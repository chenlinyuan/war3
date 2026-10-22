# -*- coding: utf-8 -*-
"""pjass gate: compare a script before/after injection; no NEW error kinds allowed.

2026-10-11: the campaign prologue's entry call was inserted BEFORE main's
`local` declarations (a JASS syntax error), which made the map unloadable
("map not found or corrupted"). This gate catches that class of bug at build
time instead of in game.

Usage:
    from jass_gate import check
    ok, note = check(before_bytes, after_bytes)
"""
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))

# pjass.exe 用仓库里那份 JassCraft；**参考脚本**用 Doctor 的 1.24 版。
#   ⚠ JassCraft 自带的 common.j 是 1.07 时代的：缺 agent/hashtable/GetHandleId，
#     拿它当判据会把"用了 hashtable 的模块"误报成编译错误（2026-10-15 实测：
#     翅膀模块改用 hashtable 存坐骑槽位后，4 个小章节被误拦）。见
#     docs/06-工具链/KKWE平台图单机化.md 坑二。
CANDIDATES = [
    os.path.join(BASE, "tools", "war3-tools", "偶久改图一条龙工具包", "tools", "JassCraft"),
    r"H:\Games\War3\Tools\偶久改图一条龙工具包\tools\JassCraft",
]
REF_CANDIDATES = [
    os.path.join(BASE, "tools", "_devos-map-doctor", "devos-map-doctor-main",
                 "doctor", "ref", "1.24"),
]


def _tool():
    for d in CANDIDATES:
        p = os.path.join(d, "pjass.exe")
        if os.path.exists(p) and os.path.exists(os.path.join(d, "common.j")):
            return d
    return None


def _ref(tool):
    """参考脚本目录：优先 Doctor 的 1.24，取不到才退回 JassCraft 自带的旧版。"""
    for d in REF_CANDIDATES:
        if os.path.exists(os.path.join(d, "common.j")):
            return d
    return tool


def _err_kinds(path, tool):
    ref = _ref(tool)
    r = subprocess.run([os.path.join(tool, "pjass.exe"),
                        os.path.join(ref, "common.j"),
                        os.path.join(ref, "blizzard.j"),
                        path], capture_output=True)
    out = (r.stdout + r.stderr).decode("utf-8", "replace")
    kinds = {}
    for line in out.splitlines():
        m = re.search(r":\d+: (.+)$", line)
        if m:
            k = re.sub(r"[\w']+", "X", m.group(1))[:60]
            kinds[k] = kinds.get(k, 0) + 1
    return r.returncode, kinds


def check(before, after, quiet=False):
    """Return (ok, note). The result may not be *worse* than before."""
    tool = _tool()
    if not tool:
        return True, "skipped (no pjass/JassCraft)"
    tmp = os.path.join(HERE, "_pjass_gate.j")
    try:
        open(tmp, "wb").write(before)
        rc1, k1 = _err_kinds(tmp, tool)
        open(tmp, "wb").write(after)
        rc2, k2 = _err_kinds(tmp, tool)
    finally:
        if os.path.exists(tmp):
            os.remove(tmp)
    new_kinds = {k: v for k, v in k2.items() if k not in k1}
    ok = (not new_kinds) and (rc2 == 0 or rc1 != 0)
    note = "pjass before rc=%d kinds=%d | after rc=%d kinds=%d | new kinds=%s" % (
        rc1, len(k1), rc2, len(k2), new_kinds or "-")
    if not quiet and not ok:
        print("    !! " + note, flush=True)
    return ok, note


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    ok, note = check(open(sys.argv[1], "rb").read(), open(sys.argv[2], "rb").read())
    print(note)
    print("gate:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
