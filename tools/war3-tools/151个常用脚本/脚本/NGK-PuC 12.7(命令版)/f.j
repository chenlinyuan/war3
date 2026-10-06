function eepuc_Func001C takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="off")
endfunction
function eepuc_Func003Func001C takes nothing returns boolean
return(ddngk[bj_forLoopAIndex]=="PuC")
endfunction
function eepuc_Actions takes nothing returns nothing
if(eepuc_Func001C())then
call EnableTrigger(ttfir)
set ddngk[(1+GetPlayerId(GetTriggerPlayer()))]="PuC"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00自2007年10月1日起,NGKiller启用新的域名"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00各版本地图详细说明请访问NGKiller主站"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00有任何问题、建议请到NGKiller主站发帖留言"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Puc Ultimate Turn On|r"+""))
return
endif
call DisableTrigger(ttfir)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(eepuc_Func003Func001C())then
set ddngk[bj_forLoopAIndex]=""
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★|cffFFFF00自2007年10月1日起,NGKiller启用新的域名"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★|cffFFFF00各版本地图详细说明请访问NGKiller主站"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★|cffFFFF00有任何问题、建议请到NGKiller主站发帖留言"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000All Player's Puc Ultimate Turn Off|r"+""))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set ddngk[(1+GetPlayerId(GetTriggerPlayer()))]="off"
endfunction
function eefir_Conditions takes nothing returns boolean
return(StringLength(GetEventPlayerChatString())>=2)
endfunction
function eefir_Actions takes nothing returns nothing
set ddchat[(1+GetPlayerId(GetTriggerPlayer()))]=GetEventPlayerChatString()
call ConditionalTriggerExecute(ttngk)
endfunction
function eengk_Func001Func001C takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eengk_Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="ngkiller")
endfunction
function eengk_Actions takes nothing returns nothing
if(eengk_Func001C())then
if(eengk_Func001Func001C())then
set ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00自2007年10月1日起,NGKiller启用新的域名"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00各版本地图详细说明请访问NGKiller主站"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00有任何问题、建议请到NGKiller主站发帖留言"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Puc Ultimate Turn Off|r"+""))
else
set ddngk[(1+GetPlayerId(GetTriggerPlayer()))]="PuC"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00自2007年10月1日起,NGKiller启用新的域名"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00各版本地图详细说明请访问NGKiller主站"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★|cffFFFF00有任何问题、建议请到NGKiller主站发帖留言"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),10.,(" "+""))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Puc Ultimate Turn On|r"+""))
endif
return
endif
call ConditionalTriggerExecute(ttg)
endfunction
function eeg_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eeg_Func003Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sma")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)]=="life")
endfunction
function eeg_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sma")
endfunction
function eeg_Func005Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mfa")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)]=="mana")
endfunction
function eeg_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mfa")
endfunction
function eeg_Func007Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sda")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)]=="speed")
endfunction
function eeg_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sda")
endfunction
function eeg_Func009Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jba")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]=="money")
endfunction
function eeg_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jba")
endfunction
function eeg_Func011Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mca")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]=="lumber")
endfunction
function eeg_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mca")
endfunction
function eeg_Func013Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sxa")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)]=="allatr")
endfunction
function eeg_Func013C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sxa")
endfunction
function eeg_Func015Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="lla")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)]=="stren")
endfunction
function eeg_Func015C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="lla")
endfunction
function eeg_Func017Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zla")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)]=="zhili")
endfunction
function eeg_Func017C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="zla")
endfunction
function eeg_Func019Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mja")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)]=="mj")
endfunction
function eeg_Func019C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mja")
endfunction
function eeg_Func021Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dja")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]=="level")
endfunction
function eeg_Func021C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="dja")
endfunction
function eeg_Actions takes nothing returns nothing
if(eeg_Func003C())then
if(eeg_Func003Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)]="life"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func005C())then
if(eeg_Func005Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)]="mana"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func007C())then
if(eeg_Func007Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)]="speed"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func009C())then
if(eeg_Func009Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]="money"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func011C())then
if(eeg_Func011Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]="lumber"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func013C())then
if(eeg_Func013Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)]="allatr"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func015C())then
if(eeg_Func015Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)]="stren"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func017C())then
if(eeg_Func017Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)]="zhili"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func019C())then
if(eeg_Func019Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)]="mj"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeg_Func021C())then
if(eeg_Func021Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]="level"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
call ConditionalTriggerExecute(tth)
endfunction
function eeh_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eeh_Func005Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="smm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)]=="-life")
endfunction
function eeh_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="smm")
endfunction
function eeh_Func007Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mfm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)]=="-mana")
endfunction
function eeh_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mfm")
endfunction
function eeh_Func009Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sdm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)]=="-speed")
endfunction
function eeh_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sdm")
endfunction
function eeh_Func011Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jbm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]=="-money")
endfunction
function eeh_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="jbm")
endfunction
function eeh_Func013Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mcm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]=="-lumber")
endfunction
function eeh_Func013C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mcm")
endfunction
function eeh_Func015Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sxm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)]=="-allatr")
endfunction
function eeh_Func015C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sxm")
endfunction
function eeh_Func017Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="llm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)]=="-stren")
endfunction
function eeh_Func017C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="llm")
endfunction
function eeh_Func019Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zlm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)]=="-zhili")
endfunction
function eeh_Func019C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="zlm")
endfunction
function eeh_Func021Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mjm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)]=="-mj")
endfunction
function eeh_Func021C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="mjm")
endfunction
function eeh_Func023Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="djm")and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]=="-level")
endfunction
function eeh_Func023C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="djm")
endfunction
function eeh_Actions takes nothing returns nothing
if(eeh_Func005C())then
if(eeh_Func005Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)]="-life"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func007C())then
if(eeh_Func007Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)]="-mana"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func009C())then
if(eeh_Func009Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)]="-speed"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func011C())then
if(eeh_Func011Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]="-money"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func013C())then
if(eeh_Func013Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]="-lumber"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func015C())then
if(eeh_Func015Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)]="-allatr"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func017C())then
if(eeh_Func017Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)]="-stren"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func019C())then
if(eeh_Func019Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)]="-zhili"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func021C())then
if(eeh_Func021Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)]="-mj"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeh_Func023C())then
if(eeh_Func023Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]="-level"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
call ConditionalTriggerExecute(tta)
endfunction
function eea_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eea_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="fw")
endfunction
function eea_Func005Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sm")
endfunction
function eea_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sm")
endfunction
function eea_Func007Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mf")
endfunction
function eea_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mf")
endfunction
function eea_Func009Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sd")
endfunction
function eea_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sd")
endfunction
function eea_Func011Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jb")
endfunction
function eea_Func011Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,3)=="-")
endfunction
function eea_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="jb")
endfunction
function eea_Func013Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mc")
endfunction
function eea_Func013Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,3)=="-")
endfunction
function eea_Func013C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mc")
endfunction
function eea_Actions takes nothing returns nothing
if(eea_Func003C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=99
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+bj_forLoopAIndex)]=""
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+bj_forLoopAIndex)]=0
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00OK|r"+""))
return
endif
if(eea_Func005C())then
if(eea_Func005Func001C())then
call SetUnitLifePercentBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],100)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call SetWidgetLife(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],I2R(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]))
return
endif
if(eea_Func007C())then
if(eea_Func007Func001C())then
call SetUnitManaPercentBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],100)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call SetUnitManaBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],I2R(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]))
return
endif
if(eea_Func009C())then
if(eea_Func009Func001C())then
call SetUnitMoveSpeed(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],522.)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,6))
call SetUnitMoveSpeed(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],(.0+I2R(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))])))
return
endif
if(eea_Func011C())then
if(eea_Func011Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
if(eea_Func011Func003C())then
call AdjustPlayerStateBJ((ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call AdjustPlayerStateBJ(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
return
endif
if(eea_Func013C())then
if(eea_Func013Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,10))
if(eea_Func013Func003C())then
call AdjustPlayerStateBJ((ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call AdjustPlayerStateBJ(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]*-1),GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
return
endif
call ConditionalTriggerExecute(ttb)
endfunction
function eeb_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eeb_Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="cr")
endfunction
function eeb_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="crn")
endfunction
function eeb_Func005Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+27)]=="move")
endfunction
function eeb_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sy")
endfunction
function eeb_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="info")
endfunction
function eeb_Func009Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sci")
endfunction
function eeb_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="sci")
endfunction
function eeb_Actions takes nothing returns nothing
if(eeb_Func002C())then
call SetUnitPathing(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],false)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
return
endif
if(eeb_Func003C())then
call SetUnitPathing(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],true)
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
return
endif
if(eeb_Func005C())then
if(eeb_Func005Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+27)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+27)]="move"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eeb_Func007C())then
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00自2007年10月1日起,NGKiller启用新的域名"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00各版本地图详细说明请访问NGKiller主站"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★|cffFFFF00有任何问题、建议请到NGKiller主站发帖留言"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("|cffFF0000★★★★★★★★|cff00FF00www.ngkiller.com|cffFF0000★★★★★★★★|r"+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("  "+""))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,30.,("  "+""))
return
endif
if(eeb_Func009C())then
if(eeb_Func009Func001C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call RemoveItem(UnitItemInSlotBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],bj_forLoopAIndex))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
call RemoveItem(UnitItemInSlotBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]))
return
endif
call ConditionalTriggerExecute(ttc)
endfunction
function eec_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eec_Func002Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dj")
endfunction
function eec_Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="dj")
endfunction
function eec_Func005Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sx")
endfunction
function eec_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="sx")
endfunction
function eec_Func007Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="ll")
endfunction
function eec_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="ll")
endfunction
function eec_Func009Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="mj")
endfunction
function eec_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="mj")
endfunction
function eec_Func011Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zl")
endfunction
function eec_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="zl")
endfunction
function eec_Actions takes nothing returns nothing
if(eec_Func002C())then
if(eec_Func002Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call SetHeroLevelBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],ddtemp[(1+GetPlayerId(GetTriggerPlayer()))],false)
return
endif
if(eec_Func005C())then
if(eec_Func005Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ModifyHeroStat(0,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
call ModifyHeroStat(1,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
call ModifyHeroStat(2,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
return
endif
if(eec_Func007C())then
if(eec_Func007Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ModifyHeroStat(0,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
return
endif
if(eec_Func009C())then
if(eec_Func009Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ModifyHeroStat(1,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
return
endif
if(eec_Func011C())then
if(eec_Func011Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,9))
call ModifyHeroStat(2,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],2,(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]+0))
return
endif
call ConditionalTriggerExecute(ttd)
endfunction
function eed_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eed_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="sc")
endfunction
function eed_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="ss")
endfunction
function eed_Func007Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zx")
endfunction
function eed_Func007Func003C takes nothing returns boolean
return(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]<1)and(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]>16)
endfunction
function eed_Func007C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="zx")
endfunction
function eed_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="wd")
endfunction
function eed_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="wdn")
endfunction
function eed_Actions takes nothing returns nothing
if(eed_Func003C())then
call RemoveUnit(ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
return
endif
if(eed_Func005C())then
call KillUnit(ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
return
endif
if(eed_Func007C())then
if(eed_Func007Func001C())then
call SetUnitOwner(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer(),true)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
if(eed_Func007Func003C())then
return
endif
call SetUnitOwner(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],Player(-1+(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))])),true)
return
endif
if(eed_Func009C())then
call SetUnitInvulnerable(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],true)
return
endif
if(eed_Func011C())then
call SetUnitInvulnerable(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],false)
return
endif
call ConditionalTriggerExecute(tte)
endfunction
function eee_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eee_Func003Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]=="fh")
endfunction
function eee_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="fh")
endfunction
function eee_Func005Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+24)]=="map")
endfunction
function eee_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dt")
endfunction
function eee_Func007Func002C takes nothing returns boolean
return(ddngk[25]=="allmap")
endfunction
function eee_Func007C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dta")
endfunction
function eee_Func009Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]=="cd")
endfunction
function eee_Func009C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jn")
endfunction
function eee_Func011Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+3)]=="bf")
endfunction
function eee_Func011C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="bf")
endfunction
function eee_Func013C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="lx")
endfunction
function eee_Actions takes nothing returns nothing
if(eee_Func003C())then
if(eee_Func003Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]="fh"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eee_Func005C())then
if(eee_Func005Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+24)]=""
call DestroyFogModifier(ddmap[(1+GetPlayerId(GetTriggerPlayer()))])
set ddmap[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_MASKED,GetWorldBounds())
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+24)]="map"
call DestroyFogModifier(ddmap[(1+GetPlayerId(GetTriggerPlayer()))])
set ddmap[(1+GetPlayerId(GetTriggerPlayer()))]=CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetWorldBounds())
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eee_Func007C())then
if(eee_Func007Func002C())then
set ddngk[25]=""
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(ddmap[bj_forLoopAIndex])
set ddmap[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_MASKED,GetWorldBounds())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[25]="allmap"
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyFogModifier(ddmap[bj_forLoopAIndex])
set ddmap[bj_forLoopAIndex]=CreateFogModifierRectBJ(true,Player(-1+(bj_forLoopAIndex)),FOG_OF_WAR_VISIBLE,GetWorldBounds())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eee_Func009C())then
if(eee_Func009Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]="cd"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eee_Func011C())then
if(eee_Func011Func001C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+3)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
else
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+3)]="bf"
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
endif
return
endif
if(eee_Func013C())then
call DoNotSaveReplay ()
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00OK|r"+""))
return
endif
call ConditionalTriggerExecute(ttf)
endfunction
function eef_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eef_Func002C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="hc")
endfunction
function eef_Func003C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="hcn")
endfunction
function eef_Func005C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="fz")
endfunction
function eef_Func008C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="yd")
endfunction
function eef_Func010C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="jh")
endfunction
function eef_Func012C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="zh")
endfunction
function eef_Func014Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="dli")
endfunction
function eef_Func014C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="dli")
endfunction
function eef_Func016Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="fzi")
endfunction
function eef_Func016C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,3)=="fzi")
endfunction
function eef_Func018Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="xx")
endfunction
function eef_Func018C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="xx")
endfunction
function eef_Func020Func001C takes nothing returns boolean
return(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,StringLength(ddchat[(1+GetPlayerId(GetTriggerPlayer()))]))=="tc")
endfunction
function eef_Func020Func003C takes nothing returns boolean
return(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]<1)and(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]>12)
endfunction
function eef_Func020C takes nothing returns boolean
return(GetTriggerPlayer()==Player(0))and(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],1,2)=="tc")
endfunction
function eef_Actions takes nothing returns nothing
if(eef_Func002C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]="home"
set ddunit[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]=ddunit[(1+GetPlayerId(GetTriggerPlayer()))]
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cff00FF00Turn On|r"+""))
return
endif
if(eef_Func003C())then
set ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]=""
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),1.,("|cffFF0000Turn Off|r"+""))
return
endif
if(eef_Func005C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="copyU"
return
endif
if(eef_Func008C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="move"
return
endif
if(eef_Func010C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="exchN"
return
endif
if(eef_Func012C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="exchE"
return
endif
if(eef_Func014C())then
if(eef_Func014Func001C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitRemoveItemFromSlotSwapped(bj_forLoopAIndex,ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
call UnitRemoveItemFromSlotSwapped(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))],ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
return
endif
if(eef_Func016C())then
if(eef_Func016Func001C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="copyO"
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],4,5))
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]="copyON"
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+24)]=ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]
return
endif
if(eef_Func018C())then
if(eef_Func018Func001C())then
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]=10
call ConditionalTriggerExecute(tttply)
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
set ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]=ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]
call ConditionalTriggerExecute(tttply)
return
endif
if(eef_Func020C())then
if(eef_Func020Func001C())then
return
endif
set ddtemp[(1+GetPlayerId(GetTriggerPlayer()))]=S2I(SubStringBJ(ddchat[(1+GetPlayerId(GetTriggerPlayer()))],3,5))
if(eef_Func020Func003C())then
return
endif
call CustomVictoryBJ(Player(-1+(ddtemp[(1+GetPlayerId(GetTriggerPlayer()))])),false,false)
return
endif
endfunction
function eealut_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eealut_Func014C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="copyON")
endfunction
function eealut_Func015C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="copyO")
endfunction
function eealut_Func016C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="exchE")
endfunction
function eealut_Func017C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="exchN")
endfunction
function eealut_Func018C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="move")
endfunction
function eealut_Func019C takes nothing returns boolean
return(ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=="copyU")
endfunction
function eealut_Func021C takes nothing returns boolean
return(IsPlayerAlly(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function eealut_Func022C takes nothing returns boolean
return(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetTriggerPlayer()))
endfunction
function eealut_Actions takes nothing returns nothing
if(eealut_Func014C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+24)])),GetTriggerUnit())
return
endif
if(eealut_Func015C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],bj_forLoopAIndex)),GetTriggerUnit())
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if(eealut_Func016C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
set ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]=GetUnitLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
set ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)])
call SetUnitPositionLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)])
call CreateNUnitsAtLoc(1,'ewsp',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call SetUnitOwner(GetTriggerUnit(),GetOwningPlayer(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),true)
call SetUnitOwner(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],GetOwningPlayer(bj_lastCreatedUnit),true)
call RemoveUnit(bj_lastCreatedUnit)
return
endif
if(eealut_Func017C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
set ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]=GetUnitLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))])
set ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]=GetUnitLoc(GetTriggerUnit())
call SetUnitPositionLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
call SetUnitPositionLoc(GetTriggerUnit(),ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)])
call SetUnitPositionLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],ddpoint[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)])
return
endif
if(eealut_Func018C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
call SetUnitPositionLoc(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],GetUnitLoc(GetTriggerUnit()))
return
endif
if(eealut_Func019C())then
set ddngk[((1+GetPlayerId(GetTriggerPlayer()))*100)]=""
call CreateNUnitsAtLoc(1,'ewsp',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call ReplaceUnitBJ(bj_lastCreatedUnit,GetUnitTypeId(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),3)
call SetUnitOwner(bj_lastReplacedUnit,GetTriggerPlayer(),true)
call SetHeroLevelBJ(bj_lastReplacedUnit,GetHeroLevel(ddunit[(1+GetPlayerId(GetTriggerPlayer()))]),false)
call ModifyHeroStat(0,bj_lastReplacedUnit,2,GetHeroStatBJ(0,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(1,bj_lastReplacedUnit,2,GetHeroStatBJ(1,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],true))
call ModifyHeroStat(2,bj_lastReplacedUnit,2,GetHeroStatBJ(2,ddunit[(1+GetPlayerId(GetTriggerPlayer()))],true))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(ddunit[(1+GetPlayerId(GetTriggerPlayer()))],bj_forLoopAIndex)),bj_lastReplacedUnit)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetUnitLoc(bj_lastReplacedUnit),1.)
return
endif
set ddunit[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
if(eealut_Func021C())then
call ConditionalTriggerExecute(ttally)
endif
if(eealut_Func022C())then
call ConditionalTriggerExecute(ttenem)
endif
endfunction
function eeally_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eeally_Func003C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+27)]=="move")
endfunction
function eeally_Func004C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+2)]=="cd")
endfunction
function eeally_Func005C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+3)]=="bf")
endfunction
function eeally_Func006C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)]=="life")
endfunction
function eeally_Func007C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)]=="mana")
endfunction
function eeally_Func008C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)]=="speed")
endfunction
function eeally_Func009C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]=="money")
endfunction
function eeally_Func010C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]=="lumber")
endfunction
function eeally_Func011C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)]=="allatr")
endfunction
function eeally_Func012C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)]=="stren")
endfunction
function eeally_Func013C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)]=="zhili")
endfunction
function eeally_Func014C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)]=="mj")
endfunction
function eeally_Func015C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]=="level")
endfunction
function eeally_Actions takes nothing returns nothing
if(eeally_Func003C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endif
if(eeally_Func004C())then
call UnitResetCooldown(GetTriggerUnit())
endif
if(eeally_Func005C())then
call UnitRemoveBuffsBJ(1,GetTriggerUnit())
endif
if(eeally_Func006C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())+I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+4)])))
endif
if(eeally_Func007C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+5)])))
endif
if(eeally_Func008C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())+I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+6)])))
endif
if(eeally_Func009C())then
call AdjustPlayerStateBJ(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ((ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+7)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_GOLD_GATHERED)
endif
if(eeally_Func010C())then
call AdjustPlayerStateBJ(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)],GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ((ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+8)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_LUMBER_GATHERED)
endif
if(eeally_Func011C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)])
call ModifyHeroStat(1,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)])
call ModifyHeroStat(2,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+9)])
endif
if(eeally_Func012C())then
call ModifyHeroStat(0,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+10)])
endif
if(eeally_Func013C())then
call ModifyHeroStat(2,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+11)])
endif
if(eeally_Func014C())then
call ModifyHeroStat(1,GetTriggerUnit(),0,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+12)])
endif
if(eeally_Func015C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())+ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+13)]),false)
endif
endfunction
function eeenem_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eeenem_Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)]=="-life")
endfunction
function eeenem_Func002C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)]=="-mana")
endfunction
function eeenem_Func003C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)]=="-speed")
endfunction
function eeenem_Func004C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]=="-money")
endfunction
function eeenem_Func005C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]=="-lumber")
endfunction
function eeenem_Func006C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)]=="-allatr")
endfunction
function eeenem_Func007C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)]=="-stren")
endfunction
function eeenem_Func008C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)]=="-zhili")
endfunction
function eeenem_Func009C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)]=="-mj")
endfunction
function eeenem_Func010C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]=="-level")
endfunction
function eeenem_Actions takes nothing returns nothing
if(eeenem_Func001C())then
call SetWidgetLife(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())-I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+19)])))
endif
if(eeenem_Func002C())then
call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())-I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+20)])))
endif
if(eeenem_Func003C())then
call SetUnitMoveSpeed(GetTriggerUnit(),(GetUnitDefaultMoveSpeed(GetTriggerUnit())-I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+21)])))
endif
if(eeenem_Func004C())then
call AdjustPlayerStateBJ((ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+22)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
endif
if(eeenem_Func005C())then
call AdjustPlayerStateBJ((ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+23)]*-1),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(eeenem_Func006C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)])
call ModifyHeroStat(1,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)])
call ModifyHeroStat(2,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+14)])
endif
if(eeenem_Func007C())then
call ModifyHeroStat(0,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+15)])
endif
if(eeenem_Func008C())then
call ModifyHeroStat(2,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+16)])
endif
if(eeenem_Func009C())then
call ModifyHeroStat(1,GetTriggerUnit(),1,ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+17)])
endif
if(eeenem_Func010C())then
call SetHeroLevelBJ(GetTriggerUnit(),(GetHeroLevel(GetTriggerUnit())-ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+18)]),false)
endif
endfunction
function eerlv_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))
endfunction
function eerlv_Func001C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]=="home")
endfunction
function eerlv_Func002C takes nothing returns boolean
return(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+1)]=="fh")
endfunction
function eerlv_Actions takes nothing returns nothing
if(eerlv_Func001C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(ddunit[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]))
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
return
endif
if(eerlv_Func002C())then
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
endif
endfunction
function eehc_Conditions takes nothing returns boolean
return(R2I(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit()))==0)and(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(ddngk[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]=="home")
endfunction
function eehc_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetUnitLoc(ddunit[(((1+GetPlayerId(GetTriggerPlayer()))*100)+26)]))
call TriggerSleepAction(.0)
call ReviveHeroLoc(GetTriggerUnit(),GetUnitLoc(GetTriggerUnit()),false)
endfunction
function eeinfo_Func001Func001C takes nothing returns boolean
return(ddngk[bj_forLoopAIndex]=="PuC")
endfunction
function eeinfo_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(eeinfo_Func001Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(Player(-1+(bj_forLoopAIndex))),5.,("|cFF00FF00www.|cffFFFF00NGKiller|cFF00FF00.com|r"+"   |cFFFF0000PuC|r(Version:|cFF00FF0012.7|r)"))
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function eetply_Conditions takes nothing returns boolean
return(ddngk[(1+GetPlayerId(GetTriggerPlayer()))]=="PuC")
endfunction
function eetply_Func002Func001Func001C takes nothing returns boolean
return(ddngk[bj_forLoopAIndex]=="PuC")
endfunction
function eetply_Func002Func001Func002C takes nothing returns boolean
return(ddngk[bj_forLoopAIndex]=="PuC")
endfunction
function eetply_Func002Func001C takes nothing returns boolean
return(GetPlayerSlotState(Player(-1+(bj_forLoopAIndex)))==PLAYER_SLOT_STATE_PLAYING)and(GetPlayerController(Player(-1+(bj_forLoopAIndex)))==MAP_CONTROL_USER)
endfunction
function eetply_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(eetply_Func002Func001C())then
if(eetply_Func002Func001Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-]")+" |cffFF0000NGK|cff00FF00 ")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cff00FF00")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
else
if(eetply_Func002Func001Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cffFF0000NGK|cffC0C0C0 ")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
else
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),I2R(ddval[(((1+GetPlayerId(GetTriggerPlayer()))*100)+25)]),((((("|cff00FF00[-|cffFF0000"+I2S(bj_forLoopAIndex))+"|cff00FF00-] ")+"|cffC0C0C0")+GetPlayerName(Player(-1+(bj_forLoopAIndex))))+(" |cffFFFF00"+(I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_GOLD))+(" |cff00FF00 "+I2S(GetPlayerState(Player(-1+(bj_forLoopAIndex)),PLAYER_STATE_RESOURCE_LUMBER)))))))
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function NGKPuC takes nothing returns nothing
call TriggerRegisterPlayerChatEvent(ttpuc,Player(0),"ngkpuc",true)
call TriggerAddAction(ttpuc,function eepuc_Actions)
call TriggerRegisterPlayerChatEvent(ttfir,Player(0),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(1),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(2),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(3),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(4),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(5),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(6),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(7),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(8),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(9),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(10),"",false)
call TriggerRegisterPlayerChatEvent(ttfir,Player(11),"",false)
call TriggerAddCondition(ttfir,Condition(function eefir_Conditions))
call TriggerAddAction(ttfir,function eefir_Actions)
call TriggerAddAction(ttngk,function eengk_Actions)
call TriggerAddCondition(ttg,Condition(function eeg_Conditions))
call TriggerAddAction(ttg,function eeg_Actions)
call TriggerAddCondition(tth,Condition(function eeh_Conditions))
call TriggerAddAction(tth,function eeh_Actions)
call TriggerAddCondition(tta,Condition(function eea_Conditions))
call TriggerAddAction(tta,function eea_Actions)
call TriggerAddCondition(ttb,Condition(function eeb_Conditions))
call TriggerAddAction(ttb,function eeb_Actions)
call TriggerAddCondition(ttc,Condition(function eec_Conditions))
call TriggerAddAction(ttc,function eec_Actions)
call TriggerAddCondition(ttd,Condition(function eed_Conditions))
call TriggerAddAction(ttd,function eed_Actions)
call TriggerAddCondition(tte,Condition(function eee_Conditions))
call TriggerAddAction(tte,function eee_Actions)
call TriggerAddCondition(ttf,Condition(function eef_Conditions))
call TriggerAddAction(ttf,function eef_Actions)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(ttalut,Player(11),true)
call TriggerAddCondition(ttalut,Condition(function eealut_Conditions))
call TriggerAddAction(ttalut,function eealut_Actions)
call TriggerRegisterAnyUnitEventBJ(ttally,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(ttally,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(ttally,Condition(function eeally_Conditions))
call TriggerAddAction(ttally,function eeally_Actions)
call TriggerAddCondition(ttenem,Condition(function eeenem_Conditions))
call TriggerAddAction(ttenem,function eeenem_Actions)
call TriggerRegisterAnyUnitEventBJ(ttrlv,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(ttrlv,Condition(function eerlv_Conditions))
call TriggerAddAction(ttrlv,function eerlv_Actions)
call TriggerRegisterAnyUnitEventBJ(tthc,EVENT_PLAYER_UNIT_DROP_ITEM)
call TriggerAddCondition(tthc,Condition(function eehc_Conditions))
call TriggerAddAction(tthc,function eehc_Actions)
call TriggerRegisterTimerEventPeriodic(ttinfo,100.)
call TriggerAddAction(ttinfo,function eeinfo_Actions)
call TriggerAddCondition(tttply,Condition(function eetply_Conditions))
call TriggerAddAction(tttply,function eetply_Actions)
endfunction