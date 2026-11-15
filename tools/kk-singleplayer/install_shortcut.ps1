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

$Pythonw = (Resolve-Path -LiteralPath $Pythonw).Path
$Gui = (Resolve-Path -LiteralPath $Gui).Path
$ShortcutDir = Split-Path -Parent $ShortcutPath
if (-not (Test-Path -LiteralPath $ShortcutDir)) {
    New-Item -ItemType Directory -Path $ShortcutDir -Force | Out-Null
}

$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $Pythonw
$Shortcut.Arguments = '"{0}"' -f $Gui
$Shortcut.WorkingDirectory = $AppDir
$Shortcut.IconLocation = "$env:SystemRoot\System32\shell32.dll,137"
$Shortcut.Description = "KK平台战役单机化工具（不启动游戏）"
$Shortcut.Save()

[pscustomobject]@{
    Shortcut = $ShortcutPath
    Target = $Pythonw
    Arguments = $Shortcut.Arguments
    WorkingDirectory = $Shortcut.WorkingDirectory
} | ConvertTo-Json -Compress
