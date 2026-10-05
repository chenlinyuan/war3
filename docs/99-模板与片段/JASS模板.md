# JASS 模板

> 常用 JASS 代码模板

## 1. 触发器模板

```jass
//===========================================================================
// 单位死亡触发器
//===========================================================================
function Trig_UnitDeath_Conditions takes nothing returns boolean
    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true
endfunction

function Trig_UnitDeath_Actions takes nothing returns nothing
    local unit dying = GetDyingUnit()
    local unit killer = GetKillingUnit()

    if killer != null then
        call BJDebugMsg(GetUnitName(dying) + " 被 " + GetUnitName(killer) + " 击杀")
    endif

    set dying = null
    set killer = null
endfunction

//===========================================================================
function InitTrig_UnitDeath takes nothing returns nothing
    set gg_trg_UnitDeath = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_UnitDeath, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_UnitDeath, Condition(function Trig_UnitDeath_Conditions))
    call TriggerAddAction(gg_trg_UnitDeath, function Trig_UnitDeath_Actions)
endfunction
```

## 2. 计时器模板

```jass
//===========================================================================
// 周期性计时器
//===========================================================================
function PeriodicCallback takes nothing returns nothing
    // 每秒执行
endfunction

function InitPeriodic takes nothing returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 1.0, true, function PeriodicCallback)
    // 注意：不要在回调中销毁计时器
endfunction

//===========================================================================
// 一次性延迟
//===========================================================================
function DelayCallback takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call DestroyTimer(t)
    set t = null
    // 延迟后执行
endfunction

function Delay takes real seconds returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, seconds, false, function DelayCallback)
endfunction
```

## 3. 单位组模板

```jass
//===========================================================================
// 遍历范围内单位
//===========================================================================
function ForUnitsInRangeCallback takes nothing returns nothing
    local unit u = GetEnumUnit()
    // 处理单位
    set u = null
endfunction

function ForUnitsInRange takes real x, real y, real radius returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, radius, null)
    call ForGroup(g, function ForUnitsInRangeCallback)
    call DestroyGroup(g)
    set g = null
endfunction
```

## 4. 单位创建模板

```jass
//===========================================================================
// 创建单位并初始化
//===========================================================================
function CreateMyUnit takes player p, real x, real y returns unit
    local unit u = CreateUnit(p, 'hfoo', x, y, 90.0)
    call SetUnitState(u, UNIT_STATE_LIFE, 100.0)
    call UnitAddAbility(u, 'Adef')
    return u
endfunction
```

## 5. 伤害检测模板

```jass
//===========================================================================
// 伤害事件
//===========================================================================
function Trig_Damage_Actions takes nothing returns nothing
    local unit target = GetTriggerUnit()
    local unit source = GetEventDamageSource()
    local real damage = GetEventDamage()

    // 修改伤害（需 1.31+）
    // call BlzSetEventDamage(damage * 1.5)

    set target = null
    set source = null
endfunction

function InitTrig_Damage takes nothing returns nothing
    set gg_trg_Damage = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Damage, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddAction(gg_trg_Damage, function Trig_Damage_Actions)
endfunction
```

## 6. 哈希表模板

```jass
//===========================================================================
// 使用哈希表存储单位数据
//===========================================================================
globals
    hashtable udg_UnitData = InitHashtable()
endglobals

function SetUnitValue takes unit u, integer key, integer value returns nothing
    call SaveInteger(udg_UnitData, GetHandleId(u), key, value)
endfunction

function GetUnitValue takes unit u, integer key returns integer
    return LoadInteger(udg_UnitData, GetHandleId(u), key)
endfunction

function ClearUnitData takes unit u returns nothing
    call FlushChildHashtable(udg_UnitData, GetHandleId(u))
endfunction
```

## 7. 多面板模板

```jass
//===========================================================================
// 创建多面板
//===========================================================================
function CreateScoreboard takes nothing returns multiboard
    local multiboard mb = CreateMultiboard()
    local multiboarditem mbi

    call MultiboardSetColumnCount(mb, 3)
    call MultiboardSetRowCount(mb, 5)
    call MultiboardSetTitleText(mb, "计分板")
    call MultiboardSetItemsStyle(mb, true, false)
    call MultiboardSetItemsWidth(mb, 0.05)
    call MultiboardDisplay(mb, true)

    return mb
endfunction

function SetScore takes multiboard mb, integer row, integer col, string value returns nothing
    local multiboarditem mbi = MultiboardGetItem(mb, row, col)
    call MultiboardSetItemValue(mbi, value)
    call MultiboardReleaseItem(mbi)
    set mbi = null
endfunction
```

## 8. 对话框模板

```jass
//===========================================================================
// 对话框
//===========================================================================
globals
    dialog g_dialog = null
    button g_button1 = null
    button g_button2 = null
endglobals

function DialogClick takes nothing returns nothing
    local button clicked = GetClickedButton()

    if clicked == g_button1 then
        call BJDebugMsg("点击了按钮 1")
    elseif clicked == g_button2 then
        call BJDebugMsg("点击了按钮 2")
    endif

    call DialogDestroy(g_dialog)
    set g_dialog = null
    set clicked = null
endfunction

function ShowMyDialog takes player p returns nothing
    local trigger t

    set g_dialog = DialogCreate()
    call DialogSetMessage(g_dialog, "选择")
    set g_button1 = DialogAddButton(g_dialog, "选项 1", 0)
    set g_button2 = DialogAddButton(g_dialog, "选项 2", 0)
    call DialogDisplay(p, g_dialog, true)

    set t = CreateTrigger()
    call TriggerRegisterDialogEvent(t, g_dialog)
    call TriggerAddAction(t, function DialogClick)
endfunction
```

## 9. 工具函数

```jass
//===========================================================================
// 距离
//===========================================================================
function DistanceBetweenPoints takes real x1, real y1, real x2, real y2 returns real
    local real dx = x2 - x1
    local real dy = y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

//===========================================================================
// 角度（度）
//===========================================================================
function AngleBetweenPoints takes real x1, real y1, real x2, real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

//===========================================================================
// 单位是否存活
//===========================================================================
function IsUnitAlive takes unit u returns boolean
    return GetUnitTypeId(u) != 0 and not IsUnitType(u, UNIT_TYPE_DEAD)
endfunction

//===========================================================================
// 随机点
//===========================================================================
function GetRandomPointInCircle takes real x, real y, real radius returns location
    local real angle = GetRandomReal(0, 2 * bj_PI)
    local real r = GetRandomReal(0, radius)
    return Location(x + r * Cos(angle), y + r * Sin(angle))
endfunction
```

## 10. 库初始化模板（vJASS）

```jass
//===========================================================================
// vJASS 库模板
//===========================================================================
library MyLibrary initializer Init requires SomeLibrary

    globals
        private constant real PERIOD = 0.03125
        private timer g_timer = CreateTimer()
    endglobals

    private function OnPeriod takes nothing returns nothing
        // 周期性逻辑
    endfunction

    private function Init takes nothing returns nothing
        call TimerStart(g_timer, PERIOD, true, function OnPeriod)
    endfunction

endlibrary
```

## 11. 结构体模板（vJASS）

```jass
//===========================================================================
// vJASS 结构体
//===========================================================================
struct MyStruct
    unit u
    integer id
    real x
    real y

    static method create takes player p, integer unitId, real x, real y returns thistype
        local thistype this = thistype.allocate()
        set this.u = CreateUnit(p, unitId, x, y, 90.0)
        set this.id = unitId
        set this.x = x
        set this.y = y
        return this
    endmethod

    method destroy takes nothing returns nothing
        call RemoveUnit(this.u)
        set this.u = null
        call this.deallocate()
    endmethod

    method moveTo takes real newX, real newY returns nothing
        set this.x = newX
        set this.y = newY
        call SetUnitPosition(this.u, newX, newY)
    endmethod
endstruct
```

## 参考

- JassDoc：https://github.com/lep/jassdoc
- Hive Workshop 代码资源区
