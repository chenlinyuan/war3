# -*- coding: utf-8 -*-
"""列出某个 KKWE 章节字节码调用的 native，并指出 Doctor 签名表里缺哪些。"""
import os
import sys

sys.stdout.reconfigure(encoding="utf-8")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from doctor.script import kkwe  # noqa: E402
from doctor.script import kkwe_compile as KC  # noqa: E402
from doctor.triggers import triggerdata  # noqa: E402

NATIVES_FILE = os.path.join(HERE, "doctor", "script", "kk_natives.j")


def known():
    out = {}
    for body in (triggerdata.game_script("common.j"), triggerdata.game_script("blizzard.j")):
        for it in KC.analyze(body or ""):
            if it[0] == "native":
                out[it[1]] = (it[2], it[3])
    text = open(NATIVES_FILE, "rb").read().decode("utf-8", "surrogateescape")
    for it in KC.analyze(text):
        if it[0] == "native":
            out.setdefault(it[1], (it[2], it[3]))
    return out


def main():
    jc = sys.argv[1]
    bc = kkwe.Bytecode(kkwe.read_container(open(jc, "rb").read()))
    called = sorted({bc.fname(bc.arg[k]) for k in range(bc.n) if bc.op[k] == kkwe.OP["CALLNATIVE"]})
    have = known()
    missing = [n for n in called if n not in have]
    print("字节码调用 native %d 个；签名表已知 %d 个；缺 %d 个"
          % (len(called), len(called) - len(missing), len(missing)))
    for n in missing:
        print("   MISSING %s" % n)
    sys.stderr.write("\n".join(missing))


if __name__ == "__main__":
    main()
