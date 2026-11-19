# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path


APP_DIR = Path(__file__).resolve().parents[1]
ROOT = APP_DIR.parents[1]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(APP_DIR))
sys.path.insert(0, str(INJECTOR))

import campaign_catalog as CATALOG  # noqa: E402
import campaign_singleplayer as CONVERTER  # noqa: E402


class CampaignCatalogTest(unittest.TestCase):
    def test_discovers_campaigns_recursively_and_ignores_maps(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            root = Path(directory)
            (root / "nested").mkdir()
            (root / "alpha.w3n").write_bytes(b"a")
            (root / "nested" / "beta.W3N").write_bytes(b"bb")
            (root / "nested" / "chapter.w3x").write_bytes(b"x")

            files = CATALOG.discover_campaign_files(root)

        self.assertEqual([item.filename for item in files], ["alpha.w3n", "beta.W3N"])

    def test_non_recursive_scan_only_returns_direct_campaigns(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            root = Path(directory)
            (root / "nested").mkdir()
            (root / "alpha.w3n").write_bytes(b"a")
            (root / "nested" / "beta.w3n").write_bytes(b"b")

            files = CATALOG.discover_campaign_files(root, recursive=False)

        self.assertEqual([item.filename for item in files], ["alpha.w3n"])

    def test_recursive_scan_can_prune_generated_work_directories(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            root = Path(directory)
            work = root / "_singleplayer_work"
            work.mkdir()
            (root / "alpha.w3n").write_bytes(b"a")
            (work / "generated.w3n").write_bytes(b"b")

            files = CATALOG.discover_campaign_files(
                root,
                excluded_directories={"_singleplayer_work"},
            )

        self.assertEqual([item.filename for item in files], ["alpha.w3n"])

    def test_cache_requires_matching_size_and_timestamp(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            path = Path(directory) / "campaign.w3n"
            path.write_bytes(b"first")
            info = CATALOG.discover_campaign_files(path)[0]
            cache = {
                str(path.resolve()): CATALOG.cache_record(
                    info,
                    {"title": "缓存的战役", "chapter_count": 9},
                )
            }

            self.assertEqual(
                CATALOG.cached_payload(cache, info),
                {"title": "缓存的战役", "chapter_count": 9},
            )
            path.write_bytes(b"second-version")
            changed = CATALOG.discover_campaign_files(path)[0]
            self.assertIsNone(CATALOG.cached_payload(cache, changed))

    def test_row_uses_campaign_title_instead_of_numeric_filename(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            root = Path(directory)
            path = root / "194213.w3n"
            path.write_bytes(b"1234")
            info = CATALOG.discover_campaign_files(root)[0]
            values = CATALOG.row_values(
                info,
                {"title": "|cFFFFFF00燃烧之怒|r", "chapter_count": 25},
                "可用",
                root,
            )

        self.assertEqual(values[0], "燃烧之怒")
        self.assertEqual(values[1], "25")
        self.assertEqual(values[5], "194213.w3n")

    def test_exact_selected_campaign_files_override_directory_scan(self) -> None:
        with tempfile.TemporaryDirectory(prefix="campaign-catalog-") as directory:
            root = Path(directory)
            nested = root / "nested"
            nested.mkdir()
            first = root / "first.w3n"
            second = nested / "second.w3n"
            first.write_bytes(b"first")
            second.write_bytes(b"second")

            selected = CONVERTER.discover_campaigns(
                root,
                [str(second), str(first), str(second)],
            )

        self.assertEqual(selected, [second.resolve(), first.resolve()])


if __name__ == "__main__":
    unittest.main()
