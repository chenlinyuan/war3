function LT30_Has takes unit u, integer abilityId returns boolean
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    return GetUnitAbilityLevel(u, abilityId) > 0
endfunction

function LT30_JumpDamage takes unit caster, integer windLevel returns real
    local real damage = 120.0 * I2R(windLevel)
    if LT30_Has(caster, 'BT00') then
        set damage = damage * 1.5
    endif
    return damage
endfunction

function LT30_JumpRange takes unit caster returns real
    if LT30_Has(caster, 'BT00') then
        return 1000.0
    endif
    return 800.0
endfunction

function LT30_ClearBuffSlot takes integer slot returns nothing
    if LT30_BUFF_UNIT[slot] != null and GetUnitTypeId(LT30_BUFF_UNIT[slot]) != 0 then
        call UnitRemoveAbility(LT30_BUFF_UNIT[slot], LT30_BUFF_ABILITY[slot])
    endif
    set LT30_BUFF_UNIT[slot] = null
    set LT30_BUFF_ABILITY[slot] = 0
    set LT30_BUFF_REMAIN[slot] = 0.0
endfunction

function LT30_ApplyTimed takes unit u, integer abilityId, real duration returns nothing
    local integer i = 0
    local integer freeSlot = -1
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    loop
        exitwhen i >= LT30_BUFF_COUNT
        if LT30_BUFF_UNIT[i] == u and LT30_BUFF_ABILITY[i] == abilityId then
            set freeSlot = i
            exitwhen true
        endif
        if freeSlot < 0 and LT30_BUFF_UNIT[i] == null then
            set freeSlot = i
        endif
        set i = i + 1
    endloop
    if freeSlot < 0 then
        return
    endif
    if GetUnitAbilityLevel(u, abilityId) > 0 then
        call UnitRemoveAbility(u, abilityId)
    endif
    call UnitAddAbility(u, abilityId)
    set LT30_BUFF_UNIT[freeSlot] = u
    set LT30_BUFF_ABILITY[freeSlot] = abilityId
    set LT30_BUFF_REMAIN[freeSlot] = duration
endfunction

function LT30_BuffStep takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i >= LT30_BUFF_COUNT
        if LT30_BUFF_UNIT[i] != null then
            if GetUnitTypeId(LT30_BUFF_UNIT[i]) == 0 then
                call LT30_ClearBuffSlot(i)
            else
                set LT30_BUFF_REMAIN[i] = LT30_BUFF_REMAIN[i] - 0.1
                if LT30_BUFF_REMAIN[i] <= 0.0 then
                    call LT30_ClearBuffSlot(i)
                endif
            endif
        endif
        set i = i + 1
    endloop
endfunction

function LT30_OnJumpHit takes unit caster, unit target, real bonusDamage returns nothing
    local location p
    local group g
    local unit u
    if caster == null or target == null or GetUnitTypeId(caster) == 0 or GetUnitTypeId(target) == 0 then
        return
    endif
    if LT30_Has(caster, 'BT02') then
        call LT30_ApplyTimed(caster, 'BTE0', 4.0)
        call LT30_ApplyTimed(caster, 'BTE1', 4.0)
    endif
    if LT30_Has(caster, 'BT01') and IsUnitAliveBJ(target) then
        set p = GetUnitLoc(target)
        set g = CreateGroup()
        call GroupEnumUnitsInRangeOfLoc(g, p, 250.0, null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)
            if u != caster and IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
                call UnitDamageTarget(caster, u, bonusDamage * 0.5, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
        endloop
        call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", p))
        call DestroyGroup(g)
        call RemoveLocation(p)
        set p = null
        set g = null
        set u = null
    endif
endfunction

function LT30_GiveTalentPoint takes unit u, integer level, integer key returns nothing
    local integer id
    if u == null or GetUnitTypeId(u) != 'H0B1' then
        return
    endif
    set id = GetHandleId(u)
    if GetHeroLevel(u) >= level and not LoadBoolean(LT30_STATE, id, key) then
        call UnitAddItemById(u, 'ttal')
        call SaveBoolean(LT30_STATE, id, key, true)
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cff32cd32[天赋]|r 获得 1 个天赋点，请打开背包的 TALENTS 页选择天赋。")
    endif
endfunction

function LT30_OnLevel takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call LT30_GiveTalentPoint(u, 2, 2)
    call LT30_GiveTalentPoint(u, 4, 4)
    call LT30_GiveTalentPoint(u, 7, 7)
    call LT30_GiveTalentPoint(u, 10, 10)
    set u = null
endfunction

function LT30_FindHero takes player p returns unit
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsOfPlayer(g, p, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitAliveBJ(u) then
            call DestroyGroup(g)
            set g = null
            return u
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    return null
endfunction

function LT30_HasBackpackItem takes unit u returns boolean
    local integer i = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == 'B30B' then
            set it = null
            return true
        endif
        set i = i + 1
    endloop
    set it = null
    return false
endfunction

function LT30_OnChat takes nothing returns nothing
    local string msg = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local unit u
    local item it
    if StringCase(msg, false) == "baggive" then
        set u = LT30_FindHero(p)
        if u == null then
            call DisplayTextToPlayer(p, 0, 0, "|cffff4444[背包]|r 请先用 addhero 添加英雄。")
        elseif not LT30_HasBackpackItem(u) then
            call UnitAddItemByIdSwapped('B30B', u)
            call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[背包]|r 已发放英雄装备背包。")
        endif
        set u = null
    elseif StringCase(msg, false) == "baginfo" then
        set u = LT30_FindHero(p)
        if u == null then
            call DisplayTextToPlayer(p, 0, 0, "|cffff4444[背包]|r 请先用 addhero 添加英雄。")
        else
            call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[背包]|r UnitInventorySize = " + I2S(UnitInventorySize(u)))
            set it = UnitItemInBagSlotBJ(u, 7)
            if it == null then
                call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[背包]|r 第7格为空（原生背包已存在）")
            else
                call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[背包]|r 第7格 = " + GetItemName(it))
            endif
            set it = null
        endif
        set u = null
    endif
    if StringCase(SubString(msg, 0, 6), false) == "talent" then
        call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋]|r 天赋系统暂未启用；当前提供通用背包、装备栏和属性面板。")
    endif
endfunction

function LT30_Init takes nothing returns nothing
    local trigger t
    local integer i = 0
    if LT30_INITED then
        return
    endif
    set LT30_INITED = true
    set LT30_STATE = InitHashtable()
    set t = CreateTrigger()
    loop
        exitwhen i > 3
        call TriggerRegisterPlayerChatEvent(t, Player(i), "talent", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "baggive", true)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "baginfo", true)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function LT30_OnChat)
    set LT30_BUFF_TIMER = CreateTimer()
    call TimerStart(LT30_BUFF_TIMER, 0.1, true, function LT30_BuffStep)
    set t = null
endfunction
