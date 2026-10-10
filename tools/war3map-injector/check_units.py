"""Check which unit IDs exist in the game's unitdata.slk."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
t = open(os.path.join(GAME, "unitdata.slk"), encoding="latin-1").read()
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

print("total units:", len(ids))
for a in sys.argv[1:] or ["hphx", "h01D", "n02L", "n02M", "n02P", "u00K"]:
    print("%-6s %s" % (a, "EXISTS" if a in ids else "*** MISSING ***"))

# also list some phoenix/dragon units
print("--- phoenix/dragon-like units ---")
for i in sorted(ids):
    if i in ("hphx", "hpxe", "n01S", "n02L", "n02M", "n02N", "n02P", "u00K", "hdhw", "hgry", "ehpr"):
        print("  ", i)
