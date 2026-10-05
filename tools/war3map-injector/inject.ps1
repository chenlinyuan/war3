# =============================================================================
# inject.ps1 - War3 地图脚本注入（使用 HkeW3mModifier2.0）
# =============================================================================
# 用法:
#   .\inject.ps1 -Map <地图路径> -Script <脚本目录> [-Tool <工具路径>]
#
# 示例:
#   .\inject.ps1 -Map "H:\Games\War3\Maps\(4)LostTemple.w3m" -Script ".\scripts\item-browser"
#
# 说明:
#   本脚本将 f.j/g.j/m.j 复制到 HkeW3mModifier 的 HkeData 目录，
#   然后启动工具。工具会自动注入脚本到打开的地图。
# =============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$Map,

    [Parameter(Mandatory=$true)]
    [string]$Script,

    [string]$Tool = "H:\Games\War3\Tools\151个常用脚本\脚本\HKE1.25(5.17美化版）\HKE1.25(5.17美化版）\HkeW3mModifier2.0.exe"
)

$ErrorActionPreference = "Stop"

# 解析路径
$Map = (Resolve-Path $Map).Path
$Script = (Resolve-Path $Script).Path
$ToolDir = Split-Path $Tool -Parent
$HkeData = Join-Path $ToolDir "HkeData"

Write-Host "=== War3 脚本注入 ===" -ForegroundColor Cyan
Write-Host "地图:   $Map"
Write-Host "脚本:   $Script"
Write-Host "工具:   $Tool"
Write-Host ""

# 校验
if (-not (Test-Path $Tool)) { throw "找不到注入工具: $Tool" }
foreach ($f in @("f.j", "g.j", "m.j")) {
    $p = Join-Path $Script $f
    if (-not (Test-Path $p)) { throw "缺少脚本文件: $p" }
}

# 备份地图
$backup = "$Map.bak"
if (-not (Test-Path $backup)) {
    Copy-Item $Map $backup
    Write-Host "已备份原地图: $backup" -ForegroundColor Yellow
}

# 复制脚本到 HkeData
if (-not (Test-Path $HkeData)) { New-Item -ItemType Directory -Path $HkeData | Out-Null }
foreach ($f in @("f.j", "g.j", "m.j")) {
    Copy-Item (Join-Path $Script $f) (Join-Path $HkeData $f) -Force
}
Write-Host "已复制脚本到: $HkeData" -ForegroundColor Green

# 启动工具
Write-Host ""
Write-Host "启动注入工具..." -ForegroundColor Cyan
Write-Host "请在工具中:" -ForegroundColor Yellow
Write-Host "  1. 打开地图: $Map"
Write-Host "  2. 点击『脚本注入』按钮"
Write-Host "  3. 保存地图"
Write-Host ""

Start-Process -FilePath $Tool -WorkingDirectory $ToolDir
