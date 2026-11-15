# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


APP_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(APP_DIR))

from kk_singleplayer_gui import format_campaign_preview  # noqa: E402


class CampaignPreviewTest(unittest.TestCase):
    def test_numeric_filename_displays_resolved_campaign_identity(self) -> None:
        title, details = format_campaign_preview(
            {
                "filename": "194213.w3n",
                "title": "燃烧之怒v烈焰降临（更新）",
                "author": "小佳",
                "hm3w_title": "",
                "chapter_count": 25,
                "source_sha256": "1ccd780a0c151921a62be3f458de9aa6",
            }
        )

        self.assertEqual(title, "战役名称：燃烧之怒v烈焰降临（更新）")
        self.assertIn("作者：小佳", details)
        self.assertIn("章节：25", details)
        self.assertIn("源文件：194213.w3n", details)
        self.assertIn("SHA-256：1ccd780a", details)

    def test_platform_title_is_only_shown_when_different(self) -> None:
        _title, details = format_campaign_preview(
            {
                "filename": "209521.w3n",
                "title": "荒野之怒",
                "author": "小佳",
                "hm3w_title": "荒野之怒（KK平台）",
                "chapter_count": 19,
                "source_sha256": "",
            }
        )
        self.assertIn("平台标题：荒野之怒（KK平台）", details)

        _title, same_details = format_campaign_preview(
            {
                "filename": "1.w3n",
                "title": "同名战役",
                "hm3w_title": "同名战役",
                "chapter_count": 1,
            }
        )
        self.assertNotIn("平台标题：", same_details)

    def test_platform_title_color_codes_do_not_create_a_false_difference(self) -> None:
        _title, details = format_campaign_preview(
            {
                "filename": "209521.w3n",
                "title": "荒野之怒",
                "hm3w_title": "|cFFFFFF00荒野之怒",
                "chapter_count": 20,
            }
        )
        self.assertNotIn("平台标题：", details)
        self.assertNotIn("|cFFFFFF00", details)


if __name__ == "__main__":
    unittest.main()
