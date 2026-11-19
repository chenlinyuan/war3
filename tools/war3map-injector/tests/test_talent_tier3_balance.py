from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import build_losttemple_talent_tree as TALENT  # noqa: E402


class TierThreeTalentBalanceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.entries = {
            str(entry["new"]): entry
            for entry in TALENT.build_entries()
        }

    @staticmethod
    def field(ident: str, field_id: str, level: int = 1) -> object:
        entry = TierThreeTalentBalanceTests.entries[ident]
        return next(
            mod[4]
            for mod in entry["mods"]
            if mod[0] == field_id and mod[2] == level
        )

    def test_tier_three_values(self) -> None:
        self.assertEqual(self.field("T103", "Isx1"), 0.50)
        self.assertEqual(self.field("T104", "Imvb"), 100)
        self.assertEqual(self.field("T208", "Isx1"), 0.25)
        self.assertEqual(self.field("T209", "Imvb"), 50)

    def test_hybrid_is_half_of_both_specializations(self) -> None:
        self.assertEqual(
            self.field("T208", "Isx1") * 2,
            self.field("T103", "Isx1"),
        )
        self.assertEqual(
            self.field("T209", "Imvb") * 2,
            self.field("T104", "Imvb"),
        )

    def test_tooltips_match_the_object_values(self) -> None:
        self.assertEqual(
            self.field("T103", "aub1"),
            "攻击速度 +50%。",
        )
        self.assertEqual(
            self.field("T104", "aub1"),
            "移动速度 +100。",
        )
        self.assertEqual(
            self.field("T105", "aub1"),
            "攻击速度 +25%，移动速度 +50。",
        )


if __name__ == "__main__":
    unittest.main()
