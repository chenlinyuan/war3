# -*- coding: utf-8 -*-
"""把已经注入过旧 item-browser 脚本的地图里 **item-browser 版「死亡之指」** 摘掉。

背景：死亡之指以前是 item-browser（IB）模块实现的：`IB_FingerOnCast` 在
      EVENT_PLAYER_UNIT_SPELL_EFFECT 里判断 `GetSpellAbilityId() == ib_fingerAbility`
      （写死 'A000'），然后打 1,000,000 点万能伤害 —— 也就是"绝对秒杀"。
      2026-10-15 玩家把死亡之指改成"按最高属性算的混沌伤害 + 冷却/耗魔分档"，
      改由 **翅膀模块**（scripts/wings 的 WG_OnFinger）实现；旧的 IB 版要是还挂着，
      同一个技能会**同时**吃两套逻辑（1e6 秒杀 + 新公式）→ 必须摘掉。

做法：**只删掉一行** `call IB_FingerCastInit()`（IB_Init 里的注册调用），
      触发器就不会创建，那套旧逻辑等于关掉；聊天命令 `finger`/`deathfinger`
      仍然保留（那是测试用的调试命令，不走技能）。

用法:
    python strip_ib_finger.py <地图> [--out 输出] [--no-backup]
    python strip_ib_finger.py --file scripts/item-browser/f.j    # 改**模板**（物品浏览器源码）
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import mpq_patch as MP  # noqa: E402
import war3mpq as W  # noqa: E402


def strip(data):
    """返回 (新脚本, 日志, 残留标识符)。"""
    log = []
    needle = b"    call IB_FingerCastInit()"
    i = data.find(needle)
    if i < 0:
        # 兼容别的缩进/行尾
        i = data.find(b"call IB_FingerCastInit()")
    if i < 0:
        log.append("  (没有 call IB_FingerCastInit() —— 可能已经摘过)")
        return data, log, []
    # 往前吃到行首（缩进），往后吃到换行符（含）
    start = data.rfind(b"\n", 0, i) + 1
    end = data.find(b"\n", i)
    end = len(data) if end < 0 else end + 1
    log.append("  删掉 IB_Init 里的注册调用（%d 字节）" % (end - start))
    out = data[:start] + data[end:]
    left = []
    for tag in (b"call IB_FingerCastInit()", b"IB_FingerOnCast"):
        if tag in out and tag == b"call IB_FingerCastInit()":
            left.append(tag.decode("latin-1"))
    return out, log, left


def pjass_gate(before, after):
    """门禁: 改完**不能**出现新的编译错误类型。"""
    import subprocess
    import validate_dir as V

    def errs(data):
        p = os.path.join(HERE, "_sif.j")
        open(p, "wb").write(data)
        r = subprocess.run([V.PJASS, V.COMMON, V.BLIZZ, p], capture_output=True)
        txt = (r.stdout + r.stderr).decode("utf-8", "replace")
        kinds = set()
        for line in txt.splitlines():
            if "failed" in line or "Parse successful" in line:
                continue
            parts = line.split(":")
            if len(parts) >= 2:
                kinds.add(parts[-1].strip()[:40])
        return r.returncode, kinds

    rc0, k0 = errs(before)
    rc1, k1 = errs(after)
    new = k1 - k0
    note = "pjass before rc=%d kinds=%d | after rc=%d kinds=%d | new kinds=%s" % (
        rc0, len(k0), rc1, len(k1), new or "-")
    return (not new), note


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map", nargs="?")
    ap.add_argument("--file", default="",
                    help="直接改这个 .j 文件（模板源码；按字节改，能处理混了 GBK 名字表的 f.j）")
    ap.add_argument("--out")
    ap.add_argument("--no-backup", action="store_true")
    args = ap.parse_args()
    if args.file:
        # 模板源码模式：只做"删掉注册调用"这件事，原样写回（字节级，不动其它编码）
        p = os.path.abspath(args.file)
        data = open(p, "rb").read()
        new, log, left = strip(data)
        print("== 摘除 IB 版死亡之指（模板）: %d -> %d 字节 ==" % (len(data), len(new)))
        for line in log:
            print(line)
        print("残留注册调用:", left or "无 [OK]")
        if len(new) != len(data):
            open(p, "wb").write(new)
            print("已写回:", p)
        return 0
    if not args.map:
        raise SystemExit("用法: strip_ib_finger.py <地图>  或  --file <f.j>")
    mp = os.path.abspath(args.map)
    a = W.MPQArchive(mp)
    try:
        js = a.read_file("war3map.j")
    finally:
        a.close()
    if not js:
        raise SystemExit("读不到 war3map.j: %s" % mp)
    new, log, left = strip(js)
    print("== 摘除 IB 版死亡之指: %d -> %d 字节 ==" % (len(js), len(new)))
    for line in log:
        print(line)
    print("残留注册调用:", left or "无 [OK]")
    if len(new) == len(js):
        print("（脚本没变化，可能这张图本来就没有 IB 版死亡之指）")
        return 0
    ok_gate, note = pjass_gate(js, new)
    print("编译门禁:", note)
    if not ok_gate:
        raise SystemExit("摘除后脚本编译不过 -> 拒绝写盘（原图未改动）")
    out = os.path.abspath(args.out) if args.out else mp
    MP.patch(mp, [("war3map.j", new)], out_path=out, backup=not args.no_backup)
    ok = MP.verify(mp, out, [("war3map.j", new)])
    print("== %s ==" % ("手术完成并校验通过 [OK]" if ok else "校验失败 [NG]"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
