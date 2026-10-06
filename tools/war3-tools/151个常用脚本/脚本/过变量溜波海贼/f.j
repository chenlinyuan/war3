function Trig_wo_kuang_Actions takes nothing returns nothing
call DialogClear(udg_wodk[1])
call DialogAddButtonWithHotkeyBJ(udg_wodk[1],"路飞的橡胶之魂      力量型",'A')
set udg_wodkan[1]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_wodk[1],"索隆的剑豪之魂     敏捷型",'B')
set udg_wodkan[2]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_wodk[1],"sanji'智囊之魂     智力型",'C')
set udg_wodkan[3]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_wodk[1],"我很强大，不用魂魄的力量！",'D')
set udg_wodkan[4]=bj_lastCreatedButton
call DialogSetMessage(udg_wodk[1],"溜波技能")
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DialogDisplay(Player(-1+(bj_forLoopAIndex)),udg_wodk[1],true)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_wo_xuankuang_Actions takes nothing returns nothing
if GetClickedButton()==udg_wodkan[1] then
set udg_wobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]+1)
call TriggerExecute(gg_trg_wo_jiazhuangtai)
endif
if GetClickedButton()==udg_wodkan[2] then
set udg_wobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]+2)
call TriggerExecute(gg_trg_wo_jiazhuangtai)
endif
if GetClickedButton()==udg_wodkan[3] then
set udg_wobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]+3)
call TriggerExecute(gg_trg_wo_jiazhuangtai)
endif
endfunction
function liubo1 takes nothing returns boolean
return IsUnitAlly(GetFilterUnit(),Player(0))==false and  IsUnitAliveBJ(GetFilterUnit())
endfunction
function liubo2 takes nothing returns nothing
call UnitDamageTarget(udg_wodw[2],GetEnumUnit(),udg_woss[3],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function liubo3 takes nothing returns nothing
call UnitDamageTarget(udg_wodw[2],GetEnumUnit(),udg_woss[5],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function liubo4 takes nothing returns nothing
call UnitDamageTarget(udg_wodw[2],GetEnumUnit(),udg_woss[7],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function Trig_wo_gongji_Actions takes nothing returns nothing
local unit u=GetAttacker()
local unit uu=GetTriggerUnit()
local real l=I2R(GetHeroStr(u,true))
local real m=I2R(GetHeroStr(u,true))
local real z=I2R(GetHeroInt(u,true))
local real sj=GetRandomReal(.0,100.)
local real lj=I2R(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(u)))])
local real mj=I2R(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(u)))])
local real zj=I2R(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(u)))])
local real j=SquareRoot(I2R(GetHeroLevel(u)))
local real a=SquareRoot(l+m+z)/j
local integer wlj=udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]
local integer wlm=udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]
local integer wlz=udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]
local integer q=udg_wowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]
if udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]and IsUnitAlly(GetTriggerUnit(),Player(0))==false and IsUnitType(GetAttacker(),UNIT_TYPE_HERO) then
set udg_wodw[2]=u
set udg_wodw[3]=uu
set udg_wosjs[(1+GetPlayerId(GetOwningPlayer(u)))]=GetHeroLevel(u)
if GetRandomInt(1,(73+(2*wlj)))>=70 and q==1 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==1 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsl[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsl[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsl[(1+GetPlayerId(GetOwningPlayer(u)))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("路飞的橡胶之魂修为升级为："+I2S(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[3]=a*l*lj*lj
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(uu),400.,400.)),Condition(function liubo1)),function liubo2)
else
if GetRandomInt(1,(73+((3/ 2)*wlj)))>=70 and q==1 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==1 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsl[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsl[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsl[(1+GetPlayerId(GetOwningPlayer(u)))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("路飞的橡胶之魂修为升级为："+I2S(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[4]=a*3*l*lj*(lj+5)
call UnitDamageTarget(u,uu,udg_woss[4],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",uu,"Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
if GetRandomInt(1,(73+(2*wlm)))>=70 and q==2 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==2 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsm[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsm[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsm[(1+GetPlayerId(GetOwningPlayer(u)))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("索隆的剑豪之魂修为升级为："+I2S(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[5]=a*mj*mj*m
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(uu),400.,400.)),Condition(function liubo1)),function liubo3)
else
if GetRandomInt(1,(73+((3/ 2)*wlm)))>=70 and q==2 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==2 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsm[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsm[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsm[(1+GetPlayerId(GetOwningPlayer(u)))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("索隆的剑豪之魂修为升级为："+I2S(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[6]=a*3*m*mj*(mj+5)
call UnitDamageTarget(u,uu,udg_woss[6],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",uu,"Abilities\\Spells\\Other\\Drain\\ManaDrainCaster.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
if GetRandomInt(1,(73+(2*wlz)))>=70 and q==3 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==3 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsz[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("sanji'智囊之魂修为升级为："+I2S(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[7]=a*2*zj*zj*z
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(uu),400.,400.)),Condition(function liubo1)),function liubo4)
else
if GetRandomInt(1,(73+((3/ 2)*wlz)))>=70 and q==3 then
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]+10)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]==3 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))]>=udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[2])))] then
set udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(u)))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(u)))]=0
set udg_wojsz[(1+GetPlayerId(GetOwningPlayer(u)))]=(udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(u))+("sanji'智囊之魂修为升级为："+I2S(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
set udg_woss[8]=a*6*z*zj*(zj+5)
call UnitDamageTarget(u,uu,udg_woss[8],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",uu,"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
endif
if udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))] and IsUnitAlly(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))==false and IsUnitType(GetAttacker(),UNIT_TYPE_HERO) then
set udg_wosjs[27]=GetHeroLevel(GetAttacker())
if GetRandomInt(1,50)==1 then
call SetHeroLevelBJ(GetAttacker(),(udg_wosjs[27]+1),false)
call CreateTextTagUnitBJ("等级提升",GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
set udg_wosjs[26]=(3*(R2I(SquareRoot(I2R(udg_wosjs[22])))*R2I(SquareRoot(I2R(GetHeroLevel(GetAttacker()))))))
if q==1 and GetRandomInt(1,50)==1 then
call ModifyHeroStat(0,GetAttacker(),0,udg_wosjs[26])
call CreateTextTagUnitBJ(("+力量"+I2S(udg_wosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if q==2 and GetRandomInt(1,50)==1 then
call ModifyHeroStat(1,GetAttacker(),0,udg_wosjs[26])
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_wosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if q==3 and GetRandomInt(1,50)==1 then
call ModifyHeroStat(2,GetAttacker(),0,udg_wosjs[26])
call CreateTextTagUnitBJ(("+智力"+I2S(udg_wosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
endif
set u=null
set uu=null
endfunction
function Trig_wo_xinxi_Actions takes nothing returns nothing
if  udg_wosjs[21]==0 and GetEventPlayerChatString()=="溜波" then
set udg_wosjs[21]=(udg_wosjs[21]+1)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"欢迎使用溜波技能，此技能威力和属性有关，魂魄修为对技能的威力影响很大。可以通过输入“查询”查询武器的详细情况。")
set udg_wosjs[23]=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
set udg_wosjs[22]=((GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)+(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)+GetHeroStatBJ(2,FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)))/ 3)
call ConditionalTriggerExecute(gg_trg_wo_kuang)
endif
endfunction
function Trig_wo_zhouqi_Actions takes nothing returns nothing
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"欢迎使用溜波技能，开启方法为任意玩家输入“溜波”即可。此技能威力和属性有关，魂魄修为对技能的威力影响很大。可以通过输入“查询”查询武器的详细情况。")
endfunction
function Trig_wo_chushi_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_wowuqijil[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_wowuqijim[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_wowuqijiz[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_wojsl[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set udg_wojsm[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set udg_wojsz[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_wo_jiazhuangtai_Func001Func001001002 takes nothing returns boolean
return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null and udg_wobe[(1+GetPlayerId(GetFilterPlayer()))]
endfunction
function Trig_wo_jiazhuangtai_Func001Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),552.)
endfunction
function Trig_wo_jiazhuangtai_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRectMatching(GetWorldBounds(),Condition(function Trig_wo_jiazhuangtai_Func001Func001001002)),function Trig_wo_jiazhuangtai_Func001Func001A)
endfunction
function Trig_wo_siwang_Actions takes nothing returns nothing
if IsUnitAlly(GetDyingUnit(),GetOwningPlayer(GetKillingUnit()))==false and udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))] and IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO) then
set udg_wodw[1]=GetKillingUnit()
set udg_wosjs[1]=GetRandomInt(1,15)
set udg_wosjs[3]=GetRandomInt(1,R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit())))))
set udg_wosjs[2]=(R2I(SquareRoot(I2R(udg_wosjs[22])))*udg_wosjs[3])
set udg_wosjs[4]=(udg_wosjs[23]*udg_wosjs[3])
set udg_wosjs[5]=(udg_wosjs[3]*3)
if GetRandomInt(1,20)==1 and GetHeroLevel(udg_wodw[1])>500 and udg_wosjs[23]>0 then
call AdjustPlayerStateBJ(udg_wosjs[5],GetOwningPlayer(udg_wodw[1]),PLAYER_STATE_RESOURCE_LUMBER)
call CreateTextTagUnitBJ(("+木"+I2S(udg_wosjs[5])),udg_wodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if GetRandomInt(1,20)==1 and GetHeroLevel(udg_wodw[1])<=500 and udg_wosjs[23]>0 then
call AdjustPlayerStateBJ(udg_wosjs[4],GetOwningPlayer(udg_wodw[1]),PLAYER_STATE_RESOURCE_GOLD)
call CreateTextTagUnitBJ(("+钱"+I2S(udg_wosjs[4])),udg_wodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if GetRandomInt(1,50)==1 then
call ModifyHeroStat(2,udg_wodw[1],0,udg_wosjs[2])
call CreateTextTagUnitBJ(("+智力"+I2S(udg_wosjs[2])),udg_wodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if GetRandomInt(1,50)==1 then
call ModifyHeroStat(1,udg_wodw[1],0,udg_wosjs[2])
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_wosjs[2])),udg_wodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if GetRandomInt(1,50)==1 then
call ModifyHeroStat(0,udg_wodw[1],0,udg_wosjs[2])
call CreateTextTagUnitBJ(("+力量"+I2S(udg_wosjs[2])),udg_wodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
endif
if udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))] and IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO) then
call ModifyHeroStat(0,GetDyingUnit(),0,udg_wosjs[22])
call ModifyHeroStat(1,GetDyingUnit(),0,udg_wosjs[22])
call ModifyHeroStat(2,GetDyingUnit(),0,udg_wosjs[22])
endif
if IsUnitAlly(GetDyingUnit(),Player(0))==false and udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))] then
set udg_wodw[5]=GetKillingUnit()
set udg_wodw[6]=GetDyingUnit()
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+1)
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]==1 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]>=udg_wojsl[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))] then
set udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=0
set udg_wojsl[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wojsl[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_wodw[5]))+("路飞的橡胶之魂修为升级为："+I2S(udg_wowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]==2 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]>=udg_wojsm[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))] then
set udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=0
set udg_wojsm[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wojsm[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_wodw[5]))+("索隆的剑豪之魂修为升级为："+I2S(udg_wowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
if udg_wowjz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]==3 and udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]>=udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))] then
set udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+1)
set udg_wosgjs[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=0
set udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]=(udg_wojsz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_wodw[5]))+("sanji'智囊之魂修为升级为："+I2S(udg_wowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_wodw[5])))])))))
endif
endif
endfunction
function Trig_wo_shengji_Actions takes nothing returns nothing
if udg_wobe[(1+GetPlayerId(GetOwningPlayer(GetLevelingUnit())))] and IsUnitType(GetLevelingUnit(),UNIT_TYPE_HERO) then
call ModifyHeroStat(0,GetLevelingUnit(),0,udg_wosjs[22])
call ModifyHeroStat(1,GetLevelingUnit(),0,udg_wosjs[22])
call ModifyHeroStat(2,GetLevelingUnit(),0,udg_wosjs[22])
endif
if IsUnitAlly(GetLevelingUnit(),Player(0)) then
call DisableTrigger(gg_trg_wo_xinxi)
endif
endfunction
function Trig_wo_chaxun_Actions takes nothing returns nothing
local unit u=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
local real l=I2R(GetHeroStatBJ(0,u,true))
local real m=I2R(GetHeroStatBJ(1,u,true))
local real z=I2R(GetHeroStatBJ(2,u,true))
local real lj=I2R(udg_wowuqijil[(1+GetPlayerId(GetTriggerPlayer()))])
local real mj=I2R(udg_wowuqijim[(1+GetPlayerId(GetTriggerPlayer()))])
local real zj=I2R(udg_wowuqijiz[(1+GetPlayerId(GetTriggerPlayer()))])
local real j=SquareRoot(I2R(GetHeroLevel(u)))
local real a=SquareRoot(l+m+z)/j
local real ll=a*lj*lj*l
local real lll=a*3*l*lj*(lj+5)
local real mm=a*mj*mj*m
local real mmm=a*3*m*mj*(mj+5)
local real zz=a*2*zj*zj*z
local real zzz=a*6*z*zj*(zj+5)
if GetEventPlayerChatString()=="查询" then
if udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]==2 then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：索隆的剑豪之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_wowuqijim[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_wojsm[(1+GetPlayerId(GetTriggerPlayer()))]-udg_wosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((mm/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((mmm/ 10000.))+"W")))
set u=null
endif
if udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]==3 then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：sanji'智囊之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_wowuqijiz[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_wojsz[(1+GetPlayerId(GetTriggerPlayer()))]-udg_wosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((zz/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((zzz/ 10000.))+"W")))
set u=null
endif
if udg_wowjz[(1+GetPlayerId(GetTriggerPlayer()))]==1 then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：路飞的橡胶之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_wowuqijil[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_wojsl[(1+GetPlayerId(GetTriggerPlayer()))]-udg_wosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((ll/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((lll/ 10000.))+"W")))
set u=null
endif
endif
endfunction