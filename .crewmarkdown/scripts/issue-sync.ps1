<#
.SYNOPSIS
Pulls GitHub issues into .crewmarkdown/state/workflow.json as pending work items.
.PARAMETER Repo
GitHub repo in format owner/repo (e.g. "your-org/CrewMarkdown")
.PARAMETER Label
Filter issues by label (e.g. "feature", "bug")
.PARAMETER Token
GitHub PAT or leave blank for GH_TOKEN env var
.PARAMETER DryRun
Print what would be added without modifying state
.EXAMPLE
.\.crewmarkdown\scripts\issue-sync.ps1 -Repo "your-org/CrewMarkdown" -Label "feature"
#>

param(
  [Parameter(Mandatory)][string]$Repo,
  [string]$Label = '',
  [string]$Token = '',
  [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$StateFile = Join-Path $ProjectRoot ".crewmarkdown" "state" "workflow.json"

if (-not $Token) { $Token = $env:GH_TOKEN }
if (-not $Token) { Write-Host "ERROR: No GitHub token. Set GH_TOKEN env or pass -Token." -ForegroundColor Red; exit 1 }

$page = 1
$issues = @()
do {
  $url = "https://api.github.com/repos/$Repo/issues?state=open&per_page=100&page=$page"
  if ($Label) { $url += "&labels=$([System.Uri]::EscapeDataString($Label))" }
  $resp = Invoke-RestMethod -Uri $url -Headers @{ Authorization = "Bearer $Token" } -ErrorAction SilentlyContinue
  if (-not $resp -or $resp.Count -eq 0) { break }
  $issues += $resp
  $page++
} while ($resp.Count -eq 100)

if ($issues.Count -eq 0) { Write-Host "No open issues found." -ForegroundColor Yellow; exit 0 }

$state = Get-Content $StateFile -Raw | ConvertFrom-Json
$existing = @($state.achievedObjectives) + @($state.completedSteps | ForEach-Object { $_.objective })
$added = 0

foreach ($issue in $issues) {
  $title = "Issue: $($issue.title)"
  if ($title -in $existing) { continue }
  if ($DryRun) {
    Write-Host "[DRY-RUN] Would add: $title ($($issue.html_url))" -ForegroundColor Cyan
    $added++
    continue
  }
  $entry = @{
    step = "pending"
    objective = $title
    timestamp = (Get-Date).ToString("o")
    source = $issue.html_url
    labels = @($issue.labels | ForEach-Object { $_.name })
  }
  $state.completedSteps = @($state.completedSteps) + @($entry)
  $state.achievedObjectives = @($state.achievedObjectives) + @($title)
  $added++
}

if (-not $DryRun) {
  $state | ConvertTo-Json -Depth 10 | Out-File $StateFile -Encoding utf8
}

Write-Host "Synced $added issues from $Repo." -ForegroundColor Green
