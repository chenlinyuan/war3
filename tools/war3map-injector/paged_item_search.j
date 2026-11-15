function IB_PageDigit takes string c returns integer
    if c == "0" then
        return 0
    elseif c == "1" then
        return 1
    elseif c == "2" then
        return 2
    elseif c == "3" then
        return 3
    elseif c == "4" then
        return 4
    elseif c == "5" then
        return 5
    elseif c == "6" then
        return 6
    elseif c == "7" then
        return 7
    elseif c == "8" then
        return 8
    elseif c == "9" then
        return 9
    endif
    return -1
endfunction

function IB_IsPageDigits takes string s returns boolean
    local integer i = 0
    local integer len = StringLength(s)
    if len == 0 or len > 3 then
        return false
    endif
    loop
        exitwhen i >= len
        if IB_PageDigit(SubString(s, i, i + 1)) < 0 then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

function IB_PageNumber takes string s returns integer
    local integer i = 0
    local integer value = 0
    loop
        exitwhen i >= StringLength(s)
        set value = value * 10 + IB_PageDigit(SubString(s, i, i + 1))
        set i = i + 1
    endloop
    return value
endfunction

function IB_SearchStep takes nothing returns nothing
    local integer n = 0
    local integer stdPages
    local integer cusPages
    local integer lowIndex
    local integer highIndex
    local string name
    local string nameGbk
    set lowIndex = (ib_searchPage - 1) * ib_searchPageSize
    set highIndex = ib_searchPage * ib_searchPageSize
    loop
        exitwhen ib_searchIdx >= ib_itemCount or n >= 40
        set nameGbk = ib_itemNameGbk[ib_searchIdx]
        if IB_NameMatch(IB_ItemName(ib_searchIdx), ib_searchKey) or (StringLength(nameGbk) > 0 and IB_NameMatch(nameGbk, ib_searchKey)) then
            set ib_searchFound = ib_searchFound + 1
            set name = IB_ItemName(ib_searchIdx) + "[" + IB_IdStr(ib_itemList[ib_searchIdx]) + "]"
            if ib_itemCustom[ib_searchIdx] == 1 then
                set ib_searchCusN = ib_searchCusN + 1
                if ib_searchCusN > lowIndex and ib_searchCusN <= highIndex then
                    set ib_searchCus = ib_searchCus + name + "  "
                    set ib_searchCusPageN = ib_searchCusPageN + 1
                endif
            else
                set ib_searchStdN = ib_searchStdN + 1
                if ib_searchStdN > lowIndex and ib_searchStdN <= highIndex then
                    set ib_searchStd = ib_searchStd + name + "  "
                    set ib_searchStdPageN = ib_searchStdPageN + 1
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
            set stdPages = (ib_searchStdN + ib_searchPageSize - 1) / ib_searchPageSize
            set cusPages = (ib_searchCusN + ib_searchPageSize - 1) / ib_searchPageSize
            set ib_searchPages = stdPages
            if cusPages > ib_searchPages then
                set ib_searchPages = cusPages
            endif
            if ib_searchPage > ib_searchPages then
                call IB_Message(ib_searchPlayer, "没有第 " + I2S(ib_searchPage) + " 页；共 " + I2S(ib_searchPages) + " 页")
            else
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[装备]|r 第 " + I2S(ib_searchPage) + "/" + I2S(ib_searchPages) + " 页，共找到 " + I2S(ib_searchFound) + " 件")
                if ib_searchStdPageN > 0 then
                    call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaa原版(共" + I2S(ib_searchStdN) + "，本页" + I2S(ib_searchStdPageN) + "):|r " + ib_searchStd)
                endif
                if ib_searchCusPageN > 0 then
                    call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00自定义(共" + I2S(ib_searchCusN) + "，本页" + I2S(ib_searchCusPageN) + "):|r " + ib_searchCus)
                endif
                if ib_searchPage < ib_searchPages then
                    call IB_Message(ib_searchPlayer, "下一页: search " + ib_searchKey + " " + I2S(ib_searchPage + 1))
                endif
            endif
        endif
        set ib_searchPlayer = null
    endif
endfunction

function IB_Search takes player p, string keyword returns nothing
    local integer i = 0
    local integer len
    local integer spacePos = -1
    local integer page = 1
    local string suffix
    set len = StringLength(keyword)
    loop
        exitwhen i >= len
        if SubString(keyword, i, i + 1) == " " then
            set spacePos = i
        endif
        set i = i + 1
    endloop
    if spacePos >= 0 then
        set suffix = SubString(keyword, spacePos + 1, len)
        if IB_IsPageDigits(suffix) then
            set page = IB_PageNumber(suffix)
            if page < 1 then
                set page = 1
            endif
            set keyword = SubString(keyword, 0, spacePos)
            set len = StringLength(keyword)
            loop
                exitwhen len == 0 or SubString(keyword, len - 1, len) != " "
                set len = len - 1
                set keyword = SubString(keyword, 0, len)
            endloop
        endif
    endif
    if StringLength(keyword) == 0 then
        call IB_Message(p, "请输入关键词，如: search 影之玉 或 search 影之玉 2")
        return
    endif
    call IB_Message(p, "搜索 \"" + keyword + "\" 第 " + I2S(page) + " 页...")
    set ib_searchIdx = 0
    set ib_searchFound = 0
    set ib_searchKey = keyword
    set ib_searchStd = ""
    set ib_searchCus = ""
    set ib_searchStdN = 0
    set ib_searchCusN = 0
    set ib_searchPage = page
    set ib_searchPages = 1
    set ib_searchStdPageN = 0
    set ib_searchCusPageN = 0
    set ib_searchPlayer = p
    if ib_searchTimer != null then
        call PauseTimer(ib_searchTimer)
        call DestroyTimer(ib_searchTimer)
    endif
    set ib_searchTimer = CreateTimer()
    call TimerStart(ib_searchTimer, 0.01, true, function IB_SearchStep)
endfunction
