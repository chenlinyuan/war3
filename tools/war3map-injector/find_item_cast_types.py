"""Show Cast1 (cast type) for all item abilities to find instant ones."""
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
seen = set()
for y in sorted(rows):
    r = rows[y]
    if r.get(col.get("sort")) != "item":
        continue
    cast = r.get(col.get("Cast1"))
    tg = r.get(col.get("targs1"))
    if cast and cast not in ("-", "") and cast not in seen:
        seen.add(cast)
        print("Cast1=%-3s targs1=%-30s e.g. %s (%s)" % (
            cast, tg, r.get(1), r.get(col.get("comments"), "")))
