# item-browser · 装备与技能系统

在任意 War3 地图中通过**聊天输入框**搜索/添加装备、搜索/添加/移除/设置技能。

> ⚠️ **War3 1.27 无法输入中文**（游戏内聊天框不支持输入法）。
> 中文命令参数需要能输入中文的环境（如粘贴、第三方输入工具）。

## 功能（已验证）

### 装备

| 命令 | 说明 |
| --- | --- |
| `search <关键词>` / `listitem <关键词>` | 搜索名称包含关键词的装备（最多 20 条） |
| `additem <名称>` | 给**当前选中的英雄**添加 1 个装备（背包满则掉地上） |
| `additem <名称> <数量>` | 添加指定数量 |
| `additem <物品ID>` | 按 ID 添加（区分同名，如 `additem I000`） |
| `itembrowser` | 显示帮助与已加载装备数量 |

### 技能

| 命令 | 说明 |
| --- | --- |
| `listskill <关键词>` | 搜索名称包含关键词的技能（最多 30 条） |
| `addskill <名称> [等级]` | 给选中英雄添加技能（默认 1 级） |
| `removeskill <名称>` | 移除选中英雄的指定技能 |
| `setskill <名称> <等级>` | 设置选中英雄指定技能的等级 |

## 使用示例

```
search 吸血          → 列出所有名称含"吸血"的装备
additem 吸血面罩      → 给选中英雄添加「吸血面罩」
additem 吸血面罩 3    → 添加 3 个
additem I000         → 按 ID 添加
listskill 火         → 列出所有名称含"火"的技能
addskill 火球术 5     → 给选中英雄添加 5 级「火球术」
removeskill 火球术    → 移除「火球术」
setskill 火球术 10    → 把「火球术」设为 10 级
```

## 工作原理（进游戏立即可用）

物品/技能的 **ID + 名称** 在**注入时预先扫描并硬编码**到脚本中，因此：

- **进游戏立即可用**（无需等待枚举）
- 搜索直接匹配**预扫描的名称**，不依赖 `GetObjectName`
  （自定义对象名称可能返回空，故必须内嵌名称）
- 数量大时分帧填充（`IB_FillStep` / `IB_SkillFillStep`），避免单帧操作数超限

### 数据来源

- **装备**：`tools/war3map-injector/collect_items.py`
  1. 游戏标准物品：`units\itemdata.slk`
  2. 地图自定义物品：地图内 `units\itemfunc.txt` / `itemdata.slk`
- **技能**：`tools/war3map-injector/collect_skills.py`
  1. 地图 `war3map.w3a`（自定义技能，锚定 `anam` + 名称，ID 在名称前 16 字节）
  2. 游戏 `AbilityStrings`（8 个种族文件）

> ⚠️ 不同地图的自定义对象不同，**每张地图都要重新运行收集脚本**。

### 为某张地图生成列表

```powershell
# 1. 解压地图全部文件
python tools/war3map-injector/extract_all.py "maps/你的地图.w3x"

# 2. 收集装备 / 技能 ID 与名称
python tools/war3map-injector/collect_items.py "maps/你的地图"
python tools/war3map-injector/collect_skills.py "maps/你的地图"

# 3. 把列表嵌入 f.j（ID + 名称）
python tools/war3map-injector/build_fj.py
```

## 编码要求（重要）

War3 1.27 的 JASS 解析器按 **UTF-8** 读取脚本字符串字面量。
本目录的 `.j` 文件以 **UTF-8** 保存，`inject_map.py` 默认按 UTF-8 注入。
若注入 GBK 中文，游戏会把 GBK 字节当作非法 UTF-8，导致字符串被截断，搜索/添加全部失效。

## 文件结构

```
scripts/item-browser/
├── f.j    # 函数定义（构建后约 210KB，含内嵌 ID/名称）
├── g.j    # 全局变量
├── m.j    # 入口调用（IB_Init）
└── README.md
```

## 注入方法

```powershell
python tools/war3map-injector/inject_map.py "maps/你的地图.w3x"
```

> 若地图 globals 以 `constant` 开头（如 6.9），注入后还需运行：
> ```powershell
> python tools/war3map-injector/fix_globals_order.py "maps/你的地图.w3x"
> ```

详见 [`../../tools/war3map-injector/README.md`](../../tools/war3map-injector/README.md)。

## 代码结构

### 全局变量（g.j）

- 装备：`ib_itemList[]`、`ib_itemName[]`、`ib_itemCustom[]`、`ib_itemCount`、搜索/添加状态
- 技能：`ib_skillList[]`、`ib_skillName[]`、`ib_skillCustom[]`、`ib_skillCount`、填充/搜索/添加/移除/设置状态
- 注册：`ib_regTimer`

### 主要函数（f.j）

| 类别 | 函数 |
| --- | --- |
| 通用 | `IB_LowerAscii`、`IB_StrEqCI`、`IB_Message`、`IB_SkillMessage`、`IB_Char`、`IB_IdStr`、`IB_NameMatch`、`IB_GetSelectedUnit`、`IB_BoolStr` |
| 装备 | `IB_Search`/`IB_SearchStep`、`IB_AddItem`/`IB_AddStep`/`IB_AddGive`、`IB_ParseAddItem`、`IB_CountMatch`、`IB_ItemName` |
| 技能 | `IB_SkillName`、`IB_SkillGive`、`IB_SkillAddStep`、`IB_AddSkill`、`IB_SkillRemove`/`IB_SkillRemStep`、`IB_RemoveSkill`、`IB_SkillSearchStep`、`IB_SkillSearch`、`IB_ParseAddSkill`、`IB_ParseRemoveSkill`、`IB_SkillSetLevel`/`IB_SkillSetStep`、`IB_SetSkill`、`IB_ParseSetSkill` |
| 分发/注册 | `IB_OnChat`、`IB_RegisterChat`..`IB_RegisterChat6` |
| 入口 | `IB_Init` + `IB_FillStep` + `IB_SkillFillStep`（由 `build_fj.py` 生成） |

## 注意事项

1. **多人游戏**：填充使用同步计时器，不会 desync；但命令只对输入者生效。
2. **地图兼容性**：部分地图有反作弊机制，可能阻止脚本运行。
3. **聊天注册上限**：部分地图（如 6.9）聊天事件数量接近上限，需分帧注册
   （`IB_RegisterChat` 链式 TimerStart）。
4. **名称**：需使用游戏内显示的名称（中文/英文取决于地图语言），或直接用 ID。

## 参考

- 注入工具：[`../../tools/war3map-injector/`](../../tools/war3map-injector/)
- HKE 作弊激活：[`../../docs/HKE作弊激活说明.md`](../../docs/HKE作弊激活说明.md)
