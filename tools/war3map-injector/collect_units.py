"""收集地图中可用作变身目标的单位 ID + 名称 + 护甲类型。

来源:
  1. 地图 units/unitbalance.slk (defType 列 = 护甲类型)
  2. 地图 units/campaignunitfunc.txt / unitfunc.txt (单位名)

输出 _unitids.txt: id<TAB>name<TAB>armor
"""
import re, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))


def parse_balance(path):
    """返回 {unitId: armorType}"""
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
        if 1 in r and 34 in r and len(r[1]) == 4:
            out[r[1]] = r[34]
    return out


def parse_names(path):
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
    map_dir = sys.argv[1] if len(sys.argv) > 1 else None
    if not map_dir:
        print("用法: collect_units.py <解包目录>")
        return 1
    up = os.path.join(map_dir, "units")
    bal = os.path.join(up, "unitbalance.slk")
    if not os.path.isfile(bal):
        print("未找到 unitbalance.slk")
        return 1
    armor = parse_balance(bal)
    names = {}
    for fn in ("campaignunitfunc.txt", "unitfunc.txt"):
        p = os.path.join(up, fn)
        if os.path.isfile(p):
            for k, v in parse_names(p).items():
                names[k] = v
    out = os.path.join(HERE, "_unitids.txt")
    with open(out, "w", encoding="utf-8") as fh:
        for uid in sorted(armor):
            fh.write("%s\t%s\t%s\n" % (uid, names.get(uid, ""), armor[uid]))
    print("wrote %s: %d 单位" % (out, len(armor)))
    # 统计护甲类型
    from collections import Counter
    c = Counter(armor.values())
    for k, v in c.most_common():
        print("  %-10s %d" % (k, v))
    return 0


if __name__ == "__main__":
    sys.exit(main())
