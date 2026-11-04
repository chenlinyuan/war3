"""扫一张地图，看有没有被"改图/作弊"注入过的痕迹（只读，不改地图）。

用法:
    python scan_map_cheat.py <地图路径>

检查项:
  * war3map.j 大小与常见作弊脚本特征（HKE / YD / 55YOU / 作弊 / 无敌 / additem ...）
  * 聊天命令数量（作弊菜单通常几十个 chat 事件）
  * 脚本里是否存在本工程的注入标记（IB_Init = 装备浏览器, WG_Init = 翅膀/坐骑）
  * 对象数据里是否有可疑的自定义物品/单位/技能名（作弊/无敌/属性/钱木 ...）
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402

MARKERS = [
    ("作弊", "作弊"), ("无敌", "无敌"), ("秒杀", "秒杀"), ("全属性", "全属性"),
    ("刷物品", "刷物品"), ("钱木", "钱木"), ("金钱", "金钱"), ("木材", "木材"),
    ("god", "god"), ("cheat", "cheat"), ("suffer", "suffer"), ("additem", "additem"),
    ("hke", "hke"), ("ydwe", "ydwe"), ("YDAPI", "YDAPI"), ("japi", "japi"),
    ("DzAPI", "DzAPI"), ("whosyourdaddy", "whosyourdaddy"), ("iseedeadpeople", "iseedeadpeople"),
    ("IB_Init", "本工程:装备浏览器"), ("WG_Init", "本工程:翅膀/坐骑"),
    ("BlzSetUnitMaxHP", "Blz* 新 API"),
]


def main():
    path = sys.argv[1]
    a = W.MPQArchive(path)
    try:
        data = a.read_file("war3map.j")
        names = a.listfile
        print("内部文件列表条目:", len(names))
    finally:
        a.close()
    if not data:
        print("读不到 war3map.j")
        return 1
    print("war3map.j 大小: %d 字节" % len(data))
    text = data.decode("utf-8", "replace")
    low = text.lower()
    print("\n== 特征字串 ==")
    for pat, label in MARKERS:
        n = low.count(pat.lower())
        if n:
            print("   %-22s %d 处" % (label, n))
    print("\n== 聊天命令注册数 (TriggerRegisterPlayerChatEvent) ==")
    print("   ", len(re.findall(r"TriggerRegisterPlayerChatEvent", text)))
    cmds = sorted(set(re.findall(r'TriggerRegisterPlayerChatEvent\([^,]+,[^,]+,\s*"([^"]{1,24})"', text)))
    print("   命令样例:", ", ".join(cmds[:40]) if cmds else "(无)")
    print("\n== 函数数量 ==")
    print("   function 定义:", len(re.findall(r"^function ", text, re.M)))
    # 找一些可疑的行
    print("\n== 可疑行样例 ==")
    shown = 0
    for m in re.finditer(r"^.*(作弊|无敌|秒杀|全属性|whosyourdaddy|iseedeadpeople|suffer).*$",
                         text, re.M | re.I):
        line = m.group(0).strip()
        if len(line) < 200:
            print("   ", line[:160])
            shown += 1
            if shown >= 12:
                break
    return 0


if __name__ == "__main__":
    sys.exit(main())
