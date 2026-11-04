"""合并多个 war3map.w3t / w3a 文件（保留所有原版+自定义条目，按 newId 去重）。

用法:
    python merge_w3obj.py <输出> <输入1> <输入2> [...]

自动探测格式:
  w3a/w3q: modId(4)+type(4)+level(4)+column(4)+value+endMarker(4)
  w3d:     同 w3a/w3q（Reforged 实测）
  w3t/w3u/w3h/w3b: modId(4)+type(4)+value+endMarker(4)

对象文件版本 3（Reforged）在每个对象的 IDs 后增加“套装”层：
  setCount(4) + [setFlag(4) + modCount(4) + mods...]
合并时保留现有 v3 套装边界；旧模板的 v2 条目转成一个标准套装。
"""
import struct, sys, os

HAS_LEVEL_COLUMN = {"w3a", "w3q", "w3d"}


def read_all(path):
    d = open(path, "rb").read()
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN
    off = 0
    ver = struct.unpack_from("<i", d, off)[0]; off += 4
    if ver not in (1, 2, 3):
        raise ValueError("bad version %d" % ver)
    orig_n = struct.unpack_from("<i", d, off)[0]; off += 4

    def read_entry(off):
        start = off
        off += 4  # old
        off += 4  # new
        if ver >= 3:
            set_count = struct.unpack_from("<i", d, off)[0]; off += 4
            if set_count < 0 or set_count > (len(d) - off) // 8:
                raise ValueError("bad set count %d at off %d" % (set_count, off - 4))
            counts = []
            for _ in range(set_count):
                _flag, n = struct.unpack_from("<ii", d, off); off += 8
                if n < 0:
                    raise ValueError("bad mod count %d at off %d" % (n, off - 4))
                counts.append(n)
        else:
            counts = [struct.unpack_from("<i", d, off)[0]]
            off += 4
        for n in counts:
            for _ in range(n):
                off += 4  # mid
                t = struct.unpack_from("<i", d, off)[0]; off += 4
                if has_lc:
                    off += 8  # level, column
                if t == 0:
                    off += 4
                elif t in (1, 2):
                    off += 4
                elif t == 3:
                    e = d.find(b"\x00", off)
                    if e < 0:
                        raise ValueError("unterminated string at off %d" % off)
                    off = e + 1
                else:
                    raise ValueError("bad type %d at off %d" % (t, off - 4))
                off += 4  # endMarker
                if off > len(d):
                    raise ValueError("entry runs past end at off %d" % off)
        return d[start:off], off

    orig = []
    for _ in range(orig_n):
        e, off = read_entry(off)
        orig.append(e)
    cust_n = struct.unpack_from("<i", d, off)[0]; off += 4
    cust = []
    for _ in range(cust_n):
        e, off = read_entry(off)
        cust.append(e)
    if off != len(d) and d[off:].strip(b"\x00"):
        raise ValueError("trailing %d bytes" % (len(d) - off))
    return ver, orig, cust


def _legacy_entry_to_v3(entry):
    """v1/v2 entry -> v3 entry with one set carrying all modifications."""
    if len(entry) < 12:
        raise ValueError("short object entry")
    count = struct.unpack_from("<I", entry, 8)[0]
    return entry[:8] + struct.pack("<III", 1, 0, count) + entry[12:]


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    out = sys.argv[1]
    inputs = sys.argv[2:]

    n_orig, n_cust = merge_files(out, inputs)
    print("merged %d orig + %d custom -> %s" % (n_orig, n_cust, out))
    return 0


def merge_files(out, inputs, override_ids=None):
    """合并多个同类对象数据文件，**保留 orig / custom 两段**。

    ⚠ 老版本把所有条目拍平成 custom 段（origCount=0），那会把目标图里
    "修改原版对象" 的条目变成 "自定义对象"，等于把它的数值改动弄坏 ——
    往别的图移植时必须保留分段。去重键：orig 段用 oldId+newId，custom 段用 newId。
    """
    all_orig, all_cust = [], []
    seen_orig, seen_cust = set(), set()
    overrides = {}
    override_ids = set(override_ids or ())
    out_version = 2
    for p in inputs:
        if not os.path.exists(p):
            continue
        ver, orig, cust = read_all(p)
        if ver >= 3:
            out_version = 3
        for e in orig:
            new_id = e[4:8].decode("latin-1").replace("\0", "")
            if new_id in override_ids:
                overrides[new_id] = (True, ver, e)
                continue
            key = e[0:8]
            if key in seen_orig:
                continue
            seen_orig.add(key)
            all_orig.append((ver, e))
        for e in cust:
            new_id = e[4:8].decode("latin-1").replace("\0", "")
            if new_id in override_ids:
                overrides[new_id] = (False, ver, e)
                continue
            key = e[4:8]
            if key in seen_cust:
                continue
            seen_cust.add(key)
            all_cust.append((ver, e))
    for _new_id, (is_original, ver, entry) in overrides.items():
        if is_original:
            all_orig.append((ver, entry))
        else:
            all_cust.append((ver, entry))
    data = struct.pack("<ii", out_version, len(all_orig))
    for ver, e in all_orig:
        data += _legacy_entry_to_v3(e) if out_version >= 3 and ver < 3 else e
    data += struct.pack("<i", len(all_cust))
    for ver, e in all_cust:
        data += _legacy_entry_to_v3(e) if out_version >= 3 and ver < 3 else e
    open(out, "wb").write(data)
    return len(all_orig), len(all_cust)


if __name__ == "__main__":
    sys.exit(main())
