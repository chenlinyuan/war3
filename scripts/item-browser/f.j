//============================================================================
// ITEM BROWSER - 装备搜索与添加系统
// 作者: chenlinyuan (war3 mod 项目)
// 功能:
//   输入 "search <关键词>"    搜索名称包含关键词的装备
//   输入 "search <拼音首字母>" 用拼音首字母搜索（如 xxmz = 吸血面罩）
//   输入 "additem <名称>"     添加装备给当前选中的英雄（背包满则掉地上）
//   输入 "additem <名称> n"   添加 n 个
//   输入 "additem <序号>"     添加上次搜索结果中第 <序号> 件（推荐，无需中文）
//   输入 "additem <拼音> n"   用拼音首字母添加
//   输入 "itembrowser"        显示帮助
//
// 说明:
//   - 地图启动后自动枚举所有物品类型（约 2-3 分钟，视电脑性能）
//   - 枚举完成后屏幕提示 "装备列表加载完成"
//   - 支持中文名称匹配 + 拼音首字母匹配 + 序号选择
//   - 因 War3 1.27 无法输入中文，推荐用「拼音首字母」或「序号」方式
//============================================================================

//============================================================================
// PINYIN - 汉字拼音首字母映射
// 用于在无法输入中文的游戏中，用拼音首字母搜索中文装备名
// 例如：吸血面罩 -> xxmz
//============================================================================

//---------------------------------------------------------------------------
// 初始化拼音首字母表：按字母分组（索引 0-22 对应 a-w，24-25 对应 y-z 略）
//---------------------------------------------------------------------------
function PY_InitTable takes nothing returns nothing
    set py_map[0] = "阿啊哎哀挨爱碍安按暗昂凹奥"
    set py_map[1] = "八巴扒吧拔把罢白百柏摆败拜班般斑搬板版半办伴帮绑榜棒包宝保堡报抱暴爆杯悲北贝备背倍被奔本笨崩逼鼻比彼笔币必毕闭边编变便遍标表别宾冰兵并病波玻剥播伯泊驳博薄补捕不布步部"
    set py_map[2] = "擦猜才材财裁采彩踩菜参餐残蚕惨灿仓苍舱藏操糙曹草册侧测层叉插查茶察差拆柴缠产铲颤昌长肠尝偿厂场畅唱抄超朝潮巢吵炒车彻尘沉陈衬称城乘程惩澄橙吃池迟持匙尺齿赤翅充冲虫崇抽仇绸愁丑臭初出橱除楚础储处触川穿传船喘串疮窗床闯创吹垂春纯唇蠢词慈辞磁雌此刺次聪从丛凑粗促醋窜催脆翠村存寸错"
    set py_map[3] = "搭达答打大呆代带待怠贷袋逮丹单担耽胆但诞弹淡蛋当挡党荡刀导岛倒到悼盗道稻得德灯的登等凳低堤滴敌笛底抵地弟帝递第颠典点电店垫殿刁雕吊钓调掉跌叠蝶丁顶订定丢东冬董懂动冻洞都斗抖陡豆逗督毒独读堵赌杜肚度渡端短段断缎堆队对兑吨蹲盾顿多夺朵躲"
    set py_map[4] = "俄鹅额恶饿恩儿而尔耳二"
    set py_map[5] = "发罚阀法帆番翻凡烦繁反返犯泛饭范贩方芳防妨房仿访纺放飞非肥匪废沸费分纷坟粉份奋愤丰风封疯峰锋蜂逢缝讽凤奉佛否夫肤孵弗伏扶服浮符幅福抚府斧俯辅腐父付妇负附阜复副赋傅富腹覆"
    set py_map[6] = "该改盖概干甘杆肝赶敢感刚钢岗港高搞稿告哥歌搁割革格阁隔个各给根跟更耕工弓公功攻供宫恭巩共贡勾沟钩狗构购够估姑孤古谷股骨鼓固故顾瓜刮寡挂怪关观官冠馆管贯惯灌光广归龟规轨鬼贵桂跪滚棍锅国果裹过"
    set py_map[7] = "哈孩海害含寒喊汉汗旱悍焊行航毫好号浩喝合何和河荷核盒贺黑痕很狠恨恒横衡轰哄红宏洪虹喉猴吼后厚候乎呼忽狐胡湖糊虎互户护花华划化画话怀淮坏欢环还缓幻换唤荒慌皇黄谎灰挥恢辉回毁悔汇会绘昏婚浑混活火或货获祸霍"
    set py_map[8] = "击机肌鸡积基激及吉级极即急疾集辑几己挤计记纪技忌际剂季既继寄寂加夹佳家甲价驾架尖坚间肩艰监兼拣检减剪简见件建剑健舰渐践鉴键箭江姜将浆讲奖降交郊娇骄胶焦角狡饺脚搅叫轿较教阶皆接街节劫杰洁结捷截竭姐解介戒届界借巾今斤金津筋仅紧谨进近劲晋浸禁京经茎荆惊晶睛井警净径竞竟敬静境镜纠究九久酒旧救就舅居拘局菊橘举巨拒具俱剧据距锯聚卷倦决绝军均君俊"
    set py_map[9] = "卡开凯慨刊堪砍看康抗炕考靠科棵颗壳咳可克刻客课肯坑空孔恐控口扣哭苦库裤夸垮跨块快宽款筐狂况亏葵愧昆困扩括阔"
    set py_map[10] = "拉啦喇腊辣来莱赖兰拦栏蓝篮览懒烂郎狼廊朗浪捞劳牢老乐雷蕾泪类累冷愣厘梨离犁璃黎礼李里理力历厉立丽利励例隶栗粒连帘怜莲联廉脸练炼恋链良凉梁量粮两亮谅辆辽疗聊僚了料列烈裂劣猎林临淋灵铃陵零龄领令另溜刘流留榴柳六龙笼聋隆垄楼漏陋露炉卤鲁陆录鹿路驴旅铝屡缕律虑率绿氯滤乱略抡轮论罗萝逻锣骡裸洛落"
    set py_map[11] = "妈麻马码蚂骂埋买麦卖迈脉蛮满慢漫忙芒盲茫猫毛矛茅冒贸帽貌么没玫眉梅媒煤每美妹门闷们萌蒙猛梦弥迷谜米秘密蜜眠绵棉免勉面苗描秒妙庙灭民敏名明鸣命谬摸模膜摩磨魔抹末沫陌莫墨默谋某母亩木目牧墓幕慕暮穆"
    set py_map[12] = "拿哪那纳乃奶耐男南难囊脑闹呢内嫩能尼泥你拟逆匿腻年念娘酿鸟尿捏您宁凝牛扭纽农浓弄奴努怒女暖虐诺"
    set py_map[13] = "哦欧殴藕偶"
    set py_map[14] = "爬怕拍排牌派攀盘判叛盼庞旁胖抛炮跑泡陪培赔佩配喷盆朋棚蓬膨碰批披皮疲脾匹屁偏片骗飘漂票撇拼贫频品聘乒平评凭瓶萍泼颇婆迫破魄剖扑铺仆葡蒲朴普谱瀑"
    set py_map[15] = "七妻期欺齐其奇歧骑棋旗乞岂企启起气弃汽契砌器恰千迁牵铅签前钱潜浅遣欠枪腔强墙抢悄敲乔侨巧桥瞧翘切茄且窃亲侵勤青轻倾清情晴擎请庆穷丘秋求球区曲驱屈趋渠取娶去圈全权泉拳犬劝缺却确裙群"
    set py_map[16] = "然燃染嚷让饶扰绕惹热人仁忍认任扔仍日荣容绒溶融柔肉如辱入软锐瑞润若弱"
    set py_map[17] = "撒洒塞赛三伞散桑嗓丧扫嫂色森僧杀沙纱傻筛晒山删闪扇善伤商赏上尚烧稍少绍舌蛇舍设社射涉摄申伸身深神审婶甚肾慎升生声牲胜圣师失狮施湿十什石时识实拾蚀食史使始驶士氏示世市式事侍势视试饰室是适逝释收手守首寿受兽售授瘦书叔殊疏舒输蔬熟暑署属鼠数术束述树竖刷耍衰摔甩帅双霜爽谁水税睡顺瞬说硕丝司私思斯撕死四寺似饲松宋送诵搜艘苏俗诉肃素速宿塑酸蒜算虽随岁碎遂隧孙损缩所索锁"
    set py_map[18] = "他它她塌塔踏台抬太态泰贪摊滩坛谈坦毯叹炭汤唐堂塘躺烫涛掏逃桃陶讨套特疼腾梯踢提题蹄体剃替天添田甜填挑条跳贴铁帖厅听亭庭停挺艇通同铜童统桶筒痛偷头投透突图徒途涂屠土吐兔团推腿退吞屯托拖脱驼妥拓"
    set py_map[19] = "挖哇歪外弯湾丸完玩顽挽晚碗万汪亡王网往忘旺望危威微为围唯维伟伪尾委萎卫未位味畏胃谓喂慰温文闻纹吻稳问翁窝我握卧乌污屋无吴五午伍武侮舞务物误悟雾"
    set py_map[20] = "夕西吸希昔析息悉惜稀溪熄膝习席袭洗喜系细戏虾瞎峡狭霞下吓夏仙先纤鲜闲弦贤咸衔嫌显险现县限线宪陷献腺乡相香箱详想响享项象像橡消宵销小晓孝校笑效些歇协邪胁斜鞋写泄泻卸屑谢心辛欣新薪信星腥刑行形醒兴幸性姓胸兄凶雄熊休修羞朽秀绣袖需虚须徐许序叙畜绪续宣悬旋选炫削靴学雪血寻巡询循训讯迅"
    set py_map[21] = "压呀鸦鸭牙芽哑亚讶烟淹延严言岩炎沿研盐颜眼演厌宴验央秧扬羊阳洋仰养样妖腰邀摇遥咬药要耀爷也冶野业叶页夜液一衣医依仪宜姨移遗疑已乙以艺忆议亦异役译易疫益谊意溢毅因阴音银引饮隐印英婴樱鹰迎盈营蝇赢影映硬哟拥庸永咏泳勇涌用优忧幽悠尤由犹油游友有又右幼诱于余鱼娱渔愉榆与宇羽雨语玉育郁狱浴预域欲遇御愈誉元员园原圆援缘源远愿怨院约月阅越跃云匀允运晕韵蕴"
    set py_map[22] = "杂灾栽载再在咱攒暂赞脏葬遭糟早枣澡造灶责择则泽贼怎增赠扎渣眨炸摘宅窄债寨沾粘展占战站张章涨掌丈帐账胀障招找沼召照罩遮折哲者这浙珍真针侦诊阵振镇震争征挣睁蒸整正证郑政症之支只汁芝枝知织肢直值职植殖止址纸指至志制质治致秩智置中忠终钟肿种众重舟周州洲粥轴肘皱昼骤珠株诸猪竹逐主煮嘱助注驻祝著筑铸抓爪专砖转赚庄装壮状撞追准捉桌啄着仔滋姿资子紫字自宗综棕踪总纵走奏租足族阻组祖钻嘴最罪尊遵昨左作坐座做"
endfunction

//---------------------------------------------------------------------------
// 查找汉字所属的拼音首字母；找不到返回 ""
//---------------------------------------------------------------------------
function PY_GetInitial takes string ch returns string
    local integer i = 0
    local string group
    local integer len
    local integer j

    loop
        exitwhen i > 22
        set group = py_map[i]
        set len = StringLength(group)
        set j = 0
        loop
            exitwhen j >= len
            if SubString(group, j, j + 1) == ch then
                return SubString("abcdefghijklmnopqrstuvwxyz", i, i + 1)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    return ""
endfunction

//---------------------------------------------------------------------------
// 把中文名称转换为拼音首字母串，例如 "吸血面罩" -> "xxmz"
//---------------------------------------------------------------------------
function PY_Convert takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    local string initial

    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        set initial = PY_GetInitial(ch)
        if initial == "" then
            set result = result + StringCase(ch, false)
        else
            set result = result + initial
        endif
        set i = i + 1
    endloop
    return result
endfunction

//---------------------------------------------------------------------------
// 判断名称的拼音首字母是否包含关键词
//---------------------------------------------------------------------------
function PY_Matches takes string name, string keyword returns boolean
    local string py = PY_Convert(name)
    local string kw = StringCase(keyword, false)
    local integer pyLen = StringLength(py)
    local integer kwLen = StringLength(kw)
    local integer i = 0
    local integer j
    local boolean matched

    if kwLen == 0 then
        return true
    endif
    if kwLen > pyLen then
        return false
    endif

    loop
        exitwhen i + kwLen > pyLen
        set j = 0
        set matched = true
        loop
            exitwhen j >= kwLen
            if SubString(py, i + j, i + j + 1) != SubString(kw, j, j + 1) then
                set matched = false
                set j = kwLen
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
// [工具] 去除颜色代码 |cXXXXXXXX 和 |r
//---------------------------------------------------------------------------
function IB_StripColorCodes takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "|" then
            if SubString(s, i + 1, i + 2) == "c" or SubString(s, i + 1, i + 2) == "C" then
                set i = i + 9
            elseif SubString(s, i + 1, i + 2) == "r" or SubString(s, i + 1, i + 2) == "R" then
                set i = i + 1
            else
                set result = result + ch
                set i = i + 1
            endif
        else
            set result = result + ch
            set i = i + 1
        endif
    endloop
    return result
endfunction

//---------------------------------------------------------------------------
// [工具] 字符串不区分大小写比较
//---------------------------------------------------------------------------
function IB_StrEqCI takes string a, string b returns boolean
    return StringCase(a, false) == StringCase(b, false)
endfunction

//---------------------------------------------------------------------------
// [工具] 发送消息给玩家
//---------------------------------------------------------------------------
function IB_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ff00[装备]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [工具] 判断物品名称是否包含关键词（中文子串 或 拼音首字母）
//---------------------------------------------------------------------------
function IB_IsItemMatch takes integer itemId, string keyword returns boolean
    local string name = IB_StripColorCodes(GetObjectName(itemId))
    local integer nameLen = StringLength(name)
    local integer keyLen = StringLength(keyword)
    local integer i = 0
    local integer j
    local boolean matched

    if keyLen == 0 then
        return true
    endif

    // 1) 中文/原文子串匹配
    if keyLen <= nameLen then
        loop
            exitwhen i + keyLen > nameLen
            set j = 0
            set matched = true
            loop
                exitwhen j >= keyLen
                if SubString(name, i + j, i + j + 1) != SubString(keyword, j, j + 1) then
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
    endif

    // 2) 拼音首字母匹配
    if PY_Matches(name, keyword) then
        return true
    endif

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
// 搜索装备
//---------------------------------------------------------------------------
function IB_Search takes player p, string keyword returns nothing
    local integer i = 0
    local integer found = 0
    local string name

    call IB_Message(p, "搜索 \"" + keyword + "\" ...")

    set ib_lastResultCount = 0

    loop
        exitwhen i >= ib_itemCount
        if IB_IsItemMatch(ib_itemList[i], keyword) then
            set name = IB_StripColorCodes(GetObjectName(ib_itemList[i]))
            set found = found + 1
            if found <= 20 then
                set ib_lastResult[found - 1] = ib_itemList[i]
                set ib_lastResultCount = found
                call DisplayTimedTextToPlayer(p, 0, 0, 30.0, "  |cffffcc00" + I2S(found) + ".|r " + name + " |cff888888(" + PY_Convert(name) + ")|r")
            endif
        endif
        set i = i + 1
    endloop

    if found == 0 then
        call IB_Message(p, "未找到包含 \"" + keyword + "\" 的装备")
    elseif found > 20 then
        call IB_Message(p, "共找到 " + I2S(found) + " 件，仅显示前 20 件")
    else
        call IB_Message(p, "共找到 " + I2S(found) + " 件装备，输入 additem <序号> 添加")
    endif
endfunction

//---------------------------------------------------------------------------
// 添加装备（精确匹配名称，找不到则用拼音首字母匹配）
//---------------------------------------------------------------------------
function IB_AddItem takes player p, string itemName, integer count returns nothing
    local integer i = 0
    local integer added = 0
    local unit u
    local item it
    local real x
    local real y
    local string name
    local integer exactId = 0
    local integer pinyinId = 0

    if count < 1 then
        set count = 1
    endif

    set u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif

    set x = GetUnitX(u)
    set y = GetUnitY(u)

    // 第一遍：精确匹配
    loop
        exitwhen i >= ib_itemCount or exactId != 0
        set name = IB_StripColorCodes(GetObjectName(ib_itemList[i]))
        if name == itemName then
            set exactId = ib_itemList[i]
        endif
        set i = i + 1
    endloop

    // 第二遍：拼音首字母匹配（取第一个）
    if exactId == 0 then
        set i = 0
        loop
            exitwhen i >= ib_itemCount or pinyinId != 0
            set name = IB_StripColorCodes(GetObjectName(ib_itemList[i]))
            if PY_Matches(name, itemName) then
                set pinyinId = ib_itemList[i]
            endif
            set i = i + 1
        endloop
    endif

    if exactId != 0 then
        set pinyinId = exactId
    endif

    if pinyinId == 0 then
        call IB_Message(p, "未找到装备 \"" + itemName + "\"")
        set u = null
        return
    endif

    loop
        exitwhen added >= count
        set it = CreateItem(pinyinId, x, y)
        if it != null then
            if not UnitAddItem(u, it) then
                call SetItemPosition(it, x, y)
            endif
            set added = added + 1
        endif
        set it = null
    endloop

    call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + IB_StripColorCodes(GetObjectName(pinyinId)) + "\"")
    set u = null
endfunction

//---------------------------------------------------------------------------
// 按上次搜索结果序号添加装备（1-based）
//---------------------------------------------------------------------------
function IB_AddByIndex takes player p, integer index, integer count returns nothing
    local unit u
    local item it
    local real x
    local real y
    local integer added = 0
    local integer itemId

    if ib_lastResultCount == 0 then
        call IB_Message(p, "请先搜索装备（search <关键词>）")
        return
    endif
    if index < 1 or index > ib_lastResultCount then
        call IB_Message(p, "序号超出范围（1-" + I2S(ib_lastResultCount) + "）")
        return
    endif

    set u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif

    set itemId = ib_lastResult[index - 1]
    set x = GetUnitX(u)
    set y = GetUnitY(u)

    if count < 1 then
        set count = 1
    endif

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

    call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + IB_StripColorCodes(GetObjectName(itemId)) + "\"")
    set u = null
endfunction

//---------------------------------------------------------------------------
// 判断字符串是否全为数字
//---------------------------------------------------------------------------
function IB_IsAllDigits takes string s returns boolean
    local integer i = 0
    local integer len = StringLength(s)
    local string ch

    if len == 0 then
        return false
    endif
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9" then
            // ok
        else
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

//---------------------------------------------------------------------------
// 解析 additem 参数：
//   "名称"            -> 按名称添加
//   "名称 数量"       -> 按名称添加 n 个
//   "序号"            -> 添加搜索结果中第 n 件
//   "序号 数量"       -> 添加搜索结果中第 n 件 n 个
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
        set isNum = IB_IsAllDigits(numStr)
        if isNum then
            set itemName = SubString(arg, 0, lastSpace)
            set count = S2I(numStr)
        else
            set itemName = arg
        endif
    else
        set itemName = arg
    endif

    // 纯数字参数 → 按序号添加
    if IB_IsAllDigits(itemName) then
        call IB_AddByIndex(p, S2I(itemName), count)
    else
        call IB_AddItem(p, itemName, count)
    endif
endfunction

//---------------------------------------------------------------------------
// 解析聊天命令
//---------------------------------------------------------------------------
function IB_OnChat takes nothing returns boolean
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
        call IB_Message(p, "search <关键词/拼音>  搜索装备（如 search xxmz）")
        call IB_Message(p, "additem <序号> [数量]  添加搜索结果中的装备")
        call IB_Message(p, "additem <拼音> [数量]  按拼音首字母添加（如 additem xxmz）")
    endif
    return false
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
//---------------------------------------------------------------------------
function IB_RegisterChat takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "", false)
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(function IB_OnChat))
    set t = null
endfunction

//---------------------------------------------------------------------------
// 物品列表初始化
//---------------------------------------------------------------------------
function IB_InitItemCharMap takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i >= 62
        if i <= 9 then
            set ib_charMap[i] = i + 48
        elseif i <= 35 then
            set ib_charMap[i] = i + 55
        else
            set ib_charMap[i] = i + 61
        endif
        set i = i + 1
    endloop
endfunction

function IB_EnumD takes nothing returns nothing
    local integer i = 0
    local item it
    loop
        set it = CreateItem(ib_idA + ib_idB + ib_idC + ib_charMap[i], 0, 0)
        if it != null then
            set ib_itemList[ib_itemCount] = GetItemTypeId(it)
            set ib_itemCount = ib_itemCount + 1
        endif
        call RemoveItem(it)
        exitwhen i == 61
        set i = i + 1
    endloop
    set it = null
endfunction

function IB_EnumC takes nothing returns nothing
    set ib_idC = 256 * ib_charMap[ib_iC]
    set ib_iC = ib_iC + 1
    if ib_iC == 62 then
        call PauseTimer(ib_timerC)
        call DestroyTimer(ib_timerC)
        set ib_iC = 0
    endif
    call IB_EnumD()
endfunction

function IB_EnumB takes nothing returns nothing
    set ib_idB = 256 * 256 * ib_charMap[ib_iB]
    set ib_iB = ib_iB + 1
    if ib_iB == 62 then
        call PauseTimer(ib_timerB)
        call DestroyTimer(ib_timerB)
        set ib_iB = 0
    endif
    set ib_timerC = CreateTimer()
    call TimerStart(ib_timerC, 0.0005, true, function IB_EnumC)
endfunction

function IB_EnumA takes nothing returns nothing
    set ib_idA = 256 * 256 * 256 * ib_charMap[ib_iA]
    set ib_iA = ib_iA + 1
    if ib_iA == 62 then
        call PauseTimer(ib_timerA)
        call DestroyTimer(ib_timerA)
        set ib_iA = 0
        call IB_Message(GetLocalPlayer(), "装备列表加载完成，共 " + I2S(ib_itemCount) + " 件")
        call IB_RegisterChat()
    endif
    set ib_timerB = CreateTimer()
    call TimerStart(ib_timerB, 0.0322, true, function IB_EnumB)
endfunction

//---------------------------------------------------------------------------
// 入口
//---------------------------------------------------------------------------
function IB_Init takes nothing returns nothing
    call IB_InitItemCharMap()
    call PY_InitTable()
    set ib_iA = 0
    set ib_iB = 0
    set ib_iC = 0
    set ib_itemCount = 0
    set ib_timerA = CreateTimer()
    call TimerStart(ib_timerA, 2.0, true, function IB_EnumA)
endfunction
