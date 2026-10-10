"""Find powerup item abilities (code=AImi etc)."""
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
print("cols:", {k: col.get(k) for k in ["alias", "code", "comments", "sort", "targs1", "levels", "reqLevel"]})
for y in sorted(rows):
    r = rows[y]
    if r.get(col.get("code")) in ("AImi", "AIa1", "AIa2", "AIa3", "AIa4", "AIa5", "AIa6", "AIx1", "AIx2"):
        print("%-6s code=%-5s %-30s sort=%s targs1=%s" % (
            r.get(1), r.get(col.get("code")), r.get(col.get("comments"), ""),
            r.get(col.get("sort")), r.get(col.get("targs1"))))
