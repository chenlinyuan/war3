# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

import _campaign_patch_registry as REGISTRY  # noqa: E402
import campaign_plugins  # noqa: E402
from campaign_plugins.wilderness_wrath.chapter_rules import CHAPTERS  # noqa: E402
from campaign_plugins.wilderness_wrath import object_patch as OBJECT_PATCH  # noqa: E402
from campaign_plugins.wilderness_wrath.key_policy import (  # noqa: E402
    MALL_DEFAULT_TRUE,
    MALL_FALSE,
    MALL_TRUE,
)


SOURCE_SHA = (
    "762675a812e20bc45fbe52cc56bf5ca0"
    "145fb9813fee5e68a585b11c77b0c141"
)


class WildernessWrathManifestTest(unittest.TestCase):
    def test_manifest_is_independently_discovered(self) -> None:
        plugin = campaign_plugins.for_source(SOURCE_SHA)
        self.assertIsNotNone(plugin)
        self.assertEqual(plugin.name, "wilderness-wrath")
        self.assertEqual(plugin.title, "荒野之怒")
        self.assertEqual(len(CHAPTERS), 20)
        self.assertEqual(len(MALL_TRUE), 20)
        self.assertEqual(len(MALL_FALSE), 17)
        self.assertFalse(MALL_DEFAULT_TRUE)
        self.assertEqual(
            REGISTRY.backpack_switch_ids("wilderness-wrath"),
            {"A60Q"},
        )

    def test_permanent_artifacts_are_forced_to_zero_charges(self) -> None:
        end = b"\0\0\0\0"
        entries = [
            (1, "crys", "I66I", []),
            (
                1,
                "crys",
                "I66K",
                [("iuse", 0, 0, 0, 3, end)],
            ),
            (
                1,
                "crys",
                "I67E",
                [("iuse", 0, 0, 0, 3, end)],
            ),
        ]
        data = OBJECT_PATCH.OBJ.write_objects_bytes(2, entries, False)
        output, records = REGISTRY.patch_objects(
            "wilderness-wrath",
            data,
            "w3t",
            "kuaitu01.w3x",
        )
        self.assertEqual(
            {str(record["item"]) for record in records},
            {"I66I", "I66K"},
        )
        self.assertEqual(
            REGISTRY.verify_objects(
                "wilderness-wrath",
                output,
                "w3t",
                "kuaitu01.w3x",
                records,
            ),
            [],
        )

        second, second_records = REGISTRY.patch_objects(
            "wilderness-wrath",
            output,
            "w3t",
            "kuaitu01.w3x",
        )
        self.assertEqual(second, output)
        self.assertEqual(second_records, [])


if __name__ == "__main__":
    unittest.main()
