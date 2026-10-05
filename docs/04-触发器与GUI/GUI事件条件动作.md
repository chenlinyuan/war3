# 04 · 触发器与 GUI · 事件条件动作速查

> GUI 事件 / 条件 / 动作完整速查表

## 一、事件（Events）

### 1.1 地图/游戏

| GUI | 说明 |
| --- | --- |
| Map Initialization | 地图初始化 |
| 游戏时间经过 X 秒 | 一次性计时 |
| 每 X 秒游戏时间 | 周期计时 |
| 游戏 - 游戏胜利 | 胜利 |
| 游戏 - 关卡结束 | 关卡结束 |
| 游戏 - 保存游戏 | 保存 |
| 游戏 - 载入游戏 | 载入 |

### 1.2 单位

| GUI | 说明 |
| --- | --- |
| 单位 - 一个单位死亡 | 死亡 |
| 单位 - 一个单位被攻击 | 被攻击 |
| 单位 - 一个单位施放技能 | 施法 |
| 单位 - 一个单位开始施放技能 | 开始施法 |
| 单位 - 一个单位完成施放技能 | 完成施法 |
| 单位 - 一个单位停止施放技能 | 停止施法 |
| 单位 - 一个单位进入区域 | 进入区域 |
| 单位 - 一个单位离开区域 | 离开区域 |
| 单位 - 一个单位获得目标 | 获得攻击目标 |
| 单位 - 一个单位被下令 | 被下令 |
| 单位 - 一个单位被召唤 | 召唤 |
| 单位 - 一个单位被出售 | 出售 |
| 单位 - 一个单位建造完成 | 建造完成 |
| 单位 - 一个单位训练完成 | 训练完成 |
| 单位 - 一个单位研究完成 | 研究完成 |
| 单位 - 一个单位升级完成 | 升级完成 |
| 单位 - 一个单位复活 | 复活 |
| 单位 - 一个单位获得物品 | 拾取物品 |
| 单位 - 一个单位丢弃物品 | 丢弃物品 |
| 单位 - 一个单位使用物品 | 使用物品 |

### 1.3 玩家

| GUI | 说明 |
| --- | --- |
| 玩家 - 一个玩家输入聊天信息 | 聊天 |
| 玩家 - 一个玩家离开游戏 | 离开 |
| 玩家 - 一个玩家失败 | 失败 |
| 玩家 - 一个玩家胜利 | 胜利 |
| 玩家 - 一个玩家按下方向键 | 方向键 |
| 玩家 - 一个玩家按下鼠标 | 鼠标 |

### 1.4 其他

| GUI | 说明 |
| --- | --- |
| 对话框 - 一个对话框按钮被点击 | 对话框 |
| 可破坏物 - 一个可破坏物死亡 | 可破坏物死亡 |
| 物品 - 一个物品被操作 | 物品操作 |

---

## 二、条件（Conditions）

### 2.1 比较

| GUI | 说明 |
| --- | --- |
| 整数比较 | `==`, `!=`, `<`, `>`, `<=`, `>=` |
| 实数比较 | 同上 |
| 字符串比较 | 同上 |
| 布尔比较 | 等于/不等于 |
| 单位比较 | 等于/不等于 |
| 玩家比较 | 等于/不等于 |

### 2.2 单位判断

| GUI | JASS |
| --- | --- |
| (单位) 是 英雄 | `IsUnitType(u, UNIT_TYPE_HERO)` |
| (单位) 是 建筑 | `IsUnitType(u, UNIT_TYPE_STRUCTURE)` |
| (单位) 是 飞行单位 | `IsUnitType(u, UNIT_TYPE_FLYING)` |
| (单位) 是 地面单位 | `IsUnitType(u, UNIT_TYPE_GROUND)` |
| (单位) 是 机械单位 | `IsUnitType(u, UNIT_TYPE_MECHANICAL)` |
| (单位) 是 不死单位 | `IsUnitType(u, UNIT_TYPE_UNDEAD)` |
| (单位) 是 召唤单位 | `IsUnitType(u, UNIT_TYPE_SUMMONED)` |
| (单位) 是 农民 | `IsUnitType(u, UNIT_TYPE_PEON)` |
| (单位) 是 远古单位 | `IsUnitType(u, UNIT_TYPE_ANCIENT)` |
| (单位) 是 魔法免疫 | `IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE)` |
| (单位) 是 存活的 | `not IsUnitType(u, UNIT_TYPE_DEAD)` |
| (单位) 是 隐藏的 | `IsUnitHidden(u)` |
| (单位) 是 幻象 | `IsUnitIllusion(u)` |
| (单位) 是 盟友 | `IsUnitAlly(u, p)` |
| (单位) 是 敌人 | `IsUnitEnemy(u, p)` |

### 2.3 玩家判断

| GUI | JASS |
| --- | --- |
| (玩家) 是 盟友 | `IsPlayerAlly(p1, p2)` |
| (玩家) 是 敌人 | `IsPlayerEnemy(p1, p2)` |
| (玩家) 是 观战者 | `IsPlayerObserver(p)` |
| (玩家) 在 玩家组 | `IsPlayerInForce(p, f)` |

### 2.4 布尔表达式

| GUI | JASS |
| --- | --- |
| And | `And(a, b)` |
| Or | `Or(a, b)` |
| Not | `Not(a)` |

---

## 三、动作（Actions）

### 3.1 单位

| GUI | JASS |
| --- | --- |
| 杀死单位 | `KillUnit(u)` |
| 移除单位 | `RemoveUnit(u)` |
| 隐藏单位 | `ShowUnit(u, false)` |
| 显示单位 | `ShowUnit(u, true)` |
| 创建单位 | `CreateUnit(p, id, x, y, face)` |
| 创建单位在点 | `CreateUnitAtLoc(p, id, loc, face)` |
| 移动单位到点 | `SetUnitPosition(u, x, y)` |
| 移动单位到点（不打断） | `SetUnitX(u, x); SetUnitY(u, y)` |
| 设置单位生命 | `SetUnitState(u, UNIT_STATE_LIFE, v)` |
| 设置单位魔法 | `SetUnitState(u, UNIT_STATE_MANA, v)` |
| 设置单位朝向 | `SetUnitFacing(u, angle)` |
| 设置单位所有者 | `SetUnitOwner(u, p, true)` |
| 设置单位移速 | `SetUnitMoveSpeed(u, v)` |
| 设置单位飞行高度 | `SetUnitFlyHeight(u, h, rate)` |
| 添加技能 | `UnitAddAbility(u, id)` |
| 移除技能 | `UnitRemoveAbility(u, id)` |
| 设置技能等级 | `SetUnitAbilityLevel(u, id, level)` |
| 提升技能等级 | `IncUnitAbilityLevel(u, id)` |
| 降低技能等级 | `DecUnitAbilityLevel(u, id)` |
| 添加物品 | `UnitAddItem(u, item)` |
| 移除物品 | `UnitRemoveItem(u, item)` |
| 设置单位无敌 | `SetUnitInvulnerable(u, true)` |
| 暂停单位 | `PauseUnit(u, true)` |
| 命令单位攻击 | `IssueTargetOrder(u, "attack", target)` |
| 命令单位移动 | `IssuePointOrder(u, "move", x, y)` |
| 命令单位停止 | `IssueImmediateOrder(u, "stop")` |
| 命令单位施法 | `IssueTargetOrder(u, "spell", target)` |

### 3.2 单位组

| GUI | JASS |
| --- | --- |
| 选取区域内的单位 | `GroupEnumUnitsInRect(g, r, filter)` |
| 选取范围内的单位 | `GroupEnumUnitsInRange(g, x, y, radius, filter)` |
| 选取玩家的单位 | `GroupEnumUnitsOfPlayer(g, p, filter)` |
| 选取类型的单位 | `GroupEnumUnitsOfType(g, name, filter)` |
| 添加单位到组 | `GroupAddUnit(g, u)` |
| 从组移除单位 | `GroupRemoveUnit(g, u)` |
| 清空单位组 | `GroupClear(g)` |
| 单位组内单位数量 | `CountUnitsInGroup(g)` |
| 对单位组内单位执行动作 | `ForGroup(g, callback)` |

### 3.3 特效

| GUI | JASS |
| --- | --- |
| 在点创建特效 | `AddSpecialEffectLoc(model, loc)` |
| 在坐标创建特效 | `AddSpecialEffect(model, x, y)` |
| 在单位创建特效 | `AddSpecialEffectTarget(model, u, attachPoint)` |
| 销毁特效 | `DestroyEffect(e)` |

### 3.4 声音

| GUI | JASS |
| --- | --- |
| 播放声音 | `PlaySoundBJ(sound)` |
| 播放声音在点 | `PlaySoundAtPointBJ(sound, volume, loc, z)` |
| 播放音乐 | `PlayMusic(file)` |
| 停止音乐 | `StopMusic(fadeOut)` |

### 3.5 摄像机

| GUI | JASS |
| --- | --- |
| 平移摄像机到点 | `PanCameraToTimed(x, y, duration)` |
| 设置摄像机位置 | `SetCameraPosition(x, y)` |
| 设置摄像机字段 | `SetCameraField(field, value, duration)` |
| 重置摄像机 | `ResetToGameCamera(duration)` |
| 跟随单位 | `SetCameraTargetController(u, 0, 0, false)` |

### 3.6 游戏/文本

| GUI | JASS |
| --- | --- |
| 显示文本给玩家 | `DisplayTextToPlayer(p, x, y, msg)` |
| 显示文本给所有玩家 | `DisplayTextToForce(GetPlayersAll(), msg)` |
| 显示定时文本 | `DisplayTimedTextToPlayer(p, x, y, dur, msg)` |
| 清除文本 | `ClearTextMessages()` |
| 设置游戏时间 | `SetFloatGameState(GAME_STATE_TIME_OF_DAY, t)` |
| 设置游戏速度 | `SetGameSpeed(speed)` |
| 暂停游戏 | `PauseGame(true)` |
| 结束游戏 | `EndGame(doScoreScreen)` |
| 切换关卡 | `ChangeLevel(level, doScoreScreen)` |
| 重开游戏 | `RestartGame(doScoreScreen)` |

### 3.7 玩家

| GUI | JASS |
| --- | --- |
| 设置玩家金币 | `SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, v)` |
| 设置玩家木材 | `SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, v)` |
| 设置玩家食物上限 | `SetPlayerState(p, PLAYER_STATE_RESOURCE_FOOD_CAP, v)` |
| 设置玩家名字 | `SetPlayerName(p, name)` |
| 设置玩家颜色 | `SetPlayerColor(p, color)` |
| 设置玩家科技 | `SetPlayerTechResearched(p, tech, level)` |
| 设置玩家联盟 | `SetPlayerAlliance(p1, p2, type, value)` |
| 失败玩家 | `SetPlayerState(p, PLAYER_STATE_GAME_RESULT, ...)` |

### 3.8 触发器

| GUI | JASS |
| --- | --- |
| 运行触发器 | `TriggerExecute(trg)` |
| 启用触发器 | `EnableTrigger(trg)` |
| 禁用触发器 | `DisableTrigger(trg)` |
| 等待 | `TriggerSleepAction(timeout)` |
| 添加事件 | `TriggerRegister...` |

### 3.9 对话框

| GUI | JASS |
| --- | --- |
| 创建对话框 | `DialogCreate()` |
| 清空对话框 | `DialogClear(d)` |
| 设置对话框标题 | `DialogSetMessage(d, msg)` |
| 添加对话框按钮 | `DialogAddButton(d, text, hotkey)` |
| 显示对话框 | `DialogDisplay(p, d, true)` |
| 隐藏对话框 | `DialogDisplay(p, d, false)` |
| 销毁对话框 | `DialogDestroy(d)` |

### 3.10 多面板/排行榜

| GUI | JASS |
| --- | --- |
| 创建多面板 | `CreateMultiboard()` |
| 设置列数 | `MultiboardSetColumnCount(mb, n)` |
| 设置行数 | `MultiboardSetRowCount(mb, n)` |
| 设置标题 | `MultiboardSetTitleText(mb, text)` |
| 获取单元格 | `MultiboardGetItem(mb, row, col)` |
| 设置单元格值 | `MultiboardSetItemValue(item, val)` |
| 显示多面板 | `MultiboardDisplay(mb, true)` |
| 创建排行榜 | `CreateLeaderboard()` |
| 添加排行榜项 | `LeaderboardAddItem(lb, label, value, p)` |

### 3.11 浮动文字

| GUI | JASS |
| --- | --- |
| 创建浮动文字 | `CreateTextTag()` |
| 设置文字 | `SetTextTagText(t, text, height)` |
| 设置位置 | `SetTextTagPos(t, x, y, z)` |
| 设置颜色 | `SetTextTagColor(t, r, g, b, a)` |
| 设置速度 | `SetTextTagVelocity(t, xv, yv)` |
| 设置生命周期 | `SetTextTagLifespan(t, dur)` |
| 设置淡出点 | `SetTextTagFadepoint(t, fp)` |
| 销毁浮动文字 | `DestroyTextTag(t)` |

---

## 参考

- Hive Workshop GUI 教程
- 触发器编辑器内置帮助（F1）
