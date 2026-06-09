<#
.SYNOPSIS
Validates workflow integrity: cross-references, step IDs, file existence, JSON state.

.DESCRIPTION
Checks:
1. All Next arrow and Revert arrow links in step files point to existing files
2. Every step ID in 00-router.md has a matching .md file
3. .agentcrew/state/workflow.json is valid JSON with correct schema
4. No orphan .md files outside the step directory structure
5. All .step.json files are valid JSON
#>

$ErrorActionPreference = "Continue"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$WorkflowDir = Join-Path $ProjectRoot ".team"
$RouterFile = Join-Path $WorkflowDir "00-router.md"
$StateFile = Join-Path $WorkflowDir "state\workflow.json"

$passed = 0
$failed = 0
$warnings = 0

function Test-Check {
  param($Name, [scriptblock]$Block)
  try {
    $result = &$Block
    if ($result -eq $true) {
      Write-Host "  [PASS] $Name" -ForegroundColor Green
      $script:passed++
    } else {
      Write-Host "  [FAIL] $Name" -ForegroundColor Red
      Write-Host "    $result" -ForegroundColor Red
      $script:failed++
    }
  } catch {
    Write-Host "  [FAIL] $Name - $_" -ForegroundColor Red
    $script:failed++
  }
}

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Workflow Validation" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Project: $ProjectRoot`n"

# --- Check 1: Router step IDs map to existing files ---
Write-Host "--- Step References ---" -ForegroundColor Yellow
Test-Check -Name "Router file exists" -Block {
  if (Test-Path $RouterFile) { return $true }
  return "Missing: $RouterFile"
}

Test-Check -Name "All step IDs in router point to existing files" -Block {
  $router = Get-Content $RouterFile -Raw
  $stepRefs = [regex]::Matches($router, '\|\s*([\w/]+)\s*\|\s*(\d+-[\w-]+/\d+-[\w-]+\.md)')
  $missing = @()
  foreach ($m in $stepRefs) {
    $relPath = $m.Groups[2].Value
    $fullPath = Join-Path $WorkflowDir $relPath
    if (-not (Test-Path $fullPath)) {
      $missing += "$relPath (referenced from router)"
    }
  }
  if ($missing.Count -gt 0) { return "Missing files:`n  " + ($missing -join "`n  ") }
  return $true
}

# --- Check 2: Cross-references in step files ---
Write-Host "--- Cross-References ---" -ForegroundColor Yellow
Test-Check -Name "All Next arrow links point to existing files" -Block {
  $stepFiles = Get-ChildItem $WorkflowDir -Recurse -Filter "*.md" | Where-Object { $_.FullName -notlike "*\log\*" -and $_.FullName -notlike "*\custom\*" -and $_.FullName -notlike "*\roles\*" -and $_.FullName -notlike "*\light\*" -and $_.Name -ne "00-router.md" -and $_.Name -ne "00-roles.md" -and $_.Name -ne "README.md" }
  $missing = @()
  foreach ($file in $stepFiles) {
    $content = Get-Content $file.FullName -Raw
    $nextMatches = [regex]::Matches($content, '(?<=Next\s+\S+\s+)([\w./-]+\.md)')
    foreach ($m in $nextMatches) {
      $target = $m.Groups[1].Value
      $targetPath = Join-Path $file.Directory $target
      if (-not (Test-Path $targetPath)) {
        $rel = $file.FullName.Substring($ProjectRoot.Length+1)
        $missing += "$rel -> $target"
      }
    }
  }
  if ($missing.Count -gt 0) { return "Broken links:`n  " + ($missing -join "`n  ") }
  return $true
}

Test-Check -Name "All Revert arrow links point to existing files" -Block {
  $stepFiles = Get-ChildItem $WorkflowDir -Recurse -Filter "*.md" | Where-Object { $_.FullName -notlike "*\log\*" -and $_.FullName -notlike "*\custom\*" -and $_.FullName -notlike "*\roles\*" -and $_.FullName -notlike "*\light\*" -and $_.Name -ne "00-router.md" -and $_.Name -ne "00-roles.md" -and $_.Name -ne "README.md" }
  $missing = @()
  foreach ($file in $stepFiles) {
    $content = Get-Content $file.FullName -Raw
    $revertMatches = [regex]::Matches($content, '(?<=Revert\s+\S+\s+)([\w./-]+\.md)')
    foreach ($m in $revertMatches) {
      $target = $m.Groups[1].Value
      $targetPath = Join-Path $file.Directory $target
      if (-not (Test-Path $targetPath)) {
        $rel = $file.FullName.Substring($ProjectRoot.Length+1)
        $missing += "$rel -> $target"
      }
    }
  }
  if ($missing.Count -gt 0) { return "Broken links:`n  " + ($missing -join "`n  ") }
  return $true
}

# --- Check 3: workflow.json validity ---
Write-Host "--- State File ---" -ForegroundColor Yellow
Test-Check -Name "workflow.json is valid JSON" -Block {
  try {
    $state = Get-Content $StateFile -Raw | ConvertFrom-Json
    return $true
  } catch {
    return "Invalid JSON: $_"
  }
}

Test-Check -Name "workflow.json has correct schema" -Block {
  $state = Get-Content $StateFile -Raw | ConvertFrom-Json
  $required = @('project','currentStepId','currentPhase','startedAt','updatedAt','steps','phaseGates')
  $missingProps = @()
  foreach ($prop in $required) {
    if (-not ($state.PSObject.Properties.Name -contains $prop)) {
      $missingProps += $prop
    }
  }
  if ($missingProps.Count -gt 0) { return "Missing properties: $($missingProps -join ', ')" }
  return $true
}

# --- Check 4: .step.json files ---
Write-Host "--- Step Metadata ---" -ForegroundColor Yellow
Test-Check -Name "All .step.json files are valid JSON" -Block {
  $stepJsonFiles = Get-ChildItem $WorkflowDir -Recurse -Filter ".step.json"
  $invalid = @()
  foreach ($f in $stepJsonFiles) {
    try {
      $null = Get-Content $f.FullName -Raw | ConvertFrom-Json
    } catch {
      $rel = $f.FullName.Substring($ProjectRoot.Length+1)
      $invalid += ($rel + ": " + $($_))
    }
  }
  if ($invalid.Count -gt 0) { return "Invalid files:`n  " + ($invalid -join "`n  ") }
  return $true
}

# --- Check 5: Orphan files ---
Write-Host "--- Orphan Detection ---" -ForegroundColor Yellow
Test-Check -Name "No orphan step files outside phase dirs" -Block {
  $phaseDirs = @('01-requirements','02-design','03-development','04-qa','05-deployment','06-maintenance','adr','postmortem')
  $phaseFiles = @('supply-chain-security.md', 'sdlc.ps1')
  $allStepFiles = Get-ChildItem $WorkflowDir -Recurse -Filter "*.md" | Where-Object {
    $_.FullName -notlike "*\log\*" -and
    $_.FullName -notlike "*\custom\*" -and
    $_.FullName -notlike "*\roles\*" -and
    $_.FullName -notlike "*\scripts\*" -and
    $_.FullName -notlike "*\state\*" -and
    $_.FullName -notlike "*\light\*" -and
    $_.FullName -notlike "*\objectives\*" -and
    $_.FullName -notlike "*\config\*" -and
    $_.FullName -notlike "*\debate\*" -and
    $_.Name -ne "00-router.md" -and
    $_.Name -ne "00-roles.md" -and
    $_.Name -ne "00-objectives.md" -and
    $_.Name -ne "00-team.md"
  }
  $orphans = @()
  foreach ($f in $allStepFiles) {
    if ($f.Name -in $phaseFiles) { continue }
    $inPhase = $false
    foreach ($d in $phaseDirs) {
      if ($f.Directory.Name -eq $d) { $inPhase = $true; break }
    }
    if (-not $inPhase) {
      $rel = $f.FullName.Substring($ProjectRoot.Length+1)
      $orphans += $rel
    }
  }
  if ($orphans.Count -gt 0) { return "Orphan files:`n  " + ($orphans -join "`n  ") }
  return $true
}

# --- Summary ---
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed passed, $failed failed, $warnings warnings" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan

if ($failed -gt 0) { exit 1 }
exit 0
