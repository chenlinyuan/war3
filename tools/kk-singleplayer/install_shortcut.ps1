param(
    [string]$ShortcutPath = (Join-Path ([Environment]::GetFolderPath("Desktop")) "KK地图单机化工具.lnk"),
    [string]$Pythonw,
    [string]$Gui
)

$ErrorActionPreference = "Stop"
$AppDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $AppDir "..\..")).Path

if (-not $Pythonw) {
    $Pythonw = Join-Path $Root ".venv\Scripts\pythonw.exe"
}
if (-not $Gui) {
    $Gui = Join-Path $AppDir "kk_singleplayer_gui.py"
}

$PackagedExe = Join-Path $Root "dist-next\KK-Singleplayer\KK-Singleplayer.exe"
if (Test-Path -LiteralPath $PackagedExe) {
    $TargetPath = (Resolve-Path -LiteralPath $PackagedExe).Path
    $Arguments = ""
    $WorkingDirectory = Split-Path -Parent $TargetPath
} else {
    $TargetPath = (Resolve-Path -LiteralPath $Pythonw).Path
    $Arguments = '"{0}"' -f (Resolve-Path -LiteralPath $Gui).Path
    $WorkingDirectory = $AppDir
}
$ShortcutDir = Split-Path -Parent $ShortcutPath
if (-not (Test-Path -LiteralPath $ShortcutDir)) {
    New-Item -ItemType Directory -Path $ShortcutDir -Force | Out-Null
}

$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $TargetPath
$Shortcut.Arguments = $Arguments
$Shortcut.WorkingDirectory = $WorkingDirectory
$Shortcut.IconLocation = "$env:SystemRoot\System32\shell32.dll,137"
$Shortcut.Description = "KK平台战役单机化工具（不启动游戏）"
$Shortcut.Save()

[pscustomobject]@{
    Shortcut = $ShortcutPath
    Target = $TargetPath
    Arguments = $Shortcut.Arguments
    WorkingDirectory = $Shortcut.WorkingDirectory
} | ConvertTo-Json -Compress
