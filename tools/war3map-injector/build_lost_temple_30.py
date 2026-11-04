"""Build the 3.0 Lost Temple test map with the Blademaster talent matrix."""

from pathlib import Path
import re
import struct
import sys
import tempfile

import objparse as O
import war3mpq as W


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"))
from doctor.data import w3i as W3I  # noqa: E402

SOURCE = ROOT / "maps" / "LostTemple" / "LostTemple_heroes.w3x"
BASE = ROOT / "maps" / "port" / "lost_temple_30" / "base" / "LostTempleLV_fixed.w3x"
OUT = ROOT / "maps" / "port" / "lost_temple_30" / "build"

ICON = "ReplaceableTextures\\CommandButtons\\"
PASSIVE = "ReplaceableTextures\\PassiveButtons\\"


def mod(mid, value, typ=None, level=0, column=0):
    if typ is None:
        if isinstance(value, str):
            typ = O.T_STRING
        elif isinstance(value, float):
            typ = O.T_REAL
        else:
            typ = O.T_INT
    return [mid, typ, level, column, value]


def ability(old, new, name, icon, tip, uber, effect_mods=()):
    mods = [
        mod("anam", name),
        mod("aart", icon),
        mod("arar", icon),
        mod("atp1", tip),
        mod("aub1", uber),
        mod("alev", 1),
        mod("aite", 0),
        mod("aher", 0),
    ]
    mods.extend(effect_mods)
    return {"old": old, "new": new, "mods": mods}


def dummy_talent(old, new, name, icon, tip, uber):
    return ability(old, new, name, icon, tip, uber, (mod("Imvb", 0),))


def read_custom(path, ext):
    archive = W.MPQArchive(str(path))
    try:
        data = archive.read_file("war3map." + ext)
    finally:
        archive.close()
    if not data:
        raise SystemExit("missing war3map." + ext)
    temp = Path(tempfile.gettempdir()) / ("_lt30_source." + ext)
    temp.write_bytes(data)
    return O.read_file(str(temp))


def write_object(path, version, orig, custom, ext):
    path.write_bytes(O.build_bytes(version, orig, custom, ext))


def strip_legacy_hotkeys(entries):
    hotkey = re.compile(r"\(\|cffffcc00[A-Za-z0-9]\|r\)")
    colored_level = re.compile(r"\[\|cffffcc00等级 ([0-9]+)\|r\]")
    for entry in entries:
        for item in entry["mods"]:
            if item[1] == O.T_STRING:
                value = colored_level.sub(r"[等级 \1]", item[4])
                item[4] = hotkey.sub("", value)


def find_entry(entries, new_id):
    for entry in entries:
        if entry["new"] == new_id:
            return entry
    raise SystemExit("missing object " + new_id)


def set_string(entry, field, value):
    for item in entry["mods"]:
        if item[0] == field:
            item[1] = O.T_STRING
            item[4] = value
            return
    entry["mods"].append(mod(field, value))


def remove_mod(entry, field):
    entry["mods"] = [item for item in entry["mods"] if item[0] != field]


def main():
    OUT.mkdir(parents=True, exist_ok=True)

    _av, _ao, abilities = read_custom(SOURCE, "w3a")
    _uv, _uo, units = read_custom(SOURCE, "w3u")
    _hv, _ho, buffs = read_custom(SOURCE, "w3h")
    _tv, _to, source_items = read_custom(SOURCE, "w3t")

    choices = [
        dummy_talent("AIms", "BT00", "断空", ICON + "BTNWindWalkOn.blp",
                     "断空", "疾风跳砍施法距离提高至 1000，附加伤害提高 50%。"),
        dummy_talent("AIms", "BT01", "裂空", ICON + "BTNThunderClap.blp",
                     "裂空", "疾风跳砍命中后，对目标周围 250 码敌人造成本次附加伤害 50% 的伤害。"),
        dummy_talent("AIms", "BT02", "踏影", ICON + "BTNBootsOfSpeed.blp",
                     "踏影", "疾风跳砍命中后 4 秒内移动速度提高 15%，攻击速度提高 15%。"),
        dummy_talent("AIms", "BT03", "双生", ICON + "BTNMirrorImage.blp",
                     "双生", "双重镜像额外生成一个镜像。"),
        dummy_talent("AIms", "BT04", "镜返", PASSIVE + "PASBTNEvasion.blp",
                     "镜返", "释放双重镜像后获得 4 秒 25% 闪避。"),
        ability("AIrm", "BT05", "镜心", ICON + "BTNSobiMask.blp",
                "镜心", "永久提高 2 点/秒魔法恢复速度。", (mod("Imrp", 2.0),)),
        ability("AIas", "BT06", "锐意", ICON + "BTNBootsOfSpeed.blp",
                "锐意", "永久提高 15% 攻击速度。", (mod("Isx1", 0.15),)),
        ability("AIaa", "BT07", "重斩", ICON + "BTNSteelMelee.blp",
                "重斩", "永久提高 25 点攻击力。", (mod("Iaa1", 25),)),
        ability("AIar", "BT08", "破军", ICON + "BTNHumanArmorUpOne.blp",
                "破军", "永久提高 3 点护甲。", (mod("Ear1", 3.0),)),
        dummy_talent("AIms", "BT09", "风暴领主", ICON + "BTNWhirlwind.blp",
                     "风暴领主", "闪电剑刃持续 12 秒，每拍剑刃数量由 5 个提高到 6 个。"),
        dummy_talent("AIms", "BT0A", "雷霆万钧", ICON + "BTNBM30.blp",
                     "雷霆万钧", "闪电冲刺伤害由 1500 提高到 2250，范围由 300 提高到 400。"),
        ability("AIms", "BT0B", "雷鸣战体", ICON + "BTNOrbOfLightning.blp",
                "雷鸣战体", "永久提高 10% 移动速度。", (mod("Imvb", 10),)),
    ]

    effects = [
        ability("AIms", "BTE0", "踏影加速", ICON + "BTNBootsOfSpeed.blp",
                "踏影加速", "移动速度提高 15%。", (mod("Imvb", 15),)),
        ability("AIas", "BTE1", "踏影战意", ICON + "BTNBootsOfSpeed.blp",
                "踏影战意", "攻击速度提高 15%。", (mod("Isx1", 0.15),)),
        ability("AEev", "BTE2", "镜返", PASSIVE + "PASBTNEvasion.blp",
                "镜返", "闪避率提高 25%。", (mod("Eev1", 0.25),)),
    ]

    master = {
        "old": "ATal",
        "new": "BTal",
        "mods": [
            mod("anam", "剑圣天赋"),
            mod("aart", ICON + "BTNTomeRed.blp"),
            mod("atp1", "剑圣天赋"),
            mod("aub1", "选择追风、镜像、致命和雷鸣四条天赋路线。"),
            mod("alev", 4),
            mod("aite", 0),
            mod("aher", 0),
            mod("aabi", "BT00,BT01,BT02", level=1),
            mod("aabi", "BT03,BT04,BT05", level=2),
            mod("aabi", "BT06,BT07,BT08", level=3),
            mod("aabi", "BT09,BT0A,BT0B", level=4),
        ],
    }

    hero = find_entry(units, "H0B1")
    uabi = next((item[4] for item in hero["mods"] if item[0] == "uabi"), "")
    set_string(hero, "uabi", "A0B6,AInv")

    abilities.extend(choices)
    abilities.extend(effects)
    abilities.append(master)
    strip_legacy_hotkeys(abilities)

    backpack = {
        "old": "ratc",
        "new": "B30B",
        "mods": [
            mod("unam", "英雄装备背包"),
            mod("utip", "英雄装备背包"),
            mod("utub", "打开后可查看 30 格背包、装备栏和属性面板。"),
            mod("iabi", "AIni,AEqu,ASde"),
            mod("icid", "AIni"),
            mod("iico", "ReplaceableTextures\\CommandButtons\\BTNbackpack.blp"),
            mod("icla", "Campaign"),
            mod("ilev", 0),
            mod("igol", 0),
            mod("ihtp", 75),
            mod("iusa", 1),
            mod("idro", 0),
            mod("ipaw", 0),
        ],
    }
    items = []
    for item_entry in source_items:
        if item_entry["new"] in ("I000", "I105"):
            remove_mod(item_entry, "ides")
            items.append(item_entry)
    if {entry["new"] for entry in items} != {"I000", "I105"}:
        raise SystemExit("missing Akhand or Frostmourne item data")
    items.append(backpack)

    write_object(OUT / "war3map.w3a", 2, [], abilities, "w3a")
    write_object(OUT / "war3map.w3u", 2, [], units, "w3u")
    write_object(OUT / "war3map.w3h", 2, [], buffs, "w3h")
    write_object(OUT / "war3map.w3t", 2, [], items, "w3t")

    base_archive = W.MPQArchive(str(BASE))
    try:
        imp = base_archive.read_file("war3map.imp")
        w3i_data = base_archive.read_file("war3map.w3i")
    finally:
        base_archive.close()
    info = W3I.parse(w3i_data)
    info["game_data_set"] = 2
    info["game_data_version"] = 2
    (OUT / "war3map.w3i").write_bytes(W3I.write(info))
    version, count = struct.unpack_from("<ii", imp, 0)
    pos = 8
    imports = []
    for _ in range(count):
        end = imp.index(0, pos + 1)
        imports.append((imp[pos], imp[pos + 1:end]))
        pos = end + 1
    for path in (
        b"ReplaceableTextures/CommandButtons/BTNBM30.blp",
        b"ReplaceableTextures/CommandButtonsDisabled/DISBTNBM30.blp",
        b"ReplaceableTextures/CommandButtons/BTNArchimondeHand_30HD.blp",
        b"ReplaceableTextures/CommandButtonsDisabled/DISBTNArchimondeHand_30HD.blp",
        b"ReplaceableTextures/CommandButtons/BTNFrostmourne_30HD.blp",
        b"ReplaceableTextures/CommandButtonsDisabled/DISBTNFrostmourne_30HD.blp",
        b"war3campImported/Frostmourne.mdx",
        b"war3campImported/FrostArmorOnly.mdx",
        b"Frostmourne10.blp",
        b"Frostmourne100.blp",
    ):
        if not any(old_path == path for _mark, old_path in imports):
            imports.append((0x0D, path))
    rebuilt_imp = struct.pack("<ii", version, len(imports))
    for mark, path in imports:
        if len(path) > 255:
            raise SystemExit("war3map.imp path too long")
        rebuilt_imp += bytes((mark,)) + path + b"\0"
    (OUT / "war3map.imp").write_bytes(rebuilt_imp)

    archive = W.MPQArchive(str(SOURCE))
    try:
        assets = OUT / "assets"
        assets.mkdir(exist_ok=True)
        for internal in (
            "ReplaceableTextures\\CommandButtons\\BTNBM30.blp",
            "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNBM30.blp",
            "ReplaceableTextures\\CommandButtons\\BTNArchimondeHand_30HD.blp",
            "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNArchimondeHand_30HD.blp",
            "ReplaceableTextures\\CommandButtons\\BTNFrostmourne_30HD.blp",
            "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNFrostmourne_30HD.blp",
            "war3campImported\\Frostmourne.mdx",
            "Frostmourne10.blp",
            "Frostmourne100.blp",
        ):
            data = archive.read_file(internal)
            if not data:
                raise SystemExit("missing icon " + internal)
            target = assets / internal.rsplit("\\", 1)[-1]
            target.write_bytes(data)
    finally:
        archive.close()
    frost_aura = ROOT / "maps" / "port" / "frostmourne_lt" / "FrostArmorOnly.mdx"
    if not frost_aura.is_file():
        raise SystemExit("missing FrostArmorOnly.mdx")
    (OUT / "assets" / "FrostArmorOnly.mdx").write_bytes(frost_aura.read_bytes())

    print("wrote", OUT)
    print("abilities:", len(abilities), "units:", len(units), "buffs:", len(buffs), "items:", len(items))
    print("H0B1 abilities:", uabi)


if __name__ == "__main__":
    main()
