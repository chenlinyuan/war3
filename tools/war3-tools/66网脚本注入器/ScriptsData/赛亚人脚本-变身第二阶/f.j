function Trig_Tuan_kaiQi_Actions takes nothing returns nothing
set udg_CHat[(1+GetPlayerId(GetTriggerPlayer()))]=GetEventPlayerChatString()
call ConditionalTriggerExecute(gg_trg_SaiYarenA)
endfunction
function Trig_SaiYarenA_Func001Func001C takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')
endfunction
function Trig_SaiYarenA_Func001C takes nothing returns boolean
return(SubStringBJ(udg_CHat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(udg_CHat[(1+GetPlayerId(GetTriggerPlayer()))]))=="赛亚人")
endfunction
function Trig_SaiYarenA_Actions takes nothing returns nothing
if(Trig_SaiYarenA_Func001C())then
if(Trig_SaiYarenA_Func001Func001C())then
set udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))]=false
set udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=0
set udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]="Saiyaren"
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,1.,("|cff0080FF赛亚人の---|cff00FF00系统关闭!|r"+""))
else
set udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]="SaiYaRen"
set udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]='{'
set udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerPlayer()
call TriggerRegisterPlayerEventEndCinematic(gg_trg_SaiYarenB,udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))])
call TriggerRegisterPlayerChatEvent(gg_trg_SaiYarenBB,udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_SaiYaren_BianSHen,udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_SaiYaren_TuiChu,udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],"退出",true)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,1.,("|cff0080FF赛亚人の---|cff00FF00系统开启!|r"+""))
endif
return
endif
endfunction
function Trig_SaiYarenB_Conditions takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenB_Func001A takes nothing returns nothing
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+50.))
call SetUnitManaPercentBJ(GetEnumUnit(),(GetUnitManaPercent(GetEnumUnit())+50.))
call UnitResetCooldown(GetEnumUnit())
call UnitRemoveBuffs(GetEnumUnit(),false,true)
endfunction
function Trig_SaiYarenB_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenB_Func001A)
endfunction
function Trig_SaiYarenC_Conditions takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])and(GetIssuedOrderId()==851990)
endfunction
function Trig_SaiYarenC_Func001C takes nothing returns boolean
return(udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]=="p")
endfunction
function Trig_SaiYarenC_Func002Func001Func001C takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]=='{')and(udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+1)])
endfunction
function Trig_SaiYarenC_Func002Func001Func002C takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]==213)and(udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+2)])
endfunction
function Trig_SaiYarenC_Func002Func001C takes nothing returns boolean
return(Trig_SaiYarenC_Func002Func001Func001C())or(Trig_SaiYarenC_Func002Func001Func002C())
endfunction
function Trig_SaiYarenC_Func002C takes nothing returns boolean
return(Trig_SaiYarenC_Func002Func001C())
endfunction
function Trig_SaiYarenC_Actions takes nothing returns nothing
if(Trig_SaiYarenC_Func001C())then
call SetUnitMoveSpeed(GetTriggerUnit(),522.)
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
endif
if(Trig_SaiYarenC_Func002C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
call CreateTextTagUnitBJ(("|cFF996600瞬|r|cFF0041FF间|r|cFF1BE6B8移|r|cFF530080动|r"+""),GetTriggerUnit(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,64,90)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_SaiYarenAA_Conditions takes nothing returns boolean
return(udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]=="SaiYaRen")and(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenAA_Func006C takes nothing returns boolean
return(udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]=="jn")
endfunction
function Trig_SaiYarenAA_Actions takes nothing returns nothing
if(Trig_SaiYarenAA_Func006C())then
call UnitResetCooldown(GetTriggerUnit())
endif
endfunction
function Trig_SaiYarenBB_Conditions takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]=="SaiYaRen")and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenBB_Func009Func002C takes nothing returns boolean
return(udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]=="jn")
endfunction
function Trig_SaiYarenBB_Func009C takes nothing returns boolean
return(GetEventPlayerChatString()=="jn")
endfunction
function Trig_SaiYarenBB_Func010Func002C takes nothing returns boolean
return(udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]=="p")
endfunction
function Trig_SaiYarenBB_Func010C takes nothing returns boolean
return(GetEventPlayerChatString()=="p")
endfunction
function Trig_SaiYarenBB_Func011Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
call ModifyHeroStat(1,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
call ModifyHeroStat(2,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenBB_Func011C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="sx")
endfunction
function Trig_SaiYarenBB_Func012C takes nothing returns boolean
return(GetEventPlayerChatString()=="dt")
endfunction
function Trig_SaiYarenBB_Func013Func001A takes nothing returns nothing
call AdjustPlayerStateBJ(udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_GOLD_GATHERED)
endfunction
function Trig_SaiYarenBB_Func013C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="jb")
endfunction
function Trig_SaiYarenBB_Func014Func001A takes nothing returns nothing
call AdjustPlayerStateBJ(udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_LUMBER_GATHERED)
endfunction
function Trig_SaiYarenBB_Func014C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="mc")
endfunction
function Trig_SaiYarenBB_Func015Func001A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))],false)
endfunction
function Trig_SaiYarenBB_Func015C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="dj")
endfunction
function Trig_SaiYarenBB_Func016Func001A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_SaiYarenBB_Func016C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="scd")
endfunction
function Trig_SaiYarenBB_Func017Func001A takes nothing returns nothing
call KillUnit(GetEnumUnit())
endfunction
function Trig_SaiYarenBB_Func017C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="ss")
endfunction
function Trig_SaiYarenBB_Func018Func001Func001002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_SaiYarenBB_Func018Func001A takes nothing returns nothing
call EnumItemsInRectBJ(bj_mapInitialPlayableArea,function Trig_SaiYarenBB_Func018Func001Func001002)
endfunction
function Trig_SaiYarenBB_Func018C takes nothing returns boolean
return(GetEventPlayerChatString()=="ql")
endfunction
function Trig_SaiYarenBB_Func019Func001Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_SaiYarenBB_Func019Func001Func001A takes nothing returns nothing
call CreateItemLoc(ChooseRandomItem(-1),GetUnitLoc(GetEnumUnit()))
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,GetItemName(bj_lastCreatedItem))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_SaiYarenBB_Func019C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="wp")
endfunction
function Trig_SaiYarenBB_Func020Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_SaiYarenBB_Func020C takes nothing returns boolean
return(GetEventPlayerChatString()=="wd")
endfunction
function Trig_SaiYarenBB_Func021Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_SaiYarenBB_Func021C takes nothing returns boolean
return(GetEventPlayerChatString()=="bwd")
endfunction
function Trig_SaiYarenBB_Func022Func001A takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+1)])
endfunction
function Trig_SaiYarenBB_Func022C takes nothing returns boolean
return(GetEventPlayerChatString()=="sb")
endfunction
function Trig_SaiYarenBB_Func023Func001A takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+1)])
endfunction
function Trig_SaiYarenBB_Func023C takes nothing returns boolean
return(GetEventPlayerChatString()=="bsb")
endfunction
function Trig_SaiYarenBB_Func024Func001A takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+2)])
endfunction
function Trig_SaiYarenBB_Func024C takes nothing returns boolean
return(GetEventPlayerChatString()=="mm")
endfunction
function Trig_SaiYarenBB_Func025Func001A takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+2)])
endfunction
function Trig_SaiYarenBB_Func025C takes nothing returns boolean
return(GetEventPlayerChatString()=="bmm")
endfunction
function Trig_SaiYarenBB_Func026Func001A takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+3)])
endfunction
function Trig_SaiYarenBB_Func026C takes nothing returns boolean
return(GetEventPlayerChatString()=="yx")
endfunction
function Trig_SaiYarenBB_Func027Func001A takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+3)])
endfunction
function Trig_SaiYarenBB_Func027C takes nothing returns boolean
return(GetEventPlayerChatString()=="byx")
endfunction
function Trig_SaiYarenBB_Func028Func001A takes nothing returns nothing
call CreateNUnitsAtLocFacingLocBJ(1,GetUnitTypeId(GetEnumUnit()),udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetEnumUnit()),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_SaiYarenBB_Func028C takes nothing returns boolean
return(GetEventPlayerChatString()=="fzd")
endfunction
function Trig_SaiYarenBB_Func029Func001A takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitRemoveItemFromSlotSwapped(bj_forLoopAIndex,GetEnumUnit())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_SaiYarenBB_Func029C takes nothing returns boolean
return(GetEventPlayerChatString()=="dl")
endfunction
function Trig_SaiYarenBB_Func030Func001A takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),bj_forLoopAIndex)),GetUnitLoc(GetEnumUnit()))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_SaiYarenBB_Func030C takes nothing returns boolean
return(GetEventPlayerChatString()=="fzw")
endfunction
function Trig_SaiYarenBB_Func031Func001A takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(),bj_forLoopAIndex))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_SaiYarenBB_Func031C takes nothing returns boolean
return(GetEventPlayerChatString()=="scw")
endfunction
function Trig_SaiYarenBB_Func032Func001A takes nothing returns nothing
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),S2I(udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+2)]))),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_SaiYarenBB_Func032C takes nothing returns boolean
return(udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+1)]=="fzw")
endfunction
function Trig_SaiYarenBB_Func033Func001A takes nothing returns nothing
call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(),S2I(udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+2)])))
endfunction
function Trig_SaiYarenBB_Func033C takes nothing returns boolean
return(udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+1)]=="scw")
endfunction
function Trig_SaiYarenBB_Func034Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenBB_Func034C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="ll")
endfunction
function Trig_SaiYarenBB_Func035Func001A takes nothing returns nothing
call ModifyHeroStat(1,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenBB_Func035C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="mj")
endfunction
function Trig_SaiYarenBB_Func036Func001A takes nothing returns nothing
call ModifyHeroStat(2,GetEnumUnit(),0,udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYarenBB_Func036C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="zl")
endfunction
function Trig_SaiYarenBB_Func037Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),S2R(udg_ChatB[(1+GetPlayerId(GetTriggerPlayer()))]))
endfunction
function Trig_SaiYarenBB_Func037C takes nothing returns boolean
return(udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=="sd")
endfunction
function Trig_SaiYarenBB_Actions takes nothing returns nothing
set udg_CHatA[(1+GetPlayerId(GetTriggerPlayer()))]=SubStringBJ(GetEventPlayerChatString(),1,2)
set udg_ChatB[(1+GetPlayerId(GetTriggerPlayer()))]=I2S(S2I(SubStringBJ(GetEventPlayerChatString(),3,9)))
set udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+1)]=SubStringBJ(GetEventPlayerChatString(),1,3)
set udg_CHatD[((1+GetPlayerId(GetTriggerPlayer()))+2)]=I2S(S2I(SubString(GetEventPlayerChatString(),3,5)))
set udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(udg_ChatB[(1+GetPlayerId(GetTriggerPlayer()))])
set udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+1)]='ACes'
set udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+2)]='ACmi'
set udg_JiNengA[((1+GetPlayerId(GetTriggerPlayer()))+3)]='Apiv'
if(Trig_SaiYarenBB_Func009C())then
if(Trig_SaiYarenBB_Func009Func002C())then
set udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]=""
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,("|cff0080FF关闭---|cff00FF00自动清CD|r"+""))
else
set udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]="jn"
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,("|cff0080FF开启---|cff00FF00自动清CD|r"+""))
return
endif
endif
if(Trig_SaiYarenBB_Func010C())then
if(Trig_SaiYarenBB_Func010Func002C())then
set udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]=""
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,("|cff0080FF关闭---|cff00FF00P键全图闪烁|r"+""))
else
set udg_CHaojiSaiyarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]="p"
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,("|cff0080FF开启---|cff00FF00P键全图闪烁|r"+""))
return
endif
endif
if(Trig_SaiYarenBB_Func011C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func011Func001A)
endif
if(Trig_SaiYarenBB_Func012C())then
call CreateFogModifierRectBJ(true,udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],FOG_OF_WAR_VISIBLE,GetWorldBounds())
endif
if(Trig_SaiYarenBB_Func013C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func013Func001A)
endif
if(Trig_SaiYarenBB_Func014C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func014Func001A)
endif
if(Trig_SaiYarenBB_Func015C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func015Func001A)
endif
if(Trig_SaiYarenBB_Func016C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func016Func001A)
endif
if(Trig_SaiYarenBB_Func017C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func017Func001A)
return
endif
if(Trig_SaiYarenBB_Func018C())then
call ForGroupBJ(GetUnitsOfPlayerAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func018Func001A)
endif
if(Trig_SaiYarenBB_Func019C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_CHat0[(1+GetPlayerId(GetTriggerPlayer()))]
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call ForGroupBJ(GetUnitsOfPlayerMatching(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],Condition(function Trig_SaiYarenBB_Func019Func001Func001001002)),function Trig_SaiYarenBB_Func019Func001Func001A)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
if(Trig_SaiYarenBB_Func020C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func020Func001A)
endif
if(Trig_SaiYarenBB_Func021C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func021Func001A)
endif
if(Trig_SaiYarenBB_Func022C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func022Func001A)
endif
if(Trig_SaiYarenBB_Func023C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func023Func001A)
endif
if(Trig_SaiYarenBB_Func024C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func024Func001A)
endif
if(Trig_SaiYarenBB_Func025C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func025Func001A)
endif
if(Trig_SaiYarenBB_Func026C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func026Func001A)
endif
if(Trig_SaiYarenBB_Func027C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func027Func001A)
endif
if(Trig_SaiYarenBB_Func028C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func028Func001A)
endif
if(Trig_SaiYarenBB_Func029C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func029Func001A)
endif
if(Trig_SaiYarenBB_Func030C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func030Func001A)
endif
if(Trig_SaiYarenBB_Func031C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func031Func001A)
endif
if(Trig_SaiYarenBB_Func032C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func032Func001A)
endif
if(Trig_SaiYarenBB_Func033C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func033Func001A)
endif
if(Trig_SaiYarenBB_Func034C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func034Func001A)
endif
if(Trig_SaiYarenBB_Func035C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func035Func001A)
endif
if(Trig_SaiYarenBB_Func036C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func036Func001A)
endif
if(Trig_SaiYarenBB_Func037C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_SaiYarenBB_Func037Func001A)
endif
endfunction
function Trig_SaiYaren_BianSHen_Conditions takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])and(udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]=="SaiYaRen")
endfunction
function Trig_SaiYaren_BianSHen_Func001Func007Func001Func010C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+1)])
endfunction
function Trig_SaiYaren_BianSHen_Func001Func007Func001C takes nothing returns boolean
return(Trig_SaiYaren_BianSHen_Func001Func007Func001Func010C())
endfunction
function Trig_SaiYaren_BianSHen_Func001Func007A takes nothing returns nothing
if(Trig_SaiYaren_BianSHen_Func001Func007Func001C())then
call PanCameraToTimedLocForPlayer(udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+1)],GetUnitLoc(GetEnumUnit()),0)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call CreateTextTagUnitBJ("|cFF9933FF变身|r"+"|cFFCC9966超级赛亚人の第一阶|r",GetEnumUnit(),0,20.,'d',.0,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_SaiYaren_BianSHen_Func001C takes nothing returns boolean
return(GetEventPlayerChatString()=="变身第一阶")
endfunction
function Trig_SaiYaren_BianSHen_Func002Func007Func001Func010C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+2)])
endfunction
function Trig_SaiYaren_BianSHen_Func002Func007Func001C takes nothing returns boolean
return(Trig_SaiYaren_BianSHen_Func002Func007Func001Func010C())
endfunction
function Trig_SaiYaren_BianSHen_Func002Func007A takes nothing returns nothing
if(Trig_SaiYaren_BianSHen_Func002Func007Func001C())then
call PanCameraToTimedLocForPlayer(udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+2)],GetUnitLoc(GetEnumUnit()),0)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call CreateTextTagUnitBJ("|cFF9933FF变身|r"+"|cFFCC9966超级赛亚人の第二阶|r",GetEnumUnit(),0,20.,'d',.0,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_SaiYaren_BianSHen_Func002C takes nothing returns boolean
return(GetEventPlayerChatString()=="变身第二阶")
endfunction
function Trig_SaiYaren_BianSHen_Actions takes nothing returns nothing
if(Trig_SaiYaren_BianSHen_Func001C())then
set udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]='{'
call EnableTrigger(gg_trg_SaiYaren_BianSHenJinengA1)
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengB2)
set udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+1)]=GetTriggerPlayer()
set udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+1)]=true
call ForGroupBJ(GetUnitsOfPlayerAll(udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+1)]),function Trig_SaiYaren_BianSHen_Func001Func007A)
endif
if(Trig_SaiYaren_BianSHen_Func002C())then
set udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]=213
call EnableTrigger(gg_trg_SaiYaren_BianSHenJinengB2)
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengA1)
set udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+2)]=GetTriggerPlayer()
set udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+2)]=true
call ForGroupBJ(GetUnitsOfPlayerAll(udg_SaiYaRenO0[((1+GetPlayerId(GetTriggerPlayer()))+2)]),function Trig_SaiYaren_BianSHen_Func002Func007A)
endif
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Conditions takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+1)]=='{')and(udg_ABCDbu[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+1)])and(GetOwningPlayer(GetAttacker())==udg_SaiYaRenO0[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+1)])and(udg_CHaojiSaiyaren[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=="SaiYaRen")and(udg_CHaoSai[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=='{')and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003001(),Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003002())
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func014Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[1])+I2R(udg_SHuXing[3]))*(udg_SHiSHU[1]+udg_SaiYaRenXiShu)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func014C takes nothing returns boolean
return(GetRandomInt(1,16)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func015C takes nothing returns boolean
return(GetRandomInt(1,14)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003001(),Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003002())
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func016Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[2])+I2R(udg_SHuXing[3]))*udg_SHiSHU[2]),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func016C takes nothing returns boolean
return(GetRandomInt(1,15)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func017C takes nothing returns boolean
return(GetRandomInt(1,14)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003001(),Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003002())
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func018Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[1])+(I2R(udg_SHuXing[3])+I2R(udg_SHuXing[2])))*udg_SHiSHU[1]),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func018C takes nothing returns boolean
return(GetRandomInt(1,17)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003001(),Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003002())
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func019Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(udg_SHuXing[1])+I2R(udg_SHuXing[2]))+(I2R(udg_SHuXing[3])+I2R(udg_SHuXing[4])))*udg_SaiYaRenXiShu),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Func019C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengA1_Actions takes nothing returns nothing
set udg_SHuXing[1]=GetHeroStr(GetAttacker(),true)
set udg_SHuXing[2]=GetHeroAgi(GetAttacker(),true)
set udg_SHuXing[3]=GetHeroInt(GetAttacker(),true)
set udg_SHuXing[4]=GetHeroLevel(GetAttacker())
set udg_SHiSHU[1]=GetRandomReal(1.,6.)
set udg_SHiSHU[2]=GetRandomReal(10.,16.)
set udg_SHiSHU[3]=GetRandomReal(20.,40.)
if(Trig_SaiYaren_BianSHenJinengA1_Func014C())then
call CreateTextTagUnitBJ(("|cFF9933FF魔|r"+"|cFFCC9966闪光|r"),GetAttacker(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,.0)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengA1_Func014Func005001003)),function Trig_SaiYaren_BianSHenJinengA1_Func014Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if(Trig_SaiYaren_BianSHenJinengA1_Func015C())then
call CreateTextTagUnitBJ(("|cFFFF3300100倍|r"+"|cFF33FF33界王拳|r"),GetAttacker(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,140.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(udg_SHuXing[1])+I2R(udg_SHuXing[2]))*(100.*udg_SHiSHU[1])),ATTACK_TYPE_HERO,DAMAGE_TYPE_NORMAL)
endif
if(Trig_SaiYaren_BianSHenJinengA1_Func016C())then
call CreateTextTagUnitBJ(("|cFF9933FF魔贯|r"+"|cFFCC9966光杀炮|r"),GetAttacker(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,120.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengA1_Func016Func006001003)),function Trig_SaiYaren_BianSHenJinengA1_Func016Func006A)
endif
if(Trig_SaiYaren_BianSHenJinengA1_Func017C())then
call CreateTextTagUnitBJ(("|cFFCC0000龙拳|r|cFF33FF33爆发|r"+""),GetAttacker(),0,12.,10.,80.,60.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,50.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\shadowstrike\\shadowstrike.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitMoveSpeed(GetTriggerUnit(),1.)
call SetUnitAcquireRange(GetTriggerUnit(),150.)
call SetUnitVertexColorBJ(GetTriggerUnit(),50.,50.,'d',20.)
call SetUnitScalePercent(GetTriggerUnit(),70.,70.,70.)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(udg_SHuXing[1])+I2R(udg_SHuXing[2]))*(I2R(udg_SHuXing[4])+udg_SHiSHU[1])),ATTACK_TYPE_HERO,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if(Trig_SaiYaren_BianSHenJinengA1_Func018C())then
call CreateTextTagUnitBJ(("|cFF9933FF怒气|r"+"|cFFCC9966连爆|r"),GetAttacker(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,70.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetUnitInvulnerable(GetAttacker(),true)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(850.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengA1_Func018Func006001003)),function Trig_SaiYaren_BianSHenJinengA1_Func018Func006A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
call TriggerSleepAction(3.)
call SetUnitInvulnerable(GetAttacker(),false)
endif
if(Trig_SaiYaren_BianSHenJinengA1_Func019C())then
call CreateTextTagUnitBJ(("|cFF9933FF大爆炸|r"+"|cFFCC9966攻击|r"),GetAttacker(),0,12.,'d','d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,90.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(1200.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengA1_Func019Func006001003)),function Trig_SaiYaren_BianSHenJinengA1_Func019Func006A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Conditions takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+2)]==213)and(udg_ABCDbu[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+2)])and(GetOwningPlayer(GetAttacker())==udg_SaiYaRenO0[((1+GetPlayerId(GetOwningPlayer(GetAttacker())))+2)])and(udg_CHaojiSaiyaren[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=="SaiYaRen")and(udg_CHaoSai[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=='{')and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func013C takes nothing returns boolean
return(GetRandomInt(1,14)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003001(),Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003002())
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func014Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitAcquireRange(GetEnumUnit(),150.)
call SetUnitMoveSpeed(GetEnumUnit(),1.)
call SetUnitVertexColorBJ(GetEnumUnit(),50.,50.,'d',50.)
call SetUnitScalePercent(GetEnumUnit(),60.,60.,60.)
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-30.))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func014C takes nothing returns boolean
return(GetRandomInt(1,14)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003001(),Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003002())
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func015Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmMissile.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[6])+I2R(udg_SHuXing[7]))*(udg_SHiSHU[4]+udg_SaiYaRenXiShu)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
call RemoveLocation(GetUnitLoc(GetAttacker()))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func015C takes nothing returns boolean
return(GetRandomInt(1,16)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003001(),Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003002())
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func016Func007A takes nothing returns nothing
set udg_SHanDianA=(udg_SHanDianA+1)
set udg_SHanDianB[udg_SHanDianA]=GetEnumUnit()
set udg_SHanDIAN[udg_SHanDianA]=GetUnitLoc(GetEnumUnit())
call PauseUnit(GetEnumUnit(),true)
call AddLightningLoc("CHIM",GetUnitLoc(GetTriggerUnit()),udg_SHanDIAN[udg_SHanDianA])
set udg_TExiaoA[udg_SHanDianA]=bj_lastCreatedLightning
call AddSpecialEffectLocBJ(udg_SHanDIAN[udg_SHanDianA],"Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[5])+I2R(udg_SHuXing[7]))*(udg_SHiSHU[4]+(I2R(udg_SHuXing[8])+udg_SaiYaRenXiShu))),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_METAL_HEAVY_SLICE)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func016C takes nothing returns boolean
return(GetRandomInt(1,29)==2)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003 takes nothing returns boolean
return GetBooleanAnd(Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003001(),Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003002())
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017Func006A takes nothing returns nothing
call PauseUnit(GetEnumUnit(),true)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UDeathSmall\\UDeathSmall.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(udg_SHuXing[5])+(I2R(udg_SHuXing[6])+I2R(udg_SHuXing[7])))*(udg_SHiSHU[5]+I2R(udg_SHuXing[8]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017Func008A takes nothing returns nothing
call PauseUnit(GetEnumUnit(),false)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Func017C takes nothing returns boolean
return(GetRandomInt(1,16)==1)
endfunction
function Trig_SaiYaren_BianSHenJinengB2_Actions takes nothing returns nothing
set udg_SHuXing[5]=GetHeroStr(GetAttacker(),true)
set udg_SHuXing[6]=GetHeroAgi(GetAttacker(),true)
set udg_SHuXing[7]=GetHeroInt(GetAttacker(),true)
set udg_SHuXing[8]=GetHeroLevel(GetAttacker())
set udg_SHiSHU[4]=GetRandomReal(5.,9.)
set udg_SHiSHU[5]=GetRandomReal(12.,25.)
if(Trig_SaiYaren_BianSHenJinengB2_Func013C())then
call CreateTextTagUnitBJ(("|cFFFF3300超500倍|r"+"|cFF33FF33界王拳|r"),GetAttacker(),0,14.,.0,.0,'d',.0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,140.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilMissile.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(udg_SHuXing[5])+I2R(udg_SHuXing[6]))*(500.+udg_SaiYaRenXiShu)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_NORMAL)
endif
if(Trig_SaiYaren_BianSHenJinengB2_Func014C())then
call CreateTextTagUnitBJ(("|cFFCC0000超龙拳|r|cFF33FF33爆发|r"+""),GetAttacker(),0,14.,100.,90.,60.,20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,50.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(600.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengB2_Func014Func005001002003))),function Trig_SaiYaren_BianSHenJinengB2_Func014Func005A)
return
endif
if(Trig_SaiYaren_BianSHenJinengB2_Func015C())then
call CreateTextTagUnitBJ(("|cFF9933FF超魔贯|r"+"|cFFCC9966光杀炮|r"),GetAttacker(),0,14.,.0,'d','d',0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,120.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengB2_Func015Func006001003)),function Trig_SaiYaren_BianSHenJinengB2_Func015Func006A)
endif
if(Trig_SaiYaren_BianSHenJinengB2_Func016C())then
call CreateTextTagUnitBJ(("|cFF0033FF终极魔|r"+"|cFFCCFF33闪光|r"),GetAttacker(),0,14.,.0,.0,100.,30.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,70.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
set udg_SHanDianA=0
set udg_Xuanyunzu[2]=GetUnitsInRangeOfLocMatching(1000.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengB2_Func016Func006002003))
call ForGroupBJ(udg_Xuanyunzu[2],function Trig_SaiYaren_BianSHenJinengB2_Func016Func007A)
call TriggerSleepAction(.3)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_SHanDianA
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnit(udg_SHanDianB[bj_forLoopAIndex],false)
call DestroyLightning(udg_TExiaoA[bj_forLoopAIndex])
call RemoveLocation(udg_SHanDIAN[bj_forLoopAIndex])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if(Trig_SaiYaren_BianSHenJinengB2_Func017C())then
call CreateTextTagUnitBJ(("|cFF9933FF超怒气|r"+"|cFFCC9966连爆|r"),GetAttacker(),0,14.,'d','d','d',20.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,120.,70.)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
set udg_Xuanyunzu[1]=GetUnitsInRangeOfLocMatching(1000.,GetUnitLoc(GetAttacker()),Condition(function Trig_SaiYaren_BianSHenJinengB2_Func017Func005002003))
call ForGroupBJ(udg_Xuanyunzu[1],function Trig_SaiYaren_BianSHenJinengB2_Func017Func006A)
call TriggerSleepAction(4.)
call ForGroupBJ(udg_Xuanyunzu[1],function Trig_SaiYaren_BianSHenJinengB2_Func017Func008A)
endif
endfunction
function Trig_SaiYaren_TuiChu_Conditions takes nothing returns boolean
return(udg_CHaoSai[(1+GetPlayerId(GetTriggerPlayer()))]=='{')and(udg_CHaojiSaiyaren[(1+GetPlayerId(GetTriggerPlayer()))]=="SaiYaRen")and(udg_BuernzhiA[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_SaiYaren_TuiChu_Actions takes nothing returns nothing
set udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+2)]=999
set udg_SaiYarenABC[((1+GetPlayerId(GetTriggerPlayer()))+1)]=888
set udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+2)]=false
set udg_ABCDbu[((1+GetPlayerId(GetTriggerPlayer()))+1)]=false
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengA1)
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengB2)
call DisplayTimedTextToPlayer(udg_ZongWanjia[(1+GetPlayerId(GetTriggerPlayer()))],0,0,3.,("|cFF660033退出赛亚人变身系统|r"+""))
endfunction
function Trig_SaiYaren_SHuxing_Func010Func001C takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+2)]==213)and(udg_ABCDbu[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+2)])and(GetOwningPlayer(GetDyingUnit())==udg_SaiYaRenO0[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+2)])
endfunction
function Trig_SaiYaren_SHuxing_Func010Func002C takes nothing returns boolean
return(udg_SaiYarenABC[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+1)]=='{')and(udg_ABCDbu[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+1)])and(GetOwningPlayer(GetDyingUnit())==udg_SaiYaRenO0[((1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))+1)])
endfunction
function Trig_SaiYaren_SHuxing_Func010C takes nothing returns boolean
return(Trig_SaiYaren_SHuxing_Func010Func001C())or(Trig_SaiYaren_SHuxing_Func010Func002C())
endfunction
function Trig_SaiYaren_SHuxing_Conditions takes nothing returns boolean
return(IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO))and(Trig_SaiYaren_SHuxing_Func010C())
endfunction
function Trig_SaiYaren_SHuxing_Actions takes nothing returns nothing
call CreateTextTagUnitBJ(("|cFF660099身体|r"+"|cFF33FF99强化|r"),GetTriggerUnit(),0,13.,'d',100.,100.,0)
set udg_SuiJiShu[(1+GetPlayerId(GetTriggerPlayer()))]=GetRandomInt(3,8)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call ModifyHeroStat(0,GetDyingUnit(),0,udg_SuiJiShu[(1+GetPlayerId(GetTriggerPlayer()))])
call ModifyHeroStat(1,GetDyingUnit(),0,udg_SuiJiShu[(1+GetPlayerId(GetTriggerPlayer()))])
call ModifyHeroStat(2,GetDyingUnit(),0,udg_SuiJiShu[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction