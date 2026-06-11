<#
.SYNOPSIS
Generates GitHub Actions CI workflow from .crewmarkdown/state/workflow.json.
Reads objectives/completed steps and produces a .github/workflows/CrewMarkdown-ci.yml.
.PARAMETER OutputDir
Directory to write CI file (default: .github/workflows)
.EXAMPLE
.\.crewmarkdown\scripts\ci-gen.ps1
#>

param(
  [string]$OutputDir = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$StateFile = Join-Path $ProjectRoot ".crewmarkdown" "state" "workflow.json"

if (-not $OutputDir) { $OutputDir = Join-Path $ProjectRoot ".github" "workflows" }
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

$state = Get-Content $StateFile -Raw | ConvertFrom-Json
$objectives = $state.achievedObjectives
$pending = @($objectives | Where-Object { $_ -notin ($state.completedSteps | ForEach-Object { $_.objective }) })

$ciContent = @"
name: CrewMarkdown CI
on: [push, pull_request]
jobs:
  validate-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate workflow integrity
        run: |
          chmod +x .crewmarkdown/scripts/validate-workflow.sh
          .crewmarkdown/scripts/validate-workflow.sh
"@

if ($pending.Count -gt 0) {
  $ciContent += @"

  pending-objectives:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check pending objectives
        run: |
          echo "Pending objectives:"
"@
  foreach ($o in $pending) {
    $ciContent += "          echo '  - $o'`n"
  }
}

$outPath = Join-Path $OutputDir "CrewMarkdown-ci.yml"
$ciContent | Out-File $outPath -Encoding utf8
Write-Host "CI workflow written: $outPath" -ForegroundColor Green
