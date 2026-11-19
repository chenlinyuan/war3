from __future__ import annotations

import io
import sys
import tempfile
import unittest
from contextlib import redirect_stderr, redirect_stdout
from pathlib import Path
from unittest import mock


APP = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(APP))

import alas_offline  # noqa: E402


class CliErrorLogTests(unittest.TestCase):
    def test_build_failure_is_written_inside_cache_root(self) -> None:
        with tempfile.TemporaryDirectory() as temp_name:
            cache = Path(temp_name) / "cache"
            stdout = io.StringIO()
            stderr = io.StringIO()
            with (
                mock.patch.object(
                    alas_offline.OfflineBuilder,
                    "build",
                    side_effect=RuntimeError("boom"),
                ),
                mock.patch.object(
                    alas_offline,
                    "default_cache_dir",
                    return_value=cache,
                ),
                redirect_stdout(stdout),
                redirect_stderr(stderr),
            ):
                result = alas_offline.run_cli(
                    [
                        "--cli",
                        "--source",
                        "missing.w3x",
                        "--output",
                        "out.w3x",
                    ]
                )

            self.assertEqual(result, 1)
            self.assertTrue((cache / "cli-error.log").is_file())


if __name__ == "__main__":
    unittest.main()
