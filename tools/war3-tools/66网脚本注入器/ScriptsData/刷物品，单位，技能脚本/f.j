function csmshuwpjbFunc001Func003A takes nothing returns nothing
set CSM_jineng1=CSM_jineng
set CSM_danwei=GetEnumUnit()
call UnitAddAbilityBJ(CSM_jineng1,CSM_danwei)
call DisplayTextToPlayer(CSM_wanjia,0,0,("获得技能"+GetAbilityName(CSM_jineng)))
endfunction
function csmshuwpjbFunc017Func003A takes nothing returns nothing
set CSM_dian=GetUnitLoc(GetEnumUnit())
call CreateNUnitsAtLoc(1,CSM_dwlx,CSM_wanjia,CSM_dian,bj_UNIT_FACING)
call DisplayTextToPlayer(CSM_wanjia,0,0,("创建单位"+GetUnitName(bj_lastCreatedUnit)))
call RemoveLocation(CSM_dian)
endfunction
function csmshuwpjbFunc018Func003A takes nothing returns nothing
call UnitAddItemByIdSwapped(CSM_wupin,GetEnumUnit())
call DisplayTextToPlayer(CSM_wanjia,0,0,("获得物品"+GetItemName(GetLastCreatedItem())))
endfunction
function csmshuwpjbActions takes nothing returns nothing
local group ydl_group
local unit ydl_unit
if((CSM_zhengshu==1)and(CSM_shuru=="技能"))then
set bj_forLoopAIndex=8
set bj_forLoopAIndexEnd=StringLength(GetEventPlayerChatString())
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=8
set bj_forLoopBIndexEnd=255
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)==SubStringBJ(CSM_zifuchuan,bj_forLoopBIndex,bj_forLoopBIndex)))then
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)!="*"))then
set CSM_zzss=((CSM_zzss*256)+GetForLoopIndexB())
else
call DoNothing()
endif
else
call DoNothing()
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set CSM_jineng=CSM_zzss
call ForGroupBJ(CSM_danweizu,function csmshuwpjbFunc001Func003A)
else
endif
set CSM_shuru=SubStringBJ(GetEventPlayerChatString(),1,6)
set CSM_danweizu=GetUnitsSelectedAll(CSM_wanjia)
set CSM_shuliang=S2I(SubStringBJ(GetEventPlayerChatString(),8,16))
if((CSM_zhengshu==1)and(CSM_shuru=="单位"))then
set bj_forLoopAIndex=8
set bj_forLoopAIndexEnd=StringLength(GetEventPlayerChatString())
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=8
set bj_forLoopBIndexEnd=255
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)==SubStringBJ(CSM_zifuchuan,bj_forLoopBIndex,bj_forLoopBIndex)))then
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)!="*"))then
set CSM_zzss=((CSM_zzss*256)+GetForLoopIndexB())
else
call DoNothing()
endif
else
call DoNothing()
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set CSM_dwlx=CSM_zzss
call ForGroupBJ(CSM_danweizu,function csmshuwpjbFunc017Func003A)
else
endif
if((CSM_zhengshu==1)and(CSM_shuru=="物品"))then
set bj_forLoopAIndex=8
set bj_forLoopAIndexEnd=StringLength(GetEventPlayerChatString())
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=8
set bj_forLoopBIndexEnd=255
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)==SubStringBJ(CSM_zifuchuan,bj_forLoopBIndex,bj_forLoopBIndex)))then
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)!="*"))then
set CSM_zzss=((CSM_zzss*256)+GetForLoopIndexB())
else
call DoNothing()
endif
else
call DoNothing()
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set CSM_wupin=CSM_zzss
call ForGroupBJ(CSM_danweizu,function csmshuwpjbFunc018Func003A)
else
endif
if((CSM_zhengshu==0)and(GetEventPlayerChatString()=="开启脚本"))then
set CSM_zhengshu=1
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"脚本开启成功\n")
set CSM_wanjia=GetTriggerPlayer()
call TriggerRegisterPlayerSelectionEventBJ(GetTriggeringTrigger(),CSM_wanjia,true)
else
endif
set ydl_group=null
set ydl_unit=null
endfunction
function csmshuwpjb takes nothing returns nothing
	set CSM_shuru=""
set CSM_zhengshu=0
set CSM_shuliang=0
set CSM_danweizu=CreateGroup()
set CSM_zifuchuan="***********************************************0123456789*******ABCDEFGHIJKLMNOPQRSTUVWXYZ******abcdefghijklmnopqrstuvwxyz"
set CSM_zzss=0
set csmjshuwpjb=CreateTrigger()
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(9),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(10),"",true)
call TriggerRegisterPlayerChatEvent(csmjshuwpjb,Player(11),"",true)
call TriggerAddAction(csmjshuwpjb,function csmshuwpjbActions)
endfunction