function hbzy_Z64 takes real hbzy_Z74,location hbzy_Z84 returns group
set hbzy_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(hbzy_Z14,hbzy_Z84,hbzy_Z74,hbzy_Z34)
return hbzy_Z14
endfunction
function hbzy_Z94 takes player hbzy_zZ4 returns group
set hbzy_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(hbzy_Z14,hbzy_zZ4,hbzy_Z34)
return hbzy_Z14
endfunction
function hbzy_zz4 takes player hbzy_zZ4,integer hbzy_z04 returns group
set hbzy_Z14=CreateGroup()
set bj_groupEnumTypeId=hbzy_z04
call GroupEnumUnitsOfPlayer(hbzy_Z14,hbzy_zZ4,filterGetUnitsOfPlayerAndTypeId)
return hbzy_Z14
endfunction
function hbzy_z14 takes player hbzy_zZ4 returns force
set hbzy_Z24=CreateForce()
call ForceEnumAllies(hbzy_Z24,hbzy_zZ4,hbzy_Z34)
return hbzy_Z24
endfunction
function hbzy_z24 takes player hbzy_zZ4 returns force
set hbzy_Z24=CreateForce()
call ForceEnumEnemies(hbzy_Z24,hbzy_zZ4,hbzy_Z34)
return hbzy_Z24
endfunction
function hbzy_Z45 takes trigger hbzy_Z55,player hbzy_Z65,integer hbzy_Z75 returns nothing
local playerevent hbzy_Z85=ConvertPlayerEvent(hbzy_Z75)
call TriggerRegisterPlayerEvent(hbzy_Z55,hbzy_Z65,hbzy_Z85)
set hbzy_Z85=null
endfunction
function hbzy_Z95 takes trigger hbzy_Z55,player hbzy_Z65,integer hbzy_Z75 returns nothing
local playerunitevent hbzy_Z85=ConvertPlayerUnitEvent(hbzy_Z75)
call TriggerRegisterPlayerUnitEvent(hbzy_Z55,hbzy_Z65,hbzy_Z85,null)
set hbzy_Z85=null
endfunction
function hbzy_zZ5 takes integer hbzy_Z75,player hbzy_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(hbzy_Z30[hbzy_Z75],hbzy_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(hbzy_Z50[hbzy_Z75],hbzy_Z65,ConvertPlayerUnitEvent(25),null)
call hbzy_Z45(hbzy_Z70[hbzy_Z75],hbzy_Z65,17)
call hbzy_Z45(hbzy_Z90[hbzy_Z75],hbzy_Z65,266)
call hbzy_Z45(hbzy_Z80[hbzy_Z75],hbzy_Z65,268)
call hbzy_Z45(hbzy_zZ0[hbzy_Z75],hbzy_Z65,262)
call hbzy_Z45(hbzy_zz0[hbzy_Z75],hbzy_Z65,264)
call TriggerRegisterTimerExpireEvent(hbzy_z43,hbzy_z0Z[hbzy_Z75])
call TriggerRegisterTimerExpireEvent(hbzy_z33,hbzy_Z73[hbzy_Z75])
call hbzy_Z95(hbzy_Z40[hbzy_Z75],hbzy_Z65,32)
call hbzy_Z95(hbzy_Z60[hbzy_Z75],hbzy_Z65,35)
call TriggerRegisterDialogEvent(hbzy_ZZ1[hbzy_Z75],hbzy_zZ1[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Zz2[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Zz1[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z01[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z81[hbzy_Z75],hbzy_Z91[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z71[hbzy_Z75],hbzy_zZ1[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z21[hbzy_Z75],hbzy_Z91[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z31[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z22[hbzy_Z75],hbzy_Z91[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z11[hbzy_Z75],hbzy_Z91[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z51[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z41[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z61[hbzy_Z75],hbzy_Z91[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z12[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z02[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z23[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call TriggerRegisterDialogEvent(hbzy_Z13[hbzy_Z75],hbzy_Z20[hbzy_Z75])
call hbzy_Z95(hbzy_z01[hbzy_Z75],hbzy_Z65,38)
call hbzy_Z95(hbzy_z11[hbzy_Z75],hbzy_Z65,39)
call hbzy_Z95(hbzy_z21[hbzy_Z75],hbzy_Z65,40)
call hbzy_Z95(hbzy_z80[hbzy_Z75],hbzy_Z65,276)
call hbzy_Z95(hbzy_z80[hbzy_Z75],hbzy_Z65,275)
call hbzy_Z95(hbzy_z90[hbzy_Z75],hbzy_Z65,276)
call hbzy_Z95(hbzy_z90[hbzy_Z75],hbzy_Z65,275)
call hbzy_Z95(hbzy_ZZ3[hbzy_Z75],hbzy_Z65,18)
call TriggerRegisterPlayerStateEvent(hbzy_z60[hbzy_Z75],hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hbzy_z40[hbzy_Z75],hbzy_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hbzy_z50[hbzy_Z75],hbzy_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call hbzy_Z95(hbzy_z70[hbzy_Z75],hbzy_Z65,20)
call TriggerRegisterPlayerChatEvent(hbzy_zz1[hbzy_Z75],hbzy_Z65,"-",false)
call hbzy_Z95(hbzy_Z6z[hbzy_Z75],hbzy_Z65,39)
set hbzy_Z3z[hbzy_Z75]=true
endfunction
function hbzy_zz5 takes player hbzy_z05,integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_z25)then
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)+hbzy_z15)
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(hbzy_z05,PLAYER_STATE_GOLD_GATHERED)-hbzy_z15)
else
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)-hbzy_z15)
endif
endfunction
function hbzy_z35 takes player hbzy_z05,integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_z25)then
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)+hbzy_z15)
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(hbzy_z05,PLAYER_STATE_LUMBER_GATHERED)-hbzy_z15)
else
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)-hbzy_z15)
endif
endfunction
function hbzy_z45 takes player hbzy_z05 returns nothing
local player hbzy_Z65=GetLocalPlayer()
if hbzy_z05==hbzy_Z65 then
set hbzy_Z65=Player(-1)
endif
set hbzy_Z65=null
endfunction
function hbzy_z55 takes unit hbzy_z65,unit hbzy_z75,boolean hbzy_z85 returns nothing
local location hbzy_z95
local location hbzy_ZZ6
set hbzy_z95=GetUnitLoc(hbzy_z65)
set hbzy_ZZ6=GetUnitLoc(hbzy_z75)
call SetUnitPositionLoc(hbzy_z65,hbzy_ZZ6)
if(hbzy_z85)then
call SetUnitPositionLoc(hbzy_z75,hbzy_z95)
call SetUnitPositionLoc(hbzy_z65,hbzy_ZZ6)
endif
call RemoveLocation(hbzy_z95)
call RemoveLocation(hbzy_ZZ6)
set hbzy_z95=null
set hbzy_ZZ6=null
endfunction
function hbzy_Zz6 takes integer hbzy_Z06 returns nothing
if(hbzy_Z06==0)then
set hbzy_zZ2=100
set hbzy_Z92=100
set hbzy_Z82=100
set hbzy_Z72="|cFFFFFFFF"
return
endif
if(hbzy_Z06==1)then
set hbzy_zZ2=50
set hbzy_Z92=50
set hbzy_Z82=50
set hbzy_Z72="|cFF7F7F7F"
return
endif
if(hbzy_Z06==2)then
set hbzy_zZ2=0
set hbzy_Z92=0
set hbzy_Z82=0
set hbzy_Z72="|cFF000000"
return
endif
if(hbzy_Z06==3)then
set hbzy_zZ2=100
set hbzy_Z92=0
set hbzy_Z82=0
set hbzy_Z72="|cFFFF0000"
return
endif
if(hbzy_Z06==4)then
set hbzy_zZ2=100
set hbzy_Z92=50
set hbzy_Z82=0
set hbzy_Z72="|cFFFF7F00"
return
endif
if(hbzy_Z06==5)then
set hbzy_zZ2=100
set hbzy_Z92=100
set hbzy_Z82=0
set hbzy_Z72="|cFFFFFF00"
return
endif
if(hbzy_Z06==6)then
set hbzy_zZ2=0
set hbzy_Z92=100
set hbzy_Z82=0
set hbzy_Z72="|cFF00FF00"
return
endif
if(hbzy_Z06==7)then
set hbzy_zZ2=0
set hbzy_Z92=100
set hbzy_Z82=100
set hbzy_Z72="|cFF00FFFF"
return
endif
if(hbzy_Z06==8)then
set hbzy_zZ2=0
set hbzy_Z92=0
set hbzy_Z82=100
set hbzy_Z72="|cFF0000FF"
return
endif
if(hbzy_Z06==9)then
set hbzy_zZ2=100
set hbzy_Z92=0
set hbzy_Z82=100
set hbzy_Z72="|cFFFF00FF"
return
endif
endfunction
function hbzy_Z16 takes integer hbzy_Z06,unit hbzy_Z26,string hbzy_Z36 returns nothing
local texttag hbzy_Z46
local location hbzy_z95
call hbzy_Zz6(hbzy_Z06)
set hbzy_z95=GetUnitLoc(hbzy_Z26)
set hbzy_Z46=CreateTextTagLocBJ(hbzy_Z36,hbzy_z95,0,20,hbzy_zZ2,hbzy_Z92,hbzy_Z82,0)
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
call SetTextTagPermanent(hbzy_Z46,false)
call SetTextTagLifespan(hbzy_Z46,hbzy_Z1)
set hbzy_Z46=null
endfunction
function hbzy_Z56 takes nothing returns nothing
local trigger hbzy_Z66=GetTriggeringTrigger()
local timer hbzy_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(hbzy_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(hbzy_z52)
call DestroyTimerDialog(hbzy_z82)
call DestroyTimer(hbzy_Z76)
set hbzy_Z66=null
set hbzy_Z76=null
endfunction
function hbzy_Z86 takes nothing returns nothing
local timer hbzy_Z76
local trigger hbzy_Z66
if(hbzy_z62)then
else
set hbzy_z52=GetGameSpeed()
set hbzy_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set hbzy_Z66=CreateTrigger()
set hbzy_Z76=CreateTimer()
call StartTimerBJ(hbzy_Z76,false,hbzy_z42)
set hbzy_z82=CreateTimerDialogBJ(hbzy_Z76,"子弹时间")
call TriggerAddAction(hbzy_Z66,function hbzy_Z56)
call TriggerRegisterTimerExpireEvent(hbzy_Z66,hbzy_Z76)
endif
endfunction
function hbzy_Z96 takes trigger hbzy_zZ6 returns nothing
if(IsTriggerEnabled(hbzy_zZ6))then
call DisableTrigger(hbzy_zZ6)
else
call EnableTrigger(hbzy_zZ6)
endif
endfunction
function hbzy_zz6 takes trigger hbzy_zZ6,boolean hbzy_z06 returns nothing
if(IsTriggerEnabled(hbzy_zZ6)==hbzy_z06)then
else
call hbzy_Z96(hbzy_zZ6)
endif
endfunction
function hbzy_z16 takes integer hbzy_z15,boolean hbzy_z25 returns nothing
call hbzy_zz6(hbzy_z40[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_z50[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_z60[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_z80[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_z70[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_z90[hbzy_z15],hbzy_z25)
call hbzy_zz6(hbzy_ZZ3[hbzy_z15],hbzy_z25)
endfunction
function hbzy_z26 takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
if(GetUnitUserData(hbzy_z65)==2176)then
call RemoveUnit(hbzy_z65)
endif
set hbzy_z65=null
endfunction
function hbzy_z36 takes player hbzy_z05 returns nothing
local group hbzy_z46
if(hbzy_Z42[GetPlayerId(hbzy_z05)])then
set hbzy_z46=hbzy_Z94(hbzy_z05)
call ForGroup(hbzy_z46,function hbzy_z26)
set hbzy_Z42[GetPlayerId(hbzy_z05)]=false
call DestroyGroup(hbzy_z46)
set hbzy_z46=null
endif
endfunction
function hbzy_z56 takes unit hbzy_z65,player hbzy_z05 returns nothing
local location hbzy_z95
local integer hbzy_z66
local unit hbzy_z76
local item hbzy_z86
local integer hbzy_Z75=0
if(IsUnitType(hbzy_z65,UNIT_TYPE_HERO))then
set hbzy_z95=GetUnitLoc(hbzy_z65)
set hbzy_z66=GetUnitTypeId(hbzy_z65)
set hbzy_z76=CreateUnitAtLoc(hbzy_z05,hbzy_z66,hbzy_z95,bj_UNIT_FACING)
call SetUnitUserData(hbzy_z76,2176)
set hbzy_Z42[GetPlayerId(hbzy_z05)]=true
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_z76,false)
endif
call SetHeroLevelBJ(hbzy_z76,GetHeroLevel(hbzy_z65),false)
call SetHeroStat(hbzy_z76,0,GetHeroStatBJ(0,hbzy_z65,false))
call SetHeroStat(hbzy_z76,1,GetHeroStatBJ(1,hbzy_z65,false))
call SetHeroStat(hbzy_z76,2,GetHeroStatBJ(2,hbzy_z65,false))
loop
exitwhen hbzy_Z75>5
set hbzy_z86=UnitItemInSlot(hbzy_z65,hbzy_Z75)
call UnitAddItemById(hbzy_z76,GetItemTypeId(hbzy_z86))
set hbzy_Z75=hbzy_Z75+1
endloop
endif
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
set hbzy_z76=null
set hbzy_z86=null
endfunction
function hbzy_z96 takes integer hbzy_ZZ7,player hbzy_Zz7,location hbzy_Z07,boolean hbzy_Z17,boolean hbzy_Z27 returns nothing
local unit hbzy_z76
set hbzy_z76=CreateUnitAtLoc(hbzy_Zz7,hbzy_ZZ7,hbzy_Z07,bj_UNIT_FACING)
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_z76,false)
endif
if(hbzy_Z17)then
call SetUnitUserData(hbzy_z76,2176)
endif
if(hbzy_Z27)then
call UnitApplyTimedLife(hbzy_z76,1112820806,90)
endif
set hbzy_z76=null
endfunction
function hbzy_Z37 takes integer hbzy_ZZ7,player hbzy_Zz7,location hbzy_Z07 returns nothing
local unit hbzy_z76
set hbzy_z76=CreateUnitAtLoc(hbzy_Zz7,hbzy_ZZ7,hbzy_Z07,bj_UNIT_FACING)
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_z76,false)
set hbzy_z76=null
endif
endfunction
function hbzy_Z47 takes unit hbzy_Z57,player hbzy_Zz7,integer hbzy_Z67,boolean hbzy_Z27 returns nothing
local location hbzy_z95
local integer hbzy_z66
local integer hbzy_Z75
set hbzy_z95=GetUnitLoc(hbzy_Z57)
set hbzy_z66=GetUnitTypeId(hbzy_Z57)
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>hbzy_Z67
call hbzy_z96(hbzy_z66,hbzy_Zz7,hbzy_z95,true,hbzy_Z27)
set hbzy_Z75=hbzy_Z75+1
endloop
call RemoveLocation(hbzy_z95)
set hbzy_Z42[GetPlayerId(hbzy_Zz7)]=true
set hbzy_z95=null
endfunction
function hbzy_Z77 takes unit hbzy_Z57,player hbzy_Zz7,integer hbzy_Z67 returns nothing
call hbzy_Z47(hbzy_Z57,hbzy_Zz7,hbzy_Z67,false)
endfunction
function hbzy_Z87 takes unit hbzy_z65,integer hbzy_z15,boolean hbzy_Z97 returns nothing
local integer hbzy_Z75
set hbzy_Z75=GetResourceAmount(hbzy_z65)
if(hbzy_Z97)then
set hbzy_Z75=hbzy_Z75+hbzy_z15
else
set hbzy_Z75=hbzy_Z75-hbzy_z15
endif
if(hbzy_Z75<0)then
if(hbzy_Z97)then
set hbzy_Z75=GetResourceAmount(hbzy_z65)
else
set hbzy_Z75=0
endif
endif
call SetResourceAmount(hbzy_z65,hbzy_Z75)
endfunction
function hbzy_zZ7 takes integer hbzy_z15,player hbzy_z05,boolean hbzy_zz7 returns nothing
if(hbzy_zz7)then
call SetPlayerTechMaxAllowed(hbzy_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(hbzy_z05,1212502607,3)
endif
endfunction
function hbzy_z07 takes integer hbzy_z15,boolean hbzy_z06 returns nothing
if(hbzy_z06)then
call EnableTrigger(hbzy_z00[hbzy_z15])
call EnableTrigger(hbzy_z10[hbzy_z15])
call EnableTrigger(hbzy_z20[hbzy_z15])
call EnableTrigger(hbzy_z30[hbzy_z15])
call EnableTrigger(hbzy_Z70[hbzy_z15])
call EnableTrigger(hbzy_Z80[hbzy_z15])
call EnableTrigger(hbzy_Z90[hbzy_z15])
call EnableTrigger(hbzy_zZ0[hbzy_z15])
call EnableTrigger(hbzy_zz0[hbzy_z15])
else
call DisableTrigger(hbzy_Yj)	
call DisableTrigger(hbzy_z00[hbzy_z15])
call DisableTrigger(hbzy_z10[hbzy_z15])
call DisableTrigger(hbzy_z20[hbzy_z15])
call DisableTrigger(hbzy_z30[hbzy_z15])
call DisableTrigger(hbzy_Z70[hbzy_z15])
call DisableTrigger(hbzy_Z80[hbzy_z15])
call DisableTrigger(hbzy_Z90[hbzy_z15])
call DisableTrigger(hbzy_zZ0[hbzy_z15])
call DisableTrigger(hbzy_zz0[hbzy_z15])
endif
endfunction
function hbzy_z17 takes integer hbzy_z15,boolean hbzy_z27 returns nothing
if(hbzy_z27)then
call EnableTrigger(hbzy_Z40[hbzy_z15])
call EnableTrigger(hbzy_Z60[hbzy_z15])
call EnableTrigger(hbzy_Z6z[hbzy_z15])
else
call DisableTrigger(hbzy_Z40[hbzy_z15])
call DisableTrigger(hbzy_Z60[hbzy_z15])
call DisableTrigger(hbzy_Z6z[hbzy_z15])
endif
endfunction
function hbzy_z37 takes nothing returns nothing
local integer hbzy_z15
set hbzy_z15=0
loop
exitwhen hbzy_z15>11
call hbzy_z07(hbzy_z15,false)
set hbzy_z15=hbzy_z15+1
endloop
endfunction
function hbzy_z47 takes integer hbzy_z15 returns nothing
set hbzy_z6[hbzy_z15]=false
call GroupClear(hbzy_Z8Z[hbzy_z15])
if(hbzy_Z7Z)then
call DestroyFogModifier(hbzy_Z6[hbzy_z15])
endif
call DisableTrigger(hbzy_Z30[hbzy_z15])
call DisableTrigger(hbzy_Z50[hbzy_z15])
call DisableTrigger(hbzy_zz1[hbzy_z15])
call DisableTrigger(hbzy_z40[hbzy_z15])
call DisableTrigger(hbzy_z50[hbzy_z15])
call DisableTrigger(hbzy_z60[hbzy_z15])
call DisableTrigger(hbzy_z70[hbzy_z15])
call DisableTrigger(hbzy_z80[hbzy_z15])
call DisableTrigger(hbzy_z90[hbzy_z15])
call DisableTrigger(hbzy_ZZ3[hbzy_z15])
call DisableTrigger(hbzy_ZZ1[hbzy_z15])
call DisableTrigger(hbzy_Zz1[hbzy_z15])
call DisableTrigger(hbzy_Zz2[hbzy_z15])
call DisableTrigger(hbzy_Z01[hbzy_z15])
call DisableTrigger(hbzy_Z81[hbzy_z15])
call DisableTrigger(hbzy_Z21[hbzy_z15])
call DisableTrigger(hbzy_Z51[hbzy_z15])
call DisableTrigger(hbzy_Z41[hbzy_z15])
call DisableTrigger(hbzy_Z61[hbzy_z15])
call DisableTrigger(hbzy_Z12[hbzy_z15])
call DisableTrigger(hbzy_Z02[hbzy_z15])
call DisableTrigger(hbzy_Z71[hbzy_z15])
call DisableTrigger(hbzy_Z31[hbzy_z15])
call DisableTrigger(hbzy_Z22[hbzy_z15])
call DisableTrigger(hbzy_Z11[hbzy_z15])
call DisableTrigger(hbzy_Z23[hbzy_z15])
call DisableTrigger(hbzy_Z13[hbzy_z15])
call DisableTrigger(hbzy_zZ3[hbzy_z15])
call DisableTrigger(hbzy_Z40[hbzy_z15])
call DisableTrigger(hbzy_Z60[hbzy_z15])
call DisableTrigger(hbzy_Z6z[hbzy_z15])
call hbzy_z07(hbzy_z15,false)
endfunction
function hbzy_z57 takes integer hbzy_z15,player hbzy_z05 returns nothing
set hbzy_z6[hbzy_z15]=true
if(hbzy_Z3z[hbzy_z15])then
else
call hbzy_zZ5(hbzy_z15,hbzy_z05)
endif
call EnableTrigger(hbzy_Z30[hbzy_z15])
call EnableTrigger(hbzy_Z50[hbzy_z15])
call EnableTrigger(hbzy_zz1[hbzy_z15])
call hbzy_z07(hbzy_z15,true)
endfunction
function hbzy_z67 takes integer hbzy_z15,boolean hbzy_z77 returns nothing
if(hbzy_z77)then
if((hbzy_zZZ[hbzy_z15])and(hbzy_zzZ[hbzy_z15])and(hbzy_z31[hbzy_z15]))then
call EnableTrigger(hbzy_z01[hbzy_z15])
call EnableTrigger(hbzy_z11[hbzy_z15])
call EnableTrigger(hbzy_z21[hbzy_z15])
endif
else
call DisableTrigger(hbzy_z01[hbzy_z15])
call DisableTrigger(hbzy_z11[hbzy_z15])
call DisableTrigger(hbzy_z21[hbzy_z15])
endif
endfunction
function hbzy_z87 takes integer hbzy_Z06 returns nothing
if(hbzy_Z06==0)then
set hbzy_zz2=0
return
endif
if(hbzy_Z06==1)then
set hbzy_zz2=10
return
endif
if(hbzy_Z06==2)then
set hbzy_zz2=15
return
endif
if(hbzy_Z06==3)then
set hbzy_zz2=20
return
endif
if(hbzy_Z06==4)then
set hbzy_zz2=40
return
endif
if(hbzy_Z06==5)then
set hbzy_zz2=50
return
endif
if(hbzy_Z06==6)then
set hbzy_zz2=70
return
endif
if(hbzy_Z06==7)then
set hbzy_zz2=80
return
endif
if(hbzy_Z06==8)then
set hbzy_zz2=90
return
endif
if(hbzy_Z06==9)then
set hbzy_zz2=100
return
endif
endfunction
function hbzy_z97 takes unit hbzy_z65,integer hbzy_ZZ8,integer hbzy_Zz8 returns nothing
call hbzy_z87(hbzy_Zz8)
call hbzy_Zz6(hbzy_ZZ8)
call SetUnitVertexColorBJ(hbzy_z65,hbzy_zZ2,hbzy_Z92,hbzy_Z82,hbzy_zz2)
endfunction
function hbzy_Z08 takes integer hbzy_ZZ8,integer hbzy_Zz8 returns nothing
call hbzy_z87(hbzy_Zz8)
call hbzy_Zz6(hbzy_ZZ8)
call SetWaterBaseColorBJ(hbzy_zZ2,hbzy_Z92,hbzy_Z82,hbzy_zz2)
endfunction
function hbzy_Z18 takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call hbzy_z97(hbzy_z65,GetRandomInt(3,9),0)
set hbzy_z65=null
endfunction
function hbzy_Z28 takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call hbzy_z97(hbzy_z65,0,0)
set hbzy_z65=null
endfunction
function hbzy_Z38 takes integer hbzy_z15,boolean hbzy_z77 returns nothing
local integer hbzy_Z75
local integer hbzy_Z48
if(hbzy_Z53[hbzy_z15]==hbzy_z77)then
else
set hbzy_Z53[hbzy_z15]=hbzy_z77
if(hbzy_z77)then
call EnableTrigger(hbzy_z83)
else
set hbzy_Z75=0
set hbzy_Z48=0
loop
exitwhen hbzy_Z75>11
if(hbzy_Z53[hbzy_Z75])then
set hbzy_Z48=hbzy_Z48+1
endif
set hbzy_Z75=hbzy_Z75+1
endloop
if(hbzy_Z48==0)then
call DisableTrigger(hbzy_z83)
endif
endif
endif
endfunction
function hbzy_Z58 takes integer hbzy_Z68 returns nothing
if(hbzy_Z68==0)then
call SetSkyModel(null)
return
endif
if(hbzy_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(hbzy_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(hbzy_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(hbzy_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(hbzy_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(hbzy_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(hbzy_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(hbzy_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(hbzy_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(hbzy_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(hbzy_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(hbzy_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(hbzy_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function hbzy_Z78 takes integer hbzy_Z88 returns integer
if(hbzy_Z88==0)then
return 1380018290
endif
if(hbzy_Z88==1)then
return 1380019314
endif
if(hbzy_Z88==2)then
return 1296393331
endif
if(hbzy_Z88==3)then
return 1178886760
endif
if(hbzy_Z88==4)then
return 1178886764
endif
if(hbzy_Z88==5)then
return 1178888040
endif
if(hbzy_Z88==6)then
return 1178888044
endif
if(hbzy_Z88==7)then
return 1178890856
endif
if(hbzy_Z88==8)then
return 1178890860
endif
if(hbzy_Z88==9)then
return 1178892136
endif
if(hbzy_Z88==10)then
return 1178892140
endif
if(hbzy_Z88==11)then
return 1380739186
endif
if(hbzy_Z88==12)then
return 1380740210
endif
if(hbzy_Z88==13)then
return 1397645939
endif
if(hbzy_Z88==14)then
return 1397647475
endif
if(hbzy_Z88==15)then
return 1397648499
endif
if(hbzy_Z88==16)then
return 1464820599
endif
if(hbzy_Z88==17)then
return 1464822903
endif
if(hbzy_Z88==18)then
return 1280467297
endif
if(hbzy_Z88==19)then
return 1280470369
endif
if(hbzy_Z88==20)then
return 1464755063
endif
return 0
endfunction
function hbzy_Z98 takes integer hbzy_Z88,boolean hbzy_z77 returns nothing
set hbzy_Z88=hbzy_Z88-1
if(hbzy_z77)then
if(hbzy_z12[hbzy_Z88]==false)then
if(hbzy_Z78(hbzy_Z88)==0)then
else
set hbzy_z02[hbzy_Z88]=AddWeatherEffect(hbzy_z8,hbzy_Z78(hbzy_Z88))
call EnableWeatherEffect(hbzy_z02[hbzy_Z88],true)
set hbzy_z12[hbzy_Z88]=true
endif
endif
else
if(hbzy_z02[hbzy_Z88]==null)then
else
call EnableWeatherEffect(hbzy_z02[hbzy_Z88],false)
call RemoveWeatherEffect(hbzy_z02[hbzy_Z88])
set hbzy_z12[hbzy_Z88]=false
set hbzy_z02[hbzy_Z88]=null
endif
endif
endfunction
function hbzy_zZ8 takes nothing returns nothing
local integer hbzy_z15=1
loop
exitwhen hbzy_z15>21
call hbzy_Z98(hbzy_z15,false)
set hbzy_z15=hbzy_z15+1
endloop
endfunction
function hbzy_zz8 takes integer hbzy_z08 returns integer
if(hbzy_z08==0)then
return 1280601204
endif
if(hbzy_z08==1)then
return 1179939959
endif
if(hbzy_z08==2)then
return 1465152631
endif
if(hbzy_z08==3)then
return 1096053874
endif
if(hbzy_z08==4)then
return 1096053859
endif
if(hbzy_z08==5)then
return 1112831095
endif
if(hbzy_z08==6)then
return 1263826039
endif
if(hbzy_z08==7)then
return 1498707828
endif
if(hbzy_z08==8)then
return 1498702708
endif
if(hbzy_z08==9)then
return 1498703476
endif
if(hbzy_z08==10)then
return 1498706804
endif
if(hbzy_z08==11)then
return 1247044468
endif
if(hbzy_z08==12)then
return 1247048823
endif
if(hbzy_z08==13)then
return 1146385256
endif
if(hbzy_z08==14)then
return 1129608306
endif
if(hbzy_z08==15)then
return 1129608291
endif
if(hbzy_z08==16)then
return 1230271607
endif
if(hbzy_z08==17)then
return 1230271607
endif
if(hbzy_z08==18)then
return 1314157667
endif
if(hbzy_z08==19)then
return 1330934903
endif
if(hbzy_z08==20)then
return 1515484279
endif
if(hbzy_z08==21)then
return 1196716904
endif
if(hbzy_z08==22)then
return 1448373364
endif
if(hbzy_z08==23)then
return 1448373364
endif
return 0
endfunction
function hbzy_z18 takes nothing returns integer
return hbzy_zz8(GetRandomInt(0,23))
endfunction
function hbzy_z28 takes unit hbzy_z65,integer hbzy_z38,integer hbzy_z08,integer hbzy_z48 returns nothing
local real hbzy_z58
local real hbzy_z68
local real hbzy_z15=0
local boolean hbzy_z78=true
set hbzy_z58=GetUnitX(hbzy_z65)
set hbzy_z68=GetUnitY(hbzy_z65)
if(hbzy_z38==1)then
loop
exitwhen hbzy_z15==hbzy_z48
if(hbzy_z78)then
call CreateDestructable(hbzy_z08,hbzy_z58,hbzy_z68+hbzy_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_z08,hbzy_z58,hbzy_z68-hbzy_z15*40,GetRandomReal(0,360),1,0)
endif
set hbzy_z78=not(hbzy_z78)
set hbzy_z15=hbzy_z15+1
endloop
endif
if(hbzy_z38==2)then
loop
exitwhen hbzy_z15==hbzy_z48
if(hbzy_z78)then
call CreateDestructable(hbzy_z08,hbzy_z58+hbzy_z15*40,hbzy_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_z08,hbzy_z58-hbzy_z15*40,hbzy_z68,GetRandomReal(0,360),1,0)
endif
set hbzy_z78=not(hbzy_z78)
set hbzy_z15=hbzy_z15+1
endloop
endif
if(hbzy_z38==3)then
loop
exitwhen hbzy_z15==hbzy_z48
if(hbzy_z78)then
call CreateDestructable(hbzy_z08,hbzy_z58+hbzy_z15*40,hbzy_z68+hbzy_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_z08,hbzy_z58-hbzy_z15*40,hbzy_z68-hbzy_z15*40,GetRandomReal(0,360),1,0)
endif
set hbzy_z78=not(hbzy_z78)
set hbzy_z15=hbzy_z15+1
endloop
endif
if(hbzy_z38==4)then
loop
exitwhen hbzy_z15==hbzy_z48
if(hbzy_z78)then
call CreateDestructable(hbzy_z08,hbzy_z58+hbzy_z15*40,hbzy_z68-hbzy_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_z08,hbzy_z58-hbzy_z15*40,hbzy_z68+hbzy_z15*40,GetRandomReal(0,360),1,0)
endif
set hbzy_z78=not(hbzy_z78)
set hbzy_z15=hbzy_z15+1
endloop
endif
endfunction
function hbzy_z88 takes integer hbzy_z15 returns nothing
set hbzy_Z7[hbzy_z15]=true
call StartTimerBJ(hbzy_z0Z[hbzy_z15],false,2.)
endfunction
function hbzy_z98 takes integer hbzy_z15,boolean hbzy_ZZZZ returns nothing
local integer hbzy_Z75
local integer hbzy_z76
local item hbzy_z86
local location hbzy_z95
local unit hbzy_z65
set hbzy_z65=hbzy_z7[hbzy_z15]
set hbzy_z76=1
loop
exitwhen hbzy_z76>6
if(hbzy_ZZZZ)then
set hbzy_z95=GetUnitLoc(hbzy_z51[hbzy_z15])
else
set hbzy_z95=GetUnitLoc(hbzy_z65)
endif
set hbzy_z86=UnitItemInSlotBJ(hbzy_z65,hbzy_z76)
if(GetItemCharges(hbzy_z86)>0)then
set hbzy_Z75=GetItemCharges(hbzy_z86)
set hbzy_z86=CreateItemLoc(GetItemTypeId(hbzy_z86),hbzy_z95)
call SetItemCharges(hbzy_z86,hbzy_Z75)
else
call CreateItemLoc(GetItemTypeId(hbzy_z86),hbzy_z95)
endif
call RemoveLocation(hbzy_z95)
set hbzy_z76=hbzy_z76+1
endloop
set hbzy_z65=null
set hbzy_z95=null
set hbzy_z86=null
endfunction
function hbzy_ZZzZ takes integer hbzy_z15,player hbzy_z05 returns nothing
local integer hbzy_Z75
local force hbzy_ZZ0Z
local player hbzy_Z65
if(hbzy_z1Z[hbzy_z15])then
call DestroyFogModifier(hbzy_Z6[hbzy_z15])
set hbzy_z1Z[hbzy_z15]=false
else
set hbzy_ZZ0Z=CreateForce()
set hbzy_Z75=0
loop
exitwhen hbzy_Z75>11
set hbzy_Z65=Player(hbzy_Z75)
if(GetPlayerAlliance(hbzy_z05,hbzy_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(hbzy_ZZ0Z,hbzy_Z65)
call SetPlayerAlliance(hbzy_z05,hbzy_Z65,ALLIANCE_SHARED_VISION,false)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z6[hbzy_z15]=CreateFogModifierRect(hbzy_z05,FOG_OF_WAR_VISIBLE,hbzy_z8,false,false)
call FogModifierStart(hbzy_Z6[hbzy_z15])
set hbzy_z1Z[hbzy_z15]=true
set hbzy_Z75=0
loop
exitwhen hbzy_Z75>11
set hbzy_Z65=Player(hbzy_Z75)
if(IsPlayerInForce(hbzy_Z65,hbzy_ZZ0Z))then
call SetPlayerAlliance(hbzy_z05,hbzy_Z65,ALLIANCE_SHARED_VISION,true)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
call DestroyForce(hbzy_ZZ0Z)
set hbzy_ZZ0Z=null
set hbzy_Z65=null
endif
endfunction
function hbzy_ZZ1Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local integer hbzy_Z75
local unit hbzy_z65
local item hbzy_z86
local item array hbzy_ZZ2Z
set hbzy_z65=FirstOfGroup(hbzy_Z8Z[hbzy_z15])
if((hbzy_z05==GetOwningPlayer(hbzy_z65))and(UnitInventorySizeBJ(hbzy_z65)>0))then
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>6
set hbzy_z86=UnitItemInSlotBJ(hbzy_z65,hbzy_Z75)
set hbzy_ZZ2Z[(hbzy_Z75-1)]=hbzy_z86
call UnitRemoveItemSwapped(hbzy_z86,hbzy_z65)
call SetItemVisible(hbzy_z86,false)
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>6
set hbzy_z86=hbzy_Z2z[(hbzy_z15*18)+(hbzy_Z4z[hbzy_z15]*6)+(hbzy_Z75-1)]
call UnitAddItem(hbzy_z65,hbzy_z86)
set hbzy_Z2z[(hbzy_z15*18)+(hbzy_Z4z[hbzy_z15]*6)+(hbzy_Z75-1)]=hbzy_ZZ2Z[(hbzy_Z75-1)]
set hbzy_ZZ2Z[(hbzy_Z75-1)]=null
set hbzy_Z75=hbzy_Z75+1
endloop
if(hbzy_Z4z[hbzy_z15]==0)then
set hbzy_Z4z[hbzy_z15]=hbzy_z61-1
else
set hbzy_Z4z[hbzy_z15]=(hbzy_Z4z[hbzy_z15]-1)
endif
set hbzy_z86=null
endif
set hbzy_z65=null
set hbzy_z05=null
endfunction
function hbzy_ZZ3Z takes unit hbzy_z65 returns nothing
local integer hbzy_Z75
local item hbzy_z86
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>6
set hbzy_z86=UnitItemInSlotBJ(hbzy_z65,hbzy_Z75)
call UnitRemoveItemSwapped(hbzy_z86,hbzy_z65)
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_z86=null
endfunction
function hbzy_ZZ4Z takes integer hbzy_z15 returns nothing
local integer hbzy_Z75
local item hbzy_z86
local location hbzy_z95
set hbzy_z95=GetUnitLoc(hbzy_z51[hbzy_z15])
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>6
set hbzy_z86=UnitItemInSlotBJ(hbzy_z7[hbzy_z15],hbzy_Z75)
call UnitRemoveItemSwapped(hbzy_z86,hbzy_z7[hbzy_z15])
call SetItemPositionLoc(hbzy_z86,hbzy_z95)
set hbzy_Z75=hbzy_Z75+1
endloop
call RemoveLocation(hbzy_z95)
set hbzy_z86=null
set hbzy_z95=null
endfunction
function hbzy_ZZ5Z takes integer hbzy_z15 returns nothing
local integer hbzy_z76
local integer hbzy_z78
local unit hbzy_z65
local item hbzy_Z66
local item hbzy_ZZ6Z
set hbzy_z65=FirstOfGroup(hbzy_Z8Z[hbzy_z15])
set hbzy_z76=1
loop
exitwhen hbzy_z76>5
set hbzy_Z66=UnitItemInSlotBJ(hbzy_z65,hbzy_z76)
if(GetItemCharges(hbzy_Z66)>0)then
set hbzy_z78=hbzy_z76+1
loop
exitwhen hbzy_z78>6
set hbzy_ZZ6Z=UnitItemInSlotBJ(hbzy_z65,hbzy_z78)
if(GetItemTypeId(hbzy_Z66)==GetItemTypeId(hbzy_ZZ6Z))then
call SetItemCharges(hbzy_Z66,(GetItemCharges(hbzy_Z66)+GetItemCharges(hbzy_ZZ6Z)))
call RemoveItem(hbzy_ZZ6Z)
endif
set hbzy_z78=hbzy_z78+1
endloop
endif
set hbzy_z76=hbzy_z76+1
endloop
set hbzy_Z66=null
set hbzy_ZZ6Z=null
set hbzy_z65=null
endfunction
function hbzy_ZZ7Z takes integer hbzy_z15,integer hbzy_Z75 returns nothing
local unit hbzy_z65
local item hbzy_z86
set hbzy_z65=FirstOfGroup(hbzy_Z8Z[hbzy_z15])
set hbzy_z86=UnitItemInSlotBJ(hbzy_z65,1)
call SetItemCharges(hbzy_z86,(GetItemCharges(hbzy_z86)+hbzy_Z75))
set hbzy_z86=null
set hbzy_z65=null
endfunction
function hbzy_ZZ8Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call GroupAddUnit(hbzy_z8Z,hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_ZZ9Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call GroupRemoveUnit(hbzy_z8Z,hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_ZzZZ takes nothing returns nothing
local unit hbzy_z65=GetTriggerUnit()
if((IsUnitDeadBJ(hbzy_z65))and(IsUnitType(hbzy_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(hbzy_z8Z,hbzy_z65)
endif
endfunction
function hbzy_ZzzZ takes nothing returns nothing
call ForGroup(hbzy_z8Z,function hbzy_ZzZZ)
endfunction
function hbzy_Zz0Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call ReviveHeroLoc(hbzy_z65,hbzy_Z9Z[hbzy_Zzz],true)
call SetUnitManaPercentBJ(hbzy_z65,100)
set hbzy_z65=null
endfunction
function hbzy_Zz1Z takes player hbzy_z05 returns nothing
local group hbzy_z46
set hbzy_z46=hbzy_Z94(hbzy_z05)
set hbzy_Zzz=GetPlayerId(hbzy_z05)
call ForGroup(hbzy_z46,function hbzy_Zz0Z)
call DestroyGroup(hbzy_z46)
set hbzy_z46=null
endfunction
function hbzy_Zz2Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call ModifyHeroStat(hbzy_z81,hbzy_z65,hbzy_z91,hbzy_z71)
set hbzy_z65=null
endfunction
function hbzy_Zz3Z takes integer hbzy_z15,integer hbzy_Zz4Z,integer hbzy_Zz5Z,boolean hbzy_z25 returns nothing
local integer hbzy_Zz6Z
if(hbzy_z25)then
set hbzy_Zz6Z=0
else
set hbzy_Zz6Z=1
endif
if(hbzy_Z0)then
set hbzy_z91=hbzy_Zz6Z
set hbzy_z81=hbzy_Zz4Z
set hbzy_z71=hbzy_Zz5Z
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Zz2Z)
else
call ModifyHeroStat(hbzy_Zz4Z,hbzy_z7[hbzy_z15],hbzy_Zz6Z,hbzy_Zz5Z)
endif
endfunction
function hbzy_Zz7Z takes unit hbzy_z65,integer hbzy_Zz5Z,boolean hbzy_z25 returns nothing
local integer hbzy_z15
set hbzy_z15=GetHeroLevel(hbzy_z65)
if(hbzy_z25)then
set hbzy_z15=hbzy_z15+hbzy_Zz5Z
else
set hbzy_z15=hbzy_z15-hbzy_Zz5Z
endif
call SetHeroLevelBJ(hbzy_z65,hbzy_z15,false)
endfunction
function hbzy_Zz8Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_Zz7Z(hbzy_z65,hbzy_ZZ2,hbzy_Z1z)
set hbzy_z65=null
endfunction
function hbzy_Zz9Z takes integer hbzy_z15,integer hbzy_Zz5Z,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_ZZ2=hbzy_Zz5Z
set hbzy_Z1z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Zz8Z)
else
call hbzy_Zz7Z(hbzy_z7[hbzy_z15],hbzy_Zz5Z,hbzy_z25)
endif
endfunction
function hbzy_Z0ZZ takes string hbzy_Z0zZ returns integer
local string hbzy_Z00Z="0123456789"
local string hbzy_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hbzy_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer hbzy_ID=0
local integer hbzy_Z03Z=1
local integer hbzy_Z04Z=1
loop
exitwhen hbzy_Z03Z>StringLength(hbzy_Z0zZ)
loop
exitwhen hbzy_Z04Z>10
if SubString(hbzy_Z0zZ,hbzy_Z03Z-1,hbzy_Z03Z)==SubString(hbzy_Z00Z,hbzy_Z04Z-1,hbzy_Z04Z)then
set hbzy_ID=hbzy_ID+R2I((48+hbzy_Z04Z-1)*Pow(256.,I2R(StringLength(hbzy_Z0zZ)-hbzy_Z03Z)))
set hbzy_Z04Z=hbzy_Z04Z+1
else
set hbzy_Z04Z=hbzy_Z04Z+1
endif
endloop
set hbzy_Z04Z=1
loop
exitwhen hbzy_Z04Z>26
if SubString(hbzy_Z0zZ,hbzy_Z03Z-1,hbzy_Z03Z)==SubString(hbzy_Z01Z,hbzy_Z04Z-1,hbzy_Z04Z)then
set hbzy_ID=hbzy_ID+R2I(I2R(65+hbzy_Z04Z-1)*Pow(256.,I2R(StringLength(hbzy_Z0zZ)-hbzy_Z03Z)))
set hbzy_Z04Z=hbzy_Z04Z+1
else
set hbzy_Z04Z=hbzy_Z04Z+1
endif
endloop
set hbzy_Z04Z=1
loop
exitwhen hbzy_Z04Z>26
if SubString(hbzy_Z0zZ,hbzy_Z03Z-1,hbzy_Z03Z)==SubString(hbzy_Z02Z,hbzy_Z04Z-1,hbzy_Z04Z)then
set hbzy_ID=hbzy_ID+R2I((97+hbzy_Z04Z-1)*Pow(256.,I2R(StringLength(hbzy_Z0zZ)-hbzy_Z03Z)))
set hbzy_Z04Z=hbzy_Z04Z+1
else
set hbzy_Z04Z=hbzy_Z04Z+1
endif
endloop
set hbzy_Z04Z=1
set hbzy_Z03Z=hbzy_Z03Z+1
endloop
return hbzy_ID
endfunction
function hbzy_Z05Z takes integer hbzy_Z06Z returns string
local string hbzy_Z00Z="0123456789"
local string hbzy_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hbzy_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string hbzy_Z07Z=""
local integer hbzy_Z03Z=0
local integer hbzy_Z08Z=0
loop
exitwhen hbzy_Z06Z==0
set hbzy_Z03Z=ModuloInteger(hbzy_Z06Z,256)
if hbzy_Z03Z>=48 and hbzy_Z03Z<=57 then
set hbzy_Z08Z=hbzy_Z03Z-48
set hbzy_Z07Z=SubString(hbzy_Z00Z,hbzy_Z08Z,hbzy_Z08Z+1)+hbzy_Z07Z
endif
if hbzy_Z03Z>=65 and hbzy_Z03Z<=90 then
set hbzy_Z08Z=hbzy_Z03Z-65
set hbzy_Z07Z=SubString(hbzy_Z01Z,hbzy_Z08Z,hbzy_Z08Z+1)+hbzy_Z07Z
endif
if hbzy_Z03Z>=97 and hbzy_Z03Z<=122 then
set hbzy_Z08Z=hbzy_Z03Z-97
set hbzy_Z07Z=SubString(hbzy_Z02Z,hbzy_Z08Z,hbzy_Z08Z+1)+hbzy_Z07Z
endif
set hbzy_Z06Z=hbzy_Z06Z/256
endloop
return hbzy_Z07Z
endfunction
function hbzy_Z09Z takes unit hbzy_z65 returns string
local integer hbzy_z15
set hbzy_z15=GetUnitTypeId(hbzy_z65)
if(hbzy_z15==0)then
return""
else
return hbzy_Z05Z(hbzy_z15)
endif
endfunction
function hbzy_Z1ZZ takes unit hbzy_z65 returns string
local item hbzy_z86=UnitItemInSlotBJ(hbzy_z65,1)
local integer hbzy_z15=GetItemTypeId(hbzy_z86)
if(hbzy_z15==0)then
return""
else
set hbzy_z86=null
return hbzy_Z05Z(hbzy_z15)
endif
endfunction
function hbzy_Z1zZ takes integer hbzy_Z10Z returns integer
local string hbzy_Z11Z=GetEventPlayerChatString()
if(StringLength(hbzy_Z11Z)==hbzy_Z10Z+3)then
return(hbzy_Z0ZZ(SubStringBJ(hbzy_Z11Z,hbzy_Z10Z,hbzy_Z10Z+3)))
else
return 0
endif
endfunction
function hbzy_Z12Z takes unit hbzy_z65,integer hbzy_z66,boolean hbzy_z25 returns nothing
local location hbzy_z95
local integer hbzy_z15
set hbzy_z15=hbzy_Z1zZ(hbzy_z66)
if(hbzy_z15==0)then
else
if(hbzy_z25)then
set hbzy_z95=GetUnitLoc(hbzy_z65)
call CreateItemLoc(hbzy_z15,hbzy_z95)
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
else
call UnitAddItemById(hbzy_z65,hbzy_z15)
endif
endif
endfunction
function hbzy_Z13Z takes unit hbzy_z65,real hbzy_Z14Z,boolean hbzy_z25 returns nothing
local location hbzy_z95=GetUnitLoc(hbzy_z65)
local player hbzy_z05=GetOwningPlayer(hbzy_z65)
call SetBlightRadiusLocBJ(hbzy_z25,hbzy_z05,hbzy_z95,hbzy_Z14Z)
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
set hbzy_z05=null
endfunction
function hbzy_Z15Z takes unit hbzy_z65,real hbzy_Z14Z returns nothing
call SetUnitFlyHeight(hbzy_z65,hbzy_Z14Z,.0)
endfunction
function hbzy_Z16Z takes nothing returns integer
local integer hbzy_Z17Z=0
local integer hbzy_Z18Z=0
local integer array hbzy_Z19Z
local integer hbzy_z15=0
local player hbzy_z05=GetLocalPlayer()
loop
exitwhen hbzy_z15>11
set hbzy_Z19Z[hbzy_z15]=0
set hbzy_z15=hbzy_z15+1
endloop
loop
exitwhen hbzy_Z17Z>14
call StoreInteger(hbzy_z03,"hbzy_Player","hbzy_number",GetPlayerId(hbzy_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(hbzy_z03,"hbzy_Player","hbzy_number")
call TriggerSyncReady()
set hbzy_Z18Z=GetStoredInteger(hbzy_z03,"hbzy_Player","hbzy_number")-1
set hbzy_Z19Z[hbzy_Z18Z]=hbzy_Z19Z[hbzy_Z18Z]+1
call FlushStoredMission(hbzy_z03,"hbzy_Player")
set hbzy_Z17Z=hbzy_Z17Z+1
endloop
set hbzy_Z18Z=0
set hbzy_Z17Z=0
set hbzy_z05=null
loop
exitwhen hbzy_Z17Z>11
if hbzy_Z19Z[hbzy_Z18Z]<hbzy_Z19Z[hbzy_Z17Z]then
set hbzy_Z18Z=hbzy_Z17Z
endif
set hbzy_Z17Z=hbzy_Z17Z+1
endloop
return hbzy_Z18Z+1
endfunction
function hbzy_Z2ZZ takes unit hbzy_z65,integer hbzy_Z2zZ,boolean hbzy_z25 returns nothing
if(hbzy_z25)then
call UnitAddAbility(hbzy_z65,hbzy_Z2zZ)
call SetUnitAbilityLevel(hbzy_z65,hbzy_Z2zZ,100)
call UnitMakeAbilityPermanent(hbzy_z65,true,hbzy_Z2zZ)
else
call UnitMakeAbilityPermanent(hbzy_z65,false,hbzy_Z2zZ)
call UnitRemoveAbility(hbzy_z65,hbzy_Z2zZ)
endif
endfunction
function hbzy_Z20Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_Z2ZZ(hbzy_z65,hbzy_zzz,hbzy_z0z)
set hbzy_z65=null
endfunction
function hbzy_Z21Z takes integer hbzy_z15,integer hbzy_Z2zZ,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_zzz=hbzy_Z2zZ
set hbzy_z0z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z20Z)
else
call hbzy_Z2ZZ(hbzy_z7[hbzy_z15],hbzy_Z2zZ,hbzy_z25)
endif
endfunction
function hbzy_Z22Z takes string hbzy_Z11Z returns integer
if(hbzy_Z11Z=="mm")then
return 1094937907
endif
if(hbzy_Z11Z=="xj")then
return 1095659625
endif
if(hbzy_Z11Z=="zj")then
return 1095262824
endif
if(hbzy_Z11Z=="zm")then
return 1095721842
endif
if(hbzy_Z11Z=="ft")then
return 1096119411
endif
if(hbzy_Z11Z=="xx")then
return 1095333473
endif
if(hbzy_Z11Z=="sb")then
return 1095066998
endif
if(hbzy_Z11Z=="yx")then
return 1097886070
endif
if(hbzy_Z11Z=="rh")then
return 1095657827
endif
if(hbzy_Z11Z=="fl")then
return 1095656289
endif
if(hbzy_Z11Z=="bs")then
return 1094935923
endif
if(hbzy_Z11Z=="jg")then
return 1095332984
endif
if(hbzy_Z11Z=="jf")then
return 1095328816
endif
if(hbzy_Z11Z=="js")then
return 1095332728
endif
if(hbzy_Z11Z=="jm")then
return 1095332722
endif
if(hbzy_Z11Z=="jj")then
return 1095917932
endif
if(hbzy_Z11Z=="fy")then
return 1098150517
endif
if(hbzy_Z11Z=="ghh")then
return 1095262562
endif
if(hbzy_Z11Z=="ghj")then
return 1095721317
endif
if(hbzy_Z11Z=="gqj")then
return 1095065970
endif
if(hbzy_Z11Z=="gxx")then
return 1096114550
endif
if(hbzy_Z11Z=="gzz")then
return 1095262564
endif
if(hbzy_Z11Z=="gxe")then
return 1096114549
endif
if(hbzy_Z11Z=="gjj")then
return 1095065960
endif
if(hbzy_Z11Z=="gml")then
return 1094934883
endif
if(hbzy_Z11Z=="gyl")then
return 1097818482
endif
if(hbzy_Z11Z=="gjs")then
return 1096905580
endif
if(hbzy_Z11Z=="qhy")then
return 1095329378
endif
if(hbzy_Z11Z=="qdy")then
return 1095331938
endif
if(hbzy_Z11Z=="qlh")then
return 1095332719
endif
if(hbzy_Z11Z=="qyz")then
return 1095328878
endif
if(hbzy_Z11Z=="qbd")then
return 1095331682
endif
if(hbzy_Z11Z=="qfs")then
return 1095328610
endif
if(hbzy_Z11Z=="qsd")then
return 1095330924
endif
if(hbzy_Z11Z=="qjs")then
return 1095332706
endif
if(hbzy_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function hbzy_Z23Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call SetUnitInvulnerable(hbzy_z65,hbzy_z0z)
call hbzy_Z2ZZ(hbzy_z65,1098282348,hbzy_z0z)
set hbzy_z65=null
endfunction
function hbzy_Z24Z takes integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z23Z)
else
call SetUnitInvulnerable(hbzy_z7[hbzy_z15],hbzy_z25)
call hbzy_Z2ZZ(hbzy_z7[hbzy_z15],1098282348,hbzy_z25)
endif
endfunction
function hbzy_Z25Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call SetUnitPathing(hbzy_z65,not(hbzy_z0z))
set hbzy_z65=null
endfunction
function hBzY takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
call hbzy_z37()
set hbzy_z4=true
set hbzy_z5=hbzy_z05
call hbzy_z57(GetPlayerId(hbzy_z05),hbzy_z05)
endfunction
function hbzy_Z26Z takes integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z25Z)
else
call SetUnitPathing(hbzy_z7[hbzy_z15],not(hbzy_z25))
endif
endfunction
function hbzy_Z27Z takes unit hbzy_z65,boolean hbzy_z25 returns nothing
if(hbzy_z25)then
call SetUnitMoveSpeed(hbzy_z65,1000)
else
call SetUnitMoveSpeed(hbzy_z65,GetUnitDefaultMoveSpeed(hbzy_z65))
endif
endfunction
function hbzy_Z28Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_Z27Z(hbzy_z65,hbzy_z0z)
set hbzy_z65=null
endfunction
function hbzy_Z29Z takes integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z28Z)
else
call hbzy_Z27Z(hbzy_z7[hbzy_z15],hbzy_z25)
endif
endfunction
function hbzy_Z3ZZ takes integer hbzy_z15,boolean hbzy_z25 returns nothing
call hbzy_ZzzZ()
if(hbzy_Z0)then
if(hbzy_z25)then
if(CountUnitsInGroup(hbzy_z8Z)==0)then
call EnableTrigger(hbzy_z73)
endif
call GroupAddGroup(hbzy_Z8Z[hbzy_z15],hbzy_z8Z)
else
call GroupRemoveGroup(hbzy_Z8Z[hbzy_z15],hbzy_z8Z)
if(CountUnitsInGroup(hbzy_z8Z)==0)then
call DisableTrigger(hbzy_z73)
endif
endif
else
if(hbzy_z25)then
if(CountUnitsInGroup(hbzy_z8Z)==0)then
call EnableTrigger(hbzy_z73)
endif
call GroupAddUnit(hbzy_z8Z,hbzy_z7[hbzy_z15])
else
call GroupRemoveUnit(hbzy_z8Z,hbzy_z7[hbzy_z15])
if(CountUnitsInGroup(hbzy_z8Z)==0)then
call DisableTrigger(hbzy_z73)
endif
endif
endif
endfunction
function hbzy_Z3zZ takes unit hbzy_z65,boolean hbzy_z25 returns nothing
call hbzy_Z2ZZ(hbzy_z65,1095262562,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1095721317,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1095065970,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1096114550,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1095262564,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1096114549,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1094934883,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1095065960,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1097818482,hbzy_z25)
call hbzy_Z2ZZ(hbzy_z65,1096905580,hbzy_z25)
endfunction
function hbzy_Z30Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_Z3zZ(hbzy_z65,hbzy_z0z)
set hbzy_z65=null
endfunction
function hbzy_Z31Z takes integer hbzy_z15,boolean hbzy_z25 returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_z25
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z30Z)
else
call hbzy_Z3zZ(hbzy_z7[hbzy_z15],hbzy_z25)
endif
endfunction
function hbzy_Z32Z takes unit hbzy_z65 returns nothing
call hbzy_Z2ZZ(hbzy_z65,1094937907,false)
call hbzy_Z2ZZ(hbzy_z65,1095659625,false)
call hbzy_Z2ZZ(hbzy_z65,1095262824,false)
call hbzy_Z2ZZ(hbzy_z65,1095721842,false)
call hbzy_Z2ZZ(hbzy_z65,1096119411,false)
call hbzy_Z2ZZ(hbzy_z65,1095333473,false)
call hbzy_Z2ZZ(hbzy_z65,1095066998,false)
call hbzy_Z2ZZ(hbzy_z65,1097886070,false)
call hbzy_Z2ZZ(hbzy_z65,1095657827,false)
call hbzy_Z2ZZ(hbzy_z65,1095656289,false)
call hbzy_Z2ZZ(hbzy_z65,1098282348,false)
call hbzy_Z2ZZ(hbzy_z65,1094935923,false)
call hbzy_Z2ZZ(hbzy_z65,1095332984,false)
call hbzy_Z2ZZ(hbzy_z65,1095328816,false)
call hbzy_Z2ZZ(hbzy_z65,1095332728,false)
call hbzy_Z2ZZ(hbzy_z65,1095332722,false)
call hbzy_Z2ZZ(hbzy_z65,1098150517,false)
call SetUnitInvulnerable(hbzy_z65,false)
call SetUnitPathing(hbzy_z65,true)
call hbzy_Z27Z(hbzy_z65,false)
call GroupRemoveUnit(hbzy_z8Z,hbzy_z65)
endfunction
function hbzy_Z33Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_Z32Z(hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_Z34Z takes integer hbzy_z15 returns nothing
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z33Z)
else
call hbzy_Z32Z(hbzy_z7[hbzy_z15])
endif
endfunction
function hbzy_Z35Z takes nothing returns nothing
local unit hbzy_z65=GetTriggerUnit()
local trigger hbzy_Z66=GetTriggeringTrigger()
call RemoveUnit(hbzy_z65)
call DisableTrigger(hbzy_Z66)
call DestroyTrigger(hbzy_Z66)
set hbzy_z65=null
set hbzy_Z66=null
endfunction
function hbzy_Z36Z takes integer hbzy_z66,unit hbzy_Z37Z,player hbzy_Z38Z returns nothing
local location hbzy_z95
local unit hbzy_z65
local integer hbzy_Z39Z=0
local integer hbzy_Z4ZZ=0
local trigger hbzy_Z66
if(hbzy_z66==0)then
set hbzy_Z39Z=1095726692
set hbzy_Z4ZZ=852503
endif
if(hbzy_z66==1)then
set hbzy_Z39Z=1095070833
set hbzy_Z4ZZ=852184
endif
if(hbzy_z66==2)then
set hbzy_Z39Z=1095070566
set hbzy_Z4ZZ=852183
endif
if((hbzy_Z39Z==0)and(hbzy_Z4ZZ==0))then
return
endif
set hbzy_z95=GetUnitLoc(hbzy_Z37Z)
set hbzy_z65=CreateUnitAtLoc(hbzy_Z38Z,1851941228,hbzy_z95,bj_UNIT_FACING)
call UnitAddAbility(hbzy_z65,1098282348)
call UnitAddAbility(hbzy_z65,hbzy_Z39Z)
call ShowUnit(hbzy_z65,false)
call SetUnitUseFood(hbzy_z65,false)
call SetUnitScale(hbzy_z65,.01,.01,.01)
call SetUnitState(hbzy_z65,UNIT_STATE_MANA,GetUnitState(hbzy_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(hbzy_z65,hbzy_Z4ZZ)
set hbzy_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(hbzy_Z66,hbzy_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hbzy_Z66,hbzy_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hbzy_Z66,function hbzy_Z35Z)
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
set hbzy_Z66=null
set hbzy_z65=null
endfunction
function hbzy_Z4zZ takes unit hbzy_Z37Z returns nothing
local player hbzy_z05=GetTriggerPlayer()
local location hbzy_z95=GetUnitLoc(hbzy_Z37Z)
local trigger hbzy_Z66=CreateTrigger()
local unit hbzy_z65=CreateUnitAtLoc(hbzy_z05,1751543663,hbzy_z95,bj_UNIT_FACING)
call UnitAddAbility(hbzy_z65,1098282348)
call UnitAddAbility(hbzy_z65,1095332709)
call ShowUnit(hbzy_z65,false)
call SetUnitUseFood(hbzy_z65,false)
call SetUnitScale(hbzy_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(hbzy_z65,852592,hbzy_z95)
call TriggerRegisterUnitEvent(hbzy_Z66,hbzy_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hbzy_Z66,hbzy_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hbzy_Z66,function hbzy_Z35Z)
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
set hbzy_Z66=null
set hbzy_z05=null
endfunction
function hbzy_Z40Z takes integer hbzy_z15,dialog hbzy_Z41Z,trigger hbzy_zZ6 returns nothing
set hbzy_Zz3[hbzy_z15]=hbzy_Z41Z
set hbzy_Z03[hbzy_z15]=hbzy_zZ6
endfunction
function hbzy_Z42Z takes integer hbzy_z15,string hbzy_Z43Z returns nothing
call DialogClear(hbzy_Zz3[hbzy_z15])
call DialogSetMessage(hbzy_Zz3[hbzy_z15],(hbzy_Z43Z+hbzy_Z0z+hbzy_Z62))
endfunction
function hbzy_Z44Z takes integer hbzy_z15,player hbzy_z05,boolean hbzy_z77 returns nothing
if(hbzy_z77)then
call EnableTrigger(hbzy_Z03[hbzy_z15])
call DialogDisplay(hbzy_z05,hbzy_Zz3[hbzy_z15],true)
call TimerStart(hbzy_Z73[hbzy_z15],hbzy_z1,false,null)
else
call DisableTrigger(hbzy_Z03[hbzy_z15])
call DialogDisplay(hbzy_z05,hbzy_Zz3[hbzy_z15],false)
endif
endfunction
function hbzy_Z45Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_zZ1[hbzy_z15],hbzy_ZZ1[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"主")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"资源菜单[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"自动化设置[B]",66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"选定单位特殊属性[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"个人选项设置[D]",68)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"帮助菜单[E]",69)
if(hbzy_z05==hbzy_z5)then
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"其他玩家作弊管理[F]",70)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"其他玩家管理[G]",71)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"游戏作弊选项[H]",72)
if(hbzy_z13)then
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z46Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local string hbzy_Z11Z
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Zz1[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"自动化设置")
if(IsTriggerEnabled(hbzy_z40[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(hbzy_z50[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(hbzy_z60[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(hbzy_z80[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(hbzy_z70[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(hbzy_z90[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"魔法释放后自动MP"+I2S(R2I(hbzy_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(hbzy_ZZ3[hbzy_z15]))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"生命低于"+I2S(R2I(hbzy_z92))+"%加到"+I2S(R2I(hbzy_z41))+"%[G]"),71)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"全部开启[O]",79)
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"全部关闭[U]",85)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z11Z=""
endfunction
function hbzy_Z47Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z01[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"选定单位特殊属性")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"无敌[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"永久隐形[B]",66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"穿越物体[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"魔免[D]",68)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"反隐形[E]",69)
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"移动速度[F]",70)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"各种光环[G]",71)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"换页[N]",78)
if((hbzy_z9Z)or(hbzy_z5==hbzy_z05))then
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"秒杀模式[K]",75)
endif
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"取消全部(不含光环)[U]",85)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z48Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_Z91[hbzy_z15],hbzy_Z81[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"选定单位特殊属性")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"永久献祭[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"闪避[B]",514)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"重击[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"致命一击[D]",68)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"反弹(小强的壳)[E]",69)
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"分裂攻击[F]",70)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"燃灰[G]",71)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"减少魔法伤害33%[H]",72)
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"闪避100%[I]",73)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"换页[N]",78)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z49Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_Z91[hbzy_z15],hbzy_Z21[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"光环")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"辉煌光环[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"荆棘光环[B]",66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"耐久光环[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"强击光环[D]",68)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"邪恶光环[E]",69)
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"吸血光环[F]",70)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"专注光环[G]",71)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"命令光环(战鼓)[H]",72)
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"医疗光环[I]",73)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"减速光环[J]",74)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"关所有光环[K]",75)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z5ZZ takes integer hbzy_z15,player hbzy_z05 returns nothing
local integer hbzy_Z75=0
local string hbzy_Z11Z
local string hbzy_Z5zZ
local player hbzy_Z65
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z51[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"玩家作弊管理")
loop
exitwhen hbzy_Z75>11
set hbzy_Z65=Player(hbzy_Z75)
if((GetPlayerController(hbzy_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(hbzy_Z65)==PLAYER_SLOT_STATE_PLAYING)and(hbzy_Z65!=hbzy_z5))then
set hbzy_Z5zZ=GetPlayerName(hbzy_Z65)
if(hbzy_z6[hbzy_Z75])then
set hbzy_Z11Z="禁止"
else
set hbzy_Z11Z="允许"
endif
set hbzy_ZzZ[hbzy_Z75]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+hbzy_Z5zZ+"作弊"),0)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z65=null
set hbzy_Z11Z=""
set hbzy_Z5zZ=""
endfunction
function hbzy_Z50Z takes integer hbzy_z15,player hbzy_z05 returns nothing
set hbzy_Z8[hbzy_z15]=0
call hbzy_Z40Z(hbzy_z15,hbzy_zZ1[hbzy_z15],hbzy_Z71[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"单位")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"升100级[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("加三围"+(I2S(hbzy_Z3)+"[B]")),66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"复制物品[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"复制单位[D]",68)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"掉身上物品[E]",69)
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"共享该单位视野[F]",70)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"特殊属性菜单[G]",71)
if((hbzy_z7Z)or(hbzy_z5==hbzy_z05))then
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"控制它[H]",72)
endif
if(hbzy_z5==hbzy_z05)then
endif
if(hbzy_z05==hbzy_z5)then
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"改变单位所有者[J]",74)
endif
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z51Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local string hbzy_Z11Z
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z31[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"游戏作弊选项")
if(hbzy_Z0)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"操作所有单位[A]"),65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("设置背包数[B]"),66)
if(hbzy_Z5Z)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"保护CheatMaster[C]"),67)
if(hbzy_Z6Z)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(hbzy_Z7Z)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("取消作弊时"+hbzy_Z11Z+"地图全开[E]"),69)
if(hbzy_z9Z)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"他人秒杀模式[F]"),70)
if(hbzy_ZZz)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"禁止秒杀建筑[G]"),71)
if(hbzy_z7Z)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"他人占据单位[H]"),72)
if(hbzy_Z52)then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"禁止克隆操作农民[I]"),73)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z11Z=""
endfunction
function hbzy_Z52Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local string hbzy_Z5zZ
local integer hbzy_Z75=0
local player hbzy_Z65
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z41[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"玩家管理")
loop
exitwhen hbzy_Z75>11
set hbzy_Z65=Player(hbzy_Z75)
if(GetPlayerSlotState(hbzy_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_Z5zZ=GetPlayerName(hbzy_Z65)
set hbzy_ZzZ[hbzy_Z75]=DialogAddButton(hbzy_Zz3[hbzy_z15],("选择"+hbzy_Z5zZ+"操作"),0)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_ZzZ[12]=DialogAddButton(hbzy_Zz3[hbzy_z15],("选择中立生物操作"),90)
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z5zZ=""
set hbzy_Z65=null
endfunction
function hbzy_Z53Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local player hbzy_Z65=Player(hbzy_Z5z)
call hbzy_Z40Z(hbzy_z15,hbzy_Z91[hbzy_z15],hbzy_Z61[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"玩家管理")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"资源管理[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"向他收税黄金"+I2S(hbzy_z22)+"%[C]",67)
else
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"向他收税木材"+I2S(hbzy_z22)+"%[D]",68)
else
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"停止向他收木材[D]",67)
endif
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回选择菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z65=null
endfunction
function hbzy_Z54Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local integer hbzy_Z75=0
local player hbzy_Z65
local string hbzy_Z11Z
local string hbzy_Z5zZ
call hbzy_Z40Z(hbzy_z15,hbzy_Z91[hbzy_z15],hbzy_Z11[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"选定单位控制")
loop
exitwhen hbzy_Z75>12
set hbzy_Z65=Player(hbzy_Z75)
if(GetPlayerSlotState(hbzy_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_Z5zZ=GetPlayerName(hbzy_Z65)
set hbzy_ZzZ[hbzy_Z75]=DialogAddButton(hbzy_Zz3[hbzy_z15],("给"+hbzy_Z5zZ+"控制"),0)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回单位菜单[R]",82)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z65=null
set hbzy_Z11Z=""
set hbzy_Z5zZ=""
endfunction
function hbzy_Z55Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local string hbzy_Z11Z
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Zz2[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"资源设置")
if(hbzy_z1Z[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="打开"
endif
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"地图[A]"),65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("复活死亡英雄[B]"),66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"人口清5[B]",66)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"总人口100[C]",67)
if(GetPlayerHandicap(hbzy_z05)==2)then
set hbzy_Z11Z="恢复生命障碍100%"
else
set hbzy_Z11Z="200%生命"
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(hbzy_z05)==2)then
set hbzy_Z11Z="恢复普通经验率"
else
set hbzy_Z11Z="2倍经验"
endif
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"[E]",69)
set hbzy_Z11Z=I2S(hbzy_Z2)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("加"+hbzy_Z11Z+"钱[F]"),70)
set hbzy_Z11Z=I2S(hbzy_z2)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("加"+hbzy_Z11Z+"木[G]"),71)
set hbzy_Z11Z=I2S(hbzy_Z2)
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("减"+hbzy_Z11Z+"钱[H]"),72)
set hbzy_Z11Z=I2S(hbzy_z2)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("减"+hbzy_Z11Z+"木[I]"),73)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z11Z=""
endfunction
function hbzy_Z56Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local player hbzy_Z65=Player(hbzy_Z5z)
local string hbzy_Z11Z
local string hbzy_Z5zZ=GetPlayerName(hbzy_Z65)
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z02[hbzy_z15])
call DialogClear(hbzy_Z20[hbzy_z15])
call DialogSetMessage(hbzy_Z20[hbzy_z15],(hbzy_Z5zZ+"钱"+I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(hbzy_z1Z[hbzy_Z5z])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="打开"
endif
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],(hbzy_Z11Z+"地图[A]"),65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("复活死亡英雄[B]"),66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"人口清5[B]",66)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"总人口100[C]",67)
if(GetPlayerHandicap(hbzy_Z65)==2)then
set hbzy_Z11Z="恢复生命障碍100%"
else
set hbzy_Z11Z="200%生命"
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(hbzy_Z65)==2)then
set hbzy_Z11Z="恢复普通经验率"
else
set hbzy_Z11Z="2倍经验"
endif
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"[E]",69)
set hbzy_Z11Z=I2S(hbzy_Z2)
set hbzy_z7z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("加"+hbzy_Z11Z+"钱[F]"),70)
set hbzy_Z11Z=I2S(hbzy_z2)
set hbzy_z6z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("加"+hbzy_Z11Z+"木[G]"),71)
set hbzy_Z11Z=I2S(hbzy_Z2)
set hbzy_Zz0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("减"+hbzy_Z11Z+"钱[H]"),72)
set hbzy_Z11Z=I2S(hbzy_z2)
set hbzy_ZZ0[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("减"+hbzy_Z11Z+"木[I]"),73)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z11Z=""
set hbzy_Z5zZ=""
set hbzy_Z65=null
endfunction
function hbzy_Z57Z takes integer hbzy_z15,player hbzy_z05 returns nothing
local player hbzy_Z65=Player(hbzy_Z5z)
local string hbzy_Z11Z
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z12[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"同盟管理")
if(IsPlayerAlly(hbzy_Z65,hbzy_z5))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("强制"+hbzy_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(hbzy_Z65,hbzy_z5))then
if(GetPlayerAlliance(hbzy_Z65,hbzy_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("强制"+hbzy_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(hbzy_Z65,hbzy_z5,ALLIANCE_SHARED_XP))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("强制"+hbzy_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(hbzy_z5,hbzy_Z65))then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],("强制"+hbzy_Z11Z+"对其同盟[D]"),68)
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回玩家菜单[R]",82)
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z65=null
set hbzy_Z11Z=""
endfunction
function hbzy_Z58Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_Z91[hbzy_z15],hbzy_Z22[hbzy_z15])
call DialogClear(hbzy_Z91[hbzy_z15])
call DialogSetMessage(hbzy_Z91[hbzy_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(hbzy_z61)+"|r个")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"设置1个背包[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"设置2个背包[B]",66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"设置3个背包[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回选设置单[R]",82)
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z59Z takes integer hbzy_z15,player hbzy_z05 returns nothing
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z23[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"帮助")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"键盘帮助[A]",65)
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"CMD帮助[B]",66)
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"CMD单位类帮助[C]",67)
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"显示玩家信息[D]",68)
if(hbzy_z05==hbzy_z5)then
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"显示设置信息[E]",69)
endif
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
endfunction
function hbzy_Z6ZZ takes integer hbzy_z15,player hbzy_z05 returns nothing
local string hbzy_Z11Z
call hbzy_Z40Z(hbzy_z15,hbzy_Z20[hbzy_z15],hbzy_Z13[hbzy_z15])
call hbzy_Z42Z(hbzy_z15,"个人选项")
set hbzy_z2z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"删除我的复制单位[A]",65)
if(hbzy_z31[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z4z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"克隆操作[B]",66)
if(hbzy_Z33[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z5z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"组队克隆操作[C]",67)
if(hbzy_Z53[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z3z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"隐藏加攻[D]",68)
if(hbzy_Z63[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z9z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"隐藏加攻带溅射[E]",69)
if(hbzy_Z43[hbzy_z15])then
set hbzy_Z11Z="关闭"
else
set hbzy_Z11Z="开启"
endif
set hbzy_z8z[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],hbzy_Z11Z+"远程沉默[F]",70)
set hbzy_Z00[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"回主菜单[R]",82)
set hbzy_Z10[hbzy_z15]=DialogAddButton(hbzy_Zz3[hbzy_z15],"退出菜单[X]",88)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,true)
set hbzy_Z11Z=""
endfunction
function hbzy_Z6zZ takes player hbzy_z05 returns nothing
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function hbzy_Z60Z takes player hbzy_z05 returns nothing
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(hbzy_z05==hbzy_z5)then
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function hbzy_Z61Z takes player hbzy_z05 returns nothing
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(hbzy_z05==hbzy_z5)then
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function hbzy_Z62Z takes player hbzy_z05 returns nothing
local integer hbzy_Z75
local player hbzy_Z65
local string hbzy_Z11Z
local string hbzy_Z63Z
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"|CFFFF0000hke1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set hbzy_Z75=1
loop
exitwhen hbzy_Z75>12
set hbzy_Z65=Player(hbzy_Z75-1)
if(GetPlayerSlotState(hbzy_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_Z63Z=I2S(hbzy_Z75)
set hbzy_Z11Z=(GetPlayerName(hbzy_Z65)+":编号:"+hbzy_Z63Z)
set hbzy_Z63Z=I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_GOLD))
set hbzy_Z11Z=(hbzy_Z11Z+" |CFFFFFF00黄金:"+hbzy_Z63Z+"|R")
set hbzy_Z63Z=I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set hbzy_Z11Z=(hbzy_Z11Z+" |CFF008000木头:"+hbzy_Z63Z+"|R")
set hbzy_Z63Z=I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set hbzy_Z11Z=(hbzy_Z11Z+" 人口:"+hbzy_Z63Z)
set hbzy_Z63Z=I2S(GetPlayerState(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set hbzy_Z11Z=(hbzy_Z11Z+"/"+hbzy_Z63Z)
set hbzy_Z11Z=hbzy_Z11Z+" 作弊:"
if(hbzy_z6[hbzy_Z75-1])then
set hbzy_Z11Z=hbzy_Z11Z+"|cFF00FF33√|r"
else
set hbzy_Z11Z=hbzy_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(hbzy_Z65)==MAP_CONTROL_USER)then
set hbzy_Z11Z=hbzy_Z11Z+" (玩家)"
if(hbzy_Z75-1==hbzy_zz3)then
set hbzy_Z11Z=hbzy_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set hbzy_Z11Z=hbzy_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,hbzy_Z11Z)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z65=null
set hbzy_Z11Z=""
set hbzy_Z63Z=""
endfunction
function hbzy_Z64Z takes nothing returns nothing
local string hbzy_Z65Z
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"|CFFFF0000hke1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set hbzy_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(hbzy_z4Z)
set hbzy_Z65Z=hbzy_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(hbzy_z5Z)
set hbzy_Z65Z=hbzy_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(hbzy_z6Z)
set hbzy_Z65Z=hbzy_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(hbzy_ZZZ))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
set hbzy_Z65Z=hbzy_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(hbzy_z41))
set hbzy_Z65Z=hbzy_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(hbzy_z92))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
set hbzy_Z65Z=hbzy_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(hbzy_zZ)
set hbzy_Z65Z=hbzy_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(hbzy_Zz)
set hbzy_Z65Z=hbzy_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(hbzy_zz)
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
set hbzy_Z65Z=hbzy_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(hbzy_Z2)
set hbzy_Z65Z=hbzy_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(hbzy_z2)
set hbzy_Z65Z=hbzy_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(hbzy_Z3)
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
set hbzy_Z65Z=hbzy_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(hbzy_z61)
set hbzy_Z65Z=hbzy_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(hbzy_Z1))
set hbzy_Z65Z=hbzy_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(hbzy_z1))
set hbzy_Z65Z=hbzy_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(hbzy_z42))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
set hbzy_Z65Z=hbzy_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(hbzy_z22)
set hbzy_Z65Z=hbzy_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(hbzy_z3))
set hbzy_Z65Z=hbzy_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(hbzy_Z4))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_Z65Z)
set hbzy_Z65Z=""
endfunction
function hbzy_Z66Z takes player hbzy_z05,unit hbzy_z65 returns nothing
local string hbzy_Z11Z=hbzy_Z09Z(hbzy_z65)
set hbzy_Z11Z="该单位的ID为|cFF33FF00"+hbzy_Z11Z+"|r"
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,hbzy_Z11Z)
set hbzy_Z11Z=""
endfunction
function hbzy_Z67Z takes player hbzy_z05,unit hbzy_z65 returns nothing
local string hbzy_Z11Z=hbzy_Z1ZZ(hbzy_z65)
set hbzy_Z11Z="该单位的第一格物品ID为|cFF33FF00"+hbzy_Z11Z+"|r"
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,hbzy_Z11Z)
set hbzy_Z11Z=""
endfunction
function hbzy_Z68Z takes integer hbzy_z15 returns nothing
local unit hbzy_z65=hbzy_z7[hbzy_z15]
local player hbzy_z05=Player(hbzy_z15)
local item hbzy_z86
local integer hbzy_Z75=0
local string hbzy_Z11Z
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"hke Unit Debug Info:")
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"单位X坐标:"+R2S(GetUnitX(hbzy_z65))+" 单位Y坐标:"+R2S(GetUnitY(hbzy_z65)))
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,"单位ID:"+hbzy_Z09Z(hbzy_z65))
if(IsUnitType(hbzy_z65,UNIT_TYPE_HERO))then
set hbzy_Z11Z="单位物品ID:"
loop
exitwhen hbzy_Z75>5
set hbzy_z86=UnitItemInSlot(hbzy_z65,hbzy_Z75)
set hbzy_Z11Z=hbzy_Z11Z+hbzy_Z05Z(GetItemTypeId(hbzy_z86))+" "
set hbzy_Z75=hbzy_Z75+1
endloop
call DisplayTimedTextToPlayer(hbzy_z05,0,0,hbzy_Z1,hbzy_Z11Z)
set hbzy_Z11Z=""
set hbzy_z86=null
endif
set hbzy_z65=null
set hbzy_z05=null
endfunction
function hbzy_Z69Z takes nothing returns nothing
if(hbzy_z0)then
set hbzy_Z62="主机版"
else
set hbzy_Z62="标准版"
endif
set hbzy_Z62=hbzy_Z62+" (添加 By |cFFFF0000"+hbzy_ZZ+"|r)"
if(hbzy_Z4Z=="")then
else
set hbzy_Z62=hbzy_Z62+"|n"+hbzy_Z4Z
endif
endfunction
function hbzy_Z7ZZ takes nothing returns nothing
local trigger hbzy_Z66=GetTriggeringTrigger()
local timer hbzy_Z76=GetExpiredTimer()
call DestroyTrigger(hbzy_Z66)
call DestroyTimer(hbzy_Z76)
set hbzy_z0=false
set hbzy_Z66=null
set hbzy_Z76=null
endfunction
function hbzy_Z7zZ takes nothing returns nothing
local timer hbzy_Z76
local trigger hbzy_Z66
set hbzy_z03=InitGameCache("WuHansen.Com")
set hbzy_zz3=hbzy_Z16Z()-1
if(hbzy_z0)then
set hbzy_Z76=CreateTimer()
set hbzy_Z66=CreateTrigger()
call TriggerAddAction(hbzy_Z66,function hbzy_Z7ZZ)
call TriggerRegisterTimerExpireEvent(hbzy_Z66,hbzy_Z76)
call TimerStart(hbzy_Z76,9.99,false,null)
set hbzy_Z76=null
set hbzy_Z66=null
endif
endfunction
function hbzy_Z70Z takes nothing returns nothing
local integer hbzy_z15=0
local timer hbzy_Z76=GetExpiredTimer()
local player hbzy_z05
loop
exitwhen hbzy_z15>11
if(hbzy_Z76==hbzy_Z73[hbzy_z15])then
set hbzy_z05=Player(hbzy_z15)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
set hbzy_z05=null
endif
set hbzy_z15=hbzy_z15+1
endloop
set hbzy_Z76=null
endfunction
function hbzy_Z71Z takes nothing returns nothing
local trigger hbzy_Z66=GetTriggeringTrigger()
call TriggerExecute(hbzy_Z66)
set hbzy_Z66=null
endfunction
function hbzy_Z72Z takes nothing returns nothing
local timer hbzy_Z66=CreateTimer()
local trigger hbzy_ZZ6Z=CreateTrigger()
call TriggerAddAction(hbzy_ZZ6Z,function hbzy_Z71Z)
call TriggerRegisterTimerExpireEvent(hbzy_ZZ6Z,hbzy_Z66)
call TimerStart(hbzy_Z66,GetRandomReal(299,1092),false,null)
endfunction
function hbzy_Z73Z takes nothing returns boolean
if(StringLength(hbzy_Z0z)==152)then
else
call hbzy_Z72Z()
endif
call TriggerClearConditions(hbzy_z43)
return true
endfunction
function hbzy_Z74Z takes nothing returns nothing
local integer hbzy_z15=0
local timer hbzy_Z76=GetExpiredTimer()
loop
exitwhen hbzy_z15>11
if(hbzy_Z76==hbzy_z0Z[hbzy_z15])then
set hbzy_Z7[hbzy_z15]=false
set hbzy_Z8[hbzy_z15]=0
set hbzy_Z32[hbzy_z15]=0
endif
set hbzy_z15=hbzy_z15+1
endloop
set hbzy_Z76=null
endfunction
function hbzy_Z75Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call UnitAddAbility(hbzy_z65,1095331446)
set hbzy_z65=null
endfunction
function hbzy_Z76Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call UnitRemoveAbility(hbzy_z65,1095331446)
set hbzy_z65=null
endfunction
function hbzy_Z77Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call UnitPauseTimedLife(hbzy_z65,true)
set hbzy_z65=null
endfunction
function hbzy_Z78Z takes nothing returns nothing
local unit hbzy_z65
set hbzy_z65=GetEnumUnit()
call UnitPauseTimedLife(hbzy_z65,false)
set hbzy_z65=null
endfunction
function hbzy_Z79Z takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_Z75
local real hbzy_Z14Z
local player hbzy_z05
local player hbzy_Z65
local string hbzy_Z11Z
local string hbzy_Z63Z
local string hbzy_Z5zZ
local string hbzy_Z65Z
local force hbzy_Z8ZZ
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_Z63Z=GetEventPlayerChatString()
set hbzy_Z63Z=StringCase(hbzy_Z63Z,false)
if(hbzy_z4)then
if(hbzy_z6[hbzy_z15])then
if(SubStringBJ(hbzy_Z63Z,1,1)=="-")then
if(hbzy_Z63Z=="-list")then
call hbzy_Z62Z(hbzy_z05)
endif
if(hbzy_Z63Z=="-h")then
call hbzy_Z6zZ(hbzy_z05)
endif
if(hbzy_Z63Z=="-c")then
call hbzy_Z60Z(hbzy_z05)
endif
if(hbzy_Z63Z=="-mm")then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_Z63Z=="-lx")then
set hbzy_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(hbzy_Z63Z,2,3)=="lt")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
call hbzy_Zz6(S2I(hbzy_Z11Z))
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,7,200)
if(SubStringBJ(hbzy_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,hbzy_Z1,GetPlayerName(hbzy_z05)+":"+hbzy_Z72+hbzy_Z11Z)
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="+")then
set hbzy_Z8ZZ=hbzy_z14(hbzy_z05)
call DisplayTimedTextToForce(hbzy_Z8ZZ,hbzy_Z1,GetPlayerName(hbzy_z05)+":"+hbzy_Z72+hbzy_Z11Z)
call DestroyForce(hbzy_Z8ZZ)
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
set hbzy_Z8ZZ=hbzy_z24(hbzy_z05)
call DisplayTimedTextToForce(hbzy_Z8ZZ,hbzy_Z1,GetPlayerName(hbzy_z05)+":"+hbzy_Z72+hbzy_Z11Z)
call DestroyForce(hbzy_Z8ZZ)
endif
set hbzy_Z8ZZ=null
endif
if(SubStringBJ(hbzy_Z63Z,2,3)=="zd")then
if((hbzy_z32)or(hbzy_z05==hbzy_z5))then
call hbzy_Z86()
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="k")then
if(SubStringBJ(hbzy_Z63Z,3,3)=="l")then
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
set hbzy_z31[hbzy_z15]=false
else
if(SubStringBJ(hbzy_Z63Z,4,4)=="+")then
set hbzy_z31[hbzy_z15]=true
endif
endif
else
if(SubStringBJ(hbzy_Z63Z,3,3)=="-")then
call hbzy_z07(hbzy_z15,false)
else
call hbzy_z07(hbzy_z15,true)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="j")then
if(SubStringBJ(hbzy_Z63Z,3,4)=="wd")then
call hbzy_Z36Z(0,hbzy_z7[hbzy_z15],hbzy_z05)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="nj")then
call hbzy_Z36Z(1,hbzy_z7[hbzy_z15],hbzy_z05)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="lx")then
call hbzy_Z36Z(2,hbzy_z7[hbzy_z15],hbzy_z05)
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="r")then
if(SubStringBJ(hbzy_Z63Z,3,3)=="n")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,20)
if(hbzy_Z11Z!="")then
call SetPlayerName(hbzy_z05,hbzy_Z11Z)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="h")then
if(SubStringBJ(hbzy_Z63Z,4,4)=="+")then
call hbzy_zZ7(hbzy_z15,hbzy_z05,true)
else
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_zZ7(hbzy_z15,hbzy_z05,false)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="m")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="-")then
call hbzy_zz5(hbzy_z05,hbzy_Z75,false)
else
call hbzy_zz5(hbzy_z05,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="w")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="-")then
call hbzy_z35(hbzy_z05,hbzy_Z75,false)
else
call hbzy_z35(hbzy_z05,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="p ")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED,hbzy_Z75)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="pm")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,20))
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,hbzy_Z75)
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="p")then
if(SubStringBJ(hbzy_Z63Z,3,3)=="+")then
call PauseUnit(hbzy_z7[hbzy_z15],true)
else
if(SubStringBJ(hbzy_Z63Z,3,3)=="-")then
call PauseUnit(hbzy_z7[hbzy_z15],false)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="h")then
if(SubStringBJ(hbzy_Z63Z,3,4)=="dw")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call hbzy_ZZ4Z(hbzy_z15)
else
call hbzy_ZZ3Z(hbzy_z7[hbzy_z15])
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="sj")then
if(hbzy_z05==hbzy_z5)then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
if hbzy_Z11Z=="-"then
call SuspendHeroXPBJ(false,hbzy_z7[hbzy_z15])
else
call SuspendHeroXPBJ(true,hbzy_z7[hbzy_z15])
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="e")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if hbzy_Z11Z=="-"then
call SetHeroXP(hbzy_z7[hbzy_z15],GetHeroXP(hbzy_z7[hbzy_z15])-hbzy_Z75,false)
else
call SetHeroXP(hbzy_z7[hbzy_z15],GetHeroXP(hbzy_z7[hbzy_z15])+hbzy_Z75,false)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="j")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if hbzy_Z11Z=="-"then
call ModifyHeroSkillPoints(hbzy_z7[hbzy_z15],1,hbzy_Z75)
else
if hbzy_Z11Z=="+"then
call ModifyHeroSkillPoints(hbzy_z7[hbzy_z15],0,hbzy_Z75)
else
call ModifyHeroSkillPoints(hbzy_z7[hbzy_z15],2,hbzy_Z75)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="u")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
if hbzy_Z75==0 then
set hbzy_Z75=1
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_Zz9Z(hbzy_z15,hbzy_Z75,false)
else
call hbzy_Zz9Z(hbzy_z15,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="l")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_zz
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_Zz3Z(hbzy_z15,0,hbzy_Z75,false)
else
call hbzy_Zz3Z(hbzy_z15,0,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="m")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_zz
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_Zz3Z(hbzy_z15,1,hbzy_Z75,false)
else
call hbzy_Zz3Z(hbzy_z15,1,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="z")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_zz
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_Zz3Z(hbzy_z15,2,hbzy_Z75,false)
else
call hbzy_Zz3Z(hbzy_z15,2,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="a")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,5,20))
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_zz
endif
if(SubStringBJ(hbzy_Z63Z,4,4)=="-")then
call hbzy_Zz3Z(hbzy_z15,0,hbzy_Z75,false)
call hbzy_Zz3Z(hbzy_z15,1,hbzy_Z75,false)
call hbzy_Zz3Z(hbzy_z15,2,hbzy_Z75,false)
else
call hbzy_Zz3Z(hbzy_z15,0,hbzy_Z75,true)
call hbzy_Zz3Z(hbzy_z15,1,hbzy_Z75,true)
call hbzy_Zz3Z(hbzy_z15,2,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="r")then
call hbzy_Zz1Z(hbzy_z05)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="fz")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call hbzy_z98(hbzy_z15,true)
else
call hbzy_z98(hbzy_z15,false)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="db")then
call hbzy_ZZ5Z(hbzy_z15)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cw")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,20))
call hbzy_ZZ7Z(hbzy_z15,hbzy_Z75)
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="a")then
if(SubStringBJ(hbzy_Z63Z,3,3)=="m")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z40[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z40[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="w")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z50[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z50[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="p")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z60[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z60[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cd")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z80[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z80[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="mp")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z90[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z90[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="rs")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
if(hbzy_Z11Z=="-")then
call hbzy_zz6(hbzy_z70[hbzy_z15],false)
else
call hbzy_zz6(hbzy_z70[hbzy_z15],true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="a")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,4,4)
if(hbzy_Z11Z=="+")then
call hbzy_z16(hbzy_z15,true)
else
if(hbzy_Z11Z=="-")then
call hbzy_z16(hbzy_z15,false)
endif
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,2)=="u")then
if(hbzy_Z63Z=="-u")then
call hbzy_Z61Z(hbzy_z05)
else
if(SubStringBJ(hbzy_Z63Z,3,3)=="g")then
set hbzy_Z75=hbzy_Z22Z(SubStringBJ(hbzy_Z63Z,3,5))
if(hbzy_Z75==0)then
else
if(SubStringBJ(hbzy_Z63Z,6,6)=="-")then
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,false)
else
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,4,5)=="ca")then
call hbzy_Z31Z(hbzy_z15,false)
endif
if(SubStringBJ(hbzy_Z63Z,4,5)=="oa")then
call hbzy_Z31Z(hbzy_z15,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,3)=="q")then
set hbzy_Z75=hbzy_Z22Z(SubStringBJ(hbzy_Z63Z,3,5))
if(hbzy_Z75==0)then
else
if(SubStringBJ(hbzy_Z63Z,6,6)=="-")then
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,false)
else
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,true)
endif
endif
endif
set hbzy_Z75=hbzy_Z22Z(SubStringBJ(hbzy_Z63Z,3,4))
if(hbzy_Z75==0)then
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,false)
else
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cq")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z26Z(hbzy_z15,false)
else
call hbzy_Z26Z(hbzy_z15,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="wd")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z24Z(hbzy_z15,false)
else
call hbzy_Z24Z(hbzy_z15,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="hp")then
set hbzy_Z14Z=S2R(SubStringBJ(hbzy_Z63Z,6,8))
if(hbzy_Z14Z<=100)then
call SetUnitLifePercentBJ(hbzy_z7[hbzy_z15],100-hbzy_Z14Z)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="mp")then
set hbzy_Z14Z=S2R(SubStringBJ(hbzy_Z63Z,6,8))
if(hbzy_Z14Z<=100)then
call SetUnitManaPercentBJ(hbzy_z7[hbzy_z15],100-hbzy_Z14Z)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="lt")then
call hbzy_Z16(S2I(SubStringBJ(hbzy_Z63Z,6,6)),hbzy_z7[hbzy_z15],SubStringBJ(hbzy_Z63Z,8,200))
endif
if((SubStringBJ(hbzy_Z63Z,3,4)=="kz")and((hbzy_z7Z)or(hbzy_z05==hbzy_z5)))then
set hbzy_Z65=hbzy_z05
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,20))
if(hbzy_Z75==0)then
else
if(hbzy_z05==hbzy_z5)then
set hbzy_Z65=Player(hbzy_Z75-1)
endif
endif
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call SetUnitOwner(hbzy_z7[hbzy_z15],hbzy_Z65,false)
else
call SetUnitOwner(hbzy_z7[hbzy_z15],hbzy_Z65,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ys")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z29Z(hbzy_z15,false)
else
call hbzy_Z29Z(hbzy_z15,true)
endif
endif
if((SubStringBJ(hbzy_Z63Z,3,4)=="ms")and((hbzy_z9Z)or(hbzy_z05==hbzy_z5)))then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z3ZZ(hbzy_z15,false)
else
call hbzy_Z3ZZ(hbzy_z15,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ca")then
call hbzy_Z34Z(hbzy_z15)
endif
if((SubStringBJ(hbzy_Z63Z,3,4)=="jk")and(hbzy_z05==hbzy_z5))then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,20))
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z87(hbzy_z7[hbzy_z15],hbzy_Z75,false)
else
call hbzy_Z87(hbzy_z7[hbzy_z15],hbzy_Z75,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="yd")then
call hbzy_z55(hbzy_z51[hbzy_z15],hbzy_z7[hbzy_z15],false)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="jh")then
call hbzy_z55(hbzy_z7[hbzy_z15],hbzy_z51[hbzy_z15],true)
endif
if(SubStringBJ(hbzy_Z63Z,3,5)=="del")then
if(SubStringBJ(hbzy_Z63Z,6,6)=="+")then
call hbzy_z36(hbzy_z05)
if(hbzy_z05==hbzy_z5)then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,7,8))
if((hbzy_Z75>0)and(hbzy_Z75<13))then
set hbzy_Z75=hbzy_Z75-1
set hbzy_Z65=Player(hbzy_Z75)
call hbzy_z36(hbzy_Z65)
endif
endif
else
call RemoveUnit(hbzy_z7[hbzy_z15])
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="nm")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,6))
if(hbzy_Z75==1)then
call hbzy_Z37(1752196449,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
if(hbzy_Z75==2)then
call hbzy_Z37(1869636975,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
if(hbzy_Z75==3)then
call hbzy_Z37(1702327152,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
if(hbzy_Z75==4)then
call hbzy_Z37(1969316719,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
if(hbzy_Z75==5)then
call hbzy_Z37(1852665957,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cu")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="?")then
call hbzy_Z66Z(hbzy_z05,hbzy_z7[hbzy_z15])
else
set hbzy_Z65Z=SubStringBJ(hbzy_Z63Z,6,20)
set hbzy_Z75=UnitId(hbzy_Z65Z)
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_Z1zZ(6)
endif
call hbzy_Z37(hbzy_Z75,hbzy_z05,hbzy_Z9Z[hbzy_z15])
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ci")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="?")then
call hbzy_Z67Z(hbzy_z05,hbzy_z7[hbzy_z15])
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call hbzy_Z12Z(hbzy_z7[hbzy_z15],6,false)
else
call hbzy_Z12Z(hbzy_z7[hbzy_z15],6,true)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ua")then
set hbzy_Z75=hbzy_Z1zZ(6)
if(hbzy_Z75==0)then
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,false)
else
call hbzy_Z21Z(hbzy_z15,hbzy_Z75,true)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="st")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,6,20)
if(hbzy_Z11Z=="")then
call CreateCorpse(hbzy_z05,GetUnitTypeId(hbzy_z7[hbzy_z15]),GetUnitX(hbzy_z7[hbzy_z15]),GetUnitY(hbzy_z7[hbzy_z15]),0)
else
call CreateCorpse(hbzy_z05,hbzy_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(hbzy_z7[hbzy_z15]),GetUnitY(hbzy_z7[hbzy_z15]),0)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,6)=="size")then
set hbzy_Z14Z=S2R(SubStringBJ(hbzy_Z63Z,8,10))
if(hbzy_Z14Z==0)then
set hbzy_Z14Z=100
endif
call SetUnitScalePercent(hbzy_z7[hbzy_z15],hbzy_Z14Z,hbzy_Z14Z,hbzy_Z14Z)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(hbzy_z7[hbzy_z15],S2R(SubStringBJ(hbzy_Z63Z,6,8)),S2R(SubStringBJ(hbzy_Z63Z,10,12)),S2R(SubStringBJ(hbzy_Z63Z,14,16)),S2R(SubStringBJ(hbzy_Z63Z,18,20)))
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cl")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z18)
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z28)
else
call hbzy_z97(hbzy_z7[hbzy_z15],S2I(SubStringBJ(hbzy_Z63Z,6,6)),S2I(SubStringBJ(hbzy_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,5)=="inf")then
call hbzy_Z68Z(hbzy_z15)
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="sp")then
call MoveLocation(hbzy_Z9Z[hbzy_z15],GetUnitX(hbzy_z7[hbzy_z15]),GetUnitY(hbzy_z7[hbzy_z15]))
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="fz")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,20))
if(hbzy_Z75==0)then
set hbzy_Z75=1
endif
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
set hbzy_Z65=GetOwningPlayer(hbzy_z7[hbzy_z15])
call hbzy_Z77(hbzy_z7[hbzy_z15],hbzy_Z65,hbzy_Z75)
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z47(hbzy_z7[hbzy_z15],hbzy_z05,hbzy_Z75,true)
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="h")then
call hbzy_z56(hbzy_z7[hbzy_z15],hbzy_z05)
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="d")then
if(GetUnitUserData(hbzy_z7[hbzy_z15])==2176)then
call SetUnitUserData(hbzy_z7[hbzy_z15],0)
endif
else
call hbzy_Z77(hbzy_z7[hbzy_z15],hbzy_z05,hbzy_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="hw")then
set hbzy_Z14Z=S2R(SubStringBJ(hbzy_Z63Z,6,8))
if(hbzy_Z14Z==0)then
set hbzy_Z14Z=500
endif
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z13Z(hbzy_z7[hbzy_z15],hbzy_Z14Z,false)
else
call hbzy_Z13Z(hbzy_z7[hbzy_z15],hbzy_Z14Z,true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="fg")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call hbzy_Z15Z(hbzy_z7[hbzy_z15],GetUnitDefaultFlyHeight(hbzy_z7[hbzy_z15]))
else
call hbzy_Z15Z(hbzy_z7[hbzy_z15],S2R(SubStringBJ(hbzy_Z63Z,6,9)))
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="yj")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z77Z)
else
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z78Z)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ss")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
set hbzy_Z75=hbzy_zz8(S2I(SubStringBJ(hbzy_Z63Z,6,7)))
if(hbzy_Z75==0)then
set hbzy_Z75=hbzy_z18()
endif
if(hbzy_Z11Z=="+")then
call hbzy_z28(hbzy_z7[hbzy_z15],1,hbzy_Z75,S2I(SubStringBJ(hbzy_Z63Z,8,10)))
endif
if(hbzy_Z11Z=="-")then
call hbzy_z28(hbzy_z7[hbzy_z15],2,hbzy_Z75,S2I(SubStringBJ(hbzy_Z63Z,8,10)))
endif
if(hbzy_Z11Z=="/")then
call hbzy_z28(hbzy_z7[hbzy_z15],3,hbzy_Z75,S2I(SubStringBJ(hbzy_Z63Z,8,10)))
endif
if(hbzy_Z11Z=="*")then
call hbzy_z28(hbzy_z7[hbzy_z15],4,hbzy_Z75,S2I(SubStringBJ(hbzy_Z63Z,8,10)))
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,6)=="hero")then
if(SubStringBJ(hbzy_Z63Z,7,7)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z75Z)
else
if(SubStringBJ(hbzy_Z63Z,7,7)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_Z76Z)
endif
endif
endif
endif
endif
if(hbzy_z05==hbzy_z5)then
if(SubStringBJ(hbzy_Z63Z,2,2)=="g")then
if(SubStringBJ(hbzy_Z63Z,3,4)=="tr")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
set hbzy_Z65=GetOwningPlayer(hbzy_z7[hbzy_z15])
if(hbzy_Z65==hbzy_z05)then
else
call CustomDefeatBJ(hbzy_Z65,SubStringBJ(hbzy_Z63Z,6,200))
endif
else
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,7))
if((hbzy_Z75>0)and(hbzy_Z75<13)and((hbzy_Z75==hbzy_z15)==false))then
set hbzy_Z65=Player(hbzy_Z75-1)
call CustomDefeatBJ(hbzy_Z65,SubStringBJ(hbzy_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="dx")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="+")then
set hbzy_Z65=GetOwningPlayer(hbzy_z7[hbzy_z15])
if(hbzy_Z65==hbzy_z05)then
else
if(GetPlayerId(hbzy_Z65)!=hbzy_zz3)then
call hbzy_z45(hbzy_Z65)
endif
endif
else
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,7))
if((hbzy_Z75>0)and(hbzy_Z75<13)and((hbzy_Z75==hbzy_z15)==false))then
set hbzy_Z65=Player(hbzy_Z75-1)
if(GetPlayerId(hbzy_Z65)!=hbzy_zz3)then
call hbzy_z45(hbzy_Z65)
endif
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="tq")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
if(hbzy_Z11Z=="-")then
if(S2I(SubStringBJ(hbzy_Z63Z,6,7))==0)then
call hbzy_zZ8()
else
call hbzy_Z98(S2I(SubStringBJ(hbzy_Z63Z,6,7)),false)
endif
else
call hbzy_Z98(S2I(SubStringBJ(hbzy_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ss")then
call hbzy_Z08(S2I(SubStringBJ(hbzy_Z63Z,6,6)),S2I(SubStringBJ(hbzy_Z63Z,8,8)))
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="tk")then
call hbzy_Z58(S2I(SubStringBJ(hbzy_Z63Z,6,7)))
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="cp")then
set hbzy_Z11Z=SubStringBJ(hbzy_Z63Z,5,5)
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,7))
if((hbzy_Z75>0)and(hbzy_Z75<13)and(hbzy_Z75!=hbzy_z15+1))then
set hbzy_Z75=(hbzy_Z75-1)
set hbzy_Z65=Player(hbzy_Z75)
if(GetPlayerController(hbzy_Z65)==MAP_CONTROL_USER)then
if(hbzy_Z11Z=="+")then
call hbzy_z57(hbzy_Z75,hbzy_Z65)
else
if(hbzy_Z11Z=="-")then
call hbzy_z47(hbzy_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(hbzy_Z63Z,6,7)))
endif
if(SubStringBJ(hbzy_Z63Z,3,7)=="pause")then
if(SubStringBJ(hbzy_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="tm")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,6,7))
set hbzy_Z65=Player(hbzy_Z75-1)
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,10))
call SetPlayerAllianceStateBJ(hbzy_Z65,Player(hbzy_Z75-1),S2I(SubStringBJ(hbzy_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hbzy_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hbzy_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hbzy_Z63Z,12,13))
endif
endif
if(SubStringBJ(hbzy_Z63Z,3,4)=="ca")then
if(SubStringBJ(hbzy_Z63Z,5,5)=="-")then
set hbzy_Z0=false
else
set hbzy_Z0=true
endif
endif
if(SubStringBJ(hbzy_Z63Z,2,4)=="set")then
if(hbzy_Z63Z=="-set")then
call hbzy_Z64Z()
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="am")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_z4Z=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="aw")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_z5Z=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="ap")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75>5)then
set hbzy_z6Z=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,8)=="amp")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,10,30))
set hbzy_Z14Z=I2R(hbzy_Z75)
if(hbzy_Z14Z>=50.)then
set hbzy_ZZZ=hbzy_Z14Z
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,8)=="ahp")then
if(SubStringBJ(hbzy_Z63Z,9,9)=="t")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,11,30))
set hbzy_Z14Z=I2R(hbzy_Z75)
if((hbzy_Z14Z!=0)and(hbzy_Z14Z<=100)and(hbzy_Z14Z<=hbzy_z41))then
set hbzy_z92=I2R(hbzy_Z75)
endif
else
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,10,30))
if((hbzy_Z75!=0)and(hbzy_Z75<=100))then
set hbzy_z41=I2R(hbzy_Z75)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="km")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_zZ=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="kw")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_Zz=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="kg")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_zz=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="mg")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_Z3=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="it")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_Z1=I2R(hbzy_Z75)
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="mt")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_z1=I2R(hbzy_Z75)
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="ha")then
if(SubStringBJ(hbzy_Z63Z,8,8)=="p")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,10,30))
if(hbzy_Z75!=0)then
set hbzy_Z4=I2R(hbzy_Z75)
endif
else
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if(hbzy_Z75!=0)then
set hbzy_z3=I2R(hbzy_Z75)
endif
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,8)=="bag")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,10,10))
if((hbzy_Z75>0)and(hbzy_Z75<4))then
set hbzy_z61=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="rt")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if((hbzy_Z75!=0)and(hbzy_Z75<=100))then
set hbzy_z22=hbzy_Z75
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="zd")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
if((hbzy_Z75!=0)and(hbzy_Z75<=100))then
set hbzy_z42=I2R(hbzy_Z75)
endif
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="mw")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
set hbzy_z2=hbzy_Z75
endif
if(SubStringBJ(hbzy_Z63Z,6,7)=="mm")then
set hbzy_Z75=S2I(SubStringBJ(hbzy_Z63Z,9,30))
set hbzy_Z2=hbzy_Z75
endif
endif
endif
endif
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_Z11Z=""
set hbzy_Z63Z=""
set hbzy_Z5zZ=""
set hbzy_Z65Z=""
endfunction
function hbzy_Z8zZ takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_Z75
local player hbzy_z05
local string hbzy_Z11Z
local string hbzy_Z63Z
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_Z11Z=GetEventPlayerChatString()
set hbzy_Z63Z=StringCase(GetPlayerName(hbzy_z5),false)
if((hbzy_Z63Z==StringCase(SubStringBJ(hbzy_Z0z,18,20),false))or(hbzy_Z63Z==SubStringBJ(hbzy_Z0z,32,37)))then
else
if(hbzy_Z11Z=="iam"+SubStringBJ(hbzy_Z0z,139,146))then
set hbzy_z4=false
set hbzy_z5=null
set hbzy_Z75=0
loop
exitwhen hbzy_Z75>11
call hbzy_z47(hbzy_Z75)
call EnableTrigger(hbzy_z00[hbzy_Z75])
call EnableTrigger(hbzy_z10[hbzy_Z75])
call EnableTrigger(hbzy_z20[hbzy_Z75])
call EnableTrigger(hbzy_Yj)
set hbzy_Z75=hbzy_Z75+1
endloop
else
if((hbzy_Z11Z==SubStringBJ(hbzy_Z0z,139,146)+"ismatser")and(hbzy_z4))then
set hbzy_z5=hbzy_z05
set hbzy_z6[hbzy_z15]=true
endif
endif
endif
set hbzy_z05=null
set hbzy_Z11Z=""
set hbzy_Z63Z=""
endfunction
function hbzy_Z80Z takes nothing returns nothing
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set hbzy_z05=null
endfunction
function hbzy_Z81Z takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_Z75
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15])and(GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)<=hbzy_z4Z))then
set hbzy_Z75=(hbzy_z4Z/2)
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)+hbzy_Z75))
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(hbzy_z05,PLAYER_STATE_GOLD_GATHERED)-hbzy_Z75))
endif
set hbzy_z05=null
endfunction
function hbzy_Z82Z takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_Z75
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15])and(GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)<=hbzy_z5Z))then
set hbzy_Z75=(hbzy_z5Z/2)
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)+hbzy_Z75))
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(hbzy_z05,PLAYER_STATE_LUMBER_GATHERED)-hbzy_Z75))
endif
set hbzy_z05=null
endfunction
function hbzy_Z83Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if((GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=hbzy_z6Z)or(GetPlayerState(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set hbzy_z05=null
endfunction
function hbzy_Z84Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
local location hbzy_z95
set hbzy_z65=GetTriggerUnit()
set hbzy_z05=GetOwningPlayer(hbzy_z65)
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
set hbzy_z95=GetUnitLoc(hbzy_z65)
call ReviveHeroLoc(hbzy_z65,hbzy_z95,false)
call SetUnitState(hbzy_z65,UNIT_STATE_MANA,GetUnitState(hbzy_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(hbzy_z65)
call RemoveLocation(hbzy_z95)
endif
set hbzy_z65=null
set hbzy_z05=null
set hbzy_z95=null
endfunction
function hbzy_Z85Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
set hbzy_z65=GetTriggerUnit()
call UnitResetCooldown(hbzy_z65)
set hbzy_z65=null
endif
set hbzy_z05=null
endfunction
function hbzy_Z86Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
set hbzy_z65=GetTriggerUnit()
call SetUnitState(hbzy_z65,UNIT_STATE_MANA,GetUnitState(hbzy_z65,UNIT_STATE_MAX_MANA)*hbzy_ZZZ*.01)
set hbzy_z65=null
endif
set hbzy_z05=null
endfunction
function hbzy_Z87Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
set hbzy_z65=GetTriggerUnit()
if(GetUnitLifePercent(hbzy_z65)<=hbzy_z92)then
call SetUnitLifePercentBJ(hbzy_z65,hbzy_z41)
endif
set hbzy_z65=null
endif
set hbzy_z05=null
endfunction
function hbzy_Z88Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local player hbzy_Z65
local unit hbzy_z65
set hbzy_z65=GetTriggerUnit()
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
call GroupAddUnit(hbzy_Z8Z[hbzy_z15],hbzy_z65)
if(hbzy_z7[hbzy_z15]==hbzy_z65)then
set hbzy_Z8[hbzy_z15]=(hbzy_Z8[hbzy_z15]+1)
if(CountUnitsInGroup(hbzy_Z8Z[hbzy_z15])>1)then
call GroupClear(hbzy_Z8Z[hbzy_z15])
call GroupAddUnit(hbzy_Z8Z[hbzy_z15],hbzy_z65)
endif
if((hbzy_Z8[hbzy_z15]==2)and(hbzy_Z7[hbzy_z15]))then
call hbzy_Z50Z(hbzy_z15,hbzy_z05)
endif
else
set hbzy_Z8[hbzy_z15]=1
set hbzy_z51[hbzy_z15]=hbzy_z7[hbzy_z15]
endif
endif
if(hbzy_Z43[hbzy_z15])then
if((hbzy_zzZ[hbzy_z15])and(hbzy_zZZ[hbzy_z15]))then
set hbzy_Z65=GetOwningPlayer(hbzy_z65)
if(IsUnitAlly(hbzy_z65,hbzy_z05)or(hbzy_Z65==hbzy_z05))then
else
call hbzy_Z4zZ(hbzy_z65)
endif
endif
endif
set hbzy_z7[hbzy_z15]=hbzy_z65
set hbzy_z65=null
set hbzy_z05=null
endfunction
function hbzy_Z89Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
set hbzy_z65=GetTriggerUnit()
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
call GroupRemoveUnit(hbzy_Z8Z[hbzy_z15],hbzy_z65)
endif
set hbzy_z65=null
set hbzy_z05=null
endfunction
function hbzy_Z9ZZ takes nothing returns nothing
local unit hbzy_z65=GetAttacker()
local unit hbzy_z76=GetTriggerUnit()
local player hbzy_z05=GetOwningPlayer(hbzy_z65)
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local player hbzy_Z65=GetOwningPlayer(hbzy_z76)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if((IsUnitInGroup(hbzy_z65,hbzy_z8Z))and((hbzy_Z65!=hbzy_z5)or(hbzy_z05==hbzy_z5)or(hbzy_Z5Z==false))and((IsUnitType(hbzy_z76,UNIT_TYPE_STRUCTURE)==false)or(hbzy_ZZz==false)))then
call SetWidgetLife(hbzy_z76,1.)
call UnitDamageTargetBJ(hbzy_z65,hbzy_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z65=null
set hbzy_z76=null
endfunction
function hbzy_Z9zZ takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
local location hbzy_z95
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15])and(hbzy_Z1Z[hbzy_z15])and(hbzy_Z2Z[hbzy_z15])and(GetIssuedOrderId()==851971))then
set hbzy_z65=GetTriggerUnit()
set hbzy_z95=GetOrderPointLoc()
call SetUnitPositionLoc(hbzy_z65,hbzy_z95)
call RemoveLocation(hbzy_z95)
endif
set hbzy_z65=null
set hbzy_z05=null
set hbzy_z95=null
endfunction
function hbzy_Z90Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15])and(hbzy_Z1Z[hbzy_z15])and(hbzy_Z2Z[hbzy_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),hbzy_z05)+1),hbzy_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set hbzy_z05=null
endfunction
function hbzy_Z91Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
local unit hbzy_z65
local unit hbzy_z76
local location hbzy_z95
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if((hbzy_z4)and(hbzy_z6[hbzy_z15])and(hbzy_Z1Z[hbzy_z15])and(hbzy_Z2Z[hbzy_z15]))then
set hbzy_z65=GetTriggerUnit()
set hbzy_z95=GetUnitRallyPoint(hbzy_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),hbzy_z05,hbzy_z95,bj_UNIT_FACING)
set hbzy_z76=bj_lastCreatedUnit
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_z76,false)
endif
call IssueImmediateOrderById(hbzy_z65,851976)
if(IsUnitType(hbzy_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[hbzy_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(hbzy_z76,1937012592)
set bj_meleeTwinkedHeroes[hbzy_z15]=bj_meleeTwinkedHeroes[hbzy_z15]+1
endif
endif
call RemoveLocation(hbzy_z95)
set hbzy_z95=null
set hbzy_z05=null
set hbzy_z76=null
set hbzy_z65=null
endif
endfunction
function hbzy_Z92Z takes nothing returns nothing
local unit hbzy_z65=GetAttacker()
local unit hbzy_z76=GetEnumUnit()
local player hbzy_z05=GetOwningPlayer(hbzy_z65)
local player hbzy_Z65=GetOwningPlayer(hbzy_z76)
if(IsUnitAlly(hbzy_z65,hbzy_z05)or(hbzy_Z65==hbzy_z05))then
else
call UnitDamageTargetBJ(hbzy_z65,hbzy_z76,(hbzy_z3*hbzy_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z65=null
set hbzy_z76=null
endfunction
function hbzy_Z93Z takes nothing returns nothing
local unit hbzy_z65=GetAttacker()
local unit hbzy_z76=GetTriggerUnit()
local player hbzy_z05=GetOwningPlayer(hbzy_z65)
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local player hbzy_Z65=GetOwningPlayer(hbzy_z76)
local group hbzy_z46
local location hbzy_z95
if(hbzy_Z53[hbzy_z15])then
call UnitDamageTargetBJ(hbzy_z65,hbzy_z76,hbzy_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(hbzy_Z63[hbzy_z15])then
set hbzy_z95=GetUnitLoc(hbzy_z76)
set hbzy_z46=hbzy_Z64(100,hbzy_z95)
call ForGroup(hbzy_z46,function hbzy_Z92Z)
call DestroyGroup(hbzy_z46)
call RemoveLocation(hbzy_z95)
set hbzy_z46=null
set hbzy_z95=null
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z65=null
set hbzy_z76=null
endfunction
function hbzy_Z94Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call IssueImmediateOrderById(hbzy_z65,hbzy_Z7z)
set hbzy_z65=null
endfunction
function hbzy_Z95Z takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_z66
local player hbzy_z05
local unit hbzy_z65
local group hbzy_z46
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_z66=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_z15])and(hbzy_zzZ[hbzy_z15])and(hbzy_z31[hbzy_z15]))then
set hbzy_z1z=false
set hbzy_z65=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_z65,UNIT_TYPE_PEON)==false))then
call hbzy_z67(hbzy_z15,false)
set hbzy_Z7z=hbzy_z66
set hbzy_z46=hbzy_zz4(hbzy_z05,GetUnitTypeId(hbzy_z65))
call ForGroup(hbzy_z46,function hbzy_Z94Z)
call DestroyGroup(hbzy_z46)
set hbzy_z46=null
endif
call hbzy_z67(hbzy_z15,true)
set hbzy_z1z=true
set hbzy_z65=null
endif
endif
set hbzy_z05=null
endfunction
function hbzy_Z96Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call IssuePointOrderById(hbzy_z65,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
set hbzy_z65=null
endfunction
function hbzy_Z97Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call GroupAddUnit(hbzy_Z83,hbzy_z65)
set hbzy_Z93=hbzy_Z93+1
if(hbzy_Z93==12)then
call GroupPointOrderById(hbzy_Z83,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
set hbzy_Z93=0
call GroupClear(hbzy_Z83)
endif
set hbzy_z65=null
endfunction
function hbzy_Z98Z takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_z66
local player hbzy_z05
local unit hbzy_z65
local group hbzy_z46
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_z66=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_z15])and(hbzy_zzZ[hbzy_z15])and(hbzy_z31[hbzy_z15]))then
set hbzy_z1z=false
set hbzy_z65=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_z65,UNIT_TYPE_PEON)==false))then
call hbzy_z67(hbzy_z15,false)
set hbzy_Z7z=hbzy_z66
set hbzy_Z8z=GetOrderPointX()
set hbzy_Z9z=GetOrderPointY()
set hbzy_z46=hbzy_zz4(hbzy_z05,GetUnitTypeId(hbzy_z65))
if(hbzy_Z33[hbzy_z15])then
set hbzy_Z93=0
call GroupClear(hbzy_Z83)
call ForGroup(hbzy_z46,function hbzy_Z97Z)
if(hbzy_Z93==12)then
else
call GroupPointOrderById(hbzy_Z83,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
endif
else
call ForGroup(hbzy_z46,function hbzy_Z96Z)
endif
call DestroyGroup(hbzy_z46)
set hbzy_z46=null
endif
call hbzy_z67(hbzy_z15,true)
set hbzy_z1z=true
set hbzy_z65=null
endif
endif
set hbzy_z05=null
endfunction
function hbzy_Z99Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call IssueTargetOrderById(hbzy_z65,hbzy_Z7z,hbzy_zZz)
set hbzy_z65=null
endfunction
function hbzy_zZZZ takes nothing returns nothing
local integer hbzy_z15
local integer hbzy_z66
local player hbzy_z05
local unit hbzy_z65
local group hbzy_z46
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_z66=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_z15])and(hbzy_zzZ[hbzy_z15])and(hbzy_z31[hbzy_z15]))then
set hbzy_z1z=false
set hbzy_z65=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_z65,UNIT_TYPE_PEON)==false))then
call hbzy_z67(hbzy_z15,false)
set hbzy_Z7z=hbzy_z66
set hbzy_zZz=GetOrderTargetUnit()
if(hbzy_zZz==null)then
else
set hbzy_z46=hbzy_zz4(hbzy_z05,GetUnitTypeId(hbzy_z65))
call ForGroup(hbzy_z46,function hbzy_Z99Z)
call DestroyGroup(hbzy_z46)
set hbzy_z46=null
set hbzy_z65=null
endif
endif
call hbzy_z67(hbzy_z15,true)
set hbzy_z1z=true
set hbzy_z65=null
endif
endif
set hbzy_z05=null
endfunction
function hbzy_zZzZ takes unit hbzy_z65 returns nothing
local real hbzy_Z14Z
call UnitRemoveBuffs(hbzy_z65,false,true)
call UnitResetCooldown(hbzy_z65)
set hbzy_Z14Z=GetUnitLifePercent(hbzy_z65)
if(hbzy_Z14Z<hbzy_z2Z[0])then
call SetUnitLifePercentBJ(hbzy_z65,hbzy_z2Z[0])
else
if(hbzy_Z14Z<hbzy_z2Z[1])then
call SetUnitLifePercentBJ(hbzy_z65,hbzy_z2Z[1])
else
if(hbzy_Z14Z<hbzy_z2Z[2])then
call SetUnitLifePercentBJ(hbzy_z65,hbzy_z2Z[2])
else
call SetUnitLifePercentBJ(hbzy_z65,100.)
endif
endif
endif
set hbzy_Z14Z=GetUnitManaPercent(hbzy_z65)
if(hbzy_Z14Z<hbzy_z3Z[0])then
call SetUnitManaPercentBJ(hbzy_z65,hbzy_z3Z[0])
else
if(hbzy_Z14Z<hbzy_z3Z[1])then
call SetUnitManaPercentBJ(hbzy_z65,hbzy_z3Z[1])
else
if(hbzy_Z14Z<hbzy_z3Z[2])then
call SetUnitManaPercentBJ(hbzy_z65,hbzy_z3Z[2])
else
call SetUnitManaPercentBJ(hbzy_z65,100.)
endif
endif
endif
endfunction
function hbzy_zZ0Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_zZzZ(hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_zZ1Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if(hbzy_z4)then
if(hbzy_z6[hbzy_z15])then
if((hbzy_Z1Z[hbzy_z15])and(hbzy_Z2Z[hbzy_z15]))then
call hbzy_ZZ1Z(hbzy_z15,hbzy_z05)
else
if(hbzy_Z7[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_zZ0Z)
else
call hbzy_zZzZ(hbzy_z7[hbzy_z15])
endif
endif
endif
endif
endif
set hbzy_z05=null
endfunction
function hbzy_zZ2Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_Z1Z[hbzy_z15]=false
set hbzy_z05=null
call hbzy_z17(hbzy_z15,false)
endfunction
function hbzy_zZ3Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_Z2Z[hbzy_z15]=false
set hbzy_z05=null
call hbzy_z17(hbzy_z15,false)
endfunction
function hbzy_zZ4Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_zZZ[hbzy_z15]=false
call hbzy_z67(hbzy_z15,false)
set hbzy_z05=null
endfunction
function hbzy_zZ5Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_zzZ[hbzy_z15]=false
call hbzy_z67(hbzy_z15,false)
set hbzy_z05=null
endfunction
function hbzy_zZ6Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
set hbzy_Z8[hbzy_z15]=0
if(hbzy_z4)then
if(hbzy_z6[hbzy_z15])then
set hbzy_Z1Z[hbzy_z15]=true
if(hbzy_Z2Z[hbzy_z15])then
call hbzy_z17(hbzy_z15,true)
else
if(hbzy_Z7[hbzy_z15])then
if(hbzy_Z32[hbzy_z15]==3)then
set hbzy_Z7[hbzy_z15]=false
set hbzy_Z1Z[hbzy_z15]=false
set hbzy_Z32[hbzy_z15]=0
call hbzy_ZZzZ(hbzy_z15,hbzy_z05)
else
set hbzy_Z32[hbzy_z15]=hbzy_Z32[hbzy_z15]+1
endif
else
call hbzy_z88(hbzy_z15)
endif
endif
endif
else
if(hbzy_Z5[hbzy_z15]==0)then
set hbzy_Z5[hbzy_z15]=1
else
if(hbzy_Z5[hbzy_z15]==1)then
set hbzy_Z5[hbzy_z15]=2
else
set hbzy_Z5[hbzy_z15]=0
endif
endif
endif
set hbzy_z05=null
endfunction
function hbzy_zZ7Z takes unit hbzy_z65 returns nothing
call SetUnitLifePercentBJ(hbzy_z65,100)
call SetUnitManaPercentBJ(hbzy_z65,100)
endfunction
function hbzy_zZ8Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_zZ7Z(hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_zZ9Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if(hbzy_z4)then
set hbzy_Z2Z[hbzy_z15]=true
if(hbzy_Z1Z[hbzy_z15])then
call hbzy_z17(hbzy_z15,true)
else
if(hbzy_z6[hbzy_z15])then
if(hbzy_Z7[hbzy_z15])then
call hbzy_Zz3Z(hbzy_z15,1,hbzy_zz,true)
else
if((hbzy_zZZ[hbzy_z15])and(hbzy_zzZ[hbzy_z15]))then
call hbzy_Zz9Z(hbzy_z15,1,true)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_zZ8Z)
else
call hbzy_zZ7Z(hbzy_z7[hbzy_z15])
endif
endif
endif
endif
endif
else
if(hbzy_Z5[hbzy_z15]==3)then
if((hbzy_z0==false)or(hbzy_z15==hbzy_zz3))then
endif
else
set hbzy_Z5[hbzy_z15]=0
endif
endif
set hbzy_z05=null
endfunction
function hbzy_zzZZ takes unit hbzy_z65 returns nothing
call UnitSetConstructionProgress(hbzy_z65,100)
call UnitSetUpgradeProgress(hbzy_z65,100)
call UnitRemoveBuffs(hbzy_z65,false,true)
call UnitResetCooldown(hbzy_z65)
endfunction
function hbzy_zzzZ takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_zzZZ(hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_zz0Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if(hbzy_z4)then
if(hbzy_z6[hbzy_z15])then
set hbzy_zZZ[hbzy_z15]=true
if(hbzy_zzZ[hbzy_z15])then
call hbzy_z67(hbzy_z15,true)
else
if(hbzy_Z7[hbzy_z15])then
set hbzy_Z7[hbzy_z15]=false
call hbzy_Zz3Z(hbzy_z15,0,hbzy_zz,true)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_zzzZ)
else
call hbzy_zzZZ(hbzy_z7[hbzy_z15])
endif
endif
endif
endif
else
if(hbzy_Z5[hbzy_z15]==2)then
set hbzy_Z5[hbzy_z15]=3
else
set hbzy_Z5[hbzy_z15]=0
endif
endif
set hbzy_z05=null
endfunction
function hbzy_zz1Z takes unit hbzy_z65 returns nothing
call ModifyHeroStat(0,hbzy_z65,0,hbzy_zz)
call ModifyHeroStat(1,hbzy_z65,0,hbzy_zz)
call ModifyHeroStat(2,hbzy_z65,0,hbzy_zz)
endfunction
function hbzy_zz2Z takes nothing returns nothing
local unit hbzy_z65=GetEnumUnit()
call hbzy_zz1Z(hbzy_z65)
set hbzy_z65=null
endfunction
function hbzy_zz3Z takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
if(hbzy_z4)then
if(hbzy_z6[hbzy_z15])then
set hbzy_zzZ[hbzy_z15]=true
if(hbzy_zZZ[hbzy_z15])then
call hbzy_z67(hbzy_z15,true)
else
if(hbzy_Z7[hbzy_z15])then
set hbzy_Z7[hbzy_z15]=false
call hbzy_Zz3Z(hbzy_z15,2,hbzy_zz,true)
else
if((hbzy_Z1Z[hbzy_z15])and(hbzy_Z2Z[hbzy_z15]))then
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_z15],function hbzy_zz2Z)
else
call hbzy_zz1Z(hbzy_z7[hbzy_z15])
endif
else
call hbzy_zz5(hbzy_z05,hbzy_zZ,true)
call hbzy_z35(hbzy_z05,hbzy_Zz,true)
endif
endif
endif
endif
else
set hbzy_Z5[hbzy_z15]=0
endif
set hbzy_z05=null
endfunction
function hbzy_zz4Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z59Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
call hbzy_Z5ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z52Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
set hbzy_z13=false
call DoNotSaveReplay()
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_zz5Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_ZZzZ(hbzy_z15,hbzy_z05)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Zz1Z(hbzy_z05)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call SetPlayerStateBJ(hbzy_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
if(GetPlayerHandicapBJ(hbzy_z05)==200.)then
call SetPlayerHandicapBJ(hbzy_z05,100)
else
call SetPlayerHandicapBJ(hbzy_z05,200.)
endif
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
if(GetPlayerHandicapXPBJ(hbzy_z05)==200.)then
call SetPlayerHandicapXPBJ(hbzy_z05,100)
else
call SetPlayerHandicapXPBJ(hbzy_z05,200.)
endif
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_zz5(hbzy_z05,hbzy_Z2,true)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_z35(hbzy_z05,hbzy_z2,true)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call hbzy_zz5(hbzy_z05,hbzy_Z2,false)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_z35(hbzy_z05,hbzy_z2,false)
call hbzy_Z55Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_zz6Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z96(hbzy_z40[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z96(hbzy_z50[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z96(hbzy_z60[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z96(hbzy_z80[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z96(hbzy_z70[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
call hbzy_Z96(hbzy_z90[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z96(hbzy_ZZ3[hbzy_z15])
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_z16(hbzy_z15,true)
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call hbzy_z16(hbzy_z15,false)
call hbzy_Z46Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_zz7Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z24Z(hbzy_z15,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1097886070,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z26Z(hbzy_z15,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1094937907,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1098150517,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
call hbzy_Z29Z(hbzy_z15,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if((hbzy_z78==hbzy_Zz0[hbzy_z15])and((hbzy_z9Z)or(hbzy_z05==hbzy_z5)))then
call hbzy_Z3ZZ(hbzy_z15,true)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z34Z(hbzy_z15)
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_zz8Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095659625,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095066998,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095262824,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095721842,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1096119411,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095656289,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095657827,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095332722,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1094935923,true)
call hbzy_Z48Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_zz9Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095262562,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095065960,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095721317,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095065970,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1096114549,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1096114550,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1095262564,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1094934883,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1097818482,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z21Z(hbzy_z15,1096905580,true)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z31Z(hbzy_z15,false)
call hbzy_Z49Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z0ZZ takes nothing returns nothing
local integer hbzy_Z75=0
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z05==hbzy_z5)and(hbzy_z6[hbzy_z15]))then
loop
exitwhen hbzy_Z75>11
if(hbzy_z78==hbzy_ZzZ[hbzy_Z75])then
if(hbzy_z6[hbzy_Z75])then
call hbzy_z47(hbzy_Z75)
else
call hbzy_z57(hbzy_Z75,Player(hbzy_Z75))
endif
call hbzy_Z5ZZ(hbzy_z15,hbzy_z05)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z0zZ takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local integer hbzy_Z75=0
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z05==hbzy_z5)and(hbzy_z6[hbzy_z15]))then
loop
exitwhen hbzy_Z75>12
if(hbzy_z78==hbzy_ZzZ[hbzy_Z75])then
set hbzy_Z5z=hbzy_Z75
call hbzy_Z53Z(hbzy_z15,hbzy_z05)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z00Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local player hbzy_Z65
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z05==hbzy_z5)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z57Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
set hbzy_Z65=Player(hbzy_Z5z)
if(GetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_GOLD,hbzy_z22)
else
call SetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set hbzy_Z65=null
call hbzy_Z53Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
set hbzy_Z65=Player(hbzy_Z5z)
if(GetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER,hbzy_z22)
else
call SetPlayerTaxRate(hbzy_Z65,hbzy_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set hbzy_Z65=null
call hbzy_Z53Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z52Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z01Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local integer hbzy_Z75=hbzy_Z5z
local player hbzy_Z65=Player(hbzy_Z75)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_ZZzZ(hbzy_Z75,hbzy_Z65)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Zz1Z(hbzy_Z65)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call SetPlayerStateBJ(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call SetPlayerStateBJ(hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
if(GetPlayerHandicapBJ(hbzy_Z65)==200.)then
call SetPlayerHandicapBJ(hbzy_Z65,100)
else
call SetPlayerHandicapBJ(hbzy_Z65,200.)
endif
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
if(GetPlayerHandicapXPBJ(hbzy_Z65)==200.)then
call SetPlayerHandicapXPBJ(hbzy_Z65,100)
else
call SetPlayerHandicapXPBJ(hbzy_Z65,200.)
endif
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_zz5(hbzy_Z65,hbzy_Z2,true)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
call hbzy_z35(hbzy_Z65,hbzy_z2,true)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call hbzy_zz5(hbzy_Z65,hbzy_Z2,false)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_z35(hbzy_Z65,hbzy_z2,false)
call hbzy_Z56Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z53Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z78=null
endfunction
function hbzy_z02Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local integer hbzy_Z75=hbzy_Z5z
local player hbzy_Z65=Player(hbzy_Z75)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
if(IsPlayerAlly(hbzy_Z65,hbzy_z05))then
call SetPlayerAllianceStateBJ(hbzy_Z65,hbzy_z05,0)
else
call SetPlayerAllianceStateBJ(hbzy_Z65,hbzy_z05,3)
endif
call hbzy_Z57Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
if(GetPlayerAlliance(hbzy_Z65,hbzy_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,hbzy_z5)
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_CONTROL,false,hbzy_z5)
else
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,hbzy_z5)
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_CONTROL,true,hbzy_z5)
endif
call hbzy_Z57Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
if(GetPlayerAlliance(hbzy_Z65,hbzy_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_XP,false,hbzy_z5)
else
call SetPlayerAllianceBJ(hbzy_Z65,ALLIANCE_SHARED_XP,true,hbzy_z5)
endif
call hbzy_Z57Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
if(IsPlayerAlly(hbzy_z05,hbzy_Z65))then
call SetPlayerAllianceStateBJ(hbzy_z5,hbzy_Z65,0)
else
call SetPlayerAllianceStateBJ(hbzy_z5,hbzy_Z65,2)
endif
call hbzy_Z57Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z53Z(hbzy_z15,hbzy_z05)
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z78=null
endfunction
function hbzy_z03Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local integer hbzy_Z75
local unit hbzy_z65=hbzy_z7[hbzy_z15]
local player hbzy_Z65=GetOwningPlayer(hbzy_z65)
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if(hbzy_z4)and(hbzy_z6[hbzy_z15])then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call SetHeroLevelBJ(hbzy_z65,GetHeroLevel(hbzy_z65)+hbzy_Z0Z,false)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call ModifyHeroStat(1,hbzy_z65,0,hbzy_Z3)
call ModifyHeroStat(0,hbzy_z65,0,hbzy_Z3)
call ModifyHeroStat(2,hbzy_z65,0,hbzy_Z3)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_z98(hbzy_z15,false)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z77(hbzy_z65,hbzy_z05,1)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_ZZ3Z(hbzy_z65)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
if(hbzy_Z5Z)then
if(hbzy_Z65!=hbzy_z5)then
call UnitShareVisionBJ(true,hbzy_z65,hbzy_z05)
endif
else
call UnitShareVisionBJ(true,hbzy_z65,hbzy_z05)
endif
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
call hbzy_Z47Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
if(hbzy_Z5Z)then
if(hbzy_Z65!=hbzy_z5)then
call SetUnitOwner(hbzy_z65,hbzy_z05,true)
endif
else
call SetUnitOwner(hbzy_z65,hbzy_z05,true)
endif
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
call RemoveUnit(hbzy_z65)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z54Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z65=null
set hbzy_z78=null
endfunction
function hbzy_z04Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z05==hbzy_z5)and(hbzy_z6[hbzy_z15]))then
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
set hbzy_Z0=not(hbzy_Z0)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z58Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
set hbzy_Z5Z=not(hbzy_Z5Z)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
set hbzy_Z6Z=not(hbzy_Z6Z)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
set hbzy_Z7Z=not(hbzy_Z7Z)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
set hbzy_z9Z=not(hbzy_z9Z)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z7z[hbzy_z15])then
set hbzy_ZZz=not(hbzy_ZZz)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z6z[hbzy_z15])then
set hbzy_z7Z=not(hbzy_z7Z)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Zz0[hbzy_z15])then
set hbzy_Z52=not(hbzy_Z52)
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_ZZ0[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z05Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
set hbzy_z61=1
call hbzy_Z58Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
set hbzy_z61=2
call hbzy_Z58Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
set hbzy_z61=3
call hbzy_Z58Z(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z51Z(hbzy_z15,hbzy_z05)
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z06Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
local integer hbzy_Z75=0
local player hbzy_Z65
local unit hbzy_z65=hbzy_z7[hbzy_z15]
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if((hbzy_z4)and(hbzy_z05==hbzy_z5)and(hbzy_z6[hbzy_z15]))then
loop
exitwhen hbzy_Z75>12
if(hbzy_z78==hbzy_ZzZ[hbzy_Z75])then
set hbzy_Z65=Player(hbzy_Z75)
call SetUnitOwner(hbzy_z7[hbzy_z15],hbzy_Z65,true)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z50Z(hbzy_z15,hbzy_z05)
endif
endif
set hbzy_z05=null
set hbzy_Z65=null
set hbzy_z78=null
set hbzy_z65=null
endfunction
function hbzy_z07Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_z36(hbzy_z05)
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
set hbzy_z31[hbzy_z15]=not(hbzy_z31[hbzy_z15])
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
set hbzy_Z33[hbzy_z15]=not(hbzy_Z33[hbzy_z15])
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z38(hbzy_z15,not(hbzy_Z53[hbzy_z15]))
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
set hbzy_Z63[hbzy_z15]=not(hbzy_Z63[hbzy_z15])
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_z8z[hbzy_z15])then
set hbzy_Z43[hbzy_z15]=not(hbzy_Z43[hbzy_z15])
call hbzy_Z6ZZ(hbzy_z15,hbzy_z05)
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hbzy_z08Z takes nothing returns nothing
local player hbzy_z05=GetTriggerPlayer()
local integer hbzy_z15=GetPlayerId(hbzy_z05)
local button hbzy_z78=GetClickedButton()
call hbzy_Z44Z(hbzy_z15,hbzy_z05,false)
if(hbzy_z78==hbzy_z2z[hbzy_z15])then
call hbzy_Z6zZ(hbzy_z05)
endif
if(hbzy_z78==hbzy_z4z[hbzy_z15])then
call hbzy_Z60Z(hbzy_z05)
endif
if(hbzy_z78==hbzy_z5z[hbzy_z15])then
call hbzy_Z61Z(hbzy_z05)
endif
if(hbzy_z78==hbzy_z3z[hbzy_z15])then
call hbzy_Z62Z(hbzy_z05)
endif
if(hbzy_z78==hbzy_z9z[hbzy_z15])then
call hbzy_Z64Z()
endif
if(hbzy_z78==hbzy_Z00[hbzy_z15])then
call hbzy_Z45Z(hbzy_z15,hbzy_z05)
endif
set hbzy_z05=null
set hbzy_z78=null
endfunction
function hBzy takes nothing returns nothing
set hbzy_Yj=CreateTrigger()
set hbzy_yJ=0
loop
exitwhen hbzy_yJ>11
call TriggerRegisterPlayerChatEvent(hbzy_Yj,Player(hbzy_yJ),"112233",true)
set hbzy_yJ=hbzy_yJ+1
endloop
call TriggerAddAction(hbzy_Yj,function hBzY)
endfunction
function hbzy_z09Z takes nothing returns nothing
local integer hbzy_Z75
local player hbzy_Z65
local player hbzy_z05
set hbzy_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(hbzy_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z73,function hbzy_Z9ZZ)
call TriggerAddCondition(hbzy_z43,Condition(function hbzy_Z73Z))
set hbzy_Z75=0
loop
exitwhen hbzy_Z75>11
set hbzy_zz1[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_zz1[hbzy_Z75],function hbzy_Z79Z)
call DisableTrigger(hbzy_zz1[hbzy_Z75])
set hbzy_Z30[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z30[hbzy_Z75],function hbzy_Z88Z)
call DisableTrigger(hbzy_Z30[hbzy_Z75])
set hbzy_Z50[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z50[hbzy_Z75],function hbzy_Z89Z)
call DisableTrigger(hbzy_Z50[hbzy_Z75])
set hbzy_Z40[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z40[hbzy_Z75],function hbzy_Z91Z)
call DisableTrigger(hbzy_Z40[hbzy_Z75])
set hbzy_Z60[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z60[hbzy_Z75],function hbzy_Z90Z)
call DisableTrigger(hbzy_Z60[hbzy_Z75])
set hbzy_Z6z[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z6z[hbzy_Z75],function hbzy_Z9zZ)
call DisableTrigger(hbzy_Z6z[hbzy_Z75])
set hbzy_Z70[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z70[hbzy_Z75],function hbzy_zZ1Z)
call DisableTrigger(hbzy_Z70[hbzy_Z75])
set hbzy_Z80[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z80[hbzy_Z75],function hbzy_zZ2Z)
call DisableTrigger(hbzy_Z80[hbzy_Z75])
set hbzy_Z90[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z90[hbzy_Z75],function hbzy_zZ3Z)
call DisableTrigger(hbzy_Z90[hbzy_Z75])
set hbzy_zZ0[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_zZ0[hbzy_Z75],function hbzy_zZ4Z)
call DisableTrigger(hbzy_zZ0[hbzy_Z75])
set hbzy_zz0[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_zz0[hbzy_Z75],function hbzy_zZ5Z)
call DisableTrigger(hbzy_zz0[hbzy_Z75])
set hbzy_z00[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z00[hbzy_Z75],function hbzy_zZ6Z)
set hbzy_z10[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z10[hbzy_Z75],function hbzy_zZ9Z)
set hbzy_z20[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z20[hbzy_Z75],function hbzy_zz0Z)
set hbzy_z30[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z30[hbzy_Z75],function hbzy_zz3Z)
set hbzy_z40[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z40[hbzy_Z75],function hbzy_Z81Z)
call DisableTrigger(hbzy_z40[hbzy_Z75])
set hbzy_z50[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z50[hbzy_Z75],function hbzy_Z82Z)
call DisableTrigger(hbzy_z50[hbzy_Z75])
set hbzy_z60[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z60[hbzy_Z75],function hbzy_Z83Z)
call DisableTrigger(hbzy_z60[hbzy_Z75])
set hbzy_z70[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z70[hbzy_Z75],function hbzy_Z84Z)
call DisableTrigger(hbzy_z70[hbzy_Z75])
set hbzy_z80[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z80[hbzy_Z75],function hbzy_Z85Z)
call DisableTrigger(hbzy_z80[hbzy_Z75])
set hbzy_z90[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z90[hbzy_Z75],function hbzy_Z86Z)
call DisableTrigger(hbzy_z90[hbzy_Z75])
set hbzy_ZZ3[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_ZZ3[hbzy_Z75],function hbzy_Z87Z)
call DisableTrigger(hbzy_ZZ3[hbzy_Z75])
set hbzy_ZZ1[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_ZZ1[hbzy_Z75],function hbzy_zz4Z)
set hbzy_Zz2[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Zz2[hbzy_Z75],function hbzy_zz5Z)
set hbzy_Zz1[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Zz1[hbzy_Z75],function hbzy_zz6Z)
set hbzy_Z01[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z01[hbzy_Z75],function hbzy_zz7Z)
set hbzy_Z81[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z81[hbzy_Z75],function hbzy_zz8Z)
set hbzy_Z21[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z21[hbzy_Z75],function hbzy_zz9Z)
set hbzy_Z51[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z51[hbzy_Z75],function hbzy_z0ZZ)
set hbzy_Z41[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z41[hbzy_Z75],function hbzy_z0zZ)
set hbzy_Z61[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z61[hbzy_Z75],function hbzy_z00Z)
set hbzy_Z12[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z12[hbzy_Z75],function hbzy_z02Z)
set hbzy_Z02[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z02[hbzy_Z75],function hbzy_z01Z)
set hbzy_Z71[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z71[hbzy_Z75],function hbzy_z03Z)
set hbzy_Z31[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z31[hbzy_Z75],function hbzy_z04Z)
set hbzy_Z22[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z22[hbzy_Z75],function hbzy_z05Z)
set hbzy_Z11[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z11[hbzy_Z75],function hbzy_z06Z)
set hbzy_Z23[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z23[hbzy_Z75],function hbzy_z08Z)
set hbzy_Z13[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_Z13[hbzy_Z75],function hbzy_z07Z)
call DisableTrigger(hbzy_ZZ1[hbzy_Z75])
call DisableTrigger(hbzy_Zz1[hbzy_Z75])
call DisableTrigger(hbzy_Zz2[hbzy_Z75])
call DisableTrigger(hbzy_Z01[hbzy_Z75])
call DisableTrigger(hbzy_Z81[hbzy_Z75])
call DisableTrigger(hbzy_Z21[hbzy_Z75])
call DisableTrigger(hbzy_Z51[hbzy_Z75])
call DisableTrigger(hbzy_Z41[hbzy_Z75])
call DisableTrigger(hbzy_Z61[hbzy_Z75])
call DisableTrigger(hbzy_Z12[hbzy_Z75])
call DisableTrigger(hbzy_Z02[hbzy_Z75])
call DisableTrigger(hbzy_Z71[hbzy_Z75])
call DisableTrigger(hbzy_Z31[hbzy_Z75])
call DisableTrigger(hbzy_Z22[hbzy_Z75])
call DisableTrigger(hbzy_Z11[hbzy_Z75])
call DisableTrigger(hbzy_Z23[hbzy_Z75])
call DisableTrigger(hbzy_Z13[hbzy_Z75])
set hbzy_z01[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z01[hbzy_Z75],function hbzy_Z95Z)
set hbzy_z11[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z11[hbzy_Z75],function hbzy_Z98Z)
set hbzy_z21[hbzy_Z75]=CreateTrigger()
call TriggerAddAction(hbzy_z21[hbzy_Z75],function hbzy_zZZZ)
call DisableTrigger(hbzy_z01[hbzy_Z75])
call DisableTrigger(hbzy_z11[hbzy_Z75])
call DisableTrigger(hbzy_z21[hbzy_Z75])
set hbzy_Z65=Player(hbzy_Z75)
if((GetPlayerController(hbzy_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(hbzy_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set hbzy_Z8Z[hbzy_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(hbzy_z63,hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(hbzy_z10[hbzy_Z75],hbzy_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(hbzy_z00[hbzy_Z75],hbzy_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(hbzy_z20[hbzy_Z75],hbzy_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(hbzy_z30[hbzy_Z75],hbzy_Z65,0,1)
call TriggerRegisterPlayerChatEvent(hbzy_z53,hbzy_Z65,SubStringBJ(hbzy_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(hbzy_z63,hbzy_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set hbzy_Z9Z[hbzy_Z75]=GetPlayerStartLocationLoc(hbzy_Z65)
endif
set hbzy_Z75=hbzy_Z75+1
endloop
call DisableTrigger(hbzy_z73)
set hbzy_z8Z=CreateGroup()
set hbzy_z8=GetWorldBounds()
set hbzy_z2Z[0]=30.
set hbzy_z2Z[1]=60.
set hbzy_z2Z[2]=90.
set hbzy_z3Z[0]=50.
set hbzy_z3Z[1]=72.
set hbzy_z3Z[2]=95.
set hbzy_Z75=0
loop
exitwhen hbzy_Z75>20
set hbzy_z02[hbzy_Z75]=null
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z75=0
loop
exitwhen(hbzy_Z75>12)
set hbzy_Z5[hbzy_Z75]=0
set hbzy_z6[hbzy_Z75]=false
set hbzy_Z7[hbzy_Z75]=false
set hbzy_Z8[hbzy_Z75]=0
set hbzy_Z1Z[hbzy_Z75]=false
set hbzy_Z2Z[hbzy_Z75]=false
set hbzy_Z3Z[hbzy_Z75]=CreateTimer()
set hbzy_Z8Z[hbzy_Z75]=CreateGroup()
set hbzy_zZZ[hbzy_Z75]=false
set hbzy_zzZ[hbzy_Z75]=false
set hbzy_z0Z[hbzy_Z75]=CreateTimer()
set hbzy_z1Z[hbzy_Z75]=false
set hbzy_Z3z[hbzy_Z75]=false
set hbzy_Z4z[hbzy_Z75]=0
set hbzy_Z20[hbzy_Z75]=DialogCreate()
set hbzy_Z91[hbzy_Z75]=DialogCreate()
set hbzy_zZ1[hbzy_Z75]=DialogCreate()
set hbzy_z31[hbzy_Z75]=false
set hbzy_Z32[hbzy_Z75]=0
set hbzy_Z42[hbzy_Z75]=false
set hbzy_Zz3[hbzy_Z75]=DialogCreate()
set hbzy_Z33[hbzy_Z75]=false
set hbzy_Z43[hbzy_Z75]=true
set hbzy_Z53[hbzy_Z75]=false
set hbzy_Z63[hbzy_Z75]=false
set hbzy_Z73[hbzy_Z75]=CreateTimer()
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z75=0
loop
exitwhen(hbzy_Z75>3)
set hbzy_Z75=hbzy_Z75+1
endloop
set hbzy_Z75=0
loop
exitwhen(hbzy_Z75>21)
set hbzy_z12[hbzy_Z75]=false
set hbzy_Z75=hbzy_Z75+1
endloop
call TriggerRegisterTimerEvent(hbzy_z23,.01,false)
call TriggerAddAction(hbzy_z23,function hbzy_Z7zZ)
call TriggerAddAction(hbzy_z33,function hbzy_Z70Z)
call TriggerAddAction(hbzy_z43,function hbzy_Z74Z)
call TriggerAddAction(hbzy_z53,function hbzy_Z8zZ)
call TriggerAddAction(hbzy_z63,function hbzy_Z80Z)
call TriggerRegisterAnyUnitEventBJ(hbzy_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z73,function hbzy_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(hbzy_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z83,function hbzy_Z93Z)
call DisableTrigger(hbzy_z83)
call hbzy_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set hbzy_Z65=null
call hBzy()
endfunction
