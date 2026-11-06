#!/usr/bin/env python3
"""Static audit for an ALAS Reforged Lua campaign release."""

from __future__ import annotations

import argparse
import importlib
import os
import re
import struct
import sys
import tempfile
from pathlib import Path

WORKSPACE = Path(
    os.environ.get(
        "ALAS_WORKSPACE",
        r"C:\Users\Administrator\Desktop\工作项目\Work\war3",
    )
)
INJECTOR = WORKSPACE / "tools" / "war3map-injector"
DOCTOR = (
    WORKSPACE / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
)
sys.path[:0] = [str(INJECTOR), str(DOCTOR)]

import war3mpq as W  # noqa: E402
from doctor.data import campaign_info  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from wing_copy_contract import (  # noqa: E402
    DEFAULT_WING_IDS,
    wing_copy_failures,
)

ITEMS = {"I100", "I101", "I102", "I103", "I104", "I105", "I106"}
ABILITIES = {
    "A100", "A101", "A102", "A105", "A106", "A108", "A109",
    "A110", "A111", "A113", "A116", "A117", "A118",
    "A170", "A171", "W091",
}
ASSETS = (
    "war3campImported\\Frostmourne.mdx",
    "war3campImported\\DemonBoltImpactSilent.mdx",
    "war3campImported\\IceStompRaised.mdx",
    "war3campImported\\Rune-Blue-Aura_Raised20.mdx",
    "WingOfTheLucifer.MDX",
    "FWIND.MDX",
    "DoomgGuardWings.mdx",
    "anchibang0100.mdx",
    "Chest_Legendary.mdx",
    "ReplaceableTextures\\CommandButtons\\BTNDemonicWarglaives.blp",
    "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNDemonicWarglaives.blp",
    "ReplaceableTextures\\CommandButtons\\BTNGarrekCharge.blp",
    "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNGarrekCharge.blp",
)
WARGLAIVE_ICON = (
    "ReplaceableTextures\\CommandButtons\\BTNDemonicWarglaives.blp"
)
CHARGE_ICON = "ReplaceableTextures\\CommandButtons\\BTNGarrekCharge.blp"
PASSIVE_COLOR = "|cff5ddf26"
ACTIVE_COLOR = "|cff66ccff"
LORE_COLOR = "|cffffcc00"
SKILL_ENTRY = "装备后获得技能"


def artifact_copy_failures(
    text: str,
    passives: tuple[str, ...],
    lore_marker: str,
    label: str,
) -> list[str]:
    failures = []
    if text.count(SKILL_ENTRY) != 1:
        failures.append(f"{label}: equip-skill entry count is not 1")
    positions = []
    for passive in passives:
        position = text.find(PASSIVE_COLOR + passive)
        if position < 0:
            failures.append(f"{label}: passive colour/order missing {passive}")
        positions.append(position)
    if positions != sorted(positions):
        failures.append(f"{label}: passive order is inconsistent")
    active = text.find(ACTIVE_COLOR + SKILL_ENTRY)
    if active < 0:
        failures.append(f"{label}: equip-skill entry lacks active colour")
    elif positions and active < positions[-1]:
        failures.append(f"{label}: equip-skill entry is before passives")
    if text.find(LORE_COLOR + lore_marker) < active:
        failures.append(f"{label}: lore colour/order is inconsistent")
    return failures


def archive_title(archive: W.MPQArchive) -> str:
    data = archive.read_file("war3campaign.w3f") or b""
    if len(data) < 12:
        return "<missing>"
    end = data.find(b"\0", 12)
    return data[12:end].decode("utf-8", "replace") if end >= 0 else "<invalid>"


def object_ids(data: bytes, with_levels: bool, label: str) -> set[str]:
    _version, entries, consumed = OBJ.read_objects_bytes(
        data, with_levels, fname=label, with_end=True
    )
    if consumed != len(data):
        raise RuntimeError(f"{label}: trailing bytes")
    return {
        new.replace("\0", "")
        for _table, _old, new, _mods in entries
        if new.replace("\0", "")
    }


def object_fields(
    data: bytes, with_levels: bool, label: str
) -> dict[str, dict[str, str]]:
    _version, entries, consumed = OBJ.read_objects_bytes(
        data, with_levels, fname=label, with_end=True
    )
    if consumed != len(data):
        raise RuntimeError(f"{label}: trailing bytes")
    result = {}
    for _table, _old, new, mods in entries:
        ident = new.replace("\0", "")
        if not ident:
            continue
        result[ident] = {
            mod[0]: (
                mod[4].decode("utf-8", "replace")
                if isinstance(mod[4], bytes)
                else str(mod[4])
            )
            for mod in mods
        }
    return result


def object_entries(data: bytes, with_levels: bool, label: str):
    _version, entries, consumed = OBJ.read_objects_bytes(
        data, with_levels, fname=label, with_end=True
    )
    if consumed != len(data):
        raise RuntimeError(f"{label}: trailing bytes")
    return entries


def level_values(
    entries, ident: str, field_id: str
) -> dict[int, object]:
    for _table, _old, new, mods in entries:
        if new.replace("\0", "") != ident:
            continue
        return {
            mod[2]: mod[4]
            for mod in mods
            if mod[0] == field_id
        }
    return {}


def lua_runtime_failures(name: str, script: str) -> list[str]:
    failures = []
    required = (
        "function WG_OnRangedVamp()",
        "function FR_OnSoulDeath()",
        "function FR_CreateFreezeFx(",
        "function FR_DestroyFreezeFx(",
        "function FR_OnStompCast()",
        "function FR_OnHeroRevive()",
        "function WGL_ShowTimedEffect(",
        "function WGL_OnCharge(",
        "function WGL_OnChargeOrder()",
        "function WGL_ChargeTick()",
        "function WGL_FinishCharge(",
        "function WGL_AddChargeStack(",
        "function WGL_StackTick()",
        "function WGL_OnGrowthAttack()",
        "function WGL_SyncAttackSpeed(",
        "function WGL_SyncUnit(",
        "function WG_IsFingerSoulTarget(",
        "function WG_FingerSoulChance(",
        "function WG_IsExclusiveArtifact(",
        "function WG_HasOtherExclusiveArtifact(",
        "function WG_UnitCarriesItem(",
        "function WG_EnforceArtifactExclusivity(",
        "function WG_OnArtifactPickup()",
        "function IB_IsExclusiveArtifact(",
        "function IB_HasExclusiveArtifact(",
    )
    for token in required:
        if token not in script:
            failures.append(f"{name}: missing Lua runtime {token!r}")

    required_text = (
        "FR_SOUL_NORMAL_CHANCE = 0.05",
        "FR_SOUL_HERO_CHANCE = 0.50",
        "FR_CAST_GUARD_SECONDS = 9.5",
        "WGL_CHARGE_BASE_DISTANCE = 100.0",
        "WGL_CHARGE_AGI_MULT = 10.0",
        "WGL_CHARGE_MAX_DISTANCE = 2000.0",
        "WGL_CHARGE_STEP = 50.0",
        "WGL_CHARGE_INTERVAL = 0.05",
        "WGL_CHARGE_RADIUS = 150.0",
        "WGL_CHARGE_COOLDOWN = 16.0",
        "WGL_GROWTH_CHANCE_PERCENT = 2",
        "WG_PLUNDER_ENABLE = 1",
        "FreezingBreathTargetArt.mdl",
        "war3campImported\\\\IceStompRaised.mdx",
        "StormfallRed.mdx",
        "war3campImported\\\\DemonBoltImpactSilent.mdx",
        "Abilities\\\\Spells\\\\Human\\\\ThunderClap\\\\ThunderClapCaster.wav",
        "EVENT_PLAYER_UNIT_SPELL_CAST",
        "EVENT_PLAYER_UNIT_SPELL_EFFECT",
        "EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER",
        "EVENT_PLAYER_HERO_LEVEL",
        "EVENT_PLAYER_UNIT_DAMAGED",
        "BlzGetEventIsAttack()",
        "GetIssuedOrderId() == OrderId(\"channel\")",
        "IssueImmediateOrder(caster, \"stop\")",
        "SetUnitAnimation(caster, \"attack slam\")",
        "SetUnitAnimation(caster, \"stand\")",
        "SetUnitPathing(caster, false)",
        "SetUnitPathing(caster, true)",
        "PauseUnit(caster, true)",
        "PauseUnit(caster, false)",
        "SetHeroAgi(attacker",
        "SetHeroStr(source",
        "SetHeroInt(caster",
        "BlzGetUnitAbilityCooldownRemaining(u, FR_SPELL_ID)",
        "UnitAddAbility(u, FR_SPELL_ID)",
        "UnitRemoveAbility(u, FR_SPELL_ID)",
        "BlzGetUnitAbilityCooldownRemaining(u, 1093742899)",
        "UnitAddAbility(u, 1093742899)",
        "UnitRemoveAbility(u, 1093742899)",
        "BlzUnitHideAbility(u, 1093742903, true)",
        "BlzUnitHideAbility(u, 1093742904, true)",
        "IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u)",
        "IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u)) then",
        "__alasInitTimer",
        '__alasRunInit("WGL", WGL_Init)',
        "DisplayTextToPlayer(Player(0), 0, 0,",
        "FR_Init()",
        "WGL_Init()",
    )
    for token in required_text:
        if token not in script:
            failures.append(f"{name}: missing Lua runtime text {token!r}")

    obsolete = (
        "function WGL_OnChargeStart",
        "function WGL_ChargeTrailTick",
        "WGL_TRAIL_INTERVAL",
        "BatteringRam.mdl",
        "BlzUnitDisableAbility(caster, FR_SPELL_ID, true, false)",
        "TriggerAddCondition(WGL_ORDER_TRIGGER, Condition(",
        "宸插姞杞?(wing/mount)",
        "m.j 宸叉墽琛?",
        "[闇滀箣鍝€浼|r 宸插姞杞?",
    )
    for token in obsolete:
        if token in script:
            failures.append(f"{name}: obsolete Lua token {token!r}")
    add_start = script.find("function IB_AddGive")
    add_end = script.find("function IB_AddStep", add_start)
    if add_start < 0 or add_end < 0:
        failures.append(f"{name}: item browser add path is missing")
    elif "WGL_SyncUnit(u)" not in script[add_start:add_end]:
        failures.append(
            f"{name}: item browser add path does not sync the Warglaive"
        )
    if script.count("local addedWarglaive = false") != 1:
        failures.append(
            f"{name}: item browser Warglaive sync local is not unique"
        )
    pickup_start = script.find("function WG_OnArtifactPickup()")
    pickup_end = script.find("function ", pickup_start + 1)
    if (
        pickup_start < 0
        or pickup_end < 0
        or "UnitAddAbility(u, 1093742899)"
        not in script[pickup_start:pickup_end]
    ):
        failures.append(
            f"{name}: artifact pickup does not add the Warglaive ability"
        )
    return failures


def audit(path: Path, config_name: str | None = None) -> int:
    item_active = os.environ.get(
        "ALAS_EQUIPMENT_MODE", "command"
    ).strip().lower() == "item"
    expected_items = set(ITEMS)
    expected_abilities = set(ABILITIES)
    hand_item = "I103"
    hand_finger = "A100"
    hand_bash = "W091"
    frostmourne_item = "I105"
    warglaive_item = "I106"
    invul_id = "W022"
    teleport_id = "W023"
    avatar_id = "W024"
    demon_wing_item = "I102"
    avatar_duration = 45.0
    avatar_cooldown = 150.0
    avatar_mana = 100
    demon_wing = {"item": "I102", "iabi": ("W024", "W002", "W021")}
    wing_ids = dict(DEFAULT_WING_IDS)
    hand_aura = "A101"
    wing_aura_ids = {
        "W070": "B646",
        "W071": "B647",
        "W073": "B648",
        "W074": "B643",
        "W076": "B649",
        "W077": "B64A",
        "W079": "B644",
    }
    wing_aura_ability_ids = {
        "aura_unholy": "W070",
        "aura_vamp": "W071",
        "aura_brill": "W073",
        "aura_heal": "W074",
        "aura_command": "W076",
        "aura_endur": "W077",
        "aura_show": "W079",
    }
    charge_buff = "B64B"
    hand_buff = "B641"
    if config_name:
        config = importlib.import_module(config_name)
        weapons = getattr(
            config, "WEAPONS",
            {"frostmourne": "I105", "warglaive": "I106"},
        )
        hand_item = config.HAND["item"]
        hand_finger = config.HAND["finger"]
        hand_bash = config.HAND.get("bash", hand_bash)
        frostmourne_item = weapons["frostmourne"]
        warglaive_item = weapons["warglaive"]
        expected_items = {
            wing["item"] for wing in config.WINGS
        } | {hand_item, frostmourne_item, warglaive_item}
        expected_abilities = {
            "A113", "A117", "A118", "A171",
            *(config.HAND[key] for key in
              ("finger", "aura", "speed", "bash")
              if config.HAND.get(key)),
        }
        for wing in config.WINGS:
            for key in ("book", "book2", "model_abil", "active"):
                if wing.get(key):
                    expected_abilities.add(wing[key])
            expected_abilities.update(wing.get("book_abils", ()))
            expected_abilities.update(wing.get("book2_abils", ()))
        invul_id = config.ABIL["act_invul"]
        teleport_id = config.ABIL["act_tele"]
        avatar_id = config.ABIL["act_blink"]
        avatar_duration = float(
            config.COMMON["act_avatar_duration"]
        )
        avatar_cooldown = float(config.COMMON["act_avatar_cd"])
        avatar_mana = int(config.COMMON["act_avatar_mana"])
        demon_wing = next(
            wing for wing in config.WINGS if wing.get("key") == "demon"
        )
        demon_wing_item = demon_wing["item"]
        wing_ids = {
            wing["key"]: wing["item"] for wing in config.WINGS
        }
        hand_aura = config.HAND["aura"]
        wing_aura_ids = {
            config.ABIL[key]: config.BUFFS[buff_key]
            for key, buff_key in (
                ("aura_unholy", "aura_unholy"),
                ("aura_vamp", "aura_vamp"),
                ("aura_brill", "aura_brill"),
                ("aura_heal", "heal_native"),
                ("aura_command", "aura_command"),
                ("aura_endur", "aura_endur"),
                ("aura_show", "heal_show"),
            )
        }
        wing_aura_ability_ids = {
            key: config.ABIL[key]
            for key in wing_aura_ability_ids
        }
        charge_buff = config.BUFFS["warglaive_charge"]
        hand_buff = config.BUFFS["akmond"]

    outer = W.MPQArchive(str(path))
    failures = []
    try:
        title = archive_title(outer)
        chapters = sorted(
            name for name in outer.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        print("title:", title)
        print("chapters:", len(chapters))
        if not re.match(r"^\s*alas(?:\s|$)", title or "", re.I):
            failures.append(f"title {title!r} is missing the alas prefix")
        outer_attributes = outer.read_file("(attributes)")
        if outer_attributes and len(outer_attributes) >= 8:
            _version, flags = struct.unpack_from("<II", outer_attributes)
            if flags:
                failures.append(
                    "campaign (attributes) still contains stale checksums"
                )
        resolved = campaign_info.read(str(path))
        if not isinstance(resolved, dict) or resolved.get("error"):
            failures.append(f"campaign strings unresolved: {resolved!r}")
        else:
            menu_maps = resolved.get("maps") or []
            menu_files = sorted(
                str(entry.get("file", "")) for entry in menu_maps
            )
            if not menu_files:
                failures.append("campaign menu has no chapter files")
            missing_menu_files = sorted(set(menu_files) - set(chapters))
            if missing_menu_files:
                failures.append(
                    "campaign menu references missing chapters: "
                    f"{missing_menu_files}"
                )
            for entry in menu_maps:
                for field in ("chapter", "title"):
                    value = str(entry.get(field, "")).strip()
                    if not value or value.upper().startswith("TRIGSTR_"):
                        failures.append(
                            f"{entry.get('file', '?')}: unresolved {field}"
                        )

        for name in chapters:
            data = outer.read_file(name)
            if not data:
                failures.append(f"{name}: unreadable")
                continue
            fd, temp_name = tempfile.mkstemp(suffix=".w3x")
            os.close(fd)
            temp = Path(temp_name)
            try:
                temp.write_bytes(data)
                chapter = W.MPQArchive(str(temp))
                try:
                    lua_data = chapter.read_file("war3map.lua") or b""
                    jass_data = chapter.read_file("war3map.j") or b""
                    script = (lua_data or jass_data).decode(
                        "utf-8", "replace"
                    )
                    attributes = chapter.read_file("(attributes)")
                    if attributes and len(attributes) >= 8:
                        _version, flags = struct.unpack_from("<II", attributes)
                        if flags:
                            failures.append(
                                f"{name}: (attributes) still contains stale checksums"
                            )
                    if lua_data:
                        for token in (
                            "function WG_Init()",
                            "function IB_Init()",
                            "function FR_Init()",
                            "function WGL_Init()",
                            "__alasInitTimer",
                            "local function __cat(...)",
                            'name = __cat(IB_ItemName(ib_searchIdx), "[", '
                            "IB_IdStr(ib_itemList[ib_searchIdx]), \"]\")",
                        ):
                            if token not in script:
                                failures.append(f"{name}: missing {token}")
                        if "local function __cat(a, b)" in script:
                            failures.append(f"{name}: __cat drops arguments")
                    else:
                        for token in (
                            "function WG_Init takes nothing returns nothing",
                            "function IB_Init takes nothing returns nothing",
                            "function FR_Init takes nothing returns nothing",
                            "function WGL_Init takes nothing returns nothing",
                        ):
                            if token not in script:
                                failures.append(f"{name}: missing {token}")
                    mode_value = "true" if item_active else "false"
                    for mode_name in (
                        "WG_ITEM_ACTIVE",
                        "FR_ITEM_ACTIVE",
                        "WGL_ITEM_ACTIVE",
                    ):
                        expected_mode = (
                            f"boolean {mode_name} = {mode_value}"
                        )
                        if script.count(expected_mode) != 1:
                            failures.append(
                                f"{name}: wrong {mode_name} ownership mode"
                            )
                    for function_name, ability_id, check_event in (
                        ("WG_OnHandItemEvent", "WG_FINGER_ABILITY", True),
                        ("FR_OnItemDrop", "FR_SPELL_ID", False),
                        ("WGL_OnItemEvent", "'A113'", True),
                    ):
                        start = script.find(
                            f"function {function_name} takes"
                        )
                        end = script.find("endfunction", start)
                        body = (
                            script[start:end]
                            if start >= 0 and end >= 0
                            else ""
                        )
                        if (
                            "GetManipulatedItem()" not in body
                            or (
                                check_event
                                and "EVENT_PLAYER_UNIT_DROP_ITEM"
                                not in body
                            )
                            or f"UnitRemoveAbility(u, {ability_id})"
                            not in body
                        ):
                            failures.append(
                                f"{name}: {function_name} lacks direct "
                                "drop removal"
                            )
                        if "TriggerSleepAction" in body:
                            failures.append(
                                f"{name}: {function_name} still delays "
                                "drop removal"
                            )
                    if lua_data:
                        for token in (
                            "__alasOnQtCommand",
                            "TriggerRegisterPlayerChatEvent",
                            '"qt"',
                            "FogEnable(false)",
                            "FogMaskEnable(false)",
                        ):
                            if token not in script:
                                failures.append(
                                    f"{name}: missing qt command token {token}"
                                )
                    else:
                        for token in (
                            "function ALAS_InitQtCommand takes",
                            "function ALAS_OnQtCommand takes",
                            "TriggerRegisterPlayerChatEvent",
                            '"qt"',
                            "FogEnable(false)",
                            "FogMaskEnable(false)",
                        ):
                            if token not in script:
                                failures.append(
                                    f"{name}: missing qt command token {token}"
                                )
                        if script.count("call ALAS_EnableFullMap()") != 1:
                            failures.append(
                                f"{name}: qt must not enable full map "
                                "during startup"
                            )
                    item_ids = object_ids(
                        chapter.read_file("war3map.w3t"), False, name + ".w3t"
                    )
                    ability_ids = object_ids(
                        chapter.read_file("war3map.w3a"), True, name + ".w3a"
                    )
                    missing_items = expected_items - item_ids
                    missing_abilities = expected_abilities - ability_ids
                    if missing_items:
                        failures.append(
                            f"{name}: missing items {sorted(missing_items)}"
                        )
                    if missing_abilities:
                        failures.append(
                            f"{name}: missing abilities {sorted(missing_abilities)}"
                        )
                    all_item_fields = object_fields(
                        chapter.read_file("war3map.w3t"),
                        False,
                        name + ".w3t.fields",
                    )
                    item_fields = all_item_fields.get(warglaive_item, {})
                    demon_item_fields = all_item_fields.get(
                        demon_wing_item, {}
                    )
                    ability_data = chapter.read_file("war3map.w3a")
                    ability_entries = object_entries(
                        ability_data, True, name + ".w3a.fields"
                    )
                    all_ability_fields = object_fields(
                        ability_data, True, name + ".w3a.fields"
                    )
                    ability_origins = {
                        new.replace("\0", ""): old.replace("\0", "")
                        for _table, old, new, _mods in ability_entries
                        if new.replace("\0", "")
                    }
                    ability_fields = all_ability_fields.get("A113", {})
                    if ability_origins.get("A113") != "ANcl":
                        failures.append(
                            f"{name}: A113 base is "
                            f"{ability_origins.get('A113')!r}, expected ANcl"
                        )
                    expected_charge_strings = {
                        "alev": "1",
                        "aite": "0",
                        "ahky": "C",
                        "Ncl2": "2",
                        "Ncl3": "1",
                        "Ncl5": "1",
                        "Ncl6": "channel",
                        "atar": "",
                        "amcs": "70",
                    }
                    for field, expected in expected_charge_strings.items():
                        actual = ability_fields.get(field)
                        if actual != expected:
                            failures.append(
                                f"{name}: A113.{field}={actual!r}, "
                                f"expected {expected!r}"
                            )
                    expected_charge_numbers = {
                        "Ncl1": 1.16,
                        "Ncl4": 1.16,
                        "aran": 100000.0,
                        "acdn": 16.0,
                    }
                    for field, expected in expected_charge_numbers.items():
                        try:
                            actual = float(ability_fields.get(field, "nan"))
                        except ValueError:
                            actual = float("nan")
                        if abs(actual - expected) > 0.0001:
                            failures.append(
                                f"{name}: A113.{field}={actual!r}, "
                                f"expected {expected!r}"
                            )
                    if "abuf" in ability_fields:
                        failures.append(
                            f"{name}: A113 must not inherit a native charge buff"
                        )
                    if (
                        ability_fields.get("abpx") != "2"
                        or ability_fields.get("abpy") != "1"
                    ):
                        failures.append(
                            f"{name}: A113 command-card position is not 2,1"
                        )
                    for obsolete in ("chr1", "chr2", "ubr1", "ubr2", "ubr3"):
                        if obsolete in ability_fields:
                            failures.append(
                                f"{name}: A113 retains native AUbr field "
                                f"{obsolete}"
                            )
                    expected_wgl_iabi = (
                        "A113,A110,A111,Aclq"
                        if item_active
                        else "A110,A111,Aclq"
                    )
                    expected_wgl_icid = "A113" if item_active else ""
                    if item_fields.get("iabi") != expected_wgl_iabi:
                        failures.append(
                            f"{name}: {warglaive_item}.iabi="
                            f"{item_fields.get('iabi')!r}"
                        )
                    if item_fields.get("icid") != expected_wgl_icid:
                        failures.append(
                            f"{name}: {warglaive_item}.icid="
                            f"{item_fields.get('icid')!r}"
                        )
                    if item_fields.get("iico") != WARGLAIVE_ICON:
                        failures.append(
                            f"{name}: {warglaive_item}.iico="
                            f"{item_fields.get('iico')!r}"
                        )
                    if item_fields.get("ifil") != "Chest_Legendary.mdx":
                        failures.append(
                            f"{name}: {warglaive_item}.ifil="
                            f"{item_fields.get('ifil')!r}"
                        )
                    invul_fields = all_ability_fields.get(invul_id, {})
                    teleport_fields = all_ability_fields.get(teleport_id, {})
                    if abs(float(invul_fields.get("adur", 0))) < 9.999:
                        failures.append(
                            f"{name}: {invul_id} invulnerability is not 10 seconds"
                        )
                    if abs(float(teleport_fields.get("acas", 1))) > 0.0001:
                        failures.append(
                            f"{name}: {teleport_id} cast time is not zero"
                        )
                    if ability_origins.get(teleport_id) != "AHmt":
                        failures.append(
                            f"{name}: {teleport_id} base is "
                            f"{ability_origins.get(teleport_id)!r}, "
                            "expected AHmt"
                        )
                    if abs(float(teleport_fields.get("acdn", 0)) - 15.0) > 0.0001:
                        failures.append(
                            f"{name}: {teleport_id} cooldown is not 15 seconds"
                        )
                    if int(float(teleport_fields.get("amcs", 1))) != 0:
                        failures.append(
                            f"{name}: {teleport_id} still costs mana"
                        )
                    if teleport_fields.get("atar") != (
                        "friend,vulnerable,ground,structure,"
                        "invulnerable,nonsapper"
                    ):
                        failures.append(
                            f"{name}: {teleport_id} target list does not match Chenghai"
                        )
                    if int(float(teleport_fields.get("Hmt1", 0))) != 24:
                        failures.append(
                            f"{name}: {teleport_id} unit cap is not 24"
                        )
                    if abs(float(teleport_fields.get("Hmt2", 0)) - 0.2) > 0.0001:
                        failures.append(
                            f"{name}: {teleport_id} delay is not 0.2"
                        )
                    if int(float(teleport_fields.get("Hmt3", 0))) != 1:
                        failures.append(
                            f"{name}: {teleport_id} grouping flag is not enabled"
                        )
                    avatar_fields = all_ability_fields.get(avatar_id, {})
                    if ability_origins.get(avatar_id) != "ANcl":
                        failures.append(
                            f"{name}: {avatar_id} base is "
                            f"{ability_origins.get(avatar_id)!r}, "
                            "expected ANcl"
                        )
                    expected_avatar_strings = {
                        "aite": "1",
                        "anam": "天神下凡",
                        "aord": "avatar",
                        "aani": "stand",
                        "Ncl2": "0",
                        "Ncl6": "avatar",
                        "acat": "",
                        "aart": (
                            "ReplaceableTextures\\CommandButtons"
                            "\\BTNMetamorphosis.blp"
                        ),
                        "arar": (
                            "ReplaceableTextures\\CommandButtons"
                            "\\BTNMetamorphosis.blp"
                        ),
                    }
                    for field, expected in expected_avatar_strings.items():
                        if avatar_fields.get(field) != expected:
                            failures.append(
                                f"{name}: {avatar_id}.{field}="
                                f"{avatar_fields.get(field)!r}, "
                                f"expected {expected!r}"
                            )
                    if (
                        "abuf" in avatar_fields
                        or "Hav1" in avatar_fields
                    ):
                        failures.append(
                            f"{name}: {avatar_id} still contains "
                            "Vampiric Aura data"
                        )
                    expected_avatar_numbers = {
                        "adur": avatar_duration,
                        "ahdu": avatar_duration,
                        "acdn": avatar_cooldown,
                        "amcs": avatar_mana,
                    }
                    for field, expected in expected_avatar_numbers.items():
                        try:
                            actual = float(
                                avatar_fields.get(field, "nan")
                            )
                        except (TypeError, ValueError):
                            actual = float("nan")
                        if abs(actual - float(expected)) > 0.0001:
                            failures.append(
                                f"{name}: {avatar_id}.{field}="
                                f"{avatar_fields.get(field)!r}, "
                                f"expected {expected!r}"
                            )
                    expected_demon_abilities = ",".join(
                        demon_wing["iabi"]
                    )
                    if demon_item_fields.get("iabi") != (
                        expected_demon_abilities
                    ):
                        failures.append(
                            f"{name}: {demon_wing_item}.iabi="
                            f"{demon_item_fields.get('iabi')!r}, "
                            f"expected {expected_demon_abilities!r}"
                        )
                    if str(demon_item_fields.get("idrp")) != "0":
                        failures.append(
                            f"{name}: {demon_wing_item}.idrp="
                            f"{demon_item_fields.get('idrp')!r}, "
                            "expected 0"
                        )
                    for marker in (
                        "function WG_OnAvatarSimple takes",
                        "function WG_AvatarSimpleExpires takes",
                        "function WG_OnAvatarDropItem takes",
                        "BlzGetUnitIntegerField(u, UNIT_IF_DEFENSE_TYPE)",
                        "BlzSetUnitIntegerField(u, UNIT_IF_DEFENSE_TYPE, "
                        "WG_AVATAR_DIVINE_DEFENSE)",
                        "WG_AVATAR_MAGIC_IMMUNITY",
                        "AvatarActive=",
                        "UnitRemoveAbility(u, "
                        "WG_AVATAR_WING_MODEL_ABILITY)",
                        "UnitAddAbility(u, "
                        "WG_AVATAR_WING_MODEL_ABILITY)",
                        "BlzUnitDisableAbility(u, "
                        "WG_AVATAR_WING_MODEL_ABILITY, true, true)",
                        "SaveItemHandle(wg_avatarTable, key, 10, it)",
                        "SetItemDroppable(it, false)",
                        "SetItemDroppable(it, true)",
                        "TimerStart(t, WG_AVATAR_DURATION, false, "
                        "function WG_AvatarSimpleExpires)",
                        "TriggerAddAction(t, function WG_OnAvatarSimple)",
                        "real WG_AVATAR_ATTACK_SPEED_PCT = 1.0",
                        "real WG_AVATAR_MOVE_SPEED_PCT = 1.0",
                        "real WG_AVATAR_MODEL_SCALE_MULT = 3.0",
                        "UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN",
                        "BlzGetUnitRealField(u, UNIT_RF_SCALING_VALUE)",
                        "SetUnitScale(u, targetScale, targetScale, targetScale)",
                        "SetUnitMoveSpeed(u, originalSpeed * "
                        "(1.0 + WG_AVATAR_MOVE_SPEED_PCT))",
                        "LoadReal(wg_avatarTable, key, 50)",
                        "LoadReal(wg_avatarTable, key, 51)",
                    ):
                        if marker not in script:
                            failures.append(
                                f"{name}: missing Avatar runtime token "
                                f"{marker}"
                            )
                    if (
                        not lua_data
                        and "function WG_OnRangedVamp takes" not in script
                    ):
                        failures.append(f"{name}: missing ranged lifesteal runtime")
                    if lua_data:
                        failures.extend(lua_runtime_failures(name, script))
                    wgl_start = script.find(
                        "WARGLAIVE OF AZZINOTH - SCRIPTED BARBARIC CHARGE"
                    )
                    wgl_end = script.find(
                        "function main takes nothing returns nothing",
                        max(wgl_start, 0),
                    )
                    # Modules are inserted before the map's own helper
                    # functions. Bound the obsolete-token scan to the actual
                    # Warglaive module instead of unrelated map code between
                    # its marker and main.
                    wgl_init = script.find(
                        "function WGL_Init takes nothing returns nothing",
                        max(wgl_start, 0),
                    )
                    if wgl_init >= 0:
                        wgl_init_end = script.find(
                            "endfunction", wgl_init
                        )
                        if wgl_init_end >= 0:
                            wgl_end = wgl_init_end + len("endfunction")
                    if not lua_data and (wgl_start < 0 or wgl_end < 0):
                        failures.append(
                            f"{name}: Warglaive runtime section not found"
                        )
                        wgl_script = ""
                    else:
                        wgl_script = script[wgl_start:wgl_end]
                    for token in (() if lua_data else (
                        "function WGL_ShowTimedEffect takes",
                        "StormfallRed.mdx",
                        'PlaySound("Abilities\\\\Spells\\\\Human\\\\ThunderClap\\\\ThunderClapCaster.wav")',
                        "DemonBoltImpactSilent.mdx",
                        "real WGL_CHARGE_BASE_DISTANCE = 100.0",
                        "real WGL_CHARGE_AGI_MULT = 10.0",
                        "real WGL_CHARGE_MAX_DISTANCE = 2000.0",
                        "set chargeDistance = RMinBJ("
                        "WGL_CHARGE_MAX_DISTANCE, "
                        "WGL_CHARGE_BASE_DISTANCE + "
                        "I2R(GetHeroAgi(caster, true)) * WGL_CHARGE_AGI_MULT)",
                        "real WGL_CHARGE_STEP = 50.0",
                        "real WGL_CHARGE_INTERVAL = 0.05",
                        "real WGL_CHARGE_RADIUS = 150.0",
                        "real WGL_STACK_DURATION = 7.0",
                        "function WGL_OnCharge takes",
                        "function WGL_OnChargeOrder takes",
                        "function WGL_ChargeTick takes",
                        "function WGL_FinishCharge takes",
                        "function WGL_AddChargeStack takes",
                        "function WGL_StackTick takes",
                        "function WGL_OnGrowthAttack takes",
                        "function WGL_SyncAttackSpeed takes",
                        "EVENT_PLAYER_HERO_LEVEL",
                        "SetUnitAbilityLevel(u, 'A111'",
                        "set stat = GetHeroInt(caster, true)",
                        "integer WG_PLUNDER_ENABLE = 1",
                        "BlzGetEventIsAttack()",
                        "EVENT_PLAYER_UNIT_DAMAGED",
                        "SetHeroAgi(attacker, GetHeroAgi(attacker, false) + 1, true)",
                        "integer WGL_GROWTH_CHANCE_PERCENT = 2",
                        "埃辛诺斯战刃·邪魂淬炼：敏捷 +1",
                        "BlzUnitHideAbility(u, 'A117', true)",
                        "BlzUnitHideAbility(u, 'A118', true)",
                        "UnitAddAbility(u, 'A113')",
                        "UnitRemoveAbility(u, 'A113')",
                        "BlzGetUnitAbilityCooldownRemaining(u, 'A113')",
                        "SaveReal(WGL_COOLDOWN_HT, unitId, 0, "
                        "TimerGetElapsed(WGL_COOLDOWN_CLOCK) + "
                        "cooldownRemaining)",
                        "BlzStartUnitAbilityCooldown(u, 'A113', "
                        "cooldownRemaining)",
                        "set u = GetTriggerUnit()",
                        'IssueImmediateOrder(caster, "stop")',
                        "BlzStartUnitAbilityCooldown(caster, 'A113', "
                        "WGL_CHARGE_COOLDOWN)",
                        "BlzGetUnitAbilityCooldownRemaining(caster, 'A113')",
                        "GetIssuedOrderId() == OrderId(\"channel\")",
                        "real WGL_CHARGE_COOLDOWN = 16.0",
                        "TriggerRegisterAnyUnitEventBJ(WGL_CAST_TRIGGER, "
                        "EVENT_PLAYER_UNIT_SPELL_EFFECT)",
                        "TriggerRegisterAnyUnitEventBJ(WGL_ORDER_TRIGGER, "
                        "EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)",
                        'SetUnitAnimation(caster, "attack slam")',
                        "TimerStart(t, WGL_CHARGE_INTERVAL, true, "
                        "function WGL_ChargeTick)",
                        "set traveled = I2R(step) * WGL_CHARGE_STEP",
                        "not IsUnitInGroup(victim, hitGroup)",
                        "call WGL_AddChargeStack(caster)",
                        "I2R(GetHeroAgi(caster, true)) * 3.0",
                        "call SetUnitPathing(caster, false)",
                        "call SetUnitPathing(caster, true)",
                        "call PauseUnit(caster, true)",
                        "call PauseUnit(caster, false)",
                        "ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL",
                    )):
                        if token not in script:
                            failures.append(
                                f"{name}: missing Warglaive charge visual {token!r}"
                            )
                    for token in (() if lua_data else (
                        "WGL_CAST_START_TRIGGER",
                        "WGL_OnChargeStart",
                        "WGL_ChargeTrailTick",
                        "WGL_TRAIL_INTERVAL",
                        "AUbr",
                        "BUbr",
                        "chr2",
                        "IsTerrainPathable",
                        "BatteringRam.mdl",
                        "SetPlayerAbilityAvailable(GetOwningPlayer(u), "
                        "'A117'",
                        "SetPlayerAbilityAvailable(GetOwningPlayer(u), "
                        "'A118'",
                        "GetManipulatingUnit()",
                        "BlzUnitDisableAbility(u, 'A113'",
                        "BlzUnitHideAbility(u, 'A113'",
                        "SetUnitPosition(caster",
                    )):
                        if token in wgl_script:
                            failures.append(
                                f"{name}: obsolete native charge token {token!r}"
                            )
                    if (
                        not lua_data
                        and "set fx = fr_ground_effects[i]" not in script
                    ):
                        failures.append(
                            f"{name}: Frostmourne cleanup is not handle-safe"
                        )
                    for token in (() if lua_data else (
                        "function FR_OnSoulDeath takes",
                        "GetKillingUnit()",
                        "real FR_SOUL_NORMAL_CHANCE = 0.05",
                        "real FR_SOUL_HERO_CHANCE = 0.50",
                        "SetHeroStr(source",
                        "霜之哀伤·噬魂：力量 +1",
                        "function WG_IsFingerSoulTarget takes",
                        "function WG_FingerSoulChance takes",
                        "WG_HAND_SOUL_GAIN > 0",
                        "WG_HAND_SOUL_MIN_LEVEL",
                        "WG_HAND_SOUL_MIN_HP",
                        "GetWidgetLife(target) > 0.405",
                        "UnitDamageTarget(caster, target, dmg, true, false, "
                        "ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL",
                        "SetHeroInt(caster",
                        "阿克蒙德之手·夺魂：智力 +1",
                        "UnitAddAbility(u, WG_FINGER_ABILITY)",
                        "UnitRemoveAbility(u, WG_FINGER_ABILITY)",
                        "BlzGetUnitAbilityCooldownRemaining(u, WG_FINGER_ABILITY)",
                        "UnitAddAbility(u, FR_SPELL_ID)",
                        "UnitRemoveAbility(u, FR_SPELL_ID)",
                        "BlzGetUnitAbilityCooldownRemaining(u, FR_SPELL_ID)",
                        "FreezingBreathTargetArt.mdl",
                        "function FR_CreateFreezeFx takes",
                        "SaveEffectHandle(fr_freeze_table, unitKey, 1, fx)",
                        "function FR_DestroyFreezeFx takes",
                        "DestroyEffect(fx)",
                        "call FR_FreezeUnit(target, freeze_duration)",
                        "if FR_IsInvulnerable(target) then",
                        "BlzIsUnitInvulnerable(u)",
                        "EVENT_PLAYER_UNIT_SPELL_CAST",
                        "EVENT_PLAYER_UNIT_SPELL_EFFECT",
                        'SetUnitAnimation(caster, "stand")',
                        "function FR_OnStompCast takes",
                        "fr_cast_guard_table",
                        "real FR_CAST_GUARD_SECONDS = 9.5",
                        'FR_ShowTimedEffect("war3campImported\\\\IceStompRaised.mdx"',
                        "call TriggerSleepAction(0.05)",
                        "set bonus = 100.0 + ",
                        "function FR_OnHeroRevive takes",
                        "BlzUnitDisableAbility(u, FR_SPELL_ID, false, false)",
                        "function WG_IsExclusiveArtifact takes",
                        "function WG_HasOtherExclusiveArtifact takes",
                        "function WG_UnitCarriesItem takes",
                        "function WG_EnforceArtifactExclusivity takes",
                        "function WG_OnArtifactPickup takes",
                        "TriggerAddAction(t, function WG_OnArtifactPickup)",
                        "function IB_IsExclusiveArtifact takes",
                        "function IB_HasExclusiveArtifact takes",
                        "if IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u) then",
                    )):
                        if token not in script:
                            failures.append(
                                f"{name}: missing soul-steal token {token!r}"
                            )
                    if (
                        not lua_data
                        and "function ALAS_StartupMessage takes" not in script
                    ):
                        failures.append(f"{name}: missing unified startup message")
                    if (
                        not lua_data
                        and "BlzUnitDisableAbility(caster, FR_SPELL_ID, true, false)"
                        in script
                    ):
                        failures.append(
                            f"{name}: Frost Stomp can disable its own cast path"
                        )
                    for obsolete in (
                        "已加载 (wing/mount)",
                        "m.j 已执行",
                        "[霜之哀伤]|r 已加载",
                    ):
                        if obsolete in script:
                            failures.append(
                                f"{name}: obsolete startup message {obsolete!r}"
                            )
                    all_item_fields = object_fields(
                        chapter.read_file("war3map.w3t"),
                        False,
                        name + ".w3t.all-fields",
                    )
                    failures.extend(
                        wing_copy_failures(all_item_fields, wing_ids)
                    )
                    if item_active:
                        if "BlzUnitItemInEquipmentSlot" not in script:
                            failures.append(
                                f"{name}: missing loadout ownership checks"
                            )
                        for item_id in (
                            hand_item,
                            frostmourne_item,
                            warglaive_item,
                        ):
                            fields = all_item_fields.get(item_id, {})
                            if (
                                fields.get("icla") != "Equipment"
                                or fields.get("iequ") != "Trinket"
                                or fields.get("iusa") != "0"
                            ):
                                failures.append(
                                    f"{name}: {item_id} is not an "
                                    "Equipment/Trinket item"
                                )
                    if "|cffff8c00神器|r" not in (
                        all_item_fields.get(hand_item, {}).get("utub", "")
                    ):
                        failures.append(
                            f"{name}: {hand_item} tooltip lacks unified header"
                        )
                    if not all_item_fields.get(hand_item, {}).get(
                        "unam", ""
                    ).startswith("|cffff8c00"):
                        failures.append(
                            f"{name}: {hand_item} name is not orange"
                        )
                    hand_tooltip = all_item_fields.get(hand_item, {}).get(
                        "utub", ""
                    )
                    failures.extend(artifact_copy_failures(
                        hand_tooltip,
                        ("重击", "掠夺", "夺魂"),
                        "阿克蒙德留下",
                        f"{name}: {hand_item}",
                    ))
                    if "智力×25" in hand_tooltip or "冷却" in hand_tooltip:
                        failures.append(
                            f"{name}: {hand_item} still duplicates active details"
                        )
                    if not all(
                        token in hand_tooltip
                        for token in (
                            "夺魂", "永久 +1 智力", "掠夺", "重击",
                        )
                    ):
                        failures.append(
                            f"{name}: {hand_item} soul text is missing"
                        )
                    if "W091" not in all_item_fields.get(
                        hand_item, {}
                    ).get("iabi", ""):
                        failures.append(
                            f"{name}: {hand_item} universal Bash is not attached"
                        )
                    hand_iabi = all_item_fields.get(
                        hand_item, {}
                    ).get("iabi", "")
                    if item_active:
                        if hand_finger not in hand_iabi:
                            failures.append(
                                f"{name}: {hand_item} does not own "
                                f"active {hand_finger}"
                            )
                    elif hand_finger in hand_iabi:
                        failures.append(
                            f"{name}: {hand_item} still owns active "
                            f"{hand_finger}"
                        )
                    if all_item_fields.get(hand_item, {}).get("iusa") != "0":
                        failures.append(
                            f"{name}: {hand_item} is still marked usable"
                        )
                    hand_icid = all_item_fields.get(
                        hand_item, {}
                    ).get("icid", "")
                    if item_active and hand_icid != hand_finger:
                        failures.append(
                            f"{name}: {hand_item}.icid is not "
                            f"{hand_finger}"
                        )
                    elif not item_active and hand_icid:
                        failures.append(
                            f"{name}: {hand_item} still owns an item cooldown"
                        )
                    hand_finger_fields = all_ability_fields.get(
                        hand_finger, {}
                    )
                    if hand_finger_fields.get("aite") != "0":
                        failures.append(
                            f"{name}: {hand_finger} is not a hero ability"
                        )
                    if hand_finger_fields.get("ahky") != "F":
                        failures.append(
                            f"{name}: {hand_finger} hotkey is not F"
                        )
                    for icon_field in ("aart", "arar"):
                        if hand_finger_fields.get(icon_field) != (
                            r"ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp"
                        ):
                            failures.append(
                                f"{name}: {hand_finger}.{icon_field} "
                                "is not the original Death Finger icon"
                            )
                    hand_skill_tooltip = hand_finger_fields.get("aub1", "")
                    if "智力×25" not in hand_skill_tooltip:
                        failures.append(
                            f"{name}: {hand_finger} skill text is not updated"
                        )
                    if any(
                        token in hand_skill_tooltip
                        for token in ("冷却", "耗魔", "魔法消耗")
                    ):
                        failures.append(
                            f"{name}: {hand_finger} skill text repeats UI costs"
                        )
                    bash_fields = all_ability_fields.get("W091", {})
                    try:
                        if abs(float(bash_fields.get("Hbh1", "nan")) - 20.0) > 0.0001:
                            failures.append(f"{name}: W091 chance is not 20%")
                        if abs(float(bash_fields.get("Hbh3", "nan")) - 600.0) > 0.0001:
                            failures.append(f"{name}: W091 damage is not 600")
                    except (TypeError, ValueError):
                        failures.append(f"{name}: W091 numeric fields are invalid")
                    if "|cffff8c00神器|r" not in (
                        all_item_fields.get(
                            frostmourne_item, {}
                        ).get("utub", "")
                    ):
                        failures.append(
                            f"{name}: {frostmourne_item} tooltip lacks "
                            "unified header"
                        )
                    frost_tooltip = all_item_fields.get(
                        frostmourne_item, {}
                    ).get("utub", "")
                    failures.extend(artifact_copy_failures(
                        frost_tooltip,
                        ("霜冻新星", "噬魂"),
                        "巫妖王的低语",
                        f"{name}: {frostmourne_item}",
                    ))
                    if any(
                        token in frost_tooltip
                        for token in (
                            "100 + 4×力量", "消耗 100 魔法",
                            "耗魔 100", "冷却 10 秒",
                        )
                    ):
                        failures.append(
                            f"{name}: {frostmourne_item} still duplicates "
                            "active details"
                        )
                    frost_iabi = all_item_fields.get(
                        frostmourne_item, {}
                    ).get("iabi", "")
                    if item_active:
                        if "A105" not in frost_iabi:
                            failures.append(
                                f"{name}: {frostmourne_item} does not own A105"
                            )
                    elif "A105" in frost_iabi:
                        failures.append(
                            f"{name}: {frostmourne_item} still owns A105"
                        )
                    if all_item_fields.get(
                        frostmourne_item, {}
                    ).get("iusa") != "0":
                        failures.append(
                            f"{name}: {frostmourne_item} is still marked usable"
                        )
                    frost_icid = all_item_fields.get(
                        frostmourne_item, {}
                    ).get("icid", "")
                    if item_active and frost_icid != "A105":
                        failures.append(
                            f"{name}: {frostmourne_item}.icid is not A105"
                        )
                    elif not item_active and frost_icid:
                        failures.append(
                            f"{name}: {frostmourne_item} still owns an item cooldown"
                        )
                    frost_active_fields = all_ability_fields.get("A105", {})
                    if ability_origins.get("A105") != "ANcl":
                        failures.append(
                            f"{name}: A105 must use the instant Channel base"
                        )
                    if frost_active_fields.get("aite") != "0":
                        failures.append(f"{name}: A105 is not a hero ability")
                    if frost_active_fields.get("ahky") != "D":
                        failures.append(f"{name}: A105 hotkey is not D")
                    if frost_active_fields.get("aord") != "froststomp":
                        failures.append(
                            f"{name}: A105 Profile order is not froststomp"
                        )
                    if frost_active_fields.get("Ncl6") != "froststomp":
                        failures.append(
                            f"{name}: A105 Channel order is not froststomp"
                        )
                    if frost_active_fields.get("Ncl2") != "0":
                        failures.append(
                            f"{name}: A105 is not an instant no-target skill"
                        )
                    if frost_active_fields.get("Ncl3") != "1":
                        failures.append(
                            f"{name}: A105 is hidden on the command card"
                        )
                    if frost_active_fields.get("acat") != "":
                        failures.append(
                            f"{name}: A105 still has a native cast effect"
                        )
                    frost_skill_tooltip = frost_active_fields.get("aub1", "")
                    for required in (
                        "消耗当前生命 20%", "100 + 4×力量",
                        "核心 0～300", "中环 300～550", "外环 550～750",
                        "同时附加冰缓 60%，共持续 9 秒",
                        "空中单位不冰冻，但仍受伤害和减速",
                    ):
                        if required not in frost_skill_tooltip:
                            failures.append(
                                f"{name}: A105 skill text lacks {required!r}"
                            )
                    if "地面与空中" in frost_skill_tooltip:
                        failures.append(
                            f"{name}: A105 skill text still targets air units"
                        )
                    if (
                        "if IsUnitType(target, UNIT_TYPE_FLYING) then"
                        not in script
                    ):
                        failures.append(
                            f"{name}: Frost Stomp does not separate air slows"
                        )
                    for token in (
                        "function FR_IsAliveTarget takes",
                        "GetWidgetLife(u) <= 0.405",
                        "not IsUnitType(u, UNIT_TYPE_DEAD)",
                        "function FR_ApplySlow takes",
                        "call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)",
                        "call FR_FreezeUnit(target, freeze_duration)",
                        "function FR_OnFrozenDeath takes",
                        "call PauseUnit(u, false)",
                        "call SetUnitTimeScale(u, 1.0)",
                        "real FR_RING_CORE_RADIUS = 300.0",
                        "real FR_RING_MID_RADIUS = 550.0",
                        "real FR_FREEZE_CORE = 6.0",
                        "real FR_FREEZE_MID = 4.0",
                        "real FR_FREEZE_OUTER = 2.0",
                    ):
                        if token not in script:
                            failures.append(
                                f"{name}: missing Frost control token {token}"
                            )
                    slow_fields = all_ability_fields.get("A171", {})
                    if ability_origins.get("A171") != "Aslo":
                        failures.append(
                            f"{name}: A171 must use the native Slow base"
                        )
                    if slow_fields.get("abuf") != "Bfro":
                        failures.append(
                            f"{name}: A171 must use the Frost Nova buff"
                        )
                    try:
                        if abs(
                            float(slow_fields.get("Slo1", "nan")) - 0.4
                        ) > 0.0001:
                            failures.append(
                                f"{name}: A171 core slow is not 60%"
                            )
                        if abs(
                            float(slow_fields.get("adur", "nan")) - 9.0
                        ) > 0.0001:
                            failures.append(
                                f"{name}: A171 core slow is not 9 seconds"
                            )
                    except (TypeError, ValueError):
                        failures.append(
                            f"{name}: A171 slow fields are invalid"
                        )
                    if any(
                        token in frost_skill_tooltip
                        for token in (
                            "冰封践踏。", "消耗 100 魔法",
                            "耗魔 100", "冷却 10 秒",
                        )
                    ):
                        failures.append(
                            f"{name}: A105 skill text repeats title or UI costs"
                        )
                    if not all(
                        token in frost_tooltip
                        for token in ("噬魂", "5%", "50%")
                    ):
                        failures.append(
                            f"{name}: {frostmourne_item} soul text is missing"
                        )
                    buff_fields = object_fields(
                        chapter.read_file("war3map.w3h"),
                        False,
                        name + ".w3h.fields",
                    )
                    expected_buffs = {
                        hand_buff,
                        *wing_aura_ids.values(),
                        charge_buff,
                    }
                    for buff_id in expected_buffs:
                        if buff_id not in buff_fields:
                            failures.append(
                                f"{name}: missing status buff {buff_id}"
                            )
                    buff_pairs = [
                        (hand_aura, hand_buff),
                        *wing_aura_ids.items(),
                        ("A118", charge_buff),
                    ]
                    for ability_id, buff_id in buff_pairs:
                        actual = all_ability_fields.get(
                            ability_id, {}
                        ).get("abuf")
                        if actual != buff_id:
                            failures.append(
                                f"{name}: {ability_id}.abuf={actual!r}"
                            )
                    if ability_origins.get("A117") != "AIat":
                        failures.append(
                            f"{name}: A117 base is "
                            f"{ability_origins.get('A117')!r}, expected AIat"
                        )
                    if all_ability_fields.get("A117", {}).get("ahky"):
                        failures.append(
                            f"{name}: A117 exposes a duplicate command-card hotkey"
                        )
                    if all_ability_fields.get("A117", {}).get("aite") != "1":
                        failures.append(
                            f"{name}: A117 is not a green attack bonus"
                        )
                    attack_levels = level_values(
                        ability_entries, "A117", "Iatt"
                    )
                    for level in range(1, 21):
                        actual = attack_levels.get(level)
                        try:
                            value = int(float(actual))
                        except (TypeError, ValueError):
                            value = -1
                        if value != level * 15:
                            failures.append(
                                f"{name}: A117 level {level} attack bonus "
                                f"is {actual!r}, expected {level * 15}"
                            )
                    if ability_origins.get("A118") != "AOae":
                        failures.append(
                            f"{name}: A118 base is "
                            f"{ability_origins.get('A118')!r}, expected AOae"
                        )
                    if all_ability_fields.get("A118", {}).get("ahky"):
                        failures.append(
                            f"{name}: A118 exposes a duplicate command-card hotkey"
                        )
                    status_fields = all_ability_fields.get("A118", {})
                    for field, expected in (
                        ("Oae1", 0.0),
                        ("Oae2", 0.0),
                    ):
                        try:
                            actual = float(status_fields.get(field, "nan"))
                        except ValueError:
                            actual = float("nan")
                        if abs(actual - expected) > 0.0001:
                            failures.append(
                                f"{name}: A118.{field} adds an unwanted "
                                f"aura effect ({actual!r})"
                            )
                    expected_buff_icons = {
                        wing_aura_ids[wing_aura_ability_ids["aura_unholy"]]:
                        "CommandButtons\\BTNUnholyAura.blp",
                        wing_aura_ids[wing_aura_ability_ids["aura_vamp"]]:
                        "CommandButtons\\BTNVampiricAura.blp",
                        wing_aura_ids[wing_aura_ability_ids["aura_brill"]]:
                        "CommandButtons\\BTNBrilliance.blp",
                        wing_aura_ids[wing_aura_ability_ids["aura_command"]]:
                        "CommandButtons\\BTNGnollCommandAura.blp",
                        wing_aura_ids[wing_aura_ability_ids["aura_endur"]]:
                        "CommandButtons\\BTNCommand.blp",
                        charge_buff:
                        "CommandButtons\\BTNGarrekCharge.blp",
                    }
                    for buff_id, suffix in expected_buff_icons.items():
                        actual = buff_fields.get(buff_id, {}).get("fart", "")
                        if not actual.endswith(suffix):
                            failures.append(
                                f"{name}: {buff_id}.fart={actual!r}"
                            )
                    buff_origins = {
                        new.replace("\0", ""): old.replace("\0", "")
                        for _table, old, new, _mods in object_entries(
                            chapter.read_file("war3map.w3h"),
                            False,
                            name + ".w3h.origins",
                        )
                        if new.replace("\0", "")
                    }
                    if buff_origins.get(charge_buff) != "BHab":
                        failures.append(
                            f"{name}: {charge_buff} base is "
                            f"{buff_origins.get(charge_buff)!r}, "
                            "expected BHab"
                        )
                    for buff_id in ("BUbr",):
                        if buff_id in buff_origins:
                            failures.append(
                                f"{name}: forbidden custom native buff "
                                f"override {buff_id}"
                            )
                    if buff_fields.get(charge_buff, {}).get("fnam") != "雷霆冲锋":
                        failures.append(
                            f"{name}: {charge_buff} name is not 雷霆冲锋"
                        )
                    for required in ("埃辛诺斯战刃", "+15", "20", "7"):
                        if required not in buff_fields.get(charge_buff, {}).get(
                            "fube", ""
                        ):
                            failures.append(
                                f"{name}: B64B description lacks {required}"
                            )
                    if item_fields.get("unam") != (
                        "|cffff8c00埃辛诺斯战刃|r"
                    ):
                        failures.append(
                            f"{name}: I106 name is not orange"
                        )
                    tooltip = item_fields.get("utub", "")
                    description = item_fields.get("ides", "")
                    if "雷霆冲锋" not in description or "提高攻击速度" in description:
                        failures.append(
                            f"{name}: I106 description is not the managed tooltip"
                        )
                    failures.extend(artifact_copy_failures(
                        tooltip,
                        ("攻击速度随敏捷提升", "顺劈", "邪魂淬炼"),
                        "这是卡多雷",
                        f"{name}: I106",
                    ))
                    if not all(
                        token in tooltip for token in ("顺劈", "15% 转嫁")
                    ):
                        failures.append(
                            f"{name}: I106 tooltip lacks 15% cleave"
                        )
                    if "|cffff8c00神器|r" not in tooltip:
                        failures.append(f"{name}: I106 tooltip lacks artifact header")
                    if any(
                        token in tooltip
                        for token in (
                            "消耗 70 魔法", "耗魔 70", "冷却 16 秒",
                        )
                    ):
                        failures.append(
                            f"{name}: I106 still duplicates active costs"
                        )
                    if "主手武器" in tooltip:
                        failures.append(f"{name}: I106 still claims main-hand weapon")
                    if "+15 敏捷" not in tooltip:
                        failures.append(f"{name}: I106 agility is not 15")
                    if "敏捷×0.5%" not in tooltip:
                        failures.append(
                            f"{name}: I106 attack speed is not agility-scaled"
                        )
                    for required in (
                        "2% 几率永久提升 1 点敏捷",
                        "不设上限",
                    ):
                        if required not in tooltip:
                            failures.append(
                                f"{name}: I106 growth lacks {required!r}"
                            )
                    if "A112" in ability_origins:
                        failures.append(
                            f"{name}: obsolete corruption orb A112 remains"
                        )
                    if "A119" in ability_origins:
                        failures.append(
                            f"{name}: obsolete native growth ability A119 remains"
                        )
                    for field in ("aart", "arar"):
                        if ability_fields.get(field) != CHARGE_ICON:
                            failures.append(
                                f"{name}: A113.{field}="
                                f"{ability_fields.get(field)!r}"
                            )
                    if "3×敏捷" not in ability_fields.get("aub1", ""):
                        failures.append(f"{name}: A113 is not 3x agility")
                    if any(
                        token in ability_fields.get("aub1", "")
                        for token in (
                            "消耗 70 魔法", "耗魔 70", "冷却 16 秒",
                        )
                    ):
                        failures.append(
                            f"{name}: A113 skill text repeats UI costs"
                        )
                    try:
                        agility = int(
                            float(all_ability_fields["A110"]["Iagi"])
                        )
                        if agility != 15:
                            failures.append(f"{name}: A110 agility={agility}")
                        speed_levels = level_values(
                            ability_entries, "A111", "Isx1"
                        )
                        if len(speed_levels) != 38:
                            failures.append(
                                f"{name}: A111 has {len(speed_levels)} "
                                "attack-speed levels"
                            )
                        elif (
                            abs(float(speed_levels[1]) - 0.15) > 0.0001
                            or abs(float(speed_levels[38]) - 2.0) > 0.0001
                        ):
                            failures.append(
                                f"{name}: A111 range is "
                                f"{speed_levels[1]}..{speed_levels[38]}"
                            )
                        if all_ability_fields["A111"].get("alev") != "38":
                            failures.append(
                                f"{name}: A111.alev is not 38"
                            )
                        if "敏捷×0.5%" not in all_ability_fields["A111"].get(
                            "aub1", ""
                        ):
                            failures.append(
                                f"{name}: A111 lacks agility scaling"
                            )
                    except (KeyError, TypeError, ValueError) as exc:
                        failures.append(
                            f"{name}: numeric Warglaive stats invalid: {exc}"
                        )
                    stormfall = chapter.read_file("StormfallRed.mdx") or b""
                    if b"EVTS" in stormfall:
                        failures.append(
                            f"{name}: StormfallRed.mdx still has sound events"
                        )
                    silent_impact = (
                        chapter.read_file(
                            "war3campImported\\DemonBoltImpactSilent.mdx"
                        )
                        or b""
                    )
                    if b"EVTS" in silent_impact:
                        failures.append(
                            f"{name}: DemonBoltImpactSilent still has sound events"
                        )
                    for asset in ASSETS:
                        if not chapter.read_file(asset):
                            failures.append(f"{name}: missing asset {asset}")
                finally:
                    chapter.close()
            finally:
                temp.unlink(missing_ok=True)
    finally:
        outer.close()

    if failures:
        print("\nFAIL")
        for failure in failures:
            print(" -", failure)
        return 1
    print("\nPASS: title, chapters, runtime entry points, objects and assets")
    print(
        "Runtime smoke test still required: itembrowser, additem, wings, "
        "wing, wginfo, Warglaive A113, Frostmourne drop/pickup."
    )
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("campaign", type=Path)
    parser.add_argument("--config")
    parser.add_argument(
        "--equipment-mode",
        choices=("command", "item"),
    )
    args = parser.parse_args()
    if args.equipment_mode:
        os.environ["ALAS_EQUIPMENT_MODE"] = args.equipment_mode
    path = args.campaign.resolve()
    if not path.is_file():
        raise SystemExit("campaign not found: " + str(path))
    return audit(path, args.config)


if __name__ == "__main__":
    raise SystemExit(main())
