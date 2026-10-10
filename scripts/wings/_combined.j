globals
//============================================================================
// WINGS / MOUNT SYSTEM - 全局变量
// 翅膀: 物品(技能挂模型) —— `wing <名称>` 添加
// 坐骑: 蛋物品 —— 使用后创建坐骑单位(英雄骑在上面, 英雄不隐藏) + 蛋变"取消骑乘"物品
//============================================================================

// --- 坐骑蛋 -> (坐骑单位类型, 取消骑乘物品) ---
integer array wg_eggItem          // 蛋物品 ID
integer array wg_eggUnit          // 蛋对应的坐骑单位类型 ID
integer array wg_eggOffItem       // 使用后变成的"取消骑乘"物品 ID
string array wg_eggName           // 坐骑名称
real array wg_eggHeight           // 坐骑单位飞行高度 (让英雄骑在背上)
real array wg_eggHeroHeight       // 英雄飞行高度 (骑乘时抬高)
real array wg_eggScale            // 坐骑单位缩放 (SetUnitScale, 同伏魔战记)
integer wg_eggCount = 0

// 玩家当前坐骑单位
unit array wg_playerMount
// 玩家骑乘时记下的英雄句柄 (同步循环用它, 不再每帧重新查找)
//   WG_GetHero 会优先返回"当前选中单位", 玩家一换选择/换英雄就会变,
//   会导致坐骑瞬移到别的英雄、甚至误判"英雄死亡"而把坐骑卸掉。
unit array wg_rideHero
// 玩家当前坐骑的蛋索引 (缓存, 避免同步时每帧线性查找)
integer array wg_mountIdx
// 玩家是否骑乘中
boolean array wg_isRiding
// 坐骑召唤冷却 (游戏时间戳, 每玩家)
real array wg_summonCd
// 坐骑召唤物 (每玩家最多 2 只, 超出移除最旧的 -> "先知狼"行为)
unit array wg_summon1
unit array wg_summon2
// 召唤物存活时间(秒)。0 = 不自动消失(默认), 改成 20.0 即恢复伏魔战记的定时消失
real wg_summonLife = 0.0

// --- 坐骑自愈 / 诊断 ---
// 坐骑是否死于"死亡事件"(区分"被击杀"与"被引擎替换/移除")
boolean array wg_mountDied
// 单位死亡事件触发器 (坐骑 + 召唤物都注册进来)
trigger wg_deathTrig = null
// 自愈次数 (用于限制提示刷屏)
integer array wg_mountHealCount

// --- 骑乘高度 ---
// 伏魔战记原值: 坐骑 260, 英雄 240/250(红龙)/270(凤凰)。
// 本工程整体下调 50% (玩家反馈坐骑飞太高, 英雄的脚印都悬在天上),
// 2026-10-10 又按玩家要求上调 20%:
//   坐骑 156 (130*1.2), 英雄 144 (120*1.2) / 红龙 149 / 凤凰 159。
// 两段高度都由 WG_MountSync 每帧重设, 所以英雄位置是动态跟上的。
real WG_MOUNT_H = 156.0
real WG_HERO_H = 144.0

// --- 翅膀附带效果表 (移植到别的图只改这张表) ---
//   物品技能列表有 4 个上限(超出不生效), 所以物品里只放 主动+加速+模型;
//   光环/被动装在"隐藏魔法书"里, 由脚本按需加到英雄身上并隐藏 ——
//   既生效, 又**不占英雄技能栏**。
integer array wg_wingItem        // 翅膀物品 ID
integer array wg_wingBook        // 对应的隐藏魔法书技能 ID
// 第二本隐藏魔法书 (0 = 没有)。
//   ⚠ 一本魔法书实测只有**前 3 个**技能会真正挂到单位上(玩家实测: 重生被排到第 4 个就失效),
//     所以炽天使之翼的重生单独放第二本小书里, 两本都 ≤3 个。
integer array wg_wingBook2
integer wg_wingCount = 0


// --- 注册计时器 ---
timer wg_regTimer = null
// 游戏时间基准计时器 (用于召唤冷却计时)
timer wg_gameTimer = null

// 重生(炽天使之翼 I101)没有脚本实现: 完全交给隐藏魔法书 W081 里的原版 AOre
//   (曾加过"脚本兜底复活", 但与原版重生叠加成"连续复活两次", 已删除)。

endglobals
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
    call WG_Message(p, "翅膀: I100 堕落天使之翼 / I101 炽天使之翼 / I102 恶魔之翼")
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
function WG_SpawnMount takes player p, integer idx returns unit
    local integer pid = GetPlayerId(p)
    local unit hero = wg_rideHero[pid]
    local unit mount
    local real x
    local real y
    if idx < 0 or idx >= wg_eggCount then
        return null
    endif
    if hero == null or GetUnitTypeId(hero) == 0 then
        return null
    endif
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
    set wg_playerMount[pid] = mount
    set wg_mountIdx[pid] = idx
    return mount
endfunction

// 单位死亡事件:
//   * 坐骑死 -> 置诊断标记 (自愈时据此区分"被击杀"还是"被替换")
//   * 召唤物死 -> 立刻把变量置空。JASS 的 unit 句柄会被回收复用,
//     残留的旧句柄可能"变成"另一个单位(甚至坐骑), 届时 RemoveUnit 会误删坐骑。
function WG_OnUnitDeath takes nothing returns nothing
    local unit u = GetDyingUnit()
    local integer pid = GetPlayerId(GetOwningPlayer(u))
    if wg_isRiding[pid] and u == wg_playerMount[pid] then
        set wg_mountDied[pid] = true
    endif
    if u == wg_summon1[pid] then
        set wg_summon1[pid] = null
    endif
    if u == wg_summon2[pid] then
        set wg_summon2[pid] = null
    endif
    set u = null
endfunction

// 骑乘: 创建坐骑单位, 英雄骑在坐骑上 (英雄不隐藏)
function WG_RideMount takes player p, integer eggIdx, string mname returns nothing
    local integer pid = GetPlayerId(p)
    local unit hero
    local unit mount
    if wg_isRiding[pid] then
        call WG_MountMessage(p, "你已经在骑乘中")
        return
    endif
    set hero = WG_GetHero(p)
    if hero == null then
        call WG_MountMessage(p, "请先选中一个英雄")
        return
    endif
    // 先清掉背包里可能残留的"骑乘中"物品, 避免出现两件重复的
    call WG_ClearRidingItems(hero)
    set wg_rideHero[pid] = hero
    set mount = WG_SpawnMount(p, eggIdx)
    if mount == null then
        set wg_rideHero[pid] = null
        call WG_MountMessage(p, "创建坐骑失败")
        set hero = null
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
    set wg_isRiding[pid] = true
    set wg_summonCd[pid] = 0.0
    set wg_mountDied[pid] = false
    set wg_mountHealCount[pid] = 0
    call WG_MountMessage(p, "已骑乘: " + mname)
    set hero = null
    set mount = null
endfunction

// 取消骑乘: 移除坐骑单位, 英雄恢复地面
function WG_UnrideMount takes player p returns nothing
    local unit hero = WG_GetHero(p)
    local integer pid = GetPlayerId(p)
    local unit mount = wg_playerMount[pid]
    if not wg_isRiding[pid] then
        call WG_MountMessage(p, "你当前没有骑乘坐骑")
        return
    endif
    if hero != null then
        call SetUnitFlyHeight(hero, 0.0, 0.0)
        // 卸下时清掉所有"骑乘中"物品 (点它卸下/丢掉它自动卸下 都走这里)
        call WG_ClearRidingItems(hero)
    endif
    if mount != null then
        call RemoveUnit(mount)
    endif
    set wg_playerMount[pid] = null
    // 移除召唤物 (只删确实是召唤物的: userdata 2000)
    if wg_summon1[pid] != null then
        if GetUnitUserData(wg_summon1[pid]) == 2000 then
            call RemoveUnit(wg_summon1[pid])
        endif
        set wg_summon1[pid] = null
    endif
    if wg_summon2[pid] != null then
        if GetUnitUserData(wg_summon2[pid]) == 2000 then
            call RemoveUnit(wg_summon2[pid])
        endif
        set wg_summon2[pid] = null
    endif
    set wg_rideHero[pid] = null
    set wg_mountIdx[pid] = -1
    set wg_isRiding[pid] = false
    set wg_mountDied[pid] = false
    call WG_MountMessage(p, "已取消骑乘")
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
    local integer pid = 0
    local unit mount
    local unit hero
    local integer idx
    loop
        exitwhen pid >= bj_MAX_PLAYERS
        if wg_isRiding[pid] then
            set mount = wg_playerMount[pid]
            // 三种情况都要自愈: 句柄失效 / 单位已死(尸体还没消失) / 被引擎替换
            if mount == null or GetUnitTypeId(mount) == 0 or IsUnitType(mount, UNIT_TYPE_DEAD) then
                // 原地重建, 不掉骑乘 (静默处理: 不再弹提示)
                set wg_mountDied[pid] = false
                set mount = WG_SpawnMount(Player(pid), wg_mountIdx[pid])
                if mount == null then
                    call WG_MountMessage(Player(pid), "坐骑无法恢复，已卸下")
                    call WG_UnrideMount(Player(pid))
                endif
            else
                // 用骑乘时记下的英雄句柄。不要每帧调 WG_GetHero:
                //   它会优先返回"当前选中单位", 玩家换选择就会变 -> 坐骑乱飞/误卸载
                set hero = wg_rideHero[pid]
                if hero == null or GetUnitTypeId(hero) == 0 then
                    set hero = WG_GetHero(Player(pid))
                    set wg_rideHero[pid] = hero
                endif
                // 英雄死亡/不存在 -> 自动取消骑乘
                if hero == null or IsUnitType(hero, UNIT_TYPE_DEAD) then
                    // 阵亡一律卸下坐骑(保留坐骑会出 bug); 复活后玩家自己点坐骑蛋再上马
                    call WG_MountMessage(Player(pid), "英雄阵亡，已自动卸下坐骑")
                    call WG_UnrideMount(Player(pid))
                else
                    // 坐骑跟随英雄位置 (瞬移式贴合, 高频周期消除视觉跳帧)
                    call SetUnitX(mount, GetUnitX(hero))
                    call SetUnitY(mount, GetUnitY(hero))
                    // 朝向: 无条件跟英雄一致。伏魔战记 Trig_PetC1 就是无条件
                    //   SetUnitFacing —— 之前"只在空闲时同步"会让龙头锁死在攻击目标上,
                    //   与英雄移动方向不一致(玩家反馈的"龙头锁定")。
                    call SetUnitFacing(mount, GetUnitFacing(hero))
                    // 持续抬高 (地面单位 SetUnitFlyHeight 会被 SetUnitX/Y 重置)
                    set idx = wg_mountIdx[pid]
                    if idx >= 0 and idx < wg_eggCount then
                        call SetUnitFlyHeight(mount, wg_eggHeight[idx], 0.0)
                        // CRITICAL: 英雄高度也必须每帧重设! 否则英雄会被重置为地面单位,
                        //   坐骑/小龙的 ground 溅射会打到英雄 (蓝龙减速+伤害, 英雄易死)。
                        call SetUnitFlyHeight(hero, wg_eggHeroHeight[idx], 0.0)
                    endif
                    // 持续维持无敌 (防止被异常杀死; 不重设生命值, 避免血条闪烁)
                    call SetUnitInvulnerable(mount, true)
                    // 召唤物空闲时跟随英雄 (自然跟随, 不瞬移; 两只分开避免重叠)
                    call WG_FollowSummon(wg_summon1[pid], hero, 0.0)
                    call WG_FollowSummon(wg_summon2[pid], hero, 180.0)
                endif
            endif
        endif
        set pid = pid + 1
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
    if WG_StrEqCI(key, "堕落天使之翼") or WG_StrEqCI(key, "i100") then
        call WG_AddWing(p, 'I100')
    elseif WG_StrEqCI(key, "炽天使之翼") or WG_StrEqCI(key, "i101") then
        call WG_AddWing(p, 'I101')
    elseif WG_StrEqCI(key, "恶魔之翼") or WG_StrEqCI(key, "i102") then
        call WG_AddWing(p, 'I102')
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
    local integer pid = GetPlayerId(p)
    local integer itemId = GetItemTypeId(it)
    local integer idx = WG_EggIndex(itemId)

    if idx >= 0 then
        // === 使用坐骑蛋 -> 骑乘 ===
        // 蛋**不再被消耗/替换** —— 它本身就是"取消骑乘"的按钮 (骑乘中再点一次即取消)。
        // 以前那套"蛋 -> 骑乘中物品"会连带出一堆问题: 多余物品、被脚本移除的物品又被
        // 引擎丢到地上一份、换坐骑时旧的"骑乘中"物品没清导致重复。现在这些都不存在了。
        if wg_isRiding[pid] then
            if wg_mountIdx[pid] == idx then
                // 同一个蛋 -> 取消骑乘
                call WG_UnrideMount(p)
            else
                // 别的蛋 -> 换坐骑
                call WG_UnrideMount(p)
                call WG_RideMount(p, idx, wg_eggName[idx])
            endif
        else
            call WG_RideMount(p, idx, wg_eggName[idx])
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
    local integer pid = GetPlayerId(p)
    local integer idx = WG_EggIndex(GetItemTypeId(it))

    if idx >= 0 and wg_isRiding[pid] and wg_mountIdx[pid] == idx then
        call WG_UnrideMount(p)
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
                    if GetUnitAbilityLevel(u, wg_wingBook[i]) > 0 then
                        set s = s + "(书OK)"
                    else
                        set s = s + "(书缺失)"
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
            call WG_MountMessage(p, s)
            // 光环 buff 实测: 光环如果真的挂在单位身上, 对应 buff 会出现在单位上,
            //   用 GetUnitAbilityLevel(单位, buffID) 就能查出来(缓冲也是"技能"的一种)。
            // 治疗=治疗光环的 buff(原版 Boar, 被 war3map.w3h 覆盖了名称/图标);
            // 阿克蒙德=强击光环 buff(BEar) —— 那条**已经确认能显示图标**, 拿它当对照:
            //   如果 阿克蒙德=1 而 治疗=0, 说明治疗光环这个光环类型根本不挂 buff。
            // 治疗那栏查的是**展示光环**挂的 buff `Babr`（治疗光环的图标就是它贡献的；
            //   W074 的再生光环引擎不挂 buff，所以查 Boar 永远是 0，别被那个 0 误导）。
            set s = "buff 治疗图标=" + I2S(GetUnitAbilityLevel(u, 'Babr')) + " 阿克蒙德=" + I2S(GetUnitAbilityLevel(u, 'BEar'))
            set s = s + " 邪恶=" + I2S(GetUnitAbilityLevel(u, 'BUau')) + " 吸血=" + I2S(GetUnitAbilityLevel(u, 'BUav'))
            set s = s + " 辉煌=" + I2S(GetUnitAbilityLevel(u, 'BHab')) + " 命令=" + I2S(GetUnitAbilityLevel(u, 'BOac'))
            set s = s + " 耐久=" + I2S(GetUnitAbilityLevel(u, 'BOae'))
            call WG_MountMessage(p, s)
        endif
    endloop
    if found == 0 then
        call WG_MountMessage(p, "没有找到英雄")
    endif
    set u = null
endfunction

function WG_OnChat takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local string cmd
    local string arg
    local integer spacePos = -1
    local integer i = 0

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
    // unride: 卸下坐骑 (物品之外的备用入口)
    elseif WG_StrEqCI(cmd, "unride") then
        call WG_UnrideMount(p)
    // wginfo: 自检 (翅膀物品 / 隐藏魔法书 / 重生冷却)
    elseif WG_StrEqCI(cmd, "wginfo") then
        call WG_ReportWings(p)
    endif
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
    set wg_eggCount = 5
    set wg_eggItem[0] = 'I110'
    set wg_eggUnit[0] = 'h01D'
    set wg_eggOffItem[0] = 'I120'
    set wg_eggName[0] = "火凤凰"
    set wg_eggHeight[0] = WG_MOUNT_H
    set wg_eggHeroHeight[0] = WG_HERO_H + 15.0
    set wg_eggScale[0] = 0.936
    set wg_eggItem[1] = 'I111'
    set wg_eggUnit[1] = 'n02N'
    set wg_eggOffItem[1] = 'I121'
    set wg_eggName[1] = "蓝龙"
    set wg_eggHeight[1] = WG_MOUNT_H
    set wg_eggHeroHeight[1] = WG_HERO_H
    set wg_eggScale[1] = 1.008
    set wg_eggItem[2] = 'I112'
    set wg_eggUnit[2] = 'n02M'
    set wg_eggOffItem[2] = 'I122'
    set wg_eggName[2] = "黑龙"
    set wg_eggHeight[2] = WG_MOUNT_H
    set wg_eggHeroHeight[2] = WG_HERO_H
    set wg_eggScale[2] = 1.008
    set wg_eggItem[3] = 'I113'
    set wg_eggUnit[3] = 'n02P'
    set wg_eggOffItem[3] = 'I123'
    set wg_eggName[3] = "红龙"
    set wg_eggHeight[3] = WG_MOUNT_H
    set wg_eggHeroHeight[3] = WG_HERO_H + 5.0
    set wg_eggScale[3] = 1.008
    set wg_eggItem[4] = 'I114'
    set wg_eggUnit[4] = 'n02L'
    set wg_eggOffItem[4] = 'I124'
    set wg_eggName[4] = "青铜龙"
    set wg_eggHeight[4] = WG_MOUNT_H
    set wg_eggHeroHeight[4] = WG_HERO_H
    set wg_eggScale[4] = 1.008
    // 坐骑索引缓存初始化为 -1 (未骑乘)
    set wg_mountIdx[0] = -1
    set wg_mountIdx[1] = -1
    set wg_mountIdx[2] = -1
    set wg_mountIdx[3] = -1
    set wg_mountIdx[4] = -1
    set wg_mountIdx[5] = -1
    set wg_mountIdx[6] = -1
    set wg_mountIdx[7] = -1
    set wg_mountIdx[8] = -1
    set wg_mountIdx[9] = -1
    set wg_mountIdx[10] = -1
    set wg_mountIdx[11] = -1

    // --- 翅膀附带效果表 (移植到别的图只改这里) ---
    //   ⚠ 翅膀物品里只放 主动+加速+模型(物品技能列表有 4 个上限);
    //     光环/被动装进下面的"隐藏魔法书", 由 WG_WingSync 加到英雄身上并隐藏。
    set wg_wingCount = 3
    set wg_wingItem[0] = 'I100'
    set wg_wingBook[0] = 'W080'   // 邪恶光环 + 吸血光环 + 闪避
    set wg_wingBook2[0] = 0
    set wg_wingItem[1] = 'I101'
    set wg_wingBook[1] = 'W081'   // 辉煌光环 + 治疗光环 + 治疗光环(展示)
    set wg_wingBook2[1] = 'W084'  // 第二本小书: 重生
    set wg_wingItem[2] = 'I102'
    set wg_wingBook[2] = 'W082'   // 命令光环 + 耐久光环 + 致命一击
    set wg_wingBook2[2] = 0
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
    local unit hero
    local integer pid
    local integer i
    local unit d
    local real x
    local real y
    local real ang
    set pid = GetPlayerId(GetOwningPlayer(atk))
    if not wg_isRiding[pid] then
        set atk = null
        return
    endif
    // 攻击者必须是"骑乘时记下的那只英雄" (与同步循环保持一致;
    //   用 WG_GetHero 会在多英雄/换选择时取错)
    set hero = wg_rideHero[pid]
    if hero == null or atk != hero then
        set atk = null
        return
    endif
    // 命令坐骑攻击英雄的目标 (坐骑不自动索敌, 由英雄攻击带动)
    if wg_playerMount[pid] != null then
        call IssueTargetOrder(wg_playerMount[pid], "attack", GetTriggerUnit())
    endif
    // 召唤冷却 (15 秒, 同伏魔战记)
    if TimerGetElapsed(wg_gameTimer) - wg_summonCd[pid] < 15.0 then
        set atk = null
        set hero = null
        return
    endif
    set wg_summonCd[pid] = TimerGetElapsed(wg_gameTimer)
    // 移除上一批召唤物 ("先知狼"行为: 新召唤出现, 旧的消失)
    //   ⚠ 必须确认它真的是召唤物。JASS 的 unit 句柄会被回收复用：召唤物死后
    //   变量里残留的旧句柄可能"变成"另一个单位，直接 RemoveUnit 会把坐骑一起删掉
    //   —— 这正是"坐骑过一段时间自己消失"的元凶（和攻击/召唤节奏绑定）。
    //   伏魔战记用 SetUnitUserData(召唤物, 2000) 做标记，这里照做。
    if wg_summon1[pid] != null then
        if wg_summon1[pid] != wg_playerMount[pid] and GetUnitUserData(wg_summon1[pid]) == 2000 then
            call RemoveUnit(wg_summon1[pid])
        endif
        set wg_summon1[pid] = null
    endif
    if wg_summon2[pid] != null then
        if wg_summon2[pid] != wg_playerMount[pid] and GetUnitUserData(wg_summon2[pid]) == 2000 then
            call RemoveUnit(wg_summon2[pid])
        endif
        set wg_summon2[pid] = null
    endif
    // 召唤 2 只小龙 (坐骑的缩小副本), 自动攻击 (参数对齐伏魔战记)
    set i = 0
    loop
        exitwhen i >= 2
        set ang = GetRandomReal(0.0, 270.0)
        set x = GetUnitX(atk) + 200.0 * Cos(ang * bj_DEGTORAD)
        set y = GetUnitY(atk) + 200.0 * Sin(ang * bj_DEGTORAD)
        set d = CreateUnit(GetOwningPlayer(atk), wg_eggUnit[WG_UnitIndexOf(GetUnitTypeId(wg_playerMount[pid]))], x, y, GetUnitFacing(atk))
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
        call SetUnitFlyHeight(d, GetUnitFlyHeight(wg_playerMount[pid]), 0.0)
        // 存活时间 (wg_summonLife): 0 = 不自动消失, 只在下次召唤/卸下时替换
        if wg_summonLife > 0.0 then
            call UnitApplyTimedLife(d, 'BTLF', wg_summonLife)
        endif
        // 召唤物死亡 -> 立刻清空变量 (防句柄回收复用后误删坐骑)
        call TriggerRegisterUnitEvent(wg_deathTrig, d, EVENT_UNIT_DEATH)
        call IssueTargetOrder(d, "attack", GetTriggerUnit())
        if i == 0 then
            set wg_summon1[pid] = d
        else
            set wg_summon2[pid] = d
        endif
        set i = i + 1
    endloop
    set atk = null
    set hero = null
    set d = null
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
            if GetUnitAbilityLevel(u, wg_wingBook[i]) == 0 then
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
            if GetUnitAbilityLevel(u, wg_wingBook[i]) > 0 then
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
    // 坐骑同步计时器 (0.03s, 比伏魔战记 0.04s 更快 -> 消除跟随卡顿)
    call TimerStart(CreateTimer(), 0.03, true, function WG_MountSync)
    // 翅膀"隐藏魔法书"对账 (1s): 戴翅膀 = 加书并隐藏, 摘掉 = 移书
    call TimerStart(CreateTimer(), 1.0, true, function WG_WingSync)
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

function main takes nothing returns nothing
//============================================================================
// WINGS / MOUNT SYSTEM - 入口
//============================================================================
call WG_Init()

endfunction
