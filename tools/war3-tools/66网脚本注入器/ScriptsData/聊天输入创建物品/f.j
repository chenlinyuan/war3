function DebugIdInteger2IdString takes integer value returns string
local string charMap="..................................!.#$&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
local string result=""
local integer remainingValue=value
local integer charValue
local integer byteno
set byteno=0
loop
set charValue=ModuloInteger(remainingValue,256)
set remainingValue=remainingValue/ 256
set result=SubString(charMap,charValue,charValue+1)+result
set byteno=byteno+1
exitwhen byteno==4
endloop
return result
endfunction
function debugS2I takes string targetstr returns integer
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
function Trig_CreateItem_Actions takes nothing returns nothing
set udg_TS=GetEventPlayerChatString()
set udg_uu=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
set udg_Nn=debugS2I(udg_TS)
call UnitAddItemByIdSwapped(udg_Nn,udg_uu)
endfunction