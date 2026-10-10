"""Correct w3a/w3t/w3u/w3h object-data parser.

Format (v2):
  int version
  int origCount
  [orig entries]
  int customCount
  [custom entries]

entry:
  char(4) oldId
  char(4) newId
  int modCount
  per mod:
    char(4) modId
    int type (0=int,1=real,2=unreal,3=string)
    int level      (abilities/upgrades only; 0 for items/units/doodads/buffs)
    int column     (abilities/upgrades only; 0 otherwise)
    value (int/float/string)
    char(4) endMarker (00 00 00 00 for original table, else the new object id)
"""
import struct, sys, os

# Which object types have the extra level/column fields
HAS_LEVEL_COLUMN = {"w3a", "w3q"}


def parse(path, verbose=False):
    d = open(path, "rb").read()
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN
    off = 0
    version = struct.unpack_from("<i", d, off)[0]; off += 4
    orig = struct.unpack_from("<i", d, off)[0]; off += 4
    if verbose:
        print("version", version, "origCount", orig, "has_lc", has_lc)

    def read_entry(d, off):
        old = d[off:off + 4].decode("latin-1"); off += 4
        new = d[off:off + 4].decode("latin-1"); off += 4
        nmods = struct.unpack_from("<i", d, off)[0]; off += 4
        mods = []
        for _ in range(nmods):
            mid = d[off:off + 4].decode("latin-1"); off += 4
            vtype = struct.unpack_from("<i", d, off)[0]; off += 4
            level = column = 0
            if has_lc:
                level = struct.unpack_from("<i", d, off)[0]; off += 4
                column = struct.unpack_from("<i", d, off)[0]; off += 4
            if vtype == 0:
                val = struct.unpack_from("<i", d, off)[0]; off += 4
            elif vtype in (1, 2):
                val = struct.unpack_from("<f", d, off)[0]; off += 4
            elif vtype == 3:
                e = d.find(b"\x00", off)
                val = d[off:e].decode("utf-8", "replace"); off = e + 1
            else:
                raise ValueError("bad vtype %d at %s->%s mod %s off %d" % (vtype, old, new, mid, off))
            endmark = d[off:off + 4]; off += 4
            mods.append((mid, vtype, level, column, val, endmark))
        return old, new, mods, off

    entries = []
    for _ in range(orig):
        entries.append(read_entry(d, off))
        off = entries[-1][3]
    cust = struct.unpack_from("<i", d, off)[0]; off += 4
    cust_entries = []
    for _ in range(cust):
        cust_entries.append(read_entry(d, off))
        off = cust_entries[-1][3]
    if verbose:
        print("customCount", cust, "final off", off, "size", len(d), "remain", len(d) - off)
    return version, entries, cust_entries


if __name__ == "__main__":
    p = sys.argv[1]
    v, o, c = parse(p, verbose=True)
    print("orig", len(o), "custom", len(c))
