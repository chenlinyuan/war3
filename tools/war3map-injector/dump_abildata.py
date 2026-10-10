"""Parse abilitydata.slk for wing abilities (A006, A008, A0CT, A0CV, A08O, Arll)."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def parse_slk(path):
    t = open(path, encoding="latin-1").read()
    rows = {}
    cur_x = cur_y = None
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
    p = os.path.join(SJ, "units", "abilitydata.slk")
    rows = parse_slk(p)
    print("rows", len(rows))
    hdr = rows.get(1, {})
    colnames = {v: k for k, v in hdr.items()}
    idcol = colnames.get("alias") or colnames.get("abilityID") or 1
    print("id col", idcol, "cols:", list(hdr.values()))

    targets = ["A006", "A008", "A0CT", "A0CV", "A08O", "Arll", "A00D", "A001", "AId3", "A005", "A004"]
    for y in sorted(rows):
        r = rows[y]
        iid = r.get(idcol, "")
        if iid in targets:
            print("=== %s ===" % iid)
            for x, v in sorted(r.items()):
                print("   %s = %s" % (hdr.get(x, x), v))


if __name__ == "__main__":
    main()
