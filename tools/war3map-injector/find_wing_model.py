"""Search all slk/txt in the map for wing model references."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")

MODELS = ["wingofthelucifer", "doomgguardwings", "fwind", "fwing", "wingblack4",
          "effect-darkstar", "sanctitudeangell", "heroshamal"]

for root, dirs, files in os.walk(SJ):
    for f in files:
        p = os.path.join(root, f)
        try:
            d = open(p, "rb").read()
        except Exception:
            continue
        low = d.lower()
        for m in MODELS:
            b = m.encode()
            if b in low:
                rel = os.path.relpath(p, SJ)
                print("%s : %s" % (rel, m))
