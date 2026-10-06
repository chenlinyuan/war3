function Trig_QC_Func003A takes nothing returns nothing
set udg_playernum=(udg_playernum+1)
endfunction
function Trig_QC_Func004Func001Func003C takes nothing returns boolean
if (not (GetItemLevel(GetEnumItem())==0)) then
return false
endif
if (not(GetItemType(GetEnumItem())!=ITEM_TYPE_CHARGED)) then
return false
endif
return true
endfunction
function Trig_QC_Func004Func001C takes nothing returns boolean
if (not Trig_QC_Func004Func001Func003C()) then
return false
endif
return true
endfunction
function Trig_QC_Func004A takes nothing returns nothing
if (Trig_QC_Func004Func001C()) then
set udg_itemnum=(udg_itemnum+1)
else
call DoNothing()
endif
call RemoveItem(GetEnumItem())
endfunction
function Trig_QC_Func005A takes nothing returns nothing
call AdjustPlayerStateBJ((udg_itemnum*(90/(udg_playernum-1))), GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
endfunction
function Trig_QC_Actions takes nothing returns nothing
set udg_allmap=GetEntireMapRect()
set udg_onlineplayers=GetPlayersEnemies(Player(11))
call ForForce(udg_onlineplayers, function Trig_QC_Func003A )
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF0010秒后清除地面物品|r")
call TriggerSleepAction(10.00)     
call EnumItemsInRectBJ( udg_allmap, function Trig_QC_Func004A )
call ForForce(udg_onlineplayers, function Trig_QC_Func005A )
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF00物品已经清除|r")
set udg_itemnum=0
set udg_playernum=0
call RemoveRect(udg_allmap)
call DestroyForce(udg_onlineplayers)
endfunction
function InitTrig_QC takes nothing returns nothing
local integer i=0
set gg_trg_QC=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(gg_trg_QC,Player(i), "-q",true )
set i=i+1
endloop
call TriggerAddAction(gg_trg_QC,function Trig_QC_Actions)
endfunction