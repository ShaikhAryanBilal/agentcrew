<#
.SYNOPSIS
  Setup AI agent config files for this project.
  Copies from .crewmarkdown/config/ to project root with correct filenames.
  Also routes to init-config.ps1 for machine-level setup.
.DESCRIPTION
  Detects which AI tools are available and copies their config.
  Skips files that already exist at root (use -Force to overwrite).
  Pass -InitMachine to also set up ~/.config/CrewMarkdown/config.json.
.PARAMETER Force
  Overwrite existing root config files without prompting.
.PARAMETER All
  Copy all configs regardless of tool detection.
.PARAMETER Tool
  Copy config for a specific tool only: opencode, cursor, claude, copilot
.PARAMETER InitMachine
  Also run machine-level config wizard (~/.config/CrewMarkdown/config.json).
.EXAMPLE
  .\.crewmarkdown\config\setup.ps1
  .\.crewmarkdown\config\setup.ps1 -Force -All
  .\.crewmarkdown\config\setup.ps1 -Tool cursor
  .\.crewmarkdown\config\setup.ps1 -InitMachine
#>

param(
  [switch]$Force,
  [switch]$All,
  [string]$Tool = "",
  [switch]$InitMachine
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ConfigDir = Join-Path $RepoRoot ".crewmarkdown" "config"

$Configs = @(
  @{ Source = "opencode.AGENTS.md";      Dest = "AGENTS.md";               Tool = "opencode" }
  @{ Source = "opencode.jsonc";          Dest = "opencode.jsonc";          Tool = "opencode" }
  @{ Source = "opencode.SKILL.md";       Dest = "SKILL.md";                Tool = "opencode" }
  @{ Source = "cursor.rules";            Dest = ".cursorrules";            Tool = "cursor" }
  @{ Source = "claude.MD";               Dest = "CLAUDE.md";               Tool = "claude" }
  @{ Source = "copilot.instructions";    Dest = "copilot-instructions.md"; Tool = "copilot" }
)

# Route to init-config if machine setup requested
if ($InitMachine) {
  $initScript = Join-Path $RepoRoot ".crewmarkdown" "scripts" "init-config.ps1"
  if (Test-Path $initScript) {
    & $initScript -Machine -Force:$Force
  }
  return
}

# Detect available tools
$DetectedTools = @()
if ($All) {
  $DetectedTools = @("opencode", "cursor", "claude", "copilot")
} elseif ($Tool) {
  $DetectedTools = @($Tool)
} else {
  if (Get-Command "opencode" -ErrorAction SilentlyContinue) { $DetectedTools += "opencode" }
  if (Test-Path (Join-Path $env:LOCALAPPDATA "Cursor")) { $DetectedTools += "cursor" }
  if (Test-Path (Join-Path $env:LOCALAPPDATA "Claude")) { $DetectedTools += "claude" }
  if (Get-Command "gh" -ErrorAction SilentlyContinue) { $DetectedTools += "copilot" }
  if ($DetectedTools.Count -eq 0) { $DetectedTools = @("opencode", "cursor", "claude", "copilot") }
}

Write-Host "`n=== CrewMarkdown — Config Setup ===" -ForegroundColor Cyan
Write-Host "Detected tools: $($DetectedTools -join ', ')`n" -ForegroundColor Yellow

$Copied = 0
$Skipped = 0

foreach ($cfg in $Configs) {
  if ($cfg.Tool -notin $DetectedTools) { continue }

  $srcPath = Join-Path $ConfigDir $cfg.Source
  $destPath = Join-Path $RepoRoot $cfg.Dest

  if (-not (Test-Path $srcPath)) {
    Write-Host "  [WARN] Source not found: $($cfg.Source)" -ForegroundColor DarkYellow
    continue
  }

  $destParent = Split-Path -Parent $destPath
  if (-not (Test-Path $destParent)) {
    New-Item -ItemType Directory -Path $destParent -Force | Out-Null
  }

  if (Test-Path $destPath -and -not $Force) {
    Write-Host "  [SKIP] $($cfg.Dest) already exists (use -Force to overwrite)" -ForegroundColor DarkGray
    $Skipped++
    continue
  }

  Copy-Item -LiteralPath $srcPath -Destination $destPath -Force
  Write-Host "  [OK]   Copied $($cfg.Source) → $($cfg.Dest)" -ForegroundColor Green
  $Copied++
}

Write-Host "`nDone: $Copied copied, $Skipped skipped.`n" -ForegroundColor Cyan
Write-Host "  opencode:   AGENTS.md + opencode.jsonc + SKILL.md" -ForegroundColor Gray
Write-Host "  Cursor:     .cursorrules" -ForegroundColor Gray
Write-Host "  Claude:     CLAUDE.md" -ForegroundColor Gray
Write-Host "  Copilot:    copilot-instructions.md" -ForegroundColor Gray

# Offer machine config setup
if (-not $All) {
  Write-Host "`nMachine config (~/.config/CrewMarkdown/config.json) not set up." -ForegroundColor DarkYellow
  Write-Host "  Run with -InitMachine to set up, or use .\.crewmarkdown\scripts\init-config.ps1" -ForegroundColor DarkGray
}
