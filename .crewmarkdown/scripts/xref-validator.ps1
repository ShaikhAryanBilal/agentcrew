<#
.SYNOPSIS
Validates all cross-references: Next→, Revert→, and Markdown links to .md files across .crewmarkdown/.
.PARAMETER Path
Root path to validate (default: .crewmarkdown)
.EXAMPLE
.\.crewmarkdown\scripts\xref-validator.ps1
#>

param(
  [string]$Path = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $Path) { $Path = Join-Path $ProjectRoot ".crewmarkdown" }

$passed = 0; $failed = 0; $broken = @()

function Test-XRef {
  param($Name, $Pattern, $Label)
  $mdFiles = Get-ChildItem $Path -Recurse -Filter "*.md" | Where-Object {
    $_.FullName -notlike "*\log\*" -and $_.FullName -notlike "*\node_modules\*"
  }
  foreach ($file in $mdFiles) {
    $content = Get-Content $file.FullName -Raw
    $matches = [regex]::Matches($content, $Pattern)
    foreach ($m in $matches) {
      $target = $m.Groups[1].Value
      $targetPath = Join-Path $file.Directory $target
      if (-not (Test-Path $targetPath)) {
        $rel = $file.FullName.Substring($ProjectRoot.Length + 1)
        $broken += "$rel → $target"
      }
    }
  }
  if ($broken.Count -gt 0) {
    Write-Host "  [FAIL] $Name" -ForegroundColor Red
    foreach ($b in $broken) { Write-Host "    $b" -ForegroundColor Red }
    $script:failed++
  } else {
    Write-Host "  [PASS] $Name" -ForegroundColor Green
    $script:passed++
  }
}

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Cross-Reference Validator" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

Test-XRef -Name "Next → links" -Pattern "(?<=Next\s+\S+\s+)([\w./-]+\.md)" -Label "Next"
Test-XRef -Name "Revert → links" -Pattern "(?<=Revert\s+\S+\s+)([\w./-]+\.md)" -Label "Revert"
Test-XRef -Name "Markdown file links" -Pattern "\(([\w./-]+\.md)\)" -Label "Link"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed passed, $failed failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan
if ($failed -gt 0) { exit 1 }
