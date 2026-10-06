function FT1_Actions takes nothing returns nothing
set avd[0]='ankh'
set avd[1]='tgxp'
set avd[2]='tret'
set avd[3]='tpow'
set avd[4]='tdex'
set avd[5]='tint'
set avd[6]='tstr'
set avd[7]='tkno'
set avd[8]='gold'
set avd[9]='lmbr'
set avd[10]='nspi'
set avd[11]='stel'
set avd[12]='ssil'
set avd[13]='spre'
set avd[14]='axas'
set avd[15]='schl'
set avd[16]='mnsf'
set avd[17]='ccmd'
set avd[18]='stre'
set avd[19]='texp'
set avd[20]='rwiz'
set avd[21]='bspd'
set avd[22]='modt'
set avd[23]='manh'
set avd[24]='pdiv'
set avd[25]='pnvu'
set avd[26]='pams'
set avd[27]='rej6'
set avd[28]='rej4'
set avd[29]='pgin'
set avd[30]='rej5'
set avd[31]='rej2'
set avd[32]='rej1'
set avd[33]='gcel'
set avd[34]='mcou'
set avd[35]='rhth'
set avd[36]='kpin'
set avd[37]='ajen'
set avd[38]='dsum'
set avd[39]='sbch'
set avd[40]='odef'
set avd[41]='ocor'
set avd[42]='oslo'
set avd[43]='sora'
set avd[44]='oven'
set avd[45]='cosl'
set avd[46]='gldo'
set avd[47]='ofro'
set avd[48]='oli2'
set avd[49]='ofir'
set avd[50]='belv'
set avd[51]='rde3'
set avd[52]='bgst'
set avd[53]='clsd'
set avd[54]='rlif'
set avd[55]='ward'
set avd[56]='ratc'
set avd[57]='rag1'
set avd[58]='rin1'
set avd[59]='lgdh'
set avd[60]='crys'
set avd[61]='ciri'
set avd[62]='clfm'
set avd[63]='hcun'
set avd[64]='prvt'
set avd[65]='brac'
set avd[66]='penr'
set avd[67]='hval'
set avd[68]='cnob'
set avd[69]='evtl'
set avd[70]='afac'
set avd[71]='pmna'
set avd[72]='spsh'
set avd[73]='ckng'
set avd[74]='rde4'
set avd[75]='ratf'
set avd[76]='desc'
set avd[77]='uflg'
set avd[78]='sfog'
set avd[79]='srbd'
set avd[80]='dsum'
set avd[81]='fwss'
set avd[82]='asbl'
set avd[83]='blba'
set avd[84]='amrc'
set avd[85]='engs'
set avd[86]='gemt'
set avd[87]='gsou'
set avd[88]='dtsb'
set avd[89]='stwa'
set avd[90]='hbth'
set avd[91]='shen'
set avd[92]='shdt'
set avd[93]='crdt'
set avd[94]='frhg'
set avd[95]='gvsm'
set avd[96]='arsh'
set avd[97]='srtl'
set avd[98]='thdm'
set avd[99]='sbok'
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItemLoc(avd[bj_forLoopAIndex],GetRectCenter(bj_mapInitialPlayableArea))
set ave[bj_forLoopAIndex]=GetItemName(bj_lastCreatedItem)
call RemoveItem(bj_lastCreatedItem)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT2)
endfunction
function FT2_Func001C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="fw")
endfunction
function FT2_Actions takes nothing returns nothing
if(FT2_Func001C())then
set bj_forLoopAIndex=(1+GetPlayerId(GetTriggerPlayer()))
set bj_forLoopAIndexEnd=(1+GetPlayerId(GetTriggerPlayer()))
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set aval[((bj_forLoopAIndex*100)+4)]=200
set aval[((bj_forLoopAIndex*100)+5)]=200
set aval[((bj_forLoopAIndex*100)+6)]=100
set aval[((bj_forLoopAIndex*100)+7)]=10000
set aval[((bj_forLoopAIndex*'d')+8)]=10
set aval[((bj_forLoopAIndex*'d')+9)]=10
set aval[((bj_forLoopAIndex*'d')+10)]=10
set aval[((bj_forLoopAIndex*'d')+11)]=10
set aval[((bj_forLoopAIndex*'d')+12)]=10
set aval[((bj_forLoopAIndex*'d')+13)]=1
set aval[((bj_forLoopAIndex*'d')+28)]='d'
set aval[((bj_forLoopAIndex*'d')+19)]=200
set aval[((bj_forLoopAIndex*'d')+20)]=200
set aval[((bj_forLoopAIndex*'d')+21)]='d'
set aval[((bj_forLoopAIndex*'d')+22)]=10000
set aval[((bj_forLoopAIndex*'d')+23)]=10
set aval[((bj_forLoopAIndex*'d')+14)]=10
set aval[((bj_forLoopAIndex*'d')+15)]=10
set aval[((bj_forLoopAIndex*'d')+16)]=10
set aval[((bj_forLoopAIndex*'d')+17)]=10
set aval[((bj_forLoopAIndex*'d')+18)]=1
set aval[((bj_forLoopAIndex*'d')+29)]='d'
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set aval[((bj_forLoopAIndex*'d')+4)]=200
set aval[((bj_forLoopAIndex*'d')+5)]=200
set aval[((bj_forLoopAIndex*'d')+6)]='d'
set aval[((bj_forLoopAIndex*'d')+7)]=10000
set aval[((bj_forLoopAIndex*'d')+8)]=10
set aval[((bj_forLoopAIndex*'d')+9)]=10
set aval[((bj_forLoopAIndex*'d')+10)]=10
set aval[((bj_forLoopAIndex*'d')+11)]=10
set aval[((bj_forLoopAIndex*'d')+12)]=10
set aval[((bj_forLoopAIndex*'d')+13)]=1
set aval[((bj_forLoopAIndex*'d')+28)]='d'
set aval[((bj_forLoopAIndex*'d')+19)]=200
set aval[((bj_forLoopAIndex*'d')+20)]=200
set aval[((bj_forLoopAIndex*'d')+21)]='d'
set aval[((bj_forLoopAIndex*'d')+22)]=10000
set aval[((bj_forLoopAIndex*'d')+23)]=10
set aval[((bj_forLoopAIndex*'d')+14)]=10
set aval[((bj_forLoopAIndex*'d')+15)]=10
set aval[((bj_forLoopAIndex*'d')+16)]=10
set aval[((bj_forLoopAIndex*'d')+17)]=10
set aval[((bj_forLoopAIndex*'d')+18)]=1
set aval[((bj_forLoopAIndex*'d')+29)]='d'
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT3_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT3_Actions takes nothing returns nothing
set avh[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=0
call ConditionalTriggerExecute(GT4)
call ConditionalTriggerExecute(GT5)
call ConditionalTriggerExecute(GT6)
call ConditionalTriggerExecute(GT7)
endfunction
function FT4_Func001Func001C takes nothing returns boolean
return(avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==GetItemTypeId(null))
endfunction
function FT4_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=49
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT4_Func001Func001C())then
set avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=ChooseRandomItem(GetRandomInt(1,10))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT5_Func001Func001Func001C takes nothing returns boolean
return(avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]!=GetItemTypeId(null))and(bj_forLoopAIndex!=bj_forLoopBIndex)and(avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)])
endfunction
function FT5_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=49
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=49
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if(FT5_Func001Func001Func001C())then
set avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)]=GetItemTypeId(null)
set avh[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=(avh[((1+GetPlayerId(GetTriggerPlayer()))*'d')]+1)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT6_Func001Func001Func001C takes nothing returns boolean
return(avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopBIndex-1))]==GetItemTypeId(null))
endfunction
function FT6_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=avh[((1+GetPlayerId(GetTriggerPlayer()))*'d')]
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=49
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if(FT6_Func001Func001Func001C())then
set avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopBIndex-1))]=avd[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)+0)]
set avd[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopBIndex)+0)]=GetItemTypeId(null)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT7_Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItemLoc(avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)],GetRectCenter(bj_mapInitialPlayableArea))
set ave[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemName(bj_lastCreatedItem)
call RemoveItem(bj_lastCreatedItem)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00当前共有随机物品|r "+(("|cffFF0000"+I2S((50-avh[((1+GetPlayerId(GetTriggerPlayer()))*'d')])))+"|r |cff00FF00件.|r")))
endfunction
function FT8_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT8_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="itemMenu"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00获得物品|r(快捷键:|cffFF00008|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0内置物品列表|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0随机物品列表|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("增加随机物品"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("刷新随机物品"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT9_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="itemMenu")
endfunction
function FT9_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT9_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT9_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT9_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT9_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT9_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT9_Actions takes nothing returns nothing
if(FT9_Func001C())then
return
endif
if(FT9_Func002C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT9_Func003C())then
call ConditionalTriggerExecute(GT14)
return
endif
if(FT9_Func004C())then
call ConditionalTriggerExecute(GT10)
return
endif
if(FT9_Func005C())then
call ConditionalTriggerExecute(GT3)
call ConditionalTriggerExecute(GT8)
return
endif
if(FT9_Func006C())then
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=49
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set avd[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=GetItemTypeId(null)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT3)
call ConditionalTriggerExecute(GT8)
return
endif
endfunction
function FT10_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT10_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="RandomEqp"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00随机物品|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0随机物品列表 - |cff00FFFF"+(I2S(bj_forLoopAIndex)+"|r")))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT11_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="RandomEqp")
endfunction
function FT11_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT11_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT11_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT11_Actions takes nothing returns nothing
if(FT11_Func001C())then
return
endif
if(FT11_Func002C())then
call ConditionalTriggerExecute(GT8)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT11_Func003Func001C())then
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]=((bj_forLoopAIndex*10)-10)
call ConditionalTriggerExecute(GT12)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT12_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT12_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="RandomEqpSub"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("随机物品列表 - |cff00FF00"+(I2S(((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]/10)+1))+"|r")))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],ave[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT13_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="RandomEqpSub")
endfunction
function FT13_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT13_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT13_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))])
endfunction
function FT13_Actions takes nothing returns nothing
if(FT13_Func001C())then
return
endif
if(FT13_Func002C())then
call ConditionalTriggerExecute(GT10)
return
endif
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT13_Func003Func001C())then
call UnitAddItemByIdSwapped(avd[((((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])],avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT12)
endfunction
function FT14_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT14_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="eqp"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00内置物品|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0物品列表|r - |cff00FF00"+(I2S(bj_forLoopAIndex)+"|r")))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT15_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="eqp")
endfunction
function FT15_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT15_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT15_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT15_Actions takes nothing returns nothing
if(FT15_Func001C())then
return
endif
if(FT15_Func002C())then
call ConditionalTriggerExecute(GT8)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT15_Func003Func001C())then
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]=((bj_forLoopAIndex*10)-10)
call ConditionalTriggerExecute(GT16)
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT16_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT16_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="eqpSub"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("内置物品列表 - |cff00FF00"+(I2S(((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)]/10)+1))+"|r")))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],ave[(bj_forLoopAIndex+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT17_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="eqpSub")
endfunction
function FT17_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT17_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT17_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))])
endfunction
function FT17_Actions takes nothing returns nothing
if(FT17_Func001C())then
return
endif
if(FT17_Func002C())then
call ConditionalTriggerExecute(GT14)
return
endif
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=9
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT17_Func003Func001C())then
call UnitAddItemByIdSwapped(avd[(bj_forLoopAIndex+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+25)])],avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT16)
endfunction
function FT18_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT18_Func007C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function FT18_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function FT18_Func011C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function FT18_Func013C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function FT18_Func015C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function FT18_Func017C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function FT18_Func019C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=="jy")
endfunction
function FT18_Func021C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function FT18_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="autoAdd"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00自动增加|r(快捷键:|cffFF0000+|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT18_Func007C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF金币正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000金币自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(FT18_Func009C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF木材正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000木材自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(FT18_Func011C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF生命正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000生命自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(FT18_Func013C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF魔法正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000魔法自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
if(FT18_Func015C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF速度正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000速度自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(FT18_Func017C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF全属性正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000全属性自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(FT18_Func019C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF经验正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000经验自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=bj_lastCreatedButton
if(FT18_Func021C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF等级正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000等级自动 |cff00FF00+|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT19_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="autoAdd")
endfunction
function FT19_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT19_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT19_Func003Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function FT19_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT19_Func004Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function FT19_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT19_Func005Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function FT19_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT19_Func006Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function FT19_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT19_Func007Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function FT19_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT19_Func008Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function FT19_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT19_Func009Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=="jy")
endfunction
function FT19_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function FT19_Func010Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function FT19_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function FT19_Actions takes nothing returns nothing
if(FT19_Func001C())then
return
endif
if(FT19_Func002C())then
call ConditionalTriggerExecute(GT81)
return
endif
if(FT19_Func003C())then
if(FT19_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]="jb"
endif
endif
if(FT19_Func004C())then
if(FT19_Func004Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]="mc"
endif
endif
if(FT19_Func005C())then
if(FT19_Func005Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="sm"
endif
endif
if(FT19_Func006C())then
if(FT19_Func006Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]="mf"
endif
endif
if(FT19_Func007C())then
if(FT19_Func007Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]="sd"
endif
endif
if(FT19_Func008C())then
if(FT19_Func008Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]="sx"
endif
endif
if(FT19_Func009C())then
if(FT19_Func009Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]="jy"
endif
endif
if(FT19_Func010C())then
if(FT19_Func010Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]="dj"
endif
endif
call ConditionalTriggerExecute(GT18)
endfunction
function FT20_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT20_Func007C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="jb-")
endfunction
function FT20_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="mc-")
endfunction
function FT20_Func011C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sm-")
endfunction
function FT20_Func013C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="mf-")
endfunction
function FT20_Func015C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="sd-")
endfunction
function FT20_Func017C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sx-")
endfunction
function FT20_Func019C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=="jy-")
endfunction
function FT20_Func021C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="dj-")
endfunction
function FT20_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="autoMinus"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00自动减少|r(快捷键:|cffFF0000-|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT20_Func007C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000金币正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF金币自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(FT20_Func009C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000木材正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF木材自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(FT20_Func011C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000生命正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF生命自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(FT20_Func013C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000魔法正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF魔法自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
if(FT20_Func015C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000速度正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF速度自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(FT20_Func017C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000全属性正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF全属性自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(FT20_Func019C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000经验正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF经验自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=bj_lastCreatedButton
if(FT20_Func021C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000等级正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF等级自动 |cffFF0000-|r "+I2S(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)])))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT21_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="autoMinus")
endfunction
function FT21_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT21_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT21_Func003Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="jb-")
endfunction
function FT21_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT21_Func004Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="mc-")
endfunction
function FT21_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT21_Func005Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sm-")
endfunction
function FT21_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT21_Func006Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="mf-")
endfunction
function FT21_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT21_Func007Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="sd-")
endfunction
function FT21_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT21_Func008Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sx-")
endfunction
function FT21_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT21_Func009Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=="jy-")
endfunction
function FT21_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function FT21_Func010Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="dj-")
endfunction
function FT21_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function FT21_Actions takes nothing returns nothing
if(FT21_Func001C())then
return
endif
if(FT21_Func002C())then
call ConditionalTriggerExecute(GT81)
return
endif
if(FT21_Func003C())then
if(FT21_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]="jb-"
endif
endif
if(FT21_Func004C())then
if(FT21_Func004Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]="mc-"
endif
endif
if(FT21_Func005C())then
if(FT21_Func005Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]="sm-"
endif
endif
if(FT21_Func006C())then
if(FT21_Func006Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]="mf-"
endif
endif
if(FT21_Func007C())then
if(FT21_Func007Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]="sd-"
endif
endif
if(FT21_Func008C())then
if(FT21_Func008Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]="sx-"
endif
endif
if(FT21_Func009C())then
if(FT21_Func009Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]="jy-"
endif
endif
if(FT21_Func010C())then
if(FT21_Func010Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=""
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]="dj-"
endif
endif
call ConditionalTriggerExecute(GT20)
endfunction
function FT22_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT22_Func009C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]!="no")
endfunction
function FT22_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="wizard"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0修改资源|r"+""))
if(FT22_Func009C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF禁用向导|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT23_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="wizard")
endfunction
function FT23_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT23_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT23_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT23_Actions takes nothing returns nothing
if(FT23_Func001C())then
return
endif
if(FT23_Func002C())then
call ConditionalTriggerExecute(GT79)
return
endif
if(FT23_Func003C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]="no"
call ConditionalTriggerExecute(GT22)
endif
endfunction
function FT24_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT24_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="KeySet"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00按键功能|r(快捷键:|cffFF00004|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0ESC|r键"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0上|r键"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0下|r键"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0左|r键"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0右|r键"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("查询按键功能"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("取消所有功能"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT25_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="KeySet")
endfunction
function FT25_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT25_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT25_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT25_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT25_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT25_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT25_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT25_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT25_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT25_Actions takes nothing returns nothing
if(FT25_Func001C())then
return
endif
if(FT25_Func002C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT25_Func003C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="s:"
call ConditionalTriggerExecute(GT26)
return
endif
if(FT25_Func004C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="x:"
call ConditionalTriggerExecute(GT26)
return
endif
if(FT25_Func005C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="z:"
call ConditionalTriggerExecute(GT26)
return
endif
if(FT25_Func006C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="y:"
call ConditionalTriggerExecute(GT26)
return
endif
if(FT25_Func007C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="e:"
call ConditionalTriggerExecute(GT26)
return
endif
if(FT25_Func008C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="e:?"
call ConditionalTriggerExecute(GT40)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT25_Func009C())then
set bj_forLoopAIndex=86
set bj_forLoopAIndexEnd=90
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=""
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT24)
return
endif
endfunction
function FT26_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT26_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="KeyFuct"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00按键功能|r(快捷键:|cffFF00004|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("立即回城"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("立即复活"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("立即死亡"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("单位无敌"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("取消无敌"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("瞬间移动"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("穿越物体"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("复制物品"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("地图全亮"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("脚本信息"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT27_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="KeyFuct")
endfunction
function FT27_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT27_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT27_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT27_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT27_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT27_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT27_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT27_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT27_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT27_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT27_Func011C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function FT27_Func012C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function FT27_Actions takes nothing returns nothing
if(FT27_Func001C())then
return
endif
if(FT27_Func002C())then
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func003C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"hc")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func004C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"fh")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func005C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"ss")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func006C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"wd")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func007C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"wdn")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func008C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"sy")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func009C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"cr")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func010C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"fzi")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func011C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"dt")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
if(FT27_Func012C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=(achat[(1+GetPlayerId(GetTriggerPlayer()))]+"info")
call ConditionalTriggerExecute(GT42)
call ConditionalTriggerExecute(GT24)
return
endif
endfunction
function FT28_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT28_Func002Func002Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="off")
endfunction
function FT28_Func002C takes nothing returns boolean
return(avg[1]=="off")
endfunction
function FT28_Func004Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT28_Actions takes nothing returns nothing
if(FT28_Func002C())then
call EnableTrigger(GT29)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT28_Func002Func002Func001C())then
set avg[bj_forLoopAIndex]="tuantuan"
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),2.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FF00主机开启了 tuantuan 加强模式!|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT3)
return
endif
call DisableTrigger(GT29)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT28_Func004Func001C())then
set avg[bj_forLoopAIndex]="off"
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),2.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cffFF0000主机关闭了 tuantuan 加强模式,所有玩家无法开启!|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set avg[1]="off"
endfunction
function FT29_Func003Func003001001 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="e:")
endfunction
function FT29_Func003Func003001002 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="s:")
endfunction
function FT29_Func003Func003001 takes nothing returns boolean
return GetBooleanOr(FT29_Func003Func003001001(),FT29_Func003Func003001002())
endfunction
function FT29_Func003Func003002001 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="y:")
endfunction
function FT29_Func003Func003002002001 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="z:")
endfunction
function FT29_Func003Func003002002002 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="x:")
endfunction
function FT29_Func003Func003002002 takes nothing returns boolean
return GetBooleanOr(FT29_Func003Func003002002001(),FT29_Func003Func003002002002())
endfunction
function FT29_Func003Func003002 takes nothing returns boolean
return GetBooleanOr(FT29_Func003Func003002001(),FT29_Func003Func003002002())
endfunction
function FT29_Func003C takes nothing returns boolean
return(GetBooleanOr(FT29_Func003Func003001(),FT29_Func003Func003002()))
endfunction
function FT29_Actions takes nothing returns nothing
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=GetEventPlayerChatString()
set avj[(1+GetPlayerId(GetTriggerPlayer()))]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)
if(FT29_Func003C())then
call ConditionalTriggerExecute(GT40)
return
endif
call ConditionalTriggerExecute(GT30)
endfunction
function FT30_Func001Func001Func004C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]!="no")
endfunction
function FT30_Func001Func001C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT30_Func001C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT30_Actions takes nothing returns nothing
if(FT30_Func001C())then
if(FT30_Func001Func001C())then
set avg[(1+GetPlayerId(GetTriggerPlayer()))]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cffFF0000tuantuan 加强模式关闭!|r"+""))
else
set avg[(1+GetPlayerId(GetTriggerPlayer()))]="tuantuan"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FF00tuantuan 加强模式开启!|r"+""))
call ConditionalTriggerExecute(GT3)
if(FT30_Func001Func001Func004C())then
call ConditionalTriggerExecute(GT22)
endif
endif
return
endif
call ConditionalTriggerExecute(GT31)
endfunction
function FT31_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT31_Func002Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sma")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function FT31_Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sma")
endfunction
function FT31_Func003Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mfa")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function FT31_Func003C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mfa")
endfunction
function FT31_Func004Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sda")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function FT31_Func004C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sda")
endfunction
function FT31_Func005Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jba")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function FT31_Func005C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jba")
endfunction
function FT31_Func006Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mca")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function FT31_Func006C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mca")
endfunction
function FT31_Func007Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sxa")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function FT31_Func007C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sxa")
endfunction
function FT31_Func008Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="lla")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=="ll")
endfunction
function FT31_Func008C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="lla")
endfunction
function FT31_Func009Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zla")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=="zl")
endfunction
function FT31_Func009C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="zla")
endfunction
function FT31_Func010Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mja")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=="mj")
endfunction
function FT31_Func010C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mja")
endfunction
function FT31_Func011Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dja")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function FT31_Func011C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="dja")
endfunction
function FT31_Func012Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jya")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=="jy")
endfunction
function FT31_Func012C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jya")
endfunction
function FT31_Actions takes nothing returns nothing
if(FT31_Func002C())then
if(FT31_Func002Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="sm"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func003C())then
if(FT31_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]="mf"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func004C())then
if(FT31_Func004Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]="sd"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func005C())then
if(FT31_Func005Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]="jb"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func006C())then
if(FT31_Func006Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]="mc"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func007C())then
if(FT31_Func007Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]="sx"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func008C())then
if(FT31_Func008Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]="ll"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func009C())then
if(FT31_Func009Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]="zl"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func010C())then
if(FT31_Func010Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]="mj"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func011C())then
if(FT31_Func011Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]="dj"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT31_Func012C())then
if(FT31_Func012Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]="jy"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
call ConditionalTriggerExecute(GT32)
endfunction
function FT32_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT32_Func002Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="smm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sm-")
endfunction
function FT32_Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="smm")
endfunction
function FT32_Func003Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mfm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="mf-")
endfunction
function FT32_Func003C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mfm")
endfunction
function FT32_Func004Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sdm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="sd-")
endfunction
function FT32_Func004C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sdm")
endfunction
function FT32_Func005Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jbm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="jb-")
endfunction
function FT32_Func005C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jbm")
endfunction
function FT32_Func006Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mcm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="mc-")
endfunction
function FT32_Func006C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mcm")
endfunction
function FT32_Func007Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sxm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sx-")
endfunction
function FT32_Func007C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sxm")
endfunction
function FT32_Func008Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="llm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=="ll-")
endfunction
function FT32_Func008C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="llm")
endfunction
function FT32_Func009Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zlm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=="zl-")
endfunction
function FT32_Func009C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="zlm")
endfunction
function FT32_Func010Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mjm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=="mj-")
endfunction
function FT32_Func010C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mjm")
endfunction
function FT32_Func011Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="djm")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="dj-")
endfunction
function FT32_Func011C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="djm")
endfunction
function FT32_Func012Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jya")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=="jy-")
endfunction
function FT32_Func012C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jym")
endfunction
function FT32_Actions takes nothing returns nothing
if(FT32_Func002C())then
if(FT32_Func002Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]="sm-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func003C())then
if(FT32_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]="mf-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func004C())then
if(FT32_Func004Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]="sd-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func005C())then
if(FT32_Func005Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]="jb-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func006C())then
if(FT32_Func006Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]="mc-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func007C())then
if(FT32_Func007Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]="sx-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func008C())then
if(FT32_Func008Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]="ll-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func009C())then
if(FT32_Func009Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]="zl-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func010C())then
if(FT32_Func010Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]="mj-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func011C())then
if(FT32_Func011Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]="dj-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT32_Func012C())then
if(FT32_Func012Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]="jy-"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
call ConditionalTriggerExecute(GT33)
endfunction
function FT33_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT33_Func001C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="hcd")
endfunction
function FT33_Func002Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jnd")
endfunction
function FT33_Func002Func003A takes nothing returns nothing
call ModifyHeroSkillPoints(GetEnumUnit(),0,avh[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function FT33_Func002C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jnd")
endfunction
function FT33_Func004C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="fw")
endfunction
function FT33_Func005Func001Func002A takes nothing returns nothing
call SetUnitLifePercentBJ(GetEnumUnit(),'d')
endfunction
function FT33_Func005Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sm")
endfunction
function FT33_Func005Func003A takes nothing returns nothing
call SetWidgetLife(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetEnumUnit())+I2R(avh[(1+GetPlayerId(GetTriggerPlayer()))])))
endfunction
function FT33_Func005C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sm")
endfunction
function FT33_Func006Func001Func001A takes nothing returns nothing
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
endfunction
function FT33_Func006Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mf")
endfunction
function FT33_Func006Func003A takes nothing returns nothing
call SetUnitManaBJ(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())+I2R(avh[(1+GetPlayerId(GetTriggerPlayer()))])))
endfunction
function FT33_Func006C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mf")
endfunction
function FT33_Func007Func001Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function FT33_Func007Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sd")
endfunction
function FT33_Func007Func003A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),(GetUnitDefaultMoveSpeed(GetEnumUnit())+I2R(avh[(1+GetPlayerId(GetTriggerPlayer()))])))
endfunction
function FT33_Func007C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sd")
endfunction
function FT33_Func008Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jb")
endfunction
function FT33_Func008Func004C takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>0)
endfunction
function FT33_Func008C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="jb")
endfunction
function FT33_Func009Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mc")
endfunction
function FT33_Func009Func004C takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>0)
endfunction
function FT33_Func009C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mc")
endfunction
function FT33_Actions takes nothing returns nothing
if(FT33_Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00回城点已设置 : |cffFF8000"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)])+"|r")))
return
endif
if(FT33_Func002C())then
if(FT33_Func002Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func002Func003A)
return
endif
if(FT33_Func004C())then
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=""
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=0
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=""
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT2)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00OK|r"+""))
return
endif
if(FT33_Func005C())then
if(FT33_Func005Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func005Func001Func002A)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func005Func003A)
return
endif
if(FT33_Func006C())then
if(FT33_Func006Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func006Func001Func001A)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func006Func003A)
return
endif
if(FT33_Func007C())then
if(FT33_Func007Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func007Func001Func001A)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,6))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT33_Func007Func003A)
return
endif
if(FT33_Func008C())then
if(FT33_Func008Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call AdjustPlayerStateBJ(avh[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
if(FT33_Func008Func004C())then
call AdjustPlayerStateBJ((avh[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
return
endif
if(FT33_Func009C())then
if(FT33_Func009Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call AdjustPlayerStateBJ(avh[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
if(FT33_Func009Func004C())then
call AdjustPlayerStateBJ((avh[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
return
endif
call ConditionalTriggerExecute(GT34)
endfunction
function FT34_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT34_Func001Func001C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT34_Func001Func002C takes nothing returns boolean
return(GetPlayerSlotState(Player(-1+(bj_forLoopAIndex)))==PLAYER_SLOT_STATE_PLAYING)and(GetPlayerController(Player(-1+(bj_forLoopAIndex)))==MAP_CONTROL_USER)
endfunction
function FT34_Func001C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="kz")
endfunction
function FT34_Func003Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+32)]=="cr")
endfunction
function FT34_Func003C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="cra")
endfunction
function FT34_Func004Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+30)]=="cr")
endfunction
function FT34_Func004C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="cr")
endfunction
function FT34_Func005Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+27)]=="sy")
endfunction
function FT34_Func005C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="sy")
endfunction
function FT34_Func006C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="info")
endfunction
function FT34_Func007Func001Func001A takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(),bj_forLoopAIndex))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT34_Func007Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sci")
endfunction
function FT34_Func007Func003A takes nothing returns nothing
call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(),avh[(1+GetPlayerId(GetTriggerPlayer()))]))
endfunction
function FT34_Func007C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sci")
endfunction
function FT34_Actions takes nothing returns nothing
if(FT34_Func001C())then
if(FT34_Func001Func001C())then
call SetPlayerAllianceStateBJ(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),GetTriggerPlayer(),5)
call SetPlayerAllianceBJ(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),ALLIANCE_PASSIVE,false,GetTriggerPlayer())
return
endif
if(FT34_Func001Func002C())then
return
endif
call SetPlayerAllianceStateBJ(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),GetTriggerPlayer(),5)
call SetPlayerAllianceBJ(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),ALLIANCE_PASSIVE,false,GetTriggerPlayer())
return
endif
if(FT34_Func003C())then
if(FT34_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+32)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+32)]="cr"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT34_Func004C())then
if(FT34_Func004Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+30)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+30)]="cr"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT34_Func005C())then
if(FT34_Func005Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+27)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+27)]="sy"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT34_Func006C())then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★★★★★★★★|cff00FF00www.|cffFFFF00RestPlay|cff00FF00.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00添加修改：团"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00QQ：565266718"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00有任何问题、建议请加群41142967讨论研究"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★★★★★★★★|cff00FF00www.|cffFFFF00RestPlay|cff00FF00.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("  "+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cff00FF00尊敬的玩家您好!谢谢使用由|cffFF0000tuantuan|cff00FF00制作的脚本,祝您游戏愉快!|r"+""))
return
endif
if(FT34_Func007C())then
if(FT34_Func007Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT34_Func007Func001Func001A)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT34_Func007Func003A)
return
endif
call ConditionalTriggerExecute(GT35)
endfunction
function FT35_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT35_Func001Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jy")
endfunction
function FT35_Func001Func003A takes nothing returns nothing
call AddHeroXPSwapped(avh[(1+GetPlayerId(GetTriggerPlayer()))],GetEnumUnit(),false)
endfunction
function FT35_Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="jy")
endfunction
function FT35_Func003Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dj")
endfunction
function FT35_Func003Func003A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+avh[(1+GetPlayerId(GetTriggerPlayer()))]),false)
endfunction
function FT35_Func003C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="dj")
endfunction
function FT35_Func004Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sx")
endfunction
function FT35_Func004Func003A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
call ModifyHeroStat(1,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
call ModifyHeroStat(2,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
endfunction
function FT35_Func004C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sx")
endfunction
function FT35_Func005Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="ll")
endfunction
function FT35_Func005Func003A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
endfunction
function FT35_Func005C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="ll")
endfunction
function FT35_Func006Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mj")
endfunction
function FT35_Func006Func003A takes nothing returns nothing
call ModifyHeroStat(1,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
endfunction
function FT35_Func006C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mj")
endfunction
function FT35_Func007Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zl")
endfunction
function FT35_Func007Func003A takes nothing returns nothing
call ModifyHeroStat(2,GetEnumUnit(),0,(avh[(1+GetPlayerId(GetTriggerPlayer()))]+0))
endfunction
function FT35_Func007C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="zl")
endfunction
function FT35_Actions takes nothing returns nothing
if(FT35_Func001C())then
if(FT35_Func001Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func001Func003A)
return
endif
if(FT35_Func003C())then
if(FT35_Func003Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func003Func003A)
return
endif
if(FT35_Func004C())then
if(FT35_Func004Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func004Func003A)
return
endif
if(FT35_Func005C())then
if(FT35_Func005Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func005Func003A)
return
endif
if(FT35_Func006C())then
if(FT35_Func006Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func006Func003A)
return
endif
if(FT35_Func007C())then
if(FT35_Func007Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT35_Func007Func003A)
return
endif
call ConditionalTriggerExecute(GT36)
endfunction
function FT36_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT36_Func002Func001Func001A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function FT36_Func002Func001C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT36_Func002Func002Func001A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function FT36_Func002Func002C takes nothing returns boolean
return(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))])==GetTriggerPlayer())
endfunction
function FT36_Func002C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="sc")
endfunction
function FT36_Func003Func001A takes nothing returns nothing
call KillUnit(GetEnumUnit())
endfunction
function FT36_Func003C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="ss")
endfunction
function FT36_Func004Func001Func001A takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),GetTriggerPlayer(),true)
endfunction
function FT36_Func004Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zx")
endfunction
function FT36_Func004Func003Func001001 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<1)
endfunction
function FT36_Func004Func003Func001002 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>16)
endfunction
function FT36_Func004Func003C takes nothing returns boolean
return(GetBooleanOr(FT36_Func004Func003Func001001(),FT36_Func004Func003Func001002()))
endfunction
function FT36_Func004Func004Func001A takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),Player(-1+(avh[(1+GetPlayerId(GetTriggerPlayer()))])),true)
endfunction
function FT36_Func004Func004C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT36_Func004Func005Func001A takes nothing returns nothing
call SetUnitOwner(GetEnumUnit(),Player(-1+(avh[(1+GetPlayerId(GetTriggerPlayer()))])),true)
endfunction
function FT36_Func004Func005C takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]==16)
endfunction
function FT36_Func004C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="zx")
endfunction
function FT36_Func005Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function FT36_Func005C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="wd")
endfunction
function FT36_Func006Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function FT36_Func006C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="wdn")
endfunction
function FT36_Actions takes nothing returns nothing
if(FT36_Func002C())then
if(FT36_Func002Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func002Func001Func001A)
return
endif
if(FT36_Func002Func002C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func002Func002Func001A)
return
endif
endif
if(FT36_Func003C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func003Func001A)
return
endif
if(FT36_Func004C())then
if(FT36_Func004Func001C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func004Func001Func001A)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
if(FT36_Func004Func003C())then
return
endif
if(FT36_Func004Func004C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func004Func004Func001A)
return
endif
if(FT36_Func004Func005C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func004Func005Func001A)
endif
return
endif
if(FT36_Func005C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func005Func001A)
return
endif
if(FT36_Func006C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT36_Func006Func001A)
return
endif
call ConditionalTriggerExecute(GT37)
endfunction
function FT37_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT37_Func002Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="fh")
endfunction
function FT37_Func002C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="fh")
endfunction
function FT37_Func003Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=="map")
endfunction
function FT37_Func003C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="dt")
endfunction
function FT37_Func004Func003C takes nothing returns boolean
return(avg[25]=="allmap")
endfunction
function FT37_Func004C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="dta")
endfunction
function FT37_Func005Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+34)]=="jna")
endfunction
function FT37_Func005C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="jna")
endfunction
function FT37_Func006Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="jn")
endfunction
function FT37_Func006C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="jn")
endfunction
function FT37_Func007Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function FT37_Func007C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="bf")
endfunction
function FT37_Func008C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="lx")
endfunction
function FT37_Actions takes nothing returns nothing
if(FT37_Func002C())then
if(FT37_Func002Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="fh"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func003C())then
if(FT37_Func003Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=""
call DestroyFogModifier(avf[(1+GetPlayerId(GetTriggerPlayer()))])
set avf[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_MASKED,GetWorldBounds())
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]="map"
call DestroyFogModifier(avf[(1+GetPlayerId(GetTriggerPlayer()))])
set avf[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetWorldBounds())
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func004C())then
if(FT37_Func004Func003C())then
set avg[25]=""
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(avf[bj_forLoopAIndex])
set avf[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_MASKED,GetWorldBounds())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[25]="allmap"
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(avf[bj_forLoopAIndex])
set avf[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_VISIBLE,GetWorldBounds())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func005C())then
if(FT37_Func005Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+34)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+34)]="jna"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func006C())then
if(FT37_Func006Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="jn"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func007C())then
if(FT37_Func007Func001C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]="bf"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(FT37_Func008C())then
call DoNotSaveReplay ()
set ava[3]="off"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00OK|r"+""))
return
endif
call ConditionalTriggerExecute(GT38)
endfunction
function FT38_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT38_Func002C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="hc")
endfunction
function FT38_Func003C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="hcn")
endfunction
function FT38_Func004C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="fz")
endfunction
function FT38_Func005C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="yd")
endfunction
function FT38_Func006C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="jh")
endfunction
function FT38_Func007C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="zh")
endfunction
function FT38_Func008Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dli")
endfunction
function FT38_Func008C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="dli")
endfunction
function FT38_Func009Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="fzi")
endfunction
function FT38_Func009Func003C takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<1)and(avh[(1+GetPlayerId(GetTriggerPlayer()))]>6)
endfunction
function FT38_Func009C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="fzi")
endfunction
function FT38_Func010Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="xx")
endfunction
function FT38_Func010C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="xx")
endfunction
function FT38_Func011Func001C takes nothing returns boolean
return(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(achat[(1+GetPlayerId(GetTriggerPlayer()))]))=="tc")
endfunction
function FT38_Func011Func003C takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<1)and(avh[(1+GetPlayerId(GetTriggerPlayer()))]>12)
endfunction
function FT38_Func011C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="tc")
endfunction
function FT38_Actions takes nothing returns nothing
if(FT38_Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]="hc"
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
return
endif
if(FT38_Func003C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=""
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=null
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
return
endif
if(FT38_Func004C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uCopy"
return
endif
if(FT38_Func005C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uMove"
return
endif
if(FT38_Func006C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uExch"
return
endif
if(FT38_Func007C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uPer"
return
endif
if(FT38_Func008C())then
if(FT38_Func008Func001C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitRemoveItemFromSlotSwapped(bj_forLoopAIndex,avk[(1+GetPlayerId(GetTriggerPlayer()))])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
call UnitRemoveItemFromSlotSwapped(avh[(1+GetPlayerId(GetTriggerPlayer()))],avk[(1+GetPlayerId(GetTriggerPlayer()))])
return
endif
if(FT38_Func009C())then
if(FT38_Func009Func001C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="iAll"
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
if(FT38_Func009Func003C())then
return
endif
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="iOne"
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=avh[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(FT38_Func010C())then
if(FT38_Func010Func001C())then
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]=10
call ConditionalTriggerExecute(GT56)
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
set aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]=avh[(1+GetPlayerId(GetTriggerPlayer()))]
call ConditionalTriggerExecute(GT56)
return
endif
if(FT38_Func011C())then
if(FT38_Func011Func001C())then
return
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
if(FT38_Func011Func003C())then
return
endif
call CustomVictoryBJ(Player(-1+(avh[(1+GetPlayerId(GetTriggerPlayer()))])),false,false)
return
endif
call ConditionalTriggerExecute(GT39)
endfunction
function FT39_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT39_Func001C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]==".")
endfunction
function FT39_Func002C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="+")
endfunction
function FT39_Func003C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="-")
endfunction
function FT39_Func004C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="0")
endfunction
function FT39_Func005C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="1")
endfunction
function FT39_Func006C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="2")
endfunction
function FT39_Func007Func001C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT39_Func007C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="3")
endfunction
function FT39_Func008C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="4")
endfunction
function FT39_Func009C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="5")
endfunction
function FT39_Func010C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="6")
endfunction
function FT39_Func011C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="7")
endfunction
function FT39_Func012Func001C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)!=null)
endfunction
function FT39_Func012C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="8")
endfunction
function FT39_Func013C takes nothing returns boolean
return(achat[(1+GetPlayerId(GetTriggerPlayer()))]=="9")
endfunction
function FT39_Actions takes nothing returns nothing
if(FT39_Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000.|r : |cff00FF00快捷菜单帮助"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF00001|r : |cff00FF00设置自己的资源"+"    |cffFF00002|r : |cff00FF00游戏设置"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF00003|r : |cffFFFF00特殊命令"+"    |cffFF00004|r : |cff00FF00按键功能设置"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF00005|r : |cff00FF00单位菜单"+"    |cffFF00006|r : |cff00FF00单位高级命令"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF00007|r : |cff00FF00单位属性"+"    |cffFF00008|r : |cff00FF00给予英雄物品"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF00009|r : |cff00FF00单位保护菜单"+"    |cffFF00000|r : |cff00FF00主菜单"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000+|r : |cff00FF00自动增加(盟友)"+"    |cffFF0000-|r : |cff00FF00自动减少(敌人)"))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cff0080FF详细说明请访问 : |cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r"+""))
return
endif
if(FT39_Func002C())then
call ConditionalTriggerExecute(GT18)
return
endif
if(FT39_Func003C())then
call ConditionalTriggerExecute(GT20)
return
endif
if(FT39_Func004C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT39_Func005C())then
call ConditionalTriggerExecute(GT79)
return
endif
if(FT39_Func006C())then
call ConditionalTriggerExecute(GT83)
return
endif
if(FT39_Func007C())then
if(FT39_Func007Func001C())then
call ConditionalTriggerExecute(GT85)
else
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="|cffFF0000你不是第一玩家,没有特别权限!|r"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="以|cff00FF00第1玩家(红色)建立游戏|r后使用"
call ConditionalTriggerExecute(GT57)
endif
return
endif
if(FT39_Func008C())then
call ConditionalTriggerExecute(GT24)
return
endif
if(FT39_Func009C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT39_Func010C())then
call ConditionalTriggerExecute(GT67)
return
endif
if(FT39_Func011C())then
call ConditionalTriggerExecute(GT63)
return
endif
if(FT39_Func012C())then
if(FT39_Func012Func001C())then
call ConditionalTriggerExecute(GT8)
else
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="|cffFF0000此单位非英雄或者不能给予物品!|r"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="请|cff00FF00选择一名英雄|r后再打开"
call ConditionalTriggerExecute(GT57)
endif
return
endif
if(FT39_Func013C())then
call ConditionalTriggerExecute(GT70)
return
endif
endfunction
function FT40_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT40_Func002Func002C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]=="have")
endfunction
function FT40_Func002Func003C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]=="have")
endfunction
function FT40_Func002Func004C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]=="have")
endfunction
function FT40_Func002Func005C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]=="have")
endfunction
function FT40_Func002Func006C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]=="have")
endfunction
function FT40_Func002C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="?")
endfunction
function FT40_Func003C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]!="-")
endfunction
function FT40_Func005C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="e:")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]=="have")
endfunction
function FT40_Func006C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="s:")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]=="have")
endfunction
function FT40_Func007C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="x:")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]=="have")
endfunction
function FT40_Func008C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="z:")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]=="have")
endfunction
function FT40_Func009C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="y:")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]=="have")
endfunction
function FT40_Actions takes nothing returns nothing
set avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,3)
if(FT40_Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cff00FF00您已经对以下按键设置了功能 : |r"+""))
if(FT40_Func002Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000ESC|r键 : |cff00FF00"+(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]+"|r")))
endif
if(FT40_Func002Func003C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000上|r键 : |cff00FF00"+(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]+"|r")))
endif
if(FT40_Func002Func004C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000下|r键 : |cff00FF00"+(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]+"|r")))
endif
if(FT40_Func002Func005C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000左|r键 : |cff00FF00"+(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]+"|r")))
endif
if(FT40_Func002Func006C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000右|r键 : |cff00FF00"+(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]+"|r")))
endif
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("所有支持的命令请登录|cff00FF00www.|cffFFFF00RestPlay|cff00FF00.com|r查阅|cffFF0000CiV|r1.0版说明"+""))
return
endif
if(FT40_Func003C())then
call ConditionalTriggerExecute(GT41)
return
endif
set avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)
if(FT40_Func005C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
endif
if(FT40_Func006C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
endif
if(FT40_Func007C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
endif
if(FT40_Func008C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
endif
if(FT40_Func009C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
endif
endfunction
function FT41_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT41_Func002Func002Func003001 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>6)
endfunction
function FT41_Func002Func002Func003002 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<1)
endfunction
function FT41_Func002Func002C takes nothing returns boolean
return(GetBooleanOr(FT41_Func002Func002Func003001(),FT41_Func002Func002Func003002()))
endfunction
function FT41_Func002Func003Func003001 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>6)
endfunction
function FT41_Func002Func003Func003002 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<1)
endfunction
function FT41_Func002Func003C takes nothing returns boolean
return(GetBooleanOr(FT41_Func002Func003Func003001(),FT41_Func002Func003Func003002()))
endfunction
function FT41_Func002Func004001001 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="fzi")
endfunction
function FT41_Func002Func004001002 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="dli")
endfunction
function FT41_Func002Func004001 takes nothing returns boolean
return GetBooleanOr(FT41_Func002Func004001001(),FT41_Func002Func004001002())
endfunction
function FT41_Func002Func004002 takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="sci")
endfunction
function FT41_Func002C takes nothing returns boolean
return(GetBooleanOr(FT41_Func002Func004001(),FT41_Func002Func004002()))
endfunction
function FT41_Func003Func002Func003001 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>0xF4240)
endfunction
function FT41_Func003Func002Func003002 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<-0xF4240)
endfunction
function FT41_Func003Func002C takes nothing returns boolean
return(GetBooleanOr(FT41_Func003Func002Func003001(),FT41_Func003Func002Func003002()))
endfunction
function FT41_Func003C takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="jnd")
endfunction
function FT41_Func005Func003001 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]>0xF4240)
endfunction
function FT41_Func005Func003002 takes nothing returns boolean
return(avh[(1+GetPlayerId(GetTriggerPlayer()))]<-0xF4240)
endfunction
function FT41_Func005C takes nothing returns boolean
return(GetBooleanOr(FT41_Func005Func003001(),FT41_Func005Func003002()))
endfunction
function FT41_Actions takes nothing returns nothing
set avj[(1+GetPlayerId(GetTriggerPlayer()))]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,5)
if(FT41_Func002C())then
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],6,7))
if(FT41_Func002Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000数值错误!|r"+""))
return
endif
if(FT41_Func002Func003C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000数值错误!|r"+""))
return
endif
endif
if(FT41_Func003C())then
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],6,12))
if(FT41_Func003Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000数值错误!|r"+""))
return
endif
endif
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],5,11))
if(FT41_Func005C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000数值错误!|r"+""))
return
endif
call ConditionalTriggerExecute(GT42)
endfunction
function FT42_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT42_Func003C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="e:")
endfunction
function FT42_Func004C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="s:")
endfunction
function FT42_Func005C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="x:")
endfunction
function FT42_Func006C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="z:")
endfunction
function FT42_Func007C takes nothing returns boolean
return(avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="y:")
endfunction
function FT42_Func008C takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="hc")and(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]==null)
endfunction
function FT42_Actions takes nothing returns nothing
set avj[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)
set avj[(1+GetPlayerId(GetTriggerPlayer()))]=SubStringBJ(achat[(1+GetPlayerId(GetTriggerPlayer()))],3,12)
if(FT42_Func003C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]=avj[(1+GetPlayerId(GetTriggerPlayer()))]
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]="have"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
if(FT42_Func004C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]=avj[(1+GetPlayerId(GetTriggerPlayer()))]
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]="have"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
if(FT42_Func005C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]=avj[(1+GetPlayerId(GetTriggerPlayer()))]
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]="have"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
if(FT42_Func006C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]=avj[(1+GetPlayerId(GetTriggerPlayer()))]
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]="have"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
if(FT42_Func007C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]=avj[(1+GetPlayerId(GetTriggerPlayer()))]
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]="have"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
if(FT42_Func008C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="no"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="|cffFF0000没有回城点或者回城点被取消了!|r"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="请|cff00FF00左键单击任意单位|r(最好是基地)"
call ConditionalTriggerExecute(GT57)
else
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=""
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=""
endfunction
function FT43_Func002C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]=="have")
endfunction
function FT43_Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=="esc4")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]!="have")
endfunction
function FT43_Func004C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=="esc3")
endfunction
function FT43_Func005C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=="esc2")
endfunction
function FT43_Func006C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=="esc1")
endfunction
function FT43_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]="ok"
if(FT43_Func002C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]
call ConditionalTriggerExecute(GT48)
endif
if(FT43_Func003C())then
call ConditionalTriggerExecute(GT77)
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
return
endif
if(FT43_Func004C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]="esc4"
return
endif
if(FT43_Func005C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]="esc3"
return
endif
if(FT43_Func006C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]="esc2"
return
else
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]="esc1"
endif
endfunction
function FT44_Func002Func002C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="off")
endfunction
function FT44_Func002Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT44_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=="ok")
endfunction
function FT44_Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]=="have")
endfunction
function FT44_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
if(FT44_Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=""
if(FT44_Func002Func002C())then
return
endif
if(FT44_Func002Func003C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),2.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FFFFtuantuan 加强模式已经开启!|r"+""))
return
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="tuantuan"
call ConditionalTriggerExecute(GT30)
return
endif
if(FT44_Func003C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+89)]
call ConditionalTriggerExecute(GT48)
return
endif
endfunction
function FT45_Func002Func002C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="off")
endfunction
function FT45_Func002Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]!="tuantuan")
endfunction
function FT45_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=="ok")
endfunction
function FT45_Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]=="have")
endfunction
function FT45_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
if(FT45_Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=""
if(FT45_Func002Func002C())then
return
endif
if(FT45_Func002Func003C())then
return
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="tuantuan"
call ConditionalTriggerExecute(GT30)
return
endif
if(FT45_Func003C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+88)]
call ConditionalTriggerExecute(GT48)
return
endif
endfunction
function FT46_Func002Func002C takes nothing returns boolean
return(GetTriggerPlayer()!=Player(0))
endfunction
function FT46_Func002Func003C takes nothing returns boolean
return(avg[1]!="off")
endfunction
function FT46_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=="ok")
endfunction
function FT46_Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]=="have")
endfunction
function FT46_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
if(FT46_Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=""
if(FT46_Func002Func002C())then
return
endif
if(FT46_Func002Func003C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),2.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FFFF所有玩家 tuantuan 加强模式并未关闭!|r"+""))
return
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="ngkciv"
call ConditionalTriggerExecute(GT28)
return
endif
if(FT46_Func003C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+87)]
call ConditionalTriggerExecute(GT48)
return
endif
endfunction
function FT47_Func002Func002C takes nothing returns boolean
return(GetTriggerPlayer()!=Player(0))
endfunction
function FT47_Func002Func003C takes nothing returns boolean
return(avg[1]=="off")
endfunction
function FT47_Func002Func004C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]!="tuantuan")
endfunction
function FT47_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=="ok")
endfunction
function FT47_Func003C takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]=="have")
endfunction
function FT47_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
if(FT47_Func002C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=""
if(FT47_Func002Func002C())then
return
endif
if(FT47_Func002Func003C())then
return
endif
if(FT47_Func002Func004C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),2.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cffFF0000主机关闭了 tuantuan 加强模式,所有玩家无法开启!|r"+""))
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="ngkciv"
call ConditionalTriggerExecute(GT28)
return
endif
if(FT47_Func003C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+86)]
call ConditionalTriggerExecute(GT48)
return
endif
endfunction
function FT48_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT48_Func001Func001C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]==null)
endfunction
function FT48_Func001Func002Func002A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]))
endfunction
function FT48_Func001Func002C takes nothing returns boolean
return(GetUnitStateSwap(UNIT_STATE_LIFE,avk[(1+GetPlayerId(GetTriggerPlayer()))])>.0)
endfunction
function FT48_Func001Func003A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]))
endfunction
function FT48_Func001Func005A takes nothing returns nothing
call ReviveHeroLoc(GetEnumUnit(),GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))]),false)
set avk[(1+GetPlayerId(GetTriggerPlayer()))]=GetEnumUnit()
endfunction
function FT48_Func001C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="hc")
endfunction
function FT48_Func002Func001A takes nothing returns nothing
call UnitResetCooldown(GetEnumUnit())
endfunction
function FT48_Func002C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="jn")
endfunction
function FT48_Func003Func001A takes nothing returns nothing
call UnitRemoveBuffsBJ(1,GetEnumUnit())
endfunction
function FT48_Func003C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="bf")
endfunction
function FT48_Func004Func001C takes nothing returns boolean
return(IsUnitDeadBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))])==false)and(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)==false)
endfunction
function FT48_Func004Func002A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]))
endfunction
function FT48_Func004Func004A takes nothing returns nothing
call ReviveHeroLoc(GetEnumUnit(),GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))]),false)
set avk[(1+GetPlayerId(GetTriggerPlayer()))]=GetEnumUnit()
endfunction
function FT48_Func004C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="fh")
endfunction
function FT48_Func005Func001A takes nothing returns nothing
call SetUnitPathing(GetEnumUnit(),true)
endfunction
function FT48_Func005C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="crn")
endfunction
function FT48_Func006Func001A takes nothing returns nothing
call SetUnitPathing(GetEnumUnit(),false)
endfunction
function FT48_Func006C takes nothing returns boolean
return(achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="cr")
endfunction
function FT48_Actions takes nothing returns nothing
if(FT48_Func001C())then
if(FT48_Func001Func001C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="no"
call ConditionalTriggerExecute(GT57)
return
else
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=""
endif
if(FT48_Func001Func002C())then
call TriggerSleepAction(.0)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func001Func002Func002A)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]),1.)
return
endif
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func001Func003A)
call TriggerSleepAction(.0)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func001Func005A)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))]),1.)
return
endif
if(FT48_Func002C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func002Func001A)
return
endif
if(FT48_Func003C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func003Func001A)
return
endif
if(FT48_Func004C())then
if(FT48_Func004Func001C())then
return
endif
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func004Func002A)
call TriggerSleepAction(.0)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func004Func004A)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))]),1.)
return
endif
if(FT48_Func005C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func005Func001A)
return
endif
if(FT48_Func006C())then
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function FT48_Func006Func001A)
return
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]
call ConditionalTriggerExecute(GT33)
endfunction
function FT49_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT49_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+32)]=="cr")
endfunction
function FT49_Func016C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="iOne")
endfunction
function FT49_Func017C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="iAll")
endfunction
function FT49_Func018C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="uPer")
endfunction
function FT49_Func019C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="uExch")
endfunction
function FT49_Func020C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="uMove")
endfunction
function FT49_Func021C takes nothing returns boolean
return(avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=="uCopy")
endfunction
function FT49_Func023Func002C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)==false)
endfunction
function FT49_Func023Func003Func001C takes nothing returns boolean
return(avk[(1+GetPlayerId(GetTriggerPlayer()))]==avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT49_Func023C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="yes")
endfunction
function FT49_Func024C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="no")
endfunction
function FT49_Func025C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]!="off")and(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+90)]!="have")and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=="esc2")
endfunction
function FT49_Func027C takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer())
endfunction
function FT49_Func028C takes nothing returns boolean
return(IsPlayerAlly(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function FT49_Func029C takes nothing returns boolean
return(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function FT49_Actions takes nothing returns nothing
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+92)]=""
if(FT49_Func002C())then
call SetUnitPathing(GetTriggerUnit(),false)
endif
if(FT49_Func016C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)])),GetTriggerUnit())
return
endif
if(FT49_Func017C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],bj_forLoopAIndex)),GetTriggerUnit())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if(FT49_Func018C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))])
set avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
call SetUnitPositionLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))],avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
call CreateNUnitsAtLoc(1,'ewsp',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call SetUnitOwner(GetTriggerUnit(),GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),true)
call SetUnitOwner(avk[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(bj_lastCreatedUnit),true)
call RemoveUnit(bj_lastCreatedUnit)
return
endif
if(FT49_Func019C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
set avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=GetUnitLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))])
set avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
call SetUnitPositionLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))],avi[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
return
endif
if(FT49_Func020C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call SetUnitPositionLoc(avk[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
return
endif
if(FT49_Func021C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]=""
call CreateNUnitsAtLoc(1,'ewsp',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call ReplaceUnitBJ(bj_lastCreatedUnit,GetUnitTypeId(avk[(1+GetPlayerId(GetTriggerPlayer()))]),3)
call SetUnitOwner(bj_lastReplacedUnit,GetTriggerPlayer(),true)
call SetHeroLevelBJ(bj_lastReplacedUnit,GetHeroLevel(avk[(1+GetPlayerId(GetTriggerPlayer()))]),false)
call ModifyHeroStat(0,bj_lastReplacedUnit,2,GetHeroStatBJ(0,avk[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(1,bj_lastReplacedUnit,2,GetHeroStatBJ(1,avk[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(2,bj_lastReplacedUnit,2,GetHeroStatBJ(2,avk[(1+GetPlayerId(GetTriggerPlayer()))],true))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],bj_forLoopAIndex)),bj_lastReplacedUnit)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(bj_lastReplacedUnit),1.)
return
endif
set avk[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
if(FT49_Func023C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=""
if(FT49_Func023Func002C())then
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="|cffFF0000非英雄单位,请重新选择!|r"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="请|cff00FF00选择一个英雄|r"
call ConditionalTriggerExecute(GT57)
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="yes"
return
endif
set bj_forLoopAIndex=95
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT49_Func023Func003Func001C())then
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="|cffFF0000已在保护列表中,请重新添加!|r"
set avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]="请|cff00FF00左键单击任意单位|r"
call ConditionalTriggerExecute(GT57)
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="yes"
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GT72)
return
endif
if(FT49_Func024C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=""
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00回城点已设置 : |cffFF8000"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)])+"|r")))
return
endif
if(FT49_Func025C())then
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
call ConditionalTriggerExecute(GT59)
return
endif
set avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)]=""
if(FT49_Func027C())then
call ConditionalTriggerExecute(GT50)
endif
if(FT49_Func028C())then
call ConditionalTriggerExecute(GT51)
endif
if(FT49_Func029C())then
call ConditionalTriggerExecute(GT52)
endif
endfunction
function FT50_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT50_Func003C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+34)]=="jna")
endfunction
function FT50_Func005C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+30)]=="cr")
endfunction
function FT50_Func006C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+27)]=="sy")
endfunction
function FT50_Actions takes nothing returns nothing
if(FT50_Func003C())then
call SetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit(),10000)
endif
if(FT50_Func005C())then
call SetUnitPathing(GetTriggerUnit(),false)
endif
if(FT50_Func006C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endif
endfunction
function FT51_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT51_Func004C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="jn")
endfunction
function FT51_Func005C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function FT51_Func006C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=="sm")
endfunction
function FT51_Func007C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=="mf")
endfunction
function FT51_Func008C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=="sd")
endfunction
function FT51_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=="jb")
endfunction
function FT51_Func010C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=="mc")
endfunction
function FT51_Func011C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=="sx")
endfunction
function FT51_Func012C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=="ll")
endfunction
function FT51_Func013C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=="zl")
endfunction
function FT51_Func014C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=="mj")
endfunction
function FT51_Func015C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]=="dj")
endfunction
function FT51_Func016C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]=="jy")
endfunction
function FT51_Actions takes nothing returns nothing
if(FT51_Func004C())then
call UnitResetCooldown(GetTriggerUnit())
endif
if(FT51_Func005C())then
call UnitRemoveBuffsBJ(1,GetTriggerUnit())
endif
if(FT51_Func006C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())+I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])))
endif
if(FT51_Func007C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])))
endif
if(FT51_Func008C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())+I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])))
endif
if(FT51_Func009C())then
call AdjustPlayerStateBJ(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_GOLD_GATHERED)
endif
if(FT51_Func010C())then
call AdjustPlayerStateBJ(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_LUMBER_GATHERED)
endif
if(FT51_Func011C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(1,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
call ModifyHeroStat(2,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endif
if(FT51_Func012C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endif
if(FT51_Func013C())then
call ModifyHeroStat(2,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endif
if(FT51_Func014C())then
call ModifyHeroStat(1,GetTriggerUnit(),0,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endif
if(FT51_Func015C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+13)]),false)
endif
if(FT51_Func016C())then
call SetHeroXP(GetTriggerUnit(),(GetHeroXP(GetTriggerUnit())+aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+28)]),false)
endif
endfunction
function FT52_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT52_Func002C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)]=="sm-")
endfunction
function FT52_Func003C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)]=="mf-")
endfunction
function FT52_Func004C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)]=="sd-")
endfunction
function FT52_Func005C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]=="jb-")
endfunction
function FT52_Func006C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]=="mc-")
endfunction
function FT52_Func007C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=="sx-")
endfunction
function FT52_Func008C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=="ll-")
endfunction
function FT52_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)]=="zl-")
endfunction
function FT52_Func010C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=="mj-")
endfunction
function FT52_Func011C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]=="dj-")
endfunction
function FT52_Func012C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]=="jy-")
endfunction
function FT52_Actions takes nothing returns nothing
if(FT52_Func002C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())-I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+19)])))
endif
if(FT52_Func003C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())-I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+20)])))
endif
if(FT52_Func004C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())-I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+21)])))
endif
if(FT52_Func005C())then
call AdjustPlayerStateBJ((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+22)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
endif
if(FT52_Func006C())then
call AdjustPlayerStateBJ((aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+23)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(FT52_Func007C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
call ModifyHeroStat(1,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
call ModifyHeroStat(2,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
endif
if(FT52_Func008C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endif
if(FT52_Func009C())then
call ModifyHeroStat(2,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+16)])
endif
if(FT52_Func010C())then
call ModifyHeroStat(1,GetTriggerUnit(),1,aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endif
if(FT52_Func011C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())-aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+18)]),false)
endif
if(FT52_Func012C())then
call SetHeroXP(GetTriggerUnit(),(GetHeroXP(GetTriggerUnit())-aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+29)]),false)
endif
endfunction
function FT53_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))]=="tuantuan")and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))
endfunction
function FT53_Func003C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))*'d')+26)]=="hc")
endfunction
function FT53_Func004C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))*'d')+1)]=="fh")
endfunction
function FT53_Func005Func001Func001C takes nothing returns boolean
return(avk[((bj_forLoopAIndex*'d')+bj_forLoopBIndex)]==GetTriggerUnit())
endfunction
function FT53_Actions takes nothing returns nothing
if(FT53_Func003C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))*'d')+26)]))
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),1.)
return
endif
if(FT53_Func004C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))*'d')+26)]))
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),1.)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=95
set bj_forLoopBIndexEnd=99
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if(FT53_Func005Func001Func001C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetOwningPlayer(GetTriggerUnit())))*'d')+26)]))
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
call PanCameraToTimedLocForPlayer(Player(-1+(bj_forLoopAIndex)),GetUnitLoc(GetTriggerUnit()),1.)
return
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT54_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")and(R2I(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit()))==0)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=="hc")
endfunction
function FT54_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]))
call TriggerSleepAction(.0)
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),1.)
endfunction
function FT55_Func002Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT55_Func004Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT55_Func006Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT55_Func008Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT55_Actions takes nothing returns nothing
call TriggerSleepAction(725.)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT55_Func002Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    (tuantuan脚本 |cFFFF0000CiV |r|cFF00FF001.0|r正式版)"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call TriggerSleepAction(725.)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT55_Func004Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cff00FF00有|cffFF0000超过50种|cff00FF00按键功能供您使用,详细请登录|cffFFFF00www.RestPlay.com|cff00FF00查阅|cffFF0000CiV|cff00FF001.0版说明|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call TriggerSleepAction(725.)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT55_Func006Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FF00tuantuan出品  必属精品|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call TriggerSleepAction(725.)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT55_Func008Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r    |cff00FF00如果您发现脚本存在BUG,请及时通知我,谢谢!|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ConditionalTriggerExecute(GetTriggeringTrigger())
endfunction
function FT56_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT56_Func002Func001Func001C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT56_Func002Func001Func002C takes nothing returns boolean
return(avg[bj_forLoopAIndex]=="tuantuan")
endfunction
function FT56_Func002Func001C takes nothing returns boolean
return(GetPlayerSlotState(Player(-1+(bj_forLoopAIndex)))==PLAYER_SLOT_STATE_PLAYING)and(GetPlayerController(Player(-1+(bj_forLoopAIndex)))==MAP_CONTROL_USER)
endfunction
function FT56_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT56_Func002Func001C())then
if(FT56_Func002Func001Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-]")+" |cffFF0000NGK|cff00FF00 ")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cff00FF00")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
else
if(FT56_Func002Func001Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cffFF0000NGK|cffC0C0C0 ")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(aval[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+35)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cffC0C0C0")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT57_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT57_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="hcUnit"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],avj[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT58_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT58_Func001Func004C takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="KeySet")or(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="KeyFuct")
endfunction
function FT58_Func001C takes nothing returns boolean
return(FT58_Func001Func004C())
endfunction
function FT58_Actions takes nothing returns nothing
if(FT58_Func001C())then
call ConditionalTriggerExecute(GT25)
call ConditionalTriggerExecute(GT27)
return
endif
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=""
call ConditionalTriggerExecute(GT9)
call ConditionalTriggerExecute(GT11)
call ConditionalTriggerExecute(GT13)
call ConditionalTriggerExecute(GT15)
call ConditionalTriggerExecute(GT17)
call ConditionalTriggerExecute(GT19)
call ConditionalTriggerExecute(GT21)
call ConditionalTriggerExecute(GT60)
call ConditionalTriggerExecute(GT62)
call ConditionalTriggerExecute(GT64)
call ConditionalTriggerExecute(GT66)
call ConditionalTriggerExecute(GT68)
call ConditionalTriggerExecute(GT71)
call ConditionalTriggerExecute(GT76)
call ConditionalTriggerExecute(GT75)
call ConditionalTriggerExecute(GT78)
call ConditionalTriggerExecute(GT80)
call ConditionalTriggerExecute(GT82)
call ConditionalTriggerExecute(GT84)
call ConditionalTriggerExecute(GT86)
call ConditionalTriggerExecute(GT88)
call ConditionalTriggerExecute(GT90)
call ConditionalTriggerExecute(GT23)
set achat[(1+GetPlayerId(GetTriggerPlayer()))]=""
endfunction
function FT59_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT59_Func008C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)!=null)
endfunction
function FT59_Func011C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]==avk[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function FT59_Func013C takes nothing returns boolean
return(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))])==GetTriggerPlayer())
endfunction
function FT59_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="SelMain"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00E-mail : |cff00FF00tuantuan@Gmail.Com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
if(FT59_Func008C())then
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0给予|r"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|cffFF80C0物品|r")))
endif
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0设置|r"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|cffFF80C0的属性|r")))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(FT59_Func011C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000取消回城点|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF设置|r"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|cff00FFFF为回城点|r")))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(FT59_Func013C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000修改资源|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF80C0修改|r"+(GetPlayerName(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]))+"|cffFF80C0的资源|r"))+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0高级命令|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0单位保护|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT60_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="SelMain")
endfunction
function FT60_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT60_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT60_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT60_Func004Func001C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]==avk[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function FT60_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT60_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT60_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT60_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT60_Actions takes nothing returns nothing
if(FT60_Func001C())then
return
endif
if(FT60_Func002C())then
call ConditionalTriggerExecute(GT8)
return
endif
if(FT60_Func003C())then
call ConditionalTriggerExecute(GT63)
return
endif
if(FT60_Func004C())then
if(FT60_Func004Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=null
else
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00回城点已设置 : |cffFF8000"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)])+"|r")))
endif
call ConditionalTriggerExecute(GT59)
return
endif
if(FT60_Func005C())then
call ConditionalTriggerExecute(GT61)
return
endif
if(FT60_Func006C())then
call ConditionalTriggerExecute(GT67)
return
endif
if(FT60_Func007C())then
call ConditionalTriggerExecute(GT70)
return
endif
endfunction
function FT61_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT61_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="SelSource"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00E-mail : |cff00FF00tuantuan@Gmail.Com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cff00FF00 + |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cff00FF00 + |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cff00FF00 + |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cff00FF00 + |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cffFF0000 - |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cffFF0000 - |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cffFF0000 - |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cffFF0000 - |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT62_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="SelSource")
endfunction
function FT62_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT62_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT62_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT62_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT62_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT62_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT62_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT62_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT62_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT62_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT62_Actions takes nothing returns nothing
if(FT62_Func001C())then
return
endif
if(FT62_Func002C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT62_Func003C())then
call AdjustPlayerStateBJ(10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
if(FT62_Func004C())then
call AdjustPlayerStateBJ(100000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-100000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
if(FT62_Func005C())then
call AdjustPlayerStateBJ(10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(FT62_Func006C())then
call AdjustPlayerStateBJ(100000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-100000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(FT62_Func007C())then
call AdjustPlayerStateBJ(-10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
endif
if(FT62_Func008C())then
call AdjustPlayerStateBJ(-100000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
endif
if(FT62_Func009C())then
call AdjustPlayerStateBJ(-10000,GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(FT62_Func010C())then
call AdjustPlayerStateBJ(-100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
endif
call ConditionalTriggerExecute(GT61)
endfunction
function FT63_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT63_Func007C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)!=null)
endfunction
function FT63_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="attribute"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00单位属性|r(快捷键:|cffFF00007|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT63_Func007C())then
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0英雄菜单|r"+""))
endif
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("生命 |cff00FF00+|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("魔法 |cff00FF00+|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("速度 |cff00FF00+|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("可以穿越物体"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("生命 |cffFF0000-|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("魔法 |cffFF0000-|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("速度 |cffFF0000-|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("不能穿越物体"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT64_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="attribute")
endfunction
function FT64_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT64_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+11)])
endfunction
function FT64_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT64_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT64_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT64_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT64_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT64_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT64_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT64_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT64_Func011C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT64_Actions takes nothing returns nothing
if(FT64_Func001C())then
return
endif
if(FT64_Func002C())then
call ConditionalTriggerExecute(GT65)
return
endif
if(FT64_Func003C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT64_Func004C())then
call SetWidgetLife(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_LIFE,avk[(1+GetPlayerId(GetTriggerPlayer()))])+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func005C())then
call SetUnitManaBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_MANA,avk[(1+GetPlayerId(GetTriggerPlayer()))])+(GetUnitStateSwap(UNIT_STATE_MAX_MANA,avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func006C())then
call SetUnitMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitDefaultMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))])+(GetUnitMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func007C())then
call SetUnitPathing(avk[(1+GetPlayerId(GetTriggerPlayer()))],false)
endif
if(FT64_Func008C())then
call SetWidgetLife(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_LIFE,avk[(1+GetPlayerId(GetTriggerPlayer()))])-(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func009C())then
call SetUnitManaBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitStateSwap(UNIT_STATE_MANA,avk[(1+GetPlayerId(GetTriggerPlayer()))])-(GetUnitStateSwap(UNIT_STATE_MAX_MANA,avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func010C())then
call SetUnitMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetUnitDefaultMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))])-(GetUnitMoveSpeed(avk[(1+GetPlayerId(GetTriggerPlayer()))])*.1)))
endif
if(FT64_Func011C())then
call SetUnitPathing(avk[(1+GetPlayerId(GetTriggerPlayer()))],true)
endif
call ConditionalTriggerExecute(GT63)
endfunction
function FT65_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT65_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="hero"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00E-mail : |cff00FF00tuantuan@Gmail.Com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("取消CD时间"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("取消负面buffs"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("全属性 |cff00FF00+|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("经验 |cff00FF00+|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("等级 |cff00FF00+|r 1"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("全属性 |cffFF0000-|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("经验 |cffFF0000-|r 10%"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("等级 |cffFF0000-|r 1"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT66_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="hero")
endfunction
function FT66_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT66_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT66_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT66_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT66_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT66_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT66_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT66_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT66_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT66_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT66_Actions takes nothing returns nothing
if(FT66_Func001C())then
return
endif
if(FT66_Func002C())then
call ConditionalTriggerExecute(GT63)
return
endif
if(FT66_Func003C())then
call UnitResetCooldown(avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(FT66_Func004C())then
call UnitRemoveBuffsBJ(1,avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(FT66_Func005C())then
call ModifyHeroStat(0,avk[(1+GetPlayerId(GetTriggerPlayer()))],0,(GetHeroStatBJ(0,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
call ModifyHeroStat(1,avk[(1+GetPlayerId(GetTriggerPlayer()))],0,(GetHeroStatBJ(1,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
call ModifyHeroStat(2,avk[(1+GetPlayerId(GetTriggerPlayer()))],0,(GetHeroStatBJ(2,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
endif
if(FT66_Func006C())then
call AddHeroXPSwapped((GetHeroXP(avk[(1+GetPlayerId(GetTriggerPlayer()))])/10),avk[(1+GetPlayerId(GetTriggerPlayer()))],false)
endif
if(FT66_Func007C())then
call SetHeroLevelBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetHeroLevel(avk[(1+GetPlayerId(GetTriggerPlayer()))])+1),false)
endif
if(FT66_Func008C())then
call ModifyHeroStat(0,avk[(1+GetPlayerId(GetTriggerPlayer()))],1,(GetHeroStatBJ(0,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
call ModifyHeroStat(1,avk[(1+GetPlayerId(GetTriggerPlayer()))],1,(GetHeroStatBJ(1,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
call ModifyHeroStat(2,avk[(1+GetPlayerId(GetTriggerPlayer()))],1,(GetHeroStatBJ(2,avk[(1+GetPlayerId(GetTriggerPlayer()))],true)/10))
endif
if(FT66_Func009C())then
call AddHeroXPSwapped((GetHeroXP(avk[(1+GetPlayerId(GetTriggerPlayer()))])/-10),avk[(1+GetPlayerId(GetTriggerPlayer()))],false)
endif
if(FT66_Func010C())then
call SetHeroLevelBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))],(GetHeroLevel(avk[(1+GetPlayerId(GetTriggerPlayer()))])-1),false)
endif
call ConditionalTriggerExecute(GT65)
endfunction
function FT67_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT67_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="unitSet"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00单位命令|r(快捷键:|cffFF00006|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("单位中立"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("删除单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("杀死单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("单位无敌"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("取消无敌"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("交换单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("移动单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("置换单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("复制单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("招降单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT68_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="unitSet")
endfunction
function FT68_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT68_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT68_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT68_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT68_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT68_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT68_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT68_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+10)])
endfunction
function FT68_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT68_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT68_Func011C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT68_Func012C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function FT68_Actions takes nothing returns nothing
if(FT68_Func001C())then
return
endif
if(FT68_Func002C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT68_Func003C())then
call SetUnitOwner(avk[(1+GetPlayerId(GetTriggerPlayer()))],Player(15),true)
endif
if(FT68_Func004C())then
call RemoveUnit(avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(FT68_Func005C())then
call KillUnit(avk[(1+GetPlayerId(GetTriggerPlayer()))])
endif
if(FT68_Func006C())then
call SetUnitInvulnerable(avk[(1+GetPlayerId(GetTriggerPlayer()))],true)
endif
if(FT68_Func007C())then
call SetUnitInvulnerable(avk[(1+GetPlayerId(GetTriggerPlayer()))],false)
endif
if(FT68_Func008C())then
call SetUnitOwner(avk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer(),true)
endif
if(FT68_Func009C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uExch"
return
endif
if(FT68_Func010C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uMove"
return
endif
if(FT68_Func011C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uPer"
return
endif
if(FT68_Func012C())then
set avg[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="uCopy"
return
endif
call ConditionalTriggerExecute(GT67)
endfunction
function FT69_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT69_Func001Func001C takes nothing returns boolean
return(avk[(1+GetPlayerId(GetTriggerPlayer()))]==avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT69_Actions takes nothing returns nothing
set bj_forLoopAIndex=95
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT69_Func001Func001C())then
set avj[(1+GetPlayerId(GetTriggerPlayer()))]="yes"
set avh[(1+GetPlayerId(GetTriggerPlayer()))]=bj_forLoopAIndex
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT70_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT70_Func008Func001C takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="yes")
endfunction
function FT70_Func008C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO)!=null)
endfunction
function FT70_Actions takes nothing returns nothing
call ConditionalTriggerExecute(GT69)
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safe"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00单位保护|r(快捷键:|cffFF00009|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT70_Func008C())then
if(FT70_Func008Func001C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000将|r"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|cffFF8000从保护列表中删除|r")))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF将|r"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|cff00FFFF添加到保护列表|r")))
endif
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("增加保护单位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0删除保护单位|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0查看保护列表|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT71_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="safe")
endfunction
function FT71_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT71_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT71_Func003Func001C takes nothing returns boolean
return(avj[(1+GetPlayerId(GetTriggerPlayer()))]=="yes")
endfunction
function FT71_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT71_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT71_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT71_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT71_Actions takes nothing returns nothing
if(FT71_Func001C())then
return
endif
if(FT71_Func002C())then
call ConditionalTriggerExecute(GT59)
return
endif
if(FT71_Func003C())then
if(FT71_Func003Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+avh[(1+GetPlayerId(GetTriggerPlayer()))])]=null
else
call ConditionalTriggerExecute(GT72)
endif
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitList"
call ConditionalTriggerExecute(GT74)
return
endif
if(FT71_Func004C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]="yes"
return
endif
if(FT71_Func005C())then
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitDel"
call ConditionalTriggerExecute(GT74)
return
endif
if(FT71_Func006C())then
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitList"
call ConditionalTriggerExecute(GT74)
return
endif
endfunction
function FT72_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT72_Func001Func001C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==null)
endfunction
function FT72_Func004Func001C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==null)
endfunction
function FT72_Actions takes nothing returns nothing
set bj_forLoopAIndex=95
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT72_Func001Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitList"
call ConditionalTriggerExecute(GT74)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+95)]=null
call ConditionalTriggerExecute(GT73)
set bj_forLoopAIndex=95
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT72_Func004Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=avk[(1+GetPlayerId(GetTriggerPlayer()))]
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitList"
call ConditionalTriggerExecute(GT74)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT73_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT73_Func001Func001C takes nothing returns boolean
return(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]==null)
endfunction
function FT73_Actions takes nothing returns nothing
set bj_forLoopAIndex=95
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT73_Func001Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(bj_forLoopAIndex+1))]=null
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT74_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT74_Actions takes nothing returns nothing
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00E-mail : |cff00FF00tuantuan@Gmail.Com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF8000"+GetPlayerName(GetOwningPlayer(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+95)])))+("|r - |cff0080FF"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+95)])+"|r"))))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF8000"+GetPlayerName(GetOwningPlayer(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+96)])))+("|r - |cff0080FF"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+96)])+"|r"))))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF8000"+GetPlayerName(GetOwningPlayer(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+97)])))+("|r - |cff0080FF"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+97)])+"|r"))))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF8000"+GetPlayerName(GetOwningPlayer(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+98)])))+("|r - |cff0080FF"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+98)])+"|r"))))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(("|cffFF8000"+GetPlayerName(GetOwningPlayer(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)])))+("|r - |cff0080FF"+(GetUnitName(avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+99)])+"|r"))))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT75_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="safeUnitList")
endfunction
function FT75_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT75_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT75_Actions takes nothing returns nothing
if(FT75_Func001C())then
return
endif
if(FT75_Func002C())then
call ConditionalTriggerExecute(GT70)
return
endif
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitList"
call ConditionalTriggerExecute(GT74)
endfunction
function FT76_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="safeUnitDel")
endfunction
function FT76_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT76_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT76_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT76_Actions takes nothing returns nothing
if(FT76_Func001C())then
return
endif
if(FT76_Func002C())then
call ConditionalTriggerExecute(GT70)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT76_Func003Func001C())then
set avk[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+(94+bj_forLoopAIndex))]=null
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="safeUnitDel"
call ConditionalTriggerExecute(GT73)
call ConditionalTriggerExecute(GT74)
endfunction
function FT77_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT77_Func007C takes nothing returns boolean
return(IsUnitType(avk[(1+GetPlayerId(GetTriggerPlayer()))],UNIT_TYPE_HERO))and(IsUnitDeadBJ(avk[(1+GetPlayerId(GetTriggerPlayer()))]))and(GetOwningPlayer(avk[(1+GetPlayerId(GetTriggerPlayer()))])==GetTriggerPlayer())
endfunction
function FT77_Func018C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))
endfunction
function FT77_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="EscMain"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
if(FT77_Func007C())then
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000"+(GetUnitName(avk[(1+GetPlayerId(GetTriggerPlayer()))])+"|r立即复活")))
endif
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0修改资源|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0游戏设置|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0高级设置|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0按键功能"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("玩家信息"+""))
if(FT77_Func018C())then
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF0000特殊命令|r"+""))
endif
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT78_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="EscMain")
endfunction
function FT78_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT78_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT78_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT78_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT78_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT78_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT78_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT78_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT78_Actions takes nothing returns nothing
if(FT78_Func001C())then
return
endif
if(FT78_Func002C())then
set achat[((1+GetPlayerId(GetTriggerPlayer()))*'d')]="fh"
call ConditionalTriggerExecute(GT48)
return
endif
if(FT78_Func003C())then
call ConditionalTriggerExecute(GT79)
return
endif
if(FT78_Func004C())then
call ConditionalTriggerExecute(GT83)
return
endif
if(FT78_Func005C())then
call ConditionalTriggerExecute(GT81)
return
endif
if(FT78_Func006C())then
call ConditionalTriggerExecute(GT24)
return
endif
if(FT78_Func007C())then
call ConditionalTriggerExecute(GT56)
call ConditionalTriggerExecute(GT77)
return
endif
if(FT78_Func008C())then
call ConditionalTriggerExecute(GT85)
return
endif
endfunction
function FT79_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT79_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="Source"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00修改资源|r(快捷键:|cffFF00001|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cff00FF00 + |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cff00FF00 + |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cff00FF00 + |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cff00FF00 + |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cffFF0000 - |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("金币|cffFF0000 - |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cffFF0000 - |r10000"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("木材|cffFF0000 - |r10万"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT80_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="Source")
endfunction
function FT80_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT80_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT80_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT80_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT80_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT80_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT80_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT80_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT80_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT80_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT80_Actions takes nothing returns nothing
if(FT80_Func001C())then
return
endif
if(FT80_Func002C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT80_Func003C())then
call AdjustPlayerStateBJ(10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-10000,GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
endif
if(FT80_Func004C())then
call AdjustPlayerStateBJ(100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(-100000,GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED)
endif
if(FT80_Func005C())then
call AdjustPlayerStateBJ(10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-10000,GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
endif
if(FT80_Func006C())then
call AdjustPlayerStateBJ(100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-100000,GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED)
endif
if(FT80_Func007C())then
call AdjustPlayerStateBJ(-10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
endif
if(FT80_Func008C())then
call AdjustPlayerStateBJ(-100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
endif
if(FT80_Func009C())then
call AdjustPlayerStateBJ(-10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(FT80_Func010C())then
call AdjustPlayerStateBJ(-100000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
endif
call ConditionalTriggerExecute(GT79)
endfunction
function FT81_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT81_Func011C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="off")
endfunction
function FT81_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="adSet"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00www.|cffFF0000RestPlay|cff00FF00.com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0自动增加|r(盟友) |cff00FF00+|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0自动减少|r(敌人) |cffFF0000-|r"+""))
if(FT81_Func011C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000启用单位菜单|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF关闭单位菜单|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("全部复位"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("关闭|cffFF0000CiV|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT82_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="adSet")
endfunction
function FT82_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT82_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT82_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT82_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT82_Func005Func001C takes nothing returns boolean
return(ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="off")
endfunction
function FT82_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+4)])
endfunction
function FT82_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT82_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT82_Actions takes nothing returns nothing
if(FT82_Func001C())then
return
endif
if(FT82_Func002C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT82_Func003C())then
call ConditionalTriggerExecute(GT18)
return
endif
if(FT82_Func004C())then
call ConditionalTriggerExecute(GT20)
return
endif
if(FT82_Func005C())then
if(FT82_Func005Func001C())then
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=""
else
set ava[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]="off"
endif
call ConditionalTriggerExecute(GT81)
return
endif
if(FT82_Func006C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="fw"
call ConditionalTriggerExecute(GT33)
call ConditionalTriggerExecute(GT81)
return
endif
if(FT82_Func007C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="tuantuan"
call ConditionalTriggerExecute(GT30)
set avg[(1+GetPlayerId(GetTriggerPlayer()))]=""
return
endif
endfunction
function FT83_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT83_Func007C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=="jn")
endfunction
function FT83_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=="bf")
endfunction
function FT83_Func011C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=="fh")
endfunction
function FT83_Func013C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+24)]=="map")
endfunction
function FT83_Func015C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+27)]=="sy")
endfunction
function FT83_Func017C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+34)]=="jna")
endfunction
function FT83_Func019C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+30)]=="cr")
endfunction
function FT83_Func021C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=="hc")
endfunction
function FT83_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="Set"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00游戏设置|r(快捷键:|cffFF00002|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT83_Func007C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000技能正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF无限技能|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(FT83_Func009C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000buffs正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF去负面buffs|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(FT83_Func011C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000英雄正常复活|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF英雄自动复活|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=bj_lastCreatedButton
if(FT83_Func013C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000地图全黑|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF地图全亮|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
if(FT83_Func015C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000正常移动|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF瞬间移动|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=bj_lastCreatedButton
if(FT83_Func017C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000技能正常升级|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF技能升级到最大|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=bj_lastCreatedButton
if(FT83_Func019C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000穿越物体正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF穿越物体|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=bj_lastCreatedButton
if(FT83_Func021C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000取消回城|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF自动回城|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT84_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="Set")
endfunction
function FT84_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT84_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT84_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT84_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT84_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT84_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT84_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT84_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT84_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT84_Func010Func001C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+26)]=="hc")
endfunction
function FT84_Func010C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+9)])
endfunction
function FT84_Actions takes nothing returns nothing
if(FT84_Func001C())then
return
endif
if(FT84_Func002C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT84_Func003C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="jn"
endif
if(FT84_Func004C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="bf"
endif
if(FT84_Func005C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="fh"
endif
if(FT84_Func006C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="dt"
endif
if(FT84_Func007C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="sy"
endif
if(FT84_Func008C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="jna"
endif
if(FT84_Func009C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="cr"
endif
if(FT84_Func010C())then
if(FT84_Func010Func001C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="hcn"
else
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="hc"
endif
endif
call ConditionalTriggerExecute(GT33)
call ConditionalTriggerExecute(GT83)
endfunction
function FT85_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT85_Func007C takes nothing returns boolean
return(avg[25]=="allmap")
endfunction
function FT85_Func009C takes nothing returns boolean
return(avg[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+32)]=="cr")
endfunction
function FT85_Func011C takes nothing returns boolean
return(ava[3]!="off")
endfunction
function FT85_Func018C takes nothing returns boolean
return(avg[1]=="off")
endfunction
function FT85_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="special"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00特殊命令|r(快捷键:|cffFF00003|r)"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
if(FT85_Func007C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000所有玩家地图全黑|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF所有玩家地图全亮|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)]=bj_lastCreatedButton
if(FT85_Func009C())then
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF8000单位穿越物体正常|r"+""))
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FFFF任意单位穿越物体|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)]=bj_lastCreatedButton
if(FT85_Func011C())then
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("关闭录像(|cffFF0000不可开启|r)"+""))
endif
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0踢出玩家|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("脚本信息"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("开启所有玩家|cffFF0000CiV|r"+""))
if(FT85_Func018C())then
return
else
call DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("关闭所有玩家|cffFF0000CiV|r"+""))
endif
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)]=bj_lastCreatedButton
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT86_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="special")
endfunction
function FT86_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT86_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+12)])
endfunction
function FT86_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+1)])
endfunction
function FT86_Func004C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+2)])
endfunction
function FT86_Func005C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+3)])
endfunction
function FT86_Func006C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+5)])
endfunction
function FT86_Func007C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+6)])
endfunction
function FT86_Func008C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+7)])
endfunction
function FT86_Func009Func001Func001Func004C takes nothing returns boolean
return(GetPlayerController(Player(-1+(bj_forLoopAIndex)))==MAP_CONTROL_USER)and(avg[bj_forLoopAIndex]!="tuantuan")and(avg[bj_forLoopAIndex]!="off")
endfunction
function FT86_Func009Func001Func001C takes nothing returns boolean
return(FT86_Func009Func001Func001Func004C())
endfunction
function FT86_Func009C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+8)])
endfunction
function FT86_Actions takes nothing returns nothing
if(FT86_Func001C())then
return
endif
if(FT86_Func002C())then
call ConditionalTriggerExecute(GT77)
return
endif
if(FT86_Func003C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="dta"
endif
if(FT86_Func004C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="cra"
endif
if(FT86_Func005C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="lx"
endif
if(FT86_Func006C())then
call ConditionalTriggerExecute(GT87)
return
endif
if(FT86_Func007C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="info"
endif
if(FT86_Func008C())then
set achat[(1+GetPlayerId(GetTriggerPlayer()))]="ngkciv"
call ConditionalTriggerExecute(GT28)
return
endif
if(FT86_Func009C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT86_Func009Func001Func001C())then
set avg[bj_forLoopAIndex]="tuantuan"
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cff00FF00tuantuan出品  必属精品   |cffFFFF00www.|cffFF0000RestPlay|cffFFFF00.com|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),1.,("|cff00FF00tuantuan 加强模式开启!|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
call ConditionalTriggerExecute(GT33)
call ConditionalTriggerExecute(GT85)
endfunction
function FT87_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT87_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="playerA"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=bj_lastCreatedButton
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(bj_forLoopAIndex)))+""))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0下一页|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT88_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="playerA")
endfunction
function FT88_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT88_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT88_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
endfunction
function FT88_Func004Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT88_Actions takes nothing returns nothing
if(FT88_Func001C())then
return
endif
if(FT88_Func002C())then
call ConditionalTriggerExecute(GT85)
return
endif
if(FT88_Func003C())then
call ConditionalTriggerExecute(GT89)
return
endif
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT88_Func004Func001C())then
call CustomVictoryBJ(Player(-1+(bj_forLoopAIndex)),false,false)
call ConditionalTriggerExecute(GT87)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function FT89_Conditions takes nothing returns boolean
return(avg[(1+GetPlayerId(GetTriggerPlayer()))]=="tuantuan")
endfunction
function FT89_Actions takes nothing returns nothing
set avb[(1+GetPlayerId(GetTriggerPlayer()))]="playerB"
call DialogClear(avc[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFFFF00www.|cffFF0000feifeishijie|cffFFFF00.com|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00返回|r"+""))
set bj_forLoopAIndex=7
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(bj_forLoopAIndex)))+""))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cffFF80C0上一页|r"+""))
set abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)]=DialogAddButtonBJ(avc[(1+GetPlayerId(GetTriggerPlayer()))],("|cff00FF00开始游戏|r"+""))
call DialogDisplayBJ(true,avc[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function FT90_Conditions takes nothing returns boolean
return(avb[(1+GetPlayerId(GetTriggerPlayer()))]=="playerB")
endfunction
function FT90_Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+17)])
endfunction
function FT90_Func002C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+15)])
endfunction
function FT90_Func003C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+14)])
endfunction
function FT90_Func004Func001C takes nothing returns boolean
return(GetClickedButton()==abtn[(((1+GetPlayerId(GetTriggerPlayer()))*'d')+bj_forLoopAIndex)])
endfunction
function FT90_Actions takes nothing returns nothing
if(FT90_Func001C())then
return
endif
if(FT90_Func002C())then
call ConditionalTriggerExecute(GT85)
return
endif
if(FT90_Func003C())then
call ConditionalTriggerExecute(GT87)
return
endif
set bj_forLoopAIndex=7
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(FT90_Func004Func001C())then
call CustomVictoryBJ(Player(-1+(bj_forLoopAIndex)),false,false)
call ConditionalTriggerExecute(GT89)
return
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function NGKCIV takes nothing returns nothing
set avc[1]=DialogCreate()
set avc[2]=DialogCreate()
set avc[3]=DialogCreate()
set avc[4]=DialogCreate()
set avc[5]=DialogCreate()
set avc[6]=DialogCreate()
set avc[7]=DialogCreate()
set avc[8]=DialogCreate()
set avc[9]=DialogCreate()
set avc[10]=DialogCreate()
set avc[11]=DialogCreate()
set avc[12]=DialogCreate()
call TriggerRegisterTimerEventSingle(GT1,.0)
call TriggerAddAction(GT1,function FT1_Actions)
call TriggerAddAction(GT2,function FT2_Actions)
call TriggerAddCondition(GT3,Condition(function FT3_Conditions))
call TriggerAddAction(GT3,function FT3_Actions)
call TriggerAddAction(GT4,function FT4_Actions)
call TriggerAddAction(GT5,function FT5_Actions)
call TriggerAddAction(GT6,function FT6_Actions)
call TriggerAddAction(GT7,function FT7_Actions)
call TriggerAddCondition(GT8,Condition(function FT8_Conditions))
call TriggerAddAction(GT8,function FT8_Actions)
call TriggerAddCondition(GT9,Condition(function FT9_Conditions))
call TriggerAddAction(GT9,function FT9_Actions)
call TriggerAddCondition(GT10,Condition(function FT10_Conditions))
call TriggerAddAction(GT10,function FT10_Actions)
call TriggerAddCondition(GT11,Condition(function FT11_Conditions))
call TriggerAddAction(GT11,function FT11_Actions)
call TriggerAddCondition(GT12,Condition(function FT12_Conditions))
call TriggerAddAction(GT12,function FT12_Actions)
call TriggerAddCondition(GT13,Condition(function FT13_Conditions))
call TriggerAddAction(GT13,function FT13_Actions)
call TriggerAddCondition(GT14,Condition(function FT14_Conditions))
call TriggerAddAction(GT14,function FT14_Actions)
call TriggerAddCondition(GT15,Condition(function FT15_Conditions))
call TriggerAddAction(GT15,function FT15_Actions)
call TriggerAddCondition(GT16,Condition(function FT16_Conditions))
call TriggerAddAction(GT16,function FT16_Actions)
call TriggerAddCondition(GT17,Condition(function FT17_Conditions))
call TriggerAddAction(GT17,function FT17_Actions)
call TriggerAddCondition(GT18,Condition(function FT18_Conditions))
call TriggerAddAction(GT18,function FT18_Actions)
call TriggerAddCondition(GT19,Condition(function FT19_Conditions))
call TriggerAddAction(GT19,function FT19_Actions)
call TriggerAddCondition(GT20,Condition(function FT20_Conditions))
call TriggerAddAction(GT20,function FT20_Actions)
call TriggerAddCondition(GT21,Condition(function FT21_Conditions))
call TriggerAddAction(GT21,function FT21_Actions)
call TriggerAddCondition(GT22,Condition(function FT22_Conditions))
call TriggerAddAction(GT22,function FT22_Actions)
call TriggerAddCondition(GT23,Condition(function FT23_Conditions))
call TriggerAddAction(GT23,function FT23_Actions)
call TriggerAddCondition(GT24,Condition(function FT24_Conditions))
call TriggerAddAction(GT24,function FT24_Actions)
call TriggerAddCondition(GT25,Condition(function FT25_Conditions))
call TriggerAddAction(GT25,function FT25_Actions)
call TriggerAddCondition(GT26,Condition(function FT26_Conditions))
call TriggerAddAction(GT26,function FT26_Actions)
call TriggerAddCondition(GT27,Condition(function FT27_Conditions))
call TriggerAddAction(GT27,function FT27_Actions)
call TriggerRegisterPlayerChatEvent(GT28,Player(0),"ngkciv",true)
call TriggerAddCondition(GT28,Condition(function FT28_Conditions))
call TriggerAddAction(GT28,function FT28_Actions)
call TriggerRegisterPlayerChatEvent(GT29,Player(0),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(1),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(2),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(3),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(4),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(5),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(6),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(7),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(8),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(9),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(10),"",false)
call TriggerRegisterPlayerChatEvent(GT29,Player(11),"",false)
call TriggerAddAction(GT29,function FT29_Actions)
call TriggerAddAction(GT30,function FT30_Actions)
call TriggerAddCondition(GT31,Condition(function FT31_Conditions))
call TriggerAddAction(GT31,function FT31_Actions)
call TriggerAddCondition(GT32,Condition(function FT32_Conditions))
call TriggerAddAction(GT32,function FT32_Actions)
call TriggerAddCondition(GT33,Condition(function FT33_Conditions))
call TriggerAddAction(GT33,function FT33_Actions)
call TriggerAddCondition(GT34,Condition(function FT34_Conditions))
call TriggerAddAction(GT34,function FT34_Actions)
call TriggerAddCondition(GT35,Condition(function FT35_Conditions))
call TriggerAddAction(GT35,function FT35_Actions)
call TriggerAddCondition(GT36,Condition(function FT36_Conditions))
call TriggerAddAction(GT36,function FT36_Actions)
call TriggerAddCondition(GT37,Condition(function FT37_Conditions))
call TriggerAddAction(GT37,function FT37_Actions)
call TriggerAddCondition(GT38,Condition(function FT38_Conditions))
call TriggerAddAction(GT38,function FT38_Actions)
call TriggerAddCondition(GT39,Condition(function FT39_Conditions))
call TriggerAddAction(GT39,function FT39_Actions)
call TriggerAddCondition(GT40,Condition(function FT40_Conditions))
call TriggerAddAction(GT40,function FT40_Actions)
call TriggerAddCondition(GT41,Condition(function FT41_Conditions))
call TriggerAddAction(GT41,function FT41_Actions)
call TriggerAddCondition(GT42,Condition(function FT42_Conditions))
call TriggerAddAction(GT42,function FT42_Actions)
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(0))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(1))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(2))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(3))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(4))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(5))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(6))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(7))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(8))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(9))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(10))
call TriggerRegisterPlayerEventEndCinematic(GT43,Player(11))
call TriggerAddAction(GT43,function FT43_Actions)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(0),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(1),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(2),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(3),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(4),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(5),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(6),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(7),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(8),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(9),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(10),0,3)
call TriggerRegisterPlayerKeyEventBJ(GT44,Player(11),0,3)
call TriggerAddAction(GT44,function FT44_Actions)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(0),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(1),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(2),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(3),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(4),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(5),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(6),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(7),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(8),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(9),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(10),0,2)
call TriggerRegisterPlayerKeyEventBJ(GT45,Player(11),0,2)
call TriggerAddAction(GT45,function FT45_Actions)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(0),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(1),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(2),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(3),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(4),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(5),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(6),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(7),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(8),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(9),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(10),0,0)
call TriggerRegisterPlayerKeyEventBJ(GT46,Player(11),0,0)
call TriggerAddAction(GT46,function FT46_Actions)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(0),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(1),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(2),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(3),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(4),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(5),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(6),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(7),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(8),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(9),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(10),0,1)
call TriggerRegisterPlayerKeyEventBJ(GT47,Player(11),0,1)
call TriggerAddAction(GT47,function FT47_Actions)
call TriggerAddCondition(GT48,Condition(function FT48_Conditions))
call TriggerAddAction(GT48,function FT48_Actions)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(GT49,Player(11),true)
call TriggerAddCondition(GT49,Condition(function FT49_Conditions))
call TriggerAddAction(GT49,function FT49_Actions)
call TriggerRegisterAnyUnitEventBJ(GT50,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(GT50,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(GT50,Condition(function FT50_Conditions))
call TriggerAddAction(GT50,function FT50_Actions)
call TriggerRegisterAnyUnitEventBJ(GT51,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(GT51,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(GT51,Condition(function FT51_Conditions))
call TriggerAddAction(GT51,function FT51_Actions)
call TriggerAddCondition(GT52,Condition(function FT52_Conditions))
call TriggerAddAction(GT52,function FT52_Actions)
call TriggerRegisterAnyUnitEventBJ(GT53,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(GT53,Condition(function FT53_Conditions))
call TriggerAddAction(GT53,function FT53_Actions)
call TriggerRegisterAnyUnitEventBJ(GT54,EVENT_PLAYER_UNIT_USE_ITEM)
call TriggerAddCondition(GT54,Condition(function FT54_Conditions))
call TriggerAddAction(GT54,function FT54_Actions)
call TriggerRegisterTimerEventSingle(GT55,.0)
call TriggerAddAction(GT55,function FT55_Actions)
call TriggerAddCondition(GT56,Condition(function FT56_Conditions))
call TriggerAddAction(GT56,function FT56_Actions)
call TriggerAddCondition(GT57,Condition(function FT57_Conditions))
call TriggerAddAction(GT57,function FT57_Actions)
call TriggerRegisterDialogEvent(GT58,avc[1])
call TriggerRegisterDialogEvent(GT58,avc[2])
call TriggerRegisterDialogEvent(GT58,avc[3])
call TriggerRegisterDialogEvent(GT58,avc[4])
call TriggerRegisterDialogEvent(GT58,avc[5])
call TriggerRegisterDialogEvent(GT58,avc[6])
call TriggerRegisterDialogEvent(GT58,avc[7])
call TriggerRegisterDialogEvent(GT58,avc[8])
call TriggerRegisterDialogEvent(GT58,avc[9])
call TriggerRegisterDialogEvent(GT58,avc[10])
call TriggerRegisterDialogEvent(GT58,avc[11])
call TriggerRegisterDialogEvent(GT58,avc[12])
call TriggerAddCondition(GT58,Condition(function FT58_Conditions))
call TriggerAddAction(GT58,function FT58_Actions)
call TriggerRegisterPlayerChatEvent(GT59,Player(0),"t",true)
call TriggerAddCondition(GT59,Condition(function FT59_Conditions))
call TriggerAddAction(GT59,function FT59_Actions)
call TriggerAddCondition(GT60,Condition(function FT60_Conditions))
call TriggerAddAction(GT60,function FT60_Actions)
call TriggerRegisterPlayerChatEvent(GT61,Player(0),"t1",true)
call TriggerAddCondition(GT61,Condition(function FT61_Conditions))
call TriggerAddAction(GT61,function FT61_Actions)
call TriggerAddCondition(GT62,Condition(function FT62_Conditions))
call TriggerAddAction(GT62,function FT62_Actions)
call TriggerAddCondition(GT63,Condition(function FT63_Conditions))
call TriggerAddAction(GT63,function FT63_Actions)
call TriggerAddCondition(GT64,Condition(function FT64_Conditions))
call TriggerAddAction(GT64,function FT64_Actions)
call TriggerAddCondition(GT65,Condition(function FT65_Conditions))
call TriggerAddAction(GT65,function FT65_Actions)
call TriggerAddCondition(GT66,Condition(function FT66_Conditions))
call TriggerAddAction(GT66,function FT66_Actions)
call TriggerAddCondition(GT67,Condition(function FT67_Conditions))
call TriggerAddAction(GT67,function FT67_Actions)
call TriggerAddCondition(GT68,Condition(function FT68_Conditions))
call TriggerAddAction(GT68,function FT68_Actions)
call TriggerAddCondition(GT69,Condition(function FT69_Conditions))
call TriggerAddAction(GT69,function FT69_Actions)
call TriggerAddCondition(GT70,Condition(function FT70_Conditions))
call TriggerAddAction(GT70,function FT70_Actions)
call TriggerAddCondition(GT71,Condition(function FT71_Conditions))
call TriggerAddAction(GT71,function FT71_Actions)
call TriggerAddCondition(GT72,Condition(function FT72_Conditions))
call TriggerAddAction(GT72,function FT72_Actions)
call TriggerAddCondition(GT73,Condition(function FT73_Conditions))
call TriggerAddAction(GT73,function FT73_Actions)
call TriggerAddCondition(GT74,Condition(function FT74_Conditions))
call TriggerAddAction(GT74,function FT74_Actions)
call TriggerAddCondition(GT75,Condition(function FT75_Conditions))
call TriggerAddAction(GT75,function FT75_Actions)
call TriggerAddCondition(GT76,Condition(function FT76_Conditions))
call TriggerAddAction(GT76,function FT76_Actions)
call TriggerAddCondition(GT77,Condition(function FT77_Conditions))
call TriggerAddAction(GT77,function FT77_Actions)
call TriggerAddCondition(GT78,Condition(function FT78_Conditions))
call TriggerAddAction(GT78,function FT78_Actions)
call TriggerAddCondition(GT79,Condition(function FT79_Conditions))
call TriggerAddAction(GT79,function FT79_Actions)
call TriggerAddCondition(GT80,Condition(function FT80_Conditions))
call TriggerAddAction(GT80,function FT80_Actions)
call TriggerAddCondition(GT81,Condition(function FT81_Conditions))
call TriggerAddAction(GT81,function FT81_Actions)
call TriggerAddCondition(GT82,Condition(function FT82_Conditions))
call TriggerAddAction(GT82,function FT82_Actions)
call TriggerAddCondition(GT83,Condition(function FT83_Conditions))
call TriggerAddAction(GT83,function FT83_Actions)
call TriggerAddCondition(GT84,Condition(function FT84_Conditions))
call TriggerAddAction(GT84,function FT84_Actions)
call TriggerAddCondition(GT85,Condition(function FT85_Conditions))
call TriggerAddAction(GT85,function FT85_Actions)
call TriggerAddCondition(GT86,Condition(function FT86_Conditions))
call TriggerAddAction(GT86,function FT86_Actions)
call TriggerAddCondition(GT87,Condition(function FT87_Conditions))
call TriggerAddAction(GT87,function FT87_Actions)
call TriggerAddCondition(GT88,Condition(function FT88_Conditions))
call TriggerAddAction(GT88,function FT88_Actions)
call TriggerAddCondition(GT89,Condition(function FT89_Conditions))
call TriggerAddAction(GT89,function FT89_Actions)
call TriggerAddCondition(GT90,Condition(function FT90_Conditions))
call TriggerAddAction(GT90,function FT90_Actions)
endfunction
