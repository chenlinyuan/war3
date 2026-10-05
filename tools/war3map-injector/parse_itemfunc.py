"""Parse a map's units\\itemfunc.txt to extract custom item IDs and names.

itemfunc.txt format (INI-like):
    [I000]
    Name=风痕之刃
    Tip=...
    ...
"""
import re, os, sys

def parse_itemfunc(path, encoding="gbk"):
    txt = open(path, encoding=encoding, errors="replace").read()
    items = []
    cur_id = None
    for line in txt.splitlines():
        line = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", line)
        if m:
            if cur_id:
                items.append(cur_id)
            cur_id = m.group(1)
            continue
        if cur_id and line.lower().startswith("name="):
            name = line.split("=", 1)[1]
            items.append((cur_id, name))
            cur_id = None
    return items


if __name__ == "__main__":
    path = sys.argv[1]
    for enc in ("gbk", "utf-8"):
        try:
            items = parse_itemfunc(path, enc)
            print("encoding %s -> %d items" % (enc, len(items)))
            for iid, nm in items[:20]:
                print("  %s  %s" % (iid, nm))
            break
        except Exception as e:
            print("encoding %s failed: %s" % (enc, e))
