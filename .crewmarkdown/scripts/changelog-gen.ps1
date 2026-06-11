<#
.SYNOPSIS
Generates CHANGELOG.md from .crewmarkdown/logs entries and git log.
.PARAMETER Since
Git ref or date to start from (default: last tag)
.PARAMETER Output
Output file (default: CHANGELOG.md)
.EXAMPLE
.\.crewmarkdown\scripts\changelog-gen.ps1
.\.crewmarkdown\scripts\changelog-gen.ps1 -Since "v0.1.0"
#>

param(
  [string]$Since = '',
  [string]$Output = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$LogDir = Join-Path $ProjectRoot ".crewmarkdown" "logs"
if (-not $Output) { $Output = Join-Path $ProjectRoot "CHANGELOG.md" }

if (-not $Since) {
  $Since = git -C $ProjectRoot describe --tags --abbrev=0 2>$null
  if (-not $Since) { $Since = "HEAD~10" }
}

$entries = @()

# Git log entries
$gitLog = git -C $ProjectRoot log $Since..HEAD --oneline --no-decorate 2>$null
if ($gitLog) {
  foreach ($line in $gitLog) {
    $entries += "- $line"
  }
}

# Log file entries
if (Test-Path $LogDir) {
  $logFiles = Get-ChildItem $LogDir -Recurse -Filter "*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 30
  foreach ($f in $logFiles) {
    $rel = $f.FullName.Substring($ProjectRoot.Length + 1)
    $entries += "- $rel"
  }
}

$changelog = @()
$changelog += "# Changelog"
$changelog += ""
$changelog += "## $(Get-Date -Format 'yyyy-MM-dd')"
$changelog += ""
if ($entries.Count -gt 0) {
  $changelog += $entries | Sort-Object -Unique
} else {
  $changelog += "- No changes since $Since"
}
$changelog += ""

$changelog -join "`r`n" | Out-File $Output -Encoding utf8
Write-Host "Changelog written: $Output ($($entries.Count) entries)" -ForegroundColor Green
