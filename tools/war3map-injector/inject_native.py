# -*- coding: utf-8 -*-
"""原生注入（不走 HKE GUI）：把脚本模块 + 若干内部文件写进地图。

和 inject_all.py 的区别：
  * 读脚本、写文件都用我们自己的 MPQ 读写器（见 mpq_patch.py），
    **完全保留原档案的所有老条目**（没有 (listfile) 的图也不会丢资源）；
  * 几秒完成（HKE 一次要 ~100 秒）。

用法:
    python inject_native.py <地图> [--script DIR]... [--file 源文件=内部名]...
                            [--out 输出] [--deploy 名字] [--no-backup] [--no-verify]
"""
import argparse
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
import inject_all as IA  # noqa: E402  (复用 entry_points / 默认脚本目录)
import inject_script_manual as ISM  # noqa: E402
import mpq_patch as MP  # noqa: E402


def assemble(orig_script, script_dirs):
    gj = b"\n\n".join(open(os.path.join(d, "g.j"), "rb").read() for d in script_dirs)
    fj = b"\n\n".join(open(os.path.join(d, "f.j"), "rb").read() for d in script_dirs)
    mj = b"\n\n".join(open(os.path.join(d, "m.j"), "rb").read() for d in script_dirs)
    return ISM.build_script(orig_script, gj, fj, mj)


def check_entry_points(script_bytes, script_dirs):
    bad = []
    for name in IA.entry_points(script_dirs):
        n_def = script_bytes.count(name.encode())
        # 入口可能有两种形态：直接 `call XXX()`，或（默认）包进 0 秒定时器
        #   `call TimerStart(CreateTimer(), 0.0, false, function XXX)`
        n_call = (script_bytes.count(b"call " + name.encode() + b"()")
                  + script_bytes.count(b"function " + name.encode() + b")"))
        if n_def and n_call:
            print("   入口 %-10s 定义/引用=%d, 调用=%d" % (name, n_def, n_call))
        else:
            bad.append("%s(定义=%d 调用=%d)" % (name, n_def, n_call))
    return bad


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--script", action="append", default=[], metavar="DIR")
    ap.add_argument("--base-script",
                    help="使用额外的 war3map.j 作为脚本基底（用于先打补丁再合模块）")
    ap.add_argument("--file", action="append", default=[], metavar="SRC=内部名")
    ap.add_argument("--store", action="append", default=[], metavar="内部名",
                    help="该内部文件原样存储(不压缩)。战役 .w3n 的章节地图必须这样写")
    ap.add_argument("--out")
    ap.add_argument("--deploy")
    ap.add_argument("--no-backup", action="store_true")
    ap.add_argument("--no-verify", action="store_true")
    ap.add_argument("--skip-clash-check", action="store_true")
    args = ap.parse_args()

    map_path = os.path.abspath(args.map)
    if not os.path.isfile(map_path):
        raise SystemExit("找不到地图: %s" % map_path)
    script_dirs = [os.path.abspath(d) for d in args.script]
    for d in script_dirs:
        if not os.path.isfile(os.path.join(d, "f.j")):
            raise SystemExit("脚本目录里没有 f.j: %s" % d)
    payload = []
    for spec in args.file:
        if "=" not in spec:
            raise SystemExit("--file 参数格式应为 源文件=内部名: %s" % spec)
        src, internal = spec.split("=", 1)
        payload.append((internal, open(src, "rb").read()))

    # --- 脚本 ---
    if script_dirs:
        print("== 组装脚本 ==")
        if args.base_script:
            orig = open(os.path.abspath(args.base_script), "rb").read()
        else:
            ar = W.MPQArchive(map_path)
            try:
                orig = ar.read_file("war3map.j")
            finally:
                ar.close()
        if not orig:
            raise SystemExit("地图里读不到 war3map.j（壳化/加密图？）")
        if not args.skip_clash_check:
            import port_wings as P
            print("   重名检查:")
            P.check_script_clash(map_path, script_dirs)
        new = assemble(orig, script_dirs)
        bad = check_entry_points(new, script_dirs)
        if bad:
            raise SystemExit("脚本入口没就位: %s" % ", ".join(bad))
        print("   脚本: %d -> %d 字节" % (len(orig), len(new)))
        # 存一份组装结果（和 HKE 流程一致，方便事后核对/排查）
        rep = os.path.join(HERE, "_rep")
        os.makedirs(rep, exist_ok=True)
        with open(os.path.join(rep, "war3map.j"), "wb") as fh:
            fh.write(new)
        payload.append(("war3map.j", new))

    if not payload:
        raise SystemExit("没有要写的东西（给 --script 或 --file）")

    print("== 写入（原生 MPQ）==")
    out_path = os.path.abspath(args.out) if args.out else None
    if out_path and out_path != map_path:
        shutil.copy2(map_path, out_path)
    target = out_path or map_path
    # 就地打补丁时，先留一份"改前"临时副本，校验要拿它做基准
    #   （否则 verify 会拿文件和自己比，报出假的不一致）
    tmp_before = None
    if target == map_path:
        tmp_before = map_path + ".verifybase"
        shutil.copy2(map_path, tmp_before)
    new_path = MP.patch(target, payload, out_path=None, backup=not args.no_backup,
                        store=args.store)
    ok = True
    if not args.no_verify:
        print("== 校验 ==")
        ok = MP.verify(tmp_before or map_path, new_path, payload)
        print("== %s ==" % ("校验通过 [OK]" if ok else "校验失败 [NG]"))
    if tmp_before and os.path.exists(tmp_before):
        os.remove(tmp_before)
    if ok and args.deploy:
        import deploy_mod
        dest, removed = deploy_mod.deploy(new_path, args.deploy)
        print("已部署:", dest)
        for r in removed:
            print("   移除旧版本:", r)
    print("产物:", new_path)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
