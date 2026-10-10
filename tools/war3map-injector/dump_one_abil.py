"""Dump one ability from the game's abilitydata.slk."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
p = os.path.join(GAME, "abilitydata.slk")
t = open(p, encoding="latin-1").read()
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
targets = sys.argv[1:] or ["AIml"]
for y in sorted(rows):
    if rows[y].get(1) in targets:
        print("=== %s ===" % rows[y].get(1))
        for x, v in sorted(rows[y].items()):
            if v:
                print("   %s = %s" % (hdr.get(x, x), v))
