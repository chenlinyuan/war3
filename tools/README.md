# tools · 本地工具

存放本地脚本、辅助工具与配置。

## 目录结构

```
tools/
├── kk-singleplayer/    # KK/KKWE 战役单机化图形入口
├── war3map-injector/   # 地图脚本注入工具链（本项目自研）
├── war3-tools/         # 第三方 War3 工具备份（见下）
└── README.md
```

## KK 战役单机化

桌面快捷方式 `KK地图单机化工具.lnk` 指向
[`kk-singleplayer/`](kk-singleplayer/)。图形工具负责选择 `.w3n`、显示转换进度，
底层复用 `war3map-injector/campaign_singleplayer.py` 完成 KKWE 反编译、平台门禁、
逐章校验和重新打包。

更新工具后运行 `kk-singleplayer/update.ps1`，或直接启动图形工具；两种方式都会
自动刷新桌面快捷方式。

## 第三方工具备份（`war3-tools/`）

`H:\Games\War3\Tools` 的完整备份，防止本机工具丢失。见
[`war3-tools/README.md`](war3-tools/README.md)。

> ⚠️ 该目录为**第三方二进制备份**，体积较大（约 81 MB）。正常开发只需
> `war3map-injector/`；`war3-tools/` 仅作存档用途。

## 外部工具

见 [`../docs/06-工具链/`](../docs/06-工具链/)。

## 注意

- 本仓库**例外地**纳入了 `war3-tools/` 第三方工具备份（用户要求，防止丢失）。
- 记录工具版本与下载来源（见 `war3-tools/README.md`）。
