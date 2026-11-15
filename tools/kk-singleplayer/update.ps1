$ErrorActionPreference = "Stop"
$AppDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $AppDir "..\..")).Path
$Python = Join-Path $Root ".venv\Scripts\python.exe"

if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python environment not found: $Python"
}

& $Python -m py_compile `
    (Join-Path $AppDir "kk_singleplayer_gui.py") `
    (Join-Path $Root "tools\war3map-injector\campaign_singleplayer.py")
if ($LASTEXITCODE -ne 0) {
    throw "Python syntax validation failed."
}

& $Python -m unittest discover `
    -s (Join-Path $AppDir "tests") `
    -v
if ($LASTEXITCODE -ne 0) {
    throw "Policy unit tests failed."
}

& powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File (Join-Path $AppDir "install_shortcut.ps1")
if ($LASTEXITCODE -ne 0) {
    throw "Shortcut refresh failed."
}
