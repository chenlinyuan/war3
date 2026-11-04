# -*- coding: utf-8 -*-
"""Check whether the wings/mount/item/skill IDs collide with what a campaign
already uses (its war3campaign.w3*/slk/txt object data).

Usage:
    python check_campaign_ids.py <campaign.w3n> [more.w3n ...]
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import pick_ids as PI  # noqa: E402


def campaign_used(path):
    PI.SCAN_FILES = ["war3campaign." + ext for ext in
                     ("w3a", "w3t", "w3u", "w3h", "w3q", "w3b", "w3d")]
    return PI.map_used_ids(path)


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    ours = PI.our_groups()
    for p in sys.argv[1:]:
        used = campaign_used(p)
        clash = [(g, k, v) for g, k, v in ours if v in used]
        print("== %s" % os.path.basename(p))
        print("   战役已占用 ID: %d 个；我们用了 %d 个；冲突 %d 个"
              % (len(used), len(ours), len(clash)))
        for g, k, v in clash:
            print("   !! %s[%s] = %s 已被战役使用" % (g, k, v))


if __name__ == "__main__":
    main()
