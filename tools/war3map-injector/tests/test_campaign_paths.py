from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import campaign_paths as C  # noqa: E402


class CampaignMetadataTests(unittest.TestCase):
    def test_order_chapter_names_uses_authored_order(self) -> None:
        names = ["c.w3m", "a.w3x", "b.w3x"]
        ordered = C.order_chapter_names(
            names,
            ["b.w3x", "c.w3m", "a.w3x"],
        )
        self.assertEqual(ordered, ["b.w3x", "c.w3m", "a.w3x"])

    def test_order_chapter_names_matches_basename(self) -> None:
        ordered = C.order_chapter_names(
            [r"z\chapter.w3x", "other.w3x"],
            ["chapter.w3x"],
        )
        self.assertEqual(ordered[0], r"z\chapter.w3x")

    def test_wts_strings_and_trigger_resolution(self) -> None:
        title = "\u5f00\u5934\u7535\u5f71"
        strings = C._campaign_wts_strings(
            ("STRING 25\r\n{\r\n%s\r\n}\r\n" % title).encode("gbk")
        )
        self.assertEqual(strings[25], title)
        self.assertEqual(
            C._resolve_campaign_text("TRIGSTR_25", strings),
            title,
        )


if __name__ == "__main__":
    unittest.main()
