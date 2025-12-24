
# Script to bump version and create release tag
# Usage: ./bump-version.ps1 [new_version] (e.g., ./bump-version.ps1 1.0.1)
#
# Note: The app version is read dynamically from pubspec.yaml using package_info_plus,
# so we only need to update pubspec.yaml - all screens will show the new version automatically.

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
Write-Host "Note: All app screens will automatically display the new version." -ForegroundColor Gray

# Git operations
git add pubspec.yaml
git commit -m "chore: bump version to $Version"
git tag "v$Version"
git push origin main
git push origin "v$Version"

Write-Host ""
Write-Host "Pushed changes and tag v$Version to origin." -ForegroundColor Cyan
Write-Host "GitHub Action should trigger automatically." -ForegroundColor Cyan

