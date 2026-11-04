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
WINGSRC = os.path.join(BASE, "maps", "_wing_src")   # 「试穿」翅膀（来自 神界危机，见 wings_config.TEST_WINGS）
EQSRC = os.path.join(BASE, "maps", "_equip_src")    # 「装备挂件」演示（头盔/盾/光效，见 TEST_ARTS / ITEM_OVERRIDES）
SRC = os.path.join(BASE, "maps", "LostTemple", "LostTemple_ft_hand.w3x")
DST = os.path.join(BASE, "maps", "LostTemple", "LostTemple_wings.w3x")
SCRIPTS = os.path.join(BASE, "scripts", "wings")

MODELS = [
    (os.path.join(FMZJ, "wingofthelucifer.mdx"), "WingOfTheLucifer.MDX"),
    (os.path.join(FMZJ, "wingblack4.blp"), "WingBlack4.blp"),
    (os.path.join(FMZJ, "fwind.mdx"), "FWIND.MDX"),
    (os.path.join(FMZJ, "fwing.blp"), "FWING.blp"),
    (os.path.join(FMZJ, "doomgguardwings.mdx"), "DoomgGuardWings.mdx"),
    # 「试穿」用翅膀（只有模型 + 移速，挑外观用）
    (os.path.join(WINGSRC, "awing.mdx"), "awing.mdx"),
    (os.path.join(WINGSRC, "angelwing.mdx"), "angelwing.mdx"),
    (os.path.join(WINGSRC, "fairywing.mdx"), "fairywing.mdx"),
    (os.path.join(WINGSRC, "ewing.mdx"), "ewing.mdx"),
    (os.path.join(WINGSRC, "demonwings2.mdx"), "demonwings2.mdx"),
    (os.path.join(WINGSRC, "awing.blp"), "awing.blp"),
    (os.path.join(WINGSRC, "angelwing.blp"), "angelwing.blp"),
    (os.path.join(WINGSRC, "fairywing.blp"), "fairywing.blp"),
    (os.path.join(WINGSRC, "ewing.blp"), "ewing.blp"),
    # 星魂之力（燃烧之怒 194213 的神器挂件：模型 + 4 张裸文件名贴图）
    (os.path.join(WINGSRC, "anchibang0100.mdx"), "anchibang0100.mdx"),
    (os.path.join(WINGSRC, "anchibang01.blp"), "anchibang01.blp"),
    (os.path.join(WINGSRC, "anchibang02.blp"), "anchibang02.blp"),
    (os.path.join(WINGSRC, "anchibang03.blp"), "anchibang03.blp"),
    (os.path.join(WINGSRC, "anchibang04.blp"), "anchibang04.blp"),
    # 物品的"地面模型"（燃烧之怒里神器掉地上会发光的那套）:见 wings_config.GROUND
    (os.path.join(WINGSRC, "Chest_Purple.mdx"), "Chest_Purple.mdx"),
    (os.path.join(WINGSRC, "Chest_Yellow.mdx"), "Chest_Yellow.mdx"),
    (os.path.join(WINGSRC, "Chest_Black.mdx"), "Chest_Black.mdx"),
    (os.path.join(WINGSRC, "Chest_LightBlue.mdx"), "Chest_LightBlue.mdx"),
    (os.path.join(WINGSRC, "Chest_Legendary.mdx"), "Chest_Legendary.mdx"),
    (os.path.join(WINGSRC, "ChestOrangeRunes1.blp"), "ChestOrangeRunes1.blp"),
    (os.path.join(WINGSRC, "ChestOrangeRunes2.blp"), "ChestOrangeRunes2.blp"),
    # 灰烬雷暴（星魂之力的主动）的两个特效模型（从燃烧之怒战役取出）：
    #   StormfallRed = 雷暴环/二阶火箭的弹道；ssw1 = 施法者起手
    #   ⚠ 原来是 war3campImported\Stormfall Red.mdx（名字带空格），为了不让 HKE
    #     的"只留文件名"逻辑出岔子，改成不带空格的名字 —— 模型内容一模一样。
    (os.path.join(WINGSRC, "StormfallRed.mdx"), "StormfallRed.mdx"),
    (os.path.join(WINGSRC, "ssw1.mdx"), "ssw1.mdx"),
    # 「装备挂件」演示已撤掉（通用头盔不可行，见 wings_config.TEST_ARTS 注释）；
    # 要重开就把 maps/_equip_src 里的 5 个文件加回这里，并把 TEST_ARTS/ITEM_OVERRIDES 取消注释。
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
    # ⚠ 必须最先设好 WINGS_CONFIG：build_wings / gen_wing_item / gen_w3h / hand_data
    #   都按它取配置，设晚了就会用默认配置生成（踩过这个坑）。
    os.environ["WINGS_CONFIG"] = "wings_config_losttemple"
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
        PY, local("inject_native.py"), DST,
        "--script", SCRIPTS,
        "--file", local("_wing.w3a") + "=war3map.w3a",
        "--file", local("_wing_item.w3t") + "=war3map.w3t",
        "--file", local("_wing_unit.w3u") + "=war3map.w3u",
        "--file", local("_wing_buff.w3h") + "=war3map.w3h",
        # HKE 添加新文件时只保留文件名（并压成小写），所以图标放地图根目录，
        # buff 的 fart 也写这个裸名（同翅膀模型 WingOfTheLucifer.MDX 的做法）。
        "--file", local("_wing_heal.blp") + "=btnwingheal.blp",
    ]
    missing = []
    for srcname, internal in MODELS:
        p = srcname if os.path.isabs(srcname) else os.path.join(FMZJ, srcname)
        if os.path.exists(p):
            args += ["--file", p + "=" + internal]
        else:
            missing.append(srcname)
    if missing:
        print("missing models:", missing, flush=True)

    run(args)

    # 4. 摘掉图里旧注入的 criton（item-browser 那套）+ 旧的 IB 版死亡之指
    #    （死亡之指现在由本模块的 WG_OnFinger 实现，旧的"1e6 秒杀"必须关掉，
    #      否则同一个技能会吃两套逻辑），然后才部署
    run([PY, local("strip_crit.py"), DST])
    run([PY, local("strip_ib_finger.py"), DST])
    run([PY, local("deploy_mod.py"), DST, "LostTemple_wings.w3x"])
    print("=== done ===", os.path.getsize(DST), flush=True)


if __name__ == "__main__":
    main()
