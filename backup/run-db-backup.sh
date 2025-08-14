#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# --- Configuration ---
REPO_DIR="${REPO_DIR:-/repo}"                 # Dossier local où sera initialisé le repo Git
BACKUP_DIR="${BACKUP_DIR:-$REPO_DIR/backup}"  # Dossier où seront stockées les sauvegardes
BRANCH="${BRANCH:-main}"
SEED_FILE="${SEED_FILE:-$BACKUP_DIR/seed/keycloak_seed.sql.gz}"

# Fonction de garde-fou pour vérifier que le chemin est sûr
assert_safe_dir() {
  local p="$1"
  if [[ -z "$p" || "$p" == "/" || "$p" != /* ]]; then
    echo "Chemin dangereux: $p" >&2
    exit 1
  fi
}

# Vérification des chemins critiques
assert_safe_dir "$REPO_DIR"
assert_safe_dir "$BACKUP_DIR"
assert_safe_dir "$(dirname "$SEED_FILE")"

# Vérification du token GitHub
: "${GITHUB_TOKEN:?La variable GITHUB_TOKEN doit être définie}"

echo "db-backup started. interval: ${BACKUP_INTERVAL_SECONDS:-3600}s"

# Fichier .pgpass pour éviter de taper le mot de passe
echo "*:*:*:keycloak:keycloak" > /root/.pgpass
chmod 600 /root/.pgpass

# Attente que la base de données soit prête
until pg_isready -h db -U keycloak -d keycloak >/dev/null 2>&1; do
  echo "db not ready, retrying in 2s..."
  sleep 2
done

# Initialisation du repo Git dans REPO_DIR
bootstrap_git() {
  local repo_url="https://carmsi_docker:${GITHUB_TOKEN}@github.com/carmsito/keycloak-portable.git"

  mkdir -p "$REPO_DIR"
  cd "$REPO_DIR"

  if [ ! -d .git ]; then
    git init
    git remote add origin "$repo_url" || git remote set-url origin "$repo_url"
    git fetch --depth=1 origin "$BRANCH" || true
    if git rev-parse --verify "origin/$BRANCH" >/dev/null 2>&1; then
      git checkout -B "$BRANCH" "origin/$BRANCH"
    else
      git checkout -B "$BRANCH"
      git commit --allow-empty -m "init backup repo" >/dev/null 2>&1 || true
      git push -u origin "$BRANCH" >/dev/null 2>&1 || true
    fi
  else
    git remote set-url origin "$repo_url"
    git fetch origin "$BRANCH" || true
    git checkout -B "$BRANCH" "origin/$BRANCH" 2>/dev/null || git checkout -B "$BRANCH"
  fi
}

# Création et push du backup
backup_and_push() {
  local ts
  ts="$(date +%F_%H-%M-%S)"

  mkdir -p "$(dirname "$SEED_FILE")"

  # Dump PostgreSQL compressé
  pg_dump -h db -U keycloak keycloak | gzip -c > "$SEED_FILE"
  echo "backup done at $ts -> $SEED_FILE"

  cd "$REPO_DIR"
  git add -f "$SEED_FILE"
  if git commit -m "maj backup at $ts" >/dev/null 2>&1; then
    git push -u origin "$BRANCH" || echo "Git push failed"
  else
    echo "Nothing to commit"
  fi
}

# Récupération des mises à jour du repo
pull_updates() {
  cd "$REPO_DIR"
  git fetch origin "$BRANCH" >/dev/null 2>&1 || true
  git pull --rebase origin "$BRANCH" || echo "Pull failed"
}

# --- Exécution ---
bootstrap_git
backup_and_push
pull_updates

# Boucle infinie pour backups réguliers
while true; do
  sleep "${BACKUP_INTERVAL_SECONDS:-60}"
  backup_and_push
  pull_updates
done
