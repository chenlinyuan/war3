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
