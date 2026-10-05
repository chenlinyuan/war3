//============================================================================
// ITEM BROWSER - 全局变量
//============================================================================

// 物品 ID 列表（注入时预扫描硬编码）
integer array ib_itemList
// 物品名称列表（注入时预扫描硬编码，避免依赖 GetObjectName）
string array ib_itemName
integer ib_itemCount = 0

// 搜索状态（分帧扫描，避免单次执行超操作数上限）
integer ib_searchIdx = 0
integer ib_searchFound = 0
string ib_searchKey = ""
string ib_searchOut = ""
player ib_searchPlayer = null
timer ib_searchTimer = null
