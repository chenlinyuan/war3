"""导出游戏所有"物品技能"ID (abilitydata.slk 中 X8=item)。

输出 _itemabil.txt: 每行一个 4 字符技能 ID。
用于运行时判断某技能是否为物品技能(不应移除)。
"""
import os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from dump_ability import parse_slk, SLK

HERE = os.path.dirname(os.path.abspath(__file__))


def main():
    rows = parse_slk(SLK)
    ids = []
    for y, r in rows.items():
        iid = r.get(1)
        if iid and len(iid) == 4 and r.get(8) == "item":
            ids.append(iid)
    ids = sorted(set(ids))
    out = os.path.join(HERE, "_itemabil.txt")
    with open(out, "w", encoding="utf-8") as fh:
        for i in ids:
            fh.write(i + "\n")
    print("wrote %s: %d 物品技能" % (out, len(ids)))


if __name__ == "__main__":
    main()
