//============================================================================
// ITEM BROWSER - 装备搜索与添加系统
// 作者: chenlinyuan (war3 mod 项目)
// 功能:
//   输入 "search <关键词>"  搜索名称包含关键词的装备
//   输入 "additem <名称>"   添加装备给当前选中的英雄（背包满则掉地上）
//   输入 "additem <名称> n" 添加 n 个
//   输入 "itembrowser"      显示帮助
//
// 说明:
//   - 物品 ID 列表在注入时预先扫描并硬编码，进游戏立即可用（无需枚举）
//   - 支持中文名称匹配（不区分大小写）
//============================================================================

//---------------------------------------------------------------------------
// [工具] ASCII 转小写（仅处理 A-Z，不动中文等多字节字符）
// 注意：不能用 StringCase，它会把 GBK 中文字节也改写导致乱码
//---------------------------------------------------------------------------
function IB_LowerAscii takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "A" then
            set ch = "a"
        elseif ch == "B" then
            set ch = "b"
        elseif ch == "C" then
            set ch = "c"
        elseif ch == "D" then
            set ch = "d"
        elseif ch == "E" then
            set ch = "e"
        elseif ch == "F" then
            set ch = "f"
        elseif ch == "G" then
            set ch = "g"
        elseif ch == "H" then
            set ch = "h"
        elseif ch == "I" then
            set ch = "i"
        elseif ch == "J" then
            set ch = "j"
        elseif ch == "K" then
            set ch = "k"
        elseif ch == "L" then
            set ch = "l"
        elseif ch == "M" then
            set ch = "m"
        elseif ch == "N" then
            set ch = "n"
        elseif ch == "O" then
            set ch = "o"
        elseif ch == "P" then
            set ch = "p"
        elseif ch == "Q" then
            set ch = "q"
        elseif ch == "R" then
            set ch = "r"
        elseif ch == "S" then
            set ch = "s"
        elseif ch == "T" then
            set ch = "t"
        elseif ch == "U" then
            set ch = "u"
        elseif ch == "V" then
            set ch = "v"
        elseif ch == "W" then
            set ch = "w"
        elseif ch == "X" then
            set ch = "x"
        elseif ch == "Y" then
            set ch = "y"
        elseif ch == "Z" then
            set ch = "z"
        endif
        set result = result + ch
        set i = i + 1
    endloop
    return result
endfunction

//---------------------------------------------------------------------------
// [工具] 字符串不区分大小写比较（仅 ASCII 转小写，不动中文）
//---------------------------------------------------------------------------
function IB_StrEqCI takes string a, string b returns boolean
    return IB_LowerAscii(a) == IB_LowerAscii(b)
endfunction

//---------------------------------------------------------------------------
// [工具] 发送消息给玩家
//---------------------------------------------------------------------------
function IB_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ff00[装备]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [工具] 布尔转字符串（诊断用）
//---------------------------------------------------------------------------
function IB_BoolStr takes boolean b returns string
    if b then
        return "true"
    endif
    return "false"
endfunction

//---------------------------------------------------------------------------
// [工具] 获取物品显示名：直接返回预扫描名称（已去颜色码）
//---------------------------------------------------------------------------
function IB_ItemName takes integer index returns string
    return ib_itemName[index]
endfunction

//---------------------------------------------------------------------------
// [工具] 单个字节 -> 字符（可打印 ASCII 原样，否则 .）
//---------------------------------------------------------------------------
function IB_Char takes integer c returns string
    if c >= 32 and c <= 126 then
        return SubString(" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", c - 32, c - 31)
    endif
    return "."
endfunction

//---------------------------------------------------------------------------
// [工具] 把物品 ID（FourCC 整数）转成 4 字符字符串，用于区分同名物品
//---------------------------------------------------------------------------
function IB_IdStr takes integer id returns string
    local integer b0 = id - (id / 256) * 256
    local integer b1 = (id / 256) - (id / 65536) * 256
    local integer b2 = (id / 65536) - (id / 16777216) * 256
    local integer b3 = id / 16777216
    return IB_Char(b3) + IB_Char(b2) + IB_Char(b1) + IB_Char(b0)
endfunction

//---------------------------------------------------------------------------
// [工具] 判断名称是否包含关键词（逐字节直接比较，不做任何字符串重建）
// 预扫描时名称已去颜色码并转小写；此处只对 keyword 做 ASCII 转小写。
//---------------------------------------------------------------------------
function IB_NameMatch takes string name, string keyword returns boolean
    local string key = IB_LowerAscii(keyword)
    local integer nameLen = StringLength(name)
    local integer keyLen = StringLength(key)
    local integer i = 0
    local integer j
    local boolean matched

    if keyLen == 0 then
        return true
    endif
    if keyLen > nameLen then
        return false
    endif

    loop
        exitwhen i + keyLen > nameLen
        set j = 0
        set matched = true
        loop
            exitwhen j >= keyLen
            if SubString(name, i + j, i + j + 1) != SubString(key, j, j + 1) then
                set matched = false
                set j = keyLen
            endif
            set j = j + 1
        endloop
        if matched then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

//---------------------------------------------------------------------------
// [工具] 获取玩家当前选中的第一个单位
//---------------------------------------------------------------------------
function IB_GetSelectedUnit takes player p returns unit
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, p, null)
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    return u
endfunction

//---------------------------------------------------------------------------
// 搜索装备（分帧扫描：每帧处理 40 项，原版/自定义分开显示）
//---------------------------------------------------------------------------
function IB_SearchStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_searchIdx >= ib_itemCount or n >= 40
        if IB_NameMatch(IB_ItemName(ib_searchIdx), ib_searchKey) then
            set ib_searchFound = ib_searchFound + 1
            set name = IB_ItemName(ib_searchIdx) + "[" + IB_IdStr(ib_itemList[ib_searchIdx]) + "]"
            if ib_itemCustom[ib_searchIdx] == 1 then
                set ib_searchCusN = ib_searchCusN + 1
                if ib_searchCusN <= 15 then
                    set ib_searchCus = ib_searchCus + name + "  "
                endif
            else
                set ib_searchStdN = ib_searchStdN + 1
                if ib_searchStdN <= 15 then
                    set ib_searchStd = ib_searchStd + name + "  "
                endif
            endif
        endif
        set ib_searchIdx = ib_searchIdx + 1
        set n = n + 1
    endloop

    if ib_searchIdx >= ib_itemCount then
        call PauseTimer(ib_searchTimer)
        call DestroyTimer(ib_searchTimer)
        set ib_searchTimer = null
        if ib_searchFound == 0 then
            call IB_Message(ib_searchPlayer, "未找到包含 \"" + ib_searchKey + "\" 的装备")
        else
            call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[装备]|r 共找到 " + I2S(ib_searchFound) + " 件")
            if ib_searchStdN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaa原版(" + I2S(ib_searchStdN) + "):|r " + ib_searchStd)
            endif
            if ib_searchCusN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00自定义(" + I2S(ib_searchCusN) + "):|r " + ib_searchCus)
            endif
        endif
        set ib_searchPlayer = null
    endif
endfunction

function IB_Search takes player p, string keyword returns nothing
    call IB_Message(p, "搜索 \"" + keyword + "\" ...")
    set ib_searchIdx = 0
    set ib_searchFound = 0
    set ib_searchKey = keyword
    set ib_searchStd = ""
    set ib_searchCus = ""
    set ib_searchStdN = 0
    set ib_searchCusN = 0
    set ib_searchPlayer = p
    if ib_searchTimer != null then
        call PauseTimer(ib_searchTimer)
        call DestroyTimer(ib_searchTimer)
    endif
    set ib_searchTimer = CreateTimer()
    call TimerStart(ib_searchTimer, 0.01, true, function IB_SearchStep)
endfunction

//---------------------------------------------------------------------------
// 添加装备（分帧扫描：先精确/ID匹配，再包含匹配；避免超操作数上限）
//---------------------------------------------------------------------------
function IB_AddGive takes player p, integer itemId, integer count returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local item it
    local real x
    local real y
    local integer added = 0
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif
    set x = GetUnitX(u)
    set y = GetUnitY(u)
    loop
        exitwhen added >= count
        set it = CreateItem(itemId, x, y)
        if it != null then
            if not UnitAddItem(u, it) then
                call SetItemPosition(it, x, y)
            endif
            set added = added + 1
        endif
        set it = null
    endloop
    call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + IB_ItemName(ib_addFoundIdx) + "\"")
    set u = null
endfunction

function IB_AddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_addIdx >= ib_itemCount or n >= 40
        set name = IB_ItemName(ib_addIdx)
        // 精确匹配 或 ID 匹配（ID 需不区分大小写，因为 ib_addName 已被转小写）
        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then
            set ib_addFoundId = ib_itemList[ib_addIdx]
            set ib_addFoundIdx = ib_addIdx
            set ib_addIdx = ib_itemCount
        elseif ib_addFoundId == 0 then
            // 记录第一个包含匹配（继续扫描以优先找精确匹配）
            if IB_NameMatch(name, ib_addName) then
                set ib_addFoundId = ib_itemList[ib_addIdx]
                set ib_addFoundIdx = ib_addIdx
            endif
        endif
        set ib_addIdx = ib_addIdx + 1
        set n = n + 1
    endloop

    if ib_addIdx >= ib_itemCount then
        call PauseTimer(ib_addTimer)
        call DestroyTimer(ib_addTimer)
        set ib_addTimer = null
        if ib_addFoundId == 0 then
            call IB_Message(ib_addPlayer, "未找到装备 \"" + ib_addName + "\"")
        else
            call IB_AddGive(ib_addPlayer, ib_addFoundId, ib_addCount)
        endif
        set ib_addPlayer = null
    endif
endfunction

function IB_AddItem takes player p, string itemName, integer count returns nothing
    if count < 1 then
        set count = 1
    endif
    set ib_addIdx = 0
    set ib_addCount = count
    set ib_addName = IB_LowerAscii(itemName)
    set ib_addFoundId = 0
    set ib_addFoundIdx = -1
    set ib_addPlayer = p
    if ib_addTimer != null then
        call PauseTimer(ib_addTimer)
        call DestroyTimer(ib_addTimer)
    endif
    set ib_addTimer = CreateTimer()
    call TimerStart(ib_addTimer, 0.01, true, function IB_AddStep)
endfunction

//---------------------------------------------------------------------------
// 解析 additem 参数："名称" 或 "名称 数量"
//---------------------------------------------------------------------------
function IB_ParseAddItem takes player p, string arg returns nothing
    local integer len = StringLength(arg)
    local integer i = len
    local integer lastSpace = -1
    local string itemName
    local string numStr
    local integer count = 1
    local boolean isNum
    local string ch

    loop
        exitwhen i <= 0
        if SubString(arg, i - 1, i) == " " then
            set lastSpace = i - 1
            set i = 0
        endif
        set i = i - 1
    endloop

    if lastSpace > 0 then
        set numStr = SubString(arg, lastSpace + 1, len)
        set isNum = StringLength(numStr) > 0
        set i = 0
        loop
            exitwhen i >= StringLength(numStr)
            set ch = SubString(numStr, i, i + 1)
            if ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9" then
                // 数字
            else
                set isNum = false
                set i = StringLength(numStr)
            endif
            set i = i + 1
        endloop
        if isNum then
            set itemName = SubString(arg, 0, lastSpace)
            set count = S2I(numStr)
        else
            set itemName = arg
        endif
    else
        set itemName = arg
    endif

    call IB_AddItem(p, itemName, count)
endfunction

//---------------------------------------------------------------------------
// 诊断：统计匹配数（限制扫描数量，测试是否触发操作数上限）
//---------------------------------------------------------------------------
function IB_CountMatch takes player p, string keyword returns nothing
    local integer i = 0
    local integer found = 0
    local integer limit = 50
    local string out = ""
    loop
        exitwhen i >= ib_itemCount or i >= limit
        if IB_NameMatch(IB_ItemName(i), keyword) then
            set found = found + 1
            if found <= 5 then
                set out = out + I2S(i) + ":" + IB_ItemName(i) + "  "
            endif
        endif
        set i = i + 1
    endloop
    call DisplayTextToPlayer(p, 0, 0, "|cff00ff00[诊断]|r 扫描前" + I2S(limit) + "项 匹配数=" + I2S(found) + " 前5: " + out)
endfunction

//---------------------------------------------------------------------------
// 技能系统: 给选中英雄添加/移除技能
//---------------------------------------------------------------------------
function IB_SkillName takes integer idx returns string
    return ib_skillName[idx]
endfunction

// 实际添加技能到选中单位
function IB_SkillGive takes player p, integer abilId, integer level returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, abilId)
    call UnitMakeAbilityPermanent(u, true, abilId)
    if level > 1 then
        call SetUnitAbilityLevel(u, abilId, level)
    endif
    call IB_Message(p, "已添加技能 \"" + IB_SkillName(ib_skAddFoundIdx) + "\" [" + IB_IdStr(abilId) + "] 到 " + GetUnitName(u))
    set u = null
endfunction

// 添加技能: 分帧扫描找匹配
function IB_SkillAddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skAddIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skAddIdx)
        if name == ib_skAddName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skAddIdx]), ib_skAddName) then
            set ib_skAddFoundId = ib_skillList[ib_skAddIdx]
            set ib_skAddFoundIdx = ib_skAddIdx
            set ib_skAddIdx = ib_skillCount
        elseif ib_skAddFoundId == 0 then
            if IB_NameMatch(name, ib_skAddName) then
                set ib_skAddFoundId = ib_skillList[ib_skAddIdx]
                set ib_skAddFoundIdx = ib_skAddIdx
            endif
        endif
        set ib_skAddIdx = ib_skAddIdx + 1
        set n = n + 1
    endloop
    if ib_skAddIdx >= ib_skillCount then
        call PauseTimer(ib_skAddTimer)
        call DestroyTimer(ib_skAddTimer)
        set ib_skAddTimer = null
        if ib_skAddFoundId == 0 then
            call IB_Message(ib_skAddPlayer, "未找到技能 \"" + ib_skAddName + "\"")
        else
            call IB_SkillGive(ib_skAddPlayer, ib_skAddFoundId, ib_skAddLevel)
        endif
        set ib_skAddPlayer = null
    endif
endfunction

// 添加技能入口
function IB_AddSkill takes player p, string skillName, integer level returns nothing
    if level < 1 then
        set level = 1
    endif
    set ib_skAddIdx = 0
    set ib_skAddName = IB_LowerAscii(skillName)
    set ib_skAddFoundId = 0
    set ib_skAddFoundIdx = -1
    set ib_skAddLevel = level
    set ib_skAddPlayer = p
    if ib_skAddTimer != null then
        call PauseTimer(ib_skAddTimer)
        call DestroyTimer(ib_skAddTimer)
    endif
    set ib_skAddTimer = CreateTimer()
    call TimerStart(ib_skAddTimer, 0.01, true, function IB_SkillAddStep)
endfunction

function IB_SkillRemove takes player p, integer abilId returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitRemoveAbility(u, abilId)
    call IB_Message(p, "已移除技能 [" + IB_IdStr(abilId) + "]")
    set u = null
endfunction

// 移除技能: 分帧扫描
function IB_SkillRemStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skRemIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skRemIdx)
        if name == ib_skRemName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skRemIdx]), ib_skRemName) then
            set ib_skRemFoundId = ib_skillList[ib_skRemIdx]
            set ib_skRemIdx = ib_skillCount
        elseif ib_skRemFoundId == 0 then
            if IB_NameMatch(name, ib_skRemName) then
                set ib_skRemFoundId = ib_skillList[ib_skRemIdx]
            endif
        endif
        set ib_skRemIdx = ib_skRemIdx + 1
        set n = n + 1
    endloop
    if ib_skRemIdx >= ib_skillCount then
        call PauseTimer(ib_skRemTimer)
        call DestroyTimer(ib_skRemTimer)
        set ib_skRemTimer = null
        if ib_skRemFoundId == 0 then
            call IB_Message(ib_skRemPlayer, "未找到技能 \"" + ib_skRemName + "\"")
        else
            call IB_SkillRemove(ib_skRemPlayer, ib_skRemFoundId)
        endif
        set ib_skRemPlayer = null
    endif
endfunction

function IB_RemoveSkill takes player p, string skillName returns nothing
    set ib_skRemIdx = 0
    set ib_skRemName = IB_LowerAscii(skillName)
    set ib_skRemFoundId = 0
    set ib_skRemPlayer = p
    if ib_skRemTimer != null then
        call PauseTimer(ib_skRemTimer)
        call DestroyTimer(ib_skRemTimer)
    endif
    set ib_skRemTimer = CreateTimer()
    call TimerStart(ib_skRemTimer, 0.01, true, function IB_SkillRemStep)
endfunction

// 搜索技能: 分帧扫描
function IB_SkillSearchStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skSearchIdx >= ib_skillCount or n >= 40
        if IB_NameMatch(IB_SkillName(ib_skSearchIdx), ib_skSearchKey) then
            set name = IB_SkillName(ib_skSearchIdx) + "[" + IB_IdStr(ib_skillList[ib_skSearchIdx]) + "]"
            if ib_skillCustom[ib_skSearchIdx] == 1 then
                set ib_skSearchCusN = ib_skSearchCusN + 1
                set ib_skSearchCus = ib_skSearchCus + name + "  "
            else
                set ib_skSearchStdN = ib_skSearchStdN + 1
                set ib_skSearchStd = ib_skSearchStd + name + "  "
            endif
        endif
        set ib_skSearchIdx = ib_skSearchIdx + 1
        set n = n + 1
    endloop
    if ib_skSearchIdx >= ib_skillCount then
        call PauseTimer(ib_skSearchTimer)
        call DestroyTimer(ib_skSearchTimer)
        set ib_skSearchTimer = null
        call IB_Message(ib_skSearchPlayer, "搜索 \"" + ib_skSearchKey + "\" 共 " + I2S(ib_skSearchStdN + ib_skSearchCusN) + " 个")
        if ib_skSearchStdN > 0 then
            call IB_Message(ib_skSearchPlayer, "标准(" + I2S(ib_skSearchStdN) + "): " + ib_skSearchStd)
        endif
        if ib_skSearchCusN > 0 then
            call IB_Message(ib_skSearchPlayer, "自定义(" + I2S(ib_skSearchCusN) + "): " + ib_skSearchCus)
        endif
        set ib_skSearchPlayer = null
    endif
endfunction

function IB_SkillSearch takes player p, string keyword returns nothing
    set ib_skSearchIdx = 0
    set ib_skSearchKey = IB_LowerAscii(keyword)
    set ib_skSearchStd = ""
    set ib_skSearchCus = ""
    set ib_skSearchStdN = 0
    set ib_skSearchCusN = 0
    set ib_skSearchPlayer = p
    if ib_skSearchTimer != null then
        call PauseTimer(ib_skSearchTimer)
        call DestroyTimer(ib_skSearchTimer)
    endif
    set ib_skSearchTimer = CreateTimer()
    call TimerStart(ib_skSearchTimer, 0.01, true, function IB_SkillSearchStep)
endfunction

// 解析 addskill 参数: "名称" 或 "名称 等级"
function IB_ParseAddSkill takes player p, string arg returns nothing
    local integer len = StringLength(arg)
    local integer i = len
    local integer lastSpace = -1
    local string skillName
    local string numStr
    local integer level = 1
    local boolean isNum
    local string ch

    loop
        exitwhen i <= 0
        if SubString(arg, i - 1, i) == " " then
            set lastSpace = i - 1
            set i = 0
        endif
        set i = i - 1
    endloop

    if lastSpace > 0 then
        set numStr = SubString(arg, lastSpace + 1, len)
        set isNum = StringLength(numStr) > 0
        set i = 0
        loop
            exitwhen i >= StringLength(numStr)
            set ch = SubString(numStr, i, i + 1)
            if ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9" then
            else
                set isNum = false
                set i = StringLength(numStr)
            endif
            set i = i + 1
        endloop
        if isNum then
            set skillName = SubString(arg, 0, lastSpace)
            set level = S2I(numStr)
        else
            set skillName = arg
        endif
    else
        set skillName = arg
    endif
    call IB_AddSkill(p, skillName, level)
endfunction

function IB_ParseRemoveSkill takes player p, string arg returns nothing
    call IB_RemoveSkill(p, arg)
endfunction

//---------------------------------------------------------------------------
// 解析聊天命令
//---------------------------------------------------------------------------
function IB_OnChat takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local string cmd
    local string arg
    local integer spacePos = -1
    local integer i = 0

    loop
        exitwhen i >= len
        if SubString(s, i, i + 1) == " " then
            set spacePos = i
            set i = len
        endif
        set i = i + 1
    endloop

    if spacePos == -1 then
        set cmd = s
        set arg = ""
    else
        set cmd = SubString(s, 0, spacePos)
        set arg = SubString(s, spacePos + 1, len)
    endif

    if IB_StrEqCI(cmd, "search") then
        call IB_Search(p, arg)
    elseif IB_StrEqCI(cmd, "additem") then
        call IB_ParseAddItem(p, arg)
    elseif IB_StrEqCI(cmd, "itembrowser") then
        call IB_Message(p, "装备系统就绪，共 " + I2S(ib_itemCount) + " 件装备")
        call IB_Message(p, "search <关键词>  搜索装备（原版/自定义分开显示）")
        call IB_Message(p, "additem <名称> [数量]  添加装备")
        call IB_Message(p, "additem <物品ID>  按ID添加（区分同名，如 additem I000）")
    elseif IB_StrEqCI(cmd, "ibtest") then
        call IB_Message(p, "诊断: ib_itemCount=" + I2S(ib_itemCount))
        call IB_Message(p, "name[0]=" + IB_ItemName(0))
        call IB_Message(p, "name[273]=" + IB_ItemName(273))
        call IB_Message(p, "len(arg)=" + I2S(StringLength(arg)) + " arg=" + arg)
        call IB_Message(p, "match(arg,name273)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(273), arg)))
        call IB_Message(p, "match(arg,name0)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(0), arg)))
    elseif IB_StrEqCI(cmd, "ibcount") then
        call IB_Message(p, "统计 \"" + arg + "\" 匹配数...")
        call IB_CountMatch(p, arg)
    elseif IB_StrEqCI(cmd, "addskill") then
        call IB_ParseAddSkill(p, arg)
    elseif IB_StrEqCI(cmd, "removeskill") then
        call IB_ParseRemoveSkill(p, arg)
    elseif IB_StrEqCI(cmd, "listskill") then
        call IB_SkillSearch(p, arg)
    endif
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
// 用 TriggerAddAction（而非 Condition）注册：部分地图/版本下仅含 condition
// 的聊天触发器不会触发；用 action 更可靠。
//---------------------------------------------------------------------------
function IB_RegisterChat5 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call PauseTimer(ib_regTimer)
    call DestroyTimer(ib_regTimer)
    set ib_regTimer = null
endfunction

function IB_RegisterChat4 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat5)
endfunction

function IB_RegisterChat3 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "addskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat4)
endfunction

function IB_RegisterChat2 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "additem", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    // 第三组命令(技能)继续分帧注册
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat3)
endfunction
function IB_RegisterChat takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "search", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    // 第二组命令用 timer 分帧注册,避免一次注册过多聊天事件而超限
    set ib_regTimer = CreateTimer()
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat2)
endfunction

//---------------------------------------------------------------------------
// 入口：直接填充预扫描的物品 ID 列表，立即注册聊天事件（无需枚举）
//---------------------------------------------------------------------------
function IB_Fill0 takes nothing returns nothing
    set ib_itemList[0] = 'fgdg'
    set ib_itemName[0] = "恶魔雕像"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'infs'
    set ib_itemName[1] = "恶魔岩石"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'ankh'
    set ib_itemName[2] = "重生十字章"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'whwd'
    set ib_itemName[3] = "风少爷(qq171246484)"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'fgrg'
    set ib_itemName[4] = "岩石印记"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'pghe'
    set ib_itemName[5] = "大生命药水"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'pgma'
    set ib_itemName[6] = "大魔法药水"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'rej3'
    set ib_itemName[7] = "恢复药水"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'ofir'
    set ib_itemName[8] = "火焰之球"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'ocor'
    set ib_itemName[9] = "腐蚀之球"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'oli2'
    set ib_itemName[10] = "闪电之球"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'oven'
    set ib_itemName[11] = "毒液之球"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'tgrh'
    set ib_itemName[12] = "小型的大厅"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'stel'
    set ib_itemName[13] = "星辰权杖"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'tdx2'
    set ib_itemName[14] = "敏捷之书 +10000"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'texp'
    set ib_itemName[15] = "超级经验之书"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'tin2'
    set ib_itemName[16] = "智力之书 +10000"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'tpow'
    set ib_itemName[17] = "知识之书+100"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'tst2'
    set ib_itemName[18] = "力量之书 +10000"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'stwp'
    set ib_itemName[19] = "回城卷轴"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'shea'
    set ib_itemName[20] = "医疗卷轴"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'dust'
    set ib_itemName[21] = "尘土之影"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'manh'
    set ib_itemName[22] = "生命手册"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'tdex'
    set ib_itemName[23] = "敏捷之书+100"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'tint'
    set ib_itemName[24] = "智力之书+100"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'tstr'
    set ib_itemName[25] = "力量之书+100"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'phea'
    set ib_itemName[26] = "生命药水"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'pman'
    set ib_itemName[27] = "魔法药水"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'hslv'
    set ib_itemName[28] = "医疗剂"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'moon'
    set ib_itemName[29] = "月亮石"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'shas'
    set ib_itemName[30] = "速度卷轴"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'skul'
    set ib_itemName[31] = "献祭头骨"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'mcri'
    set ib_itemName[32] = "机械类的小玩艺"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'rnec'
    set ib_itemName[33] = "巫术妖棍"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'tsct'
    set ib_itemName[34] = "象牙塔"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'pams'
    set ib_itemName[35] = "抗体药水"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'spre'
    set ib_itemName[36] = "保存权杖"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'plcl'
    set ib_itemName[37] = "小净化药水"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'sreg'
    set ib_itemName[38] = "恢复卷轴"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'ssan'
    set ib_itemName[39] = "避难权杖"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'I000'
    set ib_itemName[40] = "风痕之刃"
    set ib_itemCustom[40] = 1
    set ib_itemList[41] = 'I001'
    set ib_itemName[41] = "知识之书+10000"
    set ib_itemCustom[41] = 1
    set ib_itemList[42] = 'I002'
    set ib_itemName[42] = "1点木材换10000金币"
    set ib_itemCustom[42] = 1
    set ib_itemList[43] = 'I003'
    set ib_itemName[43] = "10000金币换1点木材"
    set ib_itemCustom[43] = 1
    set ib_itemList[44] = 'I006'
    set ib_itemName[44] = "远古战斧(四级)"
    set ib_itemCustom[44] = 1
    set ib_itemList[45] = 'I007'
    set ib_itemName[45] = "国王之冠(二级)"
    set ib_itemCustom[45] = 1
    set ib_itemList[46] = 'I00A'
    set ib_itemName[46] = "攻击之爪(二级)"
    set ib_itemCustom[46] = 1
    set ib_itemList[47] = 'I00B'
    set ib_itemName[47] = "霹雳手套(一级)"
    set ib_itemCustom[47] = 1
    set ib_itemList[48] = 'I00C'
    set ib_itemName[48] = "重生十字章(极品)"
    set ib_itemCustom[48] = 1
    set ib_itemList[49] = 'I00H'
    set ib_itemName[49] = "火焰手套(四级)"
    set ib_itemCustom[49] = 1
    set ib_itemList[50] = 'I00I'
    set ib_itemName[50] = "神圣之冠(一级)"
    set ib_itemCustom[50] = 1
    set ib_itemList[51] = 'I00J'
    set ib_itemName[51] = "烈火战刀(一级)"
    set ib_itemCustom[51] = 1
    set ib_itemList[52] = 'I005'
    set ib_itemName[52] = "火焰手套(一级)"
    set ib_itemCustom[52] = 1
    set ib_itemList[53] = 'I00E'
    set ib_itemName[53] = "火焰手套(三级)"
    set ib_itemCustom[53] = 1
    set ib_itemList[54] = 'I00F'
    set ib_itemName[54] = "火焰手套(二级)"
    set ib_itemCustom[54] = 1
    set ib_itemList[55] = 'I00O'
    set ib_itemName[55] = "灼热之刀(一级)"
    set ib_itemCustom[55] = 1
    set ib_itemList[56] = 'I004'
    set ib_itemName[56] = "灼热之刀(二级)"
    set ib_itemCustom[56] = 1
    set ib_itemList[57] = 'I00L'
    set ib_itemName[57] = "灼热之刀(三级)"
    set ib_itemCustom[57] = 1
    set ib_itemList[58] = 'I00M'
    set ib_itemName[58] = "灼热之刀(四级)"
    set ib_itemCustom[58] = 1
    set ib_itemList[59] = 'I00S'
    set ib_itemName[59] = "远古战斧(一级)"
    set ib_itemCustom[59] = 1
    set ib_itemList[60] = 'I00T'
    set ib_itemName[60] = "远古战斧(二级)"
    set ib_itemCustom[60] = 1
    set ib_itemList[61] = 'I00U'
    set ib_itemName[61] = "远古战斧(三级)"
    set ib_itemCustom[61] = 1
    set ib_itemList[62] = 'I00V'
    set ib_itemName[62] = "国王之冠(三级)"
    set ib_itemCustom[62] = 1
    set ib_itemList[63] = 'I00W'
    set ib_itemName[63] = "国王之冠(一级)"
    set ib_itemCustom[63] = 1
    set ib_itemList[64] = 'I00X'
    set ib_itemName[64] = "国王之冠(四级)"
    set ib_itemCustom[64] = 1
    set ib_itemList[65] = 'I00Z'
    set ib_itemName[65] = "攻击之爪(四级)"
    set ib_itemCustom[65] = 1
    set ib_itemList[66] = 'I010'
    set ib_itemName[66] = "攻击之爪(一级)"
    set ib_itemCustom[66] = 1
    set ib_itemList[67] = 'I011'
    set ib_itemName[67] = "攻击之爪(三级)"
    set ib_itemCustom[67] = 1
    set ib_itemList[68] = 'I00Y'
    set ib_itemName[68] = "邪神战斧(一级)"
    set ib_itemCustom[68] = 1
    set ib_itemList[69] = 'I013'
    set ib_itemName[69] = "疯魔之爪(一级)"
    set ib_itemCustom[69] = 1
    set ib_itemList[70] = 'I014'
    set ib_itemName[70] = "合成宝石"
    set ib_itemCustom[70] = 1
    set ib_itemList[71] = 'I015'
    set ib_itemName[71] = "风痕之甲"
    set ib_itemCustom[71] = 1
    set ib_itemList[72] = 'I016'
    set ib_itemName[72] = "霹雳手套(二级)"
    set ib_itemCustom[72] = 1
    set ib_itemList[73] = 'I017'
    set ib_itemName[73] = "霹雳手套(三级)"
    set ib_itemCustom[73] = 1
    set ib_itemList[74] = 'I018'
    set ib_itemName[74] = "霹雳手套(四级)"
    set ib_itemCustom[74] = 1
    set ib_itemList[75] = 'I00D'
    set ib_itemName[75] = "邪神战斧(二级)"
    set ib_itemCustom[75] = 1
    set ib_itemList[76] = 'I019'
    set ib_itemName[76] = "邪神战斧(三级)"
    set ib_itemCustom[76] = 1
    set ib_itemList[77] = 'I01A'
    set ib_itemName[77] = "邪神战斧(四级)"
    set ib_itemCustom[77] = 1
    set ib_itemList[78] = 'I01B'
    set ib_itemName[78] = "烈火战刀(二级)"
    set ib_itemCustom[78] = 1
    set ib_itemList[79] = 'I01C'
    set ib_itemName[79] = "烈火战刀(三级)"
    set ib_itemCustom[79] = 1
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'I01D'
    set ib_itemName[80] = "烈火战刀(四级)"
    set ib_itemCustom[80] = 1
    set ib_itemList[81] = 'I01E'
    set ib_itemName[81] = "疯魔之爪(二级)"
    set ib_itemCustom[81] = 1
    set ib_itemList[82] = 'I01F'
    set ib_itemName[82] = "疯魔之爪(三级)"
    set ib_itemCustom[82] = 1
    set ib_itemList[83] = 'I01G'
    set ib_itemName[83] = "疯魔之爪(四级)"
    set ib_itemCustom[83] = 1
    set ib_itemList[84] = 'I01H'
    set ib_itemName[84] = "神圣之冠(二级)"
    set ib_itemCustom[84] = 1
    set ib_itemList[85] = 'I01I'
    set ib_itemName[85] = "神圣之冠(三级)"
    set ib_itemCustom[85] = 1
    set ib_itemList[86] = 'I01J'
    set ib_itemName[86] = "神圣之冠(四级)"
    set ib_itemCustom[86] = 1
    set ib_itemList[87] = 'I01N'
    set ib_itemName[87] = "10点木材换100000金币"
    set ib_itemCustom[87] = 1
    set ib_itemList[88] = 'I01O'
    set ib_itemName[88] = "100000金币换10点木材"
    set ib_itemCustom[88] = 1
    set ib_itemList[89] = 'I01P'
    set ib_itemName[89] = "秋霜战刀"
    set ib_itemCustom[89] = 1
    set ib_itemList[90] = 'I01Q'
    set ib_itemName[90] = "秋霜战斧"
    set ib_itemCustom[90] = 1
    set ib_itemList[91] = 'I01R'
    set ib_itemName[91] = "秋霜战手"
    set ib_itemCustom[91] = 1
    set ib_itemList[92] = 'I01S'
    set ib_itemName[92] = "秋霜战盔"
    set ib_itemCustom[92] = 1
    set ib_itemList[93] = 'I01U'
    set ib_itemName[93] = "秋霜战爪"
    set ib_itemCustom[93] = 1
    set ib_itemList[94] = 'I01V'
    set ib_itemName[94] = "秋霜宝石"
    set ib_itemCustom[94] = 1
    set ib_itemList[95] = 'I01W'
    set ib_itemName[95] = "落叶宝石"
    set ib_itemCustom[95] = 1
    set ib_itemList[96] = 'I01X'
    set ib_itemName[96] = "红魔宝石"
    set ib_itemCustom[96] = 1
    set ib_itemList[97] = 'I01Y'
    set ib_itemName[97] = "落叶魂刀"
    set ib_itemCustom[97] = 1
    set ib_itemList[98] = 'I01Z'
    set ib_itemName[98] = "落叶魂手"
    set ib_itemCustom[98] = 1
    set ib_itemList[99] = 'I021'
    set ib_itemName[99] = "落叶魂盔"
    set ib_itemCustom[99] = 1
    set ib_itemList[100] = 'I022'
    set ib_itemName[100] = "落叶魂爪"
    set ib_itemCustom[100] = 1
    set ib_itemList[101] = 'I023'
    set ib_itemName[101] = "落叶魂斧"
    set ib_itemCustom[101] = 1
    set ib_itemList[102] = 'I024'
    set ib_itemName[102] = "红魔龙刀"
    set ib_itemCustom[102] = 1
    set ib_itemList[103] = 'I026'
    set ib_itemName[103] = "红魔龙盔"
    set ib_itemCustom[103] = 1
    set ib_itemList[104] = 'I027'
    set ib_itemName[104] = "红魔龙手"
    set ib_itemCustom[104] = 1
    set ib_itemList[105] = 'I028'
    set ib_itemName[105] = "红魔龙爪"
    set ib_itemCustom[105] = 1
    set ib_itemList[106] = 'I029'
    set ib_itemName[106] = "红魔龙斧"
    set ib_itemCustom[106] = 1
    set ib_itemList[107] = 'I02A'
    set ib_itemName[107] = "生命手册(真)10000"
    set ib_itemCustom[107] = 1
    set ib_itemList[108] = 'I02B'
    set ib_itemName[108] = "知识之书+1000"
    set ib_itemCustom[108] = 1
    set ib_itemList[109] = 'I02C'
    set ib_itemName[109] = "力量之书+1000"
    set ib_itemCustom[109] = 1
    set ib_itemList[110] = 'I02D'
    set ib_itemName[110] = "敏捷之书+1000"
    set ib_itemCustom[110] = 1
    set ib_itemList[111] = 'I02E'
    set ib_itemName[111] = "智力之书+1000"
    set ib_itemCustom[111] = 1
    set ib_itemList[112] = 'I02F'
    set ib_itemName[112] = "生命手册(真)100000"
    set ib_itemCustom[112] = 1
    set ib_itemList[113] = 'I02G'
    set ib_itemName[113] = "极品生命手册"
    set ib_itemCustom[113] = 1
    set ib_itemList[114] = 'I02H'
    set ib_itemName[114] = "蓝风月刃"
    set ib_itemCustom[114] = 1
    set ib_itemList[115] = 'I02J'
    set ib_itemName[115] = "终极生命手册"
    set ib_itemCustom[115] = 1
    set ib_itemList[116] = 'I02K'
    set ib_itemName[116] = "生命手册(真)1000w"
    set ib_itemCustom[116] = 1
    set ib_itemList[117] = 'I02I'
    set ib_itemName[117] = "终极经验之书"
    set ib_itemCustom[117] = 1
    set ib_itemList[118] = 'I02L'
    set ib_itemName[118] = "转生证明"
    set ib_itemCustom[118] = 1
    set ib_itemList[119] = 'I008'
    set ib_itemName[119] = "二转证明"
    set ib_itemCustom[119] = 1
    set ib_itemList[120] = 'I00G'
    set ib_itemName[120] = "重生十字章(终极)"
    set ib_itemCustom[120] = 1
    set ib_itemList[121] = 'I00K'
    set ib_itemName[121] = "超级神器"
    set ib_itemCustom[121] = 1
    set ib_itemList[122] = 'I02M'
    set ib_itemName[122] = "超级神甲"
    set ib_itemCustom[122] = 1
    set ib_itemList[123] = 'I02W'
    set ib_itemName[123] = "命运宝箱"
    set ib_itemCustom[123] = 1
    set ib_itemList[124] = 'I02O'
    set ib_itemName[124] = "飞哥龙神斩"
    set ib_itemCustom[124] = 1
    set ib_itemList[125] = 'I031'
    set ib_itemName[125] = "三转证明"
    set ib_itemCustom[125] = 1
    set ib_itemList[126] = 'I02P'
    set ib_itemName[126] = "知识之书+50w"
    set ib_itemCustom[126] = 1
    set ib_itemList[127] = 'I02Q'
    set ib_itemName[127] = "飞哥圣神甲"
    set ib_itemCustom[127] = 1
    set ib_itemList[128] = 'I02S'
    set ib_itemName[128] = "飞哥龙神斩<gm>"
    set ib_itemCustom[128] = 1
    set ib_itemList[129] = 'I02T'
    set ib_itemName[129] = "<飞哥刀gm证明书>"
    set ib_itemCustom[129] = 1
    set ib_itemList[130] = 'I02R'
    set ib_itemName[130] = "飞飞世界"
    set ib_itemCustom[130] = 1
    set ib_itemList[131] = 'I02U'
    set ib_itemName[131] = "力量之书+100w"
    set ib_itemCustom[131] = 1
    set ib_itemList[132] = 'I02V'
    set ib_itemName[132] = "敏捷之书+100w"
    set ib_itemCustom[132] = 1
    set ib_itemList[133] = 'I02X'
    set ib_itemName[133] = "智力之书+100w"
    set ib_itemCustom[133] = 1
    set ib_itemList[134] = 'I02Y'
    set ib_itemName[134] = "知识之书+100w"
    set ib_itemCustom[134] = 1
    set ib_itemList[135] = 'I02Z'
    set ib_itemName[135] = "<飞哥甲gm证明书>"
    set ib_itemCustom[135] = 1
    set ib_itemList[136] = 'I030'
    set ib_itemName[136] = "飞哥圣神甲<gm>"
    set ib_itemCustom[136] = 1
    set ib_itemList[137] = 'I032'
    set ib_itemName[137] = "魔界通道通行证"
    set ib_itemCustom[137] = 1
    set ib_itemList[138] = 'I00N'
    set ib_itemName[138] = "经验之书"
    set ib_itemCustom[138] = 1
    set ib_itemList[139] = 'I02N'
    set ib_itemName[139] = "生命手册(真)100w"
    set ib_itemCustom[139] = 1
    set ib_itemList[140] = 'I033'
    set ib_itemName[140] = "鬼龙之戒"
    set ib_itemCustom[140] = 1
    set ib_itemList[141] = 'I034'
    set ib_itemName[141] = "鬼龙封印"
    set ib_itemCustom[141] = 1
    set ib_itemList[142] = 'I009'
    set ib_itemName[142] = "青龙盾"
    set ib_itemCustom[142] = 1
    set ib_itemList[143] = 'I00P'
    set ib_itemName[143] = "朱雀盾"
    set ib_itemCustom[143] = 1
    set ib_itemList[144] = 'I00Q'
    set ib_itemName[144] = "白虎盾"
    set ib_itemCustom[144] = 1
    set ib_itemList[145] = 'I00R'
    set ib_itemName[145] = "玄武盾"
    set ib_itemCustom[145] = 1
    set ib_itemList[146] = 'I012'
    set ib_itemName[146] = "四兽之盾"
    set ib_itemCustom[146] = 1
    set ib_itemList[147] = 'I01K'
    set ib_itemName[147] = "力量之书+10w"
    set ib_itemCustom[147] = 1
    set ib_itemList[148] = 'I01L'
    set ib_itemName[148] = "敏捷之书+10w"
    set ib_itemCustom[148] = 1
    set ib_itemList[149] = 'I01T'
    set ib_itemName[149] = "神秘宝石"
    set ib_itemCustom[149] = 1
endfunction

function IB_SkillFill0 takes nothing returns nothing
    set ib_skillList[0] = 'A001'
    set ib_skillName[0] = "致命一击20"
    set ib_skillCustom[0] = 1
    set ib_skillList[1] = 'A003'
    set ib_skillName[1] = "能盗取生命值的物品极品50"
    set ib_skillCustom[1] = 1
    set ib_skillList[2] = 'A007'
    set ib_skillName[2] = "近战攻击带有火焰伤害极品"
    set ib_skillCustom[2] = 1
    set ib_skillList[3] = 'A009'
    set ib_skillName[3] = "近战攻击带有冰冻伤害极品"
    set ib_skillCustom[3] = 1
    set ib_skillList[4] = 'A00C'
    set ib_skillName[4] = "能盗取生命值的物品绝对30"
    set ib_skillCustom[4] = 1
    set ib_skillList[5] = 'A00F'
    set ib_skillName[5] = "命令极品25"
    set ib_skillCustom[5] = 1
    set ib_skillList[6] = 'A00X'
    set ib_skillName[6] = "能盗取生命值的物品绝对20"
    set ib_skillCustom[6] = 1
    set ib_skillList[7] = 'A012'
    set ib_skillName[7] = "命令极品100"
    set ib_skillCustom[7] = 1
    set ib_skillList[8] = 'A017'
    set ib_skillName[8] = "能盗取生命值的物品绝对40"
    set ib_skillCustom[8] = 1
    set ib_skillList[9] = 'A01C'
    set ib_skillName[9] = "能带有火焰伤害的物品2000"
    set ib_skillCustom[9] = 1
    set ib_skillList[10] = 'A01V'
    set ib_skillName[10] = "致命一击30"
    set ib_skillCustom[10] = 1
    set ib_skillList[11] = 'A02F'
    set ib_skillName[11] = "命令极品50"
    set ib_skillCustom[11] = 1
    set ib_skillList[12] = 'A02G'
    set ib_skillName[12] = "命令极品75"
    set ib_skillCustom[12] = 1
    set ib_skillList[13] = 'A02I'
    set ib_skillName[13] = "命令极品150"
    set ib_skillCustom[13] = 1
    set ib_skillList[14] = 'A02K'
    set ib_skillName[14] = "能盗取生命值的物品极品60"
    set ib_skillCustom[14] = 1
    set ib_skillList[15] = 'A02L'
    set ib_skillName[15] = "命令极品200"
    set ib_skillCustom[15] = 1
    set ib_skillList[16] = 'A02O'
    set ib_skillName[16] = "能盗取生命值的物品极品70"
    set ib_skillCustom[16] = 1
    set ib_skillList[17] = 'A02P'
    set ib_skillName[17] = "致命一击40"
    set ib_skillCustom[17] = 1
    set ib_skillList[18] = 'A02W'
    set ib_skillName[18] = "能盗取生命值的物品极品80"
    set ib_skillCustom[18] = 1
    set ib_skillList[19] = 'A02X'
    set ib_skillName[19] = "能盗取生命值的物品极品90"
    set ib_skillCustom[19] = 1
    set ib_skillList[20] = 'A02Y'
    set ib_skillName[20] = "致命一击35"
    set ib_skillCustom[20] = 1
    set ib_skillList[21] = 'A02Z'
    set ib_skillName[21] = "致命一击45"
    set ib_skillCustom[21] = 1
    set ib_skillList[22] = 'A030'
    set ib_skillName[22] = "命令极品125"
    set ib_skillCustom[22] = 1
    set ib_skillList[23] = 'A031'
    set ib_skillName[23] = "命令极品175"
    set ib_skillCustom[23] = 1
    set ib_skillList[24] = 'A03C'
    set ib_skillName[24] = "致命一击50"
    set ib_skillCustom[24] = 1
    set ib_skillList[25] = 'A03D'
    set ib_skillName[25] = "能盗取生命值的物品极品100"
    set ib_skillCustom[25] = 1
    set ib_skillList[26] = 'A03G'
    set ib_skillName[26] = "命令极品250"
    set ib_skillCustom[26] = 1
    set ib_skillList[27] = 'A03M'
    set ib_skillName[27] = "命令极品300"
    set ib_skillCustom[27] = 1
    set ib_skillList[28] = 'A03P'
    set ib_skillName[28] = "致命一击55"
    set ib_skillCustom[28] = 1
    set ib_skillList[29] = 'A03S'
    set ib_skillName[29] = "能盗取生命值的物品极品110"
    set ib_skillCustom[29] = 1
    set ib_skillList[30] = 'A03T'
    set ib_skillName[30] = "命令极品350"
    set ib_skillCustom[30] = 1
    set ib_skillList[31] = 'A03X'
    set ib_skillName[31] = "能盗取生命值的物品极品120"
    set ib_skillCustom[31] = 1
    set ib_skillList[32] = 'A03Y'
    set ib_skillName[32] = "致命一击60"
    set ib_skillCustom[32] = 1
    set ib_skillList[33] = 'A042'
    set ib_skillName[33] = "命令极品400"
    set ib_skillCustom[33] = 1
    set ib_skillList[34] = 'A044'
    set ib_skillName[34] = "能盗取生命值的物品极品130"
    set ib_skillCustom[34] = 1
    set ib_skillList[35] = 'A045'
    set ib_skillName[35] = "致命一击70"
    set ib_skillCustom[35] = 1
    set ib_skillList[36] = 'A04L'
    set ib_skillName[36] = "小山丘之怒"
    set ib_skillCustom[36] = 1
    set ib_skillList[37] = 'A04U'
    set ib_skillName[37] = "天使之翼"
    set ib_skillCustom[37] = 1
    set ib_skillList[38] = 'A04V'
    set ib_skillName[38] = "大天使之翼"
    set ib_skillCustom[38] = 1
    set ib_skillList[39] = 'A04W'
    set ib_skillName[39] = "五彩之翼"
    set ib_skillCustom[39] = 1
    set ib_skillList[40] = 'A04X'
    set ib_skillName[40] = "白色羽翼"
    set ib_skillCustom[40] = 1
    set ib_skillList[41] = 'A04Y'
    set ib_skillName[41] = "黑龙之翼"
    set ib_skillCustom[41] = 1
    set ib_skillList[42] = 'A04Z'
    set ib_skillName[42] = "奇迹之翼"
    set ib_skillCustom[42] = 1
    set ib_skillList[43] = 'A050'
    set ib_skillName[43] = "恶魔之翼"
    set ib_skillCustom[43] = 1
    set ib_skillList[44] = 'A057'
    set ib_skillName[44] = "命令极品450"
    set ib_skillCustom[44] = 1
    set ib_skillList[45] = 'A059'
    set ib_skillName[45] = "致命一击80"
    set ib_skillCustom[45] = 1
    set ib_skillList[46] = 'A05A'
    set ib_skillName[46] = "能盗取生命值的物品极品140"
    set ib_skillCustom[46] = 1
    set ib_skillList[47] = 'A05L'
    set ib_skillName[47] = "命令极品1500"
    set ib_skillCustom[47] = 1
    set ib_skillList[48] = 'A05N'
    set ib_skillName[48] = "能盗取生命值的物品极品200"
    set ib_skillCustom[48] = 1
    set ib_skillList[49] = 'A05O'
    set ib_skillName[49] = "致命一击100"
    set ib_skillCustom[49] = 1
    set ib_skillList[50] = 'A067'
    set ib_skillName[50] = "致命一击120"
    set ib_skillCustom[50] = 1
    set ib_skillList[51] = 'A06H'
    set ib_skillName[51] = "致命一击300"
    set ib_skillCustom[51] = 1
    set ib_skillList[52] = 'A084'
    set ib_skillName[52] = "致命一击350"
    set ib_skillCustom[52] = 1
    set ib_skillList[53] = 'A085'
    set ib_skillName[53] = "致命一击500"
    set ib_skillCustom[53] = 1
    set ib_skillList[54] = 'A086'
    set ib_skillName[54] = "致命一击700"
    set ib_skillCustom[54] = 1
    set ib_skillList[55] = 'A08C'
    set ib_skillName[55] = "四神兽之盾"
    set ib_skillCustom[55] = 1
    set ib_skillList[56] = 'AAns'
    set ib_skillName[56] = "收费"
    set ib_skillCustom[56] = 0
    set ib_skillList[57] = 'ACac'
    set ib_skillName[57] = "命令光环"
    set ib_skillCustom[57] = 0
    set ib_skillList[58] = 'ACad'
    set ib_skillName[58] = "操纵死尸"
    set ib_skillCustom[58] = 0
    set ib_skillList[59] = 'ACah'
    set ib_skillName[59] = "荆棘光环"
    set ib_skillCustom[59] = 0
    set ib_skillList[60] = 'ACam'
    set ib_skillName[60] = "反魔法外壳"
    set ib_skillCustom[60] = 0
    set ib_skillList[61] = 'ACat'
    set ib_skillName[61] = "强击光环"
    set ib_skillCustom[61] = 0
    set ib_skillList[62] = 'ACav'
    set ib_skillName[62] = "专注光环"
    set ib_skillCustom[62] = 0
    set ib_skillList[63] = 'ACba'
    set ib_skillName[63] = "辉煌光环"
    set ib_skillCustom[63] = 0
    set ib_skillList[64] = 'ACbb'
    set ib_skillName[64] = "嗜血术"
    set ib_skillCustom[64] = 0
    set ib_skillList[65] = 'ACbc'
    set ib_skillName[65] = "火焰呼吸"
    set ib_skillCustom[65] = 0
    set ib_skillList[66] = 'ACbf'
    set ib_skillName[66] = "霜冻闪电"
    set ib_skillCustom[66] = 0
    set ib_skillList[67] = 'ACbh'
    set ib_skillName[67] = "重击"
    set ib_skillCustom[67] = 0
    set ib_skillList[68] = 'ACbk'
    set ib_skillName[68] = "黑暗之箭"
    set ib_skillCustom[68] = 0
    set ib_skillList[69] = 'ACbl'
    set ib_skillName[69] = "嗜血术"
    set ib_skillCustom[69] = 0
    set ib_skillList[70] = 'ACbn'
    set ib_skillName[70] = "驱散"
    set ib_skillCustom[70] = 0
    set ib_skillList[71] = 'ACbr'
    set ib_skillName[71] = "狂暴愤怒"
    set ib_skillCustom[71] = 0
    set ib_skillList[72] = 'ACbz'
    set ib_skillName[72] = "暴风雪"
    set ib_skillCustom[72] = 0
    set ib_skillList[73] = 'ACc2'
    set ib_skillName[73] = "冲击波"
    set ib_skillCustom[73] = 0
    set ib_skillList[74] = 'ACc3'
    set ib_skillName[74] = "冲击波"
    set ib_skillCustom[74] = 0
    set ib_skillList[75] = 'ACca'
    set ib_skillName[75] = "腐臭蜂群"
    set ib_skillCustom[75] = 0
    set ib_skillList[76] = 'ACcb'
    set ib_skillName[76] = "霜冻闪电"
    set ib_skillCustom[76] = 0
    set ib_skillList[77] = 'ACce'
    set ib_skillName[77] = "分裂攻击"
    set ib_skillCustom[77] = 0
    set ib_skillList[78] = 'ACch'
    set ib_skillName[78] = "符咒"
    set ib_skillCustom[78] = 0
    set ib_skillList[79] = 'ACcl'
    set ib_skillName[79] = "闪电链"
    set ib_skillCustom[79] = 0
endfunction
function IB_SkillFill1 takes nothing returns nothing
    set ib_skillList[80] = 'ACcn'
    set ib_skillName[80] = "吞食尸体"
    set ib_skillCustom[80] = 0
    set ib_skillList[81] = 'ACcr'
    set ib_skillName[81] = "残废"
    set ib_skillCustom[81] = 0
    set ib_skillList[82] = 'ACcs'
    set ib_skillName[82] = "诅咒"
    set ib_skillCustom[82] = 0
    set ib_skillList[83] = 'ACct'
    set ib_skillName[83] = "致命一击"
    set ib_skillCustom[83] = 0
    set ib_skillList[84] = 'ACcv'
    set ib_skillName[84] = "冲击波"
    set ib_skillCustom[84] = 0
    set ib_skillList[85] = 'ACcw'
    set ib_skillName[85] = "冰冻冷箭"
    set ib_skillCustom[85] = 0
    set ib_skillList[86] = 'ACcy'
    set ib_skillName[86] = "飓风"
    set ib_skillCustom[86] = 0
    set ib_skillList[87] = 'ACd2'
    set ib_skillName[87] = "驱逐魔法"
    set ib_skillCustom[87] = 0
    set ib_skillList[88] = 'ACdc'
    set ib_skillName[88] = "死亡缠绕"
    set ib_skillCustom[88] = 0
    set ib_skillList[89] = 'ACde'
    set ib_skillName[89] = "吞噬魔法"
    set ib_skillCustom[89] = 0
    set ib_skillList[90] = 'ACdm'
    set ib_skillName[90] = "驱逐魔法"
    set ib_skillCustom[90] = 0
    set ib_skillList[91] = 'ACdr'
    set ib_skillName[91] = "生命汲取"
    set ib_skillCustom[91] = 0
    set ib_skillList[92] = 'ACds'
    set ib_skillName[92] = "神圣护甲"
    set ib_skillCustom[92] = 0
    set ib_skillList[93] = 'ACdv'
    set ib_skillName[93] = "吞噬"
    set ib_skillCustom[93] = 0
    set ib_skillList[94] = 'ACen'
    set ib_skillName[94] = "诱捕"
    set ib_skillCustom[94] = 0
    set ib_skillList[95] = 'ACes'
    set ib_skillName[95] = "闪避"
    set ib_skillCustom[95] = 0
    set ib_skillList[96] = 'ACev'
    set ib_skillName[96] = "闪避"
    set ib_skillCustom[96] = 0
    set ib_skillList[97] = 'ACf2'
    set ib_skillName[97] = "霜冻护甲"
    set ib_skillCustom[97] = 0
    set ib_skillList[98] = 'ACf3'
    set ib_skillName[98] = "痛苦之指"
    set ib_skillCustom[98] = 0
    set ib_skillList[99] = 'ACfa'
    set ib_skillName[99] = "霜冻护甲"
    set ib_skillCustom[99] = 0
    set ib_skillList[100] = 'ACfb'
    set ib_skillName[100] = "霹雳闪电"
    set ib_skillCustom[100] = 0
    set ib_skillList[101] = 'ACfd'
    set ib_skillName[101] = "痛苦之指"
    set ib_skillCustom[101] = 0
    set ib_skillList[102] = 'ACff'
    set ib_skillName[102] = "精灵之火"
    set ib_skillCustom[102] = 0
    set ib_skillList[103] = 'ACfl'
    set ib_skillName[103] = "叉状闪电"
    set ib_skillCustom[103] = 0
    set ib_skillList[104] = 'ACfn'
    set ib_skillName[104] = "霜冻新星"
    set ib_skillCustom[104] = 0
    set ib_skillList[105] = 'ACfr'
    set ib_skillName[105] = "自然之力"
    set ib_skillCustom[105] = 0
    set ib_skillList[106] = 'ACfs'
    set ib_skillName[106] = "烈焰风暴"
    set ib_skillCustom[106] = 0
    set ib_skillList[107] = 'ACfu'
    set ib_skillName[107] = "霜冻护甲"
    set ib_skillCustom[107] = 0
    set ib_skillList[108] = 'AChv'
    set ib_skillName[108] = "医疗波"
    set ib_skillCustom[108] = 0
    set ib_skillList[109] = 'AChw'
    set ib_skillName[109] = "治疗守卫"
    set ib_skillCustom[109] = 0
    set ib_skillList[110] = 'AChx'
    set ib_skillName[110] = "妖术"
    set ib_skillCustom[110] = 0
    set ib_skillList[111] = 'ACif'
    set ib_skillName[111] = "心灵之火"
    set ib_skillCustom[111] = 0
    set ib_skillList[112] = 'ACim'
    set ib_skillName[112] = "献祭"
    set ib_skillCustom[112] = 0
    set ib_skillList[113] = 'ACls'
    set ib_skillName[113] = "闪电护盾"
    set ib_skillCustom[113] = 0
    set ib_skillList[114] = 'ACm2'
    set ib_skillName[114] = "魔法免疫"
    set ib_skillCustom[114] = 0
    set ib_skillList[115] = 'ACm3'
    set ib_skillName[115] = "魔法免疫"
    set ib_skillCustom[115] = 0
    set ib_skillList[116] = 'ACmf'
    set ib_skillName[116] = "魔法护盾"
    set ib_skillCustom[116] = 0
    set ib_skillList[117] = 'ACmi'
    set ib_skillName[117] = "魔法免疫"
    set ib_skillCustom[117] = 0
    set ib_skillList[118] = 'ACmo'
    set ib_skillName[118] = "季风"
    set ib_skillCustom[118] = 0
    set ib_skillList[119] = 'ACmp'
    set ib_skillName[119] = "穿刺"
    set ib_skillCustom[119] = 0
    set ib_skillList[120] = 'ACnr'
    set ib_skillName[120] = "生命恢复光环"
    set ib_skillCustom[120] = 0
    set ib_skillList[121] = 'ACpa'
    set ib_skillName[121] = "寄生虫"
    set ib_skillCustom[121] = 0
    set ib_skillList[122] = 'ACps'
    set ib_skillName[122] = "占据"
    set ib_skillCustom[122] = 0
    set ib_skillList[123] = 'ACpu'
    set ib_skillName[123] = "净化"
    set ib_skillCustom[123] = 0
    set ib_skillList[124] = 'ACpv'
    set ib_skillName[124] = "粉碎"
    set ib_skillCustom[124] = 0
    set ib_skillList[125] = 'ACpy'
    set ib_skillName[125] = "变形术"
    set ib_skillCustom[125] = 0
    set ib_skillList[126] = 'ACr1'
    set ib_skillName[126] = "咆哮"
    set ib_skillCustom[126] = 0
    set ib_skillList[127] = 'ACr2'
    set ib_skillName[127] = "生命恢复"
    set ib_skillCustom[127] = 0
    set ib_skillList[128] = 'ACrd'
    set ib_skillName[128] = "复活死尸"
    set ib_skillCustom[128] = 0
    set ib_skillList[129] = 'ACrf'
    set ib_skillName[129] = "火焰雨"
    set ib_skillCustom[129] = 0
    set ib_skillList[130] = 'ACrg'
    set ib_skillName[130] = "火焰雨"
    set ib_skillCustom[130] = 0
    set ib_skillList[131] = 'ACrj'
    set ib_skillName[131] = "生命恢复"
    set ib_skillCustom[131] = 0
    set ib_skillList[132] = 'ACrk'
    set ib_skillName[132] = "抗性皮肤"
    set ib_skillCustom[132] = 0
    set ib_skillList[133] = 'ACrn'
    set ib_skillName[133] = "重生"
    set ib_skillCustom[133] = 0
    set ib_skillList[134] = 'ACro'
    set ib_skillName[134] = "咆哮"
    set ib_skillCustom[134] = 0
    set ib_skillList[135] = 'ACs7'
    set ib_skillName[135] = "野兽幽魂"
    set ib_skillCustom[135] = 0
    set ib_skillList[136] = 'ACs8'
    set ib_skillName[136] = "灵兽"
    set ib_skillCustom[136] = 0
    set ib_skillList[137] = 'ACs9'
    set ib_skillName[137] = "野兽幽魂"
    set ib_skillCustom[137] = 0
    set ib_skillList[138] = 'ACsa'
    set ib_skillName[138] = "灼热之箭"
    set ib_skillCustom[138] = 0
    set ib_skillList[139] = 'ACsf'
    set ib_skillName[139] = "野兽幽魂"
    set ib_skillCustom[139] = 0
    set ib_skillList[140] = 'ACsh'
    set ib_skillName[140] = "震荡波"
    set ib_skillCustom[140] = 0
    set ib_skillList[141] = 'ACsi'
    set ib_skillName[141] = "沉默魔法"
    set ib_skillCustom[141] = 0
    set ib_skillList[142] = 'ACsk'
    set ib_skillName[142] = "抗性皮肤"
    set ib_skillCustom[142] = 0
    set ib_skillList[143] = 'ACsl'
    set ib_skillName[143] = "睡眠"
    set ib_skillCustom[143] = 0
    set ib_skillList[144] = 'ACsm'
    set ib_skillName[144] = "魔法吸吮"
    set ib_skillCustom[144] = 0
    set ib_skillList[145] = 'ACsp'
    set ib_skillName[145] = "睡眠"
    set ib_skillCustom[145] = 0
    set ib_skillList[146] = 'ACst'
    set ib_skillName[146] = "震荡波"
    set ib_skillCustom[146] = 0
    set ib_skillList[147] = 'ACsw'
    set ib_skillName[147] = "减速"
    set ib_skillCustom[147] = 0
    set ib_skillList[148] = 'ACt2'
    set ib_skillName[148] = "雷霆一击"
    set ib_skillCustom[148] = 0
    set ib_skillList[149] = 'ACtb'
    set ib_skillName[149] = "投石"
    set ib_skillCustom[149] = 0
    set ib_skillList[150] = 'ACtc'
    set ib_skillName[150] = "雷霆一击"
    set ib_skillCustom[150] = 0
    set ib_skillList[151] = 'ACtn'
    set ib_skillName[151] = "产卵触角"
    set ib_skillCustom[151] = 0
    set ib_skillList[152] = 'ACua'
    set ib_skillName[152] = "邪恶光环"
    set ib_skillCustom[152] = 0
    set ib_skillList[153] = 'ACuf'
    set ib_skillName[153] = "邪恶狂热"
    set ib_skillCustom[153] = 0
    set ib_skillList[154] = 'ACvp'
    set ib_skillName[154] = "八大光环"
    set ib_skillCustom[154] = 0
    set ib_skillList[155] = 'ACvs'
    set ib_skillName[155] = "浸毒武器"
    set ib_skillCustom[155] = 0
    set ib_skillList[156] = 'ACwb'
    set ib_skillName[156] = "蛛网"
    set ib_skillCustom[156] = 0
    set ib_skillList[157] = 'ACwe'
    set ib_skillName[157] = "召唤海元素"
    set ib_skillCustom[157] = 0
    set ib_skillList[158] = 'AEIl'
    set ib_skillName[158] = "变身"
    set ib_skillCustom[158] = 0
    set ib_skillList[159] = 'AEah'
    set ib_skillName[159] = "荆棘光环"
    set ib_skillCustom[159] = 0
endfunction
function IB_SkillFill2 takes nothing returns nothing
    set ib_skillList[160] = 'AEar'
    set ib_skillName[160] = "强击光环"
    set ib_skillCustom[160] = 0
    set ib_skillList[161] = 'AEbl'
    set ib_skillName[161] = "闪烁"
    set ib_skillCustom[161] = 0
    set ib_skillList[162] = 'AEbu'
    set ib_skillName[162] = "建造 (暗夜精灵)"
    set ib_skillCustom[162] = 0
    set ib_skillList[163] = 'AEer'
    set ib_skillName[163] = "纠缠根须"
    set ib_skillCustom[163] = 0
    set ib_skillList[164] = 'AEev'
    set ib_skillName[164] = "闪避"
    set ib_skillCustom[164] = 0
    set ib_skillList[165] = 'AEfk'
    set ib_skillName[165] = "刀阵旋风"
    set ib_skillCustom[165] = 0
    set ib_skillList[166] = 'AEfn'
    set ib_skillName[166] = "自然之力"
    set ib_skillCustom[166] = 0
    set ib_skillList[167] = 'AEim'
    set ib_skillName[167] = "献祭"
    set ib_skillCustom[167] = 0
    set ib_skillList[168] = 'AEmb'
    set ib_skillName[168] = "法力燃烧"
    set ib_skillCustom[168] = 0
    set ib_skillList[169] = 'AEme'
    set ib_skillName[169] = "变身"
    set ib_skillCustom[169] = 0
    set ib_skillList[170] = 'AEpa'
    set ib_skillName[170] = "毒箭"
    set ib_skillCustom[170] = 0
    set ib_skillList[171] = 'AEsb'
    set ib_skillName[171] = "群星坠落"
    set ib_skillCustom[171] = 0
    set ib_skillList[172] = 'AEsf'
    set ib_skillName[172] = "群星坠落"
    set ib_skillCustom[172] = 0
    set ib_skillList[173] = 'AEsh'
    set ib_skillName[173] = "暗影突袭"
    set ib_skillCustom[173] = 0
    set ib_skillList[174] = 'AEst'
    set ib_skillName[174] = "侦察"
    set ib_skillCustom[174] = 0
    set ib_skillList[175] = 'AEsv'
    set ib_skillName[175] = "复仇之魂"
    set ib_skillCustom[175] = 0
    set ib_skillList[176] = 'AEtq'
    set ib_skillName[176] = "宁静"
    set ib_skillCustom[176] = 0
    set ib_skillList[177] = 'AEvi'
    set ib_skillName[177] = "变身"
    set ib_skillCustom[177] = 0
    set ib_skillList[178] = 'AGbu'
    set ib_skillName[178] = "建造(娜迦)"
    set ib_skillCustom[178] = 0
    set ib_skillList[179] = 'AHab'
    set ib_skillName[179] = "辉煌光环"
    set ib_skillCustom[179] = 0
    set ib_skillList[180] = 'AHad'
    set ib_skillName[180] = "专注光环"
    set ib_skillCustom[180] = 0
    set ib_skillList[181] = 'AHav'
    set ib_skillName[181] = "天神下凡"
    set ib_skillCustom[181] = 0
    set ib_skillList[182] = 'AHbh'
    set ib_skillName[182] = "重击"
    set ib_skillCustom[182] = 0
    set ib_skillList[183] = 'AHbn'
    set ib_skillName[183] = "驱散"
    set ib_skillCustom[183] = 0
    set ib_skillList[184] = 'AHbu'
    set ib_skillName[184] = "建造(人族)"
    set ib_skillCustom[184] = 0
    set ib_skillList[185] = 'AHbz'
    set ib_skillName[185] = "暴风雪"
    set ib_skillCustom[185] = 0
    set ib_skillList[186] = 'AHca'
    set ib_skillName[186] = "冰冻冷箭"
    set ib_skillCustom[186] = 0
    set ib_skillList[187] = 'AHdr'
    set ib_skillName[187] = "魔法吸吮"
    set ib_skillCustom[187] = 0
    set ib_skillList[188] = 'AHds'
    set ib_skillName[188] = "神圣护甲"
    set ib_skillCustom[188] = 0
    set ib_skillList[189] = 'AHer'
    set ib_skillName[189] = "英雄"
    set ib_skillCustom[189] = 0
    set ib_skillList[190] = 'AHfa'
    set ib_skillName[190] = "灼热之箭"
    set ib_skillCustom[190] = 0
    set ib_skillList[191] = 'AHfs'
    set ib_skillName[191] = "烈焰风暴"
    set ib_skillCustom[191] = 0
    set ib_skillList[192] = 'AHhb'
    set ib_skillName[192] = "神圣之光"
    set ib_skillCustom[192] = 0
    set ib_skillList[193] = 'AHmt'
    set ib_skillName[193] = "群体传送"
    set ib_skillCustom[193] = 0
    set ib_skillList[194] = 'AHpx'
    set ib_skillName[194] = "火凤凰"
    set ib_skillCustom[194] = 0
    set ib_skillList[195] = 'AHre'
    set ib_skillName[195] = "复活"
    set ib_skillCustom[195] = 0
    set ib_skillList[196] = 'AHta'
    set ib_skillName[196] = "显示"
    set ib_skillCustom[196] = 0
    set ib_skillList[197] = 'AHtb'
    set ib_skillName[197] = "风暴之锤"
    set ib_skillCustom[197] = 0
    set ib_skillList[198] = 'AHtc'
    set ib_skillName[198] = "雷霆一击"
    set ib_skillCustom[198] = 0
    set ib_skillList[199] = 'AHwe'
    set ib_skillName[199] = "召唤水元素"
    set ib_skillCustom[199] = 0
    set ib_skillList[200] = 'AI2m'
    set ib_skillName[200] = "能增加魔法值的物品(200)"
    set ib_skillCustom[200] = 0
    set ib_skillList[201] = 'AIa1'
    set ib_skillName[201] = "能提高英雄属性的物品"
    set ib_skillCustom[201] = 0
    set ib_skillList[202] = 'AIa3'
    set ib_skillName[202] = "能提高英雄属性的物品"
    set ib_skillCustom[202] = 0
    set ib_skillList[203] = 'AIa4'
    set ib_skillName[203] = "能提高英雄属性的物品"
    set ib_skillCustom[203] = 0
    set ib_skillList[204] = 'AIa6'
    set ib_skillName[204] = "能提高英雄属性的物品"
    set ib_skillCustom[204] = 0
    set ib_skillList[205] = 'AIaa'
    set ib_skillName[205] = "能增加攻击力的物品"
    set ib_skillCustom[205] = 0
    set ib_skillList[206] = 'AIab'
    set ib_skillName[206] = "能提高英雄属性的物品"
    set ib_skillCustom[206] = 0
    set ib_skillList[207] = 'AIam'
    set ib_skillName[207] = "能增加敏捷度的物品"
    set ib_skillCustom[207] = 0
    set ib_skillList[208] = 'AIan'
    set ib_skillName[208] = "能操纵死尸的物品"
    set ib_skillCustom[208] = 0
    set ib_skillList[209] = 'AIas'
    set ib_skillName[209] = "能提高攻击速度的物品"
    set ib_skillCustom[209] = 0
    set ib_skillList[210] = 'AIat'
    set ib_skillName[210] = "增加攻击力的物品"
    set ib_skillCustom[210] = 0
    set ib_skillList[211] = 'AIaz'
    set ib_skillName[211] = "能提高英雄属性的物品"
    set ib_skillCustom[211] = 0
    set ib_skillList[212] = 'AIbb'
    set ib_skillName[212] = "建造微型铁匠铺"
    set ib_skillCustom[212] = 0
    set ib_skillList[213] = 'AIbf'
    set ib_skillName[213] = "建造微型农场"
    set ib_skillCustom[213] = 0
    set ib_skillList[214] = 'AIbg'
    set ib_skillName[214] = "建造小型的大厅"
    set ib_skillCustom[214] = 0
    set ib_skillList[215] = 'AIbh'
    set ib_skillName[215] = "建造微型国王祭坛"
    set ib_skillCustom[215] = 0
    set ib_skillList[216] = 'AIbk'
    set ib_skillName[216] = "闪烁(物品等级)"
    set ib_skillCustom[216] = 0
    set ib_skillList[217] = 'AIbl'
    set ib_skillName[217] = "建造小型的城堡"
    set ib_skillCustom[217] = 0
    set ib_skillList[218] = 'AIbm'
    set ib_skillName[218] = "能增加魔法值的物品"
    set ib_skillCustom[218] = 0
    set ib_skillList[219] = 'AIbr'
    set ib_skillName[219] = "建造微型伐木场"
    set ib_skillCustom[219] = 0
    set ib_skillList[220] = 'AIbs'
    set ib_skillName[220] = "建造微型兵营"
    set ib_skillCustom[220] = 0
    set ib_skillList[221] = 'AIbt'
    set ib_skillName[221] = "建造小型的哨塔"
    set ib_skillCustom[221] = 0
    set ib_skillList[222] = 'AIbx'
    set ib_skillName[222] = "重击"
    set ib_skillCustom[222] = 0
    set ib_skillList[223] = 'AIcb'
    set ib_skillName[223] = "带有腐蚀攻击效果的物品"
    set ib_skillCustom[223] = 0
    set ib_skillList[224] = 'AIcf'
    set ib_skillName[224] = "具有献祭效果的物品"
    set ib_skillCustom[224] = 0
    set ib_skillList[225] = 'AIcl'
    set ib_skillName[225] = "闪电链"
    set ib_skillCustom[225] = 0
    set ib_skillList[226] = 'AIcm'
    set ib_skillName[226] = "控制魔法"
    set ib_skillCustom[226] = 0
    set ib_skillList[227] = 'AIco'
    set ib_skillName[227] = "命令物品"
    set ib_skillCustom[227] = 0
    set ib_skillList[228] = 'AIcs'
    set ib_skillName[228] = "致命一击"
    set ib_skillCustom[228] = 0
    set ib_skillList[229] = 'AIct'
    set ib_skillName[229] = "改变一天的时间"
    set ib_skillCustom[229] = 0
    set ib_skillList[230] = 'AIcy'
    set ib_skillName[230] = "飓风"
    set ib_skillCustom[230] = 0
    set ib_skillList[231] = 'AId0'
    set ib_skillName[231] = "能提高护甲的物品"
    set ib_skillCustom[231] = 0
    set ib_skillList[232] = 'AId1'
    set ib_skillName[232] = "能提高护甲的物品"
    set ib_skillCustom[232] = 0
    set ib_skillList[233] = 'AId2'
    set ib_skillName[233] = "能提高护甲的物品"
    set ib_skillCustom[233] = 0
    set ib_skillList[234] = 'AId3'
    set ib_skillName[234] = "能提高护甲的物品"
    set ib_skillCustom[234] = 0
    set ib_skillList[235] = 'AId4'
    set ib_skillName[235] = "能提高护甲的物品"
    set ib_skillCustom[235] = 0
    set ib_skillList[236] = 'AId5'
    set ib_skillName[236] = "能提高护甲的物品"
    set ib_skillCustom[236] = 0
    set ib_skillList[237] = 'AId7'
    set ib_skillName[237] = "能加强护甲的物品"
    set ib_skillCustom[237] = 0
    set ib_skillList[238] = 'AId8'
    set ib_skillName[238] = "能提高护甲的物品"
    set ib_skillCustom[238] = 0
    set ib_skillList[239] = 'AIda'
    set ib_skillName[239] = "能暂时提高一定范围内所有单位护甲的物品"
    set ib_skillCustom[239] = 0
endfunction
function IB_SkillFill3 takes nothing returns nothing
    set ib_skillList[240] = 'AIdb'
    set ib_skillName[240] = "能暂时加强范围内所有单位护甲的物品"
    set ib_skillCustom[240] = 0
    set ib_skillList[241] = 'AIdc'
    set ib_skillName[241] = "带有锁链驱逐效果的物品"
    set ib_skillCustom[241] = 0
    set ib_skillList[242] = 'AIdd'
    set ib_skillName[242] = "passive defense"
    set ib_skillCustom[242] = 0
    set ib_skillList[243] = 'AIde'
    set ib_skillName[243] = "能增加护甲的物品"
    set ib_skillCustom[243] = 0
    set ib_skillList[244] = 'AIdf'
    set ib_skillName[244] = "能带有黑箭攻击伤害的物品"
    set ib_skillCustom[244] = 0
    set ib_skillList[245] = 'AIdi'
    set ib_skillName[245] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[245] = 0
    set ib_skillList[246] = 'AIdm'
    set ib_skillName[246] = "能对范围内的树木/墙壁造成伤害的物品"
    set ib_skillCustom[246] = 0
    set ib_skillList[247] = 'AIdn'
    set ib_skillName[247] = "影子之球 技能"
    set ib_skillCustom[247] = 0
    set ib_skillList[248] = 'AIdp'
    set ib_skillName[248] = "死亡契约"
    set ib_skillCustom[248] = 0
    set ib_skillList[249] = 'AIds'
    set ib_skillName[249] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[249] = 0
    set ib_skillList[250] = 'AIdv'
    set ib_skillName[250] = "物品神圣护甲"
    set ib_skillCustom[250] = 0
    set ib_skillList[251] = 'AIe2'
    set ib_skillName[251] = "能获取经验值的物品"
    set ib_skillCustom[251] = 0
    set ib_skillList[252] = 'AIem'
    set ib_skillName[252] = "能获取经验值的物品"
    set ib_skillCustom[252] = 0
    set ib_skillList[253] = 'AIev'
    set ib_skillName[253] = "闪避"
    set ib_skillCustom[253] = 0
    set ib_skillList[254] = 'AIfa'
    set ib_skillName[254] = "信号枪"
    set ib_skillCustom[254] = 0
    set ib_skillList[255] = 'AIfb'
    set ib_skillName[255] = "能带有火焰伤害的物品"
    set ib_skillCustom[255] = 0
    set ib_skillList[256] = 'AIfc'
    set ib_skillName[256] = "飞行地毯"
    set ib_skillCustom[256] = 0
    set ib_skillList[257] = 'AIfd'
    set ib_skillName[257] = "能召唤红龙的物品"
    set ib_skillCustom[257] = 0
    set ib_skillList[258] = 'AIfe'
    set ib_skillName[258] = "抢夺旗帜"
    set ib_skillCustom[258] = 0
    set ib_skillList[259] = 'AIff'
    set ib_skillName[259] = "能召唤熊怪的物品"
    set ib_skillCustom[259] = 0
    set ib_skillList[260] = 'AIfg'
    set ib_skillName[260] = "乌云技能"
    set ib_skillCustom[260] = 0
    set ib_skillList[261] = 'AIfh'
    set ib_skillName[261] = "能召唤地狱犬的物品"
    set ib_skillCustom[261] = 0
    set ib_skillList[262] = 'AIfi'
    set ib_skillName[262] = "霹雳闪电物品"
    set ib_skillCustom[262] = 0
    set ib_skillList[263] = 'AIfl'
    set ib_skillName[263] = "抢夺旗帜"
    set ib_skillCustom[263] = 0
    set ib_skillList[264] = 'AIfm'
    set ib_skillName[264] = "抢夺旗帜"
    set ib_skillCustom[264] = 0
    set ib_skillList[265] = 'AIfn'
    set ib_skillName[265] = "抢夺旗帜"
    set ib_skillCustom[265] = 0
    set ib_skillList[266] = 'AIfo'
    set ib_skillName[266] = "抢夺旗帜"
    set ib_skillCustom[266] = 0
    set ib_skillList[267] = 'AIfr'
    set ib_skillName[267] = "能召唤岩石傀儡的物品"
    set ib_skillCustom[267] = 0
    set ib_skillList[268] = 'AIfs'
    set ib_skillName[268] = "能召唤骷髅战士的物品"
    set ib_skillCustom[268] = 0
    set ib_skillList[269] = 'AIft'
    set ib_skillName[269] = "近战攻击带有冰冻伤害"
    set ib_skillCustom[269] = 0
    set ib_skillList[270] = 'AIfu'
    set ib_skillName[270] = "能召唤毁灭守卫的物品"
    set ib_skillCustom[270] = 0
    set ib_skillList[271] = 'AIfw'
    set ib_skillName[271] = "近战攻击带有火焰伤害"
    set ib_skillCustom[271] = 0
    set ib_skillList[272] = 'AIfx'
    set ib_skillName[272] = "物品兽族战斗标准"
    set ib_skillCustom[272] = 0
    set ib_skillList[273] = 'AIfz'
    set ib_skillName[273] = "死亡之指"
    set ib_skillCustom[273] = 0
    set ib_skillList[274] = 'AIgd'
    set ib_skillName[274] = "能带有火焰伤害的物品"
    set ib_skillCustom[274] = 0
    set ib_skillList[275] = 'AIgf'
    set ib_skillName[275] = "防御浮雕"
    set ib_skillCustom[275] = 0
    set ib_skillList[276] = 'AIgm'
    set ib_skillName[276] = "能增加敏捷度的物品"
    set ib_skillCustom[276] = 0
    set ib_skillList[277] = 'AIgo'
    set ib_skillName[277] = "金箱子"
    set ib_skillCustom[277] = 0
    set ib_skillList[278] = 'AIgu'
    set ib_skillName[278] = "防御浮雕"
    set ib_skillCustom[278] = 0
    set ib_skillList[279] = 'AIgx'
    set ib_skillName[279] = "恢复光环"
    set ib_skillCustom[279] = 0
    set ib_skillList[280] = 'AIh1'
    set ib_skillName[280] = "具有医疗效果的物品"
    set ib_skillCustom[280] = 0
    set ib_skillList[281] = 'AIh2'
    set ib_skillName[281] = "具有医疗效果的物品"
    set ib_skillCustom[281] = 0
    set ib_skillList[282] = 'AIh3'
    set ib_skillName[282] = "最小的医疗能力"
    set ib_skillCustom[282] = 0
    set ib_skillList[283] = 'AIha'
    set ib_skillName[283] = "能进行范围医疗的物品"
    set ib_skillCustom[283] = 0
    set ib_skillList[284] = 'AIhb'
    set ib_skillName[284] = "能进行范围医疗的物品"
    set ib_skillCustom[284] = 0
    set ib_skillList[285] = 'AIhe'
    set ib_skillName[285] = "具有医疗效果的物品"
    set ib_skillCustom[285] = 0
    set ib_skillList[286] = 'AIhl'
    set ib_skillName[286] = "神圣之光"
    set ib_skillCustom[286] = 0
    set ib_skillList[287] = 'AIhw'
    set ib_skillName[287] = "治疗守卫"
    set ib_skillCustom[287] = 0
    set ib_skillList[288] = 'AIhx'
    set ib_skillName[288] = "具有医疗效果的物品"
    set ib_skillCustom[288] = 0
    set ib_skillList[289] = 'AIi1'
    set ib_skillName[289] = "能提高英雄属性的物品"
    set ib_skillCustom[289] = 0
    set ib_skillList[290] = 'AIi3'
    set ib_skillName[290] = "能提高英雄属性的物品"
    set ib_skillCustom[290] = 0
    set ib_skillList[291] = 'AIi4'
    set ib_skillName[291] = "能提高英雄属性的物品"
    set ib_skillCustom[291] = 0
    set ib_skillList[292] = 'AIi6'
    set ib_skillName[292] = "能提高英雄属性的物品"
    set ib_skillCustom[292] = 0
    set ib_skillList[293] = 'AIil'
    set ib_skillName[293] = "幻象物品"
    set ib_skillCustom[293] = 0
    set ib_skillList[294] = 'AIim'
    set ib_skillName[294] = "能提高智力的物品"
    set ib_skillCustom[294] = 0
    set ib_skillList[295] = 'AIir'
    set ib_skillName[295] = "能召唤冰冻幽灵的物品"
    set ib_skillCustom[295] = 0
    set ib_skillList[296] = 'AIl1'
    set ib_skillName[296] = "能增加生命值的物品"
    set ib_skillCustom[296] = 0
    set ib_skillList[297] = 'AIl2'
    set ib_skillName[297] = "能增加生命值的物品"
    set ib_skillCustom[297] = 0
    set ib_skillList[298] = 'AIlb'
    set ib_skillName[298] = "能带有闪电伤害的物品"
    set ib_skillCustom[298] = 0
    set ib_skillList[299] = 'AIlf'
    set ib_skillName[299] = "能增加生命值的物品"
    set ib_skillCustom[299] = 0
    set ib_skillList[300] = 'AIll'
    set ib_skillName[300] = "闪电之球(新的)"
    set ib_skillCustom[300] = 0
    set ib_skillList[301] = 'AIlm'
    set ib_skillName[301] = "能提高等级的物品"
    set ib_skillCustom[301] = 0
    set ib_skillList[302] = 'AIlp'
    set ib_skillName[302] = "带有净化效果的物品"
    set ib_skillCustom[302] = 0
    set ib_skillList[303] = 'AIls'
    set ib_skillName[303] = "闪电护盾"
    set ib_skillCustom[303] = 0
    set ib_skillList[304] = 'AIlu'
    set ib_skillName[304] = "木材堆"
    set ib_skillCustom[304] = 0
    set ib_skillList[305] = 'AIlx'
    set ib_skillName[305] = "近战攻击带有闪电伤害"
    set ib_skillCustom[305] = 0
    set ib_skillList[306] = 'AIlz'
    set ib_skillName[306] = "能增加生命值的物品"
    set ib_skillCustom[306] = 0
    set ib_skillList[307] = 'AIm1'
    set ib_skillName[307] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[307] = 0
    set ib_skillList[308] = 'AIm2'
    set ib_skillName[308] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[308] = 0
    set ib_skillList[309] = 'AIma'
    set ib_skillName[309] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[309] = 0
    set ib_skillList[310] = 'AImb'
    set ib_skillName[310] = "能增加魔法值的物品"
    set ib_skillCustom[310] = 0
    set ib_skillList[311] = 'AImh'
    set ib_skillName[311] = "能永久增加生命值的物品"
    set ib_skillCustom[311] = 0
    set ib_skillList[312] = 'AImi'
    set ib_skillName[312] = "能增加生命值的物品"
    set ib_skillCustom[312] = 0
    set ib_skillList[313] = 'AIml'
    set ib_skillName[313] = "能增加生命值的物品"
    set ib_skillCustom[313] = 0
    set ib_skillList[314] = 'AImm'
    set ib_skillName[314] = "能增加魔法值的物品"
    set ib_skillCustom[314] = 0
    set ib_skillList[315] = 'AImo'
    set ib_skillName[315] = "怪兽诱捕守卫"
    set ib_skillCustom[315] = 0
    set ib_skillList[316] = 'AImr'
    set ib_skillName[316] = "能提高一定范围内所有单位魔法值的物品"
    set ib_skillCustom[316] = 0
    set ib_skillList[317] = 'AIms'
    set ib_skillName[317] = "能提高移动速度的物品"
    set ib_skillCustom[317] = 0
    set ib_skillList[318] = 'AImt'
    set ib_skillName[318] = "传送权杖"
    set ib_skillCustom[318] = 0
    set ib_skillList[319] = 'AImv'
    set ib_skillName[319] = "能增加魔法值的物品(75)"
    set ib_skillCustom[319] = 0
endfunction
function IB_SkillFill4 takes nothing returns nothing
    set ib_skillList[320] = 'AImx'
    set ib_skillName[320] = "魔法免疫"
    set ib_skillCustom[320] = 0
    set ib_skillList[321] = 'AImz'
    set ib_skillName[321] = "能增加魔法值的物品(100)"
    set ib_skillCustom[321] = 0
    set ib_skillList[322] = 'AInd'
    set ib_skillName[322] = "鼓舞"
    set ib_skillCustom[322] = 0
    set ib_skillList[323] = 'AInm'
    set ib_skillName[323] = "能增加力量的物品"
    set ib_skillCustom[323] = 0
    set ib_skillList[324] = 'AInv'
    set ib_skillName[324] = "物品栏"
    set ib_skillCustom[324] = 0
    set ib_skillList[325] = 'AIob'
    set ib_skillName[325] = "带有霜冻攻击效果的物品"
    set ib_skillCustom[325] = 0
    set ib_skillList[326] = 'AIos'
    set ib_skillName[326] = "减速"
    set ib_skillCustom[326] = 0
    set ib_skillList[327] = 'AIp1'
    set ib_skillName[327] = "普通物品-回复效果"
    set ib_skillCustom[327] = 0
    set ib_skillList[328] = 'AIp2'
    set ib_skillName[328] = "普通物品-回复效果"
    set ib_skillCustom[328] = 0
    set ib_skillList[329] = 'AIp3'
    set ib_skillName[329] = "普通物品-回复效果"
    set ib_skillCustom[329] = 0
    set ib_skillList[330] = 'AIp4'
    set ib_skillName[330] = "普通物品-回复效果"
    set ib_skillCustom[330] = 0
    set ib_skillList[331] = 'AIp5'
    set ib_skillName[331] = "普通物品-回复效果"
    set ib_skillCustom[331] = 0
    set ib_skillList[332] = 'AIp6'
    set ib_skillName[332] = "普通物品-回复效果"
    set ib_skillCustom[332] = 0
    set ib_skillList[333] = 'AIpb'
    set ib_skillName[333] = "带有毒药效果的物品"
    set ib_skillCustom[333] = 0
    set ib_skillList[334] = 'AIpg'
    set ib_skillName[334] = "带有净化效果的物品"
    set ib_skillCustom[334] = 0
    set ib_skillList[335] = 'AIpl'
    set ib_skillName[335] = "小净化药水"
    set ib_skillCustom[335] = 0
    set ib_skillList[336] = 'AIpm'
    set ib_skillName[336] = "能置放地精地雷的物品"
    set ib_skillCustom[336] = 0
    set ib_skillList[337] = 'AIpr'
    set ib_skillName[337] = "净化药水"
    set ib_skillCustom[337] = 0
    set ib_skillList[338] = 'AIps'
    set ib_skillName[338] = "带有净化效果的物品"
    set ib_skillCustom[338] = 0
    set ib_skillList[339] = 'AIpv'
    set ib_skillName[339] = "吸血药水"
    set ib_skillCustom[339] = 0
    set ib_skillList[340] = 'AIpx'
    set ib_skillName[340] = "能永久增加生命值的物品"
    set ib_skillCustom[340] = 0
    set ib_skillList[341] = 'AIpz'
    set ib_skillName[341] = "企鹅怪兽"
    set ib_skillCustom[341] = 0
    set ib_skillList[342] = 'AIra'
    set ib_skillName[342] = "能提高一定范围内所有单位魔法值和生命值的物品"
    set ib_skillCustom[342] = 0
    set ib_skillList[343] = 'AIrb'
    set ib_skillName[343] = "重生"
    set ib_skillCustom[343] = 0
    set ib_skillList[344] = 'AIrc'
    set ib_skillName[344] = "具有重生效果的物品"
    set ib_skillCustom[344] = 0
    set ib_skillList[345] = 'AIrd'
    set ib_skillName[345] = "复活死尸(物品)"
    set ib_skillCustom[345] = 0
    set ib_skillList[346] = 'AIre'
    set ib_skillName[346] = "能进行医疗和增加魔法值的单位"
    set ib_skillCustom[346] = 0
    set ib_skillList[347] = 'AIri'
    set ib_skillName[347] = "随机物品"
    set ib_skillCustom[347] = 0
    set ib_skillList[348] = 'AIrl'
    set ib_skillName[348] = "医疗剂"
    set ib_skillCustom[348] = 0
    set ib_skillList[349] = 'AIrm'
    set ib_skillName[349] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[349] = 0
    set ib_skillList[350] = 'AIrr'
    set ib_skillName[350] = "咆哮"
    set ib_skillCustom[350] = 0
    set ib_skillList[351] = 'AIrs'
    set ib_skillName[351] = "具有复活效果的物品"
    set ib_skillCustom[351] = 0
    set ib_skillList[352] = 'AIrt'
    set ib_skillName[352] = "召唤物品"
    set ib_skillCustom[352] = 0
    set ib_skillList[353] = 'AIrv'
    set ib_skillName[353] = "能显示整个地图的物品"
    set ib_skillCustom[353] = 0
    set ib_skillList[354] = 'AIrx'
    set ib_skillName[354] = "具有复活效果的物品"
    set ib_skillCustom[354] = 0
    set ib_skillList[355] = 'AIs1'
    set ib_skillName[355] = "能提高英雄属性的物品"
    set ib_skillCustom[355] = 0
    set ib_skillList[356] = 'AIs2'
    set ib_skillName[356] = "能提高进攻速度的物品"
    set ib_skillCustom[356] = 0
    set ib_skillList[357] = 'AIs3'
    set ib_skillName[357] = "能提高英雄属性的物品"
    set ib_skillCustom[357] = 0
    set ib_skillList[358] = 'AIs4'
    set ib_skillName[358] = "能提高英雄属性的物品"
    set ib_skillCustom[358] = 0
    set ib_skillList[359] = 'AIs6'
    set ib_skillName[359] = "能提高英雄属性的物品"
    set ib_skillCustom[359] = 0
    set ib_skillList[360] = 'AIsa'
    set ib_skillName[360] = "加速卷轴"
    set ib_skillCustom[360] = 0
    set ib_skillList[361] = 'AIsb'
    set ib_skillName[361] = "减速之球"
    set ib_skillCustom[361] = 0
    set ib_skillList[362] = 'AIse'
    set ib_skillName[362] = "物品沉默"
    set ib_skillCustom[362] = 0
    set ib_skillList[363] = 'AIsh'
    set ib_skillName[363] = "召唤巨魔猎头者"
    set ib_skillCustom[363] = 0
    set ib_skillList[364] = 'AIsi'
    set ib_skillName[364] = "能提高视野范围的物品"
    set ib_skillCustom[364] = 0
    set ib_skillList[365] = 'AIsl'
    set ib_skillName[365] = "恢复卷轴"
    set ib_skillCustom[365] = 0
    set ib_skillList[366] = 'AIsm'
    set ib_skillName[366] = "能增加力量的物品"
    set ib_skillCustom[366] = 0
    set ib_skillList[367] = 'AIso'
    set ib_skillName[367] = "能盗取单位灵魂的物品"
    set ib_skillCustom[367] = 0
    set ib_skillList[368] = 'AIsp'
    set ib_skillName[368] = "能暂时加快移动速度的物品"
    set ib_skillCustom[368] = 0
    set ib_skillList[369] = 'AIsr'
    set ib_skillName[369] = "魔法伤害减少"
    set ib_skillCustom[369] = 0
    set ib_skillList[370] = 'AIsw'
    set ib_skillName[370] = "岗哨守卫"
    set ib_skillCustom[370] = 0
    set ib_skillList[371] = 'AIsx'
    set ib_skillName[371] = "能提高攻击速度的物品"
    set ib_skillCustom[371] = 0
    set ib_skillList[372] = 'AIsz'
    set ib_skillName[372] = "慢性毒药"
    set ib_skillCustom[372] = 0
    set ib_skillList[373] = 'AIt6'
    set ib_skillName[373] = "增加攻击力的物品"
    set ib_skillCustom[373] = 0
    set ib_skillList[374] = 'AIt9'
    set ib_skillName[374] = "增加攻击力的物品"
    set ib_skillCustom[374] = 0
    set ib_skillList[375] = 'AIta'
    set ib_skillName[375] = "能探测一定区域的物品"
    set ib_skillCustom[375] = 0
    set ib_skillList[376] = 'AItb'
    set ib_skillName[376] = "尘土之影"
    set ib_skillCustom[376] = 0
    set ib_skillList[377] = 'AItc'
    set ib_skillName[377] = "增加攻击力的物品"
    set ib_skillCustom[377] = 0
    set ib_skillList[378] = 'AItf'
    set ib_skillName[378] = "增加攻击力的物品"
    set ib_skillCustom[378] = 0
    set ib_skillList[379] = 'AItg'
    set ib_skillName[379] = "增加攻击力的物品"
    set ib_skillCustom[379] = 0
    set ib_skillList[380] = 'AIth'
    set ib_skillName[380] = "增加攻击力的物品"
    set ib_skillCustom[380] = 0
    set ib_skillList[381] = 'AIti'
    set ib_skillName[381] = "增加攻击力的物品"
    set ib_skillCustom[381] = 0
    set ib_skillList[382] = 'AItj'
    set ib_skillName[382] = "增加攻击力的物品"
    set ib_skillCustom[382] = 0
    set ib_skillList[383] = 'AItk'
    set ib_skillName[383] = "增加攻击力的物品"
    set ib_skillCustom[383] = 0
    set ib_skillList[384] = 'AItl'
    set ib_skillName[384] = "增加攻击力的物品"
    set ib_skillCustom[384] = 0
    set ib_skillList[385] = 'AItm'
    set ib_skillName[385] = "能提高智力的物品"
    set ib_skillCustom[385] = 0
    set ib_skillList[386] = 'AItn'
    set ib_skillName[386] = "增加攻击力的物品"
    set ib_skillCustom[386] = 0
    set ib_skillList[387] = 'AItp'
    set ib_skillName[387] = "回城卷轴物品"
    set ib_skillCustom[387] = 0
    set ib_skillList[388] = 'AItx'
    set ib_skillName[388] = "增加攻击力的物品"
    set ib_skillCustom[388] = 0
    set ib_skillList[389] = 'AIuf'
    set ib_skillName[389] = "邪恶狂热"
    set ib_skillCustom[389] = 0
    set ib_skillList[390] = 'AIuv'
    set ib_skillName[390] = "夜视能力"
    set ib_skillCustom[390] = 0
    set ib_skillList[391] = 'AIuw'
    set ib_skillName[391] = "能召唤熊怪战士的物品"
    set ib_skillCustom[391] = 0
    set ib_skillList[392] = 'AIv1'
    set ib_skillName[392] = "能让单位暂时隐身的物品"
    set ib_skillCustom[392] = 0
    set ib_skillList[393] = 'AIv2'
    set ib_skillName[393] = "能让单位暂时隐身的物品"
    set ib_skillCustom[393] = 0
    set ib_skillList[394] = 'AIva'
    set ib_skillName[394] = "能盗取生命值的物品"
    set ib_skillCustom[394] = 0
    set ib_skillList[395] = 'AIvi'
    set ib_skillName[395] = "能让单位暂时隐身的物品"
    set ib_skillCustom[395] = 0
    set ib_skillList[396] = 'AIvl'
    set ib_skillName[396] = "能让单位暂时无敌的物品"
    set ib_skillCustom[396] = 0
    set ib_skillList[397] = 'AIvu'
    set ib_skillName[397] = "能让单位暂时无敌的物品"
    set ib_skillCustom[397] = 0
    set ib_skillList[398] = 'AIwb'
    set ib_skillName[398] = "带有蛛网技能的物品"
    set ib_skillCustom[398] = 0
    set ib_skillList[399] = 'AIwm'
    set ib_skillName[399] = "水奴"
    set ib_skillCustom[399] = 0
endfunction
function IB_SkillFill5 takes nothing returns nothing
    set ib_skillList[400] = 'AIx1'
    set ib_skillName[400] = "能提高英雄属性的物品"
    set ib_skillCustom[400] = 0
    set ib_skillList[401] = 'AIx2'
    set ib_skillName[401] = "能提高英雄属性的物品"
    set ib_skillCustom[401] = 0
    set ib_skillList[402] = 'AIx5'
    set ib_skillName[402] = "能提高英雄属性的物品"
    set ib_skillCustom[402] = 0
    set ib_skillList[403] = 'AIxk'
    set ib_skillName[403] = "狂暴愤怒"
    set ib_skillCustom[403] = 0
    set ib_skillList[404] = 'AIxm'
    set ib_skillName[404] = "能提高英雄三个属性的物品"
    set ib_skillCustom[404] = 0
    set ib_skillList[405] = 'AIxs'
    set ib_skillName[405] = "具有反魔法盾的物品"
    set ib_skillCustom[405] = 0
    set ib_skillList[406] = 'AIzb'
    set ib_skillName[406] = "带有冰冻攻击伤害的物品"
    set ib_skillCustom[406] = 0
    set ib_skillList[407] = 'ANab'
    set ib_skillName[407] = "酸性炸弹"
    set ib_skillCustom[407] = 0
    set ib_skillList[408] = 'ANak'
    set ib_skillName[408] = "刚毛飞射"
    set ib_skillCustom[408] = 0
    set ib_skillList[409] = 'ANav'
    set ib_skillName[409] = "天神下凡"
    set ib_skillCustom[409] = 0
    set ib_skillList[410] = 'ANb2'
    set ib_skillName[410] = "重击"
    set ib_skillCustom[410] = 0
    set ib_skillList[411] = 'ANba'
    set ib_skillName[411] = "黑暗之箭"
    set ib_skillCustom[411] = 0
    set ib_skillList[412] = 'ANbf'
    set ib_skillName[412] = "火焰呼吸"
    set ib_skillCustom[412] = 0
    set ib_skillList[413] = 'ANbh'
    set ib_skillName[413] = "重击"
    set ib_skillCustom[413] = 0
    set ib_skillList[414] = 'ANbl'
    set ib_skillName[414] = "闪烁"
    set ib_skillCustom[414] = 0
    set ib_skillList[415] = 'ANbr'
    set ib_skillName[415] = "战争咆哮"
    set ib_skillCustom[415] = 0
    set ib_skillList[416] = 'ANbs'
    set ib_skillName[416] = "黑暗之球"
    set ib_skillCustom[416] = 0
    set ib_skillList[417] = 'ANbu'
    set ib_skillName[417] = "建造(中立)"
    set ib_skillCustom[417] = 0
    set ib_skillList[418] = 'ANc1'
    set ib_skillName[418] = "火箭群"
    set ib_skillCustom[418] = 0
    set ib_skillList[419] = 'ANc2'
    set ib_skillName[419] = "火箭群"
    set ib_skillCustom[419] = 0
    set ib_skillList[420] = 'ANc3'
    set ib_skillName[420] = "火箭群"
    set ib_skillCustom[420] = 0
    set ib_skillList[421] = 'ANca'
    set ib_skillName[421] = "分裂攻击"
    set ib_skillCustom[421] = 0
    set ib_skillList[422] = 'ANcf'
    set ib_skillName[422] = "火焰呼吸"
    set ib_skillCustom[422] = 0
    set ib_skillList[423] = 'ANch'
    set ib_skillName[423] = "符咒"
    set ib_skillCustom[423] = 0
    set ib_skillList[424] = 'ANcl'
    set ib_skillName[424] = "通魔"
    set ib_skillCustom[424] = 0
    set ib_skillList[425] = 'ANcr'
    set ib_skillName[425] = "化学风暴"
    set ib_skillCustom[425] = 0
    set ib_skillList[426] = 'ANcs'
    set ib_skillName[426] = "火箭群"
    set ib_skillCustom[426] = 0
    set ib_skillList[427] = 'ANd1'
    set ib_skillName[427] = "粉碎"
    set ib_skillCustom[427] = 0
    set ib_skillList[428] = 'ANd2'
    set ib_skillName[428] = "粉碎"
    set ib_skillCustom[428] = 0
    set ib_skillList[429] = 'ANd3'
    set ib_skillName[429] = "粉碎"
    set ib_skillCustom[429] = 0
    set ib_skillList[430] = 'ANdb'
    set ib_skillName[430] = "醉拳"
    set ib_skillCustom[430] = 0
    set ib_skillList[431] = 'ANdc'
    set ib_skillName[431] = "黑暗转换"
    set ib_skillCustom[431] = 0
    set ib_skillList[432] = 'ANde'
    set ib_skillName[432] = "粉碎"
    set ib_skillCustom[432] = 0
    set ib_skillList[433] = 'ANdh'
    set ib_skillName[433] = "醉酒云雾"
    set ib_skillCustom[433] = 0
    set ib_skillList[434] = 'ANdo'
    set ib_skillName[434] = "末日审判"
    set ib_skillCustom[434] = 0
    set ib_skillList[435] = 'ANdp'
    set ib_skillName[435] = "黑暗之门"
    set ib_skillCustom[435] = 0
    set ib_skillList[436] = 'ANdr'
    set ib_skillName[436] = "生命汲取"
    set ib_skillCustom[436] = 0
    set ib_skillList[437] = 'ANef'
    set ib_skillName[437] = "\"火土风暴\""
    set ib_skillCustom[437] = 0
    set ib_skillList[438] = 'ANeg'
    set ib_skillName[438] = "工程升级"
    set ib_skillCustom[438] = 0
    set ib_skillList[439] = 'ANen'
    set ib_skillName[439] = "诱捕"
    set ib_skillCustom[439] = 0
    set ib_skillList[440] = 'ANf1'
    set ib_skillName[440] = "工厂"
    set ib_skillCustom[440] = 0
    set ib_skillList[441] = 'ANf2'
    set ib_skillName[441] = "工厂"
    set ib_skillCustom[441] = 0
    set ib_skillList[442] = 'ANf3'
    set ib_skillName[442] = "工厂"
    set ib_skillCustom[442] = 0
    set ib_skillList[443] = 'ANfa'
    set ib_skillName[443] = "霜冻之箭"
    set ib_skillCustom[443] = 0
    set ib_skillList[444] = 'ANfb'
    set ib_skillName[444] = "霹雳闪电"
    set ib_skillCustom[444] = 0
    set ib_skillList[445] = 'ANfd'
    set ib_skillName[445] = "死亡之指"
    set ib_skillCustom[445] = 0
    set ib_skillList[446] = 'ANfl'
    set ib_skillName[446] = "叉状闪电"
    set ib_skillCustom[446] = 0
    set ib_skillList[447] = 'ANfs'
    set ib_skillName[447] = "烈焰风暴"
    set ib_skillCustom[447] = 0
    set ib_skillList[448] = 'ANfy'
    set ib_skillName[448] = "工厂"
    set ib_skillCustom[448] = 0
    set ib_skillList[449] = 'ANg1'
    set ib_skillName[449] = "机器人地精"
    set ib_skillCustom[449] = 0
    set ib_skillList[450] = 'ANg2'
    set ib_skillName[450] = "机器人地精"
    set ib_skillCustom[450] = 0
    set ib_skillList[451] = 'ANg3'
    set ib_skillName[451] = "机器人地精"
    set ib_skillCustom[451] = 0
    set ib_skillList[452] = 'ANgl'
    set ib_skillName[452] = "用黄金交换木材"
    set ib_skillCustom[452] = 0
    set ib_skillList[453] = 'ANha'
    set ib_skillName[453] = "采集"
    set ib_skillCustom[453] = 0
    set ib_skillList[454] = 'ANhs'
    set ib_skillName[454] = "医疗气雾"
    set ib_skillCustom[454] = 0
    set ib_skillList[455] = 'ANht'
    set ib_skillName[455] = "恐怖嚎叫"
    set ib_skillCustom[455] = 0
    set ib_skillList[456] = 'ANhw'
    set ib_skillName[456] = "医疗波"
    set ib_skillCustom[456] = 0
    set ib_skillList[457] = 'ANhx'
    set ib_skillName[457] = "妖术"
    set ib_skillCustom[457] = 0
    set ib_skillList[458] = 'ANia'
    set ib_skillName[458] = "燃灰"
    set ib_skillCustom[458] = 0
    set ib_skillList[459] = 'ANic'
    set ib_skillName[459] = "燃灰"
    set ib_skillCustom[459] = 0
    set ib_skillList[460] = 'ANin'
    set ib_skillName[460] = "地狱火"
    set ib_skillCustom[460] = 0
    set ib_skillList[461] = 'ANlg'
    set ib_skillName[461] = "用木材交换黄金"
    set ib_skillCustom[461] = 0
    set ib_skillList[462] = 'ANlm'
    set ib_skillName[462] = "召唤炎魔"
    set ib_skillCustom[462] = 0
    set ib_skillList[463] = 'ANmo'
    set ib_skillName[463] = "季风"
    set ib_skillCustom[463] = 0
    set ib_skillList[464] = 'ANmr'
    set ib_skillName[464] = "心灵腐烂"
    set ib_skillCustom[464] = 0
    set ib_skillList[465] = 'ANms'
    set ib_skillName[465] = "魔法护盾"
    set ib_skillCustom[465] = 0
    set ib_skillList[466] = 'ANpa'
    set ib_skillName[466] = "寄生虫"
    set ib_skillCustom[466] = 0
    set ib_skillList[467] = 'ANpi'
    set ib_skillName[467] = "永久的献祭"
    set ib_skillCustom[467] = 0
    set ib_skillList[468] = 'ANpr'
    set ib_skillName[468] = "保存权杖"
    set ib_skillCustom[468] = 0
    set ib_skillList[469] = 'ANr2'
    set ib_skillName[469] = "重生"
    set ib_skillCustom[469] = 0
    set ib_skillList[470] = 'ANr3'
    set ib_skillName[470] = "混乱之雨"
    set ib_skillCustom[470] = 0
    set ib_skillList[471] = 'ANrc'
    set ib_skillName[471] = "混乱之雨"
    set ib_skillCustom[471] = 0
    set ib_skillList[472] = 'ANre'
    set ib_skillName[472] = "魔法恢复光环"
    set ib_skillCustom[472] = 0
    set ib_skillList[473] = 'ANrf'
    set ib_skillName[473] = "火焰雨"
    set ib_skillCustom[473] = 0
    set ib_skillList[474] = 'ANrg'
    set ib_skillName[474] = "机器人地精"
    set ib_skillCustom[474] = 0
    set ib_skillList[475] = 'ANrl'
    set ib_skillName[475] = "生命值恢复速度"
    set ib_skillCustom[475] = 0
    set ib_skillList[476] = 'ANrn'
    set ib_skillName[476] = "重生"
    set ib_skillCustom[476] = 0
    set ib_skillList[477] = 'ANs1'
    set ib_skillName[477] = "口袋工厂"
    set ib_skillCustom[477] = 0
    set ib_skillList[478] = 'ANs2'
    set ib_skillName[478] = "口袋工厂"
    set ib_skillCustom[478] = 0
    set ib_skillList[479] = 'ANs3'
    set ib_skillName[479] = "口袋工厂"
    set ib_skillCustom[479] = 0
endfunction
function IB_SkillFill6 takes nothing returns nothing
    set ib_skillList[480] = 'ANsa'
    set ib_skillName[480] = "避难权杖"
    set ib_skillCustom[480] = 0
    set ib_skillList[481] = 'ANsb'
    set ib_skillName[481] = "风暴之锤"
    set ib_skillCustom[481] = 0
    set ib_skillList[482] = 'ANse'
    set ib_skillName[482] = "魔法护盾"
    set ib_skillCustom[482] = 0
    set ib_skillList[483] = 'ANsg'
    set ib_skillName[483] = "召唤熊"
    set ib_skillCustom[483] = 0
    set ib_skillList[484] = 'ANsh'
    set ib_skillName[484] = "震荡波"
    set ib_skillCustom[484] = 0
    set ib_skillList[485] = 'ANsi'
    set ib_skillName[485] = "沉默魔法"
    set ib_skillCustom[485] = 0
    set ib_skillList[486] = 'ANsl'
    set ib_skillName[486] = "灵魂保存"
    set ib_skillCustom[486] = 0
    set ib_skillList[487] = 'ANso'
    set ib_skillName[487] = "灵魂燃烧"
    set ib_skillCustom[487] = 0
    set ib_skillList[488] = 'ANsp'
    set ib_skillName[488] = "间谍"
    set ib_skillCustom[488] = 0
    set ib_skillList[489] = 'ANsq'
    set ib_skillName[489] = "召唤豪猪"
    set ib_skillCustom[489] = 0
    set ib_skillList[490] = 'ANss'
    set ib_skillName[490] = "魔法护盾"
    set ib_skillCustom[490] = 0
    set ib_skillList[491] = 'ANst'
    set ib_skillName[491] = "惊吓"
    set ib_skillCustom[491] = 0
    set ib_skillList[492] = 'ANsw'
    set ib_skillName[492] = "召唤战鹰"
    set ib_skillCustom[492] = 0
    set ib_skillList[493] = 'ANsy'
    set ib_skillName[493] = "口袋工厂"
    set ib_skillCustom[493] = 0
    set ib_skillList[494] = 'ANt2'
    set ib_skillName[494] = "尖刺外壳"
    set ib_skillCustom[494] = 0
    set ib_skillList[495] = 'ANta'
    set ib_skillName[495] = "嘲讽"
    set ib_skillCustom[495] = 0
    set ib_skillList[496] = 'ANth'
    set ib_skillName[496] = "尖刺外壳"
    set ib_skillCustom[496] = 0
    set ib_skillList[497] = 'ANtm'
    set ib_skillName[497] = "点金术"
    set ib_skillCustom[497] = 0
    set ib_skillList[498] = 'ANto'
    set ib_skillName[498] = "龙卷风"
    set ib_skillCustom[498] = 0
    set ib_skillList[499] = 'ANtr'
    set ib_skillName[499] = "真实视域"
    set ib_skillCustom[499] = 0
    set ib_skillList[500] = 'ANvc'
    set ib_skillName[500] = "火山爆发"
    set ib_skillCustom[500] = 0
    set ib_skillList[501] = 'ANwk'
    set ib_skillName[501] = "疾风步"
    set ib_skillCustom[501] = 0
    set ib_skillList[502] = 'ANwm'
    set ib_skillName[502] = "水奴"
    set ib_skillCustom[502] = 0
    set ib_skillList[503] = 'AOac'
    set ib_skillName[503] = "命令光环"
    set ib_skillCustom[503] = 0
    set ib_skillList[504] = 'AOae'
    set ib_skillName[504] = "耐久光环"
    set ib_skillCustom[504] = 0
    set ib_skillList[505] = 'AObu'
    set ib_skillName[505] = "建造(兽族)"
    set ib_skillCustom[505] = 0
    set ib_skillList[506] = 'AOcl'
    set ib_skillName[506] = "闪电链"
    set ib_skillCustom[506] = 0
    set ib_skillList[507] = 'AOcr'
    set ib_skillName[507] = "致命一击"
    set ib_skillCustom[507] = 0
    set ib_skillList[508] = 'AOeq'
    set ib_skillName[508] = "地震"
    set ib_skillCustom[508] = 0
    set ib_skillList[509] = 'AOfs'
    set ib_skillName[509] = "透视"
    set ib_skillCustom[509] = 0
    set ib_skillList[510] = 'AOhw'
    set ib_skillName[510] = "医疗波"
    set ib_skillCustom[510] = 0
    set ib_skillList[511] = 'AOhx'
    set ib_skillName[511] = "妖术"
    set ib_skillCustom[511] = 0
    set ib_skillList[512] = 'AOls'
    set ib_skillName[512] = "巫毒幽魂"
    set ib_skillCustom[512] = 0
    set ib_skillList[513] = 'AOmi'
    set ib_skillName[513] = "镜像"
    set ib_skillCustom[513] = 0
    set ib_skillList[514] = 'AOr2'
    set ib_skillName[514] = "耐久光环"
    set ib_skillCustom[514] = 0
    set ib_skillList[515] = 'AOr3'
    set ib_skillName[515] = "重生"
    set ib_skillCustom[515] = 0
    set ib_skillList[516] = 'AOre'
    set ib_skillName[516] = "重生"
    set ib_skillCustom[516] = 0
    set ib_skillList[517] = 'AOs2'
    set ib_skillName[517] = "震荡波"
    set ib_skillCustom[517] = 0
    set ib_skillList[518] = 'AOsf'
    set ib_skillName[518] = "野兽幽魂"
    set ib_skillCustom[518] = 0
    set ib_skillList[519] = 'AOsh'
    set ib_skillName[519] = "震荡波"
    set ib_skillCustom[519] = 0
    set ib_skillList[520] = 'AOsw'
    set ib_skillName[520] = "毒蛇守卫"
    set ib_skillCustom[520] = 0
    set ib_skillList[521] = 'AOvd'
    set ib_skillName[521] = "巫毒"
    set ib_skillCustom[521] = 0
    set ib_skillList[522] = 'AOw2'
    set ib_skillName[522] = "战争践踏"
    set ib_skillCustom[522] = 0
    set ib_skillList[523] = 'AOwk'
    set ib_skillName[523] = "疾步风"
    set ib_skillCustom[523] = 0
    set ib_skillList[524] = 'AOws'
    set ib_skillName[524] = "战争践踏"
    set ib_skillCustom[524] = 0
    set ib_skillList[525] = 'AOww'
    set ib_skillName[525] = "剑刃风暴"
    set ib_skillCustom[525] = 0
    set ib_skillList[526] = 'APdi'
    set ib_skillName[526] = "力量上升驱散"
    set ib_skillCustom[526] = 0
    set ib_skillList[527] = 'APh1'
    set ib_skillName[527] = "力量上升治疗区域减小"
    set ib_skillCustom[527] = 0
    set ib_skillList[528] = 'APh2'
    set ib_skillName[528] = "力量上升治疗区域"
    set ib_skillCustom[528] = 0
    set ib_skillList[529] = 'APh3'
    set ib_skillName[529] = "力量上升治疗区域增强"
    set ib_skillCustom[529] = 0
    set ib_skillList[530] = 'APmg'
    set ib_skillName[530] = "神秘区域魔法恢复增强"
    set ib_skillCustom[530] = 0
    set ib_skillList[531] = 'APmr'
    set ib_skillName[531] = "神秘区域魔法恢复"
    set ib_skillCustom[531] = 0
    set ib_skillList[532] = 'APra'
    set ib_skillName[532] = "神秘区域生命/魔法恢复"
    set ib_skillCustom[532] = 0
    set ib_skillList[533] = 'APrl'
    set ib_skillName[533] = "小型复活神符"
    set ib_skillCustom[533] = 0
    set ib_skillList[534] = 'APrr'
    set ib_skillName[534] = "大型复活神符"
    set ib_skillCustom[534] = 0
    set ib_skillList[535] = 'APsa'
    set ib_skillName[535] = "速度神符"
    set ib_skillCustom[535] = 0
    set ib_skillList[536] = 'APwt'
    set ib_skillName[536] = "岗哨神符"
    set ib_skillCustom[536] = 0
    set ib_skillList[537] = 'ARal'
    set ib_skillName[537] = "集结"
    set ib_skillCustom[537] = 0
    set ib_skillList[538] = 'AUan'
    set ib_skillName[538] = "操纵死尸"
    set ib_skillCustom[538] = 0
    set ib_skillList[539] = 'AUau'
    set ib_skillName[539] = "邪恶光环"
    set ib_skillCustom[539] = 0
    set ib_skillList[540] = 'AUav'
    set ib_skillName[540] = "吸血光环"
    set ib_skillCustom[540] = 0
    set ib_skillList[541] = 'AUbu'
    set ib_skillName[541] = "建造(不死族)"
    set ib_skillCustom[541] = 0
    set ib_skillList[542] = 'AUcb'
    set ib_skillName[542] = "腐尸甲虫"
    set ib_skillCustom[542] = 0
    set ib_skillList[543] = 'AUcs'
    set ib_skillName[543] = "腐臭蜂群"
    set ib_skillCustom[543] = 0
    set ib_skillList[544] = 'AUdc'
    set ib_skillName[544] = "死亡缠绕"
    set ib_skillCustom[544] = 0
    set ib_skillList[545] = 'AUdd'
    set ib_skillName[545] = "死亡凋零"
    set ib_skillCustom[545] = 0
    set ib_skillList[546] = 'AUdp'
    set ib_skillName[546] = "死亡契约"
    set ib_skillCustom[546] = 0
    set ib_skillList[547] = 'AUdr'
    set ib_skillName[547] = "黑暗仪式"
    set ib_skillCustom[547] = 0
    set ib_skillList[548] = 'AUds'
    set ib_skillName[548] = "黑暗召唤"
    set ib_skillCustom[548] = 0
    set ib_skillList[549] = 'AUfa'
    set ib_skillName[549] = "霜冻护甲"
    set ib_skillCustom[549] = 0
    set ib_skillList[550] = 'AUfn'
    set ib_skillName[550] = "霜冻新星"
    set ib_skillCustom[550] = 0
    set ib_skillList[551] = 'AUfu'
    set ib_skillName[551] = "霜冻护甲"
    set ib_skillCustom[551] = 0
    set ib_skillList[552] = 'AUim'
    set ib_skillName[552] = "穿刺"
    set ib_skillCustom[552] = 0
    set ib_skillList[553] = 'AUin'
    set ib_skillName[553] = "地狱火"
    set ib_skillCustom[553] = 0
    set ib_skillList[554] = 'AUls'
    set ib_skillName[554] = "蝗虫群"
    set ib_skillCustom[554] = 0
    set ib_skillList[555] = 'AUmd'
    set ib_skillName[555] = "黑暗召唤(马哥尼斯)"
    set ib_skillCustom[555] = 0
    set ib_skillList[556] = 'AUsl'
    set ib_skillName[556] = "睡眠"
    set ib_skillCustom[556] = 0
    set ib_skillList[557] = 'AUts'
    set ib_skillName[557] = "尖刺外壳"
    set ib_skillCustom[557] = 0
    set ib_skillList[558] = 'Aabr'
    set ib_skillName[558] = "荒芜光环"
    set ib_skillCustom[558] = 0
    set ib_skillList[559] = 'Aabs'
    set ib_skillName[559] = "吸收魔法"
    set ib_skillCustom[559] = 0
endfunction
function IB_SkillFill7 takes nothing returns nothing
    set ib_skillList[560] = 'Aadm'
    set ib_skillName[560] = "驱逐魔法"
    set ib_skillCustom[560] = 0
    set ib_skillList[561] = 'Aaha'
    set ib_skillName[561] = "采集"
    set ib_skillCustom[561] = 0
    set ib_skillList[562] = 'Aakb'
    set ib_skillName[562] = "战鼓"
    set ib_skillCustom[562] = 0
    set ib_skillList[563] = 'Aall'
    set ib_skillName[563] = "共享商店，联盟建筑物"
    set ib_skillCustom[563] = 0
    set ib_skillList[564] = 'Aalr'
    set ib_skillName[564] = "警报"
    set ib_skillCustom[564] = 0
    set ib_skillList[565] = 'Aam2'
    set ib_skillName[565] = "反魔法外壳"
    set ib_skillCustom[565] = 0
    set ib_skillList[566] = 'Aami'
    set ib_skillName[566] = "具有反魔法盾的物品"
    set ib_skillCustom[566] = 0
    set ib_skillList[567] = 'Aamk'
    set ib_skillName[567] = "属性附加"
    set ib_skillCustom[567] = 0
    set ib_skillList[568] = 'Aams'
    set ib_skillName[568] = "反魔法外壳"
    set ib_skillCustom[568] = 0
    set ib_skillList[569] = 'Aap1'
    set ib_skillName[569] = "疾病云雾"
    set ib_skillCustom[569] = 0
    set ib_skillList[570] = 'Aap2'
    set ib_skillName[570] = "疾病云雾"
    set ib_skillCustom[570] = 0
    set ib_skillList[571] = 'Aap3'
    set ib_skillName[571] = "疾病云雾"
    set ib_skillCustom[571] = 0
    set ib_skillList[572] = 'Aap4'
    set ib_skillName[572] = "疾病云雾"
    set ib_skillCustom[572] = 0
    set ib_skillList[573] = 'Aapl'
    set ib_skillName[573] = "疾病云雾"
    set ib_skillCustom[573] = 0
    set ib_skillList[574] = 'Aarm'
    set ib_skillName[574] = "魔法恢复光环"
    set ib_skillCustom[574] = 0
    set ib_skillList[575] = 'Aasl'
    set ib_skillName[575] = "减速光环"
    set ib_skillCustom[575] = 0
    set ib_skillList[576] = 'Aast'
    set ib_skillName[576] = "先祖幽灵"
    set ib_skillCustom[576] = 0
    set ib_skillList[577] = 'Aatk'
    set ib_skillName[577] = "攻击"
    set ib_skillCustom[577] = 0
    set ib_skillList[578] = 'Aave'
    set ib_skillName[578] = "破坏者形态"
    set ib_skillCustom[578] = 0
    set ib_skillList[579] = 'Aawa'
    set ib_skillName[579] = "立刻复活英雄"
    set ib_skillCustom[579] = 0
    set ib_skillList[580] = 'Abdl'
    set ib_skillName[580] = "大型荒芜之地驱散"
    set ib_skillCustom[580] = 0
    set ib_skillList[581] = 'Abds'
    set ib_skillName[581] = "小型荒芜之地驱散"
    set ib_skillCustom[581] = 0
    set ib_skillList[582] = 'Abdt'
    set ib_skillName[582] = "钻地探测"
    set ib_skillCustom[582] = 0
    set ib_skillList[583] = 'Abgl'
    set ib_skillName[583] = "大型荒芜之地蔓延"
    set ib_skillCustom[583] = 0
    set ib_skillList[584] = 'Abgm'
    set ib_skillName[584] = "闹鬼金矿技能"
    set ib_skillCustom[584] = 0
    set ib_skillList[585] = 'Abgs'
    set ib_skillName[585] = "小型荒芜之地蔓延"
    set ib_skillCustom[585] = 0
    set ib_skillList[586] = 'Abli'
    set ib_skillName[586] = "荒芜之地"
    set ib_skillCustom[586] = 0
    set ib_skillList[587] = 'Ablo'
    set ib_skillName[587] = "嗜血术"
    set ib_skillCustom[587] = 0
    set ib_skillList[588] = 'Ablp'
    set ib_skillName[588] = "荒芜之地的置放"
    set ib_skillCustom[588] = 0
    set ib_skillList[589] = 'Abof'
    set ib_skillName[589] = "燃烧之油"
    set ib_skillCustom[589] = 0
    set ib_skillList[590] = 'Abrf'
    set ib_skillName[590] = "变熊"
    set ib_skillCustom[590] = 0
    set ib_skillList[591] = 'Absk'
    set ib_skillName[591] = "狂战士"
    set ib_skillCustom[591] = 0
    set ib_skillList[592] = 'Abtl'
    set ib_skillName[592] = "战斗位置"
    set ib_skillCustom[592] = 0
    set ib_skillList[593] = 'Abu2'
    set ib_skillName[593] = "钻地"
    set ib_skillCustom[593] = 0
    set ib_skillList[594] = 'Abu3'
    set ib_skillName[594] = "钻地"
    set ib_skillCustom[594] = 0
    set ib_skillList[595] = 'Abu5'
    set ib_skillName[595] = "钻地"
    set ib_skillCustom[595] = 0
    set ib_skillList[596] = 'Abun'
    set ib_skillName[596] = "货物保持 (兽族地洞)"
    set ib_skillCustom[596] = 0
    set ib_skillList[597] = 'Abur'
    set ib_skillName[597] = "钻地"
    set ib_skillCustom[597] = 0
    set ib_skillList[598] = 'Acan'
    set ib_skillName[598] = "吞食尸体"
    set ib_skillCustom[598] = 0
    set ib_skillList[599] = 'Acar'
    set ib_skillName[599] = "货物保持"
    set ib_skillCustom[599] = 0
    set ib_skillList[600] = 'Acdb'
    set ib_skillName[600] = "醉拳"
    set ib_skillCustom[600] = 0
    set ib_skillList[601] = 'Acdh'
    set ib_skillName[601] = "醉酒云雾"
    set ib_skillCustom[601] = 0
    set ib_skillList[602] = 'Acef'
    set ib_skillName[602] = "\"火土风暴\""
    set ib_skillCustom[602] = 0
    set ib_skillList[603] = 'Acha'
    set ib_skillName[603] = "混乱的"
    set ib_skillCustom[603] = 0
    set ib_skillList[604] = 'Achd'
    set ib_skillName[604] = "运输船保持原位"
    set ib_skillCustom[604] = 0
    set ib_skillList[605] = 'Ache'
    set ib_skillName[605] = "瓦解光线"
    set ib_skillCustom[605] = 0
    set ib_skillList[606] = 'Achl'
    set ib_skillName[606] = "装载"
    set ib_skillCustom[606] = 0
    set ib_skillList[607] = 'Acht'
    set ib_skillName[607] = "恐怖嚎叫"
    set ib_skillCustom[607] = 0
    set ib_skillList[608] = 'Aclf'
    set ib_skillName[608] = "乌云技能"
    set ib_skillCustom[608] = 0
    set ib_skillList[609] = 'Acmg'
    set ib_skillName[609] = "控制魔法"
    set ib_skillCustom[609] = 0
    set ib_skillList[610] = 'Acn2'
    set ib_skillName[610] = "吞食尸体"
    set ib_skillCustom[610] = 0
    set ib_skillList[611] = 'Acny'
    set ib_skillName[611] = "飓风"
    set ib_skillCustom[611] = 0
    set ib_skillList[612] = 'Aco2'
    set ib_skillName[612] = "骑乘角鹰兽"
    set ib_skillCustom[612] = 0
    set ib_skillList[613] = 'Aco3'
    set ib_skillName[613] = "搭载弓箭手"
    set ib_skillCustom[613] = 0
    set ib_skillList[614] = 'Acoa'
    set ib_skillName[614] = "骑乘角鹰兽"
    set ib_skillCustom[614] = 0
    set ib_skillList[615] = 'Acoh'
    set ib_skillName[615] = "搭载弓箭手"
    set ib_skillCustom[615] = 0
    set ib_skillList[616] = 'Acor'
    set ib_skillName[616] = "腐蚀喷吐"
    set ib_skillCustom[616] = 0
    set ib_skillList[617] = 'Acpf'
    set ib_skillName[617] = "灵肉形态"
    set ib_skillCustom[617] = 0
    set ib_skillList[618] = 'Acri'
    set ib_skillName[618] = "残废"
    set ib_skillCustom[618] = 0
    set ib_skillList[619] = 'Acrs'
    set ib_skillName[619] = "诅咒"
    set ib_skillCustom[619] = 0
    set ib_skillList[620] = 'Acyc'
    set ib_skillName[620] = "飓风"
    set ib_skillCustom[620] = 0
    set ib_skillList[621] = 'Adch'
    set ib_skillName[621] = "消魔"
    set ib_skillCustom[621] = 0
    set ib_skillList[622] = 'Adcn'
    set ib_skillName[622] = "消魔"
    set ib_skillCustom[622] = 0
    set ib_skillList[623] = 'Adda'
    set ib_skillName[623] = "范围性攻击伤害"
    set ib_skillCustom[623] = 0
    set ib_skillList[624] = 'Adec'
    set ib_skillName[624] = "卸载"
    set ib_skillCustom[624] = 0
    set ib_skillList[625] = 'Adef'
    set ib_skillName[625] = "防御"
    set ib_skillCustom[625] = 0
    set ib_skillList[626] = 'Adet'
    set ib_skillName[626] = "探测者"
    set ib_skillCustom[626] = 0
    set ib_skillList[627] = 'Adev'
    set ib_skillName[627] = "吞噬"
    set ib_skillCustom[627] = 0
    set ib_skillList[628] = 'Adis'
    set ib_skillName[628] = "驱逐魔法"
    set ib_skillCustom[628] = 0
    set ib_skillList[629] = 'Adri'
    set ib_skillName[629] = "立刻卸载"
    set ib_skillCustom[629] = 0
    set ib_skillList[630] = 'Adro'
    set ib_skillName[630] = "卸载"
    set ib_skillCustom[630] = 0
    set ib_skillList[631] = 'Adsm'
    set ib_skillName[631] = "驱逐魔法"
    set ib_skillCustom[631] = 0
    set ib_skillList[632] = 'Adt1'
    set ib_skillName[632] = "探测者"
    set ib_skillCustom[632] = 0
    set ib_skillList[633] = 'Adta'
    set ib_skillName[633] = "显示"
    set ib_skillCustom[633] = 0
    set ib_skillList[634] = 'Adtg'
    set ib_skillName[634] = "真实视域"
    set ib_skillCustom[634] = 0
    set ib_skillList[635] = 'Adtn'
    set ib_skillName[635] = "爆炸"
    set ib_skillCustom[635] = 0
    set ib_skillList[636] = 'Adts'
    set ib_skillName[636] = "魔法岗哨"
    set ib_skillCustom[636] = 0
    set ib_skillList[637] = 'Advc'
    set ib_skillName[637] = "吞噬货物"
    set ib_skillCustom[637] = 0
    set ib_skillList[638] = 'Advm'
    set ib_skillName[638] = "吞噬魔法"
    set ib_skillCustom[638] = 0
    set ib_skillList[639] = 'Aeat'
    set ib_skillName[639] = "吞食树木"
    set ib_skillCustom[639] = 0
endfunction
function IB_SkillFill8 takes nothing returns nothing
    set ib_skillList[640] = 'Aegm'
    set ib_skillName[640] = "缠绕金矿技能"
    set ib_skillCustom[640] = 0
    set ib_skillList[641] = 'Aegr'
    set ib_skillName[641] = "艾鲁尼之优雅"
    set ib_skillCustom[641] = 0
    set ib_skillList[642] = 'Aenc'
    set ib_skillName[642] = "装载"
    set ib_skillCustom[642] = 0
    set ib_skillList[643] = 'Aenr'
    set ib_skillName[643] = "纠缠根须"
    set ib_skillCustom[643] = 0
    set ib_skillList[644] = 'Aens'
    set ib_skillName[644] = "诱捕"
    set ib_skillCustom[644] = 0
    set ib_skillList[645] = 'Aent'
    set ib_skillName[645] = "缠绕金矿"
    set ib_skillCustom[645] = 0
    set ib_skillList[646] = 'Aenw'
    set ib_skillName[646] = "纠缠根须"
    set ib_skillCustom[646] = 0
    set ib_skillList[647] = 'Aesn'
    set ib_skillName[647] = "哨兵"
    set ib_skillCustom[647] = 0
    set ib_skillList[648] = 'Aesr'
    set ib_skillName[648] = "哨兵"
    set ib_skillCustom[648] = 0
    set ib_skillList[649] = 'Aetf'
    set ib_skillName[649] = "虚无形态"
    set ib_skillCustom[649] = 0
    set ib_skillList[650] = 'Aeth'
    set ib_skillName[650] = "幽灵"
    set ib_skillCustom[650] = 0
    set ib_skillList[651] = 'Aetl'
    set ib_skillName[651] = "虚无状态"
    set ib_skillCustom[651] = 0
    set ib_skillList[652] = 'Aexh'
    set ib_skillName[652] = "挖掘尸体"
    set ib_skillCustom[652] = 0
    set ib_skillList[653] = 'Aeye'
    set ib_skillName[653] = "岗哨守卫"
    set ib_skillCustom[653] = 0
    set ib_skillList[654] = 'Afa2'
    set ib_skillName[654] = "精灵之火"
    set ib_skillCustom[654] = 0
    set ib_skillList[655] = 'Afae'
    set ib_skillName[655] = "精灵之火"
    set ib_skillCustom[655] = 0
    set ib_skillList[656] = 'Afak'
    set ib_skillName[656] = "毁灭之球"
    set ib_skillCustom[656] = 0
    set ib_skillList[657] = 'Afbb'
    set ib_skillName[657] = "反馈"
    set ib_skillCustom[657] = 0
    set ib_skillList[658] = 'Afbk'
    set ib_skillName[658] = "魔法回应"
    set ib_skillCustom[658] = 0
    set ib_skillList[659] = 'Afbt'
    set ib_skillName[659] = "魔法回应"
    set ib_skillCustom[659] = 0
    set ib_skillList[660] = 'Afih'
    set ib_skillName[660] = "着火(人族)"
    set ib_skillCustom[660] = 0
    set ib_skillList[661] = 'Afin'
    set ib_skillName[661] = "着火(暗夜精灵)"
    set ib_skillCustom[661] = 0
    set ib_skillList[662] = 'Afio'
    set ib_skillName[662] = "着火(兽族)"
    set ib_skillCustom[662] = 0
    set ib_skillList[663] = 'Afir'
    set ib_skillName[663] = "着火"
    set ib_skillCustom[663] = 0
    set ib_skillList[664] = 'Afiu'
    set ib_skillName[664] = "着火(不死族)"
    set ib_skillCustom[664] = 0
    set ib_skillList[665] = 'Afla'
    set ib_skillName[665] = "照明弹"
    set ib_skillCustom[665] = 0
    set ib_skillList[666] = 'Aflk'
    set ib_skillName[666] = "高射炮火"
    set ib_skillCustom[666] = 0
    set ib_skillList[667] = 'Afod'
    set ib_skillName[667] = "死亡之指"
    set ib_skillCustom[667] = 0
    set ib_skillList[668] = 'Afr2'
    set ib_skillName[668] = "霜冻攻击"
    set ib_skillCustom[668] = 0
    set ib_skillList[669] = 'Afra'
    set ib_skillName[669] = "霜之攻击"
    set ib_skillCustom[669] = 0
    set ib_skillList[670] = 'Afrb'
    set ib_skillName[670] = "霜冻呼吸"
    set ib_skillCustom[670] = 0
    set ib_skillList[671] = 'Afrz'
    set ib_skillName[671] = "冰冻喷吐"
    set ib_skillCustom[671] = 0
    set ib_skillList[672] = 'Afsh'
    set ib_skillName[672] = "碎片攻击"
    set ib_skillCustom[672] = 0
    set ib_skillList[673] = 'Afzy'
    set ib_skillName[673] = "狂热"
    set ib_skillCustom[673] = 0
    set ib_skillList[674] = 'Agho'
    set ib_skillName[674] = "幽灵"
    set ib_skillCustom[674] = 0
    set ib_skillList[675] = 'Agld'
    set ib_skillName[675] = "金矿能力"
    set ib_skillCustom[675] = 0
    set ib_skillList[676] = 'Agra'
    set ib_skillName[676] = "战棍"
    set ib_skillCustom[676] = 0
    set ib_skillList[677] = 'Agyb'
    set ib_skillName[677] = "飞行机器炸弹"
    set ib_skillCustom[677] = 0
    set ib_skillList[678] = 'Agyd'
    set ib_skillName[678] = "创建尸体"
    set ib_skillCustom[678] = 0
    set ib_skillList[679] = 'Agyv'
    set ib_skillName[679] = "真实视域"
    set ib_skillCustom[679] = 0
    set ib_skillList[680] = 'Ahar'
    set ib_skillName[680] = "采集"
    set ib_skillCustom[680] = 0
    set ib_skillList[681] = 'Ahea'
    set ib_skillName[681] = "医疗"
    set ib_skillCustom[681] = 0
    set ib_skillList[682] = 'Ahid'
    set ib_skillName[682] = "影遁"
    set ib_skillCustom[682] = 0
    set ib_skillList[683] = 'Ahnl'
    set ib_skillName[683] = "召唤仪式"
    set ib_skillCustom[683] = 0
    set ib_skillList[684] = 'Ahr2'
    set ib_skillName[684] = "采集"
    set ib_skillCustom[684] = 0
    set ib_skillList[685] = 'Ahr3'
    set ib_skillName[685] = "采集"
    set ib_skillCustom[685] = 0
    set ib_skillList[686] = 'Ahrl'
    set ib_skillName[686] = "采集"
    set ib_skillCustom[686] = 0
    set ib_skillList[687] = 'Ahrp'
    set ib_skillName[687] = "修理"
    set ib_skillCustom[687] = 0
    set ib_skillList[688] = 'Ahwd'
    set ib_skillName[688] = "治疗守卫"
    set ib_skillCustom[688] = 0
    set ib_skillList[689] = 'Aien'
    set ib_skillName[689] = "单位物品栏"
    set ib_skillCustom[689] = 0
    set ib_skillList[690] = 'Aihn'
    set ib_skillName[690] = "单位物品栏"
    set ib_skillCustom[690] = 0
    set ib_skillList[691] = 'Ainf'
    set ib_skillName[691] = "心灵之火"
    set ib_skillCustom[691] = 0
    set ib_skillList[692] = 'Aion'
    set ib_skillName[692] = "单位物品栏"
    set ib_skillCustom[692] = 0
    set ib_skillList[693] = 'Aiun'
    set ib_skillName[693] = "单位物品栏"
    set ib_skillCustom[693] = 0
    set ib_skillList[694] = 'Aivs'
    set ib_skillName[694] = "隐形术"
    set ib_skillCustom[694] = 0
    set ib_skillList[695] = 'Alam'
    set ib_skillName[695] = "牺牲"
    set ib_skillCustom[695] = 0
    set ib_skillList[696] = 'Aliq'
    set ib_skillName[696] = "液体炸弹"
    set ib_skillCustom[696] = 0
    set ib_skillList[697] = 'Alit'
    set ib_skillName[697] = "闪电攻击"
    set ib_skillCustom[697] = 0
    set ib_skillList[698] = 'Aloa'
    set ib_skillName[698] = "装载"
    set ib_skillCustom[698] = 0
    set ib_skillList[699] = 'Aloc'
    set ib_skillName[699] = "蝗虫"
    set ib_skillCustom[699] = 0
    set ib_skillList[700] = 'Alsh'
    set ib_skillName[700] = "闪电护盾"
    set ib_skillCustom[700] = 0
    set ib_skillList[701] = 'Amb2'
    set ib_skillName[701] = "恢复魔法"
    set ib_skillCustom[701] = 0
    set ib_skillList[702] = 'Ambb'
    set ib_skillName[702] = "法力燃烧"
    set ib_skillCustom[702] = 0
    set ib_skillList[703] = 'Ambd'
    set ib_skillName[703] = "法力燃烧"
    set ib_skillCustom[703] = 0
    set ib_skillList[704] = 'Ambt'
    set ib_skillName[704] = "补充魔法和生命值"
    set ib_skillCustom[704] = 0
    set ib_skillList[705] = 'Amdf'
    set ib_skillName[705] = "魔法防御"
    set ib_skillCustom[705] = 0
    set ib_skillList[706] = 'Amec'
    set ib_skillName[706] = "机械类的小玩艺"
    set ib_skillCustom[706] = 0
    set ib_skillList[707] = 'Amed'
    set ib_skillName[707] = "卸载尸体"
    set ib_skillCustom[707] = 0
    set ib_skillList[708] = 'Amel'
    set ib_skillName[708] = "得到尸体"
    set ib_skillCustom[708] = 0
    set ib_skillList[709] = 'Amfl'
    set ib_skillName[709] = "魔力之焰"
    set ib_skillCustom[709] = 0
    set ib_skillList[710] = 'Amgl'
    set ib_skillName[710] = "月刃"
    set ib_skillCustom[710] = 0
    set ib_skillList[711] = 'Amgr'
    set ib_skillName[711] = "月刃"
    set ib_skillCustom[711] = 0
    set ib_skillList[712] = 'Amic'
    set ib_skillName[712] = "战斗号召"
    set ib_skillCustom[712] = 0
    set ib_skillList[713] = 'Amil'
    set ib_skillName[713] = "战斗号召"
    set ib_skillCustom[713] = 0
    set ib_skillList[714] = 'Amim'
    set ib_skillName[714] = "魔法免疫"
    set ib_skillCustom[714] = 0
    set ib_skillList[715] = 'Amin'
    set ib_skillName[715] = "地雷引爆"
    set ib_skillCustom[715] = 0
    set ib_skillList[716] = 'Amls'
    set ib_skillName[716] = "空中锁镣"
    set ib_skillCustom[716] = 0
    set ib_skillList[717] = 'Amnb'
    set ib_skillName[717] = "法力燃烧"
    set ib_skillCustom[717] = 0
    set ib_skillList[718] = 'Amnx'
    set ib_skillName[718] = "范围性攻击伤害"
    set ib_skillCustom[718] = 0
    set ib_skillList[719] = 'Amnz'
    set ib_skillName[719] = "范围性攻击伤害"
    set ib_skillCustom[719] = 0
endfunction
function IB_SkillFill9 takes nothing returns nothing
    set ib_skillList[720] = 'Amou'
    set ib_skillName[720] = "骑乘"
    set ib_skillCustom[720] = 0
    set ib_skillList[721] = 'Amov'
    set ib_skillName[721] = "移动"
    set ib_skillCustom[721] = 0
    set ib_skillList[722] = 'Amrf'
    set ib_skillName[722] = "乌鸦形态"
    set ib_skillCustom[722] = 0
    set ib_skillList[723] = 'Amtc'
    set ib_skillName[723] = "保持原位"
    set ib_skillCustom[723] = 0
    set ib_skillList[724] = 'Andm'
    set ib_skillName[724] = "驱逐魔法"
    set ib_skillCustom[724] = 0
    set ib_skillList[725] = 'Andt'
    set ib_skillName[725] = "显示"
    set ib_skillCustom[725] = 0
    set ib_skillList[726] = 'Ane2'
    set ib_skillName[726] = "选择单位"
    set ib_skillCustom[726] = 0
    set ib_skillList[727] = 'Anei'
    set ib_skillName[727] = "选择使用者"
    set ib_skillCustom[727] = 0
    set ib_skillList[728] = 'Aneu'
    set ib_skillName[728] = "选择英雄"
    set ib_skillCustom[728] = 0
    set ib_skillList[729] = 'Anh1'
    set ib_skillName[729] = "医疗"
    set ib_skillCustom[729] = 0
    set ib_skillList[730] = 'Anh2'
    set ib_skillName[730] = "医疗"
    set ib_skillCustom[730] = 0
    set ib_skillList[731] = 'Anhe'
    set ib_skillName[731] = "医疗"
    set ib_skillCustom[731] = 0
    set ib_skillList[732] = 'Anit'
    set ib_skillName[732] = "跟踪"
    set ib_skillCustom[732] = 0
    set ib_skillList[733] = 'Ansk'
    set ib_skillName[733] = "硬化皮肤"
    set ib_skillCustom[733] = 0
    set ib_skillList[734] = 'Aoar'
    set ib_skillName[734] = "治疗守卫光环"
    set ib_skillCustom[734] = 0
    set ib_skillList[735] = 'Apak'
    set ib_skillName[735] = "行囊技能"
    set ib_skillCustom[735] = 0
    set ib_skillList[736] = 'Apg2'
    set ib_skillName[736] = "净化"
    set ib_skillCustom[736] = 0
    set ib_skillList[737] = 'Aphx'
    set ib_skillName[737] = "火凤凰变形(和凤凰蛋有关的)"
    set ib_skillCustom[737] = 0
    set ib_skillList[738] = 'Apig'
    set ib_skillName[738] = "永久的献祭"
    set ib_skillCustom[738] = 0
    set ib_skillList[739] = 'Apit'
    set ib_skillName[739] = "商店购买物品"
    set ib_skillCustom[739] = 0
    set ib_skillList[740] = 'Apiv'
    set ib_skillName[740] = "永久的隐形"
    set ib_skillCustom[740] = 0
    set ib_skillList[741] = 'Aply'
    set ib_skillName[741] = "变形术"
    set ib_skillCustom[741] = 0
    set ib_skillList[742] = 'Apmf'
    set ib_skillName[742] = "凤凰火焰"
    set ib_skillCustom[742] = 0
    set ib_skillList[743] = 'Apo2'
    set ib_skillName[743] = "毒刺"
    set ib_skillCustom[743] = 0
    set ib_skillList[744] = 'Apoi'
    set ib_skillName[744] = "毒刺"
    set ib_skillCustom[744] = 0
    set ib_skillList[745] = 'Apos'
    set ib_skillName[745] = "占据"
    set ib_skillCustom[745] = 0
    set ib_skillList[746] = 'Aprg'
    set ib_skillName[746] = "净化"
    set ib_skillCustom[746] = 0
    set ib_skillList[747] = 'Aps2'
    set ib_skillName[747] = "占据"
    set ib_skillCustom[747] = 0
    set ib_skillList[748] = 'Apsh'
    set ib_skillName[748] = "变相移动"
    set ib_skillCustom[748] = 0
    set ib_skillList[749] = 'Apts'
    set ib_skillName[749] = "疾病云雾"
    set ib_skillCustom[749] = 0
    set ib_skillList[750] = 'Apxf'
    set ib_skillName[750] = "凤凰火焰"
    set ib_skillCustom[750] = 0
    set ib_skillList[751] = 'Ara2'
    set ib_skillName[751] = "咆哮"
    set ib_skillCustom[751] = 0
    set ib_skillList[752] = 'Arai'
    set ib_skillName[752] = "复活死尸"
    set ib_skillCustom[752] = 0
    set ib_skillList[753] = 'Arav'
    set ib_skillName[753] = "风暴之鸦"
    set ib_skillCustom[753] = 0
    set ib_skillList[754] = 'Arbr'
    set ib_skillName[754] = "加强型地洞升级"
    set ib_skillCustom[754] = 0
    set ib_skillList[755] = 'Arej'
    set ib_skillName[755] = "生命恢复"
    set ib_skillCustom[755] = 0
    set ib_skillList[756] = 'Arel'
    set ib_skillName[756] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[756] = 0
    set ib_skillList[757] = 'Aren'
    set ib_skillName[757] = "更新"
    set ib_skillCustom[757] = 0
    set ib_skillList[758] = 'Arep'
    set ib_skillName[758] = "修理"
    set ib_skillCustom[758] = 0
    set ib_skillList[759] = 'Aret'
    set ib_skillName[759] = "再训练之书"
    set ib_skillCustom[759] = 0
    set ib_skillList[760] = 'Arev'
    set ib_skillName[760] = "复活英雄"
    set ib_skillCustom[760] = 0
    set ib_skillList[761] = 'Argd'
    set ib_skillName[761] = "送回黄金"
    set ib_skillCustom[761] = 0
    set ib_skillList[762] = 'Argl'
    set ib_skillName[762] = "送回黄金和木材"
    set ib_skillCustom[762] = 0
    set ib_skillList[763] = 'Arll'
    set ib_skillName[763] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[763] = 0
    set ib_skillList[764] = 'Arlm'
    set ib_skillName[764] = "送回木材"
    set ib_skillCustom[764] = 0
    set ib_skillList[765] = 'Arng'
    set ib_skillName[765] = "复仇"
    set ib_skillCustom[765] = 0
    set ib_skillList[766] = 'Aro1'
    set ib_skillName[766] = "扎根"
    set ib_skillCustom[766] = 0
    set ib_skillList[767] = 'Aro2'
    set ib_skillName[767] = "扎根"
    set ib_skillCustom[767] = 0
    set ib_skillList[768] = 'Aroa'
    set ib_skillName[768] = "咆哮"
    set ib_skillCustom[768] = 0
    set ib_skillList[769] = 'Aroc'
    set ib_skillName[769] = "弹幕攻击"
    set ib_skillCustom[769] = 0
    set ib_skillList[770] = 'Aroo'
    set ib_skillName[770] = "扎根"
    set ib_skillCustom[770] = 0
    set ib_skillList[771] = 'Arpb'
    set ib_skillName[771] = "补充魔法和生命值"
    set ib_skillCustom[771] = 0
    set ib_skillList[772] = 'Arpl'
    set ib_skillName[772] = "枯萎精髓"
    set ib_skillCustom[772] = 0
    set ib_skillList[773] = 'Arpm'
    set ib_skillName[773] = "灵魂触摸"
    set ib_skillCustom[773] = 0
    set ib_skillList[774] = 'Arsg'
    set ib_skillName[774] = "召唤米纱"
    set ib_skillCustom[774] = 0
    set ib_skillList[775] = 'Arsk'
    set ib_skillName[775] = "抗性皮肤"
    set ib_skillCustom[775] = 0
    set ib_skillList[776] = 'Arsp'
    set ib_skillName[776] = "惊吓"
    set ib_skillCustom[776] = 0
    set ib_skillList[777] = 'Arsq'
    set ib_skillName[777] = "召唤豪猪"
    set ib_skillCustom[777] = 0
    set ib_skillList[778] = 'Arst'
    set ib_skillName[778] = "恢复"
    set ib_skillCustom[778] = 0
    set ib_skillList[779] = 'Arsw'
    set ib_skillName[779] = "毒蛇守卫"
    set ib_skillCustom[779] = 0
    set ib_skillList[780] = 'Artn'
    set ib_skillName[780] = "返回"
    set ib_skillCustom[780] = 0
    set ib_skillList[781] = 'Asac'
    set ib_skillName[781] = "牺牲"
    set ib_skillCustom[781] = 0
    set ib_skillList[782] = 'Asal'
    set ib_skillName[782] = "掠夺"
    set ib_skillCustom[782] = 0
    set ib_skillList[783] = 'Asb1'
    set ib_skillName[783] = "潜水"
    set ib_skillCustom[783] = 0
    set ib_skillList[784] = 'Asb2'
    set ib_skillName[784] = "潜水"
    set ib_skillCustom[784] = 0
    set ib_skillList[785] = 'Asb3'
    set ib_skillName[785] = "潜水"
    set ib_skillCustom[785] = 0
    set ib_skillList[786] = 'Asd2'
    set ib_skillName[786] = "卡布恩"
    set ib_skillCustom[786] = 0
    set ib_skillList[787] = 'Asd3'
    set ib_skillName[787] = "卡布恩"
    set ib_skillCustom[787] = 0
    set ib_skillList[788] = 'Asdg'
    set ib_skillName[788] = "卡布恩"
    set ib_skillCustom[788] = 0
    set ib_skillList[789] = 'Asds'
    set ib_skillName[789] = "卡布恩"
    set ib_skillCustom[789] = 0
    set ib_skillList[790] = 'Ashm'
    set ib_skillName[790] = "影遁"
    set ib_skillCustom[790] = 0
    set ib_skillList[791] = 'Ashs'
    set ib_skillName[791] = "影子权杖"
    set ib_skillCustom[791] = 0
    set ib_skillList[792] = 'Asid'
    set ib_skillName[792] = "出售物品"
    set ib_skillCustom[792] = 0
    set ib_skillList[793] = 'Asla'
    set ib_skillName[793] = "一直睡眠"
    set ib_skillCustom[793] = 0
    set ib_skillList[794] = 'Aslo'
    set ib_skillName[794] = "减速"
    set ib_skillCustom[794] = 0
    set ib_skillList[795] = 'Aslp'
    set ib_skillName[795] = "召唤巨虾"
    set ib_skillCustom[795] = 0
    set ib_skillList[796] = 'Asod'
    set ib_skillName[796] = "产卵之骨"
    set ib_skillCustom[796] = 0
    set ib_skillList[797] = 'Asou'
    set ib_skillName[797] = "能占据单位灵魂的物品"
    set ib_skillCustom[797] = 0
    set ib_skillList[798] = 'Asp1'
    set ib_skillName[798] = "球体"
    set ib_skillCustom[798] = 0
    set ib_skillList[799] = 'Asp2'
    set ib_skillName[799] = "球体"
    set ib_skillCustom[799] = 0
endfunction
function IB_SkillFill10 takes nothing returns nothing
    set ib_skillList[800] = 'Asp3'
    set ib_skillName[800] = "球体"
    set ib_skillCustom[800] = 0
    set ib_skillList[801] = 'Asp4'
    set ib_skillName[801] = "球体"
    set ib_skillCustom[801] = 0
    set ib_skillList[802] = 'Asp5'
    set ib_skillName[802] = "球体"
    set ib_skillCustom[802] = 0
    set ib_skillList[803] = 'Asp6'
    set ib_skillName[803] = "球体"
    set ib_skillCustom[803] = 0
    set ib_skillList[804] = 'Aspa'
    set ib_skillName[804] = "蜘蛛攻击"
    set ib_skillCustom[804] = 0
    set ib_skillList[805] = 'Aspb'
    set ib_skillName[805] = "魔法书"
    set ib_skillCustom[805] = 0
    set ib_skillList[806] = 'Aspd'
    set ib_skillName[806] = "小蜘蛛"
    set ib_skillCustom[806] = 0
    set ib_skillList[807] = 'Asph'
    set ib_skillName[807] = "球体"
    set ib_skillCustom[807] = 0
    set ib_skillList[808] = 'Aspi'
    set ib_skillName[808] = "尖形路障"
    set ib_skillCustom[808] = 0
    set ib_skillList[809] = 'Aspl'
    set ib_skillName[809] = "灵魂锁链"
    set ib_skillCustom[809] = 0
    set ib_skillList[810] = 'Aspo'
    set ib_skillName[810] = "慢性毒药"
    set ib_skillCustom[810] = 0
    set ib_skillList[811] = 'Aspp'
    set ib_skillName[811] = "灵魂锁链"
    set ib_skillCustom[811] = 0
    set ib_skillList[812] = 'Asps'
    set ib_skillName[812] = "魔法盗取"
    set ib_skillCustom[812] = 0
    set ib_skillList[813] = 'Aspt'
    set ib_skillName[813] = "诞生刺蛇幼虫"
    set ib_skillCustom[813] = 0
    set ib_skillList[814] = 'Aspy'
    set ib_skillName[814] = "诞生刺蛇"
    set ib_skillCustom[814] = 0
    set ib_skillList[815] = 'Assk'
    set ib_skillName[815] = "硬化皮肤"
    set ib_skillCustom[815] = 0
    set ib_skillList[816] = 'Assp'
    set ib_skillName[816] = "小蜘蛛"
    set ib_skillCustom[816] = 0
    set ib_skillList[817] = 'Asta'
    set ib_skillName[817] = "静止陷阱"
    set ib_skillCustom[817] = 0
    set ib_skillList[818] = 'Astd'
    set ib_skillName[818] = "卸载苦工"
    set ib_skillCustom[818] = 0
    set ib_skillList[819] = 'Aste'
    set ib_skillName[819] = "盗取"
    set ib_skillCustom[819] = 0
    set ib_skillList[820] = 'Asth'
    set ib_skillName[820] = "风暴战锤"
    set ib_skillCustom[820] = 0
    set ib_skillList[821] = 'Astn'
    set ib_skillName[821] = "石像形态"
    set ib_skillCustom[821] = 0
    set ib_skillList[822] = 'Asud'
    set ib_skillName[822] = "出售单位"
    set ib_skillCustom[822] = 0
    set ib_skillList[823] = 'Atau'
    set ib_skillName[823] = "嘲讽"
    set ib_skillCustom[823] = 0
    set ib_skillList[824] = 'Atdg'
    set ib_skillName[824] = "建筑物破坏光环"
    set ib_skillCustom[824] = 0
    set ib_skillList[825] = 'Atdp'
    set ib_skillName[825] = "卸载驾驶员"
    set ib_skillCustom[825] = 0
    set ib_skillList[826] = 'Atlp'
    set ib_skillName[826] = "装载驾驶员"
    set ib_skillCustom[826] = 0
    set ib_skillList[827] = 'Atol'
    set ib_skillName[827] = "生命之树升级技能"
    set ib_skillCustom[827] = 0
    set ib_skillList[828] = 'Atru'
    set ib_skillName[828] = "真实视域"
    set ib_skillCustom[828] = 0
    set ib_skillList[829] = 'Atsp'
    set ib_skillName[829] = "龙卷旋风"
    set ib_skillCustom[829] = 0
    set ib_skillList[830] = 'Attu'
    set ib_skillName[830] = "坦克围城"
    set ib_skillCustom[830] = 0
    set ib_skillList[831] = 'Atwa'
    set ib_skillName[831] = "龙卷风漫步者"
    set ib_skillCustom[831] = 0
    set ib_skillList[832] = 'Auco'
    set ib_skillName[832] = "不稳定化合物"
    set ib_skillCustom[832] = 0
    set ib_skillList[833] = 'Auhf'
    set ib_skillName[833] = "邪恶狂热"
    set ib_skillCustom[833] = 0
    set ib_skillList[834] = 'Ault'
    set ib_skillName[834] = "夜视能力"
    set ib_skillCustom[834] = 0
    set ib_skillList[835] = 'Auns'
    set ib_skillName[835] = "反召唤建筑"
    set ib_skillCustom[835] = 0
    set ib_skillList[836] = 'Aven'
    set ib_skillName[836] = "浸毒武器"
    set ib_skillCustom[836] = 0
    set ib_skillList[837] = 'Avng'
    set ib_skillName[837] = "复仇之魂"
    set ib_skillCustom[837] = 0
    set ib_skillList[838] = 'Avul'
    set ib_skillName[838] = "无敌的"
    set ib_skillCustom[838] = 0
    set ib_skillList[839] = 'Awan'
    set ib_skillName[839] = "游荡者"
    set ib_skillCustom[839] = 0
    set ib_skillList[840] = 'Awar'
    set ib_skillName[840] = "粉碎"
    set ib_skillCustom[840] = 0
    set ib_skillList[841] = 'Aweb'
    set ib_skillName[841] = "蛛网"
    set ib_skillCustom[841] = 0
    set ib_skillList[842] = 'Awfb'
    set ib_skillName[842] = "霹雳闪电"
    set ib_skillCustom[842] = 0
    set ib_skillList[843] = 'Awh2'
    set ib_skillName[843] = "采集"
    set ib_skillCustom[843] = 0
    set ib_skillList[844] = 'Awha'
    set ib_skillName[844] = "采集"
    set ib_skillCustom[844] = 0
    set ib_skillList[845] = 'Awhe'
    set ib_skillName[845] = "医疗"
    set ib_skillCustom[845] = 0
    set ib_skillList[846] = 'Awrg'
    set ib_skillName[846] = "战争践踏"
    set ib_skillCustom[846] = 0
    set ib_skillList[847] = 'Awrh'
    set ib_skillName[847] = "战争践踏"
    set ib_skillCustom[847] = 0
    set ib_skillList[848] = 'Awrp'
    set ib_skillName[848] = "传送门技能"
    set ib_skillCustom[848] = 0
    set ib_skillList[849] = 'Awrs'
    set ib_skillName[849] = "战争践踏"
    set ib_skillCustom[849] = 0
    set ib_skillList[850] = 'Bdbb'
    set ib_skillName[850] = "吸取生命值和魔法值（附加）"
    set ib_skillCustom[850] = 0
    set ib_skillList[851] = 'Bdbl'
    set ib_skillName[851] = "吸取生命（附加）"
    set ib_skillCustom[851] = 0
    set ib_skillList[852] = 'Bdbm'
    set ib_skillName[852] = "吸取魔法（附加）"
    set ib_skillCustom[852] = 0
    set ib_skillList[853] = 'Bolt'
    set ib_skillName[853] = "圣光束"
    set ib_skillCustom[853] = 0
    set ib_skillList[854] = 'Deat'
    set ib_skillName[854] = "风暴旋风"
    set ib_skillCustom[854] = 0
    set ib_skillList[855] = 'Drag'
    set ib_skillName[855] = "飞龙在天"
    set ib_skillCustom[855] = 0
    set ib_skillList[856] = 'Dur1'
    set ib_skillName[856] = "闪电风暴"
    set ib_skillCustom[856] = 0
    set ib_skillList[857] = 'Glac'
    set ib_skillName[857] = "狂暴霜冻"
    set ib_skillCustom[857] = 0
    set ib_skillList[858] = 'Mons'
    set ib_skillName[858] = "剑刃闪电"
    set ib_skillCustom[858] = 0
    set ib_skillList[859] = 'SCae'
    set ib_skillName[859] = "耐久光环"
    set ib_skillCustom[859] = 0
    set ib_skillList[860] = 'SCc1'
    set ib_skillName[860] = "飓风"
    set ib_skillCustom[860] = 0
    set ib_skillList[861] = 'SCva'
    set ib_skillName[861] = "窃取生命"
    set ib_skillCustom[861] = 0
    set ib_skillList[862] = 'SNdc'
    set ib_skillName[862] = "黑暗转换"
    set ib_skillCustom[862] = 0
    set ib_skillList[863] = 'SNdd'
    set ib_skillName[863] = "死亡凋零"
    set ib_skillCustom[863] = 0
    set ib_skillList[864] = 'SNeq'
    set ib_skillName[864] = "地震"
    set ib_skillCustom[864] = 0
    set ib_skillList[865] = 'SNin'
    set ib_skillName[865] = "地狱火"
    set ib_skillCustom[865] = 0
    set ib_skillList[866] = 'Sbsk'
    set ib_skillName[866] = "狂暴愤怒升级"
    set ib_skillCustom[866] = 0
    set ib_skillList[867] = 'Sbtl'
    set ib_skillName[867] = "战备状态"
    set ib_skillCustom[867] = 0
    set ib_skillList[868] = 'Sch2'
    set ib_skillName[868] = "保持原位"
    set ib_skillCustom[868] = 0
    set ib_skillList[869] = 'Sch3'
    set ib_skillName[869] = "保持原位"
    set ib_skillCustom[869] = 0
    set ib_skillList[870] = 'Sch4'
    set ib_skillName[870] = "保持原位"
    set ib_skillCustom[870] = 0
    set ib_skillList[871] = 'Sch5'
    set ib_skillName[871] = "保持原位"
    set ib_skillCustom[871] = 0
    set ib_skillList[872] = 'Scri'
    set ib_skillName[872] = "残废"
    set ib_skillCustom[872] = 0
    set ib_skillList[873] = 'Sdro'
    set ib_skillName[873] = "卸载"
    set ib_skillCustom[873] = 0
    set ib_skillList[874] = 'Slo2'
    set ib_skillName[874] = "装载小精灵"
    set ib_skillCustom[874] = 0
    set ib_skillList[875] = 'Slo3'
    set ib_skillName[875] = "装载"
    set ib_skillCustom[875] = 0
    set ib_skillList[876] = 'Sloa'
    set ib_skillName[876] = "装载"
    set ib_skillCustom[876] = 0
    set ib_skillList[877] = 'Spra'
    set ib_skillName[877] = "坠落风暴"
    set ib_skillCustom[877] = 0
    set ib_skillList[878] = 'Sshm'
    set ib_skillName[878] = "影遁"
    set ib_skillCustom[878] = 0
    set ib_skillList[879] = 'Ston'
    set ib_skillName[879] = "陨石坠落"
    set ib_skillCustom[879] = 0
endfunction
function IB_SkillFill11 takes nothing returns nothing
    set ib_skillList[880] = 'Suhf'
    set ib_skillName[880] = "邪恶狂热"
    set ib_skillCustom[880] = 0
endfunction

function IB_FillStep takes nothing returns nothing
    if ib_fillIdx == 0 then
        call IB_Fill0()
    elseif ib_fillIdx == 1 then
        call IB_Fill1()
    endif
    set ib_fillIdx = ib_fillIdx + 1
    if ib_fillIdx >= ib_fillTotal then
        set ib_itemCount = 150
        call PauseTimer(ib_fillTimer)
        call DestroyTimer(ib_fillTimer)
        set ib_fillTimer = null
    endif
endfunction

function IB_SkillFillStep takes nothing returns nothing
    if ib_skFillIdx == 0 then
        call IB_SkillFill0()
    elseif ib_skFillIdx == 1 then
        call IB_SkillFill1()
    elseif ib_skFillIdx == 2 then
        call IB_SkillFill2()
    elseif ib_skFillIdx == 3 then
        call IB_SkillFill3()
    elseif ib_skFillIdx == 4 then
        call IB_SkillFill4()
    elseif ib_skFillIdx == 5 then
        call IB_SkillFill5()
    elseif ib_skFillIdx == 6 then
        call IB_SkillFill6()
    elseif ib_skFillIdx == 7 then
        call IB_SkillFill7()
    elseif ib_skFillIdx == 8 then
        call IB_SkillFill8()
    elseif ib_skFillIdx == 9 then
        call IB_SkillFill9()
    elseif ib_skFillIdx == 10 then
        call IB_SkillFill10()
    elseif ib_skFillIdx == 11 then
        call IB_SkillFill11()
    endif
    set ib_skFillIdx = ib_skFillIdx + 1
    if ib_skFillIdx >= ib_skFillTotal then
        set ib_skillCount = 881
        call PauseTimer(ib_skFillTimer)
        call DestroyTimer(ib_skFillTimer)
        set ib_skFillTimer = null
    endif
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    set ib_skillCount = 0
    call IB_RegisterChat()
    set ib_fillIdx = 0
    set ib_fillTotal = 2
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 12
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
