"""Validate the wings JASS module with pjass."""
import os, subprocess, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
WINGS = os.path.join(BASE, "scripts", "wings")
PJASS_DIR = r"H:\Games\War3\Tools\偶久改图一条龙工具包\tools\JassCraft"
PJASS = os.path.join(PJASS_DIR, "pjass.exe")
COMMON = os.path.join(PJASS_DIR, "common.j")
BLIZZ = os.path.join(PJASS_DIR, "blizzard.j")


def main():
    g = open(os.path.join(WINGS, "g.j"), encoding="utf-8").read()
    f = open(os.path.join(WINGS, "f.j"), encoding="utf-8").read()
    m = open(os.path.join(WINGS, "m.j"), encoding="utf-8").read()

    combined = "globals\n" + g + "\nendglobals\n" + f + \
        "\nfunction main takes nothing returns nothing\n" + m + "\nendfunction\n"

    out = os.path.join(WINGS, "_combined.j")
    open(out, "w", encoding="utf-8").write(combined)
    print("wrote", out, len(combined), "bytes")

    r = subprocess.run([PJASS, COMMON, BLIZZ, out], capture_output=True)
    print("returncode", r.returncode)
    for stream in (r.stdout, r.stderr):
        try:
            txt = stream.decode("utf-8", "replace")
        except Exception:
            txt = repr(stream)
        sys.stdout.buffer.write(txt.encode("utf-8", "replace"))
        sys.stdout.buffer.write(b"\n")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
