"""List candidate flying units for mounts from the game's unit data."""
import re, os

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"


def load_slk(name):
    t = open(os.path.join(GAME, name), encoding="latin-1").read()
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
    return rows


def load_strings(name):
    t = open(os.path.join(GAME, name), encoding="utf-8", errors="replace").read()
    out = {}
    cur = None
    for ln in t.splitlines():
        m = re.match(r"^\[([^\]]+)\]", ln)
        if m:
            cur = m.group(1)
            out[cur] = {}
        elif cur and "=" in ln:
            k, v = ln.split("=", 1)
            out[cur][k.strip()] = v.strip()
    return out


rows = load_slk("unitdata.slk")
hdr = rows.get(1, {})
col_name = None
for x, v in hdr.items():
    if v == "Name":
        col_name = x
# unitdata.slk has no Name; use unitui/unitstrings. Just print ids with move type fly
col_movetp = None
for x, v in hdr.items():
    if v == "movetp":
        col_movetp = x
print("movetp col", col_movetp)
fly = []
for y in sorted(rows):
    r = rows[y]
    uid = r.get(1, "")
    if uid and col_movetp and r.get(col_movetp, "").lower() == "fly":
        fly.append(uid)
print("flying units:", len(fly))
print(" ".join(fly))
