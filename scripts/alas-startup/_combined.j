globals
// No globals required.

endglobals
//============================================================================
// ALAS EQUIPMENT - unified startup acknowledgement
//============================================================================
function ALAS_StartupMessage takes nothing returns nothing
    call DisplayTimedTextToPlayer(Player(0), 0, 0, 18.0, "|cff00ff00[ALAS 装备系统]|r 已加载：物品/技能浏览器、四翼、阿克蒙德之手、霜之哀伤、埃辛诺斯战刃。")
endfunction

function main takes nothing returns nothing
call ALAS_StartupMessage()

endfunction
