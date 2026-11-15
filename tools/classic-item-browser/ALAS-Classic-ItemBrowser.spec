# -*- mode: python ; coding: utf-8 -*-
from pathlib import Path


app_dir = Path(SPECPATH)
root = app_dir.parents[1]
doctor_ref = (
    root / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
    / "externos" / "ref" / "1.24"
)
offline_assets = root / "tools" / "alas-offline" / "assets"

datas = [
    (
        str(app_dir / "classic_item_browser.py"),
        "tools/classic-item-browser",
    ),
    (str(app_dir / "README.md"), "tools/classic-item-browser"),
    (str(offline_assets / "pjass.exe"), "tools/alas-offline/assets"),
    (
        str(offline_assets / "game_item_catalog_classic.tsv"),
        "tools/alas-offline/assets",
    ),
]

injector_files = (
    "war3mpq.py",
    "merge_w3obj.py",
    "port_wings.py",
    "port_classic_item_browser_map.py",
    "collect_items.py",
    "collect_map_items.py",
    "gen_slk_tables.py",
    "build_fj.py",
    "paged_item_search.j",
    "classic_item_chat.j",
    "inject_native.py",
    "inject_all.py",
    "inject_script_manual.py",
    "inject_map.py",
    "hke_session.py",
    "fix_globals_order.py",
    "mpq_patch.py",
    "jass_gate.py",
    "reforged_compat.j",
    "_patch_hm3w_name.py",
    "_itemabil.txt",
)
for name in injector_files:
    datas.append(
        (
            str(root / "tools" / "war3map-injector" / name),
            "tools/war3map-injector",
        )
    )
for name in ("f.j", "g.j", "m.j"):
    datas.append(
        (
            str(root / "scripts" / "item-browser" / name),
            "scripts/item-browser",
        )
    )
for name in ("common.j", "blizzard.j"):
    datas.append(
        (
            str(doctor_ref / name),
            "tools/_devos-map-doctor/devos-map-doctor-main/externos/ref/1.24",
        )
    )

hiddenimports = [
    "argparse",
    "hashlib",
    "json",
    "queue",
    "re",
    "shutil",
    "struct",
    "subprocess",
    "threading",
    "time",
    "ctypes",
    "ctypes.wintypes",
    "zlib",
    "tkinter",
    "tkinter.ttk",
    "tkinter.scrolledtext",
    "tkinter.filedialog",
    "tkinter.messagebox",
]

a = Analysis(
    [str(app_dir / "classic_launcher.py")],
    pathex=[
        str(app_dir),
        str(root / "tools" / "war3map-injector"),
    ],
    binaries=[],
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=["pytest"],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe_gui = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name="ALAS-Classic-ItemBrowser",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
)

exe_worker = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name="ALAS-Classic-ItemBrowser-Worker",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
)

coll = COLLECT(
    exe_gui,
    exe_worker,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name="ALAS-Classic-ItemBrowser",
)
