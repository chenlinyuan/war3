group TT_SCAN_GROUP = null
region TT_REGION = null
rect TT_RECT = null
trigger TT_ENTER_TRIGGER = null
trigger TT_TRAIN_TRIGGER = null
trigger TT_SELL_TRIGGER = null
trigger TT_DAMAGE_TRIGGER = null
trigger TT_LEVEL_TRIGGER = null
boolean TT_INITED = false
integer TT_HERO_COUNT = 0
unit array TT_HEROES
boolean array TT_BACKPACK_ATTEMPTED
integer array TT_LEVEL_MARKERS
integer array TT_LEVEL_REQ
integer TT_MAX_LEVEL = 10
integer TT_POINT_COUNT = 6

function TT_IsLiveHero takes unit u returns boolean
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    return IsUnitType(u, UNIT_TYPE_HERO)
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
            if it != null and GetItemTypeId(it) == TT_BackpackId(heroIndex) then
                set it = null
                return heroIndex
            endif
            set slot = slot + 1
        endloop
        set heroIndex = heroIndex + 1
    endloop
    set it = null
    return -1
endfunction

function TT_RegisterHero takes unit u returns integer
    local integer i = 0
    local integer savedIndex = -1
    if u == null or GetUnitTypeId(u) == 0 then
        return -1
    endif
    loop
        exitwhen i >= TT_HERO_COUNT
        if TT_HEROES[i] == u then
            return i
        endif
        set i = i + 1
    endloop
    set savedIndex = TT_SavedBackpackIndex(u)
    if savedIndex >= 0 and TT_HEROES[savedIndex] == null then
        set TT_HEROES[savedIndex] = u
        set TT_BACKPACK_ATTEMPTED[savedIndex] = true
        if TT_HERO_COUNT <= savedIndex then
            set TT_HERO_COUNT = savedIndex + 1
        endif
        return savedIndex
    endif
    set i = 0
    loop
        exitwhen i >= 64
        if TT_HEROES[i] == null then
            set TT_HEROES[i] = u
            set TT_BACKPACK_ATTEMPTED[i] = false
            if TT_HERO_COUNT <= i then
                set TT_HERO_COUNT = i + 1
            endif
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function TT_TalentId takes integer heroIndex returns integer
    return 'Q000' + (heroIndex / 10) * 256 + (heroIndex - (heroIndex / 10) * 10)
endfunction

function TT_EnsureBackpack takes unit u, integer heroIndex returns nothing
    local integer i = 0
    local integer desiredId = TT_BackpackId(heroIndex)
    local item it
    local real x
    local real y
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null then
            if GetItemTypeId(it) == desiredId then
                set TT_BACKPACK_ATTEMPTED[heroIndex] = true
                set it = null
                return
            endif
            if GetItemTypeId(it) == 'B30B' then
                call RemoveItem(it)
            endif
        endif
        set i = i + 1
    endloop
    if TT_BACKPACK_ATTEMPTED[heroIndex] then
        set it = null
        return
    endif
    set TT_BACKPACK_ATTEMPTED[heroIndex] = true
    set x = GetUnitX(u)
    set y = GetUnitY(u)
    set it = CreateItem(TT_BackpackId(heroIndex), x, y)
    if it != null and not UnitAddItem(u, it) then
        call SetItemPosition(it, x, y)
    endif
    set it = null
endfunction

function TT_GrantTestPoints takes unit u, integer amount returns nothing
    local integer i = 0
    local item it
    loop
        exitwhen i >= amount
        set it = UnitAddItemById(u, 'ttal')
        if it != null then
            call UnitUseItem(u, it)
            if GetItemTypeId(it) == 'ttal' then
                call RemoveItem(it)
            endif
        endif
        set it = null
        set i = i + 1
    endloop
endfunction

function TT_GrantEarnedPoints takes unit u returns nothing
    local integer i = 0
    local integer level = GetHeroLevel(u)
    loop
        exitwhen i >= TT_POINT_COUNT
        if level >= TT_LEVEL_REQ[i] and GetUnitAbilityLevel(u, TT_LEVEL_MARKERS[i]) == 0 then
            call UnitAddAbility(u, TT_LEVEL_MARKERS[i])
            call UnitMakeAbilityPermanent(u, true, TT_LEVEL_MARKERS[i])
            call BlzUnitHideAbility(u, TT_LEVEL_MARKERS[i], true)
            call TT_GrantTestPoints(u, 1)
        endif
        set i = i + 1
    endloop
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
    if GetUnitAbilityLevel(u, 'T103') > 0 then
        call BlzUnitHideAbility(u, 'T103', true)
    endif
    if GetUnitAbilityLevel(u, 'T104') > 0 then
        call BlzUnitHideAbility(u, 'T104', true)
    endif
    if GetUnitAbilityLevel(u, 'T105') > 0 then
        call BlzUnitHideAbility(u, 'T105', true)
    endif
    if GetUnitAbilityLevel(u, 'T108') > 0 then
        call BlzUnitHideAbility(u, 'T108', true)
    endif
    if GetUnitAbilityLevel(u, 'T112') > 0 then
        call BlzUnitHideAbility(u, 'T112', true)
    endif
    if GetUnitAbilityLevel(u, 'T113') > 0 then
        call BlzUnitHideAbility(u, 'T113', true)
    endif
    if GetUnitAbilityLevel(u, 'T114') > 0 then
        call BlzUnitHideAbility(u, 'T114', true)
    endif
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

function TT_ResetTalents takes unit u returns nothing
    local integer i = 0
    call BlzResetUnitTalents(u)
    loop
        exitwhen i >= 18
        call UnitRemoveAbility(u, TT_TalentAbilityId(100 + i))
        set i = i + 1
    endloop
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
    call TT_ClearTalentMilestones(u)
    call TT_GrantEarnedPoints(u)
    call TT_HideTalentBooks(u)
endfunction

function TT_EnsureHero takes unit u returns nothing
    local integer heroIndex
    if not TT_IsLiveHero(u) then
        return
    endif
    set heroIndex = TT_RegisterHero(u)
    if heroIndex < 0 then
        return
    endif
    call TT_EnsureBackpack(u, heroIndex)
    call TT_HideTalentBooks(u)
    if GetUnitAbilityLevel(u, 'T405') > 0 then
        return
    endif
    call TT_ResetNativeTalents(u)
    call UnitAddAbility(u, 'T405')
    call UnitMakeAbilityPermanent(u, true, 'T405')
    call BlzUnitHideAbility(u, 'T405', true)
    call TT_GrantEarnedPoints(u)
endfunction

function TT_OnLevel takes nothing returns nothing
    local unit u = GetLevelingUnit()
    call TT_EnsureHero(u)
    call TT_GrantEarnedPoints(u)
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
    loop
        exitwhen playerIndex >= bj_MAX_PLAYERS
        call GroupEnumUnitsOfPlayer(TT_SCAN_GROUP, Player(playerIndex), null)
        loop
            set u = FirstOfGroup(TT_SCAN_GROUP)
            exitwhen u == null
            call GroupRemoveUnit(TT_SCAN_GROUP, u)
            if TT_IsLiveHero(u) then
                call TT_EnsureHero(u)
                call TT_GrantEarnedPoints(u)
                call TT_ResetNativeTalents(u)
            endif
        endloop
        set playerIndex = playerIndex + 1
    endloop
    call TT_SyncArtifacts()
    set u = null
endfunction

function TT_OnDamage takes nothing returns nothing
    local unit victim = BlzGetEventDamageTarget()
    local real damage = GetEventDamage()
    if victim != null and damage > 0.0 and IsUnitType(victim, UNIT_TYPE_HERO) and GetUnitAbilityLevel(victim, 'T112') > 0 then
        call BlzSetEventDamage(damage * 0.60)
    endif
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
    if command != "talentreset" then
        call DestroyGroup(g)
        set g = null
        return
    endif
    call GroupEnumUnitsOfPlayer(g, p, null)
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
        call DisplayTextToPlayer(p, 0, 0, "|cff32cd32[天赋重置]|r 已重置 " + I2S(affected) + " 名英雄的天赋，并按当前等级恢复天赋点。")
    else
        call DisplayTextToPlayer(p, 0, 0, "|cffff4444[天赋重置]|r 没有找到英雄。")
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
    set chatTrigger = CreateTrigger()
    loop
        exitwhen i >= bj_MAX_PLAYERS
        call TriggerRegisterPlayerChatEvent(chatTrigger, Player(i), "talentreset", true)
        set i = i + 1
    endloop
    call TriggerAddAction(chatTrigger, function TT_OnChat)
    call TimerStart(CreateTimer(), 0.35, false, function TT_ScanInitial)
    call TimerStart(CreateTimer(), 0.50, true, function TT_SyncPlayers)
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cff32cd32[天赋]|r 通用天赋已启用，最高 " + I2S(TT_MAX_LEVEL) + " 级共提供 " + I2S(TT_POINT_COUNT) + " 点，按等级平滑分配。")
    set chatTrigger = null
endfunction

call TT_Init()
