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


class _Var:
    def __init__(self, value: bool) -> None:
        self.value = value

    def get(self) -> bool:
        return self.value

    def set(self, value: bool) -> None:
        self.value = value


class _Control:
    def __init__(self) -> None:
        self.state = None

    def configure(self, **kwargs: object) -> None:
        if "state" in kwargs:
            self.state = kwargs["state"]


class _Label:
    def configure(self, **_kwargs: object) -> None:
        return


class TalentPanelDependencyTests(unittest.TestCase):
    def test_backpack_base_panels_are_fixed_and_disabled(self) -> None:
        app = type("App", (), {})()
        app.preflight_info = type(
            "Info",
            (),
            {
                "new_backpack_supported": True,
                "source_backpack_switch_ids": (),
            },
        )()
        app.new_backpack_var = _Var(True)
        app.reforged_migrate_var = _Var(False)
        app.remove_source_backpack_switch_var = _Var(False)
        app.new_backpack_inventory_var = _Var(False)
        app.new_backpack_stats_var = _Var(False)
        app.new_backpack_equipment_var = _Var(False)
        app.new_backpack_talents_var = _Var(False)
        app.new_backpack_panel_checks = [_Control() for _ in range(4)]
        app.update_universal_talents_capability = lambda _info: None

        alas_offline.OfflineApp.on_new_backpack_toggle(app)

        self.assertTrue(app.new_backpack_inventory_var.get())
        self.assertTrue(app.new_backpack_stats_var.get())
        self.assertEqual(
            [check.state for check in app.new_backpack_panel_checks],
            ["disabled", "disabled", "normal", "normal"],
        )

    def test_unchecking_talent_panel_clears_talent_trees(self) -> None:
        app = type("App", (), {})()
        app.new_backpack_talents_var = _Var(False)
        app.universal_talents_var = _Var(True)
        app.melee_hero_talents_var = _Var(True)
        app.preflight_info = object()
        app.updated_with = None

        def update(info: object) -> None:
            app.updated_with = info

        app.update_universal_talents_capability = update

        alas_offline.OfflineApp.on_talent_panel_toggle(app)

        self.assertFalse(app.universal_talents_var.get())
        self.assertFalse(app.melee_hero_talents_var.get())
        self.assertIs(app.updated_with, app.preflight_info)

    def test_rechecking_talent_panel_refreshes_talent_capability(self) -> None:
        app = type("App", (), {})()
        app.new_backpack_talents_var = _Var(True)
        app.universal_talents_var = _Var(False)
        app.melee_hero_talents_var = _Var(False)
        app.preflight_info = object()
        app.update_count = 0

        def update(_info: object) -> None:
            app.update_count += 1

        app.update_universal_talents_capability = update

        alas_offline.OfflineApp.on_talent_panel_toggle(app)

        self.assertEqual(app.update_count, 1)
        self.assertFalse(app.universal_talents_var.get())
        self.assertFalse(app.melee_hero_talents_var.get())

    def test_talent_capability_follows_panel_uncheck_and_recheck(self) -> None:
        app = type("App", (), {})()
        app.new_backpack_var = _Var(True)
        app.new_backpack_talents_var = _Var(True)
        app.universal_talents_var = _Var(False)
        app.melee_hero_talents_var = _Var(False)
        app.universal_talents_check = _Control()
        app.melee_hero_talents_check = _Control()
        app.universal_talents_hint_var = _Var("")
        app.universal_talents_hint_label = _Label()
        app.update_wild_equipment_drops_capability = lambda _info: None
        info = type(
            "Info",
            (),
            {
                "universal_talents_supported": True,
                "universal_talents_reason": "JASS",
            },
        )()

        update = alas_offline.OfflineApp.update_universal_talents_capability
        update(app, info)
        self.assertEqual(app.universal_talents_check.state, "normal")

        app.new_backpack_talents_var.set(False)
        update(app, info)
        self.assertEqual(app.universal_talents_check.state, "disabled")

        app.new_backpack_talents_var.set(True)
        update(app, info)
        self.assertEqual(app.universal_talents_check.state, "normal")

    def test_core_rejects_talents_without_talent_panel(self) -> None:
        with self.assertRaisesRegex(
            offline_core.OfflineToolError,
            "\u5929\u8d4b\u680f",
        ):
            offline_core.OfflineBuilder(
                new_backpack=True,
                new_backpack_panels=("inventory", "stats"),
                universal_talents=True,
            )

    def test_talent_trees_keep_generic_backpack_fallback(self) -> None:
        builder = offline_core.OfflineBuilder(
            new_backpack=True,
            new_backpack_panels=(
                "inventory",
                "equipment",
                "stats",
                "talents",
            ),
            universal_talents=True,
        )

        self.assertTrue(builder._requires_generic_backpack())

    def test_core_always_enables_backpack_base_panels(self) -> None:
        builder = offline_core.OfflineBuilder(
            new_backpack=True,
            new_backpack_panels=("equipment",),
        )

        self.assertEqual(
            builder.new_backpack_panels,
            ("inventory", "equipment", "stats"),
        )

    def test_running_game_only_warns_and_does_not_block_editing(self) -> None:
        builder = offline_core.OfflineBuilder()
        messages: list[str] = []
        builder.log = messages.append

        with mock.patch.object(
            offline_core,
            "running_war3_processes",
            return_value=["Warcraft III.exe"],
        ):
            builder._warn_game_running()

        self.assertEqual(len(messages), 1)
        self.assertIn("Warcraft III.exe", messages[0])
        self.assertIn("\u53ef\u4ee5\u7ee7\u7eed\u6539\u56fe", messages[0])


if __name__ == "__main__":
    unittest.main()
