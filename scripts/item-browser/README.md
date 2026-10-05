# item-browser · 装备搜索与添加系统

在任意 War3 地图中通过**聊天输入框**搜索和添加装备。

> ⚠️ **War3 1.27 无法输入中文**（游戏内聊天框不支持输入法）。
> 本版本按用户要求**仅保留中文搜索**（`search 吸血` / `additem 吸血面罩`），
> 需要能输入中文的环境（如粘贴、第三方输入工具）。

## 功能

| 命令 | 说明 |
| --- | --- |
| `search <关键词>` | 搜索名称包含关键词的装备（支持中文，最多显示 20 条） |
| `additem <名称>` | 给**当前选中的英雄**添加 1 个装备（背包满则掉地上） |
| `additem <名称> <数量>` | 添加指定数量 |
| `itembrowser` | 显示帮助与已加载装备数量 |

## 使用示例

```
search 吸血          → 列出所有名称含"吸血"的装备
additem 吸血面罩      → 给选中英雄添加「吸血面罩」
additem 吸血面罩 3    → 添加 3 个
itembrowser          → 显示帮助
```

## 工作原理（进游戏立即可用）

物品 ID 列表在**注入时预先扫描并硬编码**到脚本中，因此：

- **进游戏立即可用**（无需等待枚举，之前 2-3 分钟的枚举已移除）
- 物品 ID 来自游戏 `Units\ItemData.slk`（273 个标准物品）
- 搜索时用 `GetObjectName` 获取运行时中文名进行匹配

### 重新生成物品列表

若游戏版本不同或需要自定义物品：

```powershell
# 1. 解析 itemdata.slk 生成 _itemids.txt（见 tools/war3map-injector/_slk 脚本逻辑）
# 2. 把列表嵌入 f.j
python tools/war3map-injector/build_fj.py
```

## 编码要求（重要）

War3 1.27 以 **GBK(ANSI)** 解析地图脚本。本目录的 `.j` 文件以 **UTF-8** 保存，
注入前由 `inject_map.py` **自动转为 GBK**。若手工复制到 `HkeData`，请务必先转 GBK，
否则中文字符串会破坏脚本解析，导致**加载地图后回到选图界面**。

搜索结果会同时显示中文名与拼音，方便对照。

## 工作原理

```mermaid
graph TD
    A[地图启动] --> B[枚举所有物品 ID]
    B --> C[存入 ib_itemList]
    C --> D[提示"装备列表加载完成"]
    D --> E[注册聊天事件]
    E --> F{玩家输入}
    F -->|search| G[遍历列表匹配名称]
    F -->|additem| H[精确匹配名称 → 创建物品]
    G --> I[显示结果]
    H --> J[放入选中单位背包/地上]
```

### 1. 物品枚举

War3 物品 ID 是 4 字符码（FourCC）。脚本通过**四层嵌套**枚举所有可能的 ID：

```
第一层 (ib_idA): 62 种字符 × 256³
第二层 (ib_idB): 62 种字符 × 256²
第三层 (ib_idC): 62 种字符 × 256
第四层 (ib_charMap): 62 种字符
```

对每个候选 ID 调用 `CreateItem`，成功则记录 `GetItemTypeId`，然后 `RemoveItem`。

> ⚠️ 完整枚举约需 2-3 分钟（62⁴ ≈ 1477 万次尝试），期间略有卡顿。
> 完成后屏幕提示「装备列表加载完成」。

### 2. 名称匹配

- 用 `GetObjectName(itemId)` 获取物品显示名
- `IB_StripColorCodes` 去除 `|cXXXXXXXX` / `|r` 颜色代码
- `IB_IsItemMatch` 做子串匹配（支持中文）

### 3. 添加物品

- `IB_GetSelectedUnit` 通过 `GroupEnumUnitsSelected` 获取玩家当前选中单位
- `CreateItem` 在单位位置创建
- `UnitAddItem` 尝试放入背包，失败则 `SetItemPosition` 留在地上

## 文件结构

```
scripts/item-browser/
├── f.j    # 函数定义（约 12KB）
├── g.j    # 全局变量
├── m.j    # 入口调用
└── README.md
```

## 注入方法

```powershell
python tools/war3map-injector/inject_map.py "maps/你的地图.w3m" scripts/item-browser
```

详见 [`../../tools/war3map-injector/README.md`](../../tools/war3map-injector/README.md)。

## 代码结构

### 全局变量（g.j）

```jass
integer array ib_itemList      // 物品 ID 列表
integer ib_itemCount = 0       // 物品数量
integer array ib_charMap       // 字符映射 (0-9, A-Z, a-z)
integer ib_iA, ib_iB, ib_iC    // 枚举索引
integer ib_idA, ib_idB, ib_idC // ID 前缀
timer ib_timerA, ib_timerB, ib_timerC
```

### 主要函数（f.j）

| 函数 | 说明 |
| --- | --- |
| `IB_StripColorCodes` | 去除颜色代码 |
| `IB_StrEqCI` | 不区分大小写比较 |
| `IB_Message` | 发送消息给玩家 |
| `IB_IsItemMatch` | 名称子串匹配 |
| `IB_GetSelectedUnit` | 获取选中单位 |
| `IB_Search` | 搜索装备 |
| `IB_AddItem` | 添加装备 |
| `IB_ParseAddItem` | 解析 additem 参数 |
| `IB_OnChat` | 聊天命令分发 |
| `IB_RegisterChat` | 注册聊天事件 |
| `IB_InitItemCharMap` | 初始化字符映射 |
| `IB_EnumA/B/C/D` | 四层 ID 枚举 |
| `IB_Init` | 入口 |

## 自定义

### 修改命令名

编辑 `IB_OnChat` 中的字符串比较：

```jass
if IB_StrEqCI(cmd, "search") then      // 改成你想要的关键词
```

### 修改显示数量

编辑 `IB_Search` 中的 `if found <= 20 then`。

### 不枚举全部物品（加速）

若只需特定物品，可跳过枚举直接硬编码 ID 列表：

```jass
function IB_Init takes nothing returns nothing
    set ib_itemList[0] = 'ratf'   // 攻击之爪
    set ib_itemList[1] = 'ratc'   // 吸血面罩
    set ib_itemCount = 2
    call IB_RegisterChat()
endfunction
```

## 注意事项

1. **首次加载耗时**：完整枚举约 2-3 分钟，建议在加载期间不要操作。
2. **多人游戏**：枚举使用同步计时器，不会 desync；但 `additem` 只对输入者生效。
3. **地图兼容性**：部分地图有反作弊机制，可能阻止脚本运行。
4. **物品名称**：需使用游戏内显示的名称（中文/英文取决于地图语言）。

## 参考

- 参考脚本：`151个常用脚本\输入名字创建物品`、`聊天输入获得所有装备-作者飘飞之影`
- 注入工具：[`../../tools/war3map-injector/`](../../tools/war3map-injector/)
