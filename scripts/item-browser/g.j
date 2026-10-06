//============================================================================
// ITEM BROWSER - 全局变量
//============================================================================

// 物品 ID 列表（注入时预扫描硬编码）
integer array ib_itemList
// 物品名称列表（注入时预扫描硬编码，避免依赖 GetObjectName）
string array ib_itemName
// 是否自定义物品（1=自定义, 0=原版）
integer array ib_itemCustom
integer ib_itemCount = 0

// 初始化填充状态（分帧调用 IB_FillN，避免 main 阶段单次执行超操作数上限）
integer ib_fillIdx = 0
integer ib_fillTotal = 0
timer ib_fillTimer = null

// 聊天注册分帧（避免一次注册过多聊天事件而失败）
timer ib_regTimer = null

// 搜索状态（分帧扫描，避免单次执行超操作数上限）
integer ib_searchIdx = 0
integer ib_searchFound = 0
string ib_searchKey = ""
string ib_searchStd = ""
string ib_searchCus = ""
integer ib_searchStdN = 0
integer ib_searchCusN = 0
player ib_searchPlayer = null
timer ib_searchTimer = null

// 添加状态（分帧扫描，避免单次执行超操作数上限）
integer ib_addIdx = 0
integer ib_addCount = 1
string ib_addName = ""
integer ib_addFoundId = 0
integer ib_addFoundIdx = -1
player ib_addPlayer = null
timer ib_addTimer = null

//---------------------------------------------------------------------------
// 技能系统（给选中英雄添加/移除技能）
//---------------------------------------------------------------------------
// 技能 ID 列表（注入时预扫描硬编码）
integer array ib_skillList
// 技能名称列表（注入时预扫描硬编码，UTF-8）
string array ib_skillName
// 技能是否自定义（1=自定义, 0=标准）
integer array ib_skillCustom
integer ib_skillCount = 0

// 技能填充状态（分帧调用 IB_SkillFillN）
integer ib_skFillIdx = 0
integer ib_skFillTotal = 0
timer ib_skFillTimer = null

// 技能搜索状态（分帧扫描）
integer ib_skSearchIdx = 0
string ib_skSearchKey = ""
string ib_skSearchStd = ""
string ib_skSearchCus = ""
integer ib_skSearchStdN = 0
integer ib_skSearchCusN = 0
player ib_skSearchPlayer = null
timer ib_skSearchTimer = null

// 添加技能状态（分帧扫描）
integer ib_skAddIdx = 0
string ib_skAddName = ""
integer ib_skAddFoundId = 0
integer ib_skAddFoundIdx = -1
integer ib_skAddLevel = 1
player ib_skAddPlayer = null
timer ib_skAddTimer = null

// 移除技能状态（分帧扫描）
integer ib_skRemIdx = 0
string ib_skRemName = ""
integer ib_skRemFoundId = 0
player ib_skRemPlayer = null
timer ib_skRemTimer = null

// 设置技能等级状态（分帧扫描）
integer ib_skSetIdx = 0
string ib_skSetName = ""
integer ib_skSetFoundId = 0
integer ib_skSetFoundIdx = -1
integer ib_skSetLevel = 1
player ib_skSetPlayer = null
timer ib_skSetTimer = null

// 移除全部技能状态（分帧扫描技能列表）
integer ib_skClrIdx = 0
integer ib_skClrCount = 0
player ib_skClrPlayer = null
unit ib_skClrUnit = null
timer ib_skClrTimer = null


//---------------------------------------------------------------------------
// 致命一击系统（自定义暴击）
//---------------------------------------------------------------------------
// 携带暴击的单位集合（用 unit group 注册，无需修改地图对象数据）
group ib_critGroup = null
// 已注册伤害事件的单位集合（避免重复注册）
group ib_critRegGroup = null
// 伤害事件触发器（为每个单位单独注册 EVENT_UNIT_DAMAGED）
trigger ib_critDmgTrig = null
// 是否启用暴击系统
boolean ib_critEnabled = true
// 攻击者/目标标记（用于把暴击限定在普通攻击上）
unit ib_critAttacker = null
unit ib_critTarget = null
boolean ib_critArmed = false
// 重入保护（额外伤害会再次触发伤害事件）
boolean ib_critBusy = false
// 统计
integer ib_critCount = 0
integer ib_critLastMult = 0

//---------------------------------------------------------------------------
// 单位系统（给玩家添加/删除单位）
//---------------------------------------------------------------------------
// 单位 ID 列表（注入时预扫描硬编码）
integer array ib_unitList
// 单位名称列表（注入时预扫描硬编码）
string array ib_unitName
// 单位名称的 GBK 字节版本（用于匹配游戏聊天输入的 GBK 编码）
string array ib_unitNameGbk
// 单位护甲类型（hero/large/medium/small/fort/none/divine）
string array ib_unitArmor
integer ib_unitCount = 0

// 单位填充状态（分帧调用 IB_UnitFillN）
integer ib_unFillIdx = 0
integer ib_unFillTotal = 0
timer ib_unFillTimer = null

// 单位搜索状态（分帧扫描）
integer ib_unSearchIdx = 0
string ib_unSearchKey = ""
string ib_unSearchOut = ""
integer ib_unSearchN = 0
player ib_unSearchPlayer = null
timer ib_unSearchTimer = null

// 添加单位状态（分帧扫描找匹配）
integer ib_unAddIdx = 0
string ib_unAddName = ""
integer ib_unAddFoundId = 0
integer ib_unAddFoundIdx = -1
player ib_unAddPlayer = null
timer ib_unAddTimer = null

// 删除单位状态（分帧扫描找匹配）
integer ib_unRemIdx = 0
string ib_unRemName = ""
integer ib_unRemFoundId = 0
integer ib_unRemFoundIdx = -1
player ib_unRemPlayer = null
timer ib_unRemTimer = null

//---------------------------------------------------------------------------
// 死亡之指（秒杀任意单位，含魔免）
//---------------------------------------------------------------------------
// 秒杀伤害值（用 UNIVERSAL 伤害类型绕过魔免与护甲）
real ib_fingerDamage = 1000000.0
// 统计
integer ib_fingerCount = 0




