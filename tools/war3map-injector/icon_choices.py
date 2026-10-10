"""从游戏 MPQ 里挑一批图标导出成 PNG 供选型（带总览图 + 索引）。

用法:
    python icon_choices.py <输出目录> <关键词正则> [更多关键词...]

例:
    python icon_choices.py 图标候选/01_手部 "glove|claw|hand|fist|grasp|grab|palm|touch"

原理: 读 war3.mpq / War3x.mpq / War3xlocal.mpq 的 (listfile) 拿到全部文件名，
按关键词筛出图标，逐个从 MPQ 提取并用 blp_icon 转 PNG。
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402
from blp_icon import read_blp  # noqa: E402
from extract_icon import ARCHIVES  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ICON_DIRS = ("replaceabletextures\\commandbuttons\\", "replaceabletextures\\passivebuttons\\")


def game_icon_names():
    """候选池 = 本机已解包地图里出现过的图标路径（1134 个，见 scan_icon_names.py）。

    游戏自带 MPQ 的 (listfile) 是加密的（读出来是压缩数据），拿不到全量文件名；
    但"地图对象数据里引用过的名字"已经足够当候选池，而且逐个还能直接用 MPQ 查存在性。
    """
    names = set()
    pool = os.path.join(BASE, "docs", "06-工具链", "图标路径实测.txt")
    if os.path.exists(pool):
        for line in open(pool, encoding="utf-8"):
            line = line.strip()
            if line and not line.startswith("#"):
                names.add(line.split(" ")[0])
    return sorted(names)


EXTRA = [
    # 可能的手/拳/爪相关（脚本会逐个查存在性，不存在的自动丢掉）
    "ReplaceableTextures\\CommandButtons\\BTNGauntlets.blp",
    "ReplaceableTextures\\CommandButtons\\BTNHandOfDeath.blp",
    "ReplaceableTextures\\CommandButtons\\BTNPalmStrike.blp",
    "ReplaceableTextures\\CommandButtons\\BTNSkeletalHand.blp",
    "ReplaceableTextures\\CommandButtons\\BTNFistOfFury.blp",
    "ReplaceableTextures\\CommandButtons\\BTNGrasp.blp",
]


def extract(name):
    short = os.path.basename(name.replace("/", "\\"))
    for arc in ARCHIVES:
        if not os.path.exists(arc):
            continue
        a = W.MPQArchive(arc)
        try:
            data = a.read_file(name)
        finally:
            a.close()
        if data:
            tmp = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_icons")
            os.makedirs(tmp, exist_ok=True)
            p = os.path.join(tmp, short)
            open(p, "wb").write(data)
            try:
                _w, _h, _ab, _hm, _s0, rgba = read_blp(p)
                return Image.fromarray(rgba, "RGBA")
            except Exception as e:
                print("   decode fail %s: %s" % (short, e))
                return None
    return None


def contact_sheet(items, out_path, cols=6, cell=72, label_h=14):
    rows = (len(items) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * cell, rows * (cell + label_h)), (24, 24, 28))
    d = ImageDraw.Draw(sheet)
    for i, (name, img) in enumerate(items):
        cx = (i % cols) * cell
        cy = (i // cols) * (cell + label_h)
        if img:
            sheet.paste(img.convert("RGB").resize((64, 64), Image.LANCZOS), (cx + 4, cy + 4))
        d.text((cx + 3, cy + cell - 4), name[:14], fill=(230, 230, 230))
    sheet.save(out_path)


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    outdir = os.path.join(BASE, sys.argv[1]) if not os.path.isabs(sys.argv[1]) else sys.argv[1]
    pats = [re.compile(p, re.I) for p in sys.argv[2:]]
    os.makedirs(outdir, exist_ok=True)

    all_names = game_icon_names()
    print("game icon files:", len(all_names))
    picked = [n for n in all_names + EXTRA
              if any(p.search(os.path.basename(n).lower()) for p in pats)]
    print("matched:", len(picked))

    items = []
    for n in picked:
        short = os.path.splitext(os.path.basename(n))[0]
        img = extract(n)
        if img is None:
            continue
        img.save(os.path.join(outdir, short + ".png"))
        items.append((short, img))
        print("   ok", short)

    if items:
        contact_sheet(items, os.path.join(outdir, "_总览.png"))
    lines = ["# 图标候选（从游戏 MPQ 直接提取）", "",
             "格式：文件名（内部路径）——回复你要的名字即可。", ""]
    for n in picked:
        lines.append("- %s  ->  %s" % (os.path.splitext(os.path.basename(n))[0], n))
    open(os.path.join(outdir, "索引.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print("wrote %d icons to %s" % (len(items), outdir))
    return 0


if __name__ == "__main__":
    sys.exit(main())
