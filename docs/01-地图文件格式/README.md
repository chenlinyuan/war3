# 01 · 地图文件格式

Warcraft III 地图（`.w3x` / `.w3m`）本质是一个 **MPQ 归档容器**，内部包含地形、单位、脚本、对象数据等文件。

## 文档列表

- [`地图容器格式.md`](地图容器格式.md) — .w3x/.w3m 容器结构与 MPQ 格式
- [`war3map文件一览.md`](war3map文件一览.md) — 所有 war3map.* 文件的作用
- [`核心文件格式.md`](核心文件格式.md) — w3i/w3e/doo/w3u 等二进制格式详解

## 快速参考

| 文件 | 内容 | 格式 |
| --- | --- | --- |
| `war3map.w3i` | 地图信息（名称、玩家、脚本语言） | 二进制 |
| `war3map.w3e` | 地形（瓦片、高度、纹理） | 二进制 |
| `war3mapUnits.doo` | 预放置单位 | 二进制 |
| `war3map.doo` | 装饰物（doodad） | 二进制 |
| `war3map.w3r` | 区域（Region） | 二进制 |
| `war3map.w3c` | 摄像机 | 二进制 |
| `war3map.w3u` | 自定义单位 | 二进制 |
| `war3map.w3t` | 自定义物品 | 二进制 |
| `war3map.w3a` | 自定义技能 | 二进制 |
| `war3map.w3b` | 自定义可破坏物 | 二进制 |
| `war3map.w3d` | 自定义装饰物 | 二进制 |
| `war3map.w3q` | 自定义升级 | 二进制 |
| `war3map.w3h` | 自定义增益 | 二进制 |
| `war3map.w3s` | 声音定义 | 二进制 |
| `war3map.wts` | 触发字符串表 | 文本 |
| `war3map.wtg` | 触发器定义（GUI） | 二进制 |
| `war3map.wct` | 自定义文本触发器 | 文本 |
| `war3map.j` | JASS 脚本 | 文本 |
| `war3map.lua` | Lua 脚本 | 文本 |
| `war3map.imp` | 导入文件清单 | 二进制 |
| `war3map.wpm` | 路径地图 | 二进制 |
| `war3map.shd` | 阴影图 | 二进制 |
| `war3map.mmp` | 小地图图标 | 二进制 |
| `war3mapMap.blp` | 小地图图片 | 图片 |
| `war3mapPreview.tga` | 预览图 | 图片 |

## 外部规范

- **WC3MapSpecification**：https://github.com/ChiefOfGxBxL/WC3MapSpecification
- **Kaitai Struct 定义**：https://github.com/WaterKnight/Warcraft3-Formats-KaitaiStruct
- **TheHelper 教程**：http://world-editor-tutorials.thehelper.net/cat_usersubmit.php?view=42787
