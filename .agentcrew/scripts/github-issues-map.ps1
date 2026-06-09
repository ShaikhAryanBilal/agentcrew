<#
.SYNOPSIS
Maps GitHub Issues to SDLC workflow steps.
Reads open issues with specific labels and maps them to workflow steps.

.LABEL MAPPING
bug â†’ qa/bugs
enhancement â†’ req/gather
feature â†’ req/gather
documentation â†’ dev/impl
security â†’ qa/pentest
deployment â†’ deploy/plan
hotfix â†’ ops/hotfix
test â†’ qa/plan
design â†’ design/arch
epic â†’ 00-router.md (manual routing)

.PARAMETER Repo
GitHub repo in format "owner/repo"
.PARAMETER Label
Filter by label (optional)
.PARAMETER OutputDir
Where to write the mapping report (default: .agentcrew/log)
#>

param(
  [Parameter(Mandatory)][string]$Repo,
  [string]$Label = '',
  [string]$OutputDir = ''
)

if (-not $OutputDir) {
  $ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
  $OutputDir = Join-Path $ProjectRoot ".team" "log"
}

$labelMap = @{
  'bug'           = 'qa/bugs'
  'enhancement'   = 'req/gather'
  'feature'       = 'req/gather'
  'documentation' = 'dev/impl'
  'security'      = 'qa/pentest'
  'deployment'    = 'deploy/plan'
  'hotfix'        = 'ops/hotfix'
  'test'          = 'qa/plan'
  'design'        = 'design/arch'
  'data'          = 'obj/data-pipeline'
  'ml'            = 'obj/ml-pipeline'
  'mobile'        = 'obj/mobile-feature'
  'adr'           = 'adr/propose'
  'postmortem'    = 'postmortem'
}

Write-Host "Fetching issues from $Repo ..." -ForegroundColor Cyan

$issuesUrl = "https://api.github.com/repos/$Repo/issues?state=open&per_page=100"
if ($Label) { $issuesUrl += "&labels=$Label" }

try {
  $issues = Invoke-RestMethod -Uri $issuesUrl -Headers @{ Accept = "application/vnd.github.v3+json" } -ErrorAction Stop
} catch {
  Write-Host "Failed to fetch issues: $_" -ForegroundColor Red
  Write-Host "Make sure the repo is public or set GITHUB_TOKEN env var" -ForegroundColor Yellow
  exit 1
}

$mapped = @()
$unmapped = @()

foreach ($issue in $issues) {
  $matchedStep = $null
  foreach ($label in $issue.labels) {
    $labelName = $label.name.ToLower()
    if ($labelMap.ContainsKey($labelName)) {
      $matchedStep = $labelMap[$labelName]
      break
    }
  }
  if ($matchedStep) {
    $mapped += [PSCustomObject]@{
      Issue    = "#$($issue.number)"
      Title    = $issue.title
      Url      = $issue.html_url
      Step     = $matchedStep
    }
  } else {
    $unmapped += [PSCustomObject]@{
      Issue    = "#$($issue.number)"
      Title    = $issue.title
      Url      = $issue.html_url
      Labels   = ($issue.labels | ForEach-Object { $_.name }) -join ', '
    }
  }
}

$timestamp = Get-Date -Format "yyyyMMddTHHmmss"
$reportFile = Join-Path $OutputDir "github-issues-$timestamp.md"

$content = @"
# GitHub Issues â†’ AgentCrew Map

**Repo:** $Repo
**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm')
**Total open issues:** $($issues.Count)
**Mapped:** $($mapped.Count)
**Unmapped:** $($unmapped.Count)

---

## Mapped Issues

| Issue | Title | Workflow Step |
|-------|-------|--------------|
$($mapped | ForEach-Object { "| [$($_.Issue)]($($_.Url)) | $($_.Title) | $($_.Step) |" } | Out-String)

---

## Unmapped Issues (no matching label)

| Issue | Title | Labels |
|-------|-------|--------|
$($unmapped | ForEach-Object { "| [$($_.Issue)]($($_.Url)) | $($_.Title) | $($_.Labels) |" } | Out-String)

---

## Label â†’ Step Mapping Reference

| Label | Workflow Step |
|-------|--------------|
$($labelMap.GetEnumerator() | Sort-Object Key | ForEach-Object { "| $($_.Key) | $($_.Value) |" } | Out-String)

## Instructions

Agent: For each mapped issue, route to the corresponding workflow step.
For unmapped issues, ask "Which SDLC phase does this belong to?"
"@

$content | Out-File $reportFile -Encoding utf8

Write-Host "Report written: $reportFile" -ForegroundColor Green
Write-Host "  Mapped: $($mapped.Count), Unmapped: $($unmapped.Count)"

return @{ Mapped=$mapped; Unmapped=$unmapped; Report=$reportFile }
