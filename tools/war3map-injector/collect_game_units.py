"""收集游戏标准单位 ID + 名称 + 护甲类型（用于官方地图如 Lost Temple）。

来源:
  1. 游戏 unitdata.slk (X1 = 单位 ID)
  2. 游戏 unitbalance.slk (X34 = 护甲类型 defType)
  3. 游戏各 races unitstrings.txt (单位名)

输出 _unitids.txt: id<TAB>name<TAB>armor
"""
import re, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
GAME_UNITS = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"

UNIT_STRINGS = [
    "humanunitstrings.txt",
    "orcunitstrings.txt",
    "undeadunitstrings.txt",
    "nightelfunitstrings.txt",
    "neutralunitstrings.txt",
    "campaignunitstrings.txt",
]


def parse_slk_col(path, col):
    """返回 {unitId: value}，col 为列号。"""
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
    out = {}
    for y in sorted(rows):
        r = rows[y]
        if 1 in r and col in r and len(r[1]) == 4:
            out[r[1]] = r[col]
    return out


def parse_strings(path):
    """从 unitstrings.txt 提取 {id: name}。"""
    t = open(path, "rb").read()
    for enc in ("utf-8", "gbk"):
        try:
            t = t.decode(enc)
            break
        except Exception:
            continue
    else:
        t = t.decode("latin-1")
    names = {}
    cur = None
    for line in t.splitlines():
        s = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", s)
        if m:
            cur = m.group(1)
            continue
        if cur and s.lower().startswith("name="):
            names[cur] = s.split("=", 1)[1]
            cur = None
    return names


def main():
    data_slk = os.path.join(GAME_UNITS, "unitdata.slk")
    bal_slk = os.path.join(GAME_UNITS, "unitbalance.slk")
    if not os.path.isfile(data_slk):
        print("未找到 unitdata.slk")
        return 1

    ids = parse_slk_col(data_slk, 1)  # 单位 ID 列表
    armor = parse_slk_col(bal_slk, 34)  # defType 护甲类型

    names = {}
    for fn in UNIT_STRINGS:
        p = os.path.join(GAME_UNITS, fn)
        if os.path.isfile(p):
            for k, v in parse_strings(p).items():
                names[k] = v

    out = os.path.join(HERE, "_unitids.txt")
    n = 0
    with open(out, "w", encoding="utf-8") as fh:
        for uid in sorted(ids):
            fh.write("%s\t%s\t%s\n" % (uid, names.get(uid, ""), armor.get(uid, "")))
            n += 1
    print("wrote %s: %d 单位" % (out, n))

    from collections import Counter
    c = Counter(armor.get(u, "") for u in ids)
    for k, v in c.most_common():
        print("  %-12s %d" % (k or "(无)", v))
    return 0


if __name__ == "__main__":
    sys.exit(main())
