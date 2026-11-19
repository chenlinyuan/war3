# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

import campaign_plugins  # noqa: E402
from campaign_plugins.linghan_wrath import cinematic_skip, player_wipe  # noqa: E402
from campaign_plugins.linghan_wrath.chapter_rules import CHAPTERS  # noqa: E402
from campaign_plugins.linghan_wrath.key_policy import (  # noqa: E402
    MALL_DEFAULT_TRUE,
    MALL_FALSE,
    MALL_TRUE,
)
from campaign_plugins.linghan_wrath.patch import patch, verify  # noqa: E402


SOURCE_SHA = (
    "6ee1f302edb0151772fbb40b799b6bf0"
    "489a70f271e9d808b0a40126387af278"
)
ALIAS_SHA = (
    "7c46b99eae5be7f17ed1fa8264dae6b0"
    "2b3857d51ae70dc8a516d890890dc3f1"
)
EXTRACTED_SHA = (
    "66dfed8abd138347ff96e72b4ad80298"
    "99d0980ea3b46171c8df89545d80a085"
)

WIPE_FIXTURE = """function Trig____________________036Conditions takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "0000H00006") != true
endfunction

function Trig____________________036Func002002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig____________________036Actions takes nothing returns nothing
    call SaveGroupHandle(YDLOC, GetHandleId(GetTriggeringTrigger()) * 3, 0x9995B7B9, YDWEGetUnitsOfPlayerMatchingNull(Player(0), null))
    call ForGroupBJ(LoadGroupHandle(YDLOC, GetHandleId(GetTriggeringTrigger()) * 3, 0x9995B7B9), function Trig____________________036Func002002)
    call DestroyGroup(LoadGroupHandle(YDLOC, GetHandleId(GetTriggeringTrigger()) * 3, 0x9995B7B9))
endfunction
"""

SKIP_FIXTURE = """function Trig____________________018Conditions takes nothing returns boolean
    return udg_dianyingtiaoguo10 != 20
endfunction

function InitTrig____________________018 takes nothing returns nothing
    set gg_trg____________________018 = CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg____________________018, Player(0))
endfunction
"""


class LinghanWrathManifestTest(unittest.TestCase):
    def test_manifest_is_independently_discovered(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        self.assertIsNotNone(plugin)
        self.assertEqual(plugin.name, "linghan-wrath")
        self.assertEqual(plugin.title, "凌寒之怒-暗黑之途")
        self.assertEqual(len(CHAPTERS), 24)
        self.assertEqual(
            plugin.manifest["chapter_key_rules"]["wu01.w3m"]["true"],
            ["0000H00006"],
        )
        self.assertIn("0000H00006", plugin.key_policy["true"])
        self.assertIs(campaign_plugins.for_source(ALIAS_SHA), plugin)
        self.assertIs(campaign_plugins.for_source(EXTRACTED_SHA), plugin)
        self.assertEqual(
            plugin.backpack_switch.get("ability_ids"),
            ["A63G"],
        )
        self.assertEqual(
            plugin.manifest["rules"]["wu02_cinematic_skip_window"]["chapter"],
            "wu02.w3x",
        )

    def test_all_shop_pets_skins_and_artifacts_are_whitelisted(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        categories = plugin.manifest["mall_categories"]
        category_keys = {
            key
            for values in categories.values()
            for key in values.values()
        }
        self.assertEqual(len(categories["artifacts"]), 4)
        self.assertEqual(len(categories["skins"]), 2)
        self.assertEqual(len(categories["pets"]), 11)
        self.assertEqual(len(categories["pet_privileges"]), 1)
        self.assertTrue(category_keys <= MALL_TRUE)
        self.assertFalse(category_keys & MALL_FALSE)
        self.assertFalse(MALL_DEFAULT_TRUE)
        self.assertNotIn("EC11", MALL_TRUE)
        self.assertNotIn("YPD0K", MALL_TRUE)


class LinghanWrathRepairTest(unittest.TestCase):
    def test_chapter_one_licence_wipe_is_disabled(self) -> None:
        self.assertEqual(
            player_wipe.verify(WIPE_FIXTURE),
            [
                "chapter1-platform-player-wipe-not-disabled",
                "chapter1-platform-player-wipe-still-active",
            ],
        )

        output, stats = patch(WIPE_FIXTURE, "wu01.w3m")
        self.assertEqual(stats["campaign_patch_count"], 1)
        self.assertIn("DisableTrigger(GetTriggeringTrigger())", output)
        self.assertIn(player_wipe.DISABLED_MARKER, output)
        self.assertEqual(player_wipe.find_player_wipes(output), [])
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "wu01.w3m")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["campaign_patch_count"], 0)
        self.assertEqual(verify(second, second_stats), [])

    def test_other_chapters_are_untouched(self) -> None:
        output, stats = patch(WIPE_FIXTURE, "wu04.w3m")
        self.assertEqual(output, WIPE_FIXTURE)
        self.assertEqual(stats["campaign_patch_count"], 0)
        self.assertEqual(verify(output, stats), [])

    def test_player_one_cleanup_is_preserved(self) -> None:
        text = WIPE_FIXTURE.replace(
            "YDWEGetUnitsOfPlayerMatchingNull(Player(0), null)",
            "YDWEGetUnitsOfPlayerMatchingNull(Player(1), null)",
        )
        self.assertRaises(RuntimeError, patch, text, "wu01.w3m")

    def test_chapter_two_skip_window_is_restored(self) -> None:
        self.assertEqual(cinematic_skip.state(SKIP_FIXTURE), "broken")
        output, stats = patch(SKIP_FIXTURE, r"chapters\wu02.w3x")
        self.assertEqual(stats["campaign_patch_count"], 1)
        self.assertEqual(cinematic_skip.state(output), "authored")
        self.assertIn("udg_dianyingtiaoguo10 == 10", output)
        self.assertIn(cinematic_skip.DISABLED_MARKER, output)
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "wu02.w3x")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["campaign_patch_count"], 0)
        self.assertEqual(verify(second, second_stats), [])

    def test_chapter_two_skip_rule_does_not_touch_other_chapters(self) -> None:
        output, stats = patch(SKIP_FIXTURE, "wu03.w3x")
        self.assertEqual(output, SKIP_FIXTURE)
        self.assertEqual(stats["campaign_patch_count"], 0)


if __name__ == "__main__":
    unittest.main()
