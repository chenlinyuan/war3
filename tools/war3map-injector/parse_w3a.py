"""解析 war3map.w3a (技能对象数据) 格式，输出条目结构，用于生成自定义技能。

w3a v2 格式:
  int version (通常 2)
  int originalCount
  [originalCount 个条目]
  int customCount
  [customCount 个条目]

条目:
  char[4] oldId
  char[4] newId
  int modificationCount
  [modificationCount 个修改]
     char[4] modId
     int valueType (0=int,1=real,2=unreal,3=string)
     int levelCount      (v2 新增)
     int levelPointer    (v2 新增, 通常 = levelCount 或 0)
     value[levelCount]   (按类型: int=4字节, real/unreal=4字节, string=以0结尾)
"""
import struct, sys, os


def parse(path, verbose=True):
    d = open(path, "rb").read()
    off = 0
    version = struct.unpack_from("<i", d, off)[0]; off += 4
    orig = struct.unpack_from("<i", d, off)[0]; off += 4
    if verbose:
        print("version", version, "originalCount", orig)

    def read_entry(d, off, label):
        old = d[off:off + 4].decode("latin-1"); off += 4
        new = d[off:off + 4].decode("latin-1"); off += 4
        nmods = struct.unpack_from("<i", d, off)[0]; off += 4
        mods = []
        for k in range(nmods):
            mid = d[off:off + 4].decode("latin-1"); off += 4
            vtype = struct.unpack_from("<i", d, off)[0]; off += 4
            levelCount = struct.unpack_from("<i", d, off)[0]; off += 4
            levelPointer = struct.unpack_from("<i", d, off)[0]; off += 4
            vals = []
            for _ in range(levelCount):
                if vtype == 0:
                    vals.append(struct.unpack_from("<i", d, off)[0]); off += 4
                elif vtype in (1, 2):
                    vals.append(struct.unpack_from("<f", d, off)[0]); off += 4
                elif vtype == 3:
                    e = d.find(b"\x00", off)
                    vals.append(d[off:e].decode("latin-1")); off = e + 1
                else:
                    raise ValueError("type %d at %s->%s mod %s off %d" % (vtype, old, new, mid, off))
            mods.append((mid, vtype, levelCount, levelPointer, vals))
        return old, new, mods, off

    entries = []
    for i in range(orig):
        old, new, mods, off = read_entry(d, off, "orig")
        entries.append((old, new, mods))
    cust = struct.unpack_from("<i", d, off)[0]; off += 4
    if verbose:
        print("customCount", cust, "offset after orig", off)
    cust_entries = []
    for i in range(cust):
        old, new, mods, off = read_entry(d, off, "cust")
        cust_entries.append((old, new, mods))
    if verbose:
        print("parsed OK, final offset", off, "file size", len(d), "remain", len(d) - off)
    return version, entries, cust_entries


if __name__ == "__main__":
    p = sys.argv[1] if len(sys.argv) > 1 else "maps/sj.original/war3map.w3a"
    version, orig, cust = parse(p)
    print("=" * 60)
    print("第一个原版条目:", orig[0][0], "->", orig[0][1], "mods:", len(orig[0][2]))
    for m in orig[0][2][:5]:
        print("   ", m)
    print("自定义条目数:", len(cust))
    for e in cust[:5]:
        print("   custom", e[0], "->", e[1], "mods:", len(e[2]))
