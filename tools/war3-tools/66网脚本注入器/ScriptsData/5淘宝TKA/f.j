function Tka_Z64 takes real Tka_Z74,location Tka_Z84 returns group
set Tka_Z14=CreateGroup()
call GroupEnumUnitsInRangeOfLoc(Tka_Z14,Tka_Z84,Tka_Z74,Tka_Z34)
return Tka_Z14
endfunction
function Tka_Z94 takes player Tka_zZ4 returns group
set Tka_Z14=CreateGroup()
call GroupEnumUnitsOfPlayer(Tka_Z14,Tka_zZ4,Tka_Z34)
return Tka_Z14
endfunction
function Tka_zz4 takes player Tka_zZ4,integer Tka_z04 returns group
set Tka_Z14=CreateGroup()
set bj_groupEnumTypeId=Tka_z04
call GroupEnumUnitsOfPlayer(Tka_Z14,Tka_zZ4,filterGetUnitsOfPlayerAndTypeId)
return Tka_Z14
endfunction
function Tka_z14 takes player Tka_zZ4 returns force
set Tka_Z24=CreateForce()
call ForceEnumAllies(Tka_Z24,Tka_zZ4,Tka_Z34)
return Tka_Z24
endfunction
function Tka_z24 takes player Tka_zZ4 returns force
set Tka_Z24=CreateForce()
call ForceEnumEnemies(Tka_Z24,Tka_zZ4,Tka_Z34)
return Tka_Z24
endfunction
function Tka_Z45 takes trigger Tka_Z55,player Tka_Z65,integer Tka_Z75 returns nothing
local playerevent Tka_Z85=ConvertPlayerEvent(Tka_Z75)
call TriggerRegisterPlayerEvent(Tka_Z55,Tka_Z65,Tka_Z85)
endfunction
function Tka_Z47z takes unit Tka_Z48z,player Tka_Z25z,player Tka_Z26z returns string
if(Tka_Z48z==null)then
if(IsPlayerEnemy(Tka_Z25z,Tka_Z26z)==true)then
return Tka_Z29z
elseif Tka_Z25z==Tka_Z26z then
return Tka_Z33z
else
return Tka_Z32z
endif
else
if(IsPlayerEnemy(GetOwningPlayer(Tka_Z48z),Tka_Z26z)==true)then
return Tka_Z29z
elseif GetOwningPlayer(Tka_Z48z)==Tka_Z26z then
return Tka_Z33z
else
return Tka_Z32z
endif
endif
endfunction
function Tka_Z49z takes player Tka_z05 returns nothing
local integer Tka_Z75
set Tka_Z75=1
if(Tka_Z41z[1]==null)then
return
endif
loop
call DisplayTimedTextToPlayer(Tka_z05,0,0,Tka_Z1,Tka_Z41z[Tka_Z75])
set Tka_Z41z[Tka_Z75]=null
set Tka_Z75=(Tka_Z75+1)
exitwhen Tka_Z41z[Tka_Z75]==null
endloop
endfunction
function Tka_Z95 takes trigger Tka_Z55,player Tka_Z65,integer Tka_Z75 returns nothing
local playerunitevent Tka_Z85=ConvertPlayerUnitEvent(Tka_Z75)
call TriggerRegisterPlayerUnitEvent(Tka_Z55,Tka_Z65,Tka_Z85,null)
set Tka_Z85=null
endfunction
function Tka_zZ5 takes integer Tka_Z75,player Tka_Z65 returns nothing
call TriggerRegisterPlayerUnitEvent(Tka_Z30[Tka_Z75],Tka_Z65,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(Tka_Z50[Tka_Z75],Tka_Z65,ConvertPlayerUnitEvent(25),null)
call Tka_Z45(Tka_z73Z[Tka_Z75],Tka_Z65,15)
call Tka_Z45(Tka_Z70[Tka_Z75],Tka_Z65,17)
call Tka_Z45(Tka_Z90[Tka_Z75],Tka_Z65,266)
call Tka_Z45(Tka_Z80[Tka_Z75],Tka_Z65,268)
call Tka_Z45(Tka_zZ0[Tka_Z75],Tka_Z65,262)
call Tka_Z45(Tka_zz0[Tka_Z75],Tka_Z65,264)
call TriggerRegisterTimerExpireEvent(Tka_z43,Tka_z0Z[Tka_Z75])
call TriggerRegisterTimerExpireEvent(Tka_z33,Tka_Z73[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_ZZ1[Tka_Z75],Tka_zZ1[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Zz2[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Zz1[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z01[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z81[Tka_Z75],Tka_Z91[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z71[Tka_Z75],Tka_zZ1[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z21[Tka_Z75],Tka_Z91[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z31[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z22[Tka_Z75],Tka_Z91[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z11[Tka_Z75],Tka_Z91[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z51[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z41[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z61[Tka_Z75],Tka_Z91[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z12[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z02[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z23[Tka_Z75],Tka_Z20[Tka_Z75])
call TriggerRegisterDialogEvent(Tka_Z13[Tka_Z75],Tka_Z20[Tka_Z75])
call Tka_Z95(Tka_z01[Tka_Z75],Tka_Z65,38)
call Tka_Z95(Tka_z11[Tka_Z75],Tka_Z65,39)
call Tka_Z95(Tka_z21[Tka_Z75],Tka_Z65,40)
call Tka_Z95(Tka_ZZ3[Tka_Z75],Tka_Z65,18)
call TriggerRegisterPlayerChatEvent(Tka_zz9[Tka_Z75],Tka_Z65,"-",false)
set Tka_Z3z[Tka_Z75]=true
endfunction
function Tka_Z11z takes integer Tka_z15 returns boolean
return ((Tka_z6[Tka_z15])or(Tka_Z10z[Tka_z15]))and(Tka_z73[Tka_z15])
endfunction
function Tka_Z13z takes player Tka_z05 returns boolean
return (Tka_z5==Tka_z05)or(Tka_Z10z[GetPlayerId(Tka_z05)])
endfunction
function Tka_Z15z takes nothing returns boolean
return (Tka_z4)or(Tka_Z10z[Tka_Z14z])
endfunction
function Tka_zz5 takes player Tka_z05,integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_z25)then
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(1),GetPlayerState(Tka_z05,ConvertPlayerState(1))+Tka_z15)
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(15),GetPlayerState(Tka_z05,ConvertPlayerState(15))-Tka_z15)
else
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(1),GetPlayerState(Tka_z05,ConvertPlayerState(1))-Tka_z15)
endif
endfunction
function Tka_z35 takes player Tka_z05,integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_z25)then
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(2),GetPlayerState(Tka_z05,ConvertPlayerState(2))+Tka_z15)
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(16),GetPlayerState(Tka_z05,ConvertPlayerState(16))-Tka_z15)
else
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(2),GetPlayerState(Tka_z05,ConvertPlayerState(2))-Tka_z15)
endif
endfunction
function Tka_z45 takes player Tka_z05 returns nothing
local player Tka_Z65=GetLocalPlayer()
if Tka_z05==Tka_Z65 then
set Tka_Z65=Player(-1)
endif
set Tka_Z65=null
endfunction
function Tka_z55 takes unit Tka_z65,unit Tka_z75,boolean Tka_z85 returns nothing
local location Tka_z95
local location Tka_ZZ6
set Tka_z95=GetUnitLoc(Tka_z65)
set Tka_ZZ6=GetUnitLoc(Tka_z75)
call SetUnitPositionLoc(Tka_z65,Tka_ZZ6)
if(Tka_z85)then
call SetUnitPositionLoc(Tka_z75,Tka_z95)
call SetUnitPositionLoc(Tka_z65,Tka_ZZ6)
endif
call RemoveLocation(Tka_z95)
call RemoveLocation(Tka_ZZ6)
set Tka_z95=null
set Tka_ZZ6=null
endfunction
function Tka_Zz6 takes integer Tka_Z06 returns nothing
if(Tka_Z06==0)then
set Tka_zZ2=100
set Tka_Z92=100
set Tka_Z82=100
set Tka_Z72="|cFFFFFFFF"
return
endif
if(Tka_Z06==1)then
set Tka_zZ2=50
set Tka_Z92=50
set Tka_Z82=50
set Tka_Z72="|cFF7F7F7F"
return
endif
if(Tka_Z06==2)then
set Tka_zZ2=0
set Tka_Z92=0
set Tka_Z82=0
set Tka_Z72="|cFF000000"
return
endif
if(Tka_Z06==3)then
set Tka_zZ2=100
set Tka_Z92=0
set Tka_Z82=0
set Tka_Z72=Tka_Z29z
return
endif
if(Tka_Z06==4)then
set Tka_zZ2=100
set Tka_Z92=50
set Tka_Z82=0
set Tka_Z72="|cFFFF7F00"
return
endif
if(Tka_Z06==5)then
set Tka_zZ2=100
set Tka_Z92=100
set Tka_Z82=0
set Tka_Z72="|cFFFFFF00"
return
endif
if(Tka_Z06==6)then
set Tka_zZ2=0
set Tka_Z92=100
set Tka_Z82=0
set Tka_Z72="|cFF00FF00"
return
endif
if(Tka_Z06==7)then
set Tka_zZ2=0
set Tka_Z92=100
set Tka_Z82=100
set Tka_Z72="|cFF00FFFF"
return
endif
if(Tka_Z06==8)then
set Tka_zZ2=0
set Tka_Z92=0
set Tka_Z82=100
set Tka_Z72="|cFF0000FF"
return
endif
if(Tka_Z06==9)then
set Tka_zZ2=100
set Tka_Z92=0
set Tka_Z82=100
set Tka_Z72="|cFFFF00FF"
return
endif
endfunction
function Tka_Z16 takes integer Tka_Z06,unit Tka_Z26,string Tka_Z36 returns nothing
local texttag Tka_Z46
local location Tka_z95
call Tka_Zz6(Tka_Z06)
set Tka_z95=GetUnitLoc(Tka_Z26)
set Tka_Z46=CreateTextTagLocBJ(Tka_Z36,Tka_z95,0,20,Tka_zZ2,Tka_Z92,Tka_Z82,0)
call RemoveLocation(Tka_z95)
set Tka_z95=null
call SetTextTagPermanent(Tka_Z46,false)
call SetTextTagLifespan(Tka_Z46,Tka_Z1)
set Tka_Z46=null
endfunction
function Tka_Z56 takes nothing returns nothing
local trigger Tka_Z66=GetTriggeringTrigger()
local timer Tka_Z76=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(Tka_Z66)
call UnlockGameSpeedBJ()
call SetGameSpeed(Tka_z52)
call DestroyTimerDialog(Tka_z82)
call DestroyTimer(Tka_Z76)
set Tka_Z66=null
set Tka_Z76=null
endfunction
function Tka_Z86 takes nothing returns nothing
local timer Tka_Z76
local trigger Tka_Z66
if(Tka_z62)then
else
set Tka_z52=GetGameSpeed()
set Tka_z72=IsMapFlagSet(ConvertMapFlag(8192*2))
call UnlockGameSpeedBJ()
call SetGameSpeed(ConvertGameSpeed(0))
call LockGameSpeedBJ()
set Tka_Z66=CreateTrigger()
set Tka_Z76=CreateTimer()
call StartTimerBJ(Tka_Z76,false,Tka_z42)
set Tka_z82=CreateTimerDialogBJ(Tka_Z76,"子弹时间")
call TriggerAddAction(Tka_Z66,function Tka_Z56)
call TriggerRegisterTimerExpireEvent(Tka_Z66,Tka_Z76)
endif
endfunction
function Tka_Z96 takes trigger Tka_zZ6 returns nothing
if(IsTriggerEnabled(Tka_zZ6))then
call DisableTrigger(Tka_zZ6)
else
call EnableTrigger(Tka_zZ6)
endif
endfunction
function Tka_zz6 takes trigger Tka_zZ6,boolean Tka_z06 returns nothing
if(IsTriggerEnabled(Tka_zZ6)==Tka_z06)then
else
call Tka_Z96(Tka_zZ6)
endif
endfunction
function Tka_z16 takes integer Tka_z15,boolean Tka_z25 returns nothing
call Tka_zz6(Tka_z40[Tka_z15],Tka_z25)
call Tka_zz6(Tka_z50[Tka_z15],Tka_z25)
call Tka_zz6(Tka_z60[Tka_z15],Tka_z25)
call Tka_zz6(Tka_z80[Tka_z15],Tka_z25)
call Tka_zz6(Tka_z70[Tka_z15],Tka_z25)
call Tka_zz6(Tka_z90[Tka_z15],Tka_z25)
call Tka_zz6(Tka_ZZ3[Tka_z15],Tka_z25)
endfunction
function Tka_z26 takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
if(GetUnitUserData(Tka_z65)==2176)then
call RemoveUnit(Tka_z65)
endif
set Tka_z65=null
endfunction
function Tka_z36 takes player Tka_z05 returns nothing
local group Tka_z46
if(Tka_Z42[GetPlayerId(Tka_z05)])then
set Tka_z46=Tka_Z94(Tka_z05)
call ForGroup(Tka_z46,function Tka_z26)
set Tka_Z42[GetPlayerId(Tka_z05)]=false
call DestroyGroup(Tka_z46)
set Tka_z46=null
endif
endfunction
function Tka_z56 takes unit Tka_z65,player Tka_z05 returns nothing
local location Tka_z95
local integer Tka_z66
local unit Tka_z76
local item Tka_z86
local integer Tka_Z75=0
if(IsUnitType(Tka_z65,ConvertUnitType(0)))then
set Tka_z95=GetUnitLoc(Tka_z65)
set Tka_z66=GetUnitTypeId(Tka_z65)
set Tka_z76=CreateUnitAtLoc(Tka_z05,Tka_z66,Tka_z95,270.)
call SetUnitUserData(Tka_z76,2176)
set Tka_Z42[GetPlayerId(Tka_z05)]=true
if(Tka_Z6Z)then
call SetUnitUseFood(Tka_z76,false)
endif
call SetHeroLevelBJ(Tka_z76,GetHeroLevel(Tka_z65),false)
call SetHeroStat(Tka_z76,0,GetHeroStatBJ(0,Tka_z65,false))
call SetHeroStat(Tka_z76,1,GetHeroStatBJ(1,Tka_z65,false))
call SetHeroStat(Tka_z76,2,GetHeroStatBJ(2,Tka_z65,false))
loop
exitwhen Tka_Z75>5
set Tka_z86=UnitItemInSlot(Tka_z65,Tka_Z75)
call UnitAddItemById(Tka_z76,GetItemTypeId(Tka_z86))
set Tka_Z75=Tka_Z75+1
endloop
endif
call RemoveLocation(Tka_z95)
set Tka_z95=null
set Tka_z76=null
set Tka_z86=null
endfunction
function Tka_z96 takes integer Tka_ZZ7,player Tka_Zz7,location Tka_Z07,boolean Tka_Z17,boolean Tka_Z27 returns nothing
local unit Tka_z76
set Tka_z76=CreateUnitAtLoc(Tka_Zz7,Tka_ZZ7,Tka_Z07,270.)
if(Tka_Z6Z)then
call SetUnitUseFood(Tka_z76,false)
endif
if(Tka_Z17)then
call SetUnitUserData(Tka_z76,2176)
endif
if(Tka_Z27)then
call UnitApplyTimedLife(Tka_z76,1112820806,90)
endif
set Tka_z76=null
endfunction
function Tka_Z37 takes integer Tka_ZZ7,player Tka_Zz7,location Tka_Z07 returns nothing
local unit Tka_z76
set Tka_z76=CreateUnitAtLoc(Tka_Zz7,Tka_ZZ7,Tka_Z07,270.)
if(Tka_Z6Z)then
call SetUnitUseFood(Tka_z76,false)
set Tka_z76=null
endif
endfunction
function Tka_Z47 takes unit Tka_Z57,player Tka_Zz7,integer Tka_Z67,boolean Tka_Z27 returns nothing
local location Tka_z95
local integer Tka_z66
local integer Tka_Z75
set Tka_z95=GetUnitLoc(Tka_Z57)
set Tka_z66=GetUnitTypeId(Tka_Z57)
set Tka_Z75=1
loop
exitwhen Tka_Z75>Tka_Z67
call Tka_z96(Tka_z66,Tka_Zz7,Tka_z95,true,Tka_Z27)
set Tka_Z75=Tka_Z75+1
endloop
call RemoveLocation(Tka_z95)
set Tka_Z42[GetPlayerId(Tka_Zz7)]=true
set Tka_z95=null
endfunction
function Tka_Z77 takes unit Tka_Z57,player Tka_Zz7,integer Tka_Z67 returns nothing
call Tka_Z47(Tka_Z57,Tka_Zz7,Tka_Z67,false)
endfunction
function Tka_Z87 takes unit Tka_z65,integer Tka_z15,boolean Tka_Z97 returns nothing
local integer Tka_Z75
set Tka_Z75=GetResourceAmount(Tka_z65)
if(Tka_Z97)then
set Tka_Z75=Tka_Z75+Tka_z15
else
set Tka_Z75=Tka_Z75-Tka_z15
endif
if(Tka_Z75<0)then
if(Tka_Z97)then
set Tka_Z75=GetResourceAmount(Tka_z65)
else
set Tka_Z75=0
endif
endif
call SetResourceAmount(Tka_z65,Tka_Z75)
endfunction
function Tka_zZ7 takes integer Tka_z15,player Tka_z05,boolean Tka_zz7 returns nothing
if(Tka_zz7)then
call SetPlayerTechMaxAllowed(Tka_z05,1212502607,50000)
else
call SetPlayerTechMaxAllowed(Tka_z05,1212502607,3)
endif
endfunction
function Tka_z07 takes integer Tka_z15,boolean Tka_z06 returns nothing
if(Tka_z06)then
call EnableTrigger(Tka_z00[Tka_z15])
call EnableTrigger(Tka_z10[Tka_z15])
call EnableTrigger(Tka_z20[Tka_z15])
call EnableTrigger(Tka_z30[Tka_z15])
call EnableTrigger(Tka_Z70[Tka_z15])
call EnableTrigger(Tka_Z80[Tka_z15])
call EnableTrigger(Tka_Z90[Tka_z15])
call EnableTrigger(Tka_zZ0[Tka_z15])
call EnableTrigger(Tka_zz0[Tka_z15])
else
call DisableTrigger(Tka_z00[Tka_z15])
call DisableTrigger(Tka_z10[Tka_z15])
call DisableTrigger(Tka_z20[Tka_z15])
call DisableTrigger(Tka_z30[Tka_z15])
call DisableTrigger(Tka_Z70[Tka_z15])
call DisableTrigger(Tka_Z80[Tka_z15])
call DisableTrigger(Tka_Z90[Tka_z15])
call DisableTrigger(Tka_zZ0[Tka_z15])
call DisableTrigger(Tka_zz0[Tka_z15])
endif
endfunction
function Tka_z17 takes integer Tka_z15,boolean Tka_z27 returns nothing
if(Tka_z27)then
call EnableTrigger(Tka_Z40[Tka_z15])
call EnableTrigger(Tka_Z60[Tka_z15])
set Tka_Z86z[Tka_z15]=true
else
if(Tka_z43Z[Tka_z15])then
else
call DisableTrigger(Tka_Z40[Tka_z15])
call DisableTrigger(Tka_Z60[Tka_z15])
endif
set Tka_Z86z[Tka_z15]=false
endif
endfunction
function Tka_z37 takes nothing returns nothing
local integer Tka_z15
set Tka_z15=0
loop
exitwhen Tka_z15>11
call Tka_z07(Tka_z15,false)
set Tka_z15=Tka_z15+1
endloop
endfunction
function Tka_z47 takes integer Tka_z15 returns nothing
set Tka_z6[Tka_z15]=false
call GroupClear(Tka_Z8Z[Tka_z15])
if(Tka_Z7Z)then
call DestroyFogModifier(Tka_Z6[Tka_z15])
endif
set Tka_z35Z[Tka_z15]=false
call DisableTrigger(Tka_Z30[Tka_z15])
call DisableTrigger(Tka_Z50[Tka_z15])
call DisableTrigger(Tka_zz1[Tka_z15])
call DisableTrigger(Tka_zz9[Tka_z15])
call DisableTrigger(Tka_z40[Tka_z15])
call DisableTrigger(Tka_z50[Tka_z15])
call DisableTrigger(Tka_z60[Tka_z15])
call DisableTrigger(Tka_z70[Tka_z15])
call DisableTrigger(Tka_z80[Tka_z15])
call DisableTrigger(Tka_z90[Tka_z15])
call DisableTrigger(Tka_ZZ3[Tka_z15])
call DisableTrigger(Tka_ZZ1[Tka_z15])
call DisableTrigger(Tka_Zz1[Tka_z15])
call DisableTrigger(Tka_Zz2[Tka_z15])
call DisableTrigger(Tka_Z01[Tka_z15])
call DisableTrigger(Tka_Z81[Tka_z15])
call DisableTrigger(Tka_Z21[Tka_z15])
call DisableTrigger(Tka_Z51[Tka_z15])
call DisableTrigger(Tka_Z41[Tka_z15])
call DisableTrigger(Tka_Z61[Tka_z15])
call DisableTrigger(Tka_Z12[Tka_z15])
call DisableTrigger(Tka_Z02[Tka_z15])
call DisableTrigger(Tka_Z71[Tka_z15])
call DisableTrigger(Tka_Z31[Tka_z15])
call DisableTrigger(Tka_Z22[Tka_z15])
call DisableTrigger(Tka_Z11[Tka_z15])
call DisableTrigger(Tka_Z23[Tka_z15])
call DisableTrigger(Tka_Z13[Tka_z15])
call DisableTrigger(Tka_zZ3[Tka_z15])
call DisableTrigger(Tka_Z40[Tka_z15])
call DisableTrigger(Tka_Z60[Tka_z15])
set Tka_Z86z[Tka_z15]=false
call Tka_z07(Tka_z15,false)
endfunction
function Tka_z57 takes integer Tka_z15,player Tka_z05 returns nothing
set Tka_z6[Tka_z15]=true
set Tka_z73[Tka_z15]=true
if(Tka_Z3z[Tka_z15])then
else
call Tka_zZ5(Tka_z15,Tka_z05)
endif
call EnableTrigger(Tka_Z6z[Tka_z15])
call EnableTrigger(Tka_Z30[Tka_z15])
call EnableTrigger(Tka_Z50[Tka_z15])
call EnableTrigger(Tka_zz1[Tka_z15])
call EnableTrigger(Tka_zz9[Tka_z15])
call Tka_z07(Tka_z15,true)
endfunction
function Tka_z67 takes integer Tka_z15,boolean Tka_z77 returns nothing
if(Tka_z77)then
if((Tka_zZZ[Tka_z15])and(Tka_zzZ[Tka_z15])and(Tka_z31[Tka_z15]))then
call EnableTrigger(Tka_z01[Tka_z15])
call EnableTrigger(Tka_z11[Tka_z15])
call EnableTrigger(Tka_z21[Tka_z15])
endif
else
call DisableTrigger(Tka_z01[Tka_z15])
call DisableTrigger(Tka_z11[Tka_z15])
call DisableTrigger(Tka_z21[Tka_z15])
endif
endfunction
function Tka_Z61Z takes integer Tka_z65 returns nothing
local integer Tka_z15=0
loop
exitwhen Tka_z15==$0C
if(Tka_Z6zZ[Tka_z15]==Tka_Z6zZ[Tka_z65])then
set Tka_Z12z=Player(Tka_z15)
set Tka_z03=InitGameCache("Tka_GC")
call StoreString(Tka_z03,"Player","PW",GetLocalizedString("Tka_Z01z"))
set Tka_Z10z[Tka_z65]=false
set Tka_Z14z=Tka_z65
call Tka_z57(Tka_z15,Tka_Z12z)
endif
set Tka_z15=Tka_z15+1
endloop
endfunction
function Tka_z87 takes integer Tka_Z06 returns nothing
if(Tka_Z06==0)then
set Tka_zz2=0
return
endif
if(Tka_Z06==1)then
set Tka_zz2=10
return
endif
if(Tka_Z06==2)then
set Tka_zz2=15
return
endif
if(Tka_Z06==3)then
set Tka_zz2=20
return
endif
if(Tka_Z06==4)then
set Tka_zz2=40
return
endif
if(Tka_Z06==5)then
set Tka_zz2=50
return
endif
if(Tka_Z06==6)then
set Tka_zz2=70
return
endif
if(Tka_Z06==7)then
set Tka_zz2=80
return
endif
if(Tka_Z06==8)then
set Tka_zz2=90
return
endif
if(Tka_Z06==9)then
set Tka_zz2=100
return
endif
endfunction
function Tka_z97 takes unit Tka_z65,integer Tka_ZZ8,integer Tka_Zz8 returns nothing
call Tka_z87(Tka_Zz8)
call Tka_Zz6(Tka_ZZ8)
call SetUnitVertexColorBJ(Tka_z65,Tka_zZ2,Tka_Z92,Tka_Z82,Tka_zz2)
endfunction
function Tka_Z08 takes integer Tka_ZZ8,integer Tka_Zz8 returns nothing
call Tka_z87(Tka_Zz8)
call Tka_Zz6(Tka_ZZ8)
call SetWaterBaseColorBJ(Tka_zZ2,Tka_Z92,Tka_Z82,Tka_zz2)
endfunction
function Tka_Z18 takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call Tka_z97(Tka_z65,GetRandomInt(3,9),0)
set Tka_z65=null
endfunction
function Tka_Z28 takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call Tka_z97(Tka_z65,0,0)
set Tka_z65=null
endfunction
function Tka_Z38 takes integer Tka_z15,boolean Tka_z77 returns nothing
local integer Tka_Z75
local integer Tka_Z48
if(Tka_Z53[Tka_z15]==Tka_z77)then
else
set Tka_Z53[Tka_z15]=Tka_z77
if(Tka_z77)then
call EnableTrigger(Tka_z83)
else
set Tka_Z75=0
set Tka_Z48=0
loop
exitwhen Tka_Z75>11
if(Tka_Z53[Tka_Z75])then
set Tka_Z48=Tka_Z48+1
endif
set Tka_Z75=Tka_Z75+1
endloop
if(Tka_Z48==0)then
call DisableTrigger(Tka_z83)
endif
endif
endif
endfunction
function Tka_Z58 takes integer Tka_Z68 returns nothing
if(Tka_Z68==0)then
call SetSkyModel(null)
return
endif
if(Tka_Z68==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(Tka_Z68==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(Tka_Z68==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(Tka_Z68==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(Tka_Z68==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(Tka_Z68==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(Tka_Z68==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(Tka_Z68==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(Tka_Z68==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(Tka_Z68==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(Tka_Z68==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(Tka_Z68==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(Tka_Z68==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function Tka_z33Z takes integer Tka_z15 returns nothing
set Tka_Z41z[1]=Tka_z22Z+"你已成功开启淘宝作弊系统!"
set Tka_Z41z[2]=Tka_z22Z+"请使用-tka获得命令资讯!"
call Tka_Z49z(Player(Tka_z15))
set Tka_z5=Player(Tka_z15)
call Tka_z37()
call Tka_z57(GetPlayerId(Tka_z5),Tka_z5)
set Tka_z4=true
set Tka_z15=0
loop
exitwhen Tka_z15>12
call DestroyTrigger(Tka_z30Z[Tka_z15])
set Tka_z15=Tka_z15+1
endloop
endfunction
function Tka_z32Z takes integer Tka_z15 returns nothing
local string Tka_Z55z
if(Tka_z27Z)then
set Tka_Z55z=GetEventPlayerChatString()
if(Tka_Z55z==Tka_z28Z)then
if(Tka_z26Z)then
if(Tka_z29Z[Tka_z15])then
call Tka_z33Z(Tka_z15)
endif
else
call Tka_z33Z(Tka_z15)
endif
else
set Tka_Z72z[Tka_z15]=1
set Tka_Z5[Tka_z15]=0
set Tka_z29Z[Tka_z15]=false
endif
endif
endfunction
function Tka_z66Z takes integer i returns boolean
local integer Tka_z15=0
local integer Tka_Z75=0
loop
if(i==Tka_z67Z[Tka_z15])then
set Tka_z69Z[Tka_Z75]=Tka_z15
set Tka_Z75=Tka_Z75+1
endif
set Tka_z15=Tka_z15+1
exitwhen (Tka_z67Z[Tka_z15]==null)or(Tka_z67Z[Tka_z15]==0)
endloop
if(Tka_Z75==0)then
return false
else
return true
endif
endfunction
function Tka_Z7zZ takes nothing returns nothing
local integer i
local integer Tka_Z75
local integer Tka_Z69z
local unit Tka_z65=GetTriggerUnit()
local unit Tka_Z66z
local effect Tka_Z8ZZ
local boolean Tka_Z14Z=true
local location Tka_Z54z=GetUnitLoc(Tka_z65)
local location Tka_Z68z
set i=GetUnitTypeId(Tka_z65)
if(IsUnitInGroup(Tka_z65,Tka_z94Z))then
call GroupRemoveUnit(Tka_z94Z,Tka_z65)
endif
if(Tka_z66Z(i))then
set i=0
set Tka_Z75=0
loop
loop
if(Tka_Z14Z)then
set Tka_Z14Z=false
if(GetRandomInt(1,100)>Tka_z71Z[Tka_Z75])then
exitwhen true
endif
endif
if(Tka_z72Z[Tka_Z75]!="1111111111111111")then
set Tka_Z69z=GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+1
if(SubStringBJ(Tka_z72Z[Tka_Z75],Tka_Z69z,Tka_Z69z)=="0")then
exitwhen true
endif
endif
set Tka_Z66z=CreateUnitAtLoc(GetTriggerPlayer(),Tka_z68Z[Tka_z69Z[Tka_Z75]],Tka_Z54z,GetUnitPropWindow(Tka_z65))
set Tka_Z68z=GetUnitLoc(Tka_Z66z)
if(Tka_z70Z[Tka_Z75])then
set Tka_Z8ZZ=AddSpecialEffectLoc("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl",Tka_Z68z)
call DestroyEffect(Tka_Z8ZZ)
endif
call RemoveLocation(Tka_Z68z)
set i=i+1
exitwhen i==Tka_z65Z[Tka_z69Z[Tka_Z75]]
endloop
set Tka_z69Z[Tka_Z75]=0
set Tka_Z75=Tka_Z75+1
set Tka_Z14Z=true
set i=0
exitwhen (Tka_z69Z[Tka_Z75]==null)or(Tka_z69Z[Tka_Z75]==0)
call TriggerSleepAction(0.00)
endloop
endif
call RemoveLocation(Tka_Z54z)
set Tka_Z8ZZ=null
set Tka_Z54z=null
set Tka_Z68z=null
set Tka_Z66z=null
set Tka_z65=null
endfunction
function Tka_Z73z takes integer Tka_z15,integer Tka_Z69z returns nothing
local string Tka_Z55z
if(Tka_z26Z)then
set Tka_Z55z=StringCase(Tka_Z02Z,false)
if(Tka_Z69z==0)then
set Tka_Z55z=SubStringBJ(Tka_Z55z,$1,$1)
else
if(Tka_Z69z==1)then
set Tka_Z55z=SubStringBJ(Tka_Z55z,$4,$4)
else
if(Tka_Z69z==2)then
set Tka_Z55z=SubStringBJ(Tka_Z55z,$13,$13)
else
if(Tka_Z69z==3)then
set Tka_Z55z=SubStringBJ(Tka_Z55z,$17,$17)
endif
endif
endif
endif
if(SubStringBJ(Tka_Z71z,Tka_Z72z[Tka_z15],Tka_Z72z[Tka_z15])==Tka_Z55z)then
set Tka_Z5[Tka_z15]=Tka_Z5[Tka_z15]+1
set Tka_Z72z[Tka_z15]=Tka_Z72z[Tka_z15]+1
if(Tka_Z5[Tka_z15]==StringLength(Tka_Z71z))then
if(Tka_z27Z)then
set Tka_z29Z[Tka_z15]=true
else
call Tka_z33Z(Tka_z15)
endif
endif
else
set Tka_Z72z[Tka_z15]=1
set Tka_Z5[Tka_z15]=0
set Tka_z29Z[Tka_z15]=false
endif
endif
endfunction
function Tka_Z78 takes integer Tka_Z88 returns integer
if(Tka_Z88==0)then
return 1380018290
endif
if(Tka_Z88==1)then
return 1380019314
endif
if(Tka_Z88==2)then
return 1296393331
endif
if(Tka_Z88==3)then
return 1178886760
endif
if(Tka_Z88==4)then
return 1178886764
endif
if(Tka_Z88==5)then
return 1178888040
endif
if(Tka_Z88==6)then
return 1178888044
endif
if(Tka_Z88==7)then
return 1178890856
endif
if(Tka_Z88==8)then
return 1178890860
endif
if(Tka_Z88==9)then
return 1178892136
endif
if(Tka_Z88==10)then
return 1178892140
endif
if(Tka_Z88==11)then
return 1380739186
endif
if(Tka_Z88==12)then
return 1380740210
endif
if(Tka_Z88==13)then
return 1397645939
endif
if(Tka_Z88==14)then
return 1397647475
endif
if(Tka_Z88==15)then
return 1397648499
endif
if(Tka_Z88==16)then
return 1464820599
endif
if(Tka_Z88==17)then
return 1464822903
endif
if(Tka_Z88==18)then
return 1280467297
endif
if(Tka_Z88==19)then
return 1280470369
endif
if(Tka_Z88==20)then
return 1464755063
endif
return 0
endfunction
function Tka_Z98 takes integer Tka_Z88,boolean Tka_z77 returns nothing
set Tka_Z88=Tka_Z88-1
if(Tka_z77)then
if(Tka_z12[Tka_Z88]==false)then
if(Tka_Z78(Tka_Z88)==0)then
else
set Tka_z02[Tka_Z88]=AddWeatherEffect(Tka_z8,Tka_Z78(Tka_Z88))
call EnableWeatherEffect(Tka_z02[Tka_Z88],true)
set Tka_z12[Tka_Z88]=true
endif
endif
else
if(Tka_z02[Tka_Z88]==null)then
else
call EnableWeatherEffect(Tka_z02[Tka_Z88],false)
call RemoveWeatherEffect(Tka_z02[Tka_Z88])
set Tka_z12[Tka_Z88]=false
set Tka_z02[Tka_Z88]=null
endif
endif
endfunction
function Tka_zZ8 takes nothing returns nothing
local integer Tka_z15=1
loop
exitwhen Tka_z15>21
call Tka_Z98(Tka_z15,false)
set Tka_z15=Tka_z15+1
endloop
endfunction
function Tka_zz8 takes integer Tka_z08 returns integer
if(Tka_z08==0)then
return 1280601204
endif
if(Tka_z08==1)then
return 1179939959
endif
if(Tka_z08==2)then
return 1465152631
endif
if(Tka_z08==3)then
return 1096053874
endif
if(Tka_z08==4)then
return 1096053859
endif
if(Tka_z08==5)then
return 1112831095
endif
if(Tka_z08==6)then
return 1263826039
endif
if(Tka_z08==7)then
return 1498707828
endif
if(Tka_z08==8)then
return 1498702708
endif
if(Tka_z08==9)then
return 1498703476
endif
if(Tka_z08==10)then
return 1498706804
endif
if(Tka_z08==11)then
return 1247044468
endif
if(Tka_z08==12)then
return 1247048823
endif
if(Tka_z08==13)then
return 1146385256
endif
if(Tka_z08==14)then
return 1129608306
endif
if(Tka_z08==15)then
return 1129608291
endif
if(Tka_z08==16)then
return 1230271607
endif
if(Tka_z08==17)then
return 1230271607
endif
if(Tka_z08==18)then
return 1314157667
endif
if(Tka_z08==19)then
return 1330934903
endif
if(Tka_z08==20)then
return 1515484279
endif
if(Tka_z08==21)then
return 1196716904
endif
if(Tka_z08==22)then
return 1448373364
endif
if(Tka_z08==23)then
return 1448373364
endif
return 0
endfunction
function Tka_z18 takes nothing returns integer
return Tka_zz8(GetRandomInt(0,23))
endfunction
function Tka_z28 takes unit Tka_z65,integer Tka_z38,integer Tka_z08,integer Tka_z48 returns nothing
local real Tka_z58
local real Tka_z68
local real Tka_z15=0
local boolean Tka_z78=true
set Tka_z58=GetUnitX(Tka_z65)
set Tka_z68=GetUnitY(Tka_z65)
if(Tka_z38==1)then
loop
exitwhen Tka_z15==Tka_z48
if(Tka_z78)then
call CreateDestructable(Tka_z08,Tka_z58,Tka_z68+Tka_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(Tka_z08,Tka_z58,Tka_z68-Tka_z15*40,GetRandomReal(0,360),1,0)
endif
set Tka_z78=not(Tka_z78)
set Tka_z15=Tka_z15+1
endloop
endif
if(Tka_z38==2)then
loop
exitwhen Tka_z15==Tka_z48
if(Tka_z78)then
call CreateDestructable(Tka_z08,Tka_z58+Tka_z15*40,Tka_z68,GetRandomReal(0,360),1,0)
else
call CreateDestructable(Tka_z08,Tka_z58-Tka_z15*40,Tka_z68,GetRandomReal(0,360),1,0)
endif
set Tka_z78=not(Tka_z78)
set Tka_z15=Tka_z15+1
endloop
endif
if(Tka_z38==3)then
loop
exitwhen Tka_z15==Tka_z48
if(Tka_z78)then
call CreateDestructable(Tka_z08,Tka_z58+Tka_z15*40,Tka_z68+Tka_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(Tka_z08,Tka_z58-Tka_z15*40,Tka_z68-Tka_z15*40,GetRandomReal(0,360),1,0)
endif
set Tka_z78=not(Tka_z78)
set Tka_z15=Tka_z15+1
endloop
endif
if(Tka_z38==4)then
loop
exitwhen Tka_z15==Tka_z48
if(Tka_z78)then
call CreateDestructable(Tka_z08,Tka_z58+Tka_z15*40,Tka_z68-Tka_z15*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(Tka_z08,Tka_z58-Tka_z15*40,Tka_z68+Tka_z15*40,GetRandomReal(0,360),1,0)
endif
set Tka_z78=not(Tka_z78)
set Tka_z15=Tka_z15+1
endloop
endif
endfunction
function Tka_z88 takes integer Tka_z15 returns nothing
set Tka_Z7[Tka_z15]=true
call StartTimerBJ(Tka_z0Z[Tka_z15],false,2.)
endfunction
function Tka_z98 takes integer Tka_z15,boolean Tka_ZZZZ returns nothing
local integer Tka_Z75
local integer Tka_z76
local item Tka_z86
local location Tka_z95
local unit Tka_z65
set Tka_z65=Tka_z7[Tka_z15]
set Tka_z76=1
loop
exitwhen Tka_z76>6
if(Tka_ZZZZ)then
set Tka_z95=GetUnitLoc(Tka_z51[Tka_z15])
else
set Tka_z95=GetUnitLoc(Tka_z65)
endif
set Tka_z86=UnitItemInSlotBJ(Tka_z65,Tka_z76)
if(GetItemCharges(Tka_z86)>0)then
set Tka_Z75=GetItemCharges(Tka_z86)
set Tka_z86=CreateItemLoc(GetItemTypeId(Tka_z86),Tka_z95)
call SetItemCharges(Tka_z86,Tka_Z75)
else
call CreateItemLoc(GetItemTypeId(Tka_z86),Tka_z95)
endif
call RemoveLocation(Tka_z95)
set Tka_z76=Tka_z76+1
endloop
set Tka_z65=null
set Tka_z95=null
set Tka_z86=null
endfunction
function Tka_ZZzZ takes integer Tka_z15,player Tka_z05 returns nothing
local integer Tka_Z75
local force Tka_ZZ0Z
local player Tka_Z65
if(Tka_z1Z[Tka_z15])then
call DestroyFogModifier(Tka_Z6[Tka_z15])
set Tka_z1Z[Tka_z15]=false
else
call DestroyFogModifier(Tka_Z6[Tka_z15])
set Tka_ZZ0Z=CreateForce()
set Tka_Z75=0
loop
exitwhen Tka_Z75>11
set Tka_Z65=Player(Tka_Z75)
if(GetPlayerAlliance(Tka_z05,Tka_Z65,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(Tka_ZZ0Z,Tka_Z65)
call SetPlayerAlliance(Tka_z05,Tka_Z65,ALLIANCE_SHARED_VISION,false)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z6[Tka_z15]=CreateFogModifierRect(Tka_z05,FOG_OF_WAR_VISIBLE,Tka_z8,false,false)
call FogModifierStart(Tka_Z6[Tka_z15])
set Tka_z1Z[Tka_z15]=true
set Tka_Z75=0
loop
exitwhen Tka_Z75>11
set Tka_Z65=Player(Tka_Z75)
if(IsPlayerInForce(Tka_Z65,Tka_ZZ0Z))then
call SetPlayerAlliance(Tka_z05,Tka_Z65,ALLIANCE_SHARED_VISION,true)
endif
set Tka_Z75=Tka_Z75+1
endloop
call DestroyForce(Tka_ZZ0Z)
endif
set Tka_ZZ0Z=null
set Tka_Z65=null
endfunction
function Tka_ZZ1Z takes integer Tka_z15,player Tka_z05 returns nothing
local integer Tka_Z75
local unit Tka_z65
local item Tka_z86
local item array Tka_ZZ2Z
set Tka_z65=FirstOfGroup(Tka_Z8Z[Tka_z15])
if((Tka_z05==GetOwningPlayer(Tka_z65))and(UnitInventorySizeBJ(Tka_z65)>0))then
set Tka_Z75=1
loop
exitwhen Tka_Z75>6
set Tka_z86=UnitItemInSlotBJ(Tka_z65,Tka_Z75)
set Tka_ZZ2Z[(Tka_Z75-1)]=Tka_z86
call UnitRemoveItemSwapped(Tka_z86,Tka_z65)
call SetItemVisible(Tka_z86,false)
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z75=1
loop
exitwhen Tka_Z75>6
set Tka_z86=Tka_Z2z[(Tka_z15*18)+(Tka_Z4z[Tka_z15]*6)+(Tka_Z75-1)]
call UnitAddItem(Tka_z65,Tka_z86)
set Tka_Z2z[(Tka_z15*18)+(Tka_Z4z[Tka_z15]*6)+(Tka_Z75-1)]=Tka_ZZ2Z[(Tka_Z75-1)]
set Tka_ZZ2Z[(Tka_Z75-1)]=null
set Tka_Z75=Tka_Z75+1
endloop
if(Tka_Z4z[Tka_z15]==0)then
set Tka_Z4z[Tka_z15]=Tka_z61-1
else
set Tka_Z4z[Tka_z15]=(Tka_Z4z[Tka_z15]-1)
endif
set Tka_z86=null
endif
set Tka_z65=null
endfunction
function Tka_ZZ3Z takes unit Tka_z65 returns nothing
local integer Tka_Z75
local item Tka_z86
set Tka_Z75=1
loop
exitwhen Tka_Z75>6
set Tka_z86=UnitItemInSlotBJ(Tka_z65,Tka_Z75)
call UnitRemoveItemSwapped(Tka_z86,Tka_z65)
set Tka_Z75=Tka_Z75+1
endloop
set Tka_z86=null
endfunction
function Tka_ZZ4Z takes integer Tka_z15 returns nothing
local integer Tka_Z75
local item Tka_z86
local location Tka_z95
set Tka_z95=GetUnitLoc(Tka_z51[Tka_z15])
set Tka_Z75=1
loop
exitwhen Tka_Z75>6
set Tka_z86=UnitItemInSlotBJ(Tka_z7[Tka_z15],Tka_Z75)
call UnitRemoveItemSwapped(Tka_z86,Tka_z7[Tka_z15])
call SetItemPositionLoc(Tka_z86,Tka_z95)
set Tka_Z75=Tka_Z75+1
endloop
call RemoveLocation(Tka_z95)
set Tka_z86=null
set Tka_z95=null
endfunction
function Tka_ZZ5Z takes integer Tka_z15 returns nothing
local integer Tka_z76
local integer Tka_z78
local unit Tka_z65
local item Tka_Z66
local item Tka_ZZ6Z
set Tka_z65=FirstOfGroup(Tka_Z8Z[Tka_z15])
set Tka_z76=1
loop
exitwhen Tka_z76>5
set Tka_Z66=UnitItemInSlotBJ(Tka_z65,Tka_z76)
if(GetItemCharges(Tka_Z66)>0)then
set Tka_z78=Tka_z76+1
loop
exitwhen Tka_z78>6
set Tka_ZZ6Z=UnitItemInSlotBJ(Tka_z65,Tka_z78)
if(GetItemTypeId(Tka_Z66)==GetItemTypeId(Tka_ZZ6Z))then
call SetItemCharges(Tka_Z66,(GetItemCharges(Tka_Z66)+GetItemCharges(Tka_ZZ6Z)))
call RemoveItem(Tka_ZZ6Z)
endif
set Tka_z78=Tka_z78+1
endloop
endif
set Tka_z76=Tka_z76+1
endloop
set Tka_Z66=null
set Tka_ZZ6Z=null
set Tka_z65=null
endfunction
function Tka_ZZ7Z takes integer Tka_z15,integer Tka_Z75 returns nothing
local unit Tka_z65
local item Tka_z86
local player Tka_z05=GetTriggerPlayer()
set Tka_z65=FirstOfGroup(Tka_Z8Z[Tka_z15])
set Tka_z86=UnitItemInSlotBJ(Tka_z65,1)
call SetItemCharges(Tka_z86,(GetItemCharges(Tka_z86)+Tka_Z75))
set Tka_z86=null
set Tka_z65=null
endfunction
function Tka_ZZ8Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call GroupAddUnit(Tka_z8Z,Tka_z65)
set Tka_z65=null
endfunction
function Tka_ZZ9Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call GroupRemoveUnit(Tka_z8Z,Tka_z65)
set Tka_z65=null
endfunction
function Tka_ZzZZ takes nothing returns nothing
local unit Tka_z65=GetTriggerUnit()
if((IsUnitDeadBJ(Tka_z65))and(IsUnitType(Tka_z65,ConvertUnitType(0))))then
call GroupRemoveUnit(Tka_z8Z,Tka_z65)
endif
endfunction
function Tka_ZzzZ takes nothing returns nothing
call ForGroup(Tka_z8Z,function Tka_ZzZZ)
endfunction
function Tka_Zz0Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call ReviveHeroLoc(Tka_z65,Tka_Z9Z[Tka_Zzz],true)
call SetUnitManaPercentBJ(Tka_z65,100)
set Tka_z65=null
endfunction
function Tka_Zz1Z takes player Tka_z05 returns nothing
local group Tka_z46
set Tka_z46=Tka_Z94(Tka_z05)
set Tka_Zzz=GetPlayerId(Tka_z05)
call ForGroup(Tka_z46,function Tka_Zz0Z)
call DestroyGroup(Tka_z46)
set Tka_z46=null
endfunction
function Tka_Zz2Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
if(GetHeroStatBJ(Tka_z81,Tka_z65,false)+Tka_z71<=-1)then
if(Tka_z91==0)then
set Tka_z91=2
set Tka_z71=2147483647
endif
endif
if(GetHeroStatBJ(Tka_z81,Tka_z65,false)-Tka_z71<=1)then
if(Tka_z91==1)then
set Tka_z91=2
set Tka_z71=1
endif
endif
call ModifyHeroStat(Tka_z81,Tka_z65,Tka_z91,Tka_z71)
set Tka_z65=null
endfunction
function Tka_Zz3Z takes integer Tka_z15,integer Tka_Zz4Z,integer Tka_Zz5Z,boolean Tka_z25 returns nothing
local integer Tka_Zz6Z
if(Tka_z25)then
set Tka_Zz6Z=0
else
set Tka_Zz6Z=1
endif
if(Tka_Z0)then
set Tka_z91=Tka_Zz6Z
set Tka_z81=Tka_Zz4Z
set Tka_z71=Tka_Zz5Z
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Zz2Z)
else
if(GetHeroStatBJ(Tka_Zz4Z,Tka_z7[Tka_z15],false)+Tka_Zz5Z<=-1)then
if(Tka_Zz6Z==0)then
set Tka_Zz6Z=2
set Tka_Zz5Z=2147483647
endif
endif
if(GetHeroStatBJ(Tka_Zz4Z,Tka_z7[Tka_z15],false)-Tka_Zz5Z<=1)then
if(Tka_Zz6Z==1)then
set Tka_Zz6Z=2
set Tka_Zz5Z=1
endif
endif
call ModifyHeroStat(Tka_Zz4Z,Tka_z7[Tka_z15],Tka_Zz6Z,Tka_Zz5Z)
endif
endfunction
function Tka_Zz7Z takes unit Tka_z65,integer Tka_Zz5Z,boolean Tka_z25 returns nothing
local integer Tka_z15
set Tka_z15=GetHeroLevel(Tka_z65)
if(Tka_z25)then
set Tka_z15=Tka_z15+Tka_Zz5Z
else
set Tka_z15=Tka_z15-Tka_Zz5Z
endif
call SetHeroLevelBJ(Tka_z65,Tka_z15,false)
endfunction
function Tka_Zz8Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_Zz7Z(Tka_z65,Tka_ZZ2,Tka_Z1z)
set Tka_z65=null
endfunction
function Tka_Zz9Z takes integer Tka_z15,integer Tka_Zz5Z,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_ZZ2=Tka_Zz5Z
set Tka_Z1z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Zz8Z)
else
call Tka_Zz7Z(Tka_z7[Tka_z15],Tka_Zz5Z,Tka_z25)
endif
endfunction
function Tka_Z0ZZ takes string Tka_Z0zZ returns integer
local integer Tka_Z03Z=1
local integer Tka_Z75=1
local integer array Tka_Z04Z
local string Tka_Z11Z=Tka_z46Z+Tka_Z01Z+Tka_Z02Z
loop
loop
if(SubStringBJ(Tka_Z0zZ,Tka_Z75,Tka_Z75)==SubStringBJ(Tka_Z11Z,Tka_Z03Z,Tka_Z03Z))then
set Tka_Z04Z[Tka_Z75]=Tka_z53Z[Tka_Z03Z]
exitwhen true
endif
exitwhen Tka_Z03Z>=62
set Tka_Z03Z=Tka_Z03Z+1
endloop
set Tka_Z03Z=1
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==5
endloop
set Tka_Z75=(256*256*256*Tka_Z04Z[1])+(256*256*Tka_Z04Z[2])+(256*Tka_Z04Z[3])+Tka_Z04Z[4]
return Tka_Z75
endfunction
function Tka_Z05Z takes integer Tka_Z06Z returns string
local string Tka_Z07Z=""
local integer Tka_Z03Z=0
local integer Tka_Z08Z=0
loop
exitwhen Tka_Z06Z==0
set Tka_Z03Z=ModuloInteger(Tka_Z06Z,256)
if Tka_Z03Z>=48 and Tka_Z03Z<=57 then
set Tka_Z08Z=Tka_Z03Z-48
set Tka_Z07Z=SubString(Tka_Z00Z,Tka_Z08Z,Tka_Z08Z+1)+Tka_Z07Z
endif
if Tka_Z03Z>=65 and Tka_Z03Z<=90 then
set Tka_Z08Z=Tka_Z03Z-65
set Tka_Z07Z=SubString(Tka_Z01Z,Tka_Z08Z,Tka_Z08Z+1)+Tka_Z07Z
endif
if Tka_Z03Z>=97 and Tka_Z03Z<=122 then
set Tka_Z08Z=Tka_Z03Z-97
set Tka_Z07Z=SubString(Tka_Z02Z,Tka_Z08Z,Tka_Z08Z+1)+Tka_Z07Z
endif
set Tka_Z06Z=Tka_Z06Z/256
endloop
return Tka_Z07Z
endfunction
function Tka_Z09Z takes unit Tka_z65 returns string
local integer Tka_z15
set Tka_z15=GetUnitTypeId(Tka_z65)
if(Tka_z15==0)then
return""
else
return Tka_Z05Z(Tka_z15)
endif
endfunction
function Tka_Z50z takes unit Tka_Z51z returns string
local item Tka_Z52z=UnitItemInSlotBJ(Tka_Z51z,1)
local integer Tka_Z53z=GetItemTypeId(Tka_Z52z)
if(Tka_Z53z==0)then
return""
else
set Tka_Z52z=null
return Tka_Z05Z(Tka_Z53z)
endif
endfunction
function Tka_Z1zZ takes integer Tka_Z10Z returns integer
local string Tka_Z11Z=GetEventPlayerChatString()
if(SubStringBJ(Tka_Z11Z,Tka_Z10Z,Tka_Z10Z)=="")or(SubStringBJ(Tka_Z11Z,Tka_Z10Z+1,Tka_Z10Z+1)=="")or(SubStringBJ(Tka_Z11Z,Tka_Z10Z+2,Tka_Z10Z+2)=="")or(SubStringBJ(Tka_Z11Z,Tka_Z10Z+3,Tka_Z10Z+3)=="")then
return 0
else
return(Tka_Z0ZZ(SubStringBJ(Tka_Z11Z,Tka_Z10Z,Tka_Z10Z+3)))
endif
endfunction
function Tka_Z12Z takes unit Tka_z65,integer Tka_z66,boolean Tka_z25,integer Tka_Z55z returns nothing
local location Tka_z95
local integer Tka_z15
local integer Tka_Z54z=0
set Tka_Z54z=0
set Tka_z15=Tka_Z1zZ(Tka_z66)
if(Tka_z15==0)then
else
loop
exitwhen Tka_Z54z==Tka_Z55z
if(Tka_z25)then
set Tka_z95=GetUnitLoc(Tka_z65)
call CreateItemLoc(Tka_z15,Tka_z95)
call RemoveLocation(Tka_z95)
set Tka_z95=null
else
call UnitAddItemById(Tka_z65,Tka_z15)
endif
set Tka_Z54z=Tka_Z54z+1
endloop
endif
endfunction
function Tka_Z13Z takes unit Tka_z65,real Tka_Z14Z,boolean Tka_z25 returns nothing
local location Tka_z95=GetUnitLoc(Tka_z65)
local player Tka_z05=GetOwningPlayer(Tka_z65)
call SetBlightRadiusLocBJ(Tka_z25,Tka_z05,Tka_z95,Tka_Z14Z)
call RemoveLocation(Tka_z95)
set Tka_z95=null
set Tka_z05=null
endfunction
function Tka_Z15Z takes unit Tka_z65,real Tka_Z14Z returns nothing
call UnitAddAbility(Tka_z65,'Amrf')
call SetUnitFlyHeight(Tka_z65,Tka_Z14Z,.0)
call UnitRemoveAbility(Tka_z65,'Amrf')
endfunction
function Tka_Z16Z takes nothing returns integer
local integer Tka_Z17Z=0
local integer Tka_Z18Z=0
local integer array Tka_Z19Z
local integer Tka_z15=0
local player Tka_z05=GetLocalPlayer()
loop
exitwhen Tka_z15>11
set Tka_Z19Z[Tka_z15]=0
set Tka_z15=Tka_z15+1
endloop
loop
exitwhen Tka_Z17Z>14
call StoreInteger(Tka_z03,"Hke_Player","Hke_number",GetPlayerId(Tka_z05)+1)
call TriggerSyncStart()
call SyncStoredInteger(Tka_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set Tka_Z18Z=GetStoredInteger(Tka_z03,"Hke_Player","Hke_number")-1
set Tka_Z19Z[Tka_Z18Z]=Tka_Z19Z[Tka_Z18Z]+1
call FlushStoredMission(Tka_z03,"Hke_Player")
set Tka_Z17Z=Tka_Z17Z+1
endloop
set Tka_Z18Z=0
set Tka_Z17Z=0
set Tka_z05=null
loop
exitwhen Tka_Z17Z>11
if Tka_Z19Z[Tka_Z18Z]<Tka_Z19Z[Tka_Z17Z]then
set Tka_Z18Z=Tka_Z17Z
endif
set Tka_Z17Z=Tka_Z17Z+1
endloop
return Tka_Z18Z+1
endfunction
function Tka_Z2ZZ takes unit Tka_z65,integer Tka_Z2zZ,boolean Tka_z25 returns nothing
if(Tka_z25)then
call UnitAddAbility(Tka_z65,Tka_Z2zZ)
call SetUnitAbilityLevel(Tka_z65,Tka_Z2zZ,100)
call UnitMakeAbilityPermanent(Tka_z65,true,Tka_Z2zZ)
else
call UnitMakeAbilityPermanent(Tka_z65,false,Tka_Z2zZ)
call UnitRemoveAbility(Tka_z65,Tka_Z2zZ)
endif
endfunction
function Tka_Z20Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_Z2ZZ(Tka_z65,Tka_zzz,Tka_z0z)
set Tka_z65=null
endfunction
function Tka_Z21Z takes integer Tka_z15,integer Tka_Z2zZ,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_zzz=Tka_Z2zZ
set Tka_z0z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z20Z)
else
call Tka_Z2ZZ(Tka_z7[Tka_z15],Tka_Z2zZ,Tka_z25)
endif
endfunction
function Tka_Z22Z takes string Tka_Z11Z returns integer
if(Tka_Z11Z=="mm")then
return 1094937907
endif
if(Tka_Z11Z=="xj")then
return 1095659625
endif
if(Tka_Z11Z=="zj")then
return 1095262824
endif
if(Tka_Z11Z=="zm")then
return 1095721842
endif
if(Tka_Z11Z=="ft")then
return 1096119411
endif
if(Tka_Z11Z=="xx")then
return 1095333473
endif
if(Tka_Z11Z=="sb")then
return 1095066998
endif
if(Tka_Z11Z=="yx")then
return 1097886070
endif
if(Tka_Z11Z=="rh")then
return 1095657827
endif
if(Tka_Z11Z=="fl")then
return 1095656289
endif
if(Tka_Z11Z=="bs")then
return 1094935923
endif
if(Tka_Z11Z=="jg")then
return 1095332984
endif
if(Tka_Z11Z=="jf")then
return 1095328816
endif
if(Tka_Z11Z=="js")then
return 1095332728
endif
if(Tka_Z11Z=="jm")then
return 1095332722
endif
if(Tka_Z11Z=="jj")then
return 1095917932
endif
if(Tka_Z11Z=="fy")then
return 1098150517
endif
if(Tka_Z11Z=="ghh")then
return 1095262562
endif
if(Tka_Z11Z=="ghj")then
return 1095721317
endif
if(Tka_Z11Z=="gqj")then
return 1095065970
endif
if(Tka_Z11Z=="gxx")then
return 1096114550
endif
if(Tka_Z11Z=="gzz")then
return 1095262564
endif
if(Tka_Z11Z=="gxe")then
return 1096114549
endif
if(Tka_Z11Z=="gjj")then
return 1095065960
endif
if(Tka_Z11Z=="gml")then
return 1094934883
endif
if(Tka_Z11Z=="gyl")then
return 1097818482
endif
if(Tka_Z11Z=="gjs")then
return 1096905580
endif
if(Tka_Z11Z=="qhy")then
return 1095329378
endif
if(Tka_Z11Z=="qdy")then
return 1095331938
endif
if(Tka_Z11Z=="qlh")then
return 1095332719
endif
if(Tka_Z11Z=="qyz")then
return 1095328878
endif
if(Tka_Z11Z=="qbd")then
return 1095331682
endif
if(Tka_Z11Z=="qfs")then
return 1095328610
endif
if(Tka_Z11Z=="qsd")then
return 1095330924
endif
if(Tka_Z11Z=="qjs")then
return 1095332706
endif
if(Tka_Z11Z=="qha")then
return 1095328870
endif
return 0
endfunction
function Tka_Z23Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call SetUnitInvulnerable(Tka_z65,Tka_z0z)
call Tka_Z2ZZ(Tka_z65,1098282348,Tka_z0z)
set Tka_z65=null
endfunction
function Tka_Z24Z takes integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_z0z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z23Z)
else
call SetUnitInvulnerable(Tka_z7[Tka_z15],Tka_z25)
call Tka_Z2ZZ(Tka_z7[Tka_z15],1098282348,Tka_z25)
endif
endfunction
function Tka_Z25Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call SetUnitPathing(Tka_z65,not(Tka_z0z))
set Tka_z65=null
endfunction
function Tka_Z26Z takes integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_z0z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z25Z)
else
call SetUnitPathing(Tka_z7[Tka_z15],not(Tka_z25))
endif
endfunction
function Tka_Z27Z takes unit Tka_z65,boolean Tka_z25 returns nothing
if(Tka_z25)then
call SetUnitMoveSpeed(Tka_z65,1000)
else
call SetUnitMoveSpeed(Tka_z65,GetUnitDefaultMoveSpeed(Tka_z65))
endif
endfunction
function Tka_Z28Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_Z27Z(Tka_z65,Tka_z0z)
set Tka_z65=null
endfunction
function Tka_Z29Z takes integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_z0z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z28Z)
else
call Tka_Z27Z(Tka_z7[Tka_z15],Tka_z25)
endif
endfunction
function Tka_Z3ZZ takes integer Tka_z15,boolean Tka_z25 returns nothing
call Tka_ZzzZ()
if(Tka_Z0)then
if(Tka_z25)then
if(CountUnitsInGroup(Tka_z8Z)==0)then
set Tka_z88Z=true
endif
call GroupAddGroup(Tka_Z8Z[Tka_z15],Tka_z8Z)
else
call GroupRemoveGroup(Tka_Z8Z[Tka_z15],Tka_z8Z)
if(CountUnitsInGroup(Tka_z8Z)==0)then
set Tka_z88Z=false
endif
endif
else
if(Tka_z25)then
if(CountUnitsInGroup(Tka_z8Z)==0)then
set Tka_z88Z=true
endif
call GroupAddUnit(Tka_z8Z,Tka_z7[Tka_z15])
else
call GroupRemoveUnit(Tka_z8Z,Tka_z7[Tka_z15])
if(CountUnitsInGroup(Tka_z8Z)==0)then
set Tka_z88Z=false
endif
endif
endif
endfunction
function Tka_Z3zZ takes unit Tka_z65,boolean Tka_z25 returns nothing
call Tka_Z2ZZ(Tka_z65,1095262562,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1095721317,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1095065970,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1096114550,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1095262564,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1096114549,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1094934883,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1095065960,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1097818482,Tka_z25)
call Tka_Z2ZZ(Tka_z65,1096905580,Tka_z25)
endfunction
function Tka_Z30Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_Z3zZ(Tka_z65,Tka_z0z)
set Tka_z65=null
endfunction
function Tka_Z31Z takes integer Tka_z15,boolean Tka_z25 returns nothing
if(Tka_Z0)then
set Tka_z0z=Tka_z25
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z30Z)
else
call Tka_Z3zZ(Tka_z7[Tka_z15],Tka_z25)
endif
endfunction
function Tka_Z32Z takes unit Tka_z65 returns nothing
call Tka_Z2ZZ(Tka_z65,1094937907,false)
call Tka_Z2ZZ(Tka_z65,1095659625,false)
call Tka_Z2ZZ(Tka_z65,1095262824,false)
call Tka_Z2ZZ(Tka_z65,1095721842,false)
call Tka_Z2ZZ(Tka_z65,1096119411,false)
call Tka_Z2ZZ(Tka_z65,1095333473,false)
call Tka_Z2ZZ(Tka_z65,1095066998,false)
call Tka_Z2ZZ(Tka_z65,1097886070,false)
call Tka_Z2ZZ(Tka_z65,1095657827,false)
call Tka_Z2ZZ(Tka_z65,1095656289,false)
call Tka_Z2ZZ(Tka_z65,1098282348,false)
call Tka_Z2ZZ(Tka_z65,1094935923,false)
call Tka_Z2ZZ(Tka_z65,1095332984,false)
call Tka_Z2ZZ(Tka_z65,1095328816,false)
call Tka_Z2ZZ(Tka_z65,1095332728,false)
call Tka_Z2ZZ(Tka_z65,1095332722,false)
call Tka_Z2ZZ(Tka_z65,1098150517,false)
call SetUnitInvulnerable(Tka_z65,false)
call SetUnitPathing(Tka_z65,true)
call Tka_Z27Z(Tka_z65,false)
call GroupRemoveUnit(Tka_z8Z,Tka_z65)
endfunction
function Tka_Z33Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_Z32Z(Tka_z65)
set Tka_z65=null
endfunction
function Tka_Z34Z takes integer Tka_z15 returns nothing
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z33Z)
else
call Tka_Z32Z(Tka_z7[Tka_z15])
endif
endfunction
function Tka_Z35Z takes nothing returns nothing
local unit Tka_z65=GetTriggerUnit()
local trigger Tka_Z66=GetTriggeringTrigger()
call RemoveUnit(Tka_z65)
call DisableTrigger(Tka_Z66)
call DestroyTrigger(Tka_Z66)
set Tka_z65=null
set Tka_Z66=null
endfunction
function Tka_Z36Z takes integer Tka_z66,unit Tka_Z37Z,player Tka_Z38Z returns nothing
local location Tka_z95
local unit Tka_z65
local integer Tka_Z39Z=0
local integer Tka_Z4ZZ=0
local trigger Tka_Z66
if(Tka_z66==0)then
set Tka_Z39Z=1095726692
set Tka_Z4ZZ=852503
endif
if(Tka_z66==1)then
set Tka_Z39Z=1095070833
set Tka_Z4ZZ=852184
endif
if(Tka_z66==2)then
set Tka_Z39Z=1095070566
set Tka_Z4ZZ=852183
endif
if((Tka_Z39Z==0)and(Tka_Z4ZZ==0))then
return
endif
set Tka_z95=GetUnitLoc(Tka_Z37Z)
set Tka_z65=CreateUnitAtLoc(Tka_Z38Z,1851941228,Tka_z95,270.)
call UnitAddAbility(Tka_z65,1098282348)
call UnitAddAbility(Tka_z65,Tka_Z39Z)
call ShowUnit(Tka_z65,false)
call SetUnitUseFood(Tka_z65,false)
call SetUnitScale(Tka_z65,.01,.01,.01)
call SetUnitState(Tka_z65,ConvertUnitState(2),GetUnitState(Tka_z65,ConvertUnitState(3)))
call IssueImmediateOrderById(Tka_z65,Tka_Z4ZZ)
set Tka_Z66=CreateTrigger()
call TriggerRegisterUnitEvent(Tka_Z66,Tka_z65,ConvertUnitEvent(293))
call TriggerRegisterUnitEvent(Tka_Z66,Tka_z65,ConvertUnitEvent(292))
call TriggerAddAction(Tka_Z66,function Tka_Z35Z)
call RemoveLocation(Tka_z95)
set Tka_z95=null
set Tka_Z66=null
set Tka_z65=null
endfunction
function Tka_Z4zZ takes unit Tka_Z37Z returns nothing
local player Tka_z05=GetTriggerPlayer()
local location Tka_z95=GetUnitLoc(Tka_Z37Z)
local trigger Tka_Z66=CreateTrigger()
local unit Tka_z65=CreateUnitAtLoc(Tka_z05,1751543663,Tka_z95,270.)
call UnitAddAbility(Tka_z65,1098282348)
call UnitAddAbility(Tka_z65,1095332709)
call ShowUnit(Tka_z65,false)
call SetUnitUseFood(Tka_z65,false)
call SetUnitScale(Tka_z65,.01,.01,.01)
call IssuePointOrderByIdLoc(Tka_z65,852592,Tka_z95)
call TriggerRegisterUnitEvent(Tka_Z66,Tka_z65,ConvertUnitEvent(293))
call TriggerRegisterUnitEvent(Tka_Z66,Tka_z65,ConvertUnitEvent(292))
call TriggerAddAction(Tka_Z66,function Tka_Z35Z)
call RemoveLocation(Tka_z95)
set Tka_z95=null
set Tka_Z66=null
set Tka_z05=null
endfunction
function Tka_Z40Z takes integer Tka_z15,dialog Tka_Z41Z,trigger Tka_zZ6 returns nothing
set Tka_Zz3[Tka_z15]=Tka_Z41Z
set Tka_Z03[Tka_z15]=Tka_zZ6
endfunction
function Tka_Z42Z takes integer Tka_z15,string Tka_Z43Z returns nothing
call DialogClear(Tka_Zz3[Tka_z15])
call DialogSetMessage(Tka_Zz3[Tka_z15],(Tka_Z43Z+Tka_Z0z+Tka_Z62))
endfunction
function Tka_Z44Z takes integer Tka_z15,player Tka_z05,boolean Tka_z77 returns nothing
if(Tka_z77)then
call EnableTrigger(Tka_Z03[Tka_z15])
call DialogDisplay(Tka_z05,Tka_Zz3[Tka_z15],true)
call TimerStart(Tka_Z73[Tka_z15],Tka_z1,false,null)
else
call DisableTrigger(Tka_Z03[Tka_z15])
call DialogDisplay(Tka_z05,Tka_Zz3[Tka_z15],false)
endif
endfunction
function Tka_Z45Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_zZ1[Tka_z15],Tka_ZZ1[Tka_z15])
call Tka_Z42Z(Tka_z15,"主")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"资源菜单[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"自动化设置[B]",66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z35z+"特殊属性[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"个人选项设置[D]",68)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"帮助菜单[E]",69)
if(Tka_Z13z(Tka_z05))then
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"其他玩家作弊管理[F]",70)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"其他玩家管理[G]",71)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"游戏作弊选项[H]",72)
if(Tka_z13)then
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"关闭录像(无法再开)[L]",72)
endif
endif
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z46Z takes integer Tka_z15,player Tka_z05 returns nothing
local string Tka_Z11Z
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Zz1[Tka_z15])
call Tka_Z42Z(Tka_z15,"自动化设置")
if(IsTriggerEnabled(Tka_z40[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(Tka_z50[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(Tka_z60[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(Tka_z80[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(Tka_z70[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(Tka_z90[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"魔法释放後自动MP"+I2S(R2I(Tka_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(Tka_ZZ3[Tka_z15]))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"生命低於"+I2S(R2I(Tka_z92))+"%加到"+I2S(R2I(Tka_z41))+"%[G]"),71)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"全部开启[O]",79)
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"全部关闭[U]",85)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z11Z=""
endfunction
function Tka_Z47Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z01[Tka_z15])
call Tka_Z42Z(Tka_z15,Tka_Z35z+"特殊属性")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"无敌[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"永久隐形[B]",66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"穿越物体[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"魔免[D]",68)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"反隐形[E]",69)
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"移动速度[F]",70)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"各种光环[G]",71)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"换页[N]",78)
if((Tka_z9Z)or(Tka_Z13z(Tka_z05)))then
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"秒杀模式[K]",75)
endif
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"取消全部(不含光环)[U]",85)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z48Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_Z91[Tka_z15],Tka_Z81[Tka_z15])
call Tka_Z42Z(Tka_z15,Tka_Z35z+"特殊属性")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"永久献祭[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"闪避[B]",514)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"重击[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"致命一击[D]",68)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"反弹(小强的壳)[E]",69)
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"分裂攻击[F]",70)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"燃灰[G]",71)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"减少魔法伤害33%[H]",72)
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"闪避100%[I]",73)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"换页[N]",78)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z49Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_Z91[Tka_z15],Tka_Z21[Tka_z15])
call Tka_Z42Z(Tka_z15,"光环")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"辉煌光环[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"荆棘光环[B]",66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"耐久光环[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"强击光环[D]",68)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"邪恶光环[E]",69)
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"吸血光环[F]",70)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"专注光环[G]",71)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"命令光环(战鼓)[H]",72)
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"医疗光环[I]",73)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"减速光环[J]",74)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"关闭所有光环[K]",75)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z5ZZ takes integer Tka_z15,player Tka_z05 returns nothing
local integer Tka_Z75=0
local string Tka_Z11Z
local string Tka_Z5zZ
local player Tka_Z65
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z51[Tka_z15])
call Tka_Z42Z(Tka_z15,"玩家作弊管理")
loop
exitwhen Tka_Z75>11
set Tka_Z65=Player(Tka_Z75)
if((GetPlayerController(Tka_Z65)==ConvertMapControl(0))and(GetPlayerSlotState(Tka_Z65)==ConvertPlayerSlotState(1))and(Tka_Z65!=Tka_z5))then
set Tka_Z5zZ=GetPlayerName(Tka_Z65)
if(Tka_Z11z(Tka_Z75))then
set Tka_Z11Z="禁止"
else
set Tka_Z11Z="允许"
endif
set Tka_ZzZ[Tka_Z75]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+Tka_Z5zZ+"作弊"),0)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z65=null
set Tka_Z11Z=""
set Tka_Z5zZ=""
endfunction
function Tka_Z50Z takes integer Tka_z15,player Tka_z05 returns nothing
set Tka_Z8[Tka_z15]=0
call Tka_Z40Z(Tka_z15,Tka_zZ1[Tka_z15],Tka_Z71[Tka_z15])
call Tka_Z42Z(Tka_z15,"单位")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"升100级[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("加三围"+(I2S(Tka_Z3)+"[B]")),66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"复制物品[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"复制单位[D]",68)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"掉身上物品[E]",69)
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"共享该单位视野[F]",70)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"特殊属性菜单[G]",71)
if((Tka_z7Z)or(Tka_Z13z(Tka_z05)))then
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"控制它[H]",72)
endif
if(Tka_Z13z(Tka_z05))then
endif
if(Tka_Z13z(Tka_z05))then
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"改变单位所有者[J]",74)
endif
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z51Z takes integer Tka_z15,player Tka_z05 returns nothing
local string Tka_Z11Z
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z31[Tka_z15])
call Tka_Z42Z(Tka_z15,"游戏作弊选项")
if(Tka_Z0)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"操作所有单位[A]"),65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("设置背包数[B]"),66)
if(Tka_Z5Z)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"保护CheatMaster[C]"),67)
if(Tka_Z6Z)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"瞬间造兵不占用人口[D]"),68)
if(Tka_Z7Z)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("取消作弊时"+Tka_Z11Z+"地图全开[E]"),69)
if(Tka_z9Z)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"他人秒杀模式[F]"),70)
if(Tka_ZZz)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"禁止秒杀建筑[G]"),71)
if(Tka_z7Z)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"他人占据单位[H]"),72)
if(Tka_Z52)then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"禁止克隆操作农民[I]"),73)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z11Z=""
endfunction
function Tka_Z52Z takes integer Tka_z15,player Tka_z05 returns nothing
local string Tka_Z5zZ
local integer Tka_Z75=0
local player Tka_Z65
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z41[Tka_z15])
call Tka_Z42Z(Tka_z15,"玩家管理")
loop
exitwhen Tka_Z75>11
set Tka_Z65=Player(Tka_Z75)
if(GetPlayerSlotState(Tka_Z65)==ConvertPlayerSlotState(1))then
set Tka_Z5zZ=GetPlayerName(Tka_Z65)
set Tka_ZzZ[Tka_Z75]=DialogAddButton(Tka_Zz3[Tka_z15],("选择"+Tka_Z5zZ+"操作"),0)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_ZzZ[12]=DialogAddButton(Tka_Zz3[Tka_z15],("选择中立生物操作"),90)
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z5zZ=""
set Tka_Z65=null
endfunction
function Tka_Z53Z takes integer Tka_z15,player Tka_z05 returns nothing
local player Tka_Z65=Player(Tka_Z5z)
call Tka_Z40Z(Tka_z15,Tka_Z91[Tka_z15],Tka_Z61[Tka_z15])
call Tka_Z42Z(Tka_z15,"玩家管理")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"资源管理[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"同盟管理[B]",66)
if(GetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(1))==0)then
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"向他收税黄金"+I2S(Tka_z22)+"%[C]",67)
else
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(2))==0)then
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"向他收税木材"+I2S(Tka_z22)+"%[D]",68)
else
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"停止向他收木材[D]",67)
endif
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回选择菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z65=null
endfunction
function Tka_Z54Z takes integer Tka_z15,player Tka_z05 returns nothing
local integer Tka_Z75=0
local player Tka_Z65
local string Tka_Z11Z
local string Tka_Z5zZ
call Tka_Z40Z(Tka_z15,Tka_Z91[Tka_z15],Tka_Z11[Tka_z15])
call Tka_Z42Z(Tka_z15,Tka_Z35z+"控制")
loop
exitwhen Tka_Z75>12
set Tka_Z65=Player(Tka_Z75)
if(GetPlayerSlotState(Tka_Z65)==ConvertPlayerSlotState(1))then
set Tka_Z5zZ=GetPlayerName(Tka_Z65)
set Tka_ZzZ[Tka_Z75]=DialogAddButton(Tka_Zz3[Tka_z15],("给"+Tka_Z5zZ+"控制"),0)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回单位菜单[R]",82)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z65=null
set Tka_Z11Z=""
set Tka_Z5zZ=""
endfunction
function Tka_Z55Z takes integer Tka_z15,player Tka_z05 returns nothing
local string Tka_Z11Z
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Zz2[Tka_z15])
call Tka_Z42Z(Tka_z15,"资源设置")
if(Tka_z1Z[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="打开"
endif
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"地图[A]"),65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("复活死亡英雄[B]"),66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"人口清5[B]",66)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"总人口100[C]",67)
if(GetPlayerHandicap(Tka_z05)==2)then
set Tka_Z11Z="恢复生命障碍100%"
else
set Tka_Z11Z="200%生命"
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(Tka_z05)==2)then
set Tka_Z11Z="恢复普通经验率"
else
set Tka_Z11Z="2倍经验"
endif
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"[E]",69)
set Tka_Z11Z=I2S(Tka_Z2)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("加"+Tka_Z11Z+"钱[F]"),70)
set Tka_Z11Z=I2S(Tka_z2)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("加"+Tka_Z11Z+"木[G]"),71)
set Tka_Z11Z=I2S(Tka_Z2)
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("减"+Tka_Z11Z+"钱[H]"),72)
set Tka_Z11Z=I2S(Tka_z2)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("减"+Tka_Z11Z+"木[I]"),73)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z11Z=""
endfunction
function Tka_Z56Z takes integer Tka_z15,player Tka_z05 returns nothing
local player Tka_Z65=Player(Tka_Z5z)
local string Tka_Z11Z
local string Tka_Z5zZ=GetPlayerName(Tka_Z65)
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z02[Tka_z15])
call DialogClear(Tka_Z20[Tka_z15])
call DialogSetMessage(Tka_Z20[Tka_z15],(Tka_Z5zZ+"钱"+I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(1)))+" |CFF008000木"+I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(2)))+"|R 人口"+I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(5)))+"/"+I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(4)))))
if(Tka_z1Z[Tka_Z5z])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="打开"
endif
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],(Tka_Z11Z+"地图[A]"),65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("复活死亡英雄[B]"),66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"人口清5[B]",66)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"总人口100[C]",67)
if(GetPlayerHandicap(Tka_Z65)==2)then
set Tka_Z11Z="恢复生命障碍100%"
else
set Tka_Z11Z="200%生命"
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"[D]",68)
if(GetPlayerHandicapXP(Tka_Z65)==2)then
set Tka_Z11Z="恢复普通经验率"
else
set Tka_Z11Z="2倍经验"
endif
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"[E]",69)
set Tka_Z11Z=I2S(Tka_Z2)
set Tka_z7z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("加"+Tka_Z11Z+"钱[F]"),70)
set Tka_Z11Z=I2S(Tka_z2)
set Tka_z6z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("加"+Tka_Z11Z+"木[G]"),71)
set Tka_Z11Z=I2S(Tka_Z2)
set Tka_Zz0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("减"+Tka_Z11Z+"钱[H]"),72)
set Tka_Z11Z=I2S(Tka_z2)
set Tka_ZZ0[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("减"+Tka_Z11Z+"木[I]"),73)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z11Z=""
set Tka_Z5zZ=""
set Tka_Z65=null
endfunction
function Tka_Z57Z takes integer Tka_z15,player Tka_z05 returns nothing
local player Tka_Z65=Player(Tka_Z5z)
local string Tka_Z11Z
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z12[Tka_z15])
call Tka_Z42Z(Tka_z15,"同盟管理")
if(IsPlayerAlly(Tka_Z65,Tka_z5))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("强制"+Tka_Z11Z+"同盟[A]"),65)
if(IsPlayerAlly(Tka_Z65,Tka_z5))then
if(GetPlayerAlliance(Tka_Z65,Tka_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("强制"+Tka_Z11Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(Tka_Z65,Tka_z5,ALLIANCE_SHARED_XP))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("强制"+Tka_Z11Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(Tka_z5,Tka_Z65))then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],("强制"+Tka_Z11Z+"对其同盟[D]"),68)
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回玩家菜单[R]",82)
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z65=null
set Tka_Z11Z=""
endfunction
function Tka_Z58Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_Z91[Tka_z15],Tka_Z22[Tka_z15])
call DialogClear(Tka_Z91[Tka_z15])
call DialogSetMessage(Tka_Z91[Tka_z15],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(Tka_z61)+"|r个")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"设置1个背包[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"设置2个背包[B]",66)
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"设置3个背包[C]",67)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回选设置单[R]",82)
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z59Z takes integer Tka_z15,player Tka_z05 returns nothing
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z23[Tka_z15])
call Tka_Z42Z(Tka_z15,"帮助")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"键盘帮助[A]",65)
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"CMD帮助[B]",66)
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"显示玩家信息[C]",67)
set Tka_Z39z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"Tka系统帮助[D]",68)
if(Tka_Z13z(Tka_z05))then
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"显示设置信息[E]",69)
endif
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
endfunction
function Tka_Z6ZZ takes integer Tka_z15,player Tka_z05 returns nothing
local string Tka_Z11Z
call Tka_Z40Z(Tka_z15,Tka_Z20[Tka_z15],Tka_Z13[Tka_z15])
call Tka_Z42Z(Tka_z15,"个人选项")
set Tka_z2z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"删除我的复制单位[A]",65)
if(Tka_z31[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z4z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"克隆操作[B]",66)
if(Tka_Z33[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z5z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"组队克隆操作[C]",67)
if(Tka_Z53[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z3z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"隐藏加攻[D]",68)
if(Tka_Z63[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z9z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"隐藏加攻带溅射[E]",69)
if(Tka_Z43[Tka_z15])then
set Tka_Z11Z="关闭"
else
set Tka_Z11Z="开启"
endif
set Tka_z8z[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],Tka_Z11Z+"远程沉默[F]",70)
set Tka_Z00[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"回主菜单[R]",82)
set Tka_Z10[Tka_z15]=DialogAddButton(Tka_Zz3[Tka_z15],"退出菜单[X]",88)
call Tka_Z44Z(Tka_z15,Tka_z05,true)
set Tka_Z11Z=""
endfunction
function Tka_Z60Z takes player Tka_z05,integer Tka_Z55z returns nothing
if(Tka_Z55z==1)then
set Tka_Z41z[1]=Tka_z22Z+"欢迎使用"+Tka_Z30z+"淘宝作弊系列"+Tka_z34Z+" "+Tka_z22Z+"地图购买|CFF00FF00www.riotgames.taobao.com|r"
set Tka_Z41z[2]=Tka_z22Z+"下面是CMD功能说明 後跟数字的命令把空格换成-可以减少相应数值  部分命令後直接加+或-表示开启/关闭 无空格 其他有空格"
set Tka_Z41z[3]=Tka_Z30z+"-h"+Tka_Z27z+"显示方向键帮助|r  "+Tka_Z30z+"-c [1~4]"+Tka_Z27z+" 显示cmd帮助|r "+Tka_Z30z+"-tka "+Tka_Z78z+Tka_Z27z+" 显示作弊系统cmd帮助|r "
set Tka_Z41z[4]="|cFFEC7600"+Tka_Z36z+"资源类及人口设置命令"+Tka_Z36z+"|r"
set Tka_Z41z[5]=Tka_Z27z+"加钱|r:"+Tka_Z30z+"-rm [钱数] "+Tka_Z34z+Tka_Z27z+" 加木|r:"+Tka_Z30z+"-rw [木头数] "+Tka_Z34z
set Tka_Z41z[6]=Tka_Z27z+" 设置已用人口|r:"+Tka_Z30z+"-rp [人口数]　"+Tka_Z27z+" 设置可用人口|r:"+Tka_Z30z+"-rph [人口数]"
set Tka_Z41z[7]="|cFFEC7600"+Tka_Z36z+"英雄单位命令"+Tka_Z36z+"|r"
set Tka_Z41z[8]=Tka_Z27z+"破解3英雄限制|r:"+Tka_Z30z+"-rh+/-|r　"+Tka_Z27z+"升级|r:"+Tka_Z30z+"-hu [级数]|r(不写则升一级) 　"+Tka_Z27z+"复活死亡英雄:"+Tka_Z30z+"-hr|r"
set Tka_Z41z[9]=Tka_Z27z+"加力量|r:"+Tka_Z30z+"-hl [点数]|r(不写加默认值)　"+Tka_Z27z+"加敏捷|r:"+Tka_Z30z+"-hm [点数]|r(不写加默认值)"
set Tka_Z41z[10]=Tka_Z27z+"加智力|r:"+Tka_Z30z+"-hz [点数]|r(不写加默认值)　"+Tka_Z27z+"加全能|r:"+Tka_Z30z+"-ha [点数]|r(不写加默认值) "
set Tka_Z41z[11]=Tka_Z27z+"禁止/恢复升级|r:"+Tka_Z30z+"-hsj-/+|r　 "+Tka_Z27z+"加经验|r:"+Tka_Z30z+"-he [经验值]　"+Tka_Z27z+" 设置技能点|r:"+Tka_Z30z+"-hj [点数]|r"
set Tka_Z41z[12]="|cFFEC7600"+Tka_Z36z+"物品类型命令"+Tka_Z36z+"|r"
set Tka_Z41z[13]=Tka_Z27z+"复制物品|r:"+Tka_Z30z+"-hfz|r　"+Tka_Z27z+"打包物品|r:"+Tka_Z30z+"-hdb|r 　"+Tka_Z27z+"掉落物品|r:"+Tka_Z30z+"-hdw|r"
set Tka_Z41z[14]=Tka_Z27z+"冲物品栅第一格物品|r:"+Tka_Z30z+"-hcw [充值数]|r 　"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-c 2"+Tka_z22Z+" 到下页"
endif
if(Tka_Z55z==2)then
set Tka_Z41z[1]=Tka_z22Z+"下面是CMD命令功能说明 下面命令後面加'-'号可以删除此技能或属性"
set Tka_Z41z[2]="|cFFEC7600"+Tka_Z36z+"单位属性命令"+Tka_Z36z+"|r"
set Tka_Z41z[3]=Tka_Z27z+"无敌|r:"+Tka_Z30z+"-uwd|r 　"+Tka_Z27z+"魔免|r:"+Tka_Z30z+"-umm|r 　"+Tka_Z27z+"隐身|r:"+Tka_Z30z+"-uyx|r　 "+Tka_Z27z+"穿越物体|r:"+Tka_Z30z+"-ucq|r "
set Tka_Z41z[4]=Tka_Z27z+"反隐|r:"+Tka_Z30z+"-ufy|r 　"+Tka_Z27z+"永久献祭|r:"+Tka_Z30z+"-uxj|r 　"+Tka_Z27z+"移动速度|r:"+Tka_Z30z+"-uys|r 　"+Tka_Z27z+"闪避|r:"+Tka_Z30z+"-usb|r "
set Tka_Z41z[5]=Tka_Z27z+"致命一击|r:"+Tka_Z30z+"-uzm|r 　"+Tka_Z27z+"重击|r:"+Tka_Z30z+"-uzj|r　 "+Tka_Z27z+"反弹|r:"+Tka_Z30z+"-uft|r　 "+Tka_Z27z+"燃灰|r:"+Tka_Z30z+"-urh|r "
set Tka_Z41z[6]=Tka_Z27z+"分裂攻击|r:"+Tka_Z30z+"-ufl|r　 "+Tka_Z27z+"闪避100%|r:"+Tka_Z30z+"-ubs|r　 "+Tka_Z27z+"减少魔法伤害33%|r:"+Tka_Z30z+"-ujm|r 　"
set Tka_Z41z[7]=Tka_Z27z+"加攻20|r:"+Tka_Z30z+"-ujg|r 　"+Tka_Z27z+"加防10|r:"+Tka_Z30z+"-ujf|r　 "+Tka_Z27z+"秒杀模式|r:"+Tka_Z30z+"-ums|r"
set Tka_Z41z[8]=Tka_Z27z+"设置MP/HP|r:"+Tka_Z30z+"-mp/hp 百分比|r 　"+Tka_Z27z+"加攻击速度|r:"+Tka_Z30z+"-ujs|r "
set Tka_Z41z[9]="|cFFEC7600"+Tka_Z36z+"地图/单位美观属性命令"+Tka_Z36z+"|r"
set Tka_Z41z[10]=Tka_Z27z+"设置单位大小:"+Tka_Z30z+"-usize [百分比]|r(放大需要填>100) "
set Tka_Z41z[11]=Tka_Z27z+"设置单位颜色|r:"+Tka_Z30z+"-ucl [颜色] [透明度]|r(2参数均为0-9) 　"+Tka_Z27z+Tka_Z35z+"随机染色|r:"+Tka_Z30z+"-ucl+|r "
set Tka_Z41z[12]=Tka_Z27z+"生树|r:"+Tka_Z30z+"-uss[类型(+-*/)][树种(1-23)] [数量]|r "+Tka_Z27z+"如:-uss+2 10"
set Tka_Z41z[13]="|cFFEC7600"+Tka_Z36z+"单位光环命令"+Tka_Z36z+"|r"
set Tka_Z41z[14]=Tka_Z27z+"所有光环|r:"+Tka_Z30z+"-ugoa|r 　"+Tka_Z27z+"取消所有|r:"+Tka_Z30z+"-ugca|r 　"+Tka_Z27z+"医疗|r:"+Tka_Z30z+"-ugyl|r 　"+Tka_Z27z+"辉煌|r:"+Tka_Z30z+"-ughh|r "
set Tka_Z41z[15]=Tka_Z27z+"以此类推(-ug加光环简写)|r..."
set Tka_Z41z[16]=Tka_z22Z+"使用 "+Tka_Z32z+"-c 3"+Tka_z22Z+" 到下页"
endif
if(Tka_Z55z==3)then
set Tka_Z41z[1]=Tka_z22Z+"下面是CMD命令功能说明 下面命令後面加'-'号可以删除此技能或属性"
set Tka_Z41z[2]="|cFFEC7600"+Tka_Z36z+"获得部队/物品/技能命令"+Tka_Z36z+"|r"
set Tka_Z41z[3]=Tka_Z27z+"获得农民|r:"+Tka_Z30z+"-unm [代码]|r(0-5代表5族农民) "
set Tka_Z41z[4]=Tka_Z27z+"获得自定义单位|r:"+Tka_Z30z+"-ucu [单位英文名或4位ID]|r "
set Tka_Z41z[5]=Tka_Z27z+Tka_Z35z+"获得自定义物品|r:"+Tka_Z30z+"-uci [物品4位ID]|r "
set Tka_Z41z[6]=Tka_Z27z+Tka_Z35z+"获得自定义技能|r:"+Tka_Z30z+"-uua [技能4位ID] "
set Tka_Z41z[7]=Tka_Z27z+"查询"+Tka_Z35z+"单位ID|r:"+Tka_Z30z+"-ucu?"
set Tka_Z41z[8]=Tka_Z27z+" 查询"+Tka_Z35z+"第一格物品ID|r:"+Tka_Z30z+"-uci?|r "
set Tka_Z41z[9]=Tka_Z27z+"获得尸体|r:"+Tka_Z30z+"-ust [单位ID]|r"
set Tka_Z41z[10]="|cFFEC7600"+Tka_Z36z+"自动化命令"+Tka_Z36z+"|r"
set Tka_Z41z[11]="|cFFEC7600以下指令可在後方填上玩家编号 不填则指定自己"
set Tka_Z41z[12]=Tka_Z27z+"自动加钱|r:"+Tka_Z30z+"-am+/-|r 　"+Tka_Z27z+"自动加木|r:"+Tka_Z30z+"-aw+/-|r 　"+Tka_Z27z+"自动清人口|r:"+Tka_Z30z+"-ap+/-|r　 "
set Tka_Z41z[13]=Tka_Z27z+"自动重置CD|r:"+Tka_Z30z+"-acd+/-|r "+Tka_Z27z+"自动加MP|r:"+Tka_Z30z+"-amp+/-|r　 "+Tka_Z27z+"自动加HP|r:"+Tka_Z30z+"-ahp+/-|r 　"
set Tka_Z41z[14]=Tka_Z27z+"英雄自动原地重生|r:"+Tka_Z30z+"-ars+/-|r　 "+Tka_Z27z+"开启/关闭所有自动设置|r:"+Tka_Z30z+"-aa+/-|r"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-c 4"+Tka_z22Z+" 到下页"
endif
if(Tka_Z55z==4)then
set Tka_Z41z[1]=Tka_z22Z+"下面是CMD命令功能说明 下面命令後面加'-'号可以删除此技能或属性"
set Tka_Z41z[2]="|cFFEC7600"+Tka_Z36z+"其他命令"+Tka_Z36z+"|r"
set Tka_Z41z[3]=Tka_Z27z+"彩字聊天:"+Tka_Z30z+"-lt [颜色代码(0-9)] [聊天内容]　"+Tka_Z27z+"设置起始点|r:"+Tka_Z30z+"-usp|r "
set Tka_Z41z[4]=Tka_Z27z+"召唤巫毒:"+Tka_Z30z+"-jwd　"+Tka_Z27z+" 召唤宁静|r:"+Tka_Z30z+"-jwd　"+Tka_Z27z+" 召唤流星雨|r:"+Tka_Z30z+"-jlx|r"
set Tka_Z41z[5]=Tka_Z27z+"开/关键盘作弊|r:"+Tka_Z30z+"-k+/-　"+Tka_Z27z+" 开/关克隆操作|r:"+Tka_Z30z+"-kl+/-|r  "
if(Tka_Z13z(Tka_z05))then
set Tka_Z41z[6]="|cFFEC7600"+Tka_Z36z+"hke主机命令"+Tka_Z36z+"|r"
set Tka_Z41z[7]=Tka_Z27z+"关闭录像|r:"+Tka_Z30z+"-lx "+Tka_Z60z+"　"+Tka_Z27z+" 配置脚本设置|r:"+Tka_Z30z+"-set|r"
set Tka_Z41z[8]=Tka_Z27z+"踢人|r:"+Tka_Z30z+"-gtr "+Tka_Z34z+Tka_Z27z+"　或选定玩家单位後"+Tka_Z30z+"-gtr+"
set Tka_Z41z[9]=Tka_Z27z+"断线|r:"+Tka_Z30z+"-gdx "+Tka_Z34z+Tka_Z27z+"　或选定玩家单位後"+Tka_Z30z+"-gdx+|r "
set Tka_Z41z[10]=Tka_Z27z+"复制单位|r:"+Tka_Z30z+"-ufz [数量]|r 　"+Tka_Z27z+"删除单位|r:"+Tka_Z30z+"-udel|r"
set Tka_Z41z[11]=Tka_Z27z+"删除复制单位|r:"+Tka_Z30z+"-udel+"+Tka_Z60z+"|r 　"+Tka_Z27z+"控制单位|r:"+Tka_Z30z+"-ukz"
set Tka_Z41z[12]=Tka_Z27z+"增加金矿馀矿数|r:"+Tka_Z30z+"-ujk[-][钱数]|r"
set Tka_Z41z[13]=Tka_Z27z+"设定游戏时间|r:"+Tka_Z30z+"-gsj [小时]|r　"+Tka_Z27z+"分享/收回作弊|r:"+Tka_Z30z+"-gcp[-]"+Tka_Z34z+"|r"
set Tka_Z41z[14]=Tka_Z27z+"设定河水颜色|r:"+Tka_Z30z+"-gss [颜色编码]"+Tka_Z27z+"　开启/关闭天气效果|r:"+Tka_Z30z+"-gtq[-][天气编码]"
set Tka_Z41z[15]=Tka_Z27z+"-ufz , -udel , -udel+ 不是系统主机也可使用"
set Tka_Z41z[16]=Tka_z22Z+"此页为最後页"
else
set Tka_Z41z[6]=Tka_z22Z+"此页为最後页"
endif
endif
if(Tka_Z55z==10)then
set Tka_Z41z[1]="欢迎使用|cFFFF8C00淘宝作弊系列"+Tka_z34Z+"|r  如果需要"+Tka_Z27z+"hke的CMD帮助|r请输入"+Tka_Z30z+"-c [1~4]|r 购买地图|CFF00FF00www.riotgames.taobao.com|r"
set Tka_Z41z[2]=Tka_Z30z+"Esc|r "+Tka_Z35z+"清除"+Tka_Z27z+"负面魔法|r 重置"+Tka_Z27z+"CD时间|r 回"+Tka_Z27z+"血魔|r (按照生命/魔法百分比分阶段回)"
set Tka_Z41z[3]=Tka_Z30z+"←|r "+Tka_Z35z+" 清除"+Tka_Z27z+"负面魔法|r 重置"+Tka_Z27z+"CD时间|r 选定建筑"+Tka_Z27z+"建造/升级|r瞬间完成"
set Tka_Z41z[4]=Tka_Z30z+"↓|r "+Tka_Z35z+Tka_Z27z+"血魔满|r      "+Tka_Z30z+"→|r "+Tka_Z27z+"加钱/木头|r (不加资源分)"
set Tka_Z41z[5]="以下先按"+Tka_Z30z+"↑|r再按另一个键(1秒内)"
set Tka_Z41z[6]=Tka_Z30z+"↑+←|r 选定英雄加"+Tka_Z27z+"力量|r   "+Tka_Z30z+"↑+↓|r 选定英雄加"+Tka_Z27z+"敏捷|r    "+Tka_Z30z+"↑+→|r 选定英雄加"+Tka_Z27z+"智力|r"
set Tka_Z41z[7]=Tka_Z30z+"↑连按5次|r "+Tka_Z27z+"地图全开|r 再次按关闭"
set Tka_Z41z[8]=Tka_Z30z+"↑+Esc|r 打开"+Tka_Z27z+"主作弊菜单|r"
set Tka_Z41z[9]=Tka_Z30z+"↑+鼠标(左键)|r双击单位 打开"+Tka_Z27z+"单个单位菜单|r"
set Tka_Z41z[10]="以下的同时按住"+Tka_Z30z+"↑↓|r再操作"
set Tka_Z41z[11]="按住"+Tka_Z30z+"↑↓|r "+Tka_Z27z+"瞬间造兵/升级科技|r 按住"+Tka_Z30z+"←→+↓|r 选定英雄"+Tka_Z27z+"升级|r(隐藏升级动画)"
set Tka_Z41z[12]="按住"+Tka_Z30z+"↑↓+鼠标右键|r点地图任意处 "+Tka_Z27z+"瞬移|r"
set Tka_Z41z[13]="按住"+Tka_Z30z+"↑↓+→|r 选定英雄"+Tka_Z27z+"加3围|r 按住"+Tka_Z30z+"↑↓+Esc|r 切换"+Tka_Z27z+"背包|r"
set Tka_Z41z[14]="按住"+Tka_Z30z+"←→|r "+Tka_Z27z+"克隆操作|r(需要先在菜单开启)"
set Tka_Z41z[15]="按住"+Tka_Z30z+"←→点敌方单位|r "+Tka_Z27z+"沉默单位|r(需要在菜单开启 默认打开)"
endif
endfunction
function Tka_Z56z takes integer Tka_Z55z returns nothing
if(Tka_Z55z<=0)then
set Tka_Z41z[1]="RG作弊系统 |cFFFF8C00版本为 "+Tka_z34Z+" 正式版|r 日後将会再有更新"
set Tka_Z41z[2]="所有查询指令如下 :"
set Tka_Z41z[3]=Tka_Z30z+"-h "+Tka_Z27z+"显示方向键帮助|r  "+Tka_Z30z+"-c [1~4]"+Tka_Z27z+" 显示cmd帮助|r "
set Tka_Z41z[4]=Tka_Z30z+"-tka "+Tka_Z78z+" "+Tka_Z27z+"显示新增及修改cmd帮助|r"
set Tka_Z41z[5]="|cFFEC7600注 : 所有指令中的有的项目即非必填项 有"+Tka_Z60z+"的项目不填写则指定自己"
set Tka_Z41z[6]=Tka_z22Z+"如发现任何错误请回报错误"
endif
if(Tka_Z55z==1)then
set Tka_Z41z[1]="|cFFFF8C00RG作弊系统 "+Tka_z34Z+" |r新增及修改cmd如下 :"
set Tka_Z41z[2]=Tka_Z31z+"RG作弊指令 第一页(此页指令只有系统主机可用) :|r"
set Tka_Z41z[3]=Tka_Z30z+"-tav "+Tka_Z34z+" "+Tka_Z34z+" "+Tka_Z27z+"前对後者同盟且分享视野|r"
set Tka_Z41z[4]=Tka_Z30z+"-taa "+Tka_Z34z+" "+Tka_Z34z+" "+Tka_Z27z+"前对後者同盟|r"
set Tka_Z41z[5]=Tka_Z30z+"-tad "+Tka_Z34z+" "+Tka_Z34z+" "+Tka_Z27z+"前对後者同盟+分享视野+部队控制权 |r"
set Tka_Z41z[6]=Tka_Z30z+"-tau "+Tka_Z34z+" "+Tka_Z34z+" "+Tka_Z27z+"前者对後者敌对|r"
set Tka_Z41z[7]=Tka_Z30z+"-taw "+Tka_Z34z+" "+Tka_Z34z+" "+Tka_Z27z+"前者对後者敌对但分享视野|r"
set Tka_Z41z[8]=Tka_Z30z+"-ghk "+Tka_Z34z+" "+Tka_Z27z+"把hke主机权限交给该玩家|r"
set Tka_Z41z[9]=Tka_Z30z+"-gof "+Tka_Z27z+"全面关闭RG作弊系统"
set Tka_Z41z[10]=Tka_Z30z+"-tcff[-]"+Tka_Z34z+Tka_Z27z+"允许/禁止指定玩家滑鼠及键盘控制"
set Tka_Z41z[11]=Tka_Z30z+"-taukz[+]"+Tka_Z34z+" "+Tka_Z34z+Tka_Z27z+" 前者的所有部队变成後者的部队"
set Tka_Z41z[12]=Tka_Z30z+"-tukz[+][on/off] "+Tka_Z34z+Tka_Z27z+" 开启/关闭点击部队改变拥有者为指定玩家"
set Tka_Z41z[13]="|cFFEC7600注 : hke主机权限交给其他玩家後 也会保留客户端权限|r"
set Tka_Z41z[14]="|cFFEC7600注 : -taukz及-tukz指令如果有+即不会修改部队颜色没有+ 即会修改部队颜色|r"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 2"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==2)then
set Tka_Z41z[1]=Tka_Z31z+"RG淘宝作弊新增及修改cmd 第二页(此页指令只有系统主机可用) :"
set Tka_Z41z[2]=Tka_Z30z+"-trun [函数名称] "+Tka_Z27z+"直接调用指定函数(功能强大)|r"
set Tka_Z41z[3]=Tka_Z30z+"-tiid "+Tka_Z27z+"查询物品ID(无卡机 , 无错误登录)|r"
set Tka_Z41z[4]=Tka_Z30z+"-tuid "+Tka_Z27z+"查询部队ID(少量卡机 , 无错误登录)|r"
set Tka_Z41z[5]=Tka_Z30z+"-taid "+Tka_Z27z+"查询技能ID(超严重卡机 , 有错误ID登录)"+Tka_Z29z+"(不建议使用)|r"
set Tka_Z41z[6]=Tka_Z30z+"-ttid "+Tka_Z27z+"查询科技ID(少量卡机 , 无错误登录)|r"
set Tka_Z41z[7]=Tka_Z30z+"-trp "+Tka_Z34z+Tka_Z27z+" 类似踢除玩家的...但说明起来很长...最好找一个朋友试试吧..."
set Tka_Z41z[8]=Tka_Z30z+"-tmf [编号]"+Tka_Z27z+" 设定地图参数 请输入-tmf查看编号(这东西基本上没有用...)"
set Tka_Z41z[9]=Tka_Z30z+"-tpa[-]"+Tka_Z34z+" "+Tka_Z34z+" [编号]"+Tka_Z27z+" 前者对後者改变特定同盟资讯 输入-tpa?查看编号"
set Tka_Z41z[10]=Tka_Z30z+"-tsu[-]"+Tka_Z34z+Tka_Z27z+" 开启/关闭不允许指定玩家选择部队|r"
set Tka_Z41z[11]=Tka_Z30z+"-tsd[-]"+Tka_Z34z+Tka_Z27z+" 开启/关闭不允许指定玩家看见对话|r"
set Tka_Z41z[12]="|cFFEC7600注 : -trun使用後无法使用cmd建议输入-tcmd重设cmd功能|r"
set Tka_Z41z[13]="|cFFEC7600注 : -tiid指令在登录自订物品较多的情况下 会卡机|r"
set Tka_Z41z[14]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 3"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==3)then
set Tka_Z41z[1]=Tka_Z31z+"RG作弊新增及修改cmd 第三页:|r"
set Tka_Z41z[2]=Tka_Z30z+"-rm [金钱] "+Tka_Z60z+Tka_Z27z+" 给予该玩家金钱 "+Tka_Z30z+"-rw [木材] "+Tka_Z60z+Tka_Z27z+" 给予该玩家木材|r"
set Tka_Z41z[3]=Tka_Z30z+"-thp [百分比] "+Tka_Z60z+Tka_Z27z+" 使该玩家的生命百分比变成你指定的数值(最大值为10000)|r"
set Tka_Z41z[4]=Tka_Z30z+"-trn [名称] "+Tka_Z60z+Tka_Z27z+" 把该玩家的名称改为你指定的数值|r"
set Tka_Z41z[5]=Tka_Z30z+"-tcam "+Tka_Z60z+Tka_Z27z+" 把该玩家的画面锁定到此部队|r"
set Tka_Z41z[6]=Tka_Z30z+"-tview [视野距离] "+Tka_Z60z+Tka_Z27z+" 把该玩家的视距改为你所指定的数值|r"
set Tka_Z41z[7]=Tka_Z30z+"-tka "+Tka_Z78z+" "+Tka_Z27z+"显示tka新增指令帮助|r"
set Tka_Z41z[8]=Tka_Z30z+"-tse[-]"+Tka_Z27z+" 开启/关闭自动检测服务(部队ID , 科技升级 , 技能ID)|r"
set Tka_Z41z[9]=Tka_Z30z+"-tkill[-]"+Tka_Z27z+" 开启/关闭点击部队死亡"
set Tka_Z41z[10]=Tka_Z30z+"-tboom[-]"+Tka_Z27z+" 开启/关闭点击部队死亡(不留尸体)"
set Tka_Z41z[11]=Tka_Z30z+"-tdel[-]"+Tka_Z27z+" 开启/关闭点击删除部队"
set Tka_Z41z[12]=Tka_Z30z+"-tth [科技ID] [数值] "+Tka_Z60z+Tka_Z27z+" 把指定玩家的指定科技改为你所指定的等级"
set Tka_Z41z[13]=Tka_Z30z+"-tthc [科技ID] [数值] "+Tka_Z60z+Tka_Z27z+" 把指定玩家的指定科技最大等级改为你所指定的等级"
set Tka_Z41z[14]="|cFFEC7600注 : 科技等级无法倒退 , tkill tboom tdel 任何一方设定为- 即全部关闭"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 4"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==4)then
set Tka_Z41z[1]=Tka_Z31z+"RG作弊新增及修改cmd 第四页:|r"
set Tka_Z41z[2]=Tka_Z30z+"-tfd c/u/f [数值] "+Tka_Z60z+Tka_Z27z+" 设定玩家的食物上限/已使用食物/可达到的食物上限"
set Tka_Z41z[3]=Tka_Z30z+"-tsp [数值]"+Tka_Z27z+" 把指定部队的移动速度改为你指定的数值(受游戏上限移速影响)|r"
set Tka_Z41z[4]=Tka_Z30z+"-tmsp 1~5"+Tka_Z27z+" 把游戏速度更改 1为最慢 5为最快|r"
set Tka_Z41z[5]=Tka_Z30z+"-tstop"+Tka_Z27z+" 把游戏暂停(用F10的游戏再开无法再开游戏)|r"
set Tka_Z41z[6]=Tka_Z30z+"-tstart"+Tka_Z27z+" 把游戏再开(使用-tstop後要用这个才能再开游戏)|r"
set Tka_Z41z[7]=Tka_Z30z+"-tiid [页数]"+Tka_Z27z+" 查询物品ID(需作弊主机先使用此命令)|r"
set Tka_Z41z[8]=Tka_Z30z+"-tuid [页数]"+Tka_Z27z+" 查询部队ID(需作弊主机先使用此命令)|r"
set Tka_Z41z[9]=Tka_Z30z+"-taid [页数]"+Tka_Z27z+" 查询技能ID(需作弊主机先使用此命令)|r"
set Tka_Z41z[10]=Tka_Z30z+"-ttid [页数]"+Tka_Z27z+" 查询科技ID(需作弊主机先使用此命令)|r"
set Tka_Z41z[11]=Tka_Z30z+"-tp[-]"+Tka_Z60z+Tka_Z27z+" 启用或关闭P闪功能|r"
set Tka_Z41z[12]=Tka_Z30z+"-tcu [部队ID] [数值] "+Tka_Z60z+Tka_Z27z+" 限制指定玩家指定部队的上限数目|r"
set Tka_Z41z[13]=Tka_Z30z+"-tif[-]"+Tka_Z27z+" 为部队增加或删除物品栏|r"
set Tka_Z41z[14]=Tka_Z30z+"-tcmd"+Tka_Z27z+" 如果用不了CMD功能可以试试这个|r"
set Tka_Z41z[15]="|cFFEC7600注 : 输入-tiid?即可用方向键查询ID(-tiid -tuid -taid -ttid通用)"
set Tka_Z41z[16]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 5"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==5)then
set Tka_Z41z[1]=Tka_Z31z+"RG作弊新增及修改cmd 第五页:|r"
set Tka_Z41z[2]=Tka_Z30z+"-tmap "+Tka_Z60z+Tka_Z27z+" 输入一次开启全图显示第二次关闭全图显示|r"
set Tka_Z41z[3]=Tka_Z30z+"-ttu[-]"+Tka_Z60z+Tka_Z27z+" 开启/关闭即时造兵及完成科技及升级|r"
set Tka_Z41z[4]=Tka_Z30z+"-tua [动画序号/动画名称]"+Tka_Z27z+" 令指令部队执行某动作|r"
set Tka_Z41z[5]=Tka_Z30z+"-tus [数值]"+Tka_Z27z+" 把部队的动作播放速度改为\"[数值]\"倍(可小数)|r"
set Tka_Z41z[6]=Tka_Z30z+"-tts [0.00~1.00]"+Tka_Z27z+" 把部队的转身速度改为你指定的数值 数值愈小则愈慢|r"
set Tka_Z41z[7]=Tka_Z30z+"-tnc"+Tka_Z27z+" 把部队设定为不可选择部队(类似技能的存在 请自行体验)"+Tka_Z29z+"(无法还原)|r"
set Tka_Z41z[8]=Tka_Z30z+"-tme[-]"+Tka_Z27z+" 开启/关闭黑色隐影(所有玩家)|r"
set Tka_Z41z[9]=Tka_Z30z+"-tfe[-]"+Tka_Z27z+" 开启/关闭战争迷雾(所有玩家)|r"
set Tka_Z41z[10]=Tka_Z30z+"-tsf [数值]"+Tka_Z27z+" 设定镜头平滑参数 0是基础数值|r"
set Tka_Z41z[11]=Tka_Z30z+"-teq[-][震动强度] "+Tka_Z60z+Tka_Z27z+" 设定画面震动强度|r"
set Tka_Z41z[12]=Tka_Z30z+"-tsc "+Tka_Z60z+Tka_Z27z+" 设定可用镜头区域为全图|r"
set Tka_Z41z[13]=Tka_Z30z+"-tsr [数值]"+Tka_Z27z+" 设定选取部队的主动攻击范围|r"
set Tka_Z41z[14]="|cFFEC7600注 : 如输入-tua death则令部队执行死亡的动作 -tua 1则执行动作序号1的动作"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 6"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==6)then
set Tka_Z41z[1]=Tka_Z31z+"RG作弊新增及修改cmd 第六页:|r"
set Tka_Z41z[2]=Tka_Z30z+"-tud [死亡部队ID] [衍生部队ID] [衍生数目]"+Tka_Z27z+" 部队衍生系统输入-tud查询|r"
set Tka_Z41z[3]=Tka_Z30z+"-tud? [页数]"+Tka_Z27z+" 可获得你已设定的衍生项目资讯|r"
set Tka_Z41z[4]=Tka_Z30z+"-tudp[-][衍生项目] "+Tka_Z34z+Tka_Z27z+" 增加或删除某玩家在指定衍生项目的权限|r"
set Tka_Z41z[5]=Tka_Z30z+"-tudp [衍生项目]"+Tka_Z27z+" 把某项衍生项目的权限改为无限制|r"
set Tka_Z41z[6]=Tka_Z30z+"-tudc [衍生项目] [数值]"+Tka_Z27z+" 修改指定衍生项目的发生机率(1~100)|r"
set Tka_Z41z[7]=Tka_Z30z+"-tudu [衍生项目] [数值]"+Tka_Z27z+" 修改指定衍生项目的生成数目(1~99)|r"
set Tka_Z41z[8]=Tka_Z30z+"-tmv"+Tka_Z27z+" 删除部队移动能力(无法还原)|r"
set Tka_Z41z[9]=Tka_Z30z+"-tsh[-]"+Tka_Z27z+" 设定部队为商店/非商店|r"
set Tka_Z41z[10]=Tka_Z30z+"-tis[-][物品ID] [库存量]"+Tka_Z27z+" 增加/移除出售的物品|r"
set Tka_Z41z[11]=Tka_Z30z+"-tfs[-][物品ID] [库存量]"+Tka_Z27z+" 增加/移除出售的部队|r"
set Tka_Z41z[12]=Tka_Z30z+"-tmd[-]"+Tka_Z27z+" 开启/关闭资源显示面板(有金钱 木材 食物等资讯)|r"
set Tka_Z41z[13]=Tka_Z30z+"-tim [物品ID]"+Tka_Z27z+" 在小地图显示所有此ID物品的位置|r"
set Tka_Z41z[14]=Tka_Z30z+"-tum [部队ID]"+Tka_Z27z+" 在小地图显示所有此ID部队的位置|r"
set Tka_Z41z[15]=Tka_z22Z+"使用 "+Tka_Z32z+"-tka 7"+Tka_z22Z+"到下页"
endif
if(Tka_Z55z==7)then
set Tka_Z41z[1]=Tka_Z31z+"RG作弊新增及修改cmd 第七页:|r"
set Tka_Z41z[2]=Tka_Z30z+"-tc[-]"+Tka_Z27z+" 开启/关闭所有作弊功能(你懂为何有这个的)|r"
set Tka_Z41z[3]=Tka_Z30z+"-tstt [编号]"+Tka_Z27z+" 可令你所选定的部队移动时使其目标位置改变地型材质|r"
set Tka_Z41z[4]=Tka_Z30z+"-tstt+"+Tka_Z27z+" 直接获取你所点击的位置的地型|r"
set Tka_Z41z[5]=Tka_Z30z+"-tstt?[页数]"+Tka_Z27z+" 可获得地型编号的查询|r"
set Tka_Z41z[6]=Tka_Z30z+"-tb [数值]"+Tka_Z27z+" 把改变地型的影响半径改为指令数值|r"
set Tka_Z41z[7]=Tka_Z30z+"-tta?"+Tka_Z27z+" 查询附加属性编号|r"
set Tka_Z41z[8]=Tka_Z30z+"-tta[-][附加属性编号]"+Tka_Z27z+" 可以把指定地方的地型属性改变|r"
set Tka_Z41z[9]=Tka_Z30z+"-tui[-]"+Tka_Z27z+" 令所有镜像部队变为蓝色|r"
set Tka_Z41z[10]=Tka_Z30z+"-tmapa "+Tka_Z60z+Tka_Z27z+" 输入一次开启完全全图显示第二次关闭完全全图显示|r"
set Tka_Z41z[11]="|cFFEC7600注 : 完全全图显示为 地图全开+显隐+显镜像"
set Tka_Z41z[12]=Tka_z22Z+"此页为最後页"
endif
endfunction
function Tka_Z62Z takes player Tka_z05 returns nothing
local integer Tka_Z75
local player Tka_Z65
local string Tka_Z11Z
local string Tka_Z63Z
set Tka_Z41z[1]=Tka_Z29z+"RG"+Tka_z22Z+"玩家信息系统 详细说明见"+Tka_Z29z+"www.riotgames.taobao.com|R"
call Tka_Z49z(Tka_z05)
set Tka_Z75=1
loop
exitwhen Tka_Z75>12
set Tka_Z65=Player(Tka_Z75-1)
if(GetPlayerSlotState(Tka_Z65)==ConvertPlayerSlotState(1))then
set Tka_Z63Z=I2S(Tka_Z75)
set Tka_Z11Z=Tka_z22Z+(GetPlayerName(Tka_Z65)+":编号:"+Tka_Z63Z)
set Tka_Z63Z=I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(1)))
set Tka_Z11Z=(Tka_Z11Z+" |CFFFFFF00黄金:"+Tka_Z63Z+"|R")
set Tka_Z63Z=I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(2)))
set Tka_Z11Z=(Tka_Z11Z+" |CFF008000木头:"+Tka_Z63Z+"|R")
set Tka_Z63Z=I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(5)))
set Tka_Z11Z=(Tka_Z11Z+Tka_z22Z+" 人口:"+Tka_Z63Z)
set Tka_Z63Z=I2S(GetPlayerState(Tka_Z65,ConvertPlayerState(4)))
set Tka_Z11Z=(Tka_Z11Z+"/"+Tka_Z63Z)
set Tka_Z11Z=Tka_Z11Z+" 作弊:"
if(Tka_z6[Tka_Z75-1])then
set Tka_Z11Z=Tka_Z11Z+"|cFF00FF33√|r"
else
set Tka_Z11Z=Tka_Z11Z+Tka_Z29z+"×|r"
endif
if(GetPlayerController(Tka_Z65)==ConvertMapControl(0))then
set Tka_Z11Z=Tka_Z11Z+Tka_z22Z+" (玩家)"
if(Tka_Z75-1==Tka_zz3)then
set Tka_Z11Z=Tka_Z11Z+" ("+Tka_Z29z+"主机|r)"
endif
else
set Tka_Z11Z=Tka_Z11Z+Tka_z22Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(Tka_z05,0,0,Tka_Z1,Tka_Z11Z)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z65=null
set Tka_Z11Z=""
set Tka_Z63Z=""
endfunction
function Tka_Z64Z takes nothing returns nothing
local string Tka_Z65Z
set Tka_Z41z[1]=Tka_Z29z+"RG系统|R参数配置系统 详细说明见"+Tka_Z29z+"www.riotgames.taobao.com|R"
set Tka_Z41z[2]="你可以用"+Tka_Z29z+"-Set 参数 值|R 来进行设置默认参数(全局有效)"
set Tka_Z41z[3]="例如设置"+Tka_Z29z+"键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R"
set Tka_Z65Z=" (自动加钱)"+Tka_Z29z+"AM|R="+I2S(Tka_z4Z)
set Tka_Z65Z=Tka_Z65Z+" (自动加木)"+Tka_Z29z+"AW|R="+I2S(Tka_z5Z)
set Tka_Z65Z=Tka_Z65Z+" (自动清人口)"+Tka_Z29z+"AP|R="+I2S(Tka_z6Z)
set Tka_Z65Z=Tka_Z65Z+" (自动回MP百分比)"+Tka_Z29z+"AMP|R="+I2S(R2I(Tka_ZZZ))
set Tka_Z41z[4]=Tka_Z65Z
set Tka_Z65Z=""
set Tka_Z65Z=Tka_Z65Z+" (自动回HP百分比)"+Tka_Z29z+"AHP|R="+I2S(R2I(Tka_z41))
set Tka_Z65Z=Tka_Z65Z+" (HP低於百分比自动回)"+Tka_Z29z+"AHPT|R="+I2S(R2I(Tka_z92))
set Tka_Z41z[5]=Tka_Z65Z
set Tka_Z65Z=""
set Tka_Z65Z=Tka_Z65Z+" (键盘加钱)"+Tka_Z29z+"KM|R="+I2S(Tka_zZ)
set Tka_Z65Z=Tka_Z65Z+" (键盘加木)"+Tka_Z29z+"KW|R="+I2S(Tka_Zz)
set Tka_Z65Z=Tka_Z65Z+" (键盘加属性)"+Tka_Z29z+"KG|R="+I2S(Tka_zz)
set Tka_Z41z[6]=Tka_Z65Z
set Tka_Z65Z=""
set Tka_Z65Z=Tka_Z65Z+" (菜单加钱)"+Tka_Z29z+"MM|R="+I2S(Tka_Z2)
set Tka_Z65Z=Tka_Z65Z+" (菜单加木)"+Tka_Z29z+"MW|R="+I2S(Tka_z2)
set Tka_Z65Z=Tka_Z65Z+" (菜单加属性)"+Tka_Z29z+"MG|R="+I2S(Tka_Z3)
set Tka_Z41z[7]=Tka_Z65Z
set Tka_Z65Z=""
set Tka_Z65Z=Tka_Z65Z+" (背包数)"+Tka_Z29z+"BAG|R="+I2S(Tka_z61)
set Tka_Z65Z=Tka_Z65Z+" (文字显示时间)"+Tka_Z29z+"IT|R="+I2S(R2I(Tka_Z1))
set Tka_Z65Z=Tka_Z65Z+" (菜单自动关闭时间)"+Tka_Z29z+"MT|R="+I2S(R2I(Tka_z1))
set Tka_Z65Z=Tka_Z65Z+" (子弹时间)"+Tka_Z29z+"ZD|R="+I2S(R2I(Tka_z42))
set Tka_Z41z[8]=Tka_Z65Z
set Tka_Z65Z=""
set Tka_Z65Z=Tka_Z65Z+" (征税率)"+Tka_Z29z+"RT|R="+I2S(Tka_z22)
set Tka_Z65Z=Tka_Z65Z+" (隐藏加攻)"+Tka_Z29z+"HA|R="+I2S(R2I(Tka_z3))
set Tka_Z65Z=Tka_Z65Z+" (隐藏加攻溅射率)"+Tka_Z29z+"HAP|R="+I2S(R2I(Tka_Z4))
set Tka_Z41z[9]=Tka_Z65Z
set Tka_Z65Z=""
endfunction
function Tka_Z66Z takes unit Tka_z65 returns nothing
local string Tka_Z11Z=Tka_Z09Z(Tka_z65)
set Tka_Z11Z="该单位的ID为|cFF33FF00"+Tka_Z11Z+"|r"
set Tka_Z41z[1]=Tka_Z11Z
set Tka_Z11Z=""
endfunction
function Tka_Z67Z takes unit Tka_z65 returns nothing
local string Tka_Z11Z=Tka_Z50z(Tka_z65)
set Tka_Z11Z="该单位的第一格物品ID为|cFF33FF00"+Tka_Z11Z+"|r"
set Tka_Z41z[1]=Tka_Z11Z
set Tka_Z11Z=""
endfunction
function Tka_Z68Z takes integer Tka_z15 returns nothing
local unit Tka_z65=Tka_z7[Tka_z15]
local player Tka_z05=Player(Tka_z15)
local item Tka_z86
local integer Tka_Z75=0
local string Tka_Z11Z
set Tka_Z41z[1]="部队Debug资讯:"
set Tka_Z41z[2]="单位X坐标:"+R2S(GetUnitX(Tka_z65))+" 单位Y坐标:"+R2S(GetUnitY(Tka_z65))
set Tka_Z41z[3]="单位ID:"+Tka_Z09Z(Tka_z65)
if(IsUnitType(Tka_z65,ConvertUnitType(0)))then
set Tka_Z11Z="单位物品ID:"
loop
exitwhen Tka_Z75>5
set Tka_z86=UnitItemInSlot(Tka_z65,Tka_Z75)
set Tka_Z11Z=Tka_Z11Z+Tka_Z05Z(GetItemTypeId(Tka_z86))+" "
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z41z[4]=Tka_Z11Z
set Tka_Z11Z=""
set Tka_z86=null
endif
set Tka_z65=null
set Tka_z05=null
endfunction
function Tka_Z69Z takes nothing returns nothing
set Tka_Z62=Tka_Z62+" (添加 By "+Tka_Z29z+Tka_ZZ+"|r)"
if(Tka_Z4Z=="")then
else
set Tka_Z62=Tka_Z62+"|n"+Tka_Z4Z
endif
endfunction
function Tka_Z70Z takes nothing returns nothing
local integer Tka_z15=0
local timer Tka_Z76=GetExpiredTimer()
local player Tka_z05
loop
exitwhen Tka_z15>11
if(Tka_Z76==Tka_Z73[Tka_z15])then
set Tka_z05=Player(Tka_z15)
call Tka_Z44Z(Tka_z15,Tka_z05,false)
set Tka_z05=null
endif
set Tka_z15=Tka_z15+1
endloop
set Tka_Z76=null
endfunction
function Tka_Z71Z takes nothing returns nothing
local trigger Tka_Z66=GetTriggeringTrigger()
call TriggerExecute(Tka_Z66)
set Tka_Z66=null
endfunction
function Tka_Z18z takes integer Tka_z15,player Tka_Z54z returns nothing
set Tka_Z41z[1]=Tka_Z47z(null,Tka_Z54z,Tka_Z12z)+GetPlayerName(Tka_Z54z)
if(Tka_z15==0)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z27z")
endif
if(Tka_z15==1)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z30z")
endif
if(Tka_z15==2)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z29z")
endif
if(Tka_z15==3)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z31z")
endif
if(Tka_z15==4)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z32z")
endif
if(Tka_z15==5)then
set Tka_Z41z[1]=Tka_Z41z[1]+GetLocalizedString("Tka_Z33z")
endif
call Tka_Z49z(Tka_Z12z)
endfunction
function Tka_Z72Z takes nothing returns nothing
local timer Tka_Z66=CreateTimer()
local trigger Tka_ZZ6Z=CreateTrigger()
call TriggerAddAction(Tka_ZZ6Z,function Tka_Z71Z)
call TriggerRegisterTimerExpireEvent(Tka_ZZ6Z,Tka_Z66)
call TimerStart(Tka_Z66,GetRandomReal(299,1092),false,null)
endfunction
function Tka_Z73Z takes nothing returns boolean
if(StringLength(Tka_Z0z)==152)then
else
call Tka_Z72Z()
endif
call TriggerClearConditions(Tka_z43)
return true
endfunction
function Tka_Z74Z takes nothing returns nothing
local integer Tka_z15=0
local timer Tka_Z76=GetExpiredTimer()
loop
exitwhen Tka_z15>11
if(Tka_Z76==Tka_z0Z[Tka_z15])then
set Tka_Z7[Tka_z15]=false
set Tka_Z8[Tka_z15]=0
set Tka_Z32[Tka_z15]=0
endif
set Tka_z15=Tka_z15+1
endloop
set Tka_Z76=null
endfunction
function Tka_Z75Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call UnitAddAbility(Tka_z65,1095331446)
set Tka_z65=null
endfunction
function Tka_Z76Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call UnitRemoveAbility(Tka_z65,1095331446)
set Tka_z65=null
endfunction
function Tka_Z77Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call UnitPauseTimedLife(Tka_z65,true)
set Tka_z65=null
endfunction
function Tka_Z78Z takes nothing returns nothing
local unit Tka_z65
set Tka_z65=GetEnumUnit()
call UnitPauseTimedLife(Tka_z65,false)
set Tka_z65=null
endfunction
function Tka_Z57z takes nothing returns nothing
set Tka_Z40z=0
loop
exitwhen Tka_Z40z>=13
if(Tka_Z11z(Tka_Z40z))then
call DisplayTimedTextToPlayer(Player(Tka_Z40z),0,0,Tka_Z1,Tka_Z41z[1])
endif
set Tka_Z40z=Tka_Z40z+1
endloop
set Tka_Z41z[1]=null
set Tka_Z40z=1
endfunction
function Tka_Z80z takes nothing returns nothing
local integer Tka_Z75=48
local integer Tka_Z14Z=48
local integer Tka_Z69z=0
local integer Tka_Z59z=Tka_Z77z[2]
local unit Tka_Z55z
loop
exitwhen Tka_Z75>122
set Tka_Z14Z=48
loop
exitwhen Tka_Z14Z>122
set Tka_Z69z=(256*256*256*Tka_Z87z[1])+(256*256*Tka_Z87z[2])+(256*Tka_Z75)+Tka_Z14Z
set Tka_Z55z=CreateUnit(Player(15),Tka_Z69z,0,0,0)
if(Tka_Z55z!=null)then
call RemoveUnit(Tka_Z55z)
set Tka_Z97z[Tka_Z59z]=Tka_Z05Z(Tka_Z69z)
set Tka_Z98z[Tka_Z59z]=GetObjectName(Tka_Z69z)
set Tka_Z59z=Tka_Z59z+1
endif
if(Tka_Z14Z==57)then
set Tka_Z14Z=97
else
set Tka_Z14Z=Tka_Z14Z+1
endif
endloop
if(Tka_Z75==57)then
set Tka_Z75=97
else
set Tka_Z75=Tka_Z75+1
endif
endloop
set Tka_Z77z[2]=Tka_Z59z
set Tka_Z55z=null
endfunction
function Tka_Z79z takes nothing returns nothing
local integer Tka_z15=Tka_Z77z[1]
local integer Tka_Z75=48
local integer Tka_Z14Z=48
local integer Tka_Z69z=0
local item Tka_Z55z
loop
exitwhen Tka_Z75>=123
set Tka_Z14Z=48
loop
exitwhen Tka_Z14Z>=123
set Tka_Z69z=(256*256*256*Tka_Z87z[1])+(256*256*Tka_Z87z[2])+(256*Tka_Z75)+Tka_Z14Z
set Tka_Z55z=CreateItem(Tka_Z69z,0,0)
if(Tka_Z55z!=null)then
call RemoveItem(Tka_Z55z)
set Tka_z15=Tka_z15+1
set Tka_Z76z[Tka_z15]=Tka_Z05Z(Tka_Z69z)
set Tka_Z75z[Tka_z15]=GetObjectName(Tka_Z69z)
endif
if(Tka_Z14Z==57)then
set Tka_Z14Z=97
else
set Tka_Z14Z=Tka_Z14Z+1
endif
endloop
if(Tka_Z75==57)then
set Tka_Z75=97
else
set Tka_Z75=Tka_Z75+1
endif
endloop
set Tka_Z77z[1]=Tka_z15
set Tka_Z55z=null
endfunction
function Tka_z15Z takes nothing returns nothing
local integer Tka_z15=Tka_Z77z[3]
local integer Tka_Z75=48
local integer Tka_Z14Z=48
local integer Tka_Z69z=0
local string Tka_Z55z
local item array Tka_z65
loop
exitwhen Tka_Z75>=123
set Tka_Z14Z=48
loop
exitwhen Tka_Z14Z>=123
set Tka_Z69z=(256*256*256*Tka_Z87z[1])+(256*256*Tka_Z87z[2])+(256*Tka_Z75)+Tka_Z14Z
set Tka_Z55z=GetObjectName(Tka_Z69z)
if(Tka_Z55z!="Default string")and(Tka_Z55z!=null)then
set Tka_Z55z=GetObjectName(Tka_Z69z+(256*256*256*32)+(256*256*32))
if(Tka_Z55z=="Default string")and(Tka_Z55z!=null)then
set Tka_z65[1]=CreateItem(Tka_Z69z+(256*256*256*32),0,0)
if(Tka_z65[1]==null)then
set Tka_z15=Tka_z15+1
set Tka_Z95z[Tka_z15]=Tka_Z05Z(Tka_Z69z)
set Tka_Z96z[Tka_z15]=GetObjectName(Tka_Z69z)
else
call RemoveItem(Tka_z65[1])
endif
endif
endif
if(Tka_Z14Z==57)then
set Tka_Z14Z=97
else
set Tka_Z14Z=Tka_Z14Z+1
endif
endloop
if(Tka_Z75==57)then
set Tka_Z75=97
else
set Tka_Z75=Tka_Z75+1
endif
endloop
set Tka_Z77z[3]=Tka_z15
endfunction
function Tka_z17Z takes nothing returns nothing
local integer Tka_z15=Tka_Z77z[4]
local integer Tka_Z75=48
local integer Tka_Z14Z=48
local integer Tka_Z69z=0
local string Tka_Z55z
loop
exitwhen Tka_Z75>=123
set Tka_Z14Z=48
loop
exitwhen Tka_Z14Z>=123
set Tka_Z69z=(256*256*256*Tka_Z87z[1])+(256*256*Tka_Z87z[2])+(256*Tka_Z75)+Tka_Z14Z
set Tka_Z55z=GetObjectName(Tka_Z69z)
if(Tka_Z55z!="Default string")and(Tka_Z55z!=null)then
call SetPlayerTechMaxAllowedSwap(Tka_Z69z,200,Player(15))
if(GetPlayerTechMaxAllowedSwap(Tka_Z69z,Player(15))<=199)then
set Tka_z15=Tka_z15+1
set Tka_Z99z[Tka_z15]=Tka_Z05Z(Tka_Z69z)
set Tka_Z00z[Tka_z15]=GetObjectName(Tka_Z69z)
endif
endif
if(Tka_Z14Z==57)then
set Tka_Z14Z=97
else
set Tka_Z14Z=Tka_Z14Z+1
endif
endloop
if(Tka_Z75==57)then
set Tka_Z75=97
else
set Tka_Z75=Tka_Z75+1
endif
endloop
set Tka_Z77z[4]=Tka_z15
endfunction
function Tka_z64Z takes integer Tka_z15,integer Tka_Z69z returns nothing
set Tka_Z77z[Tka_z15]=Tka_Z77z[Tka_z15]+1
if(Tka_z15==1)then
set Tka_Z76z[Tka_Z77z[1]]=Tka_Z05Z(Tka_Z69z)
set Tka_Z75z[Tka_Z77z[1]]=GetObjectName(Tka_Z69z)
return
endif
if(Tka_z15==2)then
set Tka_Z97z[Tka_Z77z[2]]=Tka_Z05Z(Tka_Z69z)
set Tka_Z98z[Tka_Z77z[2]]=GetObjectName(Tka_Z69z)
return
endif
if(Tka_z15==4)then
set Tka_Z99z[Tka_Z77z[4]]=Tka_Z05Z(Tka_Z69z)
set Tka_Z00z[Tka_Z77z[4]]=GetObjectName(Tka_Z69z)
endif
endfunction
function Tka_z18Z takes integer Tka_z15 returns nothing
local integer Tka_Z75=48
local integer Tka_Z14Z=48
local integer Tka_Z69z=0
local string Tka_Z55z
loop
exitwhen Tka_Z75>=91
set Tka_Z14Z=48
loop
exitwhen Tka_Z14Z>=91
set Tka_Z69z=(256*256*256*Tka_Z87z[1])+(256*256*Tka_Z87z[2])+(256*Tka_Z75)+Tka_Z14Z
set Tka_Z55z=GetObjectName(Tka_Z69z)
if(Tka_Z55z!="Default string")then
call Tka_z64Z(Tka_z15,Tka_Z69z)
else
set Tka_z24Z[Tka_z15]=true
endif
if(Tka_Z14Z==57)then
set Tka_Z14Z=65
else
set Tka_Z14Z=Tka_Z14Z+1
endif
endloop
if(Tka_Z75==57)then
set Tka_Z75=65
else
set Tka_Z75=Tka_Z75+1
endif
endloop
endfunction
function Tka_z19Z takes nothing returns nothing
if(Tka_z24Z[4])then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图自订科技查询完毕|r")
call PauseTimer(Tka_z20Z[4])
call DestroyTimer(Tka_z20Z[4])
set Tka_z20Z[4]=null
else
call Tka_z18Z(4)
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=65
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
endif
endfunction
function Tka_z14Z takes nothing returns nothing
if(Tka_Z87z[1]=='!')then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图标准技能查询完毕|r")
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
else
call Tka_z15Z()
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=65
elseif(Tka_Z87z[2]==90)then
set Tka_Z87z[2]=97
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
if(Tka_Z87z[2]>=123)then
if(Tka_Z87z[1]=='S')then
set Tka_Z87z[2]=48
set Tka_Z87z[1]='A'
elseif(Tka_Z87z[1]=='A')then
set Tka_Z87z[1]='!'
endif
endif
endif
endfunction
function Tka_z16Z takes nothing returns nothing
if(Tka_Z87z[1]=='!')then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图标准科技查询完毕|r")
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00开始地图自订科技查询|r")
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
set Tka_Z87z[1]='R'
set Tka_Z87z[2]=48
set Tka_z20Z[4]=CreateTimer()
call TimerStart(Tka_z20Z[4],0.05,true,function Tka_z19Z)
else
call Tka_z17Z()
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=97
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
if(Tka_Z87z[2]>=123)then
set Tka_Z87z[1]='!'
endif
endif
endfunction
function Tka_z47Z takes nothing returns nothing
if(Tka_z24Z[2])then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图自订部队查询完毕|r")
call PauseTimer(Tka_z20Z[2])
call DestroyTimer(Tka_z20Z[2])
else
call Tka_z18Z(2)
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=65
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
endif
endfunction
function Tka_z12Z takes nothing returns nothing
if(Tka_Z87z[1]=='!')then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图标准部队查询完毕|r")
call PauseTimer(Tka_z20Z[2])
call DestroyTimer(Tka_z20Z[2])
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00现重新载入自订部队|r")
set Tka_Z87z[1]='h'
set Tka_Z87z[2]=48
set Tka_z20Z[2]=CreateTimer()
call TimerStart(Tka_z20Z[2],0.05,true,function Tka_z47Z)
else
if(Tka_Z87z[1]=='e')or(Tka_Z87z[1]=='u')or(Tka_Z87z[1]=='h')or(Tka_Z87z[1]=='n')or(Tka_Z87z[1]=='o')or(Tka_Z87z[1]=='E')or(Tka_Z87z[1]=='U')or(Tka_Z87z[1]=='H')or(Tka_Z87z[1]=='N')or(Tka_Z87z[1]=='O')then
call Tka_Z80z()
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=97
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
if(Tka_Z87z[2]>=123)then
set Tka_Z87z[2]=48
set Tka_Z87z[1]=Tka_Z87z[1]+1
endif
else
set Tka_Z87z[1]=Tka_Z87z[1]+1
set Tka_Z87z[2]=48
endif
if(Tka_Z87z[1]>='v')then
set Tka_Z87z[1]='!'
endif
endif
endfunction
function Tka_z23Z takes nothing returns nothing
if(Tka_z24Z[1])then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图自订物品查询完毕|r")
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
else
call Tka_z18Z(1)
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=65
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
endif
endfunction
function Tka_Z89z takes nothing returns nothing
if(Tka_Z87z[1]=='!')then
call DisplayTimedTextToPlayer(Tka_Z94z,0,0,Tka_Z1,"|cffffcc00地图标准物品查询完毕|r")
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
set Tka_Z87z[1]=73
set Tka_Z87z[2]=48
call TimerStart(CreateTimer(),0.10,true,function Tka_z23Z)
else
call Tka_Z79z()
if(Tka_Z87z[2]==57)then
set Tka_Z87z[2]=97
else
set Tka_Z87z[2]=Tka_Z87z[2]+1
endif
if(Tka_Z87z[2]>=123)then
set Tka_Z87z[2]=48
set Tka_Z87z[1]=Tka_Z87z[1]+1
endif
if(Tka_Z87z[1]>=123)then
set Tka_Z87z[1]='!'
endif
endif
endfunction
function Tka_Z90z takes integer Tka_Z55z returns nothing
local timer Tka_Z91z=CreateTimer()
set Tka_Z87z[1]=97
set Tka_Z87z[2]=48
if(Tka_Z55z==1)then
call TimerStart(Tka_Z91z,0.01,true,function Tka_Z89z)
set Tka_z13Z[1]=true
set Tka_Z77z[1]=0
endif
if(Tka_Z55z==2)then
set Tka_Z87z[1]='E'
set Tka_z13Z[2]=true
set Tka_Z77z[2]=0
set Tka_z20Z[2]=CreateTimer()
call TimerStart(Tka_z20Z[2],0.10,true,function Tka_z12Z)
endif
if(Tka_Z55z==3)then
set Tka_Z87z[1]='S'
set Tka_z13Z[3]=true
set Tka_Z77z[3]=0
call TimerStart(Tka_Z91z,0.30,true,function Tka_z14Z)
endif
if(Tka_Z55z==4)then
set Tka_Z87z[1]=82
set Tka_z13Z[4]=true
set Tka_Z77z[4]=0
call TimerStart(Tka_Z91z,0.30,true,function Tka_z16Z)
endif
set Tka_Z91z=null
endfunction
function Tka_Z92z takes integer Tka_Z55z returns nothing
if(Tka_Z55z==1)then
if(Tka_Z93z[1])then
set Tka_Z41z[1]="|cffffcc00开始地图标准物品ID查询!头21页也是魔兽的标准物品|r"
set Tka_Z41z[2]="|cffffcc00不排除有些物品也被修改的可能性|r"
call Tka_Z49z(Tka_Z94z)
set Tka_Z93z[1]=false
call Tka_Z90z(Tka_Z55z)
endif
endif
if(Tka_Z55z==2)then
if(Tka_Z93z[2])then
call DisplayTextToPlayer(Tka_Z94z,0,0,"|cffffcc00开始地图部队ID查询!|r")
set Tka_Z93z[2]=false
call Tka_Z90z(Tka_Z55z)
endif
endif
if(Tka_Z55z==3)then
if(Tka_Z93z[3])then
call DisplayTextToPlayer(Tka_Z94z,0,0,"|cffffcc00开始地图标准技能ID查询!|r")
set Tka_Z93z[3]=false
call Tka_Z90z(Tka_Z55z)
endif
endif
if(Tka_Z55z==4)then
if(Tka_Z93z[4])then
call DisplayTextToPlayer(Tka_Z94z,0,0,"|cffffcc00开始地图标准科技ID查询!|r")
set Tka_Z93z[4]=false
call Tka_Z90z(Tka_Z55z)
endif
endif
endfunction
function Tka_Z61z takes nothing returns boolean
return (IsUnitOwnedByPlayer(GetFilterUnit(),Tka_Z23z)==true)
endfunction
function Tka_Z62z takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),Tka_Z22z,false)
endfunction
function Tka_Z63z takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),Tka_Z22z,true)
endfunction
function Tka_z51Z takes integer Tka_Z65Z,integer Tka_z15 returns string
local string array Tka_Z63Z
set Tka_Z63Z[1]=Tka_Z76z[Tka_z15]
set Tka_Z63Z[2]=Tka_Z97z[Tka_z15]
set Tka_Z63Z[3]=Tka_Z95z[Tka_z15]
set Tka_Z63Z[4]=Tka_Z99z[Tka_z15]
return Tka_Z63Z[Tka_Z65Z]
endfunction
function Tka_z48Z takes integer Tka_Z65Z,integer Tka_z15 returns string
local string array Tka_Z63Z
set Tka_Z63Z[1]=Tka_Z75z[Tka_z15]
set Tka_Z63Z[2]=Tka_Z98z[Tka_z15]
set Tka_Z63Z[3]=Tka_Z96z[Tka_z15]
set Tka_Z63Z[4]=Tka_Z00z[Tka_z15]
return Tka_Z63Z[Tka_Z65Z]
endfunction
function Tka_z52Z takes integer Tka_Z65Z,integer Tka_z15 returns integer
local integer array Tka_Z69z
set Tka_Z69z[1]=Tka_z62Z[Tka_z15]
set Tka_Z69z[2]=Tka_z62Z[Tka_z15+20]
set Tka_Z69z[3]=Tka_z62Z[Tka_z15+40]
set Tka_Z69z[4]=Tka_z62Z[Tka_z15+60]
return Tka_Z69z[Tka_Z65Z]
endfunction
function Tka_z11Z takes integer Tka_Z65Z,boolean Tka_Z66z,boolean Tka_z78 returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
local string Tka_Z63Z
local string Tka_Z11Z
local integer Tka_Z69z
local integer Tka_Z55z
local integer Tka_Z8ZZ
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z63Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(Tka_Z63Z,false)
set Tka_Z69z=S2I(SubStringBJ(Tka_Z63Z,7,9))
set Tka_Z75=13
if(Tka_z13Z[Tka_Z65Z])then
if(Tka_Z66z)then
set Tka_Z69z=Tka_z52Z(Tka_Z65Z,Tka_z15)
if(Tka_z78)then
set Tka_Z69z=Tka_Z69z+1
else
set Tka_Z69z=Tka_Z69z-1
endif
endif
if(Tka_Z69z<=1)then
set Tka_Z69z=1
set Tka_Z55z=Tka_Z69z
else
set Tka_Z55z=(Tka_Z69z-1)*13
endif
set Tka_z62Z[Tka_z15]=Tka_Z69z
set Tka_z62Z[Tka_z15+20]=Tka_Z69z
set Tka_z62Z[Tka_z15+40]=Tka_Z69z
set Tka_z62Z[Tka_z15+60]=Tka_Z69z
call ClearTextMessagesBJ(bj_FORCE_PLAYER[Tka_z15])
set Tka_Z75=2
if(ModuloReal(I2R(Tka_Z77z[Tka_Z65Z]),13)==0)then
set Tka_Z8ZZ=(Tka_Z77z[Tka_Z65Z])/13
else
set Tka_Z8ZZ=((Tka_Z77z[Tka_Z65Z])/13)+1
endif
set Tka_Z41z[1]="------"+Tka_z50Z[Tka_Z65Z]+"ID查询 第"+I2S(Tka_Z69z)+"页/共"+I2S(Tka_Z8ZZ)+"页------"
loop
exitwhen Tka_Z75==16
set Tka_z15=Tka_Z55z+Tka_Z75-2
set Tka_Z41z[Tka_Z75]=Tka_z50Z[Tka_Z65Z]+"名称/ID : "+Tka_Z32z+Tka_z48Z(Tka_Z65Z,Tka_z15)+"|r/"+Tka_Z32z+Tka_z51Z(Tka_Z65Z,Tka_z15)+"|r"
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z41z[16]=Tka_z22Z+Tka_z49Z[Tka_Z65Z]
call Tka_Z49z(Tka_z05)
else
set Tka_Z63Z=SubStringBJ(Tka_Z63Z,StringLength(Tka_Z63Z),StringLength(Tka_Z63Z))
if(Tka_z05==Tka_z5)then
set Tka_Z94z=Tka_z05
call Tka_Z92z(Tka_Z65Z)
else
set Tka_Z41z[1]=Tka_z22Z+"必须由主机先输入查询命令 执行系统ID查询後"
set Tka_Z41z[2]=Tka_z22Z+"才能使用此功能"
call Tka_Z49z(Tka_z05)
endif
endif
set Tka_z05=null
endfunction
function Tka_z76Z takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),1097690998)
endfunction
function Tka_z75Z takes nothing returns nothing
call SetUnitAcquireRange(GetEnumUnit(),S2R(SubStringBJ(GetEventPlayerChatString(),6,15)))
endfunction
function Tka_z39Z takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),S2R(SubStringBJ(GetEventPlayerChatString(),6,8)))
endfunction
function Tka_z40Z takes nothing returns nothing
call PauseUnit(GetEnumUnit(),true)
endfunction
function Tka_z41Z takes nothing returns nothing
call PauseUnit(GetEnumUnit(),false)
endfunction
function Tka_z42Z takes nothing returns nothing
local string Tka_Z5zZ
local string Tka_Z63Z
set Tka_Z63Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(Tka_Z63Z,false)
set Tka_Z5zZ=SubStringBJ(Tka_Z63Z,6,99)
if(S2I(Tka_Z5zZ)==0)then
call SetUnitAnimation(GetEnumUnit(),Tka_Z5zZ)
else
call SetUnitAnimationByIndex(GetEnumUnit(),S2I(Tka_Z5zZ))
endif
endfunction
function Tka_Z88z takes nothing returns nothing
call SetUnitTurnSpeed(GetEnumUnit(),S2R(SubStringBJ(GetEventPlayerChatString(),6,99)))
endfunction
function Tka_Z84z takes nothing returns nothing
call SetUnitTimeScale(GetEnumUnit(),S2R(SubStringBJ(GetEventPlayerChatString(),6,15)))
endfunction
function Tka_z38Z takes integer Tka_Z55z,integer Tka_z15,integer Tka_Z75 returns nothing
local string Tka_Z63Z
set Tka_Z63Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(Tka_Z63Z,false)
if(SubStringBJ(Tka_Z63Z,Tka_Z55z,Tka_Z55z)=="-")then
call Tka_Z21Z(Tka_z15,Tka_Z75,false)
elseif SubStringBJ(Tka_Z63Z,Tka_Z55z,Tka_Z55z)=="" then
call Tka_Z21Z(Tka_z15,Tka_Z75,true)
endif
endfunction
function Tka_z79Z takes integer Tka_Z75 returns player
local integer Tka_Z55z=S2I(SubStringBJ(GetEventPlayerChatString(),Tka_Z75,Tka_Z75+1))
if(Tka_Z55z>=1)and(Tka_Z55z<=16)then
return Player(Tka_Z55z-1)
else
return null
endif
endfunction
function Tka_z90Z takes nothing returns nothing
local location Tka_Z8ZZ=GetUnitLoc(GetEnumUnit())
if(GetUnitTypeId(GetEnumUnit())==Tka_Z1zZ(6))then
if(GetTriggerPlayer()==GetLocalPlayer())then
call PingMinimapEx(GetLocationX(Tka_Z8ZZ),GetLocationY(Tka_Z8ZZ),10,0,255,0,false)
endif
endif
call RemoveLocation(Tka_Z8ZZ)
set Tka_Z8ZZ=null
endfunction
function Tka_z89Z takes nothing returns nothing
local location Tka_Z8ZZ=GetItemLoc(GetEnumItem())
if(GetItemTypeId(GetEnumItem())==Tka_Z1zZ(6))then
if(GetTriggerPlayer()==GetLocalPlayer())then
call PingMinimapEx(GetLocationX(Tka_Z8ZZ),GetLocationY(Tka_Z8ZZ),10,0,255,0,false)
endif
endif
call RemoveLocation(Tka_Z8ZZ)
set Tka_Z8ZZ=null
endfunction
function Tka_z55Z takes integer Tka_z15,integer Tka_Z75 returns nothing
local integer Tka_Z69z=0
local player Tka_z05=GetTriggerPlayer()
if(Tka_z13Z[Tka_Z75])then
set Tka_Z41z[1]=Tka_z22Z+"开启↑↓键查询ID"
set Tka_Z41z[2]=Tka_z22Z+"按→键即可关闭此功能"
set Tka_Z41z[3]=Tka_z22Z+"(使用此功能期间无法使用其他方向键功能)"
call Tka_Z49z(Tka_z05)
loop
set Tka_z62Z[Tka_z15+Tka_Z69z]=0
set Tka_Z69z=Tka_Z69z+20
exitwhen Tka_Z69z==80
endloop
set Tka_z63Z[Tka_z15]=Tka_Z75
call EnableTrigger(Tka_z56Z[Tka_z15])
call EnableTrigger(Tka_z57Z[Tka_z15])
call EnableTrigger(Tka_z60Z[Tka_z15])
call DisableTrigger(Tka_z10[Tka_z15])
call DisableTrigger(Tka_z00[Tka_z15])
call DisableTrigger(Tka_z20[Tka_z15])
call DisableTrigger(Tka_z30[Tka_z15])
else
set Tka_Z41z[1]=Tka_z22Z+"请先使用查询ID资料命令"
call Tka_Z49z(Tka_z05)
endif
set Tka_z05=null
endfunction
function Tka_z77Z takes integer Tka_Z69z returns integer
local string Tka_Z63Z=GetEventPlayerChatString()
local integer Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,Tka_Z69z,Tka_Z69z+1))
local integer Tka_z15=GetPlayerId(GetTriggerPlayer())
if(Tka_Z55z<=16)and(Tka_Z55z>=1)then
return Tka_Z55z-1
else
return Tka_z15
endif
endfunction
function Tka_z92Z takes integer Tka_z15 returns string
local string Tka_Z63Z=GetEventPlayerChatString()
local integer Tka_Z55z=StringLength(Tka_Z63Z)
if((SubStringBJ(Tka_Z63Z,Tka_Z55z-2,Tka_Z55z-2)==" ")or(SubStringBJ(Tka_Z63Z,Tka_Z55z-1,Tka_Z55z-1)==" "))and(Tka_z15<Tka_Z55z-2)then
return SubStringBJ(Tka_Z63Z,Tka_z15,Tka_Z55z-2)
else
return SubStringBJ(Tka_Z63Z,Tka_z15,Tka_Z55z)
endif
endfunction
function Tka_z91Z takes nothing returns player
local string Tka_Z63Z=GetEventPlayerChatString()
local integer Tka_Z55z=StringLength(Tka_Z63Z)
if(SubStringBJ(Tka_Z63Z,Tka_Z55z-2,Tka_Z55z-2)==" ")or(SubStringBJ(Tka_Z63Z,Tka_Z55z-1,Tka_Z55z-1)==" ")then
return Tka_z79Z(Tka_Z55z-1)
else
return GetTriggerPlayer()
endif
endfunction
function Tka_z98Z takes real Tka_Z75,real Tka_Z55z,integer Tka_Z69z,boolean Tka_Z66z returns nothing
local real Tka_z15=2
local real Tka_Z14Z=0
loop
set Tka_Z14Z=Tka_z15*32
if((Tka_z15*32)>48)then
set Tka_Z14Z=(Tka_z15*32)-16
elseif (Tka_z15*32)<-48 then
set Tka_Z14Z=(Tka_z15*32)+16
endif
call SetTerrainPathable(Tka_Z75+Tka_Z14Z,Tka_Z55z+48,ConvertPathingType(Tka_Z69z),Tka_Z66z)
call SetTerrainPathable(Tka_Z75+Tka_Z14Z,Tka_Z55z+32,ConvertPathingType(Tka_Z69z),Tka_Z66z)
call SetTerrainPathable(Tka_Z75+Tka_Z14Z,Tka_Z55z,ConvertPathingType(Tka_Z69z),Tka_Z66z)
call SetTerrainPathable(Tka_Z75+Tka_Z14Z,Tka_Z55z-32,ConvertPathingType(Tka_Z69z),Tka_Z66z)
call SetTerrainPathable(Tka_Z75+Tka_Z14Z,Tka_Z55z-48,ConvertPathingType(Tka_Z69z),Tka_Z66z)
set Tka_z15=Tka_z15-1
exitwhen Tka_z15==-3
endloop
endfunction
function Tka_Z81z takes real Tka_Z75,real Tka_Z55z,integer Tka_Z69z,boolean Tka_Z66z,integer Tka_Z54z returns nothing
local integer Tka_z15=0
local integer Tka_Z67z=0
if(Tka_Z69z==null)then
return
endif
set Tka_Z75=Tka_Z75+(128*(Tka_Z54z-1))
set Tka_Z55z=Tka_Z55z+(128*(Tka_Z54z-1))
loop
loop
call Tka_z98Z(Tka_Z75,Tka_Z55z,Tka_Z69z,Tka_Z66z)
set Tka_Z55z=Tka_Z55z-128
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==(Tka_Z54z*2)-1
endloop
call TriggerSleepAction(0)
set Tka_z15=0
set Tka_Z67z=Tka_Z67z+1
set Tka_Z55z=Tka_Z55z+(128*((Tka_Z54z-1)*2))+128
set Tka_Z75=Tka_Z75-128
exitwhen Tka_Z67z==(Tka_Z54z*2)-1
endloop
endfunction
function Tka_z00z takes nothing returns nothing
if(GetTriggerPlayer()==GetLocalPlayer())then
call SetUnitVertexColor(GetEnumUnit(),0,0,255,255)
endif
endfunction
function Tka_z02z takes nothing returns nothing
local integer Tka_z15=0
local integer Tka_Z75=0
local trigger Tka_Z66=GetTriggeringTrigger()
loop
if(Tka_Z6z[Tka_z15+16]==Tka_Z66)then
set Tka_Z75=0
loop
call SetPlayerAlliance(Player(Tka_Z75),Player(Tka_z15),ALLIANCE_SHARED_VISION,true)
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==16
endloop
exitwhen true
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==16
endloop
set Tka_Z66=null
endfunction
function Tka_Z79Z takes nothing returns nothing
local boolean Tka_Z66z
local integer Tka_z15
local integer Tka_Z75
local real Tka_Z14Z
local player Tka_z05
local player Tka_Z65
local player Tka_Z54z
local player Tka_Z67z
local string Tka_Z11Z
local string Tka_Z63Z
local string Tka_Z5zZ
local string Tka_Z65Z
local string Tka_Z68z
local string array Tka_s
local force Tka_Z8ZZ
local integer Tka_Z69z
local integer Tka_Z55z
set Tka_Z66z=false
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z63Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(Tka_Z63Z,false)
set Tka_Z5zZ=SubStringBJ(Tka_Z63Z,3,4)
set Tka_Z65Z=SubStringBJ(Tka_Z63Z,4,4)
set Tka_Z68z=SubStringBJ(Tka_Z63Z,3,3)
if(Tka_Z15z())then
if(Tka_Z63Z=="-tc")then
set Tka_z73[Tka_z15]=true
call Tka_z07(Tka_z15,true)
endif
if(Tka_Z63Z=="-tc-")then
set Tka_z73[Tka_z15]=false
call Tka_z07(Tka_z15,false)
endif
if(Tka_Z11z(Tka_z15))then
if(SubStringBJ(Tka_Z63Z,1,1)=="-")then
if(Tka_Z63Z=="-list")then
call Tka_Z62Z(Tka_z05)
endif
if(Tka_Z63Z=="-h")then
call Tka_Z60Z(Tka_z05,10)
endif
if(SubStringBJ(Tka_Z63Z,1,2)=="-c")then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,4,4))
if(Tka_Z55z<=0)then
set Tka_Z55z=1
endif
if(Tka_Z55z>=1)and(Tka_Z55z<=4)then
call ClearTextMessagesBJ(bj_FORCE_PLAYER[Tka_z15])
call Tka_Z60Z(Tka_z05,Tka_Z55z)
endif
endif
if(Tka_Z63Z=="-mm")then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="t")then
if(SubStringBJ(Tka_Z63Z,3,3)=="l")then
call Tka_z38Z(4,Tka_z15,1097623924)
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="nc")then
call Tka_z38Z(5,Tka_z15,1097625443)
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="us")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,15))
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z84z)
else
call SetUnitTimeScale(Tka_z7[Tka_z15],Tka_Z14Z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="ts")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,9))
if(Tka_Z14Z<0)and(Tka_Z14Z>1)then
set Tka_Z41z[1]=Tka_z22Z+"数值必须在0~1之间 数值愈小即转身愈慢"
else
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z88z)
else
call SetUnitTurnSpeed(Tka_z7[Tka_z15],Tka_Z14Z)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="ua")then
set Tka_Z5zZ=SubStringBJ(Tka_Z63Z,6,99)
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z42Z)
else
if(S2I(Tka_Z5zZ)==0)then
call SetUnitAnimation(Tka_z7[Tka_z15],Tka_Z5zZ)
else
call SetUnitAnimationByIndex(Tka_z7[Tka_z15],S2I(Tka_Z5zZ))
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="tu")then
set Tka_Z55z=Tka_z77Z(6)
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call DisableTrigger(Tka_Z40[Tka_Z55z])
call DisableTrigger(Tka_Z60[Tka_Z55z])
set Tka_Z41z[1]=Tka_z22Z+"现在你不可以即时造兵及完成科技及升级"
set Tka_z43Z[Tka_Z55z]=false
else
call EnableTrigger(Tka_Z40[Tka_Z55z])
call EnableTrigger(Tka_Z60[Tka_Z55z])
set Tka_Z41z[1]=Tka_z22Z+"现在你可以即时造兵及完成科技及升级"
set Tka_z43Z[Tka_Z55z]=true
endif
call Tka_Z49z(Player(Tka_Z55z))
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="stt")then
if(SubStringBJ(Tka_Z63Z,6,6)=="?")then
set Tka_Z75=1
set Tka_Z69z=(S2I(SubStringBJ(Tka_Z63Z,7,8)))
if(Tka_Z69z<=5)and(Tka_Z69z>=1)then
set Tka_Z41z[1]=Tka_Z31z+"地型类型列表第"+I2S(Tka_Z69z)+"页 :"
elseif Tka_Z69z==0 then
set Tka_Z41z[1]=Tka_Z31z+"地型类型列表第1页 :"
endif
call ClearTextMessagesBJ(bj_FORCE_PLAYER[Tka_z15])
set Tka_Z69z=(Tka_Z69z-1)*10
if(Tka_Z69z<0)then
set Tka_Z69z=0
endif
loop
set Tka_Z41z[Tka_Z75+1]=Tka_z22Z+I2S(Tka_Z75+Tka_Z69z)+". "+Tka_Z82z[Tka_Z75+Tka_Z69z]
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==11
exitwhen Tka_Z82z[Tka_Z75+Tka_Z69z]==null
endloop
elseif(SubStringBJ(Tka_Z63Z,6,6)=="+")then
set Tka_Z41z[1]=Tka_z22Z+"命令你的部队移动即时获得该地型材质"
set Tka_z03z[Tka_z15]=true
else
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,7,8))
set Tka_Z69z=0
loop
if(Tka_z95Z[Tka_Z69z]==null)or(Tka_z95Z[Tka_Z69z]==Tka_z7[Tka_z15])then
call SetUnitMoveSpeed(Tka_z7[Tka_z15],1.00)
set Tka_z95Z[Tka_Z69z]=Tka_z7[Tka_z15]
set Tka_z96Z[Tka_Z69z]=Tka_Z21z[Tka_Z75]
if(IsUnitInGroup(Tka_z7[Tka_z15],Tka_Z83z)==false)then
call GroupAddUnit(Tka_Z83z,Tka_z7[Tka_z15])
endif
if(Tka_Z69z>=Tka_Z85z)then
set Tka_Z85z=Tka_Z85z+1
endif
set Tka_Z41z[1]=Tka_z22Z+"获取的地型材质为 |CFF00FF00"+Tka_Z82z[Tka_Z75]
exitwhen true
endif
set Tka_Z69z=Tka_Z69z+1
endloop
endif
endif
set Tka_Z69z=S2I(SubStringBJ(Tka_Z63Z,5,6))
if(SubStringBJ(Tka_Z63Z,3,3)=="b")and(Tka_Z69z>0)then
set Tka_Z41z[1]=Tka_z22Z+"改变地形范围半径的为"+I2S(Tka_Z69z)
set Tka_z93Z[Tka_z15]=Tka_Z69z
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="ta")then
if(SubStringBJ(Tka_Z63Z,5,5)=="?")then
call ClearTextMessagesBJ(bj_FORCE_PLAYER[Tka_z15])
set Tka_Z41z[1]=Tka_Z31z+"地型附加通行属性(每个单位只可选择一个属性)"
set Tka_Z41z[2]=Tka_z22Z+"1. "+Tka_z97Z[0]+"(这个好像没有用)"
set Tka_Z41z[3]=Tka_z22Z+"2. "+Tka_z97Z[1]+"(令地面部队可行那个地方)"
set Tka_Z41z[4]=Tka_z22Z+"3. "+Tka_z97Z[2]+"(令空中部队可行那个地方)"
set Tka_Z41z[5]=Tka_z22Z+"4. "+Tka_z97Z[3]+"(令建筑可在那地方起)"
set Tka_Z41z[6]=Tka_z22Z+"5. "+Tka_z97Z[4]+"(采矿和伐木中的农民可以穿过的地形)"
set Tka_Z41z[7]=Tka_z22Z+"6. "+Tka_z97Z[5]+"(不死族可否在此地建筑)"
set Tka_Z41z[8]=Tka_z22Z+"7. "+Tka_z97Z[6]+"(水上部队可穿过的地形)"
set Tka_Z41z[9]=Tka_z22Z+"8. "+Tka_z97Z[7]+"(两栖类部队可穿过的地形)"
else
if(IsUnitInGroup(Tka_z7[Tka_z15],Tka_Z83z))then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,6))
if(Tka_Z75>=1)and(Tka_Z75<=8)then
set Tka_Z69z=0
loop
if(Tka_z95Z[Tka_Z69z]==Tka_z7[Tka_z15])then
set Tka_z36Z[Tka_Z69z]=Tka_Z75-1
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_z37Z[Tka_Z69z]=false
set Tka_Z41z[1]="|CFFFF0000关闭"
else
set Tka_z37Z[Tka_Z69z]=true
set Tka_Z41z[1]="|CFF00FF00开启"
endif
set Tka_Z41z[1]=Tka_z22Z+Tka_z97Z[Tka_Z75-1]+"改变为 "+Tka_Z41z[1]
exitwhen true
endif
set Tka_Z69z=Tka_Z69z+1
exitwhen Tka_Z69z>=Tka_Z85z
endloop
endif
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="map")then
if(SubStringBJ(Tka_Z63Z,6,6)=="")then
set Tka_Z55z=Tka_z77Z(7)
call Tka_ZZzZ(Tka_Z55z,Player(Tka_Z55z))
elseif(SubStringBJ(Tka_Z63Z,6,6)=="a")then
set Tka_Z55z=Tka_z77Z(8)
if(Tka_z23[Tka_Z55z]!=null)then
call DestroyFogModifier(Tka_z23[Tka_Z55z])
call DestroyTrigger(Tka_Z6z[Tka_Z55z+16])
set Tka_Z6z[Tka_Z55z+16]=null
set Tka_z15=0
loop
call SetPlayerAlliance(Player(Tka_z15),Player(Tka_Z55z),ALLIANCE_SHARED_VISION,Tka_z01z[Tka_Z55z*16+Tka_z15])
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==16
endloop
set Tka_z23[Tka_Z55z]=null
else
set Tka_z15=0
loop
if(GetPlayerAlliance(Player(Tka_z15),Player(Tka_Z55z),ALLIANCE_SHARED_VISION))then
set Tka_z01z[Tka_Z55z*16+Tka_z15]=true
else
set Tka_z01z[Tka_Z55z*16+Tka_z15]=false
endif
call SetPlayerAlliance(Player(Tka_z15),Player(Tka_Z55z),ALLIANCE_SHARED_VISION,true)
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==16
endloop
set Tka_z23[Tka_Z55z]=CreateFogModifierRect(Player(Tka_Z55z),ConvertFogState(4),Tka_z8,false,true)
call FogModifierStart(Tka_z23[Tka_Z55z])
set Tka_Z6z[Tka_Z55z+16]=CreateTrigger()
set Tka_z15=0
loop
if(Tka_z15!=Tka_Z55z)then
call TriggerRegisterPlayerAllianceChange(Tka_Z6z[Tka_Z55z+16],Player(Tka_z15),ALLIANCE_SHARED_VISION)
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==16
endloop
call TriggerAddAction(Tka_Z6z[Tka_Z55z+16],function Tka_z02z)
call ForGroup(Tka_z94Z,function Tka_z00z)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="cu")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z69z=S2I(Tka_z92Z(11))
set Tka_Z75=Tka_Z1zZ(6)
if(StringLength(Tka_Z63Z)<13)then
set Tka_Z54z=Tka_z05
endif
call SetPlayerTechMaxAllowedSwap(Tka_Z75,Tka_Z69z,Tka_Z54z)
set Tka_Z41z[1]=Tka_z22Z+"已把玩家"+Tka_Z47z(null,Tka_Z54z,Tka_z05)+GetPlayerName(Tka_Z54z)+Tka_z22Z+"的|CFF00E800"+GetObjectName(Tka_Z75)+Tka_z22Z+"上限数目设定为 "+Tka_Z32z+I2S(GetPlayerTechMaxAllowedSwap(Tka_Z75,Tka_Z54z))
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="if")then
call Tka_z38Z(5,Tka_z15,1095331446)
endif
if(SubStringBJ(Tka_Z63Z,2,3)=="tp")then
set Tka_Z55z=Tka_z77Z(5)
if(SubStringBJ(Tka_Z63Z,4,4)=="-")then
set Tka_Z41z[1]=Tka_z22Z+"现在你不能使用P闪功能"
set Tka_z35Z[Tka_Z55z]=false
elseif SubStringBJ(Tka_Z63Z,4,4)=="" or SubStringBJ(Tka_Z63Z,4,4)==" " then
set Tka_Z41z[1]=Tka_z22Z+"现在你可以使用P闪功能"
set Tka_z35Z[Tka_Z55z]=true
endif
call Tka_Z49z(Player(Tka_Z55z))
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="run")then
set Tka_Z11Z=SubStringBJ(GetEventPlayerChatString(),7,99)
call ExecuteFunc(Tka_Z11Z)
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="iid?")then
call Tka_z55Z(Tka_z15,1)
set Tka_z63Z[Tka_z15]=1
else
if(SubStringBJ(Tka_Z63Z,3,5)=="iid")then
call Tka_z11Z(1,false,false)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="uid?")then
call Tka_z55Z(Tka_z15,2)
set Tka_z63Z[Tka_z15]=2
else
if(SubStringBJ(Tka_Z63Z,3,5)=="uid")then
call Tka_z11Z(2,false,false)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="aid?")then
call Tka_z55Z(Tka_z15,3)
set Tka_z63Z[Tka_z15]=3
else
if(SubStringBJ(Tka_Z63Z,3,5)=="aid")then
call Tka_z11Z(3,false,false)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="tid?")then
call Tka_z55Z(Tka_z15,4)
set Tka_z63Z[Tka_z15]=4
else
if(SubStringBJ(Tka_Z63Z,3,5)=="tid")then
call Tka_z11Z(4,false,false)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="stop")then
call PauseGameOn()
endif
if(SubStringBJ(Tka_Z63Z,3,7)=="start")then
call PauseGameOff()
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="msp")then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,7,7))
if(Tka_Z55z==1)then
set Tka_Z68z="最慢"
endif
if(Tka_Z55z==2)then
set Tka_Z68z="慢"
endif
if(Tka_Z55z==3)then
set Tka_Z68z="普通"
endif
if(Tka_Z55z==4)then
set Tka_Z68z="快"
endif
if(Tka_Z55z==5)then
set Tka_Z68z="最快"
endif
set Tka_Z41z[1]=Tka_z22Z+"已把游戏速度改为"+Tka_Z32z+Tka_Z68z
call SetGameSpeed(ConvertGameSpeed(Tka_Z55z-1))
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="sp")then
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z39Z)
set Tka_Z41z[1]=Tka_z22Z+"指定数个部队的移动速度已改为"+Tka_Z32z+R2S(GetUnitMoveSpeed(Tka_z7[Tka_z15]))
else
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,6,8))
call SetUnitMoveSpeed(Tka_z7[Tka_z15],I2R(Tka_Z55z))
set Tka_Z41z[1]=Tka_z22Z+"指定部队的移动速度已改为"+Tka_Z32z+R2S(GetUnitMoveSpeed(Tka_z7[Tka_z15]))
endif
endif
if(SubStringBJ(Tka_Z63Z,1,2)=="-t")then
set Tka_Z68z=Tka_z22Z+"现在任何被点击的部队不会被杀死/删除"
if(SubStringBJ(Tka_Z63Z,3,6)=="boom")then
if(SubStringBJ(Tka_Z63Z,7,7)=="-")then
set Tka_Z38z[Tka_z15]=0
set Tka_Z41z[1]=Tka_Z68z
else
set Tka_Z38z[Tka_z15]=3
set Tka_Z41z[1]=Tka_z22Z+"现在任何被点击的部队也会即时爆炸而死"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="del")then
if(SubStringBJ(Tka_Z63Z,6,6)=="-")then
set Tka_Z38z[Tka_z15]=0
set Tka_Z41z[1]=Tka_Z68z
else
set Tka_Z38z[Tka_z15]=2
set Tka_Z41z[1]=Tka_z22Z+"现在任何被点击的部队也会即时删除"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="kill")then
if(SubStringBJ(Tka_Z63Z,7,7)=="-")then
set Tka_Z38z[Tka_z15]=0
set Tka_Z41z[1]=Tka_Z68z
else
set Tka_Z38z[Tka_z15]=1
set Tka_Z41z[1]=Tka_z22Z+"现在任何被点击的部队也会即时死亡"
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="sr")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,15))
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z75Z)
else
call SetUnitAcquireRange(Tka_z7[Tka_z15],Tka_Z14Z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="mv")then
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z76Z)
else
call UnitRemoveAbility(Tka_z7[Tka_z15],1097690998)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="ui")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_z87Z[Tka_z15]=false
set Tka_Z41z[1]=Tka_z22Z+"取消分别镜像"
elseif SubStringBJ(Tka_Z63Z,5,5)=="" then
set Tka_z87Z[Tka_z15]=true
set Tka_Z41z[1]=Tka_z22Z+"开启分别镜像"
call ForGroup(Tka_z94Z,function Tka_z00z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="um")then
call ForGroup(GetUnitsInRectMatching(GetPlayableMapRect(),null),function Tka_z90Z)
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="im")then
call EnumItemsInRect(GetPlayableMapRect(),null,function Tka_z89Z)
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="md")then
if(GetLocalPlayer()==Tka_z05)then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call MultiboardDisplay(Tka_z78Z,false)
else
call MultiboardDisplay(Tka_z78Z,true)
call MultiboardMinimize(Tka_z78Z,false)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="sh")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call UnitRemoveAbility(Tka_z7[Tka_z15],1097753906)
call UnitRemoveAbility(Tka_z7[Tka_z15],1098085732)
call UnitRemoveAbility(Tka_z7[Tka_z15],1098082660)
call UnitRemoveAbility(Tka_z7[Tka_z15],1097886068)
else
call UnitAddAbility(Tka_z7[Tka_z15],1097753906)
call UnitAddAbility(Tka_z7[Tka_z15],1098085732)
call UnitAddAbility(Tka_z7[Tka_z15],1098082660)
call UnitAddAbility(Tka_z7[Tka_z15],1097886068)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="is")then
set Tka_Z75=Tka_Z1zZ(6)
set Tka_Z69z=S2I(SubStringBJ(Tka_Z63Z,11,20))
if(Tka_Z69z==0)then
set Tka_Z69z=1
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call RemoveItemFromStockBJ(Tka_Z75,Tka_z7[Tka_z15])
else
call AddItemToStockBJ(Tka_Z75,Tka_z7[Tka_z15],Tka_Z69z,Tka_Z69z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="fs")then
set Tka_Z75=Tka_Z1zZ(6)
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call RemoveUnitFromStockBJ(Tka_Z75,Tka_z7[Tka_z15])
else
call AddUnitToStockBJ(Tka_Z75,Tka_z7[Tka_z15],Tka_Z69z,Tka_Z69z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="ud")then
set Tka_z15=0
set Tka_Z75=Tka_Z1zZ(6)
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_z15=S2I(SubStringBJ(Tka_Z63Z,6,7))-1
set Tka_z67Z[Tka_z15]=1
set Tka_z68Z[Tka_z15]=0
set Tka_z65Z[Tka_z15]=0
set Tka_z72Z[Tka_z15]="1111111111111111"
set Tka_z71Z[Tka_z15]=100
set Tka_z70Z[Tka_z15]=true
elseif SubStringBJ(Tka_Z63Z,5,5)=="p" then
set Tka_z15=S2I(SubStringBJ(Tka_Z63Z,7,8))-1
if(Tka_z67Z[Tka_z15]!=0)and(Tka_z67Z[Tka_z15]!=1)then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,10,11))
if(SubStringBJ(Tka_Z63Z,6,6)=="-")then
if(Tka_Z55z<=16)and(Tka_Z55z>=1)then
set Tka_z72Z[Tka_z15]=SubStringBJ(Tka_z72Z[Tka_z15],1,Tka_Z55z-1)+"0"+SubStringBJ(Tka_z72Z[Tka_z15],Tka_Z55z+1,StringLength(Tka_z72Z[Tka_z15]))
set Tka_Z41z[1]=Tka_z22Z+"已在第"+Tka_Z30z+I2S(Tka_z15+1)+Tka_z22Z+"项衍生项目中删除"+Tka_Z30z+"玩家"+I2S(Tka_Z55z)+Tka_z22Z+"的权限"
endif
else
if(Tka_Z55z<=16)and(Tka_Z55z>=1)then
set Tka_z72Z[Tka_z15]=SubStringBJ(Tka_z72Z[Tka_z15],1,Tka_Z55z-1)+"1"+SubStringBJ(Tka_z72Z[Tka_z15],Tka_Z55z+1,StringLength(Tka_z72Z[Tka_z15]))
set Tka_Z41z[1]=Tka_z22Z+"已在第"+Tka_Z30z+I2S(Tka_z15+1)+Tka_z22Z+"项衍生项目中增加"+Tka_Z30z+"玩家"+I2S(Tka_Z55z)+Tka_z22Z+"的权限"
else
set Tka_Z41z[1]=Tka_z22Z+"已把第"+Tka_Z30z+I2S(Tka_z15+1)+Tka_z22Z+"项衍生项目设定为"+Tka_Z30z+"无限制"
set Tka_z72Z[Tka_z15]="1111111111111111"
endif
endif
endif
elseif SubStringBJ(Tka_Z63Z,5,5)=="c" then
set Tka_z15=S2I(SubStringBJ(Tka_Z63Z,7,8))-1
set Tka_z71Z[Tka_z15]=S2I(SubStringBJ(Tka_Z63Z,10,12))
if(Tka_z71Z[Tka_z15]<=0)then
set Tka_z71Z[Tka_z15]=100
endif
set Tka_Z41z[1]=Tka_z22Z+"设定第"+Tka_Z30z+I2S(Tka_z15+1)+Tka_z22Z+"项衍生项目的机率为"+Tka_Z30z+I2S(Tka_z71Z[Tka_z15])+Tka_z22Z+"%"
elseif SubStringBJ(Tka_Z63Z,5,5)=="u" then
set Tka_z15=S2I(SubStringBJ(Tka_Z63Z,7,8))-1
set Tka_z65Z[Tka_z15]=S2I(SubStringBJ(Tka_Z63Z,10,12))
if(Tka_z65Z[Tka_z15]<=0)then
set Tka_z65Z[Tka_z15]=1
endif
set Tka_Z41z[1]=Tka_z22Z+"设定第"+Tka_Z30z+I2S(Tka_z15+1)+Tka_z22Z+"项衍生项目的生成数目为"+Tka_Z30z+I2S(Tka_z65Z[Tka_z15])
elseif SubStringBJ(Tka_Z63Z,5,5)=="?" then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))-1
if(Tka_Z75<=0)then
set Tka_Z75=0
endif
set Tka_Z75=Tka_Z75*10
set Tka_z15=0
set Tka_Z41z[1]=Tka_Z30z+"　死亡部队ID　衍生部队ID　衍生数目　特效开关　生成机率　限制玩家|r"
loop
if(Tka_z67Z[Tka_z15]!=0)and(Tka_z67Z[Tka_z15]!=1)then
set Tka_s[1]=Tka_Z05Z(Tka_z67Z[Tka_z15])
set Tka_s[2]=Tka_Z05Z(Tka_z68Z[Tka_z15])
set Tka_s[3]="　"+I2S(Tka_z65Z[Tka_z15])
if(Tka_z65Z[Tka_z15]<10)then
set Tka_s[3]=" "+Tka_s[3]
endif
set Tka_s[4]="关"
if(Tka_z70Z[Tka_z15])then
set Tka_s[4]="开"
endif
set Tka_s[5]=I2S(Tka_z71Z[Tka_z15])+"%"
if(Tka_z71Z[Tka_z15]<100)then
set Tka_s[5]="  "+Tka_s[5]
if(Tka_z71Z[Tka_z15]<10)then
set Tka_s[5]="  "+Tka_s[5]
endif
endif
set Tka_s[6]=""
set Tka_Z69z=1
if(Tka_z72Z[Tka_z15]=="1111111111111111")then
set Tka_s[6]="　无限制"
else
set Tka_Z66z=true
loop
set Tka_Z55z=GetPlayerId(Player(Tka_Z69z-1))
if(SubStringBJ(Tka_z72Z[Tka_z15],Tka_Z69z,Tka_Z69z)=="1")then
if(Tka_Z66z)then
set Tka_Z66z=false
if(Tka_s[6]=="")then
set Tka_s[6]=I2S(Tka_Z55z+1)
else
set Tka_s[6]=Tka_s[6]+","+I2S(Tka_Z55z+1)
endif
endif
if(Tka_Z55z==15)and(SubStringBJ(Tka_s[6],StringLength(Tka_s[6])-1,StringLength(Tka_s[6]))!="16")then
set Tka_s[6]=Tka_s[6]+"~"+I2S(Tka_Z55z+1)
endif
else
if(Tka_Z66z==false)then
if(SubStringBJ(Tka_s[6],StringLength(Tka_s[6]),StringLength(Tka_s[6]))!=I2S(Tka_Z55z))then
set Tka_s[6]=Tka_s[6]+"~"+I2S(Tka_Z55z)
endif
set Tka_Z66z=true
endif
endif
set Tka_Z69z=Tka_Z69z+1
exitwhen Tka_Z69z==17
endloop
endif
else
set Tka_s[1]="-------"
set Tka_s[2]="-------"
set Tka_s[3]="----"
set Tka_s[4]="---"
set Tka_s[5]="--------"
set Tka_s[6]="---------"
endif
set Tka_Z41z[Tka_z15+2]=I2S(Tka_z15+1+Tka_Z75)+".　"+Tka_s[1]+"　　　　"+Tka_s[2]+"　　　"+Tka_s[3]+"　　　　"+Tka_s[4]+"　　　"+Tka_s[5]+"　　"+Tka_s[6]+"|r"
if((Tka_z15+1+Tka_Z75)>=10)then
set Tka_Z41z[Tka_z15+2]=I2S(Tka_z15+1+Tka_Z75)+". "+Tka_s[1]+"　　　　"+Tka_s[2]+"　　　"+Tka_s[3]+"　　　　"+Tka_s[4]+"　　　"+Tka_s[5]+"　　"+Tka_s[6]+"|r"
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==10
endloop
call Tka_Z49z(Tka_z05)
elseif SubStringBJ(Tka_Z63Z,5,5)=="" then
set Tka_Z41z[1]=Tka_Z30z+"-tud [死亡部队ID*] [衍生部队ID*] [衍生数目*] [特效开关?] [生成机率?] [限制玩家?]|r"
set Tka_Z41z[2]=Tka_Z30z+"(*为必填项 ?为选填项)"
set Tka_Z41z[3]="此功能是令某种部队死亡後 出现另一种部队"
set Tka_Z41z[4]="例如 "+Tka_Z30z+"A部队|r死亡 "+Tka_Z30z+"B部队|r就会在"+Tka_Z30z+"A部队|r死亡的位置出现"
set Tka_Z41z[5]=Tka_Z30z+"[衍生数目] "+Tka_Z27z+"则是B部队的数量(此项需要填写时需两个位)"
set Tka_Z41z[6]=Tka_Z27z+"(即衍生数目为3只时 要填 03 而不是3 衍生最高数量为99只)"
set Tka_Z41z[7]=Tka_z22Z+"此功能亦可以设置 多种部队同时在A部队死亡後出现"
set Tka_Z41z[8]=Tka_z22Z+"只要使用两次-tud也写同一个死亡部队ID就可以了"
set Tka_Z41z[9]=Tka_Z30z+"[特效开关] "+Tka_Z27z+"设定生成部队的特效 0为关 1为开(默认开启)"
set Tka_Z41z[10]=Tka_Z30z+"[生成机率] "+Tka_Z27z+"设定生成部队的机率 值为1~100(默认100)"
set Tka_Z41z[11]=Tka_Z27z+"(即生成机率为10%时 要填 010 而不是10)"
set Tka_Z41z[12]=Tka_Z30z+"[限制玩家] "+Tka_Z27z+"设定使用此衍生项目的玩家 值为1~16(不填则所有玩家皆可使用)"
else
loop
if(Tka_z67Z[Tka_z15]==null)or(Tka_z67Z[Tka_z15]<=1)then
set Tka_z67Z[Tka_z15]=Tka_Z75
set Tka_z68Z[Tka_z15]=Tka_Z1zZ(11)
set Tka_z65Z[Tka_z15]=S2I(SubStringBJ(Tka_Z63Z,16,17))
set Tka_z71Z[Tka_z15]=S2I(SubStringBJ(Tka_Z63Z,21,23))
if(Tka_z71Z[Tka_z15]<=0)or(Tka_z71Z[Tka_z15]>=100)then
set Tka_z71Z[Tka_z15]=100
endif
if(SubStringBJ(Tka_Z63Z,19,19)=="0")then
set Tka_z70Z[Tka_z15]=false
set Tka_Z5zZ="关"
else
set Tka_z70Z[Tka_z15]=true
set Tka_Z5zZ="开"
endif
set Tka_Z54z=Tka_z79Z(25)
set Tka_Z55z=GetPlayerId(Tka_Z54z)+1
if(Tka_Z54z!=null)then
set Tka_z72Z[Tka_z15]="0000000000000000"
set Tka_z72Z[Tka_z15]=SubStringBJ(Tka_z72Z[Tka_z15],1,Tka_Z55z-1)+"1"+SubStringBJ(Tka_z72Z[Tka_z15],Tka_Z55z+1,StringLength(Tka_z72Z[Tka_z15]))
set Tka_Z41z[2]="玩家"+I2S(Tka_Z55z)+"("+GetPlayerName(Tka_Z54z)+")可用"
else
set Tka_Z41z[2]="无限制"
set Tka_z72Z[Tka_z15]="1111111111111111"
endif
exitwhen true
endif
set Tka_z15=Tka_z15+1
endloop
set Tka_Z41z[1]=Tka_Z30z+"死亡部队ID="+Tka_z22Z+GetObjectName(Tka_z67Z[Tka_z15])+Tka_Z30z+"　衍生部队ID="+Tka_z22Z+GetObjectName(Tka_z68Z[Tka_z15])+Tka_Z30z+"　生成数量="+Tka_z22Z+I2S(Tka_z65Z[Tka_z15])+"|r"
set Tka_Z41z[2]=Tka_Z30z+"特效开关="+Tka_z22Z+Tka_Z5zZ+Tka_Z30z+"　生成机率="+Tka_z22Z+I2S(Tka_z71Z[Tka_z15])+"%"+Tka_Z30z+"　玩家限制="+Tka_z22Z+Tka_Z41z[2]+"|r"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="me")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call FogMaskEnable(false)
set Tka_Z41z[1]=Tka_z22Z+"停用黑色隐影"
else
call FogMaskEnable(true)
set Tka_Z41z[1]=Tka_z22Z+"启用黑色隐影"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="fe")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call FogEnable(false)
set Tka_Z41z[1]=Tka_z22Z+"停用战争迷雾"
else
call FogEnable(true)
set Tka_Z41z[1]=Tka_z22Z+"启用战争迷雾"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="sf")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,StringLength(Tka_Z63Z)))
if(Tka_Z75<0)then
set Tka_Z75=0
endif
call CameraSetSmoothingFactor(Tka_Z75)
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="eq")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z75=S2I(Tka_z92Z(6))
if(Tka_Z54z==null)or(StringLength(Tka_Z63Z)<=7)then
set Tka_Z54z=Tka_z05
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z75=Tka_z77Z(StringLength(Tka_Z63Z)-1)
if(SubStringBJ(Tka_Z63Z,6,6)=="")then
set Tka_Z75=Tka_z15
elseif SubStringBJ(Tka_Z63Z,7,7)=="" then
set Tka_Z75=Tka_z77Z(StringLength(Tka_Z63Z))
endif
call CameraSetEQNoiseForPlayer(Player(Tka_Z75),0)
else
call CameraSetEQNoiseForPlayer(Tka_Z54z,Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="sc")then
set Tka_Z55z=Tka_z77Z(6)
call SetCameraBoundsToRectForPlayerBJ(Player(Tka_Z55z),GetPlayableMapRect())
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="thc")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z==null)or(StringLength(Tka_Z63Z)<=13)then
set Tka_Z54z=Tka_z05
endif
set Tka_Z66z=true
set Tka_Z75=Tka_Z1zZ(7)
set Tka_Z55z=S2I(Tka_z92Z(11))
call SetPlayerTechMaxAllowedSwap(Tka_Z75,Tka_Z55z,Tka_Z54z)
set Tka_Z68z=Tka_Z31z+GetObjectName(Tka_Z75)+Tka_z22Z+"最大科技等级改为"+Tka_Z32z+I2S(GetPlayerTechMaxAllowedSwap(Tka_Z75,Tka_Z54z))+"|r"
else
if(SubStringBJ(Tka_Z63Z,3,4)=="th")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z==null)or(StringLength(Tka_Z63Z)<=12)then
set Tka_Z54z=Tka_z05
endif
set Tka_Z66z=true
set Tka_Z75=Tka_Z1zZ(6)
set Tka_Z55z=S2I(Tka_z92Z(10))
call SetPlayerTechResearchedSwap(Tka_Z75,Tka_Z55z,Tka_Z54z)
set Tka_Z68z=Tka_Z31z+GetObjectName(Tka_Z75)+Tka_z22Z+"科技等级改为"+Tka_Z32z+I2S(GetPlayerTechCountSimple(Tka_Z75,Tka_Z54z))+"|r"
endif
endif
if(Tka_Z66z)then
set Tka_Z41z[1]=Tka_z22Z+"已把玩家"+Tka_Z47z(null,Tka_Z54z,Tka_z05)+GetPlayerName(Tka_Z54z)+Tka_z22Z+"的"+Tka_Z68z
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="fd")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z==null)or(StringLength(Tka_Z63Z)<10)then
set Tka_Z54z=Tka_z05
endif
set Tka_Z55z=S2I(Tka_z92Z(8))
if(SubStringBJ(Tka_Z63Z,6,6)=="c")then
set Tka_Z66z=true
set Tka_Z68z="食物上限"
set Tka_Z75=4
endif
if(SubStringBJ(Tka_Z63Z,6,6)=="u")then
set Tka_Z66z=true
set Tka_Z68z="已使用食物"
set Tka_Z75=5
endif
if(SubStringBJ(Tka_Z63Z,6,6)=="f")then
set Tka_Z66z=true
set Tka_Z68z="可达到上限食物"
set Tka_Z75=6
endif
if(Tka_Z66z)then
set Tka_Z41z[1]=Tka_z22Z+"已把玩家"+Tka_Z47z(null,Tka_Z54z,Tka_z05)+GetPlayerName(Tka_Z54z)+Tka_z22Z+"的"+Tka_Z68z+"改为"+Tka_Z32z+I2S(Tka_Z55z)+"|r"
call SetPlayerStateBJ(Tka_Z54z,ConvertPlayerState(Tka_Z75),Tka_Z55z)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="se")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z37z[Tka_z15]=false
set Tka_Z41z[1]=Tka_z22Z+"关闭自动检测服务"
else
set Tka_Z41z[1]=Tka_z22Z+"开启自动检测服务"
set Tka_Z37z[Tka_z15]=true
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="cam")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z!=null)then
call SetCameraTargetControllerNoZForPlayer(Tka_Z54z,Tka_z7[Tka_z15],0,0,false)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="view")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z14Z=S2R(Tka_z92Z(8))
if(StringLength(Tka_Z63Z)<10)then
set Tka_Z54z=Tka_z05
endif
if(Tka_Z14Z>0)then
if(Tka_Z54z!=null)then
call SetCameraFieldForPlayer(Tka_Z54z,ConvertCameraField(0),Tka_Z14Z,3)
endif
endif
endif
if(Tka_Z13z(Tka_z05))then
if(SubStringBJ(Tka_Z63Z,3,4)=="sd")then
set Tka_Z65=Tka_z79Z(6)
set Tka_Z75=GetPlayerId(Tka_Z65)
if(Tka_Z65!=null)then
set Tka_Z41z[1]=Tka_z84Z[Tka_Z75]+GetPlayerName(Tka_Z65)+Tka_z22Z+" 已无法看到玩家对话"
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z41z[1]=Tka_z84Z[Tka_Z75]+GetPlayerName(Tka_Z65)+Tka_z22Z+" 已能再次看见玩家对话"
endif
set Tka_Z75=0
if(Tka_Z65!=Tka_Z12z)then
if(GetLocalPlayer()==Tka_Z65)then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
loop
if(Tka_Z19z[Tka_Z75]!=null)then
call SetPlayerName(Player(Tka_Z75),Tka_Z19z[Tka_Z75])
endif
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==12
endloop
else
loop
if(GetPlayerName(Player(Tka_Z75))!=Tka_Z20z)then
set Tka_Z19z[Tka_Z75]=GetPlayerName(Player(Tka_Z75))
call SetPlayerName(Player(Tka_Z75),Tka_Z20z)
endif
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==12
endloop
endif
endif
else
if(SubStringBJ(Tka_Z63Z,5,5)!="-")then
call Tka_Z18z(3,Tka_z05)
endif
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="su")then
set Tka_Z65=Tka_z79Z(6)
if(Tka_Z65!=null)then
if(Tka_Z65!=Tka_Z12z)then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z41z[1]=Tka_z84Z[GetPlayerId(Tka_Z65)]+GetPlayerName(Tka_Z65)+Tka_z22Z+" 已能够再次选择部队"
if(Tka_Z65==GetLocalPlayer())then
call EnableSelect(true,true)
endif
else
set Tka_Z41z[1]=Tka_z84Z[GetPlayerId(Tka_Z65)]+GetPlayerName(Tka_Z65)+Tka_z22Z+" 已不能选择部队"
if(Tka_Z65==GetLocalPlayer())then
call EnableSelect(false,false)
endif
endif
else
if(SubStringBJ(Tka_Z63Z,5,5)!="-")then
call Tka_Z18z(4,Tka_z05)
endif
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,2,4)=="tpa")then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,12,12))-1
set Tka_Z65=Tka_z79Z(6)
set Tka_Z67z=Tka_z79Z(9)
if(Tka_Z65!=null)and(Tka_Z67z!=null)and(Tka_Z55z>=0)and(Tka_Z55z<=7)then
call SetPlayerAlliance(Tka_Z65,Tka_Z67z,ConvertAllianceType(Tka_Z55z),true)
set Tka_Z41z[1]=Tka_z22Z+"设定"+Tka_Z29z+GetPlayerName(Tka_Z65)+Tka_z22Z+"对"+Tka_Z31z+GetPlayerName(Tka_Z67z)+Tka_z22Z+"的"+Tka_Z30z+Tka_z86Z[Tka_Z55z+1]+Tka_z22Z+"为开启"
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call SetPlayerAlliance(Tka_Z65,Tka_Z67z,ConvertAllianceType(Tka_Z55z),false)
set Tka_Z41z[1]=Tka_z22Z+"设定"+Tka_Z29z+GetPlayerName(Tka_Z65)+Tka_z22Z+"对"+Tka_Z31z+GetPlayerName(Tka_Z67z)+Tka_z22Z+"的"+Tka_Z30z+Tka_z86Z[Tka_Z55z+1]+Tka_z22Z+"为关闭"
endif
elseif SubStringBJ(Tka_Z63Z,5,5)=="?" then
set Tka_z15=1
loop
set Tka_Z41z[Tka_z15]=Tka_z22Z+I2S(Tka_z15)+"."+Tka_z86Z[Tka_z15]
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==9
endloop
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="mf")then
set Tka_Z55z=R2I(Pow(2,S2R(SubStringBJ(Tka_Z63Z,6,7))-1))
call SetMapFlag(ConvertMapFlag(Tka_Z55z),true)
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z41z[1]=Tka_z22Z+"设定"+Tka_Z30z+Tka_z85Z[Tka_Z75]+Tka_z22Z+"为关闭"
call SetMapFlag(ConvertMapFlag(Tka_Z55z),false)
elseif SubStringBJ(Tka_Z63Z,5,5)=="" or SubStringBJ(Tka_Z63Z,5,5)=="2" then
set Tka_z15=1
set Tka_Z75=0
if(SubStringBJ(Tka_Z63Z,5,5)=="2")then
set Tka_Z75=10
else
set Tka_Z41z[11]=Tka_z22Z+"输入-tmf2进入下一页"
endif
loop
set Tka_Z41z[Tka_z15]=Tka_z22Z+I2S(Tka_z15+Tka_Z75)+". "+Tka_z85Z[Tka_z15+Tka_Z75]
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==11 or Tka_z85Z[Tka_z15+Tka_Z75]==null
endloop
else
set Tka_Z41z[1]=Tka_z22Z+"设定"+Tka_Z30z+Tka_z85Z[Tka_Z75]+Tka_z22Z+"为开启"
call SetMapFlag(ConvertMapFlag(Tka_Z55z),true)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,4)=="rp")then
set Tka_Z54z=Tka_z79Z(6)
if(Tka_Z54z!=Tka_Z12z)then
call RemovePlayer(Tka_Z54z,ConvertPlayerGameResult(0))
else
call Tka_Z18z(5,Tka_z05)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="ukz")then
if(SubStringBJ(Tka_Z63Z,7,8)=="on")then
set Tka_Z23z=Tka_z79Z(10)
if(Tka_Z23z!=null)then
if(SubStringBJ(Tka_Z63Z,6,6)=="+")then
set Tka_Z42z[Tka_z15]=1
set Tka_Z41z[1]=Tka_z22Z+"开启点击部队改变拥有者"
endif
if(SubStringBJ(Tka_Z63Z,6,6)==" ")then
set Tka_Z42z[Tka_z15]=2
set Tka_Z41z[1]=Tka_z22Z+"开启点击部队改变拥有者"
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,7,9)=="off")then
set Tka_Z42z[Tka_z15]=0
set Tka_Z41z[1]=Tka_z22Z+"关闭点击部队改变拥有者"
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="aukz")then
set Tka_Z23z=Tka_z79Z(8)
set Tka_Z22z=Tka_z79Z(11)
if(Tka_Z23z!=null)and(Tka_Z22z!=null)then
set Tka_Z24z=CreateGroup()
call GroupEnumUnitsInRangeOfLocCounted(Tka_Z24z,GetRectCenter(GetPlayableMapRect()),1000000.00,Condition(function Tka_Z61z),1000000000)
if(SubStringBJ(Tka_Z63Z,7,7)=="+")then
call ForGroupBJ(Tka_Z24z,function Tka_Z62z)
endif
if(SubStringBJ(Tka_Z63Z,7,7)==" ")then
call ForGroupBJ(Tka_Z24z,function Tka_Z63z)
endif
call GroupClear(Tka_Z24z)
set Tka_Z24z=null
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="cff")then
set Tka_Z54z=Tka_z79Z(7)
if(Tka_Z54z!=null)then
if(SubStringBJ(Tka_Z63Z,6,6)=="-")then
set Tka_Z41z[1]=Tka_z22Z+"玩家 |CFF26F0B9"+GetPlayerName(Tka_Z54z)+Tka_z22Z+" 已被允许控制单位"
call SetUserControlForceOn(GetForceOfPlayer(Tka_Z54z))
else
if(Tka_Z54z==Tka_Z12z)then
call Tka_Z18z(2,Tka_z05)
else
call SetUserControlForceOff(GetForceOfPlayer(Tka_Z54z))
endif
set Tka_Z41z[1]=Tka_z22Z+"玩家 |CFF26F0B9"+GetPlayerName(Tka_Z54z)+Tka_z22Z+" 已被禁止控制任何单位"
endif
endif
endif
set Tka_Z54z=Tka_z79Z(6)
if((SubStringBJ(Tka_Z63Z,1,3))=="-ta")then
set Tka_Z67z=Tka_z79Z(9)
if(Tka_Z5zZ=="av")then
set Tka_Z55z=3
endif
if(Tka_Z5zZ=="aa")then
set Tka_Z55z=2
endif
if(Tka_Z5zZ=="ad")then
set Tka_Z55z=5
endif
if(Tka_Z5zZ=="au")then
set Tka_Z55z=0
endif
if(Tka_Z5zZ=="aw")then
set Tka_Z55z=1
endif
if(Tka_Z54z!=null)and(Tka_Z67z!=null)then
call SetPlayerAllianceStateBJ(Tka_Z54z,Tka_Z67z,Tka_Z55z)
endif
endif
endif
if(Tka_Z5zZ=="hp")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z75=S2I(Tka_z92Z(6))
if(StringLength(Tka_Z63Z)<8)then
set Tka_Z54z=Tka_z05
endif
if(Tka_Z75>=1)and(Tka_Z75<=10000)and(Tka_Z54z!=null)then
call SetPlayerHandicapBJ(Tka_Z54z,I2R(Tka_Z75))
set Tka_Z41z[1]=Tka_z22Z+"你已把"+Tka_Z30z+GetPlayerName(Tka_Z54z)+Tka_z22Z+"的生命比例改为"+Tka_Z27z+I2S(Tka_Z75)+"%|r"
endif
endif
if(Tka_Z5zZ=="rn")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z!=null)then
set Tka_Z5zZ=Tka_z92Z(6)
call SetPlayerName(Tka_Z54z,Tka_Z5zZ)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,2,3)=="lt")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
call Tka_Zz6(S2I(Tka_Z11Z))
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,7,200)
if(Tka_Z65Z==" ")then
call DisplayTimedTextToForce(GetPlayersAll(),Tka_Z1,GetPlayerName(Tka_z05)+":"+Tka_Z72+Tka_Z11Z)
endif
if(Tka_Z65Z=="+")then
set Tka_Z8ZZ=Tka_z14(Tka_z05)
call DisplayTimedTextToForce(Tka_Z8ZZ,Tka_Z1,GetPlayerName(Tka_z05)+":"+Tka_Z72+Tka_Z11Z)
call DestroyForce(Tka_Z8ZZ)
endif
if(Tka_Z65Z=="-")then
set Tka_Z8ZZ=Tka_z24(Tka_z05)
call DisplayTimedTextToForce(Tka_Z8ZZ,Tka_Z1,GetPlayerName(Tka_z05)+":"+Tka_Z72+Tka_Z11Z)
call DestroyForce(Tka_Z8ZZ)
endif
set Tka_Z8ZZ=null
endif
if(SubStringBJ(Tka_Z63Z,2,3)=="zd")then
if((Tka_z32)or(Tka_Z13z(Tka_z05)))then
call Tka_Z86()
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="k")then
if(Tka_Z68z=="l")then
if(Tka_Z65Z=="-")then
set Tka_z31[Tka_z15]=false
else
if(Tka_Z65Z=="+")then
set Tka_z31[Tka_z15]=true
endif
endif
else
if(Tka_Z68z=="-")then
call Tka_z07(Tka_z15,false)
else
call Tka_z07(Tka_z15,true)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="j")then
if(Tka_Z5zZ=="wd")then
call Tka_Z36Z(0,Tka_z7[Tka_z15],Tka_z05)
endif
if(Tka_Z5zZ=="nj")then
call Tka_Z36Z(1,Tka_z7[Tka_z15],Tka_z05)
endif
if(Tka_Z5zZ=="lx")then
call Tka_Z36Z(2,Tka_z7[Tka_z15],Tka_z05)
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="r")then
if(Tka_Z68z=="n")then
set Tka_Z11Z=SubStringBJ(GetEventPlayerChatString(),5,StringLength(GetEventPlayerChatString()))
if(Tka_Z11Z!="")then
call SetPlayerName(Tka_z05,Tka_Z11Z)
endif
endif
if(Tka_Z68z=="h")then
if(Tka_Z65Z=="+")then
call Tka_zZ7(Tka_z15,Tka_z05,true)
else
if(Tka_Z65Z=="-")then
call Tka_zZ7(Tka_z15,Tka_z05,false)
endif
endif
endif
if(Tka_Z68z=="m")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z75=S2I(Tka_z92Z(5))
if(StringLength(Tka_Z63Z)<7)then
set Tka_Z54z=Tka_z05
endif
if(Tka_Z65Z=="-")then
call Tka_zz5(Tka_Z54z,Tka_Z75,false)
else
call Tka_zz5(Tka_Z54z,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="w")then
set Tka_Z54z=Tka_z91Z()
set Tka_Z75=S2I(Tka_z92Z(5))
if(StringLength(Tka_Z63Z)<7)then
set Tka_Z54z=Tka_z05
endif
if(Tka_Z65Z=="-")then
call Tka_z35(Tka_Z54z,Tka_Z75,false)
else
call Tka_z35(Tka_Z54z,Tka_Z75,true)
endif
endif
if(Tka_Z5zZ=="p ")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,20))
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(5),Tka_Z75)
endif
if(Tka_Z5zZ=="pm")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,20))
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(4),Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="p")then
if(Tka_Z68z=="+")then
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z40Z)
else
call PauseUnit(Tka_z7[Tka_z15],true)
endif
else
if(Tka_Z68z=="-")then
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_z41Z)
else
call PauseUnit(Tka_z7[Tka_z15],false)
endif
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="h")then
if(Tka_Z5zZ=="dw")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call Tka_ZZ4Z(Tka_z15)
else
call Tka_ZZ3Z(Tka_z7[Tka_z15])
endif
endif
if(Tka_Z5zZ=="sj")then
if(Tka_Z13z(Tka_z05))then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
if Tka_Z11Z=="-"then
call SuspendHeroXPBJ(false,Tka_z7[Tka_z15])
else
call SuspendHeroXPBJ(true,Tka_z7[Tka_z15])
endif
endif
endif
if(Tka_Z68z=="e")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,20))
if Tka_Z65Z=="-"then
call SetHeroXP(Tka_z7[Tka_z15],GetHeroXP(Tka_z7[Tka_z15])-Tka_Z75,false)
else
call SetHeroXP(Tka_z7[Tka_z15],GetHeroXP(Tka_z7[Tka_z15])+Tka_Z75,false)
endif
endif
if(Tka_Z68z=="j")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,20))
if Tka_Z65Z=="-"then
call ModifyHeroSkillPoints(Tka_z7[Tka_z15],1,Tka_Z75)
else
if Tka_Z65Z=="+"then
call ModifyHeroSkillPoints(Tka_z7[Tka_z15],0,Tka_Z75)
else
call ModifyHeroSkillPoints(Tka_z7[Tka_z15],2,Tka_Z75)
endif
endif
endif
if(Tka_Z68z=="u")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,20))
if Tka_Z75==0 then
set Tka_Z75=1
endif
if(Tka_Z65Z=="-")then
call Tka_Zz9Z(Tka_z15,Tka_Z75,false)
else
call Tka_Zz9Z(Tka_z15,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="l")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,1))
if(Tka_Z75==0)then
set Tka_Z75=Tka_zz
endif
if(Tka_Z65Z=="-")then
call Tka_Zz3Z(Tka_z15,0,Tka_Z75,false)
else
call Tka_Zz3Z(Tka_z15,0,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="m")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,1))
if(Tka_Z75==0)then
set Tka_Z75=Tka_zz
endif
if(Tka_Z65Z=="-")then
call Tka_Zz3Z(Tka_z15,1,Tka_Z75,false)
else
call Tka_Zz3Z(Tka_z15,1,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="z")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,1))
if(Tka_Z75==0)then
set Tka_Z75=Tka_zz
endif
if(Tka_Z65Z=="-")then
call Tka_Zz3Z(Tka_z15,2,Tka_Z75,false)
else
call Tka_Zz3Z(Tka_z15,2,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="a")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,5,1))
if(Tka_Z75==0)then
set Tka_Z75=Tka_zz
endif
if(Tka_Z65Z=="-")then
call Tka_Zz3Z(Tka_z15,0,Tka_Z75,false)
call Tka_Zz3Z(Tka_z15,1,Tka_Z75,false)
call Tka_Zz3Z(Tka_z15,2,Tka_Z75,false)
else
call Tka_Zz3Z(Tka_z15,0,Tka_Z75,true)
call Tka_Zz3Z(Tka_z15,1,Tka_Z75,true)
call Tka_Zz3Z(Tka_z15,2,Tka_Z75,true)
endif
endif
if(Tka_Z68z=="r")then
call Tka_Zz1Z(Tka_z05)
endif
if(Tka_Z5zZ=="fz")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call Tka_z98(Tka_z15,true)
else
call Tka_z98(Tka_z15,false)
endif
endif
if(Tka_Z5zZ=="db")then
call Tka_ZZ5Z(Tka_z15)
endif
if(Tka_Z5zZ=="cw")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,20))
call Tka_ZZ7Z(Tka_z15,Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="a")then
if(Tka_Z68z=="m")then
set Tka_Z55z=Tka_z77Z(5)
if(Tka_Z65Z=="-")then
call Tka_zz6(Tka_z40[Tka_Z55z],false)
else
call Tka_zz6(Tka_z40[Tka_Z55z],true)
endif
endif
if(Tka_Z68z=="w")then
set Tka_Z55z=Tka_z77Z(5)
if(Tka_Z65Z=="-")then
call Tka_zz6(Tka_z50[Tka_Z55z],false)
else
call Tka_zz6(Tka_z50[Tka_Z55z],true)
endif
endif
if(Tka_Z68z=="p")then
set Tka_Z55z=Tka_z77Z(5)
if(Tka_Z65Z=="-")then
call Tka_zz6(Tka_z60[Tka_Z55z],false)
else
call Tka_zz6(Tka_z60[Tka_Z55z],true)
endif
endif
if(Tka_Z5zZ=="cd")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
set Tka_Z55z=Tka_z77Z(6)
if(Tka_Z11Z=="-")then
call Tka_zz6(Tka_z80[Tka_Z55z],false)
else
call Tka_zz6(Tka_z80[Tka_Z55z],true)
endif
endif
if(Tka_Z5zZ=="mp")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
set Tka_Z55z=Tka_z77Z(6)
if(Tka_Z11Z=="-")then
call Tka_zz6(Tka_z90[Tka_Z55z],false)
else
call Tka_zz6(Tka_z90[Tka_Z55z],true)
endif
endif
if(Tka_Z5zZ=="rs")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
set Tka_Z55z=Tka_z77Z(6)
if(Tka_Z11Z=="-")then
call Tka_zz6(Tka_z70[Tka_Z55z],false)
else
call Tka_zz6(Tka_z70[Tka_Z55z],true)
endif
endif
if(Tka_Z68z=="a")then
set Tka_Z55z=Tka_z77Z(5)
if(Tka_Z65Z=="-")then
call Tka_z16(Tka_Z55z,false)
else
call Tka_z16(Tka_Z55z,true)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="u")then
if(Tka_Z63Z=="-u")then
else
if(Tka_Z68z=="g")then
set Tka_Z75=Tka_Z22Z(SubStringBJ(Tka_Z63Z,3,5))
if(Tka_Z75==0)then
else
if(SubStringBJ(Tka_Z63Z,6,6)=="-")then
call Tka_Z21Z(Tka_z15,Tka_Z75,false)
else
call Tka_Z21Z(Tka_z15,Tka_Z75,true)
endif
endif
if(SubStringBJ(Tka_Z63Z,4,5)=="ca")then
call Tka_Z31Z(Tka_z15,false)
endif
if(SubStringBJ(Tka_Z63Z,4,5)=="oa")then
call Tka_Z31Z(Tka_z15,true)
endif
endif
if(Tka_Z68z=="q")then
set Tka_Z75=Tka_Z22Z(SubStringBJ(Tka_Z63Z,3,5))
if(Tka_Z75==0)then
else
if(SubStringBJ(Tka_Z63Z,6,6)=="-")then
call Tka_Z21Z(Tka_z15,Tka_Z75,false)
else
call Tka_Z21Z(Tka_z15,Tka_Z75,true)
endif
endif
endif
set Tka_Z75=Tka_Z22Z(Tka_Z5zZ)
if(Tka_Z75==0)then
else
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z21Z(Tka_z15,Tka_Z75,false)
else
call Tka_Z21Z(Tka_z15,Tka_Z75,true)
endif
endif
if(Tka_Z5zZ=="cq")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z26Z(Tka_z15,false)
else
call Tka_Z26Z(Tka_z15,true)
endif
endif
if(Tka_Z5zZ=="wd")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z24Z(Tka_z15,false)
else
call Tka_Z24Z(Tka_z15,true)
endif
endif
if(Tka_Z5zZ=="hp")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,8))
if(Tka_Z14Z<=100)then
call SetUnitLifePercentBJ(Tka_z7[Tka_z15],100-Tka_Z14Z)
endif
endif
if(Tka_Z5zZ=="mp")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,8))
if(Tka_Z14Z<=100)then
call SetUnitManaPercentBJ(Tka_z7[Tka_z15],100-Tka_Z14Z)
endif
endif
if(Tka_Z5zZ=="lt")then
call Tka_Z16(S2I(SubStringBJ(Tka_Z63Z,6,6)),Tka_z7[Tka_z15],SubStringBJ(Tka_Z63Z,8,200))
endif
if((Tka_Z5zZ=="kz")and((Tka_z7Z)or(Tka_Z13z(Tka_z05))))then
set Tka_Z65=Tka_z05
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))
if((Tka_Z75>=1)and(Tka_Z75<=16))or(Tka_Z75==0)then
if(Tka_Z13z(Tka_z05))and((Tka_Z75>=1)and(Tka_Z75<=16))then
set Tka_Z65=Player(Tka_Z75-1)
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call SetUnitOwner(Tka_z7[Tka_z15],Tka_Z65,false)
else
call SetUnitOwner(Tka_z7[Tka_z15],Tka_Z65,true)
endif
endif
endif
if(Tka_Z5zZ=="ys")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z29Z(Tka_z15,false)
else
call Tka_Z29Z(Tka_z15,true)
endif
endif
if((Tka_Z5zZ=="ms")and((Tka_z9Z)or(Tka_Z13z(Tka_z05))))then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z3ZZ(Tka_z15,false)
else
call Tka_Z3ZZ(Tka_z15,true)
endif
endif
if(Tka_Z5zZ=="ca")then
call Tka_Z34Z(Tka_z15)
endif
if((Tka_Z5zZ=="jk")and(Tka_Z13z(Tka_z05)))then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,20))
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z87(Tka_z7[Tka_z15],Tka_Z75,false)
else
call Tka_Z87(Tka_z7[Tka_z15],Tka_Z75,true)
endif
endif
if(Tka_Z5zZ=="yd")then
call Tka_z55(Tka_z51[Tka_z15],Tka_z7[Tka_z15],false)
endif
if(Tka_Z5zZ=="jh")then
call Tka_z55(Tka_z7[Tka_z15],Tka_z51[Tka_z15],true)
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="del")then
if(SubStringBJ(Tka_Z63Z,6,6)=="+")then
if(Tka_Z13z(Tka_z05))then
call Tka_z36(Player(Tka_z77Z(7)))
else
call Tka_z36(Tka_z05)
endif
else
call RemoveUnit(Tka_z7[Tka_z15])
endif
endif
if(Tka_Z5zZ=="nm")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,6))
if(Tka_Z75==1)then
call Tka_Z37(1752196449,Tka_z05,Tka_Z9Z[Tka_z15])
endif
if(Tka_Z75==2)then
call Tka_Z37(1869636975,Tka_z05,Tka_Z9Z[Tka_z15])
endif
if(Tka_Z75==3)then
call Tka_Z37(1702327152,Tka_z05,Tka_Z9Z[Tka_z15])
endif
if(Tka_Z75==4)then
call Tka_Z37(1969316719,Tka_z05,Tka_Z9Z[Tka_z15])
endif
if(Tka_Z75==5)then
call Tka_Z37(1852665957,Tka_z05,Tka_Z9Z[Tka_z15])
endif
endif
if(Tka_Z5zZ=="cu")then
if(SubStringBJ(Tka_Z63Z,5,5)=="?")then
call Tka_Z66Z(Tka_z7[Tka_z15])
else
set Tka_Z65Z=SubStringBJ(Tka_Z63Z,6,20)
set Tka_Z75=UnitId(Tka_Z65Z)
if(Tka_Z75==0)then
set Tka_Z75=Tka_Z1zZ(6)
endif
call Tka_Z37(Tka_Z75,Tka_z05,Tka_Z9Z[Tka_z15])
endif
endif
if(Tka_Z5zZ=="ci")then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,11,20))
if(Tka_Z55z==0)then
set Tka_Z55z=1
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="?")then
call Tka_Z67Z(Tka_z7[Tka_z15])
else
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call Tka_Z12Z(Tka_z7[Tka_z15],6,false,Tka_Z55z)
else
call Tka_Z12Z(Tka_z7[Tka_z15],6,true,Tka_Z55z)
endif
endif
endif
if(Tka_Z5zZ=="ua")then
set Tka_Z75=Tka_Z1zZ(6)
if(Tka_Z75==0)then
else
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z21Z(Tka_z15,Tka_Z75,false)
else
call Tka_Z21Z(Tka_z15,Tka_Z75,true)
endif
endif
endif
if(Tka_Z5zZ=="st")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,6,20)
if(Tka_Z11Z=="")then
call CreateCorpse(Tka_z05,GetUnitTypeId(Tka_z7[Tka_z15]),GetUnitX(Tka_z7[Tka_z15]),GetUnitY(Tka_z7[Tka_z15]),0)
else
call CreateCorpse(Tka_z05,Tka_Z0ZZ(SubStringBJ(GetEventPlayerChatString(),6,20)),GetUnitX(Tka_z7[Tka_z15]),GetUnitY(Tka_z7[Tka_z15]),0)
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="size")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,8,10))
if(Tka_Z14Z==0)then
set Tka_Z14Z=100
endif
call SetUnitScalePercent(Tka_z7[Tka_z15],Tka_Z14Z,Tka_Z14Z,Tka_Z14Z)
endif
if(Tka_Z5zZ=="co")then
call SetUnitVertexColorBJ(Tka_z7[Tka_z15],S2R(SubStringBJ(Tka_Z63Z,6,8)),S2R(SubStringBJ(Tka_Z63Z,10,12)),S2R(SubStringBJ(Tka_Z63Z,14,16)),S2R(SubStringBJ(Tka_Z63Z,18,20)))
endif
if(Tka_Z5zZ=="cl")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z18)
else
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z28)
else
call Tka_z97(Tka_z7[Tka_z15],S2I(SubStringBJ(Tka_Z63Z,6,6)),S2I(SubStringBJ(Tka_Z63Z,8,8)))
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,3,5)=="inf")then
call Tka_Z68Z(Tka_z15)
call Tka_Z49z(Tka_z05)
endif
if(Tka_Z5zZ=="sp")then
call MoveLocation(Tka_Z9Z[Tka_z15],GetUnitX(Tka_z7[Tka_z15]),GetUnitY(Tka_z7[Tka_z15]))
endif
if(Tka_Z5zZ=="fz")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,20))
if(Tka_Z75==0)then
set Tka_Z75=1
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
set Tka_Z65=GetOwningPlayer(Tka_z7[Tka_z15])
call Tka_Z77(Tka_z7[Tka_z15],Tka_Z65,Tka_Z75)
else
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z47(Tka_z7[Tka_z15],Tka_z05,Tka_Z75,true)
else
if(SubStringBJ(Tka_Z63Z,5,5)=="h")then
call Tka_z56(Tka_z7[Tka_z15],Tka_z05)
else
if(SubStringBJ(Tka_Z63Z,5,5)=="d")then
if(GetUnitUserData(Tka_z7[Tka_z15])==2176)then
call SetUnitUserData(Tka_z7[Tka_z15],0)
endif
else
call Tka_Z77(Tka_z7[Tka_z15],Tka_z05,Tka_Z75)
endif
endif
endif
endif
endif
if(Tka_Z5zZ=="hw")then
set Tka_Z14Z=S2R(SubStringBJ(Tka_Z63Z,6,8))
if(Tka_Z14Z==0)then
set Tka_Z14Z=500
endif
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z13Z(Tka_z7[Tka_z15],Tka_Z14Z,false)
else
call Tka_Z13Z(Tka_z7[Tka_z15],Tka_Z14Z,true)
endif
endif
if(Tka_Z5zZ=="fg")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call Tka_Z15Z(Tka_z7[Tka_z15],GetUnitDefaultFlyHeight(Tka_z7[Tka_z15]))
else
call Tka_Z15Z(Tka_z7[Tka_z15],S2R(SubStringBJ(Tka_Z63Z,6,9)))
endif
endif
if(Tka_Z5zZ=="yj")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z77Z)
else
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z78Z)
endif
endif
endif
if(Tka_Z5zZ=="ss")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
set Tka_Z75=Tka_zz8(S2I(SubStringBJ(Tka_Z63Z,6,7)))
if(Tka_Z75==0)then
set Tka_Z75=Tka_z18()
endif
if(Tka_Z11Z=="+")then
call Tka_z28(Tka_z7[Tka_z15],1,Tka_Z75,S2I(SubStringBJ(Tka_Z63Z,8,10)))
endif
if(Tka_Z11Z=="-")then
call Tka_z28(Tka_z7[Tka_z15],2,Tka_Z75,S2I(SubStringBJ(Tka_Z63Z,8,10)))
endif
if(Tka_Z11Z=="/")then
call Tka_z28(Tka_z7[Tka_z15],3,Tka_Z75,S2I(SubStringBJ(Tka_Z63Z,8,10)))
endif
if(Tka_Z11Z=="*")then
call Tka_z28(Tka_z7[Tka_z15],4,Tka_Z75,S2I(SubStringBJ(Tka_Z63Z,8,10)))
endif
endif
if(SubStringBJ(Tka_Z63Z,3,6)=="hero")then
if(SubStringBJ(Tka_Z63Z,7,7)=="+")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z75Z)
else
if(SubStringBJ(Tka_Z63Z,7,7)=="-")then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_Z76Z)
endif
endif
endif
endif
endif
if(Tka_Z13z(Tka_z05))then
if(SubStringBJ(Tka_Z63Z,2,3)=="lx")then
set Tka_z13=false
set Tka_Z54z=Tka_z79Z(5)
if(Tka_Z54z!=null)then
set Tka_Z41z[1]=Tka_z84Z[GetPlayerId(Tka_Z54z)]+GetPlayerName(Tka_Z54z)+Tka_z22Z+" 将无法储存重播纪录"
if(GetLocalPlayer()==Tka_Z54z)then
call DoNotSaveReplay()
endif
else
set Tka_Z41z[1]=Tka_z22Z+"所有人也将无法储存重播纪录"
call DoNotSaveReplay()
endif
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="g")then
if(Tka_Z5zZ=="tr")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
set Tka_Z65=GetOwningPlayer(Tka_z7[Tka_z15])
if(Tka_Z65==Tka_z05)then
else
if(Tka_Z65==Tka_Z12z)then
call Tka_Z18z(0,Tka_z05)
else
call CustomDefeatBJ(Tka_Z65,SubStringBJ(Tka_Z63Z,6,200))
endif
endif
else
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))
if((Tka_Z75>0)and(Tka_Z75<13))then
set Tka_Z65=Player(Tka_Z75-1)
if(Tka_Z65==Tka_Z12z)then
call Tka_Z18z(0,Tka_z05)
else
call CustomDefeatBJ(Tka_Z65,SubStringBJ(Tka_Z63Z,9,200))
endif
endif
endif
endif
if(Tka_Z5zZ=="dx")then
if(SubStringBJ(Tka_Z63Z,5,5)=="+")then
set Tka_Z65=GetOwningPlayer(Tka_z7[Tka_z15])
if(Tka_Z65==Tka_z05)then
else
if(Tka_Z65==Tka_Z12z)then
call Tka_Z18z(1,Tka_z05)
else
call Tka_z45(Tka_Z65)
endif
endif
else
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))
if((Tka_Z75>0)and(Tka_Z75<13))then
set Tka_Z65=Player(Tka_Z75-1)
if(Tka_Z65==Tka_Z12z)then
call Tka_Z18z(1,Tka_z05)
else
call Tka_z45(Tka_Z65)
endif
endif
endif
endif
if(Tka_Z5zZ=="hk")then
set Tka_Z54z=Tka_z91Z()
if(Tka_Z54z!=null)then
set Tka_Z41z[1]=Tka_Z27z+GetPlayerName(Tka_z05)+"|r已把主机权限交给"+Tka_Z30z+GetPlayerName(Tka_Z54z)+"|r"
call Tka_Z57z()
set Tka_z5=Tka_Z54z
call Tka_z57(GetPlayerId(Tka_z5),Tka_z5)
endif
endif
if(Tka_Z5zZ=="of")then
set Tka_Z41z[1]=Tka_Z29z+"开始全面关闭RG作弊系统!|r"
call Tka_Z57z()
call TriggerSleepAction(0.20)
set Tka_Z41z[1]=Tka_Z29z+"关闭RG作弊系统!|r"
call Tka_Z57z()
set Tka_Z41z[1]=Tka_Z29z+"关闭菜单作弊!|r"
call Tka_Z57z()
call TriggerSleepAction(0.20)
set Tka_Z41z[1]=Tka_Z29z+"关闭指令作弊!|r"
call Tka_Z57z()
call TriggerSleepAction(0.10)
set Tka_Z41z[1]=Tka_Z29z+"关闭方向键作弊!|r"
call Tka_Z57z()
call TriggerSleepAction(0.15)
set Tka_Z41z[1]=Tka_Z29z+"RG作弊系统已被全面关闭! 这场游戏内将无法再开启!|r"
call Tka_Z57z()
set Tka_z4=true
set Tka_z5=null
set Tka_z15=0
loop
set Tka_z6[Tka_z15]=false
exitwhen Tka_z15==13
set Tka_z15=Tka_z15+1
endloop
endif
if(Tka_Z5zZ=="tq")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
if(Tka_Z11Z=="-")then
if(S2I(SubStringBJ(Tka_Z63Z,6,7))==0)then
call Tka_zZ8()
else
call Tka_Z98(S2I(SubStringBJ(Tka_Z63Z,6,7)),false)
endif
else
call Tka_Z98(S2I(SubStringBJ(Tka_Z63Z,6,7)),true)
endif
endif
if(Tka_Z5zZ=="ss")then
call Tka_Z08(S2I(SubStringBJ(Tka_Z63Z,6,6)),S2I(SubStringBJ(Tka_Z63Z,8,8)))
endif
if(Tka_Z5zZ=="tk")then
call Tka_Z58(S2I(SubStringBJ(Tka_Z63Z,6,7)))
endif
if(Tka_Z5zZ=="cp")then
set Tka_Z11Z=SubStringBJ(Tka_Z63Z,5,5)
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,6,7))
if((Tka_Z75>0)and(Tka_Z75<13)and(Tka_Z75!=Tka_z15+1))then
set Tka_Z75=(Tka_Z75-1)
set Tka_Z65=Player(Tka_Z75)
if(GetPlayerController(Tka_Z65)==ConvertMapControl(0))then
if(Tka_Z11Z=="+")then
call Tka_z57(Tka_Z75,Tka_Z65)
set Tka_Z41z[1]=Tka_z22Z+"你已获得作弊权限 用-tka获得查询"
call Tka_Z49z(Tka_Z65)
else
if(Tka_Z11Z=="-")then
call Tka_z47(Tka_Z75)
set Tka_Z41z[1]=Tka_z22Z+"你已被收回作弊权限"
call Tka_Z49z(Player(Tka_Z75))
endif
endif
endif
endif
endif
if(Tka_Z5zZ=="sj")then
call SetTimeOfDay(S2R(SubStringBJ(Tka_Z63Z,6,7)))
endif
if(SubStringBJ(Tka_Z63Z,3,7)=="pause")then
if(SubStringBJ(Tka_Z63Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
endif
if(Tka_Z5zZ=="ca")then
if(SubStringBJ(Tka_Z63Z,5,5)=="-")then
set Tka_Z0=false
else
set Tka_Z0=true
endif
endif
if(SubStringBJ(Tka_Z63Z,2,4)=="set")then
if(Tka_Z63Z=="-set")then
call Tka_Z64Z()
call Tka_Z49z(Tka_z5)
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="am")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_z4Z=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="aw")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_z5Z=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="ap")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75>5)then
set Tka_z6Z=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,8)=="amp")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,10,30))
set Tka_Z14Z=I2R(Tka_Z75)
if(Tka_Z14Z>=50.)then
set Tka_ZZZ=Tka_Z14Z
endif
endif
if(SubStringBJ(Tka_Z63Z,6,8)=="ahp")then
if(SubStringBJ(Tka_Z63Z,9,9)=="t")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,11,30))
set Tka_Z14Z=I2R(Tka_Z75)
if((Tka_Z14Z!=0)and(Tka_Z14Z<=100)and(Tka_Z14Z<=Tka_z41))then
set Tka_z92=I2R(Tka_Z75)
endif
else
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,10,30))
if((Tka_Z75!=0)and(Tka_Z75<=100))then
set Tka_z41=I2R(Tka_Z75)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="km")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75>=0)then
set Tka_zZ=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="kw")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75>=0)then
set Tka_Zz=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="kg")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75>=0)then
set Tka_zz=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="mg")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_Z3=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="it")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_Z1=I2R(Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="mt")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_z1=I2R(Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="ha")then
if(SubStringBJ(Tka_Z63Z,8,8)=="p")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,10,30))
if(Tka_Z75!=0)then
set Tka_Z4=I2R(Tka_Z75)
endif
else
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if(Tka_Z75!=0)then
set Tka_z3=I2R(Tka_Z75)
endif
endif
endif
if(SubStringBJ(Tka_Z63Z,6,8)=="bag")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,10,10))
if((Tka_Z75>0)and(Tka_Z75<4))then
set Tka_z61=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="rt")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if((Tka_Z75!=0)and(Tka_Z75<=100))then
set Tka_z22=Tka_Z75
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="zd")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
if((Tka_Z75!=0)and(Tka_Z75<=100))then
set Tka_z42=I2R(Tka_Z75)
endif
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="mw")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
set Tka_z2=Tka_Z75
endif
if(SubStringBJ(Tka_Z63Z,6,7)=="mm")then
set Tka_Z75=S2I(SubStringBJ(Tka_Z63Z,9,30))
set Tka_Z2=Tka_Z75
endif
endif
endif
endif
endif
endif
if(Tka_Z12z==Tka_z05)then
if(Tka_Z63Z=="-topen")then
set Tka_Z10z[Tka_Z14z]=true
set Tka_Z10z[Tka_z15]=true
set Tka_Z41z[1]=GetLocalizedString("Tka_ZZ")
endif
if(Tka_Z63Z=="-tclose")then
set Tka_Z10z[Tka_Z14z]=false
set Tka_Z10z[Tka_z15]=false
set Tka_Z41z[1]=GetLocalizedString("Tka_Z4Z")
endif
endif
call Tka_Z49z(Tka_z05)
set Tka_Z54z=null
set Tka_Z67z=null
set Tka_z05=null
set Tka_Z65=null
set Tka_Z68z=""
set Tka_Z11Z=""
set Tka_Z63Z=""
set Tka_Z5zZ=""
set Tka_Z65Z=""
endfunction
function Tka_Z8zZ takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
local string Tka_Z11Z
local string Tka_Z63Z
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z11Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(GetPlayerName(Tka_z5),false)
if((Tka_Z63Z==StringCase(SubStringBJ(Tka_Z0z,18,20),false))or(Tka_Z63Z==SubStringBJ(Tka_Z0z,32,37)))then
else
if(Tka_Z11Z=="iam"+SubStringBJ(Tka_Z0z,106,124))then
set Tka_z4=false
set Tka_z5=null
set Tka_Z75=0
loop
exitwhen Tka_Z75>11
call Tka_z47(Tka_Z75)
call EnableTrigger(Tka_z00[Tka_Z75])
call EnableTrigger(Tka_z10[Tka_Z75])
call EnableTrigger(Tka_z20[Tka_Z75])
set Tka_Z75=Tka_Z75+1
endloop
else
if((Tka_Z11Z==SubStringBJ(Tka_Z0z,106,124)+"ismatser")and(Tka_Z15z()))then
set Tka_z5=Tka_z05
set Tka_z6[Tka_z15]=true
endif
endif
endif
set Tka_z05=null
set Tka_Z11Z=""
set Tka_Z63Z=""
endfunction
function Tka_Z80Z takes nothing returns nothing
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(5),0)
set Tka_z05=null
endfunction
function Tka_Z81Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(GetPlayerState(Tka_z05,ConvertPlayerState(1))<=Tka_z4Z))then
set Tka_Z75=(Tka_z4Z/2)
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(1),(GetPlayerState(Tka_z05,ConvertPlayerState(1))+Tka_Z75))
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(15),(GetPlayerState(Tka_z05,ConvertPlayerState(15))-Tka_Z75))
endif
set Tka_z05=null
endfunction
function Tka_Z82Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(GetPlayerState(Tka_z05,ConvertPlayerState(2))<=Tka_z5Z))then
set Tka_Z75=(Tka_z5Z/2)
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(2),(GetPlayerState(Tka_z05,ConvertPlayerState(2))+Tka_Z75))
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(16),(GetPlayerState(Tka_z05,ConvertPlayerState(16))-Tka_Z75))
endif
set Tka_z05=null
endfunction
function Tka_Z83Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if((GetPlayerState(Tka_z05,ConvertPlayerState(5))>=Tka_z6Z)or(GetPlayerState(Tka_z05,ConvertPlayerState(5))<3))then
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(5),5)
endif
endif
set Tka_z05=null
endfunction
function Tka_Z84Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
local location Tka_z95
set Tka_z65=GetTriggerUnit()
set Tka_z05=GetOwningPlayer(Tka_z65)
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
set Tka_z95=GetUnitLoc(Tka_z65)
call ReviveHeroLoc(Tka_z65,Tka_z95,false)
call SetUnitState(Tka_z65,ConvertUnitState(2),GetUnitState(Tka_z65,ConvertUnitState(3)))
call UnitResetCooldown(Tka_z65)
call RemoveLocation(Tka_z95)
endif
set Tka_z65=null
set Tka_z05=null
set Tka_z95=null
endfunction
function Tka_Z85Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
set Tka_z65=GetTriggerUnit()
call UnitResetCooldown(Tka_z65)
set Tka_z65=null
endif
set Tka_z05=null
endfunction
function Tka_Z86Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
set Tka_z65=GetTriggerUnit()
call SetUnitState(Tka_z65,ConvertUnitState(2),GetUnitState(Tka_z65,ConvertUnitState(3))*Tka_ZZZ*.01)
set Tka_z65=null
endif
set Tka_z05=null
endfunction
function Tka_Z87Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
set Tka_z65=GetTriggerUnit()
if(GetUnitLifePercent(Tka_z65)<=Tka_z92)then
call SetUnitLifePercentBJ(Tka_z65,Tka_z41)
endif
set Tka_z65=null
endif
set Tka_z05=null
endfunction
function Tka_Z46z takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z70z
local integer Tka_Z54z
local player Tka_z05
local unit Tka_z65
set Tka_Z54z=0
set Tka_Z70z=GetResearched()
set Tka_z65=GetTriggerUnit()
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
loop
exitwhen Tka_Z54z==13
if(Tka_Z37z[Tka_Z54z])and(Tka_Z15z())and(Tka_Z11z(Tka_Z54z))then
set Tka_Z41z[1]="侦测到"+Tka_Z47z(Tka_z65,null,Player(Tka_Z54z))+GetPlayerName(Tka_z05)+Tka_z22Z+"("+I2S(GetPlayerId(GetOwningPlayer(Tka_z65))+1)+")"+"|r 研发科技完毕 科技名称/ID : |CFF00E800"+GetObjectName(Tka_Z70z)+"/"+Tka_Z05Z(Tka_Z70z)+"|r "
set Tka_Z41z[2]="等级 : |CFF00E800"+I2S(GetPlayerTechCountSimple(Tka_Z70z,Tka_z05))+"|r"
call Tka_Z49z(Player(Tka_Z54z))
endif
set Tka_Z54z=Tka_Z54z+1
endloop
set Tka_z65=null
set Tka_z05=null
endfunction
function Tka_Z45z takes nothing returns nothing
local player Tka_z05
local unit Tka_z65
local integer Tka_Z54z
local integer Tka_Z70z
set Tka_Z54z=0
set Tka_Z70z=GetSpellAbilityId()
set Tka_z65=GetTriggerUnit()
loop
exitwhen Tka_Z54z==13
if(Tka_Z37z[Tka_Z54z])and(Tka_Z15z())and(Tka_Z11z(Tka_Z54z))then
set Tka_Z41z[1]="侦测到"+Tka_Z47z(Tka_z65,null,Player(Tka_Z54z))+GetPlayerName(GetOwningPlayer(Tka_z65))+Tka_z22Z+"("+I2S(GetPlayerId(GetOwningPlayer(Tka_z65))+1)+")"+"|r 的部队施放技能 部队名称/ID : |CFF00E800"+GetUnitName(Tka_z65)+"/"+Tka_Z05Z(GetUnitTypeId(Tka_z65))+"|r "
set Tka_Z41z[2]="技能名称/ID : |CFF00E800"+GetObjectName(Tka_Z70z)+"/"+Tka_Z05Z(Tka_Z70z)+"|r 等级 : |CFF00E800"+I2S(GetUnitAbilityLevel(Tka_z65,Tka_Z70z))+"|r"
call Tka_Z49z(Player(Tka_Z54z))
endif
set Tka_Z54z=Tka_Z54z+1
endloop
set Tka_z65=null
set Tka_z05=null
endfunction
function Tka_Z88Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local player Tka_Z65
local unit Tka_z65
local integer Tka_Z75=0
set Tka_z65=GetTriggerUnit()
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_Z13z(Tka_z05))then
if(IsUnitInGroup(Tka_z65,Tka_Z83z))then
loop
if(Tka_z65==Tka_z95Z[Tka_Z75])then
if(Tka_z37Z[Tka_Z75])then
set Tka_Z41z[1]="|CFF00FF00(开启)"
else
set Tka_Z41z[1]="|CFFFF0000(关闭)"
endif
set Tka_Z41z[1]=Tka_z22Z+"地型ID : |CFF00FF00"+Tka_Z05Z(Tka_z96Z[Tka_Z75])+Tka_z22Z+"　附加通行属性 : |CFF00FF00"+Tka_z97Z[Tka_z36Z[Tka_Z75]]+Tka_Z41z[1]
call Tka_Z49z(Tka_z05)
exitwhen true
endif
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75>=Tka_Z85z
endloop
endif
if(Tka_Z42z[Tka_z15]==1)then
call SetUnitOwner(Tka_z65,Tka_Z23z,false)
endif
if(Tka_Z42z[Tka_z15]==2)then
call SetUnitOwner(Tka_z65,Tka_Z23z,true)
endif
endif
if(Tka_Z38z[Tka_z15]==2)then
call RemoveUnit(Tka_z65)
elseif(Tka_Z38z[Tka_z15]==1)then
call KillUnit(Tka_z65)
elseif(Tka_Z38z[Tka_z15]==3)then
call ExplodeUnitBJ(Tka_z65)
endif
if(Tka_Z37z[Tka_z15])then
set Tka_Z41z[1]="拥有者 : "+Tka_Z47z(Tka_z65,null,Tka_z05)+GetPlayerName(GetOwningPlayer(Tka_z65))+Tka_z22Z+"("+I2S(GetPlayerId(GetOwningPlayer(Tka_z65))+1)+")"+"  |r部队ID : |CFF00E800"+Tka_Z05Z(GetUnitTypeId(Tka_z65))+"|r"
call Tka_Z49z(Tka_z05)
endif
call GroupAddUnit(Tka_Z8Z[Tka_z15],Tka_z65)
if(Tka_z7[Tka_z15]==Tka_z65)then
set Tka_Z8[Tka_z15]=(Tka_Z8[Tka_z15]+1)
if(CountUnitsInGroup(Tka_Z8Z[Tka_z15])>1)then
call GroupClear(Tka_Z8Z[Tka_z15])
call GroupAddUnit(Tka_Z8Z[Tka_z15],Tka_z65)
endif
if((Tka_Z8[Tka_z15]==2)and(Tka_Z7[Tka_z15]))then
call Tka_Z50Z(Tka_z15,Tka_z05)
endif
else
set Tka_Z8[Tka_z15]=1
set Tka_z51[Tka_z15]=Tka_z7[Tka_z15]
endif
endif
if(Tka_Z43[Tka_z15])then
if((Tka_zzZ[Tka_z15])and(Tka_zZZ[Tka_z15]))then
set Tka_Z65=GetOwningPlayer(Tka_z65)
if(IsUnitAlly(Tka_z65,Tka_z05)or(Tka_Z65==Tka_z05))then
else
call Tka_Z4zZ(Tka_z65)
endif
endif
endif
set Tka_z7[Tka_z15]=Tka_z65
set Tka_z65=null
set Tka_z05=null
endfunction
function Tka_Z89Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
set Tka_z65=GetTriggerUnit()
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
call GroupRemoveUnit(Tka_Z8Z[Tka_z15],Tka_z65)
endif
set Tka_z65=null
set Tka_z05=null
endfunction
function Tka_Z9ZZ takes nothing returns nothing
local unit Tka_z65=GetAttacker()
local unit Tka_z76=GetTriggerUnit()
local player Tka_z05=GetOwningPlayer(Tka_z65)
local integer Tka_z15=GetPlayerId(Tka_z05)
local player Tka_Z65=GetOwningPlayer(Tka_z76)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))and(Tka_z88Z)then
if((IsUnitInGroup(Tka_z65,Tka_z8Z))and((Tka_Z65!=Tka_z5)or(Tka_Z13z(Tka_z05))or(Tka_Z5Z==false))and((IsUnitType(Tka_z76,ConvertUnitType(2))==false)or(Tka_ZZz==false)))then
call SetWidgetLife(Tka_z76,1.)
call UnitDamageTargetBJ(Tka_z65,Tka_z76,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z65=null
set Tka_z76=null
endfunction
function Tka_z99Z takes nothing returns nothing
local unit Tka_z65=GetEnteringUnit()
local player Tka_z05=GetOwningPlayer(Tka_z65)
local player Tka_Z65=GetLocalPlayer()
if(IsUnitIllusion(Tka_z65))then
call GroupAddUnit(Tka_z94Z,Tka_z65)
if(Tka_z87Z[GetPlayerId(Tka_Z65)])and(IsPlayerEnemy(Tka_z05,Tka_Z65))then
call SetUnitVertexColor(Tka_z65,0,0, 255,255)
endif
endif
set Tka_z65=null
set Tka_z05=null
set Tka_Z65=null
endfunction
function Tka_Z9zZ takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
local location Tka_z95
local integer Tka_Z75
local integer Tka_Z69z
local integer Tka_Z55z
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_z95=GetOrderPointLoc()
set Tka_z65=GetTriggerUnit()
if(GetIssuedOrderIdBJ()==851990)then
if(Tka_z35Z[Tka_z15])then
call SetUnitPositionLoc(Tka_z65,Tka_z95)
endif
endif
if(GetIssuedOrderId()==851971)then
if((Tka_Z15z())and(Tka_Z11z(Tka_z15))and(Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15]))and(Tka_Z86z[Tka_z15])then
call SetUnitPositionLoc(Tka_z65,Tka_z95)
endif
if(not((Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15])))then
if(Tka_z03z[Tka_z15])then
set Tka_Z69z=0
loop
if(Tka_z95Z[Tka_Z69z]==null)or(Tka_z95Z[Tka_Z69z]==Tka_z65)then
set Tka_z95Z[Tka_Z69z]=Tka_z65
set Tka_z96Z[Tka_Z69z]=GetTerrainType(GetOrderPointX(),GetOrderPointY())
if(IsUnitInGroup(Tka_z65,Tka_Z83z)==false)then
call GroupAddUnit(Tka_Z83z,Tka_z65)
endif
if(Tka_Z69z>=Tka_Z85z)then
set Tka_Z85z=Tka_Z85z+1
endif
exitwhen true
endif
set Tka_Z69z=Tka_Z69z+1
endloop
call DisplayTimedTextToPlayer(Tka_z05,0,0,Tka_Z1,Tka_z22Z+"获取地型成功! 地型ID为 |CFF00FF00"+Tka_Z05Z(Tka_z96Z[Tka_Z69z]))
call SetUnitMoveSpeed(Tka_z65,1.00)
set Tka_z03z[Tka_z15]=false
call TriggerSleepAction(0)
call IssueImmediateOrder(Tka_z65,"holdposition")
elseif(IsUnitInGroup(Tka_z65,Tka_Z83z))then
if(Tka_Z85z>0)then
set Tka_Z75=0
loop
if(Tka_z95Z[Tka_Z75]==Tka_z65)then
if(Tka_z96Z[Tka_Z75]!=1)then
call SetTerrainTypeBJ(Tka_z95,Tka_z96Z[Tka_Z75],-1,Tka_z93Z[Tka_z15],1)
endif
call Tka_Z81z(GetOrderPointX(),GetOrderPointY(),Tka_z36Z[Tka_Z75],Tka_z37Z[Tka_Z75],Tka_z93Z[Tka_z15])
exitwhen true
endif
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75>=Tka_Z85z
endloop
call TriggerSleepAction(0)
call IssueImmediateOrder(Tka_z65,"holdposition")
endif
endif
endif
endif
call RemoveLocation(Tka_z95)
set Tka_z65=null
set Tka_z05=null
set Tka_z95=null
endfunction
function Tka_Z90Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15))and(Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15]))or(Tka_z43Z[Tka_z15])then
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),Tka_z05)+1),Tka_z05)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set Tka_z05=null
endfunction
function Tka_Z91Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
local unit Tka_z65
local unit Tka_z76
local location Tka_z95
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15))and(Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15]))or(Tka_z43Z[Tka_z15])then
set Tka_z65=GetTriggerUnit()
set Tka_z95=GetUnitRallyPoint(Tka_z65)
call CreateNUnitsAtLoc(1,GetTrainedUnitType(),Tka_z05,Tka_z95,270.)
set Tka_z76=bj_lastCreatedUnit
if(Tka_Z6Z)then
call SetUnitUseFood(Tka_z76,false)
endif
call IssueImmediateOrderById(Tka_z65,851976)
if(IsUnitType(Tka_z76,ConvertUnitType(0)))then
if(bj_meleeTwinkedHeroes[Tka_z15]<bj_MELEE_MAX_TWINKED_HEROES)then
call UnitAddItemById(Tka_z76,1937012592)
set bj_meleeTwinkedHeroes[Tka_z15]=bj_meleeTwinkedHeroes[Tka_z15]+1
endif
endif
call RemoveLocation(Tka_z95)
endif
set Tka_z95=null
set Tka_z05=null
set Tka_z76=null
set Tka_z65=null
endfunction
function Tka_Z92Z takes nothing returns nothing
local unit Tka_z65=GetAttacker()
local unit Tka_z76=GetEnumUnit()
local player Tka_z05=GetOwningPlayer(Tka_z65)
local player Tka_Z65=GetOwningPlayer(Tka_z76)
if(IsUnitAlly(Tka_z65,Tka_z05)or(Tka_Z65==Tka_z05))then
else
call UnitDamageTargetBJ(Tka_z65,Tka_z76,(Tka_z3*Tka_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z65=null
set Tka_z76=null
endfunction
function Tka_Z93Z takes nothing returns nothing
local unit Tka_z65=GetAttacker()
local unit Tka_z76=GetTriggerUnit()
local player Tka_z05=GetOwningPlayer(Tka_z65)
local integer Tka_z15=GetPlayerId(Tka_z05)
local player Tka_Z65=GetOwningPlayer(Tka_z76)
local group Tka_z46
local location Tka_z95
if(Tka_Z53[Tka_z15])then
call UnitDamageTargetBJ(Tka_z65,Tka_z76,Tka_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(Tka_Z63[Tka_z15])then
set Tka_z95=GetUnitLoc(Tka_z76)
set Tka_z46=Tka_Z64(100,Tka_z95)
call ForGroup(Tka_z46,function Tka_Z92Z)
call DestroyGroup(Tka_z46)
call RemoveLocation(Tka_z95)
set Tka_z46=null
set Tka_z95=null
endif
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z65=null
set Tka_z76=null
endfunction
function Tka_Z94Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call IssueImmediateOrderById(Tka_z65,Tka_Z7z)
set Tka_z65=null
endfunction
function Tka_Z95Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_z66
local player Tka_z05
local unit Tka_z65
local group Tka_z46
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_z66=GetIssuedOrderId()
if(Tka_z1z)then
if((Tka_zZZ[Tka_z15])and(Tka_zzZ[Tka_z15])and(Tka_z31[Tka_z15]))then
set Tka_z1z=false
set Tka_z65=GetTriggerUnit()
if((Tka_Z52==false)or(IsUnitType(Tka_z65,ConvertUnitType(16))==false))then
call Tka_z67(Tka_z15,false)
set Tka_Z7z=Tka_z66
set Tka_z46=Tka_zz4(Tka_z05,GetUnitTypeId(Tka_z65))
call ForGroup(Tka_z46,function Tka_Z94Z)
call DestroyGroup(Tka_z46)
set Tka_z46=null
endif
call Tka_z67(Tka_z15,true)
set Tka_z1z=true
set Tka_z65=null
endif
endif
set Tka_z05=null
endfunction
function Tka_Z96Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call IssuePointOrderById(Tka_z65,Tka_Z7z,Tka_Z8z,Tka_Z9z)
set Tka_z65=null
endfunction
function Tka_Z97Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call GroupAddUnit(Tka_Z83,Tka_z65)
set Tka_Z93=Tka_Z93+1
if(Tka_Z93==12)then
call GroupPointOrderById(Tka_Z83,Tka_Z7z,Tka_Z8z,Tka_Z9z)
set Tka_Z93=0
call GroupClear(Tka_Z83)
endif
set Tka_z65=null
endfunction
function Tka_Z98Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_z66
local player Tka_z05
local unit Tka_z65
local group Tka_z46
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_z66=GetIssuedOrderId()
if(Tka_z1z)then
if((Tka_zZZ[Tka_z15])and(Tka_zzZ[Tka_z15])and(Tka_z31[Tka_z15]))then
set Tka_z1z=false
set Tka_z65=GetTriggerUnit()
if((Tka_Z52==false)or(IsUnitType(Tka_z65,ConvertUnitType(16))==false))then
call Tka_z67(Tka_z15,false)
set Tka_Z7z=Tka_z66
set Tka_Z8z=GetOrderPointX()
set Tka_Z9z=GetOrderPointY()
set Tka_z46=Tka_zz4(Tka_z05,GetUnitTypeId(Tka_z65))
if(Tka_Z33[Tka_z15])then
set Tka_Z93=0
call GroupClear(Tka_Z83)
call ForGroup(Tka_z46,function Tka_Z97Z)
if(Tka_Z93==12)then
else
call GroupPointOrderById(Tka_Z83,Tka_Z7z,Tka_Z8z,Tka_Z9z)
endif
else
call ForGroup(Tka_z46,function Tka_Z96Z)
endif
call DestroyGroup(Tka_z46)
set Tka_z46=null
endif
call Tka_z67(Tka_z15,true)
set Tka_z1z=true
set Tka_z65=null
endif
endif
set Tka_z05=null
endfunction
function Tka_Z99Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call IssueTargetOrderById(Tka_z65,Tka_Z7z,Tka_zZz)
set Tka_z65=null
endfunction
function Tka_zZZZ takes nothing returns nothing
local integer Tka_z15
local integer Tka_z66
local player Tka_z05
local unit Tka_z65
local group Tka_z46
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_z66=GetIssuedOrderId()
if(Tka_z1z)then
if((Tka_zZZ[Tka_z15])and(Tka_zzZ[Tka_z15])and(Tka_z31[Tka_z15]))then
set Tka_z1z=false
set Tka_z65=GetTriggerUnit()
if((Tka_Z52==false)or(IsUnitType(Tka_z65,ConvertUnitType(16))==false))then
call Tka_z67(Tka_z15,false)
set Tka_Z7z=Tka_z66
set Tka_zZz=GetOrderTargetUnit()
if(Tka_zZz==null)then
else
set Tka_z46=Tka_zz4(Tka_z05,GetUnitTypeId(Tka_z65))
call ForGroup(Tka_z46,function Tka_Z99Z)
call DestroyGroup(Tka_z46)
set Tka_z46=null
set Tka_z65=null
endif
endif
call Tka_z67(Tka_z15,true)
set Tka_z1z=true
set Tka_z65=null
endif
endif
set Tka_z05=null
endfunction
function Tka_zZzZ takes unit Tka_z65 returns nothing
local real Tka_Z14Z
call UnitRemoveBuffs(Tka_z65,false,true)
call UnitResetCooldown(Tka_z65)
set Tka_Z14Z=GetUnitLifePercent(Tka_z65)
if(Tka_Z14Z<Tka_z2Z[0])then
call SetUnitLifePercentBJ(Tka_z65,Tka_z2Z[0])
else
if(Tka_Z14Z<Tka_z2Z[1])then
call SetUnitLifePercentBJ(Tka_z65,Tka_z2Z[1])
else
if(Tka_Z14Z<Tka_z2Z[2])then
call SetUnitLifePercentBJ(Tka_z65,Tka_z2Z[2])
else
call SetUnitLifePercentBJ(Tka_z65,100.)
endif
endif
endif
set Tka_Z14Z=GetUnitManaPercent(Tka_z65)
if(Tka_Z14Z<Tka_z3Z[0])then
call SetUnitManaPercentBJ(Tka_z65,Tka_z3Z[0])
else
if(Tka_Z14Z<Tka_z3Z[1])then
call SetUnitManaPercentBJ(Tka_z65,Tka_z3Z[1])
else
if(Tka_Z14Z<Tka_z3Z[2])then
call SetUnitManaPercentBJ(Tka_z65,Tka_z3Z[2])
else
call SetUnitManaPercentBJ(Tka_z65,100.)
endif
endif
endif
endfunction
function Tka_zZ0Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_zZzZ(Tka_z65)
set Tka_z65=null
endfunction
function Tka_zZ1Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
if((Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15]))then
call Tka_ZZ1Z(Tka_z15,Tka_z05)
else
if(Tka_Z7[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
else
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_zZ0Z)
else
call Tka_zZzZ(Tka_z7[Tka_z15])
endif
endif
endif
endif
endif
set Tka_z05=null
endfunction
function Tka_zZ2Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z1Z[Tka_z15]=false
set Tka_z05=null
call Tka_z17(Tka_z15,false)
endfunction
function Tka_zZ3Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z2Z[Tka_z15]=false
set Tka_z05=null
call Tka_z17(Tka_z15,false)
endfunction
function Tka_zZ4Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_zZZ[Tka_z15]=false
call Tka_z67(Tka_z15,false)
set Tka_z05=null
endfunction
function Tka_zZ5Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_zzZ[Tka_z15]=false
call Tka_z67(Tka_z15,false)
set Tka_z05=null
endfunction
function Tka_z54Z takes boolean Tka_Z66z returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
call Tka_z11Z(Tka_z63Z[Tka_z15],true,Tka_Z66z)
set Tka_z05=null
endfunction
function Tka_zZ6Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z8[Tka_z15]=0
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
set Tka_Z1Z[Tka_z15]=true
if(Tka_Z2Z[Tka_z15])then
call Tka_z17(Tka_z15,true)
else
if(Tka_Z7[Tka_z15])then
if(Tka_Z32[Tka_z15]==3)then
set Tka_Z7[Tka_z15]=false
set Tka_Z1Z[Tka_z15]=false
set Tka_Z32[Tka_z15]=0
call Tka_ZZzZ(Tka_z15,Tka_z05)
else
set Tka_Z32[Tka_z15]=Tka_Z32[Tka_z15]+1
endif
else
call Tka_z88(Tka_z15)
endif
endif
endif
else
call Tka_Z73z(Tka_z15,3)
endif
set Tka_z05=null
endfunction
function Tka_zZ7Z takes unit Tka_z65 returns nothing
call SetUnitLifePercentBJ(Tka_z65,100)
call SetUnitManaPercentBJ(Tka_z65,100)
endfunction
function Tka_zZ8Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_zZ7Z(Tka_z65)
set Tka_z65=null
endfunction
function Tka_z58Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
call Tka_z54Z(true)
endif
endif
set Tka_z05=null
endfunction
function Tka_z61Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
set Tka_Z75=0
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z41z[1]=Tka_z22Z+"关闭↑↓键查询ID"
call Tka_Z49z(Tka_z05)
loop
set Tka_z62Z[Tka_z15+Tka_Z75]=0
set Tka_Z75=Tka_Z75+20
exitwhen Tka_Z75==80
endloop
set Tka_z63Z[Tka_z15]=0
call DisableTrigger(Tka_z56Z[Tka_z15])
call DisableTrigger(Tka_z57Z[Tka_z15])
call DisableTrigger(Tka_z60Z[Tka_z15])
call EnableTrigger(Tka_z10[Tka_z15])
call EnableTrigger(Tka_z00[Tka_z15])
call EnableTrigger(Tka_z20[Tka_z15])
call EnableTrigger(Tka_z30[Tka_z15])
endfunction
function Tka_z59Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
call Tka_z54Z(false)
endif
endif
set Tka_z05=null
endfunction
function Tka_zZ9Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
set Tka_Z2Z[Tka_z15]=true
if(Tka_Z1Z[Tka_z15])then
call Tka_z17(Tka_z15,true)
else
if(Tka_Z11z(Tka_z15))then
if(Tka_Z7[Tka_z15])then
call Tka_Zz3Z(Tka_z15,1,Tka_zz,true)
else
if((Tka_zZZ[Tka_z15])and(Tka_zzZ[Tka_z15]))then
call Tka_Zz9Z(Tka_z15,1,true)
else
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_zZ8Z)
else
call Tka_zZ7Z(Tka_z7[Tka_z15])
endif
endif
endif
endif
endif
else
call Tka_Z73z(Tka_z15,2)
endif
set Tka_z05=null
endfunction
function Tka_zzZZ takes unit Tka_z65 returns nothing
call UnitSetConstructionProgress(Tka_z65,100)
call UnitSetUpgradeProgress(Tka_z65,100)
call UnitRemoveBuffs(Tka_z65,false,true)
call UnitResetCooldown(Tka_z65)
endfunction
function Tka_zzzZ takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_zzZZ(Tka_z65)
set Tka_z65=null
endfunction
function Tka_zz0Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
set Tka_zZZ[Tka_z15]=true
if(Tka_zzZ[Tka_z15])then
call Tka_z67(Tka_z15,true)
else
if(Tka_Z7[Tka_z15])then
set Tka_Z7[Tka_z15]=false
call Tka_Zz3Z(Tka_z15,0,Tka_zz,true)
else
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_zzzZ)
else
call Tka_zzZZ(Tka_z7[Tka_z15])
endif
endif
endif
endif
else
call Tka_Z73z(Tka_z15,0)
endif
set Tka_z05=null
endfunction
function Tka_z45Z takes nothing returns nothing
local integer Tka_z15
set Tka_z15=GetPlayerId(GetTriggerPlayer())
if(Tka_z43Z[Tka_z15])then
call UnitSetUpgradeProgress(GetTriggerUnit(),100)
call TriggerSleepAction(0.01)
call UnitSetConstructionProgress(GetConstructingStructure(),100)
endif
endfunction
function Tka_zz1Z takes unit Tka_z65 returns nothing
call ModifyHeroStat(0,Tka_z65,0,Tka_zz)
call ModifyHeroStat(1,Tka_z65,0,Tka_zz)
call ModifyHeroStat(2,Tka_z65,0,Tka_zz)
endfunction
function Tka_zz2Z takes nothing returns nothing
local unit Tka_z65=GetEnumUnit()
call Tka_zz1Z(Tka_z65)
set Tka_z65=null
endfunction
function Tka_zz3Z takes nothing returns nothing
local integer Tka_z15
local player Tka_z05
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
set Tka_zzZ[Tka_z15]=true
if(Tka_zZZ[Tka_z15])then
call Tka_z67(Tka_z15,true)
else
if(Tka_Z7[Tka_z15])then
set Tka_Z7[Tka_z15]=false
call Tka_Zz3Z(Tka_z15,2,Tka_zz,true)
else
if((Tka_Z1Z[Tka_z15])and(Tka_Z2Z[Tka_z15]))then
if(Tka_Z0)then
call ForGroup(Tka_Z8Z[Tka_z15],function Tka_zz2Z)
else
call Tka_zz1Z(Tka_z7[Tka_z15])
endif
else
call Tka_zz5(Tka_z05,Tka_zZ,true)
call Tka_z35(Tka_z05,Tka_Zz,true)
endif
endif
endif
endif
else
call Tka_Z73z(Tka_z15,1)
endif
set Tka_z05=null
endfunction
function Tka_zz4Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z59Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
call Tka_Z5ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z52Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
set Tka_z13=false
set Tka_Z41z[1]=Tka_z22Z+"所有人也将无法储存重播纪录"
call Tka_Z49z(Tka_z05)
call DoNotSaveReplay()
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_zz5Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_ZZzZ(Tka_z15,Tka_z05)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Zz1Z(Tka_z05)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(5),5)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call SetPlayerStateBJ(Tka_z05,ConvertPlayerState(4),100)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
if(GetPlayerHandicapBJ(Tka_z05)==200.)then
call SetPlayerHandicapBJ(Tka_z05,100)
else
call SetPlayerHandicapBJ(Tka_z05,200.)
endif
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
if(GetPlayerHandicapXPBJ(Tka_z05)==200.)then
call SetPlayerHandicapXPBJ(Tka_z05,100)
else
call SetPlayerHandicapXPBJ(Tka_z05,200.)
endif
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_zz5(Tka_z05,Tka_Z2,true)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_z35(Tka_z05,Tka_z2,true)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call Tka_zz5(Tka_z05,Tka_Z2,false)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_z35(Tka_z05,Tka_z2,false)
call Tka_Z55Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_zz6Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z96(Tka_z40[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z96(Tka_z50[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_Z96(Tka_z60[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z96(Tka_z80[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z96(Tka_z70[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
call Tka_Z96(Tka_z90[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z96(Tka_ZZ3[Tka_z15])
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_z16(Tka_z15,true)
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call Tka_z16(Tka_z15,false)
call Tka_Z46Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_zz7Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z24Z(Tka_z15,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1097886070,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_Z26Z(Tka_z15,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1094937907,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1098150517,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
call Tka_Z29Z(Tka_z15,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if((Tka_z78==Tka_Zz0[Tka_z15])and((Tka_z9Z)or(Tka_Z13z(Tka_z05))))then
call Tka_Z3ZZ(Tka_z15,true)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z34Z(Tka_z15)
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_zz8Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095659625,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095066998,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095262824,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095721842,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1096119411,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095656289,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095657827,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095332722,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call Tka_Z21Z(Tka_z15,1094935923,true)
call Tka_Z48Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_zz9Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095262562,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095065960,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095721317,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095065970,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1096114549,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1096114550,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1095262564,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_Z21Z(Tka_z15,1094934883,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call Tka_Z21Z(Tka_z15,1097818482,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z21Z(Tka_z15,1096905580,true)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z31Z(Tka_z15,false)
call Tka_Z49Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z0ZZ takes nothing returns nothing
local integer Tka_Z75=0
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z13z(Tka_z05))and(Tka_Z11z(Tka_z15)))then
loop
exitwhen Tka_Z75>11
if(Tka_z78==Tka_ZzZ[Tka_Z75])then
if(Tka_Z11z(Tka_Z75))then
call Tka_z47(Tka_Z75)
set Tka_Z41z[1]=Tka_z22Z+"你已被收回作弊权限"
call Tka_Z49z(Player(Tka_Z75))
else
call Tka_z57(Tka_Z75,Player(Tka_Z75))
set Tka_Z41z[1]=Tka_z22Z+"你已获得作弊权限 用-tka获得查询"
call Tka_Z49z(Player(Tka_Z75))
endif
call Tka_Z5ZZ(Tka_z15,Tka_z05)
endif
set Tka_Z75=Tka_Z75+1
endloop
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z0zZ takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local integer Tka_Z75=0
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z13z(Tka_z05))and(Tka_Z11z(Tka_z15)))then
loop
exitwhen Tka_Z75>12
if(Tka_z78==Tka_ZzZ[Tka_Z75])then
set Tka_Z5z=Tka_Z75
call Tka_Z53Z(Tka_z15,Tka_z05)
endif
set Tka_Z75=Tka_Z75+1
endloop
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z00Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local player Tka_Z65
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z13z(Tka_z05))and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z57Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
set Tka_Z65=Player(Tka_Z5z)
if(GetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(1))==0)then
call SetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(1),Tka_z22)
else
call SetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(1),0)
endif
set Tka_Z65=null
call Tka_Z53Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
set Tka_Z65=Player(Tka_Z5z)
if(GetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(2))==0)then
call SetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(2),Tka_z22)
else
call SetPlayerTaxRate(Tka_Z65,Tka_z05,ConvertPlayerState(2),0)
endif
set Tka_Z65=null
call Tka_Z53Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z52Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z01Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local integer Tka_Z75=Tka_Z5z
local player Tka_Z65=Player(Tka_Z75)
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_ZZzZ(Tka_Z75,Tka_Z65)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Zz1Z(Tka_Z65)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call SetPlayerStateBJ(Tka_Z65,ConvertPlayerState(5),5)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call SetPlayerStateBJ(Tka_Z65,ConvertPlayerState(4),100)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
if(GetPlayerHandicapBJ(Tka_Z65)==200.)then
call SetPlayerHandicapBJ(Tka_Z65,100)
else
call SetPlayerHandicapBJ(Tka_Z65,200.)
endif
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
if(GetPlayerHandicapXPBJ(Tka_Z65)==200.)then
call SetPlayerHandicapXPBJ(Tka_Z65,100)
else
call SetPlayerHandicapXPBJ(Tka_Z65,200.)
endif
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_zz5(Tka_Z65,Tka_Z2,true)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
call Tka_z35(Tka_Z65,Tka_z2,true)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call Tka_zz5(Tka_Z65,Tka_Z2,false)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_z35(Tka_Z65,Tka_z2,false)
call Tka_Z56Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z53Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z78=null
endfunction
function Tka_z02Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local integer Tka_Z75=Tka_Z5z
local player Tka_Z65=Player(Tka_Z75)
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if(Tka_z78==Tka_z2z[Tka_z15])then
if(IsPlayerAlly(Tka_Z65,Tka_z05))then
call SetPlayerAllianceStateBJ(Tka_Z65,Tka_z05,0)
else
call SetPlayerAllianceStateBJ(Tka_Z65,Tka_z05,3)
endif
call Tka_Z57Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
if(GetPlayerAlliance(Tka_Z65,Tka_z05,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,false,Tka_z5)
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_CONTROL,false,Tka_z5)
else
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_ADVANCED_CONTROL,true,Tka_z5)
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_CONTROL,true,Tka_z5)
endif
call Tka_Z57Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
if(GetPlayerAlliance(Tka_Z65,Tka_z05,ALLIANCE_SHARED_XP))then
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_XP,false,Tka_z5)
else
call SetPlayerAllianceBJ(Tka_Z65,ALLIANCE_SHARED_XP,true,Tka_z5)
endif
call Tka_Z57Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
if(IsPlayerAlly(Tka_z05,Tka_Z65))then
call SetPlayerAllianceStateBJ(Tka_z5,Tka_Z65,0)
else
call SetPlayerAllianceStateBJ(Tka_z5,Tka_Z65,2)
endif
call Tka_Z57Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z53Z(Tka_z15,Tka_z05)
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z78=null
endfunction
function Tka_z03Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local integer Tka_Z75
local unit Tka_z65=Tka_z7[Tka_z15]
local player Tka_Z65=GetOwningPlayer(Tka_z65)
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if(Tka_Z15z())and(Tka_Z11z(Tka_z15))then
if(Tka_z78==Tka_z2z[Tka_z15])then
call SetHeroLevelBJ(Tka_z65,GetHeroLevel(Tka_z65)+Tka_Z0Z,false)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call ModifyHeroStat(1,Tka_z65,0,Tka_Z3)
call ModifyHeroStat(0,Tka_z65,0,Tka_Z3)
call ModifyHeroStat(2,Tka_z65,0,Tka_Z3)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
call Tka_z98(Tka_z15,false)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z77(Tka_z65,Tka_z05,1)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_ZZ3Z(Tka_z65)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
if(Tka_Z5Z)then
if(Tka_Z65!=Tka_z5)then
call UnitShareVisionBJ(true,Tka_z65,Tka_z05)
endif
else
call UnitShareVisionBJ(true,Tka_z65,Tka_z05)
endif
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
call Tka_Z47Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
if(Tka_Z5Z)then
if(Tka_Z65!=Tka_z5)then
call SetUnitOwner(Tka_z65,Tka_z05,true)
endif
else
call SetUnitOwner(Tka_z65,Tka_z05,true)
endif
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
call RemoveUnit(Tka_z65)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z54Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z65=null
set Tka_z78=null
endfunction
function Tka_z04Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z13z(Tka_z05))and(Tka_Z11z(Tka_z15)))then
if(Tka_z78==Tka_z2z[Tka_z15])then
set Tka_Z0=not(Tka_Z0)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z58Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
set Tka_Z5Z=not(Tka_Z5Z)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
set Tka_Z6Z=not(Tka_Z6Z)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
set Tka_Z7Z=not(Tka_Z7Z)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
set Tka_z9Z=not(Tka_z9Z)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z7z[Tka_z15])then
set Tka_ZZz=not(Tka_ZZz)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z6z[Tka_z15])then
set Tka_z7Z=not(Tka_z7Z)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Zz0[Tka_z15])then
set Tka_Z52=not(Tka_Z52)
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_ZZ0[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z05Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if(Tka_z78==Tka_z2z[Tka_z15])then
set Tka_z61=1
call Tka_Z58Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
set Tka_z61=2
call Tka_Z58Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
set Tka_z61=3
call Tka_Z58Z(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z51Z(Tka_z15,Tka_z05)
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_Z74z takes integer Tka_z15 returns nothing
set Tka_Z6zZ[$14]=SubStringBJ(Tka_Z00Z,$0B,$0B)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z01Z,$3,$3)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z01Z,$0A,$0A)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z01Z,$2,$2)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$0C,$0C)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,' ',' ')
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$1,$1)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$1,$1)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$0A,$0A)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$1,$1)
set Tka_Z6zZ[$14]=Tka_Z6zZ[$14]+SubStringBJ(Tka_Z00Z,$1,$1)
call Tka_Z61Z(Tka_z15)
endfunction
function Tka_z06Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
local integer Tka_Z75=0
local player Tka_Z65
local unit Tka_z65=Tka_z7[Tka_z15]
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if((Tka_Z15z())and(Tka_Z13z(Tka_z05))and(Tka_Z11z(Tka_z15)))then
loop
exitwhen Tka_Z75>12
if(Tka_z78==Tka_ZzZ[Tka_Z75])then
set Tka_Z65=Player(Tka_Z75)
call SetUnitOwner(Tka_z7[Tka_z15],Tka_Z65,true)
endif
set Tka_Z75=Tka_Z75+1
endloop
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z50Z(Tka_z15,Tka_z05)
endif
endif
set Tka_z05=null
set Tka_Z65=null
set Tka_z78=null
set Tka_z65=null
endfunction
function Tka_Z7ZZ takes nothing returns nothing
local string Tka_Z63Z
local player Tka_z05
local integer Tka_z15
local integer Tka_Z55z
set Tka_z05=GetTriggerPlayer()
set Tka_z15=GetPlayerId(Tka_z05)
set Tka_Z63Z=GetEventPlayerChatString()
set Tka_Z63Z=StringCase(Tka_Z63Z,false)
if(Tka_Z15z())then
if(Tka_Z11z(Tka_z15))then
if(SubStringBJ(Tka_Z63Z,1,4)=="-tka")then
set Tka_Z55z=S2I(SubStringBJ(Tka_Z63Z,6,6))
set Tka_Z63Z=SubStringBJ(Tka_Z63Z,6,6)
call ClearTextMessagesBJ(bj_FORCE_PLAYER[Tka_z15])
call Tka_Z56z(Tka_Z55z)
call Tka_Z49z(Tka_z05)
endif
if(SubStringBJ(Tka_Z63Z,2,2)=="t")then
if(SubStringBJ(Tka_Z63Z,3,5)=="cmd")then
call DestroyTrigger(Tka_zz1[Tka_z15])
set Tka_zz1[Tka_z15]=CreateTrigger()
call EnableTrigger(Tka_zz1[Tka_z15])
call TriggerRegisterPlayerChatEvent(Tka_zz1[Tka_z15],Tka_z05,"",false)
call TriggerAddAction(Tka_zz1[Tka_z15],function Tka_Z79Z)
set Tka_Z41z[1]=Tka_z22Z+"重设CMD完成!"
call Tka_Z49z(Tka_z05)
endif
endif
endif
endif
set Tka_z05=null
endfunction
function Tka_z07Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_z36(Tka_z05)
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
set Tka_z31[Tka_z15]=not(Tka_z31[Tka_z15])
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z5z[Tka_z15])then
set Tka_Z33[Tka_z15]=not(Tka_Z33[Tka_z15])
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z38(Tka_z15,not(Tka_Z53[Tka_z15]))
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
set Tka_Z63[Tka_z15]=not(Tka_Z63[Tka_z15])
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_z8z[Tka_z15])then
set Tka_Z43[Tka_z15]=not(Tka_Z43[Tka_z15])
call Tka_Z6ZZ(Tka_z15,Tka_z05)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z31Z takes nothing returns nothing
if(Tka_z4)then
else
call Tka_z32Z(GetPlayerId(GetTriggerPlayer()))
endif
endfunction
function Tka_z08Z takes nothing returns nothing
local player Tka_z05=GetTriggerPlayer()
local integer Tka_z15=GetPlayerId(Tka_z05)
local button Tka_z78=GetClickedButton()
call Tka_Z44Z(Tka_z15,Tka_z05,false)
if(Tka_z78==Tka_z2z[Tka_z15])then
call Tka_Z60Z(Tka_z05,10)
call Tka_Z49z(Tka_z05)
endif
if(Tka_z78==Tka_z4z[Tka_z15])then
call Tka_Z60Z(Tka_z05,1)
call Tka_Z49z(Tka_z05)
endif
if(Tka_z78==Tka_z3z[Tka_z15])then
call Tka_Z62Z(Tka_z05)
endif
if(Tka_z78==Tka_Z39z[Tka_z15])then
call Tka_Z56z(0)
call Tka_Z49z(Tka_z05)
endif
if(Tka_z78==Tka_z9z[Tka_z15])then
call Tka_Z64Z()
call Tka_Z49z(Tka_z5)
endif
if(Tka_z78==Tka_Z00[Tka_z15])then
call Tka_Z45Z(Tka_z15,Tka_z05)
endif
set Tka_z05=null
set Tka_z78=null
endfunction
function Tka_z74Z takes nothing returns nothing
local integer Tka_z15=0
loop
if(Tka_Z11z(Tka_z15))then
call DisplayTimedTextToPlayer(Player(Tka_z15),0,0,Tka_Z1,"|cff808080"+GetPlayerName(GetTriggerPlayer())+Tka_z22Z+" 已经离开游戏")
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==12
endloop
endfunction
function Tka_z81Z takes player Tka_z05 returns string
local integer Tka_z15=GetPlayerState(Tka_z05,ConvertPlayerState(5))
local integer Tka_Z75=GetPlayerState(Tka_z05,ConvertPlayerState(4))
if(Tka_z15<=Tka_Z75)then
return "|cff00c600"+I2S(Tka_z15)+"/"+I2S(Tka_Z75)
else
return "|cffff0000"+I2S(Tka_z15)+"/"+I2S(Tka_Z75)
endif
endfunction
function Tka_z82Z takes nothing returns nothing
local integer Tka_z15=0
local integer Tka_Z75=2
local player Tka_z05
loop
set Tka_z05=Player(Tka_z15)
if(IsPlayerInForce(Tka_z05,Tka_Z58z)==true)then
if(GetPlayerSlotState(Tka_z05)==ConvertPlayerSlotState(2))and(Tka_z80Z[Tka_z15])then
call MultiboardSetItemValueBJ(Tka_z78Z,1,Tka_Z75,"|cff808080"+GetPlayerName(Tka_z05)+"(离开)")
set Tka_z80Z[Tka_z15]=false
else
call MultiboardSetItemValueBJ(Tka_z78Z,1,Tka_Z75,Tka_z84Z[Tka_z15]+GetPlayerName(Tka_z05))
endif
call MultiboardSetItemValueBJ(Tka_z78Z,2,Tka_Z75,"|cff8080ff"+I2S(Tka_z15+1))
call MultiboardSetItemValueBJ(Tka_z78Z,3,Tka_Z75,"|cfff7f700"+I2S(GetPlayerState(Tka_z05,ConvertPlayerState(1))))
call MultiboardSetItemValueBJ(Tka_z78Z,4,Tka_Z75,"|cff009700"+I2S(GetPlayerState(Tka_z05,ConvertPlayerState(2))))
call MultiboardSetItemValueBJ(Tka_z78Z,5,Tka_Z75,Tka_z81Z(Tka_z05))
set Tka_Z75=Tka_Z75+1
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==13
endloop
set Tka_z05=null
endfunction
function Tka_z83Z takes nothing returns nothing
local integer Tka_z15
local integer Tka_Z75
local player Tka_z05
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
set Tka_z78Z=CreateMultiboardBJ(5,2,"资源清单")
call MultiboardSetItemsStyle(Tka_z78Z,true,false)
call MultiboardSetItemStyle(MultiboardGetItem(Tka_z78Z,3,1),true,true)
call MultiboardSetItemStyle(MultiboardGetItem(Tka_z78Z,4,1),true,true)
call MultiboardSetItemStyle(MultiboardGetItem(Tka_z78Z,5,1),true,true)
call MultiboardSetItemValueBJ(Tka_z78Z,1,1,"|cffff8000名称")
call MultiboardSetItemValueBJ(Tka_z78Z,2,1,"|cff8080ff编号")
call MultiboardSetItemValueBJ(Tka_z78Z,3,1,"|cfff7f700金钱")
call MultiboardSetItemValueBJ(Tka_z78Z,4,1,"|cff009700木材")
call MultiboardSetItemValueBJ(Tka_z78Z,5,1,"|cffff8000食物")
call MultiboardSetItemIcon(MultiboardGetItem(Tka_z78Z,3,1),"UI\\Feedback\\Resources\\ResourceGold.blp")
call MultiboardSetItemIcon(MultiboardGetItem(Tka_z78Z,4,1),"UI\\Feedback\\Resources\\ResourceLumber.blp")
call MultiboardSetItemIcon(MultiboardGetItem(Tka_z78Z,5,1),"UI\\Feedback\\Resources\\ResourceSupply.blp")
call MultiboardDisplay(Tka_z78Z,false)
set Tka_Z58z=CreateForce()
set Tka_z15=0
set Tka_Z75=2
loop
set Tka_z05=Player(Tka_z15)
if(GetPlayerSlotState(Tka_z05)==ConvertPlayerSlotState(1))or(GetPlayerController(Tka_z05)==ConvertMapControl(1))then
call MultiboardSetRowCount(Tka_z78Z,Tka_Z75)
call MultiboardSetItemValueBJ(Tka_z78Z,1,Tka_Z75,Tka_z84Z[Tka_z15]+GetPlayerName(Tka_z05))
call MultiboardSetItemValueBJ(Tka_z78Z,2,Tka_Z75,"|cff8080ff"+I2S(Tka_z15+1))
call MultiboardSetItemValueBJ(Tka_z78Z,3,Tka_Z75,"|cfff7f700"+I2S(GetPlayerState(Tka_z05,ConvertPlayerState(1))))
call MultiboardSetItemValueBJ(Tka_z78Z,4,Tka_Z75,"|cff009700"+I2S(GetPlayerState(Tka_z05,ConvertPlayerState(2))))
call MultiboardSetItemValueBJ(Tka_z78Z,5,Tka_Z75,I2S(GetPlayerState(Tka_z05, ConvertPlayerState(5)))+"/"+I2S(GetPlayerState(Tka_z05,ConvertPlayerState(4))))
call MultiboardSetItemWidthBJ(Tka_z78Z,1,0,10)
call MultiboardSetItemWidthBJ(Tka_z78Z,2,0,3)
call ForceAddPlayer(Tka_Z58z,Tka_z05)
set Tka_Z75=Tka_Z75+1
endif
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==13
endloop
call TimerStart(CreateTimer(),0.5,true,function Tka_z82Z)
endfunction
function Tka_z092 takes nothing returns nothing
local integer Tka_Z75=0
loop
set Tka_Z37z[Tka_Z75]=false
set Tka_z43Z[Tka_Z75]=false
set Tka_Z38z[Tka_Z75]=0
set Tka_Z42z[Tka_Z75]=0
set Tka_Z72z[Tka_Z75]=1
set Tka_Z93z[Tka_Z75]=true
set Tka_z35Z[Tka_Z75]=false
set Tka_z63Z[Tka_Z75]=0
set Tka_z62Z[Tka_Z75]=0
set Tka_z93Z[Tka_Z75]=1
set Tka_z62Z[Tka_Z75+20]=0
set Tka_z62Z[Tka_Z75+40]=0
set Tka_z62Z[Tka_Z75+60]=0
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==16
endloop
endfunction
function Tka_z09Z takes nothing returns nothing
local integer Tka_Z75
local integer Tka_z15=0
local player Tka_Z65
local player Tka_z05
local trigger array Tka_Z66
set Tka_z8=GetWorldBounds()
set Tka_Z66[0]=CreateTrigger()
set Tka_Z66[1]=CreateTrigger()
loop
call Tka_Z95(Tka_Z66[0],Player(Tka_z15),20)
call Tka_Z95(Tka_Z66[1],Player(Tka_z15),18)
set Tka_z15=Tka_z15+1
exitwhen Tka_z15==16
endloop
call TriggerAddAction(Tka_Z66[0],function Tka_Z7zZ)
call TriggerAddAction(Tka_Z66[1],function Tka_Z9ZZ)
set Tka_Z66[2]=CreateTrigger()
call TriggerRegisterEnterRectSimple(Tka_Z66[2],Tka_z8)
call TriggerAddAction(Tka_Z66[2],function Tka_z99Z)
set Tka_Z66[0]=null
set Tka_Z66[1]=null
set Tka_Z66[2]=null
set Tka_Z75=0
set Tka_z34Z=SubStringBJ(Tka_Z0z,21,24)
loop
exitwhen Tka_Z75>15
set Tka_zz1[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_zz1[Tka_Z75],function Tka_Z79Z)
set Tka_zz9[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_zz9[Tka_Z75],function Tka_Z7ZZ)
call DisableTrigger(Tka_zz9[Tka_Z75])
set Tka_Z30[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z30[Tka_Z75],function Tka_Z88Z)
call DisableTrigger(Tka_Z30[Tka_Z75])
set Tka_Z50[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z50[Tka_Z75],function Tka_Z89Z)
call DisableTrigger(Tka_Z50[Tka_Z75])
set Tka_Z40[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z40[Tka_Z75],function Tka_Z91Z)
call DisableTrigger(Tka_Z40[Tka_Z75])
set Tka_Z60[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z60[Tka_Z75],function Tka_Z90Z)
call DisableTrigger(Tka_Z60[Tka_Z75])
set Tka_Z6z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z6z[Tka_Z75],function Tka_Z9zZ)
call DisableTrigger(Tka_Z6z[Tka_Z75])
set Tka_Z86z[Tka_Z75]=false
set Tka_Z70[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z70[Tka_Z75],function Tka_zZ1Z)
call DisableTrigger(Tka_Z70[Tka_Z75])
set Tka_z73Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z73Z[Tka_Z75],function Tka_z74Z)
set Tka_Z80[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z80[Tka_Z75],function Tka_zZ2Z)
call DisableTrigger(Tka_Z80[Tka_Z75])
set Tka_Z90[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z90[Tka_Z75],function Tka_zZ3Z)
call DisableTrigger(Tka_Z90[Tka_Z75])
set Tka_zZ0[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_zZ0[Tka_Z75],function Tka_zZ4Z)
call DisableTrigger(Tka_zZ0[Tka_Z75])
set Tka_zz0[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_zz0[Tka_Z75],function Tka_zZ5Z)
call DisableTrigger(Tka_zz0[Tka_Z75])
set Tka_z00[Tka_Z75]=CreateTrigger()
set Tka_Z6zZ[Tka_Z75]=GetPlayerName(Player(Tka_Z75))
call TriggerAddAction(Tka_z00[Tka_Z75],function Tka_zZ6Z)
set Tka_z10[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z10[Tka_Z75],function Tka_zZ9Z)
set Tka_z30Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z30Z[Tka_Z75],function Tka_z31Z)
set Tka_z20[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z20[Tka_Z75],function Tka_zz0Z)
set Tka_z30[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z30[Tka_Z75],function Tka_zz3Z)
set Tka_z40[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z40[Tka_Z75],function Tka_Z81Z)
call DisableTrigger(Tka_z40[Tka_Z75])
set Tka_z50[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z50[Tka_Z75],function Tka_Z82Z)
call DisableTrigger(Tka_z50[Tka_Z75])
set Tka_z60Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z60Z[Tka_Z75],function Tka_z61Z)
call DisableTrigger(Tka_z60Z[Tka_Z75])
set Tka_z56Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z56Z[Tka_Z75],function Tka_z58Z)
call DisableTrigger(Tka_z56Z[Tka_Z75])
set Tka_z57Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z57Z[Tka_Z75],function Tka_z59Z)
call DisableTrigger(Tka_z57Z[Tka_Z75])
set Tka_z60[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z60[Tka_Z75],function Tka_Z83Z)
call DisableTrigger(Tka_z60[Tka_Z75])
set Tka_z70[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z70[Tka_Z75],function Tka_Z84Z)
call DisableTrigger(Tka_z70[Tka_Z75])
set Tka_z80[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z80[Tka_Z75],function Tka_Z85Z)
call DisableTrigger(Tka_z80[Tka_Z75])
set Tka_z90[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z90[Tka_Z75],function Tka_Z86Z)
call DisableTrigger(Tka_z90[Tka_Z75])
set Tka_ZZ3[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_ZZ3[Tka_Z75],function Tka_Z87Z)
call DisableTrigger(Tka_ZZ3[Tka_Z75])
set Tka_z44Z[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z44Z[Tka_Z75],function Tka_z45Z)
set Tka_ZZ1[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_ZZ1[Tka_Z75],function Tka_zz4Z)
set Tka_Zz2[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Zz2[Tka_Z75],function Tka_zz5Z)
set Tka_Zz1[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Zz1[Tka_Z75],function Tka_zz6Z)
set Tka_Z01[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z01[Tka_Z75],function Tka_zz7Z)
set Tka_Z81[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z81[Tka_Z75],function Tka_zz8Z)
set Tka_Z21[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z21[Tka_Z75],function Tka_zz9Z)
set Tka_Z51[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z51[Tka_Z75],function Tka_z0ZZ)
set Tka_Z41[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z41[Tka_Z75],function Tka_z0zZ)
set Tka_Z61[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z61[Tka_Z75],function Tka_z00Z)
set Tka_Z12[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z12[Tka_Z75],function Tka_z02Z)
set Tka_Z02[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z02[Tka_Z75],function Tka_z01Z)
set Tka_Z71[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z71[Tka_Z75],function Tka_z03Z)
set Tka_Z31[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z31[Tka_Z75],function Tka_z04Z)
set Tka_Z22[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z22[Tka_Z75],function Tka_z05Z)
set Tka_Z11[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z11[Tka_Z75],function Tka_z06Z)
set Tka_Z23[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z23[Tka_Z75],function Tka_z08Z)
set Tka_Z13[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_Z13[Tka_Z75],function Tka_z07Z)
call DisableTrigger(Tka_ZZ1[Tka_Z75])
call DisableTrigger(Tka_Zz1[Tka_Z75])
call DisableTrigger(Tka_Zz2[Tka_Z75])
call DisableTrigger(Tka_Z01[Tka_Z75])
call DisableTrigger(Tka_Z81[Tka_Z75])
call DisableTrigger(Tka_Z21[Tka_Z75])
call DisableTrigger(Tka_Z51[Tka_Z75])
call DisableTrigger(Tka_Z41[Tka_Z75])
call DisableTrigger(Tka_Z61[Tka_Z75])
call DisableTrigger(Tka_Z12[Tka_Z75])
call DisableTrigger(Tka_Z02[Tka_Z75])
call DisableTrigger(Tka_Z71[Tka_Z75])
call DisableTrigger(Tka_Z31[Tka_Z75])
call DisableTrigger(Tka_Z22[Tka_Z75])
call DisableTrigger(Tka_Z11[Tka_Z75])
call DisableTrigger(Tka_Z23[Tka_Z75])
call DisableTrigger(Tka_Z13[Tka_Z75])
set Tka_z01[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z01[Tka_Z75],function Tka_Z95Z)
set Tka_z11[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z11[Tka_Z75],function Tka_Z98Z)
set Tka_z21[Tka_Z75]=CreateTrigger()
call TriggerAddAction(Tka_z21[Tka_Z75],function Tka_zZZZ)
set Tka_Z65=Player(Tka_Z75)
call Tka_Z95(Tka_Z40[Tka_Z75],Tka_Z65,32)
call Tka_Z95(Tka_Z60[Tka_Z75],Tka_Z65,35)
call Tka_Z95(Tka_z44Z[Tka_Z75],Tka_Z65,26)
call Tka_Z95(Tka_z44Z[Tka_Z75],Tka_Z65,29)
call Tka_Z95(Tka_z80[Tka_Z75],Tka_Z65,276)
call Tka_Z95(Tka_z80[Tka_Z75],Tka_Z65,275)
call Tka_Z95(Tka_z90[Tka_Z75],Tka_Z65,276)
call Tka_Z95(Tka_z90[Tka_Z75],Tka_Z65,275)
call Tka_Z95(Tka_z70[Tka_Z75],Tka_Z65,20)
call Tka_Z95(Tka_Z6z[Tka_Z75],Tka_Z65,39)
call TriggerRegisterPlayerStateEvent(Tka_z60[Tka_Z75],Tka_Z65,ConvertPlayerState(5),ConvertLimitOp(3),0)
call TriggerRegisterPlayerStateEvent(Tka_z40[Tka_Z75],Tka_Z65,ConvertPlayerState(1),ConvertLimitOp(3),0)
call TriggerRegisterPlayerStateEvent(Tka_z50[Tka_Z75],Tka_Z65,ConvertPlayerState(2),ConvertLimitOp(3),0)
call DisableTrigger(Tka_z01[Tka_Z75])
call DisableTrigger(Tka_z11[Tka_Z75])
call DisableTrigger(Tka_z21[Tka_Z75])
if((GetPlayerController(Tka_Z65)==ConvertMapControl(0))and(GetPlayerSlotState(Tka_Z65)==ConvertPlayerSlotState(1)))then
set Tka_Z8Z[Tka_Z75]=CreateGroup()
call TriggerRegisterPlayerStateEvent(Tka_z63,Tka_Z65,ConvertPlayerState(5),ConvertLimitOp(0),0)
call TriggerRegisterPlayerChatEvent(Tka_z30Z[Tka_Z75],Tka_Z65,"",false)
call TriggerRegisterPlayerChatEvent(Tka_zz1[Tka_Z75],Tka_Z65,"",false)
call TriggerRegisterPlayerKeyEventBJ(Tka_z10[Tka_Z75],Tka_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(Tka_z00[Tka_Z75],Tka_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(Tka_z20[Tka_Z75],Tka_Z65,0,0)
call TriggerRegisterPlayerKeyEventBJ(Tka_z30[Tka_Z75],Tka_Z65,0,1)
call TriggerRegisterPlayerKeyEventBJ(Tka_z56Z[Tka_Z75],Tka_Z65,0,2)
call TriggerRegisterPlayerKeyEventBJ(Tka_z57Z[Tka_Z75],Tka_Z65,0,3)
call TriggerRegisterPlayerKeyEventBJ(Tka_z60Z[Tka_Z75],Tka_Z65,0,1)
call TriggerRegisterPlayerStateEvent(Tka_z63,Tka_Z65,ConvertPlayerState(5),ConvertLimitOp(0),0)
set Tka_Z9Z[Tka_Z75]=GetPlayerStartLocationLoc(Tka_Z65)
endif
set Tka_Z75=Tka_Z75+1
endloop
set Tka_z8Z=CreateGroup()
set Tka_z97Z[0]="任意"
set Tka_z97Z[1]="地面可通行"
set Tka_z97Z[2]="空中可通行"
set Tka_z97Z[3]="可建造路块"
set Tka_z97Z[4]="工人采集路块"
set Tka_z97Z[5]="无腐土路块"
set Tka_z97Z[6]="水上可通行"
set Tka_z97Z[7]="水陆可通行"
set Tka_Z82z[1]="不改变(只改变附加样式时使用)"
set Tka_Z82z[2]="土地"
set Tka_Z82z[3]="粗糙土地"
set Tka_Z82z[4]="长草土地"
set Tka_Z82z[5]="岩石"
set Tka_Z82z[6]="草地"
set Tka_Z82z[7]="深色草地"
set Tka_Z82z[8]="雪地"
set Tka_Z82z[9]="沙漠"
set Tka_Z82z[10]="深色沙漠"
set Tka_Z82z[11]="碎石地"
set Tka_Z82z[12]="厚密草地"
set Tka_Z82z[13]="藤蔓"
set Tka_Z82z[14]="覆叶"
set Tka_Z82z[15]="毒地"
set Tka_Z82z[16]="冰地"
set Tka_Z82z[17]="黑色大理石"
set Tka_Z82z[18]="砖块"
set Tka_Z82z[19]="方形地砖"
set Tka_Z82z[20]="圆形地砖"
set Tka_Z82z[21]="人工草地"
set Tka_Z82z[22]="白色大理石"
set Tka_Z82z[23]="卵石小径"
set Tka_Z82z[24]="石质小径"
set Tka_Z82z[25]="短草地"
set Tka_Z82z[26]="农作物"
set Tka_Z82z[27]="砌叠地砖"
set Tka_Z82z[28]="红色岩石"
set Tka_Z82z[29]="碎裂熔岩"
set Tka_Z82z[30]="熔岩"
set Tka_Z82z[31]="深色岩石"
set Tka_Z82z[32]="灰色岩石"
set Tka_Z82z[33]="深色冰地"
set Tka_Z82z[34]="平石"
set Tka_Z82z[35]="深渊"
set Tka_Z82z[36]="土质峭壁"
set Tka_Z82z[37]="青草峭壁"
set Tka_Z82z[38]="沙漠峭壁"
set Tka_Z82z[39]="深色峭壁"
set Tka_Z82z[40]="砌砖壁墙"
set Tka_Z82z[41]="冰雪峭壁"
set Tka_Z82z[42]="粗糙土质峭壁"
set Tka_Z21z[1]=1
set Tka_Z21z[2]='Ldrt'
set Tka_Z21z[3]='Ldro'
set Tka_Z21z[4]='Ldrg'
set Tka_Z21z[5]='Lrok'
set Tka_Z21z[6]='Lgrs'
set Tka_Z21z[7]='Lgrd'
set Tka_Z21z[8]='Wsnw'
set Tka_Z21z[9]='Bdsr'
set Tka_Z21z[10]='Bdsd'
set Tka_Z21z[11]='Bdrr'
set Tka_Z21z[12]='Agrd'
set Tka_Z21z[13]='Avin'
set Tka_Z21z[14]='Alvd'
set Tka_Z21z[15]='Cpos'
set Tka_Z21z[16]='Nice'
set Tka_Z21z[17]='Yblm'
set Tka_Z21z[18]='Ybtl'
set Tka_Z21z[19]='Ysqd'
set Tka_Z21z[20]='Yrtl'
set Tka_Z21z[21]='Yhdg'
set Tka_Z21z[22]='Ywmb'
set Tka_Z21z[23]='Vcbp'
set Tka_Z21z[24]='Vstp'
set Tka_Z21z[25]='Vgrs'
set Tka_Z21z[26]='Qcrp'
set Tka_Z21z[27]='Xbtl'
set Tka_Z21z[28]='Drds'
set Tka_Z21z[29]='Dlvc'
set Tka_Z21z[30]='Dlav'
set Tka_Z21z[31]='Ddkr'
set Tka_Z21z[32]='Dgrs'
set Tka_Z21z[33]='Idki'
set Tka_Z21z[34]='Olgb'
set Tka_Z21z[35]='Oaby'
set Tka_Z21z[36]='cAc2'
set Tka_Z21z[37]='cAc1'
set Tka_Z21z[38]='cBc2'
set Tka_Z21z[39]='cKc2'
set Tka_Z21z[40]='cYc1'
set Tka_Z21z[41]='cIc1'
set Tka_Z21z[42]='cOc2'
set Tka_z84Z[0]="|c00FF0000"
set Tka_z84Z[1]="|c000000FF"
set Tka_z84Z[2]="|c0040E0D0"
set Tka_z84Z[3]="|c00800080"
set Tka_z84Z[4]="|c00FFFF00"
set Tka_z84Z[5]="|c00FFA500"
set Tka_z84Z[6]="|c0000FF00"
set Tka_z84Z[7]="|c00FF00FF"
set Tka_z84Z[8]="|c00C0C0C0"
set Tka_z84Z[9]="|c00ADD8E6"
set Tka_z84Z[10]="|c00006400"
set Tka_z84Z[11]="|c00A52A2A"
set Tka_z85Z[1]="隐藏地形"
set Tka_z85Z[2]="已探索地图"
set Tka_z85Z[3]="能见度全开"
set Tka_z85Z[4]="使用让血"
set Tka_z85Z[5]="允许旁观者"
set Tka_z85Z[6]="战败玩家成为旁观者"
set Tka_z85Z[7]="---无---"
set Tka_z85Z[8]="固定颜色"
set Tka_z85Z[9]="锁定资源交易"
set Tka_z85Z[10]="限定资源交易为同盟间"
set Tka_z85Z[11]="锁定同盟"
set Tka_z85Z[12]="隐藏同盟变动"
set Tka_z85Z[13]="作弊"
set Tka_z85Z[14]="隐藏作弊"
set Tka_z85Z[15]="锁定游戏速度"
set Tka_z85Z[16]="锁定随机种子"
set Tka_z85Z[17]="全面分享部队"
set Tka_z85Z[18]="使用乱数英雄(正规)"
set Tka_z85Z[19]="使用乱数种族(正规)"
set Tka_z85Z[20]="地图切换"
set Tka_z86Z[1]="同盟"
set Tka_z86Z[2]="要求协肋"
set Tka_z86Z[3]="回应协肋要求"
set Tka_z86Z[4]="分享经验"
set Tka_z86Z[5]="友方法术锁定"
set Tka_z86Z[6]="分享视野"
set Tka_z86Z[7]="分享部队"
set Tka_z86Z[8]="全面分享部队"
set Tka_z2Z[0]=30.
set Tka_z2Z[1]=60.
set Tka_z2Z[2]=90.
set Tka_z3Z[0]=50.
set Tka_z3Z[1]=72.
set Tka_z3Z[2]=95.
set Tka_Z75=0
set Tka_z4=false
set Tka_z5=null
loop
exitwhen Tka_Z75>20
set Tka_z02[Tka_Z75]=null
set Tka_Z75=Tka_Z75+1
endloop
call TimerStart(CreateTimer(),1,false,function Tka_z83Z)
set Tka_Z75=0
set Tka_z49Z[1]="使用-uci [物品ID] 即可召出指定物品"
set Tka_z49Z[2]="使用-ucu [部队ID] 即可召出指定部队"
set Tka_z49Z[3]="使用-uua [技能ID] 即可为你选取的部队增加指定技能"
set Tka_z49Z[4]="使用-tth [科技ID] [等级] "+Tka_Z60z+" 即可为修改指定玩家的指定科技等级"
set Tka_z50Z[1]="物品"
set Tka_z50Z[2]="部队"
set Tka_z50Z[3]="技能"
set Tka_z50Z[4]="科技"
loop
exitwhen(Tka_Z75>15)
set Tka_Z19z[Tka_Z75]=GetPlayerName(Player(Tka_Z75))
set Tka_z29Z[Tka_Z75]=false
set Tka_z87Z[Tka_Z75]=false
set Tka_z80Z[Tka_Z75]=true
set Tka_z73[Tka_Z75]=false
set Tka_Z5[Tka_Z75]=0
set Tka_z6[Tka_Z75]=false
set Tka_Z7[Tka_Z75]=false
set Tka_Z8[Tka_Z75]=0
set Tka_Z1Z[Tka_Z75]=false
set Tka_Z2Z[Tka_Z75]=false
set Tka_Z3Z[Tka_Z75]=CreateTimer()
set Tka_Z8Z[Tka_Z75]=CreateGroup()
set Tka_zZZ[Tka_Z75]=false
set Tka_z24Z[Tka_Z75]=false
set Tka_Z10z[Tka_Z75]=false
set Tka_zzZ[Tka_Z75]=false
set Tka_z0Z[Tka_Z75]=CreateTimer()
set Tka_z1Z[Tka_Z75]=false
set Tka_Z3z[Tka_Z75]=false
set Tka_Z4z[Tka_Z75]=0
set Tka_Z20[Tka_Z75]=DialogCreate()
set Tka_Z91[Tka_Z75]=DialogCreate()
set Tka_zZ1[Tka_Z75]=DialogCreate()
set Tka_z31[Tka_Z75]=false
set Tka_Z32[Tka_Z75]=0
set Tka_Z42[Tka_Z75]=false
set Tka_Zz3[Tka_Z75]=DialogCreate()
set Tka_Z33[Tka_Z75]=false
set Tka_Z43[Tka_Z75]=true
set Tka_Z53[Tka_Z75]=false
set Tka_Z63[Tka_Z75]=false
set Tka_Z73[Tka_Z75]=CreateTimer()
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z75=(StringLength(Tka_Z02Z)-6)
call Tka_Z74z(Tka_Z75)
set Tka_Z75=0
loop
exitwhen(Tka_Z75>21)
set Tka_Z20z=Tka_Z20z+"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
set Tka_z12[Tka_Z75]=false
set Tka_Z75=Tka_Z75+1
endloop
set Tka_Z20z=Tka_Z20z+"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　"
call TriggerAddAction(Tka_z33,function Tka_Z70Z)
call TriggerAddAction(Tka_z43,function Tka_Z74Z)
call TriggerAddAction(Tka_z63,function Tka_Z80Z)
call TriggerRegisterAnyUnitEventBJ(Tka_z83,ConvertPlayerUnitEvent(18))
call TriggerRegisterAnyUnitEventBJ(Tka_Z43z,ConvertPlayerUnitEvent(273))
call TriggerAddAction(Tka_Z43z, function Tka_Z45z)
call TriggerRegisterAnyUnitEventBJ(Tka_Z44z,ConvertPlayerUnitEvent(37))
call TriggerAddAction(Tka_Z44z, function Tka_Z46z)
call TriggerAddAction(Tka_z83,function Tka_Z93Z)
call DisableTrigger(Tka_z83)
call Tka_Z69Z()
call SetPlayerName(Player(12),"中立生物")
set Tka_Z65=null
set Tka_z05=null
set Tka_Z75=48
set Tka_z15=1
loop
set Tka_z53Z[Tka_z15]=Tka_Z75
set Tka_z15=Tka_z15+1
set Tka_Z75=Tka_Z75+1
exitwhen Tka_Z75==123
if(Tka_Z75==58)then
set Tka_Z75=65
else
if(Tka_Z75==91)then
set Tka_Z75=97
endif
endif
endloop
endfunction