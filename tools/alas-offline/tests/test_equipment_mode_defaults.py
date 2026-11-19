from __future__ import annotations

import sys
import unittest
from pathlib import Path
from unittest import mock


APP_DIR = Path(__file__).resolve().parents[1]
ROOT = APP_DIR.parents[1]
sys.path.insert(0, str(APP_DIR))
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))
sys.path.insert(
    0,
    str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"),
)

import alas_offline  # noqa: E402
import offline_core  # noqa: E402


class EquipmentModeDefaultTests(unittest.TestCase):
    def test_core_defaults_to_equipment_panel_skill(self) -> None:
        builder = offline_core.OfflineBuilder()

        self.assertEqual(builder.equipment_mode, "item")

    def test_gui_defaults_to_equipment_panel_skill(self) -> None:
        self.assertEqual(
            alas_offline.EQUIPMENT_MODE_LABELS[
                alas_offline.EQUIPMENT_MODE_DEFAULT
            ],
            "item（装备栏技能，默认）",
        )

    def test_equipment_panel_skill_is_first_gui_choice(self) -> None:
        self.assertEqual(
            alas_offline.EQUIPMENT_MODE_CHOICES[0],
            "item",
        )
        self.assertEqual(
            alas_offline.EQUIPMENT_MODE_DEFAULT,
            alas_offline.EQUIPMENT_MODE_CHOICES[0],
        )

    def test_command_mode_remains_available(self) -> None:
        self.assertIn("command", alas_offline.EQUIPMENT_MODE_CHOICES)
        self.assertIn(
            "command",
            alas_offline.EQUIPMENT_MODE_LABELS,
        )

    def test_cli_passes_equipment_panel_skill_by_default(self) -> None:
        with mock.patch.object(alas_offline, "OfflineBuilder") as builder:
            builder.return_value.build.return_value = object()

            result = alas_offline.run_cli(
                [
                    "--source",
                    "input.w3n",
                    "--output",
                    "output.w3n",
                ]
            )

        self.assertEqual(result, 0)
        self.assertEqual(
            builder.call_args.kwargs["equipment_mode"],
            "item",
        )


if __name__ == "__main__":
    unittest.main()
