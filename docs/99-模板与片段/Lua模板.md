# Lua 模板

> 常用 Lua 代码模板（Reforged 1.31+）

## 1. 地图初始化

```lua
-- 地图初始化（在 main 之前或 OnLibraryInit 中）
function InitGlobals()
    -- 全局变量初始化
end

function InitTriggers()
    -- 注册所有触发器
    InitTrig_MyTrigger()
end

function main()
    InitGlobals()
    InitTriggers()
    -- 其他初始化
end
```

## 2. 触发器模板

```lua
-- 单位死亡触发器
function InitTrig_UnitDeath()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(t, function()
        local dying = GetDyingUnit()
        local killer = GetKillingUnit()
        if not killer then return end
        -- 自定义逻辑
    end)
end
```

## 3. 计时器循环

```lua
-- 周期性计时器
local function StartPeriodic(interval, callback)
    local t = CreateTimer()
    TimerStart(t, interval, true, callback)
    return t
end

-- 一次性延迟
local function Delay(seconds, callback)
    local t = CreateTimer()
    TimerStart(t, seconds, false, function()
        DestroyTimer(t)
        callback()
    end)
end
```

## 4. 单位组操作

```lua
-- 遍历范围内单位
local function ForUnitsInRange(x, y, radius, callback)
    local g = CreateGroup()
    GroupEnumUnitsInRange(g, x, y, radius, nil)
    ForGroup(g, function()
        callback(GetEnumUnit())
    end)
    DestroyGroup(g)
end

-- 遍历矩形内单位
local function ForUnitsInRect(rect, callback)
    local g = CreateGroup()
    GroupEnumUnitsInRect(g, rect, nil)
    ForGroup(g, function()
        callback(GetEnumUnit())
    end)
    DestroyGroup(g)
end
```

## 5. 面向对象模板

```lua
-- 类定义
local MyClass = {}
MyClass.__index = MyClass

function MyClass.new(...)
    local self = setmetatable({}, MyClass)
    self:init(...)
    return self
end

function MyClass:init(...)
    -- 初始化
end

function MyClass:destroy()
    -- 清理
end

return MyClass
```

## 6. 投射物系统

```lua
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(caster, target, model, speed, onHit)
    local self = setmetatable({}, Projectile)
    self.caster = caster
    self.target = target
    self.model = model
    self.speed = speed
    self.onHit = onHit
    self.x = GetUnitX(caster)
    self.y = GetUnitY(caster)
    self.fx = AddSpecialEffect(model, self.x, self.y)
    self.timer = CreateTimer()
    TimerStart(self.timer, 0.03, true, function() self:update() end)
    return self
end

function Projectile:update()
    local tx = GetUnitX(self.target)
    local ty = GetUnitY(self.target)
    local dx = tx - self.x
    local dy = ty - self.y
    local dist = math.sqrt(dx * dx + dy * dy)

    if dist < 50 then
        self:destroy()
        if self.onHit then self.onHit(self.target) end
        return
    end

    local step = self.speed * 0.03
    self.x = self.x + dx / dist * step
    self.y = self.y + dy / dist * step
    BlzSetSpecialEffectPosition(self.fx, self.x, self.y, 0)
end

function Projectile:destroy()
    DestroyTimer(self.timer)
    DestroyEffect(self.fx)
    self.timer = nil
    self.fx = nil
end

return Projectile
```

## 7. 伤害检测

```lua
-- 注册伤害事件
function InitTrig_Damage()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddAction(t, function()
        local target = GetTriggerUnit()
        local source = GetEventDamageSource()
        local damage = GetEventDamage()
        -- 修改伤害
        -- BlzSetEventDamage(damage * 1.5)
    end)
end
```

## 8. 多面板模板

```lua
local function CreateScoreboard()
    local mb = CreateMultiboard()
    MultiboardSetColumnCount(mb, 3)
    MultiboardSetRowCount(mb, 5)
    MultiboardSetTitleText(mb, "计分板")
    MultiboardSetItemsStyle(mb, true, false)
    MultiboardSetItemsWidth(mb, 0.05)
    MultiboardSetItemsValueColor(mb, 255, 255, 255, 255)
    MultiboardDisplay(mb, true)
    return mb
end

local function SetScore(mb, row, col, value)
    local item = MultiboardGetItem(mb, row, col)
    MultiboardSetItemValue(item, value)
    MultiboardReleaseItem(item)
end
```

## 9. 对话框模板

```lua
local function ShowDialog(player, title, options, callback)
    local d = DialogCreate()
    DialogSetMessage(d, title)
    local buttons = {}
    for i, opt in ipairs(options) do
        buttons[i] = DialogAddButton(d, opt.text, opt.hotkey or 0)
    end
    DialogDisplay(player, d, true)

    local t = CreateTrigger()
    TriggerRegisterDialogEvent(t, d)
    TriggerAddAction(t, function()
        local clicked = GetClickedButton()
        for i, b in ipairs(buttons) do
            if clicked == b then
                callback(i)
                break
            end
        end
        DialogDestroy(d)
        DestroyTrigger(t)
    end)
end
```

## 10. 工具函数

```lua
-- 距离
local function Distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- 角度（度）
local function AngleBetween(x1, y1, x2, y2)
    return math.deg(math.atan(y2 - y1, x2 - x1))
end

-- 随机点
local function RandomPointInCircle(x, y, radius)
    local angle = GetRandomReal(0, 2 * math.pi)
    local r = GetRandomReal(0, radius)
    return x + r * math.cos(angle), y + r * math.sin(angle)
end

-- 单位是否存活
local function IsUnitAlive(u)
    return u and GetUnitTypeId(u) ~= 0 and not IsUnitType(u, UNIT_TYPE_DEAD)
end
```

## 11. 闭包与哈希表

```lua
-- 用闭包替代哈希表（Lua 优势）
local function AttachData(unit, data)
    -- 直接用 table 关联
    return setmetatable({ unit = unit, data = data }, { __index = data })
end

-- 或用全局表
local unitData = {}
local function SetUnitData(u, key, value)
    local id = GetHandleId(u)
    unitData[id] = unitData[id] or {}
    unitData[id][key] = value
end

local function GetUnitData(u, key)
    local id = GetHandleId(u)
    return unitData[id] and unitData[id][key]
end
```

## 12. 单位索引器

```lua
-- 简单的单位索引系统
local unitIndex = 0
local unitList = {}

local function IndexUnit(u)
    unitIndex = unitIndex + 1
    unitList[unitIndex] = u
    SetUnitUserData(u, unitIndex)
    return unitIndex
end

local function GetIndexedUnit(index)
    return unitList[index]
end
```

## 参考

- Lua 指南：https://www.hiveworkshop.com/threads/a-comprehensive-guide-to-mapping-in-lua.341880/
- Hive Workshop 代码资源区
