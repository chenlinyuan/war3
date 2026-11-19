from __future__ import annotations

import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


APP = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(APP))

import offline_core  # noqa: E402


class CacheRootTests(unittest.TestCase):
    def test_cache_root_can_be_overridden(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            expected = Path(temporary).resolve() / "cache"
            with mock.patch.dict(
                os.environ,
                {"ALAS_CACHE_DIR": str(expected)},
                clear=False,
            ):
                self.assertEqual(
                    offline_core.default_cache_dir(),
                    expected,
                )


if __name__ == "__main__":
    unittest.main()
