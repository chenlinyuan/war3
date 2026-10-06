function mhhke_Z64 takes real mhhke_Z74,location mhhke_Z84 returns group
set mhhke_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(mhhke_Z14,mhhke_Z84,mhhke_Z74,mhhke_Z34)
return mhhke_Z14
endfunction
function mhhke_Z94 takes player mhhke_zZ4 returns group
set mhhke_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(mhhke_Z14,mhhke_zZ4,mhhke_Z34)
return mhhke_Z14
endfunction
function mhhke_zz4 takes player mhhke_zZ4,integer mhhke_z04 returns group
set mhhke_Z14=CreateGroup()
set bj_groupEnumTypeId=mhhke_z04
call GroupEnumUnitsOfPlayer(mhhke_Z14,mhhke_zZ4,filterGetUnitsOfPlayerAndTypeId)
return mhhke_Z14
endfunction
function mhhke_z14 takes player mhhke_zZ4 returns force
set mhhke_Z24=CreateForce()
call ForceEnumAllies(mhhke_Z24,mhhke_zZ4,mhhke_Z34)
return mhhke_Z24
endfunction
function mhhke_z24 takes player mhhke_zZ4 returns force
set mhhke_Z24=CreateForce()
call ForceEnumEnemies(mhhke_Z24,mhhke_zZ4,mhhke_Z34)
return mhhke_Z24
endfunction
function mhhke_Z45 takes trigger mhhke_Z55,player mhhke_Z65,integer mhhke_Z75 returns nothing
local playerevent mhhke_Z85=ConvertPlayerEvent(mhhke_Z75)
call TriggerRegisterPlayerEvent(mhhke_Z55,mhhke_Z65,mhhke_Z85)
set mhhke_Z85=null
endfunction
function mhhke_Z95 takes trigger mhhke_Z55,player mhhke_Z65,integer mhhke_Z75 returns nothing
local playerunitevent mhhke_Z85=ConvertPlayerUnitEvent(mhhke_Z75)
call TriggerRegisterPlayerUnitEvent(mhhke_Z55,mhhke_Z65,mhhke_Z85,null)
set mhhke_Z85=null
endfunction
function mhhke_zZ5 takes integer mhhke_Z75,player mhhke_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(mhhke_Z30[mhhke_Z75],mhhke_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(mhhke_Z50[mhhke_Z75],mhhke_Z65,ConvertPlayerUnitEvent(25),null)
call mhhke_Z45(mhhke_Z70[mhhke_Z75],mhhke_Z65,17)
call mhhke_Z45(mhhke_Z90[mhhke_Z75],mhhke_Z65,266)
call mhhke_Z45(mhhke_Z80[mhhke_Z75],mhhke_Z65,268)
call mhhke_Z45(mhhke_zZ0[mhhke_Z75],mhhke_Z65,262)
call mhhke_Z45(mhhke_zz0[mhhke_Z75],mhhke_Z65,264)
call TriggerRegisterTimerExpireEvent(mhhke_z43,mhhke_z0Z[mhhke_Z75])
call TriggerRegisterTimerExpireEvent(mhhke_z33,mhhke_Z73[mhhke_Z75])
call mhhke_Z95(mhhke_Z40[mhhke_Z75],mhhke_Z65,32)
call mhhke_Z95(mhhke_Z60[mhhke_Z75],mhhke_Z65,35)
call TriggerRegisterDialogEvent(mhhke_ZZ1[mhhke_Z75],mhhke_zZ1[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Zz2[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Zz1[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z01[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z81[mhhke_Z75],mhhke_Z91[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z71[mhhke_Z75],mhhke_zZ1[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z21[mhhke_Z75],mhhke_Z91[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z31[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z22[mhhke_Z75],mhhke_Z91[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z11[mhhke_Z75],mhhke_Z91[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z51[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z41[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z61[mhhke_Z75],mhhke_Z91[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z12[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z02[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z23[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call TriggerRegisterDialogEvent(mhhke_Z13[mhhke_Z75],mhhke_Z20[mhhke_Z75])
call mhhke_Z95(mhhke_z01[mhhke_Z75],mhhke_Z65,38)
call mhhke_Z95(mhhke_z11[mhhke_Z75],mhhke_Z65,39)
call mhhke_Z95(mhhke_z21[mhhke_Z75],mhhke_Z65,40)
call mhhke_Z95(mhhke_z80[mhhke_Z75],mhhke_Z65,276)
call mhhke_Z95(mhhke_z80[mhhke_Z75],mhhke_Z65,275)
call mhhke_Z95(mhhke_z90[mhhke_Z75],mhhke_Z65,276)
call mhhke_Z95(mhhke_z90[mhhke_Z75],mhhke_Z65,275)
call mhhke_Z95(mhhke_ZZ3[mhhke_Z75],mhhke_Z65,18)
call TriggerRegisterPlayerStateEvent(mhhke_z60[mhhke_Z75],mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(mhhke_z40[mhhke_Z75],mhhke_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(mhhke_z50[mhhke_Z75],mhhke_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call mhhke_Z95(mhhke_z70[mhhke_Z75],mhhke_Z65,20)
call TriggerRegisterPlayerChatEvent(mhhke_zz1[mhhke_Z75],mhhke_Z65,"-",false)
call mhhke_Z95(mhhke_Z6z[mhhke_Z75],mhhke_Z65,39)
set mhhke_Z3z[mhhke_Z75]=true
endfunction
function mhhke_zz5 takes player mhhke_z05,integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_z25)then
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)+mhhke_z15)
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(mhhke_z05,PLAYER_STATE_GOLD_GATHERED)-mhhke_z15)
else
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)-mhhke_z15)
endif
endfunction
function mhhke_z35 takes player mhhke_z05,integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_z25)then
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)+mhhke_z15)
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(mhhke_z05,PLAYER_STATE_LUMBER_GATHERED)-mhhke_z15)
else
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)-mhhke_z15)
endif
endfunction
function mhhke_z45 takes player mhhke_z05 returns nothing
local player mhhke_Z65=GetLocalPlayer()
if mhhke_z05==mhhke_Z65 then
set mhhke_Z65=Player(-1)
endif
set mhhke_Z65=null
endfunction
function mhhke_z55 takes unit mhhke_z65,unit mhhke_z75,boolean mhhke_z85 returns nothing
local location mhhke_z95
local location mhhke_ZZ6
set mhhke_z95=GetUnitLoc(mhhke_z65)
set mhhke_ZZ6=GetUnitLoc(mhhke_z75)
call SetUnitPositionLoc(mhhke_z65,mhhke_ZZ6)
if(mhhke_z85)then
call SetUnitPositionLoc(mhhke_z75,mhhke_z95)
call SetUnitPositionLoc(mhhke_z65,mhhke_ZZ6)
endif
call RemoveLocation(mhhke_z95)
call RemoveLocation(mhhke_ZZ6)
set mhhke_z95=null
set mhhke_ZZ6=null
endfunction
function mhhke_Zz6 takes integer mhhke_Z06 returns nothing
if(mhhke_Z06==0)then
set mhhke_zZ2=100
set mhhke_Z92=100
set mhhke_Z82=100
set mhhke_Z72="|cFFFFFFFF"
return
endif
if(mhhke_Z06==1)then
set mhhke_zZ2=50
set mhhke_Z92=50
set mhhke_Z82=50
set mhhke_Z72="|cFF7F7F7F"
return
endif
if(mhhke_Z06==2)then
set mhhke_zZ2=0
set mhhke_Z92=0
set mhhke_Z82=0
set mhhke_Z72="|cFF000000"
return
endif
if(mhhke_Z06==3)then
set mhhke_zZ2=100
set mhhke_Z92=0
set mhhke_Z82=0
set mhhke_Z72="|cFFFF0000"
return
endif
if(mhhke_Z06==4)then
set mhhke_zZ2=100
set mhhke_Z92=50
set mhhke_Z82=0
set mhhke_Z72="|cFFFF7F00"
return
endif
if(mhhke_Z06==5)then
set mhhke_zZ2=100
set mhhke_Z92=100
set mhhke_Z82=0
set mhhke_Z72="|cFFFFFF00"
return
endif
if(mhhke_Z06==6)then
set mhhke_zZ2=0
set mhhke_Z92=100
set mhhke_Z82=0
set mhhke_Z72="|cFF00FF00"
return
endif
if(mhhke_Z06==7)then
set mhhke_zZ2=0
set mhhke_Z92=100
set mhhke_Z82=100
set mhhke_Z72="|cFF00FFFF"
return
endif
if(mhhke_Z06==8)then
set mhhke_zZ2=0
set mhhke_Z92=0
set mhhke_Z82=100
set mhhke_Z72="|cFF0000FF"
return
endif
if(mhhke_Z06==9)then
set mhhke_zZ2=100
set mhhke_Z92=0
set mhhke_Z82=100
set mhhke_Z72="|cFFFF00FF"
return
endif
endfunction
function mhhke_Z16 takes integer mhhke_Z06,unit mhhke_Z26,string mhhke_Z36 returns nothing
local texttag mhhke_Z46
local location mhhke_z95
call mhhke_Zz6(mhhke_Z06)
set mhhke_z95=GetUnitLoc(mhhke_Z26)
set mhhke_Z46=CreateTextTagLocBJ(mhhke_Z36,mhhke_z95,0,20,mhhke_zZ2,mhhke_Z92,mhhke_Z82,0)
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
call SetTextTagPermanent(mhhke_Z46,false)
call SetTextTagLifespan(mhhke_Z46,mhhke_Z1)
set mhhke_Z46=null
endfunction
function mhhke_Z56 takes nothing returns nothing
local trigger mhhke_Z66=GetTriggeringTrigger()
local timer mhhke_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(mhhke_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(mhhke_z52)
call DestroyTimerDialog(mhhke_z82)
call DestroyTimer(mhhke_Z76)
set mhhke_Z66=null
set mhhke_Z76=null
endfunction
function mhhke_Z86 takes nothing returns nothing
local timer mhhke_Z76
local trigger mhhke_Z66
if(mhhke_z62)then
else
set mhhke_z52=GetGameSpeed()
set mhhke_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set mhhke_Z66=CreateTrigger()
set mhhke_Z76=CreateTimer()
call StartTimerBJ(mhhke_Z76,false,mhhke_z42)
set mhhke_z82=CreateTimerDialogBJ(mhhke_Z76,"子弹时间")
call TriggerAddAction(mhhke_Z66,function mhhke_Z56)
call TriggerRegisterTimerExpireEvent(mhhke_Z66,mhhke_Z76)
endif
endfunction
function mhhke_Z96 takes trigger mhhke_zZ6 returns nothing
if(IsTriggerEnabled(mhhke_zZ6))then
call DisableTrigger(mhhke_zZ6)
else
call EnableTrigger(mhhke_zZ6)
endif
endfunction
function mhhke_zz6 takes trigger mhhke_zZ6,boolean mhhke_z06 returns nothing
if(IsTriggerEnabled(mhhke_zZ6)==mhhke_z06)then
else
call mhhke_Z96(mhhke_zZ6)
endif
endfunction
function mhhke_z16 takes integer mhhke_z15,boolean mhhke_z25 returns nothing
call mhhke_zz6(mhhke_z40[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_z50[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_z60[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_z80[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_z70[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_z90[mhhke_z15],mhhke_z25)
call mhhke_zz6(mhhke_ZZ3[mhhke_z15],mhhke_z25)
endfunction
function mhhke_z26 takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
if(GetUnitUserData(mhhke_z65)==2176)then
call RemoveUnit(mhhke_z65)
endif
set mhhke_z65=null
endfunction
function mhhke_z36 takes player mhhke_z05 returns nothing
local group mhhke_z46
if(mhhke_Z42[GetPlayerId(mhhke_z05)])then
set mhhke_z46=mhhke_Z94(mhhke_z05)
call ForGroup(mhhke_z46,function mhhke_z26)
set mhhke_Z42[GetPlayerId(mhhke_z05)]=false
call DestroyGroup(mhhke_z46)
set mhhke_z46=null
endif
endfunction
function mhhke_z56 takes unit mhhke_z65,player mhhke_z05 returns nothing
local location mhhke_z95
local integer mhhke_z66
local unit mhhke_z76
local item mhhke_z86
local integer mhhke_Z75=0
if(IsUnitType(mhhke_z65,UNIT_TYPE_HERO))then
set mhhke_z95=GetUnitLoc(mhhke_z65)
set mhhke_z66=GetUnitTypeId(mhhke_z65)
set mhhke_z76=CreateUnitAtLoc(mhhke_z05,mhhke_z66,mhhke_z95,bj_UNIT_FACING)
call SetUnitUserData(mhhke_z76,2176)
set mhhke_Z42[GetPlayerId(mhhke_z05)]=true
if(mhhke_Z6Z)then
call SetUnitUseFood(mhhke_z76,false)
endif
call SetHeroLevelBJ(mhhke_z76,GetHeroLevel(mhhke_z65),false)
call SetHeroStat(mhhke_z76,0,GetHeroStatBJ(0,mhhke_z65,false))
call SetHeroStat(mhhke_z76,1,GetHeroStatBJ(1,mhhke_z65,false))
call SetHeroStat(mhhke_z76,2,GetHeroStatBJ(2,mhhke_z65,false))
loop
exitwhen mhhke_Z75>5
set mhhke_z86=UnitItemInSlot(mhhke_z65,mhhke_Z75)
call UnitAddItemById(mhhke_z76,GetItemTypeId(mhhke_z86))
set mhhke_Z75=mhhke_Z75+1
endloop
endif
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
set mhhke_z76=null
set mhhke_z86=null
endfunction
function mhhke_z96 takes integer mhhke_ZZ7,player mhhke_Zz7,location mhhke_Z07,boolean mhhke_Z17,boolean mhhke_Z27 returns nothing
local unit mhhke_z76
set mhhke_z76=CreateUnitAtLoc(mhhke_Zz7,mhhke_ZZ7,mhhke_Z07,bj_UNIT_FACING)
if(mhhke_Z6Z)then
call SetUnitUseFood(mhhke_z76,false)
endif
if(mhhke_Z17)then
call SetUnitUserData(mhhke_z76,2176)
endif
if(mhhke_Z27)then
call UnitApplyTimedLife(mhhke_z76,1112820806,90)
endif
set mhhke_z76=null
endfunction
function mhhke_Z37 takes integer mhhke_ZZ7,player mhhke_Zz7,location mhhke_Z07 returns nothing
local unit mhhke_z76
set mhhke_z76=CreateUnitAtLoc(mhhke_Zz7,mhhke_ZZ7,mhhke_Z07,bj_UNIT_FACING)
if(mhhke_Z6Z)then
call SetUnitUseFood(mhhke_z76,false)
set mhhke_z76=null
endif
endfunction
function mhhke_Z47 takes unit mhhke_Z57,player mhhke_Zz7,integer mhhke_Z67,boolean mhhke_Z27 returns nothing
local location mhhke_z95
local integer mhhke_z66
local integer mhhke_Z75
set mhhke_z95=GetUnitLoc(mhhke_Z57)
set mhhke_z66=GetUnitTypeId(mhhke_Z57)
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>mhhke_Z67
call mhhke_z96(mhhke_z66,mhhke_Zz7,mhhke_z95,true,mhhke_Z27)
set mhhke_Z75=mhhke_Z75+1
endloop
call RemoveLocation(mhhke_z95)
set mhhke_Z42[GetPlayerId(mhhke_Zz7)]=true
set mhhke_z95=null
endfunction
function mhhke_Z77 takes unit mhhke_Z57,player mhhke_Zz7,integer mhhke_Z67 returns nothing
call mhhke_Z47(mhhke_Z57,mhhke_Zz7,mhhke_Z67,false)
endfunction
function mhhke_Z87 takes unit mhhke_z65,integer mhhke_z15,boolean mhhke_Z97 returns nothing
local integer mhhke_Z75
set mhhke_Z75=GetResourceAmount(mhhke_z65)
if(mhhke_Z97)then
set mhhke_Z75=mhhke_Z75+mhhke_z15
else
set mhhke_Z75=mhhke_Z75-mhhke_z15
endif
if(mhhke_Z75<0)then
if(mhhke_Z97)then
set mhhke_Z75=GetResourceAmount(mhhke_z65)
else
set mhhke_Z75=0
endif
endif
call SetResourceAmount(mhhke_z65,mhhke_Z75)
endfunction
function mhhke_zZ7 takes integer mhhke_z15,player mhhke_z05,boolean mhhke_zz7 returns nothing
if(mhhke_zz7)then
call SetPlayerTechMaxAllowed(mhhke_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(mhhke_z05,1212502607,3)
endif
endfunction
function mhhke_z07 takes integer mhhke_z15,boolean mhhke_z06 returns nothing
if(mhhke_z06)then
call EnableTrigger(mhhke_z00[mhhke_z15])
call EnableTrigger(mhhke_z10[mhhke_z15])
call EnableTrigger(mhhke_z20[mhhke_z15])
call EnableTrigger(mhhke_z30[mhhke_z15])
call EnableTrigger(mhhke_Z70[mhhke_z15])
call EnableTrigger(mhhke_Z80[mhhke_z15])
call EnableTrigger(mhhke_Z90[mhhke_z15])
call EnableTrigger(mhhke_zZ0[mhhke_z15])
call EnableTrigger(mhhke_zz0[mhhke_z15])
else
call DisableTrigger(mhhke_z00[mhhke_z15])
call DisableTrigger(mhhke_z10[mhhke_z15])
call DisableTrigger(mhhke_z20[mhhke_z15])
call DisableTrigger(mhhke_z30[mhhke_z15])
call DisableTrigger(mhhke_Z70[mhhke_z15])
call DisableTrigger(mhhke_Z80[mhhke_z15])
call DisableTrigger(mhhke_Z90[mhhke_z15])
call DisableTrigger(mhhke_zZ0[mhhke_z15])
call DisableTrigger(mhhke_zz0[mhhke_z15])
endif
endfunction
function mhhke_z17 takes integer mhhke_z15,boolean mhhke_z27 returns nothing
if(mhhke_z27)then
call EnableTrigger(mhhke_Z40[mhhke_z15])
call EnableTrigger(mhhke_Z60[mhhke_z15])
call EnableTrigger(mhhke_Z6z[mhhke_z15])
else
call DisableTrigger(mhhke_Z40[mhhke_z15])
call DisableTrigger(mhhke_Z60[mhhke_z15])
call DisableTrigger(mhhke_Z6z[mhhke_z15])
endif
endfunction
function mhhke_z37 takes nothing returns nothing
local integer mhhke_z15
set mhhke_z15=0
loop
exitwhen mhhke_z15>11
call mhhke_z07(mhhke_z15,false)
set mhhke_z15=mhhke_z15+1
endloop
endfunction
function mhhke_z47 takes integer mhhke_z15 returns nothing
set mhhke_z6[mhhke_z15]=false
call GroupClear(mhhke_Z8Z[mhhke_z15])
if(mhhke_Z7Z)then
call DestroyFogModifier(mhhke_Z6[mhhke_z15])
endif
call DisableTrigger(mhhke_Z30[mhhke_z15])
call DisableTrigger(mhhke_Z50[mhhke_z15])
call DisableTrigger(mhhke_zz1[mhhke_z15])
call DisableTrigger(mhhke_z40[mhhke_z15])
call DisableTrigger(mhhke_z50[mhhke_z15])
call DisableTrigger(mhhke_z60[mhhke_z15])
call DisableTrigger(mhhke_z70[mhhke_z15])
call DisableTrigger(mhhke_z80[mhhke_z15])
call DisableTrigger(mhhke_z90[mhhke_z15])
call DisableTrigger(mhhke_ZZ3[mhhke_z15])
call DisableTrigger(mhhke_ZZ1[mhhke_z15])
call DisableTrigger(mhhke_Zz1[mhhke_z15])
call DisableTrigger(mhhke_Zz2[mhhke_z15])
call DisableTrigger(mhhke_Z01[mhhke_z15])
call DisableTrigger(mhhke_Z81[mhhke_z15])
call DisableTrigger(mhhke_Z21[mhhke_z15])
call DisableTrigger(mhhke_Z51[mhhke_z15])
call DisableTrigger(mhhke_Z41[mhhke_z15])
call DisableTrigger(mhhke_Z61[mhhke_z15])
call DisableTrigger(mhhke_Z12[mhhke_z15])
call DisableTrigger(mhhke_Z02[mhhke_z15])
call DisableTrigger(mhhke_Z71[mhhke_z15])
call DisableTrigger(mhhke_Z31[mhhke_z15])
call DisableTrigger(mhhke_Z22[mhhke_z15])
call DisableTrigger(mhhke_Z11[mhhke_z15])
call DisableTrigger(mhhke_Z23[mhhke_z15])
call DisableTrigger(mhhke_Z13[mhhke_z15])
call DisableTrigger(mhhke_zZ3[mhhke_z15])
call DisableTrigger(mhhke_Z40[mhhke_z15])
call DisableTrigger(mhhke_Z60[mhhke_z15])
call DisableTrigger(mhhke_Z6z[mhhke_z15])
call mhhke_z07(mhhke_z15,false)
endfunction
function mhhke_z57 takes integer mhhke_z15,player mhhke_z05 returns nothing
set mhhke_z6[mhhke_z15]=true
if(mhhke_Z3z[mhhke_z15])then
else
call mhhke_zZ5(mhhke_z15,mhhke_z05)
endif
call EnableTrigger(mhhke_Z30[mhhke_z15])
call EnableTrigger(mhhke_Z50[mhhke_z15])
call EnableTrigger(mhhke_zz1[mhhke_z15])
call mhhke_z07(mhhke_z15,true)
endfunction
function mhhke_z67 takes integer mhhke_z15,boolean mhhke_z77 returns nothing
if(mhhke_z77)then
if((mhhke_zZZ[mhhke_z15])and(mhhke_zzZ[mhhke_z15])and(mhhke_z31[mhhke_z15]))then
call EnableTrigger(mhhke_z01[mhhke_z15])
call EnableTrigger(mhhke_z11[mhhke_z15])
call EnableTrigger(mhhke_z21[mhhke_z15])
endif
else
call DisableTrigger(mhhke_z01[mhhke_z15])
call DisableTrigger(mhhke_z11[mhhke_z15])
call DisableTrigger(mhhke_z21[mhhke_z15])
endif
endfunction
function mhhke_z87 takes integer mhhke_Z06 returns nothing
if(mhhke_Z06==0)then
set mhhke_zz2=0
return
endif
if(mhhke_Z06==1)then
set mhhke_zz2=10
return
endif
if(mhhke_Z06==2)then
set mhhke_zz2=15
return
endif
if(mhhke_Z06==3)then
set mhhke_zz2=20
return
endif
if(mhhke_Z06==4)then
set mhhke_zz2=40
return
endif
if(mhhke_Z06==5)then
set mhhke_zz2=50
return
endif
if(mhhke_Z06==6)then
set mhhke_zz2=70
return
endif
if(mhhke_Z06==7)then
set mhhke_zz2=80
return
endif
if(mhhke_Z06==8)then
set mhhke_zz2=90
return
endif
if(mhhke_Z06==9)then
set mhhke_zz2=100
return
endif
endfunction
function mhhke_z97 takes unit mhhke_z65,integer mhhke_ZZ8,integer mhhke_Zz8 returns nothing
call mhhke_z87(mhhke_Zz8)
call mhhke_Zz6(mhhke_ZZ8)
call SetUnitVertexColorBJ(mhhke_z65,mhhke_zZ2,mhhke_Z92,mhhke_Z82,mhhke_zz2)
endfunction
function mhhke_Z08 takes integer mhhke_ZZ8,integer mhhke_Zz8 returns nothing
call mhhke_z87(mhhke_Zz8)
call mhhke_Zz6(mhhke_ZZ8)
call SetWaterBaseColorBJ(mhhke_zZ2,mhhke_Z92,mhhke_Z82,mhhke_zz2)
endfunction
function mhhke_Z18 takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call mhhke_z97(mhhke_z65,GetRandomInt(3,9),0)
set mhhke_z65=null
endfunction
function mhhke_Z28 takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call mhhke_z97(mhhke_z65,0,0)
set mhhke_z65=null
endfunction
function mhhke_Z38 takes integer mhhke_z15,boolean mhhke_z77 returns nothing
local integer mhhke_Z75
local integer mhhke_Z48
if(mhhke_Z53[mhhke_z15]==mhhke_z77)then
else
set mhhke_Z53[mhhke_z15]=mhhke_z77
if(mhhke_z77)then
call EnableTrigger(mhhke_z83)
else
set mhhke_Z75=0
set mhhke_Z48=0
loop
exitwhen mhhke_Z75>11
if(mhhke_Z53[mhhke_Z75])then
set mhhke_Z48=mhhke_Z48+1
endif
set mhhke_Z75=mhhke_Z75+1
endloop
if(mhhke_Z48==0)then
call DisableTrigger(mhhke_z83)
endif
endif
endif
endfunction
function mhhke_Z58 takes integer mhhke_Z68 returns nothing
if(mhhke_Z68==0)then
call SetSkyModel(null)
return
endif
if(mhhke_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(mhhke_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(mhhke_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(mhhke_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(mhhke_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(mhhke_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(mhhke_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(mhhke_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(mhhke_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(mhhke_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(mhhke_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(mhhke_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(mhhke_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function mhhke_Z78 takes integer mhhke_Z88 returns integer
if(mhhke_Z88==0)then
return 1380018290
endif
if(mhhke_Z88==1)then
return 1380019314
endif
if(mhhke_Z88==2)then
return 1296393331
endif
if(mhhke_Z88==3)then
return 1178886760
endif
if(mhhke_Z88==4)then
return 1178886764
endif
if(mhhke_Z88==5)then
return 1178888040
endif
if(mhhke_Z88==6)then
return 1178888044
endif
if(mhhke_Z88==7)then
return 1178890856
endif
if(mhhke_Z88==8)then
return 1178890860
endif
if(mhhke_Z88==9)then
return 1178892136
endif
if(mhhke_Z88==10)then
return 1178892140
endif
if(mhhke_Z88==11)then
return 1380739186
endif
if(mhhke_Z88==12)then
return 1380740210
endif
if(mhhke_Z88==13)then
return 1397645939
endif
if(mhhke_Z88==14)then
return 1397647475
endif
if(mhhke_Z88==15)then
return 1397648499
endif
if(mhhke_Z88==16)then
return 1464820599
endif
if(mhhke_Z88==17)then
return 1464822903
endif
if(mhhke_Z88==18)then
return 1280467297
endif
if(mhhke_Z88==19)then
return 1280470369
endif
if(mhhke_Z88==20)then
return 1464755063
endif
return 0
endfunction
function mhhke_Z98 takes integer mhhke_Z88,boolean mhhke_z77 returns nothing
set mhhke_Z88=mhhke_Z88-1
if(mhhke_z77)then
if(mhhke_z12[mhhke_Z88]==false)then
if(mhhke_Z78(mhhke_Z88)==0)then
else
set mhhke_z02[mhhke_Z88]=AddWeatherEffect(mhhke_z8,mhhke_Z78(mhhke_Z88))
call EnableWeatherEffect(mhhke_z02[mhhke_Z88],true)
set mhhke_z12[mhhke_Z88]=true
endif
endif
else
if(mhhke_z02[mhhke_Z88]==null)then
else
call EnableWeatherEffect(mhhke_z02[mhhke_Z88],false)
call RemoveWeatherEffect(mhhke_z02[mhhke_Z88])
set mhhke_z12[mhhke_Z88]=false
set mhhke_z02[mhhke_Z88]=null
endif
endif
endfunction
function mhhke_zZ8 takes nothing returns nothing
local integer mhhke_z15=1
loop
exitwhen mhhke_z15>21
call mhhke_Z98(mhhke_z15,false)
set mhhke_z15=mhhke_z15+1
endloop
endfunction
function mhhke_zz8 takes integer mhhke_z08 returns integer
if(mhhke_z08==0)then
return 1280601204
endif
if(mhhke_z08==1)then
return 1179939959
endif
if(mhhke_z08==2)then
return 1465152631
endif
if(mhhke_z08==3)then
return 1096053874
endif
if(mhhke_z08==4)then
return 1096053859
endif
if(mhhke_z08==5)then
return 1112831095
endif
if(mhhke_z08==6)then
return 1263826039
endif
if(mhhke_z08==7)then
return 1498707828
endif
if(mhhke_z08==8)then
return 1498702708
endif
if(mhhke_z08==9)then
return 1498703476
endif
if(mhhke_z08==10)then
return 1498706804
endif
if(mhhke_z08==11)then
return 1247044468
endif
if(mhhke_z08==12)then
return 1247048823
endif
if(mhhke_z08==13)then
return 1146385256
endif
if(mhhke_z08==14)then
return 1129608306
endif
if(mhhke_z08==15)then
return 1129608291
endif
if(mhhke_z08==16)then
return 1230271607
endif
if(mhhke_z08==17)then
return 1230271607
endif
if(mhhke_z08==18)then
return 1314157667
endif
if(mhhke_z08==19)then
return 1330934903
endif
if(mhhke_z08==20)then
return 1515484279
endif
if(mhhke_z08==21)then
return 1196716904
endif
if(mhhke_z08==22)then
return 1448373364
endif
if(mhhke_z08==23)then
return 1448373364
endif
return 0
endfunction
function mhhke_z18 takes nothing returns integer
return mhhke_zz8(GetRandomInt(0,23))
endfunction
function mhhke_z28 takes unit mhhke_z65,integer mhhke_z38,integer mhhke_z08,integer mhhke_z48 returns nothing
local real mhhke_z58
local real mhhke_z68
local real mhhke_z15=0
local boolean mhhke_z78=true
set mhhke_z58=GetUnitX(mhhke_z65)
set mhhke_z68=GetUnitY(mhhke_z65)
if(mhhke_z38==1)then
loop
exitwhen mhhke_z15==mhhke_z48
if(mhhke_z78)then
call CreateDestructable(mhhke_z08,mhhke_z58,mhhke_z68+mhhke_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(mhhke_z08,mhhke_z58,mhhke_z68-mhhke_z15*40,GetRandomReal(0,360),1,0)
endif
set mhhke_z78=not(mhhke_z78)
set mhhke_z15=mhhke_z15+1
endloop
endif
if(mhhke_z38==2)then
loop
exitwhen mhhke_z15==mhhke_z48
if(mhhke_z78)then
call CreateDestructable(mhhke_z08,mhhke_z58+mhhke_z15*40,mhhke_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(mhhke_z08,mhhke_z58-mhhke_z15*40,mhhke_z68,GetRandomReal(0,360),1,0)
endif
set mhhke_z78=not(mhhke_z78)
set mhhke_z15=mhhke_z15+1
endloop
endif
if(mhhke_z38==3)then
loop
exitwhen mhhke_z15==mhhke_z48
if(mhhke_z78)then
call CreateDestructable(mhhke_z08,mhhke_z58+mhhke_z15*40,mhhke_z68+mhhke_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(mhhke_z08,mhhke_z58-mhhke_z15*40,mhhke_z68-mhhke_z15*40,GetRandomReal(0,360),1,0)
endif
set mhhke_z78=not(mhhke_z78)
set mhhke_z15=mhhke_z15+1
endloop
endif
if(mhhke_z38==4)then
loop
exitwhen mhhke_z15==mhhke_z48
if(mhhke_z78)then
call CreateDestructable(mhhke_z08,mhhke_z58+mhhke_z15*40,mhhke_z68-mhhke_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(mhhke_z08,mhhke_z58-mhhke_z15*40,mhhke_z68+mhhke_z15*40,GetRandomReal(0,360),1,0)
endif
set mhhke_z78=not(mhhke_z78)
set mhhke_z15=mhhke_z15+1
endloop
endif
endfunction
function mhhke_z88 takes integer mhhke_z15 returns nothing
set mhhke_Z7[mhhke_z15]=true
call StartTimerBJ(mhhke_z0Z[mhhke_z15],false,2.)
endfunction
function mhhke_z98 takes integer mhhke_z15,boolean mhhke_ZZZZ returns nothing
local integer mhhke_Z75
local integer mhhke_z76
local item mhhke_z86
local location mhhke_z95
local unit mhhke_z65
set mhhke_z65=mhhke_z7[mhhke_z15]
set mhhke_z76=1
loop
exitwhen mhhke_z76>6
if(mhhke_ZZZZ)then
set mhhke_z95=GetUnitLoc(mhhke_z51[mhhke_z15])
else
set mhhke_z95=GetUnitLoc(mhhke_z65)
endif
set mhhke_z86=UnitItemInSlotBJ(mhhke_z65,mhhke_z76)
if(GetItemCharges(mhhke_z86)>0)then
set mhhke_Z75=GetItemCharges(mhhke_z86)
set mhhke_z86=CreateItemLoc(GetItemTypeId(mhhke_z86),mhhke_z95)
call SetItemCharges(mhhke_z86,mhhke_Z75)
else
call CreateItemLoc(GetItemTypeId(mhhke_z86),mhhke_z95)
endif
call RemoveLocation(mhhke_z95)
set mhhke_z76=mhhke_z76+1
endloop
set mhhke_z65=null
set mhhke_z95=null
set mhhke_z86=null
endfunction
function mhhke_ZZzZ takes integer mhhke_z15,player mhhke_z05 returns nothing
local integer mhhke_Z75
local force mhhke_ZZ0Z
local player mhhke_Z65
if(mhhke_z1Z[mhhke_z15])then
call DestroyFogModifier(mhhke_Z6[mhhke_z15])
set mhhke_z1Z[mhhke_z15]=false
else
set mhhke_ZZ0Z=CreateForce()
set mhhke_Z75=0
loop
exitwhen mhhke_Z75>11
set mhhke_Z65=Player(mhhke_Z75)
if(GetPlayerAlliance(mhhke_z05,mhhke_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(mhhke_ZZ0Z,mhhke_Z65)
call SetPlayerAlliance(mhhke_z05,mhhke_Z65,ALLIANCE_SHARED_VISION,false)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z6[mhhke_z15]=CreateFogModifierRect(mhhke_z05,FOG_OF_WAR_VISIBLE,mhhke_z8,false,false)
call FogModifierStart(mhhke_Z6[mhhke_z15])
set mhhke_z1Z[mhhke_z15]=true
set mhhke_Z75=0
loop
exitwhen mhhke_Z75>11
set mhhke_Z65=Player(mhhke_Z75)
if(IsPlayerInForce(mhhke_Z65,mhhke_ZZ0Z))then
call SetPlayerAlliance(mhhke_z05,mhhke_Z65,ALLIANCE_SHARED_VISION,true)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
call DestroyForce(mhhke_ZZ0Z)
set mhhke_ZZ0Z=null
set mhhke_Z65=null
endif
endfunction
function mhhke_ZZ1Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local integer mhhke_Z75
local unit mhhke_z65
local item mhhke_z86
local item array mhhke_ZZ2Z
set mhhke_z65=FirstOfGroup(mhhke_Z8Z[mhhke_z15])
if((mhhke_z05==GetOwningPlayer(mhhke_z65))and(UnitInventorySizeBJ(mhhke_z65)>0))then
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>6
set mhhke_z86=UnitItemInSlotBJ(mhhke_z65,mhhke_Z75)
set mhhke_ZZ2Z[(mhhke_Z75-1)]=mhhke_z86
call UnitRemoveItemSwapped(mhhke_z86,mhhke_z65)
call SetItemVisible(mhhke_z86,false)
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>6
set mhhke_z86=mhhke_Z2z[(mhhke_z15*18)+(mhhke_Z4z[mhhke_z15]*6)+(mhhke_Z75-1)]
call UnitAddItem(mhhke_z65,mhhke_z86)
set mhhke_Z2z[(mhhke_z15*18)+(mhhke_Z4z[mhhke_z15]*6)+(mhhke_Z75-1)]=mhhke_ZZ2Z[(mhhke_Z75-1)]
set mhhke_ZZ2Z[(mhhke_Z75-1)]=null
set mhhke_Z75=mhhke_Z75+1
endloop
if(mhhke_Z4z[mhhke_z15]==0)then
set mhhke_Z4z[mhhke_z15]=mhhke_z61-1
else
set mhhke_Z4z[mhhke_z15]=(mhhke_Z4z[mhhke_z15]-1)
endif
set mhhke_z86=null
endif
set mhhke_z65=null
set mhhke_z05=null
endfunction
function mhhke_ZZ3Z takes unit mhhke_z65 returns nothing
local integer mhhke_Z75
local item mhhke_z86
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>6
set mhhke_z86=UnitItemInSlotBJ(mhhke_z65,mhhke_Z75)
call UnitRemoveItemSwapped(mhhke_z86,mhhke_z65)
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_z86=null
endfunction
function mhhke_ZZ4Z takes integer mhhke_z15 returns nothing
local integer mhhke_Z75
local item mhhke_z86
local location mhhke_z95
set mhhke_z95=GetUnitLoc(mhhke_z51[mhhke_z15])
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>6
set mhhke_z86=UnitItemInSlotBJ(mhhke_z7[mhhke_z15],mhhke_Z75)
call UnitRemoveItemSwapped(mhhke_z86,mhhke_z7[mhhke_z15])
call SetItemPositionLoc(mhhke_z86,mhhke_z95)
set mhhke_Z75=mhhke_Z75+1
endloop
call RemoveLocation(mhhke_z95)
set mhhke_z86=null
set mhhke_z95=null
endfunction
function mhhke_ZZ5Z takes integer mhhke_z15 returns nothing
local integer mhhke_z76
local integer mhhke_z78
local unit mhhke_z65
local item mhhke_Z66
local item mhhke_ZZ6Z
set mhhke_z65=FirstOfGroup(mhhke_Z8Z[mhhke_z15])
set mhhke_z76=1
loop
exitwhen mhhke_z76>5
set mhhke_Z66=UnitItemInSlotBJ(mhhke_z65,mhhke_z76)
if(GetItemCharges(mhhke_Z66)>0)then
set mhhke_z78=mhhke_z76+1
loop
exitwhen mhhke_z78>6
set mhhke_ZZ6Z=UnitItemInSlotBJ(mhhke_z65,mhhke_z78)
if(GetItemTypeId(mhhke_Z66)==GetItemTypeId(mhhke_ZZ6Z))then
call SetItemCharges(mhhke_Z66,(GetItemCharges(mhhke_Z66)+GetItemCharges(mhhke_ZZ6Z)))
call RemoveItem(mhhke_ZZ6Z)
endif
set mhhke_z78=mhhke_z78+1
endloop
endif
set mhhke_z76=mhhke_z76+1
endloop
set mhhke_Z66=null
set mhhke_ZZ6Z=null
set mhhke_z65=null
endfunction
function mhhke_ZZ7Z takes integer mhhke_z15,integer mhhke_Z75 returns nothing
local unit mhhke_z65
local item mhhke_z86
set mhhke_z65=FirstOfGroup(mhhke_Z8Z[mhhke_z15])
set mhhke_z86=UnitItemInSlotBJ(mhhke_z65,1)
call SetItemCharges(mhhke_z86,(GetItemCharges(mhhke_z86)+mhhke_Z75))
set mhhke_z86=null
set mhhke_z65=null
endfunction
function mhhke_ZZ8Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call GroupAddUnit(mhhke_z8Z,mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_ZZ9Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call GroupRemoveUnit(mhhke_z8Z,mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_ZzZZ takes nothing returns nothing
local unit mhhke_z65=GetTriggerUnit()
if((IsUnitDeadBJ(mhhke_z65))and(IsUnitType(mhhke_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(mhhke_z8Z,mhhke_z65)
endif
endfunction
function mhhke_ZzzZ takes nothing returns nothing
call ForGroup(mhhke_z8Z,function mhhke_ZzZZ)
endfunction
function mhhke_Zz0Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call ReviveHeroLoc(mhhke_z65,mhhke_Z9Z[mhhke_Zzz],true)
call SetUnitManaPercentBJ(mhhke_z65,100)
set mhhke_z65=null
endfunction
function mhhke_Zz1Z takes player mhhke_z05 returns nothing
local group mhhke_z46
set mhhke_z46=mhhke_Z94(mhhke_z05)
set mhhke_Zzz=GetPlayerId(mhhke_z05)
call ForGroup(mhhke_z46,function mhhke_Zz0Z)
call DestroyGroup(mhhke_z46)
set mhhke_z46=null
endfunction
function mhhke_Zz2Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call ModifyHeroStat(mhhke_z81,mhhke_z65,mhhke_z91,mhhke_z71)
set mhhke_z65=null
endfunction
function mhhke_Zz3Z takes integer mhhke_z15,integer mhhke_Zz4Z,integer mhhke_Zz5Z,boolean mhhke_z25 returns nothing
local integer mhhke_Zz6Z
if(mhhke_z25)then
set mhhke_Zz6Z=0
else
set mhhke_Zz6Z=1
endif
if(mhhke_Z0)then
set mhhke_z91=mhhke_Zz6Z
set mhhke_z81=mhhke_Zz4Z
set mhhke_z71=mhhke_Zz5Z
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Zz2Z)
else
call ModifyHeroStat(mhhke_Zz4Z,mhhke_z7[mhhke_z15],mhhke_Zz6Z,mhhke_Zz5Z)
endif
endfunction
function mhhke_Zz7Z takes unit mhhke_z65,integer mhhke_Zz5Z,boolean mhhke_z25 returns nothing
local integer mhhke_z15
set mhhke_z15=GetHeroLevel(mhhke_z65)
if(mhhke_z25)then
set mhhke_z15=mhhke_z15+mhhke_Zz5Z
else
set mhhke_z15=mhhke_z15-mhhke_Zz5Z
endif
call SetHeroLevelBJ(mhhke_z65,mhhke_z15,false)
endfunction
function mhhke_Zz8Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_Zz7Z(mhhke_z65,mhhke_ZZ2,mhhke_Z1z)
set mhhke_z65=null
endfunction
function mhhke_Zz9Z takes integer mhhke_z15,integer mhhke_Zz5Z,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_ZZ2=mhhke_Zz5Z
set mhhke_Z1z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Zz8Z)
else
call mhhke_Zz7Z(mhhke_z7[mhhke_z15],mhhke_Zz5Z,mhhke_z25)
endif
endfunction
function mhhke_Z0ZZ takes string mhhke_Z0zZ returns integer
local string mhhke_Z00Z="0123456789"
local string mhhke_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string mhhke_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer Id=0
local integer mhhke_Z03Z=1
local integer mhhke_Z04Z=1
loop
exitwhen mhhke_Z03Z>StringLength(mhhke_Z0zZ)
loop
exitwhen mhhke_Z04Z>10
if SubString(mhhke_Z0zZ,mhhke_Z03Z-1,mhhke_Z03Z)==SubString(mhhke_Z00Z,mhhke_Z04Z-1,mhhke_Z04Z)then
set Id=Id+R2I((48+mhhke_Z04Z-1)*Pow(256.,I2R(StringLength(mhhke_Z0zZ)-mhhke_Z03Z)))
set mhhke_Z04Z=mhhke_Z04Z+1
else
set mhhke_Z04Z=mhhke_Z04Z+1
endif
endloop
set mhhke_Z04Z=1
loop
exitwhen mhhke_Z04Z>26
if SubString(mhhke_Z0zZ,mhhke_Z03Z-1,mhhke_Z03Z)==SubString(mhhke_Z01Z,mhhke_Z04Z-1,mhhke_Z04Z)then
set Id=Id+R2I(I2R(65+mhhke_Z04Z-1)*Pow(256.,I2R(StringLength(mhhke_Z0zZ)-mhhke_Z03Z)))
set mhhke_Z04Z=mhhke_Z04Z+1
else
set mhhke_Z04Z=mhhke_Z04Z+1
endif
endloop
set mhhke_Z04Z=1
loop
exitwhen mhhke_Z04Z>26
if SubString(mhhke_Z0zZ,mhhke_Z03Z-1,mhhke_Z03Z)==SubString(mhhke_Z02Z,mhhke_Z04Z-1,mhhke_Z04Z)then
set Id=Id+R2I((97+mhhke_Z04Z-1)*Pow(256.,I2R(StringLength(mhhke_Z0zZ)-mhhke_Z03Z)))
set mhhke_Z04Z=mhhke_Z04Z+1
else
set mhhke_Z04Z=mhhke_Z04Z+1
endif
endloop
set mhhke_Z04Z=1
set mhhke_Z03Z=mhhke_Z03Z+1
endloop
return Id
endfunction
function mhhke_Z05Z takes integer mhhke_Z06Z returns string
local string mhhke_Z00Z="0123456789"
local string mhhke_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string mhhke_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string mhhke_Z07Z=""
local integer mhhke_Z03Z=0
local integer mhhke_Z08Z=0
loop
exitwhen mhhke_Z06Z==0
set mhhke_Z03Z=ModuloInteger(mhhke_Z06Z,256)
if mhhke_Z03Z>=48 and mhhke_Z03Z<=57 then
set mhhke_Z08Z=mhhke_Z03Z-48
set mhhke_Z07Z=SubString(mhhke_Z00Z,mhhke_Z08Z,mhhke_Z08Z+1)+mhhke_Z07Z
endif
if mhhke_Z03Z>=65 and mhhke_Z03Z<=90 then
set mhhke_Z08Z=mhhke_Z03Z-65
set mhhke_Z07Z=SubString(mhhke_Z01Z,mhhke_Z08Z,mhhke_Z08Z+1)+mhhke_Z07Z
endif
if mhhke_Z03Z>=97 and mhhke_Z03Z<=122 then
set mhhke_Z08Z=mhhke_Z03Z-97
set mhhke_Z07Z=SubString(mhhke_Z02Z,mhhke_Z08Z,mhhke_Z08Z+1)+mhhke_Z07Z
endif
set mhhke_Z06Z=mhhke_Z06Z/256
endloop
return mhhke_Z07Z
endfunction
function mhhke_Z09Z takes unit mhhke_z65 returns string
local integer mhhke_z15
set mhhke_z15=GetUnitTypeId(mhhke_z65)
if(mhhke_z15==0)then
return""
else
return mhhke_Z05Z(mhhke_z15)
endif
endfunction
function mhhke_Z1ZZ takes unit mhhke_z65 returns string
local item mhhke_z86=UnitItemInSlotBJ(mhhke_z65,1)
local integer mhhke_z15=GetItemTypeId(mhhke_z86)
if(mhhke_z15==0)then
return""
else
set mhhke_z86=null
return mhhke_Z05Z(mhhke_z15)
endif
endfunction
function mhhke_Z1zZ takes integer mhhke_Z10Z returns integer
local string mhhke_Z11Z=GetEventPlayerChatString()
if(StringLength(mhhke_Z11Z)==mhhke_Z10Z+3)then
return(mhhke_Z0ZZ(SubStringBJ(mhhke_Z11Z,mhhke_Z10Z,mhhke_Z10Z+3)))
else
return 0
endif
endfunction
function mhhke_Z12Z takes unit mhhke_z65,integer mhhke_z66,boolean mhhke_z25 returns nothing
local location mhhke_z95
local integer mhhke_z15
set mhhke_z15=mhhke_Z1zZ(mhhke_z66)
if(mhhke_z15==0)then
else
if(mhhke_z25)then
set mhhke_z95=GetUnitLoc(mhhke_z65)
call CreateItemLoc(mhhke_z15,mhhke_z95)
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
else
call UnitAddItemById(mhhke_z65,mhhke_z15)
endif
endif
endfunction
function mhhke_Z13Z takes unit mhhke_z65,real mhhke_Z14Z,boolean mhhke_z25 returns nothing
local location mhhke_z95=GetUnitLoc(mhhke_z65)
local player mhhke_z05=GetOwningPlayer(mhhke_z65)
call SetBlightRadiusLocBJ(mhhke_z25,mhhke_z05,mhhke_z95,mhhke_Z14Z)
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
set mhhke_z05=null
endfunction
function mhhke_Z15Z takes unit mhhke_z65,real mhhke_Z14Z returns nothing
call SetUnitFlyHeight(mhhke_z65,mhhke_Z14Z,.0)
endfunction
function mhhke_Z16Z takes nothing returns integer
local integer mhhke_Z17Z=0
local integer mhhke_Z18Z=0
local integer array mhhke_Z19Z
local integer mhhke_z15=0
local player mhhke_z05=GetLocalPlayer()
loop
exitwhen mhhke_z15>11
set mhhke_Z19Z[mhhke_z15]=0
set mhhke_z15=mhhke_z15+1
endloop
loop
exitwhen mhhke_Z17Z>14
call StoreInteger(mhhke_z03,"Hke_Player","Hke_number",GetPlayerId(mhhke_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(mhhke_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set mhhke_Z18Z=GetStoredInteger(mhhke_z03,"Hke_Player","Hke_number")-1
set mhhke_Z19Z[mhhke_Z18Z]=mhhke_Z19Z[mhhke_Z18Z]+1
call FlushStoredMission(mhhke_z03,"Hke_Player")
set mhhke_Z17Z=mhhke_Z17Z+1
endloop
set mhhke_Z18Z=0
set mhhke_Z17Z=0
set mhhke_z05=null
loop
exitwhen mhhke_Z17Z>11
if mhhke_Z19Z[mhhke_Z18Z]<mhhke_Z19Z[mhhke_Z17Z]then
set mhhke_Z18Z=mhhke_Z17Z
endif
set mhhke_Z17Z=mhhke_Z17Z+1
endloop
return mhhke_Z18Z+1
endfunction
function mhhke_Z2ZZ takes unit mhhke_z65,integer mhhke_Z2zZ,boolean mhhke_z25 returns nothing
if(mhhke_z25)then
call UnitAddAbility(mhhke_z65,mhhke_Z2zZ)
call SetUnitAbilityLevel(mhhke_z65,mhhke_Z2zZ,100)
call UnitMakeAbilityPermanent(mhhke_z65,true,mhhke_Z2zZ)
else
call UnitMakeAbilityPermanent(mhhke_z65,false,mhhke_Z2zZ)
call UnitRemoveAbility(mhhke_z65,mhhke_Z2zZ)
endif
endfunction
function mhhke_Z20Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_Z2ZZ(mhhke_z65,mhhke_zzz,mhhke_z0z)
set mhhke_z65=null
endfunction
function mhhke_Z21Z takes integer mhhke_z15,integer mhhke_Z2zZ,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_zzz=mhhke_Z2zZ
set mhhke_z0z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z20Z)
else
call mhhke_Z2ZZ(mhhke_z7[mhhke_z15],mhhke_Z2zZ,mhhke_z25)
endif
endfunction
function mhhke_Z22Z takes string mhhke_Z11Z returns integer
if(mhhke_Z11Z=="mm")then
return 1094937907
endif
if(mhhke_Z11Z=="xj")then
return 1095659625
endif
if(mhhke_Z11Z=="zj")then
return 1095262824
endif
if(mhhke_Z11Z=="zm")then
return 1095721842
endif
if(mhhke_Z11Z=="ft")then
return 1096119411
endif
if(mhhke_Z11Z=="xx")then
return 1095333473
endif
if(mhhke_Z11Z=="sb")then
return 1095066998
endif
if(mhhke_Z11Z=="yx")then
return 1097886070
endif
if(mhhke_Z11Z=="rh")then
return 1095657827
endif
if(mhhke_Z11Z=="fl")then
return 1095656289
endif
if(mhhke_Z11Z=="bs")then
return 1094935923
endif
if(mhhke_Z11Z=="jg")then
return 1095332984
endif
if(mhhke_Z11Z=="jf")then
return 1095328816
endif
if(mhhke_Z11Z=="js")then
return 1095332728
endif
if(mhhke_Z11Z=="jm")then
return 1095332722
endif
if(mhhke_Z11Z=="jj")then
return 1095917932
endif
if(mhhke_Z11Z=="fy")then
return 1098150517
endif
if(mhhke_Z11Z=="ghh")then
return 1095262562
endif
if(mhhke_Z11Z=="ghj")then
return 1095721317
endif
if(mhhke_Z11Z=="gqj")then
return 1095065970
endif
if(mhhke_Z11Z=="gxx")then
return 1096114550
endif
if(mhhke_Z11Z=="gzz")then
return 1095262564
endif
if(mhhke_Z11Z=="gxe")then
return 1096114549
endif
if(mhhke_Z11Z=="gjj")then
return 1095065960
endif
if(mhhke_Z11Z=="gml")then
return 1094934883
endif
if(mhhke_Z11Z=="gyl")then
return 1097818482
endif
if(mhhke_Z11Z=="gjs")then
return 1096905580
endif
if(mhhke_Z11Z=="qhy")then
return 1095329378
endif
if(mhhke_Z11Z=="qdy")then
return 1095331938
endif
if(mhhke_Z11Z=="qlh")then
return 1095332719
endif
if(mhhke_Z11Z=="qyz")then
return 1095328878
endif
if(mhhke_Z11Z=="qbd")then
return 1095331682
endif
if(mhhke_Z11Z=="qfs")then
return 1095328610
endif
if(mhhke_Z11Z=="qsd")then
return 1095330924
endif
if(mhhke_Z11Z=="qjs")then
return 1095332706
endif
if(mhhke_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function mhhke_Z23Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call SetUnitInvulnerable(mhhke_z65,mhhke_z0z)
call mhhke_Z2ZZ(mhhke_z65,1098282348,mhhke_z0z)
set mhhke_z65=null
endfunction
function mhhke_Z24Z takes integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_z0z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z23Z)
else
call SetUnitInvulnerable(mhhke_z7[mhhke_z15],mhhke_z25)
call mhhke_Z2ZZ(mhhke_z7[mhhke_z15],1098282348,mhhke_z25)
endif
endfunction
function mhhke_Z25Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call SetUnitPathing(mhhke_z65,not(mhhke_z0z))
set mhhke_z65=null
endfunction
function mhhke_Z26Z takes integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_z0z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z25Z)
else
call SetUnitPathing(mhhke_z7[mhhke_z15],not(mhhke_z25))
endif
endfunction
function mhhke_Z27Z takes unit mhhke_z65,boolean mhhke_z25 returns nothing
if(mhhke_z25)then
call SetUnitMoveSpeed(mhhke_z65,1000)
else
call SetUnitMoveSpeed(mhhke_z65,GetUnitDefaultMoveSpeed(mhhke_z65))
endif
endfunction
function mhhke_Z28Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_Z27Z(mhhke_z65,mhhke_z0z)
set mhhke_z65=null
endfunction
function mhhke_Z29Z takes integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_z0z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z28Z)
else
call mhhke_Z27Z(mhhke_z7[mhhke_z15],mhhke_z25)
endif
endfunction
function mhhke_Z3ZZ takes integer mhhke_z15,boolean mhhke_z25 returns nothing
call mhhke_ZzzZ()
if(mhhke_Z0)then
if(mhhke_z25)then
if(CountUnitsInGroup(mhhke_z8Z)==0)then
call EnableTrigger(mhhke_z73)
endif
call GroupAddGroup(mhhke_Z8Z[mhhke_z15],mhhke_z8Z)
else
call GroupRemoveGroup(mhhke_Z8Z[mhhke_z15],mhhke_z8Z)
if(CountUnitsInGroup(mhhke_z8Z)==0)then
call DisableTrigger(mhhke_z73)
endif
endif
else
if(mhhke_z25)then
if(CountUnitsInGroup(mhhke_z8Z)==0)then
call EnableTrigger(mhhke_z73)
endif
call GroupAddUnit(mhhke_z8Z,mhhke_z7[mhhke_z15])
else
call GroupRemoveUnit(mhhke_z8Z,mhhke_z7[mhhke_z15])
if(CountUnitsInGroup(mhhke_z8Z)==0)then
call DisableTrigger(mhhke_z73)
endif
endif
endif
endfunction
function mhhke_Z3zZ takes unit mhhke_z65,boolean mhhke_z25 returns nothing
call mhhke_Z2ZZ(mhhke_z65,1095262562,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1095721317,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1095065970,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1096114550,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1095262564,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1096114549,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1094934883,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1095065960,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1097818482,mhhke_z25)
call mhhke_Z2ZZ(mhhke_z65,1096905580,mhhke_z25)
endfunction
function mhhke_Z30Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_Z3zZ(mhhke_z65,mhhke_z0z)
set mhhke_z65=null
endfunction
function mhhke_Z31Z takes integer mhhke_z15,boolean mhhke_z25 returns nothing
if(mhhke_Z0)then
set mhhke_z0z=mhhke_z25
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z30Z)
else
call mhhke_Z3zZ(mhhke_z7[mhhke_z15],mhhke_z25)
endif
endfunction
function mhhke_Z32Z takes unit mhhke_z65 returns nothing
call mhhke_Z2ZZ(mhhke_z65,1094937907,false)
call mhhke_Z2ZZ(mhhke_z65,1095659625,false)
call mhhke_Z2ZZ(mhhke_z65,1095262824,false)
call mhhke_Z2ZZ(mhhke_z65,1095721842,false)
call mhhke_Z2ZZ(mhhke_z65,1096119411,false)
call mhhke_Z2ZZ(mhhke_z65,1095333473,false)
call mhhke_Z2ZZ(mhhke_z65,1095066998,false)
call mhhke_Z2ZZ(mhhke_z65,1097886070,false)
call mhhke_Z2ZZ(mhhke_z65,1095657827,false)
call mhhke_Z2ZZ(mhhke_z65,1095656289,false)
call mhhke_Z2ZZ(mhhke_z65,1098282348,false)
call mhhke_Z2ZZ(mhhke_z65,1094935923,false)
call mhhke_Z2ZZ(mhhke_z65,1095332984,false)
call mhhke_Z2ZZ(mhhke_z65,1095328816,false)
call mhhke_Z2ZZ(mhhke_z65,1095332728,false)
call mhhke_Z2ZZ(mhhke_z65,1095332722,false)
call mhhke_Z2ZZ(mhhke_z65,1098150517,false)
call SetUnitInvulnerable(mhhke_z65,false)
call SetUnitPathing(mhhke_z65,true)
call mhhke_Z27Z(mhhke_z65,false)
call GroupRemoveUnit(mhhke_z8Z,mhhke_z65)
endfunction
function mhhke_Z33Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_Z32Z(mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_Z34Z takes integer mhhke_z15 returns nothing
if(mhhke_Z0)then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z33Z)
else
call mhhke_Z32Z(mhhke_z7[mhhke_z15])
endif
endfunction
function mhhke_Z35Z takes nothing returns nothing
local unit mhhke_z65=GetTriggerUnit()
local trigger mhhke_Z66=GetTriggeringTrigger()
call RemoveUnit(mhhke_z65)
call DisableTrigger(mhhke_Z66)
call DestroyTrigger(mhhke_Z66)
set mhhke_z65=null
set mhhke_Z66=null
endfunction
function mhhke_Z36Z takes integer mhhke_z66,unit mhhke_Z37Z,player mhhke_Z38Z returns nothing
local location mhhke_z95
local unit mhhke_z65
local integer mhhke_Z39Z=0
local integer mhhke_Z4ZZ=0
local trigger mhhke_Z66
if(mhhke_z66==0)then
set mhhke_Z39Z=1095726692
set mhhke_Z4ZZ=852503
endif
if(mhhke_z66==1)then
set mhhke_Z39Z=1095070833
set mhhke_Z4ZZ=852184
endif
if(mhhke_z66==2)then
set mhhke_Z39Z=1095070566
set mhhke_Z4ZZ=852183
endif
if((mhhke_Z39Z==0)and(mhhke_Z4ZZ==0))then
return
endif
set mhhke_z95=GetUnitLoc(mhhke_Z37Z)
set mhhke_z65=CreateUnitAtLoc(mhhke_Z38Z,1851941228,mhhke_z95,bj_UNIT_FACING)
call UnitAddAbility(mhhke_z65,1098282348)
call UnitAddAbility(mhhke_z65,mhhke_Z39Z)
call ShowUnit(mhhke_z65,false)
call SetUnitUseFood(mhhke_z65,false)
call SetUnitScale(mhhke_z65,.01,.01,.01)
call SetUnitState(mhhke_z65,UNIT_STATE_MANA,GetUnitState(mhhke_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(mhhke_z65,mhhke_Z4ZZ)
set mhhke_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(mhhke_Z66,mhhke_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(mhhke_Z66,mhhke_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(mhhke_Z66,function mhhke_Z35Z)
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
set mhhke_Z66=null
set mhhke_z65=null
endfunction
function mhhke_Z4zZ takes unit mhhke_Z37Z returns nothing
local player mhhke_z05=GetTriggerPlayer()
local location mhhke_z95=GetUnitLoc(mhhke_Z37Z)
local trigger mhhke_Z66=CreateTrigger()
local unit mhhke_z65=CreateUnitAtLoc(mhhke_z05,1751543663,mhhke_z95,bj_UNIT_FACING)
call UnitAddAbility(mhhke_z65,1098282348)
call UnitAddAbility(mhhke_z65,1095332709)
call ShowUnit(mhhke_z65,false)
call SetUnitUseFood(mhhke_z65,false)
call SetUnitScale(mhhke_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(mhhke_z65,852592,mhhke_z95)
call TriggerRegisterUnitEvent(mhhke_Z66,mhhke_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(mhhke_Z66,mhhke_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(mhhke_Z66,function mhhke_Z35Z)
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
set mhhke_Z66=null
set mhhke_z05=null
endfunction
function mhhke_Z40Z takes integer mhhke_z15,dialog mhhke_Z41Z,trigger mhhke_zZ6 returns nothing
set mhhke_Zz3[mhhke_z15]=mhhke_Z41Z
set mhhke_Z03[mhhke_z15]=mhhke_zZ6
endfunction
function mhhke_Z42Z takes integer mhhke_z15,string mhhke_Z43Z returns nothing
call DialogClear(mhhke_Zz3[mhhke_z15])
call DialogSetMessage(mhhke_Zz3[mhhke_z15],(mhhke_Z43Z+mhhke_Z0z+mhhke_Z62))
endfunction
function mhhke_Z44Z takes integer mhhke_z15,player mhhke_z05,boolean mhhke_z77 returns nothing
if(mhhke_z77)then
call EnableTrigger(mhhke_Z03[mhhke_z15])
call DialogDisplay(mhhke_z05,mhhke_Zz3[mhhke_z15],true)
call TimerStart(mhhke_Z73[mhhke_z15],mhhke_z1,false,null)
else
call DisableTrigger(mhhke_Z03[mhhke_z15])
call DialogDisplay(mhhke_z05,mhhke_Zz3[mhhke_z15],false)
endif
endfunction
function mhhke_Z45Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_zZ1[mhhke_z15],mhhke_ZZ1[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"主")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"资源菜单[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"自动化设置[B]",66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"选定单位特殊属性[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"个人选项设置[D]",68)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"帮助菜单[E]",69)
if(mhhke_z05==mhhke_z5)then
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"其他玩家作弊管理[F]",70)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"其他玩家管理[G]",71)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"游戏作弊选项[H]",72)
if(mhhke_z13)then
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z46Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local string mhhke_Z11Z
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Zz1[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"自动化设置")
if(IsTriggerEnabled(mhhke_z40[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(mhhke_z50[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(mhhke_z60[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(mhhke_z80[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(mhhke_z70[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(mhhke_z90[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"魔法释放后自动MP"+I2S(R2I(mhhke_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(mhhke_ZZ3[mhhke_z15]))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"生命低于"+I2S(R2I(mhhke_z92))+"%加到"+I2S(R2I(mhhke_z41))+"%[G]"),71)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"全部开启[O]",79)
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"全部关闭[U]",85)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z11Z=""
endfunction
function mhhke_Z47Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z01[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"选定单位特殊属性")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"无敌[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"永久隐形[B]",66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"穿越物体[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"魔免[D]",68)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"反隐形[E]",69)
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"移动速度[F]",70)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"各种光环[G]",71)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"换页[N]",78)
if((mhhke_z9Z)or(mhhke_z5==mhhke_z05))then
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"秒杀模式[K]",75)
endif
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"取消全部(不含光环)[U]",85)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z48Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_Z91[mhhke_z15],mhhke_Z81[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"选定单位特殊属性")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"永久献祭[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"闪避[B]",514)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"重击[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"致命一击[D]",68)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"反弹(小强的壳)[E]",69)
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"分裂攻击[F]",70)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"燃灰[G]",71)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"减少魔法伤害33%[H]",72)
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"闪避100%[I]",73)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"换页[N]",78)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z49Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_Z91[mhhke_z15],mhhke_Z21[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"光环")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"辉煌光环[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"荆棘光环[B]",66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"耐久光环[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"强击光环[D]",68)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"邪恶光环[E]",69)
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"吸血光环[F]",70)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"专注光环[G]",71)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"命令光环(战鼓)[H]",72)
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"医疗光环[I]",73)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"减速光环[J]",74)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"关所有光环[K]",75)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z5ZZ takes integer mhhke_z15,player mhhke_z05 returns nothing
local integer mhhke_Z75=0
local string mhhke_Z11Z
local string mhhke_Z5zZ
local player mhhke_Z65
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z51[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"玩家作弊管理")
loop
exitwhen mhhke_Z75>11
set mhhke_Z65=Player(mhhke_Z75)
if((GetPlayerController(mhhke_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(mhhke_Z65)==PLAYER_SLOT_STATE_PLAYING)and(mhhke_Z65!=mhhke_z5))then
set mhhke_Z5zZ=GetPlayerName(mhhke_Z65)
if(mhhke_z6[mhhke_Z75])then
set mhhke_Z11Z="禁止"
else
set mhhke_Z11Z="允许"
endif
set mhhke_ZzZ[mhhke_Z75]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+mhhke_Z5zZ+"作弊"),0)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z65=null
set mhhke_Z11Z=""
set mhhke_Z5zZ=""
endfunction
function mhhke_Z50Z takes integer mhhke_z15,player mhhke_z05 returns nothing
set mhhke_Z8[mhhke_z15]=0
call mhhke_Z40Z(mhhke_z15,mhhke_zZ1[mhhke_z15],mhhke_Z71[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"单位")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"升100级[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("加三围"+(I2S(mhhke_Z3)+"[B]")),66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"复制物品[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"复制单位[D]",68)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"掉身上物品[E]",69)
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"共享该单位视野[F]",70)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"特殊属性菜单[G]",71)
if((mhhke_z7Z)or(mhhke_z5==mhhke_z05))then
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"控制它[H]",72)
endif
if(mhhke_z5==mhhke_z05)then
endif
if(mhhke_z05==mhhke_z5)then
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"改变单位所有者[J]",74)
endif
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z51Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local string mhhke_Z11Z
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z31[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"游戏作弊选项")
if(mhhke_Z0)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"操作所有单位[A]"),65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("设置背包数[B]"),66)
if(mhhke_Z5Z)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"保护CheatMaster[C]"),67)
if(mhhke_Z6Z)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(mhhke_Z7Z)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("取消作弊时"+mhhke_Z11Z+"地图全开[E]"),69)
if(mhhke_z9Z)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"他人秒杀模式[F]"),70)
if(mhhke_ZZz)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"禁止秒杀建筑[G]"),71)
if(mhhke_z7Z)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"他人占据单位[H]"),72)
if(mhhke_Z52)then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"禁止克隆操作农民[I]"),73)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z11Z=""
endfunction
function mhhke_Z52Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local string mhhke_Z5zZ
local integer mhhke_Z75=0
local player mhhke_Z65
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z41[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"玩家管理")
loop
exitwhen mhhke_Z75>11
set mhhke_Z65=Player(mhhke_Z75)
if(GetPlayerSlotState(mhhke_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set mhhke_Z5zZ=GetPlayerName(mhhke_Z65)
set mhhke_ZzZ[mhhke_Z75]=DialogAddButton(mhhke_Zz3[mhhke_z15],("选择"+mhhke_Z5zZ+"操作"),0)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_ZzZ[12]=DialogAddButton(mhhke_Zz3[mhhke_z15],("选择中立生物操作"),90)
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z5zZ=""
set mhhke_Z65=null
endfunction
function mhhke_Z53Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local player mhhke_Z65=Player(mhhke_Z5z)
call mhhke_Z40Z(mhhke_z15,mhhke_Z91[mhhke_z15],mhhke_Z61[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"玩家管理")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"资源管理[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"向他收税黄金"+I2S(mhhke_z22)+"%[C]",67)
else
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"向他收税木材"+I2S(mhhke_z22)+"%[D]",68)
else
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"停止向他收木材[D]",67)
endif
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回选择菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z65=null
endfunction
function mhhke_Z54Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local integer mhhke_Z75=0
local player mhhke_Z65
local string mhhke_Z11Z
local string mhhke_Z5zZ
call mhhke_Z40Z(mhhke_z15,mhhke_Z91[mhhke_z15],mhhke_Z11[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"选定单位控制")
loop
exitwhen mhhke_Z75>12
set mhhke_Z65=Player(mhhke_Z75)
if(GetPlayerSlotState(mhhke_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set mhhke_Z5zZ=GetPlayerName(mhhke_Z65)
set mhhke_ZzZ[mhhke_Z75]=DialogAddButton(mhhke_Zz3[mhhke_z15],("给"+mhhke_Z5zZ+"控制"),0)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回单位菜单[R]",82)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z65=null
set mhhke_Z11Z=""
set mhhke_Z5zZ=""
endfunction
function mhhke_Z55Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local string mhhke_Z11Z
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Zz2[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"资源设置")
if(mhhke_z1Z[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="打开"
endif
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"地图[A]"),65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("复活死亡英雄[B]"),66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"人口清5[B]",66)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"总人口100[C]",67)
if(GetPlayerHandicap(mhhke_z05)==2)then
set mhhke_Z11Z="恢复生命障碍100%"
else
set mhhke_Z11Z="200%生命"
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(mhhke_z05)==2)then
set mhhke_Z11Z="恢复普通经验率"
else
set mhhke_Z11Z="2倍经验"
endif
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"[E]",69)
set mhhke_Z11Z=I2S(mhhke_Z2)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("加"+mhhke_Z11Z+"钱[F]"),70)
set mhhke_Z11Z=I2S(mhhke_z2)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("加"+mhhke_Z11Z+"木[G]"),71)
set mhhke_Z11Z=I2S(mhhke_Z2)
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("减"+mhhke_Z11Z+"钱[H]"),72)
set mhhke_Z11Z=I2S(mhhke_z2)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("减"+mhhke_Z11Z+"木[I]"),73)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z11Z=""
endfunction
function mhhke_Z56Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local player mhhke_Z65=Player(mhhke_Z5z)
local string mhhke_Z11Z
local string mhhke_Z5zZ=GetPlayerName(mhhke_Z65)
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z02[mhhke_z15])
call DialogClear(mhhke_Z20[mhhke_z15])
call DialogSetMessage(mhhke_Z20[mhhke_z15],(mhhke_Z5zZ+"钱"+I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(mhhke_z1Z[mhhke_Z5z])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="打开"
endif
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],(mhhke_Z11Z+"地图[A]"),65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("复活死亡英雄[B]"),66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"人口清5[B]",66)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"总人口100[C]",67)
if(GetPlayerHandicap(mhhke_Z65)==2)then
set mhhke_Z11Z="恢复生命障碍100%"
else
set mhhke_Z11Z="200%生命"
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(mhhke_Z65)==2)then
set mhhke_Z11Z="恢复普通经验率"
else
set mhhke_Z11Z="2倍经验"
endif
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"[E]",69)
set mhhke_Z11Z=I2S(mhhke_Z2)
set mhhke_z7z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("加"+mhhke_Z11Z+"钱[F]"),70)
set mhhke_Z11Z=I2S(mhhke_z2)
set mhhke_z6z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("加"+mhhke_Z11Z+"木[G]"),71)
set mhhke_Z11Z=I2S(mhhke_Z2)
set mhhke_Zz0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("减"+mhhke_Z11Z+"钱[H]"),72)
set mhhke_Z11Z=I2S(mhhke_z2)
set mhhke_ZZ0[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("减"+mhhke_Z11Z+"木[I]"),73)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z11Z=""
set mhhke_Z5zZ=""
set mhhke_Z65=null
endfunction
function mhhke_Z57Z takes integer mhhke_z15,player mhhke_z05 returns nothing
local player mhhke_Z65=Player(mhhke_Z5z)
local string mhhke_Z11Z
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z12[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"同盟管理")
if(IsPlayerAlly(mhhke_Z65,mhhke_z5))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("强制"+mhhke_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(mhhke_Z65,mhhke_z5))then
if(GetPlayerAlliance(mhhke_Z65,mhhke_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("强制"+mhhke_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(mhhke_Z65,mhhke_z5,ALLIANCE_SHARED_XP))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("强制"+mhhke_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(mhhke_z5,mhhke_Z65))then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],("强制"+mhhke_Z11Z+"对其同盟[D]"),68)
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回玩家菜单[R]",82)
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z65=null
set mhhke_Z11Z=""
endfunction
function mhhke_Z58Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_Z91[mhhke_z15],mhhke_Z22[mhhke_z15])
call DialogClear(mhhke_Z91[mhhke_z15])
call DialogSetMessage(mhhke_Z91[mhhke_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(mhhke_z61)+"|r个")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"设置1个背包[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"设置2个背包[B]",66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"设置3个背包[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回选设置单[R]",82)
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z59Z takes integer mhhke_z15,player mhhke_z05 returns nothing
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z23[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"帮助")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"键盘帮助[A]",65)
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"CMD帮助[B]",66)
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"CMD单位类帮助[C]",67)
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"显示玩家信息[D]",68)
if(mhhke_z05==mhhke_z5)then
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"显示设置信息[E]",69)
endif
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
endfunction
function mhhke_Z6ZZ takes integer mhhke_z15,player mhhke_z05 returns nothing
local string mhhke_Z11Z
call mhhke_Z40Z(mhhke_z15,mhhke_Z20[mhhke_z15],mhhke_Z13[mhhke_z15])
call mhhke_Z42Z(mhhke_z15,"个人选项")
set mhhke_z2z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"删除我的复制单位[A]",65)
if(mhhke_z31[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z4z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"克隆操作[B]",66)
if(mhhke_Z33[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z5z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"组队克隆操作[C]",67)
if(mhhke_Z53[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z3z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"隐藏加攻[D]",68)
if(mhhke_Z63[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z9z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"隐藏加攻带溅射[E]",69)
if(mhhke_Z43[mhhke_z15])then
set mhhke_Z11Z="关闭"
else
set mhhke_Z11Z="开启"
endif
set mhhke_z8z[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],mhhke_Z11Z+"远程沉默[F]",70)
set mhhke_Z00[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"回主菜单[R]",82)
set mhhke_Z10[mhhke_z15]=DialogAddButton(mhhke_Zz3[mhhke_z15],"退出菜单[X]",88)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,true)
set mhhke_Z11Z=""
endfunction
function mhhke_Z6zZ takes player mhhke_z05 returns nothing
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"欢迎使用|cFFFF8C00mhhke的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function mhhke_Z60Z takes player mhhke_z05 returns nothing
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"欢迎使用|cFFFF8C00mhhke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(mhhke_z05==mhhke_z5)then
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function mhhke_Z61Z takes player mhhke_z05 returns nothing
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"欢迎使用|cFFFF8C00mhhke的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(mhhke_z05==mhhke_z5)then
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function mhhke_Z62Z takes player mhhke_z05 returns nothing
local integer mhhke_Z75
local player mhhke_Z65
local string mhhke_Z11Z
local string mhhke_Z63Z
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,"|CFFFF0000mhhke1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set mhhke_Z75=1
loop
exitwhen mhhke_Z75>12
set mhhke_Z65=Player(mhhke_Z75-1)
if(GetPlayerSlotState(mhhke_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set mhhke_Z63Z=I2S(mhhke_Z75)
set mhhke_Z11Z=(GetPlayerName(mhhke_Z65)+":编号:"+mhhke_Z63Z)
set mhhke_Z63Z=I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_GOLD))
set mhhke_Z11Z=(mhhke_Z11Z+" |CFFFFFF00黄金:"+mhhke_Z63Z+"|R")
set mhhke_Z63Z=I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set mhhke_Z11Z=(mhhke_Z11Z+" |CFF008000木头:"+mhhke_Z63Z+"|R")
set mhhke_Z63Z=I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set mhhke_Z11Z=(mhhke_Z11Z+" 人口:"+mhhke_Z63Z)
set mhhke_Z63Z=I2S(GetPlayerState(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set mhhke_Z11Z=(mhhke_Z11Z+"/"+mhhke_Z63Z)
set mhhke_Z11Z=mhhke_Z11Z+" 作弊:"
if(mhhke_z6[mhhke_Z75-1])then
set mhhke_Z11Z=mhhke_Z11Z+"|cFF00FF33√|r"
else
set mhhke_Z11Z=mhhke_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(mhhke_Z65)==MAP_CONTROL_USER)then
set mhhke_Z11Z=mhhke_Z11Z+" (玩家)"
if(mhhke_Z75-1==mhhke_zz3)then
set mhhke_Z11Z=mhhke_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set mhhke_Z11Z=mhhke_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,mhhke_Z11Z)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z65=null
set mhhke_Z11Z=""
set mhhke_Z63Z=""
endfunction
function mhhke_Z64Z takes nothing returns nothing
local string mhhke_Z65Z
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,"|CFFFF0000mhhke1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set mhhke_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(mhhke_z4Z)
set mhhke_Z65Z=mhhke_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(mhhke_z5Z)
set mhhke_Z65Z=mhhke_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(mhhke_z6Z)
set mhhke_Z65Z=mhhke_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(mhhke_ZZZ))
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
set mhhke_Z65Z=mhhke_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(mhhke_z41))
set mhhke_Z65Z=mhhke_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(mhhke_z92))
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
set mhhke_Z65Z=mhhke_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(mhhke_zZ)
set mhhke_Z65Z=mhhke_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(mhhke_Zz)
set mhhke_Z65Z=mhhke_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(mhhke_zz110)
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
set mhhke_Z65Z=mhhke_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(mhhke_Z2)
set mhhke_Z65Z=mhhke_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(mhhke_z2)
set mhhke_Z65Z=mhhke_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(mhhke_Z3)
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
set mhhke_Z65Z=mhhke_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(mhhke_z61)
set mhhke_Z65Z=mhhke_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(mhhke_Z1))
set mhhke_Z65Z=mhhke_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(mhhke_z1))
set mhhke_Z65Z=mhhke_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(mhhke_z42))
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
set mhhke_Z65Z=mhhke_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(mhhke_z22)
set mhhke_Z65Z=mhhke_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(mhhke_z3))
set mhhke_Z65Z=mhhke_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(mhhke_Z4))
call DisplayTimedTextToPlayer(mhhke_z5,0,0,mhhke_Z1,mhhke_Z65Z)
set mhhke_Z65Z=""
endfunction
function mhhke_Z66Z takes player mhhke_z05,unit mhhke_z65 returns nothing
local string mhhke_Z11Z=mhhke_Z09Z(mhhke_z65)
set mhhke_Z11Z="该单位的ID为|cFF33FF00"+mhhke_Z11Z+"|r"
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,mhhke_Z11Z)
set mhhke_Z11Z=""
endfunction
function mhhke_Z67Z takes player mhhke_z05,unit mhhke_z65 returns nothing
local string mhhke_Z11Z=mhhke_Z1ZZ(mhhke_z65)
set mhhke_Z11Z="该单位的第一格物品ID为|cFF33FF00"+mhhke_Z11Z+"|r"
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,mhhke_Z11Z)
set mhhke_Z11Z=""
endfunction
function mhhke_Z68Z takes integer mhhke_z15 returns nothing
local unit mhhke_z65=mhhke_z7[mhhke_z15]
local player mhhke_z05=Player(mhhke_z15)
local item mhhke_z86
local integer mhhke_Z75=0
local string mhhke_Z11Z
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"mhhke Unit Debug Info:")
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"单位X坐标:"+R2S(GetUnitX(mhhke_z65))+" 单位Y坐标:"+R2S(GetUnitY(mhhke_z65)))
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,"单位ID:"+mhhke_Z09Z(mhhke_z65))
if(IsUnitType(mhhke_z65,UNIT_TYPE_HERO))then
set mhhke_Z11Z="单位物品ID:"
loop
exitwhen mhhke_Z75>5
set mhhke_z86=UnitItemInSlot(mhhke_z65,mhhke_Z75)
set mhhke_Z11Z=mhhke_Z11Z+mhhke_Z05Z(GetItemTypeId(mhhke_z86))+" "
set mhhke_Z75=mhhke_Z75+1
endloop
call DisplayTimedTextToPlayer(mhhke_z05,0,0,mhhke_Z1,mhhke_Z11Z)
set mhhke_Z11Z=""
set mhhke_z86=null
endif
set mhhke_z65=null
set mhhke_z05=null
endfunction
function mhhke_Z69Z takes nothing returns nothing
if(mhhke_z0)then
set mhhke_Z62="主机版"
else
set mhhke_Z62="标准版"
endif
set mhhke_Z62=mhhke_Z62+" (添加 By |cFFFF0000"+mhhke_ZZ+"|r)"
if(mhhke_Z4Z=="")then
else
set mhhke_Z62=mhhke_Z62+"|n"+mhhke_Z4Z
endif
endfunction
function mhhke_Z7ZZ takes nothing returns nothing
local trigger mhhke_Z66=GetTriggeringTrigger()
local timer mhhke_Z76=GetExpiredTimer()
call DestroyTrigger(mhhke_Z66)
call DestroyTimer(mhhke_Z76)
set mhhke_z0=false
set mhhke_Z66=null
set mhhke_Z76=null
endfunction
function mhhke_Z7zZ takes nothing returns nothing
local timer mhhke_Z76
local trigger mhhke_Z66
set mhhke_z03=InitGameCache("WuHansen.Com")
set mhhke_zz3=mhhke_Z16Z()-1
if(mhhke_z0)then
set mhhke_Z76=CreateTimer()
set mhhke_Z66=CreateTrigger()
call TriggerAddAction(mhhke_Z66,function mhhke_Z7ZZ)
call TriggerRegisterTimerExpireEvent(mhhke_Z66,mhhke_Z76)
call TimerStart(mhhke_Z76,9.99,false,null)
set mhhke_Z76=null
set mhhke_Z66=null
endif
endfunction
function mhhke_Z70Z takes nothing returns nothing
local integer mhhke_z15=0
local timer mhhke_Z76=GetExpiredTimer()
local player mhhke_z05
loop
exitwhen mhhke_z15>11
if(mhhke_Z76==mhhke_Z73[mhhke_z15])then
set mhhke_z05=Player(mhhke_z15)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
set mhhke_z05=null
endif
set mhhke_z15=mhhke_z15+1
endloop
set mhhke_Z76=null
endfunction
function mhhke_Z71Z takes nothing returns nothing
local trigger mhhke_Z66=GetTriggeringTrigger()
call TriggerExecute(mhhke_Z66)
set mhhke_Z66=null
endfunction
function mhhke_Z72Z takes nothing returns nothing
local timer mhhke_Z66=CreateTimer()
local trigger mhhke_ZZ6Z=CreateTrigger()
call TriggerAddAction(mhhke_ZZ6Z,function mhhke_Z71Z)
call TriggerRegisterTimerExpireEvent(mhhke_ZZ6Z,mhhke_Z66)
call TimerStart(mhhke_Z66,GetRandomReal(299,1092),false,null)
endfunction
function mhhke_Z73Z takes nothing returns boolean
if(StringLength(mhhke_Z0z)==152)then
else
call mhhke_Z72Z()
endif
call TriggerClearConditions(mhhke_z43)
return true
endfunction
function mhhke_Z74Z takes nothing returns nothing
local integer mhhke_z15=0
local timer mhhke_Z76=GetExpiredTimer()
loop
exitwhen mhhke_z15>11
if(mhhke_Z76==mhhke_z0Z[mhhke_z15])then
set mhhke_Z7[mhhke_z15]=false
set mhhke_Z8[mhhke_z15]=0
set mhhke_Z32[mhhke_z15]=0
endif
set mhhke_z15=mhhke_z15+1
endloop
set mhhke_Z76=null
endfunction
function mhhke_Z75Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call UnitAddAbility(mhhke_z65,1095331446)
set mhhke_z65=null
endfunction
function mhhke_Z76Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call UnitRemoveAbility(mhhke_z65,1095331446)
set mhhke_z65=null
endfunction
function mhhke_Z77Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call UnitPauseTimedLife(mhhke_z65,true)
set mhhke_z65=null
endfunction
function mhhke_Z78Z takes nothing returns nothing
local unit mhhke_z65
set mhhke_z65=GetEnumUnit()
call UnitPauseTimedLife(mhhke_z65,false)
set mhhke_z65=null
endfunction
function mhhke_Z79Z takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_Z75
local real mhhke_Z14Z
local player mhhke_z05
local player mhhke_Z65
local string mhhke_Z11Z
local string mhhke_Z63Z
local string mhhke_Z5zZ
local string mhhke_Z65Z
local force mhhke_Z8ZZ
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_Z63Z=GetEventPlayerChatString()
set mhhke_Z63Z=StringCase(mhhke_Z63Z,false)
if(mhhke_z4)then
if(mhhke_z6[mhhke_z15])then
if(SubStringBJ(mhhke_Z63Z,1,1)=="-")then
if(mhhke_Z63Z=="-list")then
call mhhke_Z62Z(mhhke_z05)
endif
if(mhhke_Z63Z=="-h")then
call mhhke_Z6zZ(mhhke_z05)
endif
if(mhhke_Z63Z=="-c")then
call mhhke_Z60Z(mhhke_z05)
endif
if(mhhke_Z63Z=="-mm")then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_Z63Z=="-lx")then
set mhhke_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(mhhke_Z63Z,2,3)=="lt")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
call mhhke_Zz6(S2I(mhhke_Z11Z))
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,7,200)
if(SubStringBJ(mhhke_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,mhhke_Z1,GetPlayerName(mhhke_z05)+":"+mhhke_Z72+mhhke_Z11Z)
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="+")then
set mhhke_Z8ZZ=mhhke_z14(mhhke_z05)
call DisplayTimedTextToForce(mhhke_Z8ZZ,mhhke_Z1,GetPlayerName(mhhke_z05)+":"+mhhke_Z72+mhhke_Z11Z)
call DestroyForce(mhhke_Z8ZZ)
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
set mhhke_Z8ZZ=mhhke_z24(mhhke_z05)
call DisplayTimedTextToForce(mhhke_Z8ZZ,mhhke_Z1,GetPlayerName(mhhke_z05)+":"+mhhke_Z72+mhhke_Z11Z)
call DestroyForce(mhhke_Z8ZZ)
endif
set mhhke_Z8ZZ=null
endif
if(SubStringBJ(mhhke_Z63Z,2,3)=="zd")then
if((mhhke_z32)or(mhhke_z05==mhhke_z5))then
call mhhke_Z86()
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="k")then
if(SubStringBJ(mhhke_Z63Z,3,3)=="l")then
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
set mhhke_z31[mhhke_z15]=false
else
if(SubStringBJ(mhhke_Z63Z,4,4)=="+")then
set mhhke_z31[mhhke_z15]=true
endif
endif
else
if(SubStringBJ(mhhke_Z63Z,3,3)=="-")then
call mhhke_z07(mhhke_z15,false)
else
call mhhke_z07(mhhke_z15,true)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="j")then
if(SubStringBJ(mhhke_Z63Z,3,4)=="wd")then
call mhhke_Z36Z(0,mhhke_z7[mhhke_z15],mhhke_z05)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="nj")then
call mhhke_Z36Z(1,mhhke_z7[mhhke_z15],mhhke_z05)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="lx")then
call mhhke_Z36Z(2,mhhke_z7[mhhke_z15],mhhke_z05)
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="r")then
if(SubStringBJ(mhhke_Z63Z,3,3)=="n")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,20)
if(mhhke_Z11Z!="")then
call SetPlayerName(mhhke_z05,mhhke_Z11Z)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="h")then
if(SubStringBJ(mhhke_Z63Z,4,4)=="+")then
call mhhke_zZ7(mhhke_z15,mhhke_z05,true)
else
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_zZ7(mhhke_z15,mhhke_z05,false)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="m")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="-")then
call mhhke_zz5(mhhke_z05,mhhke_Z75,false)
else
call mhhke_zz5(mhhke_z05,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="w")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="-")then
call mhhke_z35(mhhke_z05,mhhke_Z75,false)
else
call mhhke_z35(mhhke_z05,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="p ")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED,mhhke_Z75)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="pm")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,20))
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,mhhke_Z75)
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="p")then
if(SubStringBJ(mhhke_Z63Z,3,3)=="+")then
call PauseUnit(mhhke_z7[mhhke_z15],true)
else
if(SubStringBJ(mhhke_Z63Z,3,3)=="-")then
call PauseUnit(mhhke_z7[mhhke_z15],false)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="h")then
if(SubStringBJ(mhhke_Z63Z,3,4)=="dw")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call mhhke_ZZ4Z(mhhke_z15)
else
call mhhke_ZZ3Z(mhhke_z7[mhhke_z15])
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="sj")then
if(mhhke_z05==mhhke_z5)then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
if mhhke_Z11Z=="-"then
call SuspendHeroXPBJ(false,mhhke_z7[mhhke_z15])
else
call SuspendHeroXPBJ(true,mhhke_z7[mhhke_z15])
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="e")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if mhhke_Z11Z=="-"then
call SetHeroXP(mhhke_z7[mhhke_z15],GetHeroXP(mhhke_z7[mhhke_z15])-mhhke_Z75,false)
else
call SetHeroXP(mhhke_z7[mhhke_z15],GetHeroXP(mhhke_z7[mhhke_z15])+mhhke_Z75,false)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="j")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if mhhke_Z11Z=="-"then
call ModifyHeroSkillPoints(mhhke_z7[mhhke_z15],1,mhhke_Z75)
else
if mhhke_Z11Z=="+"then
call ModifyHeroSkillPoints(mhhke_z7[mhhke_z15],0,mhhke_Z75)
else
call ModifyHeroSkillPoints(mhhke_z7[mhhke_z15],2,mhhke_Z75)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="u")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
if mhhke_Z75==0 then
set mhhke_Z75=1
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_Zz9Z(mhhke_z15,mhhke_Z75,false)
else
call mhhke_Zz9Z(mhhke_z15,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="l")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_zz110
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_Zz3Z(mhhke_z15,0,mhhke_Z75,false)
else
call mhhke_Zz3Z(mhhke_z15,0,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="m")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_zz110
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_Zz3Z(mhhke_z15,1,mhhke_Z75,false)
else
call mhhke_Zz3Z(mhhke_z15,1,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="z")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_zz110
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_Zz3Z(mhhke_z15,2,mhhke_Z75,false)
else
call mhhke_Zz3Z(mhhke_z15,2,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="a")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,5,20))
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_zz110
endif
if(SubStringBJ(mhhke_Z63Z,4,4)=="-")then
call mhhke_Zz3Z(mhhke_z15,0,mhhke_Z75,false)
call mhhke_Zz3Z(mhhke_z15,1,mhhke_Z75,false)
call mhhke_Zz3Z(mhhke_z15,2,mhhke_Z75,false)
else
call mhhke_Zz3Z(mhhke_z15,0,mhhke_Z75,true)
call mhhke_Zz3Z(mhhke_z15,1,mhhke_Z75,true)
call mhhke_Zz3Z(mhhke_z15,2,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="r")then
call mhhke_Zz1Z(mhhke_z05)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="fz")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call mhhke_z98(mhhke_z15,true)
else
call mhhke_z98(mhhke_z15,false)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="db")then
call mhhke_ZZ5Z(mhhke_z15)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cw")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,20))
call mhhke_ZZ7Z(mhhke_z15,mhhke_Z75)
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="a")then
if(SubStringBJ(mhhke_Z63Z,3,3)=="m")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z40[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z40[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="w")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z50[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z50[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="p")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z60[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z60[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cd")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z80[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z80[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="mp")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z90[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z90[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="rs")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
if(mhhke_Z11Z=="-")then
call mhhke_zz6(mhhke_z70[mhhke_z15],false)
else
call mhhke_zz6(mhhke_z70[mhhke_z15],true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="a")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,4,4)
if(mhhke_Z11Z=="+")then
call mhhke_z16(mhhke_z15,true)
else
if(mhhke_Z11Z=="-")then
call mhhke_z16(mhhke_z15,false)
endif
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,2)=="u")then
if(mhhke_Z63Z=="-u")then
call mhhke_Z61Z(mhhke_z05)
else
if(SubStringBJ(mhhke_Z63Z,3,3)=="g")then
set mhhke_Z75=mhhke_Z22Z(SubStringBJ(mhhke_Z63Z,3,5))
if(mhhke_Z75==0)then
else
if(SubStringBJ(mhhke_Z63Z,6,6)=="-")then
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,false)
else
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,4,5)=="ca")then
call mhhke_Z31Z(mhhke_z15,false)
endif
if(SubStringBJ(mhhke_Z63Z,4,5)=="oa")then
call mhhke_Z31Z(mhhke_z15,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,3)=="q")then
set mhhke_Z75=mhhke_Z22Z(SubStringBJ(mhhke_Z63Z,3,5))
if(mhhke_Z75==0)then
else
if(SubStringBJ(mhhke_Z63Z,6,6)=="-")then
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,false)
else
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,true)
endif
endif
endif
set mhhke_Z75=mhhke_Z22Z(SubStringBJ(mhhke_Z63Z,3,4))
if(mhhke_Z75==0)then
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,false)
else
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cq")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z26Z(mhhke_z15,false)
else
call mhhke_Z26Z(mhhke_z15,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="wd")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z24Z(mhhke_z15,false)
else
call mhhke_Z24Z(mhhke_z15,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="hp")then
set mhhke_Z14Z=S2R(SubStringBJ(mhhke_Z63Z,6,8))
if(mhhke_Z14Z<=100)then
call SetUnitLifePercentBJ(mhhke_z7[mhhke_z15],100-mhhke_Z14Z)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="mp")then
set mhhke_Z14Z=S2R(SubStringBJ(mhhke_Z63Z,6,8))
if(mhhke_Z14Z<=100)then
call SetUnitManaPercentBJ(mhhke_z7[mhhke_z15],100-mhhke_Z14Z)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="lt")then
call mhhke_Z16(S2I(SubStringBJ(mhhke_Z63Z,6,6)),mhhke_z7[mhhke_z15],SubStringBJ(mhhke_Z63Z,8,200))
endif
if((SubStringBJ(mhhke_Z63Z,3,4)=="kz")and((mhhke_z7Z)or(mhhke_z05==mhhke_z5)))then
set mhhke_Z65=mhhke_z05
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,20))
if(mhhke_Z75==0)then
else
if(mhhke_z05==mhhke_z5)then
set mhhke_Z65=Player(mhhke_Z75-1)
endif
endif
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call SetUnitOwner(mhhke_z7[mhhke_z15],mhhke_Z65,false)
else
call SetUnitOwner(mhhke_z7[mhhke_z15],mhhke_Z65,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ys")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z29Z(mhhke_z15,false)
else
call mhhke_Z29Z(mhhke_z15,true)
endif
endif
if((SubStringBJ(mhhke_Z63Z,3,4)=="ms")and((mhhke_z9Z)or(mhhke_z05==mhhke_z5)))then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z3ZZ(mhhke_z15,false)
else
call mhhke_Z3ZZ(mhhke_z15,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ca")then
call mhhke_Z34Z(mhhke_z15)
endif
if((SubStringBJ(mhhke_Z63Z,3,4)=="jk")and(mhhke_z05==mhhke_z5))then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,20))
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z87(mhhke_z7[mhhke_z15],mhhke_Z75,false)
else
call mhhke_Z87(mhhke_z7[mhhke_z15],mhhke_Z75,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="yd")then
call mhhke_z55(mhhke_z51[mhhke_z15],mhhke_z7[mhhke_z15],false)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="jh")then
call mhhke_z55(mhhke_z7[mhhke_z15],mhhke_z51[mhhke_z15],true)
endif
if(SubStringBJ(mhhke_Z63Z,3,5)=="del")then
if(SubStringBJ(mhhke_Z63Z,6,6)=="+")then
call mhhke_z36(mhhke_z05)
if(mhhke_z05==mhhke_z5)then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,7,8))
if((mhhke_Z75>0)and(mhhke_Z75<13))then
set mhhke_Z75=mhhke_Z75-1
set mhhke_Z65=Player(mhhke_Z75)
call mhhke_z36(mhhke_Z65)
endif
endif
else
call RemoveUnit(mhhke_z7[mhhke_z15])
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="nm")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,6))
if(mhhke_Z75==1)then
call mhhke_Z37(1752196449,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
if(mhhke_Z75==2)then
call mhhke_Z37(1869636975,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
if(mhhke_Z75==3)then
call mhhke_Z37(1702327152,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
if(mhhke_Z75==4)then
call mhhke_Z37(1969316719,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
if(mhhke_Z75==5)then
call mhhke_Z37(1852665957,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cu")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="?")then
call mhhke_Z66Z(mhhke_z05,mhhke_z7[mhhke_z15])
else
set mhhke_Z65Z=SubStringBJ(mhhke_Z63Z,6,20)
set mhhke_Z75=UnitId(mhhke_Z65Z)
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_Z1zZ(6)
endif
call mhhke_Z37(mhhke_Z75,mhhke_z05,mhhke_Z9Z[mhhke_z15])
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ci")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="?")then
call mhhke_Z67Z(mhhke_z05,mhhke_z7[mhhke_z15])
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call mhhke_Z12Z(mhhke_z7[mhhke_z15],6,false)
else
call mhhke_Z12Z(mhhke_z7[mhhke_z15],6,true)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ua")then
set mhhke_Z75=mhhke_Z1zZ(6)
if(mhhke_Z75==0)then
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,false)
else
call mhhke_Z21Z(mhhke_z15,mhhke_Z75,true)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="st")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,6,20)
if(mhhke_Z11Z=="")then
call CreateCorpse(mhhke_z05,GetUnitTypeId(mhhke_z7[mhhke_z15]),GetUnitX(mhhke_z7[mhhke_z15]),GetUnitY(mhhke_z7[mhhke_z15]),0)
else
call CreateCorpse(mhhke_z05,mhhke_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(mhhke_z7[mhhke_z15]),GetUnitY(mhhke_z7[mhhke_z15]),0)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,6)=="size")then
set mhhke_Z14Z=S2R(SubStringBJ(mhhke_Z63Z,8,10))
if(mhhke_Z14Z==0)then
set mhhke_Z14Z=100
endif
call SetUnitScalePercent(mhhke_z7[mhhke_z15],mhhke_Z14Z,mhhke_Z14Z,mhhke_Z14Z)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(mhhke_z7[mhhke_z15],S2R(SubStringBJ(mhhke_Z63Z,6,8)),S2R(SubStringBJ(mhhke_Z63Z,10,12)),S2R(SubStringBJ(mhhke_Z63Z,14,16)),S2R(SubStringBJ(mhhke_Z63Z,18,20)))
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cl")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z18)
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z28)
else
call mhhke_z97(mhhke_z7[mhhke_z15],S2I(SubStringBJ(mhhke_Z63Z,6,6)),S2I(SubStringBJ(mhhke_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,5)=="inf")then
call mhhke_Z68Z(mhhke_z15)
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="sp")then
call MoveLocation(mhhke_Z9Z[mhhke_z15],GetUnitX(mhhke_z7[mhhke_z15]),GetUnitY(mhhke_z7[mhhke_z15]))
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="fz")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,20))
if(mhhke_Z75==0)then
set mhhke_Z75=1
endif
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
set mhhke_Z65=GetOwningPlayer(mhhke_z7[mhhke_z15])
call mhhke_Z77(mhhke_z7[mhhke_z15],mhhke_Z65,mhhke_Z75)
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z47(mhhke_z7[mhhke_z15],mhhke_z05,mhhke_Z75,true)
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="h")then
call mhhke_z56(mhhke_z7[mhhke_z15],mhhke_z05)
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="d")then
if(GetUnitUserData(mhhke_z7[mhhke_z15])==2176)then
call SetUnitUserData(mhhke_z7[mhhke_z15],0)
endif
else
call mhhke_Z77(mhhke_z7[mhhke_z15],mhhke_z05,mhhke_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="hw")then
set mhhke_Z14Z=S2R(SubStringBJ(mhhke_Z63Z,6,8))
if(mhhke_Z14Z==0)then
set mhhke_Z14Z=500
endif
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z13Z(mhhke_z7[mhhke_z15],mhhke_Z14Z,false)
else
call mhhke_Z13Z(mhhke_z7[mhhke_z15],mhhke_Z14Z,true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="fg")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call mhhke_Z15Z(mhhke_z7[mhhke_z15],GetUnitDefaultFlyHeight(mhhke_z7[mhhke_z15]))
else
call mhhke_Z15Z(mhhke_z7[mhhke_z15],S2R(SubStringBJ(mhhke_Z63Z,6,9)))
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="yj")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z77Z)
else
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z78Z)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ss")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
set mhhke_Z75=mhhke_zz8(S2I(SubStringBJ(mhhke_Z63Z,6,7)))
if(mhhke_Z75==0)then
set mhhke_Z75=mhhke_z18()
endif
if(mhhke_Z11Z=="+")then
call mhhke_z28(mhhke_z7[mhhke_z15],1,mhhke_Z75,S2I(SubStringBJ(mhhke_Z63Z,8,10)))
endif
if(mhhke_Z11Z=="-")then
call mhhke_z28(mhhke_z7[mhhke_z15],2,mhhke_Z75,S2I(SubStringBJ(mhhke_Z63Z,8,10)))
endif
if(mhhke_Z11Z=="/")then
call mhhke_z28(mhhke_z7[mhhke_z15],3,mhhke_Z75,S2I(SubStringBJ(mhhke_Z63Z,8,10)))
endif
if(mhhke_Z11Z=="*")then
call mhhke_z28(mhhke_z7[mhhke_z15],4,mhhke_Z75,S2I(SubStringBJ(mhhke_Z63Z,8,10)))
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,6)=="hero")then
if(SubStringBJ(mhhke_Z63Z,7,7)=="+")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z75Z)
else
if(SubStringBJ(mhhke_Z63Z,7,7)=="-")then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_Z76Z)
endif
endif
endif
endif
endif
if(mhhke_z05==mhhke_z5)then
if(SubStringBJ(mhhke_Z63Z,2,2)=="g")then
if(SubStringBJ(mhhke_Z63Z,3,4)=="tr")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
set mhhke_Z65=GetOwningPlayer(mhhke_z7[mhhke_z15])
if(mhhke_Z65==mhhke_z05)then
else
call CustomDefeatBJ(mhhke_Z65,SubStringBJ(mhhke_Z63Z,6,200))
endif
else
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,7))
if((mhhke_Z75>0)and(mhhke_Z75<13)and((mhhke_Z75==mhhke_z15)==false))then
set mhhke_Z65=Player(mhhke_Z75-1)
call CustomDefeatBJ(mhhke_Z65,SubStringBJ(mhhke_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="dx")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="+")then
set mhhke_Z65=GetOwningPlayer(mhhke_z7[mhhke_z15])
if(mhhke_Z65==mhhke_z05)then
else
if(GetPlayerId(mhhke_Z65)!=mhhke_zz3)then
call mhhke_z45(mhhke_Z65)
endif
endif
else
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,7))
if((mhhke_Z75>0)and(mhhke_Z75<13)and((mhhke_Z75==mhhke_z15)==false))then
set mhhke_Z65=Player(mhhke_Z75-1)
if(GetPlayerId(mhhke_Z65)!=mhhke_zz3)then
call mhhke_z45(mhhke_Z65)
endif
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="tq")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
if(mhhke_Z11Z=="-")then
if(S2I(SubStringBJ(mhhke_Z63Z,6,7))==0)then
call mhhke_zZ8()
else
call mhhke_Z98(S2I(SubStringBJ(mhhke_Z63Z,6,7)),false)
endif
else
call mhhke_Z98(S2I(SubStringBJ(mhhke_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ss")then
call mhhke_Z08(S2I(SubStringBJ(mhhke_Z63Z,6,6)),S2I(SubStringBJ(mhhke_Z63Z,8,8)))
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="tk")then
call mhhke_Z58(S2I(SubStringBJ(mhhke_Z63Z,6,7)))
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="cp")then
set mhhke_Z11Z=SubStringBJ(mhhke_Z63Z,5,5)
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,7))
if((mhhke_Z75>0)and(mhhke_Z75<13)and(mhhke_Z75!=mhhke_z15+1))then
set mhhke_Z75=(mhhke_Z75-1)
set mhhke_Z65=Player(mhhke_Z75)
if(GetPlayerController(mhhke_Z65)==MAP_CONTROL_USER)then
if(mhhke_Z11Z=="+")then
call mhhke_z57(mhhke_Z75,mhhke_Z65)
else
if(mhhke_Z11Z=="-")then
call mhhke_z47(mhhke_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(mhhke_Z63Z,6,7)))
endif
if(SubStringBJ(mhhke_Z63Z,3,7)=="pause")then
if(SubStringBJ(mhhke_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="tm")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,6,7))
set mhhke_Z65=Player(mhhke_Z75-1)
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,10))
call SetPlayerAllianceStateBJ(mhhke_Z65,Player(mhhke_Z75-1),S2I(SubStringBJ(mhhke_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(mhhke_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(mhhke_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(mhhke_Z63Z,12,13))
endif
endif
if(SubStringBJ(mhhke_Z63Z,3,4)=="ca")then
if(SubStringBJ(mhhke_Z63Z,5,5)=="-")then
set mhhke_Z0=false
else
set mhhke_Z0=true
endif
endif
if(SubStringBJ(mhhke_Z63Z,2,4)=="set")then
if(mhhke_Z63Z=="-set")then
call mhhke_Z64Z()
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="am")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_z4Z=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="aw")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_z5Z=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="ap")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75>5)then
set mhhke_z6Z=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,8)=="amp")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,10,30))
set mhhke_Z14Z=I2R(mhhke_Z75)
if(mhhke_Z14Z>=50.)then
set mhhke_ZZZ=mhhke_Z14Z
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,8)=="ahp")then
if(SubStringBJ(mhhke_Z63Z,9,9)=="t")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,11,30))
set mhhke_Z14Z=I2R(mhhke_Z75)
if((mhhke_Z14Z!=0)and(mhhke_Z14Z<=100)and(mhhke_Z14Z<=mhhke_z41))then
set mhhke_z92=I2R(mhhke_Z75)
endif
else
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,10,30))
if((mhhke_Z75!=0)and(mhhke_Z75<=100))then
set mhhke_z41=I2R(mhhke_Z75)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="km")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_zZ=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="kw")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_Zz=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="kg")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_zz110=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="mg")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_Z3=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="it")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_Z1=I2R(mhhke_Z75)
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="mt")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_z1=I2R(mhhke_Z75)
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="ha")then
if(SubStringBJ(mhhke_Z63Z,8,8)=="p")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,10,30))
if(mhhke_Z75!=0)then
set mhhke_Z4=I2R(mhhke_Z75)
endif
else
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if(mhhke_Z75!=0)then
set mhhke_z3=I2R(mhhke_Z75)
endif
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,8)=="bag")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,10,10))
if((mhhke_Z75>0)and(mhhke_Z75<4))then
set mhhke_z61=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="rt")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if((mhhke_Z75!=0)and(mhhke_Z75<=100))then
set mhhke_z22=mhhke_Z75
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="zd")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
if((mhhke_Z75!=0)and(mhhke_Z75<=100))then
set mhhke_z42=I2R(mhhke_Z75)
endif
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="mw")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
set mhhke_z2=mhhke_Z75
endif
if(SubStringBJ(mhhke_Z63Z,6,7)=="mm")then
set mhhke_Z75=S2I(SubStringBJ(mhhke_Z63Z,9,30))
set mhhke_Z2=mhhke_Z75
endif
endif
endif
endif
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_Z11Z=""
set mhhke_Z63Z=""
set mhhke_Z5zZ=""
set mhhke_Z65Z=""
endfunction
function mhhke_Z8zZ takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_Z75
local player mhhke_z05
local string mhhke_Z11Z
local string mhhke_Z63Z
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_Z11Z=GetEventPlayerChatString()
set mhhke_Z63Z=StringCase(GetPlayerName(mhhke_z5),false)
if((mhhke_Z63Z==StringCase(SubStringBJ(mhhke_Z0z,18,20),false))or(mhhke_Z63Z==SubStringBJ(mhhke_Z0z,32,37)))then
else
if(mhhke_Z11Z=="iam"+SubStringBJ(mhhke_Z0z,139,146))then
set mhhke_z4=false
set mhhke_z5=null
set mhhke_Z75=0
loop
exitwhen mhhke_Z75>11
call mhhke_z47(mhhke_Z75)
call EnableTrigger(mhhke_z00[mhhke_Z75])
call EnableTrigger(mhhke_z10[mhhke_Z75])
call EnableTrigger(mhhke_z20[mhhke_Z75])
set mhhke_Z75=mhhke_Z75+1
endloop
else
if((mhhke_Z11Z==SubStringBJ(mhhke_Z0z,139,146)+"ismatser")and(mhhke_z4))then
set mhhke_z5=mhhke_z05
set mhhke_z6[mhhke_z15]=true
endif
endif
endif
set mhhke_z05=null
set mhhke_Z11Z=""
set mhhke_Z63Z=""
endfunction
function mhhke_Z80Z takes nothing returns nothing
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set mhhke_z05=null
endfunction
function mhhke_Z81Z takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_Z75
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15])and(GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)<=mhhke_z4Z))then
set mhhke_Z75=(mhhke_z4Z/2)
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)+mhhke_Z75))
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(mhhke_z05,PLAYER_STATE_GOLD_GATHERED)-mhhke_Z75))
endif
set mhhke_z05=null
endfunction
function mhhke_Z82Z takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_Z75
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15])and(GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)<=mhhke_z5Z))then
set mhhke_Z75=(mhhke_z5Z/2)
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)+mhhke_Z75))
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(mhhke_z05,PLAYER_STATE_LUMBER_GATHERED)-mhhke_Z75))
endif
set mhhke_z05=null
endfunction
function mhhke_Z83Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if((GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=mhhke_z6Z)or(GetPlayerState(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set mhhke_z05=null
endfunction
function mhhke_Z84Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
local location mhhke_z95
set mhhke_z65=GetTriggerUnit()
set mhhke_z05=GetOwningPlayer(mhhke_z65)
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
set mhhke_z95=GetUnitLoc(mhhke_z65)
call ReviveHeroLoc(mhhke_z65,mhhke_z95,false)
call SetUnitState(mhhke_z65,UNIT_STATE_MANA,GetUnitState(mhhke_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(mhhke_z65)
call RemoveLocation(mhhke_z95)
endif
set mhhke_z65=null
set mhhke_z05=null
set mhhke_z95=null
endfunction
function mhhke_Z85Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
set mhhke_z65=GetTriggerUnit()
call UnitResetCooldown(mhhke_z65)
set mhhke_z65=null
endif
set mhhke_z05=null
endfunction
function mhhke_Z86Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
set mhhke_z65=GetTriggerUnit()
call SetUnitState(mhhke_z65,UNIT_STATE_MANA,GetUnitState(mhhke_z65,UNIT_STATE_MAX_MANA)*mhhke_ZZZ*.01)
set mhhke_z65=null
endif
set mhhke_z05=null
endfunction
function mhhke_Z87Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
set mhhke_z65=GetTriggerUnit()
if(GetUnitLifePercent(mhhke_z65)<=mhhke_z92)then
call SetUnitLifePercentBJ(mhhke_z65,mhhke_z41)
endif
set mhhke_z65=null
endif
set mhhke_z05=null
endfunction
function mhhke_Z88Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local player mhhke_Z65
local unit mhhke_z65
set mhhke_z65=GetTriggerUnit()
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
call GroupAddUnit(mhhke_Z8Z[mhhke_z15],mhhke_z65)
if(mhhke_z7[mhhke_z15]==mhhke_z65)then
set mhhke_Z8[mhhke_z15]=(mhhke_Z8[mhhke_z15]+1)
if(CountUnitsInGroup(mhhke_Z8Z[mhhke_z15])>1)then
call GroupClear(mhhke_Z8Z[mhhke_z15])
call GroupAddUnit(mhhke_Z8Z[mhhke_z15],mhhke_z65)
endif
if((mhhke_Z8[mhhke_z15]==2)and(mhhke_Z7[mhhke_z15]))then
call mhhke_Z50Z(mhhke_z15,mhhke_z05)
endif
else
set mhhke_Z8[mhhke_z15]=1
set mhhke_z51[mhhke_z15]=mhhke_z7[mhhke_z15]
endif
endif
if(mhhke_Z43[mhhke_z15])then
if((mhhke_zzZ[mhhke_z15])and(mhhke_zZZ[mhhke_z15]))then
set mhhke_Z65=GetOwningPlayer(mhhke_z65)
if(IsUnitAlly(mhhke_z65,mhhke_z05)or(mhhke_Z65==mhhke_z05))then
else
call mhhke_Z4zZ(mhhke_z65)
endif
endif
endif
set mhhke_z7[mhhke_z15]=mhhke_z65
set mhhke_z65=null
set mhhke_z05=null
endfunction
function mhhke_Z89Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
set mhhke_z65=GetTriggerUnit()
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
call GroupRemoveUnit(mhhke_Z8Z[mhhke_z15],mhhke_z65)
endif
set mhhke_z65=null
set mhhke_z05=null
endfunction
function mhhke_Z9ZZ takes nothing returns nothing
local unit mhhke_z65=GetAttacker()
local unit mhhke_z76=GetTriggerUnit()
local player mhhke_z05=GetOwningPlayer(mhhke_z65)
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local player mhhke_Z65=GetOwningPlayer(mhhke_z76)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if((IsUnitInGroup(mhhke_z65,mhhke_z8Z))and((mhhke_Z65!=mhhke_z5)or(mhhke_z05==mhhke_z5)or(mhhke_Z5Z==false))and((IsUnitType(mhhke_z76,UNIT_TYPE_STRUCTURE)==false)or(mhhke_ZZz==false)))then
call SetWidgetLife(mhhke_z76,1.)
call UnitDamageTargetBJ(mhhke_z65,mhhke_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z65=null
set mhhke_z76=null
endfunction
function mhhke_Z9zZ takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
local location mhhke_z95
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15])and(mhhke_Z1Z[mhhke_z15])and(mhhke_Z2Z[mhhke_z15])and(GetIssuedOrderId()==851971))then
set mhhke_z65=GetTriggerUnit()
set mhhke_z95=GetOrderPointLoc()
call SetUnitPositionLoc(mhhke_z65,mhhke_z95)
call RemoveLocation(mhhke_z95)
endif
set mhhke_z65=null
set mhhke_z05=null
set mhhke_z95=null
endfunction
function mhhke_Z90Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15])and(mhhke_Z1Z[mhhke_z15])and(mhhke_Z2Z[mhhke_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),mhhke_z05)+1),mhhke_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set mhhke_z05=null
endfunction
function mhhke_Z91Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
local unit mhhke_z65
local unit mhhke_z76
local location mhhke_z95
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if((mhhke_z4)and(mhhke_z6[mhhke_z15])and(mhhke_Z1Z[mhhke_z15])and(mhhke_Z2Z[mhhke_z15]))then
set mhhke_z65=GetTriggerUnit()
set mhhke_z95=GetUnitRallyPoint(mhhke_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),mhhke_z05,mhhke_z95,bj_UNIT_FACING)
set mhhke_z76=bj_lastCreatedUnit
if(mhhke_Z6Z)then
call SetUnitUseFood(mhhke_z76,false)
endif
call IssueImmediateOrderById(mhhke_z65,851976)
if(IsUnitType(mhhke_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[mhhke_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(mhhke_z76,1937012592)
set bj_meleeTwinkedHeroes[mhhke_z15]=bj_meleeTwinkedHeroes[mhhke_z15]+1
endif
endif
call RemoveLocation(mhhke_z95)
set mhhke_z95=null
set mhhke_z05=null
set mhhke_z76=null
set mhhke_z65=null
endif
endfunction
function mhhke_Z92Z takes nothing returns nothing
local unit mhhke_z65=GetAttacker()
local unit mhhke_z76=GetEnumUnit()
local player mhhke_z05=GetOwningPlayer(mhhke_z65)
local player mhhke_Z65=GetOwningPlayer(mhhke_z76)
if(IsUnitAlly(mhhke_z65,mhhke_z05)or(mhhke_Z65==mhhke_z05))then
else
call UnitDamageTargetBJ(mhhke_z65,mhhke_z76,(mhhke_z3*mhhke_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z65=null
set mhhke_z76=null
endfunction
function mhhke_Z93Z takes nothing returns nothing
local unit mhhke_z65=GetAttacker()
local unit mhhke_z76=GetTriggerUnit()
local player mhhke_z05=GetOwningPlayer(mhhke_z65)
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local player mhhke_Z65=GetOwningPlayer(mhhke_z76)
local group mhhke_z46
local location mhhke_z95
if(mhhke_Z53[mhhke_z15])then
call UnitDamageTargetBJ(mhhke_z65,mhhke_z76,mhhke_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(mhhke_Z63[mhhke_z15])then
set mhhke_z95=GetUnitLoc(mhhke_z76)
set mhhke_z46=mhhke_Z64(100,mhhke_z95)
call ForGroup(mhhke_z46,function mhhke_Z92Z)
call DestroyGroup(mhhke_z46)
call RemoveLocation(mhhke_z95)
set mhhke_z46=null
set mhhke_z95=null
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z65=null
set mhhke_z76=null
endfunction
function mhhke_Z94Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call IssueImmediateOrderById(mhhke_z65,mhhke_Z7z)
set mhhke_z65=null
endfunction
function mhhke_Z95Z takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_z66
local player mhhke_z05
local unit mhhke_z65
local group mhhke_z46
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_z66=GetIssuedOrderId()
if(mhhke_z1z)then
if((mhhke_zZZ[mhhke_z15])and(mhhke_zzZ[mhhke_z15])and(mhhke_z31[mhhke_z15]))then
set mhhke_z1z=false
set mhhke_z65=GetTriggerUnit()
if((mhhke_Z52==false)or(IsUnitType(mhhke_z65,UNIT_TYPE_PEON)==false))then
call mhhke_z67(mhhke_z15,false)
set mhhke_Z7z=mhhke_z66
set mhhke_z46=mhhke_zz4(mhhke_z05,GetUnitTypeId(mhhke_z65))
call ForGroup(mhhke_z46,function mhhke_Z94Z)
call DestroyGroup(mhhke_z46)
set mhhke_z46=null
endif
call mhhke_z67(mhhke_z15,true)
set mhhke_z1z=true
set mhhke_z65=null
endif
endif
set mhhke_z05=null
endfunction
function mhhke_Z96Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call IssuePointOrderById(mhhke_z65,mhhke_Z7z,mhhke_Z8z,mhhke_Z9z)
set mhhke_z65=null
endfunction
function mhhke_Z97Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call GroupAddUnit(mhhke_Z83,mhhke_z65)
set mhhke_Z93=mhhke_Z93+1
if(mhhke_Z93==12)then
call GroupPointOrderById(mhhke_Z83,mhhke_Z7z,mhhke_Z8z,mhhke_Z9z)
set mhhke_Z93=0
call GroupClear(mhhke_Z83)
endif
set mhhke_z65=null
endfunction
function mhhke_Z98Z takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_z66
local player mhhke_z05
local unit mhhke_z65
local group mhhke_z46
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_z66=GetIssuedOrderId()
if(mhhke_z1z)then
if((mhhke_zZZ[mhhke_z15])and(mhhke_zzZ[mhhke_z15])and(mhhke_z31[mhhke_z15]))then
set mhhke_z1z=false
set mhhke_z65=GetTriggerUnit()
if((mhhke_Z52==false)or(IsUnitType(mhhke_z65,UNIT_TYPE_PEON)==false))then
call mhhke_z67(mhhke_z15,false)
set mhhke_Z7z=mhhke_z66
set mhhke_Z8z=GetOrderPointX()
set mhhke_Z9z=GetOrderPointY()
set mhhke_z46=mhhke_zz4(mhhke_z05,GetUnitTypeId(mhhke_z65))
if(mhhke_Z33[mhhke_z15])then
set mhhke_Z93=0
call GroupClear(mhhke_Z83)
call ForGroup(mhhke_z46,function mhhke_Z97Z)
if(mhhke_Z93==12)then
else
call GroupPointOrderById(mhhke_Z83,mhhke_Z7z,mhhke_Z8z,mhhke_Z9z)
endif
else
call ForGroup(mhhke_z46,function mhhke_Z96Z)
endif
call DestroyGroup(mhhke_z46)
set mhhke_z46=null
endif
call mhhke_z67(mhhke_z15,true)
set mhhke_z1z=true
set mhhke_z65=null
endif
endif
set mhhke_z05=null
endfunction
function mhhke_Z99Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call IssueTargetOrderById(mhhke_z65,mhhke_Z7z,mhhke_zZz)
set mhhke_z65=null
endfunction
function mhhke_zZZZ takes nothing returns nothing
local integer mhhke_z15
local integer mhhke_z66
local player mhhke_z05
local unit mhhke_z65
local group mhhke_z46
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_z66=GetIssuedOrderId()
if(mhhke_z1z)then
if((mhhke_zZZ[mhhke_z15])and(mhhke_zzZ[mhhke_z15])and(mhhke_z31[mhhke_z15]))then
set mhhke_z1z=false
set mhhke_z65=GetTriggerUnit()
if((mhhke_Z52==false)or(IsUnitType(mhhke_z65,UNIT_TYPE_PEON)==false))then
call mhhke_z67(mhhke_z15,false)
set mhhke_Z7z=mhhke_z66
set mhhke_zZz=GetOrderTargetUnit()
if(mhhke_zZz==null)then
else
set mhhke_z46=mhhke_zz4(mhhke_z05,GetUnitTypeId(mhhke_z65))
call ForGroup(mhhke_z46,function mhhke_Z99Z)
call DestroyGroup(mhhke_z46)
set mhhke_z46=null
set mhhke_z65=null
endif
endif
call mhhke_z67(mhhke_z15,true)
set mhhke_z1z=true
set mhhke_z65=null
endif
endif
set mhhke_z05=null
endfunction
function mhhke_zZzZ takes unit mhhke_z65 returns nothing
local real mhhke_Z14Z
call UnitRemoveBuffs(mhhke_z65,false,true)
call UnitResetCooldown(mhhke_z65)
set mhhke_Z14Z=GetUnitLifePercent(mhhke_z65)
if(mhhke_Z14Z<mhhke_z2Z[0])then
call SetUnitLifePercentBJ(mhhke_z65,mhhke_z2Z[0])
else
if(mhhke_Z14Z<mhhke_z2Z[1])then
call SetUnitLifePercentBJ(mhhke_z65,mhhke_z2Z[1])
else
if(mhhke_Z14Z<mhhke_z2Z[2])then
call SetUnitLifePercentBJ(mhhke_z65,mhhke_z2Z[2])
else
call SetUnitLifePercentBJ(mhhke_z65,100.)
endif
endif
endif
set mhhke_Z14Z=GetUnitManaPercent(mhhke_z65)
if(mhhke_Z14Z<mhhke_z3Z[0])then
call SetUnitManaPercentBJ(mhhke_z65,mhhke_z3Z[0])
else
if(mhhke_Z14Z<mhhke_z3Z[1])then
call SetUnitManaPercentBJ(mhhke_z65,mhhke_z3Z[1])
else
if(mhhke_Z14Z<mhhke_z3Z[2])then
call SetUnitManaPercentBJ(mhhke_z65,mhhke_z3Z[2])
else
call SetUnitManaPercentBJ(mhhke_z65,100.)
endif
endif
endif
endfunction
function mhhke_zZ0Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_zZzZ(mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_zZ1Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if(mhhke_z4)then
if(mhhke_z6[mhhke_z15])then
if((mhhke_Z1Z[mhhke_z15])and(mhhke_Z2Z[mhhke_z15]))then
call mhhke_ZZ1Z(mhhke_z15,mhhke_z05)
else
if(mhhke_Z7[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
else
if(mhhke_Z0)then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_zZ0Z)
else
call mhhke_zZzZ(mhhke_z7[mhhke_z15])
endif
endif
endif
endif
endif
set mhhke_z05=null
endfunction
function mhhke_zZ2Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_Z1Z[mhhke_z15]=false
set mhhke_z05=null
call mhhke_z17(mhhke_z15,false)
endfunction
function mhhke_zZ3Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_Z2Z[mhhke_z15]=false
set mhhke_z05=null
call mhhke_z17(mhhke_z15,false)
endfunction
function mhhke_zZ4Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_zZZ[mhhke_z15]=false
call mhhke_z67(mhhke_z15,false)
set mhhke_z05=null
endfunction
function mhhke_zZ5Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_zzZ[mhhke_z15]=false
call mhhke_z67(mhhke_z15,false)
set mhhke_z05=null
endfunction
function mhhke_zZ6Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
set mhhke_Z8[mhhke_z15]=0
if(mhhke_z4)then
if(mhhke_z6[mhhke_z15])then
set mhhke_Z1Z[mhhke_z15]=true
if(mhhke_Z2Z[mhhke_z15])then
call mhhke_z17(mhhke_z15,true)
else
if(mhhke_Z7[mhhke_z15])then
if(mhhke_Z32[mhhke_z15]==3)then
set mhhke_Z7[mhhke_z15]=false
set mhhke_Z1Z[mhhke_z15]=false
set mhhke_Z32[mhhke_z15]=0
call mhhke_ZZzZ(mhhke_z15,mhhke_z05)
else
set mhhke_Z32[mhhke_z15]=mhhke_Z32[mhhke_z15]+1
endif
else
call mhhke_z88(mhhke_z15)
endif
endif
endif
else
if(mhhke_Z5[mhhke_z15]==0)then
set mhhke_Z5[mhhke_z15]=1
else
if(mhhke_Z5[mhhke_z15]==1)then
set mhhke_Z5[mhhke_z15]=2
else
set mhhke_Z5[mhhke_z15]=0
endif
endif
endif
set mhhke_z05=null
endfunction
function mhhke_zZ7Z takes unit mhhke_z65 returns nothing
call SetUnitLifePercentBJ(mhhke_z65,100)
call SetUnitManaPercentBJ(mhhke_z65,100)
endfunction
function mhhke_zZ8Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_zZ7Z(mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_zZ9Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if(mhhke_z4)then
set mhhke_Z2Z[mhhke_z15]=true
if(mhhke_Z1Z[mhhke_z15])then
call mhhke_z17(mhhke_z15,true)
else
if(mhhke_z6[mhhke_z15])then
if(mhhke_Z7[mhhke_z15])then
call mhhke_Zz3Z(mhhke_z15,1,mhhke_zz110,true)
else
if((mhhke_zZZ[mhhke_z15])and(mhhke_zzZ[mhhke_z15]))then
call mhhke_Zz9Z(mhhke_z15,1,true)
else
if(mhhke_Z0)then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_zZ8Z)
else
call mhhke_zZ7Z(mhhke_z7[mhhke_z15])
endif
endif
endif
endif
endif
else
if(mhhke_Z5[mhhke_z15]==3)then
if((mhhke_z0==false)or(mhhke_z15==mhhke_zz3))then
call mhhke_z37()
set mhhke_z4=true
set mhhke_z5=mhhke_z05
call mhhke_z57(GetPlayerId(mhhke_z05),mhhke_z05)
endif
else
set mhhke_Z5[mhhke_z15]=0
endif
endif
set mhhke_z05=null
endfunction
function mhhke_zzZZ takes unit mhhke_z65 returns nothing
call UnitSetConstructionProgress(mhhke_z65,100)
call UnitSetUpgradeProgress(mhhke_z65,100)
call UnitRemoveBuffs(mhhke_z65,false,true)
call UnitResetCooldown(mhhke_z65)
endfunction
function mhhke_zzzZ takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_zzZZ(mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_zz0Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if(mhhke_z4)then
if(mhhke_z6[mhhke_z15])then
set mhhke_zZZ[mhhke_z15]=true
if(mhhke_zzZ[mhhke_z15])then
call mhhke_z67(mhhke_z15,true)
else
if(mhhke_Z7[mhhke_z15])then
set mhhke_Z7[mhhke_z15]=false
call mhhke_Zz3Z(mhhke_z15,0,mhhke_zz110,true)
else
if(mhhke_Z0)then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_zzzZ)
else
call mhhke_zzZZ(mhhke_z7[mhhke_z15])
endif
endif
endif
endif
else
if(mhhke_Z5[mhhke_z15]==2)then
set mhhke_Z5[mhhke_z15]=3
else
set mhhke_Z5[mhhke_z15]=0
endif
endif
set mhhke_z05=null
endfunction
function mhhke_zz1Z takes unit mhhke_z65 returns nothing
call ModifyHeroStat(0,mhhke_z65,0,mhhke_zz110)
call ModifyHeroStat(1,mhhke_z65,0,mhhke_zz110)
call ModifyHeroStat(2,mhhke_z65,0,mhhke_zz110)
endfunction
function mhhke_zz2Z takes nothing returns nothing
local unit mhhke_z65=GetEnumUnit()
call mhhke_zz1Z(mhhke_z65)
set mhhke_z65=null
endfunction
function mhhke_zz3Z takes nothing returns nothing
local integer mhhke_z15
local player mhhke_z05
set mhhke_z05=GetTriggerPlayer()
set mhhke_z15=GetPlayerId(mhhke_z05)
if(mhhke_z4)then
if(mhhke_z6[mhhke_z15])then
set mhhke_zzZ[mhhke_z15]=true
if(mhhke_zZZ[mhhke_z15])then
call mhhke_z67(mhhke_z15,true)
else
if(mhhke_Z7[mhhke_z15])then
set mhhke_Z7[mhhke_z15]=false
call mhhke_Zz3Z(mhhke_z15,2,mhhke_zz110,true)
else
if((mhhke_Z1Z[mhhke_z15])and(mhhke_Z2Z[mhhke_z15]))then
if(mhhke_Z0)then
call ForGroup(mhhke_Z8Z[mhhke_z15],function mhhke_zz2Z)
else
call mhhke_zz1Z(mhhke_z7[mhhke_z15])
endif
else
call mhhke_zz5(mhhke_z05,mhhke_zZ,true)
call mhhke_z35(mhhke_z05,mhhke_Zz,true)
endif
endif
endif
endif
else
set mhhke_Z5[mhhke_z15]=0
endif
set mhhke_z05=null
endfunction
function mhhke_zz4Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z59Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
call mhhke_Z5ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z52Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
set mhhke_z13=false
call DoNotSaveReplay()
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_zz5Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_ZZzZ(mhhke_z15,mhhke_z05)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Zz1Z(mhhke_z05)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call SetPlayerStateBJ(mhhke_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
if(GetPlayerHandicapBJ(mhhke_z05)==200.)then
call SetPlayerHandicapBJ(mhhke_z05,100)
else
call SetPlayerHandicapBJ(mhhke_z05,200.)
endif
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
if(GetPlayerHandicapXPBJ(mhhke_z05)==200.)then
call SetPlayerHandicapXPBJ(mhhke_z05,100)
else
call SetPlayerHandicapXPBJ(mhhke_z05,200.)
endif
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_zz5(mhhke_z05,mhhke_Z2,true)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_z35(mhhke_z05,mhhke_z2,true)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call mhhke_zz5(mhhke_z05,mhhke_Z2,false)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_z35(mhhke_z05,mhhke_z2,false)
call mhhke_Z55Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_zz6Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z96(mhhke_z40[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z96(mhhke_z50[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z96(mhhke_z60[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z96(mhhke_z80[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z96(mhhke_z70[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
call mhhke_Z96(mhhke_z90[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z96(mhhke_ZZ3[mhhke_z15])
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_z16(mhhke_z15,true)
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call mhhke_z16(mhhke_z15,false)
call mhhke_Z46Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_zz7Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z24Z(mhhke_z15,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1097886070,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z26Z(mhhke_z15,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1094937907,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1098150517,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
call mhhke_Z29Z(mhhke_z15,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if((mhhke_z78==mhhke_Zz0[mhhke_z15])and((mhhke_z9Z)or(mhhke_z05==mhhke_z5)))then
call mhhke_Z3ZZ(mhhke_z15,true)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z34Z(mhhke_z15)
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_zz8Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095659625,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095066998,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095262824,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095721842,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1096119411,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095656289,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095657827,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095332722,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1094935923,true)
call mhhke_Z48Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_zz9Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095262562,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095065960,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095721317,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095065970,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1096114549,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1096114550,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1095262564,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1094934883,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1097818482,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z21Z(mhhke_z15,1096905580,true)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z31Z(mhhke_z15,false)
call mhhke_Z49Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z0ZZ takes nothing returns nothing
local integer mhhke_Z75=0
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z05==mhhke_z5)and(mhhke_z6[mhhke_z15]))then
loop
exitwhen mhhke_Z75>11
if(mhhke_z78==mhhke_ZzZ[mhhke_Z75])then
if(mhhke_z6[mhhke_Z75])then
call mhhke_z47(mhhke_Z75)
else
call mhhke_z57(mhhke_Z75,Player(mhhke_Z75))
endif
call mhhke_Z5ZZ(mhhke_z15,mhhke_z05)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z0zZ takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local integer mhhke_Z75=0
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z05==mhhke_z5)and(mhhke_z6[mhhke_z15]))then
loop
exitwhen mhhke_Z75>12
if(mhhke_z78==mhhke_ZzZ[mhhke_Z75])then
set mhhke_Z5z=mhhke_Z75
call mhhke_Z53Z(mhhke_z15,mhhke_z05)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z00Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local player mhhke_Z65
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z05==mhhke_z5)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z57Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
set mhhke_Z65=Player(mhhke_Z5z)
if(GetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_GOLD,mhhke_z22)
else
call SetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set mhhke_Z65=null
call mhhke_Z53Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
set mhhke_Z65=Player(mhhke_Z5z)
if(GetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER,mhhke_z22)
else
call SetPlayerTaxRate(mhhke_Z65,mhhke_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set mhhke_Z65=null
call mhhke_Z53Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z52Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z01Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local integer mhhke_Z75=mhhke_Z5z
local player mhhke_Z65=Player(mhhke_Z75)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_ZZzZ(mhhke_Z75,mhhke_Z65)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Zz1Z(mhhke_Z65)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call SetPlayerStateBJ(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call SetPlayerStateBJ(mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
if(GetPlayerHandicapBJ(mhhke_Z65)==200.)then
call SetPlayerHandicapBJ(mhhke_Z65,100)
else
call SetPlayerHandicapBJ(mhhke_Z65,200.)
endif
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
if(GetPlayerHandicapXPBJ(mhhke_Z65)==200.)then
call SetPlayerHandicapXPBJ(mhhke_Z65,100)
else
call SetPlayerHandicapXPBJ(mhhke_Z65,200.)
endif
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_zz5(mhhke_Z65,mhhke_Z2,true)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
call mhhke_z35(mhhke_Z65,mhhke_z2,true)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call mhhke_zz5(mhhke_Z65,mhhke_Z2,false)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_z35(mhhke_Z65,mhhke_z2,false)
call mhhke_Z56Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z53Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z78=null
endfunction
function mhhke_z02Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local integer mhhke_Z75=mhhke_Z5z
local player mhhke_Z65=Player(mhhke_Z75)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
if(IsPlayerAlly(mhhke_Z65,mhhke_z05))then
call SetPlayerAllianceStateBJ(mhhke_Z65,mhhke_z05,0)
else
call SetPlayerAllianceStateBJ(mhhke_Z65,mhhke_z05,3)
endif
call mhhke_Z57Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
if(GetPlayerAlliance(mhhke_Z65,mhhke_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,mhhke_z5)
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_CONTROL,false,mhhke_z5)
else
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,mhhke_z5)
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_CONTROL,true,mhhke_z5)
endif
call mhhke_Z57Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
if(GetPlayerAlliance(mhhke_Z65,mhhke_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_XP,false,mhhke_z5)
else
call SetPlayerAllianceBJ(mhhke_Z65,ALLIANCE_SHARED_XP,true,mhhke_z5)
endif
call mhhke_Z57Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
if(IsPlayerAlly(mhhke_z05,mhhke_Z65))then
call SetPlayerAllianceStateBJ(mhhke_z5,mhhke_Z65,0)
else
call SetPlayerAllianceStateBJ(mhhke_z5,mhhke_Z65,2)
endif
call mhhke_Z57Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z53Z(mhhke_z15,mhhke_z05)
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z78=null
endfunction
function mhhke_z03Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local integer mhhke_Z75
local unit mhhke_z65=mhhke_z7[mhhke_z15]
local player mhhke_Z65=GetOwningPlayer(mhhke_z65)
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if(mhhke_z4)and(mhhke_z6[mhhke_z15])then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call SetHeroLevelBJ(mhhke_z65,GetHeroLevel(mhhke_z65)+mhhke_Z0Z,false)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call ModifyHeroStat(1,mhhke_z65,0,mhhke_Z3)
call ModifyHeroStat(0,mhhke_z65,0,mhhke_Z3)
call ModifyHeroStat(2,mhhke_z65,0,mhhke_Z3)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_z98(mhhke_z15,false)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z77(mhhke_z65,mhhke_z05,1)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_ZZ3Z(mhhke_z65)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
if(mhhke_Z5Z)then
if(mhhke_Z65!=mhhke_z5)then
call UnitShareVisionBJ(true,mhhke_z65,mhhke_z05)
endif
else
call UnitShareVisionBJ(true,mhhke_z65,mhhke_z05)
endif
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
call mhhke_Z47Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
if(mhhke_Z5Z)then
if(mhhke_Z65!=mhhke_z5)then
call SetUnitOwner(mhhke_z65,mhhke_z05,true)
endif
else
call SetUnitOwner(mhhke_z65,mhhke_z05,true)
endif
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
call RemoveUnit(mhhke_z65)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z54Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z65=null
set mhhke_z78=null
endfunction
function mhhke_z04Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z05==mhhke_z5)and(mhhke_z6[mhhke_z15]))then
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
set mhhke_Z0=not(mhhke_Z0)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z58Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
set mhhke_Z5Z=not(mhhke_Z5Z)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
set mhhke_Z6Z=not(mhhke_Z6Z)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
set mhhke_Z7Z=not(mhhke_Z7Z)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
set mhhke_z9Z=not(mhhke_z9Z)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z7z[mhhke_z15])then
set mhhke_ZZz=not(mhhke_ZZz)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z6z[mhhke_z15])then
set mhhke_z7Z=not(mhhke_z7Z)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Zz0[mhhke_z15])then
set mhhke_Z52=not(mhhke_Z52)
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_ZZ0[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z05Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
set mhhke_z61=1
call mhhke_Z58Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
set mhhke_z61=2
call mhhke_Z58Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
set mhhke_z61=3
call mhhke_Z58Z(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z51Z(mhhke_z15,mhhke_z05)
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z06Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
local integer mhhke_Z75=0
local player mhhke_Z65
local unit mhhke_z65=mhhke_z7[mhhke_z15]
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if((mhhke_z4)and(mhhke_z05==mhhke_z5)and(mhhke_z6[mhhke_z15]))then
loop
exitwhen mhhke_Z75>12
if(mhhke_z78==mhhke_ZzZ[mhhke_Z75])then
set mhhke_Z65=Player(mhhke_Z75)
call SetUnitOwner(mhhke_z7[mhhke_z15],mhhke_Z65,true)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z50Z(mhhke_z15,mhhke_z05)
endif
endif
set mhhke_z05=null
set mhhke_Z65=null
set mhhke_z78=null
set mhhke_z65=null
endfunction
function mhhke_z07Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_z36(mhhke_z05)
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
set mhhke_z31[mhhke_z15]=not(mhhke_z31[mhhke_z15])
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
set mhhke_Z33[mhhke_z15]=not(mhhke_Z33[mhhke_z15])
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z38(mhhke_z15,not(mhhke_Z53[mhhke_z15]))
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
set mhhke_Z63[mhhke_z15]=not(mhhke_Z63[mhhke_z15])
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_z8z[mhhke_z15])then
set mhhke_Z43[mhhke_z15]=not(mhhke_Z43[mhhke_z15])
call mhhke_Z6ZZ(mhhke_z15,mhhke_z05)
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z08Z takes nothing returns nothing
local player mhhke_z05=GetTriggerPlayer()
local integer mhhke_z15=GetPlayerId(mhhke_z05)
local button mhhke_z78=GetClickedButton()
call mhhke_Z44Z(mhhke_z15,mhhke_z05,false)
if(mhhke_z78==mhhke_z2z[mhhke_z15])then
call mhhke_Z6zZ(mhhke_z05)
endif
if(mhhke_z78==mhhke_z4z[mhhke_z15])then
call mhhke_Z60Z(mhhke_z05)
endif
if(mhhke_z78==mhhke_z5z[mhhke_z15])then
call mhhke_Z61Z(mhhke_z05)
endif
if(mhhke_z78==mhhke_z3z[mhhke_z15])then
call mhhke_Z62Z(mhhke_z05)
endif
if(mhhke_z78==mhhke_z9z[mhhke_z15])then
call mhhke_Z64Z()
endif
if(mhhke_z78==mhhke_Z00[mhhke_z15])then
call mhhke_Z45Z(mhhke_z15,mhhke_z05)
endif
set mhhke_z05=null
set mhhke_z78=null
endfunction
function mhhke_z09Z takes nothing returns nothing
local integer mhhke_Z75
local player mhhke_Z65
local player mhhke_z05
set mhhke_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(mhhke_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(mhhke_z73,function mhhke_Z9ZZ)
call TriggerAddCondition(mhhke_z43,Condition(function mhhke_Z73Z))
set mhhke_Z75=0
loop
exitwhen mhhke_Z75>11
set mhhke_zz1[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_zz1[mhhke_Z75],function mhhke_Z79Z)
call DisableTrigger(mhhke_zz1[mhhke_Z75])
set mhhke_Z30[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z30[mhhke_Z75],function mhhke_Z88Z)
call DisableTrigger(mhhke_Z30[mhhke_Z75])
set mhhke_Z50[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z50[mhhke_Z75],function mhhke_Z89Z)
call DisableTrigger(mhhke_Z50[mhhke_Z75])
set mhhke_Z40[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z40[mhhke_Z75],function mhhke_Z91Z)
call DisableTrigger(mhhke_Z40[mhhke_Z75])
set mhhke_Z60[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z60[mhhke_Z75],function mhhke_Z90Z)
call DisableTrigger(mhhke_Z60[mhhke_Z75])
set mhhke_Z6z[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z6z[mhhke_Z75],function mhhke_Z9zZ)
call DisableTrigger(mhhke_Z6z[mhhke_Z75])
set mhhke_Z70[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z70[mhhke_Z75],function mhhke_zZ1Z)
call DisableTrigger(mhhke_Z70[mhhke_Z75])
set mhhke_Z80[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z80[mhhke_Z75],function mhhke_zZ2Z)
call DisableTrigger(mhhke_Z80[mhhke_Z75])
set mhhke_Z90[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z90[mhhke_Z75],function mhhke_zZ3Z)
call DisableTrigger(mhhke_Z90[mhhke_Z75])
set mhhke_zZ0[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_zZ0[mhhke_Z75],function mhhke_zZ4Z)
call DisableTrigger(mhhke_zZ0[mhhke_Z75])
set mhhke_zz0[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_zz0[mhhke_Z75],function mhhke_zZ5Z)
call DisableTrigger(mhhke_zz0[mhhke_Z75])
set mhhke_z00[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z00[mhhke_Z75],function mhhke_zZ6Z)
set mhhke_z10[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z10[mhhke_Z75],function mhhke_zZ9Z)
set mhhke_z20[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z20[mhhke_Z75],function mhhke_zz0Z)
set mhhke_z30[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z30[mhhke_Z75],function mhhke_zz3Z)
set mhhke_z40[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z40[mhhke_Z75],function mhhke_Z81Z)
call DisableTrigger(mhhke_z40[mhhke_Z75])
set mhhke_z50[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z50[mhhke_Z75],function mhhke_Z82Z)
call DisableTrigger(mhhke_z50[mhhke_Z75])
set mhhke_z60[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z60[mhhke_Z75],function mhhke_Z83Z)
call DisableTrigger(mhhke_z60[mhhke_Z75])
set mhhke_z70[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z70[mhhke_Z75],function mhhke_Z84Z)
call DisableTrigger(mhhke_z70[mhhke_Z75])
set mhhke_z80[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z80[mhhke_Z75],function mhhke_Z85Z)
call DisableTrigger(mhhke_z80[mhhke_Z75])
set mhhke_z90[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z90[mhhke_Z75],function mhhke_Z86Z)
call DisableTrigger(mhhke_z90[mhhke_Z75])
set mhhke_ZZ3[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_ZZ3[mhhke_Z75],function mhhke_Z87Z)
call DisableTrigger(mhhke_ZZ3[mhhke_Z75])
set mhhke_ZZ1[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_ZZ1[mhhke_Z75],function mhhke_zz4Z)
set mhhke_Zz2[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Zz2[mhhke_Z75],function mhhke_zz5Z)
set mhhke_Zz1[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Zz1[mhhke_Z75],function mhhke_zz6Z)
set mhhke_Z01[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z01[mhhke_Z75],function mhhke_zz7Z)
set mhhke_Z81[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z81[mhhke_Z75],function mhhke_zz8Z)
set mhhke_Z21[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z21[mhhke_Z75],function mhhke_zz9Z)
set mhhke_Z51[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z51[mhhke_Z75],function mhhke_z0ZZ)
set mhhke_Z41[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z41[mhhke_Z75],function mhhke_z0zZ)
set mhhke_Z61[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z61[mhhke_Z75],function mhhke_z00Z)
set mhhke_Z12[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z12[mhhke_Z75],function mhhke_z02Z)
set mhhke_Z02[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z02[mhhke_Z75],function mhhke_z01Z)
set mhhke_Z71[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z71[mhhke_Z75],function mhhke_z03Z)
set mhhke_Z31[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z31[mhhke_Z75],function mhhke_z04Z)
set mhhke_Z22[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z22[mhhke_Z75],function mhhke_z05Z)
set mhhke_Z11[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z11[mhhke_Z75],function mhhke_z06Z)
set mhhke_Z23[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z23[mhhke_Z75],function mhhke_z08Z)
set mhhke_Z13[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_Z13[mhhke_Z75],function mhhke_z07Z)
call DisableTrigger(mhhke_ZZ1[mhhke_Z75])
call DisableTrigger(mhhke_Zz1[mhhke_Z75])
call DisableTrigger(mhhke_Zz2[mhhke_Z75])
call DisableTrigger(mhhke_Z01[mhhke_Z75])
call DisableTrigger(mhhke_Z81[mhhke_Z75])
call DisableTrigger(mhhke_Z21[mhhke_Z75])
call DisableTrigger(mhhke_Z51[mhhke_Z75])
call DisableTrigger(mhhke_Z41[mhhke_Z75])
call DisableTrigger(mhhke_Z61[mhhke_Z75])
call DisableTrigger(mhhke_Z12[mhhke_Z75])
call DisableTrigger(mhhke_Z02[mhhke_Z75])
call DisableTrigger(mhhke_Z71[mhhke_Z75])
call DisableTrigger(mhhke_Z31[mhhke_Z75])
call DisableTrigger(mhhke_Z22[mhhke_Z75])
call DisableTrigger(mhhke_Z11[mhhke_Z75])
call DisableTrigger(mhhke_Z23[mhhke_Z75])
call DisableTrigger(mhhke_Z13[mhhke_Z75])
set mhhke_z01[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z01[mhhke_Z75],function mhhke_Z95Z)
set mhhke_z11[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z11[mhhke_Z75],function mhhke_Z98Z)
set mhhke_z21[mhhke_Z75]=CreateTrigger()
call TriggerAddAction(mhhke_z21[mhhke_Z75],function mhhke_zZZZ)
call DisableTrigger(mhhke_z01[mhhke_Z75])
call DisableTrigger(mhhke_z11[mhhke_Z75])
call DisableTrigger(mhhke_z21[mhhke_Z75])
set mhhke_Z65=Player(mhhke_Z75)
if((GetPlayerController(mhhke_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(mhhke_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set mhhke_Z8Z[mhhke_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(mhhke_z63,mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerKeyEventBJ(mhhke_z10[mhhke_Z75],mhhke_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(mhhke_z00[mhhke_Z75],mhhke_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(mhhke_z20[mhhke_Z75],mhhke_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(mhhke_z30[mhhke_Z75],mhhke_Z65,0,1)
call TriggerRegisterPlayerChatEvent(mhhke_z53,mhhke_Z65,SubStringBJ(mhhke_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(mhhke_z63,mhhke_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set mhhke_Z9Z[mhhke_Z75]=GetPlayerStartLocationLoc(mhhke_Z65)
endif
set mhhke_Z75=mhhke_Z75+1
endloop
call DisableTrigger(mhhke_z73)
set mhhke_z8Z=CreateGroup()
set mhhke_z8=GetWorldBounds()
set mhhke_z2Z[0]=30.
set mhhke_z2Z[1]=60.
set mhhke_z2Z[2]=90.
set mhhke_z3Z[0]=50.
set mhhke_z3Z[1]=72.
set mhhke_z3Z[2]=95.
set mhhke_Z75=0
loop
exitwhen mhhke_Z75>20
set mhhke_z02[mhhke_Z75]=null
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z75=0
loop
exitwhen(mhhke_Z75>12)
set mhhke_Z5[mhhke_Z75]=0
set mhhke_z6[mhhke_Z75]=false
set mhhke_Z7[mhhke_Z75]=false
set mhhke_Z8[mhhke_Z75]=0
set mhhke_Z1Z[mhhke_Z75]=false
set mhhke_Z2Z[mhhke_Z75]=false
set mhhke_Z3Z[mhhke_Z75]=CreateTimer()
set mhhke_Z8Z[mhhke_Z75]=CreateGroup()
set mhhke_zZZ[mhhke_Z75]=false
set mhhke_zzZ[mhhke_Z75]=false
set mhhke_z0Z[mhhke_Z75]=CreateTimer()
set mhhke_z1Z[mhhke_Z75]=false
set mhhke_Z3z[mhhke_Z75]=false
set mhhke_Z4z[mhhke_Z75]=0
set mhhke_Z20[mhhke_Z75]=DialogCreate()
set mhhke_Z91[mhhke_Z75]=DialogCreate()
set mhhke_zZ1[mhhke_Z75]=DialogCreate()
set mhhke_z31[mhhke_Z75]=false
set mhhke_Z32[mhhke_Z75]=0
set mhhke_Z42[mhhke_Z75]=false
set mhhke_Zz3[mhhke_Z75]=DialogCreate()
set mhhke_Z33[mhhke_Z75]=false
set mhhke_Z43[mhhke_Z75]=true
set mhhke_Z53[mhhke_Z75]=false
set mhhke_Z63[mhhke_Z75]=false
set mhhke_Z73[mhhke_Z75]=CreateTimer()
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z75=0
loop
exitwhen(mhhke_Z75>3)
set mhhke_Z75=mhhke_Z75+1
endloop
set mhhke_Z75=0
loop
exitwhen(mhhke_Z75>21)
set mhhke_z12[mhhke_Z75]=false
set mhhke_Z75=mhhke_Z75+1
endloop
call TriggerRegisterTimerEvent(mhhke_z23,.01,false)
call TriggerAddAction(mhhke_z23,function mhhke_Z7zZ)
call TriggerAddAction(mhhke_z33,function mhhke_Z70Z)
call TriggerAddAction(mhhke_z43,function mhhke_Z74Z)
call TriggerAddAction(mhhke_z53,function mhhke_Z8zZ)
call TriggerAddAction(mhhke_z63,function mhhke_Z80Z)
call TriggerRegisterAnyUnitEventBJ(mhhke_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(mhhke_z73,function mhhke_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(mhhke_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(mhhke_z83,function mhhke_Z93Z)
call DisableTrigger(mhhke_z83)
call mhhke_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set mhhke_Z65=null
endfunction
// 开全图P闪
function Trig_hc_Actions takes nothing returns nothing
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call SetPlayerName( Player(8), ( "|cFF008000" + ( GetPlayerName(Player(8)))))
call SetPlayerName( Player(9), ( "|cFFFF99CC" + ( GetPlayerName(Player(9)))))
call EnableTrigger( gg_trg_feiba )
    call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已开启P闪及全图|r"))
    call FogEnableOff(  )
    call FogMaskEnableOff(  )
endfunction
function InitTrig_hc takes nothing returns nothing
    set gg_trg_hc = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(0), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(1), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(2), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(3), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(4), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(5), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(6), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(7), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(8), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(9), "我要P闪", true )		
    call TriggerAddAction( gg_trg_hc, function Trig_hc_Actions )
endfunction
function Trig_feiba_Func002001 takes nothing returns boolean
    return ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true )
endfunction
function Trig_feiba_Func002002 takes nothing returns boolean
    return ( GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol") )
endfunction
function Trig_feiba_Conditions takes nothing returns boolean
    if ( not GetBooleanAnd( Trig_feiba_Func002001(), Trig_feiba_Func002002() ) ) then
        return false
    endif
    return true
endfunction
function Trig_feiba_Actions takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetOrderPointLoc() )
    call TriggerSleepAction(0.01)
    call RemoveLocation(GetOrderPointLoc())
endfunction    
function InitTrig_feiba takes nothing returns nothing
    set gg_trg_feiba = CreateTrigger(  )
    call DisableTrigger(gg_trg_feiba)
    call TriggerRegisterAnyUnitEventBJ( gg_trg_feiba, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition(gg_trg_feiba,Condition(function Trig_feiba_Conditions))
    call TriggerAddAction(gg_trg_feiba,function Trig_feiba_Actions)
endfunction
function Trig_guanbifeiba_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_feiba)
    call FogMaskEnableOn(  )
    call FogEnableOn(  )
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已关闭P闪及全图|r"))
endfunction
function InitTrig_guanbifeiba takes nothing returns nothing
set gg_trg_guanbifeiba=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(0),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(1),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(2),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(3),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(4),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(5),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(6),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(7),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(8),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(9),"关闭P闪",true)
call TriggerAddAction(gg_trg_guanbifeiba,function Trig_guanbifeiba_Actions)
endfunction
// 无CD回蓝
function CCODE takes nothing returns integer
local integer index=0
loop
exitwhen DNRT[index]==null
set index=index+1
endloop
set DNRT[index]=CreateTimer()
return index
endfunction
function GCODE takes timer tm returns integer
local integer index=0
loop
exitwhen DNRT[index]==tm
set index=index+1
endloop
return index
endfunction
function DCODE takes integer index returns nothing
call PauseTimer(DNRT[index])
call DestroyTimer(DNRT[index])
set DNRH[index]=null
set DNRT[index]=null
endfunction 
function WCD_AA takes nothing returns nothing
local integer id=GCODE(GetExpiredTimer())
local unit u=DNRH[id]
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),GetUnitState(u,ConvertUnitState(3)))
call DCODE(id)
set u=null
endfunction
function WCD_A takes nothing returns nothing
local integer id
local unit u= GetTriggerUnit()
if WCDTOF[GetPlayerId(GetOwningPlayer(u))] then
    if GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0) then 
    set id=CCODE()
    set DNRH[id]=u
    call TimerStart(DNRT[id],0,false,function WCD_AA)
    endif
endif
set u=null
endfunction
function WCD_ONOFF takes nothing returns nothing
if GetEventPlayerChatString() == "我要无CD" then
    set WCDTOF[GetPlayerId(GetTriggerPlayer())] = true
    call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
    call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
    call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
    call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
    call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
    call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
    call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
    call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
    call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(8)))))
    call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(9)))))
    call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已开启无CD回蓝脚本|r"))
elseif GetEventPlayerChatString() == "关闭无CD" then
    set WCDTOF[GetPlayerId(GetTriggerPlayer())] = false 
    call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已关闭无CD回蓝脚本|r"))
endif
endfunction 
function InitTrig_WCD takes nothing returns nothing
local trigger trgO = CreateTrigger()
local trigger trgS = CreateTrigger()
local integer c=0
loop
exitwhen c>11
call TriggerRegisterPlayerChatEvent(trgO,Player(c),"我要无CD",true)
call TriggerRegisterPlayerChatEvent(trgO,Player(c),"关闭无CD",true)
call TriggerRegisterPlayerUnitEvent(trgS,Player(c),ConvertPlayerUnitEvent(274),null)
set c=c+1
endloop
call TriggerAddAction(trgO,function WCD_ONOFF)
call TriggerAddAction(trgS,function WCD_A)
set trgO=null
set trgS=null
endfunction
// 原地复活
function Trig_yedfsadgsdg_Func005C takes nothing returns boolean
return(IsUnitDeadBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))and(GetEventPlayerChatString()=="我要复活")
endfunction
function Trig_yedfsadgsdg_Conditions takes nothing returns boolean
return(Trig_yedfsadgsdg_Func005C())
endfunction
function Trig_yedfsadgsdg_Actions takes nothing returns nothing
set udg_wanjia=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
set udg_fuhuodian=GetUnitLoc(udg_wanjia)
set udg_fuhuojishi=GetLastCreatedTimerDialogBJ()
call ReviveHeroLoc(udg_wanjia,udg_fuhuodian,false)
call RemoveLocation(udg_fuhuodian)
call TriggerSleepAction(1.)
call DestroyTimerDialog(udg_fuhuojishi)
call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(GetTriggerPlayer())+ "|cFFFFFF00得到了上帝的救赎已复活！|r" ))
endfunction
// 经验倍率
function Trig_jaffc_Actions takes nothing returns nothing
local integer i=0
loop
exitwhen i==11
call SetPlayerHandicapXPBJ(Player(i),10000)  //100=1倍，自己可以改多少！
set i=i+1
endloop
endfunction
function Trig_jaffc_Func001002 takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF00已开启经验加倍模式！|r" )
endfunction
function InitTrig_jaffc takes nothing returns nothing
set gg_trg_jaffc = CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_jaffc, Player(0), "开启加倍", true) // 开启密码,主机开启
call TriggerAddAction(gg_trg_jaffc, function Trig_jaffc_Func001002)
call TriggerAddAction(gg_trg_jaffc, function Trig_jaffc_Actions)
endfunction
function Trig_jaffc1_Actions takes nothing returns nothing
local integer i=0
loop
exitwhen i==11
call SetPlayerHandicapXPBJ(Player(i),100)
set i=i+1
endloop
endfunction
function Trig_jaffc1_Func001002 takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF00已关闭经验加倍模式！|r" )
endfunction
function InitTrig_jaffc1 takes nothing returns nothing
set gg_trg_jaffc1 = CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_jaffc1, Player(0), "关闭加倍", true) // 关闭密码,主机关闭
call TriggerAddAction(gg_trg_jaffc1, function Trig_jaffc1_Func001002)
call TriggerAddAction(gg_trg_jaffc1, function Trig_jaffc1_Actions)
endfunction
// 输入信息加钱
function Trig_qqqq_Conditions takes nothing returns boolean
return(GetEventPlayerChatString()=="财源滚滚") // 这里可改为自己想要的密码 
endfunction
function Trig_qqqq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(50000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)    // 这里改金币数量
call AdjustPlayerStateBJ(50000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)  // 这里改木材数量
endfunction
// 上帝技能
function jhwx takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Xs11 takes integer i returns integer
if bz01[i] then
return strlv11[i]
endif
if bz11[i] then
return agilv11[i]
endif
if bz21[i] then
return intlv11[i]
endif
if bz31[i] then
return alllv11[i]
endif
return 0
endfunction
function P111 takes integer i returns string
local string s
if bz01[i] then
set strlv11[i]=strlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的力量秘法修为进阶为"+I2S(strlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz11[i] then
set agilv11[i]=agilv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的敏捷秘法修为进阶为"+I2S(agilv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz21[i] then
set intlv11[i]=intlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的智力秘法修为进阶为"+I2S(intlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz31[i] then
set alllv11[i]=alllv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的全能秘法修为进阶为"+I2S(alllv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
return null
endfunction
function Sg11 takes integer i,integer m returns boolean
local integer n
local string s
set exp11[i]=exp11[i]+m
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,I2S(exp11[i])+"/"+I2S(lvexp11[i]))
endif
if exp11[i]>=lvexp11[i]then
set exp11[i]=0
set n=0
set s=P111(i)
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“关闭提示”来关闭升级经验的提示。可以通过输入“查看”来查询技能详细情况。")
endif
if Isb[i]==true then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“打开提示”来打开升级经验的提示。可以通过输入“查看”来查询技能详细情况。")
endif
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,s)
set n=n+1
endloop
return true
endif
return false
endfunction
function dj11 takes integer m,integer n,unit u,real r,unit at,real ss,string e ,integer rd returns nothing
local unit uu=null
local group g=null
local integer i
local integer ep
local real x
if GetRandomInt(1,m)<=n then
set i=GetPlayerId(GetOwningPlayer(GetAttacker()))
set ep=11-Xs11(i)
if ep<2 then
set ep=2
endif
call Sg11(i,ep)
set g=CreateGroup()
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),r,Condition(function jhwx))
loop
set uu=FirstOfGroup(g)
exitwhen uu==null
if GetUnitLifePercent(uu)>.0  then
set x = GetUnitState(uu, ConvertUnitState(0))
call UnitDamageTarget(at,uu,ss,true,false,ConvertAttackType(6),ConvertDamageType(26),ConvertWeaponType(0))
set x=  (x-GetUnitState(uu, ConvertUnitState(0)))/ GetUnitState(uu, ConvertUnitState(1))
if x<0.05 and Xs11(i)>=6 and GetUnitLifePercent(uu)>.0 then
if Xs11(i)==rd or rd==7 then
set Ji11[i]=Ji11[i]*2
set Ji12[i]=Ji12[i]+1
set ep=0
loop
exitwhen ep>11
call DisplayTextToPlayer(Player(ep),0,0,sss1+GetPlayerName(Player(i))+"的隐藏技能发生了神奇的进化，技能威力加强了一倍！")
set ep=ep+1
endloop
return
endif
endif
call DestroyEffect(AddSpecialEffectTarget(e,uu,"overhead"))
call GroupRemoveUnit(g,uu)
endif
endloop
call DestroyGroup(g)
set uu=null
set g=null
endif
endfunction
function Ss11 takes integer str,integer agi,integer int,integer lv,integer m1,integer m2,integer m3,integer m4,real xs returns real
local real n
set n=(str*m1+agi*m2+int*m3)*lv*xs
if m4>1 then
set n=(str+agi+int)*lv*xs*m4
endif
return n
endfunction
function Trig_x1_Conditions takes nothing returns boolean
local integer i=0
if b11==false then
set b11=true
call DialogClear(dk11)
set an11[0]=DialogAddButton(dk11,"选择力量（力量型的会发挥最大威力）",0)
set an11[1]=DialogAddButton(dk11,"选择敏捷（敏捷型的会发挥最大威力）",0)
set an11[2]=DialogAddButton(dk11,"选择智力（智力型的会发挥最大威力）",0)
set an11[3]=DialogAddButton(dk11,"选择全能（属性平均的会发挥最大威力）",0)
call DialogSetMessage(dk11,"请选择一个")
loop
exitwhen i>12
call DialogDisplay(Player(i),dk11,true)
set i=i+1
endloop
endif
return true
endfunction
function Dk11 takes button b,integer i,string t returns boolean
if GetClickedButton()==b then
set bz123[i]=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,t)
return true
endif
return false
endfunction
function Trig_x2_Conditions takes nothing returns boolean
local integer i=0
local string s="-----------欢迎使用“上帝技能”，输入“打开提示”打开升级经验提示，输入“关闭提示”关闭升级经验提示，输入“查看”查询技能详细情况。"
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==false then
if Dk11(an11[0],i,sss1+" 选择了力量型附加技能 "+s)then
set bz01[i]=true
endif
if Dk11(an11[1],i,sss1+" 选择了敏捷型附加技能 "+s)then
set bz11[i]=true
endif
if Dk11(an11[2],i,sss1+" 选择了智力型附加技能 "+s)then
set bz21[i]=true
endif
if Dk11(an11[3],i,sss1+" 选择了全能型附加技能 "+s)then
set bz31[i]=true
endif
endif
return true
endfunction
function S2O11 takes string orderIdString returns integer
local integer orderId
set orderId=OrderId(orderIdString)
if(orderId!=0)then
return orderId
endif
set orderId=UnitId(orderIdString)
if(orderId!=0)then
return orderId
endif
return 0
endfunction
function Trig_x3_Conditions takes nothing returns boolean
local location p=null
local unit u=null
if GetIssuedOrderId()==S2O11("move")and bz123[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
set u=GetTriggerUnit()
set p=GetOrderPointLoc()
call SetUnitX(u,GetLocationX(p))
call SetUnitY(u,GetLocationY(p))
call RemoveLocation(p)
set u=null
endif
return true
endfunction
function Ppx takes integer i,integer n returns integer 
return Ji11[i]*n
endfunction
function Px11 takes integer i,integer m returns integer
if bz01[i] and m==0 then
return Ppx(i,4)
endif
if bz11[i] and m==1 then
return Ppx(i,4)
endif
if bz21[i] and m==2 then
return Ppx(i,6)
endif
if bz31[i] and m==3 then
return Ppx(i,2)
endif
return 1
endfunction
function Fx11 takes integer lv returns integer
local integer n
set n=R2I(SquareRoot(GetRandomReal(1,GetRandomInt(1,lv+2)*GetRandomInt(1,2+lv)))-1)
if n>lv then
set n=lv
if n>7 then
set n=7
endif
endif
if n<1 then
set n=1
endif
return n 
endfunction
function Trig_x4_Conditions takes nothing returns boolean
local integer i
local unit ua
local unit u
local integer str
local integer agi
local integer int
local integer lv
local real sh
local string array s
local integer n
set ua=GetAttacker()
set u=GetTriggerUnit()
set i=GetPlayerId(GetOwningPlayer(ua))
if bz123[i] and IsUnitType(ua,ConvertUnitType(0)) then
set s[1]="Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl"
set s[2]="Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl"
set s[3]="Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl"
set s[4]="Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl"
set s[5]="Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBase.mdl"
set s[6]="units\\human\\phoenix\\phoenix.mdl"
set s[7]="units\\demon\\Infernal\\Infernal.mdl"
set str=GetHeroStr(ua,true)
set agi=GetHeroAgi(ua,true)
set int=GetHeroInt(ua,true)
set lv=Xs11(i)
set n=Fx11(lv)
set sh=Ss11(str,agi,int,lv,Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),n*n)
call dj11('d',2+2*lv,u,200+50*lv+n*100,ua,sh,s[n],n)
endif
set ua=null
set u=null
return true
endfunction
function Trig_x5_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetOwningPlayer(GetKillingUnit()))
if bz123[i] and IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetKillingUnit())) then
if IsUnitType(GetTriggerUnit(),ConvertUnitType(0)) then
call Sg11(i,10)
else
call Sg11(i,1)
endif
endif
return true
endfunction
function Fj11 takes nothing returns nothing
local integer n=0
if b11==false then
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,sss1+" 任意玩家输入“上帝技能”可打开隐藏技能！，输入“打开提示”打开升级经验提示，输入“关闭提示”关闭升级经验提示，输入“查看”查询技能详细情况。")
set n=n+1
endloop
endif
endfunction
function Tt111 takes trigger trig, playerunitevent whichEvent returns nothing
local integer index
set index = 0
loop
call TriggerRegisterPlayerUnitEvent(trig, Player(index), whichEvent, null)
set index = index + 1
exitwhen index == 16
endloop
endfunction
function Trig_x7_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==false then
set Isb[i]=true
return true
endif
return false
endfunction
function Trig_x6_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==true then
set Isb[i]=false
return true
endif
return false
endfunction
function Gmu takes player whichPlayer, boolexpr filter returns group
local group g = CreateGroup()
call GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
call DestroyBoolExpr(filter)
return g
endfunction
function Zho takes real m returns string
if m<= 1000000 then
return I2S(R2I(m))
endif
if m>1000000 and m<=100000000 then
return R2S(m/10000)+"万"
endif
if m>100000000 then
return R2S(m/100000000)+"亿"
endif
return null
endfunction
function Trig_x8_Conditions takes nothing returns boolean
local integer i
local integer j
local unit u
local integer str
local integer agi
local integer int
set i=GetPlayerId(GetTriggerPlayer())
set u= FirstOfGroup(Gmu(Player(i), null))
set str=GetHeroStr(u,true)
set agi=GetHeroAgi(u,true)
set int=GetHeroInt(u,true)
if bz123[i]==true then
set j=Xs11(i)
call DisplayTextToPlayer(Player(i),0,0,sss2+" 以下是您的隐藏技能的详细信息：")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前等级："+I2S(j)+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前经验："+I2S(exp11[i]))
call DisplayTextToPlayer(Player(i),0,0,sss1+"进化等级："+I2S(Ji12[i])+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"距下一级："+I2S(lvexp11[i]-exp11[i])+"的经验")
call DisplayTextToPlayer(Player(i),0,0,sss1+"发动几率："+I2S(2+2*j)+"% ")
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小范围："+I2S(300+50*j))
if j>7 then
set j=7
endif
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大范围："+I2S(200+50*Xs11(i)+j*100))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),1)))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),j*j)))
return true
endif
return false
endfunction
function Txt takes trigger t,string s returns nothing
local integer i
set i=0
loop
exitwhen i==12
call TriggerRegisterPlayerChatEvent(t,Player(i),s,true)
set i=i+1
endloop
endfunction
function SDMJ takes nothing returns nothing
local trigger t
local integer i
local timer tt
set dk11=DialogCreate()
set i=0
loop
exitwhen(i>12)
set bz01[i]=false
set bz11[i]=false
set bz21[i]=false
set bz31[i]=false
set bz123[i]=false
set exp11[i]=0
set lvexp11[i]=200
set strlv11[i]=1
set agilv11[i]=1
set intlv11[i]=1
set alllv11[i]=1
set Ji11[i]=1
set Ji12[i]=0
set Isb[i]=false
set i=i+1
endloop
set tt=CreateTimer()
call TimerStart(tt,60,true,function Fj11)
set tt=null
set t=CreateTrigger()
call Txt(t,"上帝技能")
call TriggerAddCondition(t,Condition(function Trig_x1_Conditions))
set t=CreateTrigger()
call Txt(t,"打开提示")
call TriggerAddCondition(t,Condition(function Trig_x6_Conditions))
set t=CreateTrigger()
call Txt(t,"关闭提示")
call TriggerAddCondition(t,Condition(function Trig_x7_Conditions))
set t=CreateTrigger()
call Txt(t,"查看")
call TriggerAddCondition(t,Condition(function Trig_x8_Conditions))
set t=CreateTrigger()
call TriggerRegisterDialogEvent(t,dk11)
call TriggerAddCondition(t,Condition(function Trig_x2_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(39))
call TriggerAddCondition(t,Condition(function Trig_x3_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(18))
call TriggerAddCondition(t,Condition(function Trig_x4_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(20))
call TriggerAddCondition(t,Condition(function Trig_x5_Conditions))
set t=null
endfunction
// 诸神领域
function Trig_Fire_Func001Func001Func015C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(0))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Fire_Func001Func001C takes nothing returns boolean
return(Trig_Fire_Func001Func001Func015C())
endfunction
function Trig_Fire_Func001A takes nothing returns nothing
if(Trig_Fire_Func001Func001C())then
set udg_bFire=true
call PanCameraToTimedLocForPlayer(Player(0),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF001|R|CFFFF00002|R|CFF00FF00,3"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FFbbs.07073.com")
call SetUnitVertexColor(GetEnumUnit(),255,0,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Doodads\\Cinematic\\TownBurningFireEmitter\\TownBurningFireEmitter.mdl")
call CreateTextTagUnitBJ("诸神领域-Fire",GetEnumUnit(),0,20.,'d',.0,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_Fire_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(0)),function Trig_Fire_Func001A)
endfunction
function Trig_Fire1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(0))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(0)))and(udg_bFire)
endfunction
function Trig_Fire1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Fire1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Fire1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Fire1_Func006Func001001003001(),Trig_Fire1_Func006Func001001003002())
endfunction
function Trig_Fire1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Fire1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Fire1_Actions takes nothing returns nothing
if(Trig_Fire1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Fire1_Func006Func001001003)),function Trig_Fire1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Fire2_Conditions takes nothing returns boolean
return(udg_bFire)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Fire2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Fire3_Conditions takes nothing returns boolean
return(udg_bFire)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Fire3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Fire4_Conditions takes nothing returns boolean
return(udg_bFire)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Fire4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Fire4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Fire4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Fire4_Func001001003001(),Trig_Fire4_Func001001003002())
endfunction
function Trig_Fire4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Fire4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Fire4_Func001001003)),function Trig_Fire4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_Ice_Func001Func001Func018C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(1))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Ice_Func001Func001C takes nothing returns boolean
return(Trig_Ice_Func001Func001Func018C())
endfunction
function Trig_Ice_Func001A takes nothing returns nothing
if(Trig_Ice_Func001Func001C())then
set udg_bIce=true
call EnableTrigger(gg_trg_Ice1)
call EnableTrigger(gg_trg_Ice2)
call EnableTrigger(gg_trg_Ice3)
call PanCameraToTimedLocForPlayer(Player(1),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFF0000FF冰神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),0,0,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Doodads\\Cinematic\\TownBurningFireEmitterBlue\\TownBurningFireEmitterBlue.mdl")
call CreateTextTagUnitBJ("诸神领域-Ice",GetEnumUnit(),0,20.,.0,.0,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_Ice_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(1)),function Trig_Ice_Func001A)
endfunction
function Trig_Ice1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(1))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(1)))and(udg_bIce)
endfunction
function Trig_Ice1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Ice1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Ice1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Ice1_Func006Func001001003001(),Trig_Ice1_Func006Func001001003002())
endfunction
function Trig_Ice1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Ice1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Ice1_Actions takes nothing returns nothing
if(Trig_Ice1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Ice1_Func006Func001001003)),function Trig_Ice1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Ice2_Conditions takes nothing returns boolean
return(udg_bIce)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Ice2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Ice3_Conditions takes nothing returns boolean
return(udg_bIce)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Ice3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Ice4_Conditions takes nothing returns boolean
return(udg_bIce)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Ice4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Ice4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Ice4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Ice4_Func001001003001(),Trig_Ice4_Func001001003002())
endfunction
function Trig_Ice4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Ice4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Ice4_Func001001003)),function Trig_Ice4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_Bolt_Func001Func001Func018C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(2))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Bolt_Func001Func001C takes nothing returns boolean
return(Trig_Bolt_Func001Func001Func018C())
endfunction
function Trig_Bolt_Func001A takes nothing returns nothing
if(Trig_Bolt_Func001Func001C())then
set udg_bBolt=true
call EnableTrigger(gg_trg_Bolt1)
call EnableTrigger(gg_trg_Bolt2)
call EnableTrigger(gg_trg_Bolt3)
call PanCameraToTimedLocForPlayer(Player(2),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFF00FFFF雷神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),0,255,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call CreateTextTagUnitBJ("诸神领域-Bolt",GetEnumUnit(),0,20.,.0,100.,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_Bolt_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(2)),function Trig_Bolt_Func001A)
endfunction
function Trig_Bolt1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(2))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(2)))and(udg_bBolt)
endfunction
function Trig_Bolt1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Bolt1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Bolt1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Bolt1_Func006Func001001003001(),Trig_Bolt1_Func006Func001001003002())
endfunction
function Trig_Bolt1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Bolt1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Bolt1_Actions takes nothing returns nothing
if(Trig_Bolt1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Bolt1_Func006Func001001003)),function Trig_Bolt1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Bolt2_Conditions takes nothing returns boolean
return(udg_bBolt)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Bolt2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Bolt3_Conditions takes nothing returns boolean
return(udg_bBolt)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Bolt3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Bolt4_Conditions takes nothing returns boolean
return(udg_bBolt)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Bolt4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Bolt4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Bolt4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Bolt4_Func001001003001(),Trig_Bolt4_Func001001003002())
endfunction
function Trig_Bolt4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Bolt4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Bolt4_Func001001003)),function Trig_Bolt4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_Moon_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(3))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Moon_Func001Func001C takes nothing returns boolean
return(Trig_Moon_Func001Func001Func016C())
endfunction
function Trig_Moon_Func001A takes nothing returns nothing
if(Trig_Moon_Func001Func001C())then
set udg_bMoon=true
call EnableTrigger(gg_trg_Moon1)
call EnableTrigger(gg_trg_Moon2)
call EnableTrigger(gg_trg_Moon3)
call PanCameraToTimedLocForPlayer(Player(3),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|C00FF00FF月亮女神领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,0,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call CreateTextTagUnitBJ("诸神领域-Moon",GetEnumUnit(),0,20.,100.,.0,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_Moon_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(3)),function Trig_Moon_Func001A)
endfunction
function Trig_Moon1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(3))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(3)))and(udg_bMoon)
endfunction
function Trig_Moon1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Moon1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Moon1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Moon1_Func006Func001001003001(),Trig_Moon1_Func006Func001001003002())
endfunction
function Trig_Moon1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Moon1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Moon1_Actions takes nothing returns nothing
if(Trig_Moon1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Moon1_Func006Func001001003)),function Trig_Moon1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Moon2_Conditions takes nothing returns boolean
return(udg_bMoon)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Moon2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Moon3_Conditions takes nothing returns boolean
return(udg_bMoon)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Moon3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Moon4_Conditions takes nothing returns boolean
return(udg_bMoon)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Moon4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Moon4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Moon4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Moon4_Func001001003001(),Trig_Moon4_Func001001003002())
endfunction
function Trig_Moon4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\shadowstrike\\shadowstrike.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Moon4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Moon4_Func001001003)),function Trig_Moon4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_Light_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(4))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Light_Func001Func001C takes nothing returns boolean
return(Trig_Light_Func001Func001Func016C())
endfunction
function Trig_Light_Func001A takes nothing returns nothing
if(Trig_Light_Func001Func001C())then
set udg_bLight=true
call EnableTrigger(gg_trg_Light1)
call EnableTrigger(gg_trg_Light2)
call EnableTrigger(gg_trg_Light3)
call PanCameraToTimedLocForPlayer(Player(4),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFFFFFF00光之神领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,255,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonRain.mdl")
call CreateTextTagUnitBJ("诸神领域-Light",GetEnumUnit(),0,20.,100.,100.,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_Light_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(4)),function Trig_Light_Func001A)
endfunction
function Trig_Light1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(4))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(4)))and(udg_bLight)
endfunction
function Trig_Light1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Light1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Light1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Light1_Func006Func001001003001(),Trig_Light1_Func006Func001001003002())
endfunction
function Trig_Light1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Light1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Light1_Actions takes nothing returns nothing
if(Trig_Light1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Light1_Func006Func001001003)),function Trig_Light1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Light2_Conditions takes nothing returns boolean
return(udg_bLight)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Light2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Light3_Conditions takes nothing returns boolean
return(udg_bLight)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Light3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Light4_Conditions takes nothing returns boolean
return(udg_bLight)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Light4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Light4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Light4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Light4_Func001001003001(),Trig_Light4_Func001001003002())
endfunction
function Trig_Light4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\InnerFire\\InnerFireTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Light4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Light4_Func001001003)),function Trig_Light4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_Wind_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(5))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_Wind_Func001Func001C takes nothing returns boolean
return(Trig_Wind_Func001Func001Func016C())
endfunction
function Trig_Wind_Func001A takes nothing returns nothing
if(Trig_Wind_Func001Func001C())then
set udg_bWind=true
call EnableTrigger(gg_trg_Wind1)
call EnableTrigger(gg_trg_Wind2)
call EnableTrigger(gg_trg_Wind3)
call PanCameraToTimedLocForPlayer(Player(5),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFFFFAA00风神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,170,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call CreateTextTagUnitBJ("|CFFFFAA00诸神领域-Wind|R",GetEnumUnit(),0,20.,100.,100.,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_Wind_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(5)),function Trig_Wind_Func001A)
endfunction
function Trig_Wind1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(5))and(IsUnitEnemy(GetTriggerUnit(),Player(5)))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(udg_bWind)
endfunction
function Trig_Wind1_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Wind1_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_Wind1_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Wind1_Func006Func001001003001(),Trig_Wind1_Func006Func001001003002())
endfunction
function Trig_Wind1_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Wind1_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_Wind1_Actions takes nothing returns nothing
if(Trig_Wind1_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Wind1_Func006Func001001003)),function Trig_Wind1_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_Wind2_Conditions takes nothing returns boolean
return(udg_bWind)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_Wind2_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_Wind3_Conditions takes nothing returns boolean
return(udg_bWind)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_Wind3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_Wind4_Conditions takes nothing returns boolean
return(udg_bWind)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_Wind4_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_Wind4_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_Wind4_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_Wind4_Func001001003001(),Trig_Wind4_Func001001003002())
endfunction
function Trig_Wind4_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_Wind4_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Wind4_Func001001003)),function Trig_Wind4_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
// 无界变态版
function Wu_Jie_Bian_Huan_1 takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>8)
set udg_bWu_Jie_Bian_Huan[i]=false
set i=i+1
endloop
set udg_Red_Twist_Group1=CreateGroup()
set udg_Red_Twist_Group2=CreateGroup()
set udg_Red_Twist_Loop=0
set udg_Blue_Twist_Group1=CreateGroup()
set udg_Blue_Twist_Group2=CreateGroup()
set udg_Blue_Twist_Loop=0
set udg_Cyan_Twist_Group1=CreateGroup()
set udg_Cyan_Twist_Group2=CreateGroup()
set udg_Cyan_Twist_Loop=0
set udg_Purple_Twist_Group1=CreateGroup()
set udg_Purple_Twist_Group2=CreateGroup()
set udg_Purple_Twist_Loop=0
set udg_Yellow_Twist_Group1=CreateGroup()
set udg_Yellow_Twist_Group2=CreateGroup()
set udg_Yellow_Twist_Loop=0
set udg_Orange_Twist_Group1=CreateGroup()
set udg_Orange_Twist_Group2=CreateGroup()
set udg_Orange_Twist_Loop=0
set udg_Green_Twist_Group1=CreateGroup()
set udg_Green_Twist_Group2=CreateGroup()
set udg_Green_Twist_Loop=0
set udg_Pink_Twist_Group1=CreateGroup()
set udg_Pink_Twist_Group2=CreateGroup()
set udg_Pink_Twist_Loop=0
set i=0
loop
exitwhen(i>8)
set udg_iNew_Wu_Jie_Ablity[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>8)
set udg_WuJie_Manoy[i]=0
set i=i+1
endloop
set udg_WuJiw_Help=""
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Start_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_Red_Fire)
call DisableTrigger(gg_trg_Red_Fire_Left)
call DisableTrigger(gg_trg_Red_Fire_Down)
call DisableTrigger(gg_trg_Red_Fire_Right)
call DisableTrigger(gg_trg_Blue_Ice)
call DisableTrigger(gg_trg_Blue_Ice_Down)
call DisableTrigger(gg_trg_Blue_Ice_Right)
call DisableTrigger(gg_trg_Blue_Ice_Up)
call DisableTrigger(gg_trg_Cyan_Bolt_Right)
call DisableTrigger(gg_trg_Cyan_Bolt_Up)
call DisableTrigger(gg_trg_Cyan_Bolt_Left)
call DisableTrigger(gg_trg_Cyan_Bolt)
call DisableTrigger(gg_trg_Purple_Moon)
call DisableTrigger(gg_trg_Purple_Moon_Down)
call DisableTrigger(gg_trg_Purple_Moon_Left)
call DisableTrigger(gg_trg_Purple_Moon_Up)
call DisableTrigger(gg_trg_Yellow_Light)
call DisableTrigger(gg_trg_Yellow_Light_Down)
call DisableTrigger(gg_trg_Yellow_Light_Left)
call DisableTrigger(gg_trg_Yellow_Light_Right)
call DisableTrigger(gg_trg_Orange_Wind)
call DisableTrigger(gg_trg_Orange_Wind_Down)
call DisableTrigger(gg_trg_Orange_Wind_Left)
call DisableTrigger(gg_trg_Orange_Wind_Up)
call DisableTrigger(gg_trg_Green_Wood)
call DisableTrigger(gg_trg_Green_Wood_Left)
call DisableTrigger(gg_trg_Green_Wood_Right)
call DisableTrigger(gg_trg_Green_Wood_Up)
call DisableTrigger(gg_trg_Pink_Pink_Pink)
call DisableTrigger(gg_trg_Pink_Pink_Right)
call DisableTrigger(gg_trg_Pink_Pink_Down)
call DisableTrigger(gg_trg_Pink_Pink_Up)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Start takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Start=CreateTrigger()
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Start,function Trig_New_Wu_Jie_Bian_Huan_Start_Actions)
endfunction
function Trig_Cloce_Wu_Jie_Bian_Huan_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
return false
endif
return true
endfunction
function Trig_Cloce_Wu_Jie_Bian_Huan_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=false
call SetUnitVertexColor(udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())],255,255,255,255)
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=null
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF关闭了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000　III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
endfunction
function InitTrig_Cloce_Wu_Jie_Bian_Huan takes nothing returns nothing
set gg_trg_Cloce_Wu_Jie_Bian_Huan=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(0),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(1),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(2),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(3),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(4),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(5),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(6),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(7),"变幻",true)
call TriggerAddCondition(gg_trg_Cloce_Wu_Jie_Bian_Huan,Condition(function Trig_Cloce_Wu_Jie_Bian_Huan_Conditions))
call TriggerAddAction(gg_trg_Cloce_Wu_Jie_Bian_Huan,function Trig_Cloce_Wu_Jie_Bian_Huan_Actions)
endfunction
function Trig_Wu_Jie_Help_Actions takes nothing returns nothing
call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED,"|CFF00FF00无界QQ群|R","|CFF00FF00无界16群：69595123|R","ReplaceableTextures\\CommandButtons\\BTNManaShield.blp")
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
endfunction
function InitTrig_Wu_Jie_Help takes nothing returns nothing
set gg_trg_Wu_Jie_Help=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Wu_Jie_Help,5)
call TriggerAddAction(gg_trg_Wu_Jie_Help,function Trig_Wu_Jie_Help_Actions)
endfunction
function Trig_Red_Fire_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Red_Fire_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Left)
endfunction
function InitTrig_Red_Fire_Up takes nothing returns nothing
set gg_trg_Red_Fire_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Up,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Red_Fire_Up,function Trig_Red_Fire_Up_Actions)
endfunction
function Trig_Red_Fire_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Down)
endfunction
function InitTrig_Red_Fire_Left takes nothing returns nothing
set gg_trg_Red_Fire_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Left,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Red_Fire_Left,function Trig_Red_Fire_Left_Actions)
endfunction
function Trig_Red_Fire_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Right)
endfunction
function InitTrig_Red_Fire_Down takes nothing returns nothing
set gg_trg_Red_Fire_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Down,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Red_Fire_Down,function Trig_Red_Fire_Down_Actions)
endfunction
function Trig_Red_Fire_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire)
endfunction
function InitTrig_Red_Fire_Right takes nothing returns nothing
set gg_trg_Red_Fire_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Right,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Red_Fire_Right,function Trig_Red_Fire_Right_Actions)
endfunction
function Trig_Red_Fire_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(0)))then
return false
endif
return true
endfunction
function Trig_Red_Fire_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(0),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),255,0,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Red_Fire takes nothing returns nothing
set gg_trg_Red_Fire=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Red_Fire,Player(0),true)
call TriggerAddCondition(gg_trg_Red_Fire,Condition(function Trig_Red_Fire_Conditions))
call TriggerAddAction(gg_trg_Red_Fire,function Trig_Red_Fire_Actions)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Red_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Red_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Red_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Red_Twist_Group1,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Red_Twist_Loop=1
loop
exitwhen udg_Red_Twist_Loop>4
call ForGroupBJ(udg_Red_Twist_Group2,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Red_Twist_Loop=udg_Red_Twist_Loop+1
endloop
call ForGroupBJ(udg_Red_Twist_Group2,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Red_Twist_Group1)
call GroupClear(udg_Red_Twist_Group2)
endfunction
function InitTrig_Red_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,Player(0),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Blue_Ice_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Blue_Ice_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Down)
endfunction
function InitTrig_Blue_Ice_Left takes nothing returns nothing
set gg_trg_Blue_Ice_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Left,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Blue_Ice_Left,function Trig_Blue_Ice_Left_Actions)
endfunction
function Trig_Blue_Ice_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Right)
endfunction
function InitTrig_Blue_Ice_Down takes nothing returns nothing
set gg_trg_Blue_Ice_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Down,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Blue_Ice_Down,function Trig_Blue_Ice_Down_Actions)
endfunction
function Trig_Blue_Ice_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Up)
endfunction
function InitTrig_Blue_Ice_Right takes nothing returns nothing
set gg_trg_Blue_Ice_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Right,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Blue_Ice_Right,function Trig_Blue_Ice_Right_Actions)
endfunction
function Trig_Blue_Ice_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice)
endfunction
function InitTrig_Blue_Ice_Up takes nothing returns nothing
set gg_trg_Blue_Ice_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Up,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Blue_Ice_Up,function Trig_Blue_Ice_Up_Actions)
endfunction
function Trig_Blue_Ice_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(1)))then
return false
endif
return true
endfunction
function Trig_Blue_Ice_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(1),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),0,0,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Blue_Ice takes nothing returns nothing
set gg_trg_Blue_Ice=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Blue_Ice,Player(1),true)
call TriggerAddCondition(gg_trg_Blue_Ice,Condition(function Trig_Blue_Ice_Conditions))
call TriggerAddAction(gg_trg_Blue_Ice,function Trig_Blue_Ice_Actions)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Blue_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Blue_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Blue_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Blue_Twist_Group1,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Blue_Twist_Loop=1
loop
exitwhen udg_Blue_Twist_Loop>4
call ForGroupBJ(udg_Blue_Twist_Group2,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Blue_Twist_Loop=udg_Blue_Twist_Loop+1
endloop
call ForGroupBJ(udg_Blue_Twist_Group2,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Blue_Twist_Group1)
call GroupClear(udg_Blue_Twist_Group2)
endfunction
function InitTrig_Blue_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,Player(1),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Cyan_Bolt_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Cyan_Bolt_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Right)
endfunction
function InitTrig_Cyan_Bolt_Down takes nothing returns nothing
set gg_trg_Cyan_Bolt_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Down,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Cyan_Bolt_Down,function Trig_Cyan_Bolt_Down_Actions)
endfunction
function Trig_Cyan_Bolt_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Up)
endfunction
function InitTrig_Cyan_Bolt_Right takes nothing returns nothing
set gg_trg_Cyan_Bolt_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Right,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Cyan_Bolt_Right,function Trig_Cyan_Bolt_Right_Actions)
endfunction
function Trig_Cyan_Bolt_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Left)
endfunction
function InitTrig_Cyan_Bolt_Up takes nothing returns nothing
set gg_trg_Cyan_Bolt_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Up,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Cyan_Bolt_Up,function Trig_Cyan_Bolt_Up_Actions)
endfunction
function Trig_Cyan_Bolt_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt)
endfunction
function InitTrig_Cyan_Bolt_Left takes nothing returns nothing
set gg_trg_Cyan_Bolt_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Left,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Cyan_Bolt_Left,function Trig_Cyan_Bolt_Left_Actions)
endfunction
function Trig_Cyan_Bolt_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(2)))then
return false
endif
return true
endfunction
function Trig_Cyan_Bolt_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(2),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),0,255,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Cyan_Bolt takes nothing returns nothing
set gg_trg_Cyan_Bolt=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Cyan_Bolt,Player(2),true)
call TriggerAddCondition(gg_trg_Cyan_Bolt,Condition(function Trig_Cyan_Bolt_Conditions))
call TriggerAddAction(gg_trg_Cyan_Bolt,function Trig_Cyan_Bolt_Actions)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Cyan_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Cyan_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Cyan_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Cyan_Twist_Group1,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Cyan_Twist_Loop=1
loop
exitwhen udg_Cyan_Twist_Loop>4
call ForGroupBJ(udg_Cyan_Twist_Group2,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Cyan_Twist_Loop=udg_Cyan_Twist_Loop+1
endloop
call ForGroupBJ(udg_Cyan_Twist_Group2,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Cyan_Twist_Group1)
call GroupClear(udg_Cyan_Twist_Group2)
endfunction
function InitTrig_Cyan_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,Player(2),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Purple_Moon_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Purple_Moon_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Up)
endfunction
function InitTrig_Purple_Moon_Right takes nothing returns nothing
set gg_trg_Purple_Moon_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Right,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Purple_Moon_Right,function Trig_Purple_Moon_Right_Actions)
endfunction
function Trig_Purple_Moon_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Left)
endfunction
function InitTrig_Purple_Moon_Up takes nothing returns nothing
set gg_trg_Purple_Moon_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Up,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Purple_Moon_Up,function Trig_Purple_Moon_Up_Actions)
endfunction
function Trig_Purple_Moon_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Down)
endfunction
function InitTrig_Purple_Moon_Left takes nothing returns nothing
set gg_trg_Purple_Moon_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Left,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Purple_Moon_Left,function Trig_Purple_Moon_Left_Actions)
endfunction
function Trig_Purple_Moon_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon)
endfunction
function InitTrig_Purple_Moon_Down takes nothing returns nothing
set gg_trg_Purple_Moon_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Down,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Purple_Moon_Down,function Trig_Purple_Moon_Down_Actions)
endfunction
function Trig_Purple_Moon_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(3)))then
return false
endif
return true
endfunction
function Trig_Purple_Moon_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(3),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),255,0,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Purple_Moon takes nothing returns nothing
set gg_trg_Purple_Moon=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Purple_Moon,Player(3),true)
call TriggerAddCondition(gg_trg_Purple_Moon,Condition(function Trig_Purple_Moon_Conditions))
call TriggerAddAction(gg_trg_Purple_Moon,function Trig_Purple_Moon_Actions)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Purple_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Purple_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Purple_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Purple_Twist_Group1,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Purple_Twist_Loop=1
loop
exitwhen udg_Purple_Twist_Loop>4
call ForGroupBJ(udg_Purple_Twist_Group2,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Purple_Twist_Loop=udg_Purple_Twist_Loop+1
endloop
call ForGroupBJ(udg_Purple_Twist_Group2,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Purple_Twist_Group1)
call GroupClear(udg_Purple_Twist_Group2)
endfunction
function InitTrig_Purple_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,Player(3),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Yellow_Light_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Yellow_Light_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Right)
endfunction
function InitTrig_Yellow_Light_Up takes nothing returns nothing
set gg_trg_Yellow_Light_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Up,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Yellow_Light_Up,function Trig_Yellow_Light_Up_Actions)
endfunction
function Trig_Yellow_Light_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Down)
endfunction
function InitTrig_Yellow_Light_Right takes nothing returns nothing
set gg_trg_Yellow_Light_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Right,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Yellow_Light_Right,function Trig_Yellow_Light_Right_Actions)
endfunction
function Trig_Yellow_Light_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Left)
endfunction
function InitTrig_Yellow_Light_Down takes nothing returns nothing
set gg_trg_Yellow_Light_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Down,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Yellow_Light_Down,function Trig_Yellow_Light_Down_Actions)
endfunction
function Trig_Yellow_Light_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light)
endfunction
function InitTrig_Yellow_Light_Left takes nothing returns nothing
set gg_trg_Yellow_Light_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Left,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Yellow_Light_Left,function Trig_Yellow_Light_Left_Actions)
endfunction
function Trig_Yellow_Light_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(4)))then
return false
endif
return true
endfunction
function Trig_Yellow_Light_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(4),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),255,255,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Yellow_Light takes nothing returns nothing
set gg_trg_Yellow_Light=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Yellow_Light,Player(4),true)
call TriggerAddCondition(gg_trg_Yellow_Light,Condition(function Trig_Yellow_Light_Conditions))
call TriggerAddAction(gg_trg_Yellow_Light,function Trig_Yellow_Light_Actions)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Yellow_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Yellow_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Yellow_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Yellow_Twist_Group1,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Yellow_Twist_Loop=1
loop
exitwhen udg_Yellow_Twist_Loop>4
call ForGroupBJ(udg_Yellow_Twist_Group2,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Yellow_Twist_Loop=udg_Yellow_Twist_Loop+1
endloop
call ForGroupBJ(udg_Yellow_Twist_Group2,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Yellow_Twist_Group1)
call GroupClear(udg_Yellow_Twist_Group2)
endfunction
function InitTrig_Yellow_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,Player(4),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Orange_Wind_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Orange_Wind_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Down)
endfunction
function InitTrig_Orange_Wind_Right takes nothing returns nothing
set gg_trg_Orange_Wind_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Right,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Orange_Wind_Right,function Trig_Orange_Wind_Right_Actions)
endfunction
function Trig_Orange_Wind_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Left)
endfunction
function InitTrig_Orange_Wind_Down takes nothing returns nothing
set gg_trg_Orange_Wind_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Down,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Orange_Wind_Down,function Trig_Orange_Wind_Down_Actions)
endfunction
function Trig_Orange_Wind_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Up)
endfunction
function InitTrig_Orange_Wind_Left takes nothing returns nothing
set gg_trg_Orange_Wind_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Left,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Orange_Wind_Left,function Trig_Orange_Wind_Left_Actions)
endfunction
function Trig_Orange_Wind_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind)
endfunction
function InitTrig_Orange_Wind_Up takes nothing returns nothing
set gg_trg_Orange_Wind_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Up,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Orange_Wind_Up,function Trig_Orange_Wind_Up_Actions)
endfunction
function Trig_Orange_Wind_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(5)))then
return false
endif
return true
endfunction
function Trig_Orange_Wind_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(5),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),255,170,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Orange_Wind takes nothing returns nothing
set gg_trg_Orange_Wind=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Orange_Wind,Player(5),true)
call TriggerAddCondition(gg_trg_Orange_Wind,Condition(function Trig_Orange_Wind_Conditions))
call TriggerAddAction(gg_trg_Orange_Wind,function Trig_Orange_Wind_Actions)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Orange_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Orange_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Orange_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Orange_Twist_Group1,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Orange_Twist_Loop=1
loop
exitwhen udg_Orange_Twist_Loop>4
call ForGroupBJ(udg_Orange_Twist_Group2,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Orange_Twist_Loop=udg_Orange_Twist_Loop+1
endloop
call ForGroupBJ(udg_Orange_Twist_Group2,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Orange_Twist_Group1)
call GroupClear(udg_Orange_Twist_Group2)
endfunction
function InitTrig_Orange_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,Player(5),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Green_Wood_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Green_Wood_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Left)
endfunction
function InitTrig_Green_Wood_Down takes nothing returns nothing
set gg_trg_Green_Wood_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Down,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Green_Wood_Down,function Trig_Green_Wood_Down_Actions)
endfunction
function Trig_Green_Wood_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Up)
endfunction
function InitTrig_Green_Wood_Left takes nothing returns nothing
set gg_trg_Green_Wood_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Left,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Green_Wood_Left,function Trig_Green_Wood_Left_Actions)
endfunction
function Trig_Green_Wood_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Right)
endfunction
function InitTrig_Green_Wood_Up takes nothing returns nothing
set gg_trg_Green_Wood_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Up,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Green_Wood_Up,function Trig_Green_Wood_Up_Actions)
endfunction
function Trig_Green_Wood_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood)
endfunction
function InitTrig_Green_Wood_Right takes nothing returns nothing
set gg_trg_Green_Wood_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Right,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Green_Wood_Right,function Trig_Green_Wood_Right_Actions)
endfunction
function Trig_Green_Wood_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(6)))then
return false
endif
return true
endfunction
function Trig_Green_Wood_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(6),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),0,255,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Green_Wood takes nothing returns nothing
set gg_trg_Green_Wood=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Green_Wood,Player(6),true)
call TriggerAddCondition(gg_trg_Green_Wood,Condition(function Trig_Green_Wood_Conditions))
call TriggerAddAction(gg_trg_Green_Wood,function Trig_Green_Wood_Actions)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Green_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Green_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 0.50),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Green_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Green_Twist_Group1,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Green_Twist_Loop=1
loop
exitwhen udg_Green_Twist_Loop>4
call ForGroupBJ(udg_Green_Twist_Group2,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Green_Twist_Loop=udg_Green_Twist_Loop+1
endloop
call ForGroupBJ(udg_Green_Twist_Group2,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Green_Twist_Group1)
call GroupClear(udg_Green_Twist_Group2)
endfunction
function InitTrig_Green_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,Player(6),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Pink_Pink_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Pink_Pink_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Up)
endfunction
function InitTrig_Pink_Pink_Left takes nothing returns nothing
set gg_trg_Pink_Pink_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Left,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Pink_Pink_Left,function Trig_Pink_Pink_Left_Actions)
endfunction
function Trig_Pink_Pink_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Right)
endfunction
function InitTrig_Pink_Pink_Up takes nothing returns nothing
set gg_trg_Pink_Pink_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Up,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Pink_Pink_Up,function Trig_Pink_Pink_Up_Actions)
endfunction
function Trig_Pink_Pink_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Down)
endfunction
function InitTrig_Pink_Pink_Right takes nothing returns nothing
set gg_trg_Pink_Pink_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Right,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Pink_Pink_Right,function Trig_Pink_Pink_Right_Actions)
endfunction
function Trig_Pink_Pink_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Pink)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Pink)
endfunction
function InitTrig_Pink_Pink_Down takes nothing returns nothing
set gg_trg_Pink_Pink_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Down,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Pink_Pink_Down,function Trig_Pink_Pink_Down_Actions)
endfunction
function Trig_Pink_Pink_Pink_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(7)))then
return false
endif
return true
endfunction
function Trig_Pink_Pink_Pink_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(7),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|cFF00FF00无界变幻III变态版 |r|cFFFFAA00修改：|r|cFFFFFF00 hellour|R")
call SetUnitVertexColor(GetTriggerUnit(),255,128,192,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Pink_Pink_Pink takes nothing returns nothing
set gg_trg_Pink_Pink_Pink=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Pink_Pink_Pink,Player(7),true)
call TriggerAddCondition(gg_trg_Pink_Pink_Pink,Condition(function Trig_Pink_Pink_Pink_Conditions))
call TriggerAddAction(gg_trg_Pink_Pink_Pink,function Trig_Pink_Pink_Pink_Actions)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Pink_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Pink_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Pink_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Pink_Twist_Group1,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Pink_Twist_Loop=1
loop
exitwhen udg_Pink_Twist_Loop>4
call ForGroupBJ(udg_Pink_Twist_Group2,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Pink_Twist_Loop=udg_Pink_Twist_Loop+1
endloop
call ForGroupBJ(udg_Pink_Twist_Group2,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Pink_Twist_Group1)
call GroupClear(udg_Pink_Twist_Group2)
endfunction
function InitTrig_Pink_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,Player(7),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroStr(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,25.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroStr(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,25.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroInt(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,25.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroInt(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,25.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroInt(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,25.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func012C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func013C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Actions takes nothing returns nothing
set udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,10)
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(812.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(850.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(812.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func012C())then
call CreateTextTagUnitBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(22.00,24.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func013C())then
call CreateTextTagUnitBJ("|cFF00FF00毁|r|cFFFFFF00灭|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(24.00,26.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Ablity_1 takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Conditions takes nothing returns boolean
if(not(IsUnitIllusionBJ(GetAttacker())==true))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(21.00,23.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(21.00,23.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(21.00,23.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(22.00,24.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(22.00,24.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(22.00,24.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func012C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func013C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Actions takes nothing returns nothing
set udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,10)
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 1.00)))+800.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(812.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(850.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(812.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func012C())then
call CreateTextTagUnitBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(21.00,23.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func013C())then
call CreateTextTagUnitBJ("|cFF00FF00毁|r|cFFFFFF00灭|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),23.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),21.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(24.00,26.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Ablity_2 takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Life_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetUnitLifePercent(GetTriggerUnit())<=2.00))then
return false
endif
if(not(GetRandomReal(1.00,10.00)<=2.00))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Life_Actions takes nothing returns nothing
call CreateTextTagUnitBJ("|cFF00FF00天|r|cFFFFFF00使|r|cFFFFAA00降|r|cFFFF5500临|r",GetTriggerUnit(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),100)
call TriggerSleepAction(1.00)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Life takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Life=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Life,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Life,Condition(function Trig_New_Wu_Jie_Bian_Huan_Life_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Life,function Trig_New_Wu_Jie_Bian_Huan_Life_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call CreateTextTagUnitBJ("|cFF00FF00空|r|cFFFFFF00间|r|cFFFFAA00闪|r|cFFFF5500烁|r",GetTriggerUnit(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Anywhere takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Anywhere=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,Condition(function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Death_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Death_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Death takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Death=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Death,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Death,Condition(function Trig_New_Wu_Jie_Bian_Huan_Death_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Death,function Trig_New_Wu_Jie_Bian_Huan_Death_Actions)
endfunction
function Trig_WuJie_Lv_Up_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,20)
endfunction
function InitTrig_WuJie_Lv_Up takes nothing returns nothing
set gg_trg_WuJie_Lv_Up=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_Lv_Up,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_WuJie_Lv_Up,Condition(function Trig_WuJie_Lv_Up_Conditions))
call TriggerAddAction(gg_trg_WuJie_Lv_Up,function Trig_WuJie_Lv_Up_Actions)
endfunction
function Trig_WuJie_EXE_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Func001C takes nothing returns boolean
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Func002C takes nothing returns boolean
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Actions takes nothing returns nothing
if(Trig_WuJie_EXE_Func001C())then
call AddHeroXPSwapped((50*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
if(Trig_WuJie_EXE_Func002C())then
call AddHeroXPSwapped((10*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
endfunction
function InitTrig_WuJie_EXE takes nothing returns nothing
set gg_trg_WuJie_EXE=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_EXE,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_EXE,Condition(function Trig_WuJie_EXE_Conditions))
call TriggerAddAction(gg_trg_WuJie_EXE,function Trig_WuJie_EXE_Actions)
endfunction
function Trig_WuJie_Lv_Up_10_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_10_Func003C takes nothing returns boolean
if(not(GetHeroLevel(GetTriggerUnit())==10))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_10_Actions takes nothing returns nothing
if(Trig_WuJie_Lv_Up_10_Func003C())then
call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10.00,"|CFF00FF00英雄等级达到10级，领悟妙手空空技能|R")
else
endif
endfunction
function InitTrig_WuJie_Lv_Up_10 takes nothing returns nothing
set gg_trg_WuJie_Lv_Up_10=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_Lv_Up_10,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_WuJie_Lv_Up_10,Condition(function Trig_WuJie_Lv_Up_10_Conditions))
call TriggerAddAction(gg_trg_WuJie_Lv_Up_10,function Trig_WuJie_Lv_Up_10_Actions)
endfunction
function Trig_WuJie_KongKong_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func003Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=10)
endfunction
function Trig_WuJie_KongKong_Func003Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<20)
endfunction
function Trig_WuJie_KongKong_Func003C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func003Func004001(),Trig_WuJie_KongKong_Func003Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func004Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=20)
endfunction
function Trig_WuJie_KongKong_Func004Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<30)
endfunction
function Trig_WuJie_KongKong_Func004C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func004Func004001(),Trig_WuJie_KongKong_Func004Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func005Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=30)
endfunction
function Trig_WuJie_KongKong_Func005Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<40)
endfunction
function Trig_WuJie_KongKong_Func005C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func005Func004001(),Trig_WuJie_KongKong_Func005Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func006Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=40)
endfunction
function Trig_WuJie_KongKong_Func006Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<50)
endfunction
function Trig_WuJie_KongKong_Func006C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func006Func004001(),Trig_WuJie_KongKong_Func006Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func007Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=50)
endfunction
function Trig_WuJie_KongKong_Func007Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<60)
endfunction
function Trig_WuJie_KongKong_Func007C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func007Func004001(),Trig_WuJie_KongKong_Func007Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func008Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=60)
endfunction
function Trig_WuJie_KongKong_Func008Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<70)
endfunction
function Trig_WuJie_KongKong_Func008C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func008Func004001(),Trig_WuJie_KongKong_Func008Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func009Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=70)
endfunction
function Trig_WuJie_KongKong_Func009Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<80)
endfunction
function Trig_WuJie_KongKong_Func009C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func009Func004001(),Trig_WuJie_KongKong_Func009Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func010Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=80)
endfunction
function Trig_WuJie_KongKong_Func010Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<90)
endfunction
function Trig_WuJie_KongKong_Func010C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func010Func004001(),Trig_WuJie_KongKong_Func010Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func011Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=90)
endfunction
function Trig_WuJie_KongKong_Func011Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<100)
endfunction
function Trig_WuJie_KongKong_Func011C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func011Func004001(),Trig_WuJie_KongKong_Func011Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func012C takes nothing returns boolean
if(not(GetHeroLevel(GetAttacker())>=100))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Actions takes nothing returns nothing
if(Trig_WuJie_KongKong_Func003C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+500)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func004C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+2000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func005C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+3000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func006C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+5000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func007C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+7500)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func008C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+10000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func009C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+15000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func010C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+20000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func011C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+30000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func012C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*101)+30000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
endfunction
function InitTrig_WuJie_KongKong takes nothing returns nothing
set gg_trg_WuJie_KongKong=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_KongKong,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_KongKong,Condition(function Trig_WuJie_KongKong_Conditions))
call TriggerAddAction(gg_trg_WuJie_KongKong,function Trig_WuJie_KongKong_Actions)
endfunction
function Trig_WuJie_ShuXing_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_ShuXing_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r")
call CreateTextTagUnitBJ("|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r",GetAttacker(),0,10.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ModifyHeroStat(bj_HEROSTAT_STR,GetAttacker(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetAttacker(),bj_MODIFYMETHOD_ADD,20)
call ModifyHeroStat(bj_HEROSTAT_INT,GetAttacker(),bj_MODIFYMETHOD_ADD,20)
endfunction
function InitTrig_WuJie_ShuXing takes nothing returns nothing
set gg_trg_WuJie_ShuXing=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_ShuXing,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_ShuXing,Condition(function Trig_WuJie_ShuXing_Conditions))
call TriggerAddAction(gg_trg_WuJie_ShuXing,function Trig_WuJie_ShuXing_Actions)
endfunction
function Trig_WuJie_ReAblity_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_ReAblity_Actions takes nothing returns nothing
call UnitResetCooldown(GetAttacker())
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|C00FF00FF重置技能CD|R")
endfunction
function InitTrig_WuJie_ReAblity takes nothing returns nothing
set gg_trg_WuJie_ReAblity=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_ReAblity,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_ReAblity,Condition(function Trig_WuJie_ReAblity_Conditions))
call TriggerAddAction(gg_trg_WuJie_ReAblity,function Trig_WuJie_ReAblity_Actions)
endfunction
function Trig_WuJie_FanDan_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_FanDan_Func003C takes nothing returns boolean
if(not(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)==true))then
return false
endif
return true
endfunction
function Trig_WuJie_FanDan_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetAttacker(),"Abilities\\Spells\\Other\\ForkedLightning\\ForkedLightningTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if(Trig_WuJie_FanDan_Func003C())then
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 200.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
else
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 50.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
endif
endfunction
function InitTrig_WuJie_FanDan takes nothing returns nothing
set gg_trg_WuJie_FanDan=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_FanDan,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_FanDan,Condition(function Trig_WuJie_FanDan_Conditions))
call TriggerAddAction(gg_trg_WuJie_FanDan,function Trig_WuJie_FanDan_Actions)
endfunction
function Wu_Jie_Bian_Huan_2 takes nothing returns nothing
call InitTrig_New_Wu_Jie_Bian_Huan_Start()
call InitTrig_Cloce_Wu_Jie_Bian_Huan()
call InitTrig_Wu_Jie_Help()
call InitTrig_Red_Fire_Up()
call InitTrig_Red_Fire_Left()
call InitTrig_Red_Fire_Down()
call InitTrig_Red_Fire_Right()
call InitTrig_Red_Fire()
call InitTrig_Red_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Blue_Ice_Left()
call InitTrig_Blue_Ice_Down()
call InitTrig_Blue_Ice_Right()
call InitTrig_Blue_Ice_Up()
call InitTrig_Blue_Ice()
call InitTrig_Blue_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Cyan_Bolt_Down()
call InitTrig_Cyan_Bolt_Right()
call InitTrig_Cyan_Bolt_Up()
call InitTrig_Cyan_Bolt_Left()
call InitTrig_Cyan_Bolt()
call InitTrig_Cyan_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Purple_Moon_Right()
call InitTrig_Purple_Moon_Up()
call InitTrig_Purple_Moon_Left()
call InitTrig_Purple_Moon_Down()
call InitTrig_Purple_Moon()
call InitTrig_Purple_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Yellow_Light_Up()
call InitTrig_Yellow_Light_Right()
call InitTrig_Yellow_Light_Down()
call InitTrig_Yellow_Light_Left()
call InitTrig_Yellow_Light()
call InitTrig_Yellow_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Orange_Wind_Right()
call InitTrig_Orange_Wind_Down()
call InitTrig_Orange_Wind_Left()
call InitTrig_Orange_Wind_Up()
call InitTrig_Orange_Wind()
call InitTrig_Orange_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Green_Wood_Down()
call InitTrig_Green_Wood_Left()
call InitTrig_Green_Wood_Up()
call InitTrig_Green_Wood_Right()
call InitTrig_Green_Wood()
call InitTrig_Green_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Pink_Pink_Left()
call InitTrig_Pink_Pink_Up()
call InitTrig_Pink_Pink_Right()
call InitTrig_Pink_Pink_Down()
call InitTrig_Pink_Pink_Pink()
call InitTrig_Pink_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_New_Wu_Jie_Bian_Huan_Ablity_1()
call InitTrig_New_Wu_Jie_Bian_Huan_Ablity_2()
call InitTrig_New_Wu_Jie_Bian_Huan_Life()
call InitTrig_New_Wu_Jie_Bian_Huan_Anywhere()
call InitTrig_New_Wu_Jie_Bian_Huan_Death()
call InitTrig_WuJie_Lv_Up()
call InitTrig_WuJie_EXE()
call InitTrig_WuJie_Lv_Up_10()
call InitTrig_WuJie_KongKong()
call InitTrig_WuJie_ShuXing()
call InitTrig_WuJie_ReAblity()
call InitTrig_WuJie_FanDan()
endfunction
function Wu_Jie_Bian_Huan_3 takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_New_Wu_Jie_Bian_Huan_Start)
endfunction
// 清除物品
function fy_qwp takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Fy_qwp takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function fy_qwp)
endfunction
function FY_qwp takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"清除物品",true)
set i=i+1
endloop
call TriggerAddAction(t,function Fy_qwp)
endfunction
// 利息
function k_sjwpc takes nothing returns boolean
set k_pd[GetPlayerId(GetTriggerPlayer())]=not k_pd[GetPlayerId(GetTriggerPlayer())]
return false
endfunction
function ljlx takes nothing returns nothing
local integer i=0
loop
if k_pd[i] then
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)/20)
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)/20)
endif
exitwhen i==11
set i=i+1
endloop
endfunction
function ljzc takes nothing returns nothing
local timer tm=CreateTimer()
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
set k_pd[i]=false
if GetPlayerController(Player(i))==ConvertMapControl(0) and GetPlayerSlotState(Player(i))==ConvertPlayerSlotState(1) then
call TriggerRegisterPlayerChatEvent(t,Player(i),"TT",false)
endif
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function k_sjwpc))
set t=null
call TimerStart(tm,10.00,true,function ljlx)
set tm=null
endfunction
// 修改爆率
function Trig_erfsfd_Func007C takes nothing returns boolean
return(SubString(udg_sliubos,0,5)=="爆率")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func008C takes nothing returns boolean
return(GetEventPlayerChatString()=="关闭提示")
endfunction
function Trig_erfsfd_Func009C takes nothing returns boolean
return(GetEventPlayerChatString()=="开启爆率")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz)==false)
endfunction
function Trig_erfsfd_Func010C takes nothing returns boolean
return(GetEventPlayerChatString()=="关闭爆率")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
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
return(GetEventPlayerChatString()=="清理物品")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
endfunction
function Trig_erfsfd_Func012Func002A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_erfsfd_Func012C takes nothing returns boolean
return(GetEventPlayerChatString()=="清除所有")and(IsPlayerInForce(GetTriggerPlayer(),udg_zliuboz))
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
.
.
.
.")
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
// 魔道
function Trig_mhmdjb2_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_mhmdjb3)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_mhmdjb3)
endfunction
function Trig_mhmdjb3_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_mhmdjb4)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_mhmdjb4)
endfunction
function Trig_mhmdjb4_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_mhmdjb5)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_mhmdjb5)
endfunction
function Trig_mhmdjb5_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_mhmdjb6)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_mhmdjb6)
endfunction
function Trig_mhmdjb6_Actions takes nothing returns nothing
set udg_mhmdjb18[GetConvertedPlayerId(GetTriggerPlayer())]=true
call EnableTrigger(gg_trg_mhmdjb7)
call TriggerSleepAction(2.00)
call DisableTrigger(gg_trg_mhmdjb7)
endfunction
function Trig_mhmdjb7_Conditions takes nothing returns boolean
return ((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))and((udg_mhmdjb18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb7_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
set udg_mhmdjb29=0
set udg_mhmdjb25=true
set udg_mhmdjb24=true
set udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call PauseUnitBJ(true,GetTriggerUnit())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl")
call CreateTextTagUnitBJ("TRIGSTR_004",GetTriggerUnit(),0.00,50.00,100,60.00,100,30.00)
call RotateCameraAroundLocBJ(360.00,GetUnitLoc(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),4.70)
set udg_mhmdjb16=GetLastCreatedTextTag()
set udg_mhmdjb15=GetLastCreatedEffectBJ()
call TriggerSleepAction(5.00)
call ResetToGameCameraForPlayer(GetOwningPlayer(GetTriggerUnit()),0)
call DestroyTextTag(udg_mhmdjb16)
call DestroyEffect(udg_mhmdjb15)
call SetUnitVertexColorBJ(udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],15.00,15.00,15.00,0)
call SetUnitScalePercent(udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],110.00,110.00,110.00)
call PauseUnitBJ(false,udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call SetUnitInvulnerable(udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call EnableTrigger(gg_trg_mhmdjb8)
call EnableTrigger(gg_trg_mhmdjb10)
call EnableTrigger(gg_trg_mhmdjb14)
call EnableTrigger(gg_trg_mhmdjb9)
call EnableTrigger(gg_trg_mhmdjb11)
call EnableTrigger(gg_trg_mhmdjb1)
endfunction
function Trig_mhmdjb8_Conditions takes nothing returns boolean
return ((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((udg_mhmdjb18[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb8_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb8_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb8_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func002Func005001002003001(),Trig_mhmdjb8_Func002Func005001002003002())
endfunction
function Trig_mhmdjb8_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Units\\Demon\\Infernal\\InfernalBirth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,10.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb8_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb8_Func004Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb8_Func004Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb8_Func004Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func004Func005001002003001(),Trig_mhmdjb8_Func004Func005001002003002())
endfunction
function Trig_mhmdjb8_Func004Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*SquareRoot((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))))*GetRandomReal(10.00,20.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb8_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_mhmdjb8_Func006Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb8_Func006Func005001002003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb8_Func006Func005001002003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb8_Func006Func005001002003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb8_Func006Func005001002003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func006Func005001002003002002001(),Trig_mhmdjb8_Func006Func005001002003002002002())
endfunction
function Trig_mhmdjb8_Func006Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func006Func005001002003002001(),Trig_mhmdjb8_Func006Func005001002003002002())
endfunction
function Trig_mhmdjb8_Func006Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func006Func005001002003001(),Trig_mhmdjb8_Func006Func005001002003002())
endfunction
function Trig_mhmdjb8_Func006Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitOwner(GetEnumUnit(),GetOwningPlayer(GetAttacker()),true)
call SetUnitVertexColorBJ(GetEnumUnit(),0.00,0.00,0.00,50.00)
call SetUnitMoveSpeed(GetEnumUnit(),500.00)
endfunction
function Trig_mhmdjb8_Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_mhmdjb8_Func008Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb8_Func008Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_mhmdjb8_Func008Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func008Func005001002003001(),Trig_mhmdjb8_Func008Func005001002003002())
endfunction
function Trig_mhmdjb8_Func008Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb8_Func008Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb8_Func008Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb8_Func008Func005Func009001003001(),Trig_mhmdjb8_Func008Func005Func009001003002())
endfunction
function Trig_mhmdjb8_Func008Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb8_Func008Func005A takes nothing returns nothing
set udg_mhmdjb20=GetEnumUnit()
set udg_mhmdjb19=GetUnitLoc(udg_mhmdjb20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_mhmdjb19,Condition(function Trig_mhmdjb8_Func008Func005Func009001003)),function Trig_mhmdjb8_Func008Func005Func009A)
call RemoveUnit(udg_mhmdjb20)
call RemoveLocation(udg_mhmdjb19)
endfunction
function Trig_mhmdjb8_Func008C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_mhmdjb8_Actions takes nothing returns nothing
if (Trig_mhmdjb8_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔地狱火|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb8_Func002Func005001002003))),function Trig_mhmdjb8_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_mhmdjb8_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00邪恶突袭|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb8_Func004Func005001002003))),function Trig_mhmdjb8_Func004Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_mhmdjb8_Func006C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00黑暗召唤|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(4,GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb8_Func006Func005001002003))),function Trig_mhmdjb8_Func006Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_mhmdjb8_Func008C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔尸爆|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb8_Func008Func005001002003))),function Trig_mhmdjb8_Func008Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
endfunction
function Trig_mhmdjb9_Func004C takes nothing returns boolean
return ((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((udg_mhmdjb18[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_mhmdjb9_Conditions takes nothing returns boolean
return (Trig_mhmdjb9_Func004C())
endfunction
function Trig_mhmdjb9_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
endfunction
function Trig_mhmdjb10_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_mhmdjb18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_mhmdjb10_Func002Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb10_Func002Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_mhmdjb10_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb10_Func002Func007001003001(),Trig_mhmdjb10_Func002Func007001003002())
endfunction
function Trig_mhmdjb10_Func002Func007A takes nothing returns nothing
set udg_mhmdjb22=(udg_mhmdjb22+1)
set udg_mhmdjb21[udg_mhmdjb22]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_mhmdjb23[udg_mhmdjb22]=AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb10_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_mhmdjb24))
endfunction
function Trig_mhmdjb10_Func004Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb10_Func004Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_mhmdjb10_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb10_Func004Func007001003001(),Trig_mhmdjb10_Func004Func007001003002())
endfunction
function Trig_mhmdjb10_Func004Func007A takes nothing returns nothing
set udg_mhmdjb26=(udg_mhmdjb26+1)
set udg_mhmdjb27[udg_mhmdjb26]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_mhmdjb28[udg_mhmdjb26]=AddLightningLoc("LEAS",GetUnitLoc(GetTriggerUnit()),GetUnitLoc(GetEnumUnit()))
call UnitDamageTarget(GetTriggerUnit(),GetEnumUnit(),((I2R(GetHeroLevel(GetTriggerUnit()))*I2R(GetHeroAgi(GetTriggerUnit(),true)))*GetRandomReal(2.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb10_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_mhmdjb25))
endfunction
function Trig_mhmdjb10_Actions takes nothing returns nothing
if (Trig_mhmdjb10_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之封印|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb24=false
set udg_mhmdjb22=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb10_Func002Func007001003)),function Trig_mhmdjb10_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_mhmdjb12)
return
endif
if (Trig_mhmdjb10_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之困锁|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb25=false
set udg_mhmdjb26=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb10_Func004Func007001003)),function Trig_mhmdjb10_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(0.30)
call TriggerExecute(gg_trg_mhmdjb13)
endif
endfunction
function Trig_mhmdjb11_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_mhmdjb18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_mhmdjb11_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
endfunction
function Trig_mhmdjb12_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_mhmdjb22
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_mhmdjb21[GetForLoopIndexA()])
call DestroyEffect(udg_mhmdjb23[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_mhmdjb24=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb13_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_mhmdjb26
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb28[GetForLoopIndexA()])
call PauseUnitBJ(false,udg_mhmdjb27[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_mhmdjb25=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb14_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and((udg_mhmdjb18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_mhmdjb14_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_mhmdjb1_Conditions takes nothing returns boolean
return ((udg_mhmdjb18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1_Actions takes nothing returns nothing
set udg_mhmdjb18[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisableTrigger(gg_trg_mhmdjb14)
call DisableTrigger(gg_trg_mhmdjb8)
call DisableTrigger(gg_trg_mhmdjb9)
call DisableTrigger(gg_trg_mhmdjb10)
call DisableTrigger(gg_trg_mhmdjb11)
call SetUnitVertexColorBJ(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00,0)
call SetUnitScalePercent(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb81_Conditions takes nothing returns boolean
return ((GetTriggerPlayer()==Player(0)))
endfunction
function Trig_mhmdjb81_Func001Func002C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 关闭"))
endfunction
function Trig_mhmdjb81_Func001C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 打开"))
endfunction
function Trig_mhmdjb81_Actions takes nothing returns nothing
if (Trig_mhmdjb81_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00打开了魔道 !!!!!!!!!!!!!|r"+" 邪恶之气已经释放。修改者：|cFFFFFF00鬼和尚|r 有什么问题请登陆 魔兽地图联盟 http://www.12349.net 一起学习研究")))
call TriggerExecute(gg_trg_mhmdjb84)
call EnableTrigger(gg_trg_mhmdjb95)
else
if (Trig_mhmdjb81_Func001Func002C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00关闭了魔道 !!!!!!!!!!!!!|r"+" 任何人无法再进入魔道。")))
call DisableTrigger(gg_trg_mhmdjb82)
endif
endif
endfunction
function Trig_mhmdjb82_Conditions takes nothing returns boolean
return ((udg_mhmdjb36[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_mhmdjb58[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_mhmdjb82_Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb64==false))
endfunction
function Trig_mhmdjb82_Func001C takes nothing returns boolean
return ((udg_mhmdjb63))
endfunction
function Trig_mhmdjb82_Actions takes nothing returns nothing
if (Trig_mhmdjb82_Func001C()) then
set udg_mhmdjb59=GetTriggerPlayer()
set udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]=GetRandomInt(1,8)
call ConditionalTriggerExecute(gg_trg_mhmdjb83)
else
if (Trig_mhmdjb82_Func001Func001C()) then
set udg_mhmdjb64=true
set udg_mhmdjb59=GetTriggerPlayer()
call DialogClear(udg_mhmdjb61)
call DialogSetMessage(udg_mhmdjb61,("魔道选择"+""))
set udg_mhmdjb62[3]=DialogAddButtonBJ(udg_mhmdjb61,("冰魔"+" 智"))
set udg_mhmdjb62[4]=DialogAddButtonBJ(udg_mhmdjb61,("火魔"+" 智"))
set udg_mhmdjb62[5]=DialogAddButtonBJ(udg_mhmdjb61,("金魔"+" 力"))
set udg_mhmdjb62[6]=DialogAddButtonBJ(udg_mhmdjb61,("雷魔"+" 力"))
set udg_mhmdjb62[7]=DialogAddButtonBJ(udg_mhmdjb61,("木魔"+" 敏"))
set udg_mhmdjb62[8]=DialogAddButtonBJ(udg_mhmdjb61,("水魔"+" 敏智"))
set udg_mhmdjb62[9]=DialogAddButtonBJ(udg_mhmdjb61,("亡魔"+" 敏"))
set udg_mhmdjb62[10]=DialogAddButtonBJ(udg_mhmdjb61,("月魔"+" 敏"))
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,true)
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+" 正在选择入魔 请稍后再入魔。。。。"))
endif
endif
endfunction
function Trig_mhmdjb83_Conditions takes nothing returns boolean
return ((udg_mhmdjb58[GetConvertedPlayerId(udg_mhmdjb59)]==false))and((udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]==false))
endfunction
function Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==8))
endfunction
function Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==7))
endfunction
function Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==6))
endfunction
function Trig_mhmdjb83_Func004Func001Func002Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==5))
endfunction
function Trig_mhmdjb83_Func004Func001Func002Func002C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==4))
endfunction
function Trig_mhmdjb83_Func004Func001Func002C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==3))
endfunction
function Trig_mhmdjb83_Func004Func001C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==2))
endfunction
function Trig_mhmdjb83_Func004C takes nothing returns boolean
return ((udg_mhmdjb99[GetConvertedPlayerId(udg_mhmdjb59)]==1))
endfunction
function Trig_mhmdjb83_Actions takes nothing returns nothing
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
if (Trig_mhmdjb83_Func004C()) then
set udg_mhmdjb32[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb39[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001C()) then
set udg_mhmdjb33[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb40[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002C()) then
set udg_mhmdjb31[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb38[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002Func002C()) then
set udg_mhmdjb34[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb48[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002Func002Func001C()) then
set udg_mhmdjb35[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb47[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
set udg_mhmdjb43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002C()) then
set udg_mhmdjb49[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb50[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002Func001C()) then
set udg_mhmdjb51[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb52[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_mhmdjb83_Func004Func001Func002Func002Func001Func002Func001Func001C()) then
set udg_mhmdjb100[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb56[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
set udg_mhmdjb43[2]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+" 妄图进入魔道，但因邪恶度不够，你永久不可以入魔道！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_mhmdjb84_Actions takes nothing returns nothing
call DialogClear(udg_mhmdjb60)
call DialogSetMessage(udg_mhmdjb60,("选择入魔方式"+""))
set udg_mhmdjb62[1]=DialogAddButtonBJ(udg_mhmdjb60,("随机模式"+""))
set udg_mhmdjb62[2]=DialogAddButtonBJ(udg_mhmdjb60,("选择模式"+""))
call DialogDisplay(Player(0),udg_mhmdjb60,true)
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[10]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[9]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[8]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[7]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[6]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[5]))
endfunction
function Trig_mhmdjb84Clink_Func002Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[4]))
endfunction
function Trig_mhmdjb84Clink_Func002C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[3]))
endfunction
function Trig_mhmdjb84Clink_Actions takes nothing returns nothing
if (Trig_mhmdjb84Clink_Func002C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb32[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb39[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb33[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb40[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb31[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb38[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003Func003C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb34[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb48[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb35[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb47[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
set udg_mhmdjb43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb49[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb50[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003Func003C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb51[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb52[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
else
if (Trig_mhmdjb84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C()) then
set udg_mhmdjb36[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb100[GetConvertedPlayerId(udg_mhmdjb59)]=true
set udg_mhmdjb56[GetConvertedPlayerId(udg_mhmdjb59)]=1
set udg_mhmdjb37[GetConvertedPlayerId(udg_mhmdjb59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_mhmdjb59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_mhmdjb64=false
call DialogDisplay(udg_mhmdjb59,udg_mhmdjb61,false)
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_mhmdjb85_Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_mhmdjb62[1]))
endfunction
function Trig_mhmdjb85_Actions takes nothing returns nothing
if (Trig_mhmdjb85_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了随机入魔的方式 请各玩家输入“进入魔道”入魔！"+""))
set udg_mhmdjb63=true
call EnableTrigger(gg_trg_mhmdjb82)
call DialogDestroy(udg_mhmdjb60)
else
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了选择入魔的方式 请各玩家输入“进入魔道”入魔对话框选择！"+""))
set udg_mhmdjb63=false
call EnableTrigger(gg_trg_mhmdjb82)
call DialogDestroy(udg_mhmdjb60)
endif
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb100[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb51[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb35[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb49[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb34[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb33[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001Func001C takes nothing returns boolean
return ((udg_mhmdjb32[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Func001C takes nothing returns boolean
return ((udg_mhmdjb31[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb1NoralPlayer_Actions takes nothing returns nothing
if (Trig_mhmdjb1NoralPlayer_Func001C()) then
set udg_mhmdjb31[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001C()) then
set udg_mhmdjb32[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001C()) then
set udg_mhmdjb33[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001C()) then
set udg_mhmdjb34[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001C()) then
set udg_mhmdjb49[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001C()) then
set udg_mhmdjb35[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_mhmdjb51[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_mhmdjb1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_mhmdjb100[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" 你还没有入魔！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_mhmdjb86_Conditions takes nothing returns boolean
return ((udg_mhmdjb58[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_mhmdjb36[GetConvertedPlayerId(GetTriggerPlayer())]))and((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((GetTriggerUnit()!=udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_mhmdjb86_Actions takes nothing returns nothing
set udg_mhmdjb17[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
set udg_mhmdjb58[GetConvertedPlayerId(GetTriggerPlayer())]=true
call CreateTextTagUnitBJ(((("|cFFFFFF00"+GetHeroProperName(GetTriggerUnit()))+"|r ")+"|cFFFF0033入魔成功！|r"),GetTriggerUnit(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
endfunction
function Trig_mhmdjb87_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb31[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb87_Func002C takes nothing returns boolean
return ((GetUnitLifePercent(GetAttacker())<=80.00))
endfunction
function Trig_mhmdjb87_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb87_Func004Func011001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb87_Func004Func011001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb87_Func004Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb87_Func004Func011001003001(),Trig_mhmdjb87_Func004Func011001003002())
endfunction
function Trig_mhmdjb87_Func004Func011A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(10.00,50.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb87_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb87_Func005Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb87_Func005Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb87_Func005Func005001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb87_Func005Func005001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb87_Func005Func005001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb87_Func005Func005001003002002001(),Trig_mhmdjb87_Func005Func005001003002002002())
endfunction
function Trig_mhmdjb87_Func005Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb87_Func005Func005001003002001(),Trig_mhmdjb87_Func005Func005001003002002())
endfunction
function Trig_mhmdjb87_Func005Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb87_Func005Func005001003001(),Trig_mhmdjb87_Func005Func005001003002())
endfunction
function Trig_mhmdjb87_Func005Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(5.00,20.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb87_Func005C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb87_Func006C takes nothing returns boolean
return ((RAbsBJ((GetUnitFacing(GetTriggerUnit())-GetUnitFacing(GetAttacker())))<=60.00))
endfunction
function Trig_mhmdjb87_Actions takes nothing returns nothing
if (Trig_mhmdjb87_Func002C()) then
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetAttacker(),(GetUnitLifePercent(GetAttacker())+3.00))
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"吸血之刃")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
if (Trig_mhmdjb87_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之罩")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetTriggerUnit(),0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call PauseUnitBJ(true,GetTriggerUnit())
call TriggerSleepAction(3.00)
call PauseUnitBJ(false,GetTriggerUnit())
endif
if (Trig_mhmdjb87_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之怒")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\NightElf\\FanOfKnives\\FanOfKnivesCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb87_Func004Func011001003)),function Trig_mhmdjb87_Func004Func011A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb87_Func005C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔妖气")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb87_Func005Func005001003)),function Trig_mhmdjb87_Func005Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb87_Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"背击噬魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetTriggerUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot(I2R(GetHeroAgi(GetAttacker(),true)))*(I2R(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endif
endfunction
function Trig_mhmdjb87UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb31[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb87UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb87UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb87UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb87UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000金魔之斩魂刀|r熟练度为 ")+I2S(udg_mhmdjb38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000金魔之斩魂刀|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb87UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb88_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb32[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb88_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb88_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb88_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb88_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func001Func005001002003002001(),Trig_mhmdjb88_Func001Func005001002003002002())
endfunction
function Trig_mhmdjb88_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func001Func005001002003001(),Trig_mhmdjb88_Func001Func005001002003002())
endfunction
function Trig_mhmdjb88_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_mhmdjb39[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_mhmdjb88_Func001C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=8))
endfunction
function Trig_mhmdjb88_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb88_Func002Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb88_Func002Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb88_Func002Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func002Func005001002003002001(),Trig_mhmdjb88_Func002Func005001002003002002())
endfunction
function Trig_mhmdjb88_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func002Func005001002003001(),Trig_mhmdjb88_Func002Func005001002003002())
endfunction
function Trig_mhmdjb88_Func002Func005Func007003001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb88_Func002Func005Func007003001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb88_Func002Func005Func007003001003002002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit())))
endfunction
function Trig_mhmdjb88_Func002Func005Func007003001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func002Func005Func007003001003002001(),Trig_mhmdjb88_Func002Func005Func007003001003002002())
endfunction
function Trig_mhmdjb88_Func002Func005Func007003001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb88_Func002Func005Func007003001003001(),Trig_mhmdjb88_Func002Func005Func007003001003002())
endfunction
function Trig_mhmdjb88_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIso\\BIsvTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitOwner(GetEnumUnit(),Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
call IssueTargetOrder(GetEnumUnit(),"attack",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb88_Func002Func005Func007003001003))))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb88_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb88_Actions takes nothing returns nothing
if (Trig_mhmdjb88_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魄云渺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1000.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb88_Func001Func005001002003))),function Trig_mhmdjb88_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_mhmdjb88_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魔转魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb88_Func002Func005001002003))),function Trig_mhmdjb88_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_mhmdjb88UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb32[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb88UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb88UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb88UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb88UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000冰魔之寒冰杖|r熟练度为 ")+I2S(udg_mhmdjb39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000冰魔之寒冰杖|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb88UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_mhmdjb89_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb33[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb89_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb89_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb89_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb89_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func001Func005001002003002001(),Trig_mhmdjb89_Func001Func005001002003002002())
endfunction
function Trig_mhmdjb89_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func001Func005001002003001(),Trig_mhmdjb89_Func001Func005001002003002())
endfunction
function Trig_mhmdjb89_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_mhmdjb40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_mhmdjb89_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_mhmdjb89_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb89_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb89_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb89_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func002Func005001003002001(),Trig_mhmdjb89_Func002Func005001003002002())
endfunction
function Trig_mhmdjb89_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func002Func005001003001(),Trig_mhmdjb89_Func002Func005001003002())
endfunction
function Trig_mhmdjb89_Func002Func005A takes nothing returns nothing
set udg_mhmdjb42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),800.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call IssuePointOrderLoc(GetEnumUnit(),"move",udg_mhmdjb42)
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-1))
call RemoveLocation(udg_mhmdjb42)
endfunction
function Trig_mhmdjb89_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_mhmdjb89_Func003Func011001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb89_Func003Func011001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb89_Func003Func011001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb89_Func003Func011001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func003Func011001003002001(),Trig_mhmdjb89_Func003Func011001003002002())
endfunction
function Trig_mhmdjb89_Func003Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb89_Func003Func011001003001(),Trig_mhmdjb89_Func003Func011001003002())
endfunction
function Trig_mhmdjb89_Func003Func011A takes nothing returns nothing
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*(10.00*I2R(GetHeroLevel(GetAttacker()))))*I2R(udg_mhmdjb40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb89_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb89_Actions takes nothing returns nothing
if (Trig_mhmdjb89_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地狱飞炎")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb89_Func001Func005001002003))),function Trig_mhmdjb89_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb89_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"炽火焚心")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb89_Func002Func005001003)),function Trig_mhmdjb89_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb89_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"致命炎爆")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddLightningLoc("LEAS",GetUnitLoc(GetAttacker()),GetUnitLoc(GetTriggerUnit()))
call DestroyLightning(GetLastCreatedLightningBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb89_Func003Func011001003)),function Trig_mhmdjb89_Func003Func011A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_mhmdjb89UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb33[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb89UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb89UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb89UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb89UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000炎魔之烈火刀|r熟练度为 ")+I2S(udg_mhmdjb40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000炎魔之烈火刀|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb89UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_mhmdjb90_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb34[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb90_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb90_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb90_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb90_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func001Func005001002003002001(),Trig_mhmdjb90_Func001Func005001002003002002())
endfunction
function Trig_mhmdjb90_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func001Func005001002003001(),Trig_mhmdjb90_Func001Func005001002003002())
endfunction
function Trig_mhmdjb90_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_mhmdjb48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_mhmdjb90_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_mhmdjb90_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb90_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb90_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb90_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func002Func005001003002001(),Trig_mhmdjb90_Func002Func005001003002002())
endfunction
function Trig_mhmdjb90_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func002Func005001003001(),Trig_mhmdjb90_Func002Func005001003002())
endfunction
function Trig_mhmdjb90_Func002Func005A takes nothing returns nothing
set udg_mhmdjb42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),500.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("CLPB",GetUnitLoc(GetEnumUnit()),udg_mhmdjb42)
call DestroyLightning(GetLastCreatedLightningBJ())
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
call RemoveLocation(udg_mhmdjb42)
endfunction
function Trig_mhmdjb90_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb90_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb90_Func004Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb90_Func004Func007001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb90_Func004Func007001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb90_Func004Func007001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb90_Func004Func007001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func004Func007001003002002001(),Trig_mhmdjb90_Func004Func007001003002002002())
endfunction
function Trig_mhmdjb90_Func004Func007001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func004Func007001003002001(),Trig_mhmdjb90_Func004Func007001003002002())
endfunction
function Trig_mhmdjb90_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb90_Func004Func007001003001(),Trig_mhmdjb90_Func004Func007001003002())
endfunction
function Trig_mhmdjb90_Func004Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_mhmdjb48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb90_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_mhmdjb90_Actions takes nothing returns nothing
if (Trig_mhmdjb90_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"迅雷之击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb90_Func001Func005001002003))),function Trig_mhmdjb90_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_mhmdjb90_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"闪电净化")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb90_Func002Func005001003)),function Trig_mhmdjb90_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_mhmdjb90_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷魔突袭")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetTriggerUnit(),1.00)
call SetUnitAcquireRange(GetTriggerUnit(),150.00)
call SetUnitVertexColorBJ(GetTriggerUnit(),50.00,50.00,100,0)
call SetUnitScalePercent(GetTriggerUnit(),80.00,80.00,80.00)
return
endif
if (Trig_mhmdjb90_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷霆一击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb90_Func004Func007001003)),function Trig_mhmdjb90_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_mhmdjb90UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb34[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb90UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb90UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb90UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb90UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000雷魔之迅雷剑|r熟练度为 ")+I2S(udg_mhmdjb48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000雷魔之迅雷剑|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb90UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb91_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb49[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb91_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb91_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb91_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb91_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func001Func005001002003002001(),Trig_mhmdjb91_Func001Func005001002003002002())
endfunction
function Trig_mhmdjb91_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func001Func005001002003001(),Trig_mhmdjb91_Func001Func005001002003002())
endfunction
function Trig_mhmdjb91_Func001Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((GetUnitManaPercent(GetAttacker())*SquareRoot(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetAttacker())))*I2R(udg_mhmdjb50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb91_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_mhmdjb91_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb91_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb91_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb91_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func002Func005001003002001(),Trig_mhmdjb91_Func002Func005001003002002())
endfunction
function Trig_mhmdjb91_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func002Func005001003001(),Trig_mhmdjb91_Func002Func005001003002())
endfunction
function Trig_mhmdjb91_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroInt(GetAttacker(),true))*3.00)))*I2R(udg_mhmdjb50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb91_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_mhmdjb91_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb91_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb91_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb91_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb91_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func003Func008001003002002001(),Trig_mhmdjb91_Func003Func008001003002002002())
endfunction
function Trig_mhmdjb91_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func003Func008001003002001(),Trig_mhmdjb91_Func003Func008001003002002())
endfunction
function Trig_mhmdjb91_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb91_Func003Func008001003001(),Trig_mhmdjb91_Func003Func008001003002())
endfunction
function Trig_mhmdjb91_Func003Func008A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetEnumUnit(),0)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endfunction
function Trig_mhmdjb91_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_mhmdjb91_Actions takes nothing returns nothing
if (Trig_mhmdjb91_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水怒龙息")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(900.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb91_Func001Func005001002003))),function Trig_mhmdjb91_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb91_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"暴风雨雪")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(550.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb91_Func002Func005001003)),function Trig_mhmdjb91_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_mhmdjb91_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"邪恶水牢")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb91_Func003Func008001003)),function Trig_mhmdjb91_Func003Func008A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_mhmdjb91Hurt_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_mhmdjb49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_mhmdjb91Hurt_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=20))and((GetUnitLifePercent(GetTriggerUnit())<=20.00))and((GetUnitManaPercent(GetTriggerUnit())>=30.00))
endfunction
function Trig_mhmdjb91Hurt_Actions takes nothing returns nothing
if (Trig_mhmdjb91Hurt_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水魔重降")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCasterOverhead.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),100)
call SetUnitManaPercentBJ(GetTriggerUnit(),(GetUnitManaPercent(GetTriggerUnit())-30.00))
endif
endfunction
function Trig_mhmdjb91UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb49[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb91UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb91UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb91UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb91UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000水魔之定海神针|r熟练度为 ")+I2S(udg_mhmdjb50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000水魔之定海神针|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb91UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,6)
endif
endfunction
function Trig_mhmdjb92_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb35[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb92_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb92_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb92_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb92_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func007001002003002001(),Trig_mhmdjb92_Func001Func007001002003002002())
endfunction
function Trig_mhmdjb92_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func007001002003001(),Trig_mhmdjb92_Func001Func007001002003002())
endfunction
function Trig_mhmdjb92_Func001Func007A takes nothing returns nothing
set udg_mhmdjb45=(udg_mhmdjb45+1)
set udg_mhmdjb44[udg_mhmdjb45]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb46[udg_mhmdjb45]=AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\StormBolt\\StormBoltTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb92_Func001Func009Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb92_Func001Func009Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb92_Func001Func009Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func009Func005001003001(),Trig_mhmdjb92_Func001Func009Func005001003002())
endfunction
function Trig_mhmdjb92_Func001Func009Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*4.00)*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func009Func006Func009001003002002001(),Trig_mhmdjb92_Func001Func009Func006Func009001003002002002())
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func009Func006Func009001003002001(),Trig_mhmdjb92_Func001Func009Func006Func009001003002002())
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func001Func009Func006Func009001003001(),Trig_mhmdjb92_Func001Func009Func006Func009001003002())
endfunction
function Trig_mhmdjb92_Func001Func009Func006Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*8.00)*(I2R(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,10.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_mhmdjb92_Func001Func009Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=30))
endfunction
function Trig_mhmdjb92_Func001Func009C takes nothing returns boolean
return ((GetRandomInt(1,100)<=15))
endfunction
function Trig_mhmdjb92_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))and((udg_mhmdjb43[1]))
endfunction
function Trig_mhmdjb92_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb92_Func002Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb92_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func002Func005001003001(),Trig_mhmdjb92_Func002Func005001003002())
endfunction
function Trig_mhmdjb92_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb92_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_mhmdjb92_Func003Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb92_Func003Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb92_Func003Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb92_Func003Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb92_Func003Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func003Func009001003002002001(),Trig_mhmdjb92_Func003Func009001003002002002())
endfunction
function Trig_mhmdjb92_Func003Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func003Func009001003002001(),Trig_mhmdjb92_Func003Func009001003002002())
endfunction
function Trig_mhmdjb92_Func003Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb92_Func003Func009001003001(),Trig_mhmdjb92_Func003Func009001003002())
endfunction
function Trig_mhmdjb92_Func003Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
endfunction
function Trig_mhmdjb92_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb92_Actions takes nothing returns nothing
if (Trig_mhmdjb92_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"困仙刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb43[1]=false
set udg_mhmdjb45=0
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb92_Func001Func007001002003))),function Trig_mhmdjb92_Func001Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
if (Trig_mhmdjb92_Func001Func009C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"2连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb92_Func001Func009Func005001003)),function Trig_mhmdjb92_Func001Func009Func005A)
if (Trig_mhmdjb92_Func001Func009Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"3连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb92_Func001Func009Func006Func009001003)),function Trig_mhmdjb92_Func001Func009Func006Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_mhmdjb9201)
return
endif
if (Trig_mhmdjb92_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"穿心刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb92_Func002Func005001003)),function Trig_mhmdjb92_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_mhmdjb92_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤足刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb92_Func003Func009001003)),function Trig_mhmdjb92_Func003Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_mhmdjb92UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb35[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb92UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb92UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb92UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb92UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000木魔之精灵地刺|r熟练度为 ")+I2S(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000木魔之精灵地刺|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb92UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb9201_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_mhmdjb45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_mhmdjb44[GetForLoopIndexA()])
call DestroyEffect(udg_mhmdjb46[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_mhmdjb43[1]=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb93_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb51[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_mhmdjb93_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb93_Func001Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_mhmdjb93_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb93_Func001Func005001002003001(),Trig_mhmdjb93_Func001Func005001002003002())
endfunction
function Trig_mhmdjb93_Func001Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb93_Func001Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb93_Func001Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb93_Func001Func005Func009001003001(),Trig_mhmdjb93_Func001Func005Func009001003002())
endfunction
function Trig_mhmdjb93_Func001Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*SquareRoot(I2R(udg_mhmdjb52[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb93_Func001Func005A takes nothing returns nothing
set udg_mhmdjb20=GetEnumUnit()
set udg_mhmdjb19=GetUnitLoc(udg_mhmdjb20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_mhmdjb19,Condition(function Trig_mhmdjb93_Func001Func005Func009001003)),function Trig_mhmdjb93_Func001Func005Func009A)
call RemoveUnit(udg_mhmdjb20)
call RemoveLocation(udg_mhmdjb19)
endfunction
function Trig_mhmdjb93_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_mhmdjb93_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb93_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb93_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb93_Func002Func005001002003001(),Trig_mhmdjb93_Func002Func005001002003002())
endfunction
function Trig_mhmdjb93_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetEnumUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetEnumUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(10.00,'BHwe',GetLastCreatedUnit())
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb93_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_mhmdjb93_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))
endfunction
function Trig_mhmdjb93_Actions takes nothing returns nothing
if (Trig_mhmdjb93_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"爆炸尸体")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb93_Func001Func005001002003))),function Trig_mhmdjb93_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_mhmdjb93_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"亡灵复苏")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb93_Func002Func005001002003))),function Trig_mhmdjb93_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_mhmdjb93_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"借尸还魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(60,'BHwe',GetLastCreatedUnit())
call SetUnitVertexColorBJ(GetLastCreatedUnit(),10.00,10.00,10.00,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
endfunction
function Trig_mhmdjb93UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb51[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb93UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb93UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb93UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb93UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000亡魔之暗黑之刃|r熟练度为 ")+I2S(udg_mhmdjb52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000亡魔之暗黑之刃|r  "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb93UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb94_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb100[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb94_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb94_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb94_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb94_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func001Func007001002003002001(),Trig_mhmdjb94_Func001Func007001002003002002())
endfunction
function Trig_mhmdjb94_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func001Func007001002003001(),Trig_mhmdjb94_Func001Func007001002003002())
endfunction
function Trig_mhmdjb94_Func001Func007A takes nothing returns nothing
set udg_mhmdjb45=(udg_mhmdjb45+1)
set udg_mhmdjb57[udg_mhmdjb45]=GetEnumUnit()
set udg_mhmdjb54[udg_mhmdjb45]=GetUnitLoc(GetEnumUnit())
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieFire\\FaerieFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("DRAM",udg_mhmdjb54[(udg_mhmdjb45-1)],udg_mhmdjb54[udg_mhmdjb45])
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(I2R(GetHeroAgi(GetAttacker(),true))*(I2R(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+1))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
set udg_mhmdjb55[udg_mhmdjb45]=GetLastCreatedLightningBJ()
endfunction
function Trig_mhmdjb94_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))and((udg_mhmdjb43[2]))
endfunction
function Trig_mhmdjb94_Func002Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb94_Func002Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb94_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func002Func007001003001(),Trig_mhmdjb94_Func002Func007001003002())
endfunction
function Trig_mhmdjb94_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_mhmdjb94_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb94_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_mhmdjb94_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb94_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb94_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_mhmdjb94_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func003Func008001003002002001(),Trig_mhmdjb94_Func003Func008001003002002002())
endfunction
function Trig_mhmdjb94_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func003Func008001003002001(),Trig_mhmdjb94_Func003Func008001003002002())
endfunction
function Trig_mhmdjb94_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb94_Func003Func008001003001(),Trig_mhmdjb94_Func003Func008001003002())
endfunction
function Trig_mhmdjb94_Func003Func008A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_mhmdjb47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),5.00)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_mhmdjb94_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_mhmdjb94_Actions takes nothing returns nothing
if (Trig_mhmdjb94_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月魔锁链")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb45=0
set udg_mhmdjb54[0]=GetUnitLoc(GetAttacker())
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb94_Func001Func007001002003))),function Trig_mhmdjb94_Func001Func007A)
call RemoveLocation(udg_mhmdjb54[0])
call RemoveLocation(GetUnitLoc(GetAttacker()))
call TriggerSleepAction(0.10)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_mhmdjb45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_mhmdjb57[GetForLoopIndexA()])
call DestroyLightning(udg_mhmdjb55[GetForLoopIndexA()])
set udg_mhmdjb57[GetForLoopIndexA()]=null
call RemoveLocation(udg_mhmdjb54[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if (Trig_mhmdjb94_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"星坠月落")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb94_Func002Func007001003)),function Trig_mhmdjb94_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_mhmdjb94_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月晕之风")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_mhmdjb94_Func003Func008001003)),function Trig_mhmdjb94_Func003Func008A)
endif
endfunction
function Trig_mhmdjb9400_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_mhmdjb100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb9400_Func001Func006001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb9400_Func001Func006001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit()))!=true)
endfunction
function Trig_mhmdjb9400_Func001Func006001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb9400_Func001Func006001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb9400_Func001Func006001003002001(),Trig_mhmdjb9400_Func001Func006001003002002())
endfunction
function Trig_mhmdjb9400_Func001Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb9400_Func001Func006001003001(),Trig_mhmdjb9400_Func001Func006001003002())
endfunction
function Trig_mhmdjb9400_Func001Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+SquareRoot(I2R(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
endfunction
function Trig_mhmdjb9400_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=R2I(SquareRoot(I2R((100-R2I(GetUnitLifePercent(GetTriggerUnit()))))))))
endfunction
function Trig_mhmdjb9400_Actions takes nothing returns nothing
if (Trig_mhmdjb9400_Func001C()) then
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),(GetUnitLifePercent(GetTriggerUnit())+SquareRoot(I2R(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_mhmdjb9400_Func001Func006001003)),function Trig_mhmdjb9400_Func001Func006A)
endif
endfunction
function Trig_mhmdjb94UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb100[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb94UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb94UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb94UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb94UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000月魔之无相金轮|r熟练度为 ")+I2S(udg_mhmdjb56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000月魔之无相金轮|r "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb94UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb95_Conditions takes nothing returns boolean
return ((udg_mhmdjb36[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_mhmdjb95_Actions takes nothing returns nothing
set udg_mhmdjb36[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_mhmdjb97[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_mhmdjb70[GetConvertedPlayerId(GetTriggerPlayer())]=1
set udg_mhmdjb37[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+("  已经入了被封印的-<土魔>-"+"！ 请马上选择你要进入的英雄！")))
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb96_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_mhmdjb97[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))
endfunction
function Trig_mhmdjb96_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_mhmdjb96_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb96_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))
endfunction
function Trig_mhmdjb96_Func004C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=5))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>30))
endfunction
function Trig_mhmdjb96_Func005C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=2))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>50))
endfunction
function Trig_mhmdjb96_Actions takes nothing returns nothing
if (Trig_mhmdjb96_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"疾行土封")+"|r ")+"|cFFFF00334式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb65=GetAttacker()
call PauseUnitBJ(true,udg_mhmdjb65)
call SetUnitPathing(udg_mhmdjb65,false)
set udg_mhmdjb69=GetTriggerUnit()
call PauseUnitBJ(true,udg_mhmdjb69)
set udg_mhmdjb67[0]=GetUnitLoc(GetTriggerUnit())
set udg_mhmdjb68=0
call EnableTrigger(gg_trg_mhmdjb97F4)
return
endif
if (Trig_mhmdjb96_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地遁连击")+"|r ")+"|cFFFF003316式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb68=16
set udg_mhmdjb65=GetAttacker()
set udg_mhmdjb69=GetTriggerUnit()
call SetUnitPathing(udg_mhmdjb65,false)
call PauseUnitBJ(true,udg_mhmdjb65)
call EnableTrigger(gg_trg_mhmdjb97F16)
return
endif
if (Trig_mhmdjb96_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地魔怒杀")+"|r ")+"|cFFFF003332式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb65=GetAttacker()
set udg_mhmdjb69=GetTriggerUnit()
call PauseUnitBJ(true,udg_mhmdjb65)
call PauseUnitBJ(true,udg_mhmdjb69)
call TriggerExecute(gg_trg_mhmdjb97F32)
return
endif
if (Trig_mhmdjb96_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤残狂击")+"|r ")+"|cFFFF003364式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_mhmdjb65=GetAttacker()
set udg_mhmdjb69=GetTriggerUnit()
set udg_mhmdjb68=0
call PauseUnitBJ(true,udg_mhmdjb65)
call PauseUnitBJ(true,udg_mhmdjb69)
call SetUnitLifePercentBJ(udg_mhmdjb65,(GetUnitLifePercent(udg_mhmdjb65)-50.00))
set udg_mhmdjb46[888]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_mhmdjb46[889]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call EnableTrigger(gg_trg_mhmdjb97F64)
call EnableTrigger(gg_trg_mhmdjb97F64death)
return
endif
if (Trig_mhmdjb96_Func005C()) then
set udg_mhmdjb65=GetAttacker()
call PanCameraToTimed(GetLocationX(GetUnitLoc(udg_mhmdjb65)),GetLocationY(GetUnitLoc(udg_mhmdjb65)),0.30)
call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE,4000.00,0)
call ConditionalTriggerExecute(gg_trg_mhmdjb97Screct)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"土魔密式")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
endfunction
function Trig_mhmdjb97F4_Func009001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb97F4_Func009001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_mhmdjb65)))
endfunction
function Trig_mhmdjb97F4_Func009001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F4_Func009001003001001(),Trig_mhmdjb97F4_Func009001003001002())
endfunction
function Trig_mhmdjb97F4_Func009001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb97F4_Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F4_Func009001003001(),Trig_mhmdjb97F4_Func009001003002())
endfunction
function Trig_mhmdjb97F4_Func009A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),udg_mhmdjb67[0])
call UnitDamageTargetBJ(udg_mhmdjb65,GetEnumUnit(),((I2R(GetHeroLevel(udg_mhmdjb65))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_mhmdjb97F4_Func011C takes nothing returns boolean
return ((udg_mhmdjb68>24))
endfunction
function Trig_mhmdjb97F4_Actions takes nothing returns nothing
set udg_mhmdjb68=(udg_mhmdjb68+1)
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],500.00,(((I2R(udg_mhmdjb68)-1)*15.00)+GetUnitFacing(udg_mhmdjb69)))
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+90.00))
call AddSpecialEffectLocBJ(udg_mhmdjb67[1],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitAnimation(udg_mhmdjb65,"Walk")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(80.00,udg_mhmdjb67[1],Condition(function Trig_mhmdjb97F4_Func009001003)),function Trig_mhmdjb97F4_Func009A)
call RemoveLocation(udg_mhmdjb67[1])
if (Trig_mhmdjb97F4_Func011C()) then
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_mhmdjb97F40)
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitTimeScalePercent(udg_mhmdjb65,200.00)
call SetUnitAnimation(udg_mhmdjb65,"Attack")
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,0)
call SetUnitPositionLocFacingLocBJ(udg_mhmdjb65,udg_mhmdjb67[1],udg_mhmdjb67[0])
set udg_mhmdjb684=0
call RemoveLocation(udg_mhmdjb67[1])
endif
endfunction
function Trig_mhmdjb97F40_Func006C takes nothing returns boolean
return ((udg_mhmdjb684==1))and((IsUnitAliveBJ(udg_mhmdjb69)))
endfunction
function Trig_mhmdjb97F40_Func007C takes nothing returns boolean
return ((udg_mhmdjb684==2))and((IsUnitAliveBJ(udg_mhmdjb69)))
endfunction
function Trig_mhmdjb97F40_Func008C takes nothing returns boolean
return ((udg_mhmdjb684==3))and((IsUnitAliveBJ(udg_mhmdjb69)))
endfunction
function Trig_mhmdjb97F40_Func009C takes nothing returns boolean
return ((udg_mhmdjb684==4))and((IsUnitAliveBJ(udg_mhmdjb69)))
endfunction
function Trig_mhmdjb97F40_Func010C takes nothing returns boolean
return ((udg_mhmdjb684>=4))
endfunction
function Trig_mhmdjb97F40_Actions takes nothing returns nothing
set udg_mhmdjb684=(udg_mhmdjb684+1)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+I2S(udg_mhmdjb684))+"|r ")+"|cFFFF0033式|r"),udg_mhmdjb69,0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
if (Trig_mhmdjb97F40_Func006C()) then
call SetUnitAnimation(udg_mhmdjb65,"Attack")
call SetUnitAnimation(udg_mhmdjb69,"death")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,180.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+0.00))
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(I2R(udg_mhmdjb684)*(I2R(GetHeroAgi(udg_mhmdjb65,false))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_mhmdjb67[1])
endif
if (Trig_mhmdjb97F40_Func007C()) then
call SetUnitAnimation(udg_mhmdjb65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,0.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+0.00))
call RemoveLocation(udg_mhmdjb67[1])
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(I2R(udg_mhmdjb684)*(I2R(GetHeroAgi(udg_mhmdjb65,false))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+0.00))
call RemoveLocation(udg_mhmdjb67[1])
call SetUnitAnimation(udg_mhmdjb69,"death")
endif
if (Trig_mhmdjb97F40_Func008C()) then
call SetUnitAnimation(udg_mhmdjb65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,270.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+0.00))
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(I2R(udg_mhmdjb684)*(I2R(GetHeroAgi(udg_mhmdjb65,false))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_mhmdjb67[1])
call SetUnitAnimation(udg_mhmdjb69,"death")
endif
if (Trig_mhmdjb97F40_Func009C()) then
call SetUnitAnimation(udg_mhmdjb65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[1]=PolarProjectionBJ(udg_mhmdjb67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[1],(AngleBetweenPoints(udg_mhmdjb67[0],udg_mhmdjb67[1])+0.00))
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(I2R(udg_mhmdjb684)*(I2R(GetHeroAgi(udg_mhmdjb65,false))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_mhmdjb67[1])
call SetUnitAnimation(udg_mhmdjb69,"death")
endif
if (Trig_mhmdjb97F40_Func010C()) then
call DisableTrigger(GetTriggeringTrigger())
call PauseUnitBJ(false,udg_mhmdjb65)
call PauseUnitBJ(false,udg_mhmdjb69)
call SetUnitInvulnerable(udg_mhmdjb65,false)
call SetUnitPathing(udg_mhmdjb65,true)
call ResetUnitAnimation(udg_mhmdjb65)
call SetUnitTimeScalePercent(udg_mhmdjb65,100.00)
call RemoveLocation(udg_mhmdjb67[0])
call ResetUnitAnimation(udg_mhmdjb69)
endif
endfunction
function Trig_mhmdjb97F16_Func003002001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb97F16_Func003002001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_mhmdjb65)))
endfunction
function Trig_mhmdjb97F16_Func003002001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F16_Func003002001003001001(),Trig_mhmdjb97F16_Func003002001003001002())
endfunction
function Trig_mhmdjb97F16_Func003002001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb97F16_Func003002001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F16_Func003002001003001(),Trig_mhmdjb97F16_Func003002001003002())
endfunction
function Trig_mhmdjb97F16_Func018Func007Func002001001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb97F16_Func018Func007Func002001001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_mhmdjb65)))
endfunction
function Trig_mhmdjb97F16_Func018Func007Func002001001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F16_Func018Func007Func002001001003001001(),Trig_mhmdjb97F16_Func018Func007Func002001001003001002())
endfunction
function Trig_mhmdjb97F16_Func018Func007Func002001001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_mhmdjb97F16_Func018Func007Func002001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F16_Func018Func007Func002001001003001(),Trig_mhmdjb97F16_Func018Func007Func002001001003002())
endfunction
function Trig_mhmdjb97F16_Func018Func007C takes nothing returns boolean
return ((udg_mhmdjb68<1))or((CountUnitsInGroup(GetUnitsInRangeOfLocMatching(312.00,GetUnitLoc(udg_mhmdjb65),Condition(function Trig_mhmdjb97F16_Func018Func007Func002001001003)))<1))
endfunction
function Trig_mhmdjb97F16_Func018C takes nothing returns boolean
return (Trig_mhmdjb97F16_Func018Func007C())
endfunction
function Trig_mhmdjb97F16_Actions takes nothing returns nothing
call SetUnitVertexColorBJ(udg_mhmdjb65,0.00,0.00,0.00,70.00)
call ResetUnitAnimation(udg_mhmdjb65)
set udg_mhmdjb71=GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(udg_mhmdjb69),Condition(function Trig_mhmdjb97F16_Func003002001003)))
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"units\\orc\\SpiritWyvern\\SpiritWyvern.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SelectUnitRemoveForPlayer(udg_mhmdjb65,GetOwningPlayer(udg_mhmdjb65))
call SetUnitAnimation(udg_mhmdjb65,"Attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,GetUnitLoc(udg_mhmdjb71),(180.00-GetUnitFacing(udg_mhmdjb71)))
call CreateTextTagUnitBJ((I2S(udg_mhmdjb68)+" Hits"),udg_mhmdjb71,0,10,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(udg_mhmdjb71),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb71,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
set udg_mhmdjb69=udg_mhmdjb71
set udg_mhmdjb68=(udg_mhmdjb68-1)
if (Trig_mhmdjb97F16_Func018C()) then
call DisableTrigger(GetTriggeringTrigger())
call SetUnitPathing(udg_mhmdjb65,true)
call SelectUnitForPlayerSingle(udg_mhmdjb65,GetOwningPlayer(udg_mhmdjb65))
call PauseUnitBJ(false,udg_mhmdjb65)
call SetUnitInvulnerable(udg_mhmdjb65,false)
call SetUnitVertexColorBJ(udg_mhmdjb65,100,100,100,0)
endif
endfunction
function Trig_mhmdjb97F32_Func003Func001Func015C takes nothing returns boolean
return ((GetRandomInt(1,100)>=40))
endfunction
function Trig_mhmdjb97F32_Func003Func001C takes nothing returns boolean
return ((IsUnitAliveBJ(udg_mhmdjb69)))
endfunction
function Trig_mhmdjb97F32_Actions takes nothing returns nothing
call SelectUnitRemoveForPlayer(udg_mhmdjb65,GetOwningPlayer(udg_mhmdjb65))
call SetUnitTimeScalePercent(udg_mhmdjb65,500.00)
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=32
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if (Trig_mhmdjb97F32_Func003Func001C()) then
call CreateTextTagUnitBJ((I2S(GetForLoopIndexB())+" Hits"),udg_mhmdjb69,0,10,0.00,100,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),200.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitAnimation(udg_mhmdjb69,"death")
call AddSpecialEffectTargetUnitBJ("chest",udg_mhmdjb69,"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("HWPB",GetUnitLoc(udg_mhmdjb69),PolarProjectionBJ(GetUnitLoc(udg_mhmdjb69),700.00,(I2R(GetForLoopIndexB())*11.25)))
call SetLightningColor(GetLastCreatedLightningBJ(),0.20,1,0.20,0.40)
set udg_mhmdjb28[(100+GetForLoopIndexB())]=GetLastCreatedLightningBJ()
call AddSpecialEffectTargetUnitBJ("origin",udg_mhmdjb69,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if (Trig_mhmdjb97F32_Func003Func001Func015C()) then
call AddSpecialEffectLocBJ(GetUnitLoc(udg_mhmdjb69),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(GetForLoopIndexB())*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call TriggerSleepAction(0.10)
else
call ResetUnitAnimation(udg_mhmdjb69)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call SetUnitInvulnerable(udg_mhmdjb65,false)
call SetUnitTimeScalePercent(udg_mhmdjb65,100)
call PauseUnitBJ(false,udg_mhmdjb69)
call IssueImmediateOrder(udg_mhmdjb65,"stop")
call PauseUnitBJ(false,udg_mhmdjb65)
set bj_forLoopAIndex=100
set bj_forLoopAIndexEnd=135
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb28[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_mhmdjb97F64_Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb68>4))
endfunction
function Trig_mhmdjb97F64_Func002C takes nothing returns boolean
return ((udg_mhmdjb68==1))
endfunction
function Trig_mhmdjb97F64_Actions takes nothing returns nothing
set udg_mhmdjb68=(udg_mhmdjb68+1)
if (Trig_mhmdjb97F64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 4连"),udg_mhmdjb65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],200.00,270.00)
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
else
if (Trig_mhmdjb97F64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_mhmdjb68=4
call TriggerSleepAction(0.50)
call EnableTrigger(gg_trg_mhmdjb97F6z16)
call SetUnitTimeScalePercent(udg_mhmdjb65,200.00)
return
endif
endif
set udg_mhmdjb67[65]=GetUnitLoc(udg_mhmdjb65)
set udg_mhmdjb67[66]=GetUnitLoc(udg_mhmdjb69)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[65],(DistanceBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])/2.00),AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],2.00)
call RemoveLocation(udg_mhmdjb67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_mhmdjb65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66])+90.00),2.00)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],200.00,(I2R(udg_mhmdjb68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],0.30)
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_mhmdjb67[67])
call RemoveLocation(udg_mhmdjb67[65])
endfunction
function Trig_mhmdjb97F6z16_Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb68>21))
endfunction
function Trig_mhmdjb97F6z16_Func002C takes nothing returns boolean
return ((udg_mhmdjb68==5))
endfunction
function Trig_mhmdjb97F6z16_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_mhmdjb68,2)==1))
endfunction
function Trig_mhmdjb97F6z16_Actions takes nothing returns nothing
set udg_mhmdjb68=(udg_mhmdjb68+1)
if (Trig_mhmdjb97F6z16_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 16连"),udg_mhmdjb65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_mhmdjb97F6z16_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_mhmdjb68=21
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_mhmdjb97F6z32)
call SetUnitTimeScalePercent(udg_mhmdjb65,500.00)
return
endif
endif
set udg_mhmdjb67[65]=GetUnitLoc(udg_mhmdjb65)
set udg_mhmdjb67[66]=GetUnitLoc(udg_mhmdjb69)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[65],(DistanceBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])/2.00),AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],2.00)
call RemoveLocation(udg_mhmdjb67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_mhmdjb65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66])+90.00),2.00)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],200.00,(I2R(udg_mhmdjb68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],0.30)
if (Trig_mhmdjb97F6z16_Func012C()) then
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],300.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_mhmdjb67[67])
else
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],300.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+22.50))
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_mhmdjb67[67])
endif
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[80]=PolarProjectionBJ(udg_mhmdjb67[66],350.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+0.00))
set udg_mhmdjb67[81]=PolarProjectionBJ(udg_mhmdjb67[66],350.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+90.00))
set udg_mhmdjb67[82]=PolarProjectionBJ(udg_mhmdjb67[66],350.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+180.00))
set udg_mhmdjb67[83]=PolarProjectionBJ(udg_mhmdjb67[66],350.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+270.00))
call AddLightningLoc("HWPB",udg_mhmdjb67[80],udg_mhmdjb67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(80+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[81],udg_mhmdjb67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(110+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[82],udg_mhmdjb67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(140+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[83],udg_mhmdjb67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(170+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_mhmdjb67[67])
call RemoveLocation(udg_mhmdjb67[65])
endfunction
function Trig_mhmdjb97F6z32_Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb68>54))
endfunction
function Trig_mhmdjb97F6z32_Func002C takes nothing returns boolean
return ((udg_mhmdjb68==22))
endfunction
function Trig_mhmdjb97F6z32_Func031001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_mhmdjb97F6z32_Func031001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_mhmdjb65)))
endfunction
function Trig_mhmdjb97F6z32_Func031001003 takes nothing returns boolean
return GetBooleanAnd(Trig_mhmdjb97F6z32_Func031001003001(),Trig_mhmdjb97F6z32_Func031001003002())
endfunction
function Trig_mhmdjb97F6z32_Func031A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((1.00*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
endfunction
function Trig_mhmdjb97F6z32_Actions takes nothing returns nothing
set udg_mhmdjb68=(udg_mhmdjb68+1)
if (Trig_mhmdjb97F6z32_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 32连"),udg_mhmdjb65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
else
if (Trig_mhmdjb97F6z32_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_mhmdjb68=54
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_mhmdjb97F6z64)
call SetUnitTimeScalePercent(udg_mhmdjb65,800.00)
return
endif
endif
set udg_mhmdjb67[65]=GetUnitLoc(udg_mhmdjb65)
set udg_mhmdjb67[66]=GetUnitLoc(udg_mhmdjb69)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[65],(DistanceBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])/2.00),AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],2.00)
call RemoveLocation(udg_mhmdjb67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_mhmdjb65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66])+90.00),2.00)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],30.00,GetRandomReal(0,360.00))
call SetUnitPositionLocFacingBJ(udg_mhmdjb69,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],0.30)
call RemoveLocation(udg_mhmdjb67[67])
call RemoveLocation(udg_mhmdjb67[66])
set udg_mhmdjb67[66]=GetUnitLoc(udg_mhmdjb69)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],35.00,GetRandomReal(0,360.00))
call SetUnitAnimation(udg_mhmdjb65,"attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65]))
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\NightElf\\EntangleMine\\Roots.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_mhmdjb67[67])
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=20
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(I2R(GetForLoopIndexB())*18.00))
call AddSpecialEffectLocBJ(udg_mhmdjb67[67],"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_mhmdjb67[67])
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,udg_mhmdjb67[66],Condition(function Trig_mhmdjb97F6z32_Func031001003)),function Trig_mhmdjb97F6z32_Func031A)
call RemoveLocation(udg_mhmdjb67[66])
call RemoveLocation(udg_mhmdjb67[65])
endfunction
function Trig_mhmdjb97F6z64_Func002Func001C takes nothing returns boolean
return ((udg_mhmdjb68>64))
endfunction
function Trig_mhmdjb97F6z64_Func002C takes nothing returns boolean
return ((udg_mhmdjb68==55))
endfunction
function Trig_mhmdjb97F6z64_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_mhmdjb68,2)==1))
endfunction
function Trig_mhmdjb97F6z64_Actions takes nothing returns nothing
set udg_mhmdjb68=(udg_mhmdjb68+1)
if (Trig_mhmdjb97F6z64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 64连"),udg_mhmdjb65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_mhmdjb97F6z64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_mhmdjb68=0
call PauseUnitBJ(false,udg_mhmdjb65)
call PauseUnitBJ(false,udg_mhmdjb69)
call SetUnitInvulnerable(udg_mhmdjb65,false)
call ResetUnitAnimation(udg_mhmdjb65)
call SetUnitTimeScalePercent(udg_mhmdjb65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_mhmdjb65),0.50)
call DestroyEffect(udg_mhmdjb46[888])
call DestroyEffect(udg_mhmdjb46[889])
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endif
set udg_mhmdjb67[65]=GetUnitLoc(udg_mhmdjb65)
set udg_mhmdjb67[66]=GetUnitLoc(udg_mhmdjb69)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[65],(DistanceBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])/2.00),AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],2.00)
call RemoveLocation(udg_mhmdjb67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_mhmdjb65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66])+90.00),2.00)
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],200.00,(I2R(udg_mhmdjb68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_mhmdjb65),udg_mhmdjb67[67],0.30)
if (Trig_mhmdjb97F6z64_Func012C()) then
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],300.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_mhmdjb67[67])
else
set udg_mhmdjb67[67]=PolarProjectionBJ(udg_mhmdjb67[66],300.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+36.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_mhmdjb65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_mhmdjb65,"attack")
call SetUnitPositionLocFacingBJ(udg_mhmdjb65,udg_mhmdjb67[67],AngleBetweenPoints(udg_mhmdjb67[65],udg_mhmdjb67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_mhmdjb65,udg_mhmdjb69,(((I2R(udg_mhmdjb68)*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_mhmdjb67[67])
endif
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_mhmdjb67[66],"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_mhmdjb67[80]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+0.00))
set udg_mhmdjb67[81]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+72.00))
set udg_mhmdjb67[82]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+144.00))
set udg_mhmdjb67[83]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+216.00))
set udg_mhmdjb67[84]=PolarProjectionBJ(udg_mhmdjb67[66],500.00,(AngleBetweenPoints(udg_mhmdjb67[66],udg_mhmdjb67[65])+288.00))
call AddLightningLoc("HWPB",udg_mhmdjb67[80],udg_mhmdjb67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(80+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[81],udg_mhmdjb67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(110+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[82],udg_mhmdjb67[84])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(140+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[83],udg_mhmdjb67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(170+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_mhmdjb67[84],udg_mhmdjb67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_mhmdjb55[(200+udg_mhmdjb68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_mhmdjb67[67])
call RemoveLocation(udg_mhmdjb67[65])
endfunction
function Trig_mhmdjb97F64death_Func001C takes nothing returns boolean
return ((IsUnitDeadBJ(udg_mhmdjb69)))or((IsUnitDeadBJ(udg_mhmdjb65)))
endfunction
function Trig_mhmdjb97F64death_Conditions takes nothing returns boolean
return (Trig_mhmdjb97F64death_Func001C())
endfunction
function Trig_mhmdjb97F64death_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_mhmdjb97F64)
call DisableTrigger(gg_trg_mhmdjb97F6z16)
call DisableTrigger(gg_trg_mhmdjb97F6z32)
call DisableTrigger(gg_trg_mhmdjb97F6z64)
call DisableTrigger(gg_trg_mhmdjb97F64death)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_mhmdjb55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PauseUnitBJ(false,udg_mhmdjb65)
call PauseUnitBJ(false,udg_mhmdjb69)
call SetUnitInvulnerable(udg_mhmdjb65,false)
call DestroyEffect(udg_mhmdjb46[888])
call DestroyEffect(udg_mhmdjb46[889])
call ResetUnitAnimation(udg_mhmdjb65)
call SetUnitTimeScalePercent(udg_mhmdjb65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_mhmdjb65),0.50)
call RemoveLocation(udg_mhmdjb67[65])
call RemoveLocation(udg_mhmdjb67[66])
call RemoveLocation(udg_mhmdjb67[67])
endfunction
function Trig_tjzs_Func001C takes nothing returns boolean
return ((udg_mhmdjb74==false))and((GetUnitLevel(udg_mhmdjb65)>=50))
endfunction
function Trig_tjzs_Conditions takes nothing returns boolean
return (Trig_tjzs_Func001C())
endfunction
function Trig_tjzs_Func005Func004Func002C takes nothing returns boolean
return ((DistanceBetweenPoints(udg_mhmdjb77,OffsetLocation(udg_mhmdjb80,(0.00-(udg_mhmdjb76/2.00)),0))>100.00))
endfunction
function Trig_tjzs_Func007001003001 takes nothing returns boolean
return (GetFilterUnit()!=udg_mhmdjb65)
endfunction
function Trig_tjzs_Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func007001003001(),Trig_tjzs_Func007001003002())
endfunction
function Trig_tjzs_Func007A takes nothing returns nothing
call UnitDamageTargetBJ(udg_mhmdjb65,GetEnumUnit(),(((50.00*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
endfunction
function Trig_tjzs_Func014Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func015Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func016Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func019Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func022Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func024Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func026Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func032Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func035Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func036Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func038Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func039Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func041001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func041001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_mhmdjb65)
endfunction
function Trig_tjzs_Func041001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func041001003001(),Trig_tjzs_Func041001003002())
endfunction
function Trig_tjzs_Func041A takes nothing returns nothing
call UnitDamageTargetBJ(udg_mhmdjb65,GetEnumUnit(),(((80.00*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
endfunction
function Trig_tjzs_Func054001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func054001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_mhmdjb65)
endfunction
function Trig_tjzs_Func054001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func054001003001(),Trig_tjzs_Func054001003002())
endfunction
function Trig_tjzs_Func054A takes nothing returns nothing
call UnitDamageTargetBJ(udg_mhmdjb65,GetEnumUnit(),(((100.00*I2R(GetHeroLevel(udg_mhmdjb65)))*I2R(GetHeroAgi(udg_mhmdjb65,false)))*I2R(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(udg_mhmdjb65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
endfunction
function Trig_tjzs_Actions takes nothing returns nothing
set udg_mhmdjb74=true
set udg_mhmdjb80=GetUnitLoc(udg_mhmdjb65)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=44
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_mhmdjb80,udg_mhmdjb76,I2R((GetForLoopIndexA()*4))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_mhmdjb80,udg_mhmdjb76,I2R(((GetForLoopIndexA()*4)+180))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb73=((GetForLoopIndexA()+1)*2)
set udg_mhmdjb72=(180.00/I2R(udg_mhmdjb73))
set udg_mhmdjb78=(I2R(GetForLoopIndexA())*(udg_mhmdjb76/20.00))
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=udg_mhmdjb73
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_mhmdjb77=PolarProjectionBJ(udg_mhmdjb80,udg_mhmdjb78,(AcosBJ((udg_mhmdjb78/udg_mhmdjb76))+(I2R(GetForLoopIndexB())*udg_mhmdjb72)))
if (Trig_tjzs_Func005Func004Func002C()) then
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(udg_mhmdjb77,"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=((GetForLoopIndexA()+1)/2)
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(PolarProjectionBJ(OffsetLocation(udg_mhmdjb80,(udg_mhmdjb76/2.00),0),(I2R(GetForLoopIndexA())*5.00),(I2R(GetForLoopIndexB())*(720.00/(I2R(GetForLoopIndexA())+1)))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,udg_mhmdjb80,Condition(function Trig_tjzs_Func007001003)),function Trig_tjzs_Func007A)
call TriggerSleepAction(1.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func014Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,-700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func015Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,-600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func016Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,-500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(256.00-(I2R(GetForLoopIndexA())*32.00)),700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func019Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(218.00-(I2R(GetForLoopIndexA())*36.33)),600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(182.00-(I2R(GetForLoopIndexA())*45.50)),500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func022Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(256.00-(I2R(GetForLoopIndexA())*32.00)),-700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(218.00-(I2R(GetForLoopIndexA())*36.33)),-600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func024Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(182.00-(I2R(GetForLoopIndexA())*45.50)),-500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func026Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(675.00-(I2R(GetForLoopIndexA())*22.50)),(315.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(578.50-(I2R(GetForLoopIndexA())*25.75)),(269.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(482.50-(I2R(GetForLoopIndexA())*32.13)),(225.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(315.00+(I2R(GetForLoopIndexA())*22.50)),(-675.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(269.50+(I2R(GetForLoopIndexA())*25.75)),(-578.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func032Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(225.50+(I2R(GetForLoopIndexA())*32.13)),(-482.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-675.00+(I2R(GetForLoopIndexA())*22.50)),(-315.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func035Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-578.50+(I2R(GetForLoopIndexA())*25.75)),(-269.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func036Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-482.50+(I2R(GetForLoopIndexA())*32.13)),(-225.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func038Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-315.00-(I2R(GetForLoopIndexA())*22.50)),(675.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func039Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-269.50-(I2R(GetForLoopIndexA())*25.75)),(578.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_mhmdjb79[udg_mhmdjb75]=GetLastCreatedEffectBJ()
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-225.50-(I2R(GetForLoopIndexA())*32.13)),(482.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,udg_mhmdjb80,Condition(function Trig_tjzs_Func041001003)),function Trig_tjzs_Func041A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_mhmdjb75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_mhmdjb79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_mhmdjb75=0
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,-800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),-800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_mhmdjb79[udg_mhmdjb75]=AddSpecialEffectLocBJ(OffsetLocation(udg_mhmdjb80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_mhmdjb75=(udg_mhmdjb75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.00,udg_mhmdjb80,Condition(function Trig_tjzs_Func054001003)),function Trig_tjzs_Func054A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_mhmdjb75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_mhmdjb79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_mhmdjb75=0
set udg_mhmdjb74=false
endfunction
function Trig_mhmdjb96UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_mhmdjb97[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_mhmdjb96UP_Func003C takes nothing returns boolean
return ((udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_mhmdjb96UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_mhmdjb96UP_Actions takes nothing returns nothing
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_mhmdjb96UP_Func003C()) then
set udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000土魔之邪魔尘影|r熟练度为 ")+I2S(udg_mhmdjb70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000土魔之邪魔尘影|r  "+(I2S(udg_mhmdjb37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_mhmdjb96UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_mhmdjb14Normal_Func006C takes nothing returns boolean
return ((udg_mhmdjb31[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb32[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb33[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb34[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb35[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_mhmdjb97[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_mhmdjb14Normal_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_mhmdjb17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and(Trig_mhmdjb14Normal_Func006C())
endfunction
function Trig_mhmdjb14Normal_Func003C takes nothing returns boolean
return ((udg_mhmdjb51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetOrderTargetUnit()!=null))
endfunction
function Trig_mhmdjb14Normal_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
if (Trig_mhmdjb14Normal_Func003C()) then
call SetUnitPositionLoc(GetOrderTargetUnit(),GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
endif
endfunction
// 大男人刷物品
function BigMan_ID2S takes integer value returns string
local string charMap =BigMan_AllString
local string result = ""
local integer remainingValue = value
local integer charValue
local integer byteno
set byteno = 0
loop
set charValue = ModuloInteger(remainingValue, 256)
set remainingValue = remainingValue / 256
set result = SubString(charMap, charValue, charValue + 1) + result
set byteno = byteno + 1
exitwhen byteno == 4
endloop
return result
endfunction
function BigMan_S2ID takes string targetstr returns integer
local string originstr=BigMan_AllString
local integer strlength=StringLength(targetstr)
local integer bmloca=0
local integer bmlocb=0
local integer bmlocnumx=1
local integer result=0
loop
exitwhen bmlocb>strlength-1
set bmlocnumx=R2I(Pow(256,strlength-1-bmlocb))
set bmloca=1
loop
exitwhen bmloca>255
if SubString(targetstr,bmlocb,bmlocb+1)==SubString(originstr,bmloca,bmloca+1) then
set result=result+bmloca*bmlocnumx
set bmloca=256
endif
set bmloca=bmloca+1
endloop
set bmlocb=bmlocb+1
endloop
return result
endfunction
function BigMan_Item_Loop2 takes nothing returns nothing
local integer bmlocc=BigMan_Item_Index[0]
local integer bmlocc3=48
local integer bmlocc4=48
local integer bmlocid=0
local item bmlocit
loop
exitwhen bmlocc3>90
set bmlocc4=48
loop
exitwhen bmlocc4>90
set bmlocid=(256*256*256*BigMan_Item_Index[1])+(256*256*BigMan_Item_Index[2])+(256*bmlocc3)+bmlocc4
set bmlocit=CreateItem(bmlocid,0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
set bmlocc=bmlocc+1
set BigMan_ItemTypeId[bmlocc]=bmlocid
set BigMan_ItemName[bmlocc]=GetObjectName(bmlocid)
endif
if bmlocc4==57 then
set bmlocc4=65
else
set bmlocc4=bmlocc4+1
endif
endloop
if bmlocc3==57 then
set bmlocc3=65
else
set bmlocc3=bmlocc3+1
endif
endloop
set BigMan_Item_Index[0]=bmlocc
set bmlocit=null
endfunction
function BigMan_Item_Loop1 takes nothing returns nothing
local integer bmlocc=BigMan_Item_Index[0]
local integer bmlocc3=48
local integer bmlocc4=48
local integer bmlocid=0
local item bmlocit
loop
exitwhen bmlocc3>=123
set bmlocc4=48
loop
exitwhen bmlocc4>=123
set bmlocid=(256*256*256*BigMan_Item_Index[1])+(256*256*BigMan_Item_Index[2])+(256*bmlocc3)+bmlocc4
set bmlocit=CreateItem(bmlocid,0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
set bmlocc=bmlocc+1
set BigMan_ItemTypeId[bmlocc]=bmlocid
set BigMan_ItemName[bmlocc]=GetObjectName(bmlocid)
endif
if bmlocc4==57 then
set bmlocc4=97
else
set bmlocc4=bmlocc4+1
endif
endloop
if bmlocc3==57 then
set bmlocc3=97
else
set bmlocc3=bmlocc3+1
endif
endloop
set BigMan_Item_Index[0]=bmlocc
set bmlocit=null
endfunction
function BigMan_Item_Name_Start takes nothing returns nothing
if BigMan_Item_Index[1]==73 then
call BigMan_Item_Loop2()
if BigMan_Item_Index[2]>=90 then
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
call PauseTimer(BigMan_Item_tm)
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00搜索结束，共找到物品：|r|cffff0000"+I2S(BigMan_Item_Index[0])+"|r  |cff00ff00搜索用时：|r"+R2S(TimerGetElapsed(BigMan_Item_tm)))
call DestroyTimer(BigMan_Item_tm)
elseif BigMan_Item_Index[2]==57 then
set BigMan_Item_Index[2]=65
else
set BigMan_Item_Index[2]=BigMan_Item_Index[2]+1
endif
else
call BigMan_Item_Loop1()
if BigMan_Item_Index[2]==57 then
set BigMan_Item_Index[2]=97
else
set BigMan_Item_Index[2]=BigMan_Item_Index[2]+1
endif
if BigMan_Item_Index[2]>=123 then
set BigMan_Item_Index[2]=48
set BigMan_Item_Index[1]=BigMan_Item_Index[1]+1
endif
if BigMan_Item_Index[1]>=123 then
set BigMan_Item_Index[1]=73
endif
endif
endfunction
function BigMan_Item_Name takes nothing returns nothing
local timer bmloct=CreateTimer()
set BigMan_Item_Index[1]=97
set BigMan_Item_Index[2]=48
set BigMan_Item_Index[0]=0
//********************************
//要提高搜索速度修改下面的0.01数值，修改为0.007时，总搜索速度为6.804
call TimerStart(bmloct,0.01,true,function BigMan_Item_Name_Start)
//Up
//********************************
set bmloct=null
endfunction
function BigMan_CleanItem_Fun takes nothing returns nothing
if IsItemVisible(GetEnumItem()) then
if GetWidgetLife(GetEnumItem())<=0.401 then
call SetWidgetLife(GetEnumItem(),1)
endif
call RemoveItem(GetEnumItem())
endif
endfunction
function BigMan_CleanItem takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function BigMan_CleanItem_Fun)
endfunction
function BigMan_ItemName_Init takes nothing returns nothing
if BigMan_TOF[7777] then
set BigMan_TOF[7777]=false
call BigMan_Item_Name()
set BigMan_Item_tm=CreateTimer()
call TimerStart(BigMan_Item_tm,20,false,null)
endif
endfunction
function BigMan_Item_Query takes nothing returns nothing
local integer bmloci=1
local integer bmlocc=0
local string bmlocs=GetEventPlayerChatString()
local integer bmlock=StringLength(bmlocs)
local integer bmlocpage=BigMan_Item_Page[GetPlayerId(GetTriggerPlayer())]
local integer totalpage=BigMan_Item_Index[0]/75+1
local string array bmlocname
if(bmlocs=="查询")then
if BigMan_TOF[7777] then
set bmlocs=null
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00开始地图内物品检索，预计搜索需要用时为9.718秒，请耐心等待！")
call BigMan_ItemName_Init()
return
endif
if bmlocpage>=totalpage then
set bmlocpage=1
else
set bmlocpage=bmlocpage+1
endif
else
if(S2I(SubString(bmlocs,6,bmlock))>totalpage)then
if bmlocpage>=totalpage then
set bmlocpage=totalpage
else
set bmlocpage=bmlocpage+1
endif
else
if(S2I(SubString(bmlocs,6,bmlock))>0)then
set bmlocpage=S2I(SubString(bmlocs,6,bmlock))
endif
endif
endif
if bmlocpage==0 then
set bmlocpage=1
endif
set BigMan_Item_Page[GetPlayerId(GetTriggerPlayer())]=bmlocpage
loop
exitwhen bmlocc>14
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+1+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+1+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+2+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+2+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+3+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+3+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+4+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+4+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+5+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+5+(bmlocc*5)])+"|r "
set bmlocc=bmlocc+1
endloop
set bmlocc=0
loop
exitwhen bmlocc>14
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,bmlocname[bmlocc])
set bmlocname[bmlocc]=null
set bmlocc=bmlocc+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+I2S(bmlocpage)+"/"+I2S(totalpage)+" |r|CFF0000FF页|r|CFFFF0000查询|r"+" |r|CFFFF6600输入@物品+物品ID，可获得物品。(@可为任意字符。)"))
set bmlocs=null
endfunction
function BigMan_PlayerBag takes nothing returns boolean
local integer bmlocc = 0
local integer bmloci = 0
local integer bmlocpi = GetPlayerId(GetTriggerPlayer())
local integer bmlocbt = BigMan_BagTotal[bmlocpi]
if GetWidgetLife(BigMan_HERO[bmlocpi]) > 1 and bmlocbt>1 and IsUnitType(BigMan_HERO[bmlocpi],ConvertUnitType(0)) and GetOwningPlayer(BigMan_HERO[bmlocpi]) == Player(bmlocpi) then
loop
exitwhen bmlocc > 5
set BigMan_BagItem[bmlocpi*6+bmlocc] = UnitItemInSlot(BigMan_HERO[bmlocpi],bmlocc)
call SetItemPlayer( BigMan_BagItem[bmlocpi*6+bmlocc],Player(bmlocpi), true )
call SetItemPosition( BigMan_BagItem[bmlocpi*6+bmlocc], GetUnitX(BigMan_HERO[bmlocpi]), GetUnitY(BigMan_HERO[bmlocpi]) )
call SetItemVisible( BigMan_BagItem[bmlocpi*6+bmlocc], false )
if BigMan_BagItem[bmlocpi*6+bmlocc] != null then
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00将：|r"+GetItemName(BigMan_BagItem[bmlocpi*6+bmlocc])+" |cffffcc00物品ID：|r"+BigMan_ID2S(GetItemTypeId(BigMan_BagItem[bmlocpi*6+bmlocc]))+" |cffffcc00放入背包中！|r"))
endif
loop
exitwhen bmloci == bmlocbt
set BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci))] = BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci-1))]
set BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci))]=GetItemTypeId(BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci-1))])
set bmloci =bmloci+ 1
endloop
set bmloci=0
set bmlocc = bmlocc + 1
endloop
set bmlocc=0
loop
exitwhen bmlocc > 5
if BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)]!=0 then
if BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)] != null then
call UnitAddItem( BigMan_HERO[bmlocpi], BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)])
call SetItemVisible( BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)],true)
call SetItemPlayer( BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)], Player(15), true )
else
set BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)]=CreateItem(BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)],GetUnitX(BigMan_HERO[bmlocpi]),GetUnitY(BigMan_HERO[bmlocpi]))
call UnitAddItem( BigMan_HERO[bmlocpi],BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)]) 
endif
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00从背包中取出：|r"+GetItemName(BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)])+" |cffffcc00物品ID：|r"+BigMan_ID2S(BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)])))
endif
set bmlocc = bmlocc + 1
endloop
endif
return false
endfunction
function BigMan_Bag_Ini takes integer bmlocpi,integer bmloci returns nothing
call DestroyTrigger(BigMan_BagTrigger[bmlocpi])
set BigMan_BagTrigger[bmlocpi]=CreateTrigger()
call TriggerRegisterPlayerEvent(BigMan_BagTrigger[bmlocpi],Player(bmlocpi),ConvertPlayerEvent(bmloci))
call TriggerAddCondition(BigMan_BagTrigger[bmlocpi], Condition(function BigMan_PlayerBag))
endfunction
function BigMan__ONOFF takes nothing returns nothing
local integer bmloci=0
local integer bmlocc=0
if GetEventPlayerChatString() == "@大男人" then  // 开启密码
set BigMan_TOF[GetPlayerId(GetTriggerPlayer())] = true
call SetPlayerName(GetTriggerPlayer(), ( BigMan_Str[8100+GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer())))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC开|r|cFF4C36D9启|r|cFF333AE6了|r： |cFF1A3EF2“|r|cFF0041FF大|r|cFF076AED男|r|cFF0E94DC人|r|cFF14BDCA”|r |cFF1BE6B8脚|r|cFF29ACAA本|r|cFF37739C！|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@说明，可查看大男人脚本使用；查询脚本使用说明书或者登陆www.ymiii.com查询！|r")
elseif SubString(GetEventPlayerChatString(), 1, 7) == "背包" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if SubString(GetEventPlayerChatString(),7,10) == "ESC" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),17)
elseif SubString(GetEventPlayerChatString(),7,10) == "上" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),267)
elseif SubString(GetEventPlayerChatString(),7,10) == "下" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),265)
elseif SubString(GetEventPlayerChatString(),7,10) == "左" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),261)
elseif SubString(GetEventPlayerChatString(),7,10) == "右" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),263)
endif
set bmloci=S2I(SubString(GetEventPlayerChatString(),10,12))
if bmloci==0 then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
endif
if bmloci<100 then
set BigMan_BagTotal[GetPlayerId(GetTriggerPlayer())] = bmloci
if bmloci>1 then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00背包开启成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cff00ff00背包关闭成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000输入错误背包不能大于16，请忽在其它背包有物品的时候修改背包数从多的设置为少的，否则物品丢失概不负责。|r"))
endif
elseif SubString(GetEventPlayerChatString(),1,7) == "物品" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=BigMan_S2ID(SubString(GetEventPlayerChatString(),7,11))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
set BigMan_Item=null
set BigMan_Item=CreateItem(bmloci,GetUnitX(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]),GetUnitY(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))
if BigMan_Item!=null then
call UnitAddItem(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],BigMan_Item)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000获得物品：|r"+GetItemName(BigMan_Item))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000物品ID错误，请先查询具体ID再输入！|r")
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 5) == "ID2S" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,BigMan_ID2S(S2I(SubString(GetEventPlayerChatString(),5,30))))
elseif SubString(GetEventPlayerChatString(), 1, 7) == "说明" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00开启脚本：@大男人|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@背包ESC3：设置为ESC键切包，背包总数为3，不设置数字为关闭背包。ESC或上下左右均可。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00查询：查询物品名称及ID。@物品I001，刷物品I001给你选择的单位，@可以为任意字符。|r")
endif
endfunction 
function BigMan_Selection takes nothing returns nothing
set BigMan_HERO[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction
function InitTrig_BigMan takes nothing returns nothing
local trigger bmloctrgO = CreateTrigger()
local trigger bmloctrig = CreateTrigger()
local trigger bmloctrgI = CreateTrigger()
local integer bmlocc=0
set BigMan_AllString=".................................!.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
set BigMan_TOF[7777]=true
loop
exitwhen bmlocc>11
call TriggerRegisterPlayerUnitEvent(bmloctrig,Player(bmlocc),ConvertPlayerUnitEvent(24), null)
call TriggerRegisterPlayerChatEvent(bmloctrgO, Player(bmlocc), "", false )
call TriggerRegisterPlayerChatEvent(bmloctrgI, Player(bmlocc), "查询", false )
set BigMan_BagTrigger[bmlocc]=null
set BigMan_Item_Page[bmlocc]=1
set bmlocc=bmlocc+1
endloop
call TriggerAddAction(bmloctrig,function BigMan_Selection)
call TriggerAddAction(bmloctrgO,function BigMan__ONOFF)
call TriggerAddAction(bmloctrgI,function BigMan_Item_Query)
set BigMan_Str[8100]= "|cFFFF0c0c"
set BigMan_Str[8101]= "|cFF0c0cFF"
set BigMan_Str[8102]= "|cFF400000"
set BigMan_Str[8103]= "|cFF0EEEEE"
set BigMan_Str[8104]= "|cFF0EEE00"
set BigMan_Str[8105]= "|cFF7DDDFF"
set BigMan_Str[8106]= "|cFF888888"
set BigMan_Str[8107]= "|cFFF77700"
set BigMan_Str[8108]= "|cFFF222FF"
set BigMan_Str[8109]= "|cFF700077"
set BigMan_Str[8110]= "|cFFF00000"
set BigMan_Str[8111]= "|cFFFFFF00"
set bmloctrgO=null
set bmloctrgI=null
set bmloctrig=null
endfunction