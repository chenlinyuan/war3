"""Find the Data column index (A=1,B=2,...) for ability data fields."""
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

hdr = rows.get(1, {})
# columns: 1=id 2=field 3=slk 4=index 5=repeat 6=data 7=category 8=displayName 9=sort
# Data fields have slk=AbilityData, index=column-1 (0-based)
for y in sorted(rows):
    r = rows[y]
    fid = r.get(1, "")
    if fid in sys.argv[1:] or (not sys.argv[1:] and fid in (
            "Ilif", "Imvb", "Ihpr", "Imrp", "isr1", "isr2", "Had1", "Iatt", "Isx1", "Ear1")):
        print("%-6s field=%-20s slk=%s index=%s repeat=%s type=%s" % (
            fid, r.get(2, ""), r.get(3, ""), r.get(4, ""), r.get(5, ""), r.get(10, "")))
