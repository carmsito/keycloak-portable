# <#ps2exe>
# #title: Everbloo Keycloak Stack
# #product: Keycloak Stack Starter
# #company: Everbloo
# #description: Lance le stack Docker (Keycloak + Postgres) et gère --import-realm au 1er run.
# #fileversion: 1.0.0.0
# #productversion: 1.0.0.0
# #requireadmin: true
# #x64: true
# #noconsole: true
# #icon: .\everbloo.ico   # (optionnel) commente/retire si tu n'as pas d'icône
# </#ps2exe>

# start-docker.ps1
[Console]::OutputEncoding = [Text.Encoding]::UTF8
Write-Host "Lancement du stack Docker..."
Set-Location -Path $PSScriptRoot

# --- Helpers pour (dé)commenter --import-realm ---
function Set-ImportRealmState {
  param([string]$ComposePath, [bool]$Enable)
  if (-not (Test-Path $ComposePath)) { throw "docker-compose.yml introuvable: $ComposePath" }
  $text   = Get-Content $ComposePath -Raw -Encoding UTF8
  $before = $text

  if ($Enable) {
    # Décommenter si commenté
    $text = [regex]::Replace($text,'^(?<i>\s*)#\s*-\s*--import-realm(?<r>.*)$','${i}- --import-realm${r}','Multiline')
    # Ajouter après - start-dev s'il n'existe pas
    if ($text -notmatch '(?m)^\s*-\s*--import-realm\b') {
      $text = [regex]::Replace($text,'(^\s*-\s*start-dev\s*$)','$1'+"`r`n"+'      - --import-realm','Multiline')
    }
  } else {
    # Re-commenter
    $text = [regex]::Replace($text,'^(?<i>\s*)-\s*--import-realm(?<r>.*)$','${i}# - --import-realm${r}','Multiline')
  }

  if ($text -ne $before) { Set-Content -Path $ComposePath -Value $text -Encoding UTF8 }
}

# --- Préchecks ---
if (-not (Test-Path ".\docker-compose.yml")) { Write-Error "docker-compose.yml introuvable"; exit 1 }
docker info *>$null; if ($LASTEXITCODE -ne 0) { Write-Error "Docker Desktop n'est pas lancé"; exit 1 }

$composePath = Join-Path $PSScriptRoot 'docker-compose.yml'

# --- Détection volume (marche avec 'kc_db' ou 'xxx_kc_db') ---
$VolumeSuffix   = 'kc_db'
$allVolumes     = docker volume ls --format '{{.Name}}'
$volumeName     = $allVolumes | Where-Object { $_ -match "(^|[_-])$([regex]::Escape($VolumeSuffix))$" } | Select-Object -First 1
$firstRun       = -not $volumeName

if ($firstRun) {
  Write-Host "Volume '$VolumeSuffix' ABSENT : premier démarrage -> on active --import-realm."
  Set-ImportRealmState -ComposePath $composePath -Enable:$true
} else {
  Write-Host "Volume détecté: $volumeName -> démarrage normal (pas d'import)."
  Set-ImportRealmState -ComposePath $composePath -Enable:$false
}

# --- Démarrage du stack ---
docker compose up -d
if ($LASTEXITCODE -ne 0) { Write-Error "Erreur au lancement du stack"; exit 1 }

# --- Trouver le conteneur DB automatiquement (exclut *backup*) ---
$DbContainer = docker ps --format '{{.Names}}' |
  Where-Object { $_ -match '^keycloak-db' -and $_ -notmatch 'backup' } |
  Select-Object -First 1
if (-not $DbContainer) { $DbContainer = 'keycloak-db' }

# --- Attente DB healthy ---
$maxWait = 120; $elapsed = 0; $step = 2
Write-Host "Attente que la DB soit healthy ($DbContainer)..."
while ($true) {
  $status = docker inspect --format '{{ .State.Health.Status }}' $DbContainer 2>$null
  if ($status -eq "healthy") { break }
  if ($elapsed -ge $maxWait) { Write-Error "DB non healthy après $maxWait s (statut: $status)"; exit 1 }
  Start-Sleep -Seconds $step; $elapsed += $step
}

# --- Si 1er run : laisser Keycloak finir puis re-commenter --import-realm ---
if ($firstRun) {
  Start-Sleep -Seconds 5
  Write-Host "Premier démarrage terminé -> on re-désactive --import-realm dans docker-compose.yml."
  Set-ImportRealmState -ComposePath $composePath -Enable:$false
}

# --- Ping Keycloak + infos utiles ---
$BaseUrl = "http://localhost:8080"
$Realm   = "extranet-pp"
try {
  $oidc = Invoke-RestMethod -Uri "$BaseUrl/realms/$Realm/.well-known/openid-configuration" -TimeoutSec 10
  $pub  = (Invoke-RestMethod -Uri "$BaseUrl/realms/$Realm" -TimeoutSec 10).public_key
  Write-Host "Keycloak OK -> issuer: $($oidc.issuer)"
  Write-Host "Public key ($Realm): $pub"
  Write-Host "✅ Stack prêt."
} catch {
  Write-Warning "Keycloak n'est peut-être pas encore prêt. Réessaie dans quelques secondes."
}
