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

//---------------------------------------------------------------------------
// 移除选中单位的全部技能（分帧遍历技能列表，逐个检测并移除）
// JASS 1.27 无法直接枚举单位技能，故遍历内嵌技能表 + GetUnitAbilityLevel 检测
//---------------------------------------------------------------------------
function IB_RemoveAllSkillStep takes nothing returns nothing
    local integer n = 0
    local integer lvl
    loop
        exitwhen ib_skClrIdx >= ib_skillCount or n >= 60
        set lvl = GetUnitAbilityLevel(ib_skClrUnit, ib_skillList[ib_skClrIdx])
        if lvl > 0 then
            call UnitRemoveAbility(ib_skClrUnit, ib_skillList[ib_skClrIdx])
            set ib_skClrCount = ib_skClrCount + 1
        endif
        set ib_skClrIdx = ib_skClrIdx + 1
        set n = n + 1
    endloop
    if ib_skClrIdx >= ib_skillCount then
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
// 加权表（概率加和 = 100%，单次掷骰命中一档）:
//   50%  x2    30%  x3    10%  x4    4%   x5
//   3%   x10   2%   x50   1%   x100
//   期望倍率 EV = 4.8x
//   —— 如需调整数值，只改下面 IB_CritRoll 里的阈值即可。
//===========================================================================

// 掷骰：返回本次暴击倍率（>=2 表示暴击）
// 单次掷骰加权表，累计概率: 50/80/90/94/97/99/100
function IB_CritRoll takes nothing returns integer
    local integer r = GetRandomInt(1, 100)
    if r <= 50 then
        return 2
    elseif r <= 80 then
        return 3
    elseif r <= 90 then
        return 4
    elseif r <= 94 then
        return 5
    elseif r <= 97 then
        return 10
    elseif r <= 99 then
        return 50
    endif
    return 100
endfunction

// 攻击事件: 记录攻击者/目标，标记"下一次伤害可能来自普攻"
function IB_CritOnAttack takes nothing returns nothing
    set ib_critAttacker = GetAttacker()
    set ib_critTarget = GetTriggerUnit()
    set ib_critArmed = true
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
    set bonus = dmg * I2R(mult - 1)
    set ib_critBusy = true
    call UnitDamageTarget(src, tgt, bonus, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    set ib_critBusy = false

    set ib_critCount = ib_critCount + 1
    set ib_critLastMult = mult
    // 只在暴击倍率较高时提示，避免刷屏
    if mult >= 5 then
        call DisplayTextToPlayer(GetOwningPlayer(src), 0, 0, "|cffff2020[暴击]|r x" + I2S(mult) + "  (" + R2S(dmg) + " + " + R2S(bonus) + ")")
    endif
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
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call UnitAddAbility(u, ib_critAbility)
    call UnitMakeAbilityPermanent(u, true, ib_critAbility)
    call IB_SkillMessage(p, "已给 " + GetUnitName(u) + " 添加【致命一击】技能（技能栏）")
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
        call TriggerRegisterPlayerChatEvent(t, Player(i), "finger", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeallskill", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingeradd", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest2", false)
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

function IB_UnitFill0 takes nothing returns nothing
    set ib_unitList[0] = 'E001'
    set ib_unitName[0] = "风少爷"
    set ib_unitArmor[0] = "hero"
    set ib_unitNameGbk[0] = "����ү"
    set ib_unitList[1] = 'E002'
    set ib_unitName[1] = "风少爷"
    set ib_unitArmor[1] = "hero"
    set ib_unitNameGbk[1] = "����ү"
    set ib_unitList[2] = 'E00H'
    set ib_unitName[2] = "鬼龙"
    set ib_unitArmor[2] = "none"
    set ib_unitNameGbk[2] = "����"
    set ib_unitList[3] = 'E00I'
    set ib_unitName[3] = "魔界左护法"
    set ib_unitArmor[3] = "none"
    set ib_unitNameGbk[3] = "ħ���󻤷�"
    set ib_unitList[4] = 'E00J'
    set ib_unitName[4] = "魔界右护法"
    set ib_unitArmor[4] = "none"
    set ib_unitNameGbk[4] = "ħ���һ���"
    set ib_unitList[5] = 'E00Q'
    set ib_unitName[5] = "青龙"
    set ib_unitArmor[5] = "none"
    set ib_unitNameGbk[5] = "����"
    set ib_unitList[6] = 'E00W'
    set ib_unitName[6] = "朱雀"
    set ib_unitArmor[6] = "none"
    set ib_unitNameGbk[6] = "��ȸ"
    set ib_unitList[7] = 'E012'
    set ib_unitName[7] = "白虎"
    set ib_unitArmor[7] = "none"
    set ib_unitNameGbk[7] = "�׻�"
    set ib_unitList[8] = 'E018'
    set ib_unitName[8] = "玄武"
    set ib_unitArmor[8] = "none"
    set ib_unitNameGbk[8] = "����"
    set ib_unitList[9] = 'E01Q'
    set ib_unitName[9] = "牛头人"
    set ib_unitArmor[9] = "hero"
    set ib_unitNameGbk[9] = "ţͷ��"
    set ib_unitList[10] = 'E01R'
    set ib_unitName[10] = "暗黑恶魔"
    set ib_unitArmor[10] = "hero"
    set ib_unitNameGbk[10] = "���ڶ�ħ"
    set ib_unitList[11] = 'E01S'
    set ib_unitName[11] = "牛头人"
    set ib_unitArmor[11] = "hero"
    set ib_unitNameGbk[11] = "ţͷ��"
    set ib_unitList[12] = 'E01T'
    set ib_unitName[12] = "暗黑恶魔"
    set ib_unitArmor[12] = "hero"
    set ib_unitNameGbk[12] = "���ڶ�ħ"
    set ib_unitList[13] = 'E027'
    set ib_unitName[13] = "影子冷锋"
    set ib_unitArmor[13] = "none"
    set ib_unitNameGbk[13] = "Ӱ�����"
    set ib_unitList[14] = 'Edem'
    set ib_unitName[14] = "风少爷"
    set ib_unitArmor[14] = "hero"
    set ib_unitNameGbk[14] = "����ү"
    set ib_unitList[15] = 'Edmm'
    set ib_unitName[15] = "恶魔猎手"
    set ib_unitArmor[15] = "hero"
    set ib_unitNameGbk[15] = "��ħ����"
    set ib_unitList[16] = 'Eevi'
    set ib_unitName[16] = "幕后黑手"
    set ib_unitArmor[16] = "none"
    set ib_unitNameGbk[16] = "Ļ�����"
    set ib_unitList[17] = 'Eill'
    set ib_unitName[17] = "暗黑恶魔"
    set ib_unitArmor[17] = "hero"
    set ib_unitNameGbk[17] = "���ڶ�ħ"
    set ib_unitList[18] = 'Ekee'
    set ib_unitName[18] = "丛林守护者"
    set ib_unitArmor[18] = "hero"
    set ib_unitNameGbk[18] = "�����ػ���"
    set ib_unitList[19] = 'Emoo'
    set ib_unitName[19] = "月之女祭司"
    set ib_unitArmor[19] = "hero"
    set ib_unitNameGbk[19] = "��֮Ů��˾"
    set ib_unitList[20] = 'Ewar'
    set ib_unitName[20] = "牛头人"
    set ib_unitArmor[20] = "hero"
    set ib_unitNameGbk[20] = "ţͷ��"
    set ib_unitList[21] = 'H00X'
    set ib_unitName[21] = "圣骑士"
    set ib_unitArmor[21] = "hero"
    set ib_unitNameGbk[21] = "ʥ��ʿ"
    set ib_unitList[22] = 'H00Y'
    set ib_unitName[22] = "血魔法师"
    set ib_unitArmor[22] = "hero"
    set ib_unitNameGbk[22] = "Ѫħ��ʦ"
    set ib_unitList[23] = 'H00Z'
    set ib_unitName[23] = "大魔法师"
    set ib_unitArmor[23] = "hero"
    set ib_unitNameGbk[23] = "��ħ��ʦ"
    set ib_unitList[24] = 'H010'
    set ib_unitName[24] = "山丘之王"
    set ib_unitArmor[24] = "hero"
    set ib_unitNameGbk[24] = "ɽ��֮��"
    set ib_unitList[25] = 'H01D'
    set ib_unitName[25] = "圣骑士"
    set ib_unitArmor[25] = "hero"
    set ib_unitNameGbk[25] = "ʥ��ʿ"
    set ib_unitList[26] = 'H01E'
    set ib_unitName[26] = "山丘之王"
    set ib_unitArmor[26] = "hero"
    set ib_unitNameGbk[26] = "ɽ��֮��"
    set ib_unitList[27] = 'H01F'
    set ib_unitName[27] = "血魔法师"
    set ib_unitArmor[27] = "hero"
    set ib_unitNameGbk[27] = "Ѫħ��ʦ"
    set ib_unitList[28] = 'H01G'
    set ib_unitName[28] = "大魔法师"
    set ib_unitArmor[28] = "hero"
    set ib_unitNameGbk[28] = "��ħ��ʦ"
    set ib_unitList[29] = 'Hamg'
    set ib_unitName[29] = "神界神王"
    set ib_unitArmor[29] = "hero"
    set ib_unitNameGbk[29] = "�������"
    set ib_unitList[30] = 'Harf'
    set ib_unitName[30] = "圣骑士"
    set ib_unitArmor[30] = "hero"
    set ib_unitNameGbk[30] = "ʥ��ʿ"
    set ib_unitList[31] = 'Hart'
    set ib_unitName[31] = "圣骑士"
    set ib_unitArmor[31] = "hero"
    set ib_unitNameGbk[31] = "ʥ��ʿ"
    set ib_unitList[32] = 'Hblm'
    set ib_unitName[32] = "血魔法师"
    set ib_unitArmor[32] = "hero"
    set ib_unitNameGbk[32] = "Ѫħ��ʦ"
    set ib_unitList[33] = 'Hjai'
    set ib_unitName[33] = "大魔法师"
    set ib_unitArmor[33] = "hero"
    set ib_unitNameGbk[33] = "��ħ��ʦ"
    set ib_unitList[34] = 'Hmkg'
    set ib_unitName[34] = "山丘之王"
    set ib_unitArmor[34] = "hero"
    set ib_unitNameGbk[34] = "ɽ��֮��"
    set ib_unitList[35] = 'Hpal'
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
    set ib_unitList[38] = 'N00C'
    set ib_unitName[38] = "赵灵儿"
    set ib_unitArmor[38] = "hero"
    set ib_unitNameGbk[38] = "�����"
    set ib_unitList[39] = 'N00W'
    set ib_unitName[39] = "赵灵儿"
    set ib_unitArmor[39] = "hero"
    set ib_unitNameGbk[39] = "�����"
    set ib_unitList[40] = 'N01Y'
    set ib_unitName[40] = "火焰巨魔"
    set ib_unitArmor[40] = "hero"
    set ib_unitNameGbk[40] = "�����ħ"
    set ib_unitList[41] = 'Nal2'
    set ib_unitName[41] = "炼金术士"
    set ib_unitArmor[41] = "hero"
    set ib_unitNameGbk[41] = "������ʿ"
    set ib_unitList[42] = 'Nal3'
    set ib_unitName[42] = "炼金术士"
    set ib_unitArmor[42] = "hero"
    set ib_unitNameGbk[42] = "������ʿ"
    set ib_unitList[43] = 'Nalc'
    set ib_unitName[43] = "炼金术士"
    set ib_unitArmor[43] = "hero"
    set ib_unitNameGbk[43] = "������ʿ"
    set ib_unitList[44] = 'Nalm'
    set ib_unitName[44] = "炼金术士"
    set ib_unitArmor[44] = "hero"
    set ib_unitNameGbk[44] = "������ʿ"
    set ib_unitList[45] = 'Nbbc'
    set ib_unitName[45] = "剑圣"
    set ib_unitArmor[45] = "hero"
    set ib_unitNameGbk[45] = "��ʥ"
    set ib_unitList[46] = 'Nklj'
    set ib_unitName[46] = "魔界魔王"
    set ib_unitArmor[46] = "hero"
    set ib_unitNameGbk[46] = "ħ��ħ��"
    set ib_unitList[47] = 'Nman'
    set ib_unitName[47] = "深渊魔王"
    set ib_unitArmor[47] = "hero"
    set ib_unitNameGbk[47] = "��Ԩħ��"
    set ib_unitList[48] = 'Nsjs'
    set ib_unitName[48] = "熊猫酒仙"
    set ib_unitArmor[48] = "hero"
    set ib_unitNameGbk[48] = "��è����"
    set ib_unitList[49] = 'Ntin'
    set ib_unitName[49] = "赵灵儿"
    set ib_unitArmor[49] = "hero"
    set ib_unitNameGbk[49] = "�����"
    set ib_unitList[50] = 'O000'
    set ib_unitName[50] = "毁灭之王"
    set ib_unitArmor[50] = "hero"
    set ib_unitNameGbk[50] = "����֮��"
    set ib_unitList[51] = 'O001'
    set ib_unitName[51] = "血精灵剑圣"
    set ib_unitArmor[51] = "hero"
    set ib_unitNameGbk[51] = "Ѫ���齣ʥ"
    set ib_unitList[52] = 'O002'
    set ib_unitName[52] = "血精灵剑圣"
    set ib_unitArmor[52] = "hero"
    set ib_unitNameGbk[52] = "Ѫ���齣ʥ"
    set ib_unitList[53] = 'O003'
    set ib_unitName[53] = "血精灵剑圣"
    set ib_unitArmor[53] = "hero"
    set ib_unitNameGbk[53] = "Ѫ���齣ʥ"
    set ib_unitList[54] = 'O00M'
    set ib_unitName[54] = "赛特斯之王"
    set ib_unitArmor[54] = "hero"
    set ib_unitNameGbk[54] = "����˹֮��"
    set ib_unitList[55] = 'O00N'
    set ib_unitName[55] = "憎恶之王"
    set ib_unitArmor[55] = "hero"
    set ib_unitNameGbk[55] = "����֮��"
    set ib_unitList[56] = 'O00O'
    set ib_unitName[56] = "幽灵之王"
    set ib_unitArmor[56] = "hero"
    set ib_unitNameGbk[56] = "����֮��"
    set ib_unitList[57] = 'O00P'
    set ib_unitName[57] = "剑圣"
    set ib_unitArmor[57] = "hero"
    set ib_unitNameGbk[57] = "��ʥ"
    set ib_unitList[58] = 'O00Q'
    set ib_unitName[58] = "先知"
    set ib_unitArmor[58] = "hero"
    set ib_unitNameGbk[58] = "��֪"
    set ib_unitList[59] = 'O00R'
    set ib_unitName[59] = "剑圣"
    set ib_unitArmor[59] = "hero"
    set ib_unitNameGbk[59] = "��ʥ"
    set ib_unitList[60] = 'O00S'
    set ib_unitName[60] = "先知"
    set ib_unitArmor[60] = "hero"
    set ib_unitNameGbk[60] = "��֪"
    set ib_unitList[61] = 'Obla'
    set ib_unitName[61] = "剑圣"
    set ib_unitArmor[61] = "hero"
    set ib_unitNameGbk[61] = "��ʥ"
    set ib_unitList[62] = 'Ocb2'
    set ib_unitName[62] = "牛头人酋长"
    set ib_unitArmor[62] = "hero"
    set ib_unitNameGbk[62] = "ţͷ������"
    set ib_unitList[63] = 'Ocbh'
    set ib_unitName[63] = "牛头人酋长"
    set ib_unitArmor[63] = "hero"
    set ib_unitNameGbk[63] = "ţͷ������"
    set ib_unitList[64] = 'Odrt'
    set ib_unitName[64] = "先知"
    set ib_unitArmor[64] = "hero"
    set ib_unitNameGbk[64] = "��֪"
    set ib_unitList[65] = 'Ofar'
    set ib_unitName[65] = "先知"
    set ib_unitArmor[65] = "hero"
    set ib_unitNameGbk[65] = "��֪"
    set ib_unitList[66] = 'Ogld'
    set ib_unitName[66] = "巫师"
    set ib_unitArmor[66] = "hero"
    set ib_unitNameGbk[66] = "��ʦ"
    set ib_unitList[67] = 'Ogrh'
    set ib_unitName[67] = "剑圣"
    set ib_unitArmor[67] = "hero"
    set ib_unitNameGbk[67] = "��ʥ"
    set ib_unitList[68] = 'Opgh'
    set ib_unitName[68] = "剑圣"
    set ib_unitArmor[68] = "hero"
    set ib_unitNameGbk[68] = "��ʥ"
    set ib_unitList[69] = 'Orex'
    set ib_unitName[69] = "驯兽师"
    set ib_unitArmor[69] = "hero"
    set ib_unitNameGbk[69] = "ѱ��ʦ"
    set ib_unitList[70] = 'Orkn'
    set ib_unitName[70] = "暗影猎手"
    set ib_unitArmor[70] = "hero"
    set ib_unitNameGbk[70] = "��Ӱ����"
    set ib_unitList[71] = 'Osam'
    set ib_unitName[71] = "剑圣"
    set ib_unitArmor[71] = "hero"
    set ib_unitNameGbk[71] = "��ʥ"
    set ib_unitList[72] = 'Oshd'
    set ib_unitName[72] = "暗影猎手"
    set ib_unitArmor[72] = "hero"
    set ib_unitNameGbk[72] = "��Ӱ����"
    set ib_unitList[73] = 'Otch'
    set ib_unitName[73] = "牛头人酋长"
    set ib_unitArmor[73] = "hero"
    set ib_unitNameGbk[73] = "ţͷ������"
    set ib_unitList[74] = 'Othr'
    set ib_unitName[74] = "先知"
    set ib_unitArmor[74] = "hero"
    set ib_unitNameGbk[74] = "��֪"
    set ib_unitList[75] = 'U002'
    set ib_unitName[75] = "巫妖"
    set ib_unitArmor[75] = "hero"
    set ib_unitNameGbk[75] = "����"
    set ib_unitList[76] = 'U003'
    set ib_unitName[76] = "恐惧魔王"
    set ib_unitArmor[76] = "hero"
    set ib_unitNameGbk[76] = "�־�ħ��"
    set ib_unitList[77] = 'U004'
    set ib_unitName[77] = "黑暗游侠"
    set ib_unitArmor[77] = "hero"
    set ib_unitNameGbk[77] = "�ڰ�����"
    set ib_unitList[78] = 'U007'
    set ib_unitName[78] = "巫妖"
    set ib_unitArmor[78] = "hero"
    set ib_unitNameGbk[78] = "����"
    set ib_unitList[79] = 'U008'
    set ib_unitName[79] = "恐惧魔王"
    set ib_unitArmor[79] = "hero"
    set ib_unitNameGbk[79] = "�־�ħ��"
endfunction
function IB_UnitFill1 takes nothing returns nothing
    set ib_unitList[80] = 'U009'
    set ib_unitName[80] = "黑暗游侠"
    set ib_unitArmor[80] = "hero"
    set ib_unitNameGbk[80] = "�ڰ�����"
    set ib_unitList[81] = 'Ucrl'
    set ib_unitName[81] = "地穴领主"
    set ib_unitArmor[81] = "hero"
    set ib_unitNameGbk[81] = "��Ѩ����"
    set ib_unitList[82] = 'Udea'
    set ib_unitName[82] = "死亡骑士"
    set ib_unitArmor[82] = "hero"
    set ib_unitNameGbk[82] = "������ʿ"
    set ib_unitList[83] = 'Udre'
    set ib_unitName[83] = "恐惧魔王"
    set ib_unitArmor[83] = "hero"
    set ib_unitNameGbk[83] = "�־�ħ��"
    set ib_unitList[84] = 'Uear'
    set ib_unitName[84] = "死亡骑士"
    set ib_unitArmor[84] = "hero"
    set ib_unitNameGbk[84] = "������ʿ"
    set ib_unitList[85] = 'Uktl'
    set ib_unitName[85] = "巫妖"
    set ib_unitArmor[85] = "hero"
    set ib_unitNameGbk[85] = "����"
    set ib_unitList[86] = 'Ulic'
    set ib_unitName[86] = "巫妖"
    set ib_unitArmor[86] = "hero"
    set ib_unitNameGbk[86] = "����"
    set ib_unitList[87] = 'Usyl'
    set ib_unitName[87] = "黑暗游侠"
    set ib_unitArmor[87] = "hero"
    set ib_unitNameGbk[87] = "�ڰ�����"
    set ib_unitList[88] = 'Uwar'
    set ib_unitName[88] = "魔界魔王"
    set ib_unitArmor[88] = "hero"
    set ib_unitNameGbk[88] = "ħ��ħ��"
    set ib_unitList[89] = 'e000'
    set ib_unitName[89] = "合成飞哥龙神甲<gm>"
    set ib_unitArmor[89] = "medium"
    set ib_unitNameGbk[89] = "�ϳɷɸ������<gm>"
    set ib_unitList[90] = 'e003'
    set ib_unitName[90] = "龙王神"
    set ib_unitArmor[90] = "divine"
    set ib_unitNameGbk[90] = "������"
    set ib_unitList[91] = 'e004'
    set ib_unitName[91] = "龙王神"
    set ib_unitArmor[91] = "divine"
    set ib_unitNameGbk[91] = "������"
    set ib_unitList[92] = 'e005'
    set ib_unitName[92] = "牛头人"
    set ib_unitArmor[92] = "divine"
    set ib_unitNameGbk[92] = "ţͷ��"
    set ib_unitList[93] = 'e006'
    set ib_unitName[93] = "牛头人"
    set ib_unitArmor[93] = "divine"
    set ib_unitNameGbk[93] = "ţͷ��"
    set ib_unitList[94] = 'e007'
    set ib_unitName[94] = "牛头人"
    set ib_unitArmor[94] = "divine"
    set ib_unitNameGbk[94] = "ţͷ��"
    set ib_unitList[95] = 'e008'
    set ib_unitName[95] = "牛头人"
    set ib_unitArmor[95] = "divine"
    set ib_unitNameGbk[95] = "ţͷ��"
    set ib_unitList[96] = 'e009'
    set ib_unitName[96] = "牛头人"
    set ib_unitArmor[96] = "divine"
    set ib_unitNameGbk[96] = "ţͷ��"
    set ib_unitList[97] = 'e00A'
    set ib_unitName[97] = "龙王神"
    set ib_unitArmor[97] = "divine"
    set ib_unitNameGbk[97] = "������"
    set ib_unitList[98] = 'e00B'
    set ib_unitName[98] = "龙王神"
    set ib_unitArmor[98] = "divine"
    set ib_unitNameGbk[98] = "������"
    set ib_unitList[99] = 'e00C'
    set ib_unitName[99] = "龙王神"
    set ib_unitArmor[99] = "divine"
    set ib_unitNameGbk[99] = "������"
    set ib_unitList[100] = 'e00D'
    set ib_unitName[100] = "龙王神"
    set ib_unitArmor[100] = "divine"
    set ib_unitNameGbk[100] = "������"
    set ib_unitList[101] = 'e00E'
    set ib_unitName[101] = "召唤龙王神<二转技能>"
    set ib_unitArmor[101] = "medium"
    set ib_unitNameGbk[101] = "�ٻ�������<��ת����>"
    set ib_unitList[102] = 'e00F'
    set ib_unitName[102] = "小精灵"
    set ib_unitArmor[102] = "medium"
    set ib_unitNameGbk[102] = "С����"
    set ib_unitList[103] = 'e00G'
    set ib_unitName[103] = "小精灵"
    set ib_unitArmor[103] = "medium"
    set ib_unitNameGbk[103] = "С����"
    set ib_unitList[104] = 'e00K'
    set ib_unitName[104] = "狂暴霜冻"
    set ib_unitArmor[104] = "medium"
    set ib_unitNameGbk[104] = "��˪��"
    set ib_unitList[105] = 'e00L'
    set ib_unitName[105] = "闪电剑刃"
    set ib_unitArmor[105] = "medium"
    set ib_unitNameGbk[105] = "���罣��"
    set ib_unitList[106] = 'e00M'
    set ib_unitName[106] = "升级国王之冠"
    set ib_unitArmor[106] = "medium"
    set ib_unitNameGbk[106] = "��������֮��"
    set ib_unitList[107] = 'e00N'
    set ib_unitName[107] = "升级攻击之爪"
    set ib_unitArmor[107] = "medium"
    set ib_unitNameGbk[107] = "��������֮צ"
    set ib_unitList[108] = 'e00O'
    set ib_unitName[108] = "升级火焰手套"
    set ib_unitArmor[108] = "medium"
    set ib_unitNameGbk[108] = "������������"
    set ib_unitList[109] = 'e00P'
    set ib_unitName[109] = "升级灼热之刀"
    set ib_unitArmor[109] = "medium"
    set ib_unitNameGbk[109] = "��������֮��"
    set ib_unitList[110] = 'e00R'
    set ib_unitName[110] = "升级远古战斧"
    set ib_unitArmor[110] = "medium"
    set ib_unitNameGbk[110] = "����Զ��ս��"
    set ib_unitList[111] = 'e00S'
    set ib_unitName[111] = "合成邪神战斧"
    set ib_unitArmor[111] = "medium"
    set ib_unitNameGbk[111] = "�ϳ�а��ս��"
    set ib_unitList[112] = 'e00T'
    set ib_unitName[112] = "合成疯魔之爪"
    set ib_unitArmor[112] = "medium"
    set ib_unitNameGbk[112] = "�ϳɷ�ħ֮צ"
    set ib_unitList[113] = 'e00U'
    set ib_unitName[113] = "合成神圣之冠"
    set ib_unitArmor[113] = "medium"
    set ib_unitNameGbk[113] = "�ϳ���ʥ֮��"
    set ib_unitList[114] = 'e00V'
    set ib_unitName[114] = "合成烈火战刀"
    set ib_unitArmor[114] = "medium"
    set ib_unitNameGbk[114] = "�ϳ��һ�ս��"
    set ib_unitList[115] = 'e00X'
    set ib_unitName[115] = "合成霹雳手套"
    set ib_unitArmor[115] = "medium"
    set ib_unitNameGbk[115] = "�ϳ���������"
    set ib_unitList[116] = 'e00Y'
    set ib_unitName[116] = "升级霹雳手套"
    set ib_unitArmor[116] = "medium"
    set ib_unitNameGbk[116] = "������������"
    set ib_unitList[117] = 'e00Z'
    set ib_unitName[117] = "升级邪神战斧"
    set ib_unitArmor[117] = "medium"
    set ib_unitNameGbk[117] = "����а��ս��"
    set ib_unitList[118] = 'e010'
    set ib_unitName[118] = "升级烈火战刀"
    set ib_unitArmor[118] = "medium"
    set ib_unitNameGbk[118] = "�����һ�ս��"
    set ib_unitList[119] = 'e011'
    set ib_unitName[119] = "升级神圣之冠"
    set ib_unitArmor[119] = "medium"
    set ib_unitNameGbk[119] = "������ʥ֮��"
    set ib_unitList[120] = 'e013'
    set ib_unitName[120] = "升级疯魔之爪"
    set ib_unitArmor[120] = "medium"
    set ib_unitNameGbk[120] = "������ħ֮צ"
    set ib_unitList[121] = 'e014'
    set ib_unitName[121] = "合成秋霜战手"
    set ib_unitArmor[121] = "medium"
    set ib_unitNameGbk[121] = "�ϳ���˪ս��"
    set ib_unitList[122] = 'e015'
    set ib_unitName[122] = "合成秋霜战刀"
    set ib_unitArmor[122] = "medium"
    set ib_unitNameGbk[122] = "�ϳ���˪ս��"
    set ib_unitList[123] = 'e016'
    set ib_unitName[123] = "合成秋霜战盔"
    set ib_unitArmor[123] = "medium"
    set ib_unitNameGbk[123] = "�ϳ���˪ս��"
    set ib_unitList[124] = 'e017'
    set ib_unitName[124] = "合成秋霜战爪"
    set ib_unitArmor[124] = "medium"
    set ib_unitNameGbk[124] = "�ϳ���˪սצ"
    set ib_unitList[125] = 'e019'
    set ib_unitName[125] = "合成秋霜战斧"
    set ib_unitArmor[125] = "medium"
    set ib_unitNameGbk[125] = "�ϳ���˪ս��"
    set ib_unitList[126] = 'e01A'
    set ib_unitName[126] = "合成落叶魂刀"
    set ib_unitArmor[126] = "medium"
    set ib_unitNameGbk[126] = "�ϳ���Ҷ�굶"
    set ib_unitList[127] = 'e01B'
    set ib_unitName[127] = "合成落叶魂斧"
    set ib_unitArmor[127] = "medium"
    set ib_unitNameGbk[127] = "�ϳ���Ҷ�긫"
    set ib_unitList[128] = 'e01C'
    set ib_unitName[128] = "合成落叶魂爪"
    set ib_unitArmor[128] = "medium"
    set ib_unitNameGbk[128] = "�ϳ���Ҷ��צ"
    set ib_unitList[129] = 'e01D'
    set ib_unitName[129] = "合成落叶魂手"
    set ib_unitArmor[129] = "medium"
    set ib_unitNameGbk[129] = "�ϳ���Ҷ����"
    set ib_unitList[130] = 'e01E'
    set ib_unitName[130] = "合成落叶魂盔"
    set ib_unitArmor[130] = "medium"
    set ib_unitNameGbk[130] = "�ϳ���Ҷ���"
    set ib_unitList[131] = 'e01F'
    set ib_unitName[131] = "小精灵"
    set ib_unitArmor[131] = "medium"
    set ib_unitNameGbk[131] = "С����"
    set ib_unitList[132] = 'e01G'
    set ib_unitName[132] = "合成红魔龙刀"
    set ib_unitArmor[132] = "medium"
    set ib_unitNameGbk[132] = "�ϳɺ�ħ����"
    set ib_unitList[133] = 'e01H'
    set ib_unitName[133] = "合成红魔龙斧"
    set ib_unitArmor[133] = "medium"
    set ib_unitNameGbk[133] = "�ϳɺ�ħ����"
    set ib_unitList[134] = 'e01I'
    set ib_unitName[134] = "合成红魔龙爪"
    set ib_unitArmor[134] = "medium"
    set ib_unitNameGbk[134] = "�ϳɺ�ħ��צ"
    set ib_unitList[135] = 'e01J'
    set ib_unitName[135] = "合成红魔龙盔"
    set ib_unitArmor[135] = "medium"
    set ib_unitNameGbk[135] = "�ϳɺ�ħ����"
    set ib_unitList[136] = 'e01K'
    set ib_unitName[136] = "小精灵"
    set ib_unitArmor[136] = "medium"
    set ib_unitNameGbk[136] = "С����"
    set ib_unitList[137] = 'e01L'
    set ib_unitName[137] = "合成红魔龙手"
    set ib_unitArmor[137] = "medium"
    set ib_unitNameGbk[137] = "�ϳɺ�ħ����"
    set ib_unitList[138] = 'e01M'
    set ib_unitName[138] = "合成蓝月风刃"
    set ib_unitArmor[138] = "medium"
    set ib_unitNameGbk[138] = "�ϳ����·���"
    set ib_unitList[139] = 'e01N'
    set ib_unitName[139] = "购买群魔乱舞<三转技能>"
    set ib_unitArmor[139] = "medium"
    set ib_unitNameGbk[139] = "����Ⱥħ����<��ת����>"
    set ib_unitList[140] = 'e01O'
    set ib_unitName[140] = "购买天国之门<三转技能>"
    set ib_unitArmor[140] = "medium"
    set ib_unitNameGbk[140] = "�������֮��<��ת����>"
    set ib_unitList[141] = 'e01P'
    set ib_unitName[141] = "小精灵"
    set ib_unitArmor[141] = "medium"
    set ib_unitNameGbk[141] = "С����"
    set ib_unitList[142] = 'e01U'
    set ib_unitName[142] = "购买我最无敌<一转技能>"
    set ib_unitArmor[142] = "medium"
    set ib_unitNameGbk[142] = "���������޵�<һת����>"
    set ib_unitList[143] = 'e01V'
    set ib_unitName[143] = "购买无视一切<一转技能>"
    set ib_unitArmor[143] = "medium"
    set ib_unitNameGbk[143] = "��������һ��<һת����>"
    set ib_unitList[144] = 'e01W'
    set ib_unitName[144] = "购买鄙视一切<一转技能>"
    set ib_unitArmor[144] = "medium"
    set ib_unitNameGbk[144] = "�������һ��<һת����>"
    set ib_unitList[145] = 'e01X'
    set ib_unitName[145] = "购买治愈神速<一转技能>"
    set ib_unitArmor[145] = "medium"
    set ib_unitNameGbk[145] = "������������<һת����>"
    set ib_unitList[146] = 'e01Y'
    set ib_unitName[146] = "购买召地狱火<一转技能>"
    set ib_unitArmor[146] = "medium"
    set ib_unitNameGbk[146] = "�����ٵ�����<һת����>"
    set ib_unitList[147] = 'e01Z'
    set ib_unitName[147] = "暴风雪<二转技能>"
    set ib_unitArmor[147] = "medium"
    set ib_unitNameGbk[147] = "����ѩ<��ת����>"
    set ib_unitList[148] = 'e020'
    set ib_unitName[148] = "合成飞哥龙神斩<gm>"
    set ib_unitArmor[148] = "medium"
    set ib_unitNameGbk[148] = "�ϳɷɸ�����ն<gm>"
    set ib_unitList[149] = 'e024'
    set ib_unitName[149] = "购买慢性毒药<三转技能>"
    set ib_unitArmor[149] = "medium"
    set ib_unitNameGbk[149] = "�������Զ�ҩ<��ת����>"
    set ib_unitList[150] = 'e026'
    set ib_unitName[150] = "魔界弓箭手"
    set ib_unitArmor[150] = "hero"
    set ib_unitNameGbk[150] = "ħ�繭����"
    set ib_unitList[151] = 'e028'
    set ib_unitName[151] = "购买死亡闪电<三转技能>"
    set ib_unitArmor[151] = "medium"
    set ib_unitNameGbk[151] = "������������<��ת����>"
    set ib_unitList[152] = 'e029'
    set ib_unitName[152] = "烈焰风暴<二转技能>"
    set ib_unitArmor[152] = "medium"
    set ib_unitNameGbk[152] = "����籩<��ת����>"
    set ib_unitList[153] = 'e02A'
    set ib_unitName[153] = "纠缠根须<三转技能>"
    set ib_unitArmor[153] = "medium"
    set ib_unitNameGbk[153] = "��������<��ת����>"
    set ib_unitList[154] = 'e02B'
    set ib_unitName[154] = "群体风暴之锤<二转技能>"
    set ib_unitArmor[154] = "medium"
    set ib_unitNameGbk[154] = "Ⱥ��籩֮��<��ת����>"
    set ib_unitList[155] = 'e02C'
    set ib_unitName[155] = "腐臭蜂群<二转技能>"
    set ib_unitArmor[155] = "medium"
    set ib_unitNameGbk[155] = "������Ⱥ<��ת����>"
    set ib_unitList[156] = 'e02D'
    set ib_unitName[156] = "超级献祭<二转技能>"
    set ib_unitArmor[156] = "medium"
    set ib_unitNameGbk[156] = "�����׼�<��ת����>"
    set ib_unitList[157] = 'e02E'
    set ib_unitName[157] = "雷霆一击<二转技能>"
    set ib_unitArmor[157] = "medium"
    set ib_unitNameGbk[157] = "����һ��<��ת����>"
    set ib_unitList[158] = 'e02F'
    set ib_unitName[158] = "小精灵"
    set ib_unitArmor[158] = "medium"
    set ib_unitNameGbk[158] = "С����"
    set ib_unitList[159] = 'e02G'
    set ib_unitName[159] = "剑刃风暴<三转技能>"
    set ib_unitArmor[159] = "medium"
    set ib_unitNameGbk[159] = "���з籩<��ת����>"
endfunction
function IB_UnitFill2 takes nothing returns nothing
    set ib_unitList[160] = 'e02I'
    set ib_unitName[160] = "吸血大法<三转技能>"
    set ib_unitArmor[160] = "medium"
    set ib_unitNameGbk[160] = "��Ѫ��<��ת����>"
    set ib_unitList[161] = 'e02J'
    set ib_unitName[161] = "狂风践踏<三转技能>"
    set ib_unitArmor[161] = "medium"
    set ib_unitNameGbk[161] = "����̤<��ת����>"
    set ib_unitList[162] = 'e02K'
    set ib_unitName[162] = "复制英雄<三转>"
    set ib_unitArmor[162] = "medium"
    set ib_unitNameGbk[162] = "����Ӣ��<��ת>"
    set ib_unitList[163] = 'e02L'
    set ib_unitName[163] = "闪电医疗波<三转技能>"
    set ib_unitArmor[163] = "medium"
    set ib_unitNameGbk[163] = "����ҽ�Ʋ�<��ת����>"
    set ib_unitList[164] = 'e02M'
    set ib_unitName[164] = "闪电链<二转技能>"
    set ib_unitArmor[164] = "medium"
    set ib_unitNameGbk[164] = "������<��ת����>"
    set ib_unitList[165] = 'eaoe'
    set ib_unitName[165] = "知识古树"
    set ib_unitArmor[165] = "fort"
    set ib_unitNameGbk[165] = "֪ʶ����"
    set ib_unitList[166] = 'eaom'
    set ib_unitName[166] = "战争古树"
    set ib_unitArmor[166] = "fort"
    set ib_unitNameGbk[166] = "ս������"
    set ib_unitList[167] = 'eaow'
    set ib_unitName[167] = "风之古树"
    set ib_unitArmor[167] = "fort"
    set ib_unitNameGbk[167] = "��֮����"
    set ib_unitList[168] = 'earc'
    set ib_unitName[168] = "弓箭手"
    set ib_unitArmor[168] = "hero"
    set ib_unitNameGbk[168] = "������"
    set ib_unitList[169] = 'eate'
    set ib_unitName[169] = "长者祭坛"
    set ib_unitArmor[169] = "fort"
    set ib_unitNameGbk[169] = "���߼�̳"
    set ib_unitList[170] = 'ebal'
    set ib_unitName[170] = "投刃车"
    set ib_unitArmor[170] = "large"
    set ib_unitNameGbk[170] = "Ͷ�г�"
    set ib_unitList[171] = 'echm'
    set ib_unitName[171] = "奇美拉"
    set ib_unitArmor[171] = "hero"
    set ib_unitNameGbk[171] = "������"
    set ib_unitList[172] = 'edcm'
    set ib_unitName[172] = "利爪德鲁伊"
    set ib_unitArmor[172] = "large"
    set ib_unitNameGbk[172] = "��צ��³��"
    set ib_unitList[173] = 'eden'
    set ib_unitName[173] = "奇迹古树"
    set ib_unitArmor[173] = "fort"
    set ib_unitNameGbk[173] = "�漣����"
    set ib_unitList[174] = 'edob'
    set ib_unitName[174] = "猎手大厅"
    set ib_unitArmor[174] = "fort"
    set ib_unitNameGbk[174] = "���ִ���"
    set ib_unitList[175] = 'edoc'
    set ib_unitName[175] = "利爪德鲁伊"
    set ib_unitArmor[175] = "large"
    set ib_unitNameGbk[175] = "��צ��³��"
    set ib_unitList[176] = 'edos'
    set ib_unitName[176] = "奇美拉栖木"
    set ib_unitArmor[176] = "fort"
    set ib_unitNameGbk[176] = "��������ľ"
    set ib_unitList[177] = 'edot'
    set ib_unitName[177] = "猛禽德鲁伊"
    set ib_unitArmor[177] = "none"
    set ib_unitNameGbk[177] = "���ݵ�³��"
    set ib_unitList[178] = 'edry'
    set ib_unitName[178] = "树妖"
    set ib_unitArmor[178] = "hero"
    set ib_unitNameGbk[178] = "����"
    set ib_unitList[179] = 'edtm'
    set ib_unitName[179] = "猛禽德鲁伊"
    set ib_unitArmor[179] = "none"
    set ib_unitNameGbk[179] = "���ݵ�³��"
    set ib_unitList[180] = 'efdr'
    set ib_unitName[180] = "精灵龙"
    set ib_unitArmor[180] = "small"
    set ib_unitNameGbk[180] = "������"
    set ib_unitList[181] = 'efon'
    set ib_unitName[181] = "树人"
    set ib_unitArmor[181] = "large"
    set ib_unitNameGbk[181] = "����"
    set ib_unitList[182] = 'egol'
    set ib_unitName[182] = "被缠绕的金矿"
    set ib_unitArmor[182] = "fort"
    set ib_unitNameGbk[182] = "�����ƵĽ��"
    set ib_unitList[183] = 'ehip'
    set ib_unitName[183] = "角鹰兽"
    set ib_unitArmor[183] = "none"
    set ib_unitNameGbk[183] = "��ӥ��"
    set ib_unitList[184] = 'ehpr'
    set ib_unitName[184] = "角鹰兽骑士"
    set ib_unitArmor[184] = "small"
    set ib_unitNameGbk[184] = "��ӥ����ʿ"
    set ib_unitList[185] = 'emow'
    set ib_unitName[185] = "月亮井"
    set ib_unitArmor[185] = "fort"
    set ib_unitNameGbk[185] = "������"
    set ib_unitList[186] = 'emtg'
    set ib_unitName[186] = "山岭巨人"
    set ib_unitArmor[186] = "hero"
    set ib_unitNameGbk[186] = "ɽ�����"
    set ib_unitList[187] = 'esen'
    set ib_unitName[187] = "女猎手"
    set ib_unitArmor[187] = "hero"
    set ib_unitNameGbk[187] = "Ů����"
    set ib_unitList[188] = 'espv'
    set ib_unitName[188] = "复仇天神"
    set ib_unitArmor[188] = "large"
    set ib_unitNameGbk[188] = "��������"
    set ib_unitList[189] = 'etoa'
    set ib_unitName[189] = "远古之树"
    set ib_unitArmor[189] = "fort"
    set ib_unitNameGbk[189] = "Զ��֮��"
    set ib_unitList[190] = 'etoe'
    set ib_unitName[190] = "永恒之树"
    set ib_unitArmor[190] = "fort"
    set ib_unitNameGbk[190] = "����֮��"
    set ib_unitList[191] = 'etol'
    set ib_unitName[191] = "生命之树"
    set ib_unitArmor[191] = "fort"
    set ib_unitNameGbk[191] = "����֮��"
    set ib_unitList[192] = 'etrp'
    set ib_unitName[192] = "远古守护者"
    set ib_unitArmor[192] = "fort"
    set ib_unitNameGbk[192] = "Զ���ػ���"
    set ib_unitList[193] = 'even'
    set ib_unitName[193] = "复仇之魂"
    set ib_unitArmor[193] = "large"
    set ib_unitNameGbk[193] = "����֮��"
    set ib_unitList[194] = 'ewsp'
    set ib_unitName[194] = "小精灵"
    set ib_unitArmor[194] = "medium"
    set ib_unitNameGbk[194] = "С����"
    set ib_unitList[195] = 'h000'
    set ib_unitName[195] = "水元素"
    set ib_unitArmor[195] = "divine"
    set ib_unitNameGbk[195] = "ˮԪ��"
    set ib_unitList[196] = 'h001'
    set ib_unitName[196] = "水元素"
    set ib_unitArmor[196] = "divine"
    set ib_unitNameGbk[196] = "ˮԪ��"
    set ib_unitList[197] = 'h002'
    set ib_unitName[197] = "水元素"
    set ib_unitArmor[197] = "divine"
    set ib_unitNameGbk[197] = "ˮԪ��"
    set ib_unitList[198] = 'h003'
    set ib_unitName[198] = "水元素"
    set ib_unitArmor[198] = "divine"
    set ib_unitNameGbk[198] = "ˮԪ��"
    set ib_unitList[199] = 'h004'
    set ib_unitName[199] = "水元素"
    set ib_unitArmor[199] = "divine"
    set ib_unitNameGbk[199] = "ˮԪ��"
    set ib_unitList[200] = 'h005'
    set ib_unitName[200] = "步兵"
    set ib_unitArmor[200] = "large"
    set ib_unitNameGbk[200] = "����"
    set ib_unitList[201] = 'h006'
    set ib_unitName[201] = "步兵"
    set ib_unitArmor[201] = "large"
    set ib_unitNameGbk[201] = "����"
    set ib_unitList[202] = 'h007'
    set ib_unitName[202] = "步兵"
    set ib_unitArmor[202] = "large"
    set ib_unitNameGbk[202] = "����"
    set ib_unitList[203] = 'h008'
    set ib_unitName[203] = "步兵"
    set ib_unitArmor[203] = "large"
    set ib_unitNameGbk[203] = "����"
    set ib_unitList[204] = 'h009'
    set ib_unitName[204] = "步兵"
    set ib_unitArmor[204] = "large"
    set ib_unitNameGbk[204] = "����"
    set ib_unitList[205] = 'h00A'
    set ib_unitName[205] = "火凤凰"
    set ib_unitArmor[205] = "divine"
    set ib_unitNameGbk[205] = "����"
    set ib_unitList[206] = 'h00B'
    set ib_unitName[206] = "火凤凰"
    set ib_unitArmor[206] = "divine"
    set ib_unitNameGbk[206] = "����"
    set ib_unitList[207] = 'h00C'
    set ib_unitName[207] = "火凤凰"
    set ib_unitArmor[207] = "divine"
    set ib_unitNameGbk[207] = "����"
    set ib_unitList[208] = 'h00D'
    set ib_unitName[208] = "火凤凰"
    set ib_unitArmor[208] = "divine"
    set ib_unitNameGbk[208] = "����"
    set ib_unitList[209] = 'h00E'
    set ib_unitName[209] = "火凤凰"
    set ib_unitArmor[209] = "divine"
    set ib_unitNameGbk[209] = "����"
    set ib_unitList[210] = 'h00F'
    set ib_unitName[210] = "召唤"
    set ib_unitArmor[210] = "large"
    set ib_unitNameGbk[210] = "�ٻ�"
    set ib_unitList[211] = 'h00G'
    set ib_unitName[211] = "召唤坠落"
    set ib_unitArmor[211] = "large"
    set ib_unitNameGbk[211] = "�ٻ�׹��"
    set ib_unitList[212] = 'h00H'
    set ib_unitName[212] = "召唤木"
    set ib_unitArmor[212] = "large"
    set ib_unitNameGbk[212] = "�ٻ�ľ"
    set ib_unitList[213] = 'h00I'
    set ib_unitName[213] = "召唤妖"
    set ib_unitArmor[213] = "large"
    set ib_unitNameGbk[213] = "�ٻ���"
    set ib_unitList[214] = 'h00J'
    set ib_unitName[214] = "召唤"
    set ib_unitArmor[214] = "large"
    set ib_unitNameGbk[214] = "�ٻ�"
    set ib_unitList[215] = 'h00K'
    set ib_unitName[215] = "召唤"
    set ib_unitArmor[215] = "large"
    set ib_unitNameGbk[215] = "�ٻ�"
    set ib_unitList[216] = 'h00L'
    set ib_unitName[216] = "召唤炸弹"
    set ib_unitArmor[216] = "large"
    set ib_unitNameGbk[216] = "�ٻ�ը��"
    set ib_unitList[217] = 'h00M'
    set ib_unitName[217] = "神界守护者"
    set ib_unitArmor[217] = "hero"
    set ib_unitNameGbk[217] = "����ػ���"
    set ib_unitList[218] = 'h00N'
    set ib_unitName[218] = "召唤宁静"
    set ib_unitArmor[218] = "large"
    set ib_unitNameGbk[218] = "�ٻ�����"
    set ib_unitList[219] = 'h00O'
    set ib_unitName[219] = "召唤法力"
    set ib_unitArmor[219] = "large"
    set ib_unitNameGbk[219] = "�ٻ�����"
    set ib_unitList[220] = 'h00P'
    set ib_unitName[220] = "私人助理"
    set ib_unitArmor[220] = "medium"
    set ib_unitNameGbk[220] = "˽������"
    set ib_unitList[221] = 'h00Q'
    set ib_unitName[221] = "召唤"
    set ib_unitArmor[221] = "large"
    set ib_unitNameGbk[221] = "�ٻ�"
    set ib_unitList[222] = 'h00R'
    set ib_unitName[222] = "召唤"
    set ib_unitArmor[222] = "large"
    set ib_unitNameGbk[222] = "�ٻ�"
    set ib_unitList[223] = 'h00S'
    set ib_unitName[223] = "邮递按"
    set ib_unitArmor[223] = "divine"
    set ib_unitNameGbk[223] = "�ʵݰ�"
    set ib_unitList[224] = 'h00T'
    set ib_unitName[224] = "天国之门"
    set ib_unitArmor[224] = "divine"
    set ib_unitNameGbk[224] = "���֮��"
    set ib_unitList[225] = 'h00U'
    set ib_unitName[225] = "召唤"
    set ib_unitArmor[225] = "large"
    set ib_unitNameGbk[225] = "�ٻ�"
    set ib_unitList[226] = 'h00V'
    set ib_unitName[226] = "召唤"
    set ib_unitArmor[226] = "large"
    set ib_unitNameGbk[226] = "�ٻ�"
    set ib_unitList[227] = 'h00W'
    set ib_unitName[227] = "山丘的辅助农民"
    set ib_unitArmor[227] = "medium"
    set ib_unitNameGbk[227] = "ɽ��ĸ���ũ��"
    set ib_unitList[228] = 'h011'
    set ib_unitName[228] = "传送点"
    set ib_unitArmor[228] = "divine"
    set ib_unitNameGbk[228] = "���͵�"
    set ib_unitList[229] = 'h012'
    set ib_unitName[229] = "召唤"
    set ib_unitArmor[229] = "large"
    set ib_unitNameGbk[229] = "�ٻ�"
    set ib_unitList[230] = 'h013'
    set ib_unitName[230] = "召唤"
    set ib_unitArmor[230] = "large"
    set ib_unitNameGbk[230] = "�ٻ�"
    set ib_unitList[231] = 'h014'
    set ib_unitName[231] = "召唤"
    set ib_unitArmor[231] = "large"
    set ib_unitNameGbk[231] = "�ٻ�"
    set ib_unitList[232] = 'h015'
    set ib_unitName[232] = "召唤"
    set ib_unitArmor[232] = "large"
    set ib_unitNameGbk[232] = "�ٻ�"
    set ib_unitList[233] = 'h016'
    set ib_unitName[233] = "神界殿堂"
    set ib_unitArmor[233] = "fort"
    set ib_unitNameGbk[233] = "������"
    set ib_unitList[234] = 'h017'
    set ib_unitName[234] = "黄金剑士"
    set ib_unitArmor[234] = "divine"
    set ib_unitNameGbk[234] = "�ƽ�ʿ"
    set ib_unitList[235] = 'h018'
    set ib_unitName[235] = "死亡闪电5"
    set ib_unitArmor[235] = "large"
    set ib_unitNameGbk[235] = "��������5"
    set ib_unitList[236] = 'h019'
    set ib_unitName[236] = "死亡闪电2"
    set ib_unitArmor[236] = "large"
    set ib_unitNameGbk[236] = "��������2"
    set ib_unitList[237] = 'h01A'
    set ib_unitName[237] = "死亡闪电1"
    set ib_unitArmor[237] = "large"
    set ib_unitNameGbk[237] = "��������1"
    set ib_unitList[238] = 'h01B'
    set ib_unitName[238] = "死亡闪电4"
    set ib_unitArmor[238] = "large"
    set ib_unitNameGbk[238] = "��������4"
    set ib_unitList[239] = 'h01C'
    set ib_unitName[239] = "死亡闪电3"
    set ib_unitArmor[239] = "large"
    set ib_unitNameGbk[239] = "��������3"
endfunction
function IB_UnitFill3 takes nothing returns nothing
    set ib_unitList[240] = 'h01H'
    set ib_unitName[240] = "召唤"
    set ib_unitArmor[240] = "large"
    set ib_unitNameGbk[240] = "�ٻ�"
    set ib_unitList[241] = 'h01I'
    set ib_unitName[241] = "召唤"
    set ib_unitArmor[241] = "large"
    set ib_unitNameGbk[241] = "�ٻ�"
    set ib_unitList[242] = 'h01J'
    set ib_unitName[242] = "召唤木"
    set ib_unitArmor[242] = "large"
    set ib_unitNameGbk[242] = "�ٻ�ľ"
    set ib_unitList[243] = 'h01K'
    set ib_unitName[243] = "召唤"
    set ib_unitArmor[243] = "large"
    set ib_unitNameGbk[243] = "�ٻ�"
    set ib_unitList[244] = 'h01L'
    set ib_unitName[244] = "召唤"
    set ib_unitArmor[244] = "large"
    set ib_unitNameGbk[244] = "�ٻ�"
    set ib_unitList[245] = 'h01M'
    set ib_unitName[245] = "召唤"
    set ib_unitArmor[245] = "large"
    set ib_unitNameGbk[245] = "�ٻ�"
    set ib_unitList[246] = 'h01N'
    set ib_unitName[246] = "召唤"
    set ib_unitArmor[246] = "large"
    set ib_unitNameGbk[246] = "�ٻ�"
    set ib_unitList[247] = 'h01O'
    set ib_unitName[247] = "召唤"
    set ib_unitArmor[247] = "large"
    set ib_unitNameGbk[247] = "�ٻ�"
    set ib_unitList[248] = 'h01P'
    set ib_unitName[248] = "随机英雄"
    set ib_unitArmor[248] = "divine"
    set ib_unitNameGbk[248] = "���Ӣ��"
    set ib_unitList[249] = 'h01Q'
    set ib_unitName[249] = "召唤"
    set ib_unitArmor[249] = "large"
    set ib_unitNameGbk[249] = "�ٻ�"
    set ib_unitList[250] = 'h01R'
    set ib_unitName[250] = "火凤凰"
    set ib_unitArmor[250] = "divine"
    set ib_unitNameGbk[250] = "����"
    set ib_unitList[251] = 'h01S'
    set ib_unitName[251] = "购买双背包"
    set ib_unitArmor[251] = "medium"
    set ib_unitNameGbk[251] = "����˫����"
    set ib_unitList[252] = 'h01T'
    set ib_unitName[252] = "召唤"
    set ib_unitArmor[252] = "large"
    set ib_unitNameGbk[252] = "�ٻ�"
    set ib_unitList[253] = 'halt'
    set ib_unitName[253] = "国王祭坛"
    set ib_unitArmor[253] = "fort"
    set ib_unitNameGbk[253] = "������̳"
    set ib_unitList[254] = 'harm'
    set ib_unitName[254] = ""
    set ib_unitArmor[254] = "fort"
    set ib_unitNameGbk[254] = ""
    set ib_unitList[255] = 'hars'
    set ib_unitName[255] = "神秘圣地"
    set ib_unitArmor[255] = "fort"
    set ib_unitNameGbk[255] = "����ʥ��"
    set ib_unitList[256] = 'hatw'
    set ib_unitName[256] = "神秘之塔"
    set ib_unitArmor[256] = "large"
    set ib_unitNameGbk[256] = "����֮��"
    set ib_unitList[257] = 'hbar'
    set ib_unitName[257] = "兵营"
    set ib_unitArmor[257] = "fort"
    set ib_unitNameGbk[257] = "��Ӫ"
    set ib_unitList[258] = 'hbla'
    set ib_unitName[258] = "铁匠铺"
    set ib_unitArmor[258] = "fort"
    set ib_unitNameGbk[258] = "������"
    set ib_unitList[259] = 'hcas'
    set ib_unitName[259] = "神王殿"
    set ib_unitArmor[259] = "fort"
    set ib_unitNameGbk[259] = "������"
    set ib_unitList[260] = 'hctw'
    set ib_unitName[260] = "炮塔"
    set ib_unitArmor[260] = "fort"
    set ib_unitNameGbk[260] = "����"
    set ib_unitList[261] = 'hdhw'
    set ib_unitName[261] = "龙鹰骑士"
    set ib_unitArmor[261] = "small"
    set ib_unitNameGbk[261] = "��ӥ��ʿ"
    set ib_unitList[262] = 'hfoo'
    set ib_unitName[262] = ""
    set ib_unitArmor[262] = "hero"
    set ib_unitNameGbk[262] = ""
    set ib_unitList[263] = 'hgra'
    set ib_unitName[263] = "狮鹫笼"
    set ib_unitArmor[263] = "fort"
    set ib_unitNameGbk[263] = "ʨ����"
    set ib_unitList[264] = 'hgry'
    set ib_unitName[264] = "狮鹫骑士"
    set ib_unitArmor[264] = "hero"
    set ib_unitNameGbk[264] = "ʨ����ʿ"
    set ib_unitList[265] = 'hgtw'
    set ib_unitName[265] = "防御塔"
    set ib_unitArmor[265] = "large"
    set ib_unitNameGbk[265] = "������"
    set ib_unitList[266] = 'hgyr'
    set ib_unitName[266] = "飞行机器"
    set ib_unitArmor[266] = "large"
    set ib_unitNameGbk[266] = "���л���"
    set ib_unitList[267] = 'hhou'
    set ib_unitName[267] = "农场"
    set ib_unitArmor[267] = "fort"
    set ib_unitNameGbk[267] = "ũ��"
    set ib_unitList[268] = 'hkee'
    set ib_unitName[268] = ""
    set ib_unitArmor[268] = "fort"
    set ib_unitNameGbk[268] = ""
    set ib_unitList[269] = 'hkni'
    set ib_unitName[269] = "骑士"
    set ib_unitArmor[269] = "hero"
    set ib_unitNameGbk[269] = "��ʿ"
    set ib_unitList[270] = 'hlum'
    set ib_unitName[270] = "伐木场"
    set ib_unitArmor[270] = "fort"
    set ib_unitNameGbk[270] = "��ľ��"
    set ib_unitList[271] = 'hmil'
    set ib_unitName[271] = "民兵"
    set ib_unitArmor[271] = "large"
    set ib_unitNameGbk[271] = "���"
    set ib_unitList[272] = 'hmpr'
    set ib_unitName[272] = "牧师"
    set ib_unitArmor[272] = "none"
    set ib_unitNameGbk[272] = "��ʦ"
    set ib_unitList[273] = 'hmtm'
    set ib_unitName[273] = "迫击炮小队"
    set ib_unitArmor[273] = "large"
    set ib_unitNameGbk[273] = "�Ȼ���С��"
    set ib_unitList[274] = 'hmtt'
    set ib_unitName[274] = "蒸汽机车"
    set ib_unitArmor[274] = "fort"
    set ib_unitNameGbk[274] = "��������"
    set ib_unitList[275] = 'hpea'
    set ib_unitName[275] = "农民"
    set ib_unitArmor[275] = "medium"
    set ib_unitNameGbk[275] = "ũ��"
    set ib_unitList[276] = 'hphx'
    set ib_unitName[276] = "火凤凰"
    set ib_unitArmor[276] = "small"
    set ib_unitNameGbk[276] = "����"
    set ib_unitList[277] = 'hpxe'
    set ib_unitName[277] = "凤凰蛋"
    set ib_unitArmor[277] = "large"
    set ib_unitNameGbk[277] = "��˵�"
    set ib_unitList[278] = 'hrif'
    set ib_unitName[278] = "矮人火枪手"
    set ib_unitArmor[278] = "hero"
    set ib_unitNameGbk[278] = "���˻�ǹ��"
    set ib_unitList[279] = 'hrtt'
    set ib_unitName[279] = "蒸汽机车"
    set ib_unitArmor[279] = "fort"
    set ib_unitNameGbk[279] = "��������"
    set ib_unitList[280] = 'hsor'
    set ib_unitName[280] = "女巫"
    set ib_unitArmor[280] = "none"
    set ib_unitNameGbk[280] = "Ů��"
    set ib_unitList[281] = 'hspt'
    set ib_unitName[281] = "魔法破坏者"
    set ib_unitArmor[281] = "hero"
    set ib_unitNameGbk[281] = "ħ���ƻ���"
    set ib_unitList[282] = 'htow'
    set ib_unitName[282] = "城镇大厅"
    set ib_unitArmor[282] = "fort"
    set ib_unitNameGbk[282] = "�������"
    set ib_unitList[283] = 'hvlt'
    set ib_unitName[283] = "神秘藏宝室"
    set ib_unitArmor[283] = "fort"
    set ib_unitNameGbk[283] = "���زر���"
    set ib_unitList[284] = 'hwat'
    set ib_unitName[284] = "水元素"
    set ib_unitArmor[284] = "large"
    set ib_unitNameGbk[284] = "ˮԪ��"
    set ib_unitList[285] = 'hwt2'
    set ib_unitName[285] = "水元素"
    set ib_unitArmor[285] = "large"
    set ib_unitNameGbk[285] = "ˮԪ��"
    set ib_unitList[286] = 'hwt3'
    set ib_unitName[286] = "水元素"
    set ib_unitArmor[286] = "large"
    set ib_unitNameGbk[286] = "ˮԪ��"
    set ib_unitList[287] = 'hwtw'
    set ib_unitName[287] = "哨塔"
    set ib_unitArmor[287] = "small"
    set ib_unitNameGbk[287] = "����"
    set ib_unitList[288] = 'n000'
    set ib_unitName[288] = "赚钱区"
    set ib_unitArmor[288] = "medium"
    set ib_unitNameGbk[288] = "׬Ǯ��"
    set ib_unitList[289] = 'n001'
    set ib_unitName[289] = "练级区1号"
    set ib_unitArmor[289] = "medium"
    set ib_unitNameGbk[289] = "������1��"
    set ib_unitList[290] = 'n002'
    set ib_unitName[290] = "木材宝宝"
    set ib_unitArmor[290] = "hero"
    set ib_unitNameGbk[290] = "ľ�ı���"
    set ib_unitList[291] = 'n003'
    set ib_unitName[291] = "木材场"
    set ib_unitArmor[291] = "medium"
    set ib_unitNameGbk[291] = "ľ�ĳ�"
    set ib_unitList[292] = 'n004'
    set ib_unitName[292] = "骷髅射手"
    set ib_unitArmor[292] = "hero"
    set ib_unitNameGbk[292] = "��������"
    set ib_unitList[293] = 'n005'
    set ib_unitName[293] = "赛特斯之黑暗舞者"
    set ib_unitArmor[293] = "hero"
    set ib_unitNameGbk[293] = "����˹֮�ڰ�����"
    set ib_unitList[294] = 'n006'
    set ib_unitName[294] = "骷髅弓箭手"
    set ib_unitArmor[294] = "hero"
    set ib_unitNameGbk[294] = "���ù�����"
    set ib_unitList[295] = 'n007'
    set ib_unitName[295] = "挑战一级boss"
    set ib_unitArmor[295] = "medium"
    set ib_unitNameGbk[295] = "��սһ��boss"
    set ib_unitList[296] = 'n008'
    set ib_unitName[296] = "潮汐幽灵"
    set ib_unitArmor[296] = "hero"
    set ib_unitNameGbk[296] = "��ϫ����"
    set ib_unitList[297] = 'n009'
    set ib_unitName[297] = "毁灭守卫"
    set ib_unitArmor[297] = "hero"
    set ib_unitNameGbk[297] = "��������"
    set ib_unitList[298] = 'n00A'
    set ib_unitName[298] = "火焰弓手"
    set ib_unitArmor[298] = "hero"
    set ib_unitNameGbk[298] = "���湭��"
    set ib_unitList[299] = 'n00B'
    set ib_unitName[299] = "地狱火"
    set ib_unitArmor[299] = "hero"
    set ib_unitNameGbk[299] = "������"
    set ib_unitList[300] = 'n00D'
    set ib_unitName[300] = "初级技能商店"
    set ib_unitArmor[300] = "fort"
    set ib_unitNameGbk[300] = "���������̵�"
    set ib_unitList[301] = 'n00E'
    set ib_unitName[301] = "一次转生"
    set ib_unitArmor[301] = "medium"
    set ib_unitNameGbk[301] = "һ��ת��"
    set ib_unitList[302] = 'n00F'
    set ib_unitName[302] = "挑战牛头人"
    set ib_unitArmor[302] = "medium"
    set ib_unitNameGbk[302] = "��սţͷ��"
    set ib_unitList[303] = 'n00G'
    set ib_unitName[303] = "领主"
    set ib_unitArmor[303] = "hero"
    set ib_unitNameGbk[303] = "����"
    set ib_unitList[304] = 'n00H'
    set ib_unitName[304] = "兽族骷髅"
    set ib_unitArmor[304] = "hero"
    set ib_unitNameGbk[304] = "��������"
    set ib_unitList[305] = 'n00I'
    set ib_unitName[305] = "无敌黑暗舞者"
    set ib_unitArmor[305] = "hero"
    set ib_unitNameGbk[305] = "�޵кڰ�����"
    set ib_unitList[306] = 'n00J'
    set ib_unitName[306] = "攻城傀儡"
    set ib_unitArmor[306] = "hero"
    set ib_unitNameGbk[306] = "���ǿ���"
    set ib_unitList[307] = 'n00K'
    set ib_unitName[307] = "苦难女王"
    set ib_unitArmor[307] = "hero"
    set ib_unitNameGbk[307] = "����Ů��"
    set ib_unitList[308] = 'n00L'
    set ib_unitName[308] = "虚无行者长老"
    set ib_unitArmor[308] = "hero"
    set ib_unitNameGbk[308] = "�������߳���"
    set ib_unitList[309] = 'n00M'
    set ib_unitName[309] = "图斯卡尔酋长"
    set ib_unitArmor[309] = "hero"
    set ib_unitNameGbk[309] = "ͼ˹��������"
    set ib_unitList[310] = 'n00N'
    set ib_unitName[310] = "遗忘使者"
    set ib_unitArmor[310] = "divine"
    set ib_unitNameGbk[310] = "����ʹ��"
    set ib_unitList[311] = 'n00O'
    set ib_unitName[311] = "二次转生"
    set ib_unitArmor[311] = "medium"
    set ib_unitNameGbk[311] = "����ת��"
    set ib_unitList[312] = 'n00P'
    set ib_unitName[312] = "进攻魔界请求"
    set ib_unitArmor[312] = "medium"
    set ib_unitNameGbk[312] = "����ħ������"
    set ib_unitList[313] = 'n00Q'
    set ib_unitName[313] = "挑战火焰巨魔"
    set ib_unitArmor[313] = "medium"
    set ib_unitNameGbk[313] = "��ս�����ħ"
    set ib_unitList[314] = 'n00R'
    set ib_unitName[314] = "超级宝宝"
    set ib_unitArmor[314] = "hero"
    set ib_unitNameGbk[314] = "��������"
    set ib_unitList[315] = 'n00S'
    set ib_unitName[315] = "合成风痕之刃"
    set ib_unitArmor[315] = "medium"
    set ib_unitNameGbk[315] = "�ϳɷ��֮��"
    set ib_unitList[316] = 'n00T'
    set ib_unitName[316] = "神秘宝石区"
    set ib_unitArmor[316] = "medium"
    set ib_unitNameGbk[316] = "���ر�ʯ��"
    set ib_unitList[317] = 'n00U'
    set ib_unitName[317] = "黑暗地狱火"
    set ib_unitArmor[317] = "hero"
    set ib_unitNameGbk[317] = "�ڰ�������"
    set ib_unitList[318] = 'n00V'
    set ib_unitName[318] = "高级书店"
    set ib_unitArmor[318] = "fort"
    set ib_unitNameGbk[318] = "�߼����"
    set ib_unitList[319] = 'n00X'
    set ib_unitName[319] = "魔界隧道"
    set ib_unitArmor[319] = "medium"
    set ib_unitNameGbk[319] = "ħ������"
endfunction
function IB_UnitFill4 takes nothing returns nothing
    set ib_unitList[320] = 'n00Y'
    set ib_unitName[320] = "超级木材场1号"
    set ib_unitArmor[320] = "medium"
    set ib_unitNameGbk[320] = "����ľ�ĳ�1��"
    set ib_unitList[321] = 'n00Z'
    set ib_unitName[321] = "超级木材宝宝"
    set ib_unitArmor[321] = "hero"
    set ib_unitNameGbk[321] = "����ľ�ı���"
    set ib_unitList[322] = 'n010'
    set ib_unitName[322] = "神龙巢穴"
    set ib_unitArmor[322] = "medium"
    set ib_unitNameGbk[322] = "������Ѩ"
    set ib_unitList[323] = 'n011'
    set ib_unitName[323] = "神界商店"
    set ib_unitArmor[323] = "fort"
    set ib_unitNameGbk[323] = "����̵�"
    set ib_unitList[324] = 'n012'
    set ib_unitName[324] = "巨大的黑龙"
    set ib_unitArmor[324] = "divine"
    set ib_unitNameGbk[324] = "�޴�ĺ���"
    set ib_unitList[325] = 'n013'
    set ib_unitName[325] = "命运占卜老人"
    set ib_unitArmor[325] = "divine"
    set ib_unitNameGbk[325] = "����ռ������"
    set ib_unitList[326] = 'n014'
    set ib_unitName[326] = "超级地狱火"
    set ib_unitArmor[326] = "divine"
    set ib_unitNameGbk[326] = "����������"
    set ib_unitList[327] = 'n015'
    set ib_unitName[327] = "龙卵领主"
    set ib_unitArmor[327] = "divine"
    set ib_unitNameGbk[327] = "��������"
    set ib_unitList[328] = 'n016'
    set ib_unitName[328] = "黑魔首领"
    set ib_unitArmor[328] = "divine"
    set ib_unitNameGbk[328] = "��ħ����"
    set ib_unitList[329] = 'n017'
    set ib_unitName[329] = "熊怪乌萨战士"
    set ib_unitArmor[329] = "divine"
    set ib_unitNameGbk[329] = "�ܹ�����սʿ"
    set ib_unitList[330] = 'n018'
    set ib_unitName[330] = "幽魂"
    set ib_unitArmor[330] = "divine"
    set ib_unitNameGbk[330] = "�Ļ�"
    set ib_unitList[331] = 'n019'
    set ib_unitName[331] = "古代野人"
    set ib_unitArmor[331] = "divine"
    set ib_unitNameGbk[331] = "�Ŵ�Ұ��"
    set ib_unitList[332] = 'n01A'
    set ib_unitName[332] = "合成装备店"
    set ib_unitArmor[332] = "fort"
    set ib_unitNameGbk[332] = "�ϳ�װ����"
    set ib_unitList[333] = 'n01B'
    set ib_unitName[333] = "高级升级装备店"
    set ib_unitArmor[333] = "fort"
    set ib_unitNameGbk[333] = "�߼�����װ����"
    set ib_unitList[334] = 'n01C'
    set ib_unitName[334] = "秋霜合成装备店"
    set ib_unitArmor[334] = "fort"
    set ib_unitNameGbk[334] = "��˪�ϳ�װ����"
    set ib_unitList[335] = 'n01D'
    set ib_unitName[335] = "挑战二级boss"
    set ib_unitArmor[335] = "medium"
    set ib_unitNameGbk[335] = "��ս����boss"
    set ib_unitList[336] = 'n01E'
    set ib_unitName[336] = "挑战三级boss"
    set ib_unitArmor[336] = "medium"
    set ib_unitNameGbk[336] = "��ս����boss"
    set ib_unitList[337] = 'n01F'
    set ib_unitName[337] = "挑战四级boss"
    set ib_unitArmor[337] = "medium"
    set ib_unitNameGbk[337] = "��ս�ļ�boss"
    set ib_unitList[338] = 'n01G'
    set ib_unitName[338] = "挑战终极boss"
    set ib_unitArmor[338] = "medium"
    set ib_unitNameGbk[338] = "��ս�ռ�boss"
    set ib_unitList[339] = 'n01H'
    set ib_unitName[339] = "落叶合成装备店"
    set ib_unitArmor[339] = "fort"
    set ib_unitNameGbk[339] = "��Ҷ�ϳ�װ����"
    set ib_unitList[340] = 'n01I'
    set ib_unitName[340] = "红魔合成装备店"
    set ib_unitArmor[340] = "fort"
    set ib_unitNameGbk[340] = "��ħ�ϳ�װ����"
    set ib_unitList[341] = 'n01J'
    set ib_unitName[341] = "远古九头怪蛇"
    set ib_unitArmor[341] = "divine"
    set ib_unitNameGbk[341] = "Զ�ž�ͷ����"
    set ib_unitList[342] = 'n01K'
    set ib_unitName[342] = "风暴撕裂者巫师"
    set ib_unitArmor[342] = "divine"
    set ib_unitNameGbk[342] = "�籩˺������ʦ"
    set ib_unitList[343] = 'n01L'
    set ib_unitName[343] = "食人鬼首领"
    set ib_unitArmor[343] = "divine"
    set ib_unitNameGbk[343] = "ʳ�˹�����"
    set ib_unitList[344] = 'n01M'
    set ib_unitName[344] = "狂性野兽"
    set ib_unitArmor[344] = "divine"
    set ib_unitNameGbk[344] = "����Ұ��"
    set ib_unitList[345] = 'n01N'
    set ib_unitName[345] = "升级神殿防御"
    set ib_unitArmor[345] = "medium"
    set ib_unitNameGbk[345] = "����������"
    set ib_unitList[346] = 'n01O'
    set ib_unitName[346] = "尖毛兽酋长"
    set ib_unitArmor[346] = "divine"
    set ib_unitNameGbk[346] = "��ë������"
    set ib_unitList[347] = 'n01P'
    set ib_unitName[347] = "风暴巨龙"
    set ib_unitArmor[347] = "divine"
    set ib_unitNameGbk[347] = "�籩����"
    set ib_unitList[348] = 'n01Q'
    set ib_unitName[348] = "半人马可汗"
    set ib_unitArmor[348] = "divine"
    set ib_unitNameGbk[348] = "�������ɺ�"
    set ib_unitList[349] = 'n01R'
    set ib_unitName[349] = "神殿无敌"
    set ib_unitArmor[349] = "medium"
    set ib_unitNameGbk[349] = "����޵�"
    set ib_unitList[350] = 'n01S'
    set ib_unitName[350] = "赌博挑战商店"
    set ib_unitArmor[350] = "fort"
    set ib_unitNameGbk[350] = "�Ĳ���ս�̵�"
    set ib_unitList[351] = 'n01T'
    set ib_unitName[351] = "木材场2号"
    set ib_unitArmor[351] = "medium"
    set ib_unitNameGbk[351] = "ľ�ĳ�2��"
    set ib_unitList[352] = 'n01U'
    set ib_unitName[352] = "超级木材场2号"
    set ib_unitArmor[352] = "medium"
    set ib_unitNameGbk[352] = "����ľ�ĳ�2��"
    set ib_unitList[353] = 'n01V'
    set ib_unitName[353] = "风痕宝宝"
    set ib_unitArmor[353] = "hero"
    set ib_unitNameGbk[353] = "��۱���"
    set ib_unitList[354] = 'n01W'
    set ib_unitName[354] = "中级装备区"
    set ib_unitArmor[354] = "medium"
    set ib_unitNameGbk[354] = "�м�װ����"
    set ib_unitList[355] = 'n01X'
    set ib_unitName[355] = "三次转生"
    set ib_unitArmor[355] = "medium"
    set ib_unitNameGbk[355] = "����ת��"
    set ib_unitList[356] = 'n01Z'
    set ib_unitName[356] = "挑战四剑圣"
    set ib_unitArmor[356] = "medium"
    set ib_unitNameGbk[356] = "��ս�Ľ�ʥ"
    set ib_unitList[357] = 'n020'
    set ib_unitName[357] = "初级赌属性"
    set ib_unitArmor[357] = "medium"
    set ib_unitNameGbk[357] = "����������"
    set ib_unitList[358] = 'n021'
    set ib_unitName[358] = "中级赌属性"
    set ib_unitArmor[358] = "medium"
    set ib_unitNameGbk[358] = "�м�������"
    set ib_unitList[359] = 'n022'
    set ib_unitName[359] = "高级赌属性"
    set ib_unitArmor[359] = "medium"
    set ib_unitNameGbk[359] = "�߼�������"
    set ib_unitList[360] = 'n023'
    set ib_unitName[360] = "初级赌木材"
    set ib_unitArmor[360] = "medium"
    set ib_unitNameGbk[360] = "������ľ��"
    set ib_unitList[361] = 'n024'
    set ib_unitName[361] = "中级赌木材"
    set ib_unitArmor[361] = "medium"
    set ib_unitNameGbk[361] = "�м���ľ��"
    set ib_unitList[362] = 'n025'
    set ib_unitName[362] = "高级赌木材"
    set ib_unitArmor[362] = "medium"
    set ib_unitNameGbk[362] = "�߼���ľ��"
    set ib_unitList[363] = 'n026'
    set ib_unitName[363] = "挑战幕后黑手"
    set ib_unitArmor[363] = "medium"
    set ib_unitNameGbk[363] = "��սĻ�����"
    set ib_unitList[364] = 'n027'
    set ib_unitName[364] = "高级技能商店"
    set ib_unitArmor[364] = "fort"
    set ib_unitNameGbk[364] = "�߼������̵�"
    set ib_unitList[365] = 'n028'
    set ib_unitName[365] = "巨狼"
    set ib_unitArmor[365] = "divine"
    set ib_unitNameGbk[365] = "����"
    set ib_unitList[366] = 'n029'
    set ib_unitName[366] = "黑暗巫师"
    set ib_unitArmor[366] = "divine"
    set ib_unitNameGbk[366] = "�ڰ���ʦ"
    set ib_unitList[367] = 'n02A'
    set ib_unitName[367] = "地狱战舰"
    set ib_unitArmor[367] = "divine"
    set ib_unitNameGbk[367] = "����ս��"
    set ib_unitList[368] = 'n02B'
    set ib_unitName[368] = "耐瑟龙"
    set ib_unitArmor[368] = "divine"
    set ib_unitNameGbk[368] = "��ɪ��"
    set ib_unitList[369] = 'n02C'
    set ib_unitName[369] = "命运博彩"
    set ib_unitArmor[369] = "medium"
    set ib_unitNameGbk[369] = "���˲���"
    set ib_unitList[370] = 'n02D'
    set ib_unitName[370] = "绿蜉蝣"
    set ib_unitArmor[370] = "divine"
    set ib_unitNameGbk[370] = "������"
    set ib_unitList[371] = 'n02E'
    set ib_unitName[371] = "龙龟"
    set ib_unitArmor[371] = "divine"
    set ib_unitNameGbk[371] = "����"
    set ib_unitList[372] = 'n02F'
    set ib_unitName[372] = "练级区2号"
    set ib_unitArmor[372] = "medium"
    set ib_unitNameGbk[372] = "������2��"
    set ib_unitList[373] = 'n02G'
    set ib_unitName[373] = "超级木材场3号"
    set ib_unitArmor[373] = "medium"
    set ib_unitNameGbk[373] = "����ľ�ĳ�3��"
    set ib_unitList[374] = 'n02H'
    set ib_unitName[374] = "合成超级神器"
    set ib_unitArmor[374] = "medium"
    set ib_unitNameGbk[374] = "�ϳɳ�������"
    set ib_unitList[375] = 'n02I'
    set ib_unitName[375] = "合成超级神甲"
    set ib_unitArmor[375] = "medium"
    set ib_unitNameGbk[375] = "�ϳɳ������"
    set ib_unitList[376] = 'nadr'
    set ib_unitName[376] = "蓝龙"
    set ib_unitArmor[376] = "divine"
    set ib_unitNameGbk[376] = "����"
    set ib_unitList[377] = 'nalb'
    set ib_unitName[377] = "信天翁"
    set ib_unitArmor[377] = "medium"
    set ib_unitNameGbk[377] = "������"
    set ib_unitList[378] = 'nass'
    set ib_unitName[378] = "赚钱宝宝"
    set ib_unitArmor[378] = "medium"
    set ib_unitNameGbk[378] = "׬Ǯ����"
    set ib_unitList[379] = 'nba2'
    set ib_unitName[379] = "毁灭守卫"
    set ib_unitArmor[379] = "large"
    set ib_unitNameGbk[379] = "��������"
    set ib_unitList[380] = 'nbrg'
    set ib_unitName[380] = "练级宝宝"
    set ib_unitArmor[380] = "large"
    set ib_unitNameGbk[380] = "��������"
    set ib_unitList[381] = 'nbwm'
    set ib_unitName[381] = "黑龙"
    set ib_unitArmor[381] = "divine"
    set ib_unitNameGbk[381] = "����"
    set ib_unitList[382] = 'nbzd'
    set ib_unitName[382] = "青龙"
    set ib_unitArmor[382] = "divine"
    set ib_unitNameGbk[382] = "����"
    set ib_unitList[383] = 'ncp2'
    set ib_unitName[383] = "能量圈"
    set ib_unitArmor[383] = "fort"
    set ib_unitNameGbk[383] = "����Ȧ"
    set ib_unitList[384] = 'ncrb'
    set ib_unitName[384] = "螃蟹"
    set ib_unitArmor[384] = "medium"
    set ib_unitNameGbk[384] = "�з"
    set ib_unitList[385] = 'nech'
    set ib_unitName[385] = "小鸡"
    set ib_unitArmor[385] = "medium"
    set ib_unitNameGbk[385] = "С��"
    set ib_unitList[386] = 'necr'
    set ib_unitName[386] = "兔子"
    set ib_unitArmor[386] = "medium"
    set ib_unitNameGbk[386] = "����"
    set ib_unitList[387] = 'nfoh'
    set ib_unitName[387] = "能量之泉"
    set ib_unitArmor[387] = "fort"
    set ib_unitNameGbk[387] = "����֮Ȫ"
    set ib_unitList[388] = 'nfro'
    set ib_unitName[388] = "青蛙"
    set ib_unitArmor[388] = "medium"
    set ib_unitNameGbk[388] = "����"
    set ib_unitList[389] = 'ngad'
    set ib_unitName[389] = "地精书店"
    set ib_unitArmor[389] = "fort"
    set ib_unitNameGbk[389] = "�ؾ����"
    set ib_unitList[390] = 'ngme'
    set ib_unitName[390] = "地精商店"
    set ib_unitArmor[390] = "fort"
    set ib_unitNameGbk[390] = "�ؾ��̵�"
    set ib_unitList[391] = 'ngrd'
    set ib_unitName[391] = "绿龙"
    set ib_unitArmor[391] = "divine"
    set ib_unitNameGbk[391] = "����"
    set ib_unitList[392] = 'ngst'
    set ib_unitName[392] = "岩石傀儡"
    set ib_unitArmor[392] = "large"
    set ib_unitNameGbk[392] = "��ʯ����"
    set ib_unitList[393] = 'ngz4'
    set ib_unitName[393] = "米纱"
    set ib_unitArmor[393] = "large"
    set ib_unitNameGbk[393] = "��ɴ"
    set ib_unitList[394] = 'ngza'
    set ib_unitName[394] = "米纱"
    set ib_unitArmor[394] = "large"
    set ib_unitNameGbk[394] = "��ɴ"
    set ib_unitList[395] = 'ngzc'
    set ib_unitName[395] = "米纱"
    set ib_unitArmor[395] = "large"
    set ib_unitNameGbk[395] = "��ɴ"
    set ib_unitList[396] = 'ngzd'
    set ib_unitName[396] = "米纱"
    set ib_unitArmor[396] = "large"
    set ib_unitNameGbk[396] = "��ɴ"
    set ib_unitList[397] = 'nhmc'
    set ib_unitName[397] = "螃蟹隐士"
    set ib_unitArmor[397] = "medium"
    set ib_unitNameGbk[397] = "�з��ʿ"
    set ib_unitList[398] = 'nhyd'
    set ib_unitName[398] = "九头怪蛇"
    set ib_unitArmor[398] = "large"
    set ib_unitNameGbk[398] = "��ͷ����"
    set ib_unitList[399] = 'ninf'
    set ib_unitName[399] = "地狱火"
    set ib_unitArmor[399] = "large"
    set ib_unitNameGbk[399] = "������"
endfunction
function IB_UnitFill5 takes nothing returns nothing
    set ib_unitList[400] = 'nlv1'
    set ib_unitName[400] = "炎魔"
    set ib_unitArmor[400] = "large"
    set ib_unitNameGbk[400] = "��ħ"
    set ib_unitList[401] = 'nlv2'
    set ib_unitName[401] = "炎魔"
    set ib_unitArmor[401] = "large"
    set ib_unitNameGbk[401] = "��ħ"
    set ib_unitList[402] = 'nlv3'
    set ib_unitName[402] = "炎魔"
    set ib_unitArmor[402] = "large"
    set ib_unitNameGbk[402] = "��ħ"
    set ib_unitList[403] = 'nmdm'
    set ib_unitName[403] = "麦迪文"
    set ib_unitArmor[403] = "large"
    set ib_unitNameGbk[403] = "�����"
    set ib_unitList[404] = 'nmed'
    set ib_unitName[404] = "麦迪文"
    set ib_unitArmor[404] = "large"
    set ib_unitNameGbk[404] = "�����"
    set ib_unitList[405] = 'nmer'
    set ib_unitName[405] = "升级装备店"
    set ib_unitArmor[405] = "fort"
    set ib_unitNameGbk[405] = "����װ����"
    set ib_unitList[406] = 'nmrk'
    set ib_unitName[406] = "市场"
    set ib_unitArmor[406] = "fort"
    set ib_unitNameGbk[406] = "�г�"
    set ib_unitList[407] = 'now2'
    set ib_unitName[407] = "猫头鹰侦察者"
    set ib_unitArmor[407] = "medium"
    set ib_unitNameGbk[407] = "èͷӥ�����"
    set ib_unitList[408] = 'now3'
    set ib_unitName[408] = "猫头鹰侦察者"
    set ib_unitArmor[408] = "medium"
    set ib_unitNameGbk[408] = "èͷӥ�����"
    set ib_unitList[409] = 'nowl'
    set ib_unitName[409] = "猫头鹰侦察者"
    set ib_unitArmor[409] = "medium"
    set ib_unitNameGbk[409] = "èͷӥ�����"
    set ib_unitList[410] = 'npig'
    set ib_unitName[410] = "野猪"
    set ib_unitArmor[410] = "medium"
    set ib_unitNameGbk[410] = "Ұ��"
    set ib_unitList[411] = 'npn1'
    set ib_unitName[411] = "火焰"
    set ib_unitArmor[411] = "large"
    set ib_unitNameGbk[411] = "����"
    set ib_unitList[412] = 'npn2'
    set ib_unitName[412] = "风暴"
    set ib_unitArmor[412] = "large"
    set ib_unitNameGbk[412] = "�籩"
    set ib_unitList[413] = 'npn3'
    set ib_unitName[413] = "大地"
    set ib_unitArmor[413] = "large"
    set ib_unitNameGbk[413] = "���"
    set ib_unitList[414] = 'npng'
    set ib_unitName[414] = "企鹅"
    set ib_unitArmor[414] = "medium"
    set ib_unitNameGbk[414] = "���"
    set ib_unitList[415] = 'npnw'
    set ib_unitName[415] = "企鹅"
    set ib_unitArmor[415] = "medium"
    set ib_unitNameGbk[415] = "���"
    set ib_unitList[416] = 'nqb1'
    set ib_unitName[416] = "豪猪"
    set ib_unitArmor[416] = "medium"
    set ib_unitNameGbk[416] = "����"
    set ib_unitList[417] = 'nqb2'
    set ib_unitName[417] = "凶恶豪猪"
    set ib_unitArmor[417] = "medium"
    set ib_unitNameGbk[417] = "�׶����"
    set ib_unitList[418] = 'nqb3'
    set ib_unitName[418] = "影子豪猪"
    set ib_unitArmor[418] = "medium"
    set ib_unitNameGbk[418] = "Ӱ�Ӻ���"
    set ib_unitList[419] = 'nqb4'
    set ib_unitName[419] = "狂暴豪猪"
    set ib_unitArmor[419] = "medium"
    set ib_unitNameGbk[419] = "�񱩺���"
    set ib_unitList[420] = 'nrac'
    set ib_unitName[420] = "浣熊"
    set ib_unitArmor[420] = "medium"
    set ib_unitNameGbk[420] = "���"
    set ib_unitList[421] = 'nrat'
    set ib_unitName[421] = "老鼠"
    set ib_unitArmor[421] = "medium"
    set ib_unitNameGbk[421] = "����"
    set ib_unitList[422] = 'nrvf'
    set ib_unitName[422] = "火焰幽魂"
    set ib_unitArmor[422] = "large"
    set ib_unitNameGbk[422] = "�����Ļ�"
    set ib_unitList[423] = 'nrwm'
    set ib_unitName[423] = "红龙"
    set ib_unitArmor[423] = "divine"
    set ib_unitNameGbk[423] = "����"
    set ib_unitList[424] = 'nsea'
    set ib_unitName[424] = "海豹"
    set ib_unitArmor[424] = "medium"
    set ib_unitNameGbk[424] = "����"
    set ib_unitList[425] = 'nsha'
    set ib_unitName[425] = "绵羊"
    set ib_unitArmor[425] = "medium"
    set ib_unitNameGbk[425] = "����"
    set ib_unitList[426] = 'nshe'
    set ib_unitName[426] = "绵羊"
    set ib_unitArmor[426] = "medium"
    set ib_unitNameGbk[426] = "����"
    set ib_unitList[427] = 'nshf'
    set ib_unitName[427] = "乳羊"
    set ib_unitArmor[427] = "medium"
    set ib_unitNameGbk[427] = "����"
    set ib_unitList[428] = 'nshw'
    set ib_unitName[428] = "绵羊"
    set ib_unitArmor[428] = "medium"
    set ib_unitNameGbk[428] = "����"
    set ib_unitList[429] = 'nsno'
    set ib_unitName[429] = "雪鹰"
    set ib_unitArmor[429] = "medium"
    set ib_unitNameGbk[429] = "ѩӥ"
    set ib_unitList[430] = 'ntav'
    set ib_unitName[430] = "药水店"
    set ib_unitArmor[430] = "fort"
    set ib_unitNameGbk[430] = "ҩˮ��"
    set ib_unitList[431] = 'ntor'
    set ib_unitName[431] = "龙卷风"
    set ib_unitArmor[431] = "large"
    set ib_unitNameGbk[431] = "������"
    set ib_unitList[432] = 'nvlk'
    set ib_unitName[432] = "小孩"
    set ib_unitArmor[432] = "medium"
    set ib_unitNameGbk[432] = "С��"
    set ib_unitList[433] = 'nvul'
    set ib_unitName[433] = "秃鹰"
    set ib_unitArmor[433] = "medium"
    set ib_unitNameGbk[433] = "ͺӥ"
    set ib_unitList[434] = 'nw2w'
    set ib_unitName[434] = "兽族巫师"
    set ib_unitArmor[434] = "hero"
    set ib_unitNameGbk[434] = "������ʦ"
    set ib_unitList[435] = 'nwgt'
    set ib_unitName[435] = "传送门"
    set ib_unitArmor[435] = "fort"
    set ib_unitNameGbk[435] = "������"
    set ib_unitList[436] = 'o004'
    set ib_unitName[436] = "闪电护卫"
    set ib_unitArmor[436] = "large"
    set ib_unitNameGbk[436] = "���绤��"
    set ib_unitList[437] = 'o00G'
    set ib_unitName[437] = "阴影之狼"
    set ib_unitArmor[437] = "divine"
    set ib_unitNameGbk[437] = "��Ӱ֮��"
    set ib_unitList[438] = 'o00H'
    set ib_unitName[438] = "阴影之狼"
    set ib_unitArmor[438] = "divine"
    set ib_unitNameGbk[438] = "��Ӱ֮��"
    set ib_unitList[439] = 'o00I'
    set ib_unitName[439] = "阴影之狼"
    set ib_unitArmor[439] = "divine"
    set ib_unitNameGbk[439] = "��Ӱ֮��"
    set ib_unitList[440] = 'o00J'
    set ib_unitName[440] = "阴影之狼"
    set ib_unitArmor[440] = "divine"
    set ib_unitNameGbk[440] = "��Ӱ֮��"
    set ib_unitList[441] = 'o00K'
    set ib_unitName[441] = "阴影之狼"
    set ib_unitArmor[441] = "divine"
    set ib_unitNameGbk[441] = "��Ӱ֮��"
    set ib_unitList[442] = 'o00L'
    set ib_unitName[442] = "幻象"
    set ib_unitArmor[442] = "medium"
    set ib_unitNameGbk[442] = "����"
    set ib_unitList[443] = 'oalt'
    set ib_unitName[443] = "风暴祭坛"
    set ib_unitArmor[443] = "fort"
    set ib_unitNameGbk[443] = "�籩��̳"
    set ib_unitList[444] = 'ocat'
    set ib_unitName[444] = "粉碎者"
    set ib_unitArmor[444] = "large"
    set ib_unitNameGbk[444] = "������"
    set ib_unitList[445] = 'ofor'
    set ib_unitName[445] = "战争磨坊"
    set ib_unitArmor[445] = "fort"
    set ib_unitNameGbk[445] = "ս��ĥ��"
    set ib_unitList[446] = 'ofrt'
    set ib_unitName[446] = "堡垒"
    set ib_unitArmor[446] = "fort"
    set ib_unitNameGbk[446] = "����"
    set ib_unitList[447] = 'ogre'
    set ib_unitName[447] = "大厅"
    set ib_unitArmor[447] = "fort"
    set ib_unitNameGbk[447] = "����"
    set ib_unitList[448] = 'ogru'
    set ib_unitName[448] = "兽族步兵"
    set ib_unitArmor[448] = "hero"
    set ib_unitNameGbk[448] = "���岽��"
    set ib_unitList[449] = 'ohun'
    set ib_unitName[449] = "巨魔猎头者"
    set ib_unitArmor[449] = "hero"
    set ib_unitNameGbk[449] = "��ħ��ͷ��"
    set ib_unitList[450] = 'ohwd'
    set ib_unitName[450] = "治疗守卫"
    set ib_unitArmor[450] = "medium"
    set ib_unitNameGbk[450] = "��������"
    set ib_unitList[451] = 'opeo'
    set ib_unitName[451] = "苦工"
    set ib_unitArmor[451] = "divine"
    set ib_unitNameGbk[451] = "�๤"
    set ib_unitList[452] = 'orai'
    set ib_unitName[452] = "掠夺者"
    set ib_unitArmor[452] = "hero"
    set ib_unitNameGbk[452] = "�Ӷ���"
    set ib_unitList[453] = 'osp1'
    set ib_unitName[453] = "毒蛇守卫"
    set ib_unitArmor[453] = "large"
    set ib_unitNameGbk[453] = "��������"
    set ib_unitList[454] = 'osp2'
    set ib_unitName[454] = "毒蛇守卫"
    set ib_unitArmor[454] = "large"
    set ib_unitNameGbk[454] = "��������"
    set ib_unitList[455] = 'osp3'
    set ib_unitName[455] = "毒蛇守卫"
    set ib_unitArmor[455] = "large"
    set ib_unitNameGbk[455] = "��������"
    set ib_unitList[456] = 'osp4'
    set ib_unitName[456] = "毒蛇守卫"
    set ib_unitArmor[456] = "large"
    set ib_unitNameGbk[456] = "��������"
    set ib_unitList[457] = 'ostr'
    set ib_unitName[457] = "要塞"
    set ib_unitArmor[457] = "fort"
    set ib_unitNameGbk[457] = "Ҫ��"
    set ib_unitList[458] = 'osw1'
    set ib_unitName[458] = "幽魂之狼"
    set ib_unitArmor[458] = "large"
    set ib_unitNameGbk[458] = "�Ļ�֮��"
    set ib_unitList[459] = 'osw2'
    set ib_unitName[459] = "恐惧之狼"
    set ib_unitArmor[459] = "large"
    set ib_unitNameGbk[459] = "�־�֮��"
    set ib_unitList[460] = 'osw3'
    set ib_unitName[460] = "阴影之狼"
    set ib_unitArmor[460] = "large"
    set ib_unitNameGbk[460] = "��Ӱ֮��"
    set ib_unitList[461] = 'otau'
    set ib_unitName[461] = "牛头人"
    set ib_unitArmor[461] = "hero"
    set ib_unitNameGbk[461] = "ţͷ��"
    set ib_unitList[462] = 'otbk'
    set ib_unitName[462] = "巨魔狂暴战士"
    set ib_unitArmor[462] = "medium"
    set ib_unitNameGbk[462] = "��ħ��սʿ"
    set ib_unitList[463] = 'ovln'
    set ib_unitName[463] = "巫毒商店"
    set ib_unitArmor[463] = "fort"
    set ib_unitNameGbk[463] = "�׶��̵�"
    set ib_unitList[464] = 'owtw'
    set ib_unitName[464] = "了望塔"
    set ib_unitArmor[464] = "fort"
    set ib_unitNameGbk[464] = "������"
    set ib_unitList[465] = 'owyv'
    set ib_unitName[465] = "风骑士"
    set ib_unitArmor[465] = "hero"
    set ib_unitNameGbk[465] = "����ʿ"
    set ib_unitList[466] = 'u000'
    set ib_unitName[466] = "憎恶"
    set ib_unitArmor[466] = "hero"
    set ib_unitNameGbk[466] = "����"
    set ib_unitList[467] = 'u001'
    set ib_unitName[467] = "幽魂之塔"
    set ib_unitArmor[467] = "fort"
    set ib_unitNameGbk[467] = "�Ļ�֮��"
    set ib_unitList[468] = 'u005'
    set ib_unitName[468] = "魔界城堡"
    set ib_unitArmor[468] = "fort"
    set ib_unitNameGbk[468] = "ħ��Ǳ�"
    set ib_unitList[469] = 'u006'
    set ib_unitName[469] = "幽魂之塔"
    set ib_unitArmor[469] = "fort"
    set ib_unitNameGbk[469] = "�Ļ�֮��"
    set ib_unitList[470] = 'uabo'
    set ib_unitName[470] = "憎恶"
    set ib_unitArmor[470] = "hero"
    set ib_unitNameGbk[470] = "����"
    set ib_unitList[471] = 'uaco'
    set ib_unitName[471] = "侍僧"
    set ib_unitArmor[471] = "medium"
    set ib_unitNameGbk[471] = "��ɮ"
    set ib_unitList[472] = 'uaod'
    set ib_unitName[472] = "黑暗祭坛"
    set ib_unitArmor[472] = "fort"
    set ib_unitNameGbk[472] = "�ڰ���̳"
    set ib_unitList[473] = 'uban'
    set ib_unitName[473] = "女妖"
    set ib_unitArmor[473] = "none"
    set ib_unitNameGbk[473] = "Ů��"
    set ib_unitList[474] = 'ubon'
    set ib_unitName[474] = "埋骨地"
    set ib_unitArmor[474] = "fort"
    set ib_unitNameGbk[474] = "��ǵ�"
    set ib_unitList[475] = 'ubsp'
    set ib_unitName[475] = "破坏者"
    set ib_unitArmor[475] = "small"
    set ib_unitNameGbk[475] = "�ƻ���"
    set ib_unitList[476] = 'ucrm'
    set ib_unitName[476] = "钻入地下的穴居恶魔"
    set ib_unitArmor[476] = "medium"
    set ib_unitNameGbk[476] = "������µ�Ѩ�Ӷ�ħ"
    set ib_unitList[477] = 'ucry'
    set ib_unitName[477] = "穴居恶魔"
    set ib_unitArmor[477] = "hero"
    set ib_unitNameGbk[477] = "Ѩ�Ӷ�ħ"
    set ib_unitList[478] = 'ucs1'
    set ib_unitName[478] = "腐尸甲虫"
    set ib_unitArmor[478] = "large"
    set ib_unitNameGbk[478] = "��ʬ�׳�"
    set ib_unitList[479] = 'ucs2'
    set ib_unitName[479] = "腐尸甲虫"
    set ib_unitArmor[479] = "large"
    set ib_unitNameGbk[479] = "��ʬ�׳�"
endfunction
function IB_UnitFill6 takes nothing returns nothing
    set ib_unitList[480] = 'ucs3'
    set ib_unitName[480] = "腐尸甲虫"
    set ib_unitArmor[480] = "large"
    set ib_unitNameGbk[480] = "��ʬ�׳�"
    set ib_unitList[481] = 'ucsB'
    set ib_unitName[481] = "钻入地下的腐尸甲虫"
    set ib_unitArmor[481] = "large"
    set ib_unitNameGbk[481] = "������µĸ�ʬ�׳�"
    set ib_unitList[482] = 'ucsC'
    set ib_unitName[482] = "钻入地下的腐尸甲虫"
    set ib_unitArmor[482] = "large"
    set ib_unitNameGbk[482] = "������µĸ�ʬ�׳�"
    set ib_unitList[483] = 'ufro'
    set ib_unitName[483] = "冰霜巨龙"
    set ib_unitArmor[483] = "hero"
    set ib_unitNameGbk[483] = "��˪����"
    set ib_unitList[484] = 'ugar'
    set ib_unitName[484] = "石像鬼"
    set ib_unitArmor[484] = "none"
    set ib_unitNameGbk[484] = "ʯ���"
    set ib_unitList[485] = 'ugho'
    set ib_unitName[485] = "食尸鬼"
    set ib_unitArmor[485] = "hero"
    set ib_unitNameGbk[485] = "ʳʬ��"
    set ib_unitList[486] = 'ugol'
    set ib_unitName[486] = "闹鬼金矿"
    set ib_unitArmor[486] = "fort"
    set ib_unitNameGbk[486] = "�ֹ����"
    set ib_unitList[487] = 'ugrm'
    set ib_unitName[487] = "石像形态下的石像鬼"
    set ib_unitArmor[487] = "none"
    set ib_unitNameGbk[487] = "ʯ����̬�µ�ʯ���"
    set ib_unitList[488] = 'ugrv'
    set ib_unitName[488] = "坟场"
    set ib_unitArmor[488] = "fort"
    set ib_unitNameGbk[488] = "�س�"
    set ib_unitList[489] = 'uloc'
    set ib_unitName[489] = "蝗虫"
    set ib_unitArmor[489] = "small"
    set ib_unitNameGbk[489] = "�ȳ�"
    set ib_unitList[490] = 'umtw'
    set ib_unitName[490] = "绞肉车"
    set ib_unitArmor[490] = "large"
    set ib_unitNameGbk[490] = "���⳵"
    set ib_unitList[491] = 'unec'
    set ib_unitName[491] = "不死族巫师"
    set ib_unitArmor[491] = "none"
    set ib_unitNameGbk[491] = "��������ʦ"
    set ib_unitList[492] = 'unp1'
    set ib_unitName[492] = "亡者大厅"
    set ib_unitArmor[492] = "fort"
    set ib_unitNameGbk[492] = "���ߴ���"
    set ib_unitList[493] = 'unp2'
    set ib_unitName[493] = "黑暗城堡"
    set ib_unitArmor[493] = "fort"
    set ib_unitNameGbk[493] = "�ڰ��Ǳ�"
    set ib_unitList[494] = 'unpl'
    set ib_unitName[494] = "大墓地"
    set ib_unitArmor[494] = "fort"
    set ib_unitNameGbk[494] = "��Ĺ��"
    set ib_unitList[495] = 'uobs'
    set ib_unitName[495] = "十胜石雕像"
    set ib_unitArmor[495] = "large"
    set ib_unitNameGbk[495] = "ʮʤʯ����"
    set ib_unitList[496] = 'uplg'
    set ib_unitName[496] = "疾病云雾"
    set ib_unitArmor[496] = "medium"
    set ib_unitNameGbk[496] = "��������"
    set ib_unitList[497] = 'usap'
    set ib_unitName[497] = "牺牲深渊"
    set ib_unitArmor[497] = "fort"
    set ib_unitNameGbk[497] = "������Ԩ"
    set ib_unitList[498] = 'usep'
    set ib_unitName[498] = "地穴"
    set ib_unitArmor[498] = "fort"
    set ib_unitNameGbk[498] = "��Ѩ"
    set ib_unitList[499] = 'ushd'
    set ib_unitName[499] = "阴影"
    set ib_unitArmor[499] = "medium"
    set ib_unitNameGbk[499] = "��Ӱ"
    set ib_unitList[500] = 'uske'
    set ib_unitName[500] = "骷髅战士"
    set ib_unitArmor[500] = "large"
    set ib_unitNameGbk[500] = "����սʿ"
    set ib_unitList[501] = 'uskm'
    set ib_unitName[501] = "骷髅魔法师"
    set ib_unitArmor[501] = "medium"
    set ib_unitNameGbk[501] = "����ħ��ʦ"
    set ib_unitList[502] = 'uslh'
    set ib_unitName[502] = "屠宰场"
    set ib_unitArmor[502] = "fort"
    set ib_unitNameGbk[502] = "���׳�"
    set ib_unitList[503] = 'utod'
    set ib_unitName[503] = "诅咒神庙"
    set ib_unitArmor[503] = "fort"
    set ib_unitNameGbk[503] = "��������"
    set ib_unitList[504] = 'utom'
    set ib_unitName[504] = "古墓废墟"
    set ib_unitArmor[504] = "fort"
    set ib_unitNameGbk[504] = "��Ĺ����"
    set ib_unitList[505] = 'uzg1'
    set ib_unitName[505] = "幽魂之塔"
    set ib_unitArmor[505] = "fort"
    set ib_unitNameGbk[505] = "�Ļ�֮��"
    set ib_unitList[506] = 'uzg2'
    set ib_unitName[506] = "蛛网怪塔"
    set ib_unitArmor[506] = "fort"
    set ib_unitNameGbk[506] = "��������"
    set ib_unitList[507] = 'uzig'
    set ib_unitName[507] = "通灵塔"
    set ib_unitArmor[507] = "fort"
    set ib_unitNameGbk[507] = "ͨ����"
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
    endif
    set ib_unFillIdx = ib_unFillIdx + 1
    if ib_unFillIdx >= ib_unFillTotal then
        set ib_unitCount = 508
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
    set ib_fillTotal = 2
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 12
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    set ib_unFillIdx = 0
    set ib_unFillTotal = 7
    set ib_unFillTimer = CreateTimer()
    call TimerStart(ib_unFillTimer, 0.01, true, function IB_UnitFillStep)
    call IB_CritInit()
    call IB_FingerCastInit()
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
