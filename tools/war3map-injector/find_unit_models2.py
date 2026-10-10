"""Find unit model file paths from unitui.slk."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
t = open(os.path.join(GAME, "unitui.slk"), encoding="latin-1").read()
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
col_file = None
for x, v in hdr.items():
    if v == "file":
        col_file = x
print("file col", col_file)

for a in sys.argv[1:] or ["nadr", "nbwm", "nrwm", "hphx", "hdhw", "hgry", "ehpr"]:
    for y in rows:
        if rows[y].get(1) == a:
            print("%-6s file=%s" % (a, rows[y].get(col_file)))
            break
