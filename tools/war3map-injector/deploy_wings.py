"""一键部署翅膀/坐骑系统到 Lost Temple 地图。

步骤:
  1. 从源地图复制工作副本
  2. 注入脚本 (scripts/wings)
  3. 注入技能 w3a (_wing.w3a)
  4. 注入物品 w3t (_wing_item.w3t)
  5. 注入模型 (wingofthelucifer / wingblack4 / fwind / fwing / doomgguardwings)
  6. 部署到 H:\\Games\\War3\\Maps\\mod

用法:
    python deploy_wings.py [源地图] [目标名]
"""
import os, shutil, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or "c:/python313/python.exe"

FMZJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")
DEFAULT_SRC = os.path.join(BASE, "maps", "LostTemple", "LostTemple_ft_hand.w3x")
DEFAULT_DST = os.path.join(BASE, "maps", "LostTemple", "LostTemple_wings.w3x")


def run(args):
    print(">>>", " ".join(str(a) for a in args))
    r = subprocess.run(args, capture_output=True)
    out = r.stdout.decode("utf-8", "replace") + r.stderr.decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    if r.returncode != 0:
        raise SystemExit("command failed: %s" % args)


def main():
    src = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_SRC
    dst = sys.argv[2] if len(sys.argv) > 2 else DEFAULT_DST

    # 1. 工作副本
    shutil.copy2(src, dst)
    print("work copy:", dst, os.path.getsize(dst))

    # 2. 构建数据
    run([PY, os.path.join(HERE, "build_wings.py")])

    # 3. 注入脚本
    run([PY, os.path.join(HERE, "inject_map.py"), dst, os.path.join(BASE, "scripts", "wings")])

    # 4. 注入 w3a / w3t
    run([PY, os.path.join(HERE, "inject_file.py"), dst,
         os.path.join(HERE, "_wing.w3a"), "war3map.w3a"])
    run([PY, os.path.join(HERE, "inject_file.py"), dst,
         os.path.join(HERE, "_wing_item.w3t"), "war3map.w3t"])

    # 5. 注入模型
    models = [
        ("wingofthelucifer.mdx", "WingOfTheLucifer.MDX"),
        ("wingblack4.blp", "WingBlack4.blp"),
        ("fwind.mdx", "FWIND.MDX"),
        ("fwing.blp", "FWING.blp"),
        ("doomgguardwings.mdx", "DoomgGuardWings.mdx"),
    ]
    for srcname, internal in models:
        p = os.path.join(FMZJ, srcname)
        if os.path.exists(p):
            run([PY, os.path.join(HERE, "inject_file.py"), dst, p, internal])
        else:
            print("missing model:", p)

    # 6. 部署
    run([PY, os.path.join(HERE, "deploy_mod.py"), dst, "LostTemple_wings.w3x"])
    print("=== done ===")


if __name__ == "__main__":
    main()
