<#
.SYNOPSIS
Bumps version, generates changelog from log entries, and creates a git tag.
.PARAMETER Bump
Version segment to bump: major, minor, patch (default: patch)
.PARAMETER DryRun
Print what would happen without making changes
.EXAMPLE
.\.crewmarkdown\scripts\release-prep.ps1 -Bump minor
.\.crewmarkdown\scripts\release-prep.ps1 -Bump patch -DryRun
#>

param(
  [ValidateSet('major','minor','patch')][string]$Bump = 'patch',
  [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$LogDir = Join-Path $ProjectRoot ".crewmarkdown" "logs"

$versionFile = Join-Path $ProjectRoot "VERSION"
if (Test-Path $versionFile) {
  $version = (Get-Content $versionFile -Raw).Trim()
} else {
  $lastTag = git -C $ProjectRoot describe --tags --abbrev=0 2>$null
  if ($lastTag) {
    $version = $lastTag.TrimStart('v')
  } else {
    $version = "0.1.0"
  }
}

$parts = $version -split '\.'
switch ($Bump) {
  'major' { $parts[0] = [int]$parts[0] + 1; $parts[1] = '0'; $parts[2] = '0' }
  'minor' { $parts[1] = [int]$parts[1] + 1; $parts[2] = '0' }
  'patch' { $parts[2] = [int]$parts[2] + 1 }
}
$newVersion = $parts -join '.'

$changelog = "## v$newVersion`n`n"
if (Test-Path $LogDir) {
  $logFiles = Get-ChildItem $LogDir -Recurse -Filter "*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 20
  foreach ($f in $logFiles) {
    $rel = $f.FullName.Substring($ProjectRoot.Length + 1)
    $changelog += "- $rel`n"
  }
}

if ($DryRun) {
  Write-Host "[DRY-RUN] Version: $version -> $newVersion" -ForegroundColor Cyan
  Write-Host "[DRY-RUN] Changelog:`n$changelog" -ForegroundColor Cyan
  Write-Host "[DRY-RUN] Tag: v$newVersion" -ForegroundColor Cyan
  exit 0
}

$changelogFile = Join-Path $ProjectRoot "CHANGELOG.md"
$existing = ""
if (Test-Path $changelogFile) { $existing = Get-Content $changelogFile -Raw }
($changelog + "`n" + $existing) | Out-File $changelogFile -Encoding utf8

$newVersion | Out-File $versionFile -Encoding utf8 -Force

git -C $ProjectRoot add $versionFile $changelogFile
git -C $ProjectRoot commit -m "chore: bump to v$newVersion"
git -C $ProjectRoot tag "v$newVersion"

Write-Host "Released v$newVersion" -ForegroundColor Green
Write-Host "Tag: v$newVersion" -ForegroundColor Green
