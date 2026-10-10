"""Find Item Life Bonus ability code in the game abilitydata.slk."""
import re, os

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
p = os.path.join(GAME, "abilitydata.slk")
t = open(p, encoding="latin-1").read()

# Split into rows keyed by Y
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
col_comments = None
for x, v in hdr.items():
    if v == "comments":
        col_comments = x
print("comments col", col_comments)

for y in sorted(rows):
    r = rows[y]
    aid = r.get(1, "")
    cm = r.get(col_comments, "") if col_comments else ""
    if cm and ("life bonus" in cm.lower() or "mana bonus" in cm.lower()):
        print(aid, "->", cm)
