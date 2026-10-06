function hso_Z64 takes real hso_Z74,location hso_Z84 returns group
set hso_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(hso_Z14,hso_Z84,hso_Z74,hso_Z34)
return hso_Z14
endfunction
function hso_Z94 takes player hso_zZ4 returns group
set hso_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(hso_Z14,hso_zZ4,hso_Z34)
return hso_Z14
endfunction
function hso_zz4 takes player hso_zZ4,integer hso_z04 returns group
set hso_Z14=CreateGroup()
set bj_groupEnumTypeId=hso_z04
call GroupEnumUnitsOfPlayer(hso_Z14,hso_zZ4,filterGetUnitsOfPlayerAndTypeId)
return hso_Z14
endfunction
function hso_z14 takes player hso_zZ4 returns force
set hso_Z24=CreateForce()
call ForceEnumAllies(hso_Z24,hso_zZ4,hso_Z34)
return hso_Z24
endfunction
function hso_z24 takes player hso_zZ4 returns force
set hso_Z24=CreateForce()
call ForceEnumEnemies(hso_Z24,hso_zZ4,hso_Z34)
return hso_Z24
endfunction
function hso_Z45 takes trigger hso_Z55,player hso_Z65,integer hso_Z75 returns nothing
local playerevent hso_Z85=ConvertPlayerEvent(hso_Z75)
call TriggerRegisterPlayerEvent(hso_Z55,hso_Z65,hso_Z85)
set hso_Z85=null
endfunction
function hso_Z95 takes trigger hso_Z55,player hso_Z65,integer hso_Z75 returns nothing
local playerunitevent hso_Z85=ConvertPlayerUnitEvent(hso_Z75)
call TriggerRegisterPlayerUnitEvent(hso_Z55,hso_Z65,hso_Z85,null)
set hso_Z85=null
endfunction
function hso_zZ5 takes integer hso_Z75,player hso_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(hso_Z30[hso_Z75],hso_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(hso_Z50[hso_Z75],hso_Z65,ConvertPlayerUnitEvent(25),null)
call hso_Z45(hso_Z70[hso_Z75],hso_Z65,17)
call hso_Z45(hso_Z90[hso_Z75],hso_Z65,266)
call hso_Z45(hso_Z80[hso_Z75],hso_Z65,268)
call hso_Z45(hso_zZ0[hso_Z75],hso_Z65,262)
call hso_Z45(hso_zz0[hso_Z75],hso_Z65,264)
call TriggerRegisterTimerExpireEvent(hso_z43,hso_z0Z[hso_Z75])
call TriggerRegisterTimerExpireEvent(hso_z33,hso_Z73[hso_Z75])
call hso_Z95(hso_Z40[hso_Z75],hso_Z65,32)
call hso_Z95(hso_Z60[hso_Z75],hso_Z65,35)
call TriggerRegisterDialogEvent(hso_ZZ1[hso_Z75],hso_zZ1[hso_Z75])
call TriggerRegisterDialogEvent(hso_Zz2[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Zz1[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z01[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z81[hso_Z75],hso_Z91[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z71[hso_Z75],hso_zZ1[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z21[hso_Z75],hso_Z91[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z31[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z22[hso_Z75],hso_Z91[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z11[hso_Z75],hso_Z91[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z51[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z41[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z61[hso_Z75],hso_Z91[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z12[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z02[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z23[hso_Z75],hso_Z20[hso_Z75])
call TriggerRegisterDialogEvent(hso_Z13[hso_Z75],hso_Z20[hso_Z75])
call hso_Z95(hso_z01[hso_Z75],hso_Z65,38)
call hso_Z95(hso_z11[hso_Z75],hso_Z65,39)
call hso_Z95(hso_z21[hso_Z75],hso_Z65,40)
call hso_Z95(hso_z80[hso_Z75],hso_Z65,276)
call hso_Z95(hso_z80[hso_Z75],hso_Z65,275)
call hso_Z95(hso_z90[hso_Z75],hso_Z65,276)
call hso_Z95(hso_z90[hso_Z75],hso_Z65,275)
call hso_Z95(hso_ZZ3[hso_Z75],hso_Z65,18)
call TriggerRegisterPlayerStateEvent(hso_z60[hso_Z75],hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hso_z40[hso_Z75],hso_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hso_z50[hso_Z75],hso_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call hso_Z95(hso_z70[hso_Z75],hso_Z65,20)
call TriggerRegisterPlayerChatEvent(hso_zz1[hso_Z75],hso_Z65,"-",false)
call hso_Z95(hso_Z6z[hso_Z75],hso_Z65,39)
set hso_Z3z[hso_Z75]=true
endfunction
function hso_zz5 takes player hso_z05,integer hso_z15,boolean hso_z25 returns nothing
if(hso_z25)then
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_GOLD)+hso_z15)
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(hso_z05,PLAYER_STATE_GOLD_GATHERED)-hso_z15)
else
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_GOLD)-hso_z15)
endif
endfunction
function hso_z35 takes player hso_z05,integer hso_z15,boolean hso_z25 returns nothing
if(hso_z25)then
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_LUMBER)+hso_z15)
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(hso_z05,PLAYER_STATE_LUMBER_GATHERED)-hso_z15)
else
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_LUMBER)-hso_z15)
endif
endfunction
function hso_z45 takes player hso_z05 returns nothing
local player hso_Z65=GetLocalPlayer()
if hso_z05==hso_Z65 then
set hso_Z65=Player(-1)
endif
set hso_Z65=null
endfunction
function hso_z55 takes unit hso_z65,unit hso_z75,boolean hso_z85 returns nothing
local location hso_z95
local location hso_ZZ6
set hso_z95=GetUnitLoc(hso_z65)
set hso_ZZ6=GetUnitLoc(hso_z75)
call SetUnitPositionLoc(hso_z65,hso_ZZ6)
if(hso_z85)then
call SetUnitPositionLoc(hso_z75,hso_z95)
call SetUnitPositionLoc(hso_z65,hso_ZZ6)
endif
call RemoveLocation(hso_z95)
call RemoveLocation(hso_ZZ6)
set hso_z95=null
set hso_ZZ6=null
endfunction
function hso_Zz6 takes integer hso_Z06 returns nothing
if(hso_Z06==0)then
set hso_zZ2=100
set hso_Z92=100
set hso_Z82=100
set hso_Z72="|cFFFFFFFF"
return
endif
if(hso_Z06==1)then
set hso_zZ2=50
set hso_Z92=50
set hso_Z82=50
set hso_Z72="|cFF7F7F7F"
return
endif
if(hso_Z06==2)then
set hso_zZ2=0
set hso_Z92=0
set hso_Z82=0
set hso_Z72="|cFF000000"
return
endif
if(hso_Z06==3)then
set hso_zZ2=100
set hso_Z92=0
set hso_Z82=0
set hso_Z72="|cFFFF0000"
return
endif
if(hso_Z06==4)then
set hso_zZ2=100
set hso_Z92=50
set hso_Z82=0
set hso_Z72="|cFFFF7F00"
return
endif
if(hso_Z06==5)then
set hso_zZ2=100
set hso_Z92=100
set hso_Z82=0
set hso_Z72="|cFFFFFF00"
return
endif
if(hso_Z06==6)then
set hso_zZ2=0
set hso_Z92=100
set hso_Z82=0
set hso_Z72="|cFF00FF00"
return
endif
if(hso_Z06==7)then
set hso_zZ2=0
set hso_Z92=100
set hso_Z82=100
set hso_Z72="|cFF00FFFF"
return
endif
if(hso_Z06==8)then
set hso_zZ2=0
set hso_Z92=0
set hso_Z82=100
set hso_Z72="|cFF0000FF"
return
endif
if(hso_Z06==9)then
set hso_zZ2=100
set hso_Z92=0
set hso_Z82=100
set hso_Z72="|cFFFF00FF"
return
endif
endfunction
function hso_Z16 takes integer hso_Z06,unit hso_Z26,string hso_Z36 returns nothing
local texttag hso_Z46
local location hso_z95
call hso_Zz6(hso_Z06)
set hso_z95=GetUnitLoc(hso_Z26)
set hso_Z46=CreateTextTagLocBJ(hso_Z36,hso_z95,0,20,hso_zZ2,hso_Z92,hso_Z82,0)
call RemoveLocation(hso_z95)
set hso_z95=null
call SetTextTagPermanent(hso_Z46,false)
call SetTextTagLifespan(hso_Z46,hso_Z1)
set hso_Z46=null
endfunction
function hso_Z56 takes nothing returns nothing
local trigger hso_Z66=GetTriggeringTrigger()
local timer hso_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(hso_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(hso_z52)
call DestroyTimerDialog(hso_z82)
call DestroyTimer(hso_Z76)
set hso_Z66=null
set hso_Z76=null
endfunction
function hso_Z86 takes nothing returns nothing
local timer hso_Z76
local trigger hso_Z66
if(hso_z62)then
else
set hso_z52=GetGameSpeed()
set hso_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set hso_Z66=CreateTrigger()
set hso_Z76=CreateTimer()
call StartTimerBJ(hso_Z76,false,hso_z42)
set hso_z82=CreateTimerDialogBJ(hso_Z76,"子弹时间")
call TriggerAddAction(hso_Z66,function hso_Z56)
call TriggerRegisterTimerExpireEvent(hso_Z66,hso_Z76)
endif
endfunction
function hso_Z96 takes trigger hso_zZ6 returns nothing
if(IsTriggerEnabled(hso_zZ6))then
call DisableTrigger(hso_zZ6)
else
call EnableTrigger(hso_zZ6)
endif
endfunction
function hso_zz6 takes trigger hso_zZ6,boolean hso_z06 returns nothing
if(IsTriggerEnabled(hso_zZ6)==hso_z06)then
else
call hso_Z96(hso_zZ6)
endif
endfunction
function hso_z16 takes integer hso_z15,boolean hso_z25 returns nothing
call hso_zz6(hso_z40[hso_z15],hso_z25)
call hso_zz6(hso_z50[hso_z15],hso_z25)
call hso_zz6(hso_z60[hso_z15],hso_z25)
call hso_zz6(hso_z80[hso_z15],hso_z25)
call hso_zz6(hso_z70[hso_z15],hso_z25)
call hso_zz6(hso_z90[hso_z15],hso_z25)
call hso_zz6(hso_ZZ3[hso_z15],hso_z25)
endfunction
function hso_z26 takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
if(GetUnitUserData(hso_z65)==2176)then
call RemoveUnit(hso_z65)
endif
set hso_z65=null
endfunction
function hso_z36 takes player hso_z05 returns nothing
local group hso_z46
if(hso_Z42[GetPlayerId(hso_z05)])then
set hso_z46=hso_Z94(hso_z05)
call ForGroup(hso_z46,function hso_z26)
set hso_Z42[GetPlayerId(hso_z05)]=false
call DestroyGroup(hso_z46)
set hso_z46=null
endif
endfunction
function hso_z56 takes unit hso_z65,player hso_z05 returns nothing
local location hso_z95
local integer hso_z66
local unit hso_z76
local item hso_z86
local integer hso_Z75=0
if(IsUnitType(hso_z65,UNIT_TYPE_HERO))then
set hso_z95=GetUnitLoc(hso_z65)
set hso_z66=GetUnitTypeId(hso_z65)
set hso_z76=CreateUnitAtLoc(hso_z05,hso_z66,hso_z95,bj_UNIT_FACING)
call SetUnitUserData(hso_z76,2176)
set hso_Z42[GetPlayerId(hso_z05)]=true
if(hso_Z6Z)then
call SetUnitUseFood(hso_z76,false)
endif
call SetHeroLevelBJ(hso_z76,GetHeroLevel(hso_z65),false)
call SetHeroStat(hso_z76,0,GetHeroStatBJ(0,hso_z65,false))
call SetHeroStat(hso_z76,1,GetHeroStatBJ(1,hso_z65,false))
call SetHeroStat(hso_z76,2,GetHeroStatBJ(2,hso_z65,false))
loop
exitwhen hso_Z75>5
set hso_z86=UnitItemInSlot(hso_z65,hso_Z75)
call UnitAddItemById(hso_z76,GetItemTypeId(hso_z86))
set hso_Z75=hso_Z75+1
endloop
endif
call RemoveLocation(hso_z95)
set hso_z95=null
set hso_z76=null
set hso_z86=null
endfunction
function hso_z96 takes integer hso_ZZ7,player hso_Zz7,location hso_Z07,boolean hso_Z17,boolean hso_Z27 returns nothing
local unit hso_z76
set hso_z76=CreateUnitAtLoc(hso_Zz7,hso_ZZ7,hso_Z07,bj_UNIT_FACING)
if(hso_Z6Z)then
call SetUnitUseFood(hso_z76,false)
endif
if(hso_Z17)then
call SetUnitUserData(hso_z76,2176)
endif
if(hso_Z27)then
call UnitApplyTimedLife(hso_z76,1112820806,90)
endif
set hso_z76=null
endfunction
function hso_Z37 takes integer hso_ZZ7,player hso_Zz7,location hso_Z07 returns nothing
local unit hso_z76
set hso_z76=CreateUnitAtLoc(hso_Zz7,hso_ZZ7,hso_Z07,bj_UNIT_FACING)
if(hso_Z6Z)then
call SetUnitUseFood(hso_z76,false)
set hso_z76=null
endif
endfunction
function hso_Z47 takes unit hso_Z57,player hso_Zz7,integer hso_Z67,boolean hso_Z27 returns nothing
local location hso_z95
local integer hso_z66
local integer hso_Z75
set hso_z95=GetUnitLoc(hso_Z57)
set hso_z66=GetUnitTypeId(hso_Z57)
set hso_Z75=1
loop
exitwhen hso_Z75>hso_Z67
call hso_z96(hso_z66,hso_Zz7,hso_z95,true,hso_Z27)
set hso_Z75=hso_Z75+1
endloop
call RemoveLocation(hso_z95)
set hso_Z42[GetPlayerId(hso_Zz7)]=true
set hso_z95=null
endfunction
function hso_Z77 takes unit hso_Z57,player hso_Zz7,integer hso_Z67 returns nothing
call hso_Z47(hso_Z57,hso_Zz7,hso_Z67,false)
endfunction
function hso_Z87 takes unit hso_z65,integer hso_z15,boolean hso_Z97 returns nothing
local integer hso_Z75
set hso_Z75=GetResourceAmount(hso_z65)
if(hso_Z97)then
set hso_Z75=hso_Z75+hso_z15
else
set hso_Z75=hso_Z75-hso_z15
endif
if(hso_Z75<0)then
if(hso_Z97)then
set hso_Z75=GetResourceAmount(hso_z65)
else
set hso_Z75=0
endif
endif
call SetResourceAmount(hso_z65,hso_Z75)
endfunction
function hso_zZ7 takes integer hso_z15,player hso_z05,boolean hso_zz7 returns nothing
if(hso_zz7)then
call SetPlayerTechMaxAllowed(hso_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(hso_z05,1212502607,3)
endif
endfunction
function hso_z07 takes integer hso_z15,boolean hso_z06 returns nothing
if(hso_z06)then
call EnableTrigger(hso_z00[hso_z15])
call EnableTrigger(hso_z10[hso_z15])
call EnableTrigger(hso_z20[hso_z15])
call EnableTrigger(hso_z30[hso_z15])
call EnableTrigger(hso_Z70[hso_z15])
call EnableTrigger(hso_Z80[hso_z15])
call EnableTrigger(hso_Z90[hso_z15])
call EnableTrigger(hso_zZ0[hso_z15])
call EnableTrigger(hso_zz0[hso_z15])
else
call DisableTrigger(hso_z00[hso_z15])
call DisableTrigger(hso_z10[hso_z15])
call DisableTrigger(hso_z20[hso_z15])
call DisableTrigger(hso_z30[hso_z15])
call DisableTrigger(hso_Z70[hso_z15])
call DisableTrigger(hso_Z80[hso_z15])
call DisableTrigger(hso_Z90[hso_z15])
call DisableTrigger(hso_zZ0[hso_z15])
call DisableTrigger(hso_zz0[hso_z15])
endif
endfunction
function hso_z17 takes integer hso_z15,boolean hso_z27 returns nothing
if(hso_z27)then
call EnableTrigger(hso_Z40[hso_z15])
call EnableTrigger(hso_Z60[hso_z15])
call EnableTrigger(hso_Z6z[hso_z15])
else
call DisableTrigger(hso_Z40[hso_z15])
call DisableTrigger(hso_Z60[hso_z15])
call DisableTrigger(hso_Z6z[hso_z15])
endif
endfunction
function hso_z37 takes nothing returns nothing
local integer hso_z15
set hso_z15=0
loop
exitwhen hso_z15>11
call hso_z07(hso_z15,false)
set hso_z15=hso_z15+1
endloop
endfunction
function hso_z47 takes integer hso_z15 returns nothing
set hso_z6[hso_z15]=false
call GroupClear(hso_Z8Z[hso_z15])
if(hso_Z7Z)then
call DestroyFogModifier(hso_Z6[hso_z15])
endif
call DisableTrigger(hso_Z30[hso_z15])
call DisableTrigger(hso_Z50[hso_z15])
call DisableTrigger(hso_zz1[hso_z15])
call DisableTrigger(hso_z40[hso_z15])
call DisableTrigger(hso_z50[hso_z15])
call DisableTrigger(hso_z60[hso_z15])
call DisableTrigger(hso_z70[hso_z15])
call DisableTrigger(hso_z80[hso_z15])
call DisableTrigger(hso_z90[hso_z15])
call DisableTrigger(hso_ZZ3[hso_z15])
call DisableTrigger(hso_ZZ1[hso_z15])
call DisableTrigger(hso_Zz1[hso_z15])
call DisableTrigger(hso_Zz2[hso_z15])
call DisableTrigger(hso_Z01[hso_z15])
call DisableTrigger(hso_Z81[hso_z15])
call DisableTrigger(hso_Z21[hso_z15])
call DisableTrigger(hso_Z51[hso_z15])
call DisableTrigger(hso_Z41[hso_z15])
call DisableTrigger(hso_Z61[hso_z15])
call DisableTrigger(hso_Z12[hso_z15])
call DisableTrigger(hso_Z02[hso_z15])
call DisableTrigger(hso_Z71[hso_z15])
call DisableTrigger(hso_Z31[hso_z15])
call DisableTrigger(hso_Z22[hso_z15])
call DisableTrigger(hso_Z11[hso_z15])
call DisableTrigger(hso_Z23[hso_z15])
call DisableTrigger(hso_Z13[hso_z15])
call DisableTrigger(hso_zZ3[hso_z15])
call DisableTrigger(hso_Z40[hso_z15])
call DisableTrigger(hso_Z60[hso_z15])
call DisableTrigger(hso_Z6z[hso_z15])
call hso_z07(hso_z15,false)
endfunction
function hso_z57 takes integer hso_z15,player hso_z05 returns nothing
set hso_z6[hso_z15]=true
if(hso_Z3z[hso_z15])then
else
call hso_zZ5(hso_z15,hso_z05)
endif
call EnableTrigger(hso_Z30[hso_z15])
call EnableTrigger(hso_Z50[hso_z15])
call EnableTrigger(hso_zz1[hso_z15])
call hso_z07(hso_z15,true)
endfunction
function hso_z67 takes integer hso_z15,boolean hso_z77 returns nothing
if(hso_z77)then
if((hso_zZZ[hso_z15])and(hso_zzZ[hso_z15])and(hso_z31[hso_z15]))then
call EnableTrigger(hso_z01[hso_z15])
call EnableTrigger(hso_z11[hso_z15])
call EnableTrigger(hso_z21[hso_z15])
endif
else
call DisableTrigger(hso_z01[hso_z15])
call DisableTrigger(hso_z11[hso_z15])
call DisableTrigger(hso_z21[hso_z15])
endif
endfunction
function hso_z87 takes integer hso_Z06 returns nothing
if(hso_Z06==0)then
set hso_zz2=0
return
endif
if(hso_Z06==1)then
set hso_zz2=10
return
endif
if(hso_Z06==2)then
set hso_zz2=15
return
endif
if(hso_Z06==3)then
set hso_zz2=20
return
endif
if(hso_Z06==4)then
set hso_zz2=40
return
endif
if(hso_Z06==5)then
set hso_zz2=50
return
endif
if(hso_Z06==6)then
set hso_zz2=70
return
endif
if(hso_Z06==7)then
set hso_zz2=80
return
endif
if(hso_Z06==8)then
set hso_zz2=90
return
endif
if(hso_Z06==9)then
set hso_zz2=100
return
endif
endfunction
function hso_z97 takes unit hso_z65,integer hso_ZZ8,integer hso_Zz8 returns nothing
call hso_z87(hso_Zz8)
call hso_Zz6(hso_ZZ8)
call SetUnitVertexColorBJ(hso_z65,hso_zZ2,hso_Z92,hso_Z82,hso_zz2)
endfunction
function hso_Z08 takes integer hso_ZZ8,integer hso_Zz8 returns nothing
call hso_z87(hso_Zz8)
call hso_Zz6(hso_ZZ8)
call SetWaterBaseColorBJ(hso_zZ2,hso_Z92,hso_Z82,hso_zz2)
endfunction
function hso_Z18 takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call hso_z97(hso_z65,GetRandomInt(3,9),0)
set hso_z65=null
endfunction
function hso_Z28 takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call hso_z97(hso_z65,0,0)
set hso_z65=null
endfunction
function hso_Z38 takes integer hso_z15,boolean hso_z77 returns nothing
local integer hso_Z75
local integer hso_Z48
if(hso_Z53[hso_z15]==hso_z77)then
else
set hso_Z53[hso_z15]=hso_z77
if(hso_z77)then
call EnableTrigger(hso_z83)
else
set hso_Z75=0
set hso_Z48=0
loop
exitwhen hso_Z75>11
if(hso_Z53[hso_Z75])then
set hso_Z48=hso_Z48+1
endif
set hso_Z75=hso_Z75+1
endloop
if(hso_Z48==0)then
call DisableTrigger(hso_z83)
endif
endif
endif
endfunction
function hso_Z58 takes integer hso_Z68 returns nothing
if(hso_Z68==0)then
call SetSkyModel(null)
return
endif
if(hso_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(hso_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(hso_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(hso_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(hso_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(hso_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(hso_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(hso_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(hso_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(hso_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(hso_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(hso_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(hso_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function hso_Z78 takes integer hso_Z88 returns integer
if(hso_Z88==0)then
return 1380018290
endif
if(hso_Z88==1)then
return 1380019314
endif
if(hso_Z88==2)then
return 1296393331
endif
if(hso_Z88==3)then
return 1178886760
endif
if(hso_Z88==4)then
return 1178886764
endif
if(hso_Z88==5)then
return 1178888040
endif
if(hso_Z88==6)then
return 1178888044
endif
if(hso_Z88==7)then
return 1178890856
endif
if(hso_Z88==8)then
return 1178890860
endif
if(hso_Z88==9)then
return 1178892136
endif
if(hso_Z88==10)then
return 1178892140
endif
if(hso_Z88==11)then
return 1380739186
endif
if(hso_Z88==12)then
return 1380740210
endif
if(hso_Z88==13)then
return 1397645939
endif
if(hso_Z88==14)then
return 1397647475
endif
if(hso_Z88==15)then
return 1397648499
endif
if(hso_Z88==16)then
return 1464820599
endif
if(hso_Z88==17)then
return 1464822903
endif
if(hso_Z88==18)then
return 1280467297
endif
if(hso_Z88==19)then
return 1280470369
endif
if(hso_Z88==20)then
return 1464755063
endif
return 0
endfunction
function hso_Z98 takes integer hso_Z88,boolean hso_z77 returns nothing
set hso_Z88=hso_Z88-1
if(hso_z77)then
if(hso_z12[hso_Z88]==false)then
if(hso_Z78(hso_Z88)==0)then
else
set hso_z02[hso_Z88]=AddWeatherEffect(hso_z8,hso_Z78(hso_Z88))
call EnableWeatherEffect(hso_z02[hso_Z88],true)
set hso_z12[hso_Z88]=true
endif
endif
else
if(hso_z02[hso_Z88]==null)then
else
call EnableWeatherEffect(hso_z02[hso_Z88],false)
call RemoveWeatherEffect(hso_z02[hso_Z88])
set hso_z12[hso_Z88]=false
set hso_z02[hso_Z88]=null
endif
endif
endfunction
function hso_zZ8 takes nothing returns nothing
local integer hso_z15=1
loop
exitwhen hso_z15>21
call hso_Z98(hso_z15,false)
set hso_z15=hso_z15+1
endloop
endfunction
function hso_zz8 takes integer hso_z08 returns integer
if(hso_z08==0)then
return 1280601204
endif
if(hso_z08==1)then
return 1179939959
endif
if(hso_z08==2)then
return 1465152631
endif
if(hso_z08==3)then
return 1096053874
endif
if(hso_z08==4)then
return 1096053859
endif
if(hso_z08==5)then
return 1112831095
endif
if(hso_z08==6)then
return 1263826039
endif
if(hso_z08==7)then
return 1498707828
endif
if(hso_z08==8)then
return 1498702708
endif
if(hso_z08==9)then
return 1498703476
endif
if(hso_z08==10)then
return 1498706804
endif
if(hso_z08==11)then
return 1247044468
endif
if(hso_z08==12)then
return 1247048823
endif
if(hso_z08==13)then
return 1146385256
endif
if(hso_z08==14)then
return 1129608306
endif
if(hso_z08==15)then
return 1129608291
endif
if(hso_z08==16)then
return 1230271607
endif
if(hso_z08==17)then
return 1230271607
endif
if(hso_z08==18)then
return 1314157667
endif
if(hso_z08==19)then
return 1330934903
endif
if(hso_z08==20)then
return 1515484279
endif
if(hso_z08==21)then
return 1196716904
endif
if(hso_z08==22)then
return 1448373364
endif
if(hso_z08==23)then
return 1448373364
endif
return 0
endfunction
function hso_z18 takes nothing returns integer
return hso_zz8(GetRandomInt(0,23))
endfunction
function hso_z28 takes unit hso_z65,integer hso_z38,integer hso_z08,integer hso_z48 returns nothing
local real hso_z58
local real hso_z68
local real hso_z15=0
local boolean hso_z78=true
set hso_z58=GetUnitX(hso_z65)
set hso_z68=GetUnitY(hso_z65)
if(hso_z38==1)then
loop
exitwhen hso_z15==hso_z48
if(hso_z78)then
call CreateDestructable(hso_z08,hso_z58,hso_z68+hso_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hso_z08,hso_z58,hso_z68-hso_z15*40,GetRandomReal(0,360),1,0)
endif
set hso_z78=not(hso_z78)
set hso_z15=hso_z15+1
endloop
endif
if(hso_z38==2)then
loop
exitwhen hso_z15==hso_z48
if(hso_z78)then
call CreateDestructable(hso_z08,hso_z58+hso_z15*40,hso_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hso_z08,hso_z58-hso_z15*40,hso_z68,GetRandomReal(0,360),1,0)
endif
set hso_z78=not(hso_z78)
set hso_z15=hso_z15+1
endloop
endif
if(hso_z38==3)then
loop
exitwhen hso_z15==hso_z48
if(hso_z78)then
call CreateDestructable(hso_z08,hso_z58+hso_z15*40,hso_z68+hso_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hso_z08,hso_z58-hso_z15*40,hso_z68-hso_z15*40,GetRandomReal(0,360),1,0)
endif
set hso_z78=not(hso_z78)
set hso_z15=hso_z15+1
endloop
endif
if(hso_z38==4)then
loop
exitwhen hso_z15==hso_z48
if(hso_z78)then
call CreateDestructable(hso_z08,hso_z58+hso_z15*40,hso_z68-hso_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hso_z08,hso_z58-hso_z15*40,hso_z68+hso_z15*40,GetRandomReal(0,360),1,0)
endif
set hso_z78=not(hso_z78)
set hso_z15=hso_z15+1
endloop
endif
endfunction
function hso_z88 takes integer hso_z15 returns nothing
set hso_Z7[hso_z15]=true
call StartTimerBJ(hso_z0Z[hso_z15],false,2.)
endfunction
function hso_z98 takes integer hso_z15,boolean hso_ZZZZ returns nothing
local integer hso_Z75
local integer hso_z76
local item hso_z86
local location hso_z95
local unit hso_z65
set hso_z65=hso_z7[hso_z15]
set hso_z76=1
loop
exitwhen hso_z76>6
if(hso_ZZZZ)then
set hso_z95=GetUnitLoc(hso_z51[hso_z15])
else
set hso_z95=GetUnitLoc(hso_z65)
endif
set hso_z86=UnitItemInSlotBJ(hso_z65,hso_z76)
if(GetItemCharges(hso_z86)>0)then
set hso_Z75=GetItemCharges(hso_z86)
set hso_z86=CreateItemLoc(GetItemTypeId(hso_z86),hso_z95)
call SetItemCharges(hso_z86,hso_Z75)
else
call CreateItemLoc(GetItemTypeId(hso_z86),hso_z95)
endif
call RemoveLocation(hso_z95)
set hso_z76=hso_z76+1
endloop
set hso_z65=null
set hso_z95=null
set hso_z86=null
endfunction
function hso_ZZzZ takes integer hso_z15,player hso_z05 returns nothing
local integer hso_Z75
local force hso_ZZ0Z
local player hso_Z65
if(hso_z1Z[hso_z15])then
call DestroyFogModifier(hso_Z6[hso_z15])
set hso_z1Z[hso_z15]=false
else
set hso_ZZ0Z=CreateForce()
set hso_Z75=0
loop
exitwhen hso_Z75>11
set hso_Z65=Player(hso_Z75)
if(GetPlayerAlliance(hso_z05,hso_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(hso_ZZ0Z,hso_Z65)
call SetPlayerAlliance(hso_z05,hso_Z65,ALLIANCE_SHARED_VISION,false)
endif
set hso_Z75=hso_Z75+1
endloop
set hso_Z6[hso_z15]=CreateFogModifierRect(hso_z05,FOG_OF_WAR_VISIBLE,hso_z8,false,false)
call FogModifierStart(hso_Z6[hso_z15])
set hso_z1Z[hso_z15]=true
set hso_Z75=0
loop
exitwhen hso_Z75>11
set hso_Z65=Player(hso_Z75)
if(IsPlayerInForce(hso_Z65,hso_ZZ0Z))then
call SetPlayerAlliance(hso_z05,hso_Z65,ALLIANCE_SHARED_VISION,true)
endif
set hso_Z75=hso_Z75+1
endloop
call DestroyForce(hso_ZZ0Z)
set hso_ZZ0Z=null
set hso_Z65=null
endif
endfunction
function hso_ZZ1Z takes integer hso_z15,player hso_z05 returns nothing
local integer hso_Z75
local unit hso_z65
local item hso_z86
local item array hso_ZZ2Z
set hso_z65=FirstOfGroup(hso_Z8Z[hso_z15])
if((hso_z05==GetOwningPlayer(hso_z65))and(UnitInventorySizeBJ(hso_z65)>0))then
set hso_Z75=1
loop
exitwhen hso_Z75>6
set hso_z86=UnitItemInSlotBJ(hso_z65,hso_Z75)
set hso_ZZ2Z[(hso_Z75-1)]=hso_z86
call UnitRemoveItemSwapped(hso_z86,hso_z65)
call SetItemVisible(hso_z86,false)
set hso_Z75=hso_Z75+1
endloop
set hso_Z75=1
loop
exitwhen hso_Z75>6
set hso_z86=hso_Z2z[(hso_z15*18)+(hso_Z4z[hso_z15]*6)+(hso_Z75-1)]
call UnitAddItem(hso_z65,hso_z86)
set hso_Z2z[(hso_z15*18)+(hso_Z4z[hso_z15]*6)+(hso_Z75-1)]=hso_ZZ2Z[(hso_Z75-1)]
set hso_ZZ2Z[(hso_Z75-1)]=null
set hso_Z75=hso_Z75+1
endloop
if(hso_Z4z[hso_z15]==0)then
set hso_Z4z[hso_z15]=hso_z61-1
else
set hso_Z4z[hso_z15]=(hso_Z4z[hso_z15]-1)
endif
set hso_z86=null
endif
set hso_z65=null
set hso_z05=null
endfunction
function hso_ZZ3Z takes unit hso_z65 returns nothing
local integer hso_Z75
local item hso_z86
set hso_Z75=1
loop
exitwhen hso_Z75>6
set hso_z86=UnitItemInSlotBJ(hso_z65,hso_Z75)
call UnitRemoveItemSwapped(hso_z86,hso_z65)
set hso_Z75=hso_Z75+1
endloop
set hso_z86=null
endfunction
function hso_ZZ4Z takes integer hso_z15 returns nothing
local integer hso_Z75
local item hso_z86
local location hso_z95
set hso_z95=GetUnitLoc(hso_z51[hso_z15])
set hso_Z75=1
loop
exitwhen hso_Z75>6
set hso_z86=UnitItemInSlotBJ(hso_z7[hso_z15],hso_Z75)
call UnitRemoveItemSwapped(hso_z86,hso_z7[hso_z15])
call SetItemPositionLoc(hso_z86,hso_z95)
set hso_Z75=hso_Z75+1
endloop
call RemoveLocation(hso_z95)
set hso_z86=null
set hso_z95=null
endfunction
function hso_ZZ5Z takes integer hso_z15 returns nothing
local integer hso_z76
local integer hso_z78
local unit hso_z65
local item hso_Z66
local item hso_ZZ6Z
set hso_z65=FirstOfGroup(hso_Z8Z[hso_z15])
set hso_z76=1
loop
exitwhen hso_z76>5
set hso_Z66=UnitItemInSlotBJ(hso_z65,hso_z76)
if(GetItemCharges(hso_Z66)>0)then
set hso_z78=hso_z76+1
loop
exitwhen hso_z78>6
set hso_ZZ6Z=UnitItemInSlotBJ(hso_z65,hso_z78)
if(GetItemTypeId(hso_Z66)==GetItemTypeId(hso_ZZ6Z))then
call SetItemCharges(hso_Z66,(GetItemCharges(hso_Z66)+GetItemCharges(hso_ZZ6Z)))
call RemoveItem(hso_ZZ6Z)
endif
set hso_z78=hso_z78+1
endloop
endif
set hso_z76=hso_z76+1
endloop
set hso_Z66=null
set hso_ZZ6Z=null
set hso_z65=null
endfunction
function hso_ZZ7Z takes integer hso_z15,integer hso_Z75 returns nothing
local unit hso_z65
local item hso_z86
set hso_z65=FirstOfGroup(hso_Z8Z[hso_z15])
set hso_z86=UnitItemInSlotBJ(hso_z65,1)
call SetItemCharges(hso_z86,(GetItemCharges(hso_z86)+hso_Z75))
set hso_z86=null
set hso_z65=null
endfunction
function hso_ZZ8Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call GroupAddUnit(hso_z8Z,hso_z65)
set hso_z65=null
endfunction
function hso_ZZ9Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call GroupRemoveUnit(hso_z8Z,hso_z65)
set hso_z65=null
endfunction
function hso_ZzZZ takes nothing returns nothing
local unit hso_z65=GetTriggerUnit()
if((IsUnitDeadBJ(hso_z65))and(IsUnitType(hso_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(hso_z8Z,hso_z65)
endif
endfunction
function hso_ZzzZ takes nothing returns nothing
call ForGroup(hso_z8Z,function hso_ZzZZ)
endfunction
function hso_Zz0Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call ReviveHeroLoc(hso_z65,hso_Z9Z[hso_Zzz],true)
call SetUnitManaPercentBJ(hso_z65,100)
set hso_z65=null
endfunction
function hso_Zz1Z takes player hso_z05 returns nothing
local group hso_z46
set hso_z46=hso_Z94(hso_z05)
set hso_Zzz=GetPlayerId(hso_z05)
call ForGroup(hso_z46,function hso_Zz0Z)
call DestroyGroup(hso_z46)
set hso_z46=null
endfunction
function hso_Zz2Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call ModifyHeroStat(hso_z81,hso_z65,hso_z91,hso_z71)
set hso_z65=null
endfunction
function hso_Zz3Z takes integer hso_z15,integer hso_Zz4Z,integer hso_Zz5Z,boolean hso_z25 returns nothing
local integer hso_Zz6Z
if(hso_z25)then
set hso_Zz6Z=0
else
set hso_Zz6Z=1
endif
if(hso_Z0)then
set hso_z91=hso_Zz6Z
set hso_z81=hso_Zz4Z
set hso_z71=hso_Zz5Z
call ForGroup(hso_Z8Z[hso_z15],function hso_Zz2Z)
else
call ModifyHeroStat(hso_Zz4Z,hso_z7[hso_z15],hso_Zz6Z,hso_Zz5Z)
endif
endfunction
function hso_Zz7Z takes unit hso_z65,integer hso_Zz5Z,boolean hso_z25 returns nothing
local integer hso_z15
set hso_z15=GetHeroLevel(hso_z65)
if(hso_z25)then
set hso_z15=hso_z15+hso_Zz5Z
else
set hso_z15=hso_z15-hso_Zz5Z
endif
call SetHeroLevelBJ(hso_z65,hso_z15,false)
endfunction
function hso_Zz8Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_Zz7Z(hso_z65,hso_ZZ2,hso_Z1z)
set hso_z65=null
endfunction
function hso_Zz9Z takes integer hso_z15,integer hso_Zz5Z,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_ZZ2=hso_Zz5Z
set hso_Z1z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Zz8Z)
else
call hso_Zz7Z(hso_z7[hso_z15],hso_Zz5Z,hso_z25)
endif
endfunction
function hso_Z0ZZ takes string hso_Z0zZ returns integer
local string hso_Z00Z="0123456789"
local string hso_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hso_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer hso_Id=0
local integer hso_Z03Z=1
local integer hso_Z04Z=1
loop
exitwhen hso_Z03Z>StringLength(hso_Z0zZ)
loop
exitwhen hso_Z04Z>10
if SubString(hso_Z0zZ,hso_Z03Z-1,hso_Z03Z)==SubString(hso_Z00Z,hso_Z04Z-1,hso_Z04Z)then
set hso_Id=hso_Id+R2I((48+hso_Z04Z-1)*Pow(256.,I2R(StringLength(hso_Z0zZ)-hso_Z03Z)))
set hso_Z04Z=hso_Z04Z+1
else
set hso_Z04Z=hso_Z04Z+1
endif
endloop
set hso_Z04Z=1
loop
exitwhen hso_Z04Z>26
if SubString(hso_Z0zZ,hso_Z03Z-1,hso_Z03Z)==SubString(hso_Z01Z,hso_Z04Z-1,hso_Z04Z)then
set hso_Id=hso_Id+R2I(I2R(65+hso_Z04Z-1)*Pow(256.,I2R(StringLength(hso_Z0zZ)-hso_Z03Z)))
set hso_Z04Z=hso_Z04Z+1
else
set hso_Z04Z=hso_Z04Z+1
endif
endloop
set hso_Z04Z=1
loop
exitwhen hso_Z04Z>26
if SubString(hso_Z0zZ,hso_Z03Z-1,hso_Z03Z)==SubString(hso_Z02Z,hso_Z04Z-1,hso_Z04Z)then
set hso_Id=hso_Id+R2I((97+hso_Z04Z-1)*Pow(256.,I2R(StringLength(hso_Z0zZ)-hso_Z03Z)))
set hso_Z04Z=hso_Z04Z+1
else
set hso_Z04Z=hso_Z04Z+1
endif
endloop
set hso_Z04Z=1
set hso_Z03Z=hso_Z03Z+1
endloop
return hso_Id
endfunction
function hso_Z05Z takes integer hso_Z06Z returns string
local string hso_Z00Z="0123456789"
local string hso_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hso_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string hso_Z07Z=""
local integer hso_Z03Z=0
local integer hso_Z08Z=0
loop
exitwhen hso_Z06Z==0
set hso_Z03Z=ModuloInteger(hso_Z06Z,256)
if hso_Z03Z>=48 and hso_Z03Z<=57 then
set hso_Z08Z=hso_Z03Z-48
set hso_Z07Z=SubString(hso_Z00Z,hso_Z08Z,hso_Z08Z+1)+hso_Z07Z
endif
if hso_Z03Z>=65 and hso_Z03Z<=90 then
set hso_Z08Z=hso_Z03Z-65
set hso_Z07Z=SubString(hso_Z01Z,hso_Z08Z,hso_Z08Z+1)+hso_Z07Z
endif
if hso_Z03Z>=97 and hso_Z03Z<=122 then
set hso_Z08Z=hso_Z03Z-97
set hso_Z07Z=SubString(hso_Z02Z,hso_Z08Z,hso_Z08Z+1)+hso_Z07Z
endif
set hso_Z06Z=hso_Z06Z/256
endloop
return hso_Z07Z
endfunction
function hso_Z09Z takes unit hso_z65 returns string
local integer hso_z15
set hso_z15=GetUnitTypeId(hso_z65)
if(hso_z15==0)then
return""
else
return hso_Z05Z(hso_z15)
endif
endfunction
function hso_Z1ZZ takes unit hso_z65 returns string
local item hso_z86=UnitItemInSlotBJ(hso_z65,1)
local integer hso_z15=GetItemTypeId(hso_z86)
if(hso_z15==0)then
return""
else
set hso_z86=null
return hso_Z05Z(hso_z15)
endif
endfunction
function hso_Z1zZ takes integer hso_Z10Z returns integer
local string hso_Z11Z=GetEventPlayerChatString()
if(StringLength(hso_Z11Z)==hso_Z10Z+3)then
return(hso_Z0ZZ(SubStringBJ(hso_Z11Z,hso_Z10Z,hso_Z10Z+3)))
else
return 0
endif
endfunction
function hso_Z12Z takes unit hso_z65,integer hso_z66,boolean hso_z25 returns nothing
local location hso_z95
local integer hso_z15
set hso_z15=hso_Z1zZ(hso_z66)
if(hso_z15==0)then
else
if(hso_z25)then
set hso_z95=GetUnitLoc(hso_z65)
call CreateItemLoc(hso_z15,hso_z95)
call RemoveLocation(hso_z95)
set hso_z95=null
else
call UnitAddItemById(hso_z65,hso_z15)
endif
endif
endfunction
function hso_Z13Z takes unit hso_z65,real hso_Z14Z,boolean hso_z25 returns nothing
local location hso_z95=GetUnitLoc(hso_z65)
local player hso_z05=GetOwningPlayer(hso_z65)
call SetBlightRadiusLocBJ(hso_z25,hso_z05,hso_z95,hso_Z14Z)
call RemoveLocation(hso_z95)
set hso_z95=null
set hso_z05=null
endfunction
function hso_Z15Z takes unit hso_z65,real hso_Z14Z returns nothing
call SetUnitFlyHeight(hso_z65,hso_Z14Z,.0)
endfunction
function hso_Z16Z takes nothing returns integer
local integer hso_Z17Z=0
local integer hso_Z18Z=0
local integer array hso_Z19Z
local integer hso_z15=0
local player hso_z05=GetLocalPlayer()
loop
exitwhen hso_z15>11
set hso_Z19Z[hso_z15]=0
set hso_z15=hso_z15+1
endloop
loop
exitwhen hso_Z17Z>14
call StoreInteger(hso_z03,"hso_Player","hso_number",GetPlayerId(hso_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(hso_z03,"hso_Player","hso_number")
call TriggerSyncReady()
set hso_Z18Z=GetStoredInteger(hso_z03,"hso_Player","hso_number")-1
set hso_Z19Z[hso_Z18Z]=hso_Z19Z[hso_Z18Z]+1
call FlushStoredMission(hso_z03,"hso_Player")
set hso_Z17Z=hso_Z17Z+1
endloop
set hso_Z18Z=0
set hso_Z17Z=0
set hso_z05=null
loop
exitwhen hso_Z17Z>11
if hso_Z19Z[hso_Z18Z]<hso_Z19Z[hso_Z17Z]then
set hso_Z18Z=hso_Z17Z
endif
set hso_Z17Z=hso_Z17Z+1
endloop
return hso_Z18Z+1
endfunction
function hso_Z2ZZ takes unit hso_z65,integer hso_Z2zZ,boolean hso_z25 returns nothing
if(hso_z25)then
call UnitAddAbility(hso_z65,hso_Z2zZ)
call SetUnitAbilityLevel(hso_z65,hso_Z2zZ,100)
call UnitMakeAbilityPermanent(hso_z65,true,hso_Z2zZ)
else
call UnitMakeAbilityPermanent(hso_z65,false,hso_Z2zZ)
call UnitRemoveAbility(hso_z65,hso_Z2zZ)
endif
endfunction
function hso_Z20Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_Z2ZZ(hso_z65,hso_zzz,hso_z0z)
set hso_z65=null
endfunction
function hso_Z21Z takes integer hso_z15,integer hso_Z2zZ,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_zzz=hso_Z2zZ
set hso_z0z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Z20Z)
else
call hso_Z2ZZ(hso_z7[hso_z15],hso_Z2zZ,hso_z25)
endif
endfunction
function hso_Z22Z takes string hso_Z11Z returns integer
if(hso_Z11Z=="mm")then
return 1094937907
endif
if(hso_Z11Z=="xj")then
return 1095659625
endif
if(hso_Z11Z=="zj")then
return 1095262824
endif
if(hso_Z11Z=="zm")then
return 1095721842
endif
if(hso_Z11Z=="ft")then
return 1096119411
endif
if(hso_Z11Z=="xx")then
return 1095333473
endif
if(hso_Z11Z=="sb")then
return 1095066998
endif
if(hso_Z11Z=="yx")then
return 1097886070
endif
if(hso_Z11Z=="rh")then
return 1095657827
endif
if(hso_Z11Z=="fl")then
return 1095656289
endif
if(hso_Z11Z=="bs")then
return 1094935923
endif
if(hso_Z11Z=="jg")then
return 1095332984
endif
if(hso_Z11Z=="jf")then
return 1095328816
endif
if(hso_Z11Z=="js")then
return 1095332728
endif
if(hso_Z11Z=="jm")then
return 1095332722
endif
if(hso_Z11Z=="jj")then
return 1095917932
endif
if(hso_Z11Z=="fy")then
return 1098150517
endif
if(hso_Z11Z=="ghh")then
return 1095262562
endif
if(hso_Z11Z=="ghj")then
return 1095721317
endif
if(hso_Z11Z=="gqj")then
return 1095065970
endif
if(hso_Z11Z=="gxx")then
return 1096114550
endif
if(hso_Z11Z=="gzz")then
return 1095262564
endif
if(hso_Z11Z=="gxe")then
return 1096114549
endif
if(hso_Z11Z=="gjj")then
return 1095065960
endif
if(hso_Z11Z=="gml")then
return 1094934883
endif
if(hso_Z11Z=="gyl")then
return 1097818482
endif
if(hso_Z11Z=="gjs")then
return 1096905580
endif
if(hso_Z11Z=="qhy")then
return 1095329378
endif
if(hso_Z11Z=="qdy")then
return 1095331938
endif
if(hso_Z11Z=="qlh")then
return 1095332719
endif
if(hso_Z11Z=="qyz")then
return 1095328878
endif
if(hso_Z11Z=="qbd")then
return 1095331682
endif
if(hso_Z11Z=="qfs")then
return 1095328610
endif
if(hso_Z11Z=="qsd")then
return 1095330924
endif
if(hso_Z11Z=="qjs")then
return 1095332706
endif
if(hso_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function hso_Z23Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call SetUnitInvulnerable(hso_z65,hso_z0z)
call hso_Z2ZZ(hso_z65,1098282348,hso_z0z)
set hso_z65=null
endfunction
function hso_Z24Z takes integer hso_z15,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_z0z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Z23Z)
else
call SetUnitInvulnerable(hso_z7[hso_z15],hso_z25)
call hso_Z2ZZ(hso_z7[hso_z15],1098282348,hso_z25)
endif
endfunction
function hso_Z25Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call SetUnitPathing(hso_z65,not(hso_z0z))
set hso_z65=null
endfunction
function hso_Z26Z takes integer hso_z15,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_z0z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Z25Z)
else
call SetUnitPathing(hso_z7[hso_z15],not(hso_z25))
endif
endfunction
function hso_Z27Z takes unit hso_z65,boolean hso_z25 returns nothing
if(hso_z25)then
call SetUnitMoveSpeed(hso_z65,1000)
else
call SetUnitMoveSpeed(hso_z65,GetUnitDefaultMoveSpeed(hso_z65))
endif
endfunction
function hso_Z28Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_Z27Z(hso_z65,hso_z0z)
set hso_z65=null
endfunction
function hso_Z29Z takes integer hso_z15,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_z0z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Z28Z)
else
call hso_Z27Z(hso_z7[hso_z15],hso_z25)
endif
endfunction
function hso_Z3ZZ takes integer hso_z15,boolean hso_z25 returns nothing
call hso_ZzzZ()
if(hso_Z0)then
if(hso_z25)then
if(CountUnitsInGroup(hso_z8Z)==0)then
call EnableTrigger(hso_z73)
endif
call GroupAddGroup(hso_Z8Z[hso_z15],hso_z8Z)
else
call GroupRemoveGroup(hso_Z8Z[hso_z15],hso_z8Z)
if(CountUnitsInGroup(hso_z8Z)==0)then
call DisableTrigger(hso_z73)
endif
endif
else
if(hso_z25)then
if(CountUnitsInGroup(hso_z8Z)==0)then
call EnableTrigger(hso_z73)
endif
call GroupAddUnit(hso_z8Z,hso_z7[hso_z15])
else
call GroupRemoveUnit(hso_z8Z,hso_z7[hso_z15])
if(CountUnitsInGroup(hso_z8Z)==0)then
call DisableTrigger(hso_z73)
endif
endif
endif
endfunction
function hso_Z3zZ takes unit hso_z65,boolean hso_z25 returns nothing
call hso_Z2ZZ(hso_z65,1095262562,hso_z25)
call hso_Z2ZZ(hso_z65,1095721317,hso_z25)
call hso_Z2ZZ(hso_z65,1095065970,hso_z25)
call hso_Z2ZZ(hso_z65,1096114550,hso_z25)
call hso_Z2ZZ(hso_z65,1095262564,hso_z25)
call hso_Z2ZZ(hso_z65,1096114549,hso_z25)
call hso_Z2ZZ(hso_z65,1094934883,hso_z25)
call hso_Z2ZZ(hso_z65,1095065960,hso_z25)
call hso_Z2ZZ(hso_z65,1097818482,hso_z25)
call hso_Z2ZZ(hso_z65,1096905580,hso_z25)
endfunction
function hso_Z30Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_Z3zZ(hso_z65,hso_z0z)
set hso_z65=null
endfunction
function hso_Z31Z takes integer hso_z15,boolean hso_z25 returns nothing
if(hso_Z0)then
set hso_z0z=hso_z25
call ForGroup(hso_Z8Z[hso_z15],function hso_Z30Z)
else
call hso_Z3zZ(hso_z7[hso_z15],hso_z25)
endif
endfunction
function hso_Z32Z takes unit hso_z65 returns nothing
call hso_Z2ZZ(hso_z65,1094937907,false)
call hso_Z2ZZ(hso_z65,1095659625,false)
call hso_Z2ZZ(hso_z65,1095262824,false)
call hso_Z2ZZ(hso_z65,1095721842,false)
call hso_Z2ZZ(hso_z65,1096119411,false)
call hso_Z2ZZ(hso_z65,1095333473,false)
call hso_Z2ZZ(hso_z65,1095066998,false)
call hso_Z2ZZ(hso_z65,1097886070,false)
call hso_Z2ZZ(hso_z65,1095657827,false)
call hso_Z2ZZ(hso_z65,1095656289,false)
call hso_Z2ZZ(hso_z65,1098282348,false)
call hso_Z2ZZ(hso_z65,1094935923,false)
call hso_Z2ZZ(hso_z65,1095332984,false)
call hso_Z2ZZ(hso_z65,1095328816,false)
call hso_Z2ZZ(hso_z65,1095332728,false)
call hso_Z2ZZ(hso_z65,1095332722,false)
call hso_Z2ZZ(hso_z65,1098150517,false)
call SetUnitInvulnerable(hso_z65,false)
call SetUnitPathing(hso_z65,true)
call hso_Z27Z(hso_z65,false)
call GroupRemoveUnit(hso_z8Z,hso_z65)
endfunction
function hso_Z33Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_Z32Z(hso_z65)
set hso_z65=null
endfunction
function hso_Z34Z takes integer hso_z15 returns nothing
if(hso_Z0)then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z33Z)
else
call hso_Z32Z(hso_z7[hso_z15])
endif
endfunction
function hso_Z35Z takes nothing returns nothing
local unit hso_z65=GetTriggerUnit()
local trigger hso_Z66=GetTriggeringTrigger()
call RemoveUnit(hso_z65)
call DisableTrigger(hso_Z66)
call DestroyTrigger(hso_Z66)
set hso_z65=null
set hso_Z66=null
endfunction
function hso_Z36Z takes integer hso_z66,unit hso_Z37Z,player hso_Z38Z returns nothing
local location hso_z95
local unit hso_z65
local integer hso_Z39Z=0
local integer hso_Z4ZZ=0
local trigger hso_Z66
if(hso_z66==0)then
set hso_Z39Z=1095726692
set hso_Z4ZZ=852503
endif
if(hso_z66==1)then
set hso_Z39Z=1095070833
set hso_Z4ZZ=852184
endif
if(hso_z66==2)then
set hso_Z39Z=1095070566
set hso_Z4ZZ=852183
endif
if((hso_Z39Z==0)and(hso_Z4ZZ==0))then
return
endif
set hso_z95=GetUnitLoc(hso_Z37Z)
set hso_z65=CreateUnitAtLoc(hso_Z38Z,1851941228,hso_z95,bj_UNIT_FACING)
call UnitAddAbility(hso_z65,1098282348)
call UnitAddAbility(hso_z65,hso_Z39Z)
call ShowUnit(hso_z65,false)
call SetUnitUseFood(hso_z65,false)
call SetUnitScale(hso_z65,.01,.01,.01)
call SetUnitState(hso_z65,UNIT_STATE_MANA,GetUnitState(hso_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(hso_z65,hso_Z4ZZ)
set hso_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(hso_Z66,hso_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hso_Z66,hso_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hso_Z66,function hso_Z35Z)
call RemoveLocation(hso_z95)
set hso_z95=null
set hso_Z66=null
set hso_z65=null
endfunction
function hso_Z4zZ takes unit hso_Z37Z returns nothing
local player hso_z05=GetTriggerPlayer()
local location hso_z95=GetUnitLoc(hso_Z37Z)
local trigger hso_Z66=CreateTrigger()
local unit hso_z65=CreateUnitAtLoc(hso_z05,1751543663,hso_z95,bj_UNIT_FACING)
call UnitAddAbility(hso_z65,1098282348)
call UnitAddAbility(hso_z65,1095332709)
call ShowUnit(hso_z65,false)
call SetUnitUseFood(hso_z65,false)
call SetUnitScale(hso_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(hso_z65,852592,hso_z95)
call TriggerRegisterUnitEvent(hso_Z66,hso_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hso_Z66,hso_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hso_Z66,function hso_Z35Z)
call RemoveLocation(hso_z95)
set hso_z95=null
set hso_Z66=null
set hso_z05=null
endfunction
function hso_Z40Z takes integer hso_z15,dialog hso_Z41Z,trigger hso_zZ6 returns nothing
set hso_Zz3[hso_z15]=hso_Z41Z
set hso_Z03[hso_z15]=hso_zZ6
endfunction
function hso_Z42Z takes integer hso_z15,string hso_Z43Z returns nothing
call DialogClear(hso_Zz3[hso_z15])
call DialogSetMessage(hso_Zz3[hso_z15],(hso_Z43Z+hso_Z0z+hso_Z62))
endfunction
function hso_Z44Z takes integer hso_z15,player hso_z05,boolean hso_z77 returns nothing
if(hso_z77)then
call EnableTrigger(hso_Z03[hso_z15])
call DialogDisplay(hso_z05,hso_Zz3[hso_z15],true)
call TimerStart(hso_Z73[hso_z15],hso_z1,false,null)
else
call DisableTrigger(hso_Z03[hso_z15])
call DialogDisplay(hso_z05,hso_Zz3[hso_z15],false)
endif
endfunction
function hso_Z45Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_zZ1[hso_z15],hso_ZZ1[hso_z15])
call hso_Z42Z(hso_z15,"主")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"资源菜单[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"自动化设置[B]",66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"选定单位特殊属性[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"个人选项设置[D]",68)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"帮助菜单[E]",69)
if(hso_z05==hso_z5)then
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"其他玩家作弊管理[F]",70)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"其他玩家管理[G]",71)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"游戏作弊选项[H]",72)
if(hso_z13)then
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z46Z takes integer hso_z15,player hso_z05 returns nothing
local string hso_Z11Z
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Zz1[hso_z15])
call hso_Z42Z(hso_z15,"自动化设置")
if(IsTriggerEnabled(hso_z40[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(hso_z50[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(hso_z60[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(hso_z80[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(hso_z70[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(hso_z90[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"魔法释放后自动MP"+I2S(R2I(hso_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(hso_ZZ3[hso_z15]))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"生命低于"+I2S(R2I(hso_z92))+"%加到"+I2S(R2I(hso_z41))+"%[G]"),71)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"全部开启[O]",79)
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"全部关闭[U]",85)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z11Z=""
endfunction
function hso_Z47Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z01[hso_z15])
call hso_Z42Z(hso_z15,"选定单位特殊属性")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"无敌[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"永久隐形[B]",66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"穿越物体[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"魔免[D]",68)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"反隐形[E]",69)
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"移动速度[F]",70)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"各种光环[G]",71)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"换页[N]",78)
if((hso_z9Z)or(hso_z5==hso_z05))then
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"秒杀模式[K]",75)
endif
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"取消全部(不含光环)[U]",85)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z48Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_Z91[hso_z15],hso_Z81[hso_z15])
call hso_Z42Z(hso_z15,"选定单位特殊属性")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"永久献祭[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"闪避[B]",514)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"重击[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"致命一击[D]",68)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"反弹(小强的壳)[E]",69)
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"分裂攻击[F]",70)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"燃灰[G]",71)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"减少魔法伤害33%[H]",72)
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"闪避100%[I]",73)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"换页[N]",78)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z49Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_Z91[hso_z15],hso_Z21[hso_z15])
call hso_Z42Z(hso_z15,"光环")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"辉煌光环[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"荆棘光环[B]",66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"耐久光环[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"强击光环[D]",68)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"邪恶光环[E]",69)
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"吸血光环[F]",70)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"专注光环[G]",71)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"命令光环(战鼓)[H]",72)
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"医疗光环[I]",73)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"减速光环[J]",74)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"关所有光环[K]",75)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z5ZZ takes integer hso_z15,player hso_z05 returns nothing
local integer hso_Z75=0
local string hso_Z11Z
local string hso_Z5zZ
local player hso_Z65
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z51[hso_z15])
call hso_Z42Z(hso_z15,"玩家作弊管理")
loop
exitwhen hso_Z75>11
set hso_Z65=Player(hso_Z75)
if((GetPlayerController(hso_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(hso_Z65)==PLAYER_SLOT_STATE_PLAYING)and(hso_Z65!=hso_z5))then
set hso_Z5zZ=GetPlayerName(hso_Z65)
if(hso_z6[hso_Z75])then
set hso_Z11Z="禁止"
else
set hso_Z11Z="允许"
endif
set hso_ZzZ[hso_Z75]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+hso_Z5zZ+"作弊"),0)
endif
set hso_Z75=hso_Z75+1
endloop
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z65=null
set hso_Z11Z=""
set hso_Z5zZ=""
endfunction
function hso_Z50Z takes integer hso_z15,player hso_z05 returns nothing
set hso_Z8[hso_z15]=0
call hso_Z40Z(hso_z15,hso_zZ1[hso_z15],hso_Z71[hso_z15])
call hso_Z42Z(hso_z15,"单位")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"升100级[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("加三围"+(I2S(hso_Z3)+"[B]")),66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"复制物品[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"复制单位[D]",68)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"掉身上物品[E]",69)
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"共享该单位视野[F]",70)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"特殊属性菜单[G]",71)
if((hso_z7Z)or(hso_z5==hso_z05))then
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"控制它[H]",72)
endif
if(hso_z5==hso_z05)then
endif
if(hso_z05==hso_z5)then
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"改变单位所有者[J]",74)
endif
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z51Z takes integer hso_z15,player hso_z05 returns nothing
local string hso_Z11Z
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z31[hso_z15])
call hso_Z42Z(hso_z15,"游戏作弊选项")
if(hso_Z0)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"操作所有单位[A]"),65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("设置背包数[B]"),66)
if(hso_Z5Z)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"保护CheatMaster[C]"),67)
if(hso_Z6Z)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(hso_Z7Z)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("取消作弊时"+hso_Z11Z+"地图全开[E]"),69)
if(hso_z9Z)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"他人秒杀模式[F]"),70)
if(hso_ZZz)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"禁止秒杀建筑[G]"),71)
if(hso_z7Z)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"他人占据单位[H]"),72)
if(hso_Z52)then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"禁止克隆操作农民[I]"),73)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z11Z=""
endfunction
function hso_Z52Z takes integer hso_z15,player hso_z05 returns nothing
local string hso_Z5zZ
local integer hso_Z75=0
local player hso_Z65
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z41[hso_z15])
call hso_Z42Z(hso_z15,"玩家管理")
loop
exitwhen hso_Z75>11
set hso_Z65=Player(hso_Z75)
if(GetPlayerSlotState(hso_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hso_Z5zZ=GetPlayerName(hso_Z65)
set hso_ZzZ[hso_Z75]=DialogAddButton(hso_Zz3[hso_z15],("选择"+hso_Z5zZ+"操作"),0)
endif
set hso_Z75=hso_Z75+1
endloop
set hso_ZzZ[12]=DialogAddButton(hso_Zz3[hso_z15],("选择中立生物操作"),90)
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z5zZ=""
set hso_Z65=null
endfunction
function hso_Z53Z takes integer hso_z15,player hso_z05 returns nothing
local player hso_Z65=Player(hso_Z5z)
call hso_Z40Z(hso_z15,hso_Z91[hso_z15],hso_Z61[hso_z15])
call hso_Z42Z(hso_z15,"玩家管理")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"资源管理[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"向他收税黄金"+I2S(hso_z22)+"%[C]",67)
else
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"向他收税木材"+I2S(hso_z22)+"%[D]",68)
else
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"停止向他收木材[D]",67)
endif
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回选择菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z65=null
endfunction
function hso_Z54Z takes integer hso_z15,player hso_z05 returns nothing
local integer hso_Z75=0
local player hso_Z65
local string hso_Z11Z
local string hso_Z5zZ
call hso_Z40Z(hso_z15,hso_Z91[hso_z15],hso_Z11[hso_z15])
call hso_Z42Z(hso_z15,"选定单位控制")
loop
exitwhen hso_Z75>12
set hso_Z65=Player(hso_Z75)
if(GetPlayerSlotState(hso_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hso_Z5zZ=GetPlayerName(hso_Z65)
set hso_ZzZ[hso_Z75]=DialogAddButton(hso_Zz3[hso_z15],("给"+hso_Z5zZ+"控制"),0)
endif
set hso_Z75=hso_Z75+1
endloop
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回单位菜单[R]",82)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z65=null
set hso_Z11Z=""
set hso_Z5zZ=""
endfunction
function hso_Z55Z takes integer hso_z15,player hso_z05 returns nothing
local string hso_Z11Z
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Zz2[hso_z15])
call hso_Z42Z(hso_z15,"资源设置")
if(hso_z1Z[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="打开"
endif
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"地图[A]"),65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("复活死亡英雄[B]"),66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"人口清5[B]",66)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"总人口100[C]",67)
if(GetPlayerHandicap(hso_z05)==2)then
set hso_Z11Z="恢复生命障碍100%"
else
set hso_Z11Z="200%生命"
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(hso_z05)==2)then
set hso_Z11Z="恢复普通经验率"
else
set hso_Z11Z="2倍经验"
endif
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"[E]",69)
set hso_Z11Z=I2S(hso_Z2)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("加"+hso_Z11Z+"钱[F]"),70)
set hso_Z11Z=I2S(hso_z2)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("加"+hso_Z11Z+"木[G]"),71)
set hso_Z11Z=I2S(hso_Z2)
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("减"+hso_Z11Z+"钱[H]"),72)
set hso_Z11Z=I2S(hso_z2)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("减"+hso_Z11Z+"木[I]"),73)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z11Z=""
endfunction
function hso_Z56Z takes integer hso_z15,player hso_z05 returns nothing
local player hso_Z65=Player(hso_Z5z)
local string hso_Z11Z
local string hso_Z5zZ=GetPlayerName(hso_Z65)
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z02[hso_z15])
call DialogClear(hso_Z20[hso_z15])
call DialogSetMessage(hso_Z20[hso_z15],(hso_Z5zZ+"钱"+I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(hso_z1Z[hso_Z5z])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="打开"
endif
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],(hso_Z11Z+"地图[A]"),65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("复活死亡英雄[B]"),66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"人口清5[B]",66)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"总人口100[C]",67)
if(GetPlayerHandicap(hso_Z65)==2)then
set hso_Z11Z="恢复生命障碍100%"
else
set hso_Z11Z="200%生命"
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(hso_Z65)==2)then
set hso_Z11Z="恢复普通经验率"
else
set hso_Z11Z="2倍经验"
endif
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"[E]",69)
set hso_Z11Z=I2S(hso_Z2)
set hso_z7z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("加"+hso_Z11Z+"钱[F]"),70)
set hso_Z11Z=I2S(hso_z2)
set hso_z6z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("加"+hso_Z11Z+"木[G]"),71)
set hso_Z11Z=I2S(hso_Z2)
set hso_Zz0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("减"+hso_Z11Z+"钱[H]"),72)
set hso_Z11Z=I2S(hso_z2)
set hso_ZZ0[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("减"+hso_Z11Z+"木[I]"),73)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z11Z=""
set hso_Z5zZ=""
set hso_Z65=null
endfunction
function hso_Z57Z takes integer hso_z15,player hso_z05 returns nothing
local player hso_Z65=Player(hso_Z5z)
local string hso_Z11Z
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z12[hso_z15])
call hso_Z42Z(hso_z15,"同盟管理")
if(IsPlayerAlly(hso_Z65,hso_z5))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("强制"+hso_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(hso_Z65,hso_z5))then
if(GetPlayerAlliance(hso_Z65,hso_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("强制"+hso_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(hso_Z65,hso_z5,ALLIANCE_SHARED_XP))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("强制"+hso_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(hso_z5,hso_Z65))then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],("强制"+hso_Z11Z+"对其同盟[D]"),68)
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回玩家菜单[R]",82)
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z65=null
set hso_Z11Z=""
endfunction
function hso_Z58Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_Z91[hso_z15],hso_Z22[hso_z15])
call DialogClear(hso_Z91[hso_z15])
call DialogSetMessage(hso_Z91[hso_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(hso_z61)+"|r个")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"设置1个背包[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"设置2个背包[B]",66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"设置3个背包[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回选设置单[R]",82)
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z59Z takes integer hso_z15,player hso_z05 returns nothing
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z23[hso_z15])
call hso_Z42Z(hso_z15,"帮助")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"键盘帮助[A]",65)
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"CMD帮助[B]",66)
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"CMD单位类帮助[C]",67)
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"显示玩家信息[D]",68)
if(hso_z05==hso_z5)then
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"显示设置信息[E]",69)
endif
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
endfunction
function hso_Z6ZZ takes integer hso_z15,player hso_z05 returns nothing
local string hso_Z11Z
call hso_Z40Z(hso_z15,hso_Z20[hso_z15],hso_Z13[hso_z15])
call hso_Z42Z(hso_z15,"个人选项")
set hso_z2z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"删除我的复制单位[A]",65)
if(hso_z31[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z4z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"克隆操作[B]",66)
if(hso_Z33[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z5z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"组队克隆操作[C]",67)
if(hso_Z53[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z3z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"隐藏加攻[D]",68)
if(hso_Z63[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z9z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"隐藏加攻带溅射[E]",69)
if(hso_Z43[hso_z15])then
set hso_Z11Z="关闭"
else
set hso_Z11Z="开启"
endif
set hso_z8z[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],hso_Z11Z+"远程沉默[F]",70)
set hso_Z00[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"回主菜单[R]",82)
set hso_Z10[hso_z15]=DialogAddButton(hso_Zz3[hso_z15],"退出菜单[X]",88)
call hso_Z44Z(hso_z15,hso_z05,true)
set hso_Z11Z=""
endfunction
function hso_Z6zZ takes player hso_z05 returns nothing
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"欢迎使用|cFFFF8C00hso的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function hso_Z60Z takes player hso_z05 returns nothing
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"欢迎使用|cFFFF8C00hso的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(hso_z05==hso_z5)then
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function hso_Z61Z takes player hso_z05 returns nothing
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"欢迎使用|cFFFF8C00hso的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AFP键全图闪|r:|cFFFF0033-ups|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(hso_z05==hso_z5)then
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function hso_Z62Z takes player hso_z05 returns nothing
local integer hso_Z75
local player hso_Z65
local string hso_Z11Z
local string hso_Z63Z
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,"|CFFFF0000hso1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set hso_Z75=1
loop
exitwhen hso_Z75>12
set hso_Z65=Player(hso_Z75-1)
if(GetPlayerSlotState(hso_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set hso_Z63Z=I2S(hso_Z75)
set hso_Z11Z=(GetPlayerName(hso_Z65)+":编号:"+hso_Z63Z)
set hso_Z63Z=I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_GOLD))
set hso_Z11Z=(hso_Z11Z+" |CFFFFFF00黄金:"+hso_Z63Z+"|R")
set hso_Z63Z=I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set hso_Z11Z=(hso_Z11Z+" |CFF008000木头:"+hso_Z63Z+"|R")
set hso_Z63Z=I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set hso_Z11Z=(hso_Z11Z+" 人口:"+hso_Z63Z)
set hso_Z63Z=I2S(GetPlayerState(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set hso_Z11Z=(hso_Z11Z+"/"+hso_Z63Z)
set hso_Z11Z=hso_Z11Z+" 作弊:"
if(hso_z6[hso_Z75-1])then
set hso_Z11Z=hso_Z11Z+"|cFF00FF33√|r"
else
set hso_Z11Z=hso_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(hso_Z65)==MAP_CONTROL_USER)then
set hso_Z11Z=hso_Z11Z+" (玩家)"
if(hso_Z75-1==hso_zz3)then
set hso_Z11Z=hso_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set hso_Z11Z=hso_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,hso_Z11Z)
endif
set hso_Z75=hso_Z75+1
endloop
set hso_Z65=null
set hso_Z11Z=""
set hso_Z63Z=""
endfunction
function hso_Z64Z takes nothing returns nothing
local string hso_Z65Z
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,"|CFFFF0000hso1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set hso_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(hso_z4Z)
set hso_Z65Z=hso_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(hso_z5Z)
set hso_Z65Z=hso_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(hso_z6Z)
set hso_Z65Z=hso_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(hso_ZZZ))
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
set hso_Z65Z=hso_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(hso_z41))
set hso_Z65Z=hso_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(hso_z92))
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
set hso_Z65Z=hso_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(hso_zZ)
set hso_Z65Z=hso_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(hso_Zz)
set hso_Z65Z=hso_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(hso_zz)
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
set hso_Z65Z=hso_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(hso_Z2)
set hso_Z65Z=hso_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(hso_z2)
set hso_Z65Z=hso_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(hso_Z3)
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
set hso_Z65Z=hso_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(hso_z61)
set hso_Z65Z=hso_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(hso_Z1))
set hso_Z65Z=hso_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(hso_z1))
set hso_Z65Z=hso_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(hso_z42))
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
set hso_Z65Z=hso_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(hso_z22)
set hso_Z65Z=hso_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(hso_z3))
set hso_Z65Z=hso_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(hso_Z4))
call DisplayTimedTextToPlayer(hso_z5,0,0,hso_Z1,hso_Z65Z)
set hso_Z65Z=""
endfunction
function hso_Z66Z takes player hso_z05,unit hso_z65 returns nothing
local string hso_Z11Z=hso_Z09Z(hso_z65)
set hso_Z11Z="该单位的ID为|cFF33FF00"+hso_Z11Z+"|r"
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,hso_Z11Z)
set hso_Z11Z=""
endfunction
function hso_Z67Z takes player hso_z05,unit hso_z65 returns nothing
local string hso_Z11Z=hso_Z1ZZ(hso_z65)
set hso_Z11Z="该单位的第一格物品ID为|cFF33FF00"+hso_Z11Z+"|r"
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,hso_Z11Z)
set hso_Z11Z=""
endfunction
function hso_Z68Z takes integer hso_z15 returns nothing
local unit hso_z65=hso_z7[hso_z15]
local player hso_z05=Player(hso_z15)
local item hso_z86
local integer hso_Z75=0
local string hso_Z11Z
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"hso Unit Debug Info:")
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"单位X坐标:"+R2S(GetUnitX(hso_z65))+" 单位Y坐标:"+R2S(GetUnitY(hso_z65)))
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,"单位ID:"+hso_Z09Z(hso_z65))
if(IsUnitType(hso_z65,UNIT_TYPE_HERO))then
set hso_Z11Z="单位物品ID:"
loop
exitwhen hso_Z75>5
set hso_z86=UnitItemInSlot(hso_z65,hso_Z75)
set hso_Z11Z=hso_Z11Z+hso_Z05Z(GetItemTypeId(hso_z86))+" "
set hso_Z75=hso_Z75+1
endloop
call DisplayTimedTextToPlayer(hso_z05,0,0,hso_Z1,hso_Z11Z)
set hso_Z11Z=""
set hso_z86=null
endif
set hso_z65=null
set hso_z05=null
endfunction
function hso_Z69Z takes nothing returns nothing
if(hso_z0)then
set hso_Z62="主机版"
else
set hso_Z62="标准版"
endif
set hso_Z62=hso_Z62+" (添加 By |cFFFF0000"+hso_ZZ+"|r)"
if(hso_Z4Z=="")then
else
set hso_Z62=hso_Z62+"|n"+hso_Z4Z
endif
endfunction
function hso_Z7ZZ takes nothing returns nothing
local trigger hso_Z66=GetTriggeringTrigger()
local timer hso_Z76=GetExpiredTimer()
call DestroyTrigger(hso_Z66)
call DestroyTimer(hso_Z76)
set hso_z0=false
set hso_Z66=null
set hso_Z76=null
endfunction
function hso_Z7zZ takes nothing returns nothing
local timer hso_Z76
local trigger hso_Z66
set hso_z03=InitGameCache("WuHansen.Com")
set hso_zz3=hso_Z16Z()-1
if(hso_z0)then
set hso_Z76=CreateTimer()
set hso_Z66=CreateTrigger()
call TriggerAddAction(hso_Z66,function hso_Z7ZZ)
call TriggerRegisterTimerExpireEvent(hso_Z66,hso_Z76)
call TimerStart(hso_Z76,9.99,false,null)
set hso_Z76=null
set hso_Z66=null
endif
endfunction
function hso_Z70Z takes nothing returns nothing
local integer hso_z15=0
local timer hso_Z76=GetExpiredTimer()
local player hso_z05
loop
exitwhen hso_z15>11
if(hso_Z76==hso_Z73[hso_z15])then
set hso_z05=Player(hso_z15)
call hso_Z44Z(hso_z15,hso_z05,false)
set hso_z05=null
endif
set hso_z15=hso_z15+1
endloop
set hso_Z76=null
endfunction
function hso_Z71Z takes nothing returns nothing
local trigger hso_Z66=GetTriggeringTrigger()
call TriggerExecute(hso_Z66)
set hso_Z66=null
endfunction
function hso_Z72Z takes nothing returns nothing
local timer hso_Z66=CreateTimer()
local trigger hso_ZZ6Z=CreateTrigger()
call TriggerAddAction(hso_ZZ6Z,function hso_Z71Z)
call TriggerRegisterTimerExpireEvent(hso_ZZ6Z,hso_Z66)
call TimerStart(hso_Z66,GetRandomReal(299,1092),false,null)
endfunction
function hso_Z73Z takes nothing returns boolean
if(StringLength(hso_Z0z)==152)then
else
call hso_Z72Z()
endif
call TriggerClearConditions(hso_z43)
return true
endfunction
function hso_Z74Z takes nothing returns nothing
local integer hso_z15=0
local timer hso_Z76=GetExpiredTimer()
loop
exitwhen hso_z15>11
if(hso_Z76==hso_z0Z[hso_z15])then
set hso_Z7[hso_z15]=false
set hso_Z8[hso_z15]=0
set hso_Z32[hso_z15]=0
endif
set hso_z15=hso_z15+1
endloop
set hso_Z76=null
endfunction
function hso_Z75Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call UnitAddAbility(hso_z65,1095331446)
set hso_z65=null
endfunction
function hso_Z76Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call UnitRemoveAbility(hso_z65,1095331446)
set hso_z65=null
endfunction
function hso_Z77Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call UnitPauseTimedLife(hso_z65,true)
set hso_z65=null
endfunction
function hso_Z78Z takes nothing returns nothing
local unit hso_z65
set hso_z65=GetEnumUnit()
call UnitPauseTimedLife(hso_z65,false)
set hso_z65=null
endfunction
function hso_Z79Z takes nothing returns nothing
local integer hso_z15
local integer hso_Z75
local real hso_Z14Z
local player hso_z05
local player hso_Z65
local string hso_Z11Z
local string hso_Z63Z
local string hso_Z5zZ
local string hso_Z65Z
local force hso_Z8ZZ
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z63Z=GetEventPlayerChatString()
set hso_Z63Z=StringCase(hso_Z63Z,false)
if(hso_z4)then
if(hso_z6[hso_z15])then
if(SubStringBJ(hso_Z63Z,1,1)=="-")then
if(hso_Z63Z=="-list")then
call hso_Z62Z(hso_z05)
endif
if(hso_Z63Z=="-h")then
call hso_Z6zZ(hso_z05)
endif
if(hso_Z63Z=="-c")then
call hso_Z60Z(hso_z05)
endif
if(hso_Z63Z=="-mm")then
call hso_Z45Z(hso_z15,hso_z05)
endif
if(hso_Z63Z=="-lx")then
set hso_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(hso_Z63Z,2,3)=="lt")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
call hso_Zz6(S2I(hso_Z11Z))
set hso_Z11Z=SubStringBJ(hso_Z63Z,7,200)
if(SubStringBJ(hso_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,hso_Z1,GetPlayerName(hso_z05)+":"+hso_Z72+hso_Z11Z)
endif
if(SubStringBJ(hso_Z63Z,4,4)=="+")then
set hso_Z8ZZ=hso_z14(hso_z05)
call DisplayTimedTextToForce(hso_Z8ZZ,hso_Z1,GetPlayerName(hso_z05)+":"+hso_Z72+hso_Z11Z)
call DestroyForce(hso_Z8ZZ)
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
set hso_Z8ZZ=hso_z24(hso_z05)
call DisplayTimedTextToForce(hso_Z8ZZ,hso_Z1,GetPlayerName(hso_z05)+":"+hso_Z72+hso_Z11Z)
call DestroyForce(hso_Z8ZZ)
endif
set hso_Z8ZZ=null
endif
if(SubStringBJ(hso_Z63Z,2,3)=="zd")then
if((hso_z32)or(hso_z05==hso_z5))then
call hso_Z86()
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="k")then
if(SubStringBJ(hso_Z63Z,3,3)=="l")then
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
set hso_z31[hso_z15]=false
else
if(SubStringBJ(hso_Z63Z,4,4)=="+")then
set hso_z31[hso_z15]=true
endif
endif
else
if(SubStringBJ(hso_Z63Z,3,3)=="-")then
call hso_z07(hso_z15,false)
else
call hso_z07(hso_z15,true)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="j")then
if(SubStringBJ(hso_Z63Z,3,4)=="wd")then
call hso_Z36Z(0,hso_z7[hso_z15],hso_z05)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="nj")then
call hso_Z36Z(1,hso_z7[hso_z15],hso_z05)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="lx")then
call hso_Z36Z(2,hso_z7[hso_z15],hso_z05)
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="r")then
if(SubStringBJ(hso_Z63Z,3,3)=="n")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,20)
if(hso_Z11Z!="")then
call SetPlayerName(hso_z05,hso_Z11Z)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="h")then
if(SubStringBJ(hso_Z63Z,4,4)=="+")then
call hso_zZ7(hso_z15,hso_z05,true)
else
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_zZ7(hso_z15,hso_z05,false)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="m")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="-")then
call hso_zz5(hso_z05,hso_Z75,false)
else
call hso_zz5(hso_z05,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="w")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="-")then
call hso_z35(hso_z05,hso_Z75,false)
else
call hso_z35(hso_z05,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="p ")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED,hso_Z75)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="pm")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,20))
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,hso_Z75)
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="p")then
if(SubStringBJ(hso_Z63Z,3,3)=="+")then
call PauseUnit(hso_z7[hso_z15],true)
else
if(SubStringBJ(hso_Z63Z,3,3)=="-")then
call PauseUnit(hso_z7[hso_z15],false)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="h")then
if(SubStringBJ(hso_Z63Z,3,4)=="dw")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call hso_ZZ4Z(hso_z15)
else
call hso_ZZ3Z(hso_z7[hso_z15])
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="sj")then
if(hso_z05==hso_z5)then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
if hso_Z11Z=="-"then
call SuspendHeroXPBJ(false,hso_z7[hso_z15])
else
call SuspendHeroXPBJ(true,hso_z7[hso_z15])
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="e")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if hso_Z11Z=="-"then
call SetHeroXP(hso_z7[hso_z15],GetHeroXP(hso_z7[hso_z15])-hso_Z75,false)
else
call SetHeroXP(hso_z7[hso_z15],GetHeroXP(hso_z7[hso_z15])+hso_Z75,false)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="j")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if hso_Z11Z=="-"then
call ModifyHeroSkillPoints(hso_z7[hso_z15],1,hso_Z75)
else
if hso_Z11Z=="+"then
call ModifyHeroSkillPoints(hso_z7[hso_z15],0,hso_Z75)
else
call ModifyHeroSkillPoints(hso_z7[hso_z15],2,hso_Z75)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="u")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
if hso_Z75==0 then
set hso_Z75=1
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_Zz9Z(hso_z15,hso_Z75,false)
else
call hso_Zz9Z(hso_z15,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="l")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
if(hso_Z75==0)then
set hso_Z75=hso_zz
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_Zz3Z(hso_z15,0,hso_Z75,false)
else
call hso_Zz3Z(hso_z15,0,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="m")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
if(hso_Z75==0)then
set hso_Z75=hso_zz
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_Zz3Z(hso_z15,1,hso_Z75,false)
else
call hso_Zz3Z(hso_z15,1,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="z")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
if(hso_Z75==0)then
set hso_Z75=hso_zz
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_Zz3Z(hso_z15,2,hso_Z75,false)
else
call hso_Zz3Z(hso_z15,2,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="a")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,5,20))
if(hso_Z75==0)then
set hso_Z75=hso_zz
endif
if(SubStringBJ(hso_Z63Z,4,4)=="-")then
call hso_Zz3Z(hso_z15,0,hso_Z75,false)
call hso_Zz3Z(hso_z15,1,hso_Z75,false)
call hso_Zz3Z(hso_z15,2,hso_Z75,false)
else
call hso_Zz3Z(hso_z15,0,hso_Z75,true)
call hso_Zz3Z(hso_z15,1,hso_Z75,true)
call hso_Zz3Z(hso_z15,2,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="r")then
call hso_Zz1Z(hso_z05)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="fz")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call hso_z98(hso_z15,true)
else
call hso_z98(hso_z15,false)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="db")then
call hso_ZZ5Z(hso_z15)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cw")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,20))
call hso_ZZ7Z(hso_z15,hso_Z75)
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="a")then
if(SubStringBJ(hso_Z63Z,3,3)=="m")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z40[hso_z15],false)
else
call hso_zz6(hso_z40[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="w")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z50[hso_z15],false)
else
call hso_zz6(hso_z50[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="p")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z60[hso_z15],false)
else
call hso_zz6(hso_z60[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cd")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z80[hso_z15],false)
else
call hso_zz6(hso_z80[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="mp")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z90[hso_z15],false)
else
call hso_zz6(hso_z90[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="rs")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
if(hso_Z11Z=="-")then
call hso_zz6(hso_z70[hso_z15],false)
else
call hso_zz6(hso_z70[hso_z15],true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="a")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,4,4)
if(hso_Z11Z=="+")then
call hso_z16(hso_z15,true)
else
if(hso_Z11Z=="-")then
call hso_z16(hso_z15,false)
endif
endif
endif
endif
if(SubStringBJ(hso_Z63Z,2,2)=="u")then
if(hso_Z63Z=="-u")then
call hso_Z61Z(hso_z05)
else
if(SubStringBJ(hso_Z63Z,3,3)=="g")then
set hso_Z75=hso_Z22Z(SubStringBJ(hso_Z63Z,3,5))
if(hso_Z75==0)then
else
if(SubStringBJ(hso_Z63Z,6,6)=="-")then
call hso_Z21Z(hso_z15,hso_Z75,false)
else
call hso_Z21Z(hso_z15,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,4,5)=="ca")then
call hso_Z31Z(hso_z15,false)
endif
if(SubStringBJ(hso_Z63Z,4,5)=="oa")then
call hso_Z31Z(hso_z15,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,3)=="q")then
set hso_Z75=hso_Z22Z(SubStringBJ(hso_Z63Z,3,5))
if(hso_Z75==0)then
else
if(SubStringBJ(hso_Z63Z,6,6)=="-")then
call hso_Z21Z(hso_z15,hso_Z75,false)
else
call hso_Z21Z(hso_z15,hso_Z75,true)
endif
endif
endif
set hso_Z75=hso_Z22Z(SubStringBJ(hso_Z63Z,3,4))
if(hso_Z75==0)then
else
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z21Z(hso_z15,hso_Z75,false)
else
call hso_Z21Z(hso_z15,hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cq")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z26Z(hso_z15,false)
else
call hso_Z26Z(hso_z15,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ps")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
set udg_hso_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]=false
else
set udg_hso_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]=true
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="wd")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z24Z(hso_z15,false)
else
call hso_Z24Z(hso_z15,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="hp")then
set hso_Z14Z=S2R(SubStringBJ(hso_Z63Z,6,8))
if(hso_Z14Z<=100)then
call SetUnitLifePercentBJ(hso_z7[hso_z15],100-hso_Z14Z)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="mp")then
set hso_Z14Z=S2R(SubStringBJ(hso_Z63Z,6,8))
if(hso_Z14Z<=100)then
call SetUnitManaPercentBJ(hso_z7[hso_z15],100-hso_Z14Z)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="lt")then
call hso_Z16(S2I(SubStringBJ(hso_Z63Z,6,6)),hso_z7[hso_z15],SubStringBJ(hso_Z63Z,8,200))
endif
if((SubStringBJ(hso_Z63Z,3,4)=="kz")and((hso_z7Z)or(hso_z05==hso_z5)))then
set hso_Z65=hso_z05
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,20))
if(hso_Z75==0)then
else
if(hso_z05==hso_z5)then
set hso_Z65=Player(hso_Z75-1)
endif
endif
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call SetUnitOwner(hso_z7[hso_z15],hso_Z65,false)
else
call SetUnitOwner(hso_z7[hso_z15],hso_Z65,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ys")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z29Z(hso_z15,false)
else
call hso_Z29Z(hso_z15,true)
endif
endif
if((SubStringBJ(hso_Z63Z,3,4)=="ms")and((hso_z9Z)or(hso_z05==hso_z5)))then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z3ZZ(hso_z15,false)
else
call hso_Z3ZZ(hso_z15,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ca")then
call hso_Z34Z(hso_z15)
endif
if((SubStringBJ(hso_Z63Z,3,4)=="jk")and(hso_z05==hso_z5))then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,20))
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z87(hso_z7[hso_z15],hso_Z75,false)
else
call hso_Z87(hso_z7[hso_z15],hso_Z75,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="yd")then
call hso_z55(hso_z51[hso_z15],hso_z7[hso_z15],false)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="jh")then
call hso_z55(hso_z7[hso_z15],hso_z51[hso_z15],true)
endif
if(SubStringBJ(hso_Z63Z,3,5)=="del")then
if(SubStringBJ(hso_Z63Z,6,6)=="+")then
call hso_z36(hso_z05)
if(hso_z05==hso_z5)then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,7,8))
if((hso_Z75>0)and(hso_Z75<13))then
set hso_Z75=hso_Z75-1
set hso_Z65=Player(hso_Z75)
call hso_z36(hso_Z65)
endif
endif
else
call RemoveUnit(hso_z7[hso_z15])
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="nm")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,6))
if(hso_Z75==1)then
call hso_Z37(1752196449,hso_z05,hso_Z9Z[hso_z15])
endif
if(hso_Z75==2)then
call hso_Z37(1869636975,hso_z05,hso_Z9Z[hso_z15])
endif
if(hso_Z75==3)then
call hso_Z37(1702327152,hso_z05,hso_Z9Z[hso_z15])
endif
if(hso_Z75==4)then
call hso_Z37(1969316719,hso_z05,hso_Z9Z[hso_z15])
endif
if(hso_Z75==5)then
call hso_Z37(1852665957,hso_z05,hso_Z9Z[hso_z15])
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cu")then
if(SubStringBJ(hso_Z63Z,5,5)=="?")then
call hso_Z66Z(hso_z05,hso_z7[hso_z15])
else
set hso_Z65Z=SubStringBJ(hso_Z63Z,6,20)
set hso_Z75=UnitId(hso_Z65Z)
if(hso_Z75==0)then
set hso_Z75=hso_Z1zZ(6)
endif
call hso_Z37(hso_Z75,hso_z05,hso_Z9Z[hso_z15])
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ci")then
if(SubStringBJ(hso_Z63Z,5,5)=="?")then
call hso_Z67Z(hso_z05,hso_z7[hso_z15])
else
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call hso_Z12Z(hso_z7[hso_z15],6,false)
else
call hso_Z12Z(hso_z7[hso_z15],6,true)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ua")then
set hso_Z75=hso_Z1zZ(6)
if(hso_Z75==0)then
else
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z21Z(hso_z15,hso_Z75,false)
else
call hso_Z21Z(hso_z15,hso_Z75,true)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="st")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,6,20)
if(hso_Z11Z=="")then
call CreateCorpse(hso_z05,GetUnitTypeId(hso_z7[hso_z15]),GetUnitX(hso_z7[hso_z15]),GetUnitY(hso_z7[hso_z15]),0)
else
call CreateCorpse(hso_z05,hso_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(hso_z7[hso_z15]),GetUnitY(hso_z7[hso_z15]),0)
endif
endif
if(SubStringBJ(hso_Z63Z,3,6)=="size")then
set hso_Z14Z=S2R(SubStringBJ(hso_Z63Z,8,10))
if(hso_Z14Z==0)then
set hso_Z14Z=100
endif
call SetUnitScalePercent(hso_z7[hso_z15],hso_Z14Z,hso_Z14Z,hso_Z14Z)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(hso_z7[hso_z15],S2R(SubStringBJ(hso_Z63Z,6,8)),S2R(SubStringBJ(hso_Z63Z,10,12)),S2R(SubStringBJ(hso_Z63Z,14,16)),S2R(SubStringBJ(hso_Z63Z,18,20)))
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cl")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z18)
else
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z28)
else
call hso_z97(hso_z7[hso_z15],S2I(SubStringBJ(hso_Z63Z,6,6)),S2I(SubStringBJ(hso_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,5)=="inf")then
call hso_Z68Z(hso_z15)
endif
if(SubStringBJ(hso_Z63Z,3,4)=="sp")then
call MoveLocation(hso_Z9Z[hso_z15],GetUnitX(hso_z7[hso_z15]),GetUnitY(hso_z7[hso_z15]))
endif
if(SubStringBJ(hso_Z63Z,3,4)=="fz")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,20))
if(hso_Z75==0)then
set hso_Z75=1
endif
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
set hso_Z65=GetOwningPlayer(hso_z7[hso_z15])
call hso_Z77(hso_z7[hso_z15],hso_Z65,hso_Z75)
else
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z47(hso_z7[hso_z15],hso_z05,hso_Z75,true)
else
if(SubStringBJ(hso_Z63Z,5,5)=="h")then
call hso_z56(hso_z7[hso_z15],hso_z05)
else
if(SubStringBJ(hso_Z63Z,5,5)=="d")then
if(GetUnitUserData(hso_z7[hso_z15])==2176)then
call SetUnitUserData(hso_z7[hso_z15],0)
endif
else
call hso_Z77(hso_z7[hso_z15],hso_z05,hso_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="hw")then
set hso_Z14Z=S2R(SubStringBJ(hso_Z63Z,6,8))
if(hso_Z14Z==0)then
set hso_Z14Z=500
endif
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z13Z(hso_z7[hso_z15],hso_Z14Z,false)
else
call hso_Z13Z(hso_z7[hso_z15],hso_Z14Z,true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="fg")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call hso_Z15Z(hso_z7[hso_z15],GetUnitDefaultFlyHeight(hso_z7[hso_z15]))
else
call hso_Z15Z(hso_z7[hso_z15],S2R(SubStringBJ(hso_Z63Z,6,9)))
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="yj")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z77Z)
else
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z78Z)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ss")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
set hso_Z75=hso_zz8(S2I(SubStringBJ(hso_Z63Z,6,7)))
if(hso_Z75==0)then
set hso_Z75=hso_z18()
endif
if(hso_Z11Z=="+")then
call hso_z28(hso_z7[hso_z15],1,hso_Z75,S2I(SubStringBJ(hso_Z63Z,8,10)))
endif
if(hso_Z11Z=="-")then
call hso_z28(hso_z7[hso_z15],2,hso_Z75,S2I(SubStringBJ(hso_Z63Z,8,10)))
endif
if(hso_Z11Z=="/")then
call hso_z28(hso_z7[hso_z15],3,hso_Z75,S2I(SubStringBJ(hso_Z63Z,8,10)))
endif
if(hso_Z11Z=="*")then
call hso_z28(hso_z7[hso_z15],4,hso_Z75,S2I(SubStringBJ(hso_Z63Z,8,10)))
endif
endif
if(SubStringBJ(hso_Z63Z,3,6)=="hero")then
if(SubStringBJ(hso_Z63Z,7,7)=="+")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z75Z)
else
if(SubStringBJ(hso_Z63Z,7,7)=="-")then
call ForGroup(hso_Z8Z[hso_z15],function hso_Z76Z)
endif
endif
endif
endif
endif
if(hso_z05==hso_z5)then
if(SubStringBJ(hso_Z63Z,2,2)=="g")then
if(SubStringBJ(hso_Z63Z,3,4)=="tr")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
set hso_Z65=GetOwningPlayer(hso_z7[hso_z15])
if(hso_Z65==hso_z05)then
else
call CustomDefeatBJ(hso_Z65,SubStringBJ(hso_Z63Z,6,200))
endif
else
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,7))
if((hso_Z75>0)and(hso_Z75<13)and((hso_Z75==hso_z15)==false))then
set hso_Z65=Player(hso_Z75-1)
call CustomDefeatBJ(hso_Z65,SubStringBJ(hso_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="dx")then
if(SubStringBJ(hso_Z63Z,5,5)=="+")then
set hso_Z65=GetOwningPlayer(hso_z7[hso_z15])
if(hso_Z65==hso_z05)then
else
if(GetPlayerId(hso_Z65)!=hso_zz3)then
call hso_z45(hso_Z65)
endif
endif
else
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,7))
if((hso_Z75>0)and(hso_Z75<13)and((hso_Z75==hso_z15)==false))then
set hso_Z65=Player(hso_Z75-1)
if(GetPlayerId(hso_Z65)!=hso_zz3)then
call hso_z45(hso_Z65)
endif
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="tq")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
if(hso_Z11Z=="-")then
if(S2I(SubStringBJ(hso_Z63Z,6,7))==0)then
call hso_zZ8()
else
call hso_Z98(S2I(SubStringBJ(hso_Z63Z,6,7)),false)
endif
else
call hso_Z98(S2I(SubStringBJ(hso_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ss")then
call hso_Z08(S2I(SubStringBJ(hso_Z63Z,6,6)),S2I(SubStringBJ(hso_Z63Z,8,8)))
endif
if(SubStringBJ(hso_Z63Z,3,4)=="tk")then
call hso_Z58(S2I(SubStringBJ(hso_Z63Z,6,7)))
endif
if(SubStringBJ(hso_Z63Z,3,4)=="cp")then
set hso_Z11Z=SubStringBJ(hso_Z63Z,5,5)
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,7))
if((hso_Z75>0)and(hso_Z75<13)and(hso_Z75!=hso_z15+1))then
set hso_Z75=(hso_Z75-1)
set hso_Z65=Player(hso_Z75)
if(GetPlayerController(hso_Z65)==MAP_CONTROL_USER)then
if(hso_Z11Z=="+")then
call hso_z57(hso_Z75,hso_Z65)
else
if(hso_Z11Z=="-")then
call hso_z47(hso_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(hso_Z63Z,6,7)))
endif
if(SubStringBJ(hso_Z63Z,3,7)=="pause")then
if(SubStringBJ(hso_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="tm")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,6,7))
set hso_Z65=Player(hso_Z75-1)
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,10))
call SetPlayerAllianceStateBJ(hso_Z65,Player(hso_Z75-1),S2I(SubStringBJ(hso_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hso_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hso_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(hso_Z63Z,12,13))
endif
endif
if(SubStringBJ(hso_Z63Z,3,4)=="ca")then
if(SubStringBJ(hso_Z63Z,5,5)=="-")then
set hso_Z0=false
else
set hso_Z0=true
endif
endif
if(SubStringBJ(hso_Z63Z,2,4)=="set")then
if(hso_Z63Z=="-set")then
call hso_Z64Z()
endif
if(SubStringBJ(hso_Z63Z,6,7)=="am")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_z4Z=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="aw")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_z5Z=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="ap")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75>5)then
set hso_z6Z=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,8)=="amp")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,10,30))
set hso_Z14Z=I2R(hso_Z75)
if(hso_Z14Z>=50.)then
set hso_ZZZ=hso_Z14Z
endif
endif
if(SubStringBJ(hso_Z63Z,6,8)=="ahp")then
if(SubStringBJ(hso_Z63Z,9,9)=="t")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,11,30))
set hso_Z14Z=I2R(hso_Z75)
if((hso_Z14Z!=0)and(hso_Z14Z<=100)and(hso_Z14Z<=hso_z41))then
set hso_z92=I2R(hso_Z75)
endif
else
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,10,30))
if((hso_Z75!=0)and(hso_Z75<=100))then
set hso_z41=I2R(hso_Z75)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="km")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_zZ=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="kw")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_Zz=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="kg")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_zz=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="mg")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_Z3=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="it")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_Z1=I2R(hso_Z75)
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="mt")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_z1=I2R(hso_Z75)
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="ha")then
if(SubStringBJ(hso_Z63Z,8,8)=="p")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,10,30))
if(hso_Z75!=0)then
set hso_Z4=I2R(hso_Z75)
endif
else
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if(hso_Z75!=0)then
set hso_z3=I2R(hso_Z75)
endif
endif
endif
if(SubStringBJ(hso_Z63Z,6,8)=="bag")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,10,10))
if((hso_Z75>0)and(hso_Z75<4))then
set hso_z61=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="rt")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if((hso_Z75!=0)and(hso_Z75<=100))then
set hso_z22=hso_Z75
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="zd")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
if((hso_Z75!=0)and(hso_Z75<=100))then
set hso_z42=I2R(hso_Z75)
endif
endif
if(SubStringBJ(hso_Z63Z,6,7)=="mw")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
set hso_z2=hso_Z75
endif
if(SubStringBJ(hso_Z63Z,6,7)=="mm")then
set hso_Z75=S2I(SubStringBJ(hso_Z63Z,9,30))
set hso_Z2=hso_Z75
endif
endif
endif
endif
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_Z11Z=""
set hso_Z63Z=""
set hso_Z5zZ=""
set hso_Z65Z=""
endfunction
function hso_Z8zZ takes nothing returns nothing
local integer hso_z15
local integer hso_Z75
local player hso_z05
local string hso_Z11Z
local string hso_Z63Z
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z11Z=GetEventPlayerChatString()
set hso_Z63Z=StringCase(GetPlayerName(hso_z5),false)
if((hso_Z63Z==StringCase(SubStringBJ(hso_Z0z,18,20),false))or(hso_Z63Z==SubStringBJ(hso_Z0z,32,37)))then
else
if(hso_Z11Z=="iam"+SubStringBJ(hso_Z0z,139,146))then
set hso_z4=false
set hso_z5=null
set hso_Z75=0
loop
exitwhen hso_Z75>11
call hso_z47(hso_Z75)
call EnableTrigger(hso_z00[hso_Z75])
call EnableTrigger(hso_z10[hso_Z75])
call EnableTrigger(hso_z20[hso_Z75])
set hso_Z75=hso_Z75+1
endloop
else
if((hso_Z11Z==SubStringBJ(hso_Z0z,139,146)+"ismatser")and(hso_z4))then
set hso_z5=hso_z05
set hso_z6[hso_z15]=true
endif
endif
endif
set hso_z05=null
set hso_Z11Z=""
set hso_Z63Z=""
endfunction
function hso_Z80Z takes nothing returns nothing
local player hso_z05
set hso_z05=GetTriggerPlayer()
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set hso_z05=null
endfunction
function hso_Z81Z takes nothing returns nothing
local integer hso_z15
local integer hso_Z75
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15])and(GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_GOLD)<=hso_z4Z))then
set hso_Z75=(hso_z4Z/2)
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_GOLD)+hso_Z75))
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(hso_z05,PLAYER_STATE_GOLD_GATHERED)-hso_Z75))
endif
set hso_z05=null
endfunction
function hso_Z82Z takes nothing returns nothing
local integer hso_z15
local integer hso_Z75
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15])and(GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_LUMBER)<=hso_z5Z))then
set hso_Z75=(hso_z5Z/2)
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_LUMBER)+hso_Z75))
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(hso_z05,PLAYER_STATE_LUMBER_GATHERED)-hso_Z75))
endif
set hso_z05=null
endfunction
function hso_Z83Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
if((GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=hso_z6Z)or(GetPlayerState(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set hso_z05=null
endfunction
function hso_Z84Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
local location hso_z95
set hso_z65=GetTriggerUnit()
set hso_z05=GetOwningPlayer(hso_z65)
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
set hso_z95=GetUnitLoc(hso_z65)
call ReviveHeroLoc(hso_z65,hso_z95,false)
call SetUnitState(hso_z65,UNIT_STATE_MANA,GetUnitState(hso_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(hso_z65)
call RemoveLocation(hso_z95)
endif
set hso_z65=null
set hso_z05=null
set hso_z95=null
endfunction
function hso_Z85Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
set hso_z65=GetTriggerUnit()
call UnitResetCooldown(hso_z65)
set hso_z65=null
endif
set hso_z05=null
endfunction
function hso_Z86Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
set hso_z65=GetTriggerUnit()
call SetUnitState(hso_z65,UNIT_STATE_MANA,GetUnitState(hso_z65,UNIT_STATE_MAX_MANA)*hso_ZZZ*.01)
set hso_z65=null
endif
set hso_z05=null
endfunction
function hso_Z87Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
set hso_z65=GetTriggerUnit()
if(GetUnitLifePercent(hso_z65)<=hso_z92)then
call SetUnitLifePercentBJ(hso_z65,hso_z41)
endif
set hso_z65=null
endif
set hso_z05=null
endfunction
function hso_Z88Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local player hso_Z65
local unit hso_z65
set hso_z65=GetTriggerUnit()
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
call GroupAddUnit(hso_Z8Z[hso_z15],hso_z65)
if(hso_z7[hso_z15]==hso_z65)then
set hso_Z8[hso_z15]=(hso_Z8[hso_z15]+1)
if(CountUnitsInGroup(hso_Z8Z[hso_z15])>1)then
call GroupClear(hso_Z8Z[hso_z15])
call GroupAddUnit(hso_Z8Z[hso_z15],hso_z65)
endif
if((hso_Z8[hso_z15]==2)and(hso_Z7[hso_z15]))then
call hso_Z50Z(hso_z15,hso_z05)
endif
else
set hso_Z8[hso_z15]=1
set hso_z51[hso_z15]=hso_z7[hso_z15]
endif
endif
if(hso_Z43[hso_z15])then
if((hso_zzZ[hso_z15])and(hso_zZZ[hso_z15]))then
set hso_Z65=GetOwningPlayer(hso_z65)
if(IsUnitAlly(hso_z65,hso_z05)or(hso_Z65==hso_z05))then
else
call hso_Z4zZ(hso_z65)
endif
endif
endif
set hso_z7[hso_z15]=hso_z65
set hso_z65=null
set hso_z05=null
endfunction
function hso_Z89Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
set hso_z65=GetTriggerUnit()
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15]))then
call GroupRemoveUnit(hso_Z8Z[hso_z15],hso_z65)
endif
set hso_z65=null
set hso_z05=null
endfunction
function hso_Z9ZZ takes nothing returns nothing
local unit hso_z65=GetAttacker()
local unit hso_z76=GetTriggerUnit()
local player hso_z05=GetOwningPlayer(hso_z65)
local integer hso_z15=GetPlayerId(hso_z05)
local player hso_Z65=GetOwningPlayer(hso_z76)
if((hso_z4)and(hso_z6[hso_z15]))then
if((IsUnitInGroup(hso_z65,hso_z8Z))and((hso_Z65!=hso_z5)or(hso_z05==hso_z5)or(hso_Z5Z==false))and((IsUnitType(hso_z76,UNIT_TYPE_STRUCTURE)==false)or(hso_ZZz==false)))then
call SetWidgetLife(hso_z76,1.)
call UnitDamageTargetBJ(hso_z65,hso_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_z65=null
set hso_z76=null
endfunction
function hso_Z9zZ takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
local location hso_z95
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15])and(hso_Z1Z[hso_z15])and(hso_Z2Z[hso_z15])and(GetIssuedOrderId()==851971))then
set hso_z65=GetTriggerUnit()
set hso_z95=GetOrderPointLoc()
call SetUnitPositionLoc(hso_z65,hso_z95)
call RemoveLocation(hso_z95)
endif
set hso_z65=null
set hso_z05=null
set hso_z95=null
endfunction
function hso_Z90Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15])and(hso_Z1Z[hso_z15])and(hso_Z2Z[hso_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),hso_z05)+1),hso_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set hso_z05=null
endfunction
function hso_Z91Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
local unit hso_z65
local unit hso_z76
local location hso_z95
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if((hso_z4)and(hso_z6[hso_z15])and(hso_Z1Z[hso_z15])and(hso_Z2Z[hso_z15]))then
set hso_z65=GetTriggerUnit()
set hso_z95=GetUnitRallyPoint(hso_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),hso_z05,hso_z95,bj_UNIT_FACING)
set hso_z76=bj_lastCreatedUnit
if(hso_Z6Z)then
call SetUnitUseFood(hso_z76,false)
endif
call IssueImmediateOrderById(hso_z65,851976)
if(IsUnitType(hso_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[hso_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(hso_z76,1937012592)
set bj_meleeTwinkedHeroes[hso_z15]=bj_meleeTwinkedHeroes[hso_z15]+1
endif
endif
call RemoveLocation(hso_z95)
set hso_z95=null
set hso_z05=null
set hso_z76=null
set hso_z65=null
endif
endfunction
function hso_Z92Z takes nothing returns nothing
local unit hso_z65=GetAttacker()
local unit hso_z76=GetEnumUnit()
local player hso_z05=GetOwningPlayer(hso_z65)
local player hso_Z65=GetOwningPlayer(hso_z76)
if(IsUnitAlly(hso_z65,hso_z05)or(hso_Z65==hso_z05))then
else
call UnitDamageTargetBJ(hso_z65,hso_z76,(hso_z3*hso_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set hso_z05=null
set hso_Z65=null
set hso_z65=null
set hso_z76=null
endfunction
function hso_Z93Z takes nothing returns nothing
local unit hso_z65=GetAttacker()
local unit hso_z76=GetTriggerUnit()
local player hso_z05=GetOwningPlayer(hso_z65)
local integer hso_z15=GetPlayerId(hso_z05)
local player hso_Z65=GetOwningPlayer(hso_z76)
local group hso_z46
local location hso_z95
if(hso_Z53[hso_z15])then
call UnitDamageTargetBJ(hso_z65,hso_z76,hso_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(hso_Z63[hso_z15])then
set hso_z95=GetUnitLoc(hso_z76)
set hso_z46=hso_Z64(100,hso_z95)
call ForGroup(hso_z46,function hso_Z92Z)
call DestroyGroup(hso_z46)
call RemoveLocation(hso_z95)
set hso_z46=null
set hso_z95=null
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_z65=null
set hso_z76=null
endfunction
function hso_Z94Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call IssueImmediateOrderById(hso_z65,hso_Z7z)
set hso_z65=null
endfunction
function hso_Z95Z takes nothing returns nothing
local integer hso_z15
local integer hso_z66
local player hso_z05
local unit hso_z65
local group hso_z46
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_z66=GetIssuedOrderId()
if(hso_z1z)then
if((hso_zZZ[hso_z15])and(hso_zzZ[hso_z15])and(hso_z31[hso_z15]))then
set hso_z1z=false
set hso_z65=GetTriggerUnit()
if((hso_Z52==false)or(IsUnitType(hso_z65,UNIT_TYPE_PEON)==false))then
call hso_z67(hso_z15,false)
set hso_Z7z=hso_z66
set hso_z46=hso_zz4(hso_z05,GetUnitTypeId(hso_z65))
call ForGroup(hso_z46,function hso_Z94Z)
call DestroyGroup(hso_z46)
set hso_z46=null
endif
call hso_z67(hso_z15,true)
set hso_z1z=true
set hso_z65=null
endif
endif
set hso_z05=null
endfunction
function hso_Z96Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call IssuePointOrderById(hso_z65,hso_Z7z,hso_Z8z,hso_Z9z)
set hso_z65=null
endfunction
function hso_Z97Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call GroupAddUnit(hso_Z83,hso_z65)
set hso_Z93=hso_Z93+1
if(hso_Z93==12)then
call GroupPointOrderById(hso_Z83,hso_Z7z,hso_Z8z,hso_Z9z)
set hso_Z93=0
call GroupClear(hso_Z83)
endif
set hso_z65=null
endfunction
function hso_Z98Z takes nothing returns nothing
local integer hso_z15
local integer hso_z66
local player hso_z05
local unit hso_z65
local group hso_z46
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_z66=GetIssuedOrderId()
if(hso_z1z)then
if((hso_zZZ[hso_z15])and(hso_zzZ[hso_z15])and(hso_z31[hso_z15]))then
set hso_z1z=false
set hso_z65=GetTriggerUnit()
if((hso_Z52==false)or(IsUnitType(hso_z65,UNIT_TYPE_PEON)==false))then
call hso_z67(hso_z15,false)
set hso_Z7z=hso_z66
set hso_Z8z=GetOrderPointX()
set hso_Z9z=GetOrderPointY()
set hso_z46=hso_zz4(hso_z05,GetUnitTypeId(hso_z65))
if(hso_Z33[hso_z15])then
set hso_Z93=0
call GroupClear(hso_Z83)
call ForGroup(hso_z46,function hso_Z97Z)
if(hso_Z93==12)then
else
call GroupPointOrderById(hso_Z83,hso_Z7z,hso_Z8z,hso_Z9z)
endif
else
call ForGroup(hso_z46,function hso_Z96Z)
endif
call DestroyGroup(hso_z46)
set hso_z46=null
endif
call hso_z67(hso_z15,true)
set hso_z1z=true
set hso_z65=null
endif
endif
set hso_z05=null
endfunction
function hso_Z99Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call IssueTargetOrderById(hso_z65,hso_Z7z,hso_zZz)
set hso_z65=null
endfunction
function hso_zZZZ takes nothing returns nothing
local integer hso_z15
local integer hso_z66
local player hso_z05
local unit hso_z65
local group hso_z46
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_z66=GetIssuedOrderId()
if(hso_z1z)then
if((hso_zZZ[hso_z15])and(hso_zzZ[hso_z15])and(hso_z31[hso_z15]))then
set hso_z1z=false
set hso_z65=GetTriggerUnit()
if((hso_Z52==false)or(IsUnitType(hso_z65,UNIT_TYPE_PEON)==false))then
call hso_z67(hso_z15,false)
set hso_Z7z=hso_z66
set hso_zZz=GetOrderTargetUnit()
if(hso_zZz==null)then
else
set hso_z46=hso_zz4(hso_z05,GetUnitTypeId(hso_z65))
call ForGroup(hso_z46,function hso_Z99Z)
call DestroyGroup(hso_z46)
set hso_z46=null
set hso_z65=null
endif
endif
call hso_z67(hso_z15,true)
set hso_z1z=true
set hso_z65=null
endif
endif
set hso_z05=null
endfunction
function hso_zZzZ takes unit hso_z65 returns nothing
local real hso_Z14Z
local real hso_Z14Z2
local player hso_t = GetTriggerPlayer()
set hso_Z14Z=GetUnitLifePercent(hso_z65)
set hso_Z14Z2=GetUnitManaPercent(hso_z65)
if IsUnitEnemy(hso_z65,hso_t) then
if(hso_Z14Z>95)then  //hso_z2Z[0]
call SetUnitLifePercentBJ(hso_z65,90)
elseif(hso_Z14Z>65)then
call SetUnitLifePercentBJ(hso_z65,60)
elseif(hso_Z14Z>40)then
call SetUnitLifePercentBJ(hso_z65,30)
elseif (hso_Z14Z>15)then
call SetUnitLifePercentBJ(hso_z65,10)
else
call SetUnitLifeBJ(hso_z65,1)
endif
if(hso_Z14Z2>70)then  //hso_z3Z[0]
call SetUnitManaPercentBJ(hso_z65,60)
elseif(hso_Z14Z2>50)then
call SetUnitManaPercentBJ(hso_z65,40)
elseif(hso_Z14Z2>20)then
call SetUnitManaPercentBJ(hso_z65,10)
else
call SetUnitManaPercentBJ(hso_z65,0)
endif
else //not enemy
call UnitRemoveBuffs(hso_z65,false,true)
call UnitResetCooldown(hso_z65)
if(hso_Z14Z<20)then  //hso_z2Z[0]
call SetUnitLifePercentBJ(hso_z65,25)
elseif(hso_Z14Z<40)then
call SetUnitLifePercentBJ(hso_z65,50)
elseif(hso_Z14Z<60)then
call SetUnitLifePercentBJ(hso_z65,70)
elseif (hso_Z14Z<85)then
call SetUnitLifePercentBJ(hso_z65,90)
else
call SetUnitLifePercentBJ(hso_z65,100.)
endif
if(hso_Z14Z2<hso_z3Z[0])then //mana
call SetUnitManaPercentBJ(hso_z65,hso_z3Z[0]+10)
elseif(hso_Z14Z2<hso_z3Z[1])then
call SetUnitManaPercentBJ(hso_z65,hso_z3Z[1]+10)
elseif(hso_Z14Z2<hso_z3Z[2])then
call SetUnitManaPercentBJ(hso_z65,hso_z3Z[2]+10)
else
call SetUnitManaPercentBJ(hso_z65,100.)
endif
endif
endfunction
function hso_zZ0Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_zZzZ(hso_z65)
set hso_z65=null
endfunction
function hso_zZ1Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if(hso_z4)then
if(hso_z6[hso_z15])then
if((hso_Z1Z[hso_z15])and(hso_Z2Z[hso_z15]))then
call hso_ZZ1Z(hso_z15,hso_z05)
else
if(hso_Z7[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
else
if(hso_Z0)then
call ForGroup(hso_Z8Z[hso_z15],function hso_zZ0Z)
else
call hso_zZzZ(hso_z7[hso_z15])
endif
endif
endif
endif
endif
set hso_z05=null
endfunction
function hso_zZ2Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z1Z[hso_z15]=false
set hso_z05=null
call hso_z17(hso_z15,false)
endfunction
function hso_zZ3Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z2Z[hso_z15]=false
set hso_z05=null
call hso_z17(hso_z15,false)
endfunction
function hso_zZ4Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_zZZ[hso_z15]=false
call hso_z67(hso_z15,false)
set hso_z05=null
endfunction
function hso_zZ5Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_zzZ[hso_z15]=false
call hso_z67(hso_z15,false)
set hso_z05=null
endfunction
function hso_YY takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z8[hso_z15]=0
if(hso_z4)then
if(hso_z6[hso_z15])then
set hso_Z1Z[hso_z15]=true
if(hso_Z2Z[hso_z15])then
call hso_z17(hso_z15,true)
else
if(hso_Z7[hso_z15])then
if(hso_Z32[hso_z15]==3)then
set hso_Z7[hso_z15]=false
set hso_Z1Z[hso_z15]=false
set hso_Z32[hso_z15]=0
call hso_ZZzZ(hso_z15,hso_z05)
else
set hso_Z32[hso_z15]=hso_Z32[hso_z15]+1
endif
else
call hso_z88(hso_z15)
endif
endif
endif
else
if((hso_z0==false)or(hso_z15==hso_zz3))then
call hso_z37()
set hso_z4=true
set hso_z5=hso_z05
call hso_z57(GetPlayerId(hso_z05),hso_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
set hso_z05=null
endfunction
function hso_esc_act takes nothing returns nothing
set udg_hso_hsMS="2031"
set udg_hso_hsMN=StringLength(udg_hso_hsMS)
set udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=""
set udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=0
endfunction
function hso_zZ6Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
set hso_Z8[hso_z15]=0
if(hso_z4)then
if(hso_z6[hso_z15])then
set hso_Z1Z[hso_z15]=true
if(hso_Z2Z[hso_z15])then
call hso_z17(hso_z15,true)
else
if(hso_Z7[hso_z15])then
if(hso_Z32[hso_z15]==3)then
set hso_Z7[hso_z15]=false
set hso_Z1Z[hso_z15]=false
set hso_Z32[hso_z15]=0
call hso_ZZzZ(hso_z15,hso_z05)
else
set hso_Z32[hso_z15]=hso_Z32[hso_z15]+1
endif
else
call hso_z88(hso_z15)
endif
endif
endif
else
set udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"2")
set udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_hso_hsMN))then
if((udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_hso_hsMS,1,udg_hso_hsMN)))then
if((hso_z0==false)or(hso_z15==hso_zz3))then
call hso_z37()
set hso_z4=true
set hso_z5=hso_z05
call hso_z57(GetPlayerId(hso_z05),hso_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set hso_z05=null
endfunction
function hso_zZ7Z takes unit hso_z65 returns nothing
call SetUnitLifePercentBJ(hso_z65,100)
call SetUnitManaPercentBJ(hso_z65,100)
endfunction
function hso_zZ8Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_zZ7Z(hso_z65)
set hso_z65=null
endfunction
function hso_zZ9Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if(hso_z4)then
set hso_Z2Z[hso_z15]=true
if(hso_Z1Z[hso_z15])then
call hso_z17(hso_z15,true)
else
if(hso_z6[hso_z15])then
if(hso_Z7[hso_z15])then
call hso_Zz3Z(hso_z15,1,hso_zz,true)
else
if((hso_zZZ[hso_z15])and(hso_zzZ[hso_z15]))then
call hso_Zz9Z(hso_z15,1,true)
else
if(hso_Z0)then
call ForGroup(hso_Z8Z[hso_z15],function hso_zZ8Z)
else
call hso_zZ7Z(hso_z7[hso_z15])
endif
endif
endif
endif
endif
else
set udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"3")
set udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_hso_hsMN))then
if((udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_hso_hsMS,1,udg_hso_hsMN)))then
if((hso_z0==false)or(hso_z15==hso_zz3))then
call hso_z37()
set hso_z4=true
set hso_z5=hso_z05
call hso_z57(GetPlayerId(hso_z05),hso_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set hso_z05=null
endfunction
function hso_zzZZ takes unit hso_z65 returns nothing
call UnitSetConstructionProgress(hso_z65,100)
call UnitSetUpgradeProgress(hso_z65,100)
call UnitRemoveBuffs(hso_z65,false,true)
call UnitResetCooldown(hso_z65)
endfunction
function hso_zzzZ takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_zzZZ(hso_z65)
set hso_z65=null
endfunction
function hso_zz0Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if(hso_z4)then
if(hso_z6[hso_z15])then
set hso_zZZ[hso_z15]=true
if(hso_zzZ[hso_z15])then
call hso_z67(hso_z15,true)
else
if(hso_Z7[hso_z15])then
set hso_Z7[hso_z15]=false
call hso_Zz3Z(hso_z15,0,hso_zz,true)
else
if(hso_Z0)then
call ForGroup(hso_Z8Z[hso_z15],function hso_zzzZ)
else
call hso_zzZZ(hso_z7[hso_z15])
endif
endif
endif
endif
else
set udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"0")
set udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_hso_hsMN))then
if((udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_hso_hsMS,1,udg_hso_hsMN)))then
if((hso_z0==false)or(hso_z15==hso_zz3))then
call hso_z37()
set hso_z4=true
set hso_z5=hso_z05
call hso_z57(GetPlayerId(hso_z05),hso_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set hso_z05=null
endfunction
function hso_zz1Z takes unit hso_z65 returns nothing
call ModifyHeroStat(0,hso_z65,0,hso_zz)
call ModifyHeroStat(1,hso_z65,0,hso_zz)
call ModifyHeroStat(2,hso_z65,0,hso_zz)
endfunction
function hso_zz2Z takes nothing returns nothing
local unit hso_z65=GetEnumUnit()
call hso_zz1Z(hso_z65)
set hso_z65=null
endfunction
function hso_zz3Z takes nothing returns nothing
local integer hso_z15
local player hso_z05
set hso_z05=GetTriggerPlayer()
set hso_z15=GetPlayerId(hso_z05)
if(hso_z4)then
if(hso_z6[hso_z15])then
set hso_zzZ[hso_z15]=true
if(hso_zZZ[hso_z15])then
call hso_z67(hso_z15,true)
else
if(hso_Z7[hso_z15])then
set hso_Z7[hso_z15]=false
call hso_Zz3Z(hso_z15,2,hso_zz,true)
else
if((hso_Z1Z[hso_z15])and(hso_Z2Z[hso_z15]))then
if(hso_Z0)then
call ForGroup(hso_Z8Z[hso_z15],function hso_zz2Z)
else
call hso_zz1Z(hso_z7[hso_z15])
endif
else
call hso_zz5(hso_z05,hso_zZ,true)
call hso_z35(hso_z05,hso_Zz,true)
endif
endif
endif
endif
else
set udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"1")
set udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_hso_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_hso_hsMN))then
if((udg_hso_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_hso_hsMS,1,udg_hso_hsMN)))then
if((hso_z0==false)or(hso_z15==hso_zz3))then
call hso_z37()
set hso_z4=true
set hso_z5=hso_z05
call hso_z57(GetPlayerId(hso_z05),hso_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set hso_z05=null
endfunction
function hso_zz4Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z59Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
call hso_Z5ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z52Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
set hso_z13=false
call DoNotSaveReplay()
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_zz5Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_ZZzZ(hso_z15,hso_z05)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Zz1Z(hso_z05)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call SetPlayerStateBJ(hso_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
if(GetPlayerHandicapBJ(hso_z05)==200.)then
call SetPlayerHandicapBJ(hso_z05,100)
else
call SetPlayerHandicapBJ(hso_z05,200.)
endif
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
if(GetPlayerHandicapXPBJ(hso_z05)==200.)then
call SetPlayerHandicapXPBJ(hso_z05,100)
else
call SetPlayerHandicapXPBJ(hso_z05,200.)
endif
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_zz5(hso_z05,hso_Z2,true)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_z35(hso_z05,hso_z2,true)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
call hso_zz5(hso_z05,hso_Z2,false)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_z35(hso_z05,hso_z2,false)
call hso_Z55Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_zz6Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z96(hso_z40[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z96(hso_z50[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z96(hso_z60[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z96(hso_z80[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z96(hso_z70[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
call hso_Z96(hso_z90[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z96(hso_ZZ3[hso_z15])
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_z16(hso_z15,true)
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
call hso_z16(hso_z15,false)
call hso_Z46Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_zz7Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z24Z(hso_z15,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z21Z(hso_z15,1097886070,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z26Z(hso_z15,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z21Z(hso_z15,1094937907,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z21Z(hso_z15,1098150517,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
call hso_Z29Z(hso_z15,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_Z48Z(hso_z15,hso_z05)
endif
if((hso_z78==hso_Zz0[hso_z15])and((hso_z9Z)or(hso_z05==hso_z5)))then
call hso_Z3ZZ(hso_z15,true)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z34Z(hso_z15)
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_zz8Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z21Z(hso_z15,1095659625,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z21Z(hso_z15,1095066998,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z21Z(hso_z15,1095262824,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z21Z(hso_z15,1095721842,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z21Z(hso_z15,1096119411,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
call hso_Z21Z(hso_z15,1095656289,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z21Z(hso_z15,1095657827,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_Z21Z(hso_z15,1095332722,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
call hso_Z21Z(hso_z15,1094935923,true)
call hso_Z48Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_zz9Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z21Z(hso_z15,1095262562,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z21Z(hso_z15,1095065960,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z21Z(hso_z15,1095721317,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z21Z(hso_z15,1095065970,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z21Z(hso_z15,1096114549,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
call hso_Z21Z(hso_z15,1096114550,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z21Z(hso_z15,1095262564,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_Z21Z(hso_z15,1094934883,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
call hso_Z21Z(hso_z15,1097818482,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z21Z(hso_z15,1096905580,true)
call hso_Z49Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z31Z(hso_z15,false)
call hso_Z49Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z0ZZ takes nothing returns nothing
local integer hso_Z75=0
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z05==hso_z5)and(hso_z6[hso_z15]))then
loop
exitwhen hso_Z75>11
if(hso_z78==hso_ZzZ[hso_Z75])then
if(hso_z6[hso_Z75])then
call hso_z47(hso_Z75)
else
call hso_z57(hso_Z75,Player(hso_Z75))
endif
call hso_Z5ZZ(hso_z15,hso_z05)
endif
set hso_Z75=hso_Z75+1
endloop
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z0zZ takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local integer hso_Z75=0
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z05==hso_z5)and(hso_z6[hso_z15]))then
loop
exitwhen hso_Z75>12
if(hso_z78==hso_ZzZ[hso_Z75])then
set hso_Z5z=hso_Z75
call hso_Z53Z(hso_z15,hso_z05)
endif
set hso_Z75=hso_Z75+1
endloop
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z00Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local player hso_Z65
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z05==hso_z5)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z57Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
set hso_Z65=Player(hso_Z5z)
if(GetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_GOLD,hso_z22)
else
call SetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set hso_Z65=null
call hso_Z53Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
set hso_Z65=Player(hso_Z5z)
if(GetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_LUMBER,hso_z22)
else
call SetPlayerTaxRate(hso_Z65,hso_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set hso_Z65=null
call hso_Z53Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z52Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z01Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local integer hso_Z75=hso_Z5z
local player hso_Z65=Player(hso_Z75)
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
call hso_ZZzZ(hso_Z75,hso_Z65)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Zz1Z(hso_Z65)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call SetPlayerStateBJ(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call SetPlayerStateBJ(hso_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
if(GetPlayerHandicapBJ(hso_Z65)==200.)then
call SetPlayerHandicapBJ(hso_Z65,100)
else
call SetPlayerHandicapBJ(hso_Z65,200.)
endif
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
if(GetPlayerHandicapXPBJ(hso_Z65)==200.)then
call SetPlayerHandicapXPBJ(hso_Z65,100)
else
call SetPlayerHandicapXPBJ(hso_Z65,200.)
endif
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_zz5(hso_Z65,hso_Z2,true)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
call hso_z35(hso_Z65,hso_z2,true)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
call hso_zz5(hso_Z65,hso_Z2,false)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_z35(hso_Z65,hso_z2,false)
call hso_Z56Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z53Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_z78=null
endfunction
function hso_z02Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local integer hso_Z75=hso_Z5z
local player hso_Z65=Player(hso_Z75)
call hso_Z44Z(hso_z15,hso_z05,false)
if(hso_z78==hso_z2z[hso_z15])then
if(IsPlayerAlly(hso_Z65,hso_z05))then
call SetPlayerAllianceStateBJ(hso_Z65,hso_z05,0)
else
call SetPlayerAllianceStateBJ(hso_Z65,hso_z05,3)
endif
call hso_Z57Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
if(GetPlayerAlliance(hso_Z65,hso_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,hso_z5)
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_CONTROL,false,hso_z5)
else
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,hso_z5)
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_CONTROL,true,hso_z5)
endif
call hso_Z57Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
if(GetPlayerAlliance(hso_Z65,hso_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_XP,false,hso_z5)
else
call SetPlayerAllianceBJ(hso_Z65,ALLIANCE_SHARED_XP,true,hso_z5)
endif
call hso_Z57Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
if(IsPlayerAlly(hso_z05,hso_Z65))then
call SetPlayerAllianceStateBJ(hso_z5,hso_Z65,0)
else
call SetPlayerAllianceStateBJ(hso_z5,hso_Z65,2)
endif
call hso_Z57Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z53Z(hso_z15,hso_z05)
endif
set hso_z05=null
set hso_Z65=null
set hso_z78=null
endfunction
function hso_z03Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local integer hso_Z75
local unit hso_z65=hso_z7[hso_z15]
local player hso_Z65=GetOwningPlayer(hso_z65)
call hso_Z44Z(hso_z15,hso_z05,false)
if(hso_z4)and(hso_z6[hso_z15])then
if(hso_z78==hso_z2z[hso_z15])then
call SetHeroLevelBJ(hso_z65,GetHeroLevel(hso_z65)+hso_Z0Z,false)
endif
if(hso_z78==hso_z4z[hso_z15])then
call ModifyHeroStat(1,hso_z65,0,hso_Z3)
call ModifyHeroStat(0,hso_z65,0,hso_Z3)
call ModifyHeroStat(2,hso_z65,0,hso_Z3)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_z98(hso_z15,false)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z77(hso_z65,hso_z05,1)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_ZZ3Z(hso_z65)
endif
if(hso_z78==hso_z8z[hso_z15])then
if(hso_Z5Z)then
if(hso_Z65!=hso_z5)then
call UnitShareVisionBJ(true,hso_z65,hso_z05)
endif
else
call UnitShareVisionBJ(true,hso_z65,hso_z05)
endif
endif
if(hso_z78==hso_z7z[hso_z15])then
call hso_Z47Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
if(hso_Z5Z)then
if(hso_Z65!=hso_z5)then
call SetUnitOwner(hso_z65,hso_z05,true)
endif
else
call SetUnitOwner(hso_z65,hso_z05,true)
endif
endif
if(hso_z78==hso_Zz0[hso_z15])then
call RemoveUnit(hso_z65)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z54Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_z65=null
set hso_z78=null
endfunction
function hso_z04Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z05==hso_z5)and(hso_z6[hso_z15]))then
if(hso_z78==hso_z2z[hso_z15])then
set hso_Z0=not(hso_Z0)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z58Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
set hso_Z5Z=not(hso_Z5Z)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
set hso_Z6Z=not(hso_Z6Z)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
set hso_Z7Z=not(hso_Z7Z)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
set hso_z9Z=not(hso_z9Z)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z7z[hso_z15])then
set hso_ZZz=not(hso_ZZz)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z6z[hso_z15])then
set hso_z7Z=not(hso_z7Z)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_Zz0[hso_z15])then
set hso_Z52=not(hso_Z52)
call hso_Z51Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_ZZ0[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z05Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if(hso_z78==hso_z2z[hso_z15])then
set hso_z61=1
call hso_Z58Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
set hso_z61=2
call hso_Z58Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
set hso_z61=3
call hso_Z58Z(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z51Z(hso_z15,hso_z05)
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z06Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
local integer hso_Z75=0
local player hso_Z65
local unit hso_z65=hso_z7[hso_z15]
call hso_Z44Z(hso_z15,hso_z05,false)
if((hso_z4)and(hso_z05==hso_z5)and(hso_z6[hso_z15]))then
loop
exitwhen hso_Z75>12
if(hso_z78==hso_ZzZ[hso_Z75])then
set hso_Z65=Player(hso_Z75)
call SetUnitOwner(hso_z7[hso_z15],hso_Z65,true)
endif
set hso_Z75=hso_Z75+1
endloop
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z50Z(hso_z15,hso_z05)
endif
endif
set hso_z05=null
set hso_Z65=null
set hso_z78=null
set hso_z65=null
endfunction
function hso_z07Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if(hso_z78==hso_z2z[hso_z15])then
call hso_z36(hso_z05)
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
set hso_z31[hso_z15]=not(hso_z31[hso_z15])
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
set hso_Z33[hso_z15]=not(hso_Z33[hso_z15])
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z38(hso_z15,not(hso_Z53[hso_z15]))
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
set hso_Z63[hso_z15]=not(hso_Z63[hso_z15])
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_z8z[hso_z15])then
set hso_Z43[hso_z15]=not(hso_Z43[hso_z15])
call hso_Z6ZZ(hso_z15,hso_z05)
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
set hso_z05=null
set hso_z78=null
endfunction
function hso_z08Z takes nothing returns nothing
local player hso_z05=GetTriggerPlayer()
local integer hso_z15=GetPlayerId(hso_z05)
local button hso_z78=GetClickedButton()
call hso_Z44Z(hso_z15,hso_z05,false)
if(hso_z78==hso_z2z[hso_z15])then
call hso_Z6zZ(hso_z05)
endif
if(hso_z78==hso_z4z[hso_z15])then
call hso_Z60Z(hso_z05)
endif
if(hso_z78==hso_z5z[hso_z15])then
call hso_Z61Z(hso_z05)
endif
if(hso_z78==hso_z3z[hso_z15])then
call hso_Z62Z(hso_z05)
endif
if(hso_z78==hso_z9z[hso_z15])then
call hso_Z64Z()
endif
if(hso_z78==hso_Z00[hso_z15])then
call hso_Z45Z(hso_z15,hso_z05)
endif
set hso_z05=null
set hso_z78=null
endfunction
function huashao_ppS takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>1)
set udg_hso_hsPs[i]=false
set i=i+1
endloop
set udg_hso_hsMS=""
set udg_hso_hsMN=0
set i=0
loop
exitwhen(i>12)
set udg_hso_hsPKS[i]=""
set i=i+1
endloop
set i=0
loop
exitwhen(i>12)
set udg_hso_hsPKN[i]=0
set i=i+1
endloop
endfunction
function Trig_huashao_PS_Conditions takes nothing returns boolean
if(not(udg_hso_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
return false
endif
if(not(GetIssuedOrderIdBJ()==String2OrderIdBJ("PATROL")))then
return false
endif
return true
endfunction
function Trig_huashao_PS_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
endfunction
function InitTrig_huashao_PS takes nothing returns nothing
set gg_trg_huashao_PS=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_huashao_PS,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_huashao_PS,Condition(function Trig_huashao_PS_Conditions))
call TriggerAddAction(gg_trg_huashao_PS,function Trig_huashao_PS_Actions)
endfunction
function hso_12 takes nothing returns nothing
set hso_YS=CreateTrigger()
set hso_ys=0
loop
exitwhen hso_ys>11
call TriggerRegisterPlayerChatEvent(hso_YS,Player(hso_ys),"hellour",true)
set hso_ys=hso_ys+1
endloop
call TriggerAddAction(hso_YS,function hso_YY)
endfunction
function hso_z09Z takes nothing returns nothing
local integer hso_Z75
local player hso_Z65
local player hso_z05
set hso_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(hso_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hso_z73,function hso_Z9ZZ)
call TriggerAddCondition(hso_z43,Condition(function hso_Z73Z))
set hso_Z75=0
loop
exitwhen hso_Z75>11
set hso_zz1[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_zz1[hso_Z75],function hso_Z79Z)
call DisableTrigger(hso_zz1[hso_Z75])
set hso_Z30[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z30[hso_Z75],function hso_Z88Z)
call DisableTrigger(hso_Z30[hso_Z75])
set hso_Z50[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z50[hso_Z75],function hso_Z89Z)
call DisableTrigger(hso_Z50[hso_Z75])
set hso_Z40[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z40[hso_Z75],function hso_Z91Z)
call DisableTrigger(hso_Z40[hso_Z75])
set hso_Z60[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z60[hso_Z75],function hso_Z90Z)
call DisableTrigger(hso_Z60[hso_Z75])
set hso_Z6z[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z6z[hso_Z75],function hso_Z9zZ)
call DisableTrigger(hso_Z6z[hso_Z75])
set hso_Z70[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z70[hso_Z75],function hso_zZ1Z)
call DisableTrigger(hso_Z70[hso_Z75])
set hso_Z80[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z80[hso_Z75],function hso_zZ2Z)
call DisableTrigger(hso_Z80[hso_Z75])
set hso_Z90[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z90[hso_Z75],function hso_zZ3Z)
call DisableTrigger(hso_Z90[hso_Z75])
set hso_zZ0[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_zZ0[hso_Z75],function hso_zZ4Z)
call DisableTrigger(hso_zZ0[hso_Z75])
set hso_zz0[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_zz0[hso_Z75],function hso_zZ5Z)
call DisableTrigger(hso_zz0[hso_Z75])
set hso_z00[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z00[hso_Z75],function hso_zZ6Z)
set hso_esc[hso_Z75] = CreateTrigger()
call TriggerAddAction(hso_esc[hso_Z75], function hso_esc_act )
set hso_z10[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z10[hso_Z75],function hso_zZ9Z)
set hso_z20[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z20[hso_Z75],function hso_zz0Z)
set hso_z30[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z30[hso_Z75],function hso_zz3Z)
set hso_z40[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z40[hso_Z75],function hso_Z81Z)
call DisableTrigger(hso_z40[hso_Z75])
set hso_z50[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z50[hso_Z75],function hso_Z82Z)
call DisableTrigger(hso_z50[hso_Z75])
set hso_z60[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z60[hso_Z75],function hso_Z83Z)
call DisableTrigger(hso_z60[hso_Z75])
set hso_z70[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z70[hso_Z75],function hso_Z84Z)
call DisableTrigger(hso_z70[hso_Z75])
set hso_z80[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z80[hso_Z75],function hso_Z85Z)
call DisableTrigger(hso_z80[hso_Z75])
set hso_z90[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z90[hso_Z75],function hso_Z86Z)
call DisableTrigger(hso_z90[hso_Z75])
set hso_ZZ3[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_ZZ3[hso_Z75],function hso_Z87Z)
call DisableTrigger(hso_ZZ3[hso_Z75])
set hso_ZZ1[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_ZZ1[hso_Z75],function hso_zz4Z)
set hso_Zz2[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Zz2[hso_Z75],function hso_zz5Z)
set hso_Zz1[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Zz1[hso_Z75],function hso_zz6Z)
set hso_Z01[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z01[hso_Z75],function hso_zz7Z)
set hso_Z81[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z81[hso_Z75],function hso_zz8Z)
set hso_Z21[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z21[hso_Z75],function hso_zz9Z)
set hso_Z51[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z51[hso_Z75],function hso_z0ZZ)
set hso_Z41[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z41[hso_Z75],function hso_z0zZ)
set hso_Z61[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z61[hso_Z75],function hso_z00Z)
set hso_Z12[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z12[hso_Z75],function hso_z02Z)
set hso_Z02[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z02[hso_Z75],function hso_z01Z)
set hso_Z71[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z71[hso_Z75],function hso_z03Z)
set hso_Z31[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z31[hso_Z75],function hso_z04Z)
set hso_Z22[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z22[hso_Z75],function hso_z05Z)
set hso_Z11[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z11[hso_Z75],function hso_z06Z)
set hso_Z23[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z23[hso_Z75],function hso_z08Z)
set hso_Z13[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_Z13[hso_Z75],function hso_z07Z)
call DisableTrigger(hso_ZZ1[hso_Z75])
call DisableTrigger(hso_Zz1[hso_Z75])
call DisableTrigger(hso_Zz2[hso_Z75])
call DisableTrigger(hso_Z01[hso_Z75])
call DisableTrigger(hso_Z81[hso_Z75])
call DisableTrigger(hso_Z21[hso_Z75])
call DisableTrigger(hso_Z51[hso_Z75])
call DisableTrigger(hso_Z41[hso_Z75])
call DisableTrigger(hso_Z61[hso_Z75])
call DisableTrigger(hso_Z12[hso_Z75])
call DisableTrigger(hso_Z02[hso_Z75])
call DisableTrigger(hso_Z71[hso_Z75])
call DisableTrigger(hso_Z31[hso_Z75])
call DisableTrigger(hso_Z22[hso_Z75])
call DisableTrigger(hso_Z11[hso_Z75])
call DisableTrigger(hso_Z23[hso_Z75])
call DisableTrigger(hso_Z13[hso_Z75])
set hso_z01[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z01[hso_Z75],function hso_Z95Z)
set hso_z11[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z11[hso_Z75],function hso_Z98Z)
set hso_z21[hso_Z75]=CreateTrigger()
call TriggerAddAction(hso_z21[hso_Z75],function hso_zZZZ)
call DisableTrigger(hso_z01[hso_Z75])
call DisableTrigger(hso_z11[hso_Z75])
call DisableTrigger(hso_z21[hso_Z75])
set hso_Z65=Player(hso_Z75)
if((GetPlayerController(hso_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(hso_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set hso_Z8Z[hso_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(hso_z63,hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerEventEndCinematic(hso_esc[hso_Z75] ,hso_Z65)
call TriggerRegisterPlayerKeyEventBJ(hso_z10[hso_Z75],hso_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(hso_z00[hso_Z75],hso_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(hso_z20[hso_Z75],hso_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(hso_z30[hso_Z75],hso_Z65,0,1)
call TriggerRegisterPlayerChatEvent(hso_z53,hso_Z65,SubStringBJ(hso_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(hso_z63,hso_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set hso_Z9Z[hso_Z75]=GetPlayerStartLocationLoc(hso_Z65)
endif
set hso_Z75=hso_Z75+1
endloop
call DisableTrigger(hso_z73)
set hso_z8Z=CreateGroup()
set hso_z8=GetWorldBounds()
set hso_z2Z[0]=30.
set hso_z2Z[1]=60.
set hso_z2Z[2]=90.
set hso_z3Z[0]=50.
set hso_z3Z[1]=72.
set hso_z3Z[2]=95.
set hso_Z75=0
loop
exitwhen hso_Z75>20
set hso_z02[hso_Z75]=null
set hso_Z75=hso_Z75+1
endloop
set hso_Z75=0
loop
exitwhen(hso_Z75>12)
set hso_Z5[hso_Z75]=0
set hso_z6[hso_Z75]=false
set hso_Z7[hso_Z75]=false
set hso_Z8[hso_Z75]=0
set hso_Z1Z[hso_Z75]=false
set hso_Z2Z[hso_Z75]=false
set hso_Z3Z[hso_Z75]=CreateTimer()
set hso_Z8Z[hso_Z75]=CreateGroup()
set hso_zZZ[hso_Z75]=false
set hso_zzZ[hso_Z75]=false
set hso_z0Z[hso_Z75]=CreateTimer()
set hso_z1Z[hso_Z75]=false
set hso_Z3z[hso_Z75]=false
set hso_Z4z[hso_Z75]=0
set hso_Z20[hso_Z75]=DialogCreate()
set hso_Z91[hso_Z75]=DialogCreate()
set hso_zZ1[hso_Z75]=DialogCreate()
set hso_z31[hso_Z75]=false
set hso_Z32[hso_Z75]=0
set hso_Z42[hso_Z75]=false
set hso_Zz3[hso_Z75]=DialogCreate()
set hso_Z33[hso_Z75]=false
set hso_Z43[hso_Z75]=true
set hso_Z53[hso_Z75]=false
set hso_Z63[hso_Z75]=false
set hso_Z73[hso_Z75]=CreateTimer()
set hso_Z75=hso_Z75+1
endloop
set hso_Z75=0
loop
exitwhen(hso_Z75>3)
set hso_Z75=hso_Z75+1
endloop
set hso_Z75=0
loop
exitwhen(hso_Z75>21)
set hso_z12[hso_Z75]=false
set hso_Z75=hso_Z75+1
endloop
call TriggerRegisterTimerEvent(hso_z23,.01,false)
call TriggerAddAction(hso_z23,function hso_Z7zZ)
call TriggerAddAction(hso_z33,function hso_Z70Z)
call TriggerAddAction(hso_z43,function hso_Z74Z)
call TriggerAddAction(hso_z53,function hso_Z8zZ)
call TriggerAddAction(hso_z63,function hso_Z80Z)
call TriggerRegisterAnyUnitEventBJ(hso_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hso_z73,function hso_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(hso_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hso_z83,function hso_Z93Z)
call DisableTrigger(hso_z83)
call hso_Z69Z()
call huashao_ppS()
call hso_12()
call InitTrig_huashao_PS()
call SetPlayerName(Player(12),"中立生物")
set hso_Z65=null
endfunction