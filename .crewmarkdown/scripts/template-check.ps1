<#
.SYNOPSIS
Validates that all procedure files follow the Need → Instructions → Done template pattern.
.PARAMETER Path
Root procedures path (default: .crewmarkdown/procedures)
.EXAMPLE
.\.crewmarkdown\scripts\template-check.ps1
#>

param(
  [string]$Path = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $Path) { $Path = Join-Path $ProjectRoot ".crewmarkdown" "procedures" }

$passed = 0; $failed = 0

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Template Structure Check" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

$procFiles = Get-ChildItem $Path -Recurse -Filter "*.md" | Where-Object { $_.Name -ne ".step.json" -and $_.Name -ne "README.md" }

foreach ($file in $procFiles) {
  $rel = $file.FullName.Substring($ProjectRoot.Length + 1)
  $content = Get-Content $file.FullName -Raw

  $hasNeed = $content -match '(?i)^##\s+Need'
  $hasInstructions = $content -match '(?i)^##\s+Instructions'
  $hasDone = $content -match '(?i)^##\s+Done'

  $missing = @()
  if (-not $hasNeed) { $missing += "Need" }
  if (-not $hasInstructions) { $missing += "Instructions" }
  if (-not $hasDone) { $missing += "Done" }

  if ($missing.Count -gt 0) {
    Write-Host "  [FAIL] $rel - missing sections: $($missing -join ', ')" -ForegroundColor Red
    $failed++
  } else {
    Write-Host "  [PASS] $rel" -ForegroundColor Green
    $passed++
  }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed clean, $failed with issues" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan
if ($failed -gt 0) { exit 1 }
