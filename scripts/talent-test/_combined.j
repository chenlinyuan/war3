globals
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

endglobals
function TT_IsLiveHero takes unit u returns boolean
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    return IsUnitType(u, UNIT_TYPE_HERO) and GetHeroLevel(u) > 0
endfunction

function TT_IsTalentHero takes unit u returns boolean
    local player p
    if not TT_IsLiveHero(u) then
        return false
    endif
    set p = GetOwningPlayer(u)
    return GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING
endfunction

function TT_NoOp takes nothing returns nothing
endfunction

function TT_LogAppend takes string line returns nothing
    local integer slot = 0
    set TT_LOG_SEQ = TT_LOG_SEQ + 1
    set slot = ModuloInteger(TT_LOG_NEXT, TT_LOG_SIZE)
    set TT_LOG_LINES[slot] = "[TALENT " + I2S(TT_LOG_SEQ) + "] t=" + R2S(TimerGetElapsed(TT_LOG_CLOCK)) + " " + line
    set TT_LOG_NEXT = ModuloInteger(TT_LOG_NEXT + 1, TT_LOG_SIZE)
    if TT_LOG_COUNT < TT_LOG_SIZE then
        set TT_LOG_COUNT = TT_LOG_COUNT + 1
    endif
endfunction

function TT_LogFlush takes nothing returns nothing
    local integer i = 0
    local integer start = 0
    if TT_LOG_COUNT <= 0 then
        return
    endif
    set start = TT_LOG_NEXT - TT_LOG_COUNT
    if start < 0 then
        set start = start + TT_LOG_SIZE
    endif
    call PreloadGenClear()
    call PreloadGenStart()
    loop
        exitwhen i >= TT_LOG_COUNT
        call Preload(TT_LOG_LINES[ModuloInteger(start + i, TT_LOG_SIZE)])
        set i = i + 1
    endloop
    call PreloadGenEnd(TT_LOG_FILE)
endfunction

function TT_TalentId takes integer heroIndex returns integer
    return 'Q000' + (heroIndex / 10) * 256 + (heroIndex - (heroIndex / 10) * 10)
endfunction

function TT_BackpackId takes integer heroIndex returns integer
    return 'Z000' + (heroIndex / 10) * 256 + (heroIndex - (heroIndex / 10) * 10)
endfunction

function TT_SavedBackpackIndex takes unit u returns integer
    local integer heroIndex = 0
    local integer slot = 0
    local item it
    loop
        exitwhen heroIndex >= 64
        set slot = 0
        loop
            exitwhen slot > 5
            set it = UnitItemInSlot(u, slot)
            if it != null then
                if GetItemTypeId(it) == TT_BackpackId(heroIndex) then
                    set it = null
                    return heroIndex
                endif
            endif
            set slot = slot + 1
        endloop
        set heroIndex = heroIndex + 1
    endloop
    set it = null
    return -1
endfunction

function TT_RegisterHeroCore takes unit u, boolean allowNew returns integer
    local integer i = 0
    local integer savedIndex = -1
    if not TT_IsTalentHero(u) then
        return -1
    endif
    if TT_HERO_COUNT > 64 then
        set TT_HERO_COUNT = 64
    endif
    loop
        exitwhen i >= TT_HERO_COUNT
        if TT_HEROES[i] == u then
            return i
        endif
        if TT_HEROES[i] != null and GetUnitTypeId(TT_HEROES[i]) == 0 then
            set TT_HEROES[i] = null
            set TT_BACKPACK_ATTEMPTED[i] = false
            set TT_POINT_GRANT_FAILED[i] = false
            set TT_POINT_GRANT_FAILED_LEVEL[i] = 0
        endif
        set i = i + 1
    endloop
    set savedIndex = TT_SavedBackpackIndex(u)
    if savedIndex >= 0 and TT_HEROES[savedIndex] == null then
        set TT_HEROES[savedIndex] = u
        set TT_BACKPACK_ATTEMPTED[savedIndex] = true
        set TT_POINT_GRANT_FAILED[savedIndex] = false
        set TT_POINT_GRANT_FAILED_LEVEL[savedIndex] = 0
        if TT_HERO_COUNT <= savedIndex then
            set TT_HERO_COUNT = savedIndex + 1
        endif
        return savedIndex
    endif
    if not allowNew then
        return -1
    endif
    set i = 0
    loop
        exitwhen i >= 64
        if TT_HEROES[i] == null then
            set TT_HEROES[i] = u
            set TT_BACKPACK_ATTEMPTED[i] = false
            set TT_POINT_GRANT_FAILED[i] = false
            set TT_POINT_GRANT_FAILED_LEVEL[i] = 0
            if TT_HERO_COUNT <= i then
                set TT_HERO_COUNT = i + 1
            endif
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function TT_RegisterHero takes unit u returns integer
    return TT_RegisterHeroCore(u, false)
endfunction

function TT_RegisteredHeroIndex takes unit u returns integer
    local integer i = 0
    if u == null then
        return -1
    endif
    loop
        exitwhen i >= TT_HERO_COUNT or i >= 64
        if TT_HEROES[i] == u then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function TT_IsCampaignRestoreQueued takes unit u returns boolean
    local integer i = 0
    if u == null then
        return false
    endif
    loop
        exitwhen i >= TT_CAMPAIGN_RESTORE_COUNT or i >= 64
        if TT_CAMPAIGN_RESTORE_UNITS[i] == u then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function TT_InventoryCount takes unit u, integer itemId returns integer
    local integer i = 0
    local integer count = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == itemId then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    set it = null
    return count
endfunction

function TT_FreeInventorySlots takes unit u returns integer
    local integer i = 0
    local integer count = 0
    loop
        exitwhen i > 5
        if UnitItemInSlot(u, i) == null then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    return count
endfunction

function TT_LevelWeight takes integer index returns integer
    local integer weight = 1
    local integer i = 0
    loop
        exitwhen i >= index
        set weight = weight * 2
        set i = i + 1
    endloop
    return weight
endfunction

function TT_IsAwarded takes integer heroIndex, integer index returns boolean
    local integer weight = TT_LevelWeight(index)
    local integer value = TT_AWARDED_MASK[heroIndex] / weight
    return value - (value / 2) * 2 == 1
endfunction

function TT_MarkAwarded takes integer heroIndex, integer index returns nothing
    if not TT_IsAwarded(heroIndex, index) then
        set TT_AWARDED_MASK[heroIndex] = TT_AWARDED_MASK[heroIndex] + TT_LevelWeight(index)
    endif
endfunction

function TT_AwardedCount takes integer heroIndex returns integer
    local integer i = 0
    local integer count = 0
    loop
        exitwhen i >= TT_POINT_COUNT
        if TT_IsAwarded(heroIndex, i) then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    return count
endfunction

function TT_MarkAwardedToCount takes integer heroIndex, integer count returns nothing
    local integer i = 0
    loop
        exitwhen i >= count or i >= TT_POINT_COUNT
        call TT_MarkAwarded(heroIndex, i)
        set i = i + 1
    endloop
endfunction

function TT_SyncAwardedFromMarkers takes unit u returns integer
    local integer heroIndex = TT_RegisterHero(u)
    local integer i = 0
    local integer count = 0
    if heroIndex < 0 then
        return 0
    endif
    loop
        exitwhen i >= TT_POINT_COUNT
        if GetUnitAbilityLevel(u, TT_LEVEL_MARKERS[i]) > 0 then
            call TT_MarkAwarded(heroIndex, i)
        endif
        if TT_IsAwarded(heroIndex, i) then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    return count
endfunction

function TT_EnsureBackpack takes unit u, integer heroIndex returns boolean
    local integer i = 0
    local integer desiredId = TT_BackpackId(heroIndex)
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null then
            if GetItemTypeId(it) == desiredId then
                set TT_BACKPACK_ATTEMPTED[heroIndex] = true
                set it = null
                return true
            endif
            if GetItemTypeId(it) == 'B30B' then
                call RemoveItem(it)
            endif
        endif
        set i = i + 1
    endloop
    set it = UnitAddItemByIdSwapped(desiredId, u)
    if it != null and TT_InventoryCount(u, desiredId) > 0 then
        set TT_BACKPACK_ATTEMPTED[heroIndex] = true
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cff32cd32[背包]|r 已发放英雄装备背包，点击物品栏中的背包打开。")
        call TT_LogAppend("event=BACKPACK_OK hero=" + GetUnitName(u) + " index=" + I2S(heroIndex) + " id=" + I2S(desiredId) + " free=" + I2S(TT_FreeInventorySlots(u)))
        call TT_LogFlush()
        set it = null
        return true
    else
        set TT_BACKPACK_ATTEMPTED[heroIndex] = false
        call TT_LogAppend("event=BACKPACK_FAIL hero=" + GetUnitName(u) + " index=" + I2S(heroIndex) + " id=" + I2S(desiredId) + " free=" + I2S(TT_FreeInventorySlots(u)))
        call TT_LogFlush()
        if it != null then
            call RemoveItem(it)
        endif
        set it = null
        return false
    endif
endfunction

function TT_EarnedTalentPoints takes unit u returns integer
    return TT_SyncAwardedFromMarkers(u)
endfunction

function TT_DropItemForTalent takes unit u returns item
    local integer i = 0
    local integer itemId = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null then
            set itemId = GetItemTypeId(it)
            if itemId != 'ttal' and itemId != 'B30B' and (itemId < 'Z000' or itemId > 'Z063') and (itemId < 'I100' or itemId > 'I106') then
                call UnitRemoveItem(u, it)
                return it
            endif
        endif
        set i = i + 1
    endloop
    set it = null
    return null
endfunction

function TT_GrantOneTalentPoint takes unit u, integer amount returns boolean
    local integer heroIndex = TT_RegisterHero(u)
    local item it
    local item dropped
    local boolean accepted = false
    local integer qLevel = 0
    local string acceptedText = "0"
    if heroIndex < 0 or amount <= 0 then
        return false
    endif
    set dropped = null
    set it = UnitAddItemById(u, 'ttal')
    if it == null then
        set dropped = TT_DropItemForTalent(u)
        set it = UnitAddItemById(u, 'ttal')
    endif
    if it == null then
        if dropped != null then
            if not UnitAddItem(u, dropped) then
                call SetItemPosition(dropped, GetUnitX(u), GetUnitY(u))
            endif
        endif
        set dropped = null
        call TT_LogAppend("event=POINT_ITEM_FAILED index=" + I2S(heroIndex))
        call TT_LogFlush()
        return false
    endif
    set accepted = UnitUseItem(u, it)
    if dropped != null then
        if not UnitAddItem(u, dropped) then
            call SetItemPosition(dropped, GetUnitX(u), GetUnitY(u))
        endif
    endif
    set qLevel = GetUnitAbilityLevel(u, TT_TalentId(heroIndex))
    set TT_POINT_USE_ACCEPTED[heroIndex] = accepted
    if accepted then
        set acceptedText = "1"
    endif
    call TT_LogAppend("event=POINT_ITEM_ISSUED index=" + I2S(heroIndex) + " accepted=" + acceptedText + " Q=" + I2S(qLevel))
    call TT_LogFlush()
    set it = null
    set dropped = null
    return true
endfunction

function TT_MarkFirstEarnedMilestone takes unit u, integer heroIndex returns boolean
    local integer i = 0
    local integer level = GetHeroLevel(u)
    loop
        exitwhen i >= TT_POINT_COUNT
        if level >= TT_LEVEL_REQ[i] and not TT_IsAwarded(heroIndex, i) then
            call UnitAddAbility(u, TT_LEVEL_MARKERS[i])
            call UnitMakeAbilityPermanent(u, true, TT_LEVEL_MARKERS[i])
            call BlzUnitHideAbility(u, TT_LEVEL_MARKERS[i], true)
            call TT_MarkAwarded(heroIndex, i)
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function TT_RemoveTalentItems takes unit u returns nothing
    local integer i = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == 'ttal' then
            call RemoveItem(it)
        endif
        set i = i + 1
    endloop
    set it = null
endfunction

function TT_HeroDisplayName takes unit u returns string
    local string heroName = GetHeroProperName(u)
    if heroName == null or heroName == "" then
        set heroName = GetUnitName(u)
    endif
    return heroName
endfunction

function TT_NotifyTalentGrantedLegacy takes unit u, integer amount, integer total returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cff32cd32[天赋点]|r " + TT_HeroDisplayName(u) + " 获得 " + I2S(amount) + " 点天赋点。")
endfunction

function TT_NotifyTalentGrantBlockedLegacy takes unit u, integer before, integer target returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cffff4444[天赋点]|r 自动补发失败（" + I2S(before) + " -> " + I2S(target) + "），本等级不再自动重试。请输入 talentreset 重建天赋树。")
endfunction

function TT_NotifyTalentGranted takes unit u, integer amount, integer total returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cff32cd32[天赋点]|r " + TT_HeroDisplayName(u) + " 获得 " + I2S(amount) + " 点天赋点。")
endfunction

function TT_NotifyTalentGrantBlocked takes unit u, integer before, integer target returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cffff4444[天赋点]|r 天赋书无法使用，本等级不再自动重试。请输入 talentreset 重建天赋树。")
endfunction

function TT_OpenCampaignCache takes nothing returns gamecache
    if TT_CAMPAIGN_CACHE == null then
        set TT_CAMPAIGN_CACHE = InitGameCache("Campaigns.w3v")
    endif
    if TT_CAMPAIGN_CACHE == null and not TT_CAMPAIGN_CACHE_RELOADED then
        set TT_CAMPAIGN_CACHE_RELOADED = true
        call ReloadGameCachesFromDisk()
        set TT_CAMPAIGN_CACHE = InitGameCache("Campaigns.w3v")
    endif
    if TT_CAMPAIGN_CACHE == null then
        call TT_LogAppend("event=CAMPAIGN_CACHE_OPEN cache=none")
    else
        call TT_LogAppend("event=CAMPAIGN_CACHE_OPEN cache=" + I2S(GetHandleId(TT_CAMPAIGN_CACHE)))
    endif
    return TT_CAMPAIGN_CACHE
endfunction

function TT_QuickSaveCampaignState takes unit u returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(u)
    local gamecache cache
    local string key = ""
    if heroIndex < 0 or not TT_IsTalentHero(u) then
        return
    endif
    set cache = TT_OpenCampaignCache()
    if cache == null then
        call TT_LogAppend("event=CAMPAIGN_SAVE_FAILED index=" + I2S(heroIndex) + " reason=NO_CACHE")
        call TT_LogFlush()
        return
    endif
    set key = I2S(heroIndex)
    call StoreInteger(cache, "ALAS_TALENT", key + "v", 1)
    call StoreInteger(cache, "ALAS_TALENT", key + "a", TT_AWARDED_MASK[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "e", TT_EARNED_POINTS[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "m", TT_TALENT_MASTER_LEVEL[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "t", TT_TALENT_MASK[heroIndex])
    call TT_LogAppend("event=CAMPAIGN_SAVE index=" + key + " award=" + I2S(TT_AWARDED_MASK[heroIndex]) + " earned=" + I2S(TT_EARNED_POINTS[heroIndex]) + " mask=" + I2S(TT_TALENT_MASK[heroIndex]))
    call TT_LogFlush()
    set cache = null
endfunction

function TT_OnPointTimer takes nothing returns nothing
    local integer i = 0
    local unit u
    local boolean pending = false
    loop
        exitwhen i >= TT_HERO_COUNT or i >= 64
        set u = TT_HEROES[i]
        if TT_IsTalentHero(u) then
            if TT_POINT_WAIT_CLEANUP[i] then
                call TT_RemoveTalentItems(u)
                set TT_POINT_WAIT_CLEANUP[i] = false
                set TT_POINT_WAIT_TICKS[i] = 0
                set TT_POINT_USE_ACCEPTED[i] = false
                set TT_POINT_GRANT_FAILED[i] = false
                set TT_POINT_GRANT_FAILED_LEVEL[i] = 0
                set TT_PENDING_POINTS[i] = TT_PENDING_POINTS[i] - 1
                call TT_MarkFirstEarnedMilestone(u, i)
                set TT_EARNED_POINTS[i] = TT_AwardedCount(i)
                call TT_NotifyTalentGranted(u, 1, TT_EARNED_POINTS[i])
                call TT_LogAppend("event=POINT_GRANT_COMMITTED index=" + I2S(i) + " remaining=" + I2S(TT_PENDING_POINTS[i]))
                call TT_QuickSaveCampaignState(u)
                call TT_LogFlush()
                if TT_POINT_WAIT_CLEANUP[i] or TT_PENDING_POINTS[i] > 0 then
                    set pending = true
                endif
            elseif TT_PENDING_POINTS[i] > 0 then
                set TT_POINT_WAIT_TICKS[i] = 0
                if TT_GrantOneTalentPoint(u, 1) then
                    set TT_POINT_WAIT_CLEANUP[i] = true
                else
                    set TT_POINT_GRANT_FAILED[i] = true
                    set TT_POINT_GRANT_FAILED_LEVEL[i] = GetHeroLevel(u)
                    set TT_PENDING_POINTS[i] = 0
                    call TT_NotifyTalentGrantBlocked(u, 0, 0)
                    call TT_LogAppend("event=POINT_GRANT_BLOCKED index=" + I2S(i) + " reason=ITEM_UNAVAILABLE level=" + I2S(GetHeroLevel(u)))
                    call TT_LogFlush()
                endif
                if TT_POINT_WAIT_CLEANUP[i] or TT_PENDING_POINTS[i] > 0 then
                    set pending = true
                endif
            endif
        endif
        set i = i + 1
    endloop
    set u = null
    if not pending then
        call PauseTimer(TT_POINT_TIMER)
        call DestroyTimer(TT_POINT_TIMER)
        set TT_POINT_TIMER = null
    endif
endfunction

function TT_StartPointTimer takes nothing returns nothing
    if TT_POINT_TIMER == null then
        set TT_POINT_TIMER = CreateTimer()
        call TimerStart(TT_POINT_TIMER, 0.25, true, function TT_OnPointTimer)
    endif
endfunction

function TT_GrantEarnedPoints takes unit u returns nothing
    local integer i = 0
    local integer missing = 0
    local integer level = GetHeroLevel(u)
    local integer heroIndex = TT_RegisterHero(u)
    if heroIndex < 0 or GetUnitAbilityLevel(u, 'T405') == 0 then
        return
    endif
    if TT_POINT_GRANT_FAILED[heroIndex] and TT_POINT_GRANT_FAILED_LEVEL[heroIndex] == level then
        return
    endif
    if level > TT_POINT_GRANT_FAILED_LEVEL[heroIndex] then
        set TT_POINT_GRANT_FAILED[heroIndex] = false
    endif
    call TT_SyncAwardedFromMarkers(u)
    loop
        exitwhen i >= TT_POINT_COUNT
        if level >= TT_LEVEL_REQ[i] and not TT_IsAwarded(heroIndex, i) then
            set missing = missing + 1
        endif
        set i = i + 1
    endloop
    if TT_PENDING_POINTS[heroIndex] < missing then
        set TT_PENDING_POINTS[heroIndex] = missing
    endif
    if TT_PENDING_POINTS[heroIndex] > 0 then
        call TT_StartPointTimer()
    endif
endfunction

function TT_ResetNativeTalents takes unit u returns nothing
    call UnitRemoveAbility(u, 'T1AL')
    call UnitRemoveAbility(u, 'ATal')
    call UnitRemoveAbility(u, 'AThg')
    call UnitRemoveAbility(u, 'AThl')
    call UnitRemoveAbility(u, 'AThi')
    call UnitRemoveAbility(u, 'ATug')
    call UnitRemoveAbility(u, 'ATua')
    call UnitRemoveAbility(u, 'ATul')
endfunction

function TT_HideTalentBooks takes unit u returns nothing
    if GetUnitAbilityLevel(u, 'T100') > 0 then
        call BlzUnitHideAbility(u, 'T100', false)
    endif
    if GetUnitAbilityLevel(u, 'T101') > 0 then
        call BlzUnitHideAbility(u, 'T101', false)
    endif
    if GetUnitAbilityLevel(u, 'T102') > 0 then
        call BlzUnitHideAbility(u, 'T102', false)
    endif
    if GetUnitAbilityLevel(u, 'T105') > 0 then
        call BlzUnitHideAbility(u, 'T105', false)
    endif
    if GetUnitAbilityLevel(u, 'T112') > 0 then
        call BlzUnitHideAbility(u, 'T112', false)
    endif
    if GetUnitAbilityLevel(u, 'T113') > 0 then
        call BlzUnitHideAbility(u, 'T113', false)
    endif
    if GetUnitAbilityLevel(u, 'T114') > 0 then
        call BlzUnitHideAbility(u, 'T114', false)
    endif
endfunction

function TT_ChainTargetCount takes integer level returns integer
    return 1 + (level - 1) / 3
endfunction

function TT_ChainDamagePercent takes integer level returns integer
    return 18 + level * 2
endfunction

function TT_ChainRadius takes integer level returns real
    return I2R(400 + level * 10)
endfunction

function TT_BreakthroughDamage takes integer level returns integer
    return 60 + level * 15
endfunction

function TT_AttributeTalentLevel takes integer statValue returns integer
    local integer level = 1
    if statValue <= 30 then
        return 1
    endif
    set level = 1 + (statValue - 30) / 10
    if level > 10 then
        set level = 10
    endif
    return level
endfunction

function TT_SyncAttributeTalent takes unit u, integer abilityId, integer desiredLevel returns nothing
    local integer currentLevel = GetUnitAbilityLevel(u, abilityId)
    if currentLevel <= 0 then
        return
    endif
    if currentLevel != desiredLevel then
        call SetUnitAbilityLevel(u, abilityId, desiredLevel)
    endif
    call UnitMakeAbilityPermanent(u, true, abilityId)
    call BlzUnitHideAbility(u, abilityId, true)
endfunction

function TT_SetBreakthroughStacks takes unit u, integer heroIndex, integer stacks returns nothing
    if heroIndex < 0 then
        return
    endif
    if stacks < 0 then
        set stacks = 0
    elseif stacks > 5 then
        set stacks = 5
    endif
    set TT_BREAKTHROUGH_STACKS[heroIndex] = stacks
    if GetUnitAbilityLevel(u, 'T107') > 0 then
        if GetUnitAbilityLevel(u, 'T118') == 0 then
            call UnitAddAbility(u, 'T118')
        endif
        if GetUnitAbilityLevel(u, 'T118') != stacks + 1 then
            call SetUnitAbilityLevel(u, 'T118', stacks + 1)
        endif
        call UnitMakeAbilityPermanent(u, true, 'T118')
        call BlzUnitHideAbility(u, 'T118', true)
    elseif GetUnitAbilityLevel(u, 'T118') > 0 then
        call UnitRemoveAbility(u, 'T118')
    endif
endfunction

function TT_SyncBreakthroughTalent takes unit u returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(u)
    local real now = TimerGetElapsed(TT_LOG_CLOCK)
    if heroIndex < 0 then
        return
    endif
    if GetUnitAbilityLevel(u, 'T107') <= 0 then
        call TT_SetBreakthroughStacks(u, heroIndex, 0)
        set TT_BREAKTHROUGH_TARGET[heroIndex] = null
        return
    endif
    if TT_BREAKTHROUGH_TARGET[heroIndex] != null and GetUnitTypeId(TT_BREAKTHROUGH_TARGET[heroIndex]) == 0 then
        set TT_BREAKTHROUGH_TARGET[heroIndex] = null
        set TT_BREAKTHROUGH_STACKS[heroIndex] = 0
    endif
    if now > TT_BREAKTHROUGH_EXPIRE[heroIndex] then
        set TT_BREAKTHROUGH_TARGET[heroIndex] = null
        set TT_BREAKTHROUGH_STACKS[heroIndex] = 0
    endif
    call TT_SetBreakthroughStacks(u, heroIndex, TT_BREAKTHROUGH_STACKS[heroIndex])
endfunction

function TT_ClearNativeBarrage takes unit u returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(u)
    local integer current = 0
    if heroIndex >= 0 then
        set current = TT_BARRAGE_CURRENT[heroIndex]
    endif
    if current != 0 then
        call UnitRemoveAbility(u, current)
        set TT_BARRAGE_CURRENT[heroIndex] = 0
    endif
    call UnitRemoveAbility(u, 'T120')
    call UnitRemoveAbility(u, 'T121')
    call UnitRemoveAbility(u, 'T122')
endfunction

function TT_BarrageGroupFor takes string art, integer speed returns integer
    local string normalized = StringCase(art, false)
    if normalized == "abilities\\weapons\\arrow\\arrowmissile.mdl" and speed == 900 then
        return 0
    elseif normalized == "abilities\\weapons\\bloodelfmissile\\bloodelfmissile.mdl" and speed == 900 then
        return 1
    elseif normalized == "abilities\\weapons\\demonhuntermissile\\demonhuntermissile.mdl" and speed == 900 then
        return 2
    elseif normalized == "abilities\\weapons\\demonhuntermissile\\demonhuntermissile.mdx" and speed == 1200 then
        return 3
    elseif normalized == "abilities\\weapons\\farseermissile\\farseermissile.mdl" and speed == 1200 then
        return 4
    elseif normalized == "abilities\\weapons\\fireballmissile\\fireballmissile.mdl" and speed == 900 then
        return 5
    elseif normalized == "abilities\\weapons\\keepergrovemissile\\keepergrovemissile.mdl" and speed == 1300 then
        return 6
    elseif normalized == "abilities\\weapons\\keepergrovemissile\\keepergrovemissile.mdl" and speed == 900 then
        return 7
    elseif normalized == "abilities\\weapons\\lichmissile\\lichmissile.mdl" and speed == 900 then
        return 8
    elseif normalized == "abilities\\weapons\\lordofflamemissile\\lordofflamemissile.mdl" and speed == 1200 then
        return 9
    elseif normalized == "abilities\\weapons\\moonpriestessmissile\\moonpriestessmissile.mdl" and speed == 900 then
        return 10
    elseif normalized == "abilities\\weapons\\nagaarrowmissile\\nagaarrowmissile.mdl" and speed == 1200 then
        return 11
    elseif normalized == "abilities\\weapons\\shadowhuntermissile\\shadowhuntermissile.mdl" and speed == 900 then
        return 12
    endif
    return -1
endfunction

function TT_BarrageAbilityFor takes integer artGroup, integer targets returns integer
    if artGroup == 0 then
        if targets <= 3 then
            return 'T120'
        elseif targets <= 4 then
            return 'T121'
        endif
        return 'T122'
    elseif artGroup == 1 then
        if targets <= 3 then
            return 'T123'
        elseif targets <= 4 then
            return 'T124'
        endif
        return 'T125'
    elseif artGroup == 2 then
        if targets <= 3 then
            return 'T126'
        elseif targets <= 4 then
            return 'T127'
        endif
        return 'T128'
    elseif artGroup == 3 then
        if targets <= 3 then
            return 'T129'
        elseif targets <= 4 then
            return 'T130'
        endif
        return 'T131'
    elseif artGroup == 4 then
        if targets <= 3 then
            return 'T132'
        elseif targets <= 4 then
            return 'T133'
        endif
        return 'T134'
    elseif artGroup == 5 then
        if targets <= 3 then
            return 'T135'
        elseif targets <= 4 then
            return 'T136'
        endif
        return 'T137'
    elseif artGroup == 6 then
        if targets <= 3 then
            return 'T138'
        elseif targets <= 4 then
            return 'T139'
        endif
        return 'T140'
    elseif artGroup == 7 then
        if targets <= 3 then
            return 'T141'
        elseif targets <= 4 then
            return 'T142'
        endif
        return 'T143'
    elseif artGroup == 8 then
        if targets <= 3 then
            return 'T144'
        elseif targets <= 4 then
            return 'T145'
        endif
        return 'T146'
    elseif artGroup == 9 then
        if targets <= 3 then
            return 'T147'
        elseif targets <= 4 then
            return 'T148'
        endif
        return 'T149'
    elseif artGroup == 10 then
        if targets <= 3 then
            return 'T150'
        elseif targets <= 4 then
            return 'T151'
        endif
        return 'T152'
    elseif artGroup == 11 then
        if targets <= 3 then
            return 'T153'
        elseif targets <= 4 then
            return 'T154'
        endif
        return 'T155'
    elseif artGroup == 12 then
        if targets <= 3 then
            return 'T156'
        elseif targets <= 4 then
            return 'T157'
        endif
        return 'T158'
    endif
    return 0
endfunction

function TT_SyncNativeBarrage takes unit u returns nothing
    local integer level
    local integer heroIndex
    local integer artGroup
    local integer current
    local integer speed
    local string art
    local integer desired
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    set heroIndex = TT_RegisteredHeroIndex(u)
    if GetUnitAbilityLevel(u, 'T107') <= 0 then
        call TT_ClearNativeBarrage(u)
        return
    endif
    set art = BlzGetUnitWeaponStringField(u, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0)
    set speed = R2I(BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED, 0))
    set artGroup = TT_BarrageGroupFor(art, speed)
    if artGroup < 0 then
        if heroIndex >= 0 and TT_BARRAGE_GROUP_CACHE[heroIndex] != -2 then
            set TT_BARRAGE_GROUP_CACHE[heroIndex] = -2
            call TT_LogAppend("event=BARRAGE_ART_UNMATCHED hero=" + GetUnitName(u) + " art=" + art + " speed=" + I2S(speed))
            call TT_LogFlush()
        endif
        call TT_ClearNativeBarrage(u)
        return
    endif
    if heroIndex >= 0 and TT_BARRAGE_GROUP_CACHE[heroIndex] != artGroup + 1 then
        set TT_BARRAGE_GROUP_CACHE[heroIndex] = artGroup + 1
        call TT_LogAppend("event=BARRAGE_ART_GROUP hero=" + GetUnitName(u) + " group=" + I2S(artGroup) + " art=" + art + " speed=" + I2S(speed))
        call TT_LogFlush()
    endif
    set level = TT_AttributeTalentLevel(GetHeroAgi(u, true))
    set desired = TT_BarrageAbilityFor(artGroup, 3)
    if heroIndex >= 0 then
        set current = TT_BARRAGE_CURRENT[heroIndex]
    else
        set current = 0
    endif
    if current != desired then
        call TT_ClearNativeBarrage(u)
        if desired != 0 then
            call UnitAddAbility(u, desired)
            if heroIndex >= 0 then
                set TT_BARRAGE_CURRENT[heroIndex] = desired
            endif
            call TT_LogAppend("event=BARRAGE_NATIVE_SYNC hero=" + GetUnitName(u) + " agi=" + I2S(GetHeroAgi(u, true)) + " level=" + I2S(level) + " group=" + I2S(artGroup) + " art=" + art + " speed=" + I2S(speed) + " ability=" + I2S(desired))
            call TT_LogFlush()
        endif
    endif
    if GetUnitAbilityLevel(u, desired) > 0 then
        call UnitMakeAbilityPermanent(u, true, desired)
        call BlzUnitHideAbility(u, desired, true)
    endif
endfunction

function TT_SyncAttributeTalents takes unit u returns nothing
    call TT_SyncAttributeTalent(u, 'T106', TT_AttributeTalentLevel(GetHeroStr(u, true)))
    call TT_SyncAttributeTalent(u, 'T107', TT_AttributeTalentLevel(GetHeroAgi(u, true)))
    call TT_SyncAttributeTalent(u, 'T108', TT_AttributeTalentLevel(GetHeroInt(u, true)))
    call TT_SyncBreakthroughTalent(u)
endfunction

function TT_CleaveRadiusForLevel takes integer level returns real
    return RMinBJ(500.0, 275.0 + I2R(level) * 25.0)
endfunction

function TT_IsTalentAoeTarget takes unit caster, unit target returns boolean
    if caster == null or target == null then
        return false
    endif
    if target == caster or GetUnitTypeId(target) == 0 then
        return false
    endif
    if GetWidgetLife(target) <= 0.405 or IsUnitType(target, UNIT_TYPE_DEAD) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(caster)) then
        return false
    endif
    if BlzIsUnitInvulnerable(target) then
        return false
    endif
    return true
endfunction

function TT_OnTalentEffectExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local effect fx = LoadEffectHandle(TT_FX_TABLE, GetHandleId(t), 0)
    if fx != null then
        call DestroyEffect(fx)
    endif
    call FlushChildHashtable(TT_FX_TABLE, GetHandleId(t))
    call DestroyTimer(t)
    set fx = null
    set t = null
endfunction

function TT_ShowTalentEffectAt takes string model, real x, real y returns nothing
    local timer t
    local effect fx
    if model == "" or TT_FX_TABLE == null then
        return
    endif
    set fx = AddSpecialEffect(model, x, y)
    set t = CreateTimer()
    call SaveEffectHandle(TT_FX_TABLE, GetHandleId(t), 0, fx)
    call TimerStart(t, 0.45, false, function TT_OnTalentEffectExpire)
    set t = null
    set fx = null
endfunction

function TT_ShowTalentEffectTarget takes string model, unit target returns nothing
    local timer t
    local effect fx
    if model == "" or target == null or TT_FX_TABLE == null then
        return
    endif
    set fx = AddSpecialEffectTarget(model, target, "overhead")
    set t = CreateTimer()
    call SaveEffectHandle(TT_FX_TABLE, GetHandleId(t), 0, fx)
    call TimerStart(t, 0.45, false, function TT_OnTalentEffectExpire)
    set t = null
    set fx = null
endfunction

function TT_ShowTalentText takes unit target, string text returns nothing
    local texttag tt
    if target == null then
        return
    endif
    set tt = CreateTextTag()
    call SetTextTagPosUnit(tt, target, 40.0)
    call SetTextTagText(tt, text, 0.023)
    call SetTextTagColor(tt, 255, 128, 0, 255)
    call SetTextTagVelocity(tt, 0.0, 0.03)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.0)
    call SetTextTagFadepoint(tt, 0.8)
    set tt = null
endfunction

function TT_ApplyCleaveTalent takes unit caster, unit victim, real attackDamage returns nothing
    local group g
    local unit target
    local real x
    local real y
    local real radius
    local integer level
    if TT_AOE_BUSY or caster == null or victim == null then
        return
    endif
    set level = TT_AttributeTalentLevel(GetHeroStr(caster, true))
    set radius = TT_CleaveRadiusForLevel(level)
    set x = GetUnitX(victim)
    set y = GetUnitY(victim)
    set g = CreateGroup()
    set TT_AOE_BUSY = true
    call GroupEnumUnitsInRange(g, x, y, radius, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)
        if target != victim and TT_IsTalentAoeTarget(caster, target) then
            call UnitDamageTarget(caster, target, attackDamage * 0.35, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            call TT_ShowTalentEffectAt("Abilities\\Spells\\Other\\Cleave\\CleaveDamageTarget.mdl", GetUnitX(target), GetUnitY(target))
        endif
    endloop
    set TT_AOE_BUSY = false
    call DestroyGroup(g)
    set target = null
    set g = null
endfunction

function TT_ChainNextTarget takes unit caster, unit source, group hitTargets, real radius returns unit
    local group candidates = CreateGroup()
    local unit candidate
    local unit best = null
    local real x = GetUnitX(source)
    local real y = GetUnitY(source)
    local real dx
    local real dy
    local real distance
    local real bestDistance = radius * radius + 1.0
    call GroupEnumUnitsInRange(candidates, x, y, radius, null)
    loop
        set candidate = FirstOfGroup(candidates)
        exitwhen candidate == null
        call GroupRemoveUnit(candidates, candidate)
        if TT_IsTalentAoeTarget(caster, candidate) and not IsUnitInGroup(candidate, hitTargets) then
            set dx = GetUnitX(candidate) - x
            set dy = GetUnitY(candidate) - y
            set distance = dx * dx + dy * dy
            if distance < bestDistance then
                set bestDistance = distance
                set best = candidate
            endif
        endif
    endloop
    call DestroyGroup(candidates)
    set candidate = null
    return best
endfunction

function TT_OnChainExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = 0
    local lightning bolt
    loop
        exitwhen i >= 4
        set bolt = LoadLightningHandle(TT_FX_TABLE, GetHandleId(t), 10 + i)
        if bolt != null then
            call DestroyLightning(bolt)
        endif
        set i = i + 1
    endloop
    call FlushChildHashtable(TT_FX_TABLE, GetHandleId(t))
    call DestroyTimer(t)
    set bolt = null
    set t = null
endfunction

function TT_ApplyChainTalent takes unit caster, unit victim, real attackDamage returns nothing
    local integer level
    local integer maximumTargets
    local integer jump = 1
    local real chainDamage
    local real radius
    local unit source
    local unit target
    local group hitTargets
    local timer t = null
    local lightning bolt
    local real sourceX
    local real sourceY
    local real targetX
    local real targetY
    local real beforeLife
    local real afterLife
    if TT_AOE_BUSY or caster == null or victim == null then
        return
    endif
    set level = TT_AttributeTalentLevel(GetHeroAgi(caster, true))
    set maximumTargets = TT_ChainTargetCount(level)
    set chainDamage = attackDamage * I2R(TT_ChainDamagePercent(level)) * 0.01
    set radius = TT_ChainRadius(level)
    set source = victim
    set hitTargets = CreateGroup()
    call GroupAddUnit(hitTargets, victim)
    if TT_FX_TABLE != null then
        set t = CreateTimer()
    endif
    set TT_AOE_BUSY = true
    loop
        set target = TT_ChainNextTarget(caster, source, hitTargets, radius)
        exitwhen target == null or jump > maximumTargets
        call GroupAddUnit(hitTargets, target)
        set sourceX = GetUnitX(source)
        set sourceY = GetUnitY(source)
        set targetX = GetUnitX(target)
        set targetY = GetUnitY(target)
        if t != null then
            set bolt = AddLightningEx("CLPB", true, sourceX, sourceY, GetUnitFlyHeight(source) + 60.0, targetX, targetY, GetUnitFlyHeight(target) + 60.0)
            call SaveLightningHandle(TT_FX_TABLE, GetHandleId(t), 9 + jump, bolt)
        endif
        set beforeLife = GetWidgetLife(target)
        call UnitDamageTarget(caster, target, chainDamage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        set afterLife = GetWidgetLife(target)
        call TT_ShowTalentText(target, "-" + I2S(R2I(chainDamage)))
        call TT_LogAppend("event=CHAIN_HIT hero=" + GetUnitName(caster) + " victim=" + GetUnitName(target) + " agi=" + I2S(GetHeroAgi(caster, true)) + " level=" + I2S(level) + " jump=" + I2S(jump) + " damage=" + R2S(chainDamage) + " lifeBefore=" + R2S(beforeLife) + " lifeAfter=" + R2S(afterLife))
        set source = target
        set target = null
        set jump = jump + 1
    endloop
    set TT_AOE_BUSY = false
    if t != null then
        call TimerStart(t, 0.30, false, function TT_OnChainExpire)
    endif
    call DestroyGroup(hitTargets)
    set bolt = null
    set source = null
    set target = null
    set hitTargets = null
    set t = null
endfunction

function TT_BreakthroughWarStomp takes unit caster, unit victim returns nothing
    local group g
    local unit target
    local unit dummy
    local real x = GetUnitX(victim)
    local real y = GetUnitY(victim)
    local real damage
    local integer level = TT_AttributeTalentLevel(GetHeroAgi(caster, true))
    local integer hitCount = 0
    local boolean wasBusy = TT_AOE_BUSY
    local real beforeLife
    local real afterLife
    if caster == null or victim == null then
        return
    endif
    set damage = I2R(60 + level * 15)
    set g = CreateGroup()
    set TT_AOE_BUSY = true
    call GroupEnumUnitsInRange(g, x, y, 250.0, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)
        if TT_IsTalentAoeTarget(caster, target) then
            set beforeLife = GetWidgetLife(target)
            call UnitDamageTarget(caster, target, damage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            set afterLife = GetWidgetLife(target)
            set hitCount = hitCount + 1
            call TT_LogAppend("event=BREAKTHROUGH_HIT hero=" + GetUnitName(caster) + " victim=" + GetUnitName(target) + " agi=" + I2S(GetHeroAgi(caster, true)) + " level=" + I2S(level) + " damage=" + R2S(damage) + " lifeBefore=" + R2S(beforeLife) + " lifeAfter=" + R2S(afterLife))
        endif
    endloop
    set TT_AOE_BUSY = wasBusy
    set dummy = CreateUnit(GetOwningPlayer(caster), 'n100', x, y, 0.0)
    if dummy != null then
        call UnitAddAbility(dummy, 'T119')
        call IssueImmediateOrder(dummy, "stomp")
        call UnitApplyTimedLife(dummy, 'BTLF', 0.50)
    endif
    call TT_ShowTalentEffectAt("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", x, y)
    call TT_LogAppend("event=BREAKTHROUGH_STOMP hero=" + GetUnitName(caster) + " level=" + I2S(level) + " damage=" + R2S(damage) + " radius=250.0 stun=1.5 hits=" + I2S(hitCount))
    call TT_LogFlush()
    call DestroyGroup(g)
    set dummy = null
    set target = null
    set g = null
endfunction

function TT_ApplyBreakthroughTalent takes unit caster, unit victim returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(caster)
    local integer stacks
    local real now = TimerGetElapsed(TT_LOG_CLOCK)
    if TT_AOE_BUSY or caster == null or victim == null or heroIndex < 0 then
        return
    endif
    if TT_BREAKTHROUGH_TARGET[heroIndex] != victim or now > TT_BREAKTHROUGH_EXPIRE[heroIndex] then
        set stacks = 1
    elseif TT_BREAKTHROUGH_STACKS[heroIndex] >= 5 then
        call TT_BreakthroughWarStomp(caster, victim)
        set stacks = 0
    else
        set stacks = TT_BREAKTHROUGH_STACKS[heroIndex] + 1
    endif
    set TT_BREAKTHROUGH_TARGET[heroIndex] = victim
    set TT_BREAKTHROUGH_EXPIRE[heroIndex] = now + 3.0
    call TT_SetBreakthroughStacks(caster, heroIndex, stacks)
    call TT_LogAppend("event=BREAKTHROUGH_STACK hero=" + GetUnitName(caster) + " victim=" + GetUnitName(victim) + " agi=" + I2S(GetHeroAgi(caster, true)) + " stacks=" + I2S(stacks) + " attackSpeedPct=" + I2S(stacks * 10))
    call TT_LogFlush()
endfunction

function TT_ApplyIncinerateTalent takes unit caster, unit victim returns nothing
    local integer heroIndex
    local integer level
    local integer stacks
    local real now
    local real bonus
    local real beforeLife
    local real afterLife
    if TT_AOE_BUSY or caster == null or victim == null then
        return
    endif
    set heroIndex = TT_RegisteredHeroIndex(caster)
    if heroIndex < 0 then
        return
    endif
    set level = TT_AttributeTalentLevel(GetHeroInt(caster, true))
    set now = TimerGetElapsed(TT_LOG_CLOCK)
    if TT_INCIN_TARGET[heroIndex] != victim or now > TT_INCIN_EXPIRE[heroIndex] then
        set stacks = 1
    else
        set stacks = TT_INCIN_STACKS[heroIndex] + 1
    endif
    if stacks > 6 then
        set stacks = 6
    endif
    set TT_INCIN_TARGET[heroIndex] = victim
    set TT_INCIN_STACKS[heroIndex] = stacks
    set TT_INCIN_LEVEL[heroIndex] = level
    set TT_INCIN_EXPIRE[heroIndex] = now + 4.0
    set bonus = I2R(stacks * (3 + level))
    set beforeLife = GetWidgetLife(victim)
    set TT_AOE_BUSY = true
    call UnitDamageTarget(caster, victim, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
    set TT_AOE_BUSY = false
    set afterLife = GetWidgetLife(victim)
    call TT_ShowTalentText(victim, "+" + I2S(R2I(bonus)))
    call TT_ShowTalentEffectTarget("Abilities\\Spells\\Other\\Incinerate\\IncinerateBuff.mdx", victim)
    call TT_LogAppend("event=INCINERATE_HIT hero=" + GetUnitName(caster) + " victim=" + GetUnitName(victim) + " int=" + I2S(GetHeroInt(caster, true)) + " level=" + I2S(level) + " stack=" + I2S(stacks) + " bonus=" + R2S(bonus) + " lifeBefore=" + R2S(beforeLife) + " lifeAfter=" + R2S(afterLife))
    call TT_LogFlush()
endfunction

function TT_ExplodeIncinerateTalent takes unit caster, unit victim, integer heroIndex returns nothing
    local group g
    local unit target
    local real x
    local real y
    local real damage
    local integer level = TT_INCIN_LEVEL[heroIndex]
    local boolean wasBusy = TT_AOE_BUSY
    local integer hitCount = 0
    local real beforeLife
    local real afterLife
    if caster == null or victim == null then
        return
    endif
    set x = GetUnitX(victim)
    set y = GetUnitY(victim)
    set damage = I2R(80 + level * 20)
    set g = CreateGroup()
    set TT_AOE_BUSY = true
    call TT_ShowTalentEffectAt("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdx", x, y)
    call TT_LogAppend("event=INCINERATE_EXPLODE hero=" + GetUnitName(caster) + " victim=" + GetUnitName(victim) + " level=" + I2S(level) + " damage=" + R2S(damage))
    call GroupEnumUnitsInRange(g, x, y, 250.0, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)
        if target != victim and TT_IsTalentAoeTarget(caster, target) then
            set beforeLife = GetWidgetLife(target)
            call UnitDamageTarget(caster, target, damage, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
            set afterLife = GetWidgetLife(target)
            set hitCount = hitCount + 1
            call TT_ShowTalentText(target, "-" + I2S(R2I(damage)))
            call TT_LogAppend("event=INCINERATE_EXPLODE_HIT index=" + I2S(hitCount) + " target=" + GetUnitName(target) + " expected=" + R2S(damage) + " lifeBefore=" + R2S(beforeLife) + " lifeAfter=" + R2S(afterLife))
        endif
    endloop
    set TT_AOE_BUSY = wasBusy
    call DestroyGroup(g)
    set TT_INCIN_TARGET[heroIndex] = null
    set TT_INCIN_STACKS[heroIndex] = 0
    set TT_INCIN_LEVEL[heroIndex] = 0
    set TT_INCIN_EXPIRE[heroIndex] = 0.0
    call TT_LogAppend("event=INCINERATE_EXPLODE_END hero=" + GetUnitName(caster) + " hits=" + I2S(hitCount))
    call TT_LogFlush()
    set target = null
    set g = null
endfunction

function TT_OnAnyUnitDeath takes nothing returns nothing
    local unit victim = GetTriggerUnit()
    local unit caster
    local integer i = 0
    if victim == null then
        return
    endif
    loop
        exitwhen i >= TT_HERO_COUNT
        set caster = TT_HEROES[i]
        if caster != null and TT_INCIN_TARGET[i] == victim and TimerGetElapsed(TT_LOG_CLOCK) <= TT_INCIN_EXPIRE[i] then
            call TT_ExplodeIncinerateTalent(caster, victim, i)
        endif
        set i = i + 1
    endloop
    set caster = null
    set victim = null
endfunction

function TT_ClearTalentArtifact takes unit u returns nothing
    local integer i = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and (GetItemTypeId(it) == 'I103' or GetItemTypeId(it) == 'I105' or GetItemTypeId(it) == 'I106') then
            call UnitRemoveItem(u, it)
            call RemoveItem(it)
            set it = null
            return
        endif
        set i = i + 1
    endloop
    set it = null
endfunction

function TT_ClearTalentMilestones takes unit u returns nothing
    local integer i = 0
    loop
        exitwhen i >= TT_POINT_COUNT
        if GetUnitAbilityLevel(u, TT_LEVEL_MARKERS[i]) > 0 then
            call UnitRemoveAbility(u, TT_LEVEL_MARKERS[i])
        endif
        set i = i + 1
    endloop
endfunction

function TT_TalentAbilityId takes integer abilityCode returns integer
    return 'T000' + (abilityCode / 100) * 65536 + ((abilityCode / 10) - (abilityCode / 100) * 10) * 256 + (abilityCode - (abilityCode / 10) * 10)
endfunction

function TT_ChoiceWeight takes integer tier returns integer
    local integer weight = 1
    local integer i = 0
    loop
        exitwhen i >= tier
        set weight = weight * 8
        set i = i + 1
    endloop
    return weight
endfunction

function TT_ReadTierChoice takes unit u, integer tier returns integer
    local integer choice = 0
    loop
        exitwhen choice >= 3
        if GetUnitAbilityLevel(u, TT_TalentAbilityId(100 + tier * 3 + choice)) > 0 then
            return choice + 1
        endif
        set choice = choice + 1
    endloop
    return 0
endfunction

function TT_SelectedTierCount takes unit u returns integer
    local integer tier = 0
    local integer count = 0
    loop
        exitwhen tier >= 6
        if TT_ReadTierChoice(u, tier) > 0 then
            set count = count + 1
        endif
        set tier = tier + 1
    endloop
    return count
endfunction

function TT_SavedTierChoice takes integer heroIndex, integer tier returns integer
    local integer weight = TT_ChoiceWeight(tier)
    local integer choice = TT_TALENT_MASK[heroIndex] / weight
    return choice - (choice / 8) * 8
endfunction

function TT_MakeTalentPermanent takes unit u, integer abilityId returns nothing
    if GetUnitAbilityLevel(u, abilityId) > 0 then
        call UnitMakeAbilityPermanent(u, true, abilityId)
    endif
endfunction

function TT_SelectionText takes unit u, integer heroIndex returns string
    local integer tier = 0
    local integer choice = 0
    local string result = ""
    loop
        exitwhen tier >= 6
        set choice = TT_ReadTierChoice(u, tier)
        if choice == 0 then
            set choice = TT_SavedTierChoice(heroIndex, tier)
        endif
        if tier > 0 then
            set result = result + ","
        endif
        set result = result + I2S(choice)
        set tier = tier + 1
    endloop
    return result
endfunction

function TT_ActualSelectionText takes unit u returns string
    local integer tier = 0
    local integer choice = 0
    local string result = ""
    loop
        exitwhen tier >= 6
        set choice = TT_ReadTierChoice(u, tier)
        if tier > 0 then
            set result = result + ","
        endif
        set result = result + I2S(choice)
        set tier = tier + 1
    endloop
    return result
endfunction

function TT_LogHeroState takes unit u, integer heroIndex, string eventName returns nothing
    local string ownerName = "none"
    if u == null or heroIndex < 0 then
        call TT_LogAppend("event=" + eventName + " hero=none index=" + I2S(heroIndex))
        return
    endif
    set ownerName = GetPlayerName(GetOwningPlayer(u))
    call TT_LogAppend("event=" + eventName + " hero=" + GetUnitName(u) + " owner=" + ownerName + " level=" + I2S(GetHeroLevel(u)) + " index=" + I2S(heroIndex) + " Q=" + I2S(GetUnitAbilityLevel(u, TT_TalentId(heroIndex))) + " earned=" + I2S(TT_EarnedTalentPoints(u)) + " mask=" + I2S(TT_TALENT_MASK[heroIndex]) + " actual=" + TT_ActualSelectionText(u) + " saved=" + TT_SelectionText(u, heroIndex))
endfunction

function TT_EnsureTalentChild takes unit u, integer abilityCode returns nothing
    local integer abilityId = TT_TalentAbilityId(abilityCode)
    if GetUnitAbilityLevel(u, abilityId) == 0 then
        call UnitAddAbility(u, abilityId)
    endif
    call TT_MakeTalentPermanent(u, abilityId)
endfunction

function TT_CaptureTalentState takes unit u returns nothing
    local integer heroIndex = TT_RegisterHero(u)
    local integer tier = 0
    local integer choice = 0
    local integer level = 0
    local integer selected = 0
    local integer weight = 1
    local integer mask = 0
    local integer abilityId = 0
    if heroIndex < 0 then
        return
    endif
    loop
        exitwhen tier >= 6
        set choice = TT_ReadTierChoice(u, tier)
        if choice == 0 then
            set choice = TT_SavedTierChoice(heroIndex, tier)
        endif
        if choice > 0 then
            set weight = TT_ChoiceWeight(tier)
            set mask = mask + choice * weight
        endif
        set tier = tier + 1
    endloop
    set TT_TALENT_MASK[heroIndex] = mask
    set level = TT_SyncAwardedFromMarkers(u)
    set selected = TT_SelectedTierCount(u)
    if selected > level then
        call TT_MarkAwardedToCount(heroIndex, selected)
        set level = TT_AwardedCount(heroIndex)
        call TT_LogAppend("event=TALENT_INFER_AWARDED index=" + I2S(heroIndex) + " selected=" + I2S(selected) + " earned=" + I2S(level))
    endif
    set TT_EARNED_POINTS[heroIndex] = level
    set level = GetUnitAbilityLevel(u, TT_TalentId(heroIndex))
    if level > TT_TALENT_MASTER_LEVEL[heroIndex] then
        set TT_TALENT_MASTER_LEVEL[heroIndex] = level
    endif
    set tier = 0
    loop
        exitwhen tier >= 18
        call TT_MakeTalentPermanent(u, TT_TalentAbilityId(100 + tier))
        set tier = tier + 1
    endloop
    set tier = 0
    loop
        exitwhen tier >= 10
        call TT_MakeTalentPermanent(u, TT_TalentAbilityId(200 + tier))
        set tier = tier + 1
    endloop
endfunction

function TT_RestoreTalentState takes unit u returns nothing
    local integer heroIndex = TT_RegisterHero(u)
    local integer tier = 0
    local integer choice = 0
    local integer abilityId = 0
    if heroIndex < 0 then
        return
    endif
    loop
        exitwhen tier >= 6
        set choice = TT_SavedTierChoice(heroIndex, tier)
        if choice > 0 then
            set abilityId = TT_TalentAbilityId(100 + tier * 3 + choice - 1)
            if GetUnitAbilityLevel(u, abilityId) == 0 then
                call UnitAddAbility(u, abilityId)
            endif
            call TT_MakeTalentPermanent(u, abilityId)
            if abilityId == 'T100' then
                call TT_EnsureTalentChild(u, 200)
                call TT_EnsureTalentChild(u, 201)
            elseif abilityId == 'T101' then
                call TT_EnsureTalentChild(u, 202)
                call TT_EnsureTalentChild(u, 203)
            elseif abilityId == 'T102' then
                call TT_EnsureTalentChild(u, 204)
                call TT_EnsureTalentChild(u, 205)
                call TT_EnsureTalentChild(u, 206)
                call TT_EnsureTalentChild(u, 207)
            elseif abilityId == 'T105' then
                call TT_EnsureTalentChild(u, 208)
                call TT_EnsureTalentChild(u, 209)
            endif
        endif
        set tier = tier + 1
    endloop
    call TT_HideTalentBooks(u)
endfunction

function TT_EnsureTalentMaster takes unit u, integer heroIndex returns nothing
    local integer talentId = TT_TalentId(heroIndex)
    local integer desired = TT_TALENT_MASTER_LEVEL[heroIndex]
    local integer level = 0
    if GetUnitAbilityLevel(u, talentId) == 0 then
        call UnitAddAbility(u, talentId)
    endif
    set level = GetUnitAbilityLevel(u, talentId)
    if level > 0 then
        if desired > 0 and level != desired then
            call SetUnitAbilityLevel(u, talentId, desired)
            set level = desired
        endif
        if level > TT_TALENT_MASTER_LEVEL[heroIndex] then
            set TT_TALENT_MASTER_LEVEL[heroIndex] = level
        endif
        call UnitMakeAbilityPermanent(u, true, talentId)
    endif
endfunction

function TT_ApplyCampaignTalentState takes unit u, integer heroIndex returns nothing
    if heroIndex < 0 then
        return
    endif
    call TT_EnsureTalentMaster(u, heroIndex)
    call TT_RestoreTalentState(u)
    set TT_PENDING_POINTS[heroIndex] = 0
    set TT_POINT_WAIT_CLEANUP[heroIndex] = false
    set TT_CAMPAIGN_POINTS_QUEUED[heroIndex] = true
    call TT_LogAppend("event=CAMPAIGN_UNSPENT_PRESERVED_BY_UNIT index=" + I2S(heroIndex) + " earned=" + I2S(TT_EARNED_POINTS[heroIndex]) + " selected=" + I2S(TT_SelectedTierCount(u)))
endfunction

function TT_CampaignStore takes unit u, gamecache cache returns nothing
    local integer heroIndex = TT_RegisterHero(u)
    local string key = ""
    if heroIndex < 0 then
        return
    endif
    call TT_CaptureTalentState(u)
    call TT_QuickSaveCampaignState(u)
    if cache == null then
        return
    endif
    set key = I2S(heroIndex)
    call StoreInteger(cache, "ALAS_TALENT", key + "v", 1)
    call StoreInteger(cache, "ALAS_TALENT", key + "a", TT_AWARDED_MASK[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "e", TT_EARNED_POINTS[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "m", TT_TALENT_MASTER_LEVEL[heroIndex])
    call StoreInteger(cache, "ALAS_TALENT", key + "t", TT_TALENT_MASK[heroIndex])
    call SaveGameCache(cache)
    call TT_LogAppend("event=CAMPAIGN_STORE index=" + key + " award=" + I2S(TT_AWARDED_MASK[heroIndex]) + " earned=" + I2S(TT_EARNED_POINTS[heroIndex]) + " master=" + I2S(TT_TALENT_MASTER_LEVEL[heroIndex]) + " mask=" + I2S(TT_TALENT_MASK[heroIndex]) + " actual=" + TT_ActualSelectionText(u))
    call TT_LogAppend("event=CAMPAIGN_STORE_SAVED index=" + key + " free=" + I2S(TT_FreeInventorySlots(u)))
    call TT_LogFlush()
endfunction

function TT_OnCampaignVerifyTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(TT_RESTORE_TABLE, GetHandleId(t), 0)
    local integer heroIndex = -1
    if u != null and GetUnitTypeId(u) != 0 then
        set heroIndex = TT_RegisterHero(u)
        if heroIndex >= 0 then
            set TT_CAMPAIGN_VERIFY_PENDING[heroIndex] = false
            call TT_EnsureTalentMaster(u, heroIndex)
            call TT_RestoreTalentState(u)
            call TT_HideTalentBooks(u)
            call TT_LogHeroState(u, heroIndex, "CAMPAIGN_REAPPLY")
            call TT_LogFlush()
        endif
    endif
    call FlushChildHashtable(TT_RESTORE_TABLE, GetHandleId(t))
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

function TT_ScheduleCampaignVerify takes unit u, integer heroIndex returns nothing
    local timer t
    if u == null or heroIndex < 0 or TT_CAMPAIGN_VERIFY_PENDING[heroIndex] then
        return
    endif
    set TT_CAMPAIGN_VERIFY_PENDING[heroIndex] = true
    set t = CreateTimer()
    call SaveUnitHandle(TT_RESTORE_TABLE, GetHandleId(t), 0, u)
    call TimerStart(t, 1.00, false, function TT_OnCampaignVerifyTimer)
    set t = null
endfunction

function TT_LoadCampaignTalentState takes unit u, integer heroIndex, gamecache cache returns boolean
    local integer awarded = 0
    local integer earned = 0
    local integer master = 0
    local integer mask = 0
    local integer selected = 0
    local integer target = 0
    local string key = ""
    if cache == null or heroIndex < 0 then
        return false
    endif
    if TT_CAMPAIGN_CHAPTER <= 1 and TT_SelectedTierCount(u) == 0 then
        call TT_LogAppend("event=CAMPAIGN_FRESH index=" + I2S(heroIndex) + " chapter=" + I2S(TT_CAMPAIGN_CHAPTER))
        call TT_LogFlush()
        return false
    endif
    set TT_CAMPAIGN_CACHE_LOADED[heroIndex] = true
    set key = I2S(heroIndex)
    if HaveStoredInteger(cache, "ALAS_TALENT", key + "v") then
        set awarded = GetStoredInteger(cache, "ALAS_TALENT", key + "a")
        set earned = GetStoredInteger(cache, "ALAS_TALENT", key + "e")
        set master = GetStoredInteger(cache, "ALAS_TALENT", key + "m")
        set mask = GetStoredInteger(cache, "ALAS_TALENT", key + "t")
        if awarded < 0 then
            set awarded = 0
        endif
        if earned < 0 then
            set earned = 0
        endif
        if master < 0 then
            set master = 0
        endif
        if mask < 0 then
            set mask = 0
        endif
        set TT_AWARDED_MASK[heroIndex] = awarded
        set TT_EARNED_POINTS[heroIndex] = earned
        set TT_TALENT_MASTER_LEVEL[heroIndex] = master
        set TT_TALENT_MASK[heroIndex] = mask
        set TT_CAMPAIGN_STATE_PENDING[heroIndex] = true
        call TT_ApplyCampaignTalentState(u, heroIndex)
        call TT_LogAppend("event=CAMPAIGN_RESTORE index=" + key + " award=" + I2S(awarded) + " earned=" + I2S(earned) + " master=" + I2S(master) + " mask=" + I2S(mask) + " actual=" + TT_ActualSelectionText(u))
    else
        call TT_CaptureTalentState(u)
        set earned = TT_SyncAwardedFromMarkers(u)
        set selected = TT_SelectedTierCount(u)
        set master = GetUnitAbilityLevel(u, TT_TalentId(heroIndex))
        set target = earned
        if selected > target then
            set target = selected
        endif
        call TT_MarkAwardedToCount(heroIndex, target)
        set earned = TT_AwardedCount(heroIndex)
        set TT_EARNED_POINTS[heroIndex] = earned
        set TT_TALENT_MASTER_LEVEL[heroIndex] = master
        set TT_CAMPAIGN_STATE_PENDING[heroIndex] = true
        call TT_ApplyCampaignTalentState(u, heroIndex)
        call TT_LogAppend("event=CAMPAIGN_LEGACY_RECOVER index=" + key + " award=" + I2S(TT_AWARDED_MASK[heroIndex]) + " earned=" + I2S(earned) + " master=" + I2S(master) + " selected=" + I2S(selected))
    endif
    if GetUnitAbilityLevel(u, 'T405') > 0 then
        call TT_GrantEarnedPoints(u)
    endif
    call TT_ScheduleCampaignVerify(u, heroIndex)
    call TT_LogFlush()
    return true
endfunction

function TT_TryCampaignCacheRestore takes unit u, integer heroIndex returns boolean
    local gamecache cache
    local string key = ""
    if u == null or heroIndex < 0 or TT_CAMPAIGN_CACHE_LOADED[heroIndex] then
        return false
    endif
    set cache = TT_OpenCampaignCache()
    set TT_CAMPAIGN_CACHE_LOADED[heroIndex] = true
    if cache == null then
        call TT_LogAppend("event=CAMPAIGN_FALLBACK_MISSING index=" + I2S(heroIndex) + " reason=NO_CACHE")
        call TT_LogFlush()
        return false
    endif
    set key = I2S(heroIndex)
    if HaveStoredInteger(cache, "ALAS_TALENT", key + "v") then
        call TT_LoadCampaignTalentState(u, heroIndex, cache)
        call TT_LogAppend("event=CAMPAIGN_FALLBACK_RESTORE index=" + key + " award=" + I2S(TT_AWARDED_MASK[heroIndex]) + " earned=" + I2S(TT_EARNED_POINTS[heroIndex]) + " mask=" + I2S(TT_TALENT_MASK[heroIndex]) + " actual=" + TT_ActualSelectionText(u))
        call TT_LogFlush()
        set cache = null
        return true
    endif
    call TT_LogAppend("event=CAMPAIGN_FALLBACK_MISSING index=" + key)
    call TT_LogFlush()
    set cache = null
    return false
endfunction

function TT_QueueCampaignRestore takes unit u, gamecache cache returns nothing
    local integer i = 0
    if u == null or cache == null then
        return
    endif
    loop
        exitwhen i >= TT_CAMPAIGN_RESTORE_COUNT or i >= 64
        if TT_CAMPAIGN_RESTORE_UNITS[i] == u then
            set TT_CAMPAIGN_RESTORE_CACHES[i] = cache
            call TT_LogAppend("event=CAMPAIGN_RESTORE_DEFERRED index=" + I2S(i) + " handle=" + I2S(GetHandleId(u)) + " level=" + I2S(GetHeroLevel(u)))
            call TT_LogFlush()
            return
        endif
        if TT_CAMPAIGN_RESTORE_UNITS[i] != null and GetUnitTypeId(TT_CAMPAIGN_RESTORE_UNITS[i]) == 0 then
            set TT_CAMPAIGN_RESTORE_UNITS[i] = u
            set TT_CAMPAIGN_RESTORE_CACHES[i] = cache
            call TT_LogAppend("event=CAMPAIGN_RESTORE_DEFERRED index=" + I2S(i) + " handle=" + I2S(GetHandleId(u)) + " level=" + I2S(GetHeroLevel(u)))
            call TT_LogFlush()
            return
        endif
        set i = i + 1
    endloop
    if TT_CAMPAIGN_RESTORE_COUNT < 64 then
        set TT_CAMPAIGN_RESTORE_UNITS[TT_CAMPAIGN_RESTORE_COUNT] = u
        set TT_CAMPAIGN_RESTORE_CACHES[TT_CAMPAIGN_RESTORE_COUNT] = cache
        call TT_LogAppend("event=CAMPAIGN_RESTORE_DEFERRED index=" + I2S(TT_CAMPAIGN_RESTORE_COUNT) + " handle=" + I2S(GetHandleId(u)) + " level=" + I2S(GetHeroLevel(u)))
        call TT_LogFlush()
        set TT_CAMPAIGN_RESTORE_COUNT = TT_CAMPAIGN_RESTORE_COUNT + 1
    endif
endfunction

function TT_ConsumeCampaignRestore takes unit u, integer heroIndex returns boolean
    local integer i = 0
    local gamecache cache
    if u == null or heroIndex < 0 then
        return false
    endif
    loop
        exitwhen i >= TT_CAMPAIGN_RESTORE_COUNT or i >= 64
        if TT_CAMPAIGN_RESTORE_UNITS[i] == u then
            set cache = TT_CAMPAIGN_RESTORE_CACHES[i]
            set TT_CAMPAIGN_RESTORE_UNITS[i] = null
            set TT_CAMPAIGN_RESTORE_CACHES[i] = null
            if cache != null then
                call TT_LoadCampaignTalentState(u, heroIndex, cache)
            endif
            set cache = null
            return true
        endif
        set i = i + 1
    endloop
    set cache = null
    return false
endfunction

function TT_CampaignRestore takes unit u, gamecache cache returns nothing
    local integer heroIndex = -1
    local gamecache bridgeCache
    local string unitText = "none"
    local string cacheText = "none"
    if u != null then
        set unitText = I2S(GetHandleId(u))
    endif
    set bridgeCache = cache
    if bridgeCache == null then
        set bridgeCache = TT_OpenCampaignCache()
    endif
    if bridgeCache != null then
        set cacheText = I2S(GetHandleId(bridgeCache))
    endif
    call TT_LogAppend("event=CAMPAIGN_RESTORE_ENTER unit=" + unitText + " cache=" + cacheText)
    if u == null then
        call TT_LogAppend("event=CAMPAIGN_RESTORE_SKIP reason=NO_UNIT")
        call TT_LogFlush()
        return
    endif
    if bridgeCache == null then
        call TT_LogAppend("event=CAMPAIGN_RESTORE_SKIP reason=NO_CACHE")
        call TT_LogFlush()
        return
    endif
    if not TT_IsTalentHero(u) then
        call TT_LogAppend("event=CAMPAIGN_RESTORE_SKIP reason=NOT_TALENT_HERO")
        call TT_LogFlush()
        return
    endif
    if TT_SavedBackpackIndex(u) < 0 then
        call TT_QueueCampaignRestore(u, bridgeCache)
        set bridgeCache = null
        return
    endif
    set heroIndex = TT_RegisterHero(u)
    if heroIndex < 0 then
        call TT_QueueCampaignRestore(u, bridgeCache)
        set bridgeCache = null
        return
    endif
    call TT_LoadCampaignTalentState(u, heroIndex, bridgeCache)
    set bridgeCache = null
endfunction

function TT_ResetTalents takes unit u returns nothing
    local integer i = 0
    local integer heroIndex = TT_RegisterHero(u)
    local integer talentId = 0
    local integer restorePoints = 0
    local integer level = GetHeroLevel(u)
    if heroIndex < 0 then
        return
    endif
    set talentId = TT_TalentId(heroIndex)
    call TT_LogHeroState(u, heroIndex, "RESET_START")
    call TT_LogFlush()
    call TT_CaptureTalentState(u)
    loop
        exitwhen i >= TT_POINT_COUNT
        if level >= TT_LEVEL_REQ[i] then
            set restorePoints = restorePoints + 1
        endif
        set i = i + 1
    endloop
    call TT_ClearTalentMilestones(u)
    call BlzResetUnitTalents(u)
    call UnitRemoveAbility(u, talentId)
    loop
        exitwhen i >= 18
        call UnitRemoveAbility(u, TT_TalentAbilityId(100 + i))
        set i = i + 1
    endloop
    call TT_ClearNativeBarrage(u)
    call TT_SetBreakthroughStacks(u, heroIndex, 0)
    set TT_BREAKTHROUGH_TARGET[heroIndex] = null
    set i = 0
    loop
        exitwhen i >= 10
        call UnitRemoveAbility(u, TT_TalentAbilityId(200 + i))
        set i = i + 1
    endloop
    if GetUnitAbilityLevel(u, 'T480') > 0 then
        call TT_ClearTalentArtifact(u)
        call UnitRemoveAbility(u, 'T480')
    endif
    call UnitAddAbility(u, talentId)
    call UnitMakeAbilityPermanent(u, true, talentId)
    set TT_AWARDED_MASK[heroIndex] = 0
    set TT_TALENT_MASK[heroIndex] = 0
    set TT_CAMPAIGN_STATE_PENDING[heroIndex] = false
    set TT_PENDING_POINTS[heroIndex] = restorePoints
    set TT_POINT_WAIT_CLEANUP[heroIndex] = false
    set TT_POINT_GRANT_FAILED[heroIndex] = false
    set TT_POINT_GRANT_FAILED_LEVEL[heroIndex] = 0
    set TT_CAMPAIGN_POINTS_QUEUED[heroIndex] = true
    if TT_PENDING_POINTS[heroIndex] > 0 then
        call TT_StartPointTimer()
    endif
    call TT_HideTalentBooks(u)
    set TT_EARNED_POINTS[heroIndex] = 0
    set TT_TALENT_MASTER_LEVEL[heroIndex] = GetUnitAbilityLevel(u, talentId)
    set TT_INCIN_TARGET[heroIndex] = null
    set TT_INCIN_STACKS[heroIndex] = 0
    set TT_INCIN_LEVEL[heroIndex] = 0
    set TT_INCIN_EXPIRE[heroIndex] = 0.0
    call TT_LogHeroState(u, heroIndex, "RESET_FINISHED")
    call TT_LogFlush()
endfunction

function TT_EligiblePointCount takes integer level returns integer
    local integer i = 0
    local integer count = 0
    loop
        exitwhen i >= TT_POINT_COUNT
        if level >= TT_LEVEL_REQ[i] then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    return count
endfunction

function TT_TrimMilestonesToCount takes unit u, integer count returns nothing
    local integer i = count
    loop
        exitwhen i >= TT_POINT_COUNT
        if GetUnitAbilityLevel(u, TT_LEVEL_MARKERS[i]) > 0 then
            call UnitRemoveAbility(u, TT_LEVEL_MARKERS[i])
        endif
        set i = i + 1
    endloop
endfunction

function TT_NotifyTalentDeficit takes unit u, integer missing, integer eligible returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cff32cd32[天赋点]|r 检测到缺少 " + I2S(missing) + " 点；当前等级应有 " + I2S(eligible) + " 点，正在补发。")
endfunction

function TT_NotifyTalentExcess takes unit u, integer excess, integer eligible returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cffff8c00[天赋点]|r 检测到超额 " + I2S(excess) + " 点；当前等级上限为 " + I2S(eligible) + " 点，已重建天赋，请重新选择。")
endfunction

function TT_ValidateTalentPoints takes unit u returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(u)
    local integer level = GetHeroLevel(u)
    local integer eligible = 0
    local integer awarded = 0
    local integer earned = 0
    local integer master = 0
    local integer selected = 0
    local integer highest = 0
    local integer missing = 0
    local integer pending = 0
    if heroIndex < 0 or GetUnitAbilityLevel(u, 'T405') == 0 then
        return
    endif
    call TT_SyncAwardedFromMarkers(u)
    set eligible = TT_EligiblePointCount(level)
    set awarded = TT_AwardedCount(heroIndex)
    set earned = TT_EARNED_POINTS[heroIndex]
    set master = TT_TALENT_MASTER_LEVEL[heroIndex]
    set selected = TT_SelectedTierCount(u)
    set pending = TT_PENDING_POINTS[heroIndex]
    set highest = awarded
    if earned > highest then
        set highest = earned
    endif
    if selected > highest then
        set highest = selected
    endif
    if highest > eligible then
        call TT_LogHeroState(u, heroIndex, "POINT_RECONCILE_EXCESS")
        call TT_LogAppend("event=POINT_RECONCILE excess from=" + I2S(highest) + " to=" + I2S(eligible) + " award=" + I2S(awarded) + " earned=" + I2S(earned) + " master=" + I2S(master) + " selected=" + I2S(selected) + " level=" + I2S(level))
        call TT_TrimMilestonesToCount(u, eligible)
        set TT_AWARDED_MASK[heroIndex] = TT_LevelWeight(eligible) - 1
        set TT_EARNED_POINTS[heroIndex] = eligible
        call TT_NotifyTalentExcess(u, highest - eligible, eligible)
        call TT_LogFlush()
        call TT_ResetTalents(u)
        return
    endif
    if awarded < eligible then
        set missing = eligible - awarded
        call TT_LogHeroState(u, heroIndex, "POINT_RECONCILE_DEFICIT")
        call TT_LogAppend("event=POINT_RECONCILE missing=" + I2S(missing) + " awarded=" + I2S(awarded) + " eligible=" + I2S(eligible) + " level=" + I2S(level))
        call TT_GrantEarnedPoints(u)
    else
        call TT_LogHeroState(u, heroIndex, "POINT_RECONCILE_OK")
    endif
    call TT_LogFlush()
endfunction

function TT_EnsureHeroNow takes unit u returns nothing
    local integer heroIndex
    if not TT_IsTalentHero(u) then
        return
    endif
    set heroIndex = TT_RegisterHeroCore(u, true)
    if heroIndex < 0 then
        return
    endif
    if not TT_EnsureBackpack(u, heroIndex) then
        call TT_LogHeroState(u, heroIndex, "HERO_WAIT_BACKPACK")
        return
    endif
    call TT_ConsumeCampaignRestore(u, heroIndex)
    if not TT_CAMPAIGN_CACHE_LOADED[heroIndex] then
        call TT_TryCampaignCacheRestore(u, heroIndex)
    endif
    if TT_CAMPAIGN_STATE_PENDING[heroIndex] then
        call TT_ApplyCampaignTalentState(u, heroIndex)
        set TT_CAMPAIGN_STATE_PENDING[heroIndex] = false
    else
        call TT_CaptureTalentState(u)
        call TT_RestoreTalentState(u)
        call TT_EnsureTalentMaster(u, heroIndex)
    endif
    call TT_HideTalentBooks(u)
    call TT_SyncAttributeTalents(u)
    if GetUnitAbilityLevel(u, 'T405') > 0 then
        call TT_ValidateTalentPoints(u)
        return
    endif
    call TT_ResetNativeTalents(u)
    call UnitAddAbility(u, 'T405')
    call UnitMakeAbilityPermanent(u, true, 'T405')
    call BlzUnitHideAbility(u, 'T405', true)
    call TT_ValidateTalentPoints(u)
    call TT_LogHeroState(u, heroIndex, "HERO_INITIALIZED")
    call TT_LogFlush()
endfunction

function TT_EnsureHero takes unit u returns nothing
    if not TT_IsTalentHero(u) then
        return
    endif
    if not TT_START_READY then
        return
    endif
    if TT_SavedBackpackIndex(u) < 0 and TT_RegisteredHeroIndex(u) < 0 then
        if TT_IsCampaignRestoreQueued(u) then
            return
        endif
    endif
    call TT_EnsureHeroNow(u)
endfunction

function TT_HandleLevelGrant takes unit u returns nothing
    local integer heroIndex = TT_RegisteredHeroIndex(u)
    if not TT_IsTalentHero(u) then
        return
    endif
    call TT_LogHeroState(u, heroIndex, "LEVEL_BEFORE_GRANT")
    call TT_EnsureHero(u)
    set heroIndex = TT_RegisteredHeroIndex(u)
    if heroIndex >= 0 then
        call TT_ValidateTalentPoints(u)
        call TT_LogHeroState(u, heroIndex, "LEVEL_AFTER_GRANT")
        call TT_LogFlush()
    endif
endfunction

function TT_OnLevel takes nothing returns nothing
    local unit u = GetLevelingUnit()
    call TT_HandleLevelGrant(u)
    set u = null
endfunction

function TT_OnHeroSkill takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer heroIndex
    if not TT_IsTalentHero(u) then
        set u = null
        return
    endif
    call TriggerSleepAction(0.20)
    if not TT_IsTalentHero(u) then
        set u = null
        return
    endif
    set heroIndex = TT_RegisterHero(u)
    call TT_CaptureTalentState(u)
    call TT_SyncAttributeTalents(u)
    call TT_QuickSaveCampaignState(u)
    call TT_LogHeroState(u, heroIndex, "HERO_SKILL")
    call TT_LogFlush()
    set u = null
endfunction

function TT_OnPanelAbility takes nothing returns nothing
    local integer abilityId = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    if abilityId == 'AIni' or abilityId == 'AEqu' or abilityId == 'ASde' or abilityId == 'ATal' then
        call TT_LogAppend("event=PANEL_ABILITY hero=" + GetUnitName(u) + " id=" + I2S(abilityId))
        call TT_LogFlush()
    endif
    set u = null
endfunction

function TT_OnHeroDeath takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer heroIndex
    if TT_IsTalentHero(u) then
        set heroIndex = TT_RegisterHero(u)
        call TT_CaptureTalentState(u)
        if heroIndex >= 0 then
            set TT_INCIN_TARGET[heroIndex] = null
            set TT_INCIN_STACKS[heroIndex] = 0
            set TT_INCIN_LEVEL[heroIndex] = 0
            set TT_INCIN_EXPIRE[heroIndex] = 0.0
        endif
        call TT_LogHeroState(u, heroIndex, "HERO_DEATH")
        call TT_LogFlush()
    endif
    set u = null
endfunction

function TT_OnReviveSettled takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(TT_REVIVE_TABLE, GetHandleId(t), 0)
    if u != null then
        call TT_EnsureHero(u)
        call TT_RestoreTalentState(u)
        call TT_GrantEarnedPoints(u)
        call TT_LogHeroState(u, TT_RegisterHero(u), "REVIVE_SETTLED")
        call TT_LogFlush()
    endif
    call FlushChildHashtable(TT_REVIVE_TABLE, GetHandleId(t))
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

function TT_OnHeroRevive takes nothing returns nothing
    local unit u = GetRevivingUnit()
    local timer t
    if not TT_IsTalentHero(u) then
        set u = null
        return
    endif
    call TT_LogHeroState(u, TT_RegisterHero(u), "REVIVE_START")
    call TT_LogFlush()
    call TT_EnsureHero(u)
    set t = CreateTimer()
    call SaveUnitHandle(TT_REVIVE_TABLE, GetHandleId(t), 0, u)
    call TimerStart(t, 0.10, false, function TT_OnReviveSettled)
    set t = null
    set u = null
endfunction

function TT_HasExclusiveArtifact takes unit u returns boolean
    local integer i = 0
    local item it
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and (GetItemTypeId(it) == 'I103' or GetItemTypeId(it) == 'I105' or GetItemTypeId(it) == 'I106') then
            set it = null
            return true
        endif
        set i = i + 1
    endloop
    set it = null
    return false
endfunction

function TT_GrantArtifact takes unit u, integer itemId returns nothing
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local item it = CreateItem(itemId, x, y)
    if it == null then
        return
    endif
    if not UnitAddItem(u, it) then
        call SetItemPosition(it, x, y)
    endif
    call UnitAddAbility(u, 'T480')
    call UnitMakeAbilityPermanent(u, true, 'T480')
    call BlzUnitHideAbility(u, 'T480', true)
    set it = null
endfunction

function TT_SyncArtifacts takes nothing returns nothing
    local integer i = 0
    local unit u
    loop
        exitwhen i >= TT_HERO_COUNT
        set u = TT_HEROES[i]
        if TT_IsLiveHero(u) and GetUnitAbilityLevel(u, 'T480') == 0 and not TT_HasExclusiveArtifact(u) then
            if GetUnitAbilityLevel(u, 'T115') > 0 then
                call TT_GrantArtifact(u, 'I103')
            elseif GetUnitAbilityLevel(u, 'T116') > 0 then
                call TT_GrantArtifact(u, 'I106')
            elseif GetUnitAbilityLevel(u, 'T117') > 0 then
                call TT_GrantArtifact(u, 'I105')
            endif
        endif
        set i = i + 1
    endloop
    set u = null
endfunction

function TT_SyncPlayers takes nothing returns nothing
    local integer playerIndex = 0
    local unit u
    if not TT_START_READY then
        return
    endif
    loop
        exitwhen playerIndex >= bj_MAX_PLAYERS
        call GroupEnumUnitsOfPlayer(TT_SCAN_GROUP, Player(playerIndex), null)
        loop
            set u = FirstOfGroup(TT_SCAN_GROUP)
            exitwhen u == null
            call GroupRemoveUnit(TT_SCAN_GROUP, u)
            if TT_IsTalentHero(u) then
                if GetUnitAbilityLevel(u, 'T405') == 0 then
                    call TT_EnsureHero(u)
                    call TT_ResetNativeTalents(u)
                endif
                call TT_SyncAttributeTalents(u)
            endif
        endloop
        set playerIndex = playerIndex + 1
    endloop
    call TT_SyncArtifacts()
    set u = null
endfunction

function TT_OnDamage takes nothing returns nothing
    local unit victim = BlzGetEventDamageTarget()
    local unit attacker = GetEventDamageSource()
    local real damage = GetEventDamage()
    local integer selected = 0
    if TT_AOE_BUSY and victim != null and attacker != null and damage > 0.0 then
        call TT_LogAppend("event=TALENT_DAMAGE_EVENT source=" + GetUnitName(attacker) + " target=" + GetUnitName(victim) + " damage=" + R2S(damage))
    endif
    if victim != null and damage > 0.0 and IsUnitType(victim, UNIT_TYPE_HERO) and GetUnitAbilityLevel(victim, 'T112') > 0 then
        call BlzSetEventDamage(damage * 0.60)
        set damage = GetEventDamage()
    endif
    if victim != null and attacker != null and damage > 0.0 and not TT_AOE_BUSY and BlzGetEventIsAttack() then
        if IsUnitEnemy(victim, GetOwningPlayer(attacker)) and not IsUnitType(victim, UNIT_TYPE_STRUCTURE) then
            if GetUnitAbilityLevel(attacker, 'T106') > 0 then
                set selected = 106
            elseif GetUnitAbilityLevel(attacker, 'T107') > 0 then
                set selected = 107
            elseif GetUnitAbilityLevel(attacker, 'T108') > 0 then
                set selected = 108
            endif
            if selected > 0 then
                call TT_LogAppend("event=TALENT_ATTACK hero=" + GetUnitName(attacker) + " victim=" + GetUnitName(victim) + " selected=" + I2S(selected) + " damage=" + R2S(damage) + " str=" + I2S(GetHeroStr(attacker, true)) + " agi=" + I2S(GetHeroAgi(attacker, true)) + " int=" + I2S(GetHeroInt(attacker, true)))
                call TT_LogFlush()
            endif
            if selected == 106 then
                call TT_ApplyCleaveTalent(attacker, victim, damage)
            elseif selected == 107 then
                call TT_ApplyBreakthroughTalent(attacker, victim)
            elseif selected == 108 then
                call TT_ApplyIncinerateTalent(attacker, victim)
            endif
        endif
    endif
    set attacker = null
    set victim = null
endfunction

function TT_ScanInitial takes nothing returns nothing
    local unit u
    call GroupEnumUnitsInRect(TT_SCAN_GROUP, bj_mapInitialPlayableArea, null)
    loop
        set u = FirstOfGroup(TT_SCAN_GROUP)
        exitwhen u == null
        call GroupRemoveUnit(TT_SCAN_GROUP, u)
        call TT_EnsureHero(u)
    endloop
    set u = null
endfunction

function TT_MarkStartReady takes nothing returns nothing
    set TT_START_READY = true
    call TT_LogAppend("event=START_READY")
    call TT_ScanInitial()
    call TT_SyncPlayers()
    call TT_LogFlush()
endfunction

function TT_OnEnter takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call TT_EnsureHero(u)
    set u = null
endfunction

function TT_OnTrained takes nothing returns nothing
    local unit u = GetTrainedUnit()
    call TT_EnsureHero(u)
    set u = null
endfunction

function TT_OnSold takes nothing returns nothing
    local unit u = GetSoldUnit()
    call TT_EnsureHero(u)
    set u = null
endfunction

function TT_OnChat takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local group g = CreateGroup()
    local unit u
    local string command = StringCase(GetEventPlayerChatString(), false)
    local integer affected = 0
    local integer strValue
    local integer agiValue
    local integer intValue
    local integer derivedLevel
    local integer heroIndex
    if command == "talentlog" then
        call TT_LogAppend("event=MANUAL_FLUSH player=" + GetPlayerName(p))
        call TT_LogFlush()
        call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋日志]|r 已刷新 ALAS-TalentLog.txt。")
        call DestroyGroup(g)
        set g = null
        return
    endif
    if command == "talentstats" then
        call SyncSelections()
        call GroupEnumUnitsSelected(g, p, null)
        set u = FirstOfGroup(g)
        if TT_IsLiveHero(u) then
            set heroIndex = TT_RegisteredHeroIndex(u)
            set strValue = GetHeroStr(u, true)
            set agiValue = GetHeroAgi(u, true)
            set intValue = GetHeroInt(u, true)
            set derivedLevel = TT_AttributeTalentLevel(intValue)
            call TT_LogAppend("event=TALENT_STATS hero=" + GetUnitName(u) + " str=" + I2S(strValue) + " agi=" + I2S(agiValue) + " int=" + I2S(intValue) + " cleaveRadius=" + R2S(TT_CleaveRadiusForLevel(TT_AttributeTalentLevel(strValue))) + " breakthroughDamage=" + I2S(TT_BreakthroughDamage(TT_AttributeTalentLevel(agiValue))) + " burnStack=" + I2S(3 + derivedLevel) + " burnExplosion=" + I2S(80 + derivedLevel * 20))
            call TT_LogFlush()
            call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋属性]|r 力量 " + I2S(strValue) + "，敏捷 " + I2S(agiValue) + "，智力 " + I2S(intValue) + "。")
            call DisplayTextToPlayer(p, 0, 0, "分裂半径 " + R2S(TT_CleaveRadiusForLevel(TT_AttributeTalentLevel(strValue))) + "；破势每层攻速 +10%，满层践踏伤害 " + I2S(TT_BreakthroughDamage(TT_AttributeTalentLevel(agiValue))) + "、眩晕 1.5 秒；燃灰每层 " + I2S(3 + derivedLevel) + "，爆炸 " + I2S(80 + derivedLevel * 20) + "。")
            if heroIndex >= 0 then
                call DisplayTextToPlayer(p, 0, 0, "当前选择 " + TT_ActualSelectionText(u) + "；破势层数 " + I2S(TT_BREAKTHROUGH_STACKS[heroIndex]) + "；燃灰层数 " + I2S(TT_INCIN_STACKS[heroIndex]) + "。")
            endif
        else
            call DisplayTextToPlayer(p, 0, 0, "|cffff4444[天赋属性]|r 请先选中一个英雄。")
        endif
        call DestroyGroup(g)
        set g = null
        set u = null
        return
    endif
    if command != "talentreset" then
        call DestroyGroup(g)
        set g = null
        return
    endif
    call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋重置]|r 正在重置当前选中英雄的天赋……")
    call SyncSelections()
    call GroupEnumUnitsSelected(g, p, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if TT_IsLiveHero(u) then
            call TT_ResetTalents(u)
            set affected = affected + 1
        endif
    endloop
    call DestroyGroup(g)
    if affected > 0 then
        call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋重置]|r 已重置 " + I2S(affected) + " 名选中英雄的天赋，并按当前等级恢复天赋点。")
    else
        call DisplayTextToPlayer(p, 0, 0, "|cffff4444[天赋重置]|r 未选中可用英雄。")
    endif
    set g = null
    set u = null
endfunction

function TT_Init takes nothing returns nothing
    local trigger chatTrigger
    local integer i = 0
    if TT_INITED then
        return
    endif
    set TT_INITED = true
    set TT_LOG_FILE = "ALAS-TalentLog-" + I2S(TT_CAMPAIGN_CHAPTER) + ".txt"
    set TT_LOG_CLOCK = CreateTimer()
    call TimerStart(TT_LOG_CLOCK, 8640000.0, false, function TT_NoOp)
    call TT_LogAppend("event=INIT version=v137 chapter=" + I2S(TT_CAMPAIGN_CHAPTER) + " maxLevel=" + I2S(TT_MAX_LEVEL) + " points=" + I2S(TT_POINT_COUNT))
    call TT_LogFlush()
    if TT_MAX_LEVEL < 1 then
        set TT_MAX_LEVEL = 1
    endif
    set TT_POINT_COUNT = TT_MAX_LEVEL
    if TT_POINT_COUNT > 6 then
        set TT_POINT_COUNT = 6
    endif
    loop
        exitwhen i >= TT_POINT_COUNT
        if TT_MAX_LEVEL <= 6 then
            set TT_LEVEL_REQ[i] = i + 1
        else
            set TT_LEVEL_REQ[i] = 1 + ((i * (TT_MAX_LEVEL - 1) + 4) / 5)
        endif
        set i = i + 1
    endloop
    set TT_LEVEL_MARKERS[0] = 'T410'
    set TT_LEVEL_MARKERS[1] = 'T411'
    set TT_LEVEL_MARKERS[2] = 'T412'
    set TT_LEVEL_MARKERS[3] = 'T413'
    set TT_LEVEL_MARKERS[4] = 'T414'
    set TT_LEVEL_MARKERS[5] = 'T415'
    set i = 0
    set chatTrigger = CreateTrigger()
    loop
        exitwhen i >= bj_MAX_PLAYERS
        call TriggerRegisterPlayerChatEvent(chatTrigger, Player(i), "", false)
        set i = i + 1
    endloop
    call TriggerAddAction(chatTrigger, function TT_OnChat)
    set i = 0
    set TT_SCAN_GROUP = CreateGroup()
    set TT_RECT = Rect(GetRectMinX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), GetRectMaxX(bj_mapInitialPlayableArea), GetRectMaxY(bj_mapInitialPlayableArea))
    set TT_REGION = CreateRegion()
    call RegionAddRect(TT_REGION, TT_RECT)
    set TT_ENTER_TRIGGER = CreateTrigger()
    call TriggerRegisterEnterRegion(TT_ENTER_TRIGGER, TT_REGION, null)
    call TriggerAddAction(TT_ENTER_TRIGGER, function TT_OnEnter)
    set TT_TRAIN_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_TRAIN_TRIGGER, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddAction(TT_TRAIN_TRIGGER, function TT_OnTrained)
    set TT_SELL_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_SELL_TRIGGER, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddAction(TT_SELL_TRIGGER, function TT_OnSold)
    set TT_DAMAGE_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_DAMAGE_TRIGGER, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddAction(TT_DAMAGE_TRIGGER, function TT_OnDamage)
    set TT_LEVEL_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_LEVEL_TRIGGER, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(TT_LEVEL_TRIGGER, function TT_OnLevel)
    set TT_REVIVE_TABLE = InitHashtable()
    set TT_RESTORE_TABLE = InitHashtable()
    set TT_FX_TABLE = InitHashtable()
    set TT_SKILL_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_SKILL_TRIGGER, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddAction(TT_SKILL_TRIGGER, function TT_OnHeroSkill)
    set TT_PANEL_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_PANEL_TRIGGER, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(TT_PANEL_TRIGGER, function TT_OnPanelAbility)
    set TT_DEATH_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_DEATH_TRIGGER, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(TT_DEATH_TRIGGER, function TT_OnHeroDeath)
    call TriggerAddAction(TT_DEATH_TRIGGER, function TT_OnAnyUnitDeath)
    set TT_REVIVE_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(TT_REVIVE_TRIGGER, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddAction(TT_REVIVE_TRIGGER, function TT_OnHeroRevive)
    call TimerStart(CreateTimer(), 1.50, false, function TT_MarkStartReady)
    call TimerStart(CreateTimer(), 0.50, true, function TT_SyncPlayers)
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cff32cd32[天赋]|r 通用天赋已启用，最高 " + I2S(TT_MAX_LEVEL) + " 级共提供 " + I2S(TT_POINT_COUNT) + " 点，按等级平滑分配。")
    set chatTrigger = null
endfunction

function main takes nothing returns nothing
call TT_Init()

endfunction
