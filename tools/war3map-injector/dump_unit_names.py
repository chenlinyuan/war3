"""Dump unit names for candidate mount units from the game's unit strings."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
# unitstrings files
files = ["humanunitstrings.txt", "neutralunitstrings.txt", "nightelfunitstrings.txt",
         "undeadunitstrings.txt", "orcunitstrings.txt", "campaignunitstrings.txt",
         "commonunitstrings.txt", "unitglobalstrings.txt"]
names = {}
for fn in files:
    p = os.path.join(GAME, fn)
    if not os.path.exists(p):
        continue
    t = open(p, encoding="utf-8", errors="replace").read()
    cur = None
    for ln in t.splitlines():
        m = re.match(r"^\[([^\]]+)\]", ln)
        if m:
            cur = m.group(1)
        elif cur and ln.startswith("Name="):
            names.setdefault(cur, ln[5:])

for u in sys.argv[1:] or ["nadr", "nadk", "nadw", "nzep", "hdhw", "hgry", "ehpr",
                          "nhrw", "nhrq", "nhyc", "nchp", "nrwm", "nowb", "nowe",
                          "nwgs", "nwgt", "hphx"]:
    print("%-6s %s" % (u, names.get(u, "(no name)")))
