from __future__ import annotations

import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
SCRIPT = ROOT / "scripts" / "talent-test" / "f.j"
GLOBALS = ROOT / "scripts" / "talent-test" / "g.j"


class CampaignTalentBalanceTests(unittest.TestCase):
    def test_missing_snapshot_uses_conservative_legacy_migration(
        self,
    ) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        globals_text = GLOBALS.read_text(encoding="utf-8")
        restore_start = script.index(
            "function TT_CampaignRestoreTalentSnapshot takes unit u"
        )
        missing_start = script.index(
            "if not HaveStoredInteger(",
            restore_start,
        )
        missing_end = script.index("return", missing_start)
        missing_branch = script[missing_start:missing_end]

        self.assertIn(
            "boolean array TT_CAMPAIGN_NATIVE_POINTS_PENDING",
            globals_text,
        )
        self.assertIn(
            "TT_CAMPAIGN_NATIVE_POINTS_PENDING[heroIndex] = true",
            missing_branch,
        )
        self.assertIn(
            "TT_CAMPAIGN_RESTORED_POINTS_UNKNOWN[heroIndex] = true",
            missing_branch,
        )

    def test_snapshot_persists_talent_balance_separately(
        self,
    ) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        store_start = script.index(
            "function TT_CampaignStoreTalentSnapshot takes unit u"
        )
        store_end = script.index("endfunction", store_start)
        store_body = script[store_start:store_end]
        self.assertIn("TT_RegisteredHeroIndex(u)", store_body)
        self.assertIn('snapshotKey + ":unspent"', store_body)
        self.assertIn(
            "set available = TT_UNSPENT_POINTS[heroIndex]",
            store_body,
        )

        restore_start = script.index(
            "function TT_CampaignRestoreTalentSnapshot takes unit u"
        )
        restore_end = script.index("endfunction", restore_start)
        restore_body = script[restore_start:restore_end]
        self.assertIn('snapshotKey + ":unspent"', restore_body)
        self.assertIn(
            "set TT_UNSPENT_POINTS[heroIndex] = unspent",
            restore_body,
        )

    def test_talent_runtime_never_modifies_skill_points(self) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        self.assertNotIn("UnitModifySkillPoints", script)
        self.assertNotIn("SelectHeroSkill", script)
        self.assertNotIn("TT_TrimNativePointsToUnspent", script)
        self.assertNotIn("CAMPAIGN_PANEL_POINTS_TRIM", script)
        self.assertNotIn("CAMPAIGN_ACTIVITY_RECONCILE", script)
        self.assertNotIn("CAMPAIGN_SYNC_RECONCILE", script)

    def test_ui_refresh_does_not_touch_hero_abilities(self) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        refresh_start = script.index(
            "function TT_OnTalentUiRebuildTimer takes nothing returns nothing"
        )
        refresh_end = script.index("endfunction", refresh_start)
        refresh_body = script[refresh_start:refresh_end]

        self.assertNotIn("UnitRemoveAbility", refresh_body)
        self.assertNotIn("UnitAddAbility", refresh_body)
        self.assertNotIn("SetUnitAbilityLevel", refresh_body)
        self.assertNotIn("UnitModifySkillPoints", refresh_body)
        self.assertNotIn("SelectHeroSkill", refresh_body)
        self.assertNotIn("TT_TalentAbilityId(100 + i)", refresh_body)
        self.assertIn(
            "call TT_RevealSelectedTalentAbilities(u)",
            refresh_body,
        )
        self.assertIn("event=TALENT_UI_REFRESH", refresh_body)

    def test_selected_talent_nodes_are_visible_after_restore(
        self,
    ) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        reveal_start = script.index(
            "function TT_RevealSelectedTalentAbilities takes unit u"
        )
        reveal_end = script.index("endfunction", reveal_start)
        reveal_body = script[reveal_start:reveal_end]
        self.assertIn(
            "call BlzUnitHideAbility(u, abilityId, false)",
            reveal_body,
        )
        self.assertIn(
            "event=TALENT_SELECTED_ABILITY_VISIBLE",
            reveal_body,
        )

        restore_start = script.index(
            "function TT_RestoreTalentState takes unit u"
        )
        restore_end = script.index("endfunction", restore_start)
        restore_body = script[restore_start:restore_end]
        self.assertIn(
            "call TT_RevealSelectedTalentAbilities(u)",
            restore_body,
        )

    def test_talent_balance_tracks_awards_and_selected_tiers(
        self,
    ) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        globals_text = GLOBALS.read_text(encoding="utf-8")
        self.assertIn("integer array TT_UNSPENT_POINTS", globals_text)
        self.assertIn("integer array TT_SELECTED_TIER_COUNT", globals_text)
        self.assertIn(
            "set TT_UNSPENT_POINTS[i] = "
            "TT_AwardedCount(i) - TT_SELECTED_TIER_COUNT[i]",
            script,
        )
        self.assertIn("event=TALENT_POINTS_BALANCE", script)

    def test_level_changes_wait_before_issuing_points(self) -> None:
        script = SCRIPT.read_text(encoding="utf-8")
        globals_text = GLOBALS.read_text(encoding="utf-8")
        self.assertIn("integer array TT_POINT_LEVEL_SEEN", globals_text)
        self.assertIn("real array TT_POINT_LEVEL_SINCE", globals_text)
        self.assertIn(
            "if TT_POINT_LEVEL_SEEN[heroIndex] != level then",
            script,
        )
        self.assertIn(
            "now - TT_POINT_LEVEL_SINCE[heroIndex] < 0.75",
            script,
        )
        self.assertIn("event=POINT_LEVEL_WAIT", script)


if __name__ == "__main__":
    unittest.main()
