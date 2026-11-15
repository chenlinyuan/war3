# -*- coding: utf-8 -*-
from __future__ import annotations

import unittest

import fix_campaign_object_icons as ICONS


class DisabledIconCandidateTest(unittest.TestCase):
    def test_custom_icon_covers_shop_and_command_card_paths(self) -> None:
        candidates = ICONS.disabled_candidates(
            r"war3campImported\CustomIcon.blp"
        )
        self.assertIn(
            r"war3campImported\DISCustomIcon.blp",
            candidates,
        )
        self.assertIn(
            r"war3campImported\DISBTNCustomIcon.blp",
            candidates,
        )
        self.assertIn(
            r"ReplaceableTextures\CommandButtonsDisabled\DISCustomIcon.blp",
            candidates,
        )
        self.assertIn(
            r"ReplaceableTextures\CommandButtonsDisabled\DISBTNCustomIcon.blp",
            candidates,
        )

    def test_btn_icon_gets_double_btn_disabled_name(self) -> None:
        candidates = ICONS.disabled_candidates(
            r"war3campImported\BTNIcon.blp"
        )
        self.assertIn(
            r"war3campImported\DISBTNIcon.blp",
            candidates,
        )
        self.assertNotIn(
            r"war3campImported\DISBTNBTNIcon.blp",
            candidates,
        )


if __name__ == "__main__":
    unittest.main()
