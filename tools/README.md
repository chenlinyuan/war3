# tools · 本地工具

存放本地脚本、辅助工具与配置。

## 目录结构

```
tools/
├── scripts/         # 辅助脚本（PowerShell / Python / Node）
├── configs/         # 工具配置
└── README.md
```

## 常用脚本

### 解包地图

```powershell
# unpack.ps1
param([string]$MapPath, [string]$OutputDir)
MPQEditor.exe extract $MapPath * $OutputDir
```

### 转 JSON

```powershell
# tojson.ps1
param([string]$Dir)
wc3maptranslator $Dir --toJson
```

### 打包地图

```powershell
# pack.ps1
param([string]$MapPath, [string]$InputDir)
MPQEditor.exe add $MapPath "$InputDir\*" /r
```

## 外部工具

见 [`../docs/06-工具链/`](../docs/06-工具链/)。

## 注意

- 不将第三方工具的二进制文件提交到仓库（体积大）。
- 记录工具版本与下载来源。
