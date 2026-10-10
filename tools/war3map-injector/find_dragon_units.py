"""Find dragon/flying unit IDs in the game's unitdata.slk."""
import re, os

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

hdr = rows.get(1, {})
ids = []
for y in sorted(rows):
    uid = rows[y].get(1, "")
    if uid:
        ids.append(uid)

# candidate dragon/flying units
cands = ["n02L", "n02M", "n02N", "n02P", "u00K", "h01D", "hphx", "n01S",
         "nadr", "nadk", "nadw", "nazr", "nzdk", "nzdr", "nzep",
         "hdhw", "hgry", "ehpr", "nhrw", "nhrq", "nhyc", "nchp",
         "nrwm", "nwam", "nowb", "nowe", "nwgd", "nwgs", "nwgt"]
for c in cands:
    print("%-6s %s" % (c, "EXISTS" if c in ids else "*** MISSING ***"))
