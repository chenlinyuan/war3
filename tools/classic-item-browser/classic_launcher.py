from __future__ import annotations

import os
import runpy
import sys
import traceback
from pathlib import Path


_ARGS = tuple(sys.argv[1:])
_EXE = Path(sys.executable).stem.casefold()
_WORKER = bool(_ARGS) or _EXE.endswith(("-worker", "-cli"))


def bundle_root() -> Path:
    if hasattr(sys, "_MEIPASS"):
        return Path(sys._MEIPASS)
    return Path(__file__).resolve().parents[2]


def show_fatal(message: str) -> None:
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(
            0,
            message,
            "ALAS 经典版物品浏览器",
            0x10,
        )
    except Exception:
        pass
    sys.stderr.write(message + "\n")


def main() -> int:
    root = bundle_root()
    args = sys.argv[1:]
    if args and args[0].lower().endswith(".py"):
        script = Path(args[0]).resolve()
        script_args = args
    else:
        script = root / "tools" / "classic-item-browser" / "classic_item_browser.py"
        script_args = [str(script), *args]
    if not script.is_file():
        raise FileNotFoundError(script)

    os.environ["ALAS_CLASSIC_HOME"] = str(script.parent)
    if getattr(sys, "frozen", False) and not _WORKER:
        for folder in (root, root.parent):
            worker = folder / "ALAS-Classic-ItemBrowser-Worker.exe"
            if worker.is_file():
                os.environ["CLASSIC_WORKER_EXE"] = str(worker)
                break

    sys.path[:0] = [
        str(script.parent),
        str(root / "tools" / "war3map-injector"),
    ]
    sys.argv = script_args
    runpy.run_path(str(script), run_name="__main__")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception:
        detail = traceback.format_exc()
        if _WORKER:
            sys.stderr.write(detail + "\n")
            sys.stderr.flush()
        else:
            show_fatal("经典版工具启动失败：\n\n" + detail)
        raise SystemExit(1)
