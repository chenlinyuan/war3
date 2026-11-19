from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import apply_new_backpack as BACKPACK  # noqa: E402
import objparse as OBJECTS  # noqa: E402


class BackpackRuntimeTests(unittest.TestCase):
    def test_jass_runtime_recognizes_talent_backpacks(self) -> None:
        self.assertIn(
            "itemId >= 'Z000' and itemId <= 'Z063'",
            BACKPACK.JASS_FUNCTIONS,
        )
        self.assertNotIn("ALAS_B30B_RETRY_TIMER", BACKPACK.JASS_FUNCTIONS)

    def test_backpack_uses_native_3_0_equipment_backpack_base(self) -> None:
        version, _original, custom = OBJECTS.read_bytes(
            (INJECTOR / "_b30b_item.w3t").read_bytes(),
            "w3t",
        )
        entry = next(
            item
            for item in custom
            if item["new"].replace("\0", "") == "B30B"
        )

        self.assertEqual(version, 2)
        self.assertEqual(entry["old"].replace("\0", ""), "ebac")
        fields = {
            mod[0]: mod[4]
            for mod in entry["mods"]
        }
        self.assertIn("ides", fields)
        self.assertNotIn("\u653b\u51fb\u4e4b\u722a", str(fields["ides"]))
        self.assertIn(
            '"old": "ebac"',
            (
                INJECTOR / "build_losttemple_talent_tree.py"
            ).read_text(encoding="utf-8"),
        )
        self.assertIn(
            'mod("ides", BACKPACK_TOOLTIP)',
            (
                INJECTOR / "build_losttemple_talent_tree.py"
            ).read_text(encoding="utf-8"),
        )

    def test_lua_runtime_recognizes_talent_backpacks(self) -> None:
        self.assertIn(
            'itemId >= FourCC("Z000") and itemId <= FourCC("Z063")',
            BACKPACK.LUA_RUNTIME,
        )
        self.assertNotIn("retryScan", BACKPACK.LUA_RUNTIME)

    def test_generic_backpack_only_targets_active_user_heroes(self) -> None:
        for marker in (
            "set p = GetOwningPlayer(u)",
            "GetPlayerController(p) != MAP_CONTROL_USER",
            "GetPlayerSlotState(p) != PLAYER_SLOT_STATE_PLAYING",
        ):
            self.assertIn(marker, BACKPACK.JASS_FUNCTIONS)
        for marker in (
            "local p = GetOwningPlayer(u)",
            "GetPlayerController(p) ~= MAP_CONTROL_USER",
            "GetPlayerSlotState(p) ~= PLAYER_SLOT_STATE_PLAYING",
        ):
            self.assertIn(marker, BACKPACK.LUA_RUNTIME)
        self.assertLess(
            BACKPACK.JASS_FUNCTIONS.index(
                "GetPlayerController(p) != MAP_CONTROL_USER"
            ),
            BACKPACK.JASS_FUNCTIONS.index(
                "UnitAddItemByIdSwapped('B30B', u)"
            ),
        )
        self.assertLess(
            BACKPACK.LUA_RUNTIME.index(
                "GetPlayerController(p) ~= MAP_CONTROL_USER"
            ),
            BACKPACK.LUA_RUNTIME.index(
                'UnitAddItemByIdSwapped(FourCC("B30B"), u)'
            ),
        )

    def test_runtime_uses_orders_to_rescue_late_heroes(self) -> None:
        self.assertIn(
            "ALAS_B30B_ORDER_TRIGGER",
            BACKPACK.JASS_FUNCTIONS,
        )
        self.assertIn(
            "EVENT_PLAYER_UNIT_ISSUED_ORDER",
            BACKPACK.JASS_FUNCTIONS,
        )
        self.assertIn(
            "orderTrigger",
            BACKPACK.LUA_RUNTIME,
        )
        self.assertIn(
            "EVENT_PLAYER_UNIT_ISSUED_ORDER",
            BACKPACK.LUA_RUNTIME,
        )
        self.assertIn(
            "call TriggerSleepAction(0.50)",
            BACKPACK.JASS_FUNCTIONS,
        )
        self.assertIn(
            "TimerStart(CreateTimer(), 0.50, false, function()",
            BACKPACK.LUA_RUNTIME,
        )

    def test_runtime_waits_for_campaign_restore_before_initial_scan(
        self,
    ) -> None:
        self.assertIn(
            "TimerStart(CreateTimer(), 0.75, false, "
            "function ALAS_B30B_ScanInitial)",
            BACKPACK.JASS_FUNCTIONS,
        )
        self.assertIn(
            "TimerStart(CreateTimer(), 0.75, false, scanInitial)",
            BACKPACK.LUA_RUNTIME,
        )

    def test_runtime_writes_dedicated_backpack_log(self) -> None:
        for runtime in (BACKPACK.JASS_FUNCTIONS, BACKPACK.LUA_RUNTIME):
            self.assertIn("ALAS-BackpackLog.txt", runtime)
            self.assertIn("BACKPACK_ADD_OK", runtime)
            self.assertIn("BACKPACK_ADD_FAIL", runtime)
            self.assertIn('"order"', runtime)

    def test_talent_runtime_keeps_b30b_as_failure_fallback(self) -> None:
        script = (
            INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j"
        ).read_text(encoding="utf-8")

        self.assertIn(
            "set oldBag = UnitRemoveItemFromSlot(u, i)",
            script,
        )
        self.assertIn("event=BACKPACK_FALLBACK", script)
        self.assertIn("restored=B30B", script)

    def test_universal_talents_require_inventory_ability(self) -> None:
        script = (
            INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j"
        ).read_text(encoding="utf-8")

        self.assertIn(
            "function TT_HasInventoryAbility takes unit u returns boolean",
            script,
        )
        self.assertIn(
            "not TT_IsLiveHero(u) or not TT_HasInventoryAbility(u)",
            script,
        )
        self.assertIn(
            "TT_HasInventoryAbility",
            (
                INJECTOR / "universal_talents.py"
            ).read_text(encoding="utf-8"),
        )


if __name__ == "__main__":
    unittest.main()
