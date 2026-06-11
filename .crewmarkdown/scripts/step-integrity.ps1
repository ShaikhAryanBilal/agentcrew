<#
.SYNOPSIS
Verifies every file referenced in objectives, procedures, and role contracts actually exists.
.PARAMETER Path
Root .crewmarkdown path (default: .crewmarkdown)
.EXAMPLE
.\.crewmarkdown\scripts\step-integrity.ps1
#>

param(
  [string]$Path = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $Path) { $Path = Join-Path $ProjectRoot ".crewmarkdown" }

$passed = 0; $failed = 0; $missing = @()

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Step Integrity Check" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Check 1: objectives/ files referenced in 00-objectives.md
$objFile = Join-Path $Path "00-objectives.md"
$content = Get-Content $objFile -Raw
$phaseFiles = [regex]::Matches($content, "(?<=file:\s+)([\w./-]+\.md)")
foreach ($m in $phaseFiles) {
  $ref = $m.Groups[1].Value
  $fullPath = Join-Path $Path $ref
  if (-not (Test-Path $fullPath)) { $missing += "$ref (referenced in 00-objectives.md)" }
}

# Check 2: role contracts/workflows referenced in 00-team.md
$teamFile = Join-Path $Path "00-team.md"
$teamContent = Get-Content $teamFile -Raw
$roleRefs = [regex]::Matches($teamContent, "(?<=contract:|workflow:)\s*([\w./-]+\.md)")
foreach ($m in $roleRefs) {
  $ref = $m.Groups[1].Value.Trim()
  $fullPath = Join-Path $Path $ref
  if (-not (Test-Path $fullPath)) { $missing += "$ref (referenced in 00-team.md)" }
}

# Check 3: procedure files referenced in 00-roles.md
$rolesFile = Join-Path $Path "00-roles.md"
$rolesContent = Get-Content $rolesFile -Raw
$procRefs = [regex]::Matches($rolesContent, "(?<=procedures/)[\w./-]+\.md")
foreach ($m in $procRefs) {
  $ref = "procedures/$($m.Groups[0].Value)"
  $fullPath = Join-Path $Path $ref
  if (-not (Test-Path $fullPath)) { $missing += "$ref (referenced in 00-roles.md)" }
}

if ($missing.Count -gt 0) {
  Write-Host "  [FAIL] Missing referenced files:" -ForegroundColor Red
  foreach ($m in $missing) { Write-Host "    $m" -ForegroundColor Red }
  $failed = $missing.Count
} else {
  Write-Host "  [PASS] All referenced files exist" -ForegroundColor Green
  $passed = 1
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed passed, $failed failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan
if ($failed -gt 0) { exit 1 }
