# -*- coding: utf-8 -*-
"""用 Devo's Map Doctor 的单机锁分析器检查地图脚本。"""
import json
import os
import sys

sys.stdout.reconfigure(encoding="utf-8")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from doctor.fix import single_player as SP  # noqa: E402


def main():
    for path in sys.argv[1:]:
        print("=" * 70)
        print(path)
        res = SP.find(path)
        print(json.dumps({k: v for k, v in res.items() if k != "sites"},
                         ensure_ascii=False, indent=1))
        print("sites: %d" % len(res["sites"]))
        for s in res["sites"][:40]:
            print("  -", json.dumps({k: v for k, v in s.items() if not k.startswith("_")},
                                    ensure_ascii=False))


if __name__ == "__main__":
    main()
