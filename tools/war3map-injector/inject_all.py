# -*- coding: utf-8 -*-
"""一键批量注入：一次 HKE 会话完成“脚本 + 若干内部文件”，并直接写回磁盘。

相比旧流程（inject_map.py + 多次 inject_file.py）
------------------------------------------------
旧流程每注入一个文件都要启动/打开/关闭一次 HKE，一次部署 4 次开关、
4 次固定 sleep，收尾还 taskkill；本工具只启动一次、打开一次，
连续完成全部替换，最后干净关闭。

用法:
    python inject_all.py <地图> [--script [目录]] [--file 源文件[=内部名]] ...

示例:
    # 只注入脚本
    python inject_all.py maps/campaign/chapter1.w3x --script

    # 脚本 + 三个对象数据文件（一次会话搞定）
    python inject_all.py maps/LostTemple/LostTemple_ft_hand.w3x --script ^
        --file tools/war3map-injector/_lt_hand.w3a=war3map.w3a ^
        --file tools/war3map-injector/_hand.w3t=war3map.w3t ^
        --file tools/war3map-injector/_hand_buff.w3h=war3map.w3h

    # 只需替换文件，不动脚本
    python inject_all.py maps/x.w3x --no-script --file a.w3t=war3map.w3t

参数:
    --script [DIR]   注入 DIR/f.j g.j m.j（DIR 省略时用 scripts/item-browser）
    --no-script      不注入脚本
    --file SRC[=NAME]  替换地图内部文件；NAME 省略时取 SRC 的文件名；可重复
    --script-mode {manual,native,auto}  默认 manual（自己拼脚本，最稳）
    --recompress     额外点一次「重压缩」（默认不用，见 hke_session.py 说明）
    --deploy NAME    成功后复制到 H:\\Games\\War3\\Maps\\mod\\NAME
    --no-backup      不生成 <地图>.bak
    --no-verify      跳过注入后的校验
    --dry-run        只打印将要做什么
    -q              安静模式
"""

import argparse
import os
import shutil
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)

import hke_session as hk        # noqa: E402
import inject_map as im         # noqa: E402
import inject_script_manual as ism  # noqa: E402
import fix_globals_order as fgo     # noqa: E402

DEFAULT_SCRIPT_DIR = os.path.join(BASE, "scripts", "item-browser")


def parse_file_arg(text):
    if "=" in text:
        src, internal = text.split("=", 1)
        return src, internal
    return text, os.path.basename(text)


def count_endglobals(data):
    """精确匹配整行的 endglobals 个数。

    YDWE 图里有大量 `//endglobals from XXX` 注释，HKE 自带注入按子串匹配，
    会把 f.j 插入很多份（实测 15 份）导致脚本爆炸。这里用整行匹配区分。
    """
    n = 0
    for line in data.decode("latin-1").split("\n"):
        if line.strip() == "endglobals":
            n += 1
    return n


def assemble_script(orig, script_dir):
    gj = open(os.path.join(script_dir, "g.j"), "rb").read()
    fj = open(os.path.join(script_dir, "f.j"), "rb").read()
    mj = open(os.path.join(script_dir, "m.j"), "rb").read()
    return ism.build_script(orig, gj, fj, mj)


def deploy(src, dest_name):
    """复用 deploy_mod.py 的部署逻辑（含旧版本清理），避免两处规则不一致。"""
    import deploy_mod
    return deploy_mod.deploy(src, dest_name)


def main():
    ap = argparse.ArgumentParser(
        description="一次 HKE 会话完成全部注入", add_help=True)
    ap.add_argument("map", help="地图文件 (.w3x/.w3m/.w3n)")
    ap.add_argument("--script", nargs="?", const=DEFAULT_SCRIPT_DIR,
                    default=None, help="注入脚本目录（默认 scripts/item-browser）")
    ap.add_argument("--no-script", action="store_true", help="不注入脚本")
    ap.add_argument("--file", action="append", default=[],
                    metavar="SRC[=内部名]", help="替换地图内部文件，可重复")
    ap.add_argument("--script-mode", choices=("manual", "native", "auto"),
                    default="manual")
    ap.add_argument("--recompress", action="store_true",
                    help="额外执行一次重压缩（默认跳过）")
    ap.add_argument("--deploy", metavar="NAME", default=None,
                    help="成功后部署到 mod 目录")
    ap.add_argument("--no-backup", action="store_true")
    ap.add_argument("--no-verify", action="store_true")
    ap.add_argument("--kill-stale", action="store_true",
                    help="开始前先结束残留的 HKE 进程（上一次被强杀留下的）")
    ap.add_argument("--list", action="store_true",
                    help="只列出地图内部文件后退出（诊断用）")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("-q", "--quiet", action="store_true")
    args = ap.parse_args()

    map_path = os.path.abspath(args.map)
    if not os.path.isfile(map_path):
        print("地图不存在: %s" % map_path)
        return 1

    if args.list:
        if args.kill_stale:
            import subprocess
            subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"],
                           capture_output=True)
        sess = hk.HkeSession(verbose=not args.quiet)
        try:
            sess.start()
            sess.open(map_path)
            for name in sess.analyze():
                print("  %s" % name)
        finally:
            sess.close()
        return 0

    script_dir = os.path.abspath(args.script) if args.script else None
    if args.no_script:
        script_dir = None
    if script_dir and not os.path.isfile(os.path.join(script_dir, "f.j")):
        print("脚本目录里没有 f.j: %s" % script_dir)
        return 1

    files = []
    for spec in args.file:
        src, internal = parse_file_arg(spec)
        src = os.path.abspath(src)
        if not os.path.isfile(src):
            print("要替换的文件不存在: %s" % src)
            return 1
        files.append((src, internal))

    if not script_dir and not files:
        print("没有指定任何操作。用 --script 注入脚本，或用 --file 替换文件。")
        return 1

    print("地图      : %s" % map_path)
    print("脚本      : %s" % (script_dir or "(不注入)"))
    for src, internal in files:
        print("替换      : %s -> %s" % (os.path.basename(src), internal))
    if args.dry_run:
        print("(dry-run，未执行)")
        return 0

    t_start = time.time()
    size_before = os.path.getsize(map_path)
    if not args.no_backup:
        backup = map_path + ".bak"
        if not os.path.exists(backup):
            shutil.copy2(map_path, backup)
            print("已备份    : %s" % backup)

    notes = []
    ok = True
    if args.kill_stale:
        im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"],
                          capture_output=True)
        time.sleep(0.5)
        print("已清理残留 HKE 进程")
    sess = hk.HkeSession(verbose=not args.quiet)
    try:
        sess.start()
        sess.open(map_path)
        listing = sess.analyze()

        # ---------------- 脚本 ----------------------------------------
        if script_dir:
            mode = args.script_mode
            if mode == "auto":
                orig = sess.extract("war3map.j")
                mode = "manual" if count_endglobals(orig) > 1 else "native"
                print("脚本模式  : auto -> %s（endglobals 整行 %d 处）"
                      % (mode, count_endglobals(orig)))
            else:
                orig = sess.extract("war3map.j")
            if mode == "native":
                if count_endglobals(orig) > 1:
                    print("警告      : 该图有 %d 处 endglobals，HKE 原生注入会插入多份，"
                          "建议改用 --script-mode manual" % count_endglobals(orig))
                sess.inject_script_native(script_dir)
                # HKE 把 g.j 插到 globals 块最前面；若地图以 constant 声明开头，
                # 我们的非 constant 变量就排在 constant 之前 -> JASS 编译失败。
                # 原来要再开一次工具跑 fix_globals_order.py，这里顺手做掉。
                if not args.no_verify:
                    data = sess.extract("war3map.j")
                    fixed, changed = fgo.fix_order(data.decode("latin-1"))
                    if changed:
                        rp = os.path.join(HERE, "_rep", "war3map.j")
                        os.makedirs(os.path.dirname(rp), exist_ok=True)
                        with open(rp, "wb") as fh:
                            fh.write(fixed.encode("latin-1"))
                        sess.replace(rp, "war3map.j")
                        print("globals   : 已把自定义变量移到 constant 之后（原需再开一次工具）")
                    else:
                        print("globals   : 顺序本来就正确")
            else:
                new = assemble_script(orig, script_dir)
                rep = os.path.join(HERE, "_rep")
                os.makedirs(rep, exist_ok=True)
                rp = os.path.join(rep, "war3map.j")
                with open(rp, "wb") as fh:
                    fh.write(new)
                print("脚本装配  : %d -> %d 字节（自己拼装，绕过 HKE 的 endglobals bug）"
                      % (len(orig), len(new)))
                sess.replace(rp, "war3map.j")
                # 趁工具还“干净”立刻校验脚本；HKE 连续操作多次后解压会失灵
                if not args.no_verify:
                    try:
                        got = sess.extract("war3map.j")
                        calls = got.count(b"call IB_Init()")
                        has_def = b"IB_Init" in got
                        print("脚本校验  : %d 字节, IB_Init 定义=%s, 调用=%d 处"
                              % (len(got), has_def, calls))
                        if not has_def or calls != 1:
                            ok = False
                            notes.append("脚本校验不通过（定义=%s 调用=%d）"
                                         % (has_def, calls))
                    except hk.HkeError as e:
                        print("脚本校验  : 跳过（%s）" % e)
                        notes.append("脚本校验被跳过")

        # ---------------- 内部文件 ------------------------------------
        for src, internal in files:
            sess.replace(src, internal)

        if args.recompress:
            before, after = sess.recompress()
            print("重压缩    : %d -> %d 字节" % (before[0], after[0]))
            if before == after:
                print("             （未产生变化——该工具的常见表现）")

        # ---------------- 收尾校验 ------------------------------------
        if files and not args.no_verify:
            now = sess.list_files()
            missing = [i for _, i in files
                       if not any(f.lower() == i.lower() for f in now)]
            if missing:
                ok = False
                notes.append("列表里没有: %s" % missing)
                print("校验      : 缺失 %s" % missing)
            else:
                print("校验      : %d 个内部文件均已就位" % len(files))
    except hk.HkeError as e:
        print("失败      : %s" % e)
        ok = False
    finally:
        sess.close()

    size_after = os.path.getsize(map_path)
    print("")
    print("=== %s ===" % ("完成" if ok else "未完成"))
    print("地图      : %s" % map_path)
    print("大小      : %d -> %d (%+d)" % (size_before, size_after, size_after - size_before))
    print("耗时      : %.1fs（旧流程约需 4 次开关工具、约 100s+）" % (time.time() - t_start))
    if notes:
        print("注意      : %s" % "; ".join(notes))

    if ok and args.deploy:
        try:
            dest, removed = deploy(map_path, args.deploy)
            print("已部署    : %s" % dest)
            for r in removed:
                print("           移除旧版本 %s" % r)
        except OSError as e:
            # 目标被占用（例如正开着游戏）不该算注入失败: 地图本身已经改好了
            print("部署失败  : %s" % e)
            print("           地图已改好，只是没法复制到 mod 目录（关掉游戏后重跑 deploy 即可）")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
