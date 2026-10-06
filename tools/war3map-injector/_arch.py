# -*- coding: utf-8 -*-
import re, os

out = []

# 找所有单位名(含"阿克蒙德")
names = {}
for fn in ["campaignunitfunc.txt", "unitfunc.txt"]:
    p = "maps/sj.original/units/" + fn
    if not os.path.exists(p):
        continue
    t = open(p, "rb").read()
    for enc in ("utf-8", "gbk"):
        try:
            t = t.decode(enc); break
        except Exception:
            pass
    else:
        t = t.decode("latin-1")
    cur = None
    for line in t.splitlines():
        s = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", s)
        if m:
            cur = m.group(1); continue
        if cur and s.lower().startswith("name="):
            names[cur] = s.split("=", 1)[1]
            cur = None

out.append("=== 含'阿克蒙德'的单位 ===")
for uid, nm in names.items():
    if "阿克蒙德" in nm or "阿克" in nm:
        out.append("  %s = %s" % (uid, nm))

# 标准阿克蒙德 ID 是 "Ewar"(Archimonde)? 检查
out.append("")
out.append("=== 可能的阿克蒙德/变身相关单位 ===")
for uid in ["Ewar", "Uwar", "Owar", "Nwar", "Hwar"]:
    if uid in names:
        out.append("  %s = %s" % (uid, names[uid]))

# 找变身技能(从abilitystrings)
out.append("")
out.append("=== 变身技能 ===")
base = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
for fn in ["neutralabilitystrings.txt", "humanabilitystrings.txt", "nightelfabilitystrings.txt"]:
    p = os.path.join(base, fn)
    if not os.path.exists(p):
        continue
    t = open(p, "rb").read()
    for enc in ("utf-8", "gbk"):
        try:
            t = t.decode(enc); break
        except Exception:
            pass
    else:
        t = t.decode("latin-1")
    cur = None
    for line in t.splitlines():
        s = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", s)
        if m:
            cur = m.group(1); continue
        if cur and s.lower().startswith("name="):
            nm = s.split("=", 1)[1]
            if "变身" in nm or "变形" in nm:
                out.append("  %s = %s (%s)" % (cur, nm, fn))
            cur = None

open("tools/war3map-injector/_arch.txt", "w", encoding="utf-8").write("\n".join(out))
print("written")
