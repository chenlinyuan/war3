"""Find wing item definitions in itemfunc.txt and itemdata.slk."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def main():
    p = os.path.join(SJ, "units", "itemfunc.txt")
    t = open(p, encoding="utf-8", errors="replace").read()
    lines = t.splitlines()
    # INI: [ID] then Key=Value
    cur = None
    blocks = []
    for ln in lines:
        m = re.match(r"^\[([^\]]+)\]", ln)
        if m:
            cur = {"id": m.group(1), "kv": {}}
            blocks.append(cur)
        elif cur is not None and "=" in ln:
            k, v = ln.split("=", 1)
            cur["kv"][k.strip()] = v.strip()

    print("total blocks", len(blocks))
    kws = ["翅膀", "天翼", "之翼", "堕落", "凤凰", "坐骑", "恶魔之翼", "炽天使"]
    for b in blocks:
        name = b["kv"].get("Name", "")
        art = b["kv"].get("Art", "")
        des = b["kv"].get("Description", "")
        blob = name + art + des
        if any(k in blob for k in kws):
            print("=== [%s] ===" % b["id"])
            for k, v in b["kv"].items():
                print("   %s=%s" % (k, v))


if __name__ == "__main__":
    main()
