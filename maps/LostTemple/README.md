# Lost Temple · 改图工程

在官方对战地图 **Lost Temple (4)** 上注入装备搜索/添加系统。

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

**脚本**：`scripts/item-browser`（装备搜索与添加）

**新增功能**：
- `search <关键词>` — 搜索装备（支持中文）
- `search <拼音首字母>` — 拼音搜索，如 `search xxmz`
- `additem <序号> [数量]` — 添加搜索结果中的装备（无需中文）
- `additem <拼音> [数量]` — 按拼音首字母添加
- `itembrowser` — 显示帮助

**注入后大小**：256,713 字节（+11,626）

> 拼音表采用**延迟初始化**（首次使用搜索/添加时才加载），避免地图加载时执行
> 大字符串赋值，降低加载卡顿与崩溃风险。

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
