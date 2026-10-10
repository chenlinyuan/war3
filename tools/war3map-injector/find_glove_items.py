"""在战役文件(.w3n)里找带"手套/glove"的物品及其图标。

用法:
    python find_glove_items.py [关键词...]
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402
from find_campaign_items import read_mods_item, wts_map  # noqa: E402
from merge_w3obj import read_all  # noqa: E402

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HERE = os.path.dirname(os.path.abspath(__file__))
TMP = os.path.join(HERE, "_tmp_camp.w3t")


def dump(path, kws, label):
    if not path.lower().endswith(".w3n"):
        # 工程里 _rep/*.w3t 是裸对象数据文件, 直接解析
        try:
            ver, orig, cust = read_all(path)
        except Exception as e:
            print("  parse fail %s: %s" % (label, e))
            return 0
        return report(cust + orig, {}, kws)
    try:
        a = W.MPQArchive(path)
    except Exception as e:
        print("  open fail %s: %s" % (label, e))
        return 0
    try:
        w3t = a.read_file("war3campaign.w3t") or a.read_file("war3map.w3t")
        wts = wts_map(a.read_file("war3campaign.wts") or a.read_file("war3map.wts"))
    except Exception as e:
        print("  read fail %s: %s" % (label, e))
        a.close()
        return 0
    a.close()
    if not w3t:
        return 0
    open(TMP, "wb").write(w3t)
    try:
        ver, orig, cust = read_all(TMP)
    except Exception as e:
        print("  parse fail %s: %s" % (label, e))
        return 0
    return report(cust + orig, wts, kws)


def report(entries, wts, kws):
    hits = 0
    for e in entries:
        mods = read_mods_item(e)
        name = str(mods.get("unam", ""))
        if name.startswith("TRIGSTR_"):
            name = wts.get(name.split("_", 1)[1], name)
        icon = str(mods.get("iico", ""))
        blob = name + " " + icon
        if not kws or any(k in blob for k in kws):
            hits += 1
            print("  %-6s %-22s %s" % (e[4:8].decode("latin-1"), name, icon))
    return hits


def main():
    kws = sys.argv[1:] or ["手套", "glove", "Glove", "Gauntlet", "gauntlet"]
    total = 0
    # 1) 工程里已经解包出来的战役对象数据
    for p in glob.glob(os.path.join(HERE, "_rep", "war3campaign.w3t")) + \
            glob.glob(os.path.join(HERE, "_camp_hand.w3t")):
        print("==", os.path.relpath(p, BASE))
        total += dump(p, kws, p)
    # 2) 本机战役文件
    for p in sorted(glob.glob(r"H:\Games\War3\Campaigns\*.w3n")):
        if os.path.getsize(p) > 200 * 1024 * 1024:
            print("skip big", os.path.basename(p))
            continue
        print("==", os.path.basename(p))
        n = dump(p, kws, p)
        total += n
        if n:
            print("   命中", n)
    print("总命中", total)
    return 0


if __name__ == "__main__":
    sys.exit(main())
