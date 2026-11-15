from __future__ import annotations

import contextlib
import queue
import sys
import threading
import traceback
from datetime import datetime
from pathlib import Path
import tkinter as tk
from tkinter import filedialog, messagebox, ttk


TOOL_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(TOOL_DIR))

import offline_save_repair as repair  # noqa: E402


BG = "#15171c"
PANEL = "#20232a"
PANEL_ALT = "#272b34"
BORDER = "#343a46"
TEXT = "#f2f4f7"
MUTED = "#9ba5b4"
ACCENT = "#4f8cff"
ACCENT_HOVER = "#6a9dff"
SUCCESS = "#3ddc97"
WARNING = "#f4b860"


class QueueWriter:
    def __init__(self, messages):
        self.messages = messages

    def write(self, text):
        if text:
            self.messages.put(text)
        return len(text)

    def flush(self):
        pass

    def isatty(self):
        return False


class SaveRepairApp:
    def __init__(self, root):
        self.root = root
        self.campaign = repair.default_campaign()
        self.save_dir = None
        self.save_paths = []
        self.path_by_row = {}
        self.busy = False
        self.running_row = None
        self.action_widgets = []
        self.log_queue = queue.Queue()
        self.operation_result = queue.Queue()
        self._configure_window()
        self._configure_styles()
        self._build_ui()
        self._poll_queues()
        if self.campaign:
            self._load_campaign(self.campaign)

    def _configure_window(self):
        self.root.title("ALAS 存档修复工具")
        screen_width = self.root.winfo_screenwidth()
        screen_height = self.root.winfo_screenheight()
        width = min(1000, max(840, screen_width - 140))
        height = min(820, max(640, screen_height - 120))
        left = max(0, (screen_width - width) // 2)
        top = max(0, (screen_height - height) // 2)
        self.root.geometry(f"{width}x{height}+{left}+{top}")
        self.root.minsize(820, 600)
        self.root.configure(bg=BG)
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)

    def _configure_styles(self):
        style = ttk.Style(self.root)
        style.theme_use("clam")
        style.configure(".", font=("Microsoft YaHei UI", 10))
        style.configure("App.TFrame", background=BG)
        style.configure("Panel.TFrame", background=PANEL)
        style.configure("Alt.TFrame", background=PANEL_ALT)
        style.configure(
            "Title.TLabel",
            background=BG,
            foreground=TEXT,
            font=("Microsoft YaHei UI", 19, "bold"),
        )
        style.configure(
            "Subtitle.TLabel",
            background=BG,
            foreground=MUTED,
            font=("Microsoft YaHei UI", 10),
        )
        style.configure(
            "Section.TLabel",
            background=PANEL,
            foreground=TEXT,
            font=("Microsoft YaHei UI", 11, "bold"),
        )
        style.configure(
            "Field.TLabel",
            background=PANEL,
            foreground=MUTED,
        )
        style.configure(
            "Value.TLabel",
            background=PANEL,
            foreground=TEXT,
        )
        style.configure(
            "Hint.TLabel",
            background=BG,
            foreground=MUTED,
            font=("Microsoft YaHei UI", 9),
        )
        style.configure(
            "Status.TLabel",
            background=BG,
            foreground=MUTED,
        )
        style.configure(
            "Path.TEntry",
            fieldbackground=PANEL_ALT,
            foreground=TEXT,
            bordercolor=BORDER,
            insertcolor=TEXT,
            padding=8,
        )
        style.map(
            "Path.TEntry",
            fieldbackground=[("readonly", PANEL_ALT)],
            foreground=[("readonly", TEXT)],
        )
        style.configure(
            "TButton",
            background=PANEL_ALT,
            foreground=TEXT,
            bordercolor=BORDER,
            padding=(14, 8),
            font=("Microsoft YaHei UI", 10),
        )
        style.map(
            "TButton",
            background=[
                ("active", "#343945"),
                ("pressed", "#3d4351"),
                ("disabled", "#242830"),
            ],
            foreground=[("disabled", "#687180")],
        )
        style.configure(
            "Accent.TButton",
            background=ACCENT,
            foreground="#ffffff",
            bordercolor=ACCENT,
            padding=(18, 9),
            font=("Microsoft YaHei UI", 10, "bold"),
        )
        style.map(
            "Accent.TButton",
            background=[
                ("active", ACCENT_HOVER),
                ("pressed", "#3b76dc"),
                ("disabled", "#354b77"),
            ],
            foreground=[("disabled", "#9aa8c1")],
        )
        style.configure(
            "Treeview",
            background=PANEL_ALT,
            fieldbackground=PANEL_ALT,
            foreground=TEXT,
            bordercolor=BORDER,
            rowheight=32,
        )
        style.map(
            "Treeview",
            background=[("selected", ACCENT)],
            foreground=[("selected", "#ffffff")],
        )
        style.configure(
            "Treeview.Heading",
            background="#303541",
            foreground=TEXT,
            bordercolor=BORDER,
            relief="flat",
            padding=(8, 8),
            font=("Microsoft YaHei UI", 10, "bold"),
        )
        style.map(
            "Treeview.Heading",
            background=[("active", "#3a404d")],
        )
        style.configure(
            "Vertical.TScrollbar",
            background=PANEL_ALT,
            troughcolor=PANEL,
            bordercolor=BORDER,
            arrowcolor=MUTED,
        )
        style.configure(
            "Horizontal.TProgressbar",
            background=ACCENT,
            troughcolor=PANEL_ALT,
            bordercolor=BORDER,
            lightcolor=ACCENT,
            darkcolor=ACCENT,
        )

    def _build_ui(self):
        outer = ttk.Frame(self.root, style="App.TFrame", padding=(22, 18, 22, 16))
        outer.pack(fill="both", expand=True)

        ttk.Label(outer, text="ALAS 存档修复", style="Title.TLabel").pack(anchor="w")
        ttk.Label(
            outer,
            text="选择战役后自动读取主存档；章节伴随快照会随所选存档一起校验。",
            style="Subtitle.TLabel",
        ).pack(anchor="w", pady=(3, 14))

        selector = tk.Frame(
            outer,
            bg=PANEL,
            highlightbackground=BORDER,
            highlightthickness=1,
            padx=14,
            pady=12,
        )
        selector.pack(fill="x")

        ttk.Label(selector, text="战役文件", style="Field.TLabel").grid(
            row=0, column=0, sticky="w", padx=(0, 10), pady=(0, 7)
        )
        self.campaign_var = tk.StringVar()
        self.campaign_entry = ttk.Entry(
            selector,
            textvariable=self.campaign_var,
            style="Path.TEntry",
            state="readonly",
        )
        self.campaign_entry.grid(
            row=0, column=1, sticky="ew", padx=(0, 10), pady=(0, 7)
        )
        campaign_button = ttk.Button(
            selector,
            text="选择战役…",
            command=self._choose_campaign,
        )
        campaign_button.grid(row=0, column=2, pady=(0, 7))
        self.action_widgets.append(campaign_button)

        ttk.Label(selector, text="存档目录", style="Field.TLabel").grid(
            row=1, column=0, sticky="w", padx=(0, 10)
        )
        self.save_dir_var = tk.StringVar()
        ttk.Entry(
            selector,
            textvariable=self.save_dir_var,
            style="Path.TEntry",
            state="readonly",
        ).grid(row=1, column=1, sticky="ew", padx=(0, 10))
        directory_button = ttk.Button(
            selector,
            text="更改目录…",
            command=self._choose_save_directory,
        )
        directory_button.grid(row=1, column=2)
        self.action_widgets.append(directory_button)
        selector.columnconfigure(1, weight=1)

        list_card = tk.Frame(
            outer,
            bg=PANEL,
            highlightbackground=BORDER,
            highlightthickness=1,
            padx=14,
            pady=12,
        )
        list_card.pack(fill="both", expand=True, pady=(12, 0))

        list_header = ttk.Frame(list_card, style="Panel.TFrame")
        list_header.pack(fill="x", pady=(0, 8))
        ttk.Label(
            list_header,
            text="选择要修复的存档",
            style="Section.TLabel",
        ).pack(side="left")
        refresh_button = ttk.Button(
            list_header,
            text="重新读取",
            command=self._refresh_saves,
        )
        refresh_button.pack(side="right")
        self.action_widgets.append(refresh_button)

        tree_frame = ttk.Frame(list_card, style="Panel.TFrame")
        tree_frame.pack(fill="both", expand=True)
        self.tree = ttk.Treeview(
            tree_frame,
            columns=("name", "modified", "size", "status"),
            show="headings",
            selectmode="browse",
            height=8,
        )
        self.tree.heading("name", text="存档名称")
        self.tree.heading("modified", text="修改时间")
        self.tree.heading("size", text="大小")
        self.tree.heading("status", text="状态")
        self.tree.column("name", width=300, minwidth=180, anchor="w")
        self.tree.column("modified", width=175, minwidth=155, anchor="center")
        self.tree.column("size", width=100, minwidth=85, anchor="e")
        self.tree.column("status", width=250, minwidth=160, anchor="w")
        scrollbar = ttk.Scrollbar(
            tree_frame,
            orient="vertical",
            command=self.tree.yview,
        )
        self.tree.configure(yscrollcommand=scrollbar.set)
        self.tree.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        self.tree.bind("<<TreeviewSelect>>", self._on_save_selected)
        self.tree.bind("<Double-1>", lambda _event: self._start(apply=False))

        self.detail_var = tk.StringVar(value="尚未选择存档")
        ttk.Label(
            list_card,
            textvariable=self.detail_var,
            style="Field.TLabel",
            wraplength=900,
        ).pack(anchor="w", pady=(8, 9))

        actions = ttk.Frame(list_card, style="Panel.TFrame")
        actions.pack(fill="x")
        validate_button = ttk.Button(
            actions,
            text="仅校验",
            command=lambda: self._start(apply=False),
        )
        validate_button.pack(side="left")
        self.action_widgets.append(validate_button)
        repair_button = ttk.Button(
            actions,
            text="修复选中存档",
            style="Accent.TButton",
            command=lambda: self._start(apply=True),
        )
        repair_button.pack(side="left", padx=(9, 0))
        self.action_widgets.append(repair_button)

        self.progress = ttk.Progressbar(
            actions,
            mode="indeterminate",
            length=180,
        )
        self.progress.pack(side="right")

        log_card = tk.Frame(
            outer,
            bg=PANEL,
            highlightbackground=BORDER,
            highlightthickness=1,
            padx=14,
            pady=10,
        )
        log_card.pack(fill="both", expand=False, pady=(12, 0))
        ttk.Label(
            log_card,
            text="运行记录",
            style="Section.TLabel",
        ).pack(anchor="w", pady=(0, 7))
        log_frame = tk.Frame(log_card, bg=PANEL)
        log_frame.pack(fill="both", expand=True)
        self.log = tk.Text(
            log_frame,
            height=6,
            bg="#111318",
            fg="#c9d1dc",
            insertbackground=TEXT,
            relief="flat",
            borderwidth=0,
            padx=10,
            pady=8,
            font=("Cascadia Mono", 9),
            state="disabled",
            wrap="word",
        )
        log_scroll = ttk.Scrollbar(
            log_frame,
            orient="vertical",
            command=self.log.yview,
        )
        self.log.configure(yscrollcommand=log_scroll.set)
        self.log.pack(side="left", fill="both", expand=True)
        log_scroll.pack(side="right", fill="y")

        footer = ttk.Frame(outer, style="App.TFrame")
        footer.pack(fill="x", pady=(10, 0))
        self.status_var = tk.StringVar(value="就绪")
        ttk.Label(
            footer,
            textvariable=self.status_var,
            style="Status.TLabel",
        ).pack(side="left")
        ttk.Label(
            footer,
            text="修复会先备份；完成后请关闭并重开游戏再加载。",
            style="Hint.TLabel",
        ).pack(side="right")

    def _choose_campaign(self):
        selected = repair.choose_campaign_file(
            self.campaign,
            parent=self.root,
        )
        if selected:
            self._load_campaign(selected)

    def _load_campaign(self, campaign):
        self.campaign = Path(campaign)
        self.campaign_var.set(str(self.campaign))
        candidates = repair.discover_main_saves(self.campaign)
        if candidates:
            self.save_dir = candidates[0].parent
        else:
            self.save_dir = None
        self._populate_saves(candidates)
        if not candidates:
            self._append_log("未找到该战役的主存档，可点击“更改目录…”手动指定。\n")

    def _choose_save_directory(self):
        selected = repair.choose_save_directory(
            self.save_dir,
            parent=self.root,
        )
        if not selected:
            return
        self.save_dir = Path(selected)
        candidates = repair.discover_main_saves(self.campaign, self.save_dir)
        self._populate_saves(candidates)
        if not candidates:
            self._append_log("所选目录中没有找到主 .w3z 存档。\n")

    def _refresh_saves(self):
        if not self.campaign:
            return
        candidates = repair.discover_main_saves(
            self.campaign,
            self.save_dir,
        )
        if not candidates and self.save_dir is None:
            candidates = repair.discover_main_saves(self.campaign)
        if candidates:
            self.save_dir = candidates[0].parent
        self._populate_saves(candidates)

    def _populate_saves(self, candidates):
        self.tree.delete(*self.tree.get_children())
        self.path_by_row.clear()
        self.save_paths = list(candidates)
        self.save_dir_var.set(str(self.save_dir) if self.save_dir else "")
        for index, path in enumerate(candidates):
            stat = path.stat()
            row_id = str(index)
            self.path_by_row[row_id] = path
            modified = datetime.fromtimestamp(stat.st_mtime).strftime(
                "%Y-%m-%d %H:%M:%S"
            )
            self.tree.insert(
                "",
                "end",
                iid=row_id,
                values=(
                    path.stem,
                    modified,
                    f"{stat.st_size / (1024 * 1024):.1f} MB",
                    "尚未校验",
                ),
            )
        if candidates:
            self.tree.selection_set("0")
            self.tree.focus("0")
            self._on_save_selected()
            self.status_var.set(f"已读取 {len(candidates)} 个主存档")
        else:
            self.detail_var.set("尚未选择存档")
            self.status_var.set("没有可用的主存档")

    def _selected_save(self):
        selection = self.tree.selection()
        if not selection:
            return None
        return self.path_by_row.get(selection[0])

    def _on_save_selected(self, _event=None):
        selected = self._selected_save()
        if selected is None:
            self.detail_var.set("尚未选择存档")
            return
        try:
            bundle = repair.selected_save_bundle(
                self.campaign,
                self.save_dir,
                selected,
            )
            companion_count = max(0, len(bundle) - 1)
            self.detail_var.set(
                f"{selected.name}  ·  {selected.parent}  ·  "
                f"伴随快照 {companion_count} 个"
            )
        except Exception as exc:  # noqa: BLE001
            self.detail_var.set(f"{selected.name}  ·  {exc}")

    def _start(self, apply):
        if self.busy:
            return
        selected = self._selected_save()
        if selected is None:
            messagebox.showinfo(
                "未选择存档",
                "请先在列表中选择一个存档。",
                parent=self.root,
            )
            return
        if apply:
            if repair.game_running():
                proceed = messagebox.askyesno(
                    "游戏正在运行",
                    "可以直接修复磁盘上的存档并自动备份，"
                    "但游戏不会立即刷新。\n\n"
                    "修复后请关闭并重开游戏，且在关闭前不要再次保存，"
                    "否则可能覆盖修复结果。\n\n是否继续修复？",
                    parent=self.root,
                )
            else:
                proceed = messagebox.askyesno(
                    "确认修复",
                    f"将修复：{selected.name}\n\n"
                    "工具会先校验完整存档包，通过后自动备份并写回。",
                    parent=self.root,
                )
            if not proceed:
                return

        self._set_busy(True, "正在修复…" if apply else "正在校验…")
        self.running_row = self.tree.selection()[0]
        self._append_log(
            f"\n===== {datetime.now():%Y-%m-%d %H:%M:%S} "
            f"{'修复' if apply else '校验'} {selected.name} =====\n"
        )
        threading.Thread(
            target=self._worker,
            args=(selected, apply),
            daemon=True,
        ).start()

    def _worker(self, selected, apply):
        writer = QueueWriter(self.log_queue)
        try:
            with contextlib.redirect_stdout(writer), contextlib.redirect_stderr(writer):
                report = repair.repair_saves(
                    self.campaign,
                    self.save_dir,
                    apply,
                    selected_save=selected,
                )
            self.operation_result.put((bool(report.get("ok")), ""))
        except Exception as exc:  # noqa: BLE001
            detail = "".join(traceback.format_exception_only(type(exc), exc)).strip()
            self.operation_result.put((False, detail))

    def _set_busy(self, busy, status=None):
        self.busy = busy
        if status:
            self.status_var.set(status)
        state = "disabled" if busy else "normal"
        for widget in self.action_widgets:
            widget.configure(state=state)
        if busy:
            self.progress.start(12)
        else:
            self.progress.stop()

    def _append_log(self, text):
        self.log.configure(state="normal")
        self.log.insert("end", text)
        self.log.see("end")
        self.log.configure(state="disabled")

    def _poll_queues(self):
        chunks = []
        while True:
            try:
                chunks.append(self.log_queue.get_nowait())
            except queue.Empty:
                break
        if chunks:
            self._append_log("".join(chunks))

        try:
            success, error = self.operation_result.get_nowait()
        except queue.Empty:
            success = None
        if success is not None:
            self._set_busy(False)
            if success:
                self.status_var.set("完成")
                self._mark_selected_status("校验通过")
                self._append_log("操作完成。\n")
            else:
                self.status_var.set("失败")
                self._mark_selected_status("失败")
                self._append_log(f"操作失败：{error}\n")
                messagebox.showerror(
                    "操作失败",
                    error or "修复未完成，请查看运行记录。",
                    parent=self.root,
                )
            self.running_row = None
        self.root.after(100, self._poll_queues)

    def _on_close(self):
        if self.busy:
            messagebox.showinfo(
                "操作进行中",
                "存档正在校验或修复，请等待完成后再关闭。",
                parent=self.root,
            )
            return
        self.root.destroy()

    def _mark_selected_status(self, status):
        row = self.running_row or (self.tree.selection()[0] if self.tree.selection() else None)
        if row is None:
            return
        values = list(self.tree.item(row, "values"))
        if len(values) == 4:
            values[3] = status
            self.tree.item(row, values=values)


def main():
    root = tk.Tk()
    SaveRepairApp(root)
    root.mainloop()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
