<#
.SYNOPSIS
  Render workflow state as terminal dashboard

.DESCRIPTION
  Reads .agentcrew/state/workflow.json and displays objectives, gates, logs.
  Shows at-a-glance status of the full SDLC pipeline.

.PARAMETER Path
  Path to state JSON (default: .agentcrew/state/workflow.json)

.PARAMETER Watch
  Continuously refresh every N seconds

.EXAMPLE
  .\.agentcrew\scripts\show-state.ps1
  .\.agentcrew\scripts\show-state.ps1 -Watch 5
#>

param(
  [string]$Path = '',
  [int]$Watch = 0
)

if (-not $Path) {
  $Path = Join-Path $PSScriptRoot '..\state\workflow.json'
}
$Path = Resolve-Path $Path -ErrorAction Stop

$ESC = [char]27

$eCheck = 'GOOD'
$eHour = 'HOUR'
$eEmpty = 'EMPT'
$eBlock = 'NO'
$eDoc = 'DOC'
$eDone = 'DONE'
$ePending = '....'

function W($s, $c='') {
  if ($c) { Write-Host "$ESC[${c}m$s$ESC[0m" -NoNewline }
  else { Write-Host $s -NoNewline }
}

function WL($s='', $c='') { W "$s`n" $c }

function Get-ObjIcon($status) {
  switch ($status) {
    'completed'  { $eDone }
    'in-progress' { $eHour }
    'blocked'     { $eBlock }
    default      { $ePending }
  }
}

function Get-ObjColor($status) {
  switch ($status) {
    'completed'  { 32 }
    'in-progress' { 33 }
    'blocked'     { 31 }
    default      { 90 }
  }
}

function Get-GateIcon($s) {
  switch ($s) {
    'passed'   { $eCheck }
    'blocked'  { $eBlock }
    'skipped'  { 'SKIP' }
    default    { $eEmpty }
  }
}

function Get-GateColor($s) {
  switch ($s) { 'passed' { 32 } 'blocked' { 31 } default { 90 } }
}

do {
  Clear-Host
  $state = Get-Content $Path -Raw | ConvertFrom-Json

  WL '+----------------------------------------------------+' 36
  W '|    SDLC STATE DASHBOARD    |' 37
  WL ''
  W '|  Project: ' 37; WL $state.project 93
  W '|  Updated: ' 90; WL $state.updatedAt 90
  WL '+----------------------------------------------------+' 36

  WL ''
  WL '  Objectives:' 93

  $objectives = $state.objectives | Sort-Object id
  $allPending = $true
  $allDone = $true

  foreach ($o in $objectives) {
    $icon = Get-ObjIcon $o.status
    $color = Get-ObjColor $o.status

    if ($o.status -eq 'completed') { $allPending = $false }
    else { $allDone = $false }
    if ($o.status -ne 'pending') { $allPending = $false }

    $pct = $o.completionPercentage
    $bar = ''
    if ($pct) {
      $fill = [math]::Floor($pct / 10)
      $bar = '[' + ('#' * $fill) + ('.' * (10 - $fill)) + '] ' + $pct + '%'
    }

    W ('  ' + $icon + ' ') $color
    W ($o.id.PadRight(22)) 37
    if ($o.status -eq 'completed' -and $o.completedAt) {
      W $o.completedAt 90
    } elseif ($o.status -eq 'in-progress') {
      W $bar 33
    }
    WL ''
    W ('     Lead: ') 90; W $o.lead 37
    W ('  Squad: ') 90; WL ($o.squad -join ', ') 90

    if ($o.artifacts -and $o.artifacts.Count -gt 0) {
      W ('     Artifacts: ') 90; WL ($o.artifacts -join ', ') 32
    }
  }

  WL ''
  WL '  Security Gates:' 93
  $gates = $state.phaseGates
  $gates.PSObject.Properties | ForEach-Object {
    $name = $_.Name
    $s = $_.Value
    $icon = Get-GateIcon $s
    $color = Get-GateColor $s
    W ('  ' + $icon + ' ') $color
    W $name.PadRight(20) 37
    WL $s 90
  }

  $logDir = Join-Path $PSScriptRoot '..\log'
  if (Test-Path $logDir) {
    $logs = Get-ChildItem $logDir -Recurse -Filter '*.md' -ErrorAction SilentlyContinue |
      Sort-Object LastWriteTime -Descending |
      Select-Object -First 5
    if ($logs) {
      WL ''
      WL '  Recent Logs:' 93
      $rootLen = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path.Length + 1
      foreach ($log in $logs) {
        $rel = $log.FullName.Substring($rootLen)
        W ('  ' + $eDoc + ' ') 90; WL $rel 90
      }
    }
  }

  WL ''
  WL '+----------------------------------------------------+' 36

  if ($allDone) { WL ''; WL '  ALL OBJECTIVES COMPLETE' 32 }
  if ($allPending) { WL ''; WL '  No objectives started yet.' 90 }

  if ($Watch -gt 0) { Start-Sleep -Seconds $Watch }
} while ($Watch -gt 0)
