"""Rebuild scripts/item-browser/f.j by embedding the item ID + name list.

Reads _itemids.txt (id<TAB>name) and regenerates the body of IB_Init
(between `function IB_Init ...` and the first `call IB_Message(GetLocalPlayer()`).
Embeds both ib_itemList[i] (ID) and ib_itemName[i] (name), so search does not
depend on GetObjectName (which may return empty for custom items).
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))
FJ = os.path.join(REPO, "scripts", "item-browser", "f.j")

# Read item IDs + names
items = []
with open(os.path.join(HERE, "_itemids.txt"), encoding="utf-8") as fh:
    for line in fh:
        parts = line.rstrip("\n").split("\t")
        iid = parts[0].strip()
        nm = parts[1].strip() if len(parts) > 1 else ""
        if len(iid) == 4:
            items.append((iid, nm))


def jass_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"')


# Split into chunks to avoid War3's per-function statement limit.
CHUNK = 80
chunks = [items[i:i + CHUNK] for i in range(0, len(items), CHUNK)]

chunk_funcs = []
for ci, chunk in enumerate(chunks):
    lines = ["function IB_Fill%d takes nothing returns nothing" % ci]
    for k, (iid, nm) in enumerate(chunk):
        idx = ci * CHUNK + k
        lines.append("    set ib_itemList[%d] = '%s'" % (idx, iid))
        lines.append('    set ib_itemName[%d] = "%s"' % (idx, jass_escape(nm)))
    lines.append("endfunction")
    chunk_funcs.append("\n".join(lines))

# IB_Init calls each chunk function
init_body = ["function IB_Init takes nothing returns nothing", "    set ib_itemCount = 0"]
for ci in range(len(chunks)):
    init_body.append("    call IB_Fill%d()" % ci)
init_body.append("    set ib_itemCount = %d" % len(items))
init_block = "\n".join(init_body)

# Insert chunk functions right before IB_Init, and replace IB_Init body.
with open(FJ, encoding="utf-8") as fh:
    txt = fh.read()

pattern = re.compile(
    r"(function IB_Init takes nothing returns nothing\n)(.*?)(    call IB_Message\(GetLocalPlayer\(\))",
    re.S)
if not pattern.search(txt):
    raise SystemExit("IB_Init block not found in f.j")

new_init = init_block + "\n" + pattern.search(txt).group(3)
txt = pattern.sub(lambda m: new_init, txt)

# Insert chunk functions before IB_Init
marker = "function IB_Init takes nothing returns nothing"
txt = txt.replace(marker, "\n".join(chunk_funcs) + "\n\n" + marker, 1)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items (id+name) in %d chunks into %s" % (len(items), len(chunks), FJ))
