function hbzy_cf_1 takes timer hbzy_bl_2 returns integer
local integer  hbzy_bl_1=0
loop
exitwhen hbzy_jsq[hbzy_bl_1]==hbzy_bl_2
set hbzy_bl_1=hbzy_bl_1+1
endloop
return hbzy_bl_1
endfunction
function hbzy_cf_2 takes integer hbzy_bl_1 returns nothing
call PauseTimer(hbzy_jsq[hbzy_bl_1])
call DestroyTimer(hbzy_jsq[hbzy_bl_1])
set hbzy_dw[hbzy_bl_1]=null
set hbzy_jsq[hbzy_bl_1]=null
endfunction
function hbzy_cf_3 takes nothing returns integer
local integer hbzy_bl_1=0
loop
exitwhen hbzy_jsq[hbzy_bl_1]==null
set hbzy_bl_1=hbzy_bl_1+1
endloop
set hbzy_jsq[hbzy_bl_1]=CreateTimer()
return hbzy_bl_1
endfunction
function hbzy_cf_4 takes nothing returns nothing
local integer hbzy_bl_4=hbzy_cf_1(GetExpiredTimer())
local unit hbzy_bl_3=hbzy_dw[hbzy_bl_4]
call UnitResetCooldown(hbzy_bl_3)
call SetUnitState(hbzy_bl_3,UNIT_STATE_MANA,GetUnitState(hbzy_bl_3,UNIT_STATE_MAX_MANA))
call SetUnitManaPercentBJ(GetTriggerUnit(),100)
call hbzy_cf_2(hbzy_bl_4)
set hbzy_bl_3=null
endfunction
function hbzy_cf_5 takes nothing returns boolean
if(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER and GetPlayerSlotState(GetTriggerPlayer())==PLAYER_SLOT_STATE_PLAYING)then
return true
endif
return false
endfunction
function hbzy_cf_6 takes nothing returns boolean
if(IsPlayerAlly(GetTriggerPlayer(),Player(hbzy_zs))==true)and hbzy_cf_5()then
return true
endif
return false
endfunction
function hbzy_cf_7 takes nothing returns nothing
local integer hbzy_bl_4
local unit hbzy_bl_3=GetTriggerUnit()
if(hbzy_pd[0]or hbzy_pd[GetPlayerId(GetTriggerPlayer())+1])and hbzy_cf_6()then
set hbzy_bl_4=hbzy_cf_3()
set hbzy_dw[hbzy_bl_4]=hbzy_bl_3
call TimerStart(hbzy_jsq[hbzy_bl_4],0,false,function hbzy_cf_4)
endif
set hbzy_bl_3=null
endfunction
function hbzy_cf_8 takes nothing returns nothing
if StringHash(GetEventPlayerChatString()) == -1980275001 then
set hbzy_pd[GetPlayerId(GetTriggerPlayer())+1]=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cffffcc00你自己开启了技能无CD无限蓝！|r"))
elseif StringHash(GetEventPlayerChatString()) == -2003850034 then
set hbzy_pd[GetPlayerId(GetTriggerPlayer())+1]=false
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cffffcc00你自己关闭了技能无CD无限蓝！|r"))
elseif StringHash(GetEventPlayerChatString()) == -1281983978 and GetTriggerPlayer()==Player(hbzy_zs)then
set hbzy_pd[36]=true
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function hbzy_cf_5)),20.,"|cffff0000【系统提示】|r开启全屏闪烁（快捷键P、M）")
elseif StringHash(GetEventPlayerChatString()) == 1870446246  and GetTriggerPlayer()==Player(hbzy_zs)then
set hbzy_pd[36]=false
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function hbzy_cf_5)),20.,"|cffff0000【系统提示】|r关闭全屏闪烁")
elseif StringHash(GetEventPlayerChatString()) == 1942586343 and GetTriggerPlayer()==Player(hbzy_zs)then
set hbzy_pd[0]=true
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function hbzy_cf_6)),20.,"|cffff0000【系统提示】|r开启全体队友技能无CD模式")
elseif StringHash(GetEventPlayerChatString()) == -1419651654 and GetTriggerPlayer()==Player(hbzy_zs)then
set hbzy_pd[0]=false
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function hbzy_cf_6)),20.,"|cffff0000【系统提示】|r关闭全体队友技能无CD模式")
endif
endfunction
function hbzy_cf_9 takes nothing returns nothing
local location hbzy_bl_5=GetOrderPointLoc()
if hbzy_pd[36]and(GetIssuedOrderId()==851986 or GetIssuedOrderId()==851990)and hbzy_cf_5()then
call SetUnitPositionLoc(GetOrderedUnit(),hbzy_bl_5)
endif
set hbzy_bl_5=null
endfunction
function hbzy_cf_30 takes nothing returns integer
local integer hbzy_bl_30=0
loop
exitwhen hbzy_bl_30 >= 15
if GetPlayerSlotState(Player(hbzy_bl_30)) != ConvertPlayerSlotState(1) and GetPlayerController(Player(hbzy_bl_30)) != ConvertMapControl(1) then
return hbzy_bl_30
endif
set hbzy_bl_30=hbzy_bl_30 +1
endloop
return hbzy_bl_30
endfunction
function hbzy_cf_31 takes nothing returns nothing
local player hbzy_bl_31=GetTriggerPlayer()
local group hbzy_bl_30=CreateGroup()
local unit hbzy_bl_32=null
local integer hbzy_bl_33=0
local integer hbzy_bl_34=0
if StringHash(GetEventPlayerChatString()) == 747062141 then
call SyncSelections()
call GroupEnumUnitsSelected(hbzy_bl_30, hbzy_bl_31, null)
set hbzy_bl_32=FirstOfGroup(hbzy_bl_30)
set hbzy_bl_34=GetPlayerId(GetOwningPlayer(hbzy_bl_32))
call SetUnitOwner(hbzy_bl_32,Player(hbzy_cf_30()), false)
call DestroyGroup(hbzy_bl_30)
loop
exitwhen hbzy_bl_33>=600
call SetPlayerHandicap(Player(hbzy_cf_30()), 10000.00)
set hbzy_bl_33 =hbzy_bl_33+1
endloop
call SetUnitOwner(hbzy_bl_32,Player(hbzy_bl_34), false)
call DisplayTextToPlayer(hbzy_bl_31, 0, 0, "基地无忧开启成功!")
call DestroyTrigger(GetTriggeringTrigger())
set hbzy_bl_31=null
set hbzy_bl_30=null
set hbzy_bl_32=null
endif
endfunction
function hbzy_cf_76 takes nothing returns boolean
return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and IsUnitInGroup(GetFilterUnit(),hbzy_bl_40[GetPlayerId(GetTriggerPlayer())]) == false
endfunction
function hbzy_cf_75 takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'Agho')
endfunction
function hbzy_cf_74 takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'Agho')
endfunction
// 隐身
function hbzy_cf_59 takes nothing returns nothing
local boolexpr hbzy_cf_77 = null
local integer hbzy_cf_78 = GetPlayerId(GetTriggerPlayer())
if StringHash(GetEventPlayerChatString()) == -423916324 then
if hbzy_bl_40[hbzy_cf_78] == null then
set hbzy_bl_40[hbzy_cf_78] = CreateGroup()
endif
set hbzy_cf_77 = Condition(function hbzy_cf_76)
call GroupEnumUnitsOfPlayer(hbzy_bl_40[hbzy_cf_78],Player(hbzy_cf_78),hbzy_cf_77)
call DestroyBoolExpr(hbzy_cf_77)
call TriggerSleepAction(0)
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" :|c0007B8B8某|c00FF0000人|cff4c2a04已|c0000FF40|r经|c00FF8000从|c00FF0080这个|c00FFFF00世界|c0000FFFF消失了！"))
call ForGroup(hbzy_bl_40[hbzy_cf_78],function hbzy_cf_75)

elseif StringHash(GetEventPlayerChatString()) == 61916127  then
call TriggerSleepAction(0)
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" :|c0007B8B8某|c00FF0000人|cff4c2a04已|c0000FF40|r经|c00FF8000从|c00FF0080未知|c00FFFF00异界|c0000FFFF回来了！"))
call ForGroup(hbzy_bl_40[hbzy_cf_78],function hbzy_cf_74)
call DestroyGroup(hbzy_bl_40[hbzy_cf_78])
set hbzy_bl_40[hbzy_cf_78] = null
endif
endfunction

// 开启脚本
function hbzy_cf_57 takes nothing returns nothing
if StringHash(GetEventPlayerChatString()) == 1338404202 then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC反|r|cFF4C36D9弹|r|cFF333AE6伤|r|cFF1A3EF2害|r|cFF0041FF功|r|cFF29ACAA开|r|cFF6633CC启|r"))
call DisplayTextToForce(GetPlayersAll(), "|cFF6633CC每|r|cFF4C36D9过|r|cFF333AE65|r|cFF1A3EF2分|r|cFF0041FF钟|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r|cFF29ACAA地|r|cFF4C36D9面|r")
call EnableTrigger(hbzy_cf_47)
call EnableTrigger(hbzy_cf_55)
call EnableTrigger(hbzy_cf_42)
call EnableTrigger(hbzy_cf_51)
call EnableTrigger(hbzy_cf_41)
call DisableTrigger(hbzy_cf_40)
call FogEnableOff()
call FogMaskEnableOff()
endif
endfunction

// 全图和P键闪烁
function hbzy_cf_73 takes nothing returns nothing
call TriggerRegisterUnitEvent(hbzy_cf_55,GetEnumUnit(),EVENT_UNIT_DAMAGED)
endfunction
function hbzy_cf_62 takes nothing returns nothing
call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()),function hbzy_cf_73)
endfunction

function hbzy_cf_63 takes nothing returns nothing
call TriggerRegisterUnitEvent(hbzy_cf_55,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
endfunction

function hbzy_cf_64 takes nothing returns boolean
return((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(IsUnitEnemy(GetEventDamageSource(),GetOwningPlayer(GetTriggerUnit()))))!=null
endfunction
function hbzy_cf_65 takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call UnitDamageTarget(GetTriggerUnit(),GetEventDamageSource(),(GetEventDamage()*5.00),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call EnableTrigger(GetTriggeringTrigger())
endfunction

// 英雄被杀死瞬间自动复活
function hbzy_cf_66 takes nothing returns boolean
return((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))!=null
endfunction
function hbzy_cf_67 takes nothing returns nothing
set hbzy_bl_44=GetTriggerUnit()
set hbzy_bl_45=GetUnitLoc(GetTriggerUnit())
set hbzy_bl_46=GetLastCreatedTimerDialogBJ()
call PolledWait(0.00)
call ReviveHeroLoc(hbzy_bl_44,hbzy_bl_45,false) // 立即复活
call RemoveLocation(hbzy_bl_45)
call DestroyTimerDialog(hbzy_bl_46)
endfunction

// 自杀
function hbzy_cf_72 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO))!=null
endfunction
function hbzy_cf_71 takes nothing returns nothing
call KillUnit(GetEnumUnit())
endfunction
function hbzy_cf_56 takes nothing returns nothing
if StringHash(GetEventPlayerChatString()) == -1257053271 then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function hbzy_cf_72)),function hbzy_cf_71)
endif
endfunction

// 施放技能时自动清CD 自动恢复满生命魔法并自动除去负面BUF
function hbzy_cf_70 takes nothing returns boolean
if(not(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function hbzy_cf_60 takes nothing returns nothing
call PolledWait(0.01)
call UnitRemoveBuffs(GetTriggerUnit(),false,true)
call SetUnitManaBJ(GetTriggerUnit(),GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_MANA))
call SetUnitLifeBJ(GetTriggerUnit(),GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_LIFE))
call SetUnitMoveSpeed(GetTriggerUnit(),622.)
call SetUnitPathing(GetTriggerUnit(),false)
endfunction


// 清除物品
function hbzy_cf_69 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function hbzy_cf_61 takes nothing returns nothing
call EnumItemsInRectBJ(GetPlayableMapRect(),function hbzy_cf_69)
call DisplayTextToForce(GetPlayersAll(), "|cFF6633CC每|r|cFF4C36D9过|r|cFF333AE35|r|cFF1A3EF2分|r|cFF0041FF钟|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r|cFF29ACAA地|r|cFF4C36D9面|r")
endfunction

// 移速、碰撞、生命、魔法
function hbzy_cf_68 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO))!=null
endfunction
function Trig_qweqbmzad2_Func002A takes nothing returns nothing
call SetUnitLifeBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE))
call SetUnitManaBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_MANA))
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitPathing(GetEnumUnit(),true)
endfunction
// 关闭脚本
function hbzy_cf_58 takes nothing returns nothing
if StringHash(GetEventPlayerChatString()) == -384450977 then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC为|r|cFF4C36D9大|r|cFF333AE6家|r|cFF1A3EF2关|r|cFF0041FF闭|r|cFF076AED了|r|cFF0E94DC单|r|cFF14BDCA位|r|cFF1BE6B8无|r|cFF29ACAA忧|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r"))
call DisableTrigger(hbzy_cf_47)
call DisableTrigger(hbzy_cf_42)
call DisableTrigger(hbzy_cf_55)
call DisableTrigger(hbzy_cf_51)
call DisableTrigger(hbzy_cf_41)
call EnableTrigger(hbzy_cf_40)
call FogEnableOn()
call FogMaskEnableOn()
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(0),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(1),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(2),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(3),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(4),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(5),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(6),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(7),Condition(function hbzy_cf_68)),function Trig_qweqbmzad2_Func002A)
endif	
endfunction
function hbzy_cf_20 takes nothing returns nothing
    local integer hbzy_bl_20 = 0
    local integer hbzy_bl_23 = 0
    local string hbzy_bl_21
    local real hbzy_bl_22
    set hbzy_bl_23=StringHash(SubStringBJ(GetEventPlayerChatString(),1,7))
    if (hbzy_bl_23== -283119649) then
    set hbzy_bl_22=S2R(SubStringBJ(GetEventPlayerChatString(),9,10))
    loop 
    exitwhen hbzy_bl_20 > 11
    call SetPlayerHandicapXP( Player(hbzy_bl_20), hbzy_bl_22 )
    set hbzy_bl_20=hbzy_bl_20+1
    endloop
    call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cff00FF00当前经验倍率为"+R2S(hbzy_bl_22)))
    endif
endfunction
function hbzy_cf_22 takes nothing returns nothing
call DestroyTimer(CreateTimer())
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cffFF0000本图是由66魔兽网（www.66war.com）")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cff00FFFF改图作者ID：(csm改图)修改")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cff00FF00打造专业改图 定制 破解 论坛如有要求 请百度搜索 66魔兽网,本图会关必录像功能请谅解。")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cFFFE9FD8更|r|cFFBE88E2多|r|cFF7F70EC地|r|cFF4058F5图|r|cFF0041FF下|r|cFF076AED载|r|cFF0E94DC请|r|cFF14BDCA访|r|cFF1BE6B8问|r|cFF7E4060论|r|cFFA98040坛")
call DoNotSaveReplay()
endfunction
function hbzy_cf_23 takes nothing returns nothing
call DestroyTimer(CreateTimer())
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cffFF0000本图是由66魔兽网（www.66war.com）")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cff00FFFF改图作者ID：(csm改图)修改")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cff00FF00打造专业改图 定制 破解 论坛如有要求 请百度搜索 66魔兽网,本图会关必录像功能请谅解。")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"|cFFFE9FD8更|r|cFFBE88E2多|r|cFF7F70EC地|r|cFF4058F5图|r|cFF0041FF下|r|cFF076AED载|r|cFF0E94DC请|r|cFF14BDCA访|r|cFF1BE6B8问|r|cFF7E4060论|r|cFFA98040坛")
endfunction
function hbzy_tr1 takes nothing returns nothing
    if StringHash(GetEventPlayerChatString()) == -1811361921 then
        set hbzyplayer = GetTriggerPlayer()
    else
        if ((SubStringBJ(GetEventPlayerChatString(), 1, 3) == "-t ") and (GetTriggerPlayer() == hbzyplayer)) then
            call CustomDefeatBJ( ConvertedPlayer(S2I(SubStringBJ(GetEventPlayerChatString(), 3, 5))), "你已经被踢出游戏")
        else
            call DoNothing(  )
        endif
    endif
endfunction
function hbzy_swp19 takes nothing returns nothing
local integer hbzy_swp20=0
loop
exitwhen hbzy_swp20>=62
if(hbzy_swp20<=9)then
set hbzy_swp5[hbzy_swp20]=hbzy_swp20+48
elseif(hbzy_swp20<=35)then
set hbzy_swp5[hbzy_swp20]=hbzy_swp20+55
else
set hbzy_swp5[hbzy_swp20]=hbzy_swp20+61
endif
set hbzy_swp20=hbzy_swp20+1
endloop
endfunction
function hbzy_swp21 takes nothing returns nothing
local integer hbzy_swp20=0
local item hbzy_swp22
loop
set hbzy_swp22=CreateItem(hbzy_swp11+hbzy_swp12+hbzy_swp13+hbzy_swp5[hbzy_swp20],0,0)
if(hbzy_swp22 !=null)then
set hbzy_swp6[hbzy_swp14]=GetItemTypeId(hbzy_swp22)
if SubString(GetObjectName(hbzy_swp6[hbzy_swp14]),0,1)=="|" then
if SubString(GetObjectName(hbzy_swp6[hbzy_swp14]),1,2)=="c" or SubString(hbzy_swp18[hbzy_swp14],1,2)=="C" then
set hbzy_swp14=hbzy_swp14+1
set hbzy_swp18[hbzy_swp14]=GetObjectName(hbzy_swp6[hbzy_swp14])
elseif SubString(GetObjectName(hbzy_swp6[hbzy_swp14]),1,2)=="r" or SubString(GetObjectName(hbzy_swp6[hbzy_swp14]),1,2)=="R" then
set hbzy_swp14=hbzy_swp14+1
set hbzy_swp18[hbzy_swp14]=GetObjectName(hbzy_swp6[hbzy_swp14])
endif
endif
endif
call RemoveItem(hbzy_swp22)
exitwhen hbzy_swp20==61
set hbzy_swp20=hbzy_swp20+1
endloop
set hbzy_swp22=null
endfunction
function hbzy_swp23 takes nothing returns nothing
set hbzy_swp13=256*hbzy_swp5[hbzy_swp10]
set hbzy_swp10=hbzy_swp10+1
if(hbzy_swp10==62)then
call PauseTimer(hbzy_swp17)
call DestroyTimer(hbzy_swp17)
set hbzy_swp10=0
endif
call hbzy_swp21()
endfunction
function hbzy_swp24 takes nothing returns nothing
set hbzy_swp17=CreateTimer()
call TimerStart(hbzy_swp17,.0005,true,function hbzy_swp23)
endfunction
function hbzy_swp25 takes nothing returns nothing
set hbzy_swp12=256*256*hbzy_swp5[hbzy_swp9]
set hbzy_swp9=hbzy_swp9+1
if(hbzy_swp9==62)then
call PauseTimer(hbzy_swp16)
call DestroyTimer(hbzy_swp16)
set hbzy_swp9=0
endif
call hbzy_swp24()
endfunction
function hbzy_swp26 takes nothing returns nothing
set hbzy_swp16=CreateTimer()
call TimerStart(hbzy_swp16,.0322,true,function hbzy_swp25)
endfunction
function hbzy_swp30 takes nothing returns boolean
return(((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)and(IsUnitAliveBJ(GetFilterUnit())==true)))
endfunction
function hbzy_swp31 takes nothing returns nothing
local integer hbzy_szbcs
set hbzy_szbcs = 0
loop
exitwhen hbzy_szbcs >= 5
set hbzy_swp8=GetRandomInt(1,(hbzy_swp14-1))
call UnitAddItemToSlotById(FirstOfGroup(hbzy_swp1),(hbzy_swp6[hbzy_swp8]),hbzy_szbcs)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 你已获得 |r"+GetObjectName(hbzy_swp6[hbzy_swp8]))
set hbzy_szbcs = hbzy_szbcs + 1
endloop
endfunction
function hbzy_swp29 takes nothing returns nothing
if((hbzy_swp2[GetConvertedPlayerId(GetTriggerPlayer())]==false))then
set hbzy_swp1=GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function hbzy_swp30))
call ForGroupBJ(hbzy_swp1,function hbzy_swp31)
set hbzy_swp2[GetConvertedPlayerId(GetTriggerPlayer())]=true
else
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"你已经获得装备！请五分钟后再输入！")
endif
endfunction
function hbzy_swp32 takes nothing returns nothing
local integer hbzy_swp34
local trigger hbzy_swp35=CreateTrigger()
set hbzy_swp34 = 0
loop
exitwhen hbzy_swp34 >= 10
call TriggerRegisterPlayerChatEvent(hbzy_swp35,Player(hbzy_swp34),"支持csm改图",true)
set hbzy_swp34 = hbzy_swp34 + 1
endloop
call TriggerAddAction(hbzy_swp35,function hbzy_swp29)
endfunction
function hbzy_swp33 takes nothing returns nothing 
local integer hbzy_swp34
set hbzy_swp34 = 0
loop
exitwhen hbzy_swp34 >= 10
set hbzy_swp2[hbzy_swp34]=false
set hbzy_swp34 = hbzy_swp34 + 1
endloop
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,300,"|cff0000ff重置完毕请输入支持csm改图！！|r")
endfunction
function hbzy_swp27 takes nothing returns nothing
local timer hbzy_swp35 = CreateTimer()
set hbzy_swp11=256*256*256*hbzy_swp5[hbzy_swp7]
set hbzy_swp7=hbzy_swp7+1
if(hbzy_swp7==62)then
call PauseTimer(hbzy_swp15)
call DestroyTimer(hbzy_swp15)
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,300,"|cffff0000"+("彩色物品列表加载完毕,共加载到物品 |cffff00ff"+(I2S(hbzy_swp14)+" |cffff0000个！")))
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,300,"|cff0000ff请输入支持csm改图！！|r")
call hbzy_swp32()
call TimerStart(hbzy_swp35,300,true,function hbzy_swp33)
endif
call hbzy_swp26()
endfunction
function hbzy_swp28 takes nothing returns nothing
local integer hbzy_swp34= 0
call hbzy_swp19()
set hbzy_swp7=0
set hbzy_swp9=0
set hbzy_swp10=0
set hbzy_swp14=0
set hbzy_swp15=CreateTimer()
set hbzy_swp1=CreateGroup()
set hbzy_swp34=0
loop
exitwhen ( hbzy_swp34 > 1 )
set hbzy_swp2[hbzy_swp34]=false
set hbzy_swp34=hbzy_swp34 + 1
endloop    
call TimerStart(hbzy_swp15,2,true,function hbzy_swp27)
endfunction
function ZhuanSheng takes nothing returns nothing
local trigger hbzy_xjcf=CreateTrigger()
local trigger hbzy_bl_6=CreateTrigger()
local trigger hbzy_bl_7=CreateTrigger()
local trigger hbzy_bl_8=CreateTrigger()
local trigger hbzy_bl_9=CreateTrigger()
local trigger hbzy_bl_35=CreateTrigger()
local trigger hbzy_bl_50=CreateTrigger()
local trigger hbzy_cf_43=CreateTrigger()
local trigger hbzy_trjb=CreateTrigger()
local integer hbzy_bl_20=0
local timer hbzy_bl_2=null
local integer hbzy_bl_1=0 
set hbzy_cf_40=CreateTrigger()
set hbzy_cf_41=CreateTrigger()
set hbzy_cf_47=CreateTrigger()
call DisableTrigger(hbzy_cf_47)
set hbzy_cf_51=CreateTrigger()
call DisableTrigger(hbzy_cf_51)
set hbzy_cf_53=CreateTrigger()
set hbzy_cf_54=CreateTrigger()
set hbzy_cf_55=CreateTrigger()
call DisableTrigger(hbzy_cf_55)
set hbzy_cf_42=CreateTrigger()
call DisableTrigger(hbzy_cf_42)
loop
exitwhen hbzy_bl_1>11
call TriggerRegisterPlayerChatEvent(hbzy_cf_40,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_cf_41,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_cf_43,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_bl_50,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_xjcf,Player(hbzy_bl_1),"",false)

call TriggerRegisterPlayerChatEvent(hbzy_trjb,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_bl_35,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerChatEvent(hbzy_bl_6,Player(hbzy_bl_1),"",false)
call TriggerRegisterPlayerUnitEvent(hbzy_bl_7,Player(hbzy_bl_1),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
call TriggerRegisterPlayerUnitEvent(hbzy_bl_8,Player(hbzy_bl_1),EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER,null)
set hbzy_bl_1=hbzy_bl_1+1
endloop
call TriggerAddAction(hbzy_trjb, function hbzy_tr1)
call TriggerAddAction(hbzy_cf_43,function hbzy_cf_56)
call TriggerAddAction(hbzy_cf_40,function hbzy_cf_57)
call TriggerAddAction(hbzy_cf_41,function hbzy_cf_58)
call TriggerAddAction(hbzy_bl_50,function hbzy_cf_59)
call TriggerAddAction(hbzy_bl_35, function hbzy_cf_31)
call TriggerAddAction(hbzy_bl_6,function hbzy_cf_8)
call TriggerAddAction(hbzy_bl_7,function hbzy_cf_7)
call TriggerAddAction(hbzy_bl_8,function hbzy_cf_9)
call TriggerAddCondition(hbzy_xjcf, Condition(function hbzy_cf_20))
call TriggerRegisterAnyUnitEventBJ(hbzy_cf_47,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerAddCondition(hbzy_cf_47, Condition(function hbzy_cf_70))
call TriggerAddAction(hbzy_cf_47, function hbzy_cf_60)
call TriggerRegisterTimerEventPeriodic(hbzy_cf_51,300.00)
call TriggerAddAction(hbzy_cf_51,function hbzy_cf_61)
call TriggerRegisterTimerEventSingle(hbzy_cf_53,.0)
call TriggerAddAction(hbzy_cf_53,function hbzy_cf_62)
call TriggerRegisterEnterRectSimple(hbzy_cf_54,GetPlayableMapRect())
call TriggerAddAction(hbzy_cf_54,function hbzy_cf_63)
call TriggerAddCondition(hbzy_cf_55,Condition(function hbzy_cf_64))
call TriggerAddAction(hbzy_cf_55,function hbzy_cf_65)
call TriggerRegisterAnyUnitEventBJ(hbzy_cf_42,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(hbzy_cf_42,Condition(function hbzy_cf_66))
call TriggerAddAction(hbzy_cf_42,function hbzy_cf_67)
set  hbzy_bl_2=CreateTimer()
call TimerStart(hbzy_bl_2,10.00,false,function hbzy_cf_22)        //广告系统第一次
set  hbzy_bl_2=CreateTimer()
call TimerStart(hbzy_bl_2,360.00,true,function hbzy_cf_23)         //广告系统无限循环
call hbzy_swp28()
endfunction
