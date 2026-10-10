"""Check which base ability codes exist in the game's abilitydata.slk."""
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

ids = set()
for y in rows:
    if rows[y].get(1):
        ids.add(rows[y][1])

for a in sys.argv[1:] or ["AIml", "AImi", "AIms", "Arel", "AIrm", "AIsr", "AIad", "Aspb", "Arll", "AHad", "AIsx", "AIar", "AIat"]:
    print("%-6s %s" % (a, "EXISTS" if a in ids else "*** MISSING ***"))
