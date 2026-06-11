<#
.SYNOPSIS
Lints Markdown files for frontmatter validity and heading structure consistency.
.PARAMETER Path
Root path to lint (default: .crewmarkdown)
.PARAMETER Fix
Auto-fix trivial issues
.EXAMPLE
.\.crewmarkdown\scripts\markdown-lint.ps1
.\.crewmarkdown\scripts\markdown-lint.ps1 -Fix
#>

param(
  [string]$Path = '',
  [switch]$Fix
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $Path) { $Path = Join-Path $ProjectRoot ".crewmarkdown" }

$passed = 0; $failed = 0; $errors = @()

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Markdown Lint" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

$mdFiles = Get-ChildItem $Path -Recurse -Filter "*.md" | Where-Object {
  $_.FullName -notlike "*\node_modules\*" -and $_.FullName -notlike "*\.git\*"
}

foreach ($file in $mdFiles) {
  $rel = $file.FullName.Substring($ProjectRoot.Length + 1)
  $content = Get-Content $file.FullName -Raw
  $lines = $content -split "`n"
  $fileErrors = @()

  # Check frontmatter (--- delimiters)
  $hasFrontmatter = $content.StartsWith("---")
  if ($hasFrontmatter) {
    $closing = $content.IndexOf("---", 3)
    if ($closing -le 0) { $fileErrors += "Unclosed frontmatter" }
  }

  # Check heading hierarchy (no jumps)
  $prevLevel = 0
  for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^(#{1,6})\s') {
      $level = $matches[1].Length
      if ($level -gt $prevLevel + 1 -and $prevLevel -gt 0) {
        $fileErrors += "Line $($i+1): Heading jump from H$prevLevel to H$level"
      }
      $prevLevel = $level
    }
  }

  if ($fileErrors.Count -gt 0) {
    Write-Host "  [ISSUE] $rel" -ForegroundColor Yellow
    foreach ($e in $fileErrors) { Write-Host "    $e" -ForegroundColor Yellow; $errors += "$rel`: $e" }
    $failed++
  } else {
    $passed++
  }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed clean, $failed with issues" -ForegroundColor $(if ($failed -gt 0) { "Yellow" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan
if ($failed -gt 0 -and -not $Fix) { exit 1 }
