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
    // 攻击者必须在暴击组中
    if not IsUnitInGroup(src, ib_critGroup) then
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


// 给选中单位开启暴击
function IB_CritEnable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call GroupAddUnit(ib_critGroup, u)
    call IB_SkillMessage(p, "已给 " + GetUnitName(u) + " 开启【致命一击】")
    set u = null
endfunction

// 关闭选中单位的暴击
function IB_CritDisable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "请先选中一个英雄/单位")
        return
    endif
    call GroupRemoveUnit(ib_critGroup, u)
    call IB_SkillMessage(p, "已关闭 " + GetUnitName(u) + " 的【致命一击】")
    set u = null
endfunction

// 显示暴击系统信息
function IB_CritInfo takes player p returns nothing
    call IB_SkillMessage(p, "【致命一击】概率表: 50%x2 30%x3 10%x4 4%x5 3%x10 2%x50 1%x100 (EV=4.8x)")
    call IB_SkillMessage(p, "本局已触发暴击 " + I2S(ib_critCount) + " 次，最近倍率 x" + I2S(ib_critLastMult))
    call IB_SkillMessage(p, "命令: criton(给选中单位) / critoff(移除) / crit(信息)")
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
    endif
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
// 用 TriggerAddAction（而非 Condition）注册：部分地图/版本下仅含 condition
// 的聊天触发器不会触发；用 action 更可靠。
//---------------------------------------------------------------------------
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
    call PauseTimer(ib_regTimer)
    call DestroyTimer(ib_regTimer)
    set ib_regTimer = null
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
    set ib_itemName[0] = "金币"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'modt'
    set ib_itemName[1] = "发臭了的章鱼尸体"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'tkno'
    set ib_itemName[2] = "修炼之书"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'shar'
    set ib_itemName[3] = "破箱子"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'sres'
    set ib_itemName[4] = "变异卷轴"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'rde3'
    set ib_itemName[5] = "|cff00ffff风影勋章"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'pmna'
    set ib_itemName[6] = "魔法垂饰"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'rhth'
    set ib_itemName[7] = "生命宝石"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'ankh'
    set ib_itemName[8] = "替身术"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'whwd'
    set ib_itemName[9] = "治疗守卫"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'mcou'
    set ib_itemName[10] = "[未开封]开天斧"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'ciri'
    set ib_itemName[11] = "水晶球碎片"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'ratc'
    set ib_itemName[12] = "藏宝图"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'kpin'
    set ib_itemName[13] = "[未开封]太虚神甲"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'hlst'
    set ib_itemName[14] = "白色的鱼"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'brac'
    set ib_itemName[15] = "|cff00ffff主宰"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'ofir'
    set ib_itemName[16] = "火焰之球"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'ocor'
    set ib_itemName[17] = "腐蚀之球"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'oli2'
    set ib_itemName[18] = "闪电之球"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'oven'
    set ib_itemName[19] = "毒液之球"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'rde2'
    set ib_itemName[20] = "|cff00ffff水影勋章"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'tgrh'
    set ib_itemName[21] = "小型的大厅"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'wswd'
    set ib_itemName[22] = "岗哨守卫"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'stel'
    set ib_itemName[23] = "传送权杖"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'cnob'
    set ib_itemName[24] = "幸运护身符"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'gcel'
    set ib_itemName[25] = "|cff00ffff王者之戒"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'rde1'
    set ib_itemName[26] = "|cff00ffff火影勋章"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'bspd'
    set ib_itemName[27] = "速度之靴"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'texp'
    set ib_itemName[28] = "经验之书"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'stwp'
    set ib_itemName[29] = "回城卷轴"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'shea'
    set ib_itemName[30] = "医疗卷轴"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'dust'
    set ib_itemName[31] = "尘土之影"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'rin1'
    set ib_itemName[32] = "仙人之魂"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'manh'
    set ib_itemName[33] = "生命手册"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'tdex'
    set ib_itemName[34] = "敏捷之书"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'tint'
    set ib_itemName[35] = "智力之书"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'tstr'
    set ib_itemName[36] = "力量之书"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'phea'
    set ib_itemName[37] = "生命药水"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'pman'
    set ib_itemName[38] = "魔法药水"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'hslv'
    set ib_itemName[39] = "医疗剂"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'moon'
    set ib_itemName[40] = "月亮石"
    set ib_itemCustom[40] = 0
    set ib_itemList[41] = 'shas'
    set ib_itemName[41] = "速度卷轴"
    set ib_itemCustom[41] = 0
    set ib_itemList[42] = 'skul'
    set ib_itemName[42] = "献祭头骨"
    set ib_itemCustom[42] = 0
    set ib_itemList[43] = 'mcri'
    set ib_itemName[43] = "机械类的小玩艺"
    set ib_itemCustom[43] = 0
    set ib_itemList[44] = 'rnec'
    set ib_itemName[44] = "巫术妖棍"
    set ib_itemCustom[44] = 0
    set ib_itemList[45] = 'tsct'
    set ib_itemName[45] = "象牙塔"
    set ib_itemCustom[45] = 0
    set ib_itemList[46] = 'bzbe'
    set ib_itemName[46] = "空瓶"
    set ib_itemCustom[46] = 0
    set ib_itemList[47] = 'bzbf'
    set ib_itemName[47] = "盛满泉水的瓶子"
    set ib_itemCustom[47] = 0
    set ib_itemList[48] = 'pomn'
    set ib_itemName[48] = "白鱼"
    set ib_itemCustom[48] = 0
    set ib_itemList[49] = 'pams'
    set ib_itemName[49] = "抗体药水"
    set ib_itemCustom[49] = 0
    set ib_itemList[50] = 'spre'
    set ib_itemName[50] = "保存权杖"
    set ib_itemCustom[50] = 0
    set ib_itemList[51] = 'gold'
    set ib_itemName[51] = "金币"
    set ib_itemCustom[51] = 0
    set ib_itemList[52] = 'lmbr'
    set ib_itemName[52] = "木材堆"
    set ib_itemCustom[52] = 0
    set ib_itemList[53] = 'gomn'
    set ib_itemName[53] = "进入钓鱼场"
    set ib_itemCustom[53] = 0
    set ib_itemList[54] = 'plcl'
    set ib_itemName[54] = "小净化药水"
    set ib_itemCustom[54] = 0
    set ib_itemList[55] = 'sreg'
    set ib_itemName[55] = "恢复卷轴"
    set ib_itemCustom[55] = 0
    set ib_itemList[56] = 'ssan'
    set ib_itemName[56] = "避难权杖"
    set ib_itemCustom[56] = 0
    set ib_itemList[57] = 'I001'
    set ib_itemName[57] = "金创药水"
    set ib_itemCustom[57] = 1
    set ib_itemList[58] = 'I005'
    set ib_itemName[58] = "查克拉药水"
    set ib_itemCustom[58] = 1
    set ib_itemList[59] = 'I00A'
    set ib_itemName[59] = "邀请决斗"
    set ib_itemCustom[59] = 1
    set ib_itemList[60] = 'I00C'
    set ib_itemName[60] = "[中忍]护靴"
    set ib_itemCustom[60] = 1
    set ib_itemList[61] = 'I00D'
    set ib_itemName[61] = "[上忍]护靴"
    set ib_itemCustom[61] = 1
    set ib_itemList[62] = 'I00E'
    set ib_itemName[62] = "[影级]护靴"
    set ib_itemCustom[62] = 1
    set ib_itemList[63] = 'I00F'
    set ib_itemName[63] = "[暗部]护靴"
    set ib_itemCustom[63] = 1
    set ib_itemList[64] = 'I00G'
    set ib_itemName[64] = "[上忍]护腕"
    set ib_itemCustom[64] = 1
    set ib_itemList[65] = 'I00J'
    set ib_itemName[65] = "[下忍]护靴"
    set ib_itemCustom[65] = 1
    set ib_itemList[66] = 'I00B'
    set ib_itemName[66] = "[暗部]护腕"
    set ib_itemCustom[66] = 1
    set ib_itemList[67] = 'I00H'
    set ib_itemName[67] = "[中忍]护腕"
    set ib_itemCustom[67] = 1
    set ib_itemList[68] = 'I00I'
    set ib_itemName[68] = "[下忍]护腕"
    set ib_itemCustom[68] = 1
    set ib_itemList[69] = 'I00K'
    set ib_itemName[69] = "[影级]护腕"
    set ib_itemCustom[69] = 1
    set ib_itemList[70] = 'I00L'
    set ib_itemName[70] = "[影级]护额"
    set ib_itemCustom[70] = 1
    set ib_itemList[71] = 'I00M'
    set ib_itemName[71] = "[中忍]护额"
    set ib_itemCustom[71] = 1
    set ib_itemList[72] = 'I00N'
    set ib_itemName[72] = "[上忍]护额"
    set ib_itemCustom[72] = 1
    set ib_itemList[73] = 'I00O'
    set ib_itemName[73] = "[暗部]护额"
    set ib_itemCustom[73] = 1
    set ib_itemList[74] = 'I00P'
    set ib_itemName[74] = "[下忍]护额"
    set ib_itemCustom[74] = 1
    set ib_itemList[75] = 'I00Q'
    set ib_itemName[75] = "影之玉 +0"
    set ib_itemCustom[75] = 1
    set ib_itemList[76] = 'I00R'
    set ib_itemName[76] = "忍者铠甲"
    set ib_itemCustom[76] = 1
    set ib_itemList[77] = 'I00S'
    set ib_itemName[77] = "忍者铠甲-lv2"
    set ib_itemCustom[77] = 1
    set ib_itemList[78] = 'I00T'
    set ib_itemName[78] = "忍者铠甲-lv3"
    set ib_itemCustom[78] = 1
    set ib_itemList[79] = 'I00U'
    set ib_itemName[79] = "忍者铠甲-lv4"
    set ib_itemCustom[79] = 1
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'I00V'
    set ib_itemName[80] = "龙鳞铠甲"
    set ib_itemCustom[80] = 1
    set ib_itemList[81] = 'I00W'
    set ib_itemName[81] = "忍者铠甲-lv1"
    set ib_itemCustom[81] = 1
    set ib_itemList[82] = 'I00X'
    set ib_itemName[82] = "不动冥王宝石"
    set ib_itemCustom[82] = 1
    set ib_itemList[83] = 'I00Y'
    set ib_itemName[83] = "命运宝石"
    set ib_itemCustom[83] = 1
    set ib_itemList[84] = 'I01B'
    set ib_itemName[84] = "雷神之剑"
    set ib_itemCustom[84] = 1
    set ib_itemList[85] = 'I01C'
    set ib_itemName[85] = "雷神之剑-lv3"
    set ib_itemCustom[85] = 1
    set ib_itemList[86] = 'I01D'
    set ib_itemName[86] = "雷神之剑-lv1"
    set ib_itemCustom[86] = 1
    set ib_itemList[87] = 'I01E'
    set ib_itemName[87] = "雷神之剑-lv2"
    set ib_itemCustom[87] = 1
    set ib_itemList[88] = 'I01F'
    set ib_itemName[88] = "真.雷神剑"
    set ib_itemCustom[88] = 1
    set ib_itemList[89] = 'I01G'
    set ib_itemName[89] = "疾风履"
    set ib_itemCustom[89] = 1
    set ib_itemList[90] = 'I01H'
    set ib_itemName[90] = "升级护腕"
    set ib_itemCustom[90] = 1
    set ib_itemList[91] = 'I01I'
    set ib_itemName[91] = "升级护靴"
    set ib_itemCustom[91] = 1
    set ib_itemList[92] = 'I01J'
    set ib_itemName[92] = "升级护额"
    set ib_itemCustom[92] = 1
    set ib_itemList[93] = 'I01K'
    set ib_itemName[93] = "升级忍者铠甲"
    set ib_itemCustom[93] = 1
    set ib_itemList[94] = 'I01L'
    set ib_itemName[94] = "升级雷神之剑"
    set ib_itemCustom[94] = 1
    set ib_itemList[95] = 'I01M'
    set ib_itemName[95] = "[命运]打造"
    set ib_itemCustom[95] = 1
    set ib_itemList[96] = 'I01N'
    set ib_itemName[96] = "[合成]影之玉"
    set ib_itemCustom[96] = 1
    set ib_itemList[97] = 'I01O'
    set ib_itemName[97] = "替身术(大)"
    set ib_itemCustom[97] = 1
    set ib_itemList[98] = 'I01P'
    set ib_itemName[98] = "分解[命运象征影之玉]"
    set ib_itemCustom[98] = 1
    set ib_itemList[99] = 'I01U'
    set ib_itemName[99] = "建筑升级"
    set ib_itemCustom[99] = 1
    set ib_itemList[100] = 'I01V'
    set ib_itemName[100] = "练功房001"
    set ib_itemCustom[100] = 1
    set ib_itemList[101] = 'I01Y'
    set ib_itemName[101] = "幻影宝石"
    set ib_itemCustom[101] = 1
    set ib_itemList[102] = 'I01Z'
    set ib_itemName[102] = "天怒宝石"
    set ib_itemCustom[102] = 1
    set ib_itemList[103] = 'I020'
    set ib_itemName[103] = "混元宝石"
    set ib_itemCustom[103] = 1
    set ib_itemList[104] = 'I021'
    set ib_itemName[104] = "天幻宝石"
    set ib_itemCustom[104] = 1
    set ib_itemList[105] = 'I022'
    set ib_itemName[105] = "神武宝石"
    set ib_itemCustom[105] = 1
    set ib_itemList[106] = 'I023'
    set ib_itemName[106] = "火之意志"
    set ib_itemCustom[106] = 1
    set ib_itemList[107] = 'I024'
    set ib_itemName[107] = "力量宝石"
    set ib_itemCustom[107] = 1
    set ib_itemList[108] = 'I025'
    set ib_itemName[108] = "不动冥王甲"
    set ib_itemCustom[108] = 1
    set ib_itemList[109] = 'I026'
    set ib_itemName[109] = "火影铠甲"
    set ib_itemCustom[109] = 1
    set ib_itemList[110] = 'I027'
    set ib_itemName[110] = "天幻宝甲"
    set ib_itemCustom[110] = 1
    set ib_itemList[111] = 'I028'
    set ib_itemName[111] = "天怒宝甲"
    set ib_itemCustom[111] = 1
    set ib_itemList[112] = 'I029'
    set ib_itemName[112] = "幻影神甲"
    set ib_itemCustom[112] = 1
    set ib_itemList[113] = 'I02A'
    set ib_itemName[113] = "混元战甲"
    set ib_itemCustom[113] = 1
    set ib_itemList[114] = 'I02B'
    set ib_itemName[114] = "神武战甲"
    set ib_itemCustom[114] = 1
    set ib_itemList[115] = 'I02C'
    set ib_itemName[115] = "勇者铠甲"
    set ib_itemCustom[115] = 1
    set ib_itemList[116] = 'I02D'
    set ib_itemName[116] = "神武之枪"
    set ib_itemCustom[116] = 1
    set ib_itemList[117] = 'I02E'
    set ib_itemName[117] = "混元斩龙戬"
    set ib_itemCustom[117] = 1
    set ib_itemList[118] = 'I02F'
    set ib_itemName[118] = "幻影霸刀"
    set ib_itemCustom[118] = 1
    set ib_itemList[119] = 'I02G'
    set ib_itemName[119] = "天怒法杖"
    set ib_itemCustom[119] = 1
    set ib_itemList[120] = 'I02H'
    set ib_itemName[120] = "天幻法仗"
    set ib_itemCustom[120] = 1
    set ib_itemList[121] = 'I02I'
    set ib_itemName[121] = "勇者之剑"
    set ib_itemCustom[121] = 1
    set ib_itemList[122] = 'I02J'
    set ib_itemName[122] = "火影之剑"
    set ib_itemCustom[122] = 1
    set ib_itemList[123] = 'I02K'
    set ib_itemName[123] = "不动冥王刀"
    set ib_itemCustom[123] = 1
    set ib_itemList[124] = 'I02L'
    set ib_itemName[124] = "幻影战靴"
    set ib_itemCustom[124] = 1
    set ib_itemList[125] = 'I02M'
    set ib_itemName[125] = "天怒战靴"
    set ib_itemCustom[125] = 1
    set ib_itemList[126] = 'I02N'
    set ib_itemName[126] = "天幻战靴"
    set ib_itemCustom[126] = 1
    set ib_itemList[127] = 'I02O'
    set ib_itemName[127] = "勇者战靴"
    set ib_itemCustom[127] = 1
    set ib_itemList[128] = 'I02P'
    set ib_itemName[128] = "不动冥王靴"
    set ib_itemCustom[128] = 1
    set ib_itemList[129] = 'I02Q'
    set ib_itemName[129] = "混元战靴"
    set ib_itemCustom[129] = 1
    set ib_itemList[130] = 'I02R'
    set ib_itemName[130] = "火影战靴"
    set ib_itemCustom[130] = 1
    set ib_itemList[131] = 'I02S'
    set ib_itemName[131] = "神武战靴"
    set ib_itemCustom[131] = 1
    set ib_itemList[132] = 'I02T'
    set ib_itemName[132] = "亲热天堂"
    set ib_itemCustom[132] = 1
    set ib_itemList[133] = 'I02U'
    set ib_itemName[133] = "力量之书+10"
    set ib_itemCustom[133] = 1
    set ib_itemList[134] = 'I02V'
    set ib_itemName[134] = "敏捷之书 +10"
    set ib_itemCustom[134] = 1
    set ib_itemList[135] = 'I02W'
    set ib_itemName[135] = "智力之书 +10"
    set ib_itemCustom[135] = 1
    set ib_itemList[136] = 'I02X'
    set ib_itemName[136] = "挑战初代火影"
    set ib_itemCustom[136] = 1
    set ib_itemList[137] = 'I02Y'
    set ib_itemName[137] = "挑战二代目火影"
    set ib_itemCustom[137] = 1
    set ib_itemList[138] = 'I02Z'
    set ib_itemName[138] = "挑战三代目火影"
    set ib_itemCustom[138] = 1
    set ib_itemList[139] = 'I030'
    set ib_itemName[139] = "挑战四代目火影"
    set ib_itemCustom[139] = 1
    set ib_itemList[140] = 'I032'
    set ib_itemName[140] = "[打造套装]不动冥王套装"
    set ib_itemCustom[140] = 1
    set ib_itemList[141] = 'I033'
    set ib_itemName[141] = "[打造套装]天怒套装"
    set ib_itemCustom[141] = 1
    set ib_itemList[142] = 'I034'
    set ib_itemName[142] = "[打造套装]混元套装"
    set ib_itemCustom[142] = 1
    set ib_itemList[143] = 'I035'
    set ib_itemName[143] = "[打造套装]天幻套装"
    set ib_itemCustom[143] = 1
    set ib_itemList[144] = 'I036'
    set ib_itemName[144] = "[打造套装]幻影套装"
    set ib_itemCustom[144] = 1
    set ib_itemList[145] = 'I037'
    set ib_itemName[145] = "[打造套装]神武套装"
    set ib_itemCustom[145] = 1
    set ib_itemList[146] = 'I038'
    set ib_itemName[146] = "[打造套装]勇者套装"
    set ib_itemCustom[146] = 1
    set ib_itemList[147] = 'I039'
    set ib_itemName[147] = "[打造套装]火影套装"
    set ib_itemCustom[147] = 1
    set ib_itemList[148] = 'I03N'
    set ib_itemName[148] = "开启神器-神力"
    set ib_itemCustom[148] = 1
    set ib_itemList[149] = 'I03O'
    set ib_itemName[149] = "女娲石"
    set ib_itemCustom[149] = 1
    set ib_itemList[150] = 'I03P'
    set ib_itemName[150] = "十拳灵剑"
    set ib_itemCustom[150] = 1
    set ib_itemList[151] = 'I03Q'
    set ib_itemName[151] = "八尺镜"
    set ib_itemCustom[151] = 1
    set ib_itemList[152] = 'I03R'
    set ib_itemName[152] = "a级情报"
    set ib_itemCustom[152] = 1
    set ib_itemList[153] = 'I03S'
    set ib_itemName[153] = "b级情报"
    set ib_itemCustom[153] = 1
    set ib_itemList[154] = 'I03T'
    set ib_itemName[154] = "情报收集"
    set ib_itemCustom[154] = 1
    set ib_itemList[155] = 'I03W'
    set ib_itemName[155] = "治疗神水"
    set ib_itemCustom[155] = 1
    set ib_itemList[156] = 'I03Y'
    set ib_itemName[156] = "接受/提交寻找水源任务"
    set ib_itemCustom[156] = 1
    set ib_itemList[157] = 'I03Z'
    set ib_itemName[157] = "幻境通行证"
    set ib_itemCustom[157] = 1
    set ib_itemList[158] = 'I042'
    set ib_itemName[158] = "遗物项链"
    set ib_itemCustom[158] = 1
    set ib_itemList[159] = 'I043'
    set ib_itemName[159] = "基地无敌50秒"
    set ib_itemCustom[159] = 1
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'I048'
    set ib_itemName[160] = "[打造套装]白虎套装"
    set ib_itemCustom[160] = 1
    set ib_itemList[161] = 'I049'
    set ib_itemName[161] = "[打造套装]青龙套装"
    set ib_itemCustom[161] = 1
    set ib_itemList[162] = 'I04A'
    set ib_itemName[162] = "[打造套装]朱雀套装"
    set ib_itemCustom[162] = 1
    set ib_itemList[163] = 'I04B'
    set ib_itemName[163] = "[打造套装]玄武套装"
    set ib_itemCustom[163] = 1
    set ib_itemList[164] = 'I04C'
    set ib_itemName[164] = "白虎宝石"
    set ib_itemCustom[164] = 1
    set ib_itemList[165] = 'I04D'
    set ib_itemName[165] = "青龙宝石"
    set ib_itemCustom[165] = 1
    set ib_itemList[166] = 'I04E'
    set ib_itemName[166] = "朱雀宝石"
    set ib_itemCustom[166] = 1
    set ib_itemList[167] = 'I04F'
    set ib_itemName[167] = "玄武宝石"
    set ib_itemCustom[167] = 1
    set ib_itemList[168] = 'I04X'
    set ib_itemName[168] = "2015年礼包"
    set ib_itemCustom[168] = 1
    set ib_itemList[169] = 'I05B'
    set ib_itemName[169] = "宝石兑换"
    set ib_itemCustom[169] = 1
    set ib_itemList[170] = 'I05C'
    set ib_itemName[170] = "再不斩的大刀"
    set ib_itemCustom[170] = 1
    set ib_itemList[171] = 'I05G'
    set ib_itemName[171] = "鲛肌"
    set ib_itemCustom[171] = 1
    set ib_itemList[172] = 'I05K'
    set ib_itemName[172] = "最强之矛"
    set ib_itemCustom[172] = 1
    set ib_itemList[173] = 'I05L'
    set ib_itemName[173] = "戒指.零"
    set ib_itemCustom[173] = 1
    set ib_itemList[174] = 'I05M'
    set ib_itemName[174] = "飞雷神.苦无-[需升级]"
    set ib_itemCustom[174] = 1
    set ib_itemList[175] = 'I05P'
    set ib_itemName[175] = "飞雷神.苦无"
    set ib_itemCustom[175] = 1
    set ib_itemList[176] = 'I05Q'
    set ib_itemName[176] = "提交寻找水源"
    set ib_itemCustom[176] = 1
    set ib_itemList[177] = 'I05R'
    set ib_itemName[177] = "龙鳞雷神剑"
    set ib_itemCustom[177] = 1
    set ib_itemList[178] = 'I05S'
    set ib_itemName[178] = "面具"
    set ib_itemCustom[178] = 1
    set ib_itemList[179] = 'I05T'
    set ib_itemName[179] = "治疗药水"
    set ib_itemCustom[179] = 1
    set ib_itemList[180] = 'I05U'
    set ib_itemName[180] = "金刚棒"
    set ib_itemCustom[180] = 1
    set ib_itemList[181] = 'I05V'
    set ib_itemName[181] = "水影斗篷"
    set ib_itemCustom[181] = 1
    set ib_itemList[182] = 'I05D'
    set ib_itemName[182] = "草雉剑"
    set ib_itemCustom[182] = 1
    set ib_itemList[183] = 'I05F'
    set ib_itemName[183] = "万花筒写轮眼"
    set ib_itemCustom[183] = 1
    set ib_itemList[184] = 'I05N'
    set ib_itemName[184] = "砂葫芦"
    set ib_itemCustom[184] = 1
    set ib_itemList[185] = 'I05O'
    set ib_itemName[185] = "火影斗篷"
    set ib_itemCustom[185] = 1
    set ib_itemList[186] = 'I05X'
    set ib_itemName[186] = "忍具.双截棍"
    set ib_itemCustom[186] = 1
    set ib_itemList[187] = 'I05Y'
    set ib_itemName[187] = "圣灵精华"
    set ib_itemCustom[187] = 1
    set ib_itemList[188] = 'I063'
    set ib_itemName[188] = "[打造圣灵套装]圣兽套装"
    set ib_itemCustom[188] = 1
    set ib_itemList[189] = 'I064'
    set ib_itemName[189] = "有奖问答"
    set ib_itemCustom[189] = 1
    set ib_itemList[190] = 'I065'
    set ib_itemName[190] = "戒指.朱"
    set ib_itemCustom[190] = 1
    set ib_itemList[191] = 'I066'
    set ib_itemName[191] = "领取 七星剑"
    set ib_itemCustom[191] = 1
    set ib_itemList[192] = 'I067'
    set ib_itemName[192] = "领取 八尺镜"
    set ib_itemCustom[192] = 1
    set ib_itemList[193] = 'I068'
    set ib_itemName[193] = "领取 六道仙杖"
    set ib_itemCustom[193] = 1
    set ib_itemList[194] = 'I069'
    set ib_itemName[194] = "领取 幌金绳"
    set ib_itemCustom[194] = 1
    set ib_itemList[195] = 'I06C'
    set ib_itemName[195] = "拳套"
    set ib_itemCustom[195] = 1
    set ib_itemList[196] = 'I06F'
    set ib_itemName[196] = "戒指.玉"
    set ib_itemCustom[196] = 1
    set ib_itemList[197] = 'I06G'
    set ib_itemName[197] = "暗部配刀"
    set ib_itemCustom[197] = 1
    set ib_itemList[198] = 'I06J'
    set ib_itemName[198] = "粘土口袋"
    set ib_itemCustom[198] = 1
    set ib_itemList[199] = 'I06K'
    set ib_itemName[199] = "零食"
    set ib_itemCustom[199] = 1
    set ib_itemList[200] = 'I06L'
    set ib_itemName[200] = "进入 羁绊专区"
    set ib_itemCustom[200] = 1
    set ib_itemList[201] = 'I06M'
    set ib_itemName[201] = "赌钱 1赔2"
    set ib_itemCustom[201] = 1
    set ib_itemList[202] = 'I06N'
    set ib_itemName[202] = "赌钱 1赔5"
    set ib_itemCustom[202] = 1
    set ib_itemList[203] = 'I06O'
    set ib_itemName[203] = "神器有木有"
    set ib_itemCustom[203] = 1
    set ib_itemList[204] = 'I06Q'
    set ib_itemName[204] = "鸡蛋"
    set ib_itemCustom[204] = 1
    set ib_itemList[205] = 'I06R'
    set ib_itemName[205] = "七星剑"
    set ib_itemCustom[205] = 1
    set ib_itemList[206] = 'I06S'
    set ib_itemName[206] = "千年精华"
    set ib_itemCustom[206] = 1
    set ib_itemList[207] = 'I06T'
    set ib_itemName[207] = "金鸡蛋"
    set ib_itemCustom[207] = 1
    set ib_itemList[208] = 'I06U'
    set ib_itemName[208] = "山茶花"
    set ib_itemCustom[208] = 1
    set ib_itemList[209] = 'I002'
    set ib_itemName[209] = "[打造套装]六道套装"
    set ib_itemCustom[209] = 1
    set ib_itemList[210] = 'I004'
    set ib_itemName[210] = "仙人遗物"
    set ib_itemCustom[210] = 1
    set ib_itemList[211] = 'I007'
    set ib_itemName[211] = "[六道] - 镇海"
    set ib_itemCustom[211] = 1
    set ib_itemList[212] = 'I009'
    set ib_itemName[212] = "[六道] - 九幽"
    set ib_itemCustom[212] = 1
    set ib_itemList[213] = 'I01W'
    set ib_itemName[213] = "[六道] - 幻雷"
    set ib_itemCustom[213] = 1
    set ib_itemList[214] = 'I01X'
    set ib_itemName[214] = "雷犁刃"
    set ib_itemCustom[214] = 1
    set ib_itemList[215] = 'I03A'
    set ib_itemName[215] = "戒指.白"
    set ib_itemCustom[215] = 1
    set ib_itemList[216] = 'I03B'
    set ib_itemName[216] = "拐杖"
    set ib_itemCustom[216] = 1
    set ib_itemList[217] = 'I03C'
    set ib_itemName[217] = "振奋手套"
    set ib_itemCustom[217] = 1
    set ib_itemList[218] = 'I03D'
    set ib_itemName[218] = "前往 秒木山"
    set ib_itemCustom[218] = 1
    set ib_itemList[219] = 'I03E'
    set ib_itemName[219] = "妙木山修炼"
    set ib_itemCustom[219] = 1
    set ib_itemList[220] = 'I03F'
    set ib_itemName[220] = "修炼仙人"
    set ib_itemCustom[220] = 1
    set ib_itemList[221] = 'I03G'
    set ib_itemName[221] = "接受/提交捕食"
    set ib_itemCustom[221] = 1
    set ib_itemList[222] = 'I03H'
    set ib_itemName[222] = "重新预言"
    set ib_itemCustom[222] = 1
    set ib_itemList[223] = 'I03I'
    set ib_itemName[223] = "前往 神秘森林"
    set ib_itemCustom[223] = 1
    set ib_itemList[224] = 'I03J'
    set ib_itemName[224] = "冬冬的考验"
    set ib_itemCustom[224] = 1
    set ib_itemList[225] = 'I03K'
    set ib_itemName[225] = "幌金绳"
    set ib_itemCustom[225] = 1
    set ib_itemList[226] = 'I03L'
    set ib_itemName[226] = "勾玉项链"
    set ib_itemCustom[226] = 1
    set ib_itemList[227] = 'I03M'
    set ib_itemName[227] = "（仙)镇海伏魔刀"
    set ib_itemCustom[227] = 1
    set ib_itemList[228] = 'I03X'
    set ib_itemName[228] = "（仙)镇海伏魔甲"
    set ib_itemCustom[228] = 1
    set ib_itemList[229] = 'I040'
    set ib_itemName[229] = "（仙)镇海伏魔靴"
    set ib_itemCustom[229] = 1
    set ib_itemList[230] = 'I04S'
    set ib_itemName[230] = "（仙)镇海伏魔刀"
    set ib_itemCustom[230] = 1
    set ib_itemList[231] = 'I056'
    set ib_itemName[231] = "（仙)镇海伏魔刀"
    set ib_itemCustom[231] = 1
    set ib_itemList[232] = 'I057'
    set ib_itemName[232] = "（仙)镇海伏魔甲"
    set ib_itemCustom[232] = 1
    set ib_itemList[233] = 'I058'
    set ib_itemName[233] = "（仙)镇海伏魔甲"
    set ib_itemCustom[233] = 1
    set ib_itemList[234] = 'I05E'
    set ib_itemName[234] = "（仙)镇海伏魔靴"
    set ib_itemCustom[234] = 1
    set ib_itemList[235] = 'I05H'
    set ib_itemName[235] = "（仙)镇海伏魔靴"
    set ib_itemCustom[235] = 1
    set ib_itemList[236] = 'I05I'
    set ib_itemName[236] = "（仙)九幽伏魔枪"
    set ib_itemCustom[236] = 1
    set ib_itemList[237] = 'I05J'
    set ib_itemName[237] = "（仙)九幽伏魔甲"
    set ib_itemCustom[237] = 1
    set ib_itemList[238] = 'I05W'
    set ib_itemName[238] = "（仙)九幽伏魔靴"
    set ib_itemCustom[238] = 1
    set ib_itemList[239] = 'I06P'
    set ib_itemName[239] = "（仙)九幽伏魔枪"
    set ib_itemCustom[239] = 1
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'I06V'
    set ib_itemName[240] = "（仙)九幽伏魔枪"
    set ib_itemCustom[240] = 1
    set ib_itemList[241] = 'I06W'
    set ib_itemName[241] = "（仙)九幽伏魔甲"
    set ib_itemCustom[241] = 1
    set ib_itemList[242] = 'I06X'
    set ib_itemName[242] = "（仙)九幽伏魔甲"
    set ib_itemCustom[242] = 1
    set ib_itemList[243] = 'I06Y'
    set ib_itemName[243] = "（仙)九幽伏魔靴"
    set ib_itemCustom[243] = 1
    set ib_itemList[244] = 'I06Z'
    set ib_itemName[244] = "（仙)九幽伏魔靴"
    set ib_itemCustom[244] = 1
    set ib_itemList[245] = 'I070'
    set ib_itemName[245] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[245] = 1
    set ib_itemList[246] = 'I071'
    set ib_itemName[246] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[246] = 1
    set ib_itemList[247] = 'I072'
    set ib_itemName[247] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[247] = 1
    set ib_itemList[248] = 'I073'
    set ib_itemName[248] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[248] = 1
    set ib_itemList[249] = 'I074'
    set ib_itemName[249] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[249] = 1
    set ib_itemList[250] = 'I075'
    set ib_itemName[250] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[250] = 1
    set ib_itemList[251] = 'I076'
    set ib_itemName[251] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[251] = 1
    set ib_itemList[252] = 'I077'
    set ib_itemName[252] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[252] = 1
    set ib_itemList[253] = 'I078'
    set ib_itemName[253] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[253] = 1
    set ib_itemList[254] = 'I079'
    set ib_itemName[254] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[254] = 1
    set ib_itemList[255] = 'I07A'
    set ib_itemName[255] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[255] = 1
    set ib_itemList[256] = 'I07B'
    set ib_itemName[256] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[256] = 1
    set ib_itemList[257] = 'I07C'
    set ib_itemName[257] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[257] = 1
    set ib_itemList[258] = 'I07D'
    set ib_itemName[258] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[258] = 1
    set ib_itemList[259] = 'I07E'
    set ib_itemName[259] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[259] = 1
    set ib_itemList[260] = 'I07F'
    set ib_itemName[260] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[260] = 1
    set ib_itemList[261] = 'I07G'
    set ib_itemName[261] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[261] = 1
    set ib_itemList[262] = 'I07H'
    set ib_itemName[262] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[262] = 1
    set ib_itemList[263] = 'I07I'
    set ib_itemName[263] = "修炼石"
    set ib_itemCustom[263] = 1
    set ib_itemList[264] = 'I07J'
    set ib_itemName[264] = "强化之石"
    set ib_itemCustom[264] = 1
    set ib_itemList[265] = 'I07K'
    set ib_itemName[265] = "[打造]仙人套装"
    set ib_itemCustom[265] = 1
    set ib_itemList[266] = 'I07L'
    set ib_itemName[266] = "（仙)九幽"
    set ib_itemCustom[266] = 1
    set ib_itemList[267] = 'I07M'
    set ib_itemName[267] = "（仙)炽焰"
    set ib_itemCustom[267] = 1
    set ib_itemList[268] = 'I07N'
    set ib_itemName[268] = "（仙)镇海"
    set ib_itemCustom[268] = 1
    set ib_itemList[269] = 'I07O'
    set ib_itemName[269] = "（仙)幻雷"
    set ib_itemCustom[269] = 1
    set ib_itemList[270] = 'I07P'
    set ib_itemName[270] = "融合石"
    set ib_itemCustom[270] = 1
    set ib_itemList[271] = 'I07Q'
    set ib_itemName[271] = "仙人卷轴"
    set ib_itemCustom[271] = 1
    set ib_itemList[272] = 'I07R'
    set ib_itemName[272] = "仙人凭证"
    set ib_itemCustom[272] = 1
    set ib_itemList[273] = 'I07S'
    set ib_itemName[273] = "打火机"
    set ib_itemCustom[273] = 1
    set ib_itemList[274] = 'I07T'
    set ib_itemName[274] = "神秘面具"
    set ib_itemCustom[274] = 1
    set ib_itemList[275] = 'I07U'
    set ib_itemName[275] = "宇智波团扇"
    set ib_itemCustom[275] = 1
    set ib_itemList[276] = 'I07V'
    set ib_itemName[276] = "极限挑战"
    set ib_itemCustom[276] = 1
    set ib_itemList[277] = 'I07W'
    set ib_itemName[277] = "尾兽之力"
    set ib_itemCustom[277] = 1
    set ib_itemList[278] = 'I07X'
    set ib_itemName[278] = "兑换强化之石"
    set ib_itemCustom[278] = 1
    set ib_itemList[279] = 'I07Y'
    set ib_itemName[279] = "兑换融合石"
    set ib_itemCustom[279] = 1
    set ib_itemList[280] = 'I07Z'
    set ib_itemName[280] = "合成尾兽之力"
    set ib_itemCustom[280] = 1
    set ib_itemList[281] = 'I080'
    set ib_itemName[281] = "尾兽精华"
    set ib_itemCustom[281] = 1
    set ib_itemList[282] = 'I085'
    set ib_itemName[282] = "尾兽结晶"
    set ib_itemCustom[282] = 1
    set ib_itemList[283] = 'I086'
    set ib_itemName[283] = "仙人最终试练"
    set ib_itemCustom[283] = 1
    set ib_itemList[284] = 'I087'
    set ib_itemName[284] = "领取 上古魂石"
    set ib_itemCustom[284] = 1
    set ib_itemList[285] = 'I088'
    set ib_itemName[285] = "遗书"
    set ib_itemCustom[285] = 1
    set ib_itemList[286] = 'I089'
    set ib_itemName[286] = "土影披风"
    set ib_itemCustom[286] = 1
    set ib_itemList[287] = 'I08A'
    set ib_itemName[287] = "建筑强化"
    set ib_itemCustom[287] = 1
    set ib_itemList[288] = 'I08B'
    set ib_itemName[288] = "[六道] - 炽焰"
    set ib_itemCustom[288] = 1
    set ib_itemList[289] = 'I08C'
    set ib_itemName[289] = "禁术卷轴"
    set ib_itemCustom[289] = 1
    set ib_itemList[290] = 'I08D'
    set ib_itemName[290] = "兑换 勾玉项链"
    set ib_itemCustom[290] = 1
    set ib_itemList[291] = 'I08E'
    set ib_itemName[291] = "兑换仙人遗物"
    set ib_itemCustom[291] = 1
    set ib_itemList[292] = 'I08F'
    set ib_itemName[292] = "挑战龙兜"
    set ib_itemCustom[292] = 1
    set ib_itemList[293] = 'I08G'
    set ib_itemName[293] = "积分宝石兑换"
    set ib_itemCustom[293] = 1
    set ib_itemList[294] = 'I08H'
    set ib_itemName[294] = "任务 - 追捕逃忍"
    set ib_itemCustom[294] = 1
    set ib_itemList[295] = 'I08I'
    set ib_itemName[295] = "亲热暴力"
    set ib_itemCustom[295] = 1
    set ib_itemList[296] = 'I08K'
    set ib_itemName[296] = "红色的鱼"
    set ib_itemCustom[296] = 1
    set ib_itemList[297] = 'I08L'
    set ib_itemName[297] = "蓝色的鱼"
    set ib_itemCustom[297] = 1
    set ib_itemList[298] = 'I08M'
    set ib_itemName[298] = "黑色的鱼"
    set ib_itemCustom[298] = 1
    set ib_itemList[299] = 'I08N'
    set ib_itemName[299] = "变异的鱼"
    set ib_itemCustom[299] = 1
    set ib_itemList[300] = 'I08O'
    set ib_itemName[300] = "捕鱼者的请求"
    set ib_itemCustom[300] = 1
    set ib_itemList[301] = 'I08P'
    set ib_itemName[301] = "挑战自我 x 5"
    set ib_itemCustom[301] = 1
    set ib_itemList[302] = 'I08Q'
    set ib_itemName[302] = "挑战自我 x 10"
    set ib_itemCustom[302] = 1
    set ib_itemList[303] = 'I08R'
    set ib_itemName[303] = "查克拉守卫"
    set ib_itemCustom[303] = 1
    set ib_itemList[304] = 'I08S'
    set ib_itemName[304] = "雷影披风"
    set ib_itemCustom[304] = 1
    set ib_itemList[305] = 'I08T'
    set ib_itemName[305] = "创世仙甲"
    set ib_itemCustom[305] = 1
    set ib_itemList[306] = 'I08U'
    set ib_itemName[306] = "创世仙杖"
    set ib_itemCustom[306] = 1
    set ib_itemList[307] = 'I08V'
    set ib_itemName[307] = "创世仙靴"
    set ib_itemCustom[307] = 1
    set ib_itemList[308] = 'I08W'
    set ib_itemName[308] = "创世仙玉"
    set ib_itemCustom[308] = 1
    set ib_itemList[309] = 'I08X'
    set ib_itemName[309] = "领取奖励"
    set ib_itemCustom[309] = 1
    set ib_itemList[310] = 'I08Y'
    set ib_itemName[310] = "兑换尾兽精华"
    set ib_itemCustom[310] = 1
    set ib_itemList[311] = 'I08Z'
    set ib_itemName[311] = "合成创世仙魂"
    set ib_itemCustom[311] = 1
    set ib_itemList[312] = 'I090'
    set ib_itemName[312] = "创世仙魂"
    set ib_itemCustom[312] = 1
    set ib_itemList[313] = 'I091'
    set ib_itemName[313] = "创世仙魂"
    set ib_itemCustom[313] = 1
    set ib_itemList[314] = 'I092'
    set ib_itemName[314] = "羞涩的爱"
    set ib_itemCustom[314] = 1
    set ib_itemList[315] = 'I093'
    set ib_itemName[315] = "挑战自我 x 5秒木"
    set ib_itemCustom[315] = 1
    set ib_itemList[316] = 'I094'
    set ib_itemName[316] = "挑战自我 x 20苗木"
    set ib_itemCustom[316] = 1
    set ib_itemList[317] = 'I095'
    set ib_itemName[317] = "祥云坠饰"
    set ib_itemCustom[317] = 1
    set ib_itemList[318] = 'I096'
    set ib_itemName[318] = "前往 龙地洞"
    set ib_itemCustom[318] = 1
    set ib_itemList[319] = 'I097'
    set ib_itemName[319] = "金币2"
    set ib_itemCustom[319] = 1
endfunction
function IB_Fill4 takes nothing returns nothing
    set ib_itemList[320] = 'I098'
    set ib_itemName[320] = "木材堆2"
    set ib_itemCustom[320] = 1
    set ib_itemList[321] = 'I041'
    set ib_itemName[321] = "勇者宝藏"
    set ib_itemCustom[321] = 1
    set ib_itemList[322] = 'I099'
    set ib_itemName[322] = "仙人宝箱"
    set ib_itemCustom[322] = 1
    set ib_itemList[323] = 'I09A'
    set ib_itemName[323] = "血雾之乡"
    set ib_itemCustom[323] = 1
    set ib_itemList[324] = 'I09B'
    set ib_itemName[324] = "恐惧与信念"
    set ib_itemCustom[324] = 1
    set ib_itemList[325] = 'I09C'
    set ib_itemName[325] = "琼曲玉"
    set ib_itemCustom[325] = 1
    set ib_itemList[326] = 'I09D'
    set ib_itemName[326] = "合成 琼曲玉"
    set ib_itemCustom[326] = 1
    set ib_itemList[327] = 'I09E'
    set ib_itemName[327] = "火影披风"
    set ib_itemCustom[327] = 1
    set ib_itemList[328] = 'I09F'
    set ib_itemName[328] = "修行卷轴"
    set ib_itemCustom[328] = 1
    set ib_itemList[329] = 'I09K'
    set ib_itemName[329] = "草雉剑"
    set ib_itemCustom[329] = 1
    set ib_itemList[330] = 'I09L'
    set ib_itemName[330] = "影之玉 +13"
    set ib_itemCustom[330] = 1
    set ib_itemList[331] = 'I09M'
    set ib_itemName[331] = "影之玉 +6"
    set ib_itemCustom[331] = 1
    set ib_itemList[332] = 'I09N'
    set ib_itemName[332] = "影之玉 +2"
    set ib_itemCustom[332] = 1
    set ib_itemList[333] = 'I09O'
    set ib_itemName[333] = "影之玉 +14"
    set ib_itemCustom[333] = 1
    set ib_itemList[334] = 'I09P'
    set ib_itemName[334] = "影之玉 +4"
    set ib_itemCustom[334] = 1
    set ib_itemList[335] = 'I09Q'
    set ib_itemName[335] = "影之玉 +5"
    set ib_itemCustom[335] = 1
    set ib_itemList[336] = 'I09R'
    set ib_itemName[336] = "影之玉 +7"
    set ib_itemCustom[336] = 1
    set ib_itemList[337] = 'I09S'
    set ib_itemName[337] = "影之玉 +8"
    set ib_itemCustom[337] = 1
    set ib_itemList[338] = 'I09T'
    set ib_itemName[338] = "影之玉 +9"
    set ib_itemCustom[338] = 1
    set ib_itemList[339] = 'I09U'
    set ib_itemName[339] = "影之玉 +10"
    set ib_itemCustom[339] = 1
    set ib_itemList[340] = 'I09V'
    set ib_itemName[340] = "影之玉 +11"
    set ib_itemCustom[340] = 1
    set ib_itemList[341] = 'I09W'
    set ib_itemName[341] = "影之玉 +1"
    set ib_itemCustom[341] = 1
    set ib_itemList[342] = 'I09X'
    set ib_itemName[342] = "影之玉 +3"
    set ib_itemCustom[342] = 1
    set ib_itemList[343] = 'I09Y'
    set ib_itemName[343] = "影之玉 +12"
    set ib_itemCustom[343] = 1
    set ib_itemList[344] = 'I09Z'
    set ib_itemName[344] = "影之玉 +15"
    set ib_itemCustom[344] = 1
    set ib_itemList[345] = 'I0A0'
    set ib_itemName[345] = "创世仙魂"
    set ib_itemCustom[345] = 1
    set ib_itemList[346] = 'I0A1'
    set ib_itemName[346] = "创世仙魂"
    set ib_itemCustom[346] = 1
    set ib_itemList[347] = 'I0A2'
    set ib_itemName[347] = "封印卷轴"
    set ib_itemCustom[347] = 1
    set ib_itemList[348] = 'I0A3'
    set ib_itemName[348] = "兑换封印卷轴"
    set ib_itemCustom[348] = 1
    set ib_itemList[349] = 'I0A4'
    set ib_itemName[349] = "兑换影之玉 +15"
    set ib_itemCustom[349] = 1
    set ib_itemList[350] = 'I0A5'
    set ib_itemName[350] = "始祖之吻"
    set ib_itemCustom[350] = 1
    set ib_itemList[351] = 'I0A6'
    set ib_itemName[351] = "仙人宝藏"
    set ib_itemCustom[351] = 1
    set ib_itemList[352] = 'I0A7'
    set ib_itemName[352] = "惊呆小伙伴礼包"
    set ib_itemCustom[352] = 1
    set ib_itemList[353] = 'I0A8'
    set ib_itemName[353] = "[强化]影之玉"
    set ib_itemCustom[353] = 1
    set ib_itemList[354] = 'I0A9'
    set ib_itemName[354] = "[兑换]始祖之吻"
    set ib_itemCustom[354] = 1
    set ib_itemList[355] = 'I0AA'
    set ib_itemName[355] = "心之剑"
    set ib_itemCustom[355] = 1
    set ib_itemList[356] = 'I0AB'
    set ib_itemName[356] = "超级修炼之书"
    set ib_itemCustom[356] = 1
    set ib_itemList[357] = 'I0AC'
    set ib_itemName[357] = "兑换幸运护身符"
    set ib_itemCustom[357] = 1
    set ib_itemList[358] = 'I0AD'
    set ib_itemName[358] = "购买幸运护身符"
    set ib_itemCustom[358] = 1
    set ib_itemList[359] = 'I0AE'
    set ib_itemName[359] = "血腥三月镰"
    set ib_itemCustom[359] = 1
    set ib_itemList[360] = 'I0AF'
    set ib_itemName[360] = "戒指.北"
    set ib_itemCustom[360] = 1
    set ib_itemList[361] = 'I0AG'
    set ib_itemName[361] = "六道锡杖"
    set ib_itemCustom[361] = 1
    set ib_itemList[362] = 'I0AH'
    set ib_itemName[362] = "瞬身苦无"
    set ib_itemCustom[362] = 1
    set ib_itemList[363] = 'I0AI'
    set ib_itemName[363] = "小黄"
    set ib_itemCustom[363] = 1
    set ib_itemList[364] = 'I0AJ'
    set ib_itemName[364] = "食人魔的锁甲"
    set ib_itemCustom[364] = 1
    set ib_itemList[365] = 'I0AK'
    set ib_itemName[365] = "潜入 雨忍村"
    set ib_itemCustom[365] = 1
    set ib_itemList[366] = 'I0AL'
    set ib_itemName[366] = "125级团队任务 - 秽土转生"
    set ib_itemCustom[366] = 1
    set ib_itemList[367] = 'I0AM'
    set ib_itemName[367] = "25级团队任务 - 死之森林"
    set ib_itemCustom[367] = 1
    set ib_itemList[368] = 'I0AN'
    set ib_itemName[368] = "50级团队任务 - 等了好久！a级任务"
    set ib_itemCustom[368] = 1
    set ib_itemList[369] = 'I0AO'
    set ib_itemName[369] = "75级团队任务 - 晓之神秘组织"
    set ib_itemCustom[369] = 1
    set ib_itemList[370] = 'I0AP'
    set ib_itemName[370] = "100级团队任务 - 第四次忍界大战"
    set ib_itemCustom[370] = 1
    set ib_itemList[371] = 'I0AQ'
    set ib_itemName[371] = "150级团队任务 - 幕后操纵者"
    set ib_itemCustom[371] = 1
    set ib_itemList[372] = 'I0AR'
    set ib_itemName[372] = "传承 六道阳之力"
    set ib_itemCustom[372] = 1
    set ib_itemList[373] = 'I0AS'
    set ib_itemName[373] = "传承 六道阴之力"
    set ib_itemCustom[373] = 1
    set ib_itemList[374] = 'I0AT'
    set ib_itemName[374] = "进入 精神世界"
    set ib_itemCustom[374] = 1
    set ib_itemList[375] = 'I0AU'
    set ib_itemName[375] = "六道仙人箴言"
    set ib_itemCustom[375] = 1
    set ib_itemList[376] = 'I0AV'
    set ib_itemName[376] = "进入 宝藏洞"
    set ib_itemCustom[376] = 1
    set ib_itemList[377] = 'I0AW'
    set ib_itemName[377] = "琥珀净瓶"
    set ib_itemCustom[377] = 1
    set ib_itemList[378] = 'I0AX'
    set ib_itemName[378] = "红葫芦"
    set ib_itemCustom[378] = 1
    set ib_itemList[379] = 'I0AY'
    set ib_itemName[379] = "芭蕉扇"
    set ib_itemCustom[379] = 1
    set ib_itemList[380] = 'I0AZ'
    set ib_itemName[380] = "六道仙杖"
    set ib_itemCustom[380] = 1
    set ib_itemList[381] = 'I0B0'
    set ib_itemName[381] = "六道仙杖"
    set ib_itemCustom[381] = 1
    set ib_itemList[382] = 'I0B1'
    set ib_itemName[382] = "六道仙杖"
    set ib_itemCustom[382] = 1
    set ib_itemList[383] = 'I0B2'
    set ib_itemName[383] = "六道仙杖"
    set ib_itemCustom[383] = 1
    set ib_itemList[384] = 'I0B3'
    set ib_itemName[384] = "六道仙杖"
    set ib_itemCustom[384] = 1
    set ib_itemList[385] = 'I0B4'
    set ib_itemName[385] = "六道仙杖"
    set ib_itemCustom[385] = 1
    set ib_itemList[386] = 'I0B5'
    set ib_itemName[386] = "六道仙杖"
    set ib_itemCustom[386] = 1
    set ib_itemList[387] = 'I0B6'
    set ib_itemName[387] = "六道仙杖"
    set ib_itemCustom[387] = 1
    set ib_itemList[388] = 'I0B7'
    set ib_itemName[388] = "六道仙杖"
    set ib_itemCustom[388] = 1
    set ib_itemList[389] = 'I0B8'
    set ib_itemName[389] = "六道仙杖"
    set ib_itemCustom[389] = 1
    set ib_itemList[390] = 'I0B9'
    set ib_itemName[390] = "领取 琥珀净瓶"
    set ib_itemCustom[390] = 1
    set ib_itemList[391] = 'I0BA'
    set ib_itemName[391] = "传达 - (轻语)"
    set ib_itemCustom[391] = 1
    set ib_itemList[392] = 'I0BB'
    set ib_itemName[392] = "传达 - 信息(冬冬)"
    set ib_itemCustom[392] = 1
    set ib_itemList[393] = 'I0BC'
    set ib_itemName[393] = "传达 - 信息(唯恋)"
    set ib_itemCustom[393] = 1
    set ib_itemList[394] = 'I0BD'
    set ib_itemName[394] = "进入 野外训练场"
    set ib_itemCustom[394] = 1
    set ib_itemList[395] = 'I0BE'
    set ib_itemName[395] = "开启隐藏boss"
    set ib_itemCustom[395] = 1
    set ib_itemList[396] = 'I0BF'
    set ib_itemName[396] = "挑战自我 x 5大水"
    set ib_itemCustom[396] = 1
    set ib_itemList[397] = 'I0BG'
    set ib_itemName[397] = "挑战自我 x 10大水"
    set ib_itemCustom[397] = 1
    set ib_itemList[398] = 'I0BH'
    set ib_itemName[398] = "觉醒 转世力量"
    set ib_itemCustom[398] = 1
    set ib_itemList[399] = 'I0BI'
    set ib_itemName[399] = "神之语"
    set ib_itemCustom[399] = 1
endfunction
function IB_Fill5 takes nothing returns nothing
    set ib_itemList[400] = 'I0BJ'
    set ib_itemName[400] = "探索.眼镜"
    set ib_itemCustom[400] = 1
    set ib_itemList[401] = 'I0BK'
    set ib_itemName[401] = "合成 神之语"
    set ib_itemCustom[401] = 1
    set ib_itemList[402] = 'I000'
    set ib_itemName[402] = "[兑换]祥云坠饰"
    set ib_itemCustom[402] = 1
    set ib_itemList[403] = 'I003'
    set ib_itemName[403] = "神之宝藏"
    set ib_itemCustom[403] = 1
    set ib_itemList[404] = 'I006'
    set ib_itemName[404] = "神之强化石"
    set ib_itemCustom[404] = 1
    set ib_itemList[405] = 'I008'
    set ib_itemName[405] = "绷带"
    set ib_itemCustom[405] = 1
    set ib_itemList[406] = 'I03U'
    set ib_itemName[406] = "戒指.玄"
    set ib_itemCustom[406] = 1
    set ib_itemList[407] = 'I03V'
    set ib_itemName[407] = "换取-祥云坠饰"
    set ib_itemCustom[407] = 1
    set ib_itemList[408] = 'I0BL'
    set ib_itemName[408] = "换取-恐惧与信念"
    set ib_itemCustom[408] = 1
    set ib_itemList[409] = 'I0BM'
    set ib_itemName[409] = "换取-血雾之乡"
    set ib_itemCustom[409] = 1
    set ib_itemList[410] = 'I0BN'
    set ib_itemName[410] = "附有划痕的护额"
    set ib_itemCustom[410] = 1
endfunction

function IB_SkillFill0 takes nothing returns nothing
    set ib_skillList[0] = 'A003'
    set ib_skillName[0] = "螺旋丸"
    set ib_skillCustom[0] = 1
    set ib_skillList[1] = 'A004'
    set ib_skillName[1] = "多重影分身术"
    set ib_skillCustom[1] = 1
    set ib_skillList[2] = 'A005'
    set ib_skillName[2] = "瞳术.天照"
    set ib_skillCustom[2] = 1
    set ib_skillList[3] = 'A006'
    set ib_skillName[3] = "神威"
    set ib_skillCustom[3] = 1
    set ib_skillList[4] = 'A008'
    set ib_skillName[4] = "暗器术.神乐手里剑"
    set ib_skillCustom[4] = 1
    set ib_skillList[5] = 'A00A'
    set ib_skillName[5] = "柔拳法.八卦六十四掌"
    set ib_skillCustom[5] = 1
    set ib_skillList[6] = 'A00B'
    set ib_skillName[6] = "-黄色闪光"
    set ib_skillCustom[6] = 1
    set ib_skillList[7] = 'A00E'
    set ib_skillName[7] = "八卦空掌"
    set ib_skillCustom[7] = 1
    set ib_skillList[8] = 'A00H'
    set ib_skillName[8] = "雷遁.雷切.双穿光"
    set ib_skillCustom[8] = 1
    set ib_skillList[9] = 'A00J'
    set ib_skillName[9] = "火遁.豪火球之术"
    set ib_skillCustom[9] = 1
    set ib_skillList[10] = 'A00K'
    set ib_skillName[10] = "瞳术.天照"
    set ib_skillCustom[10] = 1
    set ib_skillList[11] = 'A00P'
    set ib_skillName[11] = "仙人模式"
    set ib_skillCustom[11] = 1
    set ib_skillList[12] = 'A00Q'
    set ib_skillName[12] = "万花筒写轮眼"
    set ib_skillCustom[12] = 1
    set ib_skillList[13] = 'A00R'
    set ib_skillName[13] = "万花筒写轮眼"
    set ib_skillCustom[13] = 1
    set ib_skillList[14] = 'A00S'
    set ib_skillName[14] = "白眼"
    set ib_skillCustom[14] = 1
    set ib_skillList[15] = 'A00T'
    set ib_skillName[15] = "幻术.月读"
    set ib_skillCustom[15] = 1
    set ib_skillList[16] = 'A00W'
    set ib_skillName[16] = "关闭白眼"
    set ib_skillCustom[16] = 1
    set ib_skillList[17] = 'A00Y'
    set ib_skillName[17] = "白眼附加技能"
    set ib_skillCustom[17] = 1
    set ib_skillList[18] = 'A010'
    set ib_skillName[18] = "白眼视野"
    set ib_skillCustom[18] = 1
    set ib_skillList[19] = 'A012'
    set ib_skillName[19] = "关闭写轮眼"
    set ib_skillCustom[19] = 1
    set ib_skillList[20] = 'A013'
    set ib_skillName[20] = "写轮眼附加技能"
    set ib_skillCustom[20] = 1
    set ib_skillList[21] = 'A016'
    set ib_skillName[21] = "万花眼附加技能"
    set ib_skillCustom[21] = 1
    set ib_skillList[22] = 'A01C'
    set ib_skillName[22] = "冰霜之镜"
    set ib_skillCustom[22] = 1
    set ib_skillList[23] = 'A01E'
    set ib_skillName[23] = "-须作附加技能"
    set ib_skillCustom[23] = 1
    set ib_skillList[24] = 'A01G'
    set ib_skillName[24] = "六芒星写轮眼"
    set ib_skillCustom[24] = 1
    set ib_skillList[25] = 'A01J'
    set ib_skillName[25] = "雷遁.麒麟"
    set ib_skillCustom[25] = 1
    set ib_skillList[26] = 'A01K'
    set ib_skillName[26] = "邀请决斗"
    set ib_skillCustom[26] = 1
    set ib_skillList[27] = 'A01L'
    set ib_skillName[27] = "雷神之怒"
    set ib_skillCustom[27] = 1
    set ib_skillList[28] = 'A01M'
    set ib_skillName[28] = "金刚帮"
    set ib_skillCustom[28] = 1
    set ib_skillList[29] = 'A01N'
    set ib_skillName[29] = "白虎+1100 600 600"
    set ib_skillCustom[29] = 1
    set ib_skillList[30] = 'A01O'
    set ib_skillName[30] = "朱雀+600 600 1100"
    set ib_skillCustom[30] = 1
    set ib_skillList[31] = 'A01P'
    set ib_skillName[31] = "混元+600 1100 600"
    set ib_skillCustom[31] = 1
    set ib_skillList[32] = 'A01Q'
    set ib_skillName[32] = "玄武+1060"
    set ib_skillCustom[32] = 1
    set ib_skillList[33] = 'A01Z'
    set ib_skillName[33] = "敏捷+40"
    set ib_skillCustom[33] = 1
    set ib_skillList[34] = 'A020'
    set ib_skillName[34] = "敏捷+50"
    set ib_skillCustom[34] = 1
    set ib_skillList[35] = 'A021'
    set ib_skillName[35] = "力量+40"
    set ib_skillCustom[35] = 1
    set ib_skillList[36] = 'A022'
    set ib_skillName[36] = "力量+50"
    set ib_skillCustom[36] = 1
    set ib_skillList[37] = 'A023'
    set ib_skillName[37] = "智力+50"
    set ib_skillCustom[37] = 1
    set ib_skillList[38] = 'A024'
    set ib_skillName[38] = "智力+40"
    set ib_skillCustom[38] = 1
    set ib_skillList[39] = 'A025'
    set ib_skillName[39] = "全属性+100"
    set ib_skillCustom[39] = 1
    set ib_skillList[40] = 'A026'
    set ib_skillName[40] = "全属性+80"
    set ib_skillCustom[40] = 1
    set ib_skillList[41] = 'A027'
    set ib_skillName[41] = "全属性+30"
    set ib_skillCustom[41] = 1
    set ib_skillList[42] = 'A028'
    set ib_skillName[42] = "全属性+50"
    set ib_skillCustom[42] = 1
    set ib_skillList[43] = 'A02A'
    set ib_skillName[43] = "忍术否定"
    set ib_skillCustom[43] = 1
    set ib_skillList[44] = 'A02C'
    set ib_skillName[44] = "玉"
    set ib_skillCustom[44] = 1
    set ib_skillList[45] = 'A031'
    set ib_skillName[45] = "混元+300 550 300"
    set ib_skillCustom[45] = 1
    set ib_skillList[46] = 'A032'
    set ib_skillName[46] = "火影+530"
    set ib_skillCustom[46] = 1
    set ib_skillList[47] = 'A033'
    set ib_skillName[47] = "幻影+150 100 100"
    set ib_skillCustom[47] = 1
    set ib_skillList[48] = 'A034'
    set ib_skillName[48] = "天幻+150 100 100"
    set ib_skillCustom[48] = 1
    set ib_skillList[49] = 'A035'
    set ib_skillName[49] = "神武+100 150 100"
    set ib_skillCustom[49] = 1
    set ib_skillList[50] = 'A036'
    set ib_skillName[50] = "不动冥王+550 300 300"
    set ib_skillCustom[50] = 1
    set ib_skillList[51] = 'A037'
    set ib_skillName[51] = "天怒+300 300 550"
    set ib_skillCustom[51] = 1
    set ib_skillList[52] = 'A038'
    set ib_skillName[52] = "勇者+130"
    set ib_skillCustom[52] = 1
    set ib_skillList[53] = 'A042'
    set ib_skillName[53] = "水箭"
    set ib_skillCustom[53] = 1
    set ib_skillList[54] = 'A043'
    set ib_skillName[54] = "镰鼬术技能"
    set ib_skillCustom[54] = 1
    set ib_skillList[55] = 'A04A'
    set ib_skillName[55] = "幻术.月读"
    set ib_skillCustom[55] = 1
    set ib_skillList[56] = 'A04C'
    set ib_skillName[56] = "十拳攻击"
    set ib_skillCustom[56] = 1
    set ib_skillList[57] = 'A04E'
    set ib_skillName[57] = "全属性+300"
    set ib_skillCustom[57] = 1
    set ib_skillList[58] = 'A04F'
    set ib_skillName[58] = "御灵"
    set ib_skillCustom[58] = 1
    set ib_skillList[59] = 'A04H'
    set ib_skillName[59] = "水遁.水分身之术"
    set ib_skillCustom[59] = 1
    set ib_skillList[60] = 'A04L'
    set ib_skillName[60] = "影分身之术"
    set ib_skillCustom[60] = 1
    set ib_skillList[61] = 'A04R'
    set ib_skillName[61] = "全+40"
    set ib_skillCustom[61] = 1
    set ib_skillList[62] = 'A04S'
    set ib_skillName[62] = "敏+20"
    set ib_skillCustom[62] = 1
    set ib_skillList[63] = 'A04T'
    set ib_skillName[63] = "幻术.解"
    set ib_skillCustom[63] = 1
    set ib_skillList[64] = 'A04V'
    set ib_skillName[64] = "椿之舞"
    set ib_skillCustom[64] = 1
    set ib_skillList[65] = 'A04Y'
    set ib_skillName[65] = "水遁秘术.千杀水翔"
    set ib_skillCustom[65] = 1
    set ib_skillList[66] = 'A052'
    set ib_skillName[66] = "螺旋丸"
    set ib_skillCustom[66] = 1
    set ib_skillList[67] = 'A057'
    set ib_skillName[67] = "水遁秘术.灭杀水翔"
    set ib_skillCustom[67] = 1
    set ib_skillList[68] = 'A05E'
    set ib_skillName[68] = "仙法.散激术"
    set ib_skillCustom[68] = 1
    set ib_skillList[69] = 'A05F'
    set ib_skillName[69] = "1-圣灵-玄武"
    set ib_skillCustom[69] = 1
    set ib_skillList[70] = 'A05G'
    set ib_skillName[70] = "1-圣灵-白虎"
    set ib_skillCustom[70] = 1
    set ib_skillList[71] = 'A05I'
    set ib_skillName[71] = "1-圣灵-青龙"
    set ib_skillCustom[71] = 1
    set ib_skillList[72] = 'A05N'
    set ib_skillName[72] = "表莲华"
    set ib_skillCustom[72] = 1
    set ib_skillList[73] = 'A05O'
    set ib_skillName[73] = "里莲华"
    set ib_skillCustom[73] = 1
    set ib_skillList[74] = 'A05Z'
    set ib_skillName[74] = "力量+300 200 200"
    set ib_skillCustom[74] = 1
    set ib_skillList[75] = 'A060'
    set ib_skillName[75] = "敏捷+200 300 200"
    set ib_skillCustom[75] = 1
    set ib_skillList[76] = 'A061'
    set ib_skillName[76] = "智力+200 200 300"
    set ib_skillCustom[76] = 1
    set ib_skillList[77] = 'A062'
    set ib_skillName[77] = "全属性+280"
    set ib_skillCustom[77] = 1
    set ib_skillList[78] = 'A065'
    set ib_skillName[78] = "言灵封印"
    set ib_skillCustom[78] = 1
    set ib_skillList[79] = 'A06D'
    set ib_skillName[79] = "时空黑洞"
    set ib_skillCustom[79] = 1
endfunction
function IB_SkillFill1 takes nothing returns nothing
    set ib_skillList[80] = 'A06E'
    set ib_skillName[80] = "礼包"
    set ib_skillCustom[80] = 1
    set ib_skillList[81] = 'A06H'
    set ib_skillName[81] = "砂瀑送葬"
    set ib_skillCustom[81] = 1
    set ib_skillList[82] = 'A06I'
    set ib_skillName[82] = "绝对防御"
    set ib_skillCustom[82] = 1
    set ib_skillList[83] = 'A06L'
    set ib_skillName[83] = "水遁.水阵壁"
    set ib_skillCustom[83] = 1
    set ib_skillList[84] = 'A06M'
    set ib_skillName[84] = "水遁.水冲波"
    set ib_skillCustom[84] = 1
    set ib_skillList[85] = 'A06N'
    set ib_skillName[85] = "水遁.硬涡水刃"
    set ib_skillCustom[85] = 1
    set ib_skillList[86] = 'A06O'
    set ib_skillName[86] = "黑暗行技能"
    set ib_skillCustom[86] = 1
    set ib_skillList[87] = 'A06T'
    set ib_skillName[87] = "砂缚牢"
    set ib_skillCustom[87] = 1
    set ib_skillList[88] = 'A06U'
    set ib_skillName[88] = "水遁.无限鲛"
    set ib_skillCustom[88] = 1
    set ib_skillList[89] = 'A06V'
    set ib_skillName[89] = "水遁.水之柱"
    set ib_skillCustom[89] = 1
    set ib_skillList[90] = 'A06W'
    set ib_skillName[90] = "水遁.水鲛霰弹术"
    set ib_skillCustom[90] = 1
    set ib_skillList[91] = 'A073'
    set ib_skillName[91] = "木遁秘术.树界降诞"
    set ib_skillCustom[91] = 1
    set ib_skillList[92] = 'A075'
    set ib_skillName[92] = "水遁.水分身之术"
    set ib_skillCustom[92] = 1
    set ib_skillList[93] = 'A076'
    set ib_skillName[93] = "水遁.水波动"
    set ib_skillCustom[93] = 1
    set ib_skillList[94] = 'A079'
    set ib_skillName[94] = "轮回眼"
    set ib_skillCustom[94] = 1
    set ib_skillList[95] = 'A07A'
    set ib_skillName[95] = "雨虎自在术"
    set ib_skillCustom[95] = 1
    set ib_skillList[96] = 'A07G'
    set ib_skillName[96] = "万花眼附加技能2"
    set ib_skillCustom[96] = 1
    set ib_skillList[97] = 'A07J'
    set ib_skillName[97] = "水箭2"
    set ib_skillCustom[97] = 1
    set ib_skillList[98] = 'A07K'
    set ib_skillName[98] = "水遁.水翔羽"
    set ib_skillCustom[98] = 1
    set ib_skillList[99] = 'A07L'
    set ib_skillName[99] = "水遁.水牢鲛舞"
    set ib_skillCustom[99] = 1
    set ib_skillList[100] = 'A07N'
    set ib_skillName[100] = "沙暴大葬"
    set ib_skillCustom[100] = 1
    set ib_skillList[101] = 'A07O'
    set ib_skillName[101] = "专属力量+500"
    set ib_skillCustom[101] = 1
    set ib_skillList[102] = 'A07P'
    set ib_skillName[102] = "专属敏捷+500"
    set ib_skillCustom[102] = 1
    set ib_skillList[103] = 'A07Q'
    set ib_skillName[103] = "pohuai  _mao"
    set ib_skillCustom[103] = 1
    set ib_skillList[104] = 'A07R'
    set ib_skillName[104] = "多重影分身之术"
    set ib_skillCustom[104] = 1
    set ib_skillList[105] = 'A07S'
    set ib_skillName[105] = "全属性+900"
    set ib_skillCustom[105] = 1
    set ib_skillList[106] = 'A07T'
    set ib_skillName[106] = "木遁.森罗万象"
    set ib_skillCustom[106] = 1
    set ib_skillList[107] = 'A07U'
    set ib_skillName[107] = "-须作附加技能"
    set ib_skillCustom[107] = 1
    set ib_skillList[108] = 'A07W'
    set ib_skillName[108] = "音速斩"
    set ib_skillCustom[108] = 1
    set ib_skillList[109] = 'A07Y'
    set ib_skillName[109] = "专属智力+500"
    set ib_skillCustom[109] = 1
    set ib_skillList[110] = 'A082'
    set ib_skillName[110] = "-天神道-佩恩"
    set ib_skillCustom[110] = 1
    set ib_skillList[111] = 'A083'
    set ib_skillName[111] = "忍法.手里剑影分身之术"
    set ib_skillCustom[111] = 1
    set ib_skillList[112] = 'A084'
    set ib_skillName[112] = "土遁.土流璧"
    set ib_skillCustom[112] = 1
    set ib_skillList[113] = 'A087'
    set ib_skillName[113] = "柔拳法.八卦三十二掌"
    set ib_skillCustom[113] = 1
    set ib_skillList[114] = 'A089'
    set ib_skillName[114] = "镰鼬术技能"
    set ib_skillCustom[114] = 1
    set ib_skillList[115] = 'A08A'
    set ib_skillName[115] = "关闭白眼"
    set ib_skillCustom[115] = 1
    set ib_skillList[116] = 'A08C'
    set ib_skillName[116] = "火遁·火龙弹"
    set ib_skillCustom[116] = 1
    set ib_skillList[117] = 'A08D'
    set ib_skillName[117] = "封印术.尸鬼封禁"
    set ib_skillCustom[117] = 1
    set ib_skillList[118] = 'A08F'
    set ib_skillName[118] = "体术奥义.柔步双狮拳"
    set ib_skillCustom[118] = 1
    set ib_skillList[119] = 'A08H'
    set ib_skillName[119] = "-人间道-佩恩"
    set ib_skillCustom[119] = 1
    set ib_skillList[120] = 'A08I'
    set ib_skillName[120] = "-畜生道-佩恩"
    set ib_skillCustom[120] = 1
    set ib_skillList[121] = 'A08J'
    set ib_skillName[121] = "--------------重生"
    set ib_skillCustom[121] = 1
    set ib_skillList[122] = 'A08P'
    set ib_skillName[122] = "-恶鬼道-佩恩"
    set ib_skillCustom[122] = 1
    set ib_skillList[123] = 'A08Q'
    set ib_skillName[123] = "-地狱道-佩恩"
    set ib_skillCustom[123] = 1
    set ib_skillList[124] = 'A08R'
    set ib_skillName[124] = "-修罗道-佩恩"
    set ib_skillCustom[124] = 1
    set ib_skillList[125] = 'A08W'
    set ib_skillName[125] = "-啊飞-佩恩"
    set ib_skillCustom[125] = 1
    set ib_skillList[126] = 'A08X'
    set ib_skillName[126] = "封印术.尸鬼封禁"
    set ib_skillCustom[126] = 1
    set ib_skillList[127] = 'A08Y'
    set ib_skillName[127] = "柔拳法.百烈掌"
    set ib_skillCustom[127] = 1
    set ib_skillList[128] = 'A08Z'
    set ib_skillName[128] = "白眼"
    set ib_skillCustom[128] = 1
    set ib_skillList[129] = 'A091'
    set ib_skillName[129] = "八门遁甲"
    set ib_skillCustom[129] = 1
    set ib_skillList[130] = 'A094'
    set ib_skillName[130] = "超.神罗天征"
    set ib_skillCustom[130] = 1
    set ib_skillList[131] = 'A095'
    set ib_skillName[131] = "1-圣灵-朱雀"
    set ib_skillCustom[131] = 1
    set ib_skillList[132] = 'A096'
    set ib_skillName[132] = "破甲 1"
    set ib_skillCustom[132] = 1
    set ib_skillList[133] = 'A097'
    set ib_skillName[133] = "破甲 2"
    set ib_skillCustom[133] = 1
    set ib_skillList[134] = 'A098'
    set ib_skillName[134] = "破甲 3"
    set ib_skillCustom[134] = 1
    set ib_skillList[135] = 'A099'
    set ib_skillName[135] = "破甲 4"
    set ib_skillCustom[135] = 1
    set ib_skillList[136] = 'A09B'
    set ib_skillName[136] = "水遁.水巨人"
    set ib_skillCustom[136] = 1
    set ib_skillList[137] = 'A09C'
    set ib_skillName[137] = "雷遁.雷切 双雷震"
    set ib_skillCustom[137] = 1
    set ib_skillList[138] = 'A09D'
    set ib_skillName[138] = "--------------重生2"
    set ib_skillCustom[138] = 1
    set ib_skillList[139] = 'A09E'
    set ib_skillName[139] = "勋章智力+300"
    set ib_skillCustom[139] = 1
    set ib_skillList[140] = 'A09F'
    set ib_skillName[140] = "勋章敏捷+300"
    set ib_skillCustom[140] = 1
    set ib_skillList[141] = 'A09G'
    set ib_skillName[141] = "勋章力量+300"
    set ib_skillCustom[141] = 1
    set ib_skillList[142] = 'A09K'
    set ib_skillName[142] = "崩拳"
    set ib_skillCustom[142] = 1
    set ib_skillList[143] = 'A09L'
    set ib_skillName[143] = "掌仙术"
    set ib_skillCustom[143] = 1
    set ib_skillList[144] = 'A09M'
    set ib_skillName[144] = "里.小樱"
    set ib_skillCustom[144] = 1
    set ib_skillList[145] = 'A09O'
    set ib_skillName[145] = "怪力100%"
    set ib_skillCustom[145] = 1
    set ib_skillList[146] = 'A09P'
    set ib_skillName[146] = "樱花吹雪之术"
    set ib_skillCustom[146] = 1
    set ib_skillList[147] = 'A09Q'
    set ib_skillName[147] = "樱花吹雪之术"
    set ib_skillCustom[147] = 1
    set ib_skillList[148] = 'A09R'
    set ib_skillName[148] = "操具死球击"
    set ib_skillCustom[148] = 1
    set ib_skillList[149] = 'A09T'
    set ib_skillName[149] = "暗器术.风魔手里剑"
    set ib_skillCustom[149] = 1
    set ib_skillList[150] = 'A09V'
    set ib_skillName[150] = "暗器术.升龙"
    set ib_skillCustom[150] = 1
    set ib_skillList[151] = 'A09X'
    set ib_skillName[151] = "操具死球击"
    set ib_skillCustom[151] = 1
    set ib_skillList[152] = 'A09Z'
    set ib_skillName[152] = "王者属性+888"
    set ib_skillCustom[152] = 1
    set ib_skillList[153] = 'A0A0'
    set ib_skillName[153] = "超兽伪画.狮子"
    set ib_skillCustom[153] = 1
    set ib_skillList[154] = 'A0A7'
    set ib_skillName[154] = "超兽伪画-墨流"
    set ib_skillCustom[154] = 1
    set ib_skillList[155] = 'A0A8'
    set ib_skillName[155] = "九尾觉醒"
    set ib_skillCustom[155] = 1
    set ib_skillList[156] = 'A0A9'
    set ib_skillName[156] = "风遁.飓风阵"
    set ib_skillCustom[156] = 1
    set ib_skillList[157] = 'A0AA'
    set ib_skillName[157] = "通灵之术.犬"
    set ib_skillCustom[157] = 1
    set ib_skillList[158] = 'A0AB'
    set ib_skillName[158] = "通灵之术.猿魔"
    set ib_skillCustom[158] = 1
    set ib_skillList[159] = 'A0AE'
    set ib_skillName[159] = "土遁.引爆黏土 - 蜘蛛"
    set ib_skillCustom[159] = 1
endfunction
function IB_SkillFill2 takes nothing returns nothing
    set ib_skillList[160] = 'A0AF'
    set ib_skillName[160] = "土遁.引爆黏土 - 飞鸟"
    set ib_skillCustom[160] = 1
    set ib_skillList[161] = 'A0AH'
    set ib_skillName[161] = "土遁.引爆黏土 - c4 迦楼罗"
    set ib_skillCustom[161] = 1
    set ib_skillList[162] = 'A0AI'
    set ib_skillName[162] = "土遁.引爆黏土 - c2 龙"
    set ib_skillCustom[162] = 1
    set ib_skillList[163] = 'A0AK'
    set ib_skillName[163] = "co.自爆"
    set ib_skillCustom[163] = 1
    set ib_skillList[164] = 'A0AM'
    set ib_skillName[164] = "超倍化肉弹战车"
    set ib_skillCustom[164] = 1
    set ib_skillList[165] = 'A0AO'
    set ib_skillName[165] = "粉碎攻击"
    set ib_skillCustom[165] = 1
    set ib_skillList[166] = 'A0AP'
    set ib_skillName[166] = "蝶弹爆击"
    set ib_skillCustom[166] = 1
    set ib_skillList[167] = 'A0AU'
    set ib_skillName[167] = "晶遁.御神渡之术"
    set ib_skillCustom[167] = 1
    set ib_skillList[168] = 'A0AW'
    set ib_skillName[168] = "晶遁.破晶降龙之术"
    set ib_skillCustom[168] = 1
    set ib_skillList[169] = 'A0AZ'
    set ib_skillName[169] = "晶遁.翠晶迷宫之术"
    set ib_skillCustom[169] = 1
    set ib_skillList[170] = 'A0B1'
    set ib_skillName[170] = "砂石雨"
    set ib_skillCustom[170] = 1
    set ib_skillList[171] = 'A0B7'
    set ib_skillName[171] = "速度+50"
    set ib_skillCustom[171] = 1
    set ib_skillList[172] = 'A0B8'
    set ib_skillName[172] = "速度+10"
    set ib_skillCustom[172] = 1
    set ib_skillList[173] = 'A0B9'
    set ib_skillName[173] = "速度+40"
    set ib_skillCustom[173] = 1
    set ib_skillList[174] = 'A0BA'
    set ib_skillName[174] = "速度+30"
    set ib_skillCustom[174] = 1
    set ib_skillList[175] = 'A0BB'
    set ib_skillName[175] = "速度+20"
    set ib_skillCustom[175] = 1
    set ib_skillList[176] = 'A0BC'
    set ib_skillName[176] = "速度+60"
    set ib_skillCustom[176] = 1
    set ib_skillList[177] = 'A0BD'
    set ib_skillName[177] = "攻速+15%"
    set ib_skillCustom[177] = 1
    set ib_skillList[178] = 'A0BE'
    set ib_skillName[178] = "攻速+10%"
    set ib_skillCustom[178] = 1
    set ib_skillList[179] = 'A0BF'
    set ib_skillName[179] = "攻速+25%"
    set ib_skillCustom[179] = 1
    set ib_skillList[180] = 'A0BG'
    set ib_skillName[180] = "攻速+5%"
    set ib_skillCustom[180] = 1
    set ib_skillList[181] = 'A0BH'
    set ib_skillName[181] = "攻速+20%"
    set ib_skillCustom[181] = 1
    set ib_skillList[182] = 'A0BI'
    set ib_skillName[182] = "攻速+30%"
    set ib_skillCustom[182] = 1
    set ib_skillList[183] = 'A0BJ'
    set ib_skillName[183] = "敏捷+30 60 30"
    set ib_skillCustom[183] = 1
    set ib_skillList[184] = 'A0BK'
    set ib_skillName[184] = "敏捷+50 80 50"
    set ib_skillCustom[184] = 1
    set ib_skillList[185] = 'A0BL'
    set ib_skillName[185] = "力量+80 50 50"
    set ib_skillCustom[185] = 1
    set ib_skillList[186] = 'A0BM'
    set ib_skillName[186] = "智力+50 50 80"
    set ib_skillCustom[186] = 1
    set ib_skillList[187] = 'A0BR'
    set ib_skillName[187] = "波涛狂怒"
    set ib_skillCustom[187] = 1
    set ib_skillList[188] = 'A0BU'
    set ib_skillName[188] = "破甲 5"
    set ib_skillCustom[188] = 1
    set ib_skillList[189] = 'A0BZ'
    set ib_skillName[189] = "宝宝进化"
    set ib_skillCustom[189] = 1
    set ib_skillList[190] = 'A0C0'
    set ib_skillName[190] = "回血+2"
    set ib_skillCustom[190] = 1
    set ib_skillList[191] = 'A0C1'
    set ib_skillName[191] = "回血+20"
    set ib_skillCustom[191] = 1
    set ib_skillList[192] = 'A0C2'
    set ib_skillName[192] = "回血+4"
    set ib_skillCustom[192] = 1
    set ib_skillList[193] = 'A0C3'
    set ib_skillName[193] = "回血+6"
    set ib_skillCustom[193] = 1
    set ib_skillList[194] = 'A0C4'
    set ib_skillName[194] = "回血+40"
    set ib_skillCustom[194] = 1
    set ib_skillList[195] = 'A0C6'
    set ib_skillName[195] = "2-圣灵-朱雀"
    set ib_skillCustom[195] = 1
    set ib_skillList[196] = 'A0C7'
    set ib_skillName[196] = "2-圣灵-白虎"
    set ib_skillCustom[196] = 1
    set ib_skillList[197] = 'A0C8'
    set ib_skillName[197] = "2-圣灵-青龙"
    set ib_skillCustom[197] = 1
    set ib_skillList[198] = 'A0CH'
    set ib_skillName[198] = "全属性+100"
    set ib_skillCustom[198] = 1
    set ib_skillList[199] = 'A0CK'
    set ib_skillName[199] = "-须作附加技能"
    set ib_skillCustom[199] = 1
    set ib_skillList[200] = 'A0CL'
    set ib_skillName[200] = "-须佐技能"
    set ib_skillCustom[200] = 1
    set ib_skillList[201] = 'A0CN'
    set ib_skillName[201] = "雷遁术.八刀流"
    set ib_skillCustom[201] = 1
    set ib_skillList[202] = 'A0CO'
    set ib_skillName[202] = "八尾查克拉"
    set ib_skillCustom[202] = 1
    set ib_skillList[203] = 'A0CP'
    set ib_skillName[203] = "雷犁热刀"
    set ib_skillCustom[203] = 1
    set ib_skillList[204] = 'A0CQ'
    set ib_skillName[204] = "查克拉流动"
    set ib_skillCustom[204] = 1
    set ib_skillList[205] = 'A0CT'
    set ib_skillName[205] = "-奇拉比技能"
    set ib_skillCustom[205] = 1
    set ib_skillList[206] = 'A0CU'
    set ib_skillName[206] = "八尾.x牛炮"
    set ib_skillCustom[206] = 1
    set ib_skillList[207] = 'A0CW'
    set ib_skillName[207] = "写轮眼and轮回眼"
    set ib_skillCustom[207] = 1
    set ib_skillList[208] = 'A0CX'
    set ib_skillName[208] = "纸手里剑"
    set ib_skillCustom[208] = 1
    set ib_skillList[209] = 'A0CY'
    set ib_skillName[209] = "纸之瞬身"
    set ib_skillCustom[209] = 1
    set ib_skillList[210] = 'A0CZ'
    set ib_skillName[210] = "纸牢之术"
    set ib_skillCustom[210] = 1
    set ib_skillList[211] = 'A0D0'
    set ib_skillName[211] = "式纸之舞"
    set ib_skillCustom[211] = 1
    set ib_skillList[212] = 'A0D1'
    set ib_skillName[212] = "神之纸者之术"
    set ib_skillCustom[212] = 1
    set ib_skillList[213] = 'A0D3'
    set ib_skillName[213] = "天纸"
    set ib_skillCustom[213] = 1
    set ib_skillList[214] = 'A0D8'
    set ib_skillName[214] = "风遁.真空波"
    set ib_skillCustom[214] = 1
    set ib_skillList[215] = 'A0D9'
    set ib_skillName[215] = "风遁.手里剑"
    set ib_skillCustom[215] = 1
    set ib_skillList[216] = 'A0DD'
    set ib_skillName[216] = "写轮眼奥义.伊邪那岐"
    set ib_skillCustom[216] = 1
    set ib_skillList[217] = 'A0DE'
    set ib_skillName[217] = "写轮眼奥义.伊邪那岐"
    set ib_skillCustom[217] = 1
    set ib_skillList[218] = 'A0DH'
    set ib_skillName[218] = "攻速+60%"
    set ib_skillCustom[218] = 1
    set ib_skillList[219] = 'A0DK'
    set ib_skillName[219] = "椿之舞"
    set ib_skillCustom[219] = 1
    set ib_skillList[220] = 'A0DP'
    set ib_skillName[220] = "君"
    set ib_skillCustom[220] = 1
    set ib_skillList[221] = 'A0DS'
    set ib_skillName[221] = "-太极丸子"
    set ib_skillCustom[221] = 1
    set ib_skillList[222] = 'A0DW'
    set ib_skillName[222] = "时空结界"
    set ib_skillCustom[222] = 1
    set ib_skillList[223] = 'A0DX'
    set ib_skillName[223] = "-4d丸子"
    set ib_skillCustom[223] = 1
    set ib_skillList[224] = 'A0DZ'
    set ib_skillName[224] = "四代物理"
    set ib_skillCustom[224] = 1
    set ib_skillList[225] = 'A0E2'
    set ib_skillName[225] = "水遁.千食鲛"
    set ib_skillCustom[225] = 1
    set ib_skillList[226] = 'A0E6'
    set ib_skillName[226] = "跳跃"
    set ib_skillCustom[226] = 1
    set ib_skillList[227] = 'A0E8'
    set ib_skillName[227] = "查克拉回复"
    set ib_skillCustom[227] = 1
    set ib_skillList[228] = 'A0E9'
    set ib_skillName[228] = "查克拉回复"
    set ib_skillCustom[228] = 1
    set ib_skillList[229] = 'A0EA'
    set ib_skillName[229] = "查克拉回复"
    set ib_skillCustom[229] = 1
    set ib_skillList[230] = 'A0ER'
    set ib_skillName[230] = "1-圣灵-九幽"
    set ib_skillCustom[230] = 1
    set ib_skillList[231] = 'A0ET'
    set ib_skillName[231] = "1-圣灵-炽焰"
    set ib_skillCustom[231] = 1
    set ib_skillList[232] = 'A0EV'
    set ib_skillName[232] = "1-圣灵-镇海"
    set ib_skillCustom[232] = 1
    set ib_skillList[233] = 'A0EW'
    set ib_skillName[233] = "查克拉回复"
    set ib_skillCustom[233] = 1
    set ib_skillList[234] = 'A0EY'
    set ib_skillName[234] = "1-圣灵-幻雷"
    set ib_skillCustom[234] = 1
    set ib_skillList[235] = 'A0FF'
    set ib_skillName[235] = "魔镜冰晶"
    set ib_skillCustom[235] = 1
    set ib_skillList[236] = 'A0FL'
    set ib_skillName[236] = "00冰之血继限界技能"
    set ib_skillCustom[236] = 1
    set ib_skillList[237] = 'A0FV'
    set ib_skillName[237] = "冰之护甲"
    set ib_skillCustom[237] = 1
    set ib_skillList[238] = 'A0FY'
    set ib_skillName[238] = "全属性+500"
    set ib_skillCustom[238] = 1
    set ib_skillList[239] = 'A0FZ'
    set ib_skillName[239] = "跟随"
    set ib_skillCustom[239] = 1
endfunction
function IB_SkillFill3 takes nothing returns nothing
    set ib_skillList[240] = 'A0G0'
    set ib_skillName[240] = "佩恩六道"
    set ib_skillCustom[240] = 1
    set ib_skillList[241] = 'A0G1'
    set ib_skillName[241] = "吸收"
    set ib_skillCustom[241] = 1
    set ib_skillList[242] = 'A0G4'
    set ib_skillName[242] = "绝对吸收"
    set ib_skillCustom[242] = 1
    set ib_skillList[243] = 'A0G6'
    set ib_skillName[243] = "发射导弹"
    set ib_skillCustom[243] = 1
    set ib_skillList[244] = 'A0G7'
    set ib_skillName[244] = "怪腕火箭"
    set ib_skillCustom[244] = 1
    set ib_skillList[245] = 'A0G8'
    set ib_skillName[245] = "通灵之术.犬"
    set ib_skillCustom[245] = 1
    set ib_skillList[246] = 'A0G9'
    set ib_skillName[246] = "通灵之术"
    set ib_skillCustom[246] = 1
    set ib_skillList[247] = 'A0GA'
    set ib_skillName[247] = "通灵之术.巨犀"
    set ib_skillCustom[247] = 1
    set ib_skillList[248] = 'A0GC'
    set ib_skillName[248] = "修复术"
    set ib_skillCustom[248] = 1
    set ib_skillList[249] = 'A0GD'
    set ib_skillName[249] = "复活术"
    set ib_skillCustom[249] = 1
    set ib_skillList[250] = 'A0GE'
    set ib_skillName[250] = "轮回眼"
    set ib_skillCustom[250] = 1
    set ib_skillList[251] = 'A0GK'
    set ib_skillName[251] = "肉弹战车"
    set ib_skillCustom[251] = 1
    set ib_skillList[252] = 'A0GO'
    set ib_skillName[252] = "时空瞬杀"
    set ib_skillCustom[252] = 1
    set ib_skillList[253] = 'A0GP'
    set ib_skillName[253] = "虚化"
    set ib_skillCustom[253] = 1
    set ib_skillList[254] = 'A0GS'
    set ib_skillName[254] = "神威"
    set ib_skillCustom[254] = 1
    set ib_skillList[255] = 'A0GU'
    set ib_skillName[255] = "地爆天星"
    set ib_skillCustom[255] = 1
    set ib_skillList[256] = 'A0GY'
    set ib_skillName[256] = "流砂暴流"
    set ib_skillCustom[256] = 1
    set ib_skillList[257] = 'A0H0'
    set ib_skillName[257] = "木遁多重木分身"
    set ib_skillCustom[257] = 1
    set ib_skillList[258] = 'A0H1'
    set ib_skillName[258] = "永恒万花筒写轮眼and轮回眼"
    set ib_skillCustom[258] = 1
    set ib_skillList[259] = 'A0H3'
    set ib_skillName[259] = "火遁.豪火灭却"
    set ib_skillCustom[259] = 1
    set ib_skillList[260] = 'A0H6'
    set ib_skillName[260] = "须佐能乎"
    set ib_skillCustom[260] = 1
    set ib_skillList[261] = 'A0H7'
    set ib_skillName[261] = "幻术.解"
    set ib_skillCustom[261] = 1
    set ib_skillList[262] = 'A0H8'
    set ib_skillName[262] = "晶遁·翠晶迷宫之术"
    set ib_skillCustom[262] = 1
    set ib_skillList[263] = 'A0HB'
    set ib_skillName[263] = "1幻术.泡沫"
    set ib_skillCustom[263] = 1
    set ib_skillList[264] = 'A0HG'
    set ib_skillName[264] = "木之叶烈风"
    set ib_skillCustom[264] = 1
    set ib_skillList[265] = 'A0HH'
    set ib_skillName[265] = "八门遁甲奥义.朝孔雀"
    set ib_skillCustom[265] = 1
    set ib_skillList[266] = 'A0HI'
    set ib_skillName[266] = "禁术.八门遁甲"
    set ib_skillCustom[266] = 1
    set ib_skillList[267] = 'A0HK'
    set ib_skillName[267] = "附加点"
    set ib_skillCustom[267] = 1
    set ib_skillList[268] = 'A0HL'
    set ib_skillName[268] = "附加点"
    set ib_skillCustom[268] = 1
    set ib_skillList[269] = 'A0HQ'
    set ib_skillName[269] = "1-圣灵-盘古开天"
    set ib_skillCustom[269] = 1
    set ib_skillList[270] = 'A0HT'
    set ib_skillName[270] = "力量+2000"
    set ib_skillCustom[270] = 1
    set ib_skillList[271] = 'A0HW'
    set ib_skillName[271] = "敏+2500"
    set ib_skillCustom[271] = 1
    set ib_skillList[272] = 'A0HX'
    set ib_skillName[272] = "1-圣灵-炎帝青龙"
    set ib_skillCustom[272] = 1
    set ib_skillList[273] = 'A0I1'
    set ib_skillName[273] = "智力+2500"
    set ib_skillCustom[273] = 1
    set ib_skillList[274] = 'A0I2'
    set ib_skillName[274] = "1-圣灵-伏羲朱雀"
    set ib_skillCustom[274] = 1
    set ib_skillList[275] = 'A0I3'
    set ib_skillName[275] = "言灵诅咒"
    set ib_skillCustom[275] = 1
    set ib_skillList[276] = 'A0I6'
    set ib_skillName[276] = "1-圣灵-轩辕玄武"
    set ib_skillCustom[276] = 1
    set ib_skillList[277] = 'A0I8'
    set ib_skillName[277] = "全属性+1200"
    set ib_skillCustom[277] = 1
    set ib_skillList[278] = 'A0ID'
    set ib_skillName[278] = "上古全属性+1000"
    set ib_skillCustom[278] = 1
    set ib_skillList[279] = 'A0IG'
    set ib_skillName[279] = "天雷落"
    set ib_skillCustom[279] = 1
    set ib_skillList[280] = 'A0IH'
    set ib_skillName[280] = "治活再生"
    set ib_skillCustom[280] = 1
    set ib_skillList[281] = 'A0IJ'
    set ib_skillName[281] = "暴力！！"
    set ib_skillCustom[281] = 1
    set ib_skillList[282] = 'A0IO'
    set ib_skillName[282] = "工程升级"
    set ib_skillCustom[282] = 1
    set ib_skillList[283] = 'A0IT'
    set ib_skillName[283] = "八卦空掌"
    set ib_skillCustom[283] = 1
    set ib_skillList[284] = 'A0IW'
    set ib_skillName[284] = "柔拳法.八卦六十四掌"
    set ib_skillCustom[284] = 1
    set ib_skillList[285] = 'A0IX'
    set ib_skillName[285] = "工程升级"
    set ib_skillCustom[285] = 1
    set ib_skillList[286] = 'A0J3'
    set ib_skillName[286] = "土遁.飞空之术"
    set ib_skillCustom[286] = 1
    set ib_skillList[287] = 'A0J4'
    set ib_skillName[287] = "土遁.轻重岩之术"
    set ib_skillCustom[287] = 1
    set ib_skillList[288] = 'A0J6'
    set ib_skillName[288] = "三代土影"
    set ib_skillCustom[288] = 1
    set ib_skillList[289] = 'A0JF'
    set ib_skillName[289] = "雷遁.雷传"
    set ib_skillCustom[289] = 1
    set ib_skillList[290] = 'A0JG'
    set ib_skillName[290] = "神威"
    set ib_skillCustom[290] = 1
    set ib_skillList[291] = 'A0JI'
    set ib_skillName[291] = "万花筒写轮眼"
    set ib_skillCustom[291] = 1
    set ib_skillList[292] = 'A0JL'
    set ib_skillName[292] = "九尾查克拉"
    set ib_skillCustom[292] = 1
    set ib_skillList[293] = 'A0JM'
    set ib_skillName[293] = "幻术.解"
    set ib_skillCustom[293] = 1
    set ib_skillList[294] = 'A0JN'
    set ib_skillName[294] = "通灵之术.外道魔像"
    set ib_skillCustom[294] = 1
    set ib_skillList[295] = 'A0K1'
    set ib_skillName[295] = "土遁.引爆黏土 - c2 龙"
    set ib_skillCustom[295] = 1
    set ib_skillList[296] = 'A0K2'
    set ib_skillName[296] = "土遁.引爆黏土 - 飞鸟"
    set ib_skillCustom[296] = 1
    set ib_skillList[297] = 'A0K3'
    set ib_skillName[297] = "土遁.引爆黏土 - 蜘蛛"
    set ib_skillCustom[297] = 1
    set ib_skillList[298] = 'A0K4'
    set ib_skillName[298] = "工程升级"
    set ib_skillCustom[298] = 1
    set ib_skillList[299] = 'A0K5'
    set ib_skillName[299] = "树缚永葬(f)"
    set ib_skillCustom[299] = 1
    set ib_skillList[300] = 'A0K7'
    set ib_skillName[300] = "凤凰丝带"
    set ib_skillCustom[300] = 1
    set ib_skillList[301] = 'A0K8'
    set ib_skillName[301] = "火遁.炎弹"
    set ib_skillCustom[301] = 1
    set ib_skillList[302] = 'A0K9'
    set ib_skillName[302] = "火遁.豪炎螺旋丸"
    set ib_skillCustom[302] = 1
    set ib_skillList[303] = 'A0KA'
    set ib_skillName[303] = "忍法·蛙变之术"
    set ib_skillCustom[303] = 1
    set ib_skillList[304] = 'A0KB'
    set ib_skillName[304] = "通灵术·压垮摊贩术"
    set ib_skillCustom[304] = 1
    set ib_skillList[305] = 'A0KC'
    set ib_skillName[305] = "火遁.蛤蟆油炎弹"
    set ib_skillCustom[305] = 1
    set ib_skillList[306] = 'A0KD'
    set ib_skillName[306] = "仙人模式"
    set ib_skillCustom[306] = 1
    set ib_skillList[307] = 'A0KE'
    set ib_skillName[307] = "全属性+150"
    set ib_skillCustom[307] = 1
    set ib_skillList[308] = 'A0KF'
    set ib_skillName[308] = "仙法.超大玉螺旋丸"
    set ib_skillCustom[308] = 1
    set ib_skillList[309] = 'A0KG'
    set ib_skillName[309] = "仙法·蛤蟆吟唱"
    set ib_skillCustom[309] = 1
    set ib_skillList[310] = 'A0KH'
    set ib_skillName[310] = "仙法·蛤蟆吟唱"
    set ib_skillCustom[310] = 1
    set ib_skillList[311] = 'A0KI'
    set ib_skillName[311] = "忍法·蛙变之术"
    set ib_skillCustom[311] = 1
    set ib_skillList[312] = 'A0KJ'
    set ib_skillName[312] = "减速光环 (龙卷风)"
    set ib_skillCustom[312] = 1
    set ib_skillList[313] = 'A0KL'
    set ib_skillName[313] = "大鱼我来啦！"
    set ib_skillCustom[313] = 1
    set ib_skillList[314] = 'A0KM'
    set ib_skillName[314] = "！恢复3000血"
    set ib_skillCustom[314] = 1
    set ib_skillList[315] = 'A0KN'
    set ib_skillName[315] = "！恢复6000血"
    set ib_skillCustom[315] = 1
    set ib_skillList[316] = 'A0KO'
    set ib_skillName[316] = "！恢复10000血"
    set ib_skillCustom[316] = 1
    set ib_skillList[317] = 'A0KP'
    set ib_skillName[317] = "！恢复40000血"
    set ib_skillCustom[317] = 1
    set ib_skillList[318] = 'A0KQ'
    set ib_skillName[318] = "！破箱子"
    set ib_skillCustom[318] = 1
    set ib_skillList[319] = 'A0KR'
    set ib_skillName[319] = "逆天鱼 全属性+1000"
    set ib_skillCustom[319] = 1
endfunction
function IB_SkillFill4 takes nothing returns nothing
    set ib_skillList[320] = 'A0KS'
    set ib_skillName[320] = "！藏宝图"
    set ib_skillCustom[320] = 1
    set ib_skillList[321] = 'A0KT'
    set ib_skillName[321] = "！全属性+1000"
    set ib_skillCustom[321] = 1
    set ib_skillList[322] = 'A0KV'
    set ib_skillName[322] = "！随即属性+50"
    set ib_skillCustom[322] = 1
    set ib_skillList[323] = 'A0KW'
    set ib_skillName[323] = "boss抗性皮肤"
    set ib_skillCustom[323] = 1
    set ib_skillList[324] = 'A0KZ'
    set ib_skillName[324] = "幻术.月读"
    set ib_skillCustom[324] = 1
    set ib_skillList[325] = 'A0L7'
    set ib_skillName[325] = "木遁.多重木分身"
    set ib_skillCustom[325] = 1
    set ib_skillList[326] = 'A0LA'
    set ib_skillName[326] = "1十尾恢复光环"
    set ib_skillCustom[326] = 1
    set ib_skillList[327] = 'A0LD'
    set ib_skillName[327] = "雷遁.雷虐水平"
    set ib_skillCustom[327] = 1
    set ib_skillList[328] = 'A0LE'
    set ib_skillName[328] = "雷遁.雷我爆弹"
    set ib_skillCustom[328] = 1
    set ib_skillList[329] = 'A0LF'
    set ib_skillName[329] = "雷遁.雷虐水平千代舞"
    set ib_skillCustom[329] = 1
    set ib_skillList[330] = 'A0LH'
    set ib_skillName[330] = "雷遁.义雷沉怒雷斧"
    set ib_skillCustom[330] = 1
    set ib_skillList[331] = 'A0LI'
    set ib_skillName[331] = "雷影闪电特效"
    set ib_skillCustom[331] = 1
    set ib_skillList[332] = 'A0LL'
    set ib_skillName[332] = "雷犁热刀"
    set ib_skillCustom[332] = 1
    set ib_skillList[333] = 'A0LP'
    set ib_skillName[333] = "魂"
    set ib_skillCustom[333] = 1
    set ib_skillList[334] = 'A0LT'
    set ib_skillName[334] = "超兽伪画.鹰"
    set ib_skillCustom[334] = 1
    set ib_skillList[335] = 'A0LU'
    set ib_skillName[335] = "“根”之人"
    set ib_skillCustom[335] = 1
    set ib_skillList[336] = 'A0LV'
    set ib_skillName[336] = "超兽伪画.狮子"
    set ib_skillCustom[336] = 1
    set ib_skillList[337] = 'A0LW'
    set ib_skillName[337] = "超兽伪画.狮子"
    set ib_skillCustom[337] = 1
    set ib_skillList[338] = 'A0LX'
    set ib_skillName[338] = "超兽伪画.狮子"
    set ib_skillCustom[338] = 1
    set ib_skillList[339] = 'A0LY'
    set ib_skillName[339] = "超兽伪画.狮子"
    set ib_skillCustom[339] = 1
    set ib_skillList[340] = 'A0LZ'
    set ib_skillName[340] = "超兽伪画.狮子"
    set ib_skillCustom[340] = 1
    set ib_skillList[341] = 'A0M0'
    set ib_skillName[341] = "超兽伪画.狮子"
    set ib_skillCustom[341] = 1
    set ib_skillList[342] = 'A0M1'
    set ib_skillName[342] = "超兽伪画.狮子"
    set ib_skillCustom[342] = 1
    set ib_skillList[343] = 'A0M2'
    set ib_skillName[343] = "超兽伪画.狮子"
    set ib_skillCustom[343] = 1
    set ib_skillList[344] = 'A0M3'
    set ib_skillName[344] = "超兽伪画.狮子"
    set ib_skillCustom[344] = 1
    set ib_skillList[345] = 'A0M4'
    set ib_skillName[345] = "超兽伪画.狮子"
    set ib_skillCustom[345] = 1
    set ib_skillList[346] = 'A0M8'
    set ib_skillName[346] = "2震慑"
    set ib_skillCustom[346] = 1
    set ib_skillList[347] = 'A0M9'
    set ib_skillName[347] = "艺术升华"
    set ib_skillCustom[347] = 1
    set ib_skillList[348] = 'A0MG'
    set ib_skillName[348] = "永恒万花筒写轮眼"
    set ib_skillCustom[348] = 1
    set ib_skillList[349] = 'A0MH'
    set ib_skillName[349] = "神罗天征"
    set ib_skillCustom[349] = 1
    set ib_skillList[350] = 'A0MK'
    set ib_skillName[350] = "迷你尾兽弹"
    set ib_skillCustom[350] = 1
    set ib_skillList[351] = 'A0MP'
    set ib_skillName[351] = "1力量上升治疗区域"
    set ib_skillCustom[351] = 1
    set ib_skillList[352] = 'A0MQ'
    set ib_skillName[352] = "2力量上升治疗区域"
    set ib_skillCustom[352] = 1
    set ib_skillList[353] = 'A0MS'
    set ib_skillName[353] = "灵魂救赎"
    set ib_skillCustom[353] = 1
    set ib_skillList[354] = 'A0MT'
    set ib_skillName[354] = "瞬身"
    set ib_skillCustom[354] = 1
    set ib_skillList[355] = 'A0MW'
    set ib_skillName[355] = "九尾模式"
    set ib_skillCustom[355] = 1
    set ib_skillList[356] = 'A0MX'
    set ib_skillName[356] = "-四代幻影"
    set ib_skillCustom[356] = 1
    set ib_skillList[357] = 'A0MY'
    set ib_skillName[357] = "水遁.水龙弹之术"
    set ib_skillCustom[357] = 1
    set ib_skillList[358] = 'A0MZ'
    set ib_skillName[358] = "水遁.水阵柱"
    set ib_skillCustom[358] = 1
    set ib_skillList[359] = 'A0N0'
    set ib_skillName[359] = "血继限界"
    set ib_skillCustom[359] = 1
    set ib_skillList[360] = 'A0N1'
    set ib_skillName[360] = "水遁.雾隐之术"
    set ib_skillCustom[360] = 1
    set ib_skillList[361] = 'A0N2'
    set ib_skillName[361] = "熔遁.熔怪之术"
    set ib_skillCustom[361] = 1
    set ib_skillList[362] = 'A0N3'
    set ib_skillName[362] = "沸遁.巧雾之术"
    set ib_skillCustom[362] = 1
    set ib_skillList[363] = 'A0N6'
    set ib_skillName[363] = "1隐形术"
    set ib_skillCustom[363] = 1
    set ib_skillList[364] = 'A0N7'
    set ib_skillName[364] = "1永久的隐形"
    set ib_skillCustom[364] = 1
    set ib_skillList[365] = 'A0N9'
    set ib_skillName[365] = "溶遁.溶甲之术"
    set ib_skillCustom[365] = 1
    set ib_skillList[366] = 'A0NK'
    set ib_skillName[366] = "禁术.百豪之印"
    set ib_skillCustom[366] = 1
    set ib_skillList[367] = 'A0NN'
    set ib_skillName[367] = "11我爱罗妈妈"
    set ib_skillCustom[367] = 1
    set ib_skillList[368] = 'A0NQ'
    set ib_skillName[368] = "所有属性+50"
    set ib_skillCustom[368] = 1
    set ib_skillList[369] = 'A0NS'
    set ib_skillName[369] = "封印.十拳剑"
    set ib_skillCustom[369] = 1
    set ib_skillList[370] = 'A0NT'
    set ib_skillName[370] = "幻术.泡沫"
    set ib_skillCustom[370] = 1
    set ib_skillList[371] = 'A0NU'
    set ib_skillName[371] = "-u和鬼鲛buff"
    set ib_skillCustom[371] = 1
    set ib_skillList[372] = 'A0NV'
    set ib_skillName[372] = "-u和鬼鲛buff"
    set ib_skillCustom[372] = 1
    set ib_skillList[373] = 'A0O2'
    set ib_skillName[373] = "木遁秘术.树界降诞"
    set ib_skillCustom[373] = 1
    set ib_skillList[374] = 'A0O3'
    set ib_skillName[374] = "-自来也仙人"
    set ib_skillCustom[374] = 1
    set ib_skillList[375] = 'A0O5'
    set ib_skillName[375] = "仙法.聚气"
    set ib_skillCustom[375] = 1
    set ib_skillList[376] = 'A0OO'
    set ib_skillName[376] = "分裂术"
    set ib_skillCustom[376] = 1
    set ib_skillList[377] = 'A0OX'
    set ib_skillName[377] = "！！附加点"
    set ib_skillCustom[377] = 1
    set ib_skillList[378] = 'A0P2'
    set ib_skillName[378] = "封印术.五行封印"
    set ib_skillCustom[378] = 1
    set ib_skillList[379] = 'A0P5'
    set ib_skillName[379] = "猛扑"
    set ib_skillCustom[379] = 1
    set ib_skillList[380] = 'A0PC'
    set ib_skillName[380] = "全属性+1118"
    set ib_skillCustom[380] = 1
    set ib_skillList[381] = 'A0PD'
    set ib_skillName[381] = "速度+80"
    set ib_skillCustom[381] = 1
    set ib_skillList[382] = 'A0PH'
    set ib_skillName[382] = "11佐助须佐"
    set ib_skillCustom[382] = 1
    set ib_skillList[383] = 'A0PJ'
    set ib_skillName[383] = "神罗天征"
    set ib_skillCustom[383] = 1
    set ib_skillList[384] = 'A0PN'
    set ib_skillName[384] = "3力量上升治疗区域"
    set ib_skillCustom[384] = 1
    set ib_skillList[385] = 'A0PO'
    set ib_skillName[385] = "仙人之力"
    set ib_skillCustom[385] = 1
    set ib_skillList[386] = 'A0PQ'
    set ib_skillName[386] = "4力量上升治疗区域"
    set ib_skillCustom[386] = 1
    set ib_skillList[387] = 'A0PS'
    set ib_skillName[387] = "阴阳遁术.双刃冲刺"
    set ib_skillCustom[387] = 1
    set ib_skillList[388] = 'A0PY'
    set ib_skillName[388] = "-带土护身"
    set ib_skillCustom[388] = 1
    set ib_skillList[389] = 'A0Q0'
    set ib_skillName[389] = "写轮眼and轮回眼"
    set ib_skillCustom[389] = 1
    set ib_skillList[390] = 'A0Q6'
    set ib_skillName[390] = "尾兽之力"
    set ib_skillCustom[390] = 1
    set ib_skillList[391] = 'A0Q7'
    set ib_skillName[391] = "雷遁.超音震雷遁刀"
    set ib_skillCustom[391] = 1
    set ib_skillList[392] = 'A0QA'
    set ib_skillName[392] = "四代二段"
    set ib_skillCustom[392] = 1
    set ib_skillList[393] = 'A0QH'
    set ib_skillName[393] = "-四代闪光幻影"
    set ib_skillCustom[393] = 1
    set ib_skillList[394] = 'A0QI'
    set ib_skillName[394] = "黄色闪光"
    set ib_skillCustom[394] = 1
    set ib_skillList[395] = 'A0QL'
    set ib_skillName[395] = "傀儡操纵"
    set ib_skillCustom[395] = 1
    set ib_skillList[396] = 'A0QM'
    set ib_skillName[396] = "砂铁结袭"
    set ib_skillCustom[396] = 1
    set ib_skillList[397] = 'A0QR'
    set ib_skillName[397] = "百机"
    set ib_skillCustom[397] = 1
    set ib_skillList[398] = 'A0QS'
    set ib_skillName[398] = "-白闪避"
    set ib_skillCustom[398] = 1
    set ib_skillList[399] = 'A0QT'
    set ib_skillName[399] = "白.闪避"
    set ib_skillCustom[399] = 1
endfunction
function IB_SkillFill5 takes nothing returns nothing
    set ib_skillList[400] = 'A0QW'
    set ib_skillName[400] = "乌鸦分身术"
    set ib_skillCustom[400] = 1
    set ib_skillList[401] = 'A0QY'
    set ib_skillName[401] = "雷遁.重流暴"
    set ib_skillCustom[401] = 1
    set ib_skillList[402] = 'A0R1'
    set ib_skillName[402] = "通灵术.五重罗生门"
    set ib_skillCustom[402] = 1
    set ib_skillList[403] = 'A0R5'
    set ib_skillName[403] = "死亡之舞"
    set ib_skillCustom[403] = 1
    set ib_skillList[404] = 'A0R6'
    set ib_skillName[404] = "死亡咆哮"
    set ib_skillCustom[404] = 1
    set ib_skillList[405] = 'A0R8'
    set ib_skillName[405] = "咒术.死司凭血"
    set ib_skillCustom[405] = 1
    set ib_skillList[406] = 'A0RG'
    set ib_skillName[406] = "火遁.头刻苦"
    set ib_skillCustom[406] = 1
    set ib_skillList[407] = 'A0RH'
    set ib_skillName[407] = "风遁.压害"
    set ib_skillCustom[407] = 1
    set ib_skillList[408] = 'A0RI'
    set ib_skillName[408] = "雷遁.伪暗"
    set ib_skillCustom[408] = 1
    set ib_skillList[409] = 'A0RJ'
    set ib_skillName[409] = "齐火一发"
    set ib_skillCustom[409] = 1
    set ib_skillList[410] = 'A0RL'
    set ib_skillName[410] = "触手重拳"
    set ib_skillCustom[410] = 1
    set ib_skillList[411] = 'A0RN'
    set ib_skillName[411] = "瞬身之术"
    set ib_skillCustom[411] = 1
    set ib_skillList[412] = 'A0RQ'
    set ib_skillName[412] = "毁灭森罗"
    set ib_skillCustom[412] = 1
    set ib_skillList[413] = 'A0RR'
    set ib_skillName[413] = "-须作附加技能（完全体）"
    set ib_skillCustom[413] = 1
    set ib_skillList[414] = 'A0RS'
    set ib_skillName[414] = "飞雷神斩杀术"
    set ib_skillCustom[414] = 1
    set ib_skillList[415] = 'A0RT'
    set ib_skillName[415] = "互乘起爆符"
    set ib_skillCustom[415] = 1
    set ib_skillList[416] = 'A0RV'
    set ib_skillName[416] = "乌鸦分身之术"
    set ib_skillCustom[416] = 1
    set ib_skillList[417] = 'A0S6'
    set ib_skillName[417] = "求道玉.攻击"
    set ib_skillCustom[417] = 1
    set ib_skillList[418] = 'A0S7'
    set ib_skillName[418] = "轮墓.边狱"
    set ib_skillCustom[418] = 1
    set ib_skillList[419] = 'A0S8'
    set ib_skillName[419] = "轮回眼"
    set ib_skillCustom[419] = 1
    set ib_skillList[420] = 'A0S9'
    set ib_skillName[420] = "仙法.阴遁雷派"
    set ib_skillCustom[420] = 1
    set ib_skillList[421] = 'A0SA'
    set ib_skillName[421] = "神.树界降临"
    set ib_skillCustom[421] = 1
    set ib_skillList[422] = 'A0SB'
    set ib_skillName[422] = "神.地爆天星"
    set ib_skillCustom[422] = 1
    set ib_skillList[423] = 'A0SC'
    set ib_skillName[423] = "永久的隐形2"
    set ib_skillCustom[423] = 1
    set ib_skillList[424] = 'A0SE'
    set ib_skillName[424] = "d级减速"
    set ib_skillCustom[424] = 1
    set ib_skillList[425] = 'A0SU'
    set ib_skillName[425] = "减速光环 (辉夜)"
    set ib_skillCustom[425] = 1
    set ib_skillList[426] = 'A0T1'
    set ib_skillName[426] = "卡"
    set ib_skillCustom[426] = 1
    set ib_skillList[427] = 'A0T2'
    set ib_skillName[427] = "神威.手里剑"
    set ib_skillCustom[427] = 1
    set ib_skillList[428] = 'A0T3'
    set ib_skillName[428] = "森罗斩"
    set ib_skillCustom[428] = 1
    set ib_skillList[429] = 'A0T9'
    set ib_skillName[429] = "天手力.己"
    set ib_skillCustom[429] = 1
    set ib_skillList[430] = 'A0TC'
    set ib_skillName[430] = "地爆天星"
    set ib_skillCustom[430] = 1
    set ib_skillList[431] = 'A0TD'
    set ib_skillName[431] = "z轮回眼"
    set ib_skillCustom[431] = 1
    set ib_skillList[432] = 'A0TE'
    set ib_skillName[432] = "1轮回眼"
    set ib_skillCustom[432] = 1
    set ib_skillList[433] = 'A0TF'
    set ib_skillName[433] = "六道佐助"
    set ib_skillCustom[433] = 1
    set ib_skillList[434] = 'A0TG'
    set ib_skillName[434] = "因陀罗之矢"
    set ib_skillCustom[434] = 1
    set ib_skillList[435] = 'A0TH'
    set ib_skillName[435] = "写轮眼"
    set ib_skillCustom[435] = 1
    set ib_skillList[436] = 'A0TN'
    set ib_skillName[436] = "六道之力.阳"
    set ib_skillCustom[436] = 1
    set ib_skillList[437] = 'A0TQ'
    set ib_skillName[437] = "鸣"
    set ib_skillCustom[437] = 1
    set ib_skillList[438] = 'A0TR'
    set ib_skillName[438] = "尾兽外衣"
    set ib_skillCustom[438] = 1
    set ib_skillList[439] = 'A0TU'
    set ib_skillName[439] = "仙法.多重影分身术"
    set ib_skillCustom[439] = 1
    set ib_skillList[440] = 'A0TX'
    set ib_skillName[440] = "仙法.白激之术"
    set ib_skillCustom[440] = 1
    set ib_skillList[441] = 'A0U0'
    set ib_skillName[441] = "仙人力量"
    set ib_skillCustom[441] = 1
    set ib_skillList[442] = 'A0U3'
    set ib_skillName[442] = "自然恢复"
    set ib_skillCustom[442] = 1
    set ib_skillList[443] = 'A0UB'
    set ib_skillName[443] = "毁灭森罗"
    set ib_skillCustom[443] = 1
    set ib_skillList[444] = 'A0UF'
    set ib_skillName[444] = "-畜生道-佩恩"
    set ib_skillCustom[444] = 1
    set ib_skillList[445] = 'A0UH'
    set ib_skillName[445] = "5力量上升治疗区域"
    set ib_skillCustom[445] = 1
    set ib_skillList[446] = 'A0UJ'
    set ib_skillName[446] = "木叶烈风"
    set ib_skillCustom[446] = 1
    set ib_skillList[447] = 'A0UM'
    set ib_skillName[447] = "禁术.八门遁甲"
    set ib_skillCustom[447] = 1
    set ib_skillList[448] = 'A0UR'
    set ib_skillName[448] = "工程升级"
    set ib_skillCustom[448] = 1
    set ib_skillList[449] = 'A0UV'
    set ib_skillName[449] = "粘土分身"
    set ib_skillCustom[449] = 1
    set ib_skillList[450] = 'A0UW'
    set ib_skillName[450] = "爆炸"
    set ib_skillCustom[450] = 1
    set ib_skillList[451] = 'A0UY'
    set ib_skillName[451] = "精神攻击"
    set ib_skillCustom[451] = 1
    set ib_skillList[452] = 'A0V1'
    set ib_skillName[452] = "阴阳遁术.精神附体"
    set ib_skillCustom[452] = 1
    set ib_skillList[453] = 'A0V3'
    set ib_skillName[453] = "工程升级"
    set ib_skillCustom[453] = 1
    set ib_skillList[454] = 'A0V4'
    set ib_skillName[454] = "天之御中.超重力"
    set ib_skillCustom[454] = 1
    set ib_skillList[455] = 'A0V8'
    set ib_skillName[455] = "操控白绝"
    set ib_skillCustom[455] = 1
    set ib_skillList[456] = 'A0V9'
    set ib_skillName[456] = "共杀灰骨"
    set ib_skillCustom[456] = 1
    set ib_skillList[457] = 'A0VD'
    set ib_skillName[457] = "神罗天征"
    set ib_skillCustom[457] = 1
    set ib_skillList[458] = 'A0VE'
    set ib_skillName[458] = "增值.通灵之术"
    set ib_skillCustom[458] = 1
    set ib_skillList[459] = 'A0VF'
    set ib_skillName[459] = "修罗之攻.怪弹火矢"
    set ib_skillCustom[459] = 1
    set ib_skillList[460] = 'A0VG'
    set ib_skillName[460] = "地爆天星"
    set ib_skillCustom[460] = 1
    set ib_skillList[461] = 'A0VL'
    set ib_skillName[461] = "天手力.己"
    set ib_skillCustom[461] = 1
    set ib_skillList[462] = 'A0VN'
    set ib_skillName[462] = "神罗天征"
    set ib_skillCustom[462] = 1
    set ib_skillList[463] = 'A0VS'
    set ib_skillName[463] = "瞳术.天照"
    set ib_skillCustom[463] = 1
    set ib_skillList[464] = 'AAns'
    set ib_skillName[464] = "收费"
    set ib_skillCustom[464] = 0
    set ib_skillList[465] = 'ACac'
    set ib_skillName[465] = "命令光环"
    set ib_skillCustom[465] = 0
    set ib_skillList[466] = 'ACad'
    set ib_skillName[466] = "操纵死尸"
    set ib_skillCustom[466] = 0
    set ib_skillList[467] = 'ACah'
    set ib_skillName[467] = "荆棘光环"
    set ib_skillCustom[467] = 0
    set ib_skillList[468] = 'ACam'
    set ib_skillName[468] = "反魔法外壳"
    set ib_skillCustom[468] = 0
    set ib_skillList[469] = 'ACat'
    set ib_skillName[469] = "强击光环"
    set ib_skillCustom[469] = 0
    set ib_skillList[470] = 'ACav'
    set ib_skillName[470] = "专注光环"
    set ib_skillCustom[470] = 0
    set ib_skillList[471] = 'ACba'
    set ib_skillName[471] = "辉煌光环"
    set ib_skillCustom[471] = 0
    set ib_skillList[472] = 'ACbb'
    set ib_skillName[472] = "嗜血术"
    set ib_skillCustom[472] = 0
    set ib_skillList[473] = 'ACbc'
    set ib_skillName[473] = "火焰呼吸"
    set ib_skillCustom[473] = 0
    set ib_skillList[474] = 'ACbf'
    set ib_skillName[474] = "霜冻闪电"
    set ib_skillCustom[474] = 0
    set ib_skillList[475] = 'ACbh'
    set ib_skillName[475] = "重击"
    set ib_skillCustom[475] = 0
    set ib_skillList[476] = 'ACbk'
    set ib_skillName[476] = "黑暗之箭"
    set ib_skillCustom[476] = 0
    set ib_skillList[477] = 'ACbl'
    set ib_skillName[477] = "嗜血术"
    set ib_skillCustom[477] = 0
    set ib_skillList[478] = 'ACbn'
    set ib_skillName[478] = "驱散"
    set ib_skillCustom[478] = 0
    set ib_skillList[479] = 'ACbr'
    set ib_skillName[479] = "狂暴愤怒"
    set ib_skillCustom[479] = 0
endfunction
function IB_SkillFill6 takes nothing returns nothing
    set ib_skillList[480] = 'ACbz'
    set ib_skillName[480] = "暴风雪"
    set ib_skillCustom[480] = 0
    set ib_skillList[481] = 'ACc2'
    set ib_skillName[481] = "冲击波"
    set ib_skillCustom[481] = 0
    set ib_skillList[482] = 'ACc3'
    set ib_skillName[482] = "冲击波"
    set ib_skillCustom[482] = 0
    set ib_skillList[483] = 'ACca'
    set ib_skillName[483] = "腐臭蜂群"
    set ib_skillCustom[483] = 0
    set ib_skillList[484] = 'ACcb'
    set ib_skillName[484] = "霜冻闪电"
    set ib_skillCustom[484] = 0
    set ib_skillList[485] = 'ACce'
    set ib_skillName[485] = "分裂攻击"
    set ib_skillCustom[485] = 0
    set ib_skillList[486] = 'ACch'
    set ib_skillName[486] = "符咒"
    set ib_skillCustom[486] = 0
    set ib_skillList[487] = 'ACcl'
    set ib_skillName[487] = "闪电链"
    set ib_skillCustom[487] = 0
    set ib_skillList[488] = 'ACcn'
    set ib_skillName[488] = "吞食尸体"
    set ib_skillCustom[488] = 0
    set ib_skillList[489] = 'ACcr'
    set ib_skillName[489] = "残废"
    set ib_skillCustom[489] = 0
    set ib_skillList[490] = 'ACcs'
    set ib_skillName[490] = "诅咒"
    set ib_skillCustom[490] = 0
    set ib_skillList[491] = 'ACct'
    set ib_skillName[491] = "致命一击"
    set ib_skillCustom[491] = 0
    set ib_skillList[492] = 'ACcv'
    set ib_skillName[492] = "冲击波"
    set ib_skillCustom[492] = 0
    set ib_skillList[493] = 'ACcw'
    set ib_skillName[493] = "冰冻冷箭"
    set ib_skillCustom[493] = 0
    set ib_skillList[494] = 'ACcy'
    set ib_skillName[494] = "飓风"
    set ib_skillCustom[494] = 0
    set ib_skillList[495] = 'ACd2'
    set ib_skillName[495] = "驱逐魔法"
    set ib_skillCustom[495] = 0
    set ib_skillList[496] = 'ACdc'
    set ib_skillName[496] = "死亡缠绕"
    set ib_skillCustom[496] = 0
    set ib_skillList[497] = 'ACde'
    set ib_skillName[497] = "吞噬魔法"
    set ib_skillCustom[497] = 0
    set ib_skillList[498] = 'ACdm'
    set ib_skillName[498] = "驱逐魔法"
    set ib_skillCustom[498] = 0
    set ib_skillList[499] = 'ACdr'
    set ib_skillName[499] = "生命汲取"
    set ib_skillCustom[499] = 0
    set ib_skillList[500] = 'ACds'
    set ib_skillName[500] = "神圣护甲"
    set ib_skillCustom[500] = 0
    set ib_skillList[501] = 'ACdv'
    set ib_skillName[501] = "吞噬"
    set ib_skillCustom[501] = 0
    set ib_skillList[502] = 'ACen'
    set ib_skillName[502] = "诱捕"
    set ib_skillCustom[502] = 0
    set ib_skillList[503] = 'ACes'
    set ib_skillName[503] = "闪避"
    set ib_skillCustom[503] = 0
    set ib_skillList[504] = 'ACev'
    set ib_skillName[504] = "闪避"
    set ib_skillCustom[504] = 0
    set ib_skillList[505] = 'ACf2'
    set ib_skillName[505] = "霜冻护甲"
    set ib_skillCustom[505] = 0
    set ib_skillList[506] = 'ACf3'
    set ib_skillName[506] = "痛苦之指"
    set ib_skillCustom[506] = 0
    set ib_skillList[507] = 'ACfa'
    set ib_skillName[507] = "霜冻护甲"
    set ib_skillCustom[507] = 0
    set ib_skillList[508] = 'ACfb'
    set ib_skillName[508] = "霹雳闪电"
    set ib_skillCustom[508] = 0
    set ib_skillList[509] = 'ACfd'
    set ib_skillName[509] = "痛苦之指"
    set ib_skillCustom[509] = 0
    set ib_skillList[510] = 'ACff'
    set ib_skillName[510] = "精灵之火"
    set ib_skillCustom[510] = 0
    set ib_skillList[511] = 'ACfl'
    set ib_skillName[511] = "叉状闪电"
    set ib_skillCustom[511] = 0
    set ib_skillList[512] = 'ACfn'
    set ib_skillName[512] = "霜冻新星"
    set ib_skillCustom[512] = 0
    set ib_skillList[513] = 'ACfr'
    set ib_skillName[513] = "自然之力"
    set ib_skillCustom[513] = 0
    set ib_skillList[514] = 'ACfs'
    set ib_skillName[514] = "烈焰风暴"
    set ib_skillCustom[514] = 0
    set ib_skillList[515] = 'ACfu'
    set ib_skillName[515] = "霜冻护甲"
    set ib_skillCustom[515] = 0
    set ib_skillList[516] = 'AChv'
    set ib_skillName[516] = "医疗波"
    set ib_skillCustom[516] = 0
    set ib_skillList[517] = 'AChw'
    set ib_skillName[517] = "治疗守卫"
    set ib_skillCustom[517] = 0
    set ib_skillList[518] = 'AChx'
    set ib_skillName[518] = "妖术"
    set ib_skillCustom[518] = 0
    set ib_skillList[519] = 'ACif'
    set ib_skillName[519] = "心灵之火"
    set ib_skillCustom[519] = 0
    set ib_skillList[520] = 'ACim'
    set ib_skillName[520] = "献祭"
    set ib_skillCustom[520] = 0
    set ib_skillList[521] = 'ACls'
    set ib_skillName[521] = "闪电护盾"
    set ib_skillCustom[521] = 0
    set ib_skillList[522] = 'ACm2'
    set ib_skillName[522] = "魔法免疫"
    set ib_skillCustom[522] = 0
    set ib_skillList[523] = 'ACm3'
    set ib_skillName[523] = "魔法免疫"
    set ib_skillCustom[523] = 0
    set ib_skillList[524] = 'ACmf'
    set ib_skillName[524] = "魔法护盾"
    set ib_skillCustom[524] = 0
    set ib_skillList[525] = 'ACmi'
    set ib_skillName[525] = "魔法免疫"
    set ib_skillCustom[525] = 0
    set ib_skillList[526] = 'ACmo'
    set ib_skillName[526] = "季风"
    set ib_skillCustom[526] = 0
    set ib_skillList[527] = 'ACmp'
    set ib_skillName[527] = "穿刺"
    set ib_skillCustom[527] = 0
    set ib_skillList[528] = 'ACnr'
    set ib_skillName[528] = "生命恢复光环"
    set ib_skillCustom[528] = 0
    set ib_skillList[529] = 'ACpa'
    set ib_skillName[529] = "寄生虫"
    set ib_skillCustom[529] = 0
    set ib_skillList[530] = 'ACps'
    set ib_skillName[530] = "占据"
    set ib_skillCustom[530] = 0
    set ib_skillList[531] = 'ACpu'
    set ib_skillName[531] = "净化"
    set ib_skillCustom[531] = 0
    set ib_skillList[532] = 'ACpv'
    set ib_skillName[532] = "粉碎"
    set ib_skillCustom[532] = 0
    set ib_skillList[533] = 'ACpy'
    set ib_skillName[533] = "变形术"
    set ib_skillCustom[533] = 0
    set ib_skillList[534] = 'ACr1'
    set ib_skillName[534] = "咆哮"
    set ib_skillCustom[534] = 0
    set ib_skillList[535] = 'ACr2'
    set ib_skillName[535] = "生命恢复"
    set ib_skillCustom[535] = 0
    set ib_skillList[536] = 'ACrd'
    set ib_skillName[536] = "复活死尸"
    set ib_skillCustom[536] = 0
    set ib_skillList[537] = 'ACrf'
    set ib_skillName[537] = "火焰雨"
    set ib_skillCustom[537] = 0
    set ib_skillList[538] = 'ACrg'
    set ib_skillName[538] = "火焰雨"
    set ib_skillCustom[538] = 0
    set ib_skillList[539] = 'ACrj'
    set ib_skillName[539] = "生命恢复"
    set ib_skillCustom[539] = 0
    set ib_skillList[540] = 'ACrk'
    set ib_skillName[540] = "抗性皮肤"
    set ib_skillCustom[540] = 0
    set ib_skillList[541] = 'ACrn'
    set ib_skillName[541] = "重生"
    set ib_skillCustom[541] = 0
    set ib_skillList[542] = 'ACro'
    set ib_skillName[542] = "咆哮"
    set ib_skillCustom[542] = 0
    set ib_skillList[543] = 'ACs7'
    set ib_skillName[543] = "野兽幽魂"
    set ib_skillCustom[543] = 0
    set ib_skillList[544] = 'ACs8'
    set ib_skillName[544] = "灵兽"
    set ib_skillCustom[544] = 0
    set ib_skillList[545] = 'ACs9'
    set ib_skillName[545] = "野兽幽魂"
    set ib_skillCustom[545] = 0
    set ib_skillList[546] = 'ACsa'
    set ib_skillName[546] = "灼热之箭"
    set ib_skillCustom[546] = 0
    set ib_skillList[547] = 'ACsf'
    set ib_skillName[547] = "野兽幽魂"
    set ib_skillCustom[547] = 0
    set ib_skillList[548] = 'ACsh'
    set ib_skillName[548] = "震荡波"
    set ib_skillCustom[548] = 0
    set ib_skillList[549] = 'ACsi'
    set ib_skillName[549] = "-沉默魔法"
    set ib_skillCustom[549] = 0
    set ib_skillList[550] = 'ACsk'
    set ib_skillName[550] = "抗性皮肤"
    set ib_skillCustom[550] = 0
    set ib_skillList[551] = 'ACsl'
    set ib_skillName[551] = "睡眠"
    set ib_skillCustom[551] = 0
    set ib_skillList[552] = 'ACsm'
    set ib_skillName[552] = "魔法吸吮"
    set ib_skillCustom[552] = 0
    set ib_skillList[553] = 'ACsp'
    set ib_skillName[553] = "睡眠"
    set ib_skillCustom[553] = 0
    set ib_skillList[554] = 'ACst'
    set ib_skillName[554] = "震荡波"
    set ib_skillCustom[554] = 0
    set ib_skillList[555] = 'ACsw'
    set ib_skillName[555] = "减速"
    set ib_skillCustom[555] = 0
    set ib_skillList[556] = 'ACt2'
    set ib_skillName[556] = "雷霆一击"
    set ib_skillCustom[556] = 0
    set ib_skillList[557] = 'ACtb'
    set ib_skillName[557] = "投石"
    set ib_skillCustom[557] = 0
    set ib_skillList[558] = 'ACtc'
    set ib_skillName[558] = "雷霆一击"
    set ib_skillCustom[558] = 0
    set ib_skillList[559] = 'ACtn'
    set ib_skillName[559] = "产卵触角"
    set ib_skillCustom[559] = 0
endfunction
function IB_SkillFill7 takes nothing returns nothing
    set ib_skillList[560] = 'ACua'
    set ib_skillName[560] = "邪恶光环"
    set ib_skillCustom[560] = 0
    set ib_skillList[561] = 'ACuf'
    set ib_skillName[561] = "邪恶狂热"
    set ib_skillCustom[561] = 0
    set ib_skillList[562] = 'ACvp'
    set ib_skillName[562] = "吸血光环"
    set ib_skillCustom[562] = 0
    set ib_skillList[563] = 'ACvs'
    set ib_skillName[563] = "浸毒武器"
    set ib_skillCustom[563] = 0
    set ib_skillList[564] = 'ACwb'
    set ib_skillName[564] = "蛛网"
    set ib_skillCustom[564] = 0
    set ib_skillList[565] = 'ACwe'
    set ib_skillName[565] = "召唤海元素"
    set ib_skillCustom[565] = 0
    set ib_skillList[566] = 'AEIl'
    set ib_skillName[566] = "变身"
    set ib_skillCustom[566] = 0
    set ib_skillList[567] = 'AEah'
    set ib_skillName[567] = "荆棘光环"
    set ib_skillCustom[567] = 0
    set ib_skillList[568] = 'AEar'
    set ib_skillName[568] = "强击光环"
    set ib_skillCustom[568] = 0
    set ib_skillList[569] = 'AEbl'
    set ib_skillName[569] = "闪烁"
    set ib_skillCustom[569] = 0
    set ib_skillList[570] = 'AEbu'
    set ib_skillName[570] = "建造 (暗夜精灵)"
    set ib_skillCustom[570] = 0
    set ib_skillList[571] = 'AEer'
    set ib_skillName[571] = "纠缠根须"
    set ib_skillCustom[571] = 0
    set ib_skillList[572] = 'AEev'
    set ib_skillName[572] = "闪避"
    set ib_skillCustom[572] = 0
    set ib_skillList[573] = 'AEfk'
    set ib_skillName[573] = "刀阵旋风"
    set ib_skillCustom[573] = 0
    set ib_skillList[574] = 'AEfn'
    set ib_skillName[574] = "自然之力"
    set ib_skillCustom[574] = 0
    set ib_skillList[575] = 'AEim'
    set ib_skillName[575] = "献祭"
    set ib_skillCustom[575] = 0
    set ib_skillList[576] = 'AEmb'
    set ib_skillName[576] = "法力燃烧"
    set ib_skillCustom[576] = 0
    set ib_skillList[577] = 'AEme'
    set ib_skillName[577] = "变身"
    set ib_skillCustom[577] = 0
    set ib_skillList[578] = 'AEpa'
    set ib_skillName[578] = "毒箭"
    set ib_skillCustom[578] = 0
    set ib_skillList[579] = 'AEsb'
    set ib_skillName[579] = "群星坠落"
    set ib_skillCustom[579] = 0
    set ib_skillList[580] = 'AEsf'
    set ib_skillName[580] = "群星坠落"
    set ib_skillCustom[580] = 0
    set ib_skillList[581] = 'AEsh'
    set ib_skillName[581] = "暗影突袭"
    set ib_skillCustom[581] = 0
    set ib_skillList[582] = 'AEst'
    set ib_skillName[582] = "侦察"
    set ib_skillCustom[582] = 0
    set ib_skillList[583] = 'AEsv'
    set ib_skillName[583] = "复仇之魂"
    set ib_skillCustom[583] = 0
    set ib_skillList[584] = 'AEtq'
    set ib_skillName[584] = "宁静"
    set ib_skillCustom[584] = 0
    set ib_skillList[585] = 'AEvi'
    set ib_skillName[585] = "变身"
    set ib_skillCustom[585] = 0
    set ib_skillList[586] = 'AGbu'
    set ib_skillName[586] = "建造(娜迦)"
    set ib_skillCustom[586] = 0
    set ib_skillList[587] = 'AHab'
    set ib_skillName[587] = "辉煌光环"
    set ib_skillCustom[587] = 0
    set ib_skillList[588] = 'AHad'
    set ib_skillName[588] = "专注光环"
    set ib_skillCustom[588] = 0
    set ib_skillList[589] = 'AHav'
    set ib_skillName[589] = "天神下凡"
    set ib_skillCustom[589] = 0
    set ib_skillList[590] = 'AHbh'
    set ib_skillName[590] = "醉拳"
    set ib_skillCustom[590] = 0
    set ib_skillList[591] = 'AHbn'
    set ib_skillName[591] = "驱散"
    set ib_skillCustom[591] = 0
    set ib_skillList[592] = 'AHbu'
    set ib_skillName[592] = "建造(人族)"
    set ib_skillCustom[592] = 0
    set ib_skillList[593] = 'AHbz'
    set ib_skillName[593] = "暴风雪"
    set ib_skillCustom[593] = 0
    set ib_skillList[594] = 'AHca'
    set ib_skillName[594] = "冰冻冷箭"
    set ib_skillCustom[594] = 0
    set ib_skillList[595] = 'AHdr'
    set ib_skillName[595] = "魔法吸吮"
    set ib_skillCustom[595] = 0
    set ib_skillList[596] = 'AHds'
    set ib_skillName[596] = "神圣护甲"
    set ib_skillCustom[596] = 0
    set ib_skillList[597] = 'AHer'
    set ib_skillName[597] = "英雄"
    set ib_skillCustom[597] = 0
    set ib_skillList[598] = 'AHfa'
    set ib_skillName[598] = "灼热之箭"
    set ib_skillCustom[598] = 0
    set ib_skillList[599] = 'AHfs'
    set ib_skillName[599] = "烈焰风暴"
    set ib_skillCustom[599] = 0
    set ib_skillList[600] = 'AHhb'
    set ib_skillName[600] = "神圣之光"
    set ib_skillCustom[600] = 0
    set ib_skillList[601] = 'AHmt'
    set ib_skillName[601] = "群体传送"
    set ib_skillCustom[601] = 0
    set ib_skillList[602] = 'AHpx'
    set ib_skillName[602] = "火凤凰"
    set ib_skillCustom[602] = 0
    set ib_skillList[603] = 'AHre'
    set ib_skillName[603] = "复活"
    set ib_skillCustom[603] = 0
    set ib_skillList[604] = 'AHta'
    set ib_skillName[604] = "显示"
    set ib_skillCustom[604] = 0
    set ib_skillList[605] = 'AHtb'
    set ib_skillName[605] = "风遁·镰鼬"
    set ib_skillCustom[605] = 0
    set ib_skillList[606] = 'AHtc'
    set ib_skillName[606] = "雷霆一击"
    set ib_skillCustom[606] = 0
    set ib_skillList[607] = 'AHwe'
    set ib_skillName[607] = "召唤水元素"
    set ib_skillCustom[607] = 0
    set ib_skillList[608] = 'AI2m'
    set ib_skillName[608] = "能增加魔法值的物品(200)"
    set ib_skillCustom[608] = 0
    set ib_skillList[609] = 'AIa1'
    set ib_skillName[609] = "能提高英雄属性的物品"
    set ib_skillCustom[609] = 0
    set ib_skillList[610] = 'AIa3'
    set ib_skillName[610] = "能提高英雄属性的物品"
    set ib_skillCustom[610] = 0
    set ib_skillList[611] = 'AIa4'
    set ib_skillName[611] = "能提高英雄属性的物品"
    set ib_skillCustom[611] = 0
    set ib_skillList[612] = 'AIa6'
    set ib_skillName[612] = "能提高英雄属性的物品"
    set ib_skillCustom[612] = 0
    set ib_skillList[613] = 'AIaa'
    set ib_skillName[613] = "能增加攻击力的物品"
    set ib_skillCustom[613] = 0
    set ib_skillList[614] = 'AIab'
    set ib_skillName[614] = "能提高英雄属性的物品"
    set ib_skillCustom[614] = 0
    set ib_skillList[615] = 'AIam'
    set ib_skillName[615] = "能增加敏捷度的物品"
    set ib_skillCustom[615] = 0
    set ib_skillList[616] = 'AIan'
    set ib_skillName[616] = "能操纵死尸的物品"
    set ib_skillCustom[616] = 0
    set ib_skillList[617] = 'AIas'
    set ib_skillName[617] = "能提高攻击速度的物品"
    set ib_skillCustom[617] = 0
    set ib_skillList[618] = 'AIat'
    set ib_skillName[618] = "增加攻击力的物品"
    set ib_skillCustom[618] = 0
    set ib_skillList[619] = 'AIaz'
    set ib_skillName[619] = "能提高英雄属性的物品"
    set ib_skillCustom[619] = 0
    set ib_skillList[620] = 'AIbb'
    set ib_skillName[620] = "建造微型铁匠铺"
    set ib_skillCustom[620] = 0
    set ib_skillList[621] = 'AIbf'
    set ib_skillName[621] = "建造微型农场"
    set ib_skillCustom[621] = 0
    set ib_skillList[622] = 'AIbg'
    set ib_skillName[622] = "建造小型的大厅"
    set ib_skillCustom[622] = 0
    set ib_skillList[623] = 'AIbh'
    set ib_skillName[623] = "建造微型国王祭坛"
    set ib_skillCustom[623] = 0
    set ib_skillList[624] = 'AIbk'
    set ib_skillName[624] = "闪烁(物品等级)"
    set ib_skillCustom[624] = 0
    set ib_skillList[625] = 'AIbl'
    set ib_skillName[625] = "建造小型的城堡"
    set ib_skillCustom[625] = 0
    set ib_skillList[626] = 'AIbm'
    set ib_skillName[626] = "能增加魔法值的物品"
    set ib_skillCustom[626] = 0
    set ib_skillList[627] = 'AIbr'
    set ib_skillName[627] = "建造微型伐木场"
    set ib_skillCustom[627] = 0
    set ib_skillList[628] = 'AIbs'
    set ib_skillName[628] = "建造微型兵营"
    set ib_skillCustom[628] = 0
    set ib_skillList[629] = 'AIbt'
    set ib_skillName[629] = "建造小型的哨塔"
    set ib_skillCustom[629] = 0
    set ib_skillList[630] = 'AIbx'
    set ib_skillName[630] = "重击"
    set ib_skillCustom[630] = 0
    set ib_skillList[631] = 'AIcb'
    set ib_skillName[631] = "带有腐蚀攻击效果的物品"
    set ib_skillCustom[631] = 0
    set ib_skillList[632] = 'AIcf'
    set ib_skillName[632] = "具有献祭效果的物品"
    set ib_skillCustom[632] = 0
    set ib_skillList[633] = 'AIcl'
    set ib_skillName[633] = "闪电链"
    set ib_skillCustom[633] = 0
    set ib_skillList[634] = 'AIcm'
    set ib_skillName[634] = "控制魔法"
    set ib_skillCustom[634] = 0
    set ib_skillList[635] = 'AIco'
    set ib_skillName[635] = "命令物品"
    set ib_skillCustom[635] = 0
    set ib_skillList[636] = 'AIcs'
    set ib_skillName[636] = "致命一击"
    set ib_skillCustom[636] = 0
    set ib_skillList[637] = 'AIct'
    set ib_skillName[637] = "改变一天的时间"
    set ib_skillCustom[637] = 0
    set ib_skillList[638] = 'AIcy'
    set ib_skillName[638] = "飓风"
    set ib_skillCustom[638] = 0
    set ib_skillList[639] = 'AId0'
    set ib_skillName[639] = "能提高护甲的物品"
    set ib_skillCustom[639] = 0
endfunction
function IB_SkillFill8 takes nothing returns nothing
    set ib_skillList[640] = 'AId1'
    set ib_skillName[640] = "能提高护甲的物品"
    set ib_skillCustom[640] = 0
    set ib_skillList[641] = 'AId2'
    set ib_skillName[641] = "能提高护甲的物品"
    set ib_skillCustom[641] = 0
    set ib_skillList[642] = 'AId3'
    set ib_skillName[642] = "能提高护甲的物品"
    set ib_skillCustom[642] = 0
    set ib_skillList[643] = 'AId4'
    set ib_skillName[643] = "能提高护甲的物品"
    set ib_skillCustom[643] = 0
    set ib_skillList[644] = 'AId5'
    set ib_skillName[644] = "能提高护甲的物品"
    set ib_skillCustom[644] = 0
    set ib_skillList[645] = 'AId7'
    set ib_skillName[645] = "能加强护甲的物品"
    set ib_skillCustom[645] = 0
    set ib_skillList[646] = 'AId8'
    set ib_skillName[646] = "能提高护甲的物品"
    set ib_skillCustom[646] = 0
    set ib_skillList[647] = 'AIda'
    set ib_skillName[647] = "能暂时提高一定范围内所有单位护甲的物品"
    set ib_skillCustom[647] = 0
    set ib_skillList[648] = 'AIdb'
    set ib_skillName[648] = "能暂时加强范围内所有单位护甲的物品"
    set ib_skillCustom[648] = 0
    set ib_skillList[649] = 'AIdc'
    set ib_skillName[649] = "带有锁链驱逐效果的物品"
    set ib_skillCustom[649] = 0
    set ib_skillList[650] = 'AIdd'
    set ib_skillName[650] = "passive defense"
    set ib_skillCustom[650] = 0
    set ib_skillList[651] = 'AIde'
    set ib_skillName[651] = "能增加护甲的物品"
    set ib_skillCustom[651] = 0
    set ib_skillList[652] = 'AIdf'
    set ib_skillName[652] = "能带有黑箭攻击伤害的物品"
    set ib_skillCustom[652] = 0
    set ib_skillList[653] = 'AIdi'
    set ib_skillName[653] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[653] = 0
    set ib_skillList[654] = 'AIdm'
    set ib_skillName[654] = "能对范围内的树木/墙壁造成伤害的物品"
    set ib_skillCustom[654] = 0
    set ib_skillList[655] = 'AIdn'
    set ib_skillName[655] = "影子之球 技能"
    set ib_skillCustom[655] = 0
    set ib_skillList[656] = 'AIdp'
    set ib_skillName[656] = "死亡契约"
    set ib_skillCustom[656] = 0
    set ib_skillList[657] = 'AIds'
    set ib_skillName[657] = "具有驱逐魔法效果的物品"
    set ib_skillCustom[657] = 0
    set ib_skillList[658] = 'AIdv'
    set ib_skillName[658] = "物品神圣护甲"
    set ib_skillCustom[658] = 0
    set ib_skillList[659] = 'AIe2'
    set ib_skillName[659] = "能获取经验值的物品"
    set ib_skillCustom[659] = 0
    set ib_skillList[660] = 'AIem'
    set ib_skillName[660] = "能获取经验值的物品"
    set ib_skillCustom[660] = 0
    set ib_skillList[661] = 'AIev'
    set ib_skillName[661] = "闪避"
    set ib_skillCustom[661] = 0
    set ib_skillList[662] = 'AIfa'
    set ib_skillName[662] = "信号枪"
    set ib_skillCustom[662] = 0
    set ib_skillList[663] = 'AIfb'
    set ib_skillName[663] = "能带有火焰伤害的物品"
    set ib_skillCustom[663] = 0
    set ib_skillList[664] = 'AIfc'
    set ib_skillName[664] = "飞行地毯"
    set ib_skillCustom[664] = 0
    set ib_skillList[665] = 'AIfd'
    set ib_skillName[665] = "能召唤红龙的物品"
    set ib_skillCustom[665] = 0
    set ib_skillList[666] = 'AIfe'
    set ib_skillName[666] = "抢夺旗帜"
    set ib_skillCustom[666] = 0
    set ib_skillList[667] = 'AIff'
    set ib_skillName[667] = "能召唤熊怪的物品"
    set ib_skillCustom[667] = 0
    set ib_skillList[668] = 'AIfg'
    set ib_skillName[668] = "乌云技能"
    set ib_skillCustom[668] = 0
    set ib_skillList[669] = 'AIfh'
    set ib_skillName[669] = "能召唤地狱犬的物品"
    set ib_skillCustom[669] = 0
    set ib_skillList[670] = 'AIfi'
    set ib_skillName[670] = "霹雳闪电物品"
    set ib_skillCustom[670] = 0
    set ib_skillList[671] = 'AIfl'
    set ib_skillName[671] = "抢夺旗帜"
    set ib_skillCustom[671] = 0
    set ib_skillList[672] = 'AIfm'
    set ib_skillName[672] = "抢夺旗帜"
    set ib_skillCustom[672] = 0
    set ib_skillList[673] = 'AIfn'
    set ib_skillName[673] = "抢夺旗帜"
    set ib_skillCustom[673] = 0
    set ib_skillList[674] = 'AIfo'
    set ib_skillName[674] = "抢夺旗帜"
    set ib_skillCustom[674] = 0
    set ib_skillList[675] = 'AIfr'
    set ib_skillName[675] = "能召唤岩石傀儡的物品"
    set ib_skillCustom[675] = 0
    set ib_skillList[676] = 'AIfs'
    set ib_skillName[676] = "能召唤骷髅战士的物品"
    set ib_skillCustom[676] = 0
    set ib_skillList[677] = 'AIft'
    set ib_skillName[677] = "近战攻击带有冰冻伤害"
    set ib_skillCustom[677] = 0
    set ib_skillList[678] = 'AIfu'
    set ib_skillName[678] = "能召唤毁灭守卫的物品"
    set ib_skillCustom[678] = 0
    set ib_skillList[679] = 'AIfw'
    set ib_skillName[679] = "近战攻击带有火焰伤害"
    set ib_skillCustom[679] = 0
    set ib_skillList[680] = 'AIfx'
    set ib_skillName[680] = "物品兽族战斗标准"
    set ib_skillCustom[680] = 0
    set ib_skillList[681] = 'AIfz'
    set ib_skillName[681] = "死亡之指"
    set ib_skillCustom[681] = 0
    set ib_skillList[682] = 'AIgd'
    set ib_skillName[682] = "能带有火焰伤害的物品"
    set ib_skillCustom[682] = 0
    set ib_skillList[683] = 'AIgf'
    set ib_skillName[683] = "防御浮雕"
    set ib_skillCustom[683] = 0
    set ib_skillList[684] = 'AIgm'
    set ib_skillName[684] = "能增加敏捷度的物品"
    set ib_skillCustom[684] = 0
    set ib_skillList[685] = 'AIgo'
    set ib_skillName[685] = "金箱子"
    set ib_skillCustom[685] = 0
    set ib_skillList[686] = 'AIgu'
    set ib_skillName[686] = "防御浮雕"
    set ib_skillCustom[686] = 0
    set ib_skillList[687] = 'AIgx'
    set ib_skillName[687] = "恢复光环"
    set ib_skillCustom[687] = 0
    set ib_skillList[688] = 'AIh1'
    set ib_skillName[688] = "具有医疗效果的物品"
    set ib_skillCustom[688] = 0
    set ib_skillList[689] = 'AIh2'
    set ib_skillName[689] = "具有医疗效果的物品"
    set ib_skillCustom[689] = 0
    set ib_skillList[690] = 'AIh3'
    set ib_skillName[690] = "最小的医疗能力"
    set ib_skillCustom[690] = 0
    set ib_skillList[691] = 'AIha'
    set ib_skillName[691] = "能进行范围医疗的物品"
    set ib_skillCustom[691] = 0
    set ib_skillList[692] = 'AIhb'
    set ib_skillName[692] = "能进行范围医疗的物品"
    set ib_skillCustom[692] = 0
    set ib_skillList[693] = 'AIhe'
    set ib_skillName[693] = "具有医疗效果的物品"
    set ib_skillCustom[693] = 0
    set ib_skillList[694] = 'AIhl'
    set ib_skillName[694] = "神圣之光"
    set ib_skillCustom[694] = 0
    set ib_skillList[695] = 'AIhw'
    set ib_skillName[695] = "治疗守卫"
    set ib_skillCustom[695] = 0
    set ib_skillList[696] = 'AIhx'
    set ib_skillName[696] = "具有医疗效果的物品"
    set ib_skillCustom[696] = 0
    set ib_skillList[697] = 'AIi1'
    set ib_skillName[697] = "能提高英雄属性的物品"
    set ib_skillCustom[697] = 0
    set ib_skillList[698] = 'AIi3'
    set ib_skillName[698] = "能提高英雄属性的物品"
    set ib_skillCustom[698] = 0
    set ib_skillList[699] = 'AIi4'
    set ib_skillName[699] = "能提高英雄属性的物品"
    set ib_skillCustom[699] = 0
    set ib_skillList[700] = 'AIi6'
    set ib_skillName[700] = "能提高英雄属性的物品"
    set ib_skillCustom[700] = 0
    set ib_skillList[701] = 'AIil'
    set ib_skillName[701] = "幻象物品"
    set ib_skillCustom[701] = 0
    set ib_skillList[702] = 'AIim'
    set ib_skillName[702] = "能提高智力的物品"
    set ib_skillCustom[702] = 0
    set ib_skillList[703] = 'AIir'
    set ib_skillName[703] = "能召唤冰冻幽灵的物品"
    set ib_skillCustom[703] = 0
    set ib_skillList[704] = 'AIl1'
    set ib_skillName[704] = "能增加生命值的物品"
    set ib_skillCustom[704] = 0
    set ib_skillList[705] = 'AIl2'
    set ib_skillName[705] = "能增加生命值的物品"
    set ib_skillCustom[705] = 0
    set ib_skillList[706] = 'AIlb'
    set ib_skillName[706] = "能带有闪电伤害的物品"
    set ib_skillCustom[706] = 0
    set ib_skillList[707] = 'AIlf'
    set ib_skillName[707] = "能增加生命值的物品"
    set ib_skillCustom[707] = 0
    set ib_skillList[708] = 'AIll'
    set ib_skillName[708] = "闪电之球(新的)"
    set ib_skillCustom[708] = 0
    set ib_skillList[709] = 'AIlm'
    set ib_skillName[709] = "能提高等级的物品"
    set ib_skillCustom[709] = 0
    set ib_skillList[710] = 'AIlp'
    set ib_skillName[710] = "带有净化效果的物品"
    set ib_skillCustom[710] = 0
    set ib_skillList[711] = 'AIls'
    set ib_skillName[711] = "闪电护盾"
    set ib_skillCustom[711] = 0
    set ib_skillList[712] = 'AIlu'
    set ib_skillName[712] = "木材堆"
    set ib_skillCustom[712] = 0
    set ib_skillList[713] = 'AIlx'
    set ib_skillName[713] = "近战攻击带有闪电伤害"
    set ib_skillCustom[713] = 0
    set ib_skillList[714] = 'AIlz'
    set ib_skillName[714] = "能增加生命值的物品"
    set ib_skillCustom[714] = 0
    set ib_skillList[715] = 'AIm1'
    set ib_skillName[715] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[715] = 0
    set ib_skillList[716] = 'AIm2'
    set ib_skillName[716] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[716] = 0
    set ib_skillList[717] = 'AIma'
    set ib_skillName[717] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[717] = 0
    set ib_skillList[718] = 'AImb'
    set ib_skillName[718] = "能增加魔法值的物品"
    set ib_skillCustom[718] = 0
    set ib_skillList[719] = 'AImh'
    set ib_skillName[719] = "能永久增加生命值的物品"
    set ib_skillCustom[719] = 0
endfunction
function IB_SkillFill9 takes nothing returns nothing
    set ib_skillList[720] = 'AImi'
    set ib_skillName[720] = "能增加生命值的物品"
    set ib_skillCustom[720] = 0
    set ib_skillList[721] = 'AIml'
    set ib_skillName[721] = "能增加生命值的物品"
    set ib_skillCustom[721] = 0
    set ib_skillList[722] = 'AImm'
    set ib_skillName[722] = "能增加魔法值的物品"
    set ib_skillCustom[722] = 0
    set ib_skillList[723] = 'AImo'
    set ib_skillName[723] = "怪兽诱捕守卫"
    set ib_skillCustom[723] = 0
    set ib_skillList[724] = 'AImr'
    set ib_skillName[724] = "能提高一定范围内所有单位魔法值的物品"
    set ib_skillCustom[724] = 0
    set ib_skillList[725] = 'AIms'
    set ib_skillName[725] = "能提高移动速度的物品"
    set ib_skillCustom[725] = 0
    set ib_skillList[726] = 'AImt'
    set ib_skillName[726] = "传送权杖"
    set ib_skillCustom[726] = 0
    set ib_skillList[727] = 'AImv'
    set ib_skillName[727] = "能增加魔法值的物品(75)"
    set ib_skillCustom[727] = 0
    set ib_skillList[728] = 'AImx'
    set ib_skillName[728] = "魔法免疫"
    set ib_skillCustom[728] = 0
    set ib_skillList[729] = 'AImz'
    set ib_skillName[729] = "能增加魔法值的物品(100)"
    set ib_skillCustom[729] = 0
    set ib_skillList[730] = 'AInd'
    set ib_skillName[730] = "鼓舞"
    set ib_skillCustom[730] = 0
    set ib_skillList[731] = 'AInm'
    set ib_skillName[731] = "能增加力量的物品"
    set ib_skillCustom[731] = 0
    set ib_skillList[732] = 'AInv'
    set ib_skillName[732] = "物品栏"
    set ib_skillCustom[732] = 0
    set ib_skillList[733] = 'AIob'
    set ib_skillName[733] = "带有霜冻攻击效果的物品"
    set ib_skillCustom[733] = 0
    set ib_skillList[734] = 'AIos'
    set ib_skillName[734] = "减速"
    set ib_skillCustom[734] = 0
    set ib_skillList[735] = 'AIp1'
    set ib_skillName[735] = "普通物品-回复效果"
    set ib_skillCustom[735] = 0
    set ib_skillList[736] = 'AIp2'
    set ib_skillName[736] = "普通物品-回复效果"
    set ib_skillCustom[736] = 0
    set ib_skillList[737] = 'AIp3'
    set ib_skillName[737] = "普通物品-回复效果"
    set ib_skillCustom[737] = 0
    set ib_skillList[738] = 'AIp4'
    set ib_skillName[738] = "普通物品-回复效果"
    set ib_skillCustom[738] = 0
    set ib_skillList[739] = 'AIp5'
    set ib_skillName[739] = "普通物品-回复效果"
    set ib_skillCustom[739] = 0
    set ib_skillList[740] = 'AIp6'
    set ib_skillName[740] = "普通物品-回复效果"
    set ib_skillCustom[740] = 0
    set ib_skillList[741] = 'AIpb'
    set ib_skillName[741] = "带有毒药效果的物品"
    set ib_skillCustom[741] = 0
    set ib_skillList[742] = 'AIpg'
    set ib_skillName[742] = "带有净化效果的物品"
    set ib_skillCustom[742] = 0
    set ib_skillList[743] = 'AIpl'
    set ib_skillName[743] = "小净化药水"
    set ib_skillCustom[743] = 0
    set ib_skillList[744] = 'AIpm'
    set ib_skillName[744] = "能置放地精地雷的物品"
    set ib_skillCustom[744] = 0
    set ib_skillList[745] = 'AIpr'
    set ib_skillName[745] = "净化药水"
    set ib_skillCustom[745] = 0
    set ib_skillList[746] = 'AIps'
    set ib_skillName[746] = "带有净化效果的物品"
    set ib_skillCustom[746] = 0
    set ib_skillList[747] = 'AIpv'
    set ib_skillName[747] = "吸血药水"
    set ib_skillCustom[747] = 0
    set ib_skillList[748] = 'AIpx'
    set ib_skillName[748] = "能永久增加生命值的物品"
    set ib_skillCustom[748] = 0
    set ib_skillList[749] = 'AIpz'
    set ib_skillName[749] = "企鹅怪兽"
    set ib_skillCustom[749] = 0
    set ib_skillList[750] = 'AIra'
    set ib_skillName[750] = "能提高一定范围内所有单位魔法值和生命值的物品"
    set ib_skillCustom[750] = 0
    set ib_skillList[751] = 'AIrb'
    set ib_skillName[751] = "重生"
    set ib_skillCustom[751] = 0
    set ib_skillList[752] = 'AIrc'
    set ib_skillName[752] = "具有重生效果的物品"
    set ib_skillCustom[752] = 0
    set ib_skillList[753] = 'AIrd'
    set ib_skillName[753] = "复活死尸(物品)"
    set ib_skillCustom[753] = 0
    set ib_skillList[754] = 'AIre'
    set ib_skillName[754] = "能进行医疗和增加魔法值的单位"
    set ib_skillCustom[754] = 0
    set ib_skillList[755] = 'AIri'
    set ib_skillName[755] = "随机物品"
    set ib_skillCustom[755] = 0
    set ib_skillList[756] = 'AIrl'
    set ib_skillName[756] = "医疗剂"
    set ib_skillCustom[756] = 0
    set ib_skillList[757] = 'AIrm'
    set ib_skillName[757] = "能增加魔法恢复速度的物品"
    set ib_skillCustom[757] = 0
    set ib_skillList[758] = 'AIrr'
    set ib_skillName[758] = "咆哮"
    set ib_skillCustom[758] = 0
    set ib_skillList[759] = 'AIrs'
    set ib_skillName[759] = "具有复活效果的物品"
    set ib_skillCustom[759] = 0
    set ib_skillList[760] = 'AIrt'
    set ib_skillName[760] = "召唤物品"
    set ib_skillCustom[760] = 0
    set ib_skillList[761] = 'AIrv'
    set ib_skillName[761] = "能显示整个地图的物品"
    set ib_skillCustom[761] = 0
    set ib_skillList[762] = 'AIrx'
    set ib_skillName[762] = "具有复活效果的物品"
    set ib_skillCustom[762] = 0
    set ib_skillList[763] = 'AIs1'
    set ib_skillName[763] = "能提高英雄属性的物品"
    set ib_skillCustom[763] = 0
    set ib_skillList[764] = 'AIs2'
    set ib_skillName[764] = "能提高进攻速度的物品"
    set ib_skillCustom[764] = 0
    set ib_skillList[765] = 'AIs3'
    set ib_skillName[765] = "能提高英雄属性的物品"
    set ib_skillCustom[765] = 0
    set ib_skillList[766] = 'AIs4'
    set ib_skillName[766] = "能提高英雄属性的物品"
    set ib_skillCustom[766] = 0
    set ib_skillList[767] = 'AIs6'
    set ib_skillName[767] = "能提高英雄属性的物品"
    set ib_skillCustom[767] = 0
    set ib_skillList[768] = 'AIsa'
    set ib_skillName[768] = "加速卷轴"
    set ib_skillCustom[768] = 0
    set ib_skillList[769] = 'AIsb'
    set ib_skillName[769] = "减速之球"
    set ib_skillCustom[769] = 0
    set ib_skillList[770] = 'AIse'
    set ib_skillName[770] = "物品沉默"
    set ib_skillCustom[770] = 0
    set ib_skillList[771] = 'AIsh'
    set ib_skillName[771] = "召唤巨魔猎头者"
    set ib_skillCustom[771] = 0
    set ib_skillList[772] = 'AIsi'
    set ib_skillName[772] = "能提高视野范围的物品"
    set ib_skillCustom[772] = 0
    set ib_skillList[773] = 'AIsl'
    set ib_skillName[773] = "恢复卷轴"
    set ib_skillCustom[773] = 0
    set ib_skillList[774] = 'AIsm'
    set ib_skillName[774] = "能增加力量的物品"
    set ib_skillCustom[774] = 0
    set ib_skillList[775] = 'AIso'
    set ib_skillName[775] = "能盗取单位灵魂的物品"
    set ib_skillCustom[775] = 0
    set ib_skillList[776] = 'AIsp'
    set ib_skillName[776] = "能暂时加快移动速度的物品"
    set ib_skillCustom[776] = 0
    set ib_skillList[777] = 'AIsr'
    set ib_skillName[777] = "魔法伤害减少"
    set ib_skillCustom[777] = 0
    set ib_skillList[778] = 'AIsw'
    set ib_skillName[778] = "岗哨守卫"
    set ib_skillCustom[778] = 0
    set ib_skillList[779] = 'AIsx'
    set ib_skillName[779] = "能提高攻击速度的物品"
    set ib_skillCustom[779] = 0
    set ib_skillList[780] = 'AIsz'
    set ib_skillName[780] = "慢性毒药"
    set ib_skillCustom[780] = 0
    set ib_skillList[781] = 'AIt6'
    set ib_skillName[781] = "增加攻击力的物品"
    set ib_skillCustom[781] = 0
    set ib_skillList[782] = 'AIt9'
    set ib_skillName[782] = "增加攻击力的物品"
    set ib_skillCustom[782] = 0
    set ib_skillList[783] = 'AIta'
    set ib_skillName[783] = "能探测一定区域的物品"
    set ib_skillCustom[783] = 0
    set ib_skillList[784] = 'AItb'
    set ib_skillName[784] = "尘土之影"
    set ib_skillCustom[784] = 0
    set ib_skillList[785] = 'AItc'
    set ib_skillName[785] = "增加攻击力的物品"
    set ib_skillCustom[785] = 0
    set ib_skillList[786] = 'AItf'
    set ib_skillName[786] = "增加攻击力的物品"
    set ib_skillCustom[786] = 0
    set ib_skillList[787] = 'AItg'
    set ib_skillName[787] = "增加攻击力的物品"
    set ib_skillCustom[787] = 0
    set ib_skillList[788] = 'AIth'
    set ib_skillName[788] = "增加攻击力的物品"
    set ib_skillCustom[788] = 0
    set ib_skillList[789] = 'AIti'
    set ib_skillName[789] = "增加攻击力的物品"
    set ib_skillCustom[789] = 0
    set ib_skillList[790] = 'AItj'
    set ib_skillName[790] = "增加攻击力的物品"
    set ib_skillCustom[790] = 0
    set ib_skillList[791] = 'AItk'
    set ib_skillName[791] = "增加攻击力的物品"
    set ib_skillCustom[791] = 0
    set ib_skillList[792] = 'AItl'
    set ib_skillName[792] = "增加攻击力的物品"
    set ib_skillCustom[792] = 0
    set ib_skillList[793] = 'AItm'
    set ib_skillName[793] = "能提高智力的物品"
    set ib_skillCustom[793] = 0
    set ib_skillList[794] = 'AItn'
    set ib_skillName[794] = "增加攻击力的物品"
    set ib_skillCustom[794] = 0
    set ib_skillList[795] = 'AItp'
    set ib_skillName[795] = "回城卷轴物品"
    set ib_skillCustom[795] = 0
    set ib_skillList[796] = 'AItx'
    set ib_skillName[796] = "增加攻击力的物品"
    set ib_skillCustom[796] = 0
    set ib_skillList[797] = 'AIuf'
    set ib_skillName[797] = "邪恶狂热"
    set ib_skillCustom[797] = 0
    set ib_skillList[798] = 'AIuv'
    set ib_skillName[798] = "夜视能力"
    set ib_skillCustom[798] = 0
    set ib_skillList[799] = 'AIuw'
    set ib_skillName[799] = "能召唤熊怪战士的物品"
    set ib_skillCustom[799] = 0
endfunction
function IB_SkillFill10 takes nothing returns nothing
    set ib_skillList[800] = 'AIv1'
    set ib_skillName[800] = "能让单位暂时隐身的物品"
    set ib_skillCustom[800] = 0
    set ib_skillList[801] = 'AIv2'
    set ib_skillName[801] = "能让单位暂时隐身的物品"
    set ib_skillCustom[801] = 0
    set ib_skillList[802] = 'AIva'
    set ib_skillName[802] = "能盗取生命值的物品"
    set ib_skillCustom[802] = 0
    set ib_skillList[803] = 'AIvi'
    set ib_skillName[803] = "能让单位暂时隐身的物品"
    set ib_skillCustom[803] = 0
    set ib_skillList[804] = 'AIvl'
    set ib_skillName[804] = "能让单位暂时无敌的物品"
    set ib_skillCustom[804] = 0
    set ib_skillList[805] = 'AIvu'
    set ib_skillName[805] = "能让单位暂时无敌的物品"
    set ib_skillCustom[805] = 0
    set ib_skillList[806] = 'AIwb'
    set ib_skillName[806] = "带有蛛网技能的物品"
    set ib_skillCustom[806] = 0
    set ib_skillList[807] = 'AIwm'
    set ib_skillName[807] = "水奴"
    set ib_skillCustom[807] = 0
    set ib_skillList[808] = 'AIx1'
    set ib_skillName[808] = "能提高英雄属性的物品"
    set ib_skillCustom[808] = 0
    set ib_skillList[809] = 'AIx2'
    set ib_skillName[809] = "能提高英雄属性的物品"
    set ib_skillCustom[809] = 0
    set ib_skillList[810] = 'AIx5'
    set ib_skillName[810] = "能提高英雄属性的物品"
    set ib_skillCustom[810] = 0
    set ib_skillList[811] = 'AIxk'
    set ib_skillName[811] = "狂暴愤怒"
    set ib_skillCustom[811] = 0
    set ib_skillList[812] = 'AIxm'
    set ib_skillName[812] = "能提高英雄三个属性的物品"
    set ib_skillCustom[812] = 0
    set ib_skillList[813] = 'AIxs'
    set ib_skillName[813] = "具有反魔法盾的物品"
    set ib_skillCustom[813] = 0
    set ib_skillList[814] = 'AIzb'
    set ib_skillName[814] = "带有冰冻攻击伤害的物品"
    set ib_skillCustom[814] = 0
    set ib_skillList[815] = 'ANab'
    set ib_skillName[815] = "酸性炸弹"
    set ib_skillCustom[815] = 0
    set ib_skillList[816] = 'ANak'
    set ib_skillName[816] = "刚毛飞射"
    set ib_skillCustom[816] = 0
    set ib_skillList[817] = 'ANav'
    set ib_skillName[817] = "天神下凡"
    set ib_skillCustom[817] = 0
    set ib_skillList[818] = 'ANb2'
    set ib_skillName[818] = "重击"
    set ib_skillCustom[818] = 0
    set ib_skillList[819] = 'ANba'
    set ib_skillName[819] = "黑暗之箭"
    set ib_skillCustom[819] = 0
    set ib_skillList[820] = 'ANbf'
    set ib_skillName[820] = "火焰呼吸"
    set ib_skillCustom[820] = 0
    set ib_skillList[821] = 'ANbh'
    set ib_skillName[821] = "重击"
    set ib_skillCustom[821] = 0
    set ib_skillList[822] = 'ANbl'
    set ib_skillName[822] = "闪烁"
    set ib_skillCustom[822] = 0
    set ib_skillList[823] = 'ANbr'
    set ib_skillName[823] = "战争咆哮"
    set ib_skillCustom[823] = 0
    set ib_skillList[824] = 'ANbs'
    set ib_skillName[824] = "黑暗之球"
    set ib_skillCustom[824] = 0
    set ib_skillList[825] = 'ANbu'
    set ib_skillName[825] = "建造(中立)"
    set ib_skillCustom[825] = 0
    set ib_skillList[826] = 'ANc1'
    set ib_skillName[826] = "火箭群"
    set ib_skillCustom[826] = 0
    set ib_skillList[827] = 'ANc2'
    set ib_skillName[827] = "火箭群"
    set ib_skillCustom[827] = 0
    set ib_skillList[828] = 'ANc3'
    set ib_skillName[828] = "火箭群"
    set ib_skillCustom[828] = 0
    set ib_skillList[829] = 'ANca'
    set ib_skillName[829] = "分裂攻击"
    set ib_skillCustom[829] = 0
    set ib_skillList[830] = 'ANcf'
    set ib_skillName[830] = "火焰呼吸"
    set ib_skillCustom[830] = 0
    set ib_skillList[831] = 'ANch'
    set ib_skillName[831] = "符咒"
    set ib_skillCustom[831] = 0
    set ib_skillList[832] = 'ANcl'
    set ib_skillName[832] = "通魔"
    set ib_skillCustom[832] = 0
    set ib_skillList[833] = 'ANcr'
    set ib_skillName[833] = "化学风暴"
    set ib_skillCustom[833] = 0
    set ib_skillList[834] = 'ANcs'
    set ib_skillName[834] = "火箭群"
    set ib_skillCustom[834] = 0
    set ib_skillList[835] = 'ANd1'
    set ib_skillName[835] = "粉碎"
    set ib_skillCustom[835] = 0
    set ib_skillList[836] = 'ANd2'
    set ib_skillName[836] = "粉碎"
    set ib_skillCustom[836] = 0
    set ib_skillList[837] = 'ANd3'
    set ib_skillName[837] = "粉碎"
    set ib_skillCustom[837] = 0
    set ib_skillList[838] = 'ANdb'
    set ib_skillName[838] = "醉拳"
    set ib_skillCustom[838] = 0
    set ib_skillList[839] = 'ANdc'
    set ib_skillName[839] = "黑暗转换"
    set ib_skillCustom[839] = 0
    set ib_skillList[840] = 'ANde'
    set ib_skillName[840] = "粉碎"
    set ib_skillCustom[840] = 0
    set ib_skillList[841] = 'ANdh'
    set ib_skillName[841] = "醉酒云雾"
    set ib_skillCustom[841] = 0
    set ib_skillList[842] = 'ANdo'
    set ib_skillName[842] = "末日审判"
    set ib_skillCustom[842] = 0
    set ib_skillList[843] = 'ANdp'
    set ib_skillName[843] = "黑暗之门"
    set ib_skillCustom[843] = 0
    set ib_skillList[844] = 'ANdr'
    set ib_skillName[844] = "生命汲取"
    set ib_skillCustom[844] = 0
    set ib_skillList[845] = 'ANef'
    set ib_skillName[845] = "\"火土风暴\""
    set ib_skillCustom[845] = 0
    set ib_skillList[846] = 'ANeg'
    set ib_skillName[846] = "工程升级"
    set ib_skillCustom[846] = 0
    set ib_skillList[847] = 'ANen'
    set ib_skillName[847] = "诱捕"
    set ib_skillCustom[847] = 0
    set ib_skillList[848] = 'ANf1'
    set ib_skillName[848] = "工厂"
    set ib_skillCustom[848] = 0
    set ib_skillList[849] = 'ANf2'
    set ib_skillName[849] = "工厂"
    set ib_skillCustom[849] = 0
    set ib_skillList[850] = 'ANf3'
    set ib_skillName[850] = "工厂"
    set ib_skillCustom[850] = 0
    set ib_skillList[851] = 'ANfa'
    set ib_skillName[851] = "霜冻之箭"
    set ib_skillCustom[851] = 0
    set ib_skillList[852] = 'ANfb'
    set ib_skillName[852] = "霹雳闪电"
    set ib_skillCustom[852] = 0
    set ib_skillList[853] = 'ANfd'
    set ib_skillName[853] = "死亡之指"
    set ib_skillCustom[853] = 0
    set ib_skillList[854] = 'ANfl'
    set ib_skillName[854] = "叉状闪电"
    set ib_skillCustom[854] = 0
    set ib_skillList[855] = 'ANfs'
    set ib_skillName[855] = "烈焰风暴"
    set ib_skillCustom[855] = 0
    set ib_skillList[856] = 'ANfy'
    set ib_skillName[856] = "工厂"
    set ib_skillCustom[856] = 0
    set ib_skillList[857] = 'ANg1'
    set ib_skillName[857] = "机器人地精"
    set ib_skillCustom[857] = 0
    set ib_skillList[858] = 'ANg2'
    set ib_skillName[858] = "机器人地精"
    set ib_skillCustom[858] = 0
    set ib_skillList[859] = 'ANg3'
    set ib_skillName[859] = "机器人地精"
    set ib_skillCustom[859] = 0
    set ib_skillList[860] = 'ANgl'
    set ib_skillName[860] = "用黄金交换木材"
    set ib_skillCustom[860] = 0
    set ib_skillList[861] = 'ANha'
    set ib_skillName[861] = "采集"
    set ib_skillCustom[861] = 0
    set ib_skillList[862] = 'ANhs'
    set ib_skillName[862] = "医疗气雾"
    set ib_skillCustom[862] = 0
    set ib_skillList[863] = 'ANht'
    set ib_skillName[863] = "恐怖嚎叫"
    set ib_skillCustom[863] = 0
    set ib_skillList[864] = 'ANhw'
    set ib_skillName[864] = "医疗波"
    set ib_skillCustom[864] = 0
    set ib_skillList[865] = 'ANhx'
    set ib_skillName[865] = "妖术"
    set ib_skillCustom[865] = 0
    set ib_skillList[866] = 'ANia'
    set ib_skillName[866] = "燃灰"
    set ib_skillCustom[866] = 0
    set ib_skillList[867] = 'ANic'
    set ib_skillName[867] = "燃灰"
    set ib_skillCustom[867] = 0
    set ib_skillList[868] = 'ANin'
    set ib_skillName[868] = "地狱火"
    set ib_skillCustom[868] = 0
    set ib_skillList[869] = 'ANlg'
    set ib_skillName[869] = "用木材交换黄金"
    set ib_skillCustom[869] = 0
    set ib_skillList[870] = 'ANlm'
    set ib_skillName[870] = "召唤炎魔"
    set ib_skillCustom[870] = 0
    set ib_skillList[871] = 'ANmo'
    set ib_skillName[871] = "季风"
    set ib_skillCustom[871] = 0
    set ib_skillList[872] = 'ANmr'
    set ib_skillName[872] = "心灵腐烂"
    set ib_skillCustom[872] = 0
    set ib_skillList[873] = 'ANms'
    set ib_skillName[873] = "魔法护盾"
    set ib_skillCustom[873] = 0
    set ib_skillList[874] = 'ANpa'
    set ib_skillName[874] = "寄生虫"
    set ib_skillCustom[874] = 0
    set ib_skillList[875] = 'ANpi'
    set ib_skillName[875] = "永久的献祭"
    set ib_skillCustom[875] = 0
    set ib_skillList[876] = 'ANpr'
    set ib_skillName[876] = "保存权杖"
    set ib_skillCustom[876] = 0
    set ib_skillList[877] = 'ANr2'
    set ib_skillName[877] = "重生"
    set ib_skillCustom[877] = 0
    set ib_skillList[878] = 'ANr3'
    set ib_skillName[878] = "混乱之雨"
    set ib_skillCustom[878] = 0
    set ib_skillList[879] = 'ANrc'
    set ib_skillName[879] = "混乱之雨"
    set ib_skillCustom[879] = 0
endfunction
function IB_SkillFill11 takes nothing returns nothing
    set ib_skillList[880] = 'ANre'
    set ib_skillName[880] = "魔法恢复光环"
    set ib_skillCustom[880] = 0
    set ib_skillList[881] = 'ANrf'
    set ib_skillName[881] = "火焰雨"
    set ib_skillCustom[881] = 0
    set ib_skillList[882] = 'ANrg'
    set ib_skillName[882] = "机器人地精"
    set ib_skillCustom[882] = 0
    set ib_skillList[883] = 'ANrl'
    set ib_skillName[883] = "生命值恢复速度"
    set ib_skillCustom[883] = 0
    set ib_skillList[884] = 'ANrn'
    set ib_skillName[884] = "重生"
    set ib_skillCustom[884] = 0
    set ib_skillList[885] = 'ANs1'
    set ib_skillName[885] = "口袋工厂"
    set ib_skillCustom[885] = 0
    set ib_skillList[886] = 'ANs2'
    set ib_skillName[886] = "口袋工厂"
    set ib_skillCustom[886] = 0
    set ib_skillList[887] = 'ANs3'
    set ib_skillName[887] = "口袋工厂"
    set ib_skillCustom[887] = 0
    set ib_skillList[888] = 'ANsa'
    set ib_skillName[888] = "避难权杖"
    set ib_skillCustom[888] = 0
    set ib_skillList[889] = 'ANsb'
    set ib_skillName[889] = "风暴之锤"
    set ib_skillCustom[889] = 0
    set ib_skillList[890] = 'ANse'
    set ib_skillName[890] = "魔法护盾"
    set ib_skillCustom[890] = 0
    set ib_skillList[891] = 'ANsg'
    set ib_skillName[891] = "召唤熊"
    set ib_skillCustom[891] = 0
    set ib_skillList[892] = 'ANsh'
    set ib_skillName[892] = "震荡波"
    set ib_skillCustom[892] = 0
    set ib_skillList[893] = 'ANsi'
    set ib_skillName[893] = "沉默魔法"
    set ib_skillCustom[893] = 0
    set ib_skillList[894] = 'ANsl'
    set ib_skillName[894] = "灵魂保存"
    set ib_skillCustom[894] = 0
    set ib_skillList[895] = 'ANso'
    set ib_skillName[895] = "灵魂燃烧"
    set ib_skillCustom[895] = 0
    set ib_skillList[896] = 'ANsp'
    set ib_skillName[896] = "间谍"
    set ib_skillCustom[896] = 0
    set ib_skillList[897] = 'ANsq'
    set ib_skillName[897] = "召唤豪猪"
    set ib_skillCustom[897] = 0
    set ib_skillList[898] = 'ANss'
    set ib_skillName[898] = "魔法护盾"
    set ib_skillCustom[898] = 0
    set ib_skillList[899] = 'ANst'
    set ib_skillName[899] = "惊吓"
    set ib_skillCustom[899] = 0
    set ib_skillList[900] = 'ANsw'
    set ib_skillName[900] = "召唤战鹰"
    set ib_skillCustom[900] = 0
    set ib_skillList[901] = 'ANsy'
    set ib_skillName[901] = "口袋工厂"
    set ib_skillCustom[901] = 0
    set ib_skillList[902] = 'ANt2'
    set ib_skillName[902] = "尖刺外壳"
    set ib_skillCustom[902] = 0
    set ib_skillList[903] = 'ANta'
    set ib_skillName[903] = "嘲讽"
    set ib_skillCustom[903] = 0
    set ib_skillList[904] = 'ANth'
    set ib_skillName[904] = "尖刺外壳"
    set ib_skillCustom[904] = 0
    set ib_skillList[905] = 'ANtm'
    set ib_skillName[905] = "点金术"
    set ib_skillCustom[905] = 0
    set ib_skillList[906] = 'ANto'
    set ib_skillName[906] = "龙卷风"
    set ib_skillCustom[906] = 0
    set ib_skillList[907] = 'ANtr'
    set ib_skillName[907] = "真实视域"
    set ib_skillCustom[907] = 0
    set ib_skillList[908] = 'ANvc'
    set ib_skillName[908] = "火山爆发"
    set ib_skillCustom[908] = 0
    set ib_skillList[909] = 'ANwk'
    set ib_skillName[909] = "疾风步"
    set ib_skillCustom[909] = 0
    set ib_skillList[910] = 'ANwm'
    set ib_skillName[910] = "水奴"
    set ib_skillCustom[910] = 0
    set ib_skillList[911] = 'AOac'
    set ib_skillName[911] = "命令光环"
    set ib_skillCustom[911] = 0
    set ib_skillList[912] = 'AOae'
    set ib_skillName[912] = "耐久光环"
    set ib_skillCustom[912] = 0
    set ib_skillList[913] = 'AObu'
    set ib_skillName[913] = "建造(兽族)"
    set ib_skillCustom[913] = 0
    set ib_skillList[914] = 'AOcl'
    set ib_skillName[914] = "水遁.水牢之术"
    set ib_skillCustom[914] = 0
    set ib_skillList[915] = 'AOcr'
    set ib_skillName[915] = "致命一击"
    set ib_skillCustom[915] = 0
    set ib_skillList[916] = 'AOeq'
    set ib_skillName[916] = "地震"
    set ib_skillCustom[916] = 0
    set ib_skillList[917] = 'AOfs'
    set ib_skillName[917] = "透视"
    set ib_skillCustom[917] = 0
    set ib_skillList[918] = 'AOhw'
    set ib_skillName[918] = "医疗波"
    set ib_skillCustom[918] = 0
    set ib_skillList[919] = 'AOhx'
    set ib_skillName[919] = "妖术"
    set ib_skillCustom[919] = 0
    set ib_skillList[920] = 'AOls'
    set ib_skillName[920] = "巫毒幽魂"
    set ib_skillCustom[920] = 0
    set ib_skillList[921] = 'AOmi'
    set ib_skillName[921] = "镜像"
    set ib_skillCustom[921] = 0
    set ib_skillList[922] = 'AOr2'
    set ib_skillName[922] = "耐久光环"
    set ib_skillCustom[922] = 0
    set ib_skillList[923] = 'AOr3'
    set ib_skillName[923] = "重生"
    set ib_skillCustom[923] = 0
    set ib_skillList[924] = 'AOre'
    set ib_skillName[924] = "重生"
    set ib_skillCustom[924] = 0
    set ib_skillList[925] = 'AOs2'
    set ib_skillName[925] = "震荡波"
    set ib_skillCustom[925] = 0
    set ib_skillList[926] = 'AOsf'
    set ib_skillName[926] = "野兽幽魂"
    set ib_skillCustom[926] = 0
    set ib_skillList[927] = 'AOsh'
    set ib_skillName[927] = "通灵术·斩斩舞"
    set ib_skillCustom[927] = 0
    set ib_skillList[928] = 'AOsw'
    set ib_skillName[928] = "毒蛇守卫"
    set ib_skillCustom[928] = 0
    set ib_skillList[929] = 'AOvd'
    set ib_skillName[929] = "巫毒"
    set ib_skillCustom[929] = 0
    set ib_skillList[930] = 'AOw2'
    set ib_skillName[930] = "风遁.大镰鼬"
    set ib_skillCustom[930] = 0
    set ib_skillList[931] = 'AOwk'
    set ib_skillName[931] = "疾步风"
    set ib_skillCustom[931] = 0
    set ib_skillList[932] = 'AOws'
    set ib_skillName[932] = "柔拳法.守护八卦六十四掌"
    set ib_skillCustom[932] = 0
    set ib_skillList[933] = 'AOww'
    set ib_skillName[933] = "剑刃风暴"
    set ib_skillCustom[933] = 0
    set ib_skillList[934] = 'APdi'
    set ib_skillName[934] = "力量上升驱散"
    set ib_skillCustom[934] = 0
    set ib_skillList[935] = 'APh1'
    set ib_skillName[935] = "力量上升治疗区域减小"
    set ib_skillCustom[935] = 0
    set ib_skillList[936] = 'APh2'
    set ib_skillName[936] = "力量上升治疗区域"
    set ib_skillCustom[936] = 0
    set ib_skillList[937] = 'APh3'
    set ib_skillName[937] = "力量上升治疗区域增强"
    set ib_skillCustom[937] = 0
    set ib_skillList[938] = 'APmg'
    set ib_skillName[938] = "神秘区域魔法恢复增强"
    set ib_skillCustom[938] = 0
    set ib_skillList[939] = 'APmr'
    set ib_skillName[939] = "神秘区域魔法恢复"
    set ib_skillCustom[939] = 0
    set ib_skillList[940] = 'APra'
    set ib_skillName[940] = "神秘区域生命/魔法恢复"
    set ib_skillCustom[940] = 0
    set ib_skillList[941] = 'APrl'
    set ib_skillName[941] = "小型复活神符"
    set ib_skillCustom[941] = 0
    set ib_skillList[942] = 'APrr'
    set ib_skillName[942] = "大型复活神符"
    set ib_skillCustom[942] = 0
    set ib_skillList[943] = 'APsa'
    set ib_skillName[943] = "速度神符"
    set ib_skillCustom[943] = 0
    set ib_skillList[944] = 'APwt'
    set ib_skillName[944] = "岗哨神符"
    set ib_skillCustom[944] = 0
    set ib_skillList[945] = 'ARal'
    set ib_skillName[945] = "集结"
    set ib_skillCustom[945] = 0
    set ib_skillList[946] = 'AUan'
    set ib_skillName[946] = "操纵死尸"
    set ib_skillCustom[946] = 0
    set ib_skillList[947] = 'AUau'
    set ib_skillName[947] = "邪恶光环"
    set ib_skillCustom[947] = 0
    set ib_skillList[948] = 'AUav'
    set ib_skillName[948] = "吸血光环"
    set ib_skillCustom[948] = 0
    set ib_skillList[949] = 'AUbu'
    set ib_skillName[949] = "建造(不死族)"
    set ib_skillCustom[949] = 0
    set ib_skillList[950] = 'AUcb'
    set ib_skillName[950] = "腐尸甲虫"
    set ib_skillCustom[950] = 0
    set ib_skillList[951] = 'AUcs'
    set ib_skillName[951] = "风遁·风杀阵"
    set ib_skillCustom[951] = 0
    set ib_skillList[952] = 'AUdc'
    set ib_skillName[952] = "死亡缠绕"
    set ib_skillCustom[952] = 0
    set ib_skillList[953] = 'AUdd'
    set ib_skillName[953] = "死亡凋零"
    set ib_skillCustom[953] = 0
    set ib_skillList[954] = 'AUdp'
    set ib_skillName[954] = "死亡契约"
    set ib_skillCustom[954] = 0
    set ib_skillList[955] = 'AUdr'
    set ib_skillName[955] = "黑暗仪式"
    set ib_skillCustom[955] = 0
    set ib_skillList[956] = 'AUds'
    set ib_skillName[956] = "黑暗召唤"
    set ib_skillCustom[956] = 0
    set ib_skillList[957] = 'AUfa'
    set ib_skillName[957] = "霜冻护甲"
    set ib_skillCustom[957] = 0
    set ib_skillList[958] = 'AUfn'
    set ib_skillName[958] = "风遁·龙卷飓风"
    set ib_skillCustom[958] = 0
    set ib_skillList[959] = 'AUfu'
    set ib_skillName[959] = "霜冻护甲"
    set ib_skillCustom[959] = 0
endfunction
function IB_SkillFill12 takes nothing returns nothing
    set ib_skillList[960] = 'AUim'
    set ib_skillName[960] = "穿刺"
    set ib_skillCustom[960] = 0
    set ib_skillList[961] = 'AUin'
    set ib_skillName[961] = "地狱火"
    set ib_skillCustom[961] = 0
    set ib_skillList[962] = 'AUls'
    set ib_skillName[962] = "蝗虫群"
    set ib_skillCustom[962] = 0
    set ib_skillList[963] = 'AUmd'
    set ib_skillName[963] = "黑暗召唤(马哥尼斯)"
    set ib_skillCustom[963] = 0
    set ib_skillList[964] = 'AUsl'
    set ib_skillName[964] = "睡眠"
    set ib_skillCustom[964] = 0
    set ib_skillList[965] = 'AUts'
    set ib_skillName[965] = "尖刺外壳"
    set ib_skillCustom[965] = 0
    set ib_skillList[966] = 'Aabr'
    set ib_skillName[966] = "荒芜光环"
    set ib_skillCustom[966] = 0
    set ib_skillList[967] = 'Aabs'
    set ib_skillName[967] = "吸收魔法"
    set ib_skillCustom[967] = 0
    set ib_skillList[968] = 'Aadm'
    set ib_skillName[968] = "驱逐魔法"
    set ib_skillCustom[968] = 0
    set ib_skillList[969] = 'Aaha'
    set ib_skillName[969] = "采集"
    set ib_skillCustom[969] = 0
    set ib_skillList[970] = 'Aakb'
    set ib_skillName[970] = "战鼓"
    set ib_skillCustom[970] = 0
    set ib_skillList[971] = 'Aall'
    set ib_skillName[971] = "共享商店，联盟建筑物"
    set ib_skillCustom[971] = 0
    set ib_skillList[972] = 'Aalr'
    set ib_skillName[972] = "警报"
    set ib_skillCustom[972] = 0
    set ib_skillList[973] = 'Aam2'
    set ib_skillName[973] = "反魔法外壳"
    set ib_skillCustom[973] = 0
    set ib_skillList[974] = 'Aami'
    set ib_skillName[974] = "具有反魔法盾的物品"
    set ib_skillCustom[974] = 0
    set ib_skillList[975] = 'Aamk'
    set ib_skillName[975] = "属性附加"
    set ib_skillCustom[975] = 0
    set ib_skillList[976] = 'Aams'
    set ib_skillName[976] = "反魔法外壳"
    set ib_skillCustom[976] = 0
    set ib_skillList[977] = 'Aap1'
    set ib_skillName[977] = "疾病云雾"
    set ib_skillCustom[977] = 0
    set ib_skillList[978] = 'Aap2'
    set ib_skillName[978] = "疾病云雾"
    set ib_skillCustom[978] = 0
    set ib_skillList[979] = 'Aap3'
    set ib_skillName[979] = "疾病云雾"
    set ib_skillCustom[979] = 0
    set ib_skillList[980] = 'Aap4'
    set ib_skillName[980] = "疾病云雾"
    set ib_skillCustom[980] = 0
    set ib_skillList[981] = 'Aapl'
    set ib_skillName[981] = "疾病云雾"
    set ib_skillCustom[981] = 0
    set ib_skillList[982] = 'Aarm'
    set ib_skillName[982] = "魔法恢复光环"
    set ib_skillCustom[982] = 0
    set ib_skillList[983] = 'Aasl'
    set ib_skillName[983] = "减速光环"
    set ib_skillCustom[983] = 0
    set ib_skillList[984] = 'Aast'
    set ib_skillName[984] = "先祖幽灵"
    set ib_skillCustom[984] = 0
    set ib_skillList[985] = 'Aatk'
    set ib_skillName[985] = "攻击"
    set ib_skillCustom[985] = 0
    set ib_skillList[986] = 'Aave'
    set ib_skillName[986] = "破坏者形态"
    set ib_skillCustom[986] = 0
    set ib_skillList[987] = 'Aawa'
    set ib_skillName[987] = "立刻复活英雄"
    set ib_skillCustom[987] = 0
    set ib_skillList[988] = 'Abdl'
    set ib_skillName[988] = "大型荒芜之地驱散"
    set ib_skillCustom[988] = 0
    set ib_skillList[989] = 'Abds'
    set ib_skillName[989] = "小型荒芜之地驱散"
    set ib_skillCustom[989] = 0
    set ib_skillList[990] = 'Abdt'
    set ib_skillName[990] = "钻地探测"
    set ib_skillCustom[990] = 0
    set ib_skillList[991] = 'Abgl'
    set ib_skillName[991] = "大型荒芜之地蔓延"
    set ib_skillCustom[991] = 0
    set ib_skillList[992] = 'Abgm'
    set ib_skillName[992] = "闹鬼金矿技能"
    set ib_skillCustom[992] = 0
    set ib_skillList[993] = 'Abgs'
    set ib_skillName[993] = "小型荒芜之地蔓延"
    set ib_skillCustom[993] = 0
    set ib_skillList[994] = 'Abli'
    set ib_skillName[994] = "荒芜之地"
    set ib_skillCustom[994] = 0
    set ib_skillList[995] = 'Ablo'
    set ib_skillName[995] = "嗜血术"
    set ib_skillCustom[995] = 0
    set ib_skillList[996] = 'Ablp'
    set ib_skillName[996] = "荒芜之地的置放"
    set ib_skillCustom[996] = 0
    set ib_skillList[997] = 'Abof'
    set ib_skillName[997] = "燃烧之油"
    set ib_skillCustom[997] = 0
    set ib_skillList[998] = 'Abrf'
    set ib_skillName[998] = "变熊"
    set ib_skillCustom[998] = 0
    set ib_skillList[999] = 'Absk'
    set ib_skillName[999] = "狂战士"
    set ib_skillCustom[999] = 0
    set ib_skillList[1000] = 'Abtl'
    set ib_skillName[1000] = "战斗位置"
    set ib_skillCustom[1000] = 0
    set ib_skillList[1001] = 'Abu2'
    set ib_skillName[1001] = "钻地"
    set ib_skillCustom[1001] = 0
    set ib_skillList[1002] = 'Abu3'
    set ib_skillName[1002] = "钻地"
    set ib_skillCustom[1002] = 0
    set ib_skillList[1003] = 'Abu5'
    set ib_skillName[1003] = "钻地"
    set ib_skillCustom[1003] = 0
    set ib_skillList[1004] = 'Abun'
    set ib_skillName[1004] = "货物保持 (兽族地洞)"
    set ib_skillCustom[1004] = 0
    set ib_skillList[1005] = 'Abur'
    set ib_skillName[1005] = "钻地"
    set ib_skillCustom[1005] = 0
    set ib_skillList[1006] = 'Acan'
    set ib_skillName[1006] = "吞食尸体"
    set ib_skillCustom[1006] = 0
    set ib_skillList[1007] = 'Acar'
    set ib_skillName[1007] = "货物保持"
    set ib_skillCustom[1007] = 0
    set ib_skillList[1008] = 'Acdb'
    set ib_skillName[1008] = "醉拳"
    set ib_skillCustom[1008] = 0
    set ib_skillList[1009] = 'Acdh'
    set ib_skillName[1009] = "醉酒云雾"
    set ib_skillCustom[1009] = 0
    set ib_skillList[1010] = 'Acef'
    set ib_skillName[1010] = "\"火土风暴\""
    set ib_skillCustom[1010] = 0
    set ib_skillList[1011] = 'Acha'
    set ib_skillName[1011] = "混乱的"
    set ib_skillCustom[1011] = 0
    set ib_skillList[1012] = 'Achd'
    set ib_skillName[1012] = "运输船保持原位"
    set ib_skillCustom[1012] = 0
    set ib_skillList[1013] = 'Ache'
    set ib_skillName[1013] = "瓦解光线"
    set ib_skillCustom[1013] = 0
    set ib_skillList[1014] = 'Achl'
    set ib_skillName[1014] = "装载"
    set ib_skillCustom[1014] = 0
    set ib_skillList[1015] = 'Acht'
    set ib_skillName[1015] = "恐怖嚎叫"
    set ib_skillCustom[1015] = 0
    set ib_skillList[1016] = 'Aclf'
    set ib_skillName[1016] = "乌云技能"
    set ib_skillCustom[1016] = 0
    set ib_skillList[1017] = 'Acmg'
    set ib_skillName[1017] = "控制魔法"
    set ib_skillCustom[1017] = 0
    set ib_skillList[1018] = 'Acn2'
    set ib_skillName[1018] = "吞食尸体"
    set ib_skillCustom[1018] = 0
    set ib_skillList[1019] = 'Acny'
    set ib_skillName[1019] = "飓风"
    set ib_skillCustom[1019] = 0
    set ib_skillList[1020] = 'Aco2'
    set ib_skillName[1020] = "骑乘角鹰兽"
    set ib_skillCustom[1020] = 0
    set ib_skillList[1021] = 'Aco3'
    set ib_skillName[1021] = "搭载弓箭手"
    set ib_skillCustom[1021] = 0
    set ib_skillList[1022] = 'Acoa'
    set ib_skillName[1022] = "骑乘角鹰兽"
    set ib_skillCustom[1022] = 0
    set ib_skillList[1023] = 'Acoh'
    set ib_skillName[1023] = "搭载弓箭手"
    set ib_skillCustom[1023] = 0
    set ib_skillList[1024] = 'Acor'
    set ib_skillName[1024] = "腐蚀喷吐"
    set ib_skillCustom[1024] = 0
    set ib_skillList[1025] = 'Acpf'
    set ib_skillName[1025] = "灵肉形态"
    set ib_skillCustom[1025] = 0
    set ib_skillList[1026] = 'Acri'
    set ib_skillName[1026] = "残废"
    set ib_skillCustom[1026] = 0
    set ib_skillList[1027] = 'Acrs'
    set ib_skillName[1027] = "诅咒"
    set ib_skillCustom[1027] = 0
    set ib_skillList[1028] = 'Acyc'
    set ib_skillName[1028] = "飓风"
    set ib_skillCustom[1028] = 0
    set ib_skillList[1029] = 'Adch'
    set ib_skillName[1029] = "消魔"
    set ib_skillCustom[1029] = 0
    set ib_skillList[1030] = 'Adcn'
    set ib_skillName[1030] = "消魔"
    set ib_skillCustom[1030] = 0
    set ib_skillList[1031] = 'Adda'
    set ib_skillName[1031] = "范围性攻击伤害"
    set ib_skillCustom[1031] = 0
    set ib_skillList[1032] = 'Adec'
    set ib_skillName[1032] = "卸载"
    set ib_skillCustom[1032] = 0
    set ib_skillList[1033] = 'Adef'
    set ib_skillName[1033] = "防御"
    set ib_skillCustom[1033] = 0
    set ib_skillList[1034] = 'Adet'
    set ib_skillName[1034] = "探测者"
    set ib_skillCustom[1034] = 0
    set ib_skillList[1035] = 'Adev'
    set ib_skillName[1035] = "吞噬"
    set ib_skillCustom[1035] = 0
    set ib_skillList[1036] = 'Adis'
    set ib_skillName[1036] = "驱逐魔法"
    set ib_skillCustom[1036] = 0
    set ib_skillList[1037] = 'Adri'
    set ib_skillName[1037] = "立刻卸载"
    set ib_skillCustom[1037] = 0
    set ib_skillList[1038] = 'Adro'
    set ib_skillName[1038] = "卸载"
    set ib_skillCustom[1038] = 0
    set ib_skillList[1039] = 'Adsm'
    set ib_skillName[1039] = "驱逐魔法"
    set ib_skillCustom[1039] = 0
endfunction
function IB_SkillFill13 takes nothing returns nothing
    set ib_skillList[1040] = 'Adt1'
    set ib_skillName[1040] = "探测者"
    set ib_skillCustom[1040] = 0
    set ib_skillList[1041] = 'Adta'
    set ib_skillName[1041] = "显示"
    set ib_skillCustom[1041] = 0
    set ib_skillList[1042] = 'Adtg'
    set ib_skillName[1042] = "真实视域"
    set ib_skillCustom[1042] = 0
    set ib_skillList[1043] = 'Adtn'
    set ib_skillName[1043] = "爆炸"
    set ib_skillCustom[1043] = 0
    set ib_skillList[1044] = 'Adts'
    set ib_skillName[1044] = "魔法岗哨"
    set ib_skillCustom[1044] = 0
    set ib_skillList[1045] = 'Advc'
    set ib_skillName[1045] = "吞噬货物"
    set ib_skillCustom[1045] = 0
    set ib_skillList[1046] = 'Advm'
    set ib_skillName[1046] = "吞噬魔法"
    set ib_skillCustom[1046] = 0
    set ib_skillList[1047] = 'Aeat'
    set ib_skillName[1047] = "吞食树木"
    set ib_skillCustom[1047] = 0
    set ib_skillList[1048] = 'Aegm'
    set ib_skillName[1048] = "缠绕金矿技能"
    set ib_skillCustom[1048] = 0
    set ib_skillList[1049] = 'Aegr'
    set ib_skillName[1049] = "艾鲁尼之优雅"
    set ib_skillCustom[1049] = 0
    set ib_skillList[1050] = 'Aenc'
    set ib_skillName[1050] = "装载"
    set ib_skillCustom[1050] = 0
    set ib_skillList[1051] = 'Aenr'
    set ib_skillName[1051] = "纠缠根须"
    set ib_skillCustom[1051] = 0
    set ib_skillList[1052] = 'Aens'
    set ib_skillName[1052] = "诱捕"
    set ib_skillCustom[1052] = 0
    set ib_skillList[1053] = 'Aent'
    set ib_skillName[1053] = "缠绕金矿"
    set ib_skillCustom[1053] = 0
    set ib_skillList[1054] = 'Aenw'
    set ib_skillName[1054] = "纠缠根须"
    set ib_skillCustom[1054] = 0
    set ib_skillList[1055] = 'Aesn'
    set ib_skillName[1055] = "哨兵"
    set ib_skillCustom[1055] = 0
    set ib_skillList[1056] = 'Aesr'
    set ib_skillName[1056] = "哨兵"
    set ib_skillCustom[1056] = 0
    set ib_skillList[1057] = 'Aetf'
    set ib_skillName[1057] = "虚无形态"
    set ib_skillCustom[1057] = 0
    set ib_skillList[1058] = 'Aeth'
    set ib_skillName[1058] = "幽灵"
    set ib_skillCustom[1058] = 0
    set ib_skillList[1059] = 'Aetl'
    set ib_skillName[1059] = "虚无状态"
    set ib_skillCustom[1059] = 0
    set ib_skillList[1060] = 'Aexh'
    set ib_skillName[1060] = "挖掘尸体"
    set ib_skillCustom[1060] = 0
    set ib_skillList[1061] = 'Aeye'
    set ib_skillName[1061] = "岗哨守卫"
    set ib_skillCustom[1061] = 0
    set ib_skillList[1062] = 'Afa2'
    set ib_skillName[1062] = "精灵之火"
    set ib_skillCustom[1062] = 0
    set ib_skillList[1063] = 'Afae'
    set ib_skillName[1063] = "精灵之火"
    set ib_skillCustom[1063] = 0
    set ib_skillList[1064] = 'Afak'
    set ib_skillName[1064] = "毁灭之球"
    set ib_skillCustom[1064] = 0
    set ib_skillList[1065] = 'Afbb'
    set ib_skillName[1065] = "反馈"
    set ib_skillCustom[1065] = 0
    set ib_skillList[1066] = 'Afbk'
    set ib_skillName[1066] = "魔法回应"
    set ib_skillCustom[1066] = 0
    set ib_skillList[1067] = 'Afbt'
    set ib_skillName[1067] = "魔法回应"
    set ib_skillCustom[1067] = 0
    set ib_skillList[1068] = 'Afih'
    set ib_skillName[1068] = "着火(人族)"
    set ib_skillCustom[1068] = 0
    set ib_skillList[1069] = 'Afin'
    set ib_skillName[1069] = "着火(暗夜精灵)"
    set ib_skillCustom[1069] = 0
    set ib_skillList[1070] = 'Afio'
    set ib_skillName[1070] = "着火(兽族)"
    set ib_skillCustom[1070] = 0
    set ib_skillList[1071] = 'Afir'
    set ib_skillName[1071] = "着火"
    set ib_skillCustom[1071] = 0
    set ib_skillList[1072] = 'Afiu'
    set ib_skillName[1072] = "着火(不死族)"
    set ib_skillCustom[1072] = 0
    set ib_skillList[1073] = 'Afla'
    set ib_skillName[1073] = "照明弹"
    set ib_skillCustom[1073] = 0
    set ib_skillList[1074] = 'Aflk'
    set ib_skillName[1074] = "高射炮火"
    set ib_skillCustom[1074] = 0
    set ib_skillList[1075] = 'Afod'
    set ib_skillName[1075] = "死亡之指"
    set ib_skillCustom[1075] = 0
    set ib_skillList[1076] = 'Afr2'
    set ib_skillName[1076] = "霜冻攻击"
    set ib_skillCustom[1076] = 0
    set ib_skillList[1077] = 'Afra'
    set ib_skillName[1077] = "霜之攻击"
    set ib_skillCustom[1077] = 0
    set ib_skillList[1078] = 'Afrb'
    set ib_skillName[1078] = "霜冻呼吸"
    set ib_skillCustom[1078] = 0
    set ib_skillList[1079] = 'Afrz'
    set ib_skillName[1079] = "冰冻喷吐"
    set ib_skillCustom[1079] = 0
    set ib_skillList[1080] = 'Afsh'
    set ib_skillName[1080] = "碎片攻击"
    set ib_skillCustom[1080] = 0
    set ib_skillList[1081] = 'Afzy'
    set ib_skillName[1081] = "狂热"
    set ib_skillCustom[1081] = 0
    set ib_skillList[1082] = 'Agho'
    set ib_skillName[1082] = "幽灵"
    set ib_skillCustom[1082] = 0
    set ib_skillList[1083] = 'Agld'
    set ib_skillName[1083] = "金矿能力"
    set ib_skillCustom[1083] = 0
    set ib_skillList[1084] = 'Agra'
    set ib_skillName[1084] = "战棍"
    set ib_skillCustom[1084] = 0
    set ib_skillList[1085] = 'Agyb'
    set ib_skillName[1085] = "飞行机器炸弹"
    set ib_skillCustom[1085] = 0
    set ib_skillList[1086] = 'Agyd'
    set ib_skillName[1086] = "创建尸体"
    set ib_skillCustom[1086] = 0
    set ib_skillList[1087] = 'Agyv'
    set ib_skillName[1087] = "真实视域"
    set ib_skillCustom[1087] = 0
    set ib_skillList[1088] = 'Ahar'
    set ib_skillName[1088] = "采集"
    set ib_skillCustom[1088] = 0
    set ib_skillList[1089] = 'Ahea'
    set ib_skillName[1089] = "医疗"
    set ib_skillCustom[1089] = 0
    set ib_skillList[1090] = 'Ahid'
    set ib_skillName[1090] = "影遁"
    set ib_skillCustom[1090] = 0
    set ib_skillList[1091] = 'Ahnl'
    set ib_skillName[1091] = "召唤仪式"
    set ib_skillCustom[1091] = 0
    set ib_skillList[1092] = 'Ahr2'
    set ib_skillName[1092] = "采集"
    set ib_skillCustom[1092] = 0
    set ib_skillList[1093] = 'Ahr3'
    set ib_skillName[1093] = "采集"
    set ib_skillCustom[1093] = 0
    set ib_skillList[1094] = 'Ahrl'
    set ib_skillName[1094] = "采集"
    set ib_skillCustom[1094] = 0
    set ib_skillList[1095] = 'Ahrp'
    set ib_skillName[1095] = "修理"
    set ib_skillCustom[1095] = 0
    set ib_skillList[1096] = 'Ahwd'
    set ib_skillName[1096] = "治疗守卫"
    set ib_skillCustom[1096] = 0
    set ib_skillList[1097] = 'Aien'
    set ib_skillName[1097] = "单位物品栏"
    set ib_skillCustom[1097] = 0
    set ib_skillList[1098] = 'Aihn'
    set ib_skillName[1098] = "单位物品栏"
    set ib_skillCustom[1098] = 0
    set ib_skillList[1099] = 'Ainf'
    set ib_skillName[1099] = "心灵之火"
    set ib_skillCustom[1099] = 0
    set ib_skillList[1100] = 'Aion'
    set ib_skillName[1100] = "单位物品栏"
    set ib_skillCustom[1100] = 0
    set ib_skillList[1101] = 'Aiun'
    set ib_skillName[1101] = "单位物品栏"
    set ib_skillCustom[1101] = 0
    set ib_skillList[1102] = 'Aivs'
    set ib_skillName[1102] = "隐形术"
    set ib_skillCustom[1102] = 0
    set ib_skillList[1103] = 'Alam'
    set ib_skillName[1103] = "牺牲"
    set ib_skillCustom[1103] = 0
    set ib_skillList[1104] = 'Aliq'
    set ib_skillName[1104] = "液体炸弹"
    set ib_skillCustom[1104] = 0
    set ib_skillList[1105] = 'Alit'
    set ib_skillName[1105] = "闪电攻击"
    set ib_skillCustom[1105] = 0
    set ib_skillList[1106] = 'Aloa'
    set ib_skillName[1106] = "装载"
    set ib_skillCustom[1106] = 0
    set ib_skillList[1107] = 'Aloc'
    set ib_skillName[1107] = "蝗虫"
    set ib_skillCustom[1107] = 0
    set ib_skillList[1108] = 'Alsh'
    set ib_skillName[1108] = "闪电护盾"
    set ib_skillCustom[1108] = 0
    set ib_skillList[1109] = 'Amb2'
    set ib_skillName[1109] = "恢复魔法"
    set ib_skillCustom[1109] = 0
    set ib_skillList[1110] = 'Ambb'
    set ib_skillName[1110] = "法力燃烧"
    set ib_skillCustom[1110] = 0
    set ib_skillList[1111] = 'Ambd'
    set ib_skillName[1111] = "法力燃烧"
    set ib_skillCustom[1111] = 0
    set ib_skillList[1112] = 'Ambt'
    set ib_skillName[1112] = "补充魔法和生命值"
    set ib_skillCustom[1112] = 0
    set ib_skillList[1113] = 'Amdf'
    set ib_skillName[1113] = "魔法防御"
    set ib_skillCustom[1113] = 0
    set ib_skillList[1114] = 'Amec'
    set ib_skillName[1114] = "机械类的小玩艺"
    set ib_skillCustom[1114] = 0
    set ib_skillList[1115] = 'Amed'
    set ib_skillName[1115] = "卸载尸体"
    set ib_skillCustom[1115] = 0
    set ib_skillList[1116] = 'Amel'
    set ib_skillName[1116] = "得到尸体"
    set ib_skillCustom[1116] = 0
    set ib_skillList[1117] = 'Amfl'
    set ib_skillName[1117] = "魔力之焰"
    set ib_skillCustom[1117] = 0
    set ib_skillList[1118] = 'Amgl'
    set ib_skillName[1118] = "月刃"
    set ib_skillCustom[1118] = 0
    set ib_skillList[1119] = 'Amgr'
    set ib_skillName[1119] = "月刃"
    set ib_skillCustom[1119] = 0
endfunction
function IB_SkillFill14 takes nothing returns nothing
    set ib_skillList[1120] = 'Amic'
    set ib_skillName[1120] = "战斗号召"
    set ib_skillCustom[1120] = 0
    set ib_skillList[1121] = 'Amil'
    set ib_skillName[1121] = "战斗号召"
    set ib_skillCustom[1121] = 0
    set ib_skillList[1122] = 'Amim'
    set ib_skillName[1122] = "魔法免疫"
    set ib_skillCustom[1122] = 0
    set ib_skillList[1123] = 'Amin'
    set ib_skillName[1123] = "地雷引爆"
    set ib_skillCustom[1123] = 0
    set ib_skillList[1124] = 'Amls'
    set ib_skillName[1124] = "空中锁镣"
    set ib_skillCustom[1124] = 0
    set ib_skillList[1125] = 'Amnb'
    set ib_skillName[1125] = "法力燃烧"
    set ib_skillCustom[1125] = 0
    set ib_skillList[1126] = 'Amnx'
    set ib_skillName[1126] = "范围性攻击伤害"
    set ib_skillCustom[1126] = 0
    set ib_skillList[1127] = 'Amnz'
    set ib_skillName[1127] = "范围性攻击伤害"
    set ib_skillCustom[1127] = 0
    set ib_skillList[1128] = 'Amou'
    set ib_skillName[1128] = "骑乘"
    set ib_skillCustom[1128] = 0
    set ib_skillList[1129] = 'Amov'
    set ib_skillName[1129] = "移动"
    set ib_skillCustom[1129] = 0
    set ib_skillList[1130] = 'Amrf'
    set ib_skillName[1130] = "乌鸦形态"
    set ib_skillCustom[1130] = 0
    set ib_skillList[1131] = 'Amtc'
    set ib_skillName[1131] = "保持原位"
    set ib_skillCustom[1131] = 0
    set ib_skillList[1132] = 'Andm'
    set ib_skillName[1132] = "驱逐魔法"
    set ib_skillCustom[1132] = 0
    set ib_skillList[1133] = 'Andt'
    set ib_skillName[1133] = "显示"
    set ib_skillCustom[1133] = 0
    set ib_skillList[1134] = 'Ane2'
    set ib_skillName[1134] = "选择单位"
    set ib_skillCustom[1134] = 0
    set ib_skillList[1135] = 'Anei'
    set ib_skillName[1135] = "选择使用者"
    set ib_skillCustom[1135] = 0
    set ib_skillList[1136] = 'Aneu'
    set ib_skillName[1136] = "选择英雄"
    set ib_skillCustom[1136] = 0
    set ib_skillList[1137] = 'Anh1'
    set ib_skillName[1137] = "医疗"
    set ib_skillCustom[1137] = 0
    set ib_skillList[1138] = 'Anh2'
    set ib_skillName[1138] = "医疗"
    set ib_skillCustom[1138] = 0
    set ib_skillList[1139] = 'Anhe'
    set ib_skillName[1139] = "医疗"
    set ib_skillCustom[1139] = 0
    set ib_skillList[1140] = 'Anit'
    set ib_skillName[1140] = "跟踪"
    set ib_skillCustom[1140] = 0
    set ib_skillList[1141] = 'Ansk'
    set ib_skillName[1141] = "硬化皮肤"
    set ib_skillCustom[1141] = 0
    set ib_skillList[1142] = 'Aoar'
    set ib_skillName[1142] = "治疗守卫光环"
    set ib_skillCustom[1142] = 0
    set ib_skillList[1143] = 'Apak'
    set ib_skillName[1143] = "行囊技能"
    set ib_skillCustom[1143] = 0
    set ib_skillList[1144] = 'Apg2'
    set ib_skillName[1144] = "净化"
    set ib_skillCustom[1144] = 0
    set ib_skillList[1145] = 'Aphx'
    set ib_skillName[1145] = "火凤凰变形(和凤凰蛋有关的)"
    set ib_skillCustom[1145] = 0
    set ib_skillList[1146] = 'Apig'
    set ib_skillName[1146] = "永久的献祭"
    set ib_skillCustom[1146] = 0
    set ib_skillList[1147] = 'Apit'
    set ib_skillName[1147] = "商店购买物品"
    set ib_skillCustom[1147] = 0
    set ib_skillList[1148] = 'Apiv'
    set ib_skillName[1148] = "永久的隐形"
    set ib_skillCustom[1148] = 0
    set ib_skillList[1149] = 'Aply'
    set ib_skillName[1149] = "变形术"
    set ib_skillCustom[1149] = 0
    set ib_skillList[1150] = 'Apmf'
    set ib_skillName[1150] = "凤凰火焰"
    set ib_skillCustom[1150] = 0
    set ib_skillList[1151] = 'Apo2'
    set ib_skillName[1151] = "毒刺"
    set ib_skillCustom[1151] = 0
    set ib_skillList[1152] = 'Apoi'
    set ib_skillName[1152] = "毒刺"
    set ib_skillCustom[1152] = 0
    set ib_skillList[1153] = 'Apos'
    set ib_skillName[1153] = "占据"
    set ib_skillCustom[1153] = 0
    set ib_skillList[1154] = 'Aprg'
    set ib_skillName[1154] = "净化"
    set ib_skillCustom[1154] = 0
    set ib_skillList[1155] = 'Aps2'
    set ib_skillName[1155] = "占据"
    set ib_skillCustom[1155] = 0
    set ib_skillList[1156] = 'Apsh'
    set ib_skillName[1156] = "变相移动"
    set ib_skillCustom[1156] = 0
    set ib_skillList[1157] = 'Apts'
    set ib_skillName[1157] = "疾病云雾"
    set ib_skillCustom[1157] = 0
    set ib_skillList[1158] = 'Apxf'
    set ib_skillName[1158] = "凤凰火焰"
    set ib_skillCustom[1158] = 0
    set ib_skillList[1159] = 'Ara2'
    set ib_skillName[1159] = "咆哮"
    set ib_skillCustom[1159] = 0
    set ib_skillList[1160] = 'Arai'
    set ib_skillName[1160] = "复活死尸"
    set ib_skillCustom[1160] = 0
    set ib_skillList[1161] = 'Arav'
    set ib_skillName[1161] = "风暴之鸦"
    set ib_skillCustom[1161] = 0
    set ib_skillList[1162] = 'Arbr'
    set ib_skillName[1162] = "加强型地洞升级"
    set ib_skillCustom[1162] = 0
    set ib_skillList[1163] = 'Arej'
    set ib_skillName[1163] = "生命恢复"
    set ib_skillCustom[1163] = 0
    set ib_skillList[1164] = 'Arel'
    set ib_skillName[1164] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[1164] = 0
    set ib_skillList[1165] = 'Aren'
    set ib_skillName[1165] = "更新"
    set ib_skillCustom[1165] = 0
    set ib_skillList[1166] = 'Arep'
    set ib_skillName[1166] = "修理"
    set ib_skillCustom[1166] = 0
    set ib_skillList[1167] = 'Aret'
    set ib_skillName[1167] = "再训练之书"
    set ib_skillCustom[1167] = 0
    set ib_skillList[1168] = 'Arev'
    set ib_skillName[1168] = "复活英雄"
    set ib_skillCustom[1168] = 0
    set ib_skillList[1169] = 'Argd'
    set ib_skillName[1169] = "送回黄金"
    set ib_skillCustom[1169] = 0
    set ib_skillList[1170] = 'Argl'
    set ib_skillName[1170] = "送回黄金和木材"
    set ib_skillCustom[1170] = 0
    set ib_skillList[1171] = 'Arll'
    set ib_skillName[1171] = "提高英雄生命值恢复速度的物品"
    set ib_skillCustom[1171] = 0
    set ib_skillList[1172] = 'Arlm'
    set ib_skillName[1172] = "送回木材"
    set ib_skillCustom[1172] = 0
    set ib_skillList[1173] = 'Arng'
    set ib_skillName[1173] = "复仇"
    set ib_skillCustom[1173] = 0
    set ib_skillList[1174] = 'Aro1'
    set ib_skillName[1174] = "扎根"
    set ib_skillCustom[1174] = 0
    set ib_skillList[1175] = 'Aro2'
    set ib_skillName[1175] = "扎根"
    set ib_skillCustom[1175] = 0
    set ib_skillList[1176] = 'Aroa'
    set ib_skillName[1176] = "咆哮"
    set ib_skillCustom[1176] = 0
    set ib_skillList[1177] = 'Aroc'
    set ib_skillName[1177] = "弹幕攻击"
    set ib_skillCustom[1177] = 0
    set ib_skillList[1178] = 'Aroo'
    set ib_skillName[1178] = "扎根"
    set ib_skillCustom[1178] = 0
    set ib_skillList[1179] = 'Arpb'
    set ib_skillName[1179] = "补充魔法和生命值"
    set ib_skillCustom[1179] = 0
    set ib_skillList[1180] = 'Arpl'
    set ib_skillName[1180] = "枯萎精髓"
    set ib_skillCustom[1180] = 0
    set ib_skillList[1181] = 'Arpm'
    set ib_skillName[1181] = "灵魂触摸"
    set ib_skillCustom[1181] = 0
    set ib_skillList[1182] = 'Arsg'
    set ib_skillName[1182] = "召唤米纱"
    set ib_skillCustom[1182] = 0
    set ib_skillList[1183] = 'Arsk'
    set ib_skillName[1183] = "抗性皮肤"
    set ib_skillCustom[1183] = 0
    set ib_skillList[1184] = 'Arsp'
    set ib_skillName[1184] = "惊吓"
    set ib_skillCustom[1184] = 0
    set ib_skillList[1185] = 'Arsq'
    set ib_skillName[1185] = "召唤豪猪"
    set ib_skillCustom[1185] = 0
    set ib_skillList[1186] = 'Arst'
    set ib_skillName[1186] = "恢复"
    set ib_skillCustom[1186] = 0
    set ib_skillList[1187] = 'Arsw'
    set ib_skillName[1187] = "毒蛇守卫"
    set ib_skillCustom[1187] = 0
    set ib_skillList[1188] = 'Artn'
    set ib_skillName[1188] = "返回"
    set ib_skillCustom[1188] = 0
    set ib_skillList[1189] = 'Asac'
    set ib_skillName[1189] = "牺牲"
    set ib_skillCustom[1189] = 0
    set ib_skillList[1190] = 'Asal'
    set ib_skillName[1190] = "掠夺"
    set ib_skillCustom[1190] = 0
    set ib_skillList[1191] = 'Asb1'
    set ib_skillName[1191] = "潜水"
    set ib_skillCustom[1191] = 0
    set ib_skillList[1192] = 'Asb2'
    set ib_skillName[1192] = "潜水"
    set ib_skillCustom[1192] = 0
    set ib_skillList[1193] = 'Asb3'
    set ib_skillName[1193] = "潜水"
    set ib_skillCustom[1193] = 0
    set ib_skillList[1194] = 'Asd2'
    set ib_skillName[1194] = "卡布恩"
    set ib_skillCustom[1194] = 0
    set ib_skillList[1195] = 'Asd3'
    set ib_skillName[1195] = "卡布恩"
    set ib_skillCustom[1195] = 0
    set ib_skillList[1196] = 'Asdg'
    set ib_skillName[1196] = "卡布恩"
    set ib_skillCustom[1196] = 0
    set ib_skillList[1197] = 'Asds'
    set ib_skillName[1197] = "卡布恩"
    set ib_skillCustom[1197] = 0
    set ib_skillList[1198] = 'Ashm'
    set ib_skillName[1198] = "影遁"
    set ib_skillCustom[1198] = 0
    set ib_skillList[1199] = 'Ashs'
    set ib_skillName[1199] = "影子权杖"
    set ib_skillCustom[1199] = 0
endfunction
function IB_SkillFill15 takes nothing returns nothing
    set ib_skillList[1200] = 'Asid'
    set ib_skillName[1200] = "出售物品"
    set ib_skillCustom[1200] = 0
    set ib_skillList[1201] = 'Asla'
    set ib_skillName[1201] = "一直睡眠"
    set ib_skillCustom[1201] = 0
    set ib_skillList[1202] = 'Aslo'
    set ib_skillName[1202] = "减速"
    set ib_skillCustom[1202] = 0
    set ib_skillList[1203] = 'Aslp'
    set ib_skillName[1203] = "召唤巨虾"
    set ib_skillCustom[1203] = 0
    set ib_skillList[1204] = 'Asod'
    set ib_skillName[1204] = "产卵之骨"
    set ib_skillCustom[1204] = 0
    set ib_skillList[1205] = 'Asou'
    set ib_skillName[1205] = "能占据单位灵魂的物品"
    set ib_skillCustom[1205] = 0
    set ib_skillList[1206] = 'Asp1'
    set ib_skillName[1206] = "球体"
    set ib_skillCustom[1206] = 0
    set ib_skillList[1207] = 'Asp2'
    set ib_skillName[1207] = "球体"
    set ib_skillCustom[1207] = 0
    set ib_skillList[1208] = 'Asp3'
    set ib_skillName[1208] = "球体"
    set ib_skillCustom[1208] = 0
    set ib_skillList[1209] = 'Asp4'
    set ib_skillName[1209] = "球体"
    set ib_skillCustom[1209] = 0
    set ib_skillList[1210] = 'Asp5'
    set ib_skillName[1210] = "球体"
    set ib_skillCustom[1210] = 0
    set ib_skillList[1211] = 'Asp6'
    set ib_skillName[1211] = "球体"
    set ib_skillCustom[1211] = 0
    set ib_skillList[1212] = 'Aspa'
    set ib_skillName[1212] = "蜘蛛攻击"
    set ib_skillCustom[1212] = 0
    set ib_skillList[1213] = 'Aspb'
    set ib_skillName[1213] = "魔法书"
    set ib_skillCustom[1213] = 0
    set ib_skillList[1214] = 'Aspd'
    set ib_skillName[1214] = "小蜘蛛"
    set ib_skillCustom[1214] = 0
    set ib_skillList[1215] = 'Asph'
    set ib_skillName[1215] = "球体"
    set ib_skillCustom[1215] = 0
    set ib_skillList[1216] = 'Aspi'
    set ib_skillName[1216] = "尖形路障"
    set ib_skillCustom[1216] = 0
    set ib_skillList[1217] = 'Aspl'
    set ib_skillName[1217] = "灵魂锁链"
    set ib_skillCustom[1217] = 0
    set ib_skillList[1218] = 'Aspo'
    set ib_skillName[1218] = "慢性毒药"
    set ib_skillCustom[1218] = 0
    set ib_skillList[1219] = 'Aspp'
    set ib_skillName[1219] = "灵魂锁链"
    set ib_skillCustom[1219] = 0
    set ib_skillList[1220] = 'Asps'
    set ib_skillName[1220] = "魔法盗取"
    set ib_skillCustom[1220] = 0
    set ib_skillList[1221] = 'Aspt'
    set ib_skillName[1221] = "诞生刺蛇幼虫"
    set ib_skillCustom[1221] = 0
    set ib_skillList[1222] = 'Aspy'
    set ib_skillName[1222] = "诞生刺蛇"
    set ib_skillCustom[1222] = 0
    set ib_skillList[1223] = 'Assk'
    set ib_skillName[1223] = "硬化皮肤"
    set ib_skillCustom[1223] = 0
    set ib_skillList[1224] = 'Assp'
    set ib_skillName[1224] = "小蜘蛛"
    set ib_skillCustom[1224] = 0
    set ib_skillList[1225] = 'Asta'
    set ib_skillName[1225] = "静止陷阱"
    set ib_skillCustom[1225] = 0
    set ib_skillList[1226] = 'Astd'
    set ib_skillName[1226] = "卸载苦工"
    set ib_skillCustom[1226] = 0
    set ib_skillList[1227] = 'Aste'
    set ib_skillName[1227] = "盗取"
    set ib_skillCustom[1227] = 0
    set ib_skillList[1228] = 'Asth'
    set ib_skillName[1228] = "风暴战锤"
    set ib_skillCustom[1228] = 0
    set ib_skillList[1229] = 'Astn'
    set ib_skillName[1229] = "石像形态"
    set ib_skillCustom[1229] = 0
    set ib_skillList[1230] = 'Asud'
    set ib_skillName[1230] = "出售单位"
    set ib_skillCustom[1230] = 0
    set ib_skillList[1231] = 'Atau'
    set ib_skillName[1231] = "嘲讽"
    set ib_skillCustom[1231] = 0
    set ib_skillList[1232] = 'Atdg'
    set ib_skillName[1232] = "建筑物破坏光环"
    set ib_skillCustom[1232] = 0
    set ib_skillList[1233] = 'Atdp'
    set ib_skillName[1233] = "卸载驾驶员"
    set ib_skillCustom[1233] = 0
    set ib_skillList[1234] = 'Atlp'
    set ib_skillName[1234] = "装载驾驶员"
    set ib_skillCustom[1234] = 0
    set ib_skillList[1235] = 'Atol'
    set ib_skillName[1235] = "生命之树升级技能"
    set ib_skillCustom[1235] = 0
    set ib_skillList[1236] = 'Atru'
    set ib_skillName[1236] = "真实视域"
    set ib_skillCustom[1236] = 0
    set ib_skillList[1237] = 'Atsp'
    set ib_skillName[1237] = "龙卷旋风"
    set ib_skillCustom[1237] = 0
    set ib_skillList[1238] = 'Attu'
    set ib_skillName[1238] = "坦克围城"
    set ib_skillCustom[1238] = 0
    set ib_skillList[1239] = 'Atwa'
    set ib_skillName[1239] = "龙卷风漫步者"
    set ib_skillCustom[1239] = 0
    set ib_skillList[1240] = 'Auco'
    set ib_skillName[1240] = "不稳定化合物"
    set ib_skillCustom[1240] = 0
    set ib_skillList[1241] = 'Auhf'
    set ib_skillName[1241] = "邪恶狂热"
    set ib_skillCustom[1241] = 0
    set ib_skillList[1242] = 'Ault'
    set ib_skillName[1242] = "夜视能力"
    set ib_skillCustom[1242] = 0
    set ib_skillList[1243] = 'Auns'
    set ib_skillName[1243] = "反召唤建筑"
    set ib_skillCustom[1243] = 0
    set ib_skillList[1244] = 'Aven'
    set ib_skillName[1244] = "浸毒武器"
    set ib_skillCustom[1244] = 0
    set ib_skillList[1245] = 'Avng'
    set ib_skillName[1245] = "复仇之魂"
    set ib_skillCustom[1245] = 0
    set ib_skillList[1246] = 'Avul'
    set ib_skillName[1246] = "无敌的"
    set ib_skillCustom[1246] = 0
    set ib_skillList[1247] = 'Awan'
    set ib_skillName[1247] = "游荡者"
    set ib_skillCustom[1247] = 0
    set ib_skillList[1248] = 'Awar'
    set ib_skillName[1248] = "粉碎"
    set ib_skillCustom[1248] = 0
    set ib_skillList[1249] = 'Aweb'
    set ib_skillName[1249] = "蛛网"
    set ib_skillCustom[1249] = 0
    set ib_skillList[1250] = 'Awfb'
    set ib_skillName[1250] = "霹雳闪电"
    set ib_skillCustom[1250] = 0
    set ib_skillList[1251] = 'Awh2'
    set ib_skillName[1251] = "采集"
    set ib_skillCustom[1251] = 0
    set ib_skillList[1252] = 'Awha'
    set ib_skillName[1252] = "采集"
    set ib_skillCustom[1252] = 0
    set ib_skillList[1253] = 'Awhe'
    set ib_skillName[1253] = "医疗"
    set ib_skillCustom[1253] = 0
    set ib_skillList[1254] = 'Awrg'
    set ib_skillName[1254] = "战争践踏"
    set ib_skillCustom[1254] = 0
    set ib_skillList[1255] = 'Awrh'
    set ib_skillName[1255] = "战争践踏"
    set ib_skillCustom[1255] = 0
    set ib_skillList[1256] = 'Awrp'
    set ib_skillName[1256] = "传送门技能"
    set ib_skillCustom[1256] = 0
    set ib_skillList[1257] = 'Awrs'
    set ib_skillName[1257] = "战争践踏"
    set ib_skillCustom[1257] = 0
    set ib_skillList[1258] = 'B000'
    set ib_skillName[1258] = "鹿丸辅助技能002"
    set ib_skillCustom[1258] = 0
    set ib_skillList[1259] = 'B00M'
    set ib_skillName[1259] = "仙法.聚气"
    set ib_skillCustom[1259] = 0
    set ib_skillList[1260] = 'BTNS'
    set ib_skillName[1260] = "螺旋丸"
    set ib_skillCustom[1260] = 0
    set ib_skillList[1261] = 'Bdbb'
    set ib_skillName[1261] = "吸取生命值和魔法值（附加）"
    set ib_skillCustom[1261] = 0
    set ib_skillList[1262] = 'Bdbl'
    set ib_skillName[1262] = "吸取生命（附加）"
    set ib_skillCustom[1262] = 0
    set ib_skillList[1263] = 'Bdbm'
    set ib_skillName[1263] = "吸取魔法（附加）"
    set ib_skillCustom[1263] = 0
    set ib_skillList[1264] = 'Blin'
    set ib_skillName[1264] = "飞雷神.术式"
    set ib_skillCustom[1264] = 0
    set ib_skillList[1265] = 'Deat'
    set ib_skillName[1265] = "三水灭杀"
    set ib_skillCustom[1265] = 0
    set ib_skillList[1266] = 'Esca'
    set ib_skillName[1266] = "飞雷神一段"
    set ib_skillCustom[1266] = 0
    set ib_skillList[1267] = 'Miss'
    set ib_skillName[1267] = "武器"
    set ib_skillCustom[1267] = 0
    set ib_skillList[1268] = 'OfFr'
    set ib_skillName[1268] = "天之御中.冰"
    set ib_skillCustom[1268] = 0
    set ib_skillList[1269] = 'Rock'
    set ib_skillName[1269] = "舞动的奇迹"
    set ib_skillCustom[1269] = 0
    set ib_skillList[1270] = 'SCae'
    set ib_skillName[1270] = "耐久光环"
    set ib_skillCustom[1270] = 0
    set ib_skillList[1271] = 'SCc1'
    set ib_skillName[1271] = "飓风"
    set ib_skillCustom[1271] = 0
    set ib_skillList[1272] = 'SCva'
    set ib_skillName[1272] = "窃取生命"
    set ib_skillCustom[1272] = 0
    set ib_skillList[1273] = 'SNdc'
    set ib_skillName[1273] = "黑暗转换"
    set ib_skillCustom[1273] = 0
    set ib_skillList[1274] = 'SNdd'
    set ib_skillName[1274] = "死亡凋零"
    set ib_skillCustom[1274] = 0
    set ib_skillList[1275] = 'SNeq'
    set ib_skillName[1275] = "地震"
    set ib_skillCustom[1275] = 0
    set ib_skillList[1276] = 'SNin'
    set ib_skillName[1276] = "地狱火"
    set ib_skillCustom[1276] = 0
    set ib_skillList[1277] = 'Sbsk'
    set ib_skillName[1277] = "狂暴愤怒升级"
    set ib_skillCustom[1277] = 0
    set ib_skillList[1278] = 'Sbtl'
    set ib_skillName[1278] = "战备状态"
    set ib_skillCustom[1278] = 0
    set ib_skillList[1279] = 'Sch2'
    set ib_skillName[1279] = "保持原位"
    set ib_skillCustom[1279] = 0
endfunction
function IB_SkillFill16 takes nothing returns nothing
    set ib_skillList[1280] = 'Sch3'
    set ib_skillName[1280] = "保持原位"
    set ib_skillCustom[1280] = 0
    set ib_skillList[1281] = 'Sch4'
    set ib_skillName[1281] = "保持原位"
    set ib_skillCustom[1281] = 0
    set ib_skillList[1282] = 'Sch5'
    set ib_skillName[1282] = "保持原位"
    set ib_skillCustom[1282] = 0
    set ib_skillList[1283] = 'Scri'
    set ib_skillName[1283] = "残废"
    set ib_skillCustom[1283] = 0
    set ib_skillList[1284] = 'Sdro'
    set ib_skillName[1284] = "卸载"
    set ib_skillCustom[1284] = 0
    set ib_skillList[1285] = 'Shie'
    set ib_skillName[1285] = "魔镜冰杀"
    set ib_skillCustom[1285] = 0
    set ib_skillList[1286] = 'Shot'
    set ib_skillName[1286] = "铁线花之舞.花"
    set ib_skillCustom[1286] = 0
    set ib_skillList[1287] = 'Slo2'
    set ib_skillName[1287] = "装载小精灵"
    set ib_skillCustom[1287] = 0
    set ib_skillList[1288] = 'Slo3'
    set ib_skillName[1288] = "装载"
    set ib_skillCustom[1288] = 0
    set ib_skillList[1289] = 'Sloa'
    set ib_skillName[1289] = "装载"
    set ib_skillCustom[1289] = 0
    set ib_skillList[1290] = 'Splo'
    set ib_skillName[1290] = "医疗攻击术.乱身冲"
    set ib_skillCustom[1290] = 0
    set ib_skillList[1291] = 'Sshm'
    set ib_skillName[1291] = "影遁"
    set ib_skillCustom[1291] = 0
    set ib_skillList[1292] = 'Stri'
    set ib_skillName[1292] = "火遁.豪风阵"
    set ib_skillCustom[1292] = 0
    set ib_skillList[1293] = 'Suhf'
    set ib_skillName[1293] = "邪恶狂热"
    set ib_skillCustom[1293] = 0
    set ib_skillList[1294] = 'TD91'
    set ib_skillName[1294] = "纸牢术"
    set ib_skillCustom[1294] = 0
    set ib_skillList[1295] = 'TNBl'
    set ib_skillName[1295] = "墨霞瞬身术"
    set ib_skillCustom[1295] = 0
    set ib_skillList[1296] = 'TNPu'
    set ib_skillName[1296] = "飞雷神一段"
    set ib_skillCustom[1296] = 0
    set ib_skillList[1297] = 'Wave'
    set ib_skillName[1297] = "飞雷神.瞬身"
    set ib_skillCustom[1297] = 0
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
    elseif ib_fillIdx == 4 then
        call IB_Fill4()
    elseif ib_fillIdx == 5 then
        call IB_Fill5()
    endif
    set ib_fillIdx = ib_fillIdx + 1
    if ib_fillIdx >= ib_fillTotal then
        set ib_itemCount = 411
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
    elseif ib_skFillIdx == 12 then
        call IB_SkillFill12()
    elseif ib_skFillIdx == 13 then
        call IB_SkillFill13()
    elseif ib_skFillIdx == 14 then
        call IB_SkillFill14()
    elseif ib_skFillIdx == 15 then
        call IB_SkillFill15()
    elseif ib_skFillIdx == 16 then
        call IB_SkillFill16()
    endif
    set ib_skFillIdx = ib_skFillIdx + 1
    if ib_skFillIdx >= ib_skFillTotal then
        set ib_skillCount = 1298
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
    set ib_fillTotal = 6
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 17
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    call IB_CritInit()
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
