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
- `search <关键词>` — 搜索装备
- `additem <名称> [数量]` — 添加装备给选中英雄
- `itembrowser` — 显示帮助

**注入后大小**：249,123 字节（+4,036）

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

## 游戏内测试

1. 将 `LostTemple.w3m` 复制到 `H:\Games\War3\Maps\`（或子目录）。
2. 启动 Warcraft III，创建自定义游戏，选择该地图。
3. 等待屏幕提示 **「装备列表加载完成，共 N 件」**（约 2-3 分钟）。
4. 选中一个英雄，输入：
   ```
   search 吸血
   additem 吸血面罩
   ```

## 已知限制

- 首次加载需 2-3 分钟枚举物品。
- 部分地图可能有反作弊，可能阻止脚本。
- 装备名称取决于地图的语言设置。

## 相关

- 脚本源码：[`../../scripts/item-browser/`](../../scripts/item-browser/)
- 注入工具：[`../../tools/war3map-injector/`](../../tools/war3map-injector/)
