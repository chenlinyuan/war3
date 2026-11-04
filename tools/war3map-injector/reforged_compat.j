// Minimal Reforged stubs used only by the classic pjass syntax check.
globals
    constant playerunitevent EVENT_PLAYER_UNIT_DAMAGED = ConvertPlayerUnitEvent(308)
endglobals

function BlzGetEventDamageTarget takes nothing returns unit
    return null
endfunction

function BlzGetEventIsAttack takes nothing returns boolean
    return false
endfunction

function BlzIsUnitInvulnerable takes unit whichUnit returns boolean
    return false
endfunction

function BlzUnitHideAbility takes unit whichUnit, integer abilId, boolean flag returns nothing
endfunction

function BlzUnitDisableAbility takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
endfunction

function BlzStartUnitAbilityCooldown takes unit whichUnit, integer abilCode, real cooldown returns nothing
endfunction

function BlzGetUnitAbilityCooldownRemaining takes unit whichUnit, integer abilId returns real
    return 0.0
endfunction

function BlzSetSpecialEffectScale takes effect whichEffect, real scale returns nothing
endfunction

function BlzSetSpecialEffectYaw takes effect whichEffect, real yaw returns nothing
endfunction

function BlzSetSpecialEffectZ takes effect whichEffect, real z returns nothing
endfunction

function BlzGetUnitCollisionSize takes unit whichUnit returns real
    return 0.0
endfunction

function BlzCreateItemWithSkin takes integer itemid, real x, real y, integer skinId returns item
    return null
endfunction

function BlzCreateUnitWithSkin takes integer id, player whichPlayer, real x, real y, real face, integer skinId returns unit
    return null
endfunction

