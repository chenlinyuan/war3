"""Parse itemdata.slk and abilitydata.slk for wing items/abilities."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def parse_slk(path):
    """Minimal SLK parser: returns list of dicts keyed by column header."""
    t = open(path, encoding="latin-1").read()
    rows = {}  # y -> {x: value}
    headers = {}
    cur_x = cur_y = None
    for cell in re.finditer(r'([CK])\s*;\s*([^;]*?)\s*;?\s*(?=[CK];|$)', t):
        pass
    # simpler: split on ';' tokens
    # SLK cells: C;Y1;X1;K"id"  (Y sets row, X sets col)
    for m in re.finditer(r'C;((?:[XY]\d+;)*)K"((?:[^"]|"")*)"', t):
        coords = m.group(1)
        val = m.group(2).replace('""', '"')
        for c in coords.split(";"):
            if not c:
                continue
            if c[0] == "Y":
                cur_y = int(c[1:])
            elif c[0] == "X":
                cur_x = int(c[1:])
        rows.setdefault(cur_y, {})[cur_x] = val
    return rows


def main():
    p = os.path.join(SJ, "units", "itemdata.slk")
    rows = parse_slk(p)
    print("rows", len(rows))
    # header row is Y=1
    hdr = rows.get(1, {})
    print("header cols", len(hdr))
    # find col of itemID and abilityList
    colnames = {v: k for k, v in hdr.items()}
    print("itemID col", colnames.get("itemID"), "abilList col", colnames.get("abilList"))

    idcol = colnames.get("itemID")
    abilcol = colnames.get("abilList")
    for y in sorted(rows):
        r = rows[y]
        iid = r.get(idcol, "")
        if iid in ("I04S", "I04P", "I04Q", "I04N", "I04R", "I02I"):
            print("=== %s ===" % iid)
            for x, v in sorted(r.items()):
                print("   %s = %s" % (hdr.get(x, x), v))


if __name__ == "__main__":
    main()
