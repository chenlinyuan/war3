# Lost Temple 改图工作总结

> 本文档总结在官方地图 **Lost Temple (4)** 上做的全部改动，供后续会话（如移植伏魔战记的翅膀/坐骑系统）参考。

## 一、成果概览

在 Lost Temple 上注入了**装备/技能/单位/致命一击/死亡之指**系统，并新增了自定义装备 **阿克蒙德之手**。

**部署位置**：`H:\Games\War3\Maps\mod\`
| 文件 | 说明 |
| --- | --- |
| `LostTemple_ft_装备技能版.w3x` | 基础注入版（装备/技能/单位/暴击/死亡之指） |
| `LostTemple_ft_阿克蒙德之手.w3x` | 含自定义装备「阿克蒙德之手」的完整版 |

**工程文件**：`maps/LostTemple/`
| 文件 | 说明 |
| --- | --- |
| `LostTemple_ft.original.w3x` | 原始地图（246,345 字节，**注意：此文件其实已含旧版注入脚本**） |
| `LostTemple_ft_hand.w3x` | 当前工作地图（含全部改动，347,158 字节） |
| `LostTemple_ft.w3x` | 基础注入版 |
| `README.md` | 详细说明 |

## 二、阿克蒙德之手（自定义装备）

| 属性 | 实现 |
| --- | --- |
| 物品 ID | `I000`（基于基础物品 `gcel` 加速手套） |
| 攻击力 | **+50%**（技能 `A001`「阿克蒙德之力」，基于 `AIar` 物品版强击光环） |
| 攻击速度 | **+100%**（技能 `A002`，基于 `AIsx`） |
| 主动技能 | **死亡之指**（技能 `A000`，秒杀，快捷键 F） |
| 图标 | `BTNCorpseExplode.blp` |
| Buff | 覆盖原版 `BEar`（强击光环 buff），名称「阿克蒙德之力」 |

**游戏内获取**：`additem I000` 或 `additem 阿克蒙德之手`

## 三、关键技术要点（踩坑记录）

### 1. w3t（物品对象数据）格式
- `version(4)=2 + origCount(4) + [entries] + customCount(4) + [entries]`
- entry = `oldId(4) + newId(4) + modCount(4) + [mods]`
- **CRITICAL：w3t 的 mod 格式与 w3a 不同！**
  - w3a（技能）：`modId(4) + type(4) + variation(4) + dataPointer(4) + value + endMarker(4)` ← 3 字段
  - w3t（物品）：`modId(4) + type(4) + value + endMarker(4)` ← **1 字段**
  - 用错格式 → 游戏回退到基础物品数据（症状：显示基础物品名/属性）

### 2. 物品字段 ID
- **名称/提示用 `unam`/`utip`/`utub`（与单位共用），不是 `inam`/`itip`/`iutb`！**
- 其余：`ides`=描述 `ihot`=热键 `iico`=图标 `icla`=分类 `ilev`=等级 `igol`=金币 `ihtp`=生命 `iabi`=技能列表 `iusa`=主动使用

### 3. 百分比攻击力
- War3 **没有被动百分比攻击技能**，但有**光环**：
  - **`AIar`（ItemAuraTrueshot，物品版强击光环）**：数据字段 `Ear1`（unreal，0.5=+50%）
  - **近战/远程开关**：`Ear2`=近战开关（bool），`Ear3`=远程开关（bool）。原版默认 `Ear2=0`（近战关）/`Ear3=1`（远程开）→ **只对远程生效**。要近战也生效须显式设 `Ear2=1`
- `AIat`（AttackBonus）只能加固定值（`Iatt`）
- `AIaa`（AttackMod）是"使用后永久加攻"（知识之书类），非被动

### 4. 光环显示来自 buff，不是技能
- **光环（Aura）的名称/提示/图标显示来自 buff 对象（`war3map.w3h`），不是技能 w3a！**
- buff 字段：`fnam`=名称 `fnsf`=后缀 `ftip`=提示 `fube`=扩展提示 `fart`=图标 `ftat`=目标美术
- **改 buff 的两种方式**：
  - (a) 自定义 buff（`customCount=1`，如 `BEar`→`B000`）+ 技能 `abuf=B000`
  - (b) **覆盖原版 buff（`origCount=1`，`BEar`→`BEar`）** ← 更可靠，推荐
- **CRITICAL：buff 图标 `fart` 必须是完整路径**（如 `ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp`），只写文件名会显示绿色方块！

### 5. 物品中文搜索需要 GBK 名
- 游戏聊天输入是 GBK，脚本名是 UTF-8 → 必须同时嵌入 `ib_itemNameGbk[]`（GBK 字节）
- `build_fj.py` 用 `@@IGBK<idx>@@` 占位符注入 GBK 字节

### 6. HKE 注入工具
- 工具：`H:\Games\War3\Tools\151个常用脚本\脚本\HKE1.25(5.17美化版）\HKE1.25(5.17美化版）\HkeW3mModifier2.0.exe`
- 脚本注入：`python tools/war3map-injector/inject_map.py <地图> scripts/item-browser`
- 任意文件注入：`python tools/war3map-injector/inject_file.py <地图> <源文件> <内部名>`
- 提取文件：`python tools/war3map-injector/extract_one.py <地图> <内部名>`
- **用完必须 `taskkill /IM HkeW3mModifier2.0.exe /F`**

## 四、工具清单（tools/war3map-injector/）

| 工具 | 用途 |
| --- | --- |
| `inject_map.py` | 注入脚本（f.j/g.j/m.j）到地图 |
| `inject_file.py` | 注入任意内部文件（w3a/w3t/w3h） |
| `extract_one.py` / `extract_to.py` | 提取地图内指定文件 |
| `extract_all.py` | 解压地图全部文件 |
| `gen_w3t.py` | 生成物品（war3map.w3t） |
| `gen_w3a.py` / `gen_w3a_finger.py` / `gen_w3a_crit.py` | 生成技能（war3map.w3a） |
| `gen_item_abils.py` | 生成物品技能（攻击力光环+攻速） |
| `gen_w3h.py` | 生成/覆盖 buff（war3map.w3h） |
| `merge_w3a.py` | 合并多个 w3a |
| `verify_w3obj.py` | 验证 w3a/w3t/w3h 结构（自动探测 3/1 字段格式） |
| `collect_items.py` / `collect_skills.py` / `collect_units.py` | 收集物品/技能/单位列表 |
| `build_fj.py` | 把列表嵌入 f.j |
| `deploy_mod.py` | 部署到 mod 文件夹 |
| `dump_ability.py` | 解析 abilitydata.slk |

## 五、脚本系统（scripts/item-browser/）

- `f.j`：主逻辑（装备/技能/单位/暴击/死亡之指系统）
- `g.j`：全局变量
- `m.j`：入口（`call IB_Init()`）
- 命令：`search` / `additem` / `addskill` / `removeskill` / `listskill` / `listunit` / `addunit` / `removeunit` / `criton` / `critoff` / `deathfinger` / `itembrowser`

## 六、复现步骤（从原始地图）

```powershell
# 1. 准备物品/技能/单位列表（按地图生成）
python tools/war3map-injector/collect_items.py "<解压目录>"
python tools/war3map-injector/collect_skills.py "<解压目录>"
python tools/war3map-injector/collect_game_units.py
python tools/war3map-injector/build_fj.py

# 2. 生成物品/技能/buff 数据
python tools/war3map-injector/gen_w3t.py tools/war3map-injector/_hand.w3t
python tools/war3map-injector/gen_item_abils.py tools/war3map-injector/_hand_abil.w3a 0.5 1.0
python tools/war3map-injector/merge_w3a.py tools/war3map-injector/_lt_hand.w3a `
    tools/war3map-injector/_lt_both.w3a tools/war3map-injector/_hand_abil.w3a
python tools/war3map-injector/gen_w3h.py tools/war3map-injector/_hand_buff.w3h

# 3. 注入（脚本 → w3a → w3t → w3h）
python tools/war3map-injector/inject_map.py "maps/LostTemple/LostTemple_ft_hand.w3x" scripts/item-browser
python tools/war3map-injector/inject_file.py "maps/LostTemple/LostTemple_ft_hand.w3x" tools/war3map-injector/_lt_hand.w3a war3map.w3a
python tools/war3map-injector/inject_file.py "maps/LostTemple/LostTemple_ft_hand.w3x" tools/war3map-injector/_hand.w3t war3map.w3t
python tools/war3map-injector/inject_file.py "maps/LostTemple/LostTemple_ft_hand.w3x" tools/war3map-injector/_hand_buff.w3h war3map.w3h

# 4. 部署
python tools/war3map-injector/deploy_mod.py "maps/LostTemple/LostTemple_ft_hand.w3x" "LostTemple_ft_阿克蒙德之手.w3x"
```

## 七、伏魔战记翅膀/坐骑系统（初步调研）

**地图**：`maps/伏魔战记.w3x.original`（2,207,946 字节）

**初步发现**：
- 脚本 `war3map.j`（959,209 字节，**纯 JASS**，以 `globals` 开头）
- 有 `war3map.w3a`（42,390 字节，技能），**无 `war3map.w3u`**（单位）
- 翅膀相关资源：`wingofthelucifer.mdx`、`doomgguardwings.mdx`、`wingblack4.blp`、`fwing.blp`、`fwind.mdx`
- 脚本中"翅膀"只出现 1 次（是"翅膀或天使手镯每样只能拿一件"的重复物品检查）
- **推断**：翅膀/坐骑是**物品**（item），效果通过**物品技能**实现（可能用 `AddSpecialEffectTarget` 挂翅膀模型，或变身）

**新会话建议**：
1. 先解压 `maps/伏魔战记.w3x.original`，分析 `war3map.w3a`（技能）和物品定义
2. 搜索脚本里的物品拾取事件（`EVENT_PLAYER_UNIT_PICKUP_ITEM`）和模型挂载（`AddSpecialEffectTarget`/`SetUnitModel`）
3. 找到翅膀/坐骑的物品 ID 和对应的模型/技能
4. 用本工程的 `gen_w3t.py`/`gen_w3h.py`/`inject_file.py` 把翅膀/坐骑系统移植到 Lost Temple

**注意**：伏魔战记脚本是**纯 JASS**（无 j2b 加密），比英灵传说好处理。
