#!/usr/bin/env bash
set -euo pipefail

# --- Config de base ---
WORKDIR="/backup"
REPO_SLUG="carmsito/keycloak-portable.git"
BRANCH="main"
SEED_PATH="backup/seed/keycloak_seed.sql.gz"
SEED_FILE="$WORKDIR/$SEED_PATH"

# Vérif du token
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "ERROR: GITHUB_TOKEN n'est pas défini dans l'environnement." >&2
  exit 1
fi

echo "db-backup started. interval: ${BACKUP_INTERVAL_SECONDS:-3600}s"
echo "*:*:*:keycloak:keycloak" > /root/.pgpass
chmod 600 /root/.pgpass

# Attente DB
until pg_isready -h db -U keycloak -d keycloak >/dev/null 2>&1; do
  echo "db not ready, retrying in 2s..."
  sleep 2
done

repo_url() { echo "https://carmsi_docker:${GITHUB_TOKEN}@github.com/${REPO_SLUG}"; }

# --- Bootstrap Git (une seule fois) ---
bootstrap_git() {
  mkdir -p "$WORKDIR"
  git config --global --add safe.directory "$WORKDIR"

  if [ ! -d "$WORKDIR/.git" ]; then
    git -C "$WORKDIR" init
    git -C "$WORKDIR" config user.name  "carmsi_docker"
    git -C "$WORKDIR" config user.email "carmsi_docker@localhost"
    git -C "$WORKDIR" remote add origin "$(repo_url)" 2>/dev/null || true

    # Crée la branche locale à partir du remote si présent, sinon vierge
    if git ls-remote --exit-code --heads "$(repo_url)" "$BRANCH" >/dev/null 2>&1; then
      git -C "$WORKDIR" fetch origin "$BRANCH"
      git -C "$WORKDIR" checkout -B "$BRANCH" "origin/$BRANCH"
    else
      git -C "$WORKDIR" checkout -B "$BRANCH"
      git -C "$WORKDIR" commit --allow-empty -m "init backup repo" >/dev/null 2>&1 || true
      git -C "$WORKDIR" push -u origin "$BRANCH" >/dev/null 2>&1 || true
    fi

    # Sparse checkout : ne synchroniser que backup/seed/
    git -C "$WORKDIR" sparse-checkout init --cone
    git -C "$WORKDIR" sparse-checkout set "backup/seed"
  else
    # Assure le bon remote et active/maj sparse checkout
    local current
    current="$(git -C "$WORKDIR" remote get-url origin 2>/dev/null || echo "")"
    if [[ "$current" != "$(repo_url)" ]]; then
      git -C "$WORKDIR" remote set-url origin "$(repo_url)"
    fi
    git -C "$WORKDIR" sparse-checkout init --cone 2>/dev/null || true
    git -C "$WORKDIR" sparse-checkout set "backup/seed"
    git -C "$WORKDIR" fetch origin "$BRANCH" >/dev/null 2>&1 || true
    git -C "$WORKDIR" checkout -B "$BRANCH" "origin/$BRANCH" 2>/dev/null || true
  fi
}

# --- Sync dur sur le remote (sans rebase) ---
sync_hard_to_remote() {
  git -C "$WORKDIR" rebase --abort >/dev/null 2>&1 || true
  rm -rf "$WORKDIR/.git/rebase-merge" "$WORKDIR/.git/rebase-apply" 2>/dev/null || true
  git -C "$WORKDIR" fetch origin "$BRANCH"
  git -C "$WORKDIR" reset --hard "origin/$BRANCH"
}

# --- Push avec retry en cas de course ---
push_with_retry() {
  local max=5 i=1
  while :; do
    if git -C "$WORKDIR" push origin "HEAD:$BRANCH"; then
      return 0
    fi
    if (( i >= max )); then
      echo "Git push failed after $max attempts"
      return 1
    fi
    echo "Push rejected (race). Retrying ($i/$max)..."
    sync_hard_to_remote
    sleep 2
    ((i++))
  done
}

# --- Backup + Push (toujours basé sur l'état remote courant) ---
backup_and_push() {
  local ts
  ts="$(date +%F_%H-%M-%S)"

  # Toujours repartir de l'état du remote pour éviter les rebase
  sync_hard_to_remote

  # Génère le dump
  mkdir -p "$(dirname "$SEED_FILE")"
  pg_dump -h db -U keycloak keycloak | gzip -c > "$SEED_FILE"
  echo "backup done at $ts -> $SEED_FILE"

  # Stage + commit (forcer l'add si .gitignore)
  git -C "$WORKDIR" add -f "$SEED_PATH"
  git -C "$WORKDIR" commit -m "maj backup at $ts" || echo "Nothing to commit"

  # Push avec retry anti-course
  push_with_retry || true
}

# --- Pull (sync dur) après push si tu veux "pull aussi par intervalle" ---
pull_updates() {
  echo "Sync to latest remote state..."
  sync_hard_to_remote
}

# --- Démarrage ---
bootstrap_git
backup_and_push
pull_updates

# --- Boucle ---
while true; do
  sleep "${BACKUP_INTERVAL_SECONDS:-60}"
  # Ordre demandé : push puis pull
  backup_and_push
  pull_updates
done
