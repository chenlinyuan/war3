from __future__ import annotations

import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]


def function_body(path: Path, name: str) -> str:
    text = path.read_text(encoding="utf-8")
    match = re.search(
        rf"(?ms)^function\s+{re.escape(name)}\s+takes.*?^endfunction\s*$",
        text,
    )
    if match is None:
        raise AssertionError(f"{name} not found in {path}")
    return match.group(0)


class RuntimeTimerBudgetTest(unittest.TestCase):
    def test_mount_sync_pauses_when_idle(self) -> None:
        path = ROOT / "scripts" / "wings" / "f.j"
        text = path.read_text(encoding="utf-8")
        mount_sync = function_body(path, "WG_MountSync")
        register = function_body(path, "WG_RegisterTriggers")

        self.assertIn("call TimerStart(wg_mountTimer, 0.03, true", register)
        self.assertIn("call PauseTimer(wg_mountTimer)", register)
        self.assertIn("call PauseTimer(wg_mountTimer)", mount_sync)
        self.assertIn("call ResumeTimer(wg_mountTimer)", function_body(path, "WG_RideMount"))
        self.assertNotIn("TimerStart(CreateTimer(), 0.03, true", text)

    def test_wings_and_immolation_only_scan_tracked_heroes(self) -> None:
        path = ROOT / "scripts" / "wings" / "f.j"
        wing_sync = function_body(path, "WG_WingSync")
        immolation = function_body(path, "WG_OnImmolation")

        self.assertIn("FirstOfGroup(wg_equipGroup)", wing_sync)
        self.assertIn("WG_HasManagedEquipment(u)", wing_sync)
        self.assertNotIn("GroupEnumUnitsOfPlayer", wing_sync)
        self.assertIn("ForGroup(wg_equipGroup", immolation)
        self.assertNotIn("GroupEnumUnitsOfPlayer", immolation)

    def test_frostmourne_blue_ground_aura_is_removed(self) -> None:
        path = ROOT / "scripts" / "frostmourne" / "f.j"
        text = path.read_text(encoding="utf-8")
        drop = function_body(path, "FR_OnItemDrop")

        self.assertNotIn("Rune-Blue-Aura_Raised20.mdx", text)
        self.assertNotIn("FR_GroundAuraStep", text)
        self.assertNotIn("FR_AddBeam", text)
        self.assertNotIn("ItemRarityTG5.pkfx", text)
        self.assertNotIn("fr_ground_", text)
        self.assertNotIn("fr_beam_", text)
        self.assertIn("call FR_SyncAbility(u)", drop)

    def test_talent_sync_uses_registered_heroes(self) -> None:
        path = ROOT / "scripts" / "talent-test" / "f.j"
        sync = function_body(path, "TT_SyncPlayers")
        init = function_body(path, "TT_Init")

        self.assertIn("TT_HEROES[heroIndex]", sync)
        self.assertNotIn("GroupEnumUnitsOfPlayer", sync)
        self.assertIn("TimerStart(CreateTimer(), 1.00, true, function TT_SyncPlayers)", init)


if __name__ == "__main__":
    unittest.main()
