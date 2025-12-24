# run-dev.ps1 - Script para rodar o app em desenvolvimento com variáveis do .env
# Uso: .\run-dev.ps1 [dispositivo]
# Exemplo: .\run-dev.ps1 -d chrome

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

Write-Host "Iniciando app com credenciais do .env..." -ForegroundColor Green

$flutterArgs = @(
    "run",
    "--dart-define=SUPABASE_URL=$supabaseUrl",
    "--dart-define=SUPABASE_ANON_KEY=$supabaseKey"
)

if ($Device) {
    $flutterArgs += "-d", $Device
}

& flutter @flutterArgs
