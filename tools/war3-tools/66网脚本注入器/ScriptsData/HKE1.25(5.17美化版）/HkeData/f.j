function wujunyou33_Z64 takes real wujunyou33_Z74,location wujunyou33_Z84 returns group
set wujunyou33_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(wujunyou33_Z14,wujunyou33_Z84,wujunyou33_Z74,wujunyou33_Z34)
return wujunyou33_Z14
endfunction
function wujunyou33_Z94 takes player wujunyou33_zZ4 returns group
set wujunyou33_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(wujunyou33_Z14,wujunyou33_zZ4,wujunyou33_Z34)
return wujunyou33_Z14
endfunction
function wujunyou33_zz4 takes player wujunyou33_zZ4,integer wujunyou33_z04 returns group
set wujunyou33_Z14=CreateGroup()
set bj_groupEnumTypeId=wujunyou33_z04
call GroupEnumUnitsOfPlayer(wujunyou33_Z14,wujunyou33_zZ4,filterGetUnitsOfPlayerAndTypeId)
return wujunyou33_Z14
endfunction
function wujunyou33_z14 takes player wujunyou33_zZ4 returns force
set wujunyou33_Z24=CreateForce()
call ForceEnumAllies(wujunyou33_Z24,wujunyou33_zZ4,wujunyou33_Z34)
return wujunyou33_Z24
endfunction
function wujunyou33_z24 takes player wujunyou33_zZ4 returns force
set wujunyou33_Z24=CreateForce()
call ForceEnumEnemies(wujunyou33_Z24,wujunyou33_zZ4,wujunyou33_Z34)
return wujunyou33_Z24
endfunction
function wujunyou33_Z45 takes trigger wujunyou33_Z55,player wujunyou33_Z65,integer wujunyou33_Z75 returns nothing
local playerevent wujunyou33_Z85=ConvertPlayerEvent(wujunyou33_Z75)
call TriggerRegisterPlayerEvent(wujunyou33_Z55,wujunyou33_Z65,wujunyou33_Z85)
set wujunyou33_Z85=null
endfunction
function wujunyou33_Z95 takes trigger wujunyou33_Z55,player wujunyou33_Z65,integer wujunyou33_Z75 returns nothing
local playerunitevent wujunyou33_Z85=ConvertPlayerUnitEvent(wujunyou33_Z75)
call TriggerRegisterPlayerUnitEvent(wujunyou33_Z55,wujunyou33_Z65,wujunyou33_Z85,null)
set wujunyou33_Z85=null
endfunction
function wujunyou33_zZ5 takes integer wujunyou33_Z75,player wujunyou33_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(wujunyou33_Z30[wujunyou33_Z75],wujunyou33_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(wujunyou33_Z50[wujunyou33_Z75],wujunyou33_Z65,ConvertPlayerUnitEvent(25),null)
call wujunyou33_Z45(wujunyou33_Z70[wujunyou33_Z75],wujunyou33_Z65,17)
call wujunyou33_Z45(wujunyou33_Z90[wujunyou33_Z75],wujunyou33_Z65,266)
call wujunyou33_Z45(wujunyou33_Z80[wujunyou33_Z75],wujunyou33_Z65,268)
call wujunyou33_Z45(wujunyou33_zZ0[wujunyou33_Z75],wujunyou33_Z65,262)
call wujunyou33_Z45(wujunyou33_zz0[wujunyou33_Z75],wujunyou33_Z65,264)
call TriggerRegisterTimerExpireEvent(wujunyou33_z43,wujunyou33_z0Z[wujunyou33_Z75])
call TriggerRegisterTimerExpireEvent(wujunyou33_z33,wujunyou33_Z73[wujunyou33_Z75])
call wujunyou33_Z95(wujunyou33_Z40[wujunyou33_Z75],wujunyou33_Z65,32)
call wujunyou33_Z95(wujunyou33_Z60[wujunyou33_Z75],wujunyou33_Z65,35)
call TriggerRegisterDialogEvent(wujunyou33_ZZ1[wujunyou33_Z75],wujunyou33_zZ1[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Zz2[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Zz1[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z01[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z81[wujunyou33_Z75],wujunyou33_Z91[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z71[wujunyou33_Z75],wujunyou33_zZ1[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z21[wujunyou33_Z75],wujunyou33_Z91[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z31[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z22[wujunyou33_Z75],wujunyou33_Z91[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z11[wujunyou33_Z75],wujunyou33_Z91[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z51[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z41[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z61[wujunyou33_Z75],wujunyou33_Z91[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z12[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z02[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z23[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call TriggerRegisterDialogEvent(wujunyou33_Z13[wujunyou33_Z75],wujunyou33_Z20[wujunyou33_Z75])
call wujunyou33_Z95(wujunyou33_z01[wujunyou33_Z75],wujunyou33_Z65,38)
call wujunyou33_Z95(wujunyou33_z11[wujunyou33_Z75],wujunyou33_Z65,39)
call wujunyou33_Z95(wujunyou33_z21[wujunyou33_Z75],wujunyou33_Z65,40)
call wujunyou33_Z95(wujunyou33_z80[wujunyou33_Z75],wujunyou33_Z65,276)
call wujunyou33_Z95(wujunyou33_z80[wujunyou33_Z75],wujunyou33_Z65,275)
call wujunyou33_Z95(wujunyou33_z90[wujunyou33_Z75],wujunyou33_Z65,276)
call wujunyou33_Z95(wujunyou33_z90[wujunyou33_Z75],wujunyou33_Z65,275)
call wujunyou33_Z95(wujunyou33_ZZ3[wujunyou33_Z75],wujunyou33_Z65,18)
call TriggerRegisterPlayerStateEvent(wujunyou33_z60[wujunyou33_Z75],wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(wujunyou33_z40[wujunyou33_Z75],wujunyou33_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(wujunyou33_z50[wujunyou33_Z75],wujunyou33_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call wujunyou33_Z95(wujunyou33_z70[wujunyou33_Z75],wujunyou33_Z65,20)
call TriggerRegisterPlayerChatEvent(wujunyou33_zz1[wujunyou33_Z75],wujunyou33_Z65,"-",false)
call wujunyou33_Z95(wujunyou33_Z6z[wujunyou33_Z75],wujunyou33_Z65,39)
set wujunyou33_Z3z[wujunyou33_Z75]=true
endfunction
function wujunyou33_zz5 takes player wujunyou33_z05,integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_z25)then
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)+wujunyou33_z15)
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(wujunyou33_z05,PLAYER_STATE_GOLD_GATHERED)-wujunyou33_z15)
else
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)-wujunyou33_z15)
endif
endfunction
function wujunyou33_z35 takes player wujunyou33_z05,integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_z25)then
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)+wujunyou33_z15)
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(wujunyou33_z05,PLAYER_STATE_LUMBER_GATHERED)-wujunyou33_z15)
else
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)-wujunyou33_z15)
endif
endfunction
function wujunyou33_z45 takes player wujunyou33_z05 returns nothing
local player wujunyou33_Z65=GetLocalPlayer()
if wujunyou33_z05==wujunyou33_Z65 then
set wujunyou33_Z65=Player(-1)
endif
set wujunyou33_Z65=null
endfunction
function wujunyou33_z55 takes unit wujunyou33_z65,unit wujunyou33_z75,boolean wujunyou33_z85 returns nothing
local location wujunyou33_z95
local location wujunyou33_ZZ6
set wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
set wujunyou33_ZZ6=GetUnitLoc(wujunyou33_z75)
call SetUnitPositionLoc(wujunyou33_z65,wujunyou33_ZZ6)
if(wujunyou33_z85)then
call SetUnitPositionLoc(wujunyou33_z75,wujunyou33_z95)
call SetUnitPositionLoc(wujunyou33_z65,wujunyou33_ZZ6)
endif
call RemoveLocation(wujunyou33_z95)
call RemoveLocation(wujunyou33_ZZ6)
set wujunyou33_z95=null
set wujunyou33_ZZ6=null
endfunction
function wujunyou33_Zz6 takes integer wujunyou33_Z06 returns nothing
if(wujunyou33_Z06==0)then
set wujunyou33_zZ2=100
set wujunyou33_Z92=100
set wujunyou33_Z82=100
set wujunyou33_Z72="|cFFFFFFFF"
return
endif
if(wujunyou33_Z06==1)then
set wujunyou33_zZ2=50
set wujunyou33_Z92=50
set wujunyou33_Z82=50
set wujunyou33_Z72="|cFF7F7F7F"
return
endif
if(wujunyou33_Z06==2)then
set wujunyou33_zZ2=0
set wujunyou33_Z92=0
set wujunyou33_Z82=0
set wujunyou33_Z72="|cFF000000"
return
endif
if(wujunyou33_Z06==3)then
set wujunyou33_zZ2=100
set wujunyou33_Z92=0
set wujunyou33_Z82=0
set wujunyou33_Z72="|cFFFF0000"
return
endif
if(wujunyou33_Z06==4)then
set wujunyou33_zZ2=100
set wujunyou33_Z92=50
set wujunyou33_Z82=0
set wujunyou33_Z72="|cFFFF7F00"
return
endif
if(wujunyou33_Z06==5)then
set wujunyou33_zZ2=100
set wujunyou33_Z92=100
set wujunyou33_Z82=0
set wujunyou33_Z72="|cFFFFFF00"
return
endif
if(wujunyou33_Z06==6)then
set wujunyou33_zZ2=0
set wujunyou33_Z92=100
set wujunyou33_Z82=0
set wujunyou33_Z72="|cFF00FF00"
return
endif
if(wujunyou33_Z06==7)then
set wujunyou33_zZ2=0
set wujunyou33_Z92=100
set wujunyou33_Z82=100
set wujunyou33_Z72="|cFF00FFFF"
return
endif
if(wujunyou33_Z06==8)then
set wujunyou33_zZ2=0
set wujunyou33_Z92=0
set wujunyou33_Z82=100
set wujunyou33_Z72="|cFF0000FF"
return
endif
if(wujunyou33_Z06==9)then
set wujunyou33_zZ2=100
set wujunyou33_Z92=0
set wujunyou33_Z82=100
set wujunyou33_Z72="|cFFFF00FF"
return
endif
endfunction
function wujunyou33_Z16 takes integer wujunyou33_Z06,unit wujunyou33_Z26,string wujunyou33_Z36 returns nothing
local texttag wujunyou33_Z46
local location wujunyou33_z95
call wujunyou33_Zz6(wujunyou33_Z06)
set wujunyou33_z95=GetUnitLoc(wujunyou33_Z26)
set wujunyou33_Z46=CreateTextTagLocBJ(wujunyou33_Z36,wujunyou33_z95,0,20,wujunyou33_zZ2,wujunyou33_Z92,wujunyou33_Z82,0)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
call SetTextTagPermanent(wujunyou33_Z46,false)
call SetTextTagLifespan(wujunyou33_Z46,wujunyou33_Z1)
set wujunyou33_Z46=null
endfunction
function wujunyou33_Z56 takes nothing returns nothing
local trigger wujunyou33_Z66=GetTriggeringTrigger()
local timer wujunyou33_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(wujunyou33_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(wujunyou33_z52)
call DestroyTimerDialog(wujunyou33_z82)
call DestroyTimer(wujunyou33_Z76)
set wujunyou33_Z66=null
set wujunyou33_Z76=null
endfunction
function wujunyou33_Z86 takes nothing returns nothing
local timer wujunyou33_Z76
local trigger wujunyou33_Z66
if(wujunyou33_z62)then
else
set wujunyou33_z52=GetGameSpeed()
set wujunyou33_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set wujunyou33_Z66=CreateTrigger()
set wujunyou33_Z76=CreateTimer()
call StartTimerBJ(wujunyou33_Z76,false,wujunyou33_z42)
set wujunyou33_z82=CreateTimerDialogBJ(wujunyou33_Z76,"子弹时间")
call TriggerAddAction(wujunyou33_Z66,function wujunyou33_Z56)
call TriggerRegisterTimerExpireEvent(wujunyou33_Z66,wujunyou33_Z76)
endif
endfunction
function wujunyou33_Z96 takes trigger wujunyou33_zZ6 returns nothing
if(IsTriggerEnabled(wujunyou33_zZ6))then
call DisableTrigger(wujunyou33_zZ6)
else
call EnableTrigger(wujunyou33_zZ6)
endif
endfunction
function wujunyou33_zz6 takes trigger wujunyou33_zZ6,boolean wujunyou33_z06 returns nothing
if(IsTriggerEnabled(wujunyou33_zZ6)==wujunyou33_z06)then
else
call wujunyou33_Z96(wujunyou33_zZ6)
endif
endfunction
function wujunyou33_z16 takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
call wujunyou33_zz6(wujunyou33_z40[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_z50[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_z60[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_z80[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_z70[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_z90[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_zz6(wujunyou33_ZZ3[wujunyou33_z15],wujunyou33_z25)
endfunction
function wujunyou33_z26 takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
if(GetUnitUserData(wujunyou33_z65)==2176)then
call RemoveUnit(wujunyou33_z65)
endif
set wujunyou33_z65=null
endfunction
function wujunyou33_z36 takes player wujunyou33_z05 returns nothing
local group wujunyou33_z46
if(wujunyou33_Z42[GetPlayerId(wujunyou33_z05)])then
set wujunyou33_z46=wujunyou33_Z94(wujunyou33_z05)
call ForGroup(wujunyou33_z46,function wujunyou33_z26)
set wujunyou33_Z42[GetPlayerId(wujunyou33_z05)]=false
call DestroyGroup(wujunyou33_z46)
set wujunyou33_z46=null
endif
endfunction
function wujunyou33_z56 takes unit wujunyou33_z65,player wujunyou33_z05 returns nothing
local location wujunyou33_z95
local integer wujunyou33_z66
local unit wujunyou33_z76
local item wujunyou33_z86
local integer wujunyou33_Z75=0
if(IsUnitType(wujunyou33_z65,UNIT_TYPE_HERO))then
set wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
set wujunyou33_z66=GetUnitTypeId(wujunyou33_z65)
set wujunyou33_z76=CreateUnitAtLoc(wujunyou33_z05,wujunyou33_z66,wujunyou33_z95,bj_UNIT_FACING)
call SetUnitUserData(wujunyou33_z76,2176)
set wujunyou33_Z42[GetPlayerId(wujunyou33_z05)]=true
if(wujunyou33_Z6Z)then
call SetUnitUseFood(wujunyou33_z76,false)
endif
call SetHeroLevelBJ(wujunyou33_z76,GetHeroLevel(wujunyou33_z65),false)
call SetHeroStat(wujunyou33_z76,0,GetHeroStatBJ(0,wujunyou33_z65,false))
call SetHeroStat(wujunyou33_z76,1,GetHeroStatBJ(1,wujunyou33_z65,false))
call SetHeroStat(wujunyou33_z76,2,GetHeroStatBJ(2,wujunyou33_z65,false))
loop
exitwhen wujunyou33_Z75>5
set wujunyou33_z86=UnitItemInSlot(wujunyou33_z65,wujunyou33_Z75)
call UnitAddItemById(wujunyou33_z76,GetItemTypeId(wujunyou33_z86))
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
endif
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
set wujunyou33_z76=null
set wujunyou33_z86=null
endfunction
function wujunyou33_z96 takes integer wujunyou33_ZZ7,player wujunyou33_Zz7,location wujunyou33_Z07,boolean wujunyou33_Z17,boolean wujunyou33_Z27 returns nothing
local unit wujunyou33_z76
set wujunyou33_z76=CreateUnitAtLoc(wujunyou33_Zz7,wujunyou33_ZZ7,wujunyou33_Z07,bj_UNIT_FACING)
if(wujunyou33_Z6Z)then
call SetUnitUseFood(wujunyou33_z76,false)
endif
if(wujunyou33_Z17)then
call SetUnitUserData(wujunyou33_z76,2176)
endif
if(wujunyou33_Z27)then
call UnitApplyTimedLife(wujunyou33_z76,1112820806,90)
endif
set wujunyou33_z76=null
endfunction
function wujunyou33_Z37 takes integer wujunyou33_ZZ7,player wujunyou33_Zz7,location wujunyou33_Z07 returns nothing
local unit wujunyou33_z76
set wujunyou33_z76=CreateUnitAtLoc(wujunyou33_Zz7,wujunyou33_ZZ7,wujunyou33_Z07,bj_UNIT_FACING)
if(wujunyou33_Z6Z)then
call SetUnitUseFood(wujunyou33_z76,false)
set wujunyou33_z76=null
endif
endfunction
function wujunyou33_Z47 takes unit wujunyou33_Z57,player wujunyou33_Zz7,integer wujunyou33_Z67,boolean wujunyou33_Z27 returns nothing
local location wujunyou33_z95
local integer wujunyou33_z66
local integer wujunyou33_Z75
set wujunyou33_z95=GetUnitLoc(wujunyou33_Z57)
set wujunyou33_z66=GetUnitTypeId(wujunyou33_Z57)
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>wujunyou33_Z67
call wujunyou33_z96(wujunyou33_z66,wujunyou33_Zz7,wujunyou33_z95,true,wujunyou33_Z27)
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call RemoveLocation(wujunyou33_z95)
set wujunyou33_Z42[GetPlayerId(wujunyou33_Zz7)]=true
set wujunyou33_z95=null
endfunction
function wujunyou33_Z77 takes unit wujunyou33_Z57,player wujunyou33_Zz7,integer wujunyou33_Z67 returns nothing
call wujunyou33_Z47(wujunyou33_Z57,wujunyou33_Zz7,wujunyou33_Z67,false)
endfunction
function wujunyou33_Z87 takes unit wujunyou33_z65,integer wujunyou33_z15,boolean wujunyou33_Z97 returns nothing
local integer wujunyou33_Z75
set wujunyou33_Z75=GetResourceAmount(wujunyou33_z65)
if(wujunyou33_Z97)then
set wujunyou33_Z75=wujunyou33_Z75+wujunyou33_z15
else
set wujunyou33_Z75=wujunyou33_Z75-wujunyou33_z15
endif
if(wujunyou33_Z75<0)then
if(wujunyou33_Z97)then
set wujunyou33_Z75=GetResourceAmount(wujunyou33_z65)
else
set wujunyou33_Z75=0
endif
endif
call SetResourceAmount(wujunyou33_z65,wujunyou33_Z75)
endfunction
function wujunyou33_zZ7 takes integer wujunyou33_z15,player wujunyou33_z05,boolean wujunyou33_zz7 returns nothing
if(wujunyou33_zz7)then
call SetPlayerTechMaxAllowed(wujunyou33_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(wujunyou33_z05,1212502607,3)
endif
endfunction
function wujunyou33_z07 takes integer wujunyou33_z15,boolean wujunyou33_z06 returns nothing
if(wujunyou33_z06)then
call EnableTrigger(wujunyou33_z00[wujunyou33_z15])
call EnableTrigger(wujunyou33_z10[wujunyou33_z15])
call EnableTrigger(wujunyou33_z20[wujunyou33_z15])
call EnableTrigger(wujunyou33_z30[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z70[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z80[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z90[wujunyou33_z15])
call EnableTrigger(wujunyou33_zZ0[wujunyou33_z15])
call EnableTrigger(wujunyou33_zz0[wujunyou33_z15])
else
call DisableTrigger(wujunyou33_z00[wujunyou33_z15])
call DisableTrigger(wujunyou33_z10[wujunyou33_z15])
call DisableTrigger(wujunyou33_z20[wujunyou33_z15])
call DisableTrigger(wujunyou33_z30[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z70[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z80[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z90[wujunyou33_z15])
call DisableTrigger(wujunyou33_zZ0[wujunyou33_z15])
call DisableTrigger(wujunyou33_zz0[wujunyou33_z15])
endif
endfunction
function wujunyou33_z17 takes integer wujunyou33_z15,boolean wujunyou33_z27 returns nothing
if(wujunyou33_z27)then
call EnableTrigger(wujunyou33_Z40[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z60[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z6z[wujunyou33_z15])
else
call DisableTrigger(wujunyou33_Z40[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z60[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z6z[wujunyou33_z15])
endif
endfunction
function wujunyou33_z37 takes nothing returns nothing
local integer wujunyou33_z15
set wujunyou33_z15=0
loop
exitwhen wujunyou33_z15>11
call wujunyou33_z07(wujunyou33_z15,false)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endfunction
function wujunyou33_z47 takes integer wujunyou33_z15 returns nothing
set wujunyou33_z6[wujunyou33_z15]=false
call GroupClear(wujunyou33_Z8Z[wujunyou33_z15])
if(wujunyou33_Z7Z)then
call DestroyFogModifier(wujunyou33_Z6[wujunyou33_z15])
endif
call DisableTrigger(wujunyou33_Z30[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z50[wujunyou33_z15])
call DisableTrigger(wujunyou33_zz1[wujunyou33_z15])
call DisableTrigger(wujunyou33_z40[wujunyou33_z15])
call DisableTrigger(wujunyou33_z50[wujunyou33_z15])
call DisableTrigger(wujunyou33_z60[wujunyou33_z15])
call DisableTrigger(wujunyou33_z70[wujunyou33_z15])
call DisableTrigger(wujunyou33_z80[wujunyou33_z15])
call DisableTrigger(wujunyou33_z90[wujunyou33_z15])
call DisableTrigger(wujunyou33_ZZ3[wujunyou33_z15])
call DisableTrigger(wujunyou33_ZZ1[wujunyou33_z15])
call DisableTrigger(wujunyou33_Zz1[wujunyou33_z15])
call DisableTrigger(wujunyou33_Zz2[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z01[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z81[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z21[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z51[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z41[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z61[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z12[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z02[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z71[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z31[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z22[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z11[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z23[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z13[wujunyou33_z15])
call DisableTrigger(wujunyou33_zZ3[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z40[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z60[wujunyou33_z15])
call DisableTrigger(wujunyou33_Z6z[wujunyou33_z15])
call wujunyou33_z07(wujunyou33_z15,false)
endfunction
function wujunyou33_z57 takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
set wujunyou33_z6[wujunyou33_z15]=true
if(wujunyou33_Z3z[wujunyou33_z15])then
else
call wujunyou33_zZ5(wujunyou33_z15,wujunyou33_z05)
endif
call EnableTrigger(wujunyou33_Z30[wujunyou33_z15])
call EnableTrigger(wujunyou33_Z50[wujunyou33_z15])
call EnableTrigger(wujunyou33_zz1[wujunyou33_z15])
call wujunyou33_z07(wujunyou33_z15,true)
endfunction
function wujunyou33_z67 takes integer wujunyou33_z15,boolean wujunyou33_z77 returns nothing
if(wujunyou33_z77)then
if((wujunyou33_zZZ[wujunyou33_z15])and(wujunyou33_zzZ[wujunyou33_z15])and(wujunyou33_z31[wujunyou33_z15]))then
call EnableTrigger(wujunyou33_z01[wujunyou33_z15])
call EnableTrigger(wujunyou33_z11[wujunyou33_z15])
call EnableTrigger(wujunyou33_z21[wujunyou33_z15])
endif
else
call DisableTrigger(wujunyou33_z01[wujunyou33_z15])
call DisableTrigger(wujunyou33_z11[wujunyou33_z15])
call DisableTrigger(wujunyou33_z21[wujunyou33_z15])
endif
endfunction
function wujunyou33_z87 takes integer wujunyou33_Z06 returns nothing
if(wujunyou33_Z06==0)then
set wujunyou33_zz2=0
return
endif
if(wujunyou33_Z06==1)then
set wujunyou33_zz2=10
return
endif
if(wujunyou33_Z06==2)then
set wujunyou33_zz2=15
return
endif
if(wujunyou33_Z06==3)then
set wujunyou33_zz2=20
return
endif
if(wujunyou33_Z06==4)then
set wujunyou33_zz2=40
return
endif
if(wujunyou33_Z06==5)then
set wujunyou33_zz2=50
return
endif
if(wujunyou33_Z06==6)then
set wujunyou33_zz2=70
return
endif
if(wujunyou33_Z06==7)then
set wujunyou33_zz2=80
return
endif
if(wujunyou33_Z06==8)then
set wujunyou33_zz2=90
return
endif
if(wujunyou33_Z06==9)then
set wujunyou33_zz2=100
return
endif
endfunction
function wujunyou33_z97 takes unit wujunyou33_z65,integer wujunyou33_ZZ8,integer wujunyou33_Zz8 returns nothing
call wujunyou33_z87(wujunyou33_Zz8)
call wujunyou33_Zz6(wujunyou33_ZZ8)
call SetUnitVertexColorBJ(wujunyou33_z65,wujunyou33_zZ2,wujunyou33_Z92,wujunyou33_Z82,wujunyou33_zz2)
endfunction
function wujunyou33_Z08 takes integer wujunyou33_ZZ8,integer wujunyou33_Zz8 returns nothing
call wujunyou33_z87(wujunyou33_Zz8)
call wujunyou33_Zz6(wujunyou33_ZZ8)
call SetWaterBaseColorBJ(wujunyou33_zZ2,wujunyou33_Z92,wujunyou33_Z82,wujunyou33_zz2)
endfunction
function wujunyou33_Z18 takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call wujunyou33_z97(wujunyou33_z65,GetRandomInt(3,9),0)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z28 takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call wujunyou33_z97(wujunyou33_z65,0,0)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z38 takes integer wujunyou33_z15,boolean wujunyou33_z77 returns nothing
local integer wujunyou33_Z75
local integer wujunyou33_Z48
if(wujunyou33_Z53[wujunyou33_z15]==wujunyou33_z77)then
else
set wujunyou33_Z53[wujunyou33_z15]=wujunyou33_z77
if(wujunyou33_z77)then
call EnableTrigger(wujunyou33_z83)
else
set wujunyou33_Z75=0
set wujunyou33_Z48=0
loop
exitwhen wujunyou33_Z75>11
if(wujunyou33_Z53[wujunyou33_Z75])then
set wujunyou33_Z48=wujunyou33_Z48+1
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
if(wujunyou33_Z48==0)then
call DisableTrigger(wujunyou33_z83)
endif
endif
endif
endfunction
function wujunyou33_Z58 takes integer wujunyou33_Z68 returns nothing
if(wujunyou33_Z68==0)then
call SetSkyModel(null)
return
endif
if(wujunyou33_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(wujunyou33_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(wujunyou33_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(wujunyou33_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(wujunyou33_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(wujunyou33_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(wujunyou33_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(wujunyou33_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(wujunyou33_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(wujunyou33_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(wujunyou33_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(wujunyou33_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(wujunyou33_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function wujunyou33_Z78 takes integer wujunyou33_Z88 returns integer
if(wujunyou33_Z88==0)then
return 1380018290
endif
if(wujunyou33_Z88==1)then
return 1380019314
endif
if(wujunyou33_Z88==2)then
return 1296393331
endif
if(wujunyou33_Z88==3)then
return 1178886760
endif
if(wujunyou33_Z88==4)then
return 1178886764
endif
if(wujunyou33_Z88==5)then
return 1178888040
endif
if(wujunyou33_Z88==6)then
return 1178888044
endif
if(wujunyou33_Z88==7)then
return 1178890856
endif
if(wujunyou33_Z88==8)then
return 1178890860
endif
if(wujunyou33_Z88==9)then
return 1178892136
endif
if(wujunyou33_Z88==10)then
return 1178892140
endif
if(wujunyou33_Z88==11)then
return 1380739186
endif
if(wujunyou33_Z88==12)then
return 1380740210
endif
if(wujunyou33_Z88==13)then
return 1397645939
endif
if(wujunyou33_Z88==14)then
return 1397647475
endif
if(wujunyou33_Z88==15)then
return 1397648499
endif
if(wujunyou33_Z88==16)then
return 1464820599
endif
if(wujunyou33_Z88==17)then
return 1464822903
endif
if(wujunyou33_Z88==18)then
return 1280467297
endif
if(wujunyou33_Z88==19)then
return 1280470369
endif
if(wujunyou33_Z88==20)then
return 1464755063
endif
return 0
endfunction
function wujunyou33_Z98 takes integer wujunyou33_Z88,boolean wujunyou33_z77 returns nothing
set wujunyou33_Z88=wujunyou33_Z88-1
if(wujunyou33_z77)then
if(wujunyou33_z12[wujunyou33_Z88]==false)then
if(wujunyou33_Z78(wujunyou33_Z88)==0)then
else
set wujunyou33_z02[wujunyou33_Z88]=AddWeatherEffect(wujunyou33_z8,wujunyou33_Z78(wujunyou33_Z88))
call EnableWeatherEffect(wujunyou33_z02[wujunyou33_Z88],true)
set wujunyou33_z12[wujunyou33_Z88]=true
endif
endif
else
if(wujunyou33_z02[wujunyou33_Z88]==null)then
else
call EnableWeatherEffect(wujunyou33_z02[wujunyou33_Z88],false)
call RemoveWeatherEffect(wujunyou33_z02[wujunyou33_Z88])
set wujunyou33_z12[wujunyou33_Z88]=false
set wujunyou33_z02[wujunyou33_Z88]=null
endif
endif
endfunction
function wujunyou33_zZ8 takes nothing returns nothing
local integer wujunyou33_z15=1
loop
exitwhen wujunyou33_z15>21
call wujunyou33_Z98(wujunyou33_z15,false)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endfunction
function wujunyou33_zz8 takes integer wujunyou33_z08 returns integer
if(wujunyou33_z08==0)then
return 1280601204
endif
if(wujunyou33_z08==1)then
return 1179939959
endif
if(wujunyou33_z08==2)then
return 1465152631
endif
if(wujunyou33_z08==3)then
return 1096053874
endif
if(wujunyou33_z08==4)then
return 1096053859
endif
if(wujunyou33_z08==5)then
return 1112831095
endif
if(wujunyou33_z08==6)then
return 1263826039
endif
if(wujunyou33_z08==7)then
return 1498707828
endif
if(wujunyou33_z08==8)then
return 1498702708
endif
if(wujunyou33_z08==9)then
return 1498703476
endif
if(wujunyou33_z08==10)then
return 1498706804
endif
if(wujunyou33_z08==11)then
return 1247044468
endif
if(wujunyou33_z08==12)then
return 1247048823
endif
if(wujunyou33_z08==13)then
return 1146385256
endif
if(wujunyou33_z08==14)then
return 1129608306
endif
if(wujunyou33_z08==15)then
return 1129608291
endif
if(wujunyou33_z08==16)then
return 1230271607
endif
if(wujunyou33_z08==17)then
return 1230271607
endif
if(wujunyou33_z08==18)then
return 1314157667
endif
if(wujunyou33_z08==19)then
return 1330934903
endif
if(wujunyou33_z08==20)then
return 1515484279
endif
if(wujunyou33_z08==21)then
return 1196716904
endif
if(wujunyou33_z08==22)then
return 1448373364
endif
if(wujunyou33_z08==23)then
return 1448373364
endif
return 0
endfunction
function wujunyou33_z18 takes nothing returns integer
return wujunyou33_zz8(GetRandomInt(0,23))
endfunction
function wujunyou33_z28 takes unit wujunyou33_z65,integer wujunyou33_z38,integer wujunyou33_z08,integer wujunyou33_z48 returns nothing
local real wujunyou33_z58
local real wujunyou33_z68
local real wujunyou33_z15=0
local boolean wujunyou33_z78=true
set wujunyou33_z58=GetUnitX(wujunyou33_z65)
set wujunyou33_z68=GetUnitY(wujunyou33_z65)
if(wujunyou33_z38==1)then
loop
exitwhen wujunyou33_z15==wujunyou33_z48
if(wujunyou33_z78)then
call CreateDestructable(wujunyou33_z08,wujunyou33_z58,wujunyou33_z68+wujunyou33_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(wujunyou33_z08,wujunyou33_z58,wujunyou33_z68-wujunyou33_z15*40,GetRandomReal(0,360),1,0)
endif
set wujunyou33_z78=not(wujunyou33_z78)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endif
if(wujunyou33_z38==2)then
loop
exitwhen wujunyou33_z15==wujunyou33_z48
if(wujunyou33_z78)then
call CreateDestructable(wujunyou33_z08,wujunyou33_z58+wujunyou33_z15*40,wujunyou33_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(wujunyou33_z08,wujunyou33_z58-wujunyou33_z15*40,wujunyou33_z68,GetRandomReal(0,360),1,0)
endif
set wujunyou33_z78=not(wujunyou33_z78)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endif
if(wujunyou33_z38==3)then
loop
exitwhen wujunyou33_z15==wujunyou33_z48
if(wujunyou33_z78)then
call CreateDestructable(wujunyou33_z08,wujunyou33_z58+wujunyou33_z15*40,wujunyou33_z68+wujunyou33_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(wujunyou33_z08,wujunyou33_z58-wujunyou33_z15*40,wujunyou33_z68-wujunyou33_z15*40,GetRandomReal(0,360),1,0)
endif
set wujunyou33_z78=not(wujunyou33_z78)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endif
if(wujunyou33_z38==4)then
loop
exitwhen wujunyou33_z15==wujunyou33_z48
if(wujunyou33_z78)then
call CreateDestructable(wujunyou33_z08,wujunyou33_z58+wujunyou33_z15*40,wujunyou33_z68-wujunyou33_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(wujunyou33_z08,wujunyou33_z58-wujunyou33_z15*40,wujunyou33_z68+wujunyou33_z15*40,GetRandomReal(0,360),1,0)
endif
set wujunyou33_z78=not(wujunyou33_z78)
set wujunyou33_z15=wujunyou33_z15+1
endloop
endif
endfunction
function wujunyou33_z88 takes integer wujunyou33_z15 returns nothing
set wujunyou33_Z7[wujunyou33_z15]=true
call StartTimerBJ(wujunyou33_z0Z[wujunyou33_z15],false,2.)
endfunction
function wujunyou33_z98 takes integer wujunyou33_z15,boolean wujunyou33_ZZZZ returns nothing
local integer wujunyou33_Z75
local integer wujunyou33_z76
local item wujunyou33_z86
local location wujunyou33_z95
local unit wujunyou33_z65
set wujunyou33_z65=wujunyou33_z7[wujunyou33_z15]
set wujunyou33_z76=1
loop
exitwhen wujunyou33_z76>6
if(wujunyou33_ZZZZ)then
set wujunyou33_z95=GetUnitLoc(wujunyou33_z51[wujunyou33_z15])
else
set wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
endif
set wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z65,wujunyou33_z76)
if(GetItemCharges(wujunyou33_z86)>0)then
set wujunyou33_Z75=GetItemCharges(wujunyou33_z86)
set wujunyou33_z86=CreateItemLoc(GetItemTypeId(wujunyou33_z86),wujunyou33_z95)
call SetItemCharges(wujunyou33_z86,wujunyou33_Z75)
else
call CreateItemLoc(GetItemTypeId(wujunyou33_z86),wujunyou33_z95)
endif
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z76=wujunyou33_z76+1
endloop
set wujunyou33_z65=null
set wujunyou33_z95=null
set wujunyou33_z86=null
endfunction
function wujunyou33_ZZzZ takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local integer wujunyou33_Z75
local force wujunyou33_ZZ0Z
local player wujunyou33_Z65
if(wujunyou33_z1Z[wujunyou33_z15])then
call DestroyFogModifier(wujunyou33_Z6[wujunyou33_z15])
set wujunyou33_z1Z[wujunyou33_z15]=false
else
set wujunyou33_ZZ0Z=CreateForce()
set wujunyou33_Z75=0
loop
exitwhen wujunyou33_Z75>11
set wujunyou33_Z65=Player(wujunyou33_Z75)
if(GetPlayerAlliance(wujunyou33_z05,wujunyou33_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(wujunyou33_ZZ0Z,wujunyou33_Z65)
call SetPlayerAlliance(wujunyou33_z05,wujunyou33_Z65,ALLIANCE_SHARED_VISION,false)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z6[wujunyou33_z15]=CreateFogModifierRect(wujunyou33_z05,FOG_OF_WAR_VISIBLE,wujunyou33_z8,false,false)
call FogModifierStart(wujunyou33_Z6[wujunyou33_z15])
set wujunyou33_z1Z[wujunyou33_z15]=true
set wujunyou33_Z75=0
loop
exitwhen wujunyou33_Z75>11
set wujunyou33_Z65=Player(wujunyou33_Z75)
if(IsPlayerInForce(wujunyou33_Z65,wujunyou33_ZZ0Z))then
call SetPlayerAlliance(wujunyou33_z05,wujunyou33_Z65,ALLIANCE_SHARED_VISION,true)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call DestroyForce(wujunyou33_ZZ0Z)
set wujunyou33_ZZ0Z=null
set wujunyou33_Z65=null
endif
endfunction
function wujunyou33_ZZ1Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local integer wujunyou33_Z75
local unit wujunyou33_z65
local item wujunyou33_z86
local item array wujunyou33_ZZ2Z
set wujunyou33_z65=FirstOfGroup(wujunyou33_Z8Z[wujunyou33_z15])
if((wujunyou33_z05==GetOwningPlayer(wujunyou33_z65))and(UnitInventorySizeBJ(wujunyou33_z65)>0))then
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>6
set wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z65,wujunyou33_Z75)
set wujunyou33_ZZ2Z[(wujunyou33_Z75-1)]=wujunyou33_z86
call UnitRemoveItemSwapped(wujunyou33_z86,wujunyou33_z65)
call SetItemVisible(wujunyou33_z86,false)
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>6
set wujunyou33_z86=wujunyou33_Z2z[(wujunyou33_z15*18)+(wujunyou33_Z4z[wujunyou33_z15]*6)+(wujunyou33_Z75-1)]
call UnitAddItem(wujunyou33_z65,wujunyou33_z86)
set wujunyou33_Z2z[(wujunyou33_z15*18)+(wujunyou33_Z4z[wujunyou33_z15]*6)+(wujunyou33_Z75-1)]=wujunyou33_ZZ2Z[(wujunyou33_Z75-1)]
set wujunyou33_ZZ2Z[(wujunyou33_Z75-1)]=null
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
if(wujunyou33_Z4z[wujunyou33_z15]==0)then
set wujunyou33_Z4z[wujunyou33_z15]=wujunyou33_z61-1
else
set wujunyou33_Z4z[wujunyou33_z15]=(wujunyou33_Z4z[wujunyou33_z15]-1)
endif
set wujunyou33_z86=null
endif
set wujunyou33_z65=null
set wujunyou33_z05=null
endfunction
function wujunyou33_ZZ3Z takes unit wujunyou33_z65 returns nothing
local integer wujunyou33_Z75
local item wujunyou33_z86
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>6
set wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z65,wujunyou33_Z75)
call UnitRemoveItemSwapped(wujunyou33_z86,wujunyou33_z65)
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_z86=null
endfunction
function wujunyou33_ZZ4Z takes integer wujunyou33_z15 returns nothing
local integer wujunyou33_Z75
local item wujunyou33_z86
local location wujunyou33_z95
set wujunyou33_z95=GetUnitLoc(wujunyou33_z51[wujunyou33_z15])
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>6
set wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z75)
call UnitRemoveItemSwapped(wujunyou33_z86,wujunyou33_z7[wujunyou33_z15])
call SetItemPositionLoc(wujunyou33_z86,wujunyou33_z95)
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z86=null
set wujunyou33_z95=null
endfunction
function wujunyou33_ZZ5Z takes integer wujunyou33_z15 returns nothing
local integer wujunyou33_z76
local integer wujunyou33_z78
local unit wujunyou33_z65
local item wujunyou33_Z66
local item wujunyou33_ZZ6Z
set wujunyou33_z65=FirstOfGroup(wujunyou33_Z8Z[wujunyou33_z15])
set wujunyou33_z76=1
loop
exitwhen wujunyou33_z76>5
set wujunyou33_Z66=UnitItemInSlotBJ(wujunyou33_z65,wujunyou33_z76)
if(GetItemCharges(wujunyou33_Z66)>0)then
set wujunyou33_z78=wujunyou33_z76+1
loop
exitwhen wujunyou33_z78>6
set wujunyou33_ZZ6Z=UnitItemInSlotBJ(wujunyou33_z65,wujunyou33_z78)
if(GetItemTypeId(wujunyou33_Z66)==GetItemTypeId(wujunyou33_ZZ6Z))then
call SetItemCharges(wujunyou33_Z66,(GetItemCharges(wujunyou33_Z66)+GetItemCharges(wujunyou33_ZZ6Z)))
call RemoveItem(wujunyou33_ZZ6Z)
endif
set wujunyou33_z78=wujunyou33_z78+1
endloop
endif
set wujunyou33_z76=wujunyou33_z76+1
endloop
set wujunyou33_Z66=null
set wujunyou33_ZZ6Z=null
set wujunyou33_z65=null
endfunction
function wujunyou33_ZZ7Z takes integer wujunyou33_z15,integer wujunyou33_Z75 returns nothing
local unit wujunyou33_z65
local item wujunyou33_z86
set wujunyou33_z65=FirstOfGroup(wujunyou33_Z8Z[wujunyou33_z15])
set wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z65,1)
call SetItemCharges(wujunyou33_z86,(GetItemCharges(wujunyou33_z86)+wujunyou33_Z75))
set wujunyou33_z86=null
set wujunyou33_z65=null
endfunction
function wujunyou33_ZZ8Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call GroupAddUnit(wujunyou33_z8Z,wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_ZZ9Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call GroupRemoveUnit(wujunyou33_z8Z,wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_ZzZZ takes nothing returns nothing
local unit wujunyou33_z65=GetTriggerUnit()
if((IsUnitDeadBJ(wujunyou33_z65))and(IsUnitType(wujunyou33_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(wujunyou33_z8Z,wujunyou33_z65)
endif
endfunction
function wujunyou33_ZzzZ takes nothing returns nothing
call ForGroup(wujunyou33_z8Z,function wujunyou33_ZzZZ)
endfunction
function wujunyou33_Zz0Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call ReviveHeroLoc(wujunyou33_z65,wujunyou33_Z9Z[wujunyou33_Zzz],true)
call SetUnitManaPercentBJ(wujunyou33_z65,100)
set wujunyou33_z65=null
endfunction
function wujunyou33_Zz1Z takes player wujunyou33_z05 returns nothing
local group wujunyou33_z46
set wujunyou33_z46=wujunyou33_Z94(wujunyou33_z05)
set wujunyou33_Zzz=GetPlayerId(wujunyou33_z05)
call ForGroup(wujunyou33_z46,function wujunyou33_Zz0Z)
call DestroyGroup(wujunyou33_z46)
set wujunyou33_z46=null
endfunction
function wujunyou33_Zz2Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call ModifyHeroStat(wujunyou33_z81,wujunyou33_z65,wujunyou33_z91,wujunyou33_z71)
set wujunyou33_z65=null
endfunction
function wujunyou33_Zz3Z takes integer wujunyou33_z15,integer wujunyou33_Zz4Z,integer wujunyou33_Zz5Z,boolean wujunyou33_z25 returns nothing
local integer wujunyou33_Zz6Z
if(wujunyou33_z25)then
set wujunyou33_Zz6Z=0
else
set wujunyou33_Zz6Z=1
endif
if(wujunyou33_Z0)then
set wujunyou33_z91=wujunyou33_Zz6Z
set wujunyou33_z81=wujunyou33_Zz4Z
set wujunyou33_z71=wujunyou33_Zz5Z
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Zz2Z)
else
call ModifyHeroStat(wujunyou33_Zz4Z,wujunyou33_z7[wujunyou33_z15],wujunyou33_Zz6Z,wujunyou33_Zz5Z)
endif
endfunction
function wujunyou33_Zz7Z takes unit wujunyou33_z65,integer wujunyou33_Zz5Z,boolean wujunyou33_z25 returns nothing
local integer wujunyou33_z15
set wujunyou33_z15=GetHeroLevel(wujunyou33_z65)
if(wujunyou33_z25)then
set wujunyou33_z15=wujunyou33_z15+wujunyou33_Zz5Z
else
set wujunyou33_z15=wujunyou33_z15-wujunyou33_Zz5Z
endif
call SetHeroLevelBJ(wujunyou33_z65,wujunyou33_z15,false)
endfunction
function wujunyou33_Zz8Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_Zz7Z(wujunyou33_z65,wujunyou33_ZZ2,wujunyou33_Z1z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Zz9Z takes integer wujunyou33_z15,integer wujunyou33_Zz5Z,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_ZZ2=wujunyou33_Zz5Z
set wujunyou33_Z1z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Zz8Z)
else
call wujunyou33_Zz7Z(wujunyou33_z7[wujunyou33_z15],wujunyou33_Zz5Z,wujunyou33_z25)
endif
endfunction
function wujunyou33_Z0ZZ takes string wujunyou33_Z0zZ returns integer
local string wujunyou33_Z00Z="0123456789"
local string wujunyou33_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string wujunyou33_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer Id=0
local integer wujunyou33_Z03Z=1
local integer wujunyou33_Z04Z=1
loop
exitwhen wujunyou33_Z03Z>StringLength(wujunyou33_Z0zZ)
loop
exitwhen wujunyou33_Z04Z>10
if SubString(wujunyou33_Z0zZ,wujunyou33_Z03Z-1,wujunyou33_Z03Z)==SubString(wujunyou33_Z00Z,wujunyou33_Z04Z-1,wujunyou33_Z04Z)then
set Id=Id+R2I((48+wujunyou33_Z04Z-1)*Pow(256.,I2R(StringLength(wujunyou33_Z0zZ)-wujunyou33_Z03Z)))
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
else
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
endif
endloop
set wujunyou33_Z04Z=1
loop
exitwhen wujunyou33_Z04Z>26
if SubString(wujunyou33_Z0zZ,wujunyou33_Z03Z-1,wujunyou33_Z03Z)==SubString(wujunyou33_Z01Z,wujunyou33_Z04Z-1,wujunyou33_Z04Z)then
set Id=Id+R2I(I2R(65+wujunyou33_Z04Z-1)*Pow(256.,I2R(StringLength(wujunyou33_Z0zZ)-wujunyou33_Z03Z)))
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
else
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
endif
endloop
set wujunyou33_Z04Z=1
loop
exitwhen wujunyou33_Z04Z>26
if SubString(wujunyou33_Z0zZ,wujunyou33_Z03Z-1,wujunyou33_Z03Z)==SubString(wujunyou33_Z02Z,wujunyou33_Z04Z-1,wujunyou33_Z04Z)then
set Id=Id+R2I((97+wujunyou33_Z04Z-1)*Pow(256.,I2R(StringLength(wujunyou33_Z0zZ)-wujunyou33_Z03Z)))
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
else
set wujunyou33_Z04Z=wujunyou33_Z04Z+1
endif
endloop
set wujunyou33_Z04Z=1
set wujunyou33_Z03Z=wujunyou33_Z03Z+1
endloop
return Id
endfunction
function wujunyou33_Z05Z takes integer wujunyou33_Z06Z returns string
local string wujunyou33_Z00Z="0123456789"
local string wujunyou33_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string wujunyou33_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string wujunyou33_Z07Z=""
local integer wujunyou33_Z03Z=0
local integer wujunyou33_Z08Z=0
loop
exitwhen wujunyou33_Z06Z==0
set wujunyou33_Z03Z=ModuloInteger(wujunyou33_Z06Z,256)
if wujunyou33_Z03Z>=48 and wujunyou33_Z03Z<=57 then
set wujunyou33_Z08Z=wujunyou33_Z03Z-48
set wujunyou33_Z07Z=SubString(wujunyou33_Z00Z,wujunyou33_Z08Z,wujunyou33_Z08Z+1)+wujunyou33_Z07Z
endif
if wujunyou33_Z03Z>=65 and wujunyou33_Z03Z<=90 then
set wujunyou33_Z08Z=wujunyou33_Z03Z-65
set wujunyou33_Z07Z=SubString(wujunyou33_Z01Z,wujunyou33_Z08Z,wujunyou33_Z08Z+1)+wujunyou33_Z07Z
endif
if wujunyou33_Z03Z>=97 and wujunyou33_Z03Z<=122 then
set wujunyou33_Z08Z=wujunyou33_Z03Z-97
set wujunyou33_Z07Z=SubString(wujunyou33_Z02Z,wujunyou33_Z08Z,wujunyou33_Z08Z+1)+wujunyou33_Z07Z
endif
set wujunyou33_Z06Z=wujunyou33_Z06Z/256
endloop
return wujunyou33_Z07Z
endfunction
function wujunyou33_Z09Z takes unit wujunyou33_z65 returns string
local integer wujunyou33_z15
set wujunyou33_z15=GetUnitTypeId(wujunyou33_z65)
if(wujunyou33_z15==0)then
return""
else
return wujunyou33_Z05Z(wujunyou33_z15)
endif
endfunction
function wujunyou33_Z1ZZ takes unit wujunyou33_z65 returns string
local item wujunyou33_z86=UnitItemInSlotBJ(wujunyou33_z65,1)
local integer wujunyou33_z15=GetItemTypeId(wujunyou33_z86)
if(wujunyou33_z15==0)then
return""
else
set wujunyou33_z86=null
return wujunyou33_Z05Z(wujunyou33_z15)
endif
endfunction
function wujunyou33_Z1zZ takes integer wujunyou33_Z10Z returns integer
local string wujunyou33_Z11Z=GetEventPlayerChatString()
if(StringLength(wujunyou33_Z11Z)==wujunyou33_Z10Z+3)then
return(wujunyou33_Z0ZZ(SubStringBJ(wujunyou33_Z11Z,wujunyou33_Z10Z,wujunyou33_Z10Z+3)))
else
return 0
endif
endfunction
function wujunyou33_Z12Z takes unit wujunyou33_z65,integer wujunyou33_z66,boolean wujunyou33_z25 returns nothing
local location wujunyou33_z95
local integer wujunyou33_z15
set wujunyou33_z15=wujunyou33_Z1zZ(wujunyou33_z66)
if(wujunyou33_z15==0)then
else
if(wujunyou33_z25)then
set wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
call CreateItemLoc(wujunyou33_z15,wujunyou33_z95)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
else
call UnitAddItemById(wujunyou33_z65,wujunyou33_z15)
endif
endif
endfunction
function wujunyou33_Z13Z takes unit wujunyou33_z65,real wujunyou33_Z14Z,boolean wujunyou33_z25 returns nothing
local location wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
local player wujunyou33_z05=GetOwningPlayer(wujunyou33_z65)
call SetBlightRadiusLocBJ(wujunyou33_z25,wujunyou33_z05,wujunyou33_z95,wujunyou33_Z14Z)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
set wujunyou33_z05=null
endfunction
function wujunyou33_Z15Z takes unit wujunyou33_z65,real wujunyou33_Z14Z returns nothing
call SetUnitFlyHeight(wujunyou33_z65,wujunyou33_Z14Z,.0)
endfunction
function wujunyou33_Z16Z takes nothing returns integer
local integer wujunyou33_Z17Z=0
local integer wujunyou33_Z18Z=0
local integer array wujunyou33_Z19Z
local integer wujunyou33_z15=0
local player wujunyou33_z05=GetLocalPlayer()
loop
exitwhen wujunyou33_z15>11
set wujunyou33_Z19Z[wujunyou33_z15]=0
set wujunyou33_z15=wujunyou33_z15+1
endloop
loop
exitwhen wujunyou33_Z17Z>14
call StoreInteger(wujunyou33_z03,"Hke_Player","Hke_number",GetPlayerId(wujunyou33_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(wujunyou33_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set wujunyou33_Z18Z=GetStoredInteger(wujunyou33_z03,"Hke_Player","Hke_number")-1
set wujunyou33_Z19Z[wujunyou33_Z18Z]=wujunyou33_Z19Z[wujunyou33_Z18Z]+1
call FlushStoredMission(wujunyou33_z03,"Hke_Player")
set wujunyou33_Z17Z=wujunyou33_Z17Z+1
endloop
set wujunyou33_Z18Z=0
set wujunyou33_Z17Z=0
set wujunyou33_z05=null
loop
exitwhen wujunyou33_Z17Z>11
if wujunyou33_Z19Z[wujunyou33_Z18Z]<wujunyou33_Z19Z[wujunyou33_Z17Z]then
set wujunyou33_Z18Z=wujunyou33_Z17Z
endif
set wujunyou33_Z17Z=wujunyou33_Z17Z+1
endloop
return wujunyou33_Z18Z+1
endfunction
function wujunyou33_Z2ZZ takes unit wujunyou33_z65,integer wujunyou33_Z2zZ,boolean wujunyou33_z25 returns nothing
if(wujunyou33_z25)then
call UnitAddAbility(wujunyou33_z65,wujunyou33_Z2zZ)
call SetUnitAbilityLevel(wujunyou33_z65,wujunyou33_Z2zZ,100)
call UnitMakeAbilityPermanent(wujunyou33_z65,true,wujunyou33_Z2zZ)
else
call UnitMakeAbilityPermanent(wujunyou33_z65,false,wujunyou33_Z2zZ)
call UnitRemoveAbility(wujunyou33_z65,wujunyou33_Z2zZ)
endif
endfunction
function wujunyou33_Z20Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_Z2ZZ(wujunyou33_z65,wujunyou33_zzz,wujunyou33_z0z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z21Z takes integer wujunyou33_z15,integer wujunyou33_Z2zZ,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_zzz=wujunyou33_Z2zZ
set wujunyou33_z0z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z20Z)
else
call wujunyou33_Z2ZZ(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z2zZ,wujunyou33_z25)
endif
endfunction
function wujunyou33_Z22Z takes string wujunyou33_Z11Z returns integer
if(wujunyou33_Z11Z=="mm")then
return 1094937907
endif
if(wujunyou33_Z11Z=="xj")then
return 1095659625
endif
if(wujunyou33_Z11Z=="zj")then
return 1095262824
endif
if(wujunyou33_Z11Z=="zm")then
return 1095721842
endif
if(wujunyou33_Z11Z=="ft")then
return 1096119411
endif
if(wujunyou33_Z11Z=="xx")then
return 1095333473
endif
if(wujunyou33_Z11Z=="sb")then
return 1095066998
endif
if(wujunyou33_Z11Z=="yx")then
return 1097886070
endif
if(wujunyou33_Z11Z=="rh")then
return 1095657827
endif
if(wujunyou33_Z11Z=="fl")then
return 1095656289
endif
if(wujunyou33_Z11Z=="bs")then
return 1094935923
endif
if(wujunyou33_Z11Z=="jg")then
return 1095332984
endif
if(wujunyou33_Z11Z=="jf")then
return 1095328816
endif
if(wujunyou33_Z11Z=="js")then
return 1095332728
endif
if(wujunyou33_Z11Z=="jm")then
return 1095332722
endif
if(wujunyou33_Z11Z=="jj")then
return 1095917932
endif
if(wujunyou33_Z11Z=="fy")then
return 1098150517
endif
if(wujunyou33_Z11Z=="ghh")then
return 1095262562
endif
if(wujunyou33_Z11Z=="ghj")then
return 1095721317
endif
if(wujunyou33_Z11Z=="gqj")then
return 1095065970
endif
if(wujunyou33_Z11Z=="gxx")then
return 1096114550
endif
if(wujunyou33_Z11Z=="gzz")then
return 1095262564
endif
if(wujunyou33_Z11Z=="gxe")then
return 1096114549
endif
if(wujunyou33_Z11Z=="gjj")then
return 1095065960
endif
if(wujunyou33_Z11Z=="gml")then
return 1094934883
endif
if(wujunyou33_Z11Z=="gyl")then
return 1097818482
endif
if(wujunyou33_Z11Z=="gjs")then
return 1096905580
endif
if(wujunyou33_Z11Z=="qhy")then
return 1095329378
endif
if(wujunyou33_Z11Z=="qdy")then
return 1095331938
endif
if(wujunyou33_Z11Z=="qlh")then
return 1095332719
endif
if(wujunyou33_Z11Z=="qyz")then
return 1095328878
endif
if(wujunyou33_Z11Z=="qbd")then
return 1095331682
endif
if(wujunyou33_Z11Z=="qfs")then
return 1095328610
endif
if(wujunyou33_Z11Z=="qsd")then
return 1095330924
endif
if(wujunyou33_Z11Z=="qjs")then
return 1095332706
endif
if(wujunyou33_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function wujunyou33_Z23Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call SetUnitInvulnerable(wujunyou33_z65,wujunyou33_z0z)
call wujunyou33_Z2ZZ(wujunyou33_z65,1098282348,wujunyou33_z0z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z24Z takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_z0z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z23Z)
else
call SetUnitInvulnerable(wujunyou33_z7[wujunyou33_z15],wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z7[wujunyou33_z15],1098282348,wujunyou33_z25)
endif
endfunction
function wujunyou33_Z25Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call SetUnitPathing(wujunyou33_z65,not(wujunyou33_z0z))
set wujunyou33_z65=null
endfunction
function YJYJ takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFFFF0000"+GetPlayerName(GetTriggerPlayer())+":|c0007B8B8已开启HKE!|c00FF0000(此时你就是CheatMaster(可以理解为作弊管理员)|cff4c2a04且有一个玩家成为|c0000FF40|rCheatMaster|c00FF0080别的玩家就不能再次开启了，|c00FF8000本脚本从此刻开启到本图游戏结束之前|c00FFFF00无法中途|c0000FFFF关闭！)")
call wujunyou33_z37()
set wujunyou33_z4=true
set wujunyou33_z5=wujunyou33_z05
call wujunyou33_z57(GetPlayerId(wujunyou33_z05),wujunyou33_z05)
endfunction
function wujunyou33_Z26Z takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_z0z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z25Z)
else
call SetUnitPathing(wujunyou33_z7[wujunyou33_z15],not(wujunyou33_z25))
endif
endfunction
function wujunyou33_Z27Z takes unit wujunyou33_z65,boolean wujunyou33_z25 returns nothing
if(wujunyou33_z25)then
call SetUnitMoveSpeed(wujunyou33_z65,1000)
else
call SetUnitMoveSpeed(wujunyou33_z65,GetUnitDefaultMoveSpeed(wujunyou33_z65))
endif
endfunction
function wujunyou33_Z28Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_Z27Z(wujunyou33_z65,wujunyou33_z0z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z29Z takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_z0z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z28Z)
else
call wujunyou33_Z27Z(wujunyou33_z7[wujunyou33_z15],wujunyou33_z25)
endif
endfunction
function wujunyou33_Z3ZZ takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
call wujunyou33_ZzzZ()
if(wujunyou33_Z0)then
if(wujunyou33_z25)then
if(CountUnitsInGroup(wujunyou33_z8Z)==0)then
call EnableTrigger(wujunyou33_z73)
endif
call GroupAddGroup(wujunyou33_Z8Z[wujunyou33_z15],wujunyou33_z8Z)
else
call GroupRemoveGroup(wujunyou33_Z8Z[wujunyou33_z15],wujunyou33_z8Z)
if(CountUnitsInGroup(wujunyou33_z8Z)==0)then
call DisableTrigger(wujunyou33_z73)
endif
endif
else
if(wujunyou33_z25)then
if(CountUnitsInGroup(wujunyou33_z8Z)==0)then
call EnableTrigger(wujunyou33_z73)
endif
call GroupAddUnit(wujunyou33_z8Z,wujunyou33_z7[wujunyou33_z15])
else
call GroupRemoveUnit(wujunyou33_z8Z,wujunyou33_z7[wujunyou33_z15])
if(CountUnitsInGroup(wujunyou33_z8Z)==0)then
call DisableTrigger(wujunyou33_z73)
endif
endif
endif
endfunction
function wujunyou33_Z3zZ takes unit wujunyou33_z65,boolean wujunyou33_z25 returns nothing
call wujunyou33_Z2ZZ(wujunyou33_z65,1095262562,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095721317,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095065970,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1096114550,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095262564,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1096114549,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1094934883,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095065960,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1097818482,wujunyou33_z25)
call wujunyou33_Z2ZZ(wujunyou33_z65,1096905580,wujunyou33_z25)
endfunction
function wujunyou33_Z30Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_Z3zZ(wujunyou33_z65,wujunyou33_z0z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z31Z takes integer wujunyou33_z15,boolean wujunyou33_z25 returns nothing
if(wujunyou33_Z0)then
set wujunyou33_z0z=wujunyou33_z25
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z30Z)
else
call wujunyou33_Z3zZ(wujunyou33_z7[wujunyou33_z15],wujunyou33_z25)
endif
endfunction
function wujunyou33_Z32Z takes unit wujunyou33_z65 returns nothing
call wujunyou33_Z2ZZ(wujunyou33_z65,1094937907,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095659625,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095262824,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095721842,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1096119411,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095333473,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095066998,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1097886070,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095657827,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095656289,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1098282348,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1094935923,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095332984,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095328816,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095332728,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1095332722,false)
call wujunyou33_Z2ZZ(wujunyou33_z65,1098150517,false)
call SetUnitInvulnerable(wujunyou33_z65,false)
call SetUnitPathing(wujunyou33_z65,true)
call wujunyou33_Z27Z(wujunyou33_z65,false)
call GroupRemoveUnit(wujunyou33_z8Z,wujunyou33_z65)
endfunction
function wujunyou33_Z33Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_Z32Z(wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z34Z takes integer wujunyou33_z15 returns nothing
if(wujunyou33_Z0)then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z33Z)
else
call wujunyou33_Z32Z(wujunyou33_z7[wujunyou33_z15])
endif
endfunction
function wujunyou33_Z35Z takes nothing returns nothing
local unit wujunyou33_z65=GetTriggerUnit()
local trigger wujunyou33_Z66=GetTriggeringTrigger()
call RemoveUnit(wujunyou33_z65)
call DisableTrigger(wujunyou33_Z66)
call DestroyTrigger(wujunyou33_Z66)
set wujunyou33_z65=null
set wujunyou33_Z66=null
endfunction
function wujunyou33_Z36Z takes integer wujunyou33_z66,unit wujunyou33_Z37Z,player wujunyou33_Z38Z returns nothing
local location wujunyou33_z95
local unit wujunyou33_z65
local integer wujunyou33_Z39Z=0
local integer wujunyou33_Z4ZZ=0
local trigger wujunyou33_Z66
if(wujunyou33_z66==0)then
set wujunyou33_Z39Z=1095726692
set wujunyou33_Z4ZZ=852503
endif
if(wujunyou33_z66==1)then
set wujunyou33_Z39Z=1095070833
set wujunyou33_Z4ZZ=852184
endif
if(wujunyou33_z66==2)then
set wujunyou33_Z39Z=1095070566
set wujunyou33_Z4ZZ=852183
endif
if((wujunyou33_Z39Z==0)and(wujunyou33_Z4ZZ==0))then
return
endif
set wujunyou33_z95=GetUnitLoc(wujunyou33_Z37Z)
set wujunyou33_z65=CreateUnitAtLoc(wujunyou33_Z38Z,1851941228,wujunyou33_z95,bj_UNIT_FACING)
call UnitAddAbility(wujunyou33_z65,1098282348)
call UnitAddAbility(wujunyou33_z65,wujunyou33_Z39Z)
call ShowUnit(wujunyou33_z65,false)
call SetUnitUseFood(wujunyou33_z65,false)
call SetUnitScale(wujunyou33_z65,.01,.01,.01)
call SetUnitState(wujunyou33_z65,UNIT_STATE_MANA,GetUnitState(wujunyou33_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(wujunyou33_z65,wujunyou33_Z4ZZ)
set wujunyou33_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(wujunyou33_Z66,wujunyou33_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(wujunyou33_Z66,wujunyou33_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(wujunyou33_Z66,function wujunyou33_Z35Z)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
set wujunyou33_Z66=null
set wujunyou33_z65=null
endfunction
function wujunyou33_Z4zZ takes unit wujunyou33_Z37Z returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local location wujunyou33_z95=GetUnitLoc(wujunyou33_Z37Z)
local trigger wujunyou33_Z66=CreateTrigger()
local unit wujunyou33_z65=CreateUnitAtLoc(wujunyou33_z05,1751543663,wujunyou33_z95,bj_UNIT_FACING)
call UnitAddAbility(wujunyou33_z65,1098282348)
call UnitAddAbility(wujunyou33_z65,1095332709)
call ShowUnit(wujunyou33_z65,false)
call SetUnitUseFood(wujunyou33_z65,false)
call SetUnitScale(wujunyou33_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(wujunyou33_z65,852592,wujunyou33_z95)
call TriggerRegisterUnitEvent(wujunyou33_Z66,wujunyou33_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(wujunyou33_Z66,wujunyou33_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(wujunyou33_Z66,function wujunyou33_Z35Z)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
set wujunyou33_Z66=null
set wujunyou33_z05=null
endfunction
function wujunyou33_Z40Z takes integer wujunyou33_z15,dialog wujunyou33_Z41Z,trigger wujunyou33_zZ6 returns nothing
set wujunyou33_Zz3[wujunyou33_z15]=wujunyou33_Z41Z
set wujunyou33_Z03[wujunyou33_z15]=wujunyou33_zZ6
endfunction
function wujunyou33_Z42Z takes integer wujunyou33_z15,string wujunyou33_Z43Z returns nothing
call DialogClear(wujunyou33_Zz3[wujunyou33_z15])
call DialogSetMessage(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z43Z+wujunyou33_Z0z+wujunyou33_Z62))
endfunction
function wujunyou33_Z44Z takes integer wujunyou33_z15,player wujunyou33_z05,boolean wujunyou33_z77 returns nothing
if(wujunyou33_z77)then
call EnableTrigger(wujunyou33_Z03[wujunyou33_z15])
call DialogDisplay(wujunyou33_z05,wujunyou33_Zz3[wujunyou33_z15],true)
call TimerStart(wujunyou33_Z73[wujunyou33_z15],wujunyou33_z1,false,null)
else
call DisableTrigger(wujunyou33_Z03[wujunyou33_z15])
call DialogDisplay(wujunyou33_z05,wujunyou33_Zz3[wujunyou33_z15],false)
endif
endfunction
function wujunyou33_Z45Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_zZ1[wujunyou33_z15],wujunyou33_ZZ1[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"主")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"资源菜单[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"自动化设置[B]",66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"选定单位特殊属性[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"个人选项设置[D]",68)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"帮助菜单[E]",69)
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"其他玩家作弊管理[F]",70)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"其他玩家管理[G]",71)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"游戏作弊选项[H]",72)
if(wujunyou33_z13)then
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z46Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local string wujunyou33_Z11Z
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Zz1[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"自动化设置")
if(IsTriggerEnabled(wujunyou33_z40[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(wujunyou33_z50[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(wujunyou33_z60[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(wujunyou33_z80[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(wujunyou33_z70[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(wujunyou33_z90[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"魔法释放后自动MP"+I2S(R2I(wujunyou33_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(wujunyou33_ZZ3[wujunyou33_z15]))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"生命低于"+I2S(R2I(wujunyou33_z92))+"%加到"+I2S(R2I(wujunyou33_z41))+"%[G]"),71)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"全部开启[O]",79)
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"全部关闭[U]",85)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z47Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z01[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"选定单位特殊属性")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"无敌[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"永久隐形[B]",66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"穿越物体[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"魔免[D]",68)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"反隐形[E]",69)
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"移动速度[F]",70)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"各种光环[G]",71)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"换页[N]",78)
if((wujunyou33_z9Z)or(wujunyou33_z5==wujunyou33_z05))then
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"秒杀模式[K]",75)
endif
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"取消全部(不含光环)[U]",85)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z48Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z91[wujunyou33_z15],wujunyou33_Z81[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"选定单位特殊属性")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"永久献祭[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"闪避[B]",514)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"重击[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"致命一击[D]",68)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"反弹(小强的壳)[E]",69)
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"分裂攻击[F]",70)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"燃灰[G]",71)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"减少魔法伤害33%[H]",72)
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"闪避100%[I]",73)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"换页[N]",78)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z49Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z91[wujunyou33_z15],wujunyou33_Z21[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"光环")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"辉煌光环[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"荆棘光环[B]",66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"耐久光环[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"强击光环[D]",68)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"邪恶光环[E]",69)
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"吸血光环[F]",70)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"专注光环[G]",71)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"命令光环(战鼓)[H]",72)
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"医疗光环[I]",73)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"减速光环[J]",74)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"关所有光环[K]",75)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z5ZZ takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local integer wujunyou33_Z75=0
local string wujunyou33_Z11Z
local string wujunyou33_Z5zZ
local player wujunyou33_Z65
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z51[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"玩家作弊管理")
loop
exitwhen wujunyou33_Z75>11
set wujunyou33_Z65=Player(wujunyou33_Z75)
if((GetPlayerController(wujunyou33_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(wujunyou33_Z65)==PLAYER_SLOT_STATE_PLAYING)and(wujunyou33_Z65!=wujunyou33_z5))then
set wujunyou33_Z5zZ=GetPlayerName(wujunyou33_Z65)
if(wujunyou33_z6[wujunyou33_Z75])then
set wujunyou33_Z11Z="禁止"
else
set wujunyou33_Z11Z="允许"
endif
set wujunyou33_ZzZ[wujunyou33_Z75]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+wujunyou33_Z5zZ+"作弊"),0)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z65=null
set wujunyou33_Z11Z=""
set wujunyou33_Z5zZ=""
endfunction
function wujunyou33_Z50Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
set wujunyou33_Z8[wujunyou33_z15]=0
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_zZ1[wujunyou33_z15],wujunyou33_Z71[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"单位")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"升100级[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("加三围"+(I2S(wujunyou33_Z3)+"[B]")),66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"复制物品[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"复制单位[D]",68)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"掉身上物品[E]",69)
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"共享该单位视野[F]",70)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"特殊属性菜单[G]",71)
if((wujunyou33_z7Z)or(wujunyou33_z5==wujunyou33_z05))then
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"控制它[H]",72)
endif
if(wujunyou33_z5==wujunyou33_z05)then
endif
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"改变单位所有者[J]",74)
endif
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z51Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local string wujunyou33_Z11Z
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z31[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"游戏作弊选项")
if(wujunyou33_Z0)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"操作所有单位[A]"),65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("设置背包数[B]"),66)
if(wujunyou33_Z5Z)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"保护CheatMaster[C]"),67)
if(wujunyou33_Z6Z)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(wujunyou33_Z7Z)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("取消作弊时"+wujunyou33_Z11Z+"地图全开[E]"),69)
if(wujunyou33_z9Z)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"他人秒杀模式[F]"),70)
if(wujunyou33_ZZz)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"禁止秒杀建筑[G]"),71)
if(wujunyou33_z7Z)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"他人占据单位[H]"),72)
if(wujunyou33_Z52)then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"禁止克隆操作农民[I]"),73)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z52Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local string wujunyou33_Z5zZ
local integer wujunyou33_Z75=0
local player wujunyou33_Z65
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z41[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"玩家管理")
loop
exitwhen wujunyou33_Z75>11
set wujunyou33_Z65=Player(wujunyou33_Z75)
if(GetPlayerSlotState(wujunyou33_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set wujunyou33_Z5zZ=GetPlayerName(wujunyou33_Z65)
set wujunyou33_ZzZ[wujunyou33_Z75]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("选择"+wujunyou33_Z5zZ+"操作"),0)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_ZzZ[12]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("选择中立生物操作"),90)
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z5zZ=""
set wujunyou33_Z65=null
endfunction
function wujunyou33_Z53Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local player wujunyou33_Z65=Player(wujunyou33_Z5z)
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z91[wujunyou33_z15],wujunyou33_Z61[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"玩家管理")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"资源管理[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"向他收税黄金"+I2S(wujunyou33_z22)+"%[C]",67)
else
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"向他收税木材"+I2S(wujunyou33_z22)+"%[D]",68)
else
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"停止向他收木材[D]",67)
endif
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回选择菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z65=null
endfunction
function wujunyou33_Z54Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local integer wujunyou33_Z75=0
local player wujunyou33_Z65
local string wujunyou33_Z11Z
local string wujunyou33_Z5zZ
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z91[wujunyou33_z15],wujunyou33_Z11[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"选定单位控制")
loop
exitwhen wujunyou33_Z75>12
set wujunyou33_Z65=Player(wujunyou33_Z75)
if(GetPlayerSlotState(wujunyou33_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set wujunyou33_Z5zZ=GetPlayerName(wujunyou33_Z65)
set wujunyou33_ZzZ[wujunyou33_Z75]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("给"+wujunyou33_Z5zZ+"控制"),0)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回单位菜单[R]",82)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z65=null
set wujunyou33_Z11Z=""
set wujunyou33_Z5zZ=""
endfunction
function wujunyou33_Z55Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local string wujunyou33_Z11Z
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Zz2[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"资源设置")
if(wujunyou33_z1Z[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="打开"
endif
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"地图[A]"),65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("复活死亡英雄[B]"),66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"人口清5[B]",66)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"总人口100[C]",67)
if(GetPlayerHandicap(wujunyou33_z05)==2)then
set wujunyou33_Z11Z="恢复生命障碍100%"
else
set wujunyou33_Z11Z="200%生命"
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(wujunyou33_z05)==2)then
set wujunyou33_Z11Z="恢复普通经验率"
else
set wujunyou33_Z11Z="2倍经验"
endif
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"[E]",69)
set wujunyou33_Z11Z=I2S(wujunyou33_Z2)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("加"+wujunyou33_Z11Z+"钱[F]"),70)
set wujunyou33_Z11Z=I2S(wujunyou33_z2)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("加"+wujunyou33_Z11Z+"木[G]"),71)
set wujunyou33_Z11Z=I2S(wujunyou33_Z2)
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("减"+wujunyou33_Z11Z+"钱[H]"),72)
set wujunyou33_Z11Z=I2S(wujunyou33_z2)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("减"+wujunyou33_Z11Z+"木[I]"),73)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z56Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local player wujunyou33_Z65=Player(wujunyou33_Z5z)
local string wujunyou33_Z11Z
local string wujunyou33_Z5zZ=GetPlayerName(wujunyou33_Z65)
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z02[wujunyou33_z15])
call DialogClear(wujunyou33_Z20[wujunyou33_z15])
call DialogSetMessage(wujunyou33_Z20[wujunyou33_z15],(wujunyou33_Z5zZ+"钱"+I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(wujunyou33_z1Z[wujunyou33_Z5z])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="打开"
endif
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],(wujunyou33_Z11Z+"地图[A]"),65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("复活死亡英雄[B]"),66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"人口清5[B]",66)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"总人口100[C]",67)
if(GetPlayerHandicap(wujunyou33_Z65)==2)then
set wujunyou33_Z11Z="恢复生命障碍100%"
else
set wujunyou33_Z11Z="200%生命"
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(wujunyou33_Z65)==2)then
set wujunyou33_Z11Z="恢复普通经验率"
else
set wujunyou33_Z11Z="2倍经验"
endif
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"[E]",69)
set wujunyou33_Z11Z=I2S(wujunyou33_Z2)
set wujunyou33_z7z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("加"+wujunyou33_Z11Z+"钱[F]"),70)
set wujunyou33_Z11Z=I2S(wujunyou33_z2)
set wujunyou33_z6z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("加"+wujunyou33_Z11Z+"木[G]"),71)
set wujunyou33_Z11Z=I2S(wujunyou33_Z2)
set wujunyou33_Zz0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("减"+wujunyou33_Z11Z+"钱[H]"),72)
set wujunyou33_Z11Z=I2S(wujunyou33_z2)
set wujunyou33_ZZ0[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("减"+wujunyou33_Z11Z+"木[I]"),73)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z11Z=""
set wujunyou33_Z5zZ=""
set wujunyou33_Z65=null
endfunction
function wujunyou33_Z57Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local player wujunyou33_Z65=Player(wujunyou33_Z5z)
local string wujunyou33_Z11Z
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z12[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"同盟管理")
if(IsPlayerAlly(wujunyou33_Z65,wujunyou33_z5))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("强制"+wujunyou33_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(wujunyou33_Z65,wujunyou33_z5))then
if(GetPlayerAlliance(wujunyou33_Z65,wujunyou33_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("强制"+wujunyou33_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(wujunyou33_Z65,wujunyou33_z5,ALLIANCE_SHARED_XP))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("强制"+wujunyou33_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(wujunyou33_z5,wujunyou33_Z65))then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],("强制"+wujunyou33_Z11Z+"对其同盟[D]"),68)
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回玩家菜单[R]",82)
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z65=null
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z58Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z91[wujunyou33_z15],wujunyou33_Z22[wujunyou33_z15])
call DialogClear(wujunyou33_Z91[wujunyou33_z15])
call DialogSetMessage(wujunyou33_Z91[wujunyou33_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(wujunyou33_z61)+"|r个")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"设置1个背包[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"设置2个背包[B]",66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"设置3个背包[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回选设置单[R]",82)
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z59Z takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z23[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"帮助")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"键盘帮助[A]",65)
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"CMD帮助[B]",66)
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"CMD单位类帮助[C]",67)
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"显示玩家信息[D]",68)
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"显示设置信息[E]",69)
endif
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
endfunction
function wujunyou33_Z6ZZ takes integer wujunyou33_z15,player wujunyou33_z05 returns nothing
local string wujunyou33_Z11Z
call wujunyou33_Z40Z(wujunyou33_z15,wujunyou33_Z20[wujunyou33_z15],wujunyou33_Z13[wujunyou33_z15])
call wujunyou33_Z42Z(wujunyou33_z15,"个人选项")
set wujunyou33_z2z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"删除我的复制单位[A]",65)
if(wujunyou33_z31[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z4z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"克隆操作[B]",66)
if(wujunyou33_Z33[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z5z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"组队克隆操作[C]",67)
if(wujunyou33_Z53[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z3z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"隐藏加攻[D]",68)
if(wujunyou33_Z63[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z9z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"隐藏加攻带溅射[E]",69)
if(wujunyou33_Z43[wujunyou33_z15])then
set wujunyou33_Z11Z="关闭"
else
set wujunyou33_Z11Z="开启"
endif
set wujunyou33_z8z[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],wujunyou33_Z11Z+"远程沉默[F]",70)
set wujunyou33_Z00[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"回主菜单[R]",82)
set wujunyou33_Z10[wujunyou33_z15]=DialogAddButton(wujunyou33_Zz3[wujunyou33_z15],"退出菜单[X]",88)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,true)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z6zZ takes player wujunyou33_z05 returns nothing
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"欢迎使用|cFFFF8C00wujunyou33的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function wujunyou33_Z60Z takes player wujunyou33_z05 returns nothing
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"欢迎使用|cFFFF8C00wujunyou33的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(wujunyou33_z05==wujunyou33_z5)then
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function wujunyou33_Z61Z takes player wujunyou33_z05 returns nothing
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"欢迎使用|cFFFF8C00wujunyou33的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(wujunyou33_z05==wujunyou33_z5)then
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function wujunyou33_Z62Z takes player wujunyou33_z05 returns nothing
local integer wujunyou33_Z75
local player wujunyou33_Z65
local string wujunyou33_Z11Z
local string wujunyou33_Z63Z
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,"|CFFFF0000wujunyou331.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set wujunyou33_Z75=1
loop
exitwhen wujunyou33_Z75>12
set wujunyou33_Z65=Player(wujunyou33_Z75-1)
if(GetPlayerSlotState(wujunyou33_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set wujunyou33_Z63Z=I2S(wujunyou33_Z75)
set wujunyou33_Z11Z=(GetPlayerName(wujunyou33_Z65)+":编号:"+wujunyou33_Z63Z)
set wujunyou33_Z63Z=I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_GOLD))
set wujunyou33_Z11Z=(wujunyou33_Z11Z+" |CFFFFFF00黄金:"+wujunyou33_Z63Z+"|R")
set wujunyou33_Z63Z=I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set wujunyou33_Z11Z=(wujunyou33_Z11Z+" |CFF008000木头:"+wujunyou33_Z63Z+"|R")
set wujunyou33_Z63Z=I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set wujunyou33_Z11Z=(wujunyou33_Z11Z+" 人口:"+wujunyou33_Z63Z)
set wujunyou33_Z63Z=I2S(GetPlayerState(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set wujunyou33_Z11Z=(wujunyou33_Z11Z+"/"+wujunyou33_Z63Z)
set wujunyou33_Z11Z=wujunyou33_Z11Z+" 作弊:"
if(wujunyou33_z6[wujunyou33_Z75-1])then
set wujunyou33_Z11Z=wujunyou33_Z11Z+"|cFF00FF33√|r"
else
set wujunyou33_Z11Z=wujunyou33_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(wujunyou33_Z65)==MAP_CONTROL_USER)then
set wujunyou33_Z11Z=wujunyou33_Z11Z+" (玩家)"
if(wujunyou33_Z75-1==wujunyou33_zz3)then
set wujunyou33_Z11Z=wujunyou33_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set wujunyou33_Z11Z=wujunyou33_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,wujunyou33_Z11Z)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z65=null
set wujunyou33_Z11Z=""
set wujunyou33_Z63Z=""
endfunction
function wujunyou33_Z64Z takes nothing returns nothing
local string wujunyou33_Z65Z
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,"|CFFFF0000wujunyou331.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set wujunyou33_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(wujunyou33_z4Z)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(wujunyou33_z5Z)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(wujunyou33_z6Z)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(wujunyou33_ZZZ))
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(wujunyou33_z41))
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(wujunyou33_z92))
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(wujunyou33_zZ)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(wujunyou33_Zz)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(wujunyou33_zz)
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(wujunyou33_Z2)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(wujunyou33_z2)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(wujunyou33_Z3)
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(wujunyou33_z61)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(wujunyou33_Z1))
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(wujunyou33_z1))
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(wujunyou33_z42))
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(wujunyou33_z22)
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(wujunyou33_z3))
set wujunyou33_Z65Z=wujunyou33_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(wujunyou33_Z4))
call DisplayTimedTextToPlayer(wujunyou33_z5,0,0,wujunyou33_Z1,wujunyou33_Z65Z)
set wujunyou33_Z65Z=""
endfunction
function wujunyou33_Z66Z takes player wujunyou33_z05,unit wujunyou33_z65 returns nothing
local string wujunyou33_Z11Z=wujunyou33_Z09Z(wujunyou33_z65)
set wujunyou33_Z11Z="该单位的ID为|cFF33FF00"+wujunyou33_Z11Z+"|r"
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,wujunyou33_Z11Z)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z67Z takes player wujunyou33_z05,unit wujunyou33_z65 returns nothing
local string wujunyou33_Z11Z=wujunyou33_Z1ZZ(wujunyou33_z65)
set wujunyou33_Z11Z="该单位的第一格物品ID为|cFF33FF00"+wujunyou33_Z11Z+"|r"
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,wujunyou33_Z11Z)
set wujunyou33_Z11Z=""
endfunction
function wujunyou33_Z68Z takes integer wujunyou33_z15 returns nothing
local unit wujunyou33_z65=wujunyou33_z7[wujunyou33_z15]
local player wujunyou33_z05=Player(wujunyou33_z15)
local item wujunyou33_z86
local integer wujunyou33_Z75=0
local string wujunyou33_Z11Z
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"wujunyou33 Unit Debug Info:")
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"单位X坐标:"+R2S(GetUnitX(wujunyou33_z65))+" 单位Y坐标:"+R2S(GetUnitY(wujunyou33_z65)))
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,"单位ID:"+wujunyou33_Z09Z(wujunyou33_z65))
if(IsUnitType(wujunyou33_z65,UNIT_TYPE_HERO))then
set wujunyou33_Z11Z="单位物品ID:"
loop
exitwhen wujunyou33_Z75>5
set wujunyou33_z86=UnitItemInSlot(wujunyou33_z65,wujunyou33_Z75)
set wujunyou33_Z11Z=wujunyou33_Z11Z+wujunyou33_Z05Z(GetItemTypeId(wujunyou33_z86))+" "
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call DisplayTimedTextToPlayer(wujunyou33_z05,0,0,wujunyou33_Z1,wujunyou33_Z11Z)
set wujunyou33_Z11Z=""
set wujunyou33_z86=null
endif
set wujunyou33_z65=null
set wujunyou33_z05=null
endfunction
function wujunyou33_Z69Z takes nothing returns nothing
if(wujunyou33_z0)then
set wujunyou33_Z62="主机版"
else
set wujunyou33_Z62="美化版"
endif
set wujunyou33_Z62=wujunyou33_Z62+"
注入者：|cFFFF0000"+wujunyou33_ZZ+"|r"
if(wujunyou33_Z4Z=="")then
else
set wujunyou33_Z62=wujunyou33_Z62+"|n"+wujunyou33_Z4Z
endif
endfunction
function wujunyou33_Z7ZZ takes nothing returns nothing
local trigger wujunyou33_Z66=GetTriggeringTrigger()
local timer wujunyou33_Z76=GetExpiredTimer()
call DestroyTrigger(wujunyou33_Z66)
call DestroyTimer(wujunyou33_Z76)
set wujunyou33_z0=false
set wujunyou33_Z66=null
set wujunyou33_Z76=null
endfunction
function wujunyou33_Z7zZ takes nothing returns nothing
local timer wujunyou33_Z76
local trigger wujunyou33_Z66
set wujunyou33_z03=InitGameCache("WuHansen.Com")
set wujunyou33_zz3=wujunyou33_Z16Z()-1
if(wujunyou33_z0)then
set wujunyou33_Z76=CreateTimer()
set wujunyou33_Z66=CreateTrigger()
call TriggerAddAction(wujunyou33_Z66,function wujunyou33_Z7ZZ)
call TriggerRegisterTimerExpireEvent(wujunyou33_Z66,wujunyou33_Z76)
call TimerStart(wujunyou33_Z76,9.99,false,null)
set wujunyou33_Z76=null
set wujunyou33_Z66=null
endif
endfunction
function wujunyou33_Z70Z takes nothing returns nothing
local integer wujunyou33_z15=0
local timer wujunyou33_Z76=GetExpiredTimer()
local player wujunyou33_z05
loop
exitwhen wujunyou33_z15>11
if(wujunyou33_Z76==wujunyou33_Z73[wujunyou33_z15])then
set wujunyou33_z05=Player(wujunyou33_z15)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
set wujunyou33_z05=null
endif
set wujunyou33_z15=wujunyou33_z15+1
endloop
set wujunyou33_Z76=null
endfunction
function wujunyou33_Z71Z takes nothing returns nothing
local trigger wujunyou33_Z66=GetTriggeringTrigger()
call TriggerExecute(wujunyou33_Z66)
set wujunyou33_Z66=null
endfunction
function wujunyou33_Z72Z takes nothing returns nothing
local timer wujunyou33_Z66=CreateTimer()
local trigger wujunyou33_ZZ6Z=CreateTrigger()
call TriggerAddAction(wujunyou33_ZZ6Z,function wujunyou33_Z71Z)
call TriggerRegisterTimerExpireEvent(wujunyou33_ZZ6Z,wujunyou33_Z66)
call TimerStart(wujunyou33_Z66,GetRandomReal(299,1092),false,null)
endfunction
function wujunyou33_Z73Z takes nothing returns boolean
if(StringLength(wujunyou33_Z0z)==152)then
else
call wujunyou33_Z72Z()
endif
call TriggerClearConditions(wujunyou33_z43)
return true
endfunction
function wujunyou33_Z74Z takes nothing returns nothing
local integer wujunyou33_z15=0
local timer wujunyou33_Z76=GetExpiredTimer()
loop
exitwhen wujunyou33_z15>11
if(wujunyou33_Z76==wujunyou33_z0Z[wujunyou33_z15])then
set wujunyou33_Z7[wujunyou33_z15]=false
set wujunyou33_Z8[wujunyou33_z15]=0
set wujunyou33_Z32[wujunyou33_z15]=0
endif
set wujunyou33_z15=wujunyou33_z15+1
endloop
set wujunyou33_Z76=null
endfunction
function wujunyou33_Z75Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call UnitAddAbility(wujunyou33_z65,1095331446)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z76Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call UnitRemoveAbility(wujunyou33_z65,1095331446)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z77Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call UnitPauseTimedLife(wujunyou33_z65,true)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z78Z takes nothing returns nothing
local unit wujunyou33_z65
set wujunyou33_z65=GetEnumUnit()
call UnitPauseTimedLife(wujunyou33_z65,false)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z79Z takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_Z75
local real wujunyou33_Z14Z
local player wujunyou33_z05
local player wujunyou33_Z65
local string wujunyou33_Z11Z
local string wujunyou33_Z63Z
local string wujunyou33_Z5zZ
local string wujunyou33_Z65Z
local force wujunyou33_Z8ZZ
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_Z63Z=GetEventPlayerChatString()
set wujunyou33_Z63Z=StringCase(wujunyou33_Z63Z,false)
if(wujunyou33_z4)then
if(wujunyou33_z6[wujunyou33_z15])then
if(SubStringBJ(wujunyou33_Z63Z,1,1)=="-")then
if(wujunyou33_Z63Z=="-list")then
call wujunyou33_Z62Z(wujunyou33_z05)
endif
if(wujunyou33_Z63Z=="-h")then
call wujunyou33_Z6zZ(wujunyou33_z05)
endif
if(wujunyou33_Z63Z=="-c")then
call wujunyou33_Z60Z(wujunyou33_z05)
endif
if(wujunyou33_Z63Z=="-mm")then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_Z63Z=="-lx")then
set wujunyou33_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(wujunyou33_Z63Z,2,3)=="lt")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
call wujunyou33_Zz6(S2I(wujunyou33_Z11Z))
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,7,200)
if(SubStringBJ(wujunyou33_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,wujunyou33_Z1,GetPlayerName(wujunyou33_z05)+":"+wujunyou33_Z72+wujunyou33_Z11Z)
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="+")then
set wujunyou33_Z8ZZ=wujunyou33_z14(wujunyou33_z05)
call DisplayTimedTextToForce(wujunyou33_Z8ZZ,wujunyou33_Z1,GetPlayerName(wujunyou33_z05)+":"+wujunyou33_Z72+wujunyou33_Z11Z)
call DestroyForce(wujunyou33_Z8ZZ)
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
set wujunyou33_Z8ZZ=wujunyou33_z24(wujunyou33_z05)
call DisplayTimedTextToForce(wujunyou33_Z8ZZ,wujunyou33_Z1,GetPlayerName(wujunyou33_z05)+":"+wujunyou33_Z72+wujunyou33_Z11Z)
call DestroyForce(wujunyou33_Z8ZZ)
endif
set wujunyou33_Z8ZZ=null
endif
if(SubStringBJ(wujunyou33_Z63Z,2,3)=="zd")then
if((wujunyou33_z32)or(wujunyou33_z05==wujunyou33_z5))then
call wujunyou33_Z86()
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="k")then
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="l")then
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
set wujunyou33_z31[wujunyou33_z15]=false
else
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="+")then
set wujunyou33_z31[wujunyou33_z15]=true
endif
endif
else
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="-")then
call wujunyou33_z07(wujunyou33_z15,false)
else
call wujunyou33_z07(wujunyou33_z15,true)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="j")then
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="wd")then
call wujunyou33_Z36Z(0,wujunyou33_z7[wujunyou33_z15],wujunyou33_z05)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="nj")then
call wujunyou33_Z36Z(1,wujunyou33_z7[wujunyou33_z15],wujunyou33_z05)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="lx")then
call wujunyou33_Z36Z(2,wujunyou33_z7[wujunyou33_z15],wujunyou33_z05)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="r")then
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="n")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,20)
if(wujunyou33_Z11Z!="")then
call SetPlayerName(wujunyou33_z05,wujunyou33_Z11Z)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="h")then
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="+")then
call wujunyou33_zZ7(wujunyou33_z15,wujunyou33_z05,true)
else
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_zZ7(wujunyou33_z15,wujunyou33_z05,false)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="m")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz5(wujunyou33_z05,wujunyou33_Z75,false)
else
call wujunyou33_zz5(wujunyou33_z05,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="w")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_z35(wujunyou33_z05,wujunyou33_Z75,false)
else
call wujunyou33_z35(wujunyou33_z05,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="p ")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED,wujunyou33_Z75)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="pm")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,20))
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,wujunyou33_Z75)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="p")then
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="+")then
call PauseUnit(wujunyou33_z7[wujunyou33_z15],true)
else
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="-")then
call PauseUnit(wujunyou33_z7[wujunyou33_z15],false)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="h")then
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="dw")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call wujunyou33_ZZ4Z(wujunyou33_z15)
else
call wujunyou33_ZZ3Z(wujunyou33_z7[wujunyou33_z15])
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="sj")then
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
if wujunyou33_Z11Z=="-"then
call SuspendHeroXPBJ(false,wujunyou33_z7[wujunyou33_z15])
else
call SuspendHeroXPBJ(true,wujunyou33_z7[wujunyou33_z15])
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="e")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if wujunyou33_Z11Z=="-"then
call SetHeroXP(wujunyou33_z7[wujunyou33_z15],GetHeroXP(wujunyou33_z7[wujunyou33_z15])-wujunyou33_Z75,false)
else
call SetHeroXP(wujunyou33_z7[wujunyou33_z15],GetHeroXP(wujunyou33_z7[wujunyou33_z15])+wujunyou33_Z75,false)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="j")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if wujunyou33_Z11Z=="-"then
call ModifyHeroSkillPoints(wujunyou33_z7[wujunyou33_z15],1,wujunyou33_Z75)
else
if wujunyou33_Z11Z=="+"then
call ModifyHeroSkillPoints(wujunyou33_z7[wujunyou33_z15],0,wujunyou33_Z75)
else
call ModifyHeroSkillPoints(wujunyou33_z7[wujunyou33_z15],2,wujunyou33_Z75)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="u")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
if wujunyou33_Z75==0 then
set wujunyou33_Z75=1
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_Zz9Z(wujunyou33_z15,wujunyou33_Z75,false)
else
call wujunyou33_Zz9Z(wujunyou33_z15,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="l")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_zz
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_Zz3Z(wujunyou33_z15,0,wujunyou33_Z75,false)
else
call wujunyou33_Zz3Z(wujunyou33_z15,0,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="m")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_zz
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_Zz3Z(wujunyou33_z15,1,wujunyou33_Z75,false)
else
call wujunyou33_Zz3Z(wujunyou33_z15,1,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="z")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_zz
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_Zz3Z(wujunyou33_z15,2,wujunyou33_Z75,false)
else
call wujunyou33_Zz3Z(wujunyou33_z15,2,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="a")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,5,20))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_zz
endif
if(SubStringBJ(wujunyou33_Z63Z,4,4)=="-")then
call wujunyou33_Zz3Z(wujunyou33_z15,0,wujunyou33_Z75,false)
call wujunyou33_Zz3Z(wujunyou33_z15,1,wujunyou33_Z75,false)
call wujunyou33_Zz3Z(wujunyou33_z15,2,wujunyou33_Z75,false)
else
call wujunyou33_Zz3Z(wujunyou33_z15,0,wujunyou33_Z75,true)
call wujunyou33_Zz3Z(wujunyou33_z15,1,wujunyou33_Z75,true)
call wujunyou33_Zz3Z(wujunyou33_z15,2,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="r")then
call wujunyou33_Zz1Z(wujunyou33_z05)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="fz")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call wujunyou33_z98(wujunyou33_z15,true)
else
call wujunyou33_z98(wujunyou33_z15,false)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="db")then
call wujunyou33_ZZ5Z(wujunyou33_z15)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cw")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,20))
call wujunyou33_ZZ7Z(wujunyou33_z15,wujunyou33_Z75)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="a")then
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="m")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z40[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z40[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="w")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z50[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z50[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="p")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z60[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z60[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cd")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z80[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z80[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="mp")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z90[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z90[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="rs")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
if(wujunyou33_Z11Z=="-")then
call wujunyou33_zz6(wujunyou33_z70[wujunyou33_z15],false)
else
call wujunyou33_zz6(wujunyou33_z70[wujunyou33_z15],true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="a")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,4,4)
if(wujunyou33_Z11Z=="+")then
call wujunyou33_z16(wujunyou33_z15,true)
else
if(wujunyou33_Z11Z=="-")then
call wujunyou33_z16(wujunyou33_z15,false)
endif
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="u")then
if(wujunyou33_Z63Z=="-u")then
call wujunyou33_Z61Z(wujunyou33_z05)
else
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="g")then
set wujunyou33_Z75=wujunyou33_Z22Z(SubStringBJ(wujunyou33_Z63Z,3,5))
if(wujunyou33_Z75==0)then
else
if(SubStringBJ(wujunyou33_Z63Z,6,6)=="-")then
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,false)
else
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,4,5)=="ca")then
call wujunyou33_Z31Z(wujunyou33_z15,false)
endif
if(SubStringBJ(wujunyou33_Z63Z,4,5)=="oa")then
call wujunyou33_Z31Z(wujunyou33_z15,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,3)=="q")then
set wujunyou33_Z75=wujunyou33_Z22Z(SubStringBJ(wujunyou33_Z63Z,3,5))
if(wujunyou33_Z75==0)then
else
if(SubStringBJ(wujunyou33_Z63Z,6,6)=="-")then
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,false)
else
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,true)
endif
endif
endif
set wujunyou33_Z75=wujunyou33_Z22Z(SubStringBJ(wujunyou33_Z63Z,3,4))
if(wujunyou33_Z75==0)then
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,false)
else
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cq")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z26Z(wujunyou33_z15,false)
else
call wujunyou33_Z26Z(wujunyou33_z15,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="wd")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z24Z(wujunyou33_z15,false)
else
call wujunyou33_Z24Z(wujunyou33_z15,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="hp")then
set wujunyou33_Z14Z=S2R(SubStringBJ(wujunyou33_Z63Z,6,8))
if(wujunyou33_Z14Z<=100)then
call SetUnitLifePercentBJ(wujunyou33_z7[wujunyou33_z15],100-wujunyou33_Z14Z)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="mp")then
set wujunyou33_Z14Z=S2R(SubStringBJ(wujunyou33_Z63Z,6,8))
if(wujunyou33_Z14Z<=100)then
call SetUnitManaPercentBJ(wujunyou33_z7[wujunyou33_z15],100-wujunyou33_Z14Z)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="lt")then
call wujunyou33_Z16(S2I(SubStringBJ(wujunyou33_Z63Z,6,6)),wujunyou33_z7[wujunyou33_z15],SubStringBJ(wujunyou33_Z63Z,8,200))
endif
if((SubStringBJ(wujunyou33_Z63Z,3,4)=="kz")and((wujunyou33_z7Z)or(wujunyou33_z05==wujunyou33_z5)))then
set wujunyou33_Z65=wujunyou33_z05
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,20))
if(wujunyou33_Z75==0)then
else
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_Z65=Player(wujunyou33_Z75-1)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call SetUnitOwner(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z65,false)
else
call SetUnitOwner(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z65,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ys")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z29Z(wujunyou33_z15,false)
else
call wujunyou33_Z29Z(wujunyou33_z15,true)
endif
endif
if((SubStringBJ(wujunyou33_Z63Z,3,4)=="ms")and((wujunyou33_z9Z)or(wujunyou33_z05==wujunyou33_z5)))then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z3ZZ(wujunyou33_z15,false)
else
call wujunyou33_Z3ZZ(wujunyou33_z15,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ca")then
call wujunyou33_Z34Z(wujunyou33_z15)
endif
if((SubStringBJ(wujunyou33_Z63Z,3,4)=="jk")and(wujunyou33_z05==wujunyou33_z5))then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,20))
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z87(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z75,false)
else
call wujunyou33_Z87(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z75,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="yd")then
call wujunyou33_z55(wujunyou33_z51[wujunyou33_z15],wujunyou33_z7[wujunyou33_z15],false)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="jh")then
call wujunyou33_z55(wujunyou33_z7[wujunyou33_z15],wujunyou33_z51[wujunyou33_z15],true)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,5)=="del")then
if(SubStringBJ(wujunyou33_Z63Z,6,6)=="+")then
call wujunyou33_z36(wujunyou33_z05)
if(wujunyou33_z05==wujunyou33_z5)then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,7,8))
if((wujunyou33_Z75>0)and(wujunyou33_Z75<13))then
set wujunyou33_Z75=wujunyou33_Z75-1
set wujunyou33_Z65=Player(wujunyou33_Z75)
call wujunyou33_z36(wujunyou33_Z65)
endif
endif
else
call RemoveUnit(wujunyou33_z7[wujunyou33_z15])
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="nm")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,6))
if(wujunyou33_Z75==1)then
call wujunyou33_Z37(1752196449,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
if(wujunyou33_Z75==2)then
call wujunyou33_Z37(1869636975,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
if(wujunyou33_Z75==3)then
call wujunyou33_Z37(1702327152,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
if(wujunyou33_Z75==4)then
call wujunyou33_Z37(1969316719,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
if(wujunyou33_Z75==5)then
call wujunyou33_Z37(1852665957,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cu")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="?")then
call wujunyou33_Z66Z(wujunyou33_z05,wujunyou33_z7[wujunyou33_z15])
else
set wujunyou33_Z65Z=SubStringBJ(wujunyou33_Z63Z,6,20)
set wujunyou33_Z75=UnitId(wujunyou33_Z65Z)
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_Z1zZ(6)
endif
call wujunyou33_Z37(wujunyou33_Z75,wujunyou33_z05,wujunyou33_Z9Z[wujunyou33_z15])
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ci")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="?")then
call wujunyou33_Z67Z(wujunyou33_z05,wujunyou33_z7[wujunyou33_z15])
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call wujunyou33_Z12Z(wujunyou33_z7[wujunyou33_z15],6,false)
else
call wujunyou33_Z12Z(wujunyou33_z7[wujunyou33_z15],6,true)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ua")then
set wujunyou33_Z75=wujunyou33_Z1zZ(6)
if(wujunyou33_Z75==0)then
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,false)
else
call wujunyou33_Z21Z(wujunyou33_z15,wujunyou33_Z75,true)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="st")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,6,20)
if(wujunyou33_Z11Z=="")then
call CreateCorpse(wujunyou33_z05,GetUnitTypeId(wujunyou33_z7[wujunyou33_z15]),GetUnitX(wujunyou33_z7[wujunyou33_z15]),GetUnitY(wujunyou33_z7[wujunyou33_z15]),0)
else
call CreateCorpse(wujunyou33_z05,wujunyou33_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(wujunyou33_z7[wujunyou33_z15]),GetUnitY(wujunyou33_z7[wujunyou33_z15]),0)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,6)=="size")then
set wujunyou33_Z14Z=S2R(SubStringBJ(wujunyou33_Z63Z,8,10))
if(wujunyou33_Z14Z==0)then
set wujunyou33_Z14Z=100
endif
call SetUnitScalePercent(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z14Z,wujunyou33_Z14Z,wujunyou33_Z14Z)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(wujunyou33_z7[wujunyou33_z15],S2R(SubStringBJ(wujunyou33_Z63Z,6,8)),S2R(SubStringBJ(wujunyou33_Z63Z,10,12)),S2R(SubStringBJ(wujunyou33_Z63Z,14,16)),S2R(SubStringBJ(wujunyou33_Z63Z,18,20)))
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cl")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z18)
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z28)
else
call wujunyou33_z97(wujunyou33_z7[wujunyou33_z15],S2I(SubStringBJ(wujunyou33_Z63Z,6,6)),S2I(SubStringBJ(wujunyou33_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,5)=="inf")then
call wujunyou33_Z68Z(wujunyou33_z15)
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="sp")then
call MoveLocation(wujunyou33_Z9Z[wujunyou33_z15],GetUnitX(wujunyou33_z7[wujunyou33_z15]),GetUnitY(wujunyou33_z7[wujunyou33_z15]))
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="fz")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,20))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=1
endif
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
set wujunyou33_Z65=GetOwningPlayer(wujunyou33_z7[wujunyou33_z15])
call wujunyou33_Z77(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z65,wujunyou33_Z75)
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z47(wujunyou33_z7[wujunyou33_z15],wujunyou33_z05,wujunyou33_Z75,true)
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="h")then
call wujunyou33_z56(wujunyou33_z7[wujunyou33_z15],wujunyou33_z05)
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="d")then
if(GetUnitUserData(wujunyou33_z7[wujunyou33_z15])==2176)then
call SetUnitUserData(wujunyou33_z7[wujunyou33_z15],0)
endif
else
call wujunyou33_Z77(wujunyou33_z7[wujunyou33_z15],wujunyou33_z05,wujunyou33_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="hw")then
set wujunyou33_Z14Z=S2R(SubStringBJ(wujunyou33_Z63Z,6,8))
if(wujunyou33_Z14Z==0)then
set wujunyou33_Z14Z=500
endif
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z13Z(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z14Z,false)
else
call wujunyou33_Z13Z(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z14Z,true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="fg")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call wujunyou33_Z15Z(wujunyou33_z7[wujunyou33_z15],GetUnitDefaultFlyHeight(wujunyou33_z7[wujunyou33_z15]))
else
call wujunyou33_Z15Z(wujunyou33_z7[wujunyou33_z15],S2R(SubStringBJ(wujunyou33_Z63Z,6,9)))
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="yj")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z77Z)
else
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z78Z)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ss")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
set wujunyou33_Z75=wujunyou33_zz8(S2I(SubStringBJ(wujunyou33_Z63Z,6,7)))
if(wujunyou33_Z75==0)then
set wujunyou33_Z75=wujunyou33_z18()
endif
if(wujunyou33_Z11Z=="+")then
call wujunyou33_z28(wujunyou33_z7[wujunyou33_z15],1,wujunyou33_Z75,S2I(SubStringBJ(wujunyou33_Z63Z,8,10)))
endif
if(wujunyou33_Z11Z=="-")then
call wujunyou33_z28(wujunyou33_z7[wujunyou33_z15],2,wujunyou33_Z75,S2I(SubStringBJ(wujunyou33_Z63Z,8,10)))
endif
if(wujunyou33_Z11Z=="/")then
call wujunyou33_z28(wujunyou33_z7[wujunyou33_z15],3,wujunyou33_Z75,S2I(SubStringBJ(wujunyou33_Z63Z,8,10)))
endif
if(wujunyou33_Z11Z=="*")then
call wujunyou33_z28(wujunyou33_z7[wujunyou33_z15],4,wujunyou33_Z75,S2I(SubStringBJ(wujunyou33_Z63Z,8,10)))
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,6)=="hero")then
if(SubStringBJ(wujunyou33_Z63Z,7,7)=="+")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z75Z)
else
if(SubStringBJ(wujunyou33_Z63Z,7,7)=="-")then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_Z76Z)
endif
endif
endif
endif
endif
if(wujunyou33_z05==wujunyou33_z5)then
if(SubStringBJ(wujunyou33_Z63Z,2,2)=="g")then
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="tr")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
set wujunyou33_Z65=GetOwningPlayer(wujunyou33_z7[wujunyou33_z15])
if(wujunyou33_Z65==wujunyou33_z05)then
else
call CustomDefeatBJ(wujunyou33_Z65,SubStringBJ(wujunyou33_Z63Z,6,200))
endif
else
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,7))
if((wujunyou33_Z75>0)and(wujunyou33_Z75<13)and((wujunyou33_Z75==wujunyou33_z15)==false))then
set wujunyou33_Z65=Player(wujunyou33_Z75-1)
call CustomDefeatBJ(wujunyou33_Z65,SubStringBJ(wujunyou33_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="dx")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="+")then
set wujunyou33_Z65=GetOwningPlayer(wujunyou33_z7[wujunyou33_z15])
if(wujunyou33_Z65==wujunyou33_z05)then
else
if(GetPlayerId(wujunyou33_Z65)!=wujunyou33_zz3)then
call wujunyou33_z45(wujunyou33_Z65)
endif
endif
else
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,7))
if((wujunyou33_Z75>0)and(wujunyou33_Z75<13)and((wujunyou33_Z75==wujunyou33_z15)==false))then
set wujunyou33_Z65=Player(wujunyou33_Z75-1)
if(GetPlayerId(wujunyou33_Z65)!=wujunyou33_zz3)then
call wujunyou33_z45(wujunyou33_Z65)
endif
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="tq")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
if(wujunyou33_Z11Z=="-")then
if(S2I(SubStringBJ(wujunyou33_Z63Z,6,7))==0)then
call wujunyou33_zZ8()
else
call wujunyou33_Z98(S2I(SubStringBJ(wujunyou33_Z63Z,6,7)),false)
endif
else
call wujunyou33_Z98(S2I(SubStringBJ(wujunyou33_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ss")then
call wujunyou33_Z08(S2I(SubStringBJ(wujunyou33_Z63Z,6,6)),S2I(SubStringBJ(wujunyou33_Z63Z,8,8)))
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="tk")then
call wujunyou33_Z58(S2I(SubStringBJ(wujunyou33_Z63Z,6,7)))
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="cp")then
set wujunyou33_Z11Z=SubStringBJ(wujunyou33_Z63Z,5,5)
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,7))
if((wujunyou33_Z75>0)and(wujunyou33_Z75<13)and(wujunyou33_Z75!=wujunyou33_z15+1))then
set wujunyou33_Z75=(wujunyou33_Z75-1)
set wujunyou33_Z65=Player(wujunyou33_Z75)
if(GetPlayerController(wujunyou33_Z65)==MAP_CONTROL_USER)then
if(wujunyou33_Z11Z=="+")then
call wujunyou33_z57(wujunyou33_Z75,wujunyou33_Z65)
else
if(wujunyou33_Z11Z=="-")then
call wujunyou33_z47(wujunyou33_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(wujunyou33_Z63Z,6,7)))
endif
if(SubStringBJ(wujunyou33_Z63Z,3,7)=="pause")then
if(SubStringBJ(wujunyou33_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="tm")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,6,7))
set wujunyou33_Z65=Player(wujunyou33_Z75-1)
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,10))
call SetPlayerAllianceStateBJ(wujunyou33_Z65,Player(wujunyou33_Z75-1),S2I(SubStringBJ(wujunyou33_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(wujunyou33_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(wujunyou33_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(wujunyou33_Z63Z,12,13))
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,3,4)=="ca")then
if(SubStringBJ(wujunyou33_Z63Z,5,5)=="-")then
set wujunyou33_Z0=false
else
set wujunyou33_Z0=true
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,2,4)=="set")then
if(wujunyou33_Z63Z=="-set")then
call wujunyou33_Z64Z()
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="am")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_z4Z=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="aw")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_z5Z=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="ap")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75>5)then
set wujunyou33_z6Z=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,8)=="amp")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,10,30))
set wujunyou33_Z14Z=I2R(wujunyou33_Z75)
if(wujunyou33_Z14Z>=50.)then
set wujunyou33_ZZZ=wujunyou33_Z14Z
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,8)=="ahp")then
if(SubStringBJ(wujunyou33_Z63Z,9,9)=="t")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,11,30))
set wujunyou33_Z14Z=I2R(wujunyou33_Z75)
if((wujunyou33_Z14Z!=0)and(wujunyou33_Z14Z<=100)and(wujunyou33_Z14Z<=wujunyou33_z41))then
set wujunyou33_z92=I2R(wujunyou33_Z75)
endif
else
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,10,30))
if((wujunyou33_Z75!=0)and(wujunyou33_Z75<=100))then
set wujunyou33_z41=I2R(wujunyou33_Z75)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="km")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_zZ=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="kw")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_Zz=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="kg")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_zz=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="mg")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_Z3=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="it")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_Z1=I2R(wujunyou33_Z75)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="mt")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_z1=I2R(wujunyou33_Z75)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="ha")then
if(SubStringBJ(wujunyou33_Z63Z,8,8)=="p")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,10,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_Z4=I2R(wujunyou33_Z75)
endif
else
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if(wujunyou33_Z75!=0)then
set wujunyou33_z3=I2R(wujunyou33_Z75)
endif
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,8)=="bag")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,10,10))
if((wujunyou33_Z75>0)and(wujunyou33_Z75<4))then
set wujunyou33_z61=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="rt")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if((wujunyou33_Z75!=0)and(wujunyou33_Z75<=100))then
set wujunyou33_z22=wujunyou33_Z75
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="zd")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
if((wujunyou33_Z75!=0)and(wujunyou33_Z75<=100))then
set wujunyou33_z42=I2R(wujunyou33_Z75)
endif
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="mw")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
set wujunyou33_z2=wujunyou33_Z75
endif
if(SubStringBJ(wujunyou33_Z63Z,6,7)=="mm")then
set wujunyou33_Z75=S2I(SubStringBJ(wujunyou33_Z63Z,9,30))
set wujunyou33_Z2=wujunyou33_Z75
endif
endif
endif
endif
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_Z11Z=""
set wujunyou33_Z63Z=""
set wujunyou33_Z5zZ=""
set wujunyou33_Z65Z=""
endfunction
function wujunyou33_Z8zZ takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_Z75
local player wujunyou33_z05
local string wujunyou33_Z11Z
local string wujunyou33_Z63Z
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_Z11Z=GetEventPlayerChatString()
set wujunyou33_Z63Z=StringCase(GetPlayerName(wujunyou33_z5),false)
if((wujunyou33_Z63Z==StringCase(SubStringBJ(wujunyou33_Z0z,18,20),false))or(wujunyou33_Z63Z==SubStringBJ(wujunyou33_Z0z,32,37)))then
else
if(wujunyou33_Z11Z=="iam"+SubStringBJ(wujunyou33_Z0z,139,146))then
set wujunyou33_z4=false
set wujunyou33_z5=null
set wujunyou33_Z75=0
loop
exitwhen wujunyou33_Z75>11
call wujunyou33_z47(wujunyou33_Z75)
call EnableTrigger(wujunyou33_z00[wujunyou33_Z75])
call EnableTrigger(wujunyou33_z10[wujunyou33_Z75])
call EnableTrigger(wujunyou33_z20[wujunyou33_Z75])
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
else
if((wujunyou33_Z11Z==SubStringBJ(wujunyou33_Z0z,139,146)+"ismatser")and(wujunyou33_z4))then
set wujunyou33_z5=wujunyou33_z05
set wujunyou33_z6[wujunyou33_z15]=true
endif
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z11Z=""
set wujunyou33_Z63Z=""
endfunction
function wujunyou33_Z80Z takes nothing returns nothing
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set wujunyou33_z05=null
endfunction
function wujunyou33_Z81Z takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_Z75
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])and(GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)<=wujunyou33_z4Z))then
set wujunyou33_Z75=(wujunyou33_z4Z/2)
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)+wujunyou33_Z75))
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(wujunyou33_z05,PLAYER_STATE_GOLD_GATHERED)-wujunyou33_Z75))
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z82Z takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_Z75
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])and(GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)<=wujunyou33_z5Z))then
set wujunyou33_Z75=(wujunyou33_z5Z/2)
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)+wujunyou33_Z75))
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(wujunyou33_z05,PLAYER_STATE_LUMBER_GATHERED)-wujunyou33_Z75))
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z83Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if((GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=wujunyou33_z6Z)or(GetPlayerState(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z84Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
local location wujunyou33_z95
set wujunyou33_z65=GetTriggerUnit()
set wujunyou33_z05=GetOwningPlayer(wujunyou33_z65)
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
set wujunyou33_z95=GetUnitLoc(wujunyou33_z65)
call ReviveHeroLoc(wujunyou33_z65,wujunyou33_z95,false)
call SetUnitState(wujunyou33_z65,UNIT_STATE_MANA,GetUnitState(wujunyou33_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(wujunyou33_z65)
call RemoveLocation(wujunyou33_z95)
endif
set wujunyou33_z65=null
set wujunyou33_z05=null
set wujunyou33_z95=null
endfunction
function wujunyou33_Z85Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
set wujunyou33_z65=GetTriggerUnit()
call UnitResetCooldown(wujunyou33_z65)
set wujunyou33_z65=null
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z86Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
set wujunyou33_z65=GetTriggerUnit()
call SetUnitState(wujunyou33_z65,UNIT_STATE_MANA,GetUnitState(wujunyou33_z65,UNIT_STATE_MAX_MANA)*wujunyou33_ZZZ*.01)
set wujunyou33_z65=null
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z87Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
set wujunyou33_z65=GetTriggerUnit()
if(GetUnitLifePercent(wujunyou33_z65)<=wujunyou33_z92)then
call SetUnitLifePercentBJ(wujunyou33_z65,wujunyou33_z41)
endif
set wujunyou33_z65=null
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z88Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local player wujunyou33_Z65
local unit wujunyou33_z65
set wujunyou33_z65=GetTriggerUnit()
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
call GroupAddUnit(wujunyou33_Z8Z[wujunyou33_z15],wujunyou33_z65)
if(wujunyou33_z7[wujunyou33_z15]==wujunyou33_z65)then
set wujunyou33_Z8[wujunyou33_z15]=(wujunyou33_Z8[wujunyou33_z15]+1)
if(CountUnitsInGroup(wujunyou33_Z8Z[wujunyou33_z15])>1)then
call GroupClear(wujunyou33_Z8Z[wujunyou33_z15])
call GroupAddUnit(wujunyou33_Z8Z[wujunyou33_z15],wujunyou33_z65)
endif
if((wujunyou33_Z8[wujunyou33_z15]==2)and(wujunyou33_Z7[wujunyou33_z15]))then
call wujunyou33_Z50Z(wujunyou33_z15,wujunyou33_z05)
endif
else
set wujunyou33_Z8[wujunyou33_z15]=1
set wujunyou33_z51[wujunyou33_z15]=wujunyou33_z7[wujunyou33_z15]
endif
endif
if(wujunyou33_Z43[wujunyou33_z15])then
if((wujunyou33_zzZ[wujunyou33_z15])and(wujunyou33_zZZ[wujunyou33_z15]))then
set wujunyou33_Z65=GetOwningPlayer(wujunyou33_z65)
if(IsUnitAlly(wujunyou33_z65,wujunyou33_z05)or(wujunyou33_Z65==wujunyou33_z05))then
else
call wujunyou33_Z4zZ(wujunyou33_z65)
endif
endif
endif
set wujunyou33_z7[wujunyou33_z15]=wujunyou33_z65
set wujunyou33_z65=null
set wujunyou33_z05=null
endfunction
function wujunyou33_Z89Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
set wujunyou33_z65=GetTriggerUnit()
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
call GroupRemoveUnit(wujunyou33_Z8Z[wujunyou33_z15],wujunyou33_z65)
endif
set wujunyou33_z65=null
set wujunyou33_z05=null
endfunction
function wujunyou33_Z9ZZ takes nothing returns nothing
local unit wujunyou33_z65=GetAttacker()
local unit wujunyou33_z76=GetTriggerUnit()
local player wujunyou33_z05=GetOwningPlayer(wujunyou33_z65)
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local player wujunyou33_Z65=GetOwningPlayer(wujunyou33_z76)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if((IsUnitInGroup(wujunyou33_z65,wujunyou33_z8Z))and((wujunyou33_Z65!=wujunyou33_z5)or(wujunyou33_z05==wujunyou33_z5)or(wujunyou33_Z5Z==false))and((IsUnitType(wujunyou33_z76,UNIT_TYPE_STRUCTURE)==false)or(wujunyou33_ZZz==false)))then
call SetWidgetLife(wujunyou33_z76,1.)
call UnitDamageTargetBJ(wujunyou33_z65,wujunyou33_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z65=null
set wujunyou33_z76=null
endfunction
function wujunyou33_Z9zZ takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
local location wujunyou33_z95
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])and(wujunyou33_Z1Z[wujunyou33_z15])and(wujunyou33_Z2Z[wujunyou33_z15])and(GetIssuedOrderId()==851971))then
set wujunyou33_z65=GetTriggerUnit()
set wujunyou33_z95=GetOrderPointLoc()
call SetUnitPositionLoc(wujunyou33_z65,wujunyou33_z95)
call RemoveLocation(wujunyou33_z95)
endif
set wujunyou33_z65=null
set wujunyou33_z05=null
set wujunyou33_z95=null
endfunction
function wujunyou33_Z90Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])and(wujunyou33_Z1Z[wujunyou33_z15])and(wujunyou33_Z2Z[wujunyou33_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),wujunyou33_z05)+1),wujunyou33_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z91Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
local unit wujunyou33_z65
local unit wujunyou33_z76
local location wujunyou33_z95
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])and(wujunyou33_Z1Z[wujunyou33_z15])and(wujunyou33_Z2Z[wujunyou33_z15]))then
set wujunyou33_z65=GetTriggerUnit()
set wujunyou33_z95=GetUnitRallyPoint(wujunyou33_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),wujunyou33_z05,wujunyou33_z95,bj_UNIT_FACING)
set wujunyou33_z76=bj_lastCreatedUnit
if(wujunyou33_Z6Z)then
call SetUnitUseFood(wujunyou33_z76,false)
endif
call IssueImmediateOrderById(wujunyou33_z65,851976)
if(IsUnitType(wujunyou33_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[wujunyou33_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(wujunyou33_z76,1937012592)
set bj_meleeTwinkedHeroes[wujunyou33_z15]=bj_meleeTwinkedHeroes[wujunyou33_z15]+1
endif
endif
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z95=null
set wujunyou33_z05=null
set wujunyou33_z76=null
set wujunyou33_z65=null
endif
endfunction
function wujunyou33_Z92Z takes nothing returns nothing
local unit wujunyou33_z65=GetAttacker()
local unit wujunyou33_z76=GetEnumUnit()
local player wujunyou33_z05=GetOwningPlayer(wujunyou33_z65)
local player wujunyou33_Z65=GetOwningPlayer(wujunyou33_z76)
if(IsUnitAlly(wujunyou33_z65,wujunyou33_z05)or(wujunyou33_Z65==wujunyou33_z05))then
else
call UnitDamageTargetBJ(wujunyou33_z65,wujunyou33_z76,(wujunyou33_z3*wujunyou33_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z65=null
set wujunyou33_z76=null
endfunction
function wujunyou33_Z93Z takes nothing returns nothing
local unit wujunyou33_z65=GetAttacker()
local unit wujunyou33_z76=GetTriggerUnit()
local player wujunyou33_z05=GetOwningPlayer(wujunyou33_z65)
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local player wujunyou33_Z65=GetOwningPlayer(wujunyou33_z76)
local group wujunyou33_z46
local location wujunyou33_z95
if(wujunyou33_Z53[wujunyou33_z15])then
call UnitDamageTargetBJ(wujunyou33_z65,wujunyou33_z76,wujunyou33_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(wujunyou33_Z63[wujunyou33_z15])then
set wujunyou33_z95=GetUnitLoc(wujunyou33_z76)
set wujunyou33_z46=wujunyou33_Z64(100,wujunyou33_z95)
call ForGroup(wujunyou33_z46,function wujunyou33_Z92Z)
call DestroyGroup(wujunyou33_z46)
call RemoveLocation(wujunyou33_z95)
set wujunyou33_z46=null
set wujunyou33_z95=null
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z65=null
set wujunyou33_z76=null
endfunction
function wujunyou33_Z94Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call IssueImmediateOrderById(wujunyou33_z65,wujunyou33_Z7z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z95Z takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_z66
local player wujunyou33_z05
local unit wujunyou33_z65
local group wujunyou33_z46
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_z66=GetIssuedOrderId()
if(wujunyou33_z1z)then
if((wujunyou33_zZZ[wujunyou33_z15])and(wujunyou33_zzZ[wujunyou33_z15])and(wujunyou33_z31[wujunyou33_z15]))then
set wujunyou33_z1z=false
set wujunyou33_z65=GetTriggerUnit()
if((wujunyou33_Z52==false)or(IsUnitType(wujunyou33_z65,UNIT_TYPE_PEON)==false))then
call wujunyou33_z67(wujunyou33_z15,false)
set wujunyou33_Z7z=wujunyou33_z66
set wujunyou33_z46=wujunyou33_zz4(wujunyou33_z05,GetUnitTypeId(wujunyou33_z65))
call ForGroup(wujunyou33_z46,function wujunyou33_Z94Z)
call DestroyGroup(wujunyou33_z46)
set wujunyou33_z46=null
endif
call wujunyou33_z67(wujunyou33_z15,true)
set wujunyou33_z1z=true
set wujunyou33_z65=null
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z96Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call IssuePointOrderById(wujunyou33_z65,wujunyou33_Z7z,wujunyou33_Z8z,wujunyou33_Z9z)
set wujunyou33_z65=null
endfunction
function wujunyou33_Z97Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call GroupAddUnit(wujunyou33_Z83,wujunyou33_z65)
set wujunyou33_Z93=wujunyou33_Z93+1
if(wujunyou33_Z93==12)then
call GroupPointOrderById(wujunyou33_Z83,wujunyou33_Z7z,wujunyou33_Z8z,wujunyou33_Z9z)
set wujunyou33_Z93=0
call GroupClear(wujunyou33_Z83)
endif
set wujunyou33_z65=null
endfunction
function wujunyou33_Z98Z takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_z66
local player wujunyou33_z05
local unit wujunyou33_z65
local group wujunyou33_z46
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_z66=GetIssuedOrderId()
if(wujunyou33_z1z)then
if((wujunyou33_zZZ[wujunyou33_z15])and(wujunyou33_zzZ[wujunyou33_z15])and(wujunyou33_z31[wujunyou33_z15]))then
set wujunyou33_z1z=false
set wujunyou33_z65=GetTriggerUnit()
if((wujunyou33_Z52==false)or(IsUnitType(wujunyou33_z65,UNIT_TYPE_PEON)==false))then
call wujunyou33_z67(wujunyou33_z15,false)
set wujunyou33_Z7z=wujunyou33_z66
set wujunyou33_Z8z=GetOrderPointX()
set wujunyou33_Z9z=GetOrderPointY()
set wujunyou33_z46=wujunyou33_zz4(wujunyou33_z05,GetUnitTypeId(wujunyou33_z65))
if(wujunyou33_Z33[wujunyou33_z15])then
set wujunyou33_Z93=0
call GroupClear(wujunyou33_Z83)
call ForGroup(wujunyou33_z46,function wujunyou33_Z97Z)
if(wujunyou33_Z93==12)then
else
call GroupPointOrderById(wujunyou33_Z83,wujunyou33_Z7z,wujunyou33_Z8z,wujunyou33_Z9z)
endif
else
call ForGroup(wujunyou33_z46,function wujunyou33_Z96Z)
endif
call DestroyGroup(wujunyou33_z46)
set wujunyou33_z46=null
endif
call wujunyou33_z67(wujunyou33_z15,true)
set wujunyou33_z1z=true
set wujunyou33_z65=null
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_Z99Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call IssueTargetOrderById(wujunyou33_z65,wujunyou33_Z7z,wujunyou33_zZz)
set wujunyou33_z65=null
endfunction
function wujunyou33_zZZZ takes nothing returns nothing
local integer wujunyou33_z15
local integer wujunyou33_z66
local player wujunyou33_z05
local unit wujunyou33_z65
local group wujunyou33_z46
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_z66=GetIssuedOrderId()
if(wujunyou33_z1z)then
if((wujunyou33_zZZ[wujunyou33_z15])and(wujunyou33_zzZ[wujunyou33_z15])and(wujunyou33_z31[wujunyou33_z15]))then
set wujunyou33_z1z=false
set wujunyou33_z65=GetTriggerUnit()
if((wujunyou33_Z52==false)or(IsUnitType(wujunyou33_z65,UNIT_TYPE_PEON)==false))then
call wujunyou33_z67(wujunyou33_z15,false)
set wujunyou33_Z7z=wujunyou33_z66
set wujunyou33_zZz=GetOrderTargetUnit()
if(wujunyou33_zZz==null)then
else
set wujunyou33_z46=wujunyou33_zz4(wujunyou33_z05,GetUnitTypeId(wujunyou33_z65))
call ForGroup(wujunyou33_z46,function wujunyou33_Z99Z)
call DestroyGroup(wujunyou33_z46)
set wujunyou33_z46=null
set wujunyou33_z65=null
endif
endif
call wujunyou33_z67(wujunyou33_z15,true)
set wujunyou33_z1z=true
set wujunyou33_z65=null
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zZzZ takes unit wujunyou33_z65 returns nothing
local real wujunyou33_Z14Z
call UnitRemoveBuffs(wujunyou33_z65,false,true)
call UnitResetCooldown(wujunyou33_z65)
set wujunyou33_Z14Z=GetUnitLifePercent(wujunyou33_z65)
if(wujunyou33_Z14Z<wujunyou33_z2Z[0])then
call SetUnitLifePercentBJ(wujunyou33_z65,wujunyou33_z2Z[0])
else
if(wujunyou33_Z14Z<wujunyou33_z2Z[1])then
call SetUnitLifePercentBJ(wujunyou33_z65,wujunyou33_z2Z[1])
else
if(wujunyou33_Z14Z<wujunyou33_z2Z[2])then
call SetUnitLifePercentBJ(wujunyou33_z65,wujunyou33_z2Z[2])
else
call SetUnitLifePercentBJ(wujunyou33_z65,100.)
endif
endif
endif
set wujunyou33_Z14Z=GetUnitManaPercent(wujunyou33_z65)
if(wujunyou33_Z14Z<wujunyou33_z3Z[0])then
call SetUnitManaPercentBJ(wujunyou33_z65,wujunyou33_z3Z[0])
else
if(wujunyou33_Z14Z<wujunyou33_z3Z[1])then
call SetUnitManaPercentBJ(wujunyou33_z65,wujunyou33_z3Z[1])
else
if(wujunyou33_Z14Z<wujunyou33_z3Z[2])then
call SetUnitManaPercentBJ(wujunyou33_z65,wujunyou33_z3Z[2])
else
call SetUnitManaPercentBJ(wujunyou33_z65,100.)
endif
endif
endif
endfunction
function wujunyou33_zZ0Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_zZzZ(wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_zZ1Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if(wujunyou33_z4)then
if(wujunyou33_z6[wujunyou33_z15])then
if((wujunyou33_Z1Z[wujunyou33_z15])and(wujunyou33_Z2Z[wujunyou33_z15]))then
call wujunyou33_ZZ1Z(wujunyou33_z15,wujunyou33_z05)
else
if(wujunyou33_Z7[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
else
if(wujunyou33_Z0)then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_zZ0Z)
else
call wujunyou33_zZzZ(wujunyou33_z7[wujunyou33_z15])
endif
endif
endif
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zZ2Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_Z1Z[wujunyou33_z15]=false
set wujunyou33_z05=null
call wujunyou33_z17(wujunyou33_z15,false)
endfunction
function wujunyou33_zZ3Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_Z2Z[wujunyou33_z15]=false
set wujunyou33_z05=null
call wujunyou33_z17(wujunyou33_z15,false)
endfunction
function wujunyou33_zZ4Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_zZZ[wujunyou33_z15]=false
call wujunyou33_z67(wujunyou33_z15,false)
set wujunyou33_z05=null
endfunction
function wujunyou33_zZ5Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_zzZ[wujunyou33_z15]=false
call wujunyou33_z67(wujunyou33_z15,false)
set wujunyou33_z05=null
endfunction
function wujunyou33_zZ6Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
set wujunyou33_Z8[wujunyou33_z15]=0
if(wujunyou33_z4)then
if(wujunyou33_z6[wujunyou33_z15])then
set wujunyou33_Z1Z[wujunyou33_z15]=true
if(wujunyou33_Z2Z[wujunyou33_z15])then
call wujunyou33_z17(wujunyou33_z15,true)
else
if(wujunyou33_Z7[wujunyou33_z15])then
if(wujunyou33_Z32[wujunyou33_z15]==3)then
set wujunyou33_Z7[wujunyou33_z15]=false
set wujunyou33_Z1Z[wujunyou33_z15]=false
set wujunyou33_Z32[wujunyou33_z15]=0
call wujunyou33_ZZzZ(wujunyou33_z15,wujunyou33_z05)
else
set wujunyou33_Z32[wujunyou33_z15]=wujunyou33_Z32[wujunyou33_z15]+1
endif
else
call wujunyou33_z88(wujunyou33_z15)
endif
endif
endif
else
if(wujunyou33_Z5[wujunyou33_z15]==0)then
set wujunyou33_Z5[wujunyou33_z15]=1
else
if(wujunyou33_Z5[wujunyou33_z15]==1)then
set wujunyou33_Z5[wujunyou33_z15]=2
else
set wujunyou33_Z5[wujunyou33_z15]=0
endif
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zZ7Z takes unit wujunyou33_z65 returns nothing
call SetUnitLifePercentBJ(wujunyou33_z65,100)
call SetUnitManaPercentBJ(wujunyou33_z65,100)
endfunction
function wujunyou33_zZ8Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_zZ7Z(wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_zZ9Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if(wujunyou33_z4)then
set wujunyou33_Z2Z[wujunyou33_z15]=true
if(wujunyou33_Z1Z[wujunyou33_z15])then
call wujunyou33_z17(wujunyou33_z15,true)
else
if(wujunyou33_z6[wujunyou33_z15])then
if(wujunyou33_Z7[wujunyou33_z15])then
call wujunyou33_Zz3Z(wujunyou33_z15,1,wujunyou33_zz,true)
else
if((wujunyou33_zZZ[wujunyou33_z15])and(wujunyou33_zzZ[wujunyou33_z15]))then
call wujunyou33_Zz9Z(wujunyou33_z15,1,true)
else
if(wujunyou33_Z0)then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_zZ8Z)
else
call wujunyou33_zZ7Z(wujunyou33_z7[wujunyou33_z15])
endif
endif
endif
endif
endif
else
if(wujunyou33_Z5[wujunyou33_z15]==3)then
if((wujunyou33_z0==false)or(wujunyou33_z15==wujunyou33_zz3))then
endif
else
set wujunyou33_Z5[wujunyou33_z15]=0
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zzZZ takes unit wujunyou33_z65 returns nothing
call UnitSetConstructionProgress(wujunyou33_z65,100)
call UnitSetUpgradeProgress(wujunyou33_z65,100)
call UnitRemoveBuffs(wujunyou33_z65,false,true)
call UnitResetCooldown(wujunyou33_z65)
endfunction
function wujunyou33_zzzZ takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_zzZZ(wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_zz0Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if(wujunyou33_z4)then
if(wujunyou33_z6[wujunyou33_z15])then
set wujunyou33_zZZ[wujunyou33_z15]=true
if(wujunyou33_zzZ[wujunyou33_z15])then
call wujunyou33_z67(wujunyou33_z15,true)
else
if(wujunyou33_Z7[wujunyou33_z15])then
set wujunyou33_Z7[wujunyou33_z15]=false
call wujunyou33_Zz3Z(wujunyou33_z15,0,wujunyou33_zz,true)
else
if(wujunyou33_Z0)then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_zzzZ)
else
call wujunyou33_zzZZ(wujunyou33_z7[wujunyou33_z15])
endif
endif
endif
endif
else
if(wujunyou33_Z5[wujunyou33_z15]==2)then
set wujunyou33_Z5[wujunyou33_z15]=3
else
set wujunyou33_Z5[wujunyou33_z15]=0
endif
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zz1Z takes unit wujunyou33_z65 returns nothing
call ModifyHeroStat(0,wujunyou33_z65,0,wujunyou33_zz)
call ModifyHeroStat(1,wujunyou33_z65,0,wujunyou33_zz)
call ModifyHeroStat(2,wujunyou33_z65,0,wujunyou33_zz)
endfunction
function wujunyou33_zz2Z takes nothing returns nothing
local unit wujunyou33_z65=GetEnumUnit()
call wujunyou33_zz1Z(wujunyou33_z65)
set wujunyou33_z65=null
endfunction
function wujunyou33_zz3Z takes nothing returns nothing
local integer wujunyou33_z15
local player wujunyou33_z05
set wujunyou33_z05=GetTriggerPlayer()
set wujunyou33_z15=GetPlayerId(wujunyou33_z05)
if(wujunyou33_z4)then
if(wujunyou33_z6[wujunyou33_z15])then
set wujunyou33_zzZ[wujunyou33_z15]=true
if(wujunyou33_zZZ[wujunyou33_z15])then
call wujunyou33_z67(wujunyou33_z15,true)
else
if(wujunyou33_Z7[wujunyou33_z15])then
set wujunyou33_Z7[wujunyou33_z15]=false
call wujunyou33_Zz3Z(wujunyou33_z15,2,wujunyou33_zz,true)
else
if((wujunyou33_Z1Z[wujunyou33_z15])and(wujunyou33_Z2Z[wujunyou33_z15]))then
if(wujunyou33_Z0)then
call ForGroup(wujunyou33_Z8Z[wujunyou33_z15],function wujunyou33_zz2Z)
else
call wujunyou33_zz1Z(wujunyou33_z7[wujunyou33_z15])
endif
else
call wujunyou33_zz5(wujunyou33_z05,wujunyou33_zZ,true)
call wujunyou33_z35(wujunyou33_z05,wujunyou33_Zz,true)
endif
endif
endif
endif
else
set wujunyou33_Z5[wujunyou33_z15]=0
endif
set wujunyou33_z05=null
endfunction
function wujunyou33_zz4Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z59Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
call wujunyou33_Z5ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z52Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
set wujunyou33_z13=false
call DoNotSaveReplay()
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_zz5Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_ZZzZ(wujunyou33_z15,wujunyou33_z05)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Zz1Z(wujunyou33_z05)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call SetPlayerStateBJ(wujunyou33_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
if(GetPlayerHandicapBJ(wujunyou33_z05)==200.)then
call SetPlayerHandicapBJ(wujunyou33_z05,100)
else
call SetPlayerHandicapBJ(wujunyou33_z05,200.)
endif
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
if(GetPlayerHandicapXPBJ(wujunyou33_z05)==200.)then
call SetPlayerHandicapXPBJ(wujunyou33_z05,100)
else
call SetPlayerHandicapXPBJ(wujunyou33_z05,200.)
endif
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_zz5(wujunyou33_z05,wujunyou33_Z2,true)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_z35(wujunyou33_z05,wujunyou33_z2,true)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call wujunyou33_zz5(wujunyou33_z05,wujunyou33_Z2,false)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_z35(wujunyou33_z05,wujunyou33_z2,false)
call wujunyou33_Z55Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_zz6Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z40[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z50[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z60[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z80[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z70[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_z90[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z96(wujunyou33_ZZ3[wujunyou33_z15])
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_z16(wujunyou33_z15,true)
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call wujunyou33_z16(wujunyou33_z15,false)
call wujunyou33_Z46Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_zz7Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z24Z(wujunyou33_z15,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1097886070,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z26Z(wujunyou33_z15,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1094937907,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1098150517,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
call wujunyou33_Z29Z(wujunyou33_z15,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if((wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])and((wujunyou33_z9Z)or(wujunyou33_z05==wujunyou33_z5)))then
call wujunyou33_Z3ZZ(wujunyou33_z15,true)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z34Z(wujunyou33_z15)
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_zz8Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095659625,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095066998,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095262824,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095721842,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1096119411,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095656289,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095657827,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095332722,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1094935923,true)
call wujunyou33_Z48Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_zz9Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095262562,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095065960,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095721317,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095065970,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1096114549,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1096114550,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1095262564,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1094934883,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1097818482,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z21Z(wujunyou33_z15,1096905580,true)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z31Z(wujunyou33_z15,false)
call wujunyou33_Z49Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z0ZZ takes nothing returns nothing
local integer wujunyou33_Z75=0
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z05==wujunyou33_z5)and(wujunyou33_z6[wujunyou33_z15]))then
loop
exitwhen wujunyou33_Z75>11
if(wujunyou33_z78==wujunyou33_ZzZ[wujunyou33_Z75])then
if(wujunyou33_z6[wujunyou33_Z75])then
call wujunyou33_z47(wujunyou33_Z75)
else
call wujunyou33_z57(wujunyou33_Z75,Player(wujunyou33_Z75))
endif
call wujunyou33_Z5ZZ(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z0zZ takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local integer wujunyou33_Z75=0
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z05==wujunyou33_z5)and(wujunyou33_z6[wujunyou33_z15]))then
loop
exitwhen wujunyou33_Z75>12
if(wujunyou33_z78==wujunyou33_ZzZ[wujunyou33_Z75])then
set wujunyou33_Z5z=wujunyou33_Z75
call wujunyou33_Z53Z(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z00Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local player wujunyou33_Z65
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z05==wujunyou33_z5)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z57Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
set wujunyou33_Z65=Player(wujunyou33_Z5z)
if(GetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD,wujunyou33_z22)
else
call SetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set wujunyou33_Z65=null
call wujunyou33_Z53Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
set wujunyou33_Z65=Player(wujunyou33_Z5z)
if(GetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER,wujunyou33_z22)
else
call SetPlayerTaxRate(wujunyou33_Z65,wujunyou33_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set wujunyou33_Z65=null
call wujunyou33_Z53Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z52Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z01Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local integer wujunyou33_Z75=wujunyou33_Z5z
local player wujunyou33_Z65=Player(wujunyou33_Z75)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_ZZzZ(wujunyou33_Z75,wujunyou33_Z65)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Zz1Z(wujunyou33_Z65)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call SetPlayerStateBJ(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call SetPlayerStateBJ(wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
if(GetPlayerHandicapBJ(wujunyou33_Z65)==200.)then
call SetPlayerHandicapBJ(wujunyou33_Z65,100)
else
call SetPlayerHandicapBJ(wujunyou33_Z65,200.)
endif
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
if(GetPlayerHandicapXPBJ(wujunyou33_Z65)==200.)then
call SetPlayerHandicapXPBJ(wujunyou33_Z65,100)
else
call SetPlayerHandicapXPBJ(wujunyou33_Z65,200.)
endif
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_zz5(wujunyou33_Z65,wujunyou33_Z2,true)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
call wujunyou33_z35(wujunyou33_Z65,wujunyou33_z2,true)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call wujunyou33_zz5(wujunyou33_Z65,wujunyou33_Z2,false)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_z35(wujunyou33_Z65,wujunyou33_z2,false)
call wujunyou33_Z56Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z53Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z02Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local integer wujunyou33_Z75=wujunyou33_Z5z
local player wujunyou33_Z65=Player(wujunyou33_Z75)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
if(IsPlayerAlly(wujunyou33_Z65,wujunyou33_z05))then
call SetPlayerAllianceStateBJ(wujunyou33_Z65,wujunyou33_z05,0)
else
call SetPlayerAllianceStateBJ(wujunyou33_Z65,wujunyou33_z05,3)
endif
call wujunyou33_Z57Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
if(GetPlayerAlliance(wujunyou33_Z65,wujunyou33_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,wujunyou33_z5)
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_CONTROL,false,wujunyou33_z5)
else
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,wujunyou33_z5)
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_CONTROL,true,wujunyou33_z5)
endif
call wujunyou33_Z57Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
if(GetPlayerAlliance(wujunyou33_Z65,wujunyou33_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_XP,false,wujunyou33_z5)
else
call SetPlayerAllianceBJ(wujunyou33_Z65,ALLIANCE_SHARED_XP,true,wujunyou33_z5)
endif
call wujunyou33_Z57Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
if(IsPlayerAlly(wujunyou33_z05,wujunyou33_Z65))then
call SetPlayerAllianceStateBJ(wujunyou33_z5,wujunyou33_Z65,0)
else
call SetPlayerAllianceStateBJ(wujunyou33_z5,wujunyou33_Z65,2)
endif
call wujunyou33_Z57Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z53Z(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z03Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local integer wujunyou33_Z75
local unit wujunyou33_z65=wujunyou33_z7[wujunyou33_z15]
local player wujunyou33_Z65=GetOwningPlayer(wujunyou33_z65)
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if(wujunyou33_z4)and(wujunyou33_z6[wujunyou33_z15])then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call SetHeroLevelBJ(wujunyou33_z65,GetHeroLevel(wujunyou33_z65)+wujunyou33_Z0Z,false)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call ModifyHeroStat(1,wujunyou33_z65,0,wujunyou33_Z3)
call ModifyHeroStat(0,wujunyou33_z65,0,wujunyou33_Z3)
call ModifyHeroStat(2,wujunyou33_z65,0,wujunyou33_Z3)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_z98(wujunyou33_z15,false)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z77(wujunyou33_z65,wujunyou33_z05,1)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_ZZ3Z(wujunyou33_z65)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
if(wujunyou33_Z5Z)then
if(wujunyou33_Z65!=wujunyou33_z5)then
call UnitShareVisionBJ(true,wujunyou33_z65,wujunyou33_z05)
endif
else
call UnitShareVisionBJ(true,wujunyou33_z65,wujunyou33_z05)
endif
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
call wujunyou33_Z47Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
if(wujunyou33_Z5Z)then
if(wujunyou33_Z65!=wujunyou33_z5)then
call SetUnitOwner(wujunyou33_z65,wujunyou33_z05,true)
endif
else
call SetUnitOwner(wujunyou33_z65,wujunyou33_z05,true)
endif
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
call RemoveUnit(wujunyou33_z65)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z54Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z65=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z04Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z05==wujunyou33_z5)and(wujunyou33_z6[wujunyou33_z15]))then
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
set wujunyou33_Z0=not(wujunyou33_Z0)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z58Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
set wujunyou33_Z5Z=not(wujunyou33_Z5Z)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
set wujunyou33_Z6Z=not(wujunyou33_Z6Z)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
set wujunyou33_Z7Z=not(wujunyou33_Z7Z)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
set wujunyou33_z9Z=not(wujunyou33_z9Z)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z7z[wujunyou33_z15])then
set wujunyou33_ZZz=not(wujunyou33_ZZz)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z6z[wujunyou33_z15])then
set wujunyou33_z7Z=not(wujunyou33_z7Z)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Zz0[wujunyou33_z15])then
set wujunyou33_Z52=not(wujunyou33_Z52)
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_ZZ0[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z05Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
set wujunyou33_z61=1
call wujunyou33_Z58Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
set wujunyou33_z61=2
call wujunyou33_Z58Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
set wujunyou33_z61=3
call wujunyou33_Z58Z(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z51Z(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z06Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
local integer wujunyou33_Z75=0
local player wujunyou33_Z65
local unit wujunyou33_z65=wujunyou33_z7[wujunyou33_z15]
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if((wujunyou33_z4)and(wujunyou33_z05==wujunyou33_z5)and(wujunyou33_z6[wujunyou33_z15]))then
loop
exitwhen wujunyou33_Z75>12
if(wujunyou33_z78==wujunyou33_ZzZ[wujunyou33_Z75])then
set wujunyou33_Z65=Player(wujunyou33_Z75)
call SetUnitOwner(wujunyou33_z7[wujunyou33_z15],wujunyou33_Z65,true)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z50Z(wujunyou33_z15,wujunyou33_z05)
endif
endif
set wujunyou33_z05=null
set wujunyou33_Z65=null
set wujunyou33_z78=null
set wujunyou33_z65=null
endfunction
function wujunyou33_z07Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_z36(wujunyou33_z05)
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
set wujunyou33_z31[wujunyou33_z15]=not(wujunyou33_z31[wujunyou33_z15])
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
set wujunyou33_Z33[wujunyou33_z15]=not(wujunyou33_Z33[wujunyou33_z15])
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z38(wujunyou33_z15,not(wujunyou33_Z53[wujunyou33_z15]))
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
set wujunyou33_Z63[wujunyou33_z15]=not(wujunyou33_Z63[wujunyou33_z15])
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z8z[wujunyou33_z15])then
set wujunyou33_Z43[wujunyou33_z15]=not(wujunyou33_Z43[wujunyou33_z15])
call wujunyou33_Z6ZZ(wujunyou33_z15,wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function wujunyou33_z08Z takes nothing returns nothing
local player wujunyou33_z05=GetTriggerPlayer()
local integer wujunyou33_z15=GetPlayerId(wujunyou33_z05)
local button wujunyou33_z78=GetClickedButton()
call wujunyou33_Z44Z(wujunyou33_z15,wujunyou33_z05,false)
if(wujunyou33_z78==wujunyou33_z2z[wujunyou33_z15])then
call wujunyou33_Z6zZ(wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z4z[wujunyou33_z15])then
call wujunyou33_Z60Z(wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z5z[wujunyou33_z15])then
call wujunyou33_Z61Z(wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z3z[wujunyou33_z15])then
call wujunyou33_Z62Z(wujunyou33_z05)
endif
if(wujunyou33_z78==wujunyou33_z9z[wujunyou33_z15])then
call wujunyou33_Z64Z()
endif
if(wujunyou33_z78==wujunyou33_Z00[wujunyou33_z15])then
call wujunyou33_Z45Z(wujunyou33_z15,wujunyou33_z05)
endif
set wujunyou33_z05=null
set wujunyou33_z78=null
endfunction
function yjYJ takes nothing returns nothing
set HKE_Yj=CreateTrigger()
set HKE_yJ=0
loop
exitwhen HKE_yJ>11
call TriggerRegisterPlayerChatEvent(HKE_Yj,Player(HKE_yJ),"55you",true)
set HKE_yJ=HKE_yJ+1
endloop
call TriggerAddAction(HKE_Yj,function YJYJ)
endfunction
function wujunyou33_z09Z takes nothing returns nothing
local integer wujunyou33_Z75
local player wujunyou33_Z65
local player wujunyou33_z05
set wujunyou33_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(wujunyou33_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(wujunyou33_z73,function wujunyou33_Z9ZZ)
set wujunyou33_Z75=0
loop
exitwhen wujunyou33_Z75>11
set wujunyou33_zz1[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_zz1[wujunyou33_Z75],function wujunyou33_Z79Z)
call DisableTrigger(wujunyou33_zz1[wujunyou33_Z75])
set wujunyou33_Z30[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z30[wujunyou33_Z75],function wujunyou33_Z88Z)
call DisableTrigger(wujunyou33_Z30[wujunyou33_Z75])
set wujunyou33_Z50[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z50[wujunyou33_Z75],function wujunyou33_Z89Z)
call DisableTrigger(wujunyou33_Z50[wujunyou33_Z75])
set wujunyou33_Z40[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z40[wujunyou33_Z75],function wujunyou33_Z91Z)
call DisableTrigger(wujunyou33_Z40[wujunyou33_Z75])
set wujunyou33_Z60[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z60[wujunyou33_Z75],function wujunyou33_Z90Z)
call DisableTrigger(wujunyou33_Z60[wujunyou33_Z75])
set wujunyou33_Z6z[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z6z[wujunyou33_Z75],function wujunyou33_Z9zZ)
call DisableTrigger(wujunyou33_Z6z[wujunyou33_Z75])
set wujunyou33_Z70[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z70[wujunyou33_Z75],function wujunyou33_zZ1Z)
call DisableTrigger(wujunyou33_Z70[wujunyou33_Z75])
set wujunyou33_Z80[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z80[wujunyou33_Z75],function wujunyou33_zZ2Z)
call DisableTrigger(wujunyou33_Z80[wujunyou33_Z75])
set wujunyou33_Z90[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z90[wujunyou33_Z75],function wujunyou33_zZ3Z)
call DisableTrigger(wujunyou33_Z90[wujunyou33_Z75])
set wujunyou33_zZ0[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_zZ0[wujunyou33_Z75],function wujunyou33_zZ4Z)
call DisableTrigger(wujunyou33_zZ0[wujunyou33_Z75])
set wujunyou33_zz0[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_zz0[wujunyou33_Z75],function wujunyou33_zZ5Z)
call DisableTrigger(wujunyou33_zz0[wujunyou33_Z75])
set wujunyou33_z00[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z00[wujunyou33_Z75],function wujunyou33_zZ6Z)
set wujunyou33_z10[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z10[wujunyou33_Z75],function wujunyou33_zZ9Z)
set wujunyou33_z20[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z20[wujunyou33_Z75],function wujunyou33_zz0Z)
set wujunyou33_z30[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z30[wujunyou33_Z75],function wujunyou33_zz3Z)
set wujunyou33_z40[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z40[wujunyou33_Z75],function wujunyou33_Z81Z)
call DisableTrigger(wujunyou33_z40[wujunyou33_Z75])
set wujunyou33_z50[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z50[wujunyou33_Z75],function wujunyou33_Z82Z)
call DisableTrigger(wujunyou33_z50[wujunyou33_Z75])
set wujunyou33_z60[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z60[wujunyou33_Z75],function wujunyou33_Z83Z)
call DisableTrigger(wujunyou33_z60[wujunyou33_Z75])
set wujunyou33_z70[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z70[wujunyou33_Z75],function wujunyou33_Z84Z)
call DisableTrigger(wujunyou33_z70[wujunyou33_Z75])
set wujunyou33_z80[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z80[wujunyou33_Z75],function wujunyou33_Z85Z)
call DisableTrigger(wujunyou33_z80[wujunyou33_Z75])
set wujunyou33_z90[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z90[wujunyou33_Z75],function wujunyou33_Z86Z)
call DisableTrigger(wujunyou33_z90[wujunyou33_Z75])
set wujunyou33_ZZ3[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_ZZ3[wujunyou33_Z75],function wujunyou33_Z87Z)
call DisableTrigger(wujunyou33_ZZ3[wujunyou33_Z75])
set wujunyou33_ZZ1[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_ZZ1[wujunyou33_Z75],function wujunyou33_zz4Z)
set wujunyou33_Zz2[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Zz2[wujunyou33_Z75],function wujunyou33_zz5Z)
set wujunyou33_Zz1[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Zz1[wujunyou33_Z75],function wujunyou33_zz6Z)
set wujunyou33_Z01[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z01[wujunyou33_Z75],function wujunyou33_zz7Z)
set wujunyou33_Z81[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z81[wujunyou33_Z75],function wujunyou33_zz8Z)
set wujunyou33_Z21[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z21[wujunyou33_Z75],function wujunyou33_zz9Z)
set wujunyou33_Z51[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z51[wujunyou33_Z75],function wujunyou33_z0ZZ)
set wujunyou33_Z41[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z41[wujunyou33_Z75],function wujunyou33_z0zZ)
set wujunyou33_Z61[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z61[wujunyou33_Z75],function wujunyou33_z00Z)
set wujunyou33_Z12[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z12[wujunyou33_Z75],function wujunyou33_z02Z)
set wujunyou33_Z02[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z02[wujunyou33_Z75],function wujunyou33_z01Z)
set wujunyou33_Z71[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z71[wujunyou33_Z75],function wujunyou33_z03Z)
set wujunyou33_Z31[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z31[wujunyou33_Z75],function wujunyou33_z04Z)
set wujunyou33_Z22[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z22[wujunyou33_Z75],function wujunyou33_z05Z)
set wujunyou33_Z11[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z11[wujunyou33_Z75],function wujunyou33_z06Z)
set wujunyou33_Z23[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z23[wujunyou33_Z75],function wujunyou33_z08Z)
set wujunyou33_Z13[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_Z13[wujunyou33_Z75],function wujunyou33_z07Z)
call DisableTrigger(wujunyou33_ZZ1[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Zz1[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Zz2[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z01[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z81[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z21[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z51[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z41[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z61[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z12[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z02[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z71[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z31[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z22[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z11[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z23[wujunyou33_Z75])
call DisableTrigger(wujunyou33_Z13[wujunyou33_Z75])
set wujunyou33_z01[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z01[wujunyou33_Z75],function wujunyou33_Z95Z)
set wujunyou33_z11[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z11[wujunyou33_Z75],function wujunyou33_Z98Z)
set wujunyou33_z21[wujunyou33_Z75]=CreateTrigger()
call TriggerAddAction(wujunyou33_z21[wujunyou33_Z75],function wujunyou33_zZZZ)
call DisableTrigger(wujunyou33_z01[wujunyou33_Z75])
call DisableTrigger(wujunyou33_z11[wujunyou33_Z75])
call DisableTrigger(wujunyou33_z21[wujunyou33_Z75])
set wujunyou33_Z65=Player(wujunyou33_Z75)
if((GetPlayerController(wujunyou33_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(wujunyou33_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set wujunyou33_Z8Z[wujunyou33_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(wujunyou33_z63,wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(wujunyou33_z10[wujunyou33_Z75],wujunyou33_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(wujunyou33_z00[wujunyou33_Z75],wujunyou33_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(wujunyou33_z20[wujunyou33_Z75],wujunyou33_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(wujunyou33_z30[wujunyou33_Z75],wujunyou33_Z65,0,1)
call TriggerRegisterPlayerChatEvent(wujunyou33_z53,wujunyou33_Z65,SubStringBJ(wujunyou33_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(wujunyou33_z63,wujunyou33_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set wujunyou33_Z9Z[wujunyou33_Z75]=GetPlayerStartLocationLoc(wujunyou33_Z65)
endif
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call DisableTrigger(wujunyou33_z73)
set wujunyou33_z8Z=CreateGroup()
set wujunyou33_z8=GetWorldBounds()
set wujunyou33_z2Z[0]=30.
set wujunyou33_z2Z[1]=60.
set wujunyou33_z2Z[2]=90.
set wujunyou33_z3Z[0]=50.
set wujunyou33_z3Z[1]=72.
set wujunyou33_z3Z[2]=95.
set wujunyou33_Z75=0
loop
exitwhen wujunyou33_Z75>20
set wujunyou33_z02[wujunyou33_Z75]=null
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z75=0
loop
exitwhen(wujunyou33_Z75>12)
set wujunyou33_Z5[wujunyou33_Z75]=0
set wujunyou33_z6[wujunyou33_Z75]=false
set wujunyou33_Z7[wujunyou33_Z75]=false
set wujunyou33_Z8[wujunyou33_Z75]=0
set wujunyou33_Z1Z[wujunyou33_Z75]=false
set wujunyou33_Z2Z[wujunyou33_Z75]=false
set wujunyou33_Z3Z[wujunyou33_Z75]=CreateTimer()
set wujunyou33_Z8Z[wujunyou33_Z75]=CreateGroup()
set wujunyou33_zZZ[wujunyou33_Z75]=false
set wujunyou33_zzZ[wujunyou33_Z75]=false
set wujunyou33_z0Z[wujunyou33_Z75]=CreateTimer()
set wujunyou33_z1Z[wujunyou33_Z75]=false
set wujunyou33_Z3z[wujunyou33_Z75]=false
set wujunyou33_Z4z[wujunyou33_Z75]=0
set wujunyou33_Z20[wujunyou33_Z75]=DialogCreate()
set wujunyou33_Z91[wujunyou33_Z75]=DialogCreate()
set wujunyou33_zZ1[wujunyou33_Z75]=DialogCreate()
set wujunyou33_z31[wujunyou33_Z75]=false
set wujunyou33_Z32[wujunyou33_Z75]=0
set wujunyou33_Z42[wujunyou33_Z75]=false
set wujunyou33_Zz3[wujunyou33_Z75]=DialogCreate()
set wujunyou33_Z33[wujunyou33_Z75]=false
set wujunyou33_Z43[wujunyou33_Z75]=true
set wujunyou33_Z53[wujunyou33_Z75]=false
set wujunyou33_Z63[wujunyou33_Z75]=false
set wujunyou33_Z73[wujunyou33_Z75]=CreateTimer()
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z75=0
loop
exitwhen(wujunyou33_Z75>3)
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
set wujunyou33_Z75=0
loop
exitwhen(wujunyou33_Z75>21)
set wujunyou33_z12[wujunyou33_Z75]=false
set wujunyou33_Z75=wujunyou33_Z75+1
endloop
call TriggerRegisterTimerEvent(wujunyou33_z23,.01,false)
call TriggerAddAction(wujunyou33_z23,function wujunyou33_Z7zZ)
call TriggerAddAction(wujunyou33_z33,function wujunyou33_Z70Z)
call TriggerAddAction(wujunyou33_z43,function wujunyou33_Z74Z)
call TriggerAddAction(wujunyou33_z53,function wujunyou33_Z8zZ)
call TriggerAddAction(wujunyou33_z63,function wujunyou33_Z80Z)
call TriggerRegisterAnyUnitEventBJ(wujunyou33_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(wujunyou33_z73,function wujunyou33_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(wujunyou33_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(wujunyou33_z83,function wujunyou33_Z93Z)
call DisableTrigger(wujunyou33_z83)
call wujunyou33_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set wujunyou33_Z65=null
call yjYJ()
endfunction
