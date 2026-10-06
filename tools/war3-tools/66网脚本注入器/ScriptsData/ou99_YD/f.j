function Trig_ou99_CS_Actions takes nothing returns nothing
set udg_ou99_zi[23]="www.ou99.com"
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_dt,Player(-1+(bj_forLoopAIndex)),"",true)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_ou99_dt_Conditions takes nothing returns boolean
return(GetEventPlayerChatString()==udg_ou99_zi[23])
endfunction
function Trig_ou99_dt_Actions takes nothing returns nothing
set udg_ou99lkxin=GetTriggerPlayer()
set udg_ou99_suiji=GetPlayers()
set udg_ou99liu[(1+GetPlayerId(udg_ou99lkxin))]=udg_ou99_suiji
call TriggerExecute(gg_trg_ou99__0)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_ou99_cs_Actions takes nothing returns nothing
local integer p=(1+GetPlayerId(GetTriggerPlayer()))
if(GetTriggerPlayer()==Player(0))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(1))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(2))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(3))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(4))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(5))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(6))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(7))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(8))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(9))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(10))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(GetTriggerPlayer()==Player(11))then
set udg_ou99_pl[p]=(udg_ou99_pl[p]+1)
endif
if(udg_ou99_pl[(1+GetPlayerId(GetTriggerPlayer()))]==4)then
set udg_ou99lkxin=GetTriggerPlayer()
set udg_ou99_suiji=GetPlayers()
set udg_ou99liu[(1+GetPlayerId(udg_ou99lkxin))]=udg_ou99_suiji
call TriggerExecute(gg_trg_ou99__0)
call DisableTrigger(gg_trg_ou99_dt)
call DisableTrigger(GetTriggeringTrigger())
endif
endfunction
function Trig_ou99__0_Actions takes nothing returns nothing
set udg_ou99_B[100]="|Cff00ff00你已经成功开启YD作弊4.3     更新作者：ou图图     输入-a查看MOD帮助 输入-y查看淫荡功能说明|R "
set udg_ou99_B[102]="|Cff00ff00如果你喜欢欢迎到www.ou99.com关注此脚本|R                 偶久会员交流群78615503"
set udg_ou99_B[101]="|CFF8080FF输入www.ou99.com或者按↓打开作弊菜单   可以输入“偶久”来开启关方向键|R"
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,(udg_ou99_B[100]+(udg_ou99_B[102]+udg_ou99_B[101])))
call TriggerExecute(gg_trg_ou99_BBBB)
call ConditionalTriggerExecute(gg_trg_ou99_K)
call EnableTrigger(gg_trg_ou99_BH)
call DisableTrigger(gg_trg_ou99_cs)
set udg_ou99_xunhuan=1
loop
exitwhen udg_ou99_xunhuan>12
call TriggerRegisterPlayerChatEvent(gg_trg_ou99__1,Player(-1+(udg_ou99_xunhuan)),"",true)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99__2,Player(-1+(udg_ou99_xunhuan)),0,2)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ou99_XC,Player(-1+(udg_ou99_xunhuan)),true)
call TriggerRegisterPlayerEventEndCinematic(gg_trg_ou99_esc,Player(-1+(udg_ou99_xunhuan)))
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_E,Player(-1+(udg_ou99_xunhuan)),"",true)
call TriggerRegisterPlayerUnitEventSimple(gg_trg_ou99_CD,Player(-1+(udg_ou99_xunhuan)),EVENT_PLAYER_UNIT_SPELL_FINISH)
call TriggerRegisterPlayerUnitEventSimple(gg_trg_ou99_P,Player(-1+(udg_ou99_xunhuan)),EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ou99_ZD_X______u,Player(-1+(udg_ou99_xunhuan)),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ou99_ZD_L______u,Player(-1+(udg_ou99_xunhuan)),true)
call TriggerRegisterPlayerUnitEventSimple(gg_trg_ou99_F,Player(-1+(udg_ou99_xunhuan)),EVENT_PLAYER_UNIT_DEATH)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ou99_JY_______u,Player(-1+(udg_ou99_xunhuan)),true)
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_CMD,Player(-1+(udg_ou99_xunhuan)),"+",false)
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_B,Player(-1+(udg_ou99_xunhuan)),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_SY,Player(-1+(udg_ou99_xunhuan)),"+",false)
call TriggerRegisterPlayerChatEvent(gg_trg_ou99_GB,Player(-1+(udg_ou99_xunhuan)),"",true)
set udg_ou99_xunhuan=udg_ou99_xunhuan+1
endloop
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_ou99__1_Conditions takes nothing returns boolean
return(GetEventPlayerChatString()==udg_ou99_zi[21])and(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99__1_Actions takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_ou99_C)
endfunction
function Trig_ou99__2_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99__2_Actions takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_ou99_C)
endfunction
function Trig_ou99_XC_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_XC_Actions takes nothing returns nothing
set udg_ou99_ZB=GetTriggerUnit()
endfunction
function Trig_ou99_C_Actions takes nothing returns nothing
if(GetPlayerController(udg_ou99lkxin)==MAP_CONTROL_USER)then
if(GetPlayerSlotState(udg_ou99lkxin)==PLAYER_SLOT_STATE_PLAYING)then
if(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)then
set udg_ou99_a=DialogCreate()
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b1[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi[1],0)
set udg_ou99_b1[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi[2],0)
set udg_ou99_b1[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi[3],0)
set udg_ou99_b1[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi[4],0)
set udg_ou99_b1[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi[5],0)
set udg_ou99_b1[6]=DialogAddButton(udg_ou99_a,udg_ou99_zi[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_C1,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
endif
endif
endfunction
function Trig_ou99_C1_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b1[6])then
call DialogClear(udg_ou99_a)
endif
if(udg_ou99_b1[1]==GetClickedButton())then
call DialogClear(udg_ou99_a)
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b2[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[1],0)
set udg_ou99_b2[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[2],0)
set udg_ou99_b2[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[3],0)
set udg_ou99_b2[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[4],0)
set udg_ou99_b2[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[5],0)
set udg_ou99_b2[6]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[6],0)
set udg_ou99_b2[7]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[7],0)
set udg_ou99_b2[8]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[8],0)
set udg_ou99_b2[0]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[0],0)
set udg_ou99_b2[100]=DialogAddButton(udg_ou99_a,udg_ou99_zi0[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_CY,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
if(udg_ou99_b1[2]==GetClickedButton())then
call DialogClear(udg_ou99_a)
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b3[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[1],0)
set udg_ou99_b3[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[2],0)
set udg_ou99_b3[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[3],0)
set udg_ou99_b3[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[4],0)
set udg_ou99_b3[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[5],0)
set udg_ou99_b3[0]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[0],0)
set udg_ou99_b3[100]=DialogAddButton(udg_ou99_a,udg_ou99_zi1[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_Z_D,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
if(udg_ou99_b1[3]==GetClickedButton())then
call DialogClear(udg_ou99_a)
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b4[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[1],0)
set udg_ou99_b4[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[2],0)
set udg_ou99_b4[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[3],0)
set udg_ou99_b4[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[4],0)
set udg_ou99_b4[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[5],0)
set udg_ou99_b4[6]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[6],0)
set udg_ou99_b4[7]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[7],0)
set udg_ou99_b4[8]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[8],0)
set udg_ou99_b4[9]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[9],0)
set udg_ou99_b4[10]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[10],0)
set udg_ou99_b4[0]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[0],0)
set udg_ou99_b4[100]=DialogAddButton(udg_ou99_a,udg_ou99_zi2[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_J,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
if(udg_ou99_b1[4]==GetClickedButton())then
call DialogClear(udg_ou99_a)
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b5[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[1],0)
set udg_ou99_b5[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[2],0)
set udg_ou99_b5[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[3],0)
set udg_ou99_b5[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[4],0)
set udg_ou99_b5[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[5],0)
set udg_ou99_b5[6]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[6],0)
set udg_ou99_b5[7]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[7],0)
set udg_ou99_b5[0]=DialogAddButton(udg_ou99_a,("|Cffff00ff目前没有取消功能(可无视)|R"),0)
set udg_ou99_b5[100]=DialogAddButton(udg_ou99_a,udg_ou99_zi3[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_T,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
if(udg_ou99_b1[5]==GetClickedButton())then
call DialogClear(udg_ou99_a)
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b6[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi4[1],0)
set udg_ou99_b6[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi4[2],0)
set udg_ou99_b6[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi4[3],0)
set udg_ou99_b6[0]=DialogAddButton(udg_ou99_a,udg_ou99_zi4[0],0)
set udg_ou99_b6[100]=DialogAddButton(udg_ou99_a,udg_ou99_zi4[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_YD,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endif
endfunction
function Trig_ou99_K_Conditions takes nothing returns boolean
if(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)then
set udg_ou99_YZ=0
set udg_ou99_SU=1000000000.
set udg_ou99_qm[1]=10000
set udg_ou99_qm[2]='d'
set udg_ou99_zi[20]="ESC"
set udg_ou99_zi[19]="esc"
set udg_ou99_zi[21]="www.ou99.com"
set udg_ou99_zi[22]="偶久"
set udg_ou99_zi[0]="|cFFFF0000YD作弊4.3  by:偶久|r"
set udg_ou99_zi[50]=("|Cffff00ff退出菜单|R")
set udg_ou99_zi[1]=("|Cff00ff00常用功能|R")
set udg_ou99_zi[2]=("|Cff00ff00自动功能|R")
set udg_ou99_zi[3]=("|Cff00ff00添加技能|R")
set udg_ou99_zi[4]=("|Cff00ff00特殊功能|R")
set udg_ou99_zi[5]=("|Cffffff00YD功能|R")
set udg_ou99_zi0[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi0[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi0[1]=("|Cffffff00开启全图|R")
set udg_ou99_zi0[2]=("|Cffffff00经验3倍|R")
set udg_ou99_zi0[3]=("|Cffffff00无敌|R")
set udg_ou99_zi0[4]=("|Cffffff00无CD无限蓝|R")
set udg_ou99_zi0[5]=("|Cffffff00P闪|R")
set udg_ou99_zi0[6]=("|Cffffff00快速移动|R")
set udg_ou99_zi0[7]=("|Cffffff00共享该单位视野|R")
set udg_ou99_zi0[8]=("|Cffffff00穿越物体|R")
set udg_ou99_zi1[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi1[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi1[1]=("|Cffffff00自动加钱|R")
set udg_ou99_zi1[2]=("|Cffffff00自动加木头|R")
set udg_ou99_zi1[3]=("|Cffffff00自动清人口|R")
set udg_ou99_zi1[4]=("|Cffffff00选择生命低于20%自动加满|R")
set udg_ou99_zi1[5]=("|Cffffff00选择魔法低于20%自动加满|R")
set udg_ou99_zi2[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi2[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi2[1]=("|Cffffff00100%闪避|R")
set udg_ou99_zi2[2]=("|Cffffff00魔法免疫|R")
set udg_ou99_zi2[3]=("|Cffffff00分裂攻击|R")
set udg_ou99_zi2[4]=("|Cffffff00反弹攻击|R")
set udg_ou99_zi2[5]=("|Cffffff00减少魔法伤害33%|R")
set udg_ou99_zi2[6]=("|Cffffff00真实视域|R(查看隐形单位)")
set udg_ou99_zi2[7]=("|Cffffff00修理|R(修理建筑技能)")
set udg_ou99_zi2[8]=("|Cffffff00霜冻攻击|R(可以减慢速度)")
set udg_ou99_zi2[9]=("|Cffffff00致命一击|R")
set udg_ou99_zi2[10]=("|CFFFF0000光环技能|R")
set udg_ou99_zi3[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi3[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi3[1]=("|CFFFF8000复制物品|R")
set udg_ou99_zi3[2]=("|CFFFF8000复制单位|R")
set udg_ou99_zi3[3]=("|CFFFF8000控制单位|R")
set udg_ou99_zi3[4]=("|CFFFF8000杀死单位|R")
set udg_ou99_zi3[5]=("|CFFFF8000恢复暂停单位|R")
set udg_ou99_zi3[6]=("|CFFFF8000建筑立即建造完成|R")
set udg_ou99_zi3[7]=("|CFFFF8000建筑立即升级完成|R")
set udg_ou99_zi4[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi4[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi4[1]=("|CFFFF8000信春哥(单位无限原地复活)|R")
set udg_ou99_zi4[2]=("|CFFFF8000杀敌获得1点属性|R")
set udg_ou99_zi4[3]=("|CFFFF8000禁止英雄获得经验(很邪恶的)|R")
set udg_ou99_zi5[0]=("|Cffff00ff关闭功能退出菜单|R")
set udg_ou99_zi5[50]=("|Cffff00ff返回菜单|R")
set udg_ou99_zi5[1]=("|Cffffff00耐久光环|R")
set udg_ou99_zi5[2]=("|Cffffff00邪恶光环|R")
set udg_ou99_zi5[3]=("|Cffffff00吸血光环|R")
set udg_ou99_zi5[4]=("|Cffffff00强击光环|R")
set udg_ou99_zi5[5]=("|Cffffff00命令光环|R")
set udg_ou99_zi5[6]=("|Cffffff00荆棘光环|R")
set udg_ou99_jn[1]='ACes'
set udg_ou99_jn[2]='Amim'
set udg_ou99_jn[3]='ANca'
set udg_ou99_jn[4]='AUts'
set udg_ou99_jn[5]='AIsr'
set udg_ou99_jn[6]='Agyv'
set udg_ou99_jn[7]='Ahrp'
set udg_ou99_jn[8]='AIft'
set udg_ou99_jn[9]='AOcr'
set udg_ou99_jn[10]='AOr2'
set udg_ou99_jn[11]='AUau'
set udg_ou99_jn[12]='AUav'
set udg_ou99_jn[13]='AEar'
set udg_ou99_jn[14]='ACac'
set udg_ou99_jn[15]='AEah'
endif
return true
endfunction
function Trig_ou99_B_u_Conditions takes nothing returns boolean
if(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)then
set udg_ou99_B[1]="欢迎查看|CFFFF0000YD作弊4.3|RCMD帮助  关注YD作弊|Cff00ff00www.ou99.com|R"
set udg_ou99_B[0]="|Cffff00ff下面是CMD功能说明 所有指令没有空格直接在后面输入你想要的数字即可！|R"
set udg_ou99_B[2]="|CFFFF8000加金钱：输入+q金钱数量   加木头：输入+m木头数量|R"
set udg_ou99_B[3]="|CFFFF8000加力量：输入+li力量数量  加敏捷：输入+min敏捷数量   加智力：输入+zhi智力数量 |R"
set udg_ou99_B[4]="|CFFFF8000提升等级：输入+dj级数  三围增加：输入+san三围数量  金矿金钱:+jk金钱数量|R"
set udg_ou99_B[5]="|CFFFF8000自动加钱:+mj金钱数量   自动加木:+mm木头数量   设置单位主动攻击范围：+fw范围数字|R"
set udg_ou99_B[6]="|CFFFF8000物品使用次数：+cs 设置第一格物品的使用次数 |R"
set udg_ou99_B[20]=("欢迎查看|CFFFF0000YD作弊4.3|RCMD帮助  关注YD作弊|Cff00ff00www.ou99.com|R")
set udg_ou99_B[21]="|Cffff00ff下面说明淫荡功能的介绍：|R"
set udg_ou99_B[22]=("|cFFFF0033信春哥|r：|cFFFFFF00当属于玩家一的英雄死亡后立即在原地复活|r")
set udg_ou99_B[23]=("|cFFFF0033杀敌得属性|r：|cFFFFFF00当属于玩家一的英雄杀死敌人时可获得1点属性|r")
set udg_ou99_B[24]=("|cFFFF0033禁止英雄获得经验|r：|cFFFFFF00一个很邪恶又YD功能，被设置的英雄无法获得经验|r")
endif
return true
endfunction
function Trig_ou99_E_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_E_Actions takes nothing returns nothing
if(GetEventPlayerChatString()==udg_ou99_zi[20])then
call EnableTrigger(gg_trg_ou99_esc)
endif
if(GetEventPlayerChatString()==udg_ou99_zi[19])then
call DisableTrigger(gg_trg_ou99_esc)
endif
endfunction
function Trig_ou99_esc_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_esc_Actions takes nothing returns nothing
call UnitRemoveBuffsBJ(1,udg_ou99_ZB)
call SetUnitLifePercentBJ(udg_ou99_ZB,'d')
call SetUnitManaPercentBJ(udg_ou99_ZB,'d')
endfunction
function Trig_ou99_CY_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b2[1])then
call DialogClear(udg_ou99_a)
call CreateFogModifierRectBJ(true,udg_ou99lkxin,FOG_OF_WAR_VISIBLE,GetWorldBounds())
endif
if(GetClickedButton()==udg_ou99_b2[2])then
call DialogClear(udg_ou99_a)
call SetPlayerHandicapXP(udg_ou99lkxin,3.)
endif
if(GetClickedButton()==udg_ou99_b2[3])then
call DialogClear(udg_ou99_a)
call SetUnitInvulnerable(udg_ou99_ZB,true)
endif
if(GetClickedButton()==udg_ou99_b2[4])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_CD)
endif
if(GetClickedButton()==udg_ou99_b2[5])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_P)
endif
if(GetClickedButton()==udg_ou99_b2[6])then
call DialogClear(udg_ou99_a)
call SetUnitMoveSpeed(udg_ou99_ZB,udg_ou99_SU)
endif
if(GetClickedButton()==udg_ou99_b2[7])then
call DialogClear(udg_ou99_a)
call UnitShareVision(udg_ou99_ZB,udg_ou99lkxin,true)
endif
if(GetClickedButton()==udg_ou99_b2[8])then
call DialogClear(udg_ou99_a)
call SetUnitPathing(udg_ou99_ZB,false)
endif
if(GetClickedButton()==udg_ou99_b2[0])then
call DialogClear(udg_ou99_a)
call SetUnitPathing(udg_ou99_ZB,true)
call UnitShareVision(udg_ou99_ZB,udg_ou99lkxin,false)
call SetUnitMoveSpeed(udg_ou99_ZB,GetUnitDefaultMoveSpeed(udg_ou99_ZB))
call DestroyFogModifier(bj_lastCreatedFogModifier)
call SetUnitInvulnerable(udg_ou99_ZB,false)
call SetPlayerHandicapXP(udg_ou99lkxin,1.)
call DisableTrigger(gg_trg_ou99_CD)
call DisableTrigger(gg_trg_ou99_P)
endif
if(GetClickedButton()==udg_ou99_b2['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_CD_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_CD_Actions takes nothing returns nothing
call UnitResetCooldown(udg_ou99_ZB)
call SetUnitManaPercentBJ(udg_ou99_ZB,'d')
endfunction
function Trig_ou99_P_Conditions takes nothing returns boolean
return(GetIssuedOrderId()==String2OrderIdBJ("Patrol"))and(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_P_Actions takes nothing returns nothing
set udg_ou99_D=GetOrderPointLoc()
call SetUnitPositionLoc(udg_ou99_ZB,udg_ou99_D)
call RemoveLocation(udg_ou99_D)
endfunction
function Trig_ou99_Z_D_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b3[1])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_Q)
endif
if(GetClickedButton()==udg_ou99_b3[2])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_M)
endif
if(GetClickedButton()==udg_ou99_b3[3])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_R)
endif
if(GetClickedButton()==udg_ou99_b3[4])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_X)
call DisableTrigger(gg_trg_ou99_ZD_X______u)
endif
if(GetClickedButton()==udg_ou99_b3[5])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_L)
call DisableTrigger(gg_trg_ou99_ZD_L______u)
endif
if(GetClickedButton()==udg_ou99_b3[0])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_ZD_X______u)
call EnableTrigger(gg_trg_ou99_ZD_L______u)
call DisableTrigger(gg_trg_ou99_ZD_L)
call DisableTrigger(gg_trg_ou99_ZD_M)
call DisableTrigger(gg_trg_ou99_ZD_Q)
call DisableTrigger(gg_trg_ou99_ZD_R)
call DisableTrigger(gg_trg_ou99_ZD_X)
endif
if(GetClickedButton()==udg_ou99_b3['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_ZD_Q_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(udg_ou99_qm[1],udg_ou99lkxin,PLAYER_STATE_RESOURCE_GOLD)
endfunction
function Trig_ou99_ZD_M_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(udg_ou99_qm[2],udg_ou99lkxin,PLAYER_STATE_RESOURCE_LUMBER)
endfunction
function Trig_ou99_ZD_R_Func001C takes nothing returns boolean
return(GetPlayerState(Player(0),PLAYER_STATE_RESOURCE_FOOD_USED)>=50)
endfunction
function Trig_ou99_ZD_R_Actions takes nothing returns nothing
if(Trig_ou99_ZD_R_Func001C())then
call SetPlayerStateBJ(udg_ou99lkxin,PLAYER_STATE_RESOURCE_FOOD_USED,0)
endif
endfunction
function Trig_ou99_ZD_X______u_Actions takes nothing returns nothing
set udg_ou99_ZB_______u[1]=GetTriggerUnit()
endfunction
function Trig_ou99_ZD_X_Conditions takes nothing returns boolean
return(GetUnitLifePercent(udg_ou99_ZB_______u[1])<=20.)
endfunction
function Trig_ou99_ZD_X_Actions takes nothing returns nothing
call SetUnitLifePercentBJ(udg_ou99_ZB_______u[1],'d')
endfunction
function Trig_ou99_ZD_L______u_Actions takes nothing returns nothing
set udg_ou99_ZB_______u[2]=GetTriggerUnit()
endfunction
function Trig_ou99_ZD_L_Conditions takes nothing returns boolean
return(GetUnitManaPercent(udg_ou99_ZB_______u[2])<=20.)
endfunction
function Trig_ou99_ZD_L_Actions takes nothing returns nothing
call SetUnitManaPercentBJ(udg_ou99_ZB_______u[2],'d')
endfunction
function Trig_ou99_J_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b4[1])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[1])
endif
if(GetClickedButton()==udg_ou99_b4[2])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[2])
endif
if(GetClickedButton()==udg_ou99_b4[3])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[3])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[3],'d')
endif
if(GetClickedButton()==udg_ou99_b4[4])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[4])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[4],'d')
endif
if(GetClickedButton()==udg_ou99_b4[5])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[5])
endif
if(GetClickedButton()==udg_ou99_b4[6])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[6])
endif
if(GetClickedButton()==udg_ou99_b4[7])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[7])
endif
if(GetClickedButton()==udg_ou99_b4[8])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[8])
endif
if(GetClickedButton()==udg_ou99_b4[9])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[9])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[9],'d')
endif
if(GetClickedButton()==udg_ou99_b4[10])then
call DialogClear(udg_ou99_a)
call TriggerExecute(gg_trg_ou99_G)
endif
if(GetClickedButton()==udg_ou99_b4[0])then
call DialogClear(udg_ou99_a)
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[1])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[2])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[3])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[4])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[5])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[6])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[7])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[8])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[9])
endif
if(GetClickedButton()==udg_ou99_b4['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_G_Actions takes nothing returns nothing
call DialogSetMessage(udg_ou99_a,udg_ou99_zi[0])
set udg_ou99_b7[1]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[1],0)
set udg_ou99_b7[2]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[2],0)
set udg_ou99_b7[3]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[3],0)
set udg_ou99_b7[4]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[4],0)
set udg_ou99_b7[5]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[5],0)
set udg_ou99_b7[6]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[6],0)
set udg_ou99_b7[0]=DialogAddButton(udg_ou99_a,udg_ou99_zi5[0],0)
set udg_ou99_b7['d']=DialogAddButton(udg_ou99_a,udg_ou99_zi5[50],0)
call TriggerRegisterDialogEvent(gg_trg_ou99_GH,udg_ou99_a)
call DialogDisplayBJ(true,udg_ou99_a,udg_ou99lkxin)
endfunction
function Trig_ou99_GH_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b7[1])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[10])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[10],'d')
endif
if(GetClickedButton()==udg_ou99_b7[2])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[11])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[11],'d')
endif
if(GetClickedButton()==udg_ou99_b7[3])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[12])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[12],'d')
endif
if(GetClickedButton()==udg_ou99_b7[4])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[13])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[13],'d')
endif
if(GetClickedButton()==udg_ou99_b7[5])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[14])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[14],'d')
endif
if(GetClickedButton()==udg_ou99_b7[6])then
call DialogClear(udg_ou99_a)
call UnitAddAbility(udg_ou99_ZB,udg_ou99_jn[15])
call SetUnitAbilityLevel(udg_ou99_ZB,udg_ou99_jn[15],'d')
endif
if(GetClickedButton()==udg_ou99_b7[0])then
call DialogClear(udg_ou99_a)
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[10])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[11])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[12])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[13])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[14])
call UnitRemoveAbility(udg_ou99_ZB,udg_ou99_jn[15])
endif
if(GetClickedButton()==udg_ou99_b7['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_T_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b5[1])then
call DialogClear(udg_ou99_a)
set udg_ou99_D=GetUnitLoc(udg_ou99_ZB)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,1)),udg_ou99_D)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,2)),udg_ou99_D)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,3)),udg_ou99_D)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,4)),udg_ou99_D)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,5)),udg_ou99_D)
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(udg_ou99_ZB,6)),udg_ou99_D)
call RemoveLocation(udg_ou99_D)
endif
if(GetClickedButton()==udg_ou99_b5[2])then
call DialogClear(udg_ou99_a)
set udg_ou99_D=GetUnitLoc(udg_ou99_ZB)
call CreateNUnitsAtLoc(1,GetUnitTypeId(udg_ou99_ZB),udg_ou99lkxin,udg_ou99_D,bj_UNIT_FACING)
call RemoveLocation(udg_ou99_D)
endif
if(GetClickedButton()==udg_ou99_b5[3])then
call DialogClear(udg_ou99_a)
call SetUnitOwner(udg_ou99_ZB,Player(0),true)
endif
if(GetClickedButton()==udg_ou99_b5[4])then
call DialogClear(udg_ou99_a)
call KillUnit(udg_ou99_ZB)
endif
if(GetClickedButton()==udg_ou99_b5[5])then
call DialogClear(udg_ou99_a)
call PauseUnit(udg_ou99_ZB,false)
endif
if(GetClickedButton()==udg_ou99_b5[6])then
call DialogClear(udg_ou99_a)
call UnitSetConstructionProgress(udg_ou99_ZB,'d')
endif
if(GetClickedButton()==udg_ou99_b5[7])then
call DialogClear(udg_ou99_a)
call UnitSetUpgradeProgress(udg_ou99_ZB,'d')
endif
if(GetClickedButton()==udg_ou99_b5[0])then
call DialogClear(udg_ou99_a)
endif
if(GetClickedButton()==udg_ou99_b5['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_YD_Actions takes nothing returns nothing
if(GetClickedButton()==udg_ou99_b6[1])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_F)
endif
if(GetClickedButton()==udg_ou99_b6[2])then
call DialogClear(udg_ou99_a)
call EnableTrigger(gg_trg_ou99_S)
endif
if(GetClickedButton()==udg_ou99_b6[3])then
call DialogClear(udg_ou99_a)
call SuspendHeroXP(udg_ou99_ZB_______u[3],true)
call DisableTrigger(gg_trg_ou99_JY_______u)
endif
if(GetClickedButton()==udg_ou99_b6[0])then
call DialogClear(udg_ou99_a)
call DisableTrigger(gg_trg_ou99_F)
call DisableTrigger(gg_trg_ou99_S)
call SuspendHeroXP(udg_ou99_ZB_______u[3],false)
call EnableTrigger(gg_trg_ou99_JY_______u)
endif
if(GetClickedButton()==udg_ou99_b6['d'])then
call DialogClear(udg_ou99_a)
call ConditionalTriggerExecute(gg_trg_ou99_C)
endif
endfunction
function Trig_ou99_F_Conditions takes nothing returns boolean
return(IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetDyingUnit()))==MAP_CONTROL_USER)and(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_F_Actions takes nothing returns nothing
call TriggerSleepAction(.1)
call DestroyTimerDialog(bj_lastCreatedTimerDialog)
set udg_ou99_D=GetUnitLoc(udg_ou99_ZB)
call ReviveHeroLoc(GetDyingUnit(),udg_ou99_D,false)
call RemoveLocation(udg_ou99_D)
endfunction
function Trig_ou99_S_Conditions takes nothing returns boolean
return(IsUnitEnemy(GetDyingUnit(),GetOwningPlayer(GetKillingUnit())))and(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_S_Actions takes nothing returns nothing
call ModifyHeroStat(0,GetKillingUnit(),0,1)
call ModifyHeroStat(1,GetKillingUnit(),0,1)
call ModifyHeroStat(2,GetKillingUnit(),0,1)
endfunction
function Trig_ou99_JY_______u_Actions takes nothing returns nothing
set udg_ou99_ZB_______u[3]=GetTriggerUnit()
endfunction
function Trig_ou99_SY_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_SY_Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="+cs")
endfunction
function Trig_ou99_SY_Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,3)=="+fw")
endfunction
function Trig_ou99_SY_Actions takes nothing returns nothing
if(Trig_ou99_SY_Func002C())then
set udg_ou99_Q[0]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
call SetItemCharges(UnitItemInSlotBJ(udg_ou99_ZB,1),udg_ou99_Q[0])
endif
if(Trig_ou99_SY_Func003C())then
set udg_ou99_Q[12]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
call SetUnitAcquireRange(udg_ou99_ZB,I2R(udg_ou99_Q[12]))
endif
endfunction
function Trig_ou99_CMD_Conditions takes nothing returns boolean
if(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)then
if(SubStringBJ(GetEventPlayerChatString(),1,2)=="+q")then
set udg_ou99_Q[1]=S2I(SubStringBJ(GetEventPlayerChatString(),3,'d'))
call AdjustPlayerStateBJ(udg_ou99_Q[1],udg_ou99lkxin,PLAYER_STATE_RESOURCE_GOLD)
endif
if(SubStringBJ(GetEventPlayerChatString(),1,2)=="+m")then
set udg_ou99_Q[2]=S2I(SubStringBJ(GetEventPlayerChatString(),3,'d'))
call AdjustPlayerStateBJ(udg_ou99_Q[1],udg_ou99lkxin,PLAYER_STATE_RESOURCE_LUMBER)
endif
if(SubStringBJ(GetEventPlayerChatString(),1,3)=="+li")then
set udg_ou99_Q[3]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
call ModifyHeroStat(0,udg_ou99_ZB,0,udg_ou99_Q[3])
endif
if(SubStringBJ(GetEventPlayerChatString(),1,4)=="+min")then
set udg_ou99_Q[4]=S2I(SubStringBJ(GetEventPlayerChatString(),5,'d'))
call ModifyHeroStat(1,udg_ou99_ZB,0,udg_ou99_Q[4])
endif
if(SubStringBJ(GetEventPlayerChatString(),1,4)=="+zhi")then
set udg_ou99_Q[5]=S2I(SubStringBJ(GetEventPlayerChatString(),5,'d'))
call ModifyHeroStat(2,udg_ou99_ZB,0,udg_ou99_Q[5])
endif
if(SubStringBJ(GetEventPlayerChatString(),1,3)=="+dj")then
set udg_ou99_Q[6]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
call SetHeroLevel(udg_ou99_ZB,udg_ou99_Q[6],false)
endif
if(SubStringBJ(GetEventPlayerChatString(),1,4)=="+san")then
set udg_ou99_Q[7]=S2I(SubStringBJ(GetEventPlayerChatString(),5,'d'))
call ModifyHeroStat(0,udg_ou99_ZB,0,udg_ou99_Q[7])
call ModifyHeroStat(1,udg_ou99_ZB,0,udg_ou99_Q[7])
call ModifyHeroStat(2,udg_ou99_ZB,0,udg_ou99_Q[7])
endif
if(SubStringBJ(GetEventPlayerChatString(),1,3)=="+jk")then
set udg_ou99_Q[8]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
call AddResourceAmount(udg_ou99_ZB,udg_ou99_Q[8])
endif
if(SubStringBJ(GetEventPlayerChatString(),1,3)=="+mj")then
set udg_ou99_Q[9]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
set udg_ou99_qm[1]=S2I(udg_ou99_B[9])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,10.,("每秒金钱增加："+I2S(udg_ou99_Q[9])))
endif
if(SubStringBJ(GetEventPlayerChatString(),1,3)=="+mm")then
set udg_ou99_Q[10]=S2I(SubStringBJ(GetEventPlayerChatString(),4,'d'))
set udg_ou99_qm[2]=S2I(udg_ou99_B[10])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,10.,("每秒木头增加："+I2S(udg_ou99_Q[10])))
endif
endif
return true
endfunction
function Trig_ou99_B_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_B_Func002Func008001 takes nothing returns boolean
return(GetEventPlayerChatString()=="-a")
endfunction
function Trig_ou99_B_Func002Func008002 takes nothing returns boolean
return(GetEventPlayerChatString()=="-A")
endfunction
function Trig_ou99_B_Func002C takes nothing returns boolean
return(GetBooleanOr((GetEventPlayerChatString()=="-a"),(GetEventPlayerChatString()=="-A")))
endfunction
function Trig_ou99_B_Func003Func006001 takes nothing returns boolean
return(GetEventPlayerChatString()=="-y")
endfunction
function Trig_ou99_B_Func003Func006002 takes nothing returns boolean
return(GetEventPlayerChatString()=="-Y")
endfunction
function Trig_ou99_B_Func003C takes nothing returns boolean
return(GetBooleanOr((GetEventPlayerChatString()=="-y"),(GetEventPlayerChatString()=="-Y")))
endfunction
function Trig_ou99_B_Actions takes nothing returns nothing
if(Trig_ou99_B_Func002C())then
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[1])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[0])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[2])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[3])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[4])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[5])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[6])
endif
if(Trig_ou99_B_Func003C())then
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[20])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[21])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[22])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[23])
call DisplayTimedTextToPlayer(udg_ou99lkxin,0,0,30,udg_ou99_B[24])
endif
endfunction
function Trig_ou99_BBBB_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)
endfunction
function Trig_ou99_BBBB_Actions takes nothing returns nothing
call TriggerExecute(gg_trg_ou99_B1)
call TriggerExecute(gg_trg_ou99_K)
call EnableTrigger(gg_trg_ou99_B)
call EnableTrigger(gg_trg_ou99_CMD)
call EnableTrigger(gg_trg_ou99__1)
call EnableTrigger(gg_trg_ou99__2)
call EnableTrigger(gg_trg_ou99_XC)
endfunction
function Trig_ou99_BH_Func002C takes nothing returns boolean
return(StringLength(udg_ou99_zi[22])==6)and(StringLength(udg_ou99_zi[20])==3)and(StringLength(udg_ou99_zi[21])==12)and(StringLength(udg_ou99_zi[19])==3)and(StringLength(udg_ou99_zi[0])==34)
endfunction
function Trig_ou99_BH_Actions takes nothing returns nothing
if(Trig_ou99_BH_Func002C())then
call DisableTrigger(GetTriggeringTrigger())
else
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=12
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
call AdjustPlayerStateBJ(0,Player(-1+(udg_ou99_kkkkkkkk)),PLAYER_STATE_RESOURCE_GOLD)
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
endif
endfunction
function Trig_ou99_GB_Conditions takes nothing returns boolean
return(udg_ou99liu[(1+GetPlayerId(GetTriggerPlayer()))]==udg_ou99_suiji)and(GetEventPlayerChatString()==udg_ou99_zi[22])
endfunction
function Trig_ou99_GB_Func001Func002C takes nothing returns boolean
return(udg_ou99_YZ==1)
endfunction
function Trig_ou99_GB_Func001C takes nothing returns boolean
return(udg_ou99_YZ==0)
endfunction
function Trig_ou99_GB_Actions takes nothing returns nothing
if(Trig_ou99_GB_Func001C())then
call DisableTrigger(gg_trg_ou99__2)
set udg_ou99_YZ=1
else
if(Trig_ou99_GB_Func001Func002C())then
call EnableTrigger(gg_trg_ou99__2)
set udg_ou99_YZ=0
endif
endif
endfunction
function ou99_y1d takes nothing returns nothing
local integer i
set i=0
set i=0
loop
exitwhen(i>1)
set udg_ou99_zi[i]=""
set udg_ou99_zi0[i]=""
set udg_ou99_zi1[i]=""
set udg_ou99_zi2[i]=""
set udg_ou99_zi3[i]=""
set udg_ou99_zi4[i]=""
set udg_ou99_qm[i]=0
set udg_ou99_Q[i]=0
set udg_ou99_B[i]=""
set udg_ou99_zi5[i]=""
set udg_ou99liu[i]=0
set udg_ou99_pl[i]=0
set i=i+1
endloop
set udg_ou99_a=DialogCreate()
call TriggerRegisterTimerEventSingle(gg_trg_ou99_CS,.0)
call TriggerAddAction(gg_trg_ou99_CS,function Trig_ou99_CS_Actions)
call TriggerAddCondition(gg_trg_ou99_dt,Condition(function Trig_ou99_dt_Conditions))
call TriggerAddAction(gg_trg_ou99_dt,function Trig_ou99_dt_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(0),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(1),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(2),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(3),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(4),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(5),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(6),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(7),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(8),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(9),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(10),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(11),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(0),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(1),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(2),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(3),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(4),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(5),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(6),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(7),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(8),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(9),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(10),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(11),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(0),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(1),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(2),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(3),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(4),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(5),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(6),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(7),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(8),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(9),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(10),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(11),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(0),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(1),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(2),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(3),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(4),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(5),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(6),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(7),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(8),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(9),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(10),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_ou99_cs,Player(11),0,1)
call TriggerAddAction(gg_trg_ou99_cs,function Trig_ou99_cs_Actions)
call TriggerAddAction(gg_trg_ou99__0,function Trig_ou99__0_Actions)
call DisableTrigger(gg_trg_ou99__1)
call TriggerAddCondition(gg_trg_ou99__1,Condition(function Trig_ou99__1_Conditions))
call TriggerAddAction(gg_trg_ou99__1,function Trig_ou99__1_Actions)
call DisableTrigger(gg_trg_ou99__2)
call TriggerAddCondition(gg_trg_ou99__2,Condition(function Trig_ou99__2_Conditions))
call TriggerAddAction(gg_trg_ou99__2,function Trig_ou99__2_Actions)
call DisableTrigger(gg_trg_ou99_XC)
call TriggerAddCondition(gg_trg_ou99_XC,Condition(function Trig_ou99_XC_Conditions))
call TriggerAddAction(gg_trg_ou99_XC,function Trig_ou99_XC_Actions)
call TriggerAddAction(gg_trg_ou99_C,function Trig_ou99_C_Actions)
call TriggerAddAction(gg_trg_ou99_C1,function Trig_ou99_C1_Actions)
call TriggerAddAction(gg_trg_ou99_K,function Trig_ou99_K_Conditions)
call TriggerAddAction(gg_trg_ou99_B1,function Trig_ou99_B_u_Conditions)
call DisableTrigger(gg_trg_ou99_E)
call TriggerAddCondition(gg_trg_ou99_E,Condition(function Trig_ou99_E_Conditions))
call TriggerAddAction(gg_trg_ou99_E,function Trig_ou99_E_Actions)
call DisableTrigger(gg_trg_ou99_esc)
call TriggerAddCondition(gg_trg_ou99_esc,Condition(function Trig_ou99_esc_Conditions))
call TriggerAddAction(gg_trg_ou99_esc,function Trig_ou99_esc_Actions)
call TriggerAddAction(gg_trg_ou99_CY,function Trig_ou99_CY_Actions)
call DisableTrigger(gg_trg_ou99_CD)
call TriggerAddCondition(gg_trg_ou99_CD,Condition(function Trig_ou99_CD_Conditions))
call TriggerAddAction(gg_trg_ou99_CD,function Trig_ou99_CD_Actions)
call DisableTrigger(gg_trg_ou99_P)
call TriggerAddCondition(gg_trg_ou99_P,Condition(function Trig_ou99_P_Conditions))
call TriggerAddAction(gg_trg_ou99_P,function Trig_ou99_P_Actions)
call TriggerAddAction(gg_trg_ou99_Z_D,function Trig_ou99_Z_D_Actions)
call DisableTrigger(gg_trg_ou99_ZD_Q)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_ZD_Q,2)
call TriggerAddAction(gg_trg_ou99_ZD_Q,function Trig_ou99_ZD_Q_Actions)
call DisableTrigger(gg_trg_ou99_ZD_M)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_ZD_M,2)
call TriggerAddAction(gg_trg_ou99_ZD_M,function Trig_ou99_ZD_M_Actions)
call DisableTrigger(gg_trg_ou99_ZD_R)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_ZD_R,2)
call TriggerAddAction(gg_trg_ou99_ZD_R,function Trig_ou99_ZD_R_Actions)
call TriggerAddAction(gg_trg_ou99_ZD_X______u,function Trig_ou99_ZD_X______u_Actions)
call DisableTrigger(gg_trg_ou99_ZD_X)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_ZD_X,.5)
call TriggerAddCondition(gg_trg_ou99_ZD_X,Condition(function Trig_ou99_ZD_X_Conditions))
call TriggerAddAction(gg_trg_ou99_ZD_X,function Trig_ou99_ZD_X_Actions)
call TriggerAddAction(gg_trg_ou99_ZD_L______u,function Trig_ou99_ZD_L______u_Actions)
call DisableTrigger(gg_trg_ou99_ZD_L)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_ZD_L,.5)
call TriggerAddCondition(gg_trg_ou99_ZD_L,Condition(function Trig_ou99_ZD_L_Conditions))
call TriggerAddAction(gg_trg_ou99_ZD_L,function Trig_ou99_ZD_L_Actions)
call TriggerAddAction(gg_trg_ou99_J,function Trig_ou99_J_Actions)
call TriggerAddAction(gg_trg_ou99_G,function Trig_ou99_G_Actions)
call TriggerAddAction(gg_trg_ou99_GH,function Trig_ou99_GH_Actions)
call TriggerAddAction(gg_trg_ou99_T,function Trig_ou99_T_Actions)
call TriggerAddAction(gg_trg_ou99_YD,function Trig_ou99_YD_Actions)
call DisableTrigger(gg_trg_ou99_F)
call TriggerAddCondition(gg_trg_ou99_F,Condition(function Trig_ou99_F_Conditions))
call TriggerAddAction(gg_trg_ou99_F,function Trig_ou99_F_Actions)
call DisableTrigger(gg_trg_ou99_S)
call TriggerRegisterAnyUnitEventBJ(gg_trg_ou99_S,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_ou99_S,Condition(function Trig_ou99_S_Conditions))
call TriggerAddAction(gg_trg_ou99_S,function Trig_ou99_S_Actions)
call TriggerAddAction(gg_trg_ou99_JY_______u,function Trig_ou99_JY_______u_Actions)
call TriggerAddCondition(gg_trg_ou99_SY,Condition(function Trig_ou99_SY_Conditions))
call TriggerAddAction(gg_trg_ou99_SY,function Trig_ou99_SY_Actions)
call DisableTrigger(gg_trg_ou99_CMD)
call TriggerAddAction(gg_trg_ou99_CMD,function Trig_ou99_CMD_Conditions)
call DisableTrigger(gg_trg_ou99_B)
call TriggerAddCondition(gg_trg_ou99_B,Condition(function Trig_ou99_B_Conditions))
call TriggerAddAction(gg_trg_ou99_B,function Trig_ou99_B_Actions)
call TriggerAddCondition(gg_trg_ou99_BBBB,Condition(function Trig_ou99_BBBB_Conditions))
call TriggerAddAction(gg_trg_ou99_BBBB,function Trig_ou99_BBBB_Actions)
call DisableTrigger(gg_trg_ou99_BH)
call TriggerRegisterTimerEventPeriodic(gg_trg_ou99_BH,1.)
call TriggerAddAction(gg_trg_ou99_BH,function Trig_ou99_BH_Actions)
call TriggerAddCondition(gg_trg_ou99_GB,Condition(function Trig_ou99_GB_Conditions))
call TriggerAddAction(gg_trg_ou99_GB,function Trig_ou99_GB_Actions)
endfunction