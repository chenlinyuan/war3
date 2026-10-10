"""把 _hand.w3t 里阿克蒙德之手(I000)的物品图标 iico 换成指定图标。

_hand.w3t 是历史产物（由 gen_w3t.py 生成后一直作为合并基底），
本脚本就地改一个 mod 的值，并保持其余字节结构不变（改完可用 parse 验证）。

用法:
    python patch_hand_item_icon.py [图标路径]
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from merge_w3obj import read_all  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT = "ReplaceableTextures\\CommandButtons\\BTNGlove.blp"


def read_mods(e):
    n = struct.unpack_from("<i", e, 8)[0]
    off = 12
    out = []
    for _ in range(n):
        mid = e[off:off + 4]
        t = struct.unpack_from("<i", e, off + 4)[0]
        off += 8
        if t == 0:
            val = struct.unpack_from("<i", e, off)[0]
            raw = e[off:off + 4]
            off += 4
        elif t in (1, 2):
            val = struct.unpack_from("<f", e, off)[0]
            raw = e[off:off + 4]
            off += 4
        elif t == 3:
            end = e.index(b"\x00", off)
            raw = e[off:end]
            val = raw.decode("utf-8", "replace")
            off = end + 1
        else:
            raise ValueError("bad mod type %d" % t)
        end_marker = struct.unpack_from("<i", e, off)[0]
        off += 4
        out.append((mid, t, val, raw, end_marker))
    return out, off


def write_mod(mid, t, val, end_marker):
    out = mid + struct.pack("<i", t)
    if t == 0:
        out += struct.pack("<i", val)
    elif t in (1, 2):
        out += struct.pack("<f", val)
    elif t == 3:
        out += val.encode("utf-8") + b"\x00"
    out += struct.pack("<i", end_marker)
    return out


def main():
    icon = sys.argv[1] if len(sys.argv) > 1 else DEFAULT
    path = os.path.join(HERE, "_hand.w3t")
    ver, orig, cust = read_all(path)
    new_cust = []
    changed = 0
    for e in cust:
        mods, _ = read_mods(e)
        if e[4:8] == b"I000":
            out = []
            for (mid, t, val, raw, end) in mods:
                if mid == b"iico":
                    if val != icon:
                        val = icon
                        changed += 1
                out.append((mid, t, val, end))
            body = b"".join(write_mod(mid, t, val, end) for (mid, t, val, end) in out)
            e = e[0:8] + struct.pack("<i", len(out)) + body
        new_cust.append(e)
    data = struct.pack("<ii", ver, len(orig))
    for e in orig:
        data += e
    data += struct.pack("<i", len(new_cust))
    for e in new_cust:
        data += e
    open(path, "wb").write(data)
    print("patched %s: iico -> %s (changed %d)" % (path, icon, changed))
    return 0


if __name__ == "__main__":
    sys.exit(main())
