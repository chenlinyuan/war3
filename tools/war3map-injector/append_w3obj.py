"""Append custom entries from one w3obj file to another, preserving the target's
origCount and customCount entries exactly (no orig->custom conversion, no dedup
of the target's own entries).

Usage:
    python append_w3obj.py <target> <extra> <out>

- target: the map/campaign's existing w3a/w3t/w3h (origCount kept as-is)
- extra:  our custom entries (origCount ignored; its custom entries appended)
Only appends extra entries whose newId is not already present in target.
"""
import struct, sys, os

HAS_LEVEL_COLUMN = {"w3a", "w3q"}


def read_all(path):
    d = open(path, "rb").read()
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN
    off = 0
    ver = struct.unpack_from("<i", d, off)[0]; off += 4
    orig_n = struct.unpack_from("<i", d, off)[0]; off += 4

    def read_entry(off):
        start = off
        off += 8  # old, new
        n = struct.unpack_from("<i", d, off)[0]; off += 4
        for _ in range(n):
            off += 4  # mid
            t = struct.unpack_from("<i", d, off)[0]; off += 4
            if has_lc:
                off += 8
            if t == 0:
                off += 4
            elif t in (1, 2):
                off += 4
            elif t == 3:
                e = d.find(b"\x00", off); off = e + 1
            else:
                raise ValueError("bad type %d at off %d" % (t, off))
            off += 4
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
    return ver, orig, cust


def main():
    if len(sys.argv) < 4:
        print(__doc__)
        return 1
    target, extra, out = sys.argv[1], sys.argv[2], sys.argv[3]
    ver_t, orig_t, cust_t = read_all(target)
    ver_e, orig_e, cust_e = read_all(extra)

    used = set(e[4:8] for e in orig_t + cust_t)
    added = 0
    for e in cust_e:
        nid = e[4:8]
        if nid in used or nid == b"\x00\x00\x00\x00":
            continue
        used.add(nid)
        cust_t.append(e)
        added += 1

    data = struct.pack("<ii", 2, len(orig_t))
    for e in orig_t:
        data += e
    data += struct.pack("<i", len(cust_t))
    for e in cust_t:
        data += e
    open(out, "wb").write(data)
    print("target orig=%d cust=%d; appended %d; out orig=%d cust=%d (%d bytes)" % (
        len(orig_t), len(cust_t) - added, added, len(orig_t), len(cust_t), len(data)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
