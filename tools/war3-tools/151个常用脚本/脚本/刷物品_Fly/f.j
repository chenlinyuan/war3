function Fly_ItName_All takes nothing returns nothing
local integer i=1
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if(s=="-sa")then
set Fly_sa_n=Fly_sa_n+1
else
if(S2I(SubString(s,3,k))>Fly_all_list_n)then
set Fly_sa_n=Fly_sa_n+1
else
if(S2I(SubString(s,3,k))>0)then
set Fly_sa_n=S2I(SubString(s,3,k))
endif
endif
endif
set Fly_saII=(Fly_sa_n-1)*50
set Fly_saIII=((ljzc_n-Fly_saII)/ 5)
if(Fly_sa_n==Fly_all_list_n)then
if(ljzc_n>(Fly_saII+4))then
loop
exitwhen i>Fly_saIII
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S((i+Fly_saII)))+(".|r"+(Fly_all_name[(i+Fly_saII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+Fly_saIII))+(".|r"+(Fly_all_name[((i+Fly_saII)+Fly_saIII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*2)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(Fly_saIII*2))]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*3)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(Fly_saIII*3))]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*4)))+(".|r"+Fly_all_name[((i+Fly_saII)+(Fly_saIII*4))])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(ljzc_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-2)+".|r"+Fly_all_name[(ljzc_n-2)]+" |cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-3)+".|r"+Fly_all_name[(ljzc_n-3)]+" |cffffff00"+I2S(ljzc_n-2)+".|r"+Fly_all_name[(ljzc_n-2)]+" |cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
endif
endif
endif
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sa_n)+("/"+I2S(Fly_all_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sa\"")))
set Fly_sa_n=0
else
loop
exitwhen i>(50/ 5)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S((i+Fly_saII)))+(".|r"+(Fly_all_name[(i+Fly_saII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+(50/ 5)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(50/ 5))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*2)))+(".|r"+(Fly_all_name[((i+Fly_saII)+((50/ 5)*2))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*3)))+(".|r"+(Fly_all_name[((i+Fly_saII)+((50/ 5)*3))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*4)))+(".|r"+Fly_all_name[((i+Fly_saII)+((50/ 5)*4))])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sa_n)+("/"+I2S(Fly_all_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sa\"")))
endif
set s=null
endfunction
function Fly_ItName_Part takes nothing returns nothing
local integer i=1
local integer l=0
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if(s=="-sc")then
set Fly_sc_n=(Fly_sc_n+1)
else
if(S2I(SubString(s,3,k))>Fly_part_list_n)then
set Fly_sc_n=(Fly_sc_n+1)
else
if(S2I(SubString(s,3,k))>0)then
set Fly_sc_n=(S2I(SubString(s,3,k)))
endif
endif
endif
set Fly_scII=((Fly_sc_n-1)*50)
set Fly_scIII=((Fly_part_n-Fly_scII)/ 5)
if(Fly_sc_n==Fly_part_list_n)and(Fly_part_list_n!=1)then
if(Fly_part_n>(Fly_scII+4))then
loop
exitwhen i>Fly_scIII
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[(i+Fly_scII)]))+(".|r"+(Fly_part_name[(i+Fly_scII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+Fly_scIII)])+(".|r"+(Fly_part_name[((i+Fly_scII)+Fly_scIII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*2))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(Fly_scIII*2))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*3))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(Fly_scIII*3))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*4))])+(".|r"+Fly_part_name[((i+Fly_scII)+(Fly_scIII*4))])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(Fly_part_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-3)])+".|r"+Fly_part_name[(Fly_part_n-3)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
elseif(Fly_part_list_n==1)then
if(ModuloInteger(Fly_part_n,5)==0)then
set l=Fly_part_n/ 5
loop
exitwhen i>l
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[((i*5)-4)]))+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-4)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-3)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-3)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-2)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-2)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-1)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-1)]]+(" |cffffff00"+(I2S(Fly_part_No[i*5])+(".|r"+Fly_part_name[Fly_part_No[i*5]])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
set s=null
else
set l=(Fly_part_n/ 5)+1
if(Fly_part_n>5)then
loop
exitwhen i>l-1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[((i*5)-4)]))+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-4)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-3)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-3)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-2)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-2)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-1)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-1)]]+(" |cffffff00"+(I2S(Fly_part_No[i*5])+(".|r"+Fly_part_name[Fly_part_No[i*5]])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(Fly_part_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-3)])+".|r"+Fly_part_name[(Fly_part_n-3)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
set s=null
endif
else
if(Fly_part_n!=0)then
loop
exitwhen i>50/ 5
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[(i+Fly_scII)]))+(".|r"+(Fly_part_name[(i+Fly_scII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(50/ 5))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(50/ 5))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*2))])+(".|r"+(Fly_part_name[((i+Fly_scII)+((50/ 5)*2))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*3))])+(".|r"+(Fly_part_name[((i+Fly_scII)+((50/ 5)*3))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*4))])+(".|r"+Fly_part_name[((i+Fly_scII)+((50/ 5)*4))])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000此|CFFFF6600地|CFFFFFF00图|CFF00FF00没|CFF00FFFF有|CFF0000FF彩|CFFFF0000色|CFFFF6600装备"))
endif
endif
set s=null
endfunction
function Fly_Item_sc takes nothing returns nothing
local integer i=0
local integer k=0
local string s1
loop
set s1=Fly_all_name[i]
if SubString(s1,0,1)=="|" then
if SubString(s1,1,2)=="c" or SubString(s1,1,2)=="C" then
set k=k+1
set Fly_part_name[k]=s1
set Fly_part_No[k]=i
set Fly_part_n=Fly_part_n+1
elseif SubString(s1,1,2)=="r" or SubString(s1,1,2)=="R" then
set k=k+1
set Fly_part_name[k]=s1
set Fly_part_No[k]=i
set Fly_part_n=Fly_part_n+1
endif
endif
if(i==ljzc_n)then
if(ModuloInteger(Fly_part_n,50)==0)then
set Fly_part_list_n=Fly_part_n/ 50
else
set Fly_part_list_n=((Fly_part_n/ 50)+1)
endif
endif
exitwhen i>ljzc_n
set i=i+1
endloop
set s1=null
endfunction
function Fly_It_Name takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
local trigger t1=CreateTrigger()
loop
call TriggerRegisterPlayerChatEvent(t,Player(i),"-sa",false)
call TriggerRegisterPlayerChatEvent(t1,Player(i),"-sc",false)
set i=i+1
exitwhen i==11
endloop
call TriggerAddAction(t1,function Fly_ItName_Part)
call TriggerAddAction(t,function Fly_ItName_All)
endfunction
function FYMessage takes string msg returns nothing
local integer i=0
loop
call DisplayTimedTextToPlayer(Player(i),0,0,300,msg)
set i=i+1
exitwhen i==11
endloop
endfunction
function C_IM takes integer p,string s returns nothing
local integer i=0
local integer j=1
local integer k=StringLength(s)
local integer k1
local string s1
loop
set s1=GetObjectName(ljzc_it[i])
set k1=StringLength(s1)
set j=1
loop
if SubString(s1,j-1,j)=="|" then
if SubString(s1,j,j+1)=="c" or SubString(s1,j,j+1)=="C" then
set s1=SubString(s1,0,j-1)+SubString(s1,j+9,k1)
set j=j-1
elseif SubString(s1,j,j+1)=="r" or SubString(s1,j,j+1)=="R" then
set s1=SubString(s1,0,j-1)+SubString(s1,j+1,k1)
endif
endif
exitwhen j>=k1
set j=j+1
endloop
if SubString(s,8,k)==SubString(s1,0,k-8)then
call CreateItem(ljzc_it[i],pfzy_wpX[GetPlayerId(GetTriggerPlayer())],pfzy_wpY[GetPlayerId(GetTriggerPlayer())])
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建 |r"+s1)
endif
exitwhen(i==ljzc_n)
set i=i+1
endloop
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建完成! |r")
set s1=null
endfunction
function YLS_0000 takes nothing returns boolean
local string s1
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if(s=="fly-ffsj")then
set yls_ok=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cff0000ff开启成功！！|r")
endif
if yls_ok then
if SubString(s,0,8)=="=获得 " then
call C_IM(GetPlayerId(GetTriggerPlayer()),s)
endif
if SubString(s,0,2)=="=#" then
set s1=GetObjectName(ljzc_it[S2I(SubString(s,2,k))])
call CreateItem(ljzc_it[S2I(SubString(s,2,k))],pfzy_wpX[GetPlayerId(GetTriggerPlayer())],pfzy_wpY[GetPlayerId(GetTriggerPlayer())])
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 创建 |r"+s1)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 创建完成! |r")
endif
endif
return false
endfunction
function YLS_ylsNB takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"",false)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function YLS_0000))
endfunction
function ljcsh takes nothing returns nothing
local integer i=0
loop
exitwhen i>=62
if(i<=9)then
set ljzc_id[i]=i+48
elseif(i<=35)then
set ljzc_id[i]=i+55
else
set ljzc_id[i]=i+61
endif
set i=i+1
endloop
endfunction
function ljid6 takes nothing returns nothing
local integer i=0
local item it
local integer j=1
local integer k1
local string s1
loop
set it=CreateItem(ljzc_ida+ljzc_idb+ljzc_idc+ljzc_id[i],0,0)
if(it!=null)then
set ljzc_n=ljzc_n+1
set ljzc_it[ljzc_n]=GetItemTypeId(it)
set Fly_all_name[ljzc_n]=GetObjectName(ljzc_it[ljzc_n])
endif
call RemoveItem(it)
exitwhen i==61
set i=i+1
endloop
set it=null
endfunction
function ljid5 takes nothing returns nothing
set ljzc_idc=256*ljzc_id[ljzc_ic]
set ljzc_ic=ljzc_ic+1
if(ljzc_ic==62)then
call PauseTimer(ljzc_tmc)
call DestroyTimer(ljzc_tmc)
set ljzc_ic=0
endif
call ljid6()
endfunction
function ljid4 takes nothing returns nothing
set ljzc_tmc=CreateTimer()
call TimerStart(ljzc_tmc,.0005,true,function ljid5)
endfunction
function ljid3 takes nothing returns nothing
set ljzc_idb=256*256*ljzc_id[ljzc_ib]
set ljzc_ib=ljzc_ib+1
if(ljzc_ib==62)then
call PauseTimer(ljzc_tmb)
call DestroyTimer(ljzc_tmb)
set ljzc_ib=0
endif
call ljid4()
endfunction
function ljid2 takes nothing returns nothing
set ljzc_tmb=CreateTimer()
call TimerStart(ljzc_tmb,.0322,true,function ljid3)
endfunction
function ljid1 takes nothing returns nothing
set ljzc_ida=256*256*256*ljzc_id[ljzc_ia]
set ljzc_ia=ljzc_ia+1
if(ljzc_ia==62)then
call PauseTimer(ljzc_tm)
call DestroyTimer(ljzc_tm)
if(ModuloInteger(ljzc_n,50)==0)then
set Fly_all_list_n=(ljzc_n/ 50)
else
set Fly_all_list_n=((ljzc_n/ 50)+1)
endif
call FYMessage("|cffff0000"+("物品列表加载完毕,共加载到物品 |cffff00ff"+(I2S(ljzc_n)+" |cffff0000个！")))
call YLS_ylsNB()
call Fly_It_Name()
call Fly_Item_sc()
endif
call ljid2()
endfunction
function ljzc takes nothing returns nothing
call ljcsh()
set ljzc_ia=0
set ljzc_ib=0
set ljzc_ic=0
set ljzc_n=0
set Fly_sa_n=0
set Fly_sc_n=0
set Fly_part_n=0
set ljzc_tm=CreateTimer()
call TimerStart(ljzc_tm,2,true,function ljid1)
endfunction
function fly_main takes nothing returns nothing
set pfzy_wpX[GetPlayerId(GetTriggerPlayer())]=GetUnitX(GetTriggerUnit())
set pfzy_wpY[GetPlayerId(GetTriggerPlayer())]=GetUnitY(GetTriggerUnit())
endfunction
function Fly_main takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(24),null)
set i=i+1
endloop
call ljzc()
call TriggerAddAction(t,function fly_main)
endfunction
