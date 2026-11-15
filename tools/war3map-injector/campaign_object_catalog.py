"""Scan campaign objects and build a reusable drop-object dependency bundle."""

from __future__ import annotations

import hashlib
import json
import re
import struct
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Mapping

import war3mpq as W
from doctor.data import objects as OBJ


EXTENSIONS = ("w3t", "w3a", "w3h", "w3u")
WITH_LEVELS = frozenset(("w3a",))
NAME_FIELDS = {
    "w3t": "unam",
    "w3a": "anam",
    "w3h": "bnam",
    "w3u": "unam",
}
REFERENCE_FIELDS = {
    "w3t": {
        "iabi": "w3a",
        "icid": "w3a",
    },
    "w3a": {
        "abuf": "w3h",
    },
    "w3u": {
        "uabi": "w3a",
        "uhab": "w3a",
    },
}
ASSET_RE = re.compile(
    rb"(?i)[A-Za-z0-9_.\\/ -]+\.(?:mdx|mdl|blp|tga|dds|"
    rb"wav|mp3|ogg|flac)"
)
TRIGSTR_RE = re.compile(r"^\s*TRIGSTR_0*(\d+)\s*$", re.I)
RAWCODE_RE = re.compile(r"^[0-9A-Za-z]{4}$")


class LootObjectBundleError(ValueError):
    pass


@dataclass(frozen=True)
class ObjectRecord:
    source: str
    source_kind: str
    chapter: str
    extension: str
    skin: bool
    version: int
    table: int
    old: str
    new: str
    mods: tuple
    item_sets: tuple[tuple[int, int], ...]
    name: str
    fingerprint: str

    @property
    def ident(self) -> str:
        return self.new.strip("\0") or self.old.strip("\0")

    def entry(self) -> tuple:
        mods = OBJ.Mods(self.mods)
        if self.version >= 3:
            mods.item_sets = list(self.item_sets)
        return (self.table, self.old, self.new, mods)


@dataclass(frozen=True)
class CampaignObjectCatalog:
    source: Path
    records: tuple[ObjectRecord, ...]
    chapter_names: tuple[str, ...]
    warnings: tuple[str, ...]

    def records_for(self, extension: str, ident: str) -> list[ObjectRecord]:
        return [
            record
            for record in self.records
            if record.extension == extension and record.ident == ident
        ]


@dataclass(frozen=True)
class DropObjectBundle:
    root: Path
    catalog_path: Path
    object_sources: dict[str, Path]
    assets: tuple[tuple[Path, str], ...]
    object_ids: dict[str, tuple[str, ...]]
    fingerprints: dict[str, dict[str, str]]
    warnings: tuple[str, ...]
    chapter_count: int
    definition_count: int
    duplicate_variant_count: int


def _text(value: object) -> str:
    if isinstance(value, bytes):
        return value.decode("utf-8", "replace").replace("\0", "")
    return str(value).replace("\0", "")


def parse_wts(data: bytes | None) -> dict[int, str]:
    if not data:
        return {}
    text = data.decode("utf-8-sig", "replace")
    pattern = re.compile(
        r"STRING\s+(\d+)\s*\r?\n(?:[^\r\n{}]*\r?\n)*"
        r"\{(?:\r?\n)?(.*?)\r?\n\}",
        re.S,
    )
    return {
        int(match.group(1)): match.group(2).strip()
        for match in pattern.finditer(text)
    }


def resolve_string(value: object, strings: Mapping[int, str]) -> str:
    text = _text(value).strip()
    match = TRIGSTR_RE.match(text)
    if match is None:
        return text
    return strings.get(int(match.group(1)), text)


def _display_name(
    extension: str,
    mods: Iterable[tuple],
    strings: Mapping[int, str],
) -> str:
    field = NAME_FIELDS[extension]
    values = [mod for mod in mods if mod[0] == field]
    return resolve_string(values[-1][4], strings) if values else ""


def fingerprint_record(
    table: int,
    old: str,
    new: str,
    mods: Iterable[tuple],
    strings: Mapping[int, str] | None = None,
) -> str:
    strings = strings or {}
    digest = hashlib.sha256()
    digest.update(struct.pack("<i", table))
    digest.update((old + "\0" + new).encode("latin-1", "replace"))
    for mod in mods:
        field_id, kind, level, pointer, value = mod[:5]
        digest.update(field_id.encode("latin-1", "replace"))
        digest.update(struct.pack("<iii", int(kind), int(level), int(pointer)))
        if kind == 0:
            digest.update(struct.pack("<i", int(value)))
        elif kind in (1, 2):
            digest.update(struct.pack("<f", float(value)))
        elif kind == 3:
            digest.update(resolve_string(value, strings).encode("utf-8"))
        else:
            digest.update(repr(value).encode("utf-8"))
        digest.update(b"\0")
    return digest.hexdigest()


def _record_asset_paths(record: ObjectRecord) -> set[str]:
    paths: set[str] = set()
    for mod in record.mods:
        if mod[1] != 3:
            continue
        raw = mod[4] if isinstance(mod[4], bytes) else str(mod[4]).encode()
        for match in ASSET_RE.finditer(raw):
            value = match.group(0).decode("utf-8", "replace").strip()
            value = value.replace("/", "\\").strip("\\ ")
            if value and ":" not in value and ".." not in value.split("\\"):
                paths.add(value)
    return paths


def _reference_ids(record: ObjectRecord) -> list[tuple[str, str]]:
    fields = REFERENCE_FIELDS.get(record.extension, {})
    result: list[tuple[str, str]] = []
    for mod in record.mods:
        target = fields.get(mod[0])
        if target is None or mod[1] != 3:
            continue
        for token in re.split(r"[\s,]+", _text(mod[4])):
            token = token.strip()
            if token and token != "_" and RAWCODE_RE.fullmatch(token):
                result.append((target, token))
    return result


def _parse_source(
    archive: W.MPQArchive,
    *,
    label: str,
    source_kind: str,
    chapter: str,
    prefix: str,
    skin: bool,
    strings: Mapping[int, str],
    warnings: list[str],
) -> list[ObjectRecord]:
    records: list[ObjectRecord] = []
    for extension in EXTENSIONS:
        internal = prefix + extension
        data = archive.read_file(internal) or b""
        if not data:
            continue
        try:
            version, entries, consumed = OBJ.read_objects_bytes(
                data,
                extension in WITH_LEVELS,
                fname=label + ":" + internal,
                with_end=True,
            )
        except Exception as exc:
            warnings.append("%s:%s unreadable: %s" % (label, internal, exc))
            continue
        if consumed != len(data):
            warnings.append(
                "%s:%s has %d trailing bytes"
                % (label, internal, len(data) - consumed)
            )
        for table, old, new, mods in entries:
            old_id = old.replace("\0", "")
            new_id = new.replace("\0", "")
            ident = new_id or old_id
            if not RAWCODE_RE.fullmatch(ident):
                continue
            item_sets = tuple(OBJ.item_sets(mods) or ())
            records.append(
                ObjectRecord(
                    source=label,
                    source_kind=source_kind,
                    chapter=chapter,
                    extension=extension,
                    skin=skin,
                    version=version,
                    table=table,
                    old=old,
                    new=new,
                    mods=tuple(mods),
                    item_sets=item_sets,
                    name=_display_name(extension, mods, strings),
                    fingerprint=fingerprint_record(
                        table, old, new, mods, strings
                    ),
                )
            )
    return records


def scan_campaign_objects(
    campaign: Path,
    chapter_paths: Mapping[str, Path],
) -> CampaignObjectCatalog:
    campaign = Path(campaign).resolve()
    records: list[ObjectRecord] = []
    warnings: list[str] = []
    outer = W.MPQArchive(str(campaign))
    try:
        campaign_strings = parse_wts(
            outer.read_file("war3campaign.wts") or b""
        )
        for skin in (False, True):
            prefix = "war3campaignSkin." if skin else "war3campaign."
            records.extend(
                _parse_source(
                    outer,
                    label="campaign" + ("Skin" if skin else ""),
                    source_kind="campaign",
                    chapter="",
                    prefix=prefix,
                    skin=skin,
                    strings=campaign_strings,
                    warnings=warnings,
                )
            )
    finally:
        outer.close()

    for chapter, path in sorted(chapter_paths.items()):
        archive = W.MPQArchive(str(path))
        try:
            strings = parse_wts(archive.read_file("war3map.wts") or b"")
            for skin in (False, True):
                prefix = "war3mapSkin." if skin else "war3map."
                records.extend(
                    _parse_source(
                        archive,
                        label=chapter + (":skin" if skin else ""),
                        source_kind="chapter",
                        chapter=chapter,
                        prefix=prefix,
                        skin=skin,
                        strings=strings,
                        warnings=warnings,
                    )
                )
        finally:
            archive.close()
    return CampaignObjectCatalog(
        source=campaign,
        records=tuple(records),
        chapter_names=tuple(sorted(chapter_paths)),
        warnings=tuple(warnings),
    )


def archive_object_fingerprints(
    path: Path,
    *,
    campaign_level: bool = False,
) -> dict[tuple[str, str], set[str]]:
    """Return normal/skin object fingerprints for one map or campaign."""
    archive = W.MPQArchive(str(Path(path).resolve()))
    found: dict[tuple[str, str], set[str]] = defaultdict(set)
    warnings: list[str] = []
    try:
        strings = parse_wts(
            archive.read_file(
                "war3campaign.wts" if campaign_level else "war3map.wts"
            )
            or b""
        )
        for skin in (False, True):
            if campaign_level:
                prefix = "war3campaignSkin." if skin else "war3campaign."
            else:
                prefix = "war3mapSkin." if skin else "war3map."
            records = _parse_source(
                archive,
                label=str(path),
                source_kind="campaign" if campaign_level else "chapter",
                chapter="",
                prefix=prefix,
                skin=skin,
                strings=strings,
                warnings=warnings,
            )
            for record in records:
                found[(record.extension, record.ident)].add(
                    record.fingerprint
                )
    finally:
        archive.close()
    return found


def _record_rank(record: ObjectRecord) -> tuple[int, int, str]:
    if record.source_kind == "campaign":
        return (0 if not record.skin else 1, record.table, record.source)
    return (2 if not record.skin else 3, record.table, record.source)


def _format_conflict(
    extension: str,
    ident: str,
    records: Iterable[ObjectRecord],
) -> str:
    details = []
    for record in records:
        details.append(
            "%s(base=%s,table=%d,hash=%s)"
            % (
                record.source,
                record.old.strip("\0") or "-",
                record.table,
                record.fingerprint[:12],
            )
        )
    return (
        "drop object ID %s.%s has conflicting definitions: %s"
        % (extension, ident, "; ".join(details))
    )


def _select_records(
    catalog: CampaignObjectCatalog,
    item_ids: Iterable[str],
) -> tuple[dict[tuple[str, str], ObjectRecord], list[str]]:
    by_key: dict[tuple[str, str], list[ObjectRecord]] = defaultdict(list)
    for record in catalog.records:
        by_key[(record.extension, record.ident)].append(record)

    selected: dict[tuple[str, str], ObjectRecord] = {}
    warnings: list[str] = []
    queue: list[tuple[str, str]] = [
        ("w3t", ident) for ident in sorted(set(item_ids))
    ]
    queued = set(queue)
    while queue:
        extension, ident = queue.pop(0)
        records = by_key.get((extension, ident), [])
        if not records:
            continue
        variants = {record.fingerprint for record in records}
        if len(variants) > 1:
            if any(record.table == 1 for record in records):
                raise LootObjectBundleError(
                    _format_conflict(extension, ident, records)
                )
            warnings.append(
                "base-object override %s.%s differs by chapter; "
                "chapter-local definition or CASC base is retained"
                % (extension, ident)
            )
            continue
        chosen = min(records, key=_record_rank)
        key = (extension, ident)
        if selected.get(key) == chosen:
            continue
        selected[key] = chosen
        for dep_extension, dep_id in _reference_ids(chosen):
            dep_key = (dep_extension, dep_id)
            if dep_key not in queued:
                queued.add(dep_key)
                queue.append(dep_key)
    return selected, warnings


def _chapter_conflicts(
    catalog: CampaignObjectCatalog,
    selected: Mapping[tuple[str, str], ObjectRecord],
) -> list[str]:
    errors: list[str] = []
    by_chapter: dict[tuple[str, str, str], list[ObjectRecord]] = defaultdict(
        list
    )
    for record in catalog.records:
        if record.source_kind == "chapter":
            by_chapter[
                (record.chapter, record.extension, record.ident)
            ].append(record)
    for chapter in catalog.chapter_names:
        for (extension, ident), canonical in sorted(selected.items()):
            records = by_chapter.get((chapter, extension, ident), [])
            mismatches = [
                record
                for record in records
                if record.fingerprint != canonical.fingerprint
            ]
            if mismatches:
                errors.append(
                    "chapter %s conflicts with drop bundle %s.%s: %s"
                    % (
                        chapter,
                        extension,
                        ident,
                        _format_conflict(
                            extension, ident, [canonical] + mismatches
                        ),
                    )
                )
    return errors


def _safe_asset_local(root: Path, internal: str) -> Path:
    parts = [
        part
        for part in internal.replace("/", "\\").split("\\")
        if part not in ("", ".", "..")
    ]
    if not parts:
        raise LootObjectBundleError("invalid empty asset path")
    target = root.joinpath(*parts).resolve()
    root = root.resolve()
    if root not in target.parents:
        raise LootObjectBundleError("unsafe asset path: " + internal)
    return target


def _relative_asset(parent: str, dependency: str) -> str:
    if "\\" in dependency or "/" in dependency:
        return dependency.replace("/", "\\")
    base = parent.replace("/", "\\").rsplit("\\", 1)[0]
    return base + "\\" + dependency if base else dependency


def _extract_assets(
    catalog: CampaignObjectCatalog,
    selected: Iterable[ObjectRecord],
    chapter_paths: Mapping[str, Path],
    root: Path,
) -> tuple[tuple[Path, str], ...]:
    outer = W.MPQArchive(str(catalog.source))
    chapter_archives: dict[str, W.MPQArchive] = {}
    stored: dict[str, tuple[str, Path, str]] = {}
    try:
        for record in selected:
            if record.source_kind == "chapter":
                archive = chapter_archives.get(record.chapter)
                if archive is None:
                    archive = W.MPQArchive(str(chapter_paths[record.chapter]))
                    chapter_archives[record.chapter] = archive
            else:
                archive = outer
            pending = [
                (path, archive) for path in _record_asset_paths(record)
            ]
            visited: set[str] = set()
            while pending:
                internal, asset_archive = pending.pop(0)
                internal = internal.replace("/", "\\")
                if internal in visited:
                    continue
                visited.add(internal)
                data = asset_archive.read_file(internal) or b""
                if not data and asset_archive is not outer:
                    data = outer.read_file(internal) or b""
                    if data:
                        asset_archive = outer
                if not data:
                    if internal.casefold().startswith(
                        "war3mapimported\\"
                    ):
                        raise LootObjectBundleError(
                            "missing imported asset referenced by %s: %s"
                            % (record.source, internal)
                        )
                    continue
                digest = hashlib.sha256(data).hexdigest()
                previous = stored.get(internal.casefold())
                if previous is not None:
                    if previous[0] != digest:
                        raise LootObjectBundleError(
                            "asset path has different bytes in campaign: "
                            + internal
                        )
                    continue
                local = _safe_asset_local(root, internal)
                local.parent.mkdir(parents=True, exist_ok=True)
                local.write_bytes(data)
                stored[internal.casefold()] = (digest, local, internal)
                for match in ASSET_RE.finditer(data):
                    dependency = (
                        match.group(0)
                        .decode("utf-8", "replace")
                        .strip()
                        .replace("/", "\\")
                    )
                    if dependency and ":" not in dependency:
                        candidate = _relative_asset(internal, dependency)
                        if candidate not in visited:
                            pending.append((candidate, asset_archive))
    finally:
        for archive in chapter_archives.values():
            archive.close()
        outer.close()
    return tuple(
        sorted(
            (
                (local, internal)
                for _key, (_digest, local, internal) in stored.items()
            ),
            key=lambda item: item[1].casefold(),
        )
    )


def _asset_variant_warnings(
    assets: Iterable[tuple[Path, str]],
    chapter_paths: Mapping[str, Path],
) -> list[str]:
    warnings: list[str] = []
    for chapter, path in sorted(chapter_paths.items()):
        archive = W.MPQArchive(str(path))
        try:
            for local, internal in assets:
                existing = archive.read_file(internal)
                if existing and existing != local.read_bytes():
                    warnings.append(
                        "%s preserves chapter-local asset variant: %s"
                        % (chapter, internal)
                    )
        finally:
            archive.close()
    return warnings


def _write_object_sources(
    root: Path,
    selected: Mapping[tuple[str, str], ObjectRecord],
) -> tuple[dict[str, Path], dict[str, tuple[str, ...]], dict[str, dict[str, str]]]:
    grouped: dict[str, list[ObjectRecord]] = defaultdict(list)
    for record in selected.values():
        grouped[record.extension].append(record)
    sources: dict[str, Path] = {}
    object_ids: dict[str, tuple[str, ...]] = {}
    fingerprints: dict[str, dict[str, str]] = {}
    for extension, records in sorted(grouped.items()):
        version = 3 if any(record.version >= 3 for record in records) else 2
        entries = [record.entry() for record in records]
        data = OBJ.write_objects_bytes(
            version, entries, extension in WITH_LEVELS
        )
        _read_version, check, consumed = OBJ.read_objects_bytes(
            data,
            extension in WITH_LEVELS,
            fname="drop-bundle." + extension,
            with_end=True,
        )
        if consumed != len(data) or len(check) != len(records):
            raise LootObjectBundleError(
                "drop object bundle round-trip failed for " + extension
            )
        path = root / ("objects." + extension)
        path.write_bytes(data)
        sources[extension] = path
        object_ids[extension] = tuple(
            sorted(record.ident for record in records)
        )
        fingerprints[extension] = {
            record.ident: record.fingerprint for record in records
        }
    return sources, object_ids, fingerprints


def _definition_manifest(
    catalog: CampaignObjectCatalog,
) -> tuple[list[dict[str, object]], list[dict[str, object]]]:
    grouped: dict[tuple[str, str], list[ObjectRecord]] = defaultdict(list)
    for record in catalog.records:
        grouped[(record.extension, record.ident)].append(record)
    definitions: list[dict[str, object]] = []
    duplicates: list[dict[str, object]] = []
    for (extension, ident), records in sorted(grouped.items()):
        fingerprints = sorted({record.fingerprint for record in records})
        item = {
            "extension": extension,
            "id": ident,
            "variants": [
                {
                    "source": record.source,
                    "base": record.old.strip("\0") or None,
                    "table": record.table,
                    "skin": record.skin,
                    "name": record.name,
                    "fingerprint": record.fingerprint,
                }
                for record in sorted(records, key=_record_rank)
            ],
        }
        definitions.append(item)
        if len(fingerprints) > 1:
            duplicates.append(item)
    return definitions, duplicates


def prepare_drop_object_bundle(
    campaign: Path,
    chapter_paths: Mapping[str, Path],
    pools_by_chapter: Mapping[str, Mapping[str, Iterable[str]]],
    output: Path,
) -> DropObjectBundle:
    output = Path(output).resolve()
    output.mkdir(parents=True, exist_ok=True)
    catalog = scan_campaign_objects(campaign, chapter_paths)
    item_ids: set[str] = set()
    for pools in pools_by_chapter.values():
        for pool in pools.values():
            item_ids.update(pool)
    selected, warnings = _select_records(catalog, item_ids)
    warnings.extend(catalog.warnings)
    conflicts = _chapter_conflicts(catalog, selected)
    if conflicts:
        raise LootObjectBundleError("\n".join(conflicts))
    object_sources, object_ids, fingerprints = _write_object_sources(
        output, selected
    )
    assets = _extract_assets(
        catalog,
        selected.values(),
        chapter_paths,
        output / "assets",
    )
    warnings.extend(
        _asset_variant_warnings(assets, chapter_paths)
    )
    definitions, duplicates = _definition_manifest(catalog)
    catalog_path = output / "object-catalog.json"
    manifest = {
        "version": 1,
        "campaign": str(catalog.source),
        "chapters": list(catalog.chapter_names),
        "definition_count": len(catalog.records),
        "object_id_count": len(
            {(record.extension, record.ident) for record in catalog.records}
        ),
        "duplicate_variant_count": len(duplicates),
        "definitions": definitions,
        "duplicate_variants": duplicates,
        "drop_pool_item_ids": sorted(item_ids),
        "object_bundle": {
            "object_ids": {
                extension: list(ids)
                for extension, ids in sorted(object_ids.items())
            },
            "fingerprints": fingerprints,
            "objects": {
                extension: str(path)
                for extension, path in sorted(object_sources.items())
            },
            "assets": [
                {
                    "internal": internal,
                    "local": str(local),
                    "sha256": hashlib.sha256(
                        local.read_bytes()
                    ).hexdigest(),
                }
                for local, internal in assets
            ],
            "warnings": warnings,
        },
    }
    catalog_path.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return DropObjectBundle(
        root=output,
        catalog_path=catalog_path,
        object_sources=object_sources,
        assets=assets,
        object_ids=object_ids,
        fingerprints=fingerprints,
        warnings=tuple(warnings),
        chapter_count=len(catalog.chapter_names),
        definition_count=len(catalog.records),
        duplicate_variant_count=len(duplicates),
    )
