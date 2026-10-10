import struct, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
p = os.path.join(BASE, "maps", "伏魔战记.w3x.orig", "war3map.w3a")
d = open(p, "rb").read()

# Try: version(4), origCount(4), then entries oldId(4), newId(4), nmods(4), mods
off = 0
version = struct.unpack_from("<i", d, off)[0]; off += 4
orig = struct.unpack_from("<i", d, off)[0]; off += 4
print("version", version, "orig", orig)

def dump_entry(d, off, tag):
    old = d[off:off+4]; off += 4
    new = d[off:off+4]; off += 4
    n = struct.unpack_from("<i", d, off)[0]; off += 4
    print("%s old=%r new=%r nmods=%d @%d" % (tag, old, new, n, off))
    for k in range(n):
        mid = d[off:off+4]; off += 4
        vt = struct.unpack_from("<i", d, off)[0]; off += 4
        lc = struct.unpack_from("<i", d, off)[0]; off += 4
        lp = struct.unpack_from("<i", d, off)[0]; off += 4
        vals = []
        for _ in range(lc):
            if vt == 0:
                vals.append(struct.unpack_from("<i", d, off)[0]); off += 4
            elif vt in (1, 2):
                vals.append(struct.unpack_from("<f", d, off)[0]); off += 4
            elif vt == 3:
                e = d.find(b"\x00", off)
                vals.append(d[off:e].decode("latin-1")); off = e + 1
            else:
                print("   BAD vt", vt, "at mod", mid, "off", off)
                return off, False
        print("   mod", mid, "vt", vt, "lc", lc, "lp", lp, "vals", vals)
    return off, True

off, ok = dump_entry(d, off, "entry0")
print("ok", ok, "off", off)
if ok:
    off, ok = dump_entry(d, off, "entry1")
    print("ok", ok, "off", off)
