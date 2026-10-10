"""生成"治疗光环"的 buff 图标（橙色治疗感）: _wing_heal.blp + 预览 png。

做成 64x64 的 BLP1 调色板文件（同 War3 自带图标格式），注入到地图内部的
    ReplaceableTextures\\CommandButtons\\BTNWingHeal.blp
然后让治疗光环的 buff(Boar) 的 fart 指向它 —— 这样状态栏里就有橙色的治疗图标了。

用法:
    python gen_heal_icon.py
"""
import os
import sys

import numpy as np
from PIL import Image, ImageDraw, ImageFilter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from blp_icon import write_blp1_palette  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
S = 64


def build_icon():
    yy, xx = np.mgrid[0:S, 0:S].astype(np.float32)
    cx = cy = (S - 1) / 2.0
    r = np.sqrt((xx - cx) ** 2 + (yy - cy) ** 2)

    # 1) 底: 暖橙 -> 深棕 的径向渐变
    inner = np.array([168, 82, 20], np.float32)
    outer = np.array([34, 18, 10], np.float32)
    t = np.clip(r / 46.0, 0.0, 1.0)[..., None]
    img = inner * (1.0 - t) + outer * t

    # 2) 中心橙金色发光
    glow = np.exp(-((r / 17.0) ** 2))[..., None]
    img = img + glow * np.array([255, 150, 45], np.float32) * 0.85

    # 3) 白色十字(治疗符号) + 外发光
    cross = Image.new("L", (S, S), 0)
    d = ImageDraw.Draw(cross)
    arm, thick = 23, 10
    d.rectangle([(S - arm) // 2, (S - thick) // 2, (S + arm) // 2 - 1, (S + thick) // 2 - 1], fill=255)
    d.rectangle([(S - thick) // 2, (S - arm) // 2, (S + thick) // 2 - 1, (S + arm) // 2 - 1], fill=255)
    cmask = np.array(cross, np.float32) / 255.0
    soft = np.array(
        Image.fromarray((cmask * 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(3.5)),
        np.float32,
    ) / 255.0
    img = img + (soft[..., None] * np.array([255, 190, 90], np.float32)) * 0.6
    img = img * (1.0 - cmask[..., None]) + np.array([255, 253, 245], np.float32) * cmask[..., None]

    img = np.clip(img, 0, 255).astype(np.uint8)

    # 4) 圆角 alpha
    mask = Image.new("L", (S, S), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, S - 1, S - 1], radius=7, fill=255)
    alpha = np.array(mask, np.uint8)
    return Image.fromarray(np.dstack([img, alpha]), "RGBA")


def main():
    icon = build_icon()
    png = os.path.join(HERE, "_wing_heal.png")
    blp = os.path.join(HERE, "_wing_heal.blp")
    icon.save(png)
    n, levels = write_blp1_palette(blp, icon, min_size=4)
    print("png :", png)
    print("blp : %s (%d bytes, mips %s)" % (blp, n, levels))
    return 0


if __name__ == "__main__":
    sys.exit(main())
