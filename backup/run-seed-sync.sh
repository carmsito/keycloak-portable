#!/usr/bin/env sh
set -eu

WORKDIR="/backup"
LATEST_FILE="$WORKDIR/keycloak_latest.sql.gz"
SEED_FILE="$WORKDIR/seed/keycloak_seed.sql.gz"

mkdir -p "$(dirname "$SEED_FILE")"
echo "seed-sync started"

while true; do
  if [ -f "$LATEST_FILE" ]; then
    if [ ! -f "$SEED_FILE" ] || [ "$LATEST_FILE" -nt "$SEED_FILE" ]; then
      # Create a temporary file to ensure atomic copy
      cp -f "$LATEST_FILE" "$SEED_FILE.tmp"
      mv -f "$SEED_FILE.tmp" "$SEED_FILE"
      date +%F_%T > "$WORKDIR/seed/.last_seed_sync.txt"
      echo "seed updated $(date +%F_%H-%M-%S)"
      # Give backup script time to detect the change
      sleep 1
    fi
  fi
  sleep 10
done
