function Trig_liubo_kuang_Func001C takes nothing returns boolean
return true
endfunction
function Trig_liubo_kuang_Actions takes nothing returns nothing
if(Trig_liubo_kuang_Func001C())then
call DialogClear(udg_liubodk[1])
call DialogAddButtonWithHotkeyBJ(udg_liubodk[1],"路飞的橡胶之魂      力量型",'A')
set udg_liubodkan[1]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_liubodk[1],"索隆的剑豪之魂     敏捷型",'B')
set udg_liubodkan[2]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_liubodk[1],"sanji'智囊之魂     智力型",'C')
set udg_liubodkan[3]=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_liubodk[1],"我很强大，不用魂魄的力量！",'D')
set udg_liubodkan[4]=bj_lastCreatedButton
call DialogSetMessage(udg_liubodk[1],"溜波技能")
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DialogDisplay(Player(-1+(bj_forLoopAIndex)),udg_liubodk[1],true)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endfunction
function Trig_liubo_xuankuang_Func001Func001C takes nothing returns boolean
return(GetClickedButton()==udg_liubodkan[1])
endfunction
function Trig_liubo_xuankuang_Func001Func002C takes nothing returns boolean
return(GetClickedButton()==udg_liubodkan[2])
endfunction
function Trig_liubo_xuankuang_Func001Func003C takes nothing returns boolean
return(GetClickedButton()==udg_liubodkan[3])
endfunction
function Trig_liubo_xuankuang_Func001C takes nothing returns boolean
return true
endfunction
function Trig_liubo_xuankuang_Actions takes nothing returns nothing
if(Trig_liubo_xuankuang_Func001C())then
if(Trig_liubo_xuankuang_Func001Func001C())then
set udg_liubobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]+1)
call TriggerExecute(gg_trg_liubo_jiazhuangtai)
endif
if(Trig_liubo_xuankuang_Func001Func002C())then
set udg_liubobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]+2)
call TriggerExecute(gg_trg_liubo_jiazhuangtai)
endif
if(Trig_liubo_xuankuang_Func001Func003C())then
set udg_liubobe[(1+GetPlayerId(GetTriggerPlayer()))]=true
set udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]=(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]+3)
call TriggerExecute(gg_trg_liubo_jiazhuangtai)
endif
endif
endfunction
function Trig_liubo_gongji_Func001Func010Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==1)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func010Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func010Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func010Func003Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==1)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func010Func003Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func010Func003Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func010Func003Func008C takes nothing returns boolean
return(GetRandomInt(1,(73+((3/ 2)*udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==1)
endfunction
function Trig_liubo_gongji_Func001Func010Func003C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func010Func003Func008C())
endfunction
function Trig_liubo_gongji_Func001Func010Func005001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo_gongji_Func001Func010Func005001003002 takes nothing returns boolean
return(IsUnitAlly(GetFilterUnit(),Player(0))==false)
endfunction
function Trig_liubo_gongji_Func001Func010Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo_gongji_Func001Func010Func005001003001(),Trig_liubo_gongji_Func001Func010Func005001003002())
endfunction
function Trig_liubo_gongji_Func001Func010Func005A takes nothing returns nothing
call UnitDamageTarget(udg_liubodw[2],GetEnumUnit(),udg_liuboss[3],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function Trig_liubo_gongji_Func001Func010Func006C takes nothing returns boolean
return(GetRandomInt(1,(73+(2*udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==1)
endfunction
function Trig_liubo_gongji_Func001Func010C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func010Func006C())
endfunction
function Trig_liubo_gongji_Func001Func011Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==2)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func011Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func011Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func011Func003Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==2)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func011Func003Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func011Func003Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func011Func003Func008C takes nothing returns boolean
return(GetRandomInt(1,(73+((3/ 2)*udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==2)
endfunction
function Trig_liubo_gongji_Func001Func011Func003C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func011Func003Func008C())
endfunction
function Trig_liubo_gongji_Func001Func011Func005001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo_gongji_Func001Func011Func005001003002 takes nothing returns boolean
return(IsUnitAlly(GetFilterUnit(),Player(0))==false)
endfunction
function Trig_liubo_gongji_Func001Func011Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo_gongji_Func001Func011Func005001003001(),Trig_liubo_gongji_Func001Func011Func005001003002())
endfunction
function Trig_liubo_gongji_Func001Func011Func005A takes nothing returns nothing
call UnitDamageTarget(udg_liubodw[2],GetEnumUnit(),udg_liuboss[5],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function Trig_liubo_gongji_Func001Func011Func006C takes nothing returns boolean
return(GetRandomInt(1,(73+(2*udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==2)
endfunction
function Trig_liubo_gongji_Func001Func011C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func011Func006C())
endfunction
function Trig_liubo_gongji_Func001Func012Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==3)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func012Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func012Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func012Func003Func002Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]==3)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]>=udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
endfunction
function Trig_liubo_gongji_Func001Func012Func003Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func012Func003Func002Func005C())
endfunction
function Trig_liubo_gongji_Func001Func012Func003Func008C takes nothing returns boolean
return(GetRandomInt(1,(73+((3/ 2)*udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==3)
endfunction
function Trig_liubo_gongji_Func001Func012Func003C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func012Func003Func008C())
endfunction
function Trig_liubo_gongji_Func001Func012Func005001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo_gongji_Func001Func012Func005001003002 takes nothing returns boolean
return(IsUnitAlly(GetFilterUnit(),Player(0))==false)
endfunction
function Trig_liubo_gongji_Func001Func012Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo_gongji_Func001Func012Func005001003001(),Trig_liubo_gongji_Func001Func012Func005001003002())
endfunction
function Trig_liubo_gongji_Func001Func012Func005A takes nothing returns nothing
call UnitDamageTarget(udg_liubodw[2],GetEnumUnit(),udg_liuboss[7],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call GroupClear(GetLastCreatedGroup())
call DestroyEffect(bj_lastCreatedEffect)
endfunction
function Trig_liubo_gongji_Func001Func012Func006C takes nothing returns boolean
return(GetRandomInt(1,(73+(2*udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])))>=70)and(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==3)
endfunction
function Trig_liubo_gongji_Func001Func012C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func012Func006C())
endfunction
function Trig_liubo_gongji_Func001Func013C takes nothing returns boolean
return(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])and(IsUnitAlly(GetTriggerUnit(),Player(0))==false)and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))
endfunction
function Trig_liubo_gongji_Func001C takes nothing returns boolean
return(Trig_liubo_gongji_Func001Func013C())
endfunction
function Trig_liubo_gongji_Func002Func002C takes nothing returns boolean
return(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_gongji_Func002Func004Func006C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==1)and(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_gongji_Func002Func004C takes nothing returns boolean
return(Trig_liubo_gongji_Func002Func004Func006C())
endfunction
function Trig_liubo_gongji_Func002Func005Func006C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==2)and(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_gongji_Func002Func005C takes nothing returns boolean
return(Trig_liubo_gongji_Func002Func005Func006C())
endfunction
function Trig_liubo_gongji_Func002Func006Func006C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]==3)and(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_gongji_Func002Func006C takes nothing returns boolean
return(Trig_liubo_gongji_Func002Func006Func006C())
endfunction
function Trig_liubo_gongji_Func002Func007C takes nothing returns boolean
return(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))])and(IsUnitAlly(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))==false)and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))
endfunction
function Trig_liubo_gongji_Func002C takes nothing returns boolean
return(Trig_liubo_gongji_Func002Func007C())
endfunction
function Trig_liubo_gongji_Actions takes nothing returns nothing
if(Trig_liubo_gongji_Func001C())then
set udg_liubodw[2]=GetAttacker()
set udg_liubodw[3]=GetTriggerUnit()
set udg_liuboss[0]=I2R(GetHeroStr(udg_liubodw[2],true))
set udg_liuboss[1]=I2R(GetHeroAgi(udg_liubodw[2],true))
set udg_liuboss[2]=I2R(GetHeroInt(udg_liubodw[2],true))
set udg_liuboss[10]=I2R(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
set udg_liuboss[11]=I2R(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
set udg_liuboss[12]=I2R(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))])
set udg_liubosjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=GetHeroLevel(udg_liubodw[2])
if(Trig_liubo_gongji_Func001Func010C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func010Func002C())then
set udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("路飞的橡胶之魂修为升级为："+I2S(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[3]=(((udg_liuboss[0]*3.)+(udg_liuboss[1]+udg_liuboss[2]))*((3.*udg_liuboss[10])+5.))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(udg_liubodw[3]),400.,400.)),Condition(function Trig_liubo_gongji_Func001Func010Func005001003)),function Trig_liubo_gongji_Func001Func010Func005A)
else
if(Trig_liubo_gongji_Func001Func010Func003C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func010Func003Func002C())then
set udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("路飞的橡胶之魂修为升级为："+I2S(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[4]=((10.*udg_liuboss[0])*(udg_liuboss[10]*(10.+udg_liuboss[10])))
call UnitDamageTarget(udg_liubodw[2],udg_liubodw[3],udg_liuboss[4],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",udg_liubodw[3],"Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
if(Trig_liubo_gongji_Func001Func011C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func011Func002C())then
set udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("索隆的剑豪之魂修为升级为："+I2S(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[5]=(((udg_liuboss[1]*3.)+(udg_liuboss[0]+udg_liuboss[2]))*((3.*udg_liuboss[11])+5.))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(udg_liubodw[3]),400.,400.)),Condition(function Trig_liubo_gongji_Func001Func011Func005001003)),function Trig_liubo_gongji_Func001Func011Func005A)
else
if(Trig_liubo_gongji_Func001Func011Func003C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func011Func003Func002C())then
set udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("索隆的剑豪之魂修为升级为："+I2S(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[6]=((udg_liuboss[1]*10.)*(udg_liuboss[11]*(10.+udg_liuboss[11])))
call UnitDamageTarget(udg_liubodw[2],udg_liubodw[3],udg_liuboss[6],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",udg_liubodw[3],"Abilities\\Spells\\Other\\Drain\\ManaDrainCaster.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
if(Trig_liubo_gongji_Func001Func012C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func012Func002C())then
set udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("sanji'智囊之魂修为升级为："+I2S(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[7]=(((udg_liuboss[2]*3.)+(udg_liuboss[1]+udg_liuboss[0]))*((3.*udg_liuboss[12])+5.))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.,GetRectCenter(RectFromCenterSizeBJ(GetUnitLoc(udg_liubodw[3]),400.,400.)),Condition(function Trig_liubo_gongji_Func001Func012Func005001003)),function Trig_liubo_gongji_Func001Func012Func005A)
else
if(Trig_liubo_gongji_Func001Func012Func003C())then
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+10)
if(Trig_liubo_gongji_Func001Func012Func003Func002C())then
set udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=0
set udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[2])))]=(udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[2]))+("sanji'智囊之魂修为升级为："+I2S(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
set udg_liuboss[8]=((udg_liuboss[2]*10.)*(udg_liuboss[12]*(10.+udg_liuboss[12])))
call UnitDamageTarget(udg_liubodw[2],udg_liubodw[3],udg_liuboss[8],true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call AddSpecialEffectTargetUnitBJ("overhead",udg_liubodw[3],"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call PolledWait(.1)
call DestroyEffect(bj_lastCreatedEffect)
endif
endif
endif
if(Trig_liubo_gongji_Func002C())then
set udg_liubosjs[27]=GetHeroLevel(GetAttacker())
if(Trig_liubo_gongji_Func002Func002C())then
call SetHeroLevelBJ(GetAttacker(),(udg_liubosjs[27]+1),false)
call CreateTextTagUnitBJ("等级提升",GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
set udg_liubosjs[26]=(3*(R2I(SquareRoot(I2R(udg_liubosjs[22])))*R2I(SquareRoot(I2R(GetHeroLevel(GetAttacker()))))))
if(Trig_liubo_gongji_Func002Func004C())then
call ModifyHeroStat(0,GetAttacker(),0,udg_liubosjs[26])
call CreateTextTagUnitBJ(("+力量"+I2S(udg_liubosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_gongji_Func002Func005C())then
call ModifyHeroStat(1,GetAttacker(),0,udg_liubosjs[26])
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_liubosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_gongji_Func002Func006C())then
call ModifyHeroStat(2,GetAttacker(),0,udg_liubosjs[26])
call CreateTextTagUnitBJ(("+智力"+I2S(udg_liubosjs[26])),GetAttacker(),0,17.,GetRandomReal(0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,150.),GetRandomReal(0,360))
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
endif
endfunction
function Trig_liubo_xinxi_Func001Func006C takes nothing returns boolean
return(udg_liubosjs[21]==0)and(GetEventPlayerChatString()=="溜波")
endfunction
function Trig_liubo_xinxi_Func001C takes nothing returns boolean
return(Trig_liubo_xinxi_Func001Func006C())
endfunction
function Trig_liubo_xinxi_Actions takes nothing returns nothing
if(Trig_liubo_xinxi_Func001C())then
set udg_liubosjs[21]=(udg_liubosjs[21]+1)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"欢迎使用溜波技能，此技能威力和属性有关，魂魄修为对技能的威力影响很大。可以通过输入“查询”查询武器的详细情况。")
set udg_liubosjs[23]=GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
set udg_liubosjs[22]=((GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)+(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)+GetHeroStatBJ(2,FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),false)))/ 3)
call ConditionalTriggerExecute(gg_trg_liubo_kuang)
endif
endfunction
function Trig_liubo_zhouqi_Actions takes nothing returns nothing
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"欢迎使用溜波技能，开启方法为任意玩家输入“溜波”即可。此技能威力和属性有关，魂魄修为对技能的威力影响很大。可以通过输入“查询”查询武器的详细情况。")
endfunction
function Trig_liubo_chushi_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_liubowuqijil[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_liubowuqijim[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_liubowuqijiz[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=1
set udg_liubojsl[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set udg_liubojsm[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set udg_liubojsz[(1+GetPlayerId(Player(-1+(bj_forLoopAIndex))))]=300
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_liubo_jiazhuangtai_Func001Func001001002001 takes nothing returns boolean
return(udg_liubobe[(1+GetPlayerId(GetFilterPlayer()))])
endfunction
function Trig_liubo_jiazhuangtai_Func001Func001001002002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_liubo_jiazhuangtai_Func001Func001001002 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo_jiazhuangtai_Func001Func001001002001(),Trig_liubo_jiazhuangtai_Func001Func001001002002())
endfunction
function Trig_liubo_jiazhuangtai_Func001Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),552.)
endfunction
function Trig_liubo_jiazhuangtai_Func001C takes nothing returns boolean
return true
endfunction
function Trig_liubo_jiazhuangtai_Actions takes nothing returns nothing
if(Trig_liubo_jiazhuangtai_Func001C())then
call ForGroupBJ(GetUnitsInRectMatching(GetWorldBounds(),Condition(function Trig_liubo_jiazhuangtai_Func001Func001001002)),function Trig_liubo_jiazhuangtai_Func001Func001A)
endif
endfunction
function Trig_liubo_siwang_Func001Func001Func007Func006C takes nothing returns boolean
return(GetRandomInt(1,20)==1)and(GetHeroLevel(udg_liubodw[1])>500)and(udg_liubosjs[23]>0)
endfunction
function Trig_liubo_siwang_Func001Func001Func007C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func001Func007Func006C())
endfunction
function Trig_liubo_siwang_Func001Func001Func008Func006C takes nothing returns boolean
return(GetRandomInt(1,20)==1)and(GetHeroLevel(udg_liubodw[1])<=500)and(udg_liubosjs[23]>0)
endfunction
function Trig_liubo_siwang_Func001Func001Func008C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func001Func008Func006C())
endfunction
function Trig_liubo_siwang_Func001Func001Func009C takes nothing returns boolean
return(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_siwang_Func001Func001Func010C takes nothing returns boolean
return(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_siwang_Func001Func001Func011C takes nothing returns boolean
return(GetRandomInt(1,50)==1)
endfunction
function Trig_liubo_siwang_Func001Func001Func012C takes nothing returns boolean
return(IsUnitAlly(GetDyingUnit(),GetOwningPlayer(GetKillingUnit()))==false)and(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))])and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))
endfunction
function Trig_liubo_siwang_Func001Func001C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func001Func012C())
endfunction
function Trig_liubo_siwang_Func001Func002Func004C takes nothing returns boolean
return(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetDyingUnit())))])and(IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO))
endfunction
function Trig_liubo_siwang_Func001Func002C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func002Func004C())
endfunction
function Trig_liubo_siwang_Func001Func003Func004Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]==1)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]>=udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])
endfunction
function Trig_liubo_siwang_Func001Func003Func004C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func003Func004Func005C())
endfunction
function Trig_liubo_siwang_Func001Func003Func005Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]==2)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]>=udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])
endfunction
function Trig_liubo_siwang_Func001Func003Func005C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func003Func005Func005C())
endfunction
function Trig_liubo_siwang_Func001Func003Func006Func005C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]==3)and(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]>=udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])
endfunction
function Trig_liubo_siwang_Func001Func003Func006C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func003Func006Func005C())
endfunction
function Trig_liubo_siwang_Func001Func003Func007C takes nothing returns boolean
return(IsUnitAlly(GetDyingUnit(),Player(0))==false)and(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))])
endfunction
function Trig_liubo_siwang_Func001Func003C takes nothing returns boolean
return(Trig_liubo_siwang_Func001Func003Func007C())
endfunction
function Trig_liubo_siwang_Func001C takes nothing returns boolean
return true
endfunction
function Trig_liubo_siwang_Actions takes nothing returns nothing
if(Trig_liubo_siwang_Func001C())then
if(Trig_liubo_siwang_Func001Func001C())then
set udg_liubodw[1]=GetKillingUnit()
set udg_liubosjs[1]=GetRandomInt(1,15)
set udg_liubosjs[3]=GetRandomInt(1,R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit())))))
set udg_liubosjs[2]=(R2I(SquareRoot(I2R(udg_liubosjs[22])))*udg_liubosjs[3])
set udg_liubosjs[4]=(udg_liubosjs[23]*udg_liubosjs[3])
set udg_liubosjs[5]=(udg_liubosjs[3]*3)
if(Trig_liubo_siwang_Func001Func001Func007C())then
call AdjustPlayerStateBJ(udg_liubosjs[5],GetOwningPlayer(udg_liubodw[1]),PLAYER_STATE_RESOURCE_LUMBER)
call CreateTextTagUnitBJ(("+木"+I2S(udg_liubosjs[5])),udg_liubodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_siwang_Func001Func001Func008C())then
call AdjustPlayerStateBJ(udg_liubosjs[4],GetOwningPlayer(udg_liubodw[1]),PLAYER_STATE_RESOURCE_GOLD)
call CreateTextTagUnitBJ(("+钱"+I2S(udg_liubosjs[4])),udg_liubodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_siwang_Func001Func001Func009C())then
call ModifyHeroStat(2,udg_liubodw[1],0,udg_liubosjs[2])
call CreateTextTagUnitBJ(("+智力"+I2S(udg_liubosjs[2])),udg_liubodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_siwang_Func001Func001Func010C())then
call ModifyHeroStat(1,udg_liubodw[1],0,udg_liubosjs[2])
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_liubosjs[2])),udg_liubodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
if(Trig_liubo_siwang_Func001Func001Func011C())then
call ModifyHeroStat(0,udg_liubodw[1],0,udg_liubosjs[2])
call CreateTextTagUnitBJ(("+力量"+I2S(udg_liubosjs[2])),udg_liubodw[1],0,14.,GetRandomReal(.0,100.),GetRandomReal(0,100.),GetRandomReal(0,100.),0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,GetRandomReal(40.,120.),GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
endif
if(Trig_liubo_siwang_Func001Func002C())then
call ModifyHeroStat(0,GetDyingUnit(),0,udg_liubosjs[22])
call ModifyHeroStat(1,GetDyingUnit(),0,udg_liubosjs[22])
call ModifyHeroStat(2,GetDyingUnit(),0,udg_liubosjs[22])
endif
if(Trig_liubo_siwang_Func001Func003C())then
set udg_liubodw[5]=GetKillingUnit()
set udg_liubodw[6]=GetDyingUnit()
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+1)
if(Trig_liubo_siwang_Func001Func003Func004C())then
set udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=0
set udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubojsl[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[5]))+("路飞的橡胶之魂修为升级为："+I2S(udg_liubowuqijil[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
if(Trig_liubo_siwang_Func001Func003Func005C())then
set udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=0
set udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubojsm[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[5]))+("索隆的剑豪之魂修为升级为："+I2S(udg_liubowuqijim[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
if(Trig_liubo_siwang_Func001Func003Func006C())then
set udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+1)
set udg_liubosgjs[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=0
set udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]=(udg_liubojsz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))]+300)
call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,("附在"+(GetPlayerName(GetOwningPlayer(udg_liubodw[5]))+("sanji'智囊之魂修为升级为："+I2S(udg_liubowuqijiz[(1+GetPlayerId(GetOwningPlayer(udg_liubodw[5])))])))))
endif
endif
endif
endfunction
function Trig_liubo_shengji_Func001Func004C takes nothing returns boolean
return(udg_liubobe[(1+GetPlayerId(GetOwningPlayer(GetLevelingUnit())))])and(IsUnitType(GetLevelingUnit(),UNIT_TYPE_HERO))
endfunction
function Trig_liubo_shengji_Func001C takes nothing returns boolean
return(Trig_liubo_shengji_Func001Func004C())
endfunction
function Trig_liubo_shengji_Func002C takes nothing returns boolean
return(IsUnitAlly(GetLevelingUnit(),Player(0)))
endfunction
function Trig_liubo_shengji_Actions takes nothing returns nothing
if(Trig_liubo_shengji_Func001C())then
call ModifyHeroStat(0,GetLevelingUnit(),0,udg_liubosjs[22])
call ModifyHeroStat(1,GetLevelingUnit(),0,udg_liubosjs[22])
call ModifyHeroStat(2,GetLevelingUnit(),0,udg_liubosjs[22])
endif
if(Trig_liubo_shengji_Func002C())then
call DisableTrigger(gg_trg_liubo_xinxi)
endif
endfunction
function Trig_liubo_chaxun_Func001Func013C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]==2)
endfunction
function Trig_liubo_chaxun_Func001Func014C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]==3)
endfunction
function Trig_liubo_chaxun_Func001Func015C takes nothing returns boolean
return(udg_liubowjz[(1+GetPlayerId(GetTriggerPlayer()))]==1)
endfunction
function Trig_liubo_chaxun_Func001C takes nothing returns boolean
return(GetEventPlayerChatString()=="查询")
endfunction
function Trig_liubo_chaxun_Actions takes nothing returns nothing
if(Trig_liubo_chaxun_Func001C())then
set udg_liuboss[21]=I2R(GetHeroStatBJ(0,FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))
set udg_liuboss[22]=I2R(GetHeroStatBJ(1,FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))
set udg_liuboss[23]=I2R(GetHeroStatBJ(2,FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))
set udg_liuboss[24]=I2R(udg_liubowuqijil[(1+GetPlayerId(GetTriggerPlayer()))])
set udg_liuboss[25]=I2R(udg_liubowuqijim[(1+GetPlayerId(GetTriggerPlayer()))])
set udg_liuboss[26]=I2R(udg_liubowuqijiz[(1+GetPlayerId(GetTriggerPlayer()))])
set udg_liuboss[27]=(((udg_liuboss[21]*3.)+(udg_liuboss[22]+udg_liuboss[23]))*((3.*udg_liuboss[24])+5.))
set udg_liuboss[28]=(10.*(udg_liuboss[21]*(udg_liuboss[24]*(10.+udg_liuboss[24]))))
set udg_liuboss[29]=(((udg_liuboss[22]*3.)+(udg_liuboss[21]+udg_liuboss[23]))*((3.*udg_liuboss[25])+5.))
set udg_liuboss[30]=(10.*(udg_liuboss[22]*(udg_liuboss[25]*(10.+udg_liuboss[25]))))
set udg_liuboss[31]=(((udg_liuboss[23]*3.)+(udg_liuboss[22]+udg_liuboss[21]))*((3.*udg_liuboss[26])+5.))
set udg_liuboss[32]=(10.*(udg_liuboss[23]*(udg_liuboss[26]*(10.+udg_liuboss[26]))))
if(Trig_liubo_chaxun_Func001Func013C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：索隆的剑豪之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_liubowuqijim[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_liubojsm[(1+GetPlayerId(GetTriggerPlayer()))]-udg_liubosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((udg_liuboss[29]/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((udg_liuboss[30]/ 10000.))+"W")))
endif
if(Trig_liubo_chaxun_Func001Func014C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：sanji'智囊之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_liubowuqijiz[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_liubojsz[(1+GetPlayerId(GetTriggerPlayer()))]-udg_liubosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((udg_liuboss[31]/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((udg_liuboss[32]/ 10000.))+"W")))
endif
if(Trig_liubo_chaxun_Func001Func015C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"魂魄：路飞的橡胶之魂")
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("修为等级："+I2S(udg_liubowuqijil[(1+GetPlayerId(GetTriggerPlayer()))])))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("熟练度还差"+(I2S((udg_liubojsl[(1+GetPlayerId(GetTriggerPlayer()))]-udg_liubosgjs[(1+GetPlayerId(GetTriggerPlayer()))]))+"就可以升级了！")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("群技能威力："+(R2S((udg_liuboss[27]/ 10000.))+"W")))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("单技能威力："+(R2S((udg_liuboss[28]/ 10000.))+"W")))
endif
endif
endfunction