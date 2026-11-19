# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import campaign_plugins as PLUGINS  # noqa: E402


class CampaignBackpackProfileTest(unittest.TestCase):
    def test_matches_repacked_campaign_by_exact_chapter_set(self) -> None:
        plugin = PLUGINS.for_name("burning-wrath")
        self.assertIsNotNone(plugin)
        assert plugin is not None

        matched = PLUGINS.for_identity(
            plugin.title + "（清源推导版）",
            list(reversed(plugin.chapters)),
        )

        self.assertIs(matched, plugin)

    def test_exposes_source_specific_backpack_switch_ids(self) -> None:
        plugin = PLUGINS.for_name("burning-wrath")
        self.assertIsNotNone(plugin)
        assert plugin is not None

        self.assertEqual(
            plugin.backpack_switch.get("ability_ids"),
            ["A63G"],
        )

    def test_matches_blood_mission_207_by_title_and_chapters(self) -> None:
        plugin = PLUGINS.for_name("blood-mission-qh-207")
        self.assertIsNotNone(plugin)
        assert plugin is not None

        matched = PLUGINS.for_identity(
            "血色使命I（淬火试炼）（清源推导版）",
            list(reversed(plugin.chapters)),
        )

        self.assertIs(matched, plugin)
        self.assertEqual(
            plugin.backpack_switch.get("ability_ids"),
            ["A627"],
        )

    def test_rejects_unknown_identity(self) -> None:
        self.assertIsNone(
            PLUGINS.for_identity("unknown", ["unknown.w3x"])
        )


if __name__ == "__main__":
    unittest.main()
