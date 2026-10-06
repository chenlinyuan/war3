function SYR_Z64 takes real SYR_Z74,location SYR_Z84 returns group
set SYR_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(SYR_Z14,SYR_Z84,SYR_Z74,SYR_Z34)
return SYR_Z14
endfunction
function SYR_Z94 takes player SYR_zZ4 returns group
set SYR_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(SYR_Z14,SYR_zZ4,SYR_Z34)
return SYR_Z14
endfunction
function SYR_zz4 takes player SYR_zZ4,integer SYR_z04 returns group
set SYR_Z14=CreateGroup()
set bj_groupEnumTypeId=SYR_z04
call GroupEnumUnitsOfPlayer(SYR_Z14,SYR_zZ4,filterGetUnitsOfPlayerAndTypeId)
return SYR_Z14
endfunction
function SYR_z14 takes player SYR_zZ4 returns force
set SYR_Z24=CreateForce()
call ForceEnumAllies(SYR_Z24,SYR_zZ4,SYR_Z34)
return SYR_Z24
endfunction
function SYR_z24 takes player SYR_zZ4 returns force
set SYR_Z24=CreateForce()
call ForceEnumEnemies(SYR_Z24,SYR_zZ4,SYR_Z34)
return SYR_Z24
endfunction
function SYR_Z45 takes trigger SYR_Z55,player SYR_Z65,integer SYR_Z75 returns nothing
local playerevent SYR_Z85=ConvertPlayerEvent(SYR_Z75)
call TriggerRegisterPlayerEvent(SYR_Z55,SYR_Z65,SYR_Z85)
set SYR_Z85=null
endfunction
function SYR_Z95 takes trigger SYR_Z55,player SYR_Z65,integer SYR_Z75 returns nothing
local playerunitevent SYR_Z85=ConvertPlayerUnitEvent(SYR_Z75)
call TriggerRegisterPlayerUnitEvent(SYR_Z55,SYR_Z65,SYR_Z85,null)
set SYR_Z85=null
endfunction
function SYR_zZ5 takes integer SYR_Z75,player SYR_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(SYR_Z30[SYR_Z75],SYR_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(SYR_Z50[SYR_Z75],SYR_Z65,ConvertPlayerUnitEvent(25),null)
call SYR_Z45(SYR_Z70[SYR_Z75],SYR_Z65,17)
call SYR_Z45(SYR_Z90[SYR_Z75],SYR_Z65,266)
call SYR_Z45(SYR_Z80[SYR_Z75],SYR_Z65,268)
call SYR_Z45(SYR_zZ0[SYR_Z75],SYR_Z65,262)
call SYR_Z45(SYR_zz0[SYR_Z75],SYR_Z65,264)
call TriggerRegisterTimerExpireEvent(SYR_z43,SYR_z0Z[SYR_Z75])
call TriggerRegisterTimerExpireEvent(SYR_z33,SYR_Z73[SYR_Z75])
call SYR_Z95(SYR_Z40[SYR_Z75],SYR_Z65,32)
call SYR_Z95(SYR_Z60[SYR_Z75],SYR_Z65,35)
call TriggerRegisterDialogEvent(SYR_ZZ1[SYR_Z75],SYR_zZ1[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Zz2[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Zz1[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z01[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z81[SYR_Z75],SYR_Z91[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z71[SYR_Z75],SYR_zZ1[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z21[SYR_Z75],SYR_Z91[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z31[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z22[SYR_Z75],SYR_Z91[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z11[SYR_Z75],SYR_Z91[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z51[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z41[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z61[SYR_Z75],SYR_Z91[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z12[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z02[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z23[SYR_Z75],SYR_Z20[SYR_Z75])
call TriggerRegisterDialogEvent(SYR_Z13[SYR_Z75],SYR_Z20[SYR_Z75])
call SYR_Z95(SYR_z01[SYR_Z75],SYR_Z65,38)
call SYR_Z95(SYR_z11[SYR_Z75],SYR_Z65,39)
call SYR_Z95(SYR_z21[SYR_Z75],SYR_Z65,40)
call SYR_Z95(SYR_z80[SYR_Z75],SYR_Z65,276)
call SYR_Z95(SYR_z80[SYR_Z75],SYR_Z65,275)
call SYR_Z95(SYR_z90[SYR_Z75],SYR_Z65,276)
call SYR_Z95(SYR_z90[SYR_Z75],SYR_Z65,275)
call SYR_Z95(SYR_ZZ3[SYR_Z75],SYR_Z65,18)
call TriggerRegisterPlayerStateEvent(SYR_z60[SYR_Z75],SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(SYR_z40[SYR_Z75],SYR_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(SYR_z50[SYR_Z75],SYR_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call SYR_Z95(SYR_z70[SYR_Z75],SYR_Z65,20)
call TriggerRegisterPlayerChatEvent(SYR_zz1[SYR_Z75],SYR_Z65,"-",false)
call SYR_Z95(SYR_Z6z[SYR_Z75],SYR_Z65,39)
set SYR_Z3z[SYR_Z75]=true
endfunction
function SYR_zz5 takes player SYR_z05,integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_z25)then
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_GOLD)+SYR_z15)
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(SYR_z05,PLAYER_STATE_GOLD_GATHERED)-SYR_z15)
else
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_GOLD)-SYR_z15)
endif
endfunction
function SYR_z35 takes player SYR_z05,integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_z25)then
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)+SYR_z15)
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(SYR_z05,PLAYER_STATE_LUMBER_GATHERED)-SYR_z15)
else
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)-SYR_z15)
endif
endfunction
function SYR_z45 takes player SYR_z05 returns nothing
local player SYR_Z65=GetLocalPlayer()
if SYR_z05==SYR_Z65 then
set SYR_Z65=Player(-1)
endif
set SYR_Z65=null
endfunction
function SYR_z55 takes unit SYR_z65,unit SYR_z75,boolean SYR_z85 returns nothing
local location SYR_z95
local location SYR_ZZ6
set SYR_z95=GetUnitLoc(SYR_z65)
set SYR_ZZ6=GetUnitLoc(SYR_z75)
call SetUnitPositionLoc(SYR_z65,SYR_ZZ6)
if(SYR_z85)then
call SetUnitPositionLoc(SYR_z75,SYR_z95)
call SetUnitPositionLoc(SYR_z65,SYR_ZZ6)
endif
call RemoveLocation(SYR_z95)
call RemoveLocation(SYR_ZZ6)
set SYR_z95=null
set SYR_ZZ6=null
endfunction
function SYR_Zz6 takes integer SYR_Z06 returns nothing
if(SYR_Z06==0)then
set SYR_zZ2=100
set SYR_Z92=100
set SYR_Z82=100
set SYR_Z72="|cFFFFFFFF"
return
endif
if(SYR_Z06==1)then
set SYR_zZ2=50
set SYR_Z92=50
set SYR_Z82=50
set SYR_Z72="|cFF7F7F7F"
return
endif
if(SYR_Z06==2)then
set SYR_zZ2=0
set SYR_Z92=0
set SYR_Z82=0
set SYR_Z72="|cFF000000"
return
endif
if(SYR_Z06==3)then
set SYR_zZ2=100
set SYR_Z92=0
set SYR_Z82=0
set SYR_Z72="|cFFFF0000"
return
endif
if(SYR_Z06==4)then
set SYR_zZ2=100
set SYR_Z92=50
set SYR_Z82=0
set SYR_Z72="|cFFFF7F00"
return
endif
if(SYR_Z06==5)then
set SYR_zZ2=100
set SYR_Z92=100
set SYR_Z82=0
set SYR_Z72="|cFFFFFF00"
return
endif
if(SYR_Z06==6)then
set SYR_zZ2=0
set SYR_Z92=100
set SYR_Z82=0
set SYR_Z72="|cFF00FF00"
return
endif
if(SYR_Z06==7)then
set SYR_zZ2=0
set SYR_Z92=100
set SYR_Z82=100
set SYR_Z72="|cFF00FFFF"
return
endif
if(SYR_Z06==8)then
set SYR_zZ2=0
set SYR_Z92=0
set SYR_Z82=100
set SYR_Z72="|cFF0000FF"
return
endif
if(SYR_Z06==9)then
set SYR_zZ2=100
set SYR_Z92=0
set SYR_Z82=100
set SYR_Z72="|cFFFF00FF"
return
endif
endfunction
function SYR_Z16 takes integer SYR_Z06,unit SYR_Z26,string SYR_Z36 returns nothing
local texttag SYR_Z46
local location SYR_z95
call SYR_Zz6(SYR_Z06)
set SYR_z95=GetUnitLoc(SYR_Z26)
set SYR_Z46=CreateTextTagLocBJ(SYR_Z36,SYR_z95,0,20,SYR_zZ2,SYR_Z92,SYR_Z82,0)
call RemoveLocation(SYR_z95)
set SYR_z95=null
call SetTextTagPermanent(SYR_Z46,false)
call SetTextTagLifespan(SYR_Z46,SYR_Z1)
set SYR_Z46=null
endfunction
function SYR_Z56 takes nothing returns nothing
local trigger SYR_Z66=GetTriggeringTrigger()
local timer SYR_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(SYR_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(SYR_z52)
call DestroyTimerDialog(SYR_z82)
call DestroyTimer(SYR_Z76)
set SYR_Z66=null
set SYR_Z76=null
endfunction
function SYR_Z86 takes nothing returns nothing
local timer SYR_Z76
local trigger SYR_Z66
if(SYR_z62)then
else
set SYR_z52=GetGameSpeed()
set SYR_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set SYR_Z66=CreateTrigger()
set SYR_Z76=CreateTimer()
call StartTimerBJ(SYR_Z76,false,SYR_z42)
set SYR_z82=CreateTimerDialogBJ(SYR_Z76,"子弹时间")
call TriggerAddAction(SYR_Z66,function SYR_Z56)
call TriggerRegisterTimerExpireEvent(SYR_Z66,SYR_Z76)
endif
endfunction
function SYR_Z96 takes trigger SYR_zZ6 returns nothing
if(IsTriggerEnabled(SYR_zZ6))then
call DisableTrigger(SYR_zZ6)
else
call EnableTrigger(SYR_zZ6)
endif
endfunction
function SYR_zz6 takes trigger SYR_zZ6,boolean SYR_z06 returns nothing
if(IsTriggerEnabled(SYR_zZ6)==SYR_z06)then
else
call SYR_Z96(SYR_zZ6)
endif
endfunction
function SYR_z16 takes integer SYR_z15,boolean SYR_z25 returns nothing
call SYR_zz6(SYR_z40[SYR_z15],SYR_z25)
call SYR_zz6(SYR_z50[SYR_z15],SYR_z25)
call SYR_zz6(SYR_z60[SYR_z15],SYR_z25)
call SYR_zz6(SYR_z80[SYR_z15],SYR_z25)
call SYR_zz6(SYR_z70[SYR_z15],SYR_z25)
call SYR_zz6(SYR_z90[SYR_z15],SYR_z25)
call SYR_zz6(SYR_ZZ3[SYR_z15],SYR_z25)
endfunction
function SYR_z26 takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
if(GetUnitUserData(SYR_z65)==2176)then
call RemoveUnit(SYR_z65)
endif
set SYR_z65=null
endfunction
function SYR_z36 takes player SYR_z05 returns nothing
local group SYR_z46
if(SYR_Z42[GetPlayerId(SYR_z05)])then
set SYR_z46=SYR_Z94(SYR_z05)
call ForGroup(SYR_z46,function SYR_z26)
set SYR_Z42[GetPlayerId(SYR_z05)]=false
call DestroyGroup(SYR_z46)
set SYR_z46=null
endif
endfunction
function SYR_z56 takes unit SYR_z65,player SYR_z05 returns nothing
local location SYR_z95
local integer SYR_z66
local unit SYR_z76
local item SYR_z86
local integer SYR_Z75=0
if(IsUnitType(SYR_z65,UNIT_TYPE_HERO))then
set SYR_z95=GetUnitLoc(SYR_z65)
set SYR_z66=GetUnitTypeId(SYR_z65)
set SYR_z76=CreateUnitAtLoc(SYR_z05,SYR_z66,SYR_z95,bj_UNIT_FACING)
call SetUnitUserData(SYR_z76,2176)
set SYR_Z42[GetPlayerId(SYR_z05)]=true
if(SYR_Z6Z)then
call SetUnitUseFood(SYR_z76,false)
endif
call SetHeroLevelBJ(SYR_z76,GetHeroLevel(SYR_z65),false)
call SetHeroStat(SYR_z76,0,GetHeroStatBJ(0,SYR_z65,false))
call SetHeroStat(SYR_z76,1,GetHeroStatBJ(1,SYR_z65,false))
call SetHeroStat(SYR_z76,2,GetHeroStatBJ(2,SYR_z65,false))
loop
exitwhen SYR_Z75>5
set SYR_z86=UnitItemInSlot(SYR_z65,SYR_Z75)
call UnitAddItemById(SYR_z76,GetItemTypeId(SYR_z86))
set SYR_Z75=SYR_Z75+1
endloop
endif
call RemoveLocation(SYR_z95)
set SYR_z95=null
set SYR_z76=null
set SYR_z86=null
endfunction
function SYR_z96 takes integer SYR_ZZ7,player SYR_Zz7,location SYR_Z07,boolean SYR_Z17,boolean SYR_Z27 returns nothing
local unit SYR_z76
set SYR_z76=CreateUnitAtLoc(SYR_Zz7,SYR_ZZ7,SYR_Z07,bj_UNIT_FACING)
if(SYR_Z6Z)then
call SetUnitUseFood(SYR_z76,false)
endif
if(SYR_Z17)then
call SetUnitUserData(SYR_z76,2176)
endif
if(SYR_Z27)then
call UnitApplyTimedLife(SYR_z76,1112820806,90)
endif
set SYR_z76=null
endfunction
function SYR_Z37 takes integer SYR_ZZ7,player SYR_Zz7,location SYR_Z07 returns nothing
local unit SYR_z76
set SYR_z76=CreateUnitAtLoc(SYR_Zz7,SYR_ZZ7,SYR_Z07,bj_UNIT_FACING)
if(SYR_Z6Z)then
call SetUnitUseFood(SYR_z76,false)
set SYR_z76=null
endif
endfunction
function SYR_Z47 takes unit SYR_Z57,player SYR_Zz7,integer SYR_Z67,boolean SYR_Z27 returns nothing
local location SYR_z95
local integer SYR_z66
local integer SYR_Z75
set SYR_z95=GetUnitLoc(SYR_Z57)
set SYR_z66=GetUnitTypeId(SYR_Z57)
set SYR_Z75=1
loop
exitwhen SYR_Z75>SYR_Z67
call SYR_z96(SYR_z66,SYR_Zz7,SYR_z95,true,SYR_Z27)
set SYR_Z75=SYR_Z75+1
endloop
call RemoveLocation(SYR_z95)
set SYR_Z42[GetPlayerId(SYR_Zz7)]=true
set SYR_z95=null
endfunction
function SYR_Z77 takes unit SYR_Z57,player SYR_Zz7,integer SYR_Z67 returns nothing
call SYR_Z47(SYR_Z57,SYR_Zz7,SYR_Z67,false)
endfunction
function SYR_Z87 takes unit SYR_z65,integer SYR_z15,boolean SYR_Z97 returns nothing
local integer SYR_Z75
set SYR_Z75=GetResourceAmount(SYR_z65)
if(SYR_Z97)then
set SYR_Z75=SYR_Z75+SYR_z15
else
set SYR_Z75=SYR_Z75-SYR_z15
endif
if(SYR_Z75<0)then
if(SYR_Z97)then
set SYR_Z75=GetResourceAmount(SYR_z65)
else
set SYR_Z75=0
endif
endif
call SetResourceAmount(SYR_z65,SYR_Z75)
endfunction
function SYR_zZ7 takes integer SYR_z15,player SYR_z05,boolean SYR_zz7 returns nothing
if(SYR_zz7)then
call SetPlayerTechMaxAllowed(SYR_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(SYR_z05,1212502607,3)
endif
endfunction
function SYR_z07 takes integer SYR_z15,boolean SYR_z06 returns nothing
if(SYR_z06)then
call EnableTrigger(SYR_z00[SYR_z15])
call EnableTrigger(SYR_z10[SYR_z15])
call EnableTrigger(SYR_z20[SYR_z15])
call EnableTrigger(SYR_z30[SYR_z15])
call EnableTrigger(SYR_Z70[SYR_z15])
call EnableTrigger(SYR_Z80[SYR_z15])
call EnableTrigger(SYR_Z90[SYR_z15])
call EnableTrigger(SYR_zZ0[SYR_z15])
call EnableTrigger(SYR_zz0[SYR_z15])
else
call DisableTrigger(SYR_z00[SYR_z15])
call DisableTrigger(SYR_z10[SYR_z15])
call DisableTrigger(SYR_z20[SYR_z15])
call DisableTrigger(SYR_z30[SYR_z15])
call DisableTrigger(SYR_Z70[SYR_z15])
call DisableTrigger(SYR_Z80[SYR_z15])
call DisableTrigger(SYR_Z90[SYR_z15])
call DisableTrigger(SYR_zZ0[SYR_z15])
call DisableTrigger(SYR_zz0[SYR_z15])
endif
endfunction
function SYR_z17 takes integer SYR_z15,boolean SYR_z27 returns nothing
if(SYR_z27)then
call EnableTrigger(SYR_Z40[SYR_z15])
call EnableTrigger(SYR_Z60[SYR_z15])
call EnableTrigger(SYR_Z6z[SYR_z15])
else
call DisableTrigger(SYR_Z40[SYR_z15])
call DisableTrigger(SYR_Z60[SYR_z15])
call DisableTrigger(SYR_Z6z[SYR_z15])
endif
endfunction
function SYR_z37 takes nothing returns nothing
local integer SYR_z15
set SYR_z15=0
loop
exitwhen SYR_z15>11
call SYR_z07(SYR_z15,false)
set SYR_z15=SYR_z15+1
endloop
endfunction
function SYR_z47 takes integer SYR_z15 returns nothing
set SYR_z6[SYR_z15]=false
call GroupClear(SYR_Z8Z[SYR_z15])
if(SYR_Z7Z)then
call DestroyFogModifier(SYR_Z6[SYR_z15])
endif
call DisableTrigger(SYR_Z30[SYR_z15])
call DisableTrigger(SYR_Z50[SYR_z15])
call DisableTrigger(SYR_zz1[SYR_z15])
call DisableTrigger(SYR_z40[SYR_z15])
call DisableTrigger(SYR_z50[SYR_z15])
call DisableTrigger(SYR_z60[SYR_z15])
call DisableTrigger(SYR_z70[SYR_z15])
call DisableTrigger(SYR_z80[SYR_z15])
call DisableTrigger(SYR_z90[SYR_z15])
call DisableTrigger(SYR_ZZ3[SYR_z15])
call DisableTrigger(SYR_ZZ1[SYR_z15])
call DisableTrigger(SYR_Zz1[SYR_z15])
call DisableTrigger(SYR_Zz2[SYR_z15])
call DisableTrigger(SYR_Z01[SYR_z15])
call DisableTrigger(SYR_Z81[SYR_z15])
call DisableTrigger(SYR_Z21[SYR_z15])
call DisableTrigger(SYR_Z51[SYR_z15])
call DisableTrigger(SYR_Z41[SYR_z15])
call DisableTrigger(SYR_Z61[SYR_z15])
call DisableTrigger(SYR_Z12[SYR_z15])
call DisableTrigger(SYR_Z02[SYR_z15])
call DisableTrigger(SYR_Z71[SYR_z15])
call DisableTrigger(SYR_Z31[SYR_z15])
call DisableTrigger(SYR_Z22[SYR_z15])
call DisableTrigger(SYR_Z11[SYR_z15])
call DisableTrigger(SYR_Z23[SYR_z15])
call DisableTrigger(SYR_Z13[SYR_z15])
call DisableTrigger(SYR_zZ3[SYR_z15])
call DisableTrigger(SYR_Z40[SYR_z15])
call DisableTrigger(SYR_Z60[SYR_z15])
call DisableTrigger(SYR_Z6z[SYR_z15])
call SYR_z07(SYR_z15,false)
endfunction
function SYR_z57 takes integer SYR_z15,player SYR_z05 returns nothing
set SYR_z6[SYR_z15]=true
if(SYR_Z3z[SYR_z15])then
else
call SYR_zZ5(SYR_z15,SYR_z05)
endif
call EnableTrigger(SYR_Z30[SYR_z15])
call EnableTrigger(SYR_Z50[SYR_z15])
call EnableTrigger(SYR_zz1[SYR_z15])
call SYR_z07(SYR_z15,true)
endfunction
function SYR_z67 takes integer SYR_z15,boolean SYR_z77 returns nothing
if(SYR_z77)then
if((SYR_zZZ[SYR_z15])and(SYR_zzZ[SYR_z15])and(SYR_z31[SYR_z15]))then
call EnableTrigger(SYR_z01[SYR_z15])
call EnableTrigger(SYR_z11[SYR_z15])
call EnableTrigger(SYR_z21[SYR_z15])
endif
else
call DisableTrigger(SYR_z01[SYR_z15])
call DisableTrigger(SYR_z11[SYR_z15])
call DisableTrigger(SYR_z21[SYR_z15])
endif
endfunction
function SYR_z87 takes integer SYR_Z06 returns nothing
if(SYR_Z06==0)then
set SYR_zz2=0
return
endif
if(SYR_Z06==1)then
set SYR_zz2=10
return
endif
if(SYR_Z06==2)then
set SYR_zz2=15
return
endif
if(SYR_Z06==3)then
set SYR_zz2=20
return
endif
if(SYR_Z06==4)then
set SYR_zz2=40
return
endif
if(SYR_Z06==5)then
set SYR_zz2=50
return
endif
if(SYR_Z06==6)then
set SYR_zz2=70
return
endif
if(SYR_Z06==7)then
set SYR_zz2=80
return
endif
if(SYR_Z06==8)then
set SYR_zz2=90
return
endif
if(SYR_Z06==9)then
set SYR_zz2=100
return
endif
endfunction
function SYR_z97 takes unit SYR_z65,integer SYR_ZZ8,integer SYR_Zz8 returns nothing
call SYR_z87(SYR_Zz8)
call SYR_Zz6(SYR_ZZ8)
call SetUnitVertexColorBJ(SYR_z65,SYR_zZ2,SYR_Z92,SYR_Z82,SYR_zz2)
endfunction
function SYR_Z08 takes integer SYR_ZZ8,integer SYR_Zz8 returns nothing
call SYR_z87(SYR_Zz8)
call SYR_Zz6(SYR_ZZ8)
call SetWaterBaseColorBJ(SYR_zZ2,SYR_Z92,SYR_Z82,SYR_zz2)
endfunction
function SYR_Z18 takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call SYR_z97(SYR_z65,GetRandomInt(3,9),0)
set SYR_z65=null
endfunction
function SYR_Z28 takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call SYR_z97(SYR_z65,0,0)
set SYR_z65=null
endfunction
function SYR_Z38 takes integer SYR_z15,boolean SYR_z77 returns nothing
local integer SYR_Z75
local integer SYR_Z48
if(SYR_Z53[SYR_z15]==SYR_z77)then
else
set SYR_Z53[SYR_z15]=SYR_z77
if(SYR_z77)then
call EnableTrigger(SYR_z83)
else
set SYR_Z75=0
set SYR_Z48=0
loop
exitwhen SYR_Z75>11
if(SYR_Z53[SYR_Z75])then
set SYR_Z48=SYR_Z48+1
endif
set SYR_Z75=SYR_Z75+1
endloop
if(SYR_Z48==0)then
call DisableTrigger(SYR_z83)
endif
endif
endif
endfunction
function SYR_Z58 takes integer SYR_Z68 returns nothing
if(SYR_Z68==0)then
call SetSkyModel(null)
return
endif
if(SYR_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(SYR_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(SYR_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(SYR_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(SYR_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(SYR_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(SYR_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(SYR_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(SYR_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(SYR_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(SYR_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(SYR_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(SYR_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function SYR_Z78 takes integer SYR_Z88 returns integer
if(SYR_Z88==0)then
return 1380018290
endif
if(SYR_Z88==1)then
return 1380019314
endif
if(SYR_Z88==2)then
return 1296393331
endif
if(SYR_Z88==3)then
return 1178886760
endif
if(SYR_Z88==4)then
return 1178886764
endif
if(SYR_Z88==5)then
return 1178888040
endif
if(SYR_Z88==6)then
return 1178888044
endif
if(SYR_Z88==7)then
return 1178890856
endif
if(SYR_Z88==8)then
return 1178890860
endif
if(SYR_Z88==9)then
return 1178892136
endif
if(SYR_Z88==10)then
return 1178892140
endif
if(SYR_Z88==11)then
return 1380739186
endif
if(SYR_Z88==12)then
return 1380740210
endif
if(SYR_Z88==13)then
return 1397645939
endif
if(SYR_Z88==14)then
return 1397647475
endif
if(SYR_Z88==15)then
return 1397648499
endif
if(SYR_Z88==16)then
return 1464820599
endif
if(SYR_Z88==17)then
return 1464822903
endif
if(SYR_Z88==18)then
return 1280467297
endif
if(SYR_Z88==19)then
return 1280470369
endif
if(SYR_Z88==20)then
return 1464755063
endif
return 0
endfunction
function SYR_Z98 takes integer SYR_Z88,boolean SYR_z77 returns nothing
set SYR_Z88=SYR_Z88-1
if(SYR_z77)then
if(SYR_z12[SYR_Z88]==false)then
if(SYR_Z78(SYR_Z88)==0)then
else
set SYR_z02[SYR_Z88]=AddWeatherEffect(SYR_z8,SYR_Z78(SYR_Z88))
call EnableWeatherEffect(SYR_z02[SYR_Z88],true)
set SYR_z12[SYR_Z88]=true
endif
endif
else
if(SYR_z02[SYR_Z88]==null)then
else
call EnableWeatherEffect(SYR_z02[SYR_Z88],false)
call RemoveWeatherEffect(SYR_z02[SYR_Z88])
set SYR_z12[SYR_Z88]=false
set SYR_z02[SYR_Z88]=null
endif
endif
endfunction
function SYR_zZ8 takes nothing returns nothing
local integer SYR_z15=1
loop
exitwhen SYR_z15>21
call SYR_Z98(SYR_z15,false)
set SYR_z15=SYR_z15+1
endloop
endfunction
function SYR_zz8 takes integer SYR_z08 returns integer
if(SYR_z08==0)then
return 1280601204
endif
if(SYR_z08==1)then
return 1179939959
endif
if(SYR_z08==2)then
return 1465152631
endif
if(SYR_z08==3)then
return 1096053874
endif
if(SYR_z08==4)then
return 1096053859
endif
if(SYR_z08==5)then
return 1112831095
endif
if(SYR_z08==6)then
return 1263826039
endif
if(SYR_z08==7)then
return 1498707828
endif
if(SYR_z08==8)then
return 1498702708
endif
if(SYR_z08==9)then
return 1498703476
endif
if(SYR_z08==10)then
return 1498706804
endif
if(SYR_z08==11)then
return 1247044468
endif
if(SYR_z08==12)then
return 1247048823
endif
if(SYR_z08==13)then
return 1146385256
endif
if(SYR_z08==14)then
return 1129608306
endif
if(SYR_z08==15)then
return 1129608291
endif
if(SYR_z08==16)then
return 1230271607
endif
if(SYR_z08==17)then
return 1230271607
endif
if(SYR_z08==18)then
return 1314157667
endif
if(SYR_z08==19)then
return 1330934903
endif
if(SYR_z08==20)then
return 1515484279
endif
if(SYR_z08==21)then
return 1196716904
endif
if(SYR_z08==22)then
return 1448373364
endif
if(SYR_z08==23)then
return 1448373364
endif
return 0
endfunction
function SYR_z18 takes nothing returns integer
return SYR_zz8(GetRandomInt(0,23))
endfunction
function SYR_z28 takes unit SYR_z65,integer SYR_z38,integer SYR_z08,integer SYR_z48 returns nothing
local real SYR_z58
local real SYR_z68
local real SYR_z15=0
local boolean SYR_z78=true
set SYR_z58=GetUnitX(SYR_z65)
set SYR_z68=GetUnitY(SYR_z65)
if(SYR_z38==1)then
loop
exitwhen SYR_z15==SYR_z48
if(SYR_z78)then
call CreateDestructable(SYR_z08,SYR_z58,SYR_z68+SYR_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(SYR_z08,SYR_z58,SYR_z68-SYR_z15*40,GetRandomReal(0,360),1,0)
endif
set SYR_z78=not(SYR_z78)
set SYR_z15=SYR_z15+1
endloop
endif
if(SYR_z38==2)then
loop
exitwhen SYR_z15==SYR_z48
if(SYR_z78)then
call CreateDestructable(SYR_z08,SYR_z58+SYR_z15*40,SYR_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(SYR_z08,SYR_z58-SYR_z15*40,SYR_z68,GetRandomReal(0,360),1,0)
endif
set SYR_z78=not(SYR_z78)
set SYR_z15=SYR_z15+1
endloop
endif
if(SYR_z38==3)then
loop
exitwhen SYR_z15==SYR_z48
if(SYR_z78)then
call CreateDestructable(SYR_z08,SYR_z58+SYR_z15*40,SYR_z68+SYR_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(SYR_z08,SYR_z58-SYR_z15*40,SYR_z68-SYR_z15*40,GetRandomReal(0,360),1,0)
endif
set SYR_z78=not(SYR_z78)
set SYR_z15=SYR_z15+1
endloop
endif
if(SYR_z38==4)then
loop
exitwhen SYR_z15==SYR_z48
if(SYR_z78)then
call CreateDestructable(SYR_z08,SYR_z58+SYR_z15*40,SYR_z68-SYR_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(SYR_z08,SYR_z58-SYR_z15*40,SYR_z68+SYR_z15*40,GetRandomReal(0,360),1,0)
endif
set SYR_z78=not(SYR_z78)
set SYR_z15=SYR_z15+1
endloop
endif
endfunction
function SYR_z88 takes integer SYR_z15 returns nothing
set SYR_Z7[SYR_z15]=true
call StartTimerBJ(SYR_z0Z[SYR_z15],false,2.)
endfunction
function SYR_z98 takes integer SYR_z15,boolean SYR_ZZZZ returns nothing
local integer SYR_Z75
local integer SYR_z76
local item SYR_z86
local location SYR_z95
local unit SYR_z65
set SYR_z65=SYR_z7[SYR_z15]
set SYR_z76=1
loop
exitwhen SYR_z76>6
if(SYR_ZZZZ)then
set SYR_z95=GetUnitLoc(SYR_z51[SYR_z15])
else
set SYR_z95=GetUnitLoc(SYR_z65)
endif
set SYR_z86=UnitItemInSlotBJ(SYR_z65,SYR_z76)
if(GetItemCharges(SYR_z86)>0)then
set SYR_Z75=GetItemCharges(SYR_z86)
set SYR_z86=CreateItemLoc(GetItemTypeId(SYR_z86),SYR_z95)
call SetItemCharges(SYR_z86,SYR_Z75)
else
call CreateItemLoc(GetItemTypeId(SYR_z86),SYR_z95)
endif
call RemoveLocation(SYR_z95)
set SYR_z76=SYR_z76+1
endloop
set SYR_z65=null
set SYR_z95=null
set SYR_z86=null
endfunction
function SYR_ZZzZ takes integer SYR_z15,player SYR_z05 returns nothing
local integer SYR_Z75
local force SYR_ZZ0Z
local player SYR_Z65
if(SYR_z1Z[SYR_z15])then
call DestroyFogModifier(SYR_Z6[SYR_z15])
set SYR_z1Z[SYR_z15]=false
else
set SYR_ZZ0Z=CreateForce()
set SYR_Z75=0
loop
exitwhen SYR_Z75>11
set SYR_Z65=Player(SYR_Z75)
if(GetPlayerAlliance(SYR_z05,SYR_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(SYR_ZZ0Z,SYR_Z65)
call SetPlayerAlliance(SYR_z05,SYR_Z65,ALLIANCE_SHARED_VISION,false)
endif
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z6[SYR_z15]=CreateFogModifierRect(SYR_z05,FOG_OF_WAR_VISIBLE,SYR_z8,false,false)
call FogModifierStart(SYR_Z6[SYR_z15])
set SYR_z1Z[SYR_z15]=true
set SYR_Z75=0
loop
exitwhen SYR_Z75>11
set SYR_Z65=Player(SYR_Z75)
if(IsPlayerInForce(SYR_Z65,SYR_ZZ0Z))then
call SetPlayerAlliance(SYR_z05,SYR_Z65,ALLIANCE_SHARED_VISION,true)
endif
set SYR_Z75=SYR_Z75+1
endloop
call DestroyForce(SYR_ZZ0Z)
set SYR_ZZ0Z=null
set SYR_Z65=null
endif
endfunction
function SYR_ZZ1Z takes integer SYR_z15,player SYR_z05 returns nothing
local integer SYR_Z75
local unit SYR_z65
local item SYR_z86
local item array SYR_ZZ2Z
set SYR_z65=FirstOfGroup(SYR_Z8Z[SYR_z15])
if((SYR_z05==GetOwningPlayer(SYR_z65))and(UnitInventorySizeBJ(SYR_z65)>0))then
set SYR_Z75=1
loop
exitwhen SYR_Z75>6
set SYR_z86=UnitItemInSlotBJ(SYR_z65,SYR_Z75)
set SYR_ZZ2Z[(SYR_Z75-1)]=SYR_z86
call UnitRemoveItemSwapped(SYR_z86,SYR_z65)
call SetItemVisible(SYR_z86,false)
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z75=1
loop
exitwhen SYR_Z75>6
set SYR_z86=SYR_Z2z[(SYR_z15*18)+(SYR_Z4z[SYR_z15]*6)+(SYR_Z75-1)]
call UnitAddItem(SYR_z65,SYR_z86)
set SYR_Z2z[(SYR_z15*18)+(SYR_Z4z[SYR_z15]*6)+(SYR_Z75-1)]=SYR_ZZ2Z[(SYR_Z75-1)]
set SYR_ZZ2Z[(SYR_Z75-1)]=null
set SYR_Z75=SYR_Z75+1
endloop
if(SYR_Z4z[SYR_z15]==0)then
set SYR_Z4z[SYR_z15]=SYR_z61-1
else
set SYR_Z4z[SYR_z15]=(SYR_Z4z[SYR_z15]-1)
endif
set SYR_z86=null
endif
set SYR_z65=null
set SYR_z05=null
endfunction
function SYR_ZZ3Z takes unit SYR_z65 returns nothing
local integer SYR_Z75
local item SYR_z86
set SYR_Z75=1
loop
exitwhen SYR_Z75>6
set SYR_z86=UnitItemInSlotBJ(SYR_z65,SYR_Z75)
call UnitRemoveItemSwapped(SYR_z86,SYR_z65)
set SYR_Z75=SYR_Z75+1
endloop
set SYR_z86=null
endfunction
function SYR_ZZ4Z takes integer SYR_z15 returns nothing
local integer SYR_Z75
local item SYR_z86
local location SYR_z95
set SYR_z95=GetUnitLoc(SYR_z51[SYR_z15])
set SYR_Z75=1
loop
exitwhen SYR_Z75>6
set SYR_z86=UnitItemInSlotBJ(SYR_z7[SYR_z15],SYR_Z75)
call UnitRemoveItemSwapped(SYR_z86,SYR_z7[SYR_z15])
call SetItemPositionLoc(SYR_z86,SYR_z95)
set SYR_Z75=SYR_Z75+1
endloop
call RemoveLocation(SYR_z95)
set SYR_z86=null
set SYR_z95=null
endfunction
function SYR_ZZ5Z takes integer SYR_z15 returns nothing
local integer SYR_z76
local integer SYR_z78
local unit SYR_z65
local item SYR_Z66
local item SYR_ZZ6Z
set SYR_z65=FirstOfGroup(SYR_Z8Z[SYR_z15])
set SYR_z76=1
loop
exitwhen SYR_z76>5
set SYR_Z66=UnitItemInSlotBJ(SYR_z65,SYR_z76)
if(GetItemCharges(SYR_Z66)>0)then
set SYR_z78=SYR_z76+1
loop
exitwhen SYR_z78>6
set SYR_ZZ6Z=UnitItemInSlotBJ(SYR_z65,SYR_z78)
if(GetItemTypeId(SYR_Z66)==GetItemTypeId(SYR_ZZ6Z))then
call SetItemCharges(SYR_Z66,(GetItemCharges(SYR_Z66)+GetItemCharges(SYR_ZZ6Z)))
call RemoveItem(SYR_ZZ6Z)
endif
set SYR_z78=SYR_z78+1
endloop
endif
set SYR_z76=SYR_z76+1
endloop
set SYR_Z66=null
set SYR_ZZ6Z=null
set SYR_z65=null
endfunction
function SYR_ZZ7Z takes integer SYR_z15,integer SYR_Z75 returns nothing
local unit SYR_z65
local item SYR_z86
set SYR_z65=FirstOfGroup(SYR_Z8Z[SYR_z15])
set SYR_z86=UnitItemInSlotBJ(SYR_z65,1)
call SetItemCharges(SYR_z86,(GetItemCharges(SYR_z86)+SYR_Z75))
set SYR_z86=null
set SYR_z65=null
endfunction
function SYR_ZZ8Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call GroupAddUnit(SYR_z8Z,SYR_z65)
set SYR_z65=null
endfunction
function SYR_ZZ9Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call GroupRemoveUnit(SYR_z8Z,SYR_z65)
set SYR_z65=null
endfunction
function SYR_ZzZZ takes nothing returns nothing
local unit SYR_z65=GetTriggerUnit()
if((IsUnitDeadBJ(SYR_z65))and(IsUnitType(SYR_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(SYR_z8Z,SYR_z65)
endif
endfunction
function SYR_ZzzZ takes nothing returns nothing
call ForGroup(SYR_z8Z,function SYR_ZzZZ)
endfunction
function SYR_Zz0Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call ReviveHeroLoc(SYR_z65,SYR_Z9Z[SYR_Zzz],true)
call SetUnitManaPercentBJ(SYR_z65,100)
set SYR_z65=null
endfunction
function SYR_Zz1Z takes player SYR_z05 returns nothing
local group SYR_z46
set SYR_z46=SYR_Z94(SYR_z05)
set SYR_Zzz=GetPlayerId(SYR_z05)
call ForGroup(SYR_z46,function SYR_Zz0Z)
call DestroyGroup(SYR_z46)
set SYR_z46=null
endfunction
function SYR_Zz2Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call ModifyHeroStat(SYR_z81,SYR_z65,SYR_z91,SYR_z71)
set SYR_z65=null
endfunction
function SYR_Zz3Z takes integer SYR_z15,integer SYR_Zz4Z,integer SYR_Zz5Z,boolean SYR_z25 returns nothing
local integer SYR_Zz6Z
if(SYR_z25)then
set SYR_Zz6Z=0
else
set SYR_Zz6Z=1
endif
if(SYR_Z0)then
set SYR_z91=SYR_Zz6Z
set SYR_z81=SYR_Zz4Z
set SYR_z71=SYR_Zz5Z
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Zz2Z)
else
call ModifyHeroStat(SYR_Zz4Z,SYR_z7[SYR_z15],SYR_Zz6Z,SYR_Zz5Z)
endif
endfunction
function SYR_Zz7Z takes unit SYR_z65,integer SYR_Zz5Z,boolean SYR_z25 returns nothing
local integer SYR_z15
set SYR_z15=GetHeroLevel(SYR_z65)
if(SYR_z25)then
set SYR_z15=SYR_z15+SYR_Zz5Z
else
set SYR_z15=SYR_z15-SYR_Zz5Z
endif
call SetHeroLevelBJ(SYR_z65,SYR_z15,false)
endfunction
function SYR_Zz8Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_Zz7Z(SYR_z65,SYR_ZZ2,SYR_Z1z)
set SYR_z65=null
endfunction
function SYR_Zz9Z takes integer SYR_z15,integer SYR_Zz5Z,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_ZZ2=SYR_Zz5Z
set SYR_Z1z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Zz8Z)
else
call SYR_Zz7Z(SYR_z7[SYR_z15],SYR_Zz5Z,SYR_z25)
endif
endfunction
function SYR_Z0ZZ takes string SYR_Z0zZ returns integer
local string SYR_Z00Z="0123456789"
local string SYR_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string SYR_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer SYR_Id=0
local integer SYR_Z03Z=1
local integer SYR_Z04Z=1
loop
exitwhen SYR_Z03Z>StringLength(SYR_Z0zZ)
loop
exitwhen SYR_Z04Z>10
if SubString(SYR_Z0zZ,SYR_Z03Z-1,SYR_Z03Z)==SubString(SYR_Z00Z,SYR_Z04Z-1,SYR_Z04Z)then
set SYR_Id=SYR_Id+R2I((48+SYR_Z04Z-1)*Pow(256.,I2R(StringLength(SYR_Z0zZ)-SYR_Z03Z)))
set SYR_Z04Z=SYR_Z04Z+1
else
set SYR_Z04Z=SYR_Z04Z+1
endif
endloop
set SYR_Z04Z=1
loop
exitwhen SYR_Z04Z>26
if SubString(SYR_Z0zZ,SYR_Z03Z-1,SYR_Z03Z)==SubString(SYR_Z01Z,SYR_Z04Z-1,SYR_Z04Z)then
set SYR_Id=SYR_Id+R2I(I2R(65+SYR_Z04Z-1)*Pow(256.,I2R(StringLength(SYR_Z0zZ)-SYR_Z03Z)))
set SYR_Z04Z=SYR_Z04Z+1
else
set SYR_Z04Z=SYR_Z04Z+1
endif
endloop
set SYR_Z04Z=1
loop
exitwhen SYR_Z04Z>26
if SubString(SYR_Z0zZ,SYR_Z03Z-1,SYR_Z03Z)==SubString(SYR_Z02Z,SYR_Z04Z-1,SYR_Z04Z)then
set SYR_Id=SYR_Id+R2I((97+SYR_Z04Z-1)*Pow(256.,I2R(StringLength(SYR_Z0zZ)-SYR_Z03Z)))
set SYR_Z04Z=SYR_Z04Z+1
else
set SYR_Z04Z=SYR_Z04Z+1
endif
endloop
set SYR_Z04Z=1
set SYR_Z03Z=SYR_Z03Z+1
endloop
return SYR_Id
endfunction
function SYR_Z05Z takes integer SYR_Z06Z returns string
local string SYR_Z00Z="0123456789"
local string SYR_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string SYR_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string SYR_Z07Z=""
local integer SYR_Z03Z=0
local integer SYR_Z08Z=0
loop
exitwhen SYR_Z06Z==0
set SYR_Z03Z=ModuloInteger(SYR_Z06Z,256)
if SYR_Z03Z>=48 and SYR_Z03Z<=57 then
set SYR_Z08Z=SYR_Z03Z-48
set SYR_Z07Z=SubString(SYR_Z00Z,SYR_Z08Z,SYR_Z08Z+1)+SYR_Z07Z
endif
if SYR_Z03Z>=65 and SYR_Z03Z<=90 then
set SYR_Z08Z=SYR_Z03Z-65
set SYR_Z07Z=SubString(SYR_Z01Z,SYR_Z08Z,SYR_Z08Z+1)+SYR_Z07Z
endif
if SYR_Z03Z>=97 and SYR_Z03Z<=122 then
set SYR_Z08Z=SYR_Z03Z-97
set SYR_Z07Z=SubString(SYR_Z02Z,SYR_Z08Z,SYR_Z08Z+1)+SYR_Z07Z
endif
set SYR_Z06Z=SYR_Z06Z/256
endloop
return SYR_Z07Z
endfunction
function SYR_Z09Z takes unit SYR_z65 returns string
local integer SYR_z15
set SYR_z15=GetUnitTypeId(SYR_z65)
if(SYR_z15==0)then
return""
else
return SYR_Z05Z(SYR_z15)
endif
endfunction
function SYR_Z1ZZ takes unit SYR_z65 returns string
local item SYR_z86=UnitItemInSlotBJ(SYR_z65,1)
local integer SYR_z15=GetItemTypeId(SYR_z86)
if(SYR_z15==0)then
return""
else
set SYR_z86=null
return SYR_Z05Z(SYR_z15)
endif
endfunction
function SYR_Z1zZ takes integer SYR_Z10Z returns integer
local string SYR_Z11Z=GetEventPlayerChatString()
if(StringLength(SYR_Z11Z)==SYR_Z10Z+3)then
return(SYR_Z0ZZ(SubStringBJ(SYR_Z11Z,SYR_Z10Z,SYR_Z10Z+3)))
else
return 0
endif
endfunction
function SYR_Z12Z takes unit SYR_z65,integer SYR_z66,boolean SYR_z25 returns nothing
local location SYR_z95
local integer SYR_z15
set SYR_z15=SYR_Z1zZ(SYR_z66)
if(SYR_z15==0)then
else
if(SYR_z25)then
set SYR_z95=GetUnitLoc(SYR_z65)
call CreateItemLoc(SYR_z15,SYR_z95)
call RemoveLocation(SYR_z95)
set SYR_z95=null
else
call UnitAddItemById(SYR_z65,SYR_z15)
endif
endif
endfunction
function SYR_Z13Z takes unit SYR_z65,real SYR_Z14Z,boolean SYR_z25 returns nothing
local location SYR_z95=GetUnitLoc(SYR_z65)
local player SYR_z05=GetOwningPlayer(SYR_z65)
call SetBlightRadiusLocBJ(SYR_z25,SYR_z05,SYR_z95,SYR_Z14Z)
call RemoveLocation(SYR_z95)
set SYR_z95=null
set SYR_z05=null
endfunction
function SYR_Z15Z takes unit SYR_z65,real SYR_Z14Z returns nothing
call SetUnitFlyHeight(SYR_z65,SYR_Z14Z,.0)
endfunction
function SYR_Z16Z takes nothing returns integer
local integer SYR_Z17Z=0
local integer SYR_Z18Z=0
local integer array SYR_Z19Z
local integer SYR_z15=0
local player SYR_z05=GetLocalPlayer()
loop
exitwhen SYR_z15>11
set SYR_Z19Z[SYR_z15]=0
set SYR_z15=SYR_z15+1
endloop
loop
exitwhen SYR_Z17Z>14
call StoreInteger(SYR_z03,"SYR_Player","SYR_number",GetPlayerId(SYR_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(SYR_z03,"SYR_Player","SYR_number")
call TriggerSyncReady()
set SYR_Z18Z=GetStoredInteger(SYR_z03,"SYR_Player","SYR_number")-1
set SYR_Z19Z[SYR_Z18Z]=SYR_Z19Z[SYR_Z18Z]+1
call FlushStoredMission(SYR_z03,"SYR_Player")
set SYR_Z17Z=SYR_Z17Z+1
endloop
set SYR_Z18Z=0
set SYR_Z17Z=0
set SYR_z05=null
loop
exitwhen SYR_Z17Z>11
if SYR_Z19Z[SYR_Z18Z]<SYR_Z19Z[SYR_Z17Z]then
set SYR_Z18Z=SYR_Z17Z
endif
set SYR_Z17Z=SYR_Z17Z+1
endloop
return SYR_Z18Z+1
endfunction
function SYR_Z2ZZ takes unit SYR_z65,integer SYR_Z2zZ,boolean SYR_z25 returns nothing
if(SYR_z25)then
call UnitAddAbility(SYR_z65,SYR_Z2zZ)
call SetUnitAbilityLevel(SYR_z65,SYR_Z2zZ,100)
call UnitMakeAbilityPermanent(SYR_z65,true,SYR_Z2zZ)
else
call UnitMakeAbilityPermanent(SYR_z65,false,SYR_Z2zZ)
call UnitRemoveAbility(SYR_z65,SYR_Z2zZ)
endif
endfunction
function SYR_Z20Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_Z2ZZ(SYR_z65,SYR_zzz,SYR_z0z)
set SYR_z65=null
endfunction
function SYR_Z21Z takes integer SYR_z15,integer SYR_Z2zZ,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_zzz=SYR_Z2zZ
set SYR_z0z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z20Z)
else
call SYR_Z2ZZ(SYR_z7[SYR_z15],SYR_Z2zZ,SYR_z25)
endif
endfunction
function SYR_Z22Z takes string SYR_Z11Z returns integer
if(SYR_Z11Z=="mm")then
return 1094937907
endif
if(SYR_Z11Z=="xj")then
return 1095659625
endif
if(SYR_Z11Z=="zj")then
return 1095262824
endif
if(SYR_Z11Z=="zm")then
return 1095721842
endif
if(SYR_Z11Z=="ft")then
return 1096119411
endif
if(SYR_Z11Z=="xx")then
return 1095333473
endif
if(SYR_Z11Z=="sb")then
return 1095066998
endif
if(SYR_Z11Z=="yx")then
return 1097886070
endif
if(SYR_Z11Z=="rh")then
return 1095657827
endif
if(SYR_Z11Z=="fl")then
return 1095656289
endif
if(SYR_Z11Z=="bs")then
return 1094935923
endif
if(SYR_Z11Z=="jg")then
return 1095332984
endif
if(SYR_Z11Z=="jf")then
return 1095328816
endif
if(SYR_Z11Z=="js")then
return 1095332728
endif
if(SYR_Z11Z=="jm")then
return 1095332722
endif
if(SYR_Z11Z=="jj")then
return 1095917932
endif
if(SYR_Z11Z=="fy")then
return 1098150517
endif
if(SYR_Z11Z=="ghh")then
return 1095262562
endif
if(SYR_Z11Z=="ghj")then
return 1095721317
endif
if(SYR_Z11Z=="gqj")then
return 1095065970
endif
if(SYR_Z11Z=="gxx")then
return 1096114550
endif
if(SYR_Z11Z=="gzz")then
return 1095262564
endif
if(SYR_Z11Z=="gxe")then
return 1096114549
endif
if(SYR_Z11Z=="gjj")then
return 1095065960
endif
if(SYR_Z11Z=="gml")then
return 1094934883
endif
if(SYR_Z11Z=="gyl")then
return 1097818482
endif
if(SYR_Z11Z=="gjs")then
return 1096905580
endif
if(SYR_Z11Z=="qhy")then
return 1095329378
endif
if(SYR_Z11Z=="qdy")then
return 1095331938
endif
if(SYR_Z11Z=="qlh")then
return 1095332719
endif
if(SYR_Z11Z=="qyz")then
return 1095328878
endif
if(SYR_Z11Z=="qbd")then
return 1095331682
endif
if(SYR_Z11Z=="qfs")then
return 1095328610
endif
if(SYR_Z11Z=="qsd")then
return 1095330924
endif
if(SYR_Z11Z=="qjs")then
return 1095332706
endif
if(SYR_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function SYR_Z23Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SetUnitInvulnerable(SYR_z65,SYR_z0z)
call SYR_Z2ZZ(SYR_z65,1098282348,SYR_z0z)
set SYR_z65=null
endfunction
function SYR_Z24Z takes integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_z0z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z23Z)
else
call SetUnitInvulnerable(SYR_z7[SYR_z15],SYR_z25)
call SYR_Z2ZZ(SYR_z7[SYR_z15],1098282348,SYR_z25)
endif
endfunction
function SYR_Z25Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SetUnitPathing(SYR_z65,not(SYR_z0z))
set SYR_z65=null
endfunction
function YJYJ takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
call SYR_z37()
set SYR_z4=true
set SYR_z5=SYR_z05
call SYR_z57(GetPlayerId(SYR_z05),SYR_z05)
endfunction
function SYR_Z26Z takes integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_z0z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z25Z)
else
call SetUnitPathing(SYR_z7[SYR_z15],not(SYR_z25))
endif
endfunction
function SYR_Z27Z takes unit SYR_z65,boolean SYR_z25 returns nothing
if(SYR_z25)then
call SetUnitMoveSpeed(SYR_z65,1000)
else
call SetUnitMoveSpeed(SYR_z65,GetUnitDefaultMoveSpeed(SYR_z65))
endif
endfunction
function SYR_Z28Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_Z27Z(SYR_z65,SYR_z0z)
set SYR_z65=null
endfunction
function SYR_Z29Z takes integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_z0z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z28Z)
else
call SYR_Z27Z(SYR_z7[SYR_z15],SYR_z25)
endif
endfunction
function SYR_Z3ZZ takes integer SYR_z15,boolean SYR_z25 returns nothing
call SYR_ZzzZ()
if(SYR_Z0)then
if(SYR_z25)then
if(CountUnitsInGroup(SYR_z8Z)==0)then
call EnableTrigger(SYR_z73)
endif
call GroupAddGroup(SYR_Z8Z[SYR_z15],SYR_z8Z)
else
call GroupRemoveGroup(SYR_Z8Z[SYR_z15],SYR_z8Z)
if(CountUnitsInGroup(SYR_z8Z)==0)then
call DisableTrigger(SYR_z73)
endif
endif
else
if(SYR_z25)then
if(CountUnitsInGroup(SYR_z8Z)==0)then
call EnableTrigger(SYR_z73)
endif
call GroupAddUnit(SYR_z8Z,SYR_z7[SYR_z15])
else
call GroupRemoveUnit(SYR_z8Z,SYR_z7[SYR_z15])
if(CountUnitsInGroup(SYR_z8Z)==0)then
call DisableTrigger(SYR_z73)
endif
endif
endif
endfunction
function SYR_Z3zZ takes unit SYR_z65,boolean SYR_z25 returns nothing
call SYR_Z2ZZ(SYR_z65,1095262562,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1095721317,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1095065970,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1096114550,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1095262564,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1096114549,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1094934883,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1095065960,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1097818482,SYR_z25)
call SYR_Z2ZZ(SYR_z65,1096905580,SYR_z25)
endfunction
function SYR_Z30Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_Z3zZ(SYR_z65,SYR_z0z)
set SYR_z65=null
endfunction
function SYR_Z31Z takes integer SYR_z15,boolean SYR_z25 returns nothing
if(SYR_Z0)then
set SYR_z0z=SYR_z25
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z30Z)
else
call SYR_Z3zZ(SYR_z7[SYR_z15],SYR_z25)
endif
endfunction
function SYR_Z32Z takes unit SYR_z65 returns nothing
call SYR_Z2ZZ(SYR_z65,1094937907,false)
call SYR_Z2ZZ(SYR_z65,1095659625,false)
call SYR_Z2ZZ(SYR_z65,1095262824,false)
call SYR_Z2ZZ(SYR_z65,1095721842,false)
call SYR_Z2ZZ(SYR_z65,1096119411,false)
call SYR_Z2ZZ(SYR_z65,1095333473,false)
call SYR_Z2ZZ(SYR_z65,1095066998,false)
call SYR_Z2ZZ(SYR_z65,1097886070,false)
call SYR_Z2ZZ(SYR_z65,1095657827,false)
call SYR_Z2ZZ(SYR_z65,1095656289,false)
call SYR_Z2ZZ(SYR_z65,1098282348,false)
call SYR_Z2ZZ(SYR_z65,1094935923,false)
call SYR_Z2ZZ(SYR_z65,1095332984,false)
call SYR_Z2ZZ(SYR_z65,1095328816,false)
call SYR_Z2ZZ(SYR_z65,1095332728,false)
call SYR_Z2ZZ(SYR_z65,1095332722,false)
call SYR_Z2ZZ(SYR_z65,1098150517,false)
call SetUnitInvulnerable(SYR_z65,false)
call SetUnitPathing(SYR_z65,true)
call SYR_Z27Z(SYR_z65,false)
call GroupRemoveUnit(SYR_z8Z,SYR_z65)
endfunction
function SYR_Z33Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_Z32Z(SYR_z65)
set SYR_z65=null
endfunction
function SYR_Z34Z takes integer SYR_z15 returns nothing
if(SYR_Z0)then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z33Z)
else
call SYR_Z32Z(SYR_z7[SYR_z15])
endif
endfunction
function SYR_Z35Z takes nothing returns nothing
local unit SYR_z65=GetTriggerUnit()
local trigger SYR_Z66=GetTriggeringTrigger()
call RemoveUnit(SYR_z65)
call DisableTrigger(SYR_Z66)
call DestroyTrigger(SYR_Z66)
set SYR_z65=null
set SYR_Z66=null
endfunction
function SYR_Z36Z takes integer SYR_z66,unit SYR_Z37Z,player SYR_Z38Z returns nothing
local location SYR_z95
local unit SYR_z65
local integer SYR_Z39Z=0
local integer SYR_Z4ZZ=0
local trigger SYR_Z66
if(SYR_z66==0)then
set SYR_Z39Z=1095726692
set SYR_Z4ZZ=852503
endif
if(SYR_z66==1)then
set SYR_Z39Z=1095070833
set SYR_Z4ZZ=852184
endif
if(SYR_z66==2)then
set SYR_Z39Z=1095070566
set SYR_Z4ZZ=852183
endif
if((SYR_Z39Z==0)and(SYR_Z4ZZ==0))then
return
endif
set SYR_z95=GetUnitLoc(SYR_Z37Z)
set SYR_z65=CreateUnitAtLoc(SYR_Z38Z,1851941228,SYR_z95,bj_UNIT_FACING)
call UnitAddAbility(SYR_z65,1098282348)
call UnitAddAbility(SYR_z65,SYR_Z39Z)
call ShowUnit(SYR_z65,false)
call SetUnitUseFood(SYR_z65,false)
call SetUnitScale(SYR_z65,.01,.01,.01)
call SetUnitState(SYR_z65,UNIT_STATE_MANA,GetUnitState(SYR_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(SYR_z65,SYR_Z4ZZ)
set SYR_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(SYR_Z66,SYR_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(SYR_Z66,SYR_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(SYR_Z66,function SYR_Z35Z)
call RemoveLocation(SYR_z95)
set SYR_z95=null
set SYR_Z66=null
set SYR_z65=null
endfunction
function SYR_Z4zZ takes unit SYR_Z37Z returns nothing
local player SYR_z05=GetTriggerPlayer()
local location SYR_z95=GetUnitLoc(SYR_Z37Z)
local trigger SYR_Z66=CreateTrigger()
local unit SYR_z65=CreateUnitAtLoc(SYR_z05,1751543663,SYR_z95,bj_UNIT_FACING)
call UnitAddAbility(SYR_z65,1098282348)
call UnitAddAbility(SYR_z65,1095332709)
call ShowUnit(SYR_z65,false)
call SetUnitUseFood(SYR_z65,false)
call SetUnitScale(SYR_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(SYR_z65,852592,SYR_z95)
call TriggerRegisterUnitEvent(SYR_Z66,SYR_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(SYR_Z66,SYR_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(SYR_Z66,function SYR_Z35Z)
call RemoveLocation(SYR_z95)
set SYR_z95=null
set SYR_Z66=null
set SYR_z05=null
endfunction
function SYR_Z40Z takes integer SYR_z15,dialog SYR_Z41Z,trigger SYR_zZ6 returns nothing
set SYR_Zz3[SYR_z15]=SYR_Z41Z
set SYR_Z03[SYR_z15]=SYR_zZ6
endfunction
function SYR_Z42Z takes integer SYR_z15,string SYR_Z43Z returns nothing
call DialogClear(SYR_Zz3[SYR_z15])
call DialogSetMessage(SYR_Zz3[SYR_z15],(SYR_Z43Z+SYR_Z0z+SYR_Z62))
endfunction
function SYR_Z44Z takes integer SYR_z15,player SYR_z05,boolean SYR_z77 returns nothing
if(SYR_z77)then
call EnableTrigger(SYR_Z03[SYR_z15])
call DialogDisplay(SYR_z05,SYR_Zz3[SYR_z15],true)
call TimerStart(SYR_Z73[SYR_z15],SYR_z1,false,null)
else
call DisableTrigger(SYR_Z03[SYR_z15])
call DialogDisplay(SYR_z05,SYR_Zz3[SYR_z15],false)
endif
endfunction
function SYR_Z45Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_zZ1[SYR_z15],SYR_ZZ1[SYR_z15])
call SYR_Z42Z(SYR_z15,"主")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"资源菜单[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"自动化设置[B]",66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"选定单位特殊属性[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"个人选项设置[D]",68)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"帮助菜单[E]",69)
if(SYR_z05==SYR_z5)then
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"其他玩家作弊管理[F]",70)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"其他玩家管理[G]",71)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"游戏作弊选项[H]",72)
if(SYR_z13)then
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z46Z takes integer SYR_z15,player SYR_z05 returns nothing
local string SYR_Z11Z
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Zz1[SYR_z15])
call SYR_Z42Z(SYR_z15,"自动化设置")
if(IsTriggerEnabled(SYR_z40[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(SYR_z50[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(SYR_z60[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(SYR_z80[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(SYR_z70[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(SYR_z90[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"魔法释放后自动MP"+I2S(R2I(SYR_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(SYR_ZZ3[SYR_z15]))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"生命低于"+I2S(R2I(SYR_z92))+"%加到"+I2S(R2I(SYR_z41))+"%[G]"),71)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"全部开启[O]",79)
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"全部关闭[U]",85)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z11Z=""
endfunction
function SYR_Z47Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z01[SYR_z15])
call SYR_Z42Z(SYR_z15,"选定单位特殊属性")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"无敌[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"永久隐形[B]",66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"穿越物体[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"魔免[D]",68)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"反隐形[E]",69)
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"移动速度[F]",70)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"各种光环[G]",71)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"换页[N]",78)
if((SYR_z9Z)or(SYR_z5==SYR_z05))then
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"秒杀模式[K]",75)
endif
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"取消全部(不含光环)[U]",85)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z48Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_Z91[SYR_z15],SYR_Z81[SYR_z15])
call SYR_Z42Z(SYR_z15,"选定单位特殊属性")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"永久献祭[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"闪避[B]",514)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"重击[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"致命一击[D]",68)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"反弹(小强的壳)[E]",69)
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"分裂攻击[F]",70)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"燃灰[G]",71)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"减少魔法伤害33%[H]",72)
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"闪避100%[I]",73)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"换页[N]",78)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z49Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_Z91[SYR_z15],SYR_Z21[SYR_z15])
call SYR_Z42Z(SYR_z15,"光环")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"辉煌光环[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"荆棘光环[B]",66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"耐久光环[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"强击光环[D]",68)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"邪恶光环[E]",69)
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"吸血光环[F]",70)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"专注光环[G]",71)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"命令光环(战鼓)[H]",72)
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"医疗光环[I]",73)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"减速光环[J]",74)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"关所有光环[K]",75)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z5ZZ takes integer SYR_z15,player SYR_z05 returns nothing
local integer SYR_Z75=0
local string SYR_Z11Z
local string SYR_Z5zZ
local player SYR_Z65
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z51[SYR_z15])
call SYR_Z42Z(SYR_z15,"玩家作弊管理")
loop
exitwhen SYR_Z75>11
set SYR_Z65=Player(SYR_Z75)
if((GetPlayerController(SYR_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(SYR_Z65)==PLAYER_SLOT_STATE_PLAYING)and(SYR_Z65!=SYR_z5))then
set SYR_Z5zZ=GetPlayerName(SYR_Z65)
if(SYR_z6[SYR_Z75])then
set SYR_Z11Z="禁止"
else
set SYR_Z11Z="允许"
endif
set SYR_ZzZ[SYR_Z75]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+SYR_Z5zZ+"作弊"),0)
endif
set SYR_Z75=SYR_Z75+1
endloop
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z65=null
set SYR_Z11Z=""
set SYR_Z5zZ=""
endfunction
function SYR_Z50Z takes integer SYR_z15,player SYR_z05 returns nothing
set SYR_Z8[SYR_z15]=0
call SYR_Z40Z(SYR_z15,SYR_zZ1[SYR_z15],SYR_Z71[SYR_z15])
call SYR_Z42Z(SYR_z15,"单位")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"升100级[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("加三围"+(I2S(SYR_Z3)+"[B]")),66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"复制物品[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"复制单位[D]",68)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"掉身上物品[E]",69)
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"共享该单位视野[F]",70)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"特殊属性菜单[G]",71)
if((SYR_z7Z)or(SYR_z5==SYR_z05))then
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"控制它[H]",72)
endif
if(SYR_z5==SYR_z05)then
endif
if(SYR_z05==SYR_z5)then
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"改变单位所有者[J]",74)
endif
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z51Z takes integer SYR_z15,player SYR_z05 returns nothing
local string SYR_Z11Z
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z31[SYR_z15])
call SYR_Z42Z(SYR_z15,"游戏作弊选项")
if(SYR_Z0)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"操作所有单位[A]"),65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("设置背包数[B]"),66)
if(SYR_Z5Z)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"保护CheatMaster[C]"),67)
if(SYR_Z6Z)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(SYR_Z7Z)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("取消作弊时"+SYR_Z11Z+"地图全开[E]"),69)
if(SYR_z9Z)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"他人秒杀模式[F]"),70)
if(SYR_ZZz)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"禁止秒杀建筑[G]"),71)
if(SYR_z7Z)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"他人占据单位[H]"),72)
if(SYR_Z52)then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"禁止克隆操作农民[I]"),73)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z11Z=""
endfunction
function SYR_Z52Z takes integer SYR_z15,player SYR_z05 returns nothing
local string SYR_Z5zZ
local integer SYR_Z75=0
local player SYR_Z65
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z41[SYR_z15])
call SYR_Z42Z(SYR_z15,"玩家管理")
loop
exitwhen SYR_Z75>11
set SYR_Z65=Player(SYR_Z75)
if(GetPlayerSlotState(SYR_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set SYR_Z5zZ=GetPlayerName(SYR_Z65)
set SYR_ZzZ[SYR_Z75]=DialogAddButton(SYR_Zz3[SYR_z15],("选择"+SYR_Z5zZ+"操作"),0)
endif
set SYR_Z75=SYR_Z75+1
endloop
set SYR_ZzZ[12]=DialogAddButton(SYR_Zz3[SYR_z15],("选择中立生物操作"),90)
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z5zZ=""
set SYR_Z65=null
endfunction
function SYR_Z53Z takes integer SYR_z15,player SYR_z05 returns nothing
local player SYR_Z65=Player(SYR_Z5z)
call SYR_Z40Z(SYR_z15,SYR_Z91[SYR_z15],SYR_Z61[SYR_z15])
call SYR_Z42Z(SYR_z15,"玩家管理")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"资源管理[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"向他收税黄金"+I2S(SYR_z22)+"%[C]",67)
else
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"向他收税木材"+I2S(SYR_z22)+"%[D]",68)
else
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"停止向他收木材[D]",67)
endif
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回选择菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z65=null
endfunction
function SYR_Z54Z takes integer SYR_z15,player SYR_z05 returns nothing
local integer SYR_Z75=0
local player SYR_Z65
local string SYR_Z11Z
local string SYR_Z5zZ
call SYR_Z40Z(SYR_z15,SYR_Z91[SYR_z15],SYR_Z11[SYR_z15])
call SYR_Z42Z(SYR_z15,"选定单位控制")
loop
exitwhen SYR_Z75>12
set SYR_Z65=Player(SYR_Z75)
if(GetPlayerSlotState(SYR_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set SYR_Z5zZ=GetPlayerName(SYR_Z65)
set SYR_ZzZ[SYR_Z75]=DialogAddButton(SYR_Zz3[SYR_z15],("给"+SYR_Z5zZ+"控制"),0)
endif
set SYR_Z75=SYR_Z75+1
endloop
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回单位菜单[R]",82)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z65=null
set SYR_Z11Z=""
set SYR_Z5zZ=""
endfunction
function SYR_Z55Z takes integer SYR_z15,player SYR_z05 returns nothing
local string SYR_Z11Z
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Zz2[SYR_z15])
call SYR_Z42Z(SYR_z15,"资源设置")
if(SYR_z1Z[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="打开"
endif
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"地图[A]"),65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("复活死亡英雄[B]"),66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"人口清5[B]",66)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"总人口100[C]",67)
if(GetPlayerHandicap(SYR_z05)==2)then
set SYR_Z11Z="恢复生命障碍100%"
else
set SYR_Z11Z="200%生命"
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(SYR_z05)==2)then
set SYR_Z11Z="恢复普通经验率"
else
set SYR_Z11Z="2倍经验"
endif
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"[E]",69)
set SYR_Z11Z=I2S(SYR_Z2)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("加"+SYR_Z11Z+"钱[F]"),70)
set SYR_Z11Z=I2S(SYR_z2)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("加"+SYR_Z11Z+"木[G]"),71)
set SYR_Z11Z=I2S(SYR_Z2)
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("减"+SYR_Z11Z+"钱[H]"),72)
set SYR_Z11Z=I2S(SYR_z2)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("减"+SYR_Z11Z+"木[I]"),73)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z11Z=""
endfunction
function SYR_Z56Z takes integer SYR_z15,player SYR_z05 returns nothing
local player SYR_Z65=Player(SYR_Z5z)
local string SYR_Z11Z
local string SYR_Z5zZ=GetPlayerName(SYR_Z65)
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z02[SYR_z15])
call DialogClear(SYR_Z20[SYR_z15])
call DialogSetMessage(SYR_Z20[SYR_z15],(SYR_Z5zZ+"钱"+I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(SYR_z1Z[SYR_Z5z])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="打开"
endif
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],(SYR_Z11Z+"地图[A]"),65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("复活死亡英雄[B]"),66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"人口清5[B]",66)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"总人口100[C]",67)
if(GetPlayerHandicap(SYR_Z65)==2)then
set SYR_Z11Z="恢复生命障碍100%"
else
set SYR_Z11Z="200%生命"
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(SYR_Z65)==2)then
set SYR_Z11Z="恢复普通经验率"
else
set SYR_Z11Z="2倍经验"
endif
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"[E]",69)
set SYR_Z11Z=I2S(SYR_Z2)
set SYR_z7z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("加"+SYR_Z11Z+"钱[F]"),70)
set SYR_Z11Z=I2S(SYR_z2)
set SYR_z6z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("加"+SYR_Z11Z+"木[G]"),71)
set SYR_Z11Z=I2S(SYR_Z2)
set SYR_Zz0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("减"+SYR_Z11Z+"钱[H]"),72)
set SYR_Z11Z=I2S(SYR_z2)
set SYR_ZZ0[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("减"+SYR_Z11Z+"木[I]"),73)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z11Z=""
set SYR_Z5zZ=""
set SYR_Z65=null
endfunction
function SYR_Z57Z takes integer SYR_z15,player SYR_z05 returns nothing
local player SYR_Z65=Player(SYR_Z5z)
local string SYR_Z11Z
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z12[SYR_z15])
call SYR_Z42Z(SYR_z15,"同盟管理")
if(IsPlayerAlly(SYR_Z65,SYR_z5))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("强制"+SYR_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(SYR_Z65,SYR_z5))then
if(GetPlayerAlliance(SYR_Z65,SYR_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("强制"+SYR_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(SYR_Z65,SYR_z5,ALLIANCE_SHARED_XP))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("强制"+SYR_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(SYR_z5,SYR_Z65))then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],("强制"+SYR_Z11Z+"对其同盟[D]"),68)
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回玩家菜单[R]",82)
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z65=null
set SYR_Z11Z=""
endfunction
function SYR_Z58Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_Z91[SYR_z15],SYR_Z22[SYR_z15])
call DialogClear(SYR_Z91[SYR_z15])
call DialogSetMessage(SYR_Z91[SYR_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(SYR_z61)+"|r个")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"设置1个背包[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"设置2个背包[B]",66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"设置3个背包[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回选设置单[R]",82)
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z59Z takes integer SYR_z15,player SYR_z05 returns nothing
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z23[SYR_z15])
call SYR_Z42Z(SYR_z15,"帮助")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"键盘帮助[A]",65)
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"CMD帮助[B]",66)
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"CMD单位类帮助[C]",67)
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"显示玩家信息[D]",68)
if(SYR_z05==SYR_z5)then
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"显示设置信息[E]",69)
endif
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
endfunction
function SYR_Z6ZZ takes integer SYR_z15,player SYR_z05 returns nothing
local string SYR_Z11Z
call SYR_Z40Z(SYR_z15,SYR_Z20[SYR_z15],SYR_Z13[SYR_z15])
call SYR_Z42Z(SYR_z15,"个人选项")
set SYR_z2z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"删除我的复制单位[A]",65)
if(SYR_z31[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z4z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"克隆操作[B]",66)
if(SYR_Z33[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z5z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"组队克隆操作[C]",67)
if(SYR_Z53[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z3z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"隐藏加攻[D]",68)
if(SYR_Z63[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z9z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"隐藏加攻带溅射[E]",69)
if(SYR_Z43[SYR_z15])then
set SYR_Z11Z="关闭"
else
set SYR_Z11Z="开启"
endif
set SYR_z8z[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],SYR_Z11Z+"远程沉默[F]",70)
set SYR_Z00[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"回主菜单[R]",82)
set SYR_Z10[SYR_z15]=DialogAddButton(SYR_Zz3[SYR_z15],"退出菜单[X]",88)
call SYR_Z44Z(SYR_z15,SYR_z05,true)
set SYR_Z11Z=""
endfunction
function SYR_Z6zZ takes player SYR_z05 returns nothing
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"欢迎使用|cFFFF8C00偶久作弊系列|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.ou99.com|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function SYR_Z60Z takes player SYR_z05 returns nothing
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"欢迎使用|cFFFF8C00偶久作弊系列|r 详细说明见|CFF00FF00www.ou99.com|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(SYR_z05==SYR_z5)then
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function SYR_Z61Z takes player SYR_z05 returns nothing
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"欢迎使用|cFFFF8C00偶久作弊系列|r 详细说明见|CFF00FF00www.ou99.com|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(SYR_z05==SYR_z5)then
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function SYR_Z62Z takes player SYR_z05 returns nothing
local integer SYR_Z75
local player SYR_Z65
local string SYR_Z11Z
local string SYR_Z63Z
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,"|CFFFF0000偶久作弊系列|R玩家信息系统 详细说明见|CFFFF0000www.ou99.com|R")
set SYR_Z75=1
loop
exitwhen SYR_Z75>12
set SYR_Z65=Player(SYR_Z75-1)
if(GetPlayerSlotState(SYR_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set SYR_Z63Z=I2S(SYR_Z75)
set SYR_Z11Z=(GetPlayerName(SYR_Z65)+":编号:"+SYR_Z63Z)
set SYR_Z63Z=I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_GOLD))
set SYR_Z11Z=(SYR_Z11Z+" |CFFFFFF00黄金:"+SYR_Z63Z+"|R")
set SYR_Z63Z=I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set SYR_Z11Z=(SYR_Z11Z+" |CFF008000木头:"+SYR_Z63Z+"|R")
set SYR_Z63Z=I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set SYR_Z11Z=(SYR_Z11Z+" 人口:"+SYR_Z63Z)
set SYR_Z63Z=I2S(GetPlayerState(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set SYR_Z11Z=(SYR_Z11Z+"/"+SYR_Z63Z)
set SYR_Z11Z=SYR_Z11Z+" 作弊:"
if(SYR_z6[SYR_Z75-1])then
set SYR_Z11Z=SYR_Z11Z+"|cFF00FF33√|r"
else
set SYR_Z11Z=SYR_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(SYR_Z65)==MAP_CONTROL_USER)then
set SYR_Z11Z=SYR_Z11Z+" (玩家)"
if(SYR_Z75-1==SYR_zz3)then
set SYR_Z11Z=SYR_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set SYR_Z11Z=SYR_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,SYR_Z11Z)
endif
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z65=null
set SYR_Z11Z=""
set SYR_Z63Z=""
endfunction
function SYR_Z64Z takes nothing returns nothing
local string SYR_Z65Z
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,"|CFFFF0000偶久作弊系列|R参数配置系统 详细说明见|CFFFF0000www.ou99.com|R")
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set SYR_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(SYR_z4Z)
set SYR_Z65Z=SYR_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(SYR_z5Z)
set SYR_Z65Z=SYR_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(SYR_z6Z)
set SYR_Z65Z=SYR_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(SYR_ZZZ))
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
set SYR_Z65Z=SYR_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(SYR_z41))
set SYR_Z65Z=SYR_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(SYR_z92))
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
set SYR_Z65Z=SYR_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(SYR_zZ)
set SYR_Z65Z=SYR_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(SYR_Zz)
set SYR_Z65Z=SYR_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(SYR_zz)
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
set SYR_Z65Z=SYR_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(SYR_Z2)
set SYR_Z65Z=SYR_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(SYR_z2)
set SYR_Z65Z=SYR_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(SYR_Z3)
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
set SYR_Z65Z=SYR_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(SYR_z61)
set SYR_Z65Z=SYR_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(SYR_Z1))
set SYR_Z65Z=SYR_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(SYR_z1))
set SYR_Z65Z=SYR_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(SYR_z42))
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
set SYR_Z65Z=SYR_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(SYR_z22)
set SYR_Z65Z=SYR_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(SYR_z3))
set SYR_Z65Z=SYR_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(SYR_Z4))
call DisplayTimedTextToPlayer(SYR_z5,0,0,SYR_Z1,SYR_Z65Z)
set SYR_Z65Z=""
endfunction
function SYR_Z66Z takes player SYR_z05,unit SYR_z65 returns nothing
local string SYR_Z11Z=SYR_Z09Z(SYR_z65)
set SYR_Z11Z="该单位的ID为|cFF33FF00"+SYR_Z11Z+"|r"
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,SYR_Z11Z)
set SYR_Z11Z=""
endfunction
function SYR_Z67Z takes player SYR_z05,unit SYR_z65 returns nothing
local string SYR_Z11Z=SYR_Z1ZZ(SYR_z65)
set SYR_Z11Z="该单位的第一格物品ID为|cFF33FF00"+SYR_Z11Z+"|r"
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,SYR_Z11Z)
set SYR_Z11Z=""
endfunction
function SYR_Z68Z takes integer SYR_z15 returns nothing
local unit SYR_z65=SYR_z7[SYR_z15]
local player SYR_z05=Player(SYR_z15)
local item SYR_z86
local integer SYR_Z75=0
local string SYR_Z11Z
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"hke Unit Debug Info:")
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"单位X坐标:"+R2S(GetUnitX(SYR_z65))+" 单位Y坐标:"+R2S(GetUnitY(SYR_z65)))
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,"单位ID:"+SYR_Z09Z(SYR_z65))
if(IsUnitType(SYR_z65,UNIT_TYPE_HERO))then
set SYR_Z11Z="单位物品ID:"
loop
exitwhen SYR_Z75>5
set SYR_z86=UnitItemInSlot(SYR_z65,SYR_Z75)
set SYR_Z11Z=SYR_Z11Z+SYR_Z05Z(GetItemTypeId(SYR_z86))+" "
set SYR_Z75=SYR_Z75+1
endloop
call DisplayTimedTextToPlayer(SYR_z05,0,0,SYR_Z1,SYR_Z11Z)
set SYR_Z11Z=""
set SYR_z86=null
endif
set SYR_z65=null
set SYR_z05=null
endfunction
function SYR_Z69Z takes nothing returns nothing
if(SYR_z0)then
set SYR_Z62="主机版"
else
set SYR_Z62="标准版"
endif
set SYR_Z62=SYR_Z62+"  (添加  By  |cFFFF0000"+SYR_ZZ+"|r)"
if(SYR_Z4Z=="")then
else
set SYR_Z62=SYR_Z62+"|n"+SYR_Z4Z
endif
endfunction
function SYR_Z7ZZ takes nothing returns nothing
local trigger SYR_Z66=GetTriggeringTrigger()
local timer SYR_Z76=GetExpiredTimer()
call DestroyTrigger(SYR_Z66)
call DestroyTimer(SYR_Z76)
set SYR_z0=false
set SYR_Z66=null
set SYR_Z76=null
endfunction
function SYR_Z7zZ takes nothing returns nothing
local timer SYR_Z76
local trigger SYR_Z66
set SYR_z03=InitGameCache("Ou99.Com")
set SYR_zz3=SYR_Z16Z()-1
if(SYR_z0)then
set SYR_Z76=CreateTimer()
set SYR_Z66=CreateTrigger()
call TriggerAddAction(SYR_Z66,function SYR_Z7ZZ)
call TriggerRegisterTimerExpireEvent(SYR_Z66,SYR_Z76)
call TimerStart(SYR_Z76,9.99,false,null)
set SYR_Z76=null
set SYR_Z66=null
endif
endfunction
function SYR_Z70Z takes nothing returns nothing
local integer SYR_z15=0
local timer SYR_Z76=GetExpiredTimer()
local player SYR_z05
loop
exitwhen SYR_z15>11
if(SYR_Z76==SYR_Z73[SYR_z15])then
set SYR_z05=Player(SYR_z15)
call SYR_Z44Z(SYR_z15,SYR_z05,false)
set SYR_z05=null
endif
set SYR_z15=SYR_z15+1
endloop
set SYR_Z76=null
endfunction
function SYR_Z71Z takes nothing returns nothing
local trigger SYR_Z66=GetTriggeringTrigger()
call TriggerExecute(SYR_Z66)
set SYR_Z66=null
endfunction
function SYR_Z72Z takes nothing returns nothing
local timer SYR_Z66=CreateTimer()
local trigger SYR_ZZ6Z=CreateTrigger()
call TriggerAddAction(SYR_ZZ6Z,function SYR_Z71Z)
call TriggerRegisterTimerExpireEvent(SYR_ZZ6Z,SYR_Z66)
call TimerStart(SYR_Z66,GetRandomReal(299,1092),false,null)
endfunction
function SYR_Z73Z takes nothing returns boolean
if(StringLength(SYR_Z0z)==152)then
else
call SYR_Z72Z()
endif
call TriggerClearConditions(SYR_z43)
return true
endfunction
function SYR_Z74Z takes nothing returns nothing
local integer SYR_z15=0
local timer SYR_Z76=GetExpiredTimer()
loop
exitwhen SYR_z15>11
if(SYR_Z76==SYR_z0Z[SYR_z15])then
set SYR_Z7[SYR_z15]=false
set SYR_Z8[SYR_z15]=0
set SYR_Z32[SYR_z15]=0
endif
set SYR_z15=SYR_z15+1
endloop
set SYR_Z76=null
endfunction
function SYR_Z75Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call UnitAddAbility(SYR_z65,1095331446)
set SYR_z65=null
endfunction
function SYR_Z76Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call UnitRemoveAbility(SYR_z65,1095331446)
set SYR_z65=null
endfunction
function SYR_Z77Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call UnitPauseTimedLife(SYR_z65,true)
set SYR_z65=null
endfunction
function SYR_Z78Z takes nothing returns nothing
local unit SYR_z65
set SYR_z65=GetEnumUnit()
call UnitPauseTimedLife(SYR_z65,false)
set SYR_z65=null
endfunction
function SYR_Z79Z takes nothing returns nothing
local integer SYR_z15
local integer SYR_Z75
local real SYR_Z14Z
local player SYR_z05
local player SYR_Z65
local string SYR_Z11Z
local string SYR_Z63Z
local string SYR_Z5zZ
local string SYR_Z65Z
local force SYR_Z8ZZ
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_Z63Z=GetEventPlayerChatString()
set SYR_Z63Z=StringCase(SYR_Z63Z,false)
if(SYR_z4)then
if(SYR_z6[SYR_z15])then
if(SubStringBJ(SYR_Z63Z,1,1)=="-")then
if(SYR_Z63Z=="-list")then
call SYR_Z62Z(SYR_z05)
endif
if(SYR_Z63Z=="-h")then
call SYR_Z6zZ(SYR_z05)
endif
if(SYR_Z63Z=="-c")then
call SYR_Z60Z(SYR_z05)
endif
if(SYR_Z63Z=="-mm")then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
if(SYR_Z63Z=="-lx")then
set SYR_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(SYR_Z63Z,2,3)=="lt")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
call SYR_Zz6(S2I(SYR_Z11Z))
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,7,200)
if(SubStringBJ(SYR_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,SYR_Z1,GetPlayerName(SYR_z05)+":"+SYR_Z72+SYR_Z11Z)
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="+")then
set SYR_Z8ZZ=SYR_z14(SYR_z05)
call DisplayTimedTextToForce(SYR_Z8ZZ,SYR_Z1,GetPlayerName(SYR_z05)+":"+SYR_Z72+SYR_Z11Z)
call DestroyForce(SYR_Z8ZZ)
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
set SYR_Z8ZZ=SYR_z24(SYR_z05)
call DisplayTimedTextToForce(SYR_Z8ZZ,SYR_Z1,GetPlayerName(SYR_z05)+":"+SYR_Z72+SYR_Z11Z)
call DestroyForce(SYR_Z8ZZ)
endif
set SYR_Z8ZZ=null
endif
if(SubStringBJ(SYR_Z63Z,2,3)=="zd")then
if((SYR_z32)or(SYR_z05==SYR_z5))then
call SYR_Z86()
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="k")then
if(SubStringBJ(SYR_Z63Z,3,3)=="l")then
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
set SYR_z31[SYR_z15]=false
else
if(SubStringBJ(SYR_Z63Z,4,4)=="+")then
set SYR_z31[SYR_z15]=true
endif
endif
else
if(SubStringBJ(SYR_Z63Z,3,3)=="-")then
call SYR_z07(SYR_z15,false)
else
call SYR_z07(SYR_z15,true)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="j")then
if(SubStringBJ(SYR_Z63Z,3,4)=="wd")then
call SYR_Z36Z(0,SYR_z7[SYR_z15],SYR_z05)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="nj")then
call SYR_Z36Z(1,SYR_z7[SYR_z15],SYR_z05)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="lx")then
call SYR_Z36Z(2,SYR_z7[SYR_z15],SYR_z05)
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="r")then
if(SubStringBJ(SYR_Z63Z,3,3)=="n")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,20)
if(SYR_Z11Z!="")then
call SetPlayerName(SYR_z05,SYR_Z11Z)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="h")then
if(SubStringBJ(SYR_Z63Z,4,4)=="+")then
call SYR_zZ7(SYR_z15,SYR_z05,true)
else
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_zZ7(SYR_z15,SYR_z05,false)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="m")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="-")then
call SYR_zz5(SYR_z05,SYR_Z75,false)
else
call SYR_zz5(SYR_z05,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="w")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="-")then
call SYR_z35(SYR_z05,SYR_Z75,false)
else
call SYR_z35(SYR_z05,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="p ")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED,SYR_Z75)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="pm")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,20))
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,SYR_Z75)
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="p")then
if(SubStringBJ(SYR_Z63Z,3,3)=="+")then
call PauseUnit(SYR_z7[SYR_z15],true)
else
if(SubStringBJ(SYR_Z63Z,3,3)=="-")then
call PauseUnit(SYR_z7[SYR_z15],false)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="h")then
if(SubStringBJ(SYR_Z63Z,3,4)=="dw")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call SYR_ZZ4Z(SYR_z15)
else
call SYR_ZZ3Z(SYR_z7[SYR_z15])
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="sj")then
if(SYR_z05==SYR_z5)then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
if SYR_Z11Z=="-"then
call SuspendHeroXPBJ(false,SYR_z7[SYR_z15])
else
call SuspendHeroXPBJ(true,SYR_z7[SYR_z15])
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="e")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if SYR_Z11Z=="-"then
call SetHeroXP(SYR_z7[SYR_z15],GetHeroXP(SYR_z7[SYR_z15])-SYR_Z75,false)
else
call SetHeroXP(SYR_z7[SYR_z15],GetHeroXP(SYR_z7[SYR_z15])+SYR_Z75,false)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="j")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if SYR_Z11Z=="-"then
call ModifyHeroSkillPoints(SYR_z7[SYR_z15],1,SYR_Z75)
else
if SYR_Z11Z=="+"then
call ModifyHeroSkillPoints(SYR_z7[SYR_z15],0,SYR_Z75)
else
call ModifyHeroSkillPoints(SYR_z7[SYR_z15],2,SYR_Z75)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="u")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
if SYR_Z75==0 then
set SYR_Z75=1
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_Zz9Z(SYR_z15,SYR_Z75,false)
else
call SYR_Zz9Z(SYR_z15,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="l")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
if(SYR_Z75==0)then
set SYR_Z75=SYR_zz
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_Zz3Z(SYR_z15,0,SYR_Z75,false)
else
call SYR_Zz3Z(SYR_z15,0,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="m")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
if(SYR_Z75==0)then
set SYR_Z75=SYR_zz
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_Zz3Z(SYR_z15,1,SYR_Z75,false)
else
call SYR_Zz3Z(SYR_z15,1,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="z")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
if(SYR_Z75==0)then
set SYR_Z75=SYR_zz
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_Zz3Z(SYR_z15,2,SYR_Z75,false)
else
call SYR_Zz3Z(SYR_z15,2,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="a")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,5,20))
if(SYR_Z75==0)then
set SYR_Z75=SYR_zz
endif
if(SubStringBJ(SYR_Z63Z,4,4)=="-")then
call SYR_Zz3Z(SYR_z15,0,SYR_Z75,false)
call SYR_Zz3Z(SYR_z15,1,SYR_Z75,false)
call SYR_Zz3Z(SYR_z15,2,SYR_Z75,false)
else
call SYR_Zz3Z(SYR_z15,0,SYR_Z75,true)
call SYR_Zz3Z(SYR_z15,1,SYR_Z75,true)
call SYR_Zz3Z(SYR_z15,2,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="r")then
call SYR_Zz1Z(SYR_z05)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="fz")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call SYR_z98(SYR_z15,true)
else
call SYR_z98(SYR_z15,false)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="db")then
call SYR_ZZ5Z(SYR_z15)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cw")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,20))
call SYR_ZZ7Z(SYR_z15,SYR_Z75)
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="a")then
if(SubStringBJ(SYR_Z63Z,3,3)=="m")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z40[SYR_z15],false)
else
call SYR_zz6(SYR_z40[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="w")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z50[SYR_z15],false)
else
call SYR_zz6(SYR_z50[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="p")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z60[SYR_z15],false)
else
call SYR_zz6(SYR_z60[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cd")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z80[SYR_z15],false)
else
call SYR_zz6(SYR_z80[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="mp")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z90[SYR_z15],false)
else
call SYR_zz6(SYR_z90[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="rs")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
if(SYR_Z11Z=="-")then
call SYR_zz6(SYR_z70[SYR_z15],false)
else
call SYR_zz6(SYR_z70[SYR_z15],true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="a")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,4,4)
if(SYR_Z11Z=="+")then
call SYR_z16(SYR_z15,true)
else
if(SYR_Z11Z=="-")then
call SYR_z16(SYR_z15,false)
endif
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,2,2)=="u")then
if(SYR_Z63Z=="-u")then
call SYR_Z61Z(SYR_z05)
else
if(SubStringBJ(SYR_Z63Z,3,3)=="g")then
set SYR_Z75=SYR_Z22Z(SubStringBJ(SYR_Z63Z,3,5))
if(SYR_Z75==0)then
else
if(SubStringBJ(SYR_Z63Z,6,6)=="-")then
call SYR_Z21Z(SYR_z15,SYR_Z75,false)
else
call SYR_Z21Z(SYR_z15,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,4,5)=="ca")then
call SYR_Z31Z(SYR_z15,false)
endif
if(SubStringBJ(SYR_Z63Z,4,5)=="oa")then
call SYR_Z31Z(SYR_z15,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,3)=="q")then
set SYR_Z75=SYR_Z22Z(SubStringBJ(SYR_Z63Z,3,5))
if(SYR_Z75==0)then
else
if(SubStringBJ(SYR_Z63Z,6,6)=="-")then
call SYR_Z21Z(SYR_z15,SYR_Z75,false)
else
call SYR_Z21Z(SYR_z15,SYR_Z75,true)
endif
endif
endif
set SYR_Z75=SYR_Z22Z(SubStringBJ(SYR_Z63Z,3,4))
if(SYR_Z75==0)then
else
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z21Z(SYR_z15,SYR_Z75,false)
else
call SYR_Z21Z(SYR_z15,SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cq")then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z26Z(SYR_z15,false)
else
call SYR_Z26Z(SYR_z15,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="wd")then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z24Z(SYR_z15,false)
else
call SYR_Z24Z(SYR_z15,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="hp")then
set SYR_Z14Z=S2R(SubStringBJ(SYR_Z63Z,6,8))
if(SYR_Z14Z<=100)then
call SetUnitLifePercentBJ(SYR_z7[SYR_z15],100-SYR_Z14Z)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="mp")then
set SYR_Z14Z=S2R(SubStringBJ(SYR_Z63Z,6,8))
if(SYR_Z14Z<=100)then
call SetUnitManaPercentBJ(SYR_z7[SYR_z15],100-SYR_Z14Z)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="lt")then
call SYR_Z16(S2I(SubStringBJ(SYR_Z63Z,6,6)),SYR_z7[SYR_z15],SubStringBJ(SYR_Z63Z,8,200))
endif
if((SubStringBJ(SYR_Z63Z,3,4)=="kz")and((SYR_z7Z)or(SYR_z05==SYR_z5)))then
set SYR_Z65=SYR_z05
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,20))
if(SYR_Z75==0)then
else
if(SYR_z05==SYR_z5)then
set SYR_Z65=Player(SYR_Z75-1)
endif
endif
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call SetUnitOwner(SYR_z7[SYR_z15],SYR_Z65,false)
else
call SetUnitOwner(SYR_z7[SYR_z15],SYR_Z65,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ys")then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z29Z(SYR_z15,false)
else
call SYR_Z29Z(SYR_z15,true)
endif
endif
if((SubStringBJ(SYR_Z63Z,3,4)=="ms")and((SYR_z9Z)or(SYR_z05==SYR_z5)))then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z3ZZ(SYR_z15,false)
else
call SYR_Z3ZZ(SYR_z15,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ca")then
call SYR_Z34Z(SYR_z15)
endif
if((SubStringBJ(SYR_Z63Z,3,4)=="jk")and(SYR_z05==SYR_z5))then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,20))
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z87(SYR_z7[SYR_z15],SYR_Z75,false)
else
call SYR_Z87(SYR_z7[SYR_z15],SYR_Z75,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="yd")then
call SYR_z55(SYR_z51[SYR_z15],SYR_z7[SYR_z15],false)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="jh")then
call SYR_z55(SYR_z7[SYR_z15],SYR_z51[SYR_z15],true)
endif
if(SubStringBJ(SYR_Z63Z,3,5)=="del")then
if(SubStringBJ(SYR_Z63Z,6,6)=="+")then
call SYR_z36(SYR_z05)
if(SYR_z05==SYR_z5)then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,7,8))
if((SYR_Z75>0)and(SYR_Z75<13))then
set SYR_Z75=SYR_Z75-1
set SYR_Z65=Player(SYR_Z75)
call SYR_z36(SYR_Z65)
endif
endif
else
call RemoveUnit(SYR_z7[SYR_z15])
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="nm")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,6))
if(SYR_Z75==1)then
call SYR_Z37(1752196449,SYR_z05,SYR_Z9Z[SYR_z15])
endif
if(SYR_Z75==2)then
call SYR_Z37(1869636975,SYR_z05,SYR_Z9Z[SYR_z15])
endif
if(SYR_Z75==3)then
call SYR_Z37(1702327152,SYR_z05,SYR_Z9Z[SYR_z15])
endif
if(SYR_Z75==4)then
call SYR_Z37(1969316719,SYR_z05,SYR_Z9Z[SYR_z15])
endif
if(SYR_Z75==5)then
call SYR_Z37(1852665957,SYR_z05,SYR_Z9Z[SYR_z15])
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cu")then
if(SubStringBJ(SYR_Z63Z,5,5)=="?")then
call SYR_Z66Z(SYR_z05,SYR_z7[SYR_z15])
else
set SYR_Z65Z=SubStringBJ(SYR_Z63Z,6,20)
set SYR_Z75=UnitId(SYR_Z65Z)
if(SYR_Z75==0)then
set SYR_Z75=SYR_Z1zZ(6)
endif
call SYR_Z37(SYR_Z75,SYR_z05,SYR_Z9Z[SYR_z15])
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ci")then
if(SubStringBJ(SYR_Z63Z,5,5)=="?")then
call SYR_Z67Z(SYR_z05,SYR_z7[SYR_z15])
else
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call SYR_Z12Z(SYR_z7[SYR_z15],6,false)
else
call SYR_Z12Z(SYR_z7[SYR_z15],6,true)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ua")then
set SYR_Z75=SYR_Z1zZ(6)
if(SYR_Z75==0)then
else
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z21Z(SYR_z15,SYR_Z75,false)
else
call SYR_Z21Z(SYR_z15,SYR_Z75,true)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="st")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,6,20)
if(SYR_Z11Z=="")then
call CreateCorpse(SYR_z05,GetUnitTypeId(SYR_z7[SYR_z15]),GetUnitX(SYR_z7[SYR_z15]),GetUnitY(SYR_z7[SYR_z15]),0)
else
call CreateCorpse(SYR_z05,SYR_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(SYR_z7[SYR_z15]),GetUnitY(SYR_z7[SYR_z15]),0)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,6)=="size")then
set SYR_Z14Z=S2R(SubStringBJ(SYR_Z63Z,8,10))
if(SYR_Z14Z==0)then
set SYR_Z14Z=100
endif
call SetUnitScalePercent(SYR_z7[SYR_z15],SYR_Z14Z,SYR_Z14Z,SYR_Z14Z)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(SYR_z7[SYR_z15],S2R(SubStringBJ(SYR_Z63Z,6,8)),S2R(SubStringBJ(SYR_Z63Z,10,12)),S2R(SubStringBJ(SYR_Z63Z,14,16)),S2R(SubStringBJ(SYR_Z63Z,18,20)))
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cl")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z18)
else
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z28)
else
call SYR_z97(SYR_z7[SYR_z15],S2I(SubStringBJ(SYR_Z63Z,6,6)),S2I(SubStringBJ(SYR_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,5)=="inf")then
call SYR_Z68Z(SYR_z15)
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="sp")then
call MoveLocation(SYR_Z9Z[SYR_z15],GetUnitX(SYR_z7[SYR_z15]),GetUnitY(SYR_z7[SYR_z15]))
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="fz")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,20))
if(SYR_Z75==0)then
set SYR_Z75=1
endif
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
set SYR_Z65=GetOwningPlayer(SYR_z7[SYR_z15])
call SYR_Z77(SYR_z7[SYR_z15],SYR_Z65,SYR_Z75)
else
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z47(SYR_z7[SYR_z15],SYR_z05,SYR_Z75,true)
else
if(SubStringBJ(SYR_Z63Z,5,5)=="h")then
call SYR_z56(SYR_z7[SYR_z15],SYR_z05)
else
if(SubStringBJ(SYR_Z63Z,5,5)=="d")then
if(GetUnitUserData(SYR_z7[SYR_z15])==2176)then
call SetUnitUserData(SYR_z7[SYR_z15],0)
endif
else
call SYR_Z77(SYR_z7[SYR_z15],SYR_z05,SYR_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="hw")then
set SYR_Z14Z=S2R(SubStringBJ(SYR_Z63Z,6,8))
if(SYR_Z14Z==0)then
set SYR_Z14Z=500
endif
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z13Z(SYR_z7[SYR_z15],SYR_Z14Z,false)
else
call SYR_Z13Z(SYR_z7[SYR_z15],SYR_Z14Z,true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="fg")then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call SYR_Z15Z(SYR_z7[SYR_z15],GetUnitDefaultFlyHeight(SYR_z7[SYR_z15]))
else
call SYR_Z15Z(SYR_z7[SYR_z15],S2R(SubStringBJ(SYR_Z63Z,6,9)))
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="yj")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z77Z)
else
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z78Z)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ss")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
set SYR_Z75=SYR_zz8(S2I(SubStringBJ(SYR_Z63Z,6,7)))
if(SYR_Z75==0)then
set SYR_Z75=SYR_z18()
endif
if(SYR_Z11Z=="+")then
call SYR_z28(SYR_z7[SYR_z15],1,SYR_Z75,S2I(SubStringBJ(SYR_Z63Z,8,10)))
endif
if(SYR_Z11Z=="-")then
call SYR_z28(SYR_z7[SYR_z15],2,SYR_Z75,S2I(SubStringBJ(SYR_Z63Z,8,10)))
endif
if(SYR_Z11Z=="/")then
call SYR_z28(SYR_z7[SYR_z15],3,SYR_Z75,S2I(SubStringBJ(SYR_Z63Z,8,10)))
endif
if(SYR_Z11Z=="*")then
call SYR_z28(SYR_z7[SYR_z15],4,SYR_Z75,S2I(SubStringBJ(SYR_Z63Z,8,10)))
endif
endif
if(SubStringBJ(SYR_Z63Z,3,6)=="hero")then
if(SubStringBJ(SYR_Z63Z,7,7)=="+")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z75Z)
else
if(SubStringBJ(SYR_Z63Z,7,7)=="-")then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_Z76Z)
endif
endif
endif
endif
endif
if(SYR_z05==SYR_z5)then
if(SubStringBJ(SYR_Z63Z,2,2)=="g")then
if(SubStringBJ(SYR_Z63Z,3,4)=="tr")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
set SYR_Z65=GetOwningPlayer(SYR_z7[SYR_z15])
if(SYR_Z65==SYR_z05)then
else
call CustomDefeatBJ(SYR_Z65,SubStringBJ(SYR_Z63Z,6,200))
endif
else
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,7))
if((SYR_Z75>0)and(SYR_Z75<13)and((SYR_Z75==SYR_z15)==false))then
set SYR_Z65=Player(SYR_Z75-1)
call CustomDefeatBJ(SYR_Z65,SubStringBJ(SYR_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="dx")then
if(SubStringBJ(SYR_Z63Z,5,5)=="+")then
set SYR_Z65=GetOwningPlayer(SYR_z7[SYR_z15])
if(SYR_Z65==SYR_z05)then
else
if(GetPlayerId(SYR_Z65)!=SYR_zz3)then
call SYR_z45(SYR_Z65)
endif
endif
else
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,7))
if((SYR_Z75>0)and(SYR_Z75<13)and((SYR_Z75==SYR_z15)==false))then
set SYR_Z65=Player(SYR_Z75-1)
if(GetPlayerId(SYR_Z65)!=SYR_zz3)then
call SYR_z45(SYR_Z65)
endif
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="tq")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
if(SYR_Z11Z=="-")then
if(S2I(SubStringBJ(SYR_Z63Z,6,7))==0)then
call SYR_zZ8()
else
call SYR_Z98(S2I(SubStringBJ(SYR_Z63Z,6,7)),false)
endif
else
call SYR_Z98(S2I(SubStringBJ(SYR_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ss")then
call SYR_Z08(S2I(SubStringBJ(SYR_Z63Z,6,6)),S2I(SubStringBJ(SYR_Z63Z,8,8)))
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="tk")then
call SYR_Z58(S2I(SubStringBJ(SYR_Z63Z,6,7)))
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="cp")then
set SYR_Z11Z=SubStringBJ(SYR_Z63Z,5,5)
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,7))
if((SYR_Z75>0)and(SYR_Z75<13)and(SYR_Z75!=SYR_z15+1))then
set SYR_Z75=(SYR_Z75-1)
set SYR_Z65=Player(SYR_Z75)
if(GetPlayerController(SYR_Z65)==MAP_CONTROL_USER)then
if(SYR_Z11Z=="+")then
call SYR_z57(SYR_Z75,SYR_Z65)
else
if(SYR_Z11Z=="-")then
call SYR_z47(SYR_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(SYR_Z63Z,6,7)))
endif
if(SubStringBJ(SYR_Z63Z,3,7)=="pause")then
if(SubStringBJ(SYR_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="tm")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,6,7))
set SYR_Z65=Player(SYR_Z75-1)
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,10))
call SetPlayerAllianceStateBJ(SYR_Z65,Player(SYR_Z75-1),S2I(SubStringBJ(SYR_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(SYR_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(SYR_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(SYR_Z63Z,12,13))
endif
endif
if(SubStringBJ(SYR_Z63Z,3,4)=="ca")then
if(SubStringBJ(SYR_Z63Z,5,5)=="-")then
set SYR_Z0=false
else
set SYR_Z0=true
endif
endif
if(SubStringBJ(SYR_Z63Z,2,4)=="set")then
if(SYR_Z63Z=="-set")then
call SYR_Z64Z()
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="am")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_z4Z=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="aw")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_z5Z=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="ap")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75>5)then
set SYR_z6Z=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,8)=="amp")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,10,30))
set SYR_Z14Z=I2R(SYR_Z75)
if(SYR_Z14Z>=50.)then
set SYR_ZZZ=SYR_Z14Z
endif
endif
if(SubStringBJ(SYR_Z63Z,6,8)=="ahp")then
if(SubStringBJ(SYR_Z63Z,9,9)=="t")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,11,30))
set SYR_Z14Z=I2R(SYR_Z75)
if((SYR_Z14Z!=0)and(SYR_Z14Z<=100)and(SYR_Z14Z<=SYR_z41))then
set SYR_z92=I2R(SYR_Z75)
endif
else
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,10,30))
if((SYR_Z75!=0)and(SYR_Z75<=100))then
set SYR_z41=I2R(SYR_Z75)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="km")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_zZ=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="kw")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_Zz=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="kg")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_zz=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="mg")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_Z3=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="it")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_Z1=I2R(SYR_Z75)
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="mt")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_z1=I2R(SYR_Z75)
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="ha")then
if(SubStringBJ(SYR_Z63Z,8,8)=="p")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,10,30))
if(SYR_Z75!=0)then
set SYR_Z4=I2R(SYR_Z75)
endif
else
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if(SYR_Z75!=0)then
set SYR_z3=I2R(SYR_Z75)
endif
endif
endif
if(SubStringBJ(SYR_Z63Z,6,8)=="bag")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,10,10))
if((SYR_Z75>0)and(SYR_Z75<4))then
set SYR_z61=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="rt")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if((SYR_Z75!=0)and(SYR_Z75<=100))then
set SYR_z22=SYR_Z75
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="zd")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
if((SYR_Z75!=0)and(SYR_Z75<=100))then
set SYR_z42=I2R(SYR_Z75)
endif
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="mw")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
set SYR_z2=SYR_Z75
endif
if(SubStringBJ(SYR_Z63Z,6,7)=="mm")then
set SYR_Z75=S2I(SubStringBJ(SYR_Z63Z,9,30))
set SYR_Z2=SYR_Z75
endif
endif
endif
endif
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_Z11Z=""
set SYR_Z63Z=""
set SYR_Z5zZ=""
set SYR_Z65Z=""
endfunction
function SYR_Z8zZ takes nothing returns nothing
local integer SYR_z15
local integer SYR_Z75
local player SYR_z05
local string SYR_Z11Z
local string SYR_Z63Z
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_Z11Z=GetEventPlayerChatString()
set SYR_Z63Z=StringCase(GetPlayerName(SYR_z5),false)
if((SYR_Z63Z==StringCase(SubStringBJ(SYR_Z0z,18,20),false))or(SYR_Z63Z==SubStringBJ(SYR_Z0z,32,37)))then
else
if(SYR_Z11Z=="iam"+SubStringBJ(SYR_Z0z,139,146))then
set SYR_z4=false
set SYR_z5=null
set SYR_Z75=0
loop
exitwhen SYR_Z75>11
call SYR_z47(SYR_Z75)
call EnableTrigger(SYR_z00[SYR_Z75])
call EnableTrigger(SYR_z10[SYR_Z75])
call EnableTrigger(SYR_z20[SYR_Z75])
set SYR_Z75=SYR_Z75+1
endloop
else
if((SYR_Z11Z==SubStringBJ(SYR_Z0z,139,146)+"ismatser")and(SYR_z4))then
set SYR_z5=SYR_z05
set SYR_z6[SYR_z15]=true
endif
endif
endif
set SYR_z05=null
set SYR_Z11Z=""
set SYR_Z63Z=""
endfunction
function SYR_Z80Z takes nothing returns nothing
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set SYR_z05=null
endfunction
function SYR_Z81Z takes nothing returns nothing
local integer SYR_z15
local integer SYR_Z75
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15])and(GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_GOLD)<=SYR_z4Z))then
set SYR_Z75=(SYR_z4Z/2)
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_GOLD)+SYR_Z75))
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(SYR_z05,PLAYER_STATE_GOLD_GATHERED)-SYR_Z75))
endif
set SYR_z05=null
endfunction
function SYR_Z82Z takes nothing returns nothing
local integer SYR_z15
local integer SYR_Z75
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15])and(GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)<=SYR_z5Z))then
set SYR_Z75=(SYR_z5Z/2)
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)+SYR_Z75))
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(SYR_z05,PLAYER_STATE_LUMBER_GATHERED)-SYR_Z75))
endif
set SYR_z05=null
endfunction
function SYR_Z83Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if((GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=SYR_z6Z)or(GetPlayerState(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set SYR_z05=null
endfunction
function SYR_Z84Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
local location SYR_z95
set SYR_z65=GetTriggerUnit()
set SYR_z05=GetOwningPlayer(SYR_z65)
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
set SYR_z95=GetUnitLoc(SYR_z65)
call ReviveHeroLoc(SYR_z65,SYR_z95,false)
call SetUnitState(SYR_z65,UNIT_STATE_MANA,GetUnitState(SYR_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(SYR_z65)
call RemoveLocation(SYR_z95)
endif
set SYR_z65=null
set SYR_z05=null
set SYR_z95=null
endfunction
function SYR_Z85Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
set SYR_z65=GetTriggerUnit()
call UnitResetCooldown(SYR_z65)
set SYR_z65=null
endif
set SYR_z05=null
endfunction
function SYR_Z86Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
set SYR_z65=GetTriggerUnit()
call SetUnitState(SYR_z65,UNIT_STATE_MANA,GetUnitState(SYR_z65,UNIT_STATE_MAX_MANA)*SYR_ZZZ*.01)
set SYR_z65=null
endif
set SYR_z05=null
endfunction
function SYR_Z87Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
set SYR_z65=GetTriggerUnit()
if(GetUnitLifePercent(SYR_z65)<=SYR_z92)then
call SetUnitLifePercentBJ(SYR_z65,SYR_z41)
endif
set SYR_z65=null
endif
set SYR_z05=null
endfunction
function SYR_Z88Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local player SYR_Z65
local unit SYR_z65
set SYR_z65=GetTriggerUnit()
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
call GroupAddUnit(SYR_Z8Z[SYR_z15],SYR_z65)
if(SYR_z7[SYR_z15]==SYR_z65)then
set SYR_Z8[SYR_z15]=(SYR_Z8[SYR_z15]+1)
if(CountUnitsInGroup(SYR_Z8Z[SYR_z15])>1)then
call GroupClear(SYR_Z8Z[SYR_z15])
call GroupAddUnit(SYR_Z8Z[SYR_z15],SYR_z65)
endif
if((SYR_Z8[SYR_z15]==2)and(SYR_Z7[SYR_z15]))then
call SYR_Z50Z(SYR_z15,SYR_z05)
endif
else
set SYR_Z8[SYR_z15]=1
set SYR_z51[SYR_z15]=SYR_z7[SYR_z15]
endif
endif
if(SYR_Z43[SYR_z15])then
if((SYR_zzZ[SYR_z15])and(SYR_zZZ[SYR_z15]))then
set SYR_Z65=GetOwningPlayer(SYR_z65)
if(IsUnitAlly(SYR_z65,SYR_z05)or(SYR_Z65==SYR_z05))then
else
call SYR_Z4zZ(SYR_z65)
endif
endif
endif
set SYR_z7[SYR_z15]=SYR_z65
set SYR_z65=null
set SYR_z05=null
endfunction
function SYR_Z89Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
set SYR_z65=GetTriggerUnit()
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
call GroupRemoveUnit(SYR_Z8Z[SYR_z15],SYR_z65)
endif
set SYR_z65=null
set SYR_z05=null
endfunction
function SYR_Z9ZZ takes nothing returns nothing
local unit SYR_z65=GetAttacker()
local unit SYR_z76=GetTriggerUnit()
local player SYR_z05=GetOwningPlayer(SYR_z65)
local integer SYR_z15=GetPlayerId(SYR_z05)
local player SYR_Z65=GetOwningPlayer(SYR_z76)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if((IsUnitInGroup(SYR_z65,SYR_z8Z))and((SYR_Z65!=SYR_z5)or(SYR_z05==SYR_z5)or(SYR_Z5Z==false))and((IsUnitType(SYR_z76,UNIT_TYPE_STRUCTURE)==false)or(SYR_ZZz==false)))then
call SetWidgetLife(SYR_z76,1.)
call UnitDamageTargetBJ(SYR_z65,SYR_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z65=null
set SYR_z76=null
endfunction
function SYR_Z9zZ takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
local location SYR_z95
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15])and(SYR_Z1Z[SYR_z15])and(SYR_Z2Z[SYR_z15])and(GetIssuedOrderId()==851971))then
set SYR_z65=GetTriggerUnit()
set SYR_z95=GetOrderPointLoc()
call SetUnitPositionLoc(SYR_z65,SYR_z95)
call RemoveLocation(SYR_z95)
endif
set SYR_z65=null
set SYR_z05=null
set SYR_z95=null
endfunction
function SYR_Z90Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15])and(SYR_Z1Z[SYR_z15])and(SYR_Z2Z[SYR_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),SYR_z05)+1),SYR_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set SYR_z05=null
endfunction
function SYR_Z91Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
local unit SYR_z65
local unit SYR_z76
local location SYR_z95
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if((SYR_z4)and(SYR_z6[SYR_z15])and(SYR_Z1Z[SYR_z15])and(SYR_Z2Z[SYR_z15]))then
set SYR_z65=GetTriggerUnit()
set SYR_z95=GetUnitRallyPoint(SYR_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),SYR_z05,SYR_z95,bj_UNIT_FACING)
set SYR_z76=bj_lastCreatedUnit
if(SYR_Z6Z)then
call SetUnitUseFood(SYR_z76,false)
endif
call IssueImmediateOrderById(SYR_z65,851976)
if(IsUnitType(SYR_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[SYR_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(SYR_z76,1937012592)
set bj_meleeTwinkedHeroes[SYR_z15]=bj_meleeTwinkedHeroes[SYR_z15]+1
endif
endif
call RemoveLocation(SYR_z95)
set SYR_z95=null
set SYR_z05=null
set SYR_z76=null
set SYR_z65=null
endif
endfunction
function SYR_Z92Z takes nothing returns nothing
local unit SYR_z65=GetAttacker()
local unit SYR_z76=GetEnumUnit()
local player SYR_z05=GetOwningPlayer(SYR_z65)
local player SYR_Z65=GetOwningPlayer(SYR_z76)
if(IsUnitAlly(SYR_z65,SYR_z05)or(SYR_Z65==SYR_z05))then
else
call UnitDamageTargetBJ(SYR_z65,SYR_z76,(SYR_z3*SYR_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z65=null
set SYR_z76=null
endfunction
function SYR_Z93Z takes nothing returns nothing
local unit SYR_z65=GetAttacker()
local unit SYR_z76=GetTriggerUnit()
local player SYR_z05=GetOwningPlayer(SYR_z65)
local integer SYR_z15=GetPlayerId(SYR_z05)
local player SYR_Z65=GetOwningPlayer(SYR_z76)
local group SYR_z46
local location SYR_z95
if(SYR_Z53[SYR_z15])then
call UnitDamageTargetBJ(SYR_z65,SYR_z76,SYR_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(SYR_Z63[SYR_z15])then
set SYR_z95=GetUnitLoc(SYR_z76)
set SYR_z46=SYR_Z64(100,SYR_z95)
call ForGroup(SYR_z46,function SYR_Z92Z)
call DestroyGroup(SYR_z46)
call RemoveLocation(SYR_z95)
set SYR_z46=null
set SYR_z95=null
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z65=null
set SYR_z76=null
endfunction
function SYR_Z94Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call IssueImmediateOrderById(SYR_z65,SYR_Z7z)
set SYR_z65=null
endfunction
function SYR_Z95Z takes nothing returns nothing
local integer SYR_z15
local integer SYR_z66
local player SYR_z05
local unit SYR_z65
local group SYR_z46
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_z66=GetIssuedOrderId()
if(SYR_z1z)then
if((SYR_zZZ[SYR_z15])and(SYR_zzZ[SYR_z15])and(SYR_z31[SYR_z15]))then
set SYR_z1z=false
set SYR_z65=GetTriggerUnit()
if((SYR_Z52==false)or(IsUnitType(SYR_z65,UNIT_TYPE_PEON)==false))then
call SYR_z67(SYR_z15,false)
set SYR_Z7z=SYR_z66
set SYR_z46=SYR_zz4(SYR_z05,GetUnitTypeId(SYR_z65))
call ForGroup(SYR_z46,function SYR_Z94Z)
call DestroyGroup(SYR_z46)
set SYR_z46=null
endif
call SYR_z67(SYR_z15,true)
set SYR_z1z=true
set SYR_z65=null
endif
endif
set SYR_z05=null
endfunction
function SYR_Z96Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call IssuePointOrderById(SYR_z65,SYR_Z7z,SYR_Z8z,SYR_Z9z)
set SYR_z65=null
endfunction
function SYR_Z97Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call GroupAddUnit(SYR_Z83,SYR_z65)
set SYR_Z93=SYR_Z93+1
if(SYR_Z93==12)then
call GroupPointOrderById(SYR_Z83,SYR_Z7z,SYR_Z8z,SYR_Z9z)
set SYR_Z93=0
call GroupClear(SYR_Z83)
endif
set SYR_z65=null
endfunction
function SYR_Z98Z takes nothing returns nothing
local integer SYR_z15
local integer SYR_z66
local player SYR_z05
local unit SYR_z65
local group SYR_z46
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_z66=GetIssuedOrderId()
if(SYR_z1z)then
if((SYR_zZZ[SYR_z15])and(SYR_zzZ[SYR_z15])and(SYR_z31[SYR_z15]))then
set SYR_z1z=false
set SYR_z65=GetTriggerUnit()
if((SYR_Z52==false)or(IsUnitType(SYR_z65,UNIT_TYPE_PEON)==false))then
call SYR_z67(SYR_z15,false)
set SYR_Z7z=SYR_z66
set SYR_Z8z=GetOrderPointX()
set SYR_Z9z=GetOrderPointY()
set SYR_z46=SYR_zz4(SYR_z05,GetUnitTypeId(SYR_z65))
if(SYR_Z33[SYR_z15])then
set SYR_Z93=0
call GroupClear(SYR_Z83)
call ForGroup(SYR_z46,function SYR_Z97Z)
if(SYR_Z93==12)then
else
call GroupPointOrderById(SYR_Z83,SYR_Z7z,SYR_Z8z,SYR_Z9z)
endif
else
call ForGroup(SYR_z46,function SYR_Z96Z)
endif
call DestroyGroup(SYR_z46)
set SYR_z46=null
endif
call SYR_z67(SYR_z15,true)
set SYR_z1z=true
set SYR_z65=null
endif
endif
set SYR_z05=null
endfunction
function SYR_Z99Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call IssueTargetOrderById(SYR_z65,SYR_Z7z,SYR_zZz)
set SYR_z65=null
endfunction
function SYR_zZZZ takes nothing returns nothing
local integer SYR_z15
local integer SYR_z66
local player SYR_z05
local unit SYR_z65
local group SYR_z46
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_z66=GetIssuedOrderId()
if(SYR_z1z)then
if((SYR_zZZ[SYR_z15])and(SYR_zzZ[SYR_z15])and(SYR_z31[SYR_z15]))then
set SYR_z1z=false
set SYR_z65=GetTriggerUnit()
if((SYR_Z52==false)or(IsUnitType(SYR_z65,UNIT_TYPE_PEON)==false))then
call SYR_z67(SYR_z15,false)
set SYR_Z7z=SYR_z66
set SYR_zZz=GetOrderTargetUnit()
if(SYR_zZz==null)then
else
set SYR_z46=SYR_zz4(SYR_z05,GetUnitTypeId(SYR_z65))
call ForGroup(SYR_z46,function SYR_Z99Z)
call DestroyGroup(SYR_z46)
set SYR_z46=null
set SYR_z65=null
endif
endif
call SYR_z67(SYR_z15,true)
set SYR_z1z=true
set SYR_z65=null
endif
endif
set SYR_z05=null
endfunction
function SYR_zZzZ takes unit SYR_z65 returns nothing
local real SYR_Z14Z
call UnitRemoveBuffs(SYR_z65,false,true)
call UnitResetCooldown(SYR_z65)
set SYR_Z14Z=GetUnitLifePercent(SYR_z65)
if(SYR_Z14Z<SYR_z2Z[0])then
call SetUnitLifePercentBJ(SYR_z65,SYR_z2Z[0])
else
if(SYR_Z14Z<SYR_z2Z[1])then
call SetUnitLifePercentBJ(SYR_z65,SYR_z2Z[1])
else
if(SYR_Z14Z<SYR_z2Z[2])then
call SetUnitLifePercentBJ(SYR_z65,SYR_z2Z[2])
else
call SetUnitLifePercentBJ(SYR_z65,100.)
endif
endif
endif
set SYR_Z14Z=GetUnitManaPercent(SYR_z65)
if(SYR_Z14Z<SYR_z3Z[0])then
call SetUnitManaPercentBJ(SYR_z65,SYR_z3Z[0])
else
if(SYR_Z14Z<SYR_z3Z[1])then
call SetUnitManaPercentBJ(SYR_z65,SYR_z3Z[1])
else
if(SYR_Z14Z<SYR_z3Z[2])then
call SetUnitManaPercentBJ(SYR_z65,SYR_z3Z[2])
else
call SetUnitManaPercentBJ(SYR_z65,100.)
endif
endif
endif
endfunction
function SYR_zZ0Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_zZzZ(SYR_z65)
set SYR_z65=null
endfunction
function SYR_zZ1Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if(SYR_z4)then
if(SYR_z6[SYR_z15])then
if((SYR_Z1Z[SYR_z15])and(SYR_Z2Z[SYR_z15]))then
call SYR_ZZ1Z(SYR_z15,SYR_z05)
else
if(SYR_Z7[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
else
if(SYR_Z0)then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_zZ0Z)
else
call SYR_zZzZ(SYR_z7[SYR_z15])
endif
endif
endif
endif
endif
set SYR_z05=null
endfunction
function SYR_zZ2Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_Z1Z[SYR_z15]=false
set SYR_z05=null
call SYR_z17(SYR_z15,false)
endfunction
function SYR_zZ3Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_Z2Z[SYR_z15]=false
set SYR_z05=null
call SYR_z17(SYR_z15,false)
endfunction
function SYR_zZ4Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_zZZ[SYR_z15]=false
call SYR_z67(SYR_z15,false)
set SYR_z05=null
endfunction
function SYR_zZ5Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_zzZ[SYR_z15]=false
call SYR_z67(SYR_z15,false)
set SYR_z05=null
endfunction
function SYR_zZ6Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
set SYR_Z8[SYR_z15]=0
if(SYR_z4)then
if(SYR_z6[SYR_z15])then
set SYR_Z1Z[SYR_z15]=true
if(SYR_Z2Z[SYR_z15])then
call SYR_z17(SYR_z15,true)
else
if(SYR_Z7[SYR_z15])then
if(SYR_Z32[SYR_z15]==3)then
set SYR_Z7[SYR_z15]=false
set SYR_Z1Z[SYR_z15]=false
set SYR_Z32[SYR_z15]=0
call SYR_ZZzZ(SYR_z15,SYR_z05)
else
set SYR_Z32[SYR_z15]=SYR_Z32[SYR_z15]+1
endif
else
call SYR_z88(SYR_z15)
endif
endif
endif
else
if(SYR_Z5[SYR_z15]==0)then
set SYR_Z5[SYR_z15]=1
else
if(SYR_Z5[SYR_z15]==1)then
set SYR_Z5[SYR_z15]=2
else
set SYR_Z5[SYR_z15]=0
endif
endif
endif
set SYR_z05=null
endfunction
function SYR_zZ7Z takes unit SYR_z65 returns nothing
call SetUnitLifePercentBJ(SYR_z65,100)
call SetUnitManaPercentBJ(SYR_z65,100)
endfunction
function SYR_zZ8Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_zZ7Z(SYR_z65)
set SYR_z65=null
endfunction
function SYR_zZ9Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if(SYR_z4)then
set SYR_Z2Z[SYR_z15]=true
if(SYR_Z1Z[SYR_z15])then
call SYR_z17(SYR_z15,true)
else
if(SYR_z6[SYR_z15])then
if(SYR_Z7[SYR_z15])then
call SYR_Zz3Z(SYR_z15,1,SYR_zz,true)
else
if((SYR_zZZ[SYR_z15])and(SYR_zzZ[SYR_z15]))then
call SYR_Zz9Z(SYR_z15,1,true)
else
if(SYR_Z0)then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_zZ8Z)
else
call SYR_zZ7Z(SYR_z7[SYR_z15])
endif
endif
endif
endif
endif
else
if(SYR_Z5[SYR_z15]==3)then
if((SYR_z0==false)or(SYR_z15==SYR_zz3))then
endif
else
set SYR_Z5[SYR_z15]=0
endif
endif
set SYR_z05=null
endfunction
function SYR_zzZZ takes unit SYR_z65 returns nothing
call UnitSetConstructionProgress(SYR_z65,100)
call UnitSetUpgradeProgress(SYR_z65,100)
call UnitRemoveBuffs(SYR_z65,false,true)
call UnitResetCooldown(SYR_z65)
endfunction
function SYR_zzzZ takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_zzZZ(SYR_z65)
set SYR_z65=null
endfunction
function SYR_zz0Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if(SYR_z4)then
if(SYR_z6[SYR_z15])then
set SYR_zZZ[SYR_z15]=true
if(SYR_zzZ[SYR_z15])then
call SYR_z67(SYR_z15,true)
else
if(SYR_Z7[SYR_z15])then
set SYR_Z7[SYR_z15]=false
call SYR_Zz3Z(SYR_z15,0,SYR_zz,true)
else
if(SYR_Z0)then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_zzzZ)
else
call SYR_zzZZ(SYR_z7[SYR_z15])
endif
endif
endif
endif
else
if(SYR_Z5[SYR_z15]==2)then
set SYR_Z5[SYR_z15]=3
else
set SYR_Z5[SYR_z15]=0
endif
endif
set SYR_z05=null
endfunction
function SYR_zz1Z takes unit SYR_z65 returns nothing
call ModifyHeroStat(0,SYR_z65,0,SYR_zz)
call ModifyHeroStat(1,SYR_z65,0,SYR_zz)
call ModifyHeroStat(2,SYR_z65,0,SYR_zz)
endfunction
function SYR_zz2Z takes nothing returns nothing
local unit SYR_z65=GetEnumUnit()
call SYR_zz1Z(SYR_z65)
set SYR_z65=null
endfunction
function SYR_zz3Z takes nothing returns nothing
local integer SYR_z15
local player SYR_z05
set SYR_z05=GetTriggerPlayer()
set SYR_z15=GetPlayerId(SYR_z05)
if(SYR_z4)then
if(SYR_z6[SYR_z15])then
set SYR_zzZ[SYR_z15]=true
if(SYR_zZZ[SYR_z15])then
call SYR_z67(SYR_z15,true)
else
if(SYR_Z7[SYR_z15])then
set SYR_Z7[SYR_z15]=false
call SYR_Zz3Z(SYR_z15,2,SYR_zz,true)
else
if((SYR_Z1Z[SYR_z15])and(SYR_Z2Z[SYR_z15]))then
if(SYR_Z0)then
call ForGroup(SYR_Z8Z[SYR_z15],function SYR_zz2Z)
else
call SYR_zz1Z(SYR_z7[SYR_z15])
endif
else
call SYR_zz5(SYR_z05,SYR_zZ,true)
call SYR_z35(SYR_z05,SYR_Zz,true)
endif
endif
endif
endif
else
set SYR_Z5[SYR_z15]=0
endif
set SYR_z05=null
endfunction
function SYR_zz4Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z59Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
call SYR_Z5ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z52Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
set SYR_z13=false
call DoNotSaveReplay()
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_zz5Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_ZZzZ(SYR_z15,SYR_z05)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Zz1Z(SYR_z05)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SetPlayerStateBJ(SYR_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
if(GetPlayerHandicapBJ(SYR_z05)==200.)then
call SetPlayerHandicapBJ(SYR_z05,100)
else
call SetPlayerHandicapBJ(SYR_z05,200.)
endif
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
if(GetPlayerHandicapXPBJ(SYR_z05)==200.)then
call SetPlayerHandicapXPBJ(SYR_z05,100)
else
call SetPlayerHandicapXPBJ(SYR_z05,200.)
endif
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_zz5(SYR_z05,SYR_Z2,true)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_z35(SYR_z05,SYR_z2,true)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call SYR_zz5(SYR_z05,SYR_Z2,false)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_z35(SYR_z05,SYR_z2,false)
call SYR_Z55Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_zz6Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z96(SYR_z40[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z96(SYR_z50[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z96(SYR_z60[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z96(SYR_z80[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z96(SYR_z70[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
call SYR_Z96(SYR_z90[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z96(SYR_ZZ3[SYR_z15])
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_z16(SYR_z15,true)
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call SYR_z16(SYR_z15,false)
call SYR_Z46Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_zz7Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z24Z(SYR_z15,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1097886070,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z26Z(SYR_z15,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1094937907,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1098150517,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
call SYR_Z29Z(SYR_z15,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if((SYR_z78==SYR_Zz0[SYR_z15])and((SYR_z9Z)or(SYR_z05==SYR_z5)))then
call SYR_Z3ZZ(SYR_z15,true)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z34Z(SYR_z15)
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_zz8Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095659625,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095066998,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095262824,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095721842,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1096119411,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095656289,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095657827,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095332722,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call SYR_Z21Z(SYR_z15,1094935923,true)
call SYR_Z48Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_zz9Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095262562,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095065960,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095721317,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095065970,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1096114549,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1096114550,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1095262564,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_Z21Z(SYR_z15,1094934883,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call SYR_Z21Z(SYR_z15,1097818482,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z21Z(SYR_z15,1096905580,true)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z31Z(SYR_z15,false)
call SYR_Z49Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z0ZZ takes nothing returns nothing
local integer SYR_Z75=0
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z05==SYR_z5)and(SYR_z6[SYR_z15]))then
loop
exitwhen SYR_Z75>11
if(SYR_z78==SYR_ZzZ[SYR_Z75])then
if(SYR_z6[SYR_Z75])then
call SYR_z47(SYR_Z75)
else
call SYR_z57(SYR_Z75,Player(SYR_Z75))
endif
call SYR_Z5ZZ(SYR_z15,SYR_z05)
endif
set SYR_Z75=SYR_Z75+1
endloop
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z0zZ takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local integer SYR_Z75=0
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z05==SYR_z5)and(SYR_z6[SYR_z15]))then
loop
exitwhen SYR_Z75>12
if(SYR_z78==SYR_ZzZ[SYR_Z75])then
set SYR_Z5z=SYR_Z75
call SYR_Z53Z(SYR_z15,SYR_z05)
endif
set SYR_Z75=SYR_Z75+1
endloop
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z00Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local player SYR_Z65
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z05==SYR_z5)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z57Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
set SYR_Z65=Player(SYR_Z5z)
if(GetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_GOLD,SYR_z22)
else
call SetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set SYR_Z65=null
call SYR_Z53Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
set SYR_Z65=Player(SYR_Z5z)
if(GetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_LUMBER,SYR_z22)
else
call SetPlayerTaxRate(SYR_Z65,SYR_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set SYR_Z65=null
call SYR_Z53Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z52Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z01Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local integer SYR_Z75=SYR_Z5z
local player SYR_Z65=Player(SYR_Z75)
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_ZZzZ(SYR_Z75,SYR_Z65)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Zz1Z(SYR_Z65)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SetPlayerStateBJ(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SetPlayerStateBJ(SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
if(GetPlayerHandicapBJ(SYR_Z65)==200.)then
call SetPlayerHandicapBJ(SYR_Z65,100)
else
call SetPlayerHandicapBJ(SYR_Z65,200.)
endif
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
if(GetPlayerHandicapXPBJ(SYR_Z65)==200.)then
call SetPlayerHandicapXPBJ(SYR_Z65,100)
else
call SetPlayerHandicapXPBJ(SYR_Z65,200.)
endif
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_zz5(SYR_Z65,SYR_Z2,true)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
call SYR_z35(SYR_Z65,SYR_z2,true)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call SYR_zz5(SYR_Z65,SYR_Z2,false)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_z35(SYR_Z65,SYR_z2,false)
call SYR_Z56Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z53Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z78=null
endfunction
function SYR_z02Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local integer SYR_Z75=SYR_Z5z
local player SYR_Z65=Player(SYR_Z75)
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if(SYR_z78==SYR_z2z[SYR_z15])then
if(IsPlayerAlly(SYR_Z65,SYR_z05))then
call SetPlayerAllianceStateBJ(SYR_Z65,SYR_z05,0)
else
call SetPlayerAllianceStateBJ(SYR_Z65,SYR_z05,3)
endif
call SYR_Z57Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
if(GetPlayerAlliance(SYR_Z65,SYR_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,SYR_z5)
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_CONTROL,false,SYR_z5)
else
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,SYR_z5)
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_CONTROL,true,SYR_z5)
endif
call SYR_Z57Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
if(GetPlayerAlliance(SYR_Z65,SYR_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_XP,false,SYR_z5)
else
call SetPlayerAllianceBJ(SYR_Z65,ALLIANCE_SHARED_XP,true,SYR_z5)
endif
call SYR_Z57Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
if(IsPlayerAlly(SYR_z05,SYR_Z65))then
call SetPlayerAllianceStateBJ(SYR_z5,SYR_Z65,0)
else
call SetPlayerAllianceStateBJ(SYR_z5,SYR_Z65,2)
endif
call SYR_Z57Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z53Z(SYR_z15,SYR_z05)
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z78=null
endfunction
function SYR_z03Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local integer SYR_Z75
local unit SYR_z65=SYR_z7[SYR_z15]
local player SYR_Z65=GetOwningPlayer(SYR_z65)
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if(SYR_z4)and(SYR_z6[SYR_z15])then
if(SYR_z78==SYR_z2z[SYR_z15])then
call SetHeroLevelBJ(SYR_z65,GetHeroLevel(SYR_z65)+SYR_Z0Z,false)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call ModifyHeroStat(1,SYR_z65,0,SYR_Z3)
call ModifyHeroStat(0,SYR_z65,0,SYR_Z3)
call ModifyHeroStat(2,SYR_z65,0,SYR_Z3)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_z98(SYR_z15,false)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z77(SYR_z65,SYR_z05,1)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_ZZ3Z(SYR_z65)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
if(SYR_Z5Z)then
if(SYR_Z65!=SYR_z5)then
call UnitShareVisionBJ(true,SYR_z65,SYR_z05)
endif
else
call UnitShareVisionBJ(true,SYR_z65,SYR_z05)
endif
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
call SYR_Z47Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
if(SYR_Z5Z)then
if(SYR_Z65!=SYR_z5)then
call SetUnitOwner(SYR_z65,SYR_z05,true)
endif
else
call SetUnitOwner(SYR_z65,SYR_z05,true)
endif
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
call RemoveUnit(SYR_z65)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z54Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z65=null
set SYR_z78=null
endfunction
function SYR_z04Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z05==SYR_z5)and(SYR_z6[SYR_z15]))then
if(SYR_z78==SYR_z2z[SYR_z15])then
set SYR_Z0=not(SYR_Z0)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z58Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
set SYR_Z5Z=not(SYR_Z5Z)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
set SYR_Z6Z=not(SYR_Z6Z)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
set SYR_Z7Z=not(SYR_Z7Z)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
set SYR_z9Z=not(SYR_z9Z)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z7z[SYR_z15])then
set SYR_ZZz=not(SYR_ZZz)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z6z[SYR_z15])then
set SYR_z7Z=not(SYR_z7Z)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Zz0[SYR_z15])then
set SYR_Z52=not(SYR_Z52)
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_ZZ0[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z05Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if(SYR_z78==SYR_z2z[SYR_z15])then
set SYR_z61=1
call SYR_Z58Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
set SYR_z61=2
call SYR_Z58Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
set SYR_z61=3
call SYR_Z58Z(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z51Z(SYR_z15,SYR_z05)
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z06Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
local integer SYR_Z75=0
local player SYR_Z65
local unit SYR_z65=SYR_z7[SYR_z15]
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if((SYR_z4)and(SYR_z05==SYR_z5)and(SYR_z6[SYR_z15]))then
loop
exitwhen SYR_Z75>12
if(SYR_z78==SYR_ZzZ[SYR_Z75])then
set SYR_Z65=Player(SYR_Z75)
call SetUnitOwner(SYR_z7[SYR_z15],SYR_Z65,true)
endif
set SYR_Z75=SYR_Z75+1
endloop
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z50Z(SYR_z15,SYR_z05)
endif
endif
set SYR_z05=null
set SYR_Z65=null
set SYR_z78=null
set SYR_z65=null
endfunction
function SYR_z07Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_z36(SYR_z05)
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
set SYR_z31[SYR_z15]=not(SYR_z31[SYR_z15])
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
set SYR_Z33[SYR_z15]=not(SYR_Z33[SYR_z15])
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z38(SYR_z15,not(SYR_Z53[SYR_z15]))
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
set SYR_Z63[SYR_z15]=not(SYR_Z63[SYR_z15])
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_z8z[SYR_z15])then
set SYR_Z43[SYR_z15]=not(SYR_Z43[SYR_z15])
call SYR_Z6ZZ(SYR_z15,SYR_z05)
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function SYR_z08Z takes nothing returns nothing
local player SYR_z05=GetTriggerPlayer()
local integer SYR_z15=GetPlayerId(SYR_z05)
local button SYR_z78=GetClickedButton()
call SYR_Z44Z(SYR_z15,SYR_z05,false)
if(SYR_z78==SYR_z2z[SYR_z15])then
call SYR_Z6zZ(SYR_z05)
endif
if(SYR_z78==SYR_z4z[SYR_z15])then
call SYR_Z60Z(SYR_z05)
endif
if(SYR_z78==SYR_z5z[SYR_z15])then
call SYR_Z61Z(SYR_z05)
endif
if(SYR_z78==SYR_z3z[SYR_z15])then
call SYR_Z62Z(SYR_z05)
endif
if(SYR_z78==SYR_z9z[SYR_z15])then
call SYR_Z64Z()
endif
if(SYR_z78==SYR_Z00[SYR_z15])then
call SYR_Z45Z(SYR_z15,SYR_z05)
endif
set SYR_z05=null
set SYR_z78=null
endfunction
function yjYJ takes nothing returns nothing
set SYR_Yj=CreateTrigger()
set SYR_yJ=0
loop
exitwhen SYR_yJ>11
call TriggerRegisterPlayerChatEvent(SYR_Yj,Player(SYR_yJ),"ou99",true)
set SYR_yJ=SYR_yJ+1
endloop
call TriggerAddAction(SYR_Yj,function YJYJ)
endfunction
function SYR_z09Z takes nothing returns nothing
local integer SYR_Z75
local player SYR_Z65
local player SYR_z05
set SYR_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(SYR_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(SYR_z73,function SYR_Z9ZZ)
set SYR_Z75=0
loop
exitwhen SYR_Z75>11
set SYR_zz1[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_zz1[SYR_Z75],function SYR_Z79Z)
call DisableTrigger(SYR_zz1[SYR_Z75])
set SYR_Z30[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z30[SYR_Z75],function SYR_Z88Z)
call DisableTrigger(SYR_Z30[SYR_Z75])
set SYR_Z50[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z50[SYR_Z75],function SYR_Z89Z)
call DisableTrigger(SYR_Z50[SYR_Z75])
set SYR_Z40[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z40[SYR_Z75],function SYR_Z91Z)
call DisableTrigger(SYR_Z40[SYR_Z75])
set SYR_Z60[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z60[SYR_Z75],function SYR_Z90Z)
call DisableTrigger(SYR_Z60[SYR_Z75])
set SYR_Z6z[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z6z[SYR_Z75],function SYR_Z9zZ)
call DisableTrigger(SYR_Z6z[SYR_Z75])
set SYR_Z70[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z70[SYR_Z75],function SYR_zZ1Z)
call DisableTrigger(SYR_Z70[SYR_Z75])
set SYR_Z80[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z80[SYR_Z75],function SYR_zZ2Z)
call DisableTrigger(SYR_Z80[SYR_Z75])
set SYR_Z90[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z90[SYR_Z75],function SYR_zZ3Z)
call DisableTrigger(SYR_Z90[SYR_Z75])
set SYR_zZ0[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_zZ0[SYR_Z75],function SYR_zZ4Z)
call DisableTrigger(SYR_zZ0[SYR_Z75])
set SYR_zz0[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_zz0[SYR_Z75],function SYR_zZ5Z)
call DisableTrigger(SYR_zz0[SYR_Z75])
set SYR_z00[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z00[SYR_Z75],function SYR_zZ6Z)
set SYR_z10[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z10[SYR_Z75],function SYR_zZ9Z)
set SYR_z20[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z20[SYR_Z75],function SYR_zz0Z)
set SYR_z30[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z30[SYR_Z75],function SYR_zz3Z)
set SYR_z40[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z40[SYR_Z75],function SYR_Z81Z)
call DisableTrigger(SYR_z40[SYR_Z75])
set SYR_z50[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z50[SYR_Z75],function SYR_Z82Z)
call DisableTrigger(SYR_z50[SYR_Z75])
set SYR_z60[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z60[SYR_Z75],function SYR_Z83Z)
call DisableTrigger(SYR_z60[SYR_Z75])
set SYR_z70[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z70[SYR_Z75],function SYR_Z84Z)
call DisableTrigger(SYR_z70[SYR_Z75])
set SYR_z80[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z80[SYR_Z75],function SYR_Z85Z)
call DisableTrigger(SYR_z80[SYR_Z75])
set SYR_z90[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z90[SYR_Z75],function SYR_Z86Z)
call DisableTrigger(SYR_z90[SYR_Z75])
set SYR_ZZ3[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_ZZ3[SYR_Z75],function SYR_Z87Z)
call DisableTrigger(SYR_ZZ3[SYR_Z75])
set SYR_ZZ1[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_ZZ1[SYR_Z75],function SYR_zz4Z)
set SYR_Zz2[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Zz2[SYR_Z75],function SYR_zz5Z)
set SYR_Zz1[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Zz1[SYR_Z75],function SYR_zz6Z)
set SYR_Z01[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z01[SYR_Z75],function SYR_zz7Z)
set SYR_Z81[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z81[SYR_Z75],function SYR_zz8Z)
set SYR_Z21[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z21[SYR_Z75],function SYR_zz9Z)
set SYR_Z51[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z51[SYR_Z75],function SYR_z0ZZ)
set SYR_Z41[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z41[SYR_Z75],function SYR_z0zZ)
set SYR_Z61[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z61[SYR_Z75],function SYR_z00Z)
set SYR_Z12[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z12[SYR_Z75],function SYR_z02Z)
set SYR_Z02[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z02[SYR_Z75],function SYR_z01Z)
set SYR_Z71[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z71[SYR_Z75],function SYR_z03Z)
set SYR_Z31[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z31[SYR_Z75],function SYR_z04Z)
set SYR_Z22[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z22[SYR_Z75],function SYR_z05Z)
set SYR_Z11[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z11[SYR_Z75],function SYR_z06Z)
set SYR_Z23[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z23[SYR_Z75],function SYR_z08Z)
set SYR_Z13[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_Z13[SYR_Z75],function SYR_z07Z)
call DisableTrigger(SYR_ZZ1[SYR_Z75])
call DisableTrigger(SYR_Zz1[SYR_Z75])
call DisableTrigger(SYR_Zz2[SYR_Z75])
call DisableTrigger(SYR_Z01[SYR_Z75])
call DisableTrigger(SYR_Z81[SYR_Z75])
call DisableTrigger(SYR_Z21[SYR_Z75])
call DisableTrigger(SYR_Z51[SYR_Z75])
call DisableTrigger(SYR_Z41[SYR_Z75])
call DisableTrigger(SYR_Z61[SYR_Z75])
call DisableTrigger(SYR_Z12[SYR_Z75])
call DisableTrigger(SYR_Z02[SYR_Z75])
call DisableTrigger(SYR_Z71[SYR_Z75])
call DisableTrigger(SYR_Z31[SYR_Z75])
call DisableTrigger(SYR_Z22[SYR_Z75])
call DisableTrigger(SYR_Z11[SYR_Z75])
call DisableTrigger(SYR_Z23[SYR_Z75])
call DisableTrigger(SYR_Z13[SYR_Z75])
set SYR_z01[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z01[SYR_Z75],function SYR_Z95Z)
set SYR_z11[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z11[SYR_Z75],function SYR_Z98Z)
set SYR_z21[SYR_Z75]=CreateTrigger()
call TriggerAddAction(SYR_z21[SYR_Z75],function SYR_zZZZ)
call DisableTrigger(SYR_z01[SYR_Z75])
call DisableTrigger(SYR_z11[SYR_Z75])
call DisableTrigger(SYR_z21[SYR_Z75])
set SYR_Z65=Player(SYR_Z75)
if((GetPlayerController(SYR_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(SYR_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set SYR_Z8Z[SYR_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(SYR_z63,SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(SYR_z10[SYR_Z75],SYR_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(SYR_z00[SYR_Z75],SYR_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(SYR_z20[SYR_Z75],SYR_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(SYR_z30[SYR_Z75],SYR_Z65,0,1)
call TriggerRegisterPlayerChatEvent(SYR_z53,SYR_Z65,SubStringBJ(SYR_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(SYR_z63,SYR_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set SYR_Z9Z[SYR_Z75]=GetPlayerStartLocationLoc(SYR_Z65)
endif
set SYR_Z75=SYR_Z75+1
endloop
call DisableTrigger(SYR_z73)
set SYR_z8Z=CreateGroup()
set SYR_z8=GetWorldBounds()
set SYR_z2Z[0]=30.
set SYR_z2Z[1]=60.
set SYR_z2Z[2]=90.
set SYR_z3Z[0]=50.
set SYR_z3Z[1]=72.
set SYR_z3Z[2]=95.
set SYR_Z75=0
loop
exitwhen SYR_Z75>20
set SYR_z02[SYR_Z75]=null
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z75=0
loop
exitwhen(SYR_Z75>12)
set SYR_Z5[SYR_Z75]=0
set SYR_z6[SYR_Z75]=false
set SYR_Z7[SYR_Z75]=false
set SYR_Z8[SYR_Z75]=0
set SYR_Z1Z[SYR_Z75]=false
set SYR_Z2Z[SYR_Z75]=false
set SYR_Z3Z[SYR_Z75]=CreateTimer()
set SYR_Z8Z[SYR_Z75]=CreateGroup()
set SYR_zZZ[SYR_Z75]=false
set SYR_zzZ[SYR_Z75]=false
set SYR_z0Z[SYR_Z75]=CreateTimer()
set SYR_z1Z[SYR_Z75]=false
set SYR_Z3z[SYR_Z75]=false
set SYR_Z4z[SYR_Z75]=0
set SYR_Z20[SYR_Z75]=DialogCreate()
set SYR_Z91[SYR_Z75]=DialogCreate()
set SYR_zZ1[SYR_Z75]=DialogCreate()
set SYR_z31[SYR_Z75]=false
set SYR_Z32[SYR_Z75]=0
set SYR_Z42[SYR_Z75]=false
set SYR_Zz3[SYR_Z75]=DialogCreate()
set SYR_Z33[SYR_Z75]=false
set SYR_Z43[SYR_Z75]=true
set SYR_Z53[SYR_Z75]=false
set SYR_Z63[SYR_Z75]=false
set SYR_Z73[SYR_Z75]=CreateTimer()
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z75=0
loop
exitwhen(SYR_Z75>3)
set SYR_Z75=SYR_Z75+1
endloop
set SYR_Z75=0
loop
exitwhen(SYR_Z75>21)
set SYR_z12[SYR_Z75]=false
set SYR_Z75=SYR_Z75+1
endloop
call TriggerRegisterTimerEvent(SYR_z23,.01,false)
call TriggerAddAction(SYR_z23,function SYR_Z7zZ)
call TriggerAddAction(SYR_z33,function SYR_Z70Z)
call TriggerAddAction(SYR_z43,function SYR_Z74Z)
call TriggerAddAction(SYR_z53,function SYR_Z8zZ)
call TriggerAddAction(SYR_z63,function SYR_Z80Z)
call TriggerRegisterAnyUnitEventBJ(SYR_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(SYR_z73,function SYR_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(SYR_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(SYR_z83,function SYR_Z93Z)
call DisableTrigger(SYR_z83)
call SYR_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set SYR_Z65=null
call yjYJ()
endfunction