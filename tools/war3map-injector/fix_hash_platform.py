# -*- coding: utf-8 -*-
"""把 MPQ 哈希表里的 wPlatform / wLocale 归零。

KK（以及一些地图保护器）会把哈希条目的 wPlatform 写成 0xFF00。
StormLib（我们自己的读取器）忽略该字段，所以能读到文件；
但暴雪原版 Storm.dll 的 SFileOpenFileEx 只接受 wPlatform == 0 的条目，
于是游戏读不到 war3map.w3i / w3e / w3u ...，地图在单机里表现为"打不开"。

用法:
    python fix_hash_platform.py <地图> [--out 输出] [--dry]
"""
import argparse
import os
import shutil
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402

EMPTY, DELETED = 0xFFFFFFFF, 0xFFFFFFFE


def patch(path, out=None, dry=False):
    a = W.MPQArchive(path)
    pos = a.header_offset + a.hash_table_pos
    size = a.hash_table_size
    a.file.seek(pos)
    raw = a.file.read(size * 16)
    a.close()
    if len(raw) != size * 16:
        raise SystemExit("hash table read short: %d != %d" % (len(raw), size * 16))

    key = W._hash_string("(hash table)", W.MPQ_HASH_FILE_KEY)
    plain = bytearray(W._decrypt(raw, key))
    changed = 0
    fields = {}
    for i in range(size):
        off = i * 16
        hash_a = struct.unpack_from("<I", plain, off)[0]
        if hash_a in (EMPTY, DELETED):
            continue
        combo = struct.unpack_from("<I", plain, off + 8)[0]
        locale, platform = combo & 0xFFFF, combo >> 16
        fields[(locale, platform)] = fields.get((locale, platform), 0) + 1
        if combo != 0:
            struct.pack_into("<I", plain, off + 8, 0)
            changed += 1
    print("%s: 哈希条目 (locale, platform) 组合 = %r" % (os.path.basename(path), fields))
    print("  需要归零的条目: %d" % changed)
    if dry or not changed:
        return 0
    enc = W._encrypt(bytes(plain), key)
    if len(enc) != len(raw):
        raise SystemExit("re-encrypted size mismatch")
    dst = out or path
    if os.path.abspath(dst) != os.path.abspath(path):
        shutil.copyfile(path, dst)
    with open(dst, "r+b") as f:
        f.seek(pos)
        f.write(enc)
    print("  已写回 %s" % dst)
    return changed


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--out")
    ap.add_argument("--dry", action="store_true")
    args = ap.parse_args()
    patch(args.map, args.out, args.dry)


if __name__ == "__main__":
    main()
