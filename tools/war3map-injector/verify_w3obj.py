"""通用 w3a/w3t 结构验证器（正确的 mod 格式: modId + type + a + b + value + c）。"""
import struct, sys

p = sys.argv[1]
d = open(p, 'rb').read()
print('size', len(d))
off = 0
ver = struct.unpack_from('<i', d, off)[0]; off += 4
orig = struct.unpack_from('<i', d, off)[0]; off += 4
print('version', ver, 'origCount', orig)


def read_entry(off):
    old = d[off:off + 4].decode('latin-1'); off += 4
    new = d[off:off + 4].decode('latin-1'); off += 4
    n = struct.unpack_from('<i', d, off)[0]; off += 4
    mods = []
    for _ in range(n):
        mid = d[off:off + 4].decode('latin-1'); off += 4
        t = struct.unpack_from('<i', d, off)[0]; off += 4
        a = struct.unpack_from('<i', d, off)[0]; off += 4
        b = struct.unpack_from('<i', d, off)[0]; off += 4
        if t == 0:
            v = struct.unpack_from('<i', d, off)[0]; off += 4
        elif t in (1, 2):
            v = struct.unpack_from('<f', d, off)[0]; off += 4
        elif t == 3:
            e = d.find(b'\x00', off); v = d[off:e].decode('utf-8', 'replace'); off = e + 1
        else:
            raise ValueError('type %d at %s->%s off %d' % (t, old, new, off))
        c = struct.unpack_from('<i', d, off)[0]; off += 4
        mods.append((mid, t, a, b, v, c))
    return (old, new, mods), off


for i in range(orig):
    e, off = read_entry(off)
    print('orig', e[0], '->', e[1], 'mods', len(e[2]))
cust = struct.unpack_from('<i', d, off)[0]; off += 4
print('customCount', cust)
for i in range(cust):
    e, off = read_entry(off)
    print('custom', e[0], '->', e[1], 'mods', len(e[2]))
    for m in e[2]:
        print('   ', m)
print('final offset', off, 'of', len(d), 'remain', len(d) - off)
