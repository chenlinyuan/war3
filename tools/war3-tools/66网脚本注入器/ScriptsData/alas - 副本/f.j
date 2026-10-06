function isPlayerSelectedHeroUnit takes nothing returns boolean
    return ( ( ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true ) and ( IsUnitSelected(GetFilterUnit(), Player(0)) == true ) ) )
endfunction

function addItem takes integer items returns nothing
    if udg_skillIdToAdd != 0 then
    call UnitAddItemById(GetEnumUnit(), items)
    endif
endfunction
function addItemD takes nothing returns nothing
    call addItem(udg_skillIdToAdd)
    set udg_skillIdToAdd=0
endfunction
function addItemToSelectedHeroDetail takes integer items returns nothing
    set udg_skillIdToAdd=items
    call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0) , Condition(function isPlayerSelectedHeroUnit)), function addItemD)
endfunction
function Trig_addItemActions takes nothing returns nothing
    call addItemToSelectedHeroDetail('modt')
endfunction

function InitTrig_addItem_DeathMask takes nothing returns nothing
    set gg_trg_addItem_DeathMask=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_addItem_DeathMask, Player(0), "addItem DeathMask", true)
    call TriggerAddAction(gg_trg_addItem_DeathMask, function Trig_addItemActions)
endfunction

function Trig_addItemGlovesOfHaste takes nothing returns nothing
    call addItemToSelectedHeroDetail('gcel')
endfunction

function InitTrig_addItem_GlovesOfHaste takes nothing returns nothing
    set gg_trg_addItem_GlovesOfHaste=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_addItem_GlovesOfHaste, Player(0), "addItem GlovesOfHaste", true)
    call TriggerAddAction(gg_trg_addItem_GlovesOfHaste, function Trig_addItemGlovesOfHaste)
endfunction

function Trig_addItemNecklace takes nothing returns nothing
    call addItemToSelectedHeroDetail('nspi')
endfunction

function InitTrig_addItem_Necklace takes nothing returns nothing
    set gg_trg_addItem_Necklace=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_addItem_Necklace, Player(0), "addItem Necklace", true)
    call TriggerAddAction(gg_trg_addItem_Necklace, function Trig_addItemNecklace)
endfunction