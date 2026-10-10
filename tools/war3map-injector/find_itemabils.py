"""Search game itemabilityfunc.txt / itemabilitystrings.txt for Life Bonus ability id."""
import re, os

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"

for fn in ["itemabilityfunc.txt", "itemabilitystrings.txt", "commonabilityfunc.txt"]:
    p = os.path.join(GAME, fn)
    t = open(p, encoding="utf-8", errors="replace").read()
    lines = t.splitlines()
    cur = None
    for i, ln in enumerate(lines):
        m = re.match(r"^\[([^\]]+)\]", ln)
        if m:
            cur = m.group(1)
        if "Life Bonus" in ln or "生命值" in ln or "增加生命" in ln:
            print("%s: [%s] %s" % (fn, cur, ln.strip()))
