"""Static checks for the three artifact item/skill descriptions and freeze FX."""

from __future__ import annotations

import argparse
import importlib
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import hand_data  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import war3mpq  # noqa: E402


SKILL_ENTRY = "装备后获得技能"
PASSIVE_COLOR = "|cff5ddf26"
ACTIVE_COLOR = "|cff66ccff"
LORE_COLOR = "|cffffcc00"
MANA_AND_COOLDOWN = (
    "耗魔", "魔法消耗", "消耗 70 魔法", "消耗 100 魔法",
    "冷却 16 秒", "冷却 10 秒",
)
SCRIPT_PATHS = (
    "war3map.j",
    r"scripts\war3map.j",
    r"Scripts\war3map.j",
)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(message)


def read_map_script(archive) -> bytes:
    """Read JASS from either the legacy root path or Reforged Scripts path."""
    for name in SCRIPT_PATHS:
        script = archive.read_file(name)
        if script:
            return script
    for name in archive.files():
        normalized = name.replace("/", "\\").casefold()
        if normalized == "war3map.j" or normalized.endswith("\\war3map.j"):
            script = archive.read_file(name)
            if script:
                return script
    return b""


def named_function_blocks(script: bytes, prefix: bytes) -> bytes:
    """Return complete top-level JASS functions whose names use a prefix."""
    blocks = []
    current = []
    function_start = b"function " + prefix
    for line in script.replace(b"\r\n", b"\n").splitlines(keepends=True):
        stripped = line.lstrip()
        if not current and stripped.startswith(function_start):
            current.append(line)
            continue
        if not current:
            continue
        current.append(line)
        if stripped.startswith(b"endfunction"):
            blocks.append(b"".join(current))
            current = []
    return b"".join(blocks)


def check_lore_last(text: str, lore_marker: str, name: str) -> None:
    require(text.count(SKILL_ENTRY) == 1, name + ": skill entry count is not 1")
    require(text.rfind(LORE_COLOR + lore_marker) > text.rfind(SKILL_ENTRY),
            name + ": lore is missing its colour or is not last")


def check_effect_layout(
    text: str,
    passives: tuple[str, ...],
    name: str,
    lore_marker: str | None = None,
) -> None:
    require("|n|n|n" not in text, name + ": excessive blank lines")
    positions = []
    for label in passives:
        position = text.find(PASSIVE_COLOR + label)
        require(position >= 0, name + ": passive is missing colour: " + label)
        positions.append(position)
    require(positions == sorted(positions), name + ": passives are out of order")
    active = text.find(ACTIVE_COLOR + SKILL_ENTRY)
    require(active >= 0, name + ": granted skill is missing active colour")
    require(active > positions[-1], name + ": granted skill is before passives")
    if lore_marker:
        check_lore_last(text, lore_marker, name)


def audit_archive(
    path: Path,
    hand_id: str = "I103",
    frostmourne_id: str = "I105",
    warglaive_id: str = "I106",
    bash_id: str = "W091",
    slow_id: str = "A171",
) -> None:
    archive = war3mpq.MPQArchive(str(path))
    try:
        _version, item_entries = ITEM.read_objects(archive, "war3map.w3t", False)
        _version, ability_entries = ITEM.read_objects(
            archive, "war3map.w3a", True
        )
        script = read_map_script(archive)
    finally:
        archive.close()

    items = {
        entry[2].replace("\0", ""): entry
        for entry in item_entries
    }
    abilities = {
        entry[2].replace("\0", ""): entry
        for entry in ability_entries
    }
    for ident, lore_marker, passives in (
        (hand_id, "阿克蒙德留下的", ("重击", "掠夺", "夺魂")),
        (frostmourne_id, "巫妖王的低语", ("霜冻新星", "噬魂")),
        (warglaive_id, "这是卡多雷", (
            "攻击速度随敏捷提升", "顺劈", "邪魂淬炼",
        )),
    ):
        require(ident in items, "deployed map is missing " + ident)
        fields = {
            field_id: values
            for field_id, values in (
                (field[0], ITEM.field_values(items[ident][3], field[0]))
                for field in items[ident][3]
            )
        }
        tooltip = fields["utub"][-1]
        check_effect_layout(
            tooltip, passives, "deployed " + ident + ".utub", lore_marker
        )
        require(
            any(token in tooltip for token in MANA_AND_COOLDOWN) is False,
            "deployed " + ident + " tooltip repeats mana or cooldown",
        )

    for ident, description_ident in (
        ("A100", "Death Finger"),
        ("A105", "Frost Stomp"),
        ("A113", "Thunder Charge"),
    ):
        require(ident in abilities, "deployed map is missing " + ident)
        fields = {
            field[0]: ITEM.field_values(abilities[ident][3], field[0])
            for field in abilities[ident][3]
        }
        tooltip = fields["aub1"][-1]
        require(
            any(token in tooltip for token in MANA_AND_COOLDOWN) is False,
            description_ident + " tooltip repeats mana or cooldown",
        )
    frost_base = abilities["A105"][1].replace("\0", "")
    require(frost_base == "ANcl",
            "A105 must use the instant Channel base")
    frost_fields = {
        field[0]: ITEM.field_values(abilities["A105"][3], field[0])
        for field in abilities["A105"][3]
    }
    require(
        "消耗当前生命 20%" in frost_fields["aub1"][-1],
        "deployed Frost Stomp tooltip lost the current-life cost",
    )
    require(
        "空中单位不冰冻，但仍受伤害和减速"
        in frost_fields["aub1"][-1]
        and "地面与空中" not in frost_fields["aub1"][-1],
        "deployed Frost Stomp tooltip lost the air slow rule",
    )
    for token in ("核心 0～300", "中环 300～550", "外环 550～750"):
        require(
            token in frost_fields["aub1"][-1],
            "deployed Frost Stomp tooltip lacks " + token,
        )
    require(
        "同时附加冰缓 60%，共持续 9 秒"
        in frost_fields["aub1"][-1],
        "deployed Frost Stomp tooltip lost the simultaneous slow",
    )
    require(frost_fields.get("aord") == ["froststomp"],
            "A105 must use froststomp for its Profile order")
    require(frost_fields.get("Ncl6") == ["froststomp"],
            "A105 must use froststomp for its Channel order")
    require(frost_fields.get("Ncl2") == ["0"],
            "A105 must remain an instant no-target ability")
    require(frost_fields.get("Ncl3") == ["1"],
            "A105 must remain visible on the command card")
    require(frost_fields.get("Ncl5") == ["0"],
            "A105 must not disable other abilities")
    require(frost_fields.get("aani") == ["stand"],
            "A105 must suppress the Channel cast animation")
    require(frost_fields.get("acat") == [""],
            "A105 must not create a second native cast effect")
    charge_fields = {
        field[0]: ITEM.field_values(abilities["A113"][3], field[0])
        for field in abilities["A113"][3]
    }
    require(charge_fields.get("aord") == ["channel"]
            and charge_fields.get("Ncl6") == ["channel"],
            "A113 must explicitly remain on the channel order")
    finger_fields = {
        field[0]: ITEM.field_values(abilities["A100"][3], field[0])
        for field in abilities["A100"][3]
    }
    require(
        finger_fields.get("aart") == [
            r"ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp"
        ],
        "A100 must use the original Death Finger icon",
    )
    require(
        finger_fields.get("arar") == [
            r"ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp"
        ],
        "A100 must use the original Death Finger disabled icon",
    )
    require(bash_id in abilities, "deployed map is missing " + bash_id)
    bash_fields = {
        field[0]: ITEM.field_values(abilities[bash_id][3], field[0])
        for field in abilities[bash_id][3]
    }
    require(
        abs(float(bash_fields.get("Hbh1", ["nan"])[-1]) - 20.0) < 0.0001,
        "deployed Archimonde Hand Bash chance is not 20%",
    )
    require(slow_id in abilities, "deployed map is missing " + slow_id)
    slow_fields = {
        field[0]: ITEM.field_values(abilities[slow_id][3], field[0])
        for field in abilities[slow_id][3]
    }
    require(
        abilities[slow_id][1].replace("\0", "") == "Aslo",
        slow_id + " must use the Slow base",
    )
    require(
        slow_fields.get("abuf") == ["Bfro", "Bfro", "Bfro"],
        slow_id + " must use the Frost Nova buff",
    )
    for field_id, values in (
        ("Slo1", (0.8, 0.6, 0.4)),
        ("adur", (3.0, 6.0, 9.0)),
    ):
        actual = [float(value) for value in slow_fields.get(field_id, [])]
        require(
            len(actual) == len(values)
            and all(abs(a - b) < 0.0001 for a, b in zip(actual, values)),
            slow_id + "." + field_id + " levels are incorrect",
        )
    require(b"FreezingBreathTargetArt.mdl" in script,
            "deployed map is missing the legacy freeze FX")
    require(b"function FR_CreateFreezeFx takes" in script,
            "deployed freeze FX creation is missing")
    require(b'AddSpecialEffectTarget("Abilities\\\\Spells\\\\Undead\\\\FreezingBreath\\\\FreezingBreathTargetArt.mdl", u, "origin")' in script,
            "deployed unit freeze FX is missing")
    require(b"SaveEffectHandle(fr_freeze_table, unitKey, 1, fx)" in script,
            "deployed freeze FX is not keyed")
    require(b"function FR_DestroyFreezeFx takes" in script,
            "deployed freeze FX cleanup is missing")
    require(b"DestroyEffect(fx)" in script,
            "deployed freeze FX is not destroyed")
    require(
        b"call FR_FreezeUnit(target, freeze_duration)" in script,
        "deployed spell does not freeze ground units",
    )
    require(
        b"call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)"
        in script,
        "deployed spell does not apply the Frost Nova slow immediately",
    )
    require(
        b"if IsUnitType(target, UNIT_TYPE_FLYING) then" in script,
        "deployed Frost Stomp does not exclude flying units",
    )
    require(b"call TriggerSleepAction(0.05)" in script,
            "deployed spell lost the requested script delay")
    require(b"set bonus = 100.0 + " in script,
            "deployed spell lost the fixed 100 damage")
    require(b"if FR_IsInvulnerable(target) then" in script,
            "deployed spell does not exclude invulnerable targets")
    frostmourne_functions = named_function_blocks(script, b"FR_")
    require(bool(frostmourne_functions),
            "deployed Frostmourne functions are missing")
    require(b"EVENT_PLAYER_UNIT_ISSUED_ORDER" not in frostmourne_functions,
            "deployed Frostmourne spell still double-processes its issued order")
    require(b"EVENT_PLAYER_UNIT_SPELL_CAST" in script,
            "deployed spell is missing its cast event")
    require(b"EVENT_PLAYER_UNIT_SPELL_EFFECT" in script,
            "deployed spell is missing its effect-event fallback")
    require(b'SetUnitAnimation(caster, "stand")' in script,
            "deployed spell still plays a cast animation")
    require(b"function FR_OnStompCast takes" in script,
            "deployed spell is missing its cast-event fallback")
    require(b"fr_cast_guard_table" in script,
            "deployed spell is missing its duplicate-cast guard")
    require(b"real FR_CAST_GUARD_SECONDS = 9.5" in script,
            "deployed cast guard does not cover the full cast cycle")
    require(b'FR_ShowTimedEffect("war3campImported\\\\IceStompRaised.mdx"' in script,
            "deployed spell is missing its single scripted cast effect")
    require(b"function FR_OnHeroRevive takes" in script,
            "Frostmourne command-card resync is missing after revive")
    require(b"BlzUnitDisableAbility(u, FR_SPELL_ID, false, false)" in script,
            "Frostmourne ability is not explicitly re-enabled on equip")
    for token in (
        b"function WG_EnforceArtifactExclusivity takes",
        b"function WG_OnArtifactPickup takes",
        b"call UnitRemoveItem(u, it)",
        b"call SetItemPosition(it, x, y)",
        b"TriggerAddAction(t, function WG_OnArtifactPickup)",
        b"function IB_IsExclusiveArtifact takes",
        b"function IB_HasExclusiveArtifact takes",
        b"if IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u) then",
    ):
        require(token in script,
                "deployed map is missing artifact exclusivity token "
                + token.decode("ascii"))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--map",
        type=Path,
        help="Also audit the final map/campaign object data and script.",
    )
    parser.add_argument("--hand-id", default="I103")
    parser.add_argument("--frostmourne-id", default="I105")
    parser.add_argument("--warglaive-id", default="I106")
    parser.add_argument("--bash-id", default="W091")
    parser.add_argument("--slow-id", default="A171")
    args = parser.parse_args()
    config = importlib.import_module("wings_config_offline_template")
    config_names = (
        "wings_config_arthas_lich",
        "wings_config_alas_durotar_rpg",
        "wings_config_D",
        "wings_config_fate2",
        "wings_config_ortiz_old_days",
    )
    soul = PASSIVE_COLOR + "夺魂：测试。|r"
    soul_marker = PASSIVE_COLOR + "夺魂："
    skill = ACTIVE_COLOR + "装备后获得技能：死亡之指（F）。|r"
    hand_tooltip = hand_data._canonical_hand_text(
        config.HAND_ITEM_TOOLTIP, skill, soul, True
    )
    hand_description = hand_data._canonical_hand_text(
        config.HAND_ITEM_DESCRIPTION, skill, soul, False
    )
    for text, name in (
        (hand_tooltip, "Archimonde Hand.utub"),
        (hand_description, "Archimonde Hand.ides"),
    ):
        require(text.count(SKILL_ENTRY) == 1, name + ": skill entry is duplicated")
        require(text.count(soul_marker) == 1,
                name + ": soul passive count is not 1")
        require(text.rfind(soul_marker) < text.rfind(SKILL_ENTRY),
                name + ": soul passive is not before skill entry")
        require("冷却和耗魔" not in text, name + ": active cost remains")
        require("对英雄造成" not in text, name + ": active damage remains")
    check_effect_layout(
        hand_tooltip, ("重击", "掠夺", "夺魂"),
        "Archimonde Hand.utub", "阿克蒙德留下的",
    )
    with tempfile.TemporaryDirectory() as temp_dir:
        item_path = Path(temp_dir) / "hand.w3t"
        ability_path = Path(temp_dir) / "hand.w3a"
        hand_data.build(str(item_path), str(ability_path), config)
        _version, _orig, custom = hand_data.read_entries(str(item_path))
        entry = next(
            item for item in custom if item[1].replace("\0", "") == config.HAND["item"]
        )
        fields = {
            field_id: value
            for field_id, _value_type, _level, _column, value in entry[2]
        }
        generated = fields["utub"]
        require(generated.count(SKILL_ENTRY) == 1,
                "generated I103 tooltip has duplicate skill entries")
        require(generated.count(soul_marker) == 1,
                "generated I103 tooltip soul passive count is not 1")
        check_effect_layout(
            generated, ("重击", "掠夺", "夺魂"),
            "generated I103.utub", "阿克蒙德留下的",
        )
    for config_name in config_names:
        candidate = importlib.import_module(config_name)
        tooltip = hand_data._canonical_hand_text(
            candidate.HAND_ITEM_TOOLTIP, skill, soul, True
        )
        require(tooltip.count(SKILL_ENTRY) == 1,
                config_name + ": skill entry is duplicated")
        require(tooltip.count(soul_marker) == 1,
                config_name + ": soul passive count is not 1")
        require(tooltip.rfind(soul_marker) < tooltip.rfind(SKILL_ENTRY),
                config_name + ": soul passive is not before skill entry")
        check_effect_layout(
            tooltip, ("重击", "掠夺", "夺魂"),
            config_name, "阿克蒙德",
        )

    check_effect_layout(
        ITEM.WARGLAIVE_ITEM_TOOLTIP,
        ("攻击速度随敏捷提升", "顺劈", "邪魂淬炼"),
        "Warglaive.utub", "这是卡多雷",
    )
    require(
        any(token in ITEM.WARGLAIVE_ITEM_TOOLTIP
            for token in MANA_AND_COOLDOWN) is False,
        "I106 tooltip still repeats active mana or cooldown",
    )
    check_effect_layout(
        ITEM.FROSTMOURNE_ITEM_TOOLTIP,
        ("霜冻新星", "噬魂"),
        "Frostmourne.utub", "巫妖王的低语",
    )
    require(
        any(token in ITEM.FROSTMOURNE_ITEM_TOOLTIP
            for token in MANA_AND_COOLDOWN) is False,
        "I105 tooltip still repeats active mana or cooldown",
    )
    require(
        any(token in ITEM.WARGLAIVE_CHARGE_DESCRIPTION
            for token in MANA_AND_COOLDOWN) is False,
        "A113 tooltip still repeats mana or cooldown",
    )
    require(
        any(token in ITEM.FROSTMOURNE_ACTIVE_TOOLTIP
            for token in MANA_AND_COOLDOWN) is False,
        "A105 tooltip still repeats mana or cooldown",
    )
    require(
        "消耗当前生命 20%" in ITEM.FROSTMOURNE_ACTIVE_TOOLTIP,
        "A105 tooltip lost the current-life cost",
    )
    require(
        "空中单位不冰冻，但仍受伤害和减速"
        in ITEM.FROSTMOURNE_ACTIVE_TOOLTIP
        and "同时附加冰缓 60%，共持续 9 秒"
        in ITEM.FROSTMOURNE_ACTIVE_TOOLTIP
        and "地面与空中" not in ITEM.FROSTMOURNE_ACTIVE_TOOLTIP,
        "A105 tooltip lost the air slow rule",
    )
    require(
        int(config.COMMON.get("hand_bash_chance", 0)) == 20,
        "Archimonde Hand Bash chance is not 20%",
    )

    frost_script = (
        (ROOT / "scripts" / "frostmourne" / "g.j").read_text(
            encoding="utf-8"
        )
        + "\n"
        + (ROOT / "scripts" / "frostmourne" / "f.j").read_text(
            encoding="utf-8"
        )
    )
    wings_script = (ROOT / "scripts" / "wings" / "f.j").read_text(
        encoding="utf-8"
    )
    browser_builder = (
        ROOT / "tools" / "war3map-injector" / "build_fj.py"
    ).read_text(encoding="utf-8")
    require("FreezingBreathTargetArt.mdl" in frost_script,
            "legacy freeze FX is missing")
    require(
        'AddSpecialEffectTarget("Abilities\\\\Spells\\\\Undead\\\\FreezingBreath\\\\FreezingBreathTargetArt.mdl", u, "origin")'
        in frost_script,
        "unit freeze FX is missing",
    )
    require("SaveEffectHandle(fr_freeze_table, unitKey, 1, fx)"
            in frost_script,
            "freeze FX is not keyed by the freeze owner")
    require("function FR_DestroyFreezeFx takes" in frost_script
            and "DestroyEffect(fx)" in frost_script,
            "freeze FX is not cleaned up")
    require(
        "call FR_FreezeUnit(target, freeze_duration)" in frost_script,
            "spell does not freeze ground units")
    require(
        "call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)"
        in frost_script,
        "spell does not apply the Frost Nova slow immediately",
    )
    require("if IsUnitType(target, UNIT_TYPE_FLYING) then"
            in frost_script,
            "spell does not exclude flying units")
    for token in (
        "function FR_IsAliveTarget takes",
        "GetWidgetLife(u) <= 0.405",
        "not IsUnitType(u, UNIT_TYPE_DEAD)",
        "function FR_ApplySlow takes",
        "SetUnitAbilityLevel(dummy, FR_SLOW_ABILITY, level)",
        'IssueTargetOrder(dummy, "slow", target)',
        "function FR_OnFrozenDeath takes",
        "call PauseUnit(u, false)",
        "call SetUnitTimeScale(u, 1.0)",
        "call DestroyTimer(t)",
        "real FR_RING_CORE_RADIUS = 300.0",
        "real FR_RING_MID_RADIUS = 550.0",
        "real FR_FREEZE_CORE = 6.0",
        "real FR_FREEZE_MID = 4.0",
        "real FR_FREEZE_OUTER = 2.0",
        "real FR_SLOW_CORE = 3.0",
        "real FR_SLOW_MID = 2.0",
        "real FR_SLOW_OUTER = 1.0",
        "real FR_DAMAGE_CORE_MULT = 1.0",
        "real FR_DAMAGE_MID_MULT = 0.7",
        "real FR_DAMAGE_OUTER_MULT = 0.4",
    ):
        require(token in frost_script, "freeze runtime token is missing: " + token)
    require("if FR_IsInvulnerable(target) then" in frost_script
            and "BlzIsUnitInvulnerable(u)" in frost_script,
            "invulnerable targets are not excluded")
    require("EVENT_PLAYER_UNIT_ISSUED_ORDER" not in frost_script,
            "spell still double-processes its issued order")
    require("EVENT_PLAYER_UNIT_SPELL_CAST" in frost_script,
            "spell is missing its cast event")
    require("EVENT_PLAYER_UNIT_SPELL_EFFECT" in frost_script,
            "spell is missing its effect-event fallback")
    require('SetUnitAnimation(caster, "stand")' in frost_script,
            "spell still plays a cast animation")
    require("function FR_OnStompCast takes" in frost_script,
            "spell is missing its cast-event fallback")
    require("fr_cast_guard_table" in frost_script,
            "spell is missing its duplicate-cast guard")
    require("TimerGetElapsed(fr_clock) + FR_CAST_GUARD_SECONDS"
            in frost_script,
            "cast guard does not cover the full cast cycle")
    require(
        'FR_ShowTimedEffect("war3campImported\\\\IceStompRaised.mdx"'
        in frost_script,
        "spell is missing its single scripted cast effect",
    )
    require("call TriggerSleepAction(0.05)" in frost_script,
            "spell lost the requested script delay")
    require("set bonus = 100.0 + " in frost_script,
            "spell lost the fixed 100 damage")
    require("function FR_OnHeroRevive takes" in frost_script,
            "Frostmourne revive resync is missing")
    require("BlzUnitDisableAbility(u, FR_SPELL_ID, false, false)" in frost_script,
            "Frostmourne ability is not explicitly re-enabled on equip")
    for token in (
        "function WG_IsExclusiveArtifact takes",
        "function WG_HasOtherExclusiveArtifact takes",
        "function WG_UnitCarriesItem takes",
        "function WG_EnforceArtifactExclusivity takes",
        "function WG_OnArtifactPickup takes",
        "call UnitRemoveItem(u, it)",
        "call SetItemPosition(it, x, y)",
        "TriggerAddAction(t, function WG_OnArtifactPickup)",
    ):
        require(token in wings_script,
                "artifact exclusivity is missing source token " + token)
    for token in (
        "function IB_IsExclusiveArtifact takes",
        "function IB_HasExclusiveArtifact takes",
        "if IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u) then",
    ):
        require(token in browser_builder,
                "additem precheck is missing build token " + token)
    require("BlzUnitDisableAbility(caster, FR_SPELL_ID, true, false)"
            not in frost_script,
            "Frostmourne cast path must not disable its own command-card ability")
    if args.map:
        audit_archive(
            args.map.resolve(),
            args.hand_id,
            args.frostmourne_id,
            args.warglaive_id,
            args.bash_id,
            args.slow_id,
        )
        print("deployed map item/skill copy and freeze FX checks passed")
    print("item/skill copy and freeze FX checks passed")


if __name__ == "__main__":
    main()
