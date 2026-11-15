from __future__ import annotations

import argparse
import hashlib
import json
import os
import queue
import re
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path


APP_VERSION = "v1.0"
APP_NAME = "ALAS 经典版物品浏览器"
HERE = Path(__file__).resolve().parent
ROOT = Path(getattr(sys, "_MEIPASS", HERE.parents[1]))
INJECTOR = ROOT / "tools" / "war3map-injector"
PORT_SCRIPT = INJECTOR / "port_classic_item_browser_map.py"


def local_root() -> Path:
    base = os.environ.get("LOCALAPPDATA")
    root = Path(base) if base else Path.home() / "AppData" / "Local"
    return root / "ALASClassicItemBrowser"


def default_output(source: Path) -> Path:
    maps = Path.home() / "Documents" / "Warcraft III" / "Maps" / "Mod"
    folder = maps if maps.is_dir() else source.parent
    return folder / ("alas" + source.stem + source.suffix)


def worker_executable() -> str:
    return os.environ.get("CLASSIC_WORKER_EXE") or sys.executable


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def catalog_counts(path: Path) -> tuple[int, int]:
    standard = 0
    custom = 0
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            parts = line.rstrip("\n").split("\t", 2)
            if len(parts) < 3 or len(parts[1].strip()) != 4:
                continue
            if parts[0].strip() == "C":
                custom += 1
            else:
                standard += 1
    return standard, custom


def run_build(
    source: Path,
    output: Path,
    *,
    overwrite: bool,
    log,
    process_holder: list[subprocess.Popen[str] | None] | None = None,
    cancel_event: threading.Event | None = None,
) -> dict[str, object]:
    source = source.resolve()
    output = output.resolve()
    if source.suffix.lower() not in (".w3x", ".w3m"):
        raise ValueError("只支持单张 .w3x 或 .w3m 地图")
    if not source.is_file():
        raise ValueError("源地图不存在")
    if output == source:
        raise ValueError("输出路径不能覆盖源地图")
    if output.suffix.lower() != source.suffix.lower():
        raise ValueError("输出扩展名必须与源地图一致")
    if output.exists():
        if not overwrite:
            raise ValueError("成品已存在，请勾选“允许替换同名成品”")
        trash = local_root() / "replaced"
        trash.mkdir(parents=True, exist_ok=True)
        archived = trash / (
            output.stem + "-" + time.strftime("%Y%m%d-%H%M%S")
            + output.suffix.lower()
        )
        shutil.move(str(output), str(archived))
        log("旧成品已移动到: " + str(archived))

    slug = re.sub(r"[^0-9A-Za-z_-]+", "_", output.stem)[:60] or "map"
    work = local_root() / "work" / (
        slug + "-" + time.strftime("%Y%m%d-%H%M%S")
    )
    work.mkdir(parents=True, exist_ok=False)
    log("工作目录: " + str(work))
    if process_holder is not None:
        process_holder[0] = None
    command = [
        worker_executable(),
        str(PORT_SCRIPT),
        "--map",
        str(source),
        "--work",
        str(work / "build"),
        "--output",
        str(output),
    ]
    log("> " + subprocess.list2cmdline(command))
    env = dict(os.environ)
    env["PYTHONUTF8"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    process = subprocess.Popen(
        command,
        cwd=str(ROOT),
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        encoding="utf-8",
        errors="replace",
        bufsize=1,
        creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
    )
    if process_holder is not None:
        process_holder[0] = process
    assert process.stdout is not None
    for line in process.stdout:
        log(line.rstrip())
        if cancel_event is not None and cancel_event.is_set():
            process.terminate()
            break
    code = process.wait()
    if process_holder is not None:
        process_holder[0] = None
    if cancel_event is not None and cancel_event.is_set():
        raise RuntimeError("构建已停止")
    if code:
        raise RuntimeError("构建失败，退出码 %d；工作目录已保留" % code)

    catalog = work / "build" / "_itemids.txt"
    standard, custom = catalog_counts(catalog)
    result = {
        "version": APP_VERSION,
        "source": str(source),
        "output": str(output),
        "output_bytes": output.stat().st_size,
        "sha256": sha256_file(output),
        "standard_items": standard,
        "custom_items": custom,
        "items": standard + custom,
        "work_dir": str(work),
    }
    report = work / "build-report.json"
    report.write_text(
        json.dumps(result, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    result["report"] = str(report)
    log("")
    log("构建完成")
    log("物品: %d 原版 + %d 地图自定义 = %d" % (
        standard, custom, standard + custom
    ))
    log("成品: " + str(output))
    log("大小: %d 字节" % int(result["output_bytes"]))
    log("SHA-256: " + str(result["sha256"]))
    return result


def run_cli(argv: list[str]) -> int:
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except (AttributeError, OSError):
            pass
    parser = argparse.ArgumentParser(description=APP_NAME)
    parser.add_argument("--version", action="version", version=APP_VERSION)
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--overwrite", action="store_true")
    args = parser.parse_args(argv)
    output = args.output or default_output(args.source)
    try:
        run_build(
            args.source,
            output,
            overwrite=args.overwrite,
            log=lambda text: print(text, flush=True),
        )
    except Exception as exc:
        print("错误: " + str(exc), file=sys.stderr)
        return 1
    return 0


class ClassicApp:
    def __init__(self, root) -> None:
        import tkinter as tk
        from tkinter import filedialog, messagebox, scrolledtext, ttk

        self.tk = tk
        self.filedialog = filedialog
        self.messagebox = messagebox
        self.root = root
        self.events: queue.Queue[tuple[str, object]] = queue.Queue()
        self.thread: threading.Thread | None = None
        self.process_holder: list[subprocess.Popen[str] | None] = [None]
        self.cancel_event = threading.Event()
        self.result: dict[str, object] | None = None

        root.title(f"{APP_NAME} {APP_VERSION}")
        root.geometry("900x650")
        root.minsize(760, 560)
        frame = ttk.Frame(root, padding=18)
        frame.pack(fill="both", expand=True)
        frame.columnconfigure(1, weight=1)
        frame.rowconfigure(6, weight=1)

        ttk.Label(
            frame,
            text=APP_NAME,
            font=("Microsoft YaHei UI", 18, "bold"),
        ).grid(row=0, column=0, columnspan=3, sticky="w")
        ttk.Label(
            frame,
            text="经典版 1.27 · 只注入物品搜索与添加命令",
            foreground="#355b32",
        ).grid(row=1, column=0, columnspan=3, sticky="w", pady=(3, 14))

        ttk.Label(frame, text="源地图").grid(row=2, column=0, sticky="w")
        self.source_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.source_var).grid(
            row=2, column=1, sticky="ew", padx=8
        )
        ttk.Button(frame, text="选择…", command=self.choose_source).grid(
            row=2, column=2, sticky="ew"
        )

        ttk.Label(frame, text="成品路径").grid(
            row=3, column=0, sticky="w", pady=6
        )
        self.output_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.output_var).grid(
            row=3, column=1, sticky="ew", padx=8
        )
        ttk.Button(frame, text="另存为…", command=self.choose_output).grid(
            row=3, column=2, sticky="ew"
        )

        options = ttk.Frame(frame)
        options.grid(row=4, column=0, columnspan=3, sticky="ew", pady=(8, 8))
        self.overwrite_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            options,
            text="允许替换同名成品",
            variable=self.overwrite_var,
        ).pack(side="left")
        ttk.Label(
            options,
            text="命令: search 关键词 [页码] / additem 名称或ID [数量]",
            foreground="#666666",
        ).pack(side="left", padx=20)

        buttons = ttk.Frame(frame)
        buttons.grid(row=5, column=0, columnspan=3, sticky="ew", pady=(0, 8))
        self.build_button = ttk.Button(
            buttons, text="开始构建", command=self.start_build
        )
        self.build_button.pack(side="left")
        self.stop_button = ttk.Button(
            buttons, text="停止", command=self.stop_build, state="disabled"
        )
        self.stop_button.pack(side="left", padx=8)
        ttk.Button(
            buttons, text="打开成品目录", command=self.open_output
        ).pack(side="right")

        self.status_var = tk.StringVar(value="就绪")
        ttk.Label(
            frame,
            textvariable=self.status_var,
            font=("Microsoft YaHei UI", 10, "bold"),
        ).grid(row=6, column=0, columnspan=3, sticky="nw")
        self.log_widget = scrolledtext.ScrolledText(
            frame,
            wrap="word",
            font=("Consolas", 9),
            background="#101418",
            foreground="#d9e6d0",
            insertbackground="white",
        )
        self.log_widget.grid(
            row=7, column=0, columnspan=3, sticky="nsew", pady=(4, 0)
        )
        frame.rowconfigure(7, weight=1)
        self.log_widget.configure(state="disabled")
        root.after(100, self.poll)

    def log(self, text: str) -> None:
        self.log_widget.configure(state="normal")
        self.log_widget.insert("end", text + "\n")
        self.log_widget.see("end")
        self.log_widget.configure(state="disabled")

    def choose_source(self) -> None:
        path = self.filedialog.askopenfilename(
            title="选择经典版地图",
            filetypes=[
                ("Warcraft III 地图", "*.w3x *.w3m"),
                ("所有文件", "*.*"),
            ],
        )
        if not path:
            return
        source = Path(path)
        self.source_var.set(str(source))
        self.output_var.set(str(default_output(source)))

    def choose_output(self) -> None:
        source = Path(self.source_var.get().strip() or "map.w3x")
        current = Path(self.output_var.get()) if self.output_var.get() else None
        path = self.filedialog.asksaveasfilename(
            title="保存经典版成品",
            initialdir=str(current.parent if current else source.parent),
            initialfile=current.name if current else default_output(source).name,
            defaultextension=source.suffix,
            filetypes=[("Warcraft III 地图", "*" + source.suffix)],
        )
        if path:
            self.output_var.set(path)

    def start_build(self) -> None:
        if self.thread and self.thread.is_alive():
            return
        source = Path(self.source_var.get().strip())
        output = Path(self.output_var.get().strip())
        if not self.source_var.get().strip():
            self.messagebox.showerror(APP_NAME, "请选择源地图。")
            return
        if not self.output_var.get().strip():
            self.messagebox.showerror(APP_NAME, "请选择成品路径。")
            return
        if output.exists() and not self.overwrite_var.get():
            if not self.messagebox.askyesno(
                APP_NAME,
                "同名成品已存在，是否移入可恢复目录后替换？",
            ):
                return
            self.overwrite_var.set(True)
        self.cancel_event.clear()
        self.build_button.configure(state="disabled")
        self.stop_button.configure(state="normal")
        self.status_var.set("正在构建…")

        def work() -> None:
            try:
                result = run_build(
                    source,
                    output,
                    overwrite=self.overwrite_var.get(),
                    log=lambda text: self.events.put(("log", text)),
                    process_holder=self.process_holder,
                    cancel_event=self.cancel_event,
                )
                self.events.put(("done", result))
            except Exception as exc:
                self.events.put(("error", str(exc)))

        self.thread = threading.Thread(target=work, daemon=True)
        self.thread.start()

    def stop_build(self) -> None:
        self.cancel_event.set()
        process = self.process_holder[0]
        if process is not None and process.poll() is None:
            process.terminate()
        self.status_var.set("正在停止…")

    def poll(self) -> None:
        while True:
            try:
                kind, payload = self.events.get_nowait()
            except queue.Empty:
                break
            if kind == "log":
                self.log(str(payload))
            elif kind == "done":
                self.result = payload if isinstance(payload, dict) else None
                self.build_button.configure(state="normal")
                self.stop_button.configure(state="disabled")
                if self.result:
                    self.status_var.set(
                        "完成 · %d 件物品" % int(self.result["items"])
                    )
                    self.messagebox.showinfo(
                        APP_NAME,
                        "构建完成。\n\n物品: %d\nSHA-256:\n%s"
                        % (
                            int(self.result["items"]),
                            self.result["sha256"],
                        ),
                    )
            elif kind == "error":
                self.build_button.configure(state="normal")
                self.stop_button.configure(state="disabled")
                self.status_var.set("失败")
                self.messagebox.showerror(APP_NAME, str(payload))
        self.root.after(100, self.poll)

    def open_output(self) -> None:
        text = self.output_var.get().strip()
        if not text:
            return
        folder = Path(text).resolve().parent
        if folder.is_dir():
            os.startfile(folder)


def run_gui() -> int:
    import tkinter as tk
    root = tk.Tk()
    ClassicApp(root)
    root.mainloop()
    return 0


def main() -> int:
    if len(sys.argv) > 1:
        return run_cli(sys.argv[1:])
    return run_gui()


if __name__ == "__main__":
    raise SystemExit(main())
