"""Validate any scripts/<dir> JASS module with pjass.

Usage:
    python validate_dir.py <script_dir>
"""
import os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PJASS_DIR = r"H:\Games\War3\Tools\偶久改图一条龙工具包\tools\JassCraft"
PJASS = os.path.join(PJASS_DIR, "pjass.exe")
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
    r = subprocess.run([PJASS, COMMON, BLIZZ, out], capture_output=True)
    print("returncode", r.returncode)
    for stream in (r.stdout, r.stderr):
        txt = stream.decode("utf-8", "replace")
        sys.stdout.buffer.write(txt.encode("utf-8", "replace"))
        sys.stdout.buffer.write(b"\n")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
