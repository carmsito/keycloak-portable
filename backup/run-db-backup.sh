#!/usr/bin/env bash
set -euo pipefail

# --- Base config (mirrors run-db-backup) ---
WORKDIR="/backup"
REPO_SLUG="carmsito/keycloak-portable.git"
BRANCH="main"

# Repo-tracked paths (RESPECT structure: backup/seed/…)
SEED_PATH="backup/seed/keycloak_seed.sql.gz"
LAST_SYNC_PATH="backup/seed/.last_seed_sync.txt"

# Absolute paths inside the worktree
SEED_FILE="$WORKDIR/$SEED_PATH"
LAST_SYNC_FILE="$WORKDIR/$LAST_SYNC_PATH"

# Local source produced by another process (NOT tracked)
LATEST_FILE="$WORKDIR/keycloak_latest.sql.gz"

# --- Token check ---
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "ERROR: GITHUB_TOKEN n'est pas défini dans l'environnement." >&2
  exit 1
fi

repo_url() { echo "https://carmsi_docker:${GITHUB_TOKEN}@github.com/${REPO_SLUG}"; }

# --- Git bootstrap (one-time), identical layout/sparse as run-db-backup ---
bootstrap_git() {
  mkdir -p "$WORKDIR"
  git config --global --add safe.directory "$WORKDIR"

  if [[ ! -d "$WORKDIR/.git" ]]; then
    git -C "$WORKDIR" init
    git -C "$WORKDIR" config user.name  "carmsi_docker"
    git -C "$WORKDIR" config user.email "carmsi_docker@localhost"
    git -C "$WORKDIR" remote add origin "$(repo_url)" 2>/dev/null || true

    if git ls-remote --exit-code --heads "$(repo_url)" "$BRANCH" >/dev/null 2>&1; then
      git -C "$WORKDIR" fetch origin "$BRANCH"
      git -C "$WORKDIR" checkout -B "$BRANCH" "origin/$BRANCH"
    else
      git -C "$WORKDIR" checkout -B "$BRANCH"
      git -C "$WORKDIR" commit --allow-empty -m "init backup repo" >/dev/null 2>&1 || true
      git -C "$WORKDIR" push -u origin "$BRANCH" >/dev/null 2>&1 || true
    fi

    # Sparse: ONLY backup/seed
    git -C "$WORKDIR" sparse-checkout init --cone
    git -C "$WORKDIR" sparse-checkout set "backup/seed"
  else
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

# --- Hard sync to remote (no rebase) ---
sync_hard_to_remote() {
  git -C "$WORKDIR" rebase --abort >/dev/null 2>&1 || true
  rm -rf "$WORKDIR/.git/rebase-merge" "$WORKDIR/.git/rebase-apply" 2>/dev/null || true
  git -C "$WORKDIR" fetch origin "$BRANCH"
  git -C "$WORKDIR" reset --hard "origin/$BRANCH"
}

# --- Push with retry to avoid races ---
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

echo "seed-sync started"
mkdir -p "$(dirname "$SEED_FILE")" "$(dirname "$LAST_SYNC_FILE")"

bootstrap_git
sync_hard_to_remote

# --- Loop ---
while true; do
  if [[ -f "$LATEST_FILE" ]]; then
    needs_update=0
    if [[ ! -f "$SEED_FILE" ]]; then
      needs_update=1
    elif [[ "$LATEST_FILE" -nt "$SEED_FILE" ]]; then
      needs_update=1
    fi

    if (( needs_update == 1 )); then
      ts="$(date +%F_%H-%M-%S)"

      # Always start from remote state to avoid conflicts
      sync_hard_to_remote

      # Atomic copy into EXACT repo path backup/seed/...
      cp -f "$LATEST_FILE" "$SEED_FILE.tmp"
      mv -f "$SEED_FILE.tmp" "$SEED_FILE"

      # Update shared sync marker INSIDE backup/seed/
      date +%F_%T > "$LAST_SYNC_FILE"

      # Stage & commit (force add in case of ignores)
      git -C "$WORKDIR" add -f "$SEED_PATH" "$LAST_SYNC_PATH"
      git -C "$WORKDIR" commit -m "seed-sync: update seed and marker at $ts" || echo "Nothing to commit"

      push_with_retry || true
      echo "seed updated $ts"
      sleep 1
    fi
  fi

  sleep 10
done
