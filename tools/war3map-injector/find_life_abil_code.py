"""Find base ability codes by comment/name in game abilitydata.slk."""
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
col_code = None
col_comment = None
for x, v in hdr.items():
    if v == "code":
        col_code = x
    if v == "comments":
        col_comment = x
print("code col", col_code, "comment col", col_comment)

# list all item abilities (race=other, sort=item) with their code
for y in sorted(rows):
    r = rows[y]
    aid = r.get(1, "")
    code = r.get(col_code, "") if col_code else ""
    cm = r.get(col_comment, "") if col_comment else ""
    if code in ("AIml", "AImi", "AIlf", "AIl1", "AIl2", "AImh", "AIlz"):
        print("%s code=%s comment=%s" % (aid, code, cm))
