"""Find mount unit types (n02L, n02M, n02N, n02P, h01D, u00K) and phoenix."""
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
    for fn in ["humanunitfunc.txt", "neutralunitfunc.txt", "unitfunc.txt"]:
        p = os.path.join(SJ, "units", fn)
        if not os.path.exists(p):
            continue
        print("###", fn)
        blocks = load_blocks(p)
        print("  blocks", len(blocks))
        for b in blocks:
            blob = " ".join(b["kv"].values())
            if any(k in blob for k in ["凤凰", "坐骑", "战兽", "骑", "宠物"]):
                print("  [%s] %s" % (b["id"], b["kv"].get("Name", "")))
        # print the mount unit ids
        by_id = {b["id"]: b for b in blocks}
        for i in ["n02L", "n02M", "n02N", "n02P", "h01D", "u00K"]:
            if i in by_id:
                print("  === [%s] ===" % i)
                for k, v in by_id[i]["kv"].items():
                    print("     %s=%s" % (k, v))


if __name__ == "__main__":
    main()
