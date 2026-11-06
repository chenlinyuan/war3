# alas 命运之路II月神的秘密

## 成品

- 部署路径：`C:\Users\Administrator\Documents\Warcraft III\Campaigns\alas命运之路II月神的秘密.w3n`
- 工作区成品：`maps\alas命运之路II月神的秘密.w3n`
- 源战役：`C:\Users\Administrator\Desktop\Campaigns\命运之路II月神的秘密.w3n`
- 源 SHA-256：`56E4D004DA542B97E12521DF9416AFDFCC084C360183754F3E00573C5A86856E`
- 成品 SHA-256：`38FFBFF33DD406D3F696F6850751EA0D8DFAE60F4167B06B801F54D2697C678D`
- 大小：644,597,248 字节
- 游戏显示名：`alas 命运之路II月神的秘密`
- 章节：12 个

## ID 避让

`WisdomGlade.w3x` 原本使用 `I100-I106`。为了不破坏该章原物品，
本次完整 ALAS 装备集使用以下空闲 ID：

| 内容 | 本战役 ID |
| --- | --- |
| 堕落天使之翼 | `I115` |
| 炽天使之翼 | `I116` |
| 恶魔之翼 | `I117` |
| 星魂之力 | `I118` |
| 阿克蒙德之手 | `I119` |
| 霜之哀伤 | `I125` |
| 埃辛诺斯战刃 | `I126` |

手势技能仍为 `A100-A102`；战刃技能为 `A112/A113/A116/A117/A118/Aclq`。
浏览器 ASCII 别名已随实际物品 ID 重映射：

- `hand` / `akhand` -> `I119`
- `frost` / `frostmourne` -> `I125`
- `warglaive` / `glaive` / `eggblade` / `azzinoth` -> `I126`

## 静态验收

- 12/12 章通过一次性对象、脚本与资源注入校验。
- 每章唯一包含 `IB_Init`、`WG_Init`、`FR_Init`、`WGL_Init` 入口。
- 12/12 章通过 pjass；战刃与霜之哀伤模块单独通过 pjass。
- 物品目录审计通过：927 个物品别名、856 个物品 ID，JASS 字符串无未闭合行。
- ALAS 战役审计通过标题、12 章、对象字段、运行时入口和全部导入资源检查。
- 原图 `I100-I106` 物品保留在章节内，没有被新装备覆盖。
- 工作区成品与部署文件大小和 SHA-256 完全一致。

## 游戏内测试

进入任一章节后测试：

```text
itembrowser
search 天使
additem hand
additem frost
additem warglaive
wings
wginfo
```

重点确认聊天命令有响应、四件翅膀可穿戴、三件装备图标与模型可见、
战刃技能按钮随 `I126` 装卸、霜之哀伤可掉落与拾取，并检查 `War3Log.txt`
没有 `model creation failed`。
