#!/usr/bin/env bash
set -euo pipefail

# --- Config de base ---
WORKDIR="/backup"
REPO_SLUG="carmsito/keycloak-portable.git"
BRANCH="main"
SEED_FILE="$WORKDIR/backup/seed/keycloak_seed.sql.gz"

# Vérif du token
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "ERROR: GITHUB_TOKEN n'est pas défini dans l'environnement." >&2
  exit 1
fi

echo "db-backup started. interval: ${BACKUP_INTERVAL_SECONDS:-3600}s"
echo "*:*:*:keycloak:keycloak" > /root/.pgpass
chmod 600 /root/.pgpass

# Attente que la DB réponde
until pg_isready -h db -U keycloak -d keycloak >/dev/null 2>&1; do
  echo "db not ready, retrying in 2s..."
  sleep 2
done

# --- Bootstrap Git ---
bootstrap_git() {
  local repo_url="https://carmsi_docker:${GITHUB_TOKEN}@github.com/${REPO_SLUG}"
  mkdir -p "$WORKDIR"
  git config --global --add safe.directory "$WORKDIR"

  if [ ! -d "$WORKDIR/.git" ]; then
    git -C "$WORKDIR" init
    git -C "$WORKDIR" config user.name  "carmsi_docker"
    git -C "$WORKDIR" config user.email "carmsi_docker@localhost"
    git -C "$WORKDIR" remote add origin "$repo_url" 2>/dev/null || \
    git -C "$WORKDIR" remote set-url origin "$repo_url"

    if git ls-remote --exit-code --heads "$repo_url" "$BRANCH" >/dev/null 2>&1; then
      git -C "$WORKDIR" fetch origin "$BRANCH"
      git -C "$WORKDIR" checkout -B "$BRANCH" "origin/$BRANCH"
    else
      git -C "$WORKDIR" checkout -B "$BRANCH"
      git -C "$WORKDIR" commit --allow-empty -m "init backup repo" >/dev/null 2>&1 || true
      git -C "$WORKDIR" push -u origin "$BRANCH" >/dev/null 2>&1 || true
    fi
  else
    local repo_url_current
    repo_url_current="$(git -C "$WORKDIR" remote get-url origin 2>/dev/null || echo "")"
    local repo_url_expected="$repo_url"
    if [[ "$repo_url_current" != "$repo_url_expected" ]]; then
      git -C "$WORKDIR" remote set-url origin "$repo_url_expected"
    fi
    git -C "$WORKDIR" fetch origin "$BRANCH" >/dev/null 2>&1 || true
  fi
}

# --- Push du backup ---
backup_and_push() {
  ts="$(date +%F_%H-%M-%S)"

  mkdir -p "$WORKDIR/backup/seed"
  pg_dump -h db -U keycloak keycloak | gzip -c > "$SEED_FILE"
  echo "backup done at $ts"

  git -C "$WORKDIR" add -f "backup/seed/keycloak_seed.sql.gz" || true
  git -C "$WORKDIR" commit -m "maj backup at $ts" || echo "Nothing to commit"

  if ! git -C "$WORKDIR" push -u origin "$BRANCH"; then
    echo "Git push failed (retrying after pull --rebase)..."
    git -C "$WORKDIR" pull --rebase origin "$BRANCH" || true
    git -C "$WORKDIR" push -u origin "$BRANCH" || echo "Git push failed again"
  fi
}

# --- Pull des mises à jour ---
pull_updates() {
  echo "Pulling latest changes from remote..."
  git -C "$WORKDIR" fetch origin "$BRANCH" >/dev/null 2>&1 || true
  git -C "$WORKDIR" pull --rebase origin "$BRANCH" || echo "Pull failed"
}

# --- Démarrage ---
bootstrap_git
backup_and_push
pull_updates

# --- Boucle ---
while true; do
  sleep "${BACKUP_INTERVAL_SECONDS:-60}"
  backup_and_push
  pull_updates
done
