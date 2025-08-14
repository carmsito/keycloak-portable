#!/usr/bin/env bash
set -euo pipefail

# --- Config de base ---
WORKDIR="/backup"
REPO_SLUG="carmsito/keycloak-portable.git"
BRANCH="main"
SEED_FILE="$WORKDIR/seed/keycloak_seed.sql.gz"

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
  cd "$WORKDIR/.."
  
  # Always reinit git to ensure clean state
  rm -rf .git
  git init
  git config --global --add safe.directory "$PWD"
  git config user.name "carmsi_docker"
  git config user.email "carmsi_docker@localhost"
  
  # Add remote
  git remote add origin "$repo_url" 2>/dev/null || \
  git remote set-url origin "$repo_url"

  # Track all root files except backup
  git add -f .everbloo.ico .gitattributes .github/workflows/auto-seed.yml \
    .gitignore README.md docker-compose.yml realm/extranet-pp-realm.json \
    start-docker.exe start-docker.ps1 2>/dev/null || true

  # Setup branch
  if git ls-remote --exit-code --heads "$repo_url" "$BRANCH" >/dev/null 2>&1; then
    git fetch origin "$BRANCH"
    git reset --hard "origin/$BRANCH" || true
  else
    git checkout -B "$BRANCH"
    git commit --allow-empty -m "init backup repo" >/dev/null 2>&1 || true
    git push -u origin "$BRANCH" >/dev/null 2>&1 || true
  fi

  cd "$WORKDIR"
}

# --- Push du backup ---
backup_and_push() {
  ts="$(date +%F_%H-%M-%S)"

  cd "$WORKDIR/.."

  # Reset any untracked changes
  git reset --hard HEAD || true
  git clean -fd || true

  # Pull latest changes
  git fetch origin "$BRANCH"
  git reset --hard "origin/$BRANCH" || true

  cd "$WORKDIR"

  # Create backup
  mkdir -p "$(dirname "$SEED_FILE")"
  pg_dump -h db -U keycloak keycloak | gzip -c > "$SEED_FILE"
  echo "backup done at $ts"

  cd "$WORKDIR/.."
  
  # Git operations
  git add -f backup/seed/keycloak_seed.sql.gz || true
  git commit -m "maj backup at $ts" || echo "Nothing to commit"
  git push -u origin "$BRANCH" || echo "Git push failed"

  cd "$WORKDIR"
}

# --- Pull des mises à jour ---
pull_updates() {
  echo "Pulling latest changes from remote..."
  cd "$WORKDIR/.."
  git fetch origin "$BRANCH" >/dev/null 2>&1 || true
  git pull --rebase origin "$BRANCH" || echo "Pull failed"
  cd "$WORKDIR"
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
