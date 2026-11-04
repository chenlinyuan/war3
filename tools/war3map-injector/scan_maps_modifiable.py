"""扫描本机地图，判断哪些是"可修改"的（war3map.j 是真脚本），哪些是壳化/加密图。

用法:
    python scan_maps_modifiable.py [目录...]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402

DEFAULT_DIRS = [r"H:\Games\War3\Maps"]
STUB_LIMIT = 4096          # 小于 4KB 基本就是"壳"


def script_size(path):
    a = W.MPQArchive(path)
    try:
        info = a._find_file("war3map.j")
        return info.fsize if info else None
    finally:
        a.close()


def main():
    dirs = sys.argv[1:] or DEFAULT_DIRS
    rows = []
    for d in dirs:
        if not os.path.isdir(d):
            continue
        for dp, _dn, fn in os.walk(d):
            for f in fn:
                if not f.lower().endswith((".w3x", ".w3m")):
                    continue
                p = os.path.join(dp, f)
                try:
                    size = script_size(p)
                except Exception as e:
                    rows.append((f, None, "打不开(%s)" % str(e)[:30], os.path.getsize(p)))
                    continue
                if size is None:
                    verdict = "无 war3map.j"
                elif size < STUB_LIMIT:
                    verdict = "壳化/加密"
                else:
                    verdict = "可修改"
                rows.append((f, size, verdict, os.path.getsize(p)))

    ok = [r for r in rows if r[2] == "可修改"]
    stub = [r for r in rows if r[2] == "壳化/加密"]
    print("扫描 %d 张图：可修改 %d，壳化/加密 %d，其它 %d\n" % (
        len(rows), len(ok), len(stub), len(rows) - len(ok) - len(stub)))
    print("== 可修改（war3map.j 是真脚本）==")
    for f, s, _v, mb in sorted(ok, key=lambda r: -r[1]):
        print("  %10d 字节脚本  %6.1f MB  %s" % (s, mb / 1048576, f))
    print("\n== 壳化/加密（脚本极小）==")
    for f, s, _v, mb in sorted(stub, key=lambda r: -(r[1] or 0))[:60]:
        print("  %10s 字节脚本  %6.1f MB  %s" % (s, mb / 1048576, f))
    return 0


if __name__ == "__main__":
    sys.exit(main())
