function LPT_Z64 takes real LPT_Z74,location LPT_Z84 returns group
set LPT_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(LPT_Z14,LPT_Z84,LPT_Z74,LPT_Z34)
return LPT_Z14
endfunction
function LPT_Z94 takes player LPT_zZ4 returns group
set LPT_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(LPT_Z14,LPT_zZ4,LPT_Z34)
return LPT_Z14
endfunction
function LPT_zz4 takes player LPT_zZ4,integer LPT_z04 returns group
set LPT_Z14=CreateGroup()
set bj_groupEnumTypeId=LPT_z04
call GroupEnumUnitsOfPlayer(LPT_Z14,LPT_zZ4,filterGetUnitsOfPlayerAndTypeId)
return LPT_Z14
endfunction
function LPT_z14 takes player LPT_zZ4 returns force
set LPT_Z24=CreateForce()
call ForceEnumAllies(LPT_Z24,LPT_zZ4,LPT_Z34)
return LPT_Z24
endfunction
function LPT_z24 takes player LPT_zZ4 returns force
set LPT_Z24=CreateForce()
call ForceEnumEnemies(LPT_Z24,LPT_zZ4,LPT_Z34)
return LPT_Z24
endfunction
function LPT_Z45 takes trigger LPT_Z55,player LPT_Z65,integer LPT_Z75 returns nothing
local playerevent LPT_Z85=ConvertPlayerEvent(LPT_Z75)
call TriggerRegisterPlayerEvent(LPT_Z55,LPT_Z65,LPT_Z85)
set LPT_Z85=null
endfunction
function LPT_Z95 takes trigger LPT_Z55,player LPT_Z65,integer LPT_Z75 returns nothing
local playerunitevent LPT_Z85=ConvertPlayerUnitEvent(LPT_Z75)
call TriggerRegisterPlayerUnitEvent(LPT_Z55,LPT_Z65,LPT_Z85,null)
set LPT_Z85=null
endfunction
function LPT_zZ5 takes integer LPT_Z75,player LPT_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(LPT_Z30[LPT_Z75],LPT_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(LPT_Z50[LPT_Z75],LPT_Z65,ConvertPlayerUnitEvent(25),null)
call LPT_Z45(LPT_Z70[LPT_Z75],LPT_Z65,17)
call LPT_Z45(LPT_Z90[LPT_Z75],LPT_Z65,266)
call LPT_Z45(LPT_Z80[LPT_Z75],LPT_Z65,268)
call LPT_Z45(LPT_zZ0[LPT_Z75],LPT_Z65,262)
call LPT_Z45(LPT_zz0[LPT_Z75],LPT_Z65,264)
call TriggerRegisterTimerExpireEvent(LPT_z43,LPT_z0Z[LPT_Z75])
call TriggerRegisterTimerExpireEvent(LPT_z33,LPT_Z73[LPT_Z75])
call LPT_Z95(LPT_Z40[LPT_Z75],LPT_Z65,32)
call LPT_Z95(LPT_Z60[LPT_Z75],LPT_Z65,35)
call TriggerRegisterDialogEvent(LPT_ZZ1[LPT_Z75],LPT_zZ1[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Zz2[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Zz1[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z01[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z81[LPT_Z75],LPT_Z91[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z71[LPT_Z75],LPT_zZ1[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z21[LPT_Z75],LPT_Z91[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z31[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z22[LPT_Z75],LPT_Z91[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z11[LPT_Z75],LPT_Z91[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z51[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z41[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z61[LPT_Z75],LPT_Z91[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z12[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z02[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z23[LPT_Z75],LPT_Z20[LPT_Z75])
call TriggerRegisterDialogEvent(LPT_Z13[LPT_Z75],LPT_Z20[LPT_Z75])
call LPT_Z95(LPT_z01[LPT_Z75],LPT_Z65,38)
call LPT_Z95(LPT_z11[LPT_Z75],LPT_Z65,39)
call LPT_Z95(LPT_z21[LPT_Z75],LPT_Z65,40)
call LPT_Z95(LPT_z80[LPT_Z75],LPT_Z65,276)
call LPT_Z95(LPT_z80[LPT_Z75],LPT_Z65,275)
call LPT_Z95(LPT_z90[LPT_Z75],LPT_Z65,276)
call LPT_Z95(LPT_z90[LPT_Z75],LPT_Z65,275)
call LPT_Z95(LPT_ZZ3[LPT_Z75],LPT_Z65,18)
call TriggerRegisterPlayerStateEvent(LPT_z60[LPT_Z75],LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(LPT_z40[LPT_Z75],LPT_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(LPT_z50[LPT_Z75],LPT_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call LPT_Z95(LPT_z70[LPT_Z75],LPT_Z65,20)
call TriggerRegisterPlayerChatEvent(LPT_zz1[LPT_Z75],LPT_Z65,"-",false)
call LPT_Z95(LPT_Z6z[LPT_Z75],LPT_Z65,39)
set LPT_Z3z[LPT_Z75]=true
endfunction
function LPT_zz5 takes player LPT_z05,integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_z25)then
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_GOLD)+LPT_z15)
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(LPT_z05,PLAYER_STATE_GOLD_GATHERED)-LPT_z15)
else
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_GOLD)-LPT_z15)
endif
endfunction
function LPT_z35 takes player LPT_z05,integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_z25)then
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)+LPT_z15)
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(LPT_z05,PLAYER_STATE_LUMBER_GATHERED)-LPT_z15)
else
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)-LPT_z15)
endif
endfunction
function LPT_z45 takes player LPT_z05 returns nothing
local player LPT_Z65=GetLocalPlayer()
if LPT_z05==LPT_Z65 then
set LPT_Z65=Player(-1)
endif
set LPT_Z65=null
endfunction
function LPT_z55 takes unit LPT_z65,unit LPT_z75,boolean LPT_z85 returns nothing
local location LPT_z95
local location LPT_ZZ6
set LPT_z95=GetUnitLoc(LPT_z65)
set LPT_ZZ6=GetUnitLoc(LPT_z75)
call SetUnitPositionLoc(LPT_z65,LPT_ZZ6)
if(LPT_z85)then
call SetUnitPositionLoc(LPT_z75,LPT_z95)
call SetUnitPositionLoc(LPT_z65,LPT_ZZ6)
endif
call RemoveLocation(LPT_z95)
call RemoveLocation(LPT_ZZ6)
set LPT_z95=null
set LPT_ZZ6=null
endfunction
function LPT_Zz6 takes integer LPT_Z06 returns nothing
if(LPT_Z06==0)then
set LPT_zZ2=100
set LPT_Z92=100
set LPT_Z82=100
set LPT_Z72="|cFFFFFFFF"
return
endif
if(LPT_Z06==1)then
set LPT_zZ2=50
set LPT_Z92=50
set LPT_Z82=50
set LPT_Z72="|cFF7F7F7F"
return
endif
if(LPT_Z06==2)then
set LPT_zZ2=0
set LPT_Z92=0
set LPT_Z82=0
set LPT_Z72="|cFF000000"
return
endif
if(LPT_Z06==3)then
set LPT_zZ2=100
set LPT_Z92=0
set LPT_Z82=0
set LPT_Z72="|cFFFF0000"
return
endif
if(LPT_Z06==4)then
set LPT_zZ2=100
set LPT_Z92=50
set LPT_Z82=0
set LPT_Z72="|cFFFF7F00"
return
endif
if(LPT_Z06==5)then
set LPT_zZ2=100
set LPT_Z92=100
set LPT_Z82=0
set LPT_Z72="|cFFFFFF00"
return
endif
if(LPT_Z06==6)then
set LPT_zZ2=0
set LPT_Z92=100
set LPT_Z82=0
set LPT_Z72="|cFF00FF00"
return
endif
if(LPT_Z06==7)then
set LPT_zZ2=0
set LPT_Z92=100
set LPT_Z82=100
set LPT_Z72="|cFF00FFFF"
return
endif
if(LPT_Z06==8)then
set LPT_zZ2=0
set LPT_Z92=0
set LPT_Z82=100
set LPT_Z72="|cFF0000FF"
return
endif
if(LPT_Z06==9)then
set LPT_zZ2=100
set LPT_Z92=0
set LPT_Z82=100
set LPT_Z72="|cFFFF00FF"
return
endif
endfunction
function LPT_Z16 takes integer LPT_Z06,unit LPT_Z26,string LPT_Z36 returns nothing
local texttag LPT_Z46
local location LPT_z95
call LPT_Zz6(LPT_Z06)
set LPT_z95=GetUnitLoc(LPT_Z26)
set LPT_Z46=CreateTextTagLocBJ(LPT_Z36,LPT_z95,0,20,LPT_zZ2,LPT_Z92,LPT_Z82,0)
call RemoveLocation(LPT_z95)
set LPT_z95=null
call SetTextTagPermanent(LPT_Z46,false)
call SetTextTagLifespan(LPT_Z46,LPT_Z1)
set LPT_Z46=null
endfunction
function LPT_Z56 takes nothing returns nothing
local trigger LPT_Z66=GetTriggeringTrigger()
local timer LPT_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(LPT_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(LPT_z52)
call DestroyTimerDialog(LPT_z82)
call DestroyTimer(LPT_Z76)
set LPT_Z66=null
set LPT_Z76=null
endfunction
function LPT_Z86 takes nothing returns nothing
local timer LPT_Z76
local trigger LPT_Z66
if(LPT_z62)then
else
set LPT_z52=GetGameSpeed()
set LPT_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set LPT_Z66=CreateTrigger()
set LPT_Z76=CreateTimer()
call StartTimerBJ(LPT_Z76,false,LPT_z42)
set LPT_z82=CreateTimerDialogBJ(LPT_Z76,"子弹时间")
call TriggerAddAction(LPT_Z66,function LPT_Z56)
call TriggerRegisterTimerExpireEvent(LPT_Z66,LPT_Z76)
endif
endfunction
function LPT_Z96 takes trigger LPT_zZ6 returns nothing
if(IsTriggerEnabled(LPT_zZ6))then
call DisableTrigger(LPT_zZ6)
else
call EnableTrigger(LPT_zZ6)
endif
endfunction
function LPT_zz6 takes trigger LPT_zZ6,boolean LPT_z06 returns nothing
if(IsTriggerEnabled(LPT_zZ6)==LPT_z06)then
else
call LPT_Z96(LPT_zZ6)
endif
endfunction
function LPT_z16 takes integer LPT_z15,boolean LPT_z25 returns nothing
call LPT_zz6(LPT_z40[LPT_z15],LPT_z25)
call LPT_zz6(LPT_z50[LPT_z15],LPT_z25)
call LPT_zz6(LPT_z60[LPT_z15],LPT_z25)
call LPT_zz6(LPT_z80[LPT_z15],LPT_z25)
call LPT_zz6(LPT_z70[LPT_z15],LPT_z25)
call LPT_zz6(LPT_z90[LPT_z15],LPT_z25)
call LPT_zz6(LPT_ZZ3[LPT_z15],LPT_z25)
endfunction
function LPT_z26 takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
if(GetUnitUserData(LPT_z65)==2176)then
call RemoveUnit(LPT_z65)
endif
set LPT_z65=null
endfunction
function LPT_z36 takes player LPT_z05 returns nothing
local group LPT_z46
if(LPT_Z42[GetPlayerId(LPT_z05)])then
set LPT_z46=LPT_Z94(LPT_z05)
call ForGroup(LPT_z46,function LPT_z26)
set LPT_Z42[GetPlayerId(LPT_z05)]=false
call DestroyGroup(LPT_z46)
set LPT_z46=null
endif
endfunction
function LPT_z56 takes unit LPT_z65,player LPT_z05 returns nothing
local location LPT_z95
local integer LPT_z66
local unit LPT_z76
local item LPT_z86
local integer LPT_Z75=0
if(IsUnitType(LPT_z65,UNIT_TYPE_HERO))then
set LPT_z95=GetUnitLoc(LPT_z65)
set LPT_z66=GetUnitTypeId(LPT_z65)
set LPT_z76=CreateUnitAtLoc(LPT_z05,LPT_z66,LPT_z95,bj_UNIT_FACING)
call SetUnitUserData(LPT_z76,2176)
set LPT_Z42[GetPlayerId(LPT_z05)]=true
if(LPT_Z6Z)then
call SetUnitUseFood(LPT_z76,false)
endif
call SetHeroLevelBJ(LPT_z76,GetHeroLevel(LPT_z65),false)
call SetHeroStat(LPT_z76,0,GetHeroStatBJ(0,LPT_z65,false))
call SetHeroStat(LPT_z76,1,GetHeroStatBJ(1,LPT_z65,false))
call SetHeroStat(LPT_z76,2,GetHeroStatBJ(2,LPT_z65,false))
loop
exitwhen LPT_Z75>5
set LPT_z86=UnitItemInSlot(LPT_z65,LPT_Z75)
call UnitAddItemById(LPT_z76,GetItemTypeId(LPT_z86))
set LPT_Z75=LPT_Z75+1
endloop
endif
call RemoveLocation(LPT_z95)
set LPT_z95=null
set LPT_z76=null
set LPT_z86=null
endfunction
function LPT_z96 takes integer LPT_ZZ7,player LPT_Zz7,location LPT_Z07,boolean LPT_Z17,boolean LPT_Z27 returns nothing
local unit LPT_z76
set LPT_z76=CreateUnitAtLoc(LPT_Zz7,LPT_ZZ7,LPT_Z07,bj_UNIT_FACING)
if(LPT_Z6Z)then
call SetUnitUseFood(LPT_z76,false)
endif
if(LPT_Z17)then
call SetUnitUserData(LPT_z76,2176)
endif
if(LPT_Z27)then
call UnitApplyTimedLife(LPT_z76,1112820806,90)
endif
set LPT_z76=null
endfunction
function LPT_Z37 takes integer LPT_ZZ7,player LPT_Zz7,location LPT_Z07 returns nothing
local unit LPT_z76
set LPT_z76=CreateUnitAtLoc(LPT_Zz7,LPT_ZZ7,LPT_Z07,bj_UNIT_FACING)
if(LPT_Z6Z)then
call SetUnitUseFood(LPT_z76,false)
set LPT_z76=null
endif
endfunction
function LPT_Z47 takes unit LPT_Z57,player LPT_Zz7,integer LPT_Z67,boolean LPT_Z27 returns nothing
local location LPT_z95
local integer LPT_z66
local integer LPT_Z75
set LPT_z95=GetUnitLoc(LPT_Z57)
set LPT_z66=GetUnitTypeId(LPT_Z57)
set LPT_Z75=1
loop
exitwhen LPT_Z75>LPT_Z67
call LPT_z96(LPT_z66,LPT_Zz7,LPT_z95,true,LPT_Z27)
set LPT_Z75=LPT_Z75+1
endloop
call RemoveLocation(LPT_z95)
set LPT_Z42[GetPlayerId(LPT_Zz7)]=true
set LPT_z95=null
endfunction
function LPT_Z77 takes unit LPT_Z57,player LPT_Zz7,integer LPT_Z67 returns nothing
call LPT_Z47(LPT_Z57,LPT_Zz7,LPT_Z67,false)
endfunction
function LPT_Z87 takes unit LPT_z65,integer LPT_z15,boolean LPT_Z97 returns nothing
local integer LPT_Z75
set LPT_Z75=GetResourceAmount(LPT_z65)
if(LPT_Z97)then
set LPT_Z75=LPT_Z75+LPT_z15
else
set LPT_Z75=LPT_Z75-LPT_z15
endif
if(LPT_Z75<0)then
if(LPT_Z97)then
set LPT_Z75=GetResourceAmount(LPT_z65)
else
set LPT_Z75=0
endif
endif
call SetResourceAmount(LPT_z65,LPT_Z75)
endfunction
function LPT_zZ7 takes integer LPT_z15,player LPT_z05,boolean LPT_zz7 returns nothing
if(LPT_zz7)then
call SetPlayerTechMaxAllowed(LPT_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(LPT_z05,1212502607,3)
endif
endfunction
function LPT_z07 takes integer LPT_z15,boolean LPT_z06 returns nothing
if(LPT_z06)then
call EnableTrigger(LPT_z00[LPT_z15])
call EnableTrigger(LPT_z10[LPT_z15])
call EnableTrigger(LPT_z20[LPT_z15])
call EnableTrigger(LPT_z30[LPT_z15])
call EnableTrigger(LPT_Z70[LPT_z15])
call EnableTrigger(LPT_Z80[LPT_z15])
call EnableTrigger(LPT_Z90[LPT_z15])
call EnableTrigger(LPT_zZ0[LPT_z15])
call EnableTrigger(LPT_zz0[LPT_z15])
else
call DisableTrigger(LPT_Yj)	
call DisableTrigger(LPT_z00[LPT_z15])
call DisableTrigger(LPT_z10[LPT_z15])
call DisableTrigger(LPT_z20[LPT_z15])
call DisableTrigger(LPT_z30[LPT_z15])
call DisableTrigger(LPT_Z70[LPT_z15])
call DisableTrigger(LPT_Z80[LPT_z15])
call DisableTrigger(LPT_Z90[LPT_z15])
call DisableTrigger(LPT_zZ0[LPT_z15])
call DisableTrigger(LPT_zz0[LPT_z15])
endif
endfunction
function LPT_z17 takes integer LPT_z15,boolean LPT_z27 returns nothing
if(LPT_z27)then
call EnableTrigger(LPT_Z40[LPT_z15])
call EnableTrigger(LPT_Z60[LPT_z15])
call EnableTrigger(LPT_Z6z[LPT_z15])
else
call DisableTrigger(LPT_Z40[LPT_z15])
call DisableTrigger(LPT_Z60[LPT_z15])
call DisableTrigger(LPT_Z6z[LPT_z15])
endif
endfunction
function LPT_z37 takes nothing returns nothing
local integer LPT_z15
set LPT_z15=0
loop
exitwhen LPT_z15>11
call LPT_z07(LPT_z15,false)
set LPT_z15=LPT_z15+1
endloop
endfunction
function LPT_z47 takes integer LPT_z15 returns nothing
set LPT_z6[LPT_z15]=false
call GroupClear(LPT_Z8Z[LPT_z15])
if(LPT_Z7Z)then
call DestroyFogModifier(LPT_Z6[LPT_z15])
endif
call DisableTrigger(LPT_Z30[LPT_z15])
call DisableTrigger(LPT_Z50[LPT_z15])
call DisableTrigger(LPT_zz1[LPT_z15])
call DisableTrigger(LPT_z40[LPT_z15])
call DisableTrigger(LPT_z50[LPT_z15])
call DisableTrigger(LPT_z60[LPT_z15])
call DisableTrigger(LPT_z70[LPT_z15])
call DisableTrigger(LPT_z80[LPT_z15])
call DisableTrigger(LPT_z90[LPT_z15])
call DisableTrigger(LPT_ZZ3[LPT_z15])
call DisableTrigger(LPT_ZZ1[LPT_z15])
call DisableTrigger(LPT_Zz1[LPT_z15])
call DisableTrigger(LPT_Zz2[LPT_z15])
call DisableTrigger(LPT_Z01[LPT_z15])
call DisableTrigger(LPT_Z81[LPT_z15])
call DisableTrigger(LPT_Z21[LPT_z15])
call DisableTrigger(LPT_Z51[LPT_z15])
call DisableTrigger(LPT_Z41[LPT_z15])
call DisableTrigger(LPT_Z61[LPT_z15])
call DisableTrigger(LPT_Z12[LPT_z15])
call DisableTrigger(LPT_Z02[LPT_z15])
call DisableTrigger(LPT_Z71[LPT_z15])
call DisableTrigger(LPT_Z31[LPT_z15])
call DisableTrigger(LPT_Z22[LPT_z15])
call DisableTrigger(LPT_Z11[LPT_z15])
call DisableTrigger(LPT_Z23[LPT_z15])
call DisableTrigger(LPT_Z13[LPT_z15])
call DisableTrigger(LPT_zZ3[LPT_z15])
call DisableTrigger(LPT_Z40[LPT_z15])
call DisableTrigger(LPT_Z60[LPT_z15])
call DisableTrigger(LPT_Z6z[LPT_z15])
call LPT_z07(LPT_z15,false)
endfunction
function LPT_z57 takes integer LPT_z15,player LPT_z05 returns nothing
set LPT_z6[LPT_z15]=true
if(LPT_Z3z[LPT_z15])then
else
call LPT_zZ5(LPT_z15,LPT_z05)
endif
call EnableTrigger(LPT_Z30[LPT_z15])
call EnableTrigger(LPT_Z50[LPT_z15])
call EnableTrigger(LPT_zz1[LPT_z15])
call LPT_z07(LPT_z15,true)
endfunction
function LPT_z67 takes integer LPT_z15,boolean LPT_z77 returns nothing
if(LPT_z77)then
if((LPT_zZZ[LPT_z15])and(LPT_zzZ[LPT_z15])and(LPT_z31[LPT_z15]))then
call EnableTrigger(LPT_z01[LPT_z15])
call EnableTrigger(LPT_z11[LPT_z15])
call EnableTrigger(LPT_z21[LPT_z15])
endif
else
call DisableTrigger(LPT_z01[LPT_z15])
call DisableTrigger(LPT_z11[LPT_z15])
call DisableTrigger(LPT_z21[LPT_z15])
endif
endfunction
function LPT_z87 takes integer LPT_Z06 returns nothing
if(LPT_Z06==0)then
set LPT_zz2=0
return
endif
if(LPT_Z06==1)then
set LPT_zz2=10
return
endif
if(LPT_Z06==2)then
set LPT_zz2=15
return
endif
if(LPT_Z06==3)then
set LPT_zz2=20
return
endif
if(LPT_Z06==4)then
set LPT_zz2=40
return
endif
if(LPT_Z06==5)then
set LPT_zz2=50
return
endif
if(LPT_Z06==6)then
set LPT_zz2=70
return
endif
if(LPT_Z06==7)then
set LPT_zz2=80
return
endif
if(LPT_Z06==8)then
set LPT_zz2=90
return
endif
if(LPT_Z06==9)then
set LPT_zz2=100
return
endif
endfunction
function LPT_z97 takes unit LPT_z65,integer LPT_ZZ8,integer LPT_Zz8 returns nothing
call LPT_z87(LPT_Zz8)
call LPT_Zz6(LPT_ZZ8)
call SetUnitVertexColorBJ(LPT_z65,LPT_zZ2,LPT_Z92,LPT_Z82,LPT_zz2)
endfunction
function LPT_Z08 takes integer LPT_ZZ8,integer LPT_Zz8 returns nothing
call LPT_z87(LPT_Zz8)
call LPT_Zz6(LPT_ZZ8)
call SetWaterBaseColorBJ(LPT_zZ2,LPT_Z92,LPT_Z82,LPT_zz2)
endfunction
function LPT_Z18 takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call LPT_z97(LPT_z65,GetRandomInt(3,9),0)
set LPT_z65=null
endfunction
function LPT_Z28 takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call LPT_z97(LPT_z65,0,0)
set LPT_z65=null
endfunction
function LPT_Z38 takes integer LPT_z15,boolean LPT_z77 returns nothing
local integer LPT_Z75
local integer LPT_Z48
if(LPT_Z53[LPT_z15]==LPT_z77)then
else
set LPT_Z53[LPT_z15]=LPT_z77
if(LPT_z77)then
call EnableTrigger(LPT_z83)
else
set LPT_Z75=0
set LPT_Z48=0
loop
exitwhen LPT_Z75>11
if(LPT_Z53[LPT_Z75])then
set LPT_Z48=LPT_Z48+1
endif
set LPT_Z75=LPT_Z75+1
endloop
if(LPT_Z48==0)then
call DisableTrigger(LPT_z83)
endif
endif
endif
endfunction
function LPT_Z58 takes integer LPT_Z68 returns nothing
if(LPT_Z68==0)then
call SetSkyModel(null)
return
endif
if(LPT_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(LPT_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(LPT_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(LPT_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(LPT_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(LPT_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(LPT_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(LPT_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(LPT_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(LPT_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(LPT_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(LPT_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(LPT_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function LPT_Z78 takes integer LPT_Z88 returns integer
if(LPT_Z88==0)then
return 1380018290
endif
if(LPT_Z88==1)then
return 1380019314
endif
if(LPT_Z88==2)then
return 1296393331
endif
if(LPT_Z88==3)then
return 1178886760
endif
if(LPT_Z88==4)then
return 1178886764
endif
if(LPT_Z88==5)then
return 1178888040
endif
if(LPT_Z88==6)then
return 1178888044
endif
if(LPT_Z88==7)then
return 1178890856
endif
if(LPT_Z88==8)then
return 1178890860
endif
if(LPT_Z88==9)then
return 1178892136
endif
if(LPT_Z88==10)then
return 1178892140
endif
if(LPT_Z88==11)then
return 1380739186
endif
if(LPT_Z88==12)then
return 1380740210
endif
if(LPT_Z88==13)then
return 1397645939
endif
if(LPT_Z88==14)then
return 1397647475
endif
if(LPT_Z88==15)then
return 1397648499
endif
if(LPT_Z88==16)then
return 1464820599
endif
if(LPT_Z88==17)then
return 1464822903
endif
if(LPT_Z88==18)then
return 1280467297
endif
if(LPT_Z88==19)then
return 1280470369
endif
if(LPT_Z88==20)then
return 1464755063
endif
return 0
endfunction
function LPT_Z98 takes integer LPT_Z88,boolean LPT_z77 returns nothing
set LPT_Z88=LPT_Z88-1
if(LPT_z77)then
if(LPT_z12[LPT_Z88]==false)then
if(LPT_Z78(LPT_Z88)==0)then
else
set LPT_z02[LPT_Z88]=AddWeatherEffect(LPT_z8,LPT_Z78(LPT_Z88))
call EnableWeatherEffect(LPT_z02[LPT_Z88],true)
set LPT_z12[LPT_Z88]=true
endif
endif
else
if(LPT_z02[LPT_Z88]==null)then
else
call EnableWeatherEffect(LPT_z02[LPT_Z88],false)
call RemoveWeatherEffect(LPT_z02[LPT_Z88])
set LPT_z12[LPT_Z88]=false
set LPT_z02[LPT_Z88]=null
endif
endif
endfunction
function LPT_zZ8 takes nothing returns nothing
local integer LPT_z15=1
loop
exitwhen LPT_z15>21
call LPT_Z98(LPT_z15,false)
set LPT_z15=LPT_z15+1
endloop
endfunction
function LPT_zz8 takes integer LPT_z08 returns integer
if(LPT_z08==0)then
return 1280601204
endif
if(LPT_z08==1)then
return 1179939959
endif
if(LPT_z08==2)then
return 1465152631
endif
if(LPT_z08==3)then
return 1096053874
endif
if(LPT_z08==4)then
return 1096053859
endif
if(LPT_z08==5)then
return 1112831095
endif
if(LPT_z08==6)then
return 1263826039
endif
if(LPT_z08==7)then
return 1498707828
endif
if(LPT_z08==8)then
return 1498702708
endif
if(LPT_z08==9)then
return 1498703476
endif
if(LPT_z08==10)then
return 1498706804
endif
if(LPT_z08==11)then
return 1247044468
endif
if(LPT_z08==12)then
return 1247048823
endif
if(LPT_z08==13)then
return 1146385256
endif
if(LPT_z08==14)then
return 1129608306
endif
if(LPT_z08==15)then
return 1129608291
endif
if(LPT_z08==16)then
return 1230271607
endif
if(LPT_z08==17)then
return 1230271607
endif
if(LPT_z08==18)then
return 1314157667
endif
if(LPT_z08==19)then
return 1330934903
endif
if(LPT_z08==20)then
return 1515484279
endif
if(LPT_z08==21)then
return 1196716904
endif
if(LPT_z08==22)then
return 1448373364
endif
if(LPT_z08==23)then
return 1448373364
endif
return 0
endfunction
function LPT_z18 takes nothing returns integer
return LPT_zz8(GetRandomInt(0,23))
endfunction
function LPT_z28 takes unit LPT_z65,integer LPT_z38,integer LPT_z08,integer LPT_z48 returns nothing
local real LPT_z58
local real LPT_z68
local real LPT_z15=0
local boolean LPT_z78=true
set LPT_z58=GetUnitX(LPT_z65)
set LPT_z68=GetUnitY(LPT_z65)
if(LPT_z38==1)then
loop
exitwhen LPT_z15==LPT_z48
if(LPT_z78)then
call CreateDestructable(LPT_z08,LPT_z58,LPT_z68+LPT_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(LPT_z08,LPT_z58,LPT_z68-LPT_z15*40,GetRandomReal(0,360),1,0)
endif
set LPT_z78=not(LPT_z78)
set LPT_z15=LPT_z15+1
endloop
endif
if(LPT_z38==2)then
loop
exitwhen LPT_z15==LPT_z48
if(LPT_z78)then
call CreateDestructable(LPT_z08,LPT_z58+LPT_z15*40,LPT_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(LPT_z08,LPT_z58-LPT_z15*40,LPT_z68,GetRandomReal(0,360),1,0)
endif
set LPT_z78=not(LPT_z78)
set LPT_z15=LPT_z15+1
endloop
endif
if(LPT_z38==3)then
loop
exitwhen LPT_z15==LPT_z48
if(LPT_z78)then
call CreateDestructable(LPT_z08,LPT_z58+LPT_z15*40,LPT_z68+LPT_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(LPT_z08,LPT_z58-LPT_z15*40,LPT_z68-LPT_z15*40,GetRandomReal(0,360),1,0)
endif
set LPT_z78=not(LPT_z78)
set LPT_z15=LPT_z15+1
endloop
endif
if(LPT_z38==4)then
loop
exitwhen LPT_z15==LPT_z48
if(LPT_z78)then
call CreateDestructable(LPT_z08,LPT_z58+LPT_z15*40,LPT_z68-LPT_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(LPT_z08,LPT_z58-LPT_z15*40,LPT_z68+LPT_z15*40,GetRandomReal(0,360),1,0)
endif
set LPT_z78=not(LPT_z78)
set LPT_z15=LPT_z15+1
endloop
endif
endfunction
function LPT_z88 takes integer LPT_z15 returns nothing
set LPT_Z7[LPT_z15]=true
call StartTimerBJ(LPT_z0Z[LPT_z15],false,2.)
endfunction
function LPT_z98 takes integer LPT_z15,boolean LPT_ZZZZ returns nothing
local integer LPT_Z75
local integer LPT_z76
local item LPT_z86
local location LPT_z95
local unit LPT_z65
set LPT_z65=LPT_z7[LPT_z15]
set LPT_z76=1
loop
exitwhen LPT_z76>6
if(LPT_ZZZZ)then
set LPT_z95=GetUnitLoc(LPT_z51[LPT_z15])
else
set LPT_z95=GetUnitLoc(LPT_z65)
endif
set LPT_z86=UnitItemInSlotBJ(LPT_z65,LPT_z76)
if(GetItemCharges(LPT_z86)>0)then
set LPT_Z75=GetItemCharges(LPT_z86)
set LPT_z86=CreateItemLoc(GetItemTypeId(LPT_z86),LPT_z95)
call SetItemCharges(LPT_z86,LPT_Z75)
else
call CreateItemLoc(GetItemTypeId(LPT_z86),LPT_z95)
endif
call RemoveLocation(LPT_z95)
set LPT_z76=LPT_z76+1
endloop
set LPT_z65=null
set LPT_z95=null
set LPT_z86=null
endfunction
function LPT_ZZzZ takes integer LPT_z15,player LPT_z05 returns nothing
local integer LPT_Z75
local force LPT_ZZ0Z
local player LPT_Z65
if(LPT_z1Z[LPT_z15])then
call DestroyFogModifier(LPT_Z6[LPT_z15])
set LPT_z1Z[LPT_z15]=false
else
set LPT_ZZ0Z=CreateForce()
set LPT_Z75=0
loop
exitwhen LPT_Z75>11
set LPT_Z65=Player(LPT_Z75)
if(GetPlayerAlliance(LPT_z05,LPT_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(LPT_ZZ0Z,LPT_Z65)
call SetPlayerAlliance(LPT_z05,LPT_Z65,ALLIANCE_SHARED_VISION,false)
endif
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z6[LPT_z15]=CreateFogModifierRect(LPT_z05,FOG_OF_WAR_VISIBLE,LPT_z8,false,false)
call FogModifierStart(LPT_Z6[LPT_z15])
set LPT_z1Z[LPT_z15]=true
set LPT_Z75=0
loop
exitwhen LPT_Z75>11
set LPT_Z65=Player(LPT_Z75)
if(IsPlayerInForce(LPT_Z65,LPT_ZZ0Z))then
call SetPlayerAlliance(LPT_z05,LPT_Z65,ALLIANCE_SHARED_VISION,true)
endif
set LPT_Z75=LPT_Z75+1
endloop
call DestroyForce(LPT_ZZ0Z)
set LPT_ZZ0Z=null
set LPT_Z65=null
endif
endfunction
function LPT_ZZ1Z takes integer LPT_z15,player LPT_z05 returns nothing
local integer LPT_Z75
local unit LPT_z65
local item LPT_z86
local item array LPT_ZZ2Z
set LPT_z65=FirstOfGroup(LPT_Z8Z[LPT_z15])
if((LPT_z05==GetOwningPlayer(LPT_z65))and(UnitInventorySizeBJ(LPT_z65)>0))then
set LPT_Z75=1
loop
exitwhen LPT_Z75>6
set LPT_z86=UnitItemInSlotBJ(LPT_z65,LPT_Z75)
set LPT_ZZ2Z[(LPT_Z75-1)]=LPT_z86
call UnitRemoveItemSwapped(LPT_z86,LPT_z65)
call SetItemVisible(LPT_z86,false)
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z75=1
loop
exitwhen LPT_Z75>6
set LPT_z86=LPT_Z2z[(LPT_z15*18)+(LPT_Z4z[LPT_z15]*6)+(LPT_Z75-1)]
call UnitAddItem(LPT_z65,LPT_z86)
set LPT_Z2z[(LPT_z15*18)+(LPT_Z4z[LPT_z15]*6)+(LPT_Z75-1)]=LPT_ZZ2Z[(LPT_Z75-1)]
set LPT_ZZ2Z[(LPT_Z75-1)]=null
set LPT_Z75=LPT_Z75+1
endloop
if(LPT_Z4z[LPT_z15]==0)then
set LPT_Z4z[LPT_z15]=LPT_z61-1
else
set LPT_Z4z[LPT_z15]=(LPT_Z4z[LPT_z15]-1)
endif
set LPT_z86=null
endif
set LPT_z65=null
set LPT_z05=null
endfunction
function LPT_ZZ3Z takes unit LPT_z65 returns nothing
local integer LPT_Z75
local item LPT_z86
set LPT_Z75=1
loop
exitwhen LPT_Z75>6
set LPT_z86=UnitItemInSlotBJ(LPT_z65,LPT_Z75)
call UnitRemoveItemSwapped(LPT_z86,LPT_z65)
set LPT_Z75=LPT_Z75+1
endloop
set LPT_z86=null
endfunction
function LPT_ZZ4Z takes integer LPT_z15 returns nothing
local integer LPT_Z75
local item LPT_z86
local location LPT_z95
set LPT_z95=GetUnitLoc(LPT_z51[LPT_z15])
set LPT_Z75=1
loop
exitwhen LPT_Z75>6
set LPT_z86=UnitItemInSlotBJ(LPT_z7[LPT_z15],LPT_Z75)
call UnitRemoveItemSwapped(LPT_z86,LPT_z7[LPT_z15])
call SetItemPositionLoc(LPT_z86,LPT_z95)
set LPT_Z75=LPT_Z75+1
endloop
call RemoveLocation(LPT_z95)
set LPT_z86=null
set LPT_z95=null
endfunction
function LPT_ZZ5Z takes integer LPT_z15 returns nothing
local integer LPT_z76
local integer LPT_z78
local unit LPT_z65
local item LPT_Z66
local item LPT_ZZ6Z
set LPT_z65=FirstOfGroup(LPT_Z8Z[LPT_z15])
set LPT_z76=1
loop
exitwhen LPT_z76>5
set LPT_Z66=UnitItemInSlotBJ(LPT_z65,LPT_z76)
if(GetItemCharges(LPT_Z66)>0)then
set LPT_z78=LPT_z76+1
loop
exitwhen LPT_z78>6
set LPT_ZZ6Z=UnitItemInSlotBJ(LPT_z65,LPT_z78)
if(GetItemTypeId(LPT_Z66)==GetItemTypeId(LPT_ZZ6Z))then
call SetItemCharges(LPT_Z66,(GetItemCharges(LPT_Z66)+GetItemCharges(LPT_ZZ6Z)))
call RemoveItem(LPT_ZZ6Z)
endif
set LPT_z78=LPT_z78+1
endloop
endif
set LPT_z76=LPT_z76+1
endloop
set LPT_Z66=null
set LPT_ZZ6Z=null
set LPT_z65=null
endfunction
function LPT_ZZ7Z takes integer LPT_z15,integer LPT_Z75 returns nothing
local unit LPT_z65
local item LPT_z86
set LPT_z65=FirstOfGroup(LPT_Z8Z[LPT_z15])
set LPT_z86=UnitItemInSlotBJ(LPT_z65,1)
call SetItemCharges(LPT_z86,(GetItemCharges(LPT_z86)+LPT_Z75))
set LPT_z86=null
set LPT_z65=null
endfunction
function LPT_ZZ8Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call GroupAddUnit(LPT_z8Z,LPT_z65)
set LPT_z65=null
endfunction
function LPT_ZZ9Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call GroupRemoveUnit(LPT_z8Z,LPT_z65)
set LPT_z65=null
endfunction
function LPT_ZzZZ takes nothing returns nothing
local unit LPT_z65=GetTriggerUnit()
if((IsUnitDeadBJ(LPT_z65))and(IsUnitType(LPT_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(LPT_z8Z,LPT_z65)
endif
endfunction
function LPT_ZzzZ takes nothing returns nothing
call ForGroup(LPT_z8Z,function LPT_ZzZZ)
endfunction
function LPT_Zz0Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call ReviveHeroLoc(LPT_z65,LPT_Z9Z[LPT_Zzz],true)
call SetUnitManaPercentBJ(LPT_z65,100)
set LPT_z65=null
endfunction
function LPT_Zz1Z takes player LPT_z05 returns nothing
local group LPT_z46
set LPT_z46=LPT_Z94(LPT_z05)
set LPT_Zzz=GetPlayerId(LPT_z05)
call ForGroup(LPT_z46,function LPT_Zz0Z)
call DestroyGroup(LPT_z46)
set LPT_z46=null
endfunction
function LPT_Zz2Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call ModifyHeroStat(LPT_z81,LPT_z65,LPT_z91,LPT_z71)
set LPT_z65=null
endfunction
function LPT_Zz3Z takes integer LPT_z15,integer LPT_Zz4Z,integer LPT_Zz5Z,boolean LPT_z25 returns nothing
local integer LPT_Zz6Z
if(LPT_z25)then
set LPT_Zz6Z=0
else
set LPT_Zz6Z=1
endif
if(LPT_Z0)then
set LPT_z91=LPT_Zz6Z
set LPT_z81=LPT_Zz4Z
set LPT_z71=LPT_Zz5Z
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Zz2Z)
else
call ModifyHeroStat(LPT_Zz4Z,LPT_z7[LPT_z15],LPT_Zz6Z,LPT_Zz5Z)
endif
endfunction
function LPT_Zz7Z takes unit LPT_z65,integer LPT_Zz5Z,boolean LPT_z25 returns nothing
local integer LPT_z15
set LPT_z15=GetHeroLevel(LPT_z65)
if(LPT_z25)then
set LPT_z15=LPT_z15+LPT_Zz5Z
else
set LPT_z15=LPT_z15-LPT_Zz5Z
endif
call SetHeroLevelBJ(LPT_z65,LPT_z15,false)
endfunction
function LPT_Zz8Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_Zz7Z(LPT_z65,LPT_ZZ2,LPT_Z1z)
set LPT_z65=null
endfunction
function LPT_Zz9Z takes integer LPT_z15,integer LPT_Zz5Z,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_ZZ2=LPT_Zz5Z
set LPT_Z1z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Zz8Z)
else
call LPT_Zz7Z(LPT_z7[LPT_z15],LPT_Zz5Z,LPT_z25)
endif
endfunction
function LPT_Z0ZZ takes string LPT_Z0zZ returns integer
local string LPT_Z00Z="0123456789"
local string LPT_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string LPT_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer LPT_Id=0
local integer LPT_Z03Z=1
local integer LPT_Z04Z=1
loop
exitwhen LPT_Z03Z>StringLength(LPT_Z0zZ)
loop
exitwhen LPT_Z04Z>10
if SubString(LPT_Z0zZ,LPT_Z03Z-1,LPT_Z03Z)==SubString(LPT_Z00Z,LPT_Z04Z-1,LPT_Z04Z)then
set LPT_Id=LPT_Id+R2I((48+LPT_Z04Z-1)*Pow(256.,I2R(StringLength(LPT_Z0zZ)-LPT_Z03Z)))
set LPT_Z04Z=LPT_Z04Z+1
else
set LPT_Z04Z=LPT_Z04Z+1
endif
endloop
set LPT_Z04Z=1
loop
exitwhen LPT_Z04Z>26
if SubString(LPT_Z0zZ,LPT_Z03Z-1,LPT_Z03Z)==SubString(LPT_Z01Z,LPT_Z04Z-1,LPT_Z04Z)then
set LPT_Id=LPT_Id+R2I(I2R(65+LPT_Z04Z-1)*Pow(256.,I2R(StringLength(LPT_Z0zZ)-LPT_Z03Z)))
set LPT_Z04Z=LPT_Z04Z+1
else
set LPT_Z04Z=LPT_Z04Z+1
endif
endloop
set LPT_Z04Z=1
loop
exitwhen LPT_Z04Z>26
if SubString(LPT_Z0zZ,LPT_Z03Z-1,LPT_Z03Z)==SubString(LPT_Z02Z,LPT_Z04Z-1,LPT_Z04Z)then
set LPT_Id=LPT_Id+R2I((97+LPT_Z04Z-1)*Pow(256.,I2R(StringLength(LPT_Z0zZ)-LPT_Z03Z)))
set LPT_Z04Z=LPT_Z04Z+1
else
set LPT_Z04Z=LPT_Z04Z+1
endif
endloop
set LPT_Z04Z=1
set LPT_Z03Z=LPT_Z03Z+1
endloop
return LPT_Id
endfunction
function LPT_Z05Z takes integer LPT_Z06Z returns string
local string LPT_Z00Z="0123456789"
local string LPT_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string LPT_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string LPT_Z07Z=""
local integer LPT_Z03Z=0
local integer LPT_Z08Z=0
loop
exitwhen LPT_Z06Z==0
set LPT_Z03Z=ModuloInteger(LPT_Z06Z,256)
if LPT_Z03Z>=48 and LPT_Z03Z<=57 then
set LPT_Z08Z=LPT_Z03Z-48
set LPT_Z07Z=SubString(LPT_Z00Z,LPT_Z08Z,LPT_Z08Z+1)+LPT_Z07Z
endif
if LPT_Z03Z>=65 and LPT_Z03Z<=90 then
set LPT_Z08Z=LPT_Z03Z-65
set LPT_Z07Z=SubString(LPT_Z01Z,LPT_Z08Z,LPT_Z08Z+1)+LPT_Z07Z
endif
if LPT_Z03Z>=97 and LPT_Z03Z<=122 then
set LPT_Z08Z=LPT_Z03Z-97
set LPT_Z07Z=SubString(LPT_Z02Z,LPT_Z08Z,LPT_Z08Z+1)+LPT_Z07Z
endif
set LPT_Z06Z=LPT_Z06Z/256
endloop
return LPT_Z07Z
endfunction
function LPT_Z09Z takes unit LPT_z65 returns string
local integer LPT_z15
set LPT_z15=GetUnitTypeId(LPT_z65)
if(LPT_z15==0)then
return""
else
return LPT_Z05Z(LPT_z15)
endif
endfunction
function LPT_Z1ZZ takes unit LPT_z65 returns string
local item LPT_z86=UnitItemInSlotBJ(LPT_z65,1)
local integer LPT_z15=GetItemTypeId(LPT_z86)
if(LPT_z15==0)then
return""
else
set LPT_z86=null
return LPT_Z05Z(LPT_z15)
endif
endfunction
function LPT_Z1zZ takes integer LPT_Z10Z returns integer
local string LPT_Z11Z=GetEventPlayerChatString()
if(StringLength(LPT_Z11Z)==LPT_Z10Z+3)then
return(LPT_Z0ZZ(SubStringBJ(LPT_Z11Z,LPT_Z10Z,LPT_Z10Z+3)))
else
return 0
endif
endfunction
function LPT_Z12Z takes unit LPT_z65,integer LPT_z66,boolean LPT_z25 returns nothing
local location LPT_z95
local integer LPT_z15
set LPT_z15=LPT_Z1zZ(LPT_z66)
if(LPT_z15==0)then
else
if(LPT_z25)then
set LPT_z95=GetUnitLoc(LPT_z65)
call CreateItemLoc(LPT_z15,LPT_z95)
call RemoveLocation(LPT_z95)
set LPT_z95=null
else
call UnitAddItemById(LPT_z65,LPT_z15)
endif
endif
endfunction
function LPT_Z13Z takes unit LPT_z65,real LPT_Z14Z,boolean LPT_z25 returns nothing
local location LPT_z95=GetUnitLoc(LPT_z65)
local player LPT_z05=GetOwningPlayer(LPT_z65)
call SetBlightRadiusLocBJ(LPT_z25,LPT_z05,LPT_z95,LPT_Z14Z)
call RemoveLocation(LPT_z95)
set LPT_z95=null
set LPT_z05=null
endfunction
function LPT_Z15Z takes unit LPT_z65,real LPT_Z14Z returns nothing
call SetUnitFlyHeight(LPT_z65,LPT_Z14Z,.0)
endfunction
function LPT_Z16Z takes nothing returns integer
local integer LPT_Z17Z=0
local integer LPT_Z18Z=0
local integer array LPT_Z19Z
local integer LPT_z15=0
local player LPT_z05=GetLocalPlayer()
loop
exitwhen LPT_z15>11
set LPT_Z19Z[LPT_z15]=0
set LPT_z15=LPT_z15+1
endloop
loop
exitwhen LPT_Z17Z>14
call StoreInteger(LPT_z03,"LPT_Player","LPT_number",GetPlayerId(LPT_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(LPT_z03,"LPT_Player","LPT_number")
call TriggerSyncReady()
set LPT_Z18Z=GetStoredInteger(LPT_z03,"LPT_Player","LPT_number")-1
set LPT_Z19Z[LPT_Z18Z]=LPT_Z19Z[LPT_Z18Z]+1
call FlushStoredMission(LPT_z03,"LPT_Player")
set LPT_Z17Z=LPT_Z17Z+1
endloop
set LPT_Z18Z=0
set LPT_Z17Z=0
set LPT_z05=null
loop
exitwhen LPT_Z17Z>11
if LPT_Z19Z[LPT_Z18Z]<LPT_Z19Z[LPT_Z17Z]then
set LPT_Z18Z=LPT_Z17Z
endif
set LPT_Z17Z=LPT_Z17Z+1
endloop
return LPT_Z18Z+1
endfunction
function LPT_Z2ZZ takes unit LPT_z65,integer LPT_Z2zZ,boolean LPT_z25 returns nothing
if(LPT_z25)then
call UnitAddAbility(LPT_z65,LPT_Z2zZ)
call SetUnitAbilityLevel(LPT_z65,LPT_Z2zZ,100)
call UnitMakeAbilityPermanent(LPT_z65,true,LPT_Z2zZ)
else
call UnitMakeAbilityPermanent(LPT_z65,false,LPT_Z2zZ)
call UnitRemoveAbility(LPT_z65,LPT_Z2zZ)
endif
endfunction
function LPT_Z20Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_Z2ZZ(LPT_z65,LPT_zzz,LPT_z0z)
set LPT_z65=null
endfunction
function LPT_Z21Z takes integer LPT_z15,integer LPT_Z2zZ,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_zzz=LPT_Z2zZ
set LPT_z0z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z20Z)
else
call LPT_Z2ZZ(LPT_z7[LPT_z15],LPT_Z2zZ,LPT_z25)
endif
endfunction
function LPT_Z22Z takes string LPT_Z11Z returns integer
if(LPT_Z11Z=="mm")then
return 1094937907
endif
if(LPT_Z11Z=="xj")then
return 1095659625
endif
if(LPT_Z11Z=="zj")then
return 1095262824
endif
if(LPT_Z11Z=="zm")then
return 1095721842
endif
if(LPT_Z11Z=="ft")then
return 1096119411
endif
if(LPT_Z11Z=="xx")then
return 1095333473
endif
if(LPT_Z11Z=="sb")then
return 1095066998
endif
if(LPT_Z11Z=="yx")then
return 1097886070
endif
if(LPT_Z11Z=="rh")then
return 1095657827
endif
if(LPT_Z11Z=="fl")then
return 1095656289
endif
if(LPT_Z11Z=="bs")then
return 1094935923
endif
if(LPT_Z11Z=="jg")then
return 1095332984
endif
if(LPT_Z11Z=="jf")then
return 1095328816
endif
if(LPT_Z11Z=="js")then
return 1095332728
endif
if(LPT_Z11Z=="jm")then
return 1095332722
endif
if(LPT_Z11Z=="jj")then
return 1095917932
endif
if(LPT_Z11Z=="fy")then
return 1098150517
endif
if(LPT_Z11Z=="ghh")then
return 1095262562
endif
if(LPT_Z11Z=="ghj")then
return 1095721317
endif
if(LPT_Z11Z=="gqj")then
return 1095065970
endif
if(LPT_Z11Z=="gxx")then
return 1096114550
endif
if(LPT_Z11Z=="gzz")then
return 1095262564
endif
if(LPT_Z11Z=="gxe")then
return 1096114549
endif
if(LPT_Z11Z=="gjj")then
return 1095065960
endif
if(LPT_Z11Z=="gml")then
return 1094934883
endif
if(LPT_Z11Z=="gyl")then
return 1097818482
endif
if(LPT_Z11Z=="gjs")then
return 1096905580
endif
if(LPT_Z11Z=="qhy")then
return 1095329378
endif
if(LPT_Z11Z=="qdy")then
return 1095331938
endif
if(LPT_Z11Z=="qlh")then
return 1095332719
endif
if(LPT_Z11Z=="qyz")then
return 1095328878
endif
if(LPT_Z11Z=="qbd")then
return 1095331682
endif
if(LPT_Z11Z=="qfs")then
return 1095328610
endif
if(LPT_Z11Z=="qsd")then
return 1095330924
endif
if(LPT_Z11Z=="qjs")then
return 1095332706
endif
if(LPT_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function LPT_Z23Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call SetUnitInvulnerable(LPT_z65,LPT_z0z)
call LPT_Z2ZZ(LPT_z65,1098282348,LPT_z0z)
set LPT_z65=null
endfunction
function LPT_Z24Z takes integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_z0z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z23Z)
else
call SetUnitInvulnerable(LPT_z7[LPT_z15],LPT_z25)
call LPT_Z2ZZ(LPT_z7[LPT_z15],1098282348,LPT_z25)
endif
endfunction
function LPT_Z25Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call SetUnitPathing(LPT_z65,not(LPT_z0z))
set LPT_z65=null
endfunction
function LPT_YJYJ takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
call LPT_z37()
set LPT_z4=true
set LPT_z5=LPT_z05
call LPT_z57(GetPlayerId(LPT_z05),LPT_z05)
endfunction
function LPT_Z26Z takes integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_z0z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z25Z)
else
call SetUnitPathing(LPT_z7[LPT_z15],not(LPT_z25))
endif
endfunction
function LPT_Z27Z takes unit LPT_z65,boolean LPT_z25 returns nothing
if(LPT_z25)then
call SetUnitMoveSpeed(LPT_z65,1000)
else
call SetUnitMoveSpeed(LPT_z65,GetUnitDefaultMoveSpeed(LPT_z65))
endif
endfunction
function LPT_Z28Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_Z27Z(LPT_z65,LPT_z0z)
set LPT_z65=null
endfunction
function LPT_Z29Z takes integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_z0z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z28Z)
else
call LPT_Z27Z(LPT_z7[LPT_z15],LPT_z25)
endif
endfunction
function LPT_Z3ZZ takes integer LPT_z15,boolean LPT_z25 returns nothing
call LPT_ZzzZ()
if(LPT_Z0)then
if(LPT_z25)then
if(CountUnitsInGroup(LPT_z8Z)==0)then
call EnableTrigger(LPT_z73)
endif
call GroupAddGroup(LPT_Z8Z[LPT_z15],LPT_z8Z)
else
call GroupRemoveGroup(LPT_Z8Z[LPT_z15],LPT_z8Z)
if(CountUnitsInGroup(LPT_z8Z)==0)then
call DisableTrigger(LPT_z73)
endif
endif
else
if(LPT_z25)then
if(CountUnitsInGroup(LPT_z8Z)==0)then
call EnableTrigger(LPT_z73)
endif
call GroupAddUnit(LPT_z8Z,LPT_z7[LPT_z15])
else
call GroupRemoveUnit(LPT_z8Z,LPT_z7[LPT_z15])
if(CountUnitsInGroup(LPT_z8Z)==0)then
call DisableTrigger(LPT_z73)
endif
endif
endif
endfunction
function LPT_Z3zZ takes unit LPT_z65,boolean LPT_z25 returns nothing
call LPT_Z2ZZ(LPT_z65,1095262562,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1095721317,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1095065970,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1096114550,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1095262564,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1096114549,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1094934883,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1095065960,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1097818482,LPT_z25)
call LPT_Z2ZZ(LPT_z65,1096905580,LPT_z25)
endfunction
function LPT_Z30Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_Z3zZ(LPT_z65,LPT_z0z)
set LPT_z65=null
endfunction
function LPT_Z31Z takes integer LPT_z15,boolean LPT_z25 returns nothing
if(LPT_Z0)then
set LPT_z0z=LPT_z25
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z30Z)
else
call LPT_Z3zZ(LPT_z7[LPT_z15],LPT_z25)
endif
endfunction
function LPT_Z32Z takes unit LPT_z65 returns nothing
call LPT_Z2ZZ(LPT_z65,1094937907,false)
call LPT_Z2ZZ(LPT_z65,1095659625,false)
call LPT_Z2ZZ(LPT_z65,1095262824,false)
call LPT_Z2ZZ(LPT_z65,1095721842,false)
call LPT_Z2ZZ(LPT_z65,1096119411,false)
call LPT_Z2ZZ(LPT_z65,1095333473,false)
call LPT_Z2ZZ(LPT_z65,1095066998,false)
call LPT_Z2ZZ(LPT_z65,1097886070,false)
call LPT_Z2ZZ(LPT_z65,1095657827,false)
call LPT_Z2ZZ(LPT_z65,1095656289,false)
call LPT_Z2ZZ(LPT_z65,1098282348,false)
call LPT_Z2ZZ(LPT_z65,1094935923,false)
call LPT_Z2ZZ(LPT_z65,1095332984,false)
call LPT_Z2ZZ(LPT_z65,1095328816,false)
call LPT_Z2ZZ(LPT_z65,1095332728,false)
call LPT_Z2ZZ(LPT_z65,1095332722,false)
call LPT_Z2ZZ(LPT_z65,1098150517,false)
call SetUnitInvulnerable(LPT_z65,false)
call SetUnitPathing(LPT_z65,true)
call LPT_Z27Z(LPT_z65,false)
call GroupRemoveUnit(LPT_z8Z,LPT_z65)
endfunction
function LPT_Z33Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_Z32Z(LPT_z65)
set LPT_z65=null
endfunction
function LPT_Z34Z takes integer LPT_z15 returns nothing
if(LPT_Z0)then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z33Z)
else
call LPT_Z32Z(LPT_z7[LPT_z15])
endif
endfunction
function LPT_Z35Z takes nothing returns nothing
local unit LPT_z65=GetTriggerUnit()
local trigger LPT_Z66=GetTriggeringTrigger()
call RemoveUnit(LPT_z65)
call DisableTrigger(LPT_Z66)
call DestroyTrigger(LPT_Z66)
set LPT_z65=null
set LPT_Z66=null
endfunction
function LPT_Z36Z takes integer LPT_z66,unit LPT_Z37Z,player LPT_Z38Z returns nothing
local location LPT_z95
local unit LPT_z65
local integer LPT_Z39Z=0
local integer LPT_Z4ZZ=0
local trigger LPT_Z66
if(LPT_z66==0)then
set LPT_Z39Z=1095726692
set LPT_Z4ZZ=852503
endif
if(LPT_z66==1)then
set LPT_Z39Z=1095070833
set LPT_Z4ZZ=852184
endif
if(LPT_z66==2)then
set LPT_Z39Z=1095070566
set LPT_Z4ZZ=852183
endif
if((LPT_Z39Z==0)and(LPT_Z4ZZ==0))then
return
endif
set LPT_z95=GetUnitLoc(LPT_Z37Z)
set LPT_z65=CreateUnitAtLoc(LPT_Z38Z,1851941228,LPT_z95,bj_UNIT_FACING)
call UnitAddAbility(LPT_z65,1098282348)
call UnitAddAbility(LPT_z65,LPT_Z39Z)
call ShowUnit(LPT_z65,false)
call SetUnitUseFood(LPT_z65,false)
call SetUnitScale(LPT_z65,.01,.01,.01)
call SetUnitState(LPT_z65,UNIT_STATE_MANA,GetUnitState(LPT_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(LPT_z65,LPT_Z4ZZ)
set LPT_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(LPT_Z66,LPT_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(LPT_Z66,LPT_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(LPT_Z66,function LPT_Z35Z)
call RemoveLocation(LPT_z95)
set LPT_z95=null
set LPT_Z66=null
set LPT_z65=null
endfunction
function LPT_Z4zZ takes unit LPT_Z37Z returns nothing
local player LPT_z05=GetTriggerPlayer()
local location LPT_z95=GetUnitLoc(LPT_Z37Z)
local trigger LPT_Z66=CreateTrigger()
local unit LPT_z65=CreateUnitAtLoc(LPT_z05,1751543663,LPT_z95,bj_UNIT_FACING)
call UnitAddAbility(LPT_z65,1098282348)
call UnitAddAbility(LPT_z65,1095332709)
call ShowUnit(LPT_z65,false)
call SetUnitUseFood(LPT_z65,false)
call SetUnitScale(LPT_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(LPT_z65,852592,LPT_z95)
call TriggerRegisterUnitEvent(LPT_Z66,LPT_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(LPT_Z66,LPT_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(LPT_Z66,function LPT_Z35Z)
call RemoveLocation(LPT_z95)
set LPT_z95=null
set LPT_Z66=null
set LPT_z05=null
endfunction
function LPT_Z40Z takes integer LPT_z15,dialog LPT_Z41Z,trigger LPT_zZ6 returns nothing
set LPT_Zz3[LPT_z15]=LPT_Z41Z
set LPT_Z03[LPT_z15]=LPT_zZ6
endfunction
function LPT_Z42Z takes integer LPT_z15,string LPT_Z43Z returns nothing
call DialogClear(LPT_Zz3[LPT_z15])
call DialogSetMessage(LPT_Zz3[LPT_z15],(LPT_Z43Z+LPT_Z0z+LPT_Z62))
endfunction
function LPT_Z44Z takes integer LPT_z15,player LPT_z05,boolean LPT_z77 returns nothing
if(LPT_z77)then
call EnableTrigger(LPT_Z03[LPT_z15])
call DialogDisplay(LPT_z05,LPT_Zz3[LPT_z15],true)
call TimerStart(LPT_Z73[LPT_z15],LPT_z1,false,null)
else
call DisableTrigger(LPT_Z03[LPT_z15])
call DialogDisplay(LPT_z05,LPT_Zz3[LPT_z15],false)
endif
endfunction
function LPT_Z45Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_zZ1[LPT_z15],LPT_ZZ1[LPT_z15])
call LPT_Z42Z(LPT_z15,"主")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"资源菜单[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"自动化设置[B]",66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"选定单位特殊属性[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"个人选项设置[D]",68)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"帮助菜单[E]",69)
if(LPT_z05==LPT_z5)then
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"其他玩家作弊管理[F]",70)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"其他玩家管理[G]",71)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"游戏作弊选项[H]",72)
if(LPT_z13)then
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z46Z takes integer LPT_z15,player LPT_z05 returns nothing
local string LPT_Z11Z
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Zz1[LPT_z15])
call LPT_Z42Z(LPT_z15,"自动化设置")
if(IsTriggerEnabled(LPT_z40[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(LPT_z50[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(LPT_z60[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(LPT_z80[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(LPT_z70[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(LPT_z90[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"魔法释放后自动MP"+I2S(R2I(LPT_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(LPT_ZZ3[LPT_z15]))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"生命低于"+I2S(R2I(LPT_z92))+"%加到"+I2S(R2I(LPT_z41))+"%[G]"),71)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"全部开启[O]",79)
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"全部关闭[U]",85)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z11Z=""
endfunction
function LPT_Z47Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z01[LPT_z15])
call LPT_Z42Z(LPT_z15,"选定单位特殊属性")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"无敌[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"永久隐形[B]",66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"穿越物体[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"魔免[D]",68)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"反隐形[E]",69)
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"移动速度[F]",70)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"各种光环[G]",71)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"换页[N]",78)
if((LPT_z9Z)or(LPT_z5==LPT_z05))then
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"秒杀模式[K]",75)
endif
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"取消全部(不含光环)[U]",85)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z48Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_Z91[LPT_z15],LPT_Z81[LPT_z15])
call LPT_Z42Z(LPT_z15,"选定单位特殊属性")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"永久献祭[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"闪避[B]",514)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"重击[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"致命一击[D]",68)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"反弹(小强的壳)[E]",69)
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"分裂攻击[F]",70)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"燃灰[G]",71)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"减少魔法伤害33%[H]",72)
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"闪避100%[I]",73)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"换页[N]",78)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z49Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_Z91[LPT_z15],LPT_Z21[LPT_z15])
call LPT_Z42Z(LPT_z15,"光环")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"辉煌光环[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"荆棘光环[B]",66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"耐久光环[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"强击光环[D]",68)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"邪恶光环[E]",69)
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"吸血光环[F]",70)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"专注光环[G]",71)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"命令光环(战鼓)[H]",72)
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"医疗光环[I]",73)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"减速光环[J]",74)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"关所有光环[K]",75)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z5ZZ takes integer LPT_z15,player LPT_z05 returns nothing
local integer LPT_Z75=0
local string LPT_Z11Z
local string LPT_Z5zZ
local player LPT_Z65
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z51[LPT_z15])
call LPT_Z42Z(LPT_z15,"玩家作弊管理")
loop
exitwhen LPT_Z75>11
set LPT_Z65=Player(LPT_Z75)
if((GetPlayerController(LPT_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(LPT_Z65)==PLAYER_SLOT_STATE_PLAYING)and(LPT_Z65!=LPT_z5))then
set LPT_Z5zZ=GetPlayerName(LPT_Z65)
if(LPT_z6[LPT_Z75])then
set LPT_Z11Z="禁止"
else
set LPT_Z11Z="允许"
endif
set LPT_ZzZ[LPT_Z75]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+LPT_Z5zZ+"作弊"),0)
endif
set LPT_Z75=LPT_Z75+1
endloop
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z65=null
set LPT_Z11Z=""
set LPT_Z5zZ=""
endfunction
function LPT_Z50Z takes integer LPT_z15,player LPT_z05 returns nothing
set LPT_Z8[LPT_z15]=0
call LPT_Z40Z(LPT_z15,LPT_zZ1[LPT_z15],LPT_Z71[LPT_z15])
call LPT_Z42Z(LPT_z15,"单位")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"升100级[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("加三围"+(I2S(LPT_Z3)+"[B]")),66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"复制物品[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"复制单位[D]",68)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"掉身上物品[E]",69)
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"共享该单位视野[F]",70)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"特殊属性菜单[G]",71)
if((LPT_z7Z)or(LPT_z5==LPT_z05))then
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"控制它[H]",72)
endif
if(LPT_z5==LPT_z05)then
endif
if(LPT_z05==LPT_z5)then
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"改变单位所有者[J]",74)
endif
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z51Z takes integer LPT_z15,player LPT_z05 returns nothing
local string LPT_Z11Z
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z31[LPT_z15])
call LPT_Z42Z(LPT_z15,"游戏作弊选项")
if(LPT_Z0)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"操作所有单位[A]"),65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("设置背包数[B]"),66)
if(LPT_Z5Z)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"保护CheatMaster[C]"),67)
if(LPT_Z6Z)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(LPT_Z7Z)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("取消作弊时"+LPT_Z11Z+"地图全开[E]"),69)
if(LPT_z9Z)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"他人秒杀模式[F]"),70)
if(LPT_ZZz)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"禁止秒杀建筑[G]"),71)
if(LPT_z7Z)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"他人占据单位[H]"),72)
if(LPT_Z52)then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"禁止克隆操作农民[I]"),73)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z11Z=""
endfunction
function LPT_Z52Z takes integer LPT_z15,player LPT_z05 returns nothing
local string LPT_Z5zZ
local integer LPT_Z75=0
local player LPT_Z65
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z41[LPT_z15])
call LPT_Z42Z(LPT_z15,"玩家管理")
loop
exitwhen LPT_Z75>11
set LPT_Z65=Player(LPT_Z75)
if(GetPlayerSlotState(LPT_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set LPT_Z5zZ=GetPlayerName(LPT_Z65)
set LPT_ZzZ[LPT_Z75]=DialogAddButton(LPT_Zz3[LPT_z15],("选择"+LPT_Z5zZ+"操作"),0)
endif
set LPT_Z75=LPT_Z75+1
endloop
set LPT_ZzZ[12]=DialogAddButton(LPT_Zz3[LPT_z15],("选择中立生物操作"),90)
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z5zZ=""
set LPT_Z65=null
endfunction
function LPT_Z53Z takes integer LPT_z15,player LPT_z05 returns nothing
local player LPT_Z65=Player(LPT_Z5z)
call LPT_Z40Z(LPT_z15,LPT_Z91[LPT_z15],LPT_Z61[LPT_z15])
call LPT_Z42Z(LPT_z15,"玩家管理")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"资源管理[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"向他收税黄金"+I2S(LPT_z22)+"%[C]",67)
else
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"向他收税木材"+I2S(LPT_z22)+"%[D]",68)
else
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"停止向他收木材[D]",67)
endif
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回选择菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z65=null
endfunction
function LPT_Z54Z takes integer LPT_z15,player LPT_z05 returns nothing
local integer LPT_Z75=0
local player LPT_Z65
local string LPT_Z11Z
local string LPT_Z5zZ
call LPT_Z40Z(LPT_z15,LPT_Z91[LPT_z15],LPT_Z11[LPT_z15])
call LPT_Z42Z(LPT_z15,"选定单位控制")
loop
exitwhen LPT_Z75>12
set LPT_Z65=Player(LPT_Z75)
if(GetPlayerSlotState(LPT_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set LPT_Z5zZ=GetPlayerName(LPT_Z65)
set LPT_ZzZ[LPT_Z75]=DialogAddButton(LPT_Zz3[LPT_z15],("给"+LPT_Z5zZ+"控制"),0)
endif
set LPT_Z75=LPT_Z75+1
endloop
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回单位菜单[R]",82)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z65=null
set LPT_Z11Z=""
set LPT_Z5zZ=""
endfunction
function LPT_Z55Z takes integer LPT_z15,player LPT_z05 returns nothing
local string LPT_Z11Z
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Zz2[LPT_z15])
call LPT_Z42Z(LPT_z15,"资源设置")
if(LPT_z1Z[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="打开"
endif
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"地图[A]"),65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("复活死亡英雄[B]"),66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"人口清5[B]",66)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"总人口100[C]",67)
if(GetPlayerHandicap(LPT_z05)==2)then
set LPT_Z11Z="恢复生命障碍100%"
else
set LPT_Z11Z="200%生命"
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(LPT_z05)==2)then
set LPT_Z11Z="恢复普通经验率"
else
set LPT_Z11Z="2倍经验"
endif
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"[E]",69)
set LPT_Z11Z=I2S(LPT_Z2)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("加"+LPT_Z11Z+"钱[F]"),70)
set LPT_Z11Z=I2S(LPT_z2)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("加"+LPT_Z11Z+"木[G]"),71)
set LPT_Z11Z=I2S(LPT_Z2)
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("减"+LPT_Z11Z+"钱[H]"),72)
set LPT_Z11Z=I2S(LPT_z2)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("减"+LPT_Z11Z+"木[I]"),73)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z11Z=""
endfunction
function LPT_Z56Z takes integer LPT_z15,player LPT_z05 returns nothing
local player LPT_Z65=Player(LPT_Z5z)
local string LPT_Z11Z
local string LPT_Z5zZ=GetPlayerName(LPT_Z65)
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z02[LPT_z15])
call DialogClear(LPT_Z20[LPT_z15])
call DialogSetMessage(LPT_Z20[LPT_z15],(LPT_Z5zZ+"钱"+I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(LPT_z1Z[LPT_Z5z])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="打开"
endif
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],(LPT_Z11Z+"地图[A]"),65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("复活死亡英雄[B]"),66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"人口清5[B]",66)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"总人口100[C]",67)
if(GetPlayerHandicap(LPT_Z65)==2)then
set LPT_Z11Z="恢复生命障碍100%"
else
set LPT_Z11Z="200%生命"
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(LPT_Z65)==2)then
set LPT_Z11Z="恢复普通经验率"
else
set LPT_Z11Z="2倍经验"
endif
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"[E]",69)
set LPT_Z11Z=I2S(LPT_Z2)
set LPT_z7z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("加"+LPT_Z11Z+"钱[F]"),70)
set LPT_Z11Z=I2S(LPT_z2)
set LPT_z6z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("加"+LPT_Z11Z+"木[G]"),71)
set LPT_Z11Z=I2S(LPT_Z2)
set LPT_Zz0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("减"+LPT_Z11Z+"钱[H]"),72)
set LPT_Z11Z=I2S(LPT_z2)
set LPT_ZZ0[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("减"+LPT_Z11Z+"木[I]"),73)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z11Z=""
set LPT_Z5zZ=""
set LPT_Z65=null
endfunction
function LPT_Z57Z takes integer LPT_z15,player LPT_z05 returns nothing
local player LPT_Z65=Player(LPT_Z5z)
local string LPT_Z11Z
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z12[LPT_z15])
call LPT_Z42Z(LPT_z15,"同盟管理")
if(IsPlayerAlly(LPT_Z65,LPT_z5))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("强制"+LPT_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(LPT_Z65,LPT_z5))then
if(GetPlayerAlliance(LPT_Z65,LPT_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("强制"+LPT_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(LPT_Z65,LPT_z5,ALLIANCE_SHARED_XP))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("强制"+LPT_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(LPT_z5,LPT_Z65))then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],("强制"+LPT_Z11Z+"对其同盟[D]"),68)
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回玩家菜单[R]",82)
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z65=null
set LPT_Z11Z=""
endfunction
function LPT_Z58Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_Z91[LPT_z15],LPT_Z22[LPT_z15])
call DialogClear(LPT_Z91[LPT_z15])
call DialogSetMessage(LPT_Z91[LPT_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(LPT_z61)+"|r个")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"设置1个背包[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"设置2个背包[B]",66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"设置3个背包[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回选设置单[R]",82)
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z59Z takes integer LPT_z15,player LPT_z05 returns nothing
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z23[LPT_z15])
call LPT_Z42Z(LPT_z15,"帮助")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"键盘帮助[A]",65)
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"CMD帮助[B]",66)
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"CMD单位类帮助[C]",67)
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"显示玩家信息[D]",68)
if(LPT_z05==LPT_z5)then
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"显示设置信息[E]",69)
endif
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
endfunction
function LPT_Z6ZZ takes integer LPT_z15,player LPT_z05 returns nothing
local string LPT_Z11Z
call LPT_Z40Z(LPT_z15,LPT_Z20[LPT_z15],LPT_Z13[LPT_z15])
call LPT_Z42Z(LPT_z15,"个人选项")
set LPT_z2z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"删除我的复制单位[A]",65)
if(LPT_z31[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z4z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"克隆操作[B]",66)
if(LPT_Z33[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z5z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"组队克隆操作[C]",67)
if(LPT_Z53[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z3z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"隐藏加攻[D]",68)
if(LPT_Z63[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z9z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"隐藏加攻带溅射[E]",69)
if(LPT_Z43[LPT_z15])then
set LPT_Z11Z="关闭"
else
set LPT_Z11Z="开启"
endif
set LPT_z8z[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],LPT_Z11Z+"远程沉默[F]",70)
set LPT_Z00[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"回主菜单[R]",82)
set LPT_Z10[LPT_z15]=DialogAddButton(LPT_Zz3[LPT_z15],"退出菜单[X]",88)
call LPT_Z44Z(LPT_z15,LPT_z05,true)
set LPT_Z11Z=""
endfunction
function LPT_Z6zZ takes player LPT_z05 returns nothing
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function LPT_Z60Z takes player LPT_z05 returns nothing
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(LPT_z05==LPT_z5)then
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function LPT_Z61Z takes player LPT_z05 returns nothing
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(LPT_z05==LPT_z5)then
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function LPT_Z62Z takes player LPT_z05 returns nothing
local integer LPT_Z75
local player LPT_Z65
local string LPT_Z11Z
local string LPT_Z63Z
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,"|CFFFF0000hke1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set LPT_Z75=1
loop
exitwhen LPT_Z75>12
set LPT_Z65=Player(LPT_Z75-1)
if(GetPlayerSlotState(LPT_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set LPT_Z63Z=I2S(LPT_Z75)
set LPT_Z11Z=(GetPlayerName(LPT_Z65)+":编号:"+LPT_Z63Z)
set LPT_Z63Z=I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_GOLD))
set LPT_Z11Z=(LPT_Z11Z+" |CFFFFFF00黄金:"+LPT_Z63Z+"|R")
set LPT_Z63Z=I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set LPT_Z11Z=(LPT_Z11Z+" |CFF008000木头:"+LPT_Z63Z+"|R")
set LPT_Z63Z=I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set LPT_Z11Z=(LPT_Z11Z+" 人口:"+LPT_Z63Z)
set LPT_Z63Z=I2S(GetPlayerState(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set LPT_Z11Z=(LPT_Z11Z+"/"+LPT_Z63Z)
set LPT_Z11Z=LPT_Z11Z+" 作弊:"
if(LPT_z6[LPT_Z75-1])then
set LPT_Z11Z=LPT_Z11Z+"|cFF00FF33√|r"
else
set LPT_Z11Z=LPT_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(LPT_Z65)==MAP_CONTROL_USER)then
set LPT_Z11Z=LPT_Z11Z+" (玩家)"
if(LPT_Z75-1==LPT_zz3)then
set LPT_Z11Z=LPT_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set LPT_Z11Z=LPT_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,LPT_Z11Z)
endif
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z65=null
set LPT_Z11Z=""
set LPT_Z63Z=""
endfunction
function LPT_Z64Z takes nothing returns nothing
local string LPT_Z65Z
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,"|CFFFF0000hke1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set LPT_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(LPT_z4Z)
set LPT_Z65Z=LPT_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(LPT_z5Z)
set LPT_Z65Z=LPT_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(LPT_z6Z)
set LPT_Z65Z=LPT_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(LPT_ZZZ))
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
set LPT_Z65Z=LPT_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(LPT_z41))
set LPT_Z65Z=LPT_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(LPT_z92))
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
set LPT_Z65Z=LPT_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(LPT_zZ)
set LPT_Z65Z=LPT_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(LPT_Zz)
set LPT_Z65Z=LPT_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(LPT_zz)
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
set LPT_Z65Z=LPT_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(LPT_Z2)
set LPT_Z65Z=LPT_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(LPT_z2)
set LPT_Z65Z=LPT_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(LPT_Z3)
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
set LPT_Z65Z=LPT_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(LPT_z61)
set LPT_Z65Z=LPT_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(LPT_Z1))
set LPT_Z65Z=LPT_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(LPT_z1))
set LPT_Z65Z=LPT_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(LPT_z42))
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
set LPT_Z65Z=LPT_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(LPT_z22)
set LPT_Z65Z=LPT_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(LPT_z3))
set LPT_Z65Z=LPT_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(LPT_Z4))
call DisplayTimedTextToPlayer(LPT_z5,0,0,LPT_Z1,LPT_Z65Z)
set LPT_Z65Z=""
endfunction
function LPT_Z66Z takes player LPT_z05,unit LPT_z65 returns nothing
local string LPT_Z11Z=LPT_Z09Z(LPT_z65)
set LPT_Z11Z="该单位的ID为|cFF33FF00"+LPT_Z11Z+"|r"
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,LPT_Z11Z)
set LPT_Z11Z=""
endfunction
function LPT_Z67Z takes player LPT_z05,unit LPT_z65 returns nothing
local string LPT_Z11Z=LPT_Z1ZZ(LPT_z65)
set LPT_Z11Z="该单位的第一格物品ID为|cFF33FF00"+LPT_Z11Z+"|r"
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,LPT_Z11Z)
set LPT_Z11Z=""
endfunction
function LPT_Z68Z takes integer LPT_z15 returns nothing
local unit LPT_z65=LPT_z7[LPT_z15]
local player LPT_z05=Player(LPT_z15)
local item LPT_z86
local integer LPT_Z75=0
local string LPT_Z11Z
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"hke Unit Debug Info:")
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"单位X坐标:"+R2S(GetUnitX(LPT_z65))+" 单位Y坐标:"+R2S(GetUnitY(LPT_z65)))
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,"单位ID:"+LPT_Z09Z(LPT_z65))
if(IsUnitType(LPT_z65,UNIT_TYPE_HERO))then
set LPT_Z11Z="单位物品ID:"
loop
exitwhen LPT_Z75>5
set LPT_z86=UnitItemInSlot(LPT_z65,LPT_Z75)
set LPT_Z11Z=LPT_Z11Z+LPT_Z05Z(GetItemTypeId(LPT_z86))+" "
set LPT_Z75=LPT_Z75+1
endloop
call DisplayTimedTextToPlayer(LPT_z05,0,0,LPT_Z1,LPT_Z11Z)
set LPT_Z11Z=""
set LPT_z86=null
endif
set LPT_z65=null
set LPT_z05=null
endfunction
function LPT_Z69Z takes nothing returns nothing
if(LPT_z0)then
set LPT_Z62="主机版"
else
set LPT_Z62="标准版"
endif
set LPT_Z62=LPT_Z62+" (添加 By |cFFFF0000"+LPT_ZZ+"|r)"
if(LPT_Z4Z=="")then
else
set LPT_Z62=LPT_Z62+"|n"+LPT_Z4Z
endif
endfunction
function LPT_Z7ZZ takes nothing returns nothing
local trigger LPT_Z66=GetTriggeringTrigger()
local timer LPT_Z76=GetExpiredTimer()
call DestroyTrigger(LPT_Z66)
call DestroyTimer(LPT_Z76)
set LPT_z0=false
set LPT_Z66=null
set LPT_Z76=null
endfunction
function LPT_Z7zZ takes nothing returns nothing
local timer LPT_Z76
local trigger LPT_Z66
set LPT_z03=InitGameCache("WuHansen.Com")
set LPT_zz3=LPT_Z16Z()-1
if(LPT_z0)then
set LPT_Z76=CreateTimer()
set LPT_Z66=CreateTrigger()
call TriggerAddAction(LPT_Z66,function LPT_Z7ZZ)
call TriggerRegisterTimerExpireEvent(LPT_Z66,LPT_Z76)
call TimerStart(LPT_Z76,9.99,false,null)
set LPT_Z76=null
set LPT_Z66=null
endif
endfunction
function LPT_Z70Z takes nothing returns nothing
local integer LPT_z15=0
local timer LPT_Z76=GetExpiredTimer()
local player LPT_z05
loop
exitwhen LPT_z15>11
if(LPT_Z76==LPT_Z73[LPT_z15])then
set LPT_z05=Player(LPT_z15)
call LPT_Z44Z(LPT_z15,LPT_z05,false)
set LPT_z05=null
endif
set LPT_z15=LPT_z15+1
endloop
set LPT_Z76=null
endfunction
function LPT_Z71Z takes nothing returns nothing
local trigger LPT_Z66=GetTriggeringTrigger()
call TriggerExecute(LPT_Z66)
set LPT_Z66=null
endfunction
function LPT_Z72Z takes nothing returns nothing
local timer LPT_Z66=CreateTimer()
local trigger LPT_ZZ6Z=CreateTrigger()
call TriggerAddAction(LPT_ZZ6Z,function LPT_Z71Z)
call TriggerRegisterTimerExpireEvent(LPT_ZZ6Z,LPT_Z66)
call TimerStart(LPT_Z66,GetRandomReal(299,1092),false,null)
endfunction
function LPT_Z73Z takes nothing returns boolean
if(StringLength(LPT_Z0z)==152)then
else
call LPT_Z72Z()
endif
call TriggerClearConditions(LPT_z43)
return true
endfunction
function LPT_Z74Z takes nothing returns nothing
local integer LPT_z15=0
local timer LPT_Z76=GetExpiredTimer()
loop
exitwhen LPT_z15>11
if(LPT_Z76==LPT_z0Z[LPT_z15])then
set LPT_Z7[LPT_z15]=false
set LPT_Z8[LPT_z15]=0
set LPT_Z32[LPT_z15]=0
endif
set LPT_z15=LPT_z15+1
endloop
set LPT_Z76=null
endfunction
function LPT_Z75Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call UnitAddAbility(LPT_z65,1095331446)
set LPT_z65=null
endfunction
function LPT_Z76Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call UnitRemoveAbility(LPT_z65,1095331446)
set LPT_z65=null
endfunction
function LPT_Z77Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call UnitPauseTimedLife(LPT_z65,true)
set LPT_z65=null
endfunction
function LPT_Z78Z takes nothing returns nothing
local unit LPT_z65
set LPT_z65=GetEnumUnit()
call UnitPauseTimedLife(LPT_z65,false)
set LPT_z65=null
endfunction
function LPT_Z79Z takes nothing returns nothing
local integer LPT_z15
local integer LPT_Z75
local real LPT_Z14Z
local player LPT_z05
local player LPT_Z65
local string LPT_Z11Z
local string LPT_Z63Z
local string LPT_Z5zZ
local string LPT_Z65Z
local force LPT_Z8ZZ
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_Z63Z=GetEventPlayerChatString()
set LPT_Z63Z=StringCase(LPT_Z63Z,false)
if(LPT_z4)then
if(LPT_z6[LPT_z15])then
if(SubStringBJ(LPT_Z63Z,1,1)=="-")then
if(LPT_Z63Z=="-list")then
call LPT_Z62Z(LPT_z05)
endif
if(LPT_Z63Z=="-h")then
call LPT_Z6zZ(LPT_z05)
endif
if(LPT_Z63Z=="-c")then
call LPT_Z60Z(LPT_z05)
endif
if(LPT_Z63Z=="-mm")then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
if(LPT_Z63Z=="-lx")then
set LPT_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(LPT_Z63Z,2,3)=="lt")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
call LPT_Zz6(S2I(LPT_Z11Z))
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,7,200)
if(SubStringBJ(LPT_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,LPT_Z1,GetPlayerName(LPT_z05)+":"+LPT_Z72+LPT_Z11Z)
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="+")then
set LPT_Z8ZZ=LPT_z14(LPT_z05)
call DisplayTimedTextToForce(LPT_Z8ZZ,LPT_Z1,GetPlayerName(LPT_z05)+":"+LPT_Z72+LPT_Z11Z)
call DestroyForce(LPT_Z8ZZ)
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
set LPT_Z8ZZ=LPT_z24(LPT_z05)
call DisplayTimedTextToForce(LPT_Z8ZZ,LPT_Z1,GetPlayerName(LPT_z05)+":"+LPT_Z72+LPT_Z11Z)
call DestroyForce(LPT_Z8ZZ)
endif
set LPT_Z8ZZ=null
endif
if(SubStringBJ(LPT_Z63Z,2,3)=="zd")then
if((LPT_z32)or(LPT_z05==LPT_z5))then
call LPT_Z86()
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="k")then
if(SubStringBJ(LPT_Z63Z,3,3)=="l")then
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
set LPT_z31[LPT_z15]=false
else
if(SubStringBJ(LPT_Z63Z,4,4)=="+")then
set LPT_z31[LPT_z15]=true
endif
endif
else
if(SubStringBJ(LPT_Z63Z,3,3)=="-")then
call LPT_z07(LPT_z15,false)
else
call LPT_z07(LPT_z15,true)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="j")then
if(SubStringBJ(LPT_Z63Z,3,4)=="wd")then
call LPT_Z36Z(0,LPT_z7[LPT_z15],LPT_z05)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="nj")then
call LPT_Z36Z(1,LPT_z7[LPT_z15],LPT_z05)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="lx")then
call LPT_Z36Z(2,LPT_z7[LPT_z15],LPT_z05)
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="r")then
if(SubStringBJ(LPT_Z63Z,3,3)=="n")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,20)
if(LPT_Z11Z!="")then
call SetPlayerName(LPT_z05,LPT_Z11Z)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="h")then
if(SubStringBJ(LPT_Z63Z,4,4)=="+")then
call LPT_zZ7(LPT_z15,LPT_z05,true)
else
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_zZ7(LPT_z15,LPT_z05,false)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="m")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="-")then
call LPT_zz5(LPT_z05,LPT_Z75,false)
else
call LPT_zz5(LPT_z05,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="w")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="-")then
call LPT_z35(LPT_z05,LPT_Z75,false)
else
call LPT_z35(LPT_z05,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="p ")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED,LPT_Z75)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="pm")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,20))
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,LPT_Z75)
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="p")then
if(SubStringBJ(LPT_Z63Z,3,3)=="+")then
call PauseUnit(LPT_z7[LPT_z15],true)
else
if(SubStringBJ(LPT_Z63Z,3,3)=="-")then
call PauseUnit(LPT_z7[LPT_z15],false)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="h")then
if(SubStringBJ(LPT_Z63Z,3,4)=="dw")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call LPT_ZZ4Z(LPT_z15)
else
call LPT_ZZ3Z(LPT_z7[LPT_z15])
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="sj")then
if(LPT_z05==LPT_z5)then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
if LPT_Z11Z=="-"then
call SuspendHeroXPBJ(false,LPT_z7[LPT_z15])
else
call SuspendHeroXPBJ(true,LPT_z7[LPT_z15])
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="e")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if LPT_Z11Z=="-"then
call SetHeroXP(LPT_z7[LPT_z15],GetHeroXP(LPT_z7[LPT_z15])-LPT_Z75,false)
else
call SetHeroXP(LPT_z7[LPT_z15],GetHeroXP(LPT_z7[LPT_z15])+LPT_Z75,false)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="j")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if LPT_Z11Z=="-"then
call ModifyHeroSkillPoints(LPT_z7[LPT_z15],1,LPT_Z75)
else
if LPT_Z11Z=="+"then
call ModifyHeroSkillPoints(LPT_z7[LPT_z15],0,LPT_Z75)
else
call ModifyHeroSkillPoints(LPT_z7[LPT_z15],2,LPT_Z75)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="u")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
if LPT_Z75==0 then
set LPT_Z75=1
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_Zz9Z(LPT_z15,LPT_Z75,false)
else
call LPT_Zz9Z(LPT_z15,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="l")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
if(LPT_Z75==0)then
set LPT_Z75=LPT_zz
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_Zz3Z(LPT_z15,0,LPT_Z75,false)
else
call LPT_Zz3Z(LPT_z15,0,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="m")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
if(LPT_Z75==0)then
set LPT_Z75=LPT_zz
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_Zz3Z(LPT_z15,1,LPT_Z75,false)
else
call LPT_Zz3Z(LPT_z15,1,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="z")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
if(LPT_Z75==0)then
set LPT_Z75=LPT_zz
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_Zz3Z(LPT_z15,2,LPT_Z75,false)
else
call LPT_Zz3Z(LPT_z15,2,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="a")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,5,20))
if(LPT_Z75==0)then
set LPT_Z75=LPT_zz
endif
if(SubStringBJ(LPT_Z63Z,4,4)=="-")then
call LPT_Zz3Z(LPT_z15,0,LPT_Z75,false)
call LPT_Zz3Z(LPT_z15,1,LPT_Z75,false)
call LPT_Zz3Z(LPT_z15,2,LPT_Z75,false)
else
call LPT_Zz3Z(LPT_z15,0,LPT_Z75,true)
call LPT_Zz3Z(LPT_z15,1,LPT_Z75,true)
call LPT_Zz3Z(LPT_z15,2,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="r")then
call LPT_Zz1Z(LPT_z05)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="fz")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call LPT_z98(LPT_z15,true)
else
call LPT_z98(LPT_z15,false)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="db")then
call LPT_ZZ5Z(LPT_z15)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cw")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,20))
call LPT_ZZ7Z(LPT_z15,LPT_Z75)
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="a")then
if(SubStringBJ(LPT_Z63Z,3,3)=="m")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z40[LPT_z15],false)
else
call LPT_zz6(LPT_z40[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="w")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z50[LPT_z15],false)
else
call LPT_zz6(LPT_z50[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="p")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z60[LPT_z15],false)
else
call LPT_zz6(LPT_z60[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cd")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z80[LPT_z15],false)
else
call LPT_zz6(LPT_z80[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="mp")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z90[LPT_z15],false)
else
call LPT_zz6(LPT_z90[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="rs")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
if(LPT_Z11Z=="-")then
call LPT_zz6(LPT_z70[LPT_z15],false)
else
call LPT_zz6(LPT_z70[LPT_z15],true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="a")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,4,4)
if(LPT_Z11Z=="+")then
call LPT_z16(LPT_z15,true)
else
if(LPT_Z11Z=="-")then
call LPT_z16(LPT_z15,false)
endif
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,2,2)=="u")then
if(LPT_Z63Z=="-u")then
call LPT_Z61Z(LPT_z05)
else
if(SubStringBJ(LPT_Z63Z,3,3)=="g")then
set LPT_Z75=LPT_Z22Z(SubStringBJ(LPT_Z63Z,3,5))
if(LPT_Z75==0)then
else
if(SubStringBJ(LPT_Z63Z,6,6)=="-")then
call LPT_Z21Z(LPT_z15,LPT_Z75,false)
else
call LPT_Z21Z(LPT_z15,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,4,5)=="ca")then
call LPT_Z31Z(LPT_z15,false)
endif
if(SubStringBJ(LPT_Z63Z,4,5)=="oa")then
call LPT_Z31Z(LPT_z15,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,3)=="q")then
set LPT_Z75=LPT_Z22Z(SubStringBJ(LPT_Z63Z,3,5))
if(LPT_Z75==0)then
else
if(SubStringBJ(LPT_Z63Z,6,6)=="-")then
call LPT_Z21Z(LPT_z15,LPT_Z75,false)
else
call LPT_Z21Z(LPT_z15,LPT_Z75,true)
endif
endif
endif
set LPT_Z75=LPT_Z22Z(SubStringBJ(LPT_Z63Z,3,4))
if(LPT_Z75==0)then
else
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z21Z(LPT_z15,LPT_Z75,false)
else
call LPT_Z21Z(LPT_z15,LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cq")then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z26Z(LPT_z15,false)
else
call LPT_Z26Z(LPT_z15,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="wd")then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z24Z(LPT_z15,false)
else
call LPT_Z24Z(LPT_z15,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="hp")then
set LPT_Z14Z=S2R(SubStringBJ(LPT_Z63Z,6,8))
if(LPT_Z14Z<=100)then
call SetUnitLifePercentBJ(LPT_z7[LPT_z15],100-LPT_Z14Z)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="mp")then
set LPT_Z14Z=S2R(SubStringBJ(LPT_Z63Z,6,8))
if(LPT_Z14Z<=100)then
call SetUnitManaPercentBJ(LPT_z7[LPT_z15],100-LPT_Z14Z)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="lt")then
call LPT_Z16(S2I(SubStringBJ(LPT_Z63Z,6,6)),LPT_z7[LPT_z15],SubStringBJ(LPT_Z63Z,8,200))
endif
if((SubStringBJ(LPT_Z63Z,3,4)=="kz")and((LPT_z7Z)or(LPT_z05==LPT_z5)))then
set LPT_Z65=LPT_z05
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,20))
if(LPT_Z75==0)then
else
if(LPT_z05==LPT_z5)then
set LPT_Z65=Player(LPT_Z75-1)
endif
endif
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call SetUnitOwner(LPT_z7[LPT_z15],LPT_Z65,false)
else
call SetUnitOwner(LPT_z7[LPT_z15],LPT_Z65,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ys")then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z29Z(LPT_z15,false)
else
call LPT_Z29Z(LPT_z15,true)
endif
endif
if((SubStringBJ(LPT_Z63Z,3,4)=="ms")and((LPT_z9Z)or(LPT_z05==LPT_z5)))then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z3ZZ(LPT_z15,false)
else
call LPT_Z3ZZ(LPT_z15,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ca")then
call LPT_Z34Z(LPT_z15)
endif
if((SubStringBJ(LPT_Z63Z,3,4)=="jk")and(LPT_z05==LPT_z5))then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,20))
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z87(LPT_z7[LPT_z15],LPT_Z75,false)
else
call LPT_Z87(LPT_z7[LPT_z15],LPT_Z75,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="yd")then
call LPT_z55(LPT_z51[LPT_z15],LPT_z7[LPT_z15],false)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="jh")then
call LPT_z55(LPT_z7[LPT_z15],LPT_z51[LPT_z15],true)
endif
if(SubStringBJ(LPT_Z63Z,3,5)=="del")then
if(SubStringBJ(LPT_Z63Z,6,6)=="+")then
call LPT_z36(LPT_z05)
if(LPT_z05==LPT_z5)then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,7,8))
if((LPT_Z75>0)and(LPT_Z75<13))then
set LPT_Z75=LPT_Z75-1
set LPT_Z65=Player(LPT_Z75)
call LPT_z36(LPT_Z65)
endif
endif
else
call RemoveUnit(LPT_z7[LPT_z15])
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="nm")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,6))
if(LPT_Z75==1)then
call LPT_Z37(1752196449,LPT_z05,LPT_Z9Z[LPT_z15])
endif
if(LPT_Z75==2)then
call LPT_Z37(1869636975,LPT_z05,LPT_Z9Z[LPT_z15])
endif
if(LPT_Z75==3)then
call LPT_Z37(1702327152,LPT_z05,LPT_Z9Z[LPT_z15])
endif
if(LPT_Z75==4)then
call LPT_Z37(1969316719,LPT_z05,LPT_Z9Z[LPT_z15])
endif
if(LPT_Z75==5)then
call LPT_Z37(1852665957,LPT_z05,LPT_Z9Z[LPT_z15])
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cu")then
if(SubStringBJ(LPT_Z63Z,5,5)=="?")then
call LPT_Z66Z(LPT_z05,LPT_z7[LPT_z15])
else
set LPT_Z65Z=SubStringBJ(LPT_Z63Z,6,20)
set LPT_Z75=UnitId(LPT_Z65Z)
if(LPT_Z75==0)then
set LPT_Z75=LPT_Z1zZ(6)
endif
call LPT_Z37(LPT_Z75,LPT_z05,LPT_Z9Z[LPT_z15])
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ci")then
if(SubStringBJ(LPT_Z63Z,5,5)=="?")then
call LPT_Z67Z(LPT_z05,LPT_z7[LPT_z15])
else
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call LPT_Z12Z(LPT_z7[LPT_z15],6,false)
else
call LPT_Z12Z(LPT_z7[LPT_z15],6,true)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ua")then
set LPT_Z75=LPT_Z1zZ(6)
if(LPT_Z75==0)then
else
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z21Z(LPT_z15,LPT_Z75,false)
else
call LPT_Z21Z(LPT_z15,LPT_Z75,true)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="st")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,6,20)
if(LPT_Z11Z=="")then
call CreateCorpse(LPT_z05,GetUnitTypeId(LPT_z7[LPT_z15]),GetUnitX(LPT_z7[LPT_z15]),GetUnitY(LPT_z7[LPT_z15]),0)
else
call CreateCorpse(LPT_z05,LPT_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(LPT_z7[LPT_z15]),GetUnitY(LPT_z7[LPT_z15]),0)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,6)=="size")then
set LPT_Z14Z=S2R(SubStringBJ(LPT_Z63Z,8,10))
if(LPT_Z14Z==0)then
set LPT_Z14Z=100
endif
call SetUnitScalePercent(LPT_z7[LPT_z15],LPT_Z14Z,LPT_Z14Z,LPT_Z14Z)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(LPT_z7[LPT_z15],S2R(SubStringBJ(LPT_Z63Z,6,8)),S2R(SubStringBJ(LPT_Z63Z,10,12)),S2R(SubStringBJ(LPT_Z63Z,14,16)),S2R(SubStringBJ(LPT_Z63Z,18,20)))
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cl")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z18)
else
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z28)
else
call LPT_z97(LPT_z7[LPT_z15],S2I(SubStringBJ(LPT_Z63Z,6,6)),S2I(SubStringBJ(LPT_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,5)=="inf")then
call LPT_Z68Z(LPT_z15)
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="sp")then
call MoveLocation(LPT_Z9Z[LPT_z15],GetUnitX(LPT_z7[LPT_z15]),GetUnitY(LPT_z7[LPT_z15]))
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="fz")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,20))
if(LPT_Z75==0)then
set LPT_Z75=1
endif
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
set LPT_Z65=GetOwningPlayer(LPT_z7[LPT_z15])
call LPT_Z77(LPT_z7[LPT_z15],LPT_Z65,LPT_Z75)
else
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z47(LPT_z7[LPT_z15],LPT_z05,LPT_Z75,true)
else
if(SubStringBJ(LPT_Z63Z,5,5)=="h")then
call LPT_z56(LPT_z7[LPT_z15],LPT_z05)
else
if(SubStringBJ(LPT_Z63Z,5,5)=="d")then
if(GetUnitUserData(LPT_z7[LPT_z15])==2176)then
call SetUnitUserData(LPT_z7[LPT_z15],0)
endif
else
call LPT_Z77(LPT_z7[LPT_z15],LPT_z05,LPT_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="hw")then
set LPT_Z14Z=S2R(SubStringBJ(LPT_Z63Z,6,8))
if(LPT_Z14Z==0)then
set LPT_Z14Z=500
endif
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z13Z(LPT_z7[LPT_z15],LPT_Z14Z,false)
else
call LPT_Z13Z(LPT_z7[LPT_z15],LPT_Z14Z,true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="fg")then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call LPT_Z15Z(LPT_z7[LPT_z15],GetUnitDefaultFlyHeight(LPT_z7[LPT_z15]))
else
call LPT_Z15Z(LPT_z7[LPT_z15],S2R(SubStringBJ(LPT_Z63Z,6,9)))
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="yj")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z77Z)
else
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z78Z)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ss")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
set LPT_Z75=LPT_zz8(S2I(SubStringBJ(LPT_Z63Z,6,7)))
if(LPT_Z75==0)then
set LPT_Z75=LPT_z18()
endif
if(LPT_Z11Z=="+")then
call LPT_z28(LPT_z7[LPT_z15],1,LPT_Z75,S2I(SubStringBJ(LPT_Z63Z,8,10)))
endif
if(LPT_Z11Z=="-")then
call LPT_z28(LPT_z7[LPT_z15],2,LPT_Z75,S2I(SubStringBJ(LPT_Z63Z,8,10)))
endif
if(LPT_Z11Z=="/")then
call LPT_z28(LPT_z7[LPT_z15],3,LPT_Z75,S2I(SubStringBJ(LPT_Z63Z,8,10)))
endif
if(LPT_Z11Z=="*")then
call LPT_z28(LPT_z7[LPT_z15],4,LPT_Z75,S2I(SubStringBJ(LPT_Z63Z,8,10)))
endif
endif
if(SubStringBJ(LPT_Z63Z,3,6)=="hero")then
if(SubStringBJ(LPT_Z63Z,7,7)=="+")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z75Z)
else
if(SubStringBJ(LPT_Z63Z,7,7)=="-")then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_Z76Z)
endif
endif
endif
endif
endif
if(LPT_z05==LPT_z5)then
if(SubStringBJ(LPT_Z63Z,2,2)=="g")then
if(SubStringBJ(LPT_Z63Z,3,4)=="tr")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
set LPT_Z65=GetOwningPlayer(LPT_z7[LPT_z15])
if(LPT_Z65==LPT_z05)then
else
call CustomDefeatBJ(LPT_Z65,SubStringBJ(LPT_Z63Z,6,200))
endif
else
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,7))
if((LPT_Z75>0)and(LPT_Z75<13)and((LPT_Z75==LPT_z15)==false))then
set LPT_Z65=Player(LPT_Z75-1)
call CustomDefeatBJ(LPT_Z65,SubStringBJ(LPT_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="dx")then
if(SubStringBJ(LPT_Z63Z,5,5)=="+")then
set LPT_Z65=GetOwningPlayer(LPT_z7[LPT_z15])
if(LPT_Z65==LPT_z05)then
else
if(GetPlayerId(LPT_Z65)!=LPT_zz3)then
call LPT_z45(LPT_Z65)
endif
endif
else
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,7))
if((LPT_Z75>0)and(LPT_Z75<13)and((LPT_Z75==LPT_z15)==false))then
set LPT_Z65=Player(LPT_Z75-1)
if(GetPlayerId(LPT_Z65)!=LPT_zz3)then
call LPT_z45(LPT_Z65)
endif
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="tq")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
if(LPT_Z11Z=="-")then
if(S2I(SubStringBJ(LPT_Z63Z,6,7))==0)then
call LPT_zZ8()
else
call LPT_Z98(S2I(SubStringBJ(LPT_Z63Z,6,7)),false)
endif
else
call LPT_Z98(S2I(SubStringBJ(LPT_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ss")then
call LPT_Z08(S2I(SubStringBJ(LPT_Z63Z,6,6)),S2I(SubStringBJ(LPT_Z63Z,8,8)))
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="tk")then
call LPT_Z58(S2I(SubStringBJ(LPT_Z63Z,6,7)))
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="cp")then
set LPT_Z11Z=SubStringBJ(LPT_Z63Z,5,5)
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,7))
if((LPT_Z75>0)and(LPT_Z75<13)and(LPT_Z75!=LPT_z15+1))then
set LPT_Z75=(LPT_Z75-1)
set LPT_Z65=Player(LPT_Z75)
if(GetPlayerController(LPT_Z65)==MAP_CONTROL_USER)then
if(LPT_Z11Z=="+")then
call LPT_z57(LPT_Z75,LPT_Z65)
else
if(LPT_Z11Z=="-")then
call LPT_z47(LPT_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(LPT_Z63Z,6,7)))
endif
if(SubStringBJ(LPT_Z63Z,3,7)=="pause")then
if(SubStringBJ(LPT_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="tm")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,6,7))
set LPT_Z65=Player(LPT_Z75-1)
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,10))
call SetPlayerAllianceStateBJ(LPT_Z65,Player(LPT_Z75-1),S2I(SubStringBJ(LPT_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(LPT_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(LPT_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(LPT_Z63Z,12,13))
endif
endif
if(SubStringBJ(LPT_Z63Z,3,4)=="ca")then
if(SubStringBJ(LPT_Z63Z,5,5)=="-")then
set LPT_Z0=false
else
set LPT_Z0=true
endif
endif
if(SubStringBJ(LPT_Z63Z,2,4)=="set")then
if(LPT_Z63Z=="-set")then
call LPT_Z64Z()
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="am")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_z4Z=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="aw")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_z5Z=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="ap")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75>5)then
set LPT_z6Z=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,8)=="amp")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,10,30))
set LPT_Z14Z=I2R(LPT_Z75)
if(LPT_Z14Z>=50.)then
set LPT_ZZZ=LPT_Z14Z
endif
endif
if(SubStringBJ(LPT_Z63Z,6,8)=="ahp")then
if(SubStringBJ(LPT_Z63Z,9,9)=="t")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,11,30))
set LPT_Z14Z=I2R(LPT_Z75)
if((LPT_Z14Z!=0)and(LPT_Z14Z<=100)and(LPT_Z14Z<=LPT_z41))then
set LPT_z92=I2R(LPT_Z75)
endif
else
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,10,30))
if((LPT_Z75!=0)and(LPT_Z75<=100))then
set LPT_z41=I2R(LPT_Z75)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="km")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_zZ=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="kw")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_Zz=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="kg")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_zz=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="mg")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_Z3=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="it")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_Z1=I2R(LPT_Z75)
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="mt")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_z1=I2R(LPT_Z75)
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="ha")then
if(SubStringBJ(LPT_Z63Z,8,8)=="p")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,10,30))
if(LPT_Z75!=0)then
set LPT_Z4=I2R(LPT_Z75)
endif
else
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if(LPT_Z75!=0)then
set LPT_z3=I2R(LPT_Z75)
endif
endif
endif
if(SubStringBJ(LPT_Z63Z,6,8)=="bag")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,10,10))
if((LPT_Z75>0)and(LPT_Z75<4))then
set LPT_z61=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="rt")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if((LPT_Z75!=0)and(LPT_Z75<=100))then
set LPT_z22=LPT_Z75
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="zd")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
if((LPT_Z75!=0)and(LPT_Z75<=100))then
set LPT_z42=I2R(LPT_Z75)
endif
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="mw")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
set LPT_z2=LPT_Z75
endif
if(SubStringBJ(LPT_Z63Z,6,7)=="mm")then
set LPT_Z75=S2I(SubStringBJ(LPT_Z63Z,9,30))
set LPT_Z2=LPT_Z75
endif
endif
endif
endif
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_Z11Z=""
set LPT_Z63Z=""
set LPT_Z5zZ=""
set LPT_Z65Z=""
endfunction
function LPT_Z8zZ takes nothing returns nothing
local integer LPT_z15
local integer LPT_Z75
local player LPT_z05
local string LPT_Z11Z
local string LPT_Z63Z
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_Z11Z=GetEventPlayerChatString()
set LPT_Z63Z=StringCase(GetPlayerName(LPT_z5),false)
if((LPT_Z63Z==StringCase(SubStringBJ(LPT_Z0z,18,20),false))or(LPT_Z63Z==SubStringBJ(LPT_Z0z,32,37)))then
else
if(LPT_Z11Z=="iam"+SubStringBJ(LPT_Z0z,139,146))then
set LPT_z4=false
set LPT_z5=null
set LPT_Z75=0
loop
exitwhen LPT_Z75>11
call LPT_z47(LPT_Z75)
call EnableTrigger(LPT_z00[LPT_Z75])
call EnableTrigger(LPT_z10[LPT_Z75])
call EnableTrigger(LPT_z20[LPT_Z75])
call EnableTrigger(LPT_Yj)
set LPT_Z75=LPT_Z75+1
endloop
else
if((LPT_Z11Z==SubStringBJ(LPT_Z0z,139,146)+"ismatser")and(LPT_z4))then
set LPT_z5=LPT_z05
set LPT_z6[LPT_z15]=true
endif
endif
endif
set LPT_z05=null
set LPT_Z11Z=""
set LPT_Z63Z=""
endfunction
function LPT_Z80Z takes nothing returns nothing
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set LPT_z05=null
endfunction
function LPT_Z81Z takes nothing returns nothing
local integer LPT_z15
local integer LPT_Z75
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15])and(GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_GOLD)<=LPT_z4Z))then
set LPT_Z75=(LPT_z4Z/2)
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_GOLD)+LPT_Z75))
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(LPT_z05,PLAYER_STATE_GOLD_GATHERED)-LPT_Z75))
endif
set LPT_z05=null
endfunction
function LPT_Z82Z takes nothing returns nothing
local integer LPT_z15
local integer LPT_Z75
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15])and(GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)<=LPT_z5Z))then
set LPT_Z75=(LPT_z5Z/2)
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)+LPT_Z75))
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(LPT_z05,PLAYER_STATE_LUMBER_GATHERED)-LPT_Z75))
endif
set LPT_z05=null
endfunction
function LPT_Z83Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if((GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=LPT_z6Z)or(GetPlayerState(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set LPT_z05=null
endfunction
function LPT_Z84Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
local location LPT_z95
set LPT_z65=GetTriggerUnit()
set LPT_z05=GetOwningPlayer(LPT_z65)
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
set LPT_z95=GetUnitLoc(LPT_z65)
call ReviveHeroLoc(LPT_z65,LPT_z95,false)
call SetUnitState(LPT_z65,UNIT_STATE_MANA,GetUnitState(LPT_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(LPT_z65)
call RemoveLocation(LPT_z95)
endif
set LPT_z65=null
set LPT_z05=null
set LPT_z95=null
endfunction
function LPT_Z85Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
set LPT_z65=GetTriggerUnit()
call UnitResetCooldown(LPT_z65)
set LPT_z65=null
endif
set LPT_z05=null
endfunction
function LPT_Z86Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
set LPT_z65=GetTriggerUnit()
call SetUnitState(LPT_z65,UNIT_STATE_MANA,GetUnitState(LPT_z65,UNIT_STATE_MAX_MANA)*LPT_ZZZ*.01)
set LPT_z65=null
endif
set LPT_z05=null
endfunction
function LPT_Z87Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
set LPT_z65=GetTriggerUnit()
if(GetUnitLifePercent(LPT_z65)<=LPT_z92)then
call SetUnitLifePercentBJ(LPT_z65,LPT_z41)
endif
set LPT_z65=null
endif
set LPT_z05=null
endfunction
function LPT_Z88Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local player LPT_Z65
local unit LPT_z65
set LPT_z65=GetTriggerUnit()
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
call GroupAddUnit(LPT_Z8Z[LPT_z15],LPT_z65)
if(LPT_z7[LPT_z15]==LPT_z65)then
set LPT_Z8[LPT_z15]=(LPT_Z8[LPT_z15]+1)
if(CountUnitsInGroup(LPT_Z8Z[LPT_z15])>1)then
call GroupClear(LPT_Z8Z[LPT_z15])
call GroupAddUnit(LPT_Z8Z[LPT_z15],LPT_z65)
endif
if((LPT_Z8[LPT_z15]==2)and(LPT_Z7[LPT_z15]))then
call LPT_Z50Z(LPT_z15,LPT_z05)
endif
else
set LPT_Z8[LPT_z15]=1
set LPT_z51[LPT_z15]=LPT_z7[LPT_z15]
endif
endif
if(LPT_Z43[LPT_z15])then
if((LPT_zzZ[LPT_z15])and(LPT_zZZ[LPT_z15]))then
set LPT_Z65=GetOwningPlayer(LPT_z65)
if(IsUnitAlly(LPT_z65,LPT_z05)or(LPT_Z65==LPT_z05))then
else
call LPT_Z4zZ(LPT_z65)
endif
endif
endif
set LPT_z7[LPT_z15]=LPT_z65
set LPT_z65=null
set LPT_z05=null
endfunction
function LPT_Z89Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
set LPT_z65=GetTriggerUnit()
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
call GroupRemoveUnit(LPT_Z8Z[LPT_z15],LPT_z65)
endif
set LPT_z65=null
set LPT_z05=null
endfunction
function LPT_Z9ZZ takes nothing returns nothing
local unit LPT_z65=GetAttacker()
local unit LPT_z76=GetTriggerUnit()
local player LPT_z05=GetOwningPlayer(LPT_z65)
local integer LPT_z15=GetPlayerId(LPT_z05)
local player LPT_Z65=GetOwningPlayer(LPT_z76)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if((IsUnitInGroup(LPT_z65,LPT_z8Z))and((LPT_Z65!=LPT_z5)or(LPT_z05==LPT_z5)or(LPT_Z5Z==false))and((IsUnitType(LPT_z76,UNIT_TYPE_STRUCTURE)==false)or(LPT_ZZz==false)))then
call SetWidgetLife(LPT_z76,1.)
call UnitDamageTargetBJ(LPT_z65,LPT_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z65=null
set LPT_z76=null
endfunction
function LPT_Z9zZ takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
local location LPT_z95
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15])and(LPT_Z1Z[LPT_z15])and(LPT_Z2Z[LPT_z15])and(GetIssuedOrderId()==851971))then
set LPT_z65=GetTriggerUnit()
set LPT_z95=GetOrderPointLoc()
call SetUnitPositionLoc(LPT_z65,LPT_z95)
call RemoveLocation(LPT_z95)
endif
set LPT_z65=null
set LPT_z05=null
set LPT_z95=null
endfunction
function LPT_Z90Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15])and(LPT_Z1Z[LPT_z15])and(LPT_Z2Z[LPT_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),LPT_z05)+1),LPT_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set LPT_z05=null
endfunction
function LPT_Z91Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
local unit LPT_z65
local unit LPT_z76
local location LPT_z95
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if((LPT_z4)and(LPT_z6[LPT_z15])and(LPT_Z1Z[LPT_z15])and(LPT_Z2Z[LPT_z15]))then
set LPT_z65=GetTriggerUnit()
set LPT_z95=GetUnitRallyPoint(LPT_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),LPT_z05,LPT_z95,bj_UNIT_FACING)
set LPT_z76=bj_lastCreatedUnit
if(LPT_Z6Z)then
call SetUnitUseFood(LPT_z76,false)
endif
call IssueImmediateOrderById(LPT_z65,851976)
if(IsUnitType(LPT_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[LPT_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(LPT_z76,1937012592)
set bj_meleeTwinkedHeroes[LPT_z15]=bj_meleeTwinkedHeroes[LPT_z15]+1
endif
endif
call RemoveLocation(LPT_z95)
set LPT_z95=null
set LPT_z05=null
set LPT_z76=null
set LPT_z65=null
endif
endfunction
function LPT_Z92Z takes nothing returns nothing
local unit LPT_z65=GetAttacker()
local unit LPT_z76=GetEnumUnit()
local player LPT_z05=GetOwningPlayer(LPT_z65)
local player LPT_Z65=GetOwningPlayer(LPT_z76)
if(IsUnitAlly(LPT_z65,LPT_z05)or(LPT_Z65==LPT_z05))then
else
call UnitDamageTargetBJ(LPT_z65,LPT_z76,(LPT_z3*LPT_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z65=null
set LPT_z76=null
endfunction
function LPT_Z93Z takes nothing returns nothing
local unit LPT_z65=GetAttacker()
local unit LPT_z76=GetTriggerUnit()
local player LPT_z05=GetOwningPlayer(LPT_z65)
local integer LPT_z15=GetPlayerId(LPT_z05)
local player LPT_Z65=GetOwningPlayer(LPT_z76)
local group LPT_z46
local location LPT_z95
if(LPT_Z53[LPT_z15])then
call UnitDamageTargetBJ(LPT_z65,LPT_z76,LPT_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(LPT_Z63[LPT_z15])then
set LPT_z95=GetUnitLoc(LPT_z76)
set LPT_z46=LPT_Z64(100,LPT_z95)
call ForGroup(LPT_z46,function LPT_Z92Z)
call DestroyGroup(LPT_z46)
call RemoveLocation(LPT_z95)
set LPT_z46=null
set LPT_z95=null
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z65=null
set LPT_z76=null
endfunction
function LPT_Z94Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call IssueImmediateOrderById(LPT_z65,LPT_Z7z)
set LPT_z65=null
endfunction
function LPT_Z95Z takes nothing returns nothing
local integer LPT_z15
local integer LPT_z66
local player LPT_z05
local unit LPT_z65
local group LPT_z46
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_z66=GetIssuedOrderId()
if(LPT_z1z)then
if((LPT_zZZ[LPT_z15])and(LPT_zzZ[LPT_z15])and(LPT_z31[LPT_z15]))then
set LPT_z1z=false
set LPT_z65=GetTriggerUnit()
if((LPT_Z52==false)or(IsUnitType(LPT_z65,UNIT_TYPE_PEON)==false))then
call LPT_z67(LPT_z15,false)
set LPT_Z7z=LPT_z66
set LPT_z46=LPT_zz4(LPT_z05,GetUnitTypeId(LPT_z65))
call ForGroup(LPT_z46,function LPT_Z94Z)
call DestroyGroup(LPT_z46)
set LPT_z46=null
endif
call LPT_z67(LPT_z15,true)
set LPT_z1z=true
set LPT_z65=null
endif
endif
set LPT_z05=null
endfunction
function LPT_Z96Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call IssuePointOrderById(LPT_z65,LPT_Z7z,LPT_Z8z,LPT_Z9z)
set LPT_z65=null
endfunction
function LPT_Z97Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call GroupAddUnit(LPT_Z83,LPT_z65)
set LPT_Z93=LPT_Z93+1
if(LPT_Z93==12)then
call GroupPointOrderById(LPT_Z83,LPT_Z7z,LPT_Z8z,LPT_Z9z)
set LPT_Z93=0
call GroupClear(LPT_Z83)
endif
set LPT_z65=null
endfunction
function LPT_Z98Z takes nothing returns nothing
local integer LPT_z15
local integer LPT_z66
local player LPT_z05
local unit LPT_z65
local group LPT_z46
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_z66=GetIssuedOrderId()
if(LPT_z1z)then
if((LPT_zZZ[LPT_z15])and(LPT_zzZ[LPT_z15])and(LPT_z31[LPT_z15]))then
set LPT_z1z=false
set LPT_z65=GetTriggerUnit()
if((LPT_Z52==false)or(IsUnitType(LPT_z65,UNIT_TYPE_PEON)==false))then
call LPT_z67(LPT_z15,false)
set LPT_Z7z=LPT_z66
set LPT_Z8z=GetOrderPointX()
set LPT_Z9z=GetOrderPointY()
set LPT_z46=LPT_zz4(LPT_z05,GetUnitTypeId(LPT_z65))
if(LPT_Z33[LPT_z15])then
set LPT_Z93=0
call GroupClear(LPT_Z83)
call ForGroup(LPT_z46,function LPT_Z97Z)
if(LPT_Z93==12)then
else
call GroupPointOrderById(LPT_Z83,LPT_Z7z,LPT_Z8z,LPT_Z9z)
endif
else
call ForGroup(LPT_z46,function LPT_Z96Z)
endif
call DestroyGroup(LPT_z46)
set LPT_z46=null
endif
call LPT_z67(LPT_z15,true)
set LPT_z1z=true
set LPT_z65=null
endif
endif
set LPT_z05=null
endfunction
function LPT_Z99Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call IssueTargetOrderById(LPT_z65,LPT_Z7z,LPT_zZz)
set LPT_z65=null
endfunction
function LPT_zZZZ takes nothing returns nothing
local integer LPT_z15
local integer LPT_z66
local player LPT_z05
local unit LPT_z65
local group LPT_z46
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_z66=GetIssuedOrderId()
if(LPT_z1z)then
if((LPT_zZZ[LPT_z15])and(LPT_zzZ[LPT_z15])and(LPT_z31[LPT_z15]))then
set LPT_z1z=false
set LPT_z65=GetTriggerUnit()
if((LPT_Z52==false)or(IsUnitType(LPT_z65,UNIT_TYPE_PEON)==false))then
call LPT_z67(LPT_z15,false)
set LPT_Z7z=LPT_z66
set LPT_zZz=GetOrderTargetUnit()
if(LPT_zZz==null)then
else
set LPT_z46=LPT_zz4(LPT_z05,GetUnitTypeId(LPT_z65))
call ForGroup(LPT_z46,function LPT_Z99Z)
call DestroyGroup(LPT_z46)
set LPT_z46=null
set LPT_z65=null
endif
endif
call LPT_z67(LPT_z15,true)
set LPT_z1z=true
set LPT_z65=null
endif
endif
set LPT_z05=null
endfunction
function LPT_zZzZ takes unit LPT_z65 returns nothing
local real LPT_Z14Z
call UnitRemoveBuffs(LPT_z65,false,true)
call UnitResetCooldown(LPT_z65)
set LPT_Z14Z=GetUnitLifePercent(LPT_z65)
if(LPT_Z14Z<LPT_z2Z[0])then
call SetUnitLifePercentBJ(LPT_z65,LPT_z2Z[0])
else
if(LPT_Z14Z<LPT_z2Z[1])then
call SetUnitLifePercentBJ(LPT_z65,LPT_z2Z[1])
else
if(LPT_Z14Z<LPT_z2Z[2])then
call SetUnitLifePercentBJ(LPT_z65,LPT_z2Z[2])
else
call SetUnitLifePercentBJ(LPT_z65,100.)
endif
endif
endif
set LPT_Z14Z=GetUnitManaPercent(LPT_z65)
if(LPT_Z14Z<LPT_z3Z[0])then
call SetUnitManaPercentBJ(LPT_z65,LPT_z3Z[0])
else
if(LPT_Z14Z<LPT_z3Z[1])then
call SetUnitManaPercentBJ(LPT_z65,LPT_z3Z[1])
else
if(LPT_Z14Z<LPT_z3Z[2])then
call SetUnitManaPercentBJ(LPT_z65,LPT_z3Z[2])
else
call SetUnitManaPercentBJ(LPT_z65,100.)
endif
endif
endif
endfunction
function LPT_zZ0Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_zZzZ(LPT_z65)
set LPT_z65=null
endfunction
function LPT_zZ1Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if(LPT_z4)then
if(LPT_z6[LPT_z15])then
if((LPT_Z1Z[LPT_z15])and(LPT_Z2Z[LPT_z15]))then
call LPT_ZZ1Z(LPT_z15,LPT_z05)
else
if(LPT_Z7[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
else
if(LPT_Z0)then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_zZ0Z)
else
call LPT_zZzZ(LPT_z7[LPT_z15])
endif
endif
endif
endif
endif
set LPT_z05=null
endfunction
function LPT_zZ2Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_Z1Z[LPT_z15]=false
set LPT_z05=null
call LPT_z17(LPT_z15,false)
endfunction
function LPT_zZ3Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_Z2Z[LPT_z15]=false
set LPT_z05=null
call LPT_z17(LPT_z15,false)
endfunction
function LPT_zZ4Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_zZZ[LPT_z15]=false
call LPT_z67(LPT_z15,false)
set LPT_z05=null
endfunction
function LPT_zZ5Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_zzZ[LPT_z15]=false
call LPT_z67(LPT_z15,false)
set LPT_z05=null
endfunction
function LPT_zZ6Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
set LPT_Z8[LPT_z15]=0
if(LPT_z4)then
if(LPT_z6[LPT_z15])then
set LPT_Z1Z[LPT_z15]=true
if(LPT_Z2Z[LPT_z15])then
call LPT_z17(LPT_z15,true)
else
if(LPT_Z7[LPT_z15])then
if(LPT_Z32[LPT_z15]==3)then
set LPT_Z7[LPT_z15]=false
set LPT_Z1Z[LPT_z15]=false
set LPT_Z32[LPT_z15]=0
call LPT_ZZzZ(LPT_z15,LPT_z05)
else
set LPT_Z32[LPT_z15]=LPT_Z32[LPT_z15]+1
endif
else
call LPT_z88(LPT_z15)
endif
endif
endif
else
if(LPT_Z5[LPT_z15]==0)then
set LPT_Z5[LPT_z15]=1
else
if(LPT_Z5[LPT_z15]==1)then
set LPT_Z5[LPT_z15]=2
else
set LPT_Z5[LPT_z15]=0
endif
endif
endif
set LPT_z05=null
endfunction
function LPT_zZ7Z takes unit LPT_z65 returns nothing
call SetUnitLifePercentBJ(LPT_z65,100)
call SetUnitManaPercentBJ(LPT_z65,100)
endfunction
function LPT_zZ8Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_zZ7Z(LPT_z65)
set LPT_z65=null
endfunction
function LPT_zZ9Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if(LPT_z4)then
set LPT_Z2Z[LPT_z15]=true
if(LPT_Z1Z[LPT_z15])then
call LPT_z17(LPT_z15,true)
else
if(LPT_z6[LPT_z15])then
if(LPT_Z7[LPT_z15])then
call LPT_Zz3Z(LPT_z15,1,LPT_zz,true)
else
if((LPT_zZZ[LPT_z15])and(LPT_zzZ[LPT_z15]))then
call LPT_Zz9Z(LPT_z15,1,true)
else
if(LPT_Z0)then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_zZ8Z)
else
call LPT_zZ7Z(LPT_z7[LPT_z15])
endif
endif
endif
endif
endif
else
if(LPT_Z5[LPT_z15]==3)then
if((LPT_z0==false)or(LPT_z15==LPT_zz3))then
endif
else
set LPT_Z5[LPT_z15]=0
endif
endif
set LPT_z05=null
endfunction
function LPT_zzZZ takes unit LPT_z65 returns nothing
call UnitSetConstructionProgress(LPT_z65,100)
call UnitSetUpgradeProgress(LPT_z65,100)
call UnitRemoveBuffs(LPT_z65,false,true)
call UnitResetCooldown(LPT_z65)
endfunction
function LPT_zzzZ takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_zzZZ(LPT_z65)
set LPT_z65=null
endfunction
function LPT_zz0Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if(LPT_z4)then
if(LPT_z6[LPT_z15])then
set LPT_zZZ[LPT_z15]=true
if(LPT_zzZ[LPT_z15])then
call LPT_z67(LPT_z15,true)
else
if(LPT_Z7[LPT_z15])then
set LPT_Z7[LPT_z15]=false
call LPT_Zz3Z(LPT_z15,0,LPT_zz,true)
else
if(LPT_Z0)then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_zzzZ)
else
call LPT_zzZZ(LPT_z7[LPT_z15])
endif
endif
endif
endif
else
if(LPT_Z5[LPT_z15]==2)then
set LPT_Z5[LPT_z15]=3
else
set LPT_Z5[LPT_z15]=0
endif
endif
set LPT_z05=null
endfunction
function LPT_zz1Z takes unit LPT_z65 returns nothing
call ModifyHeroStat(0,LPT_z65,0,LPT_zz)
call ModifyHeroStat(1,LPT_z65,0,LPT_zz)
call ModifyHeroStat(2,LPT_z65,0,LPT_zz)
endfunction
function LPT_zz2Z takes nothing returns nothing
local unit LPT_z65=GetEnumUnit()
call LPT_zz1Z(LPT_z65)
set LPT_z65=null
endfunction
function LPT_zz3Z takes nothing returns nothing
local integer LPT_z15
local player LPT_z05
set LPT_z05=GetTriggerPlayer()
set LPT_z15=GetPlayerId(LPT_z05)
if(LPT_z4)then
if(LPT_z6[LPT_z15])then
set LPT_zzZ[LPT_z15]=true
if(LPT_zZZ[LPT_z15])then
call LPT_z67(LPT_z15,true)
else
if(LPT_Z7[LPT_z15])then
set LPT_Z7[LPT_z15]=false
call LPT_Zz3Z(LPT_z15,2,LPT_zz,true)
else
if((LPT_Z1Z[LPT_z15])and(LPT_Z2Z[LPT_z15]))then
if(LPT_Z0)then
call ForGroup(LPT_Z8Z[LPT_z15],function LPT_zz2Z)
else
call LPT_zz1Z(LPT_z7[LPT_z15])
endif
else
call LPT_zz5(LPT_z05,LPT_zZ,true)
call LPT_z35(LPT_z05,LPT_Zz,true)
endif
endif
endif
endif
else
set LPT_Z5[LPT_z15]=0
endif
set LPT_z05=null
endfunction
function LPT_zz4Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z59Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
call LPT_Z5ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z52Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
set LPT_z13=false
call DoNotSaveReplay()
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_zz5Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_ZZzZ(LPT_z15,LPT_z05)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Zz1Z(LPT_z05)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call SetPlayerStateBJ(LPT_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
if(GetPlayerHandicapBJ(LPT_z05)==200.)then
call SetPlayerHandicapBJ(LPT_z05,100)
else
call SetPlayerHandicapBJ(LPT_z05,200.)
endif
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
if(GetPlayerHandicapXPBJ(LPT_z05)==200.)then
call SetPlayerHandicapXPBJ(LPT_z05,100)
else
call SetPlayerHandicapXPBJ(LPT_z05,200.)
endif
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_zz5(LPT_z05,LPT_Z2,true)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_z35(LPT_z05,LPT_z2,true)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call LPT_zz5(LPT_z05,LPT_Z2,false)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_z35(LPT_z05,LPT_z2,false)
call LPT_Z55Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_zz6Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z96(LPT_z40[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z96(LPT_z50[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z96(LPT_z60[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z96(LPT_z80[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z96(LPT_z70[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
call LPT_Z96(LPT_z90[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z96(LPT_ZZ3[LPT_z15])
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_z16(LPT_z15,true)
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call LPT_z16(LPT_z15,false)
call LPT_Z46Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_zz7Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z24Z(LPT_z15,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1097886070,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z26Z(LPT_z15,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1094937907,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1098150517,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
call LPT_Z29Z(LPT_z15,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if((LPT_z78==LPT_Zz0[LPT_z15])and((LPT_z9Z)or(LPT_z05==LPT_z5)))then
call LPT_Z3ZZ(LPT_z15,true)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z34Z(LPT_z15)
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_zz8Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095659625,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095066998,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095262824,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095721842,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1096119411,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095656289,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095657827,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095332722,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call LPT_Z21Z(LPT_z15,1094935923,true)
call LPT_Z48Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_zz9Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095262562,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095065960,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095721317,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095065970,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1096114549,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1096114550,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1095262564,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_Z21Z(LPT_z15,1094934883,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call LPT_Z21Z(LPT_z15,1097818482,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z21Z(LPT_z15,1096905580,true)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z31Z(LPT_z15,false)
call LPT_Z49Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z0ZZ takes nothing returns nothing
local integer LPT_Z75=0
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z05==LPT_z5)and(LPT_z6[LPT_z15]))then
loop
exitwhen LPT_Z75>11
if(LPT_z78==LPT_ZzZ[LPT_Z75])then
if(LPT_z6[LPT_Z75])then
call LPT_z47(LPT_Z75)
else
call LPT_z57(LPT_Z75,Player(LPT_Z75))
endif
call LPT_Z5ZZ(LPT_z15,LPT_z05)
endif
set LPT_Z75=LPT_Z75+1
endloop
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z0zZ takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local integer LPT_Z75=0
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z05==LPT_z5)and(LPT_z6[LPT_z15]))then
loop
exitwhen LPT_Z75>12
if(LPT_z78==LPT_ZzZ[LPT_Z75])then
set LPT_Z5z=LPT_Z75
call LPT_Z53Z(LPT_z15,LPT_z05)
endif
set LPT_Z75=LPT_Z75+1
endloop
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z00Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local player LPT_Z65
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z05==LPT_z5)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z57Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
set LPT_Z65=Player(LPT_Z5z)
if(GetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_GOLD,LPT_z22)
else
call SetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set LPT_Z65=null
call LPT_Z53Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
set LPT_Z65=Player(LPT_Z5z)
if(GetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_LUMBER,LPT_z22)
else
call SetPlayerTaxRate(LPT_Z65,LPT_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set LPT_Z65=null
call LPT_Z53Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z52Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z01Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local integer LPT_Z75=LPT_Z5z
local player LPT_Z65=Player(LPT_Z75)
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_ZZzZ(LPT_Z75,LPT_Z65)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Zz1Z(LPT_Z65)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call SetPlayerStateBJ(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call SetPlayerStateBJ(LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
if(GetPlayerHandicapBJ(LPT_Z65)==200.)then
call SetPlayerHandicapBJ(LPT_Z65,100)
else
call SetPlayerHandicapBJ(LPT_Z65,200.)
endif
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
if(GetPlayerHandicapXPBJ(LPT_Z65)==200.)then
call SetPlayerHandicapXPBJ(LPT_Z65,100)
else
call SetPlayerHandicapXPBJ(LPT_Z65,200.)
endif
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_zz5(LPT_Z65,LPT_Z2,true)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
call LPT_z35(LPT_Z65,LPT_z2,true)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call LPT_zz5(LPT_Z65,LPT_Z2,false)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_z35(LPT_Z65,LPT_z2,false)
call LPT_Z56Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z53Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z78=null
endfunction
function LPT_z02Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local integer LPT_Z75=LPT_Z5z
local player LPT_Z65=Player(LPT_Z75)
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if(LPT_z78==LPT_z2z[LPT_z15])then
if(IsPlayerAlly(LPT_Z65,LPT_z05))then
call SetPlayerAllianceStateBJ(LPT_Z65,LPT_z05,0)
else
call SetPlayerAllianceStateBJ(LPT_Z65,LPT_z05,3)
endif
call LPT_Z57Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
if(GetPlayerAlliance(LPT_Z65,LPT_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,LPT_z5)
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_CONTROL,false,LPT_z5)
else
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,LPT_z5)
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_CONTROL,true,LPT_z5)
endif
call LPT_Z57Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
if(GetPlayerAlliance(LPT_Z65,LPT_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_XP,false,LPT_z5)
else
call SetPlayerAllianceBJ(LPT_Z65,ALLIANCE_SHARED_XP,true,LPT_z5)
endif
call LPT_Z57Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
if(IsPlayerAlly(LPT_z05,LPT_Z65))then
call SetPlayerAllianceStateBJ(LPT_z5,LPT_Z65,0)
else
call SetPlayerAllianceStateBJ(LPT_z5,LPT_Z65,2)
endif
call LPT_Z57Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z53Z(LPT_z15,LPT_z05)
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z78=null
endfunction
function LPT_z03Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local integer LPT_Z75
local unit LPT_z65=LPT_z7[LPT_z15]
local player LPT_Z65=GetOwningPlayer(LPT_z65)
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if(LPT_z4)and(LPT_z6[LPT_z15])then
if(LPT_z78==LPT_z2z[LPT_z15])then
call SetHeroLevelBJ(LPT_z65,GetHeroLevel(LPT_z65)+LPT_Z0Z,false)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call ModifyHeroStat(1,LPT_z65,0,LPT_Z3)
call ModifyHeroStat(0,LPT_z65,0,LPT_Z3)
call ModifyHeroStat(2,LPT_z65,0,LPT_Z3)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_z98(LPT_z15,false)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z77(LPT_z65,LPT_z05,1)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_ZZ3Z(LPT_z65)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
if(LPT_Z5Z)then
if(LPT_Z65!=LPT_z5)then
call UnitShareVisionBJ(true,LPT_z65,LPT_z05)
endif
else
call UnitShareVisionBJ(true,LPT_z65,LPT_z05)
endif
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
call LPT_Z47Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
if(LPT_Z5Z)then
if(LPT_Z65!=LPT_z5)then
call SetUnitOwner(LPT_z65,LPT_z05,true)
endif
else
call SetUnitOwner(LPT_z65,LPT_z05,true)
endif
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
call RemoveUnit(LPT_z65)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z54Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z65=null
set LPT_z78=null
endfunction
function LPT_z04Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z05==LPT_z5)and(LPT_z6[LPT_z15]))then
if(LPT_z78==LPT_z2z[LPT_z15])then
set LPT_Z0=not(LPT_Z0)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z58Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
set LPT_Z5Z=not(LPT_Z5Z)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
set LPT_Z6Z=not(LPT_Z6Z)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
set LPT_Z7Z=not(LPT_Z7Z)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
set LPT_z9Z=not(LPT_z9Z)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z7z[LPT_z15])then
set LPT_ZZz=not(LPT_ZZz)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z6z[LPT_z15])then
set LPT_z7Z=not(LPT_z7Z)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Zz0[LPT_z15])then
set LPT_Z52=not(LPT_Z52)
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_ZZ0[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z05Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if(LPT_z78==LPT_z2z[LPT_z15])then
set LPT_z61=1
call LPT_Z58Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
set LPT_z61=2
call LPT_Z58Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
set LPT_z61=3
call LPT_Z58Z(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z51Z(LPT_z15,LPT_z05)
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z06Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
local integer LPT_Z75=0
local player LPT_Z65
local unit LPT_z65=LPT_z7[LPT_z15]
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if((LPT_z4)and(LPT_z05==LPT_z5)and(LPT_z6[LPT_z15]))then
loop
exitwhen LPT_Z75>12
if(LPT_z78==LPT_ZzZ[LPT_Z75])then
set LPT_Z65=Player(LPT_Z75)
call SetUnitOwner(LPT_z7[LPT_z15],LPT_Z65,true)
endif
set LPT_Z75=LPT_Z75+1
endloop
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z50Z(LPT_z15,LPT_z05)
endif
endif
set LPT_z05=null
set LPT_Z65=null
set LPT_z78=null
set LPT_z65=null
endfunction
function LPT_z07Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_z36(LPT_z05)
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
set LPT_z31[LPT_z15]=not(LPT_z31[LPT_z15])
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
set LPT_Z33[LPT_z15]=not(LPT_Z33[LPT_z15])
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z38(LPT_z15,not(LPT_Z53[LPT_z15]))
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
set LPT_Z63[LPT_z15]=not(LPT_Z63[LPT_z15])
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_z8z[LPT_z15])then
set LPT_Z43[LPT_z15]=not(LPT_Z43[LPT_z15])
call LPT_Z6ZZ(LPT_z15,LPT_z05)
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_z08Z takes nothing returns nothing
local player LPT_z05=GetTriggerPlayer()
local integer LPT_z15=GetPlayerId(LPT_z05)
local button LPT_z78=GetClickedButton()
call LPT_Z44Z(LPT_z15,LPT_z05,false)
if(LPT_z78==LPT_z2z[LPT_z15])then
call LPT_Z6zZ(LPT_z05)
endif
if(LPT_z78==LPT_z4z[LPT_z15])then
call LPT_Z60Z(LPT_z05)
endif
if(LPT_z78==LPT_z5z[LPT_z15])then
call LPT_Z61Z(LPT_z05)
endif
if(LPT_z78==LPT_z3z[LPT_z15])then
call LPT_Z62Z(LPT_z05)
endif
if(LPT_z78==LPT_z9z[LPT_z15])then
call LPT_Z64Z()
endif
if(LPT_z78==LPT_Z00[LPT_z15])then
call LPT_Z45Z(LPT_z15,LPT_z05)
endif
set LPT_z05=null
set LPT_z78=null
endfunction
function LPT_yjYJ takes nothing returns nothing
set LPT_Yj=CreateTrigger()
set LPT_yJ=0
loop
exitwhen LPT_yJ>11
call TriggerRegisterPlayerChatEvent(LPT_Yj,Player(LPT_yJ),"飘飞之影”",true)
set LPT_yJ=LPT_yJ+1
endloop
call TriggerAddAction(LPT_Yj,function LPT_YJYJ)
endfunction
function LPT_z09Z takes nothing returns nothing
local integer LPT_Z75
local player LPT_Z65
local player LPT_z05
set LPT_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(LPT_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(LPT_z73,function LPT_Z9ZZ)
call TriggerAddCondition(LPT_z43,Condition(function LPT_Z73Z))
set LPT_Z75=0
loop
exitwhen LPT_Z75>11
set LPT_zz1[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_zz1[LPT_Z75],function LPT_Z79Z)
call DisableTrigger(LPT_zz1[LPT_Z75])
set LPT_Z30[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z30[LPT_Z75],function LPT_Z88Z)
call DisableTrigger(LPT_Z30[LPT_Z75])
set LPT_Z50[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z50[LPT_Z75],function LPT_Z89Z)
call DisableTrigger(LPT_Z50[LPT_Z75])
set LPT_Z40[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z40[LPT_Z75],function LPT_Z91Z)
call DisableTrigger(LPT_Z40[LPT_Z75])
set LPT_Z60[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z60[LPT_Z75],function LPT_Z90Z)
call DisableTrigger(LPT_Z60[LPT_Z75])
set LPT_Z6z[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z6z[LPT_Z75],function LPT_Z9zZ)
call DisableTrigger(LPT_Z6z[LPT_Z75])
set LPT_Z70[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z70[LPT_Z75],function LPT_zZ1Z)
call DisableTrigger(LPT_Z70[LPT_Z75])
set LPT_Z80[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z80[LPT_Z75],function LPT_zZ2Z)
call DisableTrigger(LPT_Z80[LPT_Z75])
set LPT_Z90[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z90[LPT_Z75],function LPT_zZ3Z)
call DisableTrigger(LPT_Z90[LPT_Z75])
set LPT_zZ0[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_zZ0[LPT_Z75],function LPT_zZ4Z)
call DisableTrigger(LPT_zZ0[LPT_Z75])
set LPT_zz0[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_zz0[LPT_Z75],function LPT_zZ5Z)
call DisableTrigger(LPT_zz0[LPT_Z75])
set LPT_z00[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z00[LPT_Z75],function LPT_zZ6Z)
set LPT_z10[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z10[LPT_Z75],function LPT_zZ9Z)
set LPT_z20[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z20[LPT_Z75],function LPT_zz0Z)
set LPT_z30[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z30[LPT_Z75],function LPT_zz3Z)
set LPT_z40[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z40[LPT_Z75],function LPT_Z81Z)
call DisableTrigger(LPT_z40[LPT_Z75])
set LPT_z50[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z50[LPT_Z75],function LPT_Z82Z)
call DisableTrigger(LPT_z50[LPT_Z75])
set LPT_z60[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z60[LPT_Z75],function LPT_Z83Z)
call DisableTrigger(LPT_z60[LPT_Z75])
set LPT_z70[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z70[LPT_Z75],function LPT_Z84Z)
call DisableTrigger(LPT_z70[LPT_Z75])
set LPT_z80[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z80[LPT_Z75],function LPT_Z85Z)
call DisableTrigger(LPT_z80[LPT_Z75])
set LPT_z90[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z90[LPT_Z75],function LPT_Z86Z)
call DisableTrigger(LPT_z90[LPT_Z75])
set LPT_ZZ3[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_ZZ3[LPT_Z75],function LPT_Z87Z)
call DisableTrigger(LPT_ZZ3[LPT_Z75])
set LPT_ZZ1[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_ZZ1[LPT_Z75],function LPT_zz4Z)
set LPT_Zz2[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Zz2[LPT_Z75],function LPT_zz5Z)
set LPT_Zz1[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Zz1[LPT_Z75],function LPT_zz6Z)
set LPT_Z01[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z01[LPT_Z75],function LPT_zz7Z)
set LPT_Z81[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z81[LPT_Z75],function LPT_zz8Z)
set LPT_Z21[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z21[LPT_Z75],function LPT_zz9Z)
set LPT_Z51[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z51[LPT_Z75],function LPT_z0ZZ)
set LPT_Z41[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z41[LPT_Z75],function LPT_z0zZ)
set LPT_Z61[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z61[LPT_Z75],function LPT_z00Z)
set LPT_Z12[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z12[LPT_Z75],function LPT_z02Z)
set LPT_Z02[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z02[LPT_Z75],function LPT_z01Z)
set LPT_Z71[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z71[LPT_Z75],function LPT_z03Z)
set LPT_Z31[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z31[LPT_Z75],function LPT_z04Z)
set LPT_Z22[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z22[LPT_Z75],function LPT_z05Z)
set LPT_Z11[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z11[LPT_Z75],function LPT_z06Z)
set LPT_Z23[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z23[LPT_Z75],function LPT_z08Z)
set LPT_Z13[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_Z13[LPT_Z75],function LPT_z07Z)
call DisableTrigger(LPT_ZZ1[LPT_Z75])
call DisableTrigger(LPT_Zz1[LPT_Z75])
call DisableTrigger(LPT_Zz2[LPT_Z75])
call DisableTrigger(LPT_Z01[LPT_Z75])
call DisableTrigger(LPT_Z81[LPT_Z75])
call DisableTrigger(LPT_Z21[LPT_Z75])
call DisableTrigger(LPT_Z51[LPT_Z75])
call DisableTrigger(LPT_Z41[LPT_Z75])
call DisableTrigger(LPT_Z61[LPT_Z75])
call DisableTrigger(LPT_Z12[LPT_Z75])
call DisableTrigger(LPT_Z02[LPT_Z75])
call DisableTrigger(LPT_Z71[LPT_Z75])
call DisableTrigger(LPT_Z31[LPT_Z75])
call DisableTrigger(LPT_Z22[LPT_Z75])
call DisableTrigger(LPT_Z11[LPT_Z75])
call DisableTrigger(LPT_Z23[LPT_Z75])
call DisableTrigger(LPT_Z13[LPT_Z75])
set LPT_z01[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z01[LPT_Z75],function LPT_Z95Z)
set LPT_z11[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z11[LPT_Z75],function LPT_Z98Z)
set LPT_z21[LPT_Z75]=CreateTrigger()
call TriggerAddAction(LPT_z21[LPT_Z75],function LPT_zZZZ)
call DisableTrigger(LPT_z01[LPT_Z75])
call DisableTrigger(LPT_z11[LPT_Z75])
call DisableTrigger(LPT_z21[LPT_Z75])
set LPT_Z65=Player(LPT_Z75)
if((GetPlayerController(LPT_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(LPT_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set LPT_Z8Z[LPT_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(LPT_z63,LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(LPT_z10[LPT_Z75],LPT_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(LPT_z00[LPT_Z75],LPT_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(LPT_z20[LPT_Z75],LPT_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(LPT_z30[LPT_Z75],LPT_Z65,0,1)
call TriggerRegisterPlayerChatEvent(LPT_z53,LPT_Z65,SubStringBJ(LPT_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(LPT_z63,LPT_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set LPT_Z9Z[LPT_Z75]=GetPlayerStartLocationLoc(LPT_Z65)
endif
set LPT_Z75=LPT_Z75+1
endloop
call DisableTrigger(LPT_z73)
set LPT_z8Z=CreateGroup()
set LPT_z8=GetWorldBounds()
set LPT_z2Z[0]=30.
set LPT_z2Z[1]=60.
set LPT_z2Z[2]=90.
set LPT_z3Z[0]=50.
set LPT_z3Z[1]=72.
set LPT_z3Z[2]=95.
set LPT_Z75=0
loop
exitwhen LPT_Z75>20
set LPT_z02[LPT_Z75]=null
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z75=0
loop
exitwhen(LPT_Z75>12)
set LPT_Z5[LPT_Z75]=0
set LPT_z6[LPT_Z75]=false
set LPT_Z7[LPT_Z75]=false
set LPT_Z8[LPT_Z75]=0
set LPT_Z1Z[LPT_Z75]=false
set LPT_Z2Z[LPT_Z75]=false
set LPT_Z3Z[LPT_Z75]=CreateTimer()
set LPT_Z8Z[LPT_Z75]=CreateGroup()
set LPT_zZZ[LPT_Z75]=false
set LPT_zzZ[LPT_Z75]=false
set LPT_z0Z[LPT_Z75]=CreateTimer()
set LPT_z1Z[LPT_Z75]=false
set LPT_Z3z[LPT_Z75]=false
set LPT_Z4z[LPT_Z75]=0
set LPT_Z20[LPT_Z75]=DialogCreate()
set LPT_Z91[LPT_Z75]=DialogCreate()
set LPT_zZ1[LPT_Z75]=DialogCreate()
set LPT_z31[LPT_Z75]=false
set LPT_Z32[LPT_Z75]=0
set LPT_Z42[LPT_Z75]=false
set LPT_Zz3[LPT_Z75]=DialogCreate()
set LPT_Z33[LPT_Z75]=false
set LPT_Z43[LPT_Z75]=true
set LPT_Z53[LPT_Z75]=false
set LPT_Z63[LPT_Z75]=false
set LPT_Z73[LPT_Z75]=CreateTimer()
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z75=0
loop
exitwhen(LPT_Z75>3)
set LPT_Z75=LPT_Z75+1
endloop
set LPT_Z75=0
loop
exitwhen(LPT_Z75>21)
set LPT_z12[LPT_Z75]=false
set LPT_Z75=LPT_Z75+1
endloop
call TriggerRegisterTimerEvent(LPT_z23,.01,false)
call TriggerAddAction(LPT_z23,function LPT_Z7zZ)
call TriggerAddAction(LPT_z33,function LPT_Z70Z)
call TriggerAddAction(LPT_z43,function LPT_Z74Z)
call TriggerAddAction(LPT_z53,function LPT_Z8zZ)
call TriggerAddAction(LPT_z63,function LPT_Z80Z)
call TriggerRegisterAnyUnitEventBJ(LPT_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(LPT_z73,function LPT_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(LPT_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(LPT_z83,function LPT_Z93Z)
call DisableTrigger(LPT_z83)
call LPT_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set LPT_Z65=null
call LPT_yjYJ()
endfunction