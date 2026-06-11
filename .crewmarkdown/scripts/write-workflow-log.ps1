<#
.SYNOPSIS
Writes workflow step log to request-hierarchy path: .crewmarkdown/logs/<year>/<month>/<day>/<time>/<chatName>-[<time>]/<stepId>.md
.PARAMETER StepId
Step identifier (e.g. "req/gather", "dev/impl")
.PARAMETER ChatName
Request slug derived from user request (kebab-case, 5 words max). Default: "request"
.PARAMETER Status
completed | failed | reverted
.PARAMETER InputText
What was used as input
.PARAMETER OutputText
Artifacts produced
.PARAMETER Notes
Anything notable during execution
.EXAMPLE
.\write-workflow-log.ps1 -StepId "req/gather" -ChatName "build-login" -Status "completed" -InputText "User request: build auth" -OutputText "PRD drafted"
#>

param(
  [Parameter(Mandatory)][string]$StepId,
  [string]$ChatName = 'request',
  [ValidateSet('completed','failed','reverted')][string]$Status = 'completed',
  [string]$InputText = '',
  [string]$OutputText = '',
  [string]$Notes = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$LogsRoot = Join-Path $ProjectRoot ".crewmarkdown" "logs"
$StateFile = Join-Path $ProjectRoot ".crewmarkdown" "state" "workflow.json"
$SchemaFile = Join-Path $ProjectRoot ".crewmarkdown" "state" "schema-workflow.json"

# Guard: validate workflow.json schema before writing
if (Test-Path $StateFile -and Test-Path $SchemaFile) {
  try {
    $state = Get-Content $StateFile -Raw | ConvertFrom-Json
    $schema = Get-Content $SchemaFile -Raw | ConvertFrom-Json
    foreach ($prop in $schema.required) {
      if (-not ($state.PSObject.Properties.Name -contains $prop)) {
        throw "Schema validation failed: missing required property '$prop' in $StateFile"
      }
    }
  } catch {
    Write-Host "  [WARN] State validation skipped: $_" -ForegroundColor Yellow
  }
}

$now = Get-Date
$year = $now.ToString('yyyy')
$month = $now.ToString('MM')
$day = $now.ToString('dd')
$time = $now.ToString('HHmmss')
$timestamp = $now.ToString('yyyyMMddTHHmmss')

$safeChatName = $ChatName -replace '[^a-z0-9-]', ''
$RequestDir = Join-Path $LogsRoot $year $month $day $time "$safeChatName-[$time]"
if (-not (Test-Path $RequestDir)) {
  New-Item -ItemType Directory -Path $RequestDir -Force | Out-Null
}

$safeStepId = $StepId -replace '[\\/:]', '-'
$filename = "$safeStepId-$timestamp.md"
$filePath = Join-Path $RequestDir $filename

$content = @"
# Step: $StepId
**Request:** $safeChatName
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
  StepId = $StepId
  ChatName = $safeChatName
  Timestamp = $timestamp
}
