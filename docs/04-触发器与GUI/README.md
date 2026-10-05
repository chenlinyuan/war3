# 04 · 触发器与 GUI

触发器编辑器（Trigger Editor）是 World Editor 的可视化脚本系统。

## 文档列表

- [`触发器编辑器.md`](触发器编辑器.md) — 触发器编辑器使用指南
- [`GUI事件条件动作.md`](GUI事件条件动作.md) — GUI 事件/条件/动作速查
- [`GUI转JASS.md`](GUI转JASS.md) — GUI 与 JASS/Lua 的对应关系

## 核心模型

```
触发器（Trigger）
├── 事件（Events）      —— 何时触发
├── 条件（Conditions）  —— 是否执行
└── 动作（Actions）     —— 执行什么
```

## 示例

```
事件: 单位 - 一个单位死亡
条件: (触发单位) 是 英雄 等于 真
动作: 游戏 - 显示文本给 (所有玩家): "一个英雄倒下了！"
```

## GUI 的优缺点

| 优点 | 缺点 |
| --- | --- |
| 无需编程知识 | 复杂逻辑难以表达 |
| 可视化、直观 | 生成代码冗余（BJ 函数） |
| 快速原型 | 性能较差 |
| 易于学习 | 难以版本控制（二进制 wtg） |

## 建议

- **简单逻辑**：用 GUI。
- **复杂逻辑/性能敏感**：用 JASS/Lua。
- **混合**：GUI 框架 + 自定义脚本（通过「自定义脚本」动作）。

## 参考

- Hive Workshop GUI 教程：https://www.hiveworkshop.com/forums/trigger-gui-editor-tutorials.279/
- 触发器编辑器帮助（游戏内 F1）
