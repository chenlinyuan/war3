# alas Arthas Rise of the Lich King

## 成品

- 部署路径：`C:\Users\Administrator\Documents\Warcraft III\Campaigns\alasArthas Rise of the Lich King.w3n`
- 工作区成品：`maps\alasArthas Rise of the Lich King.w3n`
- 源战役：`C:\Users\Administrator\Desktop\Campaigns\Arthas Rise of the Lich King.w3n`
- 源 SHA-256：`457510E3BE4A4A258F6B5D02CE0BEA6A21C14C32A98170F68F4B977BD1529D20`
- 成品 SHA-256：`666526A2859C069811A8507DC445608D357398420678494CFE7E2B6B20FCBF78`
- 大小：1,068,861,440 字节
- 游戏显示名：`alas Arthas Rise of the Lich King`
- 章节：4 个

## 内容与 ID

- 完整物品/技能浏览器。
- 四翼：`I100`、`I101`、`I102`、`I104`。
- 阿克蒙德之手：`I103`，死亡之指 `A100`。
- 霜之哀伤：`I105`。
- 埃辛诺斯战刃：`I106`，战刃技能 `A112/A113/A116/A117/A118/Aclq`。
- 不包含坐骑。

原战役占用 `B641/B642/B643`，因此对应的 ALAS buff 使用：

- 阿克蒙德光环：`B100`
- 灰烬减速：`B101`
- 治疗光环：`B102`

所有章节使用同一套装备 ID。

## 验收

- 4/4 章一次性注入对象、脚本和资源，读回逐字节一致。
- ALAS 战役审计通过标题、章节、运行时入口、装备字段及全部资源。
- 物品目录审计通过：618 个物品别名、49 个战役物品 ID。
- 原图另有一个乱码技能 rawcode；目录生成器已过滤所有非 4 字节 ASCII rawcode。
- 注入前后逐章 pjass 诊断数量完全一致，没有新增错误。
- 工作区成品与部署文件大小和 SHA-256 一致。

## 游戏内测试

```text
itembrowser
additem hand
additem frost
additem warglaive
wings
wginfo
```

重点确认聊天命令响应、四翼可见、战刃技能装卸、霜之哀伤掉落拾取，
并检查 `War3Log.txt` 没有 `model creation failed`。
