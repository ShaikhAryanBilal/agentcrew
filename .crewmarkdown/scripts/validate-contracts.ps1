<#
.SYNOPSIS
Validates role contracts: each role's needs are satisfied by another role's produces.
Checks:
1. Every 'needs.artifact' is produced by at least one role's 'produces.artifact'
2. The 'from' role(s) listed actually produce that artifact
3. No orphan produces (artifacts no role needs — warning only)
4. Every role contract has valid YAML frontmatter
.PARAMETER RolesDir
Path to roles directory (default: .crewmarkdown/roles)
.EXAMPLE
.\.crewmarkdown\scripts\validate-contracts.ps1
#>

param(
  [string]$RolesDir = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $RolesDir) { $RolesDir = Join-Path (Join-Path $ProjectRoot ".crewmarkdown") "roles" }

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
      if ($result) { Write-Host "    $result" -ForegroundColor Red }
      $script:failed++
    }
  } catch {
    Write-Host "  [FAIL] $Name - $_" -ForegroundColor Red
    $script:failed++
  }
}

function Parse-ContractFrontmatter {
  param([string]$Path)
  $content = Get-Content $Path -Raw
  if ($content -notmatch '(?s)^---\s*\r?\n(.*?)\r?\n---') { return $null }
  $yaml = $matches[1]

  # Manual YAML parsing for needs/produces (PowerShell 5.1 has no built-in YAML parser)
  $result = @{ needs = @(); produces = @() }

  $currentSection = $null
  $currentEntry = $null

  foreach ($line in $yaml -split "`n") {
    $trimmed = $line.Trim()
    if ($trimmed -eq 'needs:') { $currentSection = 'needs'; continue }
    if ($trimmed -eq 'produces:') {
      if ($currentEntry) { $result[$currentEntry.sourceSection] += $currentEntry; $currentEntry = $null }
      $currentSection = 'produces'; continue
    }

    if ($currentSection -and $trimmed -match '^- artifact:\s*(.+)') {
      if ($currentEntry) { $result[$currentEntry.sourceSection] += $currentEntry }
      $currentEntry = @{ artifact = $matches[1].Trim() }
      $currentEntry.sourceSection = $currentSection
    } elseif ($currentEntry -and $line -match '^\s+(from|to):\s*(.+)') {
      $currentEntry[$matches[1]] = $matches[2].Trim()
    }
  }
  if ($currentEntry) { $result[$currentEntry.sourceSection] += $currentEntry }

  return $result
}

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Contract Validation" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Roles Dir: $RolesDir`n"

# Load all contract frontmatter
$roleContracts = @{}
$roleFiles = Get-ChildItem $RolesDir -Recurse -Filter "contract.md"
foreach ($f in $roleFiles) {
  $roleName = $f.Directory.Name
  $parsed = Parse-ContractFrontmatter -Path $f.FullName
  if (-not $parsed) {
    Test-Check -Name "$roleName/contract.md has valid frontmatter" -Block { return $false }
    continue
  }
  $roleContracts[$roleName] = $parsed
}

Write-Host "--- Need → Produce Mapping ---" -ForegroundColor Yellow

# Build artifact → producer map
$artifactProducers = @{}
foreach ($roleName in $roleContracts.Keys) {
  $contract = $roleContracts[$roleName]
  foreach ($prod in $contract.produces) {
    $key = $prod.artifact.ToLower()
    if (-not $artifactProducers.ContainsKey($key)) { $artifactProducers[$key] = @() }
    $artifactProducers[$key] += $roleName
  }
}

# Role name aliases (contract uses shorthand, directory uses full name)
$roleAliases = @{
  'pm' = 'product-manager'
  'em' = 'engineering-manager'
  'tl' = 'tech-lead'
  'ux' = 'ux-designer'
  'fe' = 'frontend'
  'be' = 'backend'
  'qa' = 'qa'
  'ba' = 'ba'
  'ml' = 'ml-engineer'
}

# Check each role's needs
$unmetNeeds = @()
$roleNames = $roleContracts.Keys | Sort-Object
foreach ($roleName in $roleNames) {
  $contract = $roleContracts[$roleName]
  foreach ($need in $contract.needs) {
    $needKey = $need.artifact.ToLower()

    # Check if any role produces this artifact
    if (-not $artifactProducers.ContainsKey($needKey)) {
      $warnOnly = $need.from -match '(?i)^(stakeholders?|users?|repo|scribes?|minutes|archive|everyone|system|external|environment|infrastructure|credentials)$'
      if (-not $warnOnly) {
        $fuzzy = $artifactProducers.Keys | Where-Object { $_ -like "*$needKey*" -or $needKey -like "*$_*" } | Select-Object -First 3
        $hint = if ($fuzzy) { " Similar: $($fuzzy -join ', ')" } else { "" }
        $unmetNeeds += "$roleName needs '$($need.artifact)' but no role produces it.$hint"
      }
      continue
    }

    # Check if the specific 'from' role produces it
    $fromRoles = $need.from -split ',' | ForEach-Object { $_.Trim() }
    $producers = $artifactProducers[$needKey]
    $externalSources = @('stakeholders', 'stakeholder', 'users', 'user', 'repo', 'scribe', 'scribes', 'minutes', 'archive', 'everyone', 'system', 'all panelists', 'decision record')

    foreach ($fromRole in $fromRoles) {
      $normalized = $fromRole.ToLower().Trim()
      $isExternal = $false
      foreach ($ext in $externalSources) {
        if ($normalized -eq $ext -or $normalized -like "$ext,*" -or $normalized -like "*,$ext") { $isExternal = $true; break }
      }
      if ($isExternal) { continue }
      # File-path sources (starts with . or /)
      if ($normalized -match '^(\.|\/)') { continue }
      # Special patterns
      if ($normalized -match '^(pm\s*/\s*user|any\s+role|panelist|facilitator|codebase-map|00-team|00-roles|objectives/)') { continue }

      if ($roleAliases.ContainsKey($normalized)) { $normalized = $roleAliases[$normalized] }
      $matched = $producers | Where-Object { $_ -eq $normalized -or $_ -like "$normalized*" -or $normalized -like "$_*" }
      if (-not $matched) {
        $actualProducers = $producers -join ', '
        $unmetNeeds += "$roleName expects '$($need.artifact)' from $fromRole, but producers are: $actualProducers"
      }
    }
  }
}

if ($unmetNeeds.Count -eq 0) {
  Test-Check -Name "All role needs are satisfied by producers" -Block { return $true }
} else {
  Test-Check -Name "All role needs are satisfied by producers" -Block {
    return "Unmet needs:`n  " + ($unmetNeeds -join "`n  ")
  }
}

# Orphan produces (warnings only)
$allNeeds = @{}
foreach ($roleName in $roleNames) {
  $contract = $roleContracts[$roleName]
  foreach ($need in $contract.needs) {
    $allNeeds[$need.artifact.ToLower()] = $true
  }
}

$orphanProduces = @()
foreach ($roleName in $roleNames) {
  $contract = $roleContracts[$roleName]
  foreach ($prod in $contract.produces) {
    $key = $prod.artifact.ToLower()
    if (-not $allNeeds.ContainsKey($key)) {
      $orphanProduces += "$roleName produces '$($prod.artifact)' but no role needs it"
    }
  }
}

if ($orphanProduces.Count -gt 0) {
  Write-Host "  [WARN] Orphan produces ($($orphanProduces.Count)):" -ForegroundColor Yellow
  foreach ($o in $orphanProduces) { Write-Host "    $o" -ForegroundColor Yellow }
  $script:warnings += $orphanProduces.Count
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Results: $passed passed, $failed failed, $warnings warnings" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "============================================" -ForegroundColor Cyan

if ($failed -gt 0) { exit 1 }
exit 0
