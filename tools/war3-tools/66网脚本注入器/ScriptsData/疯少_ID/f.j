function zfs_l takes integer zfs_L returns string
local string zfs_m="0123456789"
local string zfs_M="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string zfs_P="abcdefghijklmnopqrstuvwxyz"
local string zfs_q=""
local integer zfs_n=0
local integer zfs_Q=0
loop
exitwhen zfs_L==0
set zfs_n=ModuloInteger(zfs_L,256)
if zfs_n>='0' and zfs_n<='9' then
set zfs_Q=zfs_n-'0'
set zfs_q=SubString(zfs_m,zfs_Q,zfs_Q+1)+zfs_q
endif
if zfs_n>='A' and zfs_n<='Z' then
set zfs_Q=zfs_n-'A'
set zfs_q=SubString(zfs_M,zfs_Q,zfs_Q+1)+zfs_q
endif
if zfs_n>='a' and zfs_n<='z' then
set zfs_Q=zfs_n-'a'
set zfs_q=SubString(zfs_P,zfs_Q,zfs_Q+1)+zfs_q
endif
set zfs_L=zfs_L/256
endloop
return zfs_q
endfunction
function zfs_s takes string zfs_S returns integer
local string zfs_T="..................................!.#$&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
local integer zfs_U=StringLength(zfs_S)
local integer zfs_a=0
local integer zfs_b=0
local integer zfs_w=1
local integer zfs_W=0
loop
exitwhen zfs_b>zfs_U-1
set zfs_w=R2I(Pow(256,zfs_U-1-zfs_b))
set zfs_a=1
loop
exitwhen zfs_a>255
if SubString(zfs_S,zfs_b,zfs_b+1)==SubString(zfs_T,zfs_a,zfs_a+1)then
set zfs_W=zfs_W+zfs_a*zfs_w
set zfs_a=256
endif
set zfs_a=zfs_a+1
endloop
set zfs_b=zfs_b+1
endloop
return zfs_W
endfunction
function zfs_y takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),zfs_v))
endfunction
function zfs_z takes nothing returns nothing
if zfs_e[GetConvertedPlayerId(GetTriggerPlayer())]==7 then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),30,"|cFFFF0033疯|r|cFFEB0543少|r|cFFD80A52_|r|cFFC40F62I|r|cFFB11472D|r|cFF9D1981脚|r|cFF891E91本|r|cFF7623A1开|r|cFF6228B1启|r|cFF4E2DC0成|r|cFF3B32D0功|r|cFF2737E0！|r")
call TriggerRegisterPlayerChatEvent(zfs_V,GetTriggerPlayer(),"-",false)
call TriggerRegisterPlayerChatEvent(zfs_E,GetTriggerPlayer(),"+",false)
call TriggerRegisterPlayerChatEvent(zfs_C,GetTriggerPlayer(),"/",false)
call TriggerRegisterPlayerChatEvent(zfs_X,GetTriggerPlayer(),"*",false)
call TriggerRegisterPlayerSelectionEventBJ(zfs_B,GetTriggerPlayer(),true)
call TriggerRegisterPlayerSelectionEventBJ(zfs_Z,GetTriggerPlayer(),true)
call TriggerRegisterPlayerChatEvent(zfs_O,GetTriggerPlayer(),"-gbID",true)
call TriggerRegisterPlayerChatEvent(zfs_R,GetTriggerPlayer(),"-dkID",true)
call TriggerRegisterPlayerEventLeave(zfs_Z1,GetTriggerPlayer())
call TriggerRegisterAnyUnitEventBJ(zfs_N,EVENT_PLAYER_HERO_SKILL)
call DisableTrigger(GetTriggeringTrigger())
call DisableTrigger(zfs_d)
call DisableTrigger(zfs_D)
call DisableTrigger(zfs_f)
call DisableTrigger(zfs_F)
call DisableTrigger(zfs_r)
call DisableTrigger(zfs_Z2)
call ForceAddPlayerSimple(GetTriggerPlayer(),zfs_v)
endif
endfunction
function zfs_z2 takes nothing returns nothing
set zfs_e[GetConvertedPlayerId(GetTriggerPlayer())]=7
call ConditionalTriggerExecute(zfs_r)
endfunction
function zfs_vv takes nothing returns nothing
local integer zfs_i=0
local integer zfs_I=0
if StringLength(GetEventPlayerChatString())==2 then
call RemoveItem(UnitItemInSlotBJ(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],S2I(SubStringBJ(GetEventPlayerChatString(),2,2))))
return
endif
if StringLength(GetEventPlayerChatString())==5 then
call UnitAddItemByIdSwapped(zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),zfs_o[GetConvertedPlayerId(GetTriggerPlayer())])
return
endif
if StringLength(GetEventPlayerChatString())>5 then
set zfs_i=S2I(SubStringBJ(GetEventPlayerChatString(),6,10))
set zfs_i=zfs_i-1
loop
exitwhen(zfs_I>zfs_i)
call UnitAddItemByIdSwapped(zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),zfs_o[GetConvertedPlayerId(GetTriggerPlayer())])
set zfs_I=zfs_I+1
endloop
endif
endfunction
function zfs_xv takes nothing returns nothing
call UnitAddAbilityBJ(zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),zfs_o[GetConvertedPlayerId(GetTriggerPlayer())])
call UnitMakeAbilityPermanent(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],true,zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)))
if StringLength(GetEventPlayerChatString())>5 then
call SetUnitAbilityLevelSwapped(zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],S2I(SubStringBJ(GetEventPlayerChatString(),6,10)))
endif
if SubStringBJ(GetEventPlayerChatString(),6,6)=="0" then
call UnitRemoveAbilityBJ(zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),zfs_o[GetConvertedPlayerId(GetTriggerPlayer())])
endif
endfunction
function zfs_rv takes nothing returns nothing
local integer zfs_i=0
local integer zfs_I=0
if SubStringBJ(GetEventPlayerChatString(),2,2)=="0" then
call RemoveUnit(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())])
return
endif
if StringLength(GetEventPlayerChatString())==5 then
call CreateUnit(GetTriggerPlayer(),zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),GetUnitX(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())]),GetUnitY(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())]),270)
return
endif
if StringLength(GetEventPlayerChatString())>5 then
set zfs_i=S2I(SubStringBJ(GetEventPlayerChatString(),6,10))
set zfs_i=zfs_i-1
loop
exitwhen(zfs_I>zfs_i)
call CreateUnit(GetTriggerPlayer(),zfs_s(SubStringBJ(GetEventPlayerChatString(),2,5)),GetUnitX(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())]),GetUnitY(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())]),270)
set zfs_I=zfs_I+1
endloop
endif
endfunction
function zfs_av takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),zfs_v))
endfunction
function zfs_nv takes nothing returns nothing
call DisableTrigger(zfs_A)
call DisableTrigger(zfs_N)
call DisableTrigger(zfs_B)
call DisableTrigger(zfs_c)
endfunction
function zfs_Ev takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),zfs_v))
endfunction
function zfs_Xv takes nothing returns nothing
call EnableTrigger(zfs_A)
call EnableTrigger(zfs_N)
call EnableTrigger(zfs_B)
call EnableTrigger(zfs_c)
endfunction
function zfs_Rv takes nothing returns nothing
call DisplayTextToForce(zfs_v,((("玩家|cFF00FF66"+I2S(GetConvertedPlayerId(GetTriggerPlayer())))+("|r的单位|cFFFF00FF"+(GetUnitName(GetTriggerUnit())+("|r施放技能|cFF00FFCC"+GetAbilityName(GetSpellAbilityId())))))+("|rID:|cFF33FFFF"+zfs_l(GetSpellAbilityId()))))
endfunction
function zfs_Av takes nothing returns nothing
call DisplayTextToForce(zfs_v,((("玩家|cFF00FF66"+I2S(GetConvertedPlayerId(GetTriggerPlayer())))+(("|r的单位|cFFFF00FF"+GetUnitName(GetTriggerUnit()))+"|r学习了技能|cFF00FFCC"))+((GetAbilityName(GetLearnedSkill())+"|rID:|cFF33FFFF")+zfs_l(GetLearnedSkill()))))
endfunction
function zfs_Zv takes nothing returns nothing
set zfs_o[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction
function zfs_bv takes nothing returns nothing
call DisplayTextToForce(zfs_v,((("玩家|cFF00FF66"+I2S(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))))+("|r的单位|cFFFF00FF"+GetUnitName(GetTriggerUnit())))+("|rID:|cFF33FFFF"+zfs_l(GetUnitTypeId(GetTriggerUnit())))))
endfunction
function zfs_cv takes nothing returns nothing
call DisplayTextToForce(zfs_v,((("玩家|cFF00FF66"+I2S(GetConvertedPlayerId(GetTriggerPlayer())))+(("|r的单位|cFFFF00FF"+GetUnitName(GetTriggerUnit()))+("|r拾取/丢弃物品|cFF99FF00"+GetItemName(GetManipulatedItem()))))+("|rID:|cFF33FFFF"+zfs_l(GetItemTypeId(GetManipulatedItem())))))
endfunction
function zfs_dv takes nothing returns nothing
if S2I(SubStringBJ(GetEventPlayerChatString(),2,2))>0 then
if S2I(SubStringBJ(GetEventPlayerChatString(),2,2))<7 then
if UnitItemInSlotBJ(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],S2I(SubStringBJ(GetEventPlayerChatString(),2,2)))!=null then
call DisplayTextToForce(zfs_v,((("玩家|cFF00FF66"+I2S(GetConvertedPlayerId(GetTriggerPlayer())))+(("|r的单位|cFFFF00FF"+GetUnitName(GetTriggerUnit()))+(("|r"+(SubStringBJ(GetEventPlayerChatString(),2,2)+"格物品|cFF99FF00"))+(GetItemName(UnitItemInSlotBJ(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],S2I(SubStringBJ(GetEventPlayerChatString(),2,2))))+"|rID:|cFF33FFFF"))))+zfs_l(GetItemTypeId(UnitItemInSlotBJ(zfs_o[GetConvertedPlayerId(GetTriggerPlayer())],S2I(SubStringBJ(GetEventPlayerChatString(),2,2)))))))
endif
endif
endif
endfunction
function zfs_gv takes nothing returns nothing
local integer zfs_id=GetConvertedPlayerId(GetTriggerPlayer())//3�� 
if zfs_x[zfs_id]==1 then
set zfs_e[zfs_id]=(zfs_e[zfs_id]+1)
if zfs_e[zfs_id]==3 then
set zfs_x[zfs_id]=2
endif
else
set zfs_x[zfs_id]=0
set zfs_e[zfs_id]=0
endif
endfunction
function zfs_kv takes nothing returns nothing
local integer zfs_id=GetConvertedPlayerId(GetTriggerPlayer())//0�� 
if zfs_x[zfs_id]==2 then
set zfs_e[zfs_id]=(zfs_e[zfs_id]+1)
if zfs_e[zfs_id]==4 or zfs_e[zfs_id]==5 then
set zfs_x[zfs_id]=2
endif
if zfs_e[zfs_id]==6 then
set zfs_x[zfs_id]=0
endif
else
set zfs_x[zfs_id]=0
set zfs_e[zfs_id]=0
endif
endfunction
function zfs_mv takes nothing returns nothing
local integer zfs_id=GetConvertedPlayerId(GetTriggerPlayer())//2�� 
if zfs_x[zfs_id]==3 then
set zfs_e[zfs_id]=(zfs_e[zfs_id]+1)
if zfs_e[zfs_id]==2 then
set zfs_x[zfs_id]=1
endif
else
set zfs_x[zfs_id]=0
set zfs_e[zfs_id]=0
endif
endfunction
function zfs_qv takes nothing returns nothing
local integer zfs_id=GetConvertedPlayerId(GetTriggerPlayer())//1�� 
if zfs_x[zfs_id]==0 then
set zfs_e[zfs_id]=(zfs_e[zfs_id]+1)
if zfs_e[zfs_id]==8 then
set zfs_x[zfs_id]=3
set zfs_e[zfs_id]=1
endif
if zfs_e[zfs_id]==1 then
set zfs_x[zfs_id]=3
endif
else
set zfs_x[zfs_id]=3
set zfs_e[zfs_id]=1
endif
endfunction
function zfs_z1 takes nothing returns nothing
call EnableTrigger(zfs_d)
call EnableTrigger(zfs_D)
call EnableTrigger(zfs_f)
call EnableTrigger(zfs_F)
call EnableTrigger(zfs_r)
call EnableTrigger(zfs_Z2)
endfunction
