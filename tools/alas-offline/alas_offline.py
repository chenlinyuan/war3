from __future__ import annotations

import argparse
import json
import os
import queue
import subprocess
import sys
import threading
import traceback
from dataclasses import asdict
from pathlib import Path

from offline_core import (
    OfflineBuilder,
    OfflineToolError,
    analyze_source,
    default_output_dir,
    suggested_output_name,
)
from version import APP_VERSION, BUILD_DATE


def safe_console_log(text: str) -> None:
    stream = sys.stdout
    if stream is None:
        return
    try:
        stream.write(text + "\n")
        stream.flush()
    except UnicodeEncodeError:
        buffer = getattr(stream, "buffer", None)
        if buffer is not None:
            buffer.write((text + "\n").encode("utf-8", "replace"))
            buffer.flush()


def save_repair_summary(repair) -> str:
    if not repair.enabled:
        return "自动修复存档：已关闭"
    lines = [
        "自动修复存档："
        + (
            "尝试处理 %d 个存档目录" % len(repair.directories)
            if repair.attempted
            else repair.message
        )
    ]
    if repair.attempted:
        lines.append(
            "修改 %d，已经是最新 %d，跳过 %d"
            % (repair.changed, repair.already_current, repair.skipped)
        )
        if repair.backups:
            lines.append("备份：" + "\n".join(repair.backups))
    if repair.errors:
        lines.append("错误：\n" + "\n".join(repair.errors))
    return "\n".join(lines)


def run_cli(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(
        description=f"ALAS 离线改图工具 {APP_VERSION}"
    )
    parser.add_argument("--cli", action="store_true", help=argparse.SUPPRESS)
    parser.add_argument(
        "--version",
        action="version",
        version=f"ALAS 离线改图工具 {APP_VERSION} ({BUILD_DATE})",
    )
    parser.add_argument("--source", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--overwrite", action="store_true")
    parser.add_argument("--no-doctor", action="store_true")
    parser.add_argument(
        "--no-repair-saves",
        action="store_true",
        help="关闭构建完成后的自动存档修复；默认开启。",
    )
    parser.add_argument(
        "--saves",
        type=Path,
        help="指定要自动修复的存档目录；默认按成品名称或战役标题自动查找。",
    )
    parser.add_argument(
        "--no-compact",
        action="store_true",
        help="关闭深度无损压缩；默认开启逐章重压缩、去重和空洞清理",
    )
    parser.add_argument(
        "--ft-data",
        action="store_true",
        help="将支持独立数据版本字段的章节设为 TFT；旧版地图保持原样",
    )
    parser.add_argument(
        "--equipment-mode",
        choices=("command", "item"),
        default="command",
        help=(
            "equipment skill ownership: command (default, normal bag + "
            "hero skills) or item (new bag/loadout)"
        ),
    )
    parser.add_argument(
        "--follow-graphics",
        action="store_true",
        help="让地图同时允许 SD/HD，画面跟随游戏设置",
    )
    parser.add_argument("--preflight", action="store_true")
    args = parser.parse_args(argv)
    if not args.source:
        parser.error("--source is required in CLI mode")
    if args.preflight:
        print(json.dumps(
            asdict(analyze_source(args.source)),
            ensure_ascii=False,
            indent=2,
        ))
        return 0
    if not args.output:
        args.output = (
            default_output_dir(args.source)
            / suggested_output_name(args.source)
        )
    try:
        OfflineBuilder(
            safe_console_log,
            compact_archive=not args.no_compact,
            ft_data=args.ft_data,
            equipment_mode=args.equipment_mode,
            follow_game_graphics=args.follow_graphics,
            repair_saves=not args.no_repair_saves,
            repair_save_dir=args.saves,
        ).build(
            args.source,
            args.output,
            overwrite=args.overwrite,
            doctor=not args.no_doctor,
        )
    except Exception as exc:  # noqa: BLE001
        message = "错误: " + str(exc) + "\n\n" + traceback.format_exc()
        local = Path(os.environ.get("LOCALAPPDATA", Path.home()))
        log = local / "ALASOffline" / "cli-error.log"
        log.parent.mkdir(parents=True, exist_ok=True)
        log.write_text(message, encoding="utf-8")
        if sys.stderr:
            print(message, file=sys.stderr)
        return 1
    return 0


class OfflineApp:
    def __init__(self, root) -> None:
        import tkinter as tk
        from tkinter import filedialog, messagebox, scrolledtext, ttk

        self.tk = tk
        self.filedialog = filedialog
        self.messagebox = messagebox
        self.root = root
        self.events: queue.Queue[tuple[str, object]] = queue.Queue()
        self.builder: OfflineBuilder | None = None
        self.worker: threading.Thread | None = None
        self.last_output: Path | None = None
        self.preflight_info = None

        root.title(f"ALAS 离线改图工具 {APP_VERSION}")
        root.geometry("980x720")
        root.minsize(820, 600)
        root.protocol("WM_DELETE_WINDOW", self.close)

        style = ttk.Style(root)
        try:
            style.theme_use("vista")
        except tk.TclError:
            pass

        frame = ttk.Frame(root, padding=18)
        frame.pack(fill="both", expand=True)
        frame.columnconfigure(1, weight=1)
        frame.rowconfigure(8, weight=1)

        ttk.Label(
            frame,
            text="ALAS 离线改图工具",
            font=("Microsoft YaHei UI", 18, "bold"),
        ).grid(row=0, column=0, columnspan=3, sticky="w")
        ttk.Label(
            frame,
            text=f"版本 {APP_VERSION}（{BUILD_DATE}）",
            font=("Microsoft YaHei UI", 10, "bold"),
            foreground="#666666",
        ).grid(row=0, column=3, sticky="e")
        ttk.Label(
            frame,
            text="完整装备系统 · 全本地资源 · 不调用联网功能 · Reforged 3.0",
            foreground="#355b32",
        ).grid(row=1, column=0, columnspan=4, sticky="w", pady=(4, 16))

        ttk.Label(frame, text="源战役或地图").grid(
            row=2, column=0, sticky="w", pady=4
        )
        self.source_var = tk.StringVar()
        self.source_entry = ttk.Entry(frame, textvariable=self.source_var)
        self.source_entry.grid(row=2, column=1, columnspan=2, sticky="ew", padx=8)
        ttk.Button(
            frame, text="选择文件…", command=self.choose_source
        ).grid(row=2, column=3, sticky="ew")

        ttk.Label(frame, text="成品路径").grid(row=3, column=0, sticky="w", pady=4)
        self.output_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.output_var).grid(
            row=3, column=1, columnspan=2, sticky="ew", padx=8
        )
        ttk.Button(
            frame, text="另存为…", command=self.choose_output
        ).grid(row=3, column=3, sticky="ew")

        self.info_var = tk.StringVar(
            value="选择 .w3n 战役或 .w3x/.w3m 单图后，将自动识别脚本类型。"
        )
        ttk.Label(
            frame,
            textvariable=self.info_var,
            foreground="#555555",
        ).grid(row=4, column=0, columnspan=4, sticky="w", pady=(8, 8))

        options = ttk.Frame(frame)
        options.grid(row=5, column=0, columnspan=4, sticky="ew", pady=(0, 10))
        self.overwrite_var = tk.BooleanVar(value=False)
        self.doctor_var = tk.BooleanVar(value=True)
        self.compact_var = tk.BooleanVar(value=True)
        self.repair_saves_var = tk.BooleanVar(value=True)
        self.ft_data_var = tk.BooleanVar(value=False)
        self.equipment_mode_var = tk.StringVar(
            value="command（普通背包，默认）"
        )
        self.follow_graphics_var = tk.BooleanVar(value=False)
        row1 = ttk.Frame(options)
        row1.pack(fill="x")
        row2 = ttk.Frame(options)
        row2.pack(fill="x", pady=(6, 0))
        ttk.Checkbutton(
            row1,
            text="允许归档替换同名成品",
            variable=self.overwrite_var,
        ).pack(side="left")
        ttk.Checkbutton(
            row1,
            text="执行 Map Doctor 深度检查",
            variable=self.doctor_var,
        ).pack(side="left", padx=20)
        ttk.Checkbutton(
            row1,
            text="无损压缩（推荐）",
            variable=self.compact_var,
        ).pack(side="left")
        ttk.Checkbutton(
            row1,
            text="自动修复存档（默认）",
            variable=self.repair_saves_var,
        ).pack(side="left", padx=(20, 0))
        ttk.Label(row2, text="技能归属：").pack(side="left")
        ttk.Combobox(
            row2,
            textvariable=self.equipment_mode_var,
            values=(
                "command（普通背包，默认）",
                "item（新背包）",
            ),
            state="readonly",
            width=22,
        ).pack(side="left")
        ttk.Checkbutton(
            row2,
            text="游戏数据改为 FT",
            variable=self.ft_data_var,
        ).pack(side="left", padx=20)
        ttk.Checkbutton(
            row2,
            text="画面模式跟随游戏设置",
            variable=self.follow_graphics_var,
        ).pack(side="left")

        buttons = ttk.Frame(frame)
        buttons.grid(row=6, column=0, columnspan=4, sticky="ew", pady=(0, 10))
        self.preflight_button = ttk.Button(
            buttons, text="预检查", command=self.start_preflight
        )
        self.preflight_button.pack(side="left")
        self.build_button = ttk.Button(
            buttons, text="开始构建", command=self.start_build
        )
        self.build_button.pack(side="left", padx=8)
        self.cancel_button = ttk.Button(
            buttons, text="停止", command=self.cancel, state="disabled"
        )
        self.cancel_button.pack(side="left")
        self.open_button = ttk.Button(
            buttons, text="打开成品目录", command=self.open_output
        )
        self.open_button.pack(side="right")

        self.status_var = tk.StringVar(value="就绪")
        ttk.Label(
            frame,
            textvariable=self.status_var,
            font=("Microsoft YaHei UI", 10, "bold"),
        ).grid(row=7, column=0, columnspan=4, sticky="w", pady=(0, 5))

        self.log_widget = scrolledtext.ScrolledText(
            frame,
            wrap="word",
            font=("Consolas", 9),
            background="#101418",
            foreground="#d9e6d0",
            insertbackground="white",
        )
        self.log_widget.grid(row=8, column=0, columnspan=4, sticky="nsew")
        self.log_widget.configure(state="disabled")
        self.root.after(100, self.poll_events)

    def put_log(self, text: str) -> None:
        self.events.put(("log", text))

    def append_log(self, text: str) -> None:
        self.log_widget.configure(state="normal")
        self.log_widget.insert("end", text + "\n")
        self.log_widget.see("end")
        self.log_widget.configure(state="disabled")

    def choose_source(self) -> None:
        initial = default_output_dir(Path("campaign.w3n"))
        path = self.filedialog.askopenfilename(
            title="选择未修改的战役或地图",
            initialdir=str(initial if initial.is_dir() else Path.home()),
            filetypes=[
                ("War3 战役或地图", "*.w3n *.w3x *.w3m"),
                ("战役", "*.w3n"),
                ("单张地图", "*.w3x *.w3m"),
                ("所有文件", "*.*"),
            ],
        )
        if not path:
            return
        source = Path(path)
        self.source_var.set(str(source))
        self.output_var.set(
            str(default_output_dir(source) / suggested_output_name(source))
        )
        self.start_preflight()

    def choose_output(self) -> None:
        current = Path(self.output_var.get()) if self.output_var.get() else None
        source = Path(self.source_var.get().strip())
        suffix = (
            source.suffix.lower()
            if source.suffix.lower() in (".w3x", ".w3m")
            else ".w3n"
        )
        folder = current.parent if current else default_output_dir(source)
        path = self.filedialog.asksaveasfilename(
            title="保存 ALAS 成品",
            initialdir=str(folder),
            initialfile=(
                current.name
                if current
                else "alas地图" + suffix
            ),
            defaultextension=suffix,
            filetypes=[
                ("War3 文件", "*" + suffix),
            ],
        )
        if path:
            self.output_var.set(path)

    def set_busy(self, busy: bool) -> None:
        state = "disabled" if busy else "normal"
        self.preflight_button.configure(state=state)
        self.build_button.configure(state=state)
        self.cancel_button.configure(state="normal" if busy else "disabled")

    def start_preflight(self) -> None:
        if self.worker and self.worker.is_alive():
            return
        source = Path(self.source_var.get().strip())
        self.set_busy(True)
        self.status_var.set("正在识别源文件…")

        def work() -> None:
            try:
                info = analyze_source(source)
                self.events.put(("preflight", info))
            except Exception as exc:  # noqa: BLE001
                self.events.put(("error", str(exc)))

        self.worker = threading.Thread(target=work, daemon=True)
        self.worker.start()

    def start_build(self) -> None:
        if self.worker and self.worker.is_alive():
            return
        source = Path(self.source_var.get().strip())
        output = Path(self.output_var.get().strip())
        if not output.name:
            self.messagebox.showerror("路径错误", "请选择成品路径。")
            return
        if output.exists() and not self.overwrite_var.get():
            answer = self.messagebox.askyesno(
                "同名成品已存在",
                "是否将旧成品移入可恢复目录后生成新版本？",
            )
            if not answer:
                return
            self.overwrite_var.set(True)
        self.last_output = output
        self.set_busy(True)
        self.status_var.set("正在构建…")
        self.append_log("=" * 72)
        self.append_log("开始构建: " + str(source))

        def work() -> None:
            builder = OfflineBuilder(
                self.put_log,
                compact_archive=self.compact_var.get(),
                ft_data=self.ft_data_var.get(),
                equipment_mode=self.equipment_mode_var.get().split(
                    "（", 1
                )[0],
                follow_game_graphics=self.follow_graphics_var.get(),
                repair_saves=self.repair_saves_var.get(),
            )
            self.builder = builder
            try:
                result = builder.build(
                    source,
                    output,
                    overwrite=self.overwrite_var.get(),
                    doctor=self.doctor_var.get(),
                )
                self.events.put(("done", result))
            except Exception as exc:  # noqa: BLE001
                self.events.put(("error", str(exc)))
            finally:
                self.builder = None

        self.worker = threading.Thread(target=work, daemon=True)
        self.worker.start()

    def cancel(self) -> None:
        if self.builder:
            self.status_var.set("正在停止…")
            self.builder.cancel()

    def poll_events(self) -> None:
        while True:
            try:
                kind, payload = self.events.get_nowait()
            except queue.Empty:
                break
            if kind == "log":
                self.append_log(str(payload))
            elif kind == "preflight":
                self.preflight_info = payload
                if payload.source_kind == "map":
                    detail = "单张地图"
                else:
                    detail = "%d 章" % len(payload.chapters)
                self.info_var.set(
                    "%s · %s · %s · %.1f MB"
                    % (
                        payload.title,
                        detail,
                        payload.script_type.upper(),
                        payload.source_bytes / 1048576,
                    )
                )
                self.status_var.set("预检查通过")
                self.set_busy(False)
            elif kind == "done":
                self.status_var.set("构建及审计完成")
                self.set_busy(False)
                self.last_output = Path(payload.output)
                warning = ""
                if payload.doctor_blockers:
                    warning = (
                        "\n\n注意：Map Doctor 仍有 %d 个阻断项，请查看日志。"
                        % payload.doctor_blockers
                    )
                self.messagebox.showinfo(
                    "完成",
                    "成品已生成并通过离线审计。\n\n"
                    + payload.output
                    + "\n\nSHA-256：\n"
                    + payload.output_sha256
                    + "\n\n"
                    + save_repair_summary(payload.save_repair)
                    + warning,
                )
            elif kind == "error":
                self.status_var.set("失败")
                self.set_busy(False)
                self.append_log("错误: " + str(payload))
                self.messagebox.showerror("构建失败", str(payload))
        self.root.after(100, self.poll_events)

    def open_output(self) -> None:
        target = None
        if self.last_output:
            target = self.last_output.parent
        elif self.output_var.get():
            target = Path(self.output_var.get()).parent
        if target and target.exists():
            os.startfile(target)  # type: ignore[attr-defined]

    def close(self) -> None:
        if self.worker and self.worker.is_alive():
            if not self.messagebox.askyesno("退出", "构建仍在运行，是否停止并退出？"):
                return
            self.cancel()
        self.root.destroy()


def run_gui() -> int:
    import tkinter as tk

    root = tk.Tk()
    OfflineApp(root)
    root.mainloop()
    return 0


def main() -> int:
    if "--version" in sys.argv[1:]:
        print(f"ALAS 离线改图工具 {APP_VERSION} ({BUILD_DATE})")
        return 0
    if "--cli" in sys.argv[1:]:
        return run_cli(sys.argv[1:])
    return run_gui()


if __name__ == "__main__":
    raise SystemExit(main())
