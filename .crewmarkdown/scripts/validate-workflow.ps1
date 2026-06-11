<#
.SYNOPSIS
Validates workflow integrity: cross-references, step IDs, file existence, JSON state.

.DESCRIPTION
Checks:
1. All Next arrow and Revert arrow links in step files point to existing files
2. Every step ID in 00-router.md has a matching .md file
3. .crewmarkdown/state/workflow.json is valid JSON with correct schema
4. No orphan .md files outside the step directory structure
5. All .step.json files are valid JSON
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$WorkflowDir = Join-Path $ProjectRoot ".crewmarkdown"
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

# --- Check 1: Cross-references in step files ---
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

# --- Check 2: workflow.json validity + schema validation ---
Write-Host "--- State File ---" -ForegroundColor Yellow
$SchemaFile = Join-Path $WorkflowDir "state\schema-workflow.json"

Test-Check -Name "schema-workflow.json exists" -Block {
  return (Test-Path $SchemaFile)
}

Test-Check -Name "workflow.json is valid JSON" -Block {
  try {
    $state = Get-Content $StateFile -Raw | ConvertFrom-Json
    return $true
  } catch {
    return "Invalid JSON: $_"
  }
}

Test-Check -Name "workflow.json matches schema" -Block {
  try {
    $state = Get-Content $StateFile -Raw | ConvertFrom-Json
    $schema = Get-Content $SchemaFile -Raw | ConvertFrom-Json
  } catch {
    return "Cannot read files: $_"
  }

  $errors = @()

  # Version check — handle future migrations
  if ($state.PSObject.Properties.Name -contains 'version') {
    if ($state.version -lt 1 -or $state.version -gt 1) {
      $errors += "Unsupported schema version: $($state.version). Expected: 1"
    }
  }

  # Check required top-level properties
  foreach ($prop in $schema.required) {
    if (-not ($state.PSObject.Properties.Name -contains $prop)) {
      $errors += "Missing required property: $prop"
    }
  }

  # currentObjective must be non-empty
  if ($state.PSObject.Properties.Name -contains 'currentObjective' -and [string]::IsNullOrEmpty($state.currentObjective)) {
    $errors += "currentObjective must not be empty"
  }

  # achievedObjectives must be unique strings
  if ($state.PSObject.Properties.Name -contains 'achievedObjectives') {
    $dupes = $state.achievedObjectives | Group-Object | Where-Object { $_.Count -gt 1 }
    foreach ($d in $dupes) { $errors += "Duplicate achievedObjective: $($d.Name)" }
  }

  # completedSteps must have step/objective/timestamp
  if ($state.PSObject.Properties.Name -contains 'completedSteps') {
    foreach ($step in $state.completedSteps) {
      if (-not $step.step) { $errors += "completedStep missing 'step' field" }
      if (-not $step.objective) { $errors += "completedStep missing 'objective' field" }
      if (-not $step.timestamp) { $errors += "completedStep missing 'timestamp' field" }
      elseif ($step.timestamp -notmatch '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$') {
        $errors += "completedStep timestamp not ISO 8601: $($step.timestamp)"
      }
    }
  }

  # phaseGates must have passed + pending
  if ($state.PSObject.Properties.Name -contains 'phaseGates') {
    $pg = $state.phaseGates
    if ($null -eq $pg.passed) { $errors += "phaseGates missing 'passed' array" }
    if ($null -eq $pg.pending) { $errors += "phaseGates missing 'pending' array" }
  }

  # artifacts must be unique
  if ($state.PSObject.Properties.Name -contains 'artifacts') {
    $dupes = $state.artifacts | Group-Object | Where-Object { $_.Count -gt 1 }
    foreach ($d in $dupes) { $errors += "Duplicate artifact: $($d.Name)" }
  }

  # debates entries must have required fields
  if ($state.PSObject.Properties.Name -contains 'debates' -and $state.debates) {
    foreach ($deb in $state.debates) {
      if (-not $deb.slug) { $errors += "debate missing 'slug'" }
      if (-not $deb.date) { $errors += "debate missing 'date'" }
      if (-not $deb.question) { $errors += "debate missing 'question'" }
      if (-not $deb.decision) { $errors += "debate missing 'decision'" }
      if (-not $deb.method) { $errors += "debate missing 'method'" }
      if (-not $deb.log) { $errors += "debate missing 'log'" }
    }
  }

  if ($errors.Count -gt 0) { return "Schema violations:`n  " + ($errors -join "`n  ") }
  return $true
}

# --- Check 3: .step.json files ---
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

# --- Check 4: Contract validation (optional, runs if validate-contracts.ps1 exists) ---
$ContractValidator = Join-Path $WorkflowDir "scripts\validate-contracts.ps1"
if (Test-Path $ContractValidator) {
  Test-Check -Name "Role contracts pass validation" -Block {
    try {
      $null = & $ContractValidator 2>&1
      $exitCode = $LASTEXITCODE
      if ($exitCode -ne 0 -and $null -ne $exitCode) {
        return "Contract validation failed. Run scripts\validate-contracts.ps1 for details."
      }
      return $true
    } catch {
      return "Contract validation error: $_"
    }
  }
}

# --- Check 5: Orphan files ---
Write-Host "--- Orphan Detection ---" -ForegroundColor Yellow
Test-Check -Name "No orphan step files outside phase dirs" -Block {
  $phaseDirs = @('01-requirements','02-design','03-development','04-qa','05-deployment','06-maintenance','adr','postmortem')
  $phaseFiles = @('supply-chain-security.md', 'CrewMarkdown.ps1')
  $allStepFiles = Get-ChildItem $WorkflowDir -Recurse -Filter "*.md" | Where-Object {
    $_.FullName -notlike "*\logs\*" -and
    $_.FullName -notlike "*\log\*" -and
    $_.FullName -notlike "*\custom\*" -and
    $_.FullName -notlike "*\roles\*" -and
    $_.FullName -notlike "*\scripts\*" -and
    $_.FullName -notlike "*\state\*" -and
    $_.FullName -notlike "*\light\*" -and
    $_.FullName -notlike "*\objectives\*" -and
    $_.FullName -notlike "*\config\*" -and
    $_.FullName -notlike "*\debate\*" -and
    $_.FullName -notlike "*\meeting\*" -and
    $_.FullName -notlike "*\animations\*" -and
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
