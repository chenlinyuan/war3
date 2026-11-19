from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(INJECTOR))

import campaign_singleplayer as CONVERTER  # noqa: E402
import fix_alas_campaign_names as NAMES  # noqa: E402


class CampaignTitleTests(unittest.TestCase):
    def test_only_original_name_and_alas_prefix_remain(self) -> None:
        cases = {
            "娜迦之怒": "alas 娜迦之怒",
            "alas 娜迦之怒": "alas 娜迦之怒",
            "alas娜迦之怒": "alas 娜迦之怒",
            "alasArthas": "alas Arthas",
            "娜迦之怒（提取版）": "alas 娜迦之怒",
            "娜迦之怒（单机修复版·经典版）": "alas 娜迦之怒",
            "娜迦之怒（清源推导版）": "alas 娜迦之怒",
            "娜迦之怒（全配音·资源修复·载入图汉化）": "alas 娜迦之怒",
            "娜迦之怒-物品技能翅膀版": "alas 娜迦之怒",
        }
        for value, expected in cases.items():
            self.assertEqual(NAMES.alas_campaign_title(value), expected)

    def test_original_parenthetical_name_is_preserved(self) -> None:
        self.assertEqual(
            NAMES.alas_campaign_title("血色使命（淬火试炼）2.07"),
            "alas 血色使命（淬火试炼）2.07",
        )

    def test_every_export_target_uses_same_plain_title(self) -> None:
        for target in CONVERTER.TARGET_CHOICES:
            self.assertEqual(
                CONVERTER.campaign_output_title("娜迦之怒", target),
                "alas 娜迦之怒",
            )
            self.assertEqual(
                CONVERTER.campaign_output_title(
                    "娜迦之怒（单机修复版）",
                    target,
                    clean_rederive=True,
                ),
                "alas 娜迦之怒",
            )


if __name__ == "__main__":
    unittest.main()
