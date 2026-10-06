function InitGlobalsl takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>1)
set udg_zfc[i]=""
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_zfc2[i]=""
set i=i+1
endloop
set i=0
loop
exitwhen(i>99)
set udg_dhk[i]=DialogCreate()
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_zs[i]=0
set i=i+1
endloop
set udg_zs2=0
set i=0
loop
exitwhen(i>1)
set udg_xs3[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_zs4[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_zs5[i]=0
set i=i+1
endloop
endfunction
function Trig_tianhuan1_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan16,udg_dhk[bj_forLoopAIndex])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_zfc[0]="退出选择"
set udg_zfc[1]="选择光环"
set udg_zfc[2]="常用技能"
set udg_zfc[3]="杂七杂八"
set udg_zfc[4]="升级属性 "
set udg_zfc[5]="升级经验"
set udg_zfc[6]="增加金钱"
set udg_zfc[7]="增加木材"
set udg_zfc[8]="增加人口"
set udg_zfc[9]="创建单位"
set udg_zfc[10]="赠送钱木"
set udg_zfc[11]="吸血光环"
set udg_zfc[12]="专注光环"
set udg_zfc[13]="辉煌光环"
set udg_zfc[14]="恢复光环"
set udg_zfc[15]="耐久光环"
set udg_zfc[16]="邪恶光环"
set udg_zfc[17]="强击光环"
set udg_zfc[18]="命令光环"
set udg_zfc[19]="减速光环"
set udg_zfc[20]="闪烁（凑个数的）"
set udg_zfc[21]="无敌"
set udg_zfc[22]="镜像"
set udg_zfc[23]="重生"
set udg_zfc[24]="弹幕攻击"
set udg_zfc[25]="分裂攻击"
set udg_zfc[26]="魔法护盾"
set udg_zfc[27]="地狱火"
set udg_zfc[28]="黑暗之门"
set udg_zfc[29]="吸血"
set udg_zfc[30]="魔法免疫"
set udg_zfc[31]="全图瞬移  按M键全图瞬移"
set udg_zfc[32]="人口自动清0   每5秒清一次"
set udg_zfc[33]="自动清除CD  也可手动清除 按↑键"
set udg_zfc[34]="狂爆物品   20/1几率会爆一切物品"
set udg_zfc[35]="快速建造升级   瞬间完成95%"
set udg_zfc[36]="无限弹药 丢掉在捡起使用次数200次"
set udg_zfc[37]="自动回血   血少于20%才会发动"
set udg_zfc[38]="地图全亮"
set udg_zfc[39]="梦幻效果   改变造型 加快速度"
set udg_zfc[40]="自动原地复活"
set udg_zfc[51]="农民（人族）"
set udg_zfc[52]="苦工（兽族）"
set udg_zfc[53]="侍僧（不死族）"
set udg_zfc[54]="小精灵（暗夜精灵）"
set udg_zfc[55]="奴隶（娜伽）"
set udg_zfc[56]="剑圣"
set udg_zfc[57]="恶魔猎手"
set udg_zfc[58]="牛头人"
set udg_zfc[59]="恐惧魔王"
set udg_zfc[60]="大魔法师"
set udg_zfc[61]="玩家1"
set udg_zfc[62]="玩家2"
set udg_zfc[63]="玩家3"
set udg_zfc[64]="玩家4"
set udg_zfc[65]="玩家5"
set udg_zfc[66]="玩家6"
set udg_zfc[67]="玩家7"
set udg_zfc[68]="玩家8"
set udg_zfc[69]="玩家9"
set udg_zfc[70]="玩家10"
set udg_zfc[41]="1"
set udg_zfc[42]="10"
set udg_zfc[43]="100"
set udg_zfc[44]="1000"
set udg_zfc[45]="10000"
set udg_zfc[46]="-1"
set udg_zfc[47]="-10"
set udg_zfc[48]="-100"
set udg_zfc[49]="-1000"
set udg_zfc[50]="-10000"
set udg_zfc2[11]="吸血光环"
set udg_zfc2[12]="专注光环"
set udg_zfc2[13]="辉煌光环"
set udg_zfc2[14]="恢复光环"
set udg_zfc2[15]="耐久光环"
set udg_zfc2[16]="邪恶光环"
set udg_zfc2[17]="强击光环"
set udg_zfc2[18]="命令光环"
set udg_zfc2[19]="减速光环"
set udg_zfc2[20]="闪烁（凑个数的）"
set udg_zfc2[21]="无敌"
set udg_zfc2[22]="镜像"
set udg_zfc2[23]="重生"
set udg_zfc2[24]="弹幕攻击"
set udg_zfc2[25]="分裂攻击"
set udg_zfc2[26]="魔法护盾"
set udg_zfc2[27]="地狱火"
set udg_zfc2[28]="黑暗之门"
set udg_zfc2[29]="吸血"
set udg_zfc2[30]="魔法免疫"
set udg_zfc2[31]="全图瞬移  按M键全图瞬移"
set udg_zfc2[32]="人口自动清0   每5秒清一次"
set udg_zfc2[33]="自动清除CD  也可手动清除 按↑键"
set udg_zfc2[34]="狂爆物品   20/1几率会爆一切物品"
set udg_zfc2[35]="快速建造升级   瞬间完成95%"
set udg_zfc2[36]="无限弹药 丢掉在捡起使用次数200次"
set udg_zfc2[37]="自动回血   血少于20%才会发动"
set udg_zfc2[38]="地图全亮"
set udg_zfc2[39]="梦幻效果   改变造型 加快速度"
set udg_zfc2[40]="自动原地复活"
set udg_zfc2[1]="返回上级"
set udg_zfc2[2]="关闭"
set udg_zfc2[3]="玩家"
set udg_jn[21]='Avul'
set udg_jn[22]='AOmi'
set udg_jn[23]='AOre'
set udg_jn[24]='Aroc'
set udg_jn[25]='ACce'
set udg_jn[26]='ANms'
set udg_jn[27]='AUin'
set udg_jn[28]='ANdp'
set udg_jn[29]='AIva'
set udg_jn[30]='ACmi'
set udg_jn[11]='ACvp'
set udg_jn[12]='ACav'
set udg_jn[13]='AIba'
set udg_jn[14]='Aoar'
set udg_jn[15]='SCae'
set udg_jn[16]='AUau'
set udg_jn[17]='ACat'
set udg_jn[18]='ACac'
set udg_jn[19]='Aasl'
set udg_jn[20]='ANbl'
set udg_zs4[1]=1
set udg_zs4[2]=10
set udg_zs4[3]='d'
set udg_zs4[4]=1000
set udg_zs4[5]=10000
set udg_zs4[6]=-1
set udg_zs4[7]=-10
set udg_zs4[8]=-'d'
set udg_zs4[9]=-1000
set udg_zs4[10]=-10000
set udg_zs4[20]=0
set udg_dwlx[1]='hpea'
set udg_dwlx[2]='opeo'
set udg_dwlx[3]='uaco'
set udg_dwlx[4]='ewsp'
set udg_dwlx[5]='nmpe'
set udg_dwlx[6]='Obla'
set udg_dwlx[7]='Edem'
set udg_dwlx[8]='Otch'
set udg_dwlx[9]='Udre'
set udg_dwlx[10]='Hamg'
endfunction
function InitTrig_tianhuan1 takes nothing returns nothing
set gg_trg_tianhuan1=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_tianhuan1,.1)
call TriggerAddAction(gg_trg_tianhuan1,function Trig_tianhuan1_Actions)
endfunction
function Trig_tianhuan2_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("Stop"))
endfunction
function Trig_tianhuan2_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_tianhuan3)
call TriggerSleepAction(.1)
call DisableTrigger(gg_trg_tianhuan3)
endfunction
function InitTrig_tianhuan2 takes nothing returns nothing
set gg_trg_tianhuan2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan2,EVENT_PLAYER_UNIT_ISSUED_ORDER)
call TriggerAddCondition(gg_trg_tianhuan2,Condition(function Trig_tianhuan2_Conditions))
call TriggerAddAction(gg_trg_tianhuan2,function Trig_tianhuan2_Actions)
endfunction
function Trig_tianhuan3_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==851993)
endfunction
function Trig_tianhuan3_Actions takes nothing returns nothing
set udg_dw[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call TriggerExecute(gg_trg_tianhuan4)
call TriggerExecute(gg_trg_tianhuan17)
endfunction
function InitTrig_tianhuan3 takes nothing returns nothing
set gg_trg_tianhuan3=CreateTrigger()
call DisableTrigger(gg_trg_tianhuan3)
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan3,EVENT_PLAYER_UNIT_ISSUED_ORDER)
call TriggerAddCondition(gg_trg_tianhuan3,Condition(function Trig_tianhuan3_Conditions))
call TriggerAddAction(gg_trg_tianhuan3,function Trig_tianhuan3_Actions)
endfunction
function Trig_tianhuan4_Actions takes nothing returns nothing
call DialogClear(udg_dhk[99])
call DialogSetMessage(udg_dhk[99],("天幻"+"狂想"))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DialogAddButtonBJ(udg_dhk[99],udg_zfc[bj_forLoopAIndex])
set udg_dhkan[bj_forLoopAIndex]=bj_lastCreatedButton
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DialogAddButtonBJ(udg_dhk[99],udg_zfc[0])
set udg_dhkan[98]=bj_lastCreatedButton
call DialogDisplay(GetTriggerPlayer(),udg_dhk[99],true)
endfunction
function InitTrig_tianhuan4 takes nothing returns nothing
set gg_trg_tianhuan4=CreateTrigger()
call TriggerAddAction(gg_trg_tianhuan4,function Trig_tianhuan4_Actions)
endfunction
function Trig_tianhuan5_Func001Func001Func001C takes nothing returns boolean
return(udg_dhkan[bj_forLoopAIndex]==GetClickedButtonBJ())
endfunction
function Trig_tianhuan5_Func001Func002C takes nothing returns boolean
return(udg_dhkan[9]==GetClickedButtonBJ())
endfunction
function Trig_tianhuan5_Func001Func003C takes nothing returns boolean
return(udg_dhkan[10]==GetClickedButtonBJ())
endfunction
function Trig_tianhuan5_Func001Func004Func001C takes nothing returns boolean
return(udg_dhkan[bj_forLoopAIndex]==GetClickedButtonBJ())
endfunction
function Trig_tianhuan5_Func001C takes nothing returns boolean
return(udg_dhkan[98]!=GetClickedButtonBJ())
endfunction
function Trig_tianhuan5_Actions takes nothing returns nothing
if(Trig_tianhuan5_Func001C())then
set bj_forLoopAIndex=4
set bj_forLoopAIndexEnd=8
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan5_Func001Func001Func001C())then
set udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]=40
set udg_zs2=bj_forLoopAIndex
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
if(Trig_tianhuan5_Func001Func002C())then
set udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]=50
set udg_zs2=9
endif
if(Trig_tianhuan5_Func001Func003C())then
set udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]=60
set udg_zs2=10
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=3
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan5_Func001Func004Func001C())then
set udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]=(bj_forLoopAIndex*10)
set udg_zs2=bj_forLoopAIndex
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DialogClear(udg_dhk[udg_zs2])
call DialogSetMessage(udg_dhk[udg_zs2],udg_zfc[udg_zs2])
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=10
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
call DialogAddButtonBJ(udg_dhk[udg_zs2],udg_zfc[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopBIndex)])
set udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopBIndex)]=bj_lastCreatedButton
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call DialogAddButtonBJ(udg_dhk[udg_zs2],udg_zfc2[1])
set udg_dhkan[99]=bj_lastCreatedButton
call DialogDisplay(GetTriggerPlayer(),udg_dhk[udg_zs2],true)
endif
endfunction
function InitTrig_tianhuan5 takes nothing returns nothing
set gg_trg_tianhuan5=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan5,udg_dhk[99])
call TriggerAddAction(gg_trg_tianhuan5,function Trig_tianhuan5_Actions)
endfunction
function Trig_tianhuan6_Func001Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+10))]==1)
endfunction
function Trig_tianhuan6_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+10))]==0)
endfunction
function Trig_tianhuan6_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan6_Func001Func001C())then
call UnitAddAbilityBJ(udg_jn[(10+bj_forLoopAIndex)],udg_dw[GetConvertedPlayerId(GetTriggerPlayer())])
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+10))]=1
set udg_zfc[(10+bj_forLoopAIndex)]=("关闭"+udg_zfc[(10+bj_forLoopAIndex)])
call TriggerExecute(gg_trg_tianhuan5)
else
if(Trig_tianhuan6_Func001Func001Func001C())then
call UnitRemoveAbilityBJ(udg_jn[(10+bj_forLoopAIndex)],udg_dw[GetConvertedPlayerId(GetTriggerPlayer())])
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+10))]=0
set udg_zfc[(10+bj_forLoopAIndex)]=udg_zfc2[(10+bj_forLoopAIndex)]
call TriggerExecute(gg_trg_tianhuan5)
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan6 takes nothing returns nothing
set gg_trg_tianhuan6=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan6,udg_dhk[1])
call TriggerAddAction(gg_trg_tianhuan6,function Trig_tianhuan6_Actions)
endfunction
function Trig_tianhuan7_Func001Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+20))]==1)
endfunction
function Trig_tianhuan7_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+20))]==0)
endfunction
function Trig_tianhuan7_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan7_Func001Func001C())then
call UnitAddAbilityBJ(udg_jn[(20+bj_forLoopAIndex)],udg_dw[GetConvertedPlayerId(GetTriggerPlayer())])
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+20))]=1
set udg_zfc[(20+bj_forLoopAIndex)]=("删除"+udg_zfc[(20+bj_forLoopAIndex)])
call TriggerExecute(gg_trg_tianhuan5)
else
if(Trig_tianhuan7_Func001Func001Func001C())then
call UnitRemoveAbilityBJ(udg_jn[(20+bj_forLoopAIndex)],udg_dw[GetConvertedPlayerId(GetTriggerPlayer())])
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+20))]=0
set udg_zfc[(20+bj_forLoopAIndex)]=udg_zfc2[(20+bj_forLoopAIndex)]
call TriggerExecute(gg_trg_tianhuan5)
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan7 takes nothing returns nothing
set gg_trg_tianhuan7=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan7,udg_dhk[2])
call TriggerAddAction(gg_trg_tianhuan7,function Trig_tianhuan7_Actions)
endfunction
function Trig_tianhuan8_Func001Func001Func002C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+30))]==1)
endfunction
function Trig_tianhuan8_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])and(udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+30))]==0)
endfunction
function Trig_tianhuan8_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan8_Func001Func001C())then
set udg_zs5[((GetConvertedPlayerId(GetTriggerPlayer())*10)+(bj_forLoopAIndex-1))]=1
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+30))]=1
set udg_zfc[(30+bj_forLoopAIndex)]=("关闭"+udg_zfc[(30+bj_forLoopAIndex)])
call TriggerExecute(gg_trg_tianhuan5)
else
if(Trig_tianhuan8_Func001Func001Func002C())then
set udg_zs5[((GetConvertedPlayerId(GetTriggerPlayer())*10)+(bj_forLoopAIndex-1))]=0
set udg_xs3[((udg_xs3[GetConvertedPlayerId(GetTriggerPlayer())]+'d')+(bj_forLoopAIndex+30))]=0
set udg_zfc[(30+bj_forLoopAIndex)]=udg_zfc2[(30+bj_forLoopAIndex)]
call TriggerExecute(gg_trg_tianhuan5)
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan8 takes nothing returns nothing
set gg_trg_tianhuan8=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan8,udg_dhk[3])
call TriggerAddAction(gg_trg_tianhuan8,function Trig_tianhuan8_Actions)
endfunction
function Trig_tianhuan9_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan9_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan9_Func001Func001C())then
set udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+1)]=(udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+1)]+udg_zs4[bj_forLoopAIndex])
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("现在每级增加属性为"+I2S(udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+1)])))
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan9 takes nothing returns nothing
set gg_trg_tianhuan9=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan9,udg_dhk[4])
call TriggerAddAction(gg_trg_tianhuan9,function Trig_tianhuan9_Actions)
endfunction
function Trig_tianhuan10_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan10_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan10_Func001Func001C())then
set udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+2)]=(udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+2)]+udg_zs4[bj_forLoopAIndex])
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("现在杀怪增加经验为"+I2S(udg_zs4[((GetConvertedPlayerId(GetTriggerPlayer())*12)+2)])))
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan10 takes nothing returns nothing
set gg_trg_tianhuan10=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan10,udg_dhk[5])
call TriggerAddAction(gg_trg_tianhuan10,function Trig_tianhuan10_Actions)
endfunction
function Trig_tianhuan11_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan11_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan11_Func001Func001C())then
call AdjustPlayerStateBJ(udg_zs4[bj_forLoopAIndex],GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan11 takes nothing returns nothing
set gg_trg_tianhuan11=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan11,udg_dhk[6])
call TriggerAddAction(gg_trg_tianhuan11,function Trig_tianhuan11_Actions)
endfunction
function Trig_tianhuan12_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan12_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan12_Func001Func001C())then
call AdjustPlayerStateBJ(udg_zs4[bj_forLoopAIndex],GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan12 takes nothing returns nothing
set gg_trg_tianhuan12=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan12,udg_dhk[7])
call TriggerAddAction(gg_trg_tianhuan12,function Trig_tianhuan12_Actions)
endfunction
function Trig_tianhuan13_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan13_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan13_Func001Func001C())then
call AdjustPlayerStateBJ(udg_zs4[bj_forLoopAIndex],GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED)
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan13 takes nothing returns nothing
set gg_trg_tianhuan13=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan13,udg_dhk[8])
call TriggerAddAction(gg_trg_tianhuan13,function Trig_tianhuan13_Actions)
endfunction
function Trig_tianhuan14_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan14_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan14_Func001Func001C())then
call CreateNUnitsAtLoc(1,udg_dwlx[bj_forLoopAIndex],GetTriggerPlayer(),GetUnitLoc(udg_dw[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan14 takes nothing returns nothing
set gg_trg_tianhuan14=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan14,udg_dhk[9])
call TriggerAddAction(gg_trg_tianhuan14,function Trig_tianhuan14_Actions)
endfunction
function Trig_tianhuan15_Func001Func001C takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[(udg_zs[GetConvertedPlayerId(GetTriggerPlayer())]+bj_forLoopAIndex)])
endfunction
function Trig_tianhuan15_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan15_Func001Func001C())then
call AdjustPlayerStateBJ(10000,ConvertedPlayer(bj_forLoopAIndex),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(10000,ConvertedPlayer(bj_forLoopAIndex),PLAYER_STATE_RESOURCE_LUMBER)
call TriggerExecute(gg_trg_tianhuan5)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan15 takes nothing returns nothing
set gg_trg_tianhuan15=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan15,udg_dhk[10])
call TriggerAddAction(gg_trg_tianhuan15,function Trig_tianhuan15_Actions)
endfunction
function Trig_tianhuan16_Conditions takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[99])
endfunction
function Trig_tianhuan16_Actions takes nothing returns nothing
call TriggerExecute(gg_trg_tianhuan4)
endfunction
function InitTrig_tianhuan16 takes nothing returns nothing
set gg_trg_tianhuan16=CreateTrigger()
call TriggerAddCondition(gg_trg_tianhuan16,Condition(function Trig_tianhuan16_Conditions))
call TriggerAddAction(gg_trg_tianhuan16,function Trig_tianhuan16_Actions)
endfunction
function Trig_tianhuan17_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call SetPlayerTechResearchedSwap('Rhrt',(GetPlayerTechCountSimple('Rhrt',ConvertedPlayer(bj_forLoopAIndex))+1),ConvertedPlayer(bj_forLoopAIndex))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_tianhuan17 takes nothing returns nothing
set gg_trg_tianhuan17=CreateTrigger()
call TriggerAddAction(gg_trg_tianhuan17,function Trig_tianhuan17_Actions)
endfunction
function Trig_tianhuan18_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,udg_zs4[11])
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,udg_zs4[11])
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,udg_zs4[11])
endfunction
function InitTrig_tianhuan18 takes nothing returns nothing
set gg_trg_tianhuan18=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan18,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddAction(gg_trg_tianhuan18,function Trig_tianhuan18_Actions)
endfunction
function Trig_tianhuan19_Conditions takes nothing returns boolean
return(IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_tianhuan19_Func002C takes nothing returns boolean
return(GetRandomInt(1,20)==2)and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))*10)+3)]==1)
endfunction
function Trig_tianhuan19_Actions takes nothing returns nothing
call AddHeroXPSwapped((udg_zs4[12]*GetUnitLevel(GetDyingUnit())),GetKillingUnitBJ(),true)
if(Trig_tianhuan19_Func002C())then
call CreateItemLoc(ChooseRandomItemBJ(-1),GetUnitLoc(GetDyingUnit()))
endif
endfunction
function InitTrig_tianhuan19 takes nothing returns nothing
set gg_trg_tianhuan19=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan19,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_tianhuan19,Condition(function Trig_tianhuan19_Conditions))
call TriggerAddAction(gg_trg_tianhuan19,function Trig_tianhuan19_Actions)
endfunction
function Trig_tianhuan20_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("Move"))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))*10)+0)]==1)
endfunction
function Trig_tianhuan20_Actions takes nothing returns nothing
call SetUnitPositionLocFacingBJ(GetTriggerUnit(),GetOrderPointLoc(),bj_UNIT_FACING)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetOrderPointLoc(),0)
endfunction
function InitTrig_tianhuan20 takes nothing returns nothing
set gg_trg_tianhuan20=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan20,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_tianhuan20,Condition(function Trig_tianhuan20_Conditions))
call TriggerAddAction(gg_trg_tianhuan20,function Trig_tianhuan20_Actions)
endfunction
function Trig_tianhuan21_Conditions takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE))and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))*10)+4)]==1)
endfunction
function Trig_tianhuan21_Actions takes nothing returns nothing
call PolledWait(1.)
call UnitSetUpgradeProgress(GetTriggerUnit(),95)
endfunction
function InitTrig_tianhuan21 takes nothing returns nothing
set gg_trg_tianhuan21=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan21,EVENT_PLAYER_UNIT_UPGRADE_START)
call TriggerAddCondition(gg_trg_tianhuan21,Condition(function Trig_tianhuan21_Conditions))
call TriggerAddAction(gg_trg_tianhuan21,function Trig_tianhuan21_Actions)
endfunction
function Trig_tianhuan22_Conditions takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE))and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))*10)+4)]==1)
endfunction
function Trig_tianhuan22_Actions takes nothing returns nothing
call PolledWait(1.)
call UnitSetConstructionProgress(GetTriggerUnit(),95)
endfunction
function InitTrig_tianhuan22 takes nothing returns nothing
set gg_trg_tianhuan22=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan22,EVENT_PLAYER_UNIT_CONSTRUCT_START)
call TriggerAddCondition(gg_trg_tianhuan22,Condition(function Trig_tianhuan22_Conditions))
call TriggerAddAction(gg_trg_tianhuan22,function Trig_tianhuan22_Actions)
endfunction
function Trig_tianhuan23_Conditions takes nothing returns boolean
return(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomInt(1,10)==1)and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))*10)+6)]==1)
endfunction
function Trig_tianhuan23_Actions takes nothing returns nothing
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl")
endfunction
function InitTrig_tianhuan23 takes nothing returns nothing
set gg_trg_tianhuan23=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan23,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_tianhuan23,Condition(function Trig_tianhuan23_Conditions))
call TriggerAddAction(gg_trg_tianhuan23,function Trig_tianhuan23_Actions)
endfunction
function Trig_tianhuan24_Func001Func001C takes nothing returns boolean
return(udg_zs5[((bj_forLoopAIndex*10)+1)]==1)
endfunction
function Trig_tianhuan24_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_tianhuan24_Func001Func001C())then
call SetPlayerStateBJ(ConvertedPlayer(bj_forLoopAIndex),PLAYER_STATE_RESOURCE_FOOD_USED,0)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_tianhuan24 takes nothing returns nothing
set gg_trg_tianhuan24=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_tianhuan24,5.)
call TriggerAddAction(gg_trg_tianhuan24,function Trig_tianhuan24_Actions)
endfunction
function Trig_tianhuan25_Conditions takes nothing returns boolean
return(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))*10)+5)]==1)
endfunction
function Trig_tianhuan25_Actions takes nothing returns nothing
call SetItemCharges(GetManipulatedItem(),200)
endfunction
function InitTrig_tianhuan25 takes nothing returns nothing
set gg_trg_tianhuan25=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan25,EVENT_PLAYER_UNIT_DROP_ITEM)
call TriggerAddCondition(gg_trg_tianhuan25,Condition(function Trig_tianhuan25_Conditions))
call TriggerAddAction(gg_trg_tianhuan25,function Trig_tianhuan25_Actions)
endfunction
function Trig_tianhuan26_Conditions takes nothing returns boolean
return(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))*10)+2)]==1)
endfunction
function Trig_tianhuan26_Actions takes nothing returns nothing
call UnitResetCooldown(GetSpellAbilityUnit())
endfunction
function InitTrig_tianhuan26 takes nothing returns nothing
set gg_trg_tianhuan26=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan26,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(gg_trg_tianhuan26,Condition(function Trig_tianhuan26_Conditions))
call TriggerAddAction(gg_trg_tianhuan26,function Trig_tianhuan26_Actions)
endfunction
function Trig_tianhuan27_Conditions takes nothing returns boolean
return(GetClickedButtonBJ()==udg_dhkan[28])
endfunction
function Trig_tianhuan27_Func002C takes nothing returns boolean
return(udg_zs5[((GetConvertedPlayerId(GetTriggerPlayer())*10)+7)]==1)
endfunction
function Trig_tianhuan27_Actions takes nothing returns nothing
if(Trig_tianhuan27_Func002C())then
call CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetPlayableMapRect())
set udg_kjd[GetConvertedPlayerId(GetTriggerPlayer())]=bj_lastCreatedFogModifier
else
call DestroyFogModifier(udg_kjd[GetConvertedPlayerId(GetTriggerPlayer())])
endif
endfunction
function InitTrig_tianhuan27 takes nothing returns nothing
set gg_trg_tianhuan27=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_tianhuan27,udg_dhk[3])
call TriggerAddCondition(gg_trg_tianhuan27,Condition(function Trig_tianhuan27_Conditions))
call TriggerAddAction(gg_trg_tianhuan27,function Trig_tianhuan27_Actions)
endfunction
function Trig_tianhuan28_Conditions takes nothing returns boolean
return(IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO))and(udg_zs5[((GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))*10)+9)]==1)
endfunction
function Trig_tianhuan28_Actions takes nothing returns nothing
call ReviveHeroLoc(GetDyingUnit(),GetUnitLoc(GetDyingUnit()),false)
endfunction
function InitTrig_tianhuan28 takes nothing returns nothing
set gg_trg_tianhuan28=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_tianhuan28,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_tianhuan28,Condition(function Trig_tianhuan28_Conditions))
call TriggerAddAction(gg_trg_tianhuan28,function Trig_tianhuan28_Actions)
endfunction
