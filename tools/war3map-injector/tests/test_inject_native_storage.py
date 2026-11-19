from __future__ import annotations

import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]


class InjectNativeStorageTests(unittest.TestCase):
    def test_in_place_write_uses_atomic_rename_for_verify_base(self) -> None:
        source = (INJECTOR / "inject_native.py").read_text(encoding="utf-8")

        self.assertIn("os.replace(map_path, tmp_before)", source)
        self.assertNotIn("shutil.copy2(map_path, tmp_before)", source)
        self.assertIn(
            "patch_source = tmp_before if target == map_path else target",
            source,
        )
        self.assertIn(
            "patch_output = map_path if target == map_path else None",
            source,
        )

    def test_failed_write_restores_original_map(self) -> None:
        source = (INJECTOR / "inject_native.py").read_text(encoding="utf-8")

        self.assertIn("if tmp_before and os.path.exists(tmp_before):", source)
        self.assertIn("os.replace(tmp_before, map_path)", source)
        self.assertIn("if not ok:", source)


if __name__ == "__main__":
    unittest.main()
