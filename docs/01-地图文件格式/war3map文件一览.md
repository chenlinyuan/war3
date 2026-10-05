# war3map 文件一览

地图（`.w3x`）解包后包含以下 `war3map.*` 文件。本页汇总各文件的作用、格式与对应工具。

## 世界文件（World Files）

| 文件 | 内容 | 格式 | 对应编辑器面板 |
| --- | --- | --- | --- |
| `war3map.w3e` | 地形（瓦片类型、高度、纹理） | 二进制 | 地形编辑器 |
| `war3mapUnits.doo` | 预放置单位 | 二进制 | 单位面板 |
| `war3map.doo` | 装饰物（doodad） | 二进制 | 装饰物面板 |
| `war3map.w3r` | 区域（Region） | 二进制 | 区域面板 |
| `war3map.w3c` | 摄像机 | 二进制 | 摄像机面板 |

## 对象数据文件（Object Data）

| 文件 | 内容 | 对应编辑器 |
| --- | --- | --- |
| `war3map.w3u` | 自定义单位 | 对象编辑器 - 单位 |
| `war3map.w3t` | 自定义物品 | 对象编辑器 - 物品 |
| `war3map.w3a` | 自定义技能 | 对象编辑器 - 技能 |
| `war3map.w3b` | 自定义可破坏物 | 对象编辑器 - 可破坏物 |
| `war3mapSkin.w3b` | 皮肤版可破坏物 | 同上 |
| `war3map.w3d` | 自定义装饰物 | 对象编辑器 - 装饰物 |
| `war3map.w3q` | 自定义升级 | 对象编辑器 - 升级 |
| `war3map.w3h` | 自定义增益/魔法效果 | 对象编辑器 - 增益 |

## 地图文件（Map Files）

| 文件 | 内容 | 格式 |
| --- | --- | --- |
| `war3map.w3i` | 地图信息（名称、玩家、脚本语言） | 二进制 |
| `war3map.imp` | 导入文件清单 | 二进制 |
| `war3map.w3s` | 声音定义 | 二进制 |
| `war3map.wts` | 触发字符串表 | 文本 |
| `war3map.wpm` | 路径地图（pathing） | 二进制 |
| `war3map.shd` | 阴影图 | 二进制 |

## 触发器与脚本

| 文件 | 内容 | 格式 |
| --- | --- | --- |
| `war3map.wtg` | 触发器定义（GUI 数据） | 二进制 |
| `war3map.wct` | 自定义文本触发器 | 文本 |
| `war3map.j` | JASS 脚本 | 文本 |
| `war3map.lua` | Lua 脚本 | 文本 |

> 地图只会包含 `war3map.j` **或** `war3map.lua`，取决于脚本语言设置。

## 图像与界面

| 文件 | 内容 |
| --- | --- |
| `war3map.mmp` | 小地图图标 |
| `war3mapMap.blp` | 小地图图片 |
| `war3mapMap.b00` | 小地图图片（旧） |
| `war3mapMap.tga` | 小地图图片（TGA） |
| `war3mapPreview.tga` | 地图预览图 |
| `war3mapPath.tga` | 路径预览图（编辑器用） |
| `war3mapExtra.txt` | 额外信息（编辑器用） |

## 战役文件（.w3n）

| 文件 | 内容 |
| --- | --- |
| `war3campaign.w3f` | 战役信息 |
| `war3campaign.w3u` | 战役级单位数据 |
| `war3campaign.w3a` | 战役级技能数据 |
| `war3campaign.w3t` | 战役级物品数据 |
| `war3campaign.w3q` | 战役级升级数据 |
| `war3campaign.w3b` | 战役级可破坏物数据 |
| `war3campaign.w3d` | 战役级装饰物数据 |
| `war3campaign.w3h` | 战役级增益数据 |
| `war3campaign.imp` | 战役导入清单 |
| `war3campaign.wts` | 战役字符串表 |

## 工具支持矩阵（WC3MapTranslator）

| 文件 | JSON ⇄ 二进制 |
| --- | --- |
| `war3map.w3e` | ✅ |
| `war3mapUnits.doo` | ✅ |
| `war3map.doo` | ✅ |
| `war3map.w3r` | ✅ |
| `war3map.w3c` | ✅ |
| `war3map.w3u` | ✅ |
| `war3map.w3t` | ✅ |
| `war3map.w3a` | ✅ |
| `war3map.w3b` | ✅ |
| `war3map.w3d` | ✅ |
| `war3map.w3q` | ✅ |
| `war3map.w3h` | ✅ |
| `war3map.w3i` | ✅ |
| `war3map.imp` | ✅ |
| `war3map.w3s` | ✅ |
| `war3map.wts` | ✅ |
| `war3map.wpm` | ❌ |
| `war3map.shd` | ❌ |

## 参考

- WC3MapSpecification：https://github.com/ChiefOfGxBxL/WC3MapSpecification
- WC3MapTranslator：https://github.com/ChiefOfGxBxL/WC3MapTranslator
