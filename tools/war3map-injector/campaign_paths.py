"""Discover campaign chapters while preserving nested archive paths."""

from __future__ import annotations

from pathlib import Path


CHAPTER_SUFFIXES = frozenset((".w3x", ".w3m"))
PLAYABLE_EPILOGUE_MARKERS = (
    b"RestoreUnitLocFacingAngleBJ",
    b"RestoreUnitLocFacingPointBJ",
    b"RestoreUnitLocFacingBJ",
    b"RestoreUnitBJ",
)
CINEMATIC_NAME_MARKERS = (
    "interlude",
    "cinematic",
    "epilogue",
    "outro",
    "过场",
    "過場",
    "幕间",
    "幕間",
    "尾声",
    "尾聲",
)


def normalize_chapter_name(name: str) -> str:
    """Return a stable MPQ-style chapter key."""
    return name.replace("\\", "/").strip("/")


def chapter_key(base: Path | str, path: Path | str) -> str:
    """Return a chapter's path relative to the extracted campaign root."""
    base = Path(base)
    path = Path(path)
    return normalize_chapter_name(
        str(path.resolve().relative_to(base.resolve()))
    )


def chapter_paths(base: Path | str) -> list[Path]:
    """Return every chapter recursively, including nested official paths."""
    root = Path(base).resolve()
    return sorted(
        (
            path
            for path in root.rglob("*")
            if path.is_file() and path.suffix.lower() in CHAPTER_SUFFIXES
        ),
        key=lambda path: chapter_key(root, path).casefold(),
    )


def cinematic_chapter_reason(
    chapter: str | Path,
    title: str = "",
    *,
    playable_epilogue: bool = False,
) -> str | None:
    """Return why a chapter is explicitly cinematic, or ``None``."""
    name = Path(normalize_chapter_name(str(chapter))).name.casefold()
    for marker in CINEMATIC_NAME_MARKERS:
        if marker == "epilogue" and playable_epilogue:
            continue
        if marker.casefold() in name:
            return "chapter filename contains %r" % marker
    folded_title = title.casefold()
    for marker in CINEMATIC_NAME_MARKERS:
        if marker == "epilogue" and playable_epilogue:
            continue
        if marker.casefold() in folded_title:
            return "campaign title contains %r" % marker
    return None


def has_playable_hero_restore(path: Path | str) -> bool:
    """Return whether a chapter restores a campaign hero from saved state.

    Some campaigns name their final playable mission ``Epilogue``. Treating
    every such filename as a non-playable cinematic skips the chapter's object
    data and scripts, which can lose the restored hero's extended inventory.
    """
    path = Path(path)
    if path.suffix.lower() not in CHAPTER_SUFFIXES:
        return False
    try:
        import war3mpq as W

        archive = W.MPQArchive(str(path))
        try:
            script = (
                archive.read_file("war3map.j")
                or archive.read_file(r"scripts\war3map.j")
                or archive.read_file(r"Scripts\war3map.j")
                or archive.read_file("war3map.lua")
                or archive.read_file(r"scripts\war3map.lua")
                or archive.read_file(r"Scripts\war3map.lua")
                or b""
            )
        finally:
            archive.close()
    except Exception:
        return False
    return any(marker in script for marker in PLAYABLE_EPILOGUE_MARKERS)


def campaign_chapter_titles(campaign: Path | str) -> dict[str, str]:
    """Read chapter button titles from a campaign archive.

    Malformed or protected campaign metadata is ignored; filename markers
    remain available as the conservative fallback.
    """
    campaign = Path(campaign)
    if campaign.suffix.lower() != ".w3n" or not campaign.is_file():
        return {}
    try:
        from doctor.data import campaign_info

        import war3mpq as W

        archive = W.MPQArchive(str(campaign))
        try:
            data = archive.read_file("war3campaign.w3f") or b""
        finally:
            archive.close()
        if not data:
            return {}
        model = campaign_info.parse(data)
    except Exception:
        return {}

    titles: dict[str, str] = {}
    for button in model.get("buttons", ()):
        raw_map = button.get("map", b"")
        raw_title = button.get("title", b"")
        if isinstance(raw_map, bytes):
            chapter = raw_map.decode("utf-8", "replace")
        else:
            chapter = str(raw_map)
        if isinstance(raw_title, bytes):
            title = raw_title.decode("utf-8", "replace")
        else:
            title = str(raw_title)
        key = normalize_chapter_name(chapter).casefold()
        if key:
            titles[key] = title
            titles.setdefault(key.rsplit("/", 1)[-1], title)
    return titles


def select_campaign_chapters(
    base: Path | str,
    campaign: Path | str | None = None,
    *,
    include_cinematic: bool = False,
) -> tuple[list[Path], dict[str, str]]:
    """Split chapters into ALAS targets and explicitly skipped cinematics."""
    root = Path(base).resolve()
    titles = campaign_chapter_titles(campaign) if campaign else {}
    selected: list[Path] = []
    skipped: dict[str, str] = {}
    for path in chapter_paths(root):
        key = chapter_key(root, path)
        folded = key.casefold()
        title = titles.get(folded) or titles.get(
            folded.rsplit("/", 1)[-1], ""
        )
        reason = cinematic_chapter_reason(
            key,
            title,
            playable_epilogue=has_playable_hero_restore(path),
        )
        if reason and not include_cinematic:
            skipped[key] = reason
        else:
            selected.append(path)
    return selected, skipped


def _safe_target(base: Path, key: str) -> Path:
    parts = [
        part for part in normalize_chapter_name(key).split("/") if part
    ]
    if not parts or any(part in (".", "..") for part in parts):
        raise ValueError("unsafe campaign chapter name: " + key)
    target = base.joinpath(*parts).resolve()
    root = base.resolve()
    if target != root and root not in target.parents:
        raise ValueError("campaign chapter escapes extraction root: " + key)
    return target


def restore_campaign_chapters(
    campaign: Path | str,
    base: Path | str,
    chapter_keys: set[str] | list[str] | tuple[str, ...],
) -> None:
    """Restore selected nested chapters byte-for-byte from a campaign."""
    if not chapter_keys:
        return
    import war3mpq as W

    archive = W.MPQArchive(str(campaign))
    try:
        for key in sorted(chapter_keys):
            data = archive.read_file(key)
            if not data:
                raise ValueError("campaign chapter cannot be read: " + key)
            target = _safe_target(Path(base), key)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
    finally:
        archive.close()


def verify_campaign_chapters(
    source: Path | str,
    output: Path | str,
    chapter_keys: set[str] | list[str] | tuple[str, ...],
) -> None:
    """Require selected nested chapters to remain byte-identical."""
    if not chapter_keys:
        return
    import war3mpq as W

    original = W.MPQArchive(str(source))
    deployed = W.MPQArchive(str(output))
    try:
        for key in sorted(chapter_keys):
            expected = original.read_file(key)
            actual = deployed.read_file(key)
            if not expected:
                raise ValueError("source chapter cannot be read: " + key)
            if actual != expected:
                raise ValueError(
                    "skipped cinematic chapter changed: " + key
                )
    finally:
        original.close()
        deployed.close()


def chapter_map(base: Path | str) -> dict[str, Path]:
    """Map normalized relative chapter names to extracted files."""
    root = Path(base).resolve()
    return {
        chapter_key(root, path): path
        for path in chapter_paths(root)
    }
