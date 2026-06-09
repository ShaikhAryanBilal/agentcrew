<#
.SYNOPSIS
Writes workflow step log to date-hierarchy path: .agentcrew/log/<year>/<month>/<day>/<index>-<stepId>-<timestamp>.md
.PARAMETER StepId
Step identifier (e.g. "req/gather", "dev/impl")
.PARAMETER Status
completed | failed | reverted
.PARAMETER InputText
What was used as input
.PARAMETER OutputText
Artifacts produced
.PARAMETER Notes
Anything notable during execution
.EXAMPLE
.\write-workflow-log.ps1 -StepId "req/gather" -Status "completed" -InputText "User request: build auth" -OutputText "PRD drafted"
#>

param(
  [Parameter(Mandatory)][string]$StepId,
  [ValidateSet('completed','failed','reverted')][string]$Status = 'completed',
  [string]$InputText = '',
  [string]$OutputText = '',
  [string]$Notes = ''
)

$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$LogsRoot = Join-Path $ProjectRoot ".team" "log"

$now = Get-Date
$year = $now.ToString('yyyy')
$month = $now.ToString('MM')
$day = $now.ToString('dd')
$timestamp = $now.ToString('yyyyMMddTHHmmss')

$DayDir = Join-Path $LogsRoot $year $month $day
if (-not (Test-Path $DayDir)) {
  New-Item -ItemType Directory -Path $DayDir -Force | Out-Null
}

$existing = @(Get-ChildItem -Path $DayDir -Filter '*.md' -File)
$index = $existing.Count + 1

$safeStepId = $StepId -replace '[\\/:]', '-'
$filename = "$($index.ToString('D4'))-$safeStepId-$timestamp.md"
$filePath = Join-Path $DayDir $filename

$content = @"
# Step: $StepId
**Started:** $timestamp
**Completed:** $timestamp
**Status:** $Status

## Input
$InputText

## Output
$OutputText

## Notes
$Notes
"@

$content | Out-File -FilePath $filePath -Encoding utf8

Write-Host "Log written: $filePath" -ForegroundColor Green

return @{
  Path = $filePath
  Index = $index
  StepId = $StepId
  Timestamp = $timestamp
}
