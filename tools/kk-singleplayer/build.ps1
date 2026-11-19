param(
    [string]$DistPath
)

$ErrorActionPreference = "Stop"
$AppDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $AppDir "..\..")).Path
$Python = Join-Path $Root ".venv\Scripts\python.exe"
$Dist = if ($DistPath) {
    [System.IO.Path]::GetFullPath($DistPath)
} else {
    Join-Path $Root "dist"
}
$Output = Join-Path $Dist "KK-Singleplayer"
$Build = Join-Path $Root "build\kk-singleplayer"

& $Python -m PyInstaller `
    --noconfirm `
    --clean `
    --distpath $Output `
    --workpath $Build `
    (Join-Path $AppDir "KK-Singleplayer.spec")
if ($LASTEXITCODE -ne 0) {
    throw "PyInstaller failed with exit code $LASTEXITCODE"
}

$Exe = Join-Path $Output "KK-Singleplayer.exe"
if (-not (Test-Path -LiteralPath $Exe)) {
    throw "Build finished but executable is missing: $Exe"
}

Get-Item -LiteralPath $Exe |
    Select-Object FullName, Length, LastWriteTime
