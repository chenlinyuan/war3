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
        self.assertEqual(
            CONVERTER.campaign_output_title(
                "燃烧之怒",
                TARGET_REFORGED,
                clean_rederive=True,
            ),
            "燃烧之怒（清源推导版）",
        )
        self.assertEqual(
            CONVERTER.campaign_output_title(
                "燃烧之怒",
                TARGET_CLASSIC,
                clean_rederive=True,
            ),
            "燃烧之怒（清源推导版·经典版）",
        )

    def test_unknown_target_is_rejected(self) -> None:
        with self.assertRaises(CONVERTER.BuildError):
            CONVERTER.prepare_campaign_map_info(b"data", "chapter.w3x", "unknown")
        with self.assertRaises(CONVERTER.BuildError):
            CONVERTER.campaign_output_title("campaign", "unknown")

    def test_clean_rederive_disables_legacy_critical_prop_rewrite(self) -> None:
        text = """function CreateAllUnits takes nothing returns nothing
    set gg_unit_npgr_0732 = CreateUnit(Player(1), 'npgr', 0.0, 0.0, 0.0)
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
        output, stats = CONVERTER.patch_chapter_script(
            text,
            "ransao03.w3m",
            critical_props_enabled=False,
        )

        self.assertEqual(stats["critical_props"], 0)
        self.assertFalse(stats["critical_props_enabled"])
        self.assertNotIn("IB: critical prop must not die", output)
        self.assertNotIn("IB: critical prop death is no longer fatal", output)
        self.assertIn("call CustomDefeatBJ(Player(0)", output)


if __name__ == "__main__":
    unittest.main()
