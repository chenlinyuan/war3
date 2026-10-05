# 内存泄漏与 Desync

> War3 脚本开发中最常见的两类问题：内存泄漏（单机性能）与 desync（多人同步）。

## 一、内存泄漏（Memory Leak）

### 1.1 泄漏类型

| 类型 | 大小 | 说明 |
| --- | --- | --- |
| **对象泄漏** | 大 | 未销毁游戏对象（group/location 等） |
| **引用泄漏** | 小 | 未置 null 的 agent 变量（仅 JASS） |
| **死引用** | 小 | table 中持有已销毁对象的引用（Lua） |

### 1.2 必须销毁的对象

| 类型 | 销毁函数 | 备注 |
| --- | --- | --- |
| `group` | `DestroyGroup` | 每次创建都要销毁 |
| `force` | `DestroyForce` | |
| `location` | `RemoveLocation` | 最易泄漏 |
| `rect` | `RemoveRect` | |
| `region` | `RemoveRegion` | |
| `trigger` | `DestroyTrigger` | 不要销毁正在运行的 |
| `timer` | `DestroyTimer` | 不要销毁正在运行的 |
| `effect` | `DestroyEffect` | |
| `sound` | `DestroySound` | |
| `lightning` | `DestroyLightning` | |
| `image` | `DestroyImage` | |
| `ubersplat` | `DestroyUbersplat` | |
| `texttag` | `DestroyTextTag` | |
| `hashtable` | `DestroyHashtable` | |
| `gamecache` | `FlushGameCache` | |
| `boolexpr` | `DestroyBoolExpr` | Condition/Filter 创建的 |
| `dialog` | `DialogDestroy` | |
| `quest` | `DestroyQuest` | |
| `multiboard` | `DestroyMultiboard` | |
| `leaderboard` | `DestroyLeaderboard` | |
| `timerdialog` | `DestroyTimerDialog` | |
| `fogmodifier` | `DestroyFogModifier` | |

### 1.3 JASS 中的 null 置空

**所有局部 `agent` 类型变量**必须置 null：

```jass
function Example takes nothing returns nothing
    local unit u = CreateUnit(...)
    local player p = Player(0)
    local group g = CreateGroup()
    local location loc = Location(0, 0)
    local trigger t = CreateTrigger()
    local effect e = AddSpecialEffect(...)

    // ... 使用 ...

    call RemoveUnit(u)
    call DestroyGroup(g)
    call RemoveLocation(loc)
    call DestroyTrigger(t)
    call DestroyEffect(e)

    // 必须全部置 null
    set u = null
    set p = null
    set g = null
    set loc = null
    set t = null
    set e = null
endfunction
```

### 1.4 常见泄漏场景

#### 循环中创建对象

```jass
// ❌ 泄漏：每次循环创建 location 未销毁
loop
    exitwhen i >= 10
    call SetUnitPositionLoc(u, Location(0, 0))
    set i = i + 1
endloop

// ✅ 正确
local location loc = Location(0, 0)
loop
    exitwhen i >= 10
    call SetUnitPositionLoc(u, loc)
    set i = i + 1
endloop
call RemoveLocation(loc)
set loc = null
```

#### 单位组过滤

```jass
// ❌ 泄漏：Filter 创建的 boolexpr 未销毁
call GroupEnumUnitsInRange(g, 0, 0, 500, Filter(function MyFilter))

// ✅ 正确
local boolexpr b = Filter(function MyFilter)
call GroupEnumUnitsInRange(g, 0, 0, 500, b)
call DestroyBoolExpr(b)
set b = null
```

> 注意：`Condition`/`Filter` 在 JASS 中对同一函数返回同一 handle，销毁需谨慎。

#### 触发器条件

```jass
// 大多数 BJ 函数会自动销毁传入的 boolexpr
// 但自定义 Condition/Filter 需手动管理
```

### 1.5 Lua 中的内存管理

```lua
-- Lua 不需要置 nil，但仍需销毁游戏对象
local g = CreateGroup()
GroupEnumUnitsInRange(g, 0, 0, 500, nil)
ForGroup(g, callback)
DestroyGroup(g)  -- 必须

-- 死引用：table 长期持有已销毁对象
local cache = {}
cache[id] = unit
RemoveUnit(unit)
cache[id] = nil  -- 清理死引用
```

### 1.6 检测泄漏

- 观察游戏运行一段时间后的内存占用。
- 使用调试工具（部分第三方工具提供 handle 计数）。
- 代码审查：检查每个 `CreateXxx` 是否有对应 `DestroyXxx`。

---

## 二、Desync（同步错误）

### 2.1 什么是 Desync

War3 多人游戏采用**锁步（lock-step）同步**：所有客户端运行相同代码、相同数据。
一旦某客户端的状态与其他客户端不一致，游戏就会 **desync**（玩家掉线/游戏分裂）。

### 2.2 核心原则

> **任何影响游戏逻辑的操作，必须在所有客户端以相同方式执行。**

`GetLocalPlayer()` 返回当前客户端对应的玩家，用于**仅本地**的效果（如摄像机、UI）。

### 2.3 安全 vs 危险

```jass
// ✅ 安全：仅视觉/本地效果
if GetLocalPlayer() == Player(0) then
    call SetCameraPosition(0, 0)
    call ClearTextMessages()
endif

// ❌ 危险：改变游戏状态
if GetLocalPlayer() == Player(0) then
    call KillUnit(u)          // 只有玩家 0 的单位死亡 → desync
    call CreateUnit(...)      // 只有玩家 0 创建单位 → desync
    call SetUnitState(u, ...) // 状态不一致 → desync
endif
```

### 2.4 安全的本地操作

| 类别 | 示例 |
| --- | --- |
| 摄像机 | `SetCameraPosition`, `PanCameraTo` |
| UI 文本 | `DisplayTextToPlayer`（对单个玩家） |
| 声音 | `PlaySound`（本地播放） |
| 特效（纯视觉） | `AddSpecialEffect`（谨慎，可能影响同步） |
| 选择 | `SelectUnit`（需 `SyncSelections`） |
| 迷雾 | `CreateFogModifier` |
| 小地图 | `PingMinimap` |

### 2.5 危险的本地操作

| 类别 | 示例 |
| --- | --- |
| 创建/销毁单位 | `CreateUnit`, `RemoveUnit`, `KillUnit` |
| 修改单位属性 | `SetUnitState`, `SetUnitX/Y` |
| 随机数 | `GetRandomInt`, `GetRandomReal` |
| 单位组操作 | `GroupEnumUnits...`（结果依赖本地状态时） |
| 触发器注册 | `TriggerRegister...` |
| 使用技能 | `IssueOrder` |
| 修改玩家状态 | `SetPlayerState` |

### 2.6 Lua 特有的 desync 陷阱

#### table 遍历顺序

```lua
-- ❌ pairs 遍历含 handle key 的 table，顺序不确定
for k, v in pairs(unitTable) do
    DoSomething(v)  -- 每个客户端顺序可能不同 → desync
end

-- ✅ 用数组或排序
local keys = {}
for k in pairs(unitTable) do
    table.insert(keys, k)
end
table.sort(keys)
for _, k in ipairs(keys) do
    DoSomething(unitTable[k])
end
```

#### table.sort 不稳定

```lua
-- ❌ 相等元素顺序不确定
table.sort(list, function(a, b) return a.value < b.value end)

-- ✅ 加唯一 tie-breaker
table.sort(list, function(a, b)
    if a.value == b.value then return a.id < b.id end
    return a.value < b.value
end)
```

#### 随机数

```lua
-- math.random 在异步上下文（GetLocalPlayer 块内）会导致 desync
-- 确保在同步上下文中调用
```

#### 匿名函数与 GC

```lua
-- 高频计时器中创建大量匿名函数会增加 GC 压力
-- 可能导致不同客户端 GC 时机不同（极端情况）
```

### 2.7 同步机制

#### SyncSelections

```jass
call SyncSelections()  // 同步所有玩家的选择
```

#### 同步数据（Lua）

```lua
-- 发送同步数据
BlzSendSyncData("prefix", "data")

-- 接收
BlzTriggerRegisterPlayerSyncEvent(trg, player, "prefix", false)
```

#### 游戏缓存同步

```jass
call StoreInteger(cache, "mission", "key", value)
call SyncStoredInteger(cache, "mission", "key")  // 同步到所有玩家
```

### 2.8 调试 Desync

1. **复现**：在多人大厅（LAN 或 Battle.net）测试。
2. **二分定位**：注释掉可疑代码块。
3. **检查 GetLocalPlayer**：搜索所有 `GetLocalPlayer` 使用。
4. **检查随机数**：确保同步调用。
5. **检查 table 遍历**：Lua 项目重点。
6. **日志**：在各客户端打印关键状态对比。

---

## 三、最佳实践清单

### 内存

- [ ] 每个 `CreateXxx` 都有对应 `DestroyXxx`
- [ ] JASS 中所有局部 agent 变量置 null
- [ ] 循环内不重复创建 location/group
- [ ] boolexpr 正确销毁
- [ ] Lua 中清理 table 的死引用

### 同步

- [ ] `GetLocalPlayer` 块内只做视觉/本地操作
- [ ] 随机数在同步上下文调用
- [ ] Lua table 遍历用排序或数组
- [ ] `table.sort` 加唯一 tie-breaker
- [ ] 多人大厅测试

### 性能

- [ ] 优先用 native 而非 BJ 函数
- [ ] 避免 0ms 高频计时器
- [ ] 单位组操作注意复杂度
- [ ] 减少不必要的触发器

---

## 参考

- **内存泄漏教程**：https://www.hiveworkshop.com/threads/memory-leaks.263410/
- **Lua Desync 章节**：https://www.hiveworkshop.com/threads/a-comprehensive-guide-to-mapping-in-lua.341880/
- **JassDoc @async 注解**：https://github.com/lep/jassdoc
- **常见崩溃列表**：https://www.hiveworkshop.com/threads/list-of-warcraft-iii-crashes.194706/
