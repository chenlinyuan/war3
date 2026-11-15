# -*- coding: utf-8 -*-
"""改地图/战役文件开头 HM3W 头里的名字（就地改前 512 字节，不动 MPQ）。"""
import sys


def main():
    path, new = sys.argv[1], sys.argv[2]
    with open(path, "rb") as f:
        block = bytearray(f.read(512))
    if bytes(block[:4]) != b"HM3W":
        print("文件没有 HM3W 头，跳过地图列表显示名")
        return 0
    nul = block.index(0, 8)
    old = bytes(block[8:nul]).decode("utf-8", "replace")
    # Preserve metadata after the name through its final non-zero byte.
    # Blizzard's official campaigns carry an extra field after the usual
    # flags/max-players pair; shifting the entire 512-byte padding block
    # would incorrectly consume the room needed for a longer display name.
    tail_end = max((i + 1 for i, value in enumerate(block[nul + 1:], nul + 1)
                    if value), default=nul + 1)
    tail = bytes(block[nul + 1:tail_end])
    name = new.encode("utf-8")
    out = b"HM3W" + bytes(block[4:8]) + name + b"\x00" + tail
    if len(out) > 512:
        raise SystemExit("新名字太长，超出 512 字节头：%d" % len(out))
    out += b"\x00" * (512 - len(out))
    with open(path, "r+b") as f:
        f.write(out)
    print("HM3W 名字: %r -> %r（头块仍是 512 字节）" % (old, new))


if __name__ == "__main__":
    main()
