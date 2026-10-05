"""Rebuild scripts/item-browser/f.j by embedding the item ID + cleaned name list.

Reads _itemids.txt (flag<TAB>id<TAB>name, flag = S standard / C custom).
Names are PRE-CLEANED here (strip |cXXXXXXXX / |r colour codes, trim,
ASCII-lowercase) so the runtime script does NO string transformation — this
avoids corrupting multibyte UTF-8/GBK Chinese.

Embeds ib_itemList[i] (ID), ib_itemName[i] (cleaned name) and
ib_itemCustom[i] (1 = custom item, 0 = standard).
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))
FJ = os.path.join(REPO, "scripts", "item-browser", "f.j")


def clean_name(s):
    s = re.sub(r"\|c[0-9a-fA-F]{8}", "", s)
    s = re.sub(r"\|r", "", s)
    s = s.strip()
    return "".join(chr(ord(c) + 32) if "A" <= c <= "Z" else c for c in s)


# Read flag + id + name
items = []
with open(os.path.join(HERE, "_itemids.txt"), encoding="utf-8") as fh:
    for line in fh:
        parts = line.rstrip("\n").split("\t")
        if len(parts) >= 3:
            flag, iid, nm = parts[0].strip(), parts[1].strip(), parts[2].strip()
        elif len(parts) == 2:
            flag, iid, nm = "S", parts[0].strip(), parts[1].strip()
        else:
            continue
        if len(iid) == 4:
            items.append((flag, iid, clean_name(nm)))


def jass_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"')


# Split into chunks to avoid War3's per-function statement limit.
CHUNK = 80
chunks = [items[i:i + CHUNK] for i in range(0, len(items), CHUNK)]

chunk_funcs = []
for ci, chunk in enumerate(chunks):
    lines = ["function IB_Fill%d takes nothing returns nothing" % ci]
    for k, (flag, iid, nm) in enumerate(chunk):
        idx = ci * CHUNK + k
        lines.append("    set ib_itemList[%d] = '%s'" % (idx, iid))
        lines.append('    set ib_itemName[%d] = "%s"' % (idx, jass_escape(nm)))
        lines.append("    set ib_itemCustom[%d] = %d" % (idx, 1 if flag == "C" else 0))
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

# 1) Remove any previously generated IB_Fill* functions (idempotent rebuild)
txt = re.sub(r"function IB_Fill\d+ takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)

# 2) Replace IB_Init body
pattern = re.compile(
    r"(function IB_Init takes nothing returns nothing\n)(.*?)(    call IB_Message\(GetLocalPlayer\(\))",
    re.S)
if not pattern.search(txt):
    raise SystemExit("IB_Init block not found in f.j")

new_init = init_block + "\n" + pattern.search(txt).group(3)
txt = pattern.sub(lambda m: new_init, txt)

# 3) Insert chunk functions before IB_Init
marker = "function IB_Init takes nothing returns nothing"
txt = txt.replace(marker, "\n".join(chunk_funcs) + "\n\n" + marker, 1)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items (id+name) in %d chunks into %s" % (len(items), len(chunks), FJ))
