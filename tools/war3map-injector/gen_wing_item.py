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

# 物品 ID
WING_ITEM_FALLEN = "I100"   # 堕落天使之翼 (魔器)
WING_ITEM_SERAPH = "I101"   # 炽天使之翼 (神器)
WING_ITEM_DEMON = "I102"    # 恶魔之翼 (魔器)
MOUNT_EGG_PHOENIX = "I110"  # 火凤凰蛋
MOUNT_EGG_BLUE = "I111"     # 蓝龙蛋
MOUNT_EGG_BLACK = "I112"    # 黑龙蛋
MOUNT_EGG_RED = "I113"      # 红龙蛋
MOUNT_EGG_BRONZE = "I114"   # 青铜龙蛋
# 取消骑乘物品: 使用蛋后蛋变成它, 点它取消骑乘; 丢掉它也会自动取消骑乘(脚本处理)
MOUNT_OFF_PHOENIX = "I120"
MOUNT_OFF_BLUE = "I121"
MOUNT_OFF_BLACK = "I122"
MOUNT_OFF_RED = "I123"
MOUNT_OFF_BRONZE = "I124"
# 取消骑乘技能 (放在"骑乘中物品"的 iabi)
MOUNT_DISMOUNT = "W050"

ICON_FALLEN = "ReplaceableTextures\\CommandButtons\\BTNEnchantedCrows.blp"
ICON_SERAPH = "ReplaceableTextures\\CommandButtons\\BTNSirenMaster.blp"
ICON_DEMON = "ReplaceableTextures\\CommandButtons\\BTNStoneForm.blp"
ICON_EGG = "ReplaceableTextures\\CommandButtons\\BTNThunderLizardEgg.blp"

# 翅膀技能列表 (本体 + 全部属性, 直接列出)
# ⚠⚠ 物品的技能列表有**数量上限**(原版最多 4 个), 超出不生效。
#     所以物品里只放 3 个: 主动技能 + 移动速度+100 + 翅膀模型。
#     其余(2 个光环 + 被动)装在"隐藏魔法书"里, 由脚本加到英雄身上并隐藏
#     (见 f.j 的 WG_WingSync) —— 既不占技能栏, 也不受物品上限影响。
#     模型/加速是"物品技能", 挂在物品上才生效; 书里的必须是"单位技能"。
# ⚠ 主动技能必须在 iabi 里(物品图标才会显示冷却转圈)。
WING_ABILS_FALLEN = "W022,W002,W000"   # 暗影庇护 / +100速 / 模型(书: W080)
# 炽天使之翼: 群体传送 / +100速 / 模型
#   治疗光环(W074) 曾经试过放在这里(第 4 个), 结果 buff 探针 治疗=0(没挂上) →
#   第七轮挪回魔法书 W081(那里辉煌光环已验证会挂 buff)。见 gen_wing.py 说明。
WING_ABILS_SERAPH = "W023,W002,W020"   # 群体传送 / +100速 / 模型(书: W081)
WING_ABILS_DEMON = "W024,W002,W021"    # 闪烁     / +100速 / 模型(书: W082)

TREASURE = "Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl"


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
               usable=False, hotkey="", cooldown_id=None):
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
        mod("ifil", 3, TREASURE),
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

    # === 翅膀 (三件各有定位; 属性全部是百分比, 数值见 gen_wing.py) ===
    #   堕落天使之翼: 生存 (生命上限%/每秒回%/魔法减伤/4 秒无敌)
    fallen_tip = ("|cffFF3300堕落天使之翼(魔器)|r|n|cffFFE79B|n"
                  "移动速度 +100|n闪避 30%|n"
                  "邪恶光环: 附近友军 移动速度 +20%、每秒回复生命 30|n"
                  "吸血光环: 附近友军 吸血 +40%|n"
                  "主动(点物品使用): 暗影庇护 —— 6 秒无敌，冷却 50 秒")
    entries.append(item_entry(
        WING_ITEM_FALLEN,
        "|cffCC33FF堕落天使之翼|r", "堕落天使之翼",
        fallen_tip, fallen_tip,
        ICON_FALLEN, WING_ABILS_FALLEN, usable=True, hotkey="D", cooldown_id="wgf1",
    ))
    #   炽天使之翼: 团队辅助 (附近友军 移速/攻速/回蓝 + 群体传送)
    seraph_tip = ("|cffFF3300炽天使之翼(神器)|r|n|cffFFE79B|n"
                  "移动速度 +100|n重生: 阵亡 3 秒后自动复活（冷却 150 秒，骑乘时坐骑保留）|n"
                  "辉煌光环: 附近友军 魔法恢复 +300%|n"
                  "治疗光环: 附近友军 每秒回复最大生命 3%|n"
                  "主动(点物品使用): 群体传送 —— 自身与周围 700 友军一起传送，冷却 60 秒")
    entries.append(item_entry(
        WING_ITEM_SERAPH,
        "|cffFFFF00天|cffFFAA55使|cffFF55AA之|cffFF00FF翼|r", "炽天使之翼",
        seraph_tip, seraph_tip,
        ICON_SERAPH, WING_ABILS_SERAPH, usable=True, hotkey="T", cooldown_id="wgs1",
    ))
    #   恶魔之翼: 输出与机动 (攻击力 +30%、攻速 +50% + 闪烁)
    demon_tip = ("|cffFF3300恶魔之翼(魔器)|r|n|cffFFE79B|n"
                 "移动速度 +100|n致命一击 35% × 3 倍伤害|n"
                 "命令光环: 附近友军 攻击力 +50%（近战/远程都生效）|n"
                 "耐久光环: 附近友军 攻击速度 +40%|n"
                 "主动(点物品使用): 闪烁 —— 最远 1300，冷却 12 秒")
    entries.append(item_entry(
        WING_ITEM_DEMON,
        "|cff3E3E3E恶|cff696969魔|cff959595之|cffC0C0C0翼|r", "恶魔之翼",
        demon_tip, demon_tip,
        ICON_DEMON, WING_ABILS_DEMON, usable=True, hotkey="B", cooldown_id="wgd1",
    ))

    # === 坐骑蛋 (iabi = 使用技能 W060-W063, 主动可点击) ===
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

    # === 骑乘中物品 (iabi = 取消骑乘技能 W050) ===
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

    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(entries))
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
