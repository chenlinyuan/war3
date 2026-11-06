globals
// Frostmourne item behavior
boolean FR_ITEM_ACTIVE = false
integer FR_ITEM_ID = 'I105'
integer FR_SPELL_ID = 'A105'
integer FR_NOVA_ABILITY = 'A170'
integer FR_SLOW_ABILITY = 'A171'
integer FR_NOVA_DUMMY = 'hfoo'
integer FR_NOVA_LIFE = 'BTLF'

trigger fr_spell_trigger = null
trigger fr_freeze_death_trigger = null
trigger fr_attack_trigger = null
trigger fr_pickup_trigger = null
trigger fr_drop_trigger = null
trigger fr_revive_trigger = null
trigger fr_soul_trigger = null
hashtable fr_freeze_table = null
hashtable fr_freeze_timer_table = null
hashtable fr_soul_source_table = null
hashtable fr_soul_timer_table = null
hashtable fr_cooldown_table = null
hashtable fr_active_fx_table = null
hashtable fr_cast_guard_table = null
integer fr_ground_count = 0
item array fr_ground_items
integer array fr_ground_keys
effect array fr_ground_effects
real array fr_ground_x
real array fr_ground_y
hashtable fr_ground_table = null
rect fr_world = null
timer fr_ground_timer = null
timer fr_clock = null

boolean fr_inited = false

real FR_SPELL_RADIUS = 750.0
real FR_RING_CORE_RADIUS = 300.0
real FR_RING_MID_RADIUS = 550.0
real FR_FREEZE_CORE = 6.0
real FR_FREEZE_MID = 4.0
real FR_FREEZE_OUTER = 2.0
real FR_SLOW_CORE = 3.0
real FR_SLOW_MID = 2.0
real FR_SLOW_OUTER = 1.0
real FR_DAMAGE_CORE_MULT = 1.0
real FR_DAMAGE_MID_MULT = 0.7
real FR_DAMAGE_OUTER_MULT = 0.4
real FR_SPELL_STAT_MULT = 4.0
real FR_NOVA_CHANCE = 0.30
real FR_ACTIVE_LIFE_COST = 0.20
real FR_ACTIVE_MANA_COST = 100.0
real FR_ACTIVE_COOLDOWN = 10.0
real FR_CAST_GUARD_SECONDS = 9.5
real FR_SOUL_NORMAL_CHANCE = 0.05
real FR_SOUL_HERO_CHANCE = 0.50

endglobals
function FR_GetEquippedItem takes unit u returns item
    local item it
    if u == null or GetUnitTypeId(u) == 0 then
        return null
    endif
    if FR_ITEM_ACTIVE then
        set it = BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(8))
        if it != null and GetItemTypeId(it) == FR_ITEM_ID then
            return it
        endif
        return null
    endif
    return GetItemOfTypeFromUnitBJ(u, FR_ITEM_ID)
endfunction

function FR_HasItem takes unit u returns boolean
    local item it = FR_GetEquippedItem(u)
    local boolean found = it != null
    set it = null
    return found
endfunction

function FR_NoOp takes nothing returns nothing
endfunction

function FR_IsSoulTarget takes unit killer, unit victim returns boolean
    local integer ownerId
    if killer == null or victim == null then
        return false
    endif
    if GetUnitTypeId(victim) == 0 then
        return false
    endif
    if IsUnitType(victim, UNIT_TYPE_STRUCTURE) or IsUnitType(victim, UNIT_TYPE_MECHANICAL) then
        return false
    endif
    if IsUnitType(victim, UNIT_TYPE_SUMMONED) or IsUnitIllusion(victim) then
        return false
    endif
    set ownerId = GetPlayerId(GetOwningPlayer(victim))
    if ownerId == PLAYER_NEUTRAL_PASSIVE then
        return false
    endif
    if IsUnitEnemy(victim, GetOwningPlayer(killer)) then
        return true
    endif
    return ownerId == PLAYER_NEUTRAL_AGGRESSIVE
endfunction

function FR_ClearNovaSoulSource takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerKey = GetHandleId(t)
    local integer unitKey = LoadInteger(fr_soul_timer_table, timerKey, 0)
    call FlushChildHashtable(fr_soul_source_table, unitKey)
    call FlushChildHashtable(fr_soul_timer_table, timerKey)
    call DestroyTimer(t)
    set t = null
endfunction

function FR_TrackNovaSoulSource takes unit source, unit dummy returns nothing
    local timer t
    if source == null or dummy == null then
        return
    endif
    set t = CreateTimer()
    call SaveUnitHandle(fr_soul_source_table, GetHandleId(dummy), 0, source)
    call SaveInteger(fr_soul_timer_table, GetHandleId(t), 0, GetHandleId(dummy))
    call TimerStart(t, 1.2, false, function FR_ClearNovaSoulSource)
    set t = null
endfunction

function FR_ShowSoulGain takes unit source returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt, "霜之哀伤·噬魂：力量 +1", 0.023)
    call SetTextTagPosUnit(tt, source, 96.0)
    call SetTextTagColor(tt, 157, 92, 255, 255)
    call SetTextTagVelocity(tt, 0.0, 0.035)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.6)
    call SetTextTagFadepoint(tt, 1.1)
    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(source))
    set tt = null
endfunction

function FR_OnSoulDeath takes nothing returns nothing
    local unit victim = GetDyingUnit()
    local unit killer = GetKillingUnit()
    local unit source = killer
    if killer == null or victim == null then
        set victim = null
        set killer = null
        set source = null
        return
    endif
    if not FR_HasItem(source) then
        set source = LoadUnitHandle(fr_soul_source_table, GetHandleId(killer), 0)
    endif
    if source == null or not IsUnitType(source, UNIT_TYPE_HERO) or not FR_HasItem(source) then
        set victim = null
        set killer = null
        set source = null
        return
    endif
    if not FR_IsSoulTarget(source, victim) then
        set victim = null
        set killer = null
        set source = null
        return
    endif
    if IsUnitType(victim, UNIT_TYPE_HERO) then
        if GetRandomReal(0.0, 1.0) > FR_SOUL_HERO_CHANCE then
            set victim = null
            set killer = null
            set source = null
            return
        endif
    elseif GetRandomReal(0.0, 1.0) > FR_SOUL_NORMAL_CHANCE then
        set victim = null
        set killer = null
        set source = null
        return
    endif
    call SetHeroStr(source, GetHeroStr(source, false) + 1, true)
    call FR_ShowSoulGain(source)
    set victim = null
    set killer = null
    set source = null
endfunction

function FR_OnAttack takes nothing returns nothing
    local unit attacker = GetAttacker()
    local unit victim = GetTriggerUnit()
    local unit dummy
    if attacker == null or victim == null then
        set attacker = null
        set victim = null
        return
    endif
    if not FR_HasItem(attacker) then
        set attacker = null
        set victim = null
        return
    endif
    if IsUnitType(victim, UNIT_TYPE_STRUCTURE) or IsUnitType(victim, UNIT_TYPE_MAGIC_IMMUNE) then
        set attacker = null
        set victim = null
        return
    endif
    if GetRandomReal(0.0, 1.0) > FR_NOVA_CHANCE then
        set attacker = null
        set victim = null
        return
    endif
    // 用官方霜冻新星的马甲施法方式。A170 是 AUfn 的无耗魔、无冷却副本，
    // 伤害、减速和视觉均继承官方能力。
    set dummy = CreateUnit(GetOwningPlayer(attacker), FR_NOVA_DUMMY, GetUnitX(victim), GetUnitY(victim), 0.0)
    call UnitAddAbility(dummy, 'Aloc')
    call SetUnitScale(dummy, 0.01, 0.01, 0.01)
    call SetUnitVertexColor(dummy, 255, 255, 255, 0)
    call UnitAddAbility(dummy, FR_NOVA_ABILITY)
    call FR_TrackNovaSoulSource(attacker, dummy)
    call IssueTargetOrder(dummy, "frostnova", victim)
    call UnitApplyTimedLife(dummy, FR_NOVA_LIFE, 1.0)
    set attacker = null
    set victim = null
    set dummy = null
endfunction

function FR_SyncAbility takes unit u returns nothing
    local integer key
    local real cooldown
    local real expires
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if FR_ITEM_ACTIVE then
        return
    endif
    set key = GetHandleId(u)
    if FR_HasItem(u) then
        if GetUnitAbilityLevel(u, FR_SPELL_ID) == 0 then
            call UnitAddAbility(u, FR_SPELL_ID)
            call UnitMakeAbilityPermanent(u, true, FR_SPELL_ID)
            set expires = LoadReal(fr_cooldown_table, key, 0)
            set cooldown = expires - TimerGetElapsed(fr_clock)
            if cooldown > 0.0 then
                call BlzStartUnitAbilityCooldown(u, FR_SPELL_ID, cooldown)
            endif
            call FlushChildHashtable(fr_cooldown_table, key)
        endif
        call BlzUnitDisableAbility(u, FR_SPELL_ID, false, false)
    elseif GetUnitAbilityLevel(u, FR_SPELL_ID) > 0 then
        set cooldown = BlzGetUnitAbilityCooldownRemaining(u, FR_SPELL_ID)
        if cooldown > 0.0 then
            call SaveReal(fr_cooldown_table, key, 0, TimerGetElapsed(fr_clock) + cooldown)
        else
            call FlushChildHashtable(fr_cooldown_table, key)
        endif
        call UnitRemoveAbility(u, FR_SPELL_ID)
    endif
endfunction

function FR_InitialAbilityUnit takes nothing returns nothing
    call FR_SyncAbility(GetEnumUnit())
endfunction

function FR_OnHeroRevive takes nothing returns nothing
    local unit u = GetRevivingUnit()
    call FR_SyncAbility(u)
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
            set fr_ground_x[last] = 0.0
            set fr_ground_y[last] = 0.0
            set fr_ground_count = last
            return
        endif
        set i = i + 1
    endloop
endfunction

function FR_OnItemPickup takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call FR_RemoveItemAura(GetManipulatedItem())
    call FR_SyncAbility(u)
    set u = null
endfunction

function FR_OnItemDrop takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local item it = GetManipulatedItem()
    local integer key
    local real cooldown
    if not FR_ITEM_ACTIVE and u != null and it != null and GetItemTypeId(it) == FR_ITEM_ID then
        if GetUnitAbilityLevel(u, FR_SPELL_ID) > 0 then
            set key = GetHandleId(u)
            set cooldown = BlzGetUnitAbilityCooldownRemaining(u, FR_SPELL_ID)
            if cooldown > 0.0 then
                call SaveReal(fr_cooldown_table, key, 0, TimerGetElapsed(fr_clock) + cooldown)
            else
                call FlushChildHashtable(fr_cooldown_table, key)
            endif
            call UnitRemoveAbility(u, FR_SPELL_ID)
        endif
        set it = null
        set u = null
        return
    endif
    call FR_SyncAbility(u)
    set it = null
    set u = null
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
            // A-click may invalidate the item before the next scan. Use the
            // effect handle saved in our own table instead of asking the dead
            // item handle for its type ID.
            set key = fr_ground_keys[i]
            set fx = fr_ground_effects[i]
            if fx != null then
                call DestroyEffect(fx)
            endif
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
            set fr_ground_x[last] = 0.0
            set fr_ground_y[last] = 0.0
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

function FR_CreateFreezeFx takes unit u returns nothing
    local integer unitKey = GetHandleId(u)
    local effect fx = AddSpecialEffectTarget("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl", u, "origin")
    if fx != null then
        call SaveEffectHandle(fr_freeze_table, unitKey, 1, fx)
    endif
    set fx = null
endfunction

function FR_DestroyFreezeFx takes integer unitKey returns nothing
    local effect fx
    if HaveSavedHandle(fr_freeze_table, unitKey, 1) then
        set fx = LoadEffectHandle(fr_freeze_table, unitKey, 1)
        if fx != null then
            call DestroyEffect(fx)
        endif
    endif
    set fx = null
endfunction

function FR_IsAliveTarget takes unit u returns boolean
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    if GetWidgetLife(u) <= 0.405 then
        return false
    endif
    return not IsUnitType(u, UNIT_TYPE_DEAD)
endfunction

function FR_IsInvulnerable takes unit u returns boolean
    if u == null then
        return false
    endif
    if BlzIsUnitInvulnerable(u) then
        return true
    endif
    return GetUnitAbilityLevel(u, 'Avul') > 0
endfunction

function FR_ApplySlow takes player owner, unit target, integer level returns nothing
    local unit dummy
    local real x
    local real y
    if owner == null or not FR_IsAliveTarget(target) then
        return
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return
    endif
    set x = GetUnitX(target)
    set y = GetUnitY(target)
    set dummy = CreateUnit(owner, FR_NOVA_DUMMY, x, y, 0.0)
    call UnitAddAbility(dummy, 'Aloc')
    call SetUnitScale(dummy, 0.01, 0.01, 0.01)
    call SetUnitVertexColor(dummy, 255, 255, 255, 0)
    call UnitAddAbility(dummy, FR_SLOW_ABILITY)
    call SetUnitAbilityLevel(dummy, FR_SLOW_ABILITY, level)
    call IssueTargetOrder(dummy, "slow", target)
    call UnitApplyTimedLife(dummy, FR_NOVA_LIFE, 1.0)
    set dummy = null
endfunction

function FR_Unfreeze takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerKey = GetHandleId(t)
    local integer unitKey = LoadInteger(fr_freeze_timer_table, timerKey, 1)
    local unit u = LoadUnitHandle(fr_freeze_timer_table, timerKey, 0)
    call FR_DestroyFreezeFx(unitKey)
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

function FR_FreezeUnit takes unit u, real duration returns nothing
    local integer unitKey
    local integer timerKey
    local timer t
    if not FR_IsAliveTarget(u) or FR_IsInvulnerable(u) then
        return
    endif
    if IsUnitType(u, UNIT_TYPE_FLYING) then
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
        call FR_CreateFreezeFx(u)
    endif
    call TimerStart(t, duration, false, function FR_Unfreeze)
    set t = null
endfunction

function FR_OnFrozenDeath takes nothing returns nothing
    local unit u = GetDyingUnit()
    local integer unitKey
    local timer t
    if u == null then
        return
    endif
    set unitKey = GetHandleId(u)
    if not HaveSavedHandle(fr_freeze_table, unitKey, 0) then
        set u = null
        return
    endif
    set t = LoadTimerHandle(fr_freeze_table, unitKey, 0)
    call PauseUnit(u, false)
    call SetUnitTimeScale(u, 1.0)
    call FR_DestroyFreezeFx(unitKey)
    if t != null then
        call FlushChildHashtable(fr_freeze_timer_table, GetHandleId(t))
        call DestroyTimer(t)
    endif
    call FlushChildHashtable(fr_freeze_table, unitKey)
    set t = null
    set u = null
endfunction

function FR_CanAffect takes unit caster, unit target returns boolean
    local integer ownerId
    if caster == null or not FR_IsAliveTarget(target) then
        return false
    endif
    if FR_IsInvulnerable(target) then
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

function FR_PayActiveLife takes unit u returns nothing
    local real currentLife
    local real cost
    if u == null then
        return
    endif
    set currentLife = GetUnitState(u, UNIT_STATE_LIFE)
    set cost = RMinBJ(RMaxBJ(1.0, currentLife * FR_ACTIVE_LIFE_COST), RMaxBJ(0.0, currentLife - 1.0))
    if cost <= 0.0 then
        return
    endif
    call SetUnitState(u, UNIT_STATE_LIFE, currentLife - cost)
endfunction

function FR_DestroyTimedEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerKey = GetHandleId(t)
    local effect fx = LoadEffectHandle(fr_active_fx_table, timerKey, 0)
    if fx != null then
        call DestroyEffect(fx)
    endif
    call FlushChildHashtable(fr_active_fx_table, timerKey)
    call DestroyTimer(t)
    set fx = null
    set t = null
endfunction

function FR_ShowTimedEffect takes string path, real x, real y, real duration returns nothing
    local timer t = CreateTimer()
    local effect fx = AddSpecialEffect(path, x, y)
    call SaveEffectHandle(fr_active_fx_table, GetHandleId(t), 0, fx)
    call TimerStart(t, duration, false, function FR_DestroyTimedEffect)
    set fx = null
    set t = null
endfunction

function FR_CastStomp takes unit caster returns nothing
    local group g
    local unit target
    local real x
    local real y
    local real bonus
    local real dx
    local real dy
    local real distance
    local real damageFactor
    local real freeze_duration
    local integer slowLevel
    if caster == null or not FR_HasItem(caster) then
        set caster = null
        return
    endif
    set x = GetUnitX(caster)
    set y = GetUnitY(caster)
    set bonus = 100.0 + I2R(GetHeroStr(caster, true)) * FR_SPELL_STAT_MULT
    if bonus <= 0.0 then
        set caster = null
        return
    endif
    call FR_PayActiveLife(caster)
    call SetUnitAnimation(caster, "stand")
    call FR_ShowTimedEffect("war3campImported\\IceStompRaised.mdx", x, y, 1.5)
    call TriggerSleepAction(0.05)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, FR_SPELL_RADIUS, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        if target != caster and IsUnitAliveBJ(target) and FR_CanAffect(caster, target) then
            set dx = GetUnitX(target) - x
            set dy = GetUnitY(target) - y
            set distance = SquareRoot(dx * dx + dy * dy)
            if distance <= FR_RING_CORE_RADIUS then
                set freeze_duration = FR_FREEZE_CORE
                set slowLevel = 3
                set damageFactor = FR_DAMAGE_CORE_MULT
            elseif distance <= FR_RING_MID_RADIUS then
                set freeze_duration = FR_FREEZE_MID
                set slowLevel = 2
                set damageFactor = FR_DAMAGE_MID_MULT
            else
                set freeze_duration = FR_FREEZE_OUTER
                set slowLevel = 1
                set damageFactor = FR_DAMAGE_OUTER_MULT
            endif
            if IsUnitType(target, UNIT_TYPE_FLYING) then
                call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)
            else
                if not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
                    call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)
                endif
                call FR_FreezeUnit(target, freeze_duration)
            endif
            if not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
                call UnitDamageTarget(caster, target, bonus * damageFactor, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif
        endif
        call GroupRemoveUnit(g, target)
    endloop
    call DestroyGroup(g)
    set g = null
    set target = null
    set caster = null
endfunction

function FR_OnStompCast takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer unitKey
    local real now
    if GetSpellAbilityId() != FR_SPELL_ID then
        return
    endif
    if caster == null or not FR_HasItem(caster) then
        set caster = null
        return
    endif
    set unitKey = GetHandleId(caster)
    set now = TimerGetElapsed(fr_clock)
    if now < LoadReal(fr_cast_guard_table, unitKey, 0) then
        set caster = null
        return
    endif
    call SaveReal(fr_cast_guard_table, unitKey, 0, TimerGetElapsed(fr_clock) + FR_CAST_GUARD_SECONDS)
    call FR_CastStomp(caster)
    set caster = null
endfunction

function FR_Init takes nothing returns nothing
    local integer i = 0
    local group initialGroup
    if fr_inited then
        return
    endif
    set fr_inited = true
    set fr_freeze_table = InitHashtable()
    set fr_freeze_timer_table = InitHashtable()
    set fr_soul_source_table = InitHashtable()
    set fr_soul_timer_table = InitHashtable()
    set fr_cooldown_table = InitHashtable()
    set fr_active_fx_table = InitHashtable()
    set fr_cast_guard_table = InitHashtable()
    set fr_clock = CreateTimer()
    call TimerStart(fr_clock, 8640000.0, false, function FR_NoOp)
    set fr_world = GetWorldBounds()
    set fr_ground_table = InitHashtable()
    set fr_pickup_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_pickup_trigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(fr_pickup_trigger, function FR_OnItemPickup)
    set fr_drop_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_drop_trigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(fr_drop_trigger, function FR_OnItemDrop)
    set fr_revive_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_revive_trigger, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddAction(fr_revive_trigger, function FR_OnHeroRevive)
    set fr_ground_timer = CreateTimer()
    call TimerStart(fr_ground_timer, 0.25, true, function FR_GroundAuraStep)

    set fr_attack_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_attack_trigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(fr_attack_trigger, function FR_OnAttack)

    set fr_spell_trigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(fr_spell_trigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerRegisterAnyUnitEventBJ(fr_spell_trigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(fr_spell_trigger, function FR_OnStompCast)

    set fr_freeze_death_trigger = CreateTrigger()
    set i = 0
    loop
        exitwhen i >= 16
        call TriggerRegisterPlayerUnitEvent(fr_freeze_death_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
        set i = i + 1
    endloop
    call TriggerAddAction(fr_freeze_death_trigger, function FR_OnFrozenDeath)

    set fr_soul_trigger = CreateTrigger()
    set i = 0
    loop
        exitwhen i >= 12
        call TriggerRegisterPlayerUnitEvent(fr_soul_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
        set i = i + 1
    endloop
    call TriggerRegisterPlayerUnitEvent(fr_soul_trigger, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddAction(fr_soul_trigger, function FR_OnSoulDeath)

    set initialGroup = CreateGroup()
    call GroupEnumUnitsInRect(initialGroup, bj_mapInitialPlayableArea, null)
    call ForGroup(initialGroup, function FR_InitialAbilityUnit)
    call DestroyGroup(initialGroup)
    set initialGroup = null
endfunction

function main takes nothing returns nothing
call FR_Init()

endfunction
