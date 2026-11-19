# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import apply_source_backpack_removal as REMOVE  # noqa: E402


class FakeArchive:
    def __init__(self, files: dict[str, bytes]) -> None:
        self.files = files

    def read_file(self, name: str):
        return self.files.get(name)


class SourceBackpackRemovalTest(unittest.TestCase):
    def test_plans_script_grant_and_trigger_condition_removal(self) -> None:
        archive = FakeArchive(
            {
                "war3map.j": (
                    "function Grant takes nothing returns nothing\n"
                    "    call UnitAddAbilityBJ('A63G', GetTriggerUnit())\n"
                    "endfunction\n"
                    "function IsSwitch takes nothing returns boolean\n"
                    "    return GetSpellAbilityId() == 'A63G'\n"
                    "endfunction\n"
                ).encode("utf-8")
            }
        )

        patches, records = REMOVE.plan_archive(
            archive,
            {"A63G"},
            campaign_level=False,
        )

        self.assertEqual(len(patches), 1)
        self.assertNotIn(b"UnitAddAbilityBJ('A63G'", patches[0][1])
        self.assertIn(b"return false", patches[0][1])
        self.assertEqual(records[0]["file"], "war3map.j")

    def test_removes_native_add_remove_and_permanent_calls(self) -> None:
        archive = FakeArchive(
            {
                "war3map.j": (
                    "function Story takes nothing returns nothing\n"
                    "    call UnitRemoveAbilityBJ('A627', udg_old)\n"
                    "    call UnitRemoveAbilityBJ('A627', udg_new)\n"
                    "    call UnitAddAbility(udg_new, 'A627')\n"
                    "    call UnitMakeAbilityPermanent(udg_new, true, 'A627')\n"
                    "endfunction\n"
                ).encode("utf-8")
            }
        )

        patches, records = REMOVE.plan_archive(
            archive,
            {"A627"},
            campaign_level=False,
        )

        self.assertEqual(len(patches), 1)
        patched = patches[0][1]
        self.assertNotIn(b"'A627'", patched)
        self.assertEqual(
            patched.count(
                b"call DoNothing() // IB: backpack switch ability removed"
            ),
            4,
        )
        self.assertEqual(records[0]["file"], "war3map.j")

    def test_removes_player_availability_toggle(self) -> None:
        archive = FakeArchive(
            {
                "war3map.j": (
                    b"call SetPlayerAbilityAvailable(Player(0), 'A627', true)\n"
                )
            }
        )

        patches, _records = REMOVE.plan_archive(
            archive,
            {"A627"},
            campaign_level=False,
        )

        self.assertEqual(len(patches), 1)
        self.assertNotIn(b"'A627'", patches[0][1])

    def test_already_clean_archive_produces_no_patch(self) -> None:
        archive = FakeArchive(
            {
                "war3map.j": (
                    b"function Nothing takes nothing returns nothing\n"
                    b"endfunction\n"
                )
            }
        )

        patches, records = REMOVE.plan_archive(
            archive,
            {"A63G"},
            campaign_level=False,
        )

        self.assertEqual(patches, [])
        self.assertEqual(records, [])


if __name__ == "__main__":
    unittest.main()
