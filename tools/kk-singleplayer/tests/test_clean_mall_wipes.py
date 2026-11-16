# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import _patch_clean_mall_wipes as WIPES  # noqa: E402


class CleanMallWipeTest(unittest.TestCase):
    def test_disables_mall_gated_player_group_wipe_and_defeat(self) -> None:
        text = """function WipeFilter takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'H67V'
endfunction
function WipeRemove takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function WipeActions takes nothing returns nothing
    call SaveGroupHandle(YDLOC, 1, 2, YDWEGetUnitsOfPlayerMatchingNull(Player(0), null))
    call ForGroupBJ(LoadGroupHandle(YDLOC, 1, 2), function WipeRemove)
    call CustomDefeatBJ(Player(0), "失败!")
endfunction
function WipeConditions takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "MDS122") != true
endfunction
function InitTrig_Wipe takes nothing returns nothing
    set gg_trg_Wipe = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Wipe, 5.0)
    call TriggerAddCondition(gg_trg_Wipe, Condition(function WipeConditions))
    call TriggerAddAction(gg_trg_Wipe, function WipeActions)
endfunction
"""
        output, records = WIPES.patch(text)

        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]["keys"], ["MDS122"])
        self.assertIn("mall-gated player-group wipe disabled", output)
        self.assertIn("mall-gated defeat disabled", output)
        self.assertNotIn("call ForGroupBJ(LoadGroupHandle", output)
        self.assertNotIn("call CustomDefeatBJ", output)
        self.assertEqual(WIPES.verify(output), [])

        second, second_records = WIPES.patch(output)
        self.assertEqual(second, output)
        self.assertEqual(second_records, [])

    def test_preserves_story_group_cleanup_without_mall_condition(self) -> None:
        text = """function StoryRemove takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction
function StoryActions takes nothing returns nothing
    call SaveGroupHandle(YDLOC, 1, 2, YDWEGetUnitsOfPlayerMatchingNull(Player(0), null))
    call ForGroupBJ(LoadGroupHandle(YDLOC, 1, 2), function StoryRemove)
    call CustomDefeatBJ(Player(0), "任务失败")
endfunction
function StoryConditions takes nothing returns boolean
    return udg_objective_dead == true
endfunction
function InitTrig_Story takes nothing returns nothing
    set gg_trg_Story = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Story, 5.0)
    call TriggerAddCondition(gg_trg_Story, Condition(function StoryConditions))
    call TriggerAddAction(gg_trg_Story, function StoryActions)
endfunction
"""
        output, records = WIPES.patch(text)

        self.assertEqual(output, text)
        self.assertEqual(records, [])


if __name__ == "__main__":
    unittest.main()
