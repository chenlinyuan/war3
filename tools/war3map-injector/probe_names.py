"""用一份常见内部文件名清单去探测地图里存在哪些文件（对付没有 listfile 的图）。

用法: python probe_names.py <地图>
"""
import os
import struct
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402

NAMES = [
    "war3map.j", "war3map.lua", "war3map.w3e", "war3map.w3i", "war3map.w3a", "war3map.w3t",
    "war3map.w3u", "war3map.w3h", "war3map.w3q", "war3map.w3b", "war3map.w3d", "war3map.w3r",
    "war3map.w3c", "war3map.wct", "war3map.wtg", "war3map.wts", "war3map.imp", "war3map.shd",
    "war3map.mmp", "war3map.wpm", "war3map.doo", "war3mapunits.doo", "war3mapmap.blp",
    "war3mappreview.tga", "war3mapSkin.txt", "war3mapMisc.txt", "war3mapExtra.txt",
    "war3map.j.bak", "war3map.original.j", "war3mapJP.j", "war3map_cn.j", "war3mapCN.j",
    "Scripts\\war3map.j", "Scripts\\Blizzard.j", "war3mapImported\\war3map.j",
    "(listfile)", "(attributes)", "(signature)", "war3map.j.new", "conversation.json",
    "war3map.w3o", "war3map.w3f", "war3map.w3v", "war3map.w3s", "war3map.w3g", "war3map.w3x",
]


def main():
    a = W.MPQArchive(sys.argv[1])
    try:
        for n in NAMES:
            d = a.read_file(n)
            if d is None:
                continue
            info = a._find_file(n)
            extra = ""
            if n.endswith((".j", ".txt", ".imp", ".wts")):
                txt = "".join(chr(c) if 32 <= c < 127 else "." for c in d[:60])
                extra = "  " + txt
            print("%-28s %9d 字节  flags=0x%08X%s" % (n, len(d), info.flags, extra))
    finally:
        a.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
