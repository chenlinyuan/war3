"""Merge campaign-level custom items (war3campaign.w3t) into _itemids.txt.

Usage:
    python _collect_campaign_items.py <campaign_dir>
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parse_campaign_w3t as pcw

HERE = os.path.dirname(os.path.abspath(__file__))


def main():
    camp_dir = sys.argv[1]
    w3t = os.path.join(camp_dir, "war3campaign.w3t")
    wts = os.path.join(camp_dir, "war3campaign.wts")
    items = pcw.parse_w3t(w3t, wts) if os.path.isfile(w3t) else []
    print("campaign custom items:", len(items))

    # load current _itemids.txt
    p = os.path.join(HERE, "_itemids.txt")
    lines = open(p, encoding="utf-8").read().splitlines()
    existing = set()
    for ln in lines:
        parts = ln.split("\t")
        if len(parts) >= 2:
            existing.add(parts[1])

    added = 0
    for iid, nm in items:
        if iid and iid not in existing:
            lines.append("C\t%s\t%s" % (iid, nm))
            existing.add(iid)
            added += 1
    print("added campaign items:", added)

    # add 阿克蒙德之手 (I000) if not present
    if "I000" not in existing:
        lines.append("C\tI000\t阿克蒙德之手")
        existing.add("I000")
        print("added 阿克蒙德之手 I000")

    open(p, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print("total:", len(lines))


if __name__ == "__main__":
    main()
