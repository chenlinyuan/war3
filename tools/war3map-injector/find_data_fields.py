"""Find data field IDs for common item abilities."""
import re, os

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
t = open(os.path.join(GAME, "abilitymetadata.slk"), encoding="latin-1").read()
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

# print all fields whose category is AbilityData and id starts with I (item abilities)
for y in sorted(rows):
    r = rows[y]
    fid = r.get(1, "")
    nm = r.get(2, "")
    slk = r.get(3, "")
    if slk == "AbilityData" and fid[:1] in ("I",):
        print("%-6s %-24s idx=%s type=%s" % (fid, nm, r.get(4), r.get(10)))
