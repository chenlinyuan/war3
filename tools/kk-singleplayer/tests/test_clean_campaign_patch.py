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
    def test_protects_generator_without_removing_authored_defeat(self) -> None:
        text = """function CreateGenerator takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
endfunction
function FailActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "失败!")
endfunction
"""
        output, records = CLEAN.patch(
            CLEAN.BURNING_WRATH_SHA256,
            text,
            "ransao03.w3m",
        )

        self.assertEqual(len(records), 1)
        self.assertIn(
            "call SetUnitInvulnerable(gg_unit_npgr_0732, true)",
            output,
        )
        self.assertIn('call CustomDefeatBJ(Player(0), "失败!")', output)
        self.assertEqual(
            CLEAN.verify(
                CLEAN.BURNING_WRATH_SHA256,
                output,
                "ransao03.w3m",
                records,
            ),
            [],
        )

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
