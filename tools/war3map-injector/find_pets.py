"""Find pet/mount items (I04N etc) and phoenix in itemfunc.txt."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def load_blocks(path):
    t = open(path, encoding="utf-8", errors="replace").read()
    cur = None
    blocks = []
    for ln in t.splitlines():
        m = re.match(r"^\[([^\]]+)\]", ln)
        if m:
            cur = {"id": m.group(1), "kv": {}}
            blocks.append(cur)
        elif cur is not None and "=" in ln:
            k, v = ln.split("=", 1)
            cur["kv"][k.strip()] = v.strip()
    return blocks


def main():
    blocks = load_blocks(os.path.join(SJ, "units", "itemfunc.txt"))
    by_id = {b["id"]: b for b in blocks}

    # print items I04N and neighbors
    for i in ["I04N", "I04M", "I04O", "I04L", "I04K", "I04J", "I04I", "I04H"]:
        b = by_id.get(i)
        if b:
            print("=== [%s] ===" % i)
            for k, v in b["kv"].items():
                print("   %s=%s" % (k, v))

    print()
    print("=== blocks mentioning 坐骑/宠/凤凰/骑 ===")
    for b in blocks:
        blob = " ".join(b["kv"].values())
        if any(k in blob for k in ["坐骑", "凤凰", "骑", "宠物", "战兽", "捕捉"]):
            print("[%s] %s" % (b["id"], b["kv"].get("Name", "")))


if __name__ == "__main__":
    main()
