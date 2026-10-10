"""从干净源图重建翅膀/坐骑版地图（一次 HKE 会话完成全部注入）。

流程:
  1. 复制干净工作副本
  2. build_wings.py 生成 w3a / w3t / w3u
  3. inject_all.py 一次会话注入: 脚本 + w3a + w3t + w3u + 5 个模型
  4. 部署到 H:\\Games\\War3\\Maps\\mod

用法:
    python rebuild_wings.py
"""
import os
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or "c:/python313/python.exe"

FMZJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")
SRC = os.path.join(BASE, "maps", "LostTemple", "LostTemple_ft_hand.w3x")
DST = os.path.join(BASE, "maps", "LostTemple", "LostTemple_wings.w3x")
SCRIPTS = os.path.join(BASE, "scripts", "wings")

MODELS = [
    ("wingofthelucifer.mdx", "WingOfTheLucifer.MDX"),
    ("wingblack4.blp", "WingBlack4.blp"),
    ("fwind.mdx", "FWIND.MDX"),
    ("fwing.blp", "FWING.blp"),
    ("doomgguardwings.mdx", "DoomgGuardWings.mdx"),
]


def run(args, allow_fail=False):
    print(">>>", " ".join(str(a) for a in args), flush=True)
    r = subprocess.run(args, capture_output=True)
    out = r.stdout.decode("utf-8", "replace") + r.stderr.decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    if r.returncode != 0 and not allow_fail:
        raise SystemExit("command failed: %s" % args)
    return r.returncode


def local(p):
    return os.path.join(HERE, p)


def main():
    shutil.copy2(SRC, DST)
    print("work copy:", DST, os.path.getsize(DST), flush=True)

    # 2. 生成数据
    run([PY, local("build_wings.py")])
    # buff 覆盖(治疗光环图标/名称 + 保留阿克蒙德之力的 BEar 覆盖) + 自定义图标 blp
    run([PY, local("gen_heal_icon.py")])
    run([PY, "-c",
         "import sys, os; sys.path.insert(0, r'%s'); import gen_w3h; "
         "gen_w3h.build_project_buffs(os.path.join(r'%s', '_wing_buff.w3h'))"
         % (HERE, HERE)])

    # 3. 一次会话注入全部内容
    args = [
        PY, local("inject_all.py"), DST,
        "--script", SCRIPTS, "--script-mode", "manual",
        "--file", local("_wing.w3a") + "=war3map.w3a",
        "--file", local("_wing_item.w3t") + "=war3map.w3t",
        "--file", local("_wing_unit.w3u") + "=war3map.w3u",
        "--file", local("_wing_buff.w3h") + "=war3map.w3h",
        # HKE 添加新文件时只保留文件名（并压成小写），所以图标放地图根目录，
        # buff 的 fart 也写这个裸名（同翅膀模型 WingOfTheLucifer.MDX 的做法）。
        "--file", local("_wing_heal.blp") + "=btnwingheal.blp",
        "--kill-stale",
        "--deploy", "LostTemple_wings.w3x",
    ]
    missing = []
    for srcname, internal in MODELS:
        p = os.path.join(FMZJ, srcname)
        if os.path.exists(p):
            args += ["--file", p + "=" + internal]
        else:
            missing.append(srcname)
    if missing:
        print("missing models:", missing, flush=True)

    run(args)
    print("=== done ===", os.path.getsize(DST), flush=True)


if __name__ == "__main__":
    main()
