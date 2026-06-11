<#
.SYNOPSIS
Bootstraps CrewMarkdown .crewmarkdown/ directory in a target project.
Copies the minimal required structure from source to target.
.PARAMETER Target
Target project directory (default: current directory)
.PARAMETER Source
Source .crewmarkdown directory (default: this script's .crewmarkdown)
.PARAMETER Force
Overwrite existing files
.EXAMPLE
.\.crewmarkdown\scripts\scaffold-init.ps1 -Target "C:\Projects\new-app"
#>

param(
  [string]$Target = '',
  [string]$Source = '',
  [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ScriptRoot = (Resolve-Path "$PSScriptRoot\..").Path.TrimEnd('\')
if (-not $Source) { $Source = $ScriptRoot }
if (-not $Target) { $Target = (Resolve-Path ".").Path.TrimEnd('\') }

$TargetDir = Join-Path $Target ".crewmarkdown"
New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

$copyDirs = @('objectives', 'roles', 'procedures', 'scripts', 'config', 'meeting', 'debate', 'custom', 'state')
$copyFiles = @('00-objectives.md', '00-team.md', '00-roles.md')

foreach ($dir in $copyDirs) {
  $src = Join-Path $Source $dir
  $dst = Join-Path $TargetDir $dir
  if (Test-Path $src) {
    $params = @{ Path = $src; Destination = $dst; Recurse = $true }
    if ($Force) { $params['Force'] = $true }
    Copy-Item @params -ErrorAction SilentlyContinue
    Write-Host "  Copied: $dir" -ForegroundColor Green
  }
}

foreach ($file in $copyFiles) {
  $src = Join-Path $Source $file
  $dst = Join-Path $TargetDir $file
  if (Test-Path $src) {
    $params = @{ Path = $src; Destination = $dst }
    if ($Force) { $params['Force'] = $true }
    Copy-Item @params -ErrorAction SilentlyContinue
    Write-Host "  Copied: $file" -ForegroundColor Green
  }
}

Write-Host "`nCrewMarkdown scaffolded at: $TargetDir" -ForegroundColor Cyan
Write-Host "Next: Copy AGENTS.md (opencode) or .cursorrules to project root." -ForegroundColor Yellow
