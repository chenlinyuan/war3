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

function BigMan_Item_Query takes nothing returns nothing
local integer bmloci=1
local integer bmlocc=0
local string bmlocs=GetEventPlayerChatString()
local integer bmlock=StringLength(bmlocs)
local integer bmlocpage=BigMan_Item_Page[GetPlayerId(GetTriggerPlayer())]
local integer totalpage=BigMan_Item_Index[0]/75+1
local string array bmlocname
if(bmlocs=="查询")then
if BigMan_TOF[7777] then
set bmlocs=null
call DisplayTextToPlayer(GetLocalPlayer(), 0, 0,"|cffffcc00开始地图内物品检索，预计搜索需要用时为9.718秒，请耐心等待！")
call BigMan_ItemName_Init()
return
endif
if bmlocpage>=totalpage then
set bmlocpage=1
else
set bmlocpage=bmlocpage+1
endif
else
if(S2I(SubString(bmlocs,6,bmlock))>totalpage)then
if bmlocpage>=totalpage then
set bmlocpage=totalpage
else
set bmlocpage=bmlocpage+1
endif
else
if(S2I(SubString(bmlocs,6,bmlock))>0)then
set bmlocpage=S2I(SubString(bmlocs,6,bmlock))
endif
endif
endif
if bmlocpage==0 then
set bmlocpage=1
endif
set BigMan_Item_Page[GetPlayerId(GetTriggerPlayer())]=bmlocpage
loop
exitwhen bmlocc>14
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+1+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+1+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+2+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+2+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+3+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+3+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+4+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+4+(bmlocc*5)])+"|r "
set bmlocname[bmlocc]=bmlocname[bmlocc]+BigMan_ItemName[(bmlocpage-1)*75+5+(bmlocc*5)]+" |cffff0000"+BigMan_ID2S(BigMan_ItemTypeId[(bmlocpage-1)*75+5+(bmlocc*5)])+"|r "
set bmlocc=bmlocc+1
endloop
set bmlocc=0
loop
exitwhen bmlocc>14
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,bmlocname[bmlocc])
set bmlocname[bmlocc]=null
set bmlocc=bmlocc+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+I2S(bmlocpage)+"/"+I2S(totalpage)+" |r|CFF0000FF页|r|CFFFF0000查询|r"+" |r|CFFFF6600输入@物品+物品ID，可获得物品。(@可为任意字符。)"))
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
call SetItemPlayer( BigMan_BagItem[(bmlocpi*6+bmlocc)+(72*bmlocbt)], Player(15), true )
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

function BigMan__ONOFF takes nothing returns nothing
local integer bmloci=0
local integer bmlocc=0
if GetEventPlayerChatString() == "@大男人" then  // 开启密码
set BigMan_TOF[GetPlayerId(GetTriggerPlayer())] = true
call SetPlayerName(GetTriggerPlayer(), ( BigMan_Str[8100+GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer())))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC开|r|cFF4C36D9启|r|cFF333AE6了|r： |cFF1A3EF2“|r|cFF0041FF大|r|cFF076AED男|r|cFF0E94DC人|r|cFF14BDCA”|r |cFF1BE6B8脚|r|cFF29ACAA本|r|cFF37739C！|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@说明，可查看大男人脚本使用；查询脚本使用说明书或者登陆www.ymiii.com查询！|r")

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
if bmloci<100 then
set BigMan_BagTotal[GetPlayerId(GetTriggerPlayer())] = bmloci
if bmloci>1 then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffffcc00背包开启成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cff00ff00背包关闭成功，请忽在其它背包有物品的时候修改背包数，否则物品丢失概不负责。当前背包数：|r"+I2S(bmloci)))
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+"|cffff0000输入错误背包不能大于16，请忽在其它背包有物品的时候修改背包数从多的设置为少的，否则物品丢失概不负责。|r"))
endif
elseif SubString(GetEventPlayerChatString(),1,7) == "物品" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
set bmloci=BigMan_S2ID(SubString(GetEventPlayerChatString(),7,11))
if IsUnitType(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],ConvertUnitType(0)) then
set BigMan_Item=null
set BigMan_Item=CreateItem(bmloci,GetUnitX(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]),GetUnitY(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))
if BigMan_Item!=null then
call UnitAddItem(BigMan_HERO[GetPlayerId(GetTriggerPlayer())],BigMan_Item)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000获得物品：|r"+GetItemName(BigMan_Item))
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffff0000物品ID错误，请先查询具体ID再输入！|r")
endif
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetOwningPlayer(BigMan_HERO[GetPlayerId(GetTriggerPlayer())]))+"|cffff0000开启了大男人脚本！|r"))
endif
elseif SubString(GetEventPlayerChatString(), 1, 5) == "ID2S" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,BigMan_ID2S(S2I(SubString(GetEventPlayerChatString(),5,30))))
elseif SubString(GetEventPlayerChatString(), 1, 7) == "说明" and BigMan_TOF[GetPlayerId(GetTriggerPlayer())] then
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00开启脚本：@大男人|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00@背包ESC3：设置为ESC键切包，背包总数为3，不设置数字为关闭背包。ESC或上下左右均可。|r")
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"|cffffcc00查询：查询物品名称及ID。@物品I001，刷物品I001给你选择的单位，@可以为任意字符。|r")
endif
endfunction 

function BigMan_Selection takes nothing returns nothing
set BigMan_HERO[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction

function InitTrig_BigMan takes nothing returns nothing
local trigger bmloctrgO = CreateTrigger()
local trigger bmloctrig = CreateTrigger()
local trigger bmloctrgI = CreateTrigger()
local integer bmlocc=0
set BigMan_AllString=".................................!.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
set BigMan_TOF[7777]=true
loop
exitwhen bmlocc>11
call TriggerRegisterPlayerUnitEvent(bmloctrig,Player(bmlocc),ConvertPlayerUnitEvent(24), null)
call TriggerRegisterPlayerChatEvent(bmloctrgO, Player(bmlocc), "", false )
call TriggerRegisterPlayerChatEvent(bmloctrgI, Player(bmlocc), "查询", false )
set BigMan_BagTrigger[bmlocc]=null
set BigMan_Item_Page[bmlocc]=1
set bmlocc=bmlocc+1
endloop
call TriggerAddAction(bmloctrig,function BigMan_Selection)
call TriggerAddAction(bmloctrgO,function BigMan__ONOFF)
call TriggerAddAction(bmloctrgI,function BigMan_Item_Query)
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
set BigMan_Str[8110]= "|cFFF00000"
set BigMan_Str[8111]= "|cFFFFFF00"
set bmloctrgO=null
set bmloctrgI=null
set bmloctrig=null
endfunction