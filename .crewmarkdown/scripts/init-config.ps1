<#
.SYNOPSIS
  CrewMarkdown configuration initializer — machine and project level.
.DESCRIPTION
  Sets up CrewMarkdown configuration at machine level (~/.config/CrewMarkdown/config.json)
  and/or project level (.crewmarkdown/CrewMarkdown.json).

  Merge hierarchy: Machine config (base) → Project config (override) → Runtime (env vars)
.PARAMETER Machine
  Initialize machine-level config only.
.PARAMETER Project
  Initialize project-level config only.
.PARAMETER Force
  Overwrite existing config without prompting.
.PARAMETER Validate
  Validate existing config(s) and show merge result.
.EXAMPLE
  .\.crewmarkdown\scripts\init-config.ps1
  .\.crewmarkdown\scripts\init-config.ps1 -Machine
  .\.crewmarkdown\scripts\init-config.ps1 -Project -Force
  .\.crewmarkdown\scripts\init-config.ps1 -Validate
#>

param(
  [switch]$Machine,
  [switch]$Project,
  [switch]$Force,
  [switch]$Validate
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ConfigDir = Join-Path $RepoRoot ".crewmarkdown" "config"
$ProjectConfigPath = Join-Path $RepoRoot ".crewmarkdown" "CrewMarkdown.json"
$MachineConfigDir = Join-Path $env:USERPROFILE ".config" "CrewMarkdown"
$MachineConfigPath = Join-Path $MachineConfigDir "config.json"
$SchemaPath = Join-Path $ConfigDir "CrewMarkdown.schema.json"

function Read-YesNo {
  param([string]$Prompt)
  $response = Read-Host "$Prompt (y/n)"
  return $response -eq 'y' -or $response -eq 'Y' -or $response -eq 'yes'
}

function Write-HostColored {
  param([string]$Text, [string]$Color = "White")
  Write-Host "  $Text" -ForegroundColor $Color
}

function New-MachineConfig {
  Write-Host "`n=== Machine Config Setup (~/.config/CrewMarkdown/config.json) ===" -ForegroundColor Cyan

  if (Test-Path $MachineConfigPath -and -not $Force) {
    if (-not (Read-YesNo "Machine config exists. Overwrite?")) { return $false }
  }

  $config = @{
    user = @{
      name = Read-Host "  Your name"
      defaultRole = Read-Host "  Default role (e.g. Architect, Dev, PM)"
      preferredModel = Read-Host "  Preferred AI model (or press Enter to skip)"
    }
    tools = @{
      opencode = @{
        configPath = Read-Host "  opencode config path (or Enter for default)"
        skillPaths = @("~/.agents/skills")
      }
    }
    defaults = @{
      sdlcModel = "agile"
      logging = @{ level = "normal" }
    }
    tone = @{
      mode = "full"
      compression = $false
    }
  }

  # Ensure directory exists
  $parent = Split-Path -Parent $MachineConfigPath
  if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }

  $config | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $MachineConfigPath -Encoding UTF8
  Write-HostColored "Wrote $MachineConfigPath" "Green"
  return $true
}

function New-ProjectConfig {
  Write-Host "`n=== Project Config Setup (.crewmarkdown/CrewMarkdown.json) ===" -ForegroundColor Cyan

  if (Test-Path $ProjectConfigPath -and -not $Force) {
    if (-not (Read-YesNo "Project config exists. Overwrite?")) { return $false }
  }

  # Detect project name from directory
  $projectName = Split-Path -Leaf $RepoRoot

  Write-Host "  Detected project: $projectName" -ForegroundColor Yellow

  $sdlcModels = @("waterfall", "v-model", "spiral", "agile", "iterative", "incremental", "big-bang", "rad")
  $sdlcChoice = Read-Host "  SDLC model (default: agile) [$($sdlcModels -join ', ')]"
  if ([string]::IsNullOrWhiteSpace($sdlcChoice)) { $sdlcChoice = "agile" }

  $securityGates = Read-YesNo "  Enable security gates (SG1-SG4)? (y/n, default: y)"
  $rolesStr = Read-Host "  Roles needed (comma-separated, e.g. PM,Architect,Dev,QA,DevOps)"
  $roles = if ([string]::IsNullOrWhiteSpace($rolesStr)) { @("PM","Architect","Frontend","Backend","QA","DevOps") } else { $rolesStr -split ',' | ForEach-Object { $_.Trim() } }

  $ci = Read-Host "  CI platform (e.g. github-actions, gitlab-ci) or Enter to skip"

  $config = @{
    project = @{
      name = $projectName
      description = ""
      sdlcModel = $sdlcChoice
      securityGates = $securityGates
    }
    roles = @{
      available = $roles
      defaultSquad = @{}
    }
    custom = @{
      phaseOverrides = @{}
      procedureOverrides = @{}
    }
    logging = @{
      level = "normal"
      path = ".crewmarkdown/logs/"
    }
    integrations = @{
      ci = $ci
      ticketing = ""
      notifications = ""
    }
  }

  $config | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $ProjectConfigPath -Encoding UTF8
  Write-HostColored "Wrote $ProjectConfigPath" "Green"

  # Offer to copy AI tool configs to root
  if (Read-YesNo "  Copy AI tool configs (.crewmarkdown/config/*) to project root?")) {
    & (Join-Path $RepoRoot ".crewmarkdown" "config" "setup.ps1") -Force
  }

  return $true
}

function Test-ConfigValid {
  param([string]$Path)
  if (-not (Test-Path $Path)) { return $false }
  try {
    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $null = $content | ConvertFrom-Json
    return $true
  } catch {
    return $false
  }
}

function Show-MergeResult {
  Write-Host "`n=== Config Merge Result ===" -ForegroundColor Cyan

  $machine = $null
  $project = $null

  if (Test-Path $MachineConfigPath) {
    $machine = Get-Content -LiteralPath $MachineConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json
    Write-HostColored "Machine config: $MachineConfigPath [OK]" "Green"
  } else {
    Write-HostColored "Machine config: not found [using defaults]" "DarkYellow"
  }

  if (Test-Path $ProjectConfigPath) {
    $project = Get-Content -LiteralPath $ProjectConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json
    Write-HostColored "Project config: $ProjectConfigPath [OK]" "Green"
  } else {
    Write-HostColored "Project config: not found [SKIP]" "DarkYellow"
  }

  Write-Host "`n  --- Effective Configuration ---" -ForegroundColor Yellow
  $effective = @{}
  if ($machine) {
    if ($machine.user) { $effective["user"] = $machine.user.name }
    if ($machine.defaults) {
      $effective["sdlcModel"] = $machine.defaults.sdlcModel
      $effective["logLevel"] = $machine.defaults.logging.level
    }
    if ($machine.tone) { $effective["tone"] = $machine.tone.mode }
  }
  if ($project) {
    if ($project.project) {
      $effective["project"] = $project.project.name
      $effective["sdlcModel"] = $project.project.sdlcModel  # project overrides machine
      $effective["securityGates"] = $project.project.securityGates
    }
    $effective["roles"] = $project.roles.available -join ", "
    if ($project.integrations.ci) { $effective["ci"] = $project.integrations.ci }
  }
  if ($env:CrewMarkdown_LOG_LEVEL) { $effective["logLevel"] = $env:CrewMarkdown_LOG_LEVEL }

  foreach ($k in $effective.Keys) {
    Write-Host "    $k = $($effective[$k])" -ForegroundColor White
  }
}

function Test-Configs {
  Write-Host "`n=== Config Validation ===" -ForegroundColor Cyan

  $machineOk = Test-ConfigValid -Path $MachineConfigPath
  $projectOk = Test-ConfigValid -Path $ProjectConfigPath

  if (-not $machineOk -and -not $projectOk) {
    Write-HostColored "No configs found. Run 'init-config.ps1' first." "Red"
    return
  }

  if ($machineOk) { Write-HostColored "Machine config: valid JSON" "Green" }
  else { Write-HostColored "Machine config: missing or invalid" "Red" }

  if ($projectOk) { Write-HostColored "Project config: valid JSON" "Green" }
  else { Write-HostColored "Project config: missing or invalid" "Red" }

  if ($machineOk -or $projectOk) {
    Show-MergeResult
  }
}

# === MAIN ===

Write-Host "`n=== CrewMarkdown Config Initializer ===" -ForegroundColor Cyan

if ($Validate) {
  Test-Configs
  return
}

$doMachine = $Machine -or (-not $Project)
$doProject = $Project -or (-not $Machine)

if ($doMachine) { New-MachineConfig }
if ($doProject) { New-ProjectConfig }

Write-Host "`nDone. Run with -Validate to see merge result.`n" -ForegroundColor Cyan
