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

选择一个战役目录，工具会读取其中的 `.w3n` 名称并显示为可多选列表；也可以继续使用单文件入口。勾选战役后再点击“开始转换”。如果本机存在
`H:\Games\War3\Campaigns`，图形工具默认把最终战役直接放进该目录，方便 1.27
自定义战役列表直接显示；也可以手动改回源目录下的暂存目录。输出为：

```text
H:\Games\War3\Campaigns\<战役标题>（单机修复版）.w3n
<源目录>\_singleplayer_work\<战役ID>-<时间>-<PID>\
```

其中 `reports\REPORT.md` 是逐章转换报告，`scripts\` 是还原并修复后的 JASS。

## 数据版本边界

KK 图形工具固定保留源图的 `war3map.w3i` 和对象数据版本，不再要求在这里选择
经典版或重制版。输出使用 `<战役标题>（提取版）.w3n`：

```text
平台原图 -> KK 提取/单机兼容整理（保留源版本）
         -> ALAS 目标客户端选择、Reforged v31+/2/2 数据迁移
         -> ALAS 装备、背包和对象注入
```

命令行仍保留 `--target classic|reforged`，只作为独立单机兼容构建的显式兼容路径；
正常交接 ALAS 时不使用该参数。

## 清源推导模式

勾选“清源推导模式（忽略历史战役插件）”后，工具不会套用旧 sentinel、旧剧情单位修复、
旧对象补丁或重制版兼容容器。商城 key 则单独遵循已验证的源 SHA 商品策略：
商店可兑换商品为 `true`，陷阱和哨兵 key 为 `false`，未知 key 默认 `false`。
转换器仍会执行通用平台 native 替换、静态门禁和原图扫描，并输出：

```text
<战役标题>（清源推导版）.w3n
<战役标题>（清源推导版·经典版）.w3n
```

该模式用于从干净 KK 原图重新验证问题。报告中的 `clean_rederive` 字段会记录本次
是否绕过了历史战役插件。

清源模式还会按行为扫描所有章节，只中和同时满足以下条件的触发器：

- 条件包含 `DzAPI_Map_HasMallItem`；
- 动作枚举 `Player(0)` 全部单位；
- `ForGroupBJ` 回调直接 `RemoveUnit(GetEnumUnit())`。

普通剧情目标死亡、保护单位失败和其他非商城清场不会被这条规则修改。

## 加载画面与结算背景

重制版默认启用“修复重制版加载画面和结算背景”。工具会识别自定义
loading-screen MDX 及其单块或四分块纹理，生成 1024×576 的 16:9 版本：

- 原图按原始比例完整居中，不做横向拉伸；
- 先按作者原始 4:3 模型比例恢复源图被压进正方形纹理的横向内容；
- 两侧使用同画面的模糊、暗化延伸填满；
- 章节加载模型扩展到 16:9；
- 战役背景模型扩展到完整结算画面；
- 经典版不执行该重制版布局修复。

如需保留作者原始画面，可取消该选项，或在命令行添加 `--skip-loading-art`。

## 禁用态图标

工具会扫描战役级和章节级对象数据，包括 `war3campaign.*`、
`war3campaignSkin.*`、`war3map.*`、`war3mapSkin.*`，以及地图自定义文本对象表。
扫描字段覆盖技能、物品、单位、Buff、可破坏物和升级图标。章节本地对象引用的
图标如果位于父战役档案，也会回退读取并生成本地禁用态别名。

该修复同时应用于重制版和经典版导出，不再只修复战役级对象。

## 永久装备充能

对象数据阶段会按名称、描述和主动技能识别永久装备。对仍继承有限使用次数
（`iuse > 0`）的神器、套装、军团手环和同义装备统一改为 `iuse=0`。
药水、卷轴、食物、任务材料、兑换券和其他明确消耗品保持原次数。

该规则同时作用于战役级和合并后的章节级 `w3t` 数据，并逐项做写回验证。

## 燃烧之怒清源专用保护

清源模式会扫描 `ransao03.w3m` 中注册到能量产生器 `gg_unit_npgr_0732` 的
`EVENT_UNIT_DEATH` 动作，只中和其中的 `CustomDefeatBJ` 和清空 `Player(0)`
全部单位的动作；同时停用 `URIZZ4` 分支在 10 秒后对 `udg_xxxx` 施加的
`UnitApplyTimedLifeBJ`。触发器、单位和其他剧情动作保持不变。这里不再使用无敌，
因为无敌无法阻止脚本主动判负、清场或限时生命。该规则只在对应源 SHA 和该章节生效。

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

## 与 ALAS 改图工具的职责边界

KK 工具不再提供“移除地图自带的切换背包能力”选项。原作者切换技能、目标数据版本
迁移、Reforged 2/2 数据基线、替代背包注入和最终对象校验统一由 ALAS 离线改图工具
处理。

KK 工具只负责从平台原图恢复章节和脚本，并提供可供 ALAS 继续修改的洁净战役源。
各战役的切换技能 ID 仍保存在独立战役清单中，由 ALAS 按章节集合识别后应用，不能
按其他地图的 ID 猜测。

## 快捷方式刷新

图形工具每次启动都会调用 `install_shortcut.ps1` 刷新桌面快捷方式。更新源码后
也可以手动执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
  -File tools\kk-singleplayer\install_shortcut.ps1
```

快捷方式始终指向当前工作区的 `.venv\Scripts\pythonw.exe` 和图形入口，不依赖固定版本号。

## 战役目录浏览

图形工具现在以“选择战役目录”为主流程：

- 递归扫描所选目录中的 `.w3n`，自动忽略 `_singleplayer_work`、`_replaced` 等生成目录；
- 在列表中读取并显示战役内部名称、章节数、文件大小、修改时间和相对路径；
- 支持单选、多选、全选和清空选择，只有列表中选中的战役会进入转换；
- 战役标题按路径、大小和修改时间缓存，未变化的文件再次打开时无需重新解析；
- 列表身份读取不计算完整 SHA-256，真正开始转换时才计算和校验源文件。

仍可通过“选择单个 W3N”保留单文件入口。

## 命令行

批量或自动化调用仍可直接使用底层入口：

```powershell
.\.venv\Scripts\python.exe tools\war3map-injector\campaign_singleplayer.py `
  "H:\Games\War3\Campaigns\dz\209521.w3n" --overwrite `
  --clean-rederive
```

在图形界面多选战役时，底层使用精确文件列表参数，不依赖标题或文件名模糊匹配：

```powershell
python tools\war3map-injector\campaign_singleplayer.py "H:\Games\War3\Campaigns\dz" `
  --campaign-file "H:\Games\War3\Campaigns\dz\194213.w3n" `
  --campaign-file "H:\Games\War3\Campaigns\dz\209521.w3n"
```

运行游戏验证前，请按工作区规则停止并交给用户手动测试。
