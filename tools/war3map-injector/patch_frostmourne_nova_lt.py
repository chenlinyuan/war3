# -*- coding: utf-8 -*-
"""Build the simplified Frostmourne LT test map."""

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))

import mpq_patch  # noqa: E402
import objparse  # noqa: E402
import war3mpq  # noqa: E402
import gen_frostmourne_lt as FROST_OBJECT  # noqa: E402


SOURCE_MAP = ROOT / "maps" / "LostTemple" / "LostTemple_heroes.w3x"
OUTPUT_MAP = ROOT / "maps" / "LostTemple" / "LostTemple_heroes_frostnova.w3x"
SOURCE_ABILITY = ROOT / "heroes" / "frostmourne" / "ability.w3a"
SOURCE_ITEM = ROOT / "heroes" / "frostmourne" / "item.w3t"
SOURCE_SCRIPT_DIR = ROOT / "scripts" / "frostmourne"

NOVA_ID = "A170"
NOVA_BASE = "AUfn"
NOVA_ICON = r"ReplaceableTextures\CommandButtons\BTNFrostNova.blp"
REMOVED_SOUL_IDS = {"A%d" % value for value in range(130, 142)}

ITEM_UBERTIP = (
    "|cffff8c00神器|r|n|n"
    "攻击力 +30，攻击速度 +50%，魔法恢复 +100%。|n"
    "|cff5ddf26霜冻新星：普通攻击有 30% 概率触发，250 范围内造成 100 点伤害，"
    "主目标额外受到 50 点伤害，并减速 4 秒。|r|n"
    "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
    "|cff66ccff装备后获得技能：冰封践踏（D）。|r|n|n"
    "巫妖王的低语。一柄吞噬灵魂的长剑。"
)
ITEM_DESCRIPTION = (
    "攻击力 +30，攻击速度 +50%，魔法恢复 +100%。|n"
    "|cff5ddf26霜冻新星：普通攻击有 30% 概率造成范围伤害与减速。|r|n"
    "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
    "|cff66ccff装备后获得技能：冰封践踏（D）。|r|n|n"
    "巫妖王的低语。一柄吞噬灵魂的长剑。"
)
ACTIVE_TOOLTIP = (
    "对 550 范围内地面与空中敌人造成 100 + 4×力量 的伤害。|n"
    "普通单位冰冻 5 秒，英雄冰冻 3 秒。|n"
    "|cff9d5cff消耗当前生命 20%，不会致死。|r"
)


def find_entry(entries, entry_id):
    found = [entry for entry in entries if entry["new"] == entry_id]
    if len(found) != 1:
        raise RuntimeError("expected one %s entry, found %d" % (entry_id, len(found)))
    return found[0]


def set_mod(entry, field_id, value):
    found = False
    for mod in entry["mods"]:
        if mod[0] == field_id:
            mod[4] = value
            found = True
    if not found:
        raise RuntimeError("%s.%s is missing" % (entry["new"], field_id))


def nova_mods():
    return [
        ["anam", 3, 0, 0, "霜之哀伤·霜冻新星"],
        ["aart", 3, 0, 0, NOVA_ICON],
        ["arar", 3, 0, 0, NOVA_ICON],
        ["alev", 0, 0, 0, 1],
        ["aite", 0, 0, 0, 0],
        ["aher", 0, 0, 0, 0],
        ["acdn", 2, 1, 0, 0.0],
        ["amcs", 0, 1, 0, 0],
        ["aare", 2, 1, 0, 250.0],
        ["Ufn1", 2, 1, 1, 50.0],
        ["Ufn2", 2, 1, 2, 100.0],
        ["atar", 3, 1, 0, "ground,air,organic,enemy,neutral"],
        ["adur", 2, 1, 0, 4.0],
        ["ahdu", 2, 1, 0, 4.0],
    ]


def patch_ability_data(data):
    version, original, custom = objparse.read_bytes(data, "w3a")
    custom = [entry for entry in custom if entry["new"] not in REMOVED_SOUL_IDS]

    nova = [entry for entry in custom if entry["new"] == NOVA_ID]
    if not nova:
        custom.append({"old": NOVA_BASE, "new": NOVA_ID, "mods": nova_mods()})
    else:
        nova = nova[0]
        nova["old"] = NOVA_BASE
        nova["mods"] = nova_mods()

    regen = find_entry(custom, "A109")
    set_mod(regen, "Imrp", 1.0)

    active = find_entry(custom, "A105")
    replacement = FROST_OBJECT.spell_entry()
    active["old"] = replacement["old"]
    active["mods"] = replacement["mods"]

    updated = objparse.build_bytes(version, original, custom, "w3a")
    assert_ability(updated)
    return updated


def assert_ability(data):
    _version, _original, custom = objparse.read_bytes(data, "w3a")
    if any(entry["new"] in REMOVED_SOUL_IDS for entry in custom):
        raise RuntimeError("obsolete soul-burden abilities remain")

    nova = find_entry(custom, NOVA_ID)
    if nova["old"] != NOVA_BASE:
        raise RuntimeError("%s has the wrong base" % NOVA_ID)
    mods = {item[0]: item[4] for item in nova["mods"]}
    expected = {
        "amcs": 0,
        "acdn": 0.0,
        "aare": 250.0,
        "Ufn1": 50.0,
        "Ufn2": 100.0,
    }
    for field_id, value in expected.items():
        if abs(float(mods[field_id]) - float(value)) > 0.0001:
            raise RuntimeError("%s.%s is %r, expected %r" %
                               (NOVA_ID, field_id, mods[field_id], value))

    regen = find_entry(custom, "A109")
    regen_mods = {item[0]: item[4] for item in regen["mods"]}
    if abs(float(regen_mods["Imrp"]) - 1.0) > 0.0001:
        raise RuntimeError("A109.Imrp must be 1.0")

    active = find_entry(custom, "A105")
    active_mods = {item[0]: item[4] for item in active["mods"]}
    if active["old"] != "ANcl":
        raise RuntimeError("A105 must use the instant Channel base")
    if active_mods["aub1"] != ACTIVE_TOOLTIP:
        raise RuntimeError("A105 does not have the final structured tooltip")
    if active_mods.get("atp1") != "冰封践踏":
        raise RuntimeError("A105 title must not duplicate the hotkey")
    if int(active_mods.get("aite", 1)) != 0:
        raise RuntimeError("A105 must be a hero ability")
    if active_mods.get("ahky") != "D" or active_mods.get("arhk") != "D":
        raise RuntimeError("A105 hotkey must be D")
    if active_mods.get("aord") != "froststomp":
        raise RuntimeError("A105 Profile order must be froststomp")
    if active_mods.get("Ncl6") != "froststomp":
        raise RuntimeError("A105 Channel order must be froststomp")
    if active_mods.get("Ncl2") != 0:
        raise RuntimeError("A105 must be an instant no-target skill")
    if active_mods.get("aani") != "stand":
        raise RuntimeError("A105 must suppress the Channel animation")


def patch_item_data(data):
    version, original, custom = objparse.read_bytes(data, "w3t")
    target = find_entry(custom, "I105")
    set_mod(target, "utub", ITEM_UBERTIP)
    set_mod(target, "ides", ITEM_DESCRIPTION)
    set_mod(target, "iabi", "A106,A108,A109")
    set_mod(target, "iusa", 0)
    set_mod(target, "icid", "")
    updated = objparse.build_bytes(version, original, custom, "w3t")
    assert_item(updated)
    return updated


def assert_item(data):
    _version, _original, custom = objparse.read_bytes(data, "w3t")
    target = find_entry(custom, "I105")
    mods = {item[0]: item[4] for item in target["mods"]}
    if mods.get("iabi") != "A106,A108,A109":
        raise RuntimeError("I105 must contain passives only")
    if int(mods.get("iusa", 1)) != 0:
        raise RuntimeError("I105 must not be an active item")
    if mods.get("icid", "") != "":
        raise RuntimeError("I105 must not own an item cooldown")
    for field_id in ("utub", "ides"):
        text = mods[field_id]
        if text != (ITEM_UBERTIP if field_id == "utub" else ITEM_DESCRIPTION):
            raise RuntimeError("I105 %s is not the final simplified text" % field_id)
        for forbidden in ("｜", "攻击减速", "生命代价", "灵魂代价", "灵魂血偿",
                          "永久失去", "+200%", "+2 倍"):
            if forbidden in text:
                raise RuntimeError("I105 %s still contains %s" % (field_id, forbidden))
        required = [
            "攻击力 +30，攻击速度 +50%，魔法恢复 +100%",
            "冰封践踏", "不会致死",
            "100 + 4×力量", "霜冻新星", "30% 概率",
            "噬魂", "5%", "50%",
        ]
        if field_id == "utub":
            required.append("生命消耗：当前生命的 20%")
        else:
            required.append("当前生命 20%（不会致死）")
        for required_text in required:
            if required_text not in text:
                raise RuntimeError("I105 %s lacks %s" % (field_id, required_text))


def source_globals():
    return (SOURCE_SCRIPT_DIR / "g.j").read_text(encoding="utf-8").rstrip("\r\n")


def source_functions():
    return (SOURCE_SCRIPT_DIR / "f.j").read_text(encoding="utf-8").rstrip("\r\n")


def patch_script(data):
    newline = b"\r\n" if b"\r\n" in data[:4096] else b"\n"
    text_newline = "\r\n" if newline == b"\r\n" else "\n"
    globals_marker = b"// Frostmourne item behavior"
    globals_start = data.find(globals_marker)
    if globals_start < 0 or data.find(globals_marker, globals_start + 1) >= 0:
        raise RuntimeError("expected one Frostmourne module start")
    globals_end = data.find(b"endglobals", globals_start)
    if globals_end < 0:
        raise RuntimeError("Frostmourne globals end not found")

    globals_text = source_globals().replace("\r\n", "\n").replace("\n", text_newline)
    globals_block = (globals_text + text_newline + "endglobals").encode("utf-8")
    updated = data[:globals_start] + globals_block + data[globals_end + len(b"endglobals"):]

    functions_start = -1
    for functions_marker in (
        b"function FR_NoOp",
        b"function FR_IsSoulTarget",
        b"function FR_HighestStat",
    ):
        functions_start = updated.find(
            functions_marker, globals_start + len(globals_block)
        )
        if functions_start >= 0:
            break
    end_marker = b"// WINGS / MOUNT SYSTEM"
    functions_end = updated.find(end_marker, functions_start)
    if functions_start < 0 or functions_end < 0:
        raise RuntimeError("Frostmourne function block boundaries not found")
    functions_text = source_functions().replace("\r\n", "\n").replace("\n", text_newline)
    functions_block = (functions_text + text_newline * 2).encode("utf-8")
    updated = updated[:functions_start] + functions_block + updated[functions_end:]
    assert_script(updated)
    return updated


def assert_script(data):
    for forbidden in (
        b"function FR_ApplySlow",
        b"function FR_SlowStep",
        b"FR_SLOW_",
        b"fr_slow_",
        b"FR_ApplySoulCost",
        b"LifeDrainTarget.mdl",
    ):
        if forbidden in data:
            raise RuntimeError("obsolete Frostmourne token remains: %r" % forbidden)
    for token in (
        b"real FR_NOVA_CHANCE = 0.30",
        b"real FR_ACTIVE_LIFE_COST = 0.20",
        b"call FR_PayActiveLife(caster)",
        b'IssueTargetOrder(dummy, "frostnova", victim)',
        b"UnitApplyTimedLife(dummy, FR_NOVA_LIFE, 1.0)",
        b"function FR_OnSoulDeath takes nothing returns nothing",
        b"real FR_SOUL_NORMAL_CHANCE = 0.05",
        b"real FR_SOUL_HERO_CHANCE = 0.50",
        b"SetHeroStr(source, GetHeroStr(source, false) + 1, true)",
        b"TriggerRegisterAnyUnitEventBJ(fr_attack_trigger, EVENT_PLAYER_UNIT_ATTACKED)",
        b"function FR_Init takes nothing returns nothing",
    ):
        if token not in data:
            raise RuntimeError("required Frostmourne token missing: %r" % token)


def main():
    SOURCE_ABILITY.write_bytes(patch_ability_data(SOURCE_ABILITY.read_bytes()))
    SOURCE_ITEM.write_bytes(patch_item_data(SOURCE_ITEM.read_bytes()))

    archive = war3mpq.MPQArchive(str(SOURCE_MAP))
    try:
        w3a = archive.read_file("war3map.w3a")
        w3t = archive.read_file("war3map.w3t")
        script = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not w3a or not w3t or not script:
        raise RuntimeError("LT is missing object data or war3map.j")

    patches = [
        ("war3map.w3a", patch_ability_data(w3a)),
        ("war3map.w3t", patch_item_data(w3t)),
        ("war3map.j", patch_script(script)),
    ]
    mpq_patch.patch(
        str(SOURCE_MAP), patches, out_path=str(OUTPUT_MAP), backup=False
    )

    check = war3mpq.MPQArchive(str(OUTPUT_MAP))
    try:
        for internal, expected in patches:
            if check.read_file(internal) != expected:
                raise RuntimeError("read-back mismatch: %s" % internal)
        assert_ability(check.read_file("war3map.w3a"))
        assert_item(check.read_file("war3map.w3t"))
        assert_script(check.read_file("war3map.j"))
    finally:
        check.close()
    print("verified", OUTPUT_MAP)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
