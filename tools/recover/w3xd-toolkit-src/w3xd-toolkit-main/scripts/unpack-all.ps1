<#
.SYNOPSIS
    Unpack every .w3xd in a directory and decompile the Lua inside each map.

.EXAMPLE
    scripts\unpack-all.ps1 -Source D:\maps
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Source,
    [string]$Python = 'python'
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$env:PYTHONPATH = $root

Write-Host '== decrypting containers =='
& $Python -m w3xd batch $Source -x
if ($LASTEXITCODE -ne 0) { throw "w3xd batch failed ($LASTEXITCODE)" }

Write-Host ''
Write-Host '== decompiling war3map.luac =='
foreach ($d in Get-ChildItem $Source -Directory -Filter '*.files') {
    $luac = Join-Path $d.FullName 'war3map.luac'
    if (-not (Test-Path $luac)) { continue }
    & $Python -m luac53 decompile $luac
    if ($LASTEXITCODE -ne 0) { Write-Warning "decompile failed for $luac" }
}

Write-Host ''
Write-Host 'done.  Each <map>.files/ now holds war3map.lua next to war3map.luac.'
