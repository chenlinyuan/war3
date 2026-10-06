globals
string array N2chat
string array N2ngk
integer array N2temp
unit array N2unit
fogmodifier array N2map
location array N2point
integer array N2val
string array N2dgc
string array N2str
button array N2btn
dialog array N2dlg
integer array N2eqp
trigger N3init=CreateTrigger()
trigger N3rest=CreateTrigger()
trigger N3cre=CreateTrigger()
trigger N3crea=CreateTrigger()
trigger N3creb=CreateTrigger()
trigger N3crec=CreateTrigger()
trigger N3cred=CreateTrigger()
trigger N3ngo=CreateTrigger()
trigger N3fir=CreateTrigger()
trigger N3ngk=CreateTrigger()
trigger N3nga=CreateTrigger()
trigger N3esc=CreateTrigger()
trigger N3sel=CreateTrigger()
trigger N3alu=CreateTrigger()
trigger N3ally=CreateTrigger()
trigger N3enem=CreateTrigger()
trigger N3rlv=CreateTrigger()
trigger N3info=CreateTrigger()
trigger N3tply=CreateTrigger()
trigger N3dlgS=CreateTrigger()
trigger N3main=CreateTrigger()
trigger N3maiS=CreateTrigger()
trigger N3unti=CreateTrigger()
trigger N3untS=CreateTrigger()
trigger N3untU=CreateTrigger()
trigger N3utUS=CreateTrigger()
trigger N3untD=CreateTrigger()
trigger N3unDS=CreateTrigger()
trigger N3untF=CreateTrigger()
trigger N3unFS=CreateTrigger()
trigger N3unt=CreateTrigger()
trigger N3unS=CreateTrigger()
trigger N3auto=CreateTrigger()
trigger N3autS=CreateTrigger()
trigger N3autU=CreateTrigger()
trigger N3auUS=CreateTrigger()
trigger N3autD=CreateTrigger()
trigger N3auDS=CreateTrigger()
trigger N3othe=CreateTrigger()
trigger N3othS=CreateTrigger()
trigger N3CopI=CreateTrigger()
trigger N3CopS=CreateTrigger()
trigger N3pla1=CreateTrigger()
trigger N3pl1S=CreateTrigger()
trigger N3pla2=CreateTrigger()
trigger N3pl2S=CreateTrigger()
trigger N3item=CreateTrigger()
trigger N3iteS=CreateTrigger()
trigger N3Req=CreateTrigger()
trigger N3ReS=CreateTrigger()
trigger N3RSub=CreateTrigger()
trigger N3RSuS=CreateTrigger()
trigger N3equp=CreateTrigger()
trigger N3equS=CreateTrigger()
trigger N3Sube=CreateTrigger()
trigger N3SubS=CreateTrigger()
trigger N3help=CreateTrigger()
trigger N3helS=CreateTrigger()

endglobals
function N1init_Actions takes nothing returns nothing
set N2eqp[0]='stel'
set N2eqp[1]='gcel'
set N2eqp[2]='mcou'
set N2eqp[3]='rhth'
set N2eqp[4]='kpin'
set N2eqp[5]='ajen'
set N2eqp[6]='dsum'
set N2eqp[7]='sbch'
set N2eqp[8]='belv'
set N2eqp[9]='rde3'
set N2eqp[10]='bgst'
set N2eqp[11]='clsd'
set N2eqp[12]='rlif'
set N2eqp[13]='ward'
set N2eqp[14]='ratc'
set N2eqp[15]='rag1'
set N2eqp[16]='rin1'
set N2eqp[17]='lgdh'
set N2eqp[18]='crys'
set N2eqp[19]='ssil'
set N2eqp[20]='ciri'
set N2eqp[21]='clfm'
set N2eqp[22]='hcun'
set N2eqp[23]='prvt'
set N2eqp[24]='brac'
set N2eqp[25]='penr'
set N2eqp[26]='rwiz'
set N2eqp[27]='hval'
set N2eqp[28]='cnob'
set N2eqp[29]='bspd'
set N2eqp[30]='evtl'
set N2eqp[31]='afac'
set N2eqp[32]='pmna'
set N2eqp[33]='spsh'
set N2eqp[34]='odef'
set N2eqp[35]='ckng'
set N2eqp[36]='rde4'
set N2eqp[37]='ratf'
set N2eqp[38]='modt'
set N2eqp[39]='desc'
set N2eqp[40]='tkno'
set N2eqp[41]='ofro'
set N2eqp[42]='uflg'
set N2eqp[43]='sfog'
set N2eqp[44]='spre'
set N2eqp[45]='nspi'
set N2eqp[46]='fgun'
set N2eqp[47]='srbd'
set N2eqp[48]='pdiv'
set N2eqp[49]='axas'
set N2eqp[50]='dsum'
set N2eqp[51]='ofir'
set N2eqp[52]='ankh'
set N2eqp[53]='texp'
set N2eqp[54]='stel'
set N2eqp[55]='fwss'
set N2eqp[56]='oslo'
set N2eqp[57]='asbl'
set N2eqp[58]='blba'
set N2eqp[59]='schl'
set N2eqp[60]='amrc'
set N2eqp[61]='gldo'
set N2eqp[62]='rej6'
set N2eqp[63]='rej4'
set N2eqp[64]='pgin'
set N2eqp[65]='rej5'
set N2eqp[66]='rej2'
set N2eqp[67]='rej1'
set N2eqp[68]='pnvu'
set N2eqp[69]='sora'
set N2eqp[70]='dtsb'
set N2eqp[71]='mnsf'
set N2eqp[72]='stwa'
set N2eqp[73]='hbth'
set N2eqp[74]='pams'
set N2eqp[75]='shen'
set N2eqp[76]='gemt'
set N2eqp[77]='shdt'
set N2eqp[78]='crdt'
set N2eqp[79]='oven'
set N2eqp[80]='frhg'
set N2eqp[81]='gvsm'
set N2eqp[82]='cosl'
set N2eqp[83]='arsh'
set N2eqp[84]='texp'
set N2eqp[85]='tret'
set N2eqp[86]='tpow'
set N2eqp[87]='tdex'
set N2eqp[88]='tint'
set N2eqp[89]='tstr'
set N2eqp[90]='gold'
set N2eqp[91]='lmbr'
set N2eqp[92]='gsou'
set N2eqp[93]='srtl'
set N2eqp[94]='ccmd'
set N2eqp[95]='ocor'
set N2eqp[96]='thdm'
set N2eqp[97]='oli2'
set N2eqp[98]='sbok'
set N2eqp[99]='tgxp'
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItemLoc(N2eqp[bj_forLoopAIndex],GetRectCenter(bj_mapInitialPlayableArea))
set N2str[bj_forLoopAIndex]=GetItemName(bj_lastCreatedItem)
call RemoveItem(bj_lastCreatedItem)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2val[((bj_forLoopAIndex*100)+4)]=200
set N2val[((bj_forLoopAIndex*100)+5)]=200
set N2val[((bj_forLoopAIndex*100)+6)]=500
set N2val[((bj_forLoopAIndex*'d')+7)]=10000
set N2val[((bj_forLoopAIndex*'d')+8)]=10
set N2val[((bj_forLoopAIndex*'d')+9)]=10
set N2val[((bj_forLoopAIndex*'d')+10)]=10
set N2val[((bj_forLoopAIndex*'d')+11)]=10
set N2val[((bj_forLoopAIndex*'d')+12)]=10
set N2val[((bj_forLoopAIndex*'d')+13)]=1
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1rest_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=24
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=""
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=200
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=200
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=500
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=10000
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=10
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=10
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=10
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=10
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=10
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=1
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00所有状态和数值恢复到初始值!|r"+""))
endfunction
function N1cre_Actions takes nothing returns nothing
set N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=0
call ConditionalTriggerExecute(N3crea)
call ConditionalTriggerExecute(N3creb)
call ConditionalTriggerExecute(N3crec)
call ConditionalTriggerExecute(N3cred)
endfunction
function N1crea_Func001Func001C takes nothing returns boolean
return(N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==GetItemTypeId(null))
endfunction
function N1crea_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1crea_Func001Func001C())then
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=ChooseRandomItem(GetRandomInt(1,10))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1creb_Func001Func001Func001C takes nothing returns boolean
return(N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]!=GetItemTypeId(null))and(bj_forLoopAIndex!=bj_forLoopBIndex)and(N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)])
endfunction
function N1creb_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=99
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if(N1creb_Func001Func001Func001C())then
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)]=GetItemTypeId(null)
set N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=(N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')]+1)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1crec_Func001Func001Func001C takes nothing returns boolean
return(N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopBIndex-1))]==GetItemTypeId(null))
endfunction
function N1crec_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')]
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=99
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if(N1crec_Func001Func001Func001C())then
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopBIndex-1))]=N2eqp[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)+0)]
set N2eqp[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)+0)]=GetItemTypeId(null)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1cred_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItemLoc(N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)],GetRectCenter(bj_mapInitialPlayableArea))
set N2str[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemName(bj_lastCreatedItem)
call RemoveItem(bj_lastCreatedItem)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1ngo_Func001C takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="off")
endfunction
function N1ngo_Func003Func001C takes nothing returns boolean
return(N2ngk[bj_forLoopAIndex]=="NGK")
endfunction
function N1ngo_Actions takes nothing returns nothing
if(N1ngo_Func001C())then
call EnableTrigger(N3fir)
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="NGK"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00成功启动!|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemTypeId(null)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(N3cre)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00当前共有随机物品|r "+(("|cffFF0000"+I2S(('d'-N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')])))+"|r |cff00FF00件.|r")))
return
endif
call DisableTrigger(N3fir)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1ngo_Func003Func001C())then
set N2ngk[bj_forLoopAIndex]=""
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,(("|cffFFFF00"+GetPlayerName(GetTriggerPlayer()))+"|cffFF0000强行关闭了命令行系统,其他玩家将不能开启.|r"))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="off"
endfunction
function N1fir_Conditions takes nothing returns boolean
return(StringLength(GetEventPlayerChatString())>=3)
endfunction
function N1fir_Actions takes nothing returns nothing
set N2chat[(1+GetPlayerId(GetTriggerPlayer()))]=GetEventPlayerChatString()
call ConditionalTriggerExecute(N3ngk)
endfunction
function N1ngk_Func001Func003C takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1ngk_Func001C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="ngk")and(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],3,8)=="killer")and(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,8)=="ngkiller")
endfunction
function N1ngk_Actions takes nothing returns nothing
if(N1ngk_Func001C())then
if(N1ngk_Func001Func003C())then
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cffFFFF00已经关闭!|r"+""))
else
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="NGK"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00成功启动!|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemTypeId(null)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(N3cre)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00当前共有随机物品|r "+(("|cffFF0000"+I2S(('d'-N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')])))+"|r |cff00FF00件.|r")))
endif
return
endif
call ConditionalTriggerExecute(N3nga)
endfunction
function N1nga_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1nga_Func002C takes nothing returns boolean
return(N2temp[(1+GetPlayerId(GetTriggerPlayer()))]<0)and(N2temp[(1+GetPlayerId(GetTriggerPlayer()))]>0xF4240)
endfunction
function N1nga_Func004C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sm")
endfunction
function N1nga_Func005C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mf")
endfunction
function N1nga_Func006C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sd")
endfunction
function N1nga_Func007C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="jb")
endfunction
function N1nga_Func008C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mc")
endfunction
function N1nga_Func009C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sx")
endfunction
function N1nga_Func010C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="ll")
endfunction
function N1nga_Func011C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="zl")
endfunction
function N1nga_Func012C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mj")
endfunction
function N1nga_Func013C takes nothing returns boolean
return(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="dj")
endfunction
function N1nga_Actions takes nothing returns nothing
set N2temp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(N2chat[(1+GetPlayerId(GetTriggerPlayer()))],3,StringLength(N2chat[(1+GetPlayerId(GetTriggerPlayer()))])))
if(N1nga_Func002C())then
return
endif
if(N1nga_Func004C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func005C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func006C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func007C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func008C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func009C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func010C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func011C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func012C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(N1nga_Func013C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=N2temp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
endfunction
function N1esc_Func001C takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1esc_Actions takes nothing returns nothing
if(N1esc_Func001C())then
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="Dlg"
call TriggerSleepAction(.5)
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="NGK"
endif
endfunction
function N1sel_Func013C takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="Dlg")
endfunction
function N1sel_Actions takes nothing returns nothing
if(N1sel_Func013C())then
set N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]="NGK"
set N2unit[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
call ConditionalTriggerExecute(N3main)
return
endif
call ConditionalTriggerExecute(N3alu)
call ConditionalTriggerExecute(N3ally)
call ConditionalTriggerExecute(N3enem)
set N2unit[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
endfunction
function N1alu_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1alu_Func001C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="CopyItemNum")
endfunction
function N1alu_Func002C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="CopyItem")
endfunction
function N1alu_Func003C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="Exch")
endfunction
function N1alu_Func004C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="ExchNormal")
endfunction
function N1alu_Func005C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="Move")
endfunction
function N1alu_Func006C takes nothing returns boolean
return(N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="CopyUnit")
endfunction
function N1alu_Actions takes nothing returns nothing
if(N1alu_Func001C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)])),GetTriggerUnit())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3CopI)
return
endif
if(N1alu_Func002C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1)),GetTriggerUnit())
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2)),GetTriggerUnit())
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],3)),GetTriggerUnit())
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],4)),GetTriggerUnit())
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],5)),GetTriggerUnit())
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],6)),GetTriggerUnit())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3CopI)
return
endif
if(N1alu_Func003C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=GetUnitLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
set N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
call SetUnitPositionLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
call CreateNUnitsAtLoc(1,'ewsp',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call SetUnitOwner(GetTriggerUnit(),GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),true)
call SetUnitOwner(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(bj_lastCreatedUnit),true)
call RemoveUnit(bj_lastCreatedUnit)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3unt)
return
endif
if(N1alu_Func004C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=GetUnitLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
set N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
call SetUnitPositionLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],N2point[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3unt)
return
endif
if(N1alu_Func005C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call SetUnitPositionLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3unt)
return
endif
if(N1alu_Func006C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call CreateNUnitsAtLoc(1,'ewsp',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call ReplaceUnitBJ(bj_lastCreatedUnit,GetUnitTypeId(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),3)
call SetUnitOwner(bj_lastReplacedUnit,GetTriggerPlayer(),true)
call SetHeroLevelBJ(bj_lastReplacedUnit,GetHeroLevel(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),false)
call ModifyHeroStat(0,bj_lastReplacedUnit,2,GetHeroStatBJ(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(1,bj_lastReplacedUnit,2,GetHeroStatBJ(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(2,bj_lastReplacedUnit,2,GetHeroStatBJ(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],true))
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1)),bj_lastReplacedUnit)
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2)),bj_lastReplacedUnit)
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],3)),bj_lastReplacedUnit)
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],4)),bj_lastReplacedUnit)
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],5)),bj_lastReplacedUnit)
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],6)),bj_lastReplacedUnit)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(bj_lastReplacedUnit),1.)
call TriggerSleepAction(2.)
call ConditionalTriggerExecute(N3unt)
return
endif
set N2unit[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
endfunction
function N1ally_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")and(IsPlayerAlly(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function N1ally_Func002C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="cd")
endfunction
function N1ally_Func003C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function N1ally_Func004C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function N1ally_Func005C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function N1ally_Func006C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function N1ally_Func007C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function N1ally_Func008C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function N1ally_Func009C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function N1ally_Func010C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=="ll")
endfunction
function N1ally_Func011C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=="zl")
endfunction
function N1ally_Func012C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=="mj")
endfunction
function N1ally_Func013C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function N1ally_Actions takes nothing returns nothing
if(N1ally_Func002C())then
call UnitResetCooldown(GetTriggerUnit())
endif
if(N1ally_Func003C())then
call UnitRemoveBuffsBJ(1,GetTriggerUnit())
endif
if(N1ally_Func004C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(N1ally_Func005C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(N1ally_Func006C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(N1ally_Func007C())then
call AdjustPlayerStateBJ(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_GOLD_GATHERED)
endif
if(N1ally_Func008C())then
call AdjustPlayerStateBJ(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_LUMBER_GATHERED)
endif
if(N1ally_Func009C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(N1ally_Func010C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(N1ally_Func011C())then
call ModifyHeroStat(2,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(N1ally_Func012C())then
call ModifyHeroStat(1,GetTriggerUnit(),0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(N1ally_Func013C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
endfunction
function N1enem_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")and(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function N1enem_Func002C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sm-")
endfunction
function N1enem_Func003C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=="mf-")
endfunction
function N1enem_Func004C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=="sd-")
endfunction
function N1enem_Func005C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=="jb-")
endfunction
function N1enem_Func006C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="mc-")
endfunction
function N1enem_Func007C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sx-")
endfunction
function N1enem_Func008C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="ll-")
endfunction
function N1enem_Func009C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="zl-")
endfunction
function N1enem_Func010C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="mj-")
endfunction
function N1enem_Func011C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="dj-")
endfunction
function N1enem_Actions takes nothing returns nothing
if(N1enem_Func002C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(N1enem_Func003C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(N1enem_Func004C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(N1enem_Func005C())then
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
endif
if(N1enem_Func006C())then
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(N1enem_Func007C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(N1enem_Func008C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(N1enem_Func009C())then
call ModifyHeroStat(2,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(N1enem_Func010C())then
call ModifyHeroStat(1,GetTriggerUnit(),1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(N1enem_Func011C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())-N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
endfunction
function N1rlv_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")and(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="fh")and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))
endfunction
function N1rlv_Actions takes nothing returns nothing
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
endfunction
function N1info_Func001Func001C takes nothing returns boolean
return(N2ngk[bj_forLoopAIndex]=="NGK")
endfunction
function N1info_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1info_Func001Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cFF00FF00NGKiller|cFFFF8000兴浪博客|r:"+"|cffFFFF00http://blog.sina.com.cn/|cff00FF00NGKiller|r"))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1tply_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1tply_Func002Func001Func001C takes nothing returns boolean
return(N2ngk[bj_forLoopAIndex]=="NGK")
endfunction
function N1tply_Func002Func001Func002C takes nothing returns boolean
return(N2ngk[bj_forLoopAIndex]=="NGK")
endfunction
function N1tply_Func002Func001C takes nothing returns boolean
return(GetPlayerSlotState(Player(-1+(bj_forLoopAIndex)))==PLAYER_SLOT_STATE_PLAYING)and(GetPlayerController(Player(-1+(bj_forLoopAIndex)))==MAP_CONTROL_USER)
endfunction
function N1tply_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1tply_Func002Func001C())then
if(N1tply_Func002Func001Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(("|cffFF0000NGK|cff00FF00 "+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(("|cff00FF00"+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
else
if(N1tply_Func002Func001Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(("|cffFF0000NGK|cffC0C0C0 "+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(("|cffC0C0C0"+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1dlgS_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1dlgS_Func014C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="main")
endfunction
function N1dlgS_Func015C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="other")
endfunction
function N1dlgS_Func016C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="player1")
endfunction
function N1dlgS_Func017C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="player2")
endfunction
function N1dlgS_Func018C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="equip")
endfunction
function N1dlgS_Func019C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="Subequip")
endfunction
function N1dlgS_Func020C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="auto")
endfunction
function N1dlgS_Func021C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="autoUP")
endfunction
function N1dlgS_Func022C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="autoDOWN")
endfunction
function N1dlgS_Func023C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="unit")
endfunction
function N1dlgS_Func024C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="unitatti")
endfunction
function N1dlgS_Func025C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiUP")
endfunction
function N1dlgS_Func026C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiDOWN")
endfunction
function N1dlgS_Func027C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiFOLLOW")
endfunction
function N1dlgS_Func028C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="help")
endfunction
function N1dlgS_Func029C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="Requip")
endfunction
function N1dlgS_Func030C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="Requip")
endfunction
function N1dlgS_Func031C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="RSubequip")
endfunction
function N1dlgS_Func032C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="item")
endfunction
function N1dlgS_Func033C takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="num")
endfunction
function N1dlgS_Func034C takes nothing returns boolean
return true
endfunction
function N1dlgS_Actions takes nothing returns nothing
if(N1dlgS_Func014C())then
call ConditionalTriggerExecute(N3maiS)
return
endif
if(N1dlgS_Func015C())then
call ConditionalTriggerExecute(N3othS)
return
endif
if(N1dlgS_Func016C())then
call ConditionalTriggerExecute(N3pl1S)
return
endif
if(N1dlgS_Func017C())then
call ConditionalTriggerExecute(N3pl2S)
return
endif
if(N1dlgS_Func018C())then
call ConditionalTriggerExecute(N3equS)
return
endif
if(N1dlgS_Func019C())then
call ConditionalTriggerExecute(N3SubS)
return
endif
if(N1dlgS_Func020C())then
call ConditionalTriggerExecute(N3autS)
return
endif
if(N1dlgS_Func021C())then
call ConditionalTriggerExecute(N3auUS)
return
endif
if(N1dlgS_Func022C())then
call ConditionalTriggerExecute(N3auDS)
return
endif
if(N1dlgS_Func023C())then
call ConditionalTriggerExecute(N3unS)
return
endif
if(N1dlgS_Func024C())then
call ConditionalTriggerExecute(N3untS)
return
endif
if(N1dlgS_Func025C())then
call ConditionalTriggerExecute(N3utUS)
return
endif
if(N1dlgS_Func026C())then
call ConditionalTriggerExecute(N3unDS)
return
endif
if(N1dlgS_Func027C())then
call ConditionalTriggerExecute(N3unFS)
return
endif
if(N1dlgS_Func028C())then
call ConditionalTriggerExecute(N3helS)
return
endif
if(N1dlgS_Func029C())then
call ConditionalTriggerExecute(N3ReS)
return
endif
if(N1dlgS_Func030C())then
call ConditionalTriggerExecute(N3ReS)
return
endif
if(N1dlgS_Func031C())then
call ConditionalTriggerExecute(N3RSuS)
return
endif
if(N1dlgS_Func032C())then
call ConditionalTriggerExecute(N3iteS)
return
endif
if(N1dlgS_Func033C())then
call ConditionalTriggerExecute(N3CopS)
return
endif
if(N1dlgS_Func034C())then
call ConditionalTriggerExecute(N3RSuS)
return
endif
endfunction
function N1main_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1main_Func017C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function N1main_Func020C takes nothing returns boolean
return(N2ngk[24]!="gblx")
endfunction
function N1main_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="main"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00"+GetUnitName(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+((("|r - |cffFF0000"+R2S(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])))+"|r - |cff0000FF")+(R2S(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r - |cff00FF00")))+(GetPlayerName(GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("复位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("自动"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("其他"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("单位命令"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("单位状态"+""))
if(N1main_Func017C())then
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("踢出玩家"+""))
endif
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00NGKiller|r - |cffFF0000VC|r版改图帮助"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=bj_lastCreatedButton
if(N1main_Func020C())then
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF0000关闭录像|r(无法开启)"+""))
endif
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1maiS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="main")
endfunction
function N1maiS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1maiS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1maiS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1maiS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1maiS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1maiS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1maiS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1maiS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1maiS_Func009C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1maiS_Actions takes nothing returns nothing
if(N1maiS_Func001C())then
return
endif
if(N1maiS_Func002C())then
set N2ngk[24]="gblx"
call DoNotSaveReplay ()
call ConditionalTriggerExecute(N3main)
return
endif
if(N1maiS_Func003C())then
call ConditionalTriggerExecute(N3help)
return
endif
if(N1maiS_Func004C())then
call ConditionalTriggerExecute(N3auto)
return
endif
if(N1maiS_Func005C())then
call ConditionalTriggerExecute(N3othe)
return
endif
if(N1maiS_Func006C())then
call ConditionalTriggerExecute(N3unt)
return
endif
if(N1maiS_Func007C())then
call ConditionalTriggerExecute(N3unti)
return
endif
if(N1maiS_Func008C())then
call ConditionalTriggerExecute(N3rest)
call ConditionalTriggerExecute(N3main)
return
endif
if(N1maiS_Func009C())then
call ConditionalTriggerExecute(N3pla1)
return
endif
endfunction
function N1unti_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1unti_Func013C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=="dt")
endfunction
function N1unti_Func015C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="fh")
endfunction
function N1unti_Func017C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function N1unti_Func019C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="cd")
endfunction
function N1unti_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="unitatti"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("修改单位的属性"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("增加单位属性"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("减少单位属性"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("设置单位属性"+""))
if(N1unti_Func013C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040地图全黑|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00地图全亮|r"+""))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(N1unti_Func015C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040英雄正常复活|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00英雄原地复活|r"+""))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(N1unti_Func017C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040技能正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00无限技能|r"+""))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=bj_lastCreatedButton
if(N1unti_Func019C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040buffs正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00无负面buffs|r"+""))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=bj_lastCreatedButton
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1untS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="unitatti")
endfunction
function N1untS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1untS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1untS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1untS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1untS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1untS_Func006Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=="dt")
endfunction
function N1untS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1untS_Func007Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="fh")
endfunction
function N1untS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1untS_Func008Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function N1untS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1untS_Func009Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="cd")
endfunction
function N1untS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1untS_Actions takes nothing returns nothing
if(N1untS_Func001C())then
return
endif
if(N1untS_Func002C())then
call ConditionalTriggerExecute(N3main)
return
endif
if(N1untS_Func003C())then
call ConditionalTriggerExecute(N3untU)
return
endif
if(N1untS_Func004C())then
call ConditionalTriggerExecute(N3untD)
return
endif
if(N1untS_Func005C())then
call ConditionalTriggerExecute(N3untF)
return
endif
if(N1untS_Func006C())then
if(N1untS_Func006Func001C())then
call DestroyFogModifier(N2map[(1+GetPlayerId(GetTriggerPlayer()))])
set N2map[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_MASKED,GetWorldBounds())
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=""
else
call DestroyFogModifier(N2map[(1+GetPlayerId(GetTriggerPlayer()))])
set N2map[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetWorldBounds())
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]="dt"
endif
endif
if(N1untS_Func007C())then
if(N1untS_Func007Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="fh"
endif
endif
if(N1untS_Func008C())then
if(N1untS_Func008Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]="bf"
endif
endif
if(N1untS_Func009C())then
if(N1untS_Func009Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="cd"
endif
endif
call ConditionalTriggerExecute(N3unti)
endfunction
function N1untU_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1untU_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="untattiUP"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00"+GetUnitName(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+((("|r - |cffFF0000"+R2S(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])))+"|r - |cff0000FF")+(R2S(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r - |cff00FF00")))+(GetPlayerName(GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("金币 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("木材 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("生命 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("魔法 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("速度 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全属性 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("力量 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("智力 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("敏捷 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("等级 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1utUS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiUP")
endfunction
function N1utUS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1utUS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1utUS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1utUS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1utUS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1utUS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1utUS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1utUS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1utUS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1utUS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1utUS_Func011C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1utUS_Func012C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function N1utUS_Actions takes nothing returns nothing
if(N1utUS_Func001C())then
return
endif
if(N1utUS_Func002C())then
call ConditionalTriggerExecute(N3unti)
return
endif
if(N1utUS_Func003C())then
call AdjustPlayerStateBJ(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)],GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]*-1),GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
if(N1utUS_Func004C())then
call AdjustPlayerStateBJ(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)],GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]*-1),GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(N1utUS_Func005C())then
call SetWidgetLife(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(N1utUS_Func006C())then
call SetUnitManaBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(N1utUS_Func007C())then
call SetUnitMoveSpeed(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitMoveSpeed(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(N1utUS_Func008C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(N1utUS_Func009C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(N1utUS_Func010C())then
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(N1utUS_Func011C())then
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],0,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(N1utUS_Func012C())then
call SetHeroLevelBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetHeroLevel(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
call ConditionalTriggerExecute(N3untU)
endfunction
function N1untD_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1untD_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="untattiDOWN"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00"+GetUnitName(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+((("|r - |cffFF0000"+R2S(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])))+"|r - |cff0000FF")+(R2S(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r - |cff00FF00")))+(GetPlayerName(GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("金币 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("木材 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("生命 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("魔法 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("速度 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全属性 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("力量 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("智力 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("敏捷 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("等级 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1unDS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiDOWN")
endfunction
function N1unDS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1unDS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1unDS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1unDS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1unDS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1unDS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1unDS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1unDS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1unDS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1unDS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1unDS_Func011C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1unDS_Func012C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function N1unDS_Actions takes nothing returns nothing
if(N1unDS_Func001C())then
return
endif
if(N1unDS_Func002C())then
call ConditionalTriggerExecute(N3unti)
return
endif
if(N1unDS_Func003C())then
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]*-1),GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
endif
if(N1unDS_Func004C())then
call AdjustPlayerStateBJ((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]*-1),GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(N1unDS_Func005C())then
call SetWidgetLife(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(N1unDS_Func006C())then
call SetUnitManaBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(N1unDS_Func007C())then
call SetUnitMoveSpeed(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitMoveSpeed(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])-I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(N1unDS_Func008C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(N1unDS_Func009C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(N1unDS_Func010C())then
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(N1unDS_Func011C())then
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],1,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(N1unDS_Func012C())then
call SetHeroLevelBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(GetHeroLevel(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])-N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
call ConditionalTriggerExecute(N3untD)
endfunction
function N1untF_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1untF_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="untattiFOLLOW"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00"+GetUnitName(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+((("|r - |cffFF0000"+R2S(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])))+"|r - |cff0000FF")+(R2S(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r - |cff00FF00")))+(GetPlayerName(GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("生命 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("魔法 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("速度 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全属性 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("力量 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("智力 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("敏捷 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("等级 |cff0080FF=|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1unFS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="untattiFOLLOW")
endfunction
function N1unFS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1unFS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1unFS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1unFS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1unFS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1unFS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1unFS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1unFS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1unFS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1unFS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function N1unFS_Actions takes nothing returns nothing
if(N1unFS_Func001C())then
return
endif
if(N1unFS_Func002C())then
call ConditionalTriggerExecute(N3unti)
return
endif
if(N1unFS_Func003C())then
call SetWidgetLife(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(.0+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(N1unFS_Func004C())then
call SetUnitManaBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(.0+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(N1unFS_Func005C())then
call SetUnitMoveSpeed(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(.0+I2R(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(N1unFS_Func006C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(N1unFS_Func007C())then
call ModifyHeroStat(0,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(N1unFS_Func008C())then
call ModifyHeroStat(2,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(N1unFS_Func009C())then
call ModifyHeroStat(1,N2unit[(1+GetPlayerId(GetTriggerPlayer()))],2,N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(N1unFS_Func010C())then
call SetHeroLevelBJ(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],(0+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
call ConditionalTriggerExecute(N3untF)
endfunction
function N1unt_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1unt_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="unit"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00"+GetUnitName(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+((("|r - |cffFF0000"+R2S(GetUnitStateSwap(UNIT_STATE_LIFE,N2unit[(1+GetPlayerId(GetTriggerPlayer()))])))+"|r - |cff0000FF")+(R2S(GetUnitStateSwap(UNIT_STATE_MANA,N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r - |cff00FF00")))+(GetPlayerName(GetOwningPlayer(N2unit[(1+GetPlayerId(GetTriggerPlayer()))]))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("单位中立"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("删除单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("杀死单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("单位无敌"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("取消无敌"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("交换单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("移动单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("置换单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("复制单位"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1unS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="unit")
endfunction
function N1unS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1unS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1unS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1unS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1unS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1unS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1unS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1unS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1unS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1unS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1unS_Func011C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1unS_Actions takes nothing returns nothing
if(N1unS_Func001C())then
return
endif
if(N1unS_Func002C())then
call ConditionalTriggerExecute(N3main)
return
endif
if(N1unS_Func003C())then
call SetUnitOwner(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],Player(15),true)
endif
if(N1unS_Func004C())then
call RemoveUnit(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(N1unS_Func005C())then
call KillUnit(N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(N1unS_Func006C())then
call SetUnitInvulnerable(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],true)
endif
if(N1unS_Func007C())then
call SetUnitInvulnerable(N2unit[(1+GetPlayerId(GetTriggerPlayer()))],false)
endif
if(N1unS_Func008C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="ExchNormal"
return
endif
if(N1unS_Func009C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="Move"
return
endif
if(N1unS_Func010C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="Exch"
return
endif
if(N1unS_Func011C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="CopyUnit"
return
endif
call ConditionalTriggerExecute(N3unt)
endfunction
function N1auto_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1auto_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="auto"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("选择一个单位自动实现"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00自动增加 - 盟友|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF0000自动减少 - 敌对|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1autS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="auto")
endfunction
function N1autS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1autS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1autS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1autS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1autS_Actions takes nothing returns nothing
if(N1autS_Func001C())then
return
endif
if(N1autS_Func002C())then
call ConditionalTriggerExecute(N3autD)
return
endif
if(N1autS_Func003C())then
call ConditionalTriggerExecute(N3autU)
return
endif
if(N1autS_Func004C())then
call ConditionalTriggerExecute(N3main)
return
endif
endfunction
function N1autU_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1autU_Func007C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function N1autU_Func009C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function N1autU_Func011C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function N1autU_Func013C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function N1autU_Func015C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function N1autU_Func017C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function N1autU_Func019C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=="ll")
endfunction
function N1autU_Func021C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=="zl")
endfunction
function N1autU_Func023C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=="mj")
endfunction
function N1autU_Func025C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function N1autU_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="autoUP"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("只对盟友有效"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(N1autU_Func007C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00金币正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("金币自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(N1autU_Func009C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00木材正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("木材自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(N1autU_Func011C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00生命正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("生命自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(N1autU_Func013C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00魔法正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("魔法自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
if(N1autU_Func015C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00速度正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("速度自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(N1autU_Func017C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00全属性正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全属性自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(N1autU_Func019C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00力量正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("力量自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=bj_lastCreatedButton
if(N1autU_Func021C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00智力正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("智力自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=bj_lastCreatedButton
if(N1autU_Func023C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00敏捷正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("敏捷自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=bj_lastCreatedButton
if(N1autU_Func025C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00等级正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("等级自动 |cff00FF00+|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=bj_lastCreatedButton
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1auUS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="autoUP")
endfunction
function N1auUS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1auUS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1auUS_Func003Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function N1auUS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1auUS_Func004Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function N1auUS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1auUS_Func005Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function N1auUS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1auUS_Func006Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function N1auUS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1auUS_Func007Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function N1auUS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1auUS_Func008Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function N1auUS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1auUS_Func009Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=="ll")
endfunction
function N1auUS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1auUS_Func010Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=="zl")
endfunction
function N1auUS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1auUS_Func011Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=="mj")
endfunction
function N1auUS_Func011C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1auUS_Func012Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function N1auUS_Func012C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function N1auUS_Actions takes nothing returns nothing
if(N1auUS_Func001C())then
return
endif
if(N1auUS_Func002C())then
call ConditionalTriggerExecute(N3auto)
return
endif
if(N1auUS_Func003C())then
if(N1auUS_Func003Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]="jb"
endif
endif
if(N1auUS_Func004C())then
if(N1auUS_Func004Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]="mc"
endif
endif
if(N1auUS_Func005C())then
if(N1auUS_Func005Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="sm"
endif
endif
if(N1auUS_Func006C())then
if(N1auUS_Func006Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]="mf"
endif
endif
if(N1auUS_Func007C())then
if(N1auUS_Func007Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]="sd"
endif
endif
if(N1auUS_Func008C())then
if(N1auUS_Func008Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]="sx"
endif
endif
if(N1auUS_Func009C())then
if(N1auUS_Func009Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]="ll"
endif
endif
if(N1auUS_Func010C())then
if(N1auUS_Func010Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]="zl"
endif
endif
if(N1auUS_Func011C())then
if(N1auUS_Func011Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]="mj"
endif
endif
if(N1auUS_Func012C())then
if(N1auUS_Func012Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]="dj"
endif
endif
call ConditionalTriggerExecute(N3autU)
endfunction
function N1autD_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1autD_Func007C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=="jb-")
endfunction
function N1autD_Func009C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="mc-")
endfunction
function N1autD_Func011C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sm-")
endfunction
function N1autD_Func013C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=="mf-")
endfunction
function N1autD_Func015C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=="sd-")
endfunction
function N1autD_Func017C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sx-")
endfunction
function N1autD_Func019C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="ll-")
endfunction
function N1autD_Func021C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="zl-")
endfunction
function N1autD_Func023C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="mj-")
endfunction
function N1autD_Func025C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="dj-")
endfunction
function N1autD_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="autoDOWN"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("只对敌方有效"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(N1autD_Func007C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040金币正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("金币自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(N1autD_Func009C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040木材正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("木材自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(N1autD_Func011C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040生命正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("生命自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(N1autD_Func013C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040魔法正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("魔法自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
if(N1autD_Func015C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040速度正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("速度自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(N1autD_Func017C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040全属性正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全属性自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(N1autD_Func019C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040力量正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("力量自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=bj_lastCreatedButton
if(N1autD_Func021C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040智力正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("智力自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=bj_lastCreatedButton
if(N1autD_Func023C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040敏捷正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("敏捷自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=bj_lastCreatedButton
if(N1autD_Func025C())then
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8040等级正常|r"+""))
else
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("等级自动 |cffFF0000-|r "+I2S(N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
endif
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=bj_lastCreatedButton
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1auDS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="autoDOWN")
endfunction
function N1auDS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1auDS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1auDS_Func003Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=="jb-")
endfunction
function N1auDS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1auDS_Func004Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="mc-")
endfunction
function N1auDS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1auDS_Func005Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sm-")
endfunction
function N1auDS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1auDS_Func006Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=="mf-")
endfunction
function N1auDS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1auDS_Func007Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=="sd-")
endfunction
function N1auDS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function N1auDS_Func008Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sx-")
endfunction
function N1auDS_Func008C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function N1auDS_Func009Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="ll-")
endfunction
function N1auDS_Func009C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1auDS_Func010Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="zl-")
endfunction
function N1auDS_Func010C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function N1auDS_Func011Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="mj-")
endfunction
function N1auDS_Func011C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1auDS_Func012Func001C takes nothing returns boolean
return(N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="dj-")
endfunction
function N1auDS_Func012C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function N1auDS_Actions takes nothing returns nothing
if(N1auDS_Func001C())then
return
endif
if(N1auDS_Func002C())then
call ConditionalTriggerExecute(N3auto)
return
endif
if(N1auDS_Func003C())then
if(N1auDS_Func003Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]="jb-"
endif
endif
if(N1auDS_Func004C())then
if(N1auDS_Func004Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]="mc-"
endif
endif
if(N1auDS_Func005C())then
if(N1auDS_Func005Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]="sm-"
endif
endif
if(N1auDS_Func006C())then
if(N1auDS_Func006Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]="mf-"
endif
endif
if(N1auDS_Func007C())then
if(N1auDS_Func007Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]="sd-"
endif
endif
if(N1auDS_Func008C())then
if(N1auDS_Func008Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]="sx-"
endif
endif
if(N1auDS_Func009C())then
if(N1auDS_Func009Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]="ll-"
endif
endif
if(N1auDS_Func010C())then
if(N1auDS_Func010Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]="zl-"
endif
endif
if(N1auDS_Func011C())then
if(N1auDS_Func011Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]="mj-"
endif
endif
if(N1auDS_Func012C())then
if(N1auDS_Func012Func001C())then
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=""
else
set N2ngk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]="dj-"
endif
endif
call ConditionalTriggerExecute(N3autD)
endfunction
function N1othe_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1othe_Func013C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function N1othe_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="other"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("杂项"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("复制物品"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("获得物品"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("玩家信息"+""))
if(N1othe_Func013C())then
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("所有玩家地图全亮"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("所有玩家地图全黑"+""))
endif
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=bj_lastCreatedButton
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1othS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="other")
endfunction
function N1othS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1othS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1othS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1othS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1othS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1othS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1othS_Func007C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1othS_Actions takes nothing returns nothing
if(N1othS_Func001C())then
return
endif
if(N1othS_Func002C())then
call ConditionalTriggerExecute(N3main)
return
endif
if(N1othS_Func003C())then
call ConditionalTriggerExecute(N3CopI)
return
endif
if(N1othS_Func004C())then
call ConditionalTriggerExecute(N3item)
return
endif
if(N1othS_Func005C())then
call ConditionalTriggerExecute(N3tply)
endif
if(N1othS_Func006C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(N2map[bj_forLoopAIndex])
set N2map[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_VISIBLE,GetWorldBounds())
set N2ngk[((bj_forLoopAIndex*'d')+24)]="dt"
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
if(N1othS_Func007C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(N2map[bj_forLoopAIndex])
set N2map[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_MASKED,GetWorldBounds())
set N2ngk[((bj_forLoopAIndex*'d')+24)]=""
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
call ConditionalTriggerExecute(N3othe)
endfunction
function N1CopI_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1CopI_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="num"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("请选择物品序号"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("全部物品"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("第 |cff00FF00"+(I2S(bj_forLoopAIndex)+"|r 格物品")))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1CopS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="num")
endfunction
function N1CopS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1CopS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1CopS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function N1CopS_Func004Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function N1CopS_Actions takes nothing returns nothing
if(N1CopS_Func001C())then
return
endif
if(N1CopS_Func002C())then
call ConditionalTriggerExecute(N3othe)
return
endif
if(N1CopS_Func003C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="CopyItem"
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1CopS_Func004Func001C())then
set N2ngk[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="CopyItemNum"
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=bj_forLoopAIndex
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1pla1_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1pla1_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="player1"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF0000仅对第一玩家有效|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=bj_lastCreatedButton
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetPlayerName(Player(-1+(bj_forLoopAIndex))))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00下一页|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1pl1S_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="player1")
endfunction
function N1pl1S_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1pl1S_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1pl1S_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
endfunction
function N1pl1S_Func004Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function N1pl1S_Actions takes nothing returns nothing
if(N1pl1S_Func001C())then
return
endif
if(N1pl1S_Func002C())then
call ConditionalTriggerExecute(N3main)
return
endif
if(N1pl1S_Func003C())then
call ConditionalTriggerExecute(N3pla2)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1pl1S_Func004Func001C())then
call CustomVictoryBJ(Player(-1+(bj_forLoopAIndex)),false,false)
call ConditionalTriggerExecute(N3pla1)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1pla2_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1pla2_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="player2"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF0000仅对第一玩家有效|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=7
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetPlayerName(Player(-1+(bj_forLoopAIndex))))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00上一页|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1pl2S_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="player2")
endfunction
function N1pl2S_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1pl2S_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function N1pl2S_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
endfunction
function N1pl2S_Func004Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function N1pl2S_Actions takes nothing returns nothing
if(N1pl2S_Func001C())then
return
endif
if(N1pl2S_Func002C())then
call ConditionalTriggerExecute(N3main)
return
endif
if(N1pl2S_Func003C())then
call ConditionalTriggerExecute(N3pla1)
return
endif
set bj_forLoopAIndex=7
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1pl2S_Func004Func001C())then
call CustomVictoryBJ(Player(-1+(bj_forLoopAIndex)),false,false)
call ConditionalTriggerExecute(N3pla2)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1item_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1item_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="item"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("获得物品"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("内置物品列表"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("随机物品列表"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("增加随机物品"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("重新刷新随机物品"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1iteS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="item")
endfunction
function N1iteS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1iteS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1iteS_Func003C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function N1iteS_Func004C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function N1iteS_Func005C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function N1iteS_Func006C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function N1iteS_Actions takes nothing returns nothing
if(N1iteS_Func001C())then
return
endif
if(N1iteS_Func002C())then
call ConditionalTriggerExecute(N3othe)
return
endif
if(N1iteS_Func003C())then
call ConditionalTriggerExecute(N3equp)
return
endif
if(N1iteS_Func004C())then
call ConditionalTriggerExecute(N3Req)
return
endif
if(N1iteS_Func005C())then
call ConditionalTriggerExecute(N3cre)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00当前共有随机物品|r "+(("|cffFF0000"+I2S(('d'-N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')])))+"|r |cff00FF00件.|r")))
call ConditionalTriggerExecute(N3item)
return
endif
if(N1iteS_Func006C())then
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2eqp[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemTypeId(null)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(N3cre)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),5.,("|cff00FF00当前共有随机物品|r "+(("|cffFF0000"+I2S(('d'-N2temp[((1+GetPlayerId(GetTriggerPlayer()))*'d')])))+"|r |cff00FF00件.|r")))
call ConditionalTriggerExecute(N3item)
return
endif
endfunction
function N1Req_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1Req_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="Requip"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00随机物品|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("随机物品列表 - |cff00FF00"+(I2S(bj_forLoopAIndex)+"|r")))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1ReS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="Requip")
endfunction
function N1ReS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1ReS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1ReS_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function N1ReS_Actions takes nothing returns nothing
if(N1ReS_Func001C())then
return
endif
if(N1ReS_Func002C())then
call ConditionalTriggerExecute(N3item)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1ReS_Func003Func001C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]=((bj_forLoopAIndex*10)-10)
call ConditionalTriggerExecute(N3RSub)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1RSub_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1RSub_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="RSubequip"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("随机物品列表 - |cff00FF00"+(I2S(((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]/10)+1))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],N2str[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1RSuS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="RSubequip")
endfunction
function N1RSuS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1RSuS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1RSuS_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))])
endfunction
function N1RSuS_Actions takes nothing returns nothing
if(N1RSuS_Func001C())then
return
endif
if(N1RSuS_Func002C())then
call ConditionalTriggerExecute(N3Req)
return
endif
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1RSuS_Func003Func001C())then
call UnitAddItemByIdSwapped(N2eqp[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])],N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(N3RSub)
endfunction
function N1equp_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1equp_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="equip"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00获得物品|r"+""))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("物品列表 - |cff00FF00"+(I2S(bj_forLoopAIndex)+"|r")))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1equS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="equip")
endfunction
function N1equS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1equS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1equS_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function N1equS_Actions takes nothing returns nothing
if(N1equS_Func001C())then
return
endif
if(N1equS_Func002C())then
call ConditionalTriggerExecute(N3item)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1equS_Func003Func001C())then
set N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]=((bj_forLoopAIndex*10)-10)
call ConditionalTriggerExecute(N3Sube)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function N1Sube_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1Sube_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="Subequip"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("物品列表 - |cff00FF00"+(I2S(((N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]/10)+1))+"|r")))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],N2str[(bj_forLoopAIndex+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1SubS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="Subequip")
endfunction
function N1SubS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function N1SubS_Func002C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function N1SubS_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))])
endfunction
function N1SubS_Actions takes nothing returns nothing
if(N1SubS_Func001C())then
return
endif
if(N1SubS_Func002C())then
call ConditionalTriggerExecute(N3equp)
return
endif
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(N1SubS_Func003Func001C())then
call UnitAddItemByIdSwapped(N2eqp[(bj_forLoopAIndex+N2val[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])],N2unit[(1+GetPlayerId(GetTriggerPlayer()))])
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(N3Sube)
endfunction
function N1help_Conditions takes nothing returns boolean
return(N2ngk[(1+GetPlayerId(GetTriggerPlayer()))]=="NGK")
endfunction
function N1help_Actions takes nothing returns nothing
set N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]="help"
call DialogClear(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],((("|cff00FF00NGKiller|r - |cffFF0000VC|r版改图|n|n"+"|cFF00FFFF在游戏中按回车键直接输入:|n|cFF00FF00sm|r11520 |cFFFF80C0(单位生命)|n|cFF00FF00mf|r11520 |cFFFF80C0(单位")+"魔法)|n|cFF00FF00sd|r11520 |cFFFF80C0(单位移动速度)|n|cFF00FF00sx|r11520 |cFFFF80C0(英雄全属性)|n|cFF00FF00ll|r11520 ")+("|cFFFF80C0(英雄力量)|n|cFF00FF00zl|r11520 |cFFFF80C0(英雄智力)|n|cFF00FF00mj|r11520 |cFFFF80C0(英雄敏捷)"+("|n|cFF00FF00dj|r11520 |cFFFF80C0(英雄等级)|n|cFF00FF00jb|r11520 |cFFFF80C0(玩家金币)|n|cFF00FF00mc|r11520 "+("|cFFFF80C0(玩家木材)|n|cFF00FFFF>全部为中文拼音缩写|n>括号中的内容不要输入|n>数字|r11520|r|cFF00FFFF可以替换为其他数"+"字|n>全部为英文半角小写无空格|n|cffFF80C0>例如:|r   |cff00FF00dj725|n|cFFFF0000>更多信息请访问我的|cFF00FFFF兴浪博客|r|n百度一下|cFF00FF00NGKiller|r即可找到.")))))
set N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
call DialogAddButtonBJ(N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,N2dlg[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function N1helS_Conditions takes nothing returns boolean
return(N2dgc[(1+GetPlayerId(GetTriggerPlayer()))]=="help")
endfunction
function N1helS_Func001C takes nothing returns boolean
return(GetClickedButton()==N2btn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function N1helS_Actions takes nothing returns nothing
if(N1helS_Func001C())then
call ConditionalTriggerExecute(N3main)
endif
endfunction
function NgkVc takes nothing returns nothing
set N2dlg[1]=DialogCreate()
set N2dlg[2]=DialogCreate()
set N2dlg[3]=DialogCreate()
set N2dlg[4]=DialogCreate()
set N2dlg[5]=DialogCreate()
set N2dlg[6]=DialogCreate()
set N2dlg[7]=DialogCreate()
set N2dlg[8]=DialogCreate()
set N2dlg[9]=DialogCreate()
set N2dlg[10]=DialogCreate()
set N2dlg[11]=DialogCreate()
set N2dlg[12]=DialogCreate()
call TriggerRegisterTimerEventSingle(N3init,.0)
call TriggerAddAction(N3init,function N1init_Actions)
call TriggerAddAction(N3rest,function N1rest_Actions)
call TriggerAddAction(N3cre,function N1cre_Actions)
call TriggerAddAction(N3crea,function N1crea_Actions)
call TriggerAddAction(N3creb,function N1creb_Actions)
call TriggerAddAction(N3crec,function N1crec_Actions)
call TriggerAddAction(N3cred,function N1cred_Actions)
call TriggerRegisterPlayerChatEvent(N3ngo,Player(0),"ngkvc",true)
call TriggerAddAction(N3ngo,function N1ngo_Actions)
call TriggerRegisterPlayerChatEvent(N3fir,Player(0),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(1),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(2),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(3),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(4),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(5),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(6),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(7),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(8),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(9),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(10),"",false)
call TriggerRegisterPlayerChatEvent(N3fir,Player(11),"",false)
call TriggerAddCondition(N3fir,Condition(function N1fir_Conditions))
call TriggerAddAction(N3fir,function N1fir_Actions)
call TriggerAddAction(N3ngk,function N1ngk_Actions)
call TriggerAddCondition(N3nga,Condition(function N1nga_Conditions))
call TriggerAddAction(N3nga,function N1nga_Actions)
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(0))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(1))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(2))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(3))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(4))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(5))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(6))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(7))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(8))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(9))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(10))
call TriggerRegisterPlayerEventEndCinematic(N3esc,Player(11))
call TriggerAddAction(N3esc,function N1esc_Actions)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(N3sel,Player(11),true)
call TriggerAddAction(N3sel,function N1sel_Actions)
call TriggerAddCondition(N3alu,Condition(function N1alu_Conditions))
call TriggerAddAction(N3alu,function N1alu_Actions)
call TriggerAddCondition(N3ally,Condition(function N1ally_Conditions))
call TriggerAddAction(N3ally,function N1ally_Actions)
call TriggerAddCondition(N3enem,Condition(function N1enem_Conditions))
call TriggerAddAction(N3enem,function N1enem_Actions)
call TriggerRegisterAnyUnitEventBJ(N3rlv,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(N3rlv,Condition(function N1rlv_Conditions))
call TriggerAddAction(N3rlv,function N1rlv_Actions)
call TriggerRegisterTimerEventPeriodic(N3info,100.)
call TriggerAddAction(N3info,function N1info_Actions)
call TriggerAddCondition(N3tply,Condition(function N1tply_Conditions))
call TriggerAddAction(N3tply,function N1tply_Actions)
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[1])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[2])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[3])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[4])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[5])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[6])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[7])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[8])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[9])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[10])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[11])
call TriggerRegisterDialogEvent(N3dlgS,N2dlg[12])
call TriggerAddCondition(N3dlgS,Condition(function N1dlgS_Conditions))
call TriggerAddAction(N3dlgS,function N1dlgS_Actions)
call TriggerAddCondition(N3main,Condition(function N1main_Conditions))
call TriggerAddAction(N3main,function N1main_Actions)
call TriggerAddCondition(N3maiS,Condition(function N1maiS_Conditions))
call TriggerAddAction(N3maiS,function N1maiS_Actions)
call TriggerAddCondition(N3unti,Condition(function N1unti_Conditions))
call TriggerAddAction(N3unti,function N1unti_Actions)
call TriggerAddCondition(N3untS,Condition(function N1untS_Conditions))
call TriggerAddAction(N3untS,function N1untS_Actions)
call TriggerAddCondition(N3untU,Condition(function N1untU_Conditions))
call TriggerAddAction(N3untU,function N1untU_Actions)
call TriggerAddCondition(N3utUS,Condition(function N1utUS_Conditions))
call TriggerAddAction(N3utUS,function N1utUS_Actions)
call TriggerAddCondition(N3untD,Condition(function N1untD_Conditions))
call TriggerAddAction(N3untD,function N1untD_Actions)
call TriggerAddCondition(N3unDS,Condition(function N1unDS_Conditions))
call TriggerAddAction(N3unDS,function N1unDS_Actions)
call TriggerAddCondition(N3untF,Condition(function N1untF_Conditions))
call TriggerAddAction(N3untF,function N1untF_Actions)
call TriggerAddCondition(N3unFS,Condition(function N1unFS_Conditions))
call TriggerAddAction(N3unFS,function N1unFS_Actions)
call TriggerAddCondition(N3unt,Condition(function N1unt_Conditions))
call TriggerAddAction(N3unt,function N1unt_Actions)
call TriggerAddCondition(N3unS,Condition(function N1unS_Conditions))
call TriggerAddAction(N3unS,function N1unS_Actions)
call TriggerAddCondition(N3auto,Condition(function N1auto_Conditions))
call TriggerAddAction(N3auto,function N1auto_Actions)
call TriggerAddCondition(N3autS,Condition(function N1autS_Conditions))
call TriggerAddAction(N3autS,function N1autS_Actions)
call TriggerAddCondition(N3autU,Condition(function N1autU_Conditions))
call TriggerAddAction(N3autU,function N1autU_Actions)
call TriggerAddCondition(N3auUS,Condition(function N1auUS_Conditions))
call TriggerAddAction(N3auUS,function N1auUS_Actions)
call TriggerAddCondition(N3autD,Condition(function N1autD_Conditions))
call TriggerAddAction(N3autD,function N1autD_Actions)
call TriggerAddCondition(N3auDS,Condition(function N1auDS_Conditions))
call TriggerAddAction(N3auDS,function N1auDS_Actions)
call TriggerAddCondition(N3othe,Condition(function N1othe_Conditions))
call TriggerAddAction(N3othe,function N1othe_Actions)
call TriggerAddCondition(N3othS,Condition(function N1othS_Conditions))
call TriggerAddAction(N3othS,function N1othS_Actions)
call TriggerAddCondition(N3CopI,Condition(function N1CopI_Conditions))
call TriggerAddAction(N3CopI,function N1CopI_Actions)
call TriggerAddCondition(N3CopS,Condition(function N1CopS_Conditions))
call TriggerAddAction(N3CopS,function N1CopS_Actions)
call TriggerAddCondition(N3pla1,Condition(function N1pla1_Conditions))
call TriggerAddAction(N3pla1,function N1pla1_Actions)
call TriggerAddCondition(N3pl1S,Condition(function N1pl1S_Conditions))
call TriggerAddAction(N3pl1S,function N1pl1S_Actions)
call TriggerAddCondition(N3pla2,Condition(function N1pla2_Conditions))
call TriggerAddAction(N3pla2,function N1pla2_Actions)
call TriggerAddCondition(N3pl2S,Condition(function N1pl2S_Conditions))
call TriggerAddAction(N3pl2S,function N1pl2S_Actions)
call TriggerAddCondition(N3item,Condition(function N1item_Conditions))
call TriggerAddAction(N3item,function N1item_Actions)
call TriggerAddCondition(N3iteS,Condition(function N1iteS_Conditions))
call TriggerAddAction(N3iteS,function N1iteS_Actions)
call TriggerAddCondition(N3Req,Condition(function N1Req_Conditions))
call TriggerAddAction(N3Req,function N1Req_Actions)
call TriggerAddCondition(N3ReS,Condition(function N1ReS_Conditions))
call TriggerAddAction(N3ReS,function N1ReS_Actions)
call TriggerAddCondition(N3RSub,Condition(function N1RSub_Conditions))
call TriggerAddAction(N3RSub,function N1RSub_Actions)
call TriggerAddCondition(N3RSuS,Condition(function N1RSuS_Conditions))
call TriggerAddAction(N3RSuS,function N1RSuS_Actions)
call TriggerAddCondition(N3equp,Condition(function N1equp_Conditions))
call TriggerAddAction(N3equp,function N1equp_Actions)
call TriggerAddCondition(N3equS,Condition(function N1equS_Conditions))
call TriggerAddAction(N3equS,function N1equS_Actions)
call TriggerAddCondition(N3Sube,Condition(function N1Sube_Conditions))
call TriggerAddAction(N3Sube,function N1Sube_Actions)
call TriggerAddCondition(N3SubS,Condition(function N1SubS_Conditions))
call TriggerAddAction(N3SubS,function N1SubS_Actions)
call TriggerAddCondition(N3help,Condition(function N1help_Conditions))
call TriggerAddAction(N3help,function N1help_Actions)
call TriggerAddCondition(N3helS,Condition(function N1helS_Conditions))
call TriggerAddAction(N3helS,function N1helS_Actions)
endfunction

function main takes nothing returns nothing
call NgkVc()
endfunction

