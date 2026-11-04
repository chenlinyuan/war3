# -*- coding: utf-8 -*-
"""阿克蒙德之手（战役装备）——把模板里的固定 ID 换成配置里的 ID。

为什么要有这个文件：
  * 阿克蒙德之手的对象数据（物品 + 4 个技能）是从战役里提取的，字段值照抄不动；
  * 但它用掉的 5 个 ID（I000 / A000 / A001 / A002 / Azcr）**别的图很可能已经用了**
    （实测：侏罗纪公园1.5 里 I000 是"瓦斯"、A000/A001/A002 也都被占），所以移植时
    不能直接塞进去；
  * 这里只做一件事：**按 wings_config.HAND 里的 ID 重写模板**（同时改物品
    iabi / icid 里对技能 ID 的引用）。生成器与移植脚本都走这里。

模板文件（仓库里的原始提取物，不要手改）:
  * _hand.w3t     —— 1 条物品 I000
  * _lt_hand.w3a  —— 4 条技能 A000(死亡之指) / A001(阿克蒙德之力) / A002(攻速) / Azcr(致命一击)

用法:
    python hand_data.py <输出.w3t> <输出.w3a>      # 用默认配置
    WINGS_CONFIG=wings_config_1_5 python hand_data.py ...
"""
import os
import re
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

TEMPLATE_W3T = os.path.join(HERE, "_hand.w3t")
TEMPLATE_W3A = os.path.join(HERE, "_lt_hand.w3a")
ITEM_PASSIVE_COLOR = "|cff5ddf26"
ITEM_ACTIVE_COLOR = "|cff66ccff"

# 模板里的原始 ID（固定不变）
TPL_ITEM = "I000"
TPL_FINGER = "A000"
TPL_AURA = "A001"
TPL_SPEED = "A002"
TPL_CRIT = "Azcr"

HAS_LEVEL_COLUMN = {"w3a", "w3q"}


def read_entries(path):
    """读出 (version, orig, cust)，每条 entry = (old, new, mods)，mods = [(mid, t, lv, col, val)]。"""
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN
    d = open(path, "rb").read()
    off = 0
    ver = struct.unpack_from("<i", d, off)[0]
    off += 4
    n_orig = struct.unpack_from("<i", d, off)[0]
    off += 4

    def read_entry(off):
        old = d[off:off + 4].decode("latin-1")
        new = d[off + 4:off + 8].decode("latin-1")
        off += 8
        n = struct.unpack_from("<i", d, off)[0]
        off += 4
        mods = []
        for _ in range(n):
            mid = d[off:off + 4].decode("latin-1")
            off += 4
            t = struct.unpack_from("<i", d, off)[0]
            off += 4
            lv = col = 0
            if has_lc:
                lv, col = struct.unpack_from("<ii", d, off)
                off += 8
            if t == 0:
                val = struct.unpack_from("<i", d, off)[0]
                off += 4
            elif t in (1, 2):
                val = struct.unpack_from("<f", d, off)[0]
                off += 4
            elif t == 3:
                end = d.index(b"\x00", off)
                val = d[off:end].decode("utf-8", "replace")
                off = end + 1
            else:
                raise ValueError("bad type %d at off %d" % (t, off))
            off += 4
            mods.append((mid, t, lv, col, val))
        return (old, new, mods), off

    orig = []
    for _ in range(n_orig):
        e, off = read_entry(off)
        orig.append(e)
    n_cust = struct.unpack_from("<i", d, off)[0]
    off += 4
    cust = []
    for _ in range(n_cust):
        e, off = read_entry(off)
        cust.append(e)
    return ver, orig, cust


def write_entries(path, ver, orig, cust):
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN

    def write_entry(old, new, mods):
        out = old.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
        for mid, t, lv, col, val in mods:
            out += mid.encode("latin-1") + struct.pack("<i", t)
            if has_lc:
                out += struct.pack("<ii", lv, col)
            if t == 0:
                out += struct.pack("<i", val)
            elif t in (1, 2):
                out += struct.pack("<f", val)
            elif t == 3:
                out += val.encode("utf-8") + b"\x00"
            out += struct.pack("<i", 0)
        return out

    data = struct.pack("<ii", ver, len(orig))
    for e in orig:
        data += write_entry(*e)
    data += struct.pack("<i", len(cust))
    for e in cust:
        data += write_entry(*e)
    open(path, "wb").write(data)


def _patch_string(val, mapping):
    """把逗号分隔的技能 ID 列表里的 ID 换成新的（只换整段匹配的 4 字符 ID）。"""
    parts = [p for p in val.split(",")]
    out = [mapping.get(p, p) for p in parts]
    return ",".join(out)


def _canonical_hand_text(text, skill_line, soul_line, keep_lore):
    """统一阿克蒙德之手说明：被动、装备技能、剧情，剧情固定放最后。"""
    lore = ""
    if keep_lore:
        marker = "|cffffcc00阿克蒙德"
        position = text.find(marker)
        if position >= 0:
            lore = text[position:]
            text = text[:position]

    body_lines = []
    passives = {"重击": "", "掠夺": ""}
    for line in text.split("|n"):
        if "装备后获得技能：死亡之指（F）" in line or "夺魂" in line:
            continue
        line = line.replace("，可主动释放死亡之指。", "。")
        line = line.replace("可主动释放死亡之指。", "")
        plain = re.sub(r"\|c[0-9a-fA-F]{8}", "", line).replace("|r", "")
        matched = [label for label in passives if label in plain]
        if matched:
            label = matched[0]
            passives[label] = ITEM_PASSIVE_COLOR + plain + "|r"
        else:
            body_lines.append(line)
    while body_lines and not body_lines[-1]:
        body_lines.pop()
    body_lines.extend(
        passives[label] for label in ("重击", "掠夺") if passives[label]
    )
    body = "|n".join(body_lines)
    body = re.sub(r"^(?:\|n)+|(?:\|n)+$", "", body)

    sections = [section for section in (body, soul_line, skill_line) if section]
    result = "|n".join(sections)
    if lore:
        result += "|n|n" + lore
    return result


def build(out_w3t, out_w3a, cfg=None):
    """按配置里的 ID 重写"阿克蒙德之手"模板，写出 w3t / w3a。"""
    if cfg is None:
        cfg = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))
    hand = cfg.HAND
    mapping = {
        TPL_ITEM: hand["item"],
        TPL_FINGER: hand["finger"],
        TPL_AURA: hand["aura"],
        TPL_SPEED: hand["speed"],
        TPL_CRIT: hand["crit"],
    }
    if len(set(mapping.values())) != len(mapping):
        raise SystemExit("HAND 里的 ID 有重复: %s" % mapping)

    # --- 物品 ---
    ver, orig, cust = read_entries(TEMPLATE_W3T)
    out_cust = []
    for old, new, mods in cust:
        new2 = mapping.get(new, new)
        mods2 = []
        for mid, t, lv, col, val in mods:
            if t == 3 and isinstance(val, str) and mid in ("iabi", "icid"):
                val = _patch_string(val, mapping)
            if mid == "icid":
                continue
            if mid == "iabi":
                val = ",".join(
                    part for part in val.split(",")
                    if part != mapping[TPL_FINGER]
                )
            elif mid == "iusa":
                val = 0
            elif mid == "ihot":
                val = ""
            mods2.append((mid, t, lv, col, val))
        # 地面模型：燃烧里的神器掉在地上是"发光宝箱"（作者那套 Chest_*.mdx），
        #   这里也给阿克蒙德之手换成传说款（配置 GROUND["hand"]，老配置没有就跳过）。
        ground = getattr(cfg, "GROUND", {}).get("hand")
        if ground:
            mods2 = [m for m in mods2 if m[0] != "ifil"]
            mods2.append(("ifil", 3, 0, 0, ground))
        # 掠夺（脚本被动）的说明：写进物品的扩展提示/描述里（plunder_enable = 0 就不写）
        common = getattr(cfg, "COMMON", {})
        if int(common.get("plunder_enable", 0) or 0) > 0:
            # 数值按《西方世界的劫难6》的公式：非英雄 base+等级*per_lv(+随机)，英雄同款更大。
            line = ("|n|cffffcc00掠夺|r：击杀敌方单位时掠夺金币（目标等级越高越多；"
                    "生命 ≥ %d 的才算）。" % int(common.get("plunder_min_hp", 500)))
            for i, (mid, t, lv, col, val) in enumerate(mods2):
                if mid in ("utub", "ides") and t == 3 and isinstance(val, str):
                    mods2[i] = (mid, t, lv, col, val + line)
        # 重击（我们自己生成的那条，不在模板里）：加进物品的技能列表 + 写一行说明。
        #   技能本体由 gen_wing.py 生成（基对象 AHbh），这里只负责"挂上去"和文案。
        bash = getattr(cfg, "HAND", {}).get("bash")
        chance = int(common.get("hand_bash_chance", 0) or 0)
        if bash and chance > 0:
            dmg = int(common.get("hand_bash_damage", 600))
            line = ("|n|cffffcc00重击|r：攻击时 %d%% 概率造成 %d 点额外伤害并眩晕。" % (chance, dmg))
            for i, (mid, t, lv, col, val) in enumerate(mods2):
                if mid == "iabi" and t == 3 and isinstance(val, str):
                    if bash not in val:
                        mods2[i] = (mid, t, lv, col, (val + "," + bash) if val else bash)
                elif mid in ("utub", "ides") and t == 3 and isinstance(val, str):
                    mods2[i] = (mid, t, lv, col, val + line)
        tooltip = getattr(cfg, "HAND_ITEM_TOOLTIP", "")
        description = getattr(cfg, "HAND_ITEM_DESCRIPTION", "")
        item_name = getattr(cfg, "HAND_ITEM_NAME", "")
        for i, (mid, t, lv, col, val) in enumerate(mods2):
            if mid == "utub" and t == 3 and tooltip:
                mods2[i] = (mid, t, lv, col, tooltip)
            elif mid == "ides" and t == 3 and description:
                mods2[i] = (mid, t, lv, col, description)
            elif mid == "unam" and t == 3 and item_name:
                mods2[i] = (mid, t, lv, col, item_name)
        soul_line = ""
        if int(common.get("hand_soul_gain", 1) or 0) > 0:
            elite_chance = int(common.get("hand_soul_elite_chance", 25))
            min_level = int(common.get("hand_soul_min_level", 8))
            min_hp = int(common.get("hand_soul_min_hp", 2000))
            soul_line = (
                ITEM_PASSIVE_COLOR + "夺魂：死亡之指击杀英雄时永久 +1 智力；"
                "击杀等级≥%d或生命≥%d的非英雄强敌有%d%%概率永久 +1 智力。|r"
                % (min_level, min_hp, elite_chance)
            )
        skill_line = ITEM_ACTIVE_COLOR + "装备后获得技能：死亡之指（F）。|r"
        for i, (mid, t, lv, col, val) in enumerate(mods2):
            if mid in ("utub", "ides") and t == 3 and isinstance(val, str):
                mods2[i] = (
                    mid, t, lv, col,
                    _canonical_hand_text(
                        val, skill_line, soul_line, mid == "utub"
                    ),
                )
        out_cust.append((old, new2, mods2))
    write_entries(out_w3t, ver, orig, out_cust)

    # --- 技能 ---
    ver, orig, cust = read_entries(TEMPLATE_W3A)
    out_cust = []
    for old, new, mods in cust:
        if new == TPL_FINGER:
            # 死亡之指现在由 gen_wing.py 按配置**重新生成**（底子换成 Channel，
            #   带"物理/万能法术"标记 + 多档冷却/耗魔），模板里这条 Chain Lightning
            #   版本直接丢掉，免得同一个 ID 出现两份。
            continue
        new2 = mapping.get(new, new)
        mods2 = []
        for mid, t, lv, col, val in mods:
            if t == 3 and isinstance(val, str) and val in mapping:
                val = mapping[val]
            mods2.append((mid, t, lv, col, val))
        if new == TPL_AURA:
            # 光环的 buff 换成**自定义** buff（底子 BEar = 原版强击光环的 buff）：
            #   玩家要求"独立的新光环，不影响原有光环"—— 原版 BEar 一个字段都不碰。
            mods2 = [m for m in mods2 if m[0] != "abuf"]
            mods2.append(("abuf", 3, 1, 0, cfg.BUFFS["akmond"]))
        out_cust.append((old, new2, mods2))
    write_entries(out_w3a, ver, orig, out_cust)

    print("阿克蒙德之手: 物品 %s, 死亡之指 %s, 光环 %s, 攻速 %s, 暴击 %s"
          % (hand["item"], hand["finger"], hand["aura"], hand["speed"], hand["crit"]))
    return mapping


def main():
    out_w3t = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "_hand_reid.w3t")
    out_w3a = sys.argv[2] if len(sys.argv) > 2 else os.path.join(HERE, "_lt_hand_reid.w3a")
    build(out_w3t, out_w3a)
    print("wrote %s / %s" % (out_w3t, out_w3a))


if __name__ == "__main__":
    main()
