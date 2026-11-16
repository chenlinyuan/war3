# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import _patch_permanent_item_charges as CHARGES  # noqa: E402
from doctor.data import objects  # noqa: E402


END = b"\0\0\0\0"


def item(name: str, item_id: str, fields: list[tuple]) -> bytes:
    del name
    return objects.write_objects_bytes(
        1,
        [(1, "desc", item_id, fields)],
        False,
    )


class PermanentItemChargeTest(unittest.TestCase):
    def test_artifact_active_is_forced_permanent(self) -> None:
        data = item(
            "军团手环（神器）",
            "A001",
            [
                ("unam", 3, 0, 0, "军团手环（神器）".encode(), END),
                ("iabi", 3, 0, 0, b"A001", END),
                ("icid", 3, 0, 0, b"A001", END),
                ("iuse", 0, 0, 0, 3, END),
            ],
        )
        output, records = CHARGES.patch(data, "w3t")
        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]["previous"], 3)
        self.assertEqual(CHARGES.verify(output, "w3t", records), [])

    def test_consumable_charges_are_preserved(self) -> None:
        data = item(
            "大型恢复药水",
            "A002",
            [
                ("unam", 3, 0, 0, "大型恢复药水".encode(), END),
                ("iabi", 3, 0, 0, b"A002", END),
                ("icid", 3, 0, 0, b"A002", END),
                ("iuse", 0, 0, 0, 2, END),
            ],
        )
        output, records = CHARGES.patch(data, "w3t")
        self.assertEqual(output, data)
        self.assertEqual(records, [])

    def test_passive_item_without_active_ability_is_preserved(self) -> None:
        data = item(
            "军团徽记",
            "A003",
            [
                ("unam", 3, 0, 0, "军团徽记".encode(), END),
                ("iuse", 0, 0, 0, 3, END),
            ],
        )
        output, records = CHARGES.patch(data, "w3t")
        self.assertEqual(output, data)
        self.assertEqual(records, [])


if __name__ == "__main__":
    unittest.main()
