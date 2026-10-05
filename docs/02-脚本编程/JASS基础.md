# JASS 基础

> 适用：所有 War3 版本

## 1. 基本语法

### 变量声明

```jass
globals
    // 全局变量
    integer g_count = 0
    unit array g_units
    constant real PI = 3.14159
endglobals

function Example takes nothing returns nothing
    // 局部变量必须声明在函数开头
    local integer i = 0
    local unit u = null
    local string s = "hello"
    // ...
endfunction
```

### 类型

| 类型 | 说明 |
| --- | --- |
| `integer` | 32 位整数 |
| `real` | 单精度浮点 |
| `boolean` | 布尔（true/false） |
| `string` | 字符串 |
| `code` | 函数引用 |
| `handle` | 对象引用基类 |
| `agent` | 引用计数对象 |
| `widget` | 可交互对象（unit/destructable/item 的父类） |
| `unit` | 单位 |
| `item` | 物品 |
| `destructable` | 可破坏物 |
| `player` | 玩家 |
| `group` | 单位组 |
| `force` | 玩家组 |
| `location` | 点 |
| `rect` | 矩形 |
| `region` | 区域 |
| `trigger` | 触发器 |
| `timer` | 计时器 |
| `effect` | 特效 |
| `sound` | 声音 |
| `hashtable` | 哈希表 |
| `gamecache` | 游戏缓存 |

### 函数定义

```jass
// 无参数无返回
function DoSomething takes nothing returns nothing
endfunction

// 带参数和返回
function Add takes integer a, integer b returns integer
    return a + b
endfunction

// 原生函数声明
native CreateUnit takes player id, integer unitid, real x, real y, real face returns unit
```

### 控制流

```jass
// if
if condition then
    // ...
elseif other then
    // ...
else
    // ...
endif

// loop
loop
    exitwhen i >= 10
    set i = i + 1
endloop

// while 模拟
loop
    exitwhen not condition
    // ...
endloop
```

> **JASS 没有 `break` 和 `continue`**，用 `exitwhen` 和 `if` 模拟。

### 运算符

| 运算符 | 说明 |
| --- | --- |
| `+` `-` `*` `/` | 算术 |
| `==` `!=` | 相等/不等 |
| `<` `>` `<=` `>=` | 比较 |
| `and` `or` `not` | 逻辑 |
| `+` | 字符串连接（也用于字符串） |

---

## 2. 触发器

### 创建触发器

```jass
function Trig_MyTrigger_Actions takes nothing returns nothing
    call BJDebugMsg("Hello!")
endfunction

function InitTrig_MyTrigger takes nothing returns nothing
    set gg_trg_MyTrigger = CreateTrigger()
    call TriggerRegisterTimerEvent(gg_trg_MyTrigger, 5.0, true)  // 每 5 秒
    call TriggerAddAction(gg_trg_MyTrigger, function Trig_MyTrigger_Actions)
endfunction
```

### 事件类型

| 函数 | 说明 |
| --- | --- |
| `TriggerRegisterTimerEvent` | 计时器事件 |
| `TriggerRegisterTimerExpireEvent` | 计时器到期 |
| `TriggerRegisterGameEvent` | 游戏事件 |
| `TriggerRegisterPlayerEvent` | 玩家事件 |
| `TriggerRegisterPlayerUnitEvent` | 玩家单位事件 |
| `TriggerRegisterUnitEvent` | 单位事件 |
| `TriggerRegisterEnterRegion` | 进入区域 |
| `TriggerRegisterLeaveRegion` | 离开区域 |
| `TriggerRegisterDeathEvent` | 死亡事件 |
| `TriggerRegisterDialogEvent` | 对话框事件 |

### 条件与过滤

```jass
function MyFilter takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'hfoo'
endfunction

function Trig_Test_Actions takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, Filter(function MyFilter))
    // ...
    call DestroyGroup(g)
    set g = null
endfunction
```

### 常用事件响应函数

| 函数 | 返回 |
| --- | --- |
| `GetTriggerUnit()` | 触发单位 |
| `GetTriggerPlayer()` | 触发玩家 |
| `GetTriggeringTrigger()` | 触发触发器 |
| `GetEnteringUnit()` | 进入区域的单位 |
| `GetLeavingUnit()` | 离开区域的单位 |
| `GetDyingUnit()` | 死亡单位 |
| `GetKillingUnit()` | 击杀单位 |
| `GetAttacker()` | 攻击者 |
| `GetAttackedUnit()` | 被攻击单位 |
| `GetSpellAbility()` | 施放的技能 |
| `GetSpellAbilityId()` | 技能 ID |
| `GetSpellTargetUnit()` | 技能目标单位 |
| `GetSpellTargetX()` / `Y()` | 技能目标坐标 |
| `GetSummonedUnit()` | 召唤的单位 |
| `GetSummoningUnit()` | 召唤者 |
| `GetSoldUnit()` | 出售的单位 |
| `GetBuyingUnit()` | 购买者 |
| `GetManipulatedItem()` | 操作的物品 |
| `GetOrderedUnit()` | 被下令的单位 |
| `GetIssuedOrderId()` | 命令 ID |
| `GetTriggerEventId()` | 事件 ID |

---

## 3. 常用操作

### 单位

```jass
local unit u = CreateUnit(Player(0), 'hfoo', 0, 0, 90)
call SetUnitState(u, UNIT_STATE_LIFE, 100.0)
call SetUnitPosition(u, 100, 100)
call SetUnitOwner(u, Player(1), true)
call KillUnit(u)
call RemoveUnit(u)
set u = null
```

### 单位组

```jass
local group g = CreateGroup()
call GroupEnumUnitsInRange(g, 0, 0, 500, null)
call ForGroup(g, function DoSomething)
call DestroyGroup(g)
set g = null
```

### 计时器

```jass
function TimerCallback takes nothing returns nothing
    call BJDebugMsg("Tick!")
endfunction

local timer t = CreateTimer()
call TimerStart(t, 1.0, true, function TimerCallback)
// 用完销毁
call DestroyTimer(t)
set t = null
```

### 特效

```jass
local effect e = AddSpecialEffect("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", 0, 0)
call DestroyEffect(e)
set e = null
```

### 哈希表

```jass
local hashtable ht = InitHashtable()
call SaveUnitHandle(ht, GetHandleId(u), 0, u)
call SaveInteger(ht, GetHandleId(u), 1, 42)
local unit stored = LoadUnitHandle(ht, GetHandleId(u), 0)
call FlushChildHashtable(ht, GetHandleId(u))
call DestroyHashtable(ht)
set ht = null
```

### 点与位置

```jass
local location loc = Location(100, 200)
call SetUnitPositionLoc(u, loc)
call RemoveLocation(loc)
set loc = null
```

---

## 4. 内存泄漏

JASS 中以下类型必须手动销毁，否则泄漏：

| 类型 | 销毁函数 |
| --- | --- |
| `group` | `DestroyGroup` |
| `force` | `DestroyForce` |
| `location` | `RemoveLocation` |
| `rect` | `RemoveRect` |
| `region` | `RemoveRegion` |
| `trigger` | `DestroyTrigger` |
| `timer` | `DestroyTimer` |
| `effect` | `DestroyEffect` |
| `sound` | `DestroySound` |
| `hashtable` | `DestroyHashtable` |
| `boolexpr` | `DestroyBoolExpr` |

**局部 `agent` 变量**（unit/item/player 等）必须置 `null`：

```jass
local unit u = CreateUnit(...)
// ...
call RemoveUnit(u)
set u = null  // 必须！
```

详见 [`内存泄漏与Desync.md`](内存泄漏与Desync.md)。

---

## 5. 数组

```jass
globals
    unit array g_units        // 大小 32768
    integer array g_values
endglobals

// 使用
set g_units[0] = CreateUnit(...)
set g_values[100] = 42
```

- 数组索引从 0 开始，最大 `JASS_MAX_ARRAY_SIZE - 1` = 32767。
- 不能动态增长。
- 多维数组需手动模拟（如 `index = row * width + col`）。

---

## 6. 字符串

```jass
local string s = "Hello, " + "World!"
local integer len = StringLength(s)
local string sub = SubString(s, 0, 5)     // "Hello"
local integer idx = StringHash(s)          // 哈希值
local string upper = StringCase(s, true)   // 大写
local integer num = S2I("123")             // 字符串转整数
local real r = S2R("1.5")                  // 字符串转实数
local string is = I2S(42)                  // 整数转字符串
local string rs = R2S(1.5)                 // 实数转字符串
```

### 颜色代码

```
|cffffcc00金色文字|r
```

格式：`|c` + AARRGGBB + 文本 + `|r`

---

## 7. 调试

```jass
call BJDebugMsg("调试信息")
call BJDebugMsg("单位生命: " + R2S(GetUnitState(u, UNIT_STATE_LIFE)))
call DisplayTextToPlayer(Player(0), 0, 0, "消息")
```

---

## 参考

- JassDoc：https://github.com/lep/jassdoc
- Jassbot：https://lep.nrw/jassbot/
- 常用函数速查：[`API参考.md`](API参考.md)
