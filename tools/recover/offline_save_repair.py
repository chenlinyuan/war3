#!/usr/bin/env python3
"""Offline W3Z map-identity repair for the Alas campaign.

This tool never touches saved Lua or task state. It reads the current campaign,
rebinds each save to the matching chapter map identity, verifies every W3Z
block, and only then replaces the original save after making a backup.
"""

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(HERE / "w3z_map_checksum_repair"))

import war3mpq  # noqa: E402
import w3z as save_w3z  # noqa: E402
from compute_map_checksum import map_checksum  # noqa: E402

NODE = shutil.which("node")
PROBE = HERE / "w3z_probe.js"
PATCH = HERE / "patch_w3z_map_identity.js"
MAP_SUFFIXES = (".w3x", ".w3m")


def fail(message):
    raise RuntimeError(message)


def hidden_process_options():
    """Prevent console child processes from flashing when launched by the GUI."""
    if sys.platform != "win32":
        return {}
    startupinfo = subprocess.STARTUPINFO()
    startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    startupinfo.wShowWindow = subprocess.SW_HIDE
    return {
        "creationflags": subprocess.CREATE_NO_WINDOW,
        "startupinfo": startupinfo,
    }


def run_hidden(command, **kwargs):
    return subprocess.run(
        command,
        **hidden_process_options(),
        **kwargs,
    )


def default_campaign():
    folder = Path.home() / "Documents" / "Warcraft III" / "Campaigns"
    candidates = sorted(
        folder.glob("alas*被遗忘的王国*.w3n"),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    if candidates:
        return candidates[0]
    fallback = sorted(
        folder.glob("alas*.w3n"),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    return fallback[0] if fallback else None


def default_save_dir():
    root = Path.home() / "Documents" / "Warcraft III" / "BattleNet"
    candidates = [
        path
        for path in root.glob("*/Campaigns/Custom/alas*")
        if path.is_dir() and any(path.glob("*.w3z"))
    ]
    candidates.sort(
        key=lambda path: max(item.stat().st_mtime for item in path.glob("*.w3z")),
        reverse=True,
    )
    return candidates[0] if candidates else None


def discover_main_saves(campaign, save_dir=None):
    directories = []
    if save_dir:
        directories.append(Path(save_dir))
    else:
        root = Path.home() / "Documents" / "Warcraft III" / "BattleNet"
        stem = campaign.stem.casefold()
        if root.is_dir():
            for profile_dir in root.iterdir():
                custom = profile_dir / "Campaigns" / "Custom"
                if not custom.is_dir():
                    continue
                for directory in custom.iterdir():
                    if directory.is_dir() and directory.name.casefold() == stem:
                        directories.append(directory)
    saves = []
    seen = set()
    for directory in directories:
        for path in directory.iterdir():
            if not path.is_file() or path.suffix.lower() != ".w3z":
                continue
            key = str(path.resolve()).casefold()
            if key in seen:
                continue
            seen.add(key)
            saves.append(path)
    saves.sort(key=lambda path: path.stat().st_mtime, reverse=True)
    return saves


def choose_campaign_file(default, parent=None):
    import tkinter as tk
    from tkinter import filedialog

    owner = parent
    if owner is None:
        owner = tk.Tk()
        owner.withdraw()
        owner.attributes("-topmost", True)
    try:
        initial = default if default and Path(default).exists() else (
            Path.home() / "Documents" / "Warcraft III" / "Campaigns"
        )
        selected = filedialog.askopenfilename(
            parent=owner,
            title="选择要修复的 Warcraft III 战役",
            initialdir=str(Path(initial).parent if Path(initial).is_file() else initial),
            filetypes=(
                ("Warcraft III 战役", "*.w3n"),
                ("所有文件", "*.*"),
            ),
        )
    finally:
        if parent is None:
            owner.destroy()
    return Path(selected) if selected else None


def choose_save_file(candidates):
    import tkinter as tk
    from tkinter import messagebox, ttk

    root = tk.Tk()
    root.title("选择要修复的存档")
    root.geometry("780x420")
    root.minsize(620, 320)
    root.attributes("-topmost", True)
    chosen = {}

    frame = ttk.Frame(root, padding=12)
    frame.pack(fill="both", expand=True)
    ttk.Label(
        frame,
        text="选择一个主存档。对应的章节伴随快照会自动一起校验和修复。",
    ).pack(anchor="w", pady=(0, 8))

    table = ttk.Treeview(
        frame,
        columns=("name", "modified", "size"),
        show="headings",
        selectmode="browse",
    )
    table.heading("name", text="存档")
    table.heading("modified", text="修改时间")
    table.heading("size", text="大小")
    table.column("name", width=360, anchor="w")
    table.column("modified", width=165, anchor="center")
    table.column("size", width=90, anchor="e")
    scrollbar = ttk.Scrollbar(frame, orient="vertical", command=table.yview)
    table.configure(yscrollcommand=scrollbar.set)
    table.pack(side="left", fill="both", expand=True)
    scrollbar.pack(side="right", fill="y")

    by_row = {}
    for index, path in enumerate(candidates):
        stat = path.stat()
        row_id = str(index)
        by_row[row_id] = path
        modified = datetime.fromtimestamp(stat.st_mtime).strftime(
            "%Y-%m-%d %H:%M:%S"
        )
        size = f"{stat.st_size / (1024 * 1024):.1f} MB"
        table.insert("", "end", iid=row_id, values=(path.stem, modified, size))

    def accept(_event=None):
        selection = table.selection()
        if not selection:
            messagebox.showinfo("未选择存档", "请先选择一个存档。", parent=root)
            return
        chosen["path"] = by_row[selection[0]]
        root.destroy()

    buttons = ttk.Frame(frame)
    buttons.pack(fill="x", pady=(8, 0))
    ttk.Button(buttons, text="取消", command=root.destroy).pack(side="right")
    ttk.Button(buttons, text="修复此存档", command=accept).pack(
        side="right", padx=(0, 8)
    )
    table.bind("<Double-1>", accept)
    table.bind("<Return>", accept)
    if candidates:
        first = "0"
        table.selection_set(first)
        table.focus(first)
    root.mainloop()
    return chosen.get("path")


def choose_save_directory(default, parent=None):
    import tkinter as tk
    from tkinter import filedialog

    owner = parent
    if owner is None:
        owner = tk.Tk()
        owner.withdraw()
        owner.attributes("-topmost", True)
    try:
        initial = default if default and Path(default).is_dir() else (
            Path.home() / "Documents" / "Warcraft III" / "BattleNet"
        )
        selected = filedialog.askdirectory(
            parent=owner,
            title="选择包含 .w3z 存档的文件夹",
            initialdir=str(initial),
            mustexist=True,
        )
    finally:
        if parent is None:
            owner.destroy()
    return Path(selected) if selected else None


def selected_save_bundle(campaign, save_dir, selected_save):
    save_paths = [selected_save]
    custom_root = save_dir / "CustomSaves" / campaign.stem
    companion_roots = (
        custom_root / "Blizzard" / selected_save.stem,
        custom_root / "CustomSaves" / selected_save.stem,
        custom_root / "FKManualSaves" / selected_save.stem,
        custom_root / "Blizzard" / "Zones",
    )
    for companion_root in companion_roots:
        if companion_root.is_dir():
            save_paths.extend(
                path for path in companion_root.rglob("*.w3z")
                if path.is_file()
            )
    unique = []
    seen = set()
    for path in save_paths:
        key = str(path.resolve()).casefold()
        if key in seen:
            continue
        seen.add(key)
        unique.append(path)
    return unique


def run_json(command):
    result = run_hidden(
        command,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    if result.returncode:
        fail(
            f"command failed ({result.returncode}): {' '.join(map(str, command))}\n"
            f"{result.stderr or result.stdout}"
        )
    text = result.stdout.strip()
    if not text:
        fail(f"command produced no JSON: {' '.join(map(str, command))}")
    return json.loads(text)


def campaign_identities(campaign):
    archive = war3mpq.MPQArchive(str(campaign))
    identities = {}
    with tempfile.TemporaryDirectory(prefix="alas-map-identity-") as temp:
        temp_dir = Path(temp)
        try:
            names = [
                name for name in archive.files()
                if name.lower().endswith(MAP_SUFFIXES)
            ]
            if not names:
                fail("campaign has no chapter maps")
            for name in names:
                data = archive.read_file(name)
                if not data:
                    continue
                path = temp_dir / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(data)
                checksum, _ = map_checksum(str(path))
                identities[name.lower()] = {
                    "name": name,
                    "checksum": checksum.to_bytes(4, "little").hex(),
                    "sha1": hashlib.sha1(data).hexdigest(),
                    "size": len(data),
                }
        finally:
            archive.close()
    return identities


def game_running():
    result = run_hidden(
        ["tasklist", "/FI", "IMAGENAME eq Warcraft III.exe"],
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    return "warcraft iii.exe" in (result.stdout or "").lower()


def decode_settings(encoded):
    decoded = bytearray()
    mask = 0
    for index, value in enumerate(encoded):
        if index % 8 == 0:
            mask = value
        else:
            decoded.append(
                value if mask & (1 << (index % 8)) else value - 1
            )
    return bytes(decoded)


def encode_settings(decoded):
    output = bytearray()
    for offset in range(0, len(decoded), 7):
        mask = 1
        group = bytearray(decoded[offset:offset + 7])
        for index in range(len(group)):
            if group[index] & 1:
                mask |= 1 << (index + 1)
            else:
                group[index] += 1
        output.append(mask)
        output.extend(group)
    return bytes(output)


def save_identity(path):
    _, info, blocks = save_w3z.parse(str(path))
    if info["hcrc"] != info["hcrc_calc"] or info["end"] != info["filelen"]:
        fail(f"{path.name}: invalid save header or framing")
    bad_blocks = [
        index for index, block in enumerate(blocks)
        if block["ck"] != block["ck_calc"]
    ]
    if bad_blocks:
        fail(f"{path.name}: invalid save blocks {bad_blocks}")
    raw, _ = save_w3z.decompress(blocks)
    map_end = raw.index(0)
    map_name = raw[:map_end].decode("ascii")
    for start in range(map_end + 3, min(len(raw), 512)):
        if raw[start - 1] != 0 or raw[start - 2] != 0 or raw[start] == 0:
            continue
        end = raw.find(0, start)
        if end < 0 or end - start < 36:
            continue
        encoded = raw[start:end]
        decoded = decode_settings(encoded)
        if len(decoded) < 33 or encode_settings(decoded) != encoded:
            continue
        name_end = decoded.find(0, 13)
        if name_end < 0:
            continue
        identity_name = decoded[13:name_end].decode("ascii")
        if identity_name.lower().replace("\\", "/") == map_name.lower().replace("\\", "/"):
            return {
                "map": map_name,
                "checksum": decoded[9:13],
                "sha1": decoded[-20:],
                "info": info,
            }
    fail(f"{path.name}: save identity record not found")


def repair_saves(
    campaign,
    save_dir,
    apply_changes,
    selected_save=None,
    quiet=False,
):
    """Validate and optionally repair W3Z saves.

    Returns a JSON-serializable report. Raises RuntimeError if validation or
    repair fails; no original save is replaced until every selected file has
    passed the temporary-copy validation.
    """
    def emit(message):
        if not quiet:
            print(message)

    if NODE is None:
        fail("Node.js was not found on PATH")
    identities = campaign_identities(campaign)
    if selected_save:
        save_paths = selected_save_bundle(campaign, save_dir, selected_save)
    else:
        save_paths = sorted(
            path for path in save_dir.rglob("*.w3z") if path.is_file()
        )
    if not save_paths:
        fail("no W3Z saves found")
    if apply_changes and game_running():
        emit(
            "WARNING: Warcraft III is running. Files will be repaired on disk, "
            "but close and reopen the game before loading them. If the game "
            "saves again first, it may overwrite the repaired files."
        )

    companion_count = None
    if selected_save:
        companion_count = len(save_paths) - 1
        emit(f"Selected checkpoint: {selected_save}")
        emit(f"Companion snapshots: {companion_count}")

    rows = []
    with tempfile.TemporaryDirectory(prefix="alas-save-repair-") as temp:
        patched_dir = Path(temp) / "patched"
        patched_dir.mkdir()
        for save in save_paths:
            relative = save.relative_to(save_dir)
            try:
                summary = run_json([NODE, str(PROBE), str(save)])
                map_name = summary["prefixStrings"][0]["value"]
            except Exception as exc:  # noqa: BLE001
                rows.append(
                    {
                        "save": str(relative),
                        "status": "ERROR",
                        "error": str(exc),
                    }
                )
                continue
            identity = identities.get(map_name.lower())
            if identity is None:
                rows.append(
                    {
                        "save": str(relative),
                        "map": map_name,
                        "status": "SKIP: map not in campaign",
                    }
                )
                continue
            try:
                current = save_identity(save)
            except Exception as exc:  # noqa: BLE001
                rows.append(
                    {
                        "save": str(relative),
                        "map": map_name,
                        "status": "ERROR",
                        "error": str(exc),
                    }
                )
                continue
            target_checksum = bytes.fromhex(identity["checksum"])
            target_sha1 = bytes.fromhex(identity["sha1"])
            if (
                current["checksum"] == target_checksum
                and current["sha1"] == target_sha1
            ):
                rows.append(
                    {
                        "save": str(relative),
                        "map": identity["name"],
                        "status": "CURRENT",
                        "new_checksum": identity["checksum"],
                        "blocks": summary["header"]["blockCount"],
                    }
                )
                continue
            output = patched_dir / relative
            output.parent.mkdir(parents=True, exist_ok=True)
            try:
                patch_summary = run_json(
                    [
                        NODE,
                        str(PATCH),
                        str(save),
                        str(output),
                        identity["checksum"],
                        identity["sha1"],
                    ]
                )
                verification = run_json([NODE, str(PROBE), str(output)])
                if verification.get("trailerSize") != 0:
                    fail(f"{relative}: rebuilt save has an unsupported trailer")
            except Exception as exc:  # noqa: BLE001
                rows.append(
                    {
                        "save": str(relative),
                        "map": identity["name"],
                        "status": "ERROR",
                        "error": str(exc),
                    }
                )
                continue
            rows.append(
                {
                    "save": str(relative),
                    "map": identity["name"],
                    "status": "OK",
                    "old_checksum": patch_summary["oldChecksum"],
                    "new_checksum": patch_summary["newChecksum"],
                    "blocks": verification["header"]["blockCount"],
                    "output": output,
                    "source": save,
                }
            )

        failures = [row for row in rows if row["status"] not in ("OK", "CURRENT") and
                    not row["status"].startswith("SKIP:")]
        if failures:
            details = "\n".join(
                f"{row['save']}: {row['status']} {row.get('error', '')}"
                for row in failures
            )
            fail("one or more saves failed validation\n" + details)

        for row in rows:
            emit(
                f"{row['save']}: {row['status']} "
                f"{row.get('map', '')} "
                f"{row.get('old_checksum', '')}->{row.get('new_checksum', '')} "
                f"blocks={row.get('blocks', '')} "
                f"{row.get('error', '')}"
            )

        changed_rows = [row for row in rows if row["status"] == "OK"]
        backup_dir = None
        if apply_changes and changed_rows:
            backup_dir = save_dir.parent / (
                "save-repair-backup-"
                + datetime.now().strftime("%Y%m%d-%H%M%S")
            )
            backup_dir.mkdir(parents=True)
            for row in changed_rows:
                backup_path = backup_dir / row["source"].relative_to(save_dir)
                backup_path.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(row["source"], backup_path)
            for row in changed_rows:
                shutil.copy2(row["output"], row["source"])
            emit(f"Backup: {backup_dir}")
            emit(f"Applied: {len(changed_rows)} saves")
            emit(
                "Already current: "
                f"{sum(row['status'] == 'CURRENT' for row in rows)} saves"
            )
        elif not apply_changes:
            emit("DRY RUN: no save files were changed")
        elif not changed_rows:
            emit("No changes needed; no files were written.")

        reported_rows = []
        for row in rows:
            reported_rows.append(
                {
                    "save": row["save"],
                    "map": row.get("map"),
                    "status": row["status"],
                    "old_checksum": row.get("old_checksum"),
                    "new_checksum": row.get("new_checksum"),
                    "blocks": row.get("blocks"),
                    "error": row.get("error"),
                }
            )

        return {
            "ok": True,
            "dry_run": not apply_changes,
            "campaign": str(Path(campaign).resolve()),
            "save_dir": str(Path(save_dir).resolve()),
            "selected_save": (
                str(Path(selected_save).resolve()) if selected_save else None
            ),
            "companion_snapshots": companion_count,
            "changed": len(changed_rows),
            "already_current": sum(
                row["status"] == "CURRENT" for row in rows
            ),
            "skipped": sum(
                row["status"].startswith("SKIP:") for row in rows
            ),
            "backup": str(backup_dir) if backup_dir else None,
            "rows": reported_rows,
        }


def prompt_path(label, default):
    suffix = f" [{default}]" if default else ""
    value = input(f"{label}{suffix}: ").strip()
    return Path(value).expanduser() if value else default


def main():
    parser = argparse.ArgumentParser(
        description="Offline Alas W3Z map-identity repair"
    )
    parser.add_argument("--campaign", type=Path)
    parser.add_argument("--saves", type=Path)
    parser.add_argument("--save", type=Path)
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Write validated repairs to disk after creating a backup.",
    )
    parser.add_argument(
        "--yes",
        action="store_true",
        help="Do not ask interactive questions; fail if required paths are missing.",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Suppress human-readable progress output.",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Print one machine-readable JSON result and suppress other output.",
    )
    parser.add_argument(
        "--select",
        action="store_true",
        help="手动选择战役，然后从自动读取的存档列表中选择一个",
    )
    args = parser.parse_args()
    quiet = args.quiet or args.json

    campaign = args.campaign or default_campaign()
    save_dir = args.saves or default_save_dir()
    selected_save = args.save
    if args.select:
        if args.campaign is None:
            campaign = choose_campaign_file(campaign)
            if campaign is None:
                print("Cancelled.")
                return 0
        if selected_save is None:
            candidates = discover_main_saves(campaign, args.saves)
            if not candidates:
                save_dir = choose_save_directory(save_dir)
                if save_dir is None:
                    print("Cancelled.")
                    return 0
                candidates = discover_main_saves(campaign, save_dir)
                if not candidates:
                    fail("the selected campaign has no main .w3z saves")
            selected_save = choose_save_file(candidates)
            if selected_save is None:
                print("Cancelled.")
                return 0
    elif campaign is None or save_dir is None:
        if args.yes:
            fail(
                "could not auto-detect the campaign or save folder; "
                "pass --campaign and --save/--saves"
            )
        if not quiet:
            print("Could not auto-detect the campaign or save folder.")
        campaign = prompt_path("Campaign .w3n", campaign)
        save_dir = prompt_path("Save folder", save_dir)
    if selected_save:
        save_dir = selected_save.parent

    if not campaign or not campaign.is_file():
        fail("campaign file not found")
    if selected_save and not selected_save.is_file():
        fail("selected save file not found")
    if not save_dir or not save_dir.is_dir():
        fail("save folder not found")

    if not quiet:
        print(f"Campaign: {campaign}")
        print(f"Saves:    {save_dir}")
    apply_changes = args.apply
    if (
        not args.apply
        and not args.yes
        and not args.json
        and sys.stdin.isatty()
    ):
        answer = input(
            "Apply changes after validation? Type Y to repair, "
            "or press Enter for dry run: "
        ).strip().lower()
        apply_changes = answer in ("y", "yes")
    report = repair_saves(
        campaign,
        save_dir,
        apply_changes,
        selected_save=selected_save,
        quiet=quiet,
    )
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:  # noqa: BLE001
        if "--json" in sys.argv[1:]:
            print(
                json.dumps(
                    {"ok": False, "error": str(exc)},
                    ensure_ascii=False,
                    indent=2,
                )
            )
        else:
            print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
