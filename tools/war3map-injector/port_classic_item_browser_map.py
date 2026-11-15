"""Inject a 1.27-compatible item browser into one JASS map."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import stat
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import port_wings as P  # noqa: E402
import war3mpq as W  # noqa: E402


PY = sys.executable
CLASSIC_CATALOG = (
    ROOT / "tools" / "alas-offline" / "assets"
    / "game_item_catalog_classic.tsv"
)
CLASSIC_REF = (
    ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
    / "externos" / "ref" / "1.24"
)


def force_writable(path: Path) -> None:
    try:
        path.chmod(path.stat().st_mode | stat.S_IWRITE)
    except OSError:
        pass


def prepare_startup(work: Path) -> Path:
    target = work / "_classic_startup"
    target.mkdir(parents=True, exist_ok=True)
    (target / "g.j").write_text("", encoding="utf-8")
    (target / "f.j").write_text(
        "function ALAS_ClassicStartupMessage takes nothing returns nothing\n"
        '    call DisplayTextToPlayer(GetLocalPlayer(), 0.0, 0.0, '
        '"ALAS Classic item browser ready. Type itembrowser.")\n'
        "endfunction\n",
        encoding="utf-8",
    )
    (target / "m.j").write_text(
        "call ALAS_ClassicStartupMessage()\n",
        encoding="utf-8",
    )
    return target


def count_catalog_rows(path: Path) -> tuple[int, int]:
    standard = 0
    custom = 0
    for line in path.read_text(encoding="utf-8").splitlines():
        parts = line.split("\t")
        if len(parts) < 3 or len(parts[1].strip()) != 4:
            continue
        if parts[0].strip() == "C":
            custom += 1
        else:
            standard += 1
    return standard, custom


def extract_installed_script(map_path: Path, output: Path) -> bytes:
    archive = W.MPQArchive(str(map_path))
    try:
        script = archive.read_file("war3map.j") or b""
    finally:
        archive.close()
    if not script:
        raise SystemExit("injected map has no war3map.j")
    output.write_bytes(script)
    return script


def validate_classic_script(
    map_path: Path,
    work: Path,
    browser: Path,
) -> tuple[bytes, int, int]:
    module_bytes = b"".join(
        (browser / name).read_bytes()
        for name in ("f.j", "g.j", "m.j")
    )
    forbidden = sorted(set(re.findall(rb"\bBlz[A-Za-z0-9_]+\b", module_bytes)))
    if forbidden:
        raise SystemExit(
            "classic browser contains Reforged APIs: "
            + ", ".join(item.decode("ascii") for item in forbidden)
        )
    for token in (
        b"function IB_Init takes",
        b"call IB_Init()",
        b"function IB_PageNumber takes",
        b"function IB_RegisterItemChat takes",
        b"ib_searchPageSize",
        b"additem",
        b"search",
    ):
        if token not in module_bytes:
            raise SystemExit(
                "classic browser entry is missing: " + token.decode("ascii")
            )
    if b"call IB_RegisterItemChat()" not in module_bytes:
        raise SystemExit("classic browser does not register item-only chat")
    if b"call IB_RegisterChat()" in module_bytes:
        raise SystemExit("classic browser still registers all chat commands")

    assembled = work / "assembled-war3map.j"
    script = extract_installed_script(map_path, assembled)
    if b"Blz" in script:
        raise SystemExit("classic output script still contains Blz APIs")

    pjass = ROOT / "tools" / "alas-offline" / "assets" / "pjass.exe"
    common = CLASSIC_REF / "common.j"
    blizzard = CLASSIC_REF / "blizzard.j"
    if not pjass.is_file() or not common.is_file() or not blizzard.is_file():
        raise SystemExit("classic pjass reference is incomplete")
    result = subprocess.run(
        [str(pjass), str(common), str(blizzard), str(assembled)],
        capture_output=True,
        text=True,
        errors="replace",
        creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
    )
    diagnostics = (result.stdout or "") + (result.stderr or "")
    if result.returncode != 0:
        tail = "\n".join(diagnostics.splitlines()[-20:])
        raise SystemExit("classic pjass validation failed:\n" + tail)
    print("classic pjass: OK")
    return script, len(script), 0


def build(args: argparse.Namespace) -> int:
    source = args.map.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    if source.suffix.lower() not in (".w3x", ".w3m"):
        raise SystemExit("classic item browser supports one .w3x or .w3m map")
    if output.suffix.lower() != source.suffix.lower():
        raise SystemExit("output extension must match the source map")
    if source == output:
        raise SystemExit("output must not overwrite the source map")
    if not source.is_file():
        raise SystemExit("source map missing: " + str(source))
    if work.exists() and any(work.iterdir()):
        raise SystemExit("work directory must be empty")
    if not CLASSIC_CATALOG.is_file():
        raise SystemExit("classic item catalog missing: " + str(CLASSIC_CATALOG))

    work.mkdir(parents=True, exist_ok=True)
    browser = Path(P.prepare_item_browser(
        str(work),
        None,
        None,
        str(source),
        item_catalog=CLASSIC_CATALOG,
        include_alas_extras=False,
        include_skills=False,
        include_game_units=False,
    ))
    startup = prepare_startup(work)
    standard, custom = count_catalog_rows(work / "_itemids.txt")
    print(
        "classic catalog: %d standard + %d map/custom = %d"
        % (standard, custom, standard + custom)
    )

    output.parent.mkdir(parents=True, exist_ok=True)
    force_writable(output)
    shutil.copy2(source, output)
    force_writable(output)
    env = {
        "ALAS_REPORT_DIR": str(work / "inject-report"),
        "JASS_REF_VERSION": "1.24",
        "PYTHONUTF8": "1",
        "PYTHONIOENCODING": "utf-8",
    }
    P.run([
        PY,
        HERE / "inject_native.py",
        output,
        "--no-backup",
        "--script-internal",
        "war3map.j",
        "--script",
        browser,
        "--script",
        startup,
    ], env=env)

    title = "alas " + (
        output.stem[4:].lstrip()
        if output.stem.lower().startswith("alas")
        else output.stem
    )
    P.run([PY, HERE / "_patch_hm3w_name.py", output, title], env=env)
    _script, script_bytes, _count = validate_classic_script(
        output,
        work,
        browser,
    )
    output_bytes = output.stat().st_size
    print("classic script bytes:", script_bytes)
    print("display title:", title)
    print("output:", output)
    print("bytes:", output_bytes)
    print(
        "sha256:",
        __import__("hashlib").sha256(output.read_bytes()).hexdigest().upper(),
    )
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--map", type=Path, required=True)
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    return build(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
