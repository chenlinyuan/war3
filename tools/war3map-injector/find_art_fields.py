"""Find ability metadata field IDs for art/attachment fields."""
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

want = ("TargetArt", "Targetattach", "Targetattachcount", "Art", "EffectArt",
        "CasterArt", "Casterattach", "Targetattach1", "SpecialArt", "MissileArt")
for y in sorted(rows):
    r = rows[y]
    nm = r.get(2, "")
    if nm in want:
        print("%s = %-20s slk=%s idx=%s type=%s" % (r.get(1), nm, r.get(3), r.get(4), r.get(10)))
