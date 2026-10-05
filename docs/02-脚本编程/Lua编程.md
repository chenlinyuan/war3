# Lua 编程（Reforged）

> 适用：Warcraft III Reforged 1.31+（Lua 5.3）

## 1. 启用 Lua

1. World Editor → **情节 → 地图选项**（或地图描述对话框）。
2. 设置 **脚本语言 = Lua**。
3. 保存后生成 `war3map.lua`。

或直接编辑 `war3map.w3i` 的脚本语言字段。

## 2. 与 JASS 的对应关系

| JASS | Lua |
| --- | --- |
| `'hfoo'` | `FourCC("hfoo")` |
| `null` | `nil` |
| `set x = y` | `x = y` |
| `call f()` | `f()` |
| `function ... endfunction` | `function ... end` |
| `local integer i = 0` | `local i = 0` |
| `globals ... endglobals` | 直接赋值（不推荐） |
| `if ... then ... endif` | `if ... then ... end` |
| `loop ... exitwhen ... endloop` | `while ... do ... end` |
| `and` / `or` / `not` | `and` / `or` / `not` |
| `bj_MAX_PLAYERS` | `bj_MAX_PLAYERS` |
| `GetLocalPlayer()` | `GetLocalPlayer()` |

## 3. 基本结构

### 函数与触发器

```lua
function MyActions()
    print("Hello from Lua!")
    BJDebugMsg("Hello from Lua!")
end

function InitTrig_MyTrigger()
    local t = CreateTrigger()
    TriggerRegisterTimerEvent(t, 5.0, true)
    TriggerAddAction(t, MyActions)
end
```

### 闭包（Lua 优势）

```lua
function InitTrig_MyTrigger()
    local t = CreateTrigger()
    TriggerRegisterTimerEvent(t, 5.0, true)
    TriggerAddAction(t, function()
        -- 可直接访问外部变量，无需哈希表传递
        BJDebugMsg("Tick: " .. GetGameTime())
    end)
end
```

### 面向对象

```lua
local Unit = {}
Unit.__index = Unit

function Unit.new(player, id, x, y, face)
    local self = setmetatable({}, Unit)
    self.handle = CreateUnit(player, id, x, y, face or 90)
    self.id = id
    return self
end

function Unit:setLife(life)
    SetUnitState(self.handle, UNIT_STATE_LIFE, life)
end

function Unit:destroy()
    if self.handle then
        RemoveUnit(self.handle)
        self.handle = nil
    end
end

-- 使用
local u = Unit.new(Player(0), FourCC("hfoo"), 0, 0)
u:setLife(100)
u:destroy()
```

## 4. 数据类型映射

| War3 类型 | Lua 类型 |
| --- | --- |
| `integer` | `number` |
| `real` | `number` |
| `boolean` | `boolean` |
| `string` | `string` |
| `handle` 及子类 | `userdata` |
| `code` | `function` |
| 数组 | `table` |

## 5. 常用 API（Lua 版）

### 单位

```lua
local u = CreateUnit(Player(0), FourCC("hfoo"), 0, 0, 90)
SetUnitState(u, UNIT_STATE_LIFE, 100.0)
SetUnitPosition(u, 100, 100)
KillUnit(u)
RemoveUnit(u)
```

### 触发器

```lua
local t = CreateTrigger()
TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
TriggerAddAction(t, function()
    local dying = GetDyingUnit()
    local killer = GetKillingUnit()
    print(GetUnitName(dying) .. " 被 " .. GetUnitName(killer) .. " 击杀")
end)
```

### 计时器

```lua
local t = CreateTimer()
TimerStart(t, 1.0, true, function()
    BJDebugMsg("每秒触发")
end)
-- 注意：不要销毁正在运行的计时器；用 PauseTimer + DestroyTimer
```

### 哈希表

```lua
local ht = InitHashtable()
SaveInteger(ht, GetHandleId(u), 0, 42)
local v = LoadInteger(ht, GetHandleId(u), 0)
FlushChildHashtable(ht, GetHandleId(u))
DestroyHashtable(ht)
```

### 单位组

```lua
local g = CreateGroup()
GroupEnumUnitsInRange(g, 0, 0, 500, nil)
ForGroup(g, function()
    local u = GetEnumUnit()
    -- 处理单位
end)
DestroyGroup(g)
```

## 6. 内存管理

**Lua 与 JASS 的关键差异**：

| 项 | JASS | Lua |
| --- | --- | --- |
| 对象销毁 | 手动 `RemoveXxx` | 仍需手动 `RemoveXxx` |
| 引用置 null | **必须** | **不需要**（GC 管理） |
| 死引用 | 无此概念 | 需注意 table 中的失效引用 |

### 仍需手动销毁的对象

```lua
-- 这些仍然必须手动销毁
DestroyGroup(g)
DestroyTimer(t)
RemoveLocation(loc)
RemoveRect(r)
DestroyEffect(e)
DestroyHashtable(ht)
DestroyTrigger(trg)
```

### 不需要手动置 nil

```lua
function DoStuff()
    local u = CreateUnit(...)
    -- ...
    RemoveUnit(u)
    -- 不需要 u = nil，函数结束时自动回收
end
```

### 死引用问题

```lua
-- 如果 table 长期持有已销毁对象的引用，会形成"死引用"
local cache = {}
cache[GetHandleId(u)] = u
RemoveUnit(u)
-- cache 中仍持有引用，需手动清理
cache[GetHandleId(u)] = nil
```

## 7. Desync 陷阱

### 7.1 GetLocalPlayer

```lua
-- 安全：仅视觉效果
if GetLocalPlayer() == Player(0) then
    SetCameraPosition(0, 0)
end

-- 危险：改变游戏状态 → desync
if GetLocalPlayer() == Player(0) then
    KillUnit(someUnit)  -- 只有本地玩家执行！
end
```

### 7.2 table 遍历顺序

```lua
-- 危险：pairs 遍历顺序在不同客户端可能不同
for k, v in pairs(unitTable) do
    -- 如果 k 是 unit（handle），顺序不确定
    DoSomething(v)
end

-- 安全：用数组或排序后的 key
local ids = {}
for k in pairs(unitTable) do
    table.insert(ids, k)
end
table.sort(ids)
for _, k in ipairs(ids) do
    DoSomething(unitTable[k])
end
```

### 7.3 随机数

```lua
-- math.random 在异步上下文中会导致 desync
-- 确保在所有客户端同步调用
```

### 7.4 table.sort 不稳定排序

```lua
-- 相等元素的顺序可能不同 → desync
-- 解决：添加唯一 tie-breaker
table.sort(list, function(a, b)
    if a.value == b.value then
        return a.id < b.id  -- 唯一键
    end
    return a.value < b.value
end)
```

详见 [`内存泄漏与Desync.md`](内存泄漏与Desync.md)。

## 8. 覆盖原生函数

Lua 允许覆盖 War3 原生函数（高级技巧）：

```lua
-- 保存原始函数
local originalCreateUnit = CreateUnit

-- 覆盖
function CreateUnit(player, id, x, y, face)
    local u = originalCreateUnit(player, id, x, y, face)
    -- 自定义逻辑，如自动注册单位
    RegisterUnit(u)
    return u
end
```

> ⚠️ 谨慎使用，可能破坏其他系统。

## 9. 调试

```lua
print("调试信息")                    -- 输出到日志
BJDebugMsg("调试信息")               -- 游戏内显示
DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "消息")
```

Lua 错误日志位于：

```
Documents\Warcraft III\Errors\
```

## 10. 代码组织

### 全局初始化（推荐模式）

```lua
-- 使用 Bribe 的 Global Initialization
OnLibraryInit(function()
    -- 所有库加载完成后执行
    InitMySystem()
end)
```

### 模块化

```lua
-- 每个系统一个文件，通过 require 或全局表组织
MySystem = MySystem or {}
MySystem.config = { ... }

function MySystem.init()
    -- ...
end
```

## 参考

- **Lua 指南**：https://www.hiveworkshop.com/threads/a-comprehensive-guide-to-mapping-in-lua.341880/
- **JassDoc**：https://github.com/lep/jassdoc
- **vJASS → Lua 迁移**：https://www.hiveworkshop.com/threads/lua-switching-from-vjass-to-lua-structs-methods-modules-and-more.339479/
- **Lua 5.3 手册**：https://www.lua.org/manual/5.3/
