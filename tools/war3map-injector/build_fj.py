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


# Build the list lines
list_lines = ["    set ib_itemCount = 0"]
for i, (iid, nm) in enumerate(items):
    list_lines.append("    set ib_itemList[%d] = '%s'" % (i, iid))
    list_lines.append('    set ib_itemName[%d] = "%s"' % (i, jass_escape(nm)))
list_lines.append("    set ib_itemCount = %d" % len(items))
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

print("embedded %d items (id+name) into %s" % (len(items), FJ))
