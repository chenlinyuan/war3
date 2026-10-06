function Trig_KaiQi_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(("|cFFFFCC33"+GetPlayerName(GetTriggerPlayer()))+("|r|cFF660000开启|r"+"|cFF660000CMD测试脚本|r")))
call EnableTrigger(gg_trg_CMDchufa)
call EnableTrigger(gg_trg_CMD)
endfunction
function InitTrig_KaiQi takes nothing returns nothing
set gg_trg_KaiQi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(0),"飞飞世界",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(1),"飞飞世界",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(2),"飞飞世界",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(3),"飞飞世界",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(4),"飞飞世界",true)
call TriggerRegisterPlayerChatEvent(gg_trg_KaiQi,Player(5),"飞飞世界",true)
call TriggerAddAction(gg_trg_KaiQi,function Trig_KaiQi_Actions)
endfunction
function Trig_CMD_Func001Func001Func001C takes nothing returns boolean
return true
endfunction
function Trig_CMD_Func001Func001A takes nothing returns nothing
if(Trig_CMD_Func001Func001Func001C())then
call UnitRemoveAbilityBJ('AImx',GetEnumUnit())
endif
endfunction
function Trig_CMD_Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="my=")
endfunction
function Trig_CMD_Func002Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_CMD_Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="wd=")
endfunction
function Trig_CMD_Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="cd=")
endfunction
function Trig_CMD_Func004Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMD_Func004Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_INT,GetEnumUnit(),bj_MODIFYMETHOD_SUB,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMD_Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="zl=")
endfunction
function Trig_CMD_Func005Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMD_Func005Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetEnumUnit(),bj_MODIFYMETHOD_SUB,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMD_Func005C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="ll=")
endfunction
function Trig_CMD_Func006Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMD_Func006Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_AGI,GetEnumUnit(),bj_MODIFYMETHOD_SUB,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMD_Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="mj=")
endfunction
function Trig_CMD_Func007C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="RPG=")
endfunction
function Trig_CMD_Func008Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMD_Func008Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call ModifyHeroStat(bj_HEROSTAT_AGI,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call ModifyHeroStat(bj_HEROSTAT_INT,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF333300属性修改减少|r"+SubStringBJ(GetEventPlayerChatString(),4,9)))
endfunction
function Trig_CMD_Func008C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="sx=")
endfunction
function Trig_CMD_Actions takes nothing returns nothing
if(Trig_CMD_Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMD_Func001Func001A)
endif
if(Trig_CMD_Func002C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMD_Func002Func001A)
endif
if(Trig_CMD_Func003C())then
set udg_CDCD[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|cFFCCFF33关|r|cFF0041FF闭|r"+"|cFF1BE6B8自|r|cFF530080动|r|cFFFFFF00清|r|cFFFE9FD8C|r|cFF1FBF00D|r"))
endif
if(Trig_CMD_Func004C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMD_Func004Func001001002)),function Trig_CMD_Func004Func001A)
endif
if(Trig_CMD_Func005C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMD_Func005Func001001002)),function Trig_CMD_Func005Func001A)
endif
if(Trig_CMD_Func006C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMD_Func006Func001001002)),function Trig_CMD_Func006Func001A)
endif
if(Trig_CMD_Func007C())then
set udg_shengming[GetConvertedPlayerId(GetTriggerPlayer())]=0
set udg_mofa[GetConvertedPlayerId(GetTriggerPlayer())]=0
set udg_CDCD[GetConvertedPlayerId(GetTriggerPlayer())]=0
set udg_sudu[GetConvertedPlayerId(GetTriggerPlayer())]=0
set udg_Buffs[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFFCCFF33取|r|cFF0041FF消|r"+"|cFF1BE6B8自|r|cFF530080动|r|cFFFFFF00类|r"))
endif
if(Trig_CMD_Func008C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMD_Func008Func001001002)),function Trig_CMD_Func008Func001A)
endif
endfunction
function InitTrig_CMD takes nothing returns nothing
set gg_trg_CMD=CreateTrigger()
call DisableTrigger(gg_trg_CMD)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(0),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(1),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(2),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(3),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(4),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMD,Player(5),"=",false)
call TriggerAddAction(gg_trg_CMD,function Trig_CMD_Actions)
endfunction
function Trig_CMDchufa_Func001Func001A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_CMDchufa_Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-ql")
endfunction
function Trig_CMDchufa_Func002Func001A takes nothing returns nothing
call CreateNUnitsAtLocFacingLocBJ(1,GetUnitTypeId(GetEnumUnit()),GetTriggerPlayer(),GetUnitLoc(GetEnumUnit()),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_CMDchufa_Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-fz")
endfunction
function Trig_CMDchufa_Func003Func001A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_CMDchufa_Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-yc")
endfunction
function Trig_CMDchufa_Func004Func001A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_CMDchufa_Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-yc")
endfunction
function Trig_CMDchufa_Func005Func001Func001C takes nothing returns boolean
return true
endfunction
function Trig_CMDchufa_Func005Func001A takes nothing returns nothing
if(Trig_CMDchufa_Func005Func001Func001C())then
call UnitRemoveItemFromSlotSwapped(1,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(2,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(3,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(4,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(5,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(6,GetEnumUnit())
endif
endfunction
function Trig_CMDchufa_Func005C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-dl")
endfunction
function Trig_CMDchufa_Func006Func001Func001C takes nothing returns boolean
return true
endfunction
function Trig_CMDchufa_Func006Func001A takes nothing returns nothing
if(Trig_CMDchufa_Func006Func001Func001C())then
call SetUnitLifePercentBJ(GetEnumUnit(),.0)
endif
endfunction
function Trig_CMDchufa_Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-ss")
endfunction
function Trig_CMDchufa_Func007Func001Func001C takes nothing returns boolean
return true
endfunction
function Trig_CMDchufa_Func007Func001A takes nothing returns nothing
if(Trig_CMDchufa_Func007Func001Func001C())then
call UnitAddAbilityBJ('AImx',GetEnumUnit())
endif
endfunction
function Trig_CMDchufa_Func007C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-my")
endfunction
function Trig_CMDchufa_Func008Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_CMDchufa_Func008C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-wd")
endfunction
function Trig_CMDchufa_Func009Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func009Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_AGI,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMDchufa_Func009C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-mj")
endfunction
function Trig_CMDchufa_Func010Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func010Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_INT,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMDchufa_Func010C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-zl")
endfunction
function Trig_CMDchufa_Func011Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func011Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,10)))
endfunction
function Trig_CMDchufa_Func011C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-ll")
endfunction
function Trig_CMDchufa_Func012C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-cd")
endfunction
function Trig_CMDchufa_Func013Func001A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+S2I(SubStringBJ(GetEventPlayerChatString(),4,8))),false)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFFCCFF00等级设置：|r"+SubStringBJ(GetEventPlayerChatString(),4,8)))
endfunction
function Trig_CMDchufa_Func013C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-dj")
endfunction
function Trig_CMDchufa_Func014Func001Func001A takes nothing returns nothing
call UnitShareVisionBJ(false,GetEnumUnit(),GetEnumPlayer())
call CreateFogModifierRectBJ(true,GetEnumPlayer(),FOG_OF_WAR_VISIBLE,GetEntireMapRect())
endfunction
function Trig_CMDchufa_Func014Func001A takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(GetTriggerPlayer()),function Trig_CMDchufa_Func014Func001Func001A)
endfunction
function Trig_CMDchufa_Func014C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-dt")
endfunction
function Trig_CMDchufa_Func015Func001Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func015Func001Func001A takes nothing returns nothing
call CreateItemLoc(ChooseRandomItemBJ(-1),GetUnitLoc(GetEnumUnit()))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,GetItemName(GetLastCreatedItem()))
endfunction
function Trig_CMDchufa_Func015C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-wp")
endfunction
function Trig_CMDchufa_Func016Func001Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func016Func001Func001A takes nothing returns nothing
call CreateItemLoc(ChooseRandomItemExBJ(-1,ITEM_TYPE_PERMANENT),GetUnitLoc(GetEnumUnit()))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,GetItemName(GetLastCreatedItem()))
endfunction
function Trig_CMDchufa_Func016C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)=="-wpyj")
endfunction
function Trig_CMDchufa_Func017Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func017Func001A takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call ModifyHeroStat(bj_HEROSTAT_AGI,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call ModifyHeroStat(bj_HEROSTAT_INT,GetEnumUnit(),bj_MODIFYMETHOD_ADD,S2I(SubStringBJ(GetEventPlayerChatString(),4,9)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF333300属性修改增加|r"+SubStringBJ(GetEventPlayerChatString(),4,9)))
endfunction
function Trig_CMDchufa_Func017C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-sx")
endfunction
function Trig_CMDchufa_Func018Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_CMDchufa_Func018Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),S2R(SubStringBJ(GetEventPlayerChatString(),4,6)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF9933FF当前移动速度为|r"+SubStringBJ(GetEventPlayerChatString(),4,6)))
endfunction
function Trig_CMDchufa_Func018C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-sd")
endfunction
function Trig_CMDchufa_Func019C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-mc")
endfunction
function Trig_CMDchufa_Func020C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="-jb")
endfunction
function Trig_CMDchufa_Func021C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)=="-smbs")
endfunction
function Trig_CMDchufa_Func028C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)=="-jybs")
endfunction
function Trig_CMDchufa_Func029C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="-RPG")
endfunction
function Trig_CMDchufa_Actions takes nothing returns nothing
if(Trig_CMDchufa_Func001C())then
call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_CMDchufa_Func001Func001A)
endif
if(Trig_CMDchufa_Func002C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func002Func001A)
endif
if(Trig_CMDchufa_Func003C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func003Func001A)
endif
if(Trig_CMDchufa_Func004C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func004Func001A)
endif
if(Trig_CMDchufa_Func005C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func005Func001A)
endif
if(Trig_CMDchufa_Func006C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func006Func001A)
endif
if(Trig_CMDchufa_Func007C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func007Func001A)
endif
if(Trig_CMDchufa_Func008C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_CMDchufa_Func008Func001A)
endif
if(Trig_CMDchufa_Func009C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func009Func001001002)),function Trig_CMDchufa_Func009Func001A)
endif
if(Trig_CMDchufa_Func010C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func010Func001001002)),function Trig_CMDchufa_Func010Func001A)
endif
if(Trig_CMDchufa_Func011C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func011Func001001002)),function Trig_CMDchufa_Func011Func001A)
endif
if(Trig_CMDchufa_Func012C())then
set udg_CDCD[GetConvertedPlayerId(GetTriggerPlayer())]='{'
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|cFFCCFF33开|r|cFF0041FF启|r"+"|cFF1BE6B8自|r|cFF530080动|r|cFFFFFF00清|r|cFFFE9FD8C|r|cFF1FBF00D|r"))
endif
if(Trig_CMDchufa_Func013C())then
call ForGroupBJ(GetUnitsOfPlayerAll(GetTriggerPlayer()),function Trig_CMDchufa_Func013Func001A)
endif
if(Trig_CMDchufa_Func014C())then
call ForForce(GetPlayersAllies(GetTriggerPlayer()),function Trig_CMDchufa_Func014Func001A)
endif
if(Trig_CMDchufa_Func015C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=S2I(SubStringBJ(GetEventPlayerChatString(),4,8))
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func015Func001Func001001002)),function Trig_CMDchufa_Func015Func001Func001A)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
if(Trig_CMDchufa_Func016C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=S2I(SubStringBJ(GetEventPlayerChatString(),6,10))
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func016Func001Func001001002)),function Trig_CMDchufa_Func016Func001Func001A)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
if(Trig_CMDchufa_Func017C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func017Func001001002)),function Trig_CMDchufa_Func017Func001A)
endif
if(Trig_CMDchufa_Func018C())then
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_CMDchufa_Func018Func001001002)),function Trig_CMDchufa_Func018Func001A)
endif
if(Trig_CMDchufa_Func019C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),4,10)),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF9933FF木材增加|r"+SubStringBJ(GetEventPlayerChatString(),4,10)))
endif
if(Trig_CMDchufa_Func020C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),4,10)),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF9933FF金币增加|r"+SubStringBJ(GetEventPlayerChatString(),4,10)))
endif
if(Trig_CMDchufa_Func021C())then
call SetPlayerHandicap(GetTriggerPlayer(),S2R(SubStringBJ(GetEventPlayerChatString(),6,10)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF9933FF当前生命倍数为：|r"+SubStringBJ(GetEventPlayerChatString(),6,10)))
endif
if(Trig_CMDchufa_Func028C())then
call SetPlayerHandicapXP(GetTriggerPlayer(),S2R(SubStringBJ(GetEventPlayerChatString(),6,10)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF9933FF当前经验倍数为：|r"+SubStringBJ(GetEventPlayerChatString(),6,10)))
endif
if(Trig_CMDchufa_Func029C())then
set udg_shengming[GetConvertedPlayerId(GetTriggerPlayer())]='{'
set udg_mofa[GetConvertedPlayerId(GetTriggerPlayer())]='{'
set udg_CDCD[GetConvertedPlayerId(GetTriggerPlayer())]='{'
set udg_sudu[GetConvertedPlayerId(GetTriggerPlayer())]='{'
set udg_Buffs[GetConvertedPlayerId(GetTriggerPlayer())]='{'
call AdjustPlayerStateBJ(100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(1000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|cFF33CCCC开|r|cFF0041FF启|r"+"|cFF1BE6B8自|r|cFF530080动|r|cFFFFFF00类|r|cFFFE9FD8项|r"))
endif
endfunction
function InitTrig_CMDchufa takes nothing returns nothing
set gg_trg_CMDchufa=CreateTrigger()
call DisableTrigger(gg_trg_CMDchufa)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(0),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(1),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(2),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(3),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(4),"-",false)
call TriggerRegisterPlayerChatEvent(gg_trg_CMDchufa,Player(5),"-",false)
call TriggerAddAction(gg_trg_CMDchufa,function Trig_CMDchufa_Actions)
endfunction
function Trig_ZiDongchufa_Func001Func001Func001A takes nothing returns nothing
call SetUnitLifePercentBJ(GetEnumUnit(),'d')
endfunction
function Trig_ZiDongchufa_Func001Func001C takes nothing returns boolean
return(udg_shengming[GetForLoopIndexA()]=='{')
endfunction
function Trig_ZiDongchufa_Func002Func001Func001A takes nothing returns nothing
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
endfunction
function Trig_ZiDongchufa_Func002Func001C takes nothing returns boolean
return(udg_mofa[GetForLoopIndexA()]=='{')
endfunction
function Trig_ZiDongchufa_Func003Func001Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function Trig_ZiDongchufa_Func003Func001C takes nothing returns boolean
return(udg_sudu[GetForLoopIndexA()]=='{')
endfunction
function Trig_ZiDongchufa_Func004Func001Func001A takes nothing returns nothing
call UnitResetCooldown(GetEnumUnit())
endfunction
function Trig_ZiDongchufa_Func004Func001C takes nothing returns boolean
return(udg_CDCD[GetForLoopIndexA()]=='{')
endfunction
function Trig_ZiDongchufa_Func005Func001Func001A takes nothing returns nothing
call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_NEGATIVE,GetEnumUnit())
endfunction
function Trig_ZiDongchufa_Func005Func001C takes nothing returns boolean
return(udg_Buffs[GetForLoopIndexA()]=='{')
endfunction
function Trig_ZiDongchufa_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_ZiDongchufa_Func001Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())),function Trig_ZiDongchufa_Func001Func001Func001A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_ZiDongchufa_Func002Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())),function Trig_ZiDongchufa_Func002Func001Func001A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_ZiDongchufa_Func003Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())),function Trig_ZiDongchufa_Func003Func001Func001A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_ZiDongchufa_Func004Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())),function Trig_ZiDongchufa_Func004Func001Func001A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_ZiDongchufa_Func005Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(ConvertedPlayer(GetForLoopIndexA())),function Trig_ZiDongchufa_Func005Func001Func001A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_ZiDongchufa takes nothing returns nothing
set gg_trg_ZiDongchufa=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_ZiDongchufa,.5)
call TriggerAddAction(gg_trg_ZiDongchufa,function Trig_ZiDongchufa_Actions)
endfunction
function Trig_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Esc)
call TriggerSleepAction(.5)
call DisableTrigger(gg_trg_Esc)
endfunction
function InitTrig_Up takes nothing returns nothing
set gg_trg_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Up,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Up,function Trig_Up_Actions)
endfunction
function Trig_Esc_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(("|cFFFFCC33"+GetPlayerName(GetTriggerPlayer()))+("|r|cFF660000开启|r"+"|cFF660000CMD测试脚本|r")))
call EnableTrigger(gg_trg_CMD)
call EnableTrigger(gg_trg_CMDchufa)
endfunction
function InitTrig_Esc takes nothing returns nothing
set gg_trg_Esc=CreateTrigger()
call DisableTrigger(gg_trg_Esc)
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_Esc,Player(5))
call TriggerAddAction(gg_trg_Esc,function Trig_Esc_Actions)
endfunction
