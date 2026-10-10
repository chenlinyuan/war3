"""扫描本机已解包地图的对象数据，导出"真实存在"的图标路径清单。

用途：写技能/物品/buff 的图标字段时，从这里挑，别凭印象写
（凭印象写错的名字在游戏里就是空图标/绿方块）。

用法:
    python scan_icon_names.py [输出文件]
默认输出 docs/06-工具链/图标路径实测.txt
"""
import collections
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))

ROOTS = [
    os.path.join(BASE, "maps", "伏魔战记.w3x.orig"),
    os.path.join(BASE, "maps", "仙之侠道"),
    os.path.join(BASE, "maps", "sj.original"),
    os.path.join(BASE, "maps", "campaign"),
    os.path.join(BASE, "maps", "LostTemple"),
]
EXTS = (".w3a", ".w3t", ".w3u", ".w3h", ".w3d", ".w3b", ".slk", ".wts", ".j", ".txt")
PAT = re.compile(r"[A-Za-z0-9_\\/]*BTN[A-Za-z0-9_]+\.blp")


def scan():
    names = collections.Counter()
    for root in ROOTS:
        if not os.path.isdir(root):
            continue
        for dirpath, _dirnames, filenames in os.walk(root):
            for fn in filenames:
                if not fn.lower().endswith(EXTS):
                    continue
                try:
                    text = open(os.path.join(dirpath, fn), "rb").read().decode("latin-1")
                except OSError:
                    continue
                for m in PAT.findall(text):
                    names[m.replace("/", "\\")] += 1
    return names


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        BASE, "docs", "06-工具链", "图标路径实测.txt")
    names = scan()
    header = [
        "# 可用图标路径实测清单（自动生成，勿手改）",
        "",
        "生成：`python tools/war3map-injector/scan_icon_names.py`",
        "",
        "来源：把本机已解包地图的对象数据里的 BTN*.blp 字符串抓出来去重 —— "
        "这些路径**真实存在**（地图能用说明游戏里有）。",
        "",
        "扫描目录：" + "、".join(os.path.relpath(r, BASE).replace("\\", "/") for r in ROOTS),
        "扫描类型：" + " ".join(EXTS),
        "",
        "格式：路径  引用次数（次数多 = 多张图都在用，越稳）",
        "",
    ]
    body = ["%s %d" % (k, v) for k, v in names.most_common()]
    os.makedirs(os.path.dirname(out), exist_ok=True)
    open(out, "w", encoding="utf-8").write("\n".join(header + body) + "\n")
    print("wrote %s: %d icons" % (out, len(body)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
