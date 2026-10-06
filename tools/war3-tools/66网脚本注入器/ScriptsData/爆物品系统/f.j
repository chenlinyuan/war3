function Trig_erfsfd_Func007C takes nothing returns boolean
return(SubString(udg_sliubos,0,5)=="baoli")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func008C takes nothing returns boolean
return(GetEventPlayerChatString()=="关闭提示")
endfunction
function Trig_erfsfd_Func009C takes nothing returns boolean
return(GetEventPlayerChatString()=="飞飞世界")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz)==false)
endfunction
function Trig_erfsfd_Func010C takes nothing returns boolean
return(GetEventPlayerChatString()=="关闭")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
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
return(GetEventPlayerChatString()=="清除")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func012Func002A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_erfsfd_Func012C takes nothing returns boolean
return(GetEventPlayerChatString()=="全部清除")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
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
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("您当前的爆率为："+(R2S((udg_ccliubocc*100.))+"%")))
endif
if(Trig_erfsfd_Func008C())then
call DestroyTrigger(gg_trg_sdeewew)
endif
if(Trig_erfsfd_Func009C())then
set udg_itp[(1+GetPlayerId(GetTriggerPlayer()))]=((1+GetPlayerId(GetTriggerPlayer()))+123456)
call ForceAddPlayer(udg_zliuboz,GetTriggerPlayer())
set udg_ccliubocc=((.0+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))]))/(100.+I2R(udg_cliuboc[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"开启爆物品模式！")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("您当前的爆率为："+(R2S((udg_ccliubocc*100.))+"%")))
endif
if(Trig_erfsfd_Func010C())then
set udg_itp[(1+GetPlayerId(GetTriggerPlayer()))]=0
call ForceRemovePlayer(udg_zliuboz,GetTriggerPlayer())
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"关闭爆物品模式！")
endif
if(Trig_erfsfd_Func011C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,(GetPlayerName(GetTriggerPlayer())+"输入了“清除”，清除了属于他的物品。"))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call EnumItemsInRectBJ(GetWorldBounds(),function Trig_erfsfd_Func011Func002A)
endif
if(Trig_erfsfd_Func012C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,(GetPlayerName(GetTriggerPlayer())+"输入了“全部清除”，清除了地图的全部物品，大家一起揍他吧！"))
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
call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,"这个物品不属于你！")
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
call DisplayTextToPlayer(Player(-1+(bj_forLoopAIndex)),0,0,"欢迎使用爆物品模式系统。
开启方式为输入“飞飞世界”，关闭方式为输入“关闭”。
可以通过输入“baoli+数字”来修改爆率。
可以通过输入“清除”来清除属于自己爆的物品。
可以通过输入“全部清除”来清楚所有物品。
可以通过输入“关闭提示”关闭这个信息提示。")
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction