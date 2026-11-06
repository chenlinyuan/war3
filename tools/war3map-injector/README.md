# war3map-injector · War3 地图脚本/数据注入工具

把自定义 JASS 脚本与对象数据（w3a/w3t/w3h/…）注入任意 War3 地图，
支持加密/保护地图。

## 一句话现状

**首选 `inject_native.py`：不开 GUI，原生写 MPQ，几秒完成，一次替换脚本 + 任意多个内部文件。**
它的容器被游戏自带的 Storm.dll 校验过（`sfmpq_probe.ps1`：逐文件开门 + md5 与本地一致），
可以放心用。`inject_all.py`（一次 HKE 会话）作为备选，遇到容器脾气怪的图再上。
更旧的 `inject_map.py` / `inject_file.py` 每次调用都要完整开关一次 HKE，已不推荐（保留可用）。

```powershell
# 原生注入：脚本 + 对象数据 + 模型，一次写入（秒级）
python tools/war3map-injector/inject_native.py maps/LostTemple/LostTemple_wings.w3x `
    --script scripts/wings `
    --file tools/war3map-injector/_wing.w3a=war3map.w3a `
    --file tools/war3map-injector/_wing_item.w3t=war3map.w3t `
    --deploy LostTemple_wings.w3x
```

```powershell
# 脚本 + 三个对象数据，一次会话搞定（实测约 30s，旧流程 100s+）
python tools/war3map-injector/inject_all.py "maps/LostTemple/LostTemple_ft_hand.w3x" --script `
    --file tools/war3map-injector/_lt_hand.w3a=war3map.w3a `
    --file tools/war3map-injector/_hand.w3t=war3map.w3t `
    --file tools/war3map-injector/_hand_buff.w3h=war3map.w3h `
    --deploy "LostTemple_ft_阿克蒙德之手.w3x"
```

## 关于"要不要用 HKE"

2026-10-11 复测：`war3mpq.py` 现在可以正常读这些图（哈希/块表、加密条目、
`HM3W` 头、单块/分块文件都能处理），`mpq_patch.py` 写出的档案也能被
游戏自带的 `Storm.dll` 完整读取。所以**纯 Python 路线是可行的，也是默认路线**；
HKE 只在两种情况下需要：图里有本工具不认识的压缩方式，或需要 HKE 自带的重压缩。

## 工具清单

### 推荐使用

| 文件 | 用途 |
| --- | --- |
| `apply_reforged_migration.py` | **实验性 Reforged 数据迁移**：逐章把 `map-info v25-v30` 升级到 `v31+`，设置 Reforged 数据 `2/2`，战役章节保持原样存储，并逐章回读校验 |
| `campaign_singleplayer.py` | **KK/KKWE 战役单机修复入口**：批量提取章节、还原 JASS、拆平台门禁、修已知卡关/清场/掉落问题、清内层 MPQ platform 位、pjass + Map Doctor + Storm 校验，并输出可供 ALAS 离线工具继续加工的 `.w3n` |
| `inject_native.py` | **原生写入（推荐）**：不开 HKE，几秒完成脚本 + 文件替换；写入后自动读回校验。`--store <内部名>` = 原样存储（战役 .w3n 的章节**必须**这样写，否则游戏打不开章节）|
| `mpq_patch.py` | 原生 MPQ 写入器（保留全部老条目 + 重写哈希/块表）|
| `jass_gate.py` | 构建期门禁：pjass 对比注入前后，出现**新的错误类型**就拒绝写出 |
| `check_locals.py` | JASS 硬规则审计：任何函数里"语句出现在 local 之前"都会点名 |
| `fix_main_locals.py` | 修复类工具：把 main 里位置不对的 local 搬回函数头部 |
| `sfmpq_probe.ps1` | 用 SFmpq.dll → **游戏自带 Storm.dll** 验容器（32 位 PowerShell 运行）|
| `sfmpq_subarchive.ps1` | 验"归档里的归档"能否打开——**战役 .w3n 能否进游戏的关键判据** |
| `inject_all.py` | **一键批量注入**：一次会话完成脚本 + 任意多个内部文件替换 |
| `hke_session.py` | HKE 会话层（供上面两个脚本复用，也可被自己的脚本 import） |
| `verify_inject.py` | 注入后校验：另开一次会话解压，检查标记与逐字节一致性 |

`inject_all.py` 常用参数：

| 参数 | 说明 |
| --- | --- |
| `--script [DIR]` | 注入 DIR 的 f.j/g.j/m.j（默认 `scripts/item-browser`） |
| `--file SRC[=内部名]` | 替换地图内部文件，可重复；内部名省略时取文件名 |
| `--script-mode manual\|native\|auto` | 默认 `manual`（自己拼脚本，最稳） |
| `--deploy NAME` | 成功后复制到 `H:\Games\War3\Maps\mod\NAME`（自动清同名前缀旧版本） |
| `--list` | 只列出地图内部文件（诊断用） |
| `--recompress` | 额外点一次「重压缩」（默认不点，见下文） |
| `--kill-stale` | 开始前清理上一次被强杀残留的 HKE 进程 |

### 仍可用（旧流程）

| 文件 | 用途 |
| --- | --- |
| `inject_map.py` | 单次脚本注入（一次开关工具） |
| `inject_file.py` | 单次文件替换（一次开关工具） |
| `inject_script_manual.py` | 自己拼脚本再替换 war3map.j（YDWE 图必需，已被 inject_all 吸收） |
| `inject_campaign_chapters.py` | 批量注入战役各章节脚本 |
| `replace_campaign_chapters.py` | 把改好的章节替换回 .w3n |
| `fix_globals_order.py` | 把自定义变量移到 constant 之后（已被 inject_all 的 native 模式吸收） |

### 数据生成 / 解析

| 文件 | 用途 |
| --- | --- |
| `gen_w3t.py` / `gen_w3a.py` / `gen_w3a_finger.py` / `gen_w3a_crit.py` | 生成物品/技能（war3map.w3t / w3a） |
| `gen_item_abils.py` | 生成物品技能（攻击力光环/攻速） |
| `gen_w3h.py` | 生成/覆盖 buff（war3map.w3h） |
| `add_warglaive_lt30.py` | 向 Reforged LT 成品加入埃辛诺斯战刃、敏捷成长攻速、能力、图标和物品浏览器条目 |
| `merge_w3a.py` / `append_w3obj.py` | 合并/追加 w3obj（append 会保留目标 origCount） |
| `collect_items.py` / `collect_map_items.py` / `collect_skills.py` / `collect_units.py` | 收集物品/技能/单位清单 |
| `build_fj.py` | 把清单嵌入 f.j |
| `validate_dir.py` | 用 pjass 校验脚本目录 |
| `deploy_mod.py` | 部署到 `H:\Games\War3\Maps\mod` |

### 校验 / 排查

| 文件 | 用途 |
| --- | --- |
| `audit_item_copy.py` | 检查神器说明颜色/顺序、冰封践踏冷却隔离和半透明冰封清理 |
| `_objcmp.py` | 比对改写前后的对象数据"原始条目"是否被动过 |
| `check_locals.py` / `jass_gate.py` | 见上（脚本层） |
| `strip_crit.py` | 摘掉图里旧的 criton 暴击系统（带 pjass 门禁） |
| `verify_map.py` / `verify_inject.py` / `verify_w3obj.py` | 各自的读回校验 |

踩坑记录见 `docs/06-工具链/地图载入校验.md`（"找不到地图或者损毁"排查手册）。

## Reforged 数据迁移

仅用于需要 Reforged `map-info v31+` 功能、但源地图仍是 `v25-v30`
的兼容性测试。迁移只修改工作副本中的 `war3map.w3i`，不会升级脚本或资源，
也不能证明 Reforged 基础数据下的剧情、单位和章节切换仍然正常。

```powershell
python tools\war3map-injector\apply_reforged_migration.py `
  "C:\path\legacy.w3n" `
  --output "C:\path\legacy-migrated.w3n" `
  --work "C:\path\legacy-migration-work"
```

低于 `map-info v25`、缺少 `war3map.w3i` 或无法解析的章节会被拒绝。

## KK/KKWE 战役单机化 + 已知卡关修复

`campaign_singleplayer.py` 是本仓库面向 KK/KKWE 平台战役的统一入口。它只做
单机兼容和已知作者陷阱修复，不添加物品、翅膀、英雄或其他 ALAS 内容；生成的
`.w3n` 应作为 ALAS 离线工具的干净输入。

```powershell
# 处理一个目录里的全部 .w3n
python tools\war3map-injector\campaign_singleplayer.py "H:\Games\War3\Campaigns\dz"

# 或只处理一部战役
python tools\war3map-injector\campaign_singleplayer.py "H:\Games\War3\Campaigns\dz\194213.w3n"

# 只提取并修复章节，不重新打包 .w3n
python tools\war3map-injector\campaign_singleplayer.py "H:\Games\War3\Campaigns\dz" --extract-only
```

默认输出：

```text
<源目录>\singleplayer\             最终 .w3n
<源目录>\_singleplayer_work\       原始章节、修复章节、脚本、报告
```

每一步都从原始 `.w3n` 重新提取，不会在已经注入过的成品上二次施工。主要处理：

- KKWE `kkmap.jc` 还原为 JASS；
- `DzAPI_*`、`EX*`、`RequestExtra*`、`LBK*`、`Blz*`、`JAPI*` 平台 native 就地存根；
- 拆 `DzAPI_Map_IsMapTest` 防盗版/反破解失败陷阱；
- 按触发器走法区分试玩/付费门禁与正常剧情结束，只中和平台相关结束点；
- 修复商城福利清场、宠物领取删主角、任意英雄（含宠物）死亡误判负；
- 修复跨章节存档污染、错误进度分支、关键机关/预置 BOSS 删除、遗漏掉落；
- 修复黑屏过场和单人入口缺少任务句柄保护；
- 清零每章 MPQ 哈希表的 `wPlatform`，章节在外层战役中原样存储；
- 每章执行 pjass、Map Doctor 1.27/Reforged 检查，并对整个成品执行 Storm
  外层读取和逐章 `open-as-archive` 校验。

这里不会自动执行章节结束用的 `GO` 聊天命令。原作者用平台的“过关”按钮发送
`GO`，单机版仍保留聊天触发器；若某章任务完成但未自动切章，在聊天框输入
`GO`。自动定时触发曾被证实会因任务对象尚未创建而误触发结局，因此没有把它
作为默认修复。

## 环境要求

- Windows + Python 3.8+（本机 `C:\Python313\python.exe`）
- `HkeW3mModifier2.0.exe`，路径见 `inject_map.py` 的 `TOOL` 常量
  （`H:\Games\War3\Tools\151个常用脚本\脚本\HKE1.25(5.17美化版）\...`）

## 脚本三部分约定

| 文件 | 注入位置 | 内容 |
| --- | --- | --- |
| `g.j` | `globals ... endglobals` 内（所有 `constant` 之后） | 全局变量 |
| `f.j` | `function main` 之前 | 函数定义 |
| `m.j` | `function main` 开头 | 初始化调用 |

### 编码

本仓库脚本以 **UTF-8** 保存，注入时**按字节原样嵌入**，不做转码。
（`ib_unitNameGbk` 等数组内嵌的是原始 GBK 字节，整体转码会破坏它。）
War3 1.27 按 UTF-8 解析字符串字面量，UTF-8 中文正常；用 `IB_ENCODING` 可覆盖。

## 实测要点（重要，务必先读）

完整记录见 [`docs/06-工具链/HKE行为实测.md`](../../docs/06-工具链/HKE行为实测.md)，
这里只列最容易踩的几条：

1. **「重压缩」可以不用。** 点「添加/替换文件」时地图文件当场就已写好；
   再点「重压缩」实测 30s 内文件毫无变化。工具自带提示
   「重压缩卡死可试试修复MPQ头」，旧脚本点完只等 6~8s 就 `taskkill`，有写坏图的风险。
2. **添加文件前必须先点「自定义文件」。** 默认的「Jass脚本」会把目标名强行
   设成 `war3map.j`，连续替换 w3a/w3t/w3h 会把三个文件全写进 `war3map.j`。
3. **目标名只取文件名。** 源文件要先复制成"文件名 == 内部名"
   （如 `_rep\war3map.w3a`）再选。
4. **列表选择要补发 `LBN_SELCHANGE`。** 只发 `LB_SETCURSEL` 的话，
   「解压文件」会解出上一次的文件。
5. **会话别做太多事。** 多次替换后「解压文件」会失灵（工具说明自己写着
   「不稳定就重启」）。所以：先解压读取，再替换写入；校验另开会话。
6. **别用 `taskkill /IM`。** 会杀掉用户自己开的 HKE；应只结束自己启动的 PID。

## 校验注入

```powershell
python tools/war3map-injector/verify_inject.py "maps/LostTemple/LostTemple_ft_hand.w3x" `
    tools/war3map-injector/_hand.w3t=war3map.w3t
```

输出示例：

```
war3map.j 445714 字节: IB_Init 定义=True, call IB_Init()=1 处, 变量顺序正确=True
war3map.w3t          509 字节, 与源文件一致=True
=== 校验通过 ===
```

## 大批量场景（战役 `血色使命`）

```powershell
# 逐章注入脚本（脚本在本地拼好，绕开 HKE 的 endglobals 重复插入 bug）
python tools/war3map-injector/inject_all.py "maps/campaign/chapter1.w3x" --script

# 战役级共享数据一次替换，而不是每章开一次工具
python tools/war3map-injector/inject_all.py "<战役>.w3n" --no-script `
    --file tools/war3map-injector/_camp_hand.w3a=war3campaign.w3a `
    --file tools/war3map-injector/_camp_hand.w3t=war3campaign.w3t
```

## 仍然需要人工判断的两件事

- **加密类型**：`KKWE 保护`（如 `侏罗纪世界 轮回`）无法注入，HKE 报告"注入成功"
  但 `war3map.j` 不会变，属正常现象。
- **脚本体积**：War3 1.27 的脚本执行上限约 3MB，超了要换更小的图或精简脚本。

## 参考

- HkeW3mModifier2.0（HKE，2010）
- [`docs/06-工具链/地图脚本注入.md`](../../docs/06-工具链/地图脚本注入.md)
- [`docs/06-工具链/HKE行为实测.md`](../../docs/06-工具链/HKE行为实测.md)

## 许可

仅用于**学习与个人单机游戏**，请勿用于作弊或侵犯他人作品。
