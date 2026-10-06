# -*- coding: utf-8 -*-
import re

d = open("maps/hy69.original/war3map.j", "rb").read().decode("utf-8", "replace")
out = []

# 找"打开勇者宝藏"所在函数
for kw in ["勇者宝藏", "极乐宝箱", "仙人宝藏"]:
    i = d.find(kw)
    if i < 0:
        continue
    fs = d.rfind("function ", 0, i)
    fn = d[fs:fs+90].split("(")[0].replace("function ", "").strip()
    out.append("=== [%s] 所在函数: %s ===" % (kw, fn))
    out.append(d[fs:i+200][:1400])
    out.append("")

open("tools/war3map-injector/_jf_out.txt", "w", encoding="utf-8").write("\n".join(out))
print("written")






