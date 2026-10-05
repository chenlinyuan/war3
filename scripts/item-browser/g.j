//============================================================================
// ITEM BROWSER - 全局变量
//============================================================================

// 物品列表
integer array ib_itemList
integer ib_itemCount = 0

// 字符映射（0-9, A-Z, a-z）
integer array ib_charMap

// ID 枚举状态
integer ib_iA
integer ib_iB
integer ib_iC
integer ib_idA
integer ib_idB
integer ib_idC

// 计时器
timer ib_timerA
timer ib_timerB
timer ib_timerC

// 拼音首字母映射表（索引 0-22 对应 a-z 分组）
string array py_map
boolean py_ready = false

// 最近一次搜索结果（用于序号选择）
integer array ib_lastResult
integer ib_lastResultCount = 0
