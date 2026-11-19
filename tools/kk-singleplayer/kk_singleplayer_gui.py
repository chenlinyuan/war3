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
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from tkinter import filedialog, messagebox, ttk
from typing import Mapping

import campaign_catalog as CATALOG


APP_DIR = (
    Path(sys.executable).resolve().parent
    if getattr(sys, "frozen", False)
    else Path(__file__).resolve().parent
)
ROOT = APP_DIR.parents[1]
CONVERTER = ROOT / "tools" / "war3map-injector" / "campaign_singleplayer.py"
PYTHON = ROOT / ".venv" / "Scripts" / "python.exe"
SHORTCUT_SCRIPT = ROOT / "tools" / "kk-singleplayer" / "install_shortcut.ps1"
SETTINGS = Path(os.environ.get("LOCALAPPDATA", Path.home())) / "KKSingleplayerTool" / "settings.json"
CAMPAIGN_CACHE = SETTINGS.with_name("campaign-cache.json")
DZ_DIR = Path(r"H:\Games\War3\Campaigns\dz")
DEPLOY_DIR = DZ_DIR.parent
PROGRESS = re.compile(r"\[(?P<name>[^\]]+)\s+(?P<done>\d+)/(?P<total>\d+)\]\s*(?P<chapter>.+)")
WAR3_COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)
CAMPAIGN_SCAN_DELAY_MS = 250
CAMPAIGN_METADATA_WORKERS = 4
CAMPAIGN_EXCLUDED_DIRS = frozenset({"_singleplayer_work", "_replaced", "__pycache__"})
TARGET_SOURCE = "source"
TARGET_REFORGED = "reforged"
TARGET_CLASSIC = "classic"
TARGET_LABELS = {
    TARGET_SOURCE: "保留源版本（由 ALAS 迁移）",
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
    return "战役名称：%s" % title, "    ".join(details)


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


def load_campaign_cache() -> dict[str, object]:
    try:
        data = json.loads(CAMPAIGN_CACHE.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}
    files = data.get("files") if isinstance(data, dict) else None
    return dict(files) if isinstance(files, dict) else {}


def save_campaign_cache(files: Mapping[str, object]) -> None:
    try:
        CAMPAIGN_CACHE.parent.mkdir(parents=True, exist_ok=True)
        CAMPAIGN_CACHE.write_text(
            json.dumps(
                {"version": 1, "files": dict(files)},
                ensure_ascii=False,
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )
    except OSError:
        pass


def initial_source() -> str:
    if len(sys.argv) > 1 and Path(sys.argv[1]).exists():
        return str(Path(sys.argv[1]).resolve())
    configured = str(load_settings().get("source", "") or "")
    if configured and Path(configured).exists():
        configured_path = Path(configured).resolve()
        if configured_path.is_file() and configured_path.suffix.casefold() == ".w3n":
            return str(configured_path.parent)
        return str(configured_path)
    if DZ_DIR.is_dir():
        return str(DZ_DIR.resolve())
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
        self.geometry("1180x720")
        self.minsize(980, 640)
        self.events: queue.Queue[tuple[str, object]] = queue.Queue()
        self.process: subprocess.Popen[str] | None = None
        self.worker: threading.Thread | None = None
        self.stopping = False
        self.scan_generation = 0
        self.scan_after_id: str | None = None
        self.scan_thread: threading.Thread | None = None
        self.campaign_rows: dict[str, dict[str, object]] = {}
        self.campaign_iids: dict[str, str] = {}
        self.campaign_cache = load_campaign_cache()
        saved_settings = load_settings()
        selected_campaigns = [
            str(value)
            for value in saved_settings.get("selected_campaigns", [])
            if str(value).strip()
        ]
        configured_source = Path(str(saved_settings.get("source", "") or ""))
        if (
            configured_source.is_file()
            and configured_source.suffix.casefold() == ".w3n"
        ):
            selected_campaigns.append(str(configured_source.resolve()))
        self.saved_selection = {
            str(Path(value).resolve())
            for value in selected_campaigns
        }

        self.source_var = tk.StringVar(value=initial_source())
        self.output_var = tk.StringVar(value=initial_output())
        self.overwrite_var = tk.BooleanVar(value=True)
        self.extract_only_var = tk.BooleanVar(value=False)
        self.target_var = tk.StringVar(value=initial_target())
        self.clean_rederive_var = tk.BooleanVar(
            value=bool(load_settings().get("clean_rederive", False))
        )
        self.fix_loading_art_var = tk.BooleanVar(
            value=bool(load_settings().get("fix_loading_art", True))
        )
        self.status_var = tk.StringVar(value="就绪")
        self.chapter_var = tk.StringVar(value="")
        self.campaign_list_status_var = tk.StringVar(value="尚未扫描战役目录")
        self.campaign_name_var = tk.StringVar(value="尚未选择战役")
        self.campaign_details_var = tk.StringVar(value="选择战役目录后，从下方列表勾选需要的地图。")

        self._build_ui()
        self._source_changed()
        self.protocol("WM_DELETE_WINDOW", self._on_close)
        self.after(80, self._poll_events)
        try:
            refresh_shortcut()
        except Exception:
            pass

    def _build_ui(self) -> None:
        outer = ttk.Frame(self, padding=10)
        outer.pack(fill="both", expand=True)

        title = ttk.Label(outer, text="KK / KKWE 战役单机化", font=("Microsoft YaHei UI", 15, "bold"))
        title.grid(row=0, column=0, columnspan=4, sticky="w")
        subtitle = ttk.Label(
            outer,
            text="从平台原版重新提取、还原脚本并做静态校验；不会启动游戏或编辑器。",
            foreground="#555555",
        )
        subtitle.grid(row=1, column=0, columnspan=4, sticky="w", pady=(1, 7))

        ttk.Label(outer, text="源战役 / 目录").grid(row=2, column=0, sticky="w")
        self.source_entry = ttk.Entry(outer, textvariable=self.source_var)
        self.source_entry.grid(row=3, column=0, columnspan=2, sticky="ew", padx=(0, 8), pady=(4, 0))
        self.source_var.trace_add("write", lambda *_args: self._source_changed())
        ttk.Button(outer, text="选择战役目录...", command=self._pick_directory).grid(
            row=3, column=2, sticky="ew", padx=(0, 8)
        )
        ttk.Button(outer, text="选择单个 W3N...", command=self._pick_file).grid(
            row=3, column=3, sticky="ew"
        )

        campaign_list = ttk.LabelFrame(outer, text="战役列表", padding=6)
        campaign_list.grid(row=4, column=0, columnspan=4, sticky="nsew", pady=(6, 0))
        list_toolbar = ttk.Frame(campaign_list)
        list_toolbar.grid(row=0, column=0, sticky="ew")
        ttk.Button(list_toolbar, text="重新扫描", command=self._refresh_campaigns).pack(side="left")
        ttk.Button(list_toolbar, text="全选", command=self._select_all_campaigns).pack(
            side="left", padx=(6, 0)
        )
        ttk.Button(list_toolbar, text="清空选择", command=self._clear_campaign_selection).pack(
            side="left", padx=(6, 0)
        )
        ttk.Label(
            list_toolbar,
            textvariable=self.campaign_list_status_var,
            foreground="#555555",
        ).pack(side="right")

        tree_frame = ttk.Frame(campaign_list)
        tree_frame.grid(row=1, column=0, sticky="nsew", pady=(6, 0))
        self.campaign_tree = ttk.Treeview(
            tree_frame,
            columns=("title", "chapters", "size", "modified", "status", "path"),
            show="headings",
            selectmode="extended",
            height=11,
        )
        headings = {
            "title": ("战役名称", 280),
            "chapters": ("章节", 70),
            "size": ("大小", 90),
            "modified": ("修改时间", 125),
            "status": ("状态", 100),
            "path": ("路径", 420),
        }
        for column, (heading, width) in headings.items():
            self.campaign_tree.heading(column, text=heading)
            self.campaign_tree.column(
                column,
                width=width,
                minwidth=60,
                stretch=column in ("title", "path"),
            )
        tree_scroll_y = ttk.Scrollbar(
            tree_frame,
            orient="vertical",
            command=self.campaign_tree.yview,
        )
        tree_scroll_x = ttk.Scrollbar(
            tree_frame,
            orient="horizontal",
            command=self.campaign_tree.xview,
        )
        self.campaign_tree.configure(
            yscrollcommand=tree_scroll_y.set,
            xscrollcommand=tree_scroll_x.set,
        )
        self.campaign_tree.grid(row=0, column=0, sticky="nsew")
        tree_scroll_y.grid(row=0, column=1, sticky="ns")
        tree_scroll_x.grid(row=1, column=0, sticky="ew")
        tree_frame.columnconfigure(0, weight=1)
        tree_frame.rowconfigure(0, weight=1)
        campaign_list.columnconfigure(0, weight=1)
        campaign_list.rowconfigure(1, weight=1)
        self.campaign_tree.bind(
            "<<TreeviewSelect>>",
            lambda _event: self._campaign_selection_changed(),
        )
        self.campaign_tree.bind(
            "<Control-a>",
            lambda _event: self._select_all_campaigns(),
        )

        preview = ttk.LabelFrame(outer, text="已选战役", padding=(7, 4))
        preview.grid(row=5, column=0, columnspan=4, sticky="ew", pady=(6, 0))
        ttk.Label(
            preview,
            textvariable=self.campaign_name_var,
            font=("Microsoft YaHei UI", 10, "bold"),
        ).grid(row=0, column=0, sticky="w")
        ttk.Label(
            preview,
            textvariable=self.campaign_details_var,
            foreground="#555555",
            justify="left",
        ).grid(row=1, column=0, sticky="w", pady=(1, 0))

        ttk.Label(outer, text="输出目录：").grid(
            row=6, column=0, sticky="w", pady=(7, 0)
        )
        ttk.Entry(outer, textvariable=self.output_var).grid(
            row=6, column=1, columnspan=2, sticky="ew", padx=(4, 8), pady=(7, 0)
        )
        ttk.Button(outer, text="选择输出...", command=self._pick_output).grid(
            row=6, column=3, sticky="ew", pady=(7, 0)
        )

        options = ttk.LabelFrame(outer, text="转换选项", padding=(8, 5))
        options.grid(row=8, column=0, columnspan=4, sticky="ew", pady=(8, 0))
        ttk.Label(options, text="导出目标：").grid(row=0, column=0, sticky="w")
        ttk.Radiobutton(
            options,
            text="保留源版本",
            value=TARGET_SOURCE,
            variable=self.target_var,
        ).grid(row=0, column=1, sticky="w", padx=(6, 18))
        ttk.Radiobutton(
            options,
            text="重制版",
            value=TARGET_REFORGED,
            variable=self.target_var,
        ).grid(row=0, column=2, sticky="w", padx=(0, 18))
        ttk.Radiobutton(
            options,
            text="经典版（1.27）",
            value=TARGET_CLASSIC,
            variable=self.target_var,
        ).grid(row=0, column=3, sticky="w")
        ttk.Checkbutton(
            options,
            text="覆盖已有成品",
            variable=self.overwrite_var,
        ).grid(row=0, column=4, sticky="w", padx=(18, 0))
        ttk.Checkbutton(
            options,
            text="只提取章节",
            variable=self.extract_only_var,
        ).grid(row=1, column=0, sticky="w", pady=(5, 0))
        ttk.Checkbutton(
            options,
            text="清源推导",
            variable=self.clean_rederive_var,
        ).grid(row=1, column=1, sticky="w", padx=(16, 0), pady=(5, 0))
        ttk.Checkbutton(
            options,
            text="修复重制加载/结算背景",
            variable=self.fix_loading_art_var,
        ).grid(row=1, column=2, sticky="w", padx=(16, 0), pady=(5, 0))

        actions = ttk.Frame(outer)
        actions.grid(row=9, column=0, columnspan=4, sticky="ew", pady=(8, 0))
        self.start_button = ttk.Button(actions, text="开始转换", command=self._start)
        self.start_button.pack(side="left")
        self.stop_button = ttk.Button(actions, text="停止", command=self._stop, state="disabled")
        self.stop_button.pack(side="left", padx=(8, 0))
        ttk.Button(actions, text="打开输出目录", command=self._open_output).pack(side="left", padx=(8, 0))
        ttk.Button(actions, text="清空日志", command=self._clear_log).pack(side="right")

        progress_frame = ttk.Frame(outer)
        progress_frame.grid(row=10, column=0, columnspan=4, sticky="ew", pady=(7, 2))
        self.progress = ttk.Progressbar(progress_frame, mode="indeterminate")
        self.progress.pack(fill="x")
        status = ttk.Frame(outer)
        status.grid(row=11, column=0, columnspan=4, sticky="ew")
        ttk.Label(status, textvariable=self.status_var).pack(side="left")
        ttk.Label(status, textvariable=self.chapter_var, foreground="#555555").pack(side="right")

        log_frame = ttk.LabelFrame(outer, text="转换日志", padding=4)
        log_frame.grid(row=12, column=0, columnspan=4, sticky="nsew", pady=(6, 0))
        self.log = tk.Text(
            log_frame,
            wrap="word",
            height=6,
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
        outer.rowconfigure(4, weight=4, minsize=220)
        outer.rowconfigure(12, weight=1, minsize=100)

    def _source_changed(self) -> None:
        raw_source = self.source_var.get().strip()
        source = Path(raw_source).resolve() if raw_source else None
        self.scan_generation += 1
        generation = self.scan_generation
        if self.scan_after_id is not None:
            self.after_cancel(self.scan_after_id)
            self.scan_after_id = None
        self._clear_campaign_tree()
        self._update_campaign_actions()

        if source is None or not source.exists():
            self.campaign_list_status_var.set("尚未扫描战役目录")
            self.campaign_name_var.set("尚未选择战役")
            self.campaign_details_var.set("选择战役目录后，从下方列表勾选需要的地图。")
            return
        if not source.is_dir() and source.suffix.lower() != ".w3n":
            self.campaign_name_var.set("所选文件不是 W3N 战役")
            self.campaign_details_var.set("源文件：%s" % source.name)
            self.campaign_list_status_var.set("请选择目录或 .w3n 文件")
            return

        self.scan_source_root = source.parent if source.is_file() else source
        self.campaign_list_status_var.set("正在扫描 W3N 并读取战役名称…")
        self.campaign_name_var.set("正在加载战役列表")
        self.campaign_details_var.set("先显示文件列表，再在后台逐个读取战役名称。")
        self.scan_after_id = self.after(
            CAMPAIGN_SCAN_DELAY_MS,
            lambda: self._start_campaign_scan(source, generation),
        )

    def _clear_campaign_tree(self) -> None:
        if not hasattr(self, "campaign_tree"):
            return
        children = self.campaign_tree.get_children()
        if children:
            self.campaign_tree.delete(*children)
        self.campaign_rows.clear()
        self.campaign_iids.clear()

    def _start_campaign_scan(self, source: Path, generation: int) -> None:
        self.scan_after_id = None
        if generation != self.scan_generation:
            return
        self.scan_thread = threading.Thread(
            target=self._scan_campaign_source,
            args=(source, generation),
            daemon=True,
        )
        self.scan_thread.start()

    def _scan_campaign_source(self, source: Path, generation: int) -> None:
        try:
            files = CATALOG.discover_campaign_files(
                source,
                excluded_directories=CAMPAIGN_EXCLUDED_DIRS,
            )
            stale: list[CATALOG.CampaignFile] = []
            for info in files:
                payload = CATALOG.cached_payload(self.campaign_cache, info)
                status = "可用" if payload is not None else "读取中"
                self.events.put(
                    ("campaign_row", (generation, info, payload, status))
                )
                if payload is None:
                    stale.append(info)
            if stale:
                with ThreadPoolExecutor(
                    max_workers=CAMPAIGN_METADATA_WORKERS
                ) as executor:
                    futures = {
                        executor.submit(self._read_campaign_metadata, info.path): info
                        for info in stale
                    }
                    for future in as_completed(futures):
                        info = futures[future]
                        try:
                            payload = future.result()
                            self.events.put(
                                (
                                    "campaign_metadata",
                                    (generation, info, payload, ""),
                                )
                            )
                        except Exception as exc:
                            self.events.put(
                                (
                                    "campaign_metadata",
                                    (generation, info, None, str(exc)),
                                )
                            )
            self.events.put(
                ("campaign_scan_done", (generation, len(files), ""))
            )
        except Exception as exc:
            self.events.put(("campaign_scan_done", (generation, 0, str(exc))))

    @staticmethod
    def _read_campaign_metadata(path: Path) -> dict[str, object]:
        result = run_hidden(
            [
                str(PYTHON),
                "-X",
                "utf8",
                str(CONVERTER),
                str(path),
                "--inspect-json",
                "--no-hash",
            ]
        )
        if result.returncode != 0:
            detail = (result.stderr or result.stdout or "未知错误").strip()
            raise RuntimeError(detail[-300:])
        payload = json.loads(result.stdout.strip())
        if not isinstance(payload, dict):
            raise ValueError("metadata response is not an object")
        return payload

    def _add_campaign_row(
        self,
        generation: int,
        info: CATALOG.CampaignFile,
        payload: Mapping[str, object] | None,
        status: str,
    ) -> None:
        if generation != self.scan_generation:
            return
        path_key = str(info.path)
        iid = "campaign-%d" % (len(self.campaign_rows) + 1)
        self.campaign_rows[path_key] = {
            "info": info,
            "payload": dict(payload) if payload is not None else None,
            "error": "",
            "status": status,
        }
        self.campaign_iids[path_key] = iid
        self.campaign_tree.insert(
            "",
            "end",
            iid=iid,
            values=CATALOG.row_values(
                info,
                payload,
                status,
                self.scan_source_root,
            ),
        )

    def _update_campaign_row(
        self,
        generation: int,
        info: CATALOG.CampaignFile,
        payload: Mapping[str, object] | None,
        error: str,
    ) -> None:
        if generation != self.scan_generation:
            return
        path_key = str(info.path)
        row = self.campaign_rows.get(path_key)
        iid = self.campaign_iids.get(path_key)
        if row is None or iid is None:
            return
        status = "可用" if payload is not None else "读取失败"
        row["payload"] = dict(payload) if payload is not None else None
        row["error"] = error
        row["status"] = status
        if payload is not None:
            self.campaign_cache[path_key] = CATALOG.cache_record(info, payload)
        self.campaign_tree.item(
            iid,
            values=CATALOG.row_values(
                info,
                payload,
                status,
                self.scan_source_root,
            ),
        )
        if self.campaign_tree.selection():
            self._campaign_selection_changed()

    def _finish_campaign_scan(
        self,
        generation: int,
        count: int,
        error: str,
    ) -> None:
        if generation != self.scan_generation:
            return
        if error:
            self.campaign_list_status_var.set("扫描失败：%s" % error[-180:])
        else:
            failed = sum(
                1
                for row in self.campaign_rows.values()
                if row.get("status") == "读取失败"
            )
            suffix = "，%d 个读取失败" % failed if failed else ""
            self.campaign_list_status_var.set(
                "扫描完成：%d 个战役%s" % (count, suffix)
            )
        save_campaign_cache(self.campaign_cache)
        if not self.campaign_tree.selection():
            selected = [
                self.campaign_iids[path]
                for path in self.saved_selection
                if path in self.campaign_iids
            ]
            if selected:
                self.campaign_tree.selection_set(*selected)
            elif count:
                first = self.campaign_tree.get_children()
                if first:
                    self.campaign_tree.selection_set(first[0])
        self._campaign_selection_changed()

    def _selected_campaign_paths(self) -> list[Path]:
        result: list[Path] = []
        for iid in self.campaign_tree.selection():
            for path, mapped_iid in self.campaign_iids.items():
                if mapped_iid == iid:
                    result.append(Path(path))
                    break
        return result

    def _campaign_selection_changed(self) -> None:
        paths = self._selected_campaign_paths()
        if not paths:
            self.campaign_name_var.set("尚未选择战役")
            self.campaign_details_var.set("从上方列表选择一个或多个战役。")
            self._update_campaign_actions()
            return
        if len(paths) == 1:
            row = self.campaign_rows[str(paths[0])]
            payload = row.get("payload")
            if isinstance(payload, dict):
                name, details = format_campaign_preview(payload)
                self.campaign_name_var.set(name)
                self.campaign_details_var.set(details)
            else:
                self.campaign_name_var.set("无法读取战役信息")
                self.campaign_details_var.set(
                    "文件：%s\n%s"
                    % (paths[0].name, row.get("error") or "后台读取失败")
                )
        else:
            names = [
                CATALOG.campaign_title(
                    self.campaign_rows[str(path)].get("payload")
                    if isinstance(self.campaign_rows[str(path)].get("payload"), dict)
                    else None,
                    path.stem,
                )
                for path in paths
            ]
            self.campaign_name_var.set("已选择 %d 个战役" % len(paths))
            self.campaign_details_var.set(
                "将按列表顺序逐个处理：\n" + "\n".join(names[:8])
                + ("\n…" if len(names) > 8 else "")
            )
        self._update_campaign_actions()

    def _update_campaign_actions(self) -> None:
        if not hasattr(self, "start_button"):
            return
        enabled = self.process is None and bool(self._selected_campaign_paths())
        self.start_button.configure(state="normal" if enabled else "disabled")

    def _select_all_campaigns(self) -> None:
        children = self.campaign_tree.get_children()
        if children:
            self.campaign_tree.selection_set(*children)
            self._campaign_selection_changed()

    def _clear_campaign_selection(self) -> None:
        self.campaign_tree.selection_remove(*self.campaign_tree.selection())
        self._campaign_selection_changed()

    def _refresh_campaigns(self) -> None:
        self._source_changed()

    def _pick_file(self) -> None:
        initial = Path(self.source_var.get()) if self.source_var.get() else DZ_DIR
        if initial.is_file():
            initial = initial.parent
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
        selected_paths = self._selected_campaign_paths()
        if not selected_paths:
            messagebox.showerror("未选择战役", "请先从战役列表中选择至少一个 W3N。", parent=self)
            return
        source = Path(self.source_var.get().strip()).resolve()
        if not source.exists():
            messagebox.showerror("路径无效", "源战役或目录不存在。", parent=self)
            return
        if not PYTHON.is_file() or not CONVERTER.is_file():
            messagebox.showerror("工具不完整", "Python 环境或底层转换器不存在。", parent=self)
            return
        command_source = selected_paths[0] if len(selected_paths) == 1 else (
            source if source.is_dir() else selected_paths[0].parent
        )
        arguments = [str(PYTHON), "-u", str(CONVERTER), str(command_source)]
        if len(selected_paths) > 1:
            for path in selected_paths:
                arguments.extend(["--campaign-file", str(path)])
        output = self.output_var.get().strip()
        if output:
            arguments.extend(["--output-dir", output])
        if self.overwrite_var.get() and not self.extract_only_var.get():
            arguments.append("--overwrite")
        if self.extract_only_var.get():
            arguments.append("--extract-only")
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
                "selected_campaigns": [str(path) for path in selected_paths],
                "output": output,
                "target": target,
                "clean_rederive": self.clean_rederive_var.get(),
                "fix_loading_art": self.fix_loading_art_var.get(),
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
                elif kind == "campaign_row":
                    generation, info, payload, status = value
                    self._add_campaign_row(generation, info, payload, str(status))
                elif kind == "campaign_metadata":
                    generation, info, payload, error = value
                    self._update_campaign_row(
                        generation,
                        info,
                        payload if isinstance(payload, dict) else None,
                        str(error),
                    )
                elif kind == "campaign_scan_done":
                    generation, count, error = value
                    self._finish_campaign_scan(
                        generation,
                        int(count),
                        str(error),
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
        self._update_campaign_actions()
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
