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

