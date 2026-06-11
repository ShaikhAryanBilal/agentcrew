<#
.SYNOPSIS
Generates codebase-map.md: full tree + file descriptions + exports.
Agent reads this to navigate without searching.
Language-agnostic.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path "$PSScriptRoot\..\..").Path.TrimEnd('\')
$OutFile = Join-Path $ProjectRoot "codebase-map.md"

$IgnoredDirs = @('node_modules','.git','.svn','.hg','dist','build','.next','.nuxt','.output','__pycache__','.venv','venv','.env','env','coverage','.nyc_output','.pytest_cache','target','bin','obj','.vs','.terraform','.serverless','.opencode','.cursor','.vscode')

$IgnoredExts = @('.min.js','.min.css','.map','.pyc','.pyo','.so','.dll','.exe','.jpg','.jpeg','.png','.gif','.ico','.svg','.webp','.woff','.woff2','.ttf','.eot','.mp4','.mp3','.avi','.mov','.zip','.tar','.gz','.rar','.7z','.pdf','.doc','.docx','.xls','.xlsx','.log')

$CommentChars = @{
    '.py'='#'; '.rb'='#'; '.sh'='#'; '.ps1'='#'; '.psm1'='#'
    '.yaml'='#'; '.yml'='#'; '.toml'='#'; '.ini'=';'; '.cfg'='#'; '.conf'='#'
    '.js'='//'; '.ts'='//'; '.tsx'='//'; '.jsx'='//'
    '.rs'='//'; '.go'='//'; '.java'='//'; '.c'='//'; '.cpp'='//'; '.h'='//'; '.hpp'='//'
    '.cs'='//'; '.swift'='//'; '.kt'='//'; '.php'='//'; '.sql'='--'
    '.css'='/*'; '.scss'='//'; '.less'='//'
    '.html'='<!--'; '.htm'='<!--'; '.xml'='<!--'; '.vue'='<!--'; '.svelte'='<!--'
    '.md'='<!--'; '.tf'='#'; '.gradle'='//'
    '.dockerfile'='#'; 'Dockerfile'='#'
}

function Should-Ignore {
    param($RelPath)
    $parts = $RelPath -split '[/\\]'
    foreach ($d in $IgnoredDirs) {
        if ($parts -contains $d) { return $true }
    }
    return $false
}

function Get-FirstComment {
    param($Path, $Ext, $Fname)
    try {
        $lines = Get-Content $Path -TotalCount 20 -ErrorAction Stop
        $cc = $null
        if ($CommentChars.ContainsKey($Ext)) { $cc = $CommentChars[$Ext] }
        elseif ($CommentChars.ContainsKey($Fname)) { $cc = $CommentChars[$Fname] }
        if (-not $cc) { return $null }

        $comments = @(); $inBlock = $false
        foreach ($line in $lines) {
            $t = $line.Trim()
            if ([string]::IsNullOrEmpty($t)) { continue }
            if ($cc -eq '/*') {
                if ($t -match '^/\*\*') { $inBlock = $true; continue }
                if ($t -match '\*/') { $inBlock = $false; continue }
                if ($inBlock) { $c = $t -replace '^\s*\*\s?',''; if ($c) {$comments+=$c}; continue }
            }
            elseif ($cc -eq '<!--') {
                if ($t -match '^<!--') { $inBlock = $true }
                if ($inBlock) { $c = $t -replace '^\s*<!--?\s*','' -replace '\s*-->\s*$',''; if ($c -and $c -ne '-->') {$comments+=$c}; if ($t -match '-->') {$inBlock=$false}; continue }
            }
            elseif ($t -match "^$([regex]::Escape($cc))\s*(.*)") {
                $comments += $matches[1]
            }
            if ($comments.Count -ge 3) { break }
        }
        if ($comments.Count -gt 0) { return ($comments -join ' | ') }
    } catch {}
    return $null
}

function Get-Defs {
    param($Path)
    $defs = @()
    try {
        $content = Get-Content $Path -ErrorAction Stop
        $max = [Math]::Min($content.Count, 200)
        for ($i=0; $i -lt $max; $i++) {
            $l = $content[$i].Trim()
            $patterns = @(
                '^\s*(export\s+)?(async\s+)?function\s+\w+'
                '^\s*(export\s+)?(async\s+)?def\s+\w+'
                '^\s*(export\s+)?(pub\s+)?fn\s+\w+'
                '^\s*(export\s+)?class\s+\w+'
                '^\s*(export\s+)?interface\s+\w+'
                '^\s*(export\s+)?type\s+\w+'
                '^\s*(export\s+)?enum\s+\w+'
                '^\s*(export\s+)?const\s+\w+'
                '^\s*def\s+\w+'
                '^\s*func\s+\w+'
                '^\s*fn\s+\w+'
                '^\s*CREATE\s+(TABLE|VIEW|INDEX|FUNCTION|PROCEDURE)'
                '^\s*(public|private|protected)\s+(override\s+)?(fun\s+)?\w+\s*\('
                '^\s*struct\s+\w+'
                '^\s*trait\s+\w+'
                '^\s*impl\s+\w+'
            )
            foreach ($p in $patterns) {
                if ($l -match $p) {
                    $defs += ($l -replace '\s+',' ').Substring(0, [Math]::Min(80, ($l -replace '\s+',' ').Length))
                    break
                }
            }
        }
    } catch {}
    return ($defs | Select-Object -Unique)
}

function Build-Tree {
    param($Items)
    $root = @{}
    foreach ($item in $Items) {
        $parts = $item -split '[/\\]'
        $cur = $root
        for ($i=0; $i -lt $parts.Length-1; $i++) {
            if (-not $cur.ContainsKey($parts[$i])) { $cur[$parts[$i]] = @{} }
            $cur = $cur[$parts[$i]]
        }
        if (-not $cur.ContainsKey('__files__')) { $cur['__files__'] = @() }
        $cur['__files__'] += $parts[-1]
    }
    return $root
}

function Render-TreeLines {
    param($Node, $Indent = '')
    $lines = @()
    $keys = $Node.Keys | Where-Object { $_ -ne '__files__' } | Sort-Object
    for ($i=0; $i -lt $keys.Count; $i++) {
        $k = $keys[$i]
        $lines += "$Indent|-- $k/"
        if ($Node[$k] -is [hashtable]) {
            $sub = Render-TreeLines -Node $Node[$k] -Indent "$Indent|   "
            $lines += $sub
        }
    }
    if ($Node.ContainsKey('__files__')) {
        $files = $Node['__files__'] | Sort-Object
        foreach ($f in $files) {
            $lines += "$Indent|-- $f"
        }
    }
    return $lines
}

Write-Host "Scanning $ProjectRoot ..." -ForegroundColor Cyan

$AllFiles = Get-ChildItem $ProjectRoot -Recurse -File -ErrorAction SilentlyContinue
$Details = @(); $Count = 0; $Total = $AllFiles.Count

foreach ($file in $AllFiles) {
    $Count++
    if ($Count % 100 -eq 0) { Write-Host "  $Count / $Total" }
    $Rel = $file.FullName.Substring($ProjectRoot.Length + 1)
    if (Should-Ignore -RelPath $Rel) { continue }

    $Ext = [System.IO.Path]::GetExtension($file.Name).ToLower()
    $Fname = $file.Name
    $lowFname = $Fname.ToLower()

    $skipExt = $false
    foreach ($ie in $IgnoredExts) {
        if ($Rel.ToLower().EndsWith($ie)) { $skipExt = $true; break }
    }
    if ($skipExt) { continue }

    $Desc = Get-FirstComment -Path $file.FullName -Ext $Ext -Fname $Fname
    $Defs = Get-Defs -Path $file.FullName
    $Lines = (Get-Content $file.FullName -ErrorAction SilentlyContinue | Measure-Object).Count
    $Size = [Math]::Round($file.Length / 1KB, 1)

    $Details += [PSCustomObject]@{Path=$Rel; Lines=$Lines; Size=$Size; Desc=$Desc; Defs=$Defs}
}

$Details = $Details | Sort-Object Path
$Paths = $Details | ForEach-Object { $_.Path }
$Tree = Build-Tree -Items $Paths
$TreeLines = Render-TreeLines -Node $Tree

Write-Host "Writing $OutFile ..." -ForegroundColor Cyan

$Content = @()
$Content += "# Codebase Map"
$Content += ""
$Content += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
$Content += "Project: $((Get-Item $ProjectRoot).Name)"
$Content += "Files: $($Details.Count)"
$Content += ""
$Content += "Agent reads this first to navigate without searching."
$Content += ""
$Content += "---"
$Content += ""
$Content += "## Directory Tree"
$Content += ""
$Content += '```'
$Content += $TreeLines
$Content += '```'
$Content += ""
$Content += "---"
$Content += ""
$Content += "## File Details"
$Content += ""

foreach ($d in $Details) {
    $Content += "### $($d.Path)"
    $Content += "**Lines:** $($d.Lines) | **Size:** $($d.Size)KB"
    if ($d.Desc) { $Content += "**Desc:** $($d.Desc)" }
    if ($d.Defs) { $Content += "**Defs:** $($d.Defs)" }
    $Content += ""
}

$Content -join "`r`n" | Out-File $OutFile -Encoding utf8

Write-Host "Done: $OutFile ($($Details.Count) files)" -ForegroundColor Green
