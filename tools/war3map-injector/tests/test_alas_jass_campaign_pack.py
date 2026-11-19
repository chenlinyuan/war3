from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import port_alas_jass_campaign as CAMPAIGN  # noqa: E402


class AlasJassCampaignPackTests(unittest.TestCase):
    def test_final_pack_preserves_protected_campaign_root(self) -> None:
        args = CAMPAIGN.final_pack_args(
            Path("source.w3n"),
            Path("work"),
            Path("output.w3n"),
        )

        self.assertEqual(str(args[-1]), "--chapters-only")
        self.assertIn("pack", [str(value) for value in args])
        self.assertIn("source.w3n", [str(value) for value in args])
        self.assertIn("output.w3n", [str(value) for value in args])

    def test_campaign_pipeline_applies_loading_art_fixes(self) -> None:
        source = (
            INJECTOR / "port_alas_jass_campaign.py"
        ).read_text(encoding="utf-8")

        self.assertIn("LOADING_ART.chapter_loading_patches(chapter)", source)
        self.assertIn(
            "LOADING_ART.campaign_background_patches(source)",
            source,
        )
        self.assertIn("patch_campaign_root_files(output, background_patches", source)
        self.assertIn('"--skip-loading-art"', source)
        self.assertIn('"loading/score backgrounds:"', source)

    def test_campaign_root_patch_uses_output_volume_temp_file(self) -> None:
        expected = {b"zhutitupian33333.blp": b"background"}
        observed_out_path: Path | None = None

        class FakeArchive:
            def __init__(self, _path: str) -> None:
                pass

            def read_file(self, internal: str) -> bytes | None:
                return expected.get(internal.encode("utf-8"))

            def close(self) -> None:
                pass

        def fake_patch(
            _map_path: str,
            _patches: list[tuple[str, bytes]],
            *,
            out_path: str,
            backup: bool,
        ) -> str:
            nonlocal observed_out_path
            self.assertFalse(backup)
            observed_out_path = Path(out_path)
            observed_out_path.write_bytes(b"patched campaign")
            return out_path

        with tempfile.TemporaryDirectory() as temp_dir:
            output = Path(temp_dir) / "alas test.w3n"
            output.write_bytes(b"original campaign")
            with (
                mock.patch.object(CAMPAIGN.MP, "patch", side_effect=fake_patch),
                mock.patch.object(CAMPAIGN.W, "MPQArchive", FakeArchive),
            ):
                CAMPAIGN.patch_campaign_root_files(
                    output,
                    [("zhutitupian33333.blp", b"background")],
                    Path("different-volume-work"),
                )

            self.assertIsNotNone(observed_out_path)
            assert observed_out_path is not None
            self.assertEqual(observed_out_path.parent, output.parent)
            self.assertEqual(output.read_bytes(), b"patched campaign")
            self.assertFalse(observed_out_path.exists())


if __name__ == "__main__":
    unittest.main()
