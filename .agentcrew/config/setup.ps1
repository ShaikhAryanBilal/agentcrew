<#
.SYNOPSIS
  Setup AI agent config files for this project.
  Copies from .agentcrew/config/ to project root with correct filenames.
.DESCRIPTION
  Detects which AI tools are available and copies their config.
  Skips files that already exist at root (use -Force to overwrite).
.PARAMETER Force
  Overwrite existing root config files without prompting.
.PARAMETER All
  Copy all configs regardless of tool detection.
.PARAMETER Tool
  Copy config for a specific tool only: opencode, cursor, claude, copilot
.EXAMPLE
  .\.agentcrew\config\setup.ps1
  .\.agentcrew\config\setup.ps1 -Force -All
  .\.agentcrew\config\setup.ps1 -Tool cursor
#>

param(
  [switch]$Force,
  [switch]$All,
  [string]$Tool = ""
)

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ConfigDir = Join-Path $RepoRoot ".team" "config"

$Configs = @(
  @{ Source = "opencode.AGENTS.md";     Dest = "AGENTS.md";              Tool = "opencode" }
  @{ Source = "opencode.opencode.jsonc"; Dest = "opencode.jsonc";        Tool = "opencode" }
  @{ Source = "opencode.SKILL.md";      Dest = "SKILL.md";               Tool = "opencode" }
  @{ Source = "cursor.rules";           Dest = ".cursorrules";           Tool = "cursor" }
  @{ Source = "claude.MD";              Dest = "CLAUDE.md";              Tool = "claude" }
  @{ Source = "copilot.instructions";   Dest = "copilot-instructions.md"; Tool = "copilot" }
)

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

Write-Host "`n=== AgentCrew — Config Setup ===" -ForegroundColor Cyan
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

  # Ensure parent dir exists (e.g., .github/)
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
Write-Host "To direct your AI tool to the team config:" -ForegroundColor White
Write-Host "  opencode:   AGENTS.md + opencode.jsonc + SKILL.md" -ForegroundColor Gray
Write-Host "  Cursor:     .cursorrules" -ForegroundColor Gray
Write-Host "  Claude:     CLAUDE.md" -ForegroundColor Gray
Write-Host "  Copilot:    copilot-instructions.md" -ForegroundColor Gray
