from __future__ import annotations

import sys
import unittest
from pathlib import Path


APP_DIR = Path(__file__).resolve().parents[1]
ROOT = APP_DIR.parents[1]
sys.path.insert(0, str(APP_DIR))
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))
sys.path.insert(0, str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"))

import offline_core  # noqa: E402


class OfflineOutputNameTests(unittest.TestCase):
    def test_map_fallback_uses_alas_prefix_and_original_stem(self) -> None:
        self.assertEqual(
            offline_core.suggested_output_name(
                Path("娜迦之怒（提取版）.w3x")
            ),
            "alas 娜迦之怒.w3x",
        )

    def test_existing_alas_prefix_is_not_duplicated(self) -> None:
        self.assertEqual(
            offline_core.suggested_output_name(
                Path("alas 娜迦之怒.w3x")
            ),
            "alas 娜迦之怒.w3x",
        )


if __name__ == "__main__":
    unittest.main()
