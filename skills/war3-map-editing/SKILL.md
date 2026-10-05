---
name: war3-map-editing
description: Warcraft III 地图编辑 / Mod 制作专业知识。当用户需要创建、编辑、调试 War3 地图（.w3x/.w3m）、编写 JASS/vJASS/Lua 脚本、操作对象数据（单位/技能/物品）、处理 war3map.* 文件格式、导入自定义资源、排查内存泄漏或 desync 时使用本技能。触发词：war3, 魔兽争霸3, Warcraft III, 地图编辑, World Editor, JASS, vJASS, war3map, w3x, 触发器, 对象编辑器, 技能制作, 模型导入, MPQ。
---

# Warcraft III 地图编辑技能

本技能提供 War3 地图编辑 / Mod 制作的领域知识与工作流程。

## 知识库位置

本仓库的知识库位于 `docs/`：

| 目录 | 内容 |
| --- | --- |
| `docs/00-入门/` | 环境搭建、第一个地图、术语表 |
| `docs/01-地图文件格式/` | .w3x 容器、war3map.* 二进制格式 |
| `docs/02-脚本编程/` | JASS / vJASS / Lua / API / 内存与 desync |
| `docs/03-对象数据/` | 单位、技能、物品、升级、增益 |
| `docs/04-触发器与GUI/` | 触发器编辑器、GUI 速查、GUI→JASS |
| `docs/05-资源制作/` | 模型、贴图、图标、音效、UI |
| `docs/06-工具链/` | 编辑器、MPQ/CASC、脚本、资源工具 |
| `docs/07-参考/` | 外部链接、常量、崩溃、版本差异 |
| `docs/99-模板与片段/` | 可复用代码模板与设计模式 |

## 工作流程

### 场景 1：创建新地图

1. 阅读 `docs/00-入门/第一个地图.md`。
2. 确定脚本语言（新项目推荐 Lua，见 `docs/02-脚本编程/脚本语言概览.md`）。
3. 在 `maps/<地图名>/` 创建工程目录。
4. 使用 World Editor 或编程方式（War3Net）创建地图。

### 场景 2：编写脚本

1. 确认脚本语言（JASS / Lua）。
2. 参考 `docs/02-脚本编程/`：
   - JASS → `JASS基础.md`
   - Lua → `Lua编程.md`
   - API → `API参考.md`
3. 使用 `docs/99-模板与片段/` 中的模板起步。
4. **必读** `docs/02-脚本编程/内存泄漏与Desync.md`。

### 场景 3：操作对象数据

1. 参考 `docs/03-对象数据/`。
2. 单位字段 → `单位数据.md`
3. 技能字段 → `技能数据.md`
4. 物品/升级 → `物品与升级.md`

### 场景 4：处理地图文件格式

1. 参考 `docs/01-地图文件格式/`。
2. 使用 WC3MapTranslator 转换 war3map.* ⇄ JSON。
3. 使用 War3Net（C#）编程读写。

### 场景 5：导入自定义资源

1. 参考 `docs/05-资源制作/资源导入.md`。
2. 注意路径规范（反斜杠、大小写敏感）。
3. 模型需同时导入贴图。

### 场景 6：排查问题

1. 崩溃 → `docs/07-参考/常见崩溃与问题.md`
2. 内存泄漏 → `docs/02-脚本编程/内存泄漏与Desync.md`
3. Desync → 同上
4. 版本兼容 → `docs/07-参考/版本差异.md`

## 核心原则

### 内存管理

- **所有创建的对象必须销毁**：`DestroyGroup`, `RemoveLocation`, `DestroyTimer` 等。
- **JASS 中所有局部 agent 变量必须置 `null`**。
- **Lua 中不需要置 nil**，但需手动销毁游戏对象。

### 同步（多人游戏）

- **`GetLocalPlayer` 块内只做视觉/本地操作**（摄像机、UI、声音）。
- **禁止在 `GetLocalPlayer` 块内改变游戏状态**（创建/销毁单位、修改属性）。
- **Lua 中 table 遍历需排序**（`pairs` 顺序不确定）。
- **`table.sort` 需加唯一 tie-breaker**。
- **随机数必须在同步上下文调用**。

### 版本兼容

- Reforged 地图默认不兼容经典版。
- 使用 Lua / Frame API 会破坏经典版兼容性。
- 通过 `war3map.w3i` 的 Editor Version 控制兼容性。

## 常用命令

```powershell
# 解包地图
MPQEditor.exe extract MyMap.w3x * ./MyMap_unpacked

# war3map.* → JSON
wc3maptranslator ./MyMap_unpacked --toJson

# JSON → war3map.*
wc3maptranslator ./MyMap_json --toWar

# 打包地图
MPQEditor.exe add MyMap.w3x ./MyMap_unpacked\* /r
```

## 权威参考

| 资源 | 链接 |
| --- | --- |
| Hive Workshop | https://www.hiveworkshop.com/ |
| JassDoc | https://github.com/lep/jassdoc |
| Jassbot | https://lep.nrw/jassbot/ |
| WC3MapSpecification | https://github.com/ChiefOfGxBxL/WC3MapSpecification |
| WC3MapTranslator | https://github.com/ChiefOfGxBxL/WC3MapTranslator |
| Lua 指南 | https://www.hiveworkshop.com/threads/a-comprehensive-guide-to-mapping-in-lua.341880/ |
| WurstScript | https://github.com/wurstscript/WurstScript |

## 注意事项

1. **不要假设 API 行为**：查询 JassDoc / Jassbot 确认。
2. **注意版本差异**：某些原生函数仅特定版本可用。
3. **多人大厅测试**：本地测试无法发现 desync。
4. **备份地图**：编辑前备份。
5. **资源路径大小写**：保持一致性。

## 输出规范

- 代码块标注语言（`jass` / `lua`）。
- 引用文件时使用相对路径。
- 提及 API 时给出完整签名。
- 涉及版本差异时明确标注。
