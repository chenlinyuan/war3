from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import wild_equipment_drops as WED  # noqa: E402


class HeroDropTuningTests(unittest.TestCase):
    def test_stage_boundaries(self) -> None:
        self.assertEqual(WED.hero_drop_stage(0), 0)
        self.assertEqual(WED.hero_drop_stage(31), 0)
        self.assertEqual(WED.hero_drop_stage(32), 1)
        self.assertEqual(WED.hero_drop_stage(57), 1)
        self.assertEqual(WED.hero_drop_stage(58), 2)
        self.assertEqual(WED.hero_drop_stage(84), 2)
        self.assertEqual(WED.hero_drop_stage(85), 3)
        self.assertEqual(WED.hero_drop_stage(100), 3)

    def test_every_stage_exposes_all_qualities(self) -> None:
        for weights in WED.HERO_DROP_WEIGHTS:
            self.assertEqual(len(weights), 5)
            self.assertTrue(all(weight > 0 for weight in weights))
            self.assertEqual(sum(weights), 100)

    def test_boss_uses_next_stage_weights(self) -> None:
        first = WED.hero_drop_tuning(0)
        self.assertEqual(first.stage, 0)
        self.assertEqual(first.chance, 40)
        self.assertEqual(first.weights, WED.HERO_DROP_WEIGHTS[0])
        self.assertEqual(
            first.boss_weights,
            WED.HERO_DROP_WEIGHTS[1],
        )

        final = WED.hero_drop_tuning(100)
        self.assertEqual(final.stage, 3)
        self.assertEqual(final.chance, 70)
        self.assertEqual(final.boss_weights, final.weights)

    def test_boss_level_uses_upper_quarter(self) -> None:
        self.assertEqual(WED.hero_boss_level(20), 15)
        self.assertEqual(WED.hero_boss_level(10), 8)
        self.assertEqual(WED.hero_boss_level(1), 1)

    def test_weighted_script_uses_one_roll_ladder(self) -> None:
        tuning = WED.hero_drop_tuning(0)
        script = WED._weighted_roll_function(
            "WED_HeroTier",
            tuning.weights,
        )
        self.assertEqual(
            WED._script_weight_thresholds(script),
            (35, 79, 94, 99),
        )
        self.assertEqual(script.count("GetRandomInt"), 1)

    def test_generated_campaign_hero_path_has_no_extra_orange_roll(
        self,
    ) -> None:
        tuning = WED.hero_drop_tuning(0)
        profile = WED.CampaignDropProfile(
            chapter="chapter.w3x",
            chapter_index=1,
            chapter_count=16,
            level_cap=20,
            hero_level_cap=20,
            chapter_level_cap=10,
            chapter_hero_level_cap=20,
            chapter_progress=0,
            drop_stage=tuning.stage,
            hero_drop_chance=tuning.chance,
            hero_drop_limit=WED.HERO_DROP_LIMIT,
            hero_boss_level=15,
            hero_weights=tuning.weights,
            hero_boss_weights=tuning.boss_weights,
            counts={},
            script_dir=Path("."),
        )
        pools = {
            name: ["A001"]
            for name in WED.POOL_NAMES
        }
        script = WED._campaign_script_functions(pools, profile)
        self.assertNotIn("WED_HeroOrangeChance", script)
        self.assertIn(
            "GetRandomInt(1, 100) <= WED_HERO_DROP_CHANCE",
            script,
        )
        self.assertIn("WED_HERO_DROP_COUNT < WED_HERO_DROP_LIMIT", script)
        self.assertIn(
            "GetUnitLevel(victim) >= WED_HERO_BOSS_LEVEL",
            script,
        )

    def test_generated_drops_use_the_item_native_ground_model(self) -> None:
        pools = {
            name: ["A001"]
            for name in WED.POOL_NAMES
        }
        script = WED._script_functions(pools)

        self.assertIn("call CreateItem(ident, x, y)", script)
        self.assertNotIn("AddSpecialEffect", script)
        self.assertNotIn("ItemRarityTG5.pkfx", script)
        self.assertNotIn("WED_LOOT_BEAM_TIMER", script)


if __name__ == "__main__":
    unittest.main()
