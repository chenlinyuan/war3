# API 参考

> War3 脚本 API 分类速查。完整文档见 [JassDoc](https://github.com/lep/jassdoc) 与
> [Jassbot](https://lep.nrw/jassbot/)。

## 1. 函数来源

| 文件 | 说明 |
| --- | --- |
| `common.j` | 原生函数（native），引擎实现 |
| `blizzard.j` | BJ 函数，Blizzard 用 JASS 封装的便捷函数 |
| `common.ai` | AI 脚本函数 |
| `war3map.j` / `.lua` | 地图脚本 |

> **性能提示**：BJ 函数通常是 native 的封装，多一层调用开销。性能敏感处直接用 native。

## 2. 单位 API

### 创建/销毁

| 函数 | 说明 |
| --- | --- |
| `CreateUnit(player, unitid, x, y, face)` | 创建单位 |
| `CreateUnitByName(player, name, x, y, face)` | 按名称创建 |
| `CreateUnitAtLoc(player, unitid, loc, face)` | 在点创建 |
| `CreateCorpse(player, unitid, x, y, face)` | 创建尸体 |
| `RemoveUnit(u)` | 移除单位 |
| `KillUnit(u)` | 杀死单位 |
| `ShowUnit(u, show)` | 显示/隐藏 |

### 属性

| 函数 | 说明 |
| --- | --- |
| `GetUnitState(u, state)` | 获取状态（生命/魔法等） |
| `SetUnitState(u, state, value)` | 设置状态 |
| `GetWidgetLife(u)` / `SetWidgetLife(u, v)` | 生命值 |
| `GetUnitX(u)` / `GetUnitY(u)` | 坐标 |
| `SetUnitX(u, x)` / `SetUnitY(u, y)` | 设置坐标（不取消命令） |
| `SetUnitPosition(u, x, y)` | 设置位置（取消命令） |
| `GetUnitFacing(u)` / `SetUnitFacing(u, angle)` | 朝向 |
| `GetUnitMoveSpeed(u)` / `SetUnitMoveSpeed(u, v)` | 移速 |
| `GetUnitTypeId(u)` | 单位类型 ID |
| `GetOwningPlayer(u)` | 所属玩家 |
| `SetUnitOwner(u, player, changeColor)` | 改变所有者 |
| `GetUnitName(u)` | 单位名 |
| `GetHeroLevel(u)` / `SetHeroLevel(u, level, showEyeCandy)` | 英雄等级 |
| `GetHeroStr(u, includeBonuses)` | 力量 |
| `GetHeroAgi(u, includeBonuses)` | 敏捷 |
| `GetHeroInt(u, includeBonuses)` | 智力 |
| `GetHeroXP(u)` / `AddHeroXP(u, xp, showEyeCandy)` | 经验 |

### 状态常量

| 常量 | 说明 |
| --- | --- |
| `UNIT_STATE_LIFE` | 当前生命 |
| `UNIT_STATE_MAX_LIFE` | 最大生命 |
| `UNIT_STATE_MANA` | 当前魔法 |
| `UNIT_STATE_MAX_MANA` | 最大魔法 |

### 技能

| 函数 | 说明 |
| --- | --- |
| `UnitAddAbility(u, abilid)` | 添加技能 |
| `UnitRemoveAbility(u, abilid)` | 移除技能 |
| `GetUnitAbilityLevel(u, abilid)` | 技能等级 |
| `SetUnitAbilityLevel(u, abilid, level)` | 设置技能等级 |
| `IncUnitAbilityLevel(u, abilid)` | 提升技能等级 |
| `DecUnitAbilityLevel(u, abilid)` | 降低技能等级 |
| `SelectHeroSkill(u, abilid)` | 学习英雄技能 |

### 物品

| 函数 | 说明 |
| --- | --- |
| `UnitAddItem(u, item)` | 添加物品 |
| `UnitAddItemById(u, itemid)` | 按 ID 添加 |
| `UnitRemoveItem(u, item)` | 移除物品 |
| `UnitItemInSlot(u, slot)` | 获取槽位物品 |
| `UnitHasItem(u, item)` | 是否持有物品 |
| `UnitInventorySize(u)` | 背包大小 |

### 判断

| 函数 | 说明 |
| --- | --- |
| `IsUnitType(u, type)` | 是否某类型 |
| `IsUnitAlly(u, player)` | 是否盟友 |
| `IsUnitEnemy(u, player)` | 是否敌人 |
| `IsUnitAliveBJ(u)` | 是否存活 |
| `IsUnitInGroup(u, g)` | 是否在组中 |
| `IsUnitInRange(u, other, dist)` | 是否在范围内 |
| `IsUnitHidden(u)` | 是否隐藏 |
| `IsUnitIllusion(u)` | 是否幻象 |

### 单位类型常量

| 常量 | 说明 |
| --- | --- |
| `UNIT_TYPE_HERO` | 英雄 |
| `UNIT_TYPE_DEAD` | 死亡 |
| `UNIT_TYPE_STRUCTURE` | 建筑 |
| `UNIT_TYPE_FLYING` | 飞行 |
| `UNIT_TYPE_GROUND` | 地面 |
| `UNIT_TYPE_MECHANICAL` | 机械 |
| `UNIT_TYPE_PEON` | 农民 |
| `UNIT_TYPE_SUMMONED` | 召唤物 |
| `UNIT_TYPE_UNDEAD` | 不死 |
| `UNIT_TYPE_TAUREN` | 牛头人 |
| `UNIT_TYPE_ANCIENT` | 远古 |
| `UNIT_TYPE_MAGIC_IMMUNE` | 魔法免疫 |

## 3. 玩家 API

| 函数 | 说明 |
| --- | --- |
| `Player(index)` | 获取玩家（0-based） |
| `GetLocalPlayer()` | 本地玩家 |
| `GetPlayerName(p)` | 玩家名 |
| `GetPlayerId(p)` | 玩家 ID |
| `GetPlayerState(p, state)` | 玩家状态 |
| `SetPlayerState(p, state, value)` | 设置玩家状态 |
| `GetPlayerRace(p)` | 种族 |
| `GetPlayerColor(p)` | 颜色 |
| `GetPlayerTeam(p)` | 队伍 |
| `GetPlayerSlotState(p)` | 槽位状态 |
| `IsPlayerAlly(p1, p2)` | 是否盟友 |
| `IsPlayerEnemy(p1, p2)` | 是否敌人 |
| `IsPlayerInForce(p, force)` | 是否在玩家组 |
| `GetPlayerTechCount(p, techid, specificonly)` | 科技等级 |
| `SetPlayerTechResearched(p, techid, level)` | 设置科技等级 |

### 玩家状态常量

| 常量 | 说明 |
| --- | --- |
| `PLAYER_STATE_RESOURCE_GOLD` | 金币 |
| `PLAYER_STATE_RESOURCE_LUMBER` | 木材 |
| `PLAYER_STATE_RESOURCE_FOOD_USED` | 已用食物 |
| `PLAYER_STATE_RESOURCE_FOOD_CAP` | 食物上限 |
| `PLAYER_STATE_GOLD_GATHERED` | 累计金币 |
| `PLAYER_STATE_LUMBER_GATHERED` | 累计木材 |

### 玩家组

```jass
local force f = CreateForce()
call ForceAddPlayer(f, Player(0))
call ForceEnumPlayers(f, null)
call ForForce(f, function DoSomething)
call DestroyForce(f)
set f = null
```

| 函数 | 说明 |
| --- | --- |
| `CreateForce()` | 创建玩家组 |
| `ForceAddPlayer(f, p)` | 添加玩家 |
| `ForceRemovePlayer(f, p)` | 移除玩家 |
| `ForceEnumPlayers(f, filter)` | 枚举玩家 |
| `ForForce(f, callback)` | 遍历 |
| `DestroyForce(f)` | 销毁 |
| `GetPlayersAll()` | 所有玩家 |

## 4. 触发器 API

| 函数 | 说明 |
| --- | --- |
| `CreateTrigger()` | 创建触发器 |
| `DestroyTrigger(t)` | 销毁 |
| `TriggerAddAction(t, func)` | 添加动作 |
| `TriggerAddCondition(t, cond)` | 添加条件 |
| `TriggerRegisterTimerEvent(t, timeout, periodic)` | 计时器事件 |
| `TriggerRegisterTimerExpireEvent(t, timer)` | 计时器到期 |
| `TriggerRegisterGameEvent(t, event)` | 游戏事件 |
| `TriggerRegisterPlayerEvent(t, p, event)` | 玩家事件 |
| `TriggerRegisterPlayerUnitEvent(t, p, event, filter)` | 玩家单位事件 |
| `TriggerRegisterAnyUnitEventBJ(t, event)` | 任意单位事件 |
| `TriggerRegisterUnitEvent(t, u, event)` | 单位事件 |
| `TriggerRegisterEnterRegion(t, region, filter)` | 进入区域 |
| `TriggerRegisterLeaveRegion(t, region, filter)` | 离开区域 |
| `TriggerRegisterDeathEvent(t, widget)` | 死亡事件 |
| `TriggerRegisterDialogEvent(t, dialog)` | 对话框事件 |
| `TriggerRegisterPlayerChatEvent(t, p, msg, exact)` | 聊天事件 |
| `TriggerEvaluate(t)` | 评估条件 |
| `TriggerExecute(t)` | 执行动作 |
| `TriggerSleepAction(timeout)` | 等待（精度差） |
| `EnableTrigger(t)` / `DisableTrigger(t)` | 启用/禁用 |

### 常用事件常量

| 常量 | 说明 |
| --- | --- |
| `EVENT_GAME_VICTORY` | 游戏胜利 |
| `EVENT_GAME_END_LEVEL` | 关卡结束 |
| `EVENT_GAME_ENTER_REGION` | 进入区域 |
| `EVENT_GAME_LEAVE_REGION` | 离开区域 |
| `EVENT_PLAYER_UNIT_DEATH` | 单位死亡 |
| `EVENT_PLAYER_UNIT_ATTACKED` | 单位被攻击 |
| `EVENT_PLAYER_UNIT_SPELL_EFFECT` | 技能生效 |
| `EVENT_PLAYER_UNIT_SPELL_CAST` | 技能施放 |
| `EVENT_PLAYER_UNIT_SPELL_FINISH` | 技能结束 |
| `EVENT_PLAYER_UNIT_SPELL_CHANNEL` | 技能引导 |
| `EVENT_PLAYER_UNIT_SUMMON` | 召唤单位 |
| `EVENT_PLAYER_UNIT_SELL` | 出售单位 |
| `EVENT_PLAYER_UNIT_PICKUP_ITEM` | 拾取物品 |
| `EVENT_PLAYER_UNIT_DROP_ITEM` | 丢弃物品 |
| `EVENT_PLAYER_UNIT_USE_ITEM` | 使用物品 |
| `EVENT_PLAYER_UNIT_CONSTRUCT_FINISH` | 建造完成 |
| `EVENT_PLAYER_UNIT_TRAIN_FINISH` | 训练完成 |
| `EVENT_PLAYER_UNIT_RESEARCH_FINISH` | 研究完成 |
| `EVENT_PLAYER_UNIT_UPGRADE_FINISH` | 升级完成 |
| `EVENT_PLAYER_HERO_LEVEL` | 英雄升级 |
| `EVENT_PLAYER_HERO_SKILL` | 英雄学技能 |
| `EVENT_PLAYER_HERO_REVIVE_FINISH` | 英雄复活 |
| `EVENT_PLAYER_LEAVE` | 玩家离开 |
| `EVENT_PLAYER_CHAT` | 玩家聊天 |
| `EVENT_UNIT_DAMAGED` | 单位受伤 |
| `EVENT_UNIT_DEATH` | 单位死亡 |
| `EVENT_UNIT_ISSUED_ORDER` | 单位被下令 |
| `EVENT_UNIT_ACQUIRED_TARGET` | 单位获得目标 |
| `EVENT_UNIT_ATTACKED` | 单位被攻击 |

## 5. 计时器 API

| 函数 | 说明 |
| --- | --- |
| `CreateTimer()` | 创建计时器 |
| `DestroyTimer(t)` | 销毁 |
| `TimerStart(t, timeout, periodic, handler)` | 启动 |
| `PauseTimer(t)` / `ResumeTimer(t)` | 暂停/恢复 |
| `TimerGetElapsed(t)` | 已过时间 |
| `TimerGetRemaining(t)` | 剩余时间 |
| `TimerGetTimeout(t)` | 总时长 |
| `GetExpiredTimer()` | 到期的计时器 |

> **精度**：0ms 计时器约 10077 Hz（经典）/ 100 Hz（Reforged 1.32）。

## 6. 单位组 API

| 函数 | 说明 |
| --- | --- |
| `CreateGroup()` | 创建单位组 |
| `DestroyGroup(g)` | 销毁 |
| `GroupAddUnit(g, u)` | 添加单位 |
| `GroupRemoveUnit(g, u)` | 移除单位 |
| `GroupClear(g)` | 清空 |
| `GroupEnumUnitsInRange(g, x, y, radius, filter)` | 范围内枚举 |
| `GroupEnumUnitsInRect(g, rect, filter)` | 矩形内枚举 |
| `GroupEnumUnitsOfType(g, name, filter)` | 按类型枚举 |
| `GroupEnumUnitsOfPlayer(g, p, filter)` | 按玩家枚举 |
| `ForGroup(g, callback)` | 遍历 |
| `FirstOfGroup(g)` | 第一个单位 |
| `IsUnitInGroup(u, g)` | 是否在组中 |
| `CountUnitsInGroup(g)` | 数量 |

## 7. 特效 API

| 函数 | 说明 |
| --- | --- |
| `AddSpecialEffect(model, x, y)` | 创建特效 |
| `AddSpecialEffectTarget(model, widget, attachPoint)` | 附着特效 |
| `AddSpecialEffectLoc(model, loc)` | 在点创建 |
| `DestroyEffect(e)` | 销毁特效 |
| `AddSpellEffectById(abilid, type, x, y)` | 技能特效 |
| `AddSpellEffectTargetById(abilid, type, widget, attachPoint)` | 技能附着特效 |

### 常用附着点

| 附着点 | 说明 |
| --- | --- |
| `"origin"` | 原点 |
| `"overhead"` | 头顶 |
| `"head"` | 头 |
| `"chest"` | 胸 |
| `"hand"` / `"left hand"` / `"right hand"` | 手 |
| `"foot"` / `"left foot"` / `"right foot"` | 脚 |
| `"weapon"` | 武器 |
| `"sprite"` | 精灵（血条上方） |

## 8. 声音/音乐 API

| 函数 | 说明 |
| --- | --- |
| `CreateSound(file, looping, is3D, stopOutOfRange, fadeIn, fadeOut, eax)` | 创建声音 |
| `CreateSoundFilenameWithLabel(...)` | 带标签创建 |
| `PlaySound(s)` / `PlaySoundBJ(s)` | 播放 |
| `StartSound(s)` | 开始 |
| `StopSound(s, killWhenDone, fadeOut)` | 停止 |
| `DestroySound(s)` | 销毁 |
| `SetSoundVolume(s, volume)` | 音量 |
| `SetSoundPitch(s, pitch)` | 音调 |
| `PlayMusic(file)` | 播放音乐 |
| `StopMusic(fadeOut)` | 停止音乐 |
| `SetMusicVolume(v)` | 音乐音量 |
| `PlayThematicMusic(file)` | 播放主题音乐 |

## 9. 摄像机 API

| 函数 | 说明 |
| --- | --- |
| `SetCameraPosition(x, y)` | 设置位置 |
| `PanCameraTo(x, y)` | 平移 |
| `PanCameraToTimed(x, y, duration)` | 定时平移 |
| `SetCameraField(field, value, duration)` | 设置字段 |
| `AdjustCameraField(field, offset, duration)` | 调整字段 |
| `SetCameraTargetController(u, xoff, yoff, inherit)` | 跟随单位 |
| `ResetToGameCamera(duration)` | 重置 |
| `SetCameraBounds(x1, y1, x2, y2, x3, y3, x4, y4)` | 设置边界 |

### 摄像机字段常量

| 常量 | 说明 |
| --- | --- |
| `CAMERA_FIELD_TARGET_DISTANCE` | 目标距离 |
| `CAMERA_FIELD_FARZ` | 远裁剪面 |
| `CAMERA_FIELD_ANGLE_OF_ATTACK` | 攻击角度 |
| `CAMERA_FIELD_FIELD_OF_VIEW` | 视野 |
| `CAMERA_FIELD_ROLL` | 翻滚 |
| `CAMERA_FIELD_ROTATION` | 旋转 |
| `CAMERA_FIELD_ZOFFSET` | Z 偏移 |

## 10. 对话框 API

| 函数 | 说明 |
| --- | --- |
| `DialogCreate()` | 创建对话框 |
| `DialogDestroy(d)` | 销毁 |
| `DialogClear(d)` | 清空 |
| `DialogSetMessage(d, msg)` | 设置标题 |
| `DialogAddButton(d, text, hotkey)` | 添加按钮 |
| `DialogAddQuitButton(d, doScoreScreen, text, hotkey)` | 添加退出按钮 |
| `DialogDisplay(p, d, flag)` | 显示/隐藏 |
| `GetClickedButton()` | 被点击的按钮 |
| `GetClickedDialog()` | 被点击的对话框 |

## 11. 文本/多面板 API

| 函数 | 说明 |
| --- | --- |
| `DisplayTextToPlayer(p, x, y, msg)` | 显示文本 |
| `DisplayTimedTextToPlayer(p, x, y, duration, msg)` | 定时显示 |
| `DisplayTimedTextFromPlayer(p, x, y, duration, msg)` | 带玩家名前缀 |
| `ClearTextMessages()` | 清除文本 |
| `CreateMultiboard()` | 创建多面板 |
| `MultiboardDisplay(mb, show)` | 显示 |
| `MultiboardSetTitleText(mb, text)` | 设置标题 |
| `MultiboardSetRowCount(mb, count)` | 行数 |
| `MultiboardSetColumnCount(mb, count)` | 列数 |
| `MultiboardGetItem(mb, row, col)` | 获取单元格 |
| `MultiboardSetItemValue(item, val)` | 设置值 |
| `CreateLeaderboard()` | 创建排行榜 |
| `LeaderboardAddItem(lb, label, value, p)` | 添加项 |
| `CreateTextTag()` | 创建浮动文字 |
| `SetTextTagText(t, text, height)` | 设置文本 |
| `SetTextTagPos(t, x, y, z)` | 设置位置 |
| `SetTextTagColor(t, r, g, b, a)` | 设置颜色 |
| `SetTextTagVelocity(t, xv, yv)` | 设置速度 |
| `SetTextTagLifespan(t, duration)` | 生命周期 |
| `DestroyTextTag(t)` | 销毁 |

## 12. 数学函数

| 函数 | 说明 |
| --- | --- |
| `Sin(r)` / `Cos(r)` / `Tan(r)` | 三角函数 |
| `Asin(r)` / `Acos(r)` / `Atan(r)` | 反三角 |
| `Atan2(y, x)` | 反正切（两参数） |
| `Pow(x, power)` | 幂 |
| `SquareRoot(r)` | 平方根 |
| `Deg2Rad(deg)` / `Rad2Deg(rad)` | 角度弧度转换 |
| `GetRandomInt(low, high)` | 随机整数 |
| `GetRandomReal(low, high)` | 随机实数 |
| `SetRandomSeed(seed)` | 设置随机种子 |
| `I2R(i)` / `R2I(r)` | 整数实数转换 |
| `I2S(i)` / `S2I(s)` | 整数字符串转换 |
| `R2S(r)` / `S2R(s)` | 实数字符串转换 |

## 13. 字符串函数

| 函数 | 说明 |
| --- | --- |
| `StringLength(s)` | 长度（字节） |
| `SubString(s, start, end)` | 子串 |
| `StringCase(s, upper)` | 大小写转换 |
| `StringHash(s)` | 哈希值 |
| `GetLocalizedString(key)` | 本地化字符串 |
| `GetLocalizedHotkey(key)` | 本地化热键 |

## 14. 游戏状态

| 函数 | 说明 |
| --- | --- |
| `GetGameTime()` | 游戏时间 |
| `GetGameDifficulty()` | 难度 |
| `GetGameSpeed()` | 速度 |
| `SetGameSpeed(speed)` | 设置速度 |
| `GetFloatGameState(state)` | 浮点游戏状态 |
| `GetIntegerGameState(state)` | 整数游戏状态 |
| `SetFloatGameState(state, value)` | 设置浮点状态 |
| `SetIntegerGameState(state, value)` | 设置整数状态 |
| `DisplayTextToPlayer(...)` | 显示文本 |
| `EndGame(doScoreScreen)` | 结束游戏 |
| `ChangeLevel(newLevel, doScoreScreen)` | 切换关卡 |
| `RestartGame(doScoreScreen)` | 重开 |

## 15. 完整 API 查询

- **Jassbot**（在线搜索）：https://lep.nrw/jassbot/
- **JassDoc**（源码注解）：https://github.com/lep/jassdoc
- **common.j**：https://github.com/lep/jassdoc/blob/master/common.j
- **Blizzard.j**：https://github.com/lep/jassdoc/blob/master/Blizzard.j
- **VSCode 扩展**：
  - [wc3-lua-natives](https://github.com/Tomotz/wc3-lua-natives)
  - [Jass API Search](https://github.com/toeneeoh/jass-api-search)
