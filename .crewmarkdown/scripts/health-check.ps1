<#
.SYNOPSIS
Validates .crewmarkdown/ directory structure: required files, directories, and JSON state.
.PARAMETER Quiet
Only output on failure
.EXAMPLE
.\.crewmarkdown\scripts\health-check.ps1
#>

param(
  [switch]$Quiet
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$humorPath = Join-Path $PSScriptRoot '..\config\humor-data.ps1'
if (Test-Path $humorPath) { . $humorPath }

$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$WorkflowDir = Join-Path $ProjectRoot ".crewmarkdown"

$requiredDirs = @(
  'objectives', 'roles', 'procedures', 'custom', 'state', 'scripts', 'log', 'meeting', 'debate', 'config'
)
$requiredFiles = @(
  '00-objectives.md', '00-team.md', '00-roles.md', 'state/workflow.json'
)

$passed = 0
$failed = 0

function Test-Check {
  param($Name, [scriptblock]$Block)
  try {
    $result = &$Block
    if ($result -eq $true) {
      if (-not $Quiet) { Write-Host "  [PASS] $Name" -ForegroundColor Green }
      $script:passed++
    } else {
      Write-Host "  [FAIL] $Name" -ForegroundColor Red
      if ($result) { Write-Host "    $result" -ForegroundColor Red }
      $script:failed++
    }
  } catch {
    Write-Host "  [FAIL] $Name - $_" -ForegroundColor Red
    $suffix = if (Test-Path 'function:Get-ErrorSuffix') { Get-ErrorSuffix }
    if ($suffix) { Write-Host "    $suffix" -ForegroundColor DarkYellow }
    $script:failed++
  }
}

if (-not $Quiet) {
  Write-Host "`n============================================" -ForegroundColor Cyan
  Write-Host " CrewMarkdown Health Check" -ForegroundColor Cyan
  Write-Host "============================================" -ForegroundColor Cyan
}

Test-Check -Name ".crewmarkdown directory exists" -Block { Test-Path $WorkflowDir }

foreach ($dir in $requiredDirs) {
  $path = Join-Path $WorkflowDir $dir
  Test-Check -Name "Directory: $dir" -Block { Test-Path $path }
}

foreach ($file in $requiredFiles) {
  $path = Join-Path $WorkflowDir $file
  Test-Check -Name "File: $file" -Block { Test-Path $path }
}

Test-Check -Name "workflow.json is valid JSON" -Block {
  $stateFile = Join-Path $WorkflowDir "state/workflow.json"
  try {
    $null = Get-Content $stateFile -Raw | ConvertFrom-Json
    return $true
  } catch { return "Invalid JSON: $_" }
}

if (-not $Quiet) {
  Write-Host "============================================" -ForegroundColor Cyan
  $resultColor = if ($failed -gt 0) { "Red" } else { "Green" }
  Write-Host " Results: $passed passed, $failed failed" -ForegroundColor $resultColor
  $suffix = if (Test-Path 'function:Get-ErrorSuffix' -and $failed -gt 0) { Get-ErrorSuffix }
  if ($suffix) { Write-Host " $suffix" -ForegroundColor DarkYellow }
  Write-Host "============================================" -ForegroundColor Cyan
}

if ($failed -gt 0) { exit 1 }
exit 0
