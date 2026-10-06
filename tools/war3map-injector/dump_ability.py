"""读取 abilitydata.slk 中某个技能的字段，用于对照 w3a 字段。"""
import re, sys

SLK = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\abilitydata.slk"


def parse_slk(path):
    t = open(path, "rb").read().decode("utf-8", "replace")
    cur_x = 1
    cur_y = 1
    rows = {}
    for m in re.finditer(r'C;([^K]*);K"((?:[^"]|"")*)"', t):
        coords = m.group(1)
        val = m.group(2).replace('""', '"')
        xm = re.search(r"X(\d+)", coords)
        ym = re.search(r"Y(\d+)", coords)
        if xm:
            cur_x = int(xm.group(1))
        if ym:
            cur_y = int(ym.group(1))
        rows.setdefault(cur_y, {})[cur_x] = val
    return rows


if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "ANfd"
    rows = parse_slk(SLK)
    for y, r in rows.items():
        if r.get(1) == target:
            for x in sorted(r):
                print("X%d = %r" % (x, r[x]))
            break
