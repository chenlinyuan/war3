# ALAS 被遗忘的王国 3.0.1.24371 · 缓存修复完整修复版

> 此版本已由《缓存修复精简修复版》取代。

## 成品

`C:\Users\Administrator\Documents\Warcraft III\Campaigns\alas被遗忘的王国-3.0.1.24371-缓存修复-完整修复版.w3n`

- 源底图：`C:\Users\Administrator\Documents\Warcraft III\Campaigns\被遗忘的王国-3.0.1.24371-缓存修复.w3n`
- 源图 SHA-256：`AD528143269F6A8D020B7FDA5965C1A19F69EFC48F3892FC3ED72885FB485BE2`
- 成品大小：379,396,608 字节
- 成品 SHA-256：`C4F523DAF6A3E8A2806450D60BD8AB390D78472A45D6F15783ADB9CEB474BEF3`
- 游戏显示名：`alas 被遗忘的王国-3.0.1.24371-缓存修复-完整修复版`

## WCT 修复

使用 `tools/recover/patch_forsaken_301_wct.py` 修复以下章节中
`TS 01 Config` 对应的错误长度字段：

- `UndeadRE02.w3x`
- `UndeadRE02_01.w3x`
- `UndeadRE02_02.w3x`
- `UndeadRE02_03.w3x`
- `UndeadRE02_04.w3x`
- `UndeadRE02_06.w3x`

每章只修正一个四字节长度字段，实际值减小 1；没有移动或改写触发器文本。
修复后 15 章 WCT 均可完整读取，并与 WTG 文本逐项配对。

## 任务修复

使用 `tools/recover/patch_forsaken_301_source_fixes.py` 在 ALAS 注入前修复：

1. 第二幕鼠巢烧毁与任务轮询。
2. 第二幕三个坑道入口、炸药桶爆炸和读档恢复。
3. 第一幕巢母中立死亡、蛛网解控、任务物掉落顺序和门无敌。
4. 第一幕黑暗犬中立死亡、任务物可见及触发器恢复。
5. 第一幕女妖任务创建、同步、完成和死亡路径的暂停恢复。

## 验证

- 15/15 章 Lua 语法检查通过。
- 15/15 章 Map Doctor 3.0 检查无阻断项。
- 15/15 章 WCT/WTG 配对通过。
- 目录审计通过：688 件物品、213 项技能。
- 7 件装备及关键对象字段、资源回读、ALAS 入口检查通过。
- 修复后的底图与 `-2` 的全部内部文件逐项一致。
- 新成品章节与上一张“底图修复版”的章节逻辑内容一致，仅外层标题和 MPQ 打包布局不同。

仍需进入游戏新开档验证命令响应、任务推进、Boss 掉物、蛛网解控和剧情后英雄控制。
