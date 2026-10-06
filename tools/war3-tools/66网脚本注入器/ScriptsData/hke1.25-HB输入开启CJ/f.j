function hbzy_Z25 takes real a,real b returns real
if(a<b)then
return b
else
return a
endif
endfunction
function hbzy_Z35 takes unit hbzy_Z45 returns integer
return UnitInventorySize(hbzy_Z45)
endfunction
function hbzy_Z55 takes item hbzy_Z65,location hbzy_Z75 returns nothing
call SetItemPosition(hbzy_Z65,GetLocationX(hbzy_Z75),GetLocationY(hbzy_Z75))
endfunction
function hbzy_Z85 takes unit hbzy_Z45,integer hbzy_Z95 returns item
return UnitItemInSlot(hbzy_Z45,hbzy_Z95-1)
endfunction
function hbzy_zZ5 takes boolean hbzy_zz5,player hbzy_z05,location hbzy_Z75,real hbzy_z15 returns nothing
call SetBlightLoc(hbzy_z05,hbzy_Z75,hbzy_z15,hbzy_zz5)
endfunction
function hbzy_z25 takes player hbzy_z05,playerstate hbzy_z35,integer hbzy_z45 returns nothing
call SetPlayerState(hbzy_z05,hbzy_z35,GetPlayerState(hbzy_z05,hbzy_z35)+hbzy_z45)
endfunction
function hbzy_z55 takes integer hbzy_z45,player hbzy_z05,playerstate hbzy_z35 returns nothing
if(hbzy_z45>0)then
if(hbzy_z35==PLAYER_STATE_RESOURCE_GOLD)then
call hbzy_z25(hbzy_z05,PLAYER_STATE_GOLD_GATHERED,hbzy_z45)
elseif(hbzy_z35==PLAYER_STATE_RESOURCE_LUMBER)then
call hbzy_z25(hbzy_z05,PLAYER_STATE_LUMBER_GATHERED,hbzy_z45)
endif
endif
call hbzy_z25(hbzy_z05,hbzy_z35,hbzy_z45)
endfunction
function hbzy_z65 takes player hbzy_z05,playerstate hbzy_z35,integer hbzy_z75 returns nothing
local integer hbzy_z85=GetPlayerState(hbzy_z05,hbzy_z35)
call hbzy_z55(hbzy_z75-hbzy_z85,hbzy_z05,hbzy_z35)
endfunction
function hbzy_z95 takes real hbzy_ZZ6 returns real
return hbzy_ZZ6*.023/10
endfunction
function hbzy_Zz6 takes real hbzy_Z06,integer hbzy_Z16 returns integer
local integer hbzy_Z26=R2I(hbzy_Z06*I2R(hbzy_Z16)*.01)
if(hbzy_Z26<0)then
set hbzy_Z26=0
elseif(hbzy_Z26>hbzy_Z16)then
set hbzy_Z26=hbzy_Z16
endif
return hbzy_Z26
endfunction
function hbzy_Z36 takes real hbzy_Z06 returns integer
return hbzy_Zz6(hbzy_Z06,255)
endfunction
function hbzy_Z46 takes texttag tt,string s,real hbzy_ZZ6 returns nothing
local real hbzy_Z56=hbzy_z95(hbzy_ZZ6)
call SetTextTagText(tt,s,hbzy_Z56)
endfunction
function hbzy_Z66 takes texttag tt,location hbzy_Z75,real hbzy_Z76 returns nothing
call SetTextTagPos(tt,GetLocationX(hbzy_Z75),GetLocationY(hbzy_Z75),hbzy_Z76)
endfunction
function hbzy_Z86 takes texttag tt,real hbzy_Z96,real hbzy_zZ6,real hbzy_zz6,real hbzy_z06 returns nothing
call SetTextTagColor(tt,hbzy_Z36(hbzy_Z96),hbzy_Z36(hbzy_zZ6),hbzy_Z36(hbzy_zz6),hbzy_Z36(100.-hbzy_z06))
endfunction
function hbzy_z16 takes string s,location hbzy_Z75,real hbzy_Z76,real hbzy_ZZ6,real hbzy_Z96,real hbzy_zZ6,real hbzy_zz6,real hbzy_z06 returns texttag
local texttag hbzy_z26=CreateTextTag()
call hbzy_Z46(hbzy_z26,s,hbzy_ZZ6)
call hbzy_Z66(hbzy_z26,hbzy_Z75,hbzy_Z76)
call hbzy_Z86(hbzy_z26,hbzy_Z96,hbzy_zZ6,hbzy_zz6,hbzy_z06)
return hbzy_z26
endfunction
function hbzy_z36 takes nothing returns nothing
call SetMapFlag(MAP_LOCK_SPEED,true)
endfunction
function hbzy_z46 takes nothing returns nothing
call SetMapFlag(MAP_LOCK_SPEED,false)
endfunction
function hbzy_z56 takes timer t,boolean hbzy_z66,real hbzy_z76 returns timer
call TimerStart(t,hbzy_z76,hbzy_z66,null)
return t
endfunction
function hbzy_z86 takes timer t,string hbzy_z96 returns timerdialog
local timerdialog hbzy_ZZ7=CreateTimerDialog(t)
call TimerDialogSetTitle(hbzy_ZZ7,hbzy_z96)
call TimerDialogDisplay(hbzy_ZZ7,true)
return hbzy_ZZ7
endfunction
function hbzy_Zz7 takes unit hbzy_Z07,integer hbzy_Z17,boolean hbzy_Z27 returns nothing
local integer hbzy_Z37=GetHeroLevel(hbzy_Z07)
if(hbzy_Z17>hbzy_Z37)then
call SetHeroLevel(hbzy_Z07,hbzy_Z17,hbzy_Z27)
elseif(hbzy_Z17<hbzy_Z37)then
call UnitStripHeroLevel(hbzy_Z07,hbzy_Z37-hbzy_Z17)
endif
endfunction
function hbzy_Z47 takes integer hbzy_Z57,unit hbzy_Z07,boolean hbzy_Z67 returns integer
if(hbzy_Z57==hbzy_Z04)then
return GetHeroStr(hbzy_Z07,hbzy_Z67)
elseif(hbzy_Z57==hbzy_Z14)then
return GetHeroAgi(hbzy_Z07,hbzy_Z67)
elseif(hbzy_Z57==hbzy_Z24)then
return GetHeroInt(hbzy_Z07,hbzy_Z67)
else
return 0
endif
endfunction
function hbzy_Z77 takes unit hbzy_Z07,integer hbzy_Z57,integer hbzy_z75 returns nothing
if(hbzy_z75<=0)then
return
endif
if(hbzy_Z57==hbzy_Z04)then
call SetHeroStr(hbzy_Z07,hbzy_z75,true)
elseif(hbzy_Z57==hbzy_Z14)then
call SetHeroAgi(hbzy_Z07,hbzy_z75,true)
elseif(hbzy_Z57==hbzy_Z24)then
call SetHeroInt(hbzy_Z07,hbzy_z75,true)
endif
endfunction
function hbzy_Z87 takes integer hbzy_Z57,unit hbzy_Z07,integer hbzy_Z97,integer hbzy_z75 returns nothing
if(hbzy_Z97==hbzy_Z44)then
call hbzy_Z77(hbzy_Z07,hbzy_Z57,hbzy_Z47(hbzy_Z57,hbzy_Z07,false)+hbzy_z75)
elseif(hbzy_Z97==hbzy_Z54)then
call hbzy_Z77(hbzy_Z07,hbzy_Z57,hbzy_Z47(hbzy_Z57,hbzy_Z07,false)-hbzy_z75)
elseif(hbzy_Z97==hbzy_Z64)then
call hbzy_Z77(hbzy_Z07,hbzy_Z57,hbzy_z75)
endif
endfunction
function hbzy_zZ7 takes unit hbzy_Z45,real hbzy_Z96,real hbzy_zZ6,real hbzy_zz6,real hbzy_z06 returns nothing
call SetUnitVertexColor(hbzy_Z45,hbzy_Z36(hbzy_Z96),hbzy_Z36(hbzy_zZ6),hbzy_Z36(hbzy_zz6),hbzy_Z36(100.-hbzy_z06))
endfunction
function hbzy_zz7 takes real hbzy_Z96,real hbzy_zZ6,real hbzy_zz6,real hbzy_z06 returns nothing
call SetWaterBaseColor(hbzy_Z36(hbzy_Z96),hbzy_Z36(hbzy_zZ6),hbzy_Z36(hbzy_zz6),hbzy_Z36(100.-hbzy_z06))
endfunction
function hbzy_z07 takes integer hbzy_z17,location hbzy_Z75 returns item
local item hbzy_z27=CreateItem(hbzy_z17,GetLocationX(hbzy_Z75),GetLocationY(hbzy_Z75))
return hbzy_z27
endfunction
function hbzy_z37 takes item hbzy_Z65,unit hbzy_Z07 returns nothing
call UnitRemoveItem(hbzy_Z07,hbzy_Z65)
endfunction
function hbzy_z47 takes unit hbzy_Z45 returns boolean
return GetUnitState(hbzy_Z45,UNIT_STATE_LIFE)<=0
endfunction
function hbzy_z57 takes unit hbzy_Z45,real hbzy_z67 returns nothing
call SetUnitState(hbzy_Z45,UNIT_STATE_MANA,GetUnitState(hbzy_Z45,UNIT_STATE_MAX_MANA)*hbzy_Z25(0,hbzy_z67)*.01)
endfunction
function hbzy_z77 takes integer hbzy_z87,integer hbzy_z97 returns integer
local integer hbzy_ZZ8=hbzy_z87-(hbzy_z87/hbzy_z97)*hbzy_z97
if(hbzy_ZZ8<0)then
set hbzy_ZZ8=hbzy_ZZ8+hbzy_z97
endif
return hbzy_ZZ8
endfunction
function hbzy_Zz8 takes string hbzy_Z08,integer hbzy_Z18,integer hbzy_Z28 returns string
return SubString(hbzy_Z08,hbzy_Z18-1,hbzy_Z28)
endfunction
function hbzy_Z38 takes nothing returns nothing
set hbzy_Z74=hbzy_Z74+1
endfunction
function hbzy_Z48 takes group g returns integer
set hbzy_Z74=0
call ForGroup(g,function hbzy_Z38)
return hbzy_Z74
endfunction
function hbzy_Z58 takes nothing returns nothing
call GroupAddUnit(hbzy_Z84,GetEnumUnit())
endfunction
function hbzy_Z68 takes group hbzy_Z78,group hbzy_Z88 returns nothing
set hbzy_Z84=hbzy_Z88
call ForGroup(hbzy_Z78,function hbzy_Z58)
endfunction
function hbzy_Z98 takes nothing returns nothing
call GroupRemoveUnit(hbzy_Z34,GetEnumUnit())
endfunction
function hbzy_zZ8 takes group hbzy_Z78,group hbzy_Z88 returns nothing
set hbzy_Z34=hbzy_Z88
call ForGroup(hbzy_Z78,function hbzy_Z98)
endfunction
function hbzy_zz8 takes force hbzy_z08,real hbzy_z18,string hbzy_z28 returns nothing
if(IsPlayerInForce(GetLocalPlayer(),hbzy_z08))then
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,hbzy_z18,hbzy_z28)
endif
endfunction
function hbzy_z38 takes boolean hbzy_z48,unit hbzy_Z07 returns nothing
call SuspendHeroXP(hbzy_Z07,not hbzy_z48)
endfunction
function hbzy_z58 takes unit hbzy_Z07,integer hbzy_Z97,integer hbzy_z75 returns boolean
if(hbzy_Z97==hbzy_Z44)then
return UnitModifySkillPoints(hbzy_Z07,hbzy_z75)
elseif(hbzy_Z97==hbzy_Z54)then
return UnitModifySkillPoints(hbzy_Z07,-hbzy_z75)
elseif(hbzy_Z97==hbzy_Z64)then
return UnitModifySkillPoints(hbzy_Z07,hbzy_z75-GetHeroSkillPoints(hbzy_Z07))
else
return false
endif
endfunction
function hbzy_z68 takes unit hbzy_Z45,real hbzy_z67 returns nothing
call SetUnitState(hbzy_Z45,UNIT_STATE_LIFE,GetUnitState(hbzy_Z45,UNIT_STATE_MAX_LIFE)*hbzy_Z25(0,hbzy_z67)*.01)
endfunction
function hbzy_z78 takes unit hbzy_Z45,real hbzy_z88,real hbzy_z98,real hbzy_ZZZZ returns nothing
call SetUnitScale(hbzy_Z45,hbzy_z88*.01,hbzy_z98*.01,hbzy_ZZZZ*.01)
endfunction
function hbzy_ZZzZ takes real hbzy_ZZ0Z returns nothing
call SetFloatGameState(GAME_STATE_TIME_OF_DAY,hbzy_ZZ0Z)
endfunction
function hbzy_ZZ1Z takes unit hbzy_Z45,unitstate hbzy_ZZ2Z,unitstate hbzy_ZZ3Z returns real
local real hbzy_z75=GetUnitState(hbzy_Z45,hbzy_ZZ2Z)
local real hbzy_ZZ4Z=GetUnitState(hbzy_Z45,hbzy_ZZ3Z)
if(hbzy_Z45==null)or(hbzy_ZZ4Z==0)then
return .0
endif
return hbzy_z75/ hbzy_ZZ4Z*100.
endfunction
function hbzy_ZZ5Z takes unit hbzy_Z45 returns real
return hbzy_ZZ1Z(hbzy_Z45,UNIT_STATE_LIFE,UNIT_STATE_MAX_LIFE)
endfunction
function hbzy_ZZ6Z takes unit hbzy_Z45,unit hbzy_ZZ7Z,real hbzy_ZZ8Z,attacktype hbzy_ZZ9Z,damagetype hbzy_ZzZZ returns boolean
return UnitDamageTarget(hbzy_Z45,hbzy_ZZ7Z,hbzy_ZZ8Z,true,false,hbzy_ZZ9Z,hbzy_ZzZZ,WEAPON_TYPE_WHOKNOWS)
endfunction
function hbzy_ZzzZ takes integer hbzy_Zz0Z,integer hbzy_Zz1Z,player hbzy_z05 returns nothing
call SetPlayerTechResearched(hbzy_z05,hbzy_Zz0Z,hbzy_Zz1Z)
endfunction
function hbzy_Zz2Z takes player id,integer hbzy_Zz3Z,location hbzy_Z75,real hbzy_Zz4Z returns unit
if(hbzy_Zz3Z==1969713004)then
set hbzy_z54=CreateBlightedGoldmine(id,GetLocationX(hbzy_Z75),GetLocationY(hbzy_Z75),hbzy_Zz4Z)
else
set hbzy_z54=CreateUnitAtLoc(id,hbzy_Zz3Z,hbzy_Z75,hbzy_Zz4Z)
endif
return hbzy_z54
endfunction
function hbzy_Zz5Z takes integer hbzy_Zz6Z,integer hbzy_Zz7Z,player hbzy_z05,location hbzy_Z75,real hbzy_Zz4Z returns group
local group hbzy_Zz8Z=CreateGroup()
loop
set hbzy_Zz6Z=hbzy_Zz6Z-1
exitwhen hbzy_Zz6Z<0
call hbzy_Zz2Z(hbzy_z05,hbzy_Zz7Z,hbzy_Z75,hbzy_Zz4Z)
call GroupAddUnit(hbzy_Zz8Z,hbzy_z54)
endloop
return hbzy_Zz8Z
endfunction
function hbzy_Zz9Z takes integer hbzy_Zz0Z,player hbzy_z05 returns integer
return GetPlayerTechCount(hbzy_z05,hbzy_Zz0Z,true)
endfunction
function hbzy_Z0ZZ takes unit hbzy_Z45 returns real
return hbzy_ZZ1Z(hbzy_Z45,UNIT_STATE_MANA,UNIT_STATE_MAX_MANA)
endfunction
function hbzy_Z0zZ takes player hbzy_z05,real hbzy_Z00Z returns nothing
call SetPlayerHandicap(hbzy_z05,hbzy_Z00Z*.01)
endfunction
function hbzy_Z01Z takes player hbzy_z05 returns real
return GetPlayerHandicap(hbzy_z05)*100
endfunction
function hbzy_Z02Z takes player hbzy_z05,real hbzy_Z00Z returns nothing
call SetPlayerHandicapXP(hbzy_z05,hbzy_Z00Z*.01)
endfunction
function hbzy_Z03Z takes player hbzy_z05 returns real
return GetPlayerHandicapXP(hbzy_z05)*100
endfunction
function hbzy_Z04Z takes player hbzy_Z05Z,alliancetype hbzy_Z06Z,boolean hbzy_z75,player hbzy_Z07Z returns nothing
if(hbzy_Z05Z==hbzy_Z07Z)then
return
endif
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,hbzy_Z06Z,hbzy_z75)
endfunction
function hbzy_Z08Z takes boolean hbzy_Z09Z,unit hbzy_Z45,player hbzy_z05 returns nothing
call UnitShareVision(hbzy_Z45,hbzy_z05,hbzy_Z09Z)
endfunction
function hbzy_Z1ZZ takes trigger hbzy_Z1zZ,player hbzy_z05,integer hbzy_Z10Z,integer hbzy_Z11Z returns event
if(hbzy_Z10Z==hbzy_zZ4)then
if(hbzy_Z11Z==hbzy_z04)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_LEFT_DOWN)
elseif(hbzy_Z11Z==hbzy_z14)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_RIGHT_DOWN)
elseif(hbzy_Z11Z==hbzy_z24)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_DOWN_DOWN)
elseif(hbzy_Z11Z==hbzy_z34)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_UP_DOWN)
else
return null
endif
elseif(hbzy_Z10Z==hbzy_zz4)then
if(hbzy_Z11Z==hbzy_z04)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_LEFT_UP)
elseif(hbzy_Z11Z==hbzy_z14)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_RIGHT_UP)
elseif(hbzy_Z11Z==hbzy_z24)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_DOWN_UP)
elseif(hbzy_Z11Z==hbzy_z34)then
return TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_z05,EVENT_PLAYER_ARROW_UP_UP)
else
return null
endif
else
return null
endif
endfunction
function hbzy_Z12Z takes trigger hbzy_Z1zZ,playerunitevent hbzy_Z13Z returns nothing
local integer hbzy_Z14Z
set hbzy_Z14Z=0
loop
call TriggerRegisterPlayerUnitEvent(hbzy_Z1zZ,Player(hbzy_Z14Z),hbzy_Z13Z,null)
set hbzy_Z14Z=hbzy_Z14Z+1
exitwhen hbzy_Z14Z==hbzy_z44
endloop
endfunction
function hbzy_Z15Z takes player hbzy_z05 returns location
return GetStartLocationLoc(GetPlayerStartLocation(hbzy_z05))
endfunction
function hbzy_Z16Z takes player hbzy_Z05Z,player hbzy_Z07Z,boolean hbzy_z48 returns nothing
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_PASSIVE,hbzy_z48)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_HELP_REQUEST,hbzy_z48)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_HELP_RESPONSE,hbzy_z48)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_SHARED_XP,hbzy_z48)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_SHARED_SPELLS,hbzy_z48)
endfunction
function hbzy_Z17Z takes player hbzy_Z05Z,player hbzy_Z07Z,boolean hbzy_z48 returns nothing
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_SHARED_VISION,hbzy_z48)
endfunction
function hbzy_Z18Z takes player hbzy_Z05Z,player hbzy_Z07Z,boolean hbzy_z48 returns nothing
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_SHARED_CONTROL,hbzy_z48)
endfunction
function hbzy_Z19Z takes player hbzy_Z05Z,player hbzy_Z07Z,boolean hbzy_z48 returns nothing
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_SHARED_ADVANCED_CONTROL,hbzy_z48)
endfunction
function hbzy_Z2ZZ takes player hbzy_Z05Z,player hbzy_Z07Z,integer hbzy_Z2zZ returns nothing
if(hbzy_Z05Z==hbzy_Z07Z)then
return
endif
if hbzy_Z2zZ==hbzy_z64 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
elseif hbzy_Z2zZ==hbzy_z74 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
elseif hbzy_Z2zZ==hbzy_z84 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
elseif hbzy_Z2zZ==hbzy_z94 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
elseif hbzy_Z2zZ==hbzy_ZZ5 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
elseif hbzy_Z2zZ==hbzy_Zz5 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,true)
elseif hbzy_Z2zZ==hbzy_Z05 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_PASSIVE,true)
elseif hbzy_Z2zZ==hbzy_Z15 then
call hbzy_Z16Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z17Z(hbzy_Z05Z,hbzy_Z07Z,true)
call hbzy_Z18Z(hbzy_Z05Z,hbzy_Z07Z,false)
call hbzy_Z19Z(hbzy_Z05Z,hbzy_Z07Z,false)
call SetPlayerAlliance(hbzy_Z05Z,hbzy_Z07Z,ALLIANCE_PASSIVE,true)
endif
endfunction
function hbzy_Z20Z takes player hbzy_z05,integer hbzy_Zz3Z returns group
local group g=CreateGroup()
set hbzy_z93=hbzy_Zz3Z
call GroupEnumUnitsOfPlayer(g,hbzy_z05,hbzy_Zz4)
return g
endfunction
function hbzy_Z21Z takes trigger hbzy_Z1zZ,player hbzy_Z22Z,integer hbzy_Z23Z returns nothing
local playerevent hbzy_Z24Z=ConvertPlayerEvent(hbzy_Z23Z)
call TriggerRegisterPlayerEvent(hbzy_Z1zZ,hbzy_Z22Z,hbzy_Z24Z)
set hbzy_Z24Z=null
endfunction
function hbzy_Z25Z takes trigger hbzy_Z1zZ,player hbzy_Z22Z,integer hbzy_Z23Z returns nothing
local playerunitevent hbzy_Z24Z=ConvertPlayerUnitEvent(hbzy_Z23Z)
call TriggerRegisterPlayerUnitEvent(hbzy_Z1zZ,hbzy_Z22Z,hbzy_Z24Z,null)
set hbzy_Z24Z=null
endfunction
function hbzy_Z26Z takes integer hbzy_Z23Z,player hbzy_Z22Z returns nothing
call TriggerRegisterPlayerUnitEvent(hbzy_Z30[hbzy_Z23Z],hbzy_Z22Z,ConvertPlayerUnitEvent(24),null)
call TriggerRegisterPlayerUnitEvent(hbzy_Z50[hbzy_Z23Z],hbzy_Z22Z,ConvertPlayerUnitEvent(25),null)
call hbzy_Z21Z(hbzy_Z70[hbzy_Z23Z],hbzy_Z22Z,17)
call hbzy_Z21Z(hbzy_Z90[hbzy_Z23Z],hbzy_Z22Z,266)
call hbzy_Z21Z(hbzy_Z80[hbzy_Z23Z],hbzy_Z22Z,268)
call hbzy_Z21Z(hbzy_zZ0[hbzy_Z23Z],hbzy_Z22Z,262)
call hbzy_Z21Z(hbzy_zz0[hbzy_Z23Z],hbzy_Z22Z,264)
call TriggerRegisterTimerExpireEvent(hbzy_z43,hbzy_z0Z[hbzy_Z23Z])
call TriggerRegisterTimerExpireEvent(hbzy_z33,hbzy_Z73[hbzy_Z23Z])
call hbzy_Z25Z(hbzy_Z40[hbzy_Z23Z],hbzy_Z22Z,32)
call hbzy_Z25Z(hbzy_Z60[hbzy_Z23Z],hbzy_Z22Z,35)
call TriggerRegisterDialogEvent(hbzy_ZZ1[hbzy_Z23Z],hbzy_zZ1[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Zz2[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Zz1[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z01[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z81[hbzy_Z23Z],hbzy_Z91[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z71[hbzy_Z23Z],hbzy_zZ1[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z21[hbzy_Z23Z],hbzy_Z91[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z31[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z22[hbzy_Z23Z],hbzy_Z91[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z11[hbzy_Z23Z],hbzy_Z91[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z51[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z41[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z61[hbzy_Z23Z],hbzy_Z91[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z12[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z02[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z23[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call TriggerRegisterDialogEvent(hbzy_Z13[hbzy_Z23Z],hbzy_Z20[hbzy_Z23Z])
call hbzy_Z25Z(hbzy_z01[hbzy_Z23Z],hbzy_Z22Z,38)
call hbzy_Z25Z(hbzy_z11[hbzy_Z23Z],hbzy_Z22Z,39)
call hbzy_Z25Z(hbzy_z21[hbzy_Z23Z],hbzy_Z22Z,40)
call hbzy_Z25Z(hbzy_z80[hbzy_Z23Z],hbzy_Z22Z,276)
call hbzy_Z25Z(hbzy_z80[hbzy_Z23Z],hbzy_Z22Z,275)
call hbzy_Z25Z(hbzy_z90[hbzy_Z23Z],hbzy_Z22Z,276)
call hbzy_Z25Z(hbzy_z90[hbzy_Z23Z],hbzy_Z22Z,275)
call hbzy_Z25Z(hbzy_ZZ3[hbzy_Z23Z],hbzy_Z22Z,18)
call TriggerRegisterPlayerStateEvent(hbzy_z60[hbzy_Z23Z],hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hbzy_z40[hbzy_Z23Z],hbzy_Z22Z,PLAYER_STATE_RESOURCE_GOLD,GREATER_THAN_OR_EQUAL,0)
call TriggerRegisterPlayerStateEvent(hbzy_z50[hbzy_Z23Z],hbzy_Z22Z,PLAYER_STATE_RESOURCE_LUMBER,GREATER_THAN_OR_EQUAL,0)
call hbzy_Z25Z(hbzy_z70[hbzy_Z23Z],hbzy_Z22Z,20)
call TriggerRegisterPlayerChatEvent(hbzy_zz1[hbzy_Z23Z],hbzy_Z22Z,"-",false)
call hbzy_Z25Z(hbzy_Z6z[hbzy_Z23Z],hbzy_Z22Z,39)
set hbzy_Z3z[hbzy_Z23Z]=true
endfunction
function hbzy_Z27Z takes player hbzy_Z28Z,integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z3ZZ)then
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)+hbzy_Z29Z)
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_GOLD_GATHERED,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_GOLD_GATHERED)-hbzy_Z29Z)
else
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)-hbzy_Z29Z)
endif
endfunction
function hbzy_Z3zZ takes player hbzy_Z28Z,integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z3ZZ)then
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)+hbzy_Z29Z)
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_LUMBER_GATHERED,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_LUMBER_GATHERED)-hbzy_Z29Z)
else
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)-hbzy_Z29Z)
endif
endfunction
function hbzy_Z30Z takes player hbzy_Z28Z returns nothing
local player hbzy_Z22Z=GetLocalPlayer()
if hbzy_Z28Z==hbzy_Z22Z then
set hbzy_Z22Z=Player(-1)
endif
set hbzy_Z22Z=null
endfunction
function hbzy_Z31Z takes unit hbzy_Z32Z,unit hbzy_Z33Z,boolean hbzy_Z34Z returns nothing
local location hbzy_Z35Z
local location hbzy_Z36Z
set hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
set hbzy_Z36Z=GetUnitLoc(hbzy_Z33Z)
call SetUnitPositionLoc(hbzy_Z32Z,hbzy_Z36Z)
if(hbzy_Z34Z)then
call SetUnitPositionLoc(hbzy_Z33Z,hbzy_Z35Z)
call SetUnitPositionLoc(hbzy_Z32Z,hbzy_Z36Z)
endif
call RemoveLocation(hbzy_Z35Z)
call RemoveLocation(hbzy_Z36Z)
set hbzy_Z35Z=null
set hbzy_Z36Z=null
endfunction
function hbzy_Z37Z takes integer hbzy_Z38Z returns nothing
if(hbzy_Z38Z==0)then
set hbzy_zZ2=100
set hbzy_Z92=100
set hbzy_Z82=100
set hbzy_Z72="|cFFFFFFFF"
return
endif
if(hbzy_Z38Z==1)then
set hbzy_zZ2=50
set hbzy_Z92=50
set hbzy_Z82=50
set hbzy_Z72="|cFF7F7F7F"
return
endif
if(hbzy_Z38Z==2)then
set hbzy_zZ2=0
set hbzy_Z92=0
set hbzy_Z82=0
set hbzy_Z72="|cFF000000"
return
endif
if(hbzy_Z38Z==3)then
set hbzy_zZ2=100
set hbzy_Z92=0
set hbzy_Z82=0
set hbzy_Z72="|cFFFF0000"
return
endif
if(hbzy_Z38Z==4)then
set hbzy_zZ2=100
set hbzy_Z92=50
set hbzy_Z82=0
set hbzy_Z72="|cFFFF7F00"
return
endif
if(hbzy_Z38Z==5)then
set hbzy_zZ2=100
set hbzy_Z92=100
set hbzy_Z82=0
set hbzy_Z72="|cFFFFFF00"
return
endif
if(hbzy_Z38Z==6)then
set hbzy_zZ2=0
set hbzy_Z92=100
set hbzy_Z82=0
set hbzy_Z72="|cFF00FF00"
return
endif
if(hbzy_Z38Z==7)then
set hbzy_zZ2=0
set hbzy_Z92=100
set hbzy_Z82=100
set hbzy_Z72="|cFF00FFFF"
return
endif
if(hbzy_Z38Z==8)then
set hbzy_zZ2=0
set hbzy_Z92=0
set hbzy_Z82=100
set hbzy_Z72="|cFF0000FF"
return
endif
if(hbzy_Z38Z==9)then
set hbzy_zZ2=100
set hbzy_Z92=0
set hbzy_Z82=100
set hbzy_Z72="|cFFFF00FF"
return
endif
endfunction
function hbzy_Z39Z takes integer hbzy_Z38Z,unit hbzy_Z4ZZ,string hbzy_Z4zZ returns nothing
local texttag hbzy_Z40Z
local location hbzy_Z35Z
call hbzy_Z37Z(hbzy_Z38Z)
set hbzy_Z35Z=GetUnitLoc(hbzy_Z4ZZ)
set hbzy_Z40Z=hbzy_z16(hbzy_Z4zZ,hbzy_Z35Z,0,20,hbzy_zZ2,hbzy_Z92,hbzy_Z82,0)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
call SetTextTagPermanent(hbzy_Z40Z,false)
call SetTextTagLifespan(hbzy_Z40Z,hbzy_Z1)
set hbzy_Z40Z=null
endfunction
function hbzy_Z41Z takes nothing returns nothing
local trigger hbzy_Z42Z=GetTriggeringTrigger()
local timer hbzy_Z43Z=GetExpiredTimer()
local timerdialog H_dio
call DestroyTrigger(hbzy_Z42Z)
call hbzy_z46()
call SetGameSpeed(hbzy_z52)
call DestroyTimerDialog(hbzy_z82)
call DestroyTimer(hbzy_Z43Z)
set hbzy_Z42Z=null
set hbzy_Z43Z=null
endfunction
function hbzy_Z44Z takes nothing returns nothing
local timer hbzy_Z43Z
local trigger hbzy_Z42Z
if(hbzy_z62)then
else
set hbzy_z52=GetGameSpeed()
set hbzy_z72=IsMapFlagSet(MAP_LOCK_SPEED)
call hbzy_z46()
call SetGameSpeed(MAP_SPEED_SLOWEST)
call hbzy_z36()
set hbzy_Z42Z=CreateTrigger()
set hbzy_Z43Z=CreateTimer()
call hbzy_z56(hbzy_Z43Z,false,hbzy_z42)
set hbzy_z82=hbzy_z86(hbzy_Z43Z,"子弹时间")
call TriggerAddAction(hbzy_Z42Z,function hbzy_Z41Z)
call TriggerRegisterTimerExpireEvent(hbzy_Z42Z,hbzy_Z43Z)
endif
endfunction
function hbzy_Z45Z takes trigger hbzy_Z46Z returns nothing
if(IsTriggerEnabled(hbzy_Z46Z))then
call DisableTrigger(hbzy_Z46Z)
else
call EnableTrigger(hbzy_Z46Z)
endif
endfunction
function hbzy_Z47Z takes trigger hbzy_Z46Z,boolean hbzy_Z48Z returns nothing
if(IsTriggerEnabled(hbzy_Z46Z)==hbzy_Z48Z)then
else
call hbzy_Z45Z(hbzy_Z46Z)
endif
endfunction
function hbzy_Z49Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
call hbzy_Z47Z(hbzy_z40[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_z50[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_z60[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_z80[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_z70[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_z90[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_Z47Z(hbzy_ZZ3[hbzy_Z29Z],hbzy_Z3ZZ)
endfunction
function hbzy_Z5ZZ takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
if(GetUnitUserData(hbzy_Z32Z)==2176)then
call RemoveUnit(hbzy_Z32Z)
endif
set hbzy_Z32Z=null
endfunction
function hbzy_Z5zZ takes player hbzy_Z28Z returns nothing
local group hbzy_Z50Z
if(hbzy_Z42[GetPlayerId(hbzy_Z28Z)])then
call GroupEnumUnitsOfPlayer(hbzy_Z50Z,hbzy_Z28Z,null)
call ForGroup(hbzy_Z50Z,function hbzy_Z5ZZ)
set hbzy_Z42[GetPlayerId(hbzy_Z28Z)]=false
call DestroyGroup(hbzy_Z50Z)
set hbzy_Z50Z=null
endif
endfunction
function hbzy_Z51Z takes unit hbzy_Z32Z,player hbzy_Z28Z returns nothing
local location hbzy_Z35Z
local integer hbzy_Z52Z
local unit hbzy_Z53Z
local item hbzy_Z54Z
local integer hbzy_Z23Z=0
if(IsUnitType(hbzy_Z32Z,UNIT_TYPE_HERO))then
set hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
set hbzy_Z52Z=GetUnitTypeId(hbzy_Z32Z)
set hbzy_Z53Z=CreateUnitAtLoc(hbzy_Z28Z,hbzy_Z52Z,hbzy_Z35Z,hbzy_ZZ4)
call SetUnitUserData(hbzy_Z53Z,2176)
set hbzy_Z42[GetPlayerId(hbzy_Z28Z)]=true
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_Z53Z,false)
endif
call hbzy_Zz7(hbzy_Z53Z,GetHeroLevel(hbzy_Z32Z),false)
call hbzy_Z77(hbzy_Z53Z,0,hbzy_Z47(0,hbzy_Z32Z,false))
call hbzy_Z77(hbzy_Z53Z,1,hbzy_Z47(1,hbzy_Z32Z,false))
call hbzy_Z77(hbzy_Z53Z,2,hbzy_Z47(2,hbzy_Z32Z,false))
loop
exitwhen hbzy_Z23Z>5
set hbzy_Z54Z=UnitItemInSlot(hbzy_Z32Z,hbzy_Z23Z)
call UnitAddItemById(hbzy_Z53Z,GetItemTypeId(hbzy_Z54Z))
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
endif
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
set hbzy_Z53Z=null
set hbzy_Z54Z=null
endfunction
function hbzy_Z55Z takes integer hbzy_Zz7Z,player hbzy_Z56Z,location hbzy_Z57Z,boolean hbzy_Z58Z,boolean hbzy_Z59Z returns nothing
local unit hbzy_Z53Z
set hbzy_Z53Z=CreateUnitAtLoc(hbzy_Z56Z,hbzy_Zz7Z,hbzy_Z57Z,hbzy_ZZ4)
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_Z53Z,false)
endif
if(hbzy_Z58Z)then
call SetUnitUserData(hbzy_Z53Z,2176)
endif
if(hbzy_Z59Z)then
call UnitApplyTimedLife(hbzy_Z53Z,1112820806,90)
endif
set hbzy_Z53Z=null
endfunction
function hbzy_Z6ZZ takes integer hbzy_Zz7Z,player hbzy_Z56Z,location hbzy_Z57Z returns nothing
local unit hbzy_Z53Z
set hbzy_Z53Z=CreateUnitAtLoc(hbzy_Z56Z,hbzy_Zz7Z,hbzy_Z57Z,hbzy_ZZ4)
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_Z53Z,false)
set hbzy_Z53Z=null
endif
endfunction
function hbzy_Z6zZ takes unit hbzy_Z60Z,player hbzy_Z56Z,integer hbzy_Zz6Z,boolean hbzy_Z59Z returns nothing
local location hbzy_Z35Z
local integer hbzy_Z52Z
local integer hbzy_Z23Z
set hbzy_Z35Z=GetUnitLoc(hbzy_Z60Z)
set hbzy_Z52Z=GetUnitTypeId(hbzy_Z60Z)
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>hbzy_Zz6Z
call hbzy_Z55Z(hbzy_Z52Z,hbzy_Z56Z,hbzy_Z35Z,true,hbzy_Z59Z)
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z42[GetPlayerId(hbzy_Z56Z)]=true
set hbzy_Z35Z=null
endfunction
function hbzy_Z61Z takes unit hbzy_Z60Z,player hbzy_Z56Z,integer hbzy_Zz6Z returns nothing
call hbzy_Z6zZ(hbzy_Z60Z,hbzy_Z56Z,hbzy_Zz6Z,false)
endfunction
function hbzy_Z62Z takes unit hbzy_Z32Z,integer hbzy_Z29Z,boolean hbzy_Z63Z returns nothing
local integer hbzy_Z23Z
set hbzy_Z23Z=GetResourceAmount(hbzy_Z32Z)
if(hbzy_Z63Z)then
set hbzy_Z23Z=hbzy_Z23Z+hbzy_Z29Z
else
set hbzy_Z23Z=hbzy_Z23Z-hbzy_Z29Z
endif
if(hbzy_Z23Z<0)then
if(hbzy_Z63Z)then
set hbzy_Z23Z=GetResourceAmount(hbzy_Z32Z)
else
set hbzy_Z23Z=0
endif
endif
call SetResourceAmount(hbzy_Z32Z,hbzy_Z23Z)
endfunction
function hbzy_Z64Z takes integer hbzy_Z29Z,player hbzy_Z28Z,boolean hbzy_Z65Z returns nothing
if(hbzy_Z65Z)then
call SetPlayerTechMaxAllowed(hbzy_Z28Z,1212502607,50000)
else
call SetPlayerTechMaxAllowed(hbzy_Z28Z,1212502607,3)
endif
endfunction
function hbzy_Z66Z takes integer hbzy_Z29Z,boolean hbzy_Z48Z returns nothing
if(hbzy_Z48Z)then
call EnableTrigger(hbzy_z00[hbzy_Z29Z])
call EnableTrigger(hbzy_z10[hbzy_Z29Z])
call EnableTrigger(hbzy_z20[hbzy_Z29Z])
call EnableTrigger(hbzy_z30[hbzy_Z29Z])
call EnableTrigger(hbzy_Z70[hbzy_Z29Z])
call EnableTrigger(hbzy_Z80[hbzy_Z29Z])
call EnableTrigger(hbzy_Z90[hbzy_Z29Z])
call EnableTrigger(hbzy_zZ0[hbzy_Z29Z])
call EnableTrigger(hbzy_zz0[hbzy_Z29Z])
else
call DisableTrigger(hbzy_z00[hbzy_Z29Z])
call DisableTrigger(hbzy_z10[hbzy_Z29Z])
call DisableTrigger(hbzy_z20[hbzy_Z29Z])
call DisableTrigger(hbzy_z30[hbzy_Z29Z])
call DisableTrigger(hbzy_Z70[hbzy_Z29Z])
call DisableTrigger(hbzy_Z80[hbzy_Z29Z])
call DisableTrigger(hbzy_Z90[hbzy_Z29Z])
call DisableTrigger(hbzy_zZ0[hbzy_Z29Z])
call DisableTrigger(hbzy_zz0[hbzy_Z29Z])
endif
endfunction
function hbzy_Z67Z takes integer hbzy_Z29Z,boolean hbzy_Z68Z returns nothing
if(hbzy_Z68Z)then
call EnableTrigger(hbzy_Z40[hbzy_Z29Z])
call EnableTrigger(hbzy_Z60[hbzy_Z29Z])
call EnableTrigger(hbzy_Z6z[hbzy_Z29Z])
else
call DisableTrigger(hbzy_Z40[hbzy_Z29Z])
call DisableTrigger(hbzy_Z60[hbzy_Z29Z])
call DisableTrigger(hbzy_Z6z[hbzy_Z29Z])
endif
endfunction
function hbzy_Z69Z takes nothing returns nothing
local integer hbzy_Z29Z
set hbzy_Z29Z=0
loop
exitwhen hbzy_Z29Z>11
call hbzy_Z66Z(hbzy_Z29Z,false)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endfunction
function hbzy_Z7ZZ takes integer hbzy_Z29Z returns nothing
set hbzy_z6[hbzy_Z29Z]=false
call GroupClear(hbzy_Z8Z[hbzy_Z29Z])
if(hbzy_Z7Z)then
call DestroyFogModifier(hbzy_Z6[hbzy_Z29Z])
endif
call DisableTrigger(hbzy_Z30[hbzy_Z29Z])
call DisableTrigger(hbzy_Z50[hbzy_Z29Z])
call DisableTrigger(hbzy_zz1[hbzy_Z29Z])
call DisableTrigger(hbzy_z40[hbzy_Z29Z])
call DisableTrigger(hbzy_z50[hbzy_Z29Z])
call DisableTrigger(hbzy_z60[hbzy_Z29Z])
call DisableTrigger(hbzy_z70[hbzy_Z29Z])
call DisableTrigger(hbzy_z80[hbzy_Z29Z])
call DisableTrigger(hbzy_z90[hbzy_Z29Z])
call DisableTrigger(hbzy_ZZ3[hbzy_Z29Z])
call DisableTrigger(hbzy_ZZ1[hbzy_Z29Z])
call DisableTrigger(hbzy_Zz1[hbzy_Z29Z])
call DisableTrigger(hbzy_Zz2[hbzy_Z29Z])
call DisableTrigger(hbzy_Z01[hbzy_Z29Z])
call DisableTrigger(hbzy_Z81[hbzy_Z29Z])
call DisableTrigger(hbzy_Z21[hbzy_Z29Z])
call DisableTrigger(hbzy_Z51[hbzy_Z29Z])
call DisableTrigger(hbzy_Z41[hbzy_Z29Z])
call DisableTrigger(hbzy_Z61[hbzy_Z29Z])
call DisableTrigger(hbzy_Z12[hbzy_Z29Z])
call DisableTrigger(hbzy_Z02[hbzy_Z29Z])
call DisableTrigger(hbzy_Z71[hbzy_Z29Z])
call DisableTrigger(hbzy_Z31[hbzy_Z29Z])
call DisableTrigger(hbzy_Z22[hbzy_Z29Z])
call DisableTrigger(hbzy_Z11[hbzy_Z29Z])
call DisableTrigger(hbzy_Z23[hbzy_Z29Z])
call DisableTrigger(hbzy_Z13[hbzy_Z29Z])
call DisableTrigger(hbzy_zZ3[hbzy_Z29Z])
call DisableTrigger(hbzy_Z40[hbzy_Z29Z])
call DisableTrigger(hbzy_Z60[hbzy_Z29Z])
call DisableTrigger(hbzy_Z6z[hbzy_Z29Z])
call hbzy_Z66Z(hbzy_Z29Z,false)
endfunction
function hbzy_Z7zZ takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
set hbzy_z6[hbzy_Z29Z]=true
if(hbzy_Z3z[hbzy_Z29Z])then
else
call hbzy_Z26Z(hbzy_Z29Z,hbzy_Z28Z)
endif
call EnableTrigger(hbzy_Z30[hbzy_Z29Z])
call EnableTrigger(hbzy_Z50[hbzy_Z29Z])
call EnableTrigger(hbzy_zz1[hbzy_Z29Z])
call hbzy_Z66Z(hbzy_Z29Z,true)
endfunction
function hbzy_Z70Z takes integer hbzy_Z29Z,boolean hbzy_Z71Z returns nothing
if(hbzy_Z71Z)then
if((hbzy_zZZ[hbzy_Z29Z])and(hbzy_zzZ[hbzy_Z29Z])and(hbzy_z31[hbzy_Z29Z]))then
call EnableTrigger(hbzy_z01[hbzy_Z29Z])
call EnableTrigger(hbzy_z11[hbzy_Z29Z])
call EnableTrigger(hbzy_z21[hbzy_Z29Z])
endif
else
call DisableTrigger(hbzy_z01[hbzy_Z29Z])
call DisableTrigger(hbzy_z11[hbzy_Z29Z])
call DisableTrigger(hbzy_z21[hbzy_Z29Z])
endif
endfunction
function hbzy_Z72Z takes integer hbzy_Z38Z returns nothing
if(hbzy_Z38Z==0)then
set hbzy_zz2=0
return
endif
if(hbzy_Z38Z==1)then
set hbzy_zz2=10
return
endif
if(hbzy_Z38Z==2)then
set hbzy_zz2=15
return
endif
if(hbzy_Z38Z==3)then
set hbzy_zz2=20
return
endif
if(hbzy_Z38Z==4)then
set hbzy_zz2=40
return
endif
if(hbzy_Z38Z==5)then
set hbzy_zz2=50
return
endif
if(hbzy_Z38Z==6)then
set hbzy_zz2=70
return
endif
if(hbzy_Z38Z==7)then
set hbzy_zz2=80
return
endif
if(hbzy_Z38Z==8)then
set hbzy_zz2=90
return
endif
if(hbzy_Z38Z==9)then
set hbzy_zz2=100
return
endif
endfunction
function hbzy_Z73Z takes unit hbzy_Z32Z,integer hbzy_Z74Z,integer hbzy_Z75Z returns nothing
call hbzy_Z72Z(hbzy_Z75Z)
call hbzy_Z37Z(hbzy_Z74Z)
call hbzy_zZ7(hbzy_Z32Z,hbzy_zZ2,hbzy_Z92,hbzy_Z82,hbzy_zz2)
endfunction
function hbzy_Z76Z takes integer hbzy_Z74Z,integer hbzy_Z75Z returns nothing
call hbzy_Z72Z(hbzy_Z75Z)
call hbzy_Z37Z(hbzy_Z74Z)
call hbzy_zz7(hbzy_zZ2,hbzy_Z92,hbzy_Z82,hbzy_zz2)
endfunction
function hbzy_Z77Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call hbzy_Z73Z(hbzy_Z32Z,GetRandomInt(3,9),0)
set hbzy_Z32Z=null
endfunction
function hbzy_Z78Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call hbzy_Z73Z(hbzy_Z32Z,0,0)
set hbzy_Z32Z=null
endfunction
function hbzy_Z79Z takes integer hbzy_Z29Z,boolean hbzy_Z71Z returns nothing
local integer hbzy_Z23Z
local integer hbzy_Z8ZZ
if(hbzy_Z53[hbzy_Z29Z]==hbzy_Z71Z)then
else
set hbzy_Z53[hbzy_Z29Z]=hbzy_Z71Z
if(hbzy_Z71Z)then
call EnableTrigger(hbzy_z83)
else
set hbzy_Z23Z=0
set hbzy_Z8ZZ=0
loop
exitwhen hbzy_Z23Z>11
if(hbzy_Z53[hbzy_Z23Z])then
set hbzy_Z8ZZ=hbzy_Z8ZZ+1
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
if(hbzy_Z8ZZ==0)then
call DisableTrigger(hbzy_z83)
endif
endif
endif
endfunction
function hbzy_Z8zZ takes integer hbzy_Z80Z returns nothing
if(hbzy_Z80Z==0)then
call SetSkyModel(null)
return
endif
if(hbzy_Z80Z==1)then
call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
return
endif
if(hbzy_Z80Z==2)then
call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
return
endif
if(hbzy_Z80Z==3)then
call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
return
endif
if(hbzy_Z80Z==4)then
call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
return
endif
if(hbzy_Z80Z==5)then
call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
return
endif
if(hbzy_Z80Z==6)then
call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
return
endif
if(hbzy_Z80Z==7)then
call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
return
endif
if(hbzy_Z80Z==8)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
return
endif
if(hbzy_Z80Z==9)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyBrightGreen\\LordaeronWinterSkyBrightGreen.mdl")
return
endif
if(hbzy_Z80Z==10)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPink\\LordaeronWinterSkyPink.mdl")
return
endif
if(hbzy_Z80Z==11)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyPurple\\LordaeronWinterSkyPurple.mdl")
return
endif
if(hbzy_Z80Z==12)then
call SetSkyModel("Environment\\Sky\\LordaeronWinterSkyYellow\\LordaeronWinterSkyYellow.mdl")
return
endif
if(hbzy_Z80Z==13)then
call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
return
endif
endfunction
function hbzy_Z81Z takes integer hbzy_Z82Z returns integer
if(hbzy_Z82Z==0)then
return 1380018290
endif
if(hbzy_Z82Z==1)then
return 1380019314
endif
if(hbzy_Z82Z==2)then
return 1296393331
endif
if(hbzy_Z82Z==3)then
return 1178886760
endif
if(hbzy_Z82Z==4)then
return 1178886764
endif
if(hbzy_Z82Z==5)then
return 1178888040
endif
if(hbzy_Z82Z==6)then
return 1178888044
endif
if(hbzy_Z82Z==7)then
return 1178890856
endif
if(hbzy_Z82Z==8)then
return 1178890860
endif
if(hbzy_Z82Z==9)then
return 1178892136
endif
if(hbzy_Z82Z==10)then
return 1178892140
endif
if(hbzy_Z82Z==11)then
return 1380739186
endif
if(hbzy_Z82Z==12)then
return 1380740210
endif
if(hbzy_Z82Z==13)then
return 1397645939
endif
if(hbzy_Z82Z==14)then
return 1397647475
endif
if(hbzy_Z82Z==15)then
return 1397648499
endif
if(hbzy_Z82Z==16)then
return 1464820599
endif
if(hbzy_Z82Z==17)then
return 1464822903
endif
if(hbzy_Z82Z==18)then
return 1280467297
endif
if(hbzy_Z82Z==19)then
return 1280470369
endif
if(hbzy_Z82Z==20)then
return 1464755063
endif
return 0
endfunction
function hbzy_Z83Z takes integer hbzy_Z82Z,boolean hbzy_Z71Z returns nothing
set hbzy_Z82Z=hbzy_Z82Z-1
if(hbzy_Z71Z)then
if(hbzy_z12[hbzy_Z82Z]==false)then
if(hbzy_Z81Z(hbzy_Z82Z)==0)then
else
set hbzy_z02[hbzy_Z82Z]=AddWeatherEffect(hbzy_z8,hbzy_Z81Z(hbzy_Z82Z))
call EnableWeatherEffect(hbzy_z02[hbzy_Z82Z],true)
set hbzy_z12[hbzy_Z82Z]=true
endif
endif
else
if(hbzy_z02[hbzy_Z82Z]==null)then
else
call EnableWeatherEffect(hbzy_z02[hbzy_Z82Z],false)
call RemoveWeatherEffect(hbzy_z02[hbzy_Z82Z])
set hbzy_z12[hbzy_Z82Z]=false
set hbzy_z02[hbzy_Z82Z]=null
endif
endif
endfunction
function hbzy_Z84Z takes nothing returns nothing
local integer hbzy_Z29Z=1
loop
exitwhen hbzy_Z29Z>21
call hbzy_Z83Z(hbzy_Z29Z,false)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endfunction
function hbzy_Z85Z takes integer hbzy_Z86Z returns integer
if(hbzy_Z86Z==0)then
return 1280601204
endif
if(hbzy_Z86Z==1)then
return 1179939959
endif
if(hbzy_Z86Z==2)then
return 1465152631
endif
if(hbzy_Z86Z==3)then
return 1096053874
endif
if(hbzy_Z86Z==4)then
return 1096053859
endif
if(hbzy_Z86Z==5)then
return 1112831095
endif
if(hbzy_Z86Z==6)then
return 1263826039
endif
if(hbzy_Z86Z==7)then
return 1498707828
endif
if(hbzy_Z86Z==8)then
return 1498702708
endif
if(hbzy_Z86Z==9)then
return 1498703476
endif
if(hbzy_Z86Z==10)then
return 1498706804
endif
if(hbzy_Z86Z==11)then
return 1247044468
endif
if(hbzy_Z86Z==12)then
return 1247048823
endif
if(hbzy_Z86Z==13)then
return 1146385256
endif
if(hbzy_Z86Z==14)then
return 1129608306
endif
if(hbzy_Z86Z==15)then
return 1129608291
endif
if(hbzy_Z86Z==16)then
return 1230271607
endif
if(hbzy_Z86Z==17)then
return 1230271607
endif
if(hbzy_Z86Z==18)then
return 1314157667
endif
if(hbzy_Z86Z==19)then
return 1330934903
endif
if(hbzy_Z86Z==20)then
return 1515484279
endif
if(hbzy_Z86Z==21)then
return 1196716904
endif
if(hbzy_Z86Z==22)then
return 1448373364
endif
if(hbzy_Z86Z==23)then
return 1448373364
endif
return 0
endfunction
function hbzy_Z87Z takes nothing returns integer
return hbzy_Z85Z(GetRandomInt(0,23))
endfunction
function hbzy_Z88Z takes unit hbzy_Z32Z,integer hbzy_Z89Z,integer hbzy_Z86Z,integer hbzy_Z9ZZ returns nothing
local real hbzy_Z9zZ
local real hbzy_Z90Z
local real hbzy_Z29Z=0
local boolean hbzy_Z91Z=true
set hbzy_Z9zZ=GetUnitX(hbzy_Z32Z)
set hbzy_Z90Z=GetUnitY(hbzy_Z32Z)
if(hbzy_Z89Z==1)then
loop
exitwhen hbzy_Z29Z==hbzy_Z9ZZ
if(hbzy_Z91Z)then
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ,hbzy_Z90Z+hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ,hbzy_Z90Z-hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
endif
set hbzy_Z91Z=not(hbzy_Z91Z)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endif
if(hbzy_Z89Z==2)then
loop
exitwhen hbzy_Z29Z==hbzy_Z9ZZ
if(hbzy_Z91Z)then
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ+hbzy_Z29Z*40,hbzy_Z90Z,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ-hbzy_Z29Z*40,hbzy_Z90Z,GetRandomReal(0,360),1,0)
endif
set hbzy_Z91Z=not(hbzy_Z91Z)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endif
if(hbzy_Z89Z==3)then
loop
exitwhen hbzy_Z29Z==hbzy_Z9ZZ
if(hbzy_Z91Z)then
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ+hbzy_Z29Z*40,hbzy_Z90Z+hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ-hbzy_Z29Z*40,hbzy_Z90Z-hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
endif
set hbzy_Z91Z=not(hbzy_Z91Z)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endif
if(hbzy_Z89Z==4)then
loop
exitwhen hbzy_Z29Z==hbzy_Z9ZZ
if(hbzy_Z91Z)then
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ+hbzy_Z29Z*40,hbzy_Z90Z-hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
else
call CreateDestructable(hbzy_Z86Z,hbzy_Z9zZ-hbzy_Z29Z*40,hbzy_Z90Z+hbzy_Z29Z*40,GetRandomReal(0,360),1,0)
endif
set hbzy_Z91Z=not(hbzy_Z91Z)
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
endif
endfunction
function hbzy_Z92Z takes integer hbzy_Z29Z returns nothing
set hbzy_Z7[hbzy_Z29Z]=true
call hbzy_z56(hbzy_z0Z[hbzy_Z29Z],false,2.)
endfunction
function hbzy_Z93Z takes integer hbzy_Z29Z,boolean hbzy_Z94Z returns nothing
local integer hbzy_Z23Z
local integer hbzy_Z53Z
local item hbzy_Z54Z
local location hbzy_Z35Z
local unit hbzy_Z32Z
set hbzy_Z32Z=hbzy_z7[hbzy_Z29Z]
set hbzy_Z53Z=1
loop
exitwhen hbzy_Z53Z>6
if(hbzy_Z94Z)then
set hbzy_Z35Z=GetUnitLoc(hbzy_z51[hbzy_Z29Z])
else
set hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
endif
set hbzy_Z54Z=hbzy_Z85(hbzy_Z32Z,hbzy_Z53Z)
if(GetItemCharges(hbzy_Z54Z)>0)then
set hbzy_Z23Z=GetItemCharges(hbzy_Z54Z)
set hbzy_Z54Z=hbzy_z07(GetItemTypeId(hbzy_Z54Z),hbzy_Z35Z)
call SetItemCharges(hbzy_Z54Z,hbzy_Z23Z)
else
call hbzy_z07(GetItemTypeId(hbzy_Z54Z),hbzy_Z35Z)
endif
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z53Z=hbzy_Z53Z+1
endloop
set hbzy_Z32Z=null
set hbzy_Z35Z=null
set hbzy_Z54Z=null
endfunction
function hbzy_Z95Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local integer hbzy_Z23Z
local force hbzy_Z96Z
local player hbzy_Z22Z
if(hbzy_z1Z[hbzy_Z29Z])then
call DestroyFogModifier(hbzy_Z6[hbzy_Z29Z])
set hbzy_z1Z[hbzy_Z29Z]=false
else
set hbzy_Z96Z=CreateForce()
set hbzy_Z23Z=0
loop
exitwhen hbzy_Z23Z>11
set hbzy_Z22Z=Player(hbzy_Z23Z)
if(GetPlayerAlliance(hbzy_Z28Z,hbzy_Z22Z,ALLIANCE_SHARED_VISION))then
call ForceAddPlayer(hbzy_Z96Z,hbzy_Z22Z)
call SetPlayerAlliance(hbzy_Z28Z,hbzy_Z22Z,ALLIANCE_SHARED_VISION,false)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z6[hbzy_Z29Z]=CreateFogModifierRect(hbzy_Z28Z,FOG_OF_WAR_VISIBLE,hbzy_z8,false,false)
call FogModifierStart(hbzy_Z6[hbzy_Z29Z])
set hbzy_z1Z[hbzy_Z29Z]=true
set hbzy_Z23Z=0
loop
exitwhen hbzy_Z23Z>11
set hbzy_Z22Z=Player(hbzy_Z23Z)
if(IsPlayerInForce(hbzy_Z22Z,hbzy_Z96Z))then
call SetPlayerAlliance(hbzy_Z28Z,hbzy_Z22Z,ALLIANCE_SHARED_VISION,true)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
call DestroyForce(hbzy_Z96Z)
set hbzy_Z96Z=null
set hbzy_Z22Z=null
endif
endfunction
function hbzy_Z97Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local integer hbzy_Z23Z
local unit hbzy_Z32Z
local item hbzy_Z54Z
local item array hbzy_Z98Z
set hbzy_Z32Z=FirstOfGroup(hbzy_Z8Z[hbzy_Z29Z])
if((hbzy_Z28Z==GetOwningPlayer(hbzy_Z32Z))and(hbzy_Z35(hbzy_Z32Z)>0))then
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>6
set hbzy_Z54Z=hbzy_Z85(hbzy_Z32Z,hbzy_Z23Z)
set hbzy_Z98Z[(hbzy_Z23Z-1)]=hbzy_Z54Z
call hbzy_z37(hbzy_Z54Z,hbzy_Z32Z)
call SetItemVisible(hbzy_Z54Z,false)
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>6
set hbzy_Z54Z=hbzy_Z2z[(hbzy_Z29Z*18)+(hbzy_Z4z[hbzy_Z29Z]*6)+(hbzy_Z23Z-1)]
call UnitAddItem(hbzy_Z32Z,hbzy_Z54Z)
set hbzy_Z2z[(hbzy_Z29Z*18)+(hbzy_Z4z[hbzy_Z29Z]*6)+(hbzy_Z23Z-1)]=hbzy_Z98Z[(hbzy_Z23Z-1)]
set hbzy_Z98Z[(hbzy_Z23Z-1)]=null
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
if(hbzy_Z4z[hbzy_Z29Z]==0)then
set hbzy_Z4z[hbzy_Z29Z]=hbzy_z61-1
else
set hbzy_Z4z[hbzy_Z29Z]=(hbzy_Z4z[hbzy_Z29Z]-1)
endif
set hbzy_Z54Z=null
endif
set hbzy_Z32Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_Z99Z takes unit hbzy_Z32Z returns nothing
local integer hbzy_Z23Z
local item hbzy_Z54Z
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>6
set hbzy_Z54Z=hbzy_Z85(hbzy_Z32Z,hbzy_Z23Z)
call hbzy_z37(hbzy_Z54Z,hbzy_Z32Z)
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z54Z=null
endfunction
function hbzy_zZZZ takes integer hbzy_Z29Z returns nothing
local integer hbzy_Z23Z
local item hbzy_Z54Z
local location hbzy_Z35Z
set hbzy_Z35Z=GetUnitLoc(hbzy_z51[hbzy_Z29Z])
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>6
set hbzy_Z54Z=hbzy_Z85(hbzy_z7[hbzy_Z29Z],hbzy_Z23Z)
call hbzy_z37(hbzy_Z54Z,hbzy_z7[hbzy_Z29Z])
call hbzy_Z55(hbzy_Z54Z,hbzy_Z35Z)
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z54Z=null
set hbzy_Z35Z=null
endfunction
function hbzy_zZzZ takes integer hbzy_Z29Z returns nothing
local integer hbzy_Z53Z
local integer hbzy_Z91Z
local unit hbzy_Z32Z
local item hbzy_Z42Z
local item hbzy_zZ0Z
set hbzy_Z32Z=FirstOfGroup(hbzy_Z8Z[hbzy_Z29Z])
set hbzy_Z53Z=1
loop
exitwhen hbzy_Z53Z>5
set hbzy_Z42Z=hbzy_Z85(hbzy_Z32Z,hbzy_Z53Z)
if(GetItemCharges(hbzy_Z42Z)>0)then
set hbzy_Z91Z=hbzy_Z53Z+1
loop
exitwhen hbzy_Z91Z>6
set hbzy_zZ0Z=hbzy_Z85(hbzy_Z32Z,hbzy_Z91Z)
if(GetItemTypeId(hbzy_Z42Z)==GetItemTypeId(hbzy_zZ0Z))then
call SetItemCharges(hbzy_Z42Z,(GetItemCharges(hbzy_Z42Z)+GetItemCharges(hbzy_zZ0Z)))
call RemoveItem(hbzy_zZ0Z)
endif
set hbzy_Z91Z=hbzy_Z91Z+1
endloop
endif
set hbzy_Z53Z=hbzy_Z53Z+1
endloop
set hbzy_Z42Z=null
set hbzy_zZ0Z=null
set hbzy_Z32Z=null
endfunction
function hbzy_zZ1Z takes integer hbzy_Z29Z,integer hbzy_Z23Z returns nothing
local unit hbzy_Z32Z
local item hbzy_Z54Z
set hbzy_Z32Z=FirstOfGroup(hbzy_Z8Z[hbzy_Z29Z])
set hbzy_Z54Z=hbzy_Z85(hbzy_Z32Z,1)
call SetItemCharges(hbzy_Z54Z,(GetItemCharges(hbzy_Z54Z)+hbzy_Z23Z))
set hbzy_Z54Z=null
set hbzy_Z32Z=null
endfunction
function hbzy_zZ2Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call GroupAddUnit(hbzy_z8Z,hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_zZ3Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call GroupRemoveUnit(hbzy_z8Z,hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_zZ4Z takes nothing returns nothing
local unit hbzy_Z32Z=GetTriggerUnit()
if((hbzy_z47(hbzy_Z32Z))and(IsUnitType(hbzy_Z32Z,UNIT_TYPE_HERO)))then
call GroupRemoveUnit(hbzy_z8Z,hbzy_Z32Z)
endif
endfunction
function hbzy_zZ5Z takes nothing returns nothing
call ForGroup(hbzy_z8Z,function hbzy_zZ4Z)
endfunction
function hbzy_zZ6Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call ReviveHeroLoc(hbzy_Z32Z,hbzy_Z9Z[hbzy_Zzz],true)
call hbzy_z57(hbzy_Z32Z,100)
set hbzy_Z32Z=null
endfunction
function hbzy_zZ7Z takes player hbzy_Z28Z returns nothing
local group hbzy_Z50Z
call GroupEnumUnitsOfPlayer(hbzy_Z50Z,hbzy_Z28Z,null)
set hbzy_Zzz=GetPlayerId(hbzy_Z28Z)
call ForGroup(hbzy_Z50Z,function hbzy_zZ6Z)
call DestroyGroup(hbzy_Z50Z)
set hbzy_Z50Z=null
endfunction
function hbzy_zZ8Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_Z87(hbzy_z81,hbzy_Z32Z,hbzy_z91,hbzy_z71)
set hbzy_Z32Z=null
endfunction
function hbzy_zZ9Z takes integer hbzy_Z29Z,integer hbzy_zzZZ,integer hbzy_z75,boolean hbzy_Z3ZZ returns nothing
local integer hbzy_zzzZ
if(hbzy_Z3ZZ)then
set hbzy_zzzZ=0
else
set hbzy_zzzZ=1
endif
if(hbzy_Z0)then
set hbzy_z91=hbzy_zzzZ
set hbzy_z81=hbzy_zzZZ
set hbzy_z71=hbzy_z75
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_zZ8Z)
else
call hbzy_Z87(hbzy_zzZZ,hbzy_z7[hbzy_Z29Z],hbzy_zzzZ,hbzy_z75)
endif
endfunction
function hbzy_zz0Z takes unit hbzy_Z32Z,integer hbzy_z75,boolean hbzy_Z3ZZ returns nothing
local integer hbzy_Z29Z
set hbzy_Z29Z=GetHeroLevel(hbzy_Z32Z)
if(hbzy_Z3ZZ)then
set hbzy_Z29Z=hbzy_Z29Z+hbzy_z75
else
set hbzy_Z29Z=hbzy_Z29Z-hbzy_z75
endif
call hbzy_Zz7(hbzy_Z32Z,hbzy_Z29Z,false)
endfunction
function hbzy_zz1Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_zz0Z(hbzy_Z32Z,hbzy_ZZ2,hbzy_Z1z)
set hbzy_Z32Z=null
endfunction
function hbzy_zz2Z takes integer hbzy_Z29Z,integer hbzy_z75,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_ZZ2=hbzy_z75
set hbzy_Z1z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_zz1Z)
else
call hbzy_zz0Z(hbzy_z7[hbzy_Z29Z],hbzy_z75,hbzy_Z3ZZ)
endif
endfunction
function hbzy_zz3Z takes string hbzy_Z08 returns integer
local string hbzy_zz4Z="0123456789"
local string hbzy_zz5Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hbzy_zz6Z="abcdefghijklmnopqrstuvwxyz"
local integer hbzy_id=0
local integer hbzy_zz7Z=1
local integer hbzy_zz8Z=1
loop
exitwhen hbzy_zz7Z>StringLength(hbzy_Z08)
loop
exitwhen hbzy_zz8Z>10
if SubString(hbzy_Z08,hbzy_zz7Z-1,hbzy_zz7Z)==SubString(hbzy_zz4Z,hbzy_zz8Z-1,hbzy_zz8Z)then
set hbzy_id=hbzy_id+R2I((48+hbzy_zz8Z-1)*Pow(256.,I2R(StringLength(hbzy_Z08)-hbzy_zz7Z)))
set hbzy_zz8Z=hbzy_zz8Z+1
else
set hbzy_zz8Z=hbzy_zz8Z+1
endif
endloop
set hbzy_zz8Z=1
loop
exitwhen hbzy_zz8Z>26
if SubString(hbzy_Z08,hbzy_zz7Z-1,hbzy_zz7Z)==SubString(hbzy_zz5Z,hbzy_zz8Z-1,hbzy_zz8Z)then
set hbzy_id=hbzy_id+R2I(I2R(65+hbzy_zz8Z-1)*Pow(256.,I2R(StringLength(hbzy_Z08)-hbzy_zz7Z)))
set hbzy_zz8Z=hbzy_zz8Z+1
else
set hbzy_zz8Z=hbzy_zz8Z+1
endif
endloop
set hbzy_zz8Z=1
loop
exitwhen hbzy_zz8Z>26
if SubString(hbzy_Z08,hbzy_zz7Z-1,hbzy_zz7Z)==SubString(hbzy_zz6Z,hbzy_zz8Z-1,hbzy_zz8Z)then
set hbzy_id=hbzy_id+R2I((97+hbzy_zz8Z-1)*Pow(256.,I2R(StringLength(hbzy_Z08)-hbzy_zz7Z)))
set hbzy_zz8Z=hbzy_zz8Z+1
else
set hbzy_zz8Z=hbzy_zz8Z+1
endif
endloop
set hbzy_zz8Z=1
set hbzy_zz7Z=hbzy_zz7Z+1
endloop
return hbzy_id
endfunction
function hbzy_zz9Z takes integer hbzy_z0ZZ returns string
local string hbzy_zz4Z="0123456789"
local string hbzy_zz5Z="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string hbzy_zz6Z="abcdefghijklmnopqrstuvwxyz"
local string hbzy_ZZ7Z=""
local integer hbzy_zz7Z=0
local integer hbzy_z0zZ=0
loop
exitwhen hbzy_z0ZZ==0
set hbzy_zz7Z=hbzy_z77(hbzy_z0ZZ,256)
if hbzy_zz7Z>=48 and hbzy_zz7Z<=57 then
set hbzy_z0zZ=hbzy_zz7Z-48
set hbzy_ZZ7Z=SubString(hbzy_zz4Z,hbzy_z0zZ,hbzy_z0zZ+1)+hbzy_ZZ7Z
endif
if hbzy_zz7Z>=65 and hbzy_zz7Z<=90 then
set hbzy_z0zZ=hbzy_zz7Z-65
set hbzy_ZZ7Z=SubString(hbzy_zz5Z,hbzy_z0zZ,hbzy_z0zZ+1)+hbzy_ZZ7Z
endif
if hbzy_zz7Z>=97 and hbzy_zz7Z<=122 then
set hbzy_z0zZ=hbzy_zz7Z-97
set hbzy_ZZ7Z=SubString(hbzy_zz6Z,hbzy_z0zZ,hbzy_z0zZ+1)+hbzy_ZZ7Z
endif
set hbzy_z0ZZ=hbzy_z0ZZ/256
endloop
return hbzy_ZZ7Z
endfunction
function hbzy_z00Z takes unit hbzy_Z32Z returns string
local integer hbzy_Z29Z
set hbzy_Z29Z=GetUnitTypeId(hbzy_Z32Z)
if(hbzy_Z29Z==0)then
return""
else
return hbzy_zz9Z(hbzy_Z29Z)
endif
endfunction
function hbzy_z01Z takes unit hbzy_Z32Z returns string
local item hbzy_Z54Z=hbzy_Z85(hbzy_Z32Z,1)
local integer hbzy_Z29Z=GetItemTypeId(hbzy_Z54Z)
if(hbzy_Z29Z==0)then
return""
else
set hbzy_Z54Z=null
return hbzy_zz9Z(hbzy_Z29Z)
endif
endfunction
function hbzy_z02Z takes integer hbzy_z03Z returns integer
local string hbzy_z04Z=GetEventPlayerChatString()
if(StringLength(hbzy_z04Z)==hbzy_z03Z+3)then
return(hbzy_zz3Z(hbzy_Zz8(hbzy_z04Z,hbzy_z03Z,hbzy_z03Z+3)))
else
return 0
endif
endfunction
function hbzy_z05Z takes unit hbzy_Z32Z,integer hbzy_Z52Z,boolean hbzy_Z3ZZ returns nothing
local location hbzy_Z35Z
local integer hbzy_Z29Z
set hbzy_Z29Z=hbzy_z02Z(hbzy_Z52Z)
if(hbzy_Z29Z==0)then
else
if(hbzy_Z3ZZ)then
set hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
call hbzy_z07(hbzy_Z29Z,hbzy_Z35Z)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
else
call UnitAddItemById(hbzy_Z32Z,hbzy_Z29Z)
endif
endif
endfunction
function hbzy_z06Z takes unit hbzy_Z32Z,real hbzy_z07Z,boolean hbzy_Z3ZZ returns nothing
local location hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
local player hbzy_Z28Z=GetOwningPlayer(hbzy_Z32Z)
call hbzy_zZ5(hbzy_Z3ZZ,hbzy_Z28Z,hbzy_Z35Z,hbzy_z07Z)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_z08Z takes unit hbzy_Z32Z,real hbzy_z07Z returns nothing
call SetUnitFlyHeight(hbzy_Z32Z,hbzy_z07Z,.0)
endfunction
function hbzy_z09Z takes nothing returns integer
local integer hbzy_z1ZZ=0
local integer hbzy_z1zZ=0
local integer array hbzy_z10Z
local integer hbzy_Z29Z=0
local player hbzy_Z28Z=GetLocalPlayer()
loop
exitwhen hbzy_Z29Z>11
set hbzy_z10Z[hbzy_Z29Z]=0
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
loop
exitwhen hbzy_z1ZZ>14
call StoreInteger(hbzy_z03,"Hke_Player","Hke_number",GetPlayerId(hbzy_Z28Z)+1)
call TriggerSyncStart()
call SyncStoredInteger(hbzy_z03,"Hke_Player","Hke_number")
call TriggerSyncReady()
set hbzy_z1zZ=GetStoredInteger(hbzy_z03,"Hke_Player","Hke_number")-1
set hbzy_z10Z[hbzy_z1zZ]=hbzy_z10Z[hbzy_z1zZ]+1
call FlushStoredMission(hbzy_z03,"Hke_Player")
set hbzy_z1ZZ=hbzy_z1ZZ+1
endloop
set hbzy_z1zZ=0
set hbzy_z1ZZ=0
set hbzy_Z28Z=null
loop
exitwhen hbzy_z1ZZ>11
if hbzy_z10Z[hbzy_z1zZ]<hbzy_z10Z[hbzy_z1ZZ]then
set hbzy_z1zZ=hbzy_z1ZZ
endif
set hbzy_z1ZZ=hbzy_z1ZZ+1
endloop
return hbzy_z1zZ+1
endfunction
function hbzy_z11Z takes unit hbzy_Z32Z,integer hbzy_z12Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z3ZZ)then
call UnitAddAbility(hbzy_Z32Z,hbzy_z12Z)
call SetUnitAbilityLevel(hbzy_Z32Z,hbzy_z12Z,100)
call UnitMakeAbilityPermanent(hbzy_Z32Z,true,hbzy_z12Z)
else
call UnitMakeAbilityPermanent(hbzy_Z32Z,false,hbzy_z12Z)
call UnitRemoveAbility(hbzy_Z32Z,hbzy_z12Z)
endif
endfunction
function hbzy_z13Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_z11Z(hbzy_Z32Z,hbzy_zzz,hbzy_z0z)
set hbzy_Z32Z=null
endfunction
function hbzy_z14Z takes integer hbzy_Z29Z,integer hbzy_z12Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_zzz=hbzy_z12Z
set hbzy_z0z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z13Z)
else
call hbzy_z11Z(hbzy_z7[hbzy_Z29Z],hbzy_z12Z,hbzy_Z3ZZ)
endif
endfunction
function hbzy_z15Z takes string hbzy_z04Z returns integer
if(hbzy_z04Z=="mm")then
return 1094937907
endif
if(hbzy_z04Z=="xj")then
return 1095659625
endif
if(hbzy_z04Z=="zj")then
return 1095262824
endif
if(hbzy_z04Z=="zm")then
return 1095721842
endif
if(hbzy_z04Z=="ft")then
return 1096119411
endif
if(hbzy_z04Z=="xx")then
return 1095333473
endif
if(hbzy_z04Z=="sb")then
return 1095066998
endif
if(hbzy_z04Z=="yx")then
return 1097886070
endif
if(hbzy_z04Z=="rh")then
return 1095657827
endif
if(hbzy_z04Z=="fl")then
return 1095656289
endif
if(hbzy_z04Z=="bs")then
return 1094935923
endif
if(hbzy_z04Z=="jg")then
return 1095332984
endif
if(hbzy_z04Z=="jf")then
return 1095328816
endif
if(hbzy_z04Z=="js")then
return 1095332728
endif
if(hbzy_z04Z=="jm")then
return 1095332722
endif
if(hbzy_z04Z=="jj")then
return 1095917932
endif
if(hbzy_z04Z=="fy")then
return 1098150517
endif
if(hbzy_z04Z=="ghh")then
return 1095262562
endif
if(hbzy_z04Z=="ghj")then
return 1095721317
endif
if(hbzy_z04Z=="gqj")then
return 1095065970
endif
if(hbzy_z04Z=="gxx")then
return 1096114550
endif
if(hbzy_z04Z=="gzz")then
return 1095262564
endif
if(hbzy_z04Z=="gxe")then
return 1096114549
endif
if(hbzy_z04Z=="gjj")then
return 1095065960
endif
if(hbzy_z04Z=="gml")then
return 1094934883
endif
if(hbzy_z04Z=="gyl")then
return 1097818482
endif
if(hbzy_z04Z=="gjs")then
return 1096905580
endif
if(hbzy_z04Z=="qhy")then
return 1095329378
endif
if(hbzy_z04Z=="qdy")then
return 1095331938
endif
if(hbzy_z04Z=="qlh")then
return 1095332719
endif
if(hbzy_z04Z=="qyz")then
return 1095328878
endif
if(hbzy_z04Z=="qbd")then
return 1095331682
endif
if(hbzy_z04Z=="qfs")then
return 1095328610
endif
if(hbzy_z04Z=="qsd")then
return 1095330924
endif
if(hbzy_z04Z=="qjs")then
return 1095332706
endif
if(hbzy_z04Z=="qha")then
return 1095328870
endif
return 0
endfunction
function hbzy_z16Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call SetUnitInvulnerable(hbzy_Z32Z,hbzy_z0z)
call hbzy_z11Z(hbzy_Z32Z,1098282348,hbzy_z0z)
set hbzy_Z32Z=null
endfunction
function hbzy_z17Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z16Z)
else
call SetUnitInvulnerable(hbzy_z7[hbzy_Z29Z],hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_z7[hbzy_Z29Z],1098282348,hbzy_Z3ZZ)
endif
endfunction
function hbzy_z18Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call SetUnitPathing(hbzy_Z32Z,not(hbzy_z0z))
set hbzy_Z32Z=null
endfunction
function hbzy_z19Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z18Z)
else
call SetUnitPathing(hbzy_z7[hbzy_Z29Z],not(hbzy_Z3ZZ))
endif
endfunction
function hbzy_z2ZZ takes unit hbzy_Z32Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z3ZZ)then
call SetUnitMoveSpeed(hbzy_Z32Z,1000)
else
call SetUnitMoveSpeed(hbzy_Z32Z,GetUnitDefaultMoveSpeed(hbzy_Z32Z))
endif
endfunction
function hbzy_z2zZ takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_z2ZZ(hbzy_Z32Z,hbzy_z0z)
set hbzy_Z32Z=null
endfunction
function hbzy_z20Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z2zZ)
else
call hbzy_z2ZZ(hbzy_z7[hbzy_Z29Z],hbzy_Z3ZZ)
endif
endfunction
function hbzy_z21Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
call hbzy_zZ5Z()
if(hbzy_Z0)then
if(hbzy_Z3ZZ)then
if(hbzy_Z48(hbzy_z8Z)==0)then
call EnableTrigger(hbzy_z73)
endif
call hbzy_Z68(hbzy_Z8Z[hbzy_Z29Z],hbzy_z8Z)
else
call hbzy_zZ8(hbzy_Z8Z[hbzy_Z29Z],hbzy_z8Z)
if(hbzy_Z48(hbzy_z8Z)==0)then
call DisableTrigger(hbzy_z73)
endif
endif
else
if(hbzy_Z3ZZ)then
if(hbzy_Z48(hbzy_z8Z)==0)then
call EnableTrigger(hbzy_z73)
endif
call GroupAddUnit(hbzy_z8Z,hbzy_z7[hbzy_Z29Z])
else
call GroupRemoveUnit(hbzy_z8Z,hbzy_z7[hbzy_Z29Z])
if(hbzy_Z48(hbzy_z8Z)==0)then
call DisableTrigger(hbzy_z73)
endif
endif
endif
endfunction
function hbzy_z22Z takes unit hbzy_Z32Z,boolean hbzy_Z3ZZ returns nothing
call hbzy_z11Z(hbzy_Z32Z,1095262562,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1095721317,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1095065970,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1096114550,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1095262564,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1096114549,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1094934883,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1095065960,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1097818482,hbzy_Z3ZZ)
call hbzy_z11Z(hbzy_Z32Z,1096905580,hbzy_Z3ZZ)
endfunction
function hbzy_z23Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_z22Z(hbzy_Z32Z,hbzy_z0z)
set hbzy_Z32Z=null
endfunction
function hbzy_z24Z takes integer hbzy_Z29Z,boolean hbzy_Z3ZZ returns nothing
if(hbzy_Z0)then
set hbzy_z0z=hbzy_Z3ZZ
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z23Z)
else
call hbzy_z22Z(hbzy_z7[hbzy_Z29Z],hbzy_Z3ZZ)
endif
endfunction
function hbzy_z25Z takes unit hbzy_Z32Z returns nothing
call hbzy_z11Z(hbzy_Z32Z,1094937907,false)
call hbzy_z11Z(hbzy_Z32Z,1095659625,false)
call hbzy_z11Z(hbzy_Z32Z,1095262824,false)
call hbzy_z11Z(hbzy_Z32Z,1095721842,false)
call hbzy_z11Z(hbzy_Z32Z,1096119411,false)
call hbzy_z11Z(hbzy_Z32Z,1095333473,false)
call hbzy_z11Z(hbzy_Z32Z,1095066998,false)
call hbzy_z11Z(hbzy_Z32Z,1097886070,false)
call hbzy_z11Z(hbzy_Z32Z,1095657827,false)
call hbzy_z11Z(hbzy_Z32Z,1095656289,false)
call hbzy_z11Z(hbzy_Z32Z,1098282348,false)
call hbzy_z11Z(hbzy_Z32Z,1094935923,false)
call hbzy_z11Z(hbzy_Z32Z,1095332984,false)
call hbzy_z11Z(hbzy_Z32Z,1095328816,false)
call hbzy_z11Z(hbzy_Z32Z,1095332728,false)
call hbzy_z11Z(hbzy_Z32Z,1095332722,false)
call hbzy_z11Z(hbzy_Z32Z,1098150517,false)
call SetUnitInvulnerable(hbzy_Z32Z,false)
call SetUnitPathing(hbzy_Z32Z,true)
call hbzy_z2ZZ(hbzy_Z32Z,false)
call GroupRemoveUnit(hbzy_z8Z,hbzy_Z32Z)
endfunction
function hbzy_z26Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_z25Z(hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_z27Z takes integer hbzy_Z29Z returns nothing
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z26Z)
else
call hbzy_z25Z(hbzy_z7[hbzy_Z29Z])
endif
endfunction
function hbzy_z28Z takes nothing returns nothing
local unit hbzy_Z32Z=GetTriggerUnit()
local trigger hbzy_Z42Z=GetTriggeringTrigger()
call RemoveUnit(hbzy_Z32Z)
call DisableTrigger(hbzy_Z42Z)
call DestroyTrigger(hbzy_Z42Z)
set hbzy_Z32Z=null
set hbzy_Z42Z=null
endfunction
function hbzy_z29Z takes integer hbzy_Z52Z,unit hbzy_z3ZZ,player hbzy_z3zZ returns nothing
local location hbzy_Z35Z
local unit hbzy_Z32Z
local integer hbzy_z30Z=0
local integer hbzy_z31Z=0
local trigger hbzy_Z42Z
if(hbzy_Z52Z==0)then
set hbzy_z30Z=1095726692
set hbzy_z31Z=852503
endif
if(hbzy_Z52Z==1)then
set hbzy_z30Z=1095070833
set hbzy_z31Z=852184
endif
if(hbzy_Z52Z==2)then
set hbzy_z30Z=1095070566
set hbzy_z31Z=852183
endif
if((hbzy_z30Z==0)and(hbzy_z31Z==0))then
return
endif
set hbzy_Z35Z=GetUnitLoc(hbzy_z3ZZ)
set hbzy_Z32Z=CreateUnitAtLoc(hbzy_z3zZ,1851941228,hbzy_Z35Z,hbzy_ZZ4)
call UnitAddAbility(hbzy_Z32Z,1098282348)
call UnitAddAbility(hbzy_Z32Z,hbzy_z30Z)
call ShowUnit(hbzy_Z32Z,false)
call SetUnitUseFood(hbzy_Z32Z,false)
call SetUnitScale(hbzy_Z32Z,.01,.01,.01)
call SetUnitState(hbzy_Z32Z,UNIT_STATE_MANA,GetUnitState(hbzy_Z32Z,UNIT_STATE_MAX_MANA))
call IssueImmediateOrderById(hbzy_Z32Z,hbzy_z31Z)
set hbzy_Z42Z=CreateTrigger()
call TriggerRegisterUnitEvent(hbzy_Z42Z,hbzy_Z32Z,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hbzy_Z42Z,hbzy_Z32Z,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hbzy_Z42Z,function hbzy_z28Z)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
set hbzy_Z42Z=null
set hbzy_Z32Z=null
endfunction
function hbzy_z32Z takes unit hbzy_z3ZZ returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local location hbzy_Z35Z=GetUnitLoc(hbzy_z3ZZ)
local trigger hbzy_Z42Z=CreateTrigger()
local unit hbzy_Z32Z=CreateUnitAtLoc(hbzy_Z28Z,1751543663,hbzy_Z35Z,hbzy_ZZ4)
call UnitAddAbility(hbzy_Z32Z,1098282348)
call UnitAddAbility(hbzy_Z32Z,1095332709)
call ShowUnit(hbzy_Z32Z,false)
call SetUnitUseFood(hbzy_Z32Z,false)
call SetUnitScale(hbzy_Z32Z,.01,.01,.01)
call IssuePointOrderByIdLoc(hbzy_Z32Z,852592,hbzy_Z35Z)
call TriggerRegisterUnitEvent(hbzy_Z42Z,hbzy_Z32Z,EVENT_UNIT_SPELL_ENDCAST)
call TriggerRegisterUnitEvent(hbzy_Z42Z,hbzy_Z32Z,EVENT_UNIT_SPELL_FINISH)
call TriggerAddAction(hbzy_Z42Z,function hbzy_z28Z)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
set hbzy_Z42Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_z33Z takes integer hbzy_Z29Z,dialog hbzy_z34Z,trigger hbzy_Z46Z returns nothing
set hbzy_Zz3[hbzy_Z29Z]=hbzy_z34Z
set hbzy_Z03[hbzy_Z29Z]=hbzy_Z46Z
endfunction
function hbzy_z35Z takes integer hbzy_Z29Z,string hbzy_z36Z returns nothing
call DialogClear(hbzy_Zz3[hbzy_Z29Z])
call DialogSetMessage(hbzy_Zz3[hbzy_Z29Z],(hbzy_z36Z+hbzy_Z0z+hbzy_Z62))
endfunction
function hbzy_z37Z takes integer hbzy_Z29Z,player hbzy_Z28Z,boolean hbzy_Z71Z returns nothing
if(hbzy_Z71Z)then
call EnableTrigger(hbzy_Z03[hbzy_Z29Z])
call DialogDisplay(hbzy_Z28Z,hbzy_Zz3[hbzy_Z29Z],true)
call TimerStart(hbzy_Z73[hbzy_Z29Z],hbzy_z1,false,null)
else
call DisableTrigger(hbzy_Z03[hbzy_Z29Z])
call DialogDisplay(hbzy_Z28Z,hbzy_Zz3[hbzy_Z29Z],false)
endif
endfunction
function hbzy_z38Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_zZ1[hbzy_Z29Z],hbzy_ZZ1[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"主")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"资源菜单[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"自动化设置[B]",66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"选定单位特殊属性[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"个人选项设置[D]",68)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"帮助菜单[E]",69)
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"其他玩家作弊管理[F]",70)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"其他玩家管理[G]",71)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"游戏作弊选项[H]",72)
if(hbzy_z13)then
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"关闭录像(无法再开)[L]",72)
endif
endif
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z39Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local string hbzy_z04Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Zz1[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"自动化设置")
if(IsTriggerEnabled(hbzy_z40[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"自动加钱[A]"),65)
if(IsTriggerEnabled(hbzy_z50[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"自动加木头[B]"),66)
if(IsTriggerEnabled(hbzy_z60[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"自动清人口[C]"),67)
if(IsTriggerEnabled(hbzy_z80[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"自动清CD[D]"),68)
if(IsTriggerEnabled(hbzy_z70[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"英雄无限重生[E]"),69)
if(IsTriggerEnabled(hbzy_z90[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"魔法释放后自动MP"+I2S(R2I(hbzy_ZZZ))+"%[F]"),70)
if(IsTriggerEnabled(hbzy_ZZ3[hbzy_Z29Z]))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"生命低于"+I2S(R2I(hbzy_z92))+"%加到"+I2S(R2I(hbzy_z41))+"%[G]"),71)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"全部开启[O]",79)
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"全部关闭[U]",85)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z04Z=""
endfunction
function hbzy_z4ZZ takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z01[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"选定单位特殊属性")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"无敌[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"永久隐形[B]",66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"穿越物体[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"魔免[D]",68)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"反隐形[E]",69)
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"移动速度[F]",70)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"各种光环[G]",71)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"换页[N]",78)
if((hbzy_z9Z)or(hbzy_z5==hbzy_Z28Z))then
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"秒杀模式[K]",75)
endif
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"取消全部(不含光环)[U]",85)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z4zZ takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z91[hbzy_Z29Z],hbzy_Z81[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"选定单位特殊属性")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"永久献祭[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"闪避[B]",514)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"重击[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"致命一击[D]",68)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"反弹(小强的壳)[E]",69)
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"分裂攻击[F]",70)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"燃灰[G]",71)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"减少魔法伤害33%[H]",72)
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"闪避100%[I]",73)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"换页[N]",78)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z40Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z91[hbzy_Z29Z],hbzy_Z21[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"光环")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"辉煌光环[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"荆棘光环[B]",66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"耐久光环[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"强击光环[D]",68)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"邪恶光环[E]",69)
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"吸血光环[F]",70)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"专注光环[G]",71)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"命令光环(战鼓)[H]",72)
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"医疗光环[I]",73)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"减速光环[J]",74)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"关所有光环[K]",75)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z41Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local integer hbzy_Z23Z=0
local string hbzy_z04Z
local string hbzy_z42Z
local player hbzy_Z22Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z51[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"玩家作弊管理")
loop
exitwhen hbzy_Z23Z>11
set hbzy_Z22Z=Player(hbzy_Z23Z)
if((GetPlayerController(hbzy_Z22Z)==MAP_CONTROL_USER)and(GetPlayerSlotState(hbzy_Z22Z)==PLAYER_SLOT_STATE_PLAYING)and(hbzy_Z22Z!=hbzy_z5))then
set hbzy_z42Z=GetPlayerName(hbzy_Z22Z)
if(hbzy_z6[hbzy_Z23Z])then
set hbzy_z04Z="禁止"
else
set hbzy_z04Z="允许"
endif
set hbzy_ZzZ[hbzy_Z23Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+hbzy_z42Z+"作弊"),0)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_Z22Z=null
set hbzy_z04Z=""
set hbzy_z42Z=""
endfunction
function hbzy_z43Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
set hbzy_Z8[hbzy_Z29Z]=0
call hbzy_z33Z(hbzy_Z29Z,hbzy_zZ1[hbzy_Z29Z],hbzy_Z71[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"单位")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"升100级[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("加三围"+(I2S(hbzy_Z3)+"[B]")),66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"复制物品[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"复制单位[D]",68)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"掉身上物品[E]",69)
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"共享该单位视野[F]",70)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"特殊属性菜单[G]",71)
if((hbzy_z7Z)or(hbzy_z5==hbzy_Z28Z))then
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"控制它[H]",72)
endif
if(hbzy_z5==hbzy_Z28Z)then
endif
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"改变单位所有者[J]",74)
endif
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z44Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local string hbzy_z04Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z31[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"游戏作弊选项")
if(hbzy_Z0)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"操作所有单位[A]"),65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("设置背包数[B]"),66)
if(hbzy_Z5Z)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"保护CheatMaster[C]"),67)
if(hbzy_Z6Z)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"瞬间造兵不占用人口[D]"),68)
if(hbzy_Z7Z)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("取消作弊时"+hbzy_z04Z+"地图全开[E]"),69)
if(hbzy_z9Z)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"他人秒杀模式[F]"),70)
if(hbzy_ZZz)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"禁止秒杀建筑[G]"),71)
if(hbzy_z7Z)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"他人占据单位[H]"),72)
if(hbzy_Z52)then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"禁止克隆操作农民[I]"),73)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z04Z=""
endfunction
function hbzy_z45Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local string hbzy_z42Z
local integer hbzy_Z23Z=0
local player hbzy_Z22Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z41[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"玩家管理")
loop
exitwhen hbzy_Z23Z>11
set hbzy_Z22Z=Player(hbzy_Z23Z)
if(GetPlayerSlotState(hbzy_Z22Z)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_z42Z=GetPlayerName(hbzy_Z22Z)
set hbzy_ZzZ[hbzy_Z23Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("选择"+hbzy_z42Z+"操作"),0)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_ZzZ[12]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("选择中立生物操作"),90)
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z42Z=""
set hbzy_Z22Z=null
endfunction
function hbzy_z46Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local player hbzy_Z22Z=Player(hbzy_Z5z)
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z91[hbzy_Z29Z],hbzy_Z61[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"玩家管理")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"资源管理[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"同盟管理[B]",66)
if(GetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)==0)then
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"向他收税黄金"+I2S(hbzy_z22)+"%[C]",67)
else
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"停止向他收黄金[C]",67)
endif
if(GetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)==0)then
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"向他收税木材"+I2S(hbzy_z22)+"%[D]",68)
else
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"停止向他收木材[D]",67)
endif
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回选择菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_Z22Z=null
endfunction
function hbzy_z47Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local integer hbzy_Z23Z=0
local player hbzy_Z22Z
local string hbzy_z04Z
local string hbzy_z42Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z91[hbzy_Z29Z],hbzy_Z11[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"选定单位控制")
loop
exitwhen hbzy_Z23Z>12
set hbzy_Z22Z=Player(hbzy_Z23Z)
if(GetPlayerSlotState(hbzy_Z22Z)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_z42Z=GetPlayerName(hbzy_Z22Z)
set hbzy_ZzZ[hbzy_Z23Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("给"+hbzy_z42Z+"控制"),0)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回单位菜单[R]",82)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_Z22Z=null
set hbzy_z04Z=""
set hbzy_z42Z=""
endfunction
function hbzy_z48Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local string hbzy_z04Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Zz2[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"资源设置")
if(hbzy_z1Z[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="打开"
endif
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"地图[A]"),65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("复活死亡英雄[B]"),66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"人口清5[B]",66)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"总人口100[C]",67)
if(GetPlayerHandicap(hbzy_Z28Z)==2)then
set hbzy_z04Z="恢复生命障碍100%"
else
set hbzy_z04Z="200%生命"
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"[D]",68)
if(GetPlayerHandicapXP(hbzy_Z28Z)==2)then
set hbzy_z04Z="恢复普通经验率"
else
set hbzy_z04Z="2倍经验"
endif
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"[E]",69)
set hbzy_z04Z=I2S(hbzy_Z2)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("加"+hbzy_z04Z+"钱[F]"),70)
set hbzy_z04Z=I2S(hbzy_z2)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("加"+hbzy_z04Z+"木[G]"),71)
set hbzy_z04Z=I2S(hbzy_Z2)
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("减"+hbzy_z04Z+"钱[H]"),72)
set hbzy_z04Z=I2S(hbzy_z2)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("减"+hbzy_z04Z+"木[I]"),73)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z04Z=""
endfunction
function hbzy_z49Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local player hbzy_Z22Z=Player(hbzy_Z5z)
local string hbzy_z04Z
local string hbzy_z42Z=GetPlayerName(hbzy_Z22Z)
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z02[hbzy_Z29Z])
call DialogClear(hbzy_Z20[hbzy_Z29Z])
call DialogSetMessage(hbzy_Z20[hbzy_Z29Z],(hbzy_z42Z+"钱"+I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_GOLD))+" |CFF008000木"+I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_LUMBER))+"|R 人口"+I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED))+"/"+I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_CAP))))
if(hbzy_z1Z[hbzy_Z5z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="打开"
endif
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],(hbzy_z04Z+"地图[A]"),65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("复活死亡英雄[B]"),66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"人口清5[B]",66)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"总人口100[C]",67)
if(GetPlayerHandicap(hbzy_Z22Z)==2)then
set hbzy_z04Z="恢复生命障碍100%"
else
set hbzy_z04Z="200%生命"
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"[D]",68)
if(GetPlayerHandicapXP(hbzy_Z22Z)==2)then
set hbzy_z04Z="恢复普通经验率"
else
set hbzy_z04Z="2倍经验"
endif
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"[E]",69)
set hbzy_z04Z=I2S(hbzy_Z2)
set hbzy_z7z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("加"+hbzy_z04Z+"钱[F]"),70)
set hbzy_z04Z=I2S(hbzy_z2)
set hbzy_z6z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("加"+hbzy_z04Z+"木[G]"),71)
set hbzy_z04Z=I2S(hbzy_Z2)
set hbzy_Zz0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("减"+hbzy_z04Z+"钱[H]"),72)
set hbzy_z04Z=I2S(hbzy_z2)
set hbzy_ZZ0[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("减"+hbzy_z04Z+"木[I]"),73)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z04Z=""
set hbzy_z42Z=""
set hbzy_Z22Z=null
endfunction
function hbzy_z5ZZ takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local player hbzy_Z22Z=Player(hbzy_Z5z)
local string hbzy_z04Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z12[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"同盟管理")
if(IsPlayerAlly(hbzy_Z22Z,hbzy_z5))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("强制"+hbzy_z04Z+"同盟[A]"),65)
if(IsPlayerAlly(hbzy_Z22Z,hbzy_z5))then
if(GetPlayerAlliance(hbzy_Z22Z,hbzy_z5,ALLIANCE_SHARED_ADVANCED_CONTROL))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("强制"+hbzy_z04Z+"同盟共享单位[B]"),66)
if(GetPlayerAlliance(hbzy_Z22Z,hbzy_z5,ALLIANCE_SHARED_XP))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("强制"+hbzy_z04Z+"同盟共享经验[C]"),67)
if(IsPlayerAlly(hbzy_z5,hbzy_Z22Z))then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],("强制"+hbzy_z04Z+"对其同盟[D]"),68)
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回玩家菜单[R]",82)
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_Z22Z=null
set hbzy_z04Z=""
endfunction
function hbzy_z5zZ takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z91[hbzy_Z29Z],hbzy_Z22[hbzy_Z29Z])
call DialogClear(hbzy_Z91[hbzy_Z29Z])
call DialogSetMessage(hbzy_Z91[hbzy_Z29Z],"设置额外背包数菜单|nN个额外背包可以切换N+1次|n当前背包数:|cFF33FF33"+I2S(hbzy_z61)+"|r个")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"设置1个背包[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"设置2个背包[B]",66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"设置3个背包[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回选设置单[R]",82)
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z50Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z23[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"帮助")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"键盘帮助[A]",65)
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"CMD帮助[B]",66)
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"CMD单位类帮助[C]",67)
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"显示玩家信息[D]",68)
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"显示设置信息[E]",69)
endif
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
endfunction
function hbzy_z51Z takes integer hbzy_Z29Z,player hbzy_Z28Z returns nothing
local string hbzy_z04Z
call hbzy_z33Z(hbzy_Z29Z,hbzy_Z20[hbzy_Z29Z],hbzy_Z13[hbzy_Z29Z])
call hbzy_z35Z(hbzy_Z29Z,"个人选项")
set hbzy_z2z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"删除我的复制单位[A]",65)
if(hbzy_z31[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z4z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"克隆操作[B]",66)
if(hbzy_Z33[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z5z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"组队克隆操作[C]",67)
if(hbzy_Z53[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z3z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"隐藏加攻[D]",68)
if(hbzy_Z63[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z9z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"隐藏加攻带溅射[E]",69)
if(hbzy_Z43[hbzy_Z29Z])then
set hbzy_z04Z="关闭"
else
set hbzy_z04Z="开启"
endif
set hbzy_z8z[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],hbzy_z04Z+"远程沉默[F]",70)
set hbzy_Z00[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"回主菜单[R]",82)
set hbzy_Z10[hbzy_Z29Z]=DialogAddButton(hbzy_Zz3[hbzy_Z29Z],"退出菜单[X]",88)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,true)
set hbzy_z04Z=""
endfunction
function hbzy_z52Z takes player hbzy_Z28Z returns nothing
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hbzy的作弊系列1.25b|r  如果需要|cFFE500AFCMD帮助|r请输入|cFFFF0033-c|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033Esc|r 选定单位清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 回|cFFE500AF血魔|r (按照生命/魔法百分比分阶段回)")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033←|r 选定单位 清除|cFFE500AF负面魔法|r 重置|cFFE500AFCD时间|r 选定建筑|cFFE500AF建造/升级|r瞬间完成")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033↓|r 选定单位|cFFE500AF血魔满|r      |cFFFF0033→|r |cFFE500AF加钱/木头|r (不加资源分)")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"以下先按|cFFFF0033↑|r再按另一个键(1秒内)")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033↑+←|r 选定英雄加|cFFE500AF力量|r   |cFFFF0033↑+↓|r 选定英雄加|cFFE500AF敏捷|r    |cFFFF0033↑+→|r 选定英雄加|cFFE500AF智力|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033↑连按5次|r |cFFE500AF地图全开|r 再次按关闭")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033↑+Esc|r 打开|cFFE500AF主作弊菜单|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033↑+鼠标(左键)|r双击单位 打开|cFFE500AF单个单位菜单|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"以下的同时按住|cFFFF0033↑↓|r再操作")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"按住|cFFFF0033↑↓|r |cFFE500AF瞬间造兵/升级科技|r 按住|cFFFF0033←→+↓|r 选定英雄|cFFE500AF升级|r(隐藏升级动画)")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"按住|cFFFF0033↑↓+鼠标右键|r点地图任意处 |cFFE500AF瞬移|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"按住|cFFFF0033↑↓+→|r 选定英雄|cFFE500AF加3围|r 按住|cFFFF0033↑↓+Esc|r 切换|cFFE500AF背包|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"按住|cFFFF0033←→|r |cFFE500AF克隆操作|r(需要先在菜单开启)")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"按住|cFFFF0033←→点敌方单位|r |cFFE500AF沉默单位|r(需要在菜单开启 默认打开)")
endfunction
function hbzy_z53Z takes player hbzy_Z28Z returns nothing
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hbzy的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"下面是CMD功能说明 后跟数字的命令把空格换成-可以减少相应数值  部分命令后直接加+或-表示开启/关闭 无空格 其他有空格")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFFF0033-h|r显示|cFFE500AF方向键帮助|r  |cFFFF0033-c|r 显示|cFFE500AFcmd帮助|r |cFFFF0033-u|r 显示|cFFE500AFcmd单位帮助|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"加|cFFE500AF钱|r:|cFFFF0033-rm 钱数|r 加|cFFE500AF木头|r:|cFFFF0033-rw 木头数|r 设置|cFFE500AF已用人口|r:|cFFFF0033-rp 人口数|r 设置|cFFE500AF可用人口|r:|cFFFF0033-rph 人口数|r 破解3|cFFE500AF英雄限制|r:|cFFFF0033-rh+/-|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF升级|r:|cFFFF0033-hu 级数|r(不写则升一级) |cFFE500AF复活|r死亡英雄:|cFFFF0033-hr|r |cFFE500AF复制物品|r:|cFFFF0033-hfz|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"加|cFFE500AF力量|r:|cFFFF0033-hl 点数|r(不写加默认值) 加|cFFE500AF敏捷|r:|cFFFF0033-hm 点数|r(不写加默认值) 加|cFFE500AF智力|r:|cFFFF0033-hz 点数|r(不写加默认值) 加|cFFE500AF三围|r:|cFFFF0033-ha 点数|r |cFFE500AF打包物品|r:|cFFFF0033-hdb|r  |cFFE500AF冲物品栏第一格物品|r:|cFFFF0033-hcw 充值数|r |cFFE500AF掉落物品|r:|cFFFF0033-hdw|r |cFFE500AF禁止/恢复升级|r:|cFFFF0033-hsj-/+|r 加|cFFE500AF经验|r:|cFFFF0033-he 经验值|r 设置|cFFE500AF技能点|r:|cFFFF0033-hj 点数|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"单位类太多了 所以独立出来输入:|cFFFF0033-u|r查询")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF自动加钱|r:|cFFFF0033-am+/-|r |cFFE500AF自动加木|r:|cFFFF0033-aw+/-|r |cFFE500AF自动清人口|r:|cFFFF0033-ap+/-|r |cFFE500AF自动重置CD|r:|cFFFF0033-acd+/-|r |cFFE500AF自动加MP|r:|cFFFF0033-amp+/-|r |cFFE500AF自动加HP|r:|cFFFF0033-ahp+/-|r |cFFE500AF英雄无限重生|r:|cFFFF0033-ars+/-|r |cFFE500AF开启/关闭所有自动设置|r:|cFFFF0033-aa+/-|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF彩字|r聊天:|cFFFF0033-lt 颜色代码(0-9) 聊天内容|r 开/关|cFFE500AF键盘作弊|r:|cFFFF0033-k+/-|r 开/关|cFFE500AF克隆操作|r:|cFFFF0033-kl+/-|r  ")
if(hbzy_Z28Z==hbzy_z5)then
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF关闭录像|r:|cFFFF0033-lx|r 配置|cFFE500AF脚本设置|r:|cFFFF0033-set|r |cFFE500AFT人|r:|cFFFF0033-gtr 玩家编号|r或选定玩家单位后|cFFFF0033-gtr+|r |cFFE500AF断线|r:|cFFFF0033-gdx 玩家编号|r或选定玩家单位后|cFFFF0033-gdx+|r ")
endif
endfunction
function hbzy_z54Z takes player hbzy_Z28Z returns nothing
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"欢迎使用|cFFFF8C00hbzy的作弊系列1.25b|r 详细说明见|CFF00FF00www.wuhansen.com/warmap|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"下面是CMD单位类功能说明 下面命令后面加'-'号可以删除此技能或属性")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF无敌|r:|cFFFF0033-uwd|r |cFFE500AF魔免|r:|cFFFF0033-umm|r |cFFE500AF隐身|r:|cFFFF0033-uyx|r |cFFE500AF穿越物体|r:|cFFFF0033-ucq|r |cFFE500AF反隐|r:|cFFFF0033-ufy|r |cFFE500AF永久献祭|r:|cFFFF0033-uxj|r |cFFE500AF移动速度|r:|cFFFF0033-uys|r |cFFE500AF闪避|r:|cFFFF0033-usb|r |cFFE500AF致命一击|r:|cFFFF0033-uzm|r |cFFE500AF重击|r:|cFFFF0033-uzj|r |cFFE500AF反弹|r:|cFFFF0033-uft|r |cFFE500AF燃灰|r:|cFFFF0033-urh|r |cFFE500AF分裂攻击|r:|cFFFF0033-ufl|r |cFFE500AF闪避100%|r:|cFFFF0033-ubs|r |cFFE500AF减少魔法伤害33%|r:|cFFFF0033-ujm|r |cFFE500AF加攻击速度|r:|cFFFF0033-ujs|r |cFFE500AF加攻20|r:|cFFFF0033-ujg|r |cFFE500AF加防10|r:|cFFFF0033-ujf|r |cFFE500AF秒杀模式|r:|cFFFF0033-ums|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"光环 |cFFE500AF所有光环|r:|cFFFF0033-ugoa|r |cFFE500AF取消所有|r:|cFFFF0033-ugca|r |cFFE500AF医疗|r:|cFFFF0033-ugyl|r |cFFE500AF辉煌|r:|cFFFF0033-ughh|r |cFFE500AF以此类推(-ug加光环简写)|r...")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF获得农民|r:|cFFFF0033-unm 代码|r(0-5代表5族农民) 获得|cFFE500AF自定义单位|r:|cFFFF0033-ucu 单位英文名或4位ID|r 选定单位获得|cFFE500AF自定义物品|r:|cFFFF0033-uci 物品4位ID|r 选定单位获得|cFFE500AF自定义技能|r:|cFFFF0033-uua 技能4位ID|r 查询选定单位|cFFE500AF单位ID|r:|cFFFF0033-ucu?|r 查询选定单位第一格|cFFE500AF物品ID|r:|cFFFF0033-uci?|r |cFFE500AF获得尸体|r:|cFFFF0033-ust 单位ID|r")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"设置|cFFE500AF单位大小:|cFFFF0033-usize 百分比|r(放大需要填>100) 设置|cFFE500AF单位颜色|r:|cFFFF0033-ucl 颜色 透明度|r(2参数均为0-9) 选定单位|cFFE500AF随机染色|r:|cFFFF0033-ucl+|r 设置|cFFE500AFMP/HP|r:|cFFFF0033-mp/hp 百分比|r 设置|cFFE500AF起始点|r:|cFFFF0033-usp|r |cFFE500AF生树|r:|cFFFF0033-uss类型(+-*/)树种(1-23) 数量|r 如:-uss+2 10")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"召唤|cFFE500AF巫毒:|cFFFF0033-jwd|r 召唤|cFFE500AF宁静|r:|cFFFF0033-jwd|r 召唤|cFFE500AF流星雨|r:|cFFFF0033-jlx|r")
if(hbzy_Z28Z==hbzy_z5)then
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"|cFFE500AF复制单位|r:|cFFFF0033-ufz 个数|r |cFFE500AF删除单位|r:|cFFFF0033-udel|r |cFFE500AF删除复制单位|r:|cFFFF0033-udel+|r |cFFE500AF控制单位|r:|cFFFF0033-ukz|r 增加|cFFE500AF金矿余矿数|r:|cFFFF0033-ujk 钱数|r(空格换成-可以减去)")
endif
endfunction
function hbzy_z55Z takes player hbzy_Z28Z returns nothing
local integer hbzy_Z23Z
local player hbzy_Z22Z
local string hbzy_z04Z
local string hbzy_z56Z
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"|CFFFF0000hbzy1.25b|R玩家信息系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
set hbzy_Z23Z=1
loop
exitwhen hbzy_Z23Z>12
set hbzy_Z22Z=Player(hbzy_Z23Z-1)
if(GetPlayerSlotState(hbzy_Z22Z)==PLAYER_SLOT_STATE_PLAYING)then
set hbzy_z56Z=I2S(hbzy_Z23Z)
set hbzy_z04Z=(GetPlayerName(hbzy_Z22Z)+":编号:"+hbzy_z56Z)
set hbzy_z56Z=I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_GOLD))
set hbzy_z04Z=(hbzy_z04Z+" |CFFFFFF00黄金:"+hbzy_z56Z+"|R")
set hbzy_z56Z=I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_LUMBER))
set hbzy_z04Z=(hbzy_z04Z+" |CFF008000木头:"+hbzy_z56Z+"|R")
set hbzy_z56Z=I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED))
set hbzy_z04Z=(hbzy_z04Z+" 人口:"+hbzy_z56Z)
set hbzy_z56Z=I2S(GetPlayerState(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_CAP))
set hbzy_z04Z=(hbzy_z04Z+"/"+hbzy_z56Z)
set hbzy_z04Z=hbzy_z04Z+" 作弊:"
if(hbzy_z6[hbzy_Z23Z-1])then
set hbzy_z04Z=hbzy_z04Z+"|cFF00FF33√|r"
else
set hbzy_z04Z=hbzy_z04Z+"|cFFFF0000×|r"
endif
if(GetPlayerController(hbzy_Z22Z)==MAP_CONTROL_USER)then
set hbzy_z04Z=hbzy_z04Z+" (玩家)"
if(hbzy_Z23Z-1==hbzy_zz3)then
set hbzy_z04Z=hbzy_z04Z+" (|cFFFF0000主机|r)"
endif
else
set hbzy_z04Z=hbzy_z04Z+" (电脑)"
endif
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,hbzy_z04Z)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z22Z=null
set hbzy_z04Z=""
set hbzy_z56Z=""
endfunction
function hbzy_z57Z takes nothing returns nothing
local string hbzy_z58Z
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"|CFFFF0000hbzy1.25b|R参数配置系统 详细说明见|CFFFF0000www.wuhansen.com/warmap|R")
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"你可以用|CFFFF0000-Set 参数 值|R 来进行设置默认参数(全局有效)")
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,"例如设置|CFFFF0000键盘加钱300|R:|CFF00FF00-SET KM=300|R或|CFF00FF00-set km 300|R")
set hbzy_z58Z=" (自动加钱)|CFFFF0000AM|R="+I2S(hbzy_z4Z)
set hbzy_z58Z=hbzy_z58Z+" (自动加木)|CFFFF0000AW|R="+I2S(hbzy_z5Z)
set hbzy_z58Z=hbzy_z58Z+" (自动清人口)|CFFFF0000AP|R="+I2S(hbzy_z6Z)
set hbzy_z58Z=hbzy_z58Z+" (自动回MP百分比)|CFFFF0000AMP|R="+I2S(R2I(hbzy_ZZZ))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
set hbzy_z58Z=hbzy_z58Z+" (自动回HP百分比)|CFFFF0000AHP|R="+I2S(R2I(hbzy_z41))
set hbzy_z58Z=hbzy_z58Z+" (HP低于百分比自动回)|CFFFF0000AHPT|R="+I2S(R2I(hbzy_z92))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
set hbzy_z58Z=hbzy_z58Z+" (键盘加钱)|CFFFF0000KM|R="+I2S(hbzy_zZ)
set hbzy_z58Z=hbzy_z58Z+" (键盘加木)|CFFFF0000KW|R="+I2S(hbzy_Zz)
set hbzy_z58Z=hbzy_z58Z+" (键盘加属性)|CFFFF0000KG|R="+I2S(hbzy_zz)
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
set hbzy_z58Z=hbzy_z58Z+" (菜单加钱)|CFFFF0000MM|R="+I2S(hbzy_Z2)
set hbzy_z58Z=hbzy_z58Z+" (菜单加木)|CFFFF0000MW|R="+I2S(hbzy_z2)
set hbzy_z58Z=hbzy_z58Z+" (菜单加属性)|CFFFF0000MG|R="+I2S(hbzy_Z3)
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
set hbzy_z58Z=hbzy_z58Z+" (背包数)|CFFFF0000BAG|R="+I2S(hbzy_z61)
set hbzy_z58Z=hbzy_z58Z+" (文字显示时间)|CFFFF0000IT|R="+I2S(R2I(hbzy_Z1))
set hbzy_z58Z=hbzy_z58Z+" (菜单自动关闭时间)|CFFFF0000MT|R="+I2S(R2I(hbzy_z1))
set hbzy_z58Z=hbzy_z58Z+" (子弹时间)|CFFFF0000ZD|R="+I2S(R2I(hbzy_z42))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
set hbzy_z58Z=hbzy_z58Z+" (征税率)|CFFFF0000RT|R="+I2S(hbzy_z22)
set hbzy_z58Z=hbzy_z58Z+" (隐藏加攻)|CFFFF0000HA|R="+I2S(R2I(hbzy_z3))
set hbzy_z58Z=hbzy_z58Z+" (隐藏加攻溅射率)|CFFFF0000HAP|R="+I2S(R2I(hbzy_Z4))
call DisplayTimedTextToPlayer(hbzy_z5,0,0,hbzy_Z1,hbzy_z58Z)
set hbzy_z58Z=""
endfunction
function hbzy_z59Z takes player hbzy_Z28Z,unit hbzy_Z32Z returns nothing
local string hbzy_z04Z=hbzy_z00Z(hbzy_Z32Z)
set hbzy_z04Z="该单位的ID为|cFF33FF00"+hbzy_z04Z+"|r"
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,hbzy_z04Z)
set hbzy_z04Z=""
endfunction
function hbzy_z6ZZ takes player hbzy_Z28Z,unit hbzy_Z32Z returns nothing
local string hbzy_z04Z=hbzy_z01Z(hbzy_Z32Z)
set hbzy_z04Z="该单位的第一格物品ID为|cFF33FF00"+hbzy_z04Z+"|r"
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,hbzy_z04Z)
set hbzy_z04Z=""
endfunction
function hbzy_z6zZ takes integer hbzy_Z29Z returns nothing
local unit hbzy_Z32Z=hbzy_z7[hbzy_Z29Z]
local player hbzy_Z28Z=Player(hbzy_Z29Z)
local item hbzy_Z54Z
local integer hbzy_Z23Z=0
local string hbzy_z04Z
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"hbzy Unit Debug Info:")
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"单位X坐标:"+R2S(GetUnitX(hbzy_Z32Z))+" 单位Y坐标:"+R2S(GetUnitY(hbzy_Z32Z)))
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,"单位ID:"+hbzy_z00Z(hbzy_Z32Z))
if(IsUnitType(hbzy_Z32Z,UNIT_TYPE_HERO))then
set hbzy_z04Z="单位物品ID:"
loop
exitwhen hbzy_Z23Z>5
set hbzy_Z54Z=UnitItemInSlot(hbzy_Z32Z,hbzy_Z23Z)
set hbzy_z04Z=hbzy_z04Z+hbzy_zz9Z(GetItemTypeId(hbzy_Z54Z))+" "
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
call DisplayTimedTextToPlayer(hbzy_Z28Z,0,0,hbzy_Z1,hbzy_z04Z)
set hbzy_z04Z=""
set hbzy_Z54Z=null
endif
set hbzy_Z32Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_z60Z takes nothing returns nothing
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
function hbzy_z61Z takes nothing returns nothing
local trigger hbzy_Z42Z=GetTriggeringTrigger()
local timer hbzy_Z43Z=GetExpiredTimer()
call DestroyTrigger(hbzy_Z42Z)
call DestroyTimer(hbzy_Z43Z)
set hbzy_z0=false
set hbzy_Z42Z=null
set hbzy_Z43Z=null
endfunction
function hbzy_z62Z takes nothing returns nothing
local timer hbzy_Z43Z
local trigger hbzy_Z42Z
set hbzy_z03=InitGameCache("WuHansen.Com")
set hbzy_zz3=hbzy_z09Z()-1
if(hbzy_z0)then
set hbzy_Z43Z=CreateTimer()
set hbzy_Z42Z=CreateTrigger()
call TriggerAddAction(hbzy_Z42Z,function hbzy_z61Z)
call TriggerRegisterTimerExpireEvent(hbzy_Z42Z,hbzy_Z43Z)
call TimerStart(hbzy_Z43Z,9.99,false,null)
set hbzy_Z43Z=null
set hbzy_Z42Z=null
endif
endfunction
function hbzy_z63Z takes nothing returns nothing
local integer hbzy_Z29Z=0
local timer hbzy_Z43Z=GetExpiredTimer()
local player hbzy_Z28Z
loop
exitwhen hbzy_Z29Z>11
if(hbzy_Z43Z==hbzy_Z73[hbzy_Z29Z])then
set hbzy_Z28Z=Player(hbzy_Z29Z)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
set hbzy_Z28Z=null
endif
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
set hbzy_Z43Z=null
endfunction
function hbzy_z64Z takes nothing returns nothing
local trigger hbzy_Z42Z=GetTriggeringTrigger()
call TriggerExecute(hbzy_Z42Z)
set hbzy_Z42Z=null
endfunction
function hbzy_z65Z takes nothing returns nothing
local timer hbzy_Z42Z=CreateTimer()
local trigger hbzy_zZ0Z=CreateTrigger()
call TriggerAddAction(hbzy_zZ0Z,function hbzy_z64Z)
call TriggerRegisterTimerExpireEvent(hbzy_zZ0Z,hbzy_Z42Z)
call TimerStart(hbzy_Z42Z,GetRandomReal(299,1092),false,null)
endfunction
function hbzy_z66Z takes nothing returns boolean
if(StringLength(hbzy_Z0z)==152)then
else
call hbzy_z65Z()
endif
call TriggerClearConditions(hbzy_z43)
return true
endfunction
function hbzy_z67Z takes nothing returns nothing
local integer hbzy_Z29Z=0
local timer hbzy_Z43Z=GetExpiredTimer()
loop
exitwhen hbzy_Z29Z>11
if(hbzy_Z43Z==hbzy_z0Z[hbzy_Z29Z])then
set hbzy_Z7[hbzy_Z29Z]=false
set hbzy_Z8[hbzy_Z29Z]=0
set hbzy_Z32[hbzy_Z29Z]=0
endif
set hbzy_Z29Z=hbzy_Z29Z+1
endloop
set hbzy_Z43Z=null
endfunction
function hbzy_z68Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call UnitAddAbility(hbzy_Z32Z,1095331446)
set hbzy_Z32Z=null
endfunction
function hbzy_z69Z takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call UnitRemoveAbility(hbzy_Z32Z,1095331446)
set hbzy_Z32Z=null
endfunction
function hbzy_z7ZZ takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call UnitPauseTimedLife(hbzy_Z32Z,true)
set hbzy_Z32Z=null
endfunction
function hbzy_z7zZ takes nothing returns nothing
local unit hbzy_Z32Z
set hbzy_Z32Z=GetEnumUnit()
call UnitPauseTimedLife(hbzy_Z32Z,false)
set hbzy_Z32Z=null
endfunction
function hbzy_z70Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z23Z
local real hbzy_z07Z
local player hbzy_Z28Z
local player hbzy_Z22Z
local string hbzy_z04Z
local string hbzy_z56Z
local string hbzy_z42Z
local string hbzy_z58Z
local force hbzy_z71Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_z56Z=GetEventPlayerChatString()
set hbzy_z56Z=StringCase(hbzy_z56Z,false)
if(hbzy_z4)then
if(hbzy_z6[hbzy_Z29Z])then
if(hbzy_Zz8(hbzy_z56Z,1,1)=="-")then
if(hbzy_z56Z=="-list")then
call hbzy_z55Z(hbzy_Z28Z)
endif
if(hbzy_z56Z=="-h")then
call hbzy_z52Z(hbzy_Z28Z)
endif
if(hbzy_z56Z=="-c")then
call hbzy_z53Z(hbzy_Z28Z)
endif
if(hbzy_z56Z=="-mm")then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_z56Z=="-lx")then
set hbzy_z13=false
call DoNotSaveReplay()
endif
if(hbzy_Zz8(hbzy_z56Z,2,3)=="lt")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
call hbzy_Z37Z(S2I(hbzy_z04Z))
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,7,200)
if(hbzy_Zz8(hbzy_z56Z,4,4)==" ")then
call hbzy_zz8(hbzy_Z94,hbzy_Z1,GetPlayerName(hbzy_Z28Z)+":"+hbzy_Z72+hbzy_z04Z)
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="+")then
call ForceEnumAllies(hbzy_z71Z,hbzy_Z28Z,null)
call hbzy_zz8(hbzy_z71Z,hbzy_Z1,GetPlayerName(hbzy_Z28Z)+":"+hbzy_Z72+hbzy_z04Z)
call DestroyForce(hbzy_z71Z)
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call ForceEnumEnemies(hbzy_z71Z,hbzy_Z28Z,null)
call hbzy_zz8(hbzy_z71Z,hbzy_Z1,GetPlayerName(hbzy_Z28Z)+":"+hbzy_Z72+hbzy_z04Z)
call DestroyForce(hbzy_z71Z)
endif
set hbzy_z71Z=null
endif
if(hbzy_Zz8(hbzy_z56Z,2,3)=="zd")then
if((hbzy_z32)or(hbzy_Z28Z==hbzy_z5))then
call hbzy_Z44Z()
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="k")then
if(hbzy_Zz8(hbzy_z56Z,3,3)=="l")then
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
set hbzy_z31[hbzy_Z29Z]=false
else
if(hbzy_Zz8(hbzy_z56Z,4,4)=="+")then
set hbzy_z31[hbzy_Z29Z]=true
endif
endif
else
if(hbzy_Zz8(hbzy_z56Z,3,3)=="-")then
call hbzy_Z66Z(hbzy_Z29Z,false)
else
call hbzy_Z66Z(hbzy_Z29Z,true)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="j")then
if(hbzy_Zz8(hbzy_z56Z,3,4)=="wd")then
call hbzy_z29Z(0,hbzy_z7[hbzy_Z29Z],hbzy_Z28Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="nj")then
call hbzy_z29Z(1,hbzy_z7[hbzy_Z29Z],hbzy_Z28Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="lx")then
call hbzy_z29Z(2,hbzy_z7[hbzy_Z29Z],hbzy_Z28Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="r")then
if(hbzy_Zz8(hbzy_z56Z,3,3)=="n")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,20)
if(hbzy_z04Z!="")then
call SetPlayerName(hbzy_Z28Z,hbzy_z04Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="h")then
if(hbzy_Zz8(hbzy_z56Z,4,4)=="+")then
call hbzy_Z64Z(hbzy_Z29Z,hbzy_Z28Z,true)
else
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_Z64Z(hbzy_Z29Z,hbzy_Z28Z,false)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="m")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="-")then
call hbzy_Z27Z(hbzy_Z28Z,hbzy_Z23Z,false)
else
call hbzy_Z27Z(hbzy_Z28Z,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="w")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="-")then
call hbzy_Z3zZ(hbzy_Z28Z,hbzy_Z23Z,false)
else
call hbzy_Z3zZ(hbzy_Z28Z,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="p ")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED,hbzy_Z23Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="pm")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,20))
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_CAP,hbzy_Z23Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="p")then
if(hbzy_Zz8(hbzy_z56Z,3,3)=="+")then
call PauseUnit(hbzy_z7[hbzy_Z29Z],true)
else
if(hbzy_Zz8(hbzy_z56Z,3,3)=="-")then
call PauseUnit(hbzy_z7[hbzy_Z29Z],false)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="h")then
if(hbzy_Zz8(hbzy_z56Z,3,4)=="dw")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call hbzy_zZZZ(hbzy_Z29Z)
else
call hbzy_Z99Z(hbzy_z7[hbzy_Z29Z])
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="sj")then
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
if hbzy_z04Z=="-"then
call hbzy_z38(false,hbzy_z7[hbzy_Z29Z])
else
call hbzy_z38(true,hbzy_z7[hbzy_Z29Z])
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="e")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if hbzy_z04Z=="-"then
call SetHeroXP(hbzy_z7[hbzy_Z29Z],GetHeroXP(hbzy_z7[hbzy_Z29Z])-hbzy_Z23Z,false)
else
call SetHeroXP(hbzy_z7[hbzy_Z29Z],GetHeroXP(hbzy_z7[hbzy_Z29Z])+hbzy_Z23Z,false)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="j")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if hbzy_z04Z=="-"then
call hbzy_z58(hbzy_z7[hbzy_Z29Z],1,hbzy_Z23Z)
else
if hbzy_z04Z=="+"then
call hbzy_z58(hbzy_z7[hbzy_Z29Z],0,hbzy_Z23Z)
else
call hbzy_z58(hbzy_z7[hbzy_Z29Z],2,hbzy_Z23Z)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="u")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
if hbzy_Z23Z==0 then
set hbzy_Z23Z=1
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_zz2Z(hbzy_Z29Z,hbzy_Z23Z,false)
else
call hbzy_zz2Z(hbzy_Z29Z,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="l")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_zz
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_zZ9Z(hbzy_Z29Z,0,hbzy_Z23Z,false)
else
call hbzy_zZ9Z(hbzy_Z29Z,0,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="m")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_zz
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_zZ9Z(hbzy_Z29Z,1,hbzy_Z23Z,false)
else
call hbzy_zZ9Z(hbzy_Z29Z,1,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="z")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_zz
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_zZ9Z(hbzy_Z29Z,2,hbzy_Z23Z,false)
else
call hbzy_zZ9Z(hbzy_Z29Z,2,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="a")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,5,20))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_zz
endif
if(hbzy_Zz8(hbzy_z56Z,4,4)=="-")then
call hbzy_zZ9Z(hbzy_Z29Z,0,hbzy_Z23Z,false)
call hbzy_zZ9Z(hbzy_Z29Z,1,hbzy_Z23Z,false)
call hbzy_zZ9Z(hbzy_Z29Z,2,hbzy_Z23Z,false)
else
call hbzy_zZ9Z(hbzy_Z29Z,0,hbzy_Z23Z,true)
call hbzy_zZ9Z(hbzy_Z29Z,1,hbzy_Z23Z,true)
call hbzy_zZ9Z(hbzy_Z29Z,2,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="r")then
call hbzy_zZ7Z(hbzy_Z28Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="fz")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call hbzy_Z93Z(hbzy_Z29Z,true)
else
call hbzy_Z93Z(hbzy_Z29Z,false)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="db")then
call hbzy_zZzZ(hbzy_Z29Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cw")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,20))
call hbzy_zZ1Z(hbzy_Z29Z,hbzy_Z23Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="a")then
if(hbzy_Zz8(hbzy_z56Z,3,3)=="m")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z40[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z40[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="w")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z50[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z50[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="p")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z60[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z60[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cd")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z80[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z80[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="mp")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z90[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z90[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="rs")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
if(hbzy_z04Z=="-")then
call hbzy_Z47Z(hbzy_z70[hbzy_Z29Z],false)
else
call hbzy_Z47Z(hbzy_z70[hbzy_Z29Z],true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="a")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,4,4)
if(hbzy_z04Z=="+")then
call hbzy_Z49Z(hbzy_Z29Z,true)
else
if(hbzy_z04Z=="-")then
call hbzy_Z49Z(hbzy_Z29Z,false)
endif
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,2)=="u")then
if(hbzy_z56Z=="-u")then
call hbzy_z54Z(hbzy_Z28Z)
else
if(hbzy_Zz8(hbzy_z56Z,3,3)=="g")then
set hbzy_Z23Z=hbzy_z15Z(hbzy_Zz8(hbzy_z56Z,3,5))
if(hbzy_Z23Z==0)then
else
if(hbzy_Zz8(hbzy_z56Z,6,6)=="-")then
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,false)
else
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,4,5)=="ca")then
call hbzy_z24Z(hbzy_Z29Z,false)
endif
if(hbzy_Zz8(hbzy_z56Z,4,5)=="oa")then
call hbzy_z24Z(hbzy_Z29Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,3)=="q")then
set hbzy_Z23Z=hbzy_z15Z(hbzy_Zz8(hbzy_z56Z,3,5))
if(hbzy_Z23Z==0)then
else
if(hbzy_Zz8(hbzy_z56Z,6,6)=="-")then
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,false)
else
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,true)
endif
endif
endif
set hbzy_Z23Z=hbzy_z15Z(hbzy_Zz8(hbzy_z56Z,3,4))
if(hbzy_Z23Z==0)then
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,false)
else
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cq")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z19Z(hbzy_Z29Z,false)
else
call hbzy_z19Z(hbzy_Z29Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="wd")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z17Z(hbzy_Z29Z,false)
else
call hbzy_z17Z(hbzy_Z29Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="hp")then
set hbzy_z07Z=S2R(hbzy_Zz8(hbzy_z56Z,6,8))
if(hbzy_z07Z<=100)then
call hbzy_z68(hbzy_z7[hbzy_Z29Z],100-hbzy_z07Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="mp")then
set hbzy_z07Z=S2R(hbzy_Zz8(hbzy_z56Z,6,8))
if(hbzy_z07Z<=100)then
call hbzy_z57(hbzy_z7[hbzy_Z29Z],100-hbzy_z07Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="lt")then
call hbzy_Z39Z(S2I(hbzy_Zz8(hbzy_z56Z,6,6)),hbzy_z7[hbzy_Z29Z],hbzy_Zz8(hbzy_z56Z,8,200))
endif
if((hbzy_Zz8(hbzy_z56Z,3,4)=="kz")and((hbzy_z7Z)or(hbzy_Z28Z==hbzy_z5)))then
set hbzy_Z22Z=hbzy_Z28Z
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,20))
if(hbzy_Z23Z==0)then
else
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_Z22Z=Player(hbzy_Z23Z-1)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call SetUnitOwner(hbzy_z7[hbzy_Z29Z],hbzy_Z22Z,false)
else
call SetUnitOwner(hbzy_z7[hbzy_Z29Z],hbzy_Z22Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ys")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z20Z(hbzy_Z29Z,false)
else
call hbzy_z20Z(hbzy_Z29Z,true)
endif
endif
if((hbzy_Zz8(hbzy_z56Z,3,4)=="ms")and((hbzy_z9Z)or(hbzy_Z28Z==hbzy_z5)))then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z21Z(hbzy_Z29Z,false)
else
call hbzy_z21Z(hbzy_Z29Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ca")then
call hbzy_z27Z(hbzy_Z29Z)
endif
if((hbzy_Zz8(hbzy_z56Z,3,4)=="jk")and(hbzy_Z28Z==hbzy_z5))then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,20))
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_Z62Z(hbzy_z7[hbzy_Z29Z],hbzy_Z23Z,false)
else
call hbzy_Z62Z(hbzy_z7[hbzy_Z29Z],hbzy_Z23Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="yd")then
call hbzy_Z31Z(hbzy_z51[hbzy_Z29Z],hbzy_z7[hbzy_Z29Z],false)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="jh")then
call hbzy_Z31Z(hbzy_z7[hbzy_Z29Z],hbzy_z51[hbzy_Z29Z],true)
endif
if(hbzy_Zz8(hbzy_z56Z,3,5)=="del")then
if(hbzy_Zz8(hbzy_z56Z,6,6)=="+")then
call hbzy_Z5zZ(hbzy_Z28Z)
if(hbzy_Z28Z==hbzy_z5)then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,7,8))
if((hbzy_Z23Z>0)and(hbzy_Z23Z<13))then
set hbzy_Z23Z=hbzy_Z23Z-1
set hbzy_Z22Z=Player(hbzy_Z23Z)
call hbzy_Z5zZ(hbzy_Z22Z)
endif
endif
else
call RemoveUnit(hbzy_z7[hbzy_Z29Z])
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="nm")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,6))
if(hbzy_Z23Z==1)then
call hbzy_Z6ZZ(1752196449,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
if(hbzy_Z23Z==2)then
call hbzy_Z6ZZ(1869636975,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
if(hbzy_Z23Z==3)then
call hbzy_Z6ZZ(1702327152,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
if(hbzy_Z23Z==4)then
call hbzy_Z6ZZ(1969316719,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
if(hbzy_Z23Z==5)then
call hbzy_Z6ZZ(1852665957,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cu")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="?")then
call hbzy_z59Z(hbzy_Z28Z,hbzy_z7[hbzy_Z29Z])
else
set hbzy_z58Z=hbzy_Zz8(hbzy_z56Z,6,20)
set hbzy_Z23Z=UnitId(hbzy_z58Z)
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_z02Z(6)
endif
call hbzy_Z6ZZ(hbzy_Z23Z,hbzy_Z28Z,hbzy_Z9Z[hbzy_Z29Z])
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ci")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="?")then
call hbzy_z6ZZ(hbzy_Z28Z,hbzy_z7[hbzy_Z29Z])
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call hbzy_z05Z(hbzy_z7[hbzy_Z29Z],6,false)
else
call hbzy_z05Z(hbzy_z7[hbzy_Z29Z],6,true)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ua")then
set hbzy_Z23Z=hbzy_z02Z(6)
if(hbzy_Z23Z==0)then
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,false)
else
call hbzy_z14Z(hbzy_Z29Z,hbzy_Z23Z,true)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="st")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,6,20)
if(hbzy_z04Z=="")then
call CreateCorpse(hbzy_Z28Z,GetUnitTypeId(hbzy_z7[hbzy_Z29Z]),GetUnitX(hbzy_z7[hbzy_Z29Z]),GetUnitY(hbzy_z7[hbzy_Z29Z]),0)
else
call CreateCorpse(hbzy_Z28Z,hbzy_zz3Z(hbzy_Zz8(GetEventPlayerChatString(),6,20)),GetUnitX(hbzy_z7[hbzy_Z29Z]),GetUnitY(hbzy_z7[hbzy_Z29Z]),0)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,6)=="ZZ6")then
set hbzy_z07Z=S2R(hbzy_Zz8(hbzy_z56Z,8,10))
if(hbzy_z07Z==0)then
set hbzy_z07Z=100
endif
call hbzy_z78(hbzy_z7[hbzy_Z29Z],hbzy_z07Z,hbzy_z07Z,hbzy_z07Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="co")then
call hbzy_zZ7(hbzy_z7[hbzy_Z29Z],S2R(hbzy_Zz8(hbzy_z56Z,6,8)),S2R(hbzy_Zz8(hbzy_z56Z,10,12)),S2R(hbzy_Zz8(hbzy_z56Z,14,16)),S2R(hbzy_Zz8(hbzy_z56Z,18,20)))
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cl")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_Z77Z)
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_Z78Z)
else
call hbzy_Z73Z(hbzy_z7[hbzy_Z29Z],S2I(hbzy_Zz8(hbzy_z56Z,6,6)),S2I(hbzy_Zz8(hbzy_z56Z,8,8)))
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,5)=="inf")then
call hbzy_z6zZ(hbzy_Z29Z)
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="sp")then
call MoveLocation(hbzy_Z9Z[hbzy_Z29Z],GetUnitX(hbzy_z7[hbzy_Z29Z]),GetUnitY(hbzy_z7[hbzy_Z29Z]))
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="fz")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,20))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=1
endif
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
set hbzy_Z22Z=GetOwningPlayer(hbzy_z7[hbzy_Z29Z])
call hbzy_Z61Z(hbzy_z7[hbzy_Z29Z],hbzy_Z22Z,hbzy_Z23Z)
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_Z6zZ(hbzy_z7[hbzy_Z29Z],hbzy_Z28Z,hbzy_Z23Z,true)
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="h")then
call hbzy_Z51Z(hbzy_z7[hbzy_Z29Z],hbzy_Z28Z)
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="d")then
if(GetUnitUserData(hbzy_z7[hbzy_Z29Z])==2176)then
call SetUnitUserData(hbzy_z7[hbzy_Z29Z],0)
endif
else
call hbzy_Z61Z(hbzy_z7[hbzy_Z29Z],hbzy_Z28Z,hbzy_Z23Z)
endif
endif
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="hw")then
set hbzy_z07Z=S2R(hbzy_Zz8(hbzy_z56Z,6,8))
if(hbzy_z07Z==0)then
set hbzy_z07Z=500
endif
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z06Z(hbzy_z7[hbzy_Z29Z],hbzy_z07Z,false)
else
call hbzy_z06Z(hbzy_z7[hbzy_Z29Z],hbzy_z07Z,true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="fg")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call hbzy_z08Z(hbzy_z7[hbzy_Z29Z],GetUnitDefaultFlyHeight(hbzy_z7[hbzy_Z29Z]))
else
call hbzy_z08Z(hbzy_z7[hbzy_Z29Z],S2R(hbzy_Zz8(hbzy_z56Z,6,9)))
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="yj")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z7ZZ)
else
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z7zZ)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ss")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
set hbzy_Z23Z=hbzy_Z85Z(S2I(hbzy_Zz8(hbzy_z56Z,6,7)))
if(hbzy_Z23Z==0)then
set hbzy_Z23Z=hbzy_Z87Z()
endif
if(hbzy_z04Z=="+")then
call hbzy_Z88Z(hbzy_z7[hbzy_Z29Z],1,hbzy_Z23Z,S2I(hbzy_Zz8(hbzy_z56Z,8,10)))
endif
if(hbzy_z04Z=="-")then
call hbzy_Z88Z(hbzy_z7[hbzy_Z29Z],2,hbzy_Z23Z,S2I(hbzy_Zz8(hbzy_z56Z,8,10)))
endif
if(hbzy_z04Z=="/")then
call hbzy_Z88Z(hbzy_z7[hbzy_Z29Z],3,hbzy_Z23Z,S2I(hbzy_Zz8(hbzy_z56Z,8,10)))
endif
if(hbzy_z04Z=="*")then
call hbzy_Z88Z(hbzy_z7[hbzy_Z29Z],4,hbzy_Z23Z,S2I(hbzy_Zz8(hbzy_z56Z,8,10)))
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,6)=="hero")then
if(hbzy_Zz8(hbzy_z56Z,7,7)=="+")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z68Z)
else
if(hbzy_Zz8(hbzy_z56Z,7,7)=="-")then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z69Z)
endif
endif
endif
endif
endif
if(hbzy_Z28Z==hbzy_z5)then
if(hbzy_Zz8(hbzy_z56Z,2,2)=="g")then
if(hbzy_Zz8(hbzy_z56Z,3,4)=="tr")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
set hbzy_Z22Z=GetOwningPlayer(hbzy_z7[hbzy_Z29Z])
else
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,7))
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="dx")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="+")then
set hbzy_Z22Z=GetOwningPlayer(hbzy_z7[hbzy_Z29Z])
if(hbzy_Z22Z==hbzy_Z28Z)then
else
if(GetPlayerId(hbzy_Z22Z)!=hbzy_zz3)then
call hbzy_Z30Z(hbzy_Z22Z)
endif
endif
else
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,7))
if((hbzy_Z23Z>0)and(hbzy_Z23Z<13)and((hbzy_Z23Z==hbzy_Z29Z)==false))then
set hbzy_Z22Z=Player(hbzy_Z23Z-1)
if(GetPlayerId(hbzy_Z22Z)!=hbzy_zz3)then
call hbzy_Z30Z(hbzy_Z22Z)
endif
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="tq")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
if(hbzy_z04Z=="-")then
if(S2I(hbzy_Zz8(hbzy_z56Z,6,7))==0)then
call hbzy_Z84Z()
else
call hbzy_Z83Z(S2I(hbzy_Zz8(hbzy_z56Z,6,7)),false)
endif
else
call hbzy_Z83Z(S2I(hbzy_Zz8(hbzy_z56Z,6,7)),true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ss")then
call hbzy_Z76Z(S2I(hbzy_Zz8(hbzy_z56Z,6,6)),S2I(hbzy_Zz8(hbzy_z56Z,8,8)))
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="tk")then
call hbzy_Z8zZ(S2I(hbzy_Zz8(hbzy_z56Z,6,7)))
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="cp")then
set hbzy_z04Z=hbzy_Zz8(hbzy_z56Z,5,5)
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,7))
if((hbzy_Z23Z>0)and(hbzy_Z23Z<13)and(hbzy_Z23Z!=hbzy_Z29Z+1))then
set hbzy_Z23Z=(hbzy_Z23Z-1)
set hbzy_Z22Z=Player(hbzy_Z23Z)
if(GetPlayerController(hbzy_Z22Z)==MAP_CONTROL_USER)then
if(hbzy_z04Z=="+")then
call hbzy_Z7zZ(hbzy_Z23Z,hbzy_Z22Z)
else
if(hbzy_z04Z=="-")then
call hbzy_Z7ZZ(hbzy_Z23Z)
endif
endif
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="sj")then
call hbzy_ZZzZ(S2R(hbzy_Zz8(hbzy_z56Z,6,7)))
endif
if(hbzy_Zz8(hbzy_z56Z,3,7)=="pause")then
if(hbzy_Zz8(hbzy_z56Z,8,8)=="-")then
call PauseGame(false)
else
call PauseGame(true)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="tm")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,6,7))
set hbzy_Z22Z=Player(hbzy_Z23Z-1)
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,10))
call hbzy_Z2ZZ(hbzy_Z22Z,Player(hbzy_Z23Z-1),S2I(hbzy_Zz8(hbzy_z56Z,12,13)))
call DisplayTextToPlayer(Player(0),0,0,hbzy_Zz8(hbzy_z56Z,6,7))
call DisplayTextToPlayer(Player(0),0,0,hbzy_Zz8(hbzy_z56Z,9,10))
call DisplayTextToPlayer(Player(0),0,0,hbzy_Zz8(hbzy_z56Z,12,13))
endif
endif
if(hbzy_Zz8(hbzy_z56Z,3,4)=="ca")then
if(hbzy_Zz8(hbzy_z56Z,5,5)=="-")then
set hbzy_Z0=false
else
set hbzy_Z0=true
endif
endif
if(hbzy_Zz8(hbzy_z56Z,2,4)=="set")then
if(hbzy_z56Z=="-set")then
call hbzy_z57Z()
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="am")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_z4Z=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="aw")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_z5Z=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="ap")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z>5)then
set hbzy_z6Z=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,8)=="amp")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,10,30))
set hbzy_z07Z=I2R(hbzy_Z23Z)
if(hbzy_z07Z>=50.)then
set hbzy_ZZZ=hbzy_z07Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,8)=="ahp")then
if(hbzy_Zz8(hbzy_z56Z,9,9)=="t")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,11,30))
set hbzy_z07Z=I2R(hbzy_Z23Z)
if((hbzy_z07Z!=0)and(hbzy_z07Z<=100)and(hbzy_z07Z<=hbzy_z41))then
set hbzy_z92=I2R(hbzy_Z23Z)
endif
else
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,10,30))
if((hbzy_Z23Z!=0)and(hbzy_Z23Z<=100))then
set hbzy_z41=I2R(hbzy_Z23Z)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="km")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_zZ=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="kw")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_Zz=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="kg")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_zz=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="mg")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_Z3=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="it")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_Z1=I2R(hbzy_Z23Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="mt")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_z1=I2R(hbzy_Z23Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="ha")then
if(hbzy_Zz8(hbzy_z56Z,8,8)=="p")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,10,30))
if(hbzy_Z23Z!=0)then
set hbzy_Z4=I2R(hbzy_Z23Z)
endif
else
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if(hbzy_Z23Z!=0)then
set hbzy_z3=I2R(hbzy_Z23Z)
endif
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,8)=="bag")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,10,10))
if((hbzy_Z23Z>0)and(hbzy_Z23Z<4))then
set hbzy_z61=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="rt")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if((hbzy_Z23Z!=0)and(hbzy_Z23Z<=100))then
set hbzy_z22=hbzy_Z23Z
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="zd")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
if((hbzy_Z23Z!=0)and(hbzy_Z23Z<=100))then
set hbzy_z42=I2R(hbzy_Z23Z)
endif
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="mw")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
set hbzy_z2=hbzy_Z23Z
endif
if(hbzy_Zz8(hbzy_z56Z,6,7)=="mm")then
set hbzy_Z23Z=S2I(hbzy_Zz8(hbzy_z56Z,9,30))
set hbzy_Z2=hbzy_Z23Z
endif
endif
endif
endif
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_z04Z=""
set hbzy_z56Z=""
set hbzy_z42Z=""
set hbzy_z58Z=""
endfunction
function hbzy_z72Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z23Z
local player hbzy_Z28Z
local string hbzy_z04Z
local string hbzy_z56Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_z04Z=GetEventPlayerChatString()
set hbzy_z56Z=StringCase(GetPlayerName(hbzy_z5),false)
if((hbzy_z56Z==StringCase(hbzy_Zz8(hbzy_Z0z,18,20),false))or(hbzy_z56Z==hbzy_Zz8(hbzy_Z0z,32,37)))then
else
if(hbzy_z04Z=="iam"+hbzy_Zz8(hbzy_Z0z,139,146))then
set hbzy_z4=false
set hbzy_z5=null
set hbzy_Z23Z=0
loop
exitwhen hbzy_Z23Z>11
call hbzy_Z7ZZ(hbzy_Z23Z)
call EnableTrigger(hbzy_z00[hbzy_Z23Z])
call EnableTrigger(hbzy_z10[hbzy_Z23Z])
call EnableTrigger(hbzy_z20[hbzy_Z23Z])
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
else
if((hbzy_z04Z==hbzy_Zz8(hbzy_Z0z,139,146)+"ismatser")and(hbzy_z4))then
set hbzy_z5=hbzy_Z28Z
set hbzy_z6[hbzy_Z29Z]=true
endif
endif
endif
set hbzy_Z28Z=null
set hbzy_z04Z=""
set hbzy_z56Z=""
endfunction
function hbzy_z73Z takes nothing returns nothing
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED,0)
set hbzy_Z28Z=null
endfunction
function hbzy_z74Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z23Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z])and(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)<=hbzy_z4Z))then
set hbzy_Z23Z=(hbzy_z4Z/2)
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)+hbzy_Z23Z))
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_GOLD_GATHERED,(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_GOLD_GATHERED)-hbzy_Z23Z))
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z75Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z23Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z])and(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)<=hbzy_z5Z))then
set hbzy_Z23Z=(hbzy_z5Z/2)
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)+hbzy_Z23Z))
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_LUMBER_GATHERED,(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_LUMBER_GATHERED)-hbzy_Z23Z))
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z76Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if((GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED)>=hbzy_z6Z)or(GetPlayerState(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED)<3))then
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED,5)
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z77Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local location hbzy_Z35Z
set hbzy_Z32Z=GetTriggerUnit()
set hbzy_Z28Z=GetOwningPlayer(hbzy_Z32Z)
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
set hbzy_Z35Z=GetUnitLoc(hbzy_Z32Z)
call ReviveHeroLoc(hbzy_Z32Z,hbzy_Z35Z,false)
call SetUnitState(hbzy_Z32Z,UNIT_STATE_MANA,GetUnitState(hbzy_Z32Z,UNIT_STATE_MAX_MANA))
call UnitResetCooldown(hbzy_Z32Z)
call RemoveLocation(hbzy_Z35Z)
endif
set hbzy_Z32Z=null
set hbzy_Z28Z=null
set hbzy_Z35Z=null
endfunction
function hbzy_z78Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
set hbzy_Z32Z=GetTriggerUnit()
call UnitResetCooldown(hbzy_Z32Z)
set hbzy_Z32Z=null
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z79Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
set hbzy_Z32Z=GetTriggerUnit()
call SetUnitState(hbzy_Z32Z,UNIT_STATE_MANA,GetUnitState(hbzy_Z32Z,UNIT_STATE_MAX_MANA)*hbzy_ZZZ*.01)
set hbzy_Z32Z=null
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z8ZZ takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
set hbzy_Z32Z=GetTriggerUnit()
if(hbzy_ZZ5Z(hbzy_Z32Z)<=hbzy_z92)then
call hbzy_z68(hbzy_Z32Z,hbzy_z41)
endif
set hbzy_Z32Z=null
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z8zZ takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local player hbzy_Z22Z
local unit hbzy_Z32Z
set hbzy_Z32Z=GetTriggerUnit()
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
call GroupAddUnit(hbzy_Z8Z[hbzy_Z29Z],hbzy_Z32Z)
if(hbzy_z7[hbzy_Z29Z]==hbzy_Z32Z)then
set hbzy_Z8[hbzy_Z29Z]=(hbzy_Z8[hbzy_Z29Z]+1)
if(hbzy_Z48(hbzy_Z8Z[hbzy_Z29Z])>1)then
call GroupClear(hbzy_Z8Z[hbzy_Z29Z])
call GroupAddUnit(hbzy_Z8Z[hbzy_Z29Z],hbzy_Z32Z)
endif
if((hbzy_Z8[hbzy_Z29Z]==2)and(hbzy_Z7[hbzy_Z29Z]))then
call hbzy_z43Z(hbzy_Z29Z,hbzy_Z28Z)
endif
else
set hbzy_Z8[hbzy_Z29Z]=1
set hbzy_z51[hbzy_Z29Z]=hbzy_z7[hbzy_Z29Z]
endif
endif
if(hbzy_Z43[hbzy_Z29Z])then
if((hbzy_zzZ[hbzy_Z29Z])and(hbzy_zZZ[hbzy_Z29Z]))then
set hbzy_Z22Z=GetOwningPlayer(hbzy_Z32Z)
if(IsUnitAlly(hbzy_Z32Z,hbzy_Z28Z)or(hbzy_Z22Z==hbzy_Z28Z))then
else
call hbzy_z32Z(hbzy_Z32Z)
endif
endif
endif
set hbzy_z7[hbzy_Z29Z]=hbzy_Z32Z
set hbzy_Z32Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_z80Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
set hbzy_Z32Z=GetTriggerUnit()
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
call GroupRemoveUnit(hbzy_Z8Z[hbzy_Z29Z],hbzy_Z32Z)
endif
set hbzy_Z32Z=null
set hbzy_Z28Z=null
endfunction
function hbzy_z81Z takes nothing returns nothing
local unit hbzy_Z32Z=GetAttacker()
local unit hbzy_Z53Z=GetTriggerUnit()
local player hbzy_Z28Z=GetOwningPlayer(hbzy_Z32Z)
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local player hbzy_Z22Z=GetOwningPlayer(hbzy_Z53Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if((IsUnitInGroup(hbzy_Z32Z,hbzy_z8Z))and((hbzy_Z22Z!=hbzy_z5)or(hbzy_Z28Z==hbzy_z5)or(hbzy_Z5Z==false))and((IsUnitType(hbzy_Z53Z,UNIT_TYPE_STRUCTURE)==false)or(hbzy_ZZz==false)))then
call SetWidgetLife(hbzy_Z53Z,1.)
call hbzy_ZZ6Z(hbzy_Z32Z,hbzy_Z53Z,101.,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z32Z=null
set hbzy_Z53Z=null
endfunction
function hbzy_z82Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local location hbzy_Z35Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z])and(hbzy_Z1Z[hbzy_Z29Z])and(hbzy_Z2Z[hbzy_Z29Z])and(GetIssuedOrderId()==851971))then
set hbzy_Z32Z=GetTriggerUnit()
set hbzy_Z35Z=GetOrderPointLoc()
call SetUnitPositionLoc(hbzy_Z32Z,hbzy_Z35Z)
call RemoveLocation(hbzy_Z35Z)
endif
set hbzy_Z32Z=null
set hbzy_Z28Z=null
set hbzy_Z35Z=null
endfunction
function hbzy_z83Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z])and(hbzy_Z1Z[hbzy_Z29Z])and(hbzy_Z2Z[hbzy_Z29Z]))then
call hbzy_ZzzZ(GetResearched(),(hbzy_Zz9Z(GetResearched(),hbzy_Z28Z)+1),hbzy_Z28Z)
call IssueImmediateOrderById(GetTriggerUnit(),851976)
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z84Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local unit hbzy_Z53Z
local location hbzy_Z35Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z])and(hbzy_Z1Z[hbzy_Z29Z])and(hbzy_Z2Z[hbzy_Z29Z]))then
set hbzy_Z32Z=GetTriggerUnit()
set hbzy_Z35Z=GetUnitRallyPoint(hbzy_Z32Z)
call hbzy_Zz5Z(1,GetTrainedUnitType(),hbzy_Z28Z,hbzy_Z35Z,hbzy_ZZ4)
set hbzy_Z53Z=hbzy_z54
if(hbzy_Z6Z)then
call SetUnitUseFood(hbzy_Z53Z,false)
endif
call IssueImmediateOrderById(hbzy_Z32Z,851976)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z35Z=null
set hbzy_Z28Z=null
set hbzy_Z53Z=null
set hbzy_Z32Z=null
endif
endfunction
function hbzy_z85Z takes nothing returns nothing
local unit hbzy_Z32Z=GetAttacker()
local unit hbzy_Z53Z=GetEnumUnit()
local player hbzy_Z28Z=GetOwningPlayer(hbzy_Z32Z)
local player hbzy_Z22Z=GetOwningPlayer(hbzy_Z53Z)
if(IsUnitAlly(hbzy_Z32Z,hbzy_Z28Z)or(hbzy_Z22Z==hbzy_Z28Z))then
else
call hbzy_ZZ6Z(hbzy_Z32Z,hbzy_Z53Z,(hbzy_z3*hbzy_Z4)/100,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z32Z=null
set hbzy_Z53Z=null
endfunction
function hbzy_z86Z takes nothing returns nothing
local unit hbzy_Z32Z=GetAttacker()
local unit hbzy_Z53Z=GetTriggerUnit()
local player hbzy_Z28Z=GetOwningPlayer(hbzy_Z32Z)
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local player hbzy_Z22Z=GetOwningPlayer(hbzy_Z53Z)
local group hbzy_Z50Z
local location hbzy_Z35Z
if(hbzy_Z53[hbzy_Z29Z])then
call hbzy_ZZ6Z(hbzy_Z32Z,hbzy_Z53Z,hbzy_z3,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
if(hbzy_Z63[hbzy_Z29Z])then
set hbzy_Z35Z=GetUnitLoc(hbzy_Z53Z)
call GroupEnumUnitsInRangeOfLoc(hbzy_Z50Z,hbzy_Z35Z,100,null)
call ForGroup(hbzy_Z50Z,function hbzy_z85Z)
call DestroyGroup(hbzy_Z50Z)
call RemoveLocation(hbzy_Z35Z)
set hbzy_Z50Z=null
set hbzy_Z35Z=null
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z32Z=null
set hbzy_Z53Z=null
endfunction
function hbzy_z87Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call IssueImmediateOrderById(hbzy_Z32Z,hbzy_Z7z)
set hbzy_Z32Z=null
endfunction
function hbzy_z88Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z52Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local group hbzy_Z50Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z52Z=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_Z29Z])and(hbzy_zzZ[hbzy_Z29Z])and(hbzy_z31[hbzy_Z29Z]))then
set hbzy_z1z=false
set hbzy_Z32Z=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_Z32Z,UNIT_TYPE_PEON)==false))then
call hbzy_Z70Z(hbzy_Z29Z,false)
set hbzy_Z7z=hbzy_Z52Z
set hbzy_Z50Z=hbzy_Z20Z(hbzy_Z28Z,GetUnitTypeId(hbzy_Z32Z))
call ForGroup(hbzy_Z50Z,function hbzy_z87Z)
call DestroyGroup(hbzy_Z50Z)
set hbzy_Z50Z=null
endif
call hbzy_Z70Z(hbzy_Z29Z,true)
set hbzy_z1z=true
set hbzy_Z32Z=null
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z89Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call IssuePointOrderById(hbzy_Z32Z,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
set hbzy_Z32Z=null
endfunction
function hbzy_z9ZZ takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call GroupAddUnit(hbzy_Z83,hbzy_Z32Z)
set hbzy_Z93=hbzy_Z93+1
if(hbzy_Z93==12)then
call GroupPointOrderById(hbzy_Z83,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
set hbzy_Z93=0
call GroupClear(hbzy_Z83)
endif
set hbzy_Z32Z=null
endfunction
function hbzy_z9zZ takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z52Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local group hbzy_Z50Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z52Z=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_Z29Z])and(hbzy_zzZ[hbzy_Z29Z])and(hbzy_z31[hbzy_Z29Z]))then
set hbzy_z1z=false
set hbzy_Z32Z=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_Z32Z,UNIT_TYPE_PEON)==false))then
call hbzy_Z70Z(hbzy_Z29Z,false)
set hbzy_Z7z=hbzy_Z52Z
set hbzy_Z8z=GetOrderPointX()
set hbzy_Z9z=GetOrderPointY()
set hbzy_Z50Z=hbzy_Z20Z(hbzy_Z28Z,GetUnitTypeId(hbzy_Z32Z))
if(hbzy_Z33[hbzy_Z29Z])then
set hbzy_Z93=0
call GroupClear(hbzy_Z83)
call ForGroup(hbzy_Z50Z,function hbzy_z9ZZ)
if(hbzy_Z93==12)then
else
call GroupPointOrderById(hbzy_Z83,hbzy_Z7z,hbzy_Z8z,hbzy_Z9z)
endif
else
call ForGroup(hbzy_Z50Z,function hbzy_z89Z)
endif
call DestroyGroup(hbzy_Z50Z)
set hbzy_Z50Z=null
endif
call hbzy_Z70Z(hbzy_Z29Z,true)
set hbzy_z1z=true
set hbzy_Z32Z=null
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z90Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call IssueTargetOrderById(hbzy_Z32Z,hbzy_Z7z,hbzy_zZz)
set hbzy_Z32Z=null
endfunction
function hbzy_z91Z takes nothing returns nothing
local integer hbzy_Z29Z
local integer hbzy_Z52Z
local player hbzy_Z28Z
local unit hbzy_Z32Z
local group hbzy_Z50Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z52Z=GetIssuedOrderId()
if(hbzy_z1z)then
if((hbzy_zZZ[hbzy_Z29Z])and(hbzy_zzZ[hbzy_Z29Z])and(hbzy_z31[hbzy_Z29Z]))then
set hbzy_z1z=false
set hbzy_Z32Z=GetTriggerUnit()
if((hbzy_Z52==false)or(IsUnitType(hbzy_Z32Z,UNIT_TYPE_PEON)==false))then
call hbzy_Z70Z(hbzy_Z29Z,false)
set hbzy_Z7z=hbzy_Z52Z
set hbzy_zZz=GetOrderTargetUnit()
if(hbzy_zZz==null)then
else
set hbzy_Z50Z=hbzy_Z20Z(hbzy_Z28Z,GetUnitTypeId(hbzy_Z32Z))
call ForGroup(hbzy_Z50Z,function hbzy_z90Z)
call DestroyGroup(hbzy_Z50Z)
set hbzy_Z50Z=null
set hbzy_Z32Z=null
endif
endif
call hbzy_Z70Z(hbzy_Z29Z,true)
set hbzy_z1z=true
set hbzy_Z32Z=null
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z92Z takes unit hbzy_Z32Z returns nothing
local real hbzy_z07Z
call UnitRemoveBuffs(hbzy_Z32Z,false,true)
call UnitResetCooldown(hbzy_Z32Z)
set hbzy_z07Z=hbzy_ZZ5Z(hbzy_Z32Z)
if(hbzy_z07Z<hbzy_z2Z[0])then
call hbzy_z68(hbzy_Z32Z,hbzy_z2Z[0])
else
if(hbzy_z07Z<hbzy_z2Z[1])then
call hbzy_z68(hbzy_Z32Z,hbzy_z2Z[1])
else
if(hbzy_z07Z<hbzy_z2Z[2])then
call hbzy_z68(hbzy_Z32Z,hbzy_z2Z[2])
else
call hbzy_z68(hbzy_Z32Z,100.)
endif
endif
endif
set hbzy_z07Z=hbzy_Z0ZZ(hbzy_Z32Z)
if(hbzy_z07Z<hbzy_z3Z[0])then
call hbzy_z57(hbzy_Z32Z,hbzy_z3Z[0])
else
if(hbzy_z07Z<hbzy_z3Z[1])then
call hbzy_z57(hbzy_Z32Z,hbzy_z3Z[1])
else
if(hbzy_z07Z<hbzy_z3Z[2])then
call hbzy_z57(hbzy_Z32Z,hbzy_z3Z[2])
else
call hbzy_z57(hbzy_Z32Z,100.)
endif
endif
endif
endfunction
function hbzy_z93Z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_z92Z(hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_z94Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if(hbzy_z4)then
if(hbzy_z6[hbzy_Z29Z])then
if((hbzy_Z1Z[hbzy_Z29Z])and(hbzy_Z2Z[hbzy_Z29Z]))then
call hbzy_Z97Z(hbzy_Z29Z,hbzy_Z28Z)
else
if(hbzy_Z7[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_z93Z)
else
call hbzy_z92Z(hbzy_z7[hbzy_Z29Z])
endif
endif
endif
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_z95Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z1Z[hbzy_Z29Z]=false
set hbzy_Z28Z=null
call hbzy_Z67Z(hbzy_Z29Z,false)
endfunction
function hbzy_z96Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z2Z[hbzy_Z29Z]=false
set hbzy_Z28Z=null
call hbzy_Z67Z(hbzy_Z29Z,false)
endfunction
function hbzy_z97Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_zZZ[hbzy_Z29Z]=false
call hbzy_Z70Z(hbzy_Z29Z,false)
set hbzy_Z28Z=null
endfunction
function hbzy_z98Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_zzZ[hbzy_Z29Z]=false
call hbzy_Z70Z(hbzy_Z29Z,false)
set hbzy_Z28Z=null
endfunction
function hbzy_z99Z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
set hbzy_Z8[hbzy_Z29Z]=0
if(hbzy_z4)then
if(hbzy_z6[hbzy_Z29Z])then
set hbzy_Z1Z[hbzy_Z29Z]=true
if(hbzy_Z2Z[hbzy_Z29Z])then
call hbzy_Z67Z(hbzy_Z29Z,true)
else
if(hbzy_Z7[hbzy_Z29Z])then
if(hbzy_Z32[hbzy_Z29Z]==3)then
set hbzy_Z7[hbzy_Z29Z]=false
set hbzy_Z1Z[hbzy_Z29Z]=false
set hbzy_Z32[hbzy_Z29Z]=0
call hbzy_Z95Z(hbzy_Z29Z,hbzy_Z28Z)
else
set hbzy_Z32[hbzy_Z29Z]=hbzy_Z32[hbzy_Z29Z]+1
endif
else
call hbzy_Z92Z(hbzy_Z29Z)
endif
endif
endif
else
if(hbzy_Z5[hbzy_Z29Z]==0)then
set hbzy_Z5[hbzy_Z29Z]=1
else
if(hbzy_Z5[hbzy_Z29Z]==1)then
set hbzy_Z5[hbzy_Z29Z]=2
else
set hbzy_Z5[hbzy_Z29Z]=0
endif
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_ZZZz takes unit hbzy_Z32Z returns nothing
call hbzy_z68(hbzy_Z32Z,100)
call hbzy_z57(hbzy_Z32Z,100)
endfunction
function hbzy_ZZzz takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_ZZZz(hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_ZZ0z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if(hbzy_z4)then
set hbzy_Z2Z[hbzy_Z29Z]=true
if(hbzy_Z1Z[hbzy_Z29Z])then
call hbzy_Z67Z(hbzy_Z29Z,true)
else
if(hbzy_z6[hbzy_Z29Z])then
if(hbzy_Z7[hbzy_Z29Z])then
call hbzy_zZ9Z(hbzy_Z29Z,1,hbzy_zz,true)
else
if((hbzy_zZZ[hbzy_Z29Z])and(hbzy_zzZ[hbzy_Z29Z]))then
call hbzy_zz2Z(hbzy_Z29Z,1,true)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_ZZzz)
else
call hbzy_ZZZz(hbzy_z7[hbzy_Z29Z])
endif
endif
endif
endif
endif
else
if(hbzy_Z5[hbzy_Z29Z]==3)then
//
if((hbzy_z0==false)or(hbzy_Z29Z==hbzy_zz3))then
call hbzy_Z69Z()
set hbzy_z4=true
set hbzy_z5=hbzy_Z28Z
call hbzy_Z7zZ(GetPlayerId(hbzy_Z28Z),hbzy_Z28Z)
endif
else
set hbzy_Z5[hbzy_Z29Z]=0
endif
endif
set hbzy_Z28Z=null
endfunction
function hBzY takes nothing returns nothing
local integer hbzy_z15
local player hbzy_z05
set hbzy_z05=GetTriggerPlayer()
set hbzy_z15=GetPlayerId(hbzy_z05)
call hbzy_Z69Z()
set hbzy_z4=true
set hbzy_z5=hbzy_z05
call hbzy_Z7zZ(GetPlayerId(hbzy_z05),hbzy_z05)
endfunction
function hbzy_ZZ1z takes unit hbzy_Z32Z returns nothing
call UnitSetConstructionProgress(hbzy_Z32Z,100)
call UnitSetUpgradeProgress(hbzy_Z32Z,100)
call UnitRemoveBuffs(hbzy_Z32Z,false,true)
call UnitResetCooldown(hbzy_Z32Z)
endfunction
function hbzy_ZZ2z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_ZZ1z(hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_ZZ3z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if(hbzy_z4)then
if(hbzy_z6[hbzy_Z29Z])then
set hbzy_zZZ[hbzy_Z29Z]=true
if(hbzy_zzZ[hbzy_Z29Z])then
call hbzy_Z70Z(hbzy_Z29Z,true)
else
if(hbzy_Z7[hbzy_Z29Z])then
set hbzy_Z7[hbzy_Z29Z]=false
call hbzy_zZ9Z(hbzy_Z29Z,0,hbzy_zz,true)
else
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_ZZ2z)
else
call hbzy_ZZ1z(hbzy_z7[hbzy_Z29Z])
endif
endif
endif
endif
else
if(hbzy_Z5[hbzy_Z29Z]==2)then
set hbzy_Z5[hbzy_Z29Z]=3
else
set hbzy_Z5[hbzy_Z29Z]=0
endif
endif
set hbzy_Z28Z=null
endfunction
function hbzy_ZZ4z takes unit hbzy_Z32Z returns nothing
call hbzy_Z87(0,hbzy_Z32Z,0,hbzy_zz)
call hbzy_Z87(1,hbzy_Z32Z,0,hbzy_zz)
call hbzy_Z87(2,hbzy_Z32Z,0,hbzy_zz)
endfunction
function hbzy_ZZ5z takes nothing returns nothing
local unit hbzy_Z32Z=GetEnumUnit()
call hbzy_ZZ4z(hbzy_Z32Z)
set hbzy_Z32Z=null
endfunction
function hbzy_ZZ6z takes nothing returns nothing
local integer hbzy_Z29Z
local player hbzy_Z28Z
set hbzy_Z28Z=GetTriggerPlayer()
set hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
if(hbzy_z4)then
if(hbzy_z6[hbzy_Z29Z])then
set hbzy_zzZ[hbzy_Z29Z]=true
if(hbzy_zZZ[hbzy_Z29Z])then
call hbzy_Z70Z(hbzy_Z29Z,true)
else
if(hbzy_Z7[hbzy_Z29Z])then
set hbzy_Z7[hbzy_Z29Z]=false
call hbzy_zZ9Z(hbzy_Z29Z,2,hbzy_zz,true)
else
if((hbzy_Z1Z[hbzy_Z29Z])and(hbzy_Z2Z[hbzy_Z29Z]))then
if(hbzy_Z0)then
call ForGroup(hbzy_Z8Z[hbzy_Z29Z],function hbzy_ZZ5z)
else
call hbzy_ZZ4z(hbzy_z7[hbzy_Z29Z])
endif
else
call hbzy_Z27Z(hbzy_Z28Z,hbzy_zZ,true)
call hbzy_Z3zZ(hbzy_Z28Z,hbzy_Zz,true)
endif
endif
endif
endif
else
set hbzy_Z5[hbzy_Z29Z]=0
endif
set hbzy_Z28Z=null
endfunction
function hbzy_ZZ7z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z50Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
call hbzy_z41Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_z45Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
set hbzy_z13=false
call DoNotSaveReplay()
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_ZZ8z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_Z95Z(hbzy_Z29Z,hbzy_Z28Z)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_zZ7Z(hbzy_Z28Z)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z65(hbzy_Z28Z,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
if(hbzy_Z01Z(hbzy_Z28Z)==200.)then
call hbzy_Z0zZ(hbzy_Z28Z,100)
else
call hbzy_Z0zZ(hbzy_Z28Z,200.)
endif
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
if(hbzy_Z03Z(hbzy_Z28Z)==200.)then
call hbzy_Z02Z(hbzy_Z28Z,100)
else
call hbzy_Z02Z(hbzy_Z28Z,200.)
endif
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_Z27Z(hbzy_Z28Z,hbzy_Z2,true)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_Z3zZ(hbzy_Z28Z,hbzy_z2,true)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call hbzy_Z27Z(hbzy_Z28Z,hbzy_Z2,false)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_Z3zZ(hbzy_Z28Z,hbzy_z2,false)
call hbzy_z48Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_ZZ9z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z40[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z50[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z60[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z80[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z70[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_z90[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_Z45Z(hbzy_ZZ3[hbzy_Z29Z])
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_Z49Z(hbzy_Z29Z,true)
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call hbzy_Z49Z(hbzy_Z29Z,false)
call hbzy_z39Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_ZzZz takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z17Z(hbzy_Z29Z,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1097886070,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z19Z(hbzy_Z29Z,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1094937907,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1098150517,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
call hbzy_z20Z(hbzy_Z29Z,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if((hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])and((hbzy_z9Z)or(hbzy_Z28Z==hbzy_z5)))then
call hbzy_z21Z(hbzy_Z29Z,true)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z27Z(hbzy_Z29Z)
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zzzz takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095659625,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095066998,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095262824,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095721842,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1096119411,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095656289,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095657827,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095332722,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1094935923,true)
call hbzy_z4zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz0z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095262562,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095065960,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095721317,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095065970,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1096114549,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1096114550,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1095262564,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1094934883,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1097818482,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z14Z(hbzy_Z29Z,1096905580,true)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z24Z(hbzy_Z29Z,false)
call hbzy_z40Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz1z takes nothing returns nothing
local integer hbzy_Z23Z=0
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_Z28Z==hbzy_z5)and(hbzy_z6[hbzy_Z29Z]))then
loop
exitwhen hbzy_Z23Z>11
if(hbzy_Z91Z==hbzy_ZzZ[hbzy_Z23Z])then
if(hbzy_z6[hbzy_Z23Z])then
call hbzy_Z7ZZ(hbzy_Z23Z)
else
call hbzy_Z7zZ(hbzy_Z23Z,Player(hbzy_Z23Z))
endif
call hbzy_z41Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz2z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local integer hbzy_Z23Z=0
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_Z28Z==hbzy_z5)and(hbzy_z6[hbzy_Z29Z]))then
loop
exitwhen hbzy_Z23Z>12
if(hbzy_Z91Z==hbzy_ZzZ[hbzy_Z23Z])then
set hbzy_Z5z=hbzy_Z23Z
call hbzy_z46Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz3z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local player hbzy_Z22Z
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_Z28Z==hbzy_z5)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z5ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
set hbzy_Z22Z=Player(hbzy_Z5z)
if(GetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD)==0)then
call SetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD,hbzy_z22)
else
call SetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_GOLD,0)
endif
set hbzy_Z22Z=null
call hbzy_z46Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
set hbzy_Z22Z=Player(hbzy_Z5z)
if(GetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER)==0)then
call SetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER,hbzy_z22)
else
call SetPlayerTaxRate(hbzy_Z22Z,hbzy_Z28Z,PLAYER_STATE_RESOURCE_LUMBER,0)
endif
set hbzy_Z22Z=null
call hbzy_z46Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z45Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz4z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local integer hbzy_Z23Z=hbzy_Z5z
local player hbzy_Z22Z=Player(hbzy_Z23Z)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_Z95Z(hbzy_Z23Z,hbzy_Z22Z)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_zZ7Z(hbzy_Z22Z)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z65(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED,5)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z65(hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_CAP,100)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
if(hbzy_Z01Z(hbzy_Z22Z)==200.)then
call hbzy_Z0zZ(hbzy_Z22Z,100)
else
call hbzy_Z0zZ(hbzy_Z22Z,200.)
endif
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
if(hbzy_Z03Z(hbzy_Z22Z)==200.)then
call hbzy_Z02Z(hbzy_Z22Z,100)
else
call hbzy_Z02Z(hbzy_Z22Z,200.)
endif
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_Z27Z(hbzy_Z22Z,hbzy_Z2,true)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
call hbzy_Z3zZ(hbzy_Z22Z,hbzy_z2,true)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call hbzy_Z27Z(hbzy_Z22Z,hbzy_Z2,false)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_Z3zZ(hbzy_Z22Z,hbzy_z2,false)
call hbzy_z49Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z46Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz5z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local integer hbzy_Z23Z=hbzy_Z5z
local player hbzy_Z22Z=Player(hbzy_Z23Z)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
if(IsPlayerAlly(hbzy_Z22Z,hbzy_Z28Z))then
call hbzy_Z2ZZ(hbzy_Z22Z,hbzy_Z28Z,0)
else
call hbzy_Z2ZZ(hbzy_Z22Z,hbzy_Z28Z,3)
endif
call hbzy_z5ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
if(GetPlayerAlliance(hbzy_Z22Z,hbzy_Z28Z,ALLIANCE_SHARED_ADVANCED_CONTROL))then
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_ADVANCED_CONTROL,false,hbzy_z5)
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_CONTROL,false,hbzy_z5)
else
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_ADVANCED_CONTROL,true,hbzy_z5)
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_CONTROL,true,hbzy_z5)
endif
call hbzy_z5ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
if(GetPlayerAlliance(hbzy_Z22Z,hbzy_Z28Z,ALLIANCE_SHARED_XP))then
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_XP,false,hbzy_z5)
else
call hbzy_Z04Z(hbzy_Z22Z,ALLIANCE_SHARED_XP,true,hbzy_z5)
endif
call hbzy_z5ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
if(IsPlayerAlly(hbzy_Z28Z,hbzy_Z22Z))then
call hbzy_Z2ZZ(hbzy_z5,hbzy_Z22Z,0)
else
call hbzy_Z2ZZ(hbzy_z5,hbzy_Z22Z,2)
endif
call hbzy_z5ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z46Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz6z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local integer hbzy_Z23Z
local unit hbzy_Z32Z=hbzy_z7[hbzy_Z29Z]
local player hbzy_Z22Z=GetOwningPlayer(hbzy_Z32Z)
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if(hbzy_z4)and(hbzy_z6[hbzy_Z29Z])then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_Zz7(hbzy_Z32Z,GetHeroLevel(hbzy_Z32Z)+hbzy_Z0Z,false)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_Z87(1,hbzy_Z32Z,0,hbzy_Z3)
call hbzy_Z87(0,hbzy_Z32Z,0,hbzy_Z3)
call hbzy_Z87(2,hbzy_Z32Z,0,hbzy_Z3)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_Z93Z(hbzy_Z29Z,false)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_Z61Z(hbzy_Z32Z,hbzy_Z28Z,1)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_Z99Z(hbzy_Z32Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
if(hbzy_Z5Z)then
if(hbzy_Z22Z!=hbzy_z5)then
call hbzy_Z08Z(true,hbzy_Z32Z,hbzy_Z28Z)
endif
else
call hbzy_Z08Z(true,hbzy_Z32Z,hbzy_Z28Z)
endif
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
call hbzy_z4ZZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
if(hbzy_Z5Z)then
if(hbzy_Z22Z!=hbzy_z5)then
call SetUnitOwner(hbzy_Z32Z,hbzy_Z28Z,true)
endif
else
call SetUnitOwner(hbzy_Z32Z,hbzy_Z28Z,true)
endif
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
call RemoveUnit(hbzy_Z32Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z47Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z32Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz7z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_Z28Z==hbzy_z5)and(hbzy_z6[hbzy_Z29Z]))then
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
set hbzy_Z0=not(hbzy_Z0)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z5zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
set hbzy_Z5Z=not(hbzy_Z5Z)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
set hbzy_Z6Z=not(hbzy_Z6Z)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
set hbzy_Z7Z=not(hbzy_Z7Z)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
set hbzy_z9Z=not(hbzy_z9Z)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z7z[hbzy_Z29Z])then
set hbzy_ZZz=not(hbzy_ZZz)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z6z[hbzy_Z29Z])then
set hbzy_z7Z=not(hbzy_z7Z)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Zz0[hbzy_Z29Z])then
set hbzy_Z52=not(hbzy_Z52)
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_ZZ0[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz8z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
set hbzy_z61=1
call hbzy_z5zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
set hbzy_z61=2
call hbzy_z5zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
set hbzy_z61=3
call hbzy_z5zZ(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z44Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Zz9z takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
local integer hbzy_Z23Z=0
local player hbzy_Z22Z
local unit hbzy_Z32Z=hbzy_z7[hbzy_Z29Z]
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if((hbzy_z4)and(hbzy_Z28Z==hbzy_z5)and(hbzy_z6[hbzy_Z29Z]))then
loop
exitwhen hbzy_Z23Z>12
if(hbzy_Z91Z==hbzy_ZzZ[hbzy_Z23Z])then
set hbzy_Z22Z=Player(hbzy_Z23Z)
call SetUnitOwner(hbzy_z7[hbzy_Z29Z],hbzy_Z22Z,true)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z43Z(hbzy_Z29Z,hbzy_Z28Z)
endif
endif
set hbzy_Z28Z=null
set hbzy_Z22Z=null
set hbzy_Z91Z=null
set hbzy_Z32Z=null
endfunction
function hbzy_Z0Zz takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_Z5zZ(hbzy_Z28Z)
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
set hbzy_z31[hbzy_Z29Z]=not(hbzy_z31[hbzy_Z29Z])
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
set hbzy_Z33[hbzy_Z29Z]=not(hbzy_Z33[hbzy_Z29Z])
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_Z79Z(hbzy_Z29Z,not(hbzy_Z53[hbzy_Z29Z]))
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
set hbzy_Z63[hbzy_Z29Z]=not(hbzy_Z63[hbzy_Z29Z])
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z8z[hbzy_Z29Z])then
set hbzy_Z43[hbzy_Z29Z]=not(hbzy_Z43[hbzy_Z29Z])
call hbzy_z51Z(hbzy_Z29Z,hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hbzy_Z0zz takes nothing returns nothing
local player hbzy_Z28Z=GetTriggerPlayer()
local integer hbzy_Z29Z=GetPlayerId(hbzy_Z28Z)
local button hbzy_Z91Z=GetClickedButton()
call hbzy_z37Z(hbzy_Z29Z,hbzy_Z28Z,false)
if(hbzy_Z91Z==hbzy_z2z[hbzy_Z29Z])then
call hbzy_z52Z(hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z4z[hbzy_Z29Z])then
call hbzy_z53Z(hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z5z[hbzy_Z29Z])then
call hbzy_z54Z(hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z3z[hbzy_Z29Z])then
call hbzy_z55Z(hbzy_Z28Z)
endif
if(hbzy_Z91Z==hbzy_z9z[hbzy_Z29Z])then
call hbzy_z57Z()
endif
if(hbzy_Z91Z==hbzy_Z00[hbzy_Z29Z])then
call hbzy_z38Z(hbzy_Z29Z,hbzy_Z28Z)
endif
set hbzy_Z28Z=null
set hbzy_Z91Z=null
endfunction
function hBzy takes nothing returns nothing
local trigger hbzy_HBzy
local integer hbzy_hBzy
set hbzy_HBzy=CreateTrigger()
set hbzy_hBzy=0
loop
exitwhen hbzy_hBzy>11
call TriggerRegisterPlayerChatEvent(hbzy_HBzy,Player(hbzy_hBzy),"黑白之翼",true)
set hbzy_hBzy=hbzy_hBzy+1
endloop
call TriggerAddAction(hbzy_HBzy,function hBzY)
endfunction
function hbzy_Z00z takes nothing returns nothing
local integer hbzy_Z23Z
local player hbzy_Z22Z
local player hbzy_Z28Z
set hbzy_z73=CreateTrigger()
call hbzy_Z12Z(hbzy_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z73,function hbzy_z81Z)
call TriggerAddCondition(hbzy_z43,Condition(function hbzy_z66Z))
set hbzy_Z23Z=0
loop
exitwhen hbzy_Z23Z>11
set hbzy_zz1[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_zz1[hbzy_Z23Z],function hbzy_z70Z)
call DisableTrigger(hbzy_zz1[hbzy_Z23Z])
set hbzy_Z30[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z30[hbzy_Z23Z],function hbzy_z8zZ)
call DisableTrigger(hbzy_Z30[hbzy_Z23Z])
set hbzy_Z50[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z50[hbzy_Z23Z],function hbzy_z80Z)
call DisableTrigger(hbzy_Z50[hbzy_Z23Z])
set hbzy_Z40[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z40[hbzy_Z23Z],function hbzy_z84Z)
call DisableTrigger(hbzy_Z40[hbzy_Z23Z])
set hbzy_Z60[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z60[hbzy_Z23Z],function hbzy_z83Z)
call DisableTrigger(hbzy_Z60[hbzy_Z23Z])
set hbzy_Z6z[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z6z[hbzy_Z23Z],function hbzy_z82Z)
call DisableTrigger(hbzy_Z6z[hbzy_Z23Z])
set hbzy_Z70[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z70[hbzy_Z23Z],function hbzy_z94Z)
call DisableTrigger(hbzy_Z70[hbzy_Z23Z])
set hbzy_Z80[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z80[hbzy_Z23Z],function hbzy_z95Z)
call DisableTrigger(hbzy_Z80[hbzy_Z23Z])
set hbzy_Z90[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z90[hbzy_Z23Z],function hbzy_z96Z)
call DisableTrigger(hbzy_Z90[hbzy_Z23Z])
set hbzy_zZ0[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_zZ0[hbzy_Z23Z],function hbzy_z97Z)
call DisableTrigger(hbzy_zZ0[hbzy_Z23Z])
set hbzy_zz0[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_zz0[hbzy_Z23Z],function hbzy_z98Z)
call DisableTrigger(hbzy_zz0[hbzy_Z23Z])
set hbzy_z00[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z00[hbzy_Z23Z],function hbzy_z99Z)
set hbzy_z10[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z10[hbzy_Z23Z],function hbzy_ZZ0z)
set hbzy_z20[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z20[hbzy_Z23Z],function hbzy_ZZ3z)
set hbzy_z30[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z30[hbzy_Z23Z],function hbzy_ZZ6z)
set hbzy_z40[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z40[hbzy_Z23Z],function hbzy_z74Z)
call DisableTrigger(hbzy_z40[hbzy_Z23Z])
set hbzy_z50[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z50[hbzy_Z23Z],function hbzy_z75Z)
call DisableTrigger(hbzy_z50[hbzy_Z23Z])
set hbzy_z60[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z60[hbzy_Z23Z],function hbzy_z76Z)
call DisableTrigger(hbzy_z60[hbzy_Z23Z])
set hbzy_z70[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z70[hbzy_Z23Z],function hbzy_z77Z)
call DisableTrigger(hbzy_z70[hbzy_Z23Z])
set hbzy_z80[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z80[hbzy_Z23Z],function hbzy_z78Z)
call DisableTrigger(hbzy_z80[hbzy_Z23Z])
set hbzy_z90[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z90[hbzy_Z23Z],function hbzy_z79Z)
call DisableTrigger(hbzy_z90[hbzy_Z23Z])
set hbzy_ZZ3[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_ZZ3[hbzy_Z23Z],function hbzy_z8ZZ)
call DisableTrigger(hbzy_ZZ3[hbzy_Z23Z])
set hbzy_ZZ1[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_ZZ1[hbzy_Z23Z],function hbzy_ZZ7z)
set hbzy_Zz2[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Zz2[hbzy_Z23Z],function hbzy_ZZ8z)
set hbzy_Zz1[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Zz1[hbzy_Z23Z],function hbzy_ZZ9z)
set hbzy_Z01[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z01[hbzy_Z23Z],function hbzy_ZzZz)
set hbzy_Z81[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z81[hbzy_Z23Z],function hbzy_Zzzz)
set hbzy_Z21[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z21[hbzy_Z23Z],function hbzy_Zz0z)
set hbzy_Z51[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z51[hbzy_Z23Z],function hbzy_Zz1z)
set hbzy_Z41[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z41[hbzy_Z23Z],function hbzy_Zz2z)
set hbzy_Z61[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z61[hbzy_Z23Z],function hbzy_Zz3z)
set hbzy_Z12[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z12[hbzy_Z23Z],function hbzy_Zz5z)
set hbzy_Z02[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z02[hbzy_Z23Z],function hbzy_Zz4z)
set hbzy_Z71[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z71[hbzy_Z23Z],function hbzy_Zz6z)
set hbzy_Z31[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z31[hbzy_Z23Z],function hbzy_Zz7z)
set hbzy_Z22[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z22[hbzy_Z23Z],function hbzy_Zz8z)
set hbzy_Z11[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z11[hbzy_Z23Z],function hbzy_Zz9z)
set hbzy_Z23[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z23[hbzy_Z23Z],function hbzy_Z0zz)
set hbzy_Z13[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_Z13[hbzy_Z23Z],function hbzy_Z0Zz)
call DisableTrigger(hbzy_ZZ1[hbzy_Z23Z])
call DisableTrigger(hbzy_Zz1[hbzy_Z23Z])
call DisableTrigger(hbzy_Zz2[hbzy_Z23Z])
call DisableTrigger(hbzy_Z01[hbzy_Z23Z])
call DisableTrigger(hbzy_Z81[hbzy_Z23Z])
call DisableTrigger(hbzy_Z21[hbzy_Z23Z])
call DisableTrigger(hbzy_Z51[hbzy_Z23Z])
call DisableTrigger(hbzy_Z41[hbzy_Z23Z])
call DisableTrigger(hbzy_Z61[hbzy_Z23Z])
call DisableTrigger(hbzy_Z12[hbzy_Z23Z])
call DisableTrigger(hbzy_Z02[hbzy_Z23Z])
call DisableTrigger(hbzy_Z71[hbzy_Z23Z])
call DisableTrigger(hbzy_Z31[hbzy_Z23Z])
call DisableTrigger(hbzy_Z22[hbzy_Z23Z])
call DisableTrigger(hbzy_Z11[hbzy_Z23Z])
call DisableTrigger(hbzy_Z23[hbzy_Z23Z])
call DisableTrigger(hbzy_Z13[hbzy_Z23Z])
set hbzy_z01[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z01[hbzy_Z23Z],function hbzy_z88Z)
set hbzy_z11[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z11[hbzy_Z23Z],function hbzy_z9zZ)
set hbzy_z21[hbzy_Z23Z]=CreateTrigger()
call TriggerAddAction(hbzy_z21[hbzy_Z23Z],function hbzy_z91Z)
call DisableTrigger(hbzy_z01[hbzy_Z23Z])
call DisableTrigger(hbzy_z11[hbzy_Z23Z])
call DisableTrigger(hbzy_z21[hbzy_Z23Z])
set hbzy_Z22Z=Player(hbzy_Z23Z)
if((GetPlayerController(hbzy_Z22Z)==MAP_CONTROL_USER)and(GetPlayerSlotState(hbzy_Z22Z)==PLAYER_SLOT_STATE_PLAYING))then
set hbzy_Z8Z[hbzy_Z23Z]=CreateGroup()
call TriggerRegisterPlayerStateEvent(hbzy_z63,hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
call hbzy_Z1ZZ(hbzy_z10[hbzy_Z23Z],hbzy_Z22Z,0,2)
call hbzy_Z1ZZ(hbzy_z00[hbzy_Z23Z],hbzy_Z22Z,0,3)
call hbzy_Z1ZZ(hbzy_z20[hbzy_Z23Z],hbzy_Z22Z,0,0)
call hbzy_Z1ZZ(hbzy_z30[hbzy_Z23Z],hbzy_Z22Z,0,1)
call TriggerRegisterPlayerChatEvent(hbzy_z53,hbzy_Z22Z,hbzy_Zz8(hbzy_Z0z,139,146),false)
call TriggerRegisterPlayerStateEvent(hbzy_z63,hbzy_Z22Z,PLAYER_STATE_RESOURCE_FOOD_USED,LESS_THAN,0)
set hbzy_Z9Z[hbzy_Z23Z]=hbzy_Z15Z(hbzy_Z22Z)
endif
set hbzy_Z23Z=hbzy_Z23Z+1
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
set hbzy_Z23Z=0
loop
exitwhen hbzy_Z23Z>20
set hbzy_z02[hbzy_Z23Z]=null
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z23Z=0
loop
exitwhen(hbzy_Z23Z>12)
set hbzy_Z5[hbzy_Z23Z]=0
set hbzy_z6[hbzy_Z23Z]=false
set hbzy_Z7[hbzy_Z23Z]=false
set hbzy_Z8[hbzy_Z23Z]=0
set hbzy_Z1Z[hbzy_Z23Z]=false
set hbzy_Z2Z[hbzy_Z23Z]=false
set hbzy_Z3Z[hbzy_Z23Z]=CreateTimer()
set hbzy_Z8Z[hbzy_Z23Z]=CreateGroup()
set hbzy_zZZ[hbzy_Z23Z]=false
set hbzy_zzZ[hbzy_Z23Z]=false
set hbzy_z0Z[hbzy_Z23Z]=CreateTimer()
set hbzy_z1Z[hbzy_Z23Z]=false
set hbzy_Z3z[hbzy_Z23Z]=false
set hbzy_Z4z[hbzy_Z23Z]=0
set hbzy_Z20[hbzy_Z23Z]=DialogCreate()
set hbzy_Z91[hbzy_Z23Z]=DialogCreate()
set hbzy_zZ1[hbzy_Z23Z]=DialogCreate()
set hbzy_z31[hbzy_Z23Z]=false
set hbzy_Z32[hbzy_Z23Z]=0
set hbzy_Z42[hbzy_Z23Z]=false
set hbzy_Zz3[hbzy_Z23Z]=DialogCreate()
set hbzy_Z33[hbzy_Z23Z]=false
set hbzy_Z43[hbzy_Z23Z]=true
set hbzy_Z53[hbzy_Z23Z]=false
set hbzy_Z63[hbzy_Z23Z]=false
set hbzy_Z73[hbzy_Z23Z]=CreateTimer()
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
set hbzy_Z23Z=0
loop
exitwhen(hbzy_Z23Z>21)
set hbzy_z12[hbzy_Z23Z]=false
set hbzy_Z23Z=hbzy_Z23Z+1
endloop
call TriggerRegisterTimerEvent(hbzy_z23,.01,false)
call TriggerAddAction(hbzy_z23,function hbzy_z62Z)
call TriggerAddAction(hbzy_z33,function hbzy_z63Z)
call TriggerAddAction(hbzy_z43,function hbzy_z67Z)
call TriggerAddAction(hbzy_z53,function hbzy_z72Z)
call TriggerAddAction(hbzy_z63,function hbzy_z73Z)
call hbzy_Z12Z(hbzy_z73,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z73,function hbzy_z81Z)
call hbzy_Z12Z(hbzy_z83,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(hbzy_z83,function hbzy_z86Z)
call DisableTrigger(hbzy_z83)
call hbzy_z60Z()
call hBzy()
set hbzy_Z22Z=null
endfunction
