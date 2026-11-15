# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
APP_DIR = ROOT / "tools" / "kk-singleplayer"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(APP_DIR))

import campaign_singleplayer as CONVERTER  # noqa: E402
from kk_singleplayer_gui import TARGET_CLASSIC, TARGET_REFORGED  # noqa: E402


class ExportTargetTest(unittest.TestCase):
    def test_classic_preserves_source_map_info_without_migration(self) -> None:
        source = b"classic-war3map.w3i"
        with mock.patch.object(CONVERTER.RM, "migrated_map_info") as migrate:
            output, status = CONVERTER.prepare_campaign_map_info(
                source,
                "chapter.w3x",
                TARGET_CLASSIC,
            )

        self.assertEqual(output, source)
        self.assertIn("preserved", status)
        migrate.assert_not_called()

    def test_reforged_uses_existing_map_info_migration(self) -> None:
        source = b"legacy-war3map.w3i"
        migrated = b"reforged-war3map.w3i"
        with mock.patch.object(
            CONVERTER.RM,
            "migrated_map_info",
            return_value=(migrated, "v25 -> v31"),
        ) as migrate:
            output, status = CONVERTER.prepare_campaign_map_info(
                source,
                "chapter.w3x",
                TARGET_REFORGED,
            )

        self.assertEqual(output, migrated)
        self.assertEqual(status, "v25 -> v31")
        migrate.assert_called_once_with(source, "chapter.w3x")

    def test_output_titles_distinguish_generation_and_keep_reforged_name(self) -> None:
        self.assertEqual(
            CONVERTER.campaign_output_title("娜迦之怒", TARGET_REFORGED),
            "娜迦之怒（单机修复版）",
        )
        self.assertEqual(
            CONVERTER.campaign_output_title("娜迦之怒", TARGET_CLASSIC),
            "娜迦之怒（单机修复版·经典版）",
        )

    def test_unknown_target_is_rejected(self) -> None:
        with self.assertRaises(CONVERTER.BuildError):
            CONVERTER.prepare_campaign_map_info(b"data", "chapter.w3x", "unknown")
        with self.assertRaises(CONVERTER.BuildError):
            CONVERTER.campaign_output_title("campaign", "unknown")


if __name__ == "__main__":
    unittest.main()
