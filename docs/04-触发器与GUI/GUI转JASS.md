# GUI 转 JASS 对照

GUI 触发器编译后生成 JASS（`war3map.j`）。本页给出常见 GUI 操作与代码的对应。

## 1. 结构对照

### GUI 触发器

```
触发器 MyTrigger
├── 事件: 时间 - 每 5.00 秒游戏时间
├── 条件: (无)
└── 动作: 游戏 - 显示文本给 (所有玩家): "Tick"
```

### 生成的 JASS

```jass
function Trig_MyTrigger_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "Tick")
endfunction

//===========================================================================
function InitTrig_MyTrigger takes nothing returns nothing
    set gg_trg_MyTrigger = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_MyTrigger, 5.00)
    call TriggerAddAction(gg_trg_MyTrigger, function Trig_MyTrigger_Actions)
endfunction
```

### 等价的 Lua

```lua
function Trig_MyTrigger_Actions()
    DisplayTextToForce(GetPlayersAll(), "Tick")
end

function InitTrig_MyTrigger()
    gg_trg_MyTrigger = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_MyTrigger, 5.00)
    TriggerAddAction(gg_trg_MyTrigger, Trig_MyTrigger_Actions)
end
```

## 2. 常用 GUI 动作对照表

| GUI 动作 | JASS |
| --- | --- |
| 显示文本给所有玩家 | `call DisplayTextToForce(GetPlayersAll(), "text")` |
| 显示文本给玩家 | `call DisplayTextToPlayer(Player(0), 0, 0, "text")` |
| 杀死单位 | `call KillUnit(GetTriggerUnit())` |
| 移除单位 | `call RemoveUnit(GetTriggerUnit())` |
| 创建单位 | `call CreateUnit(Player(0), 'hfoo', x, y, 90)` |
| 设置单位生命 | `call SetUnitState(u, UNIT_STATE_LIFE, 100.0)` |
| 设置单位魔法 | `call SetUnitState(u, UNIT_STATE_MANA, 50.0)` |
| 移动单位到点 | `call SetUnitPosition(u, x, y)` |
| 添加技能 | `call UnitAddAbility(u, 'AHhb')` |
| 移除技能 | `call UnitRemoveAbility(u, 'AHhb')` |
| 设置技能等级 | `call SetUnitAbilityLevel(u, 'AHhb', 2)` |
| 设置玩家金币 | `call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, 1000)` |
| 设置玩家木材 | `call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, 1000)` |
| 创建特效 | `call AddSpecialEffect("model.mdl", x, y)` |
| 销毁特效 | `call DestroyEffect(e)` |
| 播放声音 | `call PlaySoundBJ(sound)` |
| 平移摄像机 | `call PanCameraToTimed(x, y, 1.0)` |
| 创建对话框 | `call DialogCreate()` |
| 显示对话框 | `call DialogDisplay(p, d, true)` |
| 运行触发器 | `call TriggerExecute(trg)` |
| 等待 | `call TriggerSleepAction(1.0)` |
| 选取单位组 | `call ForGroup(g, function callback)` |

## 3. 事件对照表

| GUI 事件 | JASS |
| --- | --- |
| 地图初始化 | `call TriggerRegisterTimerEvent(t, 0.0, false)` |
| 每 X 秒 | `call TriggerRegisterTimerEventPeriodic(t, X)` |
| 单位死亡 | `call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)` |
| 单位施放技能 | `call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)` |
| 单位进入区域 | `call TriggerRegisterEnterRegion(t, region, null)` |
| 单位离开区域 | `call TriggerRegisterLeaveRegion(t, region, null)` |
| 玩家输入聊天 | `call TriggerRegisterPlayerChatEvent(t, p, "msg", true)` |
| 玩家离开 | `call TriggerRegisterPlayerEvent(t, p, EVENT_PLAYER_LEAVE)` |
| 对话框点击 | `call TriggerRegisterDialogEvent(t, dialog)` |
| 单位获得物品 | `call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)` |

## 4. 条件对照表

| GUI 条件 | JASS |
| --- | --- |
| 单位是英雄 | `IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)` |
| 单位是建筑 | `IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE)` |
| 单位存活 | `not IsUnitType(GetTriggerUnit(), UNIT_TYPE_DEAD)` |
| 玩家是敌人 | `IsPlayerEnemy(GetTriggerPlayer(), Player(0))` |
| 整数比较 | `udg_MyInt > 100` |
| 实数比较 | `udg_MyReal < 50.0` |
| 字符串相等 | `GetEventPlayerChatString() == "test"` |
| And | `And(cond1, cond2)` |
| Or | `Or(cond1, cond2)` |
| Not | `Not(cond)` |

## 5. 变量对照

| GUI 变量 | JASS 变量 |
| --- | --- |
| `MyInt` | `udg_MyInt` |
| `MyReal` | `udg_MyReal` |
| `MyBool` | `udg_MyBool` |
| `MyString` | `udg_MyString` |
| `MyUnit` | `udg_MyUnit` |
| `MyGroup` | `udg_MyGroup` |
| `MyPoint` | `udg_MyPoint` |
| `MyRegion` | `udg_MyRegion` |
| `MyTrigger` | `gg_trg_MyTrigger` |

> GUI 变量统一加 `udg_` 前缀；触发器变量加 `gg_trg_` 前缀。

## 6. 点（location）的处理

GUI 中「点」是 location 对象，**必须销毁**：

```jass
function Trig_Example_Actions takes nothing returns nothing
    local location loc = GetUnitLoc(GetTriggerUnit())
    call SetUnitPositionLoc(udg_MyUnit, loc)
    call RemoveLocation(loc)   // 必须销毁！
    set loc = null
endfunction
```

GUI 会自动生成销毁代码，但自定义脚本需手动处理。

## 7. 单位组的处理

```jass
function Trig_Example_Actions takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, null)
    call ForGroup(g, function DoSomething)
    call DestroyGroup(g)       // 必须销毁！
    set g = null
endfunction
```

## 8. 从 GUI 迁移到 Lua 的建议

1. **导出脚本**：World Editor → 文件 → 导出脚本，得到 `war3map.j`。
2. **理解逻辑**：阅读 JASS，理解事件-条件-动作。
3. **重写为 Lua**：
   - 去掉 `call`、`set`、`local 类型`
   - `'hfoo'` → `FourCC("hfoo")`
   - `null` → `nil`
   - `function ... endfunction` → `function ... end`
   - 用闭包替代哈希表传递数据
4. **测试**：逐触发器迁移并测试。

## 参考

- Hive Workshop GUI 教程
- JassDoc：https://github.com/lep/jassdoc
