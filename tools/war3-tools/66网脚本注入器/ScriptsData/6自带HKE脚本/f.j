function YPHJKOVVKZ_Z64 takes real YPHJKOVVKZ_Z74,location YPHJKOVVKZ_Z84 returns group
set YPHJKOVVKZ_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(YPHJKOVVKZ_Z14,YPHJKOVVKZ_Z84,YPHJKOVVKZ_Z74,YPHJKOVVKZ_Z34)
return YPHJKOVVKZ_Z14
endfunction
function YPHJKOVVKZ_Z94 takes player YPHJKOVVKZ_zZ4 returns group
set YPHJKOVVKZ_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(YPHJKOVVKZ_Z14,YPHJKOVVKZ_zZ4,YPHJKOVVKZ_Z34)
return YPHJKOVVKZ_Z14
endfunction
function YPHJKOVVKZ_zz4 takes player YPHJKOVVKZ_zZ4,integer YPHJKOVVKZ_z04 returns group
set YPHJKOVVKZ_Z14=CreateGroup()
set bj_groupEnumTypeId=YPHJKOVVKZ_z04
call GroupEnumUnitsOfPlayer(YPHJKOVVKZ_Z14,YPHJKOVVKZ_zZ4,filterGetUnitsOfPlayerAndTypeId)
return YPHJKOVVKZ_Z14
endfunction
function YPHJKOVVKZ_z14 takes player YPHJKOVVKZ_zZ4 returns force
set YPHJKOVVKZ_Z24=CreateForce()
call ForceEnumAllies(YPHJKOVVKZ_Z24,YPHJKOVVKZ_zZ4,YPHJKOVVKZ_Z34)
return YPHJKOVVKZ_Z24
endfunction
function YPHJKOVVKZ_z24 takes player YPHJKOVVKZ_zZ4 returns force
set YPHJKOVVKZ_Z24=CreateForce()
call ForceEnumEnemies(YPHJKOVVKZ_Z24,YPHJKOVVKZ_zZ4,YPHJKOVVKZ_Z34)
return YPHJKOVVKZ_Z24
endfunction
function YPHJKOVVKZ_Z45 takes trigger YPHJKOVVKZ_Z55,player YPHJKOVVKZ_Z65,integer YPHJKOVVKZ_Z75 returns nothing
local playerevent YPHJKOVVKZ_Z85=ConvertPlayerEvent(YPHJKOVVKZ_Z75)
call TriggerRegisterPlayerEvent(YPHJKOVVKZ_Z55,YPHJKOVVKZ_Z65,YPHJKOVVKZ_Z85)
set YPHJKOVVKZ_Z85=null
endfunction
function YPHJKOVVKZ_Z95 takes trigger YPHJKOVVKZ_Z55,player YPHJKOVVKZ_Z65,integer YPHJKOVVKZ_Z75 returns nothing
local playerunitevent YPHJKOVVKZ_Z85=ConvertPlayerUnitEvent(YPHJKOVVKZ_Z75)
call TriggerRegisterPlayerUnitEvent(YPHJKOVVKZ_Z55,YPHJKOVVKZ_Z65,YPHJKOVVKZ_Z85,null)
set YPHJKOVVKZ_Z85=null
endfunction
function YPHJKOVVKZ_zZ5 takes integer YPHJKOVVKZ_Z75,player YPHJKOVVKZ_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(YPHJKOVVKZ_Z30[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(YPHJKOVVKZ_Z50[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,ConvertPlayerUnitEvent(25),null)
call YPHJKOVVKZ_Z45(YPHJKOVVKZ_Z70[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,17)
call YPHJKOVVKZ_Z45(YPHJKOVVKZ_Z90[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,266)
call YPHJKOVVKZ_Z45(YPHJKOVVKZ_Z80[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,268)
call YPHJKOVVKZ_Z45(YPHJKOVVKZ_zZ0[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,262)
call YPHJKOVVKZ_Z45(YPHJKOVVKZ_zz0[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,264)
call TriggerRegisterTimerExpireEvent(YPHJKOVVKZ_z43,YPHJKOVVKZ_z0Z[YPHJKOVVKZ_Z75])
call TriggerRegisterTimerExpireEvent(YPHJKOVVKZ_z33,YPHJKOVVKZ_Z73[YPHJKOVVKZ_Z75])
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_Z40[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,32)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_Z60[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,35)
call TriggerRegisterDialogEvent(YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_Z75],YPHJKOVVKZ_zZ1[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Zz2[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Zz1[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z01[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z81[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z71[YPHJKOVVKZ_Z75],YPHJKOVVKZ_zZ1[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z21[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z31[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z22[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z11[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z51[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z41[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z61[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z12[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z02[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z23[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call TriggerRegisterDialogEvent(YPHJKOVVKZ_Z13[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75])
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z01[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,38)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z11[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,39)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z21[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,40)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z80[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,276)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z80[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,275)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z90[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,276)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z90[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,275)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,18)
call TriggerRegisterPlayerStateEvent(YPHJKOVVKZ_z60[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(YPHJKOVVKZ_z40[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(YPHJKOVVKZ_z50[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_z70[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,20)
call TriggerRegisterPlayerChatEvent(YPHJKOVVKZ_zz1[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,"-",false)
call YPHJKOVVKZ_Z95(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,39)
set YPHJKOVVKZ_Z3z[YPHJKOVVKZ_Z75]=true
endfunction
function YPHJKOVVKZ_zz5 takes player YPHJKOVVKZ_z05,integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_z25)then
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)+YPHJKOVVKZ_z15)
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_GOLD_GATHERED)-YPHJKOVVKZ_z15)
else
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)-YPHJKOVVKZ_z15)
endif
endfunction
function YPHJKOVVKZ_z35 takes player YPHJKOVVKZ_z05,integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_z25)then
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)+YPHJKOVVKZ_z15)
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_LUMBER_GATHERED)-YPHJKOVVKZ_z15)
else
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)-YPHJKOVVKZ_z15)
endif
endfunction
function YPHJKOVVKZ_z45 takes player YPHJKOVVKZ_z05 returns nothing
local player YPHJKOVVKZ_Z65=GetLocalPlayer()
if YPHJKOVVKZ_z05==YPHJKOVVKZ_Z65 then
set YPHJKOVVKZ_Z65=Player(-1)
endif
set YPHJKOVVKZ_Z65=null
endfunction
function YPHJKOVVKZ_z55 takes unit YPHJKOVVKZ_z65,unit YPHJKOVVKZ_z75,boolean YPHJKOVVKZ_z85 returns nothing
local location YPHJKOVVKZ_z95
local location YPHJKOVVKZ_ZZ6
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_ZZ6=GetUnitLoc(YPHJKOVVKZ_z75)
call SetUnitPositionLoc(YPHJKOVVKZ_z65,YPHJKOVVKZ_ZZ6)
if(YPHJKOVVKZ_z85)then
call SetUnitPositionLoc(YPHJKOVVKZ_z75,YPHJKOVVKZ_z95)
call SetUnitPositionLoc(YPHJKOVVKZ_z65,YPHJKOVVKZ_ZZ6)
endif
call RemoveLocation(YPHJKOVVKZ_z95)
call RemoveLocation(YPHJKOVVKZ_ZZ6)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_ZZ6=null
endfunction
function YPHJKOVVKZ_Zz6 takes integer YPHJKOVVKZ_Z06 returns nothing
if(YPHJKOVVKZ_Z06==0)then
set YPHJKOVVKZ_zZ2=100
set YPHJKOVVKZ_Z92=100
set YPHJKOVVKZ_Z82=100
set YPHJKOVVKZ_Z72="|cFFFFFFFF"
return
endif
if(YPHJKOVVKZ_Z06==1)then
set YPHJKOVVKZ_zZ2=50
set YPHJKOVVKZ_Z92=50
set YPHJKOVVKZ_Z82=50
set YPHJKOVVKZ_Z72="|cFF7F7F7F"
return
endif
if(YPHJKOVVKZ_Z06==2)then
set YPHJKOVVKZ_zZ2=0
set YPHJKOVVKZ_Z92=0
set YPHJKOVVKZ_Z82=0
set YPHJKOVVKZ_Z72="|cFF000000"
return
endif
if(YPHJKOVVKZ_Z06==3)then
set YPHJKOVVKZ_zZ2=100
set YPHJKOVVKZ_Z92=0
set YPHJKOVVKZ_Z82=0
set YPHJKOVVKZ_Z72="|cFFFF0000"
return
endif
if(YPHJKOVVKZ_Z06==4)then
set YPHJKOVVKZ_zZ2=100
set YPHJKOVVKZ_Z92=50
set YPHJKOVVKZ_Z82=0
set YPHJKOVVKZ_Z72="|cFFFF7F00"
return
endif
if(YPHJKOVVKZ_Z06==5)then
set YPHJKOVVKZ_zZ2=100
set YPHJKOVVKZ_Z92=100
set YPHJKOVVKZ_Z82=0
set YPHJKOVVKZ_Z72="|cFFFFFF00"
return
endif
if(YPHJKOVVKZ_Z06==6)then
set YPHJKOVVKZ_zZ2=0
set YPHJKOVVKZ_Z92=100
set YPHJKOVVKZ_Z82=0
set YPHJKOVVKZ_Z72="|cFF00FF00"
return
endif
if(YPHJKOVVKZ_Z06==7)then
set YPHJKOVVKZ_zZ2=0
set YPHJKOVVKZ_Z92=100
set YPHJKOVVKZ_Z82=100
set YPHJKOVVKZ_Z72="|cFF00FFFF"
return
endif
if(YPHJKOVVKZ_Z06==8)then
set YPHJKOVVKZ_zZ2=0
set YPHJKOVVKZ_Z92=0
set YPHJKOVVKZ_Z82=100
set YPHJKOVVKZ_Z72="|cFF0000FF"
return
endif
if(YPHJKOVVKZ_Z06==9)then
set YPHJKOVVKZ_zZ2=100
set YPHJKOVVKZ_Z92=0
set YPHJKOVVKZ_Z82=100
set YPHJKOVVKZ_Z72="|cFFFF00FF"
return
endif
endfunction
function YPHJKOVVKZ_Z16 takes integer YPHJKOVVKZ_Z06,unit YPHJKOVVKZ_Z26,string YPHJKOVVKZ_Z36 returns nothing
local texttag YPHJKOVVKZ_Z46
local location YPHJKOVVKZ_z95
call YPHJKOVVKZ_Zz6(YPHJKOVVKZ_Z06)
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_Z26)
set YPHJKOVVKZ_Z46=CreateTextTagLocBJ(YPHJKOVVKZ_Z36,YPHJKOVVKZ_z95,0,20,YPHJKOVVKZ_zZ2,YPHJKOVVKZ_Z92,YPHJKOVVKZ_Z82,0)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
call SetTextTagPermanent(YPHJKOVVKZ_Z46,false)
call SetTextTagLifespan(YPHJKOVVKZ_Z46,YPHJKOVVKZ_Z1)
set YPHJKOVVKZ_Z46=null
endfunction
function YPHJKOVVKZ_Z56 takes nothing returns nothing
local trigger YPHJKOVVKZ_Z66=GetTriggeringTrigger()
local timer YPHJKOVVKZ_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(YPHJKOVVKZ_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(YPHJKOVVKZ_z52)
call DestroyTimerDialog(YPHJKOVVKZ_z82)
call DestroyTimer(YPHJKOVVKZ_Z76)
set YPHJKOVVKZ_Z66=null
set YPHJKOVVKZ_Z76=null
endfunction
function YPHJKOVVKZ_Z86 takes nothing returns nothing
local timer YPHJKOVVKZ_Z76
local trigger YPHJKOVVKZ_Z66
if(YPHJKOVVKZ_z62)then
else
set YPHJKOVVKZ_z52=GetGameSpeed()
set YPHJKOVVKZ_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call UnlockGameSpeedBJ()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call LockGameSpeedBJ()
set YPHJKOVVKZ_Z66=CreateTrigger()
set YPHJKOVVKZ_Z76=CreateTimer()
call StartTimerBJ(YPHJKOVVKZ_Z76,false,YPHJKOVVKZ_z42)
set YPHJKOVVKZ_z82=CreateTimerDialogBJ(YPHJKOVVKZ_Z76,"子弹时间")
call TriggerAddAction(YPHJKOVVKZ_Z66,function YPHJKOVVKZ_Z56)
call TriggerRegisterTimerExpireEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_Z76)
endif
endfunction
function YPHJKOVVKZ_Z96 takes trigger YPHJKOVVKZ_zZ6 returns nothing
if(IsTriggerEnabled(YPHJKOVVKZ_zZ6))then
call DisableTrigger(YPHJKOVVKZ_zZ6)
else
call EnableTrigger(YPHJKOVVKZ_zZ6)
endif
endfunction
function YPHJKOVVKZ_zz6 takes trigger YPHJKOVVKZ_zZ6,boolean YPHJKOVVKZ_z06 returns nothing
if(IsTriggerEnabled(YPHJKOVVKZ_zZ6)==YPHJKOVVKZ_z06)then
else
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_zZ6)
endif
endfunction
function YPHJKOVVKZ_z16 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
endfunction
function YPHJKOVVKZ_z26 takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
if(GetUnitUserData(YPHJKOVVKZ_z65)==2176)then
call RemoveUnit(YPHJKOVVKZ_z65)
endif
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_z36 takes player YPHJKOVVKZ_z05 returns nothing
local group YPHJKOVVKZ_z46
if(YPHJKOVVKZ_Z42[GetPlayerId(YPHJKOVVKZ_z05)])then
set YPHJKOVVKZ_z46=YPHJKOVVKZ_Z94(YPHJKOVVKZ_z05)
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_z26)
set YPHJKOVVKZ_Z42[GetPlayerId(YPHJKOVVKZ_z05)]=false
call DestroyGroup(YPHJKOVVKZ_z46)
set YPHJKOVVKZ_z46=null
endif
endfunction
function YPHJKOVVKZ_z56 takes unit YPHJKOVVKZ_z65,player YPHJKOVVKZ_z05 returns nothing
local location YPHJKOVVKZ_z95
local integer YPHJKOVVKZ_z66
local unit YPHJKOVVKZ_z76
local item YPHJKOVVKZ_z86
local integer YPHJKOVVKZ_Z75=0
if(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_HERO))then
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z66=GetUnitTypeId(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z76=CreateUnitAtLoc(YPHJKOVVKZ_z05,YPHJKOVVKZ_z66,YPHJKOVVKZ_z95,bj_UNIT_FACING)
call SetUnitUserData(YPHJKOVVKZ_z76,2176)
set YPHJKOVVKZ_Z42[GetPlayerId(YPHJKOVVKZ_z05)]=true
if(YPHJKOVVKZ_Z6Z)then
call SetUnitUseFood(YPHJKOVVKZ_z76,false)
endif
call SetHeroLevelBJ(YPHJKOVVKZ_z76,GetHeroLevel(YPHJKOVVKZ_z65),false)
call SetHeroStat(YPHJKOVVKZ_z76,0,GetHeroStatBJ(0,YPHJKOVVKZ_z65,false))
call SetHeroStat(YPHJKOVVKZ_z76,1,GetHeroStatBJ(1,YPHJKOVVKZ_z65,false))
call SetHeroStat(YPHJKOVVKZ_z76,2,GetHeroStatBJ(2,YPHJKOVVKZ_z65,false))
loop
exitwhen YPHJKOVVKZ_Z75>5
set YPHJKOVVKZ_z86=UnitItemInSlot(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z75)
call UnitAddItemById(YPHJKOVVKZ_z76,GetItemTypeId(YPHJKOVVKZ_z86))
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
endif
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_z76=null
set YPHJKOVVKZ_z86=null
endfunction
function YPHJKOVVKZ_z96 takes integer YPHJKOVVKZ_ZZ7,player YPHJKOVVKZ_Zz7,location YPHJKOVVKZ_Z07,boolean YPHJKOVVKZ_Z17,boolean YPHJKOVVKZ_Z27 returns nothing
local unit YPHJKOVVKZ_z76
set YPHJKOVVKZ_z76=CreateUnitAtLoc(YPHJKOVVKZ_Zz7,YPHJKOVVKZ_ZZ7,YPHJKOVVKZ_Z07,bj_UNIT_FACING)
if(YPHJKOVVKZ_Z6Z)then
call SetUnitUseFood(YPHJKOVVKZ_z76,false)
endif
if(YPHJKOVVKZ_Z17)then
call SetUnitUserData(YPHJKOVVKZ_z76,2176)
endif
if(YPHJKOVVKZ_Z27)then
call UnitApplyTimedLife(YPHJKOVVKZ_z76,1112820806,90)
endif
set YPHJKOVVKZ_z76=null
endfunction
function YPHJKOVVKZ_Z37 takes integer YPHJKOVVKZ_ZZ7,player YPHJKOVVKZ_Zz7,location YPHJKOVVKZ_Z07 returns nothing
local unit YPHJKOVVKZ_z76
set YPHJKOVVKZ_z76=CreateUnitAtLoc(YPHJKOVVKZ_Zz7,YPHJKOVVKZ_ZZ7,YPHJKOVVKZ_Z07,bj_UNIT_FACING)
if(YPHJKOVVKZ_Z6Z)then
call SetUnitUseFood(YPHJKOVVKZ_z76,false)
set YPHJKOVVKZ_z76=null
endif
endfunction
function YPHJKOVVKZ_Z47 takes unit YPHJKOVVKZ_Z57,player YPHJKOVVKZ_Zz7,integer YPHJKOVVKZ_Z67,boolean YPHJKOVVKZ_Z27 returns nothing
local location YPHJKOVVKZ_z95
local integer YPHJKOVVKZ_z66
local integer YPHJKOVVKZ_Z75
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_Z57)
set YPHJKOVVKZ_z66=GetUnitTypeId(YPHJKOVVKZ_Z57)
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>YPHJKOVVKZ_Z67
call YPHJKOVVKZ_z96(YPHJKOVVKZ_z66,YPHJKOVVKZ_Zz7,YPHJKOVVKZ_z95,true,YPHJKOVVKZ_Z27)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_Z42[GetPlayerId(YPHJKOVVKZ_Zz7)]=true
set YPHJKOVVKZ_z95=null
endfunction
function YPHJKOVVKZ_Z77 takes unit YPHJKOVVKZ_Z57,player YPHJKOVVKZ_Zz7,integer YPHJKOVVKZ_Z67 returns nothing
call YPHJKOVVKZ_Z47(YPHJKOVVKZ_Z57,YPHJKOVVKZ_Zz7,YPHJKOVVKZ_Z67,false)
endfunction
function YPHJKOVVKZ_Z87 takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_Z97 returns nothing
local integer YPHJKOVVKZ_Z75
set YPHJKOVVKZ_Z75=GetResourceAmount(YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_Z97)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+YPHJKOVVKZ_z15
else
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75-YPHJKOVVKZ_z15
endif
if(YPHJKOVVKZ_Z75<0)then
if(YPHJKOVVKZ_Z97)then
set YPHJKOVVKZ_Z75=GetResourceAmount(YPHJKOVVKZ_z65)
else
set YPHJKOVVKZ_Z75=0
endif
endif
call SetResourceAmount(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z75)
endfunction
function YPHJKOVVKZ_zZ7 takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05,boolean YPHJKOVVKZ_zz7 returns nothing
if(YPHJKOVVKZ_zz7)then
call SetPlayerTechMaxAllowed(YPHJKOVVKZ_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(YPHJKOVVKZ_z05,1212502607,3)
endif
endfunction
function YPHJKOVVKZ_z07 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z06 returns nothing
if(YPHJKOVVKZ_z06)then
call EnableTrigger(YPHJKOVVKZ_z00[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_z10[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_z20[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_z30[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z70[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z80[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z90[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_zZ0[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_zz0[YPHJKOVVKZ_z15])
else
call DisableTrigger(YPHJKOVVKZ_z00[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z10[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z20[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z30[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z70[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z80[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z90[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_zZ0[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_zz0[YPHJKOVVKZ_z15])
endif
endfunction
function YPHJKOVVKZ_z17 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z27 returns nothing
if(YPHJKOVVKZ_z27)then
call EnableTrigger(YPHJKOVVKZ_Z40[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z60[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_z15])
else
call DisableTrigger(YPHJKOVVKZ_Z40[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z60[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_z15])
endif
endfunction
function YPHJKOVVKZ_z37 takes nothing returns nothing
local integer YPHJKOVVKZ_z15
set YPHJKOVVKZ_z15=0
loop
exitwhen YPHJKOVVKZ_z15>11
call YPHJKOVVKZ_z07(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endfunction
function YPHJKOVVKZ_z47 takes integer YPHJKOVVKZ_z15 returns nothing
set YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]=false
call GroupClear(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])
if(YPHJKOVVKZ_Z7Z)then
call DestroyFogModifier(YPHJKOVVKZ_Z6[YPHJKOVVKZ_z15])
endif
call DisableTrigger(YPHJKOVVKZ_Z30[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z50[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_zz1[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Zz1[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Zz2[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z01[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z81[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z21[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z51[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z41[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z61[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z12[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z02[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z71[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z31[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z22[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z11[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z23[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z13[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_zZ3[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z40[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z60[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_z07(YPHJKOVVKZ_z15,false)
endfunction
function YPHJKOVVKZ_z57 takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
set YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_Z3z[YPHJKOVVKZ_z15])then
else
call YPHJKOVVKZ_zZ5(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
call EnableTrigger(YPHJKOVVKZ_Z30[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_Z50[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_zz1[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_z07(YPHJKOVVKZ_z15,true)
endfunction
function YPHJKOVVKZ_z67 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z77 returns nothing
if(YPHJKOVVKZ_z77)then
if((YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]))then
call EnableTrigger(YPHJKOVVKZ_z01[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_z11[YPHJKOVVKZ_z15])
call EnableTrigger(YPHJKOVVKZ_z21[YPHJKOVVKZ_z15])
endif
else
call DisableTrigger(YPHJKOVVKZ_z01[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z11[YPHJKOVVKZ_z15])
call DisableTrigger(YPHJKOVVKZ_z21[YPHJKOVVKZ_z15])
endif
endfunction
function YPHJKOVVKZ_z87 takes integer YPHJKOVVKZ_Z06 returns nothing
if(YPHJKOVVKZ_Z06==0)then
set YPHJKOVVKZ_zz2=0
return
endif
if(YPHJKOVVKZ_Z06==1)then
set YPHJKOVVKZ_zz2=10
return
endif
if(YPHJKOVVKZ_Z06==2)then
set YPHJKOVVKZ_zz2=15
return
endif
if(YPHJKOVVKZ_Z06==3)then
set YPHJKOVVKZ_zz2=20
return
endif
if(YPHJKOVVKZ_Z06==4)then
set YPHJKOVVKZ_zz2=40
return
endif
if(YPHJKOVVKZ_Z06==5)then
set YPHJKOVVKZ_zz2=50
return
endif
if(YPHJKOVVKZ_Z06==6)then
set YPHJKOVVKZ_zz2=70
return
endif
if(YPHJKOVVKZ_Z06==7)then
set YPHJKOVVKZ_zz2=80
return
endif
if(YPHJKOVVKZ_Z06==8)then
set YPHJKOVVKZ_zz2=90
return
endif
if(YPHJKOVVKZ_Z06==9)then
set YPHJKOVVKZ_zz2=100
return
endif
endfunction
function YPHJKOVVKZ_z97 takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_ZZ8,integer YPHJKOVVKZ_Zz8 returns nothing
call YPHJKOVVKZ_z87(YPHJKOVVKZ_Zz8)
call YPHJKOVVKZ_Zz6(YPHJKOVVKZ_ZZ8)
call SetUnitVertexColorBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_zZ2,YPHJKOVVKZ_Z92,YPHJKOVVKZ_Z82,YPHJKOVVKZ_zz2)
endfunction
function YPHJKOVVKZ_Z08 takes integer YPHJKOVVKZ_ZZ8,integer YPHJKOVVKZ_Zz8 returns nothing
call YPHJKOVVKZ_z87(YPHJKOVVKZ_Zz8)
call YPHJKOVVKZ_Zz6(YPHJKOVVKZ_ZZ8)
call SetWaterBaseColorBJ(YPHJKOVVKZ_zZ2,YPHJKOVVKZ_Z92,YPHJKOVVKZ_Z82,YPHJKOVVKZ_zz2)
endfunction
function YPHJKOVVKZ_Z18 takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_z97(YPHJKOVVKZ_z65,GetRandomInt(3,9),0)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z28 takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_z97(YPHJKOVVKZ_z65,0,0)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z38 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z77 returns nothing
local integer YPHJKOVVKZ_Z75
local integer YPHJKOVVKZ_Z48
if(YPHJKOVVKZ_Z53[YPHJKOVVKZ_z15]==YPHJKOVVKZ_z77)then
else
set YPHJKOVVKZ_Z53[YPHJKOVVKZ_z15]=YPHJKOVVKZ_z77
if(YPHJKOVVKZ_z77)then
call EnableTrigger(YPHJKOVVKZ_z83)
else
set YPHJKOVVKZ_Z75=0
set YPHJKOVVKZ_Z48=0
loop
exitwhen YPHJKOVVKZ_Z75>11
if(YPHJKOVVKZ_Z53[YPHJKOVVKZ_Z75])then
set YPHJKOVVKZ_Z48=YPHJKOVVKZ_Z48+1
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
if(YPHJKOVVKZ_Z48==0)then
call DisableTrigger(YPHJKOVVKZ_z83)
endif
endif
endif
endfunction
function YPHJKOVVKZ_Z58 takes integer YPHJKOVVKZ_Z68 returns nothing
if(YPHJKOVVKZ_Z68==0)then
call SetSkyModel(null)
return
endif
if(YPHJKOVVKZ_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(YPHJKOVVKZ_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(YPHJKOVVKZ_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(YPHJKOVVKZ_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(YPHJKOVVKZ_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(YPHJKOVVKZ_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(YPHJKOVVKZ_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function YPHJKOVVKZ_Z78 takes integer YPHJKOVVKZ_Z88 returns integer
if(YPHJKOVVKZ_Z88==0)then
return 1380018290
endif
if(YPHJKOVVKZ_Z88==1)then
return 1380019314
endif
if(YPHJKOVVKZ_Z88==2)then
return 1296393331
endif
if(YPHJKOVVKZ_Z88==3)then
return 1178886760
endif
if(YPHJKOVVKZ_Z88==4)then
return 1178886764
endif
if(YPHJKOVVKZ_Z88==5)then
return 1178888040
endif
if(YPHJKOVVKZ_Z88==6)then
return 1178888044
endif
if(YPHJKOVVKZ_Z88==7)then
return 1178890856
endif
if(YPHJKOVVKZ_Z88==8)then
return 1178890860
endif
if(YPHJKOVVKZ_Z88==9)then
return 1178892136
endif
if(YPHJKOVVKZ_Z88==10)then
return 1178892140
endif
if(YPHJKOVVKZ_Z88==11)then
return 1380739186
endif
if(YPHJKOVVKZ_Z88==12)then
return 1380740210
endif
if(YPHJKOVVKZ_Z88==13)then
return 1397645939
endif
if(YPHJKOVVKZ_Z88==14)then
return 1397647475
endif
if(YPHJKOVVKZ_Z88==15)then
return 1397648499
endif
if(YPHJKOVVKZ_Z88==16)then
return 1464820599
endif
if(YPHJKOVVKZ_Z88==17)then
return 1464822903
endif
if(YPHJKOVVKZ_Z88==18)then
return 1280467297
endif
if(YPHJKOVVKZ_Z88==19)then
return 1280470369
endif
if(YPHJKOVVKZ_Z88==20)then
return 1464755063
endif
return 0
endfunction
function YPHJKOVVKZ_Z98 takes integer YPHJKOVVKZ_Z88,boolean YPHJKOVVKZ_z77 returns nothing
set YPHJKOVVKZ_Z88=YPHJKOVVKZ_Z88-1
if(YPHJKOVVKZ_z77)then
if(YPHJKOVVKZ_z12[YPHJKOVVKZ_Z88]==false)then
if(YPHJKOVVKZ_Z78(YPHJKOVVKZ_Z88)==0)then
else
set YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88]=AddWeatherEffect(YPHJKOVVKZ_z8,YPHJKOVVKZ_Z78(YPHJKOVVKZ_Z88))
call EnableWeatherEffect(YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88],true)
set YPHJKOVVKZ_z12[YPHJKOVVKZ_Z88]=true
endif
endif
else
if(YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88]==null)then
else
call EnableWeatherEffect(YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88],false)
call RemoveWeatherEffect(YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88])
set YPHJKOVVKZ_z12[YPHJKOVVKZ_Z88]=false
set YPHJKOVVKZ_z02[YPHJKOVVKZ_Z88]=null
endif
endif
endfunction
function YPHJKOVVKZ_zZ8 takes nothing returns nothing
local integer YPHJKOVVKZ_z15=1
loop
exitwhen YPHJKOVVKZ_z15>21
call YPHJKOVVKZ_Z98(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endfunction
function YPHJKOVVKZ_zz8 takes integer YPHJKOVVKZ_z08 returns integer
if(YPHJKOVVKZ_z08==0)then
return 1280601204
endif
if(YPHJKOVVKZ_z08==1)then
return 1179939959
endif
if(YPHJKOVVKZ_z08==2)then
return 1465152631
endif
if(YPHJKOVVKZ_z08==3)then
return 1096053874
endif
if(YPHJKOVVKZ_z08==4)then
return 1096053859
endif
if(YPHJKOVVKZ_z08==5)then
return 1112831095
endif
if(YPHJKOVVKZ_z08==6)then
return 1263826039
endif
if(YPHJKOVVKZ_z08==7)then
return 1498707828
endif
if(YPHJKOVVKZ_z08==8)then
return 1498702708
endif
if(YPHJKOVVKZ_z08==9)then
return 1498703476
endif
if(YPHJKOVVKZ_z08==10)then
return 1498706804
endif
if(YPHJKOVVKZ_z08==11)then
return 1247044468
endif
if(YPHJKOVVKZ_z08==12)then
return 1247048823
endif
if(YPHJKOVVKZ_z08==13)then
return 1146385256
endif
if(YPHJKOVVKZ_z08==14)then
return 1129608306
endif
if(YPHJKOVVKZ_z08==15)then
return 1129608291
endif
if(YPHJKOVVKZ_z08==16)then
return 1230271607
endif
if(YPHJKOVVKZ_z08==17)then
return 1230271607
endif
if(YPHJKOVVKZ_z08==18)then
return 1314157667
endif
if(YPHJKOVVKZ_z08==19)then
return 1330934903
endif
if(YPHJKOVVKZ_z08==20)then
return 1515484279
endif
if(YPHJKOVVKZ_z08==21)then
return 1196716904
endif
if(YPHJKOVVKZ_z08==22)then
return 1448373364
endif
if(YPHJKOVVKZ_z08==23)then
return 1448373364
endif
return 0
endfunction
function YPHJKOVVKZ_z18 takes nothing returns integer
return YPHJKOVVKZ_zz8(GetRandomInt(0,23))
endfunction
function YPHJKOVVKZ_z28 takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_z38,integer YPHJKOVVKZ_z08,integer YPHJKOVVKZ_z48 returns nothing
local real YPHJKOVVKZ_z58
local real YPHJKOVVKZ_z68
local real YPHJKOVVKZ_z15=0
local boolean YPHJKOVVKZ_z78=true
set YPHJKOVVKZ_z58=GetUnitX(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z68=GetUnitY(YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_z38==1)then
loop
exitwhen YPHJKOVVKZ_z15==YPHJKOVVKZ_z48
if(YPHJKOVVKZ_z78)then
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58,YPHJKOVVKZ_z68+YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58,YPHJKOVVKZ_z68-YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
endif
set YPHJKOVVKZ_z78=not(YPHJKOVVKZ_z78)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endif
if(YPHJKOVVKZ_z38==2)then
loop
exitwhen YPHJKOVVKZ_z15==YPHJKOVVKZ_z48
if(YPHJKOVVKZ_z78)then
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58+YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58-YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68,GetRandomReal(0,360),1,0)
endif
set YPHJKOVVKZ_z78=not(YPHJKOVVKZ_z78)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endif
if(YPHJKOVVKZ_z38==3)then
loop
exitwhen YPHJKOVVKZ_z15==YPHJKOVVKZ_z48
if(YPHJKOVVKZ_z78)then
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58+YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68+YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58-YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68-YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
endif
set YPHJKOVVKZ_z78=not(YPHJKOVVKZ_z78)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endif
if(YPHJKOVVKZ_z38==4)then
loop
exitwhen YPHJKOVVKZ_z15==YPHJKOVVKZ_z48
if(YPHJKOVVKZ_z78)then
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58+YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68-YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(YPHJKOVVKZ_z08,YPHJKOVVKZ_z58-YPHJKOVVKZ_z15*40,YPHJKOVVKZ_z68+YPHJKOVVKZ_z15*40,GetRandomReal(0,360),1,0)
endif
set YPHJKOVVKZ_z78=not(YPHJKOVVKZ_z78)
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
endif
endfunction
function YPHJKOVVKZ_z88 takes integer YPHJKOVVKZ_z15 returns nothing
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=true
call StartTimerBJ(YPHJKOVVKZ_z0Z[YPHJKOVVKZ_z15],false,2.)
endfunction
function YPHJKOVVKZ_z98 takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_ZZZZ returns nothing
local integer YPHJKOVVKZ_Z75
local integer YPHJKOVVKZ_z76
local item YPHJKOVVKZ_z86
local location YPHJKOVVKZ_z95
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]
set YPHJKOVVKZ_z76=1
loop
exitwhen YPHJKOVVKZ_z76>6
if(YPHJKOVVKZ_ZZZZ)then
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z51[YPHJKOVVKZ_z15])
else
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
endif
set YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z76)
if(GetItemCharges(YPHJKOVVKZ_z86)>0)then
set YPHJKOVVKZ_Z75=GetItemCharges(YPHJKOVVKZ_z86)
set YPHJKOVVKZ_z86=CreateItemLoc(GetItemTypeId(YPHJKOVVKZ_z86),YPHJKOVVKZ_z95)
call SetItemCharges(YPHJKOVVKZ_z86,YPHJKOVVKZ_Z75)
else
call CreateItemLoc(GetItemTypeId(YPHJKOVVKZ_z86),YPHJKOVVKZ_z95)
endif
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z76=YPHJKOVVKZ_z76+1
endloop
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_z86=null
endfunction
function YPHJKOVVKZ_ZZzZ takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local integer YPHJKOVVKZ_Z75
local force YPHJKOVVKZ_ZZ0Z
local player YPHJKOVVKZ_Z65
if(YPHJKOVVKZ_z1Z[YPHJKOVVKZ_z15])then
call DestroyFogModifier(YPHJKOVVKZ_Z6[YPHJKOVVKZ_z15])
set YPHJKOVVKZ_z1Z[YPHJKOVVKZ_z15]=false
else
set YPHJKOVVKZ_ZZ0Z=CreateForce()
set YPHJKOVVKZ_Z75=0
loop
exitwhen YPHJKOVVKZ_Z75>11
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if(GetPlayerAlliance(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(YPHJKOVVKZ_ZZ0Z,YPHJKOVVKZ_Z65)
call SetPlayerAlliance(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z65,ALLIANCE_SHARED_VISION,false)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z6[YPHJKOVVKZ_z15]=CreateFogModifierRect(YPHJKOVVKZ_z05,FOG_OF_WAR_VISIBLE,YPHJKOVVKZ_z8,false,false)
call FogModifierStart(YPHJKOVVKZ_Z6[YPHJKOVVKZ_z15])
set YPHJKOVVKZ_z1Z[YPHJKOVVKZ_z15]=true
set YPHJKOVVKZ_Z75=0
loop
exitwhen YPHJKOVVKZ_Z75>11
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if(IsPlayerInForce(YPHJKOVVKZ_Z65,YPHJKOVVKZ_ZZ0Z))then
call SetPlayerAlliance(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z65,ALLIANCE_SHARED_VISION,true)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call DestroyForce(YPHJKOVVKZ_ZZ0Z)
set YPHJKOVVKZ_ZZ0Z=null
set YPHJKOVVKZ_Z65=null
endif
endfunction
function YPHJKOVVKZ_ZZ1Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local integer YPHJKOVVKZ_Z75
local unit YPHJKOVVKZ_z65
local item YPHJKOVVKZ_z86
local item array YPHJKOVVKZ_ZZ2Z
set YPHJKOVVKZ_z65=FirstOfGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])
if((YPHJKOVVKZ_z05==GetOwningPlayer(YPHJKOVVKZ_z65))and(UnitInventorySizeBJ(YPHJKOVVKZ_z65)>0))then
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>6
set YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z75)
set YPHJKOVVKZ_ZZ2Z[(YPHJKOVVKZ_Z75-1)]=YPHJKOVVKZ_z86
call UnitRemoveItemSwapped(YPHJKOVVKZ_z86,YPHJKOVVKZ_z65)
call SetItemVisible(YPHJKOVVKZ_z86,false)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>6
set YPHJKOVVKZ_z86=YPHJKOVVKZ_Z2z[(YPHJKOVVKZ_z15*18)+(YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]*6)+(YPHJKOVVKZ_Z75-1)]
call UnitAddItem(YPHJKOVVKZ_z65,YPHJKOVVKZ_z86)
set YPHJKOVVKZ_Z2z[(YPHJKOVVKZ_z15*18)+(YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]*6)+(YPHJKOVVKZ_Z75-1)]=YPHJKOVVKZ_ZZ2Z[(YPHJKOVVKZ_Z75-1)]
set YPHJKOVVKZ_ZZ2Z[(YPHJKOVVKZ_Z75-1)]=null
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
if(YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]==0)then
set YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]=YPHJKOVVKZ_z61-1
else
set YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]=(YPHJKOVVKZ_Z4z[YPHJKOVVKZ_z15]-1)
endif
set YPHJKOVVKZ_z86=null
endif
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_ZZ3Z takes unit YPHJKOVVKZ_z65 returns nothing
local integer YPHJKOVVKZ_Z75
local item YPHJKOVVKZ_z86
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>6
set YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z75)
call UnitRemoveItemSwapped(YPHJKOVVKZ_z86,YPHJKOVVKZ_z65)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_z86=null
endfunction
function YPHJKOVVKZ_ZZ4Z takes integer YPHJKOVVKZ_z15 returns nothing
local integer YPHJKOVVKZ_Z75
local item YPHJKOVVKZ_z86
local location YPHJKOVVKZ_z95
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z51[YPHJKOVVKZ_z15])
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>6
set YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z75)
call UnitRemoveItemSwapped(YPHJKOVVKZ_z86,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
call SetItemPositionLoc(YPHJKOVVKZ_z86,YPHJKOVVKZ_z95)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z86=null
set YPHJKOVVKZ_z95=null
endfunction
function YPHJKOVVKZ_ZZ5Z takes integer YPHJKOVVKZ_z15 returns nothing
local integer YPHJKOVVKZ_z76
local integer YPHJKOVVKZ_z78
local unit YPHJKOVVKZ_z65
local item YPHJKOVVKZ_Z66
local item YPHJKOVVKZ_ZZ6Z
set YPHJKOVVKZ_z65=FirstOfGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])
set YPHJKOVVKZ_z76=1
loop
exitwhen YPHJKOVVKZ_z76>5
set YPHJKOVVKZ_Z66=UnitItemInSlotBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z76)
if(GetItemCharges(YPHJKOVVKZ_Z66)>0)then
set YPHJKOVVKZ_z78=YPHJKOVVKZ_z76+1
loop
exitwhen YPHJKOVVKZ_z78>6
set YPHJKOVVKZ_ZZ6Z=UnitItemInSlotBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z78)
if(GetItemTypeId(YPHJKOVVKZ_Z66)==GetItemTypeId(YPHJKOVVKZ_ZZ6Z))then
call SetItemCharges(YPHJKOVVKZ_Z66,(GetItemCharges(YPHJKOVVKZ_Z66)+GetItemCharges(YPHJKOVVKZ_ZZ6Z)))
call RemoveItem(YPHJKOVVKZ_ZZ6Z)
endif
set YPHJKOVVKZ_z78=YPHJKOVVKZ_z78+1
endloop
endif
set YPHJKOVVKZ_z76=YPHJKOVVKZ_z76+1
endloop
set YPHJKOVVKZ_Z66=null
set YPHJKOVVKZ_ZZ6Z=null
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_ZZ7Z takes integer YPHJKOVVKZ_z15,integer YPHJKOVVKZ_Z75 returns nothing
local unit YPHJKOVVKZ_z65
local item YPHJKOVVKZ_z86
set YPHJKOVVKZ_z65=FirstOfGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])
set YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z65,1)
call SetItemCharges(YPHJKOVVKZ_z86,(GetItemCharges(YPHJKOVVKZ_z86)+YPHJKOVVKZ_Z75))
set YPHJKOVVKZ_z86=null
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_ZZ8Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call GroupAddUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_ZZ9Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call GroupRemoveUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_ZzZZ takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetTriggerUnit()
if((IsUnitDeadBJ(YPHJKOVVKZ_z65))and(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z65)
endif
endfunction
function YPHJKOVVKZ_ZzzZ takes nothing returns nothing
call ForGroup(YPHJKOVVKZ_z8Z,function YPHJKOVVKZ_ZzZZ)
endfunction
function YPHJKOVVKZ_Zz0Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call ReviveHeroLoc(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_Zzz],true)
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,100)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Zz1Z takes player YPHJKOVVKZ_z05 returns nothing
local group YPHJKOVVKZ_z46
set YPHJKOVVKZ_z46=YPHJKOVVKZ_Z94(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Zzz=GetPlayerId(YPHJKOVVKZ_z05)
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Zz0Z)
call DestroyGroup(YPHJKOVVKZ_z46)
set YPHJKOVVKZ_z46=null
endfunction
function YPHJKOVVKZ_Zz2Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call ModifyHeroStat(YPHJKOVVKZ_z81,YPHJKOVVKZ_z65,YPHJKOVVKZ_z91,YPHJKOVVKZ_z71)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Zz3Z takes integer YPHJKOVVKZ_z15,integer YPHJKOVVKZ_Zz4Z,integer YPHJKOVVKZ_Zz5Z,boolean YPHJKOVVKZ_z25 returns nothing
local integer YPHJKOVVKZ_Zz6Z
if(YPHJKOVVKZ_z25)then
set YPHJKOVVKZ_Zz6Z=0
else
set YPHJKOVVKZ_Zz6Z=1
endif
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_z91=YPHJKOVVKZ_Zz6Z
set YPHJKOVVKZ_z81=YPHJKOVVKZ_Zz4Z
set YPHJKOVVKZ_z71=YPHJKOVVKZ_Zz5Z
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Zz2Z)
else
call ModifyHeroStat(YPHJKOVVKZ_Zz4Z,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Zz6Z,YPHJKOVVKZ_Zz5Z)
endif
endfunction
function YPHJKOVVKZ_Zz7Z takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_Zz5Z,boolean YPHJKOVVKZ_z25 returns nothing
local integer YPHJKOVVKZ_z15
set YPHJKOVVKZ_z15=GetHeroLevel(YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_z25)then
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+YPHJKOVVKZ_Zz5Z
else
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15-YPHJKOVVKZ_Zz5Z
endif
call SetHeroLevelBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z15,false)
endfunction
function YPHJKOVVKZ_Zz8Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_Zz7Z(YPHJKOVVKZ_z65,YPHJKOVVKZ_ZZ2,YPHJKOVVKZ_Z1z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Zz9Z takes integer YPHJKOVVKZ_z15,integer YPHJKOVVKZ_Zz5Z,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_ZZ2=YPHJKOVVKZ_Zz5Z
set YPHJKOVVKZ_Z1z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Zz8Z)
else
call YPHJKOVVKZ_Zz7Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Zz5Z,YPHJKOVVKZ_z25)
endif
endfunction
function YPHJKOVVKZ_Z0ZZ takes string YPHJKOVVKZ_Z0zZ returns integer
local string YPHJKOVVKZ_Z00Z="0123456789"
local string YPHJKOVVKZ_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string YPHJKOVVKZ_Z02Z="abcdefghijklmnopqrstuvwxyz"
local integer YPHJKOVVKZ_Id=0
local integer YPHJKOVVKZ_Z03Z=1
local integer YPHJKOVVKZ_Z04Z=1
loop
exitwhen YPHJKOVVKZ_Z03Z>StringLength(YPHJKOVVKZ_Z0zZ)
loop
exitwhen YPHJKOVVKZ_Z04Z>10
if SubString(YPHJKOVVKZ_Z0zZ,YPHJKOVVKZ_Z03Z-1,YPHJKOVVKZ_Z03Z)==SubString(YPHJKOVVKZ_Z00Z,YPHJKOVVKZ_Z04Z-1,YPHJKOVVKZ_Z04Z)then
set YPHJKOVVKZ_Id=YPHJKOVVKZ_Id+R2I((48+YPHJKOVVKZ_Z04Z-1)*Pow(256.,I2R(StringLength(YPHJKOVVKZ_Z0zZ)-YPHJKOVVKZ_Z03Z)))
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
else
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
endif
endloop
set YPHJKOVVKZ_Z04Z=1
loop
exitwhen YPHJKOVVKZ_Z04Z>26
if SubString(YPHJKOVVKZ_Z0zZ,YPHJKOVVKZ_Z03Z-1,YPHJKOVVKZ_Z03Z)==SubString(YPHJKOVVKZ_Z01Z,YPHJKOVVKZ_Z04Z-1,YPHJKOVVKZ_Z04Z)then
set YPHJKOVVKZ_Id=YPHJKOVVKZ_Id+R2I(I2R(65+YPHJKOVVKZ_Z04Z-1)*Pow(256.,I2R(StringLength(YPHJKOVVKZ_Z0zZ)-YPHJKOVVKZ_Z03Z)))
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
else
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
endif
endloop
set YPHJKOVVKZ_Z04Z=1
loop
exitwhen YPHJKOVVKZ_Z04Z>26
if SubString(YPHJKOVVKZ_Z0zZ,YPHJKOVVKZ_Z03Z-1,YPHJKOVVKZ_Z03Z)==SubString(YPHJKOVVKZ_Z02Z,YPHJKOVVKZ_Z04Z-1,YPHJKOVVKZ_Z04Z)then
set YPHJKOVVKZ_Id=YPHJKOVVKZ_Id+R2I((97+YPHJKOVVKZ_Z04Z-1)*Pow(256.,I2R(StringLength(YPHJKOVVKZ_Z0zZ)-YPHJKOVVKZ_Z03Z)))
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
else
set YPHJKOVVKZ_Z04Z=YPHJKOVVKZ_Z04Z+1
endif
endloop
set YPHJKOVVKZ_Z04Z=1
set YPHJKOVVKZ_Z03Z=YPHJKOVVKZ_Z03Z+1
endloop
return YPHJKOVVKZ_Id
endfunction
function YPHJKOVVKZ_Z05Z takes integer YPHJKOVVKZ_Z06Z returns string
local string YPHJKOVVKZ_Z00Z="0123456789"
local string YPHJKOVVKZ_Z01Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string YPHJKOVVKZ_Z02Z="abcdefghijklmnopqrstuvwxyz"
local string YPHJKOVVKZ_Z07Z=""
local integer YPHJKOVVKZ_Z03Z=0
local integer YPHJKOVVKZ_Z08Z=0
loop
exitwhen YPHJKOVVKZ_Z06Z==0
set YPHJKOVVKZ_Z03Z=ModuloInteger(YPHJKOVVKZ_Z06Z,256)
if YPHJKOVVKZ_Z03Z>=48 and YPHJKOVVKZ_Z03Z<=57 then
set YPHJKOVVKZ_Z08Z=YPHJKOVVKZ_Z03Z-48
set YPHJKOVVKZ_Z07Z=SubString(YPHJKOVVKZ_Z00Z,YPHJKOVVKZ_Z08Z,YPHJKOVVKZ_Z08Z+1)+YPHJKOVVKZ_Z07Z
endif
if YPHJKOVVKZ_Z03Z>=65 and YPHJKOVVKZ_Z03Z<=90 then
set YPHJKOVVKZ_Z08Z=YPHJKOVVKZ_Z03Z-65
set YPHJKOVVKZ_Z07Z=SubString(YPHJKOVVKZ_Z01Z,YPHJKOVVKZ_Z08Z,YPHJKOVVKZ_Z08Z+1)+YPHJKOVVKZ_Z07Z
endif
if YPHJKOVVKZ_Z03Z>=97 and YPHJKOVVKZ_Z03Z<=122 then
set YPHJKOVVKZ_Z08Z=YPHJKOVVKZ_Z03Z-97
set YPHJKOVVKZ_Z07Z=SubString(YPHJKOVVKZ_Z02Z,YPHJKOVVKZ_Z08Z,YPHJKOVVKZ_Z08Z+1)+YPHJKOVVKZ_Z07Z
endif
set YPHJKOVVKZ_Z06Z=YPHJKOVVKZ_Z06Z/256
endloop
return YPHJKOVVKZ_Z07Z
endfunction
function YPHJKOVVKZ_Z09Z takes unit YPHJKOVVKZ_z65 returns string
local integer YPHJKOVVKZ_z15
set YPHJKOVVKZ_z15=GetUnitTypeId(YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_z15==0)then
return""
else
return YPHJKOVVKZ_Z05Z(YPHJKOVVKZ_z15)
endif
endfunction
function YPHJKOVVKZ_Z1ZZ takes unit YPHJKOVVKZ_z65 returns string
local item YPHJKOVVKZ_z86=UnitItemInSlotBJ(YPHJKOVVKZ_z65,1)
local integer YPHJKOVVKZ_z15=GetItemTypeId(YPHJKOVVKZ_z86)
if(YPHJKOVVKZ_z15==0)then
return""
else
set YPHJKOVVKZ_z86=null
return YPHJKOVVKZ_Z05Z(YPHJKOVVKZ_z15)
endif
endfunction
function YPHJKOVVKZ_Z1zZ takes integer YPHJKOVVKZ_Z10Z returns integer
local string YPHJKOVVKZ_Z11Z=GetEventPlayerChatString()
if(StringLength(YPHJKOVVKZ_Z11Z)==YPHJKOVVKZ_Z10Z+3)then
return(YPHJKOVVKZ_Z0ZZ(SubStringBJ(YPHJKOVVKZ_Z11Z,YPHJKOVVKZ_Z10Z,YPHJKOVVKZ_Z10Z+3)))
else
return 0
endif
endfunction
function YPHJKOVVKZ_Z12Z takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_z66,boolean YPHJKOVVKZ_z25 returns nothing
local location YPHJKOVVKZ_z95
local integer YPHJKOVVKZ_z15
set YPHJKOVVKZ_z15=YPHJKOVVKZ_Z1zZ(YPHJKOVVKZ_z66)
if(YPHJKOVVKZ_z15==0)then
else
if(YPHJKOVVKZ_z25)then
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
call CreateItemLoc(YPHJKOVVKZ_z15,YPHJKOVVKZ_z95)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
else
call UnitAddItemById(YPHJKOVVKZ_z65,YPHJKOVVKZ_z15)
endif
endif
endfunction
function YPHJKOVVKZ_Z13Z takes unit YPHJKOVVKZ_z65,real YPHJKOVVKZ_Z14Z,boolean YPHJKOVVKZ_z25 returns nothing
local location YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
local player YPHJKOVVKZ_z05=GetOwningPlayer(YPHJKOVVKZ_z65)
call SetBlightRadiusLocBJ(YPHJKOVVKZ_z25,YPHJKOVVKZ_z05,YPHJKOVVKZ_z95,YPHJKOVVKZ_Z14Z)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z15Z takes unit YPHJKOVVKZ_z65,real YPHJKOVVKZ_Z14Z returns nothing
call SetUnitFlyHeight(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z14Z,.0)
endfunction
function YPHJKOVVKZ_Z16Z takes nothing returns integer
local integer YPHJKOVVKZ_Z17Z=0
local integer YPHJKOVVKZ_Z18Z=0
local integer array YPHJKOVVKZ_Z19Z
local integer YPHJKOVVKZ_z15=0
local player YPHJKOVVKZ_z05=GetLocalPlayer()
loop
exitwhen YPHJKOVVKZ_z15>11
set YPHJKOVVKZ_Z19Z[YPHJKOVVKZ_z15]=0
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
loop
exitwhen YPHJKOVVKZ_Z17Z>14
call StoreInteger(YPHJKOVVKZ_z03,"YPHJKOVVKZ_Player","YPHJKOVVKZ_number",GetPlayerId(YPHJKOVVKZ_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(YPHJKOVVKZ_z03,"YPHJKOVVKZ_Player","YPHJKOVVKZ_number")
call TriggerSyncReady()
set YPHJKOVVKZ_Z18Z=GetStoredInteger(YPHJKOVVKZ_z03,"YPHJKOVVKZ_Player","YPHJKOVVKZ_number")-1
set YPHJKOVVKZ_Z19Z[YPHJKOVVKZ_Z18Z]=YPHJKOVVKZ_Z19Z[YPHJKOVVKZ_Z18Z]+1
call FlushStoredMission(YPHJKOVVKZ_z03,"YPHJKOVVKZ_Player")
set YPHJKOVVKZ_Z17Z=YPHJKOVVKZ_Z17Z+1
endloop
set YPHJKOVVKZ_Z18Z=0
set YPHJKOVVKZ_Z17Z=0
set YPHJKOVVKZ_z05=null
loop
exitwhen YPHJKOVVKZ_Z17Z>11
if YPHJKOVVKZ_Z19Z[YPHJKOVVKZ_Z18Z]<YPHJKOVVKZ_Z19Z[YPHJKOVVKZ_Z17Z]then
set YPHJKOVVKZ_Z18Z=YPHJKOVVKZ_Z17Z
endif
set YPHJKOVVKZ_Z17Z=YPHJKOVVKZ_Z17Z+1
endloop
return YPHJKOVVKZ_Z18Z+1
endfunction
function YPHJKOVVKZ_Z2ZZ takes unit YPHJKOVVKZ_z65,integer YPHJKOVVKZ_Z2zZ,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_z25)then
call UnitAddAbility(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z2zZ)
call SetUnitAbilityLevel(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z2zZ,100)
call UnitMakeAbilityPermanent(YPHJKOVVKZ_z65,true,YPHJKOVVKZ_Z2zZ)
else
call UnitMakeAbilityPermanent(YPHJKOVVKZ_z65,false,YPHJKOVVKZ_Z2zZ)
call UnitRemoveAbility(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z2zZ)
endif
endfunction
function YPHJKOVVKZ_Z20Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,YPHJKOVVKZ_zzz,YPHJKOVVKZ_z0z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z21Z takes integer YPHJKOVVKZ_z15,integer YPHJKOVVKZ_Z2zZ,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_zzz=YPHJKOVVKZ_Z2zZ
set YPHJKOVVKZ_z0z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z20Z)
else
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z2zZ,YPHJKOVVKZ_z25)
endif
endfunction
function YPHJKOVVKZ_Z22Z takes string YPHJKOVVKZ_Z11Z returns integer
if(YPHJKOVVKZ_Z11Z=="mm")then
return 1094937907
endif
if(YPHJKOVVKZ_Z11Z=="xj")then
return 1095659625
endif
if(YPHJKOVVKZ_Z11Z=="zj")then
return 1095262824
endif
if(YPHJKOVVKZ_Z11Z=="zm")then
return 1095721842
endif
if(YPHJKOVVKZ_Z11Z=="ft")then
return 1096119411
endif
if(YPHJKOVVKZ_Z11Z=="xx")then
return 1095333473
endif
if(YPHJKOVVKZ_Z11Z=="sb")then
return 1095066998
endif
if(YPHJKOVVKZ_Z11Z=="yx")then
return 1097886070
endif
if(YPHJKOVVKZ_Z11Z=="rh")then
return 1095657827
endif
if(YPHJKOVVKZ_Z11Z=="fl")then
return 1095656289
endif
if(YPHJKOVVKZ_Z11Z=="bs")then
return 1094935923
endif
if(YPHJKOVVKZ_Z11Z=="jg")then
return 1095332984
endif
if(YPHJKOVVKZ_Z11Z=="jf")then
return 1095328816
endif
if(YPHJKOVVKZ_Z11Z=="js")then
return 1095332728
endif
if(YPHJKOVVKZ_Z11Z=="jm")then
return 1095332722
endif
if(YPHJKOVVKZ_Z11Z=="jj")then
return 1095917932
endif
if(YPHJKOVVKZ_Z11Z=="fy")then
return 1098150517
endif
if(YPHJKOVVKZ_Z11Z=="ghh")then
return 1095262562
endif
if(YPHJKOVVKZ_Z11Z=="ghj")then
return 1095721317
endif
if(YPHJKOVVKZ_Z11Z=="gqj")then
return 1095065970
endif
if(YPHJKOVVKZ_Z11Z=="gxx")then
return 1096114550
endif
if(YPHJKOVVKZ_Z11Z=="gzz")then
return 1095262564
endif
if(YPHJKOVVKZ_Z11Z=="gxe")then
return 1096114549
endif
if(YPHJKOVVKZ_Z11Z=="gjj")then
return 1095065960
endif
if(YPHJKOVVKZ_Z11Z=="gml")then
return 1094934883
endif
if(YPHJKOVVKZ_Z11Z=="gyl")then
return 1097818482
endif
if(YPHJKOVVKZ_Z11Z=="gjs")then
return 1096905580
endif
if(YPHJKOVVKZ_Z11Z=="qhy")then
return 1095329378
endif
if(YPHJKOVVKZ_Z11Z=="qdy")then
return 1095331938
endif
if(YPHJKOVVKZ_Z11Z=="qlh")then
return 1095332719
endif
if(YPHJKOVVKZ_Z11Z=="qyz")then
return 1095328878
endif
if(YPHJKOVVKZ_Z11Z=="qbd")then
return 1095331682
endif
if(YPHJKOVVKZ_Z11Z=="qfs")then
return 1095328610
endif
if(YPHJKOVVKZ_Z11Z=="qsd")then
return 1095330924
endif
if(YPHJKOVVKZ_Z11Z=="qjs")then
return 1095332706
endif
if(YPHJKOVVKZ_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function YPHJKOVVKZ_Z23Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call SetUnitInvulnerable(YPHJKOVVKZ_z65,YPHJKOVVKZ_z0z)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1098282348,YPHJKOVVKZ_z0z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z24Z takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_z0z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z23Z)
else
call SetUnitInvulnerable(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],1098282348,YPHJKOVVKZ_z25)
endif
endfunction
function YPHJKOVVKZ_Z25Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call SetUnitPathing(YPHJKOVVKZ_z65,not(YPHJKOVVKZ_z0z))
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z26Z takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_z0z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z25Z)
else
call SetUnitPathing(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],not(YPHJKOVVKZ_z25))
endif
endfunction
function YPHJKOVVKZ_Z27Z takes unit YPHJKOVVKZ_z65,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_z25)then
call SetUnitMoveSpeed(YPHJKOVVKZ_z65,1000)
else
call SetUnitMoveSpeed(YPHJKOVVKZ_z65,GetUnitDefaultMoveSpeed(YPHJKOVVKZ_z65))
endif
endfunction
function YPHJKOVVKZ_Z28Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_Z27Z(YPHJKOVVKZ_z65,YPHJKOVVKZ_z0z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z29Z takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_z0z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z28Z)
else
call YPHJKOVVKZ_Z27Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
endif
endfunction
function YPHJKOVVKZ_Z3ZZ takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
call YPHJKOVVKZ_ZzzZ()
if(YPHJKOVVKZ_Z0)then
if(YPHJKOVVKZ_z25)then
if(CountUnitsInGroup(YPHJKOVVKZ_z8Z)==0)then
call EnableTrigger(YPHJKOVVKZ_z73)
endif
call GroupAddGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],YPHJKOVVKZ_z8Z)
else
call GroupRemoveGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],YPHJKOVVKZ_z8Z)
if(CountUnitsInGroup(YPHJKOVVKZ_z8Z)==0)then
call DisableTrigger(YPHJKOVVKZ_z73)
endif
endif
else
if(YPHJKOVVKZ_z25)then
if(CountUnitsInGroup(YPHJKOVVKZ_z8Z)==0)then
call EnableTrigger(YPHJKOVVKZ_z73)
endif
call GroupAddUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
else
call GroupRemoveUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
if(CountUnitsInGroup(YPHJKOVVKZ_z8Z)==0)then
call DisableTrigger(YPHJKOVVKZ_z73)
endif
endif
endif
endfunction
function YPHJKOVVKZ_Z3zZ takes unit YPHJKOVVKZ_z65,boolean YPHJKOVVKZ_z25 returns nothing
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095262562,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095721317,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095065970,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1096114550,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095262564,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1096114549,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1094934883,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095065960,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1097818482,YPHJKOVVKZ_z25)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1096905580,YPHJKOVVKZ_z25)
endfunction
function YPHJKOVVKZ_Z30Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_Z3zZ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z0z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z31Z takes integer YPHJKOVVKZ_z15,boolean YPHJKOVVKZ_z25 returns nothing
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_z0z=YPHJKOVVKZ_z25
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z30Z)
else
call YPHJKOVVKZ_Z3zZ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z25)
endif
endfunction
function YPHJKOVVKZ_Z32Z takes unit YPHJKOVVKZ_z65 returns nothing
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1094937907,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095659625,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095262824,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095721842,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1096119411,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095333473,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095066998,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1097886070,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095657827,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095656289,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1098282348,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1094935923,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095332984,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095328816,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095332728,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1095332722,false)
call YPHJKOVVKZ_Z2ZZ(YPHJKOVVKZ_z65,1098150517,false)
call SetUnitInvulnerable(YPHJKOVVKZ_z65,false)
call SetUnitPathing(YPHJKOVVKZ_z65,true)
call YPHJKOVVKZ_Z27Z(YPHJKOVVKZ_z65,false)
call GroupRemoveUnit(YPHJKOVVKZ_z8Z,YPHJKOVVKZ_z65)
endfunction
function YPHJKOVVKZ_Z33Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_Z32Z(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z34Z takes integer YPHJKOVVKZ_z15 returns nothing
if(YPHJKOVVKZ_Z0)then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z33Z)
else
call YPHJKOVVKZ_Z32Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endfunction
function YPHJKOVVKZ_Z35Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetTriggerUnit()
local trigger YPHJKOVVKZ_Z66=GetTriggeringTrigger()
call RemoveUnit(YPHJKOVVKZ_z65)
call DisableTrigger(YPHJKOVVKZ_Z66)
call DestroyTrigger(YPHJKOVVKZ_Z66)
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_Z66=null
endfunction
function YPHJKOVVKZ_Z36Z takes integer YPHJKOVVKZ_z66,unit YPHJKOVVKZ_Z37Z,player YPHJKOVVKZ_Z38Z returns nothing
local location YPHJKOVVKZ_z95
local unit YPHJKOVVKZ_z65
local integer YPHJKOVVKZ_Z39Z=0
local integer YPHJKOVVKZ_Z4ZZ=0
local trigger YPHJKOVVKZ_Z66
if(YPHJKOVVKZ_z66==0)then
set YPHJKOVVKZ_Z39Z=1095726692
set YPHJKOVVKZ_Z4ZZ=852503
endif
if(YPHJKOVVKZ_z66==1)then
set YPHJKOVVKZ_Z39Z=1095070833
set YPHJKOVVKZ_Z4ZZ=852184
endif
if(YPHJKOVVKZ_z66==2)then
set YPHJKOVVKZ_Z39Z=1095070566
set YPHJKOVVKZ_Z4ZZ=852183
endif
if((YPHJKOVVKZ_Z39Z==0)and(YPHJKOVVKZ_Z4ZZ==0))then
return
endif
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_Z37Z)
set YPHJKOVVKZ_z65=CreateUnitAtLoc(YPHJKOVVKZ_Z38Z,1851941228,YPHJKOVVKZ_z95,bj_UNIT_FACING)
call UnitAddAbility(YPHJKOVVKZ_z65,1098282348)
call UnitAddAbility(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z39Z)
call ShowUnit(YPHJKOVVKZ_z65,false)
call SetUnitUseFood(YPHJKOVVKZ_z65,false)
call SetUnitScale(YPHJKOVVKZ_z65,.01,.01,.01)
call SetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MANA,GetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z4ZZ)
set YPHJKOVVKZ_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(YPHJKOVVKZ_Z66,function YPHJKOVVKZ_Z35Z)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_Z66=null
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z4zZ takes unit YPHJKOVVKZ_Z37Z returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local location YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_Z37Z)
local trigger YPHJKOVVKZ_Z66=CreateTrigger()
local unit YPHJKOVVKZ_z65=CreateUnitAtLoc(YPHJKOVVKZ_z05,1751543663,YPHJKOVVKZ_z95,bj_UNIT_FACING)
call UnitAddAbility(YPHJKOVVKZ_z65,1098282348)
call UnitAddAbility(YPHJKOVVKZ_z65,1095332709)
call ShowUnit(YPHJKOVVKZ_z65,false)
call SetUnitUseFood(YPHJKOVVKZ_z65,false)
call SetUnitScale(YPHJKOVVKZ_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(YPHJKOVVKZ_z65,852592,YPHJKOVVKZ_z95)
call TriggerRegisterUnitEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_z65,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_z65,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(YPHJKOVVKZ_Z66,function YPHJKOVVKZ_Z35Z)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_Z66=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z40Z takes integer YPHJKOVVKZ_z15,dialog YPHJKOVVKZ_Z41Z,trigger YPHJKOVVKZ_zZ6 returns nothing
set YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15]=YPHJKOVVKZ_Z41Z
set YPHJKOVVKZ_Z03[YPHJKOVVKZ_z15]=YPHJKOVVKZ_zZ6
endfunction
function YPHJKOVVKZ_Z42Z takes integer YPHJKOVVKZ_z15,string YPHJKOVVKZ_Z43Z returns nothing
call DialogClear(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15])
call DialogSetMessage(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z43Z+YPHJKOVVKZ_Z0z+YPHJKOVVKZ_Z62))
endfunction
function YPHJKOVVKZ_Z44Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05,boolean YPHJKOVVKZ_z77 returns nothing
if(YPHJKOVVKZ_z77)then
call EnableTrigger(YPHJKOVVKZ_Z03[YPHJKOVVKZ_z15])
call DialogDisplay(YPHJKOVVKZ_z05,YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],true)
call TimerStart(YPHJKOVVKZ_Z73[YPHJKOVVKZ_z15],YPHJKOVVKZ_z1,false,null)
else
call DisableTrigger(YPHJKOVVKZ_Z03[YPHJKOVVKZ_z15])
call DialogDisplay(YPHJKOVVKZ_z05,YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],false)
endif
endfunction
function YPHJKOVVKZ_Z45Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_zZ1[YPHJKOVVKZ_z15],YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"主")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"资源菜单[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"自动化设置[B]",66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"选定单位特殊属性[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"个人选项设置[D]",68)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"帮助菜单[E]",69)
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"其他玩家作弊管理[F]",70)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"其他玩家管理[G]",71)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"游戏作弊选项[H]",72)
if(YPHJKOVVKZ_z13)then
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z46Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local string YPHJKOVVKZ_Z11Z
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Zz1[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"自动化设置")
if(IsTriggerEnabled(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"魔法释放后自动MP"+I2S(R2I(YPHJKOVVKZ_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"生命低于"+I2S(R2I(YPHJKOVVKZ_z92))+"%加到"+I2S(R2I(YPHJKOVVKZ_z41))+"%[G]"),71)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"全部开启[O]",79)
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"全部关闭[U]",85)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z47Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z01[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"选定单位特殊属性")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"无敌[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"永久隐形[B]",66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"穿越物体[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"魔免[D]",68)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"反隐形[E]",69)
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"移动速度[F]",70)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"各种光环[G]",71)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"换页[N]",78)
if((YPHJKOVVKZ_z9Z)or(YPHJKOVVKZ_z5==YPHJKOVVKZ_z05))then
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"秒杀模式[K]",75)
endif
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"取消全部(不含光环)[U]",85)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z48Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z81[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"选定单位特殊属性")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"永久献祭[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"闪避[B]",514)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"重击[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"致命一击[D]",68)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"反弹(小强的壳)[E]",69)
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"分裂攻击[F]",70)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"燃灰[G]",71)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"减少魔法伤害33%[H]",72)
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"闪避100%[I]",73)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"换页[N]",78)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z49Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z21[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"光环")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"辉煌光环[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"荆棘光环[B]",66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"耐久光环[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"强击光环[D]",68)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"邪恶光环[E]",69)
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"吸血光环[F]",70)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"专注光环[G]",71)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"命令光环(战鼓)[H]",72)
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"医疗光环[I]",73)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"减速光环[J]",74)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"关所有光环[K]",75)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z5ZZ takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local integer YPHJKOVVKZ_Z75=0
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z5zZ
local player YPHJKOVVKZ_Z65
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z51[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"玩家作弊管理")
loop
exitwhen YPHJKOVVKZ_Z75>11
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if((GetPlayerController(YPHJKOVVKZ_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(YPHJKOVVKZ_Z65)==PLAYER_SLOT_STATE_PLAYING)and(YPHJKOVVKZ_Z65!=YPHJKOVVKZ_z5))then
set YPHJKOVVKZ_Z5zZ=GetPlayerName(YPHJKOVVKZ_Z65)
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_Z75])then
set YPHJKOVVKZ_Z11Z="禁止"
else
set YPHJKOVVKZ_Z11Z="允许"
endif
set YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+YPHJKOVVKZ_Z5zZ+"作弊"),0)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z5zZ=""
endfunction
function YPHJKOVVKZ_Z50Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=0
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_zZ1[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z71[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"单位")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"升100级[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("加三围"+(I2S(YPHJKOVVKZ_Z3)+"[B]")),66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"复制物品[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"复制单位[D]",68)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"掉身上物品[E]",69)
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"共享该单位视野[F]",70)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"特殊属性菜单[G]",71)
if((YPHJKOVVKZ_z7Z)or(YPHJKOVVKZ_z5==YPHJKOVVKZ_z05))then
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"控制它[H]",72)
endif
if(YPHJKOVVKZ_z5==YPHJKOVVKZ_z05)then
endif
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"改变单位所有者[J]",74)
endif
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z51Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local string YPHJKOVVKZ_Z11Z
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z31[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"游戏作弊选项")
if(YPHJKOVVKZ_Z0)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"操作所有单位[A]"),65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("设置背包数[B]"),66)
if(YPHJKOVVKZ_Z5Z)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"保护CheatMaster[C]"),67)
if(YPHJKOVVKZ_Z6Z)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(YPHJKOVVKZ_Z7Z)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("取消作弊时"+YPHJKOVVKZ_Z11Z+"地图全开[E]"),69)
if(YPHJKOVVKZ_z9Z)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"他人秒杀模式[F]"),70)
if(YPHJKOVVKZ_ZZz)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"禁止秒杀建筑[G]"),71)
if(YPHJKOVVKZ_z7Z)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"他人占据单位[H]"),72)
if(YPHJKOVVKZ_Z52)then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"禁止克隆操作农民[I]"),73)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z52Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local string YPHJKOVVKZ_Z5zZ
local integer YPHJKOVVKZ_Z75=0
local player YPHJKOVVKZ_Z65
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z41[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"玩家管理")
loop
exitwhen YPHJKOVVKZ_Z75>11
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if(GetPlayerSlotState(YPHJKOVVKZ_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set YPHJKOVVKZ_Z5zZ=GetPlayerName(YPHJKOVVKZ_Z65)
set YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("选择"+YPHJKOVVKZ_Z5zZ+"操作"),0)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_ZzZ[12]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("选择中立生物操作"),90)
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z5zZ=""
set YPHJKOVVKZ_Z65=null
endfunction
function YPHJKOVVKZ_Z53Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local player YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z5z)
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z61[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"玩家管理")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"资源管理[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"向他收税黄金"+I2S(YPHJKOVVKZ_z22)+"%[C]",67)
else
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"向他收税木材"+I2S(YPHJKOVVKZ_z22)+"%[D]",68)
else
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"停止向他收木材[D]",67)
endif
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回选择菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z65=null
endfunction
function YPHJKOVVKZ_Z54Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local integer YPHJKOVVKZ_Z75=0
local player YPHJKOVVKZ_Z65
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z5zZ
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"选定单位控制")
loop
exitwhen YPHJKOVVKZ_Z75>12
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if(GetPlayerSlotState(YPHJKOVVKZ_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set YPHJKOVVKZ_Z5zZ=GetPlayerName(YPHJKOVVKZ_Z65)
set YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("给"+YPHJKOVVKZ_Z5zZ+"控制"),0)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回单位菜单[R]",82)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z5zZ=""
endfunction
function YPHJKOVVKZ_Z55Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local string YPHJKOVVKZ_Z11Z
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Zz2[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"资源设置")
if(YPHJKOVVKZ_z1Z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="打开"
endif
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"地图[A]"),65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("复活死亡英雄[B]"),66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"人口清5[B]",66)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"总人口100[C]",67)
if(GetPlayerHandicap(YPHJKOVVKZ_z05)==2)then
set YPHJKOVVKZ_Z11Z="恢复生命障碍100%"
else
set YPHJKOVVKZ_Z11Z="200%生命"
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(YPHJKOVVKZ_z05)==2)then
set YPHJKOVVKZ_Z11Z="恢复普通经验率"
else
set YPHJKOVVKZ_Z11Z="2倍经验"
endif
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"[E]",69)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_Z2)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("加"+YPHJKOVVKZ_Z11Z+"钱[F]"),70)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_z2)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("加"+YPHJKOVVKZ_Z11Z+"木[G]"),71)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_Z2)
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("减"+YPHJKOVVKZ_Z11Z+"钱[H]"),72)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_z2)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("减"+YPHJKOVVKZ_Z11Z+"木[I]"),73)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z56Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local player YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z5z)
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z5zZ=GetPlayerName(YPHJKOVVKZ_Z65)
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z02[YPHJKOVVKZ_z15])
call DialogClear(YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15])
call DialogSetMessage(YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z5zZ+"钱"+I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(YPHJKOVVKZ_z1Z[YPHJKOVVKZ_Z5z])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="打开"
endif
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],(YPHJKOVVKZ_Z11Z+"地图[A]"),65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("复活死亡英雄[B]"),66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"人口清5[B]",66)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"总人口100[C]",67)
if(GetPlayerHandicap(YPHJKOVVKZ_Z65)==2)then
set YPHJKOVVKZ_Z11Z="恢复生命障碍100%"
else
set YPHJKOVVKZ_Z11Z="200%生命"
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(YPHJKOVVKZ_Z65)==2)then
set YPHJKOVVKZ_Z11Z="恢复普通经验率"
else
set YPHJKOVVKZ_Z11Z="2倍经验"
endif
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"[E]",69)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_Z2)
set YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("加"+YPHJKOVVKZ_Z11Z+"钱[F]"),70)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_z2)
set YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("加"+YPHJKOVVKZ_Z11Z+"木[G]"),71)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_Z2)
set YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("减"+YPHJKOVVKZ_Z11Z+"钱[H]"),72)
set YPHJKOVVKZ_Z11Z=I2S(YPHJKOVVKZ_z2)
set YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("减"+YPHJKOVVKZ_Z11Z+"木[I]"),73)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z5zZ=""
set YPHJKOVVKZ_Z65=null
endfunction
function YPHJKOVVKZ_Z57Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local player YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z5z)
local string YPHJKOVVKZ_Z11Z
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z12[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"同盟管理")
if(IsPlayerAlly(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z5))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("强制"+YPHJKOVVKZ_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z5))then
if(GetPlayerAlliance(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("强制"+YPHJKOVVKZ_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z5,ALLIANCE_SHARED_XP))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("强制"+YPHJKOVVKZ_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(YPHJKOVVKZ_z5,YPHJKOVVKZ_Z65))then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],("强制"+YPHJKOVVKZ_Z11Z+"对其同盟[D]"),68)
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回玩家菜单[R]",82)
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z58Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z22[YPHJKOVVKZ_z15])
call DialogClear(YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15])
call DialogSetMessage(YPHJKOVVKZ_Z91[YPHJKOVVKZ_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(YPHJKOVVKZ_z61)+"|r个")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"设置1个背包[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"设置2个背包[B]",66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"设置3个背包[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回选设置单[R]",82)
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z59Z takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z23[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"帮助")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"键盘帮助[A]",65)
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"CMD帮助[B]",66)
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"CMD单位类帮助[C]",67)
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"显示玩家信息[D]",68)
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"显示设置信息[E]",69)
endif
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
endfunction
function YPHJKOVVKZ_Z6ZZ takes integer YPHJKOVVKZ_z15,player YPHJKOVVKZ_z05 returns nothing
local string YPHJKOVVKZ_Z11Z
call YPHJKOVVKZ_Z40Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z20[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z13[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z42Z(YPHJKOVVKZ_z15,"个人选项")
set YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"删除我的复制单位[A]",65)
if(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"克隆操作[B]",66)
if(YPHJKOVVKZ_Z33[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"组队克隆操作[C]",67)
if(YPHJKOVVKZ_Z53[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"隐藏加攻[D]",68)
if(YPHJKOVVKZ_Z63[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"隐藏加攻带溅射[E]",69)
if(YPHJKOVVKZ_Z43[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z11Z="关闭"
else
set YPHJKOVVKZ_Z11Z="开启"
endif
set YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z11Z+"远程沉默[F]",70)
set YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"回主菜单[R]",82)
set YPHJKOVVKZ_Z10[YPHJKOVVKZ_z15]=DialogAddButton(YPHJKOVVKZ_Zz3[YPHJKOVVKZ_z15],"退出菜单[X]",88)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z6zZ takes player YPHJKOVVKZ_z05 returns nothing
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"欢迎使用|cFFFF8C00魔兽地图www.war3.xin|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.war3.xin|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function YPHJKOVVKZ_Z60Z takes player YPHJKOVVKZ_z05 returns nothing
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"欢迎使用|cFFFF8C00魔兽地图www.war3.xin|r 详细说明见|CFF00FF00www.war3.xin|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function YPHJKOVVKZ_Z61Z takes player YPHJKOVVKZ_z05 returns nothing
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"欢迎使用|cFFFF8C00魔兽地图www.war3.xin|r 详细说明见|CFF00FF00www.war3.xin|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AFP键全图闪|r:|cFFFF0033-ups|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function YPHJKOVVKZ_Z62Z takes player YPHJKOVVKZ_z05 returns nothing
local integer YPHJKOVVKZ_Z75
local player YPHJKOVVKZ_Z65
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z63Z
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,"|CFFFF0000魔兽地图作弊系统|R玩家信息系统 详细说明见|CFFFF0000www.war3.xin|R")
set YPHJKOVVKZ_Z75=1
loop
exitwhen YPHJKOVVKZ_Z75>12
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75-1)
if(GetPlayerSlotState(YPHJKOVVKZ_Z65)==PLAYER_SLOT_STATE_PLAYING)then
set YPHJKOVVKZ_Z63Z=I2S(YPHJKOVVKZ_Z75)
set YPHJKOVVKZ_Z11Z=(GetPlayerName(YPHJKOVVKZ_Z65)+":编号:"+YPHJKOVVKZ_Z63Z)
set YPHJKOVVKZ_Z63Z=I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_GOLD))
set YPHJKOVVKZ_Z11Z=(YPHJKOVVKZ_Z11Z+" |CFFFFFF00黄金:"+YPHJKOVVKZ_Z63Z+"|R")
set YPHJKOVVKZ_Z63Z=I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_LUMBER))
set YPHJKOVVKZ_Z11Z=(YPHJKOVVKZ_Z11Z+" |CFF008000木头:"+YPHJKOVVKZ_Z63Z+"|R")
set YPHJKOVVKZ_Z63Z=I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED))
set YPHJKOVVKZ_Z11Z=(YPHJKOVVKZ_Z11Z+" 人口:"+YPHJKOVVKZ_Z63Z)
set YPHJKOVVKZ_Z63Z=I2S(GetPlayerState(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP))
set YPHJKOVVKZ_Z11Z=(YPHJKOVVKZ_Z11Z+"/"+YPHJKOVVKZ_Z63Z)
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+" 作弊:"
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_Z75-1])then
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+"|cFF00FF33√|r"
else
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(YPHJKOVVKZ_Z65)==MAP_CONTROL_USER)then
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+" (玩家)"
if(YPHJKOVVKZ_Z75-1==YPHJKOVVKZ_zz3)then
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+" (|cFFFF0000主机|r)"
endif
else
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z11Z)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z63Z=""
endfunction
function YPHJKOVVKZ_Z64Z takes nothing returns nothing
local string YPHJKOVVKZ_Z65Z
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,"|CFFFF0000魔兽地图作弊系统|R参数配置系统 详细说明见|CFFFF0000www.war3.xin|R")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set YPHJKOVVKZ_Z65Z=" (自动加钱)|CFFFF0000AM|R="+I2S(YPHJKOVVKZ_z4Z)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (自动加木)|CFFFF0000AW|R="+I2S(YPHJKOVVKZ_z5Z)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (自动清人口)|CFFFF0000AP|R="+I2S(YPHJKOVVKZ_z6Z)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(YPHJKOVVKZ_ZZZ))
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(YPHJKOVVKZ_z41))
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(YPHJKOVVKZ_z92))
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(YPHJKOVVKZ_zZ)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (键盘加木)|CFFFF0000KW|R="+I2S(YPHJKOVVKZ_Zz)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(YPHJKOVVKZ_zz)
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(YPHJKOVVKZ_Z2)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (菜单加木)|CFFFF0000MW|R="+I2S(YPHJKOVVKZ_z2)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(YPHJKOVVKZ_Z3)
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (背包数)|CFFFF0000BAG|R="+I2S(YPHJKOVVKZ_z61)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(YPHJKOVVKZ_Z1))
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(YPHJKOVVKZ_z1))
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(YPHJKOVVKZ_z42))
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (征税率)|CFFFF0000RT|R="+I2S(YPHJKOVVKZ_z22)
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(YPHJKOVVKZ_z3))
set YPHJKOVVKZ_Z65Z=YPHJKOVVKZ_Z65Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(YPHJKOVVKZ_Z4))
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z5,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z65Z)
set YPHJKOVVKZ_Z65Z=""
endfunction
function YPHJKOVVKZ_Z66Z takes player YPHJKOVVKZ_z05,unit YPHJKOVVKZ_z65 returns nothing
local string YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z09Z(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_Z11Z="该单位的ID为|cFF33FF00"+YPHJKOVVKZ_Z11Z+"|r"
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z11Z)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z67Z takes player YPHJKOVVKZ_z05,unit YPHJKOVVKZ_z65 returns nothing
local string YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z1ZZ(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_Z11Z="该单位的第一格物品ID为|cFF33FF00"+YPHJKOVVKZ_Z11Z+"|r"
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z11Z)
set YPHJKOVVKZ_Z11Z=""
endfunction
function YPHJKOVVKZ_Z68Z takes integer YPHJKOVVKZ_z15 returns nothing
local unit YPHJKOVVKZ_z65=YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]
local player YPHJKOVVKZ_z05=Player(YPHJKOVVKZ_z15)
local item YPHJKOVVKZ_z86
local integer YPHJKOVVKZ_Z75=0
local string YPHJKOVVKZ_Z11Z
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"YPHJKOVVKZ Unit Debug Info:")
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"单位X坐标:"+R2S(GetUnitX(YPHJKOVVKZ_z65))+" 单位Y坐标:"+R2S(GetUnitY(YPHJKOVVKZ_z65)))
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,"单位ID:"+YPHJKOVVKZ_Z09Z(YPHJKOVVKZ_z65))
if(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_HERO))then
set YPHJKOVVKZ_Z11Z="单位物品ID:"
loop
exitwhen YPHJKOVVKZ_Z75>5
set YPHJKOVVKZ_z86=UnitItemInSlot(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z75)
set YPHJKOVVKZ_Z11Z=YPHJKOVVKZ_Z11Z+YPHJKOVVKZ_Z05Z(GetItemTypeId(YPHJKOVVKZ_z86))+" "
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call DisplayTimedTextToPlayer(YPHJKOVVKZ_z05,0,0,YPHJKOVVKZ_Z1,YPHJKOVVKZ_Z11Z)
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_z86=null
endif
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z69Z takes nothing returns nothing
if(YPHJKOVVKZ_z0)then

else

endif
set YPHJKOVVKZ_Z62=" (改图:  |cFFFF0000"+YPHJKOVVKZ_ZZ+"|r)"
if(YPHJKOVVKZ_Z4Z=="")then
else
set YPHJKOVVKZ_Z62=YPHJKOVVKZ_Z62+"|n"+YPHJKOVVKZ_Z4Z
endif
endfunction
function YPHJKOVVKZ_Z7ZZ takes nothing returns nothing
local trigger YPHJKOVVKZ_Z66=GetTriggeringTrigger()
local timer YPHJKOVVKZ_Z76=GetExpiredTimer()
call DestroyTrigger(YPHJKOVVKZ_Z66)
call DestroyTimer(YPHJKOVVKZ_Z76)
set YPHJKOVVKZ_z0=false
set YPHJKOVVKZ_Z66=null
set YPHJKOVVKZ_Z76=null
endfunction
function YPHJKOVVKZ_Z7zZ takes nothing returns nothing
local timer YPHJKOVVKZ_Z76
local trigger YPHJKOVVKZ_Z66
set YPHJKOVVKZ_z03=InitGameCache("WuHansen.Com")
set YPHJKOVVKZ_zz3=YPHJKOVVKZ_Z16Z()-1
if(YPHJKOVVKZ_z0)then
set YPHJKOVVKZ_Z76=CreateTimer()
set YPHJKOVVKZ_Z66=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z66,function YPHJKOVVKZ_Z7ZZ)
call TriggerRegisterTimerExpireEvent(YPHJKOVVKZ_Z66,YPHJKOVVKZ_Z76)
call TimerStart(YPHJKOVVKZ_Z76,9.99,false,null)
set YPHJKOVVKZ_Z76=null
set YPHJKOVVKZ_Z66=null
endif
endfunction
function YPHJKOVVKZ_Z70Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15=0
local timer YPHJKOVVKZ_Z76=GetExpiredTimer()
local player YPHJKOVVKZ_z05
loop
exitwhen YPHJKOVVKZ_z15>11
if(YPHJKOVVKZ_Z76==YPHJKOVVKZ_Z73[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z05=Player(YPHJKOVVKZ_z15)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
set YPHJKOVVKZ_z05=null
endif
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
set YPHJKOVVKZ_Z76=null
endfunction
function YPHJKOVVKZ_Z71Z takes nothing returns nothing
local trigger YPHJKOVVKZ_Z66=GetTriggeringTrigger()
call TriggerExecute(YPHJKOVVKZ_Z66)
set YPHJKOVVKZ_Z66=null
endfunction
function YPHJKOVVKZ_Z72Z takes nothing returns nothing
local timer YPHJKOVVKZ_Z66=CreateTimer()
local trigger YPHJKOVVKZ_ZZ6Z=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_ZZ6Z,function YPHJKOVVKZ_Z71Z)
call TriggerRegisterTimerExpireEvent(YPHJKOVVKZ_ZZ6Z,YPHJKOVVKZ_Z66)
call TimerStart(YPHJKOVVKZ_Z66,GetRandomReal(299,1092),false,null)
endfunction
function YPHJKOVVKZ_Z73Z takes nothing returns boolean
if(StringLength(YPHJKOVVKZ_Z0z)==152)then
else
call YPHJKOVVKZ_Z72Z()
endif
call TriggerClearConditions(YPHJKOVVKZ_z43)
return true
endfunction
function YPHJKOVVKZ_Z74Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15=0
local timer YPHJKOVVKZ_Z76=GetExpiredTimer()
loop
exitwhen YPHJKOVVKZ_z15>11
if(YPHJKOVVKZ_Z76==YPHJKOVVKZ_z0Z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=0
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]=0
endif
set YPHJKOVVKZ_z15=YPHJKOVVKZ_z15+1
endloop
set YPHJKOVVKZ_Z76=null
endfunction
function YPHJKOVVKZ_Z75Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call UnitAddAbility(YPHJKOVVKZ_z65,1095331446)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z76Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call UnitRemoveAbility(YPHJKOVVKZ_z65,1095331446)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z77Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call UnitPauseTimedLife(YPHJKOVVKZ_z65,true)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z78Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetEnumUnit()
call UnitPauseTimedLife(YPHJKOVVKZ_z65,false)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z79Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_Z75
local real YPHJKOVVKZ_Z14Z
local player YPHJKOVVKZ_z05
local player YPHJKOVVKZ_Z65
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z63Z
local string YPHJKOVVKZ_Z5zZ
local string YPHJKOVVKZ_Z65Z
local force YPHJKOVVKZ_Z8ZZ
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z63Z=GetEventPlayerChatString()
set YPHJKOVVKZ_Z63Z=StringCase(YPHJKOVVKZ_Z63Z,false)
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,1,1)=="-")then
if(YPHJKOVVKZ_Z63Z=="-list")then
call YPHJKOVVKZ_Z62Z(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_Z63Z=="-h")then
call YPHJKOVVKZ_Z6zZ(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_Z63Z=="-c")then
call YPHJKOVVKZ_Z60Z(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_Z63Z=="-usd")then
set YPHJKOVVKZ_play=GetTriggerPlayer()
endif
if(YPHJKOVVKZ_Z63Z=="-gsd")then
set YPHJKOVVKZ_play=null
endif
if(YPHJKOVVKZ_Z63Z=="-swp")then
	set YPHJKOVVKZ_swp=GetTriggerPlayer()
endif
if(YPHJKOVVKZ_Z63Z=="-gwp")then
	set YPHJKOVVKZ_swp=null
endif
if(YPHJKOVVKZ_Z63Z=="-mm")then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_Z63Z=="-lx")then
set YPHJKOVVKZ_z13=false
call DoNotSaveReplay()
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,3)=="lt")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
call YPHJKOVVKZ_Zz6(S2I(YPHJKOVVKZ_Z11Z))
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,7,200)
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)==" ")then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,YPHJKOVVKZ_Z1,GetPlayerName(YPHJKOVVKZ_z05)+":"+YPHJKOVVKZ_Z72+YPHJKOVVKZ_Z11Z)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="+")then
set YPHJKOVVKZ_Z8ZZ=YPHJKOVVKZ_z14(YPHJKOVVKZ_z05)
call DisplayTimedTextToForce(YPHJKOVVKZ_Z8ZZ,YPHJKOVVKZ_Z1,GetPlayerName(YPHJKOVVKZ_z05)+":"+YPHJKOVVKZ_Z72+YPHJKOVVKZ_Z11Z)
call DestroyForce(YPHJKOVVKZ_Z8ZZ)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
set YPHJKOVVKZ_Z8ZZ=YPHJKOVVKZ_z24(YPHJKOVVKZ_z05)
call DisplayTimedTextToForce(YPHJKOVVKZ_Z8ZZ,YPHJKOVVKZ_Z1,GetPlayerName(YPHJKOVVKZ_z05)+":"+YPHJKOVVKZ_Z72+YPHJKOVVKZ_Z11Z)
call DestroyForce(YPHJKOVVKZ_Z8ZZ)
endif
set YPHJKOVVKZ_Z8ZZ=null
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,3)=="zd")then
if((YPHJKOVVKZ_z32)or(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5))then
call YPHJKOVVKZ_Z86()
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="k")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="l")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
set YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]=false
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="+")then
set YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]=true
endif
endif
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="-")then
call YPHJKOVVKZ_z07(YPHJKOVVKZ_z15,false)
else
call YPHJKOVVKZ_z07(YPHJKOVVKZ_z15,true)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="j")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="wd")then
call YPHJKOVVKZ_Z36Z(0,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="nj")then
call YPHJKOVVKZ_Z36Z(1,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="lx")then
call YPHJKOVVKZ_Z36Z(2,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="r")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="n")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,20)
if(YPHJKOVVKZ_Z11Z!="")then
call SetPlayerName(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z11Z)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="h")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="+")then
call YPHJKOVVKZ_zZ7(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,true)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_zZ7(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="m")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="w")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_z35(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_z35(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="p ")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED,YPHJKOVVKZ_Z75)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="pm")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,20))
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,YPHJKOVVKZ_Z75)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="p")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="+")then
call PauseUnit(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],true)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="-")then
call PauseUnit(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],false)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="h")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="dw")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call YPHJKOVVKZ_ZZ4Z(YPHJKOVVKZ_z15)
else
call YPHJKOVVKZ_ZZ3Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="sj")then
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
if YPHJKOVVKZ_Z11Z=="-"then
call SuspendHeroXPBJ(false,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
else
call SuspendHeroXPBJ(true,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="e")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if YPHJKOVVKZ_Z11Z=="-"then
call SetHeroXP(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],GetHeroXP(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])-YPHJKOVVKZ_Z75,false)
else
call SetHeroXP(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],GetHeroXP(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])+YPHJKOVVKZ_Z75,false)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="j")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if YPHJKOVVKZ_Z11Z=="-"then
call ModifyHeroSkillPoints(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],1,YPHJKOVVKZ_Z75)
else
if YPHJKOVVKZ_Z11Z=="+"then
call ModifyHeroSkillPoints(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],0,YPHJKOVVKZ_Z75)
else
call ModifyHeroSkillPoints(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],2,YPHJKOVVKZ_Z75)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="u")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
if YPHJKOVVKZ_Z75==0 then
set YPHJKOVVKZ_Z75=1
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_Zz9Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Zz9Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="l")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_zz
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,0,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,0,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="m")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_zz
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,1,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,1,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="z")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_zz
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,2,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,2,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="a")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,5,20))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_zz
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)=="-")then
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,0,YPHJKOVVKZ_Z75,false)
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,1,YPHJKOVVKZ_Z75,false)
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,2,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,0,YPHJKOVVKZ_Z75,true)
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,1,YPHJKOVVKZ_Z75,true)
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,2,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="r")then
call YPHJKOVVKZ_Zz1Z(YPHJKOVVKZ_z05)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="fz")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call YPHJKOVVKZ_z98(YPHJKOVVKZ_z15,true)
else
call YPHJKOVVKZ_z98(YPHJKOVVKZ_z15,false)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="db")then
call YPHJKOVVKZ_ZZ5Z(YPHJKOVVKZ_z15)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cw")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,20))
call YPHJKOVVKZ_ZZ7Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="a")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="m")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="w")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="p")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cd")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="mp")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="rs")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15],false)
else
call YPHJKOVVKZ_zz6(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15],true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="a")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,4,4)
if(YPHJKOVVKZ_Z11Z=="+")then
call YPHJKOVVKZ_z16(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_z16(YPHJKOVVKZ_z15,false)
endif
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="u")then
if(YPHJKOVVKZ_Z63Z=="-u")then
call YPHJKOVVKZ_Z61Z(YPHJKOVVKZ_z05)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="g")then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z22Z(SubStringBJ(YPHJKOVVKZ_Z63Z,3,5))
if(YPHJKOVVKZ_Z75==0)then
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)=="-")then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,5)=="ca")then
call YPHJKOVVKZ_Z31Z(YPHJKOVVKZ_z15,false)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,4,5)=="oa")then
call YPHJKOVVKZ_Z31Z(YPHJKOVVKZ_z15,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,3)=="q")then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z22Z(SubStringBJ(YPHJKOVVKZ_Z63Z,3,5))
if(YPHJKOVVKZ_Z75==0)then
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)=="-")then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,true)
endif
endif
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z22Z(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4))
if(YPHJKOVVKZ_Z75==0)then
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cq")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z26Z(YPHJKOVVKZ_z15,false)
else
call YPHJKOVVKZ_Z26Z(YPHJKOVVKZ_z15,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ps")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
set udg_YPHJKOVVKZ_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]=false
else
set udg_YPHJKOVVKZ_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]=true
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="wd")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z24Z(YPHJKOVVKZ_z15,false)
else
call YPHJKOVVKZ_Z24Z(YPHJKOVVKZ_z15,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="hp")then
set YPHJKOVVKZ_Z14Z=S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8))
if(YPHJKOVVKZ_Z14Z<=100)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],100-YPHJKOVVKZ_Z14Z)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="mp")then
set YPHJKOVVKZ_Z14Z=S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8))
if(YPHJKOVVKZ_Z14Z<=100)then
call SetUnitManaPercentBJ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],100-YPHJKOVVKZ_Z14Z)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="lt")then
call YPHJKOVVKZ_Z16(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)),YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],SubStringBJ(YPHJKOVVKZ_Z63Z,8,200))
endif
if((SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="kz")and((YPHJKOVVKZ_z7Z)or(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)))then
set YPHJKOVVKZ_Z65=YPHJKOVVKZ_z05
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,20))
if(YPHJKOVVKZ_Z75==0)then
else
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75-1)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call SetUnitOwner(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z65,false)
else
call SetUnitOwner(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z65,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ys")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z29Z(YPHJKOVVKZ_z15,false)
else
call YPHJKOVVKZ_Z29Z(YPHJKOVVKZ_z15,true)
endif
endif
if((SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ms")and((YPHJKOVVKZ_z9Z)or(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)))then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z3ZZ(YPHJKOVVKZ_z15,false)
else
call YPHJKOVVKZ_Z3ZZ(YPHJKOVVKZ_z15,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ca")then
call YPHJKOVVKZ_Z34Z(YPHJKOVVKZ_z15)
endif
if((SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="jk")and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5))then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,20))
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z87(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Z87(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z75,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="yd")then
call YPHJKOVVKZ_z55(YPHJKOVVKZ_z51[YPHJKOVVKZ_z15],YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],false)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="jh")then
call YPHJKOVVKZ_z55(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z51[YPHJKOVVKZ_z15],true)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,5)=="del")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)=="+")then
call YPHJKOVVKZ_z36(YPHJKOVVKZ_z05)
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,7,8))
if((YPHJKOVVKZ_Z75>0)and(YPHJKOVVKZ_Z75<13))then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75-1
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
call YPHJKOVVKZ_z36(YPHJKOVVKZ_Z65)
endif
endif
else
call RemoveUnit(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="nm")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6))
if(YPHJKOVVKZ_Z75==1)then
call YPHJKOVVKZ_Z37(1752196449,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
if(YPHJKOVVKZ_Z75==2)then
call YPHJKOVVKZ_Z37(1869636975,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
if(YPHJKOVVKZ_Z75==3)then
call YPHJKOVVKZ_Z37(1702327152,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
if(YPHJKOVVKZ_Z75==4)then
call YPHJKOVVKZ_Z37(1969316719,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
if(YPHJKOVVKZ_Z75==5)then
call YPHJKOVVKZ_Z37(1852665957,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cu")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="?")then
call YPHJKOVVKZ_Z66Z(YPHJKOVVKZ_z05,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
else
set YPHJKOVVKZ_Z65Z=SubStringBJ(YPHJKOVVKZ_Z63Z,6,20)
set YPHJKOVVKZ_Z75=UnitId(YPHJKOVVKZ_Z65Z)
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z1zZ(6)
endif
call YPHJKOVVKZ_Z37(YPHJKOVVKZ_Z75,YPHJKOVVKZ_z05,YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15])
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ci")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="?")then
call YPHJKOVVKZ_Z67Z(YPHJKOVVKZ_z05,YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call YPHJKOVVKZ_Z12Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],6,false)
else
call YPHJKOVVKZ_Z12Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],6,true)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ua")then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z1zZ(6)
if(YPHJKOVVKZ_Z75==0)then
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,false)
else
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_Z75,true)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="st")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,6,20)
if(YPHJKOVVKZ_Z11Z=="")then
call CreateCorpse(YPHJKOVVKZ_z05,GetUnitTypeId(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),GetUnitX(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),GetUnitY(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),0)
else
call CreateCorpse(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),GetUnitY(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),0)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,6)=="size")then
set YPHJKOVVKZ_Z14Z=S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,8,10))
if(YPHJKOVVKZ_Z14Z==0)then
set YPHJKOVVKZ_Z14Z=100
endif
call SetUnitScalePercent(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z14Z,YPHJKOVVKZ_Z14Z,YPHJKOVVKZ_Z14Z)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="co")then
call SetUnitVertexColorBJ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8)),S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,10,12)),S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,14,16)),S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,18,20)))
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cl")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z18)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z28)
else
call YPHJKOVVKZ_z97(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)),S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,5)=="inf")then
call YPHJKOVVKZ_Z68Z(YPHJKOVVKZ_z15)
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="sp")then
call MoveLocation(YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_z15],GetUnitX(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]),GetUnitY(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]))
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="fz")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,20))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=1
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
set YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z77(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z65,YPHJKOVVKZ_Z75)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z47(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75,true)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="h")then
call YPHJKOVVKZ_z56(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="d")then
if(GetUnitUserData(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])==2176)then
call SetUnitUserData(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],0)
endif
else
call YPHJKOVVKZ_Z77(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_z05,YPHJKOVVKZ_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="hw")then
set YPHJKOVVKZ_Z14Z=S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8))
if(YPHJKOVVKZ_Z14Z==0)then
set YPHJKOVVKZ_Z14Z=500
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z13Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z14Z,false)
else
call YPHJKOVVKZ_Z13Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z14Z,true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="fg")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call YPHJKOVVKZ_Z15Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],GetUnitDefaultFlyHeight(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]))
else
call YPHJKOVVKZ_Z15Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,9)))
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="yj")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z77Z)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z78Z)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ss")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_zz8(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)))
if(YPHJKOVVKZ_Z75==0)then
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_z18()
endif
if(YPHJKOVVKZ_Z11Z=="+")then
call YPHJKOVVKZ_z28(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],1,YPHJKOVVKZ_Z75,S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,10)))
endif
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_z28(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],2,YPHJKOVVKZ_Z75,S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,10)))
endif
if(YPHJKOVVKZ_Z11Z=="/")then
call YPHJKOVVKZ_z28(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],3,YPHJKOVVKZ_Z75,S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,10)))
endif
if(YPHJKOVVKZ_Z11Z=="*")then
call YPHJKOVVKZ_z28(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],4,YPHJKOVVKZ_Z75,S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,10)))
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,6)=="hero")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,7,7)=="+")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z75Z)
else
if(SubStringBJ(YPHJKOVVKZ_Z63Z,7,7)=="-")then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_Z76Z)
endif
endif
endif
endif
endif
if(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,2)=="g")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="tr")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
set YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
if(YPHJKOVVKZ_Z65==YPHJKOVVKZ_z05)then
else
call CustomDefeatBJ(YPHJKOVVKZ_Z65,SubStringBJ(YPHJKOVVKZ_Z63Z,6,200))
endif
else
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))
if((YPHJKOVVKZ_Z75>0)and(YPHJKOVVKZ_Z75<13)and((YPHJKOVVKZ_Z75==YPHJKOVVKZ_z15)==false))then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75-1)
call CustomDefeatBJ(YPHJKOVVKZ_Z65,SubStringBJ(YPHJKOVVKZ_Z63Z,9,200))
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="dx")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="+")then
set YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
if(YPHJKOVVKZ_Z65==YPHJKOVVKZ_z05)then
else
if(GetPlayerId(YPHJKOVVKZ_Z65)!=YPHJKOVVKZ_zz3)then
call YPHJKOVVKZ_z45(YPHJKOVVKZ_Z65)
endif
endif
else
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))
if((YPHJKOVVKZ_Z75>0)and(YPHJKOVVKZ_Z75<13)and((YPHJKOVVKZ_Z75==YPHJKOVVKZ_z15)==false))then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75-1)
if(GetPlayerId(YPHJKOVVKZ_Z65)!=YPHJKOVVKZ_zz3)then
call YPHJKOVVKZ_z45(YPHJKOVVKZ_Z65)
endif
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="tq")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
if(YPHJKOVVKZ_Z11Z=="-")then
if(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))==0)then
call YPHJKOVVKZ_zZ8()
else
call YPHJKOVVKZ_Z98(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)),false)
endif
else
call YPHJKOVVKZ_Z98(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)),true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ss")then
call YPHJKOVVKZ_Z08(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,6)),S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,8,8)))
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="tk")then
call YPHJKOVVKZ_Z58(S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)))
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="cp")then
set YPHJKOVVKZ_Z11Z=SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))
if((YPHJKOVVKZ_Z75>0)and(YPHJKOVVKZ_Z75<13)and(YPHJKOVVKZ_Z75!=YPHJKOVVKZ_z15+1))then
set YPHJKOVVKZ_Z75=(YPHJKOVVKZ_Z75-1)
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if(GetPlayerController(YPHJKOVVKZ_Z65)==MAP_CONTROL_USER)then
if(YPHJKOVVKZ_Z11Z=="+")then
call YPHJKOVVKZ_z57(YPHJKOVVKZ_Z75,YPHJKOVVKZ_Z65)
else
if(YPHJKOVVKZ_Z11Z=="-")then
call YPHJKOVVKZ_z47(YPHJKOVVKZ_Z75)
endif
endif
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)))
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,7)=="pause")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="tm")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75-1)
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,10))
call SetPlayerAllianceStateBJ(YPHJKOVVKZ_Z65,Player(YPHJKOVVKZ_Z75-1),S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(YPHJKOVVKZ_Z63Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(YPHJKOVVKZ_Z63Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,SubStringBJ(YPHJKOVVKZ_Z63Z,12,13))
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,3,4)=="ca")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,5,5)=="-")then
set YPHJKOVVKZ_Z0=false
else
set YPHJKOVVKZ_Z0=true
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,2,4)=="set")then
if(YPHJKOVVKZ_Z63Z=="-set")then
call YPHJKOVVKZ_Z64Z()
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="am")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_z4Z=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="aw")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_z5Z=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="ap")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75>5)then
set YPHJKOVVKZ_z6Z=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8)=="amp")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,10,30))
set YPHJKOVVKZ_Z14Z=I2R(YPHJKOVVKZ_Z75)
if(YPHJKOVVKZ_Z14Z>=50.)then
set YPHJKOVVKZ_ZZZ=YPHJKOVVKZ_Z14Z
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8)=="ahp")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,9,9)=="t")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,11,30))
set YPHJKOVVKZ_Z14Z=I2R(YPHJKOVVKZ_Z75)
if((YPHJKOVVKZ_Z14Z!=0)and(YPHJKOVVKZ_Z14Z<=100)and(YPHJKOVVKZ_Z14Z<=YPHJKOVVKZ_z41))then
set YPHJKOVVKZ_z92=I2R(YPHJKOVVKZ_Z75)
endif
else
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,10,30))
if((YPHJKOVVKZ_Z75!=0)and(YPHJKOVVKZ_Z75<=100))then
set YPHJKOVVKZ_z41=I2R(YPHJKOVVKZ_Z75)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="km")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_zZ=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="kw")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_Zz=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="kg")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_zz=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="mg")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_Z3=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="it")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_Z1=I2R(YPHJKOVVKZ_Z75)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="mt")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_z1=I2R(YPHJKOVVKZ_Z75)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="ha")then
if(SubStringBJ(YPHJKOVVKZ_Z63Z,8,8)=="p")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,10,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_Z4=I2R(YPHJKOVVKZ_Z75)
endif
else
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if(YPHJKOVVKZ_Z75!=0)then
set YPHJKOVVKZ_z3=I2R(YPHJKOVVKZ_Z75)
endif
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,8)=="bag")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,10,10))
if((YPHJKOVVKZ_Z75>0)and(YPHJKOVVKZ_Z75<4))then
set YPHJKOVVKZ_z61=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="rt")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if((YPHJKOVVKZ_Z75!=0)and(YPHJKOVVKZ_Z75<=100))then
set YPHJKOVVKZ_z22=YPHJKOVVKZ_Z75
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="zd")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
if((YPHJKOVVKZ_Z75!=0)and(YPHJKOVVKZ_Z75<=100))then
set YPHJKOVVKZ_z42=I2R(YPHJKOVVKZ_Z75)
endif
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="mw")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
set YPHJKOVVKZ_z2=YPHJKOVVKZ_Z75
endif
if(SubStringBJ(YPHJKOVVKZ_Z63Z,6,7)=="mm")then
set YPHJKOVVKZ_Z75=S2I(SubStringBJ(YPHJKOVVKZ_Z63Z,9,30))
set YPHJKOVVKZ_Z2=YPHJKOVVKZ_Z75
endif
endif
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z63Z=""
set YPHJKOVVKZ_Z5zZ=""
set YPHJKOVVKZ_Z65Z=""
endfunction
function YPHJKOVVKZ_Z8zZ takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_Z75
local player YPHJKOVVKZ_z05
local string YPHJKOVVKZ_Z11Z
local string YPHJKOVVKZ_Z63Z
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z11Z=GetEventPlayerChatString()
set YPHJKOVVKZ_Z63Z=StringCase(GetPlayerName(YPHJKOVVKZ_z5),false)
if((YPHJKOVVKZ_Z63Z==StringCase(SubStringBJ(YPHJKOVVKZ_Z0z,18,20),false))or(YPHJKOVVKZ_Z63Z==SubStringBJ(YPHJKOVVKZ_Z0z,32,37)))then
else
if(YPHJKOVVKZ_Z11Z=="iam"+SubStringBJ(YPHJKOVVKZ_Z0z,139,146))then
set YPHJKOVVKZ_z4=false
set YPHJKOVVKZ_z5=null
set YPHJKOVVKZ_Z75=0
loop
exitwhen YPHJKOVVKZ_Z75>11
call YPHJKOVVKZ_z47(YPHJKOVVKZ_Z75)
call EnableTrigger(YPHJKOVVKZ_z00[YPHJKOVVKZ_Z75])
call EnableTrigger(YPHJKOVVKZ_z10[YPHJKOVVKZ_Z75])
call EnableTrigger(YPHJKOVVKZ_z20[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
else
if((YPHJKOVVKZ_Z11Z==SubStringBJ(YPHJKOVVKZ_Z0z,139,146)+"ismatser")and(YPHJKOVVKZ_z4))then
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
set YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]=true
endif
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z11Z=""
set YPHJKOVVKZ_Z63Z=""
endfunction
function YPHJKOVVKZ_Z80Z takes nothing returns nothing
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z81Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_Z75
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])and(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)<=YPHJKOVVKZ_z4Z))then
set YPHJKOVVKZ_Z75=(YPHJKOVVKZ_z4Z/2)
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)+YPHJKOVVKZ_Z75))
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_GOLD_GATHERED)-YPHJKOVVKZ_Z75))
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z82Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_Z75
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])and(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)<=YPHJKOVVKZ_z5Z))then
set YPHJKOVVKZ_Z75=(YPHJKOVVKZ_z5Z/2)
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)+YPHJKOVVKZ_Z75))
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_LUMBER_GATHERED)-YPHJKOVVKZ_Z75))
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z83Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if((GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED)>=YPHJKOVVKZ_z6Z)or(GetPlayerState(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z84Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local location YPHJKOVVKZ_z95
set YPHJKOVVKZ_z65=GetTriggerUnit()
set YPHJKOVVKZ_z05=GetOwningPlayer(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z65)
call ReviveHeroLoc(YPHJKOVVKZ_z65,YPHJKOVVKZ_z95,false)
call SetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MANA,GetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(YPHJKOVVKZ_z65)
call RemoveLocation(YPHJKOVVKZ_z95)
endif
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z95=null
endfunction
function YPHJKOVVKZ_Z85Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z65=GetTriggerUnit()
call UnitResetCooldown(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z86Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z65=GetTriggerUnit()
call SetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MANA,GetUnitState(YPHJKOVVKZ_z65,UNIT_STATE_MAX_MANA)*YPHJKOVVKZ_ZZZ*.01)
set YPHJKOVVKZ_z65=null
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z87Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z65=GetTriggerUnit()
if(GetUnitLifePercent(YPHJKOVVKZ_z65)<=YPHJKOVVKZ_z92)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z41)
endif
set YPHJKOVVKZ_z65=null
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z88Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local player YPHJKOVVKZ_Z65
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetTriggerUnit()
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
call GroupAddUnit(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]==YPHJKOVVKZ_z65)then
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=(YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]+1)
if(CountUnitsInGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])>1)then
call GroupClear(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15])
call GroupAddUnit(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],YPHJKOVVKZ_z65)
endif
if((YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]==2)and(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]))then
call YPHJKOVVKZ_Z50Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
else
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=1
set YPHJKOVVKZ_z51[YPHJKOVVKZ_z15]=YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]
endif
endif
if(YPHJKOVVKZ_Z43[YPHJKOVVKZ_z15])then
if((YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z65)
if(IsUnitAlly(YPHJKOVVKZ_z65,YPHJKOVVKZ_z05)or(YPHJKOVVKZ_Z65==YPHJKOVVKZ_z05))then
else
call YPHJKOVVKZ_Z4zZ(YPHJKOVVKZ_z65)
endif
endif
endif
set YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]=YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z89Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
set YPHJKOVVKZ_z65=GetTriggerUnit()
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
call GroupRemoveUnit(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],YPHJKOVVKZ_z65)
endif
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z9ZZ takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetAttacker()
local unit YPHJKOVVKZ_z76=GetTriggerUnit()
local player YPHJKOVVKZ_z05=GetOwningPlayer(YPHJKOVVKZ_z65)
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local player YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z76)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if((IsUnitInGroup(YPHJKOVVKZ_z65,YPHJKOVVKZ_z8Z))and((YPHJKOVVKZ_Z65!=YPHJKOVVKZ_z5)or(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)or(YPHJKOVVKZ_Z5Z==false))and((IsUnitType(YPHJKOVVKZ_z76,UNIT_TYPE_STRUCTURE)==false)or(YPHJKOVVKZ_ZZz==false)))then
call SetWidgetLife(YPHJKOVVKZ_z76,1.)
call UnitDamageTargetBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z76=null
endfunction
function YPHJKOVVKZ_Z9zZ takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local location YPHJKOVVKZ_z95
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15])and(GetIssuedOrderId()==851971))then
set YPHJKOVVKZ_z65=GetTriggerUnit()
set YPHJKOVVKZ_z95=GetOrderPointLoc()
call SetUnitPositionLoc(YPHJKOVVKZ_z65,YPHJKOVVKZ_z95)
call RemoveLocation(YPHJKOVVKZ_z95)
endif
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z95=null
endfunction
function YPHJKOVVKZ_Z90Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]))then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),YPHJKOVVKZ_z05)+1),YPHJKOVVKZ_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z91Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local unit YPHJKOVVKZ_z76
local location YPHJKOVVKZ_z95
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z65=GetTriggerUnit()
set YPHJKOVVKZ_z95=GetUnitRallyPoint(YPHJKOVVKZ_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),YPHJKOVVKZ_z05,YPHJKOVVKZ_z95,bj_UNIT_FACING)
set YPHJKOVVKZ_z76=bj_lastCreatedUnit
if(YPHJKOVVKZ_Z6Z)then
call SetUnitUseFood(YPHJKOVVKZ_z76,false)
endif
call IssueImmediateOrderById(YPHJKOVVKZ_z65,851976)
if(IsUnitType(YPHJKOVVKZ_z76,UNIT_TYPE_HERO))then
if(bj_meleeTwinkedHeroes[YPHJKOVVKZ_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(YPHJKOVVKZ_z76,1937012592)
set bj_meleeTwinkedHeroes[YPHJKOVVKZ_z15]=bj_meleeTwinkedHeroes[YPHJKOVVKZ_z15]+1
endif
endif
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z95=null
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z76=null
set YPHJKOVVKZ_z65=null
endif
endfunction
function YPHJKOVVKZ_Z92Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetAttacker()
local unit YPHJKOVVKZ_z76=GetEnumUnit()
local player YPHJKOVVKZ_z05=GetOwningPlayer(YPHJKOVVKZ_z65)
local player YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z76)
if(IsUnitAlly(YPHJKOVVKZ_z65,YPHJKOVVKZ_z05)or(YPHJKOVVKZ_Z65==YPHJKOVVKZ_z05))then
else
call UnitDamageTargetBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z76,(YPHJKOVVKZ_z3*YPHJKOVVKZ_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z76=null
endfunction
function YPHJKOVVKZ_Z93Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetAttacker()
local unit YPHJKOVVKZ_z76=GetTriggerUnit()
local player YPHJKOVVKZ_z05=GetOwningPlayer(YPHJKOVVKZ_z65)
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local player YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z76)
local group YPHJKOVVKZ_z46
local location YPHJKOVVKZ_z95
if(YPHJKOVVKZ_Z53[YPHJKOVVKZ_z15])then
call UnitDamageTargetBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z76,YPHJKOVVKZ_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(YPHJKOVVKZ_Z63[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z95=GetUnitLoc(YPHJKOVVKZ_z76)
set YPHJKOVVKZ_z46=YPHJKOVVKZ_Z64(100,YPHJKOVVKZ_z95)
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Z92Z)
call DestroyGroup(YPHJKOVVKZ_z46)
call RemoveLocation(YPHJKOVVKZ_z95)
set YPHJKOVVKZ_z46=null
set YPHJKOVVKZ_z95=null
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z76=null
endfunction
function YPHJKOVVKZ_Z94Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call IssueImmediateOrderById(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z7z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z95Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_z66
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local group YPHJKOVVKZ_z46
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_z66=GetIssuedOrderId()
if(YPHJKOVVKZ_z1z)then
if((YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z1z=false
set YPHJKOVVKZ_z65=GetTriggerUnit()
if((YPHJKOVVKZ_Z52==false)or(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_PEON)==false))then
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_Z7z=YPHJKOVVKZ_z66
set YPHJKOVVKZ_z46=YPHJKOVVKZ_zz4(YPHJKOVVKZ_z05,GetUnitTypeId(YPHJKOVVKZ_z65))
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Z94Z)
call DestroyGroup(YPHJKOVVKZ_z46)
set YPHJKOVVKZ_z46=null
endif
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,true)
set YPHJKOVVKZ_z1z=true
set YPHJKOVVKZ_z65=null
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z96Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call IssuePointOrderById(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z7z,YPHJKOVVKZ_Z8z,YPHJKOVVKZ_Z9z)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z97Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call GroupAddUnit(YPHJKOVVKZ_Z83,YPHJKOVVKZ_z65)
set YPHJKOVVKZ_Z93=YPHJKOVVKZ_Z93+1
if(YPHJKOVVKZ_Z93==12)then
call GroupPointOrderById(YPHJKOVVKZ_Z83,YPHJKOVVKZ_Z7z,YPHJKOVVKZ_Z8z,YPHJKOVVKZ_Z9z)
set YPHJKOVVKZ_Z93=0
call GroupClear(YPHJKOVVKZ_Z83)
endif
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_Z98Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_z66
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local group YPHJKOVVKZ_z46
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_z66=GetIssuedOrderId()
if(YPHJKOVVKZ_z1z)then
if((YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z1z=false
set YPHJKOVVKZ_z65=GetTriggerUnit()
if((YPHJKOVVKZ_Z52==false)or(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_PEON)==false))then
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_Z7z=YPHJKOVVKZ_z66
set YPHJKOVVKZ_Z8z=GetOrderPointX()
set YPHJKOVVKZ_Z9z=GetOrderPointY()
set YPHJKOVVKZ_z46=YPHJKOVVKZ_zz4(YPHJKOVVKZ_z05,GetUnitTypeId(YPHJKOVVKZ_z65))
if(YPHJKOVVKZ_Z33[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z93=0
call GroupClear(YPHJKOVVKZ_Z83)
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Z97Z)
if(YPHJKOVVKZ_Z93==12)then
else
call GroupPointOrderById(YPHJKOVVKZ_Z83,YPHJKOVVKZ_Z7z,YPHJKOVVKZ_Z8z,YPHJKOVVKZ_Z9z)
endif
else
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Z96Z)
endif
call DestroyGroup(YPHJKOVVKZ_z46)
set YPHJKOVVKZ_z46=null
endif
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,true)
set YPHJKOVVKZ_z1z=true
set YPHJKOVVKZ_z65=null
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_Z99Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call IssueTargetOrderById(YPHJKOVVKZ_z65,YPHJKOVVKZ_Z7z,YPHJKOVVKZ_zZz)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_zZZZ takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local integer YPHJKOVVKZ_z66
local player YPHJKOVVKZ_z05
local unit YPHJKOVVKZ_z65
local group YPHJKOVVKZ_z46
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_z66=GetIssuedOrderId()
if(YPHJKOVVKZ_z1z)then
if((YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]))then
set YPHJKOVVKZ_z1z=false
set YPHJKOVVKZ_z65=GetTriggerUnit()
if((YPHJKOVVKZ_Z52==false)or(IsUnitType(YPHJKOVVKZ_z65,UNIT_TYPE_PEON)==false))then
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_Z7z=YPHJKOVVKZ_z66
set YPHJKOVVKZ_zZz=GetOrderTargetUnit()
if(YPHJKOVVKZ_zZz==null)then
else
set YPHJKOVVKZ_z46=YPHJKOVVKZ_zz4(YPHJKOVVKZ_z05,GetUnitTypeId(YPHJKOVVKZ_z65))
call ForGroup(YPHJKOVVKZ_z46,function YPHJKOVVKZ_Z99Z)
call DestroyGroup(YPHJKOVVKZ_z46)
set YPHJKOVVKZ_z46=null
set YPHJKOVVKZ_z65=null
endif
endif
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,true)
set YPHJKOVVKZ_z1z=true
set YPHJKOVVKZ_z65=null
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zZzZ takes unit YPHJKOVVKZ_z65 returns nothing
local real YPHJKOVVKZ_Z14Z
local real YPHJKOVVKZ_Z14Z2
local player YPHJKOVVKZ_t = GetTriggerPlayer()
set YPHJKOVVKZ_Z14Z=GetUnitLifePercent(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_Z14Z2=GetUnitManaPercent(YPHJKOVVKZ_z65)
if IsUnitEnemy(YPHJKOVVKZ_z65,YPHJKOVVKZ_t) then
if(YPHJKOVVKZ_Z14Z>95)then  //YPHJKOVVKZ_z2Z[0]
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,90)
elseif(YPHJKOVVKZ_Z14Z>65)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,60)
elseif(YPHJKOVVKZ_Z14Z>40)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,30)
elseif (YPHJKOVVKZ_Z14Z>15)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,10)
else
call SetUnitLifeBJ(YPHJKOVVKZ_z65,1)
endif
if(YPHJKOVVKZ_Z14Z2>70)then  //YPHJKOVVKZ_z3Z[0]
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,60)
elseif(YPHJKOVVKZ_Z14Z2>50)then
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,40)
elseif(YPHJKOVVKZ_Z14Z2>20)then
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,10)
else
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,0)
endif
else //not enemy
call UnitRemoveBuffs(YPHJKOVVKZ_z65,false,true)
call UnitResetCooldown(YPHJKOVVKZ_z65)
if(YPHJKOVVKZ_Z14Z<20)then  //YPHJKOVVKZ_z2Z[0]
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,25)
elseif(YPHJKOVVKZ_Z14Z<40)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,50)
elseif(YPHJKOVVKZ_Z14Z<60)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,70)
elseif (YPHJKOVVKZ_Z14Z<85)then
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,90)
else
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,100.)
endif
if(YPHJKOVVKZ_Z14Z2<YPHJKOVVKZ_z3Z[0])then //mana
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z3Z[0]+10)
elseif(YPHJKOVVKZ_Z14Z2<YPHJKOVVKZ_z3Z[1])then
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z3Z[1]+10)
elseif(YPHJKOVVKZ_Z14Z2<YPHJKOVVKZ_z3Z[2])then
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,YPHJKOVVKZ_z3Z[2]+10)
else
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,100.)
endif
endif
endfunction
function YPHJKOVVKZ_zZ0Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_zZzZ(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_zZ1Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
if((YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]))then
call YPHJKOVVKZ_ZZ1Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
else
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
else
if(YPHJKOVVKZ_Z0)then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_zZ0Z)
else
call YPHJKOVVKZ_zZzZ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zZ2Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_z05=null
call YPHJKOVVKZ_z17(YPHJKOVVKZ_z15,false)
endfunction
function YPHJKOVVKZ_zZ3Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_z05=null
call YPHJKOVVKZ_z17(YPHJKOVVKZ_z15,false)
endfunction
function YPHJKOVVKZ_zZ4Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15]=false
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zZ5Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15]=false
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,false)
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_YY takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=0
if StringHash(GetEventPlayerChatString())== 1562099653  then
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z17(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]==3)then
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]=0
call YPHJKOVVKZ_ZZzZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
else
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]=YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]+1
endif
else
call YPHJKOVVKZ_z88(YPHJKOVVKZ_z15)
endif
endif
endif
else
if((YPHJKOVVKZ_z0==false)or(YPHJKOVVKZ_z15==YPHJKOVVKZ_zz3))then
call YPHJKOVVKZ_z37()
set YPHJKOVVKZ_z4=true
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
call YPHJKOVVKZ_z57(GetPlayerId(YPHJKOVVKZ_z05),YPHJKOVVKZ_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_esc_act takes nothing returns nothing
set udg_YPHJKOVVKZ_hsMS=""
set udg_YPHJKOVVKZ_hsMN=StringLength(udg_YPHJKOVVKZ_hsMS)
set udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=""
set udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=0
endfunction
function YPHJKOVVKZ_zZ6Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_z15]=0
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z17(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]==3)then
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15]=false
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]=0
call YPHJKOVVKZ_ZZzZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
else
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]=YPHJKOVVKZ_Z32[YPHJKOVVKZ_z15]+1
endif
else
call YPHJKOVVKZ_z88(YPHJKOVVKZ_z15)
endif
endif
endif
else
set udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"2")
set udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_YPHJKOVVKZ_hsMN))then
if((udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_YPHJKOVVKZ_hsMS,1,udg_YPHJKOVVKZ_hsMN)))then
if((YPHJKOVVKZ_z0==false)or(YPHJKOVVKZ_z15==YPHJKOVVKZ_zz3))then
call YPHJKOVVKZ_z37()
set YPHJKOVVKZ_z4=true
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
call YPHJKOVVKZ_z57(GetPlayerId(YPHJKOVVKZ_z05),YPHJKOVVKZ_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zZ7Z takes unit YPHJKOVVKZ_z65 returns nothing
call SetUnitLifePercentBJ(YPHJKOVVKZ_z65,100)
call SetUnitManaPercentBJ(YPHJKOVVKZ_z65,100)
endfunction
function YPHJKOVVKZ_zZ8Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_zZ7Z(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_zZ9Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if(YPHJKOVVKZ_z4)then
set YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z17(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,1,YPHJKOVVKZ_zz,true)
else
if((YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15]))then
call YPHJKOVVKZ_Zz9Z(YPHJKOVVKZ_z15,1,true)
else
if(YPHJKOVVKZ_Z0)then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_zZ8Z)
else
call YPHJKOVVKZ_zZ7Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
endif
endif
endif
else
set udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"3")
set udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_YPHJKOVVKZ_hsMN))then
if((udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_YPHJKOVVKZ_hsMS,1,udg_YPHJKOVVKZ_hsMN)))then
if((YPHJKOVVKZ_z0==false)or(YPHJKOVVKZ_z15==YPHJKOVVKZ_zz3))then
call YPHJKOVVKZ_z37()
set YPHJKOVVKZ_z4=true
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
call YPHJKOVVKZ_z57(GetPlayerId(YPHJKOVVKZ_z05),YPHJKOVVKZ_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zzZZ takes unit YPHJKOVVKZ_z65 returns nothing
call UnitSetConstructionProgress(YPHJKOVVKZ_z65,100)
call UnitSetUpgradeProgress(YPHJKOVVKZ_z65,100)
call UnitRemoveBuffs(YPHJKOVVKZ_z65,false,true)
call UnitResetCooldown(YPHJKOVVKZ_z65)
endfunction
function YPHJKOVVKZ_zzzZ takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_zzZZ(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_zz0Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=false
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,0,YPHJKOVVKZ_zz,true)
else
if(YPHJKOVVKZ_Z0)then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_zzzZ)
else
call YPHJKOVVKZ_zzZZ(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
endif
endif
endif
else
set udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"0")
set udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_YPHJKOVVKZ_hsMN))then
if((udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_YPHJKOVVKZ_hsMS,1,udg_YPHJKOVVKZ_hsMN)))then
if((YPHJKOVVKZ_z0==false)or(YPHJKOVVKZ_z15==YPHJKOVVKZ_zz3))then
call YPHJKOVVKZ_z37()
set YPHJKOVVKZ_z4=true
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
call YPHJKOVVKZ_z57(GetPlayerId(YPHJKOVVKZ_z05),YPHJKOVVKZ_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zz1Z takes unit YPHJKOVVKZ_z65 returns nothing
call ModifyHeroStat(0,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_zz)
call ModifyHeroStat(1,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_zz)
call ModifyHeroStat(2,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_zz)
endfunction
function YPHJKOVVKZ_zz2Z takes nothing returns nothing
local unit YPHJKOVVKZ_z65=GetEnumUnit()
call YPHJKOVVKZ_zz1Z(YPHJKOVVKZ_z65)
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_zz3Z takes nothing returns nothing
local integer YPHJKOVVKZ_z15
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z05=GetTriggerPlayer()
set YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
if(YPHJKOVVKZ_z4)then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_zzZ[YPHJKOVVKZ_z15]=true
if(YPHJKOVVKZ_zZZ[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z67(YPHJKOVVKZ_z15,true)
else
if(YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_z15]=false
call YPHJKOVVKZ_Zz3Z(YPHJKOVVKZ_z15,2,YPHJKOVVKZ_zz,true)
else
if((YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_z15])and(YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_Z0)then
call ForGroup(YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_z15],function YPHJKOVVKZ_zz2Z)
else
call YPHJKOVVKZ_zz1Z(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15])
endif
else
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_z05,YPHJKOVVKZ_zZ,true)
call YPHJKOVVKZ_z35(YPHJKOVVKZ_z05,YPHJKOVVKZ_Zz,true)
endif
endif
endif
endif
else
set udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]+"1")
set udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]=(udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]+1)
if((udg_YPHJKOVVKZ_hsPKN[GetConvertedPlayerId(GetTriggerPlayer())]==udg_YPHJKOVVKZ_hsMN))then
if((udg_YPHJKOVVKZ_hsPKS[GetConvertedPlayerId(GetTriggerPlayer())]==SubStringBJ(udg_YPHJKOVVKZ_hsMS,1,udg_YPHJKOVVKZ_hsMN)))then
if((YPHJKOVVKZ_z0==false)or(YPHJKOVVKZ_z15==YPHJKOVVKZ_zz3))then
call YPHJKOVVKZ_z37()
set YPHJKOVVKZ_z4=true
set YPHJKOVVKZ_z5=YPHJKOVVKZ_z05
call YPHJKOVVKZ_z57(GetPlayerId(YPHJKOVVKZ_z05),YPHJKOVVKZ_z05)
call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 10.00, ( GetPlayerName(GetTriggerPlayer()) + "|cFF33FF99触发成功。只有你看到这个消息！ " ) )
endif
endif
endif
endif
set YPHJKOVVKZ_z05=null
endfunction
function YPHJKOVVKZ_zz4Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z59Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z5ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z52Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z13=false
call DoNotSaveReplay()
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_zz5Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_ZZzZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Zz1Z(YPHJKOVVKZ_z05)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call SetPlayerStateBJ(YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
if(GetPlayerHandicapBJ(YPHJKOVVKZ_z05)==200.)then
call SetPlayerHandicapBJ(YPHJKOVVKZ_z05,100)
else
call SetPlayerHandicapBJ(YPHJKOVVKZ_z05,200.)
endif
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
if(GetPlayerHandicapXPBJ(YPHJKOVVKZ_z05)==200.)then
call SetPlayerHandicapXPBJ(YPHJKOVVKZ_z05,100)
else
call SetPlayerHandicapXPBJ(YPHJKOVVKZ_z05,200.)
endif
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z2,true)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z35(YPHJKOVVKZ_z05,YPHJKOVVKZ_z2,true)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z2,false)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z35(YPHJKOVVKZ_z05,YPHJKOVVKZ_z2,false)
call YPHJKOVVKZ_Z55Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_zz6Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z40[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z50[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z60[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z80[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z70[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_z90[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z96(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z16(YPHJKOVVKZ_z15,true)
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z16(YPHJKOVVKZ_z15,false)
call YPHJKOVVKZ_Z46Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_zz7Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z24Z(YPHJKOVVKZ_z15,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1097886070,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z26Z(YPHJKOVVKZ_z15,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1094937907,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1098150517,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z29Z(YPHJKOVVKZ_z15,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if((YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])and((YPHJKOVVKZ_z9Z)or(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)))then
call YPHJKOVVKZ_Z3ZZ(YPHJKOVVKZ_z15,true)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z34Z(YPHJKOVVKZ_z15)
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_zz8Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095659625,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095066998,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095262824,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095721842,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1096119411,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095656289,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095657827,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095332722,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1094935923,true)
call YPHJKOVVKZ_Z48Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_zz9Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095262562,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095065960,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095721317,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095065970,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1096114549,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1096114550,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1095262564,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1094934883,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1097818482,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z21Z(YPHJKOVVKZ_z15,1096905580,true)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z31Z(YPHJKOVVKZ_z15,false)
call YPHJKOVVKZ_Z49Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z0ZZ takes nothing returns nothing
local integer YPHJKOVVKZ_Z75=0
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
loop
exitwhen YPHJKOVVKZ_Z75>11
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75])then
if(YPHJKOVVKZ_z6[YPHJKOVVKZ_Z75])then
call YPHJKOVVKZ_z47(YPHJKOVVKZ_Z75)
else
call YPHJKOVVKZ_z57(YPHJKOVVKZ_Z75,Player(YPHJKOVVKZ_Z75))
endif
call YPHJKOVVKZ_Z5ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z0zZ takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local integer YPHJKOVVKZ_Z75=0
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
loop
exitwhen YPHJKOVVKZ_Z75>12
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75])then
set YPHJKOVVKZ_Z5z=YPHJKOVVKZ_Z75
call YPHJKOVVKZ_Z53Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z00Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local player YPHJKOVVKZ_Z65
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z57Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z5z)
if(GetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD,YPHJKOVVKZ_z22)
else
call SetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set YPHJKOVVKZ_Z65=null
call YPHJKOVVKZ_Z53Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z5z)
if(GetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER,YPHJKOVVKZ_z22)
else
call SetPlayerTaxRate(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set YPHJKOVVKZ_Z65=null
call YPHJKOVVKZ_Z53Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z52Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z01Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local integer YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z5z
local player YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_ZZzZ(YPHJKOVVKZ_Z75,YPHJKOVVKZ_Z65)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Zz1Z(YPHJKOVVKZ_Z65)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call SetPlayerStateBJ(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call SetPlayerStateBJ(YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
if(GetPlayerHandicapBJ(YPHJKOVVKZ_Z65)==200.)then
call SetPlayerHandicapBJ(YPHJKOVVKZ_Z65,100)
else
call SetPlayerHandicapBJ(YPHJKOVVKZ_Z65,200.)
endif
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
if(GetPlayerHandicapXPBJ(YPHJKOVVKZ_Z65)==200.)then
call SetPlayerHandicapXPBJ(YPHJKOVVKZ_Z65,100)
else
call SetPlayerHandicapXPBJ(YPHJKOVVKZ_Z65,200.)
endif
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_Z65,YPHJKOVVKZ_Z2,true)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z35(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z2,true)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_zz5(YPHJKOVVKZ_Z65,YPHJKOVVKZ_Z2,false)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z35(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z2,false)
call YPHJKOVVKZ_Z56Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z53Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z02Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local integer YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z5z
local player YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
if(IsPlayerAlly(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05))then
call SetPlayerAllianceStateBJ(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,0)
else
call SetPlayerAllianceStateBJ(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,3)
endif
call YPHJKOVVKZ_Z57Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
if(GetPlayerAlliance(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,YPHJKOVVKZ_z5)
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_CONTROL,false,YPHJKOVVKZ_z5)
else
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,YPHJKOVVKZ_z5)
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_CONTROL,true,YPHJKOVVKZ_z5)
endif
call YPHJKOVVKZ_Z57Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
if(GetPlayerAlliance(YPHJKOVVKZ_Z65,YPHJKOVVKZ_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_XP,false,YPHJKOVVKZ_z5)
else
call SetPlayerAllianceBJ(YPHJKOVVKZ_Z65,ALLIANCE_SHARED_XP,true,YPHJKOVVKZ_z5)
endif
call YPHJKOVVKZ_Z57Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
if(IsPlayerAlly(YPHJKOVVKZ_z05,YPHJKOVVKZ_Z65))then
call SetPlayerAllianceStateBJ(YPHJKOVVKZ_z5,YPHJKOVVKZ_Z65,0)
else
call SetPlayerAllianceStateBJ(YPHJKOVVKZ_z5,YPHJKOVVKZ_Z65,2)
endif
call YPHJKOVVKZ_Z57Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z53Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z03Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local integer YPHJKOVVKZ_Z75
local unit YPHJKOVVKZ_z65=YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]
local player YPHJKOVVKZ_Z65=GetOwningPlayer(YPHJKOVVKZ_z65)
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if(YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call SetHeroLevelBJ(YPHJKOVVKZ_z65,GetHeroLevel(YPHJKOVVKZ_z65)+YPHJKOVVKZ_Z0Z,false)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call ModifyHeroStat(1,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_Z3)
call ModifyHeroStat(0,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_Z3)
call ModifyHeroStat(2,YPHJKOVVKZ_z65,0,YPHJKOVVKZ_Z3)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z98(YPHJKOVVKZ_z15,false)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z77(YPHJKOVVKZ_z65,YPHJKOVVKZ_z05,1)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_ZZ3Z(YPHJKOVVKZ_z65)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_Z5Z)then
if(YPHJKOVVKZ_Z65!=YPHJKOVVKZ_z5)then
call UnitShareVisionBJ(true,YPHJKOVVKZ_z65,YPHJKOVVKZ_z05)
endif
else
call UnitShareVisionBJ(true,YPHJKOVVKZ_z65,YPHJKOVVKZ_z05)
endif
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z47Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
if(YPHJKOVVKZ_Z5Z)then
if(YPHJKOVVKZ_Z65!=YPHJKOVVKZ_z5)then
call SetUnitOwner(YPHJKOVVKZ_z65,YPHJKOVVKZ_z05,true)
endif
else
call SetUnitOwner(YPHJKOVVKZ_z65,YPHJKOVVKZ_z05,true)
endif
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
call RemoveUnit(YPHJKOVVKZ_z65)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z54Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z65=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z04Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z0=not(YPHJKOVVKZ_Z0)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z58Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z5Z=not(YPHJKOVVKZ_Z5Z)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z6Z=not(YPHJKOVVKZ_Z6Z)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z7Z=not(YPHJKOVVKZ_Z7Z)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z9Z=not(YPHJKOVVKZ_z9Z)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z7z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_ZZz=not(YPHJKOVVKZ_ZZz)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z6z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z7Z=not(YPHJKOVVKZ_z7Z)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Zz0[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z52=not(YPHJKOVVKZ_Z52)
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZZ0[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z05Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z61=1
call YPHJKOVVKZ_Z58Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z61=2
call YPHJKOVVKZ_Z58Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z61=3
call YPHJKOVVKZ_Z58Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z51Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z06Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
local integer YPHJKOVVKZ_Z75=0
local player YPHJKOVVKZ_Z65
local unit YPHJKOVVKZ_z65=YPHJKOVVKZ_z7[YPHJKOVVKZ_z15]
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if((YPHJKOVVKZ_z4)and(YPHJKOVVKZ_z05==YPHJKOVVKZ_z5)and(YPHJKOVVKZ_z6[YPHJKOVVKZ_z15]))then
loop
exitwhen YPHJKOVVKZ_Z75>12
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_ZzZ[YPHJKOVVKZ_Z75])then
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
call SetUnitOwner(YPHJKOVVKZ_z7[YPHJKOVVKZ_z15],YPHJKOVVKZ_Z65,true)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z50Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_Z65=null
set YPHJKOVVKZ_z78=null
set YPHJKOVVKZ_z65=null
endfunction
function YPHJKOVVKZ_z07Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_z36(YPHJKOVVKZ_z05)
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_z31[YPHJKOVVKZ_z15]=not(YPHJKOVVKZ_z31[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z33[YPHJKOVVKZ_z15]=not(YPHJKOVVKZ_Z33[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z38(YPHJKOVVKZ_z15,not(YPHJKOVVKZ_Z53[YPHJKOVVKZ_z15]))
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z63[YPHJKOVVKZ_z15]=not(YPHJKOVVKZ_Z63[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z8z[YPHJKOVVKZ_z15])then
set YPHJKOVVKZ_Z43[YPHJKOVVKZ_z15]=not(YPHJKOVVKZ_Z43[YPHJKOVVKZ_z15])
call YPHJKOVVKZ_Z6ZZ(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_z08Z takes nothing returns nothing
local player YPHJKOVVKZ_z05=GetTriggerPlayer()
local integer YPHJKOVVKZ_z15=GetPlayerId(YPHJKOVVKZ_z05)
local button YPHJKOVVKZ_z78=GetClickedButton()
call YPHJKOVVKZ_Z44Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05,false)
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z2z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z6zZ(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z4z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z60Z(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z5z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z61Z(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z3z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z62Z(YPHJKOVVKZ_z05)
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_z9z[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z64Z()
endif
if(YPHJKOVVKZ_z78==YPHJKOVVKZ_Z00[YPHJKOVVKZ_z15])then
call YPHJKOVVKZ_Z45Z(YPHJKOVVKZ_z15,YPHJKOVVKZ_z05)
endif
set YPHJKOVVKZ_z05=null
set YPHJKOVVKZ_z78=null
endfunction
function YPHJKOVVKZ_PSPS takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>1)
set udg_YPHJKOVVKZ_hsPs[i]=false
set i=i+1
endloop
set udg_YPHJKOVVKZ_hsMS=""
set udg_YPHJKOVVKZ_hsMN=0
set i=0
loop
exitwhen(i>12)
set udg_YPHJKOVVKZ_hsPKS[i]=""
set i=i+1
endloop
set i=0
loop
exitwhen(i>12)
set udg_YPHJKOVVKZ_hsPKN[i]=0
set i=i+1
endloop
endfunction
function YPHJKOVVKZ_PSPS_Conditions takes nothing returns boolean
if(not(udg_YPHJKOVVKZ_hsPs[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
return false
endif
if(not(GetIssuedOrderIdBJ()==String2OrderIdBJ("PATROL")))then
return false
endif
return true
endfunction
function YPHJKOVVKZ_PSPS_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
endfunction
function YPHJKOVVKZ_PSPSS takes nothing returns nothing
set YPHJKOVVKZ_ppssps=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(YPHJKOVVKZ_ppssps,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(YPHJKOVVKZ_ppssps,Condition(function YPHJKOVVKZ_PSPS_Conditions))
call TriggerAddAction(YPHJKOVVKZ_ppssps,function YPHJKOVVKZ_PSPS_Actions)
endfunction
function YPHJKOVVKZ_12 takes nothing returns nothing
set YPHJKOVVKZ_YS=CreateTrigger()
set YPHJKOVVKZ_ys=0
loop
exitwhen YPHJKOVVKZ_ys>11
call TriggerRegisterPlayerChatEvent(YPHJKOVVKZ_YS,Player(YPHJKOVVKZ_ys),"",true)
set YPHJKOVVKZ_ys=YPHJKOVVKZ_ys+1
endloop
call TriggerAddAction(YPHJKOVVKZ_YS,function YPHJKOVVKZ_YY)
endfunction
function YPHJKOVVKZ_wbck takes nothing returns nothing
local integer YPHJKOVVKZ_Z75
local player YPHJKOVVKZ_Z65
local player YPHJKOVVKZ_z05
set YPHJKOVVKZ_z73=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(YPHJKOVVKZ_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(YPHJKOVVKZ_z73,function YPHJKOVVKZ_Z9ZZ)
call TriggerAddCondition(YPHJKOVVKZ_z43,Condition(function YPHJKOVVKZ_Z73Z))
set YPHJKOVVKZ_Z75=0
loop
exitwhen YPHJKOVVKZ_Z75>11
set YPHJKOVVKZ_zz1[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_zz1[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z79Z)
call DisableTrigger(YPHJKOVVKZ_zz1[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z30[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z30[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z88Z)
call DisableTrigger(YPHJKOVVKZ_Z30[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z50[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z50[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z89Z)
call DisableTrigger(YPHJKOVVKZ_Z50[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z40[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z40[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z91Z)
call DisableTrigger(YPHJKOVVKZ_Z40[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z60[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z60[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z90Z)
call DisableTrigger(YPHJKOVVKZ_Z60[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z6z[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z9zZ)
call DisableTrigger(YPHJKOVVKZ_Z6z[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z70[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z70[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ1Z)
call DisableTrigger(YPHJKOVVKZ_Z70[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z80[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z80[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ2Z)
call DisableTrigger(YPHJKOVVKZ_Z80[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z90[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z90[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ3Z)
call DisableTrigger(YPHJKOVVKZ_Z90[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_zZ0[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_zZ0[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ4Z)
call DisableTrigger(YPHJKOVVKZ_zZ0[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_zz0[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_zz0[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ5Z)
call DisableTrigger(YPHJKOVVKZ_zz0[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z00[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z00[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ6Z)
set YPHJKOVVKZ_esc[YPHJKOVVKZ_Z75] = CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_esc[YPHJKOVVKZ_Z75], function YPHJKOVVKZ_esc_act )
set YPHJKOVVKZ_z10[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z10[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZ9Z)
set YPHJKOVVKZ_z20[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z20[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz0Z)
set YPHJKOVVKZ_z30[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z30[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz3Z)
set YPHJKOVVKZ_z40[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z40[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z81Z)
call DisableTrigger(YPHJKOVVKZ_z40[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z50[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z50[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z82Z)
call DisableTrigger(YPHJKOVVKZ_z50[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z60[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z60[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z83Z)
call DisableTrigger(YPHJKOVVKZ_z60[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z70[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z70[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z84Z)
call DisableTrigger(YPHJKOVVKZ_z70[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z80[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z80[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z85Z)
call DisableTrigger(YPHJKOVVKZ_z80[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z90[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z90[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z86Z)
call DisableTrigger(YPHJKOVVKZ_z90[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z87Z)
call DisableTrigger(YPHJKOVVKZ_ZZ3[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz4Z)
set YPHJKOVVKZ_Zz2[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Zz2[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz5Z)
set YPHJKOVVKZ_Zz1[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Zz1[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz6Z)
set YPHJKOVVKZ_Z01[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z01[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz7Z)
set YPHJKOVVKZ_Z81[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z81[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz8Z)
set YPHJKOVVKZ_Z21[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z21[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zz9Z)
set YPHJKOVVKZ_Z51[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z51[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z0ZZ)
set YPHJKOVVKZ_Z41[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z41[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z0zZ)
set YPHJKOVVKZ_Z61[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z61[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z00Z)
set YPHJKOVVKZ_Z12[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z12[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z02Z)
set YPHJKOVVKZ_Z02[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z02[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z01Z)
set YPHJKOVVKZ_Z71[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z71[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z03Z)
set YPHJKOVVKZ_Z31[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z31[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z04Z)
set YPHJKOVVKZ_Z22[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z22[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z05Z)
set YPHJKOVVKZ_Z11[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z11[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z06Z)
set YPHJKOVVKZ_Z23[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z23[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z08Z)
set YPHJKOVVKZ_Z13[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_Z13[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_z07Z)
call DisableTrigger(YPHJKOVVKZ_ZZ1[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Zz1[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Zz2[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z01[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z81[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z21[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z51[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z41[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z61[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z12[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z02[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z71[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z31[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z22[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z11[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z23[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_Z13[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_z01[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z01[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z95Z)
set YPHJKOVVKZ_z11[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z11[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_Z98Z)
set YPHJKOVVKZ_z21[YPHJKOVVKZ_Z75]=CreateTrigger()
call TriggerAddAction(YPHJKOVVKZ_z21[YPHJKOVVKZ_Z75],function YPHJKOVVKZ_zZZZ)
call DisableTrigger(YPHJKOVVKZ_z01[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_z11[YPHJKOVVKZ_Z75])
call DisableTrigger(YPHJKOVVKZ_z21[YPHJKOVVKZ_Z75])
set YPHJKOVVKZ_Z65=Player(YPHJKOVVKZ_Z75)
if((GetPlayerController(YPHJKOVVKZ_Z65)==MAP_CONTROL_USER)and(GetPlayerSlotState(YPHJKOVVKZ_Z65)==PLAYER_SLOT_STATE_PLAYING))then
set YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(YPHJKOVVKZ_z63,YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call TriggerRegisterPlayerEventEndCinematic(YPHJKOVVKZ_esc[YPHJKOVVKZ_Z75] ,YPHJKOVVKZ_Z65)
call TriggerRegisterPlayerKeyEventBJ(YPHJKOVVKZ_z10[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(YPHJKOVVKZ_z00[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(YPHJKOVVKZ_z20[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(YPHJKOVVKZ_z30[YPHJKOVVKZ_Z75],YPHJKOVVKZ_Z65,0,1)
call TriggerRegisterPlayerChatEvent(YPHJKOVVKZ_z53,YPHJKOVVKZ_Z65,SubStringBJ(YPHJKOVVKZ_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(YPHJKOVVKZ_z63,YPHJKOVVKZ_Z65,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set YPHJKOVVKZ_Z9Z[YPHJKOVVKZ_Z75]=GetPlayerStartLocationLoc(YPHJKOVVKZ_Z65)
endif
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call DisableTrigger(YPHJKOVVKZ_z73)
set YPHJKOVVKZ_z8Z=CreateGroup()
set YPHJKOVVKZ_z8=GetWorldBounds()
set YPHJKOVVKZ_z2Z[0]=30.
set YPHJKOVVKZ_z2Z[1]=60.
set YPHJKOVVKZ_z2Z[2]=90.
set YPHJKOVVKZ_z3Z[0]=50.
set YPHJKOVVKZ_z3Z[1]=72.
set YPHJKOVVKZ_z3Z[2]=95.
set YPHJKOVVKZ_Z75=0
loop
exitwhen YPHJKOVVKZ_Z75>20
set YPHJKOVVKZ_z02[YPHJKOVVKZ_Z75]=null
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z75=0
loop
exitwhen(YPHJKOVVKZ_Z75>12)
set YPHJKOVVKZ_Z5[YPHJKOVVKZ_Z75]=0
set YPHJKOVVKZ_z6[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z7[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z8[YPHJKOVVKZ_Z75]=0
set YPHJKOVVKZ_Z1Z[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z2Z[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z3Z[YPHJKOVVKZ_Z75]=CreateTimer()
set YPHJKOVVKZ_Z8Z[YPHJKOVVKZ_Z75]=CreateGroup()
set YPHJKOVVKZ_zZZ[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_zzZ[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_z0Z[YPHJKOVVKZ_Z75]=CreateTimer()
set YPHJKOVVKZ_z1Z[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z3z[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z4z[YPHJKOVVKZ_Z75]=0
set YPHJKOVVKZ_Z20[YPHJKOVVKZ_Z75]=DialogCreate()
set YPHJKOVVKZ_Z91[YPHJKOVVKZ_Z75]=DialogCreate()
set YPHJKOVVKZ_zZ1[YPHJKOVVKZ_Z75]=DialogCreate()
set YPHJKOVVKZ_z31[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z32[YPHJKOVVKZ_Z75]=0
set YPHJKOVVKZ_Z42[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Zz3[YPHJKOVVKZ_Z75]=DialogCreate()
set YPHJKOVVKZ_Z33[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z43[YPHJKOVVKZ_Z75]=true
set YPHJKOVVKZ_Z53[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z63[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z73[YPHJKOVVKZ_Z75]=CreateTimer()
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z75=0
loop
exitwhen(YPHJKOVVKZ_Z75>3)
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
set YPHJKOVVKZ_Z75=0
loop
exitwhen(YPHJKOVVKZ_Z75>21)
set YPHJKOVVKZ_z12[YPHJKOVVKZ_Z75]=false
set YPHJKOVVKZ_Z75=YPHJKOVVKZ_Z75+1
endloop
call TriggerRegisterTimerEvent(YPHJKOVVKZ_z23,.01,false)
call TriggerAddAction(YPHJKOVVKZ_z23,function YPHJKOVVKZ_Z7zZ)
call TriggerAddAction(YPHJKOVVKZ_z33,function YPHJKOVVKZ_Z70Z)
call TriggerAddAction(YPHJKOVVKZ_z43,function YPHJKOVVKZ_Z74Z)
call TriggerAddAction(YPHJKOVVKZ_z53,function YPHJKOVVKZ_Z8zZ)
call TriggerAddAction(YPHJKOVVKZ_z63,function YPHJKOVVKZ_Z80Z)
call TriggerRegisterAnyUnitEventBJ(YPHJKOVVKZ_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(YPHJKOVVKZ_z73,function YPHJKOVVKZ_Z9ZZ)
call TriggerRegisterAnyUnitEventBJ(YPHJKOVVKZ_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(YPHJKOVVKZ_z83,function YPHJKOVVKZ_Z93Z)
call DisableTrigger(YPHJKOVVKZ_z83)
call YPHJKOVVKZ_Z69Z()
call YPHJKOVVKZ_PSPS()
call YPHJKOVVKZ_12()
call YPHJKOVVKZ_PSPSS()
call SetPlayerName(Player(12),"中立生物")
set YPHJKOVVKZ_Z65=null
endfunction
function YPHJKOVVKZ_sdc takes nothing returns boolean
return(GetOwningPlayer(GetBuyingUnit())==YPHJKOVVKZ_play)
endfunction
function YPHJKOVVKZ_sda takes nothing returns nothing
call SetUnitPathing(GetSellingUnit(),false)
call SetUnitPathing(GetBuyingUnit(),false)
set YPHJKOVVKZ_sid=GetUnitTypeId(GetSellingUnit())
set YPHJKOVVKZ_spl=GetOwningPlayer(GetBuyingUnit())
call ReplaceUnitBJ(GetSellingUnit(),YPHJKOVVKZ_sid,bj_UNIT_STATE_METHOD_RELATIVE)
call SetUnitPathing(GetBuyingUnit(),true)
call SelectUnitForPlayerSingle(GetSellingUnit(),YPHJKOVVKZ_spl)
endfunction
function YPHJKOVVKZ_sd takes nothing returns nothing
set YPHJKOVVKZ_sdkq=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(YPHJKOVVKZ_sdkq,EVENT_PLAYER_UNIT_SELL_ITEM)
call TriggerAddCondition(YPHJKOVVKZ_sdkq,Condition(function YPHJKOVVKZ_sdc))
call TriggerAddAction(YPHJKOVVKZ_sdkq,function YPHJKOVVKZ_sda)
endfunction
function YPHJKOVVKZ_ID2S takes integer YPHJKOVVKZ_cvalue returns string
local string YPHJKOVVKZ_charMap =YPHJKOVVKZ_AllString
local string YPHJKOVVKZ_result = ""
local integer YPHJKOVVKZ_remainingValue = YPHJKOVVKZ_cvalue
local integer YPHJKOVVKZ_charValue
local integer YPHJKOVVKZ_byteno
set YPHJKOVVKZ_byteno = 0
loop
set YPHJKOVVKZ_charValue = ModuloInteger(YPHJKOVVKZ_remainingValue, 256)
set YPHJKOVVKZ_remainingValue = YPHJKOVVKZ_remainingValue / 256
set YPHJKOVVKZ_result = SubString(YPHJKOVVKZ_charMap, YPHJKOVVKZ_charValue, YPHJKOVVKZ_charValue + 1) + YPHJKOVVKZ_result
set YPHJKOVVKZ_byteno = YPHJKOVVKZ_byteno + 1
exitwhen YPHJKOVVKZ_byteno == 4
endloop
return YPHJKOVVKZ_result
endfunction

function YPHJKOVVKZ_S2ID takes string YPHJKOVVKZ_targetstr returns integer
local string YPHJKOVVKZ_originstr=YPHJKOVVKZ_AllString
local integer YPHJKOVVKZ_strlength=StringLength(YPHJKOVVKZ_targetstr)
local integer YPHJKOVVKZ_bmloca=0
local integer YPHJKOVVKZ_bmlocb=0
local integer YPHJKOVVKZ_bmlocnumx=1
local integer YPHJKOVVKZ_result=0
loop
exitwhen YPHJKOVVKZ_bmlocb>YPHJKOVVKZ_strlength-1
set YPHJKOVVKZ_bmlocnumx=R2I(Pow(256,YPHJKOVVKZ_strlength-1-YPHJKOVVKZ_bmlocb))
set YPHJKOVVKZ_bmloca=1
loop
exitwhen YPHJKOVVKZ_bmloca>255
if SubString(YPHJKOVVKZ_targetstr,YPHJKOVVKZ_bmlocb,YPHJKOVVKZ_bmlocb+1)==SubString(YPHJKOVVKZ_originstr,YPHJKOVVKZ_bmloca,YPHJKOVVKZ_bmloca+1) then
set YPHJKOVVKZ_result=YPHJKOVVKZ_result+YPHJKOVVKZ_bmloca*YPHJKOVVKZ_bmlocnumx
set YPHJKOVVKZ_bmloca=256
endif
set YPHJKOVVKZ_bmloca=YPHJKOVVKZ_bmloca+1
endloop
set YPHJKOVVKZ_bmlocb=YPHJKOVVKZ_bmlocb+1
endloop
return YPHJKOVVKZ_result
endfunction

function YPHJKOVVKZ_Item_Loop2 takes nothing returns nothing
local integer YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_Item_Index[0]
local integer YPHJKOVVKZ_bmlocc3=48
local integer YPHJKOVVKZ_bmlocc4=48
local integer YPHJKOVVKZ_bmlocid=0
local item YPHJKOVVKZ_bmlocit
loop
exitwhen YPHJKOVVKZ_bmlocc3>90
set YPHJKOVVKZ_bmlocc4=48
loop
exitwhen YPHJKOVVKZ_bmlocc4>90
set YPHJKOVVKZ_bmlocid=(256*256*256*YPHJKOVVKZ_Item_Index[1])+(256*256*YPHJKOVVKZ_Item_Index[2])+(256*YPHJKOVVKZ_bmlocc3)+YPHJKOVVKZ_bmlocc4
set YPHJKOVVKZ_bmlocit=CreateItem(YPHJKOVVKZ_bmlocid,0,0)
if YPHJKOVVKZ_bmlocit!=null then
call RemoveItem(YPHJKOVVKZ_bmlocit)
set YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_bmlocc+1
set YPHJKOVVKZ_ItemTypeId[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocid
set YPHJKOVVKZ_ItemName[YPHJKOVVKZ_bmlocc]=GetObjectName(YPHJKOVVKZ_bmlocid)
endif
if YPHJKOVVKZ_bmlocc4==57 then
set YPHJKOVVKZ_bmlocc4=65
else
set YPHJKOVVKZ_bmlocc4=YPHJKOVVKZ_bmlocc4+1
endif
endloop
if YPHJKOVVKZ_bmlocc3==57 then
set YPHJKOVVKZ_bmlocc3=65
else
set YPHJKOVVKZ_bmlocc3=YPHJKOVVKZ_bmlocc3+1
endif
endloop
set YPHJKOVVKZ_Item_Index[0]=YPHJKOVVKZ_bmlocc
set YPHJKOVVKZ_bmlocit=null
endfunction

function YPHJKOVVKZ_Item_Loop1 takes nothing returns nothing
local integer YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_Item_Index[0]
local integer YPHJKOVVKZ_bmlocc3=48
local integer YPHJKOVVKZ_bmlocc4=48
local integer YPHJKOVVKZ_bmlocid=0
local item YPHJKOVVKZ_bmlocit
loop
exitwhen YPHJKOVVKZ_bmlocc3>=123
set YPHJKOVVKZ_bmlocc4=48
loop
exitwhen YPHJKOVVKZ_bmlocc4>=123
set YPHJKOVVKZ_bmlocid=(256*256*256*YPHJKOVVKZ_Item_Index[1])+(256*256*YPHJKOVVKZ_Item_Index[2])+(256*YPHJKOVVKZ_bmlocc3)+YPHJKOVVKZ_bmlocc4
set YPHJKOVVKZ_bmlocit=CreateItem(YPHJKOVVKZ_bmlocid,0,0)
if YPHJKOVVKZ_bmlocit!=null then
call RemoveItem(YPHJKOVVKZ_bmlocit)
set YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_bmlocc+1
set YPHJKOVVKZ_ItemTypeId[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocid
set YPHJKOVVKZ_ItemName[YPHJKOVVKZ_bmlocc]=GetObjectName(YPHJKOVVKZ_bmlocid)
endif
if YPHJKOVVKZ_bmlocc4==57 then
set YPHJKOVVKZ_bmlocc4=97
else
set YPHJKOVVKZ_bmlocc4=YPHJKOVVKZ_bmlocc4+1
endif
endloop
if YPHJKOVVKZ_bmlocc3==57 then
set YPHJKOVVKZ_bmlocc3=97
else
set YPHJKOVVKZ_bmlocc3=YPHJKOVVKZ_bmlocc3+1
endif
endloop
set YPHJKOVVKZ_Item_Index[0]=YPHJKOVVKZ_bmlocc
set YPHJKOVVKZ_bmlocit=null
endfunction

function YPHJKOVVKZ_Item_Name_Start takes nothing returns nothing
if YPHJKOVVKZ_Item_Index[1]==73 then
call YPHJKOVVKZ_Item_Loop2()
if YPHJKOVVKZ_Item_Index[2]>=90 then
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
call PauseTimer(YPHJKOVVKZ_Item_tm)
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00搜索结束，共找到物品：|r|cffff0000"+I2S(YPHJKOVVKZ_Item_Index[0]))
call DestroyTimer(YPHJKOVVKZ_Item_tm)
elseif YPHJKOVVKZ_Item_Index[2]==57 then
set YPHJKOVVKZ_Item_Index[2]=65
else
set YPHJKOVVKZ_Item_Index[2]=YPHJKOVVKZ_Item_Index[2]+1
endif
else
call YPHJKOVVKZ_Item_Loop1()
if YPHJKOVVKZ_Item_Index[2]==57 then
set YPHJKOVVKZ_Item_Index[2]=97
else
set YPHJKOVVKZ_Item_Index[2]=YPHJKOVVKZ_Item_Index[2]+1
endif
if YPHJKOVVKZ_Item_Index[2]>=123 then
set YPHJKOVVKZ_Item_Index[2]=48
set YPHJKOVVKZ_Item_Index[1]=YPHJKOVVKZ_Item_Index[1]+1
endif
if YPHJKOVVKZ_Item_Index[1]>=123 then
set YPHJKOVVKZ_Item_Index[1]=73
endif
endif
endfunction

function YPHJKOVVKZ_Item_Name takes nothing returns nothing
local timer YPHJKOVVKZ_bmloct=CreateTimer()
set YPHJKOVVKZ_Item_Index[1]=97
set YPHJKOVVKZ_Item_Index[2]=48
set YPHJKOVVKZ_Item_Index[0]=0
//********************************
//要提高搜索速度修改下面的0.01数值，修改为0.007时，总搜索速度为6.804
call TimerStart(YPHJKOVVKZ_bmloct,0.005,true,function YPHJKOVVKZ_Item_Name_Start)
//Up
//********************************
set YPHJKOVVKZ_bmloct=null
endfunction

function YPHJKOVVKZ_CleanItem_Fun takes nothing returns nothing
if IsItemVisible(GetEnumItem()) then
if GetWidgetLife(GetEnumItem())<=0.401 then
call SetWidgetLife(GetEnumItem(),1)
endif
call RemoveItem(GetEnumItem())
endif
endfunction
function YPHJKOVVKZ_CleanItem takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function YPHJKOVVKZ_CleanItem_Fun)
endfunction

function YPHJKOVVKZ_ItemName_Init takes nothing returns nothing
if YPHJKOVVKZ_TOF[7777] then
set YPHJKOVVKZ_TOF[7777]=false
call YPHJKOVVKZ_Item_Name()
set YPHJKOVVKZ_Item_tm=CreateTimer()
call TimerStart(YPHJKOVVKZ_Item_tm,20,false,null)
endif
endfunction

function YPHJKOVVKZ_Item_Query takes nothing returns nothing
local integer YPHJKOVVKZ_bmloci=1
local integer YPHJKOVVKZ_bmlocc=0
local string YPHJKOVVKZ_bmlocs=GetEventPlayerChatString()
local integer YPHJKOVVKZ_bmlock=StringLength(YPHJKOVVKZ_bmlocs)
local integer YPHJKOVVKZ_bmlocpage=YPHJKOVVKZ_Item_Page[GetPlayerId(GetTriggerPlayer())]
local integer totalpage=YPHJKOVVKZ_Item_Index[0]/75+1
local string array YPHJKOVVKZ_bmlocname
if(YPHJKOVVKZ_bmlocs=="-ucx")then

if YPHJKOVVKZ_TOF[7777] then
set YPHJKOVVKZ_bmlocs=null
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00开始地图内物品查找，请耐心等待！")
call YPHJKOVVKZ_ItemName_Init()
return
endif
if YPHJKOVVKZ_bmlocpage>=totalpage then
set YPHJKOVVKZ_bmlocpage=1
else
set YPHJKOVVKZ_bmlocpage=YPHJKOVVKZ_bmlocpage+1
endif
else
if(S2I(SubString(YPHJKOVVKZ_bmlocs,6,YPHJKOVVKZ_bmlock))>totalpage)then
if YPHJKOVVKZ_bmlocpage>=totalpage then
set YPHJKOVVKZ_bmlocpage=totalpage
else
set YPHJKOVVKZ_bmlocpage=YPHJKOVVKZ_bmlocpage+1
endif
else
if(S2I(SubString(YPHJKOVVKZ_bmlocs,6,YPHJKOVVKZ_bmlock))>0)then
set YPHJKOVVKZ_bmlocpage=S2I(SubString(YPHJKOVVKZ_bmlocs,6,YPHJKOVVKZ_bmlock))
endif
endif
endif
if YPHJKOVVKZ_bmlocpage==0 then
set YPHJKOVVKZ_bmlocpage=1
endif
set YPHJKOVVKZ_Item_Page[GetPlayerId(GetTriggerPlayer())]=YPHJKOVVKZ_bmlocpage
loop
exitwhen YPHJKOVVKZ_bmlocc>14
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]+YPHJKOVVKZ_ItemName[(YPHJKOVVKZ_bmlocpage-1)*75+1+(YPHJKOVVKZ_bmlocc*5)]+" |cffff0000"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_ItemTypeId[(YPHJKOVVKZ_bmlocpage-1)*75+1+(YPHJKOVVKZ_bmlocc*5)])+"|r "
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]+YPHJKOVVKZ_ItemName[(YPHJKOVVKZ_bmlocpage-1)*75+2+(YPHJKOVVKZ_bmlocc*5)]+" |cffff0000"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_ItemTypeId[(YPHJKOVVKZ_bmlocpage-1)*75+2+(YPHJKOVVKZ_bmlocc*5)])+"|r "
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]+YPHJKOVVKZ_ItemName[(YPHJKOVVKZ_bmlocpage-1)*75+3+(YPHJKOVVKZ_bmlocc*5)]+" |cffff0000"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_ItemTypeId[(YPHJKOVVKZ_bmlocpage-1)*75+3+(YPHJKOVVKZ_bmlocc*5)])+"|r "
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]+YPHJKOVVKZ_ItemName[(YPHJKOVVKZ_bmlocpage-1)*75+4+(YPHJKOVVKZ_bmlocc*5)]+" |cffff0000"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_ItemTypeId[(YPHJKOVVKZ_bmlocpage-1)*75+4+(YPHJKOVVKZ_bmlocc*5)])+"|r "
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]+YPHJKOVVKZ_ItemName[(YPHJKOVVKZ_bmlocpage-1)*75+5+(YPHJKOVVKZ_bmlocc*5)]+" |cffff0000"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_ItemTypeId[(YPHJKOVVKZ_bmlocpage-1)*75+5+(YPHJKOVVKZ_bmlocc*5)])+"|r "
set YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_bmlocc+1
endloop
set YPHJKOVVKZ_bmlocc=0
loop
exitwhen YPHJKOVVKZ_bmlocc>14
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc])
set YPHJKOVVKZ_bmlocname[YPHJKOVVKZ_bmlocc]=null
set YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_bmlocc+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+I2S(YPHJKOVVKZ_bmlocpage)+"/"+I2S(totalpage)+" |r|CFF0000FF页|r|CFFFF0000查询|r"+" |r|CFFFF6600输入-uci+空格+物品ID，可获得物品。"))
set YPHJKOVVKZ_bmlocs=null
endfunction

function YPHJKOVVKZ_PlayerBag takes nothing returns boolean
local integer YPHJKOVVKZ_bmlocc = 0
local integer YPHJKOVVKZ_bmloci = 0
local integer YPHJKOVVKZ_bmlocpi = GetPlayerId(GetTriggerPlayer())
local integer YPHJKOVVKZ_bmlocbt = YPHJKOVVKZ_BagTotal[YPHJKOVVKZ_bmlocpi]
if GetWidgetLife(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]) > 1 and YPHJKOVVKZ_bmlocbt>1 and IsUnitType(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi],ConvertUnitType(0)) and GetOwningPlayer(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]) == Player(YPHJKOVVKZ_bmlocpi) then
loop
exitwhen YPHJKOVVKZ_bmlocc > 5
set YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc] = UnitItemInSlot(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi],YPHJKOVVKZ_bmlocc)
call SetItemPlayer( YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc],Player(YPHJKOVVKZ_bmlocpi), true )
call SetItemPosition( YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc], GetUnitX(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]), GetUnitY(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]) )
call SetItemVisible( YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc], false )
if YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc] != null then
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00将：|r"+GetItemName(YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc])+" |cffffcc00物品ID：|r"+YPHJKOVVKZ_ID2S(GetItemTypeId(YPHJKOVVKZ_BagItem[YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc]))+" |cffffcc00放入背包中！|r"))
endif
loop
exitwhen YPHJKOVVKZ_bmloci == YPHJKOVVKZ_bmlocbt
set YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*(YPHJKOVVKZ_bmlocbt-YPHJKOVVKZ_bmloci))] = YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*(YPHJKOVVKZ_bmlocbt-YPHJKOVVKZ_bmloci-1))]
set YPHJKOVVKZ_BagItemId[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*(YPHJKOVVKZ_bmlocbt-YPHJKOVVKZ_bmloci))]=GetItemTypeId(YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*(YPHJKOVVKZ_bmlocbt-YPHJKOVVKZ_bmloci-1))])
set YPHJKOVVKZ_bmloci =YPHJKOVVKZ_bmloci+ 1
endloop
set YPHJKOVVKZ_bmloci=0
set YPHJKOVVKZ_bmlocc = YPHJKOVVKZ_bmlocc + 1
endloop
set YPHJKOVVKZ_bmlocc=0
loop
exitwhen YPHJKOVVKZ_bmlocc > 5
if YPHJKOVVKZ_BagItemId[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)]!=0 then
if YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)] != null then
call UnitAddItem( YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi], YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)])
call SetItemVisible( YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)],true)
call SetItemPlayer( YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)], Player(15), true )
else
set YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)]=CreateItem(YPHJKOVVKZ_BagItemId[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)],GetUnitX(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]),GetUnitY(YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi]))
call UnitAddItem( YPHJKOVVKZ_HERO[YPHJKOVVKZ_bmlocpi],YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)]) 
endif
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00从背包中取出：|r"+GetItemName(YPHJKOVVKZ_BagItem[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)])+" |cffffcc00物品ID：|r"+YPHJKOVVKZ_ID2S(YPHJKOVVKZ_BagItemId[(YPHJKOVVKZ_bmlocpi*6+YPHJKOVVKZ_bmlocc)+(72*YPHJKOVVKZ_bmlocbt)])))
endif
set YPHJKOVVKZ_bmlocc = YPHJKOVVKZ_bmlocc + 1
endloop
endif
return false
endfunction

function YPHJKOVVKZ_Bag_Ini takes integer YPHJKOVVKZ_bmlocpi,integer YPHJKOVVKZ_bmloci returns nothing
call DestroyTrigger(YPHJKOVVKZ_BagTrigger[YPHJKOVVKZ_bmlocpi])
set YPHJKOVVKZ_BagTrigger[YPHJKOVVKZ_bmlocpi]=CreateTrigger()
call TriggerRegisterPlayerEvent(YPHJKOVVKZ_BagTrigger[YPHJKOVVKZ_bmlocpi],Player(YPHJKOVVKZ_bmlocpi),ConvertPlayerEvent(YPHJKOVVKZ_bmloci))
call TriggerAddCondition(YPHJKOVVKZ_BagTrigger[YPHJKOVVKZ_bmlocpi], Condition(function YPHJKOVVKZ_PlayerBag))
endfunction

function YPHJKOVVKZ__ONOFF takes nothing returns nothing

endfunction 

function YPHJKOVVKZ_Selection takes nothing returns nothing
set YPHJKOVVKZ_HERO[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction

function YPHJKOVVKZ_BigMan takes nothing returns nothing
local trigger YPHJKOVVKZ_bmloctrgO = CreateTrigger()
local trigger YPHJKOVVKZ_bmloctrig = CreateTrigger()
local trigger YPHJKOVVKZ_bmloctrgI = CreateTrigger()
local integer YPHJKOVVKZ_bmlocc=0
set YPHJKOVVKZ_AllString=".................................!.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
set YPHJKOVVKZ_TOF[7777]=true
loop
exitwhen YPHJKOVVKZ_bmlocc>11
call TriggerRegisterPlayerUnitEvent(YPHJKOVVKZ_bmloctrig,Player(YPHJKOVVKZ_bmlocc),ConvertPlayerUnitEvent(24), null)

call TriggerRegisterPlayerChatEvent(YPHJKOVVKZ_bmloctrgI, Player(YPHJKOVVKZ_bmlocc), "-ucx", false )
set YPHJKOVVKZ_BagTrigger[YPHJKOVVKZ_bmlocc]=null
set YPHJKOVVKZ_Item_Page[YPHJKOVVKZ_bmlocc]=1
set YPHJKOVVKZ_bmlocc=YPHJKOVVKZ_bmlocc+1
endloop
call TriggerAddAction(YPHJKOVVKZ_bmloctrig,function YPHJKOVVKZ_Selection)

call TriggerAddAction(YPHJKOVVKZ_bmloctrgI,function YPHJKOVVKZ_Item_Query)
set YPHJKOVVKZ_Str[8100]= "|cFFFF0c0c"
set YPHJKOVVKZ_Str[8101]= "|cFF0c0cFF"
set YPHJKOVVKZ_Str[8102]= "|cFF400000"
set YPHJKOVVKZ_Str[8103]= "|cFF0EEEEE"
set YPHJKOVVKZ_Str[8104]= "|cFF0EEE00"
set YPHJKOVVKZ_Str[8105]= "|cFF7DDDFF"
set YPHJKOVVKZ_Str[8106]= "|cFF888888"
set YPHJKOVVKZ_Str[8107]= "|cFFF77700"
set YPHJKOVVKZ_Str[8108]= "|cFFF222FF"
set YPHJKOVVKZ_Str[8109]= "|cFF700077"
set YPHJKOVVKZ_Str[8110]= "|cFFF00000"
set YPHJKOVVKZ_Str[8111]= "|cFFFFFF00"
set YPHJKOVVKZ_bmloctrgO=null
set YPHJKOVVKZ_bmloctrgI=null
set YPHJKOVVKZ_bmloctrig=null
endfunction