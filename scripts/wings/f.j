//============================================================================
// WINGS / MOUNT SYSTEM - 函数定义
// 移植自 伏魔战记 (翅膀/坐骑系统)
//
// 翅膀: 物品(技能 TargetArt 挂模型) —— `wing <名称>` 添加, 属性直接生效
// 坐骑: 物品(蛋) —— 使用后创建坐骑单位, 英雄骑在坐骑上(不隐藏英雄);
//       蛋变成"取消骑乘"物品, 点击取消骑乘变回蛋
//
// 命令:
//   wing <名称/ID>   给选中英雄添加翅膀
//   wings            列出全部翅膀
//   mount <名称/ID>  给选中英雄添加坐骑蛋
//   mounts           列出全部坐骑
//   unride           卸下当前坐骑
//   wgtest           诊断
//============================================================================

//---------------------------------------------------------------------------
// 通用工具
//---------------------------------------------------------------------------
function WG_LowerAscii takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "A" then
            set ch = "a"
        elseif ch == "B" then
            set ch = "b"
        elseif ch == "C" then
            set ch = "c"
        elseif ch == "D" then
            set ch = "d"
        elseif ch == "E" then
            set ch = "e"
        elseif ch == "F" then
            set ch = "f"
        elseif ch == "G" then
            set ch = "g"
        elseif ch == "H" then
            set ch = "h"
        elseif ch == "I" then
            set ch = "i"
        elseif ch == "J" then
            set ch = "j"
        elseif ch == "K" then
            set ch = "k"
        elseif ch == "L" then
            set ch = "l"
        elseif ch == "M" then
            set ch = "m"
        elseif ch == "N" then
            set ch = "n"
        elseif ch == "O" then
            set ch = "o"
        elseif ch == "P" then
            set ch = "p"
        elseif ch == "Q" then
            set ch = "q"
        elseif ch == "R" then
            set ch = "r"
        elseif ch == "S" then
            set ch = "s"
        elseif ch == "T" then
            set ch = "t"
        elseif ch == "U" then
            set ch = "u"
        elseif ch == "V" then
            set ch = "v"
        elseif ch == "W" then
            set ch = "w"
        elseif ch == "X" then
            set ch = "x"
        elseif ch == "Y" then
            set ch = "y"
        elseif ch == "Z" then
            set ch = "z"
        else
            set ch = SubString(s, i, i + 1)
        endif
        set result = result + ch
        set i = i + 1
    endloop
    return result
endfunction

function WG_StrEqCI takes string a, string b returns boolean
    return WG_LowerAscii(a) == WG_LowerAscii(b)
endfunction

function WG_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ffff[翅膀]|r " + msg)
endfunction

function WG_MountMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cffff8800[坐骑]|r " + msg)
endfunction


function WG_GetSelectedUnit takes player p returns unit
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, p, null)
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    return u
endfunction

// 找到玩家的英雄 (优先选中单位)
function WG_GetHero takes player p returns unit
    local unit u = WG_GetSelectedUnit(p)
    local unit h
    if u != null and IsUnitType(u, UNIT_TYPE_HERO) then
        return u
    endif
    call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, p, null)
    loop
        set h = FirstOfGroup(bj_lastCreatedGroup)
        exitwhen h == null
        call GroupRemoveUnit(bj_lastCreatedGroup, h)
        if IsUnitType(h, UNIT_TYPE_HERO) then
            return h
        endif
    endloop
    return u
endfunction

function WG_Char takes integer c returns string
    if c >= 65 and c <= 90 then
        return SubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", c - 65, c - 64)
    elseif c >= 97 and c <= 122 then
        return SubString("abcdefghijklmnopqrstuvwxyz", c - 97, c - 96)
    elseif c >= 48 and c <= 57 then
        return SubString("0123456789", c - 48, c - 47)
    endif
    return "?"
endfunction

function WG_IdStr takes integer id returns string
    local string s = ""
    local integer c
    set c = id / 16777216
    set s = s + WG_Char(c)
    set id = id - c * 16777216
    set c = id / 65536
    set s = s + WG_Char(c)
    set id = id - c * 65536
    set c = id / 256
    set s = s + WG_Char(c)
    set s = s + WG_Char(id - c * 256)
    return s
endfunction

function WG_BoolStr takes boolean b returns string
    if b then
        return "true"
    endif
    return "false"
endfunction

//---------------------------------------------------------------------------
// 翅膀: 添加 (物品技能自动生效)
//---------------------------------------------------------------------------
function WG_AddWing takes player p, integer itemId returns boolean
    local unit u = WG_GetHero(p)
    local item it
    if u == null then
        call WG_Message(p, "请先选中一个单位")
        return false
    endif
    set it = UnitAddItemById(u, itemId)
    if it == null then
        call WG_Message(p, "背包已满，无法添加翅膀")
        return false
    endif
    call WG_Message(p, "已添加翅膀: " + GetItemName(it))
    set it = null
    return true
endfunction

function WG_ListWings takes player p returns nothing
    // >>> GENERATED:BEGIN wing_list (wings_config.py) >>>
    call WG_Message(p, "翅膀: I100 堕落天使之翼 / I101 炽天使之翼 / I102 恶魔之翼 / I104 星魂之力")
    // >>> GENERATED:END wing_list <<<
    call WG_Message(p, "用法: wing <名称或ID>")
endfunction

//---------------------------------------------------------------------------
// 坐骑: 添加蛋 / 骑乘 / 取消
//---------------------------------------------------------------------------
function WG_AddMountEgg takes player p, integer itemId returns boolean
    local unit u = WG_GetHero(p)
    local item it
    if u == null then
        call WG_MountMessage(p, "请先选中一个单位")
        return false
    endif
    set it = UnitAddItemById(u, itemId)
    if it == null then
        call WG_MountMessage(p, "背包已满，无法添加坐骑蛋")
        return false
    endif
    call WG_MountMessage(p, "已添加: " + GetItemName(it) + "（使用后骑乘）")
    set it = null
    return true
endfunction

// 查找蛋 -> 索引 (找不到返回 -1)
function WG_EggIndex takes integer eggId returns integer
    local integer i = 0
    loop
        exitwhen i >= wg_eggCount
        if wg_eggItem[i] == eggId then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

// 查找"取消骑乘"物品 -> 索引 (找不到返回 -1)
function WG_OffIndex takes integer offId returns integer
    local integer i = 0
    loop
        exitwhen i >= wg_eggCount
        if wg_eggOffItem[i] == offId then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

// 查找坐骑单位类型 -> 索引 (找不到返回 0)
function WG_UnitIndexOf takes integer unitId returns integer
    local integer i = 0
    loop
        exitwhen i >= wg_eggCount
        if wg_eggUnit[i] == unitId then
            return i
        endif
        set i = i + 1
    endloop
    return 0
endfunction

//---------------------------------------------------------------------------
// 物品/单位小工具
//---------------------------------------------------------------------------
// 取该玩家的第一个英雄 (不看当前选中单位, 供被动效果用)
function WG_PlayerHero takes player p returns unit
    local unit h
    call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, p, null)
    loop
        set h = FirstOfGroup(bj_lastCreatedGroup)
        exitwhen h == null
        call GroupRemoveUnit(bj_lastCreatedGroup, h)
        if IsUnitType(h, UNIT_TYPE_HERO) then
            return h
        endif
    endloop
    return null
endfunction

// 清掉英雄背包里所有"骑乘中"物品 (换坐骑/卸下时用, 防止出现两件重复的物品)
function WG_ClearRidingItems takes unit u returns nothing
    local integer i = 0
    local item it
    if u == null then
        return
    endif
    loop
        exitwhen i >= 6
        set it = UnitItemInSlot(u, i)
        if it != null then
            if WG_OffIndex(GetItemTypeId(it)) >= 0 then
                call RemoveItem(it)
            endif
        endif
        set i = i + 1
    endloop
    set it = null
endfunction


//---------------------------------------------------------------------------
// 骑手槽位: 坐骑状态**按英雄**存 (不是按玩家)
//   ⚠ 以前是"每玩家一份"，一个玩家同时控制多个英雄时第二个英雄会被判
//     "你已经在骑乘中"。现在每个骑乘中的英雄各占一个槽位。
//---------------------------------------------------------------------------
function WG_SlotOfExisting takes unit hero returns integer
    local integer key
    if hero == null or wg_slotTable == null then
        return -1
    endif
    set key = GetHandleId(hero)
    if HaveSavedInteger(wg_slotTable, key, 0) then
        return LoadInteger(wg_slotTable, key, 0) - 1
    endif
    return -1
endfunction

function WG_SlotOf takes unit hero returns integer
    local integer key
    local integer slot
    local integer i
    if hero == null then
        return -1
    endif
    if wg_slotTable == null then
        set wg_slotTable = InitHashtable()
    endif
    set slot = WG_SlotOfExisting(hero)
    if slot >= 0 then
        return slot
    endif
    set slot = -1
    set i = 0
    loop
        exitwhen i >= WG_MAX_RIDERS
        if not HaveSavedInteger(wg_slotTable, i, 1) then
            set slot = i
            exitwhen true
        endif
        set i = i + 1
    endloop
    if slot < 0 then
        return -1
    endif
    call SaveInteger(wg_slotTable, slot, 1, 1)
    call SaveInteger(wg_slotTable, GetHandleId(hero), 0, slot + 1)
    set wg_riderHero[slot] = hero
    set wg_riderEgg[slot] = -1
    set wg_riderRiding[slot] = false
    set wg_riderMount[slot] = null
    set wg_riderSum1[slot] = null
    set wg_riderSum2[slot] = null
    set wg_riderCd[slot] = 0.0
    set wg_riderDied[slot] = false
    set wg_riderHeal[slot] = 0
    return slot
endfunction

// 槽位换主人 (作者的脚本把英雄换掉/重建时用): 摘掉旧句柄的映射，
//   否则旧句柄被引擎回收复用后，坐骑会误配到别的单位身上。
function WG_AdoptHero takes integer slot, unit u returns nothing
    local unit old = wg_riderHero[slot]
    if u == null then
        return
    endif
    if wg_slotTable == null then
        set wg_slotTable = InitHashtable()
    endif
    if old != null and old != u then
        call RemoveSavedInteger(wg_slotTable, GetHandleId(old), 0)
    endif
    set wg_riderHero[slot] = u
    call SaveInteger(wg_slotTable, GetHandleId(u), 0, slot + 1)
endfunction

// 英雄被换掉时，在本玩家的单位里找"身上带着这个蛋、活着、且不是别的槽位主人"的英雄，
//   把坐骑交给它；找不到返回 null (调用方卸下坐骑)。
function WG_FindHeroWithEgg takes player p, integer eggIdx, integer selfSlot returns unit
    local unit u
    local integer s
    call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, p, null)
    loop
        set u = FirstOfGroup(bj_lastCreatedGroup)
        exitwhen u == null
        call GroupRemoveUnit(bj_lastCreatedGroup, u)
        if IsUnitType(u, UNIT_TYPE_HERO) and not IsUnitType(u, UNIT_TYPE_DEAD) then
            if UnitHasItemOfTypeBJ(u, wg_eggItem[eggIdx]) then
                set s = WG_SlotOfExisting(u)
                if s < 0 or s == selfSlot then
                    return u
                endif
            endif
        endif
    endloop
    return null
endfunction

// 创建并配置一只坐骑 (骑乘 + 自愈都走这里)
//
// 与伏魔战记 Trig_PetB1_Actions 对齐的顺序:
//   CreateUnit -> Aloc -> SetUnitPathing(false) -> SetUnitScalePercent
//   -> Amrf 加/删(获得飞行) -> SetUnitFlyHeight -> SetUnitTurnSpeed/BlendTime
//
// ⚠ 曾经在这里/同步循环里调 `UnitRemoveAbility(mount,'Aphx')` 想压制凤凰"变蛋"。
//   这是**错误的**：Aphx 是凤凰的召唤/变蛋本体技能，把它摘掉等于触发了引擎的
//   "凤凰结束"逻辑 —— 引擎会把这只凤凰**替换成凤凰蛋**(hpxe)并销毁原单位，
//   于是我们存的坐骑句柄失效 (GetUnitTypeId==0)，表现为"火凤凰过一会儿就消失"。
//   伏魔战记从不摘 Aphx，坐骑靠 Aloc 就足够安全存活。
function WG_SpawnMount takes unit hero, integer slot, integer idx returns unit
    local player p
    local unit mount
    local real x
    local real y
    if slot < 0 or idx < 0 or idx >= wg_eggCount then
        return null
    endif
    if hero == null or GetUnitTypeId(hero) == 0 then
        return null
    endif
    set p = GetOwningPlayer(hero)
    set x = GetUnitX(hero)
    set y = GetUnitY(hero)
    set mount = CreateUnit(p, wg_eggUnit[idx], x, y, GetUnitFacing(hero))
    if mount == null then
        return null
    endif
    call UnitAddAbility(mount, 'Aloc')
    call SetUnitPathing(mount, false)
    call SetUnitScalePercent(mount, wg_eggScale[idx] * 100.0, 100.0, 100.0)
    call UnitAddAbility(mount, 'Amrf')
    call UnitRemoveAbility(mount, 'Amrf')
    call SetUnitFlyHeight(mount, wg_eggHeight[idx], 0.0)
    call SetUnitTurnSpeed(mount, 0.1)
    call SetUnitBlendTime(mount, 0.1)
    // 额外保险 (伏魔战记没有, 但本图有大量 AoE, 免得坐骑被误杀)
    call SetUnitInvulnerable(mount, true)
    // 不自动索敌: 攻击由英雄攻击带动 (WG_OnMountAttack)
    call SetUnitAcquireRange(mount, 0.0)
    // 死亡事件: 用于区分"被击杀"和"被引擎替换"(诊断)
    call TriggerRegisterUnitEvent(wg_deathTrig, mount, EVENT_UNIT_DEATH)
    set wg_riderMount[slot] = mount
    set wg_riderEgg[slot] = idx
    set wg_riderHero[slot] = hero
    return mount
endfunction

// 单位死亡事件:
//   * 坐骑死 -> 置诊断标记 (自愈时据此区分"被击杀"还是"被替换")
//   * 召唤物死 -> 立刻把变量置空。JASS 的 unit 句柄会被回收复用,
//     残留的旧句柄可能"变成"另一个单位(甚至坐骑), 届时 RemoveUnit 会误删坐骑。
function WG_OnUnitDeath takes nothing returns nothing
    local unit u = GetDyingUnit()
    local integer i = 0
    loop
        exitwhen i >= WG_MAX_RIDERS
        if wg_riderRiding[i] and u == wg_riderMount[i] then
            set wg_riderDied[i] = true
        endif
        if u == wg_riderSum1[i] then
            set wg_riderSum1[i] = null
        endif
        if u == wg_riderSum2[i] then
            set wg_riderSum2[i] = null
        endif
        set i = i + 1
    endloop
    set u = null
endfunction

// 骑乘: 创建坐骑单位, 英雄骑在坐骑上 (英雄不隐藏)
//   ⚠ 参数从 `player` 改成 `unit hero` —— 用蛋的是哪个英雄, 就给哪个英雄上坐骑,
//     这样才能"两个英雄各自骑一只"。以前按玩家存状态, 第二个英雄会被顶掉。
function WG_RideMount takes unit hero, integer eggIdx, string mname returns nothing
    local player p
    local integer slot
    local unit mount
    if hero == null or GetUnitTypeId(hero) == 0 then
        return
    endif
    set p = GetOwningPlayer(hero)
    set slot = WG_SlotOf(hero)
    if slot < 0 then
        call WG_MountMessage(p, "同时骑乘的英雄已达上限(" + I2S(WG_MAX_RIDERS) + ")")
        return
    endif
    if wg_riderRiding[slot] then
        call WG_MountMessage(p, GetUnitName(hero) + " 已经在骑乘中")
        return
    endif
    // 先清掉背包里可能残留的"骑乘中"物品, 避免出现两件重复的
    call WG_ClearRidingItems(hero)
    set wg_riderHero[slot] = hero
    set mount = WG_SpawnMount(hero, slot, eggIdx)
    if mount == null then
        set wg_riderEgg[slot] = -1
        call WG_MountMessage(p, "创建坐骑失败")
        return
    endif
    // 英雄抬高, 骑在坐骑上 (英雄保持可见); Amrf 加/删 = 获得飞行 (同伏魔战记)
    call UnitAddAbility(hero, 'Amrf')
    call UnitRemoveAbility(hero, 'Amrf')
    call SetUnitFlyHeight(hero, wg_eggHeroHeight[eggIdx], 0.0)
    // 注: 曾经在这里关掉英雄寻路(SetUnitPathing(hero,false))想让坐骑能穿过树木/山崖,
    //   玩家实测效果不好(会走过水面/崖壁, 观感很怪) —— 2026-10-10 第七轮已去掉。
    //   现在英雄仍然按地面寻路, 飞行只体现在高度上。
    // 诊断: 如果坐骑身上还有 Aphx(凤凰变蛋), 说明 war3map.w3u 的技能列表覆盖没生效,
    //   凤凰会被引擎"到时间/死亡变蛋"替换掉 -> 请把坐骑基础单位换掉(见文档)。
    if GetUnitAbilityLevel(mount, 'Aphx') > 0 then
        call WG_MountMessage(p, "诊断: 坐骑仍带 Aphx(凤凰变蛋技能)，w3u 技能列表未生效")
    endif
    set wg_riderRiding[slot] = true
    set wg_riderCd[slot] = 0.0
    set wg_riderDied[slot] = false
    set wg_riderHeal[slot] = 0
    call WG_MountMessage(p, GetUnitName(hero) + " 已骑乘: " + mname)
    set mount = null
endfunction

// 卸下某个槽位的坐骑 (按槽位操作, 所以"是哪个英雄"是明确的)
//   showMsg = 是否给该英雄的玩家提示
function WG_UnrideSlot takes integer slot, boolean showMsg returns nothing
    local unit hero
    local player p = null
    local unit mount
    if slot < 0 then
        return
    endif
    set hero = wg_riderHero[slot]
    set mount = wg_riderMount[slot]
    if hero != null then
        set p = GetOwningPlayer(hero)
    endif
    if p == null then
        set p = Player(0)
    endif
    if not wg_riderRiding[slot] and mount == null then
        return
    endif
    if hero != null and GetUnitTypeId(hero) != 0 then
        call SetUnitFlyHeight(hero, 0.0, 0.0)
        // 卸下时清掉所有"骑乘中"物品 (点它卸下/丢掉它自动卸下 都走这里)
        call WG_ClearRidingItems(hero)
    endif
    if mount != null then
        call RemoveUnit(mount)
    endif
    set wg_riderMount[slot] = null
    // 移除召唤物 (只删确实是召唤物的: userdata 2000)
    if wg_riderSum1[slot] != null then
        if GetUnitUserData(wg_riderSum1[slot]) == 2000 then
            call RemoveUnit(wg_riderSum1[slot])
        endif
        set wg_riderSum1[slot] = null
    endif
    if wg_riderSum2[slot] != null then
        if GetUnitUserData(wg_riderSum2[slot]) == 2000 then
            call RemoveUnit(wg_riderSum2[slot])
        endif
        set wg_riderSum2[slot] = null
    endif
    set wg_riderEgg[slot] = -1
    set wg_riderRiding[slot] = false
    set wg_riderDied[slot] = false
    set wg_riderCd[slot] = 0.0
    if showMsg then
        call WG_MountMessage(p, "已取消骑乘")
    endif
endfunction

// 按英雄卸下坐骑 (使用/丢弃坐骑蛋、聊天命令都走这里)
function WG_UnrideMount takes unit hero returns nothing
    local integer slot
    if hero == null or GetUnitTypeId(hero) == 0 then
        return
    endif
    set slot = WG_SlotOfExisting(hero)
    if slot < 0 or not wg_riderRiding[slot] then
        call WG_MountMessage(GetOwningPlayer(hero), "这个英雄当前没有骑乘坐骑")
        return
    endif
    call WG_UnrideSlot(slot, true)
endfunction

// 聊天命令 unride: 卸下"当前选中英雄"的坐骑
function WG_UnrideForPlayer takes player p returns nothing
    local unit hero = WG_GetHero(p)
    if hero == null then
        call WG_MountMessage(p, "请先选中要下坐骑的英雄")
        return
    endif
    call WG_UnrideMount(hero)
    set hero = null
endfunction

// 召唤物跟随英雄 (模仿伏魔战记: 空闲且距离远时, 命令其移动到英雄处)
//   offsetDeg: 相对英雄的偏移角度 (让两只召唤物分开, 不重叠)
function WG_FollowSummon takes unit d, unit hero, real offsetDeg returns nothing
    local real dx
    local real dy
    local real dist
    local real tx
    local real ty
    if d == null or GetUnitTypeId(d) == 0 then
        return
    endif
    if IsUnitType(d, UNIT_TYPE_DEAD) then
        return
    endif
    // 仅在空闲时下移动命令 (正在攻击时不打断)
    if GetUnitCurrentOrder(d) != 0 then
        return
    endif
    set dx = GetUnitX(hero) - GetUnitX(d)
    set dy = GetUnitY(hero) - GetUnitY(d)
    set dist = SquareRoot(dx * dx + dy * dy)
    if dist > 250.0 then
        // 目标点 = 英雄位置 + 偏移 (避免两只召唤物叠在同一点)
        set tx = GetUnitX(hero) + 120.0 * Cos(offsetDeg * bj_DEGTORAD)
        set ty = GetUnitY(hero) + 120.0 * Sin(offsetDeg * bj_DEGTORAD)
        call IssuePointOrder(d, "move", tx, ty)
    endif
endfunction

// 坐骑同步: 坐骑跟随英雄 (高频, 消除跳帧卡顿)
//   伏魔战记用 0.04s 周期做 SetUnitX/Y 跟随; 本工程用 0.03s 更顺滑。
//   注意: 不要每帧 SetUnitLifeBJ (会造成血条闪烁/开销) —— 无敌由 SetUnitInvulnerable 保证。
function WG_MountSync takes nothing returns nothing
    local integer slot = 0
    local player p
    local unit mount
    local unit hero
    local integer idx
    loop
        exitwhen slot >= WG_MAX_RIDERS
        if wg_riderRiding[slot] then
            set mount = wg_riderMount[slot]
            set hero = wg_riderHero[slot]
            if hero != null then
                set p = GetOwningPlayer(hero)
            else
                set p = Player(0)
            endif
            // 三种情况都要自愈: 句柄失效 / 单位已死(尸体还没消失) / 被引擎替换
            if mount == null or GetUnitTypeId(mount) == 0 or IsUnitType(mount, UNIT_TYPE_DEAD) then
                // 原地重建, 不掉骑乘 (静默处理: 不再弹提示)
                set wg_riderDied[slot] = false
                set mount = WG_SpawnMount(hero, slot, wg_riderEgg[slot])
                if mount == null then
                    call WG_UnrideSlot(slot, false)
                    call WG_MountMessage(p, "坐骑无法恢复，已卸下")
                endif
            else
                // 英雄句柄失效(被作者脚本换掉/删除) -> 在本玩家单位里找"带着同一个蛋"的英雄
                //   接手；找不到才卸下。**不能**用 WG_GetHero: 它返回"当前选中单位"，
                //   多英雄时会把坐骑接到别的英雄身上。
                if hero == null or GetUnitTypeId(hero) == 0 then
                    set hero = WG_FindHeroWithEgg(p, wg_riderEgg[slot], slot)
                    if hero != null then
                        call WG_AdoptHero(slot, hero)
                    endif
                endif
                // 英雄死亡/不存在 -> 自动取消骑乘
                if hero == null or GetUnitTypeId(hero) == 0 then
                    call WG_UnrideSlot(slot, false)
                    call WG_MountMessage(p, "骑乘的英雄已消失，坐骑已卸下")
                elseif IsUnitType(hero, UNIT_TYPE_DEAD) then
                    // 阵亡一律卸下坐骑(保留坐骑会出 bug); 复活后玩家自己点坐骑蛋再上马
                    call WG_MountMessage(p, GetUnitName(hero) + " 阵亡，已自动卸下坐骑")
                    call WG_UnrideSlot(slot, false)
                else
                    // 坐骑跟随英雄位置 (瞬移式贴合, 高频周期消除视觉跳帧)
                    call SetUnitX(mount, GetUnitX(hero))
                    call SetUnitY(mount, GetUnitY(hero))
                    // 朝向: 无条件跟英雄一致。伏魔战记 Trig_PetC1 就是无条件
                    //   SetUnitFacing —— 之前"只在空闲时同步"会让龙头锁死在攻击目标上,
                    //   与英雄移动方向不一致(玩家反馈的"龙头锁定")。
                    call SetUnitFacing(mount, GetUnitFacing(hero))
                    // 持续抬高 (地面单位 SetUnitFlyHeight 会被 SetUnitX/Y 重置)
                    set idx = wg_riderEgg[slot]
                    if idx >= 0 and idx < wg_eggCount then
                        call SetUnitFlyHeight(mount, wg_eggHeight[idx], 0.0)
                        // CRITICAL: 英雄高度也必须每帧重设! 否则英雄会被重置为地面单位,
                        //   坐骑/小龙的 ground 溅射会打到英雄 (蓝龙减速+伤害, 英雄易死)。
                        call SetUnitFlyHeight(hero, wg_eggHeroHeight[idx], 0.0)
                    endif
                    // 持续维持无敌 (防止被异常杀死; 不重设生命值, 避免血条闪烁)
                    call SetUnitInvulnerable(mount, true)
                    // 召唤物空闲时跟随英雄 (自然跟随, 不瞬移; 两只分开避免重叠)
                    call WG_FollowSummon(wg_riderSum1[slot], hero, 0.0)
                    call WG_FollowSummon(wg_riderSum2[slot], hero, 180.0)
                endif
            endif
        endif
        set slot = slot + 1
    endloop
endfunction

function WG_ListMounts takes player p returns nothing
    local integer i = 0
    call WG_MountMessage(p, "坐骑蛋列表:")
    loop
        exitwhen i >= wg_eggCount
        call WG_MountMessage(p, "  " + WG_IdStr(wg_eggItem[i]) + "  " + wg_eggName[i])
        set i = i + 1
    endloop
    call WG_MountMessage(p, "用法: mount <名称或ID> 添加蛋, 使用蛋骑乘, 点击\"取消骑乘\"变回蛋")
endfunction

//---------------------------------------------------------------------------
// 按名称/ID 查找并添加
//---------------------------------------------------------------------------
function WG_GiveWingByName takes player p, string key returns nothing
    // >>> GENERATED:BEGIN wing_names (wings_config.py) >>>
    if WG_StrEqCI(key, "堕落天使之翼") or WG_StrEqCI(key, "i100") then
        call WG_AddWing(p, 'I100')
    elseif WG_StrEqCI(key, "炽天使之翼") or WG_StrEqCI(key, "i101") then
        call WG_AddWing(p, 'I101')
    elseif WG_StrEqCI(key, "恶魔之翼") or WG_StrEqCI(key, "i102") then
        call WG_AddWing(p, 'I102')
    elseif WG_StrEqCI(key, "星魂之力") or WG_StrEqCI(key, "i104") then
        call WG_AddWing(p, 'I104')
    // >>> GENERATED:END wing_names <<<
    else
        call WG_Message(p, "未找到翅膀: " + key + "（输入 wings 查看列表）")
    endif
endfunction

function WG_GiveMountByName takes player p, string key returns nothing
    local integer i = 0
    loop
        exitwhen i >= wg_eggCount
        if WG_StrEqCI(wg_eggName[i], key) or WG_StrEqCI(WG_IdStr(wg_eggItem[i]), key) then
            call WG_AddMountEgg(p, wg_eggItem[i])
            return
        endif
        set i = i + 1
    endloop
    call WG_MountMessage(p, "未找到坐骑: " + key + "（输入 mounts 查看列表）")
endfunction

//---------------------------------------------------------------------------
// 使用物品 (EVENT_PLAYER_UNIT_USE_ITEM)
//   使用坐骑蛋 -> 骑乘 + 蛋变成"取消骑乘"物品
//   使用"取消骑乘"物品 -> 取消骑乘 + 变回坐骑蛋
//---------------------------------------------------------------------------
function WG_OnUseItem takes nothing returns nothing
    local item it = GetManipulatedItem()
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local integer slot = WG_SlotOfExisting(u)
    local integer itemId = GetItemTypeId(it)
    local integer idx = WG_EggIndex(itemId)

    if idx >= 0 then
        // === 使用坐骑蛋 -> 骑乘 ===
        // 蛋**不再被消耗/替换** —— 它本身就是"取消骑乘"的按钮 (骑乘中再点一次即取消)。
        // 以前那套"蛋 -> 骑乘中物品"会连带出一堆问题: 多余物品、被脚本移除的物品又被
        // 引擎丢到地上一份、换坐骑时旧的"骑乘中"物品没清导致重复。现在这些都不存在了。
        // ⚠ 状态按英雄算: 用蛋的这个单位就是骑手, 别的英雄骑着不影响。
        if slot >= 0 and wg_riderRiding[slot] then
            if wg_riderEgg[slot] == idx then
                // 同一个蛋 -> 取消骑乘
                call WG_UnrideSlot(slot, true)
            else
                // 别的蛋 -> 换坐骑
                call WG_UnrideSlot(slot, true)
                call WG_RideMount(u, idx, wg_eggName[idx])
            endif
        else
            call WG_RideMount(u, idx, wg_eggName[idx])
        endif
    endif

    set it = null
    set u = null
endfunction

//---------------------------------------------------------------------------
// 丢掉坐骑蛋 == 主动下坐骑: 自动取消骑乘 (蛋就留在地上)
//---------------------------------------------------------------------------
function WG_OnDropItem takes nothing returns nothing
    local item it = GetManipulatedItem()
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local integer slot = WG_SlotOfExisting(u)
    local integer idx = WG_EggIndex(GetItemTypeId(it))

    if idx >= 0 and slot >= 0 and wg_riderRiding[slot] and wg_riderEgg[slot] == idx then
        call WG_UnrideSlot(slot, true)
        call WG_MountMessage(p, "坐骑蛋被丢下，已自动取消骑乘")
    endif

    set it = null
    set u = null
endfunction

//---------------------------------------------------------------------------
// 聊天命令
//---------------------------------------------------------------------------
// 诊断命令 wginfo: 逐个列出该玩家每个英雄的"翅膀物品 / 隐藏魔法书"状态。
//   技能栏里看不到光环是**正常的**(书被 SetPlayerAbilityAvailable 隐藏了),
//   所以这里直接看"书挂上没有": 书OK = 光环/被动已经在身上了。
// 在世界里标一个点（**诊断用**）：飘一行字 + 点上一个特效。
//   用法：`wginfo` 会把"死亡之指最近一次施法记录的两个点"标出来，
//   一眼就能看出"闪电画在哪"和"脚本以为的坐标"哪个错了。
function WG_FingerMarker takes real x, real y, string txt, integer r, integer g, integer b returns nothing
    local texttag tt = CreateTextTag()
    local effect e = AddSpecialEffect("Abilities\\Spells\\Other\\Aneu\\AneuTarget.mdl", x, y)
    call DestroyEffect(e)
    call SetTextTagText(tt, txt, 0.024)
    call SetTextTagPos(tt, x, y, 120.0)
    call SetTextTagColor(tt, r, g, b, 255)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 6.0)
    call SetTextTagFadepoint(tt, 5.0)
    set e = null
    set tt = null
endfunction

function WG_ReportWings takes player p returns nothing
    local integer pid = GetPlayerId(p)
    local integer i
    local integer found = 0
    local string s
    local unit u
    call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, p, null)
    loop
        set u = FirstOfGroup(bj_lastCreatedGroup)
        exitwhen u == null
        call GroupRemoveUnit(bj_lastCreatedGroup, u)
        if IsUnitType(u, UNIT_TYPE_HERO) then
            set found = found + 1
            set s = GetUnitName(u) + ":"
            set i = 0
            loop
                exitwhen i >= wg_wingCount
                if UnitHasItemOfTypeBJ(u, wg_wingItem[i]) then
                    set s = s + " " + WG_IdStr(wg_wingItem[i])
                    // 有的翅膀没有书（wg_wingBook[i] = 0，例如星魂之力）→ 不打印这一项
                    if wg_wingBook[i] != 0 then
                        if GetUnitAbilityLevel(u, wg_wingBook[i]) > 0 then
                            set s = s + "(书OK)"
                        else
                            set s = s + "(书缺失)"
                        endif
                    endif
                    if wg_wingBook2[i] != 0 then
                        if GetUnitAbilityLevel(u, wg_wingBook2[i]) > 0 then
                            set s = s + "(书2OK)"
                        else
                            set s = s + "(书2缺)"
                        endif
                    endif
                endif
                set i = i + 1
            endloop
            call WG_MountMessage(p, s)
            // 逐个技能实测: 魔法书只把技能"装"进去, 到底哪些真的挂到单位身上,
            //   用 GetUnitAbilityLevel 一看就知道(每本魔法书实测只挂前 3 个)。
            // >>> GENERATED:BEGIN wing_debug (wings_config.py) >>>
            set s = "技能 堕落[邪恶" + I2S(GetUnitAbilityLevel(u, 'W070'))
            set s = s + " 吸血" + I2S(GetUnitAbilityLevel(u, 'W071'))
            set s = s + " 闪避" + I2S(GetUnitAbilityLevel(u, 'W072')) + "]"
            set s = s + " 炽天使[辉煌" + I2S(GetUnitAbilityLevel(u, 'W073'))
            set s = s + " 治疗" + I2S(GetUnitAbilityLevel(u, 'W074'))
            set s = s + " 展示" + I2S(GetUnitAbilityLevel(u, 'W079'))
            set s = s + " 重生" + I2S(GetUnitAbilityLevel(u, 'W075')) + "]"
            set s = s + " 恶魔[命令" + I2S(GetUnitAbilityLevel(u, 'W076'))
            set s = s + " 耐久" + I2S(GetUnitAbilityLevel(u, 'W077'))
            set s = s + " 暴击" + I2S(GetUnitAbilityLevel(u, 'W078')) + "]"
            // >>> GENERATED:END wing_debug <<<
            call WG_MountMessage(p, s)
            // 光环 buff 实测: 光环如果真的挂在单位身上, 对应 buff 会出现在单位上,
            //   用 GetUnitAbilityLevel(单位, buffID) 就能查出来(缓冲也是"技能"的一种)。
            // 治疗=治疗光环的 buff(原版 Boar, 被 war3map.w3h 覆盖了名称/图标);
            // 阿克蒙德=强击光环 buff(BEar) —— 那条**已经确认能显示图标**, 拿它当对照:
            //   如果 阿克蒙德=1 而 治疗=0, 说明治疗光环这个光环类型根本不挂 buff。
            // 治疗那栏查的是**展示光环**挂的 buff（治疗光环的图标就是它贡献的；
            //   W074 的再生光环引擎不挂 buff，所以查 Boar 永远是 0，别被那个 0 误导）。
            // >>> GENERATED:BEGIN buff_debug (wings_config.py) >>>
            set s = "buff 治疗图标=" + I2S(GetUnitAbilityLevel(u, 'B644'))
            set s = s + " 阿克蒙德=" + I2S(GetUnitAbilityLevel(u, 'B641'))
            set s = s + " 邪恶=" + I2S(GetUnitAbilityLevel(u, 'BUau'))
            set s = s + " 吸血=" + I2S(GetUnitAbilityLevel(u, 'BUav'))
            set s = s + " 辉煌=" + I2S(GetUnitAbilityLevel(u, 'BHab'))
            set s = s + " 命令=" + I2S(GetUnitAbilityLevel(u, 'BOac'))
            set s = s + " 耐久=" + I2S(GetUnitAbilityLevel(u, 'BOae'))
            // >>> GENERATED:END buff_debug <<<
            call WG_MountMessage(p, s)
            // 死亡之指自检：最近一次施法的落点信息（排查"闪电位置不对"用）
            //   距离 = 施法者与目标的实际距离；两个坐标都是脚本读到的真实值。
            set s = "|cffcc00ff[死亡之指]|r 技能等级 " + I2S(GetUnitAbilityLevel(u, WG_FINGER_ABILITY))
            set s = s + "  上次目标=" + wg_fingerLastTarget
            set s = s + "  距离=" + I2S(R2I(wg_fingerLastDist))
            set s = s + "  施法者=(" + I2S(R2I(wg_fingerLastX1)) + "," + I2S(R2I(wg_fingerLastY1)) + ")"
            set s = s + "  目标点=(" + I2S(R2I(wg_fingerLastX2)) + "," + I2S(R2I(wg_fingerLastY2)) + ")"
            call WG_MountMessage(p, s)
            set s = s + "  技能目标点=(" + I2S(R2I(wg_fingerLastTX)) + "," + I2S(R2I(wg_fingerLastTY)) + ")"
            set s = s + "  镜头=(" + I2S(R2I(GetCameraTargetPositionX())) + "," + I2S(R2I(GetCameraTargetPositionY())) + ")"
            call WG_MountMessage(p, s)
            // 把脚本记下的那两个点**在世界里标出来**（红=施法者记录点，黄=目标记录点，各 6 秒）。
            //   跑一下就能一眼看出："闪电画在哪"和"脚本以为在哪"到底哪个错了。
            call WG_FingerMarker(wg_fingerLastX1, wg_fingerLastY1, "记录:施法者", 255, 60, 60)
            call WG_FingerMarker(wg_fingerLastX2, wg_fingerLastY2, "记录:目标", 255, 220, 60)
            // 掠夺（阿克蒙德之手）自检：手上有没有这件装备 / 本图开没开
            if UnitHasItemOfTypeBJ(u, WG_HAND_ITEM) then
                set s = "|cffff8800[掠夺]|r 持有阿克蒙德之手 ✓"
                if WG_PLUNDER_ENABLE > 0 then
                    set s = s + "  击杀敌人时按等级掠夺金币（生命 >= "
                    set s = s + I2S(R2I(WG_PLUNDER_MIN_HP)) + "，非英雄 "
                    set s = s + I2S(WG_PLUNDER_BASE) + "+等级*" + I2S(WG_PLUNDER_PER_LV)
                    set s = s + "，英雄 " + I2S(WG_PLUNDER_HERO_BASE) + "+等级*"
                    set s = s + I2S(WG_PLUNDER_HERO_PER_LV) + "，都 /" + I2S(WG_PLUNDER_DIV) + "）"
                else
                    set s = s + "，但本图配置里关着（plunder_enable=0）"
                endif
                call DisplayTimedTextToPlayer(p, 0, 0, 15.0, s)
            endif
        endif
    endloop
    if found == 0 then
        call WG_MountMessage(p, "没有找到英雄")
    endif
    set u = null
endfunction

// 找到单位身上带着的翅膀索引（没有就 -1）
function WG_HpWing takes unit u returns integer
    local integer i = 0
    if u == null then
        return -1
    endif
    loop
        exitwhen i >= wg_wingCount
        if UnitHasItemOfTypeBJ(u, wg_wingItem[i]) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

// 诊断命令 wghp: 回血量实测。第一次输入记基准，隔 10 秒左右再输入一次看净变化。
//   以前只测"WG_GetHero"，测量对象含糊（选中别的单位时会测到没翅膀的单位，
//   让人以为光环失效）。现在明确测"带着翅膀的那个单位"，并在消息里写清楚：
//   哪个翅膀、哪个单位、魔法书在不在身上。
//   把一个 3 万血英雄 10 秒回 9000 换算成 3%/秒，一眼就知道光环有没有生效。
function WG_HpProbe takes player p returns nothing
    local unit u = WG_GetSelectedUnit(p)
    local unit h
    local unit sel
    local integer pid = GetPlayerId(p)
    local integer wi = -1
    local real now
    local real dt
    local string s
    // 优先"选中的单位"，但它必须带着翅膀；否则找玩家手上任意带翅膀的单位；
    // 都没有才退回 WG_GetHero（没有翅膀时至少还能看血量）
    set wi = WG_HpWing(u)
    if wi < 0 then
        set u = null
        call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, p, null)
        loop
            set h = FirstOfGroup(bj_lastCreatedGroup)
            exitwhen h == null
            call GroupRemoveUnit(bj_lastCreatedGroup, h)
            if WG_HpWing(h) >= 0 then
                set u = h
                set wi = WG_HpWing(h)
                call GroupClear(bj_lastCreatedGroup)
            endif
        endloop
    endif
    if u == null then
        set u = WG_GetHero(p)
    endif
    if u == null then
        call WG_MountMessage(p, "请先选中一个单位")
        return
    endif
    set now = GetUnitState(u, UNIT_STATE_LIFE)
    if wi >= 0 then
        set s = wg_wingName[wi] + " 载体「" + GetUnitName(u) + "」"
        if wg_wingBook[wi] != 0 then
            if GetUnitAbilityLevel(u, wg_wingBook[wi]) > 0 then
                set s = s + "[书OK]"
            else
                set s = s + "[书缺]"
            endif
        endif
    else
        set s = "「" + GetUnitName(u) + "」(没带翅膀)"
    endif
    set s = s + " 血量 " + I2S(R2I(now)) + " / 上限 " + I2S(R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE)))
    if wg_hpBase[pid] <= 0.0 then
        set wg_hpBase[pid] = now
        set wg_hpTime[pid] = TimerGetElapsed(wg_gameTimer)
        call WG_MountMessage(p, s + "（已记基准，隔 10 秒左右再输入一次 wghp 看回血量）")
    else
        set dt = TimerGetElapsed(wg_gameTimer) - wg_hpTime[pid]
        if dt <= 0.0 then
            set dt = 1.0
        endif
        set s = s + "，间隔 " + I2S(R2I(dt)) + " 秒"
        set s = s + "，净变化 " + I2S(R2I(now - wg_hpBase[pid]))
        set s = s + "（约 " + I2S(R2I((now - wg_hpBase[pid]) / dt)) + "/秒）"
        // 设计值是"每秒最大生命 3%"，这里顺手把它算出来给玩家对照
        set s = s + "，3%/秒应为 " + I2S(R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.03 * dt))
        call WG_MountMessage(p, s)
        set wg_hpBase[pid] = now
        set wg_hpTime[pid] = TimerGetElapsed(wg_gameTimer)
    endif
    // 如果当前选中的是另一个单位，把它也报一下（光环是有范围的，可以对照）
    set sel = WG_GetSelectedUnit(p)
    if sel != null and sel != u then
        set s = "另：选中单位「" + GetUnitName(sel) + "」血量 "
        set s = s + I2S(R2I(GetUnitState(sel, UNIT_STATE_LIFE))) + " / "
        set s = s + I2S(R2I(GetUnitState(sel, UNIT_STATE_MAX_LIFE)))
        call WG_MountMessage(p, s)
    endif
    set u = null
    set sel = null
endfunction

function WG_OnChat takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local string cmd
    local string arg
    local integer spacePos = -1
    local integer i = 0
    local unit u

    loop
        exitwhen i >= len
        if SubString(s, i, i + 1) == " " then
            set spacePos = i
            set i = len
        endif
        set i = i + 1
    endloop
    if spacePos == -1 then
        set cmd = s
        set arg = ""
    else
        set cmd = SubString(s, 0, spacePos)
        set arg = SubString(s, spacePos + 1, len)
    endif

    // mount / wing: 添加坐骑蛋 / 翅膀 (按名称或 ID)
    //   ⚠ 本系统**不再监听 additem**: additem 交给装备浏览器(scripts/item-browser)统一处理。
    //     以前两个脚本都监听 additem, 于是同一个名字会加出两件东西、弹两条提示
    //     (例如 additem 红龙 -> 我们的"红龙蛋" + 浏览器的"红龙之卵")。
    if WG_StrEqCI(cmd, "mount") then
        call WG_GiveMountByName(p, arg)
    elseif WG_StrEqCI(cmd, "wing") then
        call WG_GiveWingByName(p, arg)
    // hand: 给选中的英雄发一件阿克蒙德之手
    //   掠夺被动挂在它身上；像 LT 这种没注入物品浏览器的图，这是唯一的入口（测试/自用）
    elseif WG_StrEqCI(cmd, "hand") or WG_StrEqCI(cmd, "ak") then
        set u = WG_GetHero(p)
        if u == null then
            call WG_MountMessage(p, "请先选中一个英雄")
        else
            call UnitAddItemById(u, WG_HAND_ITEM)
            call WG_MountMessage(p, GetUnitName(u) + " 获得 阿克蒙德之手")
        endif
    // unride: 卸下坐骑 (物品之外的备用入口)
    elseif WG_StrEqCI(cmd, "unride") then
        call WG_UnrideForPlayer(p)
    // wginfo: 自检 (翅膀物品 / 隐藏魔法书 / 重生冷却)
    elseif WG_StrEqCI(cmd, "wginfo") then
        call WG_ReportWings(p)
    // wghp: 回血量实测 (第一次记基准, 隔 10 秒再输入看净变化)
    elseif WG_StrEqCI(cmd, "wghp") then
        call WG_HpProbe(p)
    endif
    set u = null
endfunction

//---------------------------------------------------------------------------
// 初始化
//---------------------------------------------------------------------------
function WG_InitData takes nothing returns nothing
    // 参数对齐伏魔战记 (Trig_PetA1 数组):
    //   坐骑高度 = arr[600+idx] = 260; 英雄高度 = arr[400+idx]; 缩放 = arr[idx]%
    //   缩放用 SetUnitScalePercent(u, s*100, 100, 100) —— 仅 X 轴 (同伏魔战记)!
    //   凤凰 h01D: 缩放130%, 坐骑高260, 英雄高270
    //   龙 n02L/M/N/P: 缩放140%, 坐骑高260, 英雄高240/250
    //   坐骑单位 = 自定义单位 (war3map.w3u, 完全照抄伏魔战记: 同模型 + 同属性)
    // 模型再放大 20% (玩家反馈偏小): 凤凰 0.78 -> 0.936, 龙 0.84 -> 1.008
    //   注意: 只放大坐骑本体; 召唤的小龙仍是 48%(绝对), 所以相对坐骑会更小一点。
    // >>> GENERATED:BEGIN mount_table (wings_config.py) >>>
    set wg_eggCount = 0
    // >>> GENERATED:END mount_table <<<
    // 骑手槽位表: 英雄句柄 -> 槽位 (按英雄记状态, 见 WG_SlotOf)
    if wg_slotTable == null then
        set wg_slotTable = InitHashtable()
    endif

    // --- 翅膀附带效果表 (移植到别的图只改这里) ---
    //   ⚠ 翅膀物品里只放 主动+加速+模型(物品技能列表有 4 个上限);
    //     光环/被动装进下面的"隐藏魔法书", 由 WG_WingSync 加到英雄身上并隐藏。
    // >>> GENERATED:BEGIN wing_table (wings_config.py) >>>
    set wg_wingCount = 4
    set wg_wingItem[0] = 'I100'
    set wg_wingBook[0] = 'W080'
    set wg_wingBook2[0] = 0
    set wg_wingName[0] = "堕落天使之翼"
    set wg_wingItem[1] = 'I101'
    set wg_wingBook[1] = 'W081'
    set wg_wingBook2[1] = 0
    set wg_wingName[1] = "炽天使之翼"
    set wg_wingItem[2] = 'I102'
    set wg_wingBook[2] = 'W082'
    set wg_wingBook2[2] = 0
    set wg_wingName[2] = "恶魔之翼"
    set wg_wingItem[3] = 'I104'
    set wg_wingBook[3] = 0
    set wg_wingBook2[3] = 0
    set wg_wingName[3] = "星魂之力"
    // >>> GENERATED:END wing_table <<<
endfunction

function WG_RegisterChat3 takes nothing returns nothing
    local trigger t = CreateTrigger()
    local integer i = 0
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "wing", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "mount", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "unride", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "wginfo", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "wghp", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function WG_OnChat)
    set t = null
endfunction

function WG_RegisterChat2 takes nothing returns nothing
    set wg_regTimer = CreateTimer()
    call TimerStart(wg_regTimer, 0.02, false, function WG_RegisterChat3)
endfunction

function WG_RegisterChat takes nothing returns nothing
    set wg_regTimer = CreateTimer()
    call TimerStart(wg_regTimer, 0.02, false, function WG_RegisterChat2)
endfunction

// 攻击 -> 命令坐骑攻击同一目标 + 召唤两只小龙 (模仿伏魔战记)
//   由英雄攻击触发 (坐骑本身不索敌, 只做视觉跟随)
//   最多保留 2 只 (超出移除最旧的 -> "先知狼"行为)
function WG_OnMountAttack takes nothing returns nothing
    local unit atk = GetAttacker()
    local integer slot
    local integer i
    local unit d
    local real x
    local real y
    local real ang
    // 状态按英雄算: 攻击者必须正好是某个槽位的骑手
    set slot = WG_SlotOfExisting(atk)
    if slot < 0 or not wg_riderRiding[slot] then
        set atk = null
        return
    endif
    // 保险: 该槽位的主人必须就是攻击者本人
    if wg_riderHero[slot] != atk then
        set atk = null
        return
    endif
    // 命令坐骑攻击英雄的目标 (坐骑不自动索敌, 由英雄攻击带动)
    if wg_riderMount[slot] != null then
        call IssueTargetOrder(wg_riderMount[slot], "attack", GetTriggerUnit())
    endif
    // 召唤小龙: 数量/冷却都来自配置 (WG_SUMMON_COUNT / WG_SUMMON_CD)。
    //   WG_SUMMON_COUNT = 0 就是"关掉召唤" —— 战役里用这个档位,
    //   因为"每次攻击召唤小龙"会明显破坏战役平衡。
    if WG_SUMMON_COUNT <= 0 then
        set atk = null
        return
    endif
    // 召唤冷却 (原版伏魔战记 15 秒) —— 每个骑手各算各的
    if TimerGetElapsed(wg_gameTimer) - wg_riderCd[slot] < WG_SUMMON_CD then
        set atk = null
        return
    endif
    set wg_riderCd[slot] = TimerGetElapsed(wg_gameTimer)
    // 移除上一批召唤物 ("先知狼"行为: 新召唤出现, 旧的消失)
    //   ⚠ 必须确认它真的是召唤物。JASS 的 unit 句柄会被回收复用：召唤物死后
    //   变量里残留的旧句柄可能"变成"另一个单位，直接 RemoveUnit 会把坐骑一起删掉
    //   —— 这正是"坐骑过一段时间自己消失"的元凶（和攻击/召唤节奏绑定）。
    //   伏魔战记用 SetUnitUserData(召唤物, 2000) 做标记，这里照做。
    if wg_riderSum1[slot] != null then
        if wg_riderSum1[slot] != wg_riderMount[slot] and GetUnitUserData(wg_riderSum1[slot]) == 2000 then
            call RemoveUnit(wg_riderSum1[slot])
        endif
        set wg_riderSum1[slot] = null
    endif
    if wg_riderSum2[slot] != null then
        if wg_riderSum2[slot] != wg_riderMount[slot] and GetUnitUserData(wg_riderSum2[slot]) == 2000 then
            call RemoveUnit(wg_riderSum2[slot])
        endif
        set wg_riderSum2[slot] = null
    endif
    // 召唤 N 只小龙 (坐骑的缩小副本), 自动攻击 (参数对齐伏魔战记)
    set i = 0
    loop
        exitwhen i >= WG_SUMMON_COUNT or i > 1
        set ang = GetRandomReal(0.0, 270.0)
        set x = GetUnitX(atk) + 200.0 * Cos(ang * bj_DEGTORAD)
        set y = GetUnitY(atk) + 200.0 * Sin(ang * bj_DEGTORAD)
        set d = CreateUnit(GetOwningPlayer(atk), wg_eggUnit[wg_riderEgg[slot]], x, y, GetUnitFacing(atk))
        // 移动速度: 召唤物是"坐骑单位的副本"，用的是原版速度（龙约 320）——
        //   而英雄戴上翅膀后是 +100 移速，召唤物一开打就掉队。
        //   这里直接给它"英雄当前速度 + 50"（引擎自己会按 522 封顶）。
        call SetUnitMoveSpeed(d, GetUnitMoveSpeed(atk) + 50.0)
        call UnitAddAbility(d, 'Aloc')
        call UnitAddAbility(d, 'Amrf')
        // 身份标记 (同伏魔战记): 清理旧召唤物时靠它确认"这确实是召唤物"
        call SetUnitUserData(d, 2000)
        // 缩放: 仅 X 轴。伏魔战记是 80%(相对它满缩放的坐骑), 而我们的坐骑缩放值
        //   是它的 0.6 倍(龙 84% 对应它的 140%), 所以这里必须是 80*0.6 = 48%
        //   才能和伏魔战记的小龙一样小; 写 80 会让小龙跟坐骑一样大。
        call SetUnitScalePercent(d, 48.0, 100.0, 100.0)
        call SetUnitPathing(d, false)
        // 索敌范围: 不要 30000 (全图追怪会把野怪拉走乱跑)。用适中范围, 只打附近目标。
        call SetUnitAcquireRange(d, 700.0)
        // 本工程坐骑是地面单位(龙), 需显式抬高到坐骑高度 (伏魔战记自定义单位自带默认高度, 故无需)
        call SetUnitFlyHeight(d, GetUnitFlyHeight(wg_riderMount[slot]), 0.0)
        // 存活时间 (wg_summonLife): 0 = 不自动消失, 只在下次召唤/卸下时替换
        if wg_summonLife > 0.0 then
            call UnitApplyTimedLife(d, 'BTLF', wg_summonLife)
        endif
        // 召唤物死亡 -> 立刻清空变量 (防句柄回收复用后误删坐骑)
        call TriggerRegisterUnitEvent(wg_deathTrig, d, EVENT_UNIT_DEATH)
        call IssueTargetOrder(d, "attack", GetTriggerUnit())
        if i == 0 then
            set wg_riderSum1[slot] = d
        else
            set wg_riderSum2[slot] = d
        endif
        set i = i + 1
    endloop
    set atk = null
    set d = null
endfunction

//---------------------------------------------------------------------------
// 掠夺（阿克蒙德之手的被动）: **击杀**敌方单位时按目标等级掠夺金币
//   数值与判定**照抄《西方世界的劫难6》**里的「掠夺」脚本（玩家指定的参考图）：
//     条件: 击杀者持有本装备、目标是敌人、非幻象、非召唤物、最大生命 >= WG_PLUNDER_MIN_HP
//     金币: 非英雄 (base + 等级*per_lv + 随机(1..等级)*rand) / div
//           英雄   (hero_base + 等级*hero_per_lv + 随机(1..等级)*hero_rand) / div
//     表现: 目标位置飘绿色「掠夺+N」，然后加金币（原图是 150 高度、1 秒寿命）。
//   ⚠ 第一版做的是"每次攻击 +3 金"（还有一个全局/同目标冷却），玩家实测体感不好 ——
//     打一下给一点金，和被掠夺的目标毫无关系。改成击杀制后"掠夺"才和战果挂钩。
//---------------------------------------------------------------------------
function WG_OnPlunder takes nothing returns nothing
    local unit killer = GetKillingUnitBJ()
    local unit victim = GetTriggerUnit()
    local player p
    local integer lvl
    local integer r
    local integer gold
    local texttag tt
    if WG_PLUNDER_ENABLE <= 0 then
        set killer = null
        set victim = null
        return
    endif
    if killer == null or victim == null then
        set killer = null
        set victim = null
        return
    endif
    // 击杀者必须是"拿着阿克蒙德之手的单位"
    if not UnitHasItemOfTypeBJ(killer, WG_HAND_ITEM) then
        set killer = null
        set victim = null
        return
    endif
    if IsUnitIllusionBJ(victim) or IsUnitIllusionBJ(killer) then
        set killer = null
        set victim = null
        return
    endif
    // 召唤物不算战果（原图同样排除），友军/自己的单位当然也不掠夺
    if IsUnitType(victim, UNIT_TYPE_SUMMONED) then
        set killer = null
        set victim = null
        return
    endif
    if IsUnitAlly(victim, GetOwningPlayer(killer)) then
        set killer = null
        set victim = null
        return
    endif
    // 只掠夺"够格"的目标（原图：最大生命 >= 500，把小鱼小虾挡掉）
    if WG_PLUNDER_MIN_HP > 0.0 then
        if GetUnitState(victim, UNIT_STATE_MAX_LIFE) < WG_PLUNDER_MIN_HP then
            set killer = null
            set victim = null
            return
        endif
    endif
    set lvl = GetUnitLevel(victim)
    if lvl < 1 then
        set lvl = 1
    endif
    set r = GetRandomInt(1, lvl)
    if IsUnitType(victim, UNIT_TYPE_HERO) then
        set gold = (WG_PLUNDER_HERO_BASE + lvl * WG_PLUNDER_HERO_PER_LV + r * WG_PLUNDER_HERO_RAND) / WG_PLUNDER_DIV
    else
        set gold = (WG_PLUNDER_BASE + lvl * WG_PLUNDER_PER_LV + r * WG_PLUNDER_RAND) / WG_PLUNDER_DIV
    endif
    if gold < 1 then
        set gold = 1
    endif
    set p = GetOwningPlayer(killer)
    call AdjustPlayerStateBJ(gold, p, PLAYER_STATE_RESOURCE_GOLD)
    // 绿色飘字「掠夺+N」（原图是 100/100/30 的 0-100 色值 → 这里用 0-255）
    set tt = CreateTextTag()
    call SetTextTagText(tt, "掠夺+" + I2S(gold), 0.023)
    call SetTextTagPos(tt, GetUnitX(victim), GetUnitY(victim), 150.0)
    call SetTextTagVelocity(tt, 0.0, 0.035)
    call SetTextTagColor(tt, 255, 255, 77, 255)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.0)
    call SetTextTagFadepoint(tt, 0.75)
    set tt = null
    set killer = null
    set victim = null
endfunction

//---------------------------------------------------------------------------
// 星魂之力的主动「灰烬雷暴」—— 照抄 194213 里阿克蒙德的 A6V0
//---------------------------------------------------------------------------
// 星魂之力的被动「献祭」—— 伤害由脚本按"最高属性"算（技能本体只留观感，见 gen_wing.py）
//   原版献祭口径：只烧敌人、**不打魔法免疫**、**不打建筑**；伤害类型 = 魔法/魔法（吃魔抗）
//   数值：500 码 / 每 0.5 秒 / 最高属性 × 0.5（想调就改下面这两个数字）
//   ⚠ 星魂之力在 WINGS 表里是第 4 件 → wg_wingItem[3]；以后换了顺序要跟着改。
function WG_OnImmolation takes nothing returns nothing
    local integer pid = 0
    local unit u
    local unit t
    local player p
    local real dmg
    local group g = CreateGroup()
    loop
        exitwhen pid > 11
        call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(pid), null)
        loop
            set u = FirstOfGroup(bj_lastCreatedGroup)
            exitwhen u == null
            call GroupRemoveUnit(bj_lastCreatedGroup, u)
            if IsUnitType(u, UNIT_TYPE_DEAD) == false and wg_wingItem[3] != 0 and UnitHasItemOfTypeBJ(u, wg_wingItem[3]) then
                set p = GetOwningPlayer(u)
                // 最高属性（含装备加成）= 三围取最大，和 WG_AshStat 的 "max" 口径一致。
                // 这里内联是为了避开"WG_AshStat 定义在本函数之后、JASS 不许先引用"的限制。
                set dmg = I2R(IMaxBJ(IMaxBJ(GetHeroStr(u, true), GetHeroAgi(u, true)), GetHeroInt(u, true))) * 0.5
                call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 300.0, null)
                loop
                    set t = FirstOfGroup(g)
                    exitwhen t == null
                    call GroupRemoveUnit(g, t)
                    if IsUnitType(t, UNIT_TYPE_DEAD) == false and IsUnitEnemy(t, p) and IsUnitType(t, UNIT_TYPE_MAGIC_IMMUNE) != true and IsUnitType(t, UNIT_TYPE_STRUCTURE) != true then
                        call UnitDamageTarget(u, t, dmg, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                endloop
                // 观感交给物品上的 `AIcf`（火焰风衣）技能本身："英雄被火焰包围"，
                // 这里是纯伤害结算（300 码 / 每 0.5 秒 / 最高属性×0.5）。
            endif
        endloop
        set pid = pid + 1
    endloop
    call DestroyGroup(g)
    set g = null
    set u = null
    set t = null
endfunction

//---------------------------------------------------------------------------
// 星魂之力的主动「灰烬雷暴」—— 照抄 194213 里阿克蒙德的 A6V0
//   技能本体是自带的「通道(Channel)」假技能：一点原生效果都没有，全在这里演。
//   一阶：自身回血(200+最高属性*4) → 起手特效 ssw1 + 屏幕震动 → 9 点雷暴环
//        （中心 + 半径 300 的 8 个方向，方向表照抄原码）→ 地形波纹
//        → 500 范围内"敌人且非魔法免疫"吃 400+最高属性*4 混沌/通用伤害
//        → 假单位放一发 500 范围的雷霆一击（减速 8 秒，buff 是照抄的 B642「灰烬之电」）
//   二阶：一阶放完 1 秒**自动**接上（同一个落点）= 假单位引导集群火箭（3 发导弹的视觉），
//        脚本按 0.5 秒的节奏补 3 次 300+最高属性 的落雷伤害（照原码"最多 3 次"）。
//   ⚠ 主属性 = 佩戴者的**最高属性**（含装备加成）；原码里那一项是"智力"。
//     1.24 没有"读取单位主属性"的原生函数，只能三个属性比大小。
//   ⚠ 原码的二阶是靠"e641 受伤害触发器"补伤害的；我们换成正时器（LT 没有那套
//     伤害触发器），节奏/数值/视觉都按原码来。
//---------------------------------------------------------------------------
function WG_AshStat takes unit hero returns integer
    local integer s
    local integer a
    local integer i
    if hero == null then
        return 0
    endif
    if not IsUnitType(hero, UNIT_TYPE_HERO) then
        return 0
    endif
    if WG_ASH_STAT == 1 then
        return GetHeroStr(hero, true)
    endif
    if WG_ASH_STAT == 2 then
        return GetHeroAgi(hero, true)
    endif
    if WG_ASH_STAT == 3 then
        return GetHeroInt(hero, true)
    endif
    // 最高属性（含装备加成）
    set s = GetHeroStr(hero, true)
    set a = GetHeroAgi(hero, true)
    set i = GetHeroInt(hero, true)
    if s >= a and s >= i then
        return s
    endif
    if a >= i then
        return a
    endif
    return i
endfunction

// 在 9 个点上各放一发特效（中心 + 半径 WG_ASH_RING 的 8 个方向）。
//   方向表**照抄原码**：-90 / 90 / 180 / 360 / 270 / -270 / 45 / -45
//   （其中有重复项，所以实际只有 6 个不同方向 —— 这是原图的样子，不"优化"它）
//   原码是"先放 9 发 Stormfall Red、再放 9 发雷霆一击落地"，所以这里也分两趟调用。
function WG_AshRingPass takes real cx, real cy, string fx returns nothing
    local real r = WG_ASH_RING
    local effect e
    set e = AddSpecialEffect(fx, cx, cy)
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(-90.0 * bj_DEGTORAD), cy + r * Sin(-90.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(90.0 * bj_DEGTORAD), cy + r * Sin(90.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(180.0 * bj_DEGTORAD), cy + r * Sin(180.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(360.0 * bj_DEGTORAD), cy + r * Sin(360.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(270.0 * bj_DEGTORAD), cy + r * Sin(270.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(-270.0 * bj_DEGTORAD), cy + r * Sin(-270.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(45.0 * bj_DEGTORAD), cy + r * Sin(45.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = AddSpecialEffect(fx, cx + r * Cos(-45.0 * bj_DEGTORAD), cy + r * Sin(-45.0 * bj_DEGTORAD))
    call DestroyEffect(e)
    set e = null
endfunction

// 区域伤害（一阶/二阶共用）：照抄原码的过滤条件 = 敌人 且 非魔法免疫（建筑照打）
//   hitfx = 1 时给每个挨打的单位挂一发爆炸特效（原码二阶每次命中都有这一下）
function WG_AshHit takes unit caster, real cx, real cy, integer dmg_base, real mult, integer hitfx returns nothing
    local group g = CreateGroup()
    local unit u
    local player p = GetOwningPlayer(caster)
    local real dmg = I2R(dmg_base) + I2R(WG_AshStat(caster)) * mult
    local effect e
    call GroupEnumUnitsInRange(g, cx, cy, WG_ASH_RADIUS, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if GetUnitTypeId(u) != 0 and IsUnitType(u, UNIT_TYPE_DEAD) == false and IsUnitEnemy(u, p) and IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) != true then
            call UnitDamageTarget(caster, u, dmg, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
            if hitfx == 1 then
                set e = AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", u, "origin")
                call DestroyEffect(e)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set e = null
    set g = null
    set u = null
endfunction

// 二阶：按 WG_ASH_WAVE_INT 的节奏砸 WG_ASH_WAVE_COUNT 次（原码"最多 3 次"）
function WG_AshWave takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer key = GetHandleId(t)
    local unit caster = LoadUnitHandle(wg_ashTable, key, 0)
    local real cx = LoadReal(wg_ashTable, key, 1)
    local real cy = LoadReal(wg_ashTable, key, 2)
    local integer left = LoadInteger(wg_ashTable, key, 3)
    if caster == null or GetUnitTypeId(caster) == 0 then
        call FlushChildHashtable(wg_ashTable, key)
        call DestroyTimer(t)
        set t = null
        return
    endif
    call WG_AshHit(caster, cx, cy, WG_ASH_WAVE_DAMAGE, WG_ASH_WAVE_MULT, 1)
    set left = left - 1
    if left <= 0 then
        call FlushChildHashtable(wg_ashTable, key)
        call DestroyTimer(t)
    else
        call SaveInteger(wg_ashTable, key, 3, left)
    endif
    set caster = null
    set t = null
endfunction

// 屏幕震动到点清掉（原码是 sleep 1.0 后 CameraClearNoiseForPlayer）
//   ⚠ 必须写在 WG_AshComboOn **前面** —— 裸 JASS 不支持"先调用后定义"
function WG_AshClearShake takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer key = GetHandleId(t)
    local player p = LoadPlayerHandle(wg_ashTable, key, 0)
    if p != null then
        call CameraClearNoiseForPlayer(p)
    endif
    call FlushChildHashtable(wg_ashTable, key)
    call DestroyTimer(t)
    set t = null
endfunction

// 一阶放完 WG_ASH_COMBO 秒后**自动接二阶**（时序照原码的 1 秒）：
//   假单位在同一个落点引导集群火箭（视觉）+ 排 3 次落雷伤害
function WG_AshComboOn takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer key = GetHandleId(t)
    local unit caster = LoadUnitHandle(wg_ashTable, key, 0)
    local player p = LoadPlayerHandle(wg_ashTable, key, 4)
    local real cx = LoadReal(wg_ashTable, key, 1)
    local real cy = LoadReal(wg_ashTable, key, 2)
    local unit d
    local location loc
    local timer t2
    call FlushChildHashtable(wg_ashTable, key)
    call DestroyTimer(t)
    set t = null
    if caster == null or GetUnitTypeId(caster) == 0 then
        // 英雄没了（死了/被移除）：只把屏幕震动清掉
        if p != null then
            call CameraClearNoiseForPlayer(p)
        endif
    else
        call CameraSetEQNoiseForPlayer(p, WG_ASH_SHAKE)
        set d = CreateUnit(p, WG_ASH_DUMMY_ROCKETS, cx, cy, 0.0)
        call UnitAddAbility(d, WG_ASH_ROCKETS)
        call IssuePointOrder(d, "clusterrockets", cx, cy)
        call UnitApplyTimedLife(d, 'BTLF', 4.0)
        set d = null
        set loc = Location(cx, cy)
        call TerrainDeformationRippleBJ(2.0, false, loc, 600.0, 200.0, 100.0, 0.5, 50.0)
        call RemoveLocation(loc)
        set loc = null
        // 落点补 3 次雷暴伤害（原码里集群火箭"最多 3 次"那一档）
        set t2 = CreateTimer()
        call SaveUnitHandle(wg_ashTable, GetHandleId(t2), 0, caster)
        call SaveReal(wg_ashTable, GetHandleId(t2), 1, cx)
        call SaveReal(wg_ashTable, GetHandleId(t2), 2, cy)
        call SaveInteger(wg_ashTable, GetHandleId(t2), 3, WG_ASH_WAVE_COUNT)
        call TimerStart(t2, WG_ASH_WAVE_INT, true, function WG_AshWave)
        set t2 = null
        // 二阶的屏幕震动 1 秒后清掉
        set t2 = CreateTimer()
        call SavePlayerHandle(wg_ashTable, GetHandleId(t2), 0, p)
        call TimerStart(t2, WG_ASH_COMBO, false, function WG_AshClearShake)
        set t2 = null
    endif
    set caster = null
endfunction

// 主入口：一阶（放完 WG_ASH_COMBO 秒后自动接二阶）
//   注册在 EVENT_PLAYER_UNIT_SPELL_EFFECT
function WG_OnAshFall takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player p
    local unit d
    local timer t
    local location loc
    local effect e
    local real cx
    local real cy
    if GetSpellAbilityId() != WG_ASH_ABILITY then
        set caster = null
        return
    endif
    if caster == null then
        set caster = null
        return
    endif
    if wg_ashTable == null then
        set wg_ashTable = InitHashtable()
    endif
    set p = GetOwningPlayer(caster)
    set cx = GetSpellTargetX()
    set cy = GetSpellTargetY()
    set loc = Location(cx, cy)
    // ===== 一阶：自身回血 + 起手特效 + 9 点雷暴环 + 区域伤害 + 减速 =====
    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + I2R(WG_ASH_HEAL) + I2R(WG_AshStat(caster)) * WG_ASH_HEAL_MULT)
    set e = AddSpecialEffectTarget(WG_ASH_FX_CASTER, caster, "origin")
    call DestroyEffect(e)
    set e = null
    call CameraSetEQNoiseForPlayer(p, WG_ASH_SHAKE)
    call WG_AshRingPass(cx, cy, WG_ASH_FX)
    call WG_AshRingPass(cx, cy, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
    call TerrainDeformationRippleBJ(2.0, false, loc, 600.0, 200.0, 100.0, 0.5, 50.0)
    call WG_AshHit(caster, cx, cy, WG_ASH_DAMAGE, WG_ASH_STAT_MULT, 0)
    // 假单位在落点放一发 500 范围的雷霆一击 = 减速那一环（buff 是照抄的 B642「灰烬之电」）
    set d = CreateUnit(p, WG_ASH_DUMMY_THUNDER, cx, cy, 0.0)
    call UnitAddAbility(d, WG_ASH_THUNDER)
    call IssueImmediateOrder(d, "thunderclap")
    call UnitApplyTimedLife(d, 'BTLF', 4.0)
    set d = null
    call RemoveLocation(loc)
    set loc = null
    // WG_ASH_COMBO 秒后自动接二阶（同一个落点）
    //   （屏幕震动的清除也交给二阶那一段：这样两段之间不会闪一下）
    set t = CreateTimer()
    call SaveUnitHandle(wg_ashTable, GetHandleId(t), 0, caster)
    call SaveReal(wg_ashTable, GetHandleId(t), 1, cx)
    call SaveReal(wg_ashTable, GetHandleId(t), 2, cy)
    call SavePlayerHandle(wg_ashTable, GetHandleId(t), 4, p)
    call TimerStart(t, WG_ASH_COMBO, false, function WG_AshComboOn)
    set t = null
    set caster = null
endfunction

//---------------------------------------------------------------------------
// 死亡之指（阿克蒙德之手的主动；2026-10-15 玩家定的数值）
//   伤害 = 最高属性 × WG_FINGER_HERO_MULT（英雄）/ × WG_FINGER_OTHER_MULT（非英雄翻倍）
//   混沌攻击 + 万能伤害类型 → 无视护甲与魔法免疫（技能说明也是这么写的）
//   ⚠ "魔免单位也能被选中"靠的是技能本体：底子换成 Channel 并打开
//     "物理法术 + 万能法术"两位（见 gen_wing.py 的 Ncl3=15）。原来那个
//     Chain Lightning 底子是魔法系指向性技能，点魔免单位时引擎直接拒绝施法，
//     触发器根本不会跑 —— 脚本这边写得再对也没用。
//   冷却/耗魔按最高属性分档（技能本体 7 档，见 wings_config.finger_level_table），
//   WG_FingerSync 每秒把技能等级调成对应档位。
//---------------------------------------------------------------------------
// 闪电 0.35 秒后删掉（一次性计时器，天然支持多人同时放）
function WG_FingerBoltFade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer key = GetHandleId(t)
    local lightning bolt = LoadLightningHandle(wg_ashTable, key, 5)
    if bolt != null then
        call DestroyLightning(bolt)
    endif
    call FlushChildHashtable(wg_ashTable, key)
    call DestroyTimer(t)
    set t = null
endfunction

function WG_OnFinger takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local player p
    local integer stat
    local integer lvl
    local real dmg
    local real refund
    local lightning bolt
    local timer t
    if GetSpellAbilityId() != WG_FINGER_ABILITY then
        set caster = null
        return
    endif
    if caster == null or target == null then
        set caster = null
        set target = null
        return
    endif
    if wg_ashTable == null then
        set wg_ashTable = InitHashtable()
    endif
    set p = GetOwningPlayer(caster)
    // ⚠ Channel 本体**没有"目标许可表"**（详见 gen_wing.py 的注释）：自己 / 友军 /
    //   中立被动单位也能被点中。所以这里兜一层 —— 不是敌方就把魔按**当前档**退回去、
    //   提示一句，不放伤害（冷却没法单独清，这条算已知代价）。
    if not IsUnitEnemy(target, p) and GetPlayerId(GetOwningPlayer(target)) != PLAYER_NEUTRAL_PASSIVE and GetPlayerId(GetOwningPlayer(target)) != PLAYER_NEUTRAL_AGGRESSIVE then
        set lvl = GetUnitAbilityLevel(caster, WG_FINGER_ABILITY)
        if lvl < 1 then
            set lvl = 1
        endif
        set refund = I2R(WG_FINGER_MANA_BASE) - I2R((lvl - 1) * WG_FINGER_STEP) / WG_FINGER_MANA_DIV
        if refund < I2R(WG_FINGER_MANA_MIN) then
            set refund = I2R(WG_FINGER_MANA_MIN)
        endif
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + I2R(R2I(refund + 0.5)))
        call DisplayTimedTextToPlayer(p, 0, 0, 5.0, "|cffcc00ff[死亡之指]|r 只能对敌方或中立单位使用（魔法已退回）。")
        set caster = null
        set target = null
        return
    endif
    set stat = WG_AshStat(caster)
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set dmg = I2R(stat) * WG_FINGER_HERO_MULT
    else
        set dmg = I2R(stat) * WG_FINGER_OTHER_MULT
    endif
    if dmg < 1.0 then
        set dmg = 1.0
    endif
    // 施法特效：底子已经换成官方 ANfd，**闪电由引擎按技能的 LightningEffect 画**
    //   （引擎锚在单位的显示位置上，不会像脚本那样画歪）。
    //   下面这段只是**兜底**：配置 finger_script_bolt=1 时脚本再补一条（默认关）。
    set wg_fingerLastTarget = GetUnitName(target)
    set wg_fingerLastX1 = GetUnitX(caster)
    set wg_fingerLastY1 = GetUnitY(caster)
    set wg_fingerLastX2 = GetUnitX(target)
    set wg_fingerLastY2 = GetUnitY(target)
    // 技能自己那一份"目标点"（引擎给的），用来和上面的单位坐标对照
    set wg_fingerLastTX = GetSpellTargetX()
    set wg_fingerLastTY = GetSpellTargetY()
    set wg_fingerLastDist = SquareRoot((wg_fingerLastX2 - wg_fingerLastX1) * (wg_fingerLastX2 - wg_fingerLastX1) + (wg_fingerLastY2 - wg_fingerLastY1) * (wg_fingerLastY2 - wg_fingerLastY1))
    if WG_FINGER_SCRIPT_BOLT > 0 then
        set bolt = AddLightningEx(WG_FINGER_LIGHTNING, false, wg_fingerLastX1, wg_fingerLastY1, GetUnitFlyHeight(caster) + 60.0, wg_fingerLastX2, wg_fingerLastY2, GetUnitFlyHeight(target) + 60.0)
        set t = CreateTimer()
        call SaveLightningHandle(wg_ashTable, GetHandleId(t), 5, bolt)
        call TimerStart(t, 0.35, false, function WG_FingerBoltFade)
        set t = null
        set bolt = null
    endif
    call UnitDamageTarget(caster, target, dmg, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    set caster = null
    set target = null
endfunction

// 按佩戴者的最高属性把死亡之指调到对应档位（1 档 = 12 秒/100 魔 … 7 档 = 6 秒/40 魔）
function WG_FingerSync takes unit u returns nothing
    local integer lvl
    if u == null then
        return
    endif
    if GetUnitAbilityLevel(u, WG_FINGER_ABILITY) <= 0 then
        return
    endif
    set lvl = 1 + WG_AshStat(u) / WG_FINGER_STEP
    if lvl > WG_FINGER_MAXLVL then
        set lvl = WG_FINGER_MAXLVL
    endif
    if GetUnitAbilityLevel(u, WG_FINGER_ABILITY) != lvl then
        call SetUnitAbilityLevel(u, WG_FINGER_ABILITY, lvl)
    endif
endfunction

//---------------------------------------------------------------------------
// 翅膀附带效果: 把"隐藏魔法书"按需加到英雄身上 / 摘掉
//   物品技能列表有 4 个上限(超出不生效), 所以光环/被动装在魔法书里;
//   书用 SetPlayerAbilityAvailable(..., false) 隐藏 —— 技能栏看不到, 效果照常生效。
//---------------------------------------------------------------------------
function WG_SyncUnit takes unit u returns nothing
    local integer i = 0
    if u == null then
        return
    endif
    loop
        exitwhen i >= wg_wingCount
        if UnitHasItemOfTypeBJ(u, wg_wingItem[i]) then
            // wg_wingBook[i] = 0 表示这件翅膀没有隐藏魔法书（例如"试穿"款只挂模型）
            if wg_wingBook[i] != 0 and GetUnitAbilityLevel(u, wg_wingBook[i]) == 0 then
                call UnitAddAbility(u, wg_wingBook[i])
                // 标记为"永久技能": 触发器加的技能默认是临时的, 会被变形/复活/换单位
                //   之类的事件剥掉。伏魔战记对每个 UnitAddAbility 都会跟一发
                //   UnitMakeAbilityPermanent —— 照做。(每秒对账其实也会补回来,
                //   但重生必须"死的那一刻就挂在身上", 不能等 1 秒的轮询。)
                call UnitMakeAbilityPermanent(u, true, wg_wingBook[i])
                call SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook[i], false)
            endif
            // 第二本小书(只有炽天使之翼有, 装重生)
            if wg_wingBook2[i] != 0 then
                if GetUnitAbilityLevel(u, wg_wingBook2[i]) == 0 then
                    call UnitAddAbility(u, wg_wingBook2[i])
                    call UnitMakeAbilityPermanent(u, true, wg_wingBook2[i])
                    call SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook2[i], false)
                endif
            endif
        else
            if wg_wingBook[i] != 0 and GetUnitAbilityLevel(u, wg_wingBook[i]) > 0 then
                call UnitRemoveAbility(u, wg_wingBook[i])
            endif
            if wg_wingBook2[i] != 0 then
                if GetUnitAbilityLevel(u, wg_wingBook2[i]) > 0 then
                    call UnitRemoveAbility(u, wg_wingBook2[i])
                endif
            endif
        endif
        set i = i + 1
    endloop
endfunction

// 每秒对账。⚠ 必须遍历该玩家的**每一个单位**: 以前只用 WG_PlayerHero(第一个英雄),
//   结果"换到第二个英雄身上戴翅膀就不生效"(光环/重生全都没挂上) —— 就是这里的问题。
function WG_WingSync takes nothing returns nothing
    local integer pid = 0
    local unit u
    loop
        exitwhen pid > 11
        call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(pid), null)
        loop
            set u = FirstOfGroup(bj_lastCreatedGroup)
            exitwhen u == null
            call GroupRemoveUnit(bj_lastCreatedGroup, u)
            call WG_SyncUnit(u)
            // 死亡之指：按这个单位的最高属性调技能档位（没有这个技能就直接返回）
            call WG_FingerSync(u)
        endloop
        set pid = pid + 1
    endloop
    set u = null
endfunction

// 重生(炽天使之翼 I101) = 隐藏魔法书 W081 里的原版 AOre。
//   曾经这里有一层"脚本兜底复活", 但玩家实测会和原版重生**叠加**(能连续复活两次),
//   已删除 —— 现在只由引擎触发, 冷却也走技能自己的 150 秒。
function WG_RegisterTriggers takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddAction(t, function WG_OnUseItem)
    set t = null
    // 丢掉"骑乘中"物品 -> 自动卸下坐骑
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(t, function WG_OnDropItem)
    set t = null
    // 单位死亡事件 (诊断/自愈依据 + 召唤物句柄清理; 创建时逐个注册)
    set wg_deathTrig = CreateTrigger()
    call TriggerAddAction(wg_deathTrig, function WG_OnUnitDeath)
    // 坐骑攻击 -> 召唤两只小龙
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(t, function WG_OnMountAttack)
    set t = null
    // 掠夺（阿克蒙德之手）：**击杀**敌人时按目标等级掠夺金币
    //   （plunder_enable = 0 时 WG_OnPlunder 第一件事就 return，等于关掉）
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function WG_OnPlunder)
    set t = null
    // 灰烬雷暴（星魂之力的主动）：伤害在脚本里按"最高属性"算（技能本体只做特效）
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function WG_OnAshFall)
    set t = null
    // 死亡之指（阿克蒙德之手的主动）：伤害在脚本里按"最高属性"算
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function WG_OnFinger)
    set t = null
    // 坐骑同步计时器 (0.03s, 比伏魔战记 0.04s 更快 -> 消除跟随卡顿)
    call TimerStart(CreateTimer(), 0.03, true, function WG_MountSync)
    // 翅膀"隐藏魔法书"对账 (1s): 戴翅膀 = 加书并隐藏, 摘掉 = 移书
    call TimerStart(CreateTimer(), 1.0, true, function WG_WingSync)
    // 星魂之力的「献祭」(0.5s): 500 码内每 0.5 秒按最高属性烧一次（不打魔免/不打建筑）
    call TimerStart(CreateTimer(), 0.5, true, function WG_OnImmolation)
    // 游戏时间基准计时器
    set wg_gameTimer = CreateTimer()
    call TimerStart(wg_gameTimer, 1000000.0, false, null)
endfunction

function WG_Init takes nothing returns nothing
    call WG_InitData()
    call WG_RegisterTriggers()
    call WG_RegisterChat()
    call DisplayTextToPlayer(Player(0), 0, 0, "|cff00ff00[翅膀/坐骑系统]|r 已加载 (wing/mount)")
endfunction
