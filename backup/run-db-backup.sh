#!/usr/bin/env bash
set -euo pipefail

echo "db-backup started. interval: ${BACKUP_INTERVAL_SECONDS:-3600}s"
echo "*:*:*:keycloak:keycloak" > /root/.pgpass
chmod 600 /root/.pgpass

# Attente active jusqu'à ce que la DB réponde
until pg_isready -h db -U keycloak -d keycloak >/dev/null 2>&1; do
  echo "db not ready, retrying in 2s..."
  sleep 2
done

backup_once() {
  ts="$(date +%F_%H-%M-%S)"
  pg_dump -h db -U keycloak keycloak > /backup/keycloak_latest.sql
  pg_dump -h db -U keycloak keycloak | gzip -c > /backup/keycloak_latest.sql.gz
#   pg_dump -h db -U keycloak keycloak | gzip -c > "/backup/keycloak_${ts}.sql.gz"
  echo "$ts" > /backup/last_backup.txt
  echo "backup done at $ts"
}

# Premier backup immédiat
backup_once

# Boucle périodique
while true; do
  sleep "${BACKUP_INTERVAL_SECONDS:-300}"
  backup_once
done
