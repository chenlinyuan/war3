
//============================================================================
// WARGLAIVE OF AZZINOTH - SCRIPTED BARBARIC CHARGE
//============================================================================
function WGL_HasWarglaive takes unit u returns boolean
    return UnitHasItemOfTypeBJ(u, 'I106')
endfunction

function WGL_CooldownClockTick takes nothing returns nothing
endfunction

function WGL_SyncAttackSpeed takes unit u returns nothing
    local integer level
    local real bonus
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) or not WGL_HasWarglaive(u) then
        return
    endif
    if GetUnitAbilityLevel(u, 'A111') <= 0 then
        return
    endif
    set bonus = I2R(GetHeroAgi(u, true)) * WGL_ATTACK_SPEED_AGI_MULT
    if bonus < WGL_ATTACK_SPEED_MIN then
        set bonus = WGL_ATTACK_SPEED_MIN
    elseif bonus > WGL_ATTACK_SPEED_MAX then
        set bonus = WGL_ATTACK_SPEED_MAX
    endif
    set level = R2I(bonus / WGL_ATTACK_SPEED_STEP + 0.5)
    set level = level - R2I(WGL_ATTACK_SPEED_MIN / WGL_ATTACK_SPEED_STEP) + 1
    if level < 1 then
        set level = 1
    elseif level > WGL_ATTACK_SPEED_LEVELS then
        set level = WGL_ATTACK_SPEED_LEVELS
    endif
    if GetUnitAbilityLevel(u, 'A111') != level then
        call SetUnitAbilityLevel(u, 'A111', level)
    endif
endfunction

function WGL_SyncUnit takes unit u returns nothing
    local integer unitId
    local real cooldownRemaining
    local real cooldownExpires
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if WGL_HasWarglaive(u) then
        call WGL_SyncAttackSpeed(u)
        if GetUnitAbilityLevel(u, 'A113') == 0 then
            call UnitAddAbility(u, 'A113')
            call UnitMakeAbilityPermanent(u, true, 'A113')
            set unitId = GetHandleId(u)
            set cooldownExpires = LoadReal(WGL_COOLDOWN_HT, unitId, 0)
            set cooldownRemaining = cooldownExpires - TimerGetElapsed(WGL_COOLDOWN_CLOCK)
            if cooldownRemaining > 0.0 then
                call BlzStartUnitAbilityCooldown(u, 'A113', cooldownRemaining)
            endif
            call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
        endif
    elseif GetUnitAbilityLevel(u, 'A113') > 0 then
        set unitId = GetHandleId(u)
        set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
        if cooldownRemaining > 0.0 then
            call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
        else
            call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
        endif
        call UnitRemoveAbility(u, 'A113')
    endif
endfunction

function WGL_DestroyTimedEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer id = GetHandleId(t)
    local effect fx = LoadEffectHandle(WGL_FX_HT, id, 0)
    if fx != null then
        call DestroyEffect(fx)
    endif
    call FlushChildHashtable(WGL_FX_HT, id)
    call DestroyTimer(t)
    set fx = null
    set t = null
endfunction

function WGL_ShowTimedEffect takes string path, real x, real y, real duration returns nothing
    local timer t = CreateTimer()
    local effect fx = AddSpecialEffect(path, x, y)
    call SaveEffectHandle(WGL_FX_HT, GetHandleId(t), 0, fx)
    call TimerStart(t, duration, false, function WGL_DestroyTimedEffect)
    set fx = null
    set t = null
endfunction

function WGL_ShowGrowthText takes unit u returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt, "埃辛诺斯战刃·邪魂淬炼：敏捷 +1", 0.023)
    call SetTextTagPosUnit(tt, u, 64.0)
    call SetTextTagColor(tt, 120, 255, 140, 255)
    call SetTextTagVelocity(tt, 0.0, 0.035)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.2)
    call SetTextTagFadepoint(tt, 0.8)
    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(u))
    set tt = null
endfunction

function WGL_OnGrowthAttack takes nothing returns nothing
    local unit attacker = GetEventDamageSource()
    local unit victim = GetTriggerUnit()
    local integer unitId
    local real now
    if attacker == null or GetUnitTypeId(attacker) == 0 then
        set attacker = null
        set victim = null
        return
    endif
    if not IsUnitType(attacker, UNIT_TYPE_HERO) or not WGL_HasWarglaive(attacker) then
        set attacker = null
        set victim = null
        return
    endif
    if victim == null or GetUnitTypeId(victim) == 0 or GetWidgetLife(victim) <= 0.405 then
        set attacker = null
        set victim = null
        return
    endif
    if not IsUnitEnemy(victim, GetOwningPlayer(attacker)) or IsUnitType(victim, UNIT_TYPE_STRUCTURE) or IsUnitType(victim, UNIT_TYPE_MECHANICAL) then
        set attacker = null
        set victim = null
        return
    endif
    if not BlzGetEventIsAttack() then
        set attacker = null
        set victim = null
        return
    endif
    set unitId = GetHandleId(attacker)
    set now = TimerGetElapsed(WGL_COOLDOWN_CLOCK)
    if now < LoadReal(WGL_GROWTH_HT, unitId, 0) then
        set attacker = null
        set victim = null
        return
    endif
    call SaveReal(WGL_GROWTH_HT, unitId, 0, now + WGL_GROWTH_ATTACK_GUARD)
    if GetRandomInt(1, 100) > WGL_GROWTH_CHANCE_PERCENT then
        set attacker = null
        set victim = null
        return
    endif
    call SetHeroAgi(attacker, GetHeroAgi(attacker, false) + 1, true)
    call WGL_SyncAttackSpeed(attacker)
    call WGL_ShowGrowthText(attacker)
    set attacker = null
    set victim = null
endfunction

function WGL_IsChargeTarget takes unit caster, unit target returns boolean
    if target == null or GetUnitTypeId(target) == 0 then
        return false
    endif
    if target == caster or GetWidgetLife(target) <= 0.405 then
        return false
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(caster)) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function WGL_RemoveStackAbilities takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if GetUnitAbilityLevel(u, 'A117') > 0 then
        call UnitMakeAbilityPermanent(u, false, 'A117')
        call UnitRemoveAbility(u, 'A117')
    endif
    if GetUnitAbilityLevel(u, 'A118') > 0 then
        call UnitMakeAbilityPermanent(u, false, 'A118')
        call UnitRemoveAbility(u, 'A118')
    endif
endfunction

function WGL_SyncInitialUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    call WGL_RemoveStackAbilities(u)
    call WGL_SyncUnit(u)
    set u = null
endfunction

function WGL_StackTick takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerId = GetHandleId(t)
    local integer unitId = LoadInteger(WGL_STACK_TIMER_HT, timerId, 0)
    local unit u = LoadUnitHandle(WGL_STACK_HT, unitId, 0)
    local real remaining
    if u == null or GetUnitTypeId(u) == 0 or GetWidgetLife(u) <= 0.405 then
        call WGL_RemoveStackAbilities(u)
        call FlushChildHashtable(WGL_STACK_TIMER_HT, timerId)
        call FlushChildHashtable(WGL_STACK_HT, unitId)
        call DestroyTimer(t)
    else
        set remaining = LoadReal(WGL_STACK_HT, unitId, 3) - 0.10
        if remaining <= 0.0 then
            call WGL_RemoveStackAbilities(u)
            call FlushChildHashtable(WGL_STACK_TIMER_HT, timerId)
            call FlushChildHashtable(WGL_STACK_HT, unitId)
            call DestroyTimer(t)
        else
            call SaveReal(WGL_STACK_HT, unitId, 3, remaining)
        endif
    endif
    set u = null
    set t = null
endfunction

function WGL_AddChargeStack takes unit u returns nothing
    local integer unitId = GetHandleId(u)
    local integer oldStacks = LoadInteger(WGL_STACK_HT, unitId, 2)
    local integer stacks = oldStacks + 1
    local timer t = LoadTimerHandle(WGL_STACK_HT, unitId, 1)
    if stacks > WGL_STACK_MAX then
        set stacks = WGL_STACK_MAX
    endif
    if GetUnitAbilityLevel(u, 'A117') == 0 then
        call UnitAddAbility(u, 'A117')
        call UnitMakeAbilityPermanent(u, true, 'A117')
    endif
    if GetUnitAbilityLevel(u, 'A118') == 0 then
        call UnitAddAbility(u, 'A118')
        call UnitMakeAbilityPermanent(u, true, 'A118')
    endif
    call BlzUnitHideAbility(u, 'A117', true)
    call BlzUnitHideAbility(u, 'A118', true)
    if GetUnitAbilityLevel(u, 'A117') != stacks then
        call SetUnitAbilityLevel(u, 'A117', stacks)
    endif
    if GetUnitAbilityLevel(u, 'A118') != 1 then
        call SetUnitAbilityLevel(u, 'A118', 1)
    endif
    call SaveUnitHandle(WGL_STACK_HT, unitId, 0, u)
    call SaveInteger(WGL_STACK_HT, unitId, 2, stacks)
    call SaveReal(WGL_STACK_HT, unitId, 3, WGL_STACK_DURATION)
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(WGL_STACK_HT, unitId, 1, t)
        call SaveInteger(WGL_STACK_TIMER_HT, GetHandleId(t), 0, unitId)
        call TimerStart(t, 0.10, true, function WGL_StackTick)
    endif
    set t = null
endfunction

function WGL_FinishCharge takes timer t returns nothing
    local integer timerId = GetHandleId(t)
    local integer unitId
    local unit caster = LoadUnitHandle(WGL_CHARGE_HT, timerId, 0)
    local group hitGroup = LoadGroupHandle(WGL_CHARGE_HT, timerId, 1)
    local real cooldownRemaining
    if caster != null and GetUnitTypeId(caster) != 0 then
        set unitId = GetHandleId(caster)
        if LoadTimerHandle(WGL_CASTER_HT, unitId, 0) == t then
            call FlushChildHashtable(WGL_CASTER_HT, unitId)
        endif
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
        call IssueImmediateOrder(caster, "stop")
        set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(caster, 'A113')
        if cooldownRemaining < 1.0 then
            call BlzStartUnitAbilityCooldown(caster, 'A113', WGL_CHARGE_COOLDOWN)
        endif
        call ResetUnitAnimation(caster)
    endif
    if hitGroup != null then
        call DestroyGroup(hitGroup)
    endif
    call FlushChildHashtable(WGL_CHARGE_HT, timerId)
    call DestroyTimer(t)
    set caster = null
    set hitGroup = null
endfunction

function WGL_ChargeTick takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerId = GetHandleId(t)
    local unit caster = LoadUnitHandle(WGL_CHARGE_HT, timerId, 0)
    local group hitGroup = LoadGroupHandle(WGL_CHARGE_HT, timerId, 1)
    local group candidates
    local unit victim
    local integer step = LoadInteger(WGL_CHARGE_HT, timerId, 2)
    local real startX = LoadReal(WGL_CHARGE_HT, timerId, 3)
    local real startY = LoadReal(WGL_CHARGE_HT, timerId, 4)
    local real angle = LoadReal(WGL_CHARGE_HT, timerId, 5)
    local real damage = LoadReal(WGL_CHARGE_HT, timerId, 6)
    local real chargeDistance = LoadReal(WGL_CHARGE_HT, timerId, 7)
    local real traveled
    local real x
    local real y
    if caster == null or GetUnitTypeId(caster) == 0 or GetWidgetLife(caster) <= 0.405 then
        call WGL_FinishCharge(t)
        set caster = null
        set hitGroup = null
        set t = null
        return
    endif
    if not IsUnitPaused(caster) or IsUnitType(caster, UNIT_TYPE_STUNNED) then
        call WGL_FinishCharge(t)
        set caster = null
        set hitGroup = null
        set t = null
        return
    endif
    set step = step + 1
    set traveled = I2R(step) * WGL_CHARGE_STEP
    if traveled > chargeDistance then
        set traveled = chargeDistance
    endif
    set x = startX + traveled * Cos(angle)
    set y = startY + traveled * Sin(angle)
    call SetUnitX(caster, x)
    call SetUnitY(caster, y)
    call SetUnitFacing(caster, angle * bj_RADTODEG)
    call WGL_ShowTimedEffect("StormfallRed.mdx", x, y, 0.55)
    set candidates = CreateGroup()
    call GroupEnumUnitsInRange(candidates, x, y, WGL_CHARGE_RADIUS, null)
    loop
        set victim = FirstOfGroup(candidates)
        exitwhen victim == null
        call GroupRemoveUnit(candidates, victim)
        if not IsUnitInGroup(victim, hitGroup) and WGL_IsChargeTarget(caster, victim) then
            call GroupAddUnit(hitGroup, victim)
            call WGL_AddChargeStack(caster)
            call UnitDamageTarget(caster, victim, damage, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
            call WGL_ShowTimedEffect("war3campImported\\DemonBoltImpactSilent.mdx", GetUnitX(victim), GetUnitY(victim), 0.8)
        endif
    endloop
    call DestroyGroup(candidates)
    call SaveInteger(WGL_CHARGE_HT, timerId, 2, step)
    if traveled >= chargeDistance then
        call WGL_FinishCharge(t)
    endif
    set candidates = null
    set victim = null
    set caster = null
    set hitGroup = null
    set t = null
endfunction

function WGL_OnChargePoint takes unit caster, real targetX, real targetY, boolean consumeMana returns nothing
    local integer unitId
    local integer timerId
    local timer previous
    local timer t
    local group hitGroup
    local real startX
    local real startY
    local real dx
    local real dy
    local real angle
    local real chargeDistance
    if caster == null or GetUnitTypeId(caster) == 0 or GetWidgetLife(caster) <= 0.405 then
        return
    endif
    if not WGL_HasWarglaive(caster) then
        return
    endif
    set unitId = GetHandleId(caster)
    set previous = LoadTimerHandle(WGL_CASTER_HT, unitId, 0)
    if previous != null then
        set previous = null
        return
    endif
    if consumeMana then
        if GetUnitState(caster, UNIT_STATE_MANA) < 70.0 then
            return
        endif
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - 70.0)
    endif
    call PlaySound("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.wav")
    set startX = GetUnitX(caster)
    set startY = GetUnitY(caster)
    set dx = targetX - startX
    set dy = targetY - startY
    if dx * dx + dy * dy < 1.0 then
        set angle = GetUnitFacing(caster) * bj_DEGTORAD
    else
        set angle = Atan2(dy, dx)
    endif
    set t = CreateTimer()
    set timerId = GetHandleId(t)
    set hitGroup = CreateGroup()
    call SaveUnitHandle(WGL_CHARGE_HT, timerId, 0, caster)
    call SaveGroupHandle(WGL_CHARGE_HT, timerId, 1, hitGroup)
    call SaveInteger(WGL_CHARGE_HT, timerId, 2, 0)
    call SaveReal(WGL_CHARGE_HT, timerId, 3, startX)
    call SaveReal(WGL_CHARGE_HT, timerId, 4, startY)
    call SaveReal(WGL_CHARGE_HT, timerId, 5, angle)
    call SaveReal(WGL_CHARGE_HT, timerId, 6, I2R(GetHeroAgi(caster, true)) * 3.0)
    set chargeDistance = RMinBJ(WGL_CHARGE_MAX_DISTANCE, WGL_CHARGE_BASE_DISTANCE + I2R(GetHeroAgi(caster, true)) * WGL_CHARGE_AGI_MULT)
    call SaveReal(WGL_CHARGE_HT, timerId, 7, chargeDistance)
    call SaveTimerHandle(WGL_CASTER_HT, unitId, 0, t)
    call SetUnitPathing(caster, false)
    call SetUnitFacing(caster, angle * bj_RADTODEG)
    call SetUnitAnimation(caster, "attack slam")
    call PauseUnit(caster, true)
    call BlzStartUnitAbilityCooldown(caster, 'A113', WGL_CHARGE_COOLDOWN)
    call TimerStart(t, WGL_CHARGE_INTERVAL, true, function WGL_ChargeTick)
    set previous = null
    set t = null
    set hitGroup = null
endfunction

function WGL_OnCharge takes nothing returns nothing
    if GetSpellAbilityId() != 'A113' then
        return
    endif
    call WGL_OnChargePoint(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), false)
endfunction

function WGL_OrderConditions takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local boolean matched
    set matched = caster != null and GetUnitTypeId(caster) != 0 and GetUnitAbilityLevel(caster, 'A113') > 0 and WGL_HasWarglaive(caster) and GetIssuedOrderId() == OrderId("channel")
    set caster = null
    return matched
endfunction

function WGL_OnChargeOrder takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real targetX
    local real targetY
    if not WGL_OrderConditions() then
        set caster = null
        return
    endif
    set targetX = GetOrderPointX()
    set targetY = GetOrderPointY()
    call IssueImmediateOrder(caster, "stop")
    call WGL_OnChargePoint(caster, targetX, targetY, true)
    set caster = null
endfunction

function WGL_OnItemEvent takes nothing returns nothing
    local unit u
    local item it
    local integer unitId
    local real cooldownRemaining
    set u = GetTriggerUnit()
    set it = GetManipulatedItem()
    if u == null or GetUnitTypeId(u) == 0 then
        set it = null
        set u = null
        return
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM and it != null and GetItemTypeId(it) == 'I106' then
        if GetUnitAbilityLevel(u, 'A113') > 0 then
            set unitId = GetHandleId(u)
            set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
            if cooldownRemaining > 0.0 then
                call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
            else
                call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
            endif
            call UnitRemoveAbility(u, 'A113')
        endif
        set it = null
        set u = null
        return
    endif
    call WGL_SyncUnit(u)
    set it = null
    set u = null
endfunction

function WGL_OnHeroLevel takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call WGL_SyncAttackSpeed(u)
    set u = null
endfunction

function WGL_Init takes nothing returns nothing
    local group initial
    local trigger itemTrigger
    if WGL_INITED then
        return
    endif
    set WGL_INITED = true
    set WGL_FX_HT = InitHashtable()
    set WGL_CHARGE_HT = InitHashtable()
    set WGL_CASTER_HT = InitHashtable()
    set WGL_STACK_HT = InitHashtable()
    set WGL_STACK_TIMER_HT = InitHashtable()
    set WGL_COOLDOWN_HT = InitHashtable()
    set WGL_GROWTH_HT = InitHashtable()
    set WGL_COOLDOWN_CLOCK = CreateTimer()
    call TimerStart(WGL_COOLDOWN_CLOCK, 8640000.0, false, function WGL_CooldownClockTick)
    set itemTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(itemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(itemTrigger, function WGL_OnItemEvent)
    set itemTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(itemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(itemTrigger, function WGL_OnItemEvent)
    set WGL_CAST_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_CAST_TRIGGER, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(WGL_CAST_TRIGGER, function WGL_OnCharge)
    set WGL_ORDER_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_ORDER_TRIGGER, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddAction(WGL_ORDER_TRIGGER, function WGL_OnChargeOrder)
    set WGL_GROWTH_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_GROWTH_TRIGGER, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddAction(WGL_GROWTH_TRIGGER, function WGL_OnGrowthAttack)
    set WGL_ATTACK_SPEED_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_ATTACK_SPEED_TRIGGER, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(WGL_ATTACK_SPEED_TRIGGER, function WGL_OnHeroLevel)
    set initial = CreateGroup()
    call GroupEnumUnitsInRect(initial, bj_mapInitialPlayableArea, null)
    call ForGroup(initial, function WGL_SyncInitialUnit)
    call DestroyGroup(initial)
    set initial = null
    set itemTrigger = null
endfunction
