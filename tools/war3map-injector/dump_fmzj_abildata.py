"""Dump the 伏魔战记 map's abilitydata.slk entries for wing abilities."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")
t = open(os.path.join(SJ, "units", "abilitydata.slk"), encoding="latin-1").read()
rows = {}
cx = cy = None
for m in re.finditer(r'C;((?:[XY]\d+;)*)K"((?:[^"]|"")*)"', t):
    coords = m.group(1)
    val = m.group(2).replace('""', '"')
    for c in coords.split(";"):
        if not c:
            continue
        if c[0] == "Y":
            cy = int(c[1:])
        elif c[0] == "X":
            cx = int(c[1:])
    rows.setdefault(cy, {})[cx] = val

hdr = rows.get(1, {})
byid = {}
for y in rows:
    if rows[y].get(1):
        byid[rows[y][1]] = rows[y]

for a in sys.argv[1:] or ["A006", "A008", "A00D", "A0CT", "A001", "A003", "A007"]:
    r = byid.get(a)
    print("=== %s ===" % a)
    if r:
        for x, v in sorted(r.items()):
            if v:
                print("   %s = %s" % (hdr.get(x, x), v))
    else:
        print("   (not in map abilitydata)")
