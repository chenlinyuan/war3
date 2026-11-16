# -*- coding: utf-8 -*-
"""Desktop front-end for the maintained KK/KKWE campaign converter."""
from __future__ import annotations

import json
import os
import queue
import re
import subprocess
import sys
import threading
import tkinter as tk
from pathlib import Path
from tkinter import filedialog, messagebox, ttk
from typing import Mapping


APP_DIR = Path(__file__).resolve().parent
ROOT = APP_DIR.parents[1]
CONVERTER = ROOT / "tools" / "war3map-injector" / "campaign_singleplayer.py"
PYTHON = ROOT / ".venv" / "Scripts" / "python.exe"
SHORTCUT_SCRIPT = APP_DIR / "install_shortcut.ps1"
SETTINGS = Path(os.environ.get("LOCALAPPDATA", Path.home())) / "KKSingleplayerTool" / "settings.json"
DZ_DIR = Path(r"H:\Games\War3\Campaigns\dz")
DEPLOY_DIR = DZ_DIR.parent
PROGRESS = re.compile(r"\[(?P<name>[^\]]+)\s+(?P<done>\d+)/(?P<total>\d+)\]\s*(?P<chapter>.+)")
WAR3_COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)
CAMPAIGN_PREVIEW_DELAY_MS = 250
TARGET_REFORGED = "reforged"
TARGET_CLASSIC = "classic"
TARGET_LABELS = {
    TARGET_REFORGED: "重制版",
    TARGET_CLASSIC: "经典版（1.27）",
}


def format_campaign_preview(payload: Mapping[str, object]) -> tuple[str, str]:
    title = WAR3_COLOR_TAG.sub("", str(payload.get("title") or "未命名战役")).strip()
    author = WAR3_COLOR_TAG.sub("", str(payload.get("author") or "未知")).strip()
    filename = str(payload.get("filename") or "未知文件").strip()
    hm3w_title = WAR3_COLOR_TAG.sub(
        "",
        str(payload.get("hm3w_title") or ""),
    ).strip()
    chapter_count = payload.get("chapter_count", 0)
    source_sha256 = str(payload.get("source_sha256") or "").strip()

    details = [
        "作者：%s    章节：%s" % (author, chapter_count),
    ]
    if hm3w_title and hm3w_title.casefold() != title.casefold():
        details.append("平台标题：%s" % hm3w_title)
    details.append("源文件：%s" % filename)
    if source_sha256:
        details.append("SHA-256：%s" % source_sha256)
    return "战役名称：%s" % title, "\n".join(details)


def run_hidden(arguments: list[str], cwd: Path | None = None) -> subprocess.CompletedProcess[str]:
    flags = getattr(subprocess, "CREATE_NO_WINDOW", 0)
    return subprocess.run(
        arguments,
        cwd=str(cwd or ROOT),
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        creationflags=flags,
        check=False,
    )


def refresh_shortcut() -> None:
    if not SHORTCUT_SCRIPT.is_file():
        return
    powershell = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32" / "WindowsPowerShell" / "v1.0" / "powershell.exe"
    if not powershell.is_file():
        return
    run_hidden(
        [
            str(powershell),
            "-NoProfile",
            "-ExecutionPolicy",
            "Bypass",
            "-File",
            str(SHORTCUT_SCRIPT),
        ]
    )


def load_settings() -> dict[str, object]:
    try:
        data = json.loads(SETTINGS.read_text(encoding="utf-8"))
        return data if isinstance(data, dict) else {}
    except (OSError, ValueError):
        return {}


def save_settings(data: dict[str, object]) -> None:
    try:
        SETTINGS.parent.mkdir(parents=True, exist_ok=True)
        SETTINGS.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    except OSError:
        pass


def initial_source() -> str:
    if len(sys.argv) > 1 and Path(sys.argv[1]).exists():
        return str(Path(sys.argv[1]).resolve())
    configured = str(load_settings().get("source", "") or "")
    if configured and Path(configured).exists():
        return configured
    if DZ_DIR.is_dir():
        campaigns = sorted(DZ_DIR.glob("*.w3n"), key=lambda path: path.stat().st_mtime, reverse=True)
        if campaigns:
            return str(campaigns[0].resolve())
    return ""


def initial_output() -> str:
    configured = str(load_settings().get("output", "") or "")
    if configured:
        return configured
    if DEPLOY_DIR.is_dir():
        return str(DEPLOY_DIR.resolve())
    return ""


def initial_target() -> str:
    configured = str(load_settings().get("target", "") or "")
    return configured if configured in TARGET_LABELS else TARGET_REFORGED


class App(tk.Tk):
    def __init__(self) -> None:
        super().__init__()
        self.title("KK 地图单机化工具")
        self.geometry("960x800")
        self.minsize(820, 640)
        self.events: queue.Queue[tuple[str, object]] = queue.Queue()
        self.process: subprocess.Popen[str] | None = None
        self.worker: threading.Thread | None = None
        self.stopping = False
        self.metadata_generation = 0
        self.metadata_after_id: str | None = None

        self.source_var = tk.StringVar(value=initial_source())
        self.output_var = tk.StringVar(value=initial_output())
        self.overwrite_var = tk.BooleanVar(value=True)
        self.extract_only_var = tk.BooleanVar(value=False)
        self.remove_backpack_switch_var = tk.BooleanVar(value=False)
        self.target_var = tk.StringVar(value=initial_target())
        self.clean_rederive_var = tk.BooleanVar(
            value=bool(load_settings().get("clean_rederive", False))
        )
        self.fix_loading_art_var = tk.BooleanVar(
            value=bool(load_settings().get("fix_loading_art", True))
        )
        self.status_var = tk.StringVar(value="就绪")
        self.chapter_var = tk.StringVar(value="")
        self.campaign_name_var = tk.StringVar(value="尚未选择战役")
        self.campaign_details_var = tk.StringVar(value="选择或输入 .w3n 后将自动读取战役信息。")

        self._build_ui()
        self._source_changed()
        self.protocol("WM_DELETE_WINDOW", self._on_close)
        self.after(80, self._poll_events)
        try:
            refresh_shortcut()
        except Exception:
            pass

    def _build_ui(self) -> None:
        outer = ttk.Frame(self, padding=16)
        outer.pack(fill="both", expand=True)

        title = ttk.Label(outer, text="KK / KKWE 战役单机化", font=("Microsoft YaHei UI", 17, "bold"))
        title.grid(row=0, column=0, columnspan=4, sticky="w")
        subtitle = ttk.Label(
            outer,
            text="从平台原版重新提取、还原脚本并做静态校验；不会启动游戏或编辑器。",
            foreground="#555555",
        )
        subtitle.grid(row=1, column=0, columnspan=4, sticky="w", pady=(2, 14))

        ttk.Label(outer, text="源战役 / 目录").grid(row=2, column=0, sticky="w")
        self.source_entry = ttk.Entry(outer, textvariable=self.source_var)
        self.source_entry.grid(row=3, column=0, columnspan=2, sticky="ew", padx=(0, 8), pady=(4, 0))
        self.source_var.trace_add("write", lambda *_args: self._source_changed())
        ttk.Button(outer, text="选择战役...", command=self._pick_file).grid(row=3, column=2, sticky="ew", padx=(0, 8))
        ttk.Button(outer, text="选择目录...", command=self._pick_directory).grid(row=3, column=3, sticky="ew")

        preview = ttk.LabelFrame(outer, text="已选战役预处理", padding=(10, 7))
        preview.grid(row=4, column=0, columnspan=4, sticky="ew", pady=(8, 0))
        ttk.Label(
            preview,
            textvariable=self.campaign_name_var,
            font=("Microsoft YaHei UI", 11, "bold"),
        ).grid(row=0, column=0, sticky="w")
        ttk.Label(
            preview,
            textvariable=self.campaign_details_var,
            foreground="#555555",
            justify="left",
        ).grid(row=1, column=0, sticky="w", pady=(3, 0))

        ttk.Label(
            outer,
            text="输出目录（默认直接放到游戏 Campaigns；留空则使用源目录\\singleplayer）",
        ).grid(row=5, column=0, sticky="w", pady=(12, 0))
        ttk.Entry(outer, textvariable=self.output_var).grid(
            row=6, column=0, columnspan=3, sticky="ew", padx=(0, 8), pady=(4, 0)
        )
        ttk.Button(outer, text="选择输出...", command=self._pick_output).grid(row=6, column=3, sticky="ew")

        options = ttk.LabelFrame(outer, text="转换选项", padding=10)
        options.grid(row=7, column=0, columnspan=4, sticky="ew", pady=(14, 0))
        ttk.Label(options, text="导出目标：").grid(row=0, column=0, sticky="w")
        ttk.Radiobutton(
            options,
            text="重制版",
            value=TARGET_REFORGED,
            variable=self.target_var,
        ).grid(row=0, column=1, sticky="w", padx=(6, 18))
        ttk.Radiobutton(
            options,
            text="经典版（1.27）",
            value=TARGET_CLASSIC,
            variable=self.target_var,
        ).grid(row=0, column=2, sticky="w")
        ttk.Checkbutton(
            options,
            text="覆盖已有成品（旧文件移入 _singleplayer_work\\_replaced）",
            variable=self.overwrite_var,
        ).grid(row=1, column=0, sticky="w", pady=(9, 0))
        ttk.Checkbutton(
            options,
            text="只提取并修复章节，不重新打包 W3N",
            variable=self.extract_only_var,
        ).grid(row=1, column=1, sticky="w", padx=(24, 0), pady=(9, 0))
        ttk.Checkbutton(
            options,
            text="移除地图自带的切换背包能力",
            variable=self.remove_backpack_switch_var,
        ).grid(row=1, column=2, sticky="w", padx=(24, 0), pady=(9, 0))
        ttk.Checkbutton(
            options,
            text="清源推导模式（忽略历史战役插件）",
            variable=self.clean_rederive_var,
        ).grid(row=2, column=0, columnspan=2, sticky="w", pady=(9, 0))
        ttk.Checkbutton(
            options,
            text="修复重制版加载画面和结算背景",
            variable=self.fix_loading_art_var,
        ).grid(row=3, column=0, columnspan=2, sticky="w", pady=(9, 0))

        actions = ttk.Frame(outer)
        actions.grid(row=8, column=0, columnspan=4, sticky="ew", pady=(14, 0))
        self.start_button = ttk.Button(actions, text="开始转换", command=self._start)
        self.start_button.pack(side="left")
        self.stop_button = ttk.Button(actions, text="停止", command=self._stop, state="disabled")
        self.stop_button.pack(side="left", padx=(8, 0))
        ttk.Button(actions, text="打开输出目录", command=self._open_output).pack(side="left", padx=(8, 0))
        ttk.Button(actions, text="清空日志", command=self._clear_log).pack(side="right")

        progress_frame = ttk.Frame(outer)
        progress_frame.grid(row=9, column=0, columnspan=4, sticky="ew", pady=(14, 4))
        self.progress = ttk.Progressbar(progress_frame, mode="indeterminate")
        self.progress.pack(fill="x")
        status = ttk.Frame(outer)
        status.grid(row=10, column=0, columnspan=4, sticky="ew")
        ttk.Label(status, textvariable=self.status_var).pack(side="left")
        ttk.Label(status, textvariable=self.chapter_var, foreground="#555555").pack(side="right")

        log_frame = ttk.LabelFrame(outer, text="转换日志", padding=6)
        log_frame.grid(row=11, column=0, columnspan=4, sticky="nsew", pady=(10, 0))
        self.log = tk.Text(
            log_frame,
            wrap="word",
            height=18,
            font=("Consolas", 10),
            background="#17191c",
            foreground="#e8e8e8",
            insertbackground="#e8e8e8",
            relief="flat",
        )
        scrollbar = ttk.Scrollbar(log_frame, orient="vertical", command=self.log.yview)
        self.log.configure(yscrollcommand=scrollbar.set)
        self.log.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        outer.columnconfigure(0, weight=1)
        outer.columnconfigure(1, weight=1)
        outer.columnconfigure(2, weight=0)
        outer.columnconfigure(3, weight=0)
        outer.rowconfigure(11, weight=1)

    def _source_changed(self) -> None:
        raw_source = self.source_var.get().strip()
        source = Path(raw_source) if raw_source else None
        self.start_button.configure(state="normal" if source and source.exists() else "disabled")
        self.metadata_generation += 1
        generation = self.metadata_generation
        if self.metadata_after_id is not None:
            self.after_cancel(self.metadata_after_id)
            self.metadata_after_id = None

        if source is None or not source.exists():
            self.campaign_name_var.set("尚未选择战役")
            self.campaign_details_var.set("选择或输入 .w3n 后将自动读取战役信息。")
            return
        if source.is_dir():
            campaigns = sorted(source.glob("*.w3n"))
            self.campaign_name_var.set("已选择战役目录")
            self.campaign_details_var.set(
                "目录：%s\n发现 %d 个 W3N；目录模式会由转换器逐个处理。"
                % (source, len(campaigns))
            )
            return
        if source.suffix.lower() != ".w3n":
            self.campaign_name_var.set("所选文件不是 W3N 战役")
            self.campaign_details_var.set("源文件：%s" % source.name)
            return

        self.campaign_name_var.set("正在读取战役信息…")
        self.campaign_details_var.set(
            "源文件：%s\n正在后台读取名称、作者、章节数并计算校验值。"
            % source.name
        )
        self.metadata_after_id = self.after(
            CAMPAIGN_PREVIEW_DELAY_MS,
            lambda: self._start_metadata_lookup(source, generation),
        )

    def _start_metadata_lookup(self, source: Path, generation: int) -> None:
        self.metadata_after_id = None
        if generation != self.metadata_generation or not source.is_file():
            return
        threading.Thread(
            target=self._load_campaign_metadata,
            args=(source, generation),
            daemon=True,
        ).start()

    def _load_campaign_metadata(self, source: Path, generation: int) -> None:
        try:
            result = run_hidden(
                [
                    str(PYTHON),
                    "-X",
                    "utf8",
                    str(CONVERTER),
                    str(source),
                    "--inspect-json",
                ]
            )
            if result.returncode != 0:
                detail = (result.stderr or result.stdout or "未知错误").strip()
                self.events.put(("metadata_error", (generation, detail[-300:])))
                return
            payload = json.loads(result.stdout.strip())
            if not isinstance(payload, dict):
                raise ValueError("metadata response is not an object")
            self.events.put(("metadata", (generation, payload)))
        except Exception as exc:
            self.events.put(("metadata_error", (generation, str(exc))))

    def _pick_file(self) -> None:
        initial = Path(self.source_var.get()).parent if self.source_var.get() else DZ_DIR
        selected = filedialog.askopenfilename(
            parent=self,
            title="选择 KK 战役",
            initialdir=str(initial if initial.is_dir() else DZ_DIR),
            filetypes=[("Warcraft III Campaign", "*.w3n"), ("All files", "*.*")],
        )
        if selected:
            self.source_var.set(selected)

    def _pick_directory(self) -> None:
        initial = Path(self.source_var.get()) if self.source_var.get() else DZ_DIR
        if initial.is_file():
            initial = initial.parent
        selected = filedialog.askdirectory(parent=self, title="选择包含 W3N 的目录", initialdir=str(initial))
        if selected:
            self.source_var.set(selected)

    def _pick_output(self) -> None:
        selected = filedialog.askdirectory(parent=self, title="选择输出目录")
        if selected:
            self.output_var.set(selected)

    def _start(self) -> None:
        if self.process is not None:
            return
        source = Path(self.source_var.get().strip())
        if not source.exists():
            messagebox.showerror("路径无效", "源战役或目录不存在。", parent=self)
            return
        if not PYTHON.is_file() or not CONVERTER.is_file():
            messagebox.showerror("工具不完整", "Python 环境或底层转换器不存在。", parent=self)
            return
        if self.clean_rederive_var.get() and self.remove_backpack_switch_var.get():
            messagebox.showerror(
                "选项冲突",
                "清源推导模式不读取历史战役插件，因此不能同时使用需要插件声明的能力移除选项。",
                parent=self,
            )
            return

        arguments = [str(PYTHON), "-u", str(CONVERTER), str(source)]
        output = self.output_var.get().strip()
        if output:
            arguments.extend(["--output-dir", output])
        if self.overwrite_var.get() and not self.extract_only_var.get():
            arguments.append("--overwrite")
        if self.extract_only_var.get():
            arguments.append("--extract-only")
        if self.remove_backpack_switch_var.get():
            arguments.append("--remove-backpack-switch")
        target = self.target_var.get()
        if target not in TARGET_LABELS:
            target = TARGET_REFORGED
        arguments.extend(["--target", target])
        if self.clean_rederive_var.get():
            arguments.append("--clean-rederive")
        if not self.fix_loading_art_var.get():
            arguments.append("--skip-loading-art")

        save_settings(
            {
                "source": str(source),
                "output": output,
                "target": target,
                "clean_rederive": self.clean_rederive_var.get(),
                "fix_loading_art": self.fix_loading_art_var.get(),
                "remove_backpack_switch": self.remove_backpack_switch_var.get(),
            }
        )
        self._clear_log()
        self._append_log("$ " + subprocess.list2cmdline(arguments) + "\n\n")
        self.status_var.set("正在转换")
        self.chapter_var.set("准备中")
        self.progress.start(12)
        self.start_button.configure(state="disabled")
        self.stop_button.configure(state="normal")
        self.stopping = False

        env = os.environ.copy()
        env["PYTHONUTF8"] = "1"
        env["PYTHONIOENCODING"] = "utf-8"
        flags = getattr(subprocess, "CREATE_NO_WINDOW", 0)
        self.process = subprocess.Popen(
            arguments,
            cwd=str(ROOT),
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
            env=env,
            creationflags=flags,
        )
        self.worker = threading.Thread(target=self._read_process, daemon=True)
        self.worker.start()

    def _read_process(self) -> None:
        process = self.process
        if process is None or process.stdout is None:
            return
        try:
            for line in process.stdout:
                self.events.put(("line", line))
            code = process.wait()
            self.events.put(("done", code))
        except Exception as exc:
            self.events.put(("error", str(exc)))

    def _poll_events(self) -> None:
        try:
            while True:
                kind, value = self.events.get_nowait()
                if kind == "line":
                    self._handle_line(str(value))
                elif kind == "done":
                    self._finish(int(value))
                elif kind == "error":
                    self._finish(1, str(value))
                elif kind == "metadata":
                    generation, payload = value
                    if generation == self.metadata_generation and isinstance(payload, dict):
                        name, details = format_campaign_preview(payload)
                        self.campaign_name_var.set(name)
                        self.campaign_details_var.set(details)
                elif kind == "metadata_error":
                    generation, detail = value
                    if generation == self.metadata_generation:
                        self.campaign_name_var.set("无法读取战役信息")
                        self.campaign_details_var.set(
                            "仍可尝试转换。预处理错误：%s" % detail
                        )
        except queue.Empty:
            pass
        if self.winfo_exists():
            self.after(80, self._poll_events)

    def _handle_line(self, line: str) -> None:
        self._append_log(line)
        match = PROGRESS.search(line)
        if match:
            self.chapter_var.set(
                "%s  %s/%s  %s"
                % (match.group("name"), match.group("done"), match.group("total"), match.group("chapter").strip())
            )
        stripped = line.strip()
        if stripped.startswith("Repacking"):
            self.status_var.set("正在重新打包战役")
            self.chapter_var.set("")
        elif stripped.startswith("Published:"):
            self.status_var.set("静态校验通过，正在发布")

    def _finish(self, code: int, error: str = "") -> None:
        self.progress.stop()
        self.process = None
        self.stop_button.configure(state="disabled")
        self._source_changed()
        if code == 0:
            self.status_var.set("完成")
            self.chapter_var.set("")
            self._append_log("\n转换完成。\n")
            messagebox.showinfo("转换完成", "单机版战役已生成并通过静态校验。", parent=self)
        elif self.stopping:
            self.status_var.set("已停止")
            self._append_log("\n用户停止了转换。\n")
        else:
            self.status_var.set("失败")
            self.chapter_var.set("")
            detail = ("\n" + error) if error else ""
            self._append_log("\n转换失败，请查看上方日志。%s\n" % detail)
            messagebox.showerror("转换失败", "未生成成品，请查看转换日志。", parent=self)
        self.stopping = False

    def _stop(self) -> None:
        process = self.process
        if process is None:
            return
        self.stopping = True
        self.status_var.set("正在停止")
        process.terminate()

    def _append_log(self, text: str) -> None:
        self.log.insert("end", text)
        self.log.see("end")

    def _clear_log(self) -> None:
        self.log.delete("1.0", "end")

    def _open_output(self) -> None:
        source = Path(self.source_var.get().strip()) if self.source_var.get().strip() else None
        output = Path(self.output_var.get().strip()) if self.output_var.get().strip() else None
        if output is None and source is not None:
            output = (source if source.is_dir() else source.parent) / "singleplayer"
        if output is not None and output.is_dir():
            os.startfile(str(output))
        else:
            messagebox.showinfo("目录不存在", "成品目录尚未生成。", parent=self)

    def _on_close(self) -> None:
        if self.process is not None:
            if not messagebox.askyesno("正在转换", "转换仍在进行，确定停止并退出吗？", parent=self):
                return
            self.stopping = True
            self.process.terminate()
        self.destroy()


def main() -> int:
    if not PYTHON.is_file():
        root = tk.Tk()
        root.withdraw()
        messagebox.showerror("工具不完整", "找不到 .venv\\Scripts\\python.exe。")
        root.destroy()
        return 1
    App().mainloop()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
