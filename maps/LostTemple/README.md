# Lost Temple · 改图工程

在官方对战地图 **Lost Temple (4)** 上注入装备搜索/添加系统。

## 阿克蒙德之手（自定义装备）

在 Lost Temple 上新增了一件自定义装备 **阿克蒙德之手**（物品 ID `I000`）：

| 属性 | 值 |
| --- | --- |
| 基础物品 | `gcel`（加速手套 Gloves of Haste） |
| 攻击力 | **+50%**（技能 `A001`，基于 `AIaa` AttackMod，数据字段 `Iaa1`=50） |
| 攻击速度 | +100%（技能 `A002`，基于 `AIsx`） |
| 主动技能 | 死亡之指（技能 `A000`，秒杀目标单位，1,000,000 伤害，快捷键 F） |
| 图标 | `BTNCorpseExplode.blp` |
| 分类 | Artifact，等级 8，售价 1000 |

> **百分比攻击力**：`AIaa`(AttackMod) 是 War3 标准的**百分比攻击力**技能，数据字段 `Iaa1` 为整数百分比（50 = +50%），作用于英雄的**基础攻击力**（含主属性加成）。

**生成/注入流程**：

```powershell
# 1. 生成物品 w3t（基础物品 gcel，技能 A001,A002,A000）
python tools/war3map-injector/gen_w3t.py tools/war3map-injector/_hand.w3t

# 2. 生成物品技能 w3a（攻击力 A001 + 攻击速度 A002）
python tools/war3map-injector/gen_item_abils.py tools/war3map-injector/_hand_abil.w3a 500 1.0

# 3. 合并技能 w3a（死亡之指 A000 + 致命一击 Azcr + A001 + A002）
python tools/war3map-injector/merge_w3a.py tools/war3map-injector/_lt_hand.w3a `
    tools/war3map-injector/_lt_both.w3a tools/war3map-injector/_hand_abil.w3a

# 4. 注入脚本 + w3a + w3t（用 HKE「添加/替换文件」）
python tools/war3map-injector/inject_map.py "maps/LostTemple/LostTemple_ft_hand.w3x" scripts/item-browser
python tools/war3map-injector/inject_file.py "maps/LostTemple/LostTemple_ft_hand.w3x" tools/war3map-injector/_lt_hand.w3a war3map.w3a
python tools/war3map-injector/inject_file.py "maps/LostTemple/LostTemple_ft_hand.w3x" tools/war3map-injector/_hand.w3t war3map.w3t
```

游戏内使用：`additem I000` 或 `additem 阿克蒙德之手`。

## 文件

| 文件 | 说明 |
| --- | --- |
| `LostTemple.original.w3m` | 原始地图备份（未修改） |
| `LostTemple.w3m` | **已注入脚本**的地图（可游玩） |
| `LostTemple.w3m.bak` | 注入前自动备份 |
| `LostTemple_ft.w3x` | FrozenThrone 目录的同名地图（参考） |

## 原始地图信息

| 项 | 值 |
| --- | --- |
| 名称 | Lost Temple |
| 最大玩家 | 4 |
| 格式 | `.w3m`（混乱之治） |
| 大小 | 245,087 字节 |
| MPQ 头偏移 | 0x200（HM3W 头之后） |
| 加密 | 是（非标准哈希表/块表加密） |

## 注入内容

**脚本**：`scripts/item-browser`（装备 + 技能 + 致命一击 + 单位系统）

**新增功能**：
- `search <关键词>` — 搜索装备（支持中文）
- `additem <名称> [数量]` — 添加装备给选中英雄
- `listskill <关键词>` / `addskill <名称> [等级]` / `removeskill` / `setskill` — 技能系统
- `criton` / `critoff` / `crit` — 致命一击（自定义暴击，50%x2 … 1%x100，EV=4.8x）
- `listunit <关键词>` / `addunit <名称>` / `removeunit [名称]` — 单位系统（搜索/创建/删除）
- `itembrowser` — 显示帮助

**注入后大小**：309,244 字节（+64,157）

> ✅ **进游戏立即可用**：物品（273）、技能（817）、单位（836）列表在注入时预扫描硬编码，无需枚举。
> ⚠️ **脚本编码**：War3 1.27 以 GBK 解析地图脚本。`inject_map.py` 会自动把
> UTF-8 源脚本转为 GBK 再注入，否则中文字符串会破坏解析，导致**加载后回到选图界面**。

> ⚠️ **数据源**：`_itemids.txt` / `_skillids.txt` / `_unitids.txt` 是**按地图生成**的临时文件。
> Lost Temple 是官方地图（无自定义对象数据），因此使用**游戏标准物品/技能/单位**：
> - 物品：273 个（`itemdata.slk` + `itemstrings.txt`）
> - 技能：817 个（8 个种族 `abilitystrings.txt`）
> - 单位：836 个（`unitdata.slk` + `unitbalance.slk` + 各种族 `unitstrings.txt`）
>
> 重新生成（`_lt_tmp` 为不含地图对象数据的空目录）：
> ```powershell
> python tools/war3map-injector/collect_items.py "_lt_tmp"
> python tools/war3map-injector/collect_skills.py "_lt_tmp"
> python tools/war3map-injector/collect_game_units.py
> python tools/war3map-injector/build_fj.py
> ```

## 部署位置

已复制到游戏目录：`H:\Games\War3\Maps\mod\LostTemple_item.w3m`

游戏内「创建自定义游戏 → mod 文件夹」即可看到。

## 复现步骤

```powershell
# 从原始地图重新注入
Copy-Item "LostTemple.original.w3m" "LostTemple.w3m" -Force
python ..\..\tools\war3map-injector\inject_map.py "LostTemple.w3m" ..\..\scripts\item-browser
```

## 验证

注入后，地图的 `war3map.j` 应包含：

```jass
// ITEM BROWSER - 全局变量
integer array ib_itemList
...

// ITEM BROWSER - 装备搜索与添加系统
function IB_Search takes player p, string keyword returns boolean
...

// ITEM BROWSER - 入口
call IB_Init()
```

可用自动化脚本验证：

```powershell
python tools/war3map-injector/verify_map.py "maps/LostTemple/LostTemple.w3m"
```

## 游戏内测试

1. 将 `LostTemple.w3m` 复制到 `H:\Games\War3\Maps\`（或子目录）。
2. 启动 Warcraft III，创建自定义游戏，选择该地图。
3. 等待屏幕提示 **「装备列表加载完成，共 N 件」**（约 2-3 分钟）。
4. 选中一个英雄，输入（**1.27 无法输入中文，用拼音或序号**）：
   ```
   search xxmz          ← 搜索「吸血面罩」等拼音含 xxmz 的装备
   additem 1            ← 添加搜索结果第 1 件
   additem xxmz         ← 或直接按拼音添加
   ```

## 已知限制

- 首次加载需 2-3 分钟枚举物品。
- 部分地图可能有反作弊，可能阻止脚本。
- **War3 1.27 游戏内无法输入中文**，请使用拼音首字母或序号方式。
- 装备名称取决于地图的语言设置。

## 相关

- 脚本源码：[`../../scripts/item-browser/`](../../scripts/item-browser/)
- 注入工具：[`../../tools/war3map-injector/`](../../tools/war3map-injector/)
