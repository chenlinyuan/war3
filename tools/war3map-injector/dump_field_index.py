"""Dump metadata (id, field, slk, index, repeat, type, useSpecific) for key data fields."""
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

# header
hdr = rows.get(1, {})
targets = sys.argv[1:] or ["Ilif", "Imvb", "Ihpr", "Imrp", "isr1", "Had1", "Iatt", "Isx1", "spb1", "spb5"]
for y in sorted(rows):
    r = rows[y]
    if r.get(1) in targets:
        print("%-6s field=%-20s slk=%s index=%s repeat=%s type=%s useSpecific=%s" % (
            r.get(1), r.get(2), r.get(3), r.get(4), r.get(5), r.get(10), r.get(23)))
