# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import _clean_campaign_patches as CLEAN  # noqa: E402


class BurningCleanPatchTest(unittest.TestCase):
    def test_neutralizes_generator_death_defeat_and_wipe(self) -> None:
        text = """function CreateGenerator takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
endfunction
function FailActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "失败!")
    call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null), function WipeCallback)
endfunction
function InitFail takes nothing returns nothing
    set gg_trg_Fail = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Fail, gg_unit_npgr_0732, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Fail, function FailActions)
endfunction
function MallActions takes nothing returns nothing
    call UnitApplyTimedLifeBJ(10.0, 'BTLF', udg_xxxx)
endfunction
"""
        output, records = CLEAN.patch(
            CLEAN.BURNING_WRATH_SHA256,
            text,
            "ransao03.w3m",
        )

        self.assertEqual(len(records), 2)
        self.assertNotIn("call SetUnitInvulnerable", output)
        self.assertNotIn("call CustomDefeatBJ", output)
        self.assertNotIn("call ForGroupBJ", output)
        self.assertNotIn("call UnitApplyTimedLifeBJ", output)
        self.assertIn(
            "generator death no longer defeats the player",
            output,
        )
        self.assertIn(
            "generator death no longer wipes the player army",
            output,
        )
        self.assertIn(
            "mall-gated generator explosion disabled",
            output,
        )
        self.assertEqual(
            CLEAN.verify(
                CLEAN.BURNING_WRATH_SHA256,
                output,
                "ransao03.w3m",
                records,
            ),
            [],
        )

    def test_removes_old_invulnerability_marker(self) -> None:
        text = """function CreateGenerator takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
    call SetUnitInvulnerable(gg_unit_npgr_0732, true) // IB: clean-source protected objective
endfunction
function FailActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "失败!")
endfunction
function InitFail takes nothing returns nothing
    set gg_trg_Fail = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Fail, gg_unit_npgr_0732, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Fail, function FailActions)
endfunction
"""
        output, records = CLEAN.patch(
            CLEAN.BURNING_WRATH_SHA256,
            text,
            "ransao03.w3m",
        )

        self.assertEqual(len(records), 1)
        self.assertNotIn("clean-source protected objective", output)
        self.assertNotIn("call CustomDefeatBJ", output)

    def test_does_not_apply_to_other_chapters_or_campaigns(self) -> None:
        text = """function CreateGenerator takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
endfunction
"""
        self.assertEqual(
            CLEAN.patch(CLEAN.BURNING_WRATH_SHA256, text, "ransao04.w3x")[0],
            text,
        )
        self.assertEqual(
            CLEAN.patch("0" * 64, text, "ransao03.w3m")[0],
            text,
        )


if __name__ == "__main__":
    unittest.main()
