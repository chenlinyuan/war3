"""Find ACTIVE item abilities (those with a real targs1, i.e. castable)."""
import re, os

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
targs1 = col.get("targs1")
sort = col.get("sort")
code = col.get("code")
comments = col.get("comments")

print("id     code  comment                        targs1")
for y in sorted(rows):
    r = rows[y]
    if r.get(sort) == "item" and r.get(targs1) and r.get(targs1) != "_":
        print("%-6s %-5s %-30s %s" % (r.get(1), r.get(code), r.get(comments, ""), r.get(targs1)))
