from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(INJECTOR))

import _patch_critical_props as CRITICAL_PROPS  # noqa: E402


FAILURE_SCRIPT = b"""function CreateAllUnits takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
endfunction
function FailActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "failed")
endfunction
function InitFail takes nothing returns nothing
    set gg_trg_Fail = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Fail, gg_unit_npgr_0732, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Fail, function FailActions)
endfunction
"""


class CriticalPropPatchTests(unittest.TestCase):
    def test_neutralizes_death_without_making_unit_invulnerable(self) -> None:
        output, count = CRITICAL_PROPS.patch(
            FAILURE_SCRIPT.decode("utf-8")
        )

        self.assertGreater(count, 0)
        self.assertNotIn("SetUnitInvulnerable", output)
        self.assertIn(
            "call DoNothing() // IB: critical prop death is no longer fatal",
            output,
        )

    def test_removes_only_the_known_generated_invulnerability(self) -> None:
        script = b"""function CreateAllUnits takes nothing returns nothing
    set gg_unit_E009 = CreateUnit(Player(0), 'E009', 0.0, 0.0, 0.0)
    call SetUnitInvulnerable(gg_unit_E009, true) // IB: critical prop must not die
    call SetUnitInvulnerable(gg_unit_E009, false)
endfunction
"""
        output, count = CRITICAL_PROPS.remove_legacy_invulnerability(
            script.decode("utf-8")
        )

        self.assertEqual(count, 1)
        self.assertNotIn("critical prop must not die", output)
        self.assertIn(
            "call SetUnitInvulnerable(gg_unit_E009, false)",
            output,
        )


if __name__ == "__main__":
    unittest.main()
