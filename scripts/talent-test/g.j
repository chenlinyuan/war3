group TT_SCAN_GROUP = null
region TT_REGION = null
rect TT_RECT = null
trigger TT_ENTER_TRIGGER = null
trigger TT_TRAIN_TRIGGER = null
trigger TT_SELL_TRIGGER = null
trigger TT_DAMAGE_TRIGGER = null
trigger TT_LEVEL_TRIGGER = null
trigger TT_SKILL_TRIGGER = null
trigger TT_PANEL_TRIGGER = null
trigger TT_DEATH_TRIGGER = null
trigger TT_REVIVE_TRIGGER = null
trigger TT_DH_ORDER_TRIGGER = null
trigger TT_DH_MB_CAST_TRIGGER = null
trigger TT_DH_MB_EFFECT_TRIGGER = null
boolean TT_AOE_BUSY = false
hashtable TT_REVIVE_TABLE = null
hashtable TT_TALENT_UI_TABLE = null
hashtable TT_FX_TABLE = null
group TT_DH_GROUP = null
boolean TT_INITED = false
boolean TT_START_READY = false
boolean TT_MELEE_HERO_TALENTS = false
integer TT_HERO_COUNT = 0
unit array TT_HEROES
boolean array TT_RANGED_HERO
unit array TT_INCIN_TARGET
integer array TT_INCIN_STACKS
integer array TT_INCIN_LEVEL
real array TT_INCIN_EXPIRE
integer array TT_BARRAGE_GROUP_CACHE
integer array TT_BARRAGE_CURRENT
unit array TT_BREAKTHROUGH_TARGET
integer array TT_BREAKTHROUGH_STACKS
real array TT_BREAKTHROUGH_EXPIRE
boolean array TT_BACKPACK_ATTEMPTED
integer array TT_LEVEL_MARKERS
integer array TT_LEVEL_REQ
integer array TT_TALENT_MASK
integer array TT_EARNED_POINTS
integer array TT_TALENT_MASTER_LEVEL
integer array TT_AWARDED_MASK
boolean array TT_CAMPAIGN_NATIVE_PRESERVED
boolean array TT_CAMPAIGN_SNAPSHOT_PENDING
boolean TT_CAMPAIGN_STORE_RESULT = false
boolean TT_CAMPAIGN_SAVE_RESULT = false
gamecache TT_CAMPAIGN_AUDIT_CACHE = null
integer TT_CAMPAIGN_AUDIT_COUNT = 0
string array TT_CAMPAIGN_AUDIT_MISSIONS
string array TT_CAMPAIGN_AUDIT_KEYS
string array TT_CAMPAIGN_AUDIT_LABELS
integer array TT_PENDING_POINTS
boolean array TT_POINT_WAIT_CLEANUP
integer array TT_POINT_WAIT_TICKS
boolean array TT_POINT_USE_ACCEPTED
boolean array TT_POINT_GRANT_FAILED
integer array TT_POINT_GRANT_FAILED_LEVEL
integer array TT_POINT_VERIFY_POINTS
integer array TT_POINT_VERIFY_Q
item array TT_POINT_TOME_ITEMS
boolean array TT_CAMPAIGN_UI_REBUILD_PENDING
unit array TT_DH_MB_TARGET
real array TT_DH_MB_TARGET_MANA
boolean array TT_DH_MB_PENDING
boolean array TT_DH_IMMOLATION_ACTIVE
real array TT_DH_IMMOLATION_OFF_UNTIL
boolean array TT_DH_IMMO_COST_APPLIED
integer array TT_DH_IMMO_COST_LEVEL
real array TT_DH_IMMO_COST_MANA
real array TT_DH_IMMO_COST_ACTIVATE
boolean array TT_DH_BLADE_READY
real array TT_DH_BLADE_EXPIRE
boolean array TT_DH_AFTERIMAGE_ACTIVE
real array TT_DH_AFTERIMAGE_EXPIRE
real array TT_DH_AFTERIMAGE_BASE
unit array TT_DH_SLOW_TARGETS
real array TT_DH_SLOW_EXPIRE
real array TT_DH_SLOW_BASE_SPEED
real array TT_DH_SLOW_BASE_COOLDOWN
integer TT_DH_SLOW_COUNT = 0
real TT_DH_MB_EXTRA_RATIO = 1.00
real TT_DH_MB_VORTEX_MANA_RATIO = 0.50
real TT_DH_MB_VORTEX_LIFE_RATIO = 0.50
real TT_DH_MB_LOCK_SPEED_FACTOR = 0.70
real TT_DH_MB_LOCK_DURATION = 2.00
real TT_DH_IMMO_RADIUS = 320.00
real TT_DH_AFTERIMAGE_MULTIPLIER = 2.00
real TT_DH_AFTERIMAGE_DURATION = 3.00
real TT_DH_BLADE_MULTIPLIER = 1.50
real TT_DH_BLADE_DURATION = 3.00
timer TT_POINT_TIMER = null
integer TT_CAMPAIGN_CHAPTER = 1
integer TT_MAX_LEVEL = 10
integer TT_POINT_COUNT = 6
integer TT_LOG_SIZE = 1024
integer TT_LOG_COUNT = 0
integer TT_LOG_NEXT = 0
integer TT_LOG_SEQ = 0
string array TT_LOG_LINES
string TT_LOG_FILE = "ALAS-TalentLog.txt"
timer TT_LOG_CLOCK = null
