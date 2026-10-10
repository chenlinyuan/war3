"""Find item abilities with NO target but with a real cast (instant use)."""
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
cast1 = col.get("Cast1")

print("id     code  comment                        targs1  Cast1")
for y in sorted(rows):
    r = rows[y]
    if r.get(sort) == "item" and r.get(targs1) == "_" and r.get(cast1) and r.get(cast1) not in ("-", ""):
        print("%-6s %-5s %-30s %s  %s" % (r.get(1), r.get(code), r.get(comments, ""), r.get(targs1), r.get(cast1)))
