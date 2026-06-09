<#
.SYNOPSIS
  Retro RPG Party Screen — gamified squad status display for AgentCrew

.DESCRIPTION
  Shows an animated terminal party screen when AI squads assemble.
  Uses box-drawing characters + ANSI colors for retro RPG feel.
  Each squad member: role icon + name + animated HP-style bar + status.

.PARAMETER Objective
  Name of the current objective (e.g. "Design Solution")

.PARAMETER Squad
  Array of role names in the squad

.PARAMETER Timeout
  Seconds to auto-exit (0 = infinite, Ctrl+C to exit)

.PARAMETER NoAnim
  Disable animation, show static screen and exit after 2s

.PARAMETER Ascii
  Use ASCII-only mode (no emoji)

.EXAMPLE
  .\.agentcrew\animations\show-party.ps1 -Objective "Design Solution" -Squad PM,Architect,Backend,Security

.EXAMPLE
  .\.agentcrew\animations\show-party.ps1 -Objective "Build Feature" -Squad Frontend,Backend,QA -Timeout 5
#>

param(
  [string]$Objective = 'Unknown Objective',
  [string[]]$Squad = @('Orchestrator'),
  [int]$Timeout = 0,
  [switch]$NoAnim,
  [switch]$Ascii
)

# Emoji set (stored in vars to avoid PowerShell 5.1 parser issues with inline emoji)
$ePM = '📋'; $eBA = '📊'; $eArch = '🏗️'; $eTL = '👨‍💻'; $eFE = '🎨'
$eBE = '⚙️'; $eMB = '📱'; $eUX = '✏️'; $eDE = '🗄️'; $eML = '🧠'
$eQA = '🔍'; $eSec = '🛡️'; $eDO = '🚀'; $eEM = '📅'; $eDB = '⚖️'; $eOrch = '🎯'

$eFallback = '?'

$roleMap = @{
  'PM'           = @{ icon = $ePM;  iconA = '[PM]'; name = 'Product Manager';   actions = @('Gathering requirements','Writing PRD','Prioritizing backlog','Aligning stakeholders','Defining scope') }
  'BA'           = @{ icon = $eBA;  iconA = '[BA]'; name = 'Business Analyst';  actions = @('Analyzing requirements','Writing user stories','Gap analysis','Mapping dependencies','Documenting flows') }
  'Architect'    = @{ icon = $eArch;iconA = '[AR]'; name = 'Solution Architect';actions = @('Designing architecture','Evaluating tech stack','Creating diagrams','Writing ADRs','Defining patterns') }
  'Tech Lead'    = @{ icon = $eTL;  iconA = '[TL]'; name = 'Tech Lead';        actions = @('Reviewing designs','Setting standards','Planning sprints','Code review','Technical guidance') }
  'Frontend'     = @{ icon = $eFE;  iconA = '[FE]'; name = 'Frontend Dev';      actions = @('Building UI components','Styling layouts','Client logic','Integration','State management') }
  'Backend'      = @{ icon = $eBE;  iconA = '[BE]'; name = 'Backend Dev';       actions = @('Implementing API','Designing DB schema','Writing services','Business logic','Data modeling') }
  'Mobile'       = @{ icon = $eMB;  iconA = '[MB]'; name = 'Mobile Dev';        actions = @('Building mobile UI','Offline support','Push notifications','App store prep','API integration') }
  'UX'           = @{ icon = $eUX;  iconA = '[UX]'; name = 'UX Designer';       actions = @('Creating wireframes','User research','Prototyping','Usability testing','Design system') }
  'Data'         = @{ icon = $eDE;  iconA = '[DE]'; name = 'Data Engineer';     actions = @('Building pipelines','Designing schemas','Data quality','ETL/ELT','Data catalog') }
  'ML'           = @{ icon = $eML;  iconA = '[ML]'; name = 'ML Engineer';       actions = @('Training models','Feature engineering','Model evaluation','Serving endpoints','Drift monitoring') }
  'QA'           = @{ icon = $eQA;  iconA = '[QA]'; name = 'QA Engineer';       actions = @('Planning tests','Writing test cases','Running tests','Regression','Bug tracking') }
  'Security'     = @{ icon = $eSec; iconA = '[SE]'; name = 'Security Engineer'; actions = @('Threat modeling','Security review','Pentesting','SBOM','Security gates') }
  'DevOps'       = @{ icon = $eDO;  iconA = '[DO]'; name = 'DevOps Engineer';   actions = @('Setting up CI/CD','Infrastructure','Deployment','Monitoring','Release mgmt') }
  'EM'           = @{ icon = $eEM;  iconA = '[EM]'; name = 'Eng Manager';       actions = @('Sprint planning','Capacity allocation','Retrospective','Velocity tracking','Standups') }
  'Debator'      = @{ icon = $eDB;  iconA = '[DB]'; name = 'Facilitator';       actions = @('Moderating debate','Structuring arguments','Scoring options','Documenting decisions','Timeboxing') }
  'Orchestrator' = @{ icon = $eOrch;iconA = '[OR]'; name = 'Orchestrator';      actions = @('Decomposing request','Assigning squads','Tracking progress','Cross-obj coordination','Status reporting') }
}

$ESC = [char]27

function Set-Cursor($x, $y) {
  Write-Host "$ESC[$($y);$($x)H" -NoNewline
}

function Hide-Cursor {
  Write-Host "$ESC[?25l" -NoNewline
}

function Show-Cursor {
  Write-Host "$ESC[?25h" -NoNewline
}

function Set-Fg($c) {
  $c = switch ($c) {
    'red'    { 31 } 'green'  { 32 } 'yellow' { 33 }
    'blue'   { 34 } 'magenta' { 35 } 'cyan'   { 36 }
    'white'  { 37 } 'gray'   { 90 } 'dim'    { 2 }
    default  { 37 }
  }
  Write-Host "$ESC[${c}m" -NoNewline
}

function Set-Bg($c) {
  $c = switch ($c) {
    'red'    { 41 } 'green'  { 42 } 'yellow' { 43 }
    'blue'   { 44 } 'magenta' { 45 } 'cyan'   { 46 }
    'gray'   { 100 }
    default  { 40 }
  }
  Write-Host "$ESC[${c}m" -NoNewline
}

function Reset-Color {
  Write-Host "$ESC[0m" -NoNewline
}

function Box-Char($name) {
  switch ($name) {
    'tl' { '╔' } 'tr' { '╗' } 'bl' { '╚' } 'br' { '╝' }
    'h'  { '═' } 'v'  { '║' }
    'ml' { '╠' } 'mr' { '╣' }
    default { ' ' }
  }
}

function Get-RoleIcon($roleName) {
  $key = $roleMap.Keys | Where-Object { $_ -eq $roleName } | Select-Object -First 1
  if (-not $key) { $key = $roleMap.Keys | Where-Object { $_ -like "$roleName*" } | Select-Object -First 1 }
  if (-not $key) { return if ($Ascii) { '[?]' } else { $eFallback } }
  if ($Ascii) { return $roleMap[$key].iconA }
  return $roleMap[$key].icon
}

function Get-RoleActions($roleName) {
  $key = $roleMap.Keys | Where-Object { $_ -eq $roleName } | Select-Object -First 1
  if (-not $key) { $key = $roleMap.Keys | Where-Object { $_ -like "$roleName*" } | Select-Object -First 1 }
  if (-not $key) { return @('Working...') }
  return $roleMap[$key].actions
}

function Get-RolePadWidth($roleNames) {
  $maxLen = 0
  foreach ($n in $roleNames) {
    if ($n.Length -gt $maxLen) { $maxLen = $n.Length }
  }
  return [math]::Max(8, [math]::Min(14, $maxLen))
}

$objectiveActions = @{
  'Clarify Vision'      = @('Clarifying scope','Defining success','Aligning stakeholders','Setting priorities')
  'Design Solution'     = @('Architecture design','Component modeling','Interface definition','Pattern selection')
  'Plan Work'           = @('Sprint planning','Task breakdown','Capacity analysis','Dependency mapping')
  'Build Feature'       = @('Feature implementation','Component building','Integration testing','Code review')
  'Verify Quality'      = @('Test execution','Quality gate review','Security scanning','Performance validation')
  'Ship Release'        = @('Release preparation','Deployment pipeline','Environment config','Rollback planning')
  'Operate & Learn'     = @('Monitoring review','Feedback analysis','Incident response','Improvement planning')
}

function Get-ObjectiveAction {
  param([string]$obj)
  $actions = $objectiveActions[$obj]
  if (-not $actions) { $actions = @('Processing','Analyzing','Building','Reviewing') }
  return $actions[(Get-Random -Maximum $actions.Count)]
}

function Draw-ProgressBar {
  param([int]$pct, [int]$width = 12, [string]$prefix = '[')

  $fillCount = [math]::Max(0, [math]::Min($width, [math]::Floor($pct * $width / 100)))
  $emptyCount = $width - $fillCount

  $bar = $prefix + ('█' * $fillCount) + ('░' * $emptyCount) + ']'

  if ($pct -ge 100) {
    Set-Fg 'green'
  } elseif ($pct -ge 50) {
    Set-Fg 'yellow'
  } else {
    Set-Fg 'gray'
  }
  Write-Host $bar -NoNewline
  Reset-Color
}

function Show-Party {
  $contentWidth = 60

  $squadData = @()
  foreach ($role in $Squad) {
    $squadData += @{
      role    = $role
      icon    = Get-RoleIcon $role
      pct     = if ($NoAnim) { 0 } else { Get-Random -Minimum 5 -Maximum 35 }
      actions = Get-RoleActions $role
      actIdx  = Get-Random -Maximum 5
    }
  }

  $rolePad = Get-RolePadWidth ($squadData | ForEach-Object { $_.role })
  $startY = 1
  $script:elapsed = 0

  function Get-Elapsed {
    $h = [math]::Floor($script:elapsed / 3600)
    $m = [math]::Floor(($script:elapsed % 3600) / 60)
    $s = $script:elapsed % 60
    return "⏱  $($h.ToString('00')):$($m.ToString('00')):$($s.ToString('00'))"
  }

  function Draw-Frame {
    $y = $startY

    Set-Cursor 1 $y
    Set-Fg 'cyan'
    Write-Host (Box-Char 'tl') -NoNewline
    Write-Host ((Box-Char 'h') * ($contentWidth + 2)) -NoNewline
    Write-Host (Box-Char 'tr')
    $y++

    Set-Cursor 1 $y
    Write-Host (Box-Char 'v') -NoNewline
    Set-Fg 'white'
    Set-Bg 'blue'
    $titleText = if ($Ascii) { ' AGENT CREW ASSEMBLED ' } else { ' 🎯 AGENT CREW ASSEMBLED ' }
    $titlePad = $contentWidth - $titleText.Length
    $leftPad = [math]::Max(0, [math]::Floor($titlePad / 2))
    $rightPad = [math]::Max(0, $titlePad - $leftPad)
    Write-Host (' ' * $leftPad) -NoNewline
    Write-Host $titleText -NoNewline
    Write-Host (' ' * $rightPad) -NoNewline
    Reset-Color
    Write-Host (Box-Char 'v')
    $y++

    Set-Cursor 1 $y
    Write-Host (Box-Char 'v') -NoNewline
    Set-Fg 'white'
    $objText = "   $Objective"
    Write-Host $objText -NoNewline
    $objPad = $contentWidth - $objText.Length
    Write-Host (' ' * $objPad) -NoNewline
    Reset-Color
    Write-Host (Box-Char 'v')
    $y++

    Set-Cursor 1 $y
    Set-Fg 'cyan'
    Write-Host (Box-Char 'ml') -NoNewline
    Write-Host ((Box-Char 'h') * ($contentWidth + 2)) -NoNewline
    Write-Host (Box-Char 'mr')
    Reset-Color
    $y++
    $y++

    foreach ($sd in $squadData) {
      Set-Cursor 1 $y
      Write-Host (Box-Char 'v') -NoNewline

      Set-Fg 'white'
      Write-Host "  $($sd.icon) " -NoNewline
      Set-Fg 'yellow'
      Write-Host $sd.role.PadRight($rolePad) -NoNewline
      Reset-Color

      Write-Host '  ' -NoNewline
      Draw-ProgressBar -pct $sd.pct -width 12 -prefix '['

      Set-Fg 'gray'
      $pctStr = $sd.pct.ToString().PadLeft(3) + '%'
      Write-Host " $pctStr" -NoNewline
      Reset-Color

      Write-Host '  ' -NoNewline
      Set-Fg 'dim'
      $actionText = $sd.actions[$sd.actIdx]
      if ($actionText.Length -gt 24) { $actionText = $actionText.Substring(0, 21) + '...' }
      Write-Host $actionText.PadRight(24) -NoNewline
      Reset-Color

      Set-Cursor ($contentWidth + 4) $y
      Write-Host (Box-Char 'v')
      $y++
    }

    $y++

    Set-Cursor 1 $y
    Set-Fg 'cyan'
    Write-Host (Box-Char 'ml') -NoNewline
    Write-Host ((Box-Char 'h') * ($contentWidth + 2)) -NoNewline
    Write-Host (Box-Char 'mr')
    Reset-Color
    $y++

    Set-Cursor 1 $y
    Write-Host (Box-Char 'v') -NoNewline
    Set-Fg 'gray'
    $elapsedStr = Get-Elapsed
    Write-Host " $elapsedStr" -NoNewline
    Reset-Color

    $phaseActions = Get-ObjectiveAction $Objective
    $footerRight = "  $phaseActions  "
    $footerMid = $contentWidth - $elapsedStr.Length - 2 - $footerRight.Length
    if ($footerMid -lt 1) { $footerMid = 1 }
    Write-Host (' ' * $footerMid) -NoNewline
    Set-Fg 'gray'
    Write-Host $footerRight -NoNewline
    Reset-Color

    Set-Cursor ($contentWidth + 4) $y
    Write-Host (Box-Char 'v')
    $y++

    Set-Cursor 1 $y
    Set-Fg 'cyan'
    Write-Host (Box-Char 'bl') -NoNewline
    Write-Host ((Box-Char 'h') * ($contentWidth + 2)) -NoNewline
    Write-Host (Box-Char 'br')
    Reset-Color
  }

  function Update-SquadData {
    foreach ($sd in $squadData) {
      $sd.pct = [math]::Min(100, $sd.pct + (Get-Random -Minimum 0 -Maximum 4))
      if ((Get-Random -Maximum 3) -eq 0) {
        $sd.actIdx = Get-Random -Maximum $sd.actions.Count
      }
    }
  }

  Hide-Cursor
  $startTime = Get-Date

  try {
    if ($NoAnim) {
      Draw-Frame
      Show-Cursor
      Write-Host "`n`n  [Static display]`n"
      Start-Sleep -Seconds 2
      return
    }

    while ($true) {
      $script:elapsed = [math]::Floor(((Get-Date) - $startTime).TotalSeconds)
      if ($Timeout -gt 0 -and $script:elapsed -ge $Timeout) { break }
      Draw-Frame
      Start-Sleep -Milliseconds 600
      Update-SquadData
    }
  } finally {
    Show-Cursor
    Reset-Color
  }

  if ($Timeout -gt 0) {
    foreach ($sd in $squadData) {
      $sd.pct = 100
      $sd.actIdx = 0
    }
    Draw-Frame
    Start-Sleep -Milliseconds 800
  }
}

try {
  Show-Party
}
finally {
  Show-Cursor
  Reset-Color
  Write-Host ''
}

