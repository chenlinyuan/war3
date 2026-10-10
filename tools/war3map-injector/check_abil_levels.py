"""Check the 'levels' (and key fields) of item abilities in the game abilitydata.slk."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
t = open(os.path.join(GAME, "abilitydata.slk"), encoding="latin-1").read()
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
col = {v: k for k, v in hdr.items()}
print("cols:", {k: col.get(k) for k in ["alias", "code", "levels", "reqLevel", "DataA1", "DataB1", "DataC1", "DataD1", "DataE1"]})

for a in sys.argv[1:] or ["AIlf", "AIl1", "AIl2", "AIlz", "AImh", "AIms", "Arel", "AIrm", "AIsr", "AIad", "Aspb"]:
    r = None
    for y in rows:
        if rows[y].get(1) == a:
            r = rows[y]
            break
    if not r:
        print("%-6s MISSING" % a)
        continue
    def g(name):
        c = col.get(name)
        return r.get(c) if c else None
    print("%-6s levels=%s reqLevel=%s DataA1=%s DataB1=%s DataC1=%s DataD1=%s DataE1=%s" % (
        a, g("levels"), g("reqLevel"), g("DataA1"), g("DataB1"), g("DataC1"), g("DataD1"), g("DataE1")))
