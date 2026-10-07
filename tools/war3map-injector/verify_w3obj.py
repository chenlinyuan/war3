"""通用 w3a/w3t 结构验证器。

格式差异:
  w3a (技能): mod = modId(4) + type(4) + variation(4) + dataPointer(4) + value + endMarker(4)
  w3t (物品): mod = modId(4) + type(4) + value + endMarker(4)

自动探测: 先试 3 字段(w3a), 失败再试 1 字段(w3t)。
"""
import struct, sys

p = sys.argv[1]
d = open(p, 'rb').read()
print('size', len(d))
off = 0
ver = struct.unpack_from('<i', d, off)[0]; off += 4
orig = struct.unpack_from('<i', d, off)[0]; off += 4
print('version', ver, 'origCount', orig)


def read_value(off, t):
    if t == 0:
        return struct.unpack_from('<i', d, off)[0], off + 4
    elif t in (1, 2):
        return struct.unpack_from('<f', d, off)[0], off + 4
    elif t == 3:
        e = d.find(b'\x00', off); return d[off:e].decode('utf-8', 'replace'), e + 1
    else:
        raise ValueError('type %d' % t)


def read_entry(off, nfields):
    old = d[off:off + 4].decode('latin-1'); off += 4
    new = d[off:off + 4].decode('latin-1'); off += 4
    n = struct.unpack_from('<i', d, off)[0]; off += 4
    mods = []
    for _ in range(n):
        mid = d[off:off + 4].decode('latin-1'); off += 4
        t = struct.unpack_from('<i', d, off)[0]; off += 4
        extra = []
        for _ in range(nfields - 1):
            extra.append(struct.unpack_from('<i', d, off)[0]); off += 4
        v, off = read_value(off, t)
        c = struct.unpack_from('<i', d, off)[0]; off += 4
        mods.append((mid, t, extra, v, c))
    return (old, new, mods), off


def try_parse(nfields):
    off = 8
    result = []
    try:
        for i in range(orig):
            e, off = read_entry(off, nfields)
            result.append(('orig', e))
        cust = struct.unpack_from('<i', d, off)[0]; off += 4
        for i in range(cust):
            e, off = read_entry(off, nfields)
            result.append(('cust', e))
        if off != len(d):
            return None
        return result, cust
    except Exception:
        return None


parsed = try_parse(3)
nfields = 3
if parsed is None:
    parsed = try_parse(1)
    nfields = 1
if parsed is None:
    print('无法解析 (两种格式都失败)')
    sys.exit(1)

result, cust = parsed
print('mod 字段数:', nfields, '(3=w3a技能, 1=w3t物品)')
print('customCount', cust)
for kind, (old, new, mods) in result:
    if kind == 'cust':
        print('custom', old, '->', new, 'mods', len(mods))
        for m in mods:
            print('   ', m)
print('解析成功')

