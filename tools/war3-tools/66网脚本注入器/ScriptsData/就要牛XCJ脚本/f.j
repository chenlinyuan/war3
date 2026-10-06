function InitCJFY takes nothing returns nothing
local integer index
local integer userControlledPlayers
local version v
set index=0
loop
exitwhen index==fy_MAX_PLAYER_SLOTS
set fy_FORCE_PLAYER[index]=CreateForce()
call ForceAddPlayer(fy_FORCE_PLAYER[index],Player(index))
set index=index+1
endloop
set fy_FORCE_ALL_PLAYERS=CreateForce()
call ForceEnumPlayers(fy_FORCE_ALL_PLAYERS,null)
set fy_cineModePriorSpeed=GetGameSpeed()
set fy_cineModePriorFogSetting=IsFogEnabled()
set fy_cineModePriorMaskSetting=IsFogMaskEnabled()
set index=0
loop
exitwhen index>=fy_MAX_QUEUED_TRIGGERS
set fy_queuedExecTriggers[index]=null
set fy_queuedExecUseConds[index]=false
set index=index+1
endloop
set fy_isSinglePlayer=false
set userControlledPlayers=0
set index=0
loop
exitwhen index>=fy_MAX_PLAYERS
if(GetPlayerController(Player(index))==MAP_CONTROL_USER and GetPlayerSlotState(Player(index))==PLAYER_SLOT_STATE_PLAYING)then
set userControlledPlayers=userControlledPlayers+1
endif
set index=index+1
endloop
set fy_isSinglePlayer=(userControlledPlayers==1)
set fy_rescueSound=CreateSoundFromLabel("Rescue",false,false,false,10000,10000)
set fy_questDiscoveredSound=CreateSoundFromLabel("QuestNew",false,false,false,10000,10000)
set fy_questUpdatedSound=CreateSoundFromLabel("QuestUpdate",false,false,false,10000,10000)
set fy_questCompletedSound=CreateSoundFromLabel("QuestCompleted",false,false,false,10000,10000)
set fy_questFailedSound=CreateSoundFromLabel("QuestFailed",false,false,false,10000,10000)
set fy_questHintSound=CreateSoundFromLabel("Hint",false,false,false,10000,10000)
set fy_questSecretSound=CreateSoundFromLabel("SecretFound",false,false,false,10000,10000)
set fy_questItemAcquiredSound=CreateSoundFromLabel("ItemReward",false,false,false,10000,10000)
set fy_questWarningSound=CreateSoundFromLabel("Warning",false,false,false,10000,10000)
set fy_victoryDialogSound=CreateSoundFromLabel("QuestCompleted",false,false,false,10000,10000)
set fy_defeatDialogSound=CreateSoundFromLabel("QuestFailed",false,false,false,10000,10000)
set v=VersionGet()
if(v==VERSION_REIGN_OF_CHAOS)then
set fy_MELEE_MAX_TWINKED_HEROES=fy_MELEE_MAX_TWINKED_HEROES_V0
else
set fy_MELEE_MAX_TWINKED_HEROES=fy_MELEE_MAX_TWINKED_HEROES_V1
endif
endfunction
function FYAnd takes boolean valueA,boolean valueB returns boolean
return valueA and valueB
endfunction
function AddStatesimFY takes player whichPlayer,playerstate whichPlayerState,integer delta returns nothing
call SetPlayerState(whichPlayer,whichPlayerState,GetPlayerState(whichPlayer,whichPlayerState)+delta)
endfunction
function AddStateFY takes integer delta,player whichPlayer,playerstate whichPlayerState returns nothing
if(delta>0)then
if(whichPlayerState==PLAYER_STATE_RESOURCE_GOLD)then
call AddStatesimFY(whichPlayer,PLAYER_STATE_GOLD_GATHERED,delta)
elseif(whichPlayerState==PLAYER_STATE_RESOURCE_LUMBER)then
call AddStatesimFY(whichPlayer,PLAYER_STATE_LUMBER_GATHERED,delta)
endif
endif
call AddStatesimFY(whichPlayer,whichPlayerState,delta)
endfunction
function GetHeroStatFY takes integer whichStat,unit whichHero,boolean includeBonuses returns integer
if(whichStat==fy_HEROSTAT_STR)then
return GetHeroStr(whichHero,includeBonuses)
elseif(whichStat==fy_HEROSTAT_AGI)then
return GetHeroAgi(whichHero,includeBonuses)
elseif(whichStat==fy_HEROSTAT_INT)then
return GetHeroInt(whichHero,includeBonuses)
else
return 0
endif
endfunction
function StatFY takes unit whichHero,integer whichStat,integer value returns nothing
if(value<=0)then
return
endif
if(whichStat==fy_HEROSTAT_STR)then
call SetHeroStr(whichHero,value,true)
elseif(whichStat==fy_HEROSTAT_AGI)then
call SetHeroAgi(whichHero,value,true)
elseif(whichStat==fy_HEROSTAT_INT)then
call SetHeroInt(whichHero,value,true)
endif
endfunction
function AllStatFY takes integer whichStat,unit whichHero,integer modifyMethod,integer value returns nothing
if(modifyMethod==fy_MODIFYMETHOD_ADD)then
call StatFY(whichHero,whichStat,GetHeroStatFY(whichStat,whichHero,false)+value)
elseif(modifyMethod==fy_MODIFYMETHOD_SUB)then
call StatFY(whichHero,whichStat,GetHeroStatFY(whichStat,whichHero,false)-value)
elseif(modifyMethod==fy_MODIFYMETHOD_SET)then
call StatFY(whichHero,whichStat,value)
endif
endfunction
function UnitAddItemByIdSwappedFY takes integer itemId,unit whichHero returns item
set fy_lastCreatedItem=CreateItem(itemId,GetUnitX(whichHero),GetUnitY(whichHero))
call UnitAddItem(whichHero,fy_lastCreatedItem)
return fy_lastCreatedItem
endfunction
function ModuloIntegerFY takes integer dividend,integer divisor returns integer
local integer modulus=dividend-(dividend/ divisor)*divisor
if(modulus<0)then
set modulus=modulus+divisor
endif
return modulus
endfunction
function SubStringFY takes string source,integer start,integer end returns string
return SubString(source,start-1,end)
endfunction
function UnitItemInSlotFY takes unit whichUnit,integer itemSlot returns item
return UnitItemInSlot(whichUnit,itemSlot-1)
endfunction
function DisplayTimedTextToForceFY takes force toForce,real duration,string message returns nothing
if(IsPlayerInForce(GetLocalPlayer(),toForce))then
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,duration,message)
endif
endfunction
function CustomVictorySkipFY takes player whichPlayer returns nothing
if(GetLocalPlayer()==whichPlayer)then
if fy_isSinglePlayer then
call SetGameDifficulty(GetDefaultDifficulty())
endif
if(fy_changeLevelMapName==null)then
call EndGame(fy_changeLevelShowScores)
else
call ChangeLevel(fy_changeLevelMapName,fy_changeLevelShowScores)
endif
endif
endfunction
function StartSoundForPlayerFY takes player whichPlayer,sound soundHandle returns nothing
if(whichPlayer==GetLocalPlayer())then
call StartSound(soundHandle)
endif
endfunction
function VolumeGroupSetVolumeForPlayerFY takes player whichPlayer,volumegroup vgroup,real scale returns nothing
if(GetLocalPlayer()==whichPlayer)then
call VolumeGroupSetVolume(vgroup,scale)
endif
endfunction
function CustomVictoryQuitFY takes nothing returns nothing
if fy_isSinglePlayer then
call PauseGame(false)
call SetGameDifficulty(GetDefaultDifficulty())
endif
call EndGame(fy_changeLevelShowScores)
endfunction
function CustomVictoryOkFY takes nothing returns nothing
if fy_isSinglePlayer then
call PauseGame(false)
call SetGameDifficulty(GetDefaultDifficulty())
endif
if(fy_changeLevelMapName==null)then
call EndGame(fy_changeLevelShowScores)
else
call ChangeLevel(fy_changeLevelMapName,fy_changeLevelShowScores)
endif
endfunction
function CustomVictoryDialogFY takes player whichPlayer returns nothing
local trigger t=CreateTrigger()
local dialog d=DialogCreate()
call DialogSetMessage(d,GetLocalizedString("GAMEOVER_VICTORY_MSG"))
set t=CreateTrigger()
call TriggerRegisterDialogButtonEvent(t,DialogAddButton(d,GetLocalizedString("GAMEOVER_CONTINUE"),GetLocalizedHotkey("GAMEOVER_CONTINUE")))
call TriggerAddAction(t,function CustomVictoryOkFY)
set t=CreateTrigger()
call TriggerRegisterDialogButtonEvent(t,DialogAddButton(d,GetLocalizedString("GAMEOVER_QUIT_MISSION"),GetLocalizedHotkey("GAMEOVER_QUIT_MISSION")))
call TriggerAddAction(t,function CustomVictoryQuitFY)
if(GetLocalPlayer()==whichPlayer)then
call EnableUserControl(true)
if fy_isSinglePlayer then
call PauseGame(true)
endif
call EnableUserUI(false)
endif
call DialogDisplay(whichPlayer,d,true)
call VolumeGroupSetVolumeForPlayerFY(whichPlayer,SOUND_VOLUMEGROUP_UI,1.)
call StartSoundForPlayerFY(whichPlayer,fy_victoryDialogSound)
endfunction
function AllowVictoryDefeatFY takes playergameresult gameResult returns boolean
if(gameResult==PLAYER_GAME_RESULT_VICTORY)then
return not IsNoVictoryCheat()
endif
if(gameResult==PLAYER_GAME_RESULT_DEFEAT)then
return not IsNoDefeatCheat()
endif
if(gameResult==PLAYER_GAME_RESULT_NEUTRAL)then
return(not IsNoVictoryCheat())and(not IsNoDefeatCheat())
endif
return true
endfunction
function CustomVictoryFY takes player whichPlayer,boolean showDialog,boolean showScores returns nothing
if AllowVictoryDefeatFY(PLAYER_GAME_RESULT_VICTORY)then
call RemovePlayer(whichPlayer,PLAYER_GAME_RESULT_VICTORY)
if not fy_isSinglePlayer then
call DisplayTimedTextFromPlayer(whichPlayer,0,0,60,GetLocalizedString("PLAYER_VICTORIOUS"))
endif
if(GetPlayerController(whichPlayer)==MAP_CONTROL_USER)then
set fy_changeLevelShowScores=showScores
if showDialog then
call CustomVictoryDialogFY(whichPlayer)
else
call CustomVictorySkipFY(whichPlayer)
endif
endif
endif
endfunction
function DialogDisplayFY takes boolean flag,dialog whichDialog,player whichPlayer returns nothing
call DialogDisplay(whichPlayer,whichDialog,flag)
endfunction
function DialogAddButtonFY takes dialog whichDialog,string buttonText returns button
set fy_lastCreatedButton=DialogAddButton(whichDialog,buttonText,0)
return fy_lastCreatedButton
endfunction
function fenglod111_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="playerA"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("下一页"+""))
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod112_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="playerA")
endfunction
function fenglod112_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[fy_forLoopAIndex])
endfunction
function fenglod112_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[13])
endfunction
function fenglod112_Actions takes nothing returns nothing
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
if(fenglod112_Func003Func001C())then
call CustomVictoryFY(Player(-1+(fy_forLoopAIndex)),false,false)
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,30,(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+"被踢出了游戏!"))
return
endif
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
if(fenglod112_Func004C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=7
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function fenglod113_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="playerB"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("下一页"+""))
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod114_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="playerB")
endfunction
function fenglod114_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[fy_forLoopAIndex])
endfunction
function fenglod114_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[13])
endfunction
function fenglod114_Actions takes nothing returns nothing
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
if(fenglod114_Func003Func001C())then
set fenglodbrzwj[(1+GetPlayerId(Player(-1+(fy_forLoopAIndex))))]=true
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,30,(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+"拥有了作弊权限!"))
return
endif
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
if(fenglod114_Func004C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=7
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function fenglodID takes integer int returns string
local string num="0123456789"
local string ABC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string abc="abcdefghijklmnopqrstuvwxyz"
local string target=""
local integer n=0
local integer dis=0
loop
exitwhen int==0
set n=ModuloIntegerFY(int,256)
if n>='0' and n<='9'then
set dis=n-'0'
set target=SubString(num,dis,dis+1)+target
endif
if n>='A' and n<='Z'then
set dis=n-'A'
set target=SubString(ABC,dis,dis+1)+target
endif
if n>='a' and n<='z'then
set dis=n-'a'
set target=SubString(abc,dis,dis+1)+target
endif
set int=int/256
endloop
return target
endfunction
function fenglodID2 takes string targetstr returns integer
local string originstr="..................................!.#$&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
local integer strlength=StringLength(targetstr)
local integer a=0
local integer b=0
local integer numx=1
local integer result=0
loop
exitwhen b>strlength-1
set numx=R2I(Pow(256,strlength-1-b))
set a=1
loop
exitwhen a>255
if SubString(targetstr,b,b+1)==SubString(originstr,a,a+1)then
set result=result+a*numx
set a=256
endif
set a=a+1
endloop
set b=b+1
endloop
return result
endfunction
function fenglod139_Conditions takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function fenglod139_Actions takes nothing returns nothing
set fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]=null
set fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
set fenglodwsz2=GetUnitTypeId(GetTriggerUnit())
set fenglodwp[1]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),1))
set fenglodwp[2]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),2))
set fenglodwp[3]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),3))
set fenglodwp[4]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),4))
set fenglodwp[5]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),5))
set fenglodwp[6]=GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),6))
set fengloddw1=GetTriggerUnit()
endfunction
function fenglod115_Conditions takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function fenglod115_Func019C takes nothing returns boolean
return(SubStringFY(fenglodzfc,1,4)=="/wp+")
endfunction
function fenglod115_Func002Func003C takes nothing returns boolean
return(SubStringFY(fenglodzfc,1,4)=="/dw+")
endfunction
function fenglod115_Func008Func003A takes nothing returns nothing
call UnitAddItemByIdSwappedFY(fenglodtszs,GetEnumUnit())
endfunction
function fenglod115_Func002Func004821 takes nothing returns boolean
return(SubStringFY(fenglodzfc,2,2)=="?")
endfunction
function fenglod115_Func003Func004001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="j")
endfunction
function fenglod115_Func003Func004002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="q")
endfunction
function fenglod115_Func003Func004002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func003Func004002 takes nothing returns boolean
return FYAnd(fenglod115_Func003Func004002001(),fenglod115_Func003Func004002002())
endfunction
function fenglod115_Func003C takes nothing returns boolean
return(FYAnd(fenglod115_Func003Func004001(),fenglod115_Func003Func004002()))
endfunction
function fenglod115_Func004Func004001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="j")
endfunction
function fenglod115_Func004Func004002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="m")
endfunction
function fenglod115_Func004Func004002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func004Func004002 takes nothing returns boolean
return FYAnd(fenglod115_Func004Func004002001(),fenglod115_Func004Func004002002())
endfunction
function fenglod115_Func004C takes nothing returns boolean
return(FYAnd(fenglod115_Func004Func004001(),fenglod115_Func004Func004002()))
endfunction
function fenglod115_Func005Func006001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="q")
endfunction
function fenglod115_Func005Func006002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="m")
endfunction
function fenglod115_Func005Func006002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func005Func006002 takes nothing returns boolean
return FYAnd(fenglod115_Func005Func006002001(),fenglod115_Func005Func006002002())
endfunction
function fenglod115_Func005C takes nothing returns boolean
return(FYAnd(fenglod115_Func005Func006001(),fenglod115_Func005Func006002()))
endfunction
function fenglod115_Func006Func004001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="j")
endfunction
function fenglod115_Func006Func004002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="q")
endfunction
function fenglod115_Func006Func004002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func006Func004002 takes nothing returns boolean
return FYAnd(fenglod115_Func006Func004002001(),fenglod115_Func006Func004002002())
endfunction
function fenglod115_Func006C takes nothing returns boolean
return(FYAnd(fenglod115_Func006Func004001(),fenglod115_Func006Func004002()))
endfunction
function fenglod115_Func007Func006001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="q")
endfunction
function fenglod115_Func007Func006002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="m")
endfunction
function fenglod115_Func007Func006002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func007Func006002 takes nothing returns boolean
return FYAnd(fenglod115_Func007Func006002001(),fenglod115_Func007Func006002002())
endfunction
function fenglod115_Func007C takes nothing returns boolean
return(FYAnd(fenglod115_Func007Func006001(),fenglod115_Func007Func006002()))
endfunction
function fenglod115_Func008Func004001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="j")
endfunction
function fenglod115_Func008Func004002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="m")
endfunction
function fenglod115_Func008Func004002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func008Func004002 takes nothing returns boolean
return FYAnd(fenglod115_Func008Func004002001(),fenglod115_Func008Func004002002())
endfunction
function fenglod115_Func008C takes nothing returns boolean
return(FYAnd(fenglod115_Func008Func004001(),fenglod115_Func008Func004002()))
endfunction
function fenglod115_Func009Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="d")
endfunction
function fenglod115_Func009Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="j")
endfunction
function fenglod115_Func009Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func009Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func009Func003002001(),fenglod115_Func009Func003002002())
endfunction
function fenglod115_Func009C takes nothing returns boolean
return(FYAnd(fenglod115_Func009Func003001(),fenglod115_Func009Func003002()))
endfunction
function fenglod115_Func010Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="d")
endfunction
function fenglod115_Func010Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="j")
endfunction
function fenglod115_Func010Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func010Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func010Func003002001(),fenglod115_Func010Func003002002())
endfunction
function fenglod115_Func010C takes nothing returns boolean
return(FYAnd(fenglod115_Func010Func003001(),fenglod115_Func010Func003002()))
endfunction
function fenglod115_Func011Func005001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="s")
endfunction
function fenglod115_Func011Func005002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="x")
endfunction
function fenglod115_Func011Func005002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func011Func005002 takes nothing returns boolean
return FYAnd(fenglod115_Func011Func005002001(),fenglod115_Func011Func005002002())
endfunction
function fenglod115_Func011C takes nothing returns boolean
return(FYAnd(fenglod115_Func011Func005001(),fenglod115_Func011Func005002()))
endfunction
function fenglod115_Func012Func005001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="s")
endfunction
function fenglod115_Func012Func005002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="x")
endfunction
function fenglod115_Func012Func005002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func012Func005002 takes nothing returns boolean
return FYAnd(fenglod115_Func012Func005002001(),fenglod115_Func012Func005002002())
endfunction
function fenglod115_Func012C takes nothing returns boolean
return(FYAnd(fenglod115_Func012Func005001(),fenglod115_Func012Func005002()))
endfunction
function fenglod115_Func013Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="l")
endfunction
function fenglod115_Func013Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="l")
endfunction
function fenglod115_Func013Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func013Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func013Func003002001(),fenglod115_Func013Func003002002())
endfunction
function fenglod115_Func013C takes nothing returns boolean
return(FYAnd(fenglod115_Func013Func003001(),fenglod115_Func013Func003002()))
endfunction
function fenglod115_Func014Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="m")
endfunction
function fenglod115_Func014Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="j")
endfunction
function fenglod115_Func014Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func014Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func014Func003002001(),fenglod115_Func014Func003002002())
endfunction
function fenglod115_Func014C takes nothing returns boolean
return(FYAnd(fenglod115_Func014Func003001(),fenglod115_Func014Func003002()))
endfunction
function fenglod115_Func015Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="z")
endfunction
function fenglod115_Func015Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="l")
endfunction
function fenglod115_Func015Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="-")
endfunction
function fenglod115_Func015Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func015Func003002001(),fenglod115_Func015Func003002002())
endfunction
function fenglod115_Func015C takes nothing returns boolean
return(FYAnd(fenglod115_Func015Func003001(),fenglod115_Func015Func003002()))
endfunction
function fenglod115_Func016Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="l")
endfunction
function fenglod115_Func016Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="l")
endfunction
function fenglod115_Func016Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func016Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func016Func003002001(),fenglod115_Func016Func003002002())
endfunction
function fenglod115_Func016C takes nothing returns boolean
return(FYAnd(fenglod115_Func016Func003001(),fenglod115_Func016Func003002()))
endfunction
function fenglod115_Func017Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="m")
endfunction
function fenglod115_Func017Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="j")
endfunction
function fenglod115_Func017Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func017Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func017Func003002001(),fenglod115_Func017Func003002002())
endfunction
function fenglod115_Func017C takes nothing returns boolean
return(FYAnd(fenglod115_Func017Func003001(),fenglod115_Func017Func003002()))
endfunction
function fenglod115_Func018Func003001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="z")
endfunction
function fenglod115_Func018Func003002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="l")
endfunction
function fenglod115_Func018Func003002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="+")
endfunction
function fenglod115_Func018Func003002 takes nothing returns boolean
return FYAnd(fenglod115_Func018Func003002001(),fenglod115_Func018Func003002002())
endfunction
function fenglod115_Func018C takes nothing returns boolean
return(FYAnd(fenglod115_Func018Func003001(),fenglod115_Func018Func003002()))
endfunction
function SUnitAFY takes player whichPlayer returns group
local group g=CreateGroup()
call SyncSelections()
call GroupEnumUnitsSelected(g,whichPlayer,null)
return g
endfunction
function CUALFY takes player id,integer unitid,location loc,real face returns unit
if(unitid=='ugol')then
set fy_lastCreatedUnit=CreateBlightedGoldmine(id,GetLocationX(loc),GetLocationY(loc),face)
else
set fy_lastCreatedUnit=CreateUnitAtLoc(id,unitid,loc,face)
endif
return fy_lastCreatedUnit
endfunction
function CNAFY takes integer count,integer unitId,player whichPlayer,location loc,real face returns group
call GroupClear(fy_lastCreatedGroup)
loop
set count=count-1
exitwhen count<0
call CUALFY(whichPlayer,unitId,loc,face)
call GroupAddUnit(fy_lastCreatedGroup,fy_lastCreatedUnit)
endloop
return fy_lastCreatedGroup
endfunction
function fenglod115_Actions takes nothing returns nothing
set fenglodzfc=GetEventPlayerChatString()
if(fenglod115_Func003C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
if(fenglod115_Func004C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(fenglod115_Func005C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(fenglod115_Func006C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endif
if(fenglod115_Func007C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(fenglod115_Func008C())then
set fenglodzy=S2I(SubStringFY(fenglodzfc,5,11))
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodzy),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endif
if(fenglod115_Func009C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call SetHeroLevel(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodsx),false)
endif
if(fenglod115_Func010C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call UnitStripHeroLevel(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],fenglodsx)
endif
if(fenglod115_Func011C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(0,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
call AllStatFY(1,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
call AllStatFY(2,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
endif
if(fenglod115_Func012C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(0,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
call AllStatFY(1,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
call AllStatFY(2,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
endif
if(fenglod115_Func013C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(0,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
endif
if(fenglod115_Func014C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(1,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
endif
if(fenglod115_Func015C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(2,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],1,fenglodsx)
endif
if(fenglod115_Func016C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(0,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
endif
if(fenglod115_Func017C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(1,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
endif
if(fenglod115_Func018C())then
set fenglodsx=S2I(SubStringFY(fenglodzfc,5,20))
call AllStatFY(2,fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))],0,fenglodsx)
endif
if(fenglod115_Func019C())then
set fenglodzfc=SubStringFY(fenglodzfc,5,8)
set fenglodtszs=fenglodID2(fenglodzfc)
call ForGroup(SUnitAFY(GetTriggerPlayer()),function fenglod115_Func008Func003A)
endif
if(fenglod115_Func002Func004821())then
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwsz2))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[1]))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[2]))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[3]))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[4]))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[5]))
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,15.,fenglodID(fenglodwp[6]))
endif
if(fenglod115_Func002Func003C())then
set fenglodzfc=SubStringFY(fenglodzfc,5,8)
call CNAFY(1,fenglodID2(fenglodzfc),GetTriggerPlayer(),GetUnitLoc(fengloddw1),fy_UNIT_FACING)
call UnitAddAbility(fy_lastCreatedUnit,'AInv')
endif
endfunction
function fenglod116_Func001001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),2,2)=="1")
endfunction
function fenglod116_Func001002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),4,4)=="i")
endfunction
function fenglod116_Func001002002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),5,5)=="u")
endfunction
function fenglod116_Func001002002002001 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),3,3)=="n")
endfunction
function fenglod116_Func001002002002002 takes nothing returns boolean
return(SubStringFY(GetEventPlayerChatString(),6,6)=="x")
endfunction
function fenglod116_Func001002002002 takes nothing returns boolean
return FYAnd(fenglod116_Func001002002002001(),fenglod116_Func001002002002002())
endfunction
function fenglod116_Func001002002 takes nothing returns boolean
return FYAnd(fenglod116_Func001002002001(),fenglod116_Func001002002002())
endfunction
function fenglod116_Func001002 takes nothing returns boolean
return FYAnd(fenglod116_Func001002001(),fenglod116_Func001002002())
endfunction
function fenglod116_Conditions takes nothing returns boolean
return(FYAnd(fenglod116_Func001001(),fenglod116_Func001002()))
endfunction
function fenglod116_Actions takes nothing returns nothing
set fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))]=true
call DisableTrigger(fenglod116)
endfunction
function fenglod117_Conditions takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function fenglod117_Actions takes nothing returns nothing
set fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]=null
set fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]=GetTriggerUnit()
endfunction
function fenglod118_Func006001 takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function S2OFY takes string orderIdString returns integer
local integer orderId
set orderId=OrderId(orderIdString)
if(orderId!=0)then
return orderId
endif
set orderId=UnitId(orderIdString)
if(orderId!=0)then
return orderId
endif
return 0
endfunction
function fenglod118_Func006002 takes nothing returns boolean
return(GetIssuedOrderId()==S2OFY("Move"))
endfunction
function fenglod118_Conditions takes nothing returns boolean
return(FYAnd(fenglod118_Func006001(),fenglod118_Func006002()))
endfunction
function SetTextTagPosFY takes texttag tt,location loc,real zOffset returns nothing
call SetTextTagPos(tt,GetLocationX(loc),GetLocationY(loc),zOffset)
endfunction
function PTIFY takes real percentage,integer max returns integer
local integer result=R2I(percentage*I2R(max)*.01)
if(result<0)then
set result=0
elseif(result>max)then
set result=max
endif
return result
endfunction
function FY255 takes real percentage returns integer
return PTIFY(percentage,255)
endfunction
function SetTextTagColorFY takes texttag tt,real red,real green,real blue,real transparency returns nothing
call SetTextTagColor(tt,FY255(red),FY255(green),FY255(blue),FY255(100.-transparency))
endfunction
function SetTextTagTextFY takes texttag tt, string s, real size returns nothing
local real textHeight=size*0.023/10
call SetTextTagText(tt,s,textHeight)
endfunction
function CreateTextTagLocFY takes string s,location loc,real zOffset,real size,real red,real green,real blue,real transparency returns texttag
set fy_lastCreatedTextTag=CreateTextTag()
call SetTextTagTextFY(fy_lastCreatedTextTag,s,size)
call SetTextTagPosFY(fy_lastCreatedTextTag,loc,zOffset)
call SetTextTagColorFY(fy_lastCreatedTextTag,red,green,blue,transparency)
return fy_lastCreatedTextTag
endfunction
function SetTVCFY takes texttag tt,real speed,real angle returns nothing
local real vel=speed*.071/ 128
local real xvel=vel*Cos(angle*fy_DEGTORAD)
local real yvel=vel*Sin(angle*fy_DEGTORAD)
call SetTextTagVelocity(tt,xvel,yvel)
endfunction
function fenglod118_Actions takes nothing returns nothing
call CreateTextTagLocFY(("|cFFBF1066瞬|cFFFFFF00间|r"+"|cFF1BE6B8移|cFFC6A7A2动|r"),GetOrderPointLoc(),0,20.,'d','d','d',0)
call SetTextTagPermanent(fy_lastCreatedTextTag,false)
call SetTextTagLifespan(fy_lastCreatedTextTag,3.)
call SetTVCFY(fy_lastCreatedTextTag,64,GetRandomReal(0,360))
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function fenglod119_Conditions takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function fenglod119_Func003C takes nothing returns boolean
return(fenglodwjzs[(1+GetPlayerId(GetTriggerPlayer()))]==5)
endfunction
function fenglod119_Actions takes nothing returns nothing
set fenglodwjzs[(1+GetPlayerId(GetTriggerPlayer()))]=(fenglodwjzs[(1+GetPlayerId(GetTriggerPlayer()))]+1)
if(fenglod119_Func003C())then
if TriggerEvaluate(fenglod123)then
call TriggerExecute(fenglod123)
endif
endif
call TriggerSleepAction(2.)
set fenglodwjzs[(1+GetPlayerId(GetTriggerPlayer()))]=0
endfunction
function fenglod120_Actions takes nothing returns nothing
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endfunction
function fenglod121_Actions takes nothing returns nothing
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodmu),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodmu),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endfunction
function KeyFY takes trigger trig,player whichPlayer,integer keType,integer keKey returns event
if(keType==fy_KEYEVENTTYPE_DEPRESS)then
if(keKey==fy_KEYEVENTKEY_LEFT)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_LEFT_DOWN)
elseif(keKey==fy_KEYEVENTKEY_RIGHT)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_RIGHT_DOWN)
elseif(keKey==fy_KEYEVENTKEY_DOWN)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_DOWN_DOWN)
elseif(keKey==fy_KEYEVENTKEY_UP)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_UP_DOWN)
else
return null
endif
elseif(keType==fy_KEYEVENTTYPE_RELEASE)then
if(keKey==fy_KEYEVENTKEY_LEFT)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_LEFT_UP)
elseif(keKey==fy_KEYEVENTKEY_RIGHT)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_RIGHT_UP)
elseif(keKey==fy_KEYEVENTKEY_DOWN)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_DOWN_UP)
elseif(keKey==fy_KEYEVENTKEY_UP)then
return TriggerRegisterPlayerEvent(trig,whichPlayer,EVENT_PLAYER_ARROW_UP_UP)
else
return null
endif
else
return null
endif
endfunction
function fenglod122_Actions takes nothing returns nothing
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,120.,"|cFFFF0000有|cFFFA0105你|cFFF60209们|cFFF1040E的|cFFEC0513支|cFFE70618持|cFFE3071C,|cFFDE0821我|cFFD90A26们|cFFD40B2A才|cFFD00C2F能|cFFCB0D34做|cFFC60E39得|cFFC2103D更|cFFBD1142好|cFFB81247.|cFFB3134C.|cFFAF1450.|cFFAA1655.|cFFA5175A更|cFFA1185E多|cFF9C1963魔|cFF971A68兽|cFF921C6D地|cFF8E1D71图|cFF891E76请|cFF841F7B登|cFF7F2080陆|cFF7B2284:|cFF762389h|cFF71248Et|cFF6D2592t|cFF682797p|cFF63289C:|cFF5E29A1/|cFF5A2AA5/|cFF552BAAb|cFF502DAFb|cFF4C2EB3s|cFF472FB8.|cFF4230BD9|cFF3D31C21|cFF3933C6n|cFF3434CBi|cFF2F35D0u|cFF2A36D5x|cFF2637D9.|cFF2139DEc|cFF1C3AE3o|cFF183BE7m|cFF133CEC/|cFF0E3DF1下|cFF093FF6载|r")
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
call KeyFY(fenglod121,Player(-1+(fy_forLoopAIndex)),0,2)
call KeyFY(fenglod120,Player(-1+(fy_forLoopAIndex)),0,3)
call TriggerRegisterPlayerEvent(fenglod119,Player(-1+(fy_forLoopAIndex)),EVENT_PLAYER_END_CINEMATIC)
call TriggerRegisterPlayerUnitEvent(fenglod117,Player(-1+(fy_forLoopAIndex)),EVENT_PLAYER_UNIT_SELECTED,null)
call TriggerRegisterPlayerChatEvent(fenglod116,Player(-1+(fy_forLoopAIndex)),"9",false)
call TriggerRegisterPlayerChatEvent(fenglod115,Player(-1+(fy_forLoopAIndex)),"/",false)
call TriggerRegisterPlayerUnitEvent(fenglod139,Player(-1+(fy_forLoopAIndex)),EVENT_PLAYER_UNIT_SELECTED,null)
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
endfunction
function fenglod123_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="烽火奇遇"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fenglodanniu['d']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFFFF0000玩家作弊管理|r"+""))
set fenglodanniu['e']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFF1BE6B8剔除玩家|r"+""))
set fenglodanniu['f']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFF7DBEF1资源菜单|r"+""))
set fenglodanniu['g']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFFCCFFCC辅助菜单|r"+""))
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod124_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="烽火奇遇")
endfunction
function fenglod124_Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['e'])
endfunction
function fenglod124_Func002C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['d'])
endfunction
function fenglod124_Func003C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['f'])
endfunction
function fenglod124_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['g'])
endfunction
function fenglod124_Actions takes nothing returns nothing
if(fenglod124_Func001C())then
if TriggerEvaluate(fenglod111)then
call TriggerExecute(fenglod111)
endif
return
endif
if(fenglod124_Func002C())then
if TriggerEvaluate(fenglod113)then
call TriggerExecute(fenglod113)
endif
return
endif
if(fenglod124_Func003C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fenglodanniu['h']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("自动加钱"+""))
set fenglodanniu['i']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("自动加木"+""))
set fenglodanniu['j']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("自动清理人口"+""))
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
if(fenglod124_Func004C())then
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="高级功能"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fenglodanniu['k']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("自动恢复"+""))
set fenglodanniu['l']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("复制物品"+""))
set fenglodanniu['m']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("复制单位"+""))
set fenglodanniu['n']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("杀死单位"+""))
set fenglodanniu['o']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("杀人加属性"+""))
set fenglodanniu['p']=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("十倍经验"+""))
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function GETPtFY takes unit whichUnit,unitstate whichState,unitstate whichMaxState returns real
local real value=GetUnitState(whichUnit,whichState)
local real maxValue=GetUnitState(whichUnit,whichMaxState)
if(whichUnit==null)or(maxValue==0)then
return .0
endif
return value/ maxValue*100.
endfunction
function ManaFY takes unit whichUnit returns real
return GETPtFY(whichUnit,UNIT_STATE_MANA,UNIT_STATE_MAX_MANA)
endfunction
function LifeFY takes unit whichUnit returns real
return GETPtFY(whichUnit,UNIT_STATE_LIFE,UNIT_STATE_MAX_LIFE)
endfunction
function fenglod125_Conditions takes nothing returns boolean
return(fenglodbrzwj[(1+GetPlayerId(GetTriggerPlayer()))])
endfunction
function fenglod125_Func002Func006001 takes nothing returns boolean
return(ManaFY(GetEnumUnit())<=20.)
endfunction
function fenglod125_Func002Func007001 takes nothing returns boolean
return(LifeFY(GetEnumUnit())<=20.)
endfunction
function UBFFY takes integer buffType,unit whichUnit returns nothing
if(buffType==fy_REMOVEBUFFS_POSITIVE)then
call UnitRemoveBuffs(whichUnit,true,false)
elseif(buffType==fy_REMOVEBUFFS_NEGATIVE)then
call UnitRemoveBuffs(whichUnit,false,true)
elseif(buffType==fy_REMOVEBUFFS_ALL)then
call UnitRemoveBuffs(whichUnit,true,true)
elseif(buffType==fy_REMOVEBUFFS_NONTLIFE)then
call UnitRemoveBuffsEx(whichUnit,true,true,false,false,false,true,false)
endif
endfunction
function GetUnitStateSwapFY takes unitstate whichState,unit whichUnit returns real
return GetUnitState(whichUnit,whichState)
endfunction
function RMaxFY takes real a,real b returns real
if(a<b)then
return b
else
return a
endif
endfunction
function ManaPFY takes unit whichUnit,real percent returns nothing
call SetUnitState(whichUnit,UNIT_STATE_MANA,GetUnitState(whichUnit,UNIT_STATE_MAX_MANA)*RMaxFY(0,percent)*.01)
endfunction
function LifePFY takes unit whichUnit,real percent returns nothing
call SetUnitState(whichUnit,UNIT_STATE_LIFE,GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)*RMaxFY(0,percent)*.01)
endfunction
function fenglod125_Func002A takes nothing returns nothing
call UBFFY(1,GetEnumUnit())
call UnitResetCooldown(GetEnumUnit())
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call SetWidgetLife(GetEnumUnit(),(GetUnitStateSwapFY(UNIT_STATE_LIFE,GetEnumUnit())+(GetUnitStateSwapFY(UNIT_STATE_MAX_LIFE,GetEnumUnit())*.05)))
call SetUnitState(GetEnumUnit(),UNIT_STATE_MANA,(GetUnitStateSwapFY(UNIT_STATE_MANA,GetEnumUnit())+(GetUnitStateSwapFY(UNIT_STATE_MAX_MANA,GetEnumUnit())*.05)))
if(fenglod125_Func002Func006001())then
call ManaPFY(GetEnumUnit(),'d')
endif
if(fenglod125_Func002Func007001())then
call LifePFY(GetEnumUnit(),'d')
endif
endfunction
function MCHFY takes player whichPlayer,boolexpr filter returns group
local group g=CreateGroup()
call GroupEnumUnitsOfPlayer(g,whichPlayer,filter)
call DestroyBoolExpr(filter)
return g
endfunction
function fenglod125_Actions takes nothing returns nothing
call ForGroup(MCHFY(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),null),function fenglod125_Func002A)
endfunction
function fenglod126_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="自动加钱")
endfunction
function fenglod126_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[fy_forLoopAIndex])
endfunction
function fenglod126_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[13])
endfunction
function fenglod126_Actions takes nothing returns nothing
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
if(fenglod126_Func003Func001C())then
call EnableTrigger(fenglod127)
return
endif
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
if(fenglod126_Func004C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=7
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function fenglod127_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="自动加钱")
endfunction
function fenglod127_Actions takes nothing returns nothing
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_GOLD)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_GOLD_GATHERED)
endfunction
function fenglod128_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="自动加木")
endfunction
function fenglod128_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[fy_forLoopAIndex])
endfunction
function fenglod128_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[13])
endfunction
function fenglod128_Actions takes nothing returns nothing
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
if(fenglod128_Func003Func001C())then
call EnableTrigger(fenglod129)
return
endif
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
if(fenglod128_Func004C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=7
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function fenglod129_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="自动加木")
endfunction
function fenglod129_Actions takes nothing returns nothing
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))+fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_LUMBER)
call AddStateFY(((1+GetPlayerId(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))])))-fenglodqian),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_LUMBER_GATHERED)
endfunction
function fenglod130_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="自动加钱"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFFFF0000自动帮"+(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+"加钱5000|r")))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("下一页"+""))
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod131_Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['h'])
endfunction
function fenglod131_Func002C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['i'])
endfunction
function fenglod131_Actions takes nothing returns nothing
if(fenglod131_Func001C())then
if TriggerEvaluate(fenglod130)then
call TriggerExecute(fenglod130)
endif
return
endif
if(fenglod131_Func002C())then
if TriggerEvaluate(fenglod132)then
call TriggerExecute(fenglod132)
endif
return
endif
endfunction
function fenglod132_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="自动加木"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFFFF0000自动帮"+(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+"加木200|r")))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("下一页"+""))
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod133_Actions takes nothing returns nothing
set fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]="自动清人口"
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("|cFFFF0000自动帮"+(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+"清除人口|r")))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
set fenglodanniu[13]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("下一页"+""))
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endfunction
function fenglod134_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="清除人口")
endfunction
function fenglod134_Func003Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[fy_forLoopAIndex])
endfunction
function fenglod134_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu[13])
endfunction
function fenglod134_Actions takes nothing returns nothing
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
if(fenglod134_Func003Func001C())then
call EnableTrigger(fenglod135)
return
endif
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
if(fenglod134_Func004C())then
call DialogClear(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))])
call DialogSetMessage(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("bbs.91niux.com"+""))
set fy_forLoopAIndex=7
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
set fenglodanniu[fy_forLoopAIndex]=DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],(GetPlayerName(Player(-1+(fy_forLoopAIndex)))+""))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
call DialogAddButtonFY(fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],("开始游戏"+""))
call DialogDisplayFY(true,fengloddhk[(1+GetPlayerId(GetTriggerPlayer()))],GetTriggerPlayer())
endif
endfunction
function fenglod135_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="自动清人口")
endfunction
function SETDATFY takes player whichPlayer,playerstate whichPlayerState,integer value returns nothing
local integer oldValue=GetPlayerState(whichPlayer,whichPlayerState)
call AddStateFY(value-oldValue,whichPlayer,whichPlayerState)
endfunction
function fenglod135_Actions takes nothing returns nothing
call SETDATFY(GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),PLAYER_STATE_RESOURCE_FOOD_USED,0)
endfunction
function fenglod136_Conditions takes nothing returns boolean
return(fengloddhzfc[(1+GetPlayerId(GetTriggerPlayer()))]=="高级功能")
endfunction
function fenglod136_Func001C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['k'])
endfunction
function fenglod136_Func002C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['l'])
endfunction
function fenglod136_Func003C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['m'])
endfunction
function fenglod136_Func004C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['n'])
endfunction
function fenglod136_Func005C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['o'])
endfunction
function fenglod136_Func006C takes nothing returns boolean
return(GetClickedButton()==fenglodanniu['p'])
endfunction
function CreateItemLocFY takes integer itemId,location loc returns item
set fy_lastCreatedItem=CreateItem(itemId,GetLocationX(loc),GetLocationY(loc))
return fy_lastCreatedItem
endfunction
function fenglod136_Actions takes nothing returns nothing
if(fenglod136_Func001C())then
call EnableTrigger(fenglod125)
return
endif
if(fenglod136_Func002C())then
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=6
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
call CreateItemLocFY(GetItemTypeId(UnitItemInSlotFY(GetTriggerUnit(),fy_forLoopAIndex)),GetUnitLoc(GetTriggerUnit()))
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
return
endif
if(fenglod136_Func003C())then
call CNAFY(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(fengloddwz[(1+GetPlayerId(GetTriggerPlayer()))]),GetUnitLoc(GetTriggerUnit()),fy_UNIT_FACING)
return
endif
if(fenglod136_Func004C())then
call KillUnit(GetTriggerUnit())
return
endif
if(fenglod136_Func005C())then
set fenglodsrjsx[(1+GetPlayerId(GetTriggerPlayer()))]=GetKillingUnit()
return
endif
if(fenglod136_Func006C())then
set fy_forLoopAIndex=1
set fy_forLoopAIndexEnd=12
loop
exitwhen fy_forLoopAIndex>fy_forLoopAIndexEnd
call SetPlayerHandicapXP(Player(-1+(fy_forLoopAIndex)),10.)
set fy_forLoopAIndex=fy_forLoopAIndex+1
endloop
return
endif
endfunction
function fenglod137_Conditions takes nothing returns boolean
return(fenglodsrjsx[(1+GetPlayerId(GetTriggerPlayer()))]==GetKillingUnit())
endfunction
function fenglod137_Func003Func001C takes nothing returns boolean
return(fenglodcjzs==1)
endfunction
function fenglod137_Func003Func002C takes nothing returns boolean
return(fenglodcjzs==2)
endfunction
function fenglod137_Func003Func003C takes nothing returns boolean
return(fenglodcjzs==3)
endfunction
function fenglod137_Func003C takes nothing returns boolean
return(fenglodsrzs[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))]==150)
endfunction
function fenglod137_Actions takes nothing returns nothing
set fenglodsrzs[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))]=(fenglodsrzs[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))]+1)
set fenglodcjzs=GetRandomInt(1,3)
if(fenglod137_Func003C())then
if(fenglod137_Func003Func001C())then
call AllStatFY(0,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,50)
call AllStatFY(1,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,50)
call AllStatFY(2,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,50)
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,60.,(GetPlayerName(GetOwningPlayer(GetKillingUnit()))+"杀敌150人增加属性全属性50点!"))
endif
if(fenglod137_Func003Func002C())then
call AllStatFY(0,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,20)
call AllStatFY(1,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,20)
call AllStatFY(2,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,20)
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,60.,(GetPlayerName(GetOwningPlayer(GetKillingUnit()))+"杀敌150人增加属性全属性20点!"))
endif
if(fenglod137_Func003Func003C())then
call AllStatFY(0,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,'d')
call AllStatFY(1,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,'d')
call AllStatFY(2,fenglodsrjsx[(1+GetPlayerId(GetOwningPlayer(GetKillingUnit())))],0,'d')
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,60.,(GetPlayerName(GetOwningPlayer(GetKillingUnit()))+"杀敌150人增加属性全属性100点!"))
endif
endif
endfunction
function fenglod138_Actions takes nothing returns nothing
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,300.,"|cFFFF0000有|cFFFA0105你|cFFF60209们|cFFF1040E的|cFFEC0513支|cFFE70618持|cFFE3071C,|cFFDE0821我|cFFD90A26们|cFFD40B2A才|cFFD00C2F能|cFFCB0D34做|cFFC60E39得|cFFC2103D更|cFFBD1142好|cFFB81247.|cFFB3134C.|cFFAF1450.|cFFAA1655.|cFFA5175A更|cFFA1185E多|cFF9C1963魔|cFF971A68兽|cFF921C6D地|cFF8E1D71图|cFF891E76请|cFF841F7B登|cFF7F2080陆|cFF7B2284:|cFF762389h|cFF71248Et|cFF6D2592t|cFF682797p|cFF63289C:|cFF5E29A1/|cFF5A2AA5/|cFF552BAAb|cFF502DAFb|cFF4C2EB3s|cFF472FB8.|cFF4230BD9|cFF3D31C21|cFF3933C6n|cFF3434CBi|cFF2F35D0u|cFF2A36D5x|cFF2637D9.|cFF2139DEc|cFF1C3AE3o|cFF183BE7m|cFF133CEC/|cFF0E3DF1下|cFF093FF6载|r")
call DisplayTimedTextToForceFY(fy_FORCE_ALL_PLAYERS,300.,fenglodzfc)
endfunction
function TrigFY takes trigger trig,playerunitevent whichEvent returns nothing
local integer index
set index=0
loop
call TriggerRegisterPlayerUnitEvent(trig,Player(index),whichEvent,null)
set index=index+1
exitwhen index==fy_MAX_PLAYER_SLOTS
endloop
endfunction
function TrigTFY takes trigger trig,real timeout returns event
return TriggerRegisterTimerEvent(trig,timeout,false)
endfunction
function TrigTfFY takes trigger trig,real timeout returns event
return TriggerRegisterTimerEvent(trig,timeout,true)
endfunction
function fenglod91niux takes nothing returns nothing
local integer i
call InitCJFY()
set i=0
set i=0
loop
exitwhen(i>1)
set fengloddhzfc[i]=""
set fenglodsrzs[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>12)
set fengloddhk[i]=DialogCreate()
set fenglodbrzwj[i]=false
set fenglodwjzs[i]=0
set i=i+1
endloop
call TriggerAddCondition(fenglod139,Condition(function fenglod139_Conditions))
call TriggerAddAction(fenglod139,function fenglod139_Actions)
call TriggerAddAction(fenglod111,function fenglod111_Actions)
call TriggerRegisterDialogEvent(fenglod112,fengloddhk[1])
call TriggerAddCondition(fenglod112,Condition(function fenglod112_Conditions))
call TriggerAddAction(fenglod112,function fenglod112_Actions)
call TriggerAddAction(fenglod113,function fenglod113_Actions)
call TriggerRegisterDialogEvent(fenglod114,fengloddhk[1])
call TriggerAddCondition(fenglod114,Condition(function fenglod114_Conditions))
call TriggerAddAction(fenglod114,function fenglod114_Actions)
call TriggerAddCondition(fenglod115,Condition(function fenglod115_Conditions))
call TriggerAddAction(fenglod115,function fenglod115_Actions)
call TriggerAddCondition(fenglod116,Condition(function fenglod116_Conditions))
call TriggerAddAction(fenglod116,function fenglod116_Actions)
call TriggerAddCondition(fenglod117,Condition(function fenglod117_Conditions))
call TriggerAddAction(fenglod117,function fenglod117_Actions)
call TrigFY(fenglod118,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(fenglod118,Condition(function fenglod118_Conditions))
call TriggerAddAction(fenglod118,function fenglod118_Actions)
call TriggerAddCondition(fenglod119,Condition(function fenglod119_Conditions))
call TriggerAddAction(fenglod119,function fenglod119_Actions)
call TriggerAddAction(fenglod120,function fenglod120_Actions)
call TriggerAddAction(fenglod121,function fenglod121_Actions)
call TrigTFY(fenglod122,.0)
call TriggerAddAction(fenglod122,function fenglod122_Actions)
call TriggerAddAction(fenglod123,function fenglod123_Actions)
call TriggerRegisterDialogEvent(fenglod124,fengloddhk[1])
call TriggerAddCondition(fenglod124,Condition(function fenglod124_Conditions))
call TriggerAddAction(fenglod124,function fenglod124_Actions)
call DisableTrigger(fenglod125)
call TrigTfFY(fenglod125,.5)
call TriggerAddCondition(fenglod125,Condition(function fenglod125_Conditions))
call TriggerAddAction(fenglod125,function fenglod125_Actions)
call TriggerRegisterDialogEvent(fenglod126,fengloddhk[1])
call TriggerAddCondition(fenglod126,Condition(function fenglod126_Conditions))
call TriggerAddAction(fenglod126,function fenglod126_Actions)
call DisableTrigger(fenglod127)
call TrigTfFY(fenglod127,60.)
call TriggerAddCondition(fenglod127,Condition(function fenglod127_Conditions))
call TriggerAddAction(fenglod127,function fenglod127_Actions)
call TriggerRegisterDialogEvent(fenglod128,fengloddhk[1])
call TriggerAddCondition(fenglod128,Condition(function fenglod128_Conditions))
call TriggerAddAction(fenglod128,function fenglod128_Actions)
call DisableTrigger(fenglod129)
call TrigTfFY(fenglod129,60.)
call TriggerAddCondition(fenglod129,Condition(function fenglod129_Conditions))
call TriggerAddAction(fenglod129,function fenglod129_Actions)
call TriggerAddAction(fenglod130,function fenglod130_Actions)
call TriggerRegisterDialogEvent(fenglod131,fengloddhk[1])
call TriggerAddAction(fenglod131,function fenglod131_Actions)
call TriggerAddAction(fenglod132,function fenglod132_Actions)
call TriggerAddAction(fenglod133,function fenglod133_Actions)
call TriggerRegisterDialogEvent(fenglod134,fengloddhk[1])
call TriggerAddCondition(fenglod134,Condition(function fenglod134_Conditions))
call TriggerAddAction(fenglod134,function fenglod134_Actions)
call DisableTrigger(fenglod135)
call TrigTfFY(fenglod135,60.)
call TriggerAddCondition(fenglod135,Condition(function fenglod135_Conditions))
call TriggerAddAction(fenglod135,function fenglod135_Actions)
call TriggerRegisterDialogEvent(fenglod136,fengloddhk[1])
call TriggerAddCondition(fenglod136,Condition(function fenglod136_Conditions))
call TriggerAddAction(fenglod136,function fenglod136_Actions)
call TrigFY(fenglod137,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(fenglod137,Condition(function fenglod137_Conditions))
call TriggerAddAction(fenglod137,function fenglod137_Actions)
call TrigTfFY(fenglod138,600.)
call TriggerAddAction(fenglod138,function fenglod138_Actions)
endfunction