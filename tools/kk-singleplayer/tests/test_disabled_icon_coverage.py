# -*- coding: utf-8 -*-
from __future__ import annotations

import struct
import sys
import unittest
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import fix_campaign_object_icons as ICONS  # noqa: E402


class FakeArchive:
    def __init__(self, files: dict[str, bytes]) -> None:
        self._files = {name.casefold(): data for name, data in files.items()}
        self.closed = False

    def read_file(self, name: str):
        return self._files.get(name.casefold())

    def close(self) -> None:
        self.closed = True


class DisabledIconFallbackTest(unittest.TestCase):
    def test_scans_local_upgrade_and_skin_object_icons(self) -> None:
        value = rb"war3mapImported\BTNUpgrade.blp"
        upgrade = (
            b"gar1"
            + struct.pack("<i", 3)
            + struct.pack("<ii", 0, 0)
            + value
            + b"\0"
        )
        skin_unit = (
            b"uico"
            + struct.pack("<i", 3)
            + rb"war3mapImported\BTNSkinUnit.blp"
            + b"\0"
        )
        archive = FakeArchive(
            {
                "war3map.w3q": upgrade,
                "war3mapSkin.w3u": skin_unit,
            }
        )

        refs = ICONS.collect_icon_refs(archive)

        self.assertIn(
            ("w3q", 0, "gar1", r"war3mapImported\BTNUpgrade.blp"),
            refs,
        )
        self.assertIn(
            ("w3u", 0, "uico", r"war3mapImported\BTNSkinUnit.blp"),
            refs,
        )

    def test_resolves_icon_when_object_value_omits_extension(self) -> None:
        archive = FakeArchive(
            {r"war3mapImported\BTNIcon.blp": b"BLP1-icon"}
        )
        files = ICONS.ArchiveFiles(archive)

        original = ICONS.resolve_icon(
            files,
            r"war3mapImported\BTNIcon",
        )

        self.assertEqual(original, r"war3mapImported\BTNIcon.blp")

    def test_resolves_enabled_icon_from_parent_campaign(self) -> None:
        local_archive = FakeArchive({})
        campaign_archive = FakeArchive(
            {r"war3campImported\BTNIcon.blp": b"BLP1-icon"}
        )
        local = ICONS.ArchiveFiles(local_archive)
        campaign = ICONS.ArchiveFiles(campaign_archive)

        original, source = ICONS.resolve_icon_with_fallback(
            local,
            campaign,
            r"war3campImported\BTNIcon.blp",
        )

        self.assertEqual(original, r"war3campImported\BTNIcon.blp")
        self.assertIs(source, campaign)

    def test_chapter_patch_writes_aliases_locally_from_campaign_asset(self) -> None:
        map_archive = FakeArchive({})
        campaign_archive = FakeArchive(
            {r"war3campImported\BTNIcon.blp": b"BLP1-icon"}
        )
        with (
            mock.patch.object(
                ICONS.W,
                "MPQArchive",
                side_effect=[map_archive, campaign_archive],
            ),
            mock.patch.object(
                ICONS,
                "collect_icon_refs",
                return_value=[
                    (
                        "w3a",
                        0,
                        "aart",
                        r"war3campImported\BTNIcon.blp",
                    )
                ],
            ),
            mock.patch.object(
                ICONS,
                "darken_icon",
                return_value=b"BLP1-disabled",
            ),
        ):
            info = ICONS.build_chapter_patch("chapter.w3x", "campaign.w3n")

        patch_names = dict(info[4])
        self.assertEqual(
            patch_names[r"war3campImported\DISBTNIcon.blp"],
            b"BLP1-disabled",
        )
        self.assertIn(
            r"ReplaceableTextures\CommandButtonsDisabled\DISBTNIcon.blp",
            patch_names,
        )
        self.assertTrue(map_archive.closed)
        self.assertTrue(campaign_archive.closed)


if __name__ == "__main__":
    unittest.main()
