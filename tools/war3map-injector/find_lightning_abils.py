"""Find item abilities that support lightning effects (alig field)."""
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

# find alig field's useSpecific
for y in sorted(rows):
    r = rows[y]
    if r.get(1) == "alig":
        print("alig field:", r.get(2), "useSpecific=", r.get(23))
        break

# now find item abilities that use alig
t2 = open(os.path.join(GAME, "abilitydata.slk"), encoding="latin-1").read()
rows2 = {}
cx = cy = None
for m in re.finditer(r'C;((?:[XY]\d+;)*)K"((?:[^"]|"")*)"', t2):
    coords = m.group(1)
    val = m.group(2).replace('""', '"')
    for c in coords.split(";"):
        if not c:
            continue
        if c[0] == "Y":
            cy = int(c[1:])
        elif c[0] == "X":
            cx = int(c[1:])
    rows2.setdefault(cy, {})[cx] = val

hdr = rows2.get(1, {})
col = {v: k for k, v in hdr.items()}
print("\nitem abilities with alig set:")
for y in sorted(rows2):
    r = rows2[y]
    if r.get(col.get("sort")) == "item" and r.get(col.get("alig")):
        print("  %s code=%s %s alig=%s" % (r.get(1), r.get(col.get("code")),
              r.get(col.get("comments"), ""), r.get(col.get("alig"))))
