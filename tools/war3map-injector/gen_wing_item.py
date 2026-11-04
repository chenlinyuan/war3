"""生成翅膀/坐骑物品 (war3map.w3t)。

翅膀 = 物品 + 技能列表(本体挂模型 + 全部属性技能, 直接列出不用魔法书)
坐骑 = 物品(蛋) + 技能(把坐骑模型挂到英雄身上)

CRITICAL: 物品的 iabi 技能列表必须直接列出所有技能 (不要用魔法书包裹,
          否则魔法书里的物品技能不会被动生效)。

用法:
    python gen_wing_item.py <输出w3t>
"""
import struct, sys, os

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
CFG = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))   # 移植到别的图时可用 WINGS_CONFIG=<别的配置模块名>
_C = CFG.COMMON


def pct(v):
    """0.2 -> "20"（面向玩家的百分比数字，% 号由调用处补）"""
    return "%g" % (float(v) * 100)

# 物品 ID / 技能 ID —— 全部从 wings_config.py 取（移植时用 pick_ids.py 自动挑空闲 ID）
WING_ITEM_FALLEN = CFG.ITEMS["wing_fallen"]
WING_ITEM_SERAPH = CFG.ITEMS["wing_seraph"]
WING_ITEM_DEMON = CFG.ITEMS["wing_demon"]
WING_ITEM_STAR = CFG.ITEMS["wing_star"]
MOUNT_EGG_PHOENIX = CFG.ITEMS["egg_phoenix"]
MOUNT_EGG_BLUE = CFG.ITEMS["egg_blue"]
MOUNT_EGG_BLACK = CFG.ITEMS["egg_black"]
MOUNT_EGG_RED = CFG.ITEMS["egg_red"]
MOUNT_EGG_BRONZE = CFG.ITEMS["egg_bronze"]
MOUNT_OFF_PHOENIX = CFG.ITEMS["off_phoenix"]
MOUNT_OFF_BLUE = CFG.ITEMS["off_blue"]
MOUNT_OFF_BLACK = CFG.ITEMS["off_black"]
MOUNT_OFF_RED = CFG.ITEMS["off_red"]
MOUNT_OFF_BRONZE = CFG.ITEMS["off_bronze"]
MOUNT_DISMOUNT = CFG.ABIL["dismount"]

ICON_FALLEN = CFG.ICONS["fallen"]
ICON_SERAPH = CFG.ICONS["seraph"]
ICON_DEMON = CFG.ICONS["demon"]
ICON_STAR = CFG.ICONS["star"]
ICON_EGG = CFG.ICONS["egg"]

# 翅膀技能列表 (本体 + 全部属性, 直接列出)
# ⚠⚠ 物品的技能列表有**数量上限**(原版最多 4 个), 超出不生效。
#     所以物品里只放 3 个: 主动技能 + 移动速度+100 + 翅膀模型。
#     其余(2 个光环 + 被动)装在"隐藏魔法书"里, 由脚本加到英雄身上并隐藏
#     (见 f.j 的 WG_WingSync) —— 既不占技能栏, 也不受物品上限影响。
#     模型/加速是"物品技能", 挂在物品上才生效; 书里的必须是"单位技能"。
# ⚠ 主动技能必须在 iabi 里(物品图标才会显示冷却转圈)。
WING_ABILS_FALLEN = ",".join(CFG.wing_by_key("fallen")["iabi"])
# 炽天使之翼: 群体传送 / +100速 / 模型
#   治疗光环(W074) 曾经试过放在这里(第 4 个), 结果 buff 探针 治疗=0(没挂上) →
#   第七轮挪回魔法书 W081(那里辉煌光环已验证会挂 buff)。见 gen_wing.py 说明。
WING_ABILS_SERAPH = ",".join(CFG.wing_by_key("seraph")["iabi"])
WING_ABILS_DEMON = ",".join(CFG.wing_by_key("demon")["iabi"])
# 星魂之力: 主动(全图闪烁) + 本体(模型挂件 + 生命上限 +1000)。
#   全属性/魔法在"隐藏魔法书"里, 所以物品技能列表只有 2 个（上限 4）。
WING_ABILS_STAR = ",".join(CFG.wing_by_key("star")["iabi"])

TREASURE = "Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl"
WING_HEADER_ARTIFACT = "|cffff8c00神器|r|n|n"
WING_HEADER_RELIC = "|cffff8c00魔器|r|n|n"
WING_PASSIVE = "|cff5ddf26"
WING_ACTIVE = "|cff66ccff"


def wing_passive(text):
    if text.endswith("|n"):
        text = text[:-2]
    return WING_PASSIVE + text + "|r|n"


def wing_active(text):
    return WING_ACTIVE + text + "|r"


def ground_of(key):
    """该翅膀的**地面模型**（掉在地上时显示的那个）。

    燃烧之怒里的神器掉地上会发光（作者那套 `Chest_*.mdx`），玩家反馈"这才符合神器的名头"，
    所以配置里加了 GROUND 映射。老配置（其它图）没有 GROUND → 退回原版宝箱。
    """
    return getattr(CFG, "GROUND", {}).get(key, TREASURE)


def mod(mid, t, val):
    """w3t mod: modId(4) + type(4) + value + endMarker(4)。"""
    return (mid, t, val, 0)


def write_mod(m):
    mid, t, val, end = m
    out = mid.encode("latin-1") + struct.pack("<i", t)
    if t == 0:
        out += struct.pack("<i", val)
    elif t in (1, 2):
        out += struct.pack("<f", val)
    elif t == 3:
        out += val.encode("utf-8") + b"\x00"
    out += struct.pack("<i", end)
    return out


def write_entry(old_id, new_id, mods):
    out = old_id.encode("latin-1") + new_id.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        out += write_mod(m)
    return out


def item_entry(new_id, name, tip, ubertip, desc, icon, abilities,
               base_id="gcel", level=8, gold=1000, hp=75, class_="Artifact",
               usable=False, hotkey="", cooldown_id=None, ground=TREASURE):
    mods = [
        mod("unam", 3, name),
        mod("utip", 3, tip),
        mod("utub", 3, ubertip),
        mod("ides", 3, desc),
        mod("iico", 3, icon),
        mod("icla", 3, class_),
        mod("ilev", 0, level),
        mod("igol", 0, gold),
        mod("ihtp", 0, hp),
        mod("iabi", 3, abilities),
        mod("ifil", 3, ground),
    ]
    if hotkey:
        mods.append(mod("ihot", 3, hotkey))
    if usable:
        # iusa=1: 物品可主动使用 (点击使用)
        mods.append(mod("iusa", 0, 1))
    if cooldown_id:
        # icid: 唯一冷却组 ID, 避免不同物品共享冷却
        mods.append(mod("icid", 3, cooldown_id))
    return (base_id, new_id, mods)


def build(out_path):
    entries = []

    # === 翅膀 ===
    #   文案层级与三神器一致：
    #     橙色类别 -> 白色基础数值 -> 绿色被动/光环 -> 浅蓝主动。
    #   数值全部从 CFG.COMMON 读取，避免技能数据改了而物品说明没跟上。
    aura_radius = int(_C["aura_radius"])

    # 堕落天使之翼：生存与吸血。
    fallen_tip = (
        WING_HEADER_RELIC
        + "移动速度 +100|n"
        + wing_passive("闪避 30%。|n")
        + wing_passive(
            f"邪恶光环：{aura_radius} 范围内友军移动速度 +20%、"
            "每秒回复 30 生命。|n"
        )
        + wing_passive(
            f"吸血光环：{aura_radius} 范围内友军普通攻击吸血 +40%。|n"
        )
        + wing_active(
            f"主动·暗影庇护：{int(_C['act_invul_dur'])} 秒内免疫所有伤害；"
            f"冷却 {int(_C['act_invul_cd'])} 秒。"
        )
    )
    fallen_desc = (
        "移动速度 +100。|n"
        + wing_passive("闪避 30%。|n")
        + wing_passive("邪恶光环：友军移动速度 +20%，每秒回复 30 生命。|n")
        + wing_passive("吸血光环：友军普通攻击吸血 +40%。|n")
        + wing_active(
            f"主动·暗影庇护：{int(_C['act_invul_dur'])} 秒内免疫伤害；"
            f"冷却 {int(_C['act_invul_cd'])} 秒。"
        )
    )
    entries.append(item_entry(
        WING_ITEM_FALLEN,
        "|cffCC33FF堕落天使之翼|r", "堕落天使之翼",
        fallen_tip, fallen_desc,
        ICON_FALLEN, WING_ABILS_FALLEN, usable=True, hotkey="D", cooldown_id="wgf1",
        ground=ground_of("fallen"),
    ))
    # 炽天使之翼：团队辅助与重生。
    seraph_tip = (
        WING_HEADER_ARTIFACT
        + "移动速度 +100|n"
        + wing_passive(
            f"重生：阵亡 {int(_C['rebirth_delay'])} 秒后自动复活；"
            f"冷却 {int(_C['rebirth_cd'])} 秒。|n"
        )
        + wing_passive(
            f"辉煌光环：{aura_radius} 范围内友军魔法恢复 +300%。|n"
        )
        + wing_passive(
            f"治疗光环：{aura_radius} 范围内友军每秒回复最大生命 3%。|n"
        )
        + wing_active(
            f"主动·群体传送：自身与 {aura_radius} 范围内最多 24 个友军"
            "传送到目标友军或建筑旁；冷却 15 秒，不耗魔。"
        )
    )
    seraph_desc = (
        "移动速度 +100。|n"
        + wing_passive(
            f"重生：阵亡 {int(_C['rebirth_delay'])} 秒后自动复活；"
            f"冷却 {int(_C['rebirth_cd'])} 秒。|n"
        )
        + wing_passive("辉煌光环：友军魔法恢复 +300%。|n")
        + wing_passive("治疗光环：友军每秒回复最大生命 3%。|n")
        + wing_active(
            "主动·群体传送：自身与附近最多 24 个友军传送到目标友军或建筑旁；"
            "冷却 15 秒，不耗魔。"
        )
    )
    entries.append(item_entry(
        WING_ITEM_SERAPH,
        "|cffFFFF00天|cffFFAA55使|cffFF55AA之|cffFF00FF翼|r", "炽天使之翼",
        seraph_tip, seraph_desc,
        ICON_SERAPH, WING_ABILS_SERAPH, usable=True, hotkey="T", cooldown_id="wgs1",
        ground=ground_of("seraph"),
    ))
    # 恶魔之翼：输出与机动。
    demon_tip = (
        WING_HEADER_RELIC
        + "移动速度 +100|n"
        + wing_passive("致命一击：35% 概率造成 3 倍伤害。|n")
        + wing_passive(
            f"命令光环：{aura_radius} 范围内友军攻击力 +50%，"
            "近战与远程均生效。|n"
        )
        + wing_passive(
            f"耐久光环：{aura_radius} 范围内友军攻击速度 +40%。|n"
        )
        + wing_active(
            f"主动·闪烁：最远 {int(_C['act_blink_range'])} 码；"
            f"冷却 {int(_C['act_blink_cd'])} 秒。"
        )
    )
    demon_desc = (
        "移动速度 +100。|n"
        + wing_passive("致命一击：35% 概率造成 3 倍伤害。|n")
        + wing_passive("命令光环：友军攻击力 +50%。|n")
        + wing_passive("耐久光环：友军攻击速度 +40%。|n")
        + wing_active(
            f"主动·闪烁：最远 {int(_C['act_blink_range'])} 码；"
            f"冷却 {int(_C['act_blink_cd'])} 秒。"
        )
    )
    entries.append(item_entry(
        WING_ITEM_DEMON,
        "|cff3E3E3E恶|cff696969魔|cff959595之|cffC0C0C0翼|r", "恶魔之翼",
        demon_tip, demon_desc,
        ICON_DEMON, WING_ABILS_DEMON, usable=True, hotkey="B", cooldown_id="wgd1",
        ground=ground_of("demon"),
    ))
    # 星魂之力：最大移速、献祭与灰烬雷暴。
    #   物品浮窗高度有限，主动效果压成两行短句；数值全部从 COMMON 读取。
    star_tip = (
        WING_HEADER_ARTIFACT
        + "移动速度：最大|n"
        + wing_passive(
            "献祭：300 范围内敌人每 0.5 秒受到最高属性×0.5 魔法伤害。|n"
        )
        + wing_active(
            f"主动·灰烬雷暴：对 {int(_C['ash_radius'])} 范围内敌人造成 "
            f"{int(_C['ash_damage'])}+最高属性×{_C['ash_stat_mult']:g} 魔法伤害"
            f"并减速 8 秒，自身回复 {int(_C['ash_heal'])}+"
            f"最高属性×{_C['ash_heal_stat_mult']:g} 生命。|n"
        )
        + wing_active(
            f"1 秒后追加 {int(_C['ash_wave_count'])} 段落雷，"
            f"每段 {int(_C['ash_wave_damage'])}+最高属性；"
            f"冷却 {int(_C['ash_cd'])} 秒，耗魔 {int(_C['ash_mana'])}。"
        )
    )
    star_desc = (
        "移动速度：最大。|n"
        + wing_passive("献祭：敌人每 0.5 秒受到最高属性×0.5 魔法伤害。|n")
        + wing_active(
            "主动·灰烬雷暴：范围伤害并减速，随后追加 3 段落雷；"
            f"冷却 {int(_C['ash_cd'])} 秒，耗魔 {int(_C['ash_mana'])}。"
        )
    )
    entries.append(item_entry(
        WING_ITEM_STAR,
        "|cff66CCFF星魂之力|r", "星魂之力",
        star_tip, star_desc,
        # 图标用原版"火焰风衣"的图标（橙红色，和火焰翅膀一致）
        r"ReplaceableTextures\CommandButtons\BTNCloakOfFlames.blp",
        WING_ABILS_STAR, usable=True, hotkey="S", cooldown_id="wgst1",
        ground=ground_of("star"), class_="",
    ))

    # === 坐骑蛋 / 骑乘中物品 ===
    #   ⚠ 只在配置里有坐骑（CFG.MOUNTS 非空）时生成 —— 2026-10-15 起"移植默认不带坐骑"。
    if CFG.MOUNTS:
        # 坐骑蛋 (iabi = 使用技能 W060-W063, 主动可点击)
        mount_eggs = [
            (MOUNT_EGG_PHOENIX, "|cffFF8800火凤凰蛋|r", "火凤凰", "W060", "mge1"),
            (MOUNT_EGG_BLUE, "|cff00CCFF蓝龙蛋|r", "蓝龙", "W061", "mge2"),
            (MOUNT_EGG_BLACK, "|cff808080黑龙蛋|r", "黑龙", "W062", "mge3"),
            (MOUNT_EGG_RED, "|cffFF3333红龙蛋|r", "红龙", "W063", "mge4"),
            (MOUNT_EGG_BRONZE, "|cffCD7F32青铜龙蛋|r", "青铜龙", "W064", "mge5"),
        ]
        for iid, name, mname, abil, cid in mount_eggs:
            entries.append(item_entry(
                iid, name,
                "使用后骑乘 " + mname + "；骑乘中再使用即取消骑乘",
                "使用后骑乘 " + mname + "。|n再次使用同一个蛋 = 取消骑乘；|n"
                "使用别的坐骑蛋 = 直接换坐骑；|n丢掉这个蛋 = 自动取消骑乘。|n"
                "（蛋不会被消耗，一直留在背包里）",
                "使用后骑乘 " + mname + "；骑乘中再使用即取消骑乘",
                ICON_EGG, abil, class_="Purchasable",
                usable=True, hotkey="R", cooldown_id=cid,
            ))

        # 骑乘中物品 (iabi = 取消骑乘技能 W050)
        #   点它 -> 取消骑乘并变回坐骑蛋; 丢掉它 -> 脚本自动取消骑乘 (WG_OnDropItem)
        mount_offs = [
            (MOUNT_OFF_PHOENIX, "|cffFF8800骑乘中(火凤凰)|r", "火凤凰", "mgo1"),
            (MOUNT_OFF_BLUE, "|cff00CCFF骑乘中(蓝龙)|r", "蓝龙", "mgo2"),
            (MOUNT_OFF_BLACK, "|cff808080骑乘中(黑龙)|r", "黑龙", "mgo3"),
            (MOUNT_OFF_RED, "|cffFF3333骑乘中(红龙)|r", "红龙", "mgo4"),
            (MOUNT_OFF_BRONZE, "|cffCD7F32骑乘中(青铜龙)|r", "青铜龙", "mgo5"),
        ]
        for iid, name, mname, cid in mount_offs:
            entries.append(item_entry(
                iid, name,
                "点击取消骑乘 " + mname + "（丢掉也会自动取消）",
                "点击取消骑乘 " + mname + "，变回坐骑蛋；直接丢掉也会自动取消骑乘",
                "点击取消骑乘 " + mname,
                ICON_EGG, MOUNT_DISMOUNT, class_="Purchasable",
                usable=True, hotkey="R", cooldown_id=cid,
            ))

    # === 「试穿」用翅膀（只挂模型 + 移速 +90；用来挑外观，不带光环） ===
    for _t in getattr(CFG, "TEST_WINGS", []):
        spd = int(CFG.COMMON.get("wing_speed_test_bonus", 90))
        entries.append(item_entry(
            _t["item"], _t["name"], _t["name"],
            "试穿用：只挂翅膀模型 + 移动速度 %d，不带任何光环。" % spd,
            "试穿用：只挂翅膀模型 + 移动速度 %d。" % spd,
            _t["icon"], ",".join(_t["iabi"]), class_="Purchasable",
        ))

    # === 「装备挂件」试穿（只挂模型，没属性；用来给装备挑外观） ===
    for _a in getattr(CFG, "TEST_ARTS", []):
        entries.append(item_entry(
            _a["item"], _a["name"], _a["name"],
            "试穿用：只把模型挂到 %s 挂点，不带任何属性。" % _a.get("attach", "chest"),
            "试穿用：只挂模型（%s 挂点）。" % _a.get("attach", "chest"),
            _a["icon"], ",".join(_a["iabi"]), class_="Purchasable",
        ))

    # === 改原版物品：只加一条挂载技能，原有技能保留（见 wings_config.ITEM_OVERRIDES）===
    orig_entries = []
    for _o in getattr(CFG, "ITEM_OVERRIDES", []):
        mods = [mod("iabi", 3, _o["iabi"])]
        orig_entries.append((_o["old_id"], "\x00\x00\x00\x00", mods))

    data = struct.pack("<ii", 2, len(orig_entries))
    for old, new, mods in orig_entries:
        data += write_entry(old, new, mods)
    data += struct.pack("<i", len(entries))
    for old, new, mods in entries:
        data += write_entry(old, new, mods)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes, %d items" % (out_path, len(data), len(entries)))
    for old, new, mods in entries:
        print("   %s <- %s" % (new, old))


if __name__ == "__main__":
    out = os.path.join(HERE, "_wing_item.w3t")
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if args:
        out = args[0]
    build(out)
