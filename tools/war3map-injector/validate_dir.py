"""Validate any scripts/<dir> JASS module with pjass.

Usage:
    python validate_dir.py <script_dir>
"""
import os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
# pjass 用仓库里那份 JassCraft（H 盘那个路径已经不存在了）。
PJASS_DIR = os.path.join(BASE, "tools", "war3-tools", "偶久改图一条龙工具包",
                         "tools", "JassCraft")
PJASS = os.path.join(PJASS_DIR, "pjass.exe")
# ⚠ 参考脚本要用 Doctor 的 1.24 版：JassCraft 自带的是 1.07 时代的 common.j，
#   缺 agent/hashtable/GetHandleId，会报一堆假错（见 docs/06-工具链/KKWE平台图单机化.md）。
_VERSION = os.environ.get("JASS_REF_VERSION", "1.24").strip()
_REF = os.path.join(BASE, "tools", "_devos-map-doctor", "devos-map-doctor-main",
                    "doctor", "ref", _VERSION)
if os.path.exists(os.path.join(_REF, "common.j")):
    COMMON = os.path.join(_REF, "common.j")
    BLIZZ = os.path.join(_REF, "blizzard.j")
else:
    COMMON = os.path.join(PJASS_DIR, "common.j")
    BLIZZ = os.path.join(PJASS_DIR, "blizzard.j")


def main():
    d = sys.argv[1] if len(sys.argv) > 1 else os.path.join(BASE, "scripts", "item-browser")
    if not os.path.isabs(d):
        d = os.path.join(BASE, d)
    g = open(os.path.join(d, "g.j"), encoding="utf-8", errors="replace").read()
    f = open(os.path.join(d, "f.j"), encoding="utf-8", errors="replace").read()
    m = open(os.path.join(d, "m.j"), encoding="utf-8", errors="replace").read()
    combined = "globals\n" + g + "\nendglobals\n" + f + \
        "\nfunction main takes nothing returns nothing\n" + m + "\nendfunction\n"
    out = os.path.join(d, "_combined.j")
    open(out, "w", encoding="utf-8", errors="replace").write(combined)
    print("wrote", out, len(combined), "bytes")
    compat = os.path.join(HERE, "reforged_compat.j")
    r = subprocess.run([PJASS, COMMON, BLIZZ, compat, out], capture_output=True)
    print("returncode", r.returncode)
    for stream in (r.stdout, r.stderr):
        txt = stream.decode("utf-8", "replace")
        sys.stdout.buffer.write(txt.encode("utf-8", "replace"))
        sys.stdout.buffer.write(b"\n")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
