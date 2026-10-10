"""For each item ability code, list its data field IDs from abilitymetadata.slk."""
import re, os, sys

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

# columns: 1=id 2=field 3=slk 4=index 6=data 10=type 23=useSpecific
targets = sys.argv[1:] or ["AIml", "AIsr", "AIms", "AIrm", "AImi", "Arel", "AIad", "AIat"]
for y in sorted(rows):
    r = rows[y]
    fid = r.get(1, "")
    spec = r.get(23, "")
    if spec and any(t in spec for t in targets):
        print("%-6s %-20s data=%s type=%s useSpecific=%s" % (
            fid, r.get(2, ""), r.get(6, ""), r.get(10, ""), spec))
