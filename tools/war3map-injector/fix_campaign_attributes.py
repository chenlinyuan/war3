# -*- coding: utf-8 -*-
"""清空 MPQ 里 (attributes) 表的校验数据（保留文件本身，只把 flags 归零）。

为啥要动它：.w3n 战役里有 4177 条 "逐文件 CRC32/FILETIME" 的属性表，
引擎加载章节前会做完整性校验；只要章节被改过就报
"The file data is corrupt. File: <章节名>"。
把 flags 归零后表里不再有任何校验值，引擎无从校验（文件仍在、格式合法）。

用法:
    python fix_campaign_attributes.py <地图或战役> [--out 输出] [--dry]
"""
import argparse
import os
import shutil
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--out")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--restore", action="store_true",
                    help="把属性数据还原成正确的 CRC/FILETIME（需要原始文件做参照）")
    a = ap.parse_args()
    src = os.path.abspath(a.map)
    ar = W.MPQArchive(src)
    att = ar.read_file("(attributes)")
    if att is None:
        print("%s 没有 (attributes) 表，什么都不用做" % os.path.basename(src))
        ar.close()
        return
    ver, flags = struct.unpack_from("<II", att, 0)
    print("(attributes): %d 字节  version=%d flags=0x%X (CRC32=%s FILETIME=%s MD5=%s)"
          % (len(att), ver, flags, bool(flags & 1), bool(flags & 2), bool(flags & 4)))
    ar.close()
    # MPQ attributes use version 100. Keep that version canonical even when
    # an earlier partial-sector decoder produced a bogus version value.
    if ver == 100 and flags == 0:
        print("attributes version/flags already canonical; no change needed")
        return
    new = struct.pack("<II", 100, 0)
    tmp = os.path.join(HERE, "_rep", "(attributes)")
    os.makedirs(os.path.dirname(tmp), exist_ok=True)
    with open(tmp, "wb") as f:
        f.write(new)
    print("新 (attributes) -> %d 字节（只剩 8 字节头，flags=0）" % len(new))
    if a.dry:
        return
    out = os.path.abspath(a.out) if a.out else src
    cmd = [sys.executable, os.path.join(HERE, "inject_native.py"), src,
           "--file", tmp + "=(attributes)", "--out", out, "--no-backup"]
    import subprocess
    r = subprocess.run(cmd, capture_output=True)
    sys.stdout.buffer.write((r.stdout + r.stderr)[-1500:])
    sys.stdout.flush()


if __name__ == "__main__":
    main()
