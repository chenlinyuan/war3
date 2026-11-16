# KK 地图单机化工具

桌面入口面向 `.w3n` KK/KKWE 战役，底层复用
`tools/war3map-injector/campaign_singleplayer.py`。

工具会从原始战役重新提取章节，不基于已注入的成品二次施工。默认流程包括：

- 将 KKWE `kkmap.jc` 还原为 JASS；
- 替换平台 native、拆除平台试玩/商城结束点；
- 应用仓库维护的单机软锁与清场修复；
- 对每章运行 pjass 和 Map Doctor；
- 清除章节 MPQ 的 `wPlatform` 字段；
- 重新打包 `.w3n`，并用游戏自带 Storm.dll 做静态归档校验。

工具不会启动 Warcraft III、World Editor 或任何平台客户端。

## 启动

双击桌面的 `KK地图单机化工具.lnk`，或运行：

```powershell
.\.venv\Scripts\pythonw.exe tools\kk-singleplayer\kk_singleplayer_gui.py
```

选择单个 `.w3n` 或包含多个 `.w3n` 的目录，然后点击“开始转换”。如果本机存在
`H:\Games\War3\Campaigns`，图形工具默认把最终战役直接放进该目录，方便 1.27
自定义战役列表直接显示；也可以手动改回源目录下的暂存目录。输出为：

```text
H:\Games\War3\Campaigns\<战役标题>（单机修复版）.w3n
<源目录>\_singleplayer_work\<战役ID>-<时间>-<PID>\
```

其中 `reports\REPORT.md` 是逐章转换报告，`scripts\` 是还原并修复后的 JASS。

## 经典版 / 重制版

“转换选项”中的“导出目标”控制章节 `war3map.w3i` 和兼容容器的处理方式：

- **重制版**（默认）：迁移到 `war3map.w3i` v31、game data 2/2，并应用战役专用的
  重制版章节容器修复；
- **经典版（1.27）**：保留洁净源图的 `war3map.w3i`，不套用重制版容器，只运行
  1.27 Map Doctor 检查。

重制版成品继续使用 `<战役标题>（单机修复版）.w3n`；经典版使用
`<战役标题>（单机修复版·经典版）.w3n`，因此两种版本不会互相覆盖。该选择会保存在
工具设置中。

## 清源推导模式

勾选“清源推导模式（忽略历史战役插件）”后，工具不会按源 SHA 加载任何已保存的战役
插件，也不会套用旧 key 白名单、旧 sentinel、旧剧情单位修复或重制版兼容容器。
转换器仍会执行通用平台 native 替换、静态门禁和原图扫描，并输出：

```text
<战役标题>（清源推导版）.w3n
<战役标题>（清源推导版·经典版）.w3n
```

该模式用于从干净 KK 原图重新验证问题。报告中的 `clean_rederive` 字段会记录本次
是否绕过了历史战役插件。清源模式不能同时使用依赖插件声明的“移除切换背包”选项。

清源模式还会按行为扫描所有章节，只中和同时满足以下条件的触发器：

- 条件包含 `DzAPI_Map_HasMallItem`；
- 动作枚举 `Player(0)` 全部单位；
- `ForGroupBJ` 回调直接 `RemoveUnit(GetEnumUnit())`。

普通剧情目标死亡、保护单位失败和其他非商城清场不会被这条规则修改。

## 中断点审计

对已还原脚本运行只读审计器，可以按章节列出判胜、判负、退出、切章和读档事件，
并区分平台哨兵、任意英雄死亡、聊天作弊入口与正常剧情事件：

```powershell
.\.venv\Scripts\python.exe tools\war3map-injector\audit_exit_paths.py `
  "<工作目录>\scripts" `
  --json "<工作目录>\reports\exit_audit.json" `
  --markdown "<工作目录>\reports\exit_audit.md"
```

修补单章后可增量合并，不必重建其余章节：

```powershell
.\.venv\Scripts\python.exe tools\war3map-injector\patch_deployed_campaign.py `
  "<当前成品.w3n>" --chapter "kuaitu02.w3x=<修复后的章节.w3x>" --replace
```

## 移除自带切换背包

图形工具中的“移除地图自带的切换背包能力”会按战役插件声明清理：

- 英雄、单位、物品和技能书对象里的切换技能 ID；
- 脚本中的 `UnitAddAbilityBJ` / `UnitMakeAbilityPermanent` 动态授予；
- 旧切换技能的 `GetSpellAbilityId()` 事件判断。

该选项不会删除普通 `AInv` 物品栏，也不会改动其他英雄技能。《荒野之怒》使用
`A60Q`，《战歌魅影》使用 `A6B7`，《娜迦之怒》和《燃烧之怒》使用 `A63G`，ID
分别保存在各自的战役插件清单中。

## 快捷方式刷新

图形工具每次启动都会调用 `install_shortcut.ps1` 刷新桌面快捷方式。更新源码后
也可以手动执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
  -File tools\kk-singleplayer\install_shortcut.ps1
```

快捷方式始终指向当前工作区的 `.venv\Scripts\pythonw.exe` 和图形入口，不依赖固定版本号。

## 命令行

批量或自动化调用仍可直接使用底层入口：

```powershell
.\.venv\Scripts\python.exe tools\war3map-injector\campaign_singleplayer.py `
  "H:\Games\War3\Campaigns\dz\209521.w3n" --overwrite `
  --clean-rederive --target classic
```

运行游戏验证前，请按工作区规则停止并交给用户手动测试。
