# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import _patch_hero_death as HERO  # noqa: E402
import _patch_anticheat_markers as ANTI  # noqa: E402
import _patch_chat_registration as CHAT  # noqa: E402
import _patch_command_mall_guards as COMMAND  # noqa: E402
import _patch_cache_handoff as HANDOFF  # noqa: E402
import _patch_final_cinematic_cleanup as FINAL_CINEMATIC  # noqa: E402
import campaign_plugins.warsong_phantom as WARSONG  # noqa: E402
import _patch_mall_cleanup as CLEANUP  # noqa: E402
import _patch_restore_guards as RESTORE  # noqa: E402
import _neutralize_ends as ENDS  # noqa: E402
import _patch_sentinel_exits as SENTINEL  # noqa: E402
import stub_platform_natives as STUB  # noqa: E402
import _campaign_profiles as PROFILES  # noqa: E402
import _campaign_patch_registry as CAMPAIGN_PATCHES  # noqa: E402
import merge_w3obj as OBJECTS  # noqa: E402
import _patch_backpack_switch as BACKPACK  # noqa: E402


class PlatformLevelTest(unittest.TestCase):
    def test_map_level_stub_avoids_level_fifty_sentinel(self) -> None:
        value = STUB.default_value(
            "DzAPI_Map_GetMapLevel", "integer", STUB.DEFAULT_LEVEL, True
        )
        self.assertEqual(value, "30")
        self.assertLess(int(value), 50)


class CampaignObjectTextTest(unittest.TestCase):
    def test_resolves_trigstr_inside_object_string_fields(self) -> None:
        import struct

        value = b"TRIGSTR_105\x00"
        data = (
            struct.pack("<ii", 1, 0)
            + struct.pack("<i", 1)
            + b"0000"
            + b"A001"
            + struct.pack("<I", 1)
            + struct.pack("<Ii", 0x62757475, 3)
            + value
            + struct.pack("<I", 1)
        )
        output = OBJECTS.resolve_trigstr(data, "w3t", {105: "斧王物品说明"})
        self.assertIn("斧王物品说明".encode("utf-8"), output)
        self.assertNotIn(b"TRIGSTR_", output)


class BackpackSwitchRemovalTest(unittest.TestCase):
    def test_removes_script_grants_and_spell_conditions(self) -> None:
        text = """function C takes nothing returns boolean
    return GetSpellAbilityId()=='A6B7'
endfunction
function A takes nothing returns nothing
    call UnitAddAbilityBJ('A6B7',udg_hero)
    call UnitMakeAbilityPermanent(udg_hero,true,'A6B7')
endfunction
"""
        output, records = BACKPACK.patch_script(text, {"A6B7"})
        self.assertNotIn("'A6B7'", output)
        self.assertIn("return false", output)
        self.assertEqual(BACKPACK.verify_script(output, {"A6B7"}), [])
        self.assertEqual(len(records), 3)

    def test_removes_ability_object_and_list_tokens(self) -> None:
        from doctor.data import objects

        data = objects.write_objects_bytes(
            1,
            [
                (
                    0,
                    "hfoo",
                    "\0\0\0\0",
                    [("uabi", 3, 0, 0, b"A60Q,AInv", b"\0\0\0\0")],
                ),
                (1, "ANcl", "A60Q", []),
            ],
            False,
        )
        output, stats = BACKPACK.patch_objects(data, "w3u", {"A60Q"})
        self.assertEqual(stats["removed_objects"], 1)
        self.assertEqual(stats["removed_tokens"], 1)
        self.assertEqual(BACKPACK.verify_objects(output, "w3u", {"A60Q"}), [])

    def test_noop_object_patch_preserves_source_bytes(self) -> None:
        from doctor.data import objects

        data = objects.write_objects_bytes(
            1,
            [
                (
                    0,
                    "hfoo",
                    "\0\0\0\0",
                    [("uabi", 3, 0, 0, b"AInv", b"\0\0\0\0")],
                ),
            ],
            False,
        )

        output, stats = BACKPACK.patch_objects(data, "w3u", {"A60Q"})

        self.assertEqual(output, data)
        self.assertEqual(stats["removed_objects"], 0)
        self.assertEqual(stats["removed_tokens"], 0)


class HeroDeathPolicyTest(unittest.TestCase):
    def test_uses_zhujue_in_campaign_using_that_main_hero_name(self) -> None:
        text = """
unit udg_zhujue = null
unit udg_chongwu01 = null
function HConditions takes nothing returns boolean
    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true and GetOwningPlayer(GetDyingUnit()) == Player(0)
endfunction
function HActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "failed")
    call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null), function HFunc)
endfunction
function HFunc takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function InitTrig_H takes nothing returns nothing
    set gg_trg_H = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_H, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_H, Condition(function HConditions))
    call TriggerAddAction(gg_trg_H, function HActions)
endfunction
"""
        output, count = HERO.patch(text)
        self.assertEqual(count, 1)
        self.assertIn("GetDyingUnit() == udg_zhujue", output)
        self.assertNotIn("GetDyingUnit() == udg_ak", output)


class SentinelExitPolicyTest(unittest.TestCase):
    def test_disables_platform_level_and_clear_item_guards(self) -> None:
        text = """
function PlatformActions takes nothing returns nothing
    if GetPlayerTechCountSimple('R60E', Player(0)) >= 1 then
        call RemoveUnit(udg_zhujue)
        call CustomVictoryBJ(Player(0), false, false)
    endif
endfunction
function ItemActions takes nothing returns nothing
    if GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetTriggerUnit(), 'I67C')) >= 2 then
        call RemoveUnit(udg_zhujue)
        call CustomVictoryBJ(Player(0), false, false)
    endif
endfunction
function ThousandActions takes nothing returns nothing
    if GetPlayerTechCountSimple('R60F', Player(0)) >= 1 or DzAPI_Map_HasMallItem(Player(0), "WW56SZZ") == true then
        call SetPlayerHandicap(Player(PLAYER_NEUTRAL_AGGRESSIVE), 1000.0)
    endif
endfunction
"""
        output, stats = SENTINEL.patch(text)
        self.assertEqual(stats["sentinel_exit_count"], 3)
        self.assertEqual(output.count("if false then"), 3)
        self.assertNotIn("GetPlayerTechCountSimple('R60E', Player(0)) >= 1 then", output)
        self.assertNotIn("GetPlayerTechCountSimple('R60F', Player(0)) >= 1", output)
        self.assertEqual(SENTINEL.verify(output, stats["sentinel_exits"]), [])


class AntiCheatMarkerTest(unittest.TestCase):
    def test_marks_negative_mall_keys_false_from_wts_text(self) -> None:
        text = """
function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "YEZ500") != true then
        call QuestItemSetCompleted(udg_main, true)
    else
        call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "TRIGSTR_884")
    endif
    if DzAPI_Map_HasMallItem(Player(0), "SSE660") == true then
        call RemoveUnit(udg_main_hero)
    endif
endfunction
"""
        strings = {884: "警告：你已严重违反平台规定，使用未知软件"}
        result = ANTI.classify(text, strings)
        self.assertEqual(
            result["anti_cheat_mall_keys"], ["SSE660", "YEZ500"]
        )
        self.assertEqual(result["progress_marker_keys"], [])

    def test_detects_mall_key_that_blocks_quest_item_completion(self) -> None:
        text = """
function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "H6RDNN") == true then
        call CustomVictoryBJ(Player(0), false, false)
    else
        call QuestItemSetCompleted(udg_main_quest, true)
    endif
endfunction
"""
        result = ANTI.classify(text, {})
        self.assertEqual(result["progress_marker_keys"], ["H6RDNN"])
        self.assertEqual(result["mall_false_keys"], ["H6RDNN"])


class CampaignProfileTest(unittest.TestCase):
    def test_wilderness_wrath_reuses_known_false_markers_across_chapters(self) -> None:
        profile = PROFILES.for_source(
            "762675a812e20bc45fbe52cc56bf5ca0145fb9813fee5e68a585b11c77b0c141"
        )
        self.assertIsNotNone(profile)
        self.assertEqual(
            set(profile.mall_false),
            {
                "YEZ500",
                "SSE660",
                "SX015",
                "T6DS",
                "S6S5D",
                "QQ5564R",
                "WS6S6S",
                "SSD99R",
                "Y55TT",
                "QS2250",
                "WW56SZZ",
                "W5S9",
                "YSZT",
                "E6D66",
                "H5J4L",
                "HD8D2",
                "WEE9C",
            },
        )
        self.assertEqual(
            set(profile.mall_true),
            {
                "0000GS0007",
                "ZJP555",
                "MM652",
                "DW898",
                "FCZS7",
                "LLZW1",
                "GNSM5",
                "HDS19",
                "SYMM1",
                "LSZW2",
                "FAS66",
                "ARF874",
                "TH574",
                "AYZC4",
                "DFJ60",
                "ZS698",
                "CWSB2",
                "YEZ150",
                "YEZ350",
                "SGZD8",
            },
        )
        self.assertFalse(profile.mall_default_true)
        warsong = PROFILES.for_source(
            "f7c868b92afe5d3f74c84b996bfdb34255355a16d86a60bd6b617012dfa3ba5c"
        )
        self.assertIsNotNone(warsong)
        self.assertEqual(len(warsong.mall_true), 15)
        self.assertFalse(warsong.mall_default_true)
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids("wilderness-wrath"),
            {"A60Q"},
        )
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids("warsong-phantom"),
            {"A6B7"},
        )
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids("naga-wrath"),
            {"A63G"},
        )
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids("burning-wrath"),
            {"A63G"},
        )
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids("linghan-wrath"),
            {"A63G"},
        )
        self.assertEqual(
            CAMPAIGN_PATCHES.backpack_switch_ids(
                "blood-mission-qh-207"
            ),
            {"A627"},
        )
        self.assertFalse(
            CAMPAIGN_PATCHES.legacy_patch_enabled(
                "burning-wrath",
                "critical_props",
            )
        )
        self.assertTrue(
            CAMPAIGN_PATCHES.legacy_patch_enabled(
                "naga-wrath",
                "critical_props",
            )
        )


class WarsongPhantomPatchTest(unittest.TestCase):
    def test_neutralizes_license_cleanup_by_action(self) -> None:
        text = """function Cond takes nothing returns boolean
    return YDWECountLivingPlayerUnitsOfTypeIdNull('U60P', Player(0)) >= 1 and DzAPI_Map_HasMallItem(Player(0), "CWDAWUYAO") != true
endfunction
function RemoveAll takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function Act takes nothing returns nothing
    call ForGroupBJ(YDWEGetUnitsOfPlayerAllNull(Player(0)), function RemoveAll)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "warning")
endfunction
function InitTrig_T takes nothing returns nothing
    set gg_trg_T = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_T, 10.0)
    call TriggerAddCondition(gg_trg_T, Condition(function Cond))
    call TriggerAddAction(gg_trg_T, function Act)
endfunction
"""
        output, stats = WARSONG.patch(text, "dianyingfujia.w3x")
        self.assertEqual(stats["license_cleanup_count"], 1)
        self.assertIn("IB: mall license cleanup disabled", output)
        self.assertIn("IB: mall license warning disabled", output)
        stats["expected_license_cleanup_count"] = 1
        self.assertEqual(WARSONG.verify(output, stats), [])

    def test_narrows_any_hero_death_to_main_hero(self) -> None:
        text = """function Cond takes nothing returns boolean
    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true and GetOwningPlayer(GetDyingUnit()) == Player(0)
endfunction
function Act takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "failed")
endfunction
function InitTrig_T takes nothing returns nothing
    set gg_trg_T = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_T, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_T, Condition(function Cond))
    call TriggerAddAction(gg_trg_T, function Act)
endfunction
"""
        output, stats = WARSONG.patch(text, "Human01.w3m")
        self.assertIn("GetDyingUnit() == udg_zhange", output)
        self.assertEqual(stats["main_hero_death_count"], 1)
        stats["expected_license_cleanup_count"] = 0
        self.assertEqual(WARSONG.verify(output, stats), [])

    def test_disables_extra_pet_food_false_defeat(self) -> None:
        text = """function RemoveAll takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function Act takes nothing returns nothing
    if YDWECountLivingPlayerUnitsOfTypeIdNull('H62F', Player(0)) >= 1 and udg_food != GetFoodUsed('earc') then
        call ForGroupBJ(YDWEGetUnitsOfPlayerAllNull(Player(0)), function RemoveAll)
        call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "warning")
        call CustomDefeatBJ(Player(0), "failed")
    endif
endfunction
"""
        output, stats = WARSONG.patch(text, "jianshenger.w3x")
        self.assertEqual(stats["extra_pet_food_guard_count"], 1)
        self.assertIn("IB: extra-pet food false defeat disabled", output)
        stats["expected_license_cleanup_count"] = 0
        stats["expected_main_hero_death_count"] = 0
        self.assertEqual(WARSONG.verify(output, stats), [])


class CacheHandoffPolicyTest(unittest.TestCase):
    def test_disables_placeholder_hero_cache_write(self) -> None:
        text = """function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "WS6S6S") == true then
        call InitGameCacheBJ("shouwang02")
        set udg_zhujue = gg_unit_hkni_0047
        call StoreUnitBJ(udg_zhujue, "zhu", "jue", GetLastCreatedGameCacheBJ())
        call SaveGameCache(GetLastCreatedGameCacheBJ())
    endif
endfunction
"""
        output, records = HANDOFF.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn("if false then // IB: cache placeholder write disabled", output)
        self.assertEqual(HANDOFF.verify(output, records), [])

    def test_forces_real_handoff_unconditional(self) -> None:
        text = """function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "OTHER") == true then
        call InitGameCacheBJ("shouwang02")
        set udg_zhujue = gg_unit_O60W_0047
        call StoreUnitBJ(udg_zhujue, "zhu", "jue", GetLastCreatedGameCacheBJ())
        call SaveGameCache(GetLastCreatedGameCacheBJ())
    endif
endfunction
"""
        output, records = HANDOFF.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn("if true then // IB: preserve campaign unit cache handoff", output)
        self.assertEqual(HANDOFF.verify(output, records), [])

    def test_leaves_cache_block_with_side_effects_gated(self) -> None:
        text = """function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "CACHE_ONLY") == true then
        call InitGameCacheBJ("shouwang02")
        call StoreUnitBJ(udg_hero, "zhu", "jue", GetLastCreatedGameCacheBJ())
        call SaveGameCache(GetLastCreatedGameCacheBJ())
        call RemoveUnit(gg_unit_H006_0374)
    endif
endfunction
"""
        output, records = HANDOFF.patch(text)
        self.assertEqual(output, text)
        self.assertEqual(records, [])

    def test_verify_ignores_same_key_side_effect_block(self) -> None:
        text = """function Safe takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "MP620") == true then
        call InitGameCacheBJ("shouwang08")
        call StoreUnitBJ(udg_hero, "zhu", "jue", GetLastCreatedGameCacheBJ())
        call SaveGameCache(GetLastCreatedGameCacheBJ())
    endif
endfunction
function Risky takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "MP620") == true then
        call InitGameCacheBJ("shouwang08")
        call StoreUnitBJ(udg_hero, "zhu", "jue", GetLastCreatedGameCacheBJ())
        call SaveGameCache(GetLastCreatedGameCacheBJ())
        call CustomVictoryBJ(Player(0), false, false)
    endif
endfunction
"""
        output, records = HANDOFF.patch(text)
        self.assertEqual(len(records), 1)
        self.assertEqual(HANDOFF.verify(output, records), [])


class RestoreGuardPolicyTest(unittest.TestCase):
    def test_adds_chapter_five_restore_validator(self) -> None:
        text = """
function Create takes nothing returns nothing
    set gg_rct______________000 = Rect(0.0, 0.0, 1.0, 1.0)
    set gg_rct______________001 = Rect(0.0, 0.0, 1.0, 1.0)
endfunction
function Actions takes nothing returns nothing
    call InitGameCacheBJ("shouwang02")
    call RestoreUnitLocFacingAngleBJ("zhu", "jue", GetLastCreatedGameCacheBJ(), Player(0), null, 0.0)
    set udg_zhujue = bj_lastLoadedUnit
    call RestoreUnitLocFacingAngleBJ("chongwu", "02", GetLastCreatedGameCacheBJ(), Player(0), null, 0.0)
    set udg_chongwu02 = bj_lastLoadedUnit
endfunction
// object availability: 'O60W' 'O60M' 'n609'
""".replace("\n", "\r\n")
        output, stats = RESTORE.patch(text)
        self.assertEqual(stats["restore_guards"], 1)
        self.assertIn("IB: validate restored campaign units", output)
        self.assertIn("CreateUnit(Player(0), 'O60W'", output)
        self.assertEqual(RESTORE.verify(output), [])


class CommandMallGuardTest(unittest.TestCase):
    def test_removes_mall_clause_from_go_condition(self) -> None:
        text = """function GOConditions takes nothing returns boolean
    return ( GetEventPlayerChatString() == "GO" and IsQuestItemCompleted(udg_main) == true and DzAPI_Map_HasMallItem(Player(0), "SWLY65") != true ) and udg_main != null
endfunction
"""
        output, records = COMMAND.patch(text)
        self.assertEqual(len(records), 1)
        self.assertNotIn("SWLY65", output)
        self.assertIn('GetEventPlayerChatString() == "GO"', output)
        self.assertIn("IsQuestItemCompleted(udg_main) == true", output)
        self.assertEqual(COMMAND.verify(output), [])


class MallCleanupPolicyTest(unittest.TestCase):
    def test_disables_army_wide_license_cleanup(self) -> None:
        text = """function RemoveAll takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "FJPS8") != true and IsUnitAliveBJ(udg_pet) == true then
        call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null), function RemoveAll)
    endif
endfunction
"""
        output, records = CLEANUP.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn(
            'if DzAPI_Map_HasMallItem(Player(0), "FJPS8") != true',
            output,
        )
        self.assertIn(
            "call DoNothing() // IB: mall license cleanup disabled (FJPS8)",
            output,
        )
        self.assertNotIn(
            "call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null)",
            output,
        )
        self.assertEqual(CLEANUP.verify(output, records), [])

    def test_preserves_normal_branch_when_else_is_anti_cheat(self) -> None:
        text = """function RemoveAll takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function Actions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "YEZ500") != true then
        call QuestItemSetCompleted(udg_main, true)
    else
        call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "warning")
        call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null), function RemoveAll)
    endif
endfunction
"""
        output, records = CLEANUP.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn(
            'if DzAPI_Map_HasMallItem(Player(0), "YEZ500") != true then',
            output,
        )
        self.assertIn("call QuestItemSetCompleted(udg_main, true)", output)
        self.assertIn("call DoNothing() // IB: mall license cleanup disabled", output)
        self.assertEqual(CLEANUP.verify(output, records), [])


class MallDefaultPolicyTest(unittest.TestCase):
    def test_stub_can_default_to_false_with_explicit_whitelist(self) -> None:
        body = "\n".join(
            STUB.mall_stub_body(
                "player p, string key",
                {"BAD"},
                {"GOOD"},
                mall_default=False,
            )
        )
        self.assertIn('if key == "BAD" then', body)
        self.assertIn('if key == "GOOD" then', body)
        self.assertTrue(body.rstrip().endswith("return false"))


class FinalCinematicCleanupTest(unittest.TestCase):
    def test_restores_state_before_cinematic_victory(self) -> None:
        text = """function FinalActions takes nothing returns nothing
    call CinematicModeBJ(true, GetPlayersAll())
    call FogMaskEnable(false)
    call CustomVictoryBJ(Player(0), true, false)
endfunction
"""
        output, records = FINAL_CINEMATIC.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn("IB: restore campaign UI before final victory", output)
        self.assertLess(
            output.index("CinematicModeBJ(false"),
            output.index("CustomVictoryBJ"),
        )
        self.assertEqual(FINAL_CINEMATIC.verify(output, records), [])

    def test_restores_state_before_end_cinematic_victory(self) -> None:
        text = """function SkipActions takes nothing returns nothing
    call CustomVictoryBJ(Player(0), true, false)
endfunction
function InitTrig_Skip takes nothing returns nothing
    set gg_trg_Skip = CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Skip, Player(0))
    call TriggerAddAction(gg_trg_Skip, function SkipActions)
endfunction
"""
        output, records = FINAL_CINEMATIC.patch(text)
        self.assertEqual(len(records), 1)
        self.assertIn("FogEnable(true)", output)
        self.assertEqual(FINAL_CINEMATIC.verify(output, records), [])

    def test_ignores_non_cinematic_victory(self) -> None:
        text = """function NormalActions takes nothing returns nothing
    call CustomVictoryBJ(Player(0), true, false)
endfunction
"""
        output, records = FINAL_CINEMATIC.patch(text)
        self.assertEqual(output, text)
        self.assertEqual(records, [])


class ChatRegistrationTest(unittest.TestCase):
    def test_go_registration_uses_literal_command(self) -> None:
        text = """
function InitTrig_GO takes nothing returns nothing
    set gg_trg_GO = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_GO, Player(0), GetEventPlayerChatString(), true)
    call TriggerAddCondition(gg_trg_GO, Condition(function GOCond))
    call TriggerAddAction(gg_trg_GO, function GOAct)
endfunction
function GOCond takes nothing returns boolean
    return GetEventPlayerChatString() == "GO"
endfunction
function GOAct takes nothing returns nothing
    call DoNothing()
endfunction
"""
        output, records = CHAT.patch(text)
        self.assertEqual(records[0]["command"], "GO")
        self.assertIn(
            'TriggerRegisterPlayerChatEvent(gg_trg_GO, Player(0), "GO", true)',
            output,
        )
        self.assertEqual(CHAT.verify(output), [])


class TransitionVictoryTest(unittest.TestCase):
    def test_normal_next_level_victory_is_not_neutralized(self) -> None:
        text = """
function InitTrig_GO takes nothing returns nothing
    set gg_trg_GO = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_GO, Player(0), "GO", true)
    call TriggerAddCondition(gg_trg_GO, Condition(function GOCond))
    call TriggerAddAction(gg_trg_GO, function GOAct)
endfunction
function GOCond takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "0000GS0007") == true
endfunction
function GOAct takes nothing returns nothing
    call CustomVictoryBJ(Player(0), true, false)
    call SetNextLevelBJ("next.w3x")
endfunction
"""
        output, records = ENDS.neutralize(text)
        self.assertIn("call CustomVictoryBJ(Player(0), true, false)", output)
        self.assertEqual(records, [])


if __name__ == "__main__":
    unittest.main()
