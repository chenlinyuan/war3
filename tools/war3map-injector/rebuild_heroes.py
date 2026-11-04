# -*- coding: utf-8 -*-
"""把英雄包注入 Lost Temple（先只改这一张图验证）。

流程：
  1. 以当前 LostTemple_wings.w3x 为底（保留翅膀/物品浏览器/阿手）
  2. 生成 heroes/light_ranger/hero.w3a + hero.w3u
  3. 与底图已有的 w3a/w3u 合并（不覆盖旧内容）
  4. 注入 scripts/heroes + 合并后的对象数据
  5. 部署为 LostTemple_heroes.w3x

用法:
  python rebuild_heroes.py
"""
import os
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or r"C:\Python313\python.exe"

SRC = os.path.join(BASE, "maps", "LostTemple", "LostTemple_wings.w3x")
DST = os.path.join(BASE, "maps", "LostTemple", "LostTemple_heroes.w3x")
HERO_DIR = os.path.join(BASE, "heroes", "light_ranger")
HERO_DIR_DH = os.path.join(BASE, "heroes", "demon_hunter")
HERO_DIR_SH = os.path.join(BASE, "heroes", "shadow_shaman")
HERO_DIR_BM = os.path.join(BASE, "heroes", "blade_master")
HERO_DIR_FL = os.path.join(BASE, "heroes", "firelord")
FROST_DIR = os.path.join(BASE, "heroes", "frostmourne")
ITEM_ICON_DIR = os.path.join(BASE, "heroes", "item_icons")
SCRIPTS = os.path.join(BASE, "scripts", "heroes")
FROST_SCRIPTS = os.path.join(BASE, "scripts", "frostmourne")
HERO_SOURCE_MAP = os.path.join("H:\\", "Games", "War3", "Maps", "mod", "ChengHai_3c_692.w3x")
HERO_ICON_SRC = os.path.join(HERE, "_hero_BTNLS15_src.blp")
HERO_ICON = os.path.join(HERE, "_hero_BTNLS15.blp")
HERO_DISBTN_SRC = os.path.join(HERE, "_hero_DISBTNLS15_src.blp")
HERO_DISBTN = os.path.join(HERE, "_hero_DISBTNLS15.blp")
HERO_SH30 = os.path.join(HERE, "_hero_BTNSH30.blp")
HERO_DISSH30 = os.path.join(HERE, "_hero_DISBTNSH30.blp")
HERO_SH30_SRC = os.path.join(HERE, "_hero_BTNSH30_src.blp")
HERO_DISSH30_SRC = os.path.join(HERE, "_hero_DISBTNSH30_src.blp")
HERO_BM_ICON_SRC = os.path.join(HERE, "_hero_BTNBM30_src.blp")
HERO_BM_ICON = os.path.join(HERE, "_hero_BTNBM30.blp")
HERO_BM_DIS_SRC = os.path.join(HERE, "_hero_DISBTNBM30_src.blp")
HERO_BM_DIS = os.path.join(HERE, "_hero_DISBTNBM30.blp")
HERO_ABILITY_SLK = os.path.join(HERE, "_chenghai_abilitydata.slk")
HERO_WARD_BUFF = os.path.join(HERE, "_hero_ward_buff.w3h")
FROST_ASSETS = [
    ("Frostmourne.mdx", "war3campImported\\Frostmourne.mdx"),
    ("Frostmourne10.blp", "Frostmourne10.blp"),
    ("Frostmourne100.blp", "Frostmourne100.blp"),
    ("IceStompRaised.mdx", "war3campImported\\IceStompRaised.mdx"),
    ("Rune-Blue-Aura_Raised20.mdx",
     "war3campImported\\Rune-Blue-Aura_Raised20.mdx"),
]
ITEM_ICONS = [
    ("BTNArchimondeHand_30HD.blp",
     "ReplaceableTextures\\CommandButtons\\BTNArchimondeHand_30HD.blp"),
    ("DISBTNArchimondeHand_30HD.blp",
     "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNArchimondeHand_30HD.blp"),
    ("BTNFrostmourne_30HD.blp",
     "ReplaceableTextures\\CommandButtons\\BTNFrostmourne_30HD.blp"),
    ("DISBTNFrostmourne_30HD.blp",
     "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNFrostmourne_30HD.blp"),
    ("BTNFirelordAvatar_30HD.blp",
     "ReplaceableTextures\\CommandButtons\\BTNFirelordAvatar_30HD.blp"),
]


def run(args):
    print(">>>", " ".join(str(a) for a in args), flush=True)
    r = subprocess.run(args, capture_output=True)
    out = r.stdout.decode("utf-8", "replace") + r.stderr.decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    if r.returncode != 0:
        raise SystemExit("command failed: %s" % args)


def extract_obj(src_map, ext, out):
    sys.path.insert(0, HERE)
    import war3mpq as W
    ar = W.MPQArchive(src_map)
    try:
        d = ar.read_file("war3map." + ext)
    finally:
        ar.close()
    if not d:
        raise SystemExit("%s 里没有 war3map.%s" % (src_map, ext))
    open(out, "wb").write(d)
    print("extract %s: %d bytes" % (ext, len(d)))


def extract_file(src_map, internal, out):
    sys.path.insert(0, HERE)
    import war3mpq as W
    ar = W.MPQArchive(src_map)
    try:
        d = ar.read_file(internal)
    finally:
        ar.close()
    if not d:
        raise SystemExit("%s 里没有 %s" % (src_map, internal))
    open(out, "wb").write(d)
    print("extract %s: %d bytes" % (internal, len(d)))


def write_ward_buff(out):
    """Create the ward timed-life label and its independent fallback buff."""
    sys.path.insert(0, HERE)
    import objparse as O
    mods = [
        ["fnam", 3, 0, 0, "守卫"],
        ["ftip", 3, 0, 0, "守卫"],
        ["fube", 3, 0, 0, "该守卫将在 36 秒后消失。"],
        ["fart", 3, 0, 0,
         r"ReplaceableTextures\CommandButtons\BTNSerpentWard.blp"],
    ]
    # UnitApplyTimedLife still uses BTLF for the visible countdown on this
    # engine, so override BTLF as well. B646 (based on a normal buff) remains
    # an independent fallback for the ward-only label.
    data = O.build_bytes(
        2,
        [{"old": "BTLF", "new": "BTLF", "mods": mods}],
        [{"old": "BEar", "new": "B646", "mods": mods}],
        "w3h")
    open(out, "wb").write(data)
    print("wrote ward buff %s (%d bytes)" % (out, len(data)))


def normalize_icon(src, dst):
    """源图 BLP 的 mip 表是重复/错位的，学习面板会取到坏 mip 显示绿块。
    重新编码成带完整 mip 的标准调色板 BLP（与游戏自带图标同格式）。"""
    sys.path.insert(0, HERE)
    from blp_icon import read_blp, write_blp1_palette
    from PIL import Image
    w, h, ab, hm, s0, rgba = read_blp(src)
    n, levels = write_blp1_palette(dst, Image.fromarray(rgba, "RGBA"), min_size=4)
    print("normalize icon %dx%d -> %s (%d bytes)" % (w, h, dst, n))


def normalize_jpeg_icon(src, dst):
    """把 JPEG 内容的 BLP 解码成 PNG 像素，再写成带完整 mip 的调色板 BLP。"""
    import io
    sys.path.insert(0, HERE)
    from blp_icon import write_blp1_palette
    from PIL import Image
    d = open(src, "rb").read()
    s = d.find(b"\xff\xd8")
    e = d.rfind(b"\xff\xd9")
    im = Image.open(io.BytesIO(d[s:e + 2])).convert("RGBA")
    n, levels = write_blp1_palette(dst, im, min_size=4)
    print("normalize jpeg icon %dx%d -> %s (%d bytes)" % (im.size[0], im.size[1], dst, n))


def patch_item_icon(path, item_id, icon):
    sys.path.insert(0, HERE)
    import objparse as O
    data = open(path, "rb").read()
    version, orig, custom = O.read_bytes(data, "w3t")
    found = False
    for entry in orig + custom:
        if entry["new"] != item_id:
            continue
        for mod in entry["mods"]:
            if mod[0] == "iico":
                mod[4] = icon
                found = True
        if not found:
            entry["mods"].append(["iico", O.T_STRING, None, None, icon])
            found = True
    if not found:
        raise SystemExit("item %s not found in %s" % (item_id, path))
    open(path, "wb").write(O.build_bytes(version, orig, custom, "w3t"))
    print("item icon %s -> %s" % (item_id, icon))


def main():
    if not os.path.exists(SRC):
        raise SystemExit("找不到底图: %s" % SRC)
    if not os.path.exists(HERO_ABILITY_SLK):
        raise SystemExit("缺少 3C AbilityData.slk: %s" % HERO_ABILITY_SLK)

    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "light_ranger", "--profile", "lt_ls3c"])
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "demon_hunter", "--profile", "lt"])
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "shadow_shaman", "--profile", "lt"])
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "blade_master", "--profile", "lt_blade"])
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "firelord", "--profile", "lt_fire"])
    if not os.path.exists(os.path.join(HERO_DIR, "hero.w3a")):
        raise SystemExit("英雄数据没有生成")

    shutil.copy2(SRC, DST)
    print("work copy:", DST, os.path.getsize(DST), flush=True)

    base_a = os.path.join(HERE, "_hero_base.w3a")
    base_t = os.path.join(HERE, "_hero_base.w3t")
    base_u = os.path.join(HERE, "_hero_base.w3u")
    base_h = os.path.join(HERE, "_hero_base.w3h")
    base_j = os.path.join(HERE, "_hero_base.j")
    extract_obj(SRC, "w3a", base_a)
    extract_obj(SRC, "w3t", base_t)
    extract_obj(SRC, "w3u", base_u)
    extract_obj(SRC, "w3h", base_h)
    extract_obj(SRC, "j", base_j)
    import patch_frostmourne_lt_script as fsp
    fsp.patch(base_j)
    write_ward_buff(HERO_WARD_BUFF)
    extract_file(HERO_SOURCE_MAP, "ReplaceableTextures\\CommandButtons\\BTNLS15.blp", HERO_ICON_SRC)
    normalize_icon(HERO_ICON_SRC, HERO_ICON)
    # 学习面板显示“未学习”状态时会取 DISBTN 禁用图标
    extract_file(HERO_SOURCE_MAP,
                 "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNLS15.blp",
                 HERO_DISBTN_SRC)
    normalize_icon(HERO_DISBTN_SRC, HERO_DISBTN)
    extract_file(HERO_SOURCE_MAP, "ReplaceableTextures\\CommandButtons\\BTNSH30.blp",
                 HERO_SH30_SRC)
    normalize_jpeg_icon(HERO_SH30_SRC, HERO_SH30)
    extract_file(HERO_SOURCE_MAP,
                 "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSH30.blp",
                 HERO_DISSH30_SRC)
    normalize_jpeg_icon(HERO_DISSH30_SRC, HERO_DISSH30)
    extract_file(HERO_SOURCE_MAP, "ReplaceableTextures\\CommandButtons\\BTNBM30.blp",
                 HERO_BM_ICON_SRC)
    normalize_jpeg_icon(HERO_BM_ICON_SRC, HERO_BM_ICON)
    extract_file(HERO_SOURCE_MAP,
                 "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNBM30.blp",
                 HERO_BM_DIS_SRC)
    normalize_jpeg_icon(HERO_BM_DIS_SRC, HERO_BM_DIS)

    merged_a = os.path.join(HERE, "_hero_merged.w3a")
    merged_t = os.path.join(HERE, "_hero_merged.w3t")
    merged_u = os.path.join(HERE, "_hero_merged.w3u")
    merged_h = os.path.join(HERE, "_hero_merged.w3h")
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_a,
         base_a, os.path.join(HERO_DIR, "hero.w3a"),
         os.path.join(HERO_DIR_DH, "hero.w3a"), os.path.join(HERO_DIR_SH, "hero.w3a"),
         os.path.join(HERO_DIR_BM, "hero.w3a"), os.path.join(HERO_DIR_FL, "hero.w3a"),
         os.path.join(FROST_DIR, "ability.w3a")])
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_t,
         base_t, os.path.join(FROST_DIR, "item.w3t")])
    patch_item_icon(
        merged_t, "I000",
        r"ReplaceableTextures\CommandButtons\BTNArchimondeHand_30HD.blp")
    patch_item_icon(
        merged_t, "I105",
        r"ReplaceableTextures\CommandButtons\BTNFrostmourne_30HD.blp")
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_u,
         base_u, os.path.join(HERO_DIR, "hero.w3u"),
         os.path.join(HERO_DIR_DH, "hero.w3u"), os.path.join(HERO_DIR_SH, "hero.w3u"),
         os.path.join(HERO_DIR_BM, "hero.w3u"), os.path.join(HERO_DIR_FL, "hero.w3u")])
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_h,
         base_h, HERO_WARD_BUFF])

    run([PY, os.path.join(HERE, "inject_native.py"), DST,
         "--base-script", base_j,
         "--script", SCRIPTS, "--script", FROST_SCRIPTS,
         "--file", merged_a + "=war3map.w3a",
         "--file", merged_t + "=war3map.w3t",
         "--file", merged_u + "=war3map.w3u",
         "--file", merged_h + "=war3map.w3h",
         "--file", HERO_ICON + "=ReplaceableTextures\\CommandButtons\\BTNLS15.blp",
         "--file", HERO_DISBTN + "=ReplaceableTextures\\CommandButtonsDisabled\\DISBTNLS15.blp",
         "--file", HERO_SH30 + "=ReplaceableTextures\\CommandButtons\\BTNSH30.blp",
         "--file", HERO_DISSH30 + "=ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSH30.blp",
         "--file", HERO_BM_ICON + "=ReplaceableTextures\\CommandButtons\\BTNBM30.blp",
         "--file", HERO_BM_DIS + "=ReplaceableTextures\\CommandButtonsDisabled\\DISBTNBM30.blp",
         ] + [
             token
             for src_name, internal in FROST_ASSETS
             for token in ("--file", os.path.join(FROST_DIR, "assets", src_name)
                           + "=" + internal)
         ] + [
             token
             for src_name, internal in ITEM_ICONS
             for token in ("--file", os.path.join(ITEM_ICON_DIR, src_name)
                           + "=" + internal)
         ] + [
         "--deploy", "LostTemple_heroes.w3x"])
    print("=== done ===", os.path.getsize(DST), flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
