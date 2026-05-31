# run-dev.ps1 - Script para rodar o app em desenvolvimento com variáveis do .env
# Uso: .\run-dev.ps1 [dispositivo]
# Exemplo: .\run-dev.ps1 -d chrome
#
# Variáveis opcionais no .env:
#   GOOGLE_SERVER_CLIENT_ID - Web OAuth client ID (serverClientId do Google Sign-In)

param(
    [string]$Device = ""
)

# Verifica se .env existe
if (-not (Test-Path ".env")) {
    Write-Host "Erro: Arquivo .env não encontrado!" -ForegroundColor Red
    Write-Host "Copie .env.example para .env e preencha com suas credenciais." -ForegroundColor Yellow
    exit 1
}

# Carrega variáveis do .env
$envVars = @{}
Get-Content ".env" | ForEach-Object {
    if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        $envVars[$key] = $value
    }
}

$supabaseUrl = $envVars['SUPABASE_URL']
$supabaseKey = $envVars['SUPABASE_ANON_KEY']

if ([string]::IsNullOrEmpty($supabaseUrl) -or [string]::IsNullOrEmpty($supabaseKey)) {
    Write-Host "Erro: SUPABASE_URL e SUPABASE_ANON_KEY devem estar definidos no .env" -ForegroundColor Red
    exit 1
}

Write-Host "Gerando dart_defines.json a partir do .env..." -ForegroundColor Green
$dartDefines = @{
    SUPABASE_URL      = $supabaseUrl
    SUPABASE_ANON_KEY = $supabaseKey
}
$googleServerClientId = $envVars['GOOGLE_SERVER_CLIENT_ID']
if (-not [string]::IsNullOrEmpty($googleServerClientId)) {
    $dartDefines['GOOGLE_SERVER_CLIENT_ID'] = $googleServerClientId
}
$dartDefines | ConvertTo-Json | Set-Content -Path "dart_defines.json" -Encoding utf8

Write-Host "Iniciando app com credenciais do .env..." -ForegroundColor Green

$flutterArgs = @(
    "run",
    "--dart-define-from-file=dart_defines.json"
)

if ($Device) {
    $flutterArgs += "-d", $Device
}

& flutter @flutterArgs
