
# Script to bump version and create release tag
# Usage: ./bump-version.ps1 [new_version] (e.g., ./bump-version.ps1 1.0.1)

param (
    [string]$Version
)

if (-not $Version) {
    Write-Host "Please provide a version number (e.g., 1.0.1)" -ForegroundColor Red
    exit 1
}

$PubspecPath = "pubspec.yaml"

# Update version in pubspec.yaml
$Content = Get-Content $PubspecPath
$NewContent = $Content -replace '^version: .*', "version: $Version"
$NewContent | Set-Content $PubspecPath

Write-Host "Updated pubspec.yaml to version $Version" -ForegroundColor Green

# Update version in lib/screens/home_screen.dart
$HomeScreenPath = "lib/screens/home_screen.dart"
if (Test-Path $HomeScreenPath) {
    $HomeContent = Get-Content $HomeScreenPath
    $NewHomeContent = $HomeContent -replace 'Versão: .*?"', "Versão: $Version"""
    $NewHomeContent | Set-Content $HomeScreenPath
    Write-Host "Updated home_screen.dart to version $Version" -ForegroundColor Green
    git add lib/screens/home_screen.dart
}
else {
    Write-Host "Warning: $HomeScreenPath not found. Version in UI skipped." -ForegroundColor Yellow
}

# Git operations
git add pubspec.yaml
git commit -m "chore: bump version to $Version"
git tag "v$Version"
git push origin main
git push origin "v$Version"

Write-Host "Pushed changes and tag v$Version to origin." -ForegroundColor Cyan
Write-Host "GitHub Action should trigger automatically." -ForegroundColor Cyan
