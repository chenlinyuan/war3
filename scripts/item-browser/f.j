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



function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    set ib_skillCount = 0
    call IB_RegisterChat()
    set ib_fillIdx = 0
    set ib_fillTotal = 4
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 11
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    call IB_CritInit()
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
