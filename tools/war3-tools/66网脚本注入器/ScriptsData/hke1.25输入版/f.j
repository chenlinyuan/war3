function minlibanhek_Z64 takes real minlibanhek_Z74,location minlibanhek_Z84 returns group
set minlibanhek_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(minlibanhek_Z14,minlibanhek_Z84,minlibanhek_Z74,minlibanhek_Z34)
return minlibanhek_Z14
endfunction
function minlibanhek_Z94 takes player minlibanhek_zZ4 returns group
set minlibanhek_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(minlibanhek_Z14,minlibanhek_zZ4,minlibanhek_Z34)
return minlibanhek_Z14
endfunction
function minlibanhek_zz4 takes player minlibanhek_zZ4,integer minlibanhek_z04 returns group
set minlibanhek_Z14=CreateGroup()
set bj_groupEnumTypeId=minlibanhek_z04
call GroupEnumUnitsOfPlayer(minlibanhek_Z14,minlibanhek_zZ4,filterGetUnitsOfPlayerAndTypeId)
return minlibanhek_Z14
endfunction
function minlibanhek_z14 takes player minlibanhek_zZ4 returns force
set minlibanhek_Z24=CreateForce()
call ForceEnumAllies(minlibanhek_Z24,minlibanhek_zZ4,minlibanhek_Z34)
return minlibanhek_Z24
endfunction
function minlibanhek_z24 takes player minlibanhek_zZ4 returns force
set minlibanhek_Z24=CreateForce()
call ForceEnumEnemies(minlibanhek_Z24,minlibanhek_zZ4,minlibanhek_Z34)
return minlibanhek_Z24
endfunction
function minlibanhek_Z45 takes trigger minlibanhek_Z55,player minlibanhek_Z65,integer minlibanhek_Z75 returns nothing
local playerevent minlibanhek_Z85=ConvertPlayerEvent(minlibanhek_Z75)
call TriggerRegisterPlayerEvent(minlibanhek_Z55,minlibanhek_Z65,minlibanhek_Z85)
set minlibanhek_Z85=null
endfunction
function minlibanhek_Z95 takes trigger minlibanhek_Z55,player minlibanhek_Z65,integer minlibanhek_Z75 returns nothing
local playerunitevent minlibanhek_Z85=ConvertPlayerUnitEvent(minlibanhek_Z75)
call TriggerRegisterPlayerUnitEvent(minlibanhek_Z55,minlibanhek_Z65,minlibanhek_Z85,null)
set minlibanhek_Z85=null
endfunction
function minlibanhek_zZ5 takes integer minlibanhek_Z75,player minlibanhek_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(minlibanhek_Z30[minlibanhek_Z75],minlibanhek_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(minlibanhek_Z50[minlibanhek_Z75],minlibanhek_Z65,ConvertPlayerUnitEvent(25),null)
call minlibanhek_Z45(minlibanhek_Z70[minlibanhek_Z75],minlibanhek_Z65,17)
call minlibanhek_Z45(minlibanhek_Z90[minlibanhek_Z75],minlibanhek_Z65,266)
call minlibanhek_Z45(minlibanhek_Z80[minlibanhek_Z75],minlibanhek_Z65,268)
call minlibanhek_Z45(minlibanhek_zZ0[minlibanhek_Z75],minlibanhek_Z65,262)
call minlibanhek_Z45(minlibanhek_zz0[minlibanhek_Z75],minlibanhek_Z65,264)
call TriggerRegisterTimerExpireEvent(minlibanhek_z43,minlibanhek_z0Z[minlibanhek_Z75])
call TriggerRegisterTimerExpireEvent(minlibanhek_z33,minlibanhek_Z73[minlibanhek_Z75])
call minlibanhek_Z95(minlibanhek_Z40[minlibanhek_Z75],minlibanhek_Z65,32)
call minlibanhek_Z95(minlibanhek_Z60[minlibanhek_Z75],minlibanhek_Z65,35)
call TriggerRegisterDialogEvent(minlibanhek_ZZ1[minlibanhek_Z75],minlibanhek_zZ1[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Zz2[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Zz1[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z01[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z81[minlibanhek_Z75],minlibanhek_Z91[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z71[minlibanhek_Z75],minlibanhek_zZ1[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z21[minlibanhek_Z75],minlibanhek_Z91[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z31[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z22[minlibanhek_Z75],minlibanhek_Z91[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z11[minlibanhek_Z75],minlibanhek_Z91[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z51[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z41[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z61[minlibanhek_Z75],minlibanhek_Z91[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z12[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z02[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z23[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call TriggerRegisterDialogEvent(minlibanhek_Z13[minlibanhek_Z75],minlibanhek_Z20[minlibanhek_Z75])
call minlibanhek_Z95(minlibanhek_z01[minlibanhek_Z75],minlibanhek_Z65,38)
call minlibanhek_Z95(minlibanhek_z11[minlibanhek_Z75],minlibanhek_Z65,39)
call minlibanhek_Z95(minlibanhek_z21[minlibanhek_Z75],minlibanhek_Z65,40)
call minlibanhek_Z95(minlibanhek_z80[minlibanhek_Z75],minlibanhek_Z65,276)
call minlibanhek_Z95(minlibanhek_z80[minlibanhek_Z75],minlibanhek_Z65,275)
call minlibanhek_Z95(minlibanhek_z90[minlibanhek_Z75],minlibanhek_Z65,276)
call minlibanhek_Z95(minlibanhek_z90[minlibanhek_Z75],minlibanhek_Z65,275)
call minlibanhek_Z95(minlibanhek_ZZ3[minlibanhek_Z75],minlibanhek_Z65,18)
call TriggerRegisterPlayerStateEvent(minlibanhek_z60[minlibanhek_Z75],minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(minlibanhek_z40[minlibanhek_Z75],minlibanhek_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(minlibanhek_z50[minlibanhek_Z75],minlibanhek_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call minlibanhek_Z95(minlibanhek_z70[minlibanhek_Z75],minlibanhek_Z65,20)
call TriggerRegisterPlayerChatEvent(minlibanhek_zz1[minlibanhek_Z75],minlibanhek_Z65,"-",false)
call minlibanhek_Z95(minlibanhek_Z6z[minlibanhek_Z75],minlibanhek_Z65,39)
set minlibanhek_Z3z[minlibanhek_Z75]=true
endfunction
function minlibanhek_zz5 takes player minlibanhek_z05,integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_z25)then
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)+minlibanhek_z15)
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(minlibanhek_z05,PLAYER_STATE_GOLD_GATHERED)-minlibanhek_z15)
else
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)-minlibanhek_z15)
endif
endfunction
function minlibanhek_z35 takes player minlibanhek_z05,integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_z25)then
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)+minlibanhek_z15)
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(minlibanhek_z05,PLAYER_STATE_LUMBER_GATHERED)-minlibanhek_z15)
else
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)-minlibanhek_z15)
endif
endfunction
function minlibanhek_z45 takes player minlibanhek_z05 returns nothing
local player minlibanhek_Z65=GetLocalPlayer()
if minlibanhek_z05==minlibanhek_Z65 then
set minlibanhek_Z65=Player(-1)
endif
set minlibanhek_Z65=null
endfunction
function minlibanhek_z55 takes unit minlibanhek_z65,unit minlibanhek_z75,boolean minlibanhek_z85 returns nothing
local location minlibanhek_z95
local location minlibanhek_ZZ6
set minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
set minlibanhek_ZZ6=GetUnitLoc(minlibanhek_z75)
call SetUnitPositionLoc(minlibanhek_z65,minlibanhek_ZZ6)
if(minlibanhek_z85)then
call SetUnitPositionLoc(minlibanhek_z75,minlibanhek_z95)
call SetUnitPositionLoc(minlibanhek_z65,minlibanhek_ZZ6)
endif
call RemoveLocation(minlibanhek_z95)
call RemoveLocation(minlibanhek_ZZ6)
set minlibanhek_z95=null
set minlibanhek_ZZ6=null
endfunction
function minlibanhek_Zz6 takes integer minlibanhek_Z06 returns nothing
if(minlibanhek_Z06==0)then
set minlibanhek_zZ2=100
set minlibanhek_Z92=100
set minlibanhek_Z82=100
set minlibanhek_Z72="|cFFFFFFFF"
return
endif
if(minlibanhek_Z06==1)then
set minlibanhek_zZ2=50
set minlibanhek_Z92=50
set minlibanhek_Z82=50
set minlibanhek_Z72="|cFF7F7F7F"
return
endif
if(minlibanhek_Z06==2)then
set minlibanhek_zZ2=0
set minlibanhek_Z92=0
set minlibanhek_Z82=0
set minlibanhek_Z72="|cFF000000"
return
endif
if(minlibanhek_Z06==3)then
set minlibanhek_zZ2=100
set minlibanhek_Z92=0
set minlibanhek_Z82=0
set minlibanhek_Z72="|cFFFF0000"
return
endif
if(minlibanhek_Z06==4)then
set minlibanhek_zZ2=100
set minlibanhek_Z92=50
set minlibanhek_Z82=0
set minlibanhek_Z72="|cFFFF7F00"
return
endif
if(minlibanhek_Z06==5)then
set minlibanhek_zZ2=100
set minlibanhek_Z92=100
set minlibanhek_Z82=0
set minlibanhek_Z72="|cFFFFFF00"
return
endif
if(minlibanhek_Z06==6)then
set minlibanhek_zZ2=0
set minlibanhek_Z92=100
set minlibanhek_Z82=0
set minlibanhek_Z72="|cFF00FF00"
return
endif
if(minlibanhek_Z06==7)then
set minlibanhek_zZ2=0
set minlibanhek_Z92=100
set minlibanhek_Z82=100
set minlibanhek_Z72="|cFF00FFFF"
return
endif
if(minlibanhek_Z06==8)then
set minlibanhek_zZ2=0
set minlibanhek_Z92=0
set minlibanhek_Z82=100
set minlibanhek_Z72="|cFF0000FF"
return
endif
if(minlibanhek_Z06==9)then
set minlibanhek_zZ2=100
set minlibanhek_Z92=0
set minlibanhek_Z82=100
set minlibanhek_Z72="|cFFFF00FF"
return
endif
endfunction
function minlibanhek_Z16 takes integer minlibanhek_Z06,unit minlibanhek_Z26,string minlibanhek_Z36 returns nothing
local texttag minlibanhek_Z46
local location minlibanhek_z95
call minlibanhek_Zz6(minlibanhek_Z06)
set minlibanhek_z95=GetUnitLoc(minlibanhek_Z26)
set minlibanhek_Z46=CreateTextTagLocBJ(minlibanhek_Z36,minlibanhek_z95,0,20,minlibanhek_zZ2,minlibanhek_Z92,minlibanhek_Z82,0)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
call SetTextTagPermanent(minlibanhek_Z46,false)
call SetTextTagLifespan(minlibanhek_Z46,minlibanhek_Z1)
set minlibanhek_Z46=null
endfunction
function minlibanhek_Z56 takes nothing returns nothing
local trigger minlibanhek_Z66=GetTriggeringTrigger()
local timer minlibanhek_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(minlibanhek_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(minlibanhek_z52)
call DestroyTimerDialog(minlibanhek_z82)
call DestroyTimer(minlibanhek_Z76)
set minlibanhek_Z66=null
set minlibanhek_Z76=null
endfunction
function minlibanhek_Z86 takes nothing returns nothing
local timer minlibanhek_Z76
local trigger minlibanhek_Z66
if(minlibanhek_z62)then
else
set minlibanhek_z52=GetGameSpeed()
set minlibanhek_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set minlibanhek_Z66=CreateTrigger()
set minlibanhek_Z76=CreateTimer()
call StartTimerBJ(minlibanhek_Z76,false,minlibanhek_z42)
set minlibanhek_z82=CreateTimerDialogBJ(minlibanhek_Z76,"子弹时间")
call TriggerAddAction(minlibanhek_Z66,function minlibanhek_Z56)
call TriggerRegisterTimerExpireEvent(minlibanhek_Z66,minlibanhek_Z76)
endif
endfunction
function minlibanhek_Z96 takes trigger minlibanhek_zZ6 returns nothing
if(IsTriggerEnabled(minlibanhek_zZ6))then
call DisableTrigger(minlibanhek_zZ6)
else
call EnableTrigger(minlibanhek_zZ6)
endif
endfunction
function minlibanhek_zz6 takes trigger minlibanhek_zZ6,boolean minlibanhek_z06 returns nothing
if(IsTriggerEnabled(minlibanhek_zZ6)==minlibanhek_z06)then
else
call minlibanhek_Z96(minlibanhek_zZ6)
endif
endfunction
function minlibanhek_z16 takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
call minlibanhek_zz6(minlibanhek_z40[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_z50[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_z60[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_z80[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_z70[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_z90[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_zz6(minlibanhek_ZZ3[minlibanhek_z15],minlibanhek_z25)
endfunction
function minlibanhek_z26 takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
if(GetUnitUserData(minlibanhek_z65)==2176)then
call RemoveUnit(minlibanhek_z65)
endif
set minlibanhek_z65=null
endfunction
function minlibanhek_z36 takes player minlibanhek_z05 returns nothing
local group minlibanhek_z46
if(minlibanhek_Z42[GetPlayerId(minlibanhek_z05)])then
set minlibanhek_z46=minlibanhek_Z94(minlibanhek_z05)
call ForGroup(minlibanhek_z46,function minlibanhek_z26)
set minlibanhek_Z42[GetPlayerId(minlibanhek_z05)]=false
call DestroyGroup(minlibanhek_z46)
set minlibanhek_z46=null
endif
endfunction
function minlibanhek_z56 takes unit minlibanhek_z65,player minlibanhek_z05 returns nothing
local location minlibanhek_z95
local integer minlibanhek_z66
local unit minlibanhek_z76
local item minlibanhek_z86
local integer minlibanhek_Z75=0
if(IsUnitType(minlibanhek_z65,UNIT_TYPE_HERO))then
set minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
set minlibanhek_z66=GetUnitTypeId(minlibanhek_z65)
set minlibanhek_z76=CreateUnitAtLoc(minlibanhek_z05,minlibanhek_z66,minlibanhek_z95,bj_UNIT_FACING)
call SetUnitUserData(minlibanhek_z76,2176)
set minlibanhek_Z42[GetPlayerId(minlibanhek_z05)]=true
if(minlibanhek_Z6Z)then
call SetUnitUseFood(minlibanhek_z76,false)
endif
call SetHeroLevelBJ(minlibanhek_z76,GetHeroLevel(minlibanhek_z65),false)
call SetHeroStat(minlibanhek_z76,0,GetHeroStatBJ(0,minlibanhek_z65,false))
call SetHeroStat(minlibanhek_z76,1,GetHeroStatBJ(1,minlibanhek_z65,false))
call SetHeroStat(minlibanhek_z76,2,GetHeroStatBJ(2,minlibanhek_z65,false))
loop
exitwhen minlibanhek_Z75>5
set minlibanhek_z86=UnitItemInSlot(minlibanhek_z65,minlibanhek_Z75)
call UnitAddItemById(minlibanhek_z76,GetItemTypeId(minlibanhek_z86))
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
endif
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
set minlibanhek_z76=null
set minlibanhek_z86=null
endfunction
function minlibanhek_z96 takes integer minlibanhek_ZZ7,player minlibanhek_Zz7,location minlibanhek_Z07,boolean minlibanhek_Z17,boolean minlibanhek_Z27 returns nothing
local unit minlibanhek_z76
set minlibanhek_z76=CreateUnitAtLoc(minlibanhek_Zz7,minlibanhek_ZZ7,minlibanhek_Z07,bj_UNIT_FACING)
if(minlibanhek_Z6Z)then
call SetUnitUseFood(minlibanhek_z76,false)
endif
if(minlibanhek_Z17)then
call SetUnitUserData(minlibanhek_z76,2176)
endif
if(minlibanhek_Z27)then
call UnitApplyTimedLife(minlibanhek_z76,1112820806,90)
endif
set minlibanhek_z76=null
endfunction
function minlibanhek_Z37 takes integer minlibanhek_ZZ7,player minlibanhek_Zz7,location minlibanhek_Z07 returns nothing
local unit minlibanhek_z76
set minlibanhek_z76=CreateUnitAtLoc(minlibanhek_Zz7,minlibanhek_ZZ7,minlibanhek_Z07,bj_UNIT_FACING)
if(minlibanhek_Z6Z)then
call SetUnitUseFood(minlibanhek_z76,false)
set minlibanhek_z76=null
endif
endfunction
function minlibanhek_Z47 takes unit minlibanhek_Z57,player minlibanhek_Zz7,integer minlibanhek_Z67,boolean minlibanhek_Z27 returns nothing
local location minlibanhek_z95
local integer minlibanhek_z66
local integer minlibanhek_Z75
set minlibanhek_z95=GetUnitLoc(minlibanhek_Z57)
set minlibanhek_z66=GetUnitTypeId(minlibanhek_Z57)
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>minlibanhek_Z67
call minlibanhek_z96(minlibanhek_z66,minlibanhek_Zz7,minlibanhek_z95,true,minlibanhek_Z27)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call RemoveLocation(minlibanhek_z95)
set minlibanhek_Z42[GetPlayerId(minlibanhek_Zz7)]=true
set minlibanhek_z95=null
endfunction
function minlibanhek_Z77 takes unit minlibanhek_Z57,player minlibanhek_Zz7,integer minlibanhek_Z67 returns nothing
call minlibanhek_Z47(minlibanhek_Z57,minlibanhek_Zz7,minlibanhek_Z67,false)
endfunction
function minlibanhek_Z87 takes unit minlibanhek_z65,integer minlibanhek_z15,boolean minlibanhek_Z97 returns nothing
local integer minlibanhek_Z75
set minlibanhek_Z75=GetResourceAmount(minlibanhek_z65)
if(minlibanhek_Z97)then
set minlibanhek_Z75=minlibanhek_Z75+minlibanhek_z15
else
set minlibanhek_Z75=minlibanhek_Z75-minlibanhek_z15
endif
if(minlibanhek_Z75<0)then
if(minlibanhek_Z97)then
set minlibanhek_Z75=GetResourceAmount(minlibanhek_z65)
else
set minlibanhek_Z75=0
endif
endif
call SetResourceAmount(minlibanhek_z65,minlibanhek_Z75)
endfunction
function minlibanhek_zZ7 takes integer minlibanhek_z15,player minlibanhek_z05,boolean minlibanhek_zz7 returns nothing
if(minlibanhek_zz7)then
call SetPlayerTechMaxAllowed(minlibanhek_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(minlibanhek_z05,1212502607,3)
endif
endfunction
function minlibanhek_z07 takes integer minlibanhek_z15,boolean minlibanhek_z06 returns nothing
if(minlibanhek_z06)then
call EnableTrigger(minlibanhek_z00[minlibanhek_z15])
call EnableTrigger(minlibanhek_z10[minlibanhek_z15])
call EnableTrigger(minlibanhek_z20[minlibanhek_z15])
call EnableTrigger(minlibanhek_z30[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z70[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z80[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z90[minlibanhek_z15])
call EnableTrigger(minlibanhek_zZ0[minlibanhek_z15])
call EnableTrigger(minlibanhek_zz0[minlibanhek_z15])
else
call DisableTrigger(HKE_Yj)	
call DisableTrigger(minlibanhek_z00[minlibanhek_z15])
call DisableTrigger(minlibanhek_z10[minlibanhek_z15])
call DisableTrigger(minlibanhek_z20[minlibanhek_z15])
call DisableTrigger(minlibanhek_z30[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z70[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z80[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z90[minlibanhek_z15])
call DisableTrigger(minlibanhek_zZ0[minlibanhek_z15])
call DisableTrigger(minlibanhek_zz0[minlibanhek_z15])
endif
endfunction
function minlibanhek_z17 takes integer minlibanhek_z15,boolean minlibanhek_z27 returns nothing
if(minlibanhek_z27)then
call EnableTrigger(minlibanhek_Z40[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z60[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z6z[minlibanhek_z15])
else
call DisableTrigger(minlibanhek_Z40[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z60[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z6z[minlibanhek_z15])
endif
endfunction
function minlibanhek_z37 takes nothing returns nothing
local integer minlibanhek_z15
set minlibanhek_z15=0
loop
exitwhen minlibanhek_z15>11
call minlibanhek_z07(minlibanhek_z15,false)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endfunction
function minlibanhek_z47 takes integer minlibanhek_z15 returns nothing
set minlibanhek_z6[minlibanhek_z15]=false
call GroupClear(minlibanhek_Z8Z[minlibanhek_z15])
if(minlibanhek_Z7Z)then
call DestroyFogModifier(minlibanhek_Z6[minlibanhek_z15])
endif
call DisableTrigger(minlibanhek_Z30[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z50[minlibanhek_z15])
call DisableTrigger(minlibanhek_zz1[minlibanhek_z15])
call DisableTrigger(minlibanhek_z40[minlibanhek_z15])
call DisableTrigger(minlibanhek_z50[minlibanhek_z15])
call DisableTrigger(minlibanhek_z60[minlibanhek_z15])
call DisableTrigger(minlibanhek_z70[minlibanhek_z15])
call DisableTrigger(minlibanhek_z80[minlibanhek_z15])
call DisableTrigger(minlibanhek_z90[minlibanhek_z15])
call DisableTrigger(minlibanhek_ZZ3[minlibanhek_z15])
call DisableTrigger(minlibanhek_ZZ1[minlibanhek_z15])
call DisableTrigger(minlibanhek_Zz1[minlibanhek_z15])
call DisableTrigger(minlibanhek_Zz2[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z01[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z81[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z21[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z51[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z41[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z61[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z12[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z02[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z71[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z31[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z22[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z11[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z23[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z13[minlibanhek_z15])
call DisableTrigger(minlibanhek_zZ3[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z40[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z60[minlibanhek_z15])
call DisableTrigger(minlibanhek_Z6z[minlibanhek_z15])
call minlibanhek_z07(minlibanhek_z15,false)
endfunction
function minlibanhek_z57 takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
set minlibanhek_z6[minlibanhek_z15]=true
if(minlibanhek_Z3z[minlibanhek_z15])then
else
call minlibanhek_zZ5(minlibanhek_z15,minlibanhek_z05)
endif
call EnableTrigger(minlibanhek_Z30[minlibanhek_z15])
call EnableTrigger(minlibanhek_Z50[minlibanhek_z15])
call EnableTrigger(minlibanhek_zz1[minlibanhek_z15])
call minlibanhek_z07(minlibanhek_z15,true)
endfunction
function minlibanhek_z67 takes integer minlibanhek_z15,boolean minlibanhek_z77 returns nothing
if(minlibanhek_z77)then
if((minlibanhek_zZZ[minlibanhek_z15])and(minlibanhek_zzZ[minlibanhek_z15])and(minlibanhek_z31[minlibanhek_z15]))then
call EnableTrigger(minlibanhek_z01[minlibanhek_z15])
call EnableTrigger(minlibanhek_z11[minlibanhek_z15])
call EnableTrigger(minlibanhek_z21[minlibanhek_z15])
endif
else
call DisableTrigger(minlibanhek_z01[minlibanhek_z15])
call DisableTrigger(minlibanhek_z11[minlibanhek_z15])
call DisableTrigger(minlibanhek_z21[minlibanhek_z15])
endif
endfunction
function minlibanhek_z87 takes integer minlibanhek_Z06 returns nothing
if(minlibanhek_Z06==0)then
set minlibanhek_zz2=0
return
endif
if(minlibanhek_Z06==1)then
set minlibanhek_zz2=10
return
endif
if(minlibanhek_Z06==2)then
set minlibanhek_zz2=15
return
endif
if(minlibanhek_Z06==3)then
set minlibanhek_zz2=20
return
endif
if(minlibanhek_Z06==4)then
set minlibanhek_zz2=40
return
endif
if(minlibanhek_Z06==5)then
set minlibanhek_zz2=50
return
endif
if(minlibanhek_Z06==6)then
set minlibanhek_zz2=70
return
endif
if(minlibanhek_Z06==7)then
set minlibanhek_zz2=80
return
endif
if(minlibanhek_Z06==8)then
set minlibanhek_zz2=90
return
endif
if(minlibanhek_Z06==9)then
set minlibanhek_zz2=100
return
endif
endfunction
function minlibanhek_z97 takes unit minlibanhek_z65,integer minlibanhek_ZZ8,integer minlibanhek_Zz8 returns nothing
call minlibanhek_z87(minlibanhek_Zz8)
call minlibanhek_Zz6(minlibanhek_ZZ8)
call SetUnitVertexColorBJ(minlibanhek_z65,minlibanhek_zZ2,minlibanhek_Z92,minlibanhek_Z82,minlibanhek_zz2)
endfunction
function minlibanhek_Z08 takes integer minlibanhek_ZZ8,integer minlibanhek_Zz8 returns nothing
call minlibanhek_z87(minlibanhek_Zz8)
call minlibanhek_Zz6(minlibanhek_ZZ8)
call SetWaterBaseColorBJ(minlibanhek_zZ2,minlibanhek_Z92,minlibanhek_Z82,minlibanhek_zz2)
endfunction
function minlibanhek_Z18 takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call minlibanhek_z97(minlibanhek_z65,GetRandomInt(3,9),0)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z28 takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call minlibanhek_z97(minlibanhek_z65,0,0)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z38 takes integer minlibanhek_z15,boolean minlibanhek_z77 returns nothing
local integer minlibanhek_Z75
local integer minlibanhek_Z48
if(minlibanhek_Z53[minlibanhek_z15]==minlibanhek_z77)then
else
set minlibanhek_Z53[minlibanhek_z15]=minlibanhek_z77
if(minlibanhek_z77)then
call EnableTrigger(minlibanhek_z83)
else
set minlibanhek_Z75=0
set minlibanhek_Z48=0
loop
exitwhen minlibanhek_Z75>11
if(minlibanhek_Z53[minlibanhek_Z75])then
set minlibanhek_Z48=minlibanhek_Z48+1
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
if(minlibanhek_Z48==0)then
call DisableTrigger(minlibanhek_z83)
endif
endif
endif
endfunction
function minlibanhek_Z58 takes integer minlibanhek_Z68 returns nothing
if(minlibanhek_Z68==0)then
call SetSkyModel(null)
return
endif
if(minlibanhek_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(minlibanhek_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(minlibanhek_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(minlibanhek_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(minlibanhek_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(minlibanhek_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(minlibanhek_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(minlibanhek_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(minlibanhek_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(minlibanhek_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(minlibanhek_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(minlibanhek_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(minlibanhek_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function minlibanhek_Z78 takes integer minlibanhek_Z88 returns integer
if(minlibanhek_Z88==0)then
return 1380018290
endif
if(minlibanhek_Z88==1)then
return 1380019314
endif
if(minlibanhek_Z88==2)then
return 1296393331
endif
if(minlibanhek_Z88==3)then
return 1178886760
endif
if(minlibanhek_Z88==4)then
return 1178886764
endif
if(minlibanhek_Z88==5)then
return 1178888040
endif
if(minlibanhek_Z88==6)then
return 1178888044
endif
if(minlibanhek_Z88==7)then
return 1178890856
endif
if(minlibanhek_Z88==8)then
return 1178890860
endif
if(minlibanhek_Z88==9)then
return 1178892136
endif
if(minlibanhek_Z88==10)then
return 1178892140
endif
if(minlibanhek_Z88==11)then
return 1380739186
endif
if(minlibanhek_Z88==12)then
return 1380740210
endif
if(minlibanhek_Z88==13)then
return 1397645939
endif
if(minlibanhek_Z88==14)then
return 1397647475
endif
if(minlibanhek_Z88==15)then
return 1397648499
endif
if(minlibanhek_Z88==16)then
return 1464820599
endif
if(minlibanhek_Z88==17)then
return 1464822903
endif
if(minlibanhek_Z88==18)then
return 1280467297
endif
if(minlibanhek_Z88==19)then
return 1280470369
endif
if(minlibanhek_Z88==20)then
return 1464755063
endif
return 0
endfunction
function minlibanhek_Z98 takes integer minlibanhek_Z88,boolean minlibanhek_z77 returns nothing
set minlibanhek_Z88=minlibanhek_Z88-1
if(minlibanhek_z77)then
if(minlibanhek_z12[minlibanhek_Z88]==false)then
if(minlibanhek_Z78(minlibanhek_Z88)==0)then
else
set minlibanhek_z02[minlibanhek_Z88]=AddWeatherEffect(minlibanhek_z8,minlibanhek_Z78(minlibanhek_Z88))
call EnableWeatherEffect(minlibanhek_z02[minlibanhek_Z88],true)
set minlibanhek_z12[minlibanhek_Z88]=true
endif
endif
else
if(minlibanhek_z02[minlibanhek_Z88]==null)then
else
call EnableWeatherEffect(minlibanhek_z02[minlibanhek_Z88],false)
call RemoveWeatherEffect(minlibanhek_z02[minlibanhek_Z88])
set minlibanhek_z12[minlibanhek_Z88]=false
set minlibanhek_z02[minlibanhek_Z88]=null
endif
endif
endfunction
function minlibanhek_zZ8 takes nothing returns nothing
local integer minlibanhek_z15=1
loop
exitwhen minlibanhek_z15>21
call minlibanhek_Z98(minlibanhek_z15,false)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endfunction
function minlibanhek_zz8 takes integer minlibanhek_z08 returns integer
if(minlibanhek_z08==0)then
return 1280601204
endif
if(minlibanhek_z08==1)then
return 1179939959
endif
if(minlibanhek_z08==2)then
return 1465152631
endif
if(minlibanhek_z08==3)then
return 1096053874
endif
if(minlibanhek_z08==4)then
return 1096053859
endif
if(minlibanhek_z08==5)then
return 1112831095
endif
if(minlibanhek_z08==6)then
return 1263826039
endif
if(minlibanhek_z08==7)then
return 1498707828
endif
if(minlibanhek_z08==8)then
return 1498702708
endif
if(minlibanhek_z08==9)then
return 1498703476
endif
if(minlibanhek_z08==10)then
return 1498706804
endif
if(minlibanhek_z08==11)then
return 1247044468
endif
if(minlibanhek_z08==12)then
return 1247048823
endif
if(minlibanhek_z08==13)then
return 1146385256
endif
if(minlibanhek_z08==14)then
return 1129608306
endif
if(minlibanhek_z08==15)then
return 1129608291
endif
if(minlibanhek_z08==16)then
return 1230271607
endif
if(minlibanhek_z08==17)then
return 1230271607
endif
if(minlibanhek_z08==18)then
return 1314157667
endif
if(minlibanhek_z08==19)then
return 1330934903
endif
if(minlibanhek_z08==20)then
return 1515484279
endif
if(minlibanhek_z08==21)then
return 1196716904
endif
if(minlibanhek_z08==22)then
return 1448373364
endif
if(minlibanhek_z08==23)then
return 1448373364
endif
return 0
endfunction
function minlibanhek_z18 takes nothing returns integer
return minlibanhek_zz8(GetRandomInt(0,23))
endfunction
function minlibanhek_z28 takes unit minlibanhek_z65,integer minlibanhek_z38,integer minlibanhek_z08,integer minlibanhek_z48 returns nothing
local real minlibanhek_z58
local real minlibanhek_z68
local real minlibanhek_z15=0
local boolean minlibanhek_z78=true
set minlibanhek_z58=GetUnitX(minlibanhek_z65)
set minlibanhek_z68=GetUnitY(minlibanhek_z65)
if(minlibanhek_z38==1)then
loop
exitwhen minlibanhek_z15==minlibanhek_z48
if(minlibanhek_z78)then
call CreateDestructable(minlibanhek_z08,minlibanhek_z58,minlibanhek_z68+minlibanhek_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(minlibanhek_z08,minlibanhek_z58,minlibanhek_z68-minlibanhek_z15*40,GetRandomReal(0,360),1,0)
endif
set minlibanhek_z78=not(minlibanhek_z78)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endif
if(minlibanhek_z38==2)then
loop
exitwhen minlibanhek_z15==minlibanhek_z48
if(minlibanhek_z78)then
call CreateDestructable(minlibanhek_z08,minlibanhek_z58+minlibanhek_z15*40,minlibanhek_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(minlibanhek_z08,minlibanhek_z58-minlibanhek_z15*40,minlibanhek_z68,GetRandomReal(0,360),1,0)
endif
set minlibanhek_z78=not(minlibanhek_z78)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endif
if(minlibanhek_z38==3)then
loop
exitwhen minlibanhek_z15==minlibanhek_z48
if(minlibanhek_z78)then
call CreateDestructable(minlibanhek_z08,minlibanhek_z58+minlibanhek_z15*40,minlibanhek_z68+minlibanhek_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(minlibanhek_z08,minlibanhek_z58-minlibanhek_z15*40,minlibanhek_z68-minlibanhek_z15*40,GetRandomReal(0,360),1,0)
endif
set minlibanhek_z78=not(minlibanhek_z78)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endif
if(minlibanhek_z38==4)then
loop
exitwhen minlibanhek_z15==minlibanhek_z48
if(minlibanhek_z78)then
call CreateDestructable(minlibanhek_z08,minlibanhek_z58+minlibanhek_z15*40,minlibanhek_z68-minlibanhek_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(minlibanhek_z08,minlibanhek_z58-minlibanhek_z15*40,minlibanhek_z68+minlibanhek_z15*40,GetRandomReal(0,360),1,0)
endif
set minlibanhek_z78=not(minlibanhek_z78)
set minlibanhek_z15=minlibanhek_z15+1
endloop
endif
endfunction
function minlibanhek_z88 takes integer minlibanhek_z15 returns nothing
set minlibanhek_Z7[minlibanhek_z15]=true
call StartTimerBJ(minlibanhek_z0Z[minlibanhek_z15],false,2.)
endfunction
function minlibanhek_z98 takes integer minlibanhek_z15,boolean minlibanhek_ZZZZ returns nothing
local integer minlibanhek_Z75
local integer minlibanhek_z76
local item minlibanhek_z86
local location minlibanhek_z95
local unit minlibanhek_z65
set minlibanhek_z65=minlibanhek_z7[minlibanhek_z15]
set minlibanhek_z76=1
loop
exitwhen minlibanhek_z76>6
if(minlibanhek_ZZZZ)then
set minlibanhek_z95=GetUnitLoc(minlibanhek_z51[minlibanhek_z15])
else
set minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
endif
set minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z65,minlibanhek_z76)
if(GetItemCharges(minlibanhek_z86)>0)then
set minlibanhek_Z75=GetItemCharges(minlibanhek_z86)
set minlibanhek_z86=CreateItemLoc(GetItemTypeId(minlibanhek_z86),minlibanhek_z95)
call SetItemCharges(minlibanhek_z86,minlibanhek_Z75)
else
call CreateItemLoc(GetItemTypeId(minlibanhek_z86),minlibanhek_z95)
endif
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z76=minlibanhek_z76+1
endloop
set minlibanhek_z65=null
set minlibanhek_z95=null
set minlibanhek_z86=null
endfunction
function minlibanhek_ZZzZ takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local integer minlibanhek_Z75
local force minlibanhek_ZZ0Z
local player minlibanhek_Z65
if(minlibanhek_z1Z[minlibanhek_z15])then
call DestroyFogModifier(minlibanhek_Z6[minlibanhek_z15])
set minlibanhek_z1Z[minlibanhek_z15]=false
else
set minlibanhek_ZZ0Z=CreateForce()
set minlibanhek_Z75=0
loop
exitwhen minlibanhek_Z75>11
set minlibanhek_Z65=Player(minlibanhek_Z75)
if(GetPlayerAlliance(minlibanhek_z05,minlibanhek_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(minlibanhek_ZZ0Z,minlibanhek_Z65)
call SetPlayerAlliance(minlibanhek_z05,minlibanhek_Z65,ALLIANCE_SHARED_VISION,false)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z6[minlibanhek_z15]=CreateFogModifierRect(minlibanhek_z05,FOG_OF_WAR_VISIBLE,minlibanhek_z8,false,false)
call FogModifierStart(minlibanhek_Z6[minlibanhek_z15])
set minlibanhek_z1Z[minlibanhek_z15]=true
set minlibanhek_Z75=0
loop
exitwhen minlibanhek_Z75>11
set minlibanhek_Z65=Player(minlibanhek_Z75)
if(IsPlayerInForce(minlibanhek_Z65,minlibanhek_ZZ0Z))then
call SetPlayerAlliance(minlibanhek_z05,minlibanhek_Z65,ALLIANCE_SHARED_VISION,true)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call DestroyForce(minlibanhek_ZZ0Z)
set minlibanhek_ZZ0Z=null
set minlibanhek_Z65=null
endif
endfunction
function minlibanhek_ZZ1Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local integer minlibanhek_Z75
local unit minlibanhek_z65
local item minlibanhek_z86
local item array minlibanhek_ZZ2Z
set minlibanhek_z65=FirstOfGroup(minlibanhek_Z8Z[minlibanhek_z15])
if((minlibanhek_z05==GetOwningPlayer(minlibanhek_z65))and(UnitInventorySizeBJ(minlibanhek_z65)>0))then
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>6
set minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z65,minlibanhek_Z75)
set minlibanhek_ZZ2Z[(minlibanhek_Z75-1)]=minlibanhek_z86
call UnitRemoveItemSwapped(minlibanhek_z86,minlibanhek_z65)
call SetItemVisible(minlibanhek_z86,false)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>6
set minlibanhek_z86=minlibanhek_Z2z[(minlibanhek_z15*18)+(minlibanhek_Z4z[minlibanhek_z15]*6)+(minlibanhek_Z75-1)]
call UnitAddItem(minlibanhek_z65,minlibanhek_z86)
set minlibanhek_Z2z[(minlibanhek_z15*18)+(minlibanhek_Z4z[minlibanhek_z15]*6)+(minlibanhek_Z75-1)]=minlibanhek_ZZ2Z[(minlibanhek_Z75-1)]
set minlibanhek_ZZ2Z[(minlibanhek_Z75-1)]=null
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
if(minlibanhek_Z4z[minlibanhek_z15]==0)then
set minlibanhek_Z4z[minlibanhek_z15]=minlibanhek_z61-1
else
set minlibanhek_Z4z[minlibanhek_z15]=(minlibanhek_Z4z[minlibanhek_z15]-1)
endif
set minlibanhek_z86=null
endif
set minlibanhek_z65=null
set minlibanhek_z05=null
endfunction
function minlibanhek_ZZ3Z takes unit minlibanhek_z65 returns nothing
local integer minlibanhek_Z75
local item minlibanhek_z86
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>6
set minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z65,minlibanhek_Z75)
call UnitRemoveItemSwapped(minlibanhek_z86,minlibanhek_z65)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_z86=null
endfunction
function minlibanhek_ZZ4Z takes integer minlibanhek_z15 returns nothing
local integer minlibanhek_Z75
local item minlibanhek_z86
local location minlibanhek_z95
set minlibanhek_z95=GetUnitLoc(minlibanhek_z51[minlibanhek_z15])
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>6
set minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z75)
call UnitRemoveItemSwapped(minlibanhek_z86,minlibanhek_z7[minlibanhek_z15])
call SetItemPositionLoc(minlibanhek_z86,minlibanhek_z95)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z86=null
set minlibanhek_z95=null
endfunction
function minlibanhek_ZZ5Z takes integer minlibanhek_z15 returns nothing
local integer minlibanhek_z76
local integer minlibanhek_z78
local unit minlibanhek_z65
local item minlibanhek_Z66
local item minlibanhek_ZZ6Z
set minlibanhek_z65=FirstOfGroup(minlibanhek_Z8Z[minlibanhek_z15])
set minlibanhek_z76=1
loop
exitwhen minlibanhek_z76>5
set minlibanhek_Z66=UnitItemInSlotBJ(minlibanhek_z65,minlibanhek_z76)
if(GetItemCharges(minlibanhek_Z66)>0)then
set minlibanhek_z78=minlibanhek_z76+1
loop
exitwhen minlibanhek_z78>6
set minlibanhek_ZZ6Z=UnitItemInSlotBJ(minlibanhek_z65,minlibanhek_z78)
if(GetItemTypeId(minlibanhek_Z66)==GetItemTypeId(minlibanhek_ZZ6Z))then
call SetItemCharges(minlibanhek_Z66,(GetItemCharges(minlibanhek_Z66)+GetItemCharges(minlibanhek_ZZ6Z)))
call RemoveItem(minlibanhek_ZZ6Z)
endif
set minlibanhek_z78=minlibanhek_z78+1
endloop
endif
set minlibanhek_z76=minlibanhek_z76+1
endloop
set minlibanhek_Z66=null
set minlibanhek_ZZ6Z=null
set minlibanhek_z65=null
endfunction
function minlibanhek_ZZ7Z takes integer minlibanhek_z15,integer minlibanhek_Z75 returns nothing
local unit minlibanhek_z65
local item minlibanhek_z86
set minlibanhek_z65=FirstOfGroup(minlibanhek_Z8Z[minlibanhek_z15])
set minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z65,1)
call SetItemCharges(minlibanhek_z86,(GetItemCharges(minlibanhek_z86)+minlibanhek_Z75))
set minlibanhek_z86=null
set minlibanhek_z65=null
endfunction
function minlibanhek_ZZ8Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call GroupAddUnit(minlibanhek_z8Z,minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_ZZ9Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call GroupRemoveUnit(minlibanhek_z8Z,minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_ZzZZ takes nothing returns nothing
local unit minlibanhek_z65=GetTriggerUnit()
if((IsUnitDeadBJ(minlibanhek_z65))and(IsUnitType(minlibanhek_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(minlibanhek_z8Z,minlibanhek_z65)
endif
endfunction
function minlibanhek_ZzzZ takes nothing returns nothing
call ForGroup(minlibanhek_z8Z,function minlibanhek_ZzZZ)
endfunction
function minlibanhek_Zz0Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call ReviveHeroLoc(minlibanhek_z65,minlibanhek_Z9Z[minlibanhek_Zzz],true)
call SetUnitManaPercentBJ(minlibanhek_z65,100)
set minlibanhek_z65=null
endfunction
function minlibanhek_Zz1Z takes player minlibanhek_z05 returns nothing
local group minlibanhek_z46
set minlibanhek_z46=minlibanhek_Z94(minlibanhek_z05)
set minlibanhek_Zzz=GetPlayerId(minlibanhek_z05)
call ForGroup(minlibanhek_z46,function minlibanhek_Zz0Z)
call DestroyGroup(minlibanhek_z46)
set minlibanhek_z46=null
endfunction
function minlibanhek_Zz2Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call ModifyHeroStat(minlibanhek_z81,minlibanhek_z65,minlibanhek_z91,minlibanhek_z71)
set minlibanhek_z65=null
endfunction
function minlibanhek_Zz3Z takes integer minlibanhek_z15,integer minlibanhek_Zz4Z,integer minlibanhek_Zz5Z,boolean minlibanhek_z25 returns nothing
local integer minlibanhek_Zz6Z
if(minlibanhek_z25)then
set minlibanhek_Zz6Z=0
else
set minlibanhek_Zz6Z=1
endif
if(minlibanhek_Z0)then
set minlibanhek_z91=minlibanhek_Zz6Z
set minlibanhek_z81=minlibanhek_Zz4Z
set minlibanhek_z71=minlibanhek_Zz5Z
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Zz2Z)
else
call ModifyHeroStat(minlibanhek_Zz4Z,minlibanhek_z7[minlibanhek_z15],minlibanhek_Zz6Z,minlibanhek_Zz5Z)
endif
endfunction
function minlibanhek_Zz7Z takes unit minlibanhek_z65,integer minlibanhek_Zz5Z,boolean minlibanhek_z25 returns nothing
local integer minlibanhek_z15
set minlibanhek_z15=GetHeroLevel(minlibanhek_z65)
if(minlibanhek_z25)then
set minlibanhek_z15=minlibanhek_z15+minlibanhek_Zz5Z
else
set minlibanhek_z15=minlibanhek_z15-minlibanhek_Zz5Z
endif
call SetHeroLevelBJ(minlibanhek_z65,minlibanhek_z15,false)
endfunction
function minlibanhek_Zz8Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_Zz7Z(minlibanhek_z65,minlibanhek_ZZ2,minlibanhek_Z1z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Zz9Z takes integer minlibanhek_z15,integer minlibanhek_Zz5Z,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_ZZ2=minlibanhek_Zz5Z
set minlibanhek_Z1z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Zz8Z)
else
call minlibanhek_Zz7Z(minlibanhek_z7[minlibanhek_z15],minlibanhek_Zz5Z,minlibanhek_z25)
endif
endfunction
function minlibanhek_Z0ZZ takes string minlibanhek_Z0zZ returns integer
local string minlibanhek_Z00Z="0123456789"
local string minlibanhek_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string minlibanhek_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer Id=0
local integer minlibanhek_Z03Z=1
local integer minlibanhek_Z04Z=1
loop
exitwhen minlibanhek_Z03Z>StringLength(minlibanhek_Z0zZ)
loop
exitwhen minlibanhek_Z04Z>10
if SubString(minlibanhek_Z0zZ,minlibanhek_Z03Z-1,minlibanhek_Z03Z)==SubString(minlibanhek_Z00Z,minlibanhek_Z04Z-1,minlibanhek_Z04Z)then
set Id=Id+R2I((48+minlibanhek_Z04Z-1)*Pow(256.,I2R(StringLength(minlibanhek_Z0zZ)-minlibanhek_Z03Z)))
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
else
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
endif
endloop
set minlibanhek_Z04Z=1
loop
exitwhen minlibanhek_Z04Z>26
if SubString(minlibanhek_Z0zZ,minlibanhek_Z03Z-1,minlibanhek_Z03Z)==SubString(minlibanhek_Z01Z,minlibanhek_Z04Z-1,minlibanhek_Z04Z)then
set Id=Id+R2I(I2R(65+minlibanhek_Z04Z-1)*Pow(256.,I2R(StringLength(minlibanhek_Z0zZ)-minlibanhek_Z03Z)))
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
else
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
endif
endloop
set minlibanhek_Z04Z=1
loop
exitwhen minlibanhek_Z04Z>26
if SubString(minlibanhek_Z0zZ,minlibanhek_Z03Z-1,minlibanhek_Z03Z)==SubString(minlibanhek_Z02Z,minlibanhek_Z04Z-1,minlibanhek_Z04Z)then
set Id=Id+R2I((97+minlibanhek_Z04Z-1)*Pow(256.,I2R(StringLength(minlibanhek_Z0zZ)-minlibanhek_Z03Z)))
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
else
set minlibanhek_Z04Z=minlibanhek_Z04Z+1
endif
endloop
set minlibanhek_Z04Z=1
set minlibanhek_Z03Z=minlibanhek_Z03Z+1
endloop
return Id
endfunction
function minlibanhek_Z05Z takes integer minlibanhek_Z06Z returns string
local string minlibanhek_Z00Z="0123456789"
local string minlibanhek_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string minlibanhek_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string minlibanhek_Z07Z=""
local integer minlibanhek_Z03Z=0
local integer minlibanhek_Z08Z=0
loop
exitwhen minlibanhek_Z06Z==0
set minlibanhek_Z03Z=ModuloInteger(minlibanhek_Z06Z,256)
if minlibanhek_Z03Z>=48 and minlibanhek_Z03Z<=57 then
set minlibanhek_Z08Z=minlibanhek_Z03Z-48
set minlibanhek_Z07Z=SubString(minlibanhek_Z00Z,minlibanhek_Z08Z,minlibanhek_Z08Z+1)+minlibanhek_Z07Z
endif
if minlibanhek_Z03Z>=65 and minlibanhek_Z03Z<=90 then
set minlibanhek_Z08Z=minlibanhek_Z03Z-65
set minlibanhek_Z07Z=SubString(minlibanhek_Z01Z,minlibanhek_Z08Z,minlibanhek_Z08Z+1)+minlibanhek_Z07Z
endif
if minlibanhek_Z03Z>=97 and minlibanhek_Z03Z<=122 then
set minlibanhek_Z08Z=minlibanhek_Z03Z-97
set minlibanhek_Z07Z=SubString(minlibanhek_Z02Z,minlibanhek_Z08Z,minlibanhek_Z08Z+1)+minlibanhek_Z07Z
endif
set minlibanhek_Z06Z=minlibanhek_Z06Z/256
endloop
return minlibanhek_Z07Z
endfunction
function minlibanhek_Z09Z takes unit minlibanhek_z65 returns string
local integer minlibanhek_z15
set minlibanhek_z15=GetUnitTypeId(minlibanhek_z65)
if(minlibanhek_z15==0)then
return""
else
return minlibanhek_Z05Z(minlibanhek_z15)
endif
endfunction
function minlibanhek_Z1ZZ takes unit minlibanhek_z65 returns string
local item minlibanhek_z86=UnitItemInSlotBJ(minlibanhek_z65,1)
local integer minlibanhek_z15=GetItemTypeId(minlibanhek_z86)
if(minlibanhek_z15==0)then
return""
else
set minlibanhek_z86=null
return minlibanhek_Z05Z(minlibanhek_z15)
endif
endfunction
function minlibanhek_Z1zZ takes integer minlibanhek_Z10Z returns integer
local string minlibanhek_Z11Z=GetEventPlayerChatString()
if(StringLength(minlibanhek_Z11Z)==minlibanhek_Z10Z+3)then
return(minlibanhek_Z0ZZ(SubStringBJ(minlibanhek_Z11Z,minlibanhek_Z10Z,minlibanhek_Z10Z+3)))
else
return 0
endif
endfunction
function minlibanhek_Z12Z takes unit minlibanhek_z65,integer minlibanhek_z66,boolean minlibanhek_z25 returns nothing
local location minlibanhek_z95
local integer minlibanhek_z15
set minlibanhek_z15=minlibanhek_Z1zZ(minlibanhek_z66)
if(minlibanhek_z15==0)then
else
if(minlibanhek_z25)then
set minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
call CreateItemLoc(minlibanhek_z15,minlibanhek_z95)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
else
call UnitAddItemById(minlibanhek_z65,minlibanhek_z15)
endif
endif
endfunction
function minlibanhek_Z13Z takes unit minlibanhek_z65,real minlibanhek_Z14Z,boolean minlibanhek_z25 returns nothing
local location minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
local player minlibanhek_z05=GetOwningPlayer(minlibanhek_z65)
call SetBlightRadiusLocBJ(minlibanhek_z25,minlibanhek_z05,minlibanhek_z95,minlibanhek_Z14Z)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
set minlibanhek_z05=null
endfunction
function minlibanhek_Z15Z takes unit minlibanhek_z65,real minlibanhek_Z14Z returns nothing
call SetUnitFlyHeight(minlibanhek_z65,minlibanhek_Z14Z,.0)
endfunction
function minlibanhek_Z16Z takes nothing returns integer
local integer minlibanhek_Z17Z=0
local integer minlibanhek_Z18Z=0
local integer array minlibanhek_Z19Z
local integer minlibanhek_z15=0
local player minlibanhek_z05=GetLocalPlayer()
loop
exitwhen minlibanhek_z15>11
set minlibanhek_Z19Z[minlibanhek_z15]=0
set minlibanhek_z15=minlibanhek_z15+1
endloop
loop
exitwhen minlibanhek_Z17Z>14
call StoreInteger(minlibanhek_z03,"Hke_Player","Hke_number",GetPlayerId(minlibanhek_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(minlibanhek_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set minlibanhek_Z18Z=GetStoredInteger(minlibanhek_z03,"Hke_Player","Hke_number")-1
set minlibanhek_Z19Z[minlibanhek_Z18Z]=minlibanhek_Z19Z[minlibanhek_Z18Z]+1
call FlushStoredMission(minlibanhek_z03,"Hke_Player")
set minlibanhek_Z17Z=minlibanhek_Z17Z+1
endloop
set minlibanhek_Z18Z=0
set minlibanhek_Z17Z=0
set minlibanhek_z05=null
loop
exitwhen minlibanhek_Z17Z>11
if minlibanhek_Z19Z[minlibanhek_Z18Z]<minlibanhek_Z19Z[minlibanhek_Z17Z]then
set minlibanhek_Z18Z=minlibanhek_Z17Z
endif
set minlibanhek_Z17Z=minlibanhek_Z17Z+1
endloop
return minlibanhek_Z18Z+1
endfunction
function minlibanhek_Z2ZZ takes unit minlibanhek_z65,integer minlibanhek_Z2zZ,boolean minlibanhek_z25 returns nothing
if(minlibanhek_z25)then
call UnitAddAbility(minlibanhek_z65,minlibanhek_Z2zZ)
call SetUnitAbilityLevel(minlibanhek_z65,minlibanhek_Z2zZ,100)
call UnitMakeAbilityPermanent(minlibanhek_z65,true,minlibanhek_Z2zZ)
else
call UnitMakeAbilityPermanent(minlibanhek_z65,false,minlibanhek_Z2zZ)
call UnitRemoveAbility(minlibanhek_z65,minlibanhek_Z2zZ)
endif
endfunction
function minlibanhek_Z20Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_Z2ZZ(minlibanhek_z65,minlibanhek_zzz,minlibanhek_z0z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z21Z takes integer minlibanhek_z15,integer minlibanhek_Z2zZ,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_zzz=minlibanhek_Z2zZ
set minlibanhek_z0z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z20Z)
else
call minlibanhek_Z2ZZ(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z2zZ,minlibanhek_z25)
endif
endfunction
function minlibanhek_Z22Z takes string minlibanhek_Z11Z returns integer
if(minlibanhek_Z11Z=="mm")then
return 1094937907
endif
if(minlibanhek_Z11Z=="xj")then
return 1095659625
endif
if(minlibanhek_Z11Z=="zj")then
return 1095262824
endif
if(minlibanhek_Z11Z=="zm")then
return 1095721842
endif
if(minlibanhek_Z11Z=="ft")then
return 1096119411
endif
if(minlibanhek_Z11Z=="xx")then
return 1095333473
endif
if(minlibanhek_Z11Z=="sb")then
return 1095066998
endif
if(minlibanhek_Z11Z=="yx")then
return 1097886070
endif
if(minlibanhek_Z11Z=="rh")then
return 1095657827
endif
if(minlibanhek_Z11Z=="fl")then
return 1095656289
endif
if(minlibanhek_Z11Z=="bs")then
return 1094935923
endif
if(minlibanhek_Z11Z=="jg")then
return 1095332984
endif
if(minlibanhek_Z11Z=="jf")then
return 1095328816
endif
if(minlibanhek_Z11Z=="js")then
return 1095332728
endif
if(minlibanhek_Z11Z=="jm")then
return 1095332722
endif
if(minlibanhek_Z11Z=="jj")then
return 1095917932
endif
if(minlibanhek_Z11Z=="fy")then
return 1098150517
endif
if(minlibanhek_Z11Z=="ghh")then
return 1095262562
endif
if(minlibanhek_Z11Z=="ghj")then
return 1095721317
endif
if(minlibanhek_Z11Z=="gqj")then
return 1095065970
endif
if(minlibanhek_Z11Z=="gxx")then
return 1096114550
endif
if(minlibanhek_Z11Z=="gzz")then
return 1095262564
endif
if(minlibanhek_Z11Z=="gxe")then
return 1096114549
endif
if(minlibanhek_Z11Z=="gjj")then
return 1095065960
endif
if(minlibanhek_Z11Z=="gml")then
return 1094934883
endif
if(minlibanhek_Z11Z=="gyl")then
return 1097818482
endif
if(minlibanhek_Z11Z=="gjs")then
return 1096905580
endif
if(minlibanhek_Z11Z=="qhy")then
return 1095329378
endif
if(minlibanhek_Z11Z=="qdy")then
return 1095331938
endif
if(minlibanhek_Z11Z=="qlh")then
return 1095332719
endif
if(minlibanhek_Z11Z=="qyz")then
return 1095328878
endif
if(minlibanhek_Z11Z=="qbd")then
return 1095331682
endif
if(minlibanhek_Z11Z=="qfs")then
return 1095328610
endif
if(minlibanhek_Z11Z=="qsd")then
return 1095330924
endif
if(minlibanhek_Z11Z=="qjs")then
return 1095332706
endif
if(minlibanhek_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function minlibanhek_Z23Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call SetUnitInvulnerable(minlibanhek_z65,minlibanhek_z0z)
call minlibanhek_Z2ZZ(minlibanhek_z65,1098282348,minlibanhek_z0z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z24Z takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_z0z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z23Z)
else
call SetUnitInvulnerable(minlibanhek_z7[minlibanhek_z15],minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z7[minlibanhek_z15],1098282348,minlibanhek_z25)
endif
endfunction
function minlibanhek_Z25Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call SetUnitPathing(minlibanhek_z65,not(minlibanhek_z0z))
set minlibanhek_z65=null
endfunction
function YJYJ takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
call minlibanhek_z37()
set minlibanhek_z4=true
set minlibanhek_z5=minlibanhek_z05
call minlibanhek_z57(GetPlayerId(minlibanhek_z05),minlibanhek_z05)
endfunction
function minlibanhek_Z26Z takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_z0z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z25Z)
else
call SetUnitPathing(minlibanhek_z7[minlibanhek_z15],not(minlibanhek_z25))
endif
endfunction
function minlibanhek_Z27Z takes unit minlibanhek_z65,boolean minlibanhek_z25 returns nothing
if(minlibanhek_z25)then
call SetUnitMoveSpeed(minlibanhek_z65,1000)
else
call SetUnitMoveSpeed(minlibanhek_z65,GetUnitDefaultMoveSpeed(minlibanhek_z65))
endif
endfunction
function minlibanhek_Z28Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_Z27Z(minlibanhek_z65,minlibanhek_z0z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z29Z takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_z0z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z28Z)
else
call minlibanhek_Z27Z(minlibanhek_z7[minlibanhek_z15],minlibanhek_z25)
endif
endfunction
function minlibanhek_Z3ZZ takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
call minlibanhek_ZzzZ()
if(minlibanhek_Z0)then
if(minlibanhek_z25)then
if(CountUnitsInGroup(minlibanhek_z8Z)==0)then
call EnableTrigger(minlibanhek_z73)
endif
call GroupAddGroup(minlibanhek_Z8Z[minlibanhek_z15],minlibanhek_z8Z)
else
call GroupRemoveGroup(minlibanhek_Z8Z[minlibanhek_z15],minlibanhek_z8Z)
if(CountUnitsInGroup(minlibanhek_z8Z)==0)then
call DisableTrigger(minlibanhek_z73)
endif
endif
else
if(minlibanhek_z25)then
if(CountUnitsInGroup(minlibanhek_z8Z)==0)then
call EnableTrigger(minlibanhek_z73)
endif
call GroupAddUnit(minlibanhek_z8Z,minlibanhek_z7[minlibanhek_z15])
else
call GroupRemoveUnit(minlibanhek_z8Z,minlibanhek_z7[minlibanhek_z15])
if(CountUnitsInGroup(minlibanhek_z8Z)==0)then
call DisableTrigger(minlibanhek_z73)
endif
endif
endif
endfunction
function minlibanhek_Z3zZ takes unit minlibanhek_z65,boolean minlibanhek_z25 returns nothing
call minlibanhek_Z2ZZ(minlibanhek_z65,1095262562,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095721317,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095065970,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1096114550,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095262564,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1096114549,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1094934883,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095065960,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1097818482,minlibanhek_z25)
call minlibanhek_Z2ZZ(minlibanhek_z65,1096905580,minlibanhek_z25)
endfunction
function minlibanhek_Z30Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_Z3zZ(minlibanhek_z65,minlibanhek_z0z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z31Z takes integer minlibanhek_z15,boolean minlibanhek_z25 returns nothing
if(minlibanhek_Z0)then
set minlibanhek_z0z=minlibanhek_z25
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z30Z)
else
call minlibanhek_Z3zZ(minlibanhek_z7[minlibanhek_z15],minlibanhek_z25)
endif
endfunction
function minlibanhek_Z32Z takes unit minlibanhek_z65 returns nothing
call minlibanhek_Z2ZZ(minlibanhek_z65,1094937907,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095659625,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095262824,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095721842,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1096119411,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095333473,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095066998,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1097886070,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095657827,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095656289,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1098282348,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1094935923,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095332984,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095328816,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095332728,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1095332722,false)
call minlibanhek_Z2ZZ(minlibanhek_z65,1098150517,false)
call SetUnitInvulnerable(minlibanhek_z65,false)
call SetUnitPathing(minlibanhek_z65,true)
call minlibanhek_Z27Z(minlibanhek_z65,false)
call GroupRemoveUnit(minlibanhek_z8Z,minlibanhek_z65)
endfunction
function minlibanhek_Z33Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_Z32Z(minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z34Z takes integer minlibanhek_z15 returns nothing
if(minlibanhek_Z0)then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z33Z)
else
call minlibanhek_Z32Z(minlibanhek_z7[minlibanhek_z15])
endif
endfunction
function minlibanhek_Z35Z takes nothing returns nothing
local unit minlibanhek_z65=GetTriggerUnit()
local trigger minlibanhek_Z66=GetTriggeringTrigger()
call RemoveUnit(minlibanhek_z65)
call DisableTrigger(minlibanhek_Z66)
call DestroyTrigger(minlibanhek_Z66)
set minlibanhek_z65=null
set minlibanhek_Z66=null
endfunction
function minlibanhek_Z36Z takes integer minlibanhek_z66,unit minlibanhek_Z37Z,player minlibanhek_Z38Z returns nothing
local location minlibanhek_z95
local unit minlibanhek_z65
local integer minlibanhek_Z39Z=0
local integer minlibanhek_Z4ZZ=0
local trigger minlibanhek_Z66
if(minlibanhek_z66==0)then
set minlibanhek_Z39Z=1095726692
set minlibanhek_Z4ZZ=852503
endif
if(minlibanhek_z66==1)then
set minlibanhek_Z39Z=1095070833
set minlibanhek_Z4ZZ=852184
endif
if(minlibanhek_z66==2)then
set minlibanhek_Z39Z=1095070566
set minlibanhek_Z4ZZ=852183
endif
if((minlibanhek_Z39Z==0)and(minlibanhek_Z4ZZ==0))then
return
endif
set minlibanhek_z95=GetUnitLoc(minlibanhek_Z37Z)
set minlibanhek_z65=CreateUnitAtLoc(minlibanhek_Z38Z,1851941228,minlibanhek_z95,bj_UNIT_FACING)
call UnitAddAbility(minlibanhek_z65,1098282348)
call UnitAddAbility(minlibanhek_z65,minlibanhek_Z39Z)
call ShowUnit(minlibanhek_z65,false)
call SetUnitUseFood(minlibanhek_z65,false)
call SetUnitScale(minlibanhek_z65,.01,.01,.01)
call SetUnitState(minlibanhek_z65,UNIT_STATE_MANA,GetUnitState(minlibanhek_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(minlibanhek_z65,minlibanhek_Z4ZZ)
set minlibanhek_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(minlibanhek_Z66,minlibanhek_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(minlibanhek_Z66,minlibanhek_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(minlibanhek_Z66,function minlibanhek_Z35Z)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
set minlibanhek_Z66=null
set minlibanhek_z65=null
endfunction
function minlibanhek_Z4zZ takes unit minlibanhek_Z37Z returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local location minlibanhek_z95=GetUnitLoc(minlibanhek_Z37Z)
local trigger minlibanhek_Z66=CreateTrigger()
local unit minlibanhek_z65=CreateUnitAtLoc(minlibanhek_z05,1751543663,minlibanhek_z95,bj_UNIT_FACING)
call UnitAddAbility(minlibanhek_z65,1098282348)
call UnitAddAbility(minlibanhek_z65,1095332709)
call ShowUnit(minlibanhek_z65,false)
call SetUnitUseFood(minlibanhek_z65,false)
call SetUnitScale(minlibanhek_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(minlibanhek_z65,852592,minlibanhek_z95)
call TriggerRegisterUnitEvent(minlibanhek_Z66,minlibanhek_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(minlibanhek_Z66,minlibanhek_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(minlibanhek_Z66,function minlibanhek_Z35Z)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
set minlibanhek_Z66=null
set minlibanhek_z05=null
endfunction
function minlibanhek_Z40Z takes integer minlibanhek_z15,dialog minlibanhek_Z41Z,trigger minlibanhek_zZ6 returns nothing
set minlibanhek_Zz3[minlibanhek_z15]=minlibanhek_Z41Z
set minlibanhek_Z03[minlibanhek_z15]=minlibanhek_zZ6
endfunction
function minlibanhek_Z42Z takes integer minlibanhek_z15,string minlibanhek_Z43Z returns nothing
call DialogClear(minlibanhek_Zz3[minlibanhek_z15])
call DialogSetMessage(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z43Z+minlibanhek_Z0z+minlibanhek_Z62))
endfunction
function minlibanhek_Z44Z takes integer minlibanhek_z15,player minlibanhek_z05,boolean minlibanhek_z77 returns nothing
if(minlibanhek_z77)then
call EnableTrigger(minlibanhek_Z03[minlibanhek_z15])
call DialogDisplay(minlibanhek_z05,minlibanhek_Zz3[minlibanhek_z15],true)
call TimerStart(minlibanhek_Z73[minlibanhek_z15],minlibanhek_z1,false,null)
else
call DisableTrigger(minlibanhek_Z03[minlibanhek_z15])
call DialogDisplay(minlibanhek_z05,minlibanhek_Zz3[minlibanhek_z15],false)
endif
endfunction
function minlibanhek_Z45Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_zZ1[minlibanhek_z15],minlibanhek_ZZ1[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"主")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"资源菜单[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"自动化设置[B]",66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"选定单位特殊属性[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"个人选项设置[D]",68)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"帮助菜单[E]",69)
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"其他玩家作弊管理[F]",70)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"其他玩家管理[G]",71)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"游戏作弊选项[H]",72)
if(minlibanhek_z13)then
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z46Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local string minlibanhek_Z11Z
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Zz1[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"自动化设置")
if(IsTriggerEnabled(minlibanhek_z40[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(minlibanhek_z50[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(minlibanhek_z60[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(minlibanhek_z80[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(minlibanhek_z70[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(minlibanhek_z90[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"魔法释放后自动MP"+I2S(R2I(minlibanhek_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(minlibanhek_ZZ3[minlibanhek_z15]))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"生命低于"+I2S(R2I(minlibanhek_z92))+"%加到"+I2S(R2I(minlibanhek_z41))+"%[G]"),71)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"全部开启[O]",79)
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"全部关闭[U]",85)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z47Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z01[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"选定单位特殊属性")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"无敌[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"永久隐形[B]",66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"穿越物体[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"魔免[D]",68)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"反隐形[E]",69)
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"移动速度[F]",70)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"各种光环[G]",71)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"换页[N]",78)
if((minlibanhek_z9Z)or(minlibanhek_z5==minlibanhek_z05))then
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"秒杀模式[K]",75)
endif
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"取消全部(不含光环)[U]",85)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z48Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z91[minlibanhek_z15],minlibanhek_Z81[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"选定单位特殊属性")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"永久献祭[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"闪避[B]",514)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"重击[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"致命一击[D]",68)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"反弹(小强的壳)[E]",69)
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"分裂攻击[F]",70)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"燃灰[G]",71)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"减少魔法伤害33%[H]",72)
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"闪避100%[I]",73)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"换页[N]",78)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z49Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z91[minlibanhek_z15],minlibanhek_Z21[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"光环")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"辉煌光环[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"荆棘光环[B]",66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"耐久光环[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"强击光环[D]",68)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"邪恶光环[E]",69)
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"吸血光环[F]",70)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"专注光环[G]",71)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"命令光环(战鼓)[H]",72)
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"医疗光环[I]",73)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"减速光环[J]",74)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"关所有光环[K]",75)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z5ZZ takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local integer minlibanhek_Z75=0
local string minlibanhek_Z11Z
local string minlibanhek_Z5zZ
local player minlibanhek_Z65
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z51[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"玩家作弊管理")
loop
exitwhen minlibanhek_Z75>11
set minlibanhek_Z65=Player(minlibanhek_Z75)
if((GetPlayerController(minlibanhek_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(minlibanhek_Z65)==PLAYER_SLOT_STATE_PLAYING)and(minlibanhek_Z65!=minlibanhek_z5))then
set minlibanhek_Z5zZ=GetPlayerName(minlibanhek_Z65)
if(minlibanhek_z6[minlibanhek_Z75])then
set minlibanhek_Z11Z="禁止"
else
set minlibanhek_Z11Z="允许"
endif
set minlibanhek_ZzZ[minlibanhek_Z75]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+minlibanhek_Z5zZ+"作弊"),0)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z65=null
set minlibanhek_Z11Z=""
set minlibanhek_Z5zZ=""
endfunction
function minlibanhek_Z50Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
set minlibanhek_Z8[minlibanhek_z15]=0
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_zZ1[minlibanhek_z15],minlibanhek_Z71[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"单位")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"升100级[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("加三围"+(I2S(minlibanhek_Z3)+"[B]")),66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"复制物品[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"复制单位[D]",68)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"掉身上物品[E]",69)
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"共享该单位视野[F]",70)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"特殊属性菜单[G]",71)
if((minlibanhek_z7Z)or(minlibanhek_z5==minlibanhek_z05))then
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"控制它[H]",72)
endif
if(minlibanhek_z5==minlibanhek_z05)then
endif
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"改变单位所有者[J]",74)
endif
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z51Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local string minlibanhek_Z11Z
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z31[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"游戏作弊选项")
if(minlibanhek_Z0)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"操作所有单位[A]"),65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("设置背包数[B]"),66)
if(minlibanhek_Z5Z)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"保护CheatMaster[C]"),67)
if(minlibanhek_Z6Z)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(minlibanhek_Z7Z)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("取消作弊时"+minlibanhek_Z11Z+"地图全开[E]"),69)
if(minlibanhek_z9Z)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"他人秒杀模式[F]"),70)
if(minlibanhek_ZZz)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"禁止秒杀建筑[G]"),71)
if(minlibanhek_z7Z)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"他人占据单位[H]"),72)
if(minlibanhek_Z52)then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"禁止克隆操作农民[I]"),73)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z52Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local string minlibanhek_Z5zZ
local integer minlibanhek_Z75=0
local player minlibanhek_Z65
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z41[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"玩家管理")
loop
exitwhen minlibanhek_Z75>11
set minlibanhek_Z65=Player(minlibanhek_Z75)
if(GetPlayerSlotState(minlibanhek_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set minlibanhek_Z5zZ=GetPlayerName(minlibanhek_Z65)
set minlibanhek_ZzZ[minlibanhek_Z75]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("选择"+minlibanhek_Z5zZ+"操作"),0)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_ZzZ[12]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("选择中立生物操作"),90)
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z5zZ=""
set minlibanhek_Z65=null
endfunction
function minlibanhek_Z53Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local player minlibanhek_Z65=Player(minlibanhek_Z5z)
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z91[minlibanhek_z15],minlibanhek_Z61[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"玩家管理")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"资源管理[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"向他收税黄金"+I2S(minlibanhek_z22)+"%[C]",67)
else
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"向他收税木材"+I2S(minlibanhek_z22)+"%[D]",68)
else
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"停止向他收木材[D]",67)
endif
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回选择菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z65=null
endfunction
function minlibanhek_Z54Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local integer minlibanhek_Z75=0
local player minlibanhek_Z65
local string minlibanhek_Z11Z
local string minlibanhek_Z5zZ
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z91[minlibanhek_z15],minlibanhek_Z11[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"选定单位控制")
loop
exitwhen minlibanhek_Z75>12
set minlibanhek_Z65=Player(minlibanhek_Z75)
if(GetPlayerSlotState(minlibanhek_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set minlibanhek_Z5zZ=GetPlayerName(minlibanhek_Z65)
set minlibanhek_ZzZ[minlibanhek_Z75]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("给"+minlibanhek_Z5zZ+"控制"),0)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回单位菜单[R]",82)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z65=null
set minlibanhek_Z11Z=""
set minlibanhek_Z5zZ=""
endfunction
function minlibanhek_Z55Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local string minlibanhek_Z11Z
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Zz2[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"资源设置")
if(minlibanhek_z1Z[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="打开"
endif
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"地图[A]"),65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("复活死亡英雄[B]"),66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"人口清5[B]",66)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"总人口100[C]",67)
if(GetPlayerHandicap(minlibanhek_z05)==2)then
set minlibanhek_Z11Z="恢复生命障碍100%"
else
set minlibanhek_Z11Z="200%生命"
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(minlibanhek_z05)==2)then
set minlibanhek_Z11Z="恢复普通经验率"
else
set minlibanhek_Z11Z="2倍经验"
endif
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"[E]",69)
set minlibanhek_Z11Z=I2S(minlibanhek_Z2)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("加"+minlibanhek_Z11Z+"钱[F]"),70)
set minlibanhek_Z11Z=I2S(minlibanhek_z2)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("加"+minlibanhek_Z11Z+"木[G]"),71)
set minlibanhek_Z11Z=I2S(minlibanhek_Z2)
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("减"+minlibanhek_Z11Z+"钱[H]"),72)
set minlibanhek_Z11Z=I2S(minlibanhek_z2)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("减"+minlibanhek_Z11Z+"木[I]"),73)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z56Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local player minlibanhek_Z65=Player(minlibanhek_Z5z)
local string minlibanhek_Z11Z
local string minlibanhek_Z5zZ=GetPlayerName(minlibanhek_Z65)
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z02[minlibanhek_z15])
call DialogClear(minlibanhek_Z20[minlibanhek_z15])
call DialogSetMessage(minlibanhek_Z20[minlibanhek_z15],(minlibanhek_Z5zZ+"钱"+I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(minlibanhek_z1Z[minlibanhek_Z5z])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="打开"
endif
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],(minlibanhek_Z11Z+"地图[A]"),65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("复活死亡英雄[B]"),66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"人口清5[B]",66)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"总人口100[C]",67)
if(GetPlayerHandicap(minlibanhek_Z65)==2)then
set minlibanhek_Z11Z="恢复生命障碍100%"
else
set minlibanhek_Z11Z="200%生命"
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(minlibanhek_Z65)==2)then
set minlibanhek_Z11Z="恢复普通经验率"
else
set minlibanhek_Z11Z="2倍经验"
endif
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"[E]",69)
set minlibanhek_Z11Z=I2S(minlibanhek_Z2)
set minlibanhek_z7z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("加"+minlibanhek_Z11Z+"钱[F]"),70)
set minlibanhek_Z11Z=I2S(minlibanhek_z2)
set minlibanhek_z6z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("加"+minlibanhek_Z11Z+"木[G]"),71)
set minlibanhek_Z11Z=I2S(minlibanhek_Z2)
set minlibanhek_Zz0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("减"+minlibanhek_Z11Z+"钱[H]"),72)
set minlibanhek_Z11Z=I2S(minlibanhek_z2)
set minlibanhek_ZZ0[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("减"+minlibanhek_Z11Z+"木[I]"),73)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z11Z=""
set minlibanhek_Z5zZ=""
set minlibanhek_Z65=null
endfunction
function minlibanhek_Z57Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local player minlibanhek_Z65=Player(minlibanhek_Z5z)
local string minlibanhek_Z11Z
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z12[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"同盟管理")
if(IsPlayerAlly(minlibanhek_Z65,minlibanhek_z5))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("强制"+minlibanhek_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(minlibanhek_Z65,minlibanhek_z5))then
if(GetPlayerAlliance(minlibanhek_Z65,minlibanhek_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("强制"+minlibanhek_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(minlibanhek_Z65,minlibanhek_z5,ALLIANCE_SHARED_XP))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("强制"+minlibanhek_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(minlibanhek_z5,minlibanhek_Z65))then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],("强制"+minlibanhek_Z11Z+"对其同盟[D]"),68)
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回玩家菜单[R]",82)
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z65=null
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z58Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z91[minlibanhek_z15],minlibanhek_Z22[minlibanhek_z15])
call DialogClear(minlibanhek_Z91[minlibanhek_z15])
call DialogSetMessage(minlibanhek_Z91[minlibanhek_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(minlibanhek_z61)+"|r个")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"设置1个背包[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"设置2个背包[B]",66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"设置3个背包[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回选设置单[R]",82)
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z59Z takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z23[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"帮助")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"键盘帮助[A]",65)
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"CMD帮助[B]",66)
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"CMD单位类帮助[C]",67)
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"显示玩家信息[D]",68)
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"显示设置信息[E]",69)
endif
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
endfunction
function minlibanhek_Z6ZZ takes integer minlibanhek_z15,player minlibanhek_z05 returns nothing
local string minlibanhek_Z11Z
call minlibanhek_Z40Z(minlibanhek_z15,minlibanhek_Z20[minlibanhek_z15],minlibanhek_Z13[minlibanhek_z15])
call minlibanhek_Z42Z(minlibanhek_z15,"个人选项")
set minlibanhek_z2z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"删除我的复制单位[A]",65)
if(minlibanhek_z31[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z4z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"克隆操作[B]",66)
if(minlibanhek_Z33[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z5z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"组队克隆操作[C]",67)
if(minlibanhek_Z53[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z3z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"隐藏加攻[D]",68)
if(minlibanhek_Z63[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z9z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"隐藏加攻带溅射[E]",69)
if(minlibanhek_Z43[minlibanhek_z15])then
set minlibanhek_Z11Z="关闭"
else
set minlibanhek_Z11Z="开启"
endif
set minlibanhek_z8z[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],minlibanhek_Z11Z+"远程沉默[F]",70)
set minlibanhek_Z00[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"回主菜单[R]",82)
set minlibanhek_Z10[minlibanhek_z15]=DialogAddButton(minlibanhek_Zz3[minlibanhek_z15],"退出菜单[X]",88)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,true)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z6zZ takes player minlibanhek_z05 returns nothing
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"欢迎使用|cFFFF8C00hek的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r ")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function minlibanhek_Z60Z takes player minlibanhek_z05 returns nothing
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"欢迎使用|cFFFF8C00hek的作弊系列1.25b|r ")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(minlibanhek_z05==minlibanhek_z5)then
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function minlibanhek_Z61Z takes player minlibanhek_z05 returns nothing
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"欢迎使用|cFFFF8C00hek的作弊系列1.25b|r ")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(minlibanhek_z05==minlibanhek_z5)then
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function minlibanhek_Z62Z takes player minlibanhek_z05 returns nothing
local integer minlibanhek_Z75
local player minlibanhek_Z65
local string minlibanhek_Z11Z
local string minlibanhek_Z63Z
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,"|CFFFF0000hek1.25b|R ")
set minlibanhek_Z75=1
loop
exitwhen minlibanhek_Z75>12
set minlibanhek_Z65=Player(minlibanhek_Z75-1)
if(GetPlayerSlotState(minlibanhek_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set minlibanhek_Z63Z=I2S(minlibanhek_Z75)
set minlibanhek_Z11Z=(GetPlayerName(minlibanhek_Z65)+":编号:"+minlibanhek_Z63Z)
set minlibanhek_Z63Z=I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_GOLD))
set minlibanhek_Z11Z=(minlibanhek_Z11Z+" |CFFFFFF00黄金:"+minlibanhek_Z63Z+"|R")
set minlibanhek_Z63Z=I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set minlibanhek_Z11Z=(minlibanhek_Z11Z+" |CFF008000木头:"+minlibanhek_Z63Z+"|R")
set minlibanhek_Z63Z=I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set minlibanhek_Z11Z=(minlibanhek_Z11Z+" 人口:"+minlibanhek_Z63Z)
set minlibanhek_Z63Z=I2S(GetPlayerState(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set minlibanhek_Z11Z=(minlibanhek_Z11Z+"/"+minlibanhek_Z63Z)
set minlibanhek_Z11Z=minlibanhek_Z11Z+" 作弊:"
if(minlibanhek_z6[minlibanhek_Z75-1])then
set minlibanhek_Z11Z=minlibanhek_Z11Z+"|cFF00FF33√|r"
else
set minlibanhek_Z11Z=minlibanhek_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(minlibanhek_Z65)==MAP_CONTROL_USER)then
set minlibanhek_Z11Z=minlibanhek_Z11Z+" (玩家)"
if(minlibanhek_Z75-1==minlibanhek_zz3)then
set minlibanhek_Z11Z=minlibanhek_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set minlibanhek_Z11Z=minlibanhek_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,minlibanhek_Z11Z)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z65=null
set minlibanhek_Z11Z=""
set minlibanhek_Z63Z=""
endfunction
function minlibanhek_Z64Z takes nothing returns nothing
local string minlibanhek_Z65Z
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,"|CFFFF0000hek1.25b|R ")
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set minlibanhek_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(minlibanhek_z4Z)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(minlibanhek_z5Z)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(minlibanhek_z6Z)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(minlibanhek_ZZZ))
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(minlibanhek_z41))
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(minlibanhek_z92))
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(minlibanhek_zZ)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(minlibanhek_Zz)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(minlibanhek_zz)
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(minlibanhek_Z2)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(minlibanhek_z2)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(minlibanhek_Z3)
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(minlibanhek_z61)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(minlibanhek_Z1))
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(minlibanhek_z1))
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(minlibanhek_z42))
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(minlibanhek_z22)
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(minlibanhek_z3))
set minlibanhek_Z65Z=minlibanhek_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(minlibanhek_Z4))
call DisplayTimedTextToPlayer(minlibanhek_z5,0,0,minlibanhek_Z1,minlibanhek_Z65Z)
set minlibanhek_Z65Z=""
endfunction
function minlibanhek_Z66Z takes player minlibanhek_z05,unit minlibanhek_z65 returns nothing
local string minlibanhek_Z11Z=minlibanhek_Z09Z(minlibanhek_z65)
set minlibanhek_Z11Z="该单位的ID为|cFF33FF00"+minlibanhek_Z11Z+"|r"
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,minlibanhek_Z11Z)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z67Z takes player minlibanhek_z05,unit minlibanhek_z65 returns nothing
local string minlibanhek_Z11Z=minlibanhek_Z1ZZ(minlibanhek_z65)
set minlibanhek_Z11Z="该单位的第一格物品ID为|cFF33FF00"+minlibanhek_Z11Z+"|r"
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,minlibanhek_Z11Z)
set minlibanhek_Z11Z=""
endfunction
function minlibanhek_Z68Z takes integer minlibanhek_z15 returns nothing
local unit minlibanhek_z65=minlibanhek_z7[minlibanhek_z15]
local player minlibanhek_z05=Player(minlibanhek_z15)
local item minlibanhek_z86
local integer minlibanhek_Z75=0
local string minlibanhek_Z11Z
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"minlibanhek Unit Debug Info:")
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"单位X坐标:"+R2S(GetUnitX(minlibanhek_z65))+" 单位Y坐标:"+R2S(GetUnitY(minlibanhek_z65)))
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,"单位ID:"+minlibanhek_Z09Z(minlibanhek_z65))
if(IsUnitType(minlibanhek_z65,UNIT_TYPE_HERO))then
set minlibanhek_Z11Z="单位物品ID:"
loop
exitwhen minlibanhek_Z75>5
set minlibanhek_z86=UnitItemInSlot(minlibanhek_z65,minlibanhek_Z75)
set minlibanhek_Z11Z=minlibanhek_Z11Z+minlibanhek_Z05Z(GetItemTypeId(minlibanhek_z86))+" "
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call DisplayTimedTextToPlayer(minlibanhek_z05,0,0,minlibanhek_Z1,minlibanhek_Z11Z)
set minlibanhek_Z11Z=""
set minlibanhek_z86=null
endif
set minlibanhek_z65=null
set minlibanhek_z05=null
endfunction
function minlibanhek_Z69Z takes nothing returns nothing
if(minlibanhek_z0)then
set minlibanhek_Z62="主机版"
else
set minlibanhek_Z62="标准版"
endif
set minlibanhek_Z62=minlibanhek_Z62+" (添加 By |cFFFF0000"+minlibanhek_ZZ+"|r)"
if(minlibanhek_Z4Z=="")then
else
set minlibanhek_Z62=minlibanhek_Z62+"|n"+minlibanhek_Z4Z
endif
endfunction
function minlibanhek_Z7ZZ takes nothing returns nothing
local trigger minlibanhek_Z66=GetTriggeringTrigger()
local timer minlibanhek_Z76=GetExpiredTimer()
call DestroyTrigger(minlibanhek_Z66)
call DestroyTimer(minlibanhek_Z76)
set minlibanhek_z0=false
set minlibanhek_Z66=null
set minlibanhek_Z76=null
endfunction
function minlibanhek_Z7zZ takes nothing returns nothing
local timer minlibanhek_Z76
local trigger minlibanhek_Z66
set minlibanhek_z03=InitGameCache("WuHansen.Com")
set minlibanhek_zz3=minlibanhek_Z16Z()-1
if(minlibanhek_z0)then
set minlibanhek_Z76=CreateTimer()
set minlibanhek_Z66=CreateTrigger()
call TriggerAddAction(minlibanhek_Z66,function minlibanhek_Z7ZZ)
call TriggerRegisterTimerExpireEvent(minlibanhek_Z66,minlibanhek_Z76)
call TimerStart(minlibanhek_Z76,9.99,false,null)
set minlibanhek_Z76=null
set minlibanhek_Z66=null
endif
endfunction
function minlibanhek_Z70Z takes nothing returns nothing
local integer minlibanhek_z15=0
local timer minlibanhek_Z76=GetExpiredTimer()
local player minlibanhek_z05
loop
exitwhen minlibanhek_z15>11
if(minlibanhek_Z76==minlibanhek_Z73[minlibanhek_z15])then
set minlibanhek_z05=Player(minlibanhek_z15)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
set minlibanhek_z05=null
endif
set minlibanhek_z15=minlibanhek_z15+1
endloop
set minlibanhek_Z76=null
endfunction
function minlibanhek_Z71Z takes nothing returns nothing
local trigger minlibanhek_Z66=GetTriggeringTrigger()
call TriggerExecute(minlibanhek_Z66)
set minlibanhek_Z66=null
endfunction
function minlibanhek_Z72Z takes nothing returns nothing
local timer minlibanhek_Z66=CreateTimer()
local trigger minlibanhek_ZZ6Z=CreateTrigger()
call TriggerAddAction(minlibanhek_ZZ6Z,function minlibanhek_Z71Z)
call TriggerRegisterTimerExpireEvent(minlibanhek_ZZ6Z,minlibanhek_Z66)
call TimerStart(minlibanhek_Z66,GetRandomReal(299,1092),false,null)
endfunction
function minlibanhek_Z73Z takes nothing returns boolean
if(StringLength(minlibanhek_Z0z)==152)then
else
call minlibanhek_Z72Z()
endif
call TriggerClearConditions(minlibanhek_z43)
return true
endfunction
function minlibanhek_Z74Z takes nothing returns nothing
local integer minlibanhek_z15=0
local timer minlibanhek_Z76=GetExpiredTimer()
loop
exitwhen minlibanhek_z15>11
if(minlibanhek_Z76==minlibanhek_z0Z[minlibanhek_z15])then
set minlibanhek_Z7[minlibanhek_z15]=false
set minlibanhek_Z8[minlibanhek_z15]=0
set minlibanhek_Z32[minlibanhek_z15]=0
endif
set minlibanhek_z15=minlibanhek_z15+1
endloop
set minlibanhek_Z76=null
endfunction
function minlibanhek_Z75Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call UnitAddAbility(minlibanhek_z65,1095331446)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z76Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call UnitRemoveAbility(minlibanhek_z65,1095331446)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z77Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call UnitPauseTimedLife(minlibanhek_z65,true)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z78Z takes nothing returns nothing
local unit minlibanhek_z65
set minlibanhek_z65=GetEnumUnit()
call UnitPauseTimedLife(minlibanhek_z65,false)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z79Z takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_Z75
local real minlibanhek_Z14Z
local player minlibanhek_z05
local player minlibanhek_Z65
local string minlibanhek_Z11Z
local string minlibanhek_Z63Z
local string minlibanhek_Z5zZ
local string minlibanhek_Z65Z
local force minlibanhek_Z8ZZ
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_Z63Z=GetEventPlayerChatString()
set minlibanhek_Z63Z=StringCase(minlibanhek_Z63Z,false)
if(minlibanhek_z4)then
if(minlibanhek_z6[minlibanhek_z15])then
if(SubStringBJ(minlibanhek_Z63Z,1,1)=="-")then
if(minlibanhek_Z63Z=="-list")then
call minlibanhek_Z62Z(minlibanhek_z05)
endif
if(minlibanhek_Z63Z=="-h")then
call minlibanhek_Z6zZ(minlibanhek_z05)
endif
if(minlibanhek_Z63Z=="-c")then
call minlibanhek_Z60Z(minlibanhek_z05)
endif
if(minlibanhek_Z63Z=="-mm")then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_Z63Z=="-lx")then
set minlibanhek_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(minlibanhek_Z63Z,2,3)=="lt")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
call minlibanhek_Zz6(S2I(minlibanhek_Z11Z))
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,7,200)
if(SubStringBJ(minlibanhek_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,minlibanhek_Z1,GetPlayerName(minlibanhek_z05)+":"+minlibanhek_Z72+minlibanhek_Z11Z)
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="+")then
set minlibanhek_Z8ZZ=minlibanhek_z14(minlibanhek_z05)
call DisplayTimedTextToForce(minlibanhek_Z8ZZ,minlibanhek_Z1,GetPlayerName(minlibanhek_z05)+":"+minlibanhek_Z72+minlibanhek_Z11Z)
call DestroyForce(minlibanhek_Z8ZZ)
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
set minlibanhek_Z8ZZ=minlibanhek_z24(minlibanhek_z05)
call DisplayTimedTextToForce(minlibanhek_Z8ZZ,minlibanhek_Z1,GetPlayerName(minlibanhek_z05)+":"+minlibanhek_Z72+minlibanhek_Z11Z)
call DestroyForce(minlibanhek_Z8ZZ)
endif
set minlibanhek_Z8ZZ=null
endif
if(SubStringBJ(minlibanhek_Z63Z,2,3)=="zd")then
if((minlibanhek_z32)or(minlibanhek_z05==minlibanhek_z5))then
call minlibanhek_Z86()
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="k")then
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="l")then
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
set minlibanhek_z31[minlibanhek_z15]=false
else
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="+")then
set minlibanhek_z31[minlibanhek_z15]=true
endif
endif
else
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="-")then
call minlibanhek_z07(minlibanhek_z15,false)
else
call minlibanhek_z07(minlibanhek_z15,true)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="j")then
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="wd")then
call minlibanhek_Z36Z(0,minlibanhek_z7[minlibanhek_z15],minlibanhek_z05)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="nj")then
call minlibanhek_Z36Z(1,minlibanhek_z7[minlibanhek_z15],minlibanhek_z05)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="lx")then
call minlibanhek_Z36Z(2,minlibanhek_z7[minlibanhek_z15],minlibanhek_z05)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="r")then
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="n")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,20)
if(minlibanhek_Z11Z!="")then
call SetPlayerName(minlibanhek_z05,minlibanhek_Z11Z)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="h")then
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="+")then
call minlibanhek_zZ7(minlibanhek_z15,minlibanhek_z05,true)
else
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_zZ7(minlibanhek_z15,minlibanhek_z05,false)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="m")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz5(minlibanhek_z05,minlibanhek_Z75,false)
else
call minlibanhek_zz5(minlibanhek_z05,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="w")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_z35(minlibanhek_z05,minlibanhek_Z75,false)
else
call minlibanhek_z35(minlibanhek_z05,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="p ")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED,minlibanhek_Z75)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="pm")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,20))
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,minlibanhek_Z75)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="p")then
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="+")then
call PauseUnit(minlibanhek_z7[minlibanhek_z15],true)
else
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="-")then
call PauseUnit(minlibanhek_z7[minlibanhek_z15],false)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="h")then
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="dw")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call minlibanhek_ZZ4Z(minlibanhek_z15)
else
call minlibanhek_ZZ3Z(minlibanhek_z7[minlibanhek_z15])
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="sj")then
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
if minlibanhek_Z11Z=="-"then
call SuspendHeroXPBJ(false,minlibanhek_z7[minlibanhek_z15])
else
call SuspendHeroXPBJ(true,minlibanhek_z7[minlibanhek_z15])
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="e")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if minlibanhek_Z11Z=="-"then
call SetHeroXP(minlibanhek_z7[minlibanhek_z15],GetHeroXP(minlibanhek_z7[minlibanhek_z15])-minlibanhek_Z75,false)
else
call SetHeroXP(minlibanhek_z7[minlibanhek_z15],GetHeroXP(minlibanhek_z7[minlibanhek_z15])+minlibanhek_Z75,false)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="j")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if minlibanhek_Z11Z=="-"then
call ModifyHeroSkillPoints(minlibanhek_z7[minlibanhek_z15],1,minlibanhek_Z75)
else
if minlibanhek_Z11Z=="+"then
call ModifyHeroSkillPoints(minlibanhek_z7[minlibanhek_z15],0,minlibanhek_Z75)
else
call ModifyHeroSkillPoints(minlibanhek_z7[minlibanhek_z15],2,minlibanhek_Z75)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="u")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
if minlibanhek_Z75==0 then
set minlibanhek_Z75=1
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_Zz9Z(minlibanhek_z15,minlibanhek_Z75,false)
else
call minlibanhek_Zz9Z(minlibanhek_z15,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="l")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_zz
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_Zz3Z(minlibanhek_z15,0,minlibanhek_Z75,false)
else
call minlibanhek_Zz3Z(minlibanhek_z15,0,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="m")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_zz
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_Zz3Z(minlibanhek_z15,1,minlibanhek_Z75,false)
else
call minlibanhek_Zz3Z(minlibanhek_z15,1,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="z")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_zz
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_Zz3Z(minlibanhek_z15,2,minlibanhek_Z75,false)
else
call minlibanhek_Zz3Z(minlibanhek_z15,2,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="a")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,5,20))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_zz
endif
if(SubStringBJ(minlibanhek_Z63Z,4,4)=="-")then
call minlibanhek_Zz3Z(minlibanhek_z15,0,minlibanhek_Z75,false)
call minlibanhek_Zz3Z(minlibanhek_z15,1,minlibanhek_Z75,false)
call minlibanhek_Zz3Z(minlibanhek_z15,2,minlibanhek_Z75,false)
else
call minlibanhek_Zz3Z(minlibanhek_z15,0,minlibanhek_Z75,true)
call minlibanhek_Zz3Z(minlibanhek_z15,1,minlibanhek_Z75,true)
call minlibanhek_Zz3Z(minlibanhek_z15,2,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="r")then
call minlibanhek_Zz1Z(minlibanhek_z05)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="fz")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call minlibanhek_z98(minlibanhek_z15,true)
else
call minlibanhek_z98(minlibanhek_z15,false)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="db")then
call minlibanhek_ZZ5Z(minlibanhek_z15)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cw")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,20))
call minlibanhek_ZZ7Z(minlibanhek_z15,minlibanhek_Z75)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="a")then
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="m")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z40[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z40[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="w")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z50[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z50[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="p")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z60[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z60[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cd")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z80[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z80[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="mp")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z90[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z90[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="rs")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
if(minlibanhek_Z11Z=="-")then
call minlibanhek_zz6(minlibanhek_z70[minlibanhek_z15],false)
else
call minlibanhek_zz6(minlibanhek_z70[minlibanhek_z15],true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="a")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,4,4)
if(minlibanhek_Z11Z=="+")then
call minlibanhek_z16(minlibanhek_z15,true)
else
if(minlibanhek_Z11Z=="-")then
call minlibanhek_z16(minlibanhek_z15,false)
endif
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="u")then
if(minlibanhek_Z63Z=="-u")then
call minlibanhek_Z61Z(minlibanhek_z05)
else
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="g")then
set minlibanhek_Z75=minlibanhek_Z22Z(SubStringBJ(minlibanhek_Z63Z,3,5))
if(minlibanhek_Z75==0)then
else
if(SubStringBJ(minlibanhek_Z63Z,6,6)=="-")then
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,false)
else
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,4,5)=="ca")then
call minlibanhek_Z31Z(minlibanhek_z15,false)
endif
if(SubStringBJ(minlibanhek_Z63Z,4,5)=="oa")then
call minlibanhek_Z31Z(minlibanhek_z15,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,3)=="q")then
set minlibanhek_Z75=minlibanhek_Z22Z(SubStringBJ(minlibanhek_Z63Z,3,5))
if(minlibanhek_Z75==0)then
else
if(SubStringBJ(minlibanhek_Z63Z,6,6)=="-")then
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,false)
else
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,true)
endif
endif
endif
set minlibanhek_Z75=minlibanhek_Z22Z(SubStringBJ(minlibanhek_Z63Z,3,4))
if(minlibanhek_Z75==0)then
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,false)
else
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cq")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z26Z(minlibanhek_z15,false)
else
call minlibanhek_Z26Z(minlibanhek_z15,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="wd")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z24Z(minlibanhek_z15,false)
else
call minlibanhek_Z24Z(minlibanhek_z15,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="hp")then
set minlibanhek_Z14Z=S2R(SubStringBJ(minlibanhek_Z63Z,6,8))
if(minlibanhek_Z14Z<=100)then
call SetUnitLifePercentBJ(minlibanhek_z7[minlibanhek_z15],100-minlibanhek_Z14Z)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="mp")then
set minlibanhek_Z14Z=S2R(SubStringBJ(minlibanhek_Z63Z,6,8))
if(minlibanhek_Z14Z<=100)then
call SetUnitManaPercentBJ(minlibanhek_z7[minlibanhek_z15],100-minlibanhek_Z14Z)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="lt")then
call minlibanhek_Z16(S2I(SubStringBJ(minlibanhek_Z63Z,6,6)),minlibanhek_z7[minlibanhek_z15],SubStringBJ(minlibanhek_Z63Z,8,200))
endif
if((SubStringBJ(minlibanhek_Z63Z,3,4)=="kz")and((minlibanhek_z7Z)or(minlibanhek_z05==minlibanhek_z5)))then
set minlibanhek_Z65=minlibanhek_z05
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,20))
if(minlibanhek_Z75==0)then
else
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_Z65=Player(minlibanhek_Z75-1)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call SetUnitOwner(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z65,false)
else
call SetUnitOwner(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z65,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ys")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z29Z(minlibanhek_z15,false)
else
call minlibanhek_Z29Z(minlibanhek_z15,true)
endif
endif
if((SubStringBJ(minlibanhek_Z63Z,3,4)=="ms")and((minlibanhek_z9Z)or(minlibanhek_z05==minlibanhek_z5)))then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z3ZZ(minlibanhek_z15,false)
else
call minlibanhek_Z3ZZ(minlibanhek_z15,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ca")then
call minlibanhek_Z34Z(minlibanhek_z15)
endif
if((SubStringBJ(minlibanhek_Z63Z,3,4)=="jk")and(minlibanhek_z05==minlibanhek_z5))then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,20))
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z87(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z75,false)
else
call minlibanhek_Z87(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z75,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="yd")then
call minlibanhek_z55(minlibanhek_z51[minlibanhek_z15],minlibanhek_z7[minlibanhek_z15],false)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="jh")then
call minlibanhek_z55(minlibanhek_z7[minlibanhek_z15],minlibanhek_z51[minlibanhek_z15],true)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,5)=="del")then
if(SubStringBJ(minlibanhek_Z63Z,6,6)=="+")then
call minlibanhek_z36(minlibanhek_z05)
if(minlibanhek_z05==minlibanhek_z5)then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,7,8))
if((minlibanhek_Z75>0)and(minlibanhek_Z75<13))then
set minlibanhek_Z75=minlibanhek_Z75-1
set minlibanhek_Z65=Player(minlibanhek_Z75)
call minlibanhek_z36(minlibanhek_Z65)
endif
endif
else
call RemoveUnit(minlibanhek_z7[minlibanhek_z15])
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="nm")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,6))
if(minlibanhek_Z75==1)then
call minlibanhek_Z37(1752196449,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
if(minlibanhek_Z75==2)then
call minlibanhek_Z37(1869636975,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
if(minlibanhek_Z75==3)then
call minlibanhek_Z37(1702327152,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
if(minlibanhek_Z75==4)then
call minlibanhek_Z37(1969316719,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
if(minlibanhek_Z75==5)then
call minlibanhek_Z37(1852665957,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cu")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="?")then
call minlibanhek_Z66Z(minlibanhek_z05,minlibanhek_z7[minlibanhek_z15])
else
set minlibanhek_Z65Z=SubStringBJ(minlibanhek_Z63Z,6,20)
set minlibanhek_Z75=UnitId(minlibanhek_Z65Z)
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_Z1zZ(6)
endif
call minlibanhek_Z37(minlibanhek_Z75,minlibanhek_z05,minlibanhek_Z9Z[minlibanhek_z15])
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ci")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="?")then
call minlibanhek_Z67Z(minlibanhek_z05,minlibanhek_z7[minlibanhek_z15])
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call minlibanhek_Z12Z(minlibanhek_z7[minlibanhek_z15],6,false)
else
call minlibanhek_Z12Z(minlibanhek_z7[minlibanhek_z15],6,true)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ua")then
set minlibanhek_Z75=minlibanhek_Z1zZ(6)
if(minlibanhek_Z75==0)then
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,false)
else
call minlibanhek_Z21Z(minlibanhek_z15,minlibanhek_Z75,true)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="st")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,6,20)
if(minlibanhek_Z11Z=="")then
call CreateCorpse(minlibanhek_z05,GetUnitTypeId(minlibanhek_z7[minlibanhek_z15]),GetUnitX(minlibanhek_z7[minlibanhek_z15]),GetUnitY(minlibanhek_z7[minlibanhek_z15]),0)
else
call CreateCorpse(minlibanhek_z05,minlibanhek_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(minlibanhek_z7[minlibanhek_z15]),GetUnitY(minlibanhek_z7[minlibanhek_z15]),0)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,6)=="size")then
set minlibanhek_Z14Z=S2R(SubStringBJ(minlibanhek_Z63Z,8,10))
if(minlibanhek_Z14Z==0)then
set minlibanhek_Z14Z=100
endif
call SetUnitScalePercent(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z14Z,minlibanhek_Z14Z,minlibanhek_Z14Z)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(minlibanhek_z7[minlibanhek_z15],S2R(SubStringBJ(minlibanhek_Z63Z,6,8)),S2R(SubStringBJ(minlibanhek_Z63Z,10,12)),S2R(SubStringBJ(minlibanhek_Z63Z,14,16)),S2R(SubStringBJ(minlibanhek_Z63Z,18,20)))
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cl")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z18)
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z28)
else
call minlibanhek_z97(minlibanhek_z7[minlibanhek_z15],S2I(SubStringBJ(minlibanhek_Z63Z,6,6)),S2I(SubStringBJ(minlibanhek_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,5)=="inf")then
call minlibanhek_Z68Z(minlibanhek_z15)
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="sp")then
call MoveLocation(minlibanhek_Z9Z[minlibanhek_z15],GetUnitX(minlibanhek_z7[minlibanhek_z15]),GetUnitY(minlibanhek_z7[minlibanhek_z15]))
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="fz")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,20))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=1
endif
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
set minlibanhek_Z65=GetOwningPlayer(minlibanhek_z7[minlibanhek_z15])
call minlibanhek_Z77(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z65,minlibanhek_Z75)
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z47(minlibanhek_z7[minlibanhek_z15],minlibanhek_z05,minlibanhek_Z75,true)
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="h")then
call minlibanhek_z56(minlibanhek_z7[minlibanhek_z15],minlibanhek_z05)
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="d")then
if(GetUnitUserData(minlibanhek_z7[minlibanhek_z15])==2176)then
call SetUnitUserData(minlibanhek_z7[minlibanhek_z15],0)
endif
else
call minlibanhek_Z77(minlibanhek_z7[minlibanhek_z15],minlibanhek_z05,minlibanhek_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="hw")then
set minlibanhek_Z14Z=S2R(SubStringBJ(minlibanhek_Z63Z,6,8))
if(minlibanhek_Z14Z==0)then
set minlibanhek_Z14Z=500
endif
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z13Z(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z14Z,false)
else
call minlibanhek_Z13Z(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z14Z,true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="fg")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call minlibanhek_Z15Z(minlibanhek_z7[minlibanhek_z15],GetUnitDefaultFlyHeight(minlibanhek_z7[minlibanhek_z15]))
else
call minlibanhek_Z15Z(minlibanhek_z7[minlibanhek_z15],S2R(SubStringBJ(minlibanhek_Z63Z,6,9)))
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="yj")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z77Z)
else
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z78Z)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ss")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
set minlibanhek_Z75=minlibanhek_zz8(S2I(SubStringBJ(minlibanhek_Z63Z,6,7)))
if(minlibanhek_Z75==0)then
set minlibanhek_Z75=minlibanhek_z18()
endif
if(minlibanhek_Z11Z=="+")then
call minlibanhek_z28(minlibanhek_z7[minlibanhek_z15],1,minlibanhek_Z75,S2I(SubStringBJ(minlibanhek_Z63Z,8,10)))
endif
if(minlibanhek_Z11Z=="-")then
call minlibanhek_z28(minlibanhek_z7[minlibanhek_z15],2,minlibanhek_Z75,S2I(SubStringBJ(minlibanhek_Z63Z,8,10)))
endif
if(minlibanhek_Z11Z=="/")then
call minlibanhek_z28(minlibanhek_z7[minlibanhek_z15],3,minlibanhek_Z75,S2I(SubStringBJ(minlibanhek_Z63Z,8,10)))
endif
if(minlibanhek_Z11Z=="*")then
call minlibanhek_z28(minlibanhek_z7[minlibanhek_z15],4,minlibanhek_Z75,S2I(SubStringBJ(minlibanhek_Z63Z,8,10)))
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,6)=="hero")then
if(SubStringBJ(minlibanhek_Z63Z,7,7)=="+")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z75Z)
else
if(SubStringBJ(minlibanhek_Z63Z,7,7)=="-")then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_Z76Z)
endif
endif
endif
endif
endif
if(minlibanhek_z05==minlibanhek_z5)then
if(SubStringBJ(minlibanhek_Z63Z,2,2)=="g")then
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="tr")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
set minlibanhek_Z65=GetOwningPlayer(minlibanhek_z7[minlibanhek_z15])
if(minlibanhek_Z65==minlibanhek_z05)then
else
call CustomDefeatBJ(minlibanhek_Z65,SubStringBJ(minlibanhek_Z63Z,6,200))
endif
else
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,7))
if((minlibanhek_Z75>0)and(minlibanhek_Z75<13)and((minlibanhek_Z75==minlibanhek_z15)==false))then
set minlibanhek_Z65=Player(minlibanhek_Z75-1)
call CustomDefeatBJ(minlibanhek_Z65,SubStringBJ(minlibanhek_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="dx")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="+")then
set minlibanhek_Z65=GetOwningPlayer(minlibanhek_z7[minlibanhek_z15])
if(minlibanhek_Z65==minlibanhek_z05)then
else
if(GetPlayerId(minlibanhek_Z65)!=minlibanhek_zz3)then
call minlibanhek_z45(minlibanhek_Z65)
endif
endif
else
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,7))
if((minlibanhek_Z75>0)and(minlibanhek_Z75<13)and((minlibanhek_Z75==minlibanhek_z15)==false))then
set minlibanhek_Z65=Player(minlibanhek_Z75-1)
if(GetPlayerId(minlibanhek_Z65)!=minlibanhek_zz3)then
call minlibanhek_z45(minlibanhek_Z65)
endif
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="tq")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
if(minlibanhek_Z11Z=="-")then
if(S2I(SubStringBJ(minlibanhek_Z63Z,6,7))==0)then
call minlibanhek_zZ8()
else
call minlibanhek_Z98(S2I(SubStringBJ(minlibanhek_Z63Z,6,7)),false)
endif
else
call minlibanhek_Z98(S2I(SubStringBJ(minlibanhek_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ss")then
call minlibanhek_Z08(S2I(SubStringBJ(minlibanhek_Z63Z,6,6)),S2I(SubStringBJ(minlibanhek_Z63Z,8,8)))
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="tk")then
call minlibanhek_Z58(S2I(SubStringBJ(minlibanhek_Z63Z,6,7)))
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="cp")then
set minlibanhek_Z11Z=SubStringBJ(minlibanhek_Z63Z,5,5)
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,7))
if((minlibanhek_Z75>0)and(minlibanhek_Z75<13)and(minlibanhek_Z75!=minlibanhek_z15+1))then
set minlibanhek_Z75=(minlibanhek_Z75-1)
set minlibanhek_Z65=Player(minlibanhek_Z75)
if(GetPlayerController(minlibanhek_Z65)==MAP_CONTROL_USER)then
if(minlibanhek_Z11Z=="+")then
call minlibanhek_z57(minlibanhek_Z75,minlibanhek_Z65)
else
if(minlibanhek_Z11Z=="-")then
call minlibanhek_z47(minlibanhek_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(minlibanhek_Z63Z,6,7)))
endif
if(SubStringBJ(minlibanhek_Z63Z,3,7)=="pause")then
if(SubStringBJ(minlibanhek_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="tm")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,6,7))
set minlibanhek_Z65=Player(minlibanhek_Z75-1)
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,10))
call SetPlayerAllianceStateBJ(minlibanhek_Z65,Player(minlibanhek_Z75-1),S2I(SubStringBJ(minlibanhek_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(minlibanhek_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(minlibanhek_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(minlibanhek_Z63Z,12,13))
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,3,4)=="ca")then
if(SubStringBJ(minlibanhek_Z63Z,5,5)=="-")then
set minlibanhek_Z0=false
else
set minlibanhek_Z0=true
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,2,4)=="set")then
if(minlibanhek_Z63Z=="-set")then
call minlibanhek_Z64Z()
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="am")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_z4Z=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="aw")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_z5Z=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="ap")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75>5)then
set minlibanhek_z6Z=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,8)=="amp")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,10,30))
set minlibanhek_Z14Z=I2R(minlibanhek_Z75)
if(minlibanhek_Z14Z>=50.)then
set minlibanhek_ZZZ=minlibanhek_Z14Z
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,8)=="ahp")then
if(SubStringBJ(minlibanhek_Z63Z,9,9)=="t")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,11,30))
set minlibanhek_Z14Z=I2R(minlibanhek_Z75)
if((minlibanhek_Z14Z!=0)and(minlibanhek_Z14Z<=100)and(minlibanhek_Z14Z<=minlibanhek_z41))then
set minlibanhek_z92=I2R(minlibanhek_Z75)
endif
else
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,10,30))
if((minlibanhek_Z75!=0)and(minlibanhek_Z75<=100))then
set minlibanhek_z41=I2R(minlibanhek_Z75)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="km")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_zZ=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="kw")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_Zz=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="kg")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_zz=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="mg")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_Z3=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="it")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_Z1=I2R(minlibanhek_Z75)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="mt")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_z1=I2R(minlibanhek_Z75)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="ha")then
if(SubStringBJ(minlibanhek_Z63Z,8,8)=="p")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,10,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_Z4=I2R(minlibanhek_Z75)
endif
else
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if(minlibanhek_Z75!=0)then
set minlibanhek_z3=I2R(minlibanhek_Z75)
endif
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,8)=="bag")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,10,10))
if((minlibanhek_Z75>0)and(minlibanhek_Z75<4))then
set minlibanhek_z61=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="rt")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if((minlibanhek_Z75!=0)and(minlibanhek_Z75<=100))then
set minlibanhek_z22=minlibanhek_Z75
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="zd")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
if((minlibanhek_Z75!=0)and(minlibanhek_Z75<=100))then
set minlibanhek_z42=I2R(minlibanhek_Z75)
endif
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="mw")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
set minlibanhek_z2=minlibanhek_Z75
endif
if(SubStringBJ(minlibanhek_Z63Z,6,7)=="mm")then
set minlibanhek_Z75=S2I(SubStringBJ(minlibanhek_Z63Z,9,30))
set minlibanhek_Z2=minlibanhek_Z75
endif
endif
endif
endif
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_Z11Z=""
set minlibanhek_Z63Z=""
set minlibanhek_Z5zZ=""
set minlibanhek_Z65Z=""
endfunction
function minlibanhek_Z8zZ takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_Z75
local player minlibanhek_z05
local string minlibanhek_Z11Z
local string minlibanhek_Z63Z
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_Z11Z=GetEventPlayerChatString()
set minlibanhek_Z63Z=StringCase(GetPlayerName(minlibanhek_z5),false)
if((minlibanhek_Z63Z==StringCase(SubStringBJ(minlibanhek_Z0z,18,20),false))or(minlibanhek_Z63Z==SubStringBJ(minlibanhek_Z0z,32,37)))then
else
if(minlibanhek_Z11Z=="iam"+SubStringBJ(minlibanhek_Z0z,139,146))then
set minlibanhek_z4=false
set minlibanhek_z5=null
set minlibanhek_Z75=0
loop
exitwhen minlibanhek_Z75>11
call minlibanhek_z47(minlibanhek_Z75)
call EnableTrigger(minlibanhek_z00[minlibanhek_Z75])
call EnableTrigger(minlibanhek_z10[minlibanhek_Z75])
call EnableTrigger(minlibanhek_z20[minlibanhek_Z75])
call EnableTrigger(HKE_Yj)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
else
if((minlibanhek_Z11Z==SubStringBJ(minlibanhek_Z0z,139,146)+"ismatser")and(minlibanhek_z4))then
set minlibanhek_z5=minlibanhek_z05
set minlibanhek_z6[minlibanhek_z15]=true
endif
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z11Z=""
set minlibanhek_Z63Z=""
endfunction
function minlibanhek_Z80Z takes nothing returns nothing
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set minlibanhek_z05=null
endfunction
function minlibanhek_Z81Z takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_Z75
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])and(GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)<=minlibanhek_z4Z))then
set minlibanhek_Z75=(minlibanhek_z4Z/2)
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)+minlibanhek_Z75))
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(minlibanhek_z05,PLAYER_STATE_GOLD_GATHERED)-minlibanhek_Z75))
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z82Z takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_Z75
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])and(GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)<=minlibanhek_z5Z))then
set minlibanhek_Z75=(minlibanhek_z5Z/2)
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)+minlibanhek_Z75))
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(minlibanhek_z05,PLAYER_STATE_LUMBER_GATHERED)-minlibanhek_Z75))
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z83Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if((GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=minlibanhek_z6Z)or(GetPlayerState(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z84Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
local location minlibanhek_z95
set minlibanhek_z65=GetTriggerUnit()
set minlibanhek_z05=GetOwningPlayer(minlibanhek_z65)
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
set minlibanhek_z95=GetUnitLoc(minlibanhek_z65)
call ReviveHeroLoc(minlibanhek_z65,minlibanhek_z95,false)
call SetUnitState(minlibanhek_z65,UNIT_STATE_MANA,GetUnitState(minlibanhek_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(minlibanhek_z65)
call RemoveLocation(minlibanhek_z95)
endif
set minlibanhek_z65=null
set minlibanhek_z05=null
set minlibanhek_z95=null
endfunction
function minlibanhek_Z85Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
set minlibanhek_z65=GetTriggerUnit()
call UnitResetCooldown(minlibanhek_z65)
set minlibanhek_z65=null
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z86Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
set minlibanhek_z65=GetTriggerUnit()
call SetUnitState(minlibanhek_z65,UNIT_STATE_MANA,GetUnitState(minlibanhek_z65,UNIT_STATE_MAX_MANA)*minlibanhek_ZZZ*.01)
set minlibanhek_z65=null
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z87Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
set minlibanhek_z65=GetTriggerUnit()
if(GetUnitLifePercent(minlibanhek_z65)<=minlibanhek_z92)then
call SetUnitLifePercentBJ(minlibanhek_z65,minlibanhek_z41)
endif
set minlibanhek_z65=null
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z88Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local player minlibanhek_Z65
local unit minlibanhek_z65
set minlibanhek_z65=GetTriggerUnit()
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
call GroupAddUnit(minlibanhek_Z8Z[minlibanhek_z15],minlibanhek_z65)
if(minlibanhek_z7[minlibanhek_z15]==minlibanhek_z65)then
set minlibanhek_Z8[minlibanhek_z15]=(minlibanhek_Z8[minlibanhek_z15]+1)
if(CountUnitsInGroup(minlibanhek_Z8Z[minlibanhek_z15])>1)then
call GroupClear(minlibanhek_Z8Z[minlibanhek_z15])
call GroupAddUnit(minlibanhek_Z8Z[minlibanhek_z15],minlibanhek_z65)
endif
if((minlibanhek_Z8[minlibanhek_z15]==2)and(minlibanhek_Z7[minlibanhek_z15]))then
call minlibanhek_Z50Z(minlibanhek_z15,minlibanhek_z05)
endif
else
set minlibanhek_Z8[minlibanhek_z15]=1
set minlibanhek_z51[minlibanhek_z15]=minlibanhek_z7[minlibanhek_z15]
endif
endif
if(minlibanhek_Z43[minlibanhek_z15])then
if((minlibanhek_zzZ[minlibanhek_z15])and(minlibanhek_zZZ[minlibanhek_z15]))then
set minlibanhek_Z65=GetOwningPlayer(minlibanhek_z65)
if(IsUnitAlly(minlibanhek_z65,minlibanhek_z05)or(minlibanhek_Z65==minlibanhek_z05))then
else
call minlibanhek_Z4zZ(minlibanhek_z65)
endif
endif
endif
set minlibanhek_z7[minlibanhek_z15]=minlibanhek_z65
set minlibanhek_z65=null
set minlibanhek_z05=null
endfunction
function minlibanhek_Z89Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
set minlibanhek_z65=GetTriggerUnit()
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
call GroupRemoveUnit(minlibanhek_Z8Z[minlibanhek_z15],minlibanhek_z65)
endif
set minlibanhek_z65=null
set minlibanhek_z05=null
endfunction
function minlibanhek_Z9ZZ takes nothing returns nothing
local unit minlibanhek_z65=GetAttacker()
local unit minlibanhek_z76=GetTriggerUnit()
local player minlibanhek_z05=GetOwningPlayer(minlibanhek_z65)
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local player minlibanhek_Z65=GetOwningPlayer(minlibanhek_z76)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if((IsUnitInGroup(minlibanhek_z65,minlibanhek_z8Z))and((minlibanhek_Z65!=minlibanhek_z5)or(minlibanhek_z05==minlibanhek_z5)or(minlibanhek_Z5Z==false))and((IsUnitType(minlibanhek_z76,UNIT_TYPE_STRUCTURE)==false)or(minlibanhek_ZZz==false)))then
call SetWidgetLife(minlibanhek_z76,1.)
call UnitDamageTargetBJ(minlibanhek_z65,minlibanhek_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z65=null
set minlibanhek_z76=null
endfunction
function minlibanhek_Z9zZ takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
local location minlibanhek_z95
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])and(minlibanhek_Z1Z[minlibanhek_z15])and(minlibanhek_Z2Z[minlibanhek_z15])and(GetIssuedOrderId()==851971))then
set minlibanhek_z65=GetTriggerUnit()
set minlibanhek_z95=GetOrderPointLoc()
call SetUnitPositionLoc(minlibanhek_z65,minlibanhek_z95)
call RemoveLocation(minlibanhek_z95)
endif
set minlibanhek_z65=null
set minlibanhek_z05=null
set minlibanhek_z95=null
endfunction
function minlibanhek_Z90Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])and(minlibanhek_Z1Z[minlibanhek_z15])and(minlibanhek_Z2Z[minlibanhek_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),minlibanhek_z05)+1),minlibanhek_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z91Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
local unit minlibanhek_z65
local unit minlibanhek_z76
local location minlibanhek_z95
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])and(minlibanhek_Z1Z[minlibanhek_z15])and(minlibanhek_Z2Z[minlibanhek_z15]))then
set minlibanhek_z65=GetTriggerUnit()
set minlibanhek_z95=GetUnitRallyPoint(minlibanhek_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),minlibanhek_z05,minlibanhek_z95,bj_UNIT_FACING)
set minlibanhek_z76=bj_lastCreatedUnit
if(minlibanhek_Z6Z)then
call SetUnitUseFood(minlibanhek_z76,false)
endif
call IssueImmediateOrderById(minlibanhek_z65,851976)
if(IsUnitType(minlibanhek_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[minlibanhek_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(minlibanhek_z76,1937012592)
set bj_meleeTwinkedHeroes[minlibanhek_z15]=bj_meleeTwinkedHeroes[minlibanhek_z15]+1
endif
endif
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z95=null
set minlibanhek_z05=null
set minlibanhek_z76=null
set minlibanhek_z65=null
endif
endfunction
function minlibanhek_Z92Z takes nothing returns nothing
local unit minlibanhek_z65=GetAttacker()
local unit minlibanhek_z76=GetEnumUnit()
local player minlibanhek_z05=GetOwningPlayer(minlibanhek_z65)
local player minlibanhek_Z65=GetOwningPlayer(minlibanhek_z76)
if(IsUnitAlly(minlibanhek_z65,minlibanhek_z05)or(minlibanhek_Z65==minlibanhek_z05))then
else
call UnitDamageTargetBJ(minlibanhek_z65,minlibanhek_z76,(minlibanhek_z3*minlibanhek_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z65=null
set minlibanhek_z76=null
endfunction
function minlibanhek_Z93Z takes nothing returns nothing
local unit minlibanhek_z65=GetAttacker()
local unit minlibanhek_z76=GetTriggerUnit()
local player minlibanhek_z05=GetOwningPlayer(minlibanhek_z65)
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local player minlibanhek_Z65=GetOwningPlayer(minlibanhek_z76)
local group minlibanhek_z46
local location minlibanhek_z95
if(minlibanhek_Z53[minlibanhek_z15])then
call UnitDamageTargetBJ(minlibanhek_z65,minlibanhek_z76,minlibanhek_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(minlibanhek_Z63[minlibanhek_z15])then
set minlibanhek_z95=GetUnitLoc(minlibanhek_z76)
set minlibanhek_z46=minlibanhek_Z64(100,minlibanhek_z95)
call ForGroup(minlibanhek_z46,function minlibanhek_Z92Z)
call DestroyGroup(minlibanhek_z46)
call RemoveLocation(minlibanhek_z95)
set minlibanhek_z46=null
set minlibanhek_z95=null
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z65=null
set minlibanhek_z76=null
endfunction
function minlibanhek_Z94Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call IssueImmediateOrderById(minlibanhek_z65,minlibanhek_Z7z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z95Z takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_z66
local player minlibanhek_z05
local unit minlibanhek_z65
local group minlibanhek_z46
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_z66=GetIssuedOrderId()
if(minlibanhek_z1z)then
if((minlibanhek_zZZ[minlibanhek_z15])and(minlibanhek_zzZ[minlibanhek_z15])and(minlibanhek_z31[minlibanhek_z15]))then
set minlibanhek_z1z=false
set minlibanhek_z65=GetTriggerUnit()
if((minlibanhek_Z52==false)or(IsUnitType(minlibanhek_z65,UNIT_TYPE_PEON)==false))then
call minlibanhek_z67(minlibanhek_z15,false)
set minlibanhek_Z7z=minlibanhek_z66
set minlibanhek_z46=minlibanhek_zz4(minlibanhek_z05,GetUnitTypeId(minlibanhek_z65))
call ForGroup(minlibanhek_z46,function minlibanhek_Z94Z)
call DestroyGroup(minlibanhek_z46)
set minlibanhek_z46=null
endif
call minlibanhek_z67(minlibanhek_z15,true)
set minlibanhek_z1z=true
set minlibanhek_z65=null
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z96Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call IssuePointOrderById(minlibanhek_z65,minlibanhek_Z7z,minlibanhek_Z8z,minlibanhek_Z9z)
set minlibanhek_z65=null
endfunction
function minlibanhek_Z97Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call GroupAddUnit(minlibanhek_Z83,minlibanhek_z65)
set minlibanhek_Z93=minlibanhek_Z93+1
if(minlibanhek_Z93==12)then
call GroupPointOrderById(minlibanhek_Z83,minlibanhek_Z7z,minlibanhek_Z8z,minlibanhek_Z9z)
set minlibanhek_Z93=0
call GroupClear(minlibanhek_Z83)
endif
set minlibanhek_z65=null
endfunction
function minlibanhek_Z98Z takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_z66
local player minlibanhek_z05
local unit minlibanhek_z65
local group minlibanhek_z46
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_z66=GetIssuedOrderId()
if(minlibanhek_z1z)then
if((minlibanhek_zZZ[minlibanhek_z15])and(minlibanhek_zzZ[minlibanhek_z15])and(minlibanhek_z31[minlibanhek_z15]))then
set minlibanhek_z1z=false
set minlibanhek_z65=GetTriggerUnit()
if((minlibanhek_Z52==false)or(IsUnitType(minlibanhek_z65,UNIT_TYPE_PEON)==false))then
call minlibanhek_z67(minlibanhek_z15,false)
set minlibanhek_Z7z=minlibanhek_z66
set minlibanhek_Z8z=GetOrderPointX()
set minlibanhek_Z9z=GetOrderPointY()
set minlibanhek_z46=minlibanhek_zz4(minlibanhek_z05,GetUnitTypeId(minlibanhek_z65))
if(minlibanhek_Z33[minlibanhek_z15])then
set minlibanhek_Z93=0
call GroupClear(minlibanhek_Z83)
call ForGroup(minlibanhek_z46,function minlibanhek_Z97Z)
if(minlibanhek_Z93==12)then
else
call GroupPointOrderById(minlibanhek_Z83,minlibanhek_Z7z,minlibanhek_Z8z,minlibanhek_Z9z)
endif
else
call ForGroup(minlibanhek_z46,function minlibanhek_Z96Z)
endif
call DestroyGroup(minlibanhek_z46)
set minlibanhek_z46=null
endif
call minlibanhek_z67(minlibanhek_z15,true)
set minlibanhek_z1z=true
set minlibanhek_z65=null
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_Z99Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call IssueTargetOrderById(minlibanhek_z65,minlibanhek_Z7z,minlibanhek_zZz)
set minlibanhek_z65=null
endfunction
function minlibanhek_zZZZ takes nothing returns nothing
local integer minlibanhek_z15
local integer minlibanhek_z66
local player minlibanhek_z05
local unit minlibanhek_z65
local group minlibanhek_z46
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_z66=GetIssuedOrderId()
if(minlibanhek_z1z)then
if((minlibanhek_zZZ[minlibanhek_z15])and(minlibanhek_zzZ[minlibanhek_z15])and(minlibanhek_z31[minlibanhek_z15]))then
set minlibanhek_z1z=false
set minlibanhek_z65=GetTriggerUnit()
if((minlibanhek_Z52==false)or(IsUnitType(minlibanhek_z65,UNIT_TYPE_PEON)==false))then
call minlibanhek_z67(minlibanhek_z15,false)
set minlibanhek_Z7z=minlibanhek_z66
set minlibanhek_zZz=GetOrderTargetUnit()
if(minlibanhek_zZz==null)then
else
set minlibanhek_z46=minlibanhek_zz4(minlibanhek_z05,GetUnitTypeId(minlibanhek_z65))
call ForGroup(minlibanhek_z46,function minlibanhek_Z99Z)
call DestroyGroup(minlibanhek_z46)
set minlibanhek_z46=null
set minlibanhek_z65=null
endif
endif
call minlibanhek_z67(minlibanhek_z15,true)
set minlibanhek_z1z=true
set minlibanhek_z65=null
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zZzZ takes unit minlibanhek_z65 returns nothing
local real minlibanhek_Z14Z
call UnitRemoveBuffs(minlibanhek_z65,false,true)
call UnitResetCooldown(minlibanhek_z65)
set minlibanhek_Z14Z=GetUnitLifePercent(minlibanhek_z65)
if(minlibanhek_Z14Z<minlibanhek_z2Z[0])then
call SetUnitLifePercentBJ(minlibanhek_z65,minlibanhek_z2Z[0])
else
if(minlibanhek_Z14Z<minlibanhek_z2Z[1])then
call SetUnitLifePercentBJ(minlibanhek_z65,minlibanhek_z2Z[1])
else
if(minlibanhek_Z14Z<minlibanhek_z2Z[2])then
call SetUnitLifePercentBJ(minlibanhek_z65,minlibanhek_z2Z[2])
else
call SetUnitLifePercentBJ(minlibanhek_z65,100.)
endif
endif
endif
set minlibanhek_Z14Z=GetUnitManaPercent(minlibanhek_z65)
if(minlibanhek_Z14Z<minlibanhek_z3Z[0])then
call SetUnitManaPercentBJ(minlibanhek_z65,minlibanhek_z3Z[0])
else
if(minlibanhek_Z14Z<minlibanhek_z3Z[1])then
call SetUnitManaPercentBJ(minlibanhek_z65,minlibanhek_z3Z[1])
else
if(minlibanhek_Z14Z<minlibanhek_z3Z[2])then
call SetUnitManaPercentBJ(minlibanhek_z65,minlibanhek_z3Z[2])
else
call SetUnitManaPercentBJ(minlibanhek_z65,100.)
endif
endif
endif
endfunction
function minlibanhek_zZ0Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_zZzZ(minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_zZ1Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if(minlibanhek_z4)then
if(minlibanhek_z6[minlibanhek_z15])then
if((minlibanhek_Z1Z[minlibanhek_z15])and(minlibanhek_Z2Z[minlibanhek_z15]))then
call minlibanhek_ZZ1Z(minlibanhek_z15,minlibanhek_z05)
else
if(minlibanhek_Z7[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
else
if(minlibanhek_Z0)then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_zZ0Z)
else
call minlibanhek_zZzZ(minlibanhek_z7[minlibanhek_z15])
endif
endif
endif
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zZ2Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_Z1Z[minlibanhek_z15]=false
set minlibanhek_z05=null
call minlibanhek_z17(minlibanhek_z15,false)
endfunction
function minlibanhek_zZ3Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_Z2Z[minlibanhek_z15]=false
set minlibanhek_z05=null
call minlibanhek_z17(minlibanhek_z15,false)
endfunction
function minlibanhek_zZ4Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_zZZ[minlibanhek_z15]=false
call minlibanhek_z67(minlibanhek_z15,false)
set minlibanhek_z05=null
endfunction
function minlibanhek_zZ5Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_zzZ[minlibanhek_z15]=false
call minlibanhek_z67(minlibanhek_z15,false)
set minlibanhek_z05=null
endfunction
function minlibanhek_zZ6Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
set minlibanhek_Z8[minlibanhek_z15]=0
if(minlibanhek_z4)then
if(minlibanhek_z6[minlibanhek_z15])then
set minlibanhek_Z1Z[minlibanhek_z15]=true
if(minlibanhek_Z2Z[minlibanhek_z15])then
call minlibanhek_z17(minlibanhek_z15,true)
else
if(minlibanhek_Z7[minlibanhek_z15])then
if(minlibanhek_Z32[minlibanhek_z15]==3)then
set minlibanhek_Z7[minlibanhek_z15]=false
set minlibanhek_Z1Z[minlibanhek_z15]=false
set minlibanhek_Z32[minlibanhek_z15]=0
call minlibanhek_ZZzZ(minlibanhek_z15,minlibanhek_z05)
else
set minlibanhek_Z32[minlibanhek_z15]=minlibanhek_Z32[minlibanhek_z15]+1
endif
else
call minlibanhek_z88(minlibanhek_z15)
endif
endif
endif
else
if(minlibanhek_Z5[minlibanhek_z15]==0)then
set minlibanhek_Z5[minlibanhek_z15]=1
else
if(minlibanhek_Z5[minlibanhek_z15]==1)then
set minlibanhek_Z5[minlibanhek_z15]=2
else
set minlibanhek_Z5[minlibanhek_z15]=0
endif
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zZ7Z takes unit minlibanhek_z65 returns nothing
call SetUnitLifePercentBJ(minlibanhek_z65,100)
call SetUnitManaPercentBJ(minlibanhek_z65,100)
endfunction
function minlibanhek_zZ8Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_zZ7Z(minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_zZ9Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if(minlibanhek_z4)then
set minlibanhek_Z2Z[minlibanhek_z15]=true
if(minlibanhek_Z1Z[minlibanhek_z15])then
call minlibanhek_z17(minlibanhek_z15,true)
else
if(minlibanhek_z6[minlibanhek_z15])then
if(minlibanhek_Z7[minlibanhek_z15])then
call minlibanhek_Zz3Z(minlibanhek_z15,1,minlibanhek_zz,true)
else
if((minlibanhek_zZZ[minlibanhek_z15])and(minlibanhek_zzZ[minlibanhek_z15]))then
call minlibanhek_Zz9Z(minlibanhek_z15,1,true)
else
if(minlibanhek_Z0)then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_zZ8Z)
else
call minlibanhek_zZ7Z(minlibanhek_z7[minlibanhek_z15])
endif
endif
endif
endif
endif
else
if(minlibanhek_Z5[minlibanhek_z15]==3)then
if((minlibanhek_z0==false)or(minlibanhek_z15==minlibanhek_zz3))then
endif
else
set minlibanhek_Z5[minlibanhek_z15]=0
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zzZZ takes unit minlibanhek_z65 returns nothing
call UnitSetConstructionProgress(minlibanhek_z65,100)
call UnitSetUpgradeProgress(minlibanhek_z65,100)
call UnitRemoveBuffs(minlibanhek_z65,false,true)
call UnitResetCooldown(minlibanhek_z65)
endfunction
function minlibanhek_zzzZ takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_zzZZ(minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_zz0Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if(minlibanhek_z4)then
if(minlibanhek_z6[minlibanhek_z15])then
set minlibanhek_zZZ[minlibanhek_z15]=true
if(minlibanhek_zzZ[minlibanhek_z15])then
call minlibanhek_z67(minlibanhek_z15,true)
else
if(minlibanhek_Z7[minlibanhek_z15])then
set minlibanhek_Z7[minlibanhek_z15]=false
call minlibanhek_Zz3Z(minlibanhek_z15,0,minlibanhek_zz,true)
else
if(minlibanhek_Z0)then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_zzzZ)
else
call minlibanhek_zzZZ(minlibanhek_z7[minlibanhek_z15])
endif
endif
endif
endif
else
if(minlibanhek_Z5[minlibanhek_z15]==2)then
set minlibanhek_Z5[minlibanhek_z15]=3
else
set minlibanhek_Z5[minlibanhek_z15]=0
endif
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zz1Z takes unit minlibanhek_z65 returns nothing
call ModifyHeroStat(0,minlibanhek_z65,0,minlibanhek_zz)
call ModifyHeroStat(1,minlibanhek_z65,0,minlibanhek_zz)
call ModifyHeroStat(2,minlibanhek_z65,0,minlibanhek_zz)
endfunction
function minlibanhek_zz2Z takes nothing returns nothing
local unit minlibanhek_z65=GetEnumUnit()
call minlibanhek_zz1Z(minlibanhek_z65)
set minlibanhek_z65=null
endfunction
function minlibanhek_zz3Z takes nothing returns nothing
local integer minlibanhek_z15
local player minlibanhek_z05
set minlibanhek_z05=GetTriggerPlayer()
set minlibanhek_z15=GetPlayerId(minlibanhek_z05)
if(minlibanhek_z4)then
if(minlibanhek_z6[minlibanhek_z15])then
set minlibanhek_zzZ[minlibanhek_z15]=true
if(minlibanhek_zZZ[minlibanhek_z15])then
call minlibanhek_z67(minlibanhek_z15,true)
else
if(minlibanhek_Z7[minlibanhek_z15])then
set minlibanhek_Z7[minlibanhek_z15]=false
call minlibanhek_Zz3Z(minlibanhek_z15,2,minlibanhek_zz,true)
else
if((minlibanhek_Z1Z[minlibanhek_z15])and(minlibanhek_Z2Z[minlibanhek_z15]))then
if(minlibanhek_Z0)then
call ForGroup(minlibanhek_Z8Z[minlibanhek_z15],function minlibanhek_zz2Z)
else
call minlibanhek_zz1Z(minlibanhek_z7[minlibanhek_z15])
endif
else
call minlibanhek_zz5(minlibanhek_z05,minlibanhek_zZ,true)
call minlibanhek_z35(minlibanhek_z05,minlibanhek_Zz,true)
endif
endif
endif
endif
else
set minlibanhek_Z5[minlibanhek_z15]=0
endif
set minlibanhek_z05=null
endfunction
function minlibanhek_zz4Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z59Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
call minlibanhek_Z5ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z52Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
set minlibanhek_z13=false
call DoNotSaveReplay()
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_zz5Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_ZZzZ(minlibanhek_z15,minlibanhek_z05)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Zz1Z(minlibanhek_z05)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call SetPlayerStateBJ(minlibanhek_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
if(GetPlayerHandicapBJ(minlibanhek_z05)==200.)then
call SetPlayerHandicapBJ(minlibanhek_z05,100)
else
call SetPlayerHandicapBJ(minlibanhek_z05,200.)
endif
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
if(GetPlayerHandicapXPBJ(minlibanhek_z05)==200.)then
call SetPlayerHandicapXPBJ(minlibanhek_z05,100)
else
call SetPlayerHandicapXPBJ(minlibanhek_z05,200.)
endif
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_zz5(minlibanhek_z05,minlibanhek_Z2,true)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_z35(minlibanhek_z05,minlibanhek_z2,true)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call minlibanhek_zz5(minlibanhek_z05,minlibanhek_Z2,false)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_z35(minlibanhek_z05,minlibanhek_z2,false)
call minlibanhek_Z55Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_zz6Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z40[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z50[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z60[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z80[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z70[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_z90[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z96(minlibanhek_ZZ3[minlibanhek_z15])
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_z16(minlibanhek_z15,true)
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call minlibanhek_z16(minlibanhek_z15,false)
call minlibanhek_Z46Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_zz7Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z24Z(minlibanhek_z15,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1097886070,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z26Z(minlibanhek_z15,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1094937907,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1098150517,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
call minlibanhek_Z29Z(minlibanhek_z15,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if((minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])and((minlibanhek_z9Z)or(minlibanhek_z05==minlibanhek_z5)))then
call minlibanhek_Z3ZZ(minlibanhek_z15,true)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z34Z(minlibanhek_z15)
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_zz8Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095659625,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095066998,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095262824,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095721842,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1096119411,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095656289,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095657827,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095332722,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1094935923,true)
call minlibanhek_Z48Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_zz9Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095262562,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095065960,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095721317,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095065970,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1096114549,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1096114550,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1095262564,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1094934883,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1097818482,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z21Z(minlibanhek_z15,1096905580,true)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z31Z(minlibanhek_z15,false)
call minlibanhek_Z49Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z0ZZ takes nothing returns nothing
local integer minlibanhek_Z75=0
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z05==minlibanhek_z5)and(minlibanhek_z6[minlibanhek_z15]))then
loop
exitwhen minlibanhek_Z75>11
if(minlibanhek_z78==minlibanhek_ZzZ[minlibanhek_Z75])then
if(minlibanhek_z6[minlibanhek_Z75])then
call minlibanhek_z47(minlibanhek_Z75)
else
call minlibanhek_z57(minlibanhek_Z75,Player(minlibanhek_Z75))
endif
call minlibanhek_Z5ZZ(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z0zZ takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local integer minlibanhek_Z75=0
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z05==minlibanhek_z5)and(minlibanhek_z6[minlibanhek_z15]))then
loop
exitwhen minlibanhek_Z75>12
if(minlibanhek_z78==minlibanhek_ZzZ[minlibanhek_Z75])then
set minlibanhek_Z5z=minlibanhek_Z75
call minlibanhek_Z53Z(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z00Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local player minlibanhek_Z65
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z05==minlibanhek_z5)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z57Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
set minlibanhek_Z65=Player(minlibanhek_Z5z)
if(GetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD,minlibanhek_z22)
else
call SetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set minlibanhek_Z65=null
call minlibanhek_Z53Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
set minlibanhek_Z65=Player(minlibanhek_Z5z)
if(GetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER,minlibanhek_z22)
else
call SetPlayerTaxRate(minlibanhek_Z65,minlibanhek_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set minlibanhek_Z65=null
call minlibanhek_Z53Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z52Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z01Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local integer minlibanhek_Z75=minlibanhek_Z5z
local player minlibanhek_Z65=Player(minlibanhek_Z75)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_ZZzZ(minlibanhek_Z75,minlibanhek_Z65)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Zz1Z(minlibanhek_Z65)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call SetPlayerStateBJ(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call SetPlayerStateBJ(minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
if(GetPlayerHandicapBJ(minlibanhek_Z65)==200.)then
call SetPlayerHandicapBJ(minlibanhek_Z65,100)
else
call SetPlayerHandicapBJ(minlibanhek_Z65,200.)
endif
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
if(GetPlayerHandicapXPBJ(minlibanhek_Z65)==200.)then
call SetPlayerHandicapXPBJ(minlibanhek_Z65,100)
else
call SetPlayerHandicapXPBJ(minlibanhek_Z65,200.)
endif
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_zz5(minlibanhek_Z65,minlibanhek_Z2,true)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
call minlibanhek_z35(minlibanhek_Z65,minlibanhek_z2,true)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call minlibanhek_zz5(minlibanhek_Z65,minlibanhek_Z2,false)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_z35(minlibanhek_Z65,minlibanhek_z2,false)
call minlibanhek_Z56Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z53Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z02Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local integer minlibanhek_Z75=minlibanhek_Z5z
local player minlibanhek_Z65=Player(minlibanhek_Z75)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
if(IsPlayerAlly(minlibanhek_Z65,minlibanhek_z05))then
call SetPlayerAllianceStateBJ(minlibanhek_Z65,minlibanhek_z05,0)
else
call SetPlayerAllianceStateBJ(minlibanhek_Z65,minlibanhek_z05,3)
endif
call minlibanhek_Z57Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
if(GetPlayerAlliance(minlibanhek_Z65,minlibanhek_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,minlibanhek_z5)
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_CONTROL,false,minlibanhek_z5)
else
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,minlibanhek_z5)
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_CONTROL,true,minlibanhek_z5)
endif
call minlibanhek_Z57Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
if(GetPlayerAlliance(minlibanhek_Z65,minlibanhek_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_XP,false,minlibanhek_z5)
else
call SetPlayerAllianceBJ(minlibanhek_Z65,ALLIANCE_SHARED_XP,true,minlibanhek_z5)
endif
call minlibanhek_Z57Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
if(IsPlayerAlly(minlibanhek_z05,minlibanhek_Z65))then
call SetPlayerAllianceStateBJ(minlibanhek_z5,minlibanhek_Z65,0)
else
call SetPlayerAllianceStateBJ(minlibanhek_z5,minlibanhek_Z65,2)
endif
call minlibanhek_Z57Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z53Z(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z03Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local integer minlibanhek_Z75
local unit minlibanhek_z65=minlibanhek_z7[minlibanhek_z15]
local player minlibanhek_Z65=GetOwningPlayer(minlibanhek_z65)
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if(minlibanhek_z4)and(minlibanhek_z6[minlibanhek_z15])then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call SetHeroLevelBJ(minlibanhek_z65,GetHeroLevel(minlibanhek_z65)+minlibanhek_Z0Z,false)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call ModifyHeroStat(1,minlibanhek_z65,0,minlibanhek_Z3)
call ModifyHeroStat(0,minlibanhek_z65,0,minlibanhek_Z3)
call ModifyHeroStat(2,minlibanhek_z65,0,minlibanhek_Z3)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_z98(minlibanhek_z15,false)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z77(minlibanhek_z65,minlibanhek_z05,1)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_ZZ3Z(minlibanhek_z65)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
if(minlibanhek_Z5Z)then
if(minlibanhek_Z65!=minlibanhek_z5)then
call UnitShareVisionBJ(true,minlibanhek_z65,minlibanhek_z05)
endif
else
call UnitShareVisionBJ(true,minlibanhek_z65,minlibanhek_z05)
endif
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
call minlibanhek_Z47Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
if(minlibanhek_Z5Z)then
if(minlibanhek_Z65!=minlibanhek_z5)then
call SetUnitOwner(minlibanhek_z65,minlibanhek_z05,true)
endif
else
call SetUnitOwner(minlibanhek_z65,minlibanhek_z05,true)
endif
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
call RemoveUnit(minlibanhek_z65)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z54Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z65=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z04Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z05==minlibanhek_z5)and(minlibanhek_z6[minlibanhek_z15]))then
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
set minlibanhek_Z0=not(minlibanhek_Z0)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z58Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
set minlibanhek_Z5Z=not(minlibanhek_Z5Z)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
set minlibanhek_Z6Z=not(minlibanhek_Z6Z)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
set minlibanhek_Z7Z=not(minlibanhek_Z7Z)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
set minlibanhek_z9Z=not(minlibanhek_z9Z)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z7z[minlibanhek_z15])then
set minlibanhek_ZZz=not(minlibanhek_ZZz)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z6z[minlibanhek_z15])then
set minlibanhek_z7Z=not(minlibanhek_z7Z)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Zz0[minlibanhek_z15])then
set minlibanhek_Z52=not(minlibanhek_Z52)
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_ZZ0[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z05Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
set minlibanhek_z61=1
call minlibanhek_Z58Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
set minlibanhek_z61=2
call minlibanhek_Z58Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
set minlibanhek_z61=3
call minlibanhek_Z58Z(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z51Z(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z06Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
local integer minlibanhek_Z75=0
local player minlibanhek_Z65
local unit minlibanhek_z65=minlibanhek_z7[minlibanhek_z15]
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if((minlibanhek_z4)and(minlibanhek_z05==minlibanhek_z5)and(minlibanhek_z6[minlibanhek_z15]))then
loop
exitwhen minlibanhek_Z75>12
if(minlibanhek_z78==minlibanhek_ZzZ[minlibanhek_Z75])then
set minlibanhek_Z65=Player(minlibanhek_Z75)
call SetUnitOwner(minlibanhek_z7[minlibanhek_z15],minlibanhek_Z65,true)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z50Z(minlibanhek_z15,minlibanhek_z05)
endif
endif
set minlibanhek_z05=null
set minlibanhek_Z65=null
set minlibanhek_z78=null
set minlibanhek_z65=null
endfunction
function minlibanhek_z07Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_z36(minlibanhek_z05)
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
set minlibanhek_z31[minlibanhek_z15]=not(minlibanhek_z31[minlibanhek_z15])
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
set minlibanhek_Z33[minlibanhek_z15]=not(minlibanhek_Z33[minlibanhek_z15])
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z38(minlibanhek_z15,not(minlibanhek_Z53[minlibanhek_z15]))
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
set minlibanhek_Z63[minlibanhek_z15]=not(minlibanhek_Z63[minlibanhek_z15])
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z8z[minlibanhek_z15])then
set minlibanhek_Z43[minlibanhek_z15]=not(minlibanhek_Z43[minlibanhek_z15])
call minlibanhek_Z6ZZ(minlibanhek_z15,minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function minlibanhek_z08Z takes nothing returns nothing
local player minlibanhek_z05=GetTriggerPlayer()
local integer minlibanhek_z15=GetPlayerId(minlibanhek_z05)
local button minlibanhek_z78=GetClickedButton()
call minlibanhek_Z44Z(minlibanhek_z15,minlibanhek_z05,false)
if(minlibanhek_z78==minlibanhek_z2z[minlibanhek_z15])then
call minlibanhek_Z6zZ(minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z4z[minlibanhek_z15])then
call minlibanhek_Z60Z(minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z5z[minlibanhek_z15])then
call minlibanhek_Z61Z(minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z3z[minlibanhek_z15])then
call minlibanhek_Z62Z(minlibanhek_z05)
endif
if(minlibanhek_z78==minlibanhek_z9z[minlibanhek_z15])then
call minlibanhek_Z64Z()
endif
if(minlibanhek_z78==minlibanhek_Z00[minlibanhek_z15])then
call minlibanhek_Z45Z(minlibanhek_z15,minlibanhek_z05)
endif
set minlibanhek_z05=null
set minlibanhek_z78=null
endfunction
function yjYJ takes nothing returns nothing
set HKE_Yj=CreateTrigger()
set HKE_yJ=0
loop
exitwhen HKE_yJ>11
call TriggerRegisterPlayerChatEvent(HKE_Yj,Player(HKE_yJ),"飘飞之影",true)
set HKE_yJ=HKE_yJ+1
endloop
call TriggerAddAction(HKE_Yj,function YJYJ)
endfunction
function minlibanhek_z09Z takes nothing returns nothing
local integer minlibanhek_Z75
local player minlibanhek_Z65
local player minlibanhek_z05
set minlibanhek_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(minlibanhek_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(minlibanhek_z73,function minlibanhek_Z9ZZ)
call TriggerAddCondition(minlibanhek_z43,Condition(function minlibanhek_Z73Z))
set minlibanhek_Z75=0
loop
exitwhen minlibanhek_Z75>11
set minlibanhek_zz1[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_zz1[minlibanhek_Z75],function minlibanhek_Z79Z)
call DisableTrigger(minlibanhek_zz1[minlibanhek_Z75])
set minlibanhek_Z30[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z30[minlibanhek_Z75],function minlibanhek_Z88Z)
call DisableTrigger(minlibanhek_Z30[minlibanhek_Z75])
set minlibanhek_Z50[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z50[minlibanhek_Z75],function minlibanhek_Z89Z)
call DisableTrigger(minlibanhek_Z50[minlibanhek_Z75])
set minlibanhek_Z40[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z40[minlibanhek_Z75],function minlibanhek_Z91Z)
call DisableTrigger(minlibanhek_Z40[minlibanhek_Z75])
set minlibanhek_Z60[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z60[minlibanhek_Z75],function minlibanhek_Z90Z)
call DisableTrigger(minlibanhek_Z60[minlibanhek_Z75])
set minlibanhek_Z6z[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z6z[minlibanhek_Z75],function minlibanhek_Z9zZ)
call DisableTrigger(minlibanhek_Z6z[minlibanhek_Z75])
set minlibanhek_Z70[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z70[minlibanhek_Z75],function minlibanhek_zZ1Z)
call DisableTrigger(minlibanhek_Z70[minlibanhek_Z75])
set minlibanhek_Z80[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z80[minlibanhek_Z75],function minlibanhek_zZ2Z)
call DisableTrigger(minlibanhek_Z80[minlibanhek_Z75])
set minlibanhek_Z90[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z90[minlibanhek_Z75],function minlibanhek_zZ3Z)
call DisableTrigger(minlibanhek_Z90[minlibanhek_Z75])
set minlibanhek_zZ0[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_zZ0[minlibanhek_Z75],function minlibanhek_zZ4Z)
call DisableTrigger(minlibanhek_zZ0[minlibanhek_Z75])
set minlibanhek_zz0[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_zz0[minlibanhek_Z75],function minlibanhek_zZ5Z)
call DisableTrigger(minlibanhek_zz0[minlibanhek_Z75])
set minlibanhek_z00[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z00[minlibanhek_Z75],function minlibanhek_zZ6Z)
set minlibanhek_z10[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z10[minlibanhek_Z75],function minlibanhek_zZ9Z)
set minlibanhek_z20[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z20[minlibanhek_Z75],function minlibanhek_zz0Z)
set minlibanhek_z30[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z30[minlibanhek_Z75],function minlibanhek_zz3Z)
set minlibanhek_z40[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z40[minlibanhek_Z75],function minlibanhek_Z81Z)
call DisableTrigger(minlibanhek_z40[minlibanhek_Z75])
set minlibanhek_z50[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z50[minlibanhek_Z75],function minlibanhek_Z82Z)
call DisableTrigger(minlibanhek_z50[minlibanhek_Z75])
set minlibanhek_z60[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z60[minlibanhek_Z75],function minlibanhek_Z83Z)
call DisableTrigger(minlibanhek_z60[minlibanhek_Z75])
set minlibanhek_z70[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z70[minlibanhek_Z75],function minlibanhek_Z84Z)
call DisableTrigger(minlibanhek_z70[minlibanhek_Z75])
set minlibanhek_z80[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z80[minlibanhek_Z75],function minlibanhek_Z85Z)
call DisableTrigger(minlibanhek_z80[minlibanhek_Z75])
set minlibanhek_z90[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z90[minlibanhek_Z75],function minlibanhek_Z86Z)
call DisableTrigger(minlibanhek_z90[minlibanhek_Z75])
set minlibanhek_ZZ3[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_ZZ3[minlibanhek_Z75],function minlibanhek_Z87Z)
call DisableTrigger(minlibanhek_ZZ3[minlibanhek_Z75])
set minlibanhek_ZZ1[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_ZZ1[minlibanhek_Z75],function minlibanhek_zz4Z)
set minlibanhek_Zz2[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Zz2[minlibanhek_Z75],function minlibanhek_zz5Z)
set minlibanhek_Zz1[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Zz1[minlibanhek_Z75],function minlibanhek_zz6Z)
set minlibanhek_Z01[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z01[minlibanhek_Z75],function minlibanhek_zz7Z)
set minlibanhek_Z81[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z81[minlibanhek_Z75],function minlibanhek_zz8Z)
set minlibanhek_Z21[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z21[minlibanhek_Z75],function minlibanhek_zz9Z)
set minlibanhek_Z51[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z51[minlibanhek_Z75],function minlibanhek_z0ZZ)
set minlibanhek_Z41[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z41[minlibanhek_Z75],function minlibanhek_z0zZ)
set minlibanhek_Z61[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z61[minlibanhek_Z75],function minlibanhek_z00Z)
set minlibanhek_Z12[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z12[minlibanhek_Z75],function minlibanhek_z02Z)
set minlibanhek_Z02[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z02[minlibanhek_Z75],function minlibanhek_z01Z)
set minlibanhek_Z71[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z71[minlibanhek_Z75],function minlibanhek_z03Z)
set minlibanhek_Z31[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z31[minlibanhek_Z75],function minlibanhek_z04Z)
set minlibanhek_Z22[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z22[minlibanhek_Z75],function minlibanhek_z05Z)
set minlibanhek_Z11[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z11[minlibanhek_Z75],function minlibanhek_z06Z)
set minlibanhek_Z23[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z23[minlibanhek_Z75],function minlibanhek_z08Z)
set minlibanhek_Z13[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_Z13[minlibanhek_Z75],function minlibanhek_z07Z)
call DisableTrigger(minlibanhek_ZZ1[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Zz1[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Zz2[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z01[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z81[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z21[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z51[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z41[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z61[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z12[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z02[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z71[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z31[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z22[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z11[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z23[minlibanhek_Z75])
call DisableTrigger(minlibanhek_Z13[minlibanhek_Z75])
set minlibanhek_z01[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z01[minlibanhek_Z75],function minlibanhek_Z95Z)
set minlibanhek_z11[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z11[minlibanhek_Z75],function minlibanhek_Z98Z)
set minlibanhek_z21[minlibanhek_Z75]=CreateTrigger()
call TriggerAddAction(minlibanhek_z21[minlibanhek_Z75],function minlibanhek_zZZZ)
call DisableTrigger(minlibanhek_z01[minlibanhek_Z75])
call DisableTrigger(minlibanhek_z11[minlibanhek_Z75])
call DisableTrigger(minlibanhek_z21[minlibanhek_Z75])
set minlibanhek_Z65=Player(minlibanhek_Z75)
if((GetPlayerController(minlibanhek_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(minlibanhek_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set minlibanhek_Z8Z[minlibanhek_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(minlibanhek_z63,minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(minlibanhek_z10[minlibanhek_Z75],minlibanhek_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(minlibanhek_z00[minlibanhek_Z75],minlibanhek_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(minlibanhek_z20[minlibanhek_Z75],minlibanhek_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(minlibanhek_z30[minlibanhek_Z75],minlibanhek_Z65,0,1)
call TriggerRegisterPlayerChatEvent(minlibanhek_z53,minlibanhek_Z65,SubStringBJ(minlibanhek_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(minlibanhek_z63,minlibanhek_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set minlibanhek_Z9Z[minlibanhek_Z75]=GetPlayerStartLocationLoc(minlibanhek_Z65)
endif
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call DisableTrigger(minlibanhek_z73)
set minlibanhek_z8Z=CreateGroup()
set minlibanhek_z8=GetWorldBounds()
set minlibanhek_z2Z[0]=30.
set minlibanhek_z2Z[1]=60.
set minlibanhek_z2Z[2]=90.
set minlibanhek_z3Z[0]=50.
set minlibanhek_z3Z[1]=72.
set minlibanhek_z3Z[2]=95.
set minlibanhek_Z75=0
loop
exitwhen minlibanhek_Z75>20
set minlibanhek_z02[minlibanhek_Z75]=null
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z75=0
loop
exitwhen(minlibanhek_Z75>12)
set minlibanhek_Z5[minlibanhek_Z75]=0
set minlibanhek_z6[minlibanhek_Z75]=false
set minlibanhek_Z7[minlibanhek_Z75]=false
set minlibanhek_Z8[minlibanhek_Z75]=0
set minlibanhek_Z1Z[minlibanhek_Z75]=false
set minlibanhek_Z2Z[minlibanhek_Z75]=false
set minlibanhek_Z3Z[minlibanhek_Z75]=CreateTimer()
set minlibanhek_Z8Z[minlibanhek_Z75]=CreateGroup()
set minlibanhek_zZZ[minlibanhek_Z75]=false
set minlibanhek_zzZ[minlibanhek_Z75]=false
set minlibanhek_z0Z[minlibanhek_Z75]=CreateTimer()
set minlibanhek_z1Z[minlibanhek_Z75]=false
set minlibanhek_Z3z[minlibanhek_Z75]=false
set minlibanhek_Z4z[minlibanhek_Z75]=0
set minlibanhek_Z20[minlibanhek_Z75]=DialogCreate()
set minlibanhek_Z91[minlibanhek_Z75]=DialogCreate()
set minlibanhek_zZ1[minlibanhek_Z75]=DialogCreate()
set minlibanhek_z31[minlibanhek_Z75]=false
set minlibanhek_Z32[minlibanhek_Z75]=0
set minlibanhek_Z42[minlibanhek_Z75]=false
set minlibanhek_Zz3[minlibanhek_Z75]=DialogCreate()
set minlibanhek_Z33[minlibanhek_Z75]=false
set minlibanhek_Z43[minlibanhek_Z75]=true
set minlibanhek_Z53[minlibanhek_Z75]=false
set minlibanhek_Z63[minlibanhek_Z75]=false
set minlibanhek_Z73[minlibanhek_Z75]=CreateTimer()
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z75=0
loop
exitwhen(minlibanhek_Z75>3)
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
set minlibanhek_Z75=0
loop
exitwhen(minlibanhek_Z75>21)
set minlibanhek_z12[minlibanhek_Z75]=false
set minlibanhek_Z75=minlibanhek_Z75+1
endloop
call TriggerRegisterTimerEvent(minlibanhek_z23,.01,false)
call TriggerAddAction(minlibanhek_z23,function minlibanhek_Z7zZ)
call TriggerAddAction(minlibanhek_z33,function minlibanhek_Z70Z)
call TriggerAddAction(minlibanhek_z43,function minlibanhek_Z74Z)
call TriggerAddAction(minlibanhek_z53,function minlibanhek_Z8zZ)
call TriggerAddAction(minlibanhek_z63,function minlibanhek_Z80Z)
call TriggerRegisterAnyUnitEventBJ(minlibanhek_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(minlibanhek_z73,function minlibanhek_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(minlibanhek_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(minlibanhek_z83,function minlibanhek_Z93Z)
call DisableTrigger(minlibanhek_z83)
call minlibanhek_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set minlibanhek_Z65=null
call yjYJ()
endfunction