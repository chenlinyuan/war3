# item-browser · 装备搜索与添加系统

在任意 War3 地图中通过**聊天输入框**搜索和添加装备。

> ⚠️ **War3 1.27 无法输入中文**（游戏内聊天框不支持输入法）。
> 因此本系统支持 **拼音首字母搜索** 和 **序号选择**，无需输入中文即可操作。

## 功能

| 命令 | 说明 |
| --- | --- |
| `search <关键词>` | 搜索名称包含关键词的装备（支持中文） |
| `search <拼音首字母>` | 用拼音首字母搜索，如 `search xxmz` = 吸血面罩 |
| `additem <序号>` | 添加**上次搜索结果**中第 N 件（推荐，无需中文） |
| `additem <序号> <数量>` | 添加第 N 件共 m 个 |
| `additem <拼音>` | 按拼音首字母添加，如 `additem xxmz` |
| `additem <名称>` | 按完整名称添加（需中文输入） |
| `itembrowser` | 显示帮助与已加载装备数量 |

## 使用示例

**方式一：拼音首字母（推荐）**

```
search xxmz          → 搜索拼音含 xxmz 的装备，结果显示编号与拼音
additem 1            → 添加结果中第 1 件
additem 1 3          → 添加第 1 件共 3 个
```

**方式二：直接按拼音添加**

```
additem xxmz         → 直接添加「吸血面罩」
additem xxmz 3       → 添加 3 个
```

**方式三：中文（需能输入中文的环境）**

```
search 吸血          → 列出所有名称含"吸血"的装备
additem 吸血面罩      → 给选中英雄添加「吸血面罩」
```

**其他**

```
itembrowser          → 显示帮助
```

## 拼音首字母说明

拼音表覆盖常用汉字，按字母分组存储于 `py_map[0..22]`。
`PY_Convert` 将中文名转为拼音首字母串，例如：

| 中文名 | 拼音首字母 |
| --- | --- |
| 吸血面罩 | `xxmz` |
| 力量之戒 | `llzj` |
| 速度之靴 | `sdzx` |

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
├── f.j    # 函数定义（含拼音表，约 27KB）
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
string array py_map            // 拼音首字母表（0-22 对应 a-w）
integer array ib_lastResult    // 上次搜索结果
integer ib_lastResultCount = 0 // 上次搜索结果数量
```

### 主要函数（f.j）

| 函数 | 说明 |
| --- | --- |
| `IB_StripColorCodes` | 去除颜色代码 |
| `IB_StrEqCI` | 不区分大小写比较 |
| `IB_Message` | 发送消息给玩家 |
| `IB_IsItemMatch` | 名称子串 / 拼音匹配 |
| `IB_GetSelectedUnit` | 获取选中单位 |
| `IB_Search` | 搜索装备（记录结果供序号选择） |
| `IB_AddItem` | 按名称/拼音添加装备 |
| `IB_AddByIndex` | 按搜索结果序号添加 |
| `IB_IsAllDigits` | 判断字符串是否全为数字 |
| `IB_ParseAddItem` | 解析 additem 参数 |
| `IB_OnChat` | 聊天命令分发 |
| `IB_RegisterChat` | 注册聊天事件 |
| `IB_InitItemCharMap` | 初始化字符映射 |
| `IB_EnumA/B/C/D` | 四层 ID 枚举 |
| `IB_Init` | 入口 |
| `PY_InitTable` | 初始化拼音表 |
| `PY_GetInitial` | 查单字拼音首字母 |
| `PY_Convert` | 中文名转拼音首字母串 |
| `PY_Matches` | 拼音首字母匹配 |

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
