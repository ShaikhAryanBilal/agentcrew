<#
.SYNOPSIS
Diffs two workflow.json snapshots to show what changed between states.
.PARAMETER Old
Path to the older workflow.json
.PARAMETER New
Path to the newer workflow.json (default: current state)
.EXAMPLE
.\.crewmarkdown\scripts\state-diff.ps1 -Old ".crewmarkdown/state/workflow-backup.json"
#>

param(
  [Parameter(Mandatory)][string]$Old,
  [string]$New = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
if (-not $New) { $New = Join-Path $ProjectRoot ".crewmarkdown" "state" "workflow.json" }

$oldState = Get-Content $Old -Raw | ConvertFrom-Json
$newState = Get-Content $New -Raw | ConvertFrom-Json

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " State Diff" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Compare currentObjective
if ($oldState.currentObjective -ne $newState.currentObjective) {
  Write-Host "  [CHANGED] currentObjective" -ForegroundColor Yellow
  Write-Host "    Old: $($oldState.currentObjective)" -ForegroundColor Red
  Write-Host "    New: $($newState.currentObjective)" -ForegroundColor Green
}

# Compare achievedObjectives
$oldObjs = @($oldState.achievedObjectives)
$newObjs = @($newState.achievedObjectives)
$added = $newObjs | Where-Object { $_ -notin $oldObjs }
$removed = $oldObjs | Where-Object { $_ -notin $newObjs }
if ($added) { Write-Host "  [ADDED] objectives: $($added -join ', ')" -ForegroundColor Green }
if ($removed) { Write-Host "  [REMOVED] objectives: $($removed -join ', ')" -ForegroundColor Red }

# Compare completedSteps count
$oldStepCount = @($oldState.completedSteps).Count
$newStepCount = @($newState.completedSteps).Count
$diff = $newStepCount - $oldStepCount
if ($diff -ne 0) {
  Write-Host "  [CHANGED] completedSteps: $oldStepCount → $newStepCount ($(if($diff -gt 0){'+'})${diff})" -ForegroundColor Yellow
  if ($diff -gt 0) {
    $newSteps = @($newState.completedSteps) | Select-Object -Last $diff
    foreach ($s in $newSteps) {
      Write-Host "    + $($s.step): $($s.objective)" -ForegroundColor Green
    }
  }
}

# Compare artifacts
$oldArtifacts = @($oldState.artifacts)
$newArtifacts = @($newState.artifacts)
$addedArt = $newArtifacts | Where-Object { $_ -notin $oldArtifacts }
if ($addedArt) {
  Write-Host "  [ADDED] artifacts:" -ForegroundColor Green
  foreach ($a in $addedArt) { Write-Host "    + $a" -ForegroundColor Green }
}

# Compare phaseGates
$oldGates = $oldState.phaseGates
$newGates = $newState.phaseGates
$x = -join ($oldGates.PSObject.Properties | ForEach-Object { "$($_.Name):$($_.Value)" })
$y = -join ($newGates.PSObject.Properties | ForEach-Object { "$($_.Name):$($_.Value)" })
if ($x -ne $y) {
  Write-Host "  [CHANGED] phaseGates" -ForegroundColor Yellow
}

Write-Host "============================================" -ForegroundColor Cyan
