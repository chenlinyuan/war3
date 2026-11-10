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
boolean TT_AOE_BUSY = false
hashtable TT_REVIVE_TABLE = null
hashtable TT_RESTORE_TABLE = null
hashtable TT_FX_TABLE = null
boolean TT_INITED = false
boolean TT_START_READY = false
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
boolean array TT_CAMPAIGN_STATE_PENDING
unit array TT_CAMPAIGN_RESTORE_UNITS
gamecache array TT_CAMPAIGN_RESTORE_CACHES
integer TT_CAMPAIGN_RESTORE_COUNT = 0
gamecache TT_CAMPAIGN_CACHE = null
boolean TT_CAMPAIGN_CACHE_RELOADED = false
boolean array TT_CAMPAIGN_CACHE_LOADED
boolean array TT_CAMPAIGN_VERIFY_PENDING
integer array TT_PENDING_POINTS
boolean array TT_POINT_WAIT_CLEANUP
integer array TT_POINT_WAIT_TICKS
boolean array TT_POINT_USE_ACCEPTED
boolean array TT_POINT_GRANT_FAILED
integer array TT_POINT_GRANT_FAILED_LEVEL
boolean array TT_CAMPAIGN_POINTS_QUEUED
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
