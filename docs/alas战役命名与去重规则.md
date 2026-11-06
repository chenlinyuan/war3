# alas 战役命名与去重规则

## 唯一副本

- 每个 alas 战役在游戏用户战役目录中只保留一份 `.w3n`。
- 同一战役的旧缓存修复版、单机修复版、翅膀修复中间版等都不保留在
  `Campaigns` 目录；清理时移入回收站，避免误删不可恢复。
- `H:\Games\War3\Campaigns` 不再保留与用户战役目录重复的 alas 文件。

## 显示名

- 游戏内名称使用 `alas ` 前缀，后接与文件名一致的主题。
- 标题直接写入 `war3campaign.w3f` 的 UTF-8 字符串，不依赖容易损坏的
  `war3campaign.wts`。
- 存在 `HM3W` 头的战役同时同步头里的名称。
- 颜色代码不放进标题，避免不同客户端把 `|c...` 原样显示。

## 自动检查

```powershell
python tools\war3map-injector\fix_alas_campaign_names.py
python tools\war3map-injector\fix_alas_campaign_names.py --apply
```

第一条只报告名称差异，第二条写入并读回验证。脚本会先备份原
`war3campaign.w3f` 到 `maps/recover/alas_campaign_names_20261030`。

当前保留 9 个唯一 alas 战役，两个战役目录里不再有重复项。

## 每次改图后的强制验收

1. 只部署一份最终 `.w3n`，旧中间版移入回收站。
2. 游戏内标题必须与部署文件名一致，并检查 `war3campaign.w3f`；有 `HM3W`
   时同时检查头字段。
3. 比较工作区成品与部署文件的大小和 SHA-256。
4. 进入实际地图，确认出现系统初始化提示。
5. 至少实际输入一次 `itembrowser` 或 `search`，看到回应后才能报告完成。
6. 若初始化某一部分失败，物品/技能核心命令必须先启动；翅膀、武器等模块
   分别用保护初始化执行，不能因一个模块异常导致全部聊天命令失效。
