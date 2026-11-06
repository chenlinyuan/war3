// Minimal Reforged stubs used only by the classic pjass syntax check.
constant native ConvertUnitRealField takes integer i returns integer

globals
    constant playerunitevent EVENT_PLAYER_UNIT_DAMAGED = ConvertPlayerUnitEvent(308)
    constant integer UNIT_IF_DEFENSE_TYPE = 0
    constant integer UNIT_RF_SCALING_VALUE = ConvertUnitRealField('usca')
    constant integer UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE = 0
    constant integer UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED = 1
    constant integer UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS = 2
    constant integer UNIT_WEAPON_RF_ATTACK_RANGE = 2
    constant integer UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED = 3
    constant integer UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN = 4
    constant integer UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_FULL_DAMAGE = 4
    constant integer UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_MEDIUM_DAMAGE = 5
    constant integer UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_SMALL_DAMAGE = 6
    constant integer UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM = 7
    constant integer UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL = 8
    constant integer UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART = 4
    constant integer UNIT_WEAPON_BF_ATTACKS_ENABLED = 5
    constant integer UNIT_WEAPON_BF_ATTACK_SHOW_UI = 6
endglobals

function ConvertLoadoutSlot takes integer i returns integer
    return i
endfunction

function ConvertUnitIntegerField takes integer i returns integer
    return i
endfunction

function ConvertUnitWeaponIntegerField takes integer i returns integer
    return i
endfunction

function ConvertUnitWeaponStringField takes integer i returns integer
    return i
endfunction

function ConvertAbilityRealLevelField takes integer i returns integer
    return i
endfunction

function ConvertAbilityIntegerLevelField takes integer i returns integer
    return i
endfunction

function BlzGetEventDamageTarget takes nothing returns unit
    return null
endfunction

function BlzGetEventIsAttack takes nothing returns boolean
    return false
endfunction

function BlzSetEventDamage takes real damage returns nothing
endfunction

function BlzGetUnitIntegerField takes unit whichUnit, integer whichField returns integer
    return 0
endfunction

function BlzGetUnitRealField takes unit whichUnit, integer whichField returns real
    return 0.0
endfunction

function BlzSetUnitRealField takes unit whichUnit, integer whichField, real value returns boolean
    return false
endfunction

function BlzSetUnitIntegerField takes unit whichUnit, integer whichField, integer value returns boolean
    return false
endfunction

function BlzGetUnitWeaponIntegerField takes unit whichUnit, integer whichField, integer index returns integer
    return 0
endfunction

function BlzSetUnitWeaponIntegerField takes unit whichUnit, integer whichField, integer index, integer value returns boolean
    return false
endfunction

function BlzGetUnitWeaponBooleanField takes unit whichUnit, integer whichField, integer index returns boolean
    return false
endfunction

function BlzSetUnitWeaponBooleanField takes unit whichUnit, integer whichField, integer index, boolean value returns boolean
    return false
endfunction

function BlzGetUnitWeaponRealField takes unit whichUnit, integer whichField, integer index returns real
    return 0.0
endfunction

function BlzSetUnitWeaponRealField takes unit whichUnit, integer whichField, integer index, real value returns boolean
    return false
endfunction

function BlzGetUnitWeaponStringField takes unit whichUnit, integer whichField, integer index returns string
    return ""
endfunction

function BlzSetUnitWeaponStringField takes unit whichUnit, integer whichField, integer index, string value returns boolean
    return false
endfunction

function BlzBitOr takes integer x, integer y returns integer
    return 0
endfunction

function BlzUnitItemInEquipmentSlot takes unit whichUnit, integer loadoutSlot returns item
    return null
endfunction

function BlzGetItemAbility takes item whichItem, integer abilCode returns ability
    return null
endfunction

function BlzSetAbilityRealLevelField takes ability whichAbility, integer whichField, integer level, real value returns boolean
    return false
endfunction

function BlzSetAbilityIntegerLevelField takes ability whichAbility, integer whichField, integer level, integer value returns boolean
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

function BlzResetUnitTalents takes unit whichUnit returns nothing
endfunction

