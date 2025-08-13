#!/usr/bin/env sh
set -eu

mkdir -p /backup/seed
echo "seed-sync started"

while true; do
  if [ -f /backup/keycloak_latest.sql.gz ]; then
    if [ ! -f /backup/seed/keycloak_seed.sql.gz ] || \
       [ /backup/keycloak_latest.sql.gz -nt /backup/seed/keycloak_seed.sql.gz ]; then
      cp -f /backup/keycloak_latest.sql.gz /backup/seed/keycloak_seed.sql.gz
      date +%F_%T > /backup/seed/.last_seed_sync.txt
      echo "seed updated"
    fi
  fi
  sleep 60
done
