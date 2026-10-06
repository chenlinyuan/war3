function BigMan_CCODE takes nothing returns integer
local integer bmlocindex=0
loop
exitwhen BigMan_T[bmlocindex]==null
set bmlocindex=bmlocindex+1
endloop
set BigMan_T[bmlocindex]=CreateTimer()
return bmlocindex
endfunction
function BigMan_GCODE takes timer bmloctm returns integer
local integer bmlocindex=0
loop
exitwhen BigMan_T[bmlocindex]==bmloctm
set bmlocindex=bmlocindex+1
endloop
return bmlocindex
endfunction
function BigMan_DCODE takes integer bmlocindex returns nothing
call PauseTimer(BigMan_T[bmlocindex])
call DestroyTimer(BigMan_T[bmlocindex])
set BigMan_H[bmlocindex]=null
set BigMan_T[bmlocindex]=null
endfunction

function BigMan_ID2S takes integer value returns string
local string charMap =BigMan_AllString
local string result = ""
local integer remainingValue = value
local integer charValue
local integer byteno
set byteno = 0
loop
set charValue = ModuloInteger(remainingValue, 256)
set remainingValue = remainingValue / 256
set result = SubString(charMap, charValue, charValue + 1) + result
set byteno = byteno + 1
exitwhen byteno == 4
endloop
return result
endfunction

function BigMan_S2ID takes string targetstr returns integer
local string originstr=BigMan_AllString
local integer strlength=StringLength(targetstr)
local integer bmloca=0
local integer bmlocb=0
local integer bmlocnumx=1
local integer result=0
loop
exitwhen bmlocb>strlength-1
set bmlocnumx=R2I(Pow(256,strlength-1-bmlocb))
set bmloca=1
loop
exitwhen bmloca>255
if SubString(targetstr,bmlocb,bmlocb+1)==SubString(originstr,bmloca,bmloca+1) then
set result=result+bmloca*bmlocnumx
set bmloca=256
endif
set bmloca=bmloca+1
endloop
set bmlocb=bmlocb+1
endloop
return result
endfunction

function BigMan_Ability_classify takes nothing returns nothing
local item bmlocit=null
local integer bmlocc=1
local integer bmloci=0
local integer bmlocz=BigMan_Item_Index[4000]/2
local integer bmloce=BigMan_Item_Index[4000]
loop
set bmlocit=CreateItem(BigMan_ItemTypeId[bmlocc+4100],0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
else
set bmloci=bmloci+1
set BigMan_ItemTypeId[bmloci+4000]=BigMan_ItemTypeId[bmlocc+4100]
set BigMan_ItemName[bmloci+4000]=GetObjectName(BigMan_ItemTypeId[bmlocc+4100])
endif
set bmlocc=bmlocc+1
exitwhen bmlocc>bmlocz
endloop
loop
set bmlocit=CreateItem(BigMan_ItemTypeId[bmlocc+4100],0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
else
set bmloci=bmloci+1
set BigMan_ItemTypeId[bmloci+4000]=BigMan_ItemTypeId[bmlocc+4100]
set BigMan_ItemName[bmloci+4000]=GetObjectName(BigMan_ItemTypeId[bmlocc+4100])
endif
set BigMan_Item_Index[4000]=bmloci
set bmlocc=bmlocc+1
exitwhen bmlocc>bmloce
endloop
set BigMan_Item_Index[4000]=bmloci
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00筛选结束，共有技能：|r|cffff0000"+I2S(BigMan_Item_Index[4000])+"|r  |cff00ff00搜索用时：|r"+R2S(TimerGetElapsed(BigMan_Ability_tm)))
call PauseTimer(BigMan_Ability_tm)
call DestroyTimer(BigMan_Ability_tm)
set bmlocit=null
endfunction

function BigMan_Ability_Loop takes nothing returns nothing
local integer bmlocc=BigMan_Item_Index[4000]
local integer bmlocc3=48
local integer bmlocc4=48
local integer bmlocid=0
loop
exitwhen bmlocc4>122
set bmlocid=(256*256*256*BigMan_Item_Index[4001])+(256*256*BigMan_Item_Index[4002])+(256*BigMan_Item_Index[4003])+bmlocc4
if GetObjectName(bmlocid) !="Default string" then
set bmlocc=bmlocc+1
set BigMan_ItemTypeId[bmlocc+4100]=bmlocid
set BigMan_ItemName[bmlocc+4100]=GetObjectName(bmlocid)
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,BigMan_ItemName[bmlocc+4100]+"  "+StringCase(BigMan_ID2S(bmlocid),true))
endif
if bmlocc4==57 then
set bmlocc4=97
else
set bmlocc4=bmlocc4+1
endif
endloop
set BigMan_Item_Index[4000]=bmlocc
endfunction

function BigMan_Ability_Name_Start takes nothing returns nothing
call BigMan_Ability_Loop()
if BigMan_Item_Index[4001]>=115 and BigMan_Item_Index[4002]>=122 then
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00搜索结束，共找到技能：|r|cffff0000"+I2S(BigMan_Item_Index[4000])+"|r  |cff00ff00开始进行筛选……|r")
call BigMan_Ability_classify()
 else
if BigMan_Item_Index[4002]==57 then
set BigMan_Item_Index[4002]=97
elseif BigMan_Item_Index[4002]>122 then
set BigMan_Item_Index[4002]=48
set BigMan_Item_Index[4001]=115
endif
if BigMan_Item_Index[4003]==57 then
set BigMan_Item_Index[4003]=97
elseif BigMan_Item_Index[4003]==122 then
set BigMan_Item_Index[4003]=48
set BigMan_Item_Index[4002]=BigMan_Item_Index[4002]+1
else
set BigMan_Item_Index[4003]=BigMan_Item_Index[4003]+1
endif
endif
endfunction

function BigMan_Ability_Name takes nothing returns nothing
local timer bmloct=CreateTimer()
if BigMan_TOF[6666] then
set BigMan_TOF[6666]=false
set BigMan_Item_Index[4001]=97
set BigMan_Item_Index[4002]=48
set BigMan_Item_Index[4003]=48
set BigMan_Item_Index[4000]=0
//********************************
//要提高搜索速度修改下面的0.05数值，数值越小搜索速度越快。
call TimerStart(bmloct,0.01,true,function BigMan_Ability_Name_Start)
//Up
//********************************
endif
set bmloct=null
endfunction


function BigMan_Item_Loop2 takes nothing returns nothing
local integer bmlocc=BigMan_Item_Index[0]
local integer bmlocc3=48
local integer bmlocc4=48
local integer bmlocid=0
local item bmlocit
loop
exitwhen bmlocc3>90
set bmlocc4=48
loop
exitwhen bmlocc4>90
set bmlocid=(256*256*256*BigMan_Item_Index[1])+(256*256*BigMan_Item_Index[2])+(256*bmlocc3)+bmlocc4
set bmlocit=CreateItem(bmlocid,0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
set bmlocc=bmlocc+1
set BigMan_ItemTypeId[bmlocc]=bmlocid
set BigMan_ItemName[bmlocc]=GetObjectName(bmlocid)
endif
if bmlocc4==57 then
set bmlocc4=65
else
set bmlocc4=bmlocc4+1
endif
endloop
if bmlocc3==57 then
set bmlocc3=65
else
set bmlocc3=bmlocc3+1
endif
endloop
set BigMan_Item_Index[0]=bmlocc
set bmlocit=null
endfunction

function BigMan_Item_Loop1 takes nothing returns nothing
local integer bmlocc=BigMan_Item_Index[0]
local integer bmlocc3=48
local integer bmlocc4=48
local integer bmlocid=0
local item bmlocit
loop
exitwhen bmlocc3>=123
set bmlocc4=48
loop
exitwhen bmlocc4>=123
set bmlocid=(256*256*256*BigMan_Item_Index[1])+(256*256*BigMan_Item_Index[2])+(256*bmlocc3)+bmlocc4
set bmlocit=CreateItem(bmlocid,0,0)
if bmlocit!=null then
call RemoveItem(bmlocit)
set bmlocc=bmlocc+1
set BigMan_ItemTypeId[bmlocc]=bmlocid
set BigMan_ItemName[bmlocc]=GetObjectName(bmlocid)
endif
if bmlocc4==57 then
set bmlocc4=97
else
set bmlocc4=bmlocc4+1
endif
endloop
if bmlocc3==57 then
set bmlocc3=97
else
set bmlocc3=bmlocc3+1
endif
endloop
set BigMan_Item_Index[0]=bmlocc
set bmlocit=null
endfunction

function BigMan_Item_Name_Start takes nothing returns nothing
if BigMan_Item_Index[1]==73 then
call BigMan_Item_Loop2()
if BigMan_Item_Index[2]>=90 then
call PauseTimer(GetExpiredTimer())
call DestroyTimer(GetExpiredTimer())
call PauseTimer(BigMan_Item_tm)
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00搜索结束，共找到物品：|r|cffff0000"+I2S(BigMan_Item_Index[0])+"|r  |cff00ff00搜索用时：|r"+R2S(TimerGetElapsed(BigMan_Item_tm)))
call DestroyTimer(BigMan_Item_tm)
elseif BigMan_Item_Index[2]==57 then
set BigMan_Item_Index[2]=65
else
set BigMan_Item_Index[2]=BigMan_Item_Index[2]+1
endif
else
call BigMan_Item_Loop1()
if BigMan_Item_Index[2]==57 then
set BigMan_Item_Index[2]=97
else
set BigMan_Item_Index[2]=BigMan_Item_Index[2]+1
endif
if BigMan_Item_Index[2]>=123 then
set BigMan_Item_Index[2]=48
set BigMan_Item_Index[1]=BigMan_Item_Index[1]+1
endif
if BigMan_Item_Index[1]>=123 then
set BigMan_Item_Index[1]=73
endif
endif
endfunction

function BigMan_Item_Name takes nothing returns nothing
local timer bmloct=CreateTimer()
set BigMan_Item_Index[1]=97
set BigMan_Item_Index[2]=48
set BigMan_Item_Index[0]=0
//********************************
//要提高搜索速度修改下面的0.01数值，修改为0.007时，总搜索速度为6.804
call TimerStart(bmloct,0.01,true,function BigMan_Item_Name_Start)
//Up
//********************************
set bmloct=null
endfunction

function BigMan_CleanItem_Fun takes nothing returns nothing
if IsItemVisible(GetEnumItem()) then
if GetWidgetLife(GetEnumItem())<=0.401 then
call SetWidgetLife(GetEnumItem(),1)
endif
call RemoveItem(GetEnumItem())
endif
endfunction
function BigMan_CleanItem takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function BigMan_CleanItem_Fun)
endfunction

function BigMan_ItemName_Init takes nothing returns nothing
if BigMan_TOF[7777] then
set BigMan_TOF[7777]=false
call BigMan_Item_Name()
set BigMan_Item_tm=CreateTimer()
call TimerStart(BigMan_Item_tm,20,false,null)
endif
endfunction

function BigMan_Item_Query takes player bmlocp,string bmlocs returns nothing
local integer bmloci=1
local integer bmlocc=0
local integer bmlock=StringLength(bmlocs)
local integer bmlocpa=S2I(SubString(bmlocs,10,bmlock))
local integer bmlocpage=BigMan_Item_Page[GetPlayerId(bmlocp)]
local integer totalpage=BigMan_Item_Index[0]/75+1
local string array bmlocname
local integer bmlocti=0
if SubString(bmlocs,1,10)=="查技能" then
set bmlocti=4000
set bmlocpage=BigMan_Item_Page[GetPlayerId(bmlocp)+bmlocti]
set totalpage=BigMan_Item_Index[0+bmlocti]/75+1
endif
if bmlocpa==0 then
if bmlocpage>=totalpage then
set bmlocpage=1
else
set bmlocpage=bmlocpage+1
endif
else
if(bmlocpa>totalpage)then
if bmlocpage>=totalpage then
set bmlocpage=totalpage
else
set bmlocpage=bmlocpage+1
endif
else
if(bmlocpa>0)then
set bmlocpage=bmlocpa
endif
endif
endif
if bmlocpage<=0 then
set bmlocpage=1
endif
set BigMan_Item_Page[GetPlayerId(GetTriggerPlayer())+bmlocti]=bmlocpage
loop
exitwhen bmlocc>14
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+1+(bmlocc*5)+bmlocti]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+1+(bmlocc*5)+bmlocti])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+2+(bmlocc*5)+bmlocti]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+2+(bmlocc*5)+bmlocti])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+3+(bmlocc*5)+bmlocti]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+3+(bmlocc*5)+bmlocti])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+4+(bmlocc*5)+bmlocti]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+4+(bmlocc*5)+bmlocti])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+5+(bmlocc*5)+bmlocti]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+5+(bmlocc*5)+bmlocti])+"|r "
set bmlocc=bmlocc+1
endloop
set bmlocc=0
loop
exitwhen bmlocc>14
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,bmlocname[bmlocc])
set bmlocname[bmlocc]=null
set bmlocc=bmlocc+1
endloop
if bmlocti>0 then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFF00FF00当前为第|CFF00FFFF "+I2S(bmlocpage)+"/"+I2S(totalpage)+" |r|CFF0000FF页|r|CFFFF0000查技能|r"+" |r|CFFFF6600输入@技能+技能ID+数字，可获得或删除技能。(技能ID一般为大写字母，如果不行请将最后两位或三位改成小写)"))
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFF00FF00当前为第|CFF00FFFF "+I2S(bmlocpage)+"/"+I2S(totalpage)+" |r|CFF0000FF页|r|CFFFF0000查物品|r"+" |r|CFFFF6600输入@物品+物品ID，可获得物品。(物品ID一般为小写，I开头必定为大写，除了infs及iwbr为小写外，)"))
endif
set bmlocs=null
endfunction

function BigMan_PlayerBag takes nothing returns boolean
local integer bmlocc = 0
local integer bmloci = 0
local integer bmlocpi = GetPlayerId(GetTriggerPlayer())
local integer bmlocbt = BigMan_BagTotal[bmlocpi]
if GetWidgetLife(BigMan_HERO[bmlocpi]) > 1 and bmlocbt>1 and IsUnitType(BigMan_HERO[bmlocpi],ConvertUnitType(0)) and GetOwningPlayer(BigMan_HERO[bmlocpi]) == Player(bmlocpi) then
loop
exitwhen bmlocc > 5
set BigMan_BagItem[bmlocpi*6+bmlocc] = UnitItemInSlot(BigMan_HERO[bmlocpi],bmlocc)
call SetItemPlayer( BigMan_BagItem[bmlocpi*6+bmlocc],Player(bmlocpi), true )
call SetItemPosition( BigMan_BagItem[bmlocpi*6+bmlocc], GetUnitX(BigMan_HERO[bmlocpi]), GetUnitY(BigMan_HERO[bmlocpi]) )
call SetItemVisible( BigMan_BagItem[bmlocpi*6+bmlocc], false )
if BigMan_BagItem[bmlocpi*6+bmlocc] != null then
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00将：|r"+GetItemName(BigMan_BagItem[bmlocpi*6+bmlocc])+" |cffffcc00物品ID：|r"+BigMan_ID2S(GetItemTypeId(BigMan_BagItem[bmlocpi*6+bmlocc]))+" |cffffcc00放入背包中！|r"))
endif
loop
exitwhen bmloci == bmlocbt
set BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci))] = BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci-1))]
set BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci))]=GetItemTypeId(BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*(bmlocbt-bmloci-1))])
set bmloci =bmloci+ 1
endloop
set bmloci=0
set bmlocc = bmlocc + 1
endloop
set bmlocc=0
loop
exitwhen bmlocc > 5
if BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)]!=0 then
if BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)] != null then
call UnitAddItem( BigMan_HERO[bmlocpi], BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)])
call SetItemVisible( BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)],true)
else
set BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)]=CreateItem(BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)],GetUnitX(BigMan_HERO[bmlocpi]),GetUnitY(BigMan_HERO[bmlocpi]))
call UnitAddItem( BigMan_HERO[bmlocpi],BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)]) 
endif
call DisplayTextToPlayer( GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00从背包中取出：|r"+GetItemName(BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)])+" |cffffcc00物品ID：|r"+BigMan_ID2S(BigMan_BagItemId[(bmlocpi*6+bmlocc)+(72*bmlocbt)])))
endif
set bmlocc = bmlocc + 1
endloop
endif
return false
endfunction

function BigMan_Bag_Ini takes integer bmlocpi,integer bmloci returns nothing
call DestroyTrigger(BigMan_BagTrigger[bmlocpi])
set BigMan_BagTrigger[bmlocpi]=CreateTrigger()
call TriggerRegisterPlayerEvent(BigMan_BagTrigger[bmlocpi],Player(bmlocpi),ConvertPlayerEvent(bmloci))
call TriggerAddCondition(BigMan_BagTrigger[bmlocpi], Condition(function BigMan_PlayerBag))
endfunction
  
function BigMan__AA takes nothing returns nothing
local integer bmlocid=BigMan_GCODE(GetExpiredTimer())
local unit bmlocu=BigMan_H[bmlocid]
call UnitResetCooldown(bmlocu)
call SetUnitState(bmlocu,ConvertUnitState(2),GetUnitState(bmlocu,ConvertUnitState(3)))
call UnitSetConstructionProgress(bmlocu,100)
call UnitSetUpgradeProgress(bmlocu,100)
call BigMan_DCODE(bmlocid)
set bmlocu=null
endfunction

function BigMan__A takes nothing returns nothing
local integer bmlocid
local unit bmlocu= GetTriggerUnit()
if BigMan_WCDTOF[GetPlayerId(GetOwningPlayer(bmlocu))] then
if GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0) then 
set bmlocid=BigMan_CCODE()
set BigMan_H[bmlocid]=bmlocu
call TimerStart(BigMan_T[bmlocid],0,false,function BigMan__AA)
endif
endif
set bmlocu=null
endfunction

function BigMan__ONOFF takes nothing returns nothing
local integer bmloci=0
local integer bmlocc=0
if GetEventPlayerChatString() == "@大男人" then
set BigMan_TOF[GetPlayerId(GetTriggerPlayer())] = true
call SetPlayerName(GetTriggerPlayer(), ( BigMan_Str[8100+GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer())))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC开|r|cFF4C36D9启|r|cFF333AE6了|r： |cFF1A3EF2“|r|cFF0041FF大|r|cFF076AED男|r|cFF0E94DC人|r|cFF14BDCA”|r |cFF1BE6B8脚|r|cFF29ACAA本|r|cFF37739C！|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@说明，可查看大男人脚本使用；查询脚本使用说明书或者登陆www.ymiii.com查询！|r")
elseif GetEventPlayerChatString() == "@大男人_BigMan" then
set BigMan_TOF[GetPlayerId(GetTriggerPlayer())] = true
call SetPlayerName(GetTriggerPlayer(), ( BigMan_Str[8100+GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer())))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC开|r|cFF4C36D9启|r|cFF333AE6了|r： |cFF1A3EF2“|r|cFF0041FF大|r|cFF076AED男|r|cFF0E94DC人|r|cFF14BDCA”|r |cFF1BE6B8脚|r|cFF29ACAA本|r|cFF37739C！|r"))
set BigMan_WCDTOF[GetPlayerId(GetTriggerPlayer())] = true
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC无|r|cFF14BDCAC|r|cFF1BE6B8D|r|cFF29ACAA回|r|cFF37739C蓝|r"))
set BigMan_Jump_TOF[GetPlayerId(GetTriggerPlayer())] = true
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC跳|r|cFF14BDCA斩|r|cFF1BE6B8！|r"))
elseif SubString(GetEventPlayerChatString(), 1, 10) == "查物品" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if BigMan_TOF[7777] then
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00开始地图内物品检索，预计搜索需要用时为9.718秒，请耐心等待！")
call BigMan_ItemName_Init()
return
endif
call BigMan_Item_Query(GetTriggerPlayer(),GetEventPlayerChatString())
elseif SubString(GetEventPlayerChatString(), 1, 10) == "查技能" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if BigMan_TOF[6666] then
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00开始地图内技能检索，预计搜索需要用时为7.2秒，请耐心等待！")
set BigMan_Ability_tm=CreateTimer()
call BigMan_Ability_Name()
call TimerStart(BigMan_Ability_tm,120,false,null)
return
endif
call BigMan_Item_Query(GetTriggerPlayer(),GetEventPlayerChatString())
elseif SubString(GetEventPlayerChatString(), 1, 7) == "背包" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if SubString(GetEventPlayerChatString(),7,10) == "ESC" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),17)
elseif SubString(GetEventPlayerChatString(),7,10) == "上" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),267)
elseif SubString(GetEventPlayerChatString(),7,10) == "下" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),265)
elseif SubString(GetEventPlayerChatString(),7,10) == "左" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),261)
elseif SubString(GetEventPlayerChatString(),7,10) == "右" then
call BigMan_Bag_Ini(GetPlayerId(GetTriggerPlayer()),263)
endif
set bmloci=S2I(SubString(GetEventPlayerChatString(),10,12))
if bmloci==0 then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
endif
if bmloci<16 then
set BigMan_BagTotal[GetPlayerId(GetTriggerPlayer())] = bmloci
if bmloci>1 then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00背包开启成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cff00ff00背包关闭成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
endif
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000输入错误背包不能大于16，请忽在其它背包有物品的时候修改背包数从多的设置为少的，否则物品丢失概不负责。|r"))
endif
elseif GetEventPlayerChatString() == "我要无CD" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_WCDTOF[GetPlayerId(GetTriggerPlayer())] = true
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC无|r|cFF14BDCAC|r|cFF1BE6B8D|r|cFF29ACAA回|r|cFF37739C蓝|r"))
elseif GetEventPlayerChatString() == "关闭无CD" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_WCDTOF[GetPlayerId(GetTriggerPlayer())] = false 
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF1A3EF2无|r|cFF0041FFC|r|cFF076AEDD|r|cFF0E94DC回|r|cFF14BDCA蓝|r"))
elseif GetEventPlayerChatString() == "打开跳斩" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_Jump_TOF[GetPlayerId(GetTriggerPlayer())] = true
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC跳|r|cFF14BDCA斩|r|cFF1BE6B8！|r"))
elseif GetEventPlayerChatString() == "关闭跳斩" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_Jump_TOF[GetPlayerId(GetTriggerPlayer())] = false
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF1A3EF2关|r|cFF0041FF闭|r|cFF076AED了|r|cFF0E94DC跳|r|cFF14BDCA斩|r|cFF1BE6B8！|r"))
elseif GetEventPlayerChatString() == "关闭效果" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_SuperEff[GetPlayerId(GetTriggerPlayer())] = ""
elseif GetEventPlayerChatString() == "打开效果" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set BigMan_SuperEff[GetPlayerId(GetTriggerPlayer())] = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl"
elseif SubString(GetEventPlayerChatString(), 1, 7) == "控制" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())])==GetTriggerPlayer() or BigMan_TOF[GetPlayerId(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))]==false then
call SetPlayerAlliance( GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]), GetTriggerPlayer(), ConvertAllianceType(6),true)
call SetPlayerAlliance( GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]), GetTriggerPlayer(), ConvertAllianceType(7),true)
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "改变" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())])==GetTriggerPlayer() or BigMan_TOF[GetPlayerId(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))]==false then
call SetUnitOwner(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], Player(GetPlayerId(GetTriggerPlayer())), true)
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "恢复" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call PauseUnit(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],false)
elseif SubString(GetEventPlayerChatString(), 1, 7) == "速度" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>0 and bmloci<99999 then
   set BigMan_SuperSpeed[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000数值不对！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "距离" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>0 and bmloci<99999 then
   set BigMan_SuperDis[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000数值不对！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "范围" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>10 and bmloci<99999 then
   set BigMan_Jump_DamAeo[GetPlayerId(GetTriggerPlayer())]=bmloci * 1.1
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000数值不对！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "伤害" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,30))
if bmloci>0 then
   set BigMan_Jump_Dam[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000数值过小！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "最近" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>99 and bmloci<BigMan_Jump_DisMax[GetPlayerId(GetTriggerPlayer())] then
   set BigMan_Jump_DisMin[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000跳斩最近距离不能小于100，最大不能超过最远距离！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "最远" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>BigMan_Jump_DisMin[GetPlayerId(GetTriggerPlayer())] and bmloci<9999 then
   set BigMan_Jump_DisMax[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000跳斩最远距离不能小于最近距离，最大不能超过9999！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "跳跃" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>99 and bmloci<9999 then
   set BigMan_Jump_Speed[GetPlayerId(GetTriggerPlayer())]=bmloci
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000不能小于100或大于9999！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "生命" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())])==GetTriggerPlayer() or BigMan_TOF[GetPlayerId(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))]==false then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if bmloci>1 and bmloci<999999 and bmloci!=0 then
   call SetPlayerState(GetTriggerPlayer(),ConvertPlayerState(1), GetPlayerState(GetTriggerPlayer(),ConvertPlayerState(1))+bmloci)
   call SetPlayerHandicap(GetTriggerPlayer(),bmloci)
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000其实是调整生命障碍倍数，最小为1倍，不叠加，只重置。|r"))
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "金钱" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,20))
if bmloci!=0 then
   call SetPlayerState(GetTriggerPlayer(),ConvertPlayerState(1), GetPlayerState(GetTriggerPlayer(),ConvertPlayerState(1))+bmloci)
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000正数加钱负数扣钱，但不能为0。|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "木材" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,20))
if bmloci!=0 then
   call SetPlayerState(GetTriggerPlayer(),ConvertPlayerState(2), GetPlayerState(GetTriggerPlayer(),ConvertPlayerState(2))+bmloci)
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000正数加木负数扣木，但不能为0。|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "经验" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,20))
if bmloci>0and bmloci<99999999 then
   call SetPlayerHandicapXP( GetTriggerPlayer(),bmloci)
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000参数1为正常，2为2倍。|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "升级" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,12))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
if bmloci>0and bmloci<999999 and bmloci!=0 then
   call SetHeroLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], ( GetUnitLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]) + bmloci ), false )
else
   call SetHeroLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], ( GetUnitLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]) + 1 ), false )
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000请先框选一个英雄！|r")
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "力量" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,22))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
if bmloci!=0 then
   call SetHeroStr(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroStr(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + bmloci), true )
else
   call SetHeroStr(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroStr(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + 1), true )
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000请先框选一个英雄！|r")
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "敏捷" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,22))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
if bmloci!=0 then
   call SetHeroAgi(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroAgi(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + bmloci), true )
else
   call SetHeroAgi(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroAgi(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + 1), true )
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000请先框选一个英雄！|r")
endif
elseif SubString(GetEventPlayerChatString(), 1, 7) == "智力" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=S2I(SubString(GetEventPlayerChatString(),7,22))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
if bmloci!=0 then
   call SetHeroInt(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroInt(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + bmloci), true )
else
   call SetHeroInt(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],( GetHeroInt(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], false) + 1), true )
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000请先框选一个英雄！|r")
endif
elseif SubString(GetEventPlayerChatString(),1,7) == "物品" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if StringCase(SubString(GetEventPlayerChatString(),7,8),true) == "I" then
set bmloci=BigMan_S2ID(StringCase(SubString(GetEventPlayerChatString(),7,11),true))
if bmloci==1230455378 then
set bmloci=1769431666
elseif bmloci==1229866579 then
set bmloci=1768842867
endif
else
set bmloci=BigMan_S2ID(StringCase(SubString(GetEventPlayerChatString(),7,11),false))
endif
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
set BigMan_Item=null
set BigMan_Item=CreateItem(bmloci,GetUnitX(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]),GetUnitY(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))
if BigMan_Item!=null then
call SetItemPlayer(BigMan_Item,GetTriggerPlayer(), true )
   call UnitAddItem(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],BigMan_Item)
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000获得物品：|r"+GetItemName(BigMan_Item))
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000物品ID错误，请先查询具体ID再输入！|r")
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000请先框选一个英雄！|r")
endif
elseif SubString(GetEventPlayerChatString(),1,7) == "技能" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
if GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())])==GetTriggerPlayer() or BigMan_TOF[GetPlayerId(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))]==false then
set bmloci=BigMan_S2ID(SubString(GetEventPlayerChatString(),7,11))
if GetObjectName(bmloci) !="Default string" then
set bmlocc=S2I(SubString(GetEventPlayerChatString(),11,13))
if bmlocc>=0 then
if GetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci)>0 then
if bmlocc>0 then
call SetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci,bmlocc)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,GetObjectName(bmloci)+" |cffffcc00技能的等级提升为：|r"+I2S(bmlocc))
else
call SetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci,GetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci)+1)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,GetObjectName(bmloci)+" |cffffcc00技能的等级提升了一级。|r")
endif
else
call UnitAddAbility(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci)
if GetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci)>0 then
call UnitMakeAbilityPermanent(BigMan_HERO[GetPlayerId(GetTriggerPlayer())], true,bmloci)
if bmlocc>0 then 
call SetUnitAbilityLevel(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci,bmlocc)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00学习了技能：|r"+GetObjectName(bmloci)+" |cffff0000技能的等级为：|r"+I2S(bmlocc))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00学习了技能：|r"+GetObjectName(bmloci)+" |cffff0000技能的等级为一级。|r")
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000技能ID输入需要区分大小写，技能首字母肯定是大写，请尝试后两位改为小写，或者后三位改为小写！|r")
endif
endif
else
call UnitRemoveAbility(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],bmloci)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000删除了技能：|r"+GetObjectName(bmloci))
   endif
else
   call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000技能ID错误，请先查询具体ID再输入！|r")
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 5) == "ID2S" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,BigMan_ID2S(S2I(SubString(GetEventPlayerChatString(),5,30))))
elseif SubString(GetEventPlayerChatString(), 1, 7) == "清理" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call BigMan_CleanItem()
elseif SubString(GetEventPlayerChatString(), 1, 7) == "说明" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00开启脚本：@大男人|r "+" |cffffcc00开启脚本所有功能：@大男人_BigMan|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00开启无CD：我要无CD  关闭无CD：关闭无CD|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00幽灵漫步命令：关闭效果   没有特效。   打开效果   显示特效，默认打开。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00-速度30初始速度30码/0.02秒(每秒1500码)就是移动速度 最小0最大99999  等于全屏闪|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00-距离600   发动距离初始600 最小0 最大99999 最好不要设置0 要不捡不起物品  距离太大 鼠标要点得很远,设为99999相当于关闭漫步|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00跳斩命令：  启用右击跳斩：打开跳斩停用右击跳斩：关闭跳斩|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00-最近100  起跳最近距离，默认100|r "+"  |cffffcc00-最远1000  起跳最近距离 默认1000|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00-伤害100  跳斩伤害，默认单位等级*100|r "+"  |cffffcc00-范围500  跳斩伤害范围，默认500码|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00玩家属性调整：-金钱999 金钱加999负数为扣钱。 -木材999  同金钱。 -生命2 所有单位提高生命为2倍|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00英雄属性调整(要先选择一个英雄)：-升级99 升99级，不带参数固定升1级。 -力量999  加力量，敏捷智力雷同。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00单位技能物品(要先选择一个单位)：-技能Avul99 添加Avul中立无敌技能，并设置等级为99。如果等级填写为小于或是等于0则是删除该技能。-物品I000 添加I000物品。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@查技能/@查物品：查询技能或物品名称及ID,首次使用为初始化搜索。@物品I001，刷物品I001给你选择的单位，@可以为任意字符。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00单位其它功能(要先选择一个单位)：-控制  让你可以控制单位。 -改变  改变单位归属。 -恢复  恢复暂停的单位。|r")
endif
endfunction 
function BigMan_JumpLoop takes nothing returns nothing
local integer bmlocid=BigMan_GCODE(GetExpiredTimer())
local unit bmlochero=BigMan_Jump_Hero[bmlocid]
local integer bmlocpi=GetPlayerId(GetOwningPlayer(bmlochero))
local real bmlocangle=BigMan_Jump_Ang[bmlocid]
local integer bmlocsteeps=BigMan_Jump_Steeps[bmlocid]
local integer bmlocsteepsMax=BigMan_Jump_SteepsMax[bmlocid]
local real bmlocheightMax=BigMan_Jump_HeightMax[bmlocid]
local real bmlocdist=BigMan_Jump_Dist[bmlocid]
local real bmlocdheig=BigMan_Jump_Dheig[bmlocid]
local real bmlocOriginHeight=BigMan_Jump_OriginHeight[bmlocid]
local real bmlocx=BigMan_Jump_HeroX[bmlocid]
local real bmlocy=BigMan_Jump_HeroY[bmlocid]
local real bmlocx1=0
local real bmlocy1=0
local real bmlocheight=0
local real bmlocaeo=BigMan_Jump_DamAeo[bmlocpi]
local real bmlocdem=BigMan_Jump_Dam[bmlocpi]
local group bmlocg
local unit bmlocu
if bmlocsteeps < bmlocsteepsMax then
set bmlocx1=bmlocx + bmlocsteeps * bmlocdist * Cos(bmlocangle * 3.14159 / 180.0)
set bmlocy1=bmlocy + bmlocsteeps * bmlocdist * Sin(bmlocangle * 3.14159 / 180.0)
call SetUnitX(bmlochero, bmlocx1)
call SetUnitY(bmlochero, bmlocy1)
set bmlocsteeps=bmlocsteeps + 1
set BigMan_Jump_Steeps[bmlocid]=bmlocsteeps
set bmlocheight=( - ( 2 * I2R(bmlocsteeps) * bmlocdheig - 1 ) * ( 2 * I2R(bmlocsteeps) * bmlocdheig - 1 ) + 1 ) * bmlocheightMax + bmlocOriginHeight
call SetUnitFlyHeight(bmlochero, bmlocheight, 99999)
call SetUnitFacing(bmlochero, bmlocangle)
else
call SetUnitFlyHeight(bmlochero, bmlocOriginHeight, 99999)
call SetUnitPathing(bmlochero, true)
if bmlocdem==0 then
set bmlocdem=I2R(GetUnitLevel(bmlochero)*100)
endif
if bmlocaeo==0 then
set bmlocaeo=330
endif
set bmlocg=CreateGroup()
call GroupEnumUnitsInRange(bmlocg,GetUnitX(bmlochero),GetUnitY(bmlochero),bmlocaeo,null)
loop
set bmlocu = FirstOfGroup(bmlocg)
exitwhen bmlocu == null
call GroupRemoveUnit(bmlocg,bmlocu)
if IsUnitEnemy(bmlocu,GetOwningPlayer(bmlochero)) == true then
call UnitDamageTarget(bmlochero,bmlocu,bmlocdem, false, false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS )
endif
endloop
call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",GetUnitX(bmlochero),GetUnitY(bmlochero)) )
call SetUnitPosition(bmlochero,GetUnitX(bmlochero),GetUnitY(bmlochero))
set BigMan_Jump_Hero[bmlocid]=null
set BigMan_Jump_Run[bmlocpi]=true
call BigMan_DCODE(bmlocid)
endif
set bmlochero=null
set bmlocu=null
set bmlocg=null
endfunction
function BigMan_Jump takes unit bmlochero,real bmlocmx,real bmlocmy,real bmlocdistance returns nothing
local integer bmlocid=BigMan_CCODE()
local real bmlocx=GetUnitX(bmlochero)
local real bmlocy=GetUnitY(bmlochero)
local integer bmlocsteepsMax=R2I((bmlocdistance/BigMan_Jump_Speed[GetPlayerId(GetOwningPlayer(bmlochero))]) / .02)
local integer bmlocsteeps=0
local real bmlocdist=bmlocdistance / bmlocsteepsMax
local real bmlocdheig=1.0 / bmlocsteepsMax
call UnitAddAbility(bmlochero,'Amrf')
call UnitRemoveAbility(bmlochero,'Amrf')
call SetUnitPathing(bmlochero, false)
call SetUnitAnimation(bmlochero, "slam" )
set BigMan_Jump_Run[GetPlayerId(GetOwningPlayer(bmlochero))]=false
set BigMan_Jump_Hero[bmlocid]=bmlochero
set BigMan_Jump_OriginHeight[bmlocid]=GetUnitFlyHeight(bmlochero)
set BigMan_Jump_Ang[bmlocid]=Atan2(bmlocmy - bmlocy,bmlocmx - bmlocx) * (180.0/3.14159)
set BigMan_Jump_HeightMax[bmlocid]=bmlocdistance/2
set BigMan_Jump_Dist[bmlocid]=bmlocdist
set BigMan_Jump_Dheig[bmlocid]=bmlocdheig
set BigMan_Jump_HeroX[bmlocid]=bmlocx
set BigMan_Jump_HeroY[bmlocid]=bmlocy
set BigMan_Jump_Steeps[bmlocid]=bmlocsteeps
set BigMan_Jump_SteepsMax[bmlocid]=bmlocsteepsMax
call TimerStart(BigMan_T[bmlocid],.02, true, function BigMan_JumpLoop)
endfunction

function BigMan_SuperMove takes nothing returns nothing
local integer bmlocid=BigMan_GCODE(GetExpiredTimer())
local unit bmlocu=BigMan_H[bmlocid]
local integer bmlocpi=GetPlayerId(GetOwningPlayer(bmlocu))
local real bmlocx1=GetUnitX(BigMan_H[bmlocid])
local real bmlocy1=GetUnitY(BigMan_H[bmlocid])
local real bmlocx2=BigMan_X[bmlocid]
local real bmlocy2=BigMan_Y[bmlocid]
local real bmlocang=Atan2(BigMan_SuperMoveY[bmlocpi] - bmlocy1,BigMan_SuperMoveX[bmlocpi] - bmlocx1)
local real bmlocdis1=SquareRoot(( BigMan_SuperMoveX[bmlocpi] - bmlocx1 ) * ( BigMan_SuperMoveX[bmlocpi] - bmlocx1 ) + (BigMan_SuperMoveY[bmlocpi] - bmlocy1 ) * (BigMan_SuperMoveY[bmlocpi] - bmlocy1 ))
local real bmlocdis2=SquareRoot(( bmlocx2 - bmlocx1 ) * ( bmlocx2 - bmlocx1 ) + (bmlocy2 - bmlocy1 ) * ( bmlocy2 - bmlocy1 ))
if BigMan_SuperEff[bmlocpi]!="" then
call DestroyEffect( AddSpecialEffect(BigMan_SuperEff[bmlocpi],bmlocx2,bmlocy2))
endif
call SetUnitAnimation(bmlocu, "spin" )
if bmlocdis1<BigMan_SuperSpeed[bmlocpi] or bmlocdis2>BigMan_SuperSpeed[bmlocpi] then
call SetUnitX(bmlocu,BigMan_SuperMoveX[bmlocpi])
call SetUnitY(bmlocu,BigMan_SuperMoveY[bmlocpi])
if bmlocdis1<BigMan_SuperSpeed[bmlocpi] then
if BigMan_U[bmlocid]!=null then
call IssueTargetOrderById(bmlocu,851983,BigMan_U[bmlocid])
else
call IssueImmediateOrderById(bmlocu,851972)
endif
else
call IssueImmediateOrderById(bmlocu,851972)
endif
set BigMan_H[bmlocid]=null
set BigMan_U[bmlocid]=null
set BigMan_X[bmlocid]=0
set BigMan_Y[bmlocid]=0
set BigMan_SuperMoveX[bmlocpi]=0
set BigMan_SuperMoveY[bmlocpi]=0
set BigMan_Jump_Run[bmlocpi]=true
call SetUnitAnimation(bmlocu, "stand" )
call BigMan_DCODE(bmlocid)
else
call SetUnitX(bmlocu,bmlocx1 + BigMan_SuperSpeed[bmlocpi] * Cos(bmlocang))
call SetUnitY(bmlocu,bmlocy1 + BigMan_SuperSpeed[bmlocpi] * Sin(bmlocang))
set BigMan_X[bmlocid]= GetUnitX(bmlocu)
set BigMan_Y[bmlocid]= GetUnitY(bmlocu)
endif
call SetUnitFacing(bmlocu,bmlocang*(180.0/3.14159))
set bmlocu=null
endfunction

function BigMan_SuperMove_Unit takes nothing returns nothing
local integer bmlocid
local unit bmlocu= GetTriggerUnit()
local integer bmlocpi=GetPlayerId(GetOwningPlayer(bmlocu))
local real bmlocx= GetUnitX(bmlocu)
local real bmlocy= GetUnitY(bmlocu)
local real bmlocmx
local real bmlocmy 
local real bmlocdis
if GetUnitX(GetOrderTargetUnit())!=0 and GetUnitY(GetOrderTargetUnit())!=0 then
set bmlocmx=GetUnitX(GetOrderTargetUnit())
set bmlocmy=GetUnitY(GetOrderTargetUnit())
elseif GetItemX(GetOrderTargetItem())!=0 and GetItemY(GetOrderTargetItem())!=0 then
set bmlocmx=GetItemX(GetOrderTargetItem())
set bmlocmy=GetItemY(GetOrderTargetItem())
elseif GetDestructableX(GetOrderTargetDestructable())!=0 and GetDestructableY(GetOrderTargetDestructable())!=0 then
set bmlocmx=GetDestructableX(GetOrderTargetDestructable())
set bmlocmy=GetDestructableY(GetOrderTargetDestructable())
endif
set bmlocdis=SquareRoot((bmlocmx-bmlocx) * (bmlocmx-bmlocx) + (bmlocmy-bmlocy) * (bmlocmy-bmlocy))
if BigMan_TOF[bmlocpi] and GetIssuedOrderId()==851971 and BigMan_Jump_Run[bmlocpi] and BigMan_Jump_TOF[bmlocpi] and bmlocdis>BigMan_Jump_DisMin[bmlocpi] and bmlocdis<BigMan_Jump_DisMax[bmlocpi] then
set BigMan_Jump_Run[bmlocpi]=false
call BigMan_Jump(bmlocu,bmlocmx,bmlocmy,bmlocdis)
elseif BigMan_TOF[bmlocpi] and bmlocdis>=BigMan_SuperDis[bmlocpi] and GetIssuedOrderId()==851971 then
call SetUnitMoveSpeed(bmlocu,522)
if BigMan_SuperMoveX[bmlocpi]==0 and BigMan_SuperMoveY[bmlocpi]==0 then 
set bmlocid=BigMan_CCODE()
set BigMan_H[bmlocid]=bmlocu
set BigMan_X[bmlocid]= GetUnitX(bmlocu)
set BigMan_Y[bmlocid]= GetUnitY(bmlocu)
set BigMan_U[bmlocid]=GetOrderTargetUnit()
set BigMan_SuperMoveX[bmlocpi]=bmlocmx
set BigMan_SuperMoveY[bmlocpi]=bmlocmy
set BigMan_Jump_Run[bmlocpi]=false
call TimerStart(BigMan_T[bmlocid],0.02,true,function BigMan_SuperMove)
else
set BigMan_X[bmlocid]= GetUnitX(bmlocu)
set BigMan_Y[bmlocid]= GetUnitY(bmlocu)
set BigMan_SuperMoveX[bmlocpi]=bmlocmx
set BigMan_SuperMoveY[bmlocpi]=bmlocmy 
endif
endif
set bmlocu=null
endfunction
function BigMan_SuperMove_XY takes nothing returns nothing
local integer bmlocid
local unit bmlocu= GetTriggerUnit()
local integer bmlocpi=GetPlayerId(GetOwningPlayer(bmlocu))
local real bmlocdis=SquareRoot((GetOrderPointX()-GetUnitX(bmlocu)) * (GetOrderPointX()-GetUnitX(bmlocu)) + (GetOrderPointY()-GetUnitY(bmlocu)) * (GetOrderPointY()-GetUnitY(bmlocu)))
if BigMan_TOF[GetPlayerId(GetOwningPlayer(bmlocu))] and bmlocdis>=BigMan_SuperDis[bmlocpi] and GetIssuedOrderId()==851971 then
call SetUnitMoveSpeed(bmlocu,522)
call SetUnitTurnSpeed(bmlocu,3.)
if BigMan_SuperMoveX[bmlocpi]==0 and BigMan_SuperMoveY[bmlocpi]==0 then 
set bmlocid=BigMan_CCODE()
set BigMan_H[bmlocid]=bmlocu
set BigMan_X[bmlocid]= GetUnitX(bmlocu)
set BigMan_Y[bmlocid]= GetUnitY(bmlocu)
set BigMan_U[bmlocid]=null
set BigMan_Jump_Run[bmlocpi]=false
set BigMan_SuperMoveX[bmlocpi]=GetOrderPointX()
set BigMan_SuperMoveY[bmlocpi]=GetOrderPointY()
call TimerStart(BigMan_T[bmlocid],0.02,true,function BigMan_SuperMove)
else
set BigMan_SuperMoveX[bmlocpi]=GetOrderPointX()
set BigMan_SuperMoveY[bmlocpi]=GetOrderPointY()
endif
endif
set bmlocu=null
endfunction

function BigMan_Selection takes nothing returns nothing
set BigMan_HERO[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction

function InitTrig_BigMan takes nothing returns nothing
local trigger trgO = CreateTrigger()
local trigger trgS = CreateTrigger()
local trigger trgUM = CreateTrigger()
local trigger trgXY = CreateTrigger()
local trigger trig = CreateTrigger()
local integer bmlocc=0
set BigMan_AllString=".................................!.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
set BigMan_TOF[6666]=true
set BigMan_TOF[7777]=true
loop
exitwhen bmlocc>11
call TriggerRegisterPlayerUnitEvent(trig,Player(bmlocc),ConvertPlayerUnitEvent(24), null)
call TriggerRegisterPlayerChatEvent(trgO, Player(bmlocc), "", false )
call TriggerRegisterPlayerUnitEvent(trgS,Player(bmlocc),ConvertPlayerUnitEvent(274),null)
call TriggerRegisterPlayerUnitEvent(trgUM,Player(bmlocc),ConvertPlayerUnitEvent(40),null)
call TriggerRegisterPlayerUnitEvent(trgXY,Player(bmlocc),ConvertPlayerUnitEvent(39),null)
set BigMan_SuperMoveX[bmlocc]=0
set BigMan_SuperMoveY[bmlocc]=0
set BigMan_SuperSpeed[bmlocc]=50
set BigMan_SuperDis[bmlocc]=600
set BigMan_SuperEff[bmlocc]="Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl"
set BigMan_Jump_TOF[bmlocc] = false
set BigMan_Jump_DisMin[bmlocc]=100
set BigMan_Jump_DisMax[bmlocc]=1000
set BigMan_Jump_DamAeo[bmlocc]=550
set BigMan_Jump_Speed[bmlocc]=1000
set BigMan_Jump_Run[bmlocc]=true
set BigMan_BagTrigger[bmlocc]=null
call TriggerRegisterPlayerUnitEvent(trgS,Player(bmlocc),ConvertPlayerUnitEvent(26),null)
call TriggerRegisterPlayerUnitEvent(trgS,Player(bmlocc),ConvertPlayerUnitEvent(32),null)
call TriggerRegisterPlayerUnitEvent(trgS,Player(bmlocc),ConvertPlayerUnitEvent(35),null)
set bmlocc=bmlocc+1
endloop
call TriggerAddAction(trig,function BigMan_Selection)
call TriggerAddAction(trgO,function BigMan__ONOFF)
call TriggerAddAction(trgS,function BigMan__A)
call TriggerAddAction(trgUM,function BigMan_SuperMove_Unit)
call TriggerAddAction(trgXY,function BigMan_SuperMove_XY)
set BigMan_Str[8100]= "|cFFFF0c0c"
set BigMan_Str[8101]= "|cFF0c0cFF"
set BigMan_Str[8102]= "|cFF400000"
set BigMan_Str[8103]= "|cFF0EEEEE"
set BigMan_Str[8104]= "|cFF0EEE00"
set BigMan_Str[8105]= "|cFF7DDDFF"
set BigMan_Str[8106]= "|cFF888888"
set BigMan_Str[8107]= "|cFFF77700"
set BigMan_Str[8108]= "|cFFF222FF"
set BigMan_Str[8109]= "|cFF700077"
set BigMan_Str[8110]= "|cFF077766"
set BigMan_Str[8111]= "|cFFFFFF00"
set trgO=null
set trgS=null
set trgUM=null
set trgXY=null
set trig=null
endfunction