"""从游戏 MPQ 里按名字提取图标（BLP）并转成 PNG 预览。

用法:
    python extract_icon.py <内部路径或图标名> [输出目录]
    python extract_icon.py --check BTNGlove.blp BTNHeal.blp ...   # 只检查是否存在

依赖: war3mpq.py（注意 2026-10-10 修好了 _hash_string，之前按名字查找全是失败的）
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402
from blp_icon import read_blp  # noqa: E402
from PIL import Image  # noqa: E402

GAME_DIR = r"H:\Games\War3"
ARCHIVES = [
    os.path.join(GAME_DIR, "War3Patch.mpq"),
    os.path.join(GAME_DIR, "War3xlocal.mpq"),
    os.path.join(GAME_DIR, "War3x.mpq"),
    os.path.join(GAME_DIR, "war3.mpq"),
]


def candidates(name):
    """把一个名字扩展成可能的内部路径。"""
    if "\\" in name or "/" in name:
        yield name.replace("/", "\\")
        return
    yield "ReplaceableTextures\\CommandButtons\\" + name
    yield "ReplaceableTextures\\PassiveButtons\\" + name
    yield "ReplaceableTextures\\CommandButtonsDisabled\\" + name
    yield name


def find(name):
    for arc in ARCHIVES:
        if not os.path.exists(arc):
            continue
        a = W.MPQArchive(arc)
        try:
            for cand in candidates(name):
                data = a.read_file(cand)
                if data:
                    return os.path.basename(arc), cand, data
        finally:
            a.close()
    return None, None, None


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        return 1
    check_only = args[0] == "--check"
    if check_only:
        args = args[1:]
    for name in args:
        arc, path, data = find(name)
        if not data:
            print("%-34s NOT FOUND" % name)
            continue
        print("%-34s %-16s %-52s %d bytes" % (name, arc, path, len(data)))
        if check_only:
            continue
        outdir = sys.argv[2] if len(sys.argv) > 2 and os.path.isdir(sys.argv[2]) else os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "_icons")
        os.makedirs(outdir, exist_ok=True)
        blp = os.path.join(outdir, os.path.splitext(os.path.basename(path))[0] + ".blp")
        open(blp, "wb").write(data)
        try:
            w, h, ab, hm, s0, rgba = read_blp(blp)
            png = os.path.join(outdir, os.path.splitext(os.path.basename(path))[0] + ".png")
            Image.fromarray(rgba, "RGBA").save(png)
            print("      -> %s  (%dx%d -> png)" % (png, w, h))
        except Exception as e:
            print("      decode failed: %s" % e)
    return 0


if __name__ == "__main__":
    sys.exit(main())
