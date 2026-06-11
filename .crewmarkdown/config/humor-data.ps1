$script:helpQuotes = @(
  "Ship early. Ship often. Ship before they change the requirements.",
  "Works on my machine (TM).",
  "There are 10 types of people. Those who understand binary, and those who don't.",
  "It's not a bug, it's an undocumented feature.",
  "I don't always test my code, but when I do, I do it in production.",
  "The best error message is the one that never appears.",
  "Programming is 10% writing code and 90% debugging why it doesn't work.",
  "A user interface is like a joke. If you have to explain it, it's bad.",
  "I put the 'pro' in 'procrastination'.",
  "The code compiles. The code works. The code is perfect. ...said no developer ever."
)

$script:chaoticQuotes = @(
  "You had ONE job. Actually, you had several. But still.",
  "This is fine. (Everything is fine.)",
  "The AI is taking notes. The AI is always taking notes.",
  "If you can read this, you're too close to the terminal.",
  "Your ticket has been escalated. The AI is me.",
  "I'd tell you a joke about UDP, but you might not get it.",
  "Why do programmers prefer dark mode? Light attracts bugs.",
  "I'm not arguing, I'm just explaining why I'm right.",
  "This project brought to you by caffeine and denial.",
  "Commit early, commit often, commit to therapy."
)

$script:progressFlavors = @(
  "Herding cats...",
  "Convincing the AI to cooperate...",
  "Counting to infinity...",
  "Untangling spaghetti code...",
  "Consulting the ancient scrolls...",
  "Charging crystals...",
  "Summoning the demons...",
  "Reticulating splines...",
  "Teaching a neural net to fish...",
  "Dividing by zero...",
  "Watching paint dry...",
  "Waiting for the bus...",
  "Sharpening pencils...",
  "Brewing coffee...",
  "Assembling the fellowship..."
)

$script:retryMessages = @(
  "Retrying before I write a strongly worded letter.",
  "Attempt #{0}. The AI is learning patience from you.",
  "Round #{0}. This is fine. (Everything is fine.)",
  "Persistent, aren't we? Retry #{0}.",
  "This code has more lives than a cat. Retry #{0}.",
  "Third time's the charm. Retry #{0}."
)

$script:errorSuffixes = @(
  "But what do I know? I'm just ones and zeroes.",
  "The AI is disappointed. The AI is always disappointed.",
  "Oof. That didn't work. Try again?",
  "This is why we can't have nice things.",
  "I blame the network. It's always the network.",
  "Error: the computer said no.",
  "Fate has frowned upon this operation."
)

$script:aprilFoolsMessages = @(
  "Your code has been converted to COBOL for 'backward compatibility'.",
  "We've migrated your project to punch cards. Enjoy.",
  "Today only: all errors are now warnings. You're welcome.",
  "Vim keybindings enabled in all outputs. Good luck.",
  "All function names randomly shuffled. Ship it."
)

function Get-Tone {
  $envTone = [System.Environment]::GetEnvironmentVariable('CREW_TONE', 'Process')
  $af = [System.Environment]::GetEnvironmentVariable('APRIL_FOOLS', 'Process') -eq '1'
  if (-not $envTone) {
    $configPath = Join-Path $PSScriptRoot 'tone.json'
    if (Test-Path $configPath) {
      try {
        $cfg = Get-Content $configPath -Raw | ConvertFrom-Json
        $envTone = $cfg.tone
        if ($af -or $cfg.aprilFools) { return 'chaotic' }
      } catch { $envTone = 'professional' }
    } else { $envTone = 'professional' }
  }
  if ($af) { return 'chaotic' }
  return $envTone
}

function Get-HelpQuote {
  $tone = Get-Tone
  $pool = if ($tone -eq 'chaotic') { $script:chaoticQuotes } else { $script:helpQuotes }
  return $pool[(Get-Random -Maximum $pool.Count)]
}

function Get-ProgressFlavor {
  $tone = Get-Tone
  if ($tone -eq 'professional') { return $null }
  return $script:progressFlavors[(Get-Random -Maximum $script:progressFlavors.Count)]
}

function Get-RetryMessage {
  param([int]$Attempt)
  $tone = Get-Tone
  if ($tone -eq 'professional') { return "Retrying... (attempt $Attempt)" }
  $msg = $script:retryMessages[(Get-Random -Maximum $script:retryMessages.Count)]
  return $msg -f $Attempt
}

function Get-ErrorSuffix {
  $tone = Get-Tone
  if ($tone -eq 'professional') { return $null }
  return $script:errorSuffixes[(Get-Random -Maximum $script:errorSuffixes.Count)]
}

function Invoke-PleaseTransform {
  param([string]$Text)
  $tone = Get-Tone
  if ($tone -eq 'professional') { return $text }
  $politePrefixes = @(
    "Please stand by: ",
    "With pleasure: ",
    "If you don't mind: ",
    "Allow me to politely: "
  )
  return $politePrefixes[(Get-Random -Maximum $politePrefixes.Count)] + $Text
}

function Invoke-YellTransform {
  param([string]$Text)
  return $Text.ToUpper()
}

function Get-JanuaryFirst {
  $today = Get-Date
  return ($today.Month -eq 4 -and $today.Day -eq 1)
}
