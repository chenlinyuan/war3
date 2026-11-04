<#
.SYNOPSIS
    Fetch and build unluac into tools/unluac (git-ignored).

.DESCRIPTION
    unluac is MIT licensed: https://github.com/HansWessels/unluac

.EXAMPLE
    scripts\get-unluac.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$dest = Join-Path $root 'tools\unluac'
$repo = 'https://github.com/HansWessels/unluac.git'

if (Test-Path (Join-Path $dest 'src\build\unluac')) {
    Write-Host "unluac already built in $dest\src\build"
    exit 0
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'git is required'
}
if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    throw 'a JDK is required (javac not found)'
}

New-Item -ItemType Directory -Force -Path (Join-Path $root 'tools') | Out-Null

if (-not (Test-Path (Join-Path $dest '.git'))) {
    Write-Host 'cloning unluac ...'
    & git clone --depth 1 $repo $dest
    if ($LASTEXITCODE -ne 0) { throw "git clone failed ($LASTEXITCODE)" }
}

Write-Host 'compiling ...'
$build = Join-Path $dest 'src\build'
New-Item -ItemType Directory -Force -Path $build | Out-Null
$sources = Get-ChildItem (Join-Path $dest 'src\unluac') -Recurse -Filter '*.java' |
    ForEach-Object { $_.FullName }
& javac -nowarn -d $build $sources
if ($LASTEXITCODE -ne 0) { throw "javac failed ($LASTEXITCODE)" }

Write-Host ''
Write-Host "done: $build"
Write-Host 'luac53 will find it automatically; or set UNLUAC_JAR to a jar.'
