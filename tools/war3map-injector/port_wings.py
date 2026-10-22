# -*- coding: utf-8 -*-
"""把"翅膀 / 坐骑"系统移植到任意一张地图（一条命令走完）。

用法:
    python port_wings.py <目标图> [--name 输出名] [--deploy]
                         [--config 配置模块名] [--no-fix-ids]
                         [--no-hand] [--no-item-browser] [--dry-run]

做了这些事:
  1. 给这张图准备一份**独立配置**（复制 wings_config.py -> wings_config_<图名>.py），
     这样移植不会动到 LostTemple 用的那份；
  2. 扫目标图已占用的 ID，把冲突的自动换成空闲的（写回独立配置）——
     **包含阿克蒙德之手的 5 个 ID**（物品 + 4 个技能）；
  3. 用该配置生成我们的对象数据 + JASS 表；
  4. 解出目标图自己的 w3a/w3t/w3u/w3h，和我们的条目**保留 orig/custom 分段**地合并；
  5. 给这张图做一份"物品浏览器"副本（表里并入本系统自己注入的东西：
     阿克蒙德之手 / 3 件翅膀 / 5 个蛋，否则 `additem 阿克蒙德之手` 找不到）；
  6. 一次 HKE 会话注入：物品浏览器脚本 + 翅膀脚本 + 4 个对象数据 + 翅膀模型；
  7. 收尾（`--deploy` 时复制到 H:\\Games\\War3\\Maps\\mod）。

注意:
  * 目标图必须"没被壳化/加密"（war3map.j 是真脚本）。判断: python probe_names.py <图>
  * 注入用的脚本拼装是「读目标图自己的脚本 + 追加我们的模块」，所以地图原有逻辑保留。
"""
import argparse
import importlib
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or "c:/python313/python.exe"
# 控制台是 GBK 时，print 里出现 ✓/⚠ 这种字符会直接抛 UnicodeEncodeError
#   （以前注入成功、却在最后一步"校验"崩掉就是这个原因）→ 统一改成不崩的输出。
try:
    sys.stdout.reconfigure(errors="replace")
    sys.stderr.reconfigure(errors="replace")
except Exception:
    pass
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
from merge_w3obj import merge_files, read_all  # noqa: E402

OBJ_FILES = [("war3map.w3a", "w3a"), ("war3map.w3t", "w3t"),
             ("war3map.w3u", "w3u"), ("war3map.w3h", "w3h")]
WING_MODELS = [
    ("wingofthelucifer.mdx", "WingOfTheLucifer.MDX"),
    ("wingblack4.blp", "WingBlack4.blp"),
    ("fwind.mdx", "FWIND.MDX"),
    ("fwing.blp", "FWING.blp"),
    ("doomgguardwings.mdx", "DoomgGuardWings.mdx"),
    # 星魂之力（燃烧之怒 194213 的神器挂件，挂 chest）：模型 + 它引用的 4 张贴图。
    #   贴图在模型里是**裸文件名**，所以都写到地图根目录（同名即可被找到）。
    ("anchibang0100.mdx", "anchibang0100.mdx"),
    ("anchibang01.blp", "anchibang01.blp"),
    ("anchibang02.blp", "anchibang02.blp"),
    ("anchibang03.blp", "anchibang03.blp"),
    ("anchibang04.blp", "anchibang04.blp"),
    # 物品的"地面模型"（燃烧之怒里神器掉地上会发光的那套 Chest_*.mdx）：
    #   贴图全是游戏自带的，只有传说款还要两张符文图（一起带上）。
    ("Chest_Purple.mdx", "Chest_Purple.mdx"),
    ("Chest_Yellow.mdx", "Chest_Yellow.mdx"),
    ("Chest_Black.mdx", "Chest_Black.mdx"),
    ("Chest_LightBlue.mdx", "Chest_LightBlue.mdx"),
    ("Chest_Legendary.mdx", "Chest_Legendary.mdx"),
    ("ChestOrangeRunes1.blp", "ChestOrangeRunes1.blp"),
    ("ChestOrangeRunes2.blp", "ChestOrangeRunes2.blp"),
    # 「灰烬雷暴」的两个特效模型（燃烧之怒里 A6V0 用的那对，模型自带贴图）：
    #   StormfallRed = 雷暴环 / 二阶火箭弹道；ssw1 = 施法者起手
    ("StormfallRed.mdx", "StormfallRed.mdx"),
    ("ssw1.mdx", "ssw1.mdx"),
]
MODEL_DIR = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def model_src(name):
    """模型源文件：默认取"伏魔战记"里的存量，没有就回退到 maps\\_wing_src
    （星魂之力的模型只存在于那个目录）。"""
    p = os.path.join(MODEL_DIR, name)
    if os.path.exists(p):
        return p
    return os.path.join(BASE, "maps", "_wing_src", name)


def slug(path):
    name = os.path.splitext(os.path.basename(path))[0]
    return re.sub(r"[^0-9A-Za-z_]+", "_", name).strip("_") or "target"


def run(args, env=None, allow_fail=False):
    print(">>>", " ".join(str(a) for a in args), flush=True)
    e = dict(os.environ)
    e.setdefault("PYTHONIOENCODING", "utf-8")
    if env:
        for k, v in env.items():
            if v is None:          # env={"XXX": None} = 显式删掉这个变量
                e.pop(k, None)
            else:
                e[k] = v
    r = subprocess.run(args, capture_output=True, env=e)
    out = (r.stdout + r.stderr).decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    if r.returncode != 0 and not allow_fail:
        raise SystemExit("命令失败: %s" % args[1:3])
    return r.returncode


def extract_objects(map_path, out_dir):
    """用 MPQ 读取器解出目标图自己的对象数据（只对未加密的图有效）。"""
    os.makedirs(out_dir, exist_ok=True)
    got = []
    a = W.MPQArchive(map_path)
    try:
        j = a._find_file("war3map.j")
        if not j or j.fsize < 4096:
            raise SystemExit("目标图的 war3map.j 只有 %s 字节 —— 像是壳化/加密图，先找解密版。"
                             % (j.fsize if j else "?"))
        for internal, ext in OBJ_FILES:
            data = a.read_file(internal)
            if not data:
                continue
            p = os.path.join(out_dir, "target." + ext)
            open(p, "wb").write(data)
            got.append((internal, p, len(data)))
    finally:
        a.close()
    for internal, p, n in got:
        print("  解出 %-14s %8d 字节 -> %s" % (internal, n, os.path.basename(p)))
    return got


def prepare_item_browser(work_dir, cfg_module, cfg, src_path=None):
    """给目标图做一份物品浏览器副本。

    表 = 游戏标准物品/技能（collect_items / collect_skills 从游戏数据里取）
        + 目标图自己的对象数据（war3map.w3t / w3a）
        + **"SLK 化"图内联在 units\\*.slk 里的自定义物品/技能**（gen_slk_tables）
        + 本系统自己注入的东西（gen_ib_extras）
    src_path 传地图文件（.w3x）或已解包的目录（战役用 base/）。
    """
    src = os.path.join(BASE, "scripts", "item-browser")
    dst = os.path.join(work_dir, "item-browser")
    os.makedirs(dst, exist_ok=True)
    for fn in ("f.j", "g.j", "m.j"):
        shutil.copy2(os.path.join(src, fn), os.path.join(dst, fn))
    env = {"WINGS_CONFIG": cfg_module, "IB_OUT_DIR": dst, "IB_EXTRA_DIR": work_dir,
           "IB_BASE_DIR": work_dir,
           "IB_FINGER_ABILITY": cfg.HAND["finger"], "IB_CRIT_ABILITY": cfg.HAND["crit"]}
    # 0) 把目标图自己的对象数据/SLK 摊到 <work>/_ibsrc（collect_* 按 war3map.* 名字找）
    if src_path:
        stage = os.path.join(work_dir, "_ibsrc")
        os.makedirs(stage, exist_ok=True)
        wanted = ["war3map.w3t", "war3map.w3a", "war3map.w3u", "war3map.wts",
                  "units\\itemdata.slk", "units\\abilitydata.slk",
                  "units\\itemstrings.txt", "units\\itemfunc.txt"]
        for internal in wanted:
            data = None
            if os.path.isdir(src_path):
                p = os.path.join(src_path, internal.replace("\\", os.sep))
                data = open(p, "rb").read() if os.path.exists(p) else None
            else:
                try:
                    ar = W.MPQArchive(src_path)
                    data = ar.read_file(internal)
                    ar.close()
                except Exception as e:
                    print("  ! 读图内 %s 失败: %s" % (internal, e))
            if data:
                outp = os.path.join(stage, internal.replace("\\", os.sep))
                os.makedirs(os.path.dirname(outp), exist_ok=True)
                open(outp, "wb").write(data)
        run([PY, os.path.join(HERE, "collect_items.py")], env=env)
        run([PY, os.path.join(HERE, "collect_map_items.py"), stage], env=env)
        run([PY, os.path.join(HERE, "collect_skills.py"), stage], env=env)
        run([PY, os.path.join(HERE, "gen_slk_tables.py"), stage], env=env)
    # 1) 本系统自己注入的东西（地图里扫不到）-> <work>/_itemids_extra.txt
    run([PY, os.path.join(HERE, "gen_ib_extras.py"), work_dir], env=env)
    # 1b) **单位表**（`addunit` / `listunit` 用）：游戏标准单位清单，与目标图无关。
    #     ⚠ 这里以前没做 —— 战役移植那条"默认没有单位表"的记录就是这个原因。
    #     已经有现成的就用现成的（没有才现场从游戏数据里生成）。
    tbl = os.path.join(work_dir, "_unitids.txt")
    if not os.path.exists(tbl):
        if not os.path.exists(os.path.join(HERE, "_unitids.txt")):
            run([PY, os.path.join(HERE, "collect_game_units.py")], env=env)
        std = os.path.join(HERE, "_unitids.txt")
        if os.path.exists(std):
            shutil.copy2(std, tbl)
            print("   单位表 -> %s（%d 行）" % (tbl, sum(1 for _ in open(tbl, encoding="utf-8"))))
    # 2) 把补充表并进 f.j，并把死亡之指/致命一击的技能 ID 写进 g.j
    run([PY, os.path.join(HERE, "build_fj.py")], env=env)
    return dst


FUNC_RE = re.compile(r"^function\s+([A-Za-z_][A-Za-z0-9_]*)\s+takes", re.M)


def check_script_clash(target, script_dirs):
    """注入前查重名：我们的模块函数名不能和目标图自己的脚本函数重名。

    重名会让整张图的脚本编译失败（地图直接打不开），而 HKE 注入本身不会报错，
    所以这一步必须在注入前做。
    """
    a = W.MPQArchive(target)
    try:
        data = a.read_file("war3map.j") or b""
    finally:
        a.close()
    map_fns = set(FUNC_RE.findall(data.decode("latin-1")))
    bad = []
    for d in script_dirs:
        f = set(FUNC_RE.findall(
            open(os.path.join(d, "f.j"), encoding="utf-8", errors="replace").read()))
        clash = sorted(f & map_fns)
        print("  重名检查 %-24s 模块函数 %3d，重名: %s"
              % (os.path.basename(d), len(f), clash or "无"))
        bad += ["%s.%s" % (os.path.basename(d), c) for c in clash]
    if bad:
        raise SystemExit("脚本函数重名，注入后地图会编译失败: %s" % ", ".join(bad))


def verify_injected(dst, pairs):
    """注入后**读回地图**，逐个文件和本地构件逐字节比对（war3mpq 已能完整读 HKE 写的图）。"""
    a = W.MPQArchive(dst)
    try:
        for internal, local in pairs:
            if not os.path.exists(local):
                print("  校验 %-14s 本地文件不存在，跳过" % internal)
                continue
            got = a.read_file(internal)
            want = open(local, "rb").read()
            ok = (got == want)
            print("  校验 %-14s %s（%d 字节）"
                  % (internal, "逐字节一致 [OK]" if ok else "不一致 [NG]", len(want)))
            if not ok:
                raise SystemExit("注入校验失败: %s（读回 %s 字节，本地 %s 字节）"
                                 % (internal, len(got or b""), len(want)))
    finally:
        a.close()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--name", help="部署到 Maps\\mod 下的文件名（默认 <原图名>_wings.w3x）")
    ap.add_argument("--config", help="用指定的配置模块（默认自动生成一份独立配置）")
    ap.add_argument("--deploy", action="store_true", help="构建成功后部署到 Maps\\mod")
    ap.add_argument("--no-fix-ids", action="store_true", help="不自动换冲突 ID（只报告）")
    ap.add_argument("--no-hand", action="store_true", help="不带阿克蒙德之手（默认带）")
    ap.add_argument("--no-item-browser", action="store_true",
                    help="不注入物品浏览器（默认注入；没有它就只能用 wing/mount 命令）")
    ap.add_argument("--native", action="store_true",
                    help="用原生 MPQ 写入器注入（不走 HKE；没有 (listfile) 的图必须用它）")
    ap.add_argument("--profile-original", action="store_true",
                    help="坐骑数值用「只加不改」档位（伤害/护甲等全部继承原版；战役/别人家的图推荐）")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    target = os.path.abspath(args.map)
    if not os.path.isfile(target):
        raise SystemExit("找不到地图: %s" % target)
    s = slug(target)

    # 1) 独立配置（不影响 LostTemple 那份）
    if args.config:
        cfg_module = args.config
    else:
        cfg_module = "wings_config_" + s
        cfg_path = os.path.join(HERE, cfg_module + ".py")
        if not os.path.exists(cfg_path):
            shutil.copy2(os.path.join(HERE, "wings_config.py"), cfg_path)
            print("已生成独立配置:", os.path.basename(cfg_path))
        else:
            print("沿用以有独立配置:", os.path.basename(cfg_path))
        if args.profile_original:
            import port_wings_campaign as PC
            src = open(cfg_path, encoding="utf-8").read()
            n = 0
            for before, after, cnt in PC.PROFILE:
                if before in src:
                    src = src.replace(before, after, cnt)
                    n += 1
            if "hp_regen=None," in src:
                src = src.replace(
                    "usca=1.0, ussc=1.5, egg_scale=0.936, hero_h_off=15.0)",
                    "usca=1.0, ussc=1.5, egg_scale=0.936, hero_h_off=15.0, hp_regen=2.0)")
            # 移植到别人家的图时不带「试穿」款（它们是我们挑模型用的，模型文件也没随行）
            src += ("\n\n# --- 移植模式: 不带试穿款 ---\n"
                    "TEST_WINGS = []\nTEST_ARTS = []\nITEM_OVERRIDES = []\n")
            open(cfg_path, "w", encoding="utf-8").write(src)
            print("已套用「只加不改」档位（%d 处；凤凰仍写 hp_regen=2.0）" % n)
    cfg_env = {"WINGS_CONFIG": cfg_module}
    os.environ["WINGS_CONFIG"] = cfg_module
    cfg = importlib.import_module(cfg_module)

    # 2) 冲突检查 / 自动换 ID
    print("\n=== 1/5 检查 ID 冲突 ===")
    if args.no_fix_ids or args.dry_run:
        run([PY, os.path.join(HERE, "pick_ids.py"), target, "--check"], env=cfg_env)
    else:
        run([PY, os.path.join(HERE, "pick_ids.py"), target, "--write"], env=cfg_env)
        importlib.reload(cfg)
    if args.dry_run:
        print("（dry-run：到此为止）")
        return 0

    # 3) 生成我们的数据（用独立配置）
    print("\n=== 2/5 生成翅膀/坐骑数据 ===")
    run([PY, os.path.join(HERE, "build_wings.py")], env=cfg_env)

    # 4) 解出目标图对象数据并合并
    print("\n=== 3/5 解出目标图对象数据并合并 ===")
    work = os.path.join(BASE, "maps", "port", s)
    os.makedirs(work, exist_ok=True)
    got = extract_objects(target, work)
    if args.no_hand:
        ours_of = {"w3a": "_wing_nohand.w3a", "w3t": "_wing_item_nohand.w3t",
                   "w3u": "_wing_unit.w3u", "w3h": "_wing_buff.w3h"}
    else:
        ours_of = {"w3a": "_wing.w3a", "w3t": "_wing_item.w3t",
                   "w3u": "_wing_unit.w3u", "w3h": "_wing_buff.w3h"}
    merged = []
    for internal, tpath, _n in got:
        ext = internal.rsplit(".", 1)[-1]
        ours = os.path.join(HERE, ours_of.get(ext, ""))
        outp = os.path.join(work, "merged." + ext)
        if os.path.exists(ours):
            n_orig, n_cust = merge_files(outp, [tpath, ours])
            print("  %s: 目标图 %s + 我们 -> %d orig / %d custom"
                  % (internal, os.path.basename(tpath), n_orig, n_cust))
        else:
            shutil.copy2(tpath, outp)
            print("  %s: 只有目标图的（我们不提供这个文件）: %s" % (internal, ours))
        merged.append((outp, internal))
    # 目标图**没有**的对象数据文件（例如 W3x2lni "SLK 化"的图没有 w3t/w3u/w3h）：
    #   直接用我们的那份新建（对象数据优先级高于 slk，游戏会叠加读取）。
    for internal, ours_name in ours_of.items():
        if any(i == "war3map." + internal for _o, i in merged):
            continue
        src = os.path.join(HERE, ours_name)
        if not os.path.exists(src):
            continue
        outp = os.path.join(work, "merged." + internal)
        shutil.copy2(src, outp)
        merged.append((outp, "war3map." + internal))
        print("  war3map.%s: 目标图没有 → 用我们的新建（%d 字节）"
              % (internal, os.path.getsize(outp)))

    # 5) 物品浏览器副本（阿克蒙德之手要能被 additem 找到）
    ib_dir = None
    if not args.no_item_browser:
        print("\n=== 4/5 准备物品浏览器 ===")
        ib_dir = prepare_item_browser(work, cfg_module, cfg, target)

    # 6) 注入 + 校验 + 部署
    print("\n=== 5/5 注入 ===")
    dst = os.path.join(work, os.path.basename(target))
    shutil.copy2(target, dst)
    script_dirs = ([ib_dir] if ib_dir else []) + [os.path.join(BASE, "scripts", "wings")]
    print("注入前重名检查（模块函数 vs 目标图脚本）：")
    check_script_clash(target, script_dirs)
    injector = "inject_native.py" if args.native else "inject_all.py"
    inject = [PY, os.path.join(HERE, injector), dst]
    if not args.native:
        inject += ["--script-mode", "manual", "--kill-stale"]
    for d in script_dirs:
        inject += ["--script", d]
    for outp, internal in merged:
        inject += ["--file", outp + "=" + internal]
    verify_pairs = [(internal, outp) for outp, internal in merged]
    for srcname, internal in WING_MODELS:
        p = model_src(srcname)
        if os.path.exists(p):
            inject += ["--file", p + "=" + internal]
        else:
            print("  ! 缺模型:", p)
    if args.deploy:
        out_name = args.name or (os.path.splitext(os.path.basename(target))[0] + "_wings.w3x")
        inject += ["--deploy", out_name]
    run(inject)

    print("\n注入结果校验（读回地图，和本地构件逐字节比对）：")
    verify_injected(dst, verify_pairs + [("war3map.j", os.path.join(HERE, "_rep", "war3map.j"))])
    print("\n产物地图:", dst)
    # 把生成物恢复成默认配置的版本，避免下次构建 LostTemple 时混淆。
    #   ⚠ 必须把 WINGS_CONFIG 删掉：main 里为了 import 配置把它写进了 os.environ，
    #     不删的话"恢复"跑的还是这张图的配置（实测踩过）。
    run([PY, os.path.join(HERE, "build_wings.py")],
        env={"WINGS_CONFIG": None}, allow_fail=True)
    print("（已把 _wing.* 生成物恢复为默认配置的版本）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
