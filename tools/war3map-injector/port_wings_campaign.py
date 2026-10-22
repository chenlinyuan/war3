# -*- coding: utf-8 -*-
"""把"翅膀 / 坐骑"系统移植到**战役**（.w3n 或解包目录）。

和普通地图的区别（这就是战役移植的全部特殊之处）:
  1. 战役是**一个 MPQ**，里面装着"战役级对象数据"(`war3campaign.w3a/w3t/w3u/w3h`)
     + 19 个章节地图 + 一堆素材；
  2. 对象数据放**战役级**：合并一次，所有章节都能用（不用逐章改数据）；
  3. 脚本（`wing` / `mount` 命令、坐骑跟随、镜子等）必须**逐章注入**，
     因为每个章节是独立地图、各自的 `war3map.j`；
  4. 战役里**本来就有**阿克蒙德之手（`I000/A000/A001/A002/Azcr`），
     所以移植时**不要**再塞一份（用 `_wing_nohand.*`），只加成翅膀/坐骑那部分。

本文件按"档位"来参数化，战役用的是**只加不改**档位（在 `objects` 步骤自动生成配置）:
  坐骑的 伤害 / 攻击类型 / 溅射 / 护甲 / 阴影 / 目标表 / 种族 全部**继承原版**，
  只覆盖：不占人口、模型缩放、地面寻路（不飞过树/山）、凤凰的每秒回血（原版 -25 会掉死）。
  召唤小龙**关掉**（`summon_count=0`）。

用法:
    # 一条命令全跑（解包 → 配置 → 对象 → 逐章脚本 → 打包）
    python port_wings_campaign.py all "H:\\...\\血色使命 I 十周年纪念版.w3n.bak" \\
        --work maps/port/blood1 --out "H:\\Games\\War3\\Campaigns\\血色使命 I 十周年纪念版(翅膀版).w3n"

    # 也可以分步（可重跑；`chapters` 会跳过已经注入过的章节）
    python port_wings_campaign.py extract  <战役.w3n|目录> --work <工作目录>
    python port_wings_campaign.py config   --work <工作目录> [--mounts full]
    python port_wings_campaign.py objects  --work <工作目录>
    python port_wings_campaign.py chapters --work <工作目录> [--only chapter1.w3x,...]
    python port_wings_campaign.py pack <原始.w3n> --work <工作目录> --out <输出.w3n>

坐骑档位（`config --mounts`）:
    original（默认）= 只加不改：伤害/攻击类型/护甲…全部继承原版，召唤小龙关掉；
    full = 350 打架档（=`wings_config_1_5.py` 那套）：伤害 350、混乱攻击、肉甲、
           飞行阴影、全天回血 2.0、目标 air、种族 orc、**召唤小龙开着**。
"""
import argparse
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or "c:/python313/python.exe"
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
from merge_w3obj import merge_files  # noqa: E402
import port_wings as P  # noqa: E402  (复用 run / check_script_clash / WING_MODELS)

CAMPAIGN_OBJ = [("war3campaign.w3a", "_wing_nohand.w3a"),
                ("war3campaign.w3t", "_wing_item_nohand.w3t"),
                ("war3campaign.w3u", "_wing_unit.w3u"),
                ("war3campaign.w3h", "_wing_buff.w3h")]
# 带阿克蒙德之手的那一套（战役自己**没有**这件装备时用；有就用上面 nohand 那套，不重复添加）
CAMPAIGN_OBJ_HAND = [("war3campaign.w3a", "_wing.w3a"),
                     ("war3campaign.w3t", "_wing_item.w3t"),
                     ("war3campaign.w3u", "_wing_unit.w3u"),
                     ("war3campaign.w3h", "_wing_buff.w3h")]
# 逐章注入模式用（对象数据放进每个章节自己的 war3map.w3a/w3t/w3u/w3h）
CHAPTER_OBJ = [("war3map.w3a", "w3a"), ("war3map.w3t", "w3t"),
               ("war3map.w3u", "w3u"), ("war3map.w3h", "w3h")]
OURS_HAND = {"w3a": "_wing.w3a", "w3t": "_wing_item.w3t",
             "w3u": "_wing_unit.w3u", "w3h": "_wing_buff.w3h"}
OURS_NOHAND = {"w3a": "_wing_nohand.w3a", "w3t": "_wing_item_nohand.w3t",
               "w3u": "_wing_unit.w3u", "w3h": "_wing_buff.w3h"}


def ours_of(a):
    return OURS_NOHAND if getattr(a, "no_hand", False) else OURS_HAND


def merge_chapter_objects(chapter, objdir, mapping):
    """把一章自己的对象数据和我们的合并（保留 orig/custom 分段）。

    章节自己**没有**的对象数据文件（有的战役只有 w3a/w3u）→ 直接用我们的新建，
    对象数据的优先级高于 slk，游戏会叠加读取。
    返回 [(本地文件, 内部名)]，可直接喂给 inject_native.py --file。
    """
    os.makedirs(objdir, exist_ok=True)
    out = []
    ar = W.MPQArchive(chapter)
    try:
        for internal, ext in CHAPTER_OBJ:
            ours = os.path.join(HERE, mapping.get(ext, ""))
            if not os.path.exists(ours):
                continue
            data = ar.read_file(internal)
            merged = os.path.join(objdir, "merged." + ext)
            if data:
                tgt = os.path.join(objdir, "target." + ext)
                open(tgt, "wb").write(data)
                n_orig, n_cust = merge_files(merged, [tgt, ours])
                print("     %-14s 章节 + 我们 -> %d orig / %d custom"
                      % (internal, n_orig, n_cust))
            else:
                shutil.copy2(ours, merged)
                print("     %-14s 章节没有 → 用我们的新建（%d 字节）"
                      % (internal, os.path.getsize(merged)))
            out.append((merged, internal))
    finally:
        ar.close()
    return out


def obj_list(a):
    return CAMPAIGN_OBJ if getattr(a, "no_hand", False) else CAMPAIGN_OBJ_HAND
# 打包时要一起写回、但不是"合并"出来的文件
EXTRA_PACK_FILES = ["war3campaign.w3f", "war3campaign.wts"]
DEFAULT_CFG = "wings_config_campaign"


def cfg_paths(name=None):
    return os.path.join(HERE, (name or DEFAULT_CFG) + ".py")


# ---------------------------------------------------------------------------
# 1) 解包
# ---------------------------------------------------------------------------
def cmd_extract(a):
    src = os.path.abspath(a.campaign)
    base = os.path.join(os.path.abspath(a.work), "base")
    os.makedirs(base, exist_ok=True)
    n = 0
    if os.path.isdir(src):
        for root, _dirs, files in os.walk(src):
            for fn in files:
                s = os.path.join(root, fn)
                rel = os.path.relpath(s, src)
                d = os.path.join(base, rel)
                os.makedirs(os.path.dirname(d), exist_ok=True)
                shutil.copy2(s, d)
                n += 1
        print("从目录复制 %d 个文件 -> %s" % (n, base))
    else:
        ar = W.MPQArchive(src)
        try:
            names = ar.listfile or []
            for name in names:
                data = ar.read_file(name)
                if data is None:
                    print("  ! 读不出: %s" % name)
                    continue
                d = os.path.join(base, name.replace("\\", os.sep).replace("/", os.sep))
                os.makedirs(os.path.dirname(d), exist_ok=True)
                open(d, "wb").write(data)
                n += 1
        finally:
            ar.close()
        print("从 %s 解出 %d 个文件 -> %s" % (os.path.basename(src), n, base))
    chs = sorted(f for f in os.listdir(base) if f.lower().endswith((".w3x", ".w3m")))
    print("章节地图 %d 个: %s" % (len(chs), ", ".join(chs)))
    return 0


# ---------------------------------------------------------------------------
# 2) 生成本战役的配置（"只加不改"档位）
# ---------------------------------------------------------------------------
# (原文, 替换, 替换几处) —— "只加不改"档位与默认配置的差异部分
#
# 2026-10-15 更新：`wings_config.py` 后来做过重构，MOUNT_COMMON 的默认值**本来就是**
#   只加不改（dmg_base/atk_type/armor/shadow/regen_type/race/targets 都是 None、
#   move_height 也是 None），所以这里只剩一条真正要改的：关掉召唤小龙。
#   ⚠ 溅射 `splash` 必须保留我们的值（含 enemy）：原版龙类 ua1p 不含 enemy，
#     溅射会打到友军 —— 实测"坐骑把自己骑乘的英雄打伤"。
PROFILE = [
    ('summon_count=2,', 'summon_count=0,', 1),        # 战役里关掉召唤小龙
    # 阿克蒙德之手的两个被动在战役里**也打开**（数值和 LT 一样，都是玩家验收过的）：
    #   掠夺（击杀制，门槛 300 生命）+ 重击（8% / 600 额外伤害 + 眩晕）。
    #   ⚠ 这两个开关在默认配置里是**关**的（见 wings_config.py 的注释），
    #     所以战役/后续移植要显式打开。
    ('plunder_enable=0,', 'plunder_enable=1,', 1),
    ('plunder_min_hp=500,', 'plunder_min_hp=300,', 1),
    ('hand_bash_chance=0,', 'hand_bash_chance=8,', 1),
]

# 另一档：**350 打架档**（就是 `wings_config_1_5.py` / 伏魔战记那套数值）。
#   用户明确要求"这个战役不用关召唤、坐骑伤害要 350"时用 `config --mounts full`。
FULL_TIER = [
    ('dmg_base=None,', 'dmg_base=350,', 1),           # ua1b：伤害基数 350
    ('atk_type=None,', 'atk_type="chaos",', 1),       # ua1t：混乱攻击
    ('armor=None,', 'armor="Flesh",', 1),             # uarm：肉甲
    ('shadow=None,', 'shadow="ShadowFlyer",', 1),     # ushu：飞行阴影
    ('regen_type=None,', 'regen_type="always",', 1),  # uhrt：全天回血
    ('race=None,', 'race="orc",', 1),                 # urac
    ('targets=None,', 'targets="air",', 1),           # utar
    ('hp_regen=None,', 'hp_regen=2.0,', 1),           # uhpr（凤凰那条在 MOUNTS 里已是 2.0）
    ('summon_count=0,', 'summon_count=2,', 1),        # 召唤小龙：开
]
PROFILES = {"original": PROFILE, "full": FULL_TIER}

# 第三档：**不要坐骑系统**（2026-10-15 玩家要求："以后移植默认都不加坐骑，除非我说"）。
#   做法：把配置里 MOUNTS 整段换成空表 —— 技能/物品/单位三边的生成器都会因此
#   一条坐骑内容都不产出（gen_wing / gen_wing_item / gen_w3u 都按 CFG.MOUNTS 判断）；
#   JASS 侧 `wg_eggCount = 0`，坐骑代码全部空转（循环一次都不进，不用改脚本，
#   详见 docs/翅膀与坐骑系统.md 的"不带坐骑档位"）。
PROFILES["none"] = PROFILE


def cmd_config(a):
    out = cfg_paths(a.config)
    if os.path.exists(out) and not a.force:
        print("已存在配置，跳过:", os.path.basename(out), "（要重生成加 --force）")
        return 0
    src = open(os.path.join(HERE, "wings_config.py"), encoding="utf-8").read()
    mounts = getattr(a, "mounts", "original")
    if mounts == "full":
        head = ('''"""战役专用配置（port_wings_campaign.py --mounts full 生成）。\n
档位 = **350 打架档**（同 wings_config_1_5.py / 伏魔战记那套）：\n
  * 伤害 350（ua1b）、混乱攻击（ua1t）、肉甲（uarm）、飞行阴影（ushu）；\n
  * 全天回血（uhrt）+ 2.0/秒（uhpr，盖掉凤凰原版的 -25/秒）；\n
  * 目标表 air、种族 orc；**召唤小龙开着**（summon_count=2）；\n
  * 溅射仍是我们的值（含 enemy）—— 原版龙类 ua1p 不含 enemy，会打到友军。\n
  * HAND 用战役里**已有**的阿克蒙德之手 ID（移植时不重复添加这件装备）。\n
"""\n
''')
    elif mounts == "none":
        head = ('''"""战役专用配置（port_wings_campaign.py --mounts none 生成）。\n
档位 = **不带坐骑系统**（2026-10-15 玩家要求：以后移植默认不加坐骑）：\n
  * `MOUNTS` 已清空 → 坐骑单位 / 坐骑蛋 / 骑乘中物品 / 挂载技能 **一条都不生成**；\n
  * JASS 里 `wg_eggCount = 0`，坐骑相关代码全部空转（循环不进，也不会有坐骑内容）；\n
  * 翅膀（含星魂之力·灰烬雷暴） / 阿克蒙德之手 / 物品浏览器 照常；\n
  * HAND 用战役里**已有**的阿克蒙德之手 ID（移植时不重复添加这件装备）。\n
"""\n
''')
    else:
        head = ('''"""战役专用配置（由 port_wings_campaign.py 生成）。\n
档位 = **只加不改**：\n
  * 坐骑的 伤害/攻击类型/溅射/护甲/阴影/目标表/种族 全部留 None = **继承原版数值**；\n
  * 只覆盖：不占人口(ufoo=0)、模型缩放(usca/ussc)、地面寻路(umvt=foot)、\n
    凤凰的每秒回血（原版 hphx 是 -25/秒，约 50 秒会自己掉死 → 必须写 2.0）；\n
  * **关掉召唤小龙**（summon_count=0）；\n
  * HAND 用战役里**已有**的阿克蒙德之手 ID（移植时不重复添加这件装备）。\n
"""\n
''')
    src = head + src.split('"""', 2)[2].lstrip("\n")
    if mounts == "none":
        # 把 MOUNTS 整段（`MOUNTS = [` 到行首的 `]`）换成空表
        import re
        src, n = re.subn(r"(?ms)^MOUNTS = \[.*?^\]",
                         "MOUNTS = []   # --mounts none：本图不要坐骑系统", src)
        print("  MOUNTS 已清空（替换 %d 处）" % n)
        if n != 1:
            print("  ! 预期替换 1 处，实际 %d 处，请检查配置！" % n)
    for before, after, cnt in PROFILES[mounts]:
        if before not in src:
            print("  ! 配置里找不到: %s（跳过）" % before)
            continue
        src = src.replace(before, after, cnt)
    # 凤凰必须写回血（覆盖原版 -25/秒，否则约 50 秒自己掉死）。
    #   配置重构后这条已经写在 MOUNTS 的凤凰条目里，这里只做兜底。
    if "hero_h_off=15.0)" in src:
        src = src.replace("hero_h_off=15.0)",
                          "hero_h_off=15.0, hp_regen=2.0)")
    # 战役移植不带"试穿"款（它们是我们挑模型用的，模型文件也不会随行）
    src += ("\n\n# --- 战役移植: 不带试穿款 ---\n"
            "TEST_WINGS = []\nTEST_ARTS = []\nITEM_OVERRIDES = []\n")
    open(out, "w", encoding="utf-8").write(src)
    print("已生成战役配置:", os.path.basename(out), "（档位 %s）" % mounts)
    return 0


# ---------------------------------------------------------------------------
# 3) 战役级对象数据 + 模型
# ---------------------------------------------------------------------------
def cmd_objects(a):
    base = os.path.join(os.path.abspath(a.work), "base")
    env = {"WINGS_CONFIG": a.config}
    P.run([PY, os.path.join(HERE, "build_wings.py")], env=env)
    for internal, ours in obj_list(a):
        t = os.path.join(base, internal)
        o = os.path.join(HERE, ours)
        if not os.path.exists(t):
            print("  ! 战役里没有 %s，跳过" % internal)
            continue
        n_orig, n_cust = merge_files(t, [t, o])
        print("  %s: 战役 %d orig / %d custom（合并后）" % (internal, n_orig, n_cust))
    for srcname, internal in P.WING_MODELS:
        s = P.model_src(srcname)
        if os.path.exists(s):
            shutil.copy2(s, os.path.join(base, internal))
        else:
            print("  ! 缺模型:", s)
    print("战役级对象数据与模型已就位 ->", base)
    return 0


# ---------------------------------------------------------------------------
# 3b) 改战役显示名（不然战役列表里两条一模一样，分不清哪个是翅膀版）
# ---------------------------------------------------------------------------
def cmd_name(a):
    import re
    import struct
    base = os.path.join(os.path.abspath(a.work), "base")
    wts_path = os.path.join(base, "war3campaign.wts")
    w3f_path = os.path.join(base, "war3campaign.w3f")
    if not os.path.exists(wts_path) or not os.path.exists(w3f_path):
        print("  ! 缺少 war3campaign.wts/w3f，跳过改名")
        return 0

    prefix = getattr(a, "prefix", "alas ")
    w3f = open(w3f_path, "rb").read()
    if len(w3f) < 13:
        print("  ! war3campaign.w3f 太短，跳过改名")
        return 0
    try:
        struct.unpack_from("<iii", w3f, 0)
    except struct.error:
        print("  ! war3campaign.w3f 头部无效，跳过改名")
        return 0
    name_start = 12
    name_end = w3f.find(b"\0", name_start)
    if name_end < 0:
        print("  ! war3campaign.w3f 战役名未终止，跳过改名")
        return 0
    raw_name = w3f[name_start:name_end]

    raw_wts = open(wts_path, "rb").read()
    enc = "utf-8"
    try:
        text = raw_wts.decode("utf-8")
    except UnicodeDecodeError:
        enc = "gbk"
        text = raw_wts.decode("gbk")

    def has_prefix(value):
        return re.match(r"^\s*alas(?:\s|$)", value, re.I) is not None

    ref_text = raw_name.decode(enc, "replace")
    ref = re.fullmatch(r"\s*TRIGSTR_(\d+)\s*", ref_text, re.I)
    if ref:
        number = int(ref.group(1))
        m = re.search(
            r"(STRING\s+%d\s*\r?\n\{)(.*?)(\})" % number,
            text,
            re.I | re.S,
        )
        if not m:
            print("  ! wts 里找不到 w3f 引用的 STRING %d，跳过" % number)
            return 0
        body = m.group(2)
        lead_len = len(body) - len(body.lstrip())
        lead, value = body[:lead_len], body[lead_len:]
        if has_prefix(value):
            print("战役显示名已带 alas 前缀，跳过")
            return 0
        new_body = lead + prefix + value
        text = text[:m.start(2)] + new_body + text[m.end(2):]
        open(wts_path, "wb").write(text.encode(enc))
        print("战役显示名 STRING %d -> %s" % (number, (prefix + value).strip()))
        return 0

    literal = ref_text.strip()
    if has_prefix(literal):
        print("战役显示名已带 alas 前缀，跳过")
        return 0
    new_name = (prefix + literal).encode("utf-8")
    w3f = w3f[:name_start] + new_name + w3f[name_end:]
    open(w3f_path, "wb").write(w3f)
    print("战役显示名 -> %s" % (prefix + literal).strip())
    return 0


# ---------------------------------------------------------------------------
# 4) 逐章注入脚本（可重跑：已注入过的章节会跳过）
# ---------------------------------------------------------------------------
def cmd_chapters(a):
    base = os.path.join(os.path.abspath(a.work), "base")
    wings = os.path.join(BASE, "scripts", "wings")
    mods = [wings]
    ib = os.path.join(os.path.abspath(a.work), "item-browser")
    if os.path.isdir(ib):
        mods.append(ib)     # 物品/技能系统（f.j 里的表是本战役专属的，见 `ib` 子命令）
    only = None
    if a.only:
        only = set(x.strip() for x in a.only.split(",") if x.strip())
    chs = sorted(f for f in os.listdir(base)
                 if f.lower().endswith((".w3x", ".w3m")) and (not only or f in only))
    injected = skipped = failed = 0
    for i, ch in enumerate(chs, 1):
        p = os.path.join(base, ch)
        # 已经注入过就跳过（否则会插第二遍 -> 函数重定义，地图打不开）
        try:
            ar = W.MPQArchive(p)
            data = ar.read_file("war3map.j") or b""
            ar.close()
        except Exception as e:
            print("[%d/%d] %s 打不开: %s" % (i, len(chs), ch, e))
            failed += 1
            continue
        if b"WG_Init" in data:
            print("[%d/%d] %s 已注入过，跳过" % (i, len(chs), ch))
            skipped += 1
            continue
        print("\n[%d/%d] ==== %s (%d 字节) ====" % (i, len(chs), ch, os.path.getsize(p)))
        try:
            P.check_script_clash(p, mods)
            args = None
            if os.environ.get("PORT_HKE") == "1":
                # 可选：走 HKE 写容器。默认不用 —— 2026-10-11 实测：原生写入器
                # (inject_native.py / mpq_patch.py) 写出的档案，游戏自带的 Storm.dll
                # 能完整读出（sfmpq_probe.ps1 逐文件比对 md5 全对），容器没问题。
                args = [PY, os.path.join(HERE, "inject_all.py"), p,
                        "--script-mode", "manual", "--kill-stale"]
            else:
                args = [PY, os.path.join(HERE, "inject_native.py"), p]
            for m in mods:
                args += ["--script", m]
            # 逐章对象数据（战役级那份我们**不动**，尤其是 KK 平台图）
            objdir = os.path.join(os.path.abspath(a.work), "_obj",
                                  os.path.splitext(ch)[0])
            for outp, internal in merge_chapter_objects(p, objdir, ours_of(a)):
                args += ["--file", outp + "=" + internal]
            # 翅膀模型也要跟着章节走（章节是独立地图，读的是自己的导入文件）
            for srcname, internal in P.WING_MODELS:
                s = P.model_src(srcname)
                if os.path.exists(s):
                    args += ["--file", s + "=" + internal]
                else:
                    print("  ! 缺模型:", s)
            P.run(args)
            injected += 1
        except SystemExit as e:
            print("  !! 失败:", e)
            failed += 1
    print("\n逐章注入: 新注入 %d，跳过 %d，失败 %d（共 %d）" % (injected, skipped, failed, len(chs)))
    return 1 if failed else 0


# ---------------------------------------------------------------------------
# 4b) 物品/技能系统：给本战役做一份 item-browser 副本（表按本战役自己的物品/技能生成）
# ---------------------------------------------------------------------------
def cmd_ib(a):
    work = os.path.abspath(a.work)
    base = os.path.join(work, "base")
    cfg = a.config
    env = {"WINGS_CONFIG": cfg, "IB_BASE_DIR": work}
    stage = os.path.join(work, "_ibsrc")
    os.makedirs(stage, exist_ok=True)
    for src_name, dst_name in (("war3campaign.w3t", "war3map.w3t"),
                               ("war3campaign.w3a", "war3map.w3a"),
                               ("war3campaign.wts", "war3map.wts"),
                               ("war3campaign.w3u", "war3map.w3u")):
        p = os.path.join(base, src_name)
        if os.path.exists(p):
            shutil.copy2(p, os.path.join(stage, dst_name))
    # 基础物品表：直接从游戏数据重建"标准物品"（不搬别的战役那份），
    #   本战役自己的自定义物品由 collect_map_items 并进来。
    P.run([PY, os.path.join(HERE, "collect_items.py")], env=env)
    P.run([PY, os.path.join(HERE, "collect_map_items.py"), stage], env=env)
    P.run([PY, os.path.join(HERE, "collect_skills.py"), stage], env=env)
    import importlib
    dst = P.prepare_item_browser(work, cfg, importlib.import_module(cfg), base)
    print("   物品/技能系统就位 ->", dst)
    return 0


# ---------------------------------------------------------------------------
# 5) 打包（一次 HKE 会话写回 .w3n）
# ---------------------------------------------------------------------------
def cmd_pack(a):
    src = os.path.abspath(a.campaign)
    base = os.path.join(os.path.abspath(a.work), "base")
    out = os.path.abspath(a.out)
    shutil.copy2(src, out)
    print("从原始战役复制出:", out, os.path.getsize(out), "字节")
    files = []
    if getattr(a, "chapters_only", False):
        # 逐章注入模式：对象数据/模型都在章节里，战役级文件（含 wts）一个都不写。
        #   KK 平台图（比如 194213 燃烧之怒）必须走这条 —— 改战役级文件会报
        #   "The file data is corrupt"（见 docs/06-工具链/KKWE平台图单机化.md 坑四）。
        print("   --chapters-only：只写章节，战役级对象数据/模型/wts 保持原样")
    else:
        for internal, _ours in CAMPAIGN_OBJ:
            p = os.path.join(base, internal)
            if os.path.exists(p):
                files.append((p, internal))
        for _srcname, internal in P.WING_MODELS:
            p = os.path.join(base, internal)
            if os.path.exists(p):
                files.append((p, internal))
        for internal in EXTRA_PACK_FILES:
            p = os.path.join(base, internal)
            if os.path.exists(p):
                files.append((p, internal))
    chs = sorted(f for f in os.listdir(base) if f.lower().endswith((".w3x", ".w3m")))
    for ch in chs:
        files.append((os.path.join(base, ch), ch))
    # ⚠ 章节地图必须**原样存储(不压缩)**：游戏是把它当"归档里的归档"打开的
    #   （SFileOpenFileAsArchive），压缩过的块打不开 -> "找不到地图或者损毁"。
    #   原版战役里章节也都是未压缩存储的；这里顺便照抄原战役每个文件的存储方式。
    store = set(ch for ch in chs)
    try:
        src_ar = W.MPQArchive(src)
        try:
            for _p, internal in files:
                info = src_ar._find_file(internal)
                if info is not None and not (info.flags & W.COMPRESSION_MASK):
                    store.add(internal)
        finally:
            src_ar.close()
    except Exception as e:
        print("  ! 读原战役取存储方式失败（章节仍按未压缩写）:", e)
    print("   原样存储的文件: %d 个（其中章节 %d 个）" % (len(store), len(chs)))
    # 原生写成（不走 HKE）：一次会话、保留全部老条目、也不会重写 (listfile)
    args = [PY, os.path.join(HERE, "inject_native.py"), out, "--no-backup"]
    for p, internal in files:
        args += ["--file", p + "=" + internal]
    for internal in sorted(store):
        args += ["--store", internal]
    P.run(args)
    prefix_hm3w_name(out, getattr(a, "prefix", "alas "))
    # 读回逐字节校验
    print("\n打包校验（读回 .w3n 和本地文件逐字节比对）：")
    ar = W.MPQArchive(out)
    bad = 0
    try:
        for p, internal in files:
            got = ar.read_file(internal)
            want = open(p, "rb").read()
            if got != want:
                bad += 1
                print("   %-22s 不一致（%s vs %s 字节）"
                      % (internal, len(got or b""), len(want)))
        if not bad:
            print("   %d 个文件全部一致 [OK]" % len(files))
    finally:
        ar.close()
    print("\n输出战役:", out)
    return 1 if bad else 0


def prefix_hm3w_name(path, prefix):
    """Patch the HM3W display name used by the custom-campaign list."""
    import re

    with open(path, "rb") as f:
        block = bytearray(f.read(512))
    if bytes(block[:4]) != b"HM3W":
        print("   HM3W 头不存在，跳过战役列表显示名")
        return
    try:
        nul = block.index(0, 8)
    except ValueError:
        print("   HM3W 名未终止，跳过战役列表显示名")
        return
    old = bytes(block[8:nul]).decode("utf-8", "replace")
    color = re.match(r"^(\|[cC][0-9a-fA-F]{8})(.*)$", old, re.S)
    visible = color.group(2) if color else old
    if re.match(r"^\s*alas(?:\s|$)", visible, re.I):
        print("   HM3W 显示名已带 alas 前缀")
        return
    if color:
        new = color.group(1) + " " + prefix.strip() + " " + color.group(2).lstrip()
    else:
        new = prefix + old.lstrip()

    # Keep all non-zero metadata following the name string inside the 512-byte
    # HM3W header, then rebuild the zero padding.
    tail_end = max(
        (i + 1 for i, value in enumerate(block[nul + 1:], nul + 1) if value),
        default=nul + 1,
    )
    tail = bytes(block[nul + 1:tail_end])
    out = b"HM3W" + bytes(block[4:8]) + new.encode("utf-8") + b"\0" + tail
    if len(out) > 512:
        raise SystemExit("HM3W 显示名超过 512 字节: %r" % new)
    out += b"\0" * (512 - len(out))
    with open(path, "r+b") as f:
        f.write(out)
    print("   战役列表显示名: %r -> %r" % (old, new))


def cmd_all(a):
    cmd_extract(a)
    cmd_config(a)
    cmd_objects(a)
    cmd_name(a)
    rc = cmd_chapters(a)
    if rc:
        print("逐章注入有失败，先别打包（修好再跑 chapters/pack）")
        return rc
    return cmd_pack(a)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd")
    for name in ("extract", "all"):
        s = sub.add_parser(name)
        s.add_argument("campaign")
        s.add_argument("--work", required=True)
        s.add_argument("--out")
        s.add_argument("--config", default=DEFAULT_CFG)
        s.add_argument("--mounts", choices=("none", "original", "full"), default="original",
                       help="none=不带坐骑系统；original=只加不改（默认）；full=350 打架档")
        s.add_argument("--only")
        s.add_argument("--force", action="store_true")
    for name in ("config", "objects", "name", "chapters", "ib"):
        s = sub.add_parser(name)
        s.add_argument("--work", required=True)
        s.add_argument("--config", default=DEFAULT_CFG)
        s.add_argument("--mounts", choices=("none", "original", "full"), default="original",
                       help="只对 config 生效：none=不带坐骑；original=只加不改（默认）；full=350 打架档")
        s.add_argument("--no-hand", action="store_true",
                       help="战役自己已经有阿克蒙德之手时用（不重复添加那件装备）")
        s.add_argument("--only")
        s.add_argument("--force", action="store_true")
        s.add_argument("--prefix", default="alas ",
                       help="战役列表中的显示名前缀")
    s = sub.add_parser("pack")
    s.add_argument("campaign")
    s.add_argument("--work", required=True)
    s.add_argument("--out", required=True)
    s.add_argument("--chapters-only", action="store_true",
                   help="只写章节地图（对象数据/模型已在章节内），不碰战役级文件")
    a = ap.parse_args()
    if not a.cmd:
        print(__doc__)
        return 1
    return globals()["cmd_" + a.cmd](a) or 0


if __name__ == "__main__":
    sys.exit(main())
