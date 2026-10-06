function Trig_KaiQi_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(("|cFFFFCC33"+GetPlayerName(GetTriggerPlayer()))+("|r"+"|cFFFFFF00已开启刷物品脚本 |r")))
call EnableTrigger(gg_trg_CMDchufa)
endfunction
function InitTrig_KaiQi takes nothing returns nothing
set gg_trg_KaiQi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(0),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(1),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(2),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(3),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(4),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(5),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(6),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(7),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(8),"梦幻星空",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(9),"梦幻星空",true)
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
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(6),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(7),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(8),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(9),"-",false)
call TriggerAddAction(gg_trg_CMDchufa,function Trig_CMDchufa_Actions)
endfunction
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
function Trig_erfsfd_Func007C takes nothing returns boolean
return(SubString(udg_sliubos,0,5)=="baoli")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func008C takes nothing returns boolean
return(GetEventPlayerChatString()=="GT")
endfunction
function Trig_erfsfd_Func009C takes nothing returns boolean
return(GetEventPlayerChatString()=="OTT")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz)==false)
endfunction
function Trig_erfsfd_Func010C takes nothing returns boolean
return(GetEventPlayerChatString()=="GB")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func011Func002Func001C takes nothing returns boolean
return(GetItemUserData(GetFilterItem())==((1+GetPlayerId(GetTriggerPlayer()))+123456))
endfunction
function Trig_erfsfd_Func011Func002A takes nothing returns nothing
if(Trig_erfsfd_Func011Func002Func001C())then
call RemoveItem(GetEnumItem())
endif
endfunction
function Trig_erfsfd_Func011C takes nothing returns boolean
return(GetEventPlayerChatString()=="QC")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func012Func002A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_erfsfd_Func012C takes nothing returns boolean
return(GetEventPlayerChatString()=="QQC")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Actions takes nothing returns nothing
local item it
local location p
local real x
local real y
local string s
set udg_sliubos=GetEventPlayerChatString()
if(Trig_erfsfd_Func007C())then
set udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubString(udg_sliubos,5,10))
set udg_ccliubocc=((.0+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))]))/(100.+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(".："+(R2S((udg_ccliubocc*100.))+"%")))
endif
if(Trig_erfsfd_Func008C())then
call DestroyTrigger(gg_trg_sdeewew)
endif
if(Trig_erfsfd_Func009C())then
set udg_itp[(1+GetPlayerId(GetTriggerPlayer()))]=((1+GetPlayerId(GetTriggerPlayer()))+123456)
call ForceAddPlayer(udg_zliuboz,GetTriggerPlayer())
set udg_ccliubocc=((.0+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))]))/(100.+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,".")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(".："+(R2S((udg_ccliubocc*100.))+"%")))
endif
if(Trig_erfsfd_Func010C())then
set udg_itp[(1+GetPlayerId(GetTriggerPlayer()))]=0
call ForceRemovePlayer(udg_zliuboz,GetTriggerPlayer())
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,".")
endif
if(Trig_erfsfd_Func011C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,(GetPlayerName(GetTriggerPlayer())+"."))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call EnumItemsInRectBJ(GetWorldBounds(),function Trig_erfsfd_Func011Func002A)
endif
if(Trig_erfsfd_Func012C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,(GetPlayerName(GetTriggerPlayer())+"."))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call EnumItemsInRectBJ(GetWorldBounds(),function Trig_erfsfd_Func012Func002A)
endif
endfunction
function Trig_sdfaw_Func001C takes nothing returns boolean
return(udg_itp[(1+GetPlayerId(GetOwningPlayer(GetManipulatingUnit())))]==udg_itpp[(1+GetPlayerId(GetOwningPlayer(GetManipulatingUnit())))])
endfunction
function Trig_sdfaw_Actions takes nothing returns nothing
if(Trig_sdfaw_Func001C())then
else
call UnitRemoveItemSwapped(GetManipulatedItem(),GetTriggerUnit())
call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,".")
endif
endfunction
function Trig_sdqwaa_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_cliuboc[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=10
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_sdqasdf_Func001C takes nothing returns boolean
return((GetRandomInt(1,('d'+udg_cliuboc[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))]))+1)<=udg_cliuboc[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))])and(IsPlayerEnemy(GetOwningPlayer(GetDyingUnit()),GetOwningPlayer(GetKillingUnit())))and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetKillingUnit()))==MAP_CONTROL_USER)and(IsPlayerInForce(GetOwningPlayer(GetKillingUnit()),udg_zliuboz))
endfunction
function Trig_sdqasdf_Actions takes nothing returns nothing
if(Trig_sdqasdf_Func001C())then
set udg_pliubox=GetUnitLoc(GetTriggerUnit())
set udg_itliuboit=CreateItemLoc(ChooseRandomItemExBJ(-1,ITEM_TYPE_ANY),udg_pliubox)
set udg_itpp[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))]=((1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))+123456)
call SetItemUserData(udg_itliuboit,udg_itpp[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))])
call RemoveLocation(udg_pliubox)
endif
endfunction
function Trig_sdeewew_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,".
.
.")
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction