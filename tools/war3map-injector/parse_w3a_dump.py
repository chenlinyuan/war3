"""Dump all abilities from a war3map.w3a with their name (anam) strings."""
import re, os, sys, struct

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(SJ, "war3map.w3a")
    w = open(path, "rb").read()
    print("size", len(w))
    ver = struct.unpack_from("<I", w, 0)[0]
    print("version", ver)
    # find all 4-char ids followed by anam
    for m in re.finditer(rb"anam", w):
        i = m.start()
        # id is 4 bytes before? Actually structure: id(4) ... mods. Look backwards for printable 4-char id
        seg = w[max(0, i - 60):i]
        ids = re.findall(rb"[\x41-\x5a\x61-\x7a\x30-\x39]{4}", seg)
        # name value: after anam(4)+type(4)+?+value
        after = w[i:i + 120]
        # TRIGSTR or raw string
        print("---")
        print("id candidates:", [x.decode() for x in ids])
        print("after:", after[:80])


if __name__ == "__main__":
    main()
