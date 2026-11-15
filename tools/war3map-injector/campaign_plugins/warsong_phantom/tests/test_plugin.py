# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

import campaign_plugins  # noqa: E402
import _campaign_patch_registry as REGISTRY  # noqa: E402
from campaign_plugins.warsong_phantom import patch, verify  # noqa: E402
from campaign_plugins.warsong_phantom.chapter_rules import (  # noqa: E402
    CHAPTERS,
    expected_fangshou_deathwing,
    expected_license_cleanup,
    expected_main_hero_death,
)
from campaign_plugins.warsong_phantom.key_policy import (  # noqa: E402
    MALL_DEFAULT_TRUE,
    MALL_TRUE,
)


SOURCE_SHA = (
    "f7c868b92afe5d3f74c84b996bfdb342"
    "55355a16d86a60bd6b617012dfa3ba5c"
)


class WarsongPhantomManifestTest(unittest.TestCase):
    def test_manifest_is_discovered_by_source_sha(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        self.assertIsNotNone(plugin)
        self.assertEqual(plugin.name, "warsong-phantom")
        self.assertEqual(plugin.title, "战歌魅影-斧王之怒")
        self.assertEqual(len(CHAPTERS), 19)
        self.assertEqual(len(MALL_TRUE), 15)
        self.assertFalse(MALL_DEFAULT_TRUE)

    def test_rule_chapter_sets_are_explicit(self) -> None:
        self.assertEqual(
            sum(expected_license_cleanup(chapter) for chapter in CHAPTERS),
            121,
        )
        self.assertEqual(
            sum(expected_main_hero_death(chapter) for chapter in CHAPTERS),
            7,
        )
        self.assertEqual(
            sum(
                expected_fangshou_deathwing(chapter)
                for chapter in CHAPTERS
            ),
            1,
        )

    def test_converter_registry_dispatches_by_profile_name(self) -> None:
        output, stats = REGISTRY.apply(
            "warsong-phantom",
            "function NoAction takes nothing returns nothing\nendfunction\n",
            "dianyingfujia.w3x",
        )
        self.assertIn("NoAction", output)
        self.assertEqual(stats["campaign_patch"], "warsong-phantom")


class WarsongPhantomOffsetSafetyTest(unittest.TestCase):
    def test_all_stages_use_fresh_function_offsets(self) -> None:
        text = """function RemoveAll takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function LicenseCond takes nothing returns boolean
    return YDWECountLivingPlayerUnitsOfTypeIdNull('H62F', Player(0)) >= 1 and HasMallItem(Player(0), "SBBQ") != true
endfunction
function LicenseAct takes nothing returns nothing
    call ForGroupBJ(YDWEGetUnitsOfPlayerAllNull(Player(0)), function RemoveAll)
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, "warning")
endfunction
function InitTrig_License takes nothing returns nothing
    set gg_trg_License = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_License, 10.0)
    call TriggerAddCondition(gg_trg_License, Condition(function LicenseCond))
    call TriggerAddAction(gg_trg_License, function LicenseAct)
endfunction
function HeroCond takes nothing returns boolean
    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true and GetOwningPlayer(GetDyingUnit()) == Player(0)
endfunction
function HeroAct takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "failed")
endfunction
function InitTrig_Hero takes nothing returns nothing
    set gg_trg_Hero = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hero, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Hero, Condition(function HeroCond))
    call TriggerAddAction(gg_trg_Hero, function HeroAct)
endfunction
"""
        output, stats = patch(text, "Human01.w3m")
        self.assertIn("IB: mall license cleanup disabled", output)
        self.assertIn("GetDyingUnit() == udg_zhange", output)
        self.assertEqual(stats["license_cleanup_count"], 1)
        self.assertEqual(stats["main_hero_death_count"], 1)
        stats["expected_license_cleanup_count"] = 1
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "Human01.w3m")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["campaign_patch_count"], 0)
        self.assertEqual(verify(second, stats), [])

    def test_fangshou_deathwing_cleanup_is_reordered_and_idempotent(
        self,
    ) -> None:
        text = """function Trig_faafxfcxActions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call TriggerSleepAction(1.00)
    call RemoveUnit(gg_unit_U60H_0127)
    call TransmissionFromUnitWithNameBJ(GetPlayersAll(),gg_unit_U60H_0127,"死亡之翼",null,"dialogue",bj_TIMETYPE_SET,10.00,true)
    call QuestMessageBJ(GetPlayersAll(),bj_QUESTMESSAGE_ALWAYSHINT,"reward")
endfunction
"""
        output, stats = patch(text, "fangshou.w3m")
        self.assertEqual(stats["fangshou_deathwing_count"], 1)
        dialogue = output.index("TransmissionFromUnitWithNameBJ")
        removal = output.index("call RemoveUnit(gg_unit_U60H_0127)")
        self.assertLess(dialogue, removal)
        self.assertIn(
            "call DisableTrigger(gg_trg_dafanwe______________u)",
            output,
        )
        self.assertIn("call DisableTrigger(gg_trg_xiaznasog)", output)
        self.assertIn("set gg_unit_U60H_0127=null", output)
        stats["expected_license_cleanup_count"] = 0
        self.assertEqual(verify(output, stats), [])

        second, second_stats = patch(output, "fangshou.w3m")
        self.assertEqual(second, output)
        self.assertEqual(second_stats["fangshou_deathwing_count"], 0)
        self.assertEqual(verify(second, stats), [])


if __name__ == "__main__":
    unittest.main()
