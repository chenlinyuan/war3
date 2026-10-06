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
call TriggerRegisterPlayerChatEvent(t,Player(i),"qingli",true)
set i=i+1
endloop
call TriggerAddAction(t,function Fy_qwp)
endfunction
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
function Trig_xwzxwz2_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz3)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz3)
endfunction
function Trig_xwzxwz3_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz4)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz4)
endfunction
function Trig_xwzxwz4_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz5)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz5)
endfunction
function Trig_xwzxwz5_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz6)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz6)
endfunction
function Trig_xwzxwz6_Actions takes nothing returns nothing
set udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]=true
call EnableTrigger(gg_trg_xwzxwz7)
call TriggerSleepAction(2.00)
call DisableTrigger(gg_trg_xwzxwz7)
endfunction
function Trig_xwzxwz7_Conditions takes nothing returns boolean
return ((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))and((udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz7_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz29=0
set udg_xwzxwz25=true
set udg_xwzxwz24=true
set udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call PauseUnitBJ(true,GetTriggerUnit())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl")
call CreateTextTagUnitBJ("TRIGSTR_004",GetTriggerUnit(),0.00,50.00,100,60.00,100,30.00)
call RotateCameraAroundLocBJ(360.00,GetUnitLoc(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),4.70)
set udg_xwzxwz16=GetLastCreatedTextTag()
set udg_xwzxwz15=GetLastCreatedEffectBJ()
call TriggerSleepAction(5.00)
call ResetToGameCameraForPlayer(GetOwningPlayer(GetTriggerUnit()),0)
call DestroyTextTag(udg_xwzxwz16)
call DestroyEffect(udg_xwzxwz15)
call SetUnitVertexColorBJ(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],15.00,15.00,15.00,0)
call SetUnitScalePercent(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],110.00,110.00,110.00)
call PauseUnitBJ(false,udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call SetUnitInvulnerable(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call EnableTrigger(gg_trg_xwzxwz8)
call EnableTrigger(gg_trg_xwzxwz10)
call EnableTrigger(gg_trg_xwzxwz14)
call EnableTrigger(gg_trg_xwzxwz9)
call EnableTrigger(gg_trg_xwzxwz11)
call EnableTrigger(gg_trg_xwzxwz1)
endfunction
function Trig_xwzxwz8_Conditions takes nothing returns boolean
return ((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz8_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func002Func005001002003001(),Trig_xwzxwz8_Func002Func005001002003002())
endfunction
function Trig_xwzxwz8_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Units\\Demon\\Infernal\\InfernalBirth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,10.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz8_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz8_Func004Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func004Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func004Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func004Func005001002003001(),Trig_xwzxwz8_Func004Func005001002003002())
endfunction
function Trig_xwzxwz8_Func004Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*SquareRoot((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))))*GetRandomReal(10.00,20.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz8_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz8_Func006Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func006Func005001002003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003002002001(),Trig_xwzxwz8_Func006Func005001002003002002002())
endfunction
function Trig_xwzxwz8_Func006Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003002001(),Trig_xwzxwz8_Func006Func005001002003002002())
endfunction
function Trig_xwzxwz8_Func006Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003001(),Trig_xwzxwz8_Func006Func005001002003002())
endfunction
function Trig_xwzxwz8_Func006Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitOwner(GetEnumUnit(),GetOwningPlayer(GetAttacker()),true)
call SetUnitVertexColorBJ(GetEnumUnit(),0.00,0.00,0.00,50.00)
call SetUnitMoveSpeed(GetEnumUnit(),500.00)
endfunction
function Trig_xwzxwz8_Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_xwzxwz8_Func008Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_xwzxwz8_Func008Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func008Func005001002003001(),Trig_xwzxwz8_Func008Func005001002003002())
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func008Func005Func009001003001(),Trig_xwzxwz8_Func008Func005Func009001003002())
endfunction
function Trig_xwzxwz8_Func008Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005A takes nothing returns nothing
set udg_xwzxwz20=GetEnumUnit()
set udg_xwzxwz19=GetUnitLoc(udg_xwzxwz20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_xwzxwz19,Condition(function Trig_xwzxwz8_Func008Func005Func009001003)),function Trig_xwzxwz8_Func008Func005Func009A)
call RemoveUnit(udg_xwzxwz20)
call RemoveLocation(udg_xwzxwz19)
endfunction
function Trig_xwzxwz8_Func008C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_xwzxwz8_Actions takes nothing returns nothing
if (Trig_xwzxwz8_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔地狱火|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func002Func005001002003))),function Trig_xwzxwz8_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz8_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00邪恶突袭|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func004Func005001002003))),function Trig_xwzxwz8_Func004Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz8_Func006C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00黑暗召唤|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(4,GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func006Func005001002003))),function Trig_xwzxwz8_Func006Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz8_Func008C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔尸爆|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func008Func005001002003))),function Trig_xwzxwz8_Func008Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
endfunction
function Trig_xwzxwz9_Func004C takes nothing returns boolean
return ((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz9_Conditions takes nothing returns boolean
return (Trig_xwzxwz9_Func004C())
endfunction
function Trig_xwzxwz9_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
endfunction
function Trig_xwzxwz10_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz10_Func002Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz10_Func002Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_xwzxwz10_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz10_Func002Func007001003001(),Trig_xwzxwz10_Func002Func007001003002())
endfunction
function Trig_xwzxwz10_Func002Func007A takes nothing returns nothing
set udg_xwzxwz22=(udg_xwzxwz22+1)
set udg_xwzxwz21[udg_xwzxwz22]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_xwzxwz23[udg_xwzxwz22]=AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz10_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_xwzxwz24))
endfunction
function Trig_xwzxwz10_Func004Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz10_Func004Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_xwzxwz10_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz10_Func004Func007001003001(),Trig_xwzxwz10_Func004Func007001003002())
endfunction
function Trig_xwzxwz10_Func004Func007A takes nothing returns nothing
set udg_xwzxwz26=(udg_xwzxwz26+1)
set udg_xwzxwz27[udg_xwzxwz26]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_xwzxwz28[udg_xwzxwz26]=AddLightningLoc("LEAS",GetUnitLoc(GetTriggerUnit()),GetUnitLoc(GetEnumUnit()))
call UnitDamageTarget(GetTriggerUnit(),GetEnumUnit(),((I2R(GetHeroLevel(GetTriggerUnit()))*I2R(GetHeroAgi(GetTriggerUnit(),true)))*GetRandomReal(2.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz10_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_xwzxwz25))
endfunction
function Trig_xwzxwz10_Actions takes nothing returns nothing
if (Trig_xwzxwz10_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之封印|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz24=false
set udg_xwzxwz22=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz10_Func002Func007001003)),function Trig_xwzxwz10_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_xwzxwz12)
return
endif
if (Trig_xwzxwz10_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之困锁|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz25=false
set udg_xwzxwz26=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz10_Func004Func007001003)),function Trig_xwzxwz10_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(0.30)
call TriggerExecute(gg_trg_xwzxwz13)
endif
endfunction
function Trig_xwzxwz11_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz11_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
endfunction
function Trig_xwzxwz12_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz22
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz21[GetForLoopIndexA()])
call DestroyEffect(udg_xwzxwz23[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz24=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz13_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz26
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz28[GetForLoopIndexA()])
call PauseUnitBJ(false,udg_xwzxwz27[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz25=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz14_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz14_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_xwzxwz1_Conditions takes nothing returns boolean
return ((udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1_Actions takes nothing returns nothing
set udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisableTrigger(gg_trg_xwzxwz14)
call DisableTrigger(gg_trg_xwzxwz8)
call DisableTrigger(gg_trg_xwzxwz9)
call DisableTrigger(gg_trg_xwzxwz10)
call DisableTrigger(gg_trg_xwzxwz11)
call SetUnitVertexColorBJ(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00,0)
call SetUnitScalePercent(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz81_Conditions takes nothing returns boolean
return ((GetTriggerPlayer()==Player(0)))
endfunction
function Trig_xwzxwz81_Func001Func002C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 关闭"))
endfunction
function Trig_xwzxwz81_Func001C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 打开"))
endfunction
function Trig_xwzxwz81_Actions takes nothing returns nothing
if (Trig_xwzxwz81_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00打开了魔道 !!!!!!!!!!!!!|r"+" 邪恶之气已经释放。修改者：|cFFFFFF00鬼和尚|r 有什么问题请登陆 魔兽地图联盟 http://www.12349.net 一起学习研究")))
call TriggerExecute(gg_trg_xwzxwz84)
call EnableTrigger(gg_trg_xwzxwz95)
else
if (Trig_xwzxwz81_Func001Func002C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00关闭了魔道 !!!!!!!!!!!!!|r"+" 任何人无法再进入魔道。")))
call DisableTrigger(gg_trg_xwzxwz82)
endif
endif
endfunction
function Trig_xwzxwz82_Conditions takes nothing returns boolean
return ((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_xwzxwz82_Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz64==false))
endfunction
function Trig_xwzxwz82_Func001C takes nothing returns boolean
return ((udg_xwzxwz63))
endfunction
function Trig_xwzxwz82_Actions takes nothing returns nothing
if (Trig_xwzxwz82_Func001C()) then
set udg_xwzxwz59=GetTriggerPlayer()
set udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]=GetRandomInt(1,8)
call ConditionalTriggerExecute(gg_trg_xwzxwz83)
else
if (Trig_xwzxwz82_Func001Func001C()) then
set udg_xwzxwz64=true
set udg_xwzxwz59=GetTriggerPlayer()
call DialogClear(udg_xwzxwz61)
call DialogSetMessage(udg_xwzxwz61,("魔道选择"+""))
set udg_xwzxwz62[3]=DialogAddButtonBJ(udg_xwzxwz61,("冰魔"+" 智"))
set udg_xwzxwz62[4]=DialogAddButtonBJ(udg_xwzxwz61,("火魔"+" 智"))
set udg_xwzxwz62[5]=DialogAddButtonBJ(udg_xwzxwz61,("金魔"+" 力"))
set udg_xwzxwz62[6]=DialogAddButtonBJ(udg_xwzxwz61,("雷魔"+" 力"))
set udg_xwzxwz62[7]=DialogAddButtonBJ(udg_xwzxwz61,("木魔"+" 敏"))
set udg_xwzxwz62[8]=DialogAddButtonBJ(udg_xwzxwz61,("水魔"+" 敏智"))
set udg_xwzxwz62[9]=DialogAddButtonBJ(udg_xwzxwz61,("亡魔"+" 敏"))
set udg_xwzxwz62[10]=DialogAddButtonBJ(udg_xwzxwz61,("月魔"+" 敏"))
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,true)
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+" 正在选择入魔 请稍后再入魔。。。。"))
endif
endif
endfunction
function Trig_xwzxwz83_Conditions takes nothing returns boolean
return ((udg_xwzxwz58[GetConvertedPlayerId(udg_xwzxwz59)]==false))and((udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]==false))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==8))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==7))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==6))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==5))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==4))
endfunction
function Trig_xwzxwz83_Func004Func001Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==3))
endfunction
function Trig_xwzxwz83_Func004Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==2))
endfunction
function Trig_xwzxwz83_Func004C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==1))
endfunction
function Trig_xwzxwz83_Actions takes nothing returns nothing
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
if (Trig_xwzxwz83_Func004C()) then
set udg_xwzxwz32[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz39[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001C()) then
set udg_xwzxwz33[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz40[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002C()) then
set udg_xwzxwz31[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz38[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002C()) then
set udg_xwzxwz34[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz48[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001C()) then
set udg_xwzxwz35[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz47[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002C()) then
set udg_xwzxwz49[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz50[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001C()) then
set udg_xwzxwz51[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz52[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001Func001C()) then
set udg_xwzxwz100[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz56[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[2]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+" 妄图进入魔道，但因邪恶度不够，你永久不可以入魔道！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_xwzxwz84_Actions takes nothing returns nothing
call DialogClear(udg_xwzxwz60)
call DialogSetMessage(udg_xwzxwz60,("选择入魔方式"+""))
set udg_xwzxwz62[1]=DialogAddButtonBJ(udg_xwzxwz60,("随机模式"+""))
set udg_xwzxwz62[2]=DialogAddButtonBJ(udg_xwzxwz60,("选择模式"+""))
call DialogDisplay(Player(0),udg_xwzxwz60,true)
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[10]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[9]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[8]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[7]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[6]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[5]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[4]))
endfunction
function Trig_xwzxwz84Clink_Func002C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[3]))
endfunction
function Trig_xwzxwz84Clink_Actions takes nothing returns nothing
if (Trig_xwzxwz84Clink_Func002C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz32[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz39[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz33[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz40[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz31[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz38[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz34[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz48[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz35[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz47[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz49[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz50[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz51[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz52[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz100[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz56[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_xwzxwz85_Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[1]))
endfunction
function Trig_xwzxwz85_Actions takes nothing returns nothing
if (Trig_xwzxwz85_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了随机入魔的方式 请各玩家输入“进入魔道”入魔！"+""))
set udg_xwzxwz63=true
call EnableTrigger(gg_trg_xwzxwz82)
call DialogDestroy(udg_xwzxwz60)
else
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了选择入魔的方式 请各玩家输入“进入魔道”入魔对话框选择！"+""))
set udg_xwzxwz63=false
call EnableTrigger(gg_trg_xwzxwz82)
call DialogDestroy(udg_xwzxwz60)
endif
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz100[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz51[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz35[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz49[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz34[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz33[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz32[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001C takes nothing returns boolean
return ((udg_xwzxwz31[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Actions takes nothing returns nothing
if (Trig_xwzxwz1NoralPlayer_Func001C()) then
set udg_xwzxwz31[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001C()) then
set udg_xwzxwz32[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001C()) then
set udg_xwzxwz33[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001C()) then
set udg_xwzxwz34[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz49[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz35[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz51[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz100[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
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
function Trig_xwzxwz86_Conditions takes nothing returns boolean
return ((udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]))and((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((GetTriggerUnit()!=udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz86_Actions takes nothing returns nothing
set udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
set udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]=true
call CreateTextTagUnitBJ(((("|cFFFFFF00"+GetHeroProperName(GetTriggerUnit()))+"|r ")+"|cFFFF0033入魔成功！|r"),GetTriggerUnit(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
endfunction
function Trig_xwzxwz87_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz87_Func002C takes nothing returns boolean
return ((GetUnitLifePercent(GetAttacker())<=80.00))
endfunction
function Trig_xwzxwz87_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func004Func011001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz87_Func004Func011001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz87_Func004Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func004Func011001003001(),Trig_xwzxwz87_Func004Func011001003002())
endfunction
function Trig_xwzxwz87_Func004Func011A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(10.00,50.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz87_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func005Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz87_Func005Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz87_Func005Func005001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz87_Func005Func005001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz87_Func005Func005001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003002002001(),Trig_xwzxwz87_Func005Func005001003002002002())
endfunction
function Trig_xwzxwz87_Func005Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003002001(),Trig_xwzxwz87_Func005Func005001003002002())
endfunction
function Trig_xwzxwz87_Func005Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003001(),Trig_xwzxwz87_Func005Func005001003002())
endfunction
function Trig_xwzxwz87_Func005Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(5.00,20.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz87_Func005C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func006C takes nothing returns boolean
return ((RAbsBJ((GetUnitFacing(GetTriggerUnit())-GetUnitFacing(GetAttacker())))<=60.00))
endfunction
function Trig_xwzxwz87_Actions takes nothing returns nothing
if (Trig_xwzxwz87_Func002C()) then
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetAttacker(),(GetUnitLifePercent(GetAttacker())+3.00))
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"吸血之刃")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
if (Trig_xwzxwz87_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之罩")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetTriggerUnit(),0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call PauseUnitBJ(true,GetTriggerUnit())
call TriggerSleepAction(3.00)
call PauseUnitBJ(false,GetTriggerUnit())
endif
if (Trig_xwzxwz87_Func004C()) then
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
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz87_Func004Func011001003)),function Trig_xwzxwz87_Func004Func011A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz87_Func005C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔妖气")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz87_Func005Func005001003)),function Trig_xwzxwz87_Func005Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz87_Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"背击噬魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetTriggerUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot(I2R(GetHeroAgi(GetAttacker(),true)))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endif
endfunction
function Trig_xwzxwz87UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz87UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz87UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz87UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz87UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000金魔之斩魂刀|r熟练度为 ")+I2S(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000金魔之斩魂刀|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz87UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz88_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz88_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz88_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func001Func005001002003002001(),Trig_xwzxwz88_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz88_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func001Func005001002003001(),Trig_xwzxwz88_Func001Func005001002003002())
endfunction
function Trig_xwzxwz88_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz88_Func001C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz88_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func002Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func002Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz88_Func002Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005001002003002001(),Trig_xwzxwz88_Func002Func005001002003002002())
endfunction
function Trig_xwzxwz88_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005001002003001(),Trig_xwzxwz88_Func002Func005001002003002())
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit())))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005Func007003001003002001(),Trig_xwzxwz88_Func002Func005Func007003001003002002())
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005Func007003001003001(),Trig_xwzxwz88_Func002Func005Func007003001003002())
endfunction
function Trig_xwzxwz88_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIso\\BIsvTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitOwner(GetEnumUnit(),Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
call IssueTargetOrder(GetEnumUnit(),"attack",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func002Func005Func007003001003))))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz88_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz88_Actions takes nothing returns nothing
if (Trig_xwzxwz88_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魄云渺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1000.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func001Func005001002003))),function Trig_xwzxwz88_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz88_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魔转魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func002Func005001002003))),function Trig_xwzxwz88_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz88UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz88UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz88UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz88UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz88UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000冰魔之寒冰杖|r熟练度为 ")+I2S(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000冰魔之寒冰杖|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz88UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_xwzxwz89_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz89_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func001Func005001002003002001(),Trig_xwzxwz89_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz89_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func001Func005001002003001(),Trig_xwzxwz89_Func001Func005001002003002())
endfunction
function Trig_xwzxwz89_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz89_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz89_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func002Func005001003002001(),Trig_xwzxwz89_Func002Func005001003002002())
endfunction
function Trig_xwzxwz89_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func002Func005001003001(),Trig_xwzxwz89_Func002Func005001003002())
endfunction
function Trig_xwzxwz89_Func002Func005A takes nothing returns nothing
set udg_xwzxwz42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),800.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call IssuePointOrderLoc(GetEnumUnit(),"move",udg_xwzxwz42)
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-1))
call RemoveLocation(udg_xwzxwz42)
endfunction
function Trig_xwzxwz89_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz89_Func003Func011001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func003Func011001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func003Func011001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func003Func011001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func003Func011001003002001(),Trig_xwzxwz89_Func003Func011001003002002())
endfunction
function Trig_xwzxwz89_Func003Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func003Func011001003001(),Trig_xwzxwz89_Func003Func011001003002())
endfunction
function Trig_xwzxwz89_Func003Func011A takes nothing returns nothing
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*(10.00*I2R(GetHeroLevel(GetAttacker()))))*I2R(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz89_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz89_Actions takes nothing returns nothing
if (Trig_xwzxwz89_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地狱飞炎")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz89_Func001Func005001002003))),function Trig_xwzxwz89_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz89_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"炽火焚心")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz89_Func002Func005001003)),function Trig_xwzxwz89_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz89_Func003C()) then
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
call ForGroupBJ(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz89_Func003Func011001003)),function Trig_xwzxwz89_Func003Func011A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz89UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz89UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz89UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz89UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz89UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000炎魔之烈火刀|r熟练度为 ")+I2S(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000炎魔之烈火刀|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz89UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_xwzxwz90_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz90_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func001Func005001002003002001(),Trig_xwzxwz90_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz90_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func001Func005001002003001(),Trig_xwzxwz90_Func001Func005001002003002())
endfunction
function Trig_xwzxwz90_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz90_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz90_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func002Func005001003002001(),Trig_xwzxwz90_Func002Func005001003002002())
endfunction
function Trig_xwzxwz90_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func002Func005001003001(),Trig_xwzxwz90_Func002Func005001003002())
endfunction
function Trig_xwzxwz90_Func002Func005A takes nothing returns nothing
set udg_xwzxwz42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),500.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("CLPB",GetUnitLoc(GetEnumUnit()),udg_xwzxwz42)
call DestroyLightning(GetLastCreatedLightningBJ())
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
call RemoveLocation(udg_xwzxwz42)
endfunction
function Trig_xwzxwz90_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz90_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz90_Func004Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func004Func007001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func004Func007001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func004Func007001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz90_Func004Func007001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003002002001(),Trig_xwzxwz90_Func004Func007001003002002002())
endfunction
function Trig_xwzxwz90_Func004Func007001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003002001(),Trig_xwzxwz90_Func004Func007001003002002())
endfunction
function Trig_xwzxwz90_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003001(),Trig_xwzxwz90_Func004Func007001003002())
endfunction
function Trig_xwzxwz90_Func004Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz90_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_xwzxwz90_Actions takes nothing returns nothing
if (Trig_xwzxwz90_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"迅雷之击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func001Func005001002003))),function Trig_xwzxwz90_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz90_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"闪电净化")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func002Func005001003)),function Trig_xwzxwz90_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz90_Func003C()) then
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
if (Trig_xwzxwz90_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷霆一击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func004Func007001003)),function Trig_xwzxwz90_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz90UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz90UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz90UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz90UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz90UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000雷魔之迅雷剑|r熟练度为 ")+I2S(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000雷魔之迅雷剑|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz90UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz91_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz91_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func001Func005001002003002001(),Trig_xwzxwz91_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz91_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func001Func005001002003001(),Trig_xwzxwz91_Func001Func005001002003002())
endfunction
function Trig_xwzxwz91_Func001Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((GetUnitManaPercent(GetAttacker())*SquareRoot(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetAttacker())))*I2R(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz91_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_xwzxwz91_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func002Func005001003002001(),Trig_xwzxwz91_Func002Func005001003002002())
endfunction
function Trig_xwzxwz91_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func002Func005001003001(),Trig_xwzxwz91_Func002Func005001003002())
endfunction
function Trig_xwzxwz91_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroInt(GetAttacker(),true))*3.00)))*I2R(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz91_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz91_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz91_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003002002001(),Trig_xwzxwz91_Func003Func008001003002002002())
endfunction
function Trig_xwzxwz91_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003002001(),Trig_xwzxwz91_Func003Func008001003002002())
endfunction
function Trig_xwzxwz91_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003001(),Trig_xwzxwz91_Func003Func008001003002())
endfunction
function Trig_xwzxwz91_Func003Func008A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetEnumUnit(),0)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endfunction
function Trig_xwzxwz91_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz91_Actions takes nothing returns nothing
if (Trig_xwzxwz91_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水怒龙息")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(900.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func001Func005001002003))),function Trig_xwzxwz91_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz91_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"暴风雨雪")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(550.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func002Func005001003)),function Trig_xwzxwz91_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz91_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"邪恶水牢")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func003Func008001003)),function Trig_xwzxwz91_Func003Func008A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz91Hurt_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz91Hurt_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=20))and((GetUnitLifePercent(GetTriggerUnit())<=20.00))and((GetUnitManaPercent(GetTriggerUnit())>=30.00))
endfunction
function Trig_xwzxwz91Hurt_Actions takes nothing returns nothing
if (Trig_xwzxwz91Hurt_Func001C()) then
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
function Trig_xwzxwz91UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz91UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz91UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz91UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz91UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000水魔之定海神针|r熟练度为 ")+I2S(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000水魔之定海神针|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz91UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,6)
endif
endfunction
function Trig_xwzxwz92_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz92_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func007001002003002001(),Trig_xwzxwz92_Func001Func007001002003002002())
endfunction
function Trig_xwzxwz92_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func007001002003001(),Trig_xwzxwz92_Func001Func007001002003002())
endfunction
function Trig_xwzxwz92_Func001Func007A takes nothing returns nothing
set udg_xwzxwz45=(udg_xwzxwz45+1)
set udg_xwzxwz44[udg_xwzxwz45]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz46[udg_xwzxwz45]=AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\StormBolt\\StormBoltTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func005001003001(),Trig_xwzxwz92_Func001Func009Func005001003002())
endfunction
function Trig_xwzxwz92_Func001Func009Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*4.00)*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003002002001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002002002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003002001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*8.00)*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,10.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz92_Func001Func009Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=30))
endfunction
function Trig_xwzxwz92_Func001Func009C takes nothing returns boolean
return ((GetRandomInt(1,100)<=15))
endfunction
function Trig_xwzxwz92_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))and((udg_xwzxwz43[1]))
endfunction
function Trig_xwzxwz92_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func002Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func002Func005001003001(),Trig_xwzxwz92_Func002Func005001003002())
endfunction
function Trig_xwzxwz92_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz92_Func003Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func003Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func003Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func003Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz92_Func003Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003002002001(),Trig_xwzxwz92_Func003Func009001003002002002())
endfunction
function Trig_xwzxwz92_Func003Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003002001(),Trig_xwzxwz92_Func003Func009001003002002())
endfunction
function Trig_xwzxwz92_Func003Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003001(),Trig_xwzxwz92_Func003Func009001003002())
endfunction
function Trig_xwzxwz92_Func003Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
endfunction
function Trig_xwzxwz92_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz92_Actions takes nothing returns nothing
if (Trig_xwzxwz92_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"困仙刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz43[1]=false
set udg_xwzxwz45=0
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func007001002003))),function Trig_xwzxwz92_Func001Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
if (Trig_xwzxwz92_Func001Func009C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"2连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func009Func005001003)),function Trig_xwzxwz92_Func001Func009Func005A)
if (Trig_xwzxwz92_Func001Func009Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"3连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func009Func006Func009001003)),function Trig_xwzxwz92_Func001Func009Func006Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_xwzxwz9201)
return
endif
if (Trig_xwzxwz92_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"穿心刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func002Func005001003)),function Trig_xwzxwz92_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz92_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤足刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func003Func009001003)),function Trig_xwzxwz92_Func003Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz92UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz92UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz92UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz92UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz92UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000木魔之精灵地刺|r熟练度为 ")+I2S(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000木魔之精灵地刺|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz92UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz9201_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz44[GetForLoopIndexA()])
call DestroyEffect(udg_xwzxwz46[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz43[1]=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz93_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz93_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_xwzxwz93_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func001Func005001002003001(),Trig_xwzxwz93_Func001Func005001002003002())
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func001Func005Func009001003001(),Trig_xwzxwz93_Func001Func005Func009001003002())
endfunction
function Trig_xwzxwz93_Func001Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*SquareRoot(I2R(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005A takes nothing returns nothing
set udg_xwzxwz20=GetEnumUnit()
set udg_xwzxwz19=GetUnitLoc(udg_xwzxwz20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_xwzxwz19,Condition(function Trig_xwzxwz93_Func001Func005Func009001003)),function Trig_xwzxwz93_Func001Func005Func009A)
call RemoveUnit(udg_xwzxwz20)
call RemoveLocation(udg_xwzxwz19)
endfunction
function Trig_xwzxwz93_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz93_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz93_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func002Func005001002003001(),Trig_xwzxwz93_Func002Func005001002003002())
endfunction
function Trig_xwzxwz93_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetEnumUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetEnumUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(10.00,'BHwe',GetLastCreatedUnit())
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz93_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_xwzxwz93_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))
endfunction
function Trig_xwzxwz93_Actions takes nothing returns nothing
if (Trig_xwzxwz93_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"爆炸尸体")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz93_Func001Func005001002003))),function Trig_xwzxwz93_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz93_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"亡灵复苏")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz93_Func002Func005001002003))),function Trig_xwzxwz93_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz93_Func003C()) then
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
function Trig_xwzxwz93UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz93UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz93UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz93UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz93UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000亡魔之暗黑之刃|r熟练度为 ")+I2S(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000亡魔之暗黑之刃|r  "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz93UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz94_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz94_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz94_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func001Func007001002003002001(),Trig_xwzxwz94_Func001Func007001002003002002())
endfunction
function Trig_xwzxwz94_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func001Func007001002003001(),Trig_xwzxwz94_Func001Func007001002003002())
endfunction
function Trig_xwzxwz94_Func001Func007A takes nothing returns nothing
set udg_xwzxwz45=(udg_xwzxwz45+1)
set udg_xwzxwz57[udg_xwzxwz45]=GetEnumUnit()
set udg_xwzxwz54[udg_xwzxwz45]=GetUnitLoc(GetEnumUnit())
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieFire\\FaerieFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("DRAM",udg_xwzxwz54[(udg_xwzxwz45-1)],udg_xwzxwz54[udg_xwzxwz45])
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(I2R(GetHeroAgi(GetAttacker(),true))*(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+1))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
set udg_xwzxwz55[udg_xwzxwz45]=GetLastCreatedLightningBJ()
endfunction
function Trig_xwzxwz94_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))and((udg_xwzxwz43[2]))
endfunction
function Trig_xwzxwz94_Func002Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func002Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func002Func007001003001(),Trig_xwzxwz94_Func002Func007001003002())
endfunction
function Trig_xwzxwz94_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz94_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz94_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz94_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz94_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003002002001(),Trig_xwzxwz94_Func003Func008001003002002002())
endfunction
function Trig_xwzxwz94_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003002001(),Trig_xwzxwz94_Func003Func008001003002002())
endfunction
function Trig_xwzxwz94_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003001(),Trig_xwzxwz94_Func003Func008001003002())
endfunction
function Trig_xwzxwz94_Func003Func008A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),5.00)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz94_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz94_Actions takes nothing returns nothing
if (Trig_xwzxwz94_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月魔锁链")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz45=0
set udg_xwzxwz54[0]=GetUnitLoc(GetAttacker())
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func001Func007001002003))),function Trig_xwzxwz94_Func001Func007A)
call RemoveLocation(udg_xwzxwz54[0])
call RemoveLocation(GetUnitLoc(GetAttacker()))
call TriggerSleepAction(0.10)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz57[GetForLoopIndexA()])
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set udg_xwzxwz57[GetForLoopIndexA()]=null
call RemoveLocation(udg_xwzxwz54[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if (Trig_xwzxwz94_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"星坠月落")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func002Func007001003)),function Trig_xwzxwz94_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz94_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月晕之风")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func003Func008001003)),function Trig_xwzxwz94_Func003Func008A)
endif
endfunction
function Trig_xwzxwz9400_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz9400_Func001Func006001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz9400_Func001Func006001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit()))!=true)
endfunction
function Trig_xwzxwz9400_Func001Func006001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz9400_Func001Func006001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz9400_Func001Func006001003002001(),Trig_xwzxwz9400_Func001Func006001003002002())
endfunction
function Trig_xwzxwz9400_Func001Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz9400_Func001Func006001003001(),Trig_xwzxwz9400_Func001Func006001003002())
endfunction
function Trig_xwzxwz9400_Func001Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+SquareRoot(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
endfunction
function Trig_xwzxwz9400_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=R2I(SquareRoot(I2R((100-R2I(GetUnitLifePercent(GetTriggerUnit()))))))))
endfunction
function Trig_xwzxwz9400_Actions takes nothing returns nothing
if (Trig_xwzxwz9400_Func001C()) then
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),(GetUnitLifePercent(GetTriggerUnit())+SquareRoot(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz9400_Func001Func006001003)),function Trig_xwzxwz9400_Func001Func006A)
endif
endfunction
function Trig_xwzxwz94UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz94UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz94UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz94UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz94UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000月魔之无相金轮|r熟练度为 ")+I2S(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000月魔之无相金轮|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz94UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz95_Conditions takes nothing returns boolean
return ((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_xwzxwz95_Actions takes nothing returns nothing
set udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_xwzxwz97[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_xwzxwz70[GetConvertedPlayerId(GetTriggerPlayer())]=1
set udg_xwzxwz37[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+("  已经入了被封印的-<土魔>-"+"！ 请马上选择你要进入的英雄！")))
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz96_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))
endfunction
function Trig_xwzxwz96_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_xwzxwz96_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz96_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))
endfunction
function Trig_xwzxwz96_Func004C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=5))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>30))
endfunction
function Trig_xwzxwz96_Func005C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=2))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>50))
endfunction
function Trig_xwzxwz96_Actions takes nothing returns nothing
if (Trig_xwzxwz96_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"疾行土封")+"|r ")+"|cFFFF00334式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
call PauseUnitBJ(true,udg_xwzxwz65)
call SetUnitPathing(udg_xwzxwz65,false)
set udg_xwzxwz69=GetTriggerUnit()
call PauseUnitBJ(true,udg_xwzxwz69)
set udg_xwzxwz67[0]=GetUnitLoc(GetTriggerUnit())
set udg_xwzxwz68=0
call EnableTrigger(gg_trg_xwzxwz97F4)
return
endif
if (Trig_xwzxwz96_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地遁连击")+"|r ")+"|cFFFF003316式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz68=16
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
call SetUnitPathing(udg_xwzxwz65,false)
call PauseUnitBJ(true,udg_xwzxwz65)
call EnableTrigger(gg_trg_xwzxwz97F16)
return
endif
if (Trig_xwzxwz96_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地魔怒杀")+"|r ")+"|cFFFF003332式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
call PauseUnitBJ(true,udg_xwzxwz65)
call PauseUnitBJ(true,udg_xwzxwz69)
call TriggerExecute(gg_trg_xwzxwz97F32)
return
endif
if (Trig_xwzxwz96_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤残狂击")+"|r ")+"|cFFFF003364式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
set udg_xwzxwz68=0
call PauseUnitBJ(true,udg_xwzxwz65)
call PauseUnitBJ(true,udg_xwzxwz69)
call SetUnitLifePercentBJ(udg_xwzxwz65,(GetUnitLifePercent(udg_xwzxwz65)-50.00))
set udg_xwzxwz46[888]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_xwzxwz46[889]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call EnableTrigger(gg_trg_xwzxwz97F64)
call EnableTrigger(gg_trg_xwzxwz97F64death)
return
endif
if (Trig_xwzxwz96_Func005C()) then
set udg_xwzxwz65=GetAttacker()
call PanCameraToTimed(GetLocationX(GetUnitLoc(udg_xwzxwz65)),GetLocationY(GetUnitLoc(udg_xwzxwz65)),0.30)
call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE,4000.00,0)
call ConditionalTriggerExecute(gg_trg_xwzxwz97Screct)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"土魔密式")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
endfunction
function Trig_xwzxwz97F4_Func009001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F4_Func009001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F4_Func009001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F4_Func009001003001001(),Trig_xwzxwz97F4_Func009001003001002())
endfunction
function Trig_xwzxwz97F4_Func009001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F4_Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F4_Func009001003001(),Trig_xwzxwz97F4_Func009001003002())
endfunction
function Trig_xwzxwz97F4_Func009A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),udg_xwzxwz67[0])
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),((I2R(GetHeroLevel(udg_xwzxwz65))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz97F4_Func011C takes nothing returns boolean
return ((udg_xwzxwz68>24))
endfunction
function Trig_xwzxwz97F4_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],500.00,(((I2R(udg_xwzxwz68)-1)*15.00)+GetUnitFacing(udg_xwzxwz69)))
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+90.00))
call AddSpecialEffectLocBJ(udg_xwzxwz67[1],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitAnimation(udg_xwzxwz65,"Walk")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(80.00,udg_xwzxwz67[1],Condition(function Trig_xwzxwz97F4_Func009001003)),function Trig_xwzxwz97F4_Func009A)
call RemoveLocation(udg_xwzxwz67[1])
if (Trig_xwzxwz97F4_Func011C()) then
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_xwzxwz97F40)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitTimeScalePercent(udg_xwzxwz65,200.00)
call SetUnitAnimation(udg_xwzxwz65,"Attack")
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,0)
call SetUnitPositionLocFacingLocBJ(udg_xwzxwz65,udg_xwzxwz67[1],udg_xwzxwz67[0])
set udg_xwzxwz684=0
call RemoveLocation(udg_xwzxwz67[1])
endif
endfunction
function Trig_xwzxwz97F40_Func006C takes nothing returns boolean
return ((udg_xwzxwz684==1))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func007C takes nothing returns boolean
return ((udg_xwzxwz684==2))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func008C takes nothing returns boolean
return ((udg_xwzxwz684==3))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func009C takes nothing returns boolean
return ((udg_xwzxwz684==4))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func010C takes nothing returns boolean
return ((udg_xwzxwz684>=4))
endfunction
function Trig_xwzxwz97F40_Actions takes nothing returns nothing
set udg_xwzxwz684=(udg_xwzxwz684+1)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+I2S(udg_xwzxwz684))+"|r ")+"|cFFFF0033式|r"),udg_xwzxwz69,0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
if (Trig_xwzxwz97F40_Func006C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call SetUnitAnimation(udg_xwzxwz69,"death")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,180.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
endif
if (Trig_xwzxwz97F40_Func007C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,0.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call RemoveLocation(udg_xwzxwz67[1])
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func008C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,270.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func009C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func010C()) then
call DisableTrigger(GetTriggeringTrigger())
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitPathing(udg_xwzxwz65,true)
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100.00)
call RemoveLocation(udg_xwzxwz67[0])
call ResetUnitAnimation(udg_xwzxwz69)
endif
endfunction
function Trig_xwzxwz97F16_Func003002001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F16_Func003002001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F16_Func003002001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func003002001003001001(),Trig_xwzxwz97F16_Func003002001003001002())
endfunction
function Trig_xwzxwz97F16_Func003002001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F16_Func003002001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func003002001003001(),Trig_xwzxwz97F16_Func003002001003002())
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func018Func007Func002001001003001001(),Trig_xwzxwz97F16_Func018Func007Func002001001003001002())
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func018Func007Func002001001003001(),Trig_xwzxwz97F16_Func018Func007Func002001001003002())
endfunction
function Trig_xwzxwz97F16_Func018Func007C takes nothing returns boolean
return ((udg_xwzxwz68<1))or((CountUnitsInGroup(GetUnitsInRangeOfLocMatching(312.00,GetUnitLoc(udg_xwzxwz65),Condition(function Trig_xwzxwz97F16_Func018Func007Func002001001003)))<1))
endfunction
function Trig_xwzxwz97F16_Func018C takes nothing returns boolean
return (Trig_xwzxwz97F16_Func018Func007C())
endfunction
function Trig_xwzxwz97F16_Actions takes nothing returns nothing
call SetUnitVertexColorBJ(udg_xwzxwz65,0.00,0.00,0.00,70.00)
call ResetUnitAnimation(udg_xwzxwz65)
set udg_xwzxwz71=GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(udg_xwzxwz69),Condition(function Trig_xwzxwz97F16_Func003002001003)))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"units\\orc\\SpiritWyvern\\SpiritWyvern.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SelectUnitRemoveForPlayer(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,GetUnitLoc(udg_xwzxwz71),(180.00-GetUnitFacing(udg_xwzxwz71)))
call CreateTextTagUnitBJ((I2S(udg_xwzxwz68)+" Hits"),udg_xwzxwz71,0,10,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(udg_xwzxwz71),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz71,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
set udg_xwzxwz69=udg_xwzxwz71
set udg_xwzxwz68=(udg_xwzxwz68-1)
if (Trig_xwzxwz97F16_Func018C()) then
call DisableTrigger(GetTriggeringTrigger())
call SetUnitPathing(udg_xwzxwz65,true)
call SelectUnitForPlayerSingle(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call PauseUnitBJ(false,udg_xwzxwz65)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitVertexColorBJ(udg_xwzxwz65,100,100,100,0)
endif
endfunction
function Trig_xwzxwz97F32_Func003Func001Func015C takes nothing returns boolean
return ((GetRandomInt(1,100)>=40))
endfunction
function Trig_xwzxwz97F32_Func003Func001C takes nothing returns boolean
return ((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F32_Actions takes nothing returns nothing
call SelectUnitRemoveForPlayer(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call SetUnitTimeScalePercent(udg_xwzxwz65,500.00)
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=32
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if (Trig_xwzxwz97F32_Func003Func001C()) then
call CreateTextTagUnitBJ((I2S(GetForLoopIndexB())+" Hits"),udg_xwzxwz69,0,10,0.00,100,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),200.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitAnimation(udg_xwzxwz69,"death")
call AddSpecialEffectTargetUnitBJ("chest",udg_xwzxwz69,"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("HWPB",GetUnitLoc(udg_xwzxwz69),PolarProjectionBJ(GetUnitLoc(udg_xwzxwz69),700.00,(I2R(GetForLoopIndexB())*11.25)))
call SetLightningColor(GetLastCreatedLightningBJ(),0.20,1,0.20,0.40)
set udg_xwzxwz28[(100+GetForLoopIndexB())]=GetLastCreatedLightningBJ()
call AddSpecialEffectTargetUnitBJ("origin",udg_xwzxwz69,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if (Trig_xwzxwz97F32_Func003Func001Func015C()) then
call AddSpecialEffectLocBJ(GetUnitLoc(udg_xwzxwz69),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(GetForLoopIndexB())*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call TriggerSleepAction(0.10)
else
call ResetUnitAnimation(udg_xwzxwz69)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call PauseUnitBJ(false,udg_xwzxwz69)
call IssueImmediateOrder(udg_xwzxwz65,"stop")
call PauseUnitBJ(false,udg_xwzxwz65)
set bj_forLoopAIndex=100
set bj_forLoopAIndexEnd=135
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz28[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz97F64_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>4))
endfunction
function Trig_xwzxwz97F64_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==1))
endfunction
function Trig_xwzxwz97F64_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 4连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,270.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
else
if (Trig_xwzxwz97F64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=4
call TriggerSleepAction(0.50)
call EnableTrigger(gg_trg_xwzxwz97F6z16)
call SetUnitTimeScalePercent(udg_xwzxwz65,200.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z16_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>21))
endfunction
function Trig_xwzxwz97F6z16_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==5))
endfunction
function Trig_xwzxwz97F6z16_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_xwzxwz68,2)==1))
endfunction
function Trig_xwzxwz97F6z16_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z16_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 16连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_xwzxwz97F6z16_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=21
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_xwzxwz97F6z32)
call SetUnitTimeScalePercent(udg_xwzxwz65,500.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
if (Trig_xwzxwz97F6z16_Func012C()) then
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
else
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+22.50))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
endif
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[80]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+0.00))
set udg_xwzxwz67[81]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+90.00))
set udg_xwzxwz67[82]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
set udg_xwzxwz67[83]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+270.00))
call AddLightningLoc("HWPB",udg_xwzxwz67[80],udg_xwzxwz67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(80+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[81],udg_xwzxwz67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(110+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[82],udg_xwzxwz67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(140+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[83],udg_xwzxwz67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(170+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z32_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>54))
endfunction
function Trig_xwzxwz97F6z32_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==22))
endfunction
function Trig_xwzxwz97F6z32_Func031001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F6z32_Func031001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F6z32_Func031001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F6z32_Func031001003001(),Trig_xwzxwz97F6z32_Func031001003002())
endfunction
function Trig_xwzxwz97F6z32_Func031A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((1.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
endfunction
function Trig_xwzxwz97F6z32_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z32_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 32连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
else
if (Trig_xwzxwz97F6z32_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=54
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_xwzxwz97F6z64)
call SetUnitTimeScalePercent(udg_xwzxwz65,800.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],30.00,GetRandomReal(0,360.00))
call SetUnitPositionLocFacingBJ(udg_xwzxwz69,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[66])
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],35.00,GetRandomReal(0,360.00))
call SetUnitAnimation(udg_xwzxwz65,"attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65]))
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\NightElf\\EntangleMine\\Roots.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=20
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(I2R(GetForLoopIndexB())*18.00))
call AddSpecialEffectLocBJ(udg_xwzxwz67[67],"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_xwzxwz67[67])
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,udg_xwzxwz67[66],Condition(function Trig_xwzxwz97F6z32_Func031001003)),function Trig_xwzxwz97F6z32_Func031A)
call RemoveLocation(udg_xwzxwz67[66])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z64_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>64))
endfunction
function Trig_xwzxwz97F6z64_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==55))
endfunction
function Trig_xwzxwz97F6z64_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_xwzxwz68,2)==1))
endfunction
function Trig_xwzxwz97F6z64_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 64连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_xwzxwz97F6z64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=0
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_xwzxwz65),0.50)
call DestroyEffect(udg_xwzxwz46[888])
call DestroyEffect(udg_xwzxwz46[889])
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
if (Trig_xwzxwz97F6z64_Func012C()) then
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
else
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+36.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
endif
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[80]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+0.00))
set udg_xwzxwz67[81]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+72.00))
set udg_xwzxwz67[82]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+144.00))
set udg_xwzxwz67[83]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+216.00))
set udg_xwzxwz67[84]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+288.00))
call AddLightningLoc("HWPB",udg_xwzxwz67[80],udg_xwzxwz67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(80+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[81],udg_xwzxwz67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(110+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[82],udg_xwzxwz67[84])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(140+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[83],udg_xwzxwz67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(170+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[84],udg_xwzxwz67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(200+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F64death_Func001C takes nothing returns boolean
return ((IsUnitDeadBJ(udg_xwzxwz69)))or((IsUnitDeadBJ(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F64death_Conditions takes nothing returns boolean
return (Trig_xwzxwz97F64death_Func001C())
endfunction
function Trig_xwzxwz97F64death_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_xwzxwz97F64)
call DisableTrigger(gg_trg_xwzxwz97F6z16)
call DisableTrigger(gg_trg_xwzxwz97F6z32)
call DisableTrigger(gg_trg_xwzxwz97F6z64)
call DisableTrigger(gg_trg_xwzxwz97F64death)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call DestroyEffect(udg_xwzxwz46[888])
call DestroyEffect(udg_xwzxwz46[889])
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_xwzxwz65),0.50)
call RemoveLocation(udg_xwzxwz67[65])
call RemoveLocation(udg_xwzxwz67[66])
call RemoveLocation(udg_xwzxwz67[67])
endfunction
function Trig_tjzs_Func001C takes nothing returns boolean
return ((udg_xwzxwz74==false))and((GetUnitLevel(udg_xwzxwz65)>=50))
endfunction
function Trig_tjzs_Conditions takes nothing returns boolean
return (Trig_tjzs_Func001C())
endfunction
function Trig_tjzs_Func005Func004Func002C takes nothing returns boolean
return ((DistanceBetweenPoints(udg_xwzxwz77,OffsetLocation(udg_xwzxwz80,(0.00-(udg_xwzxwz76/2.00)),0))>100.00))
endfunction
function Trig_tjzs_Func007001003001 takes nothing returns boolean
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func007001003001(),Trig_tjzs_Func007001003002())
endfunction
function Trig_tjzs_Func007A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((50.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
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
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func041001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func041001003001(),Trig_tjzs_Func041001003002())
endfunction
function Trig_tjzs_Func041A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((80.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
endfunction
function Trig_tjzs_Func054001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func054001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func054001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func054001003001(),Trig_tjzs_Func054001003002())
endfunction
function Trig_tjzs_Func054A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((100.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
endfunction
function Trig_tjzs_Actions takes nothing returns nothing
set udg_xwzxwz74=true
set udg_xwzxwz80=GetUnitLoc(udg_xwzxwz65)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=44
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz76,I2R((GetForLoopIndexA()*4))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz76,I2R(((GetForLoopIndexA()*4)+180))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz73=((GetForLoopIndexA()+1)*2)
set udg_xwzxwz72=(180.00/I2R(udg_xwzxwz73))
set udg_xwzxwz78=(I2R(GetForLoopIndexA())*(udg_xwzxwz76/20.00))
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=udg_xwzxwz73
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_xwzxwz77=PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz78,(AcosBJ((udg_xwzxwz78/udg_xwzxwz76))+(I2R(GetForLoopIndexB())*udg_xwzxwz72)))
if (Trig_tjzs_Func005Func004Func002C()) then
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(udg_xwzxwz77,"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
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
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(OffsetLocation(udg_xwzxwz80,(udg_xwzxwz76/2.00),0),(I2R(GetForLoopIndexA())*5.00),(I2R(GetForLoopIndexB())*(720.00/(I2R(GetForLoopIndexA())+1)))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func007001003)),function Trig_tjzs_Func007A)
call TriggerSleepAction(1.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func014Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func015Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func016Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(256.00-(I2R(GetForLoopIndexA())*32.00)),700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func019Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(218.00-(I2R(GetForLoopIndexA())*36.33)),600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(182.00-(I2R(GetForLoopIndexA())*45.50)),500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func022Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(256.00-(I2R(GetForLoopIndexA())*32.00)),-700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(218.00-(I2R(GetForLoopIndexA())*36.33)),-600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func024Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(182.00-(I2R(GetForLoopIndexA())*45.50)),-500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func026Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(675.00-(I2R(GetForLoopIndexA())*22.50)),(315.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(578.50-(I2R(GetForLoopIndexA())*25.75)),(269.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(482.50-(I2R(GetForLoopIndexA())*32.13)),(225.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(315.00+(I2R(GetForLoopIndexA())*22.50)),(-675.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(269.50+(I2R(GetForLoopIndexA())*25.75)),(-578.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func032Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(225.50+(I2R(GetForLoopIndexA())*32.13)),(-482.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-675.00+(I2R(GetForLoopIndexA())*22.50)),(-315.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func035Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-578.50+(I2R(GetForLoopIndexA())*25.75)),(-269.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func036Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-482.50+(I2R(GetForLoopIndexA())*32.13)),(-225.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func038Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-315.00-(I2R(GetForLoopIndexA())*22.50)),(675.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func039Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-269.50-(I2R(GetForLoopIndexA())*25.75)),(578.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-225.50-(I2R(GetForLoopIndexA())*32.13)),(482.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func041001003)),function Trig_tjzs_Func041A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_xwzxwz75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_xwzxwz79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz75=0
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),-800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func054001003)),function Trig_tjzs_Func054A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_xwzxwz75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_xwzxwz79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz75=0
set udg_xwzxwz74=false
endfunction
function Trig_xwzxwz96UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz96UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz96UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz96UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz96UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000土魔之邪魔尘影|r熟练度为 ")+I2S(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000土魔之邪魔尘影|r  "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz96UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz14Normal_Func006C takes nothing returns boolean
return ((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz14Normal_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and(Trig_xwzxwz14Normal_Func006C())
endfunction
function Trig_xwzxwz14Normal_Func003C takes nothing returns boolean
return ((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetOrderTargetUnit()!=null))
endfunction
function Trig_xwzxwz14Normal_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
if (Trig_xwzxwz14Normal_Func003C()) then
call SetUnitPositionLoc(GetOrderTargetUnit(),GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
endif
endfunction
