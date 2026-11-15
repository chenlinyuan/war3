$ErrorActionPreference = "Stop"
$AppDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $AppDir "..\..")).Path
$Python = Join-Path $Root ".venv\Scripts\python.exe"
$Dist = Join-Path $Root "dist"
$Build = Join-Path $Root "build\classic-item-browser"
$Name = "ALAS-Classic-ItemBrowser"

if (-not (Test-Path -LiteralPath $Python)) {
    throw "Build environment not found: $Python"
}

& $Python -m PyInstaller `
    --noconfirm `
    --clean `
    --distpath $Dist `
    --workpath $Build `
    (Join-Path $AppDir "$Name.spec")
if ($LASTEXITCODE -ne 0) {
    throw "PyInstaller failed with exit code $LASTEXITCODE"
}

$Worker = Join-Path $Dist "$Name\$Name-Worker.exe"
$Cli = Join-Path $Dist "$Name\$Name-CLI.exe"
if (-not (Test-Path -LiteralPath $Worker)) {
    throw "Worker executable is missing: $Worker"
}
Copy-Item -LiteralPath $Worker -Destination $Cli -Force
Copy-Item -LiteralPath (Join-Path $AppDir "README.md") `
    -Destination (Join-Path $Dist "$Name\README.md") -Force
