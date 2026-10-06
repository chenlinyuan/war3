function zFs_Z64 takes real zFs_Z74,location zFs_Z84 returns group
set zFs_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(zFs_Z14,zFs_Z84,zFs_Z74,zFs_Z34)
return zFs_Z14
endfunction
function zFs_Z94 takes player zFs_zZ4 returns group
set zFs_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(zFs_Z14,zFs_zZ4,zFs_Z34)
return zFs_Z14
endfunction
function zFs_zz4 takes player zFs_zZ4,integer zFs_z04 returns group
set zFs_Z14=CreateGroup()
set bj_groupEnumTypeId=zFs_z04
call GroupEnumUnitsOfPlayer(zFs_Z14,zFs_zZ4,filterGetUnitsOfPlayerAndTypeId)
return zFs_Z14
endfunction
function zFs_z14 takes player zFs_zZ4 returns force
set zFs_Z24=CreateForce()
call ForceEnumAllies(zFs_Z24,zFs_zZ4,zFs_Z34)
return zFs_Z24
endfunction
function zFs_z24 takes player zFs_zZ4 returns force
set zFs_Z24=CreateForce()
call ForceEnumEnemies(zFs_Z24,zFs_zZ4,zFs_Z34)
return zFs_Z24
endfunction
function zFs_Z45 takes trigger zFs_Z55,player zFs_Z65,integer zFs_Z75 returns nothing
local playerevent zFs_Z85=ConvertPlayerEvent(zFs_Z75)
call TriggerRegisterPlayerEvent(zFs_Z55,zFs_Z65,zFs_Z85)
set zFs_Z85=null
endfunction
function zFs_Z95 takes trigger zFs_Z55,player zFs_Z65,integer zFs_Z75 returns nothing
local playerunitevent zFs_Z85=ConvertPlayerUnitEvent(zFs_Z75)
call TriggerRegisterPlayerUnitEvent(zFs_Z55,zFs_Z65,zFs_Z85,null)
set zFs_Z85=null
endfunction
function zFs_zZ5 takes integer zFs_Z75,player zFs_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(zFs_Z30[zFs_Z75],zFs_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(zFs_Z50[zFs_Z75],zFs_Z65,ConvertPlayerUnitEvent(25),null)
call zFs_Z45(zFs_Z70[zFs_Z75],zFs_Z65,17)
call zFs_Z45(zFs_Z90[zFs_Z75],zFs_Z65,266)
call zFs_Z45(zFs_Z80[zFs_Z75],zFs_Z65,268)
call zFs_Z45(zFs_zZ0[zFs_Z75],zFs_Z65,262)
call zFs_Z45(zFs_zz0[zFs_Z75],zFs_Z65,264)
call TriggerRegisterTimerExpireEvent(zFs_z43,zFs_z0Z[zFs_Z75])
call TriggerRegisterTimerExpireEvent(zFs_z33,zFs_Z73[zFs_Z75])
call zFs_Z95(zFs_Z40[zFs_Z75],zFs_Z65,32)
call zFs_Z95(zFs_Z60[zFs_Z75],zFs_Z65,35)
call TriggerRegisterDialogEvent(zFs_ZZ1[zFs_Z75],zFs_zZ1[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Zz2[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Zz1[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z01[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z81[zFs_Z75],zFs_Z91[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z71[zFs_Z75],zFs_zZ1[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z21[zFs_Z75],zFs_Z91[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z31[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z22[zFs_Z75],zFs_Z91[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z11[zFs_Z75],zFs_Z91[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z51[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z41[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z61[zFs_Z75],zFs_Z91[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z12[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z02[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z23[zFs_Z75],zFs_Z20[zFs_Z75])
call TriggerRegisterDialogEvent(zFs_Z13[zFs_Z75],zFs_Z20[zFs_Z75])
call zFs_Z95(zFs_z01[zFs_Z75],zFs_Z65,38)
call zFs_Z95(zFs_z11[zFs_Z75],zFs_Z65,39)
call zFs_Z95(zFs_z21[zFs_Z75],zFs_Z65,40)
call zFs_Z95(zFs_z80[zFs_Z75],zFs_Z65,276)
call zFs_Z95(zFs_z80[zFs_Z75],zFs_Z65,275)
call zFs_Z95(zFs_z90[zFs_Z75],zFs_Z65,276)
call zFs_Z95(zFs_z90[zFs_Z75],zFs_Z65,275)
call zFs_Z95(zFs_ZZ3[zFs_Z75],zFs_Z65,18)
call TriggerRegisterPlayerStateEvent(zFs_z60[zFs_Z75],zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(zFs_z40[zFs_Z75],zFs_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(zFs_z50[zFs_Z75],zFs_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call zFs_Z95(zFs_z70[zFs_Z75],zFs_Z65,20)
call TriggerRegisterPlayerChatEvent(zFs_zz1[zFs_Z75],zFs_Z65,"-",false)
call zFs_Z95(zFs_Z6z[zFs_Z75],zFs_Z65,39)
set zFs_Z3z[zFs_Z75]=true
endfunction
function zFs_zz5 takes player zFs_z05,integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_z25)then
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_GOLD)+zFs_z15)
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(zFs_z05,PLAYER_STATE_GOLD_GATHERED)-zFs_z15)
else
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_GOLD)-zFs_z15)
endif
endfunction
function zFs_z35 takes player zFs_z05,integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_z25)then
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)+zFs_z15)
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(zFs_z05,PLAYER_STATE_LUMBER_GATHERED)-zFs_z15)
else
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)-zFs_z15)
endif
endfunction
function zFs_z45 takes player zFs_z05 returns nothing
local player zFs_Z65=GetLocalPlayer()
if zFs_z05==zFs_Z65 then
set zFs_Z65=Player(-1)
endif
set zFs_Z65=null
endfunction
function zFs_z55 takes unit zFs_z65,unit zFs_z75,boolean zFs_z85 returns nothing
local location zFs_z95
local location zFs_ZZ6
set zFs_z95=GetUnitLoc(zFs_z65)
set zFs_ZZ6=GetUnitLoc(zFs_z75)
call SetUnitPositionLoc(zFs_z65,zFs_ZZ6)
if(zFs_z85)then
call SetUnitPositionLoc(zFs_z75,zFs_z95)
call SetUnitPositionLoc(zFs_z65,zFs_ZZ6)
endif
call RemoveLocation(zFs_z95)
call RemoveLocation(zFs_ZZ6)
set zFs_z95=null
set zFs_ZZ6=null
endfunction
function zFs_Zz6 takes integer zFs_Z06 returns nothing
if(zFs_Z06==0)then
set zFs_zZ2=100
set zFs_Z92=100
set zFs_Z82=100
set zFs_Z72="|cFFFFFFFF"
return
endif
if(zFs_Z06==1)then
set zFs_zZ2=50
set zFs_Z92=50
set zFs_Z82=50
set zFs_Z72="|cFF7F7F7F"
return
endif
if(zFs_Z06==2)then
set zFs_zZ2=0
set zFs_Z92=0
set zFs_Z82=0
set zFs_Z72="|cFF000000"
return
endif
if(zFs_Z06==3)then
set zFs_zZ2=100
set zFs_Z92=0
set zFs_Z82=0
set zFs_Z72="|cFFFF0000"
return
endif
if(zFs_Z06==4)then
set zFs_zZ2=100
set zFs_Z92=50
set zFs_Z82=0
set zFs_Z72="|cFFFF7F00"
return
endif
if(zFs_Z06==5)then
set zFs_zZ2=100
set zFs_Z92=100
set zFs_Z82=0
set zFs_Z72="|cFFFFFF00"
return
endif
if(zFs_Z06==6)then
set zFs_zZ2=0
set zFs_Z92=100
set zFs_Z82=0
set zFs_Z72="|cFF00FF00"
return
endif
if(zFs_Z06==7)then
set zFs_zZ2=0
set zFs_Z92=100
set zFs_Z82=100
set zFs_Z72="|cFF00FFFF"
return
endif
if(zFs_Z06==8)then
set zFs_zZ2=0
set zFs_Z92=0
set zFs_Z82=100
set zFs_Z72="|cFF0000FF"
return
endif
if(zFs_Z06==9)then
set zFs_zZ2=100
set zFs_Z92=0
set zFs_Z82=100
set zFs_Z72="|cFFFF00FF"
return
endif
endfunction
function zFs_Z16 takes integer zFs_Z06,unit zFs_Z26,string zFs_Z36 returns nothing
local texttag zFs_Z46
local location zFs_z95
call zFs_Zz6(zFs_Z06)
set zFs_z95=GetUnitLoc(zFs_Z26)
set zFs_Z46=CreateTextTagLocBJ(zFs_Z36,zFs_z95,0,20,zFs_zZ2,zFs_Z92,zFs_Z82,0)
call RemoveLocation(zFs_z95)
set zFs_z95=null
call SetTextTagPermanent(zFs_Z46,false)
call SetTextTagLifespan(zFs_Z46,zFs_Z1)
set zFs_Z46=null
endfunction
function zFs_Z56 takes nothing returns nothing
local trigger zFs_Z66=GetTriggeringTrigger()
local timer zFs_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(zFs_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(zFs_z52)
call DestroyTimerDialog(zFs_z82)
call DestroyTimer(zFs_Z76)
set zFs_Z66=null
set zFs_Z76=null
endfunction
function zFs_Z86 takes nothing returns nothing
local timer zFs_Z76
local trigger zFs_Z66
if(zFs_z62)then
else
set zFs_z52=GetGameSpeed()
set zFs_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set zFs_Z66=CreateTrigger()
set zFs_Z76=CreateTimer()
call StartTimerBJ(zFs_Z76,false,zFs_z42)
set zFs_z82=CreateTimerDialogBJ(zFs_Z76,"子弹时间")
call TriggerAddAction(zFs_Z66,function zFs_Z56)
call TriggerRegisterTimerExpireEvent(zFs_Z66,zFs_Z76)
endif
endfunction
function zFs_Z96 takes trigger zFs_zZ6 returns nothing
if(IsTriggerEnabled(zFs_zZ6))then
call DisableTrigger(zFs_zZ6)
else
call EnableTrigger(zFs_zZ6)
endif
endfunction
function zFs_zz6 takes trigger zFs_zZ6,boolean zFs_z06 returns nothing
if(IsTriggerEnabled(zFs_zZ6)==zFs_z06)then
else
call zFs_Z96(zFs_zZ6)
endif
endfunction
function zFs_z16 takes integer zFs_z15,boolean zFs_z25 returns nothing
call zFs_zz6(zFs_z40[zFs_z15],zFs_z25)
call zFs_zz6(zFs_z50[zFs_z15],zFs_z25)
call zFs_zz6(zFs_z60[zFs_z15],zFs_z25)
call zFs_zz6(zFs_z80[zFs_z15],zFs_z25)
call zFs_zz6(zFs_z70[zFs_z15],zFs_z25)
call zFs_zz6(zFs_z90[zFs_z15],zFs_z25)
call zFs_zz6(zFs_ZZ3[zFs_z15],zFs_z25)
endfunction
function zFs_z26 takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
if(GetUnitUserData(zFs_z65)==2176)then
call RemoveUnit(zFs_z65)
endif
set zFs_z65=null
endfunction
function zFs_z36 takes player zFs_z05 returns nothing
local group zFs_z46
if(zFs_Z42[GetPlayerId(zFs_z05)])then
set zFs_z46=zFs_Z94(zFs_z05)
call ForGroup(zFs_z46,function zFs_z26)
set zFs_Z42[GetPlayerId(zFs_z05)]=false
call DestroyGroup(zFs_z46)
set zFs_z46=null
endif
endfunction
function zFs_z56 takes unit zFs_z65,player zFs_z05 returns nothing
local location zFs_z95
local integer zFs_z66
local unit zFs_z76
local item zFs_z86
local integer zFs_Z75=0
if(IsUnitType(zFs_z65,UNIT_TYPE_HERO))then
set zFs_z95=GetUnitLoc(zFs_z65)
set zFs_z66=GetUnitTypeId(zFs_z65)
set zFs_z76=CreateUnitAtLoc(zFs_z05,zFs_z66,zFs_z95,bj_UNIT_FACING)
call SetUnitUserData(zFs_z76,2176)
set zFs_Z42[GetPlayerId(zFs_z05)]=true
if(zFs_Z6Z)then
call SetUnitUseFood(zFs_z76,false)
endif
call SetHeroLevelBJ(zFs_z76,GetHeroLevel(zFs_z65),false)
call SetHeroStat(zFs_z76,0,GetHeroStatBJ(0,zFs_z65,false))
call SetHeroStat(zFs_z76,1,GetHeroStatBJ(1,zFs_z65,false))
call SetHeroStat(zFs_z76,2,GetHeroStatBJ(2,zFs_z65,false))
loop
exitwhen zFs_Z75>5
set zFs_z86=UnitItemInSlot(zFs_z65,zFs_Z75)
call UnitAddItemById(zFs_z76,GetItemTypeId(zFs_z86))
set zFs_Z75=zFs_Z75+1
endloop
endif
call RemoveLocation(zFs_z95)
set zFs_z95=null
set zFs_z76=null
set zFs_z86=null
endfunction
function zFs_z96 takes integer zFs_ZZ7,player zFs_Zz7,location zFs_Z07,boolean zFs_Z17,boolean zFs_Z27 returns nothing
local unit zFs_z76
set zFs_z76=CreateUnitAtLoc(zFs_Zz7,zFs_ZZ7,zFs_Z07,bj_UNIT_FACING)
if(zFs_Z6Z)then
call SetUnitUseFood(zFs_z76,false)
endif
if(zFs_Z17)then
call SetUnitUserData(zFs_z76,2176)
endif
if(zFs_Z27)then
call UnitApplyTimedLife(zFs_z76,1112820806,90)
endif
set zFs_z76=null
endfunction
function zFs_Z37 takes integer zFs_ZZ7,player zFs_Zz7,location zFs_Z07 returns nothing
local unit zFs_z76
set zFs_z76=CreateUnitAtLoc(zFs_Zz7,zFs_ZZ7,zFs_Z07,bj_UNIT_FACING)
if(zFs_Z6Z)then
call SetUnitUseFood(zFs_z76,false)
set zFs_z76=null
endif
endfunction
function zFs_Z47 takes unit zFs_Z57,player zFs_Zz7,integer zFs_Z67,boolean zFs_Z27 returns nothing
local location zFs_z95
local integer zFs_z66
local integer zFs_Z75
set zFs_z95=GetUnitLoc(zFs_Z57)
set zFs_z66=GetUnitTypeId(zFs_Z57)
set zFs_Z75=1
loop
exitwhen zFs_Z75>zFs_Z67
call zFs_z96(zFs_z66,zFs_Zz7,zFs_z95,true,zFs_Z27)
set zFs_Z75=zFs_Z75+1
endloop
call RemoveLocation(zFs_z95)
set zFs_Z42[GetPlayerId(zFs_Zz7)]=true
set zFs_z95=null
endfunction
function zFs_Z77 takes unit zFs_Z57,player zFs_Zz7,integer zFs_Z67 returns nothing
call zFs_Z47(zFs_Z57,zFs_Zz7,zFs_Z67,false)
endfunction
function zFs_Z87 takes unit zFs_z65,integer zFs_z15,boolean zFs_Z97 returns nothing
local integer zFs_Z75
set zFs_Z75=GetResourceAmount(zFs_z65)
if(zFs_Z97)then
set zFs_Z75=zFs_Z75+zFs_z15
else
set zFs_Z75=zFs_Z75-zFs_z15
endif
if(zFs_Z75<0)then
if(zFs_Z97)then
set zFs_Z75=GetResourceAmount(zFs_z65)
else
set zFs_Z75=0
endif
endif
call SetResourceAmount(zFs_z65,zFs_Z75)
endfunction
function zFs_zZ7 takes integer zFs_z15,player zFs_z05,boolean zFs_zz7 returns nothing
if(zFs_zz7)then
call SetPlayerTechMaxAllowed(zFs_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(zFs_z05,1212502607,3)
endif
endfunction
function zFs_z07 takes integer zFs_z15,boolean zFs_z06 returns nothing
if(zFs_z06)then
call EnableTrigger(zFs_z00[zFs_z15])
call EnableTrigger(zFs_z10[zFs_z15])
call EnableTrigger(zFs_z20[zFs_z15])
call EnableTrigger(zFs_z30[zFs_z15])
call EnableTrigger(zFs_Z70[zFs_z15])
call EnableTrigger(zFs_Z80[zFs_z15])
call EnableTrigger(zFs_Z90[zFs_z15])
call EnableTrigger(zFs_zZ0[zFs_z15])
call EnableTrigger(zFs_zz0[zFs_z15])
else
call DisableTrigger(zFs_z00[zFs_z15])
call DisableTrigger(zFs_z10[zFs_z15])
call DisableTrigger(zFs_z20[zFs_z15])
call DisableTrigger(zFs_z30[zFs_z15])
call DisableTrigger(zFs_Z70[zFs_z15])
call DisableTrigger(zFs_Z80[zFs_z15])
call DisableTrigger(zFs_Z90[zFs_z15])
call DisableTrigger(zFs_zZ0[zFs_z15])
call DisableTrigger(zFs_zz0[zFs_z15])
endif
endfunction
function zFs_z17 takes integer zFs_z15,boolean zFs_z27 returns nothing
if(zFs_z27)then
call EnableTrigger(zFs_Z40[zFs_z15])
call EnableTrigger(zFs_Z60[zFs_z15])
call EnableTrigger(zFs_Z6z[zFs_z15])
else
call DisableTrigger(zFs_Z40[zFs_z15])
call DisableTrigger(zFs_Z60[zFs_z15])
call DisableTrigger(zFs_Z6z[zFs_z15])
endif
endfunction
function zFs_z37 takes nothing returns nothing
local integer zFs_z15
set zFs_z15=0
loop
exitwhen zFs_z15>11
call zFs_z07(zFs_z15,false)
set zFs_z15=zFs_z15+1
endloop
endfunction
function zFs_z47 takes integer zFs_z15 returns nothing
set zFs_z6[zFs_z15]=false
call GroupClear(zFs_Z8Z[zFs_z15])
if(zFs_Z7Z)then
call DestroyFogModifier(zFs_Z6[zFs_z15])
endif
call DisableTrigger(zFs_Z30[zFs_z15])
call DisableTrigger(zFs_Z50[zFs_z15])
call DisableTrigger(zFs_zz1[zFs_z15])
call DisableTrigger(zFs_z40[zFs_z15])
call DisableTrigger(zFs_z50[zFs_z15])
call DisableTrigger(zFs_z60[zFs_z15])
call DisableTrigger(zFs_z70[zFs_z15])
call DisableTrigger(zFs_z80[zFs_z15])
call DisableTrigger(zFs_z90[zFs_z15])
call DisableTrigger(zFs_ZZ3[zFs_z15])
call DisableTrigger(zFs_ZZ1[zFs_z15])
call DisableTrigger(zFs_Zz1[zFs_z15])
call DisableTrigger(zFs_Zz2[zFs_z15])
call DisableTrigger(zFs_Z01[zFs_z15])
call DisableTrigger(zFs_Z81[zFs_z15])
call DisableTrigger(zFs_Z21[zFs_z15])
call DisableTrigger(zFs_Z51[zFs_z15])
call DisableTrigger(zFs_Z41[zFs_z15])
call DisableTrigger(zFs_Z61[zFs_z15])
call DisableTrigger(zFs_Z12[zFs_z15])
call DisableTrigger(zFs_Z02[zFs_z15])
call DisableTrigger(zFs_Z71[zFs_z15])
call DisableTrigger(zFs_Z31[zFs_z15])
call DisableTrigger(zFs_Z22[zFs_z15])
call DisableTrigger(zFs_Z11[zFs_z15])
call DisableTrigger(zFs_Z23[zFs_z15])
call DisableTrigger(zFs_Z13[zFs_z15])
call DisableTrigger(zFs_zZ3[zFs_z15])
call DisableTrigger(zFs_Z40[zFs_z15])
call DisableTrigger(zFs_Z60[zFs_z15])
call DisableTrigger(zFs_Z6z[zFs_z15])
call zFs_z07(zFs_z15,false)
endfunction
function zFs_z57 takes integer zFs_z15,player zFs_z05 returns nothing
set zFs_z6[zFs_z15]=true
if(zFs_Z3z[zFs_z15])then
else
call zFs_zZ5(zFs_z15,zFs_z05)
endif
call EnableTrigger(zFs_Z30[zFs_z15])
call EnableTrigger(zFs_Z50[zFs_z15])
call EnableTrigger(zFs_zz1[zFs_z15])
call zFs_z07(zFs_z15,true)
endfunction
function zFs_z67 takes integer zFs_z15,boolean zFs_z77 returns nothing
if(zFs_z77)then
if((zFs_zZZ[zFs_z15])and(zFs_zzZ[zFs_z15])and(zFs_z31[zFs_z15]))then
call EnableTrigger(zFs_z01[zFs_z15])
call EnableTrigger(zFs_z11[zFs_z15])
call EnableTrigger(zFs_z21[zFs_z15])
endif
else
call DisableTrigger(zFs_z01[zFs_z15])
call DisableTrigger(zFs_z11[zFs_z15])
call DisableTrigger(zFs_z21[zFs_z15])
endif
endfunction
function zFs_z87 takes integer zFs_Z06 returns nothing
if(zFs_Z06==0)then
set zFs_zz2=0
return
endif
if(zFs_Z06==1)then
set zFs_zz2=10
return
endif
if(zFs_Z06==2)then
set zFs_zz2=15
return
endif
if(zFs_Z06==3)then
set zFs_zz2=20
return
endif
if(zFs_Z06==4)then
set zFs_zz2=40
return
endif
if(zFs_Z06==5)then
set zFs_zz2=50
return
endif
if(zFs_Z06==6)then
set zFs_zz2=70
return
endif
if(zFs_Z06==7)then
set zFs_zz2=80
return
endif
if(zFs_Z06==8)then
set zFs_zz2=90
return
endif
if(zFs_Z06==9)then
set zFs_zz2=100
return
endif
endfunction
function zFs_z97 takes unit zFs_z65,integer zFs_ZZ8,integer zFs_Zz8 returns nothing
call zFs_z87(zFs_Zz8)
call zFs_Zz6(zFs_ZZ8)
call SetUnitVertexColorBJ(zFs_z65,zFs_zZ2,zFs_Z92,zFs_Z82,zFs_zz2)
endfunction
function zFs_Z08 takes integer zFs_ZZ8,integer zFs_Zz8 returns nothing
call zFs_z87(zFs_Zz8)
call zFs_Zz6(zFs_ZZ8)
call SetWaterBaseColorBJ(zFs_zZ2,zFs_Z92,zFs_Z82,zFs_zz2)
endfunction
function zFs_Z18 takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call zFs_z97(zFs_z65,GetRandomInt(3,9),0)
set zFs_z65=null
endfunction
function zFs_Z28 takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call zFs_z97(zFs_z65,0,0)
set zFs_z65=null
endfunction
function zFs_Z38 takes integer zFs_z15,boolean zFs_z77 returns nothing
local integer zFs_Z75
local integer zFs_Z48
if(zFs_Z53[zFs_z15]==zFs_z77)then
else
set zFs_Z53[zFs_z15]=zFs_z77
if(zFs_z77)then
call EnableTrigger(zFs_z83)
else
set zFs_Z75=0
set zFs_Z48=0
loop
exitwhen zFs_Z75>11
if(zFs_Z53[zFs_Z75])then
set zFs_Z48=zFs_Z48+1
endif
set zFs_Z75=zFs_Z75+1
endloop
if(zFs_Z48==0)then
call DisableTrigger(zFs_z83)
endif
endif
endif
endfunction
function zFs_Z58 takes integer zFs_Z68 returns nothing
if(zFs_Z68==0)then
call SetSkyModel(null)
return
endif
if(zFs_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(zFs_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(zFs_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(zFs_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(zFs_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(zFs_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(zFs_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(zFs_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(zFs_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(zFs_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(zFs_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(zFs_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(zFs_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function zFs_Z78 takes integer zFs_Z88 returns integer
if(zFs_Z88==0)then
return 1380018290
endif
if(zFs_Z88==1)then
return 1380019314
endif
if(zFs_Z88==2)then
return 1296393331
endif
if(zFs_Z88==3)then
return 1178886760
endif
if(zFs_Z88==4)then
return 1178886764
endif
if(zFs_Z88==5)then
return 1178888040
endif
if(zFs_Z88==6)then
return 1178888044
endif
if(zFs_Z88==7)then
return 1178890856
endif
if(zFs_Z88==8)then
return 1178890860
endif
if(zFs_Z88==9)then
return 1178892136
endif
if(zFs_Z88==10)then
return 1178892140
endif
if(zFs_Z88==11)then
return 1380739186
endif
if(zFs_Z88==12)then
return 1380740210
endif
if(zFs_Z88==13)then
return 1397645939
endif
if(zFs_Z88==14)then
return 1397647475
endif
if(zFs_Z88==15)then
return 1397648499
endif
if(zFs_Z88==16)then
return 1464820599
endif
if(zFs_Z88==17)then
return 1464822903
endif
if(zFs_Z88==18)then
return 1280467297
endif
if(zFs_Z88==19)then
return 1280470369
endif
if(zFs_Z88==20)then
return 1464755063
endif
return 0
endfunction
function zFs_Z98 takes integer zFs_Z88,boolean zFs_z77 returns nothing
set zFs_Z88=zFs_Z88-1
if(zFs_z77)then
if(zFs_z12[zFs_Z88]==false)then
if(zFs_Z78(zFs_Z88)==0)then
else
set zFs_z02[zFs_Z88]=AddWeatherEffect(zFs_z8,zFs_Z78(zFs_Z88))
call EnableWeatherEffect(zFs_z02[zFs_Z88],true)
set zFs_z12[zFs_Z88]=true
endif
endif
else
if(zFs_z02[zFs_Z88]==null)then
else
call EnableWeatherEffect(zFs_z02[zFs_Z88],false)
call RemoveWeatherEffect(zFs_z02[zFs_Z88])
set zFs_z12[zFs_Z88]=false
set zFs_z02[zFs_Z88]=null
endif
endif
endfunction
function zFs_zZ8 takes nothing returns nothing
local integer zFs_z15=1
loop
exitwhen zFs_z15>21
call zFs_Z98(zFs_z15,false)
set zFs_z15=zFs_z15+1
endloop
endfunction
function zFs_zz8 takes integer zFs_z08 returns integer
if(zFs_z08==0)then
return 1280601204
endif
if(zFs_z08==1)then
return 1179939959
endif
if(zFs_z08==2)then
return 1465152631
endif
if(zFs_z08==3)then
return 1096053874
endif
if(zFs_z08==4)then
return 1096053859
endif
if(zFs_z08==5)then
return 1112831095
endif
if(zFs_z08==6)then
return 1263826039
endif
if(zFs_z08==7)then
return 1498707828
endif
if(zFs_z08==8)then
return 1498702708
endif
if(zFs_z08==9)then
return 1498703476
endif
if(zFs_z08==10)then
return 1498706804
endif
if(zFs_z08==11)then
return 1247044468
endif
if(zFs_z08==12)then
return 1247048823
endif
if(zFs_z08==13)then
return 1146385256
endif
if(zFs_z08==14)then
return 1129608306
endif
if(zFs_z08==15)then
return 1129608291
endif
if(zFs_z08==16)then
return 1230271607
endif
if(zFs_z08==17)then
return 1230271607
endif
if(zFs_z08==18)then
return 1314157667
endif
if(zFs_z08==19)then
return 1330934903
endif
if(zFs_z08==20)then
return 1515484279
endif
if(zFs_z08==21)then
return 1196716904
endif
if(zFs_z08==22)then
return 1448373364
endif
if(zFs_z08==23)then
return 1448373364
endif
return 0
endfunction
function zFs_z18 takes nothing returns integer
return zFs_zz8(GetRandomInt(0,23))
endfunction
function zFs_z28 takes unit zFs_z65,integer zFs_z38,integer zFs_z08,integer zFs_z48 returns nothing
local real zFs_z58
local real zFs_z68
local real zFs_z15=0
local boolean zFs_z78=true
set zFs_z58=GetUnitX(zFs_z65)
set zFs_z68=GetUnitY(zFs_z65)
if(zFs_z38==1)then
loop
exitwhen zFs_z15==zFs_z48
if(zFs_z78)then
call CreateDestructable(zFs_z08,zFs_z58,zFs_z68+zFs_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(zFs_z08,zFs_z58,zFs_z68-zFs_z15*40,GetRandomReal(0,360),1,0)
endif
set zFs_z78=not(zFs_z78)
set zFs_z15=zFs_z15+1
endloop
endif
if(zFs_z38==2)then
loop
exitwhen zFs_z15==zFs_z48
if(zFs_z78)then
call CreateDestructable(zFs_z08,zFs_z58+zFs_z15*40,zFs_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(zFs_z08,zFs_z58-zFs_z15*40,zFs_z68,GetRandomReal(0,360),1,0)
endif
set zFs_z78=not(zFs_z78)
set zFs_z15=zFs_z15+1
endloop
endif
if(zFs_z38==3)then
loop
exitwhen zFs_z15==zFs_z48
if(zFs_z78)then
call CreateDestructable(zFs_z08,zFs_z58+zFs_z15*40,zFs_z68+zFs_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(zFs_z08,zFs_z58-zFs_z15*40,zFs_z68-zFs_z15*40,GetRandomReal(0,360),1,0)
endif
set zFs_z78=not(zFs_z78)
set zFs_z15=zFs_z15+1
endloop
endif
if(zFs_z38==4)then
loop
exitwhen zFs_z15==zFs_z48
if(zFs_z78)then
call CreateDestructable(zFs_z08,zFs_z58+zFs_z15*40,zFs_z68-zFs_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(zFs_z08,zFs_z58-zFs_z15*40,zFs_z68+zFs_z15*40,GetRandomReal(0,360),1,0)
endif
set zFs_z78=not(zFs_z78)
set zFs_z15=zFs_z15+1
endloop
endif
endfunction
function zFs_z88 takes integer zFs_z15 returns nothing
set zFs_Z7[zFs_z15]=true
call StartTimerBJ(zFs_z0Z[zFs_z15],false,2.)
endfunction
function zFs_z98 takes integer zFs_z15,boolean zFs_ZZZZ returns nothing
local integer zFs_Z75
local integer zFs_z76
local item zFs_z86
local location zFs_z95
local unit zFs_z65
set zFs_z65=zFs_z7[zFs_z15]
set zFs_z76=1
loop
exitwhen zFs_z76>6
if(zFs_ZZZZ)then
set zFs_z95=GetUnitLoc(zFs_z51[zFs_z15])
else
set zFs_z95=GetUnitLoc(zFs_z65)
endif
set zFs_z86=UnitItemInSlotBJ(zFs_z65,zFs_z76)
if(GetItemCharges(zFs_z86)>0)then
set zFs_Z75=GetItemCharges(zFs_z86)
set zFs_z86=CreateItemLoc(GetItemTypeId(zFs_z86),zFs_z95)
call SetItemCharges(zFs_z86,zFs_Z75)
else
call CreateItemLoc(GetItemTypeId(zFs_z86),zFs_z95)
endif
call RemoveLocation(zFs_z95)
set zFs_z76=zFs_z76+1
endloop
set zFs_z65=null
set zFs_z95=null
set zFs_z86=null
endfunction
function zFs_ZZzZ takes integer zFs_z15,player zFs_z05 returns nothing
local integer zFs_Z75
local force zFs_ZZ0Z
local player zFs_Z65
if(zFs_z1Z[zFs_z15])then
call DestroyFogModifier(zFs_Z6[zFs_z15])
set zFs_z1Z[zFs_z15]=false
else
set zFs_ZZ0Z=CreateForce()
set zFs_Z75=0
loop
exitwhen zFs_Z75>11
set zFs_Z65=Player(zFs_Z75)
if(GetPlayerAlliance(zFs_z05,zFs_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(zFs_ZZ0Z,zFs_Z65)
call SetPlayerAlliance(zFs_z05,zFs_Z65,ALLIANCE_SHARED_VISION,false)
endif
set zFs_Z75=zFs_Z75+1
endloop
set zFs_Z6[zFs_z15]=CreateFogModifierRect(zFs_z05,FOG_OF_WAR_VISIBLE,zFs_z8,false,false)
call FogModifierStart(zFs_Z6[zFs_z15])
set zFs_z1Z[zFs_z15]=true
set zFs_Z75=0
loop
exitwhen zFs_Z75>11
set zFs_Z65=Player(zFs_Z75)
if(IsPlayerInForce(zFs_Z65,zFs_ZZ0Z))then
call SetPlayerAlliance(zFs_z05,zFs_Z65,ALLIANCE_SHARED_VISION,true)
endif
set zFs_Z75=zFs_Z75+1
endloop
call DestroyForce(zFs_ZZ0Z)
set zFs_ZZ0Z=null
set zFs_Z65=null
endif
endfunction
function zFs_ZZ1Z takes integer zFs_z15,player zFs_z05 returns nothing
local integer zFs_Z75
local unit zFs_z65
local item zFs_z86
local item array zFs_ZZ2Z
set zFs_z65=FirstOfGroup(zFs_Z8Z[zFs_z15])
if((zFs_z05==GetOwningPlayer(zFs_z65))and(UnitInventorySizeBJ(zFs_z65)>0))then
set zFs_Z75=1
loop
exitwhen zFs_Z75>6
set zFs_z86=UnitItemInSlotBJ(zFs_z65,zFs_Z75)
set zFs_ZZ2Z[(zFs_Z75-1)]=zFs_z86
call UnitRemoveItemSwapped(zFs_z86,zFs_z65)
call SetItemVisible(zFs_z86,false)
set zFs_Z75=zFs_Z75+1
endloop
set zFs_Z75=1
loop
exitwhen zFs_Z75>6
set zFs_z86=zFs_Z2z[(zFs_z15*18)+(zFs_Z4z[zFs_z15]*6)+(zFs_Z75-1)]
call UnitAddItem(zFs_z65,zFs_z86)
set zFs_Z2z[(zFs_z15*18)+(zFs_Z4z[zFs_z15]*6)+(zFs_Z75-1)]=zFs_ZZ2Z[(zFs_Z75-1)]
set zFs_ZZ2Z[(zFs_Z75-1)]=null
set zFs_Z75=zFs_Z75+1
endloop
if(zFs_Z4z[zFs_z15]==0)then
set zFs_Z4z[zFs_z15]=zFs_z61-1
else
set zFs_Z4z[zFs_z15]=(zFs_Z4z[zFs_z15]-1)
endif
set zFs_z86=null
endif
set zFs_z65=null
set zFs_z05=null
endfunction
function zFs_ZZ3Z takes unit zFs_z65 returns nothing
local integer zFs_Z75
local item zFs_z86
set zFs_Z75=1
loop
exitwhen zFs_Z75>6
set zFs_z86=UnitItemInSlotBJ(zFs_z65,zFs_Z75)
call UnitRemoveItemSwapped(zFs_z86,zFs_z65)
set zFs_Z75=zFs_Z75+1
endloop
set zFs_z86=null
endfunction
function zFs_ZZ4Z takes integer zFs_z15 returns nothing
local integer zFs_Z75
local item zFs_z86
local location zFs_z95
set zFs_z95=GetUnitLoc(zFs_z51[zFs_z15])
set zFs_Z75=1
loop
exitwhen zFs_Z75>6
set zFs_z86=UnitItemInSlotBJ(zFs_z7[zFs_z15],zFs_Z75)
call UnitRemoveItemSwapped(zFs_z86,zFs_z7[zFs_z15])
call SetItemPositionLoc(zFs_z86,zFs_z95)
set zFs_Z75=zFs_Z75+1
endloop
call RemoveLocation(zFs_z95)
set zFs_z86=null
set zFs_z95=null
endfunction
function zFs_ZZ5Z takes integer zFs_z15 returns nothing
local integer zFs_z76
local integer zFs_z78
local unit zFs_z65
local item zFs_Z66
local item zFs_ZZ6Z
set zFs_z65=FirstOfGroup(zFs_Z8Z[zFs_z15])
set zFs_z76=1
loop
exitwhen zFs_z76>5
set zFs_Z66=UnitItemInSlotBJ(zFs_z65,zFs_z76)
if(GetItemCharges(zFs_Z66)>0)then
set zFs_z78=zFs_z76+1
loop
exitwhen zFs_z78>6
set zFs_ZZ6Z=UnitItemInSlotBJ(zFs_z65,zFs_z78)
if(GetItemTypeId(zFs_Z66)==GetItemTypeId(zFs_ZZ6Z))then
call SetItemCharges(zFs_Z66,(GetItemCharges(zFs_Z66)+GetItemCharges(zFs_ZZ6Z)))
call RemoveItem(zFs_ZZ6Z)
endif
set zFs_z78=zFs_z78+1
endloop
endif
set zFs_z76=zFs_z76+1
endloop
set zFs_Z66=null
set zFs_ZZ6Z=null
set zFs_z65=null
endfunction
function zFs_ZZ7Z takes integer zFs_z15,integer zFs_Z75 returns nothing
local unit zFs_z65
local item zFs_z86
set zFs_z65=FirstOfGroup(zFs_Z8Z[zFs_z15])
set zFs_z86=UnitItemInSlotBJ(zFs_z65,1)
call SetItemCharges(zFs_z86,(GetItemCharges(zFs_z86)+zFs_Z75))
set zFs_z86=null
set zFs_z65=null
endfunction
function zFs_ZZ8Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call GroupAddUnit(zFs_z8Z,zFs_z65)
set zFs_z65=null
endfunction
function zFs_ZZ9Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call GroupRemoveUnit(zFs_z8Z,zFs_z65)
set zFs_z65=null
endfunction
function zFs_ZzZZ takes nothing returns nothing
local unit zFs_z65=GetTriggerUnit()
if((IsUnitDeadBJ(zFs_z65))and(IsUnitType(zFs_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(zFs_z8Z,zFs_z65)
endif
endfunction
function zFs_ZzzZ takes nothing returns nothing
call ForGroup(zFs_z8Z,function zFs_ZzZZ)
endfunction
function zFs_Zz0Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call ReviveHeroLoc(zFs_z65,zFs_Z9Z[zFs_Zzz],true)
call SetUnitManaPercentBJ(zFs_z65,100)
set zFs_z65=null
endfunction
function zFs_Zz1Z takes player zFs_z05 returns nothing
local group zFs_z46
set zFs_z46=zFs_Z94(zFs_z05)
set zFs_Zzz=GetPlayerId(zFs_z05)
call ForGroup(zFs_z46,function zFs_Zz0Z)
call DestroyGroup(zFs_z46)
set zFs_z46=null
endfunction
function zFs_Zz2Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call ModifyHeroStat(zFs_z81,zFs_z65,zFs_z91,zFs_z71)
set zFs_z65=null
endfunction
function zFs_Zz3Z takes integer zFs_z15,integer zFs_Zz4Z,integer zFs_Zz5Z,boolean zFs_z25 returns nothing
local integer zFs_Zz6Z
if(zFs_z25)then
set zFs_Zz6Z=0
else
set zFs_Zz6Z=1
endif
if(zFs_Z0)then
set zFs_z91=zFs_Zz6Z
set zFs_z81=zFs_Zz4Z
set zFs_z71=zFs_Zz5Z
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Zz2Z)
else
call ModifyHeroStat(zFs_Zz4Z,zFs_z7[zFs_z15],zFs_Zz6Z,zFs_Zz5Z)
endif
endfunction
function zFs_Zz7Z takes unit zFs_z65,integer zFs_Zz5Z,boolean zFs_z25 returns nothing
local integer zFs_z15
set zFs_z15=GetHeroLevel(zFs_z65)
if(zFs_z25)then
set zFs_z15=zFs_z15+zFs_Zz5Z
else
set zFs_z15=zFs_z15-zFs_Zz5Z
endif
call SetHeroLevelBJ(zFs_z65,zFs_z15,false)
endfunction
function zFs_Zz8Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_Zz7Z(zFs_z65,zFs_ZZ2,zFs_Z1z)
set zFs_z65=null
endfunction
function zFs_Zz9Z takes integer zFs_z15,integer zFs_Zz5Z,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_ZZ2=zFs_Zz5Z
set zFs_Z1z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Zz8Z)
else
call zFs_Zz7Z(zFs_z7[zFs_z15],zFs_Zz5Z,zFs_z25)
endif
endfunction
function zFs_Z0ZZ takes string zFs_Z0zZ returns integer
local string zFs_Z00Z="0123456789"
local string zFs_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string zFs_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer zFs_Id=0
local integer zFs_Z03Z=1
local integer zFs_Z04Z=1
loop
exitwhen zFs_Z03Z>StringLength(zFs_Z0zZ)
loop
exitwhen zFs_Z04Z>10
if SubString(zFs_Z0zZ,zFs_Z03Z-1,zFs_Z03Z)==SubString(zFs_Z00Z,zFs_Z04Z-1,zFs_Z04Z)then
set zFs_Id=zFs_Id+R2I((48+zFs_Z04Z-1)*Pow(256.,I2R(StringLength(zFs_Z0zZ)-zFs_Z03Z)))
set zFs_Z04Z=zFs_Z04Z+1
else
set zFs_Z04Z=zFs_Z04Z+1
endif
endloop
set zFs_Z04Z=1
loop
exitwhen zFs_Z04Z>26
if SubString(zFs_Z0zZ,zFs_Z03Z-1,zFs_Z03Z)==SubString(zFs_Z01Z,zFs_Z04Z-1,zFs_Z04Z)then
set zFs_Id=zFs_Id+R2I(I2R(65+zFs_Z04Z-1)*Pow(256.,I2R(StringLength(zFs_Z0zZ)-zFs_Z03Z)))
set zFs_Z04Z=zFs_Z04Z+1
else
set zFs_Z04Z=zFs_Z04Z+1
endif
endloop
set zFs_Z04Z=1
loop
exitwhen zFs_Z04Z>26
if SubString(zFs_Z0zZ,zFs_Z03Z-1,zFs_Z03Z)==SubString(zFs_Z02Z,zFs_Z04Z-1,zFs_Z04Z)then
set zFs_Id=zFs_Id+R2I((97+zFs_Z04Z-1)*Pow(256.,I2R(StringLength(zFs_Z0zZ)-zFs_Z03Z)))
set zFs_Z04Z=zFs_Z04Z+1
else
set zFs_Z04Z=zFs_Z04Z+1
endif
endloop
set zFs_Z04Z=1
set zFs_Z03Z=zFs_Z03Z+1
endloop
return zFs_Id
endfunction
function zFs_Z05Z takes integer zFs_Z06Z returns string
local string zFs_Z00Z="0123456789"
local string zFs_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string zFs_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string zFs_Z07Z=""
local integer zFs_Z03Z=0
local integer zFs_Z08Z=0
loop
exitwhen zFs_Z06Z==0
set zFs_Z03Z=ModuloInteger(zFs_Z06Z,256)
if zFs_Z03Z>=48 and zFs_Z03Z<=57 then
set zFs_Z08Z=zFs_Z03Z-48
set zFs_Z07Z=SubString(zFs_Z00Z,zFs_Z08Z,zFs_Z08Z+1)+zFs_Z07Z
endif
if zFs_Z03Z>=65 and zFs_Z03Z<=90 then
set zFs_Z08Z=zFs_Z03Z-65
set zFs_Z07Z=SubString(zFs_Z01Z,zFs_Z08Z,zFs_Z08Z+1)+zFs_Z07Z
endif
if zFs_Z03Z>=97 and zFs_Z03Z<=122 then
set zFs_Z08Z=zFs_Z03Z-97
set zFs_Z07Z=SubString(zFs_Z02Z,zFs_Z08Z,zFs_Z08Z+1)+zFs_Z07Z
endif
set zFs_Z06Z=zFs_Z06Z/256
endloop
return zFs_Z07Z
endfunction
function zFs_Z09Z takes unit zFs_z65 returns string
local integer zFs_z15
set zFs_z15=GetUnitTypeId(zFs_z65)
if(zFs_z15==0)then
return""
else
return zFs_Z05Z(zFs_z15)
endif
endfunction
function zFs_Z1ZZ takes unit zFs_z65 returns string
local item zFs_z86=UnitItemInSlotBJ(zFs_z65,1)
local integer zFs_z15=GetItemTypeId(zFs_z86)
if(zFs_z15==0)then
return""
else
set zFs_z86=null
return zFs_Z05Z(zFs_z15)
endif
endfunction
function zFs_Z1zZ takes integer zFs_Z10Z returns integer
local string zFs_Z11Z=GetEventPlayerChatString()
if(StringLength(zFs_Z11Z)==zFs_Z10Z+3)then
return(zFs_Z0ZZ(SubStringBJ(zFs_Z11Z,zFs_Z10Z,zFs_Z10Z+3)))
else
return 0
endif
endfunction
function zFs_Z12Z takes unit zFs_z65,integer zFs_z66,boolean zFs_z25 returns nothing
local location zFs_z95
local integer zFs_z15
set zFs_z15=zFs_Z1zZ(zFs_z66)
if(zFs_z15==0)then
else
if(zFs_z25)then
set zFs_z95=GetUnitLoc(zFs_z65)
call CreateItemLoc(zFs_z15,zFs_z95)
call RemoveLocation(zFs_z95)
set zFs_z95=null
else
call UnitAddItemById(zFs_z65,zFs_z15)
endif
endif
endfunction
function zFs_Z13Z takes unit zFs_z65,real zFs_Z14Z,boolean zFs_z25 returns nothing
local location zFs_z95=GetUnitLoc(zFs_z65)
local player zFs_z05=GetOwningPlayer(zFs_z65)
call SetBlightRadiusLocBJ(zFs_z25,zFs_z05,zFs_z95,zFs_Z14Z)
call RemoveLocation(zFs_z95)
set zFs_z95=null
set zFs_z05=null
endfunction
function zFs_Z15Z takes unit zFs_z65,real zFs_Z14Z returns nothing
call SetUnitFlyHeight(zFs_z65,zFs_Z14Z,.0)
endfunction
function zFs_Z16Z takes nothing returns integer
local integer zFs_Z17Z=0
local integer zFs_Z18Z=0
local integer array zFs_Z19Z
local integer zFs_z15=0
local player zFs_z05=GetLocalPlayer()
loop
exitwhen zFs_z15>11
set zFs_Z19Z[zFs_z15]=0
set zFs_z15=zFs_z15+1
endloop
loop
exitwhen zFs_Z17Z>14
call StoreInteger(zFs_z03,"Hke_Player","Hke_number",GetPlayerId(zFs_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(zFs_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set zFs_Z18Z=GetStoredInteger(zFs_z03,"Hke_Player","Hke_number")-1
set zFs_Z19Z[zFs_Z18Z]=zFs_Z19Z[zFs_Z18Z]+1
call FlushStoredMission(zFs_z03,"Hke_Player")
set zFs_Z17Z=zFs_Z17Z+1
endloop
set zFs_Z18Z=0
set zFs_Z17Z=0
set zFs_z05=null
loop
exitwhen zFs_Z17Z>11
if zFs_Z19Z[zFs_Z18Z]<zFs_Z19Z[zFs_Z17Z]then
set zFs_Z18Z=zFs_Z17Z
endif
set zFs_Z17Z=zFs_Z17Z+1
endloop
return zFs_Z18Z+1
endfunction
function zFs_Z2ZZ takes unit zFs_z65,integer zFs_Z2zZ,boolean zFs_z25 returns nothing
if(zFs_z25)then
call UnitAddAbility(zFs_z65,zFs_Z2zZ)
call SetUnitAbilityLevel(zFs_z65,zFs_Z2zZ,100)
call UnitMakeAbilityPermanent(zFs_z65,true,zFs_Z2zZ)
else
call UnitMakeAbilityPermanent(zFs_z65,false,zFs_Z2zZ)
call UnitRemoveAbility(zFs_z65,zFs_Z2zZ)
endif
endfunction
function zFs_Z20Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_Z2ZZ(zFs_z65,zFs_zzz,zFs_z0z)
set zFs_z65=null
endfunction
function zFs_Z21Z takes integer zFs_z15,integer zFs_Z2zZ,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_zzz=zFs_Z2zZ
set zFs_z0z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z20Z)
else
call zFs_Z2ZZ(zFs_z7[zFs_z15],zFs_Z2zZ,zFs_z25)
endif
endfunction
function zFs_Z22Z takes string zFs_Z11Z returns integer
if(zFs_Z11Z=="mm")then
return 1094937907
endif
if(zFs_Z11Z=="xj")then
return 1095659625
endif
if(zFs_Z11Z=="zj")then
return 1095262824
endif
if(zFs_Z11Z=="zm")then
return 1095721842
endif
if(zFs_Z11Z=="ft")then
return 1096119411
endif
if(zFs_Z11Z=="xx")then
return 1095333473
endif
if(zFs_Z11Z=="sb")then
return 1095066998
endif
if(zFs_Z11Z=="yx")then
return 1097886070
endif
if(zFs_Z11Z=="rh")then
return 1095657827
endif
if(zFs_Z11Z=="fl")then
return 1095656289
endif
if(zFs_Z11Z=="bs")then
return 1094935923
endif
if(zFs_Z11Z=="jg")then
return 1095332984
endif
if(zFs_Z11Z=="jf")then
return 1095328816
endif
if(zFs_Z11Z=="js")then
return 1095332728
endif
if(zFs_Z11Z=="jm")then
return 1095332722
endif
if(zFs_Z11Z=="jj")then
return 1095917932
endif
if(zFs_Z11Z=="fy")then
return 1098150517
endif
if(zFs_Z11Z=="ghh")then
return 1095262562
endif
if(zFs_Z11Z=="ghj")then
return 1095721317
endif
if(zFs_Z11Z=="gqj")then
return 1095065970
endif
if(zFs_Z11Z=="gxx")then
return 1096114550
endif
if(zFs_Z11Z=="gzz")then
return 1095262564
endif
if(zFs_Z11Z=="gxe")then
return 1096114549
endif
if(zFs_Z11Z=="gjj")then
return 1095065960
endif
if(zFs_Z11Z=="gml")then
return 1094934883
endif
if(zFs_Z11Z=="gyl")then
return 1097818482
endif
if(zFs_Z11Z=="gjs")then
return 1096905580
endif
if(zFs_Z11Z=="qhy")then
return 1095329378
endif
if(zFs_Z11Z=="qdy")then
return 1095331938
endif
if(zFs_Z11Z=="qlh")then
return 1095332719
endif
if(zFs_Z11Z=="qyz")then
return 1095328878
endif
if(zFs_Z11Z=="qbd")then
return 1095331682
endif
if(zFs_Z11Z=="qfs")then
return 1095328610
endif
if(zFs_Z11Z=="qsd")then
return 1095330924
endif
if(zFs_Z11Z=="qjs")then
return 1095332706
endif
if(zFs_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function zFs_Z23Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call SetUnitInvulnerable(zFs_z65,zFs_z0z)
call zFs_Z2ZZ(zFs_z65,1098282348,zFs_z0z)
set zFs_z65=null
endfunction
function zFs_Z24Z takes integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_z0z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z23Z)
else
call SetUnitInvulnerable(zFs_z7[zFs_z15],zFs_z25)
call zFs_Z2ZZ(zFs_z7[zFs_z15],1098282348,zFs_z25)
endif
endfunction
function zFs_Z25Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call SetUnitPathing(zFs_z65,not(zFs_z0z))
set zFs_z65=null
endfunction
function zFs_Z26Z takes integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_z0z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z25Z)
else
call SetUnitPathing(zFs_z7[zFs_z15],not(zFs_z25))
endif
endfunction
function zFs_Z27Z takes unit zFs_z65,boolean zFs_z25 returns nothing
if(zFs_z25)then
call SetUnitMoveSpeed(zFs_z65,1000)
else
call SetUnitMoveSpeed(zFs_z65,GetUnitDefaultMoveSpeed(zFs_z65))
endif
endfunction
function zFs_Z28Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_Z27Z(zFs_z65,zFs_z0z)
set zFs_z65=null
endfunction
function zFs_Z29Z takes integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_z0z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z28Z)
else
call zFs_Z27Z(zFs_z7[zFs_z15],zFs_z25)
endif
endfunction
function zFs_Z3ZZ takes integer zFs_z15,boolean zFs_z25 returns nothing
call zFs_ZzzZ()
if(zFs_Z0)then
if(zFs_z25)then
if(CountUnitsInGroup(zFs_z8Z)==0)then
call EnableTrigger(zFs_z73)
endif
call GroupAddGroup(zFs_Z8Z[zFs_z15],zFs_z8Z)
else
call GroupRemoveGroup(zFs_Z8Z[zFs_z15],zFs_z8Z)
if(CountUnitsInGroup(zFs_z8Z)==0)then
call DisableTrigger(zFs_z73)
endif
endif
else
if(zFs_z25)then
if(CountUnitsInGroup(zFs_z8Z)==0)then
call EnableTrigger(zFs_z73)
endif
call GroupAddUnit(zFs_z8Z,zFs_z7[zFs_z15])
else
call GroupRemoveUnit(zFs_z8Z,zFs_z7[zFs_z15])
if(CountUnitsInGroup(zFs_z8Z)==0)then
call DisableTrigger(zFs_z73)
endif
endif
endif
endfunction
function zFs_Z3zZ takes unit zFs_z65,boolean zFs_z25 returns nothing
call zFs_Z2ZZ(zFs_z65,1095262562,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1095721317,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1095065970,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1096114550,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1095262564,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1096114549,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1094934883,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1095065960,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1097818482,zFs_z25)
call zFs_Z2ZZ(zFs_z65,1096905580,zFs_z25)
endfunction
function zFs_Z30Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_Z3zZ(zFs_z65,zFs_z0z)
set zFs_z65=null
endfunction
function zFs_Z31Z takes integer zFs_z15,boolean zFs_z25 returns nothing
if(zFs_Z0)then
set zFs_z0z=zFs_z25
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z30Z)
else
call zFs_Z3zZ(zFs_z7[zFs_z15],zFs_z25)
endif
endfunction
function zFs_Z32Z takes unit zFs_z65 returns nothing
call zFs_Z2ZZ(zFs_z65,1094937907,false)
call zFs_Z2ZZ(zFs_z65,1095659625,false)
call zFs_Z2ZZ(zFs_z65,1095262824,false)
call zFs_Z2ZZ(zFs_z65,1095721842,false)
call zFs_Z2ZZ(zFs_z65,1096119411,false)
call zFs_Z2ZZ(zFs_z65,1095333473,false)
call zFs_Z2ZZ(zFs_z65,1095066998,false)
call zFs_Z2ZZ(zFs_z65,1097886070,false)
call zFs_Z2ZZ(zFs_z65,1095657827,false)
call zFs_Z2ZZ(zFs_z65,1095656289,false)
call zFs_Z2ZZ(zFs_z65,1098282348,false)
call zFs_Z2ZZ(zFs_z65,1094935923,false)
call zFs_Z2ZZ(zFs_z65,1095332984,false)
call zFs_Z2ZZ(zFs_z65,1095328816,false)
call zFs_Z2ZZ(zFs_z65,1095332728,false)
call zFs_Z2ZZ(zFs_z65,1095332722,false)
call zFs_Z2ZZ(zFs_z65,1098150517,false)
call SetUnitInvulnerable(zFs_z65,false)
call SetUnitPathing(zFs_z65,true)
call zFs_Z27Z(zFs_z65,false)
call GroupRemoveUnit(zFs_z8Z,zFs_z65)
endfunction
function zFs_Z33Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_Z32Z(zFs_z65)
set zFs_z65=null
endfunction
function zFs_Z34Z takes integer zFs_z15 returns nothing
if(zFs_Z0)then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z33Z)
else
call zFs_Z32Z(zFs_z7[zFs_z15])
endif
endfunction
function zFs_Z35Z takes nothing returns nothing
local unit zFs_z65=GetTriggerUnit()
local trigger zFs_Z66=GetTriggeringTrigger()
call RemoveUnit(zFs_z65)
call DisableTrigger(zFs_Z66)
call DestroyTrigger(zFs_Z66)
set zFs_z65=null
set zFs_Z66=null
endfunction
function zFs_Z36Z takes integer zFs_z66,unit zFs_Z37Z,player zFs_Z38Z returns nothing
local location zFs_z95
local unit zFs_z65
local integer zFs_Z39Z=0
local integer zFs_Z4ZZ=0
local trigger zFs_Z66
if(zFs_z66==0)then
set zFs_Z39Z=1095726692
set zFs_Z4ZZ=852503
endif
if(zFs_z66==1)then
set zFs_Z39Z=1095070833
set zFs_Z4ZZ=852184
endif
if(zFs_z66==2)then
set zFs_Z39Z=1095070566
set zFs_Z4ZZ=852183
endif
if((zFs_Z39Z==0)and(zFs_Z4ZZ==0))then
return
endif
set zFs_z95=GetUnitLoc(zFs_Z37Z)
set zFs_z65=CreateUnitAtLoc(zFs_Z38Z,1851941228,zFs_z95,bj_UNIT_FACING)
call UnitAddAbility(zFs_z65,1098282348)
call UnitAddAbility(zFs_z65,zFs_Z39Z)
call ShowUnit(zFs_z65,false)
call SetUnitUseFood(zFs_z65,false)
call SetUnitScale(zFs_z65,.01,.01,.01)
call SetUnitState(zFs_z65,UNIT_STATE_MANA,GetUnitState(zFs_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(zFs_z65,zFs_Z4ZZ)
set zFs_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(zFs_Z66,zFs_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(zFs_Z66,zFs_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(zFs_Z66,function zFs_Z35Z)
call RemoveLocation(zFs_z95)
set zFs_z95=null
set zFs_Z66=null
set zFs_z65=null
endfunction
function zFs_Z4zZ takes unit zFs_Z37Z returns nothing
local player zFs_z05=GetTriggerPlayer()
local location zFs_z95=GetUnitLoc(zFs_Z37Z)
local trigger zFs_Z66=CreateTrigger()
local unit zFs_z65=CreateUnitAtLoc(zFs_z05,1751543663,zFs_z95,bj_UNIT_FACING)
call UnitAddAbility(zFs_z65,1098282348)
call UnitAddAbility(zFs_z65,1095332709)
call ShowUnit(zFs_z65,false)
call SetUnitUseFood(zFs_z65,false)
call SetUnitScale(zFs_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(zFs_z65,852592,zFs_z95)
call TriggerRegisterUnitEvent(zFs_Z66,zFs_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(zFs_Z66,zFs_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(zFs_Z66,function zFs_Z35Z)
call RemoveLocation(zFs_z95)
set zFs_z95=null
set zFs_Z66=null
set zFs_z05=null
endfunction
function zFs_Z40Z takes integer zFs_z15,dialog zFs_Z41Z,trigger zFs_zZ6 returns nothing
set zFs_Zz3[zFs_z15]=zFs_Z41Z
set zFs_Z03[zFs_z15]=zFs_zZ6
endfunction
function zFs_Z42Z takes integer zFs_z15,string zFs_Z43Z returns nothing
call DialogClear(zFs_Zz3[zFs_z15])
call DialogSetMessage(zFs_Zz3[zFs_z15],(zFs_Z43Z+zFs_Z0z+zFs_Z62))
endfunction
function zFs_Z44Z takes integer zFs_z15,player zFs_z05,boolean zFs_z77 returns nothing
if(zFs_z77)then
call EnableTrigger(zFs_Z03[zFs_z15])
call DialogDisplay(zFs_z05,zFs_Zz3[zFs_z15],true)
call TimerStart(zFs_Z73[zFs_z15],zFs_z1,false,null)
else
call DisableTrigger(zFs_Z03[zFs_z15])
call DialogDisplay(zFs_z05,zFs_Zz3[zFs_z15],false)
endif
endfunction
function zFs_Z45Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_zZ1[zFs_z15],zFs_ZZ1[zFs_z15])
call zFs_Z42Z(zFs_z15,"主")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"资源菜单[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"自动化设置[B]",66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"选定单位特殊属性[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"个人选项设置[D]",68)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"帮助菜单[E]",69)
if(zFs_z05==zFs_z5)then
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"其他玩家作弊管理[F]",70)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"其他玩家管理[G]",71)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"游戏作弊选项[H]",72)
if(zFs_z13)then
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z46Z takes integer zFs_z15,player zFs_z05 returns nothing
local string zFs_Z11Z
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Zz1[zFs_z15])
call zFs_Z42Z(zFs_z15,"自动化设置")
if(IsTriggerEnabled(zFs_z40[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(zFs_z50[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(zFs_z60[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(zFs_z80[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(zFs_z70[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(zFs_z90[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"魔法释放后自动MP"+I2S(R2I(zFs_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(zFs_ZZ3[zFs_z15]))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"生命低于"+I2S(R2I(zFs_z92))+"%加到"+I2S(R2I(zFs_z41))+"%[G]"),71)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"全部开启[O]",79)
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"全部关闭[U]",85)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z11Z=""
endfunction
function zFs_Z47Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z01[zFs_z15])
call zFs_Z42Z(zFs_z15,"选定单位特殊属性")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"无敌[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"永久隐形[B]",66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"穿越物体[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"魔免[D]",68)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"反隐形[E]",69)
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"移动速度[F]",70)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"各种光环[G]",71)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"换页[N]",78)
if((zFs_z9Z)or(zFs_z5==zFs_z05))then
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"秒杀模式[K]",75)
endif
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"取消全部(不含光环)[U]",85)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z48Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_Z91[zFs_z15],zFs_Z81[zFs_z15])
call zFs_Z42Z(zFs_z15,"选定单位特殊属性")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"永久献祭[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"闪避[B]",514)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"重击[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"致命一击[D]",68)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"反弹(小强的壳)[E]",69)
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"分裂攻击[F]",70)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"燃灰[G]",71)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"减少魔法伤害33%[H]",72)
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"闪避100%[I]",73)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"换页[N]",78)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z49Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_Z91[zFs_z15],zFs_Z21[zFs_z15])
call zFs_Z42Z(zFs_z15,"光环")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"辉煌光环[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"荆棘光环[B]",66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"耐久光环[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"强击光环[D]",68)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"邪恶光环[E]",69)
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"吸血光环[F]",70)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"专注光环[G]",71)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"命令光环(战鼓)[H]",72)
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"医疗光环[I]",73)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"减速光环[J]",74)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"关所有光环[K]",75)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z5ZZ takes integer zFs_z15,player zFs_z05 returns nothing
local integer zFs_Z75=0
local string zFs_Z11Z
local string zFs_Z5zZ
local player zFs_Z65
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z51[zFs_z15])
call zFs_Z42Z(zFs_z15,"玩家作弊管理")
loop
exitwhen zFs_Z75>11
set zFs_Z65=Player(zFs_Z75)
if((GetPlayerController(zFs_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(zFs_Z65)==PLAYER_SLOT_STATE_PLAYING)and(zFs_Z65!=zFs_z5))then
set zFs_Z5zZ=GetPlayerName(zFs_Z65)
if(zFs_z6[zFs_Z75])then
set zFs_Z11Z="禁止"
else
set zFs_Z11Z="允许"
endif
set zFs_ZzZ[zFs_Z75]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+zFs_Z5zZ+"作弊"),0)
endif
set zFs_Z75=zFs_Z75+1
endloop
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z65=null
set zFs_Z11Z=""
set zFs_Z5zZ=""
endfunction
function zFs_Z50Z takes integer zFs_z15,player zFs_z05 returns nothing
set zFs_Z8[zFs_z15]=0
call zFs_Z40Z(zFs_z15,zFs_zZ1[zFs_z15],zFs_Z71[zFs_z15])
call zFs_Z42Z(zFs_z15,"单位")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"升100级[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("加三围"+(I2S(zFs_Z3)+"[B]")),66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"复制物品[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"复制单位[D]",68)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"掉身上物品[E]",69)
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"共享该单位视野[F]",70)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"特殊属性菜单[G]",71)
if((zFs_z7Z)or(zFs_z5==zFs_z05))then
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"控制它[H]",72)
endif
if(zFs_z5==zFs_z05)then
endif
if(zFs_z05==zFs_z5)then
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"改变单位所有者[J]",74)
endif
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z51Z takes integer zFs_z15,player zFs_z05 returns nothing
local string zFs_Z11Z
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z31[zFs_z15])
call zFs_Z42Z(zFs_z15,"游戏作弊选项")
if(zFs_Z0)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"操作所有单位[A]"),65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("设置背包数[B]"),66)
if(zFs_Z5Z)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"保护CheatMaster[C]"),67)
if(zFs_Z6Z)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(zFs_Z7Z)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("取消作弊时"+zFs_Z11Z+"地图全开[E]"),69)
if(zFs_z9Z)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"他人秒杀模式[F]"),70)
if(zFs_ZZz)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"禁止秒杀建筑[G]"),71)
if(zFs_z7Z)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"他人占据单位[H]"),72)
if(zFs_Z52)then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"禁止克隆操作农民[I]"),73)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z11Z=""
endfunction
function zFs_Z52Z takes integer zFs_z15,player zFs_z05 returns nothing
local string zFs_Z5zZ
local integer zFs_Z75=0
local player zFs_Z65
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z41[zFs_z15])
call zFs_Z42Z(zFs_z15,"玩家管理")
loop
exitwhen zFs_Z75>11
set zFs_Z65=Player(zFs_Z75)
if(GetPlayerSlotState(zFs_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set zFs_Z5zZ=GetPlayerName(zFs_Z65)
set zFs_ZzZ[zFs_Z75]=DialogAddButton(zFs_Zz3[zFs_z15],("选择"+zFs_Z5zZ+"操作"),0)
endif
set zFs_Z75=zFs_Z75+1
endloop
set zFs_ZzZ[12]=DialogAddButton(zFs_Zz3[zFs_z15],("选择中立生物操作"),90)
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z5zZ=""
set zFs_Z65=null
endfunction
function zFs_Z53Z takes integer zFs_z15,player zFs_z05 returns nothing
local player zFs_Z65=Player(zFs_Z5z)
call zFs_Z40Z(zFs_z15,zFs_Z91[zFs_z15],zFs_Z61[zFs_z15])
call zFs_Z42Z(zFs_z15,"玩家管理")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"资源管理[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"向他收税黄金"+I2S(zFs_z22)+"%[C]",67)
else
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"向他收税木材"+I2S(zFs_z22)+"%[D]",68)
else
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"停止向他收木材[D]",67)
endif
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回选择菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z65=null
endfunction
function zFs_Z54Z takes integer zFs_z15,player zFs_z05 returns nothing
local integer zFs_Z75=0
local player zFs_Z65
local string zFs_Z11Z
local string zFs_Z5zZ
call zFs_Z40Z(zFs_z15,zFs_Z91[zFs_z15],zFs_Z11[zFs_z15])
call zFs_Z42Z(zFs_z15,"选定单位控制")
loop
exitwhen zFs_Z75>12
set zFs_Z65=Player(zFs_Z75)
if(GetPlayerSlotState(zFs_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set zFs_Z5zZ=GetPlayerName(zFs_Z65)
set zFs_ZzZ[zFs_Z75]=DialogAddButton(zFs_Zz3[zFs_z15],("给"+zFs_Z5zZ+"控制"),0)
endif
set zFs_Z75=zFs_Z75+1
endloop
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回单位菜单[R]",82)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z65=null
set zFs_Z11Z=""
set zFs_Z5zZ=""
endfunction
function zFs_Z55Z takes integer zFs_z15,player zFs_z05 returns nothing
local string zFs_Z11Z
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Zz2[zFs_z15])
call zFs_Z42Z(zFs_z15,"资源设置")
if(zFs_z1Z[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="打开"
endif
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"地图[A]"),65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("复活死亡英雄[B]"),66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"人口清5[B]",66)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"总人口100[C]",67)
if(GetPlayerHandicap(zFs_z05)==2)then
set zFs_Z11Z="恢复生命障碍100%"
else
set zFs_Z11Z="200%生命"
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(zFs_z05)==2)then
set zFs_Z11Z="恢复普通经验率"
else
set zFs_Z11Z="2倍经验"
endif
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"[E]",69)
set zFs_Z11Z=I2S(zFs_Z2)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("加"+zFs_Z11Z+"钱[F]"),70)
set zFs_Z11Z=I2S(zFs_z2)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("加"+zFs_Z11Z+"木[G]"),71)
set zFs_Z11Z=I2S(zFs_Z2)
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("减"+zFs_Z11Z+"钱[H]"),72)
set zFs_Z11Z=I2S(zFs_z2)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("减"+zFs_Z11Z+"木[I]"),73)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z11Z=""
endfunction
function zFs_Z56Z takes integer zFs_z15,player zFs_z05 returns nothing
local player zFs_Z65=Player(zFs_Z5z)
local string zFs_Z11Z
local string zFs_Z5zZ=GetPlayerName(zFs_Z65)
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z02[zFs_z15])
call DialogClear(zFs_Z20[zFs_z15])
call DialogSetMessage(zFs_Z20[zFs_z15],(zFs_Z5zZ+"钱"+I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(zFs_z1Z[zFs_Z5z])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="打开"
endif
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],(zFs_Z11Z+"地图[A]"),65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("复活死亡英雄[B]"),66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"人口清5[B]",66)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"总人口100[C]",67)
if(GetPlayerHandicap(zFs_Z65)==2)then
set zFs_Z11Z="恢复生命障碍100%"
else
set zFs_Z11Z="200%生命"
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(zFs_Z65)==2)then
set zFs_Z11Z="恢复普通经验率"
else
set zFs_Z11Z="2倍经验"
endif
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"[E]",69)
set zFs_Z11Z=I2S(zFs_Z2)
set zFs_z7z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("加"+zFs_Z11Z+"钱[F]"),70)
set zFs_Z11Z=I2S(zFs_z2)
set zFs_z6z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("加"+zFs_Z11Z+"木[G]"),71)
set zFs_Z11Z=I2S(zFs_Z2)
set zFs_Zz0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("减"+zFs_Z11Z+"钱[H]"),72)
set zFs_Z11Z=I2S(zFs_z2)
set zFs_ZZ0[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("减"+zFs_Z11Z+"木[I]"),73)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z11Z=""
set zFs_Z5zZ=""
set zFs_Z65=null
endfunction
function zFs_Z57Z takes integer zFs_z15,player zFs_z05 returns nothing
local player zFs_Z65=Player(zFs_Z5z)
local string zFs_Z11Z
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z12[zFs_z15])
call zFs_Z42Z(zFs_z15,"同盟管理")
if(IsPlayerAlly(zFs_Z65,zFs_z5))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("强制"+zFs_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(zFs_Z65,zFs_z5))then
if(GetPlayerAlliance(zFs_Z65,zFs_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("强制"+zFs_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(zFs_Z65,zFs_z5,ALLIANCE_SHARED_XP))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("强制"+zFs_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(zFs_z5,zFs_Z65))then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],("强制"+zFs_Z11Z+"对其同盟[D]"),68)
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回玩家菜单[R]",82)
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z65=null
set zFs_Z11Z=""
endfunction
function zFs_Z58Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_Z91[zFs_z15],zFs_Z22[zFs_z15])
call DialogClear(zFs_Z91[zFs_z15])
call DialogSetMessage(zFs_Z91[zFs_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(zFs_z61)+"|r个")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"设置1个背包[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"设置2个背包[B]",66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"设置3个背包[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回选设置单[R]",82)
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z59Z takes integer zFs_z15,player zFs_z05 returns nothing
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z23[zFs_z15])
call zFs_Z42Z(zFs_z15,"帮助")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"键盘帮助[A]",65)
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"CMD帮助[B]",66)
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"CMD单位类帮助[C]",67)
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"显示玩家信息[D]",68)
if(zFs_z05==zFs_z5)then
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"显示设置信息[E]",69)
endif
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
endfunction
function zFs_Z6ZZ takes integer zFs_z15,player zFs_z05 returns nothing
local string zFs_Z11Z
call zFs_Z40Z(zFs_z15,zFs_Z20[zFs_z15],zFs_Z13[zFs_z15])
call zFs_Z42Z(zFs_z15,"个人选项")
set zFs_z2z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"删除我的复制单位[A]",65)
if(zFs_z31[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z4z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"克隆操作[B]",66)
if(zFs_Z33[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z5z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"组队克隆操作[C]",67)
if(zFs_Z53[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z3z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"隐藏加攻[D]",68)
if(zFs_Z63[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z9z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"隐藏加攻带溅射[E]",69)
if(zFs_Z43[zFs_z15])then
set zFs_Z11Z="关闭"
else
set zFs_Z11Z="开启"
endif
set zFs_z8z[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],zFs_Z11Z+"远程沉默[F]",70)
set zFs_Z00[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"回主菜单[R]",82)
set zFs_Z10[zFs_z15]=DialogAddButton(zFs_Zz3[zFs_z15],"退出菜单[X]",88)
call zFs_Z44Z(zFs_z15,zFs_z05,true)
set zFs_Z11Z=""
endfunction
function zFs_Z6zZ takes player zFs_z05 returns nothing
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"欢迎使用|cFFFF8C00zFs的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function zFs_Z60Z takes player zFs_z05 returns nothing
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"欢迎使用|cFFFF8C00zFs的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(zFs_z05==zFs_z5)then
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function zFs_Z61Z takes player zFs_z05 returns nothing
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"欢迎使用|cFFFF8C00zFs的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(zFs_z05==zFs_z5)then
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function zFs_Z62Z takes player zFs_z05 returns nothing
local integer zFs_Z75
local player zFs_Z65
local string zFs_Z11Z
local string zFs_Z63Z
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,"|CFFFF0000zFs1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set zFs_Z75=1
loop
exitwhen zFs_Z75>12
set zFs_Z65=Player(zFs_Z75-1)
if(GetPlayerSlotState(zFs_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set zFs_Z63Z=I2S(zFs_Z75)
set zFs_Z11Z=(GetPlayerName(zFs_Z65)+":编号:"+zFs_Z63Z)
set zFs_Z63Z=I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_GOLD))
set zFs_Z11Z=(zFs_Z11Z+" |CFFFFFF00黄金:"+zFs_Z63Z+"|R")
set zFs_Z63Z=I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set zFs_Z11Z=(zFs_Z11Z+" |CFF008000木头:"+zFs_Z63Z+"|R")
set zFs_Z63Z=I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set zFs_Z11Z=(zFs_Z11Z+" 人口:"+zFs_Z63Z)
set zFs_Z63Z=I2S(GetPlayerState(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set zFs_Z11Z=(zFs_Z11Z+"/"+zFs_Z63Z)
set zFs_Z11Z=zFs_Z11Z+" 作弊:"
if(zFs_z6[zFs_Z75-1])then
set zFs_Z11Z=zFs_Z11Z+"|cFF00FF33√|r"
else
set zFs_Z11Z=zFs_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(zFs_Z65)==MAP_CONTROL_USER)then
set zFs_Z11Z=zFs_Z11Z+" (玩家)"
if(zFs_Z75-1==zFs_zz3)then
set zFs_Z11Z=zFs_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set zFs_Z11Z=zFs_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,zFs_Z11Z)
endif
set zFs_Z75=zFs_Z75+1
endloop
set zFs_Z65=null
set zFs_Z11Z=""
set zFs_Z63Z=""
endfunction
function zFs_Z64Z takes nothing returns nothing
local string zFs_Z65Z
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,"|CFFFF0000zFs1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set zFs_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(zFs_z4Z)
set zFs_Z65Z=zFs_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(zFs_z5Z)
set zFs_Z65Z=zFs_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(zFs_z6Z)
set zFs_Z65Z=zFs_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(zFs_ZZZ))
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
set zFs_Z65Z=zFs_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(zFs_z41))
set zFs_Z65Z=zFs_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(zFs_z92))
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
set zFs_Z65Z=zFs_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(zFs_zZ)
set zFs_Z65Z=zFs_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(zFs_Zz)
set zFs_Z65Z=zFs_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(zFs_zz)
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
set zFs_Z65Z=zFs_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(zFs_Z2)
set zFs_Z65Z=zFs_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(zFs_z2)
set zFs_Z65Z=zFs_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(zFs_Z3)
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
set zFs_Z65Z=zFs_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(zFs_z61)
set zFs_Z65Z=zFs_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(zFs_Z1))
set zFs_Z65Z=zFs_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(zFs_z1))
set zFs_Z65Z=zFs_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(zFs_z42))
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
set zFs_Z65Z=zFs_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(zFs_z22)
set zFs_Z65Z=zFs_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(zFs_z3))
set zFs_Z65Z=zFs_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(zFs_Z4))
call DisplayTimedTextToPlayer(zFs_z5,0,0,zFs_Z1,zFs_Z65Z)
set zFs_Z65Z=""
endfunction
function zFs_Z66Z takes player zFs_z05,unit zFs_z65 returns nothing
local string zFs_Z11Z=zFs_Z09Z(zFs_z65)
set zFs_Z11Z="该单位的ID为|cFF33FF00"+zFs_Z11Z+"|r"
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,zFs_Z11Z)
set zFs_Z11Z=""
endfunction
function zFs_Z67Z takes player zFs_z05,unit zFs_z65 returns nothing
local string zFs_Z11Z=zFs_Z1ZZ(zFs_z65)
set zFs_Z11Z="该单位的第一格物品ID为|cFF33FF00"+zFs_Z11Z+"|r"
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,zFs_Z11Z)
set zFs_Z11Z=""
endfunction
function zFs_Z68Z takes integer zFs_z15 returns nothing
local unit zFs_z65=zFs_z7[zFs_z15]
local player zFs_z05=Player(zFs_z15)
local item zFs_z86
local integer zFs_Z75=0
local string zFs_Z11Z
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"zFs Unit Debug Info:")
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"单位X坐标:"+R2S(GetUnitX(zFs_z65))+" 单位Y坐标:"+R2S(GetUnitY(zFs_z65)))
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,"单位ID:"+zFs_Z09Z(zFs_z65))
if(IsUnitType(zFs_z65,UNIT_TYPE_HERO))then
set zFs_Z11Z="单位物品ID:"
loop
exitwhen zFs_Z75>5
set zFs_z86=UnitItemInSlot(zFs_z65,zFs_Z75)
set zFs_Z11Z=zFs_Z11Z+zFs_Z05Z(GetItemTypeId(zFs_z86))+" "
set zFs_Z75=zFs_Z75+1
endloop
call DisplayTimedTextToPlayer(zFs_z05,0,0,zFs_Z1,zFs_Z11Z)
set zFs_Z11Z=""
set zFs_z86=null
endif
set zFs_z65=null
set zFs_z05=null
endfunction
function zFs_Z69Z takes nothing returns nothing
if(zFs_z0)then
set zFs_Z62="主机版"
else
set zFs_Z62="标准版"
endif
set zFs_Z62=zFs_Z62+" (添加 By |cFFFF0000"+zFs_ZZ+"|r)"
if(zFs_Z4Z=="")then
else
set zFs_Z62=zFs_Z62+"|n"+zFs_Z4Z
endif
endfunction
function zFs_Z7ZZ takes nothing returns nothing
local trigger zFs_Z66=GetTriggeringTrigger()
local timer zFs_Z76=GetExpiredTimer()
call DestroyTrigger(zFs_Z66)
call DestroyTimer(zFs_Z76)
set zFs_z0=false
set zFs_Z66=null
set zFs_Z76=null
endfunction
function zFs_Z7zZ takes nothing returns nothing
local timer zFs_Z76
local trigger zFs_Z66
set zFs_z03=InitGameCache("WuHansen.Com")
set zFs_zz3=zFs_Z16Z()-1
if(zFs_z0)then
set zFs_Z76=CreateTimer()
set zFs_Z66=CreateTrigger()
call TriggerAddAction(zFs_Z66,function zFs_Z7ZZ)
call TriggerRegisterTimerExpireEvent(zFs_Z66,zFs_Z76)
call TimerStart(zFs_Z76,9.99,false,null)
set zFs_Z76=null
set zFs_Z66=null
endif
endfunction
function zFs_Z70Z takes nothing returns nothing
local integer zFs_z15=0
local timer zFs_Z76=GetExpiredTimer()
local player zFs_z05
loop
exitwhen zFs_z15>11
if(zFs_Z76==zFs_Z73[zFs_z15])then
set zFs_z05=Player(zFs_z15)
call zFs_Z44Z(zFs_z15,zFs_z05,false)
set zFs_z05=null
endif
set zFs_z15=zFs_z15+1
endloop
set zFs_Z76=null
endfunction
function zFs_Z71Z takes nothing returns nothing
local trigger zFs_Z66=GetTriggeringTrigger()
call TriggerExecute(zFs_Z66)
set zFs_Z66=null
endfunction
function zFs_Z72Z takes nothing returns nothing
local timer zFs_Z66=CreateTimer()
local trigger zFs_ZZ6Z=CreateTrigger()
call TriggerAddAction(zFs_ZZ6Z,function zFs_Z71Z)
call TriggerRegisterTimerExpireEvent(zFs_ZZ6Z,zFs_Z66)
call TimerStart(zFs_Z66,GetRandomReal(299,1092),false,null)
endfunction
function zFs_Z73Z takes nothing returns boolean
if(StringLength(zFs_Z0z)==152)then
else
call zFs_Z72Z()
endif
call TriggerClearConditions(zFs_z43)
return true
endfunction
function zFs_Z74Z takes nothing returns nothing
local integer zFs_z15=0
local timer zFs_Z76=GetExpiredTimer()
loop
exitwhen zFs_z15>11
if(zFs_Z76==zFs_z0Z[zFs_z15])then
set zFs_Z7[zFs_z15]=false
set zFs_Z8[zFs_z15]=0
set zFs_Z32[zFs_z15]=0
endif
set zFs_z15=zFs_z15+1
endloop
set zFs_Z76=null
endfunction
function zFs_Z75Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call UnitAddAbility(zFs_z65,1095331446)
set zFs_z65=null
endfunction
function zFs_Z76Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call UnitRemoveAbility(zFs_z65,1095331446)
set zFs_z65=null
endfunction
function zFs_Z77Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call UnitPauseTimedLife(zFs_z65,true)
set zFs_z65=null
endfunction
function zFs_Z78Z takes nothing returns nothing
local unit zFs_z65
set zFs_z65=GetEnumUnit()
call UnitPauseTimedLife(zFs_z65,false)
set zFs_z65=null
endfunction
function zFs_Z79Z takes nothing returns nothing
local integer zFs_z15
local integer zFs_Z75
local real zFs_Z14Z
local player zFs_z05
local player zFs_Z65
local string zFs_Z11Z
local string zFs_Z63Z
local string zFs_Z5zZ
local string zFs_Z65Z
local force zFs_Z8ZZ
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_Z63Z=GetEventPlayerChatString()
set zFs_Z63Z=StringCase(zFs_Z63Z,false)
if(zFs_z4)then
if(zFs_z6[zFs_z15])then
if(SubStringBJ(zFs_Z63Z,1,1)=="-")then
if(zFs_Z63Z=="-list")then
call zFs_Z62Z(zFs_z05)
endif
if(zFs_Z63Z=="-h")then
call zFs_Z6zZ(zFs_z05)
endif
if(zFs_Z63Z=="-c")then
call zFs_Z60Z(zFs_z05)
endif
if(zFs_Z63Z=="-mm")then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
if(zFs_Z63Z=="-lx")then
set zFs_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(zFs_Z63Z,2,3)=="lt")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
call zFs_Zz6(S2I(zFs_Z11Z))
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,7,200)
if(SubStringBJ(zFs_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,zFs_Z1,GetPlayerName(zFs_z05)+":"+zFs_Z72+zFs_Z11Z)
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="+")then
set zFs_Z8ZZ=zFs_z14(zFs_z05)
call DisplayTimedTextToForce(zFs_Z8ZZ,zFs_Z1,GetPlayerName(zFs_z05)+":"+zFs_Z72+zFs_Z11Z)
call DestroyForce(zFs_Z8ZZ)
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
set zFs_Z8ZZ=zFs_z24(zFs_z05)
call DisplayTimedTextToForce(zFs_Z8ZZ,zFs_Z1,GetPlayerName(zFs_z05)+":"+zFs_Z72+zFs_Z11Z)
call DestroyForce(zFs_Z8ZZ)
endif
set zFs_Z8ZZ=null
endif
if(SubStringBJ(zFs_Z63Z,2,3)=="zd")then
if((zFs_z32)or(zFs_z05==zFs_z5))then
call zFs_Z86()
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="k")then
if(SubStringBJ(zFs_Z63Z,3,3)=="l")then
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
set zFs_z31[zFs_z15]=false
else
if(SubStringBJ(zFs_Z63Z,4,4)=="+")then
set zFs_z31[zFs_z15]=true
endif
endif
else
if(SubStringBJ(zFs_Z63Z,3,3)=="-")then
call zFs_z07(zFs_z15,false)
else
call zFs_z07(zFs_z15,true)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="j")then
if(SubStringBJ(zFs_Z63Z,3,4)=="wd")then
call zFs_Z36Z(0,zFs_z7[zFs_z15],zFs_z05)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="nj")then
call zFs_Z36Z(1,zFs_z7[zFs_z15],zFs_z05)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="lx")then
call zFs_Z36Z(2,zFs_z7[zFs_z15],zFs_z05)
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="r")then
if(SubStringBJ(zFs_Z63Z,3,3)=="n")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,20)
if(zFs_Z11Z!="")then
call SetPlayerName(zFs_z05,zFs_Z11Z)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="h")then
if(SubStringBJ(zFs_Z63Z,4,4)=="+")then
call zFs_zZ7(zFs_z15,zFs_z05,true)
else
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_zZ7(zFs_z15,zFs_z05,false)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="m")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="-")then
call zFs_zz5(zFs_z05,zFs_Z75,false)
else
call zFs_zz5(zFs_z05,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="w")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="-")then
call zFs_z35(zFs_z05,zFs_Z75,false)
else
call zFs_z35(zFs_z05,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="p ")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED,zFs_Z75)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="pm")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,20))
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,zFs_Z75)
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="p")then
if(SubStringBJ(zFs_Z63Z,3,3)=="+")then
call PauseUnit(zFs_z7[zFs_z15],true)
else
if(SubStringBJ(zFs_Z63Z,3,3)=="-")then
call PauseUnit(zFs_z7[zFs_z15],false)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="h")then
if(SubStringBJ(zFs_Z63Z,3,4)=="dw")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call zFs_ZZ4Z(zFs_z15)
else
call zFs_ZZ3Z(zFs_z7[zFs_z15])
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="sj")then
if(zFs_z05==zFs_z5)then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
if zFs_Z11Z=="-"then
call SuspendHeroXPBJ(false,zFs_z7[zFs_z15])
else
call SuspendHeroXPBJ(true,zFs_z7[zFs_z15])
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="e")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if zFs_Z11Z=="-"then
call SetHeroXP(zFs_z7[zFs_z15],GetHeroXP(zFs_z7[zFs_z15])-zFs_Z75,false)
else
call SetHeroXP(zFs_z7[zFs_z15],GetHeroXP(zFs_z7[zFs_z15])+zFs_Z75,false)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="j")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if zFs_Z11Z=="-"then
call ModifyHeroSkillPoints(zFs_z7[zFs_z15],1,zFs_Z75)
else
if zFs_Z11Z=="+"then
call ModifyHeroSkillPoints(zFs_z7[zFs_z15],0,zFs_Z75)
else
call ModifyHeroSkillPoints(zFs_z7[zFs_z15],2,zFs_Z75)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="u")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
if zFs_Z75==0 then
set zFs_Z75=1
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_Zz9Z(zFs_z15,zFs_Z75,false)
else
call zFs_Zz9Z(zFs_z15,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="l")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
if(zFs_Z75==0)then
set zFs_Z75=zFs_zz
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_Zz3Z(zFs_z15,0,zFs_Z75,false)
else
call zFs_Zz3Z(zFs_z15,0,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="m")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
if(zFs_Z75==0)then
set zFs_Z75=zFs_zz
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_Zz3Z(zFs_z15,1,zFs_Z75,false)
else
call zFs_Zz3Z(zFs_z15,1,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="z")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
if(zFs_Z75==0)then
set zFs_Z75=zFs_zz
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_Zz3Z(zFs_z15,2,zFs_Z75,false)
else
call zFs_Zz3Z(zFs_z15,2,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="a")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,5,20))
if(zFs_Z75==0)then
set zFs_Z75=zFs_zz
endif
if(SubStringBJ(zFs_Z63Z,4,4)=="-")then
call zFs_Zz3Z(zFs_z15,0,zFs_Z75,false)
call zFs_Zz3Z(zFs_z15,1,zFs_Z75,false)
call zFs_Zz3Z(zFs_z15,2,zFs_Z75,false)
else
call zFs_Zz3Z(zFs_z15,0,zFs_Z75,true)
call zFs_Zz3Z(zFs_z15,1,zFs_Z75,true)
call zFs_Zz3Z(zFs_z15,2,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="r")then
call zFs_Zz1Z(zFs_z05)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="fz")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call zFs_z98(zFs_z15,true)
else
call zFs_z98(zFs_z15,false)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="db")then
call zFs_ZZ5Z(zFs_z15)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cw")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,20))
call zFs_ZZ7Z(zFs_z15,zFs_Z75)
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="a")then
if(SubStringBJ(zFs_Z63Z,3,3)=="m")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z40[zFs_z15],false)
else
call zFs_zz6(zFs_z40[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="w")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z50[zFs_z15],false)
else
call zFs_zz6(zFs_z50[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="p")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z60[zFs_z15],false)
else
call zFs_zz6(zFs_z60[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cd")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z80[zFs_z15],false)
else
call zFs_zz6(zFs_z80[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="mp")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z90[zFs_z15],false)
else
call zFs_zz6(zFs_z90[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="rs")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
if(zFs_Z11Z=="-")then
call zFs_zz6(zFs_z70[zFs_z15],false)
else
call zFs_zz6(zFs_z70[zFs_z15],true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="a")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,4,4)
if(zFs_Z11Z=="+")then
call zFs_z16(zFs_z15,true)
else
if(zFs_Z11Z=="-")then
call zFs_z16(zFs_z15,false)
endif
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,2,2)=="u")then
if(zFs_Z63Z=="-u")then
call zFs_Z61Z(zFs_z05)
else
if(SubStringBJ(zFs_Z63Z,3,3)=="g")then
set zFs_Z75=zFs_Z22Z(SubStringBJ(zFs_Z63Z,3,5))
if(zFs_Z75==0)then
else
if(SubStringBJ(zFs_Z63Z,6,6)=="-")then
call zFs_Z21Z(zFs_z15,zFs_Z75,false)
else
call zFs_Z21Z(zFs_z15,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,4,5)=="ca")then
call zFs_Z31Z(zFs_z15,false)
endif
if(SubStringBJ(zFs_Z63Z,4,5)=="oa")then
call zFs_Z31Z(zFs_z15,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,3)=="q")then
set zFs_Z75=zFs_Z22Z(SubStringBJ(zFs_Z63Z,3,5))
if(zFs_Z75==0)then
else
if(SubStringBJ(zFs_Z63Z,6,6)=="-")then
call zFs_Z21Z(zFs_z15,zFs_Z75,false)
else
call zFs_Z21Z(zFs_z15,zFs_Z75,true)
endif
endif
endif
set zFs_Z75=zFs_Z22Z(SubStringBJ(zFs_Z63Z,3,4))
if(zFs_Z75==0)then
else
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z21Z(zFs_z15,zFs_Z75,false)
else
call zFs_Z21Z(zFs_z15,zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cq")then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z26Z(zFs_z15,false)
else
call zFs_Z26Z(zFs_z15,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="wd")then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z24Z(zFs_z15,false)
else
call zFs_Z24Z(zFs_z15,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="hp")then
set zFs_Z14Z=S2R(SubStringBJ(zFs_Z63Z,6,8))
if(zFs_Z14Z<=100)then
call SetUnitLifePercentBJ(zFs_z7[zFs_z15],100-zFs_Z14Z)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="mp")then
set zFs_Z14Z=S2R(SubStringBJ(zFs_Z63Z,6,8))
if(zFs_Z14Z<=100)then
call SetUnitManaPercentBJ(zFs_z7[zFs_z15],100-zFs_Z14Z)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="lt")then
call zFs_Z16(S2I(SubStringBJ(zFs_Z63Z,6,6)),zFs_z7[zFs_z15],SubStringBJ(zFs_Z63Z,8,200))
endif
if((SubStringBJ(zFs_Z63Z,3,4)=="kz")and((zFs_z7Z)or(zFs_z05==zFs_z5)))then
set zFs_Z65=zFs_z05
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,20))
if(zFs_Z75==0)then
else
if(zFs_z05==zFs_z5)then
set zFs_Z65=Player(zFs_Z75-1)
endif
endif
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call SetUnitOwner(zFs_z7[zFs_z15],zFs_Z65,false)
else
call SetUnitOwner(zFs_z7[zFs_z15],zFs_Z65,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ys")then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z29Z(zFs_z15,false)
else
call zFs_Z29Z(zFs_z15,true)
endif
endif
if((SubStringBJ(zFs_Z63Z,3,4)=="ms")and((zFs_z9Z)or(zFs_z05==zFs_z5)))then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z3ZZ(zFs_z15,false)
else
call zFs_Z3ZZ(zFs_z15,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ca")then
call zFs_Z34Z(zFs_z15)
endif
if((SubStringBJ(zFs_Z63Z,3,4)=="jk")and(zFs_z05==zFs_z5))then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,20))
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z87(zFs_z7[zFs_z15],zFs_Z75,false)
else
call zFs_Z87(zFs_z7[zFs_z15],zFs_Z75,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="yd")then
call zFs_z55(zFs_z51[zFs_z15],zFs_z7[zFs_z15],false)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="jh")then
call zFs_z55(zFs_z7[zFs_z15],zFs_z51[zFs_z15],true)
endif
if(SubStringBJ(zFs_Z63Z,3,5)=="del")then
if(SubStringBJ(zFs_Z63Z,6,6)=="+")then
call zFs_z36(zFs_z05)
if(zFs_z05==zFs_z5)then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,7,8))
if((zFs_Z75>0)and(zFs_Z75<13))then
set zFs_Z75=zFs_Z75-1
set zFs_Z65=Player(zFs_Z75)
call zFs_z36(zFs_Z65)
endif
endif
else
call RemoveUnit(zFs_z7[zFs_z15])
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="nm")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,6))
if(zFs_Z75==1)then
call zFs_Z37(1752196449,zFs_z05,zFs_Z9Z[zFs_z15])
endif
if(zFs_Z75==2)then
call zFs_Z37(1869636975,zFs_z05,zFs_Z9Z[zFs_z15])
endif
if(zFs_Z75==3)then
call zFs_Z37(1702327152,zFs_z05,zFs_Z9Z[zFs_z15])
endif
if(zFs_Z75==4)then
call zFs_Z37(1969316719,zFs_z05,zFs_Z9Z[zFs_z15])
endif
if(zFs_Z75==5)then
call zFs_Z37(1852665957,zFs_z05,zFs_Z9Z[zFs_z15])
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cu")then
if(SubStringBJ(zFs_Z63Z,5,5)=="?")then
call zFs_Z66Z(zFs_z05,zFs_z7[zFs_z15])
else
set zFs_Z65Z=SubStringBJ(zFs_Z63Z,6,20)
set zFs_Z75=UnitId(zFs_Z65Z)
if(zFs_Z75==0)then
set zFs_Z75=zFs_Z1zZ(6)
endif
call zFs_Z37(zFs_Z75,zFs_z05,zFs_Z9Z[zFs_z15])
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ci")then
if(SubStringBJ(zFs_Z63Z,5,5)=="?")then
call zFs_Z67Z(zFs_z05,zFs_z7[zFs_z15])
else
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call zFs_Z12Z(zFs_z7[zFs_z15],6,false)
else
call zFs_Z12Z(zFs_z7[zFs_z15],6,true)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ua")then
set zFs_Z75=zFs_Z1zZ(6)
if(zFs_Z75==0)then
else
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z21Z(zFs_z15,zFs_Z75,false)
else
call zFs_Z21Z(zFs_z15,zFs_Z75,true)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="st")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,6,20)
if(zFs_Z11Z=="")then
call CreateCorpse(zFs_z05,GetUnitTypeId(zFs_z7[zFs_z15]),GetUnitX(zFs_z7[zFs_z15]),GetUnitY(zFs_z7[zFs_z15]),0)
else
call CreateCorpse(zFs_z05,zFs_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(zFs_z7[zFs_z15]),GetUnitY(zFs_z7[zFs_z15]),0)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,6)=="size")then
set zFs_Z14Z=S2R(SubStringBJ(zFs_Z63Z,8,10))
if(zFs_Z14Z==0)then
set zFs_Z14Z=100
endif
call SetUnitScalePercent(zFs_z7[zFs_z15],zFs_Z14Z,zFs_Z14Z,zFs_Z14Z)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(zFs_z7[zFs_z15],S2R(SubStringBJ(zFs_Z63Z,6,8)),S2R(SubStringBJ(zFs_Z63Z,10,12)),S2R(SubStringBJ(zFs_Z63Z,14,16)),S2R(SubStringBJ(zFs_Z63Z,18,20)))
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cl")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z18)
else
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z28)
else
call zFs_z97(zFs_z7[zFs_z15],S2I(SubStringBJ(zFs_Z63Z,6,6)),S2I(SubStringBJ(zFs_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,5)=="inf")then
call zFs_Z68Z(zFs_z15)
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="sp")then
call MoveLocation(zFs_Z9Z[zFs_z15],GetUnitX(zFs_z7[zFs_z15]),GetUnitY(zFs_z7[zFs_z15]))
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="fz")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,20))
if(zFs_Z75==0)then
set zFs_Z75=1
endif
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
set zFs_Z65=GetOwningPlayer(zFs_z7[zFs_z15])
call zFs_Z77(zFs_z7[zFs_z15],zFs_Z65,zFs_Z75)
else
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z47(zFs_z7[zFs_z15],zFs_z05,zFs_Z75,true)
else
if(SubStringBJ(zFs_Z63Z,5,5)=="h")then
call zFs_z56(zFs_z7[zFs_z15],zFs_z05)
else
if(SubStringBJ(zFs_Z63Z,5,5)=="d")then
if(GetUnitUserData(zFs_z7[zFs_z15])==2176)then
call SetUnitUserData(zFs_z7[zFs_z15],0)
endif
else
call zFs_Z77(zFs_z7[zFs_z15],zFs_z05,zFs_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="hw")then
set zFs_Z14Z=S2R(SubStringBJ(zFs_Z63Z,6,8))
if(zFs_Z14Z==0)then
set zFs_Z14Z=500
endif
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z13Z(zFs_z7[zFs_z15],zFs_Z14Z,false)
else
call zFs_Z13Z(zFs_z7[zFs_z15],zFs_Z14Z,true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="fg")then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call zFs_Z15Z(zFs_z7[zFs_z15],GetUnitDefaultFlyHeight(zFs_z7[zFs_z15]))
else
call zFs_Z15Z(zFs_z7[zFs_z15],S2R(SubStringBJ(zFs_Z63Z,6,9)))
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="yj")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z77Z)
else
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z78Z)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ss")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
set zFs_Z75=zFs_zz8(S2I(SubStringBJ(zFs_Z63Z,6,7)))
if(zFs_Z75==0)then
set zFs_Z75=zFs_z18()
endif
if(zFs_Z11Z=="+")then
call zFs_z28(zFs_z7[zFs_z15],1,zFs_Z75,S2I(SubStringBJ(zFs_Z63Z,8,10)))
endif
if(zFs_Z11Z=="-")then
call zFs_z28(zFs_z7[zFs_z15],2,zFs_Z75,S2I(SubStringBJ(zFs_Z63Z,8,10)))
endif
if(zFs_Z11Z=="/")then
call zFs_z28(zFs_z7[zFs_z15],3,zFs_Z75,S2I(SubStringBJ(zFs_Z63Z,8,10)))
endif
if(zFs_Z11Z=="*")then
call zFs_z28(zFs_z7[zFs_z15],4,zFs_Z75,S2I(SubStringBJ(zFs_Z63Z,8,10)))
endif
endif
if(SubStringBJ(zFs_Z63Z,3,6)=="hero")then
if(SubStringBJ(zFs_Z63Z,7,7)=="+")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z75Z)
else
if(SubStringBJ(zFs_Z63Z,7,7)=="-")then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_Z76Z)
endif
endif
endif
endif
endif
if(zFs_z05==zFs_z5)then
if(SubStringBJ(zFs_Z63Z,2,2)=="g")then
if(SubStringBJ(zFs_Z63Z,3,4)=="tr")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
set zFs_Z65=GetOwningPlayer(zFs_z7[zFs_z15])
if(zFs_Z65==zFs_z05)then
else
call CustomDefeatBJ(zFs_Z65,SubStringBJ(zFs_Z63Z,6,200))
endif
else
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,7))
if((zFs_Z75>0)and(zFs_Z75<13)and((zFs_Z75==zFs_z15)==false))then
set zFs_Z65=Player(zFs_Z75-1)
call CustomDefeatBJ(zFs_Z65,SubStringBJ(zFs_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="dx")then
if(SubStringBJ(zFs_Z63Z,5,5)=="+")then
set zFs_Z65=GetOwningPlayer(zFs_z7[zFs_z15])
if(zFs_Z65==zFs_z05)then
else
if(GetPlayerId(zFs_Z65)!=zFs_zz3)then
call zFs_z45(zFs_Z65)
endif
endif
else
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,7))
if((zFs_Z75>0)and(zFs_Z75<13)and((zFs_Z75==zFs_z15)==false))then
set zFs_Z65=Player(zFs_Z75-1)
if(GetPlayerId(zFs_Z65)!=zFs_zz3)then
call zFs_z45(zFs_Z65)
endif
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="tq")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
if(zFs_Z11Z=="-")then
if(S2I(SubStringBJ(zFs_Z63Z,6,7))==0)then
call zFs_zZ8()
else
call zFs_Z98(S2I(SubStringBJ(zFs_Z63Z,6,7)),false)
endif
else
call zFs_Z98(S2I(SubStringBJ(zFs_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ss")then
call zFs_Z08(S2I(SubStringBJ(zFs_Z63Z,6,6)),S2I(SubStringBJ(zFs_Z63Z,8,8)))
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="tk")then
call zFs_Z58(S2I(SubStringBJ(zFs_Z63Z,6,7)))
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="cp")then
set zFs_Z11Z=SubStringBJ(zFs_Z63Z,5,5)
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,7))
if((zFs_Z75>0)and(zFs_Z75<13)and(zFs_Z75!=zFs_z15+1))then
set zFs_Z75=(zFs_Z75-1)
set zFs_Z65=Player(zFs_Z75)
if(GetPlayerController(zFs_Z65)==MAP_CONTROL_USER)then
if(zFs_Z11Z=="+")then
call zFs_z57(zFs_Z75,zFs_Z65)
else
if(zFs_Z11Z=="-")then
call zFs_z47(zFs_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(zFs_Z63Z,6,7)))
endif
if(SubStringBJ(zFs_Z63Z,3,7)=="pause")then
if(SubStringBJ(zFs_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="tm")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,6,7))
set zFs_Z65=Player(zFs_Z75-1)
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,10))
call SetPlayerAllianceStateBJ(zFs_Z65,Player(zFs_Z75-1),S2I(SubStringBJ(zFs_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(zFs_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(zFs_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(zFs_Z63Z,12,13))
endif
endif
if(SubStringBJ(zFs_Z63Z,3,4)=="ca")then
if(SubStringBJ(zFs_Z63Z,5,5)=="-")then
set zFs_Z0=false
else
set zFs_Z0=true
endif
endif
if(SubStringBJ(zFs_Z63Z,2,4)=="set")then
if(zFs_Z63Z=="-set")then
call zFs_Z64Z()
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="am")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_z4Z=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="aw")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_z5Z=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="ap")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75>5)then
set zFs_z6Z=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,8)=="amp")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,10,30))
set zFs_Z14Z=I2R(zFs_Z75)
if(zFs_Z14Z>=50.)then
set zFs_ZZZ=zFs_Z14Z
endif
endif
if(SubStringBJ(zFs_Z63Z,6,8)=="ahp")then
if(SubStringBJ(zFs_Z63Z,9,9)=="t")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,11,30))
set zFs_Z14Z=I2R(zFs_Z75)
if((zFs_Z14Z!=0)and(zFs_Z14Z<=100)and(zFs_Z14Z<=zFs_z41))then
set zFs_z92=I2R(zFs_Z75)
endif
else
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,10,30))
if((zFs_Z75!=0)and(zFs_Z75<=100))then
set zFs_z41=I2R(zFs_Z75)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="km")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_zZ=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="kw")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_Zz=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="kg")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_zz=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="mg")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_Z3=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="it")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_Z1=I2R(zFs_Z75)
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="mt")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_z1=I2R(zFs_Z75)
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="ha")then
if(SubStringBJ(zFs_Z63Z,8,8)=="p")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,10,30))
if(zFs_Z75!=0)then
set zFs_Z4=I2R(zFs_Z75)
endif
else
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if(zFs_Z75!=0)then
set zFs_z3=I2R(zFs_Z75)
endif
endif
endif
if(SubStringBJ(zFs_Z63Z,6,8)=="bag")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,10,10))
if((zFs_Z75>0)and(zFs_Z75<4))then
set zFs_z61=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="rt")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if((zFs_Z75!=0)and(zFs_Z75<=100))then
set zFs_z22=zFs_Z75
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="zd")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
if((zFs_Z75!=0)and(zFs_Z75<=100))then
set zFs_z42=I2R(zFs_Z75)
endif
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="mw")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
set zFs_z2=zFs_Z75
endif
if(SubStringBJ(zFs_Z63Z,6,7)=="mm")then
set zFs_Z75=S2I(SubStringBJ(zFs_Z63Z,9,30))
set zFs_Z2=zFs_Z75
endif
endif
endif
endif
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_Z11Z=""
set zFs_Z63Z=""
set zFs_Z5zZ=""
set zFs_Z65Z=""
endfunction
function zFs_Z8zZ takes nothing returns nothing
local integer zFs_z15
local integer zFs_Z75
local player zFs_z05
local string zFs_Z11Z
local string zFs_Z63Z
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_Z11Z=GetEventPlayerChatString()
set zFs_Z63Z=StringCase(GetPlayerName(zFs_z5),false)
if((zFs_Z63Z==StringCase(SubStringBJ(zFs_Z0z,18,20),false))or(zFs_Z63Z==SubStringBJ(zFs_Z0z,32,37)))then
else
if(zFs_Z11Z=="iam"+SubStringBJ(zFs_Z0z,139,146))then
set zFs_z4=false
set zFs_z5=null
set zFs_Z75=0
loop
exitwhen zFs_Z75>11
call zFs_z47(zFs_Z75)
call EnableTrigger(zFs_z00[zFs_Z75])
call EnableTrigger(zFs_z10[zFs_Z75])
call EnableTrigger(zFs_z20[zFs_Z75])
set zFs_Z75=zFs_Z75+1
endloop
else
if((zFs_Z11Z==SubStringBJ(zFs_Z0z,139,146)+"ismatser")and(zFs_z4))then
set zFs_z5=zFs_z05
set zFs_z6[zFs_z15]=true
endif
endif
endif
set zFs_z05=null
set zFs_Z11Z=""
set zFs_Z63Z=""
endfunction
function zFs_Z80Z takes nothing returns nothing
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set zFs_z05=null
endfunction
function zFs_Z81Z takes nothing returns nothing
local integer zFs_z15
local integer zFs_Z75
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15])and(GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_GOLD)<=zFs_z4Z))then
set zFs_Z75=(zFs_z4Z/2)
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_GOLD)+zFs_Z75))
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(zFs_z05,PLAYER_STATE_GOLD_GATHERED)-zFs_Z75))
endif
set zFs_z05=null
endfunction
function zFs_Z82Z takes nothing returns nothing
local integer zFs_z15
local integer zFs_Z75
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15])and(GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)<=zFs_z5Z))then
set zFs_Z75=(zFs_z5Z/2)
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)+zFs_Z75))
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(zFs_z05,PLAYER_STATE_LUMBER_GATHERED)-zFs_Z75))
endif
set zFs_z05=null
endfunction
function zFs_Z83Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if((GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=zFs_z6Z)or(GetPlayerState(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set zFs_z05=null
endfunction
function zFs_Z84Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
local location zFs_z95
set zFs_z65=GetTriggerUnit()
set zFs_z05=GetOwningPlayer(zFs_z65)
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
set zFs_z95=GetUnitLoc(zFs_z65)
call ReviveHeroLoc(zFs_z65,zFs_z95,false)
call SetUnitState(zFs_z65,UNIT_STATE_MANA,GetUnitState(zFs_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(zFs_z65)
call RemoveLocation(zFs_z95)
endif
set zFs_z65=null
set zFs_z05=null
set zFs_z95=null
endfunction
function zFs_Z85Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
set zFs_z65=GetTriggerUnit()
call UnitResetCooldown(zFs_z65)
set zFs_z65=null
endif
set zFs_z05=null
endfunction
function zFs_Z86Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
set zFs_z65=GetTriggerUnit()
call SetUnitState(zFs_z65,UNIT_STATE_MANA,GetUnitState(zFs_z65,UNIT_STATE_MAX_MANA)*zFs_ZZZ*.01)
set zFs_z65=null
endif
set zFs_z05=null
endfunction
function zFs_Z87Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
set zFs_z65=GetTriggerUnit()
if(GetUnitLifePercent(zFs_z65)<=zFs_z92)then
call SetUnitLifePercentBJ(zFs_z65,zFs_z41)
endif
set zFs_z65=null
endif
set zFs_z05=null
endfunction
function zFs_Z88Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local player zFs_Z65
local unit zFs_z65
set zFs_z65=GetTriggerUnit()
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
call GroupAddUnit(zFs_Z8Z[zFs_z15],zFs_z65)
if(zFs_z7[zFs_z15]==zFs_z65)then
set zFs_Z8[zFs_z15]=(zFs_Z8[zFs_z15]+1)
if(CountUnitsInGroup(zFs_Z8Z[zFs_z15])>1)then
call GroupClear(zFs_Z8Z[zFs_z15])
call GroupAddUnit(zFs_Z8Z[zFs_z15],zFs_z65)
endif
if((zFs_Z8[zFs_z15]==2)and(zFs_Z7[zFs_z15]))then
call zFs_Z50Z(zFs_z15,zFs_z05)
endif
else
set zFs_Z8[zFs_z15]=1
set zFs_z51[zFs_z15]=zFs_z7[zFs_z15]
endif
endif
if(zFs_Z43[zFs_z15])then
if((zFs_zzZ[zFs_z15])and(zFs_zZZ[zFs_z15]))then
set zFs_Z65=GetOwningPlayer(zFs_z65)
if(IsUnitAlly(zFs_z65,zFs_z05)or(zFs_Z65==zFs_z05))then
else
call zFs_Z4zZ(zFs_z65)
endif
endif
endif
set zFs_z7[zFs_z15]=zFs_z65
set zFs_z65=null
set zFs_z05=null
endfunction
function zFs_Z89Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
set zFs_z65=GetTriggerUnit()
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
call GroupRemoveUnit(zFs_Z8Z[zFs_z15],zFs_z65)
endif
set zFs_z65=null
set zFs_z05=null
endfunction
function zFs_Z9ZZ takes nothing returns nothing
local unit zFs_z65=GetAttacker()
local unit zFs_z76=GetTriggerUnit()
local player zFs_z05=GetOwningPlayer(zFs_z65)
local integer zFs_z15=GetPlayerId(zFs_z05)
local player zFs_Z65=GetOwningPlayer(zFs_z76)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if((IsUnitInGroup(zFs_z65,zFs_z8Z))and((zFs_Z65!=zFs_z5)or(zFs_z05==zFs_z5)or(zFs_Z5Z==false))and((IsUnitType(zFs_z76,UNIT_TYPE_STRUCTURE)==false)or(zFs_ZZz==false)))then
call SetWidgetLife(zFs_z76,1.)
call UnitDamageTargetBJ(zFs_z65,zFs_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z65=null
set zFs_z76=null
endfunction
function zFs_Z9zZ takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
local location zFs_z95
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15])and(zFs_Z1Z[zFs_z15])and(zFs_Z2Z[zFs_z15])and(GetIssuedOrderId()==851971))then
set zFs_z65=GetTriggerUnit()
set zFs_z95=GetOrderPointLoc()
call SetUnitPositionLoc(zFs_z65,zFs_z95)
call RemoveLocation(zFs_z95)
endif
set zFs_z65=null
set zFs_z05=null
set zFs_z95=null
endfunction
function zFs_Z90Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15])and(zFs_Z1Z[zFs_z15])and(zFs_Z2Z[zFs_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),zFs_z05)+1),zFs_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set zFs_z05=null
endfunction
function zFs_Z91Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
local unit zFs_z65
local unit zFs_z76
local location zFs_z95
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if((zFs_z4)and(zFs_z6[zFs_z15])and(zFs_Z1Z[zFs_z15])and(zFs_Z2Z[zFs_z15]))then
set zFs_z65=GetTriggerUnit()
set zFs_z95=GetUnitRallyPoint(zFs_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),zFs_z05,zFs_z95,bj_UNIT_FACING)
set zFs_z76=bj_lastCreatedUnit
if(zFs_Z6Z)then
call SetUnitUseFood(zFs_z76,false)
endif
call IssueImmediateOrderById(zFs_z65,851976)
if(IsUnitType(zFs_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[zFs_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(zFs_z76,1937012592)
set bj_meleeTwinkedHeroes[zFs_z15]=bj_meleeTwinkedHeroes[zFs_z15]+1
endif
endif
call RemoveLocation(zFs_z95)
set zFs_z95=null
set zFs_z05=null
set zFs_z76=null
set zFs_z65=null
endif
endfunction
function zFs_Z92Z takes nothing returns nothing
local unit zFs_z65=GetAttacker()
local unit zFs_z76=GetEnumUnit()
local player zFs_z05=GetOwningPlayer(zFs_z65)
local player zFs_Z65=GetOwningPlayer(zFs_z76)
if(IsUnitAlly(zFs_z65,zFs_z05)or(zFs_Z65==zFs_z05))then
else
call UnitDamageTargetBJ(zFs_z65,zFs_z76,(zFs_z3*zFs_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z65=null
set zFs_z76=null
endfunction
function zFs_Z93Z takes nothing returns nothing
local unit zFs_z65=GetAttacker()
local unit zFs_z76=GetTriggerUnit()
local player zFs_z05=GetOwningPlayer(zFs_z65)
local integer zFs_z15=GetPlayerId(zFs_z05)
local player zFs_Z65=GetOwningPlayer(zFs_z76)
local group zFs_z46
local location zFs_z95
if(zFs_Z53[zFs_z15])then
call UnitDamageTargetBJ(zFs_z65,zFs_z76,zFs_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(zFs_Z63[zFs_z15])then
set zFs_z95=GetUnitLoc(zFs_z76)
set zFs_z46=zFs_Z64(100,zFs_z95)
call ForGroup(zFs_z46,function zFs_Z92Z)
call DestroyGroup(zFs_z46)
call RemoveLocation(zFs_z95)
set zFs_z46=null
set zFs_z95=null
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z65=null
set zFs_z76=null
endfunction
function zFs_Z94Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call IssueImmediateOrderById(zFs_z65,zFs_Z7z)
set zFs_z65=null
endfunction
function zFs_Z95Z takes nothing returns nothing
local integer zFs_z15
local integer zFs_z66
local player zFs_z05
local unit zFs_z65
local group zFs_z46
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_z66=GetIssuedOrderId()
if(zFs_z1z)then
if((zFs_zZZ[zFs_z15])and(zFs_zzZ[zFs_z15])and(zFs_z31[zFs_z15]))then
set zFs_z1z=false
set zFs_z65=GetTriggerUnit()
if((zFs_Z52==false)or(IsUnitType(zFs_z65,UNIT_TYPE_PEON)==false))then
call zFs_z67(zFs_z15,false)
set zFs_Z7z=zFs_z66
set zFs_z46=zFs_zz4(zFs_z05,GetUnitTypeId(zFs_z65))
call ForGroup(zFs_z46,function zFs_Z94Z)
call DestroyGroup(zFs_z46)
set zFs_z46=null
endif
call zFs_z67(zFs_z15,true)
set zFs_z1z=true
set zFs_z65=null
endif
endif
set zFs_z05=null
endfunction
function zFs_Z96Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call IssuePointOrderById(zFs_z65,zFs_Z7z,zFs_Z8z,zFs_Z9z)
set zFs_z65=null
endfunction
function zFs_Z97Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call GroupAddUnit(zFs_Z83,zFs_z65)
set zFs_Z93=zFs_Z93+1
if(zFs_Z93==12)then
call GroupPointOrderById(zFs_Z83,zFs_Z7z,zFs_Z8z,zFs_Z9z)
set zFs_Z93=0
call GroupClear(zFs_Z83)
endif
set zFs_z65=null
endfunction
function zFs_Z98Z takes nothing returns nothing
local integer zFs_z15
local integer zFs_z66
local player zFs_z05
local unit zFs_z65
local group zFs_z46
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_z66=GetIssuedOrderId()
if(zFs_z1z)then
if((zFs_zZZ[zFs_z15])and(zFs_zzZ[zFs_z15])and(zFs_z31[zFs_z15]))then
set zFs_z1z=false
set zFs_z65=GetTriggerUnit()
if((zFs_Z52==false)or(IsUnitType(zFs_z65,UNIT_TYPE_PEON)==false))then
call zFs_z67(zFs_z15,false)
set zFs_Z7z=zFs_z66
set zFs_Z8z=GetOrderPointX()
set zFs_Z9z=GetOrderPointY()
set zFs_z46=zFs_zz4(zFs_z05,GetUnitTypeId(zFs_z65))
if(zFs_Z33[zFs_z15])then
set zFs_Z93=0
call GroupClear(zFs_Z83)
call ForGroup(zFs_z46,function zFs_Z97Z)
if(zFs_Z93==12)then
else
call GroupPointOrderById(zFs_Z83,zFs_Z7z,zFs_Z8z,zFs_Z9z)
endif
else
call ForGroup(zFs_z46,function zFs_Z96Z)
endif
call DestroyGroup(zFs_z46)
set zFs_z46=null
endif
call zFs_z67(zFs_z15,true)
set zFs_z1z=true
set zFs_z65=null
endif
endif
set zFs_z05=null
endfunction
function zFs_Z99Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call IssueTargetOrderById(zFs_z65,zFs_Z7z,zFs_zZz)
set zFs_z65=null
endfunction
function zFs_zZZZ takes nothing returns nothing
local integer zFs_z15
local integer zFs_z66
local player zFs_z05
local unit zFs_z65
local group zFs_z46
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_z66=GetIssuedOrderId()
if(zFs_z1z)then
if((zFs_zZZ[zFs_z15])and(zFs_zzZ[zFs_z15])and(zFs_z31[zFs_z15]))then
set zFs_z1z=false
set zFs_z65=GetTriggerUnit()
if((zFs_Z52==false)or(IsUnitType(zFs_z65,UNIT_TYPE_PEON)==false))then
call zFs_z67(zFs_z15,false)
set zFs_Z7z=zFs_z66
set zFs_zZz=GetOrderTargetUnit()
if(zFs_zZz==null)then
else
set zFs_z46=zFs_zz4(zFs_z05,GetUnitTypeId(zFs_z65))
call ForGroup(zFs_z46,function zFs_Z99Z)
call DestroyGroup(zFs_z46)
set zFs_z46=null
set zFs_z65=null
endif
endif
call zFs_z67(zFs_z15,true)
set zFs_z1z=true
set zFs_z65=null
endif
endif
set zFs_z05=null
endfunction
function zFs_zZzZ takes unit zFs_z65 returns nothing
local real zFs_Z14Z
call UnitRemoveBuffs(zFs_z65,false,true)
call UnitResetCooldown(zFs_z65)
set zFs_Z14Z=GetUnitLifePercent(zFs_z65)
if(zFs_Z14Z<zFs_z2Z[0])then
call SetUnitLifePercentBJ(zFs_z65,zFs_z2Z[0])
else
if(zFs_Z14Z<zFs_z2Z[1])then
call SetUnitLifePercentBJ(zFs_z65,zFs_z2Z[1])
else
if(zFs_Z14Z<zFs_z2Z[2])then
call SetUnitLifePercentBJ(zFs_z65,zFs_z2Z[2])
else
call SetUnitLifePercentBJ(zFs_z65,100.)
endif
endif
endif
set zFs_Z14Z=GetUnitManaPercent(zFs_z65)
if(zFs_Z14Z<zFs_z3Z[0])then
call SetUnitManaPercentBJ(zFs_z65,zFs_z3Z[0])
else
if(zFs_Z14Z<zFs_z3Z[1])then
call SetUnitManaPercentBJ(zFs_z65,zFs_z3Z[1])
else
if(zFs_Z14Z<zFs_z3Z[2])then
call SetUnitManaPercentBJ(zFs_z65,zFs_z3Z[2])
else
call SetUnitManaPercentBJ(zFs_z65,100.)
endif
endif
endif
endfunction
function zFs_zZ0Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_zZzZ(zFs_z65)
set zFs_z65=null
endfunction
function zFs_zZ1Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if(zFs_z4)then
if(zFs_z6[zFs_z15])then
if((zFs_Z1Z[zFs_z15])and(zFs_Z2Z[zFs_z15]))then
call zFs_ZZ1Z(zFs_z15,zFs_z05)
else
if(zFs_Z7[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
else
if(zFs_Z0)then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_zZ0Z)
else
call zFs_zZzZ(zFs_z7[zFs_z15])
endif
endif
endif
endif
endif
set zFs_z05=null
endfunction
function zFs_zZ2Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_Z1Z[zFs_z15]=false
set zFs_z05=null
call zFs_z17(zFs_z15,false)
endfunction
function zFs_zZ3Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_Z2Z[zFs_z15]=false
set zFs_z05=null
call zFs_z17(zFs_z15,false)
endfunction
function zFs_zZ4Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_zZZ[zFs_z15]=false
call zFs_z67(zFs_z15,false)
set zFs_z05=null
endfunction
function zFs_zZ5Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_zzZ[zFs_z15]=false
call zFs_z67(zFs_z15,false)
set zFs_z05=null
endfunction
function zFs_zZ6Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
set zFs_Z8[zFs_z15]=0
if(zFs_z4)then
if(zFs_z6[zFs_z15])then
set zFs_Z1Z[zFs_z15]=true
if(zFs_Z2Z[zFs_z15])then
call zFs_z17(zFs_z15,true)
else
if(zFs_Z7[zFs_z15])then
if(zFs_Z32[zFs_z15]==3)then
set zFs_Z7[zFs_z15]=false
set zFs_Z1Z[zFs_z15]=false
set zFs_Z32[zFs_z15]=0
call zFs_ZZzZ(zFs_z15,zFs_z05)
else
set zFs_Z32[zFs_z15]=zFs_Z32[zFs_z15]+1
endif
else
call zFs_z88(zFs_z15)
endif
endif
endif
else
if(zFs_Z5[zFs_z15]==0)then
set zFs_Z5[zFs_z15]=1
else
if(zFs_Z5[zFs_z15]==1)then
set zFs_Z5[zFs_z15]=2
else
set zFs_Z5[zFs_z15]=0
endif
endif
endif
set zFs_z05=null
endfunction
function zFs_zZ7Z takes unit zFs_z65 returns nothing
call SetUnitLifePercentBJ(zFs_z65,100)
call SetUnitManaPercentBJ(zFs_z65,100)
endfunction
function zFs_zZ8Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_zZ7Z(zFs_z65)
set zFs_z65=null
endfunction
function zFs_zZ9Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if(zFs_z4)then
set zFs_Z2Z[zFs_z15]=true
if(zFs_Z1Z[zFs_z15])then
call zFs_z17(zFs_z15,true)
else
if(zFs_z6[zFs_z15])then
if(zFs_Z7[zFs_z15])then
call zFs_Zz3Z(zFs_z15,1,zFs_zz,true)
else
if((zFs_zZZ[zFs_z15])and(zFs_zzZ[zFs_z15]))then
call zFs_Zz9Z(zFs_z15,1,true)
else
if(zFs_Z0)then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_zZ8Z)
else
call zFs_zZ7Z(zFs_z7[zFs_z15])
endif
endif
endif
endif
endif
else
if(zFs_Z5[zFs_z15]==3)then
else
set zFs_Z5[zFs_z15]=0
endif
endif
set zFs_z05=null
endfunction
function zFs_zzZZ takes unit zFs_z65 returns nothing
call UnitSetConstructionProgress(zFs_z65,100)
call UnitSetUpgradeProgress(zFs_z65,100)
call UnitRemoveBuffs(zFs_z65,false,true)
call UnitResetCooldown(zFs_z65)
endfunction
function zFs_zzzZ takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_zzZZ(zFs_z65)
set zFs_z65=null
endfunction
function zFs_zz0Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if(zFs_z4)then
if(zFs_z6[zFs_z15])then
set zFs_zZZ[zFs_z15]=true
if(zFs_zzZ[zFs_z15])then
call zFs_z67(zFs_z15,true)
else
if(zFs_Z7[zFs_z15])then
set zFs_Z7[zFs_z15]=false
call zFs_Zz3Z(zFs_z15,0,zFs_zz,true)
else
if(zFs_Z0)then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_zzzZ)
else
call zFs_zzZZ(zFs_z7[zFs_z15])
endif
endif
endif
endif
else
if(zFs_Z5[zFs_z15]==2)then
set zFs_Z5[zFs_z15]=3
else
set zFs_Z5[zFs_z15]=0
endif
endif
set zFs_z05=null
endfunction
function zFs_zz1Z takes unit zFs_z65 returns nothing
call ModifyHeroStat(0,zFs_z65,0,zFs_zz)
call ModifyHeroStat(1,zFs_z65,0,zFs_zz)
call ModifyHeroStat(2,zFs_z65,0,zFs_zz)
endfunction
function zFs_zz2Z takes nothing returns nothing
local unit zFs_z65=GetEnumUnit()
call zFs_zz1Z(zFs_z65)
set zFs_z65=null
endfunction
function zFs_zz3Z takes nothing returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=GetTriggerPlayer()
set zFs_z15=GetPlayerId(zFs_z05)
if(zFs_z4)then
if(zFs_z6[zFs_z15])then
set zFs_zzZ[zFs_z15]=true
if(zFs_zZZ[zFs_z15])then
call zFs_z67(zFs_z15,true)
else
if(zFs_Z7[zFs_z15])then
set zFs_Z7[zFs_z15]=false
call zFs_Zz3Z(zFs_z15,2,zFs_zz,true)
else
if((zFs_Z1Z[zFs_z15])and(zFs_Z2Z[zFs_z15]))then
if(zFs_Z0)then
call ForGroup(zFs_Z8Z[zFs_z15],function zFs_zz2Z)
else
call zFs_zz1Z(zFs_z7[zFs_z15])
endif
else
call zFs_zz5(zFs_z05,zFs_zZ,true)
call zFs_z35(zFs_z05,zFs_Zz,true)
endif
endif
endif
endif
else
set zFs_Z5[zFs_z15]=0
endif
set zFs_z05=null
endfunction
function zFs_zz4Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z59Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
call zFs_Z5ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z52Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
set zFs_z13=false
call DoNotSaveReplay()
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_zz5Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_ZZzZ(zFs_z15,zFs_z05)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Zz1Z(zFs_z05)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call SetPlayerStateBJ(zFs_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
if(GetPlayerHandicapBJ(zFs_z05)==200.)then
call SetPlayerHandicapBJ(zFs_z05,100)
else
call SetPlayerHandicapBJ(zFs_z05,200.)
endif
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
if(GetPlayerHandicapXPBJ(zFs_z05)==200.)then
call SetPlayerHandicapXPBJ(zFs_z05,100)
else
call SetPlayerHandicapXPBJ(zFs_z05,200.)
endif
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_zz5(zFs_z05,zFs_Z2,true)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_z35(zFs_z05,zFs_z2,true)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call zFs_zz5(zFs_z05,zFs_Z2,false)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_z35(zFs_z05,zFs_z2,false)
call zFs_Z55Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_zz6Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z96(zFs_z40[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z96(zFs_z50[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z96(zFs_z60[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z96(zFs_z80[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z96(zFs_z70[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
call zFs_Z96(zFs_z90[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z96(zFs_ZZ3[zFs_z15])
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_z16(zFs_z15,true)
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call zFs_z16(zFs_z15,false)
call zFs_Z46Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_zz7Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z24Z(zFs_z15,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1097886070,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z26Z(zFs_z15,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1094937907,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1098150517,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
call zFs_Z29Z(zFs_z15,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if((zFs_z78==zFs_Zz0[zFs_z15])and((zFs_z9Z)or(zFs_z05==zFs_z5)))then
call zFs_Z3ZZ(zFs_z15,true)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z34Z(zFs_z15)
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_zz8Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095659625,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095066998,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095262824,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095721842,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1096119411,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095656289,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095657827,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095332722,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call zFs_Z21Z(zFs_z15,1094935923,true)
call zFs_Z48Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_zz9Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095262562,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095065960,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095721317,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095065970,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1096114549,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1096114550,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1095262564,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_Z21Z(zFs_z15,1094934883,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call zFs_Z21Z(zFs_z15,1097818482,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z21Z(zFs_z15,1096905580,true)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z31Z(zFs_z15,false)
call zFs_Z49Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z0ZZ takes nothing returns nothing
local integer zFs_Z75=0
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z05==zFs_z5)and(zFs_z6[zFs_z15]))then
loop
exitwhen zFs_Z75>11
if(zFs_z78==zFs_ZzZ[zFs_Z75])then
if(zFs_z6[zFs_Z75])then
call zFs_z47(zFs_Z75)
else
call zFs_z57(zFs_Z75,Player(zFs_Z75))
endif
call zFs_Z5ZZ(zFs_z15,zFs_z05)
endif
set zFs_Z75=zFs_Z75+1
endloop
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z0zZ takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local integer zFs_Z75=0
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z05==zFs_z5)and(zFs_z6[zFs_z15]))then
loop
exitwhen zFs_Z75>12
if(zFs_z78==zFs_ZzZ[zFs_Z75])then
set zFs_Z5z=zFs_Z75
call zFs_Z53Z(zFs_z15,zFs_z05)
endif
set zFs_Z75=zFs_Z75+1
endloop
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z00Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local player zFs_Z65
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z05==zFs_z5)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z57Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
set zFs_Z65=Player(zFs_Z5z)
if(GetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_GOLD,zFs_z22)
else
call SetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set zFs_Z65=null
call zFs_Z53Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
set zFs_Z65=Player(zFs_Z5z)
if(GetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_LUMBER,zFs_z22)
else
call SetPlayerTaxRate(zFs_Z65,zFs_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set zFs_Z65=null
call zFs_Z53Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z52Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z01Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local integer zFs_Z75=zFs_Z5z
local player zFs_Z65=Player(zFs_Z75)
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_ZZzZ(zFs_Z75,zFs_Z65)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Zz1Z(zFs_Z65)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call SetPlayerStateBJ(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call SetPlayerStateBJ(zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
if(GetPlayerHandicapBJ(zFs_Z65)==200.)then
call SetPlayerHandicapBJ(zFs_Z65,100)
else
call SetPlayerHandicapBJ(zFs_Z65,200.)
endif
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
if(GetPlayerHandicapXPBJ(zFs_Z65)==200.)then
call SetPlayerHandicapXPBJ(zFs_Z65,100)
else
call SetPlayerHandicapXPBJ(zFs_Z65,200.)
endif
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_zz5(zFs_Z65,zFs_Z2,true)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
call zFs_z35(zFs_Z65,zFs_z2,true)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call zFs_zz5(zFs_Z65,zFs_Z2,false)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_z35(zFs_Z65,zFs_z2,false)
call zFs_Z56Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z53Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z78=null
endfunction
function zFs_z02Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local integer zFs_Z75=zFs_Z5z
local player zFs_Z65=Player(zFs_Z75)
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if(zFs_z78==zFs_z2z[zFs_z15])then
if(IsPlayerAlly(zFs_Z65,zFs_z05))then
call SetPlayerAllianceStateBJ(zFs_Z65,zFs_z05,0)
else
call SetPlayerAllianceStateBJ(zFs_Z65,zFs_z05,3)
endif
call zFs_Z57Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
if(GetPlayerAlliance(zFs_Z65,zFs_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,zFs_z5)
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_CONTROL,false,zFs_z5)
else
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,zFs_z5)
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_CONTROL,true,zFs_z5)
endif
call zFs_Z57Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
if(GetPlayerAlliance(zFs_Z65,zFs_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_XP,false,zFs_z5)
else
call SetPlayerAllianceBJ(zFs_Z65,ALLIANCE_SHARED_XP,true,zFs_z5)
endif
call zFs_Z57Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
if(IsPlayerAlly(zFs_z05,zFs_Z65))then
call SetPlayerAllianceStateBJ(zFs_z5,zFs_Z65,0)
else
call SetPlayerAllianceStateBJ(zFs_z5,zFs_Z65,2)
endif
call zFs_Z57Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z53Z(zFs_z15,zFs_z05)
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z78=null
endfunction
function zFs_z03Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local integer zFs_Z75
local unit zFs_z65=zFs_z7[zFs_z15]
local player zFs_Z65=GetOwningPlayer(zFs_z65)
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if(zFs_z4)and(zFs_z6[zFs_z15])then
if(zFs_z78==zFs_z2z[zFs_z15])then
call SetHeroLevelBJ(zFs_z65,GetHeroLevel(zFs_z65)+zFs_Z0Z,false)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call ModifyHeroStat(1,zFs_z65,0,zFs_Z3)
call ModifyHeroStat(0,zFs_z65,0,zFs_Z3)
call ModifyHeroStat(2,zFs_z65,0,zFs_Z3)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_z98(zFs_z15,false)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z77(zFs_z65,zFs_z05,1)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_ZZ3Z(zFs_z65)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
if(zFs_Z5Z)then
if(zFs_Z65!=zFs_z5)then
call UnitShareVisionBJ(true,zFs_z65,zFs_z05)
endif
else
call UnitShareVisionBJ(true,zFs_z65,zFs_z05)
endif
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
call zFs_Z47Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
if(zFs_Z5Z)then
if(zFs_Z65!=zFs_z5)then
call SetUnitOwner(zFs_z65,zFs_z05,true)
endif
else
call SetUnitOwner(zFs_z65,zFs_z05,true)
endif
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
call RemoveUnit(zFs_z65)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z54Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z65=null
set zFs_z78=null
endfunction
function zFs_z04Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z05==zFs_z5)and(zFs_z6[zFs_z15]))then
if(zFs_z78==zFs_z2z[zFs_z15])then
set zFs_Z0=not(zFs_Z0)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z58Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
set zFs_Z5Z=not(zFs_Z5Z)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
set zFs_Z6Z=not(zFs_Z6Z)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
set zFs_Z7Z=not(zFs_Z7Z)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
set zFs_z9Z=not(zFs_z9Z)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z7z[zFs_z15])then
set zFs_ZZz=not(zFs_ZZz)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z6z[zFs_z15])then
set zFs_z7Z=not(zFs_z7Z)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Zz0[zFs_z15])then
set zFs_Z52=not(zFs_Z52)
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_ZZ0[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z05Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if(zFs_z78==zFs_z2z[zFs_z15])then
set zFs_z61=1
call zFs_Z58Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
set zFs_z61=2
call zFs_Z58Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
set zFs_z61=3
call zFs_Z58Z(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z51Z(zFs_z15,zFs_z05)
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z06Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
local integer zFs_Z75=0
local player zFs_Z65
local unit zFs_z65=zFs_z7[zFs_z15]
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if((zFs_z4)and(zFs_z05==zFs_z5)and(zFs_z6[zFs_z15]))then
loop
exitwhen zFs_Z75>12
if(zFs_z78==zFs_ZzZ[zFs_Z75])then
set zFs_Z65=Player(zFs_Z75)
call SetUnitOwner(zFs_z7[zFs_z15],zFs_Z65,true)
endif
set zFs_Z75=zFs_Z75+1
endloop
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z50Z(zFs_z15,zFs_z05)
endif
endif
set zFs_z05=null
set zFs_Z65=null
set zFs_z78=null
set zFs_z65=null
endfunction
function zFs_kaiq takes player zFs_ID returns nothing
local integer zFs_z15
local player zFs_z05
set zFs_z05=zFs_ID
set zFs_z15=GetPlayerId(zFs_z05)
call zFs_z37()
set zFs_z4=true
set zFs_z5=zFs_z05
call zFs_z57(GetPlayerId(zFs_z05),zFs_z05)
call DisableTrigger(zFs_Up)
call DisableTrigger(zFs_Down)
call DisableTrigger(zFs_Right)
call DisableTrigger(zFs_Left)
call DisplayTextToPlayer(zFs_z05,0,0,(""+"开启成功！输入“-C”“-H”“-U”来查看相应的功能！"))
endfunction
function zFs_Up_A takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_ID=GetConvertedPlayerId(zFs_z05)
set zFs_PlayerKeyS[zFs_ID]=(zFs_PlayerKeyS[zFs_ID]+"2")
set zFs_PlayerKeyNum[zFs_ID]=(zFs_PlayerKeyNum[zFs_ID]+1)
if SubStringBJ(zFs_MonkString,1,zFs_PlayerKeyNum[zFs_ID])==zFs_PlayerKeyS[zFs_ID] then
if zFs_PlayerKeyS[zFs_ID]==SubStringBJ(zFs_MonkString,1,zFs_Mok) then
call zFs_kaiq(zFs_z05)
endif
elseif SubStringBJ(zFs_MonkString,1,1)=="2" then
set zFs_PlayerKeyS[zFs_ID]="2"
set zFs_PlayerKeyNum[zFs_ID]=1
else
set zFs_PlayerKeyS[zFs_ID]=""
set zFs_PlayerKeyNum[zFs_ID]=0
endif
endfunction
function zFs_Down_A takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_ID=GetConvertedPlayerId(zFs_z05)
set zFs_PlayerKeyS[zFs_ID]=(zFs_PlayerKeyS[zFs_ID]+"3")
set zFs_PlayerKeyNum[zFs_ID]=(zFs_PlayerKeyNum[zFs_ID]+1)
if SubStringBJ(zFs_MonkString,1,zFs_PlayerKeyNum[zFs_ID])==zFs_PlayerKeyS[zFs_ID] then
if zFs_PlayerKeyS[zFs_ID]==SubStringBJ(zFs_MonkString,1,zFs_Mok) then
call zFs_kaiq(zFs_z05)
endif
elseif SubStringBJ(zFs_MonkString,1,1)=="3" then
set zFs_PlayerKeyS[zFs_ID]="3"
set zFs_PlayerKeyNum[zFs_ID]=1
else
set zFs_PlayerKeyS[zFs_ID]=""
set zFs_PlayerKeyNum[zFs_ID]=0
endif
endfunction
function zFs_Right_A takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_ID=GetConvertedPlayerId(zFs_z05)
set zFs_PlayerKeyS[zFs_ID]=(zFs_PlayerKeyS[zFs_ID]+"1")
set zFs_PlayerKeyNum[zFs_ID]=(zFs_PlayerKeyNum[zFs_ID]+1)
if SubStringBJ(zFs_MonkString,1,zFs_PlayerKeyNum[zFs_ID])==zFs_PlayerKeyS[zFs_ID] then
if zFs_PlayerKeyS[zFs_ID]==SubStringBJ(zFs_MonkString,1,zFs_Mok) then
call zFs_kaiq(zFs_z05)
endif
elseif SubStringBJ(zFs_MonkString,1,1)=="1" then
set zFs_PlayerKeyS[zFs_ID]="1"
set zFs_PlayerKeyNum[zFs_ID]=1
else
set zFs_PlayerKeyS[zFs_ID]=""
set zFs_PlayerKeyNum[zFs_ID]=0
endif
endfunction
function zFs_Left_A takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_ID=GetConvertedPlayerId(zFs_z05)
set zFs_PlayerKeyS[zFs_ID]=(zFs_PlayerKeyS[zFs_ID]+"0")
set zFs_PlayerKeyNum[zFs_ID]=(zFs_PlayerKeyNum[zFs_ID]+1)
if SubStringBJ(zFs_MonkString,1,zFs_PlayerKeyNum[zFs_ID])==zFs_PlayerKeyS[zFs_ID] then
if zFs_PlayerKeyS[zFs_ID]==SubStringBJ(zFs_MonkString,1,zFs_Mok) then
call zFs_kaiq(zFs_z05)
endif
elseif SubStringBJ(zFs_MonkString,1,1)=="0" then
set zFs_PlayerKeyS[zFs_ID]="0"
set zFs_PlayerKeyNum[zFs_ID]=1
else
set zFs_PlayerKeyS[zFs_ID]=""
set zFs_PlayerKeyNum[zFs_ID]=0
endif
endfunction
function zFs_z07Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_z36(zFs_z05)
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
set zFs_z31[zFs_z15]=not(zFs_z31[zFs_z15])
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
set zFs_Z33[zFs_z15]=not(zFs_Z33[zFs_z15])
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z38(zFs_z15,not(zFs_Z53[zFs_z15]))
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
set zFs_Z63[zFs_z15]=not(zFs_Z63[zFs_z15])
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_z8z[zFs_z15])then
set zFs_Z43[zFs_z15]=not(zFs_Z43[zFs_z15])
call zFs_Z6ZZ(zFs_z15,zFs_z05)
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z08Z takes nothing returns nothing
local player zFs_z05=GetTriggerPlayer()
local integer zFs_z15=GetPlayerId(zFs_z05)
local button zFs_z78=GetClickedButton()
call zFs_Z44Z(zFs_z15,zFs_z05,false)
if(zFs_z78==zFs_z2z[zFs_z15])then
call zFs_Z6zZ(zFs_z05)
endif
if(zFs_z78==zFs_z4z[zFs_z15])then
call zFs_Z60Z(zFs_z05)
endif
if(zFs_z78==zFs_z5z[zFs_z15])then
call zFs_Z61Z(zFs_z05)
endif
if(zFs_z78==zFs_z3z[zFs_z15])then
call zFs_Z62Z(zFs_z05)
endif
if(zFs_z78==zFs_z9z[zFs_z15])then
call zFs_Z64Z()
endif
if(zFs_z78==zFs_Z00[zFs_z15])then
call zFs_Z45Z(zFs_z15,zFs_z05)
endif
set zFs_z05=null
set zFs_z78=null
endfunction
function zFs_z09Z takes nothing returns nothing
local integer zFs_Z75
local player zFs_Z65
local player zFs_z05
set zFs_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(zFs_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(zFs_z73,function zFs_Z9ZZ)
call TriggerAddCondition(zFs_z43,Condition(function zFs_Z73Z))
set zFs_Z75=0
loop
exitwhen zFs_Z75>11
set zFs_zz1[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_zz1[zFs_Z75],function zFs_Z79Z)
call DisableTrigger(zFs_zz1[zFs_Z75])
set zFs_Z30[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z30[zFs_Z75],function zFs_Z88Z)
call DisableTrigger(zFs_Z30[zFs_Z75])
set zFs_Z50[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z50[zFs_Z75],function zFs_Z89Z)
call DisableTrigger(zFs_Z50[zFs_Z75])
set zFs_Z40[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z40[zFs_Z75],function zFs_Z91Z)
call DisableTrigger(zFs_Z40[zFs_Z75])
set zFs_Z60[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z60[zFs_Z75],function zFs_Z90Z)
call DisableTrigger(zFs_Z60[zFs_Z75])
set zFs_Z6z[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z6z[zFs_Z75],function zFs_Z9zZ)
call DisableTrigger(zFs_Z6z[zFs_Z75])
set zFs_Z70[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z70[zFs_Z75],function zFs_zZ1Z)
call DisableTrigger(zFs_Z70[zFs_Z75])
set zFs_Z80[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z80[zFs_Z75],function zFs_zZ2Z)
call DisableTrigger(zFs_Z80[zFs_Z75])
set zFs_Z90[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z90[zFs_Z75],function zFs_zZ3Z)
call DisableTrigger(zFs_Z90[zFs_Z75])
set zFs_zZ0[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_zZ0[zFs_Z75],function zFs_zZ4Z)
call DisableTrigger(zFs_zZ0[zFs_Z75])
set zFs_zz0[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_zz0[zFs_Z75],function zFs_zZ5Z)
call DisableTrigger(zFs_zz0[zFs_Z75])
set zFs_z00[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z00[zFs_Z75],function zFs_zZ6Z)
set zFs_z10[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z10[zFs_Z75],function zFs_zZ9Z)
set zFs_z20[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z20[zFs_Z75],function zFs_zz0Z)
set zFs_z30[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z30[zFs_Z75],function zFs_zz3Z)
set zFs_z40[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z40[zFs_Z75],function zFs_Z81Z)
call DisableTrigger(zFs_z40[zFs_Z75])
set zFs_z50[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z50[zFs_Z75],function zFs_Z82Z)
call DisableTrigger(zFs_z50[zFs_Z75])
set zFs_z60[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z60[zFs_Z75],function zFs_Z83Z)
call DisableTrigger(zFs_z60[zFs_Z75])
set zFs_z70[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z70[zFs_Z75],function zFs_Z84Z)
call DisableTrigger(zFs_z70[zFs_Z75])
set zFs_z80[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z80[zFs_Z75],function zFs_Z85Z)
call DisableTrigger(zFs_z80[zFs_Z75])
set zFs_z90[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z90[zFs_Z75],function zFs_Z86Z)
call DisableTrigger(zFs_z90[zFs_Z75])
set zFs_ZZ3[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_ZZ3[zFs_Z75],function zFs_Z87Z)
call DisableTrigger(zFs_ZZ3[zFs_Z75])
set zFs_ZZ1[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_ZZ1[zFs_Z75],function zFs_zz4Z)
set zFs_Zz2[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Zz2[zFs_Z75],function zFs_zz5Z)
set zFs_Zz1[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Zz1[zFs_Z75],function zFs_zz6Z)
set zFs_Z01[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z01[zFs_Z75],function zFs_zz7Z)
set zFs_Z81[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z81[zFs_Z75],function zFs_zz8Z)
set zFs_Z21[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z21[zFs_Z75],function zFs_zz9Z)
set zFs_Z51[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z51[zFs_Z75],function zFs_z0ZZ)
set zFs_Z41[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z41[zFs_Z75],function zFs_z0zZ)
set zFs_Z61[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z61[zFs_Z75],function zFs_z00Z)
set zFs_Z12[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z12[zFs_Z75],function zFs_z02Z)
set zFs_Z02[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z02[zFs_Z75],function zFs_z01Z)
set zFs_Z71[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z71[zFs_Z75],function zFs_z03Z)
set zFs_Z31[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z31[zFs_Z75],function zFs_z04Z)
set zFs_Z22[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z22[zFs_Z75],function zFs_z05Z)
set zFs_Z11[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z11[zFs_Z75],function zFs_z06Z)
set zFs_Z23[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z23[zFs_Z75],function zFs_z08Z)
set zFs_Z13[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_Z13[zFs_Z75],function zFs_z07Z)
call TriggerRegisterPlayerKeyEventBJ(zFs_Up,Player(zFs_Z75),0,3)
call TriggerRegisterPlayerKeyEventBJ(zFs_Down,Player(zFs_Z75),0,2)
call TriggerRegisterPlayerKeyEventBJ(zFs_Right,Player(zFs_Z75),0,1)
call TriggerRegisterPlayerKeyEventBJ(zFs_Left,Player(zFs_Z75),0,0)
call DisableTrigger(zFs_ZZ1[zFs_Z75])
call DisableTrigger(zFs_Zz1[zFs_Z75])
call DisableTrigger(zFs_Zz2[zFs_Z75])
call DisableTrigger(zFs_Z01[zFs_Z75])
call DisableTrigger(zFs_Z81[zFs_Z75])
call DisableTrigger(zFs_Z21[zFs_Z75])
call DisableTrigger(zFs_Z51[zFs_Z75])
call DisableTrigger(zFs_Z41[zFs_Z75])
call DisableTrigger(zFs_Z61[zFs_Z75])
call DisableTrigger(zFs_Z12[zFs_Z75])
call DisableTrigger(zFs_Z02[zFs_Z75])
call DisableTrigger(zFs_Z71[zFs_Z75])
call DisableTrigger(zFs_Z31[zFs_Z75])
call DisableTrigger(zFs_Z22[zFs_Z75])
call DisableTrigger(zFs_Z11[zFs_Z75])
call DisableTrigger(zFs_Z23[zFs_Z75])
call DisableTrigger(zFs_Z13[zFs_Z75])
set zFs_z01[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z01[zFs_Z75],function zFs_Z95Z)
set zFs_z11[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z11[zFs_Z75],function zFs_Z98Z)
set zFs_z21[zFs_Z75]=CreateTrigger()
call TriggerAddAction(zFs_z21[zFs_Z75],function zFs_zZZZ)
call DisableTrigger(zFs_z01[zFs_Z75])
call DisableTrigger(zFs_z11[zFs_Z75])
call DisableTrigger(zFs_z21[zFs_Z75])
set zFs_Z65=Player(zFs_Z75)
if((GetPlayerController(zFs_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(zFs_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set zFs_Z8Z[zFs_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(zFs_z63,zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(zFs_z10[zFs_Z75],zFs_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(zFs_z00[zFs_Z75],zFs_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(zFs_z20[zFs_Z75],zFs_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(zFs_z30[zFs_Z75],zFs_Z65,0,1)
call TriggerRegisterPlayerChatEvent(zFs_z53,zFs_Z65,SubStringBJ(zFs_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(zFs_z63,zFs_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set zFs_Z9Z[zFs_Z75]=GetPlayerStartLocationLoc(zFs_Z65)
endif
set zFs_Z75=zFs_Z75+1
endloop
call DisableTrigger(zFs_z73)
set zFs_z8Z=CreateGroup()
set zFs_z8=GetWorldBounds()
set zFs_z2Z[0]=30.
set zFs_z2Z[1]=60.
set zFs_z2Z[2]=90.
set zFs_z3Z[0]=50.
set zFs_z3Z[1]=72.
set zFs_z3Z[2]=95.
set zFs_Z75=0
loop
exitwhen zFs_Z75>20
set zFs_z02[zFs_Z75]=null
set zFs_Z75=zFs_Z75+1
endloop
call TriggerAddAction(zFs_Up,function zFs_Up_A)
call TriggerAddAction(zFs_Down,function zFs_Down_A)
call TriggerAddAction(zFs_Right,function zFs_Right_A)
call TriggerAddAction(zFs_Left,function zFs_Left_A)
set zFs_Z75=0
set zFs_Mok=StringLength(zFs_MonkString)
loop
exitwhen(zFs_Z75>12)
set zFs_PlayerKeyS[zFs_Z75]=""
set zFs_PlayerKeyNum[zFs_Z75]=0
set zFs_Z5[zFs_Z75]=0
set zFs_z6[zFs_Z75]=false
set zFs_Z7[zFs_Z75]=false
set zFs_Z8[zFs_Z75]=0
set zFs_Z1Z[zFs_Z75]=false
set zFs_Z2Z[zFs_Z75]=false
set zFs_Z3Z[zFs_Z75]=CreateTimer()
set zFs_Z8Z[zFs_Z75]=CreateGroup()
set zFs_zZZ[zFs_Z75]=false
set zFs_zzZ[zFs_Z75]=false
set zFs_z0Z[zFs_Z75]=CreateTimer()
set zFs_z1Z[zFs_Z75]=false
set zFs_Z3z[zFs_Z75]=false
set zFs_Z4z[zFs_Z75]=0
set zFs_Z20[zFs_Z75]=DialogCreate()
set zFs_Z91[zFs_Z75]=DialogCreate()
set zFs_zZ1[zFs_Z75]=DialogCreate()
set zFs_z31[zFs_Z75]=false
set zFs_Z32[zFs_Z75]=0
set zFs_Z42[zFs_Z75]=false
set zFs_Zz3[zFs_Z75]=DialogCreate()
set zFs_Z33[zFs_Z75]=false
set zFs_Z43[zFs_Z75]=true
set zFs_Z53[zFs_Z75]=false
set zFs_Z63[zFs_Z75]=false
set zFs_Z73[zFs_Z75]=CreateTimer()
set zFs_Z75=zFs_Z75+1
endloop
set zFs_Z75=0
loop
exitwhen(zFs_Z75>3)
set zFs_Z75=zFs_Z75+1
endloop
set zFs_Z75=0
loop
exitwhen(zFs_Z75>21)
set zFs_z12[zFs_Z75]=false
set zFs_Z75=zFs_Z75+1
endloop
call TriggerRegisterTimerEvent(zFs_z23,.01,false)
call TriggerAddAction(zFs_z23,function zFs_Z7zZ)
call TriggerAddAction(zFs_z33,function zFs_Z70Z)
call TriggerAddAction(zFs_z43,function zFs_Z74Z)
call TriggerAddAction(zFs_z53,function zFs_Z8zZ)
call TriggerAddAction(zFs_z63,function zFs_Z80Z)
call TriggerRegisterAnyUnitEventBJ(zFs_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(zFs_z73,function zFs_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(zFs_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(zFs_z83,function zFs_Z93Z)
call DisableTrigger(zFs_z83)
call zFs_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set zFs_Z65=null
endfunction
