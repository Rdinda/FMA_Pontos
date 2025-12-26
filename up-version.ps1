
    # Script to bump version and create release tag
    # Usage: ./bump-version.ps1 [new_version] (e.g., ./bump-version.ps1 1.0.1)
    #
    # Note: The app version is read dynamically from pubspec.yaml using package_info_plus,
    # so we only need to update pubspec.yaml - all screens will show the new version automatically.

    param (
        [string]$Version,
        [ValidateSet('major', 'minor', 'patch')]
        [string]$Bump = 'patch',
        [switch]$SkipGit
    )

    $ErrorActionPreference = "Stop"

    $PubspecPath = Join-Path $PSScriptRoot "pubspec.yaml"

    if (-not (Test-Path -LiteralPath $PubspecPath)) {
        Write-Host "pubspec.yaml not found at: $PubspecPath" -ForegroundColor Red
        exit 1
    }

    $Content = Get-Content -LiteralPath $PubspecPath -Raw
    if ([string]::IsNullOrWhiteSpace($Content)) {
        Write-Host "pubspec.yaml is empty. Aborting." -ForegroundColor Red
        exit 1
    }

    $VersionPattern = '(?m)^version:\s*.*$'
    if ($Content -notmatch $VersionPattern) {
        Write-Host "Could not find 'version:' in pubspec.yaml. Aborting." -ForegroundColor Red
        exit 1
    }

    $CurrentVersionMatch = [regex]::Match($Content, '(?m)^version:\s*(.+?)\s*$')
    $CurrentVersion = $CurrentVersionMatch.Groups[1].Value.Trim()

    if (-not $Version) {
        $Base, $Build = $CurrentVersion -split '\+', 2
        $Parts = $Base -split '\.'
        if ($Parts.Count -ne 3) {
            Write-Host "Invalid version format in pubspec.yaml: $CurrentVersion" -ForegroundColor Red
            exit 1
        }

        $Major = [int]$Parts[0]
        $Minor = [int]$Parts[1]
        $Patch = [int]$Parts[2]

        switch ($Bump) {
            'major' { $Major++; $Minor = 0; $Patch = 0 }
            'minor' { $Minor++; $Patch = 0 }
            'patch' { $Patch++ }
        }

        $NewBase = "$Major.$Minor.$Patch"
        if ($Build) {
            if ($Build -match '^\d+$') {
                $NewBuild = ([int]$Build) + 1
                $Version = "$NewBase+$NewBuild"
            } else {
                $Version = "$NewBase+$Build"
            }
        } else {
            $Version = $NewBase
        }
    }

    if ($CurrentVersion -eq $Version) {
        Write-Host "Version already set to $Version. Nothing to do." -ForegroundColor Yellow
        exit 0
    }

    $NewContent = [regex]::Replace($Content, $VersionPattern, "version: $Version", 1)

    if ($NewContent -eq $Content) {
        Write-Host "Version already set to $Version. Nothing to do." -ForegroundColor Yellow
        exit 0
    }

    Set-Content -LiteralPath $PubspecPath -Value $NewContent -Encoding utf8NoBOM

    Write-Host "Updated pubspec.yaml to version $Version" -ForegroundColor Green
    Write-Host "Note: All app screens will automatically display the new version." -ForegroundColor Gray

    if ($SkipGit) {
        Write-Host "SkipGit enabled. Not committing/tagging/pushing." -ForegroundColor Yellow
        exit 0
    }

# Git operations
    Push-Location $PSScriptRoot
    try {
        $RepoPubspecRelativePath = "pubspec.yaml"
        git diff --quiet -- $RepoPubspecRelativePath
        if ($LASTEXITCODE -eq 0) {
            Write-Host "No changes detected in pubspec.yaml. Aborting git operations." -ForegroundColor Yellow
            exit 0
        }

        git add $RepoPubspecRelativePath

        git diff --cached --quiet -- $RepoPubspecRelativePath
        if ($LASTEXITCODE -eq 0) {
            Write-Host "No staged changes in pubspec.yaml. Aborting git operations." -ForegroundColor Yellow
            exit 0
        }

        $ExistingTag = git tag -l "v$Version"
        if ($ExistingTag) {
            Write-Host "Tag v$Version already exists. Aborting." -ForegroundColor Red
            exit 1
        }

        git commit -m "tarefa: nova versao disponivel $Version"
        git tag "v$Version"
        git push origin main
        git push origin "v$Version"

        Write-Host ""
        Write-Host "Pushed changes and tag v$Version to origin." -ForegroundColor Cyan
        Write-Host "GitHub Action should trigger automatically." -ForegroundColor Cyan
    } finally {
        Pop-Location
    }
