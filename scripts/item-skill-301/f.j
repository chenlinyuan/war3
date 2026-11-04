function WPN_HighestStat takes unit u returns integer
    local integer best
    local integer value
    if u == null or not IsUnitType(u, UNIT_TYPE_HERO) then
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

function WPN_OnPlunder takes nothing returns nothing
    local unit killer = GetKillingUnitBJ()
    local unit victim = GetTriggerUnit()
    local integer level
    local integer roll
    local integer gold
    local texttag tag
    if killer == null or victim == null then
        set killer = null
        set victim = null
        return
    endif
    if not UnitHasItemOfTypeBJ(killer, WPN_HAND_ITEM) then
        set killer = null
        set victim = null
        return
    endif
    if IsUnitIllusionBJ(killer) or IsUnitIllusionBJ(victim) or IsUnitType(victim, UNIT_TYPE_SUMMONED) then
        set killer = null
        set victim = null
        return
    endif
    if IsUnitAlly(victim, GetOwningPlayer(killer)) then
        set killer = null
        set victim = null
        return
    endif
    if GetUnitState(victim, UNIT_STATE_MAX_LIFE) < 300.0 then
        set killer = null
        set victim = null
        return
    endif
    set level = IMaxBJ(GetUnitLevel(victim), 1)
    set roll = GetRandomInt(1, level)
    if IsUnitType(victim, UNIT_TYPE_HERO) then
        set gold = (150 + level * 10 + roll * 5) / 3
    else
        set gold = (15 + level * 2 + roll * 2) / 3
    endif
    if gold < 1 then
        set gold = 1
    endif
    call AdjustPlayerStateBJ(gold, GetOwningPlayer(killer), PLAYER_STATE_RESOURCE_GOLD)
    set tag = CreateTextTag()
    call SetTextTagText(tag, "掠夺+" + I2S(gold), 0.023)
    call SetTextTagPos(tag, GetUnitX(victim), GetUnitY(victim), 150.0)
    call SetTextTagVelocity(tag, 0.0, 0.035)
    call SetTextTagColor(tag, 255, 255, 77, 255)
    call SetTextTagPermanent(tag, false)
    call SetTextTagLifespan(tag, 1.0)
    call SetTextTagFadepoint(tag, 0.75)
    set tag = null
    set killer = null
    set victim = null
endfunction

function WPN_OnFinger takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer stat
    local real damage
    if caster == null or target == null then
        set caster = null
        set target = null
        return
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(caster)) then
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 5.0, "|cffcc00ff[死亡之指]|r 只能对敌方单位使用。")
        set caster = null
        set target = null
        return
    endif
    set stat = WPN_HighestStat(caster)
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set damage = I2R(stat) * WPN_FINGER_HERO_MULT
    else
        set damage = I2R(stat) * WPN_FINGER_OTHER_MULT
    endif
    if damage < 1.0 then
        set damage = 1.0
    endif
    call UnitDamageTarget(caster, target, damage, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    set caster = null
    set target = null
endfunction

function WPN_OnSpell takes nothing returns nothing
    if GetSpellAbilityId() == WPN_HAND_SPELL then
        call WPN_OnFinger()
    endif
endfunction

function WPN_Init takes nothing returns nothing
    local trigger t
    if WPN_INITED then
        return
    endif
    set WPN_INITED = true
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function WPN_OnPlunder)
    set WPN_DEATH_TRIGGER = t
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function WPN_OnSpell)
    set WPN_SPELL_TRIGGER = t
    set t = null
endfunction
