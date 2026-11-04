# -*- coding: utf-8 -*-
"""把已经注入过旧脚本的地图里的 **criton（脚本版暴击）** 摘掉（就地手术）。

背景: item-browser 的 criton 已经在 2026-10-10 从源码里删了，但**早前注入过它的地图**
      脚本里还留着那套代码（f.j 的暴击函数 + g.j 的全局 + IB_Init 里的调用 + 聊天注册）。
      本工具按字节精确定位删除（f.j 里混有 GBK 名字表，不能整体当 UTF-8 处理）。

用法:
    python strip_crit.py <地图> [--out 输出] [--no-backup]
"""
import argparse
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
import mpq_patch as MP  # noqa: E402


def cut(data, start_marker, end_marker, what, out_log):
    """删掉 start_marker 开头到 end_marker 之前的一段。"""
    i = data.find(start_marker)
    if i < 0:
        out_log.append("  (没有 %s — 可能已经摘过)" % what)
        return data
    j = data.find(end_marker, i)
    if j < 0:
        out_log.append("  !! %s: 找不到结束标记 %r" % (what, end_marker[:40]))
        return data
    out_log.append("  删掉 %s: %d 字节" % (what, j - i))
    return data[:i] + data[j:]


def pjass_gate(before, after):
    """门禁: 用 pjass 对比"改之前/之后"，改完**不能出现新的错误类型**、也不能更差。"""
    import subprocess
    import validate_dir as V

    def errs(data):
        p = os.path.join(HERE, "_sg.j")
        open(p, "wb").write(data)
        try:
            r = subprocess.run([V.PJASS, V.COMMON, V.BLIZZ, p], capture_output=True)
            out = (r.stdout + r.stderr).decode("utf-8", "replace")
        finally:
            os.remove(p)
        kinds = {}
        for line in out.splitlines():
            m = re.search(r":\d+: (.+)$", line)
            if m:
                k = re.sub(r"[\w']+", "X", m.group(1))[:60]
                kinds[k] = kinds.get(k, 0) + 1
        return r.returncode, kinds

    rc1, k1 = errs(before)
    rc2, k2 = errs(after)
    new_kinds = {k: v for k, v in k2.items() if k not in k1}
    ok = (not new_kinds) and (rc2 == 0 or rc1 != 0)
    return ok, "改前 rc=%d/%d 种错误，改后 rc=%d/%d 种，新增类型: %s" % (
        rc1, len(k1), rc2, len(k2), new_kinds or "无")


def strip(script_bytes):
    log = []
    d = script_bytes
    # 1) 移除技能对话框里的暴击项
    d = cut(d, b"if GetUnitAbilityLevel(u, ib_critAbility) > 0 and n < 12 then",
            b"    if GetUnitAbilityLevel(u, ib_fingerAbility) > 0 and n < 12 then",
            "移除技能对话框的暴击项", log)
    # 2) 一键清空技能时的暴击处理
    d = cut(d, b"if GetUnitAbilityLevel(ib_skClrUnit, ib_critAbility) > 0 then",
            b"        if GetUnitAbilityLevel(ib_skClrUnit, ib_fingerAbility) > 0 then",
            "清空技能的暴击处理", log)
    # 3) 整个暴击系统（IB_CritRoll .. IB_CritInfo）
    i = d.find(b"function IB_CritRoll takes nothing returns integer")
    if i >= 0:
        start = d.rfind(b"//=====", 0, i)
        if start < 0:
            start = i
        j = d.find(b"function IB_CritInfo takes")
        end = d.find(b"endfunction", j) if j >= 0 else -1
        if end > 0:
            end = d.find(b"\n", end) + 1
            log.append("  删掉整个暴击系统: %d 字节" % (end - start))
            d = d[:start] + d[end:]
    # 4) 只剩注释里提到暴击的整行 -> 逐行删（**不要**跨块删，之前就是这里误删了上千行）
    keep = []
    removed_lines = 0
    for line in d.split(b"\n"):
        s = line.strip()
        if (s.startswith(b"//") and (b"IB_Crit" in line or b"ib_crit" in line)):
            removed_lines += 1
            continue
        keep.append(line)
    if removed_lines:
        log.append("  删掉 %d 行暴击注释" % removed_lines)
    d = b"\n".join(keep)
    # 5) 聊天分支 criton/critoff/crit
    for cmd in (b'"criton"', b'"critoff"', b'"crit"'):
        i = d.find(b'elseif IB_StrEqCI(cmd, ' + cmd + b") then")
        if i >= 0:
            j = d.find(b"elseif", i + 10)
            log.append("  删掉聊天分支 %s" % cmd.decode())
            d = d[:i] + d[j:]
    # 6) IB_RegisterChat7（它只注册 "crit"）+ 链条改指 Chat8
    i = d.find(b"function IB_RegisterChat7 takes nothing returns nothing")
    if i >= 0:
        j = d.find(b"endfunction", i)
        j = d.find(b"\n", j) + 1
        log.append("  删掉 IB_RegisterChat7")
        d = d[:i] + d[j:]
    if b"function IB_RegisterChat7)" in d:
        d = d.replace(b"function IB_RegisterChat7)", b"function IB_RegisterChat8)")
        log.append("  Chat6 改接 IB_RegisterChat8")
    # 7) IB_Init 里的 call IB_CritInit()
    i = d.find(b"    call IB_CritInit()")
    if i >= 0:
        j = d.find(b"\n", i) + 1
        log.append("  删掉 IB_Init 里的 call IB_CritInit()")
        d = d[:i] + d[j:]
    # 8) g.j 的暴击全局声明（**按行删**，避开 CRLF/LF 混杂与跨块删的风险）
    keep = []
    removed = 0
    for line in d.split(b"\n"):
        s = line.strip()
        if (re.match(rb"^(group|trigger|boolean|unit|integer)\s+ib_crit", s)
                or s.startswith(b"integer ib_critAbility")):
            removed += 1
            continue
        keep.append(line)
    if removed:
        log.append("  删掉 %d 行暴击全局声明" % removed)
    d = b"\n".join(keep)
    left = sorted(set(m.group(0).decode("latin-1")
                      for m in re.finditer(rb"IB_Crit\w*|ib_crit\w*|criton|critoff", d)))
    return d, log, left


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--out")
    ap.add_argument("--no-backup", action="store_true")
    args = ap.parse_args()
    mp = os.path.abspath(args.map)
    a = W.MPQArchive(mp)
    try:
        js = a.read_file("war3map.j")
    finally:
        a.close()
    if not js:
        raise SystemExit("读不到 war3map.j: %s" % mp)
    new, log, left = strip(js)
    print("== 摘除 criton: %d -> %d 字节 ==" % (len(js), len(new)))
    for line in log:
        print(line)
    print("残留标识符:", left or "无 [OK]")
    if len(new) == len(js):
        print("（脚本没变化，可能这张图本来就没有 criton）")
        return 0
    # ---- 门禁: 必须"改完之后照样能编译"，否则绝不写盘 ----
    gate_ok, note = pjass_gate(js, new)
    print("编译门禁:", note)
    if not gate_ok:
        raise SystemExit("摘除后脚本编译不过 -> 拒绝写盘（原图未改动）")
    out = os.path.abspath(args.out) if args.out else mp
    MP.patch(mp, [("war3map.j", new)], out_path=out, backup=not args.no_backup)
    ok = MP.verify(mp, out, [("war3map.j", new)])
    print("== %s ==" % ("手术完成并校验通过 [OK]" if ok else "校验失败 [NG]"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
