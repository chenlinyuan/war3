#!/usr/bin/env python3
"""Let a map or campaign use the client's SD/HD graphics setting.

For Reforged maps this sets ``SupportedModes`` to SD | HD.  Many older custom
campaigns also lock standard hero IDs to imported classic models in
``war3mapSkin.w3u`` / ``war3campaignSkin.w3u``.  Those model overrides prevent
the client setting from taking effect, so remove only the hero body and portrait
overrides while retaining unit statistics, abilities, icons, custom projectiles,
and every non-hero model.

Legacy map-info formats do not contain ``SupportedModes`` and already follow
the game setting.
"""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
import campaign_paths as CAMP  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402


SD_HD = 0x1 | 0x2
MODEL_FIELDS = frozenset(("umdl", "upor"))


def _chapter_key(value: str | Path) -> str:
    return str(value).replace("\\", "/").strip("/").casefold()


def _chapter_is_skipped(
    chapter: str | Path,
    skipped: set[str],
) -> bool:
    key = _chapter_key(chapter)
    return key in skipped or key.rsplit("/", 1)[-1] in skipped

# Standard hero IDs in Warcraft III 3.0.  Custom heroes can inherit from these
# IDs without repeating Hero Abilities in object data.  Additional custom
# heroes whose old ID is not listed here are detected through their ``uhab``
# modification instead.
BASE_HERO_IDS = frozenset("""
Ecen Edem Edmm Eevi Eevm Efur Eidm Eill Eilm Ekee Ekgg Emfr Emns Emoo Etyr
Ewar Ewrd Haah Hamg Hant Harf Hart Hblm Hct1 Hctl Hctr Hddt Hdgo Hgam Hhkl
Hjai Hjnd Hjsm Hkal Hleo Hlgr Hmbr Hmgd Hmkg Hpal Hpb1 Hpb2 Hssa Huth Hvsh
Hvwd Naka Nal2 Nal3 Nalc Nalm Nbbc Nbrn Nbst Nfir Nmag Nman Nmsr Nngs Npal
Npbm Npld Nplh Nrob Nsjs Nswt Ntin Obla Ocb2 Ocbh Odrt Ofar Ogrh Opgh Orex
Orkn Osam Oshd Otcc Otch Othr Oths Uanb Uany Uarf Ubal Uclc Ucrl Udea Udre
Udth Uear Ugr2 Ugr3 Ugrk Uktl Ulic Umal Usyl Utic Uvar Uvng Uwar
""".split())


def _field_value(mod: tuple) -> object:
    return mod[4]


def _object_key(entry: tuple) -> tuple[int, str, str]:
    table, old, new, _mods = entry
    old = old.replace("\0", "")
    new = new.replace("\0", "") or old
    return table, old, new


def _read_unit_object_data(
    data: bytes | None, label: str
) -> tuple[int, list[tuple]] | None:
    if not data:
        return None
    version, entries, consumed = OBJ.read_objects_bytes(
        data,
        False,
        fname=label,
        with_end=True,
    )
    if consumed != len(data):
        raise RuntimeError(
            "%s: object parser consumed %d of %d bytes"
            % (label, consumed, len(data))
        )
    return version, entries


def _hero_keys(
    normal_data: bytes | None,
    skin_data: bytes | None,
    label: str,
) -> set[tuple[int, str, str]]:
    keys: set[tuple[int, str, str]] = set()
    for suffix, data in (("w3u", normal_data), ("Skin.w3u", skin_data)):
        parsed = _read_unit_object_data(data, label + ":" + suffix)
        if parsed is None:
            continue
        _version, entries = parsed
        for entry in entries:
            key = _object_key(entry)
            if key[1] in BASE_HERO_IDS:
                keys.add(key)
                continue
            for mod in entry[3]:
                if mod[0] == "uhab" and _field_value(mod):
                    keys.add(key)
                    break
    return keys


def _remove_hero_models(mods, hero: bool) -> int:
    if not hero:
        return 0
    item_sets = getattr(mods, "item_sets", None)
    if not item_sets:
        old_size = len(mods)
        mods[:] = [mod for mod in mods if mod[0] not in MODEL_FIELDS]
        return old_size - len(mods)

    original = list(mods)
    kept: list[tuple] = []
    new_sets: list[tuple[int, int]] = []
    offset = 0
    removed = 0
    for flag, count in item_sets:
        group = original[offset:offset + count]
        offset += count
        group = [mod for mod in group if mod[0] not in MODEL_FIELDS]
        removed += count - len(group)
        kept.extend(group)
        new_sets.append((flag, len(group)))
    if offset != len(original):
        raise RuntimeError("object set counts do not match modification list")
    mods[:] = kept
    mods.item_sets = new_sets
    return removed


def patch_hero_models(
    normal_data: bytes | None,
    skin_data: bytes | None,
    label: str,
) -> tuple[bytes | None, bytes | None, list[tuple[str, int, str, str]]]:
    heroes = _hero_keys(normal_data, skin_data, label)
    outputs: list[bytes | None] = []
    removed: list[tuple[str, int, str, str]] = []
    for suffix, data in (("w3u", normal_data), ("Skin.w3u", skin_data)):
        if not data:
            outputs.append(None)
            continue
        parsed = _read_unit_object_data(data, label + ":" + suffix)
        assert parsed is not None
        version, entries = parsed
        changed = 0
        for entry in entries:
            key = _object_key(entry)
            count = _remove_hero_models(entry[3], key in heroes)
            if count:
                changed += count
                removed.append(
                    (suffix, key[0], key[1], key[2])
                )
        if not changed:
            outputs.append(data)
            continue
        updated = OBJ.write_objects_bytes(version, entries, False)
        check_version, check_entries, consumed = (
            OBJ.read_objects_bytes(
                updated,
                False,
                fname=label + ":" + suffix + ":verify",
                with_end=True,
            )
        )
        if (
            check_version != version
            or len(check_entries) != len(entries)
            or consumed != len(updated)
        ):
            raise RuntimeError(
                "%s hero-model write-back failed" % (label + ":" + suffix)
            )
        remaining = [
            mod[0]
            for entry in check_entries
            if _object_key(entry) in heroes
            for mod in entry[3]
            if mod[0] in MODEL_FIELDS
        ]
        if remaining:
            raise RuntimeError(
                "%s still has hero model overrides: %s"
                % (label, ", ".join(sorted(set(remaining))))
            )
        outputs.append(updated)
    return outputs[0], outputs[1], removed


def patch_w3i(data: bytes, label: str) -> tuple[bytes | None, int, str]:
    model = W3I.parse(data)
    version = int(model["version"])
    if version < 31:
        return None, version, "legacy map-info already follows the game"
    modes = int(model.get("supported_modes", -1))
    if modes == SD_HD:
        return None, version, "already follows the game"
    if W3I.write(model) != data:
        raise RuntimeError(
            "%s war3map.w3i does not round-trip byte-for-byte" % label
        )
    model["supported_modes"] = SD_HD
    updated = W3I.write(model)
    if int(W3I.parse(updated).get("supported_modes", -1)) != SD_HD:
        raise RuntimeError("%s SupportedModes read-back failed" % label)
    return updated, version, "patched"


def patch_map(source: Path, output: Path) -> str:
    archive = W.MPQArchive(str(source))
    try:
        w3i_data = archive.read_file("war3map.w3i")
        units_data = archive.read_file("war3map.w3u")
        skin_data = archive.read_file("war3mapSkin.w3u")
    finally:
        archive.close()
    if not w3i_data:
        raise RuntimeError("%s has no war3map.w3i" % source.name)
    updated_w3i, version, reason = patch_w3i(w3i_data, source.name)
    updated_units, updated_skin, removed = patch_hero_models(
        units_data,
        skin_data,
        source.name,
    )
    patches = []
    if updated_w3i is not None:
        patches.append(("war3map.w3i", updated_w3i))
    if updated_units is not None and updated_units != units_data:
        patches.append(("war3map.w3u", updated_units))
    if updated_skin is not None and updated_skin != skin_data:
        patches.append(("war3mapSkin.w3u", updated_skin))
    if updated_w3i is None:
        print(
            "graphics modes skipped (%s, map-info v%d): %s"
            % (reason, version, source.name)
        )
    if not patches:
        if source != output:
            shutil.copy2(source, output)
        return "skipped"
    mpq_patch.patch(
        str(source),
        patches,
        out_path=str(output),
        backup=False,
    )
    check = W.MPQArchive(str(output))
    try:
        for internal, expected in patches:
            if check.read_file(internal) != expected:
                raise RuntimeError(
                    "%s write-back failed: %s" % (output.name, internal)
                )
    finally:
        check.close()
    if updated_w3i is not None:
        print("graphics modes follow game setting: %s" % output)
    if removed:
        print(
            "hero graphics overrides removed: %d records from %s"
            % (len(removed), output.name)
        )
    return "patched"


def patch_campaign_directory(directory: Path) -> tuple[int, int]:
    normal_path = directory / "war3campaign.w3u"
    skin_path = directory / "war3campaignSkin.w3u"
    normal_data = normal_path.read_bytes() if normal_path.is_file() else None
    skin_data = skin_path.read_bytes() if skin_path.is_file() else None
    updated_units, updated_skin, removed = patch_hero_models(
        normal_data,
        skin_data,
        "war3campaign",
    )
    if updated_units is not None and updated_units != normal_data:
        normal_path.write_bytes(updated_units)
    if updated_skin is not None and updated_skin != skin_data:
        skin_path.write_bytes(updated_skin)
    if removed:
        print(
            "campaign hero graphics overrides removed: %d fields"
            % len(removed)
        )
    return len(removed), len(removed)


def patch_campaign_archive(source: Path, output: Path) -> str:
    archive = W.MPQArchive(str(source))
    try:
        units_data = archive.read_file("war3campaign.w3u")
        skin_data = archive.read_file("war3campaignSkin.w3u")
        chapters = sorted(
            name for name in archive.files()
            if name.lower().endswith((".w3m", ".w3x"))
        )
        chapter_payloads = [
            (name, archive.read_file(name)) for name in chapters
        ]
        original_flags = {
            name: archive._find_file(name)
            for name in (
                "war3campaign.w3u",
                "war3campaignSkin.w3u",
                *chapters,
            )
        }
    finally:
        archive.close()

    updated_units, updated_skin, campaign_removed = patch_hero_models(
        units_data,
        skin_data,
        "war3campaign",
    )
    patches: list[tuple[str, bytes]] = []
    if updated_units is not None and updated_units != units_data:
        patches.append(("war3campaign.w3u", updated_units))
    if updated_skin is not None and updated_skin != skin_data:
        patches.append(("war3campaignSkin.w3u", updated_skin))

    chapter_removed = 0
    campaign_dir = output.parent
    campaign_dir.mkdir(parents=True, exist_ok=True)
    for index, (name, data) in enumerate(chapter_payloads, 1):
        if not data:
            raise RuntimeError("cannot read chapter: " + name)
        suffix = Path(name).suffix
        temp_source = campaign_dir / (
            ".hero-graphics-source-%d%s" % (index, suffix)
        )
        temp_output = campaign_dir / (
            ".hero-graphics-output-%d%s" % (index, suffix)
        )
        try:
            temp_source.write_bytes(data)
            patch_map(temp_source, temp_output)
            chapter_data = temp_output.read_bytes()
            if chapter_data != data:
                patches.append((name, chapter_data))
                chapter_removed += 1
        finally:
            temp_source.unlink(missing_ok=True)
            temp_output.unlink(missing_ok=True)

    if not patches:
        if source != output:
            shutil.copy2(source, output)
        print("campaign already follows the game graphics setting: " + source.name)
        return "skipped"

    store = []
    for internal, _data in patches:
        info = original_flags.get(internal)
        if (
            internal.lower().endswith((".w3m", ".w3x"))
            or (
                info is not None
                and not (info.flags & W.COMPRESSION_MASK)
            )
        ):
            store.append(internal)
    mpq_patch.patch(
        str(source),
        patches,
        out_path=str(output),
        backup=False,
        store=store,
    )
    check = W.MPQArchive(str(output))
    try:
        for internal, expected in patches:
            if check.read_file(internal) != expected:
                raise RuntimeError(
                    "%s write-back failed: %s" % (output.name, internal)
                )
    finally:
        check.close()
    print(
        "campaign graphics patched: %d hero fields, %d changed chapters: %s"
        % (len(campaign_removed), chapter_removed, output)
    )
    return "patched"


def _audit_map_bytes(
    units_data: bytes | None,
    skin_data: bytes | None,
    label: str,
) -> list[str]:
    heroes = _hero_keys(units_data, skin_data, label)
    failures = []
    for suffix, data in (("w3u", units_data), ("Skin.w3u", skin_data)):
        parsed = _read_unit_object_data(data, label + ":" + suffix)
        if parsed is None:
            continue
        _version, entries = parsed
        for entry in entries:
            key = _object_key(entry)
            if key not in heroes:
                continue
            fields = sorted(
                mod[0] for mod in entry[3] if mod[0] in MODEL_FIELDS
            )
            if fields:
                failures.append(
                    "%s:%s %s -> %s has %s"
                    % (
                        label,
                        suffix,
                        key[1],
                        key[2],
                        ", ".join(fields),
                    )
                )
    return failures


def audit_path(
    path: Path,
    skipped_chapters: set[str] | None = None,
) -> list[str]:
    skipped = {
        _chapter_key(item) for item in (skipped_chapters or set())
    }
    failures: list[str] = []
    if path.is_dir():
        failures.extend(
            _audit_map_bytes(
                (path / "war3campaign.w3u").read_bytes()
                if (path / "war3campaign.w3u").is_file()
                else None,
                (path / "war3campaignSkin.w3u").read_bytes()
                if (path / "war3campaignSkin.w3u").is_file()
                else None,
                "war3campaign",
            )
        )
        chapters = CAMP.chapter_paths(path)
        for chapter in chapters:
            if _chapter_is_skipped(
                CAMP.chapter_key(path, chapter),
                skipped,
            ):
                continue
            archive = W.MPQArchive(str(chapter))
            try:
                failures.extend(
                    _audit_map_bytes(
                        archive.read_file("war3map.w3u"),
                        archive.read_file("war3mapSkin.w3u"),
                        chapter.name,
                    )
                )
            finally:
                archive.close()
        return failures

    if not path.is_file():
        return ["audit input not found: " + str(path)]
    archive = W.MPQArchive(str(path))
    try:
        failures.extend(
            _audit_map_bytes(
                archive.read_file("war3campaign.w3u"),
                archive.read_file("war3campaignSkin.w3u"),
                "war3campaign",
            )
        )
        chapters = sorted(
            name for name in archive.files()
            if name.lower().endswith((".w3m", ".w3x"))
        )
        chapter_payloads = [
            (name, archive.read_file(name)) for name in chapters
        ]
    finally:
        archive.close()
    for name, data in chapter_payloads:
        if _chapter_is_skipped(name, skipped):
            continue
        if not data:
            failures.append("cannot read chapter: " + name)
            continue
        suffix = Path(name).suffix
        temp = path.parent / (".hero-graphics-audit" + suffix)
        try:
            temp.write_bytes(data)
            chapter = W.MPQArchive(str(temp))
            try:
                failures.extend(
                    _audit_map_bytes(
                        chapter.read_file("war3map.w3u"),
                        chapter.read_file("war3mapSkin.w3u"),
                        name,
                    )
                )
            finally:
                chapter.close()
        finally:
            temp.unlink(missing_ok=True)
    return failures


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    parser.add_argument(
        "--audit",
        action="store_true",
        help="verify that no standard hero model locks remain",
    )
    parser.add_argument(
        "--skip-chapter",
        action="append",
        default=[],
        help="chapter intentionally preserved outside the graphics patch",
    )
    args = parser.parse_args()
    source = args.input.resolve()
    if args.audit:
        failures = audit_path(source, set(args.skip_chapter))
        if failures:
            raise SystemExit(
                "hero graphics audit failed:\n  " + "\n  ".join(failures)
            )
        print("hero graphics audit passed: " + str(source))
        return 0
    if source.is_dir():
        patch_campaign_directory(source)
        chapters = CAMP.chapter_paths(source)
        if not chapters:
            raise SystemExit("no chapter maps found in " + str(source))
        results = []
        for chapter in chapters:
            results.append(patch_map(chapter, chapter))
        print(
            "graphics modes summary: %d patched, %d already follow the game"
            % (results.count("patched"), results.count("skipped"))
        )
        return 0
    if not source.is_file():
        raise SystemExit("input not found: " + str(source))
    output = (args.output or source).resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    if source.suffix.lower() == ".w3n":
        patch_campaign_archive(source, output)
    else:
        patch_map(source, output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
