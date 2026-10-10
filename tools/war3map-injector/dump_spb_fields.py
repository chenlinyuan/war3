"""Dump spellbook (spb*) metadata fields."""
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

for y in sorted(rows):
    r = rows[y]
    fid = r.get(1, "")
    if fid.startswith("spb") or fid in ("aare", "atat", "ata0", "atac", "aefs", "aeat", "acat", "acap"):
        print("%-6s | %-22s | display=%s | type=%s | data=%s" % (
            fid, r.get(2, ""), r.get(8, ""), r.get(10, ""), r.get(6, "")))
