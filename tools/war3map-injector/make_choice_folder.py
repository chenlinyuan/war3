"""生成"图标候选"文件夹（给玩家挑物品图标用）。

产出于 <工程根>/图标候选/：
  01_可预览（完整图）/   本机其他地图里带的图标（能完整解码，直接看）
  02_标准图标（仅名字）/ 游戏自带图标（存在性已验证，但从 MPQ 里提不全 -> 只能给名字）
"""
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from blp_icon import read_blp  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OUT = os.path.join(BASE, "图标候选")

# (显示名, 说明, 源 blp 路径)
CUSTOM = [
    ("sss10", "金色爪手（护手+利爪），很有「阿克蒙德之手」的感觉", r"maps\仙之侠道\replaceabletextures\commandbuttons\sss10.blp"),
    ("e8", "蓝金爪手（利爪+护腕）", r"maps\仙之侠道\replaceabletextures\commandbuttons\e8.blp"),
    ("e7", "蓝色利爪", r"maps\仙之侠道\replaceabletextures\commandbuttons\e7.blp"),
    ("g1", "手持短刃（红黑手部）", r"maps\仙之侠道\replaceabletextures\commandbuttons\g1.blp"),
    ("sss1", "金绿利爪", r"maps\仙之侠道\replaceabletextures\commandbuttons\sss1.blp"),
    ("sss9", "绿色利爪", r"maps\仙之侠道\replaceabletextures\commandbuttons\sss9.blp"),
    ("b1", "绿色爪刃", r"maps\仙之侠道\replaceabletextures\commandbuttons\b1.blp"),
]

STANDARD = [
    ("BTNGlove", "食人魔力量手套（拳头/护手）—— 现在物品用的就是它"),
    ("BTNGauntletsOfOgrePower", "同上，另一张手套图标"),
    ("BTNClawsOfAttack", "攻击之爪（标准爪子图标）"),
    ("BTNGrabTree", "抓住一棵树（一只手）"),
    ("BTNNatureTouchGrow", "自然之触（手+绿光）"),
    ("BTNDruidOfTheClaw", "利爪德鲁伊（爪）"),
    ("BTNRingSkull", "骷髅指环"),
    ("BTNSacrificialSkull", "献祭骷髅"),
    ("BTNGuldanSkull", "古尔丹之颅"),
    ("BTNDoomGuard", "末日守卫（恶魔脸）"),
    ("BTNHeal", "治疗（金色，治疗光环在用）"),
    ("BTNHealingWard", "治疗守卫（巫医图腾）"),
    ("BTNHeartOfAszune", "阿祖内之心（红心，治疗感）"),
    ("BTNScrollOfHealing", "治疗卷轴"),
]


def main():
    one = os.path.join(OUT, "01_可预览（完整图）")
    two = os.path.join(OUT, "02_标准图标（仅名字）")
    os.makedirs(one, exist_ok=True)
    os.makedirs(two, exist_ok=True)

    items = []
    lines = []
    for short, desc, rel in CUSTOM:
        p = rel if os.path.isabs(rel) else os.path.join(BASE, rel)
        if not os.path.exists(p):
            print("missing", p)
            continue
        _w, _h, _ab, _hm, _s0, rgba = read_blp(p)
        img = Image.fromarray(rgba, "RGBA")
        img.resize((128, 128), Image.LANCZOS).save(os.path.join(one, short + ".png"))
        shutil.copy2(p, os.path.join(one, short + ".blp"))
        items.append((short, desc, img))
        lines.append("| `%s` | %s | `%s` |" % (short, desc, rel))

    # 总览
    cols, cell = 4, 150
    rows = (len(items) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * cell, rows * cell), (18, 18, 22))
    dr = ImageDraw.Draw(sheet)
    for i, (short, desc, img) in enumerate(items):
        cx, cy = (i % cols) * cell, (i // cols) * cell
        sheet.paste(img.convert("RGB").resize((112, 112), Image.LANCZOS), (cx + 18, cy + 10))
        dr.text((cx + 10, cy + 128), short, fill=(240, 240, 240))
    sheet.save(os.path.join(one, "_总览.png"))

    std = "\n".join("| `%s` | %s |" % (n, d) for n, d in STANDARD)
    open(os.path.join(two, "标准图标清单.md"), "w", encoding="utf-8").write(
        "# 游戏自带图标（存在性已用 MPQ 逐个验证过）\n\n"
        "这些名字**确实存在于游戏里**，直接写进物品的 `iico` 就能用。\n"
        "之所以没放预览图：游戏 MPQ 里的图标提取工具链目前只能完整解出少数几个\n"
        "（见 `tools/war3map-injector/extract_icon.py` 的说明），预览会缺一大块。\n"
        "**想看真实效果**：用 World Editor 打开地图 → 物品编辑器 → 找任一物品的"
        "「图标 - 普通」字段 → 双击选图标，左侧列表里按名字找（或直接搜索名字）。\n\n"
        "| 名字 | 长什么样 |\n| --- | --- |\n" + std + "\n")

    open(os.path.join(OUT, "README.md"), "w", encoding="utf-8").write(
        "# 图标候选（给阿克蒙德之手挑一个物品图标）\n\n"
        "两种选法，选完直接告诉我名字就行：\n\n"
        "1. **`01_可预览（完整图）`** —— 本机其他地图里带的图标，能完整看到效果（含 `_总览.png`）。\n"
        "   这些是从别的图里带过来的素材（来源见下表），你确定要用我就把它塞进地图。\n"
        "2. **`02_标准图标（仅名字）`** —— 游戏自带图标，最稳妥（不用导入任何文件），\n"
        "   但目前只能给你名字（提取工具链限制），真实效果请用 World Editor 的图标选择列表看。\n\n"
        "## 01 里的候选\n\n| 名字 | 说明 | 来源 |\n| --- | --- | --- |\n" + "\n".join(lines) + "\n")
    print("wrote", OUT, len(items), "custom icons")
    return 0


if __name__ == "__main__":
    sys.exit(main())
