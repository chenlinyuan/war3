# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

import _campaign_patch_registry as REGISTRY  # noqa: E402
import campaign_plugins  # noqa: E402
from campaign_plugins.naga_wrath import object_patch as OBJECT_PATCH  # noqa: E402
from campaign_plugins.naga_wrath.chapter_rules import CHAPTERS  # noqa: E402
from campaign_plugins.naga_wrath.key_policy import MALL_FALSE, MALL_TRUE  # noqa: E402
from campaign_plugins.naga_wrath.patch import patch, verify  # noqa: E402


SOURCE_SHA = (
    "ab9df75bb6b1397ae6ad1601af302461"
    "7af1b81f79b9429446efe693ab94338c"
)


class NagaWrathManifestTest(unittest.TestCase):
    def test_manifest_is_independently_discovered(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        self.assertIsNotNone(plugin)
        self.assertEqual(plugin.name, "naga-wrath")
        self.assertEqual(plugin.title, "娜迦之怒-暗涌初现")
        self.assertEqual(len(CHAPTERS), 17)
        self.assertEqual(len(MALL_TRUE), 19)
        self.assertEqual(len(MALL_FALSE), 0)


class NagaWrathRepairTest(unittest.TestCase):
    def test_only_campaign_heroes_trigger_defeat(self) -> None:
        text = """unit udg_yilidan=null
unit udg_fashiqi=null
unit udg_chongwu=null
function HeroDeathConditions takes nothing returns boolean
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
        output, stats = patch(text, "fennudidi.w3m")
        self.assertEqual(stats["campaign_patch_count"], 1)
        self.assertIn("GetDyingUnit() == udg_yilidan", output)
        self.assertIn("GetDyingUnit() == udg_fashiqi", output)
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "fennudidi.w3m")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["campaign_patch_count"], 0)
        self.assertEqual(verify(second, stats), [])

    def test_artifact_charges_are_permanent(self) -> None:
        end = b"\0\0\0\0"
        entries = [
            (1, "desc", "I60Q", []),
            (
                1,
                "desc",
                "I60M",
                [("iuse", 0, 0, 0, 3, end)],
            ),
        ]
        data = OBJECT_PATCH.OBJ.write_objects_bytes(2, entries, False)
        output, records = REGISTRY.patch_objects(
            "naga-wrath",
            data,
            "w3t",
            "fennuyi.w3x",
        )
        self.assertEqual(
            {str(record["item"]) for record in records},
            {"I60Q", "I60M"},
        )
        self.assertEqual(
            REGISTRY.verify_objects(
                "naga-wrath",
                output,
                "w3t",
                "fennuyi.w3x",
                records,
            ),
            [],
        )


if __name__ == "__main__":
    unittest.main()
