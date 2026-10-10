"""把本机已解包地图里的图标 blp 解成 png，并拼成总览图(sheet)方便挑选。

用法:
    python icon_sheets.py <输出目录>
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from blp_icon import read_blp  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

SOURCES = [
    r"maps\仙之侠道\replaceabletextures\commandbuttons",
    r"H:\Games\War3\Maps\Download\侏罗纪公园1.5\replaceabletextures\commandbuttons",
    r"H:\Games\War3\Campaigns\血色使命 I 十周年纪念版\replaceabletextures\commandbuttons",
    r"H:\Games\War3\Maps\dz\rpg\侏罗纪-逃出神秘岛\replaceabletextures\commandbuttons",
]

PER_SHEET = 100
COLS = 10
CELL = 84


def decode(path):
    try:
        _w, _h, _ab, _hm, _s0, rgba = read_blp(path)
        return Image.fromarray(rgba, "RGBA")
    except Exception:
        return None


def main():
    outdir = sys.argv[1] if len(sys.argv) > 1 else os.path.join(BASE, "_blptmp", "sheets")
    os.makedirs(outdir, exist_ok=True)
    items = []
    for src in SOURCES:
        d = os.path.join(BASE, src) if not os.path.isabs(src) else src
        if not os.path.isdir(d):
            print("skip", d)
            continue
        files = sorted(glob.glob(os.path.join(d, "*.blp")))
        print("%-90s %d blp" % (d, len(files)))
        for f in files:
            img = decode(f)
            if img is not None:
                items.append((os.path.basename(f), f, img))
    print("decoded", len(items))

    for k in range(0, len(items), PER_SHEET):
        chunk = items[k:k + PER_SHEET]
        rows = (len(chunk) + COLS - 1) // COLS
        sheet = Image.new("RGB", (COLS * CELL, rows * (CELL + 12)), (20, 20, 24))
        dr = ImageDraw.Draw(sheet)
        for i, (name, _path, img) in enumerate(chunk):
            cx = (i % COLS) * CELL
            cy = (i // COLS) * (CELL + 12)
            sheet.paste(img.convert("RGB").resize((64, 64), Image.LANCZOS), (cx + 10, cy + 4))
            dr.text((cx + 4, cy + CELL - 6), name[:15], fill=(235, 235, 235))
        p = os.path.join(outdir, "sheet_%02d.png" % (k // PER_SHEET))
        sheet.save(p)
        print("sheet", p, len(chunk))

    # 索引: 序号 -> 名字 + 路径
    idx = ["# 本机可解码图标索引", ""]
    for i, (name, path, _img) in enumerate(items):
        idx.append("%4d  %s  %s" % (i, name, path))
    open(os.path.join(outdir, "index.txt"), "w", encoding="utf-8").write("\n".join(idx) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
