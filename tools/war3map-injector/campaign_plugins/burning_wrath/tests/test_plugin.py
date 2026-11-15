# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

import _campaign_patch_registry as REGISTRY  # noqa: E402
import campaign_plugins  # noqa: E402
from campaign_plugins.burning_wrath import object_patch as OBJECT_PATCH  # noqa: E402
from campaign_plugins.burning_wrath.chapter_rules import CHAPTERS  # noqa: E402
from campaign_plugins.burning_wrath.key_policy import MALL_FALSE, MALL_TRUE  # noqa: E402
from campaign_plugins.burning_wrath.patch import patch, verify  # noqa: E402


SOURCE_SHA = (
    "1ccd780a0c151921a62be3f458de9aa6"
    "cb722b77c1d4fd25ae844c2b904212ae"
)


class BurningWrathManifestTest(unittest.TestCase):
    def test_manifest_is_independently_discovered(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        self.assertIsNotNone(plugin)
        self.assertEqual(plugin.name, "burning-wrath")
        self.assertEqual(plugin.title, "燃烧之怒v烈焰降临（更新）")
        self.assertEqual(len(CHAPTERS), 25)
        self.assertEqual(len(MALL_TRUE), 42)
        self.assertEqual(len(MALL_FALSE), 13)
        self.assertIn("TU66B", MALL_FALSE)
        self.assertIn("JDOLS5", MALL_FALSE)
        self.assertIn("URIZZ4", MALL_FALSE)


class BurningWrathRepairTest(unittest.TestCase):
    def test_artifact_charges_are_permanent(self) -> None:
        end = b"\0\0\0\0"
        entries = [
            (1, "desc", "I60Q", []),
            (
                1,
                "desc",
                "I66T",
                [("iuse", 0, 0, 0, 3, end)],
            ),
            (
                1,
                "ankh",
                "I63N",
                [("iuse", 0, 0, 0, 3, end)],
            ),
        ]
        data = OBJECT_PATCH.OBJ.write_objects_bytes(2, entries, False)
        output, records = REGISTRY.patch_objects(
            "burning-wrath",
            data,
            "w3t",
            "ransao02.w3x",
        )
        self.assertEqual(
            {str(record["item"]) for record in records},
            {"I60Q", "I66T"},
        )
        self.assertEqual(
            REGISTRY.verify_objects(
                "burning-wrath",
                output,
                "w3t",
                "ransao02.w3x",
                records,
            ),
            [],
        )

    def test_generic_hero_defeat_is_rejected(self) -> None:
        text = """function HeroDeathConditions takes nothing returns boolean
    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true and GetOwningPlayer(GetDyingUnit()) == Player(0)
endfunction
function HeroDeathActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "failed")
endfunction
function InitHeroDeath takes nothing returns nothing
    set gg_trg_HeroDeath=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_HeroDeath, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_HeroDeath, Condition(function HeroDeathConditions))
    call TriggerAddAction(gg_trg_HeroDeath, function HeroDeathActions)
endfunction
"""
        problems = verify(
            text,
            {"campaign_patch_unknown_chapter": False},
        )
        self.assertIn("generic-hero-defeat:gg_trg_HeroDeath", problems)

    def test_sentinel_item_no_longer_deletes_boss(self) -> None:
        text = """function SentinelActions takes nothing returns nothing
    if GetItemTypeId(GetManipulatedItem()) == 'I67I' then
        call RemoveUnit(gg_unit_H64Z_0401)
    endif
endfunction
"""
        output, stats = patch(text, "ransao02.w3x")
        self.assertEqual(stats["campaign_patch_count"], 1)
        self.assertNotIn("call RemoveUnit(gg_unit_H64Z_0401)", output)
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "ransao02.w3x")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["campaign_patch_count"], 0)


if __name__ == "__main__":
    unittest.main()
