from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import campaign_singleplayer as CAMPAIGN  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402


END = b"\0\0\0\0"


def unit_object(
    ident: str,
    fields: list[tuple],
) -> bytes:
    return OBJ.write_objects_bytes(
        1,
        [
            (
                1,
                "hfoo",
                ident,
                fields,
            )
        ],
        False,
    )


class CampaignObjectStringScopeTests(unittest.TestCase):
    def test_same_trigstr_id_uses_map_and_campaign_namespaces(self) -> None:
        local = unit_object(
            "U009",
            [("unam", 3, 0, 0, b"TRIGSTR_42", END)],
        )
        campaign = unit_object(
            "H000",
            [("unam", 3, 0, 0, b"TRIGSTR_42", END)],
        )

        resolved_local, resolved_campaign = (
            CAMPAIGN.resolve_scoped_object_strings(
                local,
                campaign,
                "w3u",
                {42: "寒冰守护者"},
                {42: "嗜血之怒(W)"},
            )
        )

        self.assertIn("寒冰守护者".encode("utf-8"), resolved_local)
        self.assertNotIn("嗜血之怒".encode("utf-8"), resolved_local)
        self.assertIn("嗜血之怒(W)".encode("utf-8"), resolved_campaign)
        self.assertNotIn("寒冰守护者".encode("utf-8"), resolved_campaign)
        self.assertNotIn(b"TRIGSTR_", resolved_local)
        self.assertNotIn(b"TRIGSTR_", resolved_campaign)

    def test_missing_local_string_is_not_filled_from_campaign_table(self) -> None:
        local = unit_object(
            "U009",
            [("unam", 3, 0, 0, b"TRIGSTR_42", END)],
        )
        campaign = unit_object(
            "H000",
            [("unam", 3, 0, 0, b"TRIGSTR_42", END)],
        )

        resolved_local, _resolved_campaign = (
            CAMPAIGN.resolve_scoped_object_strings(
                local,
                campaign,
                "w3u",
                {},
                {42: "战役名称"},
            )
        )

        self.assertIn(b"TRIGSTR_42", resolved_local)
        self.assertNotIn("战役名称".encode("utf-8"), resolved_local)

    def test_combines_inherited_and_chapter_override_fields(self) -> None:
        local = unit_object(
            "H66E",
            [
                ("uhpm", 0, 0, 0, 200000, END),
                ("usca", 1, 0, 0, 2.5, END),
            ],
        )
        campaign = unit_object(
            "H66E",
            [
                ("unam", 3, 0, 0, "血精灵领袖".encode("utf-8"), END),
                ("upro", 3, 0, 0, "西沃科".encode("utf-8"), END),
                ("uhpm", 0, 0, 0, 100, END),
                ("umdl", 3, 0, 0, b"war3campImported\\lich.mdl", END),
            ],
        )

        combined, original_count, custom_count = (
            CAMPAIGN.combine_scoped_campaign_objects(
                local,
                campaign,
                "w3u",
            )
        )
        _version, entries, _consumed = OBJ.read_objects_bytes(
            combined,
            False,
            fname="combined",
            with_end=True,
        )

        self.assertEqual(original_count, 0)
        self.assertEqual(custom_count, 1)
        fields = {
            mod[0]: mod[4]
            for mod in entries[0][3]
        }
        self.assertEqual(fields["unam"], "血精灵领袖".encode("utf-8"))
        self.assertEqual(fields["upro"], "西沃科".encode("utf-8"))
        self.assertEqual(fields["uhpm"], 200000)
        self.assertEqual(fields["usca"], 2.5)
        self.assertEqual(
            fields["umdl"],
            b"war3campImported\\lich.mdl",
        )


if __name__ == "__main__":
    unittest.main()
