function Trig_lfgddrjkdkqzb_Actions takes nothing returns nothing
set udg_lfgddrjkdkqzb=GetTriggerPlayer()
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,30,"|cFF00FF00你开启了91niux冷灬锋所制作的作弊脚本,欢迎访问bbs.91niux.com下载修改地图与作弊地图和魔兽改图所需工具|R")
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_lfgddrjkdcjdhk_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcjdhk_Func002001 takes nothing returns boolean
return(udg_lfgddrjkdsz==2.)
endfunction
function Trig_lfgddrjkdcjdhk_Actions takes nothing returns nothing
if(Trig_lfgddrjkdcjdhk_Func002001())then
call ConditionalTriggerExecute(gg_trg_lfgddrjkddhk)
endif
endfunction
function Trig_lfgddrjkdcsdddd_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcsdddd_Actions takes nothing returns nothing
set udg_lfgddrjkdsz=2.
endfunction
function Trig_lfgddrjkdcssf_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcssf_Actions takes nothing returns nothing
set udg_lfgddrjkdsz=.0
endfunction
function Trig_lfgddrjkddhk_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhk_Actions takes nothing returns nothing
call DialogClear(udg_lfgddrjkdcjdhk)
call DialogSetMessage(udg_lfgddrjkdcjdhk,"|cFF00FF0091niux作弊菜单,BY:冷灬锋|R|n|cFF00FF00QQ:453081202|R|n|cFF00FF00论坛:bbs.91niux.com|R|n")
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00加钱『A』|R",'A')
set udg_lfgddrjkddhkjq=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00加木『B』|R",'B')
set udg_lfgddrjkddhkjm=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00加三围『C』|R",'C')
set udg_lfgddrjkddhkjsw=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00移动速度『D』|R",'D')
set udg_lfgddrjkddhkydsd=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00提升200级『E』|R",'E')
set udg_lfgddrjkdtserbj=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00无敌『F』|R",'F')
set udg_lfgddrjkddhkwudi=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00取消无敌『G』|R",'G')
set udg_lfgddrjkddhkqxwudi=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00清理物品『H』|R",'H')
set udg_lfgddrjkdqingliwupin=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00重击『I』|R",'I')
set udg_lfgddrjkdzhongji=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00删除重击『J』|R",'J')
set udg_lfgddrjkdshanchuzhongji=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00复制物品『K』|R",'K')
set udg_lfgddrjkddhkfuzhiwupin=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_lfgddrjkdcjdhk,"|cFF00FF00退出『X』|R",'X')
set udg_lfgddrjkdtuichudhk=bj_lastCreatedButton
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkjq_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkjq)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkjq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(0xF4240,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,0)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkjm_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkjm)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkjm_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(0xF4240,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,0)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkjsw_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkjsw)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkjsw_Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,'d')
call ModifyHeroStat(1,GetEnumUnit(),0,'d')
call ModifyHeroStat(2,GetEnumUnit(),0,'d')
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkddhkjsw_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkjsw_Func001A)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkydsd_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkydsd)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkydsd_Func001002 takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function Trig_lfgddrjkddhkydsd_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkydsd_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhktserbaiji_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkdtserbj)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhktserbaiji_Func001002 takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+200),false)
endfunction
function Trig_lfgddrjkddhktserbaiji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhktserbaiji_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkwudi_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkwudi)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_lfgddrjkddhkwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkwudi_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkqxwudi_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkqxwudi)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkqxwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_lfgddrjkddhkqxwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkqxwudi_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkqingliwupin_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkdqingliwupin)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkqingliwupin_Func001002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_lfgddrjkddhkqingliwupin_Actions takes nothing returns nothing
call EnumItemsInRectBJ(bj_mapInitialPlayableArea,function Trig_lfgddrjkddhkqingliwupin_Func001002)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkzhongji_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkdzhongji)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkzhongji_Func001002 takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'AHbh')
endfunction
function Trig_lfgddrjkddhkzhongji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkzhongji_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkddhkshanchuzhongji_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkdshanchuzhongji)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkddhkshanchuzhongji_Func001002 takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'AHbh')
endfunction
function Trig_lfgddrjkddhkshanchuzhongji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkddhkshanchuzhongji_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkdfuzhiwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkddhkfuzhiwupin)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdfuzhiwp_Func001A takes nothing returns nothing
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),1)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),2)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),3)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),4)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),5)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),6)),GetUnitLoc(GetEnumUnit()))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdfuzhiwp_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdfuzhiwp_Func001A)
call DialogDisplayBJ(true,udg_lfgddrjkdcjdhk,GetTriggerPlayer())
endfunction
function Trig_lfgddrjkdtcdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfgddrjkdtuichudhk)and(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdtcdhk_Actions takes nothing returns nothing
call DialogClear(udg_lfgddrjkdcjdhk)
endfunction
function Trig_lfgddrjkdcmdjq_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdjq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),5,'d')),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,0)
endfunction
function Trig_lfgddrjkdcmdjm_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdjm_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),3,'d')),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,0)
endfunction
function Trig_lfgddrjkdcmdsw_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdsw_Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call ModifyHeroStat(1,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call ModifyHeroStat(2,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdsw_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdsw_Func001A)
endfunction
function Trig_lfgddrjkdcmdll_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdll_Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),8,'d')))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdll_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdll_Func001A)
endfunction
function Trig_lfgddrjkdcmdmj_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdmj_Func001A takes nothing returns nothing
call ModifyHeroStat(1,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdmj_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdmj_Func001A)
endfunction
function Trig_lfgddrjkdcmdzl_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdzl_Func001A takes nothing returns nothing
call ModifyHeroStat(2,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),6,'d')))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdzl_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdzl_Func001A)
endfunction
function Trig_lfgddrjkdsjsx_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdsjsx_Actions takes nothing returns nothing
call ModifyHeroStat(0,GetTriggerUnit(),0,5)
call ModifyHeroStat(1,GetTriggerUnit(),0,5)
call ModifyHeroStat(2,GetTriggerUnit(),0,5)
endfunction
function Trig_lfgddrjkdqxfmbuff_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdqxfmbuff_Func001A takes nothing returns nothing
call UnitRemoveBuffs(GetEnumUnit(),false,true)
call SetUnitLifePercentBJ(GetEnumUnit(),100.)
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
call UnitResetCooldown(GetEnumUnit())
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdqxfmbuff_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdqxfmbuff_Func001A)
endfunction
function Trig_lfgddrjkdpjqpf_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_lfgddrjkdkqzb)and(GetIssuedOrderId()==851990)
endfunction
function Trig_lfgddrjkdpjqpf_Actions takes nothing returns nothing
set udg_lfgddrjkdmlfbd=GetOrderPointLoc()
call SetUnitPositionLoc(GetTriggerUnit(),udg_lfgddrjkdmlfbd)
call RemoveLocation(udg_lfgddrjkdmlfbd)
endfunction
function Trig_lfgddrjkdcmdwudi_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_lfgddrjkdcmdwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdwudi_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdbuwudi_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdbuwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_lfgddrjkdcmdbuwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmdbuwudi_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdfxjydsd_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdfxjydsd_Func001002 takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function Trig_lfgddrjkdfxjydsd_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdfxjydsd_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_lfgddrjkdcmdqlwp_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmdqlwp_Func002002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_lfgddrjkdcmdqlwp_Actions takes nothing returns nothing
call EnumItemsInRectBJ(bj_mapInitialPlayableArea,function Trig_lfgddrjkdcmdqlwp_Func002002)
endfunction
function Trig_lfgddrjkdcmddengji_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfgddrjkdkqzb)
endfunction
function Trig_lfgddrjkdcmddengji_Func001002 takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+S2I(SubStringBJ(GetEventPlayerChatString(),7,'d'))),false)
endfunction
function Trig_lfgddrjkdcmddengji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfgddrjkdcmddengji_Func001002)
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function zhuji_a takes nothing returns nothing
local integer i
local gamecache abc=null
set abc=InitGameCache("abc")
set i=0
loop
exitwhen i>11
if(GetLocalPlayer()==Player(i))then
call StoreInteger(abc,"abc","abc",i)
endif
set i=i+1
endloop
call TriggerSyncStart()
call SyncStoredInteger(abc,"abc","abc")
call TriggerSyncReady()
set i=GetStoredInteger(abc,"abc","abc")
call FlushStoredMission(abc,"abc")
set zhuji=Player(i)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"The host computer is Player("+I2S(i+1)+")")
endfunction
function zjjc takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"lflf",true)
set i=i+1
endloop
call TriggerAddAction(t,function zhuji_a)
endfunction