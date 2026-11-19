# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import tempfile
import unittest
from contextlib import contextmanager
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
APP_DIR = ROOT / "tools" / "kk-singleplayer"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(APP_DIR))

import campaign_singleplayer as CONVERTER  # noqa: E402
import _clean_campaign_patches as CLEAN  # noqa: E402
import campaign_plugins as CAMPAIGN_PLUGINS  # noqa: E402
import fix_reforged_portrait_cameras as PORTRAITS  # noqa: E402
from kk_singleplayer_gui import TARGET_CLASSIC, TARGET_REFORGED  # noqa: E402


class ExportTargetTest(unittest.TestCase):
    def test_clean_mode_uses_verified_commerce_policy_not_repair_bundle(self) -> None:
        repair, mall, default_true = CONVERTER.select_campaign_profiles(
            CLEAN.BURNING_WRATH_SHA256,
            clean_rederive=True,
        )

        self.assertIsNone(repair)
        self.assertIsNotNone(mall)
        self.assertEqual(mall.name, "burning-wrath")
        self.assertFalse(default_true)
        self.assertIn("URIZZ4", mall.mall_false)
        self.assertIn("SMZA4774", mall.mall_true)

    def test_clean_mode_defaults_unknown_campaign_keys_to_false(self) -> None:
        repair, mall, default_true = CONVERTER.select_campaign_profiles(
            "0" * 64,
            clean_rederive=True,
        )

        self.assertIsNone(repair)
        self.assertIsNone(mall)
        self.assertFalse(default_true)

    def test_linghan_source_alias_uses_the_same_explicit_policy(self) -> None:
        alias_sha = (
            "7c46b99eae5be7f17ed1fa8264dae6b0"
            "2b3857d51ae70dc8a516d890890dc3f1"
        )

        repair, mall, default_true = CONVERTER.select_campaign_profiles(
            alias_sha,
            clean_rederive=False,
        )

        self.assertIsNotNone(repair)
        self.assertIsNotNone(mall)
        assert repair is not None and mall is not None
        self.assertEqual(repair.name, "linghan-wrath")
        self.assertIn("0000H00006", mall.mall_true)
        self.assertFalse(default_true)

    def test_every_campaign_policy_is_explicit_false_by_default(
        self,
    ) -> None:
        for plugin in CAMPAIGN_PLUGINS.all_plugins():
            policy = plugin.key_policy
            enabled = set(policy.get("true", ()))
            disabled = set(policy.get("false", ()))

            self.assertFalse(policy.get("default"), plugin.name)
            self.assertFalse(enabled & disabled, plugin.name)

            repair, mall, default_true = CONVERTER.select_campaign_profiles(
                plugin.source_sha256,
                clean_rederive=True,
            )
            self.assertIsNone(repair)
            self.assertIsNotNone(mall)
            self.assertEqual(mall.name, plugin.name)
            self.assertFalse(default_true)

    def test_blood_elf_curse_uses_source_locked_false_default_policy(
        self,
    ) -> None:
        plugin = CAMPAIGN_PLUGINS.for_source(
            "3b421e78373db8b11d6c84862d2005d2fd3fa386f73ede0223cdb118ec2a1ac9"
        )

        self.assertIsNotNone(plugin)
        assert plugin is not None
        self.assertEqual(plugin.name, "blood-elf-curse")
        self.assertEqual(plugin.key_policy["true"], [])
        self.assertEqual(
            set(plugin.key_policy["false"]),
            {"A001", "A002", "A003", "A004", "A005", "A006"},
        )
        repair, mall, default_true = CONVERTER.select_campaign_profiles(
            plugin.source_sha256,
            clean_rederive=False,
        )
        self.assertEqual(repair.name, plugin.name)
        self.assertEqual(mall.name, plugin.name)
        self.assertFalse(default_true)

    def test_portrait_repair_replaces_the_map_only_when_models_change(
        self,
    ) -> None:
        with self.subTest("changed"), mock.patch(
            "doctor.models.model_check.fix"
        ) as fix:
            fix.side_effect = self._write_portrait_result
            with self._temporary_map() as map_path:
                records = PORTRAITS.patch(map_path)
                self.assertEqual(map_path.read_bytes(), b"fixed")

        self.assertEqual(records[0]["file"], "portrait.mdx")
        self.assertEqual(records[0]["method"], "camera_removed")

    def test_portrait_repair_leaves_map_untouched_without_matches(self) -> None:
        with mock.patch(
            "doctor.models.model_check.fix",
            return_value={
                "state": "done",
                "fixed": [],
                "not_fixed": [],
                "checked": 0,
            },
        ):
            with self._temporary_map() as map_path:
                records = PORTRAITS.patch(map_path)
                self.assertEqual(map_path.read_bytes(), b"source")

        self.assertEqual(records, [])

    @staticmethod
    def _write_portrait_result(
        _source: str,
        output: str,
        *,
        what: tuple[str, ...],
    ) -> dict[str, object]:
        assert what == ("portrait_camera",)
        Path(output).write_bytes(b"fixed")
        return {
            "state": "done",
            "fixed": [
                {
                    "file": "portrait.mdx",
                    "method": "camera_removed",
                }
            ],
            "not_fixed": [],
            "checked": 1,
        }

    @staticmethod
    @contextmanager
    def _temporary_map():
        with tempfile.TemporaryDirectory(prefix="portrait-test-") as directory:
            map_path = Path(directory) / "chapter.w3x"
            map_path.write_bytes(b"source")
            yield map_path

    def test_source_target_preserves_map_info_and_uses_source_suffix(
        self,
    ) -> None:
        source = b"source-war3map.w3i"
        with mock.patch.object(CONVERTER.RM, "migrated_map_info") as migrate:
            output, status = CONVERTER.prepare_campaign_map_info(
                source,
                "chapter.w3x",
                CONVERTER.TARGET_SOURCE,
            )

        self.assertEqual(output, source)
        self.assertEqual(status, "preserved source map-info for source")
        self.assertEqual(
            CONVERTER.campaign_output_title(
                "campaign",
                CONVERTER.TARGET_SOURCE,
            ),
            "alas campaign",
        )
        self.assertEqual(
            CONVERTER.campaign_output_title(
                "campaign",
                CONVERTER.TARGET_SOURCE,
                clean_rederive=True,
            ),
            "alas campaign",
        )
        migrate.assert_not_called()

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

    def test_reforged_migration_accepts_legacy_v18_map_info(self) -> None:
        legacy = {
            "version": 18,
            "saves": 0,
            "editor_version": 6031,
            "name": b"legacy",
            "author": b"author",
            "description": b"",
            "players_recommended": b"",
            "camera_bounds": [0.0] * 8,
            "camera_complements": [0] * 4,
            "width": 64,
            "height": 64,
            "flags": 0,
            "tileset": b"L",
            "loading_bg": 0,
            "loading_text": b"",
            "loading_title": b"",
            "loading_subtitle": b"",
            "loading_number": 0,
            "prologue_text": b"",
            "prologue_title": b"",
            "prologue_subtitle": b"",
            "players": [],
            "forces": [],
            "upgrades": [],
            "techs": [],
            "random_unit_groups": [],
        }
        source = CONVERTER.RM.W3I.write(legacy, version=18)

        migrated, status = CONVERTER.RM.migrated_map_info(
            source,
            "legacy.w3x",
        )
        parsed = CONVERTER.RM.W3I.parse(migrated)

        self.assertIn("v18", status)
        self.assertEqual(parsed["version"], 31)
        self.assertEqual(
            (parsed["game_data_set"], parsed["game_data_version"]),
            (2, 2),
        )

    @unittest.skip("superseded by test_campaign_titles")
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

    def test_legacy_critical_prop_invulnerability_is_always_removed(self) -> None:
        text = """function CreateAllUnits takes nothing returns nothing
    set gg_unit_E009_0029 = CreateUnit(Player(0), 'E009', 0.0, 0.0, 0.0)
    call SetUnitInvulnerable(gg_unit_E009_0029, true) // IB: critical prop must not die
endfunction
function FailActions takes nothing returns nothing
    call CustomDefeatBJ(Player(0), "失败!")
endfunction
function InitFail takes nothing returns nothing
    set gg_trg_Fail = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Fail, gg_unit_E009_0029, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Fail, function FailActions)
endfunction
"""
        output, stats = CONVERTER.patch_chapter_script(
            text,
            "aelzh01.w3x",
            critical_props_enabled=False,
        )

        self.assertEqual(
            stats["critical_prop_invulnerabilities_removed"],
            1,
        )
        self.assertNotIn("IB: critical prop must not die", output)
        self.assertNotIn("SetUnitInvulnerable(gg_unit_E009_0029, true)", output)
        self.assertIn("call CustomDefeatBJ(Player(0)", output)


if __name__ == "__main__":
    unittest.main()
