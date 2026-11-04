# -*- mode: python ; coding: utf-8 -*-
from pathlib import Path


app_dir = Path(SPECPATH)
root = app_dir.parents[1]
wing_source = next((root / "maps").glob("*.w3x.orig"))

datas = [
    (str(app_dir), "tools/alas-offline"),
    (
        str(root / "tools" / "recover" / "patch_forsaken_301_wct.py"),
        "tools/recover",
    ),
    (
        str(
            root / "tools" / "recover"
            / "patch_forsaken_301_source_fixes.py"
        ),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "compact_campaign.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "compact_map.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "offline_save_repair.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "compute_map_checksum.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "research_map_checksum.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "w3z_probe.js"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "patch_w3z_map_identity.js"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "w3z_map_checksum_repair" / "w3z.py"),
        "tools/recover/w3z_map_checksum_repair",
    ),
    (
        str(
            root / "tools" / "recover"
            / "w3z_map_checksum_repair" / "statstring.py"
        ),
        "tools/recover/w3z_map_checksum_repair",
    ),
    (
        str(
            root / "tools" / "recover"
            / "w3z_map_checksum_repair" / "README.txt"
        ),
        "tools/recover/w3z_map_checksum_repair",
    ),
    (
        str(
            root / "tools" / "recover"
            / "w3z_map_checksum_repair" / "LICENSE"
        ),
        "tools/recover/w3z_map_checksum_repair",
    ),
    (
        str(root / "tools" / "recover" / "patch_forsaken_pest_bug.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "patch_forsaken_sapper_tunnel.py"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "forsaken_pest_nest_death.lua"),
        "tools/recover",
    ),
    (
        str(root / "tools" / "recover" / "forsaken_sapper_tunnel_fix.lua"),
        "tools/recover",
    ),
    (str(root / "tools" / "war3map-injector"), "tools/war3map-injector"),
    (str(root / "scripts"), "scripts"),
    (str(root / "heroes"), "heroes"),
    (str(root / "maps" / "_wing_src"), "maps/_wing_src"),
    (str(wing_source), "maps/" + wing_source.name),
    (
        str(
            root / "maps" / "port" / "lost_temple_30"
            / "LostTempleLV_BladeMaster30.w3x"
        ),
        "maps/port/lost_temple_30",
    ),
]

doctor_root = root / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
doctor_destination = "tools/_devos-map-doctor/devos-map-doctor-main"
for source in doctor_root.rglob("*"):
    if not source.is_file():
        continue
    relative = source.relative_to(doctor_root)
    if (
        any(part.startswith(".") or part == "__pycache__" for part in relative.parts)
        or relative.parts[0] not in {
            "assets", "doctor", "docs", "externos", "native",
        }
        and relative.as_posix() != "DevosMapDoctor.py"
    ):
        continue
    datas.append(
        (
            str(source),
            str(Path(doctor_destination) / Path(relative).parent),
        )
    )

hiddenimports = [
    "tkinter",
    "tkinter.ttk",
    "tkinter.scrolledtext",
    "tkinter.filedialog",
    "tkinter.messagebox",
    "PIL",
    "PIL.Image",
    "PIL.ImageOps",
    "doctor.fix.shrink",
    "doctor.triggers.wtg",
    "numpy",
    "ctypes.wintypes",
    "msvcrt",
    "winreg",
]

a = Analysis(
    [str(app_dir / "launcher.py")],
    pathex=[
        str(root / "tools" / "war3map-injector"),
        str(doctor_root),
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
    name="ALAS-Offline",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

exe_worker = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name="ALAS-Offline-Worker",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

coll = COLLECT(
    exe_gui,
    exe_worker,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name="ALAS-Offline",
)
