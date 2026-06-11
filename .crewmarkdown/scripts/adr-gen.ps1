<#
.SYNOPSIS
Promotes meeting decisions from log entries to formal Architecture Decision Records (ADRs).
.PARAMETER SourceLog
Path to a meeting minutes/log file. If omitted, scans most recent logs.
.PARAMETER OutputDir
ADR output directory (default: .crewmarkdown/procedures/adr)
.EXAMPLE
.\.crewmarkdown\scripts\adr-gen.ps1 -SourceLog ".crewmarkdown/logs/2026/06/10/meeting-minutes.md"
#>

param(
  [string]$SourceLog = '',
  [string]$OutputDir = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$LogDir = Join-Path $ProjectRoot ".crewmarkdown" "logs"
if (-not $OutputDir) { $OutputDir = Join-Path $ProjectRoot ".crewmarkdown" "procedures" "adr" }
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

if (-not $SourceLog) {
  $latest = Get-ChildItem $LogDir -Recurse -Filter "*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if (-not $latest) { Write-Host "No log files found." -ForegroundColor Yellow; exit 0 }
  $SourceLog = $latest.FullName
}

$content = Get-Content $SourceLog -Raw
$decisions = @()

# Extract decision blocks from meeting format
$decisionBlocks = [regex]::Matches($content, "(?s)- Question:.*?(?=- Question:|$)")
foreach ($block in $decisionBlocks) {
  $question = ""
  $decision = ""
  $rationale = ""
  $alternatives = ""

  if ($block.Value -match "- Question:\s*(.+)") { $question = $matches[1].Trim() }
  if ($block.Value -match "- Decision:\s*(.+)") { $decision = $matches[1].Trim() }
  if ($block.Value -match "- Rationale:\s*(.+)") { $rationale = $matches[1].Trim() }
  if ($block.Value -match "- Alternatives Considered:\s*(.+)") { $alternatives = $matches[1].Trim() }

  if ($question -and $decision) {
    $decisions += @{ Question = $question; Decision = $decision; Rationale = $rationale; Alternatives = $alternatives }
  }
}

if ($decisions.Count -eq 0) {
  Write-Host "No decision blocks found in $SourceLog" -ForegroundColor Yellow
  exit 0
}

$adrIndex = @(Get-ChildItem $OutputDir -Filter "*.md").Count + 1
foreach ($d in $decisions) {
  $adrNum = $adrIndex.ToString("D3")
  $slug = ($d.Question -replace '[^a-z0-9\s-]', '' -replace '\s+', '-' -replace '^-|-$', '').ToLower().Substring(0, [Math]::Min(40, $d.Question.Length))
  $filename = "$adrNum-$slug.md"
  $filepath = Join-Path $OutputDir $filename

  $adrContent = @"
# ADR $adrNum: $($d.Question)

- **Date**: $(Get-Date -Format 'yyyy-MM-dd')
- **Status**: Proposed

## Context
$($d.Question)

## Decision
$($d.Decision)

## Rationale
$($d.Rationale)

## Alternatives Considered
$($d.Alternatives)

## Consequences
- (to be filled)

---
*Source: $SourceLog*
"@

  $adrContent | Out-File $filepath -Encoding utf8
  Write-Host "  ADR written: $filename" -ForegroundColor Green
  $adrIndex++
}

Write-Host "Generated $($decisions.Count) ADR(s) from $SourceLog" -ForegroundColor Cyan
