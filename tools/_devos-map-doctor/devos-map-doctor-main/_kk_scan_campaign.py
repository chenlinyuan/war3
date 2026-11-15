# -*- coding: utf-8 -*-
"""扫描 .w3n 里每一章的 KKWE 字节码，报告签名缺口 / 结构情况。"""
import os
import sys

sys.stdout.reconfigure(encoding="utf-8")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(HERE)), "war3map-injector"))

from doctor.script import kkwe, kkwe_compile as KC  # noqa: E402
from doctor.triggers import triggerdata  # noqa: E402
import war3mpq as W  # noqa: E402

NATIVES_FILE = os.path.join(HERE, "doctor", "script", "kk_natives.j")


def known():
    out = {}
    for body in (triggerdata.game_script("common.j"), triggerdata.game_script("blizzard.j")):
        for it in KC.analyze(body or ""):
            if it[0] == "native":
                out[it[1]] = (it[2], it[3])
    for it in KC.analyze(open(NATIVES_FILE, "rb").read().decode("utf-8", "surrogateescape")):
        if it[0] == "native":
            out.setdefault(it[1], (it[2], it[3]))
    return out


def main():
    camp = sys.argv[1]
    tmp = os.path.join(HERE, "_rep_camp_scan")
    os.makedirs(tmp, exist_ok=True)
    a = W.MPQArchive(camp)
    chapters = sorted(n for n in a.listfile if n.lower().endswith((".w3x", ".w3m")))
    have = known()
    all_missing = set()
    for n in chapters:
        data = a.read_file(n)
        p = os.path.join(tmp, "c.tmp")
        open(p, "wb").write(data)
        try:
            b = W.MPQArchive(p)
            jc = b.read_file("kkmap.jc")
            j = b.read_file("war3map.j")
            nfiles = len(b.listfile)
            b.close()
        except Exception as e:
            print("%-16s 打不开: %r" % (n, e))
            continue
        if not jc:
            print("%-16s 没有 kkmap.jc；war3map.j=%s；内部文件 %d"
                  % (n, "MISSING" if j is None else len(j), nfiles))
            continue
        try:
            bc = kkwe.Bytecode(kkwe.read_container(jc))
        except Exception as e:
            print("%-16s kkmap.jc 读不了: %r" % (n, e))
            continue
        called = {bc.fname(bc.arg[k]) for k in range(bc.n) if bc.op[k] == kkwe.OP["CALLNATIVE"]}
        miss = sorted(x for x in called if x not in have)
        all_missing.update(miss)
        print("%-16s kkmap.jc %8d B  函数 %4d  native %4d  缺签名 %2d  %s"
              % (n, len(jc), len(bc.functions()), len(called), len(miss), miss))
    print("\n全部缺口 (%d): %s" % (len(all_missing), sorted(all_missing)))
    a.close()


if __name__ == "__main__":
    main()
