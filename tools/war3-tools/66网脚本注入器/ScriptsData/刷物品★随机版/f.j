function Trig_KaiQi_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(("|cFFFFCC33"+GetPlayerName(GetTriggerPlayer()))+("|r"+"|cFFFFFF00ÒÑ¿ªÆôË¢ÎïÆ·½Å±¾ |r")))
call EnableTrigger(gg_trg_CMDchufa)
endfunction
function InitTrig_KaiQi takes nothing returns nothing
set gg_trg_KaiQi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(0),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(1),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(2),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(3),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(4),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(5),"ÃÎ»ÃÐÇ¿Õ",true)
call TriggerAddAction(gg_trg_KaiQi,function Trig_KaiQi_Actions)
endfunction
function Trig_CMDchufa_Func015Func001Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func015Func001Func001A takes nothing returns nothing
call CreateItemLoc(ChooseRandomItemBJ(-1),GetUnitLoc(GetEnumUnit()))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,GetItemName(GetLastCreatedItem()))
endfunction
function Trig_CMDchufa_Func015C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-wp")
endfunction
function Trig_CMDchufa_Func016Func001Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func016Func001Func001A takes nothing returns nothing
call CreateItemLoc(ChooseRandomItemExBJ(-1,ITEM_TYPE_PERMANENT),GetUnitLoc(GetEnumUnit()))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,GetItemName(GetLastCreatedItem()))
endfunction
function Trig_CMDchufa_Func016C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)=="-wpyj")
endfunction
function Trig_CMDchufa_Actions takes nothing returns nothing
if(Trig_CMDchufa_Func015C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=S2I(SubStringBJ(GetEventPlayerChatString(),4,8))
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func015Func001Func001001002)),function Trig_CMDchufa_Func015Func001Func001A)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
if(Trig_CMDchufa_Func016C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=S2I(SubStringBJ(GetEventPlayerChatString(),6,10))
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func016Func001Func001001002)),function Trig_CMDchufa_Func016Func001Func001A)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endfunction
function InitTrig_CMDchufa takes nothing returns nothing
set gg_trg_CMDchufa=CreateTrigger()
call DisableTrigger(gg_trg_CMDchufa)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(0),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(1),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(2),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(3),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(4),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(5),"-",false)
call TriggerAddAction(gg_trg_CMDchufa,function Trig_CMDchufa_Actions)
endfunction
// ÇåÀíÎïÆ·
function fy_qwp1 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Fy_qwp2 takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function fy_qwp1)
endfunction
function FY_qingliwp takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"qingli",true)
set i=i+1
endloop
call TriggerAddAction(t,function Fy_qwp2)
endfunction