"""Rebuild scripts/item-browser/f.j by embedding the item ID list.

Reads item IDs from _itemids.txt and regenerates the body of IB_Init
(between `function IB_Init ...` and the first `call IB_Message(GetLocalPlayer()`).
Works whether or not a list is already embedded.
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))
FJ = os.path.join(REPO, "scripts", "item-browser", "f.j")

# Read item IDs
ids = []
with open(os.path.join(HERE, "_itemids.txt"), encoding="utf-8") as fh:
    for line in fh:
        iid = line.split("\t")[0].strip()
        if len(iid) == 4:
            ids.append(iid)

# Build the list lines
list_lines = ["    set ib_itemCount = 0"]
for i, iid in enumerate(ids):
    list_lines.append("    set ib_itemList[%d] = '%s'" % (i, iid))
list_lines.append("    set ib_itemCount = %d" % len(ids))
item_block = "\n".join(list_lines)

with open(FJ, encoding="utf-8") as fh:
    txt = fh.read()

pattern = re.compile(
    r"(function IB_Init takes nothing returns nothing\n)(.*?)(    call IB_Message\(GetLocalPlayer\(\))",
    re.S)
if not pattern.search(txt):
    raise SystemExit("IB_Init block not found in f.j")

txt = pattern.sub(lambda m: m.group(1) + item_block + "\n" + m.group(3), txt)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items into %s" % (len(ids), FJ))
