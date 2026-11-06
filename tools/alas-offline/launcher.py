from __future__ import annotations

import os
import runpy
import sys
import traceback
from pathlib import Path


_LAUNCH_ARGS = tuple(sys.argv[1:])
_LAUNCH_EXE = Path(sys.executable).stem.casefold()
_WORKER_LAUNCH = bool(_LAUNCH_ARGS) or _LAUNCH_EXE.endswith(
    ("-worker", "-cli")
)


def bundle_root() -> Path:
    if hasattr(sys, "_MEIPASS"):
        return Path(sys._MEIPASS)
    return Path(__file__).resolve().parents[2]


def show_fatal(message: str) -> None:
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(0, message, "ALAS 离线工具", 0x10)
    except Exception:
        pass
    sys.stderr.write(message + "\n")


def main() -> int:
    root = bundle_root()
    worker_args = sys.argv[1:]
    worker_mode = None
    if worker_args and worker_args[0].lower().endswith(".py"):
        worker_mode = "script"
        script = Path(worker_args[0]).resolve()
        script_args = worker_args
    elif worker_args and worker_args[0] == "-c" and len(worker_args) > 1:
        worker_mode = "code"
        script = root / "tools" / "alas-offline" / "alas_offline.py"
        script_args = ["-c", *worker_args[2:]]
        worker_code = worker_args[1]
    elif worker_args and worker_args[0] == "-m" and len(worker_args) > 1:
        worker_mode = "module"
        script = root / "tools" / "alas-offline" / "alas_offline.py"
        script_args = ["-m", *worker_args[1:]]
        worker_module = worker_args[1]
        worker_module_args = worker_args[2:]
    else:
        script = root / "tools" / "alas-offline" / "alas_offline.py"
        script_args = [str(script), *worker_args]
    if not script.is_file():
        raise FileNotFoundError(script)
    os.environ["ALAS_OFFLINE_HOME"] = str(script.parent)
    if getattr(sys, "frozen", False) and worker_mode is None:
        for folder in (root, root.parent):
            worker = folder / "ALAS-Offline-Worker.exe"
            if worker.is_file():
                os.environ["ALAS_WORKER_EXE"] = str(worker)
                break
    sys.path[:0] = [
        str(script.parent),
        str(root / "tools" / "war3map-injector"),
        str(root / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"),
    ]
    sys.argv = script_args
    if worker_mode == "code":
        exec(compile(worker_code, "<alas-worker-c>", "exec"),
             {"__name__": "__main__", "__file__": "<alas-worker-c>"})
        return 0
    if worker_mode == "module":
        sys.argv = [worker_module, *worker_module_args]
        runpy.run_module(worker_module, run_name="__main__", alter_sys=True)
        return 0
    runpy.run_path(str(script), run_name="__main__")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception:
        detail = traceback.format_exc()
        if _WORKER_LAUNCH:
            # Worker/CLI failures must be reported by the parent process or
            # terminal. A GUI modal here can block subprocess completion and
            # is misleading because the GUI itself did start successfully.
            sys.stderr.write(detail + "\n")
            sys.stderr.flush()
        else:
            show_fatal(
                "离线工具启动失败：\n\n"
                + detail
                + "\n请把此窗口内容反馈给我。"
            )
        raise SystemExit(1)
