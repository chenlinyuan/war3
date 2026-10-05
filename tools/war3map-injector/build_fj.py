"""Build scripts/item-browser/f.j by embedding the pre-scanned item ID list.

Reads the item IDs from _itemids.txt (parsed from the game's itemdata.slk)
and injects them into the IB_Init function, replacing the // __ITEM_LIST__ marker.
"""
import os

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
list_lines = []
for i, iid in enumerate(ids):
    list_lines.append("    set ib_itemList[%d] = '%s'" % (i, iid))
list_lines.append("    set ib_itemCount = %d" % len(ids))
item_block = "\n".join(list_lines)

with open(FJ, encoding="utf-8") as fh:
    txt = fh.read()

if "// __ITEM_LIST__" not in txt:
    raise SystemExit("marker not found in f.j")

txt = txt.replace("    // __ITEM_LIST__", item_block)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items into %s" % (len(ids), FJ))
