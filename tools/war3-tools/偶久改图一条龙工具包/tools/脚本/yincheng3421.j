globals
force udg_yincheng3421WJQX=CreateForce()
player udg_bf3401WJQX=null
integer array udg_yincheng3421A
integer array udg_yincheng3421B
integer array udg_yincheng3421C
integer array udg_yincheng3421D
integer udg_yincheng3421ZY=0
integer array udg_yincheng3421XH
group array udg_yincheng3421DW
force array udg_yincheng3421GX
integer array udg_yincheng3421SY
player udg_yincheng3421WJSX=null
dialog udg_yincheng3421DHK
integer array udg_yincheng3421ZYQ
integer array udg_yincheng3421ZYM
integer array udg_yincheng3421RK
integer array udg_yincheng3421KQ
integer array udg_bf3401KQ
integer array udg_yincheng3421CMD
string array udg_yincheng3421ZFC
real array udg_yincheng3421HP
real array udg_yincheng3421MP
integer array udg_yincheng3421CD
integer array udg_yincheng3421JZ
trigger gg_trg_yincheng3421WJQX=CreateTrigger()
trigger gg_trg_yincheng3421A1=CreateTrigger()
trigger gg_trg_yincheng3421ML=CreateTrigger()
trigger gg_trg_yincheng3421SS=CreateTrigger()
trigger gg_trg_yincheng3421XX=CreateTrigger()
trigger gg_trg_yincheng3421CC=CreateTrigger()
trigger gg_trg_yincheng3421DD=CreateTrigger()
trigger gg_trg_yincheng3421A3=CreateTrigger()
trigger gg_trg_yincheng3421A4=CreateTrigger()
trigger gg_trg_yincheng3421A5=CreateTrigger()
trigger gg_trg_yincheng3421A6=CreateTrigger()
trigger gg_trg_yincheng3421A7=CreateTrigger()
trigger gg_trg_yincheng3421A8=CreateTrigger()
trigger gg_trg_yincheng3421AA=CreateTrigger()
trigger gg_trg_yincheng3421JT=CreateTrigger()
trigger gg_trg_yincheng3421AS=CreateTrigger()
trigger gg_trg_yincheng3421BX=CreateTrigger()
trigger gg_trg_yincheng3421CZ=CreateTrigger()
trigger gg_trg_yincheng3421YC=CreateTrigger()
trigger gg_trg_yincheng3421XS=CreateTrigger()
trigger gg_trg_yincheng3421Z8=CreateTrigger()
trigger gg_trg_yincheng3421Y8=CreateTrigger()
trigger gg_trg_yincheng3421CD=CreateTrigger()
trigger gg_trg_bf3401CD=CreateTrigger()
trigger gg_trg_yincheng3421JZ=CreateTrigger()
trigger gg_trg_bf3401JZ=CreateTrigger()
trigger gg_trg_bf3402JZ=CreateTrigger()
trigger gg_trg_yincheng3421A2=CreateTrigger()
trigger gg_trg_yincheng3421A9=CreateTrigger()
trigger gg_trg_yincheng3421B1=CreateTrigger()
trigger gg_trg_yincheng3421BA=CreateTrigger()
trigger gg_trg_yincheng3421B2=CreateTrigger()
trigger gg_trg_yincheng3421BB=CreateTrigger()
trigger gg_trg_yincheng3421ZY=CreateTrigger()
trigger gg_trg_yincheng3421QM=CreateTrigger()
trigger gg_trg_yincheng3421Q=CreateTrigger()
trigger gg_trg_yincheng3421M=CreateTrigger()
trigger gg_trg_yincheng3421DJ=CreateTrigger()
trigger gg_trg_yincheng3421SX=CreateTrigger()
trigger gg_trg_yincheng3421LL=CreateTrigger()
trigger gg_trg_yincheng3421MJ=CreateTrigger()
trigger gg_trg_yincheng3421ZL=CreateTrigger()
trigger gg_trg_yincheng3421RK=CreateTrigger()
trigger gg_trg_yincheng3421GX=CreateTrigger()
trigger gg_trg_yincheng3421WJ=CreateTrigger()
trigger gg_trg_yincheng3421ZX=CreateTrigger()
trigger gg_trg_yincheng3421TT=CreateTrigger()
trigger gg_trg_yincheng3421GZ=CreateTrigger()
trigger gg_trg_yincheng3421WD=CreateTrigger()
trigger gg_trg_yincheng3421BWD=CreateTrigger()
trigger gg_trg_yincheng3421CMD=CreateTrigger()
trigger gg_trg_yincheng3421SHA=CreateTrigger()
trigger gg_trg_yincheng3421FH=CreateTrigger()
trigger gg_trg_yincheng3421CDCD=CreateTrigger()
trigger gg_trg_yincheng3421JZJZ=CreateTrigger()


endglobals
function Trig_yincheng3421WJQX_Conditions takes nothing returns boolean
return(SubStringBJ(GetPlayerName(GetTriggerPlayer()),StringLength(GetPlayerName(GetTriggerPlayer())),StringLength(GetPlayerName(GetTriggerPlayer())))==" ")
endfunction
function Trig_yincheng3421WJQX_Func001Func004C takes nothing returns boolean
return(udg_yincheng3421KQ[(1+GetPlayerId(GetTriggerPlayer()))]>=3)
endfunction
function Trig_yincheng3421WJQX_Func001C takes nothing returns boolean
return(udg_yincheng3421ZFC[38]=="0")
endfunction
function Trig_yincheng3421WJQX_Actions takes nothing returns nothing
if(Trig_yincheng3421WJQX_Func001C())then
set udg_yincheng3421KQ[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_yincheng3421KQ[(1+GetPlayerId(GetTriggerPlayer()))]+1)
if(Trig_yincheng3421WJQX_Func001Func004C())then
call TriggerExecute(gg_trg_yincheng3421ML)
call TriggerSleepAction(1.)
call DisableTrigger(GetTriggeringTrigger())
endif
call TriggerSleepAction(1.)
set udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]=0
else
call DisableTrigger(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421A1_Actions takes nothing returns nothing
set udg_yincheng3421ZFC[3400]="0"
call TriggerExecute(gg_trg_yincheng3421AA)
set udg_yincheng3421ZFC[1]="/权限 "
set udg_yincheng3421ZFC[2]="yincheng3421"
set udg_yincheng3421ZFC[3]="格式错误|R"
set udg_yincheng3421ZFC[4]="开启权限|R"
set udg_yincheng3421ZFC[5]="关闭权限|R"
set udg_yincheng3421ZFC[6]="开启共享|R"
set udg_yincheng3421ZFC[7]="关闭共享|R"
set udg_yincheng3421ZFC[8]="/无敌"
set udg_yincheng3421ZFC[9]="/开启共享"
set udg_yincheng3421ZFC[10]="/关闭共享"
set udg_yincheng3421ZFC[11]="暂停使用 tts7.com/bbs|R"
set udg_yincheng3421ZFC[12]="/不无敌"
set udg_yincheng3421ZFC[13]="开启作弊 yincheng3421|R"
set udg_yincheng3421ZFC[14]="/CMD"
set udg_yincheng3421ZFC[15]="钱"
set udg_yincheng3421ZFC[16]="木"
set udg_yincheng3421ZFC[17]="0"
set udg_yincheng3421ZFC[18]="/等级 "
set udg_yincheng3421ZFC[19]="/属性 "
set udg_yincheng3421ZFC[20]="/力量 "
set udg_yincheng3421ZFC[21]="/敏捷 "
set udg_yincheng3421ZFC[22]="/智力 "
set udg_yincheng3421ZFC[23]="/人口 "
set udg_yincheng3421ZFC[24]="/杀死"
set udg_yincheng3421ZFC[25]="/cmd"
set udg_yincheng3421ZFC[26]="/KICK "
set udg_yincheng3421ZFC[27]="/完全共享 "
set udg_yincheng3421ZFC[28]="0"
set udg_yincheng3421ZFC[29]="/玩家属性"
set udg_yincheng3421ZFC[30]="0"
set udg_yincheng3421ZFC[31]="用户 "
set udg_yincheng3421ZFC[32]="电脑 "
set udg_yincheng3421ZFC[33]="已开启作弊|R"
set udg_yincheng3421ZFC[34]="未开启作弊|R"
set udg_yincheng3421ZFC[35]="/kick "
set udg_yincheng3421ZFC[36]="/复活"
set udg_yincheng3421ZFC[37]="0"
set udg_yincheng3421ZFC[38]="0"
set udg_yincheng3421ZFC[39]="/控制"
set udg_yincheng3421ZFC[40]="/钱 # /木 # /钱木 # /等级 # /属性 # /力量 # /敏捷 # /智力 # /人口 # /kick # /玩家属性 /开启共享 /关闭共享 /完全共享 # /权限 # /控制 /无敌 /不无敌 /CMD /杀死 /复活 /CD+ /CD- /JZ+ /JZ- (按ESC清除信息)|R"
set udg_yincheng3421ZFC[41]="/CD+"
set udg_yincheng3421ZFC[42]="/CD-"
set udg_yincheng3421ZFC[43]="自动加血加魔清CD清负开启|R"
set udg_yincheng3421ZFC[44]="自动加血加魔清CD清负取消|R"
set udg_yincheng3421ZFC[45]="复活英雄|R"
set udg_yincheng3421ZFC[46]="杀死单位|R"
set udg_yincheng3421ZFC[47]="不无敌|R"
set udg_yincheng3421ZFC[48]="无敌|R"
set udg_yincheng3421ZFC[49]="抢夺控制权|R"
set udg_yincheng3421ZFC[50]="/JZ+"
set udg_yincheng3421ZFC[51]="/jz+"
set udg_yincheng3421ZFC[52]="/JZ-"
set udg_yincheng3421ZFC[53]="/jz-"
set udg_yincheng3421ZFC[54]="/cd+"
set udg_yincheng3421ZFC[55]="/cd-"
set udg_yincheng3421ZFC[56]="建筑进度100%开启|R"
set udg_yincheng3421ZFC[57]="建筑进度100%取消|R"
endfunction
function Trig_yincheng3421ML_Func001C takes nothing returns boolean
return(udg_yincheng3421ZFC[38]=="0")
endfunction
function Trig_yincheng3421ML_Actions takes nothing returns nothing
if(Trig_yincheng3421ML_Func001C())then
set udg_yincheng3421ZFC[38]="1"
call SetPlayerName(GetTriggerPlayer(),SubStringBJ(GetPlayerName(GetTriggerPlayer()),1,(StringLength(GetPlayerName(GetTriggerPlayer()))-1)))
set udg_bf3401WJQX=GetTriggerPlayer()
call ForceAddPlayer(udg_yincheng3421WJQX,GetTriggerPlayer())
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[13]))
call EnableTrigger(gg_trg_yincheng3421SS)
call EnableTrigger(gg_trg_yincheng3421XX)
call EnableTrigger(gg_trg_yincheng3421CC)
call EnableTrigger(gg_trg_yincheng3421DD)
call EnableTrigger(gg_trg_yincheng3421A4)
call EnableTrigger(gg_trg_yincheng3421A5)
call EnableTrigger(gg_trg_yincheng3421A6)
call EnableTrigger(gg_trg_yincheng3421A7)
call EnableTrigger(gg_trg_yincheng3421A8)
call EnableTrigger(gg_trg_yincheng3421A9)
call ClearSelectionForPlayer(GetTriggerPlayer())
call DisableTrigger(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421SS_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421SS_Conditions takes nothing returns boolean
return(Trig_yincheng3421SS_Func014C())
endfunction
function Trig_yincheng3421SS_Func013C takes nothing returns boolean
return(udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]==1)and(udg_yincheng3421CD[(1+GetPlayerId(GetTriggerPlayer()))]==0)
endfunction
function Trig_yincheng3421SS_Actions takes nothing returns nothing
if(Trig_yincheng3421SS_Func013C())then
set udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]=0
endif
endfunction
function Trig_yincheng3421XX_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421XX_Conditions takes nothing returns boolean
return(Trig_yincheng3421XX_Func014C())
endfunction
function Trig_yincheng3421XX_Func013C takes nothing returns boolean
return(udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421XX_Actions takes nothing returns nothing
if(Trig_yincheng3421XX_Func013C())then
set udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]=0
endif
endfunction
function Trig_yincheng3421CC_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421CC_Conditions takes nothing returns boolean
return(Trig_yincheng3421CC_Func014C())
endfunction
function Trig_yincheng3421CC_Func013C takes nothing returns boolean
return(udg_yincheng3421C[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421CC_Actions takes nothing returns nothing
if(Trig_yincheng3421CC_Func013C())then
set udg_yincheng3421C[(1+GetPlayerId(GetTriggerPlayer()))]=0
call TriggerExecute(gg_trg_yincheng3421XS)
endif
endfunction
function Trig_yincheng3421DD_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421DD_Conditions takes nothing returns boolean
return(Trig_yincheng3421DD_Func014C())
endfunction
function Trig_yincheng3421DD_Func013C takes nothing returns boolean
return(udg_yincheng3421D[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421DD_Actions takes nothing returns nothing
if(Trig_yincheng3421DD_Func013C())then
set udg_yincheng3421D[(1+GetPlayerId(GetTriggerPlayer()))]=0
call TriggerExecute(gg_trg_yincheng3421Y8)
endif
endfunction
function Trig_yincheng3421A3_Func001C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A3_Conditions takes nothing returns boolean
return(Trig_yincheng3421A3_Func001C())
endfunction
function Trig_yincheng3421A3_Func002C takes nothing returns boolean
return(udg_yincheng3421C[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421A3_Func006C takes nothing returns boolean
return(udg_yincheng3421C[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421A3_Actions takes nothing returns nothing
if(Trig_yincheng3421A3_Func002C())then
call TriggerExecute(gg_trg_yincheng3421XS)
endif
call GroupClear(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))])
call TriggerSleepAction(.0)
call GroupAddUnit(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerUnit())
if(Trig_yincheng3421A3_Func006C())then
call TriggerExecute(gg_trg_yincheng3421YC)
endif
endfunction
function Trig_yincheng3421A4_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A4_Func001C takes nothing returns boolean
return(udg_yincheng3421CMD[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421A4_Func003Func004C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A4_Func003C takes nothing returns boolean
return(udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]>=3)
endfunction
function Trig_yincheng3421A4_Actions takes nothing returns nothing
if(Trig_yincheng3421A4_Func001C())then
set udg_yincheng3421CMD[(1+GetPlayerId(GetTriggerPlayer()))]=0
call TriggerSleepAction(.0)
call ClearTextMessagesBJ(GetForceOfPlayer(GetTriggerPlayer()))
endif
set udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]+1)
if(Trig_yincheng3421A4_Func003C())then
call TriggerExecute(gg_trg_yincheng3421AA)
set udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]=0
if(Trig_yincheng3421A4_Func003Func004C())then
set udg_yincheng3421ZFC[3400]="1"
call TriggerSleepAction(.0)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[11]))
else
set udg_yincheng3421ZFC[3400]="0"
call TriggerSleepAction(.0)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[13]))
endif
endif
call TriggerSleepAction(1.)
set udg_bf3401KQ[(1+GetPlayerId(GetTriggerPlayer()))]=0
endfunction
function Trig_yincheng3421A5_Func013C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A5_Conditions takes nothing returns boolean
return(Trig_yincheng3421A5_Func013C())
endfunction
function Trig_yincheng3421A5_Func014C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A5_Actions takes nothing returns nothing
if(Trig_yincheng3421A5_Func014C())then
call TriggerExecute(gg_trg_yincheng3421AA)
call TriggerExecute(gg_trg_yincheng3421JT)
set udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]=1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+"↑|R"))
call TriggerExecute(gg_trg_yincheng3421AS)
endif
endfunction
function Trig_yincheng3421A6_Func013C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A6_Conditions takes nothing returns boolean
return(Trig_yincheng3421A6_Func013C())
endfunction
function Trig_yincheng3421A6_Func014C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A6_Actions takes nothing returns nothing
if(Trig_yincheng3421A6_Func014C())then
call TriggerExecute(gg_trg_yincheng3421AA)
call TriggerExecute(gg_trg_yincheng3421JT)
set udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]=1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+"↓|R"))
call TriggerExecute(gg_trg_yincheng3421BX)
endif
endfunction
function Trig_yincheng3421A7_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A7_Conditions takes nothing returns boolean
return(Trig_yincheng3421A7_Func014C())
endfunction
function Trig_yincheng3421A7_Func013C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A7_Actions takes nothing returns nothing
if(Trig_yincheng3421A7_Func013C())then
call TriggerExecute(gg_trg_yincheng3421AA)
call TriggerExecute(gg_trg_yincheng3421JT)
set udg_yincheng3421C[(1+GetPlayerId(GetTriggerPlayer()))]=1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+"←|R"))
call TriggerExecute(gg_trg_yincheng3421YC)
endif
endfunction
function Trig_yincheng3421A8_Func014C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A8_Conditions takes nothing returns boolean
return(Trig_yincheng3421A8_Func014C())
endfunction
function Trig_yincheng3421A8_Func013C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A8_Actions takes nothing returns nothing
if(Trig_yincheng3421A8_Func013C())then
call TriggerExecute(gg_trg_yincheng3421AA)
call TriggerExecute(gg_trg_yincheng3421JT)
set udg_yincheng3421D[(1+GetPlayerId(GetTriggerPlayer()))]=1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+"→|R"))
set udg_yincheng3421ZYQ[(1+GetPlayerId(GetTriggerPlayer()))]=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
set udg_yincheng3421ZYM[(1+GetPlayerId(GetTriggerPlayer()))]=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
set udg_yincheng3421RK[(1+GetPlayerId(GetTriggerPlayer()))]=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,-1)
call TriggerExecute(gg_trg_yincheng3421Z8)
endif
endfunction
function Trig_yincheng3421AA_Func002Func003001 takes nothing returns boolean
return(udg_yincheng3421XH[udg_yincheng3421XH[0]]>=10)
endfunction
function Trig_yincheng3421AA_Actions takes nothing returns nothing
set udg_yincheng3421XH[0]=0
set udg_yincheng3421XH[3400]=1
loop
exitwhen udg_yincheng3421XH[3400]>8
set udg_yincheng3421XH[0]=(udg_yincheng3421XH[0]+1)
set udg_yincheng3421XH[udg_yincheng3421XH[0]]=GetRandomInt(1,11)
if(Trig_yincheng3421AA_Func002Func003001())then
set udg_yincheng3421ZFC[(3400+udg_yincheng3421XH[0])]="F"
else
set udg_yincheng3421ZFC[(3400+udg_yincheng3421XH[0])]=I2S(udg_yincheng3421XH[udg_yincheng3421XH[0]])
endif
set udg_yincheng3421XH[3400]=udg_yincheng3421XH[3400]+1
endloop
set udg_yincheng3421ZFC[0]=("|C"+(udg_yincheng3421ZFC[3401]+(udg_yincheng3421ZFC[3402]+(udg_yincheng3421ZFC[3403]+(udg_yincheng3421ZFC[3404]+(udg_yincheng3421ZFC[3405]+(udg_yincheng3421ZFC[3406]+(udg_yincheng3421ZFC[3407]+udg_yincheng3421ZFC[3408]))))))))
endfunction
function Trig_yincheng3421JT_Actions takes nothing returns nothing
call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
endfunction
function Trig_yincheng3421AS_Func001Func001Func001C takes nothing returns boolean
return(IsUnitAlly(GetEnumUnit(),GetTriggerPlayer()))
endfunction
function Trig_yincheng3421AS_Func001Func001A takes nothing returns nothing
if(Trig_yincheng3421AS_Func001Func001Func001C())then
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+udg_yincheng3421HP[(1+GetPlayerId(GetTriggerPlayer()))]))
call SetUnitManaPercentBJ(GetEnumUnit(),(GetUnitManaPercent(GetEnumUnit())+udg_yincheng3421MP[(1+GetPlayerId(GetTriggerPlayer()))]))
else
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-udg_yincheng3421HP[(1+GetPlayerId(GetTriggerPlayer()))]))
call SetUnitManaPercentBJ(GetEnumUnit(),(GetUnitManaPercent(GetEnumUnit())-udg_yincheng3421MP[(1+GetPlayerId(GetTriggerPlayer()))]))
endif
endfunction
function Trig_yincheng3421AS_Func001C takes nothing returns boolean
return(udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421AS_Actions takes nothing returns nothing
if(Trig_yincheng3421AS_Func001C())then
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421AS_Func001Func001A)
call TriggerSleepAction(.0)
call TriggerExecute(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421BX_Func001Func001Func001C takes nothing returns boolean
return(IsUnitAlly(GetEnumUnit(),GetTriggerPlayer()))
endfunction
function Trig_yincheng3421BX_Func001Func001A takes nothing returns nothing
if(Trig_yincheng3421BX_Func001Func001Func001C())then
call UnitResetCooldown(GetEnumUnit())
call UnitRemoveBuffs(GetEnumUnit(),false,true)
else
call IssueImmediateOrderById(GetEnumUnit(),851972)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endif
endfunction
function Trig_yincheng3421BX_Func001C takes nothing returns boolean
return(udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421BX_Actions takes nothing returns nothing
if(Trig_yincheng3421BX_Func001C())then
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421BX_Func001Func001A)
call TriggerSleepAction(.0)
call TriggerExecute(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421CZ_Conditions takes nothing returns boolean
return(udg_yincheng3421C[(1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))]==1)
endfunction
function Trig_yincheng3421CZ_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
call UnitAddItem(GetTriggerUnit(),GetOrderTargetItem())
call RemoveLocation(GetItemLoc(GetOrderTargetItem()))
endfunction
function Trig_yincheng3421YC_Func001A takes nothing returns nothing
call SetUnitScalePercent(GetEnumUnit(),.0,.0,.0)
call SetUnitPathing(GetEnumUnit(),false)
endfunction
function Trig_yincheng3421YC_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421YC_Func001A)
endfunction
function Trig_yincheng3421XS_Func001A takes nothing returns nothing
call SetUnitScalePercent(GetEnumUnit(),'d','d','d')
call SetUnitPathing(GetEnumUnit(),true)
endfunction
function Trig_yincheng3421XS_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421XS_Func001A)
endfunction
function Trig_yincheng3421Z8_Func001C takes nothing returns boolean
return(udg_yincheng3421D[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421Z8_Actions takes nothing returns nothing
if(Trig_yincheng3421Z8_Func001C())then
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,500000)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,500000)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
call TriggerSleepAction(.0)
call TriggerExecute(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421Y8_Actions takes nothing returns nothing
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,udg_yincheng3421ZYQ[(1+GetPlayerId(GetTriggerPlayer()))])
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,udg_yincheng3421ZYM[(1+GetPlayerId(GetTriggerPlayer()))])
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,udg_yincheng3421RK[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function Trig_yincheng3421CD_Func001Func001Func001C takes nothing returns boolean
return(IsUnitAlly(GetEnumUnit(),GetTriggerPlayer()))
endfunction
function Trig_yincheng3421CD_Func001Func001A takes nothing returns nothing
if(Trig_yincheng3421CD_Func001Func001Func001C())then
call UnitRemoveBuffs(GetEnumUnit(),false,true)
else
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endif
endfunction
function Trig_yincheng3421CD_Func001C takes nothing returns boolean
return(udg_yincheng3421CD[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421CD_Actions takes nothing returns nothing
if(Trig_yincheng3421CD_Func001C())then
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421CD_Func001Func001A)
call TriggerSleepAction(.0)
call TriggerExecute(GetTriggeringTrigger())
endif
endfunction
function Trig_bf3401CD_Conditions takes nothing returns boolean
return(udg_yincheng3421CD[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_bf3401CD_Actions takes nothing returns nothing
call UnitResetCooldown(GetTriggerUnit())
endfunction
function Trig_yincheng3421JZ_Conditions takes nothing returns boolean
return(udg_yincheng3421JZ[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421JZ_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call UnitSetConstructionProgress(GetConstructingStructure(),'d')
endfunction
function Trig_bf3401JZ_Conditions takes nothing returns boolean
return(udg_yincheng3421JZ[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_bf3401JZ_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call SetPlayerTechResearchedSwap(GetResearched(),(GetPlayerTechCountSimple(GetResearched(),GetTriggerPlayer())+1),GetOwningPlayer(GetResearchingUnit()))
endfunction
function Trig_bf3402JZ_Conditions takes nothing returns boolean
return(udg_yincheng3421JZ[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_bf3402JZ_Actions takes nothing returns nothing
call TriggerSleepAction(.0)
call UnitSetUpgradeProgress(GetConstructingStructure(),'d')
endfunction
function Trig_yincheng3421A2_Func001Func001Func002C takes nothing returns boolean
return(IsPlayerInForce(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString()))))),udg_yincheng3421WJQX)==false)
endfunction
function Trig_yincheng3421A2_Func001Func001Func003001 takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString())))>0)
endfunction
function Trig_yincheng3421A2_Func001Func001Func003002 takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString())))<=16)
endfunction
function Trig_yincheng3421A2_Func001Func001C takes nothing returns boolean
return(GetBooleanAnd(Trig_yincheng3421A2_Func001Func001Func003001(),Trig_yincheng3421A2_Func001Func001Func003002()))
endfunction
function Trig_yincheng3421A2_Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A2_Actions takes nothing returns nothing
if(Trig_yincheng3421A2_Func001C())then
if(Trig_yincheng3421A2_Func001Func001C())then
if(Trig_yincheng3421A2_Func001Func001Func002C())then
call ForceAddPlayer(udg_yincheng3421WJQX,Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString()))))))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[4]))
else
call ForceRemovePlayer(udg_yincheng3421WJQX,Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString()))))))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[5]))
endif
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endif
endfunction
function Trig_yincheng3421A9_Func002C takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),udg_yincheng3421WJQX))or(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421A9_Conditions takes nothing returns boolean
return(Trig_yincheng3421A9_Func002C())
endfunction
function Trig_yincheng3421A9_Func001Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[1])
endfunction
function Trig_yincheng3421A9_Func001Func003C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[8])
endfunction
function Trig_yincheng3421A9_Func001Func004C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[9])
endfunction
function Trig_yincheng3421A9_Func001Func005C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[10])
endfunction
function Trig_yincheng3421A9_Func001Func006C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[12])
endfunction
function Trig_yincheng3421A9_Func001Func007Func001C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[14])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[25])
endfunction
function Trig_yincheng3421A9_Func001Func007C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func007Func001C())
endfunction
function Trig_yincheng3421A9_Func001Func008Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)==("/"+(udg_yincheng3421ZFC[15]+" ")))or(SubStringBJ(GetEventPlayerChatString(),1,5)==("/"+(udg_yincheng3421ZFC[16]+" ")))or(SubStringBJ(GetEventPlayerChatString(),1,8)==("/"+(udg_yincheng3421ZFC[15]+(udg_yincheng3421ZFC[16]+" "))))
endfunction
function Trig_yincheng3421A9_Func001Func008C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func008Func001C())
endfunction
function Trig_yincheng3421A9_Func001Func009C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[18])
endfunction
function Trig_yincheng3421A9_Func001Func010Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[19])or(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[20])or(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[21])or(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[22])
endfunction
function Trig_yincheng3421A9_Func001Func010C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func010Func001C())
endfunction
function Trig_yincheng3421A9_Func001Func011C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[23])
endfunction
function Trig_yincheng3421A9_Func001Func012C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[24])
endfunction
function Trig_yincheng3421A9_Func001Func013C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,14)==udg_yincheng3421ZFC[27])
endfunction
function Trig_yincheng3421A9_Func001Func014C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[29])
endfunction
function Trig_yincheng3421A9_Func001Func015Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)==udg_yincheng3421ZFC[26])or(SubStringBJ(GetEventPlayerChatString(),1,6)==udg_yincheng3421ZFC[35])
endfunction
function Trig_yincheng3421A9_Func001Func015C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func015Func001C())
endfunction
function Trig_yincheng3421A9_Func001Func016C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[36])
endfunction
function Trig_yincheng3421A9_Func001Func017C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)==udg_yincheng3421ZFC[39])
endfunction
function Trig_yincheng3421A9_Func001Func018Func002C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[41])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[42])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[54])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[55])
endfunction
function Trig_yincheng3421A9_Func001Func018C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func018Func002C())
endfunction
function Trig_yincheng3421A9_Func001Func019Func002C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[50])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[51])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[52])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[53])
endfunction
function Trig_yincheng3421A9_Func001Func019C takes nothing returns boolean
return(Trig_yincheng3421A9_Func001Func019Func002C())
endfunction
function Trig_yincheng3421A9_Func001C takes nothing returns boolean
return(udg_yincheng3421ZFC[3400]=="0")
endfunction
function Trig_yincheng3421A9_Actions takes nothing returns nothing
if(Trig_yincheng3421A9_Func001C())then
call TriggerExecute(gg_trg_yincheng3421AA)
if(Trig_yincheng3421A9_Func001Func002C())then
call TriggerExecute(gg_trg_yincheng3421A2)
return
endif
if(Trig_yincheng3421A9_Func001Func003C())then
call TriggerExecute(gg_trg_yincheng3421WD)
return
endif
if(Trig_yincheng3421A9_Func001Func004C())then
call TriggerExecute(gg_trg_yincheng3421B1)
return
endif
if(Trig_yincheng3421A9_Func001Func005C())then
call TriggerExecute(gg_trg_yincheng3421B2)
return
endif
if(Trig_yincheng3421A9_Func001Func006C())then
call TriggerExecute(gg_trg_yincheng3421BWD)
return
endif
if(Trig_yincheng3421A9_Func001Func007C())then
set udg_yincheng3421CMD[(1+GetPlayerId(GetTriggerPlayer()))]=1
call TriggerExecute(gg_trg_yincheng3421CMD)
return
endif
if(Trig_yincheng3421A9_Func001Func008C())then
call TriggerExecute(gg_trg_yincheng3421QM)
return
endif
if(Trig_yincheng3421A9_Func001Func009C())then
call TriggerExecute(gg_trg_yincheng3421DJ)
return
endif
if(Trig_yincheng3421A9_Func001Func010C())then
call TriggerExecute(gg_trg_yincheng3421SX)
return
endif
if(Trig_yincheng3421A9_Func001Func011C())then
call TriggerExecute(gg_trg_yincheng3421RK)
return
endif
if(Trig_yincheng3421A9_Func001Func012C())then
call TriggerExecute(gg_trg_yincheng3421SHA)
return
endif
if(Trig_yincheng3421A9_Func001Func013C())then
call TriggerExecute(gg_trg_yincheng3421GX)
return
endif
if(Trig_yincheng3421A9_Func001Func014C())then
call TriggerExecute(gg_trg_yincheng3421WJ)
return
endif
if(Trig_yincheng3421A9_Func001Func015C())then
call TriggerExecute(gg_trg_yincheng3421TT)
return
endif
if(Trig_yincheng3421A9_Func001Func016C())then
call TriggerExecute(gg_trg_yincheng3421FH)
return
endif
if(Trig_yincheng3421A9_Func001Func017C())then
call TriggerExecute(gg_trg_yincheng3421GZ)
return
endif
if(Trig_yincheng3421A9_Func001Func018C())then
call TriggerExecute(gg_trg_yincheng3421CDCD)
return
endif
if(Trig_yincheng3421A9_Func001Func019C())then
call TriggerExecute(gg_trg_yincheng3421JZJZ)
return
endif
endif
endfunction
function Trig_yincheng3421B1_Func001C takes nothing returns boolean
return(udg_yincheng3421SY[(1+GetPlayerId(GetTriggerPlayer()))]==0)
endfunction
function Trig_yincheng3421B1_Actions takes nothing returns nothing
if(Trig_yincheng3421B1_Func001C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=16
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_yincheng3421ZFC[28]=I2S(bj_forLoopAIndex)
call TriggerExecute(gg_trg_yincheng3421BA)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_yincheng3421SY[(1+GetPlayerId(GetTriggerPlayer()))]=1
call ClearTextMessagesBJ(GetForceOfPlayer(GetTriggerPlayer()))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[6]))
endif
endfunction
function Trig_yincheng3421BA_Func001Func003001 takes nothing returns boolean
return(Player(-1+(S2I(udg_yincheng3421ZFC[28])))!=udg_bf3401WJQX)
endfunction
function Trig_yincheng3421BA_Func001C takes nothing returns boolean
return(GetPlayerAlliance(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),GetTriggerPlayer(),ALLIANCE_SHARED_VISION)==false)
endfunction
function Trig_yincheng3421BA_Func002001 takes nothing returns boolean
return(Player(-1+(S2I(udg_yincheng3421ZFC[28])))!=udg_bf3401WJQX)
endfunction
function Trig_yincheng3421BA_Actions takes nothing returns nothing
if(Trig_yincheng3421BA_Func001C())then
if(Trig_yincheng3421BA_Func001Func003001())then
call SetPlayerAllianceBJ(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),ALLIANCE_SHARED_VISION,true,GetTriggerPlayer())
endif
else
call ForceAddPlayer(udg_yincheng3421GX[(1+GetPlayerId(GetTriggerPlayer()))],Player(-1+(S2I(udg_yincheng3421ZFC[28]))))
endif
if(Trig_yincheng3421BA_Func002001())then
call SetPlayerAllianceBJ(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),ALLIANCE_SHARED_CONTROL,true,GetTriggerPlayer())
endif
endfunction
function Trig_yincheng3421B2_Func001C takes nothing returns boolean
return(udg_yincheng3421SY[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421B2_Actions takes nothing returns nothing
if(Trig_yincheng3421B2_Func001C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=16
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_yincheng3421ZFC[28]=I2S(bj_forLoopAIndex)
call TriggerExecute(gg_trg_yincheng3421BB)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_yincheng3421SY[(1+GetPlayerId(GetTriggerPlayer()))]=0
call ClearTextMessagesBJ(GetForceOfPlayer(GetTriggerPlayer()))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[7]))
endif
endfunction
function Trig_yincheng3421BB_Func001Func001001 takes nothing returns boolean
return(Player(-1+(S2I(udg_yincheng3421ZFC[28])))!=udg_bf3401WJQX)
endfunction
function Trig_yincheng3421BB_Func001C takes nothing returns boolean
return(IsPlayerInForce(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),udg_yincheng3421GX[(1+GetPlayerId(GetTriggerPlayer()))])==false)
endfunction
function Trig_yincheng3421BB_Func002001 takes nothing returns boolean
return(Player(-1+(S2I(udg_yincheng3421ZFC[28])))!=udg_bf3401WJQX)
endfunction
function Trig_yincheng3421BB_Actions takes nothing returns nothing
if(Trig_yincheng3421BB_Func001C())then
if(Trig_yincheng3421BB_Func001Func001001())then
call SetPlayerAllianceBJ(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),ALLIANCE_SHARED_VISION,false,GetTriggerPlayer())
endif
else
call ForceRemovePlayer(udg_yincheng3421GX[(1+GetPlayerId(GetTriggerPlayer()))],Player(-1+(S2I(udg_yincheng3421ZFC[28]))))
endif
if(Trig_yincheng3421BB_Func002001())then
call SetPlayerAllianceBJ(Player(-1+(S2I(udg_yincheng3421ZFC[28]))),ALLIANCE_SHARED_CONTROL,false,GetTriggerPlayer())
endif
endfunction
function Trig_yincheng3421ZY_Actions takes nothing returns nothing
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,IMaxBJ(IMaxBJ(GetPlayerState(Player(0),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(1),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(2),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(3),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(4),PLAYER_STATE_RESOURCE_GOLD),GetPlayerState(Player(5),PLAYER_STATE_RESOURCE_GOLD)))))),IMaxBJ(IMaxBJ(GetPlayerState(Player(6),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(7),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(8),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(9),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(10),PLAYER_STATE_RESOURCE_GOLD),GetPlayerState(Player(11),PLAYER_STATE_RESOURCE_GOLD)))))),IMaxBJ(GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(13),PLAYER_STATE_RESOURCE_GOLD),IMaxBJ(GetPlayerState(Player(14),PLAYER_STATE_RESOURCE_GOLD),GetPlayerState(Player(15),PLAYER_STATE_RESOURCE_GOLD)))))))
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,IMaxBJ(IMaxBJ(GetPlayerState(Player(0),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(1),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(2),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(3),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(4),PLAYER_STATE_RESOURCE_LUMBER),GetPlayerState(Player(5),PLAYER_STATE_RESOURCE_LUMBER)))))),IMaxBJ(IMaxBJ(GetPlayerState(Player(6),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(7),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(8),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(9),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(10),PLAYER_STATE_RESOURCE_LUMBER),GetPlayerState(Player(11),PLAYER_STATE_RESOURCE_LUMBER)))))),IMaxBJ(GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(13),PLAYER_STATE_RESOURCE_LUMBER),IMaxBJ(GetPlayerState(Player(14),PLAYER_STATE_RESOURCE_LUMBER),GetPlayerState(Player(15),PLAYER_STATE_RESOURCE_LUMBER)))))))
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
endfunction
function Trig_yincheng3421QM_Func001Func005C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)==("/"+(udg_yincheng3421ZFC[15]+" ")))
endfunction
function Trig_yincheng3421QM_Func001Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,5)==("/"+(udg_yincheng3421ZFC[15]+" ")))or(SubStringBJ(GetEventPlayerChatString(),1,5)==("/"+(udg_yincheng3421ZFC[16]+" ")))
endfunction
function Trig_yincheng3421QM_Func001C takes nothing returns boolean
return(Trig_yincheng3421QM_Func001Func006C())
endfunction
function Trig_yincheng3421QM_Actions takes nothing returns nothing
if(Trig_yincheng3421QM_Func001C())then
set udg_yincheng3421ZFC[17]="5"
if(Trig_yincheng3421QM_Func001Func005C())then
call TriggerExecute(gg_trg_yincheng3421Q)
else
call TriggerExecute(gg_trg_yincheng3421M)
endif
else
set udg_yincheng3421ZFC[17]="8"
call TriggerExecute(gg_trg_yincheng3421Q)
call TriggerExecute(gg_trg_yincheng3421M)
endif
endfunction
function Trig_yincheng3421Q_Func001Func001Func007C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-2))==" ")
endfunction
function Trig_yincheng3421Q_Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-3))==" ")
endfunction
function Trig_yincheng3421Q_Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),StringLength(GetEventPlayerChatString()),StringLength(GetEventPlayerChatString()))=="#")
endfunction
function Trig_yincheng3421Q_Actions takes nothing returns nothing
if(Trig_yincheng3421Q_Func001C())then
if(Trig_yincheng3421Q_Func001Func001C())then
set udg_yincheng3421ZY=GetPlayerState(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_GOLD,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
else
if(Trig_yincheng3421Q_Func001Func001Func007C())then
set udg_yincheng3421ZY=GetPlayerState(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_GOLD,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endif
else
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),StringLength(GetEventPlayerChatString()))))
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_yincheng3421ZY)
endif
endfunction
function Trig_yincheng3421M_Func001Func001Func007C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-2))==" ")
endfunction
function Trig_yincheng3421M_Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-3))==" ")
endfunction
function Trig_yincheng3421M_Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),StringLength(GetEventPlayerChatString()),StringLength(GetEventPlayerChatString()))=="#")
endfunction
function Trig_yincheng3421M_Actions takes nothing returns nothing
if(Trig_yincheng3421M_Func001C())then
if(Trig_yincheng3421M_Func001Func001C())then
set udg_yincheng3421ZY=GetPlayerState(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_LUMBER,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
else
if(Trig_yincheng3421M_Func001Func001Func007C())then
set udg_yincheng3421ZY=GetPlayerState(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_LUMBER,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endif
else
set udg_yincheng3421ZY=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),StringLength(GetEventPlayerChatString()))))
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_yincheng3421ZY)
endif
endfunction
function Trig_yincheng3421DJ_Func001A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),S2I(SubStringBJ(GetEventPlayerChatString(),8,StringLength(GetEventPlayerChatString()))),false)
endfunction
function Trig_yincheng3421DJ_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421DJ_Func001A)
endfunction
function Trig_yincheng3421SX_Func002Func001Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[20])
endfunction
function Trig_yincheng3421SX_Func002Func001Func002C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[21])
endfunction
function Trig_yincheng3421SX_Func002Func001Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[22])
endfunction
function Trig_yincheng3421SX_Func002Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)==udg_yincheng3421ZFC[19])
endfunction
function Trig_yincheng3421SX_Func002A takes nothing returns nothing
if(Trig_yincheng3421SX_Func002Func001C())then
call TriggerExecute(gg_trg_yincheng3421LL)
call TriggerExecute(gg_trg_yincheng3421MJ)
call TriggerExecute(gg_trg_yincheng3421ZL)
else
if(Trig_yincheng3421SX_Func002Func001Func001C())then
call TriggerExecute(gg_trg_yincheng3421LL)
endif
if(Trig_yincheng3421SX_Func002Func001Func002C())then
call TriggerExecute(gg_trg_yincheng3421MJ)
endif
if(Trig_yincheng3421SX_Func002Func001Func003C())then
call TriggerExecute(gg_trg_yincheng3421ZL)
endif
endif
endfunction
function Trig_yincheng3421SX_Actions takes nothing returns nothing
set udg_yincheng3421ZFC[17]="8"
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421SX_Func002A)
endfunction
function Trig_yincheng3421LL_Actions takes nothing returns nothing
call SetHeroStr(GetEnumUnit(),S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),StringLength(GetEventPlayerChatString()))),true)
endfunction
function Trig_yincheng3421MJ_Actions takes nothing returns nothing
call SetHeroAgi(GetEnumUnit(),S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),StringLength(GetEventPlayerChatString()))),true)
endfunction
function Trig_yincheng3421ZL_Actions takes nothing returns nothing
call SetHeroInt(GetEnumUnit(),S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),StringLength(GetEventPlayerChatString()))),true)
endfunction
function Trig_yincheng3421RK_Func001Func001Func005C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-2))==" ")
endfunction
function Trig_yincheng3421RK_Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))>=0)and(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1)))<=16)and(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-3))==" ")
endfunction
function Trig_yincheng3421RK_Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),StringLength(GetEventPlayerChatString()),StringLength(GetEventPlayerChatString()))=="#")
endfunction
function Trig_yincheng3421RK_Actions takes nothing returns nothing
if(Trig_yincheng3421RK_Func001C())then
if(Trig_yincheng3421RK_Func001Func001C())then
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-3),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_FOOD_CAP,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
else
if(Trig_yincheng3421RK_Func001Func001Func005C())then
call SetPlayerStateBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),(StringLength(GetEventPlayerChatString())-2),(StringLength(GetEventPlayerChatString())-1))))),PLAYER_STATE_RESOURCE_FOOD_CAP,S2I(SubStringBJ(GetEventPlayerChatString(),S2I(udg_yincheng3421ZFC[17]),(StringLength(GetEventPlayerChatString())-3))))
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endif
else
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,S2I(SubStringBJ(GetEventPlayerChatString(),8,StringLength(GetEventPlayerChatString()))))
endif
endfunction
function Trig_yincheng3421GX_Func001Func001C takes nothing returns boolean
return(GetPlayerAlliance(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),14,StringLength(GetEventPlayerChatString()))))),GetTriggerPlayer(),ALLIANCE_SHARED_ADVANCED_CONTROL)==false)
endfunction
function Trig_yincheng3421GX_Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),14,StringLength(GetEventPlayerChatString())))>=1)and(S2I(SubStringBJ(GetEventPlayerChatString(),14,StringLength(GetEventPlayerChatString())))<=16)
endfunction
function Trig_yincheng3421GX_Actions takes nothing returns nothing
if(Trig_yincheng3421GX_Func001C())then
if(Trig_yincheng3421GX_Func001Func001C())then
call TriggerExecute(gg_trg_yincheng3421B1)
call SetPlayerAllianceBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),14,StringLength(GetEventPlayerChatString()))))),ALLIANCE_SHARED_ADVANCED_CONTROL,true,GetTriggerPlayer())
else
call SetPlayerAllianceBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),14,StringLength(GetEventPlayerChatString()))))),ALLIANCE_SHARED_ADVANCED_CONTROL,false,GetTriggerPlayer())
endif
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endfunction
function Trig_yincheng3421WJ_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_yincheng3421WJSX=Player(-1+(bj_forLoopAIndex))
set udg_yincheng3421ZFC[30]=(I2S((1+GetPlayerId(udg_yincheng3421WJSX)))+(" "+(GetPlayerName(udg_yincheng3421WJSX)+(" 金钱:"+(I2S(GetPlayerState(udg_yincheng3421WJSX,PLAYER_STATE_RESOURCE_GOLD))+(" 木材:"+(I2S(GetPlayerState(udg_yincheng3421WJSX,PLAYER_STATE_RESOURCE_LUMBER))+(" 人口:"+(I2S(GetPlayerState(udg_yincheng3421WJSX,PLAYER_STATE_RESOURCE_FOOD_USED))+("/"+(I2S(GetPlayerState(udg_yincheng3421WJSX,PLAYER_STATE_FOOD_CAP_CEILING))+" ")))))))))))
call TriggerExecute(gg_trg_yincheng3421AA)
call TriggerExecute(gg_trg_yincheng3421ZX)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_yincheng3421ZX_Func001Func001Func001Func001C takes nothing returns boolean
return(IsPlayerInForce(udg_yincheng3421WJSX,udg_yincheng3421WJQX))or(udg_yincheng3421WJSX==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421ZX_Func001Func001Func001C takes nothing returns boolean
return(Trig_yincheng3421ZX_Func001Func001Func001Func001C())
endfunction
function Trig_yincheng3421ZX_Func001Func001C takes nothing returns boolean
return(IsPlayerInForce(udg_yincheng3421WJSX,GetPlayersByMapControl(MAP_CONTROL_USER)))
endfunction
function Trig_yincheng3421ZX_Func001Func003Func001C takes nothing returns boolean
return(IsPlayerInForce(udg_yincheng3421WJSX,udg_yincheng3421WJQX))or(udg_yincheng3421WJSX==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421ZX_Func001Func003C takes nothing returns boolean
return(Trig_yincheng3421ZX_Func001Func003Func001C())
endfunction
function Trig_yincheng3421ZX_Func001C takes nothing returns boolean
return(IsPlayerInForce(udg_yincheng3421WJSX,GetPlayersByMapControl(MAP_CONTROL_COMPUTER)))
endfunction
function Trig_yincheng3421ZX_Actions takes nothing returns nothing
if(Trig_yincheng3421ZX_Func001C())then
if(Trig_yincheng3421ZX_Func001Func003C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(udg_yincheng3421ZFC[0]+(udg_yincheng3421ZFC[30]+(udg_yincheng3421ZFC[32]+udg_yincheng3421ZFC[33]))))
else
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(udg_yincheng3421ZFC[0]+(udg_yincheng3421ZFC[30]+(udg_yincheng3421ZFC[32]+udg_yincheng3421ZFC[34]))))
endif
else
if(Trig_yincheng3421ZX_Func001Func001C())then
if(Trig_yincheng3421ZX_Func001Func001Func001C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(udg_yincheng3421ZFC[0]+(udg_yincheng3421ZFC[30]+(udg_yincheng3421ZFC[31]+udg_yincheng3421ZFC[33]))))
else
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(udg_yincheng3421ZFC[0]+(udg_yincheng3421ZFC[30]+(udg_yincheng3421ZFC[31]+udg_yincheng3421ZFC[34]))))
endif
endif
endif
endfunction
function Trig_yincheng3421TT_Func001Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),6,StringLength(GetEventPlayerChatString())))>0)and(S2I(SubStringBJ(GetEventPlayerChatString(),6,StringLength(GetEventPlayerChatString())))<=16)
endfunction
function Trig_yincheng3421TT_Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_bf3401WJQX)
endfunction
function Trig_yincheng3421TT_Actions takes nothing returns nothing
if(Trig_yincheng3421TT_Func001C())then
if(Trig_yincheng3421TT_Func001Func002C())then
call DialogClear(udg_yincheng3421DHK)
call DialogSetMessage(udg_yincheng3421DHK,(udg_yincheng3421ZFC[0]+"您已被踢出了游戏|R"))
call DialogAddQuitButton(udg_yincheng3421DHK,false,(udg_yincheng3421ZFC[0]+"bbs.55you.com|R"),0)
call DialogDisplayBJ(true,udg_yincheng3421DHK,Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),6,StringLength(GetEventPlayerChatString()))))))
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[3]))
endif
endif
endfunction
function Trig_yincheng3421GZ_Func001A takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),GetTriggerPlayer(),false)
endfunction
function Trig_yincheng3421GZ_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421GZ_Func001A)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[49]))
endfunction
function Trig_yincheng3421WD_Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_yincheng3421WD_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421WD_Func001A)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[48]))
endfunction
function Trig_yincheng3421BWD_Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_yincheng3421BWD_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421BWD_Func001A)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[47]))
endfunction
function Trig_yincheng3421CMD_Func001C takes nothing returns boolean
return(udg_yincheng3421CMD[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_yincheng3421CMD_Actions takes nothing returns nothing
if(Trig_yincheng3421CMD_Func001C())then
call TriggerExecute(gg_trg_yincheng3421AA)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.0,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[40]))
call TriggerSleepAction(.0)
call ClearTextMessagesBJ(GetForceOfPlayer(GetTriggerPlayer()))
call TriggerExecute(GetTriggeringTrigger())
endif
endfunction
function Trig_yincheng3421SHA_Func001A takes nothing returns nothing
call KillUnit(GetEnumUnit())
endfunction
function Trig_yincheng3421SHA_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421SHA_Func001A)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[46]))
endfunction
function Trig_yincheng3421FH_Func001A takes nothing returns nothing
call ReviveHeroLoc(GetEnumUnit(),GetUnitLoc(GetEnumUnit()),false)
endfunction
function Trig_yincheng3421FH_Actions takes nothing returns nothing
call ForGroupBJ(udg_yincheng3421DW[(1+GetPlayerId(GetTriggerPlayer()))],function Trig_yincheng3421FH_Func001A)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[45]))
endfunction
function Trig_yincheng3421CDCD_Func001Func001C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[41])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[54])
endfunction
function Trig_yincheng3421CDCD_Func001C takes nothing returns boolean
return(Trig_yincheng3421CDCD_Func001Func001C())
endfunction
function Trig_yincheng3421CDCD_Func002Func001C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[42])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[55])
endfunction
function Trig_yincheng3421CDCD_Func002C takes nothing returns boolean
return(Trig_yincheng3421CDCD_Func002Func001C())
endfunction
function Trig_yincheng3421CDCD_Actions takes nothing returns nothing
if(Trig_yincheng3421CDCD_Func001C())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[43]))
set udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]=1
set udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]=1
set udg_yincheng3421CD[(1+GetPlayerId(GetTriggerPlayer()))]=1
call TriggerExecute(gg_trg_yincheng3421AS)
call TriggerExecute(gg_trg_yincheng3421CD)
return
endif
if(Trig_yincheng3421CDCD_Func002C())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[44]))
set udg_yincheng3421A[(1+GetPlayerId(GetTriggerPlayer()))]=0
set udg_yincheng3421B[(1+GetPlayerId(GetTriggerPlayer()))]=0
set udg_yincheng3421CD[(1+GetPlayerId(GetTriggerPlayer()))]=0
return
endif
endfunction
function Trig_yincheng3421JZJZ_Func001Func001C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[50])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[51])
endfunction
function Trig_yincheng3421JZJZ_Func001C takes nothing returns boolean
return(Trig_yincheng3421JZJZ_Func001Func001C())
endfunction
function Trig_yincheng3421JZJZ_Func002Func001C takes nothing returns boolean
return(GetEventPlayerChatString()==udg_yincheng3421ZFC[52])or(GetEventPlayerChatString()==udg_yincheng3421ZFC[53])
endfunction
function Trig_yincheng3421JZJZ_Func002C takes nothing returns boolean
return(Trig_yincheng3421JZJZ_Func002Func001C())
endfunction
function Trig_yincheng3421JZJZ_Actions takes nothing returns nothing
if(Trig_yincheng3421JZJZ_Func001C())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[56]))
set udg_yincheng3421JZ[(1+GetPlayerId(GetTriggerPlayer()))]=1
return
endif
if(Trig_yincheng3421JZJZ_Func002C())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,.01,(udg_yincheng3421ZFC[0]+udg_yincheng3421ZFC[57]))
set udg_yincheng3421JZ[(1+GetPlayerId(GetTriggerPlayer()))]=0
return
endif
endfunction

function main takes nothing returns nothing
local integer i

set i=0
loop
exitwhen(i>1)
set udg_yincheng3421A[i]=0
set udg_yincheng3421B[i]=0
set udg_yincheng3421C[i]=0
set udg_yincheng3421D[i]=0
set udg_yincheng3421XH[i]=0
set udg_yincheng3421DW[i]=CreateGroup()
set udg_yincheng3421GX[i]=CreateForce()
set udg_yincheng3421SY[i]=0
set udg_yincheng3421ZYQ[i]=0
set udg_yincheng3421ZYM[i]=0
set udg_yincheng3421RK[i]=0
set udg_yincheng3421KQ[i]=0
set udg_bf3401KQ[i]=0
set udg_yincheng3421CMD[i]=0
set udg_yincheng3421ZFC[i]=""
set udg_yincheng3421HP[i]=5.
set udg_yincheng3421MP[i]=10.
set udg_yincheng3421CD[i]=0
set udg_yincheng3421JZ[i]=0
set i=i+1
endloop
set udg_yincheng3421DHK=DialogCreate()
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(6))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(7))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(8))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(9))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(10))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421WJQX,Player(11))
call TriggerAddCondition(gg_trg_yincheng3421WJQX,Condition(function Trig_yincheng3421WJQX_Conditions))
call TriggerAddAction(gg_trg_yincheng3421WJQX,function Trig_yincheng3421WJQX_Actions)
call TriggerAddAction(gg_trg_yincheng3421A1,function Trig_yincheng3421A1_Actions)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(0),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(1),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(2),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(3),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(4),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(5),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(6),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(7),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(8),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(9),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(10),"yincheng3421",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421ML,Player(11),"yincheng3421",true)
call TriggerAddAction(gg_trg_yincheng3421ML,function Trig_yincheng3421ML_Actions)
call DisableTrigger(gg_trg_yincheng3421SS)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(0),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(1),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(2),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(3),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(4),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(5),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(6),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(7),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(8),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(9),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(10),1,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421SS,Player(11),1,3)
call TriggerAddCondition(gg_trg_yincheng3421SS,Condition(function Trig_yincheng3421SS_Conditions))
call TriggerAddAction(gg_trg_yincheng3421SS,function Trig_yincheng3421SS_Actions)
call DisableTrigger(gg_trg_yincheng3421XX)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(0),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(1),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(2),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(3),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(4),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(5),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(6),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(7),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(8),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(9),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(10),1,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421XX,Player(11),1,2)
call TriggerAddCondition(gg_trg_yincheng3421XX,Condition(function Trig_yincheng3421XX_Conditions))
call TriggerAddAction(gg_trg_yincheng3421XX,function Trig_yincheng3421XX_Actions)
call DisableTrigger(gg_trg_yincheng3421CC)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(0),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(1),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(2),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(3),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(4),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(5),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(6),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(7),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(8),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(9),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(10),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421CC,Player(11),1,0)
call TriggerAddCondition(gg_trg_yincheng3421CC,Condition(function Trig_yincheng3421CC_Conditions))
call TriggerAddAction(gg_trg_yincheng3421CC,function Trig_yincheng3421CC_Actions)
call DisableTrigger(gg_trg_yincheng3421DD)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(0),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(1),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(2),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(3),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(4),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(5),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(6),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(7),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(8),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(9),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(10),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421DD,Player(11),1,1)
call TriggerAddCondition(gg_trg_yincheng3421DD,Condition(function Trig_yincheng3421DD_Conditions))
call TriggerAddAction(gg_trg_yincheng3421DD,function Trig_yincheng3421DD_Actions)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yincheng3421A3,Player(11),true)
call TriggerAddCondition(gg_trg_yincheng3421A3,Condition(function Trig_yincheng3421A3_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A3,function Trig_yincheng3421A3_Actions)
call DisableTrigger(gg_trg_yincheng3421A4)
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(6))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(7))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(8))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(9))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(10))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yincheng3421A4,Player(11))
call TriggerAddCondition(gg_trg_yincheng3421A4,Condition(function Trig_yincheng3421A4_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A4,function Trig_yincheng3421A4_Actions)
call DisableTrigger(gg_trg_yincheng3421A5)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(0),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(1),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(2),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(3),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(4),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(5),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(6),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(7),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(8),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(9),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(10),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A5,Player(11),0,3)
call TriggerAddCondition(gg_trg_yincheng3421A5,Condition(function Trig_yincheng3421A5_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A5,function Trig_yincheng3421A5_Actions)
call DisableTrigger(gg_trg_yincheng3421A6)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(0),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(1),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(2),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(3),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(4),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(5),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(6),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(7),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(8),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(9),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(10),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A6,Player(11),0,2)
call TriggerAddCondition(gg_trg_yincheng3421A6,Condition(function Trig_yincheng3421A6_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A6,function Trig_yincheng3421A6_Actions)
call DisableTrigger(gg_trg_yincheng3421A7)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(0),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(1),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(2),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(3),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(4),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(5),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(6),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(7),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(8),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(9),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(10),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A7,Player(11),0,0)
call TriggerAddCondition(gg_trg_yincheng3421A7,Condition(function Trig_yincheng3421A7_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A7,function Trig_yincheng3421A7_Actions)
call DisableTrigger(gg_trg_yincheng3421A8)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(0),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(1),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(2),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(3),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(4),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(5),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(6),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(7),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(8),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(9),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(10),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yincheng3421A8,Player(11),0,1)
call TriggerAddCondition(gg_trg_yincheng3421A8,Condition(function Trig_yincheng3421A8_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A8,function Trig_yincheng3421A8_Actions)
call TriggerAddAction(gg_trg_yincheng3421AA,function Trig_yincheng3421AA_Actions)
call TriggerAddAction(gg_trg_yincheng3421JT,function Trig_yincheng3421JT_Actions)
call TriggerAddAction(gg_trg_yincheng3421AS,function Trig_yincheng3421AS_Actions)
call TriggerAddAction(gg_trg_yincheng3421BX,function Trig_yincheng3421BX_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yincheng3421CZ,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yincheng3421CZ,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
call TriggerAddCondition(gg_trg_yincheng3421CZ,Condition(function Trig_yincheng3421CZ_Conditions))
call TriggerAddAction(gg_trg_yincheng3421CZ,function Trig_yincheng3421CZ_Actions)
call TriggerAddAction(gg_trg_yincheng3421YC,function Trig_yincheng3421YC_Actions)
call TriggerAddAction(gg_trg_yincheng3421XS,function Trig_yincheng3421XS_Actions)
call TriggerAddAction(gg_trg_yincheng3421Z8,function Trig_yincheng3421Z8_Actions)
call TriggerAddAction(gg_trg_yincheng3421Y8,function Trig_yincheng3421Y8_Actions)
call TriggerAddAction(gg_trg_yincheng3421CD,function Trig_yincheng3421CD_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_bf3401CD,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerRegisterAnyUnitEventBJ(gg_trg_bf3401CD,EVENT_PLAYER_UNIT_SPELL_FINISH)
call TriggerAddCondition(gg_trg_bf3401CD,Condition(function Trig_bf3401CD_Conditions))
call TriggerAddAction(gg_trg_bf3401CD,function Trig_bf3401CD_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yincheng3421JZ,EVENT_PLAYER_UNIT_CONSTRUCT_START)
call TriggerAddCondition(gg_trg_yincheng3421JZ,Condition(function Trig_yincheng3421JZ_Conditions))
call TriggerAddAction(gg_trg_yincheng3421JZ,function Trig_yincheng3421JZ_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_bf3401JZ,EVENT_PLAYER_UNIT_RESEARCH_START)
call TriggerAddCondition(gg_trg_bf3401JZ,Condition(function Trig_bf3401JZ_Conditions))
call TriggerAddAction(gg_trg_bf3401JZ,function Trig_bf3401JZ_Actions)
call TriggerRegisterAnyUnitEventBJ(gg_trg_bf3402JZ,EVENT_PLAYER_UNIT_UPGRADE_START)
call TriggerAddCondition(gg_trg_bf3402JZ,Condition(function Trig_bf3402JZ_Conditions))
call TriggerAddAction(gg_trg_bf3402JZ,function Trig_bf3402JZ_Actions)
call TriggerAddAction(gg_trg_yincheng3421A2,function Trig_yincheng3421A2_Actions)
call DisableTrigger(gg_trg_yincheng3421A9)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(0),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(1),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(2),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(3),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(4),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(5),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(6),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(7),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(8),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(9),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(10),"/",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yincheng3421A9,Player(11),"/",false)
call TriggerAddCondition(gg_trg_yincheng3421A9,Condition(function Trig_yincheng3421A9_Conditions))
call TriggerAddAction(gg_trg_yincheng3421A9,function Trig_yincheng3421A9_Actions)
call TriggerAddAction(gg_trg_yincheng3421B1,function Trig_yincheng3421B1_Actions)
call TriggerAddAction(gg_trg_yincheng3421BA,function Trig_yincheng3421BA_Actions)
call TriggerAddAction(gg_trg_yincheng3421B2,function Trig_yincheng3421B2_Actions)
call TriggerAddAction(gg_trg_yincheng3421BB,function Trig_yincheng3421BB_Actions)
call TriggerAddAction(gg_trg_yincheng3421ZY,function Trig_yincheng3421ZY_Actions)
call TriggerAddAction(gg_trg_yincheng3421QM,function Trig_yincheng3421QM_Actions)
call TriggerAddAction(gg_trg_yincheng3421Q,function Trig_yincheng3421Q_Actions)
call TriggerAddAction(gg_trg_yincheng3421M,function Trig_yincheng3421M_Actions)
call TriggerAddAction(gg_trg_yincheng3421DJ,function Trig_yincheng3421DJ_Actions)
call TriggerAddAction(gg_trg_yincheng3421SX,function Trig_yincheng3421SX_Actions)
call TriggerAddAction(gg_trg_yincheng3421LL,function Trig_yincheng3421LL_Actions)
call TriggerAddAction(gg_trg_yincheng3421MJ,function Trig_yincheng3421MJ_Actions)
call TriggerAddAction(gg_trg_yincheng3421ZL,function Trig_yincheng3421ZL_Actions)
call TriggerAddAction(gg_trg_yincheng3421RK,function Trig_yincheng3421RK_Actions)
call TriggerAddAction(gg_trg_yincheng3421GX,function Trig_yincheng3421GX_Actions)
call TriggerAddAction(gg_trg_yincheng3421WJ,function Trig_yincheng3421WJ_Actions)
call TriggerAddAction(gg_trg_yincheng3421ZX,function Trig_yincheng3421ZX_Actions)
call TriggerAddAction(gg_trg_yincheng3421TT,function Trig_yincheng3421TT_Actions)
call TriggerAddAction(gg_trg_yincheng3421GZ,function Trig_yincheng3421GZ_Actions)
call TriggerAddAction(gg_trg_yincheng3421WD,function Trig_yincheng3421WD_Actions)
call TriggerAddAction(gg_trg_yincheng3421BWD,function Trig_yincheng3421BWD_Actions)
call TriggerAddAction(gg_trg_yincheng3421CMD,function Trig_yincheng3421CMD_Actions)
call TriggerAddAction(gg_trg_yincheng3421SHA,function Trig_yincheng3421SHA_Actions)
call TriggerAddAction(gg_trg_yincheng3421FH,function Trig_yincheng3421FH_Actions)
call TriggerAddAction(gg_trg_yincheng3421CDCD,function Trig_yincheng3421CDCD_Actions)
call TriggerAddAction(gg_trg_yincheng3421JZJZ,function Trig_yincheng3421JZJZ_Actions)
call ConditionalTriggerExecute(gg_trg_yincheng3421A1)
endfunction
