function FR_HighestStat takes unit u returns integer
    local integer best
    local integer value
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return 0
    endif
    set best = GetHeroStr(u, true)
    set value = GetHeroAgi(u, true)
    if value > best then
        set best = value
    endif
    set value = GetHeroInt(u, true)
    if value > best then
        set best = value
    endif
    return best
endfunction

function FR_ApplySlow takes unit source, unit target returns nothing
    local integer key
    local real base_speed
    local real duration
    if source == null or target == null then
        return
    endif
    if not UnitHasItemOfTypeBJ(source, FR_ITEM_ID) then
        return
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(source)) then
        return
    endif
    if IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
        return
    endif
    set key = GetHandleId(target)
    set base_speed = LoadReal(fr_slow_table, key, 0)
    if base_speed <= 0.0 then
        set base_speed = GetUnitMoveSpeed(target)
        call SaveReal(fr_slow_table, key, 0, base_speed)
        call GroupAddUnit(fr_slow_group, target)
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set duration = FR_SLOW_HERO_DURATION
    else
        set duration = FR_SLOW_DURATION
    endif
    call SaveReal(fr_slow_table, key, 1, TimerGetElapsed(fr_slow_timer) + duration)
    call SetUnitMoveSpeed(target, RMaxBJ(50.0, base_speed * FR_SLOW_FACTOR))
endfunction

function FR_OnAttack takes nothing returns nothing
    call FR_ApplySlow(GetAttacker(), GetTriggerUnit())
endfunction

function FR_SlowStep takes nothing returns nothing
    local group work = CreateGroup()
    local unit u
    local integer key
    call GroupAddGroup(fr_slow_group, work)
    loop
        set u = FirstOfGroup(work)
        exitwhen u == null
        set key = GetHandleId(u)
        if GetUnitTypeId(u) == 0 then
            call FlushChildHashtable(fr_slow_table, key)
            call GroupRemoveUnit(fr_slow_group, u)
        elseif TimerGetElapsed(fr_slow_timer) >= LoadReal(fr_slow_table, key, 1) then
            call SetUnitMoveSpeed(u, LoadReal(fr_slow_table, key, 0))
            call FlushChildHashtable(fr_slow_table, key)
            call GroupRemoveUnit(fr_slow_group, u)
        endif
        call GroupRemoveUnit(work, u)
    endloop
    call DestroyGroup(work)
    set work = null
    set u = null
endfunction

function FR_ItemOnGround takes item it returns boolean
    local player p
    if it == null or GetItemTypeId(it) != FR_ITEM_ID then
        return false
    endif
    set p = GetItemPlayer(it)
    if p == null then
        return true
    endif
    return GetPlayerId(p) == PLAYER_NEUTRAL_PASSIVE
endfunction

function FR_AddGroundAura takes item it returns nothing
    local integer i = 0
    local integer key
    local effect fx
    local real x
    local real y
    if it == null or GetItemTypeId(it) != FR_ITEM_ID then
        return
    endif
    set key = GetHandleId(it)
    loop
        exitwhen i >= fr_ground_count
        if fr_ground_keys[i] == key then
            return
        endif
        set i = i + 1
    endloop
    if fr_ground_count >= 16 then
        return
    endif
    set fx = null
    if HaveSavedHandle(fr_ground_table, key, 0) then
        set fx = LoadEffectHandle(fr_ground_table, key, 0)
    endif
    set x = GetItemX(it)
    set y = GetItemY(it)
    if fx == null then
        set fx = AddSpecialEffect("war3campImported\\Rune-Blue-Aura_Raised20.mdx", x, y)
        call SaveEffectHandle(fr_ground_table, key, 0, fx)
    endif
    set fr_ground_items[fr_ground_count] = it
    set fr_ground_keys[fr_ground_count] = key
    set fr_ground_effects[fr_ground_count] = fx
    set fr_ground_x[fr_ground_count] = x
    set fr_ground_y[fr_ground_count] = y
    set fr_ground_count = fr_ground_count + 1
    set fx = null
endfunction

function FR_EnumGroundItem takes nothing returns nothing
    call FR_AddGroundAura(GetEnumItem())
endfunction

function FR_RemoveItemAura takes item it returns nothing
    local integer i = 0
    local integer key
    local integer last
    if it == null then
        return
    endif
    set key = GetHandleId(it)
    loop
        exitwhen i >= fr_ground_count
        if fr_ground_keys[i] == key then
            call DestroyEffect(fr_ground_effects[i])
            call FlushChildHashtable(fr_ground_table, key)
            set last = fr_ground_count - 1
            set fr_ground_items[i] = fr_ground_items[last]
            set fr_ground_keys[i] = fr_ground_keys[last]
            set fr_ground_effects[i] = fr_ground_effects[last]
            set fr_ground_x[i] = fr_ground_x[last]
            set fr_ground_y[i] = fr_ground_y[last]
            set fr_ground_items[last] = null
            set fr_ground_keys[last] = 0
            set fr_ground_effects[last] = null
            set fr_ground_count = last
            return
        endif
        set i = i + 1
    endloop
endfunction

function FR_OnItemPickup takes nothing returns nothing
    call FR_RemoveItemAura(GetManipulatedItem())
endfunction

function FR_GroundAuraStep takes nothing returns nothing
    local integer i = fr_ground_count
    local integer last
    local item it
    local effect fx
    local integer key
    local real x
    local real y
    loop
        exitwhen i <= 0
        set i = i - 1
        set it = fr_ground_items[i]
        if not FR_ItemOnGround(it) then
            if it != null and GetItemTypeId(it) == FR_ITEM_ID then
                set key = GetHandleId(it)
                set fx = LoadEffectHandle(fr_ground_table, key, 0)
                call DestroyEffect(fx)
                call FlushChildHashtable(fr_ground_table, key)
            endif
            set last = fr_ground_count - 1
            set fr_ground_items[i] = fr_ground_items[last]
            set fr_ground_keys[i] = fr_ground_keys[last]
            set fr_ground_effects[i] = fr_ground_effects[last]
            set fr_ground_x[i] = fr_ground_x[last]
            set fr_ground_y[i] = fr_ground_y[last]
            set fr_ground_items[last] = null
            set fr_ground_keys[last] = 0
            set fr_ground_effects[last] = null
            set fr_ground_count = last
        else
            set x = GetItemX(it)
            set y = GetItemY(it)
            if SquareRoot((x - fr_ground_x[i]) * (x - fr_ground_x[i]) + (y - fr_ground_y[i]) * (y - fr_ground_y[i])) > 20.0 then
                call DestroyEffect(fr_ground_effects[i])
                set fr_ground_effects[i] = AddSpecialEffect("war3campImported\\Rune-Blue-Aura_Raised20.mdx", x, y)
                set fr_ground_x[i] = x
                set fr_ground_y[i] = y
                call SaveEffectHandle(fr_ground_table, GetHandleId(it), 0, fr_ground_effects[i])
            endif
        endif
    endloop
    set it = null
    set fx = null
    call EnumItemsInRect(fr_world, null, function FR_EnumGroundItem)
endfunction

function FR_SoulAbility takes integer block returns integer
    if block == 0 then
        return 'A130'
    elseif block == 1 then
        return 'A131'
    elseif block == 2 then
        return 'A132'
    elseif block == 3 then
        return 'A133'
    elseif block == 4 then
        return 'A134'
    elseif block == 5 then
        return 'A135'
    elseif block == 6 then
        return 'A136'
    elseif block == 7 then
        return 'A137'
    elseif block == 8 then
        return 'A138'
    elseif block == 9 then
        return 'A139'
    elseif block == 10 then
        return 'A140'
    elseif block == 11 then
        return 'A141'
    endif
    return 0
endfunction

function FR_SetSoulBurden takes unit u, integer value returns nothing
    local integer bit = 0
    local integer abil
    loop
        exitwhen bit >= 12
        set abil = FR_SoulAbility(bit)
        if ModuloInteger(value, 2) == 1 then
            if GetUnitAbilityLevel(u, abil) == 0 then
                call UnitAddAbility(u, abil)
                call UnitMakeAbilityPermanent(u, true, abil)
            endif
        elseif GetUnitAbilityLevel(u, abil) > 0 then
            call UnitRemoveAbility(u, abil)
        endif
        set value = value / 2
        set bit = bit + 1
    endloop
endfunction

function FR_ShowSoulDrain takes unit u returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt, "灵魂被吞噬 -50 最大生命", 0.024)
    call SetTextTagPosUnit(tt, u, 110.0)
    call SetTextTagColor(tt, 190, 100, 255, 255)
    call SetTextTagVelocity(tt, 0.0, 0.035)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.8)
    call SetTextTagFadepoint(tt, 1.2)
    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(u))
    set tt = null
endfunction

function FR_TrySoulDrain takes unit u returns nothing
    local integer key
    local integer total
    local real oldMax
    local real newMax
    if u == null or not UnitHasItemOfTypeBJ(u, FR_ITEM_ID) then
        return
    endif
    if GetRandomReal(0.0, 1.0) >= FR_SOUL_CHANCE then
        return
    endif
    set oldMax = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    if oldMax <= I2R(FR_SOUL_DRAIN) then
        return
    endif
    set key = GetHandleId(u)
    set total = LoadInteger(fr_soul_table, key, 0) + 1
    if total >= 4096 then
        return
    endif
    call FR_SetSoulBurden(u, total)
    set newMax = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    if oldMax - newMax < 49.0 then
        return
    endif
    call SaveInteger(fr_soul_table, key, 0, total)
    call FR_ShowSoulDrain(u)
endfunction

function FR_Unfreeze takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerKey = GetHandleId(t)
    local integer unitKey = LoadInteger(fr_freeze_timer_table, timerKey, 1)
    local unit u = LoadUnitHandle(fr_freeze_timer_table, timerKey, 0)
    if u != null and GetUnitTypeId(u) != 0 then
        call PauseUnit(u, false)
        call SetUnitTimeScale(u, 1.0)
    endif
    call FlushChildHashtable(fr_freeze_table, unitKey)
    call FlushChildHashtable(fr_freeze_timer_table, timerKey)
    call DestroyTimer(t)
    set u = null
    set t = null
endfunction

function FR_FreezeAir takes unit u, real duration returns nothing
    local integer unitKey
    local integer timerKey
    local timer t
    if u == null or (not IsUnitType(u, UNIT_TYPE_FLYING) and not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then
        return
    endif
    set unitKey = GetHandleId(u)
    if HaveSavedHandle(fr_freeze_table, unitKey, 0) then
        set t = LoadTimerHandle(fr_freeze_table, unitKey, 0)
    else
        set t = CreateTimer()
        set timerKey = GetHandleId(t)
        call SaveTimerHandle(fr_freeze_table, unitKey, 0, t)
        call SaveUnitHandle(fr_freeze_timer_table, timerKey, 0, u)
        call SaveInteger(fr_freeze_timer_table, timerKey, 1, unitKey)
        call PauseUnit(u, true)
        call SetUnitTimeScale(u, 0.0)
    endif
    call TimerStart(t, duration, false, function FR_Unfreeze)
    set t = null
endfunction

function FR_CanAffect takes unit caster, unit target returns boolean
    local integer ownerId
    if caster == null or target == null then
        return false
    endif
    if IsUnitEnemy(target, GetOwningPlayer(caster)) then
        return true
    endif
    if not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    set ownerId = GetPlayerId(GetOwningPlayer(target))
    return ownerId == PLAYER_NEUTRAL_PASSIVE or ownerId == PLAYER_NEUTRAL_AGGRESSIVE
endfunction

function FR_OnSpell takes nothing returns nothing
    local unit caster
    local group g
    local unit target
    local real x
    local real y
    local real bonus
    local real freeze_duration
    if GetSpellAbilityId() != FR_SPELL_ID then
        return
    endif
    set caster = GetTriggerUnit()
    set x = GetUnitX(caster)
    set y = GetUnitY(caster)
    set bonus = I2R(FR_HighestStat(caster)) * FR_SPELL_STAT_MULT
    if bonus <= 0.0 then
        set caster = null
        return
    endif
    call FR_TrySoulDrain(caster)
    call TriggerSleepAction(0.05)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, FR_SPELL_RADIUS, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        if target != caster and IsUnitAliveBJ(target) and FR_CanAffect(caster, target) then
            if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
                call FR_FreezeAir(target, 5.0)
            endif
            if not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
                call UnitDamageTarget(caster, target, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                if IsUnitType(target, UNIT_TYPE_FLYING) then
                    if IsUnitType(target, UNIT_TYPE_HERO) then
                        set freeze_duration = 3.0
                    else
                        set freeze_duration = 5.0
                    endif
                    call FR_FreezeAir(target, freeze_duration)
                endif
            endif
        endif
        call GroupRemoveUnit(g, target)
    endloop
    call DestroyGroup(g)
    set g = null
    set target = null
    set caster = null
endfunction

function FR_Init takes nothing returns nothing
    if fr_inited then
        return
    endif
    set fr_inited = true
    set fr_slow_group = CreateGroup()
    set fr_slow_table = InitHashtable()
    set fr_soul_table = InitHashtable()
    set fr_freeze_table = InitHashtable()
    set fr_freeze_timer_table = InitHashtable()
    set fr_slow_timer = CreateTimer()
    call TimerStart(fr_slow_timer, 0.10, true, function FR_SlowStep)
    set fr_world = GetWorldBounds()
    set fr_ground_table = InitHashtable()
    set fr_pickup_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_pickup_trigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(fr_pickup_trigger, function FR_OnItemPickup)
    set fr_ground_timer = CreateTimer()
    call TimerStart(fr_ground_timer, 0.25, true, function FR_GroundAuraStep)

    set fr_attack_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_attack_trigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(fr_attack_trigger, function FR_OnAttack)

    set fr_spell_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_spell_trigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(fr_spell_trigger, function FR_OnSpell)

    call DisplayTextToPlayer(Player(0), 0, 0, "|cff66ccff[霜之哀伤]|r 已加载")
endfunction
