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
// [工具] 发送技能消息给玩家
//---------------------------------------------------------------------------
function IB_SkillMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ffff[技能]|r " + msg)
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
    if StringLength(keyword) == 0 then
        call IB_Message(p, "请输入关键词，如: search 剑")
        return
    endif
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
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, abilId)
    call UnitMakeAbilityPermanent(u, true, abilId)
    if level > 1 then
        call SetUnitAbilityLevel(u, abilId, level)
    endif
    call IB_SkillMessage(p, "已添加技能 \"" + IB_SkillName(ib_skAddFoundIdx) + "\" [" + IB_IdStr(abilId) + "] 等级" + I2S(level) + " 到 " + GetUnitName(u))
    set u = null
endfunction

// 设置选中单位已有技能的等级
function IB_SkillSetLevel takes player p, integer abilId, integer level returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer cur
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    set cur = GetUnitAbilityLevel(u, abilId)
    if cur == 0 then
        // 没有该技能 -> 直接添加
        call UnitAddAbility(u, abilId)
        call UnitMakeAbilityPermanent(u, true, abilId)
    endif
    call SetUnitAbilityLevel(u, abilId, level)
    call IB_SkillMessage(p, "已设置技能 \"" + IB_SkillName(ib_skSetFoundIdx) + "\" [" + IB_IdStr(abilId) + "] 为 " + I2S(level) + " 级 (原" + I2S(cur) + "级)")
    set u = null
endfunction

// 设置技能等级: 分帧扫描找匹配
function IB_SkillSetStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skSetIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skSetIdx)
        if name == ib_skSetName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skSetIdx]), ib_skSetName) then
            set ib_skSetFoundId = ib_skillList[ib_skSetIdx]
            set ib_skSetFoundIdx = ib_skSetIdx
            set ib_skSetIdx = ib_skillCount
        elseif ib_skSetFoundId == 0 then
            if IB_NameMatch(name, ib_skSetName) then
                set ib_skSetFoundId = ib_skillList[ib_skSetIdx]
                set ib_skSetFoundIdx = ib_skSetIdx
            endif
        endif
        set ib_skSetIdx = ib_skSetIdx + 1
        set n = n + 1
    endloop
    if ib_skSetIdx >= ib_skillCount then
        call PauseTimer(ib_skSetTimer)
        call DestroyTimer(ib_skSetTimer)
        set ib_skSetTimer = null
        if ib_skSetFoundId == 0 then
            call IB_SkillMessage(ib_skSetPlayer, "未找到技能 \"" + ib_skSetName + "\"")
        else
            call IB_SkillSetLevel(ib_skSetPlayer, ib_skSetFoundId, ib_skSetLevel)
        endif
        set ib_skSetPlayer = null
    endif
endfunction

function IB_SetSkill takes player p, string skillName, integer level returns nothing
    if level < 1 then
        set level = 1
    endif
    set ib_skSetIdx = 0
    set ib_skSetName = IB_LowerAscii(skillName)
    set ib_skSetFoundId = 0
    set ib_skSetFoundIdx = -1
    set ib_skSetLevel = level
    set ib_skSetPlayer = p
    if ib_skSetTimer != null then
        call PauseTimer(ib_skSetTimer)
        call DestroyTimer(ib_skSetTimer)
    endif
    set ib_skSetTimer = CreateTimer()
    call TimerStart(ib_skSetTimer, 0.01, true, function IB_SkillSetStep)
endfunction

// 解析 setskill 参数: "名称 等级"
function IB_ParseSetSkill takes player p, string arg returns nothing
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

    if lastSpace <= 0 then
        call IB_SkillMessage(p, "用法: setskill <技能名> <等级>")
        return
    endif
    set skillName = SubString(arg, 0, lastSpace)
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
    if not isNum then
        call IB_SkillMessage(p, "等级必须是数字，用法: setskill <技能名> <等级>")
        return
    endif
    set level = S2I(numStr)
    call IB_SetSkill(p, skillName, level)
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
            call IB_SkillMessage(ib_skAddPlayer, "未找到技能 \"" + ib_skAddName + "\"")
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
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitRemoveAbility(u, abilId)
    call IB_SkillMessage(p, "已移除技能 [" + IB_IdStr(abilId) + "]")
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
            call IB_SkillMessage(ib_skRemPlayer, "未找到技能 \"" + ib_skRemName + "\"")
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
            if ib_skillCustom[ib_skSearchIdx] == 1 then
                set ib_skSearchCusN = ib_skSearchCusN + 1
                if ib_skSearchCusN <= 30 then
                    set name = IB_SkillName(ib_skSearchIdx) + "[" + IB_IdStr(ib_skillList[ib_skSearchIdx]) + "]"
                    set ib_skSearchCus = ib_skSearchCus + name + "  "
                endif
            else
                set ib_skSearchStdN = ib_skSearchStdN + 1
                if ib_skSearchStdN <= 30 then
                    set name = IB_SkillName(ib_skSearchIdx) + "[" + IB_IdStr(ib_skillList[ib_skSearchIdx]) + "]"
                    set ib_skSearchStd = ib_skSearchStd + name + "  "
                endif
            endif
        endif
        set ib_skSearchIdx = ib_skSearchIdx + 1
        set n = n + 1
    endloop
    if ib_skSearchIdx >= ib_skillCount then
        call PauseTimer(ib_skSearchTimer)
        call DestroyTimer(ib_skSearchTimer)
        set ib_skSearchTimer = null
        call IB_SkillMessage(ib_skSearchPlayer, "搜索 \"" + ib_skSearchKey + "\" 共 " + I2S(ib_skSearchStdN + ib_skSearchCusN) + " 个")
        if ib_skSearchStdN > 0 then
            call IB_SkillMessage(ib_skSearchPlayer, "标准(" + I2S(ib_skSearchStdN) + "): " + ib_skSearchStd)
        endif
        if ib_skSearchCusN > 0 then
            call IB_SkillMessage(ib_skSearchPlayer, "自定义(" + I2S(ib_skSearchCusN) + "): " + ib_skSearchCus)
        endif
        if ib_skSearchStdN > 30 or ib_skSearchCusN > 30 then
            call IB_SkillMessage(ib_skSearchPlayer, "(结果过多，每类最多显示30个，请用更精确的关键词)")
        endif
        set ib_skSearchPlayer = null
    endif
endfunction

function IB_SkillSearch takes player p, string keyword returns nothing
    if StringLength(keyword) == 0 then
        call IB_SkillMessage(p, "请输入关键词，如: listskill 致命")
        return
    endif
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

// 判断技能是否"危险"（不能移除，否则可能崩溃/破坏单位）
// 例如: 物品栏(AInv)、英雄(AHer)、蝗虫(Aloc)、防御(Adef)、采集(Ahrl) 等
function IB_SkillIsProtected takes integer abilId returns boolean
    // AInv 物品栏 / AHer 英雄 / Aloc 蝗虫 / Adef 防御 / Ahrl 采集 / Amov 移动 / Aatk 攻击
    if abilId == 'AInv' or abilId == 'AHer' or abilId == 'Aloc' then
        return true
    endif
    if abilId == 'Adef' or abilId == 'Ahrl' or abilId == 'Amov' or abilId == 'Aatk' then
        return true
    endif
    // 攻击/移动类 (Aatk/Aat1..Aat3, Amov 等) 前缀
    if abilId == 'Aat1' or abilId == 'Aat2' or abilId == 'Aat3' or abilId == 'Aatk' then
        return true
    endif
    return false
endfunction

//---------------------------------------------------------------------------
// 移除选中单位的全部技能（分帧遍历技能列表，逐个检测并移除）
// JASS 1.27 无法直接枚举单位技能，故遍历内嵌技能表 + GetUnitAbilityLevel 检测
//---------------------------------------------------------------------------
function IB_RemoveAllSkillStep takes nothing returns nothing
    local integer n = 0
    local integer lvl
    local integer aid
    // 单位可能已失效（死亡/移除）-> 直接结束
    if ib_skClrUnit == null or GetUnitTypeId(ib_skClrUnit) == 0 then
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
        set ib_skClrTimer = null
        set ib_skClrPlayer = null
        set ib_skClrUnit = null
        return
    endif
    loop
        exitwhen ib_skClrIdx >= ib_skillCount or n >= 60
        set aid = ib_skillList[ib_skClrIdx]
        // 跳过受保护技能（移除会导致崩溃/破坏单位）
        if not IB_SkillIsProtected(aid) then
            set lvl = GetUnitAbilityLevel(ib_skClrUnit, aid)
            if lvl > 0 then
                call UnitRemoveAbility(ib_skClrUnit, aid)
                set ib_skClrCount = ib_skClrCount + 1
            endif
        endif
        set ib_skClrIdx = ib_skClrIdx + 1
        set n = n + 1
    endloop
    if ib_skClrIdx >= ib_skillCount then
        // 额外移除我们添加的自定义技能（不在标准技能表中）
        if GetUnitAbilityLevel(ib_skClrUnit, ib_critAbility) > 0 then
            call UnitRemoveAbility(ib_skClrUnit, ib_critAbility)
            set ib_skClrCount = ib_skClrCount + 1
        endif
        if GetUnitAbilityLevel(ib_skClrUnit, ib_fingerAbility) > 0 then
            call UnitRemoveAbility(ib_skClrUnit, ib_fingerAbility)
            set ib_skClrCount = ib_skClrCount + 1
        endif
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
        set ib_skClrTimer = null
        call IB_SkillMessage(ib_skClrPlayer, "已移除 " + GetUnitName(ib_skClrUnit) + " 的 " + I2S(ib_skClrCount) + " 个技能")
        set ib_skClrPlayer = null
        set ib_skClrUnit = null
    endif
endfunction

function IB_RemoveAllSkill takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    set ib_skClrIdx = 0
    set ib_skClrCount = 0
    set ib_skClrPlayer = p
    set ib_skClrUnit = u
    if ib_skClrTimer != null then
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
    endif
    set ib_skClrTimer = CreateTimer()
    call TimerStart(ib_skClrTimer, 0.01, true, function IB_RemoveAllSkillStep)
    set u = null
endfunction

//===========================================================================
// 致命一击系统（自定义暴击）
//---------------------------------------------------------------------------
// 机制: 用 unit group 注册"携带暴击"的单位，其普通攻击按加权表随机触发暴击，
//       额外造成 (倍率-1) 倍伤害。用"攻击事件标记 + 伤害事件结算"限定只对普攻生效。
//       不依赖任何自定义技能对象数据，可在任意地图使用。
//
// 加权表（概率加和 = 57%，其余 43% 不暴击）:
//   30%  x2    12%  x3    8%   x4    4%   x5
//   2%   x50   1%   x100
//   —— 如需调整数值，只改下面 IB_CritRoll 里的阈值即可。
//===========================================================================

// 掷骰：返回本次暴击倍率（>=2 表示暴击）
// 掷骰：返回本次暴击倍率（>=2 表示暴击；0 表示未暴击）
// 单次掷骰加权表，累计概率: 30/42/50/54/56/57/100
//   30% x2  12% x3  8% x4  4% x5  2% x50  1% x100  43% 不暴击
function IB_CritRoll takes nothing returns integer
    local integer r = GetRandomInt(1, 100)
    if r <= 30 then
        return 2
    elseif r <= 42 then
        return 3
    elseif r <= 50 then
        return 4
    elseif r <= 54 then
        return 5
    elseif r <= 56 then
        return 50
    elseif r <= 57 then
        return 100
    endif
    return 0
endfunction

// 攻击事件: 记录攻击者/目标，标记"下一次伤害可能来自普攻"
function IB_CritOnAttack takes nothing returns nothing
    set ib_critAttacker = GetAttacker()
    set ib_critTarget = GetTriggerUnit()
    set ib_critArmed = true
endfunction

// 在单位上方显示红色漂浮伤害数字 + 暴击倍率（如 "1234  x3!"）
function IB_CritShowText takes unit u, real amount, integer mult returns nothing
    local texttag tt = CreateTextTag()
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    call SetTextTagText(tt, I2S(R2I(amount)) + "  x" + I2S(mult) + "!", 0.024)
    call SetTextTagPos(tt, x, y, 60.0)
    call SetTextTagColor(tt, 255, 0, 0, 255)
    call SetTextTagVelocity(tt, 0.0, 0.04)
    call SetTextTagVisibility(tt, true)
    call SetTextTagFadepoint(tt, 1.5)
    call SetTextTagLifespan(tt, 2.0)
    call SetTextTagPermanent(tt, false)
    set tt = null
endfunction

// 伤害事件: 若为标记的普攻且攻击者在暴击组中，则掷骰并追加伤害
function IB_CritOnDamage takes nothing returns nothing
    local unit src = GetEventDamageSource()
    local unit tgt = GetTriggerUnit()
    local real dmg = GetEventDamage()
    local integer mult
    local real bonus

    // 重入保护: 追加伤害会再次触发本事件，直接忽略
    if ib_critBusy then
        return
    endif
    if not ib_critEnabled then
        return
    endif
    // 只处理"攻击事件刚标记过"的那次普攻
    if not ib_critArmed then
        return
    endif
    if src != ib_critAttacker or tgt != ib_critTarget then
        return
    endif
    // 清除标记（一次攻击只结算一次）
    set ib_critArmed = false
    // 攻击者必须携带致命一击技能（被动图标）
    if GetUnitAbilityLevel(src, ib_critAbility) == 0 then
        return
    endif
    if dmg <= 0.0 then
        return
    endif

    set mult = IB_CritRoll()
    // mult == 0 表示未暴击，不追加伤害
    if mult < 2 then
        return
    endif
    set bonus = dmg * I2R(mult - 1)
    set ib_critBusy = true
    call UnitDamageTarget(src, tgt, bonus, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    set ib_critBusy = false

    set ib_critCount = ib_critCount + 1
    set ib_critLastMult = mult
    // 在目标上方跳出红色伤害数字 + 倍率（如 "1234  x3!"）
    call IB_CritShowText(tgt, dmg + bonus, mult)
endfunction

// 单位死亡: 从暴击组移除（避免组内积累无效单位）
function IB_CritOnDeath takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if IsUnitInGroup(u, ib_critGroup) then
        call GroupRemoveUnit(ib_critGroup, u)
    endif
    set u = null
endfunction

// 为单个单位注册伤害事件（已注册则跳过）
function IB_CritRegisterUnit takes unit u returns nothing
    if u == null then
        return
    endif
    if IsUnitInGroup(u, ib_critRegGroup) then
        return
    endif
    call GroupAddUnit(ib_critRegGroup, u)
    call TriggerRegisterUnitEvent(ib_critDmgTrig, u, EVENT_UNIT_DAMAGED)
endfunction

// 单位进入地图 -> 注册伤害事件
function IB_CritOnEnter takes nothing returns nothing
    call IB_CritRegisterUnit(GetEnteringUnit())
endfunction

// 为地图上所有现有单位注册伤害事件
function IB_CritRegisterAllUnits takes nothing returns nothing
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsInRect(g, GetWorldBounds(), null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call IB_CritRegisterUnit(u)
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = null
endfunction

// 注册暴击事件（在 IB_Init 中调用一次）
// 注意: War3 1.27 没有 EVENT_PLAYER_UNIT_DAMAGED，伤害检测需用
//       "单位进入地图 -> 为该单位注册 EVENT_UNIT_DAMAGED" 的经典 Damage Engine 模式。
function IB_CritInit takes nothing returns nothing
    local trigger ta = CreateTrigger()
    local trigger tt = CreateTrigger()
    local trigger te = CreateTrigger()
    local region reg = CreateRegion()
    local rect rc = GetWorldBounds()

    // 先建组（后续注册/统计都要用）
    set ib_critGroup = CreateGroup()
    set ib_critRegGroup = CreateGroup()

    // 攻击事件（全局）
    call TriggerRegisterAnyUnitEventBJ(ta, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(ta, function IB_CritOnAttack)

    // 死亡事件（全局）
    call TriggerRegisterAnyUnitEventBJ(tt, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(tt, function IB_CritOnDeath)

    // 伤害事件：为每个进入地图的单位单独注册
    set ib_critDmgTrig = CreateTrigger()
    call TriggerAddAction(ib_critDmgTrig, function IB_CritOnDamage)
    call RegionAddRect(reg, rc)
    call TriggerRegisterEnterRegion(te, reg, null)
    call TriggerAddAction(te, function IB_CritOnEnter)

    // 已在地图上的预置单位
    call IB_CritRegisterAllUnits()

    set ta = null
    set tt = null
    set te = null
    set rc = null
endfunction


// 给选中单位开启暴击（添加被动技能图标）
function IB_CritEnable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, ib_critAbility)
    call UnitMakeAbilityPermanent(u, true, ib_critAbility)
    set lvl = GetUnitAbilityLevel(u, ib_critAbility)
    call IB_SkillMessage(p, "已给 " + GetUnitName(u) + " 添加【致命一击】技能（技能栏）等级=" + I2S(lvl))
    set u = null
endfunction

// 关闭选中单位的暴击（移除被动技能图标）
function IB_CritDisable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitRemoveAbility(u, ib_critAbility)
    call IB_SkillMessage(p, "已移除 " + GetUnitName(u) + " 的【致命一击】技能")
    set u = null
endfunction

// 显示暴击系统信息
function IB_CritInfo takes player p returns nothing
    call IB_SkillMessage(p, "【致命一击】概率表: 50%x2 30%x3 10%x4 4%x5 3%x10 2%x50 1%x100 (EV=4.8x)")
    call IB_SkillMessage(p, "本局已触发暴击 " + I2S(ib_critCount) + " 次，最近倍率 x" + I2S(ib_critLastMult))
    call IB_SkillMessage(p, "命令: criton/critoff(添加/移除技能) / crit(信息)")
endfunction

//===========================================================================
// 单位系统（给玩家添加/删除单位）
//---------------------------------------------------------------------------
// 命令:
//   listunit <关键词>   搜索单位名或护甲类型（如 listunit 圣 或 listunit divine）
//   addunit <名称>      在选中单位位置创建一个该单位，归属玩家
//   addunit <单位ID>    按 ID 创建（区分同名，如 addunit hfoo）
//   removeunit          删除当前选中的单位
//   removeunit <名称>   删除玩家拥有的所有该名称/ID 的单位
//===========================================================================

// 单位显示名
function IB_UnitName takes integer idx returns string
    return ib_unitName[idx]
endfunction

// 单位名匹配：同时匹配 UTF-8 名和 GBK 名（游戏聊天输入可能是 GBK）
function IB_UnitNameMatch takes integer idx, string key returns boolean
    if IB_NameMatch(ib_unitName[idx], key) then
        return true
    endif
    if StringLength(ib_unitNameGbk[idx]) > 0 then
        if IB_NameMatch(ib_unitNameGbk[idx], key) then
            return true
        endif
    endif
    return false
endfunction


// 发送单位消息给玩家
function IB_UnitMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cffffcc00[单位]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [诊断] 编码探测: 报告输入字节长度 + 与存储单位名比较
//---------------------------------------------------------------------------
function IB_EncProbe takes player p, string s returns nothing
    local integer len = StringLength(s)
    local integer i = 0
    local integer found = -1
    local string nm
    call IB_UnitMessage(p, "输入: \"" + s + "\" 字节长度=" + I2S(len))
    // 找第一个名字里含"圣"的单位，报告其字节长度
    loop
        exitwhen i >= ib_unitCount
        set nm = ib_unitName[i]
        if IB_NameMatch(nm, "圣") then
            set found = i
            set i = ib_unitCount
        endif
        set i = i + 1
    endloop
    if found >= 0 then
        call IB_UnitMessage(p, "单位[0]=\"" + ib_unitName[found] + "\" UTF8长度=" + I2S(StringLength(ib_unitName[found])) + " GBK长度=" + I2S(StringLength(ib_unitNameGbk[found])))
        call IB_UnitMessage(p, "匹配UTF8名? " + IB_BoolStr(IB_NameMatch(ib_unitName[found], s)) + "  匹配GBK名? " + IB_BoolStr(IB_NameMatch(ib_unitNameGbk[found], s)))
    else
        call IB_UnitMessage(p, "存储列表里找不到含\"圣\"的单位(数据问题)")
    endif
endfunction

//---------------------------------------------------------------------------
// 搜索单位（分帧扫描：每帧 40 项；匹配名称或护甲类型）
//---------------------------------------------------------------------------
function IB_UnitSearchStep takes nothing returns nothing
    local integer n = 0
    local string line
    loop
        exitwhen ib_unSearchIdx >= ib_unitCount or n >= 40
        if IB_UnitNameMatch(ib_unSearchIdx, ib_unSearchKey) or IB_StrEqCI(ib_unitArmor[ib_unSearchIdx], ib_unSearchKey) then
            set ib_unSearchN = ib_unSearchN + 1
            if ib_unSearchN <= 30 then
                set line = IB_UnitName(ib_unSearchIdx) + "[" + IB_IdStr(ib_unitList[ib_unSearchIdx]) + "/" + ib_unitArmor[ib_unSearchIdx] + "]"
                set ib_unSearchOut = ib_unSearchOut + line + "  "
            endif
        endif
        set ib_unSearchIdx = ib_unSearchIdx + 1
        set n = n + 1
    endloop
    if ib_unSearchIdx >= ib_unitCount then
        call PauseTimer(ib_unSearchTimer)
        call DestroyTimer(ib_unSearchTimer)
        set ib_unSearchTimer = null
        if ib_unSearchN == 0 then
            call IB_UnitMessage(ib_unSearchPlayer, "未找到单位 \"" + ib_unSearchKey + "\"")
        else
            call IB_UnitMessage(ib_unSearchPlayer, "单位 \"" + ib_unSearchKey + "\" 共 " + I2S(ib_unSearchN) + " 个:")
            call IB_UnitMessage(ib_unSearchPlayer, ib_unSearchOut)
        endif
        set ib_unSearchPlayer = null
    endif
endfunction

function IB_UnitSearch takes player p, string keyword returns nothing
    if StringLength(keyword) == 0 then
        call IB_UnitMessage(p, "请输入关键词，如: listunit 圣 或 listunit divine")
        return
    endif
    set ib_unSearchIdx = 0
    set ib_unSearchKey = IB_LowerAscii(keyword)
    set ib_unSearchOut = ""
    set ib_unSearchN = 0
    set ib_unSearchPlayer = p
    if ib_unSearchTimer != null then
        call PauseTimer(ib_unSearchTimer)
        call DestroyTimer(ib_unSearchTimer)
    endif
    set ib_unSearchTimer = CreateTimer()
    call TimerStart(ib_unSearchTimer, 0.01, true, function IB_UnitSearchStep)
endfunction

//---------------------------------------------------------------------------
// 添加单位: 分帧扫描找匹配 -> 在选中单位位置创建，归属玩家
//---------------------------------------------------------------------------
// 实际创建单位
function IB_UnitGive takes player p, integer unitId returns nothing
    local unit src = IB_GetSelectedUnit(p)
    local real x
    local real y
    local unit u
    if src == null then
        call IB_UnitMessage(p, "请先选中一个单位作为创建位置")
        return
    endif
    set x = GetUnitX(src)
    set y = GetUnitY(src)
    set u = CreateUnit(p, unitId, x, y, GetUnitFacing(src))
    if u == null then
        call IB_UnitMessage(p, "创建单位失败 [" + IB_IdStr(unitId) + "]（该单位可能不可创建）")
    else
        call IB_UnitMessage(p, "已在选中位置创建 \"" + IB_UnitName(ib_unAddFoundIdx) + "\" [" + IB_IdStr(unitId) + "] 归属 " + GetPlayerName(p))
    endif
    set src = null
    set u = null
endfunction

function IB_UnitAddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_unAddIdx >= ib_unitCount or n >= 40
        set name = IB_UnitName(ib_unAddIdx)
        if name == ib_unAddName or IB_StrEqCI(IB_IdStr(ib_unitList[ib_unAddIdx]), ib_unAddName) then
            set ib_unAddFoundId = ib_unitList[ib_unAddIdx]
            set ib_unAddFoundIdx = ib_unAddIdx
            set ib_unAddIdx = ib_unitCount
        elseif ib_unAddFoundId == 0 then
            if IB_UnitNameMatch(ib_unAddIdx, ib_unAddName) then
                set ib_unAddFoundId = ib_unitList[ib_unAddIdx]
                set ib_unAddFoundIdx = ib_unAddIdx
            endif
        endif
        set ib_unAddIdx = ib_unAddIdx + 1
        set n = n + 1
    endloop
    if ib_unAddIdx >= ib_unitCount then
        call PauseTimer(ib_unAddTimer)
        call DestroyTimer(ib_unAddTimer)
        set ib_unAddTimer = null
        if ib_unAddFoundId == 0 then
            call IB_UnitMessage(ib_unAddPlayer, "未找到单位 \"" + ib_unAddName + "\"")
        else
            call IB_UnitGive(ib_unAddPlayer, ib_unAddFoundId)
        endif
        set ib_unAddPlayer = null
    endif
endfunction

function IB_AddUnit takes player p, string unitName returns nothing
    set ib_unAddIdx = 0
    set ib_unAddName = unitName
    set ib_unAddFoundId = 0
    set ib_unAddFoundIdx = -1
    set ib_unAddPlayer = p
    if ib_unAddTimer != null then
        call PauseTimer(ib_unAddTimer)
        call DestroyTimer(ib_unAddTimer)
    endif
    set ib_unAddTimer = CreateTimer()
    call TimerStart(ib_unAddTimer, 0.01, true, function IB_UnitAddStep)
endfunction

//---------------------------------------------------------------------------
// 删除单位: 无参数删选中单位；有参数删玩家拥有的该名称/ID 单位
//---------------------------------------------------------------------------
// 实际删除：遍历玩家单位，移除匹配的
function IB_UnitRemoveGive takes player p, integer unitId returns nothing
    local group g = CreateGroup()
    local unit u
    local integer cnt = 0
    if unitId == 0 then
        call IB_UnitMessage(p, "未找到单位 \"" + ib_unRemName + "\"")
        call DestroyGroup(g)
        set g = null
        return
    endif
    call GroupEnumUnitsOfPlayer(g, p, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if GetUnitTypeId(u) == unitId then
            call RemoveUnit(u)
            set cnt = cnt + 1
        endif
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = null
    call IB_UnitMessage(p, "已删除 " + I2S(cnt) + " 个 \"" + IB_UnitName(ib_unRemFoundIdx) + "\" 单位")
endfunction

function IB_UnitRemoveStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_unRemIdx >= ib_unitCount or n >= 40
        set name = IB_UnitName(ib_unRemIdx)
        if name == ib_unRemName or IB_StrEqCI(IB_IdStr(ib_unitList[ib_unRemIdx]), ib_unRemName) then
            set ib_unRemFoundId = ib_unitList[ib_unRemIdx]
            set ib_unRemFoundIdx = ib_unRemIdx
            set ib_unRemIdx = ib_unitCount
        elseif ib_unRemFoundId == 0 then
            if IB_UnitNameMatch(ib_unRemIdx, ib_unRemName) then
                set ib_unRemFoundId = ib_unitList[ib_unRemIdx]
                set ib_unRemFoundIdx = ib_unRemIdx
            endif
        endif
        set ib_unRemIdx = ib_unRemIdx + 1
        set n = n + 1
    endloop
    if ib_unRemIdx >= ib_unitCount then
        call PauseTimer(ib_unRemTimer)
        call DestroyTimer(ib_unRemTimer)
        set ib_unRemTimer = null
        call IB_UnitRemoveGive(ib_unRemPlayer, ib_unRemFoundId)
        set ib_unRemPlayer = null
    endif
endfunction

// 删除选中单位
function IB_RemoveSelectedUnit takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_UnitMessage(p, "请先选中一个单位")
        return
    endif
    call IB_UnitMessage(p, "已删除选中的 " + GetUnitName(u))
    call RemoveUnit(u)
    set u = null
endfunction

function IB_RemoveUnit takes player p, string arg returns nothing
    if StringLength(arg) == 0 then
        call IB_RemoveSelectedUnit(p)
        return
    endif
    set ib_unRemIdx = 0
    set ib_unRemName = arg
    set ib_unRemFoundId = 0
    set ib_unRemFoundIdx = -1
    set ib_unRemPlayer = p
    if ib_unRemTimer != null then
        call PauseTimer(ib_unRemTimer)
        call DestroyTimer(ib_unRemTimer)
    endif
    set ib_unRemTimer = CreateTimer()
    call TimerStart(ib_unRemTimer, 0.01, true, function IB_UnitRemoveStep)
endfunction

//===========================================================================
// 死亡之指（秒杀任意单位，含魔免）
//---------------------------------------------------------------------------
// 命令:
//   deathfinger          秒杀当前选中的单位（对魔免也生效）
//   deathfinger <伤害>   自定义秒杀伤害（默认 1000000）
//
// 原理: 用 DAMAGE_TYPE_UNIVERSAL 伤害类型绕过魔法免疫与护甲，
//       造成极大伤害实现"秒杀"。对英雄/建筑同样有效。
//===========================================================================

// 发送死亡之指消息
function IB_FingerMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cffcc00ff[死亡之指]|r " + msg)
endfunction

// 秒杀指定单位（UNIVERSAL 伤害绕过魔免/护甲）
function IB_FingerKillUnit takes player p, unit u, real dmg returns nothing
    call UnitDamageTarget(u, u, dmg, true, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    // 兜底: 若目标仍存活（如无敌/免疫伤害），再直接置 0 血
    if GetUnitState(u, UNIT_STATE_LIFE) > 0.0 and not IsUnitType(u, UNIT_TYPE_DEAD) then
        call SetUnitLifeBJ(u, 1.0)
        call UnitDamageTarget(u, u, dmg, true, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    endif
endfunction

// 秒杀当前选中单位
function IB_FingerKill takes player p, string arg returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local real dmg = ib_fingerDamage
    if u == null then
        call IB_FingerMessage(p, "请先选中一个目标单位")
        return
    endif
    // 解析可选伤害参数
    if StringLength(arg) > 0 then
        if S2I(arg) > 0 then
            set dmg = I2R(S2I(arg))
        endif
    endif
    if IsUnitType(u, UNIT_TYPE_DEAD) then
        call IB_FingerMessage(p, "目标已死亡")
        set u = null
        return
    endif
    call IB_FingerKillUnit(p, u, dmg)
    set ib_fingerCount = ib_fingerCount + 1
    call IB_FingerMessage(p, "已对 " + GetUnitName(u) + " 施放死亡之指（伤害 " + R2S(dmg) + "，累计 " + I2S(ib_fingerCount) + " 次）")
    set u = null
endfunction

//---------------------------------------------------------------------------
// 技能栏版本: 玩家点击「死亡之指」技能图标释放
// 技能 ID = ib_fingerAbility（默认 A000，由 war3map.w3a 定义）
//---------------------------------------------------------------------------
function IB_FingerOnCast takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local player p = GetOwningPlayer(caster)
    if GetSpellAbilityId() != ib_fingerAbility then
        set caster = null
        set target = null
        return
    endif
    if target == null then
        call IB_FingerMessage(p, "死亡之指需要目标单位")
        set caster = null
        return
    endif
    call IB_FingerKillUnit(p, target, ib_fingerDamage)
    set ib_fingerCount = ib_fingerCount + 1
    // 击杀后不显示文字提示（保持界面干净）
    set caster = null
    set target = null
endfunction

// 注册技能释放事件（在 IB_Init 中调用）
function IB_FingerCastInit takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function IB_FingerOnCast)
    set t = null
endfunction

// 给选中单位添加「死亡之指」技能（技能栏图标）
function IB_FingerAddAbility takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_FingerMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, ib_fingerAbility)
    call UnitMakeAbilityPermanent(u, true, ib_fingerAbility)
    set lvl = GetUnitAbilityLevel(u, ib_fingerAbility)
    call IB_FingerMessage(p, "已给 " + GetUnitName(u) + " 添加【死亡之指】技能（技能栏）等级=" + I2S(lvl))
    set u = null
endfunction

// [诊断] 添加标准单位技能 ACcl(连锁闪电) 测试技能栏机制
function IB_FingerAddTest takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_FingerMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, 'ACcl')
    call UnitMakeAbilityPermanent(u, true, 'ACcl')
    set lvl = GetUnitAbilityLevel(u, 'ACcl')
    call IB_FingerMessage(p, "测试: 已添加标准技能 ACcl 连锁闪电, 等级=" + I2S(lvl))
    set u = null
endfunction

// [诊断] 添加自定义技能 A00O(来自 sj 地图的真实自定义技能) 测试 w3a 是否被读取
function IB_FingerAddTest2 takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_FingerMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, 'A00O')
    call UnitMakeAbilityPermanent(u, true, 'A00O')
    set lvl = GetUnitAbilityLevel(u, 'A00O')
    call IB_FingerMessage(p, "测试2: 已添加自定义技能 A00O, 等级=" + I2S(lvl))
    set u = null
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
    elseif IB_StrEqCI(cmd, "setskill") then
        call IB_ParseSetSkill(p, arg)
    elseif IB_StrEqCI(cmd, "listitem") then
        call IB_Search(p, arg)
    elseif IB_StrEqCI(cmd, "criton") then
        call IB_CritEnable(p)
    elseif IB_StrEqCI(cmd, "critoff") then
        call IB_CritDisable(p)
    elseif IB_StrEqCI(cmd, "crit") then
        call IB_CritInfo(p)
    elseif IB_StrEqCI(cmd, "listunit") then
        call IB_UnitSearch(p, arg)
    elseif IB_StrEqCI(cmd, "addunit") then
        call IB_AddUnit(p, arg)
    elseif IB_StrEqCI(cmd, "removeunit") then
        call IB_RemoveUnit(p, arg)
    elseif IB_StrEqCI(cmd, "unitdiag") then
        call IB_EncProbe(p, arg)
    elseif IB_StrEqCI(cmd, "deathfinger") or IB_StrEqCI(cmd, "finger") then
        call IB_FingerKill(p, arg)
    elseif IB_StrEqCI(cmd, "removeallskill") then
        call IB_RemoveAllSkill(p)
    elseif IB_StrEqCI(cmd, "fingeradd") then
        call IB_FingerAddAbility(p)
    elseif IB_StrEqCI(cmd, "fingertest") then
        call IB_FingerAddTest(p)
    elseif IB_StrEqCI(cmd, "fingertest2") then
        call IB_FingerAddTest2(p)
    endif
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
// 用 TriggerAddAction（而非 Condition）注册：部分地图/版本下仅含 condition
// 的聊天触发器不会触发；用 action 更可靠。
//---------------------------------------------------------------------------
function IB_RegisterChat8 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "addunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "unitdiag", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "deathfinger", false)
        // "finger" 用精确匹配，否则会误匹配 fingeradd/fingertest
        call TriggerRegisterPlayerChatEvent(t, Player(i), "finger", true)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeallskill", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingeradd", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest", true)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest2", true)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call PauseTimer(ib_regTimer)
    call DestroyTimer(ib_regTimer)
    set ib_regTimer = null
endfunction

function IB_RegisterChat7 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "crit", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat8)
endfunction

function IB_RegisterChat6 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listitem", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat7)
endfunction

function IB_RegisterChat5 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listskill", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "setskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat6)
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
        call TriggerRegisterPlayerChatEvent(t, Player(i), "itembrowser", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "ibtest", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
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
    set ib_itemList[0] = 'ckng'
    set ib_itemName[0] = "国王之冠 +5"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'modt'
    set ib_itemName[1] = "死亡面罩"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'tkno'
    set ib_itemName[2] = "能量之书"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'ratf'
    set ib_itemName[3] = "攻击之爪 +15"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'rde4'
    set ib_itemName[4] = "守护指环 +5"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'ofro'
    set ib_itemName[5] = "霜冻之球"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'desc'
    set ib_itemName[6] = "科勒恩的逃脱匕首"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'fgdg'
    set ib_itemName[7] = "恶魔雕像"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'infs'
    set ib_itemName[8] = "恶魔岩石"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'shar'
    set ib_itemName[9] = "冰冻碎片"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'sand'
    set ib_itemName[10] = "操作死尸卷轴"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'wild'
    set ib_itemName[11] = "野性护身符"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'srrc'
    set ib_itemName[12] = "复活卷轴"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'odef'
    set ib_itemName[13] = "黑暗之球"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'rde3'
    set ib_itemName[14] = "守护指环 +4"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'pmna'
    set ib_itemName[15] = "魔法垂饰"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'rhth'
    set ib_itemName[16] = "卡嘉医疗宝石"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'ssil'
    set ib_itemName[17] = "沉默权杖"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'spsh'
    set ib_itemName[18] = "魔法护盾护身符"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'sres'
    set ib_itemName[19] = "恢复卷轴"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'pdiv'
    set ib_itemName[20] = "神圣药水"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'pres'
    set ib_itemName[21] = "恢复药水"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'totw'
    set ib_itemName[22] = "野性护符"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'fgfh'
    set ib_itemName[23] = "长钉衣领"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'fgrd'
    set ib_itemName[24] = "红龙之卵"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'fgrg'
    set ib_itemName[25] = "岩石印记"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'hcun'
    set ib_itemName[26] = "灵巧头巾"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'hval'
    set ib_itemName[27] = "英勇面具"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'mcou'
    set ib_itemName[28] = "勇气勋章"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'ajen'
    set ib_itemName[29] = "古之忍耐姜歌"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'clfm'
    set ib_itemName[30] = "火焰风衣"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'ratc'
    set ib_itemName[31] = "攻击之爪 +12"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'ward'
    set ib_itemName[32] = "战歌之鼓"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'kpin'
    set ib_itemName[33] = "卡嘉长萧"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'crys'
    set ib_itemName[34] = "水晶球"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'lgdh'
    set ib_itemName[35] = "毁灭之角"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'ankh'
    set ib_itemName[36] = "重生十字章"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'whwd'
    set ib_itemName[37] = "治疗守卫"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'fgsk'
    set ib_itemName[38] = "死亡之书"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'wcyc'
    set ib_itemName[39] = "飓风权杖"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'hlst'
    set ib_itemName[40] = "医疗石"
    set ib_itemCustom[40] = 0
    set ib_itemList[41] = 'mnst'
    set ib_itemName[41] = "魔法石"
    set ib_itemCustom[41] = 0
    set ib_itemList[42] = 'belv'
    set ib_itemName[42] = "奎尔萨拉斯之靴 +6"
    set ib_itemCustom[42] = 0
    set ib_itemList[43] = 'bgst'
    set ib_itemName[43] = "巨人力量腰带+6"
    set ib_itemCustom[43] = 0
    set ib_itemList[44] = 'ciri'
    set ib_itemName[44] = "法师长袍 +6"
    set ib_itemCustom[44] = 0
    set ib_itemList[45] = 'lhst'
    set ib_itemName[45] = "风暴狮角"
    set ib_itemCustom[45] = 0
    set ib_itemList[46] = 'afac'
    set ib_itemName[46] = "阿利亚之笛"
    set ib_itemCustom[46] = 0
    set ib_itemList[47] = 'sbch'
    set ib_itemName[47] = "天灾骨钟"
    set ib_itemCustom[47] = 0
    set ib_itemList[48] = 'brac'
    set ib_itemName[48] = "神秘腰带"
    set ib_itemCustom[48] = 0
    set ib_itemList[49] = 'rwiz'
    set ib_itemName[49] = "艺人面罩"
    set ib_itemCustom[49] = 0
    set ib_itemList[50] = 'pghe'
    set ib_itemName[50] = "大生命药水"
    set ib_itemCustom[50] = 0
    set ib_itemList[51] = 'pgma'
    set ib_itemName[51] = "大魔法药水"
    set ib_itemCustom[51] = 0
    set ib_itemList[52] = 'pnvu'
    set ib_itemName[52] = "无敌药水"
    set ib_itemCustom[52] = 0
    set ib_itemList[53] = 'sror'
    set ib_itemName[53] = "野兽卷轴"
    set ib_itemCustom[53] = 0
    set ib_itemList[54] = 'woms'
    set ib_itemName[54] = "魔法盗取权杖"
    set ib_itemCustom[54] = 0
    set ib_itemList[55] = 'evtl'
    set ib_itemName[55] = "闪避护符"
    set ib_itemCustom[55] = 0
    set ib_itemList[56] = 'penr'
    set ib_itemName[56] = "能量垂饰"
    set ib_itemCustom[56] = 0
    set ib_itemList[57] = 'prvt'
    set ib_itemName[57] = "生命护身符"
    set ib_itemCustom[57] = 0
    set ib_itemList[58] = 'rat9'
    set ib_itemName[58] = "攻击之爪 +9"
    set ib_itemCustom[58] = 0
    set ib_itemList[59] = 'rde2'
    set ib_itemName[59] = "守护指环 +3"
    set ib_itemCustom[59] = 0
    set ib_itemList[60] = 'rlif'
    set ib_itemName[60] = "恢复指环"
    set ib_itemCustom[60] = 0
    set ib_itemList[61] = 'bspd'
    set ib_itemName[61] = "速度之靴"
    set ib_itemCustom[61] = 0
    set ib_itemList[62] = 'rej3'
    set ib_itemName[62] = "恢复药水"
    set ib_itemCustom[62] = 0
    set ib_itemList[63] = 'will'
    set ib_itemName[63] = "幻象权杖"
    set ib_itemCustom[63] = 0
    set ib_itemList[64] = 'wlsd'
    set ib_itemName[64] = "闪电护盾权杖"
    set ib_itemCustom[64] = 0
    set ib_itemList[65] = 'wswd'
    set ib_itemName[65] = "岗哨守卫"
    set ib_itemCustom[65] = 0
    set ib_itemList[66] = 'cnob'
    set ib_itemName[66] = "贵族圆环"
    set ib_itemCustom[66] = 0
    set ib_itemList[67] = 'gcel'
    set ib_itemName[67] = "加速手套"
    set ib_itemCustom[67] = 0
    set ib_itemList[68] = 'rat6'
    set ib_itemName[68] = "攻击之爪 +6"
    set ib_itemCustom[68] = 0
    set ib_itemList[69] = 'rde1'
    set ib_itemName[69] = "守护指环 +2"
    set ib_itemCustom[69] = 0
    set ib_itemList[70] = 'tdx2'
    set ib_itemName[70] = "敏捷之书 +2"
    set ib_itemCustom[70] = 0
    set ib_itemList[71] = 'texp'
    set ib_itemName[71] = "经验之书"
    set ib_itemCustom[71] = 0
    set ib_itemList[72] = 'tin2'
    set ib_itemName[72] = "智力之书 +2"
    set ib_itemCustom[72] = 0
    set ib_itemList[73] = 'tpow'
    set ib_itemName[73] = "知识之书"
    set ib_itemCustom[73] = 0
    set ib_itemList[74] = 'tst2'
    set ib_itemName[74] = "力量之书 +2"
    set ib_itemCustom[74] = 0
    set ib_itemList[75] = 'pnvl'
    set ib_itemName[75] = "较小的无敌药水"
    set ib_itemCustom[75] = 0
    set ib_itemList[76] = 'clsd'
    set ib_itemName[76] = "影子风衣"
    set ib_itemCustom[76] = 0
    set ib_itemList[77] = 'rag1'
    set ib_itemName[77] = "敏捷便鞋  +3"
    set ib_itemCustom[77] = 0
    set ib_itemList[78] = 'rin1'
    set ib_itemName[78] = "智力斗篷 +3"
    set ib_itemCustom[78] = 0
    set ib_itemList[79] = 'rst1'
    set ib_itemName[79] = "食人鬼手套 +3"
    set ib_itemCustom[79] = 0
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'manh'
    set ib_itemName[80] = "生命手册"
    set ib_itemCustom[80] = 0
    set ib_itemList[81] = 'tdex'
    set ib_itemName[81] = "敏捷之书"
    set ib_itemCustom[81] = 0
    set ib_itemList[82] = 'tint'
    set ib_itemName[82] = "智力之书"
    set ib_itemCustom[82] = 0
    set ib_itemList[83] = 'tstr'
    set ib_itemName[83] = "力量之书"
    set ib_itemCustom[83] = 0
    set ib_itemList[84] = 'pomn'
    set ib_itemName[84] = "全知药水"
    set ib_itemCustom[84] = 0
    set ib_itemList[85] = 'wshs'
    set ib_itemName[85] = "影子权杖"
    set ib_itemCustom[85] = 0
    set ib_itemList[86] = 'rej6'
    set ib_itemName[86] = "大型恢复卷轴"
    set ib_itemCustom[86] = 0
    set ib_itemList[87] = 'rej5'
    set ib_itemName[87] = "小型恢复卷轴"
    set ib_itemCustom[87] = 0
    set ib_itemList[88] = 'rej4'
    set ib_itemName[88] = "大型恢复药水"
    set ib_itemCustom[88] = 0
    set ib_itemList[89] = 'ram4'
    set ib_itemName[89] = "大魔法师指环"
    set ib_itemCustom[89] = 0
    set ib_itemList[90] = 'dsum'
    set ib_itemName[90] = "召唤钻石"
    set ib_itemCustom[90] = 0
    set ib_itemList[91] = 'ofir'
    set ib_itemName[91] = "火焰之球"
    set ib_itemCustom[91] = 0
    set ib_itemList[92] = 'ocor'
    set ib_itemName[92] = "腐蚀之球"
    set ib_itemCustom[92] = 0
    set ib_itemList[93] = 'oli2'
    set ib_itemName[93] = "闪电之球"
    set ib_itemCustom[93] = 0
    set ib_itemList[94] = 'oven'
    set ib_itemName[94] = "毒液之球"
    set ib_itemCustom[94] = 0
    set ib_itemList[95] = 'ram3'
    set ib_itemName[95] = "大魔法师指环"
    set ib_itemCustom[95] = 0
    set ib_itemList[96] = 'tret'
    set ib_itemName[96] = "再训练之书"
    set ib_itemCustom[96] = 0
    set ib_itemList[97] = 'tgrh'
    set ib_itemName[97] = "小型的大厅"
    set ib_itemCustom[97] = 0
    set ib_itemList[98] = 'rej2'
    set ib_itemName[98] = "小型恢复药水"
    set ib_itemCustom[98] = 0
    set ib_itemList[99] = 'gemt'
    set ib_itemName[99] = "显形宝石"
    set ib_itemCustom[99] = 0
    set ib_itemList[100] = 'ram2'
    set ib_itemName[100] = "大魔法师指环"
    set ib_itemCustom[100] = 0
    set ib_itemList[101] = 'stel'
    set ib_itemName[101] = "传送权杖"
    set ib_itemCustom[101] = 0
    set ib_itemList[102] = 'stwp'
    set ib_itemName[102] = "回城卷轴"
    set ib_itemCustom[102] = 0
    set ib_itemList[103] = 'wneg'
    set ib_itemName[103] = "否决权杖"
    set ib_itemCustom[103] = 0
    set ib_itemList[104] = 'sneg'
    set ib_itemName[104] = "否决权杖"
    set ib_itemCustom[104] = 0
    set ib_itemList[105] = 'wneu'
    set ib_itemName[105] = "中和权杖"
    set ib_itemCustom[105] = 0
    set ib_itemList[106] = 'shea'
    set ib_itemName[106] = "医疗卷轴"
    set ib_itemCustom[106] = 0
    set ib_itemList[107] = 'sman'
    set ib_itemName[107] = "魔法卷轴"
    set ib_itemCustom[107] = 0
    set ib_itemList[108] = 'rej1'
    set ib_itemName[108] = "小型恢复药水"
    set ib_itemCustom[108] = 0
    set ib_itemList[109] = 'pspd'
    set ib_itemName[109] = "速度药水"
    set ib_itemCustom[109] = 0
    set ib_itemList[110] = 'dust'
    set ib_itemName[110] = "尘土之影"
    set ib_itemCustom[110] = 0
    set ib_itemList[111] = 'ram1'
    set ib_itemName[111] = "大魔法师指环"
    set ib_itemCustom[111] = 0
    set ib_itemList[112] = 'pinv'
    set ib_itemName[112] = "隐形药水"
    set ib_itemCustom[112] = 0
    set ib_itemList[113] = 'phea'
    set ib_itemName[113] = "生命药水"
    set ib_itemCustom[113] = 0
    set ib_itemList[114] = 'pman'
    set ib_itemName[114] = "魔法药水"
    set ib_itemCustom[114] = 0
    set ib_itemList[115] = 'spro'
    set ib_itemName[115] = "守护卷轴"
    set ib_itemCustom[115] = 0
    set ib_itemList[116] = 'hslv'
    set ib_itemName[116] = "医疗剂"
    set ib_itemCustom[116] = 0
    set ib_itemList[117] = 'moon'
    set ib_itemName[117] = "月亮石"
    set ib_itemCustom[117] = 0
    set ib_itemList[118] = 'shas'
    set ib_itemName[118] = "速度卷轴"
    set ib_itemCustom[118] = 0
    set ib_itemList[119] = 'skul'
    set ib_itemName[119] = "献祭头骨"
    set ib_itemCustom[119] = 0
    set ib_itemList[120] = 'mcri'
    set ib_itemName[120] = "机械类的小玩艺"
    set ib_itemCustom[120] = 0
    set ib_itemList[121] = 'rnec'
    set ib_itemName[121] = "巫术妖棍"
    set ib_itemCustom[121] = 0
    set ib_itemList[122] = 'tsct'
    set ib_itemName[122] = "象牙塔"
    set ib_itemCustom[122] = 0
    set ib_itemList[123] = 'azhr'
    set ib_itemName[123] = "埃苏尼之心"
    set ib_itemCustom[123] = 0
    set ib_itemList[124] = 'bzbe'
    set ib_itemName[124] = "空瓶"
    set ib_itemCustom[124] = 0
    set ib_itemList[125] = 'bzbf'
    set ib_itemName[125] = "盛满泉水的瓶子"
    set ib_itemCustom[125] = 0
    set ib_itemList[126] = 'ches'
    set ib_itemName[126] = "奶酪"
    set ib_itemCustom[126] = 0
    set ib_itemList[127] = 'cnhn'
    set ib_itemName[127] = "赛纳留斯的号角"
    set ib_itemCustom[127] = 0
    set ib_itemList[128] = 'glsk'
    set ib_itemName[128] = "古尔丹之颅"
    set ib_itemCustom[128] = 0
    set ib_itemList[129] = 'gopr'
    set ib_itemName[129] = "净化浮雕"
    set ib_itemCustom[129] = 0
    set ib_itemList[130] = 'k3m1'
    set ib_itemName[130] = "月亮水晶"
    set ib_itemCustom[130] = 0
    set ib_itemList[131] = 'k3m2'
    set ib_itemName[131] = "三月之钥的另外一个部分"
    set ib_itemCustom[131] = 0
    set ib_itemList[132] = 'k3m3'
    set ib_itemName[132] = "三月之钥"
    set ib_itemCustom[132] = 0
    set ib_itemList[133] = 'ktrm'
    set ib_itemName[133] = "泰瑞纳斯国王的骨灰瓮"
    set ib_itemCustom[133] = 0
    set ib_itemList[134] = 'kybl'
    set ib_itemName[134] = "鲜血钥匙"
    set ib_itemCustom[134] = 0
    set ib_itemList[135] = 'kygh'
    set ib_itemName[135] = "魔鬼钥匙"
    set ib_itemCustom[135] = 0
    set ib_itemList[136] = 'kymn'
    set ib_itemName[136] = "月之钥匙"
    set ib_itemCustom[136] = 0
    set ib_itemList[137] = 'kysn'
    set ib_itemName[137] = "太阳钥匙"
    set ib_itemCustom[137] = 0
    set ib_itemList[138] = 'ledg'
    set ib_itemName[138] = "吉拉德的帐本"
    set ib_itemCustom[138] = 0
    set ib_itemList[139] = 'phlt'
    set ib_itemName[139] = "李维特"
    set ib_itemCustom[139] = 0
    set ib_itemList[140] = 'sehr'
    set ib_itemName[140] = "赛瑞诺克斯之心"
    set ib_itemCustom[140] = 0
    set ib_itemList[141] = 'engs'
    set ib_itemName[141] = "魔法宝石"
    set ib_itemCustom[141] = 0
    set ib_itemList[142] = 'sorf'
    set ib_itemName[142] = "影子之球碎片"
    set ib_itemCustom[142] = 0
    set ib_itemList[143] = 'gmfr'
    set ib_itemName[143] = "宝石碎片"
    set ib_itemCustom[143] = 0
    set ib_itemList[144] = 'jpnt'
    set ib_itemName[144] = "给吉安娜?普罗德摩尔的便条"
    set ib_itemCustom[144] = 0
    set ib_itemList[145] = 'shwd'
    set ib_itemName[145] = "荧光草"
    set ib_itemCustom[145] = 0
    set ib_itemList[146] = 'skrt'
    set ib_itemName[146] = "骸骨宝物"
    set ib_itemCustom[146] = 0
    set ib_itemList[147] = 'thle'
    set ib_itemName[147] = "雷霆蜥蜴之蛋"
    set ib_itemCustom[147] = 0
    set ib_itemList[148] = 'sclp'
    set ib_itemName[148] = "秘密关卡激活"
    set ib_itemCustom[148] = 0
    set ib_itemList[149] = 'wtlg'
    set ib_itemName[149] = "怀特之腿"
    set ib_itemCustom[149] = 0
    set ib_itemList[150] = 'wolg'
    set ib_itemName[150] = "怀特的另一条腿"
    set ib_itemCustom[150] = 0
    set ib_itemList[151] = 'mgtk'
    set ib_itemName[151] = "魔法钥匙串"
    set ib_itemCustom[151] = 0
    set ib_itemList[152] = 'mort'
    set ib_itemName[152] = "莫哥林的报告"
    set ib_itemCustom[152] = 0
    set ib_itemList[153] = 'dphe'
    set ib_itemName[153] = "雷霆凤凰蛋"
    set ib_itemCustom[153] = 0
    set ib_itemList[154] = 'dkfw'
    set ib_itemName[154] = "雷霆水桶"
    set ib_itemCustom[154] = 0
    set ib_itemList[155] = 'dthb'
    set ib_itemName[155] = "雷电花芯"
    set ib_itemCustom[155] = 0
    set ib_itemList[156] = 'fgun'
    set ib_itemName[156] = "信号枪"
    set ib_itemCustom[156] = 0
    set ib_itemList[157] = 'lure'
    set ib_itemName[157] = "怪兽诱捕守卫"
    set ib_itemCustom[157] = 0
    set ib_itemList[158] = 'olig'
    set ib_itemName[158] = "闪电之球"
    set ib_itemCustom[158] = 0
    set ib_itemList[159] = 'amrc'
    set ib_itemName[159] = "召唤护身符"
    set ib_itemCustom[159] = 0
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'ccmd'
    set ib_itemName[160] = "统治权杖"
    set ib_itemCustom[160] = 0
    set ib_itemList[161] = 'flag'
    set ib_itemName[161] = "人族旗帜"
    set ib_itemCustom[161] = 0
    set ib_itemList[162] = 'gobm'
    set ib_itemName[162] = "地精地雷"
    set ib_itemCustom[162] = 0
    set ib_itemList[163] = 'gsou'
    set ib_itemName[163] = "灵魂宝石"
    set ib_itemCustom[163] = 0
    set ib_itemList[164] = 'nflg'
    set ib_itemName[164] = "暗夜精灵族旗帜"
    set ib_itemCustom[164] = 0
    set ib_itemList[165] = 'nspi'
    set ib_itemName[165] = "魔法免疫项链"
    set ib_itemCustom[165] = 0
    set ib_itemList[166] = 'oflg'
    set ib_itemName[166] = "兽族旗帜"
    set ib_itemCustom[166] = 0
    set ib_itemList[167] = 'pams'
    set ib_itemName[167] = "抗体药水"
    set ib_itemCustom[167] = 0
    set ib_itemList[168] = 'pgin'
    set ib_itemName[168] = "大隐形药水"
    set ib_itemCustom[168] = 0
    set ib_itemList[169] = 'rat3'
    set ib_itemName[169] = "攻击之爪 +3"
    set ib_itemCustom[169] = 0
    set ib_itemList[170] = 'rde0'
    set ib_itemName[170] = "守护指环 +1"
    set ib_itemCustom[170] = 0
    set ib_itemList[171] = 'rnsp'
    set ib_itemName[171] = "优越之戒"
    set ib_itemCustom[171] = 0
    set ib_itemList[172] = 'soul'
    set ib_itemName[172] = "灵魂"
    set ib_itemCustom[172] = 0
    set ib_itemList[173] = 'tels'
    set ib_itemName[173] = "地精夜视镜"
    set ib_itemCustom[173] = 0
    set ib_itemList[174] = 'tgxp'
    set ib_itemName[174] = "超级经验之书"
    set ib_itemCustom[174] = 0
    set ib_itemList[175] = 'uflg'
    set ib_itemName[175] = "不死族旗帜"
    set ib_itemCustom[175] = 0
    set ib_itemList[176] = 'anfg'
    set ib_itemName[176] = "远古雕像"
    set ib_itemCustom[176] = 0
    set ib_itemList[177] = 'brag'
    set ib_itemName[177] = "敏捷腰带"
    set ib_itemCustom[177] = 0
    set ib_itemList[178] = 'drph'
    set ib_itemName[178] = "德鲁伊布袋"
    set ib_itemCustom[178] = 0
    set ib_itemList[179] = 'iwbr'
    set ib_itemName[179] = "铁树枝干"
    set ib_itemCustom[179] = 0
    set ib_itemList[180] = 'jdrn'
    set ib_itemName[180] = "灵巧指环"
    set ib_itemCustom[180] = 0
    set ib_itemList[181] = 'lnrn'
    set ib_itemName[181] = "雄狮之戒"
    set ib_itemCustom[181] = 0
    set ib_itemList[182] = 'mlst'
    set ib_itemName[182] = "力量之锤"
    set ib_itemCustom[182] = 0
    set ib_itemList[183] = 'oslo'
    set ib_itemName[183] = "减速之球"
    set ib_itemCustom[183] = 0
    set ib_itemList[184] = 'sbok'
    set ib_itemName[184] = "魔法书"
    set ib_itemCustom[184] = 0
    set ib_itemList[185] = 'sksh'
    set ib_itemName[185] = "防护面具"
    set ib_itemCustom[185] = 0
    set ib_itemList[186] = 'sprn'
    set ib_itemName[186] = "蜘蛛戒指"
    set ib_itemCustom[186] = 0
    set ib_itemList[187] = 'tmmt'
    set ib_itemName[187] = "力量图腾"
    set ib_itemCustom[187] = 0
    set ib_itemList[188] = 'vddl'
    set ib_itemName[188] = "巫毒玩偶"
    set ib_itemCustom[188] = 0
    set ib_itemList[189] = 'spre'
    set ib_itemName[189] = "保存权杖"
    set ib_itemCustom[189] = 0
    set ib_itemList[190] = 'sfog'
    set ib_itemName[190] = "乌云号角"
    set ib_itemCustom[190] = 0
    set ib_itemList[191] = 'sor1'
    set ib_itemName[191] = "影子之球 +1"
    set ib_itemCustom[191] = 0
    set ib_itemList[192] = 'sor2'
    set ib_itemName[192] = "影子之球 +2"
    set ib_itemCustom[192] = 0
    set ib_itemList[193] = 'sor3'
    set ib_itemName[193] = "影子之球 +3"
    set ib_itemCustom[193] = 0
    set ib_itemList[194] = 'sor4'
    set ib_itemName[194] = "影子之球 +4"
    set ib_itemCustom[194] = 0
    set ib_itemList[195] = 'sor5'
    set ib_itemName[195] = "影子之球 +5"
    set ib_itemCustom[195] = 0
    set ib_itemList[196] = 'sor6'
    set ib_itemName[196] = "影子之球 +6"
    set ib_itemCustom[196] = 0
    set ib_itemList[197] = 'sor7'
    set ib_itemName[197] = "影子之球 +7"
    set ib_itemCustom[197] = 0
    set ib_itemList[198] = 'sor8'
    set ib_itemName[198] = "影子之球 +8"
    set ib_itemCustom[198] = 0
    set ib_itemList[199] = 'sor9'
    set ib_itemName[199] = "影子之球 +9"
    set ib_itemCustom[199] = 0
    set ib_itemList[200] = 'sora'
    set ib_itemName[200] = "影子之球 +10"
    set ib_itemCustom[200] = 0
    set ib_itemList[201] = 'fwss'
    set ib_itemName[201] = "冰霜巨龙头骨护盾"
    set ib_itemCustom[201] = 0
    set ib_itemList[202] = 'shtm'
    set ib_itemName[202] = "萨满图腾"
    set ib_itemCustom[202] = 0
    set ib_itemList[203] = 'esaz'
    set ib_itemName[203] = "埃苏尼之精髓"
    set ib_itemCustom[203] = 0
    set ib_itemList[204] = 'btst'
    set ib_itemName[204] = "战斗标准"
    set ib_itemCustom[204] = 0
    set ib_itemList[205] = 'tbsm'
    set ib_itemName[205] = "微型铁匠铺"
    set ib_itemCustom[205] = 0
    set ib_itemList[206] = 'tfar'
    set ib_itemName[206] = "微型农场"
    set ib_itemCustom[206] = 0
    set ib_itemList[207] = 'tlum'
    set ib_itemName[207] = "微型伐木场"
    set ib_itemCustom[207] = 0
    set ib_itemList[208] = 'tbar'
    set ib_itemName[208] = "微型兵营"
    set ib_itemCustom[208] = 0
    set ib_itemList[209] = 'tbak'
    set ib_itemName[209] = "微型国王祭坛"
    set ib_itemCustom[209] = 0
    set ib_itemList[210] = 'gldo'
    set ib_itemName[210] = "基尔加丹之球"
    set ib_itemCustom[210] = 0
    set ib_itemList[211] = 'stre'
    set ib_itemName[211] = "鼓舞权杖"
    set ib_itemCustom[211] = 0
    set ib_itemList[212] = 'horl'
    set ib_itemName[212] = "稀有神器"
    set ib_itemCustom[212] = 0
    set ib_itemList[213] = 'hbth'
    set ib_itemName[213] = "战舰之舵"
    set ib_itemCustom[213] = 0
    set ib_itemList[214] = 'blba'
    set ib_itemName[214] = "剑刃护甲"
    set ib_itemCustom[214] = 0
    set ib_itemList[215] = 'rugt'
    set ib_itemName[215] = "神秘手套"
    set ib_itemCustom[215] = 0
    set ib_itemList[216] = 'frhg'
    set ib_itemName[216] = "火焰手套"
    set ib_itemCustom[216] = 0
    set ib_itemList[217] = 'gvsm'
    set ib_itemName[217] = "法术大师手套"
    set ib_itemCustom[217] = 0
    set ib_itemList[218] = 'crdt'
    set ib_itemName[218] = "死亡领主皇冠"
    set ib_itemCustom[218] = 0
    set ib_itemList[219] = 'arsc'
    set ib_itemName[219] = "神秘卷轴"
    set ib_itemCustom[219] = 0
    set ib_itemList[220] = 'scul'
    set ib_itemName[220] = "邪恶军团卷轴"
    set ib_itemCustom[220] = 0
    set ib_itemList[221] = 'tmsc'
    set ib_itemName[221] = "牺牲之书"
    set ib_itemCustom[221] = 0
    set ib_itemList[222] = 'dtsb'
    set ib_itemName[222] = "德雷克萨尔魔法书"
    set ib_itemCustom[222] = 0
    set ib_itemList[223] = 'grsl'
    set ib_itemName[223] = "灵魂宝物"
    set ib_itemCustom[223] = 0
    set ib_itemList[224] = 'arsh'
    set ib_itemName[224] = "芒硝护盾"
    set ib_itemCustom[224] = 0
    set ib_itemList[225] = 'shdt'
    set ib_itemName[225] = "死亡领主护盾"
    set ib_itemCustom[225] = 0
    set ib_itemList[226] = 'shhn'
    set ib_itemName[226] = "荣誉护盾"
    set ib_itemCustom[226] = 0
    set ib_itemList[227] = 'shen'
    set ib_itemName[227] = "施魔护盾"
    set ib_itemCustom[227] = 0
    set ib_itemList[228] = 'thdm'
    set ib_itemName[228] = "雷霆蜥蜴钻石"
    set ib_itemCustom[228] = 0
    set ib_itemList[229] = 'stpg'
    set ib_itemName[229] = "时钟企鹅"
    set ib_itemCustom[229] = 0
    set ib_itemList[230] = 'shrs'
    set ib_itemName[230] = "烤肉"
    set ib_itemCustom[230] = 0
    set ib_itemList[231] = 'bfhr'
    set ib_itemName[231] = "血羽之心"
    set ib_itemCustom[231] = 0
    set ib_itemList[232] = 'cosl'
    set ib_itemName[232] = "灵魂之球"
    set ib_itemCustom[232] = 0
    set ib_itemList[233] = 'shcw'
    set ib_itemName[233] = "萨满利爪"
    set ib_itemCustom[233] = 0
    set ib_itemList[234] = 'srbd'
    set ib_itemName[234] = "灼热之刀"
    set ib_itemCustom[234] = 0
    set ib_itemList[235] = 'frgd'
    set ib_itemName[235] = "霜冻守卫"
    set ib_itemCustom[235] = 0
    set ib_itemList[236] = 'envl'
    set ib_itemName[236] = "魔法小瓶"
    set ib_itemCustom[236] = 0
    set ib_itemList[237] = 'rump'
    set ib_itemName[237] = "生锈的矿铲"
    set ib_itemCustom[237] = 0
    set ib_itemList[238] = 'srtl'
    set ib_itemName[238] = "瑟拉思尔"
    set ib_itemCustom[238] = 0
    set ib_itemList[239] = 'stwa'
    set ib_itemName[239] = "战斧"
    set ib_itemCustom[239] = 0
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'klmm'
    set ib_itemName[240] = "远古战斧"
    set ib_itemCustom[240] = 0
    set ib_itemList[241] = 'rots'
    set ib_itemName[241] = "海之权杖"
    set ib_itemCustom[241] = 0
    set ib_itemList[242] = 'axas'
    set ib_itemName[242] = "先祖权杖"
    set ib_itemCustom[242] = 0
    set ib_itemList[243] = 'mnsf'
    set ib_itemName[243] = "心灵权杖"
    set ib_itemCustom[243] = 0
    set ib_itemList[244] = 'schl'
    set ib_itemName[244] = "医疗权杖"
    set ib_itemCustom[244] = 0
    set ib_itemList[245] = 'asbl'
    set ib_itemName[245] = "刺客佩刀"
    set ib_itemCustom[245] = 0
    set ib_itemList[246] = 'kgal'
    set ib_itemName[246] = "麦酒桶"
    set ib_itemCustom[246] = 0
    set ib_itemList[247] = 'gold'
    set ib_itemName[247] = "金币"
    set ib_itemCustom[247] = 0
    set ib_itemList[248] = 'lmbr'
    set ib_itemName[248] = "木材堆"
    set ib_itemCustom[248] = 0
    set ib_itemList[249] = 'gfor'
    set ib_itemName[249] = "防御浮雕"
    set ib_itemCustom[249] = 0
    set ib_itemList[250] = 'guvi'
    set ib_itemName[250] = "夜视浮雕"
    set ib_itemCustom[250] = 0
    set ib_itemList[251] = 'rspl'
    set ib_itemName[251] = "灵魂锁链神符"
    set ib_itemCustom[251] = 0
    set ib_itemList[252] = 'rre1'
    set ib_itemName[252] = "小型复活神符"
    set ib_itemCustom[252] = 0
    set ib_itemList[253] = 'rre2'
    set ib_itemName[253] = "大型复活神符"
    set ib_itemCustom[253] = 0
    set ib_itemList[254] = 'gomn'
    set ib_itemName[254] = "全知浮雕"
    set ib_itemCustom[254] = 0
    set ib_itemList[255] = 'rsps'
    set ib_itemName[255] = "护盾神符"
    set ib_itemCustom[255] = 0
    set ib_itemList[256] = 'rspd'
    set ib_itemName[256] = "速度神符"
    set ib_itemCustom[256] = 0
    set ib_itemList[257] = 'rman'
    set ib_itemName[257] = "魔法神符"
    set ib_itemCustom[257] = 0
    set ib_itemList[258] = 'rma2'
    set ib_itemName[258] = "大型魔法神符"
    set ib_itemCustom[258] = 0
    set ib_itemList[259] = 'rres'
    set ib_itemName[259] = "恢复神符"
    set ib_itemCustom[259] = 0
    set ib_itemList[260] = 'rreb'
    set ib_itemName[260] = "重生神符"
    set ib_itemCustom[260] = 0
    set ib_itemList[261] = 'rhe1'
    set ib_itemName[261] = "小型治疗神符"
    set ib_itemCustom[261] = 0
    set ib_itemList[262] = 'rhe2'
    set ib_itemName[262] = "治疗神符"
    set ib_itemCustom[262] = 0
    set ib_itemList[263] = 'rhe3'
    set ib_itemName[263] = "大型治疗神符"
    set ib_itemCustom[263] = 0
    set ib_itemList[264] = 'rdis'
    set ib_itemName[264] = "驱魔神符"
    set ib_itemCustom[264] = 0
    set ib_itemList[265] = 'rwat'
    set ib_itemName[265] = "岗哨神符"
    set ib_itemCustom[265] = 0
    set ib_itemList[266] = 'pclr'
    set ib_itemName[266] = "净化药水"
    set ib_itemCustom[266] = 0
    set ib_itemList[267] = 'plcl'
    set ib_itemName[267] = "小净化药水"
    set ib_itemCustom[267] = 0
    set ib_itemList[268] = 'silk'
    set ib_itemName[268] = "蜘蛛丝饰针"
    set ib_itemCustom[268] = 0
    set ib_itemList[269] = 'vamp'
    set ib_itemName[269] = "吸血药水"
    set ib_itemCustom[269] = 0
    set ib_itemList[270] = 'sreg'
    set ib_itemName[270] = "恢复卷轴"
    set ib_itemCustom[270] = 0
    set ib_itemList[271] = 'ssan'
    set ib_itemName[271] = "避难权杖"
    set ib_itemCustom[271] = 0
    set ib_itemList[272] = 'tcas'
    set ib_itemName[272] = "小城堡"
    set ib_itemCustom[272] = 0
endfunction

function IB_SkillFill0 takes nothing returns nothing
    set ib_skillList[0] = 'AAns'
    set ib_skillName[0] = "收费"
    set ib_skillCustom[0] = 0
    set ib_skillList[1] = 'ACac'
    set ib_skillName[1] = "命令光环"
    set ib_skillCustom[1] = 0
    set ib_skillList[2] = 'ACad'
    set ib_skillName[2] = "操纵死尸"
    set ib_skillCustom[2] = 0
    set ib_skillList[3] = 'ACah'
    set ib_skillName[3] = "荆棘光环"
    set ib_skillCustom[3] = 0
    set ib_skillList[4] = 'ACam'
    set ib_skillName[4] = "反魔法外壳"
    set ib_skillCustom[4] = 0
    set ib_skillList[5] = 'ACat'
    set ib_skillName[5] = "强击光环"
    set ib_skillCustom[5] = 0
    set ib_skillList[6] = 'ACav'
    set ib_skillName[6] = "专注光环"
    set ib_skillCustom[6] = 0
    set ib_skillList[7] = 'ACba'
    set ib_skillName[7] = "辉煌光环"
    set ib_skillCustom[7] = 0
    set ib_skillList[8] = 'ACbb'
    set ib_skillName[8] = "嗜血术"
    set ib_skillCustom[8] = 0
    set ib_skillList[9] = 'ACbc'
    set ib_skillName[9] = "火焰呼吸"
    set ib_skillCustom[9] = 0
    set ib_skillList[10] = 'ACbf'
    set ib_skillName[10] = "霜冻闪电"
    set ib_skillCustom[10] = 0
    set ib_skillList[11] = 'ACbh'
    set ib_skillName[11] = "重击"
    set ib_skillCustom[11] = 0
    set ib_skillList[12] = 'ACbk'
    set ib_skillName[12] = "黑暗之箭"
    set ib_skillCustom[12] = 0
    set ib_skillList[13] = 'ACbl'
    set ib_skillName[13] = "嗜血术"
    set ib_skillCustom[13] = 0
    set ib_skillList[14] = 'ACbn'
    set ib_skillName[14] = "驱散"
    set ib_skillCustom[14] = 0
    set ib_skillList[15] = 'ACbr'
    set ib_skillName[15] = "狂暴愤怒"
    set ib_skillCustom[15] = 0
    set ib_skillList[16] = 'ACbz'
    set ib_skillName[16] = "暴风雪"
    set ib_skillCustom[16] = 0
    set ib_skillList[17] = 'ACc2'
    set ib_skillName[17] = "冲击波"
    set ib_skillCustom[17] = 0
    set ib_skillList[18] = 'ACc3'
    set ib_skillName[18] = "冲击波"
    set ib_skillCustom[18] = 0
    set ib_skillList[19] = 'ACca'
    set ib_skillName[19] = "腐臭蜂群"
    set ib_skillCustom[19] = 0
    set ib_skillList[20] = 'ACcb'
    set ib_skillName[20] = "霜冻闪电"
    set ib_skillCustom[20] = 0
    set ib_skillList[21] = 'ACce'
    set ib_skillName[21] = "分裂攻击"
    set ib_skillCustom[21] = 0
    set ib_skillList[22] = 'ACch'
    set ib_skillName[22] = "符咒"
    set ib_skillCustom[22] = 0
    set ib_skillList[23] = 'ACcl'
    set ib_skillName[23] = "闪电链"
    set ib_skillCustom[23] = 0
    set ib_skillList[24] = 'ACcn'
    set ib_skillName[24] = "吞食尸体"
    set ib_skillCustom[24] = 0
    set ib_skillList[25] = 'ACcr'
    set ib_skillName[25] = "残废"
    set ib_skillCustom[25] = 0
    set ib_skillList[26] = 'ACcs'
    set ib_skillName[26] = "诅咒"
    set ib_skillCustom[26] = 0
    set ib_skillList[27] = 'ACct'
    set ib_skillName[27] = "致命一击"
    set ib_skillCustom[27] = 0
    set ib_skillList[28] = 'ACcv'
    set ib_skillName[28] = "冲击波"
    set ib_skillCustom[28] = 0
    set ib_skillList[29] = 'ACcw'
    set ib_skillName[29] = "冰冻冷箭"
    set ib_skillCustom[29] = 0
    set ib_skillList[30] = 'ACcy'
    set ib_skillName[30] = "飓风"
    set ib_skillCustom[30] = 0
    set ib_skillList[31] = 'ACd2'
    set ib_skillName[31] = "驱逐魔法"
    set ib_skillCustom[31] = 0
    set ib_skillList[32] = 'ACdc'
    set ib_skillName[32] = "死亡缠绕"
    set ib_skillCustom[32] = 0
    set ib_skillList[33] = 'ACde'
    set ib_skillName[33] = "吞噬魔法"
    set ib_skillCustom[33] = 0
    set ib_skillList[34] = 'ACdm'
    set ib_skillName[34] = "驱逐魔法"
    set ib_skillCustom[34] = 0
    set ib_skillList[35] = 'ACdr'
    set ib_skillName[35] = "生命汲取"
    set ib_skillCustom[35] = 0
    set ib_skillList[36] = 'ACds'
    set ib_skillName[36] = "神圣护甲"
    set ib_skillCustom[36] = 0
    set ib_skillList[37] = 'ACdv'
    set ib_skillName[37] = "吞噬"
    set ib_skillCustom[37] = 0
    set ib_skillList[38] = 'ACen'
    set ib_skillName[38] = "诱捕"
    set ib_skillCustom[38] = 0
    set ib_skillList[39] = 'ACes'
    set ib_skillName[39] = "闪避"
    set ib_skillCustom[39] = 0
    set ib_skillList[40] = 'ACev'
    set ib_skillName[40] = "闪避"
    set ib_skillCustom[40] = 0
    set ib_skillList[41] = 'ACf2'
    set ib_skillName[41] = "霜冻护甲"
    set ib_skillCustom[41] = 0
    set ib_skillList[42] = 'ACf3'
    set ib_skillName[42] = "痛苦之指"
    set ib_skillCustom[42] = 0
    set ib_skillList[43] = 'ACfa'
    set ib_skillName[43] = "霜冻护甲"
    set ib_skillCustom[43] = 0
    set ib_skillList[44] = 'ACfb'
    set ib_skillName[44] = "霹雳闪电"
    set ib_skillCustom[44] = 0
    set ib_skillList[45] = 'ACfd'
    set ib_skillName[45] = "痛苦之指"
    set ib_skillCustom[45] = 0
    set ib_skillList[46] = 'ACff'
    set ib_skillName[46] = "精灵之火"
    set ib_skillCustom[46] = 0
    set ib_skillList[47] = 'ACfl'
    set ib_skillName[47] = "叉状闪电"
    set ib_skillCustom[47] = 0
    set ib_skillList[48] = 'ACfn'
    set ib_skillName[48] = "霜冻新星"
    set ib_skillCustom[48] = 0
    set ib_skillList[49] = 'ACfr'
    set ib_skillName[49] = "自然之力"
    set ib_skillCustom[49] = 0
    set ib_skillList[50] = 'ACfs'
    set ib_skillName[50] = "烈焰风暴"
    set ib_skillCustom[50] = 0
    set ib_skillList[51] = 'ACfu'
    set ib_skillName[51] = "霜冻护甲"
    set ib_skillCustom[51] = 0
    set ib_skillList[52] = 'AChv'
    set ib_skillName[52] = "医疗波"
    set ib_skillCustom[52] = 0
    set ib_skillList[53] = 'AChw'
    set ib_skillName[53] = "治疗守卫"
    set ib_skillCustom[53] = 0
    set ib_skillList[54] = 'AChx'
    set ib_skillName[54] = "妖术"
    set ib_skillCustom[54] = 0
    set ib_skillList[55] = 'ACif'
    set ib_skillName[55] = "心灵之火"
    set ib_skillCustom[55] = 0
    set ib_skillList[56] = 'ACim'
    set ib_skillName[56] = "献祭"
    set ib_skillCustom[56] = 0
    set ib_skillList[57] = 'ACls'
    set ib_skillName[57] = "闪电护盾"
    set ib_skillCustom[57] = 0
    set ib_skillList[58] = 'ACm2'
    set ib_skillName[58] = "魔法免疫"
    set ib_skillCustom[58] = 0
    set ib_skillList[59] = 'ACm3'
    set ib_skillName[59] = "魔法免疫"
    set ib_skillCustom[59] = 0
    set ib_skillList[60] = 'ACmf'
    set ib_skillName[60] = "魔法护盾"
    set ib_skillCustom[60] = 0
    set ib_skillList[61] = 'ACmi'
    set ib_skillName[61] = "魔法免疫"
    set ib_skillCustom[61] = 0
    set ib_skillList[62] = 'ACmo'
    set ib_skillName[62] = "季风"
    set ib_skillCustom[62] = 0
    set ib_skillList[63] = 'ACmp'
    set ib_skillName[63] = "穿刺"
    set ib_skillCustom[63] = 0
    set ib_skillList[64] = 'ACnr'
    set ib_skillName[64] = "生命恢复光环"
    set ib_skillCustom[64] = 0
    set ib_skillList[65] = 'ACpa'
    set ib_skillName[65] = "寄生虫"
    set ib_skillCustom[65] = 0
    set ib_skillList[66] = 'ACps'
    set ib_skillName[66] = "占据"
    set ib_skillCustom[66] = 0
    set ib_skillList[67] = 'ACpu'
    set ib_skillName[67] = "净化"
    set ib_skillCustom[67] = 0
    set ib_skillList[68] = 'ACpv'
    set ib_skillName[68] = "粉碎"
    set ib_skillCustom[68] = 0
    set ib_skillList[69] = 'ACpy'
    set ib_skillName[69] = "变形术"
    set ib_skillCustom[69] = 0
    set ib_skillList[70] = 'ACr1'
    set ib_skillName[70] = "咆哮"
    set ib_skillCustom[70] = 0
    set ib_skillList[71] = 'ACr2'
    set ib_skillName[71] = "生命恢复"
    set ib_skillCustom[71] = 0
    set ib_skillList[72] = 'ACrd'
    set ib_skillName[72] = "复活死尸"
    set ib_skillCustom[72] = 0
    set ib_skillList[73] = 'ACrf'
    set ib_skillName[73] = "火焰雨"
    set ib_skillCustom[73] = 0
    set ib_skillList[74] = 'ACrg'
    set ib_skillName[74] = "火焰雨"
    set ib_skillCustom[74] = 0
    set ib_skillList[75] = 'ACrj'
    set ib_skillName[75] = "生命恢复"
    set ib_skillCustom[75] = 0
    set ib_skillList[76] = 'ACrk'
    set ib_skillName[76] = "抗性皮肤"
    set ib_skillCustom[76] = 0
    set ib_skillList[77] = 'ACrn'
    set ib_skillName[77] = "重生"
    set ib_skillCustom[77] = 0
    set ib_skillList[78] = 'ACro'
    set ib_skillName[78] = "咆哮"
    set ib_skillCustom[78] = 0
    set ib_skillList[79] = 'ACs7'
    set ib_skillName[79] = "野兽幽魂"
    set ib_skillCustom[79] = 0
endfunction
function IB_SkillFill1 takes nothing returns nothing
    set ib_skillList[80] = 'ACs8'
    set ib_skillName[80] = "灵兽"
    set ib_skillCustom[80] = 0
    set ib_skillList[81] = 'ACs9'
    set ib_skillName[81] = "野兽幽魂"
    set ib_skillCustom[81] = 0
    set ib_skillList[82] = 'ACsa'
    set ib_skillName[82] = "灼热之箭"
    set ib_skillCustom[82] = 0
    set ib_skillList[83] = 'ACsf'
    set ib_skillName[83] = "野兽幽魂"
    set ib_skillCustom[83] = 0
    set ib_skillList[84] = 'ACsh'
    set ib_skillName[84] = "震荡波"
    set ib_skillCustom[84] = 0
    set ib_skillList[85] = 'ACsi'
    set ib_skillName[85] = "沉默魔法"
    set ib_skillCustom[85] = 0
    set ib_skillList[86] = 'ACsk'
    set ib_skillName[86] = "抗性皮肤"
    set ib_skillCustom[86] = 0
    set ib_skillList[87] = 'ACsl'
    set ib_skillName[87] = "睡眠"
    set ib_skillCustom[87] = 0
    set ib_skillList[88] = 'ACsm'
    set ib_skillName[88] = "魔法吸吮"
    set ib_skillCustom[88] = 0
    set ib_skillList[89] = 'ACsp'
    set ib_skillName[89] = "睡眠"
    set ib_skillCustom[89] = 0
    set ib_skillList[90] = 'ACst'
    set ib_skillName[90] = "震荡波"
    set ib_skillCustom[90] = 0
    set ib_skillList[91] = 'ACsw'
    set ib_skillName[91] = "减速"
    set ib_skillCustom[91] = 0
    set ib_skillList[92] = 'ACt2'
    set ib_skillName[92] = "雷霆一击"
    set ib_skillCustom[92] = 0
    set ib_skillList[93] = 'ACtb'
    set ib_skillName[93] = "投石"
    set ib_skillCustom[93] = 0
    set ib_skillList[94] = 'ACtc'
    set ib_skillName[94] = "雷霆一击"
    set ib_skillCustom[94] = 0
    set ib_skillList[95] = 'ACtn'
    set ib_skillName[95] = "产卵触角"
    set ib_skillCustom[95] = 0
    set ib_skillList[96] = 'ACua'
    set ib_skillName[96] = "邪恶光环"
    set ib_skillCustom[96] = 0
    set ib_skillList[97] = 'ACuf'
    set ib_skillName[97] = "邪恶狂热"
    set ib_skillCustom[97] = 0
    set ib_skillList[98] = 'ACvp'
    set ib_skillName[98] = "吸血光环"
    set ib_skillCustom[98] = 0
    set ib_skillList[99] = 'ACvs'
    set ib_skillName[99] = "浸毒武器"
    set ib_skillCustom[99] = 0
    set ib_skillList[100] = 'ACwb'
    set ib_skillName[100] = "蛛网"
    set ib_skillCustom[100] = 0
    set ib_skillList[101] = 'ACwe'
    set ib_skillName[101] = "召唤海元素"
    set ib_skillCustom[101] = 0
    set ib_skillList[102] = 'AEIl'
    set ib_skillName[102] = "变身"
    set ib_skillCustom[102] = 0
    set ib_skillList[103] = 'AEah'
    set ib_skillName[103] = "荆棘光环"
    set ib_skillCustom[103] = 0
    set ib_skillList[104] = 'AEar'
    set ib_skillName[104] = "强击光环"
    set ib_skillCustom[104] = 0
    set ib_skillList[105] = 'AEbl'
    set ib_skillName[105] = "闪烁"
    set ib_skillCustom[105] = 0
    set ib_skillList[106] = 'AEbu'
    set ib_skillName[106] = "建造 (暗夜精灵)"
    set ib_skillCustom[106] = 0
    set ib_skillList[107] = 'AEer'
    set ib_skillName[107] = "纠缠根须"
    set ib_skillCustom[107] = 0
    set ib_skillList[108] = 'AEev'
    set ib_skillName[108] = "闪避"
    set ib_skillCustom[108] = 0
    set ib_skillList[109] = 'AEfk'
    set ib_skillName[109] = "刀阵旋风"
    set ib_skillCustom[109] = 0
    set ib_skillList[110] = 'AEfn'
    set ib_skillName[110] = "自然之力"
    set ib_skillCustom[110] = 0
    set ib_skillList[111] = 'AEim'
    set ib_skillName[111] = "献祭"
    set ib_skillCustom[111] = 0
    set ib_skillList[112] = 'AEmb'
    set ib_skillName[112] = "法力燃烧"
    set ib_skillCustom[112] = 0
    set ib_skillList[113] = 'AEme'
    set ib_skillName[113] = "变身"
    set ib_skillCustom[113] = 0
    set ib_skillList[114] = 'AEpa'
    set ib_skillName[114] = "毒箭"
    set ib_skillCustom[114] = 0
    set ib_skillList[115] = 'AEsb'
    set ib_skillName[115] = "群星坠落"
    set ib_skillCustom[115] = 0
    set ib_skillList[116] = 'AEsf'
    set ib_skillName[116] = "群星坠落"
    set ib_skillCustom[116] = 0
    set ib_skillList[117] = 'AEsh'
    set ib_skillName[117] = "暗影突袭"
    set ib_skillCustom[117] = 0
    set ib_skillList[118] = 'AEst'
    set ib_skillName[118] = "侦察"
    set ib_skillCustom[118] = 0
    set ib_skillList[119] = 'AEsv'
    set ib_skillName[119] = "复仇之魂"
    set ib_skillCustom[119] = 0
    set ib_skillList[120] = 'AEtq'
    set ib_skillName[120] = "宁静"
    set ib_skillCustom[120] = 0
    set ib_skillList[121] = 'AEvi'
    set ib_skillName[121] = "变身"
    set ib_skillCustom[121] = 0
    set ib_skillList[122] = 'AGbu'
    set ib_skillName[122] = "建造(娜迦)"
    set ib_skillCustom[122] = 0
    set ib_skillList[123] = 'AHab'
    set ib_skillName[123] = "辉煌光环"
    set ib_skillCustom[123] = 0
    set ib_skillList[124] = 'AHad'
    set ib_skillName[124] = "专注光环"
    set ib_skillCustom[124] = 0
    set ib_skillList[125] = 'AHav'
    set ib_skillName[125] = "天神下凡"
    set ib_skillCustom[125] = 0
    set ib_skillList[126] = 'AHbh'
    set ib_skillName[126] = "重击"
    set ib_skillCustom[126] = 0
    set ib_skillList[127] = 'AHbn'
    set ib_skillName[127] = "驱散"
    set ib_skillCustom[127] = 0
    set ib_skillList[128] = 'AHbu'
    set ib_skillName[128] = "建造(人族)"
    set ib_skillCustom[128] = 0
    set ib_skillList[129] = 'AHbz'
    set ib_skillName[129] = "暴风雪"
    set ib_skillCustom[129] = 0
    set ib_skillList[130] = 'AHca'
    set ib_skillName[130] = "冰冻冷箭"
    set ib_skillCustom[130] = 0
    set ib_skillList[131] = 'AHdr'
    set ib_skillName[131] = "魔法吸吮"
    set ib_skillCustom[131] = 0
    set ib_skillList[132] = 'AHds'
    set ib_skillName[132] = "神圣护甲"
    set ib_skillCustom[132] = 0
    set ib_skillList[133] = 'AHer'
    set ib_skillName[133] = "英雄"
    set ib_skillCustom[133] = 0
    set ib_skillList[134] = 'AHfa'
    set ib_skillName[134] = "灼热之箭"
    set ib_skillCustom[134] = 0
    set ib_skillList[135] = 'AHfs'
    set ib_skillName[135] = "烈焰风暴"
    set ib_skillCustom[135] = 0
    set ib_skillList[136] = 'AHhb'
    set ib_skillName[136] = "神圣之光"
    set ib_skillCustom[136] = 0
    set ib_skillList[137] = 'AHmt'
    set ib_skillName[137] = "群体传送"
    set ib_skillCustom[137] = 0
    set ib_skillList[138] = 'AHpx'
    set ib_skillName[138] = "火凤凰"
    set ib_skillCustom[138] = 0
    set ib_skillList[139] = 'AHre'
    set ib_skillName[139] = "复活"
    set ib_skillCustom[139] = 0
    set ib_skillList[140] = 'AHta'
    set ib_skillName[140] = "显示"
    set ib_skillCustom[140] = 0
    set ib_skillList[141] = 'AHtb'
    set ib_skillName[141] = "风暴之锤"
    set ib_skillCustom[141] = 0
    set ib_skillList[142] = 'AHtc'
    set ib_skillName[142] = "雷霆一击"
    set ib_skillCustom[142] = 0
    set ib_skillList[143] = 'AHwe'
    set ib_skillName[143] = "召唤水元素"
    set ib_skillCustom[143] = 0
    set ib_skillList[144] = 'AI2m'
    set ib_skillName[144] = "能增加魔法值的物品(200)"
    set ib_skillCustom[144] = 0
    set ib_skillList[145] = 'AIa1'
    set ib_skillName[145] = "能提高英雄属性的物品"
    set ib_skillCustom[145] = 0
    set ib_skillList[146] = 'AIa3'
    set ib_skillName[146] = "能提高英雄属性的物品"
    set ib_skillCustom[146] = 0
    set ib_skillList[147] = 'AIa4'
    set ib_skillName[147] = "能提高英雄属性的物品"
    set ib_skillCustom[147] = 0
    set ib_skillList[148] = 'AIa6'
    set ib_skillName[148] = "能提高英雄属性的物品"
    set ib_skillCustom[148] = 0
    set ib_skillList[149] = 'AIaa'
    set ib_skillName[149] = "能增加攻击力的物品"
    set ib_skillCustom[149] = 0
    set ib_skillList[150] = 'AIab'
    set ib_skillName[150] = "能提高英雄属性的物品"
    set ib_skillCustom[150] = 0
    set ib_skillList[151] = 'AIam'
    set ib_skillName[151] = "能增加敏捷度的物品"
    set ib_skillCustom[151] = 0
    set ib_skillList[152] = 'AIan'
    set ib_skillName[152] = "能操纵死尸的物品"
    set ib_skillCustom[152] = 0
    set ib_skillList[153] = 'AIas'
    set ib_skillName[153] = "能提高攻击速度的物品"
    set ib_skillCustom[153] = 0
    set ib_skillList[154] = 'AIat'
    set ib_skillName[154] = "增加攻击力的物品"
    set ib_skillCustom[154] = 0
    set ib_skillList[155] = 'AIaz'
    set ib_skillName[155] = "能提高英雄属性的物品"
    set ib_skillCustom[155] = 0
    set ib_skillList[156] = 'AIbb'
    set ib_skillName[156] = "建造微型铁匠铺"
    set ib_skillCustom[156] = 0
    set ib_skillList[157] = 'AIbf'
    set ib_skillName[157] = "建造微型农场"
    set ib_skillCustom[157] = 0
    set ib_skillList[158] = 'AIbg'
    set ib_skillName[158] = "建造小型的大厅"
    set ib_skillCustom[158] = 0
    set ib_skillList[159] = 'AIbh'
    set ib_skillName[159] = "建造微型国王祭坛"
    set ib_skillCustom[159] = 0
endfunction
function IB_SkillFill2 takes nothing returns nothing
    set ib_skillList[160] = 'AIbk'
    set ib_skillName[160] = "闪烁(物品等级)"
    set ib_skillCustom[160] = 0
    set ib_skillList[161] = 'AIbl'
    set ib_skillName[161] = "建造小型的城堡"
    set ib_skillCustom[161] = 0
    set ib_skillList[162] = 'AIbm'
    set ib_skillName[162] = "能增加魔法值的物品"
    set ib_skillCustom[162] = 0
    set ib_skillList[163] = 'AIbr'
    set ib_skillName[163] = "建造微型伐木场"
    set ib_skillCustom[163] = 0
    set ib_skillList[164] = 'AIbs'
    set ib_skillName[164] = "建造微型兵营"
    set ib_skillCustom[164] = 0
    set ib_skillList[165] = 'AIbt'
    set ib_skillName[165] = "建造小型的哨塔"
    set ib_skillCustom[165] = 0
    set ib_skillList[166] = 'AIbx'
    set ib_skillName[166] = "重击"
    set ib_skillCustom[166] = 0
    set ib_skillList[167] = 'AIcb'
    set ib_skillName[167] = "带有腐蚀攻击效果的物品"
    set ib_skillCustom[167] = 0
    set ib_skillList[168] = 'AIcf'
    set ib_skillName[168] = "具有献祭效果的物品"
    set ib_skillCustom[168] = 0
    set ib_skillList[169] = 'AIcl'
    set ib_skillName[169] = "闪电链"
    set ib_skillCustom[169] = 0
    set ib_skillList[170] = 'AIcm'
    set ib_skillName[170] = "控制魔法"
    set ib_skillCustom[170] = 0
    set ib_skillList[171] = 'AIco'
    set ib_skillName[171] = "命令物品"
    set ib_skillCustom[171] = 0
    set ib_skillList[172] = 'AIcs'
    set ib_skillName[172] = "致命一击"
    set ib_skillCustom[172] = 0
    set ib_skillList[173] = 'AIct'
    set ib_skillName[173] = "改变一天的时间"
    set ib_skillCustom[173] = 0
    set ib_skillList[174] = 'AIcy'
    set ib_skillName[174] = "飓风"
    set ib_skillCustom[174] = 0
    set ib_skillList[175] = 'AId0'
    set ib_skillName[175] = "能提高护甲的物品"
    set ib_skillCustom[175] = 0
    set ib_skillList[176] = 'AId1'
    set ib_skillName[176] = "能提高护甲的物品"
    set ib_skillCustom[176] = 0
    set ib_skillList[177] = 'AId2'
    set ib_skillName[177] = "能提高护甲的物品"
    set ib_skillCustom[177] = 0
    set ib_skillList[178] = 'AId3'
    set ib_skillName[178] = "能提高护甲的物品"
    set ib_skillCustom[178] = 0
    set ib_skillList[179] = 'AId4'
    set ib_skillName[179] = "能提高护甲的物品"
    set ib_skillCustom[179] = 0
    set ib_skillList[180] = 'AId5'
    set ib_skillName[180] = "能提高护甲的物品"
    set ib_skillCustom[180] = 0
    set ib_skillList[181] = 'AId7'
    set ib_skillName[181] = "能加强护甲的物品"
    set ib_skillCustom[181] = 0
    set ib_skillList[182] = 'AId8'
    set ib_skillName[182] = "能提高护甲的物品"
    set ib_skillCustom[182] = 0
    set ib_skillList[183] = 'AIda'
    set ib_skillName[183] = "能暂时提高一定范围内所有单位护甲的物品"
    set ib_skillCustom[183] = 0
    set ib_skillList[184] = 'AIdb'
    set ib_skillName[184] = "能暂时加强范围内所有单位护甲的物品"
    set ib_skillCustom[184] = 0
    set ib_skillList[185] = 'AIdc'
    set ib_skillName[185] = "带有锁链驱逐效果的物品"
    set ib_skillCustom[185] = 0
    set ib_skillList[186] = 'AIdd'
    set ib_skillName[186] = "passive defense"
    set ib_skillCustom[186] = 0
    set ib_skillList[187] = 'AIde'
    set ib_skillName[187] = "能增加护甲的物品"
    set ib_skillCustom[187] = 0
    set ib_skillList[188] = 'AIdf'
    set ib_skillName[188] = "能带有黑箭攻击伤害的物品"
    set ib_skillCustom[188] = 0
    set ib_skillList[189] = 'AIdi'
    set ib_skillName[189] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[189] = 0
    set ib_skillList[190] = 'AIdm'
    set ib_skillName[190] = "能对范围内的树木/墙壁造成伤害的物品"
    set ib_skillCustom[190] = 0
    set ib_skillList[191] = 'AIdn'
    set ib_skillName[191] = "影子之球 技能"
    set ib_skillCustom[191] = 0
    set ib_skillList[192] = 'AIdp'
    set ib_skillName[192] = "死亡契约"
    set ib_skillCustom[192] = 0
    set ib_skillList[193] = 'AIds'
    set ib_skillName[193] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[193] = 0
    set ib_skillList[194] = 'AIdv'
    set ib_skillName[194] = "物品神圣护甲"
    set ib_skillCustom[194] = 0
    set ib_skillList[195] = 'AIe2'
    set ib_skillName[195] = "能获取经验值的物品"
    set ib_skillCustom[195] = 0
    set ib_skillList[196] = 'AIem'
    set ib_skillName[196] = "能获取经验值的物品"
    set ib_skillCustom[196] = 0
    set ib_skillList[197] = 'AIev'
    set ib_skillName[197] = "闪避"
    set ib_skillCustom[197] = 0
    set ib_skillList[198] = 'AIfa'
    set ib_skillName[198] = "信号枪"
    set ib_skillCustom[198] = 0
    set ib_skillList[199] = 'AIfb'
    set ib_skillName[199] = "能带有火焰伤害的物品"
    set ib_skillCustom[199] = 0
    set ib_skillList[200] = 'AIfc'
    set ib_skillName[200] = "飞行地毯"
    set ib_skillCustom[200] = 0
    set ib_skillList[201] = 'AIfd'
    set ib_skillName[201] = "能召唤红龙的物品"
    set ib_skillCustom[201] = 0
    set ib_skillList[202] = 'AIfe'
    set ib_skillName[202] = "抢夺旗帜"
    set ib_skillCustom[202] = 0
    set ib_skillList[203] = 'AIff'
    set ib_skillName[203] = "能召唤熊怪的物品"
    set ib_skillCustom[203] = 0
    set ib_skillList[204] = 'AIfg'
    set ib_skillName[204] = "乌云技能"
    set ib_skillCustom[204] = 0
    set ib_skillList[205] = 'AIfh'
    set ib_skillName[205] = "能召唤地狱犬的物品"
    set ib_skillCustom[205] = 0
    set ib_skillList[206] = 'AIfi'
    set ib_skillName[206] = "霹雳闪电物品"
    set ib_skillCustom[206] = 0
    set ib_skillList[207] = 'AIfl'
    set ib_skillName[207] = "抢夺旗帜"
    set ib_skillCustom[207] = 0
    set ib_skillList[208] = 'AIfm'
    set ib_skillName[208] = "抢夺旗帜"
    set ib_skillCustom[208] = 0
    set ib_skillList[209] = 'AIfn'
    set ib_skillName[209] = "抢夺旗帜"
    set ib_skillCustom[209] = 0
    set ib_skillList[210] = 'AIfo'
    set ib_skillName[210] = "抢夺旗帜"
    set ib_skillCustom[210] = 0
    set ib_skillList[211] = 'AIfr'
    set ib_skillName[211] = "能召唤岩石傀儡的物品"
    set ib_skillCustom[211] = 0
    set ib_skillList[212] = 'AIfs'
    set ib_skillName[212] = "能召唤骷髅战士的物品"
    set ib_skillCustom[212] = 0
    set ib_skillList[213] = 'AIft'
    set ib_skillName[213] = "近战攻击带有冰冻伤害"
    set ib_skillCustom[213] = 0
    set ib_skillList[214] = 'AIfu'
    set ib_skillName[214] = "能召唤毁灭守卫的物品"
    set ib_skillCustom[214] = 0
    set ib_skillList[215] = 'AIfw'
    set ib_skillName[215] = "近战攻击带有火焰伤害"
    set ib_skillCustom[215] = 0
    set ib_skillList[216] = 'AIfx'
    set ib_skillName[216] = "物品兽族战斗标准"
    set ib_skillCustom[216] = 0
    set ib_skillList[217] = 'AIfz'
    set ib_skillName[217] = "死亡之指"
    set ib_skillCustom[217] = 0
    set ib_skillList[218] = 'AIgd'
    set ib_skillName[218] = "能带有火焰伤害的物品"
    set ib_skillCustom[218] = 0
    set ib_skillList[219] = 'AIgf'
    set ib_skillName[219] = "防御浮雕"
    set ib_skillCustom[219] = 0
    set ib_skillList[220] = 'AIgm'
    set ib_skillName[220] = "能增加敏捷度的物品"
    set ib_skillCustom[220] = 0
    set ib_skillList[221] = 'AIgo'
    set ib_skillName[221] = "金箱子"
    set ib_skillCustom[221] = 0
    set ib_skillList[222] = 'AIgu'
    set ib_skillName[222] = "防御浮雕"
    set ib_skillCustom[222] = 0
    set ib_skillList[223] = 'AIgx'
    set ib_skillName[223] = "恢复光环"
    set ib_skillCustom[223] = 0
    set ib_skillList[224] = 'AIh1'
    set ib_skillName[224] = "具有医疗效果的物品"
    set ib_skillCustom[224] = 0
    set ib_skillList[225] = 'AIh2'
    set ib_skillName[225] = "具有医疗效果的物品"
    set ib_skillCustom[225] = 0
    set ib_skillList[226] = 'AIh3'
    set ib_skillName[226] = "最小的医疗能力"
    set ib_skillCustom[226] = 0
    set ib_skillList[227] = 'AIha'
    set ib_skillName[227] = "能进行范围医疗的物品"
    set ib_skillCustom[227] = 0
    set ib_skillList[228] = 'AIhb'
    set ib_skillName[228] = "能进行范围医疗的物品"
    set ib_skillCustom[228] = 0
    set ib_skillList[229] = 'AIhe'
    set ib_skillName[229] = "具有医疗效果的物品"
    set ib_skillCustom[229] = 0
    set ib_skillList[230] = 'AIhl'
    set ib_skillName[230] = "神圣之光"
    set ib_skillCustom[230] = 0
    set ib_skillList[231] = 'AIhw'
    set ib_skillName[231] = "治疗守卫"
    set ib_skillCustom[231] = 0
    set ib_skillList[232] = 'AIhx'
    set ib_skillName[232] = "具有医疗效果的物品"
    set ib_skillCustom[232] = 0
    set ib_skillList[233] = 'AIi1'
    set ib_skillName[233] = "能提高英雄属性的物品"
    set ib_skillCustom[233] = 0
    set ib_skillList[234] = 'AIi3'
    set ib_skillName[234] = "能提高英雄属性的物品"
    set ib_skillCustom[234] = 0
    set ib_skillList[235] = 'AIi4'
    set ib_skillName[235] = "能提高英雄属性的物品"
    set ib_skillCustom[235] = 0
    set ib_skillList[236] = 'AIi6'
    set ib_skillName[236] = "能提高英雄属性的物品"
    set ib_skillCustom[236] = 0
    set ib_skillList[237] = 'AIil'
    set ib_skillName[237] = "幻象物品"
    set ib_skillCustom[237] = 0
    set ib_skillList[238] = 'AIim'
    set ib_skillName[238] = "能提高智力的物品"
    set ib_skillCustom[238] = 0
    set ib_skillList[239] = 'AIir'
    set ib_skillName[239] = "能召唤冰冻幽灵的物品"
    set ib_skillCustom[239] = 0
endfunction
function IB_SkillFill3 takes nothing returns nothing
    set ib_skillList[240] = 'AIl1'
    set ib_skillName[240] = "能增加生命值的物品"
    set ib_skillCustom[240] = 0
    set ib_skillList[241] = 'AIl2'
    set ib_skillName[241] = "能增加生命值的物品"
    set ib_skillCustom[241] = 0
    set ib_skillList[242] = 'AIlb'
    set ib_skillName[242] = "能带有闪电伤害的物品"
    set ib_skillCustom[242] = 0
    set ib_skillList[243] = 'AIlf'
    set ib_skillName[243] = "能增加生命值的物品"
    set ib_skillCustom[243] = 0
    set ib_skillList[244] = 'AIll'
    set ib_skillName[244] = "闪电之球(新的)"
    set ib_skillCustom[244] = 0
    set ib_skillList[245] = 'AIlm'
    set ib_skillName[245] = "能提高等级的物品"
    set ib_skillCustom[245] = 0
    set ib_skillList[246] = 'AIlp'
    set ib_skillName[246] = "带有净化效果的物品"
    set ib_skillCustom[246] = 0
    set ib_skillList[247] = 'AIls'
    set ib_skillName[247] = "闪电护盾"
    set ib_skillCustom[247] = 0
    set ib_skillList[248] = 'AIlu'
    set ib_skillName[248] = "木材堆"
    set ib_skillCustom[248] = 0
    set ib_skillList[249] = 'AIlx'
    set ib_skillName[249] = "近战攻击带有闪电伤害"
    set ib_skillCustom[249] = 0
    set ib_skillList[250] = 'AIlz'
    set ib_skillName[250] = "能增加生命值的物品"
    set ib_skillCustom[250] = 0
    set ib_skillList[251] = 'AIm1'
    set ib_skillName[251] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[251] = 0
    set ib_skillList[252] = 'AIm2'
    set ib_skillName[252] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[252] = 0
    set ib_skillList[253] = 'AIma'
    set ib_skillName[253] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[253] = 0
    set ib_skillList[254] = 'AImb'
    set ib_skillName[254] = "能增加魔法值的物品"
    set ib_skillCustom[254] = 0
    set ib_skillList[255] = 'AImh'
    set ib_skillName[255] = "能永久增加生命值的物品"
    set ib_skillCustom[255] = 0
    set ib_skillList[256] = 'AImi'
    set ib_skillName[256] = "能增加生命值的物品"
    set ib_skillCustom[256] = 0
    set ib_skillList[257] = 'AIml'
    set ib_skillName[257] = "能增加生命值的物品"
    set ib_skillCustom[257] = 0
    set ib_skillList[258] = 'AImm'
    set ib_skillName[258] = "能增加魔法值的物品"
    set ib_skillCustom[258] = 0
    set ib_skillList[259] = 'AImo'
    set ib_skillName[259] = "怪兽诱捕守卫"
    set ib_skillCustom[259] = 0
    set ib_skillList[260] = 'AImr'
    set ib_skillName[260] = "能提高一定范围内所有单位魔法值的物品"
    set ib_skillCustom[260] = 0
    set ib_skillList[261] = 'AIms'
    set ib_skillName[261] = "能提高移动速度的物品"
    set ib_skillCustom[261] = 0
    set ib_skillList[262] = 'AImt'
    set ib_skillName[262] = "传送权杖"
    set ib_skillCustom[262] = 0
    set ib_skillList[263] = 'AImv'
    set ib_skillName[263] = "能增加魔法值的物品(75)"
    set ib_skillCustom[263] = 0
    set ib_skillList[264] = 'AImx'
    set ib_skillName[264] = "魔法免疫"
    set ib_skillCustom[264] = 0
    set ib_skillList[265] = 'AImz'
    set ib_skillName[265] = "能增加魔法值的物品(100)"
    set ib_skillCustom[265] = 0
    set ib_skillList[266] = 'AInd'
    set ib_skillName[266] = "鼓舞"
    set ib_skillCustom[266] = 0
    set ib_skillList[267] = 'AInm'
    set ib_skillName[267] = "能增加力量的物品"
    set ib_skillCustom[267] = 0
    set ib_skillList[268] = 'AInv'
    set ib_skillName[268] = "物品栏"
    set ib_skillCustom[268] = 0
    set ib_skillList[269] = 'AIob'
    set ib_skillName[269] = "带有霜冻攻击效果的物品"
    set ib_skillCustom[269] = 0
    set ib_skillList[270] = 'AIos'
    set ib_skillName[270] = "减速"
    set ib_skillCustom[270] = 0
    set ib_skillList[271] = 'AIp1'
    set ib_skillName[271] = "普通物品-回复效果"
    set ib_skillCustom[271] = 0
    set ib_skillList[272] = 'AIp2'
    set ib_skillName[272] = "普通物品-回复效果"
    set ib_skillCustom[272] = 0
    set ib_skillList[273] = 'AIp3'
    set ib_skillName[273] = "普通物品-回复效果"
    set ib_skillCustom[273] = 0
    set ib_skillList[274] = 'AIp4'
    set ib_skillName[274] = "普通物品-回复效果"
    set ib_skillCustom[274] = 0
    set ib_skillList[275] = 'AIp5'
    set ib_skillName[275] = "普通物品-回复效果"
    set ib_skillCustom[275] = 0
    set ib_skillList[276] = 'AIp6'
    set ib_skillName[276] = "普通物品-回复效果"
    set ib_skillCustom[276] = 0
    set ib_skillList[277] = 'AIpb'
    set ib_skillName[277] = "带有毒药效果的物品"
    set ib_skillCustom[277] = 0
    set ib_skillList[278] = 'AIpg'
    set ib_skillName[278] = "带有净化效果的物品"
    set ib_skillCustom[278] = 0
    set ib_skillList[279] = 'AIpl'
    set ib_skillName[279] = "小净化药水"
    set ib_skillCustom[279] = 0
    set ib_skillList[280] = 'AIpm'
    set ib_skillName[280] = "能置放地精地雷的物品"
    set ib_skillCustom[280] = 0
    set ib_skillList[281] = 'AIpr'
    set ib_skillName[281] = "净化药水"
    set ib_skillCustom[281] = 0
    set ib_skillList[282] = 'AIps'
    set ib_skillName[282] = "带有净化效果的物品"
    set ib_skillCustom[282] = 0
    set ib_skillList[283] = 'AIpv'
    set ib_skillName[283] = "吸血药水"
    set ib_skillCustom[283] = 0
    set ib_skillList[284] = 'AIpx'
    set ib_skillName[284] = "能永久增加生命值的物品"
    set ib_skillCustom[284] = 0
    set ib_skillList[285] = 'AIpz'
    set ib_skillName[285] = "企鹅怪兽"
    set ib_skillCustom[285] = 0
    set ib_skillList[286] = 'AIra'
    set ib_skillName[286] = "能提高一定范围内所有单位魔法值和生命值的物品"
    set ib_skillCustom[286] = 0
    set ib_skillList[287] = 'AIrb'
    set ib_skillName[287] = "重生"
    set ib_skillCustom[287] = 0
    set ib_skillList[288] = 'AIrc'
    set ib_skillName[288] = "具有重生效果的物品"
    set ib_skillCustom[288] = 0
    set ib_skillList[289] = 'AIrd'
    set ib_skillName[289] = "复活死尸(物品)"
    set ib_skillCustom[289] = 0
    set ib_skillList[290] = 'AIre'
    set ib_skillName[290] = "能进行医疗和增加魔法值的单位"
    set ib_skillCustom[290] = 0
    set ib_skillList[291] = 'AIri'
    set ib_skillName[291] = "随机物品"
    set ib_skillCustom[291] = 0
    set ib_skillList[292] = 'AIrl'
    set ib_skillName[292] = "医疗剂"
    set ib_skillCustom[292] = 0
    set ib_skillList[293] = 'AIrm'
    set ib_skillName[293] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[293] = 0
    set ib_skillList[294] = 'AIrr'
    set ib_skillName[294] = "咆哮"
    set ib_skillCustom[294] = 0
    set ib_skillList[295] = 'AIrs'
    set ib_skillName[295] = "具有复活效果的物品"
    set ib_skillCustom[295] = 0
    set ib_skillList[296] = 'AIrt'
    set ib_skillName[296] = "召唤物品"
    set ib_skillCustom[296] = 0
    set ib_skillList[297] = 'AIrv'
    set ib_skillName[297] = "能显示整个地图的物品"
    set ib_skillCustom[297] = 0
    set ib_skillList[298] = 'AIrx'
    set ib_skillName[298] = "具有复活效果的物品"
    set ib_skillCustom[298] = 0
    set ib_skillList[299] = 'AIs1'
    set ib_skillName[299] = "能提高英雄属性的物品"
    set ib_skillCustom[299] = 0
    set ib_skillList[300] = 'AIs2'
    set ib_skillName[300] = "能提高进攻速度的物品"
    set ib_skillCustom[300] = 0
    set ib_skillList[301] = 'AIs3'
    set ib_skillName[301] = "能提高英雄属性的物品"
    set ib_skillCustom[301] = 0
    set ib_skillList[302] = 'AIs4'
    set ib_skillName[302] = "能提高英雄属性的物品"
    set ib_skillCustom[302] = 0
    set ib_skillList[303] = 'AIs6'
    set ib_skillName[303] = "能提高英雄属性的物品"
    set ib_skillCustom[303] = 0
    set ib_skillList[304] = 'AIsa'
    set ib_skillName[304] = "加速卷轴"
    set ib_skillCustom[304] = 0
    set ib_skillList[305] = 'AIsb'
    set ib_skillName[305] = "减速之球"
    set ib_skillCustom[305] = 0
    set ib_skillList[306] = 'AIse'
    set ib_skillName[306] = "物品沉默"
    set ib_skillCustom[306] = 0
    set ib_skillList[307] = 'AIsh'
    set ib_skillName[307] = "召唤巨魔猎头者"
    set ib_skillCustom[307] = 0
    set ib_skillList[308] = 'AIsi'
    set ib_skillName[308] = "能提高视野范围的物品"
    set ib_skillCustom[308] = 0
    set ib_skillList[309] = 'AIsl'
    set ib_skillName[309] = "恢复卷轴"
    set ib_skillCustom[309] = 0
    set ib_skillList[310] = 'AIsm'
    set ib_skillName[310] = "能增加力量的物品"
    set ib_skillCustom[310] = 0
    set ib_skillList[311] = 'AIso'
    set ib_skillName[311] = "能盗取单位灵魂的物品"
    set ib_skillCustom[311] = 0
    set ib_skillList[312] = 'AIsp'
    set ib_skillName[312] = "能暂时加快移动速度的物品"
    set ib_skillCustom[312] = 0
    set ib_skillList[313] = 'AIsr'
    set ib_skillName[313] = "魔法伤害减少"
    set ib_skillCustom[313] = 0
    set ib_skillList[314] = 'AIsw'
    set ib_skillName[314] = "岗哨守卫"
    set ib_skillCustom[314] = 0
    set ib_skillList[315] = 'AIsx'
    set ib_skillName[315] = "能提高攻击速度的物品"
    set ib_skillCustom[315] = 0
    set ib_skillList[316] = 'AIsz'
    set ib_skillName[316] = "慢性毒药"
    set ib_skillCustom[316] = 0
    set ib_skillList[317] = 'AIt6'
    set ib_skillName[317] = "增加攻击力的物品"
    set ib_skillCustom[317] = 0
    set ib_skillList[318] = 'AIt9'
    set ib_skillName[318] = "增加攻击力的物品"
    set ib_skillCustom[318] = 0
    set ib_skillList[319] = 'AIta'
    set ib_skillName[319] = "能探测一定区域的物品"
    set ib_skillCustom[319] = 0
endfunction
function IB_SkillFill4 takes nothing returns nothing
    set ib_skillList[320] = 'AItb'
    set ib_skillName[320] = "尘土之影"
    set ib_skillCustom[320] = 0
    set ib_skillList[321] = 'AItc'
    set ib_skillName[321] = "增加攻击力的物品"
    set ib_skillCustom[321] = 0
    set ib_skillList[322] = 'AItf'
    set ib_skillName[322] = "增加攻击力的物品"
    set ib_skillCustom[322] = 0
    set ib_skillList[323] = 'AItg'
    set ib_skillName[323] = "增加攻击力的物品"
    set ib_skillCustom[323] = 0
    set ib_skillList[324] = 'AIth'
    set ib_skillName[324] = "增加攻击力的物品"
    set ib_skillCustom[324] = 0
    set ib_skillList[325] = 'AIti'
    set ib_skillName[325] = "增加攻击力的物品"
    set ib_skillCustom[325] = 0
    set ib_skillList[326] = 'AItj'
    set ib_skillName[326] = "增加攻击力的物品"
    set ib_skillCustom[326] = 0
    set ib_skillList[327] = 'AItk'
    set ib_skillName[327] = "增加攻击力的物品"
    set ib_skillCustom[327] = 0
    set ib_skillList[328] = 'AItl'
    set ib_skillName[328] = "增加攻击力的物品"
    set ib_skillCustom[328] = 0
    set ib_skillList[329] = 'AItm'
    set ib_skillName[329] = "能提高智力的物品"
    set ib_skillCustom[329] = 0
    set ib_skillList[330] = 'AItn'
    set ib_skillName[330] = "增加攻击力的物品"
    set ib_skillCustom[330] = 0
    set ib_skillList[331] = 'AItp'
    set ib_skillName[331] = "回城卷轴物品"
    set ib_skillCustom[331] = 0
    set ib_skillList[332] = 'AItx'
    set ib_skillName[332] = "增加攻击力的物品"
    set ib_skillCustom[332] = 0
    set ib_skillList[333] = 'AIuf'
    set ib_skillName[333] = "邪恶狂热"
    set ib_skillCustom[333] = 0
    set ib_skillList[334] = 'AIuv'
    set ib_skillName[334] = "夜视能力"
    set ib_skillCustom[334] = 0
    set ib_skillList[335] = 'AIuw'
    set ib_skillName[335] = "能召唤熊怪战士的物品"
    set ib_skillCustom[335] = 0
    set ib_skillList[336] = 'AIv1'
    set ib_skillName[336] = "能让单位暂时隐身的物品"
    set ib_skillCustom[336] = 0
    set ib_skillList[337] = 'AIv2'
    set ib_skillName[337] = "能让单位暂时隐身的物品"
    set ib_skillCustom[337] = 0
    set ib_skillList[338] = 'AIva'
    set ib_skillName[338] = "能盗取生命值的物品"
    set ib_skillCustom[338] = 0
    set ib_skillList[339] = 'AIvi'
    set ib_skillName[339] = "能让单位暂时隐身的物品"
    set ib_skillCustom[339] = 0
    set ib_skillList[340] = 'AIvl'
    set ib_skillName[340] = "能让单位暂时无敌的物品"
    set ib_skillCustom[340] = 0
    set ib_skillList[341] = 'AIvu'
    set ib_skillName[341] = "能让单位暂时无敌的物品"
    set ib_skillCustom[341] = 0
    set ib_skillList[342] = 'AIwb'
    set ib_skillName[342] = "带有蛛网技能的物品"
    set ib_skillCustom[342] = 0
    set ib_skillList[343] = 'AIwm'
    set ib_skillName[343] = "水奴"
    set ib_skillCustom[343] = 0
    set ib_skillList[344] = 'AIx1'
    set ib_skillName[344] = "能提高英雄属性的物品"
    set ib_skillCustom[344] = 0
    set ib_skillList[345] = 'AIx2'
    set ib_skillName[345] = "能提高英雄属性的物品"
    set ib_skillCustom[345] = 0
    set ib_skillList[346] = 'AIx5'
    set ib_skillName[346] = "能提高英雄属性的物品"
    set ib_skillCustom[346] = 0
    set ib_skillList[347] = 'AIxk'
    set ib_skillName[347] = "狂暴愤怒"
    set ib_skillCustom[347] = 0
    set ib_skillList[348] = 'AIxm'
    set ib_skillName[348] = "能提高英雄三个属性的物品"
    set ib_skillCustom[348] = 0
    set ib_skillList[349] = 'AIxs'
    set ib_skillName[349] = "具有反魔法盾的物品"
    set ib_skillCustom[349] = 0
    set ib_skillList[350] = 'AIzb'
    set ib_skillName[350] = "带有冰冻攻击伤害的物品"
    set ib_skillCustom[350] = 0
    set ib_skillList[351] = 'ANab'
    set ib_skillName[351] = "酸性炸弹"
    set ib_skillCustom[351] = 0
    set ib_skillList[352] = 'ANak'
    set ib_skillName[352] = "刚毛飞射"
    set ib_skillCustom[352] = 0
    set ib_skillList[353] = 'ANav'
    set ib_skillName[353] = "天神下凡"
    set ib_skillCustom[353] = 0
    set ib_skillList[354] = 'ANb2'
    set ib_skillName[354] = "重击"
    set ib_skillCustom[354] = 0
    set ib_skillList[355] = 'ANba'
    set ib_skillName[355] = "黑暗之箭"
    set ib_skillCustom[355] = 0
    set ib_skillList[356] = 'ANbf'
    set ib_skillName[356] = "火焰呼吸"
    set ib_skillCustom[356] = 0
    set ib_skillList[357] = 'ANbh'
    set ib_skillName[357] = "重击"
    set ib_skillCustom[357] = 0
    set ib_skillList[358] = 'ANbl'
    set ib_skillName[358] = "闪烁"
    set ib_skillCustom[358] = 0
    set ib_skillList[359] = 'ANbr'
    set ib_skillName[359] = "战争咆哮"
    set ib_skillCustom[359] = 0
    set ib_skillList[360] = 'ANbs'
    set ib_skillName[360] = "黑暗之球"
    set ib_skillCustom[360] = 0
    set ib_skillList[361] = 'ANbu'
    set ib_skillName[361] = "建造(中立)"
    set ib_skillCustom[361] = 0
    set ib_skillList[362] = 'ANc1'
    set ib_skillName[362] = "火箭群"
    set ib_skillCustom[362] = 0
    set ib_skillList[363] = 'ANc2'
    set ib_skillName[363] = "火箭群"
    set ib_skillCustom[363] = 0
    set ib_skillList[364] = 'ANc3'
    set ib_skillName[364] = "火箭群"
    set ib_skillCustom[364] = 0
    set ib_skillList[365] = 'ANca'
    set ib_skillName[365] = "分裂攻击"
    set ib_skillCustom[365] = 0
    set ib_skillList[366] = 'ANcf'
    set ib_skillName[366] = "火焰呼吸"
    set ib_skillCustom[366] = 0
    set ib_skillList[367] = 'ANch'
    set ib_skillName[367] = "符咒"
    set ib_skillCustom[367] = 0
    set ib_skillList[368] = 'ANcl'
    set ib_skillName[368] = "通魔"
    set ib_skillCustom[368] = 0
    set ib_skillList[369] = 'ANcr'
    set ib_skillName[369] = "化学风暴"
    set ib_skillCustom[369] = 0
    set ib_skillList[370] = 'ANcs'
    set ib_skillName[370] = "火箭群"
    set ib_skillCustom[370] = 0
    set ib_skillList[371] = 'ANd1'
    set ib_skillName[371] = "粉碎"
    set ib_skillCustom[371] = 0
    set ib_skillList[372] = 'ANd2'
    set ib_skillName[372] = "粉碎"
    set ib_skillCustom[372] = 0
    set ib_skillList[373] = 'ANd3'
    set ib_skillName[373] = "粉碎"
    set ib_skillCustom[373] = 0
    set ib_skillList[374] = 'ANdb'
    set ib_skillName[374] = "醉拳"
    set ib_skillCustom[374] = 0
    set ib_skillList[375] = 'ANdc'
    set ib_skillName[375] = "黑暗转换"
    set ib_skillCustom[375] = 0
    set ib_skillList[376] = 'ANde'
    set ib_skillName[376] = "粉碎"
    set ib_skillCustom[376] = 0
    set ib_skillList[377] = 'ANdh'
    set ib_skillName[377] = "醉酒云雾"
    set ib_skillCustom[377] = 0
    set ib_skillList[378] = 'ANdo'
    set ib_skillName[378] = "末日审判"
    set ib_skillCustom[378] = 0
    set ib_skillList[379] = 'ANdp'
    set ib_skillName[379] = "黑暗之门"
    set ib_skillCustom[379] = 0
    set ib_skillList[380] = 'ANdr'
    set ib_skillName[380] = "生命汲取"
    set ib_skillCustom[380] = 0
    set ib_skillList[381] = 'ANef'
    set ib_skillName[381] = "\"火土风暴\""
    set ib_skillCustom[381] = 0
    set ib_skillList[382] = 'ANeg'
    set ib_skillName[382] = "工程升级"
    set ib_skillCustom[382] = 0
    set ib_skillList[383] = 'ANen'
    set ib_skillName[383] = "诱捕"
    set ib_skillCustom[383] = 0
    set ib_skillList[384] = 'ANf1'
    set ib_skillName[384] = "工厂"
    set ib_skillCustom[384] = 0
    set ib_skillList[385] = 'ANf2'
    set ib_skillName[385] = "工厂"
    set ib_skillCustom[385] = 0
    set ib_skillList[386] = 'ANf3'
    set ib_skillName[386] = "工厂"
    set ib_skillCustom[386] = 0
    set ib_skillList[387] = 'ANfa'
    set ib_skillName[387] = "霜冻之箭"
    set ib_skillCustom[387] = 0
    set ib_skillList[388] = 'ANfb'
    set ib_skillName[388] = "霹雳闪电"
    set ib_skillCustom[388] = 0
    set ib_skillList[389] = 'ANfd'
    set ib_skillName[389] = "死亡之指"
    set ib_skillCustom[389] = 0
    set ib_skillList[390] = 'ANfl'
    set ib_skillName[390] = "叉状闪电"
    set ib_skillCustom[390] = 0
    set ib_skillList[391] = 'ANfs'
    set ib_skillName[391] = "烈焰风暴"
    set ib_skillCustom[391] = 0
    set ib_skillList[392] = 'ANfy'
    set ib_skillName[392] = "工厂"
    set ib_skillCustom[392] = 0
    set ib_skillList[393] = 'ANg1'
    set ib_skillName[393] = "机器人地精"
    set ib_skillCustom[393] = 0
    set ib_skillList[394] = 'ANg2'
    set ib_skillName[394] = "机器人地精"
    set ib_skillCustom[394] = 0
    set ib_skillList[395] = 'ANg3'
    set ib_skillName[395] = "机器人地精"
    set ib_skillCustom[395] = 0
    set ib_skillList[396] = 'ANgl'
    set ib_skillName[396] = "用黄金交换木材"
    set ib_skillCustom[396] = 0
    set ib_skillList[397] = 'ANha'
    set ib_skillName[397] = "采集"
    set ib_skillCustom[397] = 0
    set ib_skillList[398] = 'ANhs'
    set ib_skillName[398] = "医疗气雾"
    set ib_skillCustom[398] = 0
    set ib_skillList[399] = 'ANht'
    set ib_skillName[399] = "恐怖嚎叫"
    set ib_skillCustom[399] = 0
endfunction
function IB_SkillFill5 takes nothing returns nothing
    set ib_skillList[400] = 'ANhw'
    set ib_skillName[400] = "医疗波"
    set ib_skillCustom[400] = 0
    set ib_skillList[401] = 'ANhx'
    set ib_skillName[401] = "妖术"
    set ib_skillCustom[401] = 0
    set ib_skillList[402] = 'ANia'
    set ib_skillName[402] = "燃灰"
    set ib_skillCustom[402] = 0
    set ib_skillList[403] = 'ANic'
    set ib_skillName[403] = "燃灰"
    set ib_skillCustom[403] = 0
    set ib_skillList[404] = 'ANin'
    set ib_skillName[404] = "地狱火"
    set ib_skillCustom[404] = 0
    set ib_skillList[405] = 'ANlg'
    set ib_skillName[405] = "用木材交换黄金"
    set ib_skillCustom[405] = 0
    set ib_skillList[406] = 'ANlm'
    set ib_skillName[406] = "召唤炎魔"
    set ib_skillCustom[406] = 0
    set ib_skillList[407] = 'ANmo'
    set ib_skillName[407] = "季风"
    set ib_skillCustom[407] = 0
    set ib_skillList[408] = 'ANmr'
    set ib_skillName[408] = "心灵腐烂"
    set ib_skillCustom[408] = 0
    set ib_skillList[409] = 'ANms'
    set ib_skillName[409] = "魔法护盾"
    set ib_skillCustom[409] = 0
    set ib_skillList[410] = 'ANpa'
    set ib_skillName[410] = "寄生虫"
    set ib_skillCustom[410] = 0
    set ib_skillList[411] = 'ANpi'
    set ib_skillName[411] = "永久的献祭"
    set ib_skillCustom[411] = 0
    set ib_skillList[412] = 'ANpr'
    set ib_skillName[412] = "保存权杖"
    set ib_skillCustom[412] = 0
    set ib_skillList[413] = 'ANr2'
    set ib_skillName[413] = "重生"
    set ib_skillCustom[413] = 0
    set ib_skillList[414] = 'ANr3'
    set ib_skillName[414] = "混乱之雨"
    set ib_skillCustom[414] = 0
    set ib_skillList[415] = 'ANrc'
    set ib_skillName[415] = "混乱之雨"
    set ib_skillCustom[415] = 0
    set ib_skillList[416] = 'ANre'
    set ib_skillName[416] = "魔法恢复光环"
    set ib_skillCustom[416] = 0
    set ib_skillList[417] = 'ANrf'
    set ib_skillName[417] = "火焰雨"
    set ib_skillCustom[417] = 0
    set ib_skillList[418] = 'ANrg'
    set ib_skillName[418] = "机器人地精"
    set ib_skillCustom[418] = 0
    set ib_skillList[419] = 'ANrl'
    set ib_skillName[419] = "生命值恢复速度"
    set ib_skillCustom[419] = 0
    set ib_skillList[420] = 'ANrn'
    set ib_skillName[420] = "重生"
    set ib_skillCustom[420] = 0
    set ib_skillList[421] = 'ANs1'
    set ib_skillName[421] = "口袋工厂"
    set ib_skillCustom[421] = 0
    set ib_skillList[422] = 'ANs2'
    set ib_skillName[422] = "口袋工厂"
    set ib_skillCustom[422] = 0
    set ib_skillList[423] = 'ANs3'
    set ib_skillName[423] = "口袋工厂"
    set ib_skillCustom[423] = 0
    set ib_skillList[424] = 'ANsa'
    set ib_skillName[424] = "避难权杖"
    set ib_skillCustom[424] = 0
    set ib_skillList[425] = 'ANsb'
    set ib_skillName[425] = "风暴之锤"
    set ib_skillCustom[425] = 0
    set ib_skillList[426] = 'ANse'
    set ib_skillName[426] = "魔法护盾"
    set ib_skillCustom[426] = 0
    set ib_skillList[427] = 'ANsg'
    set ib_skillName[427] = "召唤熊"
    set ib_skillCustom[427] = 0
    set ib_skillList[428] = 'ANsh'
    set ib_skillName[428] = "震荡波"
    set ib_skillCustom[428] = 0
    set ib_skillList[429] = 'ANsi'
    set ib_skillName[429] = "沉默魔法"
    set ib_skillCustom[429] = 0
    set ib_skillList[430] = 'ANsl'
    set ib_skillName[430] = "灵魂保存"
    set ib_skillCustom[430] = 0
    set ib_skillList[431] = 'ANso'
    set ib_skillName[431] = "灵魂燃烧"
    set ib_skillCustom[431] = 0
    set ib_skillList[432] = 'ANsp'
    set ib_skillName[432] = "间谍"
    set ib_skillCustom[432] = 0
    set ib_skillList[433] = 'ANsq'
    set ib_skillName[433] = "召唤豪猪"
    set ib_skillCustom[433] = 0
    set ib_skillList[434] = 'ANss'
    set ib_skillName[434] = "魔法护盾"
    set ib_skillCustom[434] = 0
    set ib_skillList[435] = 'ANst'
    set ib_skillName[435] = "惊吓"
    set ib_skillCustom[435] = 0
    set ib_skillList[436] = 'ANsw'
    set ib_skillName[436] = "召唤战鹰"
    set ib_skillCustom[436] = 0
    set ib_skillList[437] = 'ANsy'
    set ib_skillName[437] = "口袋工厂"
    set ib_skillCustom[437] = 0
    set ib_skillList[438] = 'ANt2'
    set ib_skillName[438] = "尖刺外壳"
    set ib_skillCustom[438] = 0
    set ib_skillList[439] = 'ANta'
    set ib_skillName[439] = "嘲讽"
    set ib_skillCustom[439] = 0
    set ib_skillList[440] = 'ANth'
    set ib_skillName[440] = "尖刺外壳"
    set ib_skillCustom[440] = 0
    set ib_skillList[441] = 'ANtm'
    set ib_skillName[441] = "点金术"
    set ib_skillCustom[441] = 0
    set ib_skillList[442] = 'ANto'
    set ib_skillName[442] = "龙卷风"
    set ib_skillCustom[442] = 0
    set ib_skillList[443] = 'ANtr'
    set ib_skillName[443] = "真实视域"
    set ib_skillCustom[443] = 0
    set ib_skillList[444] = 'ANvc'
    set ib_skillName[444] = "火山爆发"
    set ib_skillCustom[444] = 0
    set ib_skillList[445] = 'ANwk'
    set ib_skillName[445] = "疾风步"
    set ib_skillCustom[445] = 0
    set ib_skillList[446] = 'ANwm'
    set ib_skillName[446] = "水奴"
    set ib_skillCustom[446] = 0
    set ib_skillList[447] = 'AOac'
    set ib_skillName[447] = "命令光环"
    set ib_skillCustom[447] = 0
    set ib_skillList[448] = 'AOae'
    set ib_skillName[448] = "耐久光环"
    set ib_skillCustom[448] = 0
    set ib_skillList[449] = 'AObu'
    set ib_skillName[449] = "建造(兽族)"
    set ib_skillCustom[449] = 0
    set ib_skillList[450] = 'AOcl'
    set ib_skillName[450] = "闪电链"
    set ib_skillCustom[450] = 0
    set ib_skillList[451] = 'AOcr'
    set ib_skillName[451] = "致命一击"
    set ib_skillCustom[451] = 0
    set ib_skillList[452] = 'AOeq'
    set ib_skillName[452] = "地震"
    set ib_skillCustom[452] = 0
    set ib_skillList[453] = 'AOfs'
    set ib_skillName[453] = "透视"
    set ib_skillCustom[453] = 0
    set ib_skillList[454] = 'AOhw'
    set ib_skillName[454] = "医疗波"
    set ib_skillCustom[454] = 0
    set ib_skillList[455] = 'AOhx'
    set ib_skillName[455] = "妖术"
    set ib_skillCustom[455] = 0
    set ib_skillList[456] = 'AOls'
    set ib_skillName[456] = "巫毒幽魂"
    set ib_skillCustom[456] = 0
    set ib_skillList[457] = 'AOmi'
    set ib_skillName[457] = "镜像"
    set ib_skillCustom[457] = 0
    set ib_skillList[458] = 'AOr2'
    set ib_skillName[458] = "耐久光环"
    set ib_skillCustom[458] = 0
    set ib_skillList[459] = 'AOr3'
    set ib_skillName[459] = "重生"
    set ib_skillCustom[459] = 0
    set ib_skillList[460] = 'AOre'
    set ib_skillName[460] = "重生"
    set ib_skillCustom[460] = 0
    set ib_skillList[461] = 'AOs2'
    set ib_skillName[461] = "震荡波"
    set ib_skillCustom[461] = 0
    set ib_skillList[462] = 'AOsf'
    set ib_skillName[462] = "野兽幽魂"
    set ib_skillCustom[462] = 0
    set ib_skillList[463] = 'AOsh'
    set ib_skillName[463] = "震荡波"
    set ib_skillCustom[463] = 0
    set ib_skillList[464] = 'AOsw'
    set ib_skillName[464] = "毒蛇守卫"
    set ib_skillCustom[464] = 0
    set ib_skillList[465] = 'AOvd'
    set ib_skillName[465] = "巫毒"
    set ib_skillCustom[465] = 0
    set ib_skillList[466] = 'AOw2'
    set ib_skillName[466] = "战争践踏"
    set ib_skillCustom[466] = 0
    set ib_skillList[467] = 'AOwk'
    set ib_skillName[467] = "疾步风"
    set ib_skillCustom[467] = 0
    set ib_skillList[468] = 'AOws'
    set ib_skillName[468] = "战争践踏"
    set ib_skillCustom[468] = 0
    set ib_skillList[469] = 'AOww'
    set ib_skillName[469] = "剑刃风暴"
    set ib_skillCustom[469] = 0
    set ib_skillList[470] = 'APdi'
    set ib_skillName[470] = "力量上升驱散"
    set ib_skillCustom[470] = 0
    set ib_skillList[471] = 'APh1'
    set ib_skillName[471] = "力量上升治疗区域减小"
    set ib_skillCustom[471] = 0
    set ib_skillList[472] = 'APh2'
    set ib_skillName[472] = "力量上升治疗区域"
    set ib_skillCustom[472] = 0
    set ib_skillList[473] = 'APh3'
    set ib_skillName[473] = "力量上升治疗区域增强"
    set ib_skillCustom[473] = 0
    set ib_skillList[474] = 'APmg'
    set ib_skillName[474] = "神秘区域魔法恢复增强"
    set ib_skillCustom[474] = 0
    set ib_skillList[475] = 'APmr'
    set ib_skillName[475] = "神秘区域魔法恢复"
    set ib_skillCustom[475] = 0
    set ib_skillList[476] = 'APra'
    set ib_skillName[476] = "神秘区域生命/魔法恢复"
    set ib_skillCustom[476] = 0
    set ib_skillList[477] = 'APrl'
    set ib_skillName[477] = "小型复活神符"
    set ib_skillCustom[477] = 0
    set ib_skillList[478] = 'APrr'
    set ib_skillName[478] = "大型复活神符"
    set ib_skillCustom[478] = 0
    set ib_skillList[479] = 'APsa'
    set ib_skillName[479] = "速度神符"
    set ib_skillCustom[479] = 0
endfunction
function IB_SkillFill6 takes nothing returns nothing
    set ib_skillList[480] = 'APwt'
    set ib_skillName[480] = "岗哨神符"
    set ib_skillCustom[480] = 0
    set ib_skillList[481] = 'ARal'
    set ib_skillName[481] = "集结"
    set ib_skillCustom[481] = 0
    set ib_skillList[482] = 'AUan'
    set ib_skillName[482] = "操纵死尸"
    set ib_skillCustom[482] = 0
    set ib_skillList[483] = 'AUau'
    set ib_skillName[483] = "邪恶光环"
    set ib_skillCustom[483] = 0
    set ib_skillList[484] = 'AUav'
    set ib_skillName[484] = "吸血光环"
    set ib_skillCustom[484] = 0
    set ib_skillList[485] = 'AUbu'
    set ib_skillName[485] = "建造(不死族)"
    set ib_skillCustom[485] = 0
    set ib_skillList[486] = 'AUcb'
    set ib_skillName[486] = "腐尸甲虫"
    set ib_skillCustom[486] = 0
    set ib_skillList[487] = 'AUcs'
    set ib_skillName[487] = "腐臭蜂群"
    set ib_skillCustom[487] = 0
    set ib_skillList[488] = 'AUdc'
    set ib_skillName[488] = "死亡缠绕"
    set ib_skillCustom[488] = 0
    set ib_skillList[489] = 'AUdd'
    set ib_skillName[489] = "死亡凋零"
    set ib_skillCustom[489] = 0
    set ib_skillList[490] = 'AUdp'
    set ib_skillName[490] = "死亡契约"
    set ib_skillCustom[490] = 0
    set ib_skillList[491] = 'AUdr'
    set ib_skillName[491] = "黑暗仪式"
    set ib_skillCustom[491] = 0
    set ib_skillList[492] = 'AUds'
    set ib_skillName[492] = "黑暗召唤"
    set ib_skillCustom[492] = 0
    set ib_skillList[493] = 'AUfa'
    set ib_skillName[493] = "霜冻护甲"
    set ib_skillCustom[493] = 0
    set ib_skillList[494] = 'AUfn'
    set ib_skillName[494] = "霜冻新星"
    set ib_skillCustom[494] = 0
    set ib_skillList[495] = 'AUfu'
    set ib_skillName[495] = "霜冻护甲"
    set ib_skillCustom[495] = 0
    set ib_skillList[496] = 'AUim'
    set ib_skillName[496] = "穿刺"
    set ib_skillCustom[496] = 0
    set ib_skillList[497] = 'AUin'
    set ib_skillName[497] = "地狱火"
    set ib_skillCustom[497] = 0
    set ib_skillList[498] = 'AUls'
    set ib_skillName[498] = "蝗虫群"
    set ib_skillCustom[498] = 0
    set ib_skillList[499] = 'AUmd'
    set ib_skillName[499] = "黑暗召唤(马哥尼斯)"
    set ib_skillCustom[499] = 0
    set ib_skillList[500] = 'AUsl'
    set ib_skillName[500] = "睡眠"
    set ib_skillCustom[500] = 0
    set ib_skillList[501] = 'AUts'
    set ib_skillName[501] = "尖刺外壳"
    set ib_skillCustom[501] = 0
    set ib_skillList[502] = 'Aabr'
    set ib_skillName[502] = "荒芜光环"
    set ib_skillCustom[502] = 0
    set ib_skillList[503] = 'Aabs'
    set ib_skillName[503] = "吸收魔法"
    set ib_skillCustom[503] = 0
    set ib_skillList[504] = 'Aadm'
    set ib_skillName[504] = "驱逐魔法"
    set ib_skillCustom[504] = 0
    set ib_skillList[505] = 'Aaha'
    set ib_skillName[505] = "采集"
    set ib_skillCustom[505] = 0
    set ib_skillList[506] = 'Aakb'
    set ib_skillName[506] = "战鼓"
    set ib_skillCustom[506] = 0
    set ib_skillList[507] = 'Aall'
    set ib_skillName[507] = "共享商店，联盟建筑物"
    set ib_skillCustom[507] = 0
    set ib_skillList[508] = 'Aalr'
    set ib_skillName[508] = "警报"
    set ib_skillCustom[508] = 0
    set ib_skillList[509] = 'Aam2'
    set ib_skillName[509] = "反魔法外壳"
    set ib_skillCustom[509] = 0
    set ib_skillList[510] = 'Aami'
    set ib_skillName[510] = "具有反魔法盾的物品"
    set ib_skillCustom[510] = 0
    set ib_skillList[511] = 'Aamk'
    set ib_skillName[511] = "属性附加"
    set ib_skillCustom[511] = 0
    set ib_skillList[512] = 'Aams'
    set ib_skillName[512] = "反魔法外壳"
    set ib_skillCustom[512] = 0
    set ib_skillList[513] = 'Aap1'
    set ib_skillName[513] = "疾病云雾"
    set ib_skillCustom[513] = 0
    set ib_skillList[514] = 'Aap2'
    set ib_skillName[514] = "疾病云雾"
    set ib_skillCustom[514] = 0
    set ib_skillList[515] = 'Aap3'
    set ib_skillName[515] = "疾病云雾"
    set ib_skillCustom[515] = 0
    set ib_skillList[516] = 'Aap4'
    set ib_skillName[516] = "疾病云雾"
    set ib_skillCustom[516] = 0
    set ib_skillList[517] = 'Aapl'
    set ib_skillName[517] = "疾病云雾"
    set ib_skillCustom[517] = 0
    set ib_skillList[518] = 'Aarm'
    set ib_skillName[518] = "魔法恢复光环"
    set ib_skillCustom[518] = 0
    set ib_skillList[519] = 'Aasl'
    set ib_skillName[519] = "减速光环"
    set ib_skillCustom[519] = 0
    set ib_skillList[520] = 'Aast'
    set ib_skillName[520] = "先祖幽灵"
    set ib_skillCustom[520] = 0
    set ib_skillList[521] = 'Aatk'
    set ib_skillName[521] = "攻击"
    set ib_skillCustom[521] = 0
    set ib_skillList[522] = 'Aave'
    set ib_skillName[522] = "破坏者形态"
    set ib_skillCustom[522] = 0
    set ib_skillList[523] = 'Aawa'
    set ib_skillName[523] = "立刻复活英雄"
    set ib_skillCustom[523] = 0
    set ib_skillList[524] = 'Abdl'
    set ib_skillName[524] = "大型荒芜之地驱散"
    set ib_skillCustom[524] = 0
    set ib_skillList[525] = 'Abds'
    set ib_skillName[525] = "小型荒芜之地驱散"
    set ib_skillCustom[525] = 0
    set ib_skillList[526] = 'Abdt'
    set ib_skillName[526] = "钻地探测"
    set ib_skillCustom[526] = 0
    set ib_skillList[527] = 'Abgl'
    set ib_skillName[527] = "大型荒芜之地蔓延"
    set ib_skillCustom[527] = 0
    set ib_skillList[528] = 'Abgm'
    set ib_skillName[528] = "闹鬼金矿技能"
    set ib_skillCustom[528] = 0
    set ib_skillList[529] = 'Abgs'
    set ib_skillName[529] = "小型荒芜之地蔓延"
    set ib_skillCustom[529] = 0
    set ib_skillList[530] = 'Abli'
    set ib_skillName[530] = "荒芜之地"
    set ib_skillCustom[530] = 0
    set ib_skillList[531] = 'Ablo'
    set ib_skillName[531] = "嗜血术"
    set ib_skillCustom[531] = 0
    set ib_skillList[532] = 'Ablp'
    set ib_skillName[532] = "荒芜之地的置放"
    set ib_skillCustom[532] = 0
    set ib_skillList[533] = 'Abof'
    set ib_skillName[533] = "燃烧之油"
    set ib_skillCustom[533] = 0
    set ib_skillList[534] = 'Abrf'
    set ib_skillName[534] = "变熊"
    set ib_skillCustom[534] = 0
    set ib_skillList[535] = 'Absk'
    set ib_skillName[535] = "狂战士"
    set ib_skillCustom[535] = 0
    set ib_skillList[536] = 'Abtl'
    set ib_skillName[536] = "战斗位置"
    set ib_skillCustom[536] = 0
    set ib_skillList[537] = 'Abu2'
    set ib_skillName[537] = "钻地"
    set ib_skillCustom[537] = 0
    set ib_skillList[538] = 'Abu3'
    set ib_skillName[538] = "钻地"
    set ib_skillCustom[538] = 0
    set ib_skillList[539] = 'Abu5'
    set ib_skillName[539] = "钻地"
    set ib_skillCustom[539] = 0
    set ib_skillList[540] = 'Abun'
    set ib_skillName[540] = "货物保持 (兽族地洞)"
    set ib_skillCustom[540] = 0
    set ib_skillList[541] = 'Abur'
    set ib_skillName[541] = "钻地"
    set ib_skillCustom[541] = 0
    set ib_skillList[542] = 'Acan'
    set ib_skillName[542] = "吞食尸体"
    set ib_skillCustom[542] = 0
    set ib_skillList[543] = 'Acar'
    set ib_skillName[543] = "货物保持"
    set ib_skillCustom[543] = 0
    set ib_skillList[544] = 'Acdb'
    set ib_skillName[544] = "醉拳"
    set ib_skillCustom[544] = 0
    set ib_skillList[545] = 'Acdh'
    set ib_skillName[545] = "醉酒云雾"
    set ib_skillCustom[545] = 0
    set ib_skillList[546] = 'Acef'
    set ib_skillName[546] = "\"火土风暴\""
    set ib_skillCustom[546] = 0
    set ib_skillList[547] = 'Acha'
    set ib_skillName[547] = "混乱的"
    set ib_skillCustom[547] = 0
    set ib_skillList[548] = 'Achd'
    set ib_skillName[548] = "运输船保持原位"
    set ib_skillCustom[548] = 0
    set ib_skillList[549] = 'Ache'
    set ib_skillName[549] = "瓦解光线"
    set ib_skillCustom[549] = 0
    set ib_skillList[550] = 'Achl'
    set ib_skillName[550] = "装载"
    set ib_skillCustom[550] = 0
    set ib_skillList[551] = 'Acht'
    set ib_skillName[551] = "恐怖嚎叫"
    set ib_skillCustom[551] = 0
    set ib_skillList[552] = 'Aclf'
    set ib_skillName[552] = "乌云技能"
    set ib_skillCustom[552] = 0
    set ib_skillList[553] = 'Acmg'
    set ib_skillName[553] = "控制魔法"
    set ib_skillCustom[553] = 0
    set ib_skillList[554] = 'Acn2'
    set ib_skillName[554] = "吞食尸体"
    set ib_skillCustom[554] = 0
    set ib_skillList[555] = 'Acny'
    set ib_skillName[555] = "飓风"
    set ib_skillCustom[555] = 0
    set ib_skillList[556] = 'Aco2'
    set ib_skillName[556] = "骑乘角鹰兽"
    set ib_skillCustom[556] = 0
    set ib_skillList[557] = 'Aco3'
    set ib_skillName[557] = "搭载弓箭手"
    set ib_skillCustom[557] = 0
    set ib_skillList[558] = 'Acoa'
    set ib_skillName[558] = "骑乘角鹰兽"
    set ib_skillCustom[558] = 0
    set ib_skillList[559] = 'Acoh'
    set ib_skillName[559] = "搭载弓箭手"
    set ib_skillCustom[559] = 0
endfunction
function IB_SkillFill7 takes nothing returns nothing
    set ib_skillList[560] = 'Acor'
    set ib_skillName[560] = "腐蚀喷吐"
    set ib_skillCustom[560] = 0
    set ib_skillList[561] = 'Acpf'
    set ib_skillName[561] = "灵肉形态"
    set ib_skillCustom[561] = 0
    set ib_skillList[562] = 'Acri'
    set ib_skillName[562] = "残废"
    set ib_skillCustom[562] = 0
    set ib_skillList[563] = 'Acrs'
    set ib_skillName[563] = "诅咒"
    set ib_skillCustom[563] = 0
    set ib_skillList[564] = 'Acyc'
    set ib_skillName[564] = "飓风"
    set ib_skillCustom[564] = 0
    set ib_skillList[565] = 'Adch'
    set ib_skillName[565] = "消魔"
    set ib_skillCustom[565] = 0
    set ib_skillList[566] = 'Adcn'
    set ib_skillName[566] = "消魔"
    set ib_skillCustom[566] = 0
    set ib_skillList[567] = 'Adda'
    set ib_skillName[567] = "范围性攻击伤害"
    set ib_skillCustom[567] = 0
    set ib_skillList[568] = 'Adec'
    set ib_skillName[568] = "卸载"
    set ib_skillCustom[568] = 0
    set ib_skillList[569] = 'Adef'
    set ib_skillName[569] = "防御"
    set ib_skillCustom[569] = 0
    set ib_skillList[570] = 'Adet'
    set ib_skillName[570] = "探测者"
    set ib_skillCustom[570] = 0
    set ib_skillList[571] = 'Adev'
    set ib_skillName[571] = "吞噬"
    set ib_skillCustom[571] = 0
    set ib_skillList[572] = 'Adis'
    set ib_skillName[572] = "驱逐魔法"
    set ib_skillCustom[572] = 0
    set ib_skillList[573] = 'Adri'
    set ib_skillName[573] = "立刻卸载"
    set ib_skillCustom[573] = 0
    set ib_skillList[574] = 'Adro'
    set ib_skillName[574] = "卸载"
    set ib_skillCustom[574] = 0
    set ib_skillList[575] = 'Adsm'
    set ib_skillName[575] = "驱逐魔法"
    set ib_skillCustom[575] = 0
    set ib_skillList[576] = 'Adt1'
    set ib_skillName[576] = "探测者"
    set ib_skillCustom[576] = 0
    set ib_skillList[577] = 'Adta'
    set ib_skillName[577] = "显示"
    set ib_skillCustom[577] = 0
    set ib_skillList[578] = 'Adtg'
    set ib_skillName[578] = "真实视域"
    set ib_skillCustom[578] = 0
    set ib_skillList[579] = 'Adtn'
    set ib_skillName[579] = "爆炸"
    set ib_skillCustom[579] = 0
    set ib_skillList[580] = 'Adts'
    set ib_skillName[580] = "魔法岗哨"
    set ib_skillCustom[580] = 0
    set ib_skillList[581] = 'Advc'
    set ib_skillName[581] = "吞噬货物"
    set ib_skillCustom[581] = 0
    set ib_skillList[582] = 'Advm'
    set ib_skillName[582] = "吞噬魔法"
    set ib_skillCustom[582] = 0
    set ib_skillList[583] = 'Aeat'
    set ib_skillName[583] = "吞食树木"
    set ib_skillCustom[583] = 0
    set ib_skillList[584] = 'Aegm'
    set ib_skillName[584] = "缠绕金矿技能"
    set ib_skillCustom[584] = 0
    set ib_skillList[585] = 'Aegr'
    set ib_skillName[585] = "艾鲁尼之优雅"
    set ib_skillCustom[585] = 0
    set ib_skillList[586] = 'Aenc'
    set ib_skillName[586] = "装载"
    set ib_skillCustom[586] = 0
    set ib_skillList[587] = 'Aenr'
    set ib_skillName[587] = "纠缠根须"
    set ib_skillCustom[587] = 0
    set ib_skillList[588] = 'Aens'
    set ib_skillName[588] = "诱捕"
    set ib_skillCustom[588] = 0
    set ib_skillList[589] = 'Aent'
    set ib_skillName[589] = "缠绕金矿"
    set ib_skillCustom[589] = 0
    set ib_skillList[590] = 'Aenw'
    set ib_skillName[590] = "纠缠根须"
    set ib_skillCustom[590] = 0
    set ib_skillList[591] = 'Aesn'
    set ib_skillName[591] = "哨兵"
    set ib_skillCustom[591] = 0
    set ib_skillList[592] = 'Aesr'
    set ib_skillName[592] = "哨兵"
    set ib_skillCustom[592] = 0
    set ib_skillList[593] = 'Aetf'
    set ib_skillName[593] = "虚无形态"
    set ib_skillCustom[593] = 0
    set ib_skillList[594] = 'Aeth'
    set ib_skillName[594] = "幽灵"
    set ib_skillCustom[594] = 0
    set ib_skillList[595] = 'Aetl'
    set ib_skillName[595] = "虚无状态"
    set ib_skillCustom[595] = 0
    set ib_skillList[596] = 'Aexh'
    set ib_skillName[596] = "挖掘尸体"
    set ib_skillCustom[596] = 0
    set ib_skillList[597] = 'Aeye'
    set ib_skillName[597] = "岗哨守卫"
    set ib_skillCustom[597] = 0
    set ib_skillList[598] = 'Afa2'
    set ib_skillName[598] = "精灵之火"
    set ib_skillCustom[598] = 0
    set ib_skillList[599] = 'Afae'
    set ib_skillName[599] = "精灵之火"
    set ib_skillCustom[599] = 0
    set ib_skillList[600] = 'Afak'
    set ib_skillName[600] = "毁灭之球"
    set ib_skillCustom[600] = 0
    set ib_skillList[601] = 'Afbb'
    set ib_skillName[601] = "反馈"
    set ib_skillCustom[601] = 0
    set ib_skillList[602] = 'Afbk'
    set ib_skillName[602] = "魔法回应"
    set ib_skillCustom[602] = 0
    set ib_skillList[603] = 'Afbt'
    set ib_skillName[603] = "魔法回应"
    set ib_skillCustom[603] = 0
    set ib_skillList[604] = 'Afih'
    set ib_skillName[604] = "着火(人族)"
    set ib_skillCustom[604] = 0
    set ib_skillList[605] = 'Afin'
    set ib_skillName[605] = "着火(暗夜精灵)"
    set ib_skillCustom[605] = 0
    set ib_skillList[606] = 'Afio'
    set ib_skillName[606] = "着火(兽族)"
    set ib_skillCustom[606] = 0
    set ib_skillList[607] = 'Afir'
    set ib_skillName[607] = "着火"
    set ib_skillCustom[607] = 0
    set ib_skillList[608] = 'Afiu'
    set ib_skillName[608] = "着火(不死族)"
    set ib_skillCustom[608] = 0
    set ib_skillList[609] = 'Afla'
    set ib_skillName[609] = "照明弹"
    set ib_skillCustom[609] = 0
    set ib_skillList[610] = 'Aflk'
    set ib_skillName[610] = "高射炮火"
    set ib_skillCustom[610] = 0
    set ib_skillList[611] = 'Afod'
    set ib_skillName[611] = "死亡之指"
    set ib_skillCustom[611] = 0
    set ib_skillList[612] = 'Afr2'
    set ib_skillName[612] = "霜冻攻击"
    set ib_skillCustom[612] = 0
    set ib_skillList[613] = 'Afra'
    set ib_skillName[613] = "霜之攻击"
    set ib_skillCustom[613] = 0
    set ib_skillList[614] = 'Afrb'
    set ib_skillName[614] = "霜冻呼吸"
    set ib_skillCustom[614] = 0
    set ib_skillList[615] = 'Afrz'
    set ib_skillName[615] = "冰冻喷吐"
    set ib_skillCustom[615] = 0
    set ib_skillList[616] = 'Afsh'
    set ib_skillName[616] = "碎片攻击"
    set ib_skillCustom[616] = 0
    set ib_skillList[617] = 'Afzy'
    set ib_skillName[617] = "狂热"
    set ib_skillCustom[617] = 0
    set ib_skillList[618] = 'Agho'
    set ib_skillName[618] = "幽灵"
    set ib_skillCustom[618] = 0
    set ib_skillList[619] = 'Agld'
    set ib_skillName[619] = "金矿能力"
    set ib_skillCustom[619] = 0
    set ib_skillList[620] = 'Agra'
    set ib_skillName[620] = "战棍"
    set ib_skillCustom[620] = 0
    set ib_skillList[621] = 'Agyb'
    set ib_skillName[621] = "飞行机器炸弹"
    set ib_skillCustom[621] = 0
    set ib_skillList[622] = 'Agyd'
    set ib_skillName[622] = "创建尸体"
    set ib_skillCustom[622] = 0
    set ib_skillList[623] = 'Agyv'
    set ib_skillName[623] = "真实视域"
    set ib_skillCustom[623] = 0
    set ib_skillList[624] = 'Ahar'
    set ib_skillName[624] = "采集"
    set ib_skillCustom[624] = 0
    set ib_skillList[625] = 'Ahea'
    set ib_skillName[625] = "医疗"
    set ib_skillCustom[625] = 0
    set ib_skillList[626] = 'Ahid'
    set ib_skillName[626] = "影遁"
    set ib_skillCustom[626] = 0
    set ib_skillList[627] = 'Ahnl'
    set ib_skillName[627] = "召唤仪式"
    set ib_skillCustom[627] = 0
    set ib_skillList[628] = 'Ahr2'
    set ib_skillName[628] = "采集"
    set ib_skillCustom[628] = 0
    set ib_skillList[629] = 'Ahr3'
    set ib_skillName[629] = "采集"
    set ib_skillCustom[629] = 0
    set ib_skillList[630] = 'Ahrl'
    set ib_skillName[630] = "采集"
    set ib_skillCustom[630] = 0
    set ib_skillList[631] = 'Ahrp'
    set ib_skillName[631] = "修理"
    set ib_skillCustom[631] = 0
    set ib_skillList[632] = 'Ahwd'
    set ib_skillName[632] = "治疗守卫"
    set ib_skillCustom[632] = 0
    set ib_skillList[633] = 'Aien'
    set ib_skillName[633] = "单位物品栏"
    set ib_skillCustom[633] = 0
    set ib_skillList[634] = 'Aihn'
    set ib_skillName[634] = "单位物品栏"
    set ib_skillCustom[634] = 0
    set ib_skillList[635] = 'Ainf'
    set ib_skillName[635] = "心灵之火"
    set ib_skillCustom[635] = 0
    set ib_skillList[636] = 'Aion'
    set ib_skillName[636] = "单位物品栏"
    set ib_skillCustom[636] = 0
    set ib_skillList[637] = 'Aiun'
    set ib_skillName[637] = "单位物品栏"
    set ib_skillCustom[637] = 0
    set ib_skillList[638] = 'Aivs'
    set ib_skillName[638] = "隐形术"
    set ib_skillCustom[638] = 0
    set ib_skillList[639] = 'Alam'
    set ib_skillName[639] = "牺牲"
    set ib_skillCustom[639] = 0
endfunction
function IB_SkillFill8 takes nothing returns nothing
    set ib_skillList[640] = 'Aliq'
    set ib_skillName[640] = "液体炸弹"
    set ib_skillCustom[640] = 0
    set ib_skillList[641] = 'Alit'
    set ib_skillName[641] = "闪电攻击"
    set ib_skillCustom[641] = 0
    set ib_skillList[642] = 'Aloa'
    set ib_skillName[642] = "装载"
    set ib_skillCustom[642] = 0
    set ib_skillList[643] = 'Aloc'
    set ib_skillName[643] = "蝗虫"
    set ib_skillCustom[643] = 0
    set ib_skillList[644] = 'Alsh'
    set ib_skillName[644] = "闪电护盾"
    set ib_skillCustom[644] = 0
    set ib_skillList[645] = 'Amb2'
    set ib_skillName[645] = "恢复魔法"
    set ib_skillCustom[645] = 0
    set ib_skillList[646] = 'Ambb'
    set ib_skillName[646] = "法力燃烧"
    set ib_skillCustom[646] = 0
    set ib_skillList[647] = 'Ambd'
    set ib_skillName[647] = "法力燃烧"
    set ib_skillCustom[647] = 0
    set ib_skillList[648] = 'Ambt'
    set ib_skillName[648] = "补充魔法和生命值"
    set ib_skillCustom[648] = 0
    set ib_skillList[649] = 'Amdf'
    set ib_skillName[649] = "魔法防御"
    set ib_skillCustom[649] = 0
    set ib_skillList[650] = 'Amec'
    set ib_skillName[650] = "机械类的小玩艺"
    set ib_skillCustom[650] = 0
    set ib_skillList[651] = 'Amed'
    set ib_skillName[651] = "卸载尸体"
    set ib_skillCustom[651] = 0
    set ib_skillList[652] = 'Amel'
    set ib_skillName[652] = "得到尸体"
    set ib_skillCustom[652] = 0
    set ib_skillList[653] = 'Amfl'
    set ib_skillName[653] = "魔力之焰"
    set ib_skillCustom[653] = 0
    set ib_skillList[654] = 'Amgl'
    set ib_skillName[654] = "月刃"
    set ib_skillCustom[654] = 0
    set ib_skillList[655] = 'Amgr'
    set ib_skillName[655] = "月刃"
    set ib_skillCustom[655] = 0
    set ib_skillList[656] = 'Amic'
    set ib_skillName[656] = "战斗号召"
    set ib_skillCustom[656] = 0
    set ib_skillList[657] = 'Amil'
    set ib_skillName[657] = "战斗号召"
    set ib_skillCustom[657] = 0
    set ib_skillList[658] = 'Amim'
    set ib_skillName[658] = "魔法免疫"
    set ib_skillCustom[658] = 0
    set ib_skillList[659] = 'Amin'
    set ib_skillName[659] = "地雷引爆"
    set ib_skillCustom[659] = 0
    set ib_skillList[660] = 'Amls'
    set ib_skillName[660] = "空中锁镣"
    set ib_skillCustom[660] = 0
    set ib_skillList[661] = 'Amnb'
    set ib_skillName[661] = "法力燃烧"
    set ib_skillCustom[661] = 0
    set ib_skillList[662] = 'Amnx'
    set ib_skillName[662] = "范围性攻击伤害"
    set ib_skillCustom[662] = 0
    set ib_skillList[663] = 'Amnz'
    set ib_skillName[663] = "范围性攻击伤害"
    set ib_skillCustom[663] = 0
    set ib_skillList[664] = 'Amou'
    set ib_skillName[664] = "骑乘"
    set ib_skillCustom[664] = 0
    set ib_skillList[665] = 'Amov'
    set ib_skillName[665] = "移动"
    set ib_skillCustom[665] = 0
    set ib_skillList[666] = 'Amrf'
    set ib_skillName[666] = "乌鸦形态"
    set ib_skillCustom[666] = 0
    set ib_skillList[667] = 'Amtc'
    set ib_skillName[667] = "保持原位"
    set ib_skillCustom[667] = 0
    set ib_skillList[668] = 'Andm'
    set ib_skillName[668] = "驱逐魔法"
    set ib_skillCustom[668] = 0
    set ib_skillList[669] = 'Andt'
    set ib_skillName[669] = "显示"
    set ib_skillCustom[669] = 0
    set ib_skillList[670] = 'Ane2'
    set ib_skillName[670] = "选择单位"
    set ib_skillCustom[670] = 0
    set ib_skillList[671] = 'Anei'
    set ib_skillName[671] = "选择使用者"
    set ib_skillCustom[671] = 0
    set ib_skillList[672] = 'Aneu'
    set ib_skillName[672] = "选择英雄"
    set ib_skillCustom[672] = 0
    set ib_skillList[673] = 'Anh1'
    set ib_skillName[673] = "医疗"
    set ib_skillCustom[673] = 0
    set ib_skillList[674] = 'Anh2'
    set ib_skillName[674] = "医疗"
    set ib_skillCustom[674] = 0
    set ib_skillList[675] = 'Anhe'
    set ib_skillName[675] = "医疗"
    set ib_skillCustom[675] = 0
    set ib_skillList[676] = 'Anit'
    set ib_skillName[676] = "跟踪"
    set ib_skillCustom[676] = 0
    set ib_skillList[677] = 'Ansk'
    set ib_skillName[677] = "硬化皮肤"
    set ib_skillCustom[677] = 0
    set ib_skillList[678] = 'Aoar'
    set ib_skillName[678] = "治疗守卫光环"
    set ib_skillCustom[678] = 0
    set ib_skillList[679] = 'Apak'
    set ib_skillName[679] = "行囊技能"
    set ib_skillCustom[679] = 0
    set ib_skillList[680] = 'Apg2'
    set ib_skillName[680] = "净化"
    set ib_skillCustom[680] = 0
    set ib_skillList[681] = 'Aphx'
    set ib_skillName[681] = "火凤凰变形(和凤凰蛋有关的)"
    set ib_skillCustom[681] = 0
    set ib_skillList[682] = 'Apig'
    set ib_skillName[682] = "永久的献祭"
    set ib_skillCustom[682] = 0
    set ib_skillList[683] = 'Apit'
    set ib_skillName[683] = "商店购买物品"
    set ib_skillCustom[683] = 0
    set ib_skillList[684] = 'Apiv'
    set ib_skillName[684] = "永久的隐形"
    set ib_skillCustom[684] = 0
    set ib_skillList[685] = 'Aply'
    set ib_skillName[685] = "变形术"
    set ib_skillCustom[685] = 0
    set ib_skillList[686] = 'Apmf'
    set ib_skillName[686] = "凤凰火焰"
    set ib_skillCustom[686] = 0
    set ib_skillList[687] = 'Apo2'
    set ib_skillName[687] = "毒刺"
    set ib_skillCustom[687] = 0
    set ib_skillList[688] = 'Apoi'
    set ib_skillName[688] = "毒刺"
    set ib_skillCustom[688] = 0
    set ib_skillList[689] = 'Apos'
    set ib_skillName[689] = "占据"
    set ib_skillCustom[689] = 0
    set ib_skillList[690] = 'Aprg'
    set ib_skillName[690] = "净化"
    set ib_skillCustom[690] = 0
    set ib_skillList[691] = 'Aps2'
    set ib_skillName[691] = "占据"
    set ib_skillCustom[691] = 0
    set ib_skillList[692] = 'Apsh'
    set ib_skillName[692] = "变相移动"
    set ib_skillCustom[692] = 0
    set ib_skillList[693] = 'Apts'
    set ib_skillName[693] = "疾病云雾"
    set ib_skillCustom[693] = 0
    set ib_skillList[694] = 'Apxf'
    set ib_skillName[694] = "凤凰火焰"
    set ib_skillCustom[694] = 0
    set ib_skillList[695] = 'Ara2'
    set ib_skillName[695] = "咆哮"
    set ib_skillCustom[695] = 0
    set ib_skillList[696] = 'Arai'
    set ib_skillName[696] = "复活死尸"
    set ib_skillCustom[696] = 0
    set ib_skillList[697] = 'Arav'
    set ib_skillName[697] = "风暴之鸦"
    set ib_skillCustom[697] = 0
    set ib_skillList[698] = 'Arbr'
    set ib_skillName[698] = "加强型地洞升级"
    set ib_skillCustom[698] = 0
    set ib_skillList[699] = 'Arej'
    set ib_skillName[699] = "生命恢复"
    set ib_skillCustom[699] = 0
    set ib_skillList[700] = 'Arel'
    set ib_skillName[700] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[700] = 0
    set ib_skillList[701] = 'Aren'
    set ib_skillName[701] = "更新"
    set ib_skillCustom[701] = 0
    set ib_skillList[702] = 'Arep'
    set ib_skillName[702] = "修理"
    set ib_skillCustom[702] = 0
    set ib_skillList[703] = 'Aret'
    set ib_skillName[703] = "再训练之书"
    set ib_skillCustom[703] = 0
    set ib_skillList[704] = 'Arev'
    set ib_skillName[704] = "复活英雄"
    set ib_skillCustom[704] = 0
    set ib_skillList[705] = 'Argd'
    set ib_skillName[705] = "送回黄金"
    set ib_skillCustom[705] = 0
    set ib_skillList[706] = 'Argl'
    set ib_skillName[706] = "送回黄金和木材"
    set ib_skillCustom[706] = 0
    set ib_skillList[707] = 'Arll'
    set ib_skillName[707] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[707] = 0
    set ib_skillList[708] = 'Arlm'
    set ib_skillName[708] = "送回木材"
    set ib_skillCustom[708] = 0
    set ib_skillList[709] = 'Arng'
    set ib_skillName[709] = "复仇"
    set ib_skillCustom[709] = 0
    set ib_skillList[710] = 'Aro1'
    set ib_skillName[710] = "扎根"
    set ib_skillCustom[710] = 0
    set ib_skillList[711] = 'Aro2'
    set ib_skillName[711] = "扎根"
    set ib_skillCustom[711] = 0
    set ib_skillList[712] = 'Aroa'
    set ib_skillName[712] = "咆哮"
    set ib_skillCustom[712] = 0
    set ib_skillList[713] = 'Aroc'
    set ib_skillName[713] = "弹幕攻击"
    set ib_skillCustom[713] = 0
    set ib_skillList[714] = 'Aroo'
    set ib_skillName[714] = "扎根"
    set ib_skillCustom[714] = 0
    set ib_skillList[715] = 'Arpb'
    set ib_skillName[715] = "补充魔法和生命值"
    set ib_skillCustom[715] = 0
    set ib_skillList[716] = 'Arpl'
    set ib_skillName[716] = "枯萎精髓"
    set ib_skillCustom[716] = 0
    set ib_skillList[717] = 'Arpm'
    set ib_skillName[717] = "灵魂触摸"
    set ib_skillCustom[717] = 0
    set ib_skillList[718] = 'Arsg'
    set ib_skillName[718] = "召唤米纱"
    set ib_skillCustom[718] = 0
    set ib_skillList[719] = 'Arsk'
    set ib_skillName[719] = "抗性皮肤"
    set ib_skillCustom[719] = 0
endfunction
function IB_SkillFill9 takes nothing returns nothing
    set ib_skillList[720] = 'Arsp'
    set ib_skillName[720] = "惊吓"
    set ib_skillCustom[720] = 0
    set ib_skillList[721] = 'Arsq'
    set ib_skillName[721] = "召唤豪猪"
    set ib_skillCustom[721] = 0
    set ib_skillList[722] = 'Arst'
    set ib_skillName[722] = "恢复"
    set ib_skillCustom[722] = 0
    set ib_skillList[723] = 'Arsw'
    set ib_skillName[723] = "毒蛇守卫"
    set ib_skillCustom[723] = 0
    set ib_skillList[724] = 'Artn'
    set ib_skillName[724] = "返回"
    set ib_skillCustom[724] = 0
    set ib_skillList[725] = 'Asac'
    set ib_skillName[725] = "牺牲"
    set ib_skillCustom[725] = 0
    set ib_skillList[726] = 'Asal'
    set ib_skillName[726] = "掠夺"
    set ib_skillCustom[726] = 0
    set ib_skillList[727] = 'Asb1'
    set ib_skillName[727] = "潜水"
    set ib_skillCustom[727] = 0
    set ib_skillList[728] = 'Asb2'
    set ib_skillName[728] = "潜水"
    set ib_skillCustom[728] = 0
    set ib_skillList[729] = 'Asb3'
    set ib_skillName[729] = "潜水"
    set ib_skillCustom[729] = 0
    set ib_skillList[730] = 'Asd2'
    set ib_skillName[730] = "卡布恩"
    set ib_skillCustom[730] = 0
    set ib_skillList[731] = 'Asd3'
    set ib_skillName[731] = "卡布恩"
    set ib_skillCustom[731] = 0
    set ib_skillList[732] = 'Asdg'
    set ib_skillName[732] = "卡布恩"
    set ib_skillCustom[732] = 0
    set ib_skillList[733] = 'Asds'
    set ib_skillName[733] = "卡布恩"
    set ib_skillCustom[733] = 0
    set ib_skillList[734] = 'Ashm'
    set ib_skillName[734] = "影遁"
    set ib_skillCustom[734] = 0
    set ib_skillList[735] = 'Ashs'
    set ib_skillName[735] = "影子权杖"
    set ib_skillCustom[735] = 0
    set ib_skillList[736] = 'Asid'
    set ib_skillName[736] = "出售物品"
    set ib_skillCustom[736] = 0
    set ib_skillList[737] = 'Asla'
    set ib_skillName[737] = "一直睡眠"
    set ib_skillCustom[737] = 0
    set ib_skillList[738] = 'Aslo'
    set ib_skillName[738] = "减速"
    set ib_skillCustom[738] = 0
    set ib_skillList[739] = 'Aslp'
    set ib_skillName[739] = "召唤巨虾"
    set ib_skillCustom[739] = 0
    set ib_skillList[740] = 'Asod'
    set ib_skillName[740] = "产卵之骨"
    set ib_skillCustom[740] = 0
    set ib_skillList[741] = 'Asou'
    set ib_skillName[741] = "能占据单位灵魂的物品"
    set ib_skillCustom[741] = 0
    set ib_skillList[742] = 'Asp1'
    set ib_skillName[742] = "球体"
    set ib_skillCustom[742] = 0
    set ib_skillList[743] = 'Asp2'
    set ib_skillName[743] = "球体"
    set ib_skillCustom[743] = 0
    set ib_skillList[744] = 'Asp3'
    set ib_skillName[744] = "球体"
    set ib_skillCustom[744] = 0
    set ib_skillList[745] = 'Asp4'
    set ib_skillName[745] = "球体"
    set ib_skillCustom[745] = 0
    set ib_skillList[746] = 'Asp5'
    set ib_skillName[746] = "球体"
    set ib_skillCustom[746] = 0
    set ib_skillList[747] = 'Asp6'
    set ib_skillName[747] = "球体"
    set ib_skillCustom[747] = 0
    set ib_skillList[748] = 'Aspa'
    set ib_skillName[748] = "蜘蛛攻击"
    set ib_skillCustom[748] = 0
    set ib_skillList[749] = 'Aspb'
    set ib_skillName[749] = "魔法书"
    set ib_skillCustom[749] = 0
    set ib_skillList[750] = 'Aspd'
    set ib_skillName[750] = "小蜘蛛"
    set ib_skillCustom[750] = 0
    set ib_skillList[751] = 'Asph'
    set ib_skillName[751] = "球体"
    set ib_skillCustom[751] = 0
    set ib_skillList[752] = 'Aspi'
    set ib_skillName[752] = "尖形路障"
    set ib_skillCustom[752] = 0
    set ib_skillList[753] = 'Aspl'
    set ib_skillName[753] = "灵魂锁链"
    set ib_skillCustom[753] = 0
    set ib_skillList[754] = 'Aspo'
    set ib_skillName[754] = "慢性毒药"
    set ib_skillCustom[754] = 0
    set ib_skillList[755] = 'Aspp'
    set ib_skillName[755] = "灵魂锁链"
    set ib_skillCustom[755] = 0
    set ib_skillList[756] = 'Asps'
    set ib_skillName[756] = "魔法盗取"
    set ib_skillCustom[756] = 0
    set ib_skillList[757] = 'Aspt'
    set ib_skillName[757] = "诞生刺蛇幼虫"
    set ib_skillCustom[757] = 0
    set ib_skillList[758] = 'Aspy'
    set ib_skillName[758] = "诞生刺蛇"
    set ib_skillCustom[758] = 0
    set ib_skillList[759] = 'Assk'
    set ib_skillName[759] = "硬化皮肤"
    set ib_skillCustom[759] = 0
    set ib_skillList[760] = 'Assp'
    set ib_skillName[760] = "小蜘蛛"
    set ib_skillCustom[760] = 0
    set ib_skillList[761] = 'Asta'
    set ib_skillName[761] = "静止陷阱"
    set ib_skillCustom[761] = 0
    set ib_skillList[762] = 'Astd'
    set ib_skillName[762] = "卸载苦工"
    set ib_skillCustom[762] = 0
    set ib_skillList[763] = 'Aste'
    set ib_skillName[763] = "盗取"
    set ib_skillCustom[763] = 0
    set ib_skillList[764] = 'Asth'
    set ib_skillName[764] = "风暴战锤"
    set ib_skillCustom[764] = 0
    set ib_skillList[765] = 'Astn'
    set ib_skillName[765] = "石像形态"
    set ib_skillCustom[765] = 0
    set ib_skillList[766] = 'Asud'
    set ib_skillName[766] = "出售单位"
    set ib_skillCustom[766] = 0
    set ib_skillList[767] = 'Atau'
    set ib_skillName[767] = "嘲讽"
    set ib_skillCustom[767] = 0
    set ib_skillList[768] = 'Atdg'
    set ib_skillName[768] = "建筑物破坏光环"
    set ib_skillCustom[768] = 0
    set ib_skillList[769] = 'Atdp'
    set ib_skillName[769] = "卸载驾驶员"
    set ib_skillCustom[769] = 0
    set ib_skillList[770] = 'Atlp'
    set ib_skillName[770] = "装载驾驶员"
    set ib_skillCustom[770] = 0
    set ib_skillList[771] = 'Atol'
    set ib_skillName[771] = "生命之树升级技能"
    set ib_skillCustom[771] = 0
    set ib_skillList[772] = 'Atru'
    set ib_skillName[772] = "真实视域"
    set ib_skillCustom[772] = 0
    set ib_skillList[773] = 'Atsp'
    set ib_skillName[773] = "龙卷旋风"
    set ib_skillCustom[773] = 0
    set ib_skillList[774] = 'Attu'
    set ib_skillName[774] = "坦克围城"
    set ib_skillCustom[774] = 0
    set ib_skillList[775] = 'Atwa'
    set ib_skillName[775] = "龙卷风漫步者"
    set ib_skillCustom[775] = 0
    set ib_skillList[776] = 'Auco'
    set ib_skillName[776] = "不稳定化合物"
    set ib_skillCustom[776] = 0
    set ib_skillList[777] = 'Auhf'
    set ib_skillName[777] = "邪恶狂热"
    set ib_skillCustom[777] = 0
    set ib_skillList[778] = 'Ault'
    set ib_skillName[778] = "夜视能力"
    set ib_skillCustom[778] = 0
    set ib_skillList[779] = 'Auns'
    set ib_skillName[779] = "反召唤建筑"
    set ib_skillCustom[779] = 0
    set ib_skillList[780] = 'Aven'
    set ib_skillName[780] = "浸毒武器"
    set ib_skillCustom[780] = 0
    set ib_skillList[781] = 'Avng'
    set ib_skillName[781] = "复仇之魂"
    set ib_skillCustom[781] = 0
    set ib_skillList[782] = 'Avul'
    set ib_skillName[782] = "无敌的"
    set ib_skillCustom[782] = 0
    set ib_skillList[783] = 'Awan'
    set ib_skillName[783] = "游荡者"
    set ib_skillCustom[783] = 0
    set ib_skillList[784] = 'Awar'
    set ib_skillName[784] = "粉碎"
    set ib_skillCustom[784] = 0
    set ib_skillList[785] = 'Aweb'
    set ib_skillName[785] = "蛛网"
    set ib_skillCustom[785] = 0
    set ib_skillList[786] = 'Awfb'
    set ib_skillName[786] = "霹雳闪电"
    set ib_skillCustom[786] = 0
    set ib_skillList[787] = 'Awh2'
    set ib_skillName[787] = "采集"
    set ib_skillCustom[787] = 0
    set ib_skillList[788] = 'Awha'
    set ib_skillName[788] = "采集"
    set ib_skillCustom[788] = 0
    set ib_skillList[789] = 'Awhe'
    set ib_skillName[789] = "医疗"
    set ib_skillCustom[789] = 0
    set ib_skillList[790] = 'Awrg'
    set ib_skillName[790] = "战争践踏"
    set ib_skillCustom[790] = 0
    set ib_skillList[791] = 'Awrh'
    set ib_skillName[791] = "战争践踏"
    set ib_skillCustom[791] = 0
    set ib_skillList[792] = 'Awrp'
    set ib_skillName[792] = "传送门技能"
    set ib_skillCustom[792] = 0
    set ib_skillList[793] = 'Awrs'
    set ib_skillName[793] = "战争践踏"
    set ib_skillCustom[793] = 0
    set ib_skillList[794] = 'Bdbb'
    set ib_skillName[794] = "吸取生命值和魔法值（附加）"
    set ib_skillCustom[794] = 0
    set ib_skillList[795] = 'Bdbl'
    set ib_skillName[795] = "吸取生命（附加）"
    set ib_skillCustom[795] = 0
    set ib_skillList[796] = 'Bdbm'
    set ib_skillName[796] = "吸取魔法（附加）"
    set ib_skillCustom[796] = 0
    set ib_skillList[797] = 'SCae'
    set ib_skillName[797] = "耐久光环"
    set ib_skillCustom[797] = 0
    set ib_skillList[798] = 'SCc1'
    set ib_skillName[798] = "飓风"
    set ib_skillCustom[798] = 0
    set ib_skillList[799] = 'SCva'
    set ib_skillName[799] = "窃取生命"
    set ib_skillCustom[799] = 0
endfunction
function IB_SkillFill10 takes nothing returns nothing
    set ib_skillList[800] = 'SNdc'
    set ib_skillName[800] = "黑暗转换"
    set ib_skillCustom[800] = 0
    set ib_skillList[801] = 'SNdd'
    set ib_skillName[801] = "死亡凋零"
    set ib_skillCustom[801] = 0
    set ib_skillList[802] = 'SNeq'
    set ib_skillName[802] = "地震"
    set ib_skillCustom[802] = 0
    set ib_skillList[803] = 'SNin'
    set ib_skillName[803] = "地狱火"
    set ib_skillCustom[803] = 0
    set ib_skillList[804] = 'Sbsk'
    set ib_skillName[804] = "狂暴愤怒升级"
    set ib_skillCustom[804] = 0
    set ib_skillList[805] = 'Sbtl'
    set ib_skillName[805] = "战备状态"
    set ib_skillCustom[805] = 0
    set ib_skillList[806] = 'Sch2'
    set ib_skillName[806] = "保持原位"
    set ib_skillCustom[806] = 0
    set ib_skillList[807] = 'Sch3'
    set ib_skillName[807] = "保持原位"
    set ib_skillCustom[807] = 0
    set ib_skillList[808] = 'Sch4'
    set ib_skillName[808] = "保持原位"
    set ib_skillCustom[808] = 0
    set ib_skillList[809] = 'Sch5'
    set ib_skillName[809] = "保持原位"
    set ib_skillCustom[809] = 0
    set ib_skillList[810] = 'Scri'
    set ib_skillName[810] = "残废"
    set ib_skillCustom[810] = 0
    set ib_skillList[811] = 'Sdro'
    set ib_skillName[811] = "卸载"
    set ib_skillCustom[811] = 0
    set ib_skillList[812] = 'Slo2'
    set ib_skillName[812] = "装载小精灵"
    set ib_skillCustom[812] = 0
    set ib_skillList[813] = 'Slo3'
    set ib_skillName[813] = "装载"
    set ib_skillCustom[813] = 0
    set ib_skillList[814] = 'Sloa'
    set ib_skillName[814] = "装载"
    set ib_skillCustom[814] = 0
    set ib_skillList[815] = 'Sshm'
    set ib_skillName[815] = "影遁"
    set ib_skillCustom[815] = 0
    set ib_skillList[816] = 'Suhf'
    set ib_skillName[816] = "邪恶狂热"
    set ib_skillCustom[816] = 0
endfunction

function IB_UnitFill0 takes nothing returns nothing
    set ib_unitList[0] = 'Ecen'
    set ib_unitName[0] = "半神人"
    set ib_unitArmor[0] = "divine"
    set ib_unitNameGbk[0] = "������"
    set ib_unitList[1] = 'Edem'
    set ib_unitName[1] = "恶魔猎手"
    set ib_unitArmor[1] = "hero"
    set ib_unitNameGbk[1] = "��ħ����"
    set ib_unitList[2] = 'Edmm'
    set ib_unitName[2] = "恶魔猎手"
    set ib_unitArmor[2] = "hero"
    set ib_unitNameGbk[2] = "��ħ����"
    set ib_unitList[3] = 'Eevi'
    set ib_unitName[3] = "恶魔猎手"
    set ib_unitArmor[3] = "hero"
    set ib_unitNameGbk[3] = "��ħ����"
    set ib_unitList[4] = 'Eevm'
    set ib_unitName[4] = "恶魔猎手"
    set ib_unitArmor[4] = "hero"
    set ib_unitNameGbk[4] = "��ħ����"
    set ib_unitList[5] = 'Efur'
    set ib_unitName[5] = "丛林守护者"
    set ib_unitArmor[5] = "hero"
    set ib_unitNameGbk[5] = "�����ػ���"
    set ib_unitList[6] = 'Eidm'
    set ib_unitName[6] = "恶魔猎手"
    set ib_unitArmor[6] = "hero"
    set ib_unitNameGbk[6] = "��ħ����"
    set ib_unitList[7] = 'Eill'
    set ib_unitName[7] = "恶魔猎手"
    set ib_unitArmor[7] = "hero"
    set ib_unitNameGbk[7] = "��ħ����"
    set ib_unitList[8] = 'Eilm'
    set ib_unitName[8] = "恶魔猎手"
    set ib_unitArmor[8] = "hero"
    set ib_unitNameGbk[8] = "��ħ����"
    set ib_unitList[9] = 'Ekee'
    set ib_unitName[9] = "丛林守护者"
    set ib_unitArmor[9] = "hero"
    set ib_unitNameGbk[9] = "�����ػ���"
    set ib_unitList[10] = 'Ekgg'
    set ib_unitName[10] = "丛林守护者"
    set ib_unitArmor[10] = "hero"
    set ib_unitNameGbk[10] = "�����ػ���"
    set ib_unitList[11] = 'Emfr'
    set ib_unitName[11] = "丛林守护者"
    set ib_unitArmor[11] = "hero"
    set ib_unitNameGbk[11] = "�����ػ���"
    set ib_unitList[12] = 'Emns'
    set ib_unitName[12] = "丛林守护者"
    set ib_unitArmor[12] = "hero"
    set ib_unitNameGbk[12] = "�����ػ���"
    set ib_unitList[13] = 'Emoo'
    set ib_unitName[13] = "月之女祭司"
    set ib_unitArmor[13] = "hero"
    set ib_unitNameGbk[13] = "��֮Ů��˾"
    set ib_unitList[14] = 'Etyr'
    set ib_unitName[14] = "月之女祭司"
    set ib_unitArmor[14] = "hero"
    set ib_unitNameGbk[14] = "��֮Ů��˾"
    set ib_unitList[15] = 'Ewar'
    set ib_unitName[15] = "守望者"
    set ib_unitArmor[15] = "hero"
    set ib_unitNameGbk[15] = "������"
    set ib_unitList[16] = 'Ewrd'
    set ib_unitName[16] = "守望者"
    set ib_unitArmor[16] = "hero"
    set ib_unitNameGbk[16] = "������"
    set ib_unitList[17] = 'Hamg'
    set ib_unitName[17] = "大魔法师"
    set ib_unitArmor[17] = "hero"
    set ib_unitNameGbk[17] = "��ħ��ʦ"
    set ib_unitList[18] = 'Hant'
    set ib_unitName[18] = "大魔法师"
    set ib_unitArmor[18] = "hero"
    set ib_unitNameGbk[18] = "��ħ��ʦ"
    set ib_unitList[19] = 'Hapm'
    set ib_unitName[19] = "圣骑士"
    set ib_unitArmor[19] = "hero"
    set ib_unitNameGbk[19] = "ʥ��ʿ"
    set ib_unitList[20] = 'Harf'
    set ib_unitName[20] = "圣骑士"
    set ib_unitArmor[20] = "hero"
    set ib_unitNameGbk[20] = "ʥ��ʿ"
    set ib_unitList[21] = 'Hart'
    set ib_unitName[21] = "圣骑士"
    set ib_unitArmor[21] = "hero"
    set ib_unitNameGbk[21] = "ʥ��ʿ"
    set ib_unitList[22] = 'Hblm'
    set ib_unitName[22] = ""
    set ib_unitArmor[22] = "hero"
    set ib_unitNameGbk[22] = ""
    set ib_unitList[23] = 'Hdgo'
    set ib_unitName[23] = "圣骑士"
    set ib_unitArmor[23] = "hero"
    set ib_unitNameGbk[23] = "ʥ��ʿ"
    set ib_unitList[24] = 'Hgam'
    set ib_unitName[24] = "幽灵大魔法师"
    set ib_unitArmor[24] = "hero"
    set ib_unitNameGbk[24] = "�����ħ��ʦ"
    set ib_unitList[25] = 'Hhkl'
    set ib_unitName[25] = "圣骑士"
    set ib_unitArmor[25] = "hero"
    set ib_unitNameGbk[25] = "ʥ��ʿ"
    set ib_unitList[26] = 'Hjai'
    set ib_unitName[26] = "大魔法师"
    set ib_unitArmor[26] = "hero"
    set ib_unitNameGbk[26] = "��ħ��ʦ"
    set ib_unitList[27] = 'Hkal'
    set ib_unitName[27] = "血魔法师"
    set ib_unitArmor[27] = "hero"
    set ib_unitNameGbk[27] = "Ѫħ��ʦ"
    set ib_unitList[28] = 'Hlgr'
    set ib_unitName[28] = "黑暗骑士"
    set ib_unitArmor[28] = "hero"
    set ib_unitNameGbk[28] = "�ڰ���ʿ"
    set ib_unitList[29] = 'Hmbr'
    set ib_unitName[29] = "山丘之王"
    set ib_unitArmor[29] = "hero"
    set ib_unitNameGbk[29] = "ɽ��֮��"
    set ib_unitList[30] = 'Hmgd'
    set ib_unitName[30] = "圣骑士"
    set ib_unitArmor[30] = "hero"
    set ib_unitNameGbk[30] = "ʥ��ʿ"
    set ib_unitList[31] = 'Hmkg'
    set ib_unitName[31] = "山丘之王"
    set ib_unitArmor[31] = "hero"
    set ib_unitNameGbk[31] = "ɽ��֮��"
    set ib_unitList[32] = 'Hpal'
    set ib_unitName[32] = "圣骑士"
    set ib_unitArmor[32] = "hero"
    set ib_unitNameGbk[32] = "ʥ��ʿ"
    set ib_unitList[33] = 'Hpb1'
    set ib_unitName[33] = "圣骑士"
    set ib_unitArmor[33] = "hero"
    set ib_unitNameGbk[33] = "ʥ��ʿ"
    set ib_unitList[34] = 'Hpb2'
    set ib_unitName[34] = "圣骑士"
    set ib_unitArmor[34] = "hero"
    set ib_unitNameGbk[34] = "ʥ��ʿ"
    set ib_unitList[35] = 'Huth'
    set ib_unitName[35] = "圣骑士"
    set ib_unitArmor[35] = "hero"
    set ib_unitNameGbk[35] = "ʥ��ʿ"
    set ib_unitList[36] = 'Hvsh'
    set ib_unitName[36] = "娜迦女海巫"
    set ib_unitArmor[36] = "hero"
    set ib_unitNameGbk[36] = "����Ů����"
    set ib_unitList[37] = 'Hvwd'
    set ib_unitName[37] = "游侠"
    set ib_unitArmor[37] = "hero"
    set ib_unitNameGbk[37] = "����"
    set ib_unitList[38] = 'Naka'
    set ib_unitName[38] = "贤者"
    set ib_unitArmor[38] = "hero"
    set ib_unitNameGbk[38] = "����"
    set ib_unitList[39] = 'Nal2'
    set ib_unitName[39] = "炼金术士"
    set ib_unitArmor[39] = "hero"
    set ib_unitNameGbk[39] = "������ʿ"
    set ib_unitList[40] = 'Nal3'
    set ib_unitName[40] = "炼金术士"
    set ib_unitArmor[40] = "hero"
    set ib_unitNameGbk[40] = "������ʿ"
    set ib_unitList[41] = 'Nalc'
    set ib_unitName[41] = "炼金术士"
    set ib_unitArmor[41] = "hero"
    set ib_unitNameGbk[41] = "������ʿ"
    set ib_unitList[42] = 'Nalm'
    set ib_unitName[42] = "炼金术士"
    set ib_unitArmor[42] = "hero"
    set ib_unitNameGbk[42] = "������ʿ"
    set ib_unitList[43] = 'Nbbc'
    set ib_unitName[43] = "剑圣"
    set ib_unitArmor[43] = "hero"
    set ib_unitNameGbk[43] = "��ʥ"
    set ib_unitList[44] = 'Nbrn'
    set ib_unitName[44] = "黑暗游侠"
    set ib_unitArmor[44] = "hero"
    set ib_unitNameGbk[44] = "�ڰ�����"
    set ib_unitList[45] = 'Nbst'
    set ib_unitName[45] = "驯兽师"
    set ib_unitArmor[45] = "hero"
    set ib_unitNameGbk[45] = "ѱ��ʦ"
    set ib_unitList[46] = 'Nfir'
    set ib_unitName[46] = "火焰巨魔"
    set ib_unitArmor[46] = "hero"
    set ib_unitNameGbk[46] = "�����ħ"
    set ib_unitList[47] = 'Nkjx'
    set ib_unitName[47] = "巫师"
    set ib_unitArmor[47] = "hero"
    set ib_unitNameGbk[47] = "��ʦ"
    set ib_unitList[48] = 'Nklj'
    set ib_unitName[48] = "巫师"
    set ib_unitArmor[48] = "hero"
    set ib_unitNameGbk[48] = "��ʦ"
    set ib_unitList[49] = 'Nmag'
    set ib_unitName[49] = "深渊魔王"
    set ib_unitArmor[49] = "hero"
    set ib_unitNameGbk[49] = "��Ԩħ��"
    set ib_unitList[50] = 'Nman'
    set ib_unitName[50] = "深渊魔王"
    set ib_unitArmor[50] = "hero"
    set ib_unitNameGbk[50] = "��Ԩħ��"
    set ib_unitList[51] = 'Nngs'
    set ib_unitName[51] = "娜迦女海巫"
    set ib_unitArmor[51] = "hero"
    set ib_unitNameGbk[51] = "����Ů����"
    set ib_unitList[52] = 'Npbm'
    set ib_unitName[52] = "熊猫酒仙"
    set ib_unitArmor[52] = "hero"
    set ib_unitNameGbk[52] = "��è����"
    set ib_unitList[53] = 'Npld'
    set ib_unitName[53] = "深渊魔王"
    set ib_unitArmor[53] = "hero"
    set ib_unitNameGbk[53] = "��Ԩħ��"
    set ib_unitList[54] = 'Nplh'
    set ib_unitName[54] = "深渊魔王"
    set ib_unitArmor[54] = "hero"
    set ib_unitNameGbk[54] = "��Ԩħ��"
    set ib_unitList[55] = 'Nrob'
    set ib_unitName[55] = "修补匠"
    set ib_unitArmor[55] = "hero"
    set ib_unitNameGbk[55] = "�޲���"
    set ib_unitList[56] = 'Nsjs'
    set ib_unitName[56] = "熊猫酒仙"
    set ib_unitArmor[56] = "hero"
    set ib_unitNameGbk[56] = "��è����"
    set ib_unitList[57] = 'Ntin'
    set ib_unitName[57] = "修补匠"
    set ib_unitArmor[57] = "hero"
    set ib_unitNameGbk[57] = "�޲���"
    set ib_unitList[58] = 'Obla'
    set ib_unitName[58] = "剑圣"
    set ib_unitArmor[58] = "hero"
    set ib_unitNameGbk[58] = "��ʥ"
    set ib_unitList[59] = 'Ocb2'
    set ib_unitName[59] = "牛头人酋长"
    set ib_unitArmor[59] = "hero"
    set ib_unitNameGbk[59] = "ţͷ������"
    set ib_unitList[60] = 'Ocbh'
    set ib_unitName[60] = "牛头人酋长"
    set ib_unitArmor[60] = "hero"
    set ib_unitNameGbk[60] = "ţͷ������"
    set ib_unitList[61] = 'Odrt'
    set ib_unitName[61] = "先知"
    set ib_unitArmor[61] = "hero"
    set ib_unitNameGbk[61] = "��֪"
    set ib_unitList[62] = 'Ofar'
    set ib_unitName[62] = "先知"
    set ib_unitArmor[62] = "hero"
    set ib_unitNameGbk[62] = "��֪"
    set ib_unitList[63] = 'Ogld'
    set ib_unitName[63] = "巫师"
    set ib_unitArmor[63] = "hero"
    set ib_unitNameGbk[63] = "��ʦ"
    set ib_unitList[64] = 'Ogrh'
    set ib_unitName[64] = "剑圣"
    set ib_unitArmor[64] = "hero"
    set ib_unitNameGbk[64] = "��ʥ"
    set ib_unitList[65] = 'Opgh'
    set ib_unitName[65] = "剑圣"
    set ib_unitArmor[65] = "hero"
    set ib_unitNameGbk[65] = "��ʥ"
    set ib_unitList[66] = 'Orex'
    set ib_unitName[66] = "驯兽师"
    set ib_unitArmor[66] = "hero"
    set ib_unitNameGbk[66] = "ѱ��ʦ"
    set ib_unitList[67] = 'Orkn'
    set ib_unitName[67] = "暗影猎手"
    set ib_unitArmor[67] = "hero"
    set ib_unitNameGbk[67] = "��Ӱ����"
    set ib_unitList[68] = 'Osam'
    set ib_unitName[68] = "剑圣"
    set ib_unitArmor[68] = "hero"
    set ib_unitNameGbk[68] = "��ʥ"
    set ib_unitList[69] = 'Oshd'
    set ib_unitName[69] = "暗影猎手"
    set ib_unitArmor[69] = "hero"
    set ib_unitNameGbk[69] = "��Ӱ����"
    set ib_unitList[70] = 'Otcc'
    set ib_unitName[70] = "牛头人酋长"
    set ib_unitArmor[70] = "hero"
    set ib_unitNameGbk[70] = "ţͷ������"
    set ib_unitList[71] = 'Otch'
    set ib_unitName[71] = "牛头人酋长"
    set ib_unitArmor[71] = "hero"
    set ib_unitNameGbk[71] = "ţͷ������"
    set ib_unitList[72] = 'Othr'
    set ib_unitName[72] = "先知"
    set ib_unitArmor[72] = "hero"
    set ib_unitNameGbk[72] = "��֪"
    set ib_unitList[73] = 'Uanb'
    set ib_unitName[73] = "地穴领主"
    set ib_unitArmor[73] = "hero"
    set ib_unitNameGbk[73] = "��Ѩ����"
    set ib_unitList[74] = 'Ubal'
    set ib_unitName[74] = "恐惧魔王"
    set ib_unitArmor[74] = "hero"
    set ib_unitNameGbk[74] = "�־�ħ��"
    set ib_unitList[75] = 'Uclc'
    set ib_unitName[75] = "巫妖"
    set ib_unitArmor[75] = "hero"
    set ib_unitNameGbk[75] = "����"
    set ib_unitList[76] = 'Ucrl'
    set ib_unitName[76] = ""
    set ib_unitArmor[76] = "hero"
    set ib_unitNameGbk[76] = ""
    set ib_unitList[77] = 'Udea'
    set ib_unitName[77] = "死亡骑士"
    set ib_unitArmor[77] = "hero"
    set ib_unitNameGbk[77] = "������ʿ"
    set ib_unitList[78] = 'Udre'
    set ib_unitName[78] = "恐惧魔王"
    set ib_unitArmor[78] = "hero"
    set ib_unitNameGbk[78] = "�־�ħ��"
    set ib_unitList[79] = 'Udth'
    set ib_unitName[79] = "恐惧魔王"
    set ib_unitArmor[79] = "hero"
    set ib_unitNameGbk[79] = "�־�ħ��"
endfunction
function IB_UnitFill1 takes nothing returns nothing
    set ib_unitList[80] = 'Uear'
    set ib_unitName[80] = "死亡骑士"
    set ib_unitArmor[80] = "hero"
    set ib_unitNameGbk[80] = "������ʿ"
    set ib_unitList[81] = 'Uktl'
    set ib_unitName[81] = "巫妖"
    set ib_unitArmor[81] = "hero"
    set ib_unitNameGbk[81] = "����"
    set ib_unitList[82] = 'Ulic'
    set ib_unitName[82] = "巫妖"
    set ib_unitArmor[82] = "hero"
    set ib_unitNameGbk[82] = "����"
    set ib_unitList[83] = 'Umal'
    set ib_unitName[83] = "恐惧魔王"
    set ib_unitArmor[83] = "hero"
    set ib_unitNameGbk[83] = "�־�ħ��"
    set ib_unitList[84] = 'Usyl'
    set ib_unitName[84] = "黑暗游侠"
    set ib_unitArmor[84] = "hero"
    set ib_unitNameGbk[84] = "�ڰ�����"
    set ib_unitList[85] = 'Utic'
    set ib_unitName[85] = "恐惧魔王"
    set ib_unitArmor[85] = "divine"
    set ib_unitNameGbk[85] = "�־�ħ��"
    set ib_unitList[86] = 'Uvar'
    set ib_unitName[86] = "恐惧魔王"
    set ib_unitArmor[86] = "hero"
    set ib_unitNameGbk[86] = "�־�ħ��"
    set ib_unitList[87] = 'Uvng'
    set ib_unitName[87] = "恐惧魔王"
    set ib_unitArmor[87] = "hero"
    set ib_unitNameGbk[87] = "�־�ħ��"
    set ib_unitList[88] = 'Uwar'
    set ib_unitName[88] = "巫师"
    set ib_unitArmor[88] = "divine"
    set ib_unitNameGbk[88] = "��ʦ"
    set ib_unitList[89] = 'eaoe'
    set ib_unitName[89] = "知识古树"
    set ib_unitArmor[89] = "fort"
    set ib_unitNameGbk[89] = "֪ʶ����"
    set ib_unitList[90] = 'eaom'
    set ib_unitName[90] = "战争古树"
    set ib_unitArmor[90] = "fort"
    set ib_unitNameGbk[90] = "ս������"
    set ib_unitList[91] = 'eaow'
    set ib_unitName[91] = "风之古树"
    set ib_unitArmor[91] = "fort"
    set ib_unitNameGbk[91] = "��֮����"
    set ib_unitList[92] = 'earc'
    set ib_unitName[92] = "弓箭手"
    set ib_unitArmor[92] = "medium"
    set ib_unitNameGbk[92] = "������"
    set ib_unitList[93] = 'eate'
    set ib_unitName[93] = "长者祭坛"
    set ib_unitArmor[93] = "fort"
    set ib_unitNameGbk[93] = "���߼�̳"
    set ib_unitList[94] = 'ebal'
    set ib_unitName[94] = "投刃车"
    set ib_unitArmor[94] = "large"
    set ib_unitNameGbk[94] = "Ͷ�г�"
    set ib_unitList[95] = 'ebsh'
    set ib_unitName[95] = "暗夜精灵族战舰"
    set ib_unitArmor[95] = "large"
    set ib_unitNameGbk[95] = "��ҹ������ս��"
    set ib_unitList[96] = 'echm'
    set ib_unitName[96] = "奇美拉"
    set ib_unitArmor[96] = "small"
    set ib_unitNameGbk[96] = "������"
    set ib_unitList[97] = 'edcm'
    set ib_unitName[97] = "利爪德鲁伊"
    set ib_unitArmor[97] = "large"
    set ib_unitNameGbk[97] = "��צ��³��"
    set ib_unitList[98] = 'eden'
    set ib_unitName[98] = "奇迹古树"
    set ib_unitArmor[98] = "fort"
    set ib_unitNameGbk[98] = "�漣����"
    set ib_unitList[99] = 'edes'
    set ib_unitName[99] = "暗夜精灵族护卫舰"
    set ib_unitArmor[99] = "small"
    set ib_unitNameGbk[99] = "��ҹ�����廤����"
    set ib_unitList[100] = 'edob'
    set ib_unitName[100] = "猎手大厅"
    set ib_unitArmor[100] = "fort"
    set ib_unitNameGbk[100] = "���ִ���"
    set ib_unitList[101] = 'edoc'
    set ib_unitName[101] = "利爪德鲁伊"
    set ib_unitArmor[101] = "large"
    set ib_unitNameGbk[101] = "��צ��³��"
    set ib_unitList[102] = 'edos'
    set ib_unitName[102] = "奇美拉栖木"
    set ib_unitArmor[102] = "fort"
    set ib_unitNameGbk[102] = "��������ľ"
    set ib_unitList[103] = 'edot'
    set ib_unitName[103] = "猛禽德鲁伊"
    set ib_unitArmor[103] = "none"
    set ib_unitNameGbk[103] = "���ݵ�³��"
    set ib_unitList[104] = 'edry'
    set ib_unitName[104] = "树妖"
    set ib_unitArmor[104] = "none"
    set ib_unitNameGbk[104] = "����"
    set ib_unitList[105] = 'edtm'
    set ib_unitName[105] = "猛禽德鲁伊"
    set ib_unitArmor[105] = "none"
    set ib_unitNameGbk[105] = "���ݵ�³��"
    set ib_unitList[106] = 'efdr'
    set ib_unitName[106] = "精灵龙"
    set ib_unitArmor[106] = "small"
    set ib_unitNameGbk[106] = "������"
    set ib_unitList[107] = 'efon'
    set ib_unitName[107] = "树人"
    set ib_unitArmor[107] = "large"
    set ib_unitNameGbk[107] = "����"
    set ib_unitList[108] = 'egol'
    set ib_unitName[108] = "被缠绕的金矿"
    set ib_unitArmor[108] = "fort"
    set ib_unitNameGbk[108] = "�����ƵĽ��"
    set ib_unitList[109] = 'ehip'
    set ib_unitName[109] = "角鹰兽"
    set ib_unitArmor[109] = "none"
    set ib_unitNameGbk[109] = "��ӥ��"
    set ib_unitList[110] = 'ehpr'
    set ib_unitName[110] = "角鹰兽骑士"
    set ib_unitArmor[110] = "small"
    set ib_unitNameGbk[110] = "��ӥ����ʿ"
    set ib_unitList[111] = 'eilw'
    set ib_unitName[111] = "囚车"
    set ib_unitArmor[111] = "large"
    set ib_unitNameGbk[111] = "����"
    set ib_unitList[112] = 'emow'
    set ib_unitName[112] = "月亮井"
    set ib_unitArmor[112] = "fort"
    set ib_unitNameGbk[112] = "������"
    set ib_unitList[113] = 'emtg'
    set ib_unitName[113] = "山岭巨人"
    set ib_unitArmor[113] = "medium"
    set ib_unitNameGbk[113] = "ɽ�����"
    set ib_unitList[114] = 'enec'
    set ib_unitName[114] = "暗夜精灵信使"
    set ib_unitArmor[114] = "medium"
    set ib_unitNameGbk[114] = "��ҹ������ʹ"
    set ib_unitList[115] = 'ensh'
    set ib_unitName[115] = "娜萨"
    set ib_unitArmor[115] = "large"
    set ib_unitNameGbk[115] = "����"
    set ib_unitList[116] = 'esen'
    set ib_unitName[116] = "女猎手"
    set ib_unitArmor[116] = "none"
    set ib_unitNameGbk[116] = "Ů����"
    set ib_unitList[117] = 'eshd'
    set ib_unitName[117] = "塞恩德里斯"
    set ib_unitArmor[117] = "medium"
    set ib_unitNameGbk[117] = "��������˹"
    set ib_unitList[118] = 'eshy'
    set ib_unitName[118] = "暗夜精灵族船坞"
    set ib_unitArmor[118] = "fort"
    set ib_unitNameGbk[118] = "��ҹ�����崬��"
    set ib_unitList[119] = 'espv'
    set ib_unitName[119] = "复仇天神"
    set ib_unitArmor[119] = "large"
    set ib_unitNameGbk[119] = "��������"
    set ib_unitList[120] = 'etoa'
    set ib_unitName[120] = "远古之树"
    set ib_unitArmor[120] = "fort"
    set ib_unitNameGbk[120] = "Զ��֮��"
    set ib_unitList[121] = 'etoe'
    set ib_unitName[121] = "永恒之树"
    set ib_unitArmor[121] = "fort"
    set ib_unitNameGbk[121] = "����֮��"
    set ib_unitList[122] = 'etol'
    set ib_unitName[122] = "生命之树"
    set ib_unitArmor[122] = "fort"
    set ib_unitNameGbk[122] = "����֮��"
    set ib_unitList[123] = 'etrp'
    set ib_unitName[123] = "远古守护者"
    set ib_unitArmor[123] = "fort"
    set ib_unitNameGbk[123] = "Զ���ػ���"
    set ib_unitList[124] = 'etrs'
    set ib_unitName[124] = "暗夜精灵族运输船"
    set ib_unitArmor[124] = "large"
    set ib_unitNameGbk[124] = "��ҹ���������䴬"
    set ib_unitList[125] = 'even'
    set ib_unitName[125] = "复仇之魂"
    set ib_unitArmor[125] = "large"
    set ib_unitNameGbk[125] = "����֮��"
    set ib_unitList[126] = 'ewsp'
    set ib_unitName[126] = "小精灵"
    set ib_unitArmor[126] = "medium"
    set ib_unitNameGbk[126] = "С����"
    set ib_unitList[127] = 'halt'
    set ib_unitName[127] = "国王祭坛"
    set ib_unitArmor[127] = "fort"
    set ib_unitNameGbk[127] = "������̳"
    set ib_unitList[128] = 'harm'
    set ib_unitName[128] = "车间"
    set ib_unitArmor[128] = "fort"
    set ib_unitNameGbk[128] = "����"
    set ib_unitList[129] = 'haro'
    set ib_unitName[129] = "神秘了望台"
    set ib_unitArmor[129] = "fort"
    set ib_unitNameGbk[129] = "��������̨"
    set ib_unitList[130] = 'hars'
    set ib_unitName[130] = "神秘圣地"
    set ib_unitArmor[130] = "fort"
    set ib_unitNameGbk[130] = "����ʥ��"
    set ib_unitList[131] = 'hatw'
    set ib_unitName[131] = "神秘之塔"
    set ib_unitArmor[131] = "large"
    set ib_unitNameGbk[131] = "����֮��"
    set ib_unitList[132] = 'hbar'
    set ib_unitName[132] = "兵营"
    set ib_unitArmor[132] = "fort"
    set ib_unitNameGbk[132] = "��Ӫ"
    set ib_unitList[133] = 'hbew'
    set ib_unitName[133] = "车"
    set ib_unitArmor[133] = "large"
    set ib_unitNameGbk[133] = "��"
    set ib_unitList[134] = 'hbla'
    set ib_unitName[134] = "铁匠铺"
    set ib_unitArmor[134] = "fort"
    set ib_unitNameGbk[134] = "������"
    set ib_unitList[135] = 'hbot'
    set ib_unitName[135] = "人族运输船"
    set ib_unitArmor[135] = "large"
    set ib_unitNameGbk[135] = "�������䴬"
    set ib_unitList[136] = 'hbsh'
    set ib_unitName[136] = "人族战舰"
    set ib_unitArmor[136] = "large"
    set ib_unitNameGbk[136] = "����ս��"
    set ib_unitList[137] = 'hcas'
    set ib_unitName[137] = "城堡"
    set ib_unitArmor[137] = "fort"
    set ib_unitNameGbk[137] = "�Ǳ�"
    set ib_unitList[138] = 'hcth'
    set ib_unitName[138] = "船长"
    set ib_unitArmor[138] = "large"
    set ib_unitNameGbk[138] = "����"
    set ib_unitList[139] = 'hctw'
    set ib_unitName[139] = "炮塔"
    set ib_unitArmor[139] = "fort"
    set ib_unitNameGbk[139] = "����"
    set ib_unitList[140] = 'hdes'
    set ib_unitName[140] = "人族护卫舰"
    set ib_unitArmor[140] = "small"
    set ib_unitNameGbk[140] = "���廤����"
    set ib_unitList[141] = 'hdhw'
    set ib_unitName[141] = "龙鹰骑士"
    set ib_unitArmor[141] = "small"
    set ib_unitNameGbk[141] = "��ӥ��ʿ"
    set ib_unitList[142] = 'hfoo'
    set ib_unitName[142] = "步兵"
    set ib_unitArmor[142] = "large"
    set ib_unitNameGbk[142] = "����"
    set ib_unitList[143] = 'hgra'
    set ib_unitName[143] = "狮鹫笼"
    set ib_unitArmor[143] = "fort"
    set ib_unitNameGbk[143] = "ʨ����"
    set ib_unitList[144] = 'hgry'
    set ib_unitName[144] = "狮鹫骑士"
    set ib_unitArmor[144] = "small"
    set ib_unitNameGbk[144] = "ʨ����ʿ"
    set ib_unitList[145] = 'hgtw'
    set ib_unitName[145] = "防御塔"
    set ib_unitArmor[145] = "large"
    set ib_unitNameGbk[145] = "������"
    set ib_unitList[146] = 'hgyr'
    set ib_unitName[146] = "飞行机器"
    set ib_unitArmor[146] = "large"
    set ib_unitNameGbk[146] = "���л���"
    set ib_unitList[147] = 'hhdl'
    set ib_unitName[147] = "无人之马"
    set ib_unitArmor[147] = "large"
    set ib_unitNameGbk[147] = "����֮��"
    set ib_unitList[148] = 'hhes'
    set ib_unitName[148] = "剑士"
    set ib_unitArmor[148] = "large"
    set ib_unitNameGbk[148] = "��ʿ"
    set ib_unitList[149] = 'hhou'
    set ib_unitName[149] = "农场"
    set ib_unitArmor[149] = "fort"
    set ib_unitNameGbk[149] = "ũ��"
    set ib_unitList[150] = 'hkee'
    set ib_unitName[150] = "主城"
    set ib_unitArmor[150] = "fort"
    set ib_unitNameGbk[150] = "����"
    set ib_unitList[151] = 'hkni'
    set ib_unitName[151] = "骑士"
    set ib_unitArmor[151] = "large"
    set ib_unitNameGbk[151] = "��ʿ"
    set ib_unitList[152] = 'hlum'
    set ib_unitName[152] = "伐木场"
    set ib_unitArmor[152] = "fort"
    set ib_unitNameGbk[152] = "��ľ��"
    set ib_unitList[153] = 'hmil'
    set ib_unitName[153] = "民兵"
    set ib_unitArmor[153] = "large"
    set ib_unitNameGbk[153] = "���"
    set ib_unitList[154] = 'hmpr'
    set ib_unitName[154] = "牧师"
    set ib_unitArmor[154] = "none"
    set ib_unitNameGbk[154] = "��ʦ"
    set ib_unitList[155] = 'hmtm'
    set ib_unitName[155] = "迫击炮小队"
    set ib_unitArmor[155] = "large"
    set ib_unitNameGbk[155] = "�Ȼ���С��"
    set ib_unitList[156] = 'hmtt'
    set ib_unitName[156] = "蒸汽机车"
    set ib_unitArmor[156] = "fort"
    set ib_unitNameGbk[156] = "��������"
    set ib_unitList[157] = 'hpea'
    set ib_unitName[157] = "农民"
    set ib_unitArmor[157] = "medium"
    set ib_unitNameGbk[157] = "ũ��"
    set ib_unitList[158] = 'hphx'
    set ib_unitName[158] = "火凤凰"
    set ib_unitArmor[158] = "small"
    set ib_unitNameGbk[158] = "����"
    set ib_unitList[159] = 'hprt'
    set ib_unitName[159] = "传送门"
    set ib_unitArmor[159] = "fort"
    set ib_unitNameGbk[159] = "������"
endfunction
function IB_UnitFill2 takes nothing returns nothing
    set ib_unitList[160] = 'hpxe'
    set ib_unitName[160] = "凤凰蛋"
    set ib_unitArmor[160] = "large"
    set ib_unitNameGbk[160] = "��˵�"
    set ib_unitList[161] = 'hrdh'
    set ib_unitName[161] = "背负背包的马"
    set ib_unitArmor[161] = "large"
    set ib_unitNameGbk[161] = "������������"
    set ib_unitList[162] = 'hrif'
    set ib_unitName[162] = "矮人火枪手"
    set ib_unitArmor[162] = "medium"
    set ib_unitNameGbk[162] = "���˻�ǹ��"
    set ib_unitList[163] = 'hrtt'
    set ib_unitName[163] = "蒸汽机车"
    set ib_unitArmor[163] = "fort"
    set ib_unitNameGbk[163] = "��������"
    set ib_unitList[164] = 'hshy'
    set ib_unitName[164] = "人族船坞"
    set ib_unitArmor[164] = "fort"
    set ib_unitNameGbk[164] = "���崬��"
    set ib_unitList[165] = 'hsor'
    set ib_unitName[165] = "女巫"
    set ib_unitArmor[165] = "none"
    set ib_unitNameGbk[165] = "Ů��"
    set ib_unitList[166] = 'hspt'
    set ib_unitName[166] = "魔法破坏者"
    set ib_unitArmor[166] = "medium"
    set ib_unitNameGbk[166] = "ħ���ƻ���"
    set ib_unitList[167] = 'htow'
    set ib_unitName[167] = "城镇大厅"
    set ib_unitArmor[167] = "fort"
    set ib_unitNameGbk[167] = "�������"
    set ib_unitList[168] = 'hvlt'
    set ib_unitName[168] = "神秘藏宝室"
    set ib_unitArmor[168] = "fort"
    set ib_unitNameGbk[168] = "���زر���"
    set ib_unitList[169] = 'hwat'
    set ib_unitName[169] = "水元素"
    set ib_unitArmor[169] = "large"
    set ib_unitNameGbk[169] = "ˮԪ��"
    set ib_unitList[170] = 'hwt2'
    set ib_unitName[170] = "水元素"
    set ib_unitArmor[170] = "large"
    set ib_unitNameGbk[170] = "ˮԪ��"
    set ib_unitList[171] = 'hwt3'
    set ib_unitName[171] = "水元素"
    set ib_unitArmor[171] = "large"
    set ib_unitNameGbk[171] = "ˮԪ��"
    set ib_unitList[172] = 'hwtw'
    set ib_unitName[172] = "哨塔"
    set ib_unitArmor[172] = "small"
    set ib_unitNameGbk[172] = "����"
    set ib_unitList[173] = 'nadk'
    set ib_unitName[173] = "蓝蜉蝣"
    set ib_unitArmor[173] = "large"
    set ib_unitNameGbk[173] = "������"
    set ib_unitList[174] = 'nadr'
    set ib_unitName[174] = "蓝龙"
    set ib_unitArmor[174] = "large"
    set ib_unitNameGbk[174] = "����"
    set ib_unitList[175] = 'nadw'
    set ib_unitName[175] = "蓝幼龙"
    set ib_unitArmor[175] = "large"
    set ib_unitNameGbk[175] = "������"
    set ib_unitList[176] = 'nahy'
    set ib_unitName[176] = "远古九头怪蛇"
    set ib_unitArmor[176] = "large"
    set ib_unitNameGbk[176] = "Զ�ž�ͷ����"
    set ib_unitList[177] = 'nalb'
    set ib_unitName[177] = "信天翁"
    set ib_unitArmor[177] = "medium"
    set ib_unitNameGbk[177] = "������"
    set ib_unitList[178] = 'nanb'
    set ib_unitName[178] = "阿卡那瑟德刺人"
    set ib_unitArmor[178] = "medium"
    set ib_unitNameGbk[178] = "������ɪ�´���"
    set ib_unitList[179] = 'nanc'
    set ib_unitName[179] = "水晶阿卡那瑟德"
    set ib_unitArmor[179] = "large"
    set ib_unitNameGbk[179] = "ˮ��������ɪ��"
    set ib_unitList[180] = 'nane'
    set ib_unitName[180] = "阿卡那瑟德掘地者"
    set ib_unitArmor[180] = "medium"
    set ib_unitNameGbk[180] = "������ɪ�¾����"
    set ib_unitList[181] = 'nanm'
    set ib_unitName[181] = "阿卡那瑟德刺人"
    set ib_unitArmor[181] = "medium"
    set ib_unitNameGbk[181] = "������ɪ�´���"
    set ib_unitList[182] = 'nano'
    set ib_unitName[182] = "阿卡那瑟德领主"
    set ib_unitArmor[182] = "large"
    set ib_unitNameGbk[182] = "������ɪ������"
    set ib_unitList[183] = 'nanw'
    set ib_unitName[183] = "阿卡那瑟德战士"
    set ib_unitArmor[183] = "large"
    set ib_unitNameGbk[183] = "������ɪ��սʿ"
    set ib_unitList[184] = 'narg'
    set ib_unitName[184] = "傀儡战士"
    set ib_unitArmor[184] = "medium"
    set ib_unitNameGbk[184] = "����սʿ"
    set ib_unitList[185] = 'nass'
    set ib_unitName[185] = "刺客"
    set ib_unitArmor[185] = "medium"
    set ib_unitNameGbk[185] = "�̿�"
    set ib_unitList[186] = 'nba2'
    set ib_unitName[186] = "毁灭守卫"
    set ib_unitArmor[186] = "large"
    set ib_unitNameGbk[186] = "��������"
    set ib_unitList[187] = 'nbal'
    set ib_unitName[187] = "毁灭守卫"
    set ib_unitArmor[187] = "large"
    set ib_unitNameGbk[187] = "��������"
    set ib_unitList[188] = 'nban'
    set ib_unitName[188] = "强盗"
    set ib_unitArmor[188] = "large"
    set ib_unitNameGbk[188] = "ǿ��"
    set ib_unitList[189] = 'nbda'
    set ib_unitName[189] = "龙卵学徒"
    set ib_unitArmor[189] = "medium"
    set ib_unitNameGbk[189] = "����ѧͽ"
    set ib_unitList[190] = 'nbdk'
    set ib_unitName[190] = "黑蜉蝣"
    set ib_unitArmor[190] = "large"
    set ib_unitNameGbk[190] = "������"
    set ib_unitList[191] = 'nbdm'
    set ib_unitName[191] = "龙卵盗贼"
    set ib_unitArmor[191] = "large"
    set ib_unitNameGbk[191] = "���ѵ���"
    set ib_unitList[192] = 'nbdo'
    set ib_unitName[192] = "龙卵领主"
    set ib_unitArmor[192] = "large"
    set ib_unitNameGbk[192] = "��������"
    set ib_unitList[193] = 'nbdr'
    set ib_unitName[193] = "黑幼龙"
    set ib_unitArmor[193] = "large"
    set ib_unitNameGbk[193] = "������"
    set ib_unitList[194] = 'nbds'
    set ib_unitName[194] = "龙之男巫"
    set ib_unitArmor[194] = "medium"
    set ib_unitNameGbk[194] = "��֮����"
    set ib_unitList[195] = 'nbdw'
    set ib_unitName[195] = "龙卵战士"
    set ib_unitArmor[195] = "large"
    set ib_unitNameGbk[195] = "����սʿ"
    set ib_unitList[196] = 'nbee'
    set ib_unitName[196] = "血精灵工程师"
    set ib_unitArmor[196] = "large"
    set ib_unitNameGbk[196] = "Ѫ���鹤��ʦ"
    set ib_unitList[197] = 'nbel'
    set ib_unitName[197] = "血精灵中尉"
    set ib_unitArmor[197] = "large"
    set ib_unitNameGbk[197] = "Ѫ������ξ"
    set ib_unitList[198] = 'nbfl'
    set ib_unitName[198] = "血浴之泉"
    set ib_unitArmor[198] = "fort"
    set ib_unitNameGbk[198] = "Ѫԡ֮Ȫ"
    set ib_unitList[199] = 'nbld'
    set ib_unitName[199] = "强盗领主"
    set ib_unitArmor[199] = "large"
    set ib_unitNameGbk[199] = "ǿ������"
    set ib_unitList[200] = 'nbnb'
    set ib_unitName[200] = "钻地的阿卡那瑟德刺人"
    set ib_unitArmor[200] = "large"
    set ib_unitNameGbk[200] = "��صİ�����ɪ�´���"
    set ib_unitList[201] = 'nbot'
    set ib_unitName[201] = "运输船"
    set ib_unitArmor[201] = "large"
    set ib_unitNameGbk[201] = "���䴬"
    set ib_unitList[202] = 'nbrg'
    set ib_unitName[202] = "土匪"
    set ib_unitArmor[202] = "large"
    set ib_unitNameGbk[202] = "����"
    set ib_unitList[203] = 'nbse'
    set ib_unitName[203] = "复活石"
    set ib_unitArmor[203] = "fort"
    set ib_unitNameGbk[203] = "����ʯ"
    set ib_unitList[204] = 'nbsm'
    set ib_unitName[204] = "召唤底座之书"
    set ib_unitArmor[204] = "fort"
    set ib_unitNameGbk[204] = "�ٻ�����֮��"
    set ib_unitList[205] = 'nbsp'
    set ib_unitName[205] = "船只"
    set ib_unitArmor[205] = "fort"
    set ib_unitNameGbk[205] = "��ֻ"
    set ib_unitList[206] = 'nbsw'
    set ib_unitName[206] = "复活石"
    set ib_unitArmor[206] = "fort"
    set ib_unitNameGbk[206] = "����ʯ"
    set ib_unitList[207] = 'nbt1'
    set ib_unitName[207] = "巨石之塔"
    set ib_unitArmor[207] = "fort"
    set ib_unitNameGbk[207] = "��ʯ֮��"
    set ib_unitList[208] = 'nbt2'
    set ib_unitName[208] = "高级巨石之塔"
    set ib_unitArmor[208] = "fort"
    set ib_unitNameGbk[208] = "�߼���ʯ֮��"
    set ib_unitList[209] = 'nbwd'
    set ib_unitName[209] = "兽穴"
    set ib_unitArmor[209] = "fort"
    set ib_unitNameGbk[209] = "��Ѩ"
    set ib_unitList[210] = 'nbwm'
    set ib_unitName[210] = "黑龙"
    set ib_unitArmor[210] = "large"
    set ib_unitNameGbk[210] = "����"
    set ib_unitList[211] = 'nbzd'
    set ib_unitName[211] = "青龙"
    set ib_unitArmor[211] = "large"
    set ib_unitNameGbk[211] = "����"
    set ib_unitList[212] = 'nbzk'
    set ib_unitName[212] = "青蜉蝣"
    set ib_unitArmor[212] = "large"
    set ib_unitNameGbk[212] = "������"
    set ib_unitList[213] = 'nbzw'
    set ib_unitName[213] = "青幼龙"
    set ib_unitArmor[213] = "large"
    set ib_unitNameGbk[213] = "������"
    set ib_unitList[214] = 'ncap'
    set ib_unitName[214] = "远古守护者"
    set ib_unitArmor[214] = "fort"
    set ib_unitNameGbk[214] = "Զ���ػ���"
    set ib_unitList[215] = 'ncat'
    set ib_unitName[215] = "达拉内尔粉碎者"
    set ib_unitArmor[215] = "large"
    set ib_unitNameGbk[215] = "�����ڶ�������"
    set ib_unitList[216] = 'ncaw'
    set ib_unitName[216] = "战争古树"
    set ib_unitArmor[216] = "fort"
    set ib_unitNameGbk[216] = "ս������"
    set ib_unitList[217] = 'ncb0'
    set ib_unitName[217] = "城市建筑物"
    set ib_unitArmor[217] = "fort"
    set ib_unitNameGbk[217] = "���н�����"
    set ib_unitList[218] = 'ncb1'
    set ib_unitName[218] = "城市建筑物"
    set ib_unitArmor[218] = "fort"
    set ib_unitNameGbk[218] = "���н�����"
    set ib_unitList[219] = 'ncb2'
    set ib_unitName[219] = "城市建筑物"
    set ib_unitArmor[219] = "fort"
    set ib_unitNameGbk[219] = "���н�����"
    set ib_unitList[220] = 'ncb3'
    set ib_unitName[220] = "城市建筑物"
    set ib_unitArmor[220] = "fort"
    set ib_unitNameGbk[220] = "���н�����"
    set ib_unitList[221] = 'ncb4'
    set ib_unitName[221] = "城市建筑物"
    set ib_unitArmor[221] = "fort"
    set ib_unitNameGbk[221] = "���н�����"
    set ib_unitList[222] = 'ncb5'
    set ib_unitName[222] = "城市建筑物"
    set ib_unitArmor[222] = "fort"
    set ib_unitNameGbk[222] = "���н�����"
    set ib_unitList[223] = 'ncb6'
    set ib_unitName[223] = "城市建筑物"
    set ib_unitArmor[223] = "fort"
    set ib_unitNameGbk[223] = "���н�����"
    set ib_unitList[224] = 'ncb7'
    set ib_unitName[224] = "城市建筑物"
    set ib_unitArmor[224] = "fort"
    set ib_unitNameGbk[224] = "���н�����"
    set ib_unitList[225] = 'ncb8'
    set ib_unitName[225] = "城市建筑物"
    set ib_unitArmor[225] = "fort"
    set ib_unitNameGbk[225] = "���н�����"
    set ib_unitList[226] = 'ncb9'
    set ib_unitName[226] = "城市建筑物"
    set ib_unitArmor[226] = "fort"
    set ib_unitNameGbk[226] = "���н�����"
    set ib_unitList[227] = 'ncba'
    set ib_unitName[227] = "城市建筑物"
    set ib_unitArmor[227] = "fort"
    set ib_unitNameGbk[227] = "���н�����"
    set ib_unitList[228] = 'ncbb'
    set ib_unitName[228] = "城市建筑物"
    set ib_unitArmor[228] = "fort"
    set ib_unitNameGbk[228] = "���н�����"
    set ib_unitList[229] = 'ncbc'
    set ib_unitName[229] = "城市建筑物"
    set ib_unitArmor[229] = "fort"
    set ib_unitNameGbk[229] = "���н�����"
    set ib_unitList[230] = 'ncbd'
    set ib_unitName[230] = "城市建筑物"
    set ib_unitArmor[230] = "fort"
    set ib_unitNameGbk[230] = "���н�����"
    set ib_unitList[231] = 'ncbe'
    set ib_unitName[231] = "城市建筑物"
    set ib_unitArmor[231] = "fort"
    set ib_unitNameGbk[231] = "���н�����"
    set ib_unitList[232] = 'ncbf'
    set ib_unitName[232] = "城市建筑物"
    set ib_unitArmor[232] = "fort"
    set ib_unitNameGbk[232] = "���н�����"
    set ib_unitList[233] = 'ncea'
    set ib_unitName[233] = "半人马弓箭手"
    set ib_unitArmor[233] = "large"
    set ib_unitNameGbk[233] = "������������"
    set ib_unitList[234] = 'ncen'
    set ib_unitName[234] = "半人马先行者"
    set ib_unitArmor[234] = "large"
    set ib_unitNameGbk[234] = "������������"
    set ib_unitList[235] = 'ncer'
    set ib_unitName[235] = "半人马苦工"
    set ib_unitArmor[235] = "large"
    set ib_unitNameGbk[235] = "�������๤"
    set ib_unitList[236] = 'ncfs'
    set ib_unitName[236] = "水奴"
    set ib_unitArmor[236] = "large"
    set ib_unitNameGbk[236] = "ˮū"
    set ib_unitList[237] = 'ncg1'
    set ib_unitName[237] = "人工地精"
    set ib_unitArmor[237] = "large"
    set ib_unitNameGbk[237] = "�˹��ؾ�"
    set ib_unitList[238] = 'ncg2'
    set ib_unitName[238] = "人工地精"
    set ib_unitArmor[238] = "large"
    set ib_unitNameGbk[238] = "�˹��ؾ�"
    set ib_unitList[239] = 'ncg3'
    set ib_unitName[239] = "人工地精"
    set ib_unitArmor[239] = "large"
    set ib_unitNameGbk[239] = "�˹��ؾ�"
endfunction
function IB_UnitFill3 takes nothing returns nothing
    set ib_unitList[240] = 'ncgb'
    set ib_unitName[240] = "人工地精"
    set ib_unitArmor[240] = "large"
    set ib_unitNameGbk[240] = "�˹��ؾ�"
    set ib_unitList[241] = 'nchg'
    set ib_unitName[241] = "邪恶的兽族步兵"
    set ib_unitArmor[241] = "large"
    set ib_unitNameGbk[241] = "а������岽��"
    set ib_unitList[242] = 'nchp'
    set ib_unitName[242] = "牧师"
    set ib_unitArmor[242] = "none"
    set ib_unitNameGbk[242] = "��ʦ"
    set ib_unitList[243] = 'nchr'
    set ib_unitName[243] = "邪恶的掠夺者"
    set ib_unitArmor[243] = "small"
    set ib_unitNameGbk[243] = "а����Ӷ���"
    set ib_unitList[244] = 'nchw'
    set ib_unitName[244] = "邪恶的巫师"
    set ib_unitArmor[244] = "medium"
    set ib_unitNameGbk[244] = "а�����ʦ"
    set ib_unitList[245] = 'ncim'
    set ib_unitName[245] = "半人马刺客"
    set ib_unitArmor[245] = "large"
    set ib_unitNameGbk[245] = "�������̿�"
    set ib_unitList[246] = 'nckb'
    set ib_unitName[246] = "邪恶的科多兽"
    set ib_unitArmor[246] = "small"
    set ib_unitNameGbk[246] = "а��Ŀƶ���"
    set ib_unitList[247] = 'ncks'
    set ib_unitName[247] = "半人马巫师"
    set ib_unitArmor[247] = "large"
    set ib_unitNameGbk[247] = "��������ʦ"
    set ib_unitList[248] = 'ncmw'
    set ib_unitName[248] = "月亮井"
    set ib_unitArmor[248] = "fort"
    set ib_unitNameGbk[248] = "������"
    set ib_unitList[249] = 'ncnk'
    set ib_unitName[249] = "半人马可汗"
    set ib_unitArmor[249] = "large"
    set ib_unitNameGbk[249] = "�������ɺ�"
    set ib_unitList[250] = 'ncnt'
    set ib_unitName[250] = "半人马帐篷"
    set ib_unitArmor[250] = "fort"
    set ib_unitNameGbk[250] = "����������"
    set ib_unitList[251] = 'ncop'
    set ib_unitName[251] = "能量圈"
    set ib_unitArmor[251] = "fort"
    set ib_unitNameGbk[251] = "����Ȧ"
    set ib_unitList[252] = 'ncp2'
    set ib_unitName[252] = "能量圈"
    set ib_unitArmor[252] = "fort"
    set ib_unitNameGbk[252] = "����Ȧ"
    set ib_unitList[253] = 'ncp3'
    set ib_unitName[253] = "能量圈"
    set ib_unitArmor[253] = "fort"
    set ib_unitNameGbk[253] = "����Ȧ"
    set ib_unitList[254] = 'ncpn'
    set ib_unitName[254] = "邪恶的苦工"
    set ib_unitArmor[254] = "large"
    set ib_unitNameGbk[254] = "а��Ŀ๤"
    set ib_unitList[255] = 'ncrb'
    set ib_unitName[255] = "螃蟹"
    set ib_unitArmor[255] = "medium"
    set ib_unitNameGbk[255] = "�з"
    set ib_unitList[256] = 'nct1'
    set ib_unitName[256] = "半人马帐篷"
    set ib_unitArmor[256] = "fort"
    set ib_unitNameGbk[256] = "����������"
    set ib_unitList[257] = 'nct2'
    set ib_unitName[257] = "半人马帐篷"
    set ib_unitArmor[257] = "fort"
    set ib_unitNameGbk[257] = "����������"
    set ib_unitList[258] = 'ncta'
    set ib_unitName[258] = "远古之树"
    set ib_unitArmor[258] = "fort"
    set ib_unitNameGbk[258] = "Զ��֮��"
    set ib_unitList[259] = 'ncte'
    set ib_unitName[259] = "永恒之树"
    set ib_unitArmor[259] = "fort"
    set ib_unitNameGbk[259] = "����֮��"
    set ib_unitList[260] = 'nctl'
    set ib_unitName[260] = "生命之树"
    set ib_unitArmor[260] = "fort"
    set ib_unitNameGbk[260] = "����֮��"
    set ib_unitList[261] = 'ndch'
    set ib_unitName[261] = "达拉内尔酋长之屋"
    set ib_unitArmor[261] = "fort"
    set ib_unitNameGbk[261] = "�����ڶ�����֮��"
    set ib_unitList[262] = 'nder'
    set ib_unitName[262] = "雄鹿"
    set ib_unitArmor[262] = "medium"
    set ib_unitNameGbk[262] = "��¹"
    set ib_unitList[263] = 'ndfl'
    set ib_unitName[263] = "被污染的生命之泉"
    set ib_unitArmor[263] = "fort"
    set ib_unitNameGbk[263] = "����Ⱦ������֮Ȫ"
    set ib_unitList[264] = 'ndgt'
    set ib_unitName[264] = "达拉然守卫塔"
    set ib_unitArmor[264] = "fort"
    set ib_unitNameGbk[264] = "����Ȼ������"
    set ib_unitList[265] = 'ndh0'
    set ib_unitName[265] = "达拉内尔小屋"
    set ib_unitArmor[265] = "fort"
    set ib_unitNameGbk[265] = "�����ڶ�С��"
    set ib_unitList[266] = 'ndh1'
    set ib_unitName[266] = "达拉内尔小屋"
    set ib_unitArmor[266] = "fort"
    set ib_unitNameGbk[266] = "�����ڶ�С��"
    set ib_unitList[267] = 'ndh2'
    set ib_unitName[267] = "达拉内尔港口"
    set ib_unitArmor[267] = "fort"
    set ib_unitNameGbk[267] = "�����ڶ��ۿ�"
    set ib_unitList[268] = 'ndh3'
    set ib_unitName[268] = "达拉内尔兵营"
    set ib_unitArmor[268] = "fort"
    set ib_unitNameGbk[268] = "�����ڶ���Ӫ"
    set ib_unitList[269] = 'ndh4'
    set ib_unitName[269] = "先知洞穴"
    set ib_unitArmor[269] = "fort"
    set ib_unitNameGbk[269] = "��֪��Ѩ"
    set ib_unitList[270] = 'ndke'
    set ib_unitName[270] = "异次元大门"
    set ib_unitArmor[270] = "fort"
    set ib_unitNameGbk[270] = "���Ԫ����"
    set ib_unitList[271] = 'ndkw'
    set ib_unitName[271] = "异次元大门"
    set ib_unitArmor[271] = "fort"
    set ib_unitNameGbk[271] = "���Ԫ����"
    set ib_unitList[272] = 'ndmg'
    set ib_unitName[272] = "恶魔之门"
    set ib_unitArmor[272] = "fort"
    set ib_unitNameGbk[272] = "��ħ֮��"
    set ib_unitList[273] = 'ndmu'
    set ib_unitName[273] = "达拉然之变种怪物"
    set ib_unitArmor[273] = "large"
    set ib_unitNameGbk[273] = "����Ȼ֮���ֹ���"
    set ib_unitList[274] = 'ndog'
    set ib_unitName[274] = "野狗"
    set ib_unitArmor[274] = "medium"
    set ib_unitNameGbk[274] = "Ұ��"
    set ib_unitList[275] = 'ndqn'
    set ib_unitName[275] = "女妖精"
    set ib_unitArmor[275] = "large"
    set ib_unitNameGbk[275] = "Ů����"
    set ib_unitList[276] = 'ndqp'
    set ib_unitName[276] = "痛苦少女"
    set ib_unitArmor[276] = "large"
    set ib_unitNameGbk[276] = "ʹ����Ů"
    set ib_unitList[277] = 'ndqs'
    set ib_unitName[277] = "苦难女王"
    set ib_unitArmor[277] = "large"
    set ib_unitNameGbk[277] = "����Ů��"
    set ib_unitList[278] = 'ndqt'
    set ib_unitName[278] = "恶妇"
    set ib_unitArmor[278] = "large"
    set ib_unitNameGbk[278] = "��"
    set ib_unitList[279] = 'ndqv'
    set ib_unitName[279] = "恶男"
    set ib_unitArmor[279] = "medium"
    set ib_unitNameGbk[279] = "����"
    set ib_unitList[280] = 'ndr1'
    set ib_unitName[280] = "小黑暗之奴"
    set ib_unitArmor[280] = "large"
    set ib_unitNameGbk[280] = "С�ڰ�֮ū"
    set ib_unitList[281] = 'ndr2'
    set ib_unitName[281] = "黑暗之奴"
    set ib_unitArmor[281] = "large"
    set ib_unitNameGbk[281] = "�ڰ�֮ū"
    set ib_unitList[282] = 'ndr3'
    set ib_unitName[282] = "大黑暗之奴"
    set ib_unitArmor[282] = "large"
    set ib_unitNameGbk[282] = "��ڰ�֮ū"
    set ib_unitList[283] = 'ndrb'
    set ib_unitName[283] = "龙之栖木"
    set ib_unitArmor[283] = "fort"
    set ib_unitNameGbk[283] = "��֮��ľ"
    set ib_unitList[284] = 'ndrd'
    set ib_unitName[284] = "达拉内尔暗黑屠杀者"
    set ib_unitArmor[284] = "large"
    set ib_unitNameGbk[284] = "�����ڶ�������ɱ��"
    set ib_unitList[285] = 'ndrf'
    set ib_unitName[285] = "达拉内尔守卫"
    set ib_unitArmor[285] = "large"
    set ib_unitNameGbk[285] = "�����ڶ�����"
    set ib_unitList[286] = 'ndrg'
    set ib_unitName[286] = "绿龙巢穴"
    set ib_unitArmor[286] = "fort"
    set ib_unitNameGbk[286] = "������Ѩ"
    set ib_unitList[287] = 'ndrh'
    set ib_unitName[287] = "达拉内尔先驱"
    set ib_unitArmor[287] = "medium"
    set ib_unitNameGbk[287] = "�����ڶ�����"
    set ib_unitList[288] = 'ndrj'
    set ib_unitName[288] = "达拉然之孤胆怪物"
    set ib_unitArmor[288] = "medium"
    set ib_unitNameGbk[288] = "����Ȼ֮�µ�����"
    set ib_unitList[289] = 'ndrk'
    set ib_unitName[289] = "黑龙巢穴"
    set ib_unitArmor[289] = "fort"
    set ib_unitNameGbk[289] = "������Ѩ"
    set ib_unitList[290] = 'ndrl'
    set ib_unitName[290] = "达拉内尔工人"
    set ib_unitArmor[290] = "medium"
    set ib_unitNameGbk[290] = "�����ڶ�����"
    set ib_unitList[291] = 'ndrm'
    set ib_unitName[291] = "达拉内尔信徒"
    set ib_unitArmor[291] = "medium"
    set ib_unitNameGbk[291] = "�����ڶ���ͽ"
    set ib_unitList[292] = 'ndrn'
    set ib_unitName[292] = "达拉内尔辩护者"
    set ib_unitArmor[292] = "large"
    set ib_unitNameGbk[292] = "�����ڶ��绤��"
    set ib_unitList[293] = 'ndro'
    set ib_unitName[293] = "耐瑟龙栖木"
    set ib_unitArmor[293] = "fort"
    set ib_unitNameGbk[293] = "��ɪ����ľ"
    set ib_unitList[294] = 'ndrp'
    set ib_unitName[294] = "达拉内尔护卫"
    set ib_unitArmor[294] = "large"
    set ib_unitNameGbk[294] = "�����ڶ�����"
    set ib_unitList[295] = 'ndrr'
    set ib_unitName[295] = "红龙巢穴"
    set ib_unitArmor[295] = "fort"
    set ib_unitNameGbk[295] = "������Ѩ"
    set ib_unitList[296] = 'ndrs'
    set ib_unitName[296] = "达拉内尔先知"
    set ib_unitArmor[296] = "large"
    set ib_unitNameGbk[296] = "�����ڶ���֪"
    set ib_unitList[297] = 'ndrt'
    set ib_unitName[297] = "达拉内尔漫步者"
    set ib_unitArmor[297] = "large"
    set ib_unitNameGbk[297] = "�����ڶ�������"
    set ib_unitList[298] = 'ndru'
    set ib_unitName[298] = "蓝龙巢穴"
    set ib_unitArmor[298] = "fort"
    set ib_unitNameGbk[298] = "������Ѩ"
    set ib_unitList[299] = 'ndrv'
    set ib_unitName[299] = "深渊幽灵"
    set ib_unitArmor[299] = "large"
    set ib_unitNameGbk[299] = "��Ԩ����"
    set ib_unitList[300] = 'ndrw'
    set ib_unitName[300] = "达拉内尔哨兵"
    set ib_unitArmor[300] = "large"
    set ib_unitNameGbk[300] = "�����ڶ��ڱ�"
    set ib_unitList[301] = 'ndrz'
    set ib_unitName[301] = "青龙巢穴"
    set ib_unitArmor[301] = "fort"
    set ib_unitNameGbk[301] = "������Ѩ"
    set ib_unitList[302] = 'ndsa'
    set ib_unitName[302] = "火蜥蜴"
    set ib_unitArmor[302] = "medium"
    set ib_unitNameGbk[302] = "������"
    set ib_unitList[303] = 'ndt1'
    set ib_unitName[303] = "冰霜之塔"
    set ib_unitArmor[303] = "fort"
    set ib_unitNameGbk[303] = "��˪֮��"
    set ib_unitList[304] = 'ndt2'
    set ib_unitName[304] = "高级冰霜之塔"
    set ib_unitArmor[304] = "fort"
    set ib_unitNameGbk[304] = "�߼���˪֮��"
    set ib_unitList[305] = 'ndtb'
    set ib_unitName[305] = "黑魔狂战士"
    set ib_unitArmor[305] = "medium"
    set ib_unitNameGbk[305] = "��ħ��սʿ"
    set ib_unitList[306] = 'ndth'
    set ib_unitName[306] = "黑魔高级牧师"
    set ib_unitArmor[306] = "medium"
    set ib_unitNameGbk[306] = "��ħ�߼���ʦ"
    set ib_unitList[307] = 'ndtp'
    set ib_unitName[307] = "黑魔影子牧师"
    set ib_unitArmor[307] = "large"
    set ib_unitNameGbk[307] = "��ħӰ����ʦ"
    set ib_unitList[308] = 'ndtr'
    set ib_unitName[308] = "黑暗巨魔"
    set ib_unitArmor[308] = "large"
    set ib_unitNameGbk[308] = "�ڰ���ħ"
    set ib_unitList[309] = 'ndtt'
    set ib_unitName[309] = "黑魔猎手"
    set ib_unitArmor[309] = "medium"
    set ib_unitNameGbk[309] = "��ħ����"
    set ib_unitList[310] = 'ndtw'
    set ib_unitName[310] = "黑魔首领"
    set ib_unitArmor[310] = "large"
    set ib_unitNameGbk[310] = "��ħ����"
    set ib_unitList[311] = 'ndwm'
    set ib_unitName[311] = "沙丘之虫"
    set ib_unitArmor[311] = "medium"
    set ib_unitNameGbk[311] = "ɳ��֮��"
    set ib_unitList[312] = 'nech'
    set ib_unitName[312] = "小鸡"
    set ib_unitArmor[312] = "medium"
    set ib_unitNameGbk[312] = "С��"
    set ib_unitList[313] = 'necr'
    set ib_unitName[313] = "兔子"
    set ib_unitArmor[313] = "medium"
    set ib_unitNameGbk[313] = "����"
    set ib_unitList[314] = 'nef0'
    set ib_unitName[314] = "高等精灵农场"
    set ib_unitArmor[314] = "fort"
    set ib_unitNameGbk[314] = "�ߵȾ���ũ��"
    set ib_unitList[315] = 'nef1'
    set ib_unitName[315] = "高等精灵农场"
    set ib_unitArmor[315] = "fort"
    set ib_unitNameGbk[315] = "�ߵȾ���ũ��"
    set ib_unitList[316] = 'nef2'
    set ib_unitName[316] = "高等精灵农场"
    set ib_unitArmor[316] = "fort"
    set ib_unitNameGbk[316] = "�ߵȾ���ũ��"
    set ib_unitList[317] = 'nef3'
    set ib_unitName[317] = "高等精灵农场"
    set ib_unitArmor[317] = "fort"
    set ib_unitNameGbk[317] = "�ߵȾ���ũ��"
    set ib_unitList[318] = 'nef4'
    set ib_unitName[318] = "高等精灵农场"
    set ib_unitArmor[318] = "fort"
    set ib_unitNameGbk[318] = "�ߵȾ���ũ��"
    set ib_unitList[319] = 'nef5'
    set ib_unitName[319] = "高等精灵农场"
    set ib_unitArmor[319] = "fort"
    set ib_unitNameGbk[319] = "�ߵȾ���ũ��"
endfunction
function IB_UnitFill4 takes nothing returns nothing
    set ib_unitList[320] = 'nef6'
    set ib_unitName[320] = "高等精灵农场"
    set ib_unitArmor[320] = "fort"
    set ib_unitNameGbk[320] = "�ߵȾ���ũ��"
    set ib_unitList[321] = 'nef7'
    set ib_unitName[321] = "高等精灵农场"
    set ib_unitArmor[321] = "fort"
    set ib_unitNameGbk[321] = "�ߵȾ���ũ��"
    set ib_unitList[322] = 'nefm'
    set ib_unitName[322] = "高等精灵农场"
    set ib_unitArmor[322] = "fort"
    set ib_unitNameGbk[322] = "�ߵȾ���ũ��"
    set ib_unitList[323] = 'negf'
    set ib_unitName[323] = "地怒之塔"
    set ib_unitArmor[323] = "fort"
    set ib_unitNameGbk[323] = "��ŭ֮��"
    set ib_unitList[324] = 'negm'
    set ib_unitName[324] = "天怒之塔"
    set ib_unitArmor[324] = "fort"
    set ib_unitNameGbk[324] = "��ŭ֮��"
    set ib_unitList[325] = 'negt'
    set ib_unitName[325] = "高等精灵防御塔"
    set ib_unitArmor[325] = "fort"
    set ib_unitNameGbk[325] = "�ߵȾ��������"
    set ib_unitList[326] = 'negz'
    set ib_unitName[326] = "工程师加兹劳"
    set ib_unitArmor[326] = "large"
    set ib_unitNameGbk[326] = "����ʦ������"
    set ib_unitList[327] = 'nehy'
    set ib_unitName[327] = "九头怪蛇长者"
    set ib_unitArmor[327] = "large"
    set ib_unitNameGbk[327] = "��ͷ���߳���"
    set ib_unitList[328] = 'nelb'
    set ib_unitName[328] = "狂暴元素"
    set ib_unitArmor[328] = "large"
    set ib_unitNameGbk[328] = "��Ԫ��"
    set ib_unitList[329] = 'nele'
    set ib_unitName[329] = "狂怒元素"
    set ib_unitArmor[329] = "large"
    set ib_unitNameGbk[329] = "��ŭԪ��"
    set ib_unitList[330] = 'nemi'
    set ib_unitName[330] = "使者"
    set ib_unitArmor[330] = "medium"
    set ib_unitNameGbk[330] = "ʹ��"
    set ib_unitList[331] = 'nenc'
    set ib_unitName[331] = "堕落树人"
    set ib_unitArmor[331] = "large"
    set ib_unitNameGbk[331] = "��������"
    set ib_unitList[332] = 'nenf'
    set ib_unitName[332] = "强制者"
    set ib_unitArmor[332] = "large"
    set ib_unitNameGbk[332] = "ǿ����"
    set ib_unitList[333] = 'nenp'
    set ib_unitName[333] = "毒性树人"
    set ib_unitArmor[333] = "large"
    set ib_unitNameGbk[333] = "��������"
    set ib_unitList[334] = 'nepl'
    set ib_unitName[334] = "灾祸树人"
    set ib_unitArmor[334] = "large"
    set ib_unitNameGbk[334] = "�ֻ�����"
    set ib_unitList[335] = 'nerd'
    set ib_unitName[335] = "埃瑞达-信魔者"
    set ib_unitArmor[335] = "large"
    set ib_unitNameGbk[335] = "�����-��ħ��"
    set ib_unitList[336] = 'ners'
    set ib_unitName[336] = "埃瑞达男巫"
    set ib_unitArmor[336] = "large"
    set ib_unitNameGbk[336] = "���������"
    set ib_unitList[337] = 'nerw'
    set ib_unitName[337] = "埃瑞达法师"
    set ib_unitArmor[337] = "large"
    set ib_unitNameGbk[337] = "����﷨ʦ"
    set ib_unitList[338] = 'net1'
    set ib_unitName[338] = "能量之塔"
    set ib_unitArmor[338] = "fort"
    set ib_unitNameGbk[338] = "����֮��"
    set ib_unitList[339] = 'net2'
    set ib_unitName[339] = "高级能量之塔"
    set ib_unitArmor[339] = "fort"
    set ib_unitNameGbk[339] = "�߼�����֮��"
    set ib_unitList[340] = 'nfa1'
    set ib_unitName[340] = "口袋工厂"
    set ib_unitArmor[340] = "medium"
    set ib_unitNameGbk[340] = "�ڴ�����"
    set ib_unitList[341] = 'nfa2'
    set ib_unitName[341] = "口袋工厂"
    set ib_unitArmor[341] = "medium"
    set ib_unitNameGbk[341] = "�ڴ�����"
    set ib_unitList[342] = 'nfac'
    set ib_unitName[342] = "口袋工厂"
    set ib_unitArmor[342] = "medium"
    set ib_unitNameGbk[342] = "�ڴ�����"
    set ib_unitList[343] = 'nfbr'
    set ib_unitName[343] = "野猪"
    set ib_unitArmor[343] = "medium"
    set ib_unitNameGbk[343] = "Ұ��"
    set ib_unitList[344] = 'nfel'
    set ib_unitName[344] = "邪恶漫步者"
    set ib_unitArmor[344] = "large"
    set ib_unitNameGbk[344] = "а��������"
    set ib_unitList[345] = 'nfgb'
    set ib_unitName[345] = "血恶魔"
    set ib_unitArmor[345] = "large"
    set ib_unitNameGbk[345] = "Ѫ��ħ"
    set ib_unitList[346] = 'nfgl'
    set ib_unitName[346] = "灵肉傀儡"
    set ib_unitArmor[346] = "medium"
    set ib_unitNameGbk[346] = "�������"
    set ib_unitList[347] = 'nfgo'
    set ib_unitName[347] = "遗忘者"
    set ib_unitArmor[347] = "large"
    set ib_unitNameGbk[347] = "������"
    set ib_unitList[348] = 'nfgt'
    set ib_unitName[348] = "触须"
    set ib_unitArmor[348] = "large"
    set ib_unitNameGbk[348] = "����"
    set ib_unitList[349] = 'nfgu'
    set ib_unitName[349] = "狂暴守卫"
    set ib_unitArmor[349] = "large"
    set ib_unitNameGbk[349] = "������"
    set ib_unitList[350] = 'nfh0'
    set ib_unitName[350] = "森林巨魔小屋"
    set ib_unitArmor[350] = "fort"
    set ib_unitNameGbk[350] = "ɭ�־�ħС��"
    set ib_unitList[351] = 'nfh1'
    set ib_unitName[351] = "森林巨魔小屋"
    set ib_unitArmor[351] = "fort"
    set ib_unitNameGbk[351] = "ɭ�־�ħС��"
    set ib_unitList[352] = 'nfnp'
    set ib_unitName[352] = "威力之泉"
    set ib_unitArmor[352] = "fort"
    set ib_unitNameGbk[352] = "����֮Ȫ"
    set ib_unitList[353] = 'nfod'
    set ib_unitName[353] = "无名死灵"
    set ib_unitArmor[353] = "large"
    set ib_unitNameGbk[353] = "��������"
    set ib_unitList[354] = 'nfoh'
    set ib_unitName[354] = "生命之泉"
    set ib_unitArmor[354] = "fort"
    set ib_unitNameGbk[354] = "����֮Ȫ"
    set ib_unitList[355] = 'nfor'
    set ib_unitName[355] = "无名骗士"
    set ib_unitArmor[355] = "large"
    set ib_unitNameGbk[355] = "����ƭʿ"
    set ib_unitList[356] = 'nfot'
    set ib_unitName[356] = "无名恐怖者"
    set ib_unitArmor[356] = "large"
    set ib_unitNameGbk[356] = "�����ֲ���"
    set ib_unitList[357] = 'nfov'
    set ib_unitName[357] = "领主"
    set ib_unitArmor[357] = "large"
    set ib_unitNameGbk[357] = "����"
    set ib_unitList[358] = 'nfpc'
    set ib_unitName[358] = "北极熊怪战士"
    set ib_unitArmor[358] = "large"
    set ib_unitNameGbk[358] = "�����ܹ�սʿ"
    set ib_unitList[359] = 'nfpe'
    set ib_unitName[359] = "北极熊怪萨满长者"
    set ib_unitArmor[359] = "large"
    set ib_unitNameGbk[359] = "�����ܹ���������"
    set ib_unitList[360] = 'nfpl'
    set ib_unitName[360] = "北极熊怪"
    set ib_unitArmor[360] = "large"
    set ib_unitNameGbk[360] = "�����ܹ�"
    set ib_unitList[361] = 'nfps'
    set ib_unitName[361] = "北极熊怪萨满"
    set ib_unitArmor[361] = "medium"
    set ib_unitNameGbk[361] = "�����ܹ�����"
    set ib_unitList[362] = 'nfpt'
    set ib_unitName[362] = "北极熊怪追踪者"
    set ib_unitArmor[362] = "large"
    set ib_unitNameGbk[362] = "�����ܹ�׷����"
    set ib_unitList[363] = 'nfpu'
    set ib_unitName[363] = "北极熊怪乌萨战士"
    set ib_unitArmor[363] = "large"
    set ib_unitNameGbk[363] = "�����ܹ�����սʿ"
    set ib_unitList[364] = 'nfr1'
    set ib_unitName[364] = "熊怪小屋"
    set ib_unitArmor[364] = "fort"
    set ib_unitNameGbk[364] = "�ܹ�С��"
    set ib_unitList[365] = 'nfr2'
    set ib_unitName[365] = "熊怪小屋"
    set ib_unitArmor[365] = "fort"
    set ib_unitNameGbk[365] = "�ܹ�С��"
    set ib_unitList[366] = 'nfra'
    set ib_unitName[366] = "熊怪乌萨战士"
    set ib_unitArmor[366] = "large"
    set ib_unitNameGbk[366] = "�ܹ�����սʿ"
    set ib_unitList[367] = 'nfrb'
    set ib_unitName[367] = "熊怪追踪者"
    set ib_unitArmor[367] = "large"
    set ib_unitNameGbk[367] = "�ܹ�׷����"
    set ib_unitList[368] = 'nfre'
    set ib_unitName[368] = "熊怪萨满长者"
    set ib_unitArmor[368] = "large"
    set ib_unitNameGbk[368] = "�ܹ���������"
    set ib_unitList[369] = 'nfrg'
    set ib_unitName[369] = "熊怪战士"
    set ib_unitArmor[369] = "large"
    set ib_unitNameGbk[369] = "�ܹ�սʿ"
    set ib_unitList[370] = 'nfrl'
    set ib_unitName[370] = "熊怪"
    set ib_unitArmor[370] = "large"
    set ib_unitNameGbk[370] = "�ܹ�"
    set ib_unitList[371] = 'nfrm'
    set ib_unitName[371] = "霜之哀伤底座"
    set ib_unitArmor[371] = "fort"
    set ib_unitNameGbk[371] = "˪֮���˵���"
    set ib_unitList[372] = 'nfro'
    set ib_unitName[372] = "青蛙"
    set ib_unitArmor[372] = "medium"
    set ib_unitNameGbk[372] = "����"
    set ib_unitList[373] = 'nfrp'
    set ib_unitName[373] = "熊猫"
    set ib_unitArmor[373] = "large"
    set ib_unitNameGbk[373] = "��è"
    set ib_unitList[374] = 'nfrs'
    set ib_unitName[374] = "熊怪萨满"
    set ib_unitArmor[374] = "medium"
    set ib_unitNameGbk[374] = "�ܹ�����"
    set ib_unitList[375] = 'nfrt'
    set ib_unitName[375] = "水果店"
    set ib_unitArmor[375] = "fort"
    set ib_unitNameGbk[375] = "ˮ����"
    set ib_unitList[376] = 'nfsh'
    set ib_unitName[376] = "树魔高级牧师"
    set ib_unitArmor[376] = "medium"
    set ib_unitNameGbk[376] = "��ħ�߼���ʦ"
    set ib_unitList[377] = 'nfsp'
    set ib_unitName[377] = "树魔影子牧师"
    set ib_unitArmor[377] = "large"
    set ib_unitNameGbk[377] = "��ħӰ����ʦ"
    set ib_unitList[378] = 'nft1'
    set ib_unitName[378] = "火焰之塔"
    set ib_unitArmor[378] = "fort"
    set ib_unitNameGbk[378] = "����֮��"
    set ib_unitList[379] = 'nft2'
    set ib_unitName[379] = "高级火焰之塔"
    set ib_unitArmor[379] = "fort"
    set ib_unitNameGbk[379] = "�߼�����֮��"
    set ib_unitList[380] = 'nftb'
    set ib_unitName[380] = "树魔狂战士"
    set ib_unitArmor[380] = "medium"
    set ib_unitNameGbk[380] = "��ħ��սʿ"
    set ib_unitList[381] = 'nftk'
    set ib_unitName[381] = "树魔首领"
    set ib_unitArmor[381] = "large"
    set ib_unitNameGbk[381] = "��ħ����"
    set ib_unitList[382] = 'nftr'
    set ib_unitName[382] = "森林巨魔"
    set ib_unitArmor[382] = "large"
    set ib_unitNameGbk[382] = "ɭ�־�ħ"
    set ib_unitList[383] = 'nftt'
    set ib_unitName[383] = "树魔猎手"
    set ib_unitArmor[383] = "medium"
    set ib_unitNameGbk[383] = "��ħ����"
    set ib_unitList[384] = 'nfv0'
    set ib_unitName[384] = "暗夜精灵族渔村"
    set ib_unitArmor[384] = "fort"
    set ib_unitNameGbk[384] = "��ҹ���������"
    set ib_unitList[385] = 'nfv1'
    set ib_unitName[385] = "暗夜精灵族渔村"
    set ib_unitArmor[385] = "fort"
    set ib_unitNameGbk[385] = "��ҹ���������"
    set ib_unitList[386] = 'nfv2'
    set ib_unitName[386] = "暗夜精灵族渔村"
    set ib_unitArmor[386] = "fort"
    set ib_unitNameGbk[386] = "��ҹ���������"
    set ib_unitList[387] = 'nfv3'
    set ib_unitName[387] = "暗夜精灵族渔村"
    set ib_unitArmor[387] = "fort"
    set ib_unitNameGbk[387] = "��ҹ���������"
    set ib_unitList[388] = 'nfv4'
    set ib_unitName[388] = "暗夜精灵族渔村"
    set ib_unitArmor[388] = "fort"
    set ib_unitNameGbk[388] = "��ҹ���������"
    set ib_unitList[389] = 'ngad'
    set ib_unitName[389] = "地精实验室"
    set ib_unitArmor[389] = "fort"
    set ib_unitNameGbk[389] = "�ؾ�ʵ����"
    set ib_unitList[390] = 'ngbl'
    set ib_unitName[390] = "地精爆破工"
    set ib_unitArmor[390] = "large"
    set ib_unitNameGbk[390] = "�ؾ����ƹ�"
    set ib_unitList[391] = 'ngdk'
    set ib_unitName[391] = "绿蜉蝣"
    set ib_unitArmor[391] = "large"
    set ib_unitNameGbk[391] = "������"
    set ib_unitList[392] = 'nggr'
    set ib_unitName[392] = "花岗岩傀儡"
    set ib_unitArmor[392] = "large"
    set ib_unitNameGbk[392] = "�����ҿ���"
    set ib_unitList[393] = 'ngh1'
    set ib_unitName[393] = "幽灵"
    set ib_unitArmor[393] = "medium"
    set ib_unitNameGbk[393] = "����"
    set ib_unitList[394] = 'ngh2'
    set ib_unitName[394] = "幽魂"
    set ib_unitArmor[394] = "large"
    set ib_unitNameGbk[394] = "�Ļ�"
    set ib_unitList[395] = 'ngir'
    set ib_unitName[395] = "地精撕裂者"
    set ib_unitArmor[395] = "large"
    set ib_unitNameGbk[395] = "�ؾ�˺����"
    set ib_unitList[396] = 'nglm'
    set ib_unitName[396] = "地精地雷"
    set ib_unitArmor[396] = "medium"
    set ib_unitNameGbk[396] = "�ؾ�����"
    set ib_unitList[397] = 'ngme'
    set ib_unitName[397] = "地精商店"
    set ib_unitArmor[397] = "fort"
    set ib_unitNameGbk[397] = "�ؾ��̵�"
    set ib_unitList[398] = 'ngna'
    set ib_unitName[398] = "豺狼偷猎者"
    set ib_unitArmor[398] = "large"
    set ib_unitNameGbk[398] = "����͵����"
    set ib_unitList[399] = 'ngnb'
    set ib_unitName[399] = "豺狼野兽"
    set ib_unitArmor[399] = "large"
    set ib_unitNameGbk[399] = "����Ұ��"
endfunction
function IB_UnitFill5 takes nothing returns nothing
    set ib_unitList[400] = 'ngnh'
    set ib_unitName[400] = "豺狼人小屋"
    set ib_unitArmor[400] = "fort"
    set ib_unitNameGbk[400] = "������С��"
    set ib_unitList[401] = 'ngni'
    set ib_unitName[401] = "腐烂谷仓"
    set ib_unitArmor[401] = "fort"
    set ib_unitNameGbk[401] = "���ùȲ�"
    set ib_unitList[402] = 'ngno'
    set ib_unitName[402] = "豺狼"
    set ib_unitArmor[402] = "large"
    set ib_unitNameGbk[402] = "����"
    set ib_unitList[403] = 'ngns'
    set ib_unitName[403] = "豺狼刺客"
    set ib_unitArmor[403] = "medium"
    set ib_unitNameGbk[403] = "���Ǵ̿�"
    set ib_unitList[404] = 'ngnv'
    set ib_unitName[404] = "豺狼首领"
    set ib_unitArmor[404] = "large"
    set ib_unitNameGbk[404] = "��������"
    set ib_unitList[405] = 'ngnw'
    set ib_unitName[405] = "豺狼守望者"
    set ib_unitArmor[405] = "medium"
    set ib_unitNameGbk[405] = "����������"
    set ib_unitList[406] = 'ngob'
    set ib_unitName[406] = "魔法宝石塔"
    set ib_unitArmor[406] = "fort"
    set ib_unitNameGbk[406] = "ħ����ʯ��"
    set ib_unitList[407] = 'ngol'
    set ib_unitName[407] = "金矿"
    set ib_unitArmor[407] = "fort"
    set ib_unitNameGbk[407] = "���"
    set ib_unitList[408] = 'ngrd'
    set ib_unitName[408] = "绿龙"
    set ib_unitArmor[408] = "large"
    set ib_unitNameGbk[408] = "����"
    set ib_unitList[409] = 'ngrk'
    set ib_unitName[409] = "泥潭傀儡"
    set ib_unitArmor[409] = "medium"
    set ib_unitNameGbk[409] = "��̶����"
    set ib_unitList[410] = 'ngrw'
    set ib_unitName[410] = "绿幼龙"
    set ib_unitArmor[410] = "small"
    set ib_unitNameGbk[410] = "������"
    set ib_unitList[411] = 'ngsp'
    set ib_unitName[411] = "地精工兵"
    set ib_unitArmor[411] = "large"
    set ib_unitNameGbk[411] = "�ؾ�����"
    set ib_unitList[412] = 'ngst'
    set ib_unitName[412] = "岩石傀儡"
    set ib_unitArmor[412] = "large"
    set ib_unitNameGbk[412] = "��ʯ����"
    set ib_unitList[413] = 'ngt2'
    set ib_unitName[413] = "豺狼人小屋"
    set ib_unitArmor[413] = "fort"
    set ib_unitNameGbk[413] = "������С��"
    set ib_unitList[414] = 'ngwr'
    set ib_unitName[414] = "谷仓"
    set ib_unitArmor[414] = "fort"
    set ib_unitNameGbk[414] = "�Ȳ�"
    set ib_unitList[415] = 'ngz1'
    set ib_unitName[415] = "熊"
    set ib_unitArmor[415] = "large"
    set ib_unitNameGbk[415] = "��"
    set ib_unitList[416] = 'ngz2'
    set ib_unitName[416] = "怒熊"
    set ib_unitArmor[416] = "large"
    set ib_unitNameGbk[416] = "ŭ��"
    set ib_unitList[417] = 'ngz3'
    set ib_unitName[417] = "灵魂之熊"
    set ib_unitArmor[417] = "large"
    set ib_unitNameGbk[417] = "���֮��"
    set ib_unitList[418] = 'ngz4'
    set ib_unitName[418] = "米纱"
    set ib_unitArmor[418] = "large"
    set ib_unitNameGbk[418] = "��ɴ"
    set ib_unitList[419] = 'ngza'
    set ib_unitName[419] = "米纱"
    set ib_unitArmor[419] = "large"
    set ib_unitNameGbk[419] = "��ɴ"
    set ib_unitList[420] = 'ngzc'
    set ib_unitName[420] = "米纱"
    set ib_unitArmor[420] = "large"
    set ib_unitNameGbk[420] = "��ɴ"
    set ib_unitList[421] = 'ngzd'
    set ib_unitName[421] = "米纱"
    set ib_unitArmor[421] = "large"
    set ib_unitNameGbk[421] = "��ɴ"
    set ib_unitList[422] = 'nhar'
    set ib_unitName[422] = "女妖侦察者"
    set ib_unitArmor[422] = "large"
    set ib_unitNameGbk[422] = "Ů�������"
    set ib_unitList[423] = 'nhcn'
    set ib_unitName[423] = "半神赛纳留斯之角"
    set ib_unitArmor[423] = "fort"
    set ib_unitNameGbk[423] = "����������˹֮��"
    set ib_unitList[424] = 'nhdc'
    set ib_unitName[424] = "欺骗者"
    set ib_unitArmor[424] = "large"
    set ib_unitNameGbk[424] = "��ƭ��"
    set ib_unitList[425] = 'nhea'
    set ib_unitName[425] = "弓箭手"
    set ib_unitArmor[425] = "medium"
    set ib_unitNameGbk[425] = "������"
    set ib_unitList[426] = 'nheb'
    set ib_unitName[426] = "高等精灵兵营"
    set ib_unitArmor[426] = "fort"
    set ib_unitNameGbk[426] = "�ߵȾ����Ӫ"
    set ib_unitList[427] = 'nhef'
    set ib_unitName[427] = "高等精灵"
    set ib_unitArmor[427] = "medium"
    set ib_unitNameGbk[427] = "�ߵȾ���"
    set ib_unitList[428] = 'nhem'
    set ib_unitName[428] = "高等精灵"
    set ib_unitArmor[428] = "medium"
    set ib_unitNameGbk[428] = "�ߵȾ���"
    set ib_unitList[429] = 'nhew'
    set ib_unitName[429] = "工人"
    set ib_unitArmor[429] = "medium"
    set ib_unitNameGbk[429] = "����"
    set ib_unitList[430] = 'nhfp'
    set ib_unitName[430] = "堕落牧师"
    set ib_unitArmor[430] = "medium"
    set ib_unitNameGbk[430] = "������ʦ"
    set ib_unitList[431] = 'nhhr'
    set ib_unitName[431] = "异教徒"
    set ib_unitArmor[431] = "large"
    set ib_unitNameGbk[431] = "���ͽ"
    set ib_unitList[432] = 'nhmc'
    set ib_unitName[432] = "螃蟹隐士"
    set ib_unitArmor[432] = "medium"
    set ib_unitNameGbk[432] = "�з��ʿ"
    set ib_unitList[433] = 'nhns'
    set ib_unitName[433] = "女妖巢穴"
    set ib_unitArmor[433] = "fort"
    set ib_unitNameGbk[433] = "Ů����Ѩ"
    set ib_unitList[434] = 'nhrh'
    set ib_unitName[434] = "女妖风暴巫师"
    set ib_unitArmor[434] = "large"
    set ib_unitNameGbk[434] = "Ů���籩��ʦ"
    set ib_unitList[435] = 'nhrq'
    set ib_unitName[435] = "女妖女皇"
    set ib_unitArmor[435] = "large"
    set ib_unitNameGbk[435] = "Ů��Ů��"
    set ib_unitList[436] = 'nhrr'
    set ib_unitName[436] = "鹰身女妖流氓"
    set ib_unitArmor[436] = "large"
    set ib_unitNameGbk[436] = "ӥ��Ů����å"
    set ib_unitList[437] = 'nhrw'
    set ib_unitName[437] = "鹰身女妖巫婆"
    set ib_unitArmor[437] = "small"
    set ib_unitNameGbk[437] = "ӥ��Ů������"
    set ib_unitList[438] = 'nhyc'
    set ib_unitName[438] = "龙龟"
    set ib_unitArmor[438] = "large"
    set ib_unitNameGbk[438] = "����"
    set ib_unitList[439] = 'nhyd'
    set ib_unitName[439] = "九头怪蛇"
    set ib_unitArmor[439] = "large"
    set ib_unitNameGbk[439] = "��ͷ����"
    set ib_unitList[440] = 'nhyh'
    set ib_unitName[440] = "小九头怪蛇"
    set ib_unitArmor[440] = "medium"
    set ib_unitNameGbk[440] = "С��ͷ����"
    set ib_unitList[441] = 'nhym'
    set ib_unitName[441] = "术士"
    set ib_unitArmor[441] = "none"
    set ib_unitNameGbk[441] = "��ʿ"
    set ib_unitList[442] = 'nico'
    set ib_unitName[442] = "寒冰王座方尖塔"
    set ib_unitArmor[442] = "fort"
    set ib_unitNameGbk[442] = "��������������"
    set ib_unitList[443] = 'nina'
    set ib_unitName[443] = "地狱战舰"
    set ib_unitArmor[443] = "large"
    set ib_unitNameGbk[443] = "����ս��"
    set ib_unitList[444] = 'ninc'
    set ib_unitName[444] = "地狱火机关人"
    set ib_unitArmor[444] = "large"
    set ib_unitNameGbk[444] = "�����������"
    set ib_unitList[445] = 'ninf'
    set ib_unitName[445] = "地狱火"
    set ib_unitArmor[445] = "large"
    set ib_unitNameGbk[445] = "������"
    set ib_unitList[446] = 'ninm'
    set ib_unitName[446] = "地狱火机械人"
    set ib_unitArmor[446] = "large"
    set ib_unitNameGbk[446] = "�������е��"
    set ib_unitList[447] = 'nitb'
    set ib_unitName[447] = "冰之宝盒"
    set ib_unitArmor[447] = "fort"
    set ib_unitNameGbk[447] = "��֮����"
    set ib_unitList[448] = 'nith'
    set ib_unitName[448] = "冰魔高级牧师"
    set ib_unitArmor[448] = "medium"
    set ib_unitNameGbk[448] = "��ħ�߼���ʦ"
    set ib_unitList[449] = 'nitp'
    set ib_unitName[449] = "冰魔牧师"
    set ib_unitArmor[449] = "large"
    set ib_unitNameGbk[449] = "��ħ��ʦ"
    set ib_unitList[450] = 'nitr'
    set ib_unitName[450] = "冰之巨魔"
    set ib_unitArmor[450] = "large"
    set ib_unitNameGbk[450] = "��֮��ħ"
    set ib_unitList[451] = 'nits'
    set ib_unitName[451] = "冰魔狂战士"
    set ib_unitArmor[451] = "medium"
    set ib_unitNameGbk[451] = "��ħ��սʿ"
    set ib_unitList[452] = 'nitt'
    set ib_unitName[452] = "冰魔猎手"
    set ib_unitArmor[452] = "medium"
    set ib_unitNameGbk[452] = "��ħ����"
    set ib_unitList[453] = 'nitw'
    set ib_unitName[453] = "冰魔首领"
    set ib_unitArmor[453] = "large"
    set ib_unitNameGbk[453] = "��ħ����"
    set ib_unitList[454] = 'njg1'
    set ib_unitName[454] = "丛林漫步者"
    set ib_unitArmor[454] = "large"
    set ib_unitNameGbk[454] = "����������"
    set ib_unitList[455] = 'njga'
    set ib_unitName[455] = "丛林漫步者长老"
    set ib_unitArmor[455] = "large"
    set ib_unitNameGbk[455] = "���������߳���"
    set ib_unitList[456] = 'njgb'
    set ib_unitName[456] = "怒之丛林漫步者"
    set ib_unitArmor[456] = "large"
    set ib_unitNameGbk[456] = "ŭ֮����������"
    set ib_unitList[457] = 'njks'
    set ib_unitName[457] = "监狱小卒"
    set ib_unitArmor[457] = "large"
    set ib_unitNameGbk[457] = "����С��"
    set ib_unitList[458] = 'nkob'
    set ib_unitName[458] = "狗头人"
    set ib_unitArmor[458] = "large"
    set ib_unitNameGbk[458] = "��ͷ��"
    set ib_unitList[459] = 'nkog'
    set ib_unitName[459] = "狗头人占卜者"
    set ib_unitArmor[459] = "medium"
    set ib_unitNameGbk[459] = "��ͷ��ռ����"
    set ib_unitList[460] = 'nkol'
    set ib_unitName[460] = "狗头人首领"
    set ib_unitArmor[460] = "large"
    set ib_unitNameGbk[460] = "��ͷ������"
    set ib_unitList[461] = 'nkot'
    set ib_unitName[461] = "地穴狗头人"
    set ib_unitArmor[461] = "medium"
    set ib_unitNameGbk[461] = "��Ѩ��ͷ��"
    set ib_unitList[462] = 'nlds'
    set ib_unitName[462] = "马库拉先知"
    set ib_unitArmor[462] = "medium"
    set ib_unitNameGbk[462] = "��������֪"
    set ib_unitList[463] = 'nlkl'
    set ib_unitName[463] = "马库拉潮汐领主"
    set ib_unitArmor[463] = "large"
    set ib_unitNameGbk[463] = "��������ϫ����"
    set ib_unitList[464] = 'nlpd'
    set ib_unitName[464] = "马库拉池人"
    set ib_unitArmor[464] = "large"
    set ib_unitNameGbk[464] = "����������"
    set ib_unitList[465] = 'nlpr'
    set ib_unitName[465] = "巨虾"
    set ib_unitArmor[465] = "large"
    set ib_unitNameGbk[465] = "��Ϻ"
    set ib_unitList[466] = 'nlps'
    set ib_unitName[466] = "召唤出来的巨虾"
    set ib_unitArmor[466] = "large"
    set ib_unitNameGbk[466] = "�ٻ������ľ�Ϻ"
    set ib_unitList[467] = 'nlrv'
    set ib_unitName[467] = "深渊领主幽灵"
    set ib_unitArmor[467] = "large"
    set ib_unitNameGbk[467] = "��Ԩ��������"
    set ib_unitList[468] = 'nlsn'
    set ib_unitName[468] = "马库拉甲鱼"
    set ib_unitArmor[468] = "large"
    set ib_unitNameGbk[468] = "����������"
    set ib_unitList[469] = 'nltc'
    set ib_unitName[469] = "马库拉潮汐召唤者"
    set ib_unitArmor[469] = "medium"
    set ib_unitNameGbk[469] = "��������ϫ�ٻ���"
    set ib_unitList[470] = 'nltl'
    set ib_unitName[470] = "闪电蜥蜴"
    set ib_unitArmor[470] = "large"
    set ib_unitNameGbk[470] = "��������"
    set ib_unitList[471] = 'nlur'
    set ib_unitName[471] = "怪兽诱捕守卫"
    set ib_unitArmor[471] = "medium"
    set ib_unitNameGbk[471] = "�����ղ�����"
    set ib_unitList[472] = 'nlv1'
    set ib_unitName[472] = "炎魔"
    set ib_unitArmor[472] = "large"
    set ib_unitNameGbk[472] = "��ħ"
    set ib_unitList[473] = 'nlv2'
    set ib_unitName[473] = "炎魔"
    set ib_unitArmor[473] = "large"
    set ib_unitNameGbk[473] = "��ħ"
    set ib_unitList[474] = 'nlv3'
    set ib_unitName[474] = "炎魔"
    set ib_unitArmor[474] = "large"
    set ib_unitNameGbk[474] = "��ħ"
    set ib_unitList[475] = 'nmam'
    set ib_unitName[475] = "猛犸"
    set ib_unitArmor[475] = "large"
    set ib_unitNameGbk[475] = "����"
    set ib_unitList[476] = 'nmbg'
    set ib_unitName[476] = "穆格尔血女巫"
    set ib_unitArmor[476] = "medium"
    set ib_unitNameGbk[476] = "�¸��ѪŮ��"
    set ib_unitList[477] = 'nmcf'
    set ib_unitName[477] = "穆格尔岩人"
    set ib_unitArmor[477] = "large"
    set ib_unitNameGbk[477] = "�¸������"
    set ib_unitList[478] = 'nmdm'
    set ib_unitName[478] = "麦迪文"
    set ib_unitArmor[478] = "large"
    set ib_unitNameGbk[478] = "�����"
    set ib_unitList[479] = 'nmdr'
    set ib_unitName[479] = "恐怖猛犸"
    set ib_unitArmor[479] = "large"
    set ib_unitNameGbk[479] = "�ֲ�����"
endfunction
function IB_UnitFill6 takes nothing returns nothing
    set ib_unitList[480] = 'nmed'
    set ib_unitName[480] = "麦迪文"
    set ib_unitArmor[480] = "large"
    set ib_unitNameGbk[480] = "�����"
    set ib_unitList[481] = 'nmer'
    set ib_unitName[481] = "雇佣兵营地"
    set ib_unitArmor[481] = "fort"
    set ib_unitNameGbk[481] = "��Ӷ��Ӫ��"
    set ib_unitList[482] = 'nmfs'
    set ib_unitName[482] = "两栖食肉者"
    set ib_unitArmor[482] = "large"
    set ib_unitNameGbk[482] = "����ʳ����"
    set ib_unitList[483] = 'nmg0'
    set ib_unitName[483] = "穆格尔小屋"
    set ib_unitArmor[483] = "fort"
    set ib_unitNameGbk[483] = "�¸��С��"
    set ib_unitList[484] = 'nmg1'
    set ib_unitName[484] = "穆格尔小屋"
    set ib_unitArmor[484] = "fort"
    set ib_unitNameGbk[484] = "�¸��С��"
    set ib_unitList[485] = 'nmgd'
    set ib_unitName[485] = "玛格娜托破坏者"
    set ib_unitArmor[485] = "large"
    set ib_unitNameGbk[485] = "��������ƻ���"
    set ib_unitList[486] = 'nmgr'
    set ib_unitName[486] = "玛格娜托撕裂者"
    set ib_unitArmor[486] = "large"
    set ib_unitNameGbk[486] = "�������˺����"
    set ib_unitList[487] = 'nmgv'
    set ib_unitName[487] = "魔法宝箱"
    set ib_unitArmor[487] = "fort"
    set ib_unitNameGbk[487] = "ħ������"
    set ib_unitList[488] = 'nmgw'
    set ib_unitName[488] = "玛格娜托战士"
    set ib_unitArmor[488] = "large"
    set ib_unitNameGbk[488] = "�������սʿ"
    set ib_unitList[489] = 'nmh0'
    set ib_unitName[489] = "两栖鱼人小屋"
    set ib_unitArmor[489] = "fort"
    set ib_unitNameGbk[489] = "��������С��"
    set ib_unitList[490] = 'nmh1'
    set ib_unitName[490] = "两栖鱼人小屋"
    set ib_unitArmor[490] = "fort"
    set ib_unitNameGbk[490] = "��������С��"
    set ib_unitList[491] = 'nmit'
    set ib_unitName[491] = "冰牙猛犸"
    set ib_unitArmor[491] = "large"
    set ib_unitNameGbk[491] = "��������"
    set ib_unitList[492] = 'nmmu'
    set ib_unitName[492] = "变异两栖人"
    set ib_unitArmor[492] = "large"
    set ib_unitNameGbk[492] = "����������"
    set ib_unitList[493] = 'nmoo'
    set ib_unitName[493] = "魔法之泉"
    set ib_unitArmor[493] = "fort"
    set ib_unitNameGbk[493] = "ħ��֮Ȫ"
    set ib_unitList[494] = 'nmpe'
    set ib_unitName[494] = "穆格尔奴隶"
    set ib_unitArmor[494] = "none"
    set ib_unitNameGbk[494] = "�¸��ū��"
    set ib_unitList[495] = 'nmpg'
    set ib_unitName[495] = "两栖苦难者"
    set ib_unitArmor[495] = "large"
    set ib_unitNameGbk[495] = "���ܿ�����"
    set ib_unitList[496] = 'nmr0'
    set ib_unitName[496] = "雇佣兵营地"
    set ib_unitArmor[496] = "fort"
    set ib_unitNameGbk[496] = "��Ӷ��Ӫ��"
    set ib_unitList[497] = 'nmr2'
    set ib_unitName[497] = "雇佣兵营地"
    set ib_unitArmor[497] = "fort"
    set ib_unitNameGbk[497] = "��Ӷ��Ӫ��"
    set ib_unitList[498] = 'nmr3'
    set ib_unitName[498] = "雇佣兵营地"
    set ib_unitArmor[498] = "fort"
    set ib_unitNameGbk[498] = "��Ӷ��Ӫ��"
    set ib_unitList[499] = 'nmr4'
    set ib_unitName[499] = "雇佣兵营地"
    set ib_unitArmor[499] = "fort"
    set ib_unitNameGbk[499] = "��Ӷ��Ӫ��"
    set ib_unitList[500] = 'nmr5'
    set ib_unitName[500] = "雇佣兵营地"
    set ib_unitArmor[500] = "fort"
    set ib_unitNameGbk[500] = "��Ӷ��Ӫ��"
    set ib_unitList[501] = 'nmr6'
    set ib_unitName[501] = "雇佣兵营地"
    set ib_unitArmor[501] = "fort"
    set ib_unitNameGbk[501] = "��Ӷ��Ӫ��"
    set ib_unitList[502] = 'nmr7'
    set ib_unitName[502] = "雇佣兵营地"
    set ib_unitArmor[502] = "fort"
    set ib_unitNameGbk[502] = "��Ӷ��Ӫ��"
    set ib_unitList[503] = 'nmr8'
    set ib_unitName[503] = "雇佣兵营地"
    set ib_unitArmor[503] = "fort"
    set ib_unitNameGbk[503] = "��Ӷ��Ӫ��"
    set ib_unitList[504] = 'nmr9'
    set ib_unitName[504] = "雇佣兵营地"
    set ib_unitArmor[504] = "fort"
    set ib_unitNameGbk[504] = "��Ӷ��Ӫ��"
    set ib_unitList[505] = 'nmra'
    set ib_unitName[505] = "雇佣兵营地"
    set ib_unitArmor[505] = "fort"
    set ib_unitNameGbk[505] = "��Ӷ��Ӫ��"
    set ib_unitList[506] = 'nmrb'
    set ib_unitName[506] = "雇佣兵营地"
    set ib_unitArmor[506] = "fort"
    set ib_unitNameGbk[506] = "��Ӷ��Ӫ��"
    set ib_unitList[507] = 'nmrc'
    set ib_unitName[507] = "雇佣兵营地"
    set ib_unitArmor[507] = "fort"
    set ib_unitNameGbk[507] = "��Ӷ��Ӫ��"
    set ib_unitList[508] = 'nmrd'
    set ib_unitName[508] = "雇佣兵营地"
    set ib_unitArmor[508] = "fort"
    set ib_unitNameGbk[508] = "��Ӷ��Ӫ��"
    set ib_unitList[509] = 'nmre'
    set ib_unitName[509] = "雇佣兵营地"
    set ib_unitArmor[509] = "fort"
    set ib_unitNameGbk[509] = "��Ӷ��Ӫ��"
    set ib_unitList[510] = 'nmrf'
    set ib_unitName[510] = "雇佣兵营地"
    set ib_unitArmor[510] = "fort"
    set ib_unitNameGbk[510] = "��Ӷ��Ӫ��"
    set ib_unitList[511] = 'nmrk'
    set ib_unitName[511] = "市场"
    set ib_unitArmor[511] = "fort"
    set ib_unitNameGbk[511] = "�г�"
    set ib_unitList[512] = 'nmrl'
    set ib_unitName[512] = "两栖追随者"
    set ib_unitArmor[512] = "large"
    set ib_unitNameGbk[512] = "����׷����"
    set ib_unitList[513] = 'nmrm'
    set ib_unitName[513] = "两栖夜行者"
    set ib_unitArmor[513] = "large"
    set ib_unitNameGbk[513] = "����ҹ����"
    set ib_unitList[514] = 'nmrr'
    set ib_unitName[514] = "两栖人猎手"
    set ib_unitArmor[514] = "large"
    set ib_unitNameGbk[514] = "����������"
    set ib_unitList[515] = 'nmrv'
    set ib_unitName[515] = "穆格尔掠夺者"
    set ib_unitArmor[515] = "large"
    set ib_unitNameGbk[515] = "�¸���Ӷ���"
    set ib_unitList[516] = 'nmsc'
    set ib_unitName[516] = "穆格尔影子法师"
    set ib_unitArmor[516] = "large"
    set ib_unitNameGbk[516] = "�¸��Ӱ�ӷ�ʦ"
    set ib_unitList[517] = 'nmsh'
    set ib_unitName[517] = "米纱"
    set ib_unitArmor[517] = "large"
    set ib_unitNameGbk[517] = "��ɴ"
    set ib_unitList[518] = 'nmsn'
    set ib_unitName[518] = "穆格尔猎人"
    set ib_unitArmor[518] = "medium"
    set ib_unitNameGbk[518] = "�¸������"
    set ib_unitList[519] = 'nmtw'
    set ib_unitName[519] = "穆格尔潮汐战士"
    set ib_unitArmor[519] = "large"
    set ib_unitNameGbk[519] = "�¸����ϫսʿ"
    set ib_unitList[520] = 'nmyr'
    set ib_unitName[520] = "娜迦暴徒"
    set ib_unitArmor[520] = "large"
    set ib_unitNameGbk[520] = "���ȱ�ͽ"
    set ib_unitList[521] = 'nmys'
    set ib_unitName[521] = "潜水的娜迦暴徒"
    set ib_unitArmor[521] = "large"
    set ib_unitNameGbk[521] = "Ǳˮ�����ȱ�ͽ"
    set ib_unitList[522] = 'nnad'
    set ib_unitName[522] = "深渊祭坛"
    set ib_unitArmor[522] = "fort"
    set ib_unitNameGbk[522] = "��Ԩ��̳"
    set ib_unitList[523] = 'nndk'
    set ib_unitName[523] = "耐瑟蜉蝣"
    set ib_unitArmor[523] = "large"
    set ib_unitNameGbk[523] = "��ɪ����"
    set ib_unitList[524] = 'nndr'
    set ib_unitName[524] = "耐瑟龙"
    set ib_unitArmor[524] = "large"
    set ib_unitNameGbk[524] = "��ɪ��"
    set ib_unitList[525] = 'nnfm'
    set ib_unitName[525] = "珊瑚礁"
    set ib_unitArmor[525] = "fort"
    set ib_unitNameGbk[525] = "ɺ����"
    set ib_unitList[526] = 'nnht'
    set ib_unitName[526] = "耐瑟幼龙"
    set ib_unitArmor[526] = "large"
    set ib_unitNameGbk[526] = "��ɪ����"
    set ib_unitList[527] = 'nnmg'
    set ib_unitName[527] = "穆格尔掠夺者"
    set ib_unitArmor[527] = "large"
    set ib_unitNameGbk[527] = "�¸���Ӷ���"
    set ib_unitList[528] = 'nnrg'
    set ib_unitName[528] = "娜迦皇家卫兵"
    set ib_unitArmor[528] = "large"
    set ib_unitNameGbk[528] = "���Ȼʼ�����"
    set ib_unitList[529] = 'nnrs'
    set ib_unitName[529] = "潜水的娜迦皇家卫兵"
    set ib_unitArmor[529] = "large"
    set ib_unitNameGbk[529] = "Ǳˮ�����Ȼʼ�����"
    set ib_unitList[530] = 'nnsa'
    set ib_unitName[530] = "艾萨拉女王神殿"
    set ib_unitArmor[530] = "fort"
    set ib_unitNameGbk[530] = "������Ů�����"
    set ib_unitList[531] = 'nnsg'
    set ib_unitName[531] = "产卵之地"
    set ib_unitArmor[531] = "fort"
    set ib_unitNameGbk[531] = "����֮��"
    set ib_unitList[532] = 'nnsu'
    set ib_unitName[532] = "召唤者"
    set ib_unitArmor[532] = "none"
    set ib_unitNameGbk[532] = "�ٻ���"
    set ib_unitList[533] = 'nnsw'
    set ib_unitName[533] = "娜迦海妖"
    set ib_unitArmor[533] = "none"
    set ib_unitNameGbk[533] = "���Ⱥ���"
    set ib_unitList[534] = 'nntg'
    set ib_unitName[534] = "守护者"
    set ib_unitArmor[534] = "fort"
    set ib_unitNameGbk[534] = "�ػ���"
    set ib_unitList[535] = 'nntt'
    set ib_unitName[535] = "潮汐神庙"
    set ib_unitArmor[535] = "fort"
    set ib_unitNameGbk[535] = "��ϫ����"
    set ib_unitList[536] = 'nnwa'
    set ib_unitName[536] = "蛛网怪战士"
    set ib_unitArmor[536] = "large"
    set ib_unitNameGbk[536] = "������սʿ"
    set ib_unitList[537] = 'nnwl'
    set ib_unitName[537] = "蛛网怪织网者"
    set ib_unitArmor[537] = "large"
    set ib_unitNameGbk[537] = "������֯����"
    set ib_unitList[538] = 'nnwq'
    set ib_unitName[538] = "蛛网怪女皇"
    set ib_unitArmor[538] = "large"
    set ib_unitNameGbk[538] = "������Ů��"
    set ib_unitList[539] = 'nnwr'
    set ib_unitName[539] = "蛛网怪预言者"
    set ib_unitArmor[539] = "large"
    set ib_unitNameGbk[539] = "������Ԥ����"
    set ib_unitList[540] = 'nnws'
    set ib_unitName[540] = "蛛网怪首领"
    set ib_unitArmor[540] = "large"
    set ib_unitNameGbk[540] = "����������"
    set ib_unitList[541] = 'nnzg'
    set ib_unitName[541] = "通灵塔"
    set ib_unitArmor[541] = "fort"
    set ib_unitNameGbk[541] = "ͨ����"
    set ib_unitList[542] = 'noga'
    set ib_unitName[542] = "石槌酋长"
    set ib_unitArmor[542] = "large"
    set ib_unitNameGbk[542] = "ʯ�����"
    set ib_unitList[543] = 'nogl'
    set ib_unitName[543] = "食人鬼首领"
    set ib_unitArmor[543] = "large"
    set ib_unitNameGbk[543] = "ʳ�˹�����"
    set ib_unitList[544] = 'nogm'
    set ib_unitName[544] = "食人鬼拳手"
    set ib_unitArmor[544] = "large"
    set ib_unitNameGbk[544] = "ʳ�˹�ȭ��"
    set ib_unitList[545] = 'nogn'
    set ib_unitName[545] = "石槌法师"
    set ib_unitArmor[545] = "large"
    set ib_unitNameGbk[545] = "ʯ鳷�ʦ"
    set ib_unitList[546] = 'nogo'
    set ib_unitName[546] = "石槌食人魔"
    set ib_unitArmor[546] = "large"
    set ib_unitNameGbk[546] = "ʯ�ʳ��ħ"
    set ib_unitList[547] = 'nogr'
    set ib_unitName[547] = "食人鬼战士"
    set ib_unitArmor[547] = "large"
    set ib_unitNameGbk[547] = "ʳ�˹�սʿ"
    set ib_unitList[548] = 'nomg'
    set ib_unitName[548] = "食人鬼魔法师"
    set ib_unitArmor[548] = "large"
    set ib_unitNameGbk[548] = "ʳ�˹�ħ��ʦ"
    set ib_unitList[549] = 'now2'
    set ib_unitName[549] = "猫头鹰侦察者"
    set ib_unitArmor[549] = "medium"
    set ib_unitNameGbk[549] = "èͷӥ�����"
    set ib_unitList[550] = 'now3'
    set ib_unitName[550] = "猫头鹰侦察者"
    set ib_unitArmor[550] = "medium"
    set ib_unitNameGbk[550] = "èͷӥ�����"
    set ib_unitList[551] = 'nowb'
    set ib_unitName[551] = "迅猛野兽"
    set ib_unitArmor[551] = "large"
    set ib_unitNameGbk[551] = "Ѹ��Ұ��"
    set ib_unitList[552] = 'nowe'
    set ib_unitName[552] = "暴怒野兽"
    set ib_unitArmor[552] = "large"
    set ib_unitNameGbk[552] = "��ŭҰ��"
    set ib_unitList[553] = 'nowk'
    set ib_unitName[553] = "狂性野兽"
    set ib_unitArmor[553] = "large"
    set ib_unitNameGbk[553] = "����Ұ��"
    set ib_unitList[554] = 'nowl'
    set ib_unitName[554] = "猫头鹰侦察者"
    set ib_unitArmor[554] = "medium"
    set ib_unitNameGbk[554] = "èͷӥ�����"
    set ib_unitList[555] = 'npfl'
    set ib_unitName[555] = "狂暴野兽"
    set ib_unitArmor[555] = "large"
    set ib_unitNameGbk[555] = "��Ұ��"
    set ib_unitList[556] = 'npfm'
    set ib_unitName[556] = "狂暴洗劫者"
    set ib_unitArmor[556] = "large"
    set ib_unitNameGbk[556] = "��ϴ����"
    set ib_unitList[557] = 'npgf'
    set ib_unitName[557] = "猪圈农场"
    set ib_unitArmor[557] = "fort"
    set ib_unitNameGbk[557] = "��Ȧũ��"
    set ib_unitList[558] = 'npgr'
    set ib_unitName[558] = "能量产生器"
    set ib_unitArmor[558] = "fort"
    set ib_unitNameGbk[558] = "����������"
    set ib_unitList[559] = 'npig'
    set ib_unitName[559] = "野猪"
    set ib_unitArmor[559] = "medium"
    set ib_unitNameGbk[559] = "Ұ��"
endfunction
function IB_UnitFill7 takes nothing returns nothing
    set ib_unitList[560] = 'nplb'
    set ib_unitName[560] = "北极熊"
    set ib_unitArmor[560] = "large"
    set ib_unitNameGbk[560] = "������"
    set ib_unitList[561] = 'nplg'
    set ib_unitName[561] = "巨型北极熊"
    set ib_unitArmor[561] = "large"
    set ib_unitNameGbk[561] = "���ͱ�����"
    set ib_unitList[562] = 'npn1'
    set ib_unitName[562] = "火焰"
    set ib_unitArmor[562] = "large"
    set ib_unitNameGbk[562] = "����"
    set ib_unitList[563] = 'npn2'
    set ib_unitName[563] = "风暴"
    set ib_unitArmor[563] = "large"
    set ib_unitNameGbk[563] = "�籩"
    set ib_unitList[564] = 'npn3'
    set ib_unitName[564] = "大地"
    set ib_unitArmor[564] = "large"
    set ib_unitNameGbk[564] = "���"
    set ib_unitList[565] = 'npn4'
    set ib_unitName[565] = "火之熊猫战士"
    set ib_unitArmor[565] = "large"
    set ib_unitNameGbk[565] = "��֮��èսʿ"
    set ib_unitList[566] = 'npn5'
    set ib_unitName[566] = "风之熊猫战士"
    set ib_unitArmor[566] = "large"
    set ib_unitNameGbk[566] = "��֮��èսʿ"
    set ib_unitList[567] = 'npn6'
    set ib_unitName[567] = "地之熊猫战士"
    set ib_unitArmor[567] = "large"
    set ib_unitNameGbk[567] = "��֮��èսʿ"
    set ib_unitList[568] = 'npng'
    set ib_unitName[568] = "企鹅"
    set ib_unitArmor[568] = "medium"
    set ib_unitNameGbk[568] = "���"
    set ib_unitList[569] = 'npnw'
    set ib_unitName[569] = "企鹅"
    set ib_unitArmor[569] = "medium"
    set ib_unitNameGbk[569] = "���"
    set ib_unitList[570] = 'nqb1'
    set ib_unitName[570] = "豪猪"
    set ib_unitArmor[570] = "medium"
    set ib_unitNameGbk[570] = "����"
    set ib_unitList[571] = 'nqb2'
    set ib_unitName[571] = "凶恶豪猪"
    set ib_unitArmor[571] = "medium"
    set ib_unitNameGbk[571] = "�׶����"
    set ib_unitList[572] = 'nqb3'
    set ib_unitName[572] = "影子豪猪"
    set ib_unitArmor[572] = "medium"
    set ib_unitNameGbk[572] = "Ӱ�Ӻ���"
    set ib_unitList[573] = 'nqb4'
    set ib_unitName[573] = "狂暴豪猪"
    set ib_unitArmor[573] = "medium"
    set ib_unitNameGbk[573] = "�񱩺���"
    set ib_unitList[574] = 'nqbh'
    set ib_unitName[574] = "豪猪猎手"
    set ib_unitArmor[574] = "medium"
    set ib_unitNameGbk[574] = "��������"
    set ib_unitList[575] = 'nrac'
    set ib_unitName[575] = "浣熊"
    set ib_unitArmor[575] = "medium"
    set ib_unitNameGbk[575] = "���"
    set ib_unitList[576] = 'nrat'
    set ib_unitName[576] = "老鼠"
    set ib_unitArmor[576] = "medium"
    set ib_unitNameGbk[576] = "����"
    set ib_unitList[577] = 'nrdk'
    set ib_unitName[577] = "红幼龙"
    set ib_unitArmor[577] = "small"
    set ib_unitNameGbk[577] = "������"
    set ib_unitList[578] = 'nrdr'
    set ib_unitName[578] = "红蜉蝣"
    set ib_unitArmor[578] = "large"
    set ib_unitNameGbk[578] = "������"
    set ib_unitList[579] = 'nrel'
    set ib_unitName[579] = "暗礁元素"
    set ib_unitArmor[579] = "medium"
    set ib_unitNameGbk[579] = "����Ԫ��"
    set ib_unitList[580] = 'nrog'
    set ib_unitName[580] = "流氓"
    set ib_unitArmor[580] = "large"
    set ib_unitNameGbk[580] = "��å"
    set ib_unitList[581] = 'nrvd'
    set ib_unitName[581] = "死亡幽魂"
    set ib_unitArmor[581] = "large"
    set ib_unitNameGbk[581] = "�����Ļ�"
    set ib_unitList[582] = 'nrvf'
    set ib_unitName[582] = "火焰幽魂"
    set ib_unitArmor[582] = "large"
    set ib_unitNameGbk[582] = "�����Ļ�"
    set ib_unitList[583] = 'nrvi'
    set ib_unitName[583] = "冰之幽魂"
    set ib_unitArmor[583] = "large"
    set ib_unitNameGbk[583] = "��֮�Ļ�"
    set ib_unitList[584] = 'nrvl'
    set ib_unitName[584] = "闪电幽魂"
    set ib_unitArmor[584] = "medium"
    set ib_unitNameGbk[584] = "�����Ļ�"
    set ib_unitList[585] = 'nrvs'
    set ib_unitName[585] = "霜冻幽魂"
    set ib_unitArmor[585] = "large"
    set ib_unitNameGbk[585] = "˪���Ļ�"
    set ib_unitList[586] = 'nrwm'
    set ib_unitName[586] = "红龙"
    set ib_unitArmor[586] = "large"
    set ib_unitNameGbk[586] = "����"
    set ib_unitList[587] = 'nrzb'
    set ib_unitName[587] = "尖毛兽野蛮人"
    set ib_unitArmor[587] = "large"
    set ib_unitNameGbk[587] = "��ë��Ұ����"
    set ib_unitList[588] = 'nrzg'
    set ib_unitName[588] = "尖毛兽酋长"
    set ib_unitArmor[588] = "large"
    set ib_unitNameGbk[588] = "��ë������"
    set ib_unitList[589] = 'nrzm'
    set ib_unitName[589] = "尖毛兽医生"
    set ib_unitArmor[589] = "large"
    set ib_unitNameGbk[589] = "��ë��ҽ��"
    set ib_unitList[590] = 'nrzs'
    set ib_unitName[590] = "尖毛兽侦察兵"
    set ib_unitArmor[590] = "large"
    set ib_unitNameGbk[590] = "��ë������"
    set ib_unitList[591] = 'nrzt'
    set ib_unitName[591] = "豪猪"
    set ib_unitArmor[591] = "large"
    set ib_unitNameGbk[591] = "����"
    set ib_unitList[592] = 'nsat'
    set ib_unitName[592] = "赛特斯之魔法师"
    set ib_unitArmor[592] = "large"
    set ib_unitNameGbk[592] = "����˹֮ħ��ʦ"
    set ib_unitList[593] = 'nsbm'
    set ib_unitName[593] = "血浴之母"
    set ib_unitArmor[593] = "large"
    set ib_unitNameGbk[593] = "Ѫԡ֮ĸ"
    set ib_unitList[594] = 'nsbs'
    set ib_unitName[594] = "潜水的飞龙"
    set ib_unitArmor[594] = "medium"
    set ib_unitNameGbk[594] = "Ǳˮ�ķ���"
    set ib_unitList[595] = 'nsc2'
    set ib_unitName[595] = "蜘蛛螃蟹肢体撕裂者"
    set ib_unitArmor[595] = "large"
    set ib_unitNameGbk[595] = "֩���з֫��˺����"
    set ib_unitList[596] = 'nsc3'
    set ib_unitName[596] = "蜘蛛螃蟹巨兽"
    set ib_unitArmor[596] = "large"
    set ib_unitNameGbk[596] = "֩���з����"
    set ib_unitList[597] = 'nsca'
    set ib_unitName[597] = "骷髅弓箭手"
    set ib_unitArmor[597] = "large"
    set ib_unitNameGbk[597] = "���ù�����"
    set ib_unitList[598] = 'nscb'
    set ib_unitName[598] = "蜘蛛螃蟹"
    set ib_unitArmor[598] = "large"
    set ib_unitNameGbk[598] = "֩���з"
    set ib_unitList[599] = 'nsce'
    set ib_unitName[599] = "骷髅战士"
    set ib_unitArmor[599] = "large"
    set ib_unitNameGbk[599] = "����սʿ"
    set ib_unitList[600] = 'nsea'
    set ib_unitName[600] = "海豹"
    set ib_unitArmor[600] = "medium"
    set ib_unitNameGbk[600] = "����"
    set ib_unitList[601] = 'nsel'
    set ib_unitName[601] = "海元素"
    set ib_unitArmor[601] = "medium"
    set ib_unitNameGbk[601] = "��Ԫ��"
    set ib_unitList[602] = 'nser'
    set ib_unitName[602] = "西里诺克斯"
    set ib_unitArmor[602] = "small"
    set ib_unitNameGbk[602] = "����ŵ��˹"
    set ib_unitList[603] = 'nsgb'
    set ib_unitName[603] = "深海巨兽"
    set ib_unitArmor[603] = "large"
    set ib_unitNameGbk[603] = "�����"
    set ib_unitList[604] = 'nsgg'
    set ib_unitName[604] = "攻城傀儡"
    set ib_unitArmor[604] = "large"
    set ib_unitNameGbk[604] = "���ǿ���"
    set ib_unitList[605] = 'nsgh'
    set ib_unitName[605] = "深海巨猎人"
    set ib_unitArmor[605] = "large"
    set ib_unitNameGbk[605] = "�������"
    set ib_unitList[606] = 'nsgn'
    set ib_unitName[606] = "海巨人"
    set ib_unitArmor[606] = "large"
    set ib_unitNameGbk[606] = "������"
    set ib_unitList[607] = 'nsgt'
    set ib_unitName[607] = "巨型蜘蛛"
    set ib_unitArmor[607] = "large"
    set ib_unitNameGbk[607] = "����֩��"
    set ib_unitList[608] = 'nsha'
    set ib_unitName[608] = "绵羊"
    set ib_unitArmor[608] = "medium"
    set ib_unitNameGbk[608] = "����"
    set ib_unitList[609] = 'nshe'
    set ib_unitName[609] = "绵羊"
    set ib_unitArmor[609] = "medium"
    set ib_unitNameGbk[609] = "����"
    set ib_unitList[610] = 'nshf'
    set ib_unitName[610] = "乳羊"
    set ib_unitArmor[610] = "medium"
    set ib_unitNameGbk[610] = "����"
    set ib_unitList[611] = 'nshp'
    set ib_unitName[611] = "地精船坞"
    set ib_unitArmor[611] = "fort"
    set ib_unitNameGbk[611] = "�ؾ�����"
    set ib_unitList[612] = 'nshr'
    set ib_unitName[612] = "神殿"
    set ib_unitArmor[612] = "fort"
    set ib_unitNameGbk[612] = "���"
    set ib_unitList[613] = 'nshw'
    set ib_unitName[613] = "绵羊"
    set ib_unitArmor[613] = "medium"
    set ib_unitNameGbk[613] = "����"
    set ib_unitList[614] = 'nska'
    set ib_unitName[614] = "骷髅弓箭手"
    set ib_unitArmor[614] = "large"
    set ib_unitNameGbk[614] = "���ù�����"
    set ib_unitList[615] = 'nske'
    set ib_unitName[615] = "骷髅战士"
    set ib_unitArmor[615] = "large"
    set ib_unitNameGbk[615] = "����սʿ"
    set ib_unitList[616] = 'nskf'
    set ib_unitName[616] = "火焰弓箭手"
    set ib_unitArmor[616] = "large"
    set ib_unitNameGbk[616] = "���湭����"
    set ib_unitList[617] = 'nskg'
    set ib_unitName[617] = "巨型骷髅战士"
    set ib_unitArmor[617] = "large"
    set ib_unitNameGbk[617] = "��������սʿ"
    set ib_unitList[618] = 'nskk'
    set ib_unitName[618] = "小蜥蜴"
    set ib_unitArmor[618] = "medium"
    set ib_unitNameGbk[618] = "С����"
    set ib_unitList[619] = 'nskm'
    set ib_unitName[619] = "骷髅射手"
    set ib_unitArmor[619] = "large"
    set ib_unitNameGbk[619] = "��������"
    set ib_unitList[620] = 'nsko'
    set ib_unitName[620] = "兽族骷髅"
    set ib_unitArmor[620] = "large"
    set ib_unitNameGbk[620] = "��������"
    set ib_unitList[621] = 'nslf'
    set ib_unitName[621] = "淤泥投手"
    set ib_unitArmor[621] = "medium"
    set ib_unitNameGbk[621] = "����Ͷ��"
    set ib_unitList[622] = 'nslh'
    set ib_unitName[622] = "小蜥蜴"
    set ib_unitArmor[622] = "large"
    set ib_unitNameGbk[622] = "С����"
    set ib_unitList[623] = 'nsll'
    set ib_unitName[623] = "蜥蜴领主"
    set ib_unitArmor[623] = "large"
    set ib_unitNameGbk[623] = "��������"
    set ib_unitList[624] = 'nslm'
    set ib_unitName[624] = "淤泥战士"
    set ib_unitArmor[624] = "medium"
    set ib_unitNameGbk[624] = "����սʿ"
    set ib_unitList[625] = 'nsln'
    set ib_unitName[625] = "淤泥怪物"
    set ib_unitArmor[625] = "large"
    set ib_unitNameGbk[625] = "�������"
    set ib_unitList[626] = 'nslr'
    set ib_unitName[626] = "蜥蜴怪物"
    set ib_unitArmor[626] = "large"
    set ib_unitNameGbk[626] = "�������"
    set ib_unitList[627] = 'nslv'
    set ib_unitName[627] = "大型蜥蜴怪物"
    set ib_unitArmor[627] = "large"
    set ib_unitNameGbk[627] = "�����������"
    set ib_unitList[628] = 'nsno'
    set ib_unitName[628] = "雪鹰"
    set ib_unitArmor[628] = "medium"
    set ib_unitNameGbk[628] = "ѩӥ"
    set ib_unitList[629] = 'nsnp'
    set ib_unitName[629] = "飞龙"
    set ib_unitArmor[629] = "medium"
    set ib_unitNameGbk[629] = "����"
    set ib_unitList[630] = 'nsns'
    set ib_unitName[630] = "水奴"
    set ib_unitArmor[630] = "medium"
    set ib_unitNameGbk[630] = "ˮū"
    set ib_unitList[631] = 'nsoc'
    set ib_unitName[631] = "兽族战士骷髅"
    set ib_unitArmor[631] = "large"
    set ib_unitNameGbk[631] = "����սʿ����"
    set ib_unitList[632] = 'nsog'
    set ib_unitName[632] = "兽族步兵骷髅"
    set ib_unitArmor[632] = "large"
    set ib_unitNameGbk[632] = "���岽������"
    set ib_unitList[633] = 'nspb'
    set ib_unitName[633] = "黑蜘蛛"
    set ib_unitArmor[633] = "large"
    set ib_unitNameGbk[633] = "��֩��"
    set ib_unitList[634] = 'nspc'
    set ib_unitName[634] = "支柱"
    set ib_unitArmor[634] = "fort"
    set ib_unitNameGbk[634] = "֧��"
    set ib_unitList[635] = 'nspd'
    set ib_unitName[635] = "小蜘蛛"
    set ib_unitArmor[635] = "medium"
    set ib_unitNameGbk[635] = "С֩��"
    set ib_unitList[636] = 'nspg'
    set ib_unitName[636] = "森林蜘蛛"
    set ib_unitArmor[636] = "large"
    set ib_unitNameGbk[636] = "ɭ��֩��"
    set ib_unitList[637] = 'nspp'
    set ib_unitName[637] = "灵魂之猪"
    set ib_unitArmor[637] = "large"
    set ib_unitNameGbk[637] = "���֮��"
    set ib_unitList[638] = 'nspr'
    set ib_unitName[638] = "蜘蛛"
    set ib_unitArmor[638] = "large"
    set ib_unitNameGbk[638] = "֩��"
    set ib_unitList[639] = 'nsqa'
    set ib_unitName[639] = "古代野人"
    set ib_unitArmor[639] = "large"
    set ib_unitNameGbk[639] = "�Ŵ�Ұ��"
endfunction
function IB_UnitFill8 takes nothing returns nothing
    set ib_unitList[640] = 'nsqe'
    set ib_unitName[640] = "野人长者"
    set ib_unitArmor[640] = "large"
    set ib_unitNameGbk[640] = "Ұ�˳���"
    set ib_unitList[641] = 'nsqo'
    set ib_unitName[641] = "野人神使"
    set ib_unitArmor[641] = "large"
    set ib_unitNameGbk[641] = "Ұ����ʹ"
    set ib_unitList[642] = 'nsqt'
    set ib_unitName[642] = "野人"
    set ib_unitArmor[642] = "large"
    set ib_unitNameGbk[642] = "Ұ��"
    set ib_unitList[643] = 'nsra'
    set ib_unitName[643] = "风暴撕裂者学徒"
    set ib_unitArmor[643] = "medium"
    set ib_unitNameGbk[643] = "�籩˺����ѧͽ"
    set ib_unitList[644] = 'nsrh'
    set ib_unitName[644] = "风暴撕裂者隐士"
    set ib_unitArmor[644] = "medium"
    set ib_unitNameGbk[644] = "�籩˺������ʿ"
    set ib_unitList[645] = 'nsrn'
    set ib_unitName[645] = "风暴撕裂者术士"
    set ib_unitArmor[645] = "large"
    set ib_unitNameGbk[645] = "�籩˺������ʿ"
    set ib_unitList[646] = 'nsrv'
    set ib_unitName[646] = "海之幽灵"
    set ib_unitArmor[646] = "large"
    set ib_unitNameGbk[646] = "��֮����"
    set ib_unitList[647] = 'nsrw'
    set ib_unitName[647] = "风暴撕裂者巫师"
    set ib_unitArmor[647] = "large"
    set ib_unitNameGbk[647] = "�籩˺������ʦ"
    set ib_unitList[648] = 'nssn'
    set ib_unitName[648] = "守望者"
    set ib_unitArmor[648] = "large"
    set ib_unitNameGbk[648] = "������"
    set ib_unitList[649] = 'nssp'
    set ib_unitName[649] = "毒液蜘蛛"
    set ib_unitArmor[649] = "large"
    set ib_unitNameGbk[649] = "��Һ֩��"
    set ib_unitList[650] = 'nsth'
    set ib_unitName[650] = "赛特斯之地狱使者"
    set ib_unitArmor[650] = "large"
    set ib_unitNameGbk[650] = "����˹֮����ʹ��"
    set ib_unitList[651] = 'nstl'
    set ib_unitName[651] = "赛特斯之灵魂盗贼"
    set ib_unitArmor[651] = "large"
    set ib_unitNameGbk[651] = "����˹֮������"
    set ib_unitList[652] = 'nsts'
    set ib_unitName[652] = "赛特斯之黑暗舞者"
    set ib_unitArmor[652] = "medium"
    set ib_unitNameGbk[652] = "����˹֮�ڰ�����"
    set ib_unitList[653] = 'nstw'
    set ib_unitName[653] = "风暴巨龙"
    set ib_unitArmor[653] = "large"
    set ib_unitNameGbk[653] = "�籩����"
    set ib_unitList[654] = 'nsty'
    set ib_unitName[654] = "赛特斯"
    set ib_unitArmor[654] = "large"
    set ib_unitNameGbk[654] = "����˹"
    set ib_unitList[655] = 'nsw1'
    set ib_unitName[655] = "小型灵兽"
    set ib_unitArmor[655] = "large"
    set ib_unitNameGbk[655] = "С������"
    set ib_unitList[656] = 'nsw2'
    set ib_unitName[656] = "灵兽"
    set ib_unitArmor[656] = "large"
    set ib_unitNameGbk[656] = "����"
    set ib_unitList[657] = 'nsw3'
    set ib_unitName[657] = "大型灵兽"
    set ib_unitArmor[657] = "large"
    set ib_unitNameGbk[657] = "��������"
    set ib_unitList[658] = 'ntav'
    set ib_unitName[658] = "小酒馆"
    set ib_unitArmor[658] = "fort"
    set ib_unitNameGbk[658] = "С�ƹ�"
    set ib_unitList[659] = 'nten'
    set ib_unitName[659] = "帐篷"
    set ib_unitArmor[659] = "fort"
    set ib_unitNameGbk[659] = "����"
    set ib_unitList[660] = 'nth0'
    set ib_unitName[660] = "冰之巨魔小屋"
    set ib_unitArmor[660] = "fort"
    set ib_unitNameGbk[660] = "��֮��ħС��"
    set ib_unitList[661] = 'nth1'
    set ib_unitName[661] = "冰之巨魔小屋"
    set ib_unitArmor[661] = "fort"
    set ib_unitNameGbk[661] = "��֮��ħС��"
    set ib_unitList[662] = 'nthl'
    set ib_unitName[662] = "雷霆蜥蜴"
    set ib_unitArmor[662] = "large"
    set ib_unitNameGbk[662] = "��������"
    set ib_unitList[663] = 'nthr'
    set ib_unitName[663] = "萨里法斯"
    set ib_unitArmor[663] = "small"
    set ib_unitNameGbk[663] = "���﷨˹"
    set ib_unitList[664] = 'ntka'
    set ib_unitName[664] = "图斯卡尔枪兵"
    set ib_unitArmor[664] = "large"
    set ib_unitNameGbk[664] = "ͼ˹����ǹ��"
    set ib_unitList[665] = 'ntkc'
    set ib_unitName[665] = "图斯卡尔酋长"
    set ib_unitArmor[665] = "large"
    set ib_unitNameGbk[665] = "ͼ˹��������"
    set ib_unitList[666] = 'ntkf'
    set ib_unitName[666] = "图斯卡尔格斗者"
    set ib_unitArmor[666] = "large"
    set ib_unitNameGbk[666] = "ͼ˹��������"
    set ib_unitList[667] = 'ntkh'
    set ib_unitName[667] = "图斯卡尔巫师"
    set ib_unitArmor[667] = "medium"
    set ib_unitNameGbk[667] = "ͼ˹������ʦ"
    set ib_unitList[668] = 'ntks'
    set ib_unitName[668] = "图斯卡尔男巫"
    set ib_unitArmor[668] = "medium"
    set ib_unitNameGbk[668] = "ͼ˹��������"
    set ib_unitList[669] = 'ntkt'
    set ib_unitName[669] = "图斯卡尔猎人"
    set ib_unitArmor[669] = "medium"
    set ib_unitNameGbk[669] = "ͼ˹��������"
    set ib_unitList[670] = 'ntkw'
    set ib_unitName[670] = "图斯卡尔战士"
    set ib_unitArmor[670] = "large"
    set ib_unitNameGbk[670] = "ͼ˹����սʿ"
    set ib_unitList[671] = 'ntn2'
    set ib_unitName[671] = "帐篷"
    set ib_unitArmor[671] = "fort"
    set ib_unitNameGbk[671] = "����"
    set ib_unitList[672] = 'ntnt'
    set ib_unitName[672] = "牛头人帐篷"
    set ib_unitArmor[672] = "fort"
    set ib_unitNameGbk[672] = "ţͷ������"
    set ib_unitList[673] = 'ntor'
    set ib_unitName[673] = "龙卷风"
    set ib_unitArmor[673] = "large"
    set ib_unitNameGbk[673] = "������"
    set ib_unitList[674] = 'ntrd'
    set ib_unitName[674] = "龙龟"
    set ib_unitArmor[674] = "large"
    set ib_unitNameGbk[674] = "����"
    set ib_unitList[675] = 'ntrg'
    set ib_unitName[675] = "大海龟"
    set ib_unitArmor[675] = "large"
    set ib_unitNameGbk[675] = "�󺣹�"
    set ib_unitList[676] = 'ntrh'
    set ib_unitName[676] = "小海龟"
    set ib_unitArmor[676] = "medium"
    set ib_unitNameGbk[676] = "С����"
    set ib_unitList[677] = 'ntrs'
    set ib_unitName[677] = "海龟"
    set ib_unitArmor[677] = "large"
    set ib_unitNameGbk[677] = "����"
    set ib_unitList[678] = 'ntrt'
    set ib_unitName[678] = "大海龟"
    set ib_unitArmor[678] = "medium"
    set ib_unitNameGbk[678] = "�󺣹�"
    set ib_unitList[679] = 'ntrv'
    set ib_unitName[679] = "潮汐幽灵"
    set ib_unitArmor[679] = "large"
    set ib_unitNameGbk[679] = "��ϫ����"
    set ib_unitList[680] = 'ntt1'
    set ib_unitName[680] = "死亡之塔"
    set ib_unitArmor[680] = "fort"
    set ib_unitNameGbk[680] = "����֮��"
    set ib_unitList[681] = 'ntt2'
    set ib_unitName[681] = "牛头人帐篷"
    set ib_unitArmor[681] = "fort"
    set ib_unitNameGbk[681] = "ţͷ������"
    set ib_unitList[682] = 'ntws'
    set ib_unitName[682] = "水奴"
    set ib_unitArmor[682] = "large"
    set ib_unitNameGbk[682] = "ˮū"
    set ib_unitList[683] = 'ntx2'
    set ib_unitName[683] = "高级死亡之塔"
    set ib_unitArmor[683] = "fort"
    set ib_unitNameGbk[683] = "�߼�����֮��"
    set ib_unitList[684] = 'nubk'
    set ib_unitName[684] = "无敌黑暗猎人"
    set ib_unitArmor[684] = "large"
    set ib_unitNameGbk[684] = "�޵кڰ�����"
    set ib_unitList[685] = 'nubr'
    set ib_unitName[685] = "无敌狂暴者"
    set ib_unitArmor[685] = "large"
    set ib_unitNameGbk[685] = "�޵п���"
    set ib_unitList[686] = 'nubw'
    set ib_unitName[686] = "无敌黑暗舞者"
    set ib_unitArmor[686] = "large"
    set ib_unitNameGbk[686] = "�޵кڰ�����"
    set ib_unitList[687] = 'nvde'
    set ib_unitName[687] = "虚无行者长老"
    set ib_unitArmor[687] = "large"
    set ib_unitNameGbk[687] = "�������߳���"
    set ib_unitList[688] = 'nvdg'
    set ib_unitName[688] = "巨大虚无行者长老"
    set ib_unitArmor[688] = "large"
    set ib_unitNameGbk[688] = "�޴��������߳���"
    set ib_unitList[689] = 'nvdl'
    set ib_unitName[689] = "小型虚无行者"
    set ib_unitArmor[689] = "medium"
    set ib_unitNameGbk[689] = "С����������"
    set ib_unitList[690] = 'nvdw'
    set ib_unitName[690] = "虚无行者"
    set ib_unitArmor[690] = "medium"
    set ib_unitNameGbk[690] = "��������"
    set ib_unitList[691] = 'nvil'
    set ib_unitName[691] = "村民"
    set ib_unitArmor[691] = "medium"
    set ib_unitNameGbk[691] = "����"
    set ib_unitList[692] = 'nvk2'
    set ib_unitName[692] = "小孩"
    set ib_unitArmor[692] = "medium"
    set ib_unitNameGbk[692] = "С��"
    set ib_unitList[693] = 'nvl2'
    set ib_unitName[693] = "村民"
    set ib_unitArmor[693] = "medium"
    set ib_unitNameGbk[693] = "����"
    set ib_unitList[694] = 'nvlk'
    set ib_unitName[694] = "小孩"
    set ib_unitArmor[694] = "medium"
    set ib_unitNameGbk[694] = "С��"
    set ib_unitList[695] = 'nvlw'
    set ib_unitName[695] = "村民"
    set ib_unitArmor[695] = "medium"
    set ib_unitNameGbk[695] = "����"
    set ib_unitList[696] = 'nvr0'
    set ib_unitName[696] = "暗夜精灵族渔村"
    set ib_unitArmor[696] = "fort"
    set ib_unitNameGbk[696] = "��ҹ���������"
    set ib_unitList[697] = 'nvr1'
    set ib_unitName[697] = "暗夜精灵族渔村"
    set ib_unitArmor[697] = "fort"
    set ib_unitNameGbk[697] = "��ҹ���������"
    set ib_unitList[698] = 'nvr2'
    set ib_unitName[698] = "暗夜精灵族渔村"
    set ib_unitArmor[698] = "fort"
    set ib_unitNameGbk[698] = "��ҹ���������"
    set ib_unitList[699] = 'nvul'
    set ib_unitName[699] = "秃鹰"
    set ib_unitArmor[699] = "medium"
    set ib_unitNameGbk[699] = "ͺӥ"
    set ib_unitList[700] = 'nw2w'
    set ib_unitName[700] = "兽族巫师"
    set ib_unitArmor[700] = "large"
    set ib_unitNameGbk[700] = "������ʦ"
    set ib_unitList[701] = 'nwad'
    set ib_unitName[701] = "观察守卫"
    set ib_unitArmor[701] = "medium"
    set ib_unitNameGbk[701] = "�۲�����"
    set ib_unitList[702] = 'nwat'
    set ib_unitName[702] = "岗哨"
    set ib_unitArmor[702] = "large"
    set ib_unitNameGbk[702] = "����"
    set ib_unitList[703] = 'nwc1'
    set ib_unitName[703] = "双足飞龙牢笼"
    set ib_unitArmor[703] = "fort"
    set ib_unitNameGbk[703] = "˫���������"
    set ib_unitList[704] = 'nwc2'
    set ib_unitName[704] = "双足飞龙牢笼"
    set ib_unitArmor[704] = "fort"
    set ib_unitNameGbk[704] = "˫���������"
    set ib_unitList[705] = 'nwe1'
    set ib_unitName[705] = "战鹰"
    set ib_unitArmor[705] = "small"
    set ib_unitNameGbk[705] = "սӥ"
    set ib_unitList[706] = 'nwe2'
    set ib_unitName[706] = "雷霆战鹰"
    set ib_unitArmor[706] = "small"
    set ib_unitNameGbk[706] = "����սӥ"
    set ib_unitList[707] = 'nwe3'
    set ib_unitName[707] = "影子战鹰"
    set ib_unitArmor[707] = "small"
    set ib_unitNameGbk[707] = "Ӱ��սӥ"
    set ib_unitList[708] = 'nwen'
    set ib_unitName[708] = "雪怪"
    set ib_unitArmor[708] = "large"
    set ib_unitNameGbk[708] = "ѩ��"
    set ib_unitList[709] = 'nwgs'
    set ib_unitName[709] = "飞蛇"
    set ib_unitArmor[709] = "small"
    set ib_unitNameGbk[709] = "����"
    set ib_unitList[710] = 'nwgt'
    set ib_unitName[710] = "传送门"
    set ib_unitArmor[710] = "fort"
    set ib_unitNameGbk[710] = "������"
    set ib_unitList[711] = 'nwiz'
    set ib_unitName[711] = "巫师学徒"
    set ib_unitArmor[711] = "medium"
    set ib_unitNameGbk[711] = "��ʦѧͽ"
    set ib_unitList[712] = 'nwld'
    set ib_unitName[712] = "恐怖之狼"
    set ib_unitArmor[712] = "large"
    set ib_unitNameGbk[712] = "�ֲ�֮��"
    set ib_unitList[713] = 'nwlg'
    set ib_unitName[713] = "巨狼"
    set ib_unitArmor[713] = "large"
    set ib_unitNameGbk[713] = "����"
    set ib_unitList[714] = 'nwlt'
    set ib_unitName[714] = "大灰狼"
    set ib_unitArmor[714] = "large"
    set ib_unitNameGbk[714] = "�����"
    set ib_unitList[715] = 'nwna'
    set ib_unitName[715] = "远古雪怪"
    set ib_unitArmor[715] = "large"
    set ib_unitNameGbk[715] = "Զ��ѩ��"
    set ib_unitList[716] = 'nwnr'
    set ib_unitName[716] = "雪怪长者"
    set ib_unitArmor[716] = "large"
    set ib_unitNameGbk[716] = "ѩ�ֳ���"
    set ib_unitList[717] = 'nwns'
    set ib_unitName[717] = "雪怪萨满祭司"
    set ib_unitArmor[717] = "large"
    set ib_unitNameGbk[717] = "ѩ��������˾"
    set ib_unitList[718] = 'nwrg'
    set ib_unitName[718] = "战争傀儡"
    set ib_unitArmor[718] = "large"
    set ib_unitNameGbk[718] = "ս������"
    set ib_unitList[719] = 'nws1'
    set ib_unitName[719] = "龙鹰"
    set ib_unitArmor[719] = "small"
    set ib_unitNameGbk[719] = "��ӥ"
endfunction
function IB_UnitFill9 takes nothing returns nothing
    set ib_unitList[720] = 'nwwd'
    set ib_unitName[720] = "恐怖霜冻之狼"
    set ib_unitArmor[720] = "large"
    set ib_unitNameGbk[720] = "�ֲ�˪��֮��"
    set ib_unitList[721] = 'nwwf'
    set ib_unitName[721] = "霜冻之狼"
    set ib_unitArmor[721] = "large"
    set ib_unitNameGbk[721] = "˪��֮��"
    set ib_unitList[722] = 'nwwg'
    set ib_unitName[722] = "巨型霜冻之狼"
    set ib_unitArmor[722] = "large"
    set ib_unitNameGbk[722] = "����˪��֮��"
    set ib_unitList[723] = 'nwzd'
    set ib_unitName[723] = "黑暗巫师"
    set ib_unitArmor[723] = "large"
    set ib_unitNameGbk[723] = "�ڰ���ʦ"
    set ib_unitList[724] = 'nwzg'
    set ib_unitName[724] = "巫师变节者"
    set ib_unitArmor[724] = "medium"
    set ib_unitNameGbk[724] = "��ʦ�����"
    set ib_unitList[725] = 'nwzr'
    set ib_unitName[725] = "流氓巫师"
    set ib_unitArmor[725] = "medium"
    set ib_unitNameGbk[725] = "��å��ʦ"
    set ib_unitList[726] = 'nzep'
    set ib_unitName[726] = "地精飞艇"
    set ib_unitArmor[726] = "small"
    set ib_unitNameGbk[726] = "�ؾ���ͧ"
    set ib_unitList[727] = 'nzin'
    set ib_unitName[727] = "地区显示"
    set ib_unitArmor[727] = "fort"
    set ib_unitNameGbk[727] = "������ʾ"
    set ib_unitList[728] = 'nzlc'
    set ib_unitName[728] = "巫妖王"
    set ib_unitArmor[728] = "fort"
    set ib_unitNameGbk[728] = "������"
    set ib_unitList[729] = 'nzom'
    set ib_unitName[729] = "僵尸"
    set ib_unitArmor[729] = "medium"
    set ib_unitNameGbk[729] = "��ʬ"
    set ib_unitList[730] = 'oalt'
    set ib_unitName[730] = ""
    set ib_unitArmor[730] = "fort"
    set ib_unitNameGbk[730] = ""
    set ib_unitList[731] = 'obar'
    set ib_unitName[731] = "兵营"
    set ib_unitArmor[731] = "fort"
    set ib_unitNameGbk[731] = "��Ӫ"
    set ib_unitList[732] = 'obea'
    set ib_unitName[732] = "兽栏"
    set ib_unitArmor[732] = "fort"
    set ib_unitNameGbk[732] = "����"
    set ib_unitList[733] = 'obot'
    set ib_unitName[733] = "兽族运输船"
    set ib_unitArmor[733] = "large"
    set ib_unitNameGbk[733] = "�������䴬"
    set ib_unitList[734] = 'ocat'
    set ib_unitName[734] = "粉碎者"
    set ib_unitArmor[734] = "large"
    set ib_unitNameGbk[734] = "������"
    set ib_unitList[735] = 'ocbw'
    set ib_unitName[735] = "邪恶兽族地洞"
    set ib_unitArmor[735] = "large"
    set ib_unitNameGbk[735] = "а������ض�"
    set ib_unitList[736] = 'odes'
    set ib_unitName[736] = "兽族护卫舰"
    set ib_unitArmor[736] = "small"
    set ib_unitNameGbk[736] = "���廤����"
    set ib_unitList[737] = 'odkt'
    set ib_unitName[737] = "德拉克苏尔"
    set ib_unitArmor[737] = "medium"
    set ib_unitNameGbk[737] = "�������ն�"
    set ib_unitList[738] = 'odoc'
    set ib_unitName[738] = "巨魔巫医"
    set ib_unitArmor[738] = "none"
    set ib_unitNameGbk[738] = "��ħ��ҽ"
    set ib_unitList[739] = 'oeye'
    set ib_unitName[739] = "岗哨守卫"
    set ib_unitArmor[739] = "medium"
    set ib_unitNameGbk[739] = "��������"
    set ib_unitList[740] = 'ofor'
    set ib_unitName[740] = "战争磨坊"
    set ib_unitArmor[740] = "fort"
    set ib_unitNameGbk[740] = "ս��ĥ��"
    set ib_unitList[741] = 'ofrt'
    set ib_unitName[741] = "堡垒"
    set ib_unitArmor[741] = "fort"
    set ib_unitNameGbk[741] = "����"
    set ib_unitList[742] = 'ogre'
    set ib_unitName[742] = "大厅"
    set ib_unitArmor[742] = "fort"
    set ib_unitNameGbk[742] = "����"
    set ib_unitList[743] = 'ogrk'
    set ib_unitName[743] = "加索克"
    set ib_unitArmor[743] = "large"
    set ib_unitNameGbk[743] = "������"
    set ib_unitList[744] = 'ogru'
    set ib_unitName[744] = "兽族步兵"
    set ib_unitArmor[744] = "large"
    set ib_unitNameGbk[744] = "���岽��"
    set ib_unitList[745] = 'ohun'
    set ib_unitName[745] = "巨魔猎头者"
    set ib_unitArmor[745] = "medium"
    set ib_unitNameGbk[745] = "��ħ��ͷ��"
    set ib_unitList[746] = 'ohwd'
    set ib_unitName[746] = "治疗守卫"
    set ib_unitArmor[746] = "medium"
    set ib_unitNameGbk[746] = "��������"
    set ib_unitList[747] = 'ojgn'
    set ib_unitName[747] = "兽族魔力战舰"
    set ib_unitArmor[747] = "large"
    set ib_unitNameGbk[747] = "����ħ��ս��"
    set ib_unitList[748] = 'okod'
    set ib_unitName[748] = "科多兽"
    set ib_unitArmor[748] = "none"
    set ib_unitNameGbk[748] = "�ƶ���"
    set ib_unitList[749] = 'omtg'
    set ib_unitName[749] = "马索格"
    set ib_unitArmor[749] = "large"
    set ib_unitNameGbk[749] = "������"
    set ib_unitList[750] = 'onzg'
    set ib_unitName[750] = "那滋盖尔"
    set ib_unitArmor[750] = "medium"
    set ib_unitNameGbk[750] = "���̸Ƕ�"
    set ib_unitList[751] = 'oosc'
    set ib_unitName[751] = "科多兽"
    set ib_unitArmor[751] = "large"
    set ib_unitNameGbk[751] = "�ƶ���"
    set ib_unitList[752] = 'opeo'
    set ib_unitName[752] = "苦工"
    set ib_unitArmor[752] = "medium"
    set ib_unitNameGbk[752] = "�๤"
    set ib_unitList[753] = 'orai'
    set ib_unitName[753] = "掠夺者"
    set ib_unitArmor[753] = "medium"
    set ib_unitNameGbk[753] = "�Ӷ���"
    set ib_unitList[754] = 'oshm'
    set ib_unitName[754] = "萨满祭司"
    set ib_unitArmor[754] = "none"
    set ib_unitNameGbk[754] = "������˾"
    set ib_unitList[755] = 'oshy'
    set ib_unitName[755] = "兽族船坞"
    set ib_unitArmor[755] = "fort"
    set ib_unitNameGbk[755] = "���崬��"
    set ib_unitList[756] = 'osld'
    set ib_unitName[756] = "灵魂归宿"
    set ib_unitArmor[756] = "fort"
    set ib_unitNameGbk[756] = "������"
    set ib_unitList[757] = 'osp1'
    set ib_unitName[757] = "毒蛇守卫"
    set ib_unitArmor[757] = "large"
    set ib_unitNameGbk[757] = "��������"
    set ib_unitList[758] = 'osp2'
    set ib_unitName[758] = "毒蛇守卫"
    set ib_unitArmor[758] = "large"
    set ib_unitNameGbk[758] = "��������"
    set ib_unitList[759] = 'osp3'
    set ib_unitName[759] = "毒蛇守卫"
    set ib_unitArmor[759] = "large"
    set ib_unitNameGbk[759] = "��������"
    set ib_unitList[760] = 'osp4'
    set ib_unitName[760] = "毒蛇守卫"
    set ib_unitArmor[760] = "large"
    set ib_unitNameGbk[760] = "��������"
    set ib_unitList[761] = 'ospm'
    set ib_unitName[761] = "灵魂行者"
    set ib_unitArmor[761] = "none"
    set ib_unitNameGbk[761] = "�������"
    set ib_unitList[762] = 'ospw'
    set ib_unitName[762] = "灵魂行者"
    set ib_unitArmor[762] = "none"
    set ib_unitNameGbk[762] = "�������"
    set ib_unitList[763] = 'ostr'
    set ib_unitName[763] = "要塞"
    set ib_unitArmor[763] = "fort"
    set ib_unitNameGbk[763] = "Ҫ��"
    set ib_unitList[764] = 'osw1'
    set ib_unitName[764] = "幽魂之狼"
    set ib_unitArmor[764] = "large"
    set ib_unitNameGbk[764] = "�Ļ�֮��"
    set ib_unitList[765] = 'osw2'
    set ib_unitName[765] = "恐惧之狼"
    set ib_unitArmor[765] = "large"
    set ib_unitNameGbk[765] = "�־�֮��"
    set ib_unitList[766] = 'osw3'
    set ib_unitName[766] = "阴影之狼"
    set ib_unitArmor[766] = "large"
    set ib_unitNameGbk[766] = "��Ӱ֮��"
    set ib_unitList[767] = 'oswy'
    set ib_unitName[767] = "灵魂飞龙"
    set ib_unitArmor[767] = "small"
    set ib_unitNameGbk[767] = "������"
    set ib_unitList[768] = 'otau'
    set ib_unitName[768] = "牛头人"
    set ib_unitArmor[768] = "large"
    set ib_unitNameGbk[768] = "ţͷ��"
    set ib_unitList[769] = 'otbk'
    set ib_unitName[769] = "巨魔狂暴战士"
    set ib_unitArmor[769] = "medium"
    set ib_unitNameGbk[769] = "��ħ��սʿ"
    set ib_unitList[770] = 'otbr'
    set ib_unitName[770] = "巨魔蝙蝠骑士"
    set ib_unitArmor[770] = "small"
    set ib_unitNameGbk[770] = "��ħ������ʿ"
    set ib_unitList[771] = 'otot'
    set ib_unitName[771] = "静止陷阱"
    set ib_unitArmor[771] = "medium"
    set ib_unitNameGbk[771] = "��ֹ����"
    set ib_unitList[772] = 'otrb'
    set ib_unitName[772] = "兽族地洞"
    set ib_unitArmor[772] = "large"
    set ib_unitNameGbk[772] = "����ض�"
    set ib_unitList[773] = 'otto'
    set ib_unitName[773] = "牛头人图腾"
    set ib_unitArmor[773] = "fort"
    set ib_unitNameGbk[773] = "ţͷ��ͼ��"
    set ib_unitList[774] = 'ovlj'
    set ib_unitName[774] = "沃尔京"
    set ib_unitArmor[774] = "none"
    set ib_unitNameGbk[774] = "�ֶ���"
    set ib_unitList[775] = 'ovln'
    set ib_unitName[775] = "巫毒商店"
    set ib_unitArmor[775] = "fort"
    set ib_unitNameGbk[775] = "�׶��̵�"
    set ib_unitList[776] = 'owar'
    set ib_unitName[776] = "兽族战争首领"
    set ib_unitArmor[776] = "large"
    set ib_unitNameGbk[776] = "����ս������"
    set ib_unitList[777] = 'ownr'
    set ib_unitName[777] = "双足飞龙"
    set ib_unitArmor[777] = "small"
    set ib_unitNameGbk[777] = "˫�����"
    set ib_unitList[778] = 'owtw'
    set ib_unitName[778] = "了望塔"
    set ib_unitArmor[778] = "large"
    set ib_unitNameGbk[778] = "������"
    set ib_unitList[779] = 'owyv'
    set ib_unitName[779] = "风骑士"
    set ib_unitArmor[779] = "small"
    set ib_unitNameGbk[779] = "����ʿ"
    set ib_unitList[780] = 'uabc'
    set ib_unitName[780] = "憎恶"
    set ib_unitArmor[780] = "small"
    set ib_unitNameGbk[780] = "����"
    set ib_unitList[781] = 'uabo'
    set ib_unitName[781] = "憎恶"
    set ib_unitArmor[781] = "large"
    set ib_unitNameGbk[781] = "����"
    set ib_unitList[782] = 'uaco'
    set ib_unitName[782] = "侍僧"
    set ib_unitArmor[782] = "medium"
    set ib_unitNameGbk[782] = "��ɮ"
    set ib_unitList[783] = 'uaod'
    set ib_unitName[783] = "黑暗祭坛"
    set ib_unitArmor[783] = "fort"
    set ib_unitNameGbk[783] = "�ڰ���̳"
    set ib_unitList[784] = 'uarb'
    set ib_unitName[784] = "飞艇"
    set ib_unitArmor[784] = "small"
    set ib_unitNameGbk[784] = "��ͧ"
    set ib_unitList[785] = 'uban'
    set ib_unitName[785] = "女妖"
    set ib_unitArmor[785] = "none"
    set ib_unitNameGbk[785] = "Ů��"
    set ib_unitList[786] = 'ubdd'
    set ib_unitName[786] = "萨皮洛恩"
    set ib_unitArmor[786] = "small"
    set ib_unitNameGbk[786] = "��Ƥ���"
    set ib_unitList[787] = 'ubdr'
    set ib_unitName[787] = "萨皮洛恩"
    set ib_unitArmor[787] = "small"
    set ib_unitNameGbk[787] = "��Ƥ���"
    set ib_unitList[788] = 'ubon'
    set ib_unitName[788] = "埋骨地"
    set ib_unitArmor[788] = "fort"
    set ib_unitNameGbk[788] = "��ǵ�"
    set ib_unitList[789] = 'ubot'
    set ib_unitName[789] = "不死族运输船"
    set ib_unitArmor[789] = "large"
    set ib_unitNameGbk[789] = "���������䴬"
    set ib_unitList[790] = 'ubsp'
    set ib_unitName[790] = "破坏者"
    set ib_unitArmor[790] = "small"
    set ib_unitNameGbk[790] = "�ƻ���"
    set ib_unitList[791] = 'ucrm'
    set ib_unitName[791] = "钻入地下的穴居恶魔"
    set ib_unitArmor[791] = "medium"
    set ib_unitNameGbk[791] = "������µ�Ѩ�Ӷ�ħ"
    set ib_unitList[792] = 'ucry'
    set ib_unitName[792] = "穴居恶魔"
    set ib_unitArmor[792] = "medium"
    set ib_unitNameGbk[792] = "Ѩ�Ӷ�ħ"
    set ib_unitList[793] = 'ucs1'
    set ib_unitName[793] = "腐尸甲虫"
    set ib_unitArmor[793] = "large"
    set ib_unitNameGbk[793] = "��ʬ�׳�"
    set ib_unitList[794] = 'ucs2'
    set ib_unitName[794] = "腐尸甲虫"
    set ib_unitArmor[794] = "large"
    set ib_unitNameGbk[794] = "��ʬ�׳�"
    set ib_unitList[795] = 'ucs3'
    set ib_unitName[795] = "腐尸甲虫"
    set ib_unitArmor[795] = "large"
    set ib_unitNameGbk[795] = "��ʬ�׳�"
    set ib_unitList[796] = 'ucsB'
    set ib_unitName[796] = "钻入地下的腐尸甲虫"
    set ib_unitArmor[796] = "large"
    set ib_unitNameGbk[796] = "������µĸ�ʬ�׳�"
    set ib_unitList[797] = 'ucsC'
    set ib_unitName[797] = "钻入地下的腐尸甲虫"
    set ib_unitArmor[797] = "large"
    set ib_unitNameGbk[797] = "������µĸ�ʬ�׳�"
    set ib_unitList[798] = 'udes'
    set ib_unitName[798] = "不死族族护卫舰"
    set ib_unitArmor[798] = "small"
    set ib_unitNameGbk[798] = "�������廤����"
    set ib_unitList[799] = 'ufro'
    set ib_unitName[799] = "冰霜巨龙"
    set ib_unitArmor[799] = "small"
    set ib_unitNameGbk[799] = "��˪����"
endfunction
function IB_UnitFill10 takes nothing returns nothing
    set ib_unitList[800] = 'ugar'
    set ib_unitName[800] = "石像鬼"
    set ib_unitArmor[800] = "none"
    set ib_unitNameGbk[800] = "ʯ���"
    set ib_unitList[801] = 'ugho'
    set ib_unitName[801] = "食尸鬼"
    set ib_unitArmor[801] = "large"
    set ib_unitNameGbk[801] = "ʳʬ��"
    set ib_unitList[802] = 'ugol'
    set ib_unitName[802] = "闹鬼金矿"
    set ib_unitArmor[802] = "fort"
    set ib_unitNameGbk[802] = "�ֹ����"
    set ib_unitList[803] = 'ugrm'
    set ib_unitName[803] = "石像形态下的石像鬼"
    set ib_unitArmor[803] = "none"
    set ib_unitNameGbk[803] = "ʯ����̬�µ�ʯ���"
    set ib_unitList[804] = 'ugrv'
    set ib_unitName[804] = "坟场"
    set ib_unitArmor[804] = "fort"
    set ib_unitNameGbk[804] = "�س�"
    set ib_unitList[805] = 'uktg'
    set ib_unitName[805] = "克尔苏加德"
    set ib_unitArmor[805] = "large"
    set ib_unitNameGbk[805] = "�˶��ռӵ�"
    set ib_unitList[806] = 'uktn'
    set ib_unitName[806] = "克尔苏加德"
    set ib_unitArmor[806] = "large"
    set ib_unitNameGbk[806] = "�˶��ռӵ�"
    set ib_unitList[807] = 'uloc'
    set ib_unitName[807] = "蝗虫"
    set ib_unitArmor[807] = "small"
    set ib_unitNameGbk[807] = "�ȳ�"
    set ib_unitList[808] = 'umtw'
    set ib_unitName[808] = "绞肉车"
    set ib_unitArmor[808] = "large"
    set ib_unitNameGbk[808] = "���⳵"
    set ib_unitList[809] = 'unec'
    set ib_unitName[809] = "不死族巫师"
    set ib_unitArmor[809] = "none"
    set ib_unitNameGbk[809] = "��������ʦ"
    set ib_unitList[810] = 'unp1'
    set ib_unitName[810] = "亡者大厅"
    set ib_unitArmor[810] = "fort"
    set ib_unitNameGbk[810] = "���ߴ���"
    set ib_unitList[811] = 'unp2'
    set ib_unitName[811] = "黑色城堡"
    set ib_unitArmor[811] = "fort"
    set ib_unitNameGbk[811] = "��ɫ�Ǳ�"
    set ib_unitList[812] = 'unpl'
    set ib_unitName[812] = "大墓地"
    set ib_unitArmor[812] = "fort"
    set ib_unitNameGbk[812] = "��Ĺ��"
    set ib_unitList[813] = 'uobs'
    set ib_unitName[813] = "十胜石雕像"
    set ib_unitArmor[813] = "large"
    set ib_unitNameGbk[813] = "ʮʤʯ����"
    set ib_unitList[814] = 'uplg'
    set ib_unitName[814] = "疾病云雾"
    set ib_unitArmor[814] = "medium"
    set ib_unitNameGbk[814] = "��������"
    set ib_unitList[815] = 'usap'
    set ib_unitName[815] = "牺牲深渊"
    set ib_unitArmor[815] = "fort"
    set ib_unitNameGbk[815] = "������Ԩ"
    set ib_unitList[816] = 'usep'
    set ib_unitName[816] = "地穴"
    set ib_unitArmor[816] = "fort"
    set ib_unitNameGbk[816] = "��Ѩ"
    set ib_unitList[817] = 'ushd'
    set ib_unitName[817] = "阴影"
    set ib_unitArmor[817] = "medium"
    set ib_unitNameGbk[817] = "��Ӱ"
    set ib_unitList[818] = 'ushp'
    set ib_unitName[818] = "不死族船坞"
    set ib_unitArmor[818] = "fort"
    set ib_unitNameGbk[818] = "�����崬��"
    set ib_unitList[819] = 'uske'
    set ib_unitName[819] = "骷髅战士"
    set ib_unitArmor[819] = "large"
    set ib_unitNameGbk[819] = "����սʿ"
    set ib_unitList[820] = 'uskm'
    set ib_unitName[820] = "骷髅魔法师"
    set ib_unitArmor[820] = "medium"
    set ib_unitNameGbk[820] = "����ħ��ʦ"
    set ib_unitList[821] = 'uslh'
    set ib_unitName[821] = "屠宰场"
    set ib_unitArmor[821] = "fort"
    set ib_unitNameGbk[821] = "���׳�"
    set ib_unitList[822] = 'uswb'
    set ib_unitName[822] = "追风之西尔瓦娜斯"
    set ib_unitArmor[822] = "medium"
    set ib_unitNameGbk[822] = "׷��֮��������˹"
    set ib_unitList[823] = 'utod'
    set ib_unitName[823] = "诅咒神庙"
    set ib_unitArmor[823] = "fort"
    set ib_unitNameGbk[823] = "��������"
    set ib_unitList[824] = 'utom'
    set ib_unitName[824] = "古墓废墟"
    set ib_unitArmor[824] = "fort"
    set ib_unitNameGbk[824] = "��Ĺ����"
    set ib_unitList[825] = 'uubs'
    set ib_unitName[825] = "不死族战舰"
    set ib_unitArmor[825] = "large"
    set ib_unitNameGbk[825] = "������ս��"
    set ib_unitList[826] = 'uzg1'
    set ib_unitName[826] = "幽魂之塔"
    set ib_unitArmor[826] = "fort"
    set ib_unitNameGbk[826] = "�Ļ�֮��"
    set ib_unitList[827] = 'uzg2'
    set ib_unitName[827] = "蛛网怪塔"
    set ib_unitArmor[827] = "fort"
    set ib_unitNameGbk[827] = "��������"
    set ib_unitList[828] = 'uzig'
    set ib_unitName[828] = "通灵塔"
    set ib_unitArmor[828] = "fort"
    set ib_unitNameGbk[828] = "ͨ����"
    set ib_unitList[829] = 'zcso'
    set ib_unitName[829] = "空间邪恶兽族"
    set ib_unitArmor[829] = "medium"
    set ib_unitNameGbk[829] = "�ռ�а������"
    set ib_unitList[830] = 'zhyd'
    set ib_unitName[830] = "刺蛇"
    set ib_unitArmor[830] = "medium"
    set ib_unitNameGbk[830] = "����"
    set ib_unitList[831] = 'zjug'
    set ib_unitName[831] = "兽族魔力战舰"
    set ib_unitArmor[831] = "small"
    set ib_unitNameGbk[831] = "����ħ��ս��"
    set ib_unitList[832] = 'zmar'
    set ib_unitName[832] = "马里恩"
    set ib_unitArmor[832] = "medium"
    set ib_unitNameGbk[832] = "�����"
    set ib_unitList[833] = 'zshv'
    set ib_unitName[833] = "小鬼挖掘者"
    set ib_unitArmor[833] = "medium"
    set ib_unitNameGbk[833] = "С���ھ���"
    set ib_unitList[834] = 'zsmc'
    set ib_unitName[834] = "大兵"
    set ib_unitArmor[834] = "medium"
    set ib_unitNameGbk[834] = "���"
    set ib_unitList[835] = 'zzrg'
    set ib_unitName[835] = "小狗"
    set ib_unitArmor[835] = "medium"
    set ib_unitNameGbk[835] = "С��"
endfunction

function IB_FillStep takes nothing returns nothing
    if ib_fillIdx == 0 then
        call IB_Fill0()
    elseif ib_fillIdx == 1 then
        call IB_Fill1()
    elseif ib_fillIdx == 2 then
        call IB_Fill2()
    elseif ib_fillIdx == 3 then
        call IB_Fill3()
    endif
    set ib_fillIdx = ib_fillIdx + 1
    if ib_fillIdx >= ib_fillTotal then
        set ib_itemCount = 273
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
    endif
    set ib_skFillIdx = ib_skFillIdx + 1
    if ib_skFillIdx >= ib_skFillTotal then
        set ib_skillCount = 817
        call PauseTimer(ib_skFillTimer)
        call DestroyTimer(ib_skFillTimer)
        set ib_skFillTimer = null
    endif
endfunction

function IB_UnitFillStep takes nothing returns nothing
    if ib_unFillIdx == 0 then
        call IB_UnitFill0()
    elseif ib_unFillIdx == 1 then
        call IB_UnitFill1()
    elseif ib_unFillIdx == 2 then
        call IB_UnitFill2()
    elseif ib_unFillIdx == 3 then
        call IB_UnitFill3()
    elseif ib_unFillIdx == 4 then
        call IB_UnitFill4()
    elseif ib_unFillIdx == 5 then
        call IB_UnitFill5()
    elseif ib_unFillIdx == 6 then
        call IB_UnitFill6()
    elseif ib_unFillIdx == 7 then
        call IB_UnitFill7()
    elseif ib_unFillIdx == 8 then
        call IB_UnitFill8()
    elseif ib_unFillIdx == 9 then
        call IB_UnitFill9()
    elseif ib_unFillIdx == 10 then
        call IB_UnitFill10()
    endif
    set ib_unFillIdx = ib_unFillIdx + 1
    if ib_unFillIdx >= ib_unFillTotal then
        set ib_unitCount = 836
        call PauseTimer(ib_unFillTimer)
        call DestroyTimer(ib_unFillTimer)
        set ib_unFillTimer = null
    endif
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    set ib_skillCount = 0
    set ib_unitCount = 0
    call IB_RegisterChat()
    set ib_fillIdx = 0
    set ib_fillTotal = 4
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 11
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    set ib_unFillIdx = 0
    set ib_unFillTotal = 11
    set ib_unFillTimer = CreateTimer()
    call TimerStart(ib_unFillTimer, 0.01, true, function IB_UnitFillStep)
    call IB_CritInit()
    call IB_FingerCastInit()
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
