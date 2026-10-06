function Trig_idsrpg2_Func002001 takes nothing returns boolean
return(GetOwningPlayer(GetKillingUnit())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsrpg2_Func002002 takes nothing returns boolean
return(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsrpg2_Func003C takes nothing returns boolean
return(IsTriggerEnabled(gg_trg_idsyxtsgj1))or(IsTriggerEnabled(gg_trg_idsyxtsgj2))or(IsTriggerEnabled(gg_trg_idsyxtsgj3))or(IsTriggerEnabled(gg_trg_idsyxtsgj4))or(IsTriggerEnabled(gg_trg_idsyxtsgj5))
endfunction
function Trig_idsrpg2_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsrpg2_Func002001(),Trig_idsrpg2_Func002002()))and(Trig_idsrpg2_Func003C())
endfunction
function Trig_idsrpg2_Func007Func001Func004A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*10)/100))
call ModifyHeroStat(1,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*10)/100))
call ModifyHeroStat(2,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*10)/100))
endfunction
function Trig_idsrpg2_Func007Func001C takes nothing returns boolean
return(udg_idsxhzs==1)
endfunction
function Trig_idsrpg2_Func007Func002Func004A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*20)/100))
call ModifyHeroStat(1,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*20)/100))
call ModifyHeroStat(2,GetEnumUnit(),0,((GetHeroStr(GetEnumUnit(),false)*20)/100))
endfunction
function Trig_idsrpg2_Func007Func002C takes nothing returns boolean
return(udg_idsxhzs==2)
endfunction
function Trig_idsrpg2_Func007Func003Func004A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,200)
call ModifyHeroStat(1,GetEnumUnit(),0,200)
call ModifyHeroStat(2,GetEnumUnit(),0,200)
endfunction
function Trig_idsrpg2_Func007Func003C takes nothing returns boolean
return(udg_idsxhzs==3)
endfunction
function Trig_idsrpg2_Func007C takes nothing returns boolean
return(udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]==150)
endfunction
function Trig_idsrpg2_Actions takes nothing returns nothing
set udg_idsedw=GetKillingUnit()
set udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]=(udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]+1)
set udg_idsxhzs=GetRandomInt(1,3)
if(Trig_idsrpg2_Func007C())then
if(Trig_idsrpg2_Func007Func001C())then
set udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]=0
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,(udg_idszfsz[100]+("|CFFFF8080"+(GetPlayerName(GetOwningPlayer(udg_idsedw))+"经过长期的锻炼所有属性增加10%|R"))))
call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(udg_idsedw)),function Trig_idsrpg2_Func007Func001Func004A)
endif
if(Trig_idsrpg2_Func007Func002C())then
set udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]=0
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,(udg_idszfsz[101]+("|CFF40FF00"+(GetPlayerName(GetOwningPlayer(udg_idsedw))+"得到绝世功力,所有属性提高20%|R"))))
call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(udg_idsedw)),function Trig_idsrpg2_Func007Func002Func004A)
endif
if(Trig_idsrpg2_Func007Func003C())then
set udg_idsezs[(1+GetPlayerId(GetOwningPlayer(udg_idsedw)))]=0
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,(udg_idszfsz[103]+("|CFFFF00FF"+(GetPlayerName(GetOwningPlayer(udg_idsedw))+"杀敌150人所有属性加200|R"))))
call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(udg_idsedw)),function Trig_idsrpg2_Func007Func003Func004A)
endif
endif
endfunction
function Trig_idsesc_Actions takes nothing returns nothing
call DialogClear(udg_idsdhw)
call DialogSetMessage(udg_idsdhw,(("|CFFFFFF00"+GetPlayerName(GetTriggerPlayer()))+"作弊玩家|R"))
set udg_idsdhan[1]=DialogAddButtonWithHotkeyBJ(udg_idsdhw,(udg_idszfsz[1]+"|cFF008000玩家资源|r A"),'A')
set udg_idsdhan[2]=DialogAddButtonWithHotkeyBJ(udg_idsdhw,(udg_idszfsz[2]+"|CFFFF00FF3c专用|R B"),'B')
set udg_idsdhan[3]=DialogAddButtonWithHotkeyBJ(udg_idsdhw,(udg_idszfsz[3]+"|cFF800000RPG专用|r C"),'C')
set udg_idsdhan[4]=DialogAddButtonWithHotkeyBJ(udg_idsdhw,(udg_idszfsz[4]+"|CFFFFFF00开始游戏|R D"),'D')
call DialogDisplayBJ(true,udg_idsdhw,GetTriggerPlayer())
endfunction
function Trig_idsesc2_Actions takes nothing returns nothing
call DialogClear(udg_idsdhw2)
call DialogSetMessage(udg_idsdhw2,(("|CFFFFFF00"+GetPlayerName(GetTriggerPlayer()))+"作弊玩家|R"))
set udg_idsdhan[6]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[6]+"|CFF00FFFF加钱2000|R A"),'A')
set udg_idsdhan[7]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[7]+"|CFF00FF00加木200|R B"),'B')
set udg_idsdhan[8]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[8]+"|CFFFF0000地图全亮+关闭录象|R C"),'C')
set udg_idsdhan[9]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[9]+"|CFFFFFF00设置使用人口为5|R D"),'D')
set udg_idsdhan[10]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[10]+"|CFFFF00FF自动加钱5W|R E"),'E')
set udg_idsdhan[11]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[11]+"|CFF26EF10自动加木1000|R F"),'F')
set udg_idsdhan[12]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[12]+"|CFF6532FC锁定人口数5|R G"),'G')
set udg_idsdhan[13]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[13]+"|CFF80FFFF关闭自动功能|R H"),'H')
set udg_idsdhan[14]=DialogAddButtonWithHotkeyBJ(udg_idsdhw2,(udg_idszfsz[14]+"|CFF0080FF返回上页|R I"),'I')
call DialogDisplayBJ(true,udg_idsdhw2,GetTriggerPlayer())
endfunction
function Trig_idsesc3_Actions takes nothing returns nothing
call DialogClear(udg_idsdhw3)
call DialogSetMessage(udg_idsdhw3,(("|CFFFFFF00"+GetPlayerName(GetTriggerPlayer()))+"作弊玩家|R"))
set udg_idsdhan[15]=DialogAddButtonWithHotkeyBJ(udg_idsdhw3,(udg_idszfsz[15]+"|cFF008000每杀一个人敌加2点属性|r A"),'A')
set udg_idsdhan[16]=DialogAddButtonWithHotkeyBJ(udg_idsdhw3,(udg_idszfsz[16]+"|CFFFF00FF无限放技能|R B"),'B')
set udg_idsdhan[17]=DialogAddButtonWithHotkeyBJ(udg_idsdhw3,(udg_idszfsz[17]+"|cFF800000自动回血|r C"),'C')
set udg_idsdhan[27]=DialogAddButtonWithHotkeyBJ(udg_idsdhw3,(udg_idszfsz[27]+"|CFFFFFF00关闭所有功能|R D"),'D')
set udg_idsdhan[18]=DialogAddButtonWithHotkeyBJ(udg_idsdhw3,(udg_idszfsz[18]+"|CFF80FFFF返回上页|R E"),'E')
call DialogDisplayBJ(true,udg_idsdhw3,GetTriggerPlayer())
endfunction
function Trig_idsesc4_Actions takes nothing returns nothing
call DialogClear(udg_idsdhw4)
call DialogSetMessage(udg_idsdhw4,(("|CFFFFFF00"+GetPlayerName(GetTriggerPlayer()))+"作弊玩家|R"))
set udg_idsdhan[5]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[5]+"|CFF0080FF全自动恢复|R A"),'A')
set udg_idsdhan[20]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[20]+"|CFF00FF00削弱敌人 3c勿用|R B"),'B')
set udg_idsdhan[21]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[21]+"|CFFFF0000神圣模式|R C"),'C')
set udg_idsdhan[22]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[22]+"|CFFFFFF00复制物品|R D"),'D')
set udg_idsdhan[23]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[23]+"|CFFFF00FF控制单位|R E"),'E')
set udg_idsdhan[24]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[24]+"|CFF26EF10复制单位|R F"),'F')
set udg_idsdhan[19]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[19]+"|CFF00FFFF删除单位|R G"),'G')
set udg_idsdhan[25]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[25]+"|CFF6532FC关闭自动功能|R H"),'H')
set udg_idsdhan[26]=DialogAddButtonWithHotkeyBJ(udg_idsdhw4,(udg_idszfsz[26]+"|CFF80FFFF返回上页|R I"),'I')
call DialogDisplayBJ(true,udg_idsdhw4,GetTriggerPlayer())
endfunction
function Trig_idsesc5_Actions takes nothing returns nothing
call DialogClear(udg_idsdhw5)
call DialogSetMessage(udg_idsdhw5,(("|CFFFFFF00"+GetPlayerName(GetTriggerPlayer()))+"作弊玩家|R"))
set udg_idsdhan[27]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[27]+"|CFF0080FF打人加经验|R A"),'A')
set udg_idsdhan[28]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[28]+"|CFF00FF00专打定怪物|R B"),'B')
set udg_idsdhan[29]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[29]+"|CFFFF0000我专偷钱的|R C"),'C')
set udg_idsdhan[30]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[30]+"|CFFFFFF00我专减速|R D"),'D')
set udg_idsdhan[31]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[31]+"|CFFFF00FF攻击力最强|R E"),'E')
set udg_idsdhan[32]=DialogAddButtonWithHotkeyBJ(udg_idsdhw5,(udg_idszfsz[32]+"|CFF26EF10退出|R F"),'F')
call DialogDisplayBJ(true,udg_idsdhw5,GetTriggerPlayer())
endfunction
function Trig_idsdhkq_Func001001 takes nothing returns boolean
return(udg_idszssz[100]==5)
endfunction
function Trig_idsdhkq_Actions takes nothing returns nothing
if(Trig_idsdhkq_Func001001())then
call ConditionalTriggerExecute(gg_trg_idsesc)
endif
set udg_idszssz[100]=0
endfunction
function Trig_idsDown_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsDown_Actions takes nothing returns nothing
set udg_idszssz[100]=(udg_idsshengjzs+5)
endfunction
function Trig_idsDown_off_Actions takes nothing returns nothing
set udg_idszssz[100]=0
endfunction
function Trig_idsCMD_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsCMD_Func001Func002Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_idsCMD_Func001Func002Func001Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_idsCMD_Func001Func002Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian-")
endfunction
function Trig_idsCMD_Func001Func002Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_idsCMD_Func001Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian+")
endfunction
function Trig_idsCMD_Func001Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian+")or(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian-")or(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian ")
endfunction
function Trig_idsCMD_Func001C takes nothing returns boolean
return(Trig_idsCMD_Func001Func004C())
endfunction
function Trig_idsCMD_Func002Func002Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_idsCMD_Func002Func002Func001Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_idsCMD_Func002Func002Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu-")
endfunction
function Trig_idsCMD_Func002Func002Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_idsCMD_Func002Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu+")
endfunction
function Trig_idsCMD_Func002Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu+")or(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu-")or(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu ")
endfunction
function Trig_idsCMD_Func002C takes nothing returns boolean
return(Trig_idsCMD_Func002Func004C())
endfunction
function Trig_idsCMD_Func003Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji-")
endfunction
function Trig_idsCMD_Func003Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji+")
endfunction
function Trig_idsCMD_Func003Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji+")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji-")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji ")
endfunction
function Trig_idsCMD_Func003C takes nothing returns boolean
return(Trig_idsCMD_Func003Func002C())
endfunction
function Trig_idsCMD_Func004Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing-")
endfunction
function Trig_idsCMD_Func004Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing+")
endfunction
function Trig_idsCMD_Func004Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing+")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing-")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing ")
endfunction
function Trig_idsCMD_Func004C takes nothing returns boolean
return(Trig_idsCMD_Func004Func002C())
endfunction
function Trig_idsCMD_Func005Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang-")
endfunction
function Trig_idsCMD_Func005Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang+")
endfunction
function Trig_idsCMD_Func005Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang+")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang-")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang ")
endfunction
function Trig_idsCMD_Func005C takes nothing returns boolean
return(Trig_idsCMD_Func005Func002C())
endfunction
function Trig_idsCMD_Func006Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie-")
endfunction
function Trig_idsCMD_Func006Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie+")
endfunction
function Trig_idsCMD_Func006Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie+")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie-")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie ")
endfunction
function Trig_idsCMD_Func006C takes nothing returns boolean
return(Trig_idsCMD_Func006Func002C())
endfunction
function Trig_idsCMD_Func007Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili-")
endfunction
function Trig_idsCMD_Func007Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili+")
endfunction
function Trig_idsCMD_Func007Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili+")or(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili-")or(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili ")
endfunction
function Trig_idsCMD_Func007C takes nothing returns boolean
return(Trig_idsCMD_Func007Func002C())
endfunction
function Trig_idsCMD_Func008Func001Func001Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_idsCMD_Func008Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,10)=="=不无敌")
endfunction
function Trig_idsCMD_Func008Func001Func002A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_idsCMD_Func008Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=无敌")
endfunction
function Trig_idsCMD_Func008Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=无敌")or(SubStringBJ(GetEventPlayerChatString(),1,10)=="=不无敌")
endfunction
function Trig_idsCMD_Func008C takes nothing returns boolean
return(Trig_idsCMD_Func008Func002C())
endfunction
function Trig_idsCMD_Actions takes nothing returns nothing
if(Trig_idsCMD_Func001C())then
set udg_idszssz[400]=GetPlayerScore(GetOwningPlayer(udg_idszydw),PLAYER_SCORE_GOLD_MINED_TOTAL)
if(Trig_idsCMD_Func001Func002C())then
if(Trig_idsCMD_Func001Func002Func002C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),7,77)),GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD)
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD,999999)
endif
else
if(Trig_idsCMD_Func001Func002Func001C())then
if(Trig_idsCMD_Func001Func002Func001Func001C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD)-S2I(SubStringBJ(GetEventPlayerChatString(),7,77))))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD,0)
endif
else
if(Trig_idsCMD_Func001Func002Func001Func002C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD,S2I(SubStringBJ(GetEventPlayerChatString(),7,77)))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_GOLD,999999)
endif
endif
endif
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_GOLD_GATHERED,udg_idszssz[400])
endif
if(Trig_idsCMD_Func002C())then
set udg_idszssz[401]=GetPlayerScore(GetOwningPlayer(udg_idszydw),PLAYER_SCORE_LUMBER_TOTAL)
if(Trig_idsCMD_Func002Func002C())then
if(Trig_idsCMD_Func002Func002Func002C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),5,55)),GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER)
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER,999999)
endif
else
if(Trig_idsCMD_Func002Func002Func001C())then
if(Trig_idsCMD_Func002Func002Func001Func001C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER)-S2I(SubStringBJ(GetEventPlayerChatString(),5,55))))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER,0)
endif
else
if(Trig_idsCMD_Func002Func002Func001Func002C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER,S2I(SubStringBJ(GetEventPlayerChatString(),5,55)))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_RESOURCE_LUMBER,999999)
endif
endif
endif
call SetPlayerStateBJ(GetOwningPlayer(udg_idszydw),PLAYER_STATE_LUMBER_GATHERED,udg_idszssz[401])
endif
if(Trig_idsCMD_Func003C())then
if(Trig_idsCMD_Func003Func001C())then
call SetHeroLevelBJ(udg_idszydw,(GetUnitLevel(udg_idszydw)+S2I(SubStringBJ(GetEventPlayerChatString(),9,99))),false)
else
if(Trig_idsCMD_Func003Func001Func001C())then
call SetHeroLevelBJ(udg_idszydw,(GetUnitLevel(udg_idszydw)-S2I(SubStringBJ(GetEventPlayerChatString(),9,99))),false)
else
call SetHeroLevelBJ(udg_idszydw,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)),false)
endif
endif
endif
if(Trig_idsCMD_Func004C())then
if(Trig_idsCMD_Func004Func001C())then
call ModifyHeroStat(0,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
else
if(Trig_idsCMD_Func004Func001Func001C())then
call ModifyHeroStat(0,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
else
call ModifyHeroStat(0,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
endif
endif
endif
if(Trig_idsCMD_Func005C())then
if(Trig_idsCMD_Func005Func001C())then
call ModifyHeroStat(0,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
else
if(Trig_idsCMD_Func005Func001Func001C())then
call ModifyHeroStat(0,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
else
call ModifyHeroStat(0,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
endif
endif
endif
if(Trig_idsCMD_Func006C())then
if(Trig_idsCMD_Func006Func001C())then
call ModifyHeroStat(1,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
else
if(Trig_idsCMD_Func006Func001Func001C())then
call ModifyHeroStat(1,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
else
call ModifyHeroStat(1,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
endif
endif
endif
if(Trig_idsCMD_Func007C())then
if(Trig_idsCMD_Func007Func001C())then
call ModifyHeroStat(2,udg_idszydw,0,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
else
if(Trig_idsCMD_Func007Func001Func001C())then
call ModifyHeroStat(2,udg_idszydw,1,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
else
call ModifyHeroStat(2,udg_idszydw,2,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
endif
endif
endif
if(Trig_idsCMD_Func008C())then
if(Trig_idsCMD_Func008Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_idsCMD_Func008Func001Func002A)
else
if(Trig_idsCMD_Func008Func001Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_idsCMD_Func008Func001Func001Func001A)
endif
endif
endif
endfunction
function Trig_idsdwxz_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsdwxz_Actions takes nothing returns nothing
set udg_idszydw=GetTriggerUnit()
endfunction
function Trig_idskqzb_Actions takes nothing returns nothing
set udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerPlayer()
call EnableTrigger(gg_trg_idscjyd)
call ConditionalTriggerExecute(gg_trg_idsesc5)
call TriggerSleepAction(1200.)
call DestroyTrigger(gg_trg_idskqzb)
endfunction
function Trig_idsdhw_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[1])
endfunction
function Trig_idsdhw_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[2])
endfunction
function Trig_idsdhw_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[3])
endfunction
function Trig_idsdhw_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[4])
endfunction
function Trig_idsdhw_Actions takes nothing returns nothing
if(Trig_idsdhw_Func001C())then
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw_Func002C())then
call ConditionalTriggerExecute(gg_trg_idsesc3)
endif
if(Trig_idsdhw_Func003C())then
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw_Func004C())then
call DialogClear(udg_idsdhw)
endif
endfunction
function Trig_idsdhw2_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[6])
endfunction
function Trig_idsdhw2_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[7])
endfunction
function Trig_idsdhw2_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[8])
endfunction
function Trig_idsdhw2_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[9])
endfunction
function Trig_idsdhw2_Func005C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[10])
endfunction
function Trig_idsdhw2_Func006C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[11])
endfunction
function Trig_idsdhw2_Func007C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[12])
endfunction
function Trig_idsdhw2_Func008C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[13])
endfunction
function Trig_idsdhw2_Func009C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[14])
endfunction
function Trig_idsdhw2_Actions takes nothing returns nothing
if(Trig_idsdhw2_Func001C())then
call AdjustPlayerStateBJ(2000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-2000,GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func002C())then
call AdjustPlayerStateBJ(200,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-200,GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func003C())then
call SetPlayerAlliance(GetTriggerPlayer(),Player(1),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(2),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(3),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(4),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(5),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(6),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(7),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(8),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(9),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(10),ALLIANCE_SHARED_VISION,false)
call SetPlayerAlliance(GetTriggerPlayer(),Player(11),ALLIANCE_SHARED_VISION,false)
call CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetWorldBounds())
call DoNotSaveReplay()
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func004C())then
call SetPlayerStateBJ(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_RESOURCE_FOOD_USED,5)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func005C())then
call EnableTrigger(gg_trg_idszdjiaq)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func006C())then
call EnableTrigger(gg_trg_idszdjiam)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func007C())then
call EnableTrigger(gg_trg_idsrksd)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func008C())then
call DisableTrigger(gg_trg_idsrksd)
call DisableTrigger(gg_trg_idszdjiam)
call DisableTrigger(gg_trg_idszdjiaq)
call ConditionalTriggerExecute(gg_trg_idsesc2)
endif
if(Trig_idsdhw2_Func009C())then
call DialogClear(udg_idsdhw2)
call ConditionalTriggerExecute(gg_trg_idsesc)
endif
endfunction
function Trig_idsdhw3_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[15])
endfunction
function Trig_idsdhw3_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[16])
endfunction
function Trig_idsdhw3_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[17])
endfunction
function Trig_idsdhw3_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[18])
endfunction
function Trig_idsdhw3_Func005C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[27])
endfunction
function Trig_idsdhw3_Actions takes nothing returns nothing
if(Trig_idsdhw3_Func001C())then
call EnableTrigger(gg_trg_ids3c1)
call ConditionalTriggerExecute(gg_trg_idsesc3)
endif
if(Trig_idsdhw3_Func002C())then
call EnableTrigger(gg_trg_ids3c2)
call ConditionalTriggerExecute(gg_trg_idsesc3)
endif
if(Trig_idsdhw3_Func003C())then
call EnableTrigger(gg_trg_ids3c3)
call ConditionalTriggerExecute(gg_trg_idsesc3)
endif
if(Trig_idsdhw3_Func004C())then
call DialogClear(udg_idsdhw3)
call ConditionalTriggerExecute(gg_trg_idsesc)
endif
if(Trig_idsdhw3_Func005C())then
call DisableTrigger(gg_trg_ids3c1)
call DisableTrigger(gg_trg_ids3c2)
call DisableTrigger(gg_trg_ids3c3)
call ConditionalTriggerExecute(gg_trg_idsesc3)
endif
endfunction
function Trig_idsdhw4_Func001Func001002 takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_idsdhw4_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[19])
endfunction
function Trig_idsdhw4_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[20])
endfunction
function Trig_idsdhw4_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[21])
endfunction
function Trig_idsdhw4_Func004Func001Func003Func001A takes nothing returns nothing
call GroupAddUnit(udg_idscjdwz,GetEnumUnit())
endfunction
function Trig_idsdhw4_Func004Func001Func003Func002A takes nothing returns nothing
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),1)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),2)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),3)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),4)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),5)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),6)),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_idsdhw4_Func004Func001Func003C takes nothing returns boolean
return(udg_idszssz[200]==1)
endfunction
function Trig_idsdhw4_Func004Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsdhw4_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[22])
endfunction
function Trig_idsdhw4_Func005Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(udg_idszydw),GetPlayersByMapControl(MAP_CONTROL_USER)))
endfunction
function Trig_idsdhw4_Func005C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[23])
endfunction
function Trig_idsdhw4_Func006Func001A takes nothing returns nothing
call CreateNUnitsAtLocFacingLocBJ(1,GetUnitTypeId(GetEnumUnit()),udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetEnumUnit()),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_idsdhw4_Func006C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[24])
endfunction
function Trig_idsdhw4_Func007C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[25])
endfunction
function Trig_idsdhw4_Func008C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[26])
endfunction
function Trig_idsdhw4_Func009C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[5])
endfunction
function Trig_idsdhw4_Actions takes nothing returns nothing
if(Trig_idsdhw4_Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_idsdhw4_Func001Func001002)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func002C())then
call EnableTrigger(gg_trg_idsegdr)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func003C())then
call EnableTrigger(gg_trg_idsrpg4)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func004C())then
if(Trig_idsdhw4_Func004Func001C())then
set udg_idszssz[200]=(udg_idszssz[200]+1)
if(Trig_idsdhw4_Func004Func001Func003C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_idsdhw4_Func004Func001Func003Func001A)
else
call ForGroupBJ(udg_idscjdwz,function Trig_idsdhw4_Func004Func001Func003Func002A)
call GroupClear(udg_idscjdwz)
set udg_idszssz[200]=0
endif
endif
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func005C())then
if(Trig_idsdhw4_Func005Func001C())then
call SetPlayerAllianceBJ(GetOwningPlayer(udg_idszydw),ALLIANCE_SHARED_CONTROL,true,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
return
else
call SetUnitOwner(udg_idszydw,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],true)
return
endif
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func006C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_idsdhw4_Func006Func001A)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func007C())then
call DisableTrigger(gg_trg_idsegdr)
call DisableTrigger(gg_trg_idsrpg4)
call DisableTrigger(gg_trg_idszdhf)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
if(Trig_idsdhw4_Func008C())then
call DialogClear(udg_idsdhw4)
call TriggerExecute(gg_trg_idsesc)
endif
if(Trig_idsdhw4_Func009C())then
call EnableTrigger(gg_trg_idszdhf)
call ConditionalTriggerExecute(gg_trg_idsesc4)
endif
endfunction
function Trig_idsdhw5_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[27])
endfunction
function Trig_idsdhw5_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[28])
endfunction
function Trig_idsdhw5_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[29])
endfunction
function Trig_idsdhw5_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[30])
endfunction
function Trig_idsdhw5_Func005C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[31])
endfunction
function Trig_idsdhw5_Func006C takes nothing returns boolean
return(GetClickedButton()==udg_idsdhan[32])
endfunction
function Trig_idsdhw5_Actions takes nothing returns nothing
if(Trig_idsdhw5_Func001C())then
set udg_idszssz[801]=(1+GetPlayerId(GetOwningPlayer(GetAttacker())))
call EnableTrigger(gg_trg_idsyxtsgj1)
endif
if(Trig_idsdhw5_Func002C())then
set udg_idszssz[802]=(1+GetPlayerId(GetOwningPlayer(GetAttacker())))
call EnableTrigger(gg_trg_idsyxtsgj2)
endif
if(Trig_idsdhw5_Func003C())then
set udg_idszssz[803]=(1+GetPlayerId(GetOwningPlayer(GetAttacker())))
call EnableTrigger(gg_trg_idsyxtsgj3)
endif
if(Trig_idsdhw5_Func004C())then
set udg_idszssz[804]=(1+GetPlayerId(GetOwningPlayer(GetAttacker())))
call EnableTrigger(gg_trg_idsyxtsgj4)
endif
if(Trig_idsdhw5_Func005C())then
set udg_idszssz[805]=(1+GetPlayerId(GetOwningPlayer(GetAttacker())))
call EnableTrigger(gg_trg_idsyxtsgj5)
endif
if(Trig_idsdhw5_Func006C())then
call DialogClear(udg_idsdhw5)
endif
endfunction
function Trig_idsyj_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsyj_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),GetTriggerPlayer())+1),GetOwningPlayer(GetResearchingUnit()))
endfunction
function Trig_idsJZ_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsJZ_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call UnitSetConstructionProgress(GetConstructingStructure(),'d')
endfunction
function Trig_idssj_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idssj_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call UnitSetUpgradeProgress(GetTriggerUnit(),'d')
endfunction
function Trig_idszdjiam_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(1000,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-1000,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_LUMBER_GATHERED)
endfunction
function Trig_idszdjiaq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(50000,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-50000,udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_GOLD_GATHERED)
endfunction
function Trig_idsrksd_Actions takes nothing returns nothing
call SetPlayerStateBJ(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))],PLAYER_STATE_RESOURCE_FOOD_USED,5)
endfunction
function Trig_ids3c1_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetKillingUnit())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_ids3c1_Func002A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,2)
call ModifyHeroStat(1,GetEnumUnit(),0,2)
call ModifyHeroStat(2,GetEnumUnit(),0,2)
endfunction
function Trig_ids3c1_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_ids3c1_Func002A)
endfunction
function Trig_ids3c2_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_ids3c2_Func002A takes nothing returns nothing
call UnitResetCooldown(GetEnumUnit())
call UnitRemoveBuffsBJ(1,GetEnumUnit())
call SetUnitManaPercentBJ(GetEnumUnit(),75.)
endfunction
function Trig_ids3c2_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_ids3c2_Func002A)
endfunction
function Trig_ids3c3_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_ids3c3_Func002A takes nothing returns nothing
call SetWidgetLife(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetEnumUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetEnumUnit())*.1)))
endfunction
function Trig_ids3c3_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_ids3c3_Func002A)
endfunction
function Trig_idszdhf_Func001Func006001 takes nothing returns boolean
return(GetUnitManaPercent(GetEnumUnit())<=20.)
endfunction
function Trig_idszdhf_Func001Func007001 takes nothing returns boolean
return(GetUnitLifePercent(GetEnumUnit())<=20.)
endfunction
function Trig_idszdhf_Func001A takes nothing returns nothing
call UnitRemoveBuffsBJ(1,GetEnumUnit())
call UnitResetCooldown(GetEnumUnit())
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call SetWidgetLife(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetEnumUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetEnumUnit())*.05)))
call SetUnitManaBJ(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())*.05)))
if(Trig_idszdhf_Func001Func006001())then
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
endif
if(Trig_idszdhf_Func001Func007001())then
call SetUnitLifePercentBJ(GetEnumUnit(),'d')
endif
endfunction
function Trig_idszdhf_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]),function Trig_idszdhf_Func001A)
endfunction
function Trig_idsegdr_Actions takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_idsrpg1)
endfunction
function Trig_idsrpg1_Func001Func001Func002A takes nothing returns nothing
call SetWidgetLife(GetEnumUnit(),1.)
call SetUnitManaBJ(GetEnumUnit(),1.)
call SetHeroXP(GetEnumUnit(),1,false)
call ModifyHeroStat(0,GetEnumUnit(),2,1)
call ModifyHeroStat(1,GetEnumUnit(),2,1)
call ModifyHeroStat(2,GetEnumUnit(),2,1)
endfunction
function Trig_idsrpg1_Func001Func001C takes nothing returns boolean
return(IsPlayerEnemy(Player(-1+(bj_forLoopAIndex)),udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))]))
endfunction
function Trig_idsrpg1_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_idsrpg1_Func001Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(Player(-1+(bj_forLoopAIndex))),function Trig_idsrpg1_Func001Func001Func002A)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_idsrpg4_Func001Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()),GetPlayersByMapControl(MAP_CONTROL_USER)))
endfunction
function Trig_idsrpg4_Func001C takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsrpg4_Func002Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(GetAttacker()),GetPlayersAllies(udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])))
endfunction
function Trig_idsrpg4_Func002C takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idsrpg4_Actions takes nothing returns nothing
if(Trig_idsrpg4_Func001C())then
if(Trig_idsrpg4_Func001Func001C())then
else
call SetUnitManaPercentBJ(GetTriggerUnit(),.0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())*GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endif
endif
if(Trig_idsrpg4_Func002C())then
if(Trig_idsrpg4_Func002Func001C())then
else
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call SetUnitManaPercentBJ(GetTriggerUnit(),'d')
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())*GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endif
endif
endfunction
function Trig_idscjyd_Func001001 takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_idswjsz[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_idscjyd_Func001002 takes nothing returns boolean
return(OrderId2StringBJ(GetIssuedOrderId())=="patrol")
endfunction
function Trig_idscjyd_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idscjyd_Func001001(),Trig_idscjyd_Func001002()))
endfunction
function Trig_idscjyd_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_idsyxtsgj1_Func001001 takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsyxtsgj1_Func001002 takes nothing returns boolean
return(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsyxtsgj1_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsyxtsgj1_Func001001(),Trig_idsyxtsgj1_Func001002()))and((1+GetPlayerId(GetOwningPlayer(GetAttacker())))==udg_idszssz[801])
endfunction
function Trig_idsyxtsgj1_Func003C takes nothing returns boolean
return(GetRandomInt(1,25)==1)
endfunction
function Trig_idsyxtsgj1_Func004C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj1_Func005C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj1_Func006Func006001002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_idsyxtsgj1_Func006Func006001002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_idsyxtsgj1_Func006Func006001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_idsyxtsgj1_Func006Func006001002003001(),Trig_idsyxtsgj1_Func006Func006001002003002())
endfunction
function Trig_idsyxtsgj1_Func006Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
set udg_idsss=((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+(SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*35.))
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(udg_idsss+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*40.)*40.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call UnitRemoveBuffsBJ(2,GetEnumUnit())
endfunction
function Trig_idsyxtsgj1_Func006C takes nothing returns boolean
return(GetRandomInt(1,'d')==1)
endfunction
function Trig_idsyxtsgj1_Actions takes nothing returns nothing
if(Trig_idsyxtsgj1_Func003C())then
call CreateTextTagUnitBJ((udg_idszfsz['e']+"增加经验"),GetAttacker(),0,25.,70.,.0,100.,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_COLD)
call AddHeroXPSwapped(1000,GetAttacker(),true)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
endif
if(Trig_idsyxtsgj1_Func004C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_FIRE)
endif
if(Trig_idsyxtsgj1_Func005C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\ReviveNightElf\\ReviveNightElf.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MIND)
endif
if(Trig_idsyxtsgj1_Func006C())then
set udg_idsdian[1]=GetUnitLoc(GetTriggerUnit())
call CreateTextTagUnitBJ((udg_idszfsz['i']+"删除你所有的效果"),GetAttacker(),0,25.,70.,.0,100.,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(800.,udg_idsdian[1],Condition(function Trig_idsyxtsgj1_Func006Func006001002003))),function Trig_idsyxtsgj1_Func006Func006A)
call RemoveLocation(udg_idsdian[1])
endif
endfunction
function Trig_idsyxtsgj2_Func005001 takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsyxtsgj2_Func005002 takes nothing returns boolean
return(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsyxtsgj2_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsyxtsgj2_Func005001(),Trig_idsyxtsgj2_Func005002()))and((1+GetPlayerId(GetOwningPlayer(GetAttacker())))==udg_idszssz[802])
endfunction
function Trig_idsyxtsgj2_Func001C takes nothing returns boolean
return(GetRandomInt(1,25)==1)
endfunction
function Trig_idsyxtsgj2_Func002C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj2_Func003C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj2_Func004Func006001002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_idsyxtsgj2_Func004Func006001002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_idsyxtsgj2_Func004Func006001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_idsyxtsgj2_Func004Func006001002003001(),Trig_idsyxtsgj2_Func004Func006001002003002())
endfunction
function Trig_idsyxtsgj2_Func004Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
set udg_idsss=((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+(SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*35.))
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(udg_idsss+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*45.)*45.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call PauseUnit(GetEnumUnit(),true)
call TriggerSleepAction(5.)
call PauseUnit(GetEnumUnit(),false)
endfunction
function Trig_idsyxtsgj2_Func004C takes nothing returns boolean
return(GetRandomInt(1,'d')==1)
endfunction
function Trig_idsyxtsgj2_Actions takes nothing returns nothing
if(Trig_idsyxtsgj2_Func001C())then
call CreateTextTagUnitBJ((udg_idszfsz['g']+"给我停住"),GetAttacker(),0,25.,50.,60.,70.,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call PauseUnit(GetTriggerUnit(),true)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
endif
if(Trig_idsyxtsgj2_Func002C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_DIVINE)
endif
if(Trig_idsyxtsgj2_Func003C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_LIGHTNING)
endif
if(Trig_idsyxtsgj2_Func004C())then
set udg_idsdian[3]=GetUnitLoc(GetTriggerUnit())
call CreateTextTagUnitBJ((udg_idszfsz['j']+"全部停住"),GetAttacker(),0,25.,50.,60.,70.,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(800.,udg_idsdian[3],Condition(function Trig_idsyxtsgj2_Func004Func006001002003))),function Trig_idsyxtsgj2_Func004Func006A)
call RemoveLocation(udg_idsdian[3])
endif
endfunction
function Trig_idsyxtsgj3_Func005001 takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsyxtsgj3_Func005002 takes nothing returns boolean
return(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsyxtsgj3_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsyxtsgj3_Func005001(),Trig_idsyxtsgj3_Func005002()))and((1+GetPlayerId(GetOwningPlayer(GetAttacker())))==udg_idszssz[803])
endfunction
function Trig_idsyxtsgj3_Func001C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj3_Func002C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj3_Func003C takes nothing returns boolean
return(GetRandomInt(1,25)==1)
endfunction
function Trig_idsyxtsgj3_Func004Func006001002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_idsyxtsgj3_Func004Func006001002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_idsyxtsgj3_Func004Func006001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_idsyxtsgj3_Func004Func006001002003001(),Trig_idsyxtsgj3_Func004Func006001002003002())
endfunction
function Trig_idsyxtsgj3_Func004Func006Func005003001002 takes nothing returns boolean
return(IsUnitAlly(GetTriggerUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_idsyxtsgj3_Func004Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
set udg_idsss=((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+(SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*35.))
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(udg_idsss+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*40.)*40.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call IssueTargetOrderById(GetEnumUnit(),851983,GroupPickRandomUnit(GetUnitsOfPlayerMatching(GetOwningPlayer(GetTriggerUnit()),Condition(function Trig_idsyxtsgj3_Func004Func006Func005003001002))))
endfunction
function Trig_idsyxtsgj3_Func004C takes nothing returns boolean
return(GetRandomInt(1,'d')==1)
endfunction
function Trig_idsyxtsgj3_Actions takes nothing returns nothing
if(Trig_idsyxtsgj3_Func001C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_FIRE)
endif
if(Trig_idsyxtsgj3_Func002C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MIND)
endif
if(Trig_idsyxtsgj3_Func003C())then
call CreateTextTagUnitBJ((udg_idszfsz['f']+"偷到钱了"),GetAttacker(),0,25.,10.,80.,.0,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_COLD)
call AdjustPlayerStateBJ((GetHeroLevel(GetAttacker())*1000),GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
endif
if(Trig_idsyxtsgj3_Func004C())then
set udg_idsdian[2]=GetUnitLoc(GetTriggerUnit())
call CreateTextTagUnitBJ((udg_idszfsz['k']+"打乱你"),GetAttacker(),0,25.,10.,80.,.0,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(800.,udg_idsdian[2],Condition(function Trig_idsyxtsgj3_Func004Func006001002003))),function Trig_idsyxtsgj3_Func004Func006A)
call RemoveLocation(udg_idsdian[2])
endif
endfunction
function Trig_idsyxtsgj4_Func005001 takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsyxtsgj4_Func005002 takes nothing returns boolean
return(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsyxtsgj4_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsyxtsgj4_Func005001(),Trig_idsyxtsgj4_Func005002()))and((1+GetPlayerId(GetOwningPlayer(GetAttacker())))==udg_idszssz[804])
endfunction
function Trig_idsyxtsgj4_Func001C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj4_Func002C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj4_Func003C takes nothing returns boolean
return(GetRandomInt(1,25)==1)
endfunction
function Trig_idsyxtsgj4_Func004Func006001002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_idsyxtsgj4_Func004Func006001002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_idsyxtsgj4_Func004Func006001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_idsyxtsgj4_Func004Func006001002003001(),Trig_idsyxtsgj4_Func004Func006001002003002())
endfunction
function Trig_idsyxtsgj4_Func004Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
set udg_idsss=((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+(SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*35.))
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(udg_idsss+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*40.)*40.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
call SetUnitMoveSpeed(GetEnumUnit(),-300.)
endfunction
function Trig_idsyxtsgj4_Func004C takes nothing returns boolean
return(GetRandomInt(1,'d')==1)
endfunction
function Trig_idsyxtsgj4_Actions takes nothing returns nothing
if(Trig_idsyxtsgj4_Func001C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\Immolation\\ImmolationTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_FIRE)
endif
if(Trig_idsyxtsgj4_Func002C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MIND)
endif
if(Trig_idsyxtsgj4_Func003C())then
call CreateTextTagUnitBJ((udg_idszfsz['f']+"滚远点"),GetAttacker(),0,25.,10.,80.,.0,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_COLD)
call IssuePointOrderByIdLoc(GetTriggerUnit(),851986,GetRandomLocInRect(GetWorldBounds()))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
endif
if(Trig_idsyxtsgj4_Func004C())then
set udg_idsdian[2]=GetUnitLoc(GetTriggerUnit())
call CreateTextTagUnitBJ((udg_idszfsz['l']+"减你速度"),GetAttacker(),0,25.,10.,80.,.0,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(800.,udg_idsdian[2],Condition(function Trig_idsyxtsgj4_Func004Func006001002003))),function Trig_idsyxtsgj4_Func004Func006A)
call RemoveLocation(udg_idsdian[2])
endif
endfunction
function Trig_idsyxtsgj5_Func005001 takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_idswjsz[(1+GetPlayerId(GetEnumPlayer()))])
endfunction
function Trig_idsyxtsgj5_Func005002 takes nothing returns boolean
return(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_idsyxtsgj5_Conditions takes nothing returns boolean
return(GetBooleanAnd(Trig_idsyxtsgj5_Func005001(),Trig_idsyxtsgj5_Func005002()))and((1+GetPlayerId(GetOwningPlayer(GetAttacker())))==udg_idszssz[805])
endfunction
function Trig_idsyxtsgj5_Func001C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj5_Func002C takes nothing returns boolean
return(GetRandomInt(1,20)==1)
endfunction
function Trig_idsyxtsgj5_Func003C takes nothing returns boolean
return(GetRandomInt(1,25)==1)
endfunction
function Trig_idsyxtsgj5_Func004Func006001002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_idsyxtsgj5_Func004Func006001002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_idsyxtsgj5_Func004Func006001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_idsyxtsgj5_Func004Func006001002003001(),Trig_idsyxtsgj5_Func004Func006001002003002())
endfunction
function Trig_idsyxtsgj5_Func004Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
set udg_idsss=((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+(SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*35.))
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(udg_idsss+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*180.)*800.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_idsyxtsgj5_Func004C takes nothing returns boolean
return(GetRandomInt(1,'d')==1)
endfunction
function Trig_idsyxtsgj5_Actions takes nothing returns nothing
if(Trig_idsyxtsgj5_Func001C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_FIRE)
endif
if(Trig_idsyxtsgj5_Func002C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Other\\Incinerate\\IncinerateBuff.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MIND)
endif
if(Trig_idsyxtsgj5_Func003C())then
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((SquareRoot(I2R(GetHeroStr(GetAttacker(),true)))+SquareRoot(I2R(GetHeroAgi(GetAttacker(),true))))+((SquareRoot(I2R(GetHeroInt(GetAttacker(),true)))*.3)+100.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_COLD)
call UnitDropItemPointLoc(GetTriggerUnit(),UnitItemInSlotBJ(GetTriggerUnit(),1),GetUnitLoc(GetTriggerUnit()))
endif
if(Trig_idsyxtsgj5_Func004C())then
set udg_idsdian[4]=GetUnitLoc(GetTriggerUnit())
call CreateTextTagUnitBJ((udg_idszfsz['h']+"群魔乱舞"),GetAttacker(),0,25.,90.,80.,70.,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,1.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,80.,GetRandomReal(0,360))
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(800.,udg_idsdian[4],Condition(function Trig_idsyxtsgj5_Func004Func006001002003))),function Trig_idsyxtsgj5_Func004Func006A)
call RemoveLocation(udg_idsdian[4])
endif
endfunction
function qiyuzy takes nothing returns nothing
local integer i
set i=0
set udg_idsdhw=DialogCreate()
set udg_idsdhw2=DialogCreate()
set udg_idsdhw3=DialogCreate()
set udg_idsdhw4=DialogCreate()
set i=0
loop
exitwhen(i>1)
set udg_idszfsz[i]=""
set udg_idszssz[i]=0
set udg_idsezs[i]=0
set i=i+1
endloop
set udg_idsdhw5=DialogCreate()
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsrpg2,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_idsrpg2,Condition(function Trig_idsrpg2_Conditions))
call TriggerAddAction(gg_trg_idsrpg2,function Trig_idsrpg2_Actions)
call DisableTrigger(gg_trg_idsesc)
call TriggerAddAction(gg_trg_idsesc,function Trig_idsesc_Actions)
call DisableTrigger(gg_trg_idsesc2)
call TriggerAddAction(gg_trg_idsesc2,function Trig_idsesc2_Actions)
call DisableTrigger(gg_trg_idsesc3)
call TriggerAddAction(gg_trg_idsesc3,function Trig_idsesc3_Actions)
call DisableTrigger(gg_trg_idsesc4)
call TriggerAddAction(gg_trg_idsesc4,function Trig_idsesc4_Actions)
call DisableTrigger(gg_trg_idsesc5)
call TriggerAddAction(gg_trg_idsesc5,function Trig_idsesc5_Actions)
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_idsdhkq,Player(6))
call TriggerAddAction(gg_trg_idsdhkq,function Trig_idsdhkq_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(0),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(1),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(2),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(3),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(4),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(5),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown,Player(6),0,2)
call TriggerAddCondition(gg_trg_idsDown,Condition(function Trig_idsDown_Conditions))
call TriggerAddAction(gg_trg_idsDown,function Trig_idsDown_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(0),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(1),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(2),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(3),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(4),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(5),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_idsDown_off,Player(6),1,2)
call TriggerAddAction(gg_trg_idsDown_off,function Trig_idsDown_off_Actions)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(0),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(1),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(2),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(3),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(4),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(5),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_idsCMD,Player(6),"=",false)
call TriggerAddCondition(gg_trg_idsCMD,Condition(function Trig_idsCMD_Conditions))
call TriggerAddAction(gg_trg_idsCMD,function Trig_idsCMD_Actions)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_idsdwxz,Player(6),true)
call TriggerAddCondition(gg_trg_idsdwxz,Condition(function Trig_idsdwxz_Conditions))
call TriggerAddAction(gg_trg_idsdwxz,function Trig_idsdwxz_Actions)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(0),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(1),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(2),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(3),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(4),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(5),"奇遇",true)
call TriggerRegisterPlayerChatEvent(gg_trg_idskqzb,Player(6),"奇遇",true)
call TriggerAddAction(gg_trg_idskqzb,function Trig_idskqzb_Actions)
call TriggerRegisterDialogEvent(gg_trg_idsdhw,udg_idsdhw)
call TriggerAddAction(gg_trg_idsdhw,function Trig_idsdhw_Actions)
call TriggerRegisterDialogEvent(gg_trg_idsdhw2,udg_idsdhw2)
call TriggerAddAction(gg_trg_idsdhw2,function Trig_idsdhw2_Actions)
call TriggerRegisterDialogEvent(gg_trg_idsdhw3,udg_idsdhw3)
call TriggerAddAction(gg_trg_idsdhw3,function Trig_idsdhw3_Actions)
call TriggerRegisterDialogEvent(gg_trg_idsdhw4,udg_idsdhw4)
call TriggerAddAction(gg_trg_idsdhw4,function Trig_idsdhw4_Actions)
call TriggerRegisterDialogEvent(gg_trg_idsdhw5,udg_idsdhw5)
call TriggerAddAction(gg_trg_idsdhw5,function Trig_idsdhw5_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyj,EVENT_PLAYER_UNIT_RESEARCH_START)
call TriggerAddCondition(gg_trg_idsyj,Condition(function Trig_idsyj_Conditions))
call TriggerAddAction(gg_trg_idsyj,function Trig_idsyj_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsJZ,EVENT_PLAYER_UNIT_CONSTRUCT_START)
call TriggerAddCondition(gg_trg_idsJZ,Condition(function Trig_idsJZ_Conditions))
call TriggerAddAction(gg_trg_idsJZ,function Trig_idsJZ_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idssj,EVENT_PLAYER_UNIT_UPGRADE_START)
call TriggerAddCondition(gg_trg_idssj,Condition(function Trig_idssj_Conditions))
call TriggerAddAction(gg_trg_idssj,function Trig_idssj_Actions)
call DisableTrigger(gg_trg_idszdjiam)
call TriggerRegisterTimerEventPeriodic(gg_trg_idszdjiam,30.)
call TriggerAddAction(gg_trg_idszdjiam,function Trig_idszdjiam_Actions)
call DisableTrigger(gg_trg_idszdjiaq)
call TriggerRegisterTimerEventPeriodic(gg_trg_idszdjiaq,30.)
call TriggerAddAction(gg_trg_idszdjiaq,function Trig_idszdjiaq_Actions)
call DisableTrigger(gg_trg_idsrksd)
call TriggerRegisterTimerEventPeriodic(gg_trg_idsrksd,.5)
call TriggerAddAction(gg_trg_idsrksd,function Trig_idsrksd_Actions)
call DisableTrigger(gg_trg_ids3c1)
call TriggerRegisterAnyUnitEventBJ(gg_trg_ids3c1,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_ids3c1,Condition(function Trig_ids3c1_Conditions))
call TriggerAddAction(gg_trg_ids3c1,function Trig_ids3c1_Actions)
call DisableTrigger(gg_trg_ids3c2)
call TriggerRegisterAnyUnitEventBJ(gg_trg_ids3c2,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_ids3c2,Condition(function Trig_ids3c2_Conditions))
call TriggerAddAction(gg_trg_ids3c2,function Trig_ids3c2_Actions)
call DisableTrigger(gg_trg_ids3c3)
call TriggerRegisterTimerEventPeriodic(gg_trg_ids3c3,.5)
call TriggerAddCondition(gg_trg_ids3c3,Condition(function Trig_ids3c3_Conditions))
call TriggerAddAction(gg_trg_ids3c3,function Trig_ids3c3_Actions)
call DisableTrigger(gg_trg_idszdhf)
call TriggerRegisterTimerEventPeriodic(gg_trg_idszdhf,.5)
call TriggerAddAction(gg_trg_idszdhf,function Trig_idszdhf_Actions)
call DisableTrigger(gg_trg_idsegdr)
call TriggerRegisterTimerEventPeriodic(gg_trg_idsegdr,.5)
call TriggerAddAction(gg_trg_idsegdr,function Trig_idsegdr_Actions)
call TriggerAddAction(gg_trg_idsrpg1,function Trig_idsrpg1_Actions)
call DisableTrigger(gg_trg_idsrpg4)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsrpg4,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(gg_trg_idsrpg4,function Trig_idsrpg4_Actions)
call DisableTrigger(gg_trg_idscjyd)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idscjyd,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_idscjyd,Condition(function Trig_idscjyd_Conditions))
call TriggerAddAction(gg_trg_idscjyd,function Trig_idscjyd_Actions)
call DisableTrigger(gg_trg_idsyxtsgj1)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyxtsgj1,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_idsyxtsgj1,Condition(function Trig_idsyxtsgj1_Conditions))
call TriggerAddAction(gg_trg_idsyxtsgj1,function Trig_idsyxtsgj1_Actions)
call DisableTrigger(gg_trg_idsyxtsgj2)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyxtsgj2,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_idsyxtsgj2,Condition(function Trig_idsyxtsgj2_Conditions))
call TriggerAddAction(gg_trg_idsyxtsgj2,function Trig_idsyxtsgj2_Actions)
call DisableTrigger(gg_trg_idsyxtsgj3)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyxtsgj3,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_idsyxtsgj3,Condition(function Trig_idsyxtsgj3_Conditions))
call TriggerAddAction(gg_trg_idsyxtsgj3,function Trig_idsyxtsgj3_Actions)
call DisableTrigger(gg_trg_idsyxtsgj4)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyxtsgj4,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_idsyxtsgj4,Condition(function Trig_idsyxtsgj4_Conditions))
call TriggerAddAction(gg_trg_idsyxtsgj4,function Trig_idsyxtsgj4_Actions)
call DisableTrigger(gg_trg_idsyxtsgj5)
call TriggerRegisterAnyUnitEventBJ(gg_trg_idsyxtsgj5,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_idsyxtsgj5,Condition(function Trig_idsyxtsgj5_Conditions))
call TriggerAddAction(gg_trg_idsyxtsgj5,function Trig_idsyxtsgj5_Actions)
endfunction