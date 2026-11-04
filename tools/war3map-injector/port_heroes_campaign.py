"""Inject the LS/SH hero port into the 燃烧之怒 campaign chapters.

The campaign uses per-chapter object data.  We never touch war3campaign.*.
Each chapter gets:
  * LS + SH w3a/w3u
  * the ward-only timed-life buff B646 (w3h)
  * scripts/heroes, with Burning-specific skill requirements and unit IDs
  * the two hero icons used by LS/SH

Usage:
    python port_heroes_campaign.py [--only ransao01.w3x]
"""
import argparse
import os
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or r"C:\Python313\python.exe"
sys.path.insert(0, HERE)
import hero_port as HP  # noqa: E402

WORK = os.path.join(BASE, "maps", "port", "194213f")
CHAPTER_DIR = os.path.join(WORK, "base")
CAMPAIGN = os.path.join(
    r"H:\Games\War3\Campaigns",
    "燃烧之怒v烈焰降临（单机版-D8版·翅膀版）.w3n")
OUT = os.path.join(
    r"H:\Games\War3\Campaigns",
    "燃烧之怒v烈焰降临（单机版-D8版·翅膀英雄版）.w3n")

LS_DIR = os.path.join(HERE, "_hero_burning_ls")
SH_DIR = os.path.join(HERE, "_hero_burning_sh")
SCRIPT_SRC = os.path.join(BASE, "scripts", "heroes")
SCRIPT_OUT = os.path.join(HERE, "_heroes_burning")
WARD_BUFF = os.path.join(HERE, "_hero_burning_ward.w3h")

ICON_FILES = [
    (os.path.join(HERE, "_hero_BTNLS15.blp"),
     r"ReplaceableTextures\CommandButtons\BTNLS15.blp"),
    (os.path.join(HERE, "_hero_DISBTNLS15.blp"),
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNLS15.blp"),
    (os.path.join(HERE, "_hero_BTNSH30.blp"),
     r"ReplaceableTextures\CommandButtons\BTNSH30.blp"),
    (os.path.join(HERE, "_hero_DISBTNSH30.blp"),
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNSH30.blp"),
]


def run(args, env=None):
    print(">>>", " ".join(str(a) for a in args), flush=True)
    e = os.environ.copy()
    if env:
        e.update(env)
    r = subprocess.run(args, capture_output=True, env=e)
    out = r.stdout.decode("utf-8", "replace") + r.stderr.decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    if r.returncode:
        raise SystemExit("command failed: %s" % args)


def extract_file(map_path, internal, out):
    sys.path.insert(0, HERE)
    import war3mpq as W
    ar = W.MPQArchive(map_path)
    try:
        d = ar.read_file(internal)
    finally:
        ar.close()
    if not d:
        return False
    with open(out, "wb") as f:
        f.write(d)
    return True


def write_ward_buff(out):
    sys.path.insert(0, HERE)
    import objparse as O
    mods = [
        ["fnam", 3, 0, 0, "守卫"],
        ["ftip", 3, 0, 0, "守卫"],
        ["fube", 3, 0, 0, "该守卫将在 36 秒后消失。"],
        ["fart", 3, 0, 0,
         r"ReplaceableTextures\CommandButtons\BTNSerpentWard.blp"],
    ]
    data = O.build_bytes(
        2,
        [{"old": "BTLF", "new": "BTLF", "mods": mods}],
        [{"old": "BEar", "new": "B646", "mods": mods}],
        "w3h")
    with open(out, "wb") as f:
        f.write(data)
    print("ward buff ->", out, len(data), "bytes")


def make_script_variant(profile):
    os.makedirs(SCRIPT_OUT, exist_ok=True)
    shutil.copy2(os.path.join(SCRIPT_SRC, "g.j"), os.path.join(SCRIPT_OUT, "g.j"))
    shutil.copy2(os.path.join(SCRIPT_SRC, "m.j"), os.path.join(SCRIPT_OUT, "m.j"))
    with open(os.path.join(SCRIPT_SRC, "f.j"), "r", encoding="utf-8") as f:
        text = f.read()
    start = text.index("    set HB_HERO_COUNT = 3")
    end = text.index("    set HB_ABIL_SILENCE =")
    block = '''    set HB_HERO_COUNT = 2
    set HB_HERO_NAME[0] = "光明游侠"
    set HB_HERO_ID[0] = "H0L1"
    set HB_HERO_ALIAS[0] = "Hvwd,lightranger,ls,gmyx,guangmingyouxia"
    set HB_HERO_TYPE[0] = 'H0L1'
    set HB_HERO_ABIL_COUNT[0] = 5
    set HB_HERO_ABIL[0] = 'A0L1'
    set HB_HERO_ABIL_MAX[0] = 10
    set HB_HERO_ABIL[1] = 'A0L2'
    set HB_HERO_ABIL_MAX[1] = 10
    set HB_HERO_ABIL[2] = 'A0L3'
    set HB_HERO_ABIL_MAX[2] = 10
    set HB_HERO_ABIL[3] = 'A0L4'
    set HB_HERO_ABIL_MAX[3] = 2
    set HB_HERO_ABIL[4] = 'A0L5'
    set HB_HERO_ABIL_MAX[4] = 1
    set HB_HERO_ABIL_REQ[0] = 1
    set HB_HERO_ABIL_SKIP[0] = 2
    set HB_HERO_ABIL_REQ[1] = 2
    set HB_HERO_ABIL_SKIP[1] = 2
    set HB_HERO_ABIL_REQ[2] = 1
    set HB_HERO_ABIL_SKIP[2] = 2
    set HB_HERO_ABIL_REQ[3] = 10
    set HB_HERO_ABIL_SKIP[3] = 10
    set HB_HERO_ABIL_REQ[4] = 20
    set HB_HERO_ABIL_SKIP[4] = 1
    set HB_HERO_MORPH[0] = 0

    set HB_HERO_NAME[1] = "暗影猎手"
    set HB_HERO_ID[1] = "H0S1"
    set HB_HERO_ALIAS[1] = "Oshd,sh,xiaoy,shadowhunter"
    set HB_HERO_TYPE[1] = 'H0S1'
    set HB_HERO_MORPH[1] = 0
    set HB_HERO_ABIL_COUNT[1] = 5
    set HB_HERO_ABIL[8] = 'A0S1'
    set HB_HERO_ABIL_MAX[8] = 10
    set HB_HERO_ABIL[9] = 'A0S2'
    set HB_HERO_ABIL_MAX[9] = 10
    set HB_HERO_ABIL[10] = 'A0S3'
    set HB_HERO_ABIL_MAX[10] = 10
    set HB_HERO_ABIL[11] = 'A0S4'
    set HB_HERO_ABIL_MAX[11] = 2
    set HB_HERO_ABIL[12] = 'A0S5'
    set HB_HERO_ABIL_MAX[12] = 1
    set HB_HERO_ABIL_REQ[8] = 1
    set HB_HERO_ABIL_SKIP[8] = 2
    set HB_HERO_ABIL_REQ[9] = 2
    set HB_HERO_ABIL_SKIP[9] = 2
    set HB_HERO_ABIL_REQ[10] = 1
    set HB_HERO_ABIL_SKIP[10] = 2
    set HB_HERO_ABIL_REQ[11] = 10
    set HB_HERO_ABIL_SKIP[11] = 10
    set HB_HERO_ABIL_REQ[12] = 20
    set HB_HERO_ABIL_SKIP[12] = 1

'''
    text = text[:start] + block + text[end:]
    unit_map = HP.PROFILES[profile]["unit_map"]
    for old, new in unit_map.items():
        text = text.replace("'%s'" % old, "'%s'" % new)
    with open(os.path.join(SCRIPT_OUT, "f.j"), "w", encoding="utf-8", newline="\n") as f:
        f.write(text)
    print("script variant ->", SCRIPT_OUT)


def make_heroes(profile):
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "light_ranger",
         "--profile", profile, "--outdir", LS_DIR])
    run([PY, os.path.join(HERE, "hero_port.py"), "--hero", "shadow_shaman",
         "--profile", profile, "--outdir", SH_DIR])
    for p in (os.path.join(LS_DIR, "hero.w3a"), os.path.join(LS_DIR, "hero.w3u"),
              os.path.join(SH_DIR, "hero.w3a"), os.path.join(SH_DIR, "hero.w3u")):
        if not os.path.exists(p):
            raise SystemExit("missing hero package: " + p)


def has_hero_script(chapter):
    sys.path.insert(0, HERE)
    import war3mpq as W
    ar = W.MPQArchive(chapter)
    try:
        d = ar.read_file("war3map.j") or b""
    finally:
        ar.close()
    return b"HB_Init" in d


def inject_chapter(chapter, tmp):
    name = os.path.splitext(os.path.basename(chapter))[0]
    base_a = os.path.join(tmp, name + "_base.w3a")
    base_u = os.path.join(tmp, name + "_base.w3u")
    base_h = os.path.join(tmp, name + "_base.w3h")
    if not extract_file(chapter, "war3map.w3a", base_a):
        raise SystemExit("missing war3map.w3a: " + chapter)
    if not extract_file(chapter, "war3map.w3u", base_u):
        raise SystemExit("missing war3map.w3u: " + chapter)
    extract_file(chapter, "war3map.w3h", base_h)

    merged_a = os.path.join(tmp, name + "_merged.w3a")
    merged_u = os.path.join(tmp, name + "_merged.w3u")
    merged_h = os.path.join(tmp, name + "_merged.w3h")
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_a,
         base_a, os.path.join(LS_DIR, "hero.w3a"),
         os.path.join(SH_DIR, "hero.w3a")])
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_u,
         base_u, os.path.join(LS_DIR, "hero.w3u"),
         os.path.join(SH_DIR, "hero.w3u")])
    run([PY, os.path.join(HERE, "merge_w3obj.py"), merged_h,
         base_h, WARD_BUFF])

    args = [PY, os.path.join(HERE, "inject_native.py"), chapter,
            "--script", SCRIPT_OUT,
            "--file", merged_a + "=war3map.w3a",
            "--file", merged_u + "=war3map.w3u",
            "--file", merged_h + "=war3map.w3h"]
    for src, internal in ICON_FILES:
        if not os.path.exists(src):
            raise SystemExit("missing icon: " + src)
        args += ["--file", src + "=" + internal]
    run(args)
    if not has_hero_script(chapter):
        raise SystemExit("HB_Init missing after injection: " + chapter)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default=CAMPAIGN)
    ap.add_argument("--out", default=OUT)
    ap.add_argument("--work", default=WORK)
    ap.add_argument("--only")
    ap.add_argument("--profile", default="burning")
    ap.add_argument("--skip-pack", action="store_true")
    args = ap.parse_args()
    global CHAPTER_DIR, LS_DIR, SH_DIR, SCRIPT_OUT
    CHAPTER_DIR = os.path.join(os.path.abspath(args.work), "base")
    if not os.path.isdir(CHAPTER_DIR):
        raise SystemExit("missing chapter dir: " + CHAPTER_DIR)
    if not os.path.exists(args.campaign):
        raise SystemExit("missing campaign: " + args.campaign)

    LS_DIR = os.path.join(HERE, "_hero_%s_ls" % args.profile)
    SH_DIR = os.path.join(HERE, "_hero_%s_sh" % args.profile)
    SCRIPT_OUT = os.path.join(HERE, "_heroes_%s" % args.profile)
    make_heroes(args.profile)
    make_script_variant(args.profile)
    write_ward_buff(WARD_BUFF)
    tmp = os.path.join(HERE, "_hero_campaign_tmp")
    os.makedirs(tmp, exist_ok=True)

    only = None
    if args.only:
        only = set(x.strip() for x in args.only.split(",") if x.strip())
    chapters = sorted(
        f for f in os.listdir(CHAPTER_DIR)
        if f.lower().endswith((".w3x", ".w3m"))
        and (not only or f in only)
    )
    ok = skip = fail = 0
    for i, ch in enumerate(chapters, 1):
        p = os.path.join(CHAPTER_DIR, ch)
        print("\n[%d/%d] %s" % (i, len(chapters), ch), flush=True)
        if has_hero_script(p):
            print("  already has HB_Init, skip")
            skip += 1
            continue
        try:
            inject_chapter(p, tmp)
            ok += 1
            print("  [OK]")
        except SystemExit as e:
            print("  [FAIL]", e)
            fail += 1
    print("\nchapters: injected=%d skipped=%d failed=%d" % (ok, skip, fail))
    if fail:
        return 1
    if not args.skip_pack:
        run([PY, os.path.join(HERE, "port_wings_campaign.py"), "pack",
             args.campaign, "--work", os.path.abspath(args.work),
             "--out", args.out, "--chapters-only"])
        print("campaign ->", args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
