globals
// ===========================================================================
// 英雄系统（从优秀地图移植英雄）
// ===========================================================================
integer HB_HERO_COUNT = 0
string array HB_HERO_NAME
string array HB_HERO_ID
string array HB_HERO_ALIAS
integer array HB_HERO_TYPE
integer array HB_HERO_ABIL_COUNT
integer array HB_HERO_ABIL
integer array HB_HERO_ABIL_MAX
integer array HB_HERO_ABIL_REQ
integer array HB_HERO_ABIL_SKIP

integer HB_ABIL_SILENCE = 0
integer HB_ABIL_RAIN = 0
integer HB_ABIL_DRAIN = 0
integer HB_ABIL_ICE = 0
integer HB_ABIL_MULTI = 0
integer HB_ABIL_CHARM = 0
integer HB_ABIL_FROST = 0
integer HB_ABIL_INV = 0
integer HB_ABIL_MULTI_DUMMY = 0
integer HB_ABIL_RAIN_DUMMY = 0
integer HB_UNIT_RAIN = 0
integer HB_UNIT_MULTI = 0
integer array HB_HERO_MORPH

integer HB_ABIL_DH_BURN = 0
integer HB_ABIL_DH_LEASH = 0
integer HB_ABIL_DH_EVASION = 0
integer HB_ABIL_DH_META = 0
integer HB_ABIL_DH_BREATH = 0
integer HB_ABIL_DH_ORB = 0
integer HB_ABIL_DH_BURN_DUMMY = 0
integer HB_ABIL_DH_LEASH_DUMMY = 0
integer HB_ABIL_DH_SWARM_DUMMY = 0
integer HB_UNIT_DH_DUMMY = 0
integer HB_UNIT_DH_DUMMY2 = 0
unit HB_DH_META_UNIT = null
timer HB_DH_META_TIMER = null
unit HB_DH_BURN_UNIT = null
timer HB_DH_BURN_TIMER = null
timer HB_DH_PULL_TIMER = null
group HB_DH_PULL_GROUP = null
location HB_DH_PULL_POINT = null
integer HB_DH_PULL_TICKS = 0

integer HB_ABIL_SH_HEAL = 0
integer HB_ABIL_SH_HEX = 0
integer HB_ABIL_SH_WARD = 0
integer HB_ABIL_SH_VOODOO = 0
integer HB_ABIL_SH_ANCESTOR = 0
integer HB_ABIL_SH_GLAIVE = 0
integer HB_ABIL_SH_HEX_DUMMY = 0
integer HB_UNIT_SH_DUMMY = 0
integer HB_UNIT_SH_SPIRIT = 0
unit array HB_SH_SPIRIT
unit HB_SH_VOODOO_CASTER = null
timer HB_SH_VOODOO_TIMER = null
unit HB_SH_ANCESTOR_CASTER = null
timer HB_SH_ANCESTOR_TIMER = null
integer HB_SH_ANCESTOR_TICKS = 0
unit array HB_SH_MI
unit array HB_SH_MJ
integer HB_SH_EJ = 0
trigger HB_SH_MK = null
trigger HB_SH_ML = null
integer HB_UNIT_SH_SPIRIT2 = 0
integer HB_UNIT_SH_ORB = 0
integer HB_UNIT_SH_WARD1 = 0
integer HB_UNIT_SH_WARD2 = 0
integer HB_UNIT_SH_WARD3 = 0
integer HB_UNIT_SH_WARD4 = 0
integer HB_UNIT_SH_WARD5 = 0
integer HB_SH_WARD_MAX = 96
unit array HB_SH_WARD_UNIT
timer array HB_SH_WARD_TIMER
timer HB_SH_ANCESTOR_INVULN_TIMER = null
integer HB_ABIL_BM_DASH = 0
integer HB_ABIL_BM_BLADE = 0
integer HB_ABIL_BM_WIND = 0
integer HB_ABIL_BM_MIRROR = 0
integer HB_ABIL_BM_GREEN = 0
integer HB_ABIL_BM_BLADE_DUMMY = 0
integer HB_ABIL_BM_MIRROR_DUMMY = 0
integer HB_UNIT_BM_BLADE = 0
integer HB_UNIT_BM_MIRROR = 0
integer HB_UNIT_BM_JUMP = 0
unit HB_BM_JUMP_CASTER = null
unit HB_BM_JUMP_TARGET = null
location HB_BM_JUMP_START = null
timer HB_BM_JUMP_TIMER = null
integer HB_BM_JUMP_TICKS = 0
integer HB_BM_JUMP_SHADOW_COUNT = 0
unit array HB_BM_JUMP_SHADOWS
boolean HB_BM_JUMPING = false
unit HB_BM_FINISH_CASTER = null
unit HB_BM_FINISH_TARGET = null
timer HB_BM_FINISH_TIMER = null
boolean HB_BM_FINISH_HIT = false
unit HB_BM_GREEN_CASTER = null
trigger HB_BM_GREEN_TRIGGER = null
timer HB_BM_GREEN_TIMER = null
boolean HB_INITED = false

integer HB_ABIL_FL_SOUL = 0
integer HB_ABIL_FL_VOLCANO = 0
integer HB_ABIL_FL_ROPE = 0
integer HB_ABIL_FL_ARMOR = 0
integer HB_ABIL_FL_BOOK = 0
integer HB_ABIL_FL_VOLCANO_DUMMY = 0
integer HB_ABIL_FL_CLEAR = 0
integer HB_UNIT_FL_SOUL = 0
integer HB_UNIT_FL_VOLCANO = 0
integer HB_UNIT_FL_ROPE = 0
integer HB_UNIT_FL_ARMOR = 0

integer HB_FL_MAX = 8
integer HB_FL_VOL_MAX = 8
boolean array HB_FL_ROPE_ACTIVE
boolean array HB_FL_ROPE_ENDING
boolean array HB_FL_ROPE_WAS_SAPPER
unit array HB_FL_ROPE_CASTER
timer array HB_FL_ROPE_TIMER
timer array HB_FL_ROPE_GUARD_TIMER
location array HB_FL_ROPE_CENTER
terraindeformation array HB_FL_ROPE_TERRAIN
real array HB_FL_ROPE_ANGLE
integer array HB_FL_ROPE_TICK
unit array HB_FL_ROPE_VISUAL
unit array HB_FL_ROPE_TARGET
boolean array HB_FL_VOL_ACTIVE
unit array HB_FL_VOL_CASTER
location array HB_FL_VOL_POINT

endglobals
// ===========================================================================
// 英雄系统：addhero / listhero / heroskills
// 首个移植英雄：澄海 3C 6.92 光明游侠
// ===========================================================================
function HB_Msg takes player p, string s returns nothing
    call DisplayTextToPlayer(p, 0, 0, s)
endfunction

function HB_GetSelected takes player p returns unit
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, p, null)
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    return u
endfunction

function HB_StrEqCI takes string a, string b returns boolean
    return StringCase(a, false) == StringCase(b, false)
endfunction

function HB_Trim takes string s returns string
    local integer a = 0
    local integer b = StringLength(s)
    loop
        exitwhen a >= b
        if SubString(s, a, a + 1) != " " then
            exitwhen true
        endif
        set a = a + 1
    endloop
    loop
        exitwhen b <= a
        if SubString(s, b - 1, b) != " " then
            exitwhen true
        endif
        set b = b - 1
    endloop
    return SubString(s, a, b)
endfunction

function HB_InList takes string list, string key returns boolean
    local integer i = 0
    local integer a = 0
    local integer n = StringLength(list)
    local string part
    loop
        exitwhen i >= n
        if SubString(list, i, i + 1) == "," then
            set part = HB_Trim(SubString(list, a, i))
            if HB_StrEqCI(part, key) then
                return true
            endif
            set a = i + 1
        endif
        set i = i + 1
    endloop
    set part = HB_Trim(SubString(list, a, n))
    return HB_StrEqCI(part, key)
endfunction

function HB_FindHero takes string name returns integer
    local integer i = 0
    local string n = HB_Trim(name)
    loop
        exitwhen i >= HB_HERO_COUNT
        if HB_StrEqCI(n, HB_HERO_NAME[i]) or HB_StrEqCI(n, HB_HERO_ID[i]) then
            return i
        endif
        if HB_InList(HB_HERO_ALIAS[i], n) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_FindHeroByUnit takes unit u returns integer
    local integer i = 0
    local integer t = GetUnitTypeId(u)
    loop
        exitwhen i >= HB_HERO_COUNT
        if t == HB_HERO_TYPE[i] or t == HB_HERO_MORPH[i] then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_CountUnlockedSkills takes unit u, integer idx returns integer
    local integer i = 0
    local integer lv = GetHeroLevel(u)
    local integer total = 0
    local integer mx
    local integer req
    local integer skip
    local integer n
    loop
        exitwhen i >= HB_HERO_ABIL_COUNT[idx]
        set mx = HB_HERO_ABIL_MAX[idx * 8 + i]
        set req = HB_HERO_ABIL_REQ[idx * 8 + i]
        set skip = HB_HERO_ABIL_SKIP[idx * 8 + i]
        if lv >= req then
            if skip < 1 then
                set skip = 1
            endif
            set n = 1 + (lv - req) / skip
            if n > mx then
                set n = mx
            endif
            set total = total + n
        endif
        set i = i + 1
    endloop
    return total
endfunction

function HB_CountLearnedSkills takes unit u, integer idx returns integer
    local integer i = 0
    local integer total = 0
    local integer aid
    loop
        exitwhen i >= HB_HERO_ABIL_COUNT[idx]
        set aid = HB_HERO_ABIL[idx * 8 + i]
        set total = total + GetUnitAbilityLevel(u, aid)
        set i = i + 1
    endloop
    return total
endfunction

function HB_RefreshSkillPoints takes unit u returns nothing
    local integer idx = HB_FindHeroByUnit(u)
    local integer target
    if idx < 0 then
        return
    endif
    set target = HB_CountUnlockedSkills(u, idx) - HB_CountLearnedSkills(u, idx)
    if target < 0 then
        set target = 0
    endif
    call UnitModifySkillPoints(u, target - GetHeroSkillPoints(u))
endfunction

function HB_ListHero takes player p returns nothing
    local integer i = 0
    call HB_Msg(p, "|cff00ff00英雄系统|r 已载入 " + I2S(HB_HERO_COUNT) + " 位英雄")
    loop
        exitwhen i >= HB_HERO_COUNT
        call HB_Msg(p, HB_HERO_NAME[i] + "  [" + HB_HERO_ID[i] + "]  别名: " + HB_HERO_ALIAS[i])
        set i = i + 1
    endloop
    call HB_Msg(p, "addhero <名称|ID> [等级]  在选中单位旁创建英雄")
    call HB_Msg(p, "heroskills [等级]  测试用：把选中英雄的技能全部点到指定等级")
endfunction

function HB_AddHero takes player p, string arg returns nothing
    local string name
    local string lvlStr
    local string s = HB_Trim(arg)
    local integer sp = -1
    local integer i = 0
    local integer idx
    local integer level
    local unit sel
    local unit u
    local real x
    local real y

    loop
        exitwhen i >= StringLength(s)
        if SubString(s, i, i + 1) == " " then
            set sp = i
            set i = StringLength(s)
        endif
        set i = i + 1
    endloop
    if sp < 0 then
        set name = s
        set lvlStr = ""
    else
        set name = HB_Trim(SubString(s, 0, sp))
        set lvlStr = HB_Trim(SubString(s, sp + 1, StringLength(s)))
    endif
    set idx = HB_FindHero(name)
    if idx < 0 then
        call HB_Msg(p, "|cffff0000没有这个英雄|r: " + name)
        call HB_ListHero(p)
        return
    endif
    set level = 1
    if lvlStr != "" then
        set level = S2I(lvlStr)
    endif
    if level < 1 then
        set level = 1
    endif
    if level > 100 then
        set level = 100
    endif

    set sel = HB_GetSelected(p)
    if sel != null then
        set x = GetUnitX(sel)
        set y = GetUnitY(sel)
    else
        set x = GetCameraTargetPositionX()
        set y = GetCameraTargetPositionY()
    endif
    set u = CreateUnit(p, HB_HERO_TYPE[idx], x + 96.0, y + 96.0, 270.0)
    if u == null then
        call HB_Msg(p, "|cffff0000创建失败|r: 英雄单位数据没有载入")
        return
    endif
    if level > 1 then
        call SetHeroLevel(u, level, false)
    else
        call SetHeroXP(u, 0, false)
    endif
    call HB_RefreshSkillPoints(u)
    call SelectUnitForPlayerSingle(u, p)
    call PanCameraToTimedForPlayer(p, x, y, 0.4)
    call HB_Msg(p, "|cff00ff00" + HB_HERO_NAME[idx] + "|r 已加入，等级 " + I2S(GetHeroLevel(u)))
    call HB_Msg(p, "升级后请手动学习技能；heroskills 仅用于测试")
    set sel = null
    set u = null
endfunction

function HB_HeroSkills takes player p, string arg returns nothing
    local unit u = HB_GetSelected(p)
    local integer idx
    local integer i = 0
    local integer want = 99
    local integer mx
    local integer lv
    local integer aid
    if u == null then
        call HB_Msg(p, "请先选中一个英雄")
        return
    endif
    set idx = HB_FindHeroByUnit(u)
    if idx < 0 then
        call HB_Msg(p, "选中的单位不是已载入的移植英雄")
        return
    endif
    if HB_Trim(arg) != "" then
        set want = S2I(HB_Trim(arg))
    endif
    if want < 1 then
        set want = 1
    endif
    loop
        exitwhen i >= HB_HERO_ABIL_COUNT[idx]
        set aid = HB_HERO_ABIL[idx * 8 + i]
        set mx = HB_HERO_ABIL_MAX[idx * 8 + i]
        set lv = want
        if lv > mx then
            set lv = mx
        endif
        call UnitAddAbility(u, aid)
        call SetUnitAbilityLevel(u, aid, lv)
        set i = i + 1
    endloop
    call HB_RefreshSkillPoints(u)
    call HB_Msg(p, "|cff00ff00" + HB_HERO_NAME[idx] + "|r 的技能已设置为 " + I2S(want) + " 级（受各技能上限限制）")
    set u = null
endfunction

function HB_ShareVision takes unit caster, unit target returns nothing
    local player owner = GetOwningPlayer(caster)
    local integer i = 0
    if target == null then
        return
    endif
    loop
        exitwhen i > 11
        if Player(i) != owner then
            call UnitShareVision(target, Player(i), false)
        endif
        set i = i + 1
    endloop
    call UnitShareVision(target, owner, true)
endfunction

function HB_MultiArrow takes unit caster, location target returns nothing
    local location base = GetUnitLoc(caster)
    local location casterLoc
    local location p
    local unit d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_MULTI, base, 0.0)
    local integer wave = 1
    local integer k
    local real step
    local real ang
    if d == null then
        call RemoveLocation(base)
        call RemoveLocation(target)
        return
    endif
    if target == null then
        set casterLoc = GetUnitLoc(caster)
        set target = PolarProjectionBJ(casterLoc, 600.0, GetUnitFacing(caster))
        call RemoveLocation(casterLoc)
    endif
    loop
        exitwhen wave > 5
        if wave == 1 then
            set step = 15.0
        elseif wave == 2 then
            set step = 12.0
        elseif wave == 3 then
            set step = 9.0
        elseif wave == 4 then
            set step = 6.0
        else
            set step = 3.0
        endif
        call RemoveLocation(base)
        set base = GetUnitLoc(caster)
        set ang = AngleBetweenPoints(base, target)
        call SetUnitPositionLocFacingLocBJ(d, base, target)
        call SetUnitAbilityLevel(d, HB_ABIL_MULTI_DUMMY, wave)
        set k = -3
        loop
            exitwhen k > 3
            set p = PolarProjectionBJ(base, 33.0, ang + I2R(k) * step)
            call IssuePointOrderByIdLoc(d, 852218, p)
            call RemoveLocation(p)
            set k = k + 1
        endloop
        call TriggerSleepAction(0.5)
        set wave = wave + 1
    endloop
    call UnitApplyTimedLife(d, 'BTLF', 0.2)
    call RemoveLocation(base)
    call RemoveLocation(target)
    set d = null
    set p = null
    set base = null
    set casterLoc = null
    set target = null
endfunction

// ===========================================================================
// 恶魔猎手（澄海 3C 6.92）— DH01 / DH02 / DH15 / DH30
// ===========================================================================
function HB_DHBurnStop takes nothing returns nothing
    if HB_DH_BURN_UNIT != null then
        call IssueImmediateOrder(HB_DH_BURN_UNIT, "stop")
        set HB_DH_BURN_UNIT = null
    endif
    if HB_DH_BURN_TIMER != null then
        call DestroyTimer(HB_DH_BURN_TIMER)
        set HB_DH_BURN_TIMER = null
    endif
endfunction

function HB_DHBurnTimer takes unit u returns nothing
    set HB_DH_BURN_UNIT = u
    set HB_DH_BURN_TIMER = CreateTimer()
    call TimerStart(HB_DH_BURN_TIMER, 1.0, false, function HB_DHBurnStop)
endfunction

function HB_DHManaBurn takes unit caster, unit target returns nothing
    local location c = GetUnitLoc(caster)
    local location t = GetUnitLoc(target)
    local group g = CreateGroup()
    local unit u
    local unit d
    call GroupEnumUnitsInRangeOfLoc(g, t, 500.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if u != target and IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_DH_DUMMY, c, 0.0)
            call SetUnitAbilityLevel(d, HB_ABIL_DH_BURN_DUMMY, GetUnitAbilityLevel(caster, HB_ABIL_DH_BURN))
            call IssueTargetOrderById(d, 852487, u)
            call UnitApplyTimedLife(d, 'BTLF', 1.0)
        endif
    endloop
    call DestroyGroup(g)
    call RemoveLocation(c)
    call RemoveLocation(t)
    set u = null
    set d = null
    set g = null
    call HB_DHBurnTimer(caster)
endfunction

function HB_DHLeash takes unit caster, unit target returns nothing
    local location t = GetUnitLoc(target)
    local group g = CreateGroup()
    local group casters = CreateGroup()
    local unit u
    local unit d
    local integer n = 0
    local real dur
    call GroupEnumUnitsInRangeOfLoc(g, t, 500.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and IsUnitType(u, UNIT_TYPE_HERO) and GetUnitUserData(u) != 300 and not UnitHasBuffBJ(u, 'Bovd') and not UnitHasBuffBJ(u, 'Bcy2') and not UnitHasBuffBJ(u, 'Btsp') and not UnitHasBuffBJ(u, 'BHds') then
            call GroupAddUnit(casters, u)
            set n = n + 1
        endif
    endloop
    set dur = 2.7 + 0.3 * I2R(n)
    loop
        set u = FirstOfGroup(casters)
        exitwhen u == null
        call GroupRemoveUnit(casters, u)
        set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_DH_DUMMY2, t, 0.0)
        call UnitAddAbility(d, HB_ABIL_DH_LEASH_DUMMY)
        call IssueTargetOrder(d, "magicleash", u)
        call UnitApplyTimedLife(d, 'BTLF', dur)
    endloop
    call DestroyGroup(g)
    call DestroyGroup(casters)
    call RemoveLocation(t)
    set u = null
    set d = null
    set g = null
    set casters = null
endfunction

function HB_DHPullUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    local location p = GetUnitLoc(u)
    local location np
    local real dist = DistanceBetweenPoints(p, HB_DH_PULL_POINT)
    if IsUnitAliveBJ(u) and GetUnitState(u, UNIT_STATE_LIFE) >= 0.5 then
        if dist > 32.0 and dist < 764.0 then
            set np = PolarProjectionBJ(p, 32.0, AngleBetweenPoints(p, HB_DH_PULL_POINT))
        else
            set np = p
        endif
        call SetUnitPositionLoc(u, np)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", u, "origin"))
        if np != p then
            call RemoveLocation(np)
        endif
    endif
    call RemoveLocation(p)
    set u = null
    set np = null
endfunction

function HB_DHPullTick takes nothing returns nothing
    set HB_DH_PULL_TICKS = HB_DH_PULL_TICKS + 1
    call ForGroup(HB_DH_PULL_GROUP, function HB_DHPullUnit)
    if HB_DH_PULL_TICKS >= 50 or IsUnitGroupEmptyBJ(HB_DH_PULL_GROUP) then
        call PauseTimer(HB_DH_PULL_TIMER)
        call DestroyTimer(HB_DH_PULL_TIMER)
        call DestroyGroup(HB_DH_PULL_GROUP)
        call RemoveLocation(HB_DH_PULL_POINT)
        set HB_DH_PULL_TIMER = null
        set HB_DH_PULL_GROUP = null
        set HB_DH_PULL_POINT = null
    endif
endfunction

function HB_DHBreath takes unit caster returns nothing
    local location c = GetUnitLoc(caster)
    local group g = CreateGroup()
    local unit u
    set HB_DH_PULL_GROUP = CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(g, c, 732.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetUnitUserData(u) != 300 and GetUnitState(u, UNIT_STATE_LIFE) >= 0.5 then
            if GetUnitState(u, UNIT_STATE_MANA) > 0.0 then
                call SetUnitManaBJ(u, GetUnitState(u, UNIT_STATE_MANA) * 0.3)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u, "origin"))
            endif
            call GroupAddUnit(HB_DH_PULL_GROUP, u)
        endif
    endloop
    call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", c))
    set HB_DH_PULL_POINT = c
    set HB_DH_PULL_TICKS = 0
    set HB_DH_PULL_TIMER = CreateTimer()
    call TimerStart(HB_DH_PULL_TIMER, 0.05, true, function HB_DHPullTick)
    call DestroyGroup(g)
    set u = null
    set g = null
endfunction

function HB_DHMetaEnd takes nothing returns nothing
    if HB_DH_META_UNIT != null then
        call SetUnitInvulnerable(HB_DH_META_UNIT, false)
        set HB_DH_META_UNIT = null
    endif
    if HB_DH_META_TIMER != null then
        call DestroyTimer(HB_DH_META_TIMER)
        set HB_DH_META_TIMER = null
    endif
endfunction

function HB_DHMeta takes unit u returns nothing
    set HB_DH_META_UNIT = u
    call SetUnitInvulnerable(u, true)
    set HB_DH_META_TIMER = CreateTimer()
    call TimerStart(HB_DH_META_TIMER, 2.0, false, function HB_DHMetaEnd)
endfunction

// ===========================================================================
// 暗影猎手（澄海 3C 6.92）— SH02 / SH15 / SH30
// ===========================================================================
function HB_SHWardExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = 0
    local unit w
    loop
        exitwhen i >= HB_SH_WARD_MAX
        if HB_SH_WARD_TIMER[i] == t then
            set w = HB_SH_WARD_UNIT[i]
            if w != null then
                if GetUnitTypeId(w) != 0 then
                    call KillUnit(w)
                    call RemoveUnit(w)
                endif
            endif
            set HB_SH_WARD_UNIT[i] = null
            set HB_SH_WARD_TIMER[i] = null
            call DestroyTimer(t)
            set w = null
            set t = null
            return
        endif
        set i = i + 1
    endloop
    set t = null
endfunction

function HB_SHWard takes unit caster, location target returns nothing
    local integer lv = GetUnitAbilityLevel(caster, HB_ABIL_SH_WARD)
    local integer count
    local integer utype
    local integer i = 1
    local integer slot
    local unit w
    local timer t
    local location p
    if lv <= 0 then
        set lv = 1
    endif
    if lv == 1 then
        set count = 1
    elseif lv == 2 then
        set count = 2
    elseif lv == 3 then
        set count = 2
    elseif lv == 4 then
        set count = 3
    elseif lv == 5 then
        set count = 3
    elseif lv == 6 then
        set count = 4
    elseif lv == 7 then
        set count = 4
    elseif lv == 8 then
        set count = 5
    elseif lv == 9 then
        set count = 5
    else
        set count = 6
    endif
    if lv <= 2 then
        set utype = HB_UNIT_SH_WARD1
    elseif lv <= 4 then
        set utype = HB_UNIT_SH_WARD2
    elseif lv <= 6 then
        set utype = HB_UNIT_SH_WARD5
    elseif lv <= 8 then
        set utype = HB_UNIT_SH_WARD4
    else
        set utype = HB_UNIT_SH_WARD3
    endif
    loop
        exitwhen i > count
        set p = PolarProjectionBJ(target, 96.0, I2R(i) * 60.0)
        set w = CreateUnitAtLoc(GetOwningPlayer(caster), utype, p, 270.0)
        // Native timed life gives the summoned-unit duration bar. The ward
        // is magic immune, so briefly remove Amim while applying BTLF.
        call UnitRemoveAbility(w, 'Amim')
        call UnitApplyTimedLife(w, 'B646', 36.0)
        call UnitAddAbility(w, 'Amim')
        set slot = 0
        loop
            exitwhen slot >= HB_SH_WARD_MAX or HB_SH_WARD_TIMER[slot] == null
            set slot = slot + 1
        endloop
        if slot < HB_SH_WARD_MAX then
            set t = CreateTimer()
            set HB_SH_WARD_UNIT[slot] = w
            set HB_SH_WARD_TIMER[slot] = t
            call TimerStart(t, 37.0, false, function HB_SHWardExpire)
            set t = null
        endif
        set w = null
        call RemoveLocation(p)
        set i = i + 1
    endloop
    call RemoveLocation(target)
    set p = null
endfunction

function HB_SHHexAoe takes unit caster, unit target returns nothing
    local location t = GetUnitLoc(target)
    local group g = CreateGroup()
    local unit u
    local unit d
    call GroupEnumUnitsInRangeOfLoc(g, t, 500.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if u != target and IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_SH_DUMMY, t, 0.0)
            call SetUnitAbilityLevel(d, HB_ABIL_SH_HEX_DUMMY, GetUnitAbilityLevel(caster, HB_ABIL_SH_HEX))
            call IssueTargetOrderById(d, 852502, u)
            call UnitApplyTimedLife(d, 'BTLF', 2.0)
        endif
    endloop
    call DestroyGroup(g)
    call RemoveLocation(t)
    set u = null
    set d = null
    set g = null
endfunction

function HB_SHVoodooRestore takes nothing returns nothing
    if HB_SH_VOODOO_CASTER != null then
        call SetUnitInvulnerable(HB_SH_VOODOO_CASTER, false)
        set HB_SH_VOODOO_CASTER = null
    endif
    if HB_SH_VOODOO_TIMER != null then
        call DestroyTimer(HB_SH_VOODOO_TIMER)
        set HB_SH_VOODOO_TIMER = null
    endif
endfunction

function HB_SHVoodoo takes unit caster returns nothing
    local location c = GetUnitLoc(caster)
    local location p
    local integer i = 1
    set HB_SH_VOODOO_CASTER = caster
    call SetUnitInvulnerable(caster, true)
    call UnitAddType(caster, UNIT_TYPE_SAPPER)
    loop
        exitwhen i > 12
        set p = PolarProjectionBJ(c, 150.0, I2R(i) * 30.0)
        set HB_SH_SPIRIT[i] = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_SH_SPIRIT, p, I2R(i) * 30.0)
        call RemoveLocation(p)
        set i = i + 1
    endloop
    call RemoveLocation(c)
    if HB_SH_VOODOO_TIMER != null then
        call DestroyTimer(HB_SH_VOODOO_TIMER)
    endif
    set HB_SH_VOODOO_TIMER = CreateTimer()
    call TimerStart(HB_SH_VOODOO_TIMER, 3.0, false, function HB_SHVoodooRestore)
endfunction

function HB_SHVoodooEnd takes unit caster returns nothing
    local integer i = 1
    call SetUnitInvulnerable(caster, false)
    call UnitRemoveType(caster, UNIT_TYPE_SAPPER)
    set HB_SH_VOODOO_CASTER = null
    if HB_SH_VOODOO_TIMER != null then
        call DestroyTimer(HB_SH_VOODOO_TIMER)
        set HB_SH_VOODOO_TIMER = null
    endif
    loop
        exitwhen i > 12
        if HB_SH_SPIRIT[i] != null then
            call RemoveUnit(HB_SH_SPIRIT[i])
            set HB_SH_SPIRIT[i] = null
        endif
        set i = i + 1
    endloop
endfunction

function HB_SHAncestorInvulnEnd takes nothing returns nothing
    if HB_SH_ANCESTOR_CASTER != null then
        call SetUnitInvulnerable(HB_SH_ANCESTOR_CASTER, false)
    endif
    if HB_SH_ANCESTOR_INVULN_TIMER != null then
        call DestroyTimer(HB_SH_ANCESTOR_INVULN_TIMER)
        set HB_SH_ANCESTOR_INVULN_TIMER = null
    endif
endfunction

function HB_SHAncestorDance takes nothing returns nothing
    local location p
    local integer i
    loop
        exitwhen HB_SH_EJ == 1
        set i = 1
        loop
            exitwhen i > 5
            call SetUnitLifePercentBJ(HB_SH_MI[i], 50.0)
            call IssueTargetOrder(HB_SH_MI[i + 10], "chainlightning", HB_SH_MI[i])
            call IssueTargetOrder(HB_SH_MI[i + 5], "healingwave", HB_SH_MI[i])
            set i = i + 1
        endloop
        call TriggerSleepAction(1.0)
        if HB_SH_EJ == 0 then
            set p = GetUnitLoc(HB_SH_MI[3])
            call IssuePointOrderLoc(HB_SH_MI[1], "move", p)
            call RemoveLocation(p)
            set p = GetUnitLoc(HB_SH_MI[5])
            call IssuePointOrderLoc(HB_SH_MI[3], "move", p)
            call RemoveLocation(p)
            set p = GetUnitLoc(HB_SH_MI[2])
            call IssuePointOrderLoc(HB_SH_MI[5], "move", p)
            call RemoveLocation(p)
            set p = GetUnitLoc(HB_SH_MI[4])
            call IssuePointOrderLoc(HB_SH_MI[2], "move", p)
            call RemoveLocation(p)
            set p = GetUnitLoc(HB_SH_MI[1])
            call IssuePointOrderLoc(HB_SH_MI[4], "move", p)
            call RemoveLocation(p)
        endif
        call TriggerSleepAction(1.33)
    endloop
    set i = 1
    loop
        exitwhen i > 15
        if HB_SH_MI[i] != null then
            call RemoveUnit(HB_SH_MI[i])
            set HB_SH_MI[i] = null
        endif
        set i = i + 1
    endloop
endfunction

function HB_SHAncestorOrbit takes nothing returns nothing
    local location c
    local location p
    local integer i
    local integer k
    loop
        exitwhen HB_SH_EJ == 1
        set c = GetUnitLoc(HB_SH_ANCESTOR_CASTER)
        set i = 1
        loop
            exitwhen i > 49
            call SetUnitFlyHeight(HB_SH_MJ[i], GetUnitFlyHeight(HB_SH_MJ[i]) + 10.0, 100.0)
            set p = PolarProjectionBJ(c, 300.0, I2R(i) * 20.0 + 20.0)
            call IssuePointOrderLoc(HB_SH_MJ[i], "move", p)
            call RemoveLocation(p)
            set i = i + 1
        endloop
        call RemoveUnit(HB_SH_MJ[50])
        call RemoveLocation(c)
        call TriggerSleepAction(0.1)
        if HB_SH_EJ == 0 and HB_SH_ANCESTOR_CASTER != null then
            set k = 50
            loop
                exitwhen k == 1
                set HB_SH_MJ[k] = HB_SH_MJ[k - 1]
                set k = k - 1
            endloop
            set c = GetUnitLoc(HB_SH_ANCESTOR_CASTER)
            set p = PolarProjectionBJ(c, 300.0, 0.0)
            set HB_SH_MJ[1] = CreateUnitAtLoc(GetOwningPlayer(HB_SH_ANCESTOR_CASTER), HB_UNIT_SH_ORB, p, 0.0)
            call UnitApplyTimedLife(HB_SH_MJ[1], 'BTLF', 30.0)
            call RemoveLocation(p)
            call RemoveLocation(c)
        endif
    endloop
    set i = 1
    loop
        exitwhen i > 50
        if HB_SH_MJ[i] != null then
            call RemoveUnit(HB_SH_MJ[i])
            set HB_SH_MJ[i] = null
        endif
        set i = i + 1
    endloop
endfunction

function HB_SHAncestor takes unit caster returns nothing
    local location c
    local location p
    local integer i
    set HB_SH_ANCESTOR_CASTER = caster
    set HB_SH_EJ = 0
    call SetUnitInvulnerable(caster, true)
    call UnitAddType(caster, UNIT_TYPE_SAPPER)
    call SetUnitFlyHeight(caster, 300.0, 100.0)
    set c = GetUnitLoc(caster)
    set i = 1
    loop
        exitwhen i > 5
        set p = PolarProjectionBJ(c, 350.0, I2R(i) * 72.0)
        set HB_SH_MI[i] = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_SH_SPIRIT2, p, 0.0)
        call UnitApplyTimedLife(HB_SH_MI[i], 'BTLF', 30.0)
        call UnitRemoveAbility(HB_SH_MI[i], 'Aloc')
        call RemoveLocation(p)
        set i = i + 1
    endloop
    set i = 6
    loop
        exitwhen i > 15
        set HB_SH_MI[i] = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_SH_SPIRIT2, c, 0.0)
        call UnitApplyTimedLife(HB_SH_MI[i], 'BTLF', 30.0)
        call SetUnitFlyHeight(HB_SH_MI[i], 300.0, 100.0)
        call ShowUnitHide(HB_SH_MI[i])
        set i = i + 1
    endloop
    set i = 1
    loop
        exitwhen i > 50
        set p = PolarProjectionBJ(c, 300.0, I2R(i) * 20.0)
        set HB_SH_MJ[i] = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_SH_ORB, p, 0.0)
        call UnitApplyTimedLife(HB_SH_MJ[i], 'BTLF', 30.0)
        call SetUnitFlyHeight(HB_SH_MJ[i], I2R(i) * 10.0, 0.0)
        call RemoveLocation(p)
        set i = i + 1
    endloop
    call RemoveLocation(c)
    call EnableTrigger(HB_SH_MK)
    call EnableTrigger(HB_SH_ML)
    call TriggerExecute(HB_SH_MK)
    call TriggerExecute(HB_SH_ML)
    if HB_SH_ANCESTOR_INVULN_TIMER != null then
        call DestroyTimer(HB_SH_ANCESTOR_INVULN_TIMER)
    endif
    set HB_SH_ANCESTOR_INVULN_TIMER = CreateTimer()
    call TimerStart(HB_SH_ANCESTOR_INVULN_TIMER, 3.0, false, function HB_SHAncestorInvulnEnd)
endfunction

function HB_SHAncestorEnd takes unit caster returns nothing
    local integer i
    set HB_SH_EJ = 1
    call UnitRemoveType(caster, UNIT_TYPE_SAPPER)
    call SetUnitInvulnerable(caster, false)
    call SetUnitFlyHeight(caster, 0.0, 0.0)
    if HB_SH_ANCESTOR_INVULN_TIMER != null then
        call DestroyTimer(HB_SH_ANCESTOR_INVULN_TIMER)
        set HB_SH_ANCESTOR_INVULN_TIMER = null
    endif
    set i = 1
    loop
        exitwhen i > 15
        if HB_SH_MI[i] != null then
            call RemoveUnit(HB_SH_MI[i])
            set HB_SH_MI[i] = null
        endif
        set i = i + 1
    endloop
    set i = 1
    loop
        exitwhen i > 50
        if HB_SH_MJ[i] != null then
            call RemoveUnit(HB_SH_MJ[i])
            set HB_SH_MJ[i] = null
        endif
        set i = i + 1
    endloop
    set HB_SH_ANCESTOR_CASTER = null
endfunction

// ===========================================================================
// 剑圣（澄海 3C 6.92）— 闪电冲刺 / 闪电剑刃的触发器补全
// ===========================================================================
function HB_BMDash takes unit caster, location target returns nothing
    local location start = GetUnitLoc(caster)
    local location cur
    local location p
    local real angle = AngleBetweenPoints(start, target)
    local real dist
    local integer i
    local group g = CreateGroup()
    local unit u

    call PauseUnit(caster, true)
    call SetUnitPathing(caster, false)
    call SetUnitTimeScale(caster, 1.5)
    call SetUnitAnimation(caster, "slam")
    call SetUnitVertexColorBJ(caster, 100.0, 100.0, 100.0, 50.0)
    call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Orc\\LightningBolt\\LightningBoltMissile.mdl", start))

    // 3C 的冲刺是瞬移式位移。不要用 TriggerSleepAction 分段移动：
    // 该函数在 1.24 下会被量化到约 0.1 秒，10 段就变成明显慢动作。
    set dist = DistanceBetweenPoints(start, target)
    call SetUnitPositionLocFacingBJ(caster, target, angle)
    set cur = GetUnitLoc(caster)
    set i = 1
    loop
        exitwhen i > 5
        set p = PolarProjectionBJ(start, dist * I2R(i) / 5.0, angle)
        call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Orc\\LightningBolt\\LightningBoltMissile.mdl", p))
        call RemoveLocation(p)
        set i = i + 1
    endloop

    if IsUnitAliveBJ(caster) then
        call GroupEnumUnitsInRangeOfLoc(g, cur, 300.0, null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)
            if u != caster and IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
                call UnitDamageTarget(caster, u, 1500.0, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_UNKNOWN, WEAPON_TYPE_WHOKNOWS)
            endif
        endloop
        call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", cur))
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitVertexColorBJ(caster, 100.0, 100.0, 100.0, 0.0)
        call ResetUnitAnimation(caster)
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
    endif

    call DestroyGroup(g)
    call RemoveLocation(cur)
    call RemoveLocation(start)
    call RemoveLocation(target)
    set u = null
    set g = null
    set p = null
endfunction

// 3C 疾风跳砍：攻击目标时，如果目标距离在 200~800 内，先用跳砍影子
// 冲进目标，再恢复普通攻击。状态放在英雄系统自己的局部状态里，避免
// 复制 3C 原图的全局变量。
function HB_BMJumpCleanup takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i > HB_BM_JUMP_SHADOW_COUNT
        if HB_BM_JUMP_SHADOWS[i] != null and GetUnitTypeId(HB_BM_JUMP_SHADOWS[i]) != 0 then
            call RemoveUnit(HB_BM_JUMP_SHADOWS[i])
        endif
        set HB_BM_JUMP_SHADOWS[i] = null
        set i = i + 1
    endloop
    if HB_BM_JUMP_TIMER != null then
        call PauseTimer(HB_BM_JUMP_TIMER)
        call DestroyTimer(HB_BM_JUMP_TIMER)
        set HB_BM_JUMP_TIMER = null
    endif
    if HB_BM_JUMP_START != null then
        call RemoveLocation(HB_BM_JUMP_START)
        set HB_BM_JUMP_START = null
    endif
    set HB_BM_JUMP_CASTER = null
    set HB_BM_JUMP_TARGET = null
    set HB_BM_JUMP_TICKS = 0
    set HB_BM_JUMP_SHADOW_COUNT = 0
    set HB_BM_JUMPING = false
endfunction

function HB_BMJumpFinish takes boolean success returns nothing
    local unit caster = HB_BM_JUMP_CASTER
    local unit target = HB_BM_JUMP_TARGET
    local integer windLevel
    local texttag tt
    if caster != null and GetUnitTypeId(caster) != 0 then
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitInvulnerable(caster, false)
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
        call ResetUnitAnimation(caster)
        call UnitRemoveBuffBJ('BOwk', caster)
        if success and target != null and IsUnitAliveBJ(target) and GetUnitTypeId(target) != 0 then
            set windLevel = GetUnitAbilityLevel(caster, HB_ABIL_BM_WIND)
            set tt = CreateTextTag()
            call SetTextTagText(tt, I2S(windLevel * 120) + "!", 0.024)
            call SetTextTagPosUnit(tt, target, 100.0)
            call SetTextTagColor(tt, 255, 0, 0, 255)
            call SetTextTagVelocity(tt, 0.0, 0.03)
            call SetTextTagPermanent(tt, false)
            call SetTextTagLifespan(tt, 1.5)
            call SetTextTagFadepoint(tt, 1.0)
            set tt = null
            call UnitDamageTarget(caster, target, 120.0 * I2R(windLevel), true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            call IssueTargetOrderById(caster, 851983, target)
        endif
    endif
    call HB_BMJumpCleanup()
    set caster = null
    set target = null
endfunction

function HB_BMShowBonusText takes unit target, integer amount returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt, "附伤 " + I2S(amount) + "!", 0.024)
    call SetTextTagPosUnit(tt, target, 100.0)
    call SetTextTagColor(tt, 255, 0, 0, 255)
    call SetTextTagVelocity(tt, 0.0, 0.03)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.5)
    call SetTextTagFadepoint(tt, 1.0)
    set tt = null
endfunction

function HB_BMJumpAttack takes nothing returns nothing
    if HB_BM_FINISH_CASTER != null and GetAttacker() == HB_BM_FINISH_CASTER and GetTriggerUnit() == HB_BM_FINISH_TARGET then
        set HB_BM_FINISH_HIT = true
    endif
endfunction

function HB_BMJumpFallback takes nothing returns nothing
    local unit caster = HB_BM_FINISH_CASTER
    local unit target = HB_BM_FINISH_TARGET
    local integer windLevel
    if not HB_BM_FINISH_HIT and caster != null and target != null and GetUnitTypeId(caster) != 0 and GetUnitTypeId(target) != 0 and IsUnitAliveBJ(target) then
        call UnitRemoveBuffBJ('BOwk', caster)
        set windLevel = GetUnitAbilityLevel(caster, HB_ABIL_BM_WIND)
        call HB_BMShowBonusText(target, windLevel * 120)
        call UnitDamageTarget(caster, target, 120.0 * I2R(windLevel), true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    endif
    if HB_BM_FINISH_TIMER != null then
        call PauseTimer(HB_BM_FINISH_TIMER)
        call DestroyTimer(HB_BM_FINISH_TIMER)
        set HB_BM_FINISH_TIMER = null
    endif
    set HB_BM_FINISH_CASTER = null
    set HB_BM_FINISH_TARGET = null
    set HB_BM_FINISH_HIT = false
    set caster = null
    set target = null
endfunction

function HB_BMJumpFinishNative takes boolean success returns nothing
    local unit caster = HB_BM_JUMP_CASTER
    local unit target = HB_BM_JUMP_TARGET
    if caster != null and GetUnitTypeId(caster) != 0 then
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitInvulnerable(caster, false)
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
        call ResetUnitAnimation(caster)
        if success and target != null and IsUnitAliveBJ(target) and GetUnitTypeId(target) != 0 then
            set HB_BM_FINISH_CASTER = caster
            set HB_BM_FINISH_TARGET = target
            set HB_BM_FINISH_HIT = false
            if HB_BM_FINISH_TIMER != null then
                call PauseTimer(HB_BM_FINISH_TIMER)
                call DestroyTimer(HB_BM_FINISH_TIMER)
            endif
            set HB_BM_FINISH_TIMER = CreateTimer()
            call TimerStart(HB_BM_FINISH_TIMER, 0.8, false, function HB_BMJumpFallback)
            call IssueTargetOrderById(caster, 851983, target)
        endif
    endif
    call HB_BMJumpCleanup()
    set caster = null
    set target = null
endfunction

function HB_BMJumpFinishGreen takes boolean success returns nothing
    local unit caster = HB_BM_JUMP_CASTER
    local unit target = HB_BM_JUMP_TARGET
    if caster != null and GetUnitTypeId(caster) != 0 then
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitInvulnerable(caster, false)
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
        call ResetUnitAnimation(caster)
        if success and target != null and IsUnitAliveBJ(target) and GetUnitTypeId(target) != 0 then
            call IssueTargetOrderById(caster, 851983, target)
        endif
    endif
    call HB_BMJumpCleanup()
    set caster = null
    set target = null
endfunction

function HB_BMGreenDamage takes nothing returns nothing
    local unit source = GetEventDamageSource()
    if source == HB_BM_GREEN_CASTER and GetEventDamage() > 0.0 then
        call UnitRemoveAbility(HB_BM_GREEN_CASTER, HB_ABIL_BM_GREEN)
        if HB_BM_GREEN_TRIGGER != null then
            call DisableTrigger(HB_BM_GREEN_TRIGGER)
            call DestroyTrigger(HB_BM_GREEN_TRIGGER)
            set HB_BM_GREEN_TRIGGER = null
        endif
        set HB_BM_GREEN_CASTER = null
    endif
    set source = null
endfunction

function HB_BMGreenRemove takes nothing returns nothing
    if HB_BM_GREEN_CASTER != null and GetUnitTypeId(HB_BM_GREEN_CASTER) != 0 then
        call UnitRemoveAbility(HB_BM_GREEN_CASTER, HB_ABIL_BM_GREEN)
    endif
    if HB_BM_GREEN_TIMER != null then
        call PauseTimer(HB_BM_GREEN_TIMER)
        call DestroyTimer(HB_BM_GREEN_TIMER)
        set HB_BM_GREEN_TIMER = null
    endif
    if HB_BM_GREEN_TRIGGER != null then
        call DisableTrigger(HB_BM_GREEN_TRIGGER)
        call DestroyTrigger(HB_BM_GREEN_TRIGGER)
        set HB_BM_GREEN_TRIGGER = null
    endif
    set HB_BM_GREEN_CASTER = null
endfunction

function HB_BMGreenAttack takes nothing returns nothing
    if HB_BM_GREEN_CASTER != null and GetAttacker() == HB_BM_GREEN_CASTER then
        if HB_BM_GREEN_TIMER != null then
            call PauseTimer(HB_BM_GREEN_TIMER)
            call DestroyTimer(HB_BM_GREEN_TIMER)
        endif
        set HB_BM_GREEN_TIMER = CreateTimer()
        call TimerStart(HB_BM_GREEN_TIMER, 0.5, false, function HB_BMGreenRemove)
    endif
endfunction

function HB_BMGreenStart takes unit caster returns nothing
    if caster == null or GetUnitTypeId(caster) == 0 then
        return
    endif
    if HB_BM_GREEN_TRIGGER != null then
        call DisableTrigger(HB_BM_GREEN_TRIGGER)
        call DestroyTrigger(HB_BM_GREEN_TRIGGER)
        set HB_BM_GREEN_TRIGGER = null
    endif
    if HB_BM_GREEN_TIMER != null then
        call PauseTimer(HB_BM_GREEN_TIMER)
        call DestroyTimer(HB_BM_GREEN_TIMER)
        set HB_BM_GREEN_TIMER = null
    endif
    if GetUnitAbilityLevel(caster, HB_ABIL_BM_GREEN) > 0 then
        call UnitRemoveAbility(caster, HB_ABIL_BM_GREEN)
    endif
    call UnitAddAbility(caster, HB_ABIL_BM_GREEN)
    call SetUnitAbilityLevel(caster, HB_ABIL_BM_GREEN, GetUnitAbilityLevel(caster, HB_ABIL_BM_WIND))
    set HB_BM_GREEN_CASTER = caster
    set HB_BM_GREEN_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(HB_BM_GREEN_TRIGGER, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(HB_BM_GREEN_TRIGGER, function HB_BMGreenAttack)
endfunction

function HB_BMJumpTick takes nothing returns nothing
    local integer tick = HB_BM_JUMP_TICKS + 1
    local unit caster = HB_BM_JUMP_CASTER
    local unit target = HB_BM_JUMP_TARGET
    local location tl
    local location cl
    local location p
    local real dist
    local real angle
    local real newdist

    if caster == null or target == null or GetUnitTypeId(caster) == 0 or GetUnitTypeId(target) == 0 or not IsUnitAliveBJ(caster) or not IsUnitAliveBJ(target) then
        call HB_BMJumpFinish(false)
        return
    endif
    set HB_BM_JUMP_TICKS = tick
    set tl = GetUnitLoc(target)
    set cl = GetUnitLoc(caster)
    set dist = DistanceBetweenPoints(cl, tl)
    set angle = AngleBetweenPoints(cl, tl)

    if dist > 800.0 or tick >= 26 then
        call RemoveLocation(tl)
        call RemoveLocation(cl)
        call HB_BMJumpFinish(dist <= 200.0)
        return
    endif
    if dist <= 130.0 then
        call RemoveLocation(tl)
        call RemoveLocation(cl)
        call HB_BMJumpFinish(true)
        return
    endif

    set newdist = dist - dist / I2R(27 - tick)
    if newdist < 70.0 then
        set newdist = 70.0
    endif
    set p = PolarProjectionBJ(tl, newdist, angle + 180.0)
    call SetUnitPositionLocFacingBJ(caster, p, angle)

    call RemoveLocation(tl)
    call RemoveLocation(cl)
    call RemoveLocation(p)
    set p = null
    set tl = null
    set cl = null
endfunction

function HB_BMJumpStart takes unit caster, unit target returns nothing
    if caster == null or target == null or HB_BM_JUMPING then
        return
    endif
    set HB_BM_JUMP_CASTER = caster
    set HB_BM_JUMP_TARGET = target
    set HB_BM_JUMP_START = GetUnitLoc(caster)
    set HB_BM_JUMP_TICKS = 0
    set HB_BM_JUMP_SHADOW_COUNT = 0
    set HB_BM_JUMPING = true

    call IssueImmediateOrderById(caster, 851972)
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitPathing(caster, false)
    call SetUnitAnimation(caster, "attack slam")
    call SetUnitTimeScale(caster, 0.75)
    set HB_BM_JUMP_TIMER = CreateTimer()
    call TimerStart(HB_BM_JUMP_TIMER, 0.05, true, function HB_BMJumpTick)
endfunction

function HB_OnBMOrder takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit target = GetOrderTargetUnit()
    local location a
    local location b
    local real dist
    if u == null or target == null or HB_BM_JUMPING then
        set u = null
        set target = null
        return
    endif
    if HB_FindHeroByUnit(u) != 3 or not IsUnitEnemy(target, GetOwningPlayer(u)) then
        set u = null
        set target = null
        return
    endif
    if GetIssuedOrderIdBJ() != String2OrderIdBJ("smart") and GetIssuedOrderIdBJ() != String2OrderIdBJ("attack") then
        set u = null
        set target = null
        return
    endif
    if not UnitHasBuffBJ(u, 'BOwk') then
        set u = null
        set target = null
        return
    endif
    set a = GetUnitLoc(u)
    set b = GetUnitLoc(target)
    set dist = DistanceBetweenPoints(a, b)
    call RemoveLocation(a)
    call RemoveLocation(b)
    if dist > 200.0 and dist <= 800.0 then
        call HB_BMJumpStart(u, target)
    endif
    set u = null
    set target = null
endfunction

function HB_BMMirror takes unit caster returns nothing
    local group g = CreateGroup()
    local unit u
    local unit d
    local location p
    call TriggerSleepAction(0.7)
    if caster == null or GetUnitTypeId(caster) == 0 or not IsUnitAliveBJ(caster) then
        call DestroyGroup(g)
        set g = null
        return
    endif
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if UnitHasBuffBJ(u, 'BOmi') then
            set p = GetUnitLoc(u)
            set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_BM_MIRROR, p, GetUnitFacing(u))
            call UnitApplyTimedLife(d, 'BTLF', 1.0)
            call IssueTargetOrderById(d, 852274, u)
            call RemoveLocation(p)
            set d = null
            set p = null
        endif
    endloop
    set p = GetUnitLoc(caster)
    set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_BM_MIRROR, p, 0.0)
    call UnitApplyTimedLife(d, 'BTLF', 1.0)
    call IssueTargetOrderById(d, 852274, caster)
    call RemoveLocation(p)
    call DestroyGroup(g)
    set u = null
    set d = null
    set p = null
    set g = null
endfunction

function HB_BMBlades takes unit caster returns nothing
    local location c
    local location p
    local unit d
    local timer t = CreateTimer()
    local integer tick = 0
    local integer i
    local boolean was_immune = IsUnitType(caster, UNIT_TYPE_MAGIC_IMMUNE)

    if not was_immune then
        call UnitAddType(caster, UNIT_TYPE_MAGIC_IMMUNE)
    endif
    // A0B4 is a custom ability based on AOww. Some 1.24 maps do not replay
    // the model's bladestorm sequence for a copied custom ability, so drive
    // the model animation explicitly while the storm is active.
    call SetUnitAnimation(caster, "Attack Walk Stand Spin")
    call TimerStart(t, 10.0, false, null)
    loop
        exitwhen TimerGetRemaining(t) <= 0.0 or not IsUnitAliveBJ(caster)
        if tick > 0 and ModuloInteger(tick, 2) == 0 then
            call SetUnitAnimation(caster, "Attack Walk Stand Spin")
        endif
        set c = GetUnitLoc(caster)
        set i = 1
        loop
            exitwhen i > 5
            set p = PolarProjectionBJ(c, 100.0, 14.4 * I2R(tick) + 72.0 * I2R(i))
            set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_BM_BLADE, c, 0.0)
            call SetUnitAbilityLevel(d, HB_ABIL_BM_BLADE_DUMMY, 1)
            call IssuePointOrderByIdLoc(d, 852218, p)
            call UnitApplyTimedLife(d, 'BTLF', 0.35)
            call RemoveLocation(p)
            set i = i + 1
        endloop
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\ForkedLightning\\ForkedLightningTarget.mdl", caster, "weapon"))
        call RemoveLocation(c)
        set tick = tick + 1
        call TriggerSleepAction(0.2)
    endloop

    call PauseTimer(t)
    call DestroyTimer(t)
    if not was_immune then
        call UnitRemoveType(caster, UNIT_TYPE_MAGIC_IMMUNE)
    endif
    call ResetUnitAnimation(caster)
    set d = null
    set t = null
    set p = null
    set c = null
endfunction

// ===========================================================================
// 火魔（澄海 3C 6.92，Nfir）
// ===========================================================================
function HB_FLFindRopeSlot takes unit u returns integer
    local integer i = 0
    loop
        exitwhen i >= HB_FL_MAX
        if HB_FL_ROPE_ACTIVE[i] and HB_FL_ROPE_CASTER[i] == u then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_FLFreeRopeSlot takes nothing returns integer
    local integer i = 0
    loop
        exitwhen i >= HB_FL_MAX
        if not HB_FL_ROPE_ACTIVE[i] then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_FLFindVolcanoSlot takes unit u returns integer
    local integer i = 0
    loop
        exitwhen i >= HB_FL_VOL_MAX
        if HB_FL_VOL_ACTIVE[i] and HB_FL_VOL_CASTER[i] == u then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_FLFreeVolcanoSlot takes nothing returns integer
    local integer i = 0
    loop
        exitwhen i >= HB_FL_VOL_MAX
        if not HB_FL_VOL_ACTIVE[i] then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function HB_FLFlameArmor takes unit caster returns nothing
    local location p = GetUnitLoc(caster)
    call CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_FL_ARMOR, p, 0.0)
    call RemoveLocation(p)
    set p = null
endfunction

function HB_FLSoulBurn takes unit caster, unit target returns nothing
    local location p
    local group g
    local unit u
    local unit d
    if target == null then
        return
    endif
    set p = GetUnitLoc(target)
    set g = CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(g, p, 500.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if u != target and IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_FL_SOUL, p, 0.0)
            call IssueTargetOrderById(d, 852668, u)
        endif
    endloop
    call DestroyGroup(g)
    call RemoveLocation(p)
    set u = null
    set d = null
    set g = null
    set p = null
endfunction

function HB_FLRopeCanGrab takes unit owner, unit u returns boolean
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    if not IsUnitAliveBJ(u) or GetUnitState(u, UNIT_STATE_LIFE) < 0.5 then
        return false
    endif
    if not IsUnitEnemy(u, GetOwningPlayer(owner)) or IsUnitType(u, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if GetUnitUserData(u) == 280 or GetUnitUserData(u) == 290 or GetUnitUserData(u) == 300 then
        return false
    endif
    if GetUnitTypeId(u) == 'even' then
        return false
    endif
    if GetUnitAbilityLevel(u, 'Aloc') > 0 or GetUnitAbilityLevel(u, 'Amgr') > 0 then
        return false
    endif
    if UnitHasBuffBJ(u, 'Bcy2') or UnitHasBuffBJ(u, 'Btsp') or UnitHasBuffBJ(u, 'BOvd') then
        return false
    endif
    if UnitHasBuffBJ(u, 'BHds') or UnitHasBuffBJ(u, 'Bvsf') or UnitHasBuffBJ(u, 'BUan') then
        return false
    endif
    if UnitHasBuffBJ(u, 'Bmlt') or UnitHasBuffBJ(u, 'Bmlc') then
        return false
    endif
    return true
endfunction

function HB_FLRopeClearInvalid takes integer slot, integer i returns nothing
    local integer idx = slot * 6 + i
    local unit t = HB_FL_ROPE_TARGET[idx]
    if t != null and (GetUnitTypeId(t) == 0 or not IsUnitAliveBJ(t) or GetUnitState(t, UNIT_STATE_LIFE) < 0.5 or GetUnitUserData(t) != 280 or not UnitHasBuffBJ(t, 'Bmlt') or UnitHasBuffBJ(t, 'Bcy2') or UnitHasBuffBJ(t, 'Btsp') or UnitHasBuffBJ(t, 'BOvd') or UnitHasBuffBJ(t, 'BHds') or UnitHasBuffBJ(t, 'Bvsf')) then
        if GetUnitTypeId(t) != 0 then
            call SetUnitFlyHeight(t, GetUnitDefaultFlyHeight(t), 500.0)
            if GetUnitUserData(t) == 280 then
                call SetUnitUserData(t, 0)
            endif
        endif
        set HB_FL_ROPE_TARGET[idx] = null
    endif
    set t = null
endfunction

function HB_FLRopePick takes integer slot, integer i returns nothing
    local integer idx = slot * 6 + i
    local unit caster = HB_FL_ROPE_CASTER[slot]
    local location center = HB_FL_ROPE_CENTER[slot]
    local unit visual = HB_FL_ROPE_VISUAL[idx]
    local group g
    local unit u
    local unit heroPick = null
    local unit normalPick = null
    if caster == null or center == null or visual == null then
        return
    endif
    set g = CreateGroup()
    call GroupEnumUnitsInRangeOfLoc(g, center, 750.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if HB_FLRopeCanGrab(caster, u) then
            if heroPick == null and IsUnitType(u, UNIT_TYPE_HERO) then
                set heroPick = u
            endif
            if normalPick == null then
                set normalPick = u
            endif
        endif
    endloop
    if heroPick != null then
        set u = heroPick
    else
        set u = normalPick
    endif
    if u != null then
        call IssueTargetOrder(visual, "magicleash", u)
        call UnitAddAbility(u, HB_ABIL_FL_CLEAR)
        call UnitRemoveAbility(u, HB_ABIL_FL_CLEAR)
        call SetUnitFlyHeight(u, 350.0, 850.0)
        call SetUnitUserData(u, 280)
        set HB_FL_ROPE_TARGET[idx] = u
    endif
    call DestroyGroup(g)
    set u = null
    set g = null
    set visual = null
    set caster = null
    set center = null
    set heroPick = null
    set normalPick = null
endfunction

function HB_FLRopeFinish takes integer slot returns nothing
    local integer i = 1
    local integer idx
    local unit caster = HB_FL_ROPE_CASTER[slot]
    local unit visual
    local unit target
    loop
        exitwhen i > 6
        set idx = slot * 6 + i
        set visual = HB_FL_ROPE_VISUAL[idx]
        set target = HB_FL_ROPE_TARGET[idx]
        if visual != null and GetUnitTypeId(visual) != 0 then
            call SetUnitFlyHeight(visual, 0.0, 0.0)
            call IssueImmediateOrderById(visual, 851972)
        endif
        if target != null and GetUnitTypeId(target) != 0 then
            call SetUnitFlyHeight(target, GetUnitDefaultFlyHeight(target), 500.0)
            if visual != null and GetUnitTypeId(visual) != 0 then
                call IssueTargetOrderById(visual, 852668, target)
            endif
            if GetUnitUserData(target) != 300 and GetUnitUserData(target) != 290 then
                call SetUnitUserData(target, 0)
            endif
        endif
        set HB_FL_ROPE_TARGET[idx] = null
        if visual != null and GetUnitTypeId(visual) != 0 then
            call RemoveUnit(visual)
        endif
        set HB_FL_ROPE_VISUAL[idx] = null
        set visual = null
        set target = null
        set i = i + 1
    endloop
    if caster != null and GetUnitTypeId(caster) != 0 then
        call UnitRemoveType(caster, UNIT_TYPE_SAPPER)
        call SetUnitInvulnerable(caster, false)
        call SetUnitFlyHeight(caster, GetUnitDefaultFlyHeight(caster), 0.0)
        call UnitRemoveAbility(caster, 'AItj')
    endif
    if HB_FL_ROPE_TERRAIN[slot] != null then
        call TerrainDeformationStopBJ(HB_FL_ROPE_TERRAIN[slot], 1.5)
        set HB_FL_ROPE_TERRAIN[slot] = null
    endif
    if HB_FL_ROPE_TIMER[slot] != null then
        call PauseTimer(HB_FL_ROPE_TIMER[slot])
        call DestroyTimer(HB_FL_ROPE_TIMER[slot])
        set HB_FL_ROPE_TIMER[slot] = null
    endif
    if HB_FL_ROPE_GUARD_TIMER[slot] != null then
        call PauseTimer(HB_FL_ROPE_GUARD_TIMER[slot])
        call DestroyTimer(HB_FL_ROPE_GUARD_TIMER[slot])
        set HB_FL_ROPE_GUARD_TIMER[slot] = null
    endif
    if HB_FL_ROPE_CENTER[slot] != null then
        call RemoveLocation(HB_FL_ROPE_CENTER[slot])
        set HB_FL_ROPE_CENTER[slot] = null
    endif
    set HB_FL_ROPE_CASTER[slot] = null
    set HB_FL_ROPE_ACTIVE[slot] = false
    set HB_FL_ROPE_ENDING[slot] = false
    set HB_FL_ROPE_WAS_SAPPER[slot] = false
    set HB_FL_ROPE_ANGLE[slot] = 0.0
    set HB_FL_ROPE_TICK[slot] = 0
    set caster = null
endfunction

function HB_FLRopeTick takes nothing returns nothing
    local timer expired = GetExpiredTimer()
    local integer slot = -1
    local integer i = 0
    local integer idx
    local unit caster
    local location center
    local unit target
    local real x
    local real y
    loop
        exitwhen i >= HB_FL_MAX
        if HB_FL_ROPE_ACTIVE[i] and HB_FL_ROPE_TIMER[i] == expired then
            set slot = i
            set i = HB_FL_MAX
        else
            set i = i + 1
        endif
    endloop
    set expired = null
    if slot < 0 then
        return
    endif
    set caster = HB_FL_ROPE_CASTER[slot]
    if caster == null or GetUnitTypeId(caster) == 0 or not IsUnitAliveBJ(caster) then
        call HB_FLRopeFinish(slot)
        set caster = null
        return
    endif
    if HB_FL_ROPE_ENDING[slot] then
        call HB_FLRopeFinish(slot)
        set caster = null
        return
    endif
    set center = HB_FL_ROPE_CENTER[slot]
    if center == null then
        call HB_FLRopeFinish(slot)
        set caster = null
        return
    endif
    set HB_FL_ROPE_TICK[slot] = HB_FL_ROPE_TICK[slot] + 1
    if HB_FL_ROPE_TICK[slot] >= 7 then
        set HB_FL_ROPE_TICK[slot] = 0
        set i = 1
        loop
            exitwhen i > 6
            call HB_FLRopeClearInvalid(slot, i)
            if HB_FL_ROPE_TARGET[slot * 6 + i] == null then
                call HB_FLRopePick(slot, i)
            endif
            set i = i + 1
        endloop
    endif
    set HB_FL_ROPE_ANGLE[slot] = HB_FL_ROPE_ANGLE[slot] + 3.0
    set i = 1
    loop
        exitwhen i > 6
        set idx = slot * 6 + i
        set target = HB_FL_ROPE_TARGET[idx]
        if target != null and GetUnitTypeId(target) != 0 then
            set x = GetLocationX(center) + 350.0 * CosBJ(HB_FL_ROPE_ANGLE[slot] + 60.0 * I2R(i))
            set y = GetLocationY(center) + 350.0 * SinBJ(HB_FL_ROPE_ANGLE[slot] + 60.0 * I2R(i))
            call SetUnitX(target, x)
            call SetUnitY(target, y)
        endif
        set target = null
        set i = i + 1
    endloop
    set caster = null
    set center = null
endfunction

function HB_FLRopeInvulnEnd takes nothing returns nothing
    local timer expired = GetExpiredTimer()
    local integer i = 0
    loop
        exitwhen i >= HB_FL_MAX
        if HB_FL_ROPE_ACTIVE[i] and HB_FL_ROPE_GUARD_TIMER[i] == expired then
            if HB_FL_ROPE_CASTER[i] != null and GetUnitTypeId(HB_FL_ROPE_CASTER[i]) != 0 then
                call SetUnitInvulnerable(HB_FL_ROPE_CASTER[i], false)
            endif
            set HB_FL_ROPE_GUARD_TIMER[i] = null
            set i = HB_FL_MAX
        else
            set i = i + 1
        endif
    endloop
    call DestroyTimer(expired)
    set expired = null
endfunction

function HB_FLRopeStart takes unit caster returns nothing
    local integer slot
    local integer i = 1
    local location center
    local unit visual
    if caster == null or GetUnitTypeId(caster) == 0 then
        return
    endif
    set slot = HB_FLFindRopeSlot(caster)
    if slot >= 0 then
        call HB_FLRopeFinish(slot)
    endif
    set slot = HB_FLFreeRopeSlot()
    if slot < 0 then
        return
    endif
    set HB_FL_ROPE_ACTIVE[slot] = true
    set HB_FL_ROPE_ENDING[slot] = false
    set HB_FL_ROPE_CASTER[slot] = caster
    set HB_FL_ROPE_CENTER[slot] = GetUnitLoc(caster)
    set HB_FL_ROPE_ANGLE[slot] = 0.0
    set HB_FL_ROPE_TICK[slot] = 0
    set HB_FL_ROPE_WAS_SAPPER[slot] = IsUnitType(caster, UNIT_TYPE_SAPPER)
    set center = HB_FL_ROPE_CENTER[slot]
    call UnitAddType(caster, UNIT_TYPE_SAPPER)
    call SetUnitInvulnerable(caster, true)
    call UnitAddAbility(caster, 'AItj')
    call UnitAddAbility(caster, HB_ABIL_FL_CLEAR)
    call UnitRemoveAbility(caster, HB_ABIL_FL_CLEAR)
    call SetUnitFlyHeight(caster, 350.0, 500.0)
    set HB_FL_ROPE_TERRAIN[slot] = TerrainDeformationRippleBJ(30.0, false, center, 700.0, 700.0, 50.0, 1, 512)
    loop
        exitwhen i > 6
        set visual = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_FL_ROPE, center, 0.0)
        set HB_FL_ROPE_VISUAL[slot * 6 + i] = visual
        call SetUnitFlyHeight(visual, 350.0, 500.0)
        set visual = null
        set i = i + 1
    endloop
    set HB_FL_ROPE_TIMER[slot] = CreateTimer()
    call TimerStart(HB_FL_ROPE_TIMER[slot], 0.04, true, function HB_FLRopeTick)
    set HB_FL_ROPE_GUARD_TIMER[slot] = CreateTimer()
    call TimerStart(HB_FL_ROPE_GUARD_TIMER[slot], 1.2, false, function HB_FLRopeInvulnEnd)
    set center = null
endfunction

function HB_FLRopeEnd takes unit caster returns nothing
    local integer slot = HB_FLFindRopeSlot(caster)
    if slot < 0 then
        return
    endif
    set HB_FL_ROPE_ENDING[slot] = true
    if caster != null and GetUnitTypeId(caster) != 0 then
        call UnitRemoveType(caster, UNIT_TYPE_SAPPER)
        call SetUnitInvulnerable(caster, false)
        call SetUnitFlyHeight(caster, GetUnitDefaultFlyHeight(caster), 0.0)
        call UnitRemoveAbility(caster, 'AItj')
    endif
    if HB_FL_ROPE_TERRAIN[slot] != null then
        call TerrainDeformationStopBJ(HB_FL_ROPE_TERRAIN[slot], 1.5)
        set HB_FL_ROPE_TERRAIN[slot] = null
    endif
endfunction

function HB_FLVolcanoSave takes unit caster, location target returns nothing
    local integer slot = HB_FLFindVolcanoSlot(caster)
    if slot < 0 then
        set slot = HB_FLFreeVolcanoSlot()
    endif
    if slot < 0 or target == null then
        if target != null then
            call RemoveLocation(target)
        endif
        return
    endif
    if HB_FL_VOL_POINT[slot] != null then
        call RemoveLocation(HB_FL_VOL_POINT[slot])
    endif
    set HB_FL_VOL_ACTIVE[slot] = true
    set HB_FL_VOL_CASTER[slot] = caster
    set HB_FL_VOL_POINT[slot] = target
endfunction

function HB_FLVolcanoFinish takes unit caster returns nothing
    local integer slot = HB_FLFindVolcanoSlot(caster)
    local unit d
    local location p
    if slot < 0 then
        return
    endif
    set p = HB_FL_VOL_POINT[slot]
    if p != null then
        set d = CreateUnitAtLoc(GetOwningPlayer(caster), HB_UNIT_FL_VOLCANO, p, 0.0)
        call SetUnitAbilityLevel(d, HB_ABIL_FL_VOLCANO_DUMMY, GetUnitAbilityLevel(caster, HB_ABIL_FL_VOLCANO))
        call IssuePointOrderByIdLoc(d, 852669, p)
        call UnitApplyTimedLife(d, 'BTLF', 40.0)
        call RemoveLocation(p)
    endif
    set HB_FL_VOL_POINT[slot] = null
    set HB_FL_VOL_CASTER[slot] = null
    set HB_FL_VOL_ACTIVE[slot] = false
    set d = null
    set p = null
endfunction

function HB_FLVolcanoCancel takes unit caster returns nothing
    local integer slot = HB_FLFindVolcanoSlot(caster)
    if slot < 0 then
        return
    endif
    if HB_FL_VOL_POINT[slot] != null then
        call RemoveLocation(HB_FL_VOL_POINT[slot])
    endif
    set HB_FL_VOL_POINT[slot] = null
    set HB_FL_VOL_CASTER[slot] = null
    set HB_FL_VOL_ACTIVE[slot] = false
endfunction

function HB_OnHeroLevel takes nothing returns nothing
    local unit u = GetLevelingUnit()
    if u != null and HB_FindHeroByUnit(u) >= 0 then
        call HB_RefreshSkillPoints(u)
    endif
    set u = null
endfunction

function HB_OnSpell takes nothing returns nothing
    local integer id = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    if id == HB_ABIL_MULTI then
        call HB_MultiArrow(u, GetSpellTargetLoc())
    elseif id == HB_ABIL_CHARM then
        call HB_ShareVision(u, GetSpellTargetUnit())
    elseif id == HB_ABIL_DRAIN or id == HB_ABIL_ICE then
        call UnitAddType(u, UNIT_TYPE_SAPPER)
    elseif id == HB_ABIL_DH_BURN then
        call HB_DHManaBurn(u, GetSpellTargetUnit())
    elseif id == HB_ABIL_DH_LEASH then
        call HB_DHLeash(u, GetSpellTargetUnit())
    elseif id == HB_ABIL_DH_META then
        call HB_DHMeta(u)
    elseif id == HB_ABIL_DH_BREATH then
        call HB_DHBreath(u)
    elseif id == HB_ABIL_BM_DASH then
        call HB_BMDash(u, GetSpellTargetLoc())
    elseif id == HB_ABIL_BM_BLADE then
        call HB_BMBlades(u)
    elseif id == HB_ABIL_BM_MIRROR then
        call HB_BMMirror(u)
    elseif id == HB_ABIL_FL_ARMOR then
        call HB_FLFlameArmor(u)
    elseif id == HB_ABIL_FL_SOUL then
        call HB_FLSoulBurn(u, GetSpellTargetUnit())
    elseif id == HB_ABIL_FL_VOLCANO then
        call HB_FLVolcanoSave(u, GetSpellTargetLoc())
    elseif id == HB_ABIL_FL_ROPE then
        call HB_FLRopeStart(u)
    elseif id == HB_ABIL_SH_HEX then
        call HB_SHHexAoe(u, GetSpellTargetUnit())
    elseif id == HB_ABIL_SH_WARD then
        call HB_SHWard(u, GetSpellTargetLoc())
    elseif id == HB_ABIL_SH_VOODOO then
        call HB_SHVoodoo(u)
    elseif id == HB_ABIL_SH_ANCESTOR then
        call HB_SHAncestor(u)
    endif
    set u = null
endfunction

function HB_OnSpellFinish takes nothing returns nothing
    local integer id = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    local location loc
    local location loc2
    local unit d
    if id == HB_ABIL_RAIN then
        set loc = GetUnitLoc(u)
        set loc2 = PolarProjectionBJ(loc, 200.0, GetUnitFacing(u))
        set d = CreateUnitAtLoc(GetOwningPlayer(u), HB_UNIT_RAIN, loc2, 0.0)
        call IssueTargetOrderById(u, 851985, d)
        call RemoveLocation(loc2)
        call RemoveLocation(loc)
        set d = null
    elseif id == HB_ABIL_FL_VOLCANO then
        call HB_FLVolcanoFinish(u)
    endif
    set u = null
endfunction

function HB_OnSpellEnd takes nothing returns nothing
    local integer id = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    if id == HB_ABIL_DRAIN or id == HB_ABIL_ICE then
        call UnitRemoveType(u, UNIT_TYPE_SAPPER)
    elseif id == HB_ABIL_FL_VOLCANO then
        call HB_FLVolcanoCancel(u)
    elseif id == HB_ABIL_FL_ROPE then
        call HB_FLRopeEnd(u)
    elseif id == HB_ABIL_SH_VOODOO then
        call HB_SHVoodooEnd(u)
    elseif id == HB_ABIL_SH_ANCESTOR then
        call HB_SHAncestorEnd(u)
    endif
    set u = null
endfunction

function HB_OnChat takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local integer i = 0
    local integer sp = -1
    local string cmd
    local string arg
    loop
        exitwhen i >= len
        if SubString(s, i, i + 1) == " " then
            set sp = i
            set i = len
        endif
        set i = i + 1
    endloop
    if sp < 0 then
        set cmd = s
        set arg = ""
    else
        set cmd = SubString(s, 0, sp)
        set arg = HB_Trim(SubString(s, sp + 1, len))
    endif
    if HB_StrEqCI(cmd, "addhero") then
        call HB_AddHero(p, arg)
    elseif HB_StrEqCI(cmd, "listhero") then
        call HB_ListHero(p)
    elseif HB_StrEqCI(cmd, "heroskills") then
        call HB_HeroSkills(p, arg)
    endif
endfunction

function HB_Init takes nothing returns nothing
    local trigger t
    local integer i = 0
    if HB_INITED then
        return
    endif
    set HB_INITED = true

    set HB_HERO_COUNT = 5
    set HB_HERO_NAME[0] = "光明游侠"
    set HB_HERO_ID[0] = "H0L1"
    set HB_HERO_ALIAS[0] = "Hvwd,lightranger,ls,gmyx,guangmingyouxia"
    set HB_HERO_TYPE[0] = 'H0L1'
    set HB_HERO_ABIL_COUNT[0] = 5
    set HB_HERO_ABIL[0] = 'A0L1'
    set HB_HERO_ABIL_MAX[0] = 10
    set HB_HERO_ABIL[1] = 'A0L2'
    set HB_HERO_ABIL_MAX[1] = 10
    set HB_HERO_ABIL[2] = 'A0L3'
    set HB_HERO_ABIL_MAX[2] = 10
    set HB_HERO_ABIL[3] = 'A0L4'
    set HB_HERO_ABIL_MAX[3] = 2
    set HB_HERO_ABIL[4] = 'A0L5'
    set HB_HERO_ABIL_MAX[4] = 1
    set HB_HERO_ABIL_REQ[0] = 1
    set HB_HERO_ABIL_SKIP[0] = 1
    set HB_HERO_ABIL_REQ[1] = 1
    set HB_HERO_ABIL_SKIP[1] = 1
    set HB_HERO_ABIL_REQ[2] = 1
    set HB_HERO_ABIL_SKIP[2] = 1
    set HB_HERO_ABIL_REQ[3] = 4
    set HB_HERO_ABIL_SKIP[3] = 4
    set HB_HERO_ABIL_REQ[4] = 10
    set HB_HERO_ABIL_SKIP[4] = 1
    set HB_HERO_MORPH[0] = 0

    set HB_HERO_NAME[1] = "恶魔猎手"
    set HB_HERO_ID[1] = "H0D1"
    set HB_HERO_ALIAS[1] = "Edem,dh,demonhunter,emls"
    set HB_HERO_TYPE[1] = 'H0D1'
    set HB_HERO_MORPH[1] = 'H0D2'
    set HB_HERO_ABIL_COUNT[1] = 5
    set HB_HERO_ABIL[8] = 'A0D1'
    set HB_HERO_ABIL_MAX[8] = 10
    set HB_HERO_ABIL[9] = 'A0D2'
    set HB_HERO_ABIL_MAX[9] = 10
    set HB_HERO_ABIL[10] = 'A0D3'
    set HB_HERO_ABIL_MAX[10] = 10
    set HB_HERO_ABIL[11] = 'A0D4'
    set HB_HERO_ABIL_MAX[11] = 2
    set HB_HERO_ABIL[12] = 'A0D5'
    set HB_HERO_ABIL_MAX[12] = 1
    set HB_HERO_ABIL_REQ[8] = 1
    set HB_HERO_ABIL_SKIP[8] = 1
    set HB_HERO_ABIL_REQ[9] = 1
    set HB_HERO_ABIL_SKIP[9] = 1
    set HB_HERO_ABIL_REQ[10] = 1
    set HB_HERO_ABIL_SKIP[10] = 1
    set HB_HERO_ABIL_REQ[11] = 4
    set HB_HERO_ABIL_SKIP[11] = 4
    set HB_HERO_ABIL_REQ[12] = 10
    set HB_HERO_ABIL_SKIP[12] = 1

    set HB_HERO_NAME[2] = "暗影猎手"
    set HB_HERO_ID[2] = "H0S1"
    set HB_HERO_ALIAS[2] = "Oshd,sh,xiaoy,shadowhunter"
    set HB_HERO_TYPE[2] = 'H0S1'
    set HB_HERO_MORPH[2] = 0
    set HB_HERO_ABIL_COUNT[2] = 5
    set HB_HERO_ABIL[16] = 'A0S1'
    set HB_HERO_ABIL_MAX[16] = 10
    set HB_HERO_ABIL[17] = 'A0S2'
    set HB_HERO_ABIL_MAX[17] = 10
    set HB_HERO_ABIL[18] = 'A0S3'
    set HB_HERO_ABIL_MAX[18] = 10
    set HB_HERO_ABIL[19] = 'A0S4'
    set HB_HERO_ABIL_MAX[19] = 2
    set HB_HERO_ABIL[20] = 'A0S5'
    set HB_HERO_ABIL_MAX[20] = 1
    set HB_HERO_ABIL_REQ[16] = 1
    set HB_HERO_ABIL_SKIP[16] = 1
    set HB_HERO_ABIL_REQ[17] = 1
    set HB_HERO_ABIL_SKIP[17] = 1
    set HB_HERO_ABIL_REQ[18] = 1
    set HB_HERO_ABIL_SKIP[18] = 1
    set HB_HERO_ABIL_REQ[19] = 4
    set HB_HERO_ABIL_SKIP[19] = 4
    set HB_HERO_ABIL_REQ[20] = 10
    set HB_HERO_ABIL_SKIP[20] = 1

    set HB_HERO_NAME[3] = "剑圣"
    set HB_HERO_ID[3] = "H0B1"
    set HB_HERO_ALIAS[3] = "Obla,blademaster,blade,bm,js,jiansheng,huorenjiansheng,火刃剑圣"
    set HB_HERO_TYPE[3] = 'H0B1'
    set HB_HERO_MORPH[3] = 0
    set HB_HERO_ABIL_COUNT[3] = 5
    set HB_HERO_ABIL[24] = 'A0B1'
    set HB_HERO_ABIL_MAX[24] = 10
    set HB_HERO_ABIL[25] = 'A0B2'
    set HB_HERO_ABIL_MAX[25] = 10
    set HB_HERO_ABIL[26] = 'A0B3'
    set HB_HERO_ABIL_MAX[26] = 10
    set HB_HERO_ABIL[27] = 'A0B4'
    set HB_HERO_ABIL_MAX[27] = 2
    set HB_HERO_ABIL[28] = 'A0B5'
    set HB_HERO_ABIL_MAX[28] = 1
    set HB_HERO_ABIL_REQ[24] = 1
    set HB_HERO_ABIL_SKIP[24] = 1
    set HB_HERO_ABIL_REQ[25] = 1
    set HB_HERO_ABIL_SKIP[25] = 1
    set HB_HERO_ABIL_REQ[26] = 1
    set HB_HERO_ABIL_SKIP[26] = 1
    set HB_HERO_ABIL_REQ[27] = 4
    set HB_HERO_ABIL_SKIP[27] = 3
    set HB_HERO_ABIL_REQ[28] = 10
    set HB_HERO_ABIL_SKIP[28] = 1

    set HB_HERO_NAME[4] = "火魔"
    set HB_HERO_ID[4] = "H0F1"
    set HB_HERO_ALIAS[4] = "Nfir,firelord,fl,huomo,huoyanjumo,火焰巨魔"
    set HB_HERO_TYPE[4] = 'H0F1'
    set HB_HERO_MORPH[4] = 0
    set HB_HERO_ABIL_COUNT[4] = 5
    set HB_HERO_ABIL[32] = 'A0F1'
    set HB_HERO_ABIL_MAX[32] = 10
    set HB_HERO_ABIL[33] = 'A0F2'
    set HB_HERO_ABIL_MAX[33] = 10
    set HB_HERO_ABIL[34] = 'A0F3'
    set HB_HERO_ABIL_MAX[34] = 10
    set HB_HERO_ABIL[35] = 'A0F4'
    set HB_HERO_ABIL_MAX[35] = 2
    set HB_HERO_ABIL[36] = 'A0F5'
    set HB_HERO_ABIL_MAX[36] = 1
    set HB_HERO_ABIL_REQ[32] = 1
    set HB_HERO_ABIL_SKIP[32] = 1
    set HB_HERO_ABIL_REQ[33] = 1
    set HB_HERO_ABIL_SKIP[33] = 1
    set HB_HERO_ABIL_REQ[34] = 1
    set HB_HERO_ABIL_SKIP[34] = 1
    set HB_HERO_ABIL_REQ[35] = 4
    set HB_HERO_ABIL_SKIP[35] = 4
    set HB_HERO_ABIL_REQ[36] = 10
    set HB_HERO_ABIL_SKIP[36] = 1

    set HB_ABIL_SILENCE = 'A0L1'
    set HB_ABIL_RAIN = 'A0L2'
    set HB_ABIL_DRAIN = 'A0L3'
    set HB_ABIL_ICE = 'A0L4'
    set HB_ABIL_MULTI = 'A0L5'
    set HB_ABIL_CHARM = 'A0L6'
    set HB_ABIL_FROST = 'A0L7'
    set HB_ABIL_INV = 'A0L8'
    set HB_ABIL_MULTI_DUMMY = 'A0L9'
    set HB_ABIL_RAIN_DUMMY = 'A0LA'
    set HB_UNIT_RAIN = 'nskk'
    set HB_UNIT_MULTI = 'emtg'
    set HB_ABIL_DH_BURN = 'A0D1'
    set HB_ABIL_DH_LEASH = 'A0D2'
    set HB_ABIL_DH_EVASION = 'A0D3'
    set HB_ABIL_DH_META = 'A0D4'
    set HB_ABIL_DH_BREATH = 'A0D5'
    set HB_ABIL_DH_ORB = 'A0D6'
    set HB_ABIL_DH_BURN_DUMMY = 'A0D8'
    set HB_ABIL_DH_LEASH_DUMMY = 'A0D9'
    set HB_ABIL_DH_SWARM_DUMMY = 'A0DA'
    set HB_UNIT_DH_DUMMY = 'hgyr'
    set HB_UNIT_DH_DUMMY2 = 'hmtt'
    set HB_ABIL_BM_DASH = 'A0B5'
    set HB_ABIL_BM_BLADE = 'A0B4'
    set HB_ABIL_BM_WIND = 'A0B1'
    set HB_ABIL_BM_MIRROR = 'A0B2'
    set HB_ABIL_BM_BLADE_DUMMY = 'A0B7'
    set HB_ABIL_BM_MIRROR_DUMMY = 'A0B9'
    set HB_UNIT_BM_BLADE = 'h0B2'
    set HB_UNIT_BM_MIRROR = 'h0B2'
    set HB_UNIT_BM_JUMP = 'h0B3'
    set HB_ABIL_SH_HEAL = 'A0S1'
    set HB_ABIL_SH_HEX = 'A0S2'
    set HB_ABIL_SH_WARD = 'A0S3'
    set HB_ABIL_SH_VOODOO = 'A0S4'
    set HB_ABIL_SH_ANCESTOR = 'A0S5'
    set HB_ABIL_SH_GLAIVE = 'A0S6'
    set HB_ABIL_SH_HEX_DUMMY = 'A0S8'
    set HB_UNIT_SH_DUMMY = 'nanb'
    set HB_UNIT_SH_SPIRIT = 'zmar'
    set HB_UNIT_SH_SPIRIT2 = 'owyv'
    set HB_UNIT_SH_ORB = 'otbr'
    set HB_UNIT_SH_WARD1 = 'osp1'
    set HB_UNIT_SH_WARD2 = 'osp2'
    set HB_UNIT_SH_WARD3 = 'osp3'
    set HB_UNIT_SH_WARD4 = 'osp4'
    set HB_UNIT_SH_WARD5 = 'hpxe'
    set HB_ABIL_FL_SOUL = 'A0F1'
    set HB_ABIL_FL_VOLCANO = 'A0F4'
    set HB_ABIL_FL_ROPE = 'A0F5'
    set HB_ABIL_FL_ARMOR = 'A0F7'
    set HB_ABIL_FL_BOOK = 'A0F6'
    set HB_ABIL_FL_VOLCANO_DUMMY = 'A0FA'
    set HB_ABIL_FL_CLEAR = 'A0FF'
    set HB_UNIT_FL_SOUL = 'h0F1'
    set HB_UNIT_FL_VOLCANO = 'o0F1'
    set HB_UNIT_FL_ROPE = 'n0F4'
    set HB_UNIT_FL_ARMOR = 'n0F3'

    set i = 0
    loop
        exitwhen i > 11
        call SetPlayerAbilityAvailable(Player(i), HB_ABIL_FL_BOOK, false)
        set i = i + 1
    endloop

    set HB_SH_MK = CreateTrigger()
    call TriggerAddAction(HB_SH_MK, function HB_SHAncestorDance)
    call DisableTrigger(HB_SH_MK)
    set HB_SH_ML = CreateTrigger()
    call TriggerAddAction(HB_SH_ML, function HB_SHAncestorOrbit)
    call DisableTrigger(HB_SH_ML)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function HB_OnSpell)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(t, function HB_OnBMOrder)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddAction(t, function HB_OnSpellFinish)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddAction(t, function HB_OnSpellEnd)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(t, function HB_OnHeroLevel)

    set t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "addhero", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "heroskills", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listhero", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function HB_OnChat)
    set t = null
endfunction

function main takes nothing returns nothing
call HB_Init()

endfunction
