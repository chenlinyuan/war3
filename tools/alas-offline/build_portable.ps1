$ErrorActionPreference = "Stop"
$AppDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $AppDir "..\..")).Path
$Python = Join-Path $Root ".venv\Scripts\python.exe"
if (-not (Test-Path -LiteralPath $Python)) {
    throw "Build environment not found: $Python"
}

$Dist = Join-Path $Root "dist"
$Build = Join-Path $Root "build\alas-offline"
$Name = "ALAS-Offline"
$WingSource = Get-ChildItem -LiteralPath (Join-Path $Root "maps") -Directory |
    Where-Object { $_.Name -like "*.w3x.orig" } |
    Select-Object -First 1
if (-not $WingSource) {
    throw "Wing model source map not found."
}

$PyArgs = @(
    "-m", "PyInstaller",
    "--noconfirm",
    "--clean",
    "--distpath", $Dist,
    "--workpath", $Build,
    (Join-Path $AppDir "ALAS-Offline.spec")
)

& $Python @PyArgs
if ($LASTEXITCODE -ne 0) {
    throw "PyInstaller failed with exit code $LASTEXITCODE"
}

$Exe = Join-Path $Dist "$Name\$Name.exe"
$WorkerExe = Join-Path $Dist "$Name\$Name-Worker.exe"
$CliExe = Join-Path $Dist "$Name\$Name-CLI.exe"
if (-not (Test-Path -LiteralPath $Exe)) {
    throw "Build finished but executable is missing: $Exe"
}
if (-not (Test-Path -LiteralPath $WorkerExe)) {
    throw "Build finished but worker executable is missing: $WorkerExe"
}
Copy-Item -LiteralPath $WorkerExe -Destination $CliExe -Force
Copy-Item -LiteralPath (Join-Path $AppDir "README.md") `
    -Destination (Join-Path $Dist "$Name\README.md") -Force

Get-Item -LiteralPath $Exe, $WorkerExe |
    Select-Object FullName, Length, LastWriteTime
