from __future__ import annotations

import hashlib
import importlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Callable

from version import APP_VERSION


APP_DIR = Path(__file__).resolve().parent
ROOT = APP_DIR.parents[1]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
RECOVER = ROOT / "tools" / "recover"
SAVE_REPAIR = RECOVER / "offline_save_repair.py"
TEMPLATE_CONFIG = INJECTOR / "wings_config_offline_template.py"
LOCAL_AUDIT = APP_DIR / "assets" / "audit_alas_campaign.py"
FORSAKEN_CHAPTERS = {
    "UndeadRE01.w3x",
    "UndeadRE01_02.w3x",
    "UndeadRE01_03.w3x",
    "UndeadRE01_04.w3x",
    "UndeadRE01_05.w3x",
    "UndeadRE01_06.w3x",
    "UndeadRE02.w3x",
    "UndeadRE02_01.w3x",
    "UndeadRE02_02.w3x",
    "UndeadRE02_03.w3x",
    "UndeadRE02_04.w3x",
    "UndeadRE02_06.w3x",
    "UndeadRE03Interlude.w3x",
    "UndeadRE03a.w3x",
    "UndeadRE03b.w3x",
}

sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import fix_alas_campaign_names as NAMES  # noqa: E402
import alas_item_rules as ITEM_RULES  # noqa: E402
import campaign_paths as CAMP  # noqa: E402
import port_alas_jass_campaign as JASS_CAMPAIGN  # noqa: E402
import universal_talents as TALENT_BUNDLE  # noqa: E402
import wild_equipment_drops as WILD_DROPS  # noqa: E402
import war3mpq as W  # noqa: E402
from wing_copy_contract import wing_copy_failures  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.triggers import wtg  # noqa: E402


Log = Callable[[str], None]


class OfflineToolError(RuntimeError):
    pass


def runtime_compact(script: bytes) -> str:
    return re.sub(
        r"[^A-Za-z0-9_]+",
        "",
        script.decode("latin-1", "replace"),
    )


def runtime_marker_matches(
    script: bytes,
    compact_script: str,
    marker: bytes,
) -> bool:
    if marker in script:
        return True
    text = marker.decode("ascii", "replace")
    function = re.fullmatch(r"function (\w+) takes", text)
    if function:
        text = "function " + function.group(1) + "("
    elif "function " in text:
        text = text.replace("function ", "")
    text = re.sub(
        r"^(?:call|real|integer|boolean|string) ",
        "",
        text,
    )
    compact_marker = re.sub(r"[^A-Za-z0-9_]+", "", text)
    return compact_marker in compact_script


def require_wing_copy(
    item_fields: dict[str, dict[str, object]],
    config: object,
    label: str,
) -> None:
    wing_ids = {
        wing["key"]: wing["item"]
        for wing in config.WINGS
    }
    issues = wing_copy_failures(item_fields, wing_ids)
    if issues:
        raise OfflineToolError(
            "%s: 翅膀神器文案审计失败：%s" % (label, "; ".join(issues))
        )


def require_frost_control(
    ability_fields: dict[str, dict[str, object]],
    ability_origins: dict[str, str],
    script: bytes,
    label: str,
) -> None:
    tooltip = ability_fields.get("A105", {}).get("aub1", "")
    if isinstance(tooltip, bytes):
        tooltip = tooltip.decode("utf-8", "replace")
    tooltip = str(tooltip)
    required = (
        "核心 0～300",
        "中环 300～550",
        "外环 550～750",
        "同时附加冰缓 60%，共持续 9 秒",
        "空中单位不冰冻，但仍受伤害和减速",
    )
    missing = [token for token in required if token not in tooltip]
    if missing:
        raise OfflineToolError(
            "%s: 冰封践踏说明缺少：%s" % (label, ", ".join(missing))
        )
    if ability_origins.get("A171") != "Aslo":
        raise OfflineToolError("%s: A171 不是原生 Slow 基底" % label)
    slow = ability_fields.get("A171", {})
    slow_buff = slow.get("abuf", "")
    if isinstance(slow_buff, bytes):
        slow_buff = slow_buff.decode("utf-8", "replace")
    if str(slow_buff) != "Bfro":
        raise OfflineToolError("%s: A171 没有使用霜冻新星 Buff" % label)
    try:
        slow_factor = float(slow.get("Slo1", "nan"))
        slow_duration = float(slow.get("adur", "nan"))
    except (TypeError, ValueError):
        raise OfflineToolError("%s: A171 减速字段无效" % label)
    if abs(slow_factor - 0.4) > 0.0001:
        raise OfflineToolError("%s: A171 核心减速不是 60%%" % label)
    if abs(slow_duration - 9.0) > 0.0001:
        raise OfflineToolError("%s: A171 核心减速不是 9 秒" % label)
    compact_script = runtime_compact(script)
    for marker in (
        b"function FR_IsAliveTarget takes",
        b"GetWidgetLife(u) <= 0.405",
        b"not IsUnitType(u, UNIT_TYPE_DEAD)",
        b"function FR_ApplySlow takes",
        b"call FR_ApplySlow(GetOwningPlayer(caster), target, slowLevel)",
        b"call FR_FreezeUnit(target, freeze_duration)",
        b"function FR_OnFrozenDeath takes",
        b"call PauseUnit(u, false)",
        b"call SetUnitTimeScale(u, 1.0)",
        b"IssueTargetOrder(dummy, \"slow\", target)",
        b"real FR_RING_CORE_RADIUS = 300.0",
        b"real FR_RING_MID_RADIUS = 550.0",
        b"real FR_FREEZE_CORE = 6.0",
        b"real FR_FREEZE_MID = 4.0",
        b"real FR_FREEZE_OUTER = 2.0",
    ):
        if not runtime_marker_matches(
            script,
            compact_script,
            marker,
        ):
            raise OfflineToolError(
                "%s: 冰封践踏缺少运行时标记 %s"
                % (label, marker.decode("ascii"))
            )
    if runtime_marker_matches(
        script,
        compact_script,
        b"call FR_FreezeUnit(caster, target, freeze_duration, slowLevel)",
    ):
        raise OfflineToolError("%s: 冰封践踏仍使用旧的延迟减速调用" % label)


@dataclass
class CampaignInfo:
    source: str
    source_kind: str
    title: str
    script_type: str
    map_info_versions: dict[str, int | None]
    new_backpack_supported: bool
    new_backpack_reason: str
    universal_talents_supported: bool
    universal_talents_reason: str
    reforged_migration_required: bool
    reforged_migration_supported: bool
    reforged_migration_reason: str
    chapters: list[str]
    injectable_chapters: list[str]
    cinematic_chapters: dict[str, str]
    source_sha256: str
    source_bytes: int
    already_injected: bool


@dataclass
class BuildResult:
    app_version: str
    source: str
    source_kind: str
    output: str
    compact_archive: bool
    ft_data: bool
    reforged_migrate: bool
    equipment_mode: str
    new_backpack: bool
    new_backpack_panels: tuple[str, ...]
    universal_talents: bool
    wild_equipment_drops: bool
    campaign_equipment_drops: bool
    follow_game_graphics: bool
    include_cinematic_chapters: bool
    script_type: str
    chapters: int
    injected_chapters: int
    skipped_cinematic_chapters: int
    output_bytes: int
    output_sha256: str
    doctor_blockers: int
    save_repair_enabled: bool
    save_repair: SaveRepairResult
    work_dir: str
    report: str
    started_at: str
    finished_at: str


@dataclass
class SaveRepairResult:
    enabled: bool
    attempted: bool
    directories: list[str]
    reports: list[dict[str, object]]
    errors: list[str]
    changed: int
    already_current: int
    skipped: int
    backups: list[str]
    message: str


@dataclass
class CacheClearResult:
    targets: int
    files: int
    bytes_removed: int
    errors: list[str]
    message: str


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def running_war3_processes() -> list[str]:
    """Return running War3 editor/game executables without touching the GUI."""
    try:
        result = subprocess.run(
            ["tasklist", "/FO", "CSV", "/NH"],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=5,
        )
    except (OSError, subprocess.SubprocessError):
        return []
    wanted = {
        "warcraft iii.exe",
        "warcraft iii launcher.exe",
        "war3.exe",
        "worldedit.exe",
        "world editor.exe",
    }
    found = []
    for line in result.stdout.splitlines():
        if not line.startswith('"'):
            continue
        end = line.find('"', 1)
        name = line[1:end] if end > 1 else ""
        if name.casefold() in wanted:
            found.append(name)
    return sorted(set(found))


def default_campaign_dir() -> Path:
    profile = Path(os.environ.get("USERPROFILE", str(Path.home())))
    return profile / "Documents" / "Warcraft III" / "Campaigns"


def default_map_dir() -> Path:
    profile = Path(os.environ.get("USERPROFILE", str(Path.home())))
    return profile / "Documents" / "Warcraft III" / "Maps" / "Mod"


def default_output_dir(source: Path) -> Path:
    return (
        default_map_dir()
        if source.suffix.lower() in (".w3x", ".w3m")
        else default_campaign_dir()
    )


def default_cache_dir() -> Path:
    local = Path(os.environ.get("LOCALAPPDATA", profile_cache_fallback()))
    return local / "ALASOffline"


def _path_size(path: Path) -> tuple[int, int]:
    if not path.exists() and not path.is_symlink():
        return 0, 0
    if path.is_file() or path.is_symlink():
        try:
            return 1, path.stat().st_size
        except OSError:
            return 0, 0
    files = 0
    size = 0
    for item in path.rglob("*"):
        if not item.is_file():
            continue
        files += 1
        try:
            size += item.stat().st_size
        except OSError:
            pass
    return files, size


def _deduplicate_paths(paths: list[Path]) -> list[Path]:
    found: dict[str, Path] = {}
    for path in paths:
        resolved = path.resolve()
        found[os.path.normcase(str(resolved))] = resolved
    return sorted(
        found.values(),
        key=lambda path: (len(path.parts), str(path).casefold()),
        reverse=True,
    )


def clear_tool_cache(
    *,
    cache_root: Path | None = None,
    injector: Path | None = None,
    doctor: Path | None = None,
    workspace_root: Path | None = None,
) -> CacheClearResult:
    """Remove tool-generated cache and backup data, never source/archive files."""
    cache_root = (cache_root or default_cache_dir()).resolve()
    injector = (injector or INJECTOR).resolve()
    doctor = (doctor or DOCTOR).resolve()
    workspace_root = (workspace_root or ROOT).resolve()

    targets: list[Path] = []
    if cache_root.is_dir():
        targets.extend(cache_root.iterdir())

    for exact in (
        injector / "_rep",
        injector / "__pycache__",
        doctor / "doctor" / "cache",
    ):
        if exact.exists() or exact.is_symlink():
            targets.append(exact)

    if injector.is_dir():
        for pattern in (
            "wings_config_offline_*",
            "_tmp*",
            "_verify*",
            "_diag*",
        ):
            for target in injector.glob(pattern):
                if target.name == "wings_config_offline_template.py":
                    continue
                targets.append(target)

    recover = workspace_root / "maps" / "recover"
    if recover.is_dir():
        targets.extend(recover.glob("alas_campaign_names_*"))

    allowed_roots = (
        cache_root,
        injector,
        doctor,
        workspace_root / "maps" / "recover",
    )
    safe_targets = []
    for target in _deduplicate_paths(targets):
        try:
            if target == Path(target.anchor):
                continue
            if not any(
                target == root
                or root in target.parents
                for root in allowed_roots
            ):
                continue
        except (OSError, ValueError):
            continue
        safe_targets.append(target)

    files = 0
    bytes_removed = 0
    errors: list[str] = []
    for target in safe_targets:
        count, size = _path_size(target)
        try:
            if target.is_dir() and not target.is_symlink():
                shutil.rmtree(target)
            else:
                target.unlink(missing_ok=True)
        except OSError as exc:
            errors.append("%s：%s" % (target, exc))
            continue
        files += count
        bytes_removed += size

    message = (
        "已清理 %d 项缓存，共 %d 个文件，释放 %.1f MB。"
        % (len(safe_targets) - len(errors), files, bytes_removed / 1048576)
    )
    if errors:
        message += "\n%d 项未能删除。" % len(errors)
    return CacheClearResult(
        targets=len(safe_targets),
        files=files,
        bytes_removed=bytes_removed,
        errors=errors,
        message=message,
    )


def profile_cache_fallback() -> Path:
    return Path(os.environ.get("USERPROFILE", str(Path.home()))) / "AppData" / "Local"


def suggested_output_name(source: Path) -> str:
    if source.suffix.lower() == ".w3n":
        title = NAMES.desired_title(source)
        title = re.sub(r'[<>:"/\\|?*\x00-\x1f]', "_", title).strip(" .")
        if title:
            return title + ".w3n"
    stem = source.stem
    if stem.lower().startswith("alas"):
        stem = stem[4:].lstrip()
    return "alas" + stem + source.suffix.lower()


def _normalized_campaign_name(name: str) -> str:
    return re.sub(r"\s+", "", name.casefold())


def discover_save_directories(
    campaign: Path,
    *,
    extra_names: tuple[str, ...] = (),
    explicit_dir: Path | None = None,
    battle_root: Path | None = None,
) -> list[Path]:
    """Find save folders belonging to the campaign being deployed."""
    if explicit_dir is not None:
        path = explicit_dir.expanduser().resolve()
        return [path] if path.is_dir() else []

    profile = Path(os.environ.get("USERPROFILE", str(Path.home())))
    documents = profile / "Documents" / "Warcraft III"
    bnet_root = battle_root or documents / "BattleNet"
    names = {
        _normalized_campaign_name(name)
        for name in (campaign.stem, *extra_names)
        if name
    }

    custom_roots: list[Path] = []
    if bnet_root.is_dir():
        custom_roots.extend(
            profile_dir / "Campaigns" / "Custom"
            for profile_dir in bnet_root.iterdir()
            if profile_dir.is_dir()
        )
    custom_roots.append(documents / "Campaigns" / "Custom")

    found: list[Path] = []
    seen: set[str] = set()
    for custom_root in custom_roots:
        if not custom_root.is_dir():
            continue
        for directory in custom_root.iterdir():
            if not directory.is_dir():
                continue
            if _normalized_campaign_name(directory.name) not in names:
                continue
            if not any(directory.glob("*.w3z")):
                continue
            key = str(directory.resolve()).casefold()
            if key in seen:
                continue
            seen.add(key)
            found.append(directory.resolve())
    found.sort(
        key=lambda path: max(
            item.stat().st_mtime for item in path.glob("*.w3z")
        ),
        reverse=True,
    )
    return found


def _read_map_info_version(data: bytes) -> int | None:
    if not data:
        return None
    try:
        return int(W3I.parse_or_tolerant(data).get("version", 0))
    except Exception:
        return None


def _format_map_info_versions(
    versions: dict[str, int | None],
) -> str:
    values = sorted(
        {
            int(version)
            for version in versions.values()
            if version is not None
        }
    )
    if not values:
        return "未知"
    if len(values) == 1:
        return "v%d" % values[0]
    return "v%d-v%d" % (values[0], values[-1])


def _new_backpack_compatibility(
    versions: dict[str, int | None],
) -> tuple[bool, str]:
    missing = sum(version is None for version in versions.values())
    if missing:
        return (
            False,
            "有 %d 个地图无法读取 war3map.w3i" % missing,
        )
    if versions and all(
        int(version) >= 31
        for version in versions.values()
        if version is not None
    ):
        return True, "全部地图均为 Reforged map-info v31+"
    return (
        False,
        "需要 Reforged map-info v31+，当前为 "
        + _format_map_info_versions(versions),
    )


def _reforged_migration_compatibility(
    versions: dict[str, int | None],
) -> tuple[bool, bool, str]:
    missing = sum(version is None for version in versions.values())
    if missing:
        return (
            True,
            False,
            "有 %d 个地图无法读取 war3map.w3i" % missing,
        )
    values = [
        int(version)
        for version in versions.values()
        if version is not None
    ]
    if not values:
        return True, False, "没有可读取的 map-info 数据"
    if all(version >= 31 for version in values):
        return False, False, "当前已经是 Reforged map-info v31+"
    if any(version < 25 for version in values):
        return (
            True,
            False,
            "包含低于 v25 的 map-info，不支持自动迁移",
        )
    legacy = sum(version < 31 for version in values)
    return (
        True,
        True,
        "可将 %d 个旧版地图迁移到 Reforged map-info v31+/2/2"
        % legacy,
    )


def _universal_talents_compatibility(
    source_kind: str,
    script_type: str,
    new_backpack_supported: bool,
    migration_supported: bool,
) -> tuple[bool, str]:
    label = (
        "Lua" if script_type == "lua" else "JASS"
    ) + (
        " 战役" if source_kind == "campaign" else " 单图"
    )
    if new_backpack_supported:
        return True, "Reforged " + label
    if migration_supported:
        return True, "Reforged 数据迁移后可用（" + label + "）"
    return False, "需要 Reforged map-info v31+"


def analyze_source(path: Path) -> CampaignInfo:
    path = path.resolve()
    if not path.is_file():
        raise OfflineToolError("找不到源战役或地图：" + str(path))
    suffix = path.suffix.lower()
    if suffix not in (".w3n", ".w3x", ".w3m"):
        raise OfflineToolError("仅支持 .w3n 战役或 .w3x/.w3m 单张地图。")
    if suffix in (".w3x", ".w3m"):
        return analyze_map(path)

    outer = W.MPQArchive(str(path))
    script_types: set[str] = set()
    already_injected = False
    chapters: list[str] = []
    map_info_versions: dict[str, int | None] = {}
    try:
        chapters = sorted(
            name for name in outer.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        if not chapters:
            raise OfflineToolError("战役中没有列出章节地图，可能是未命名保护块。")
        chapter_titles = CAMP.campaign_chapter_titles(path)
        injectable_chapters: list[str] = []
        cinematic_chapters: dict[str, str] = {}
        for name in chapters:
            key = CAMP.normalize_chapter_name(name)
            folded = key.casefold()
            title = chapter_titles.get(folded) or chapter_titles.get(
                folded.rsplit("/", 1)[-1], ""
            )
            reason = CAMP.cinematic_chapter_reason(key, title)
            if reason:
                cinematic_chapters[key] = reason
                continue
            injectable_chapters.append(key)
            data = outer.read_file(name)
            if not data:
                raise OfflineToolError("章节无法读取：" + name)
            fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
            os.close(fd)
            temp = Path(temp_name)
            try:
                temp.write_bytes(data)
                chapter = W.MPQArchive(str(temp))
                try:
                    map_info_versions[name] = _read_map_info_version(
                        chapter.read_file("war3map.w3i") or b""
                    )
                    jass = chapter.read_file("war3map.j") or b""
                    lua = chapter.read_file("war3map.lua") or b""
                    script = lua or jass
                    if not script:
                        raise OfflineToolError("章节没有 JASS/Lua 脚本：" + name)
                    if lua:
                        script_types.add("lua")
                    else:
                        script_types.add("jass")
                    if b"WG_Init" in script or b"IB_Init" in script:
                        already_injected = True
                finally:
                    chapter.close()
            finally:
                temp.unlink(missing_ok=True)
    finally:
        outer.close()

    if not injectable_chapters:
        raise OfflineToolError(
            "\u8be5\u6218\u5f79\u53ea\u5305\u542b\u8fc7\u573a\u7ae0"
            "\u8282\uff0c\u6ca1\u6709\u53ef\u6ce8\u5165\u7684\u5267\u60c5"
            "\u6d41\u7a0b\u3002"
        )
    if len(script_types) != 1:
        raise OfflineToolError(
            "战役混用了 JASS/Lua 章节，v1 无法安全地自动选择管线："
            + ", ".join(sorted(script_types))
        )
    script_type = next(iter(script_types))
    if already_injected:
        raise OfflineToolError(
            "源战役已经包含 ALAS 模块。请选择未注入的干净源文件，不能二次追加。"
        )
    if not NAMES.read_campaign_title(path)[0]:
        raise OfflineToolError("无法读取战役标题。")

    new_backpack_supported, new_backpack_reason = (
        _new_backpack_compatibility(map_info_versions)
    )
    (
        reforged_migration_required,
        reforged_migration_supported,
        reforged_migration_reason,
    ) = _reforged_migration_compatibility(map_info_versions)
    talent_supported, talent_reason = _universal_talents_compatibility(
        "campaign",
        script_type,
        new_backpack_supported,
        reforged_migration_supported,
    )
    return CampaignInfo(
        source=str(path),
        source_kind="campaign",
        title=NAMES.read_campaign_title(path)[0] or "",
        script_type=script_type,
        map_info_versions=map_info_versions,
        new_backpack_supported=new_backpack_supported,
        new_backpack_reason=new_backpack_reason,
        universal_talents_supported=talent_supported,
        universal_talents_reason=talent_reason,
        reforged_migration_required=reforged_migration_required,
        reforged_migration_supported=reforged_migration_supported,
        reforged_migration_reason=reforged_migration_reason,
        chapters=chapters,
        injectable_chapters=injectable_chapters,
        cinematic_chapters=cinematic_chapters,
        source_sha256=sha256_file(path),
        source_bytes=path.stat().st_size,
        already_injected=already_injected,
    )


def analyze_map(path: Path) -> CampaignInfo:
    archive = W.MPQArchive(str(path))
    try:
        map_info_data = archive.read_file("war3map.w3i") or b""
        jass = archive.read_file("war3map.j") or b""
        if not jass:
            jass = (
                archive.read_file(r"scripts\war3map.j")
                or archive.read_file(r"Scripts\war3map.j")
                or b""
            )
        lua = archive.read_file("war3map.lua") or b""
        if not lua:
            lua = (
                archive.read_file(r"scripts\war3map.lua")
                or archive.read_file(r"Scripts\war3map.lua")
                or b""
            )
    finally:
        archive.close()
    if jass and lua:
        raise OfflineToolError(
            "地图同时包含 JASS 和 Lua 脚本，无法安全判断应修改哪一份。"
        )
    if not jass and not lua:
        raise OfflineToolError(
            "地图没有可读取的 war3map.j/war3map.lua，可能是加密或壳化地图。"
        )
    script_type = "lua" if lua else "jass"
    script = lua or jass
    already_injected = b"WG_Init" in script or b"IB_Init" in script
    if already_injected:
        raise OfflineToolError(
            "源地图已经包含 ALAS 模块。请选择未注入的干净源文件，不能二次追加。"
        )
    header_title = NAMES.read_hm3w(path)
    map_info_versions = {
        path.name: _read_map_info_version(map_info_data),
    }
    new_backpack_supported, new_backpack_reason = (
        _new_backpack_compatibility(map_info_versions)
    )
    (
        reforged_migration_required,
        reforged_migration_supported,
        reforged_migration_reason,
    ) = _reforged_migration_compatibility(map_info_versions)
    talent_supported, talent_reason = _universal_talents_compatibility(
        "map",
        script_type,
        new_backpack_supported,
        reforged_migration_supported,
    )
    return CampaignInfo(
        source=str(path),
        source_kind="map",
        title=(
            NAMES.strip_colours(header_title)
            if header_title
            else path.stem
        ),
        script_type=script_type,
        map_info_versions=map_info_versions,
        new_backpack_supported=new_backpack_supported,
        new_backpack_reason=new_backpack_reason,
        universal_talents_supported=talent_supported,
        universal_talents_reason=talent_reason,
        reforged_migration_required=reforged_migration_required,
        reforged_migration_supported=reforged_migration_supported,
        reforged_migration_reason=reforged_migration_reason,
        chapters=[],
        injectable_chapters=[],
        cinematic_chapters={},
        source_sha256=sha256_file(path),
        source_bytes=path.stat().st_size,
        already_injected=False,
    )


def analyze_campaign(path: Path) -> CampaignInfo:
    """Backward-compatible alias used by older launchers."""
    return analyze_source(path)


class OfflineBuilder:
    def __init__(
        self,
        log: Log | None = None,
        *,
        compact_archive: bool = True,
        ft_data: bool = False,
        reforged_migrate: bool = False,
        equipment_mode: str = "command",
        new_backpack: bool = False,
        new_backpack_panels: tuple[str, ...] | None = None,
        universal_talents: bool = False,
        wild_equipment_drops: bool = False,
        campaign_equipment_drops: bool = False,
        follow_game_graphics: bool = False,
        include_cinematic_chapters: bool = False,
        repair_saves: bool = True,
        repair_save_dir: Path | None = None,
    ) -> None:
        self.log = log or print
        self.compact_archive = compact_archive
        self.ft_data = ft_data
        self.reforged_migrate = reforged_migrate
        if self.ft_data and self.reforged_migrate:
            raise OfflineToolError(
                "游戏数据改为 FT 与 Reforged 数据迁移不能同时启用。"
            )
        if equipment_mode not in ("item", "command"):
            raise OfflineToolError(
                "equipment_mode must be item or command"
            )
        self.equipment_mode = equipment_mode
        self.universal_talents = bool(universal_talents)
        self.wild_equipment_drops = bool(wild_equipment_drops)
        self.campaign_equipment_drops = bool(
            campaign_equipment_drops
        )
        self.include_cinematic_chapters = bool(
            include_cinematic_chapters
        )
        self.new_backpack = bool(new_backpack)
        if self.universal_talents and not self.new_backpack:
            raise OfflineToolError(
                "通用天赋树必须与新背包系统一起启用"
            )
        if self.wild_equipment_drops and not self.new_backpack:
            raise OfflineToolError(
                "wild equipment drops require the new backpack"
            )
        if self.campaign_equipment_drops and not self.new_backpack:
            raise OfflineToolError(
                "campaign equipment drops require the new backpack"
            )
        if self.wild_equipment_drops and self.campaign_equipment_drops:
            raise OfflineToolError(
                "wild map drops and campaign drops are mutually exclusive"
            )
        panels = tuple(new_backpack_panels or ("inventory", "stats"))
        allowed_panels = ("inventory", "equipment", "stats", "talents")
        if any(panel not in allowed_panels for panel in panels):
            raise OfflineToolError("unknown new-backpack panel")
        if len(set(panels)) != len(panels):
            raise OfflineToolError("duplicate new-backpack panel")
        if (
            self.wild_equipment_drops
            or self.campaign_equipment_drops
        ) and "equipment" not in panels:
            panels = tuple(panels) + ("equipment",)
        if self.new_backpack and not panels:
            raise OfflineToolError(
                "new backpack requires at least one selected panel"
            )
        self.new_backpack_panels = panels
        self.follow_game_graphics = follow_game_graphics
        self.repair_saves = repair_saves
        self.repair_save_dir = repair_save_dir
        self.python_executable = os.environ.get(
            "ALAS_WORKER_EXE", sys.executable
        )
        self._process: subprocess.Popen[str] | None = None
        self._cancel = threading.Event()
        self._last_command: list[str] = []
        self._campaign_drop_bundle: (
            WILD_DROPS.CampaignDropBundle | None
        ) = None
        self._talent_bundle: (
            TALENT_BUNDLE.TalentBundle | None
        ) = None

    @property
    def cancelled(self) -> bool:
        return self._cancel.is_set()

    def cancel(self) -> None:
        self._cancel.set()
        process = self._process
        if process and process.poll() is None:
            creationflags = getattr(subprocess, "CREATE_NO_WINDOW", 0)
            subprocess.run(
                ["taskkill", "/T", "/F", "/PID", str(process.pid)],
                capture_output=True,
                creationflags=creationflags,
            )

    def _env(self) -> dict[str, str]:
        env = dict(os.environ)
        env["PYTHONUTF8"] = "1"
        env["PYTHONIOENCODING"] = "utf-8"
        env["ALAS_WORKSPACE"] = str(ROOT)
        env["ALAS_COMPACT_ARCHIVE"] = (
            "1" if self.compact_archive else "0"
        )
        env["ALAS_FT_DATA"] = "1" if self.ft_data else "0"
        env["ALAS_REFORGED_MIGRATE"] = (
            "1" if self.reforged_migrate else "0"
        )
        env["ALAS_EQUIPMENT_MODE"] = self.equipment_mode
        env["ALAS_NEW_BACKPACK"] = "1" if self.new_backpack else "0"
        env["ALAS_NEW_BACKPACK_PANELS"] = ",".join(
            self.new_backpack_panels
        )
        env["ALAS_UNIVERSAL_TALENTS"] = (
            "1" if self.universal_talents else "0"
        )
        env["ALAS_WILD_EQUIPMENT_DROPS"] = (
            "1" if self.wild_equipment_drops else "0"
        )
        env["ALAS_CAMPAIGN_EQUIPMENT_DROPS"] = (
            "1" if self.campaign_equipment_drops else "0"
        )
        env["ALAS_FOLLOW_GAME_GRAPHICS"] = (
            "1" if self.follow_game_graphics else "0"
        )
        env["PYTHONPATH"] = os.pathsep.join(
            [str(INJECTOR), str(DOCTOR), env.get("PYTHONPATH", "")]
        ).rstrip(os.pathsep)
        return env

    def run(self, args: list[object], env_extra: dict[str, str] | None = None) -> int:
        command = [str(value) for value in args]
        self._last_command = command
        self.log("> " + subprocess.list2cmdline(command))
        env = self._env()
        if env_extra:
            env.update(env_extra)
        creationflags = getattr(subprocess, "CREATE_NO_WINDOW", 0)
        process = subprocess.Popen(
            command,
            cwd=str(ROOT),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
            creationflags=creationflags,
        )
        self._process = process
        assert process.stdout is not None
        try:
            for line in process.stdout:
                self.log(line.rstrip())
            return process.wait()
        finally:
            self._process = None

    def prepare_config(
        self, source: Path, output: Path, source_kind: str
    ) -> str:
        if not TEMPLATE_CONFIG.is_file():
            raise OfflineToolError("缺少离线配置模板：" + str(TEMPLATE_CONFIG))
        token = hashlib.sha1(
            f"{source.resolve()}|{output.resolve()}|{time.time_ns()}".encode("utf-8")
        ).hexdigest()[:12]
        config_name = "wings_config_offline_" + token
        target = INJECTOR / (config_name + ".py")
        shutil.copy2(TEMPLATE_CONFIG, target)
        pick_args: list[object] = [
            self.python_executable, INJECTOR / "pick_ids.py", source,
        ]
        if source_kind == "campaign":
            pick_args += ["--campaign", "--chapters"]
        pick_args.append("--write")
        code = self.run(
            pick_args,
            {"WINGS_CONFIG": config_name},
        )
        if code:
            raise OfflineToolError("ID 冲突处理失败，退出码 %d" % code)
        importlib.invalidate_caches()
        config = importlib.import_module(config_name)
        expected_wing_keys = {"fallen", "seraph", "demon", "star"}
        wing_keys = {wing["key"] for wing in config.WINGS}
        actual = {wing["item"] for wing in config.WINGS}
        actual.update(config.WEAPONS.values())
        actual.add(config.HAND["item"])
        if wing_keys != expected_wing_keys or len(actual) != 7:
            raise OfflineToolError("自动配置缺少完整 ALAS 装备 ID。")
        if any(len(ident) != 4 or not ident.isascii() for ident in actual):
            raise OfflineToolError("自动配置生成了非法物品 ID。")
        self.log("自动配置: " + target.name)
        return config_name

    def _is_forsaken_lua_campaign(self, info: CampaignInfo) -> bool:
        return (
            info.source_kind == "campaign"
            and info.script_type == "lua"
            and FORSAKEN_CHAPTERS.issubset(set(info.chapters))
        )

    def _prepare_forsaken_source(self, work: Path) -> None:
        wct_fix = RECOVER / "patch_forsaken_301_wct.py"
        gameplay_fix = RECOVER / "patch_forsaken_301_source_fixes.py"
        for path in (wct_fix, gameplay_fix):
            if not path.is_file():
                raise OfflineToolError(
                    "缺少被遗忘的王国源修复工具：" + str(path)
                )
        self.log("被遗忘的王国：修复 WCT 文本长度结构")
        code = self.run([
            self.python_executable, wct_fix, "--work", work,
        ])
        if code:
            raise OfflineToolError("WCT 结构修复失败，退出码 %d。" % code)
        self.log("被遗忘的王国：修复鼠巢、坑道、巢母、黑暗犬和女妖任务")
        code = self.run([
            self.python_executable, gameplay_fix, "--work", work,
        ])
        if code:
            raise OfflineToolError("旧任务问题修复失败，退出码 %d。" % code)

    def _compact_campaign_release(
        self,
        output: Path,
        work: Path,
        expected_chapters: list[str],
        skipped_cinematics: dict[str, str],
    ) -> None:
        compactor = RECOVER / "compact_campaign.py"
        if not compactor.is_file():
            raise OfflineToolError("缺少无损缩容工具：" + str(compactor))
        before = output.stat().st_size
        output.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(
            dir=output.parent, prefix=".alas-compact-"
        ) as temp_name:
            target = Path(temp_name) / output.name
            compact_work = work / "release-compaction"
            compact_work.mkdir(parents=True, exist_ok=True)
            self.log("逐章无损重压缩并紧凑重建战役归档")
            compact_args: list[object] = [
                self.python_executable,
                compactor,
                "--campaign",
                output,
                "--work",
                compact_work,
                "--output",
                target,
            ]
            for name in sorted(skipped_cinematics):
                compact_args.extend(["--skip-chapter", name])
            code = self.run(compact_args)
            if code:
                self.log(
                    "战役无损缩容失败，退出码 %d；保留已通过逐文件校验的"
                    "未缩容成品。地图仍可正常使用，只是文件更大。"
                    % code
                )
                return
            if not target.is_file():
                self.log("无损缩容未生成成品；保留未缩容成品。")
                return
            archive = W.MPQArchive(str(target))
            try:
                chapters = sorted(
                    name for name in archive.listfile
                    if name.lower().endswith((".w3x", ".w3m"))
                )
            finally:
                archive.close()
            if chapters != sorted(expected_chapters):
                self.log(
                    "缩容后章节列表发生变化；保留未缩容成品并继续后续审计。"
                )
                return
            after = target.stat().st_size
            if after >= before:
                self.log(
                    "战役已足够紧凑，无损压缩未减小文件，保留原成品：%d -> %d"
                    % (before, after)
                )
                return
            os.replace(target, output)
            self.log(
                "无损缩容完成：%d -> %d 字节（节省 %.1f%%）"
                % (before, after, 100.0 * (before - after) / before)
            )

    def _compact_map_release(self, output: Path, work: Path) -> None:
        compactor = RECOVER / "compact_map.py"
        if not compactor.is_file():
            raise OfflineToolError("缺少单图无损压缩工具：" + str(compactor))
        before = output.stat().st_size
        with tempfile.TemporaryDirectory(
            dir=output.parent, prefix=".alas-compact-"
        ) as temp_name:
            target = Path(temp_name) / output.name
            self.log("逐块重压缩地图并去重相同数据")
            code = self.run([
                self.python_executable,
                compactor,
                "--map",
                output,
                "--output",
                target,
            ])
            if code:
                raise OfflineToolError(
                    "单图无损压缩失败，退出码 %d。" % code
                )
            if not target.is_file():
                raise OfflineToolError("单图无损压缩未生成成品。")
            after = target.stat().st_size
            if after < before:
                os.replace(target, output)
                self.log(
                    "单图无损压缩完成：%d -> %d 字节（节省 %.1f%%）"
                    % (before, after, 100.0 * (before - after) / before)
                )
            else:
                self.log("单图已足够紧凑，无需替换成品")

    def _audit_lua_release(
        self,
        output: Path,
        expected_chapters: list[str],
        config_name: str,
        skipped_cinematics: dict[str, str],
    ) -> None:
        config = importlib.import_module(config_name)
        avatar_id = config.ABIL["act_blink"]
        demon_wing = next(
            wing for wing in config.WINGS if wing.get("key") == "demon"
        )
        outer = W.MPQArchive(str(output))
        try:
            title, _hm3w = NAMES.read_campaign_title(output)
            if not re.match(r"^\s*alas(?:\s|$)", title, re.I):
                raise OfflineToolError(
                    "Lua 战役标题缺少 alas 前缀：%r" % title
                )
            chapters = sorted(
                name for name in outer.listfile
                if name.lower().endswith((".w3x", ".w3m"))
            )
            if chapters != sorted(expected_chapters):
                raise OfflineToolError("Lua 成品章节列表与源战役不一致。")
            required_markers = (
                b"function WG_Init()",
                b"function IB_Init()",
                b"function FR_Init()",
                b"function WGL_Init()",
            )
            for name in chapters:
                data = outer.read_file(name)
                if not data:
                    raise OfflineToolError("Lua 成品章节无法读取：" + name)
                fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
                os.close(fd)
                temp = Path(temp_name)
                try:
                    temp.write_bytes(data)
                    chapter = W.MPQArchive(str(temp))
                    try:
                        script = chapter.read_file("war3map.lua") or b""
                        if name in skipped_cinematics:
                            for marker in (
                                b"function WG_Init",
                                b"function IB_Init",
                                b"function FR_Init",
                                b"function WGL_Init",
                                b"__alasRunInit",
                            ):
                                if marker in script:
                                    raise OfflineToolError(
                                        "%s: skipped cinematic chapter contains %s"
                                        % (
                                            name,
                                            marker.decode("ascii"),
                                        )
                                    )
                            continue
                        if FORSAKEN_CHAPTERS.issubset(set(chapters)):
                            text_data = chapter.read_file("war3map.wct") or b""
                            trigger_data = chapter.read_file("war3map.wtg") or b""
                            custom_text = wtg.read_wct(text_data)
                            trigger_table, _ = wtg.load_td(None)
                            map_triggers = wtg.read_wtg(
                                trigger_data, trigger_table
                            )
                            wtg.trigger_texts(map_triggers, custom_text)
                            if name in {
                                "UndeadRE01.w3x",
                                "UndeadRE01_02.w3x",
                                "UndeadRE01_03.w3x",
                                "UndeadRE01_05.w3x",
                                "UndeadRE01_06.w3x",
                                "UndeadRE02.w3x",
                            }:
                                marker = (
                                    b"-- ALAS_FORSaken_301_"
                                    b"KNOWN_GAMEPLAY_FIXES_V1"
                                )
                                if script.count(marker) != 1:
                                    raise OfflineToolError(
                                        "%s 缺少被遗忘的王国任务修复标记" % name
                                    )
                        for marker in required_markers:
                            if marker not in script:
                                raise OfflineToolError(
                                    "%s 缺少运行时入口 %s"
                                    % (name, marker.decode("ascii"))
                                )
                        if b'__alasRunInit("LOAD", ALAS_InitLoadSync)' not in script:
                            raise OfflineToolError(
                                "%s: equipment load recovery is missing" % name
                            )
                        item_active = self.equipment_mode == "item"
                        if (
                            b"TriggerRegisterPlayerChatEvent" not in script
                            or b"__alasOnQtCommand" not in script
                            or b'"qt"' not in script
                            or b"FogEnable(false)" not in script
                            or b"FogMaskEnable(false)" not in script
                        ):
                            raise OfflineToolError(
                                "%s: qt 开全图命令缺失" % name
                            )
                        mode_value = b"true" if item_active else b"false"
                        for mode_name in (
                            b"WG_ITEM_ACTIVE",
                            b"FR_ITEM_ACTIVE",
                            b"WGL_ITEM_ACTIVE",
                        ):
                            mode_marker = mode_name + b" = " + mode_value
                            if script.count(mode_marker) != 1:
                                raise OfflineToolError(
                                    "%s: %s ownership mode is not unique"
                                    % (name, mode_name.decode("ascii"))
                                )
                        if (
                            item_active
                            and b"BlzUnitItemInEquipmentSlot" not in script
                        ):
                            raise OfflineToolError(
                                "%s: equipped-item ownership checks are missing"
                                % name
                            )
                        item_data = chapter.read_file("war3map.w3t") or b""
                        ability_data = chapter.read_file("war3map.w3a") or b""
                        _, item_entries, _ = ITEM_RULES.O.read_objects_bytes(
                            item_data,
                            False,
                            fname=name + ":w3t",
                            with_end=True,
                        )
                        _, ability_entries, _ = ITEM_RULES.O.read_objects_bytes(
                            ability_data,
                            True,
                            fname=name + ":w3a",
                            with_end=True,
                        )
                        item_fields = {
                            entry[2].strip("\0"): {
                                mod[0]: mod[4] for mod in entry[3]
                            }
                            for entry in item_entries
                        }
                        require_wing_copy(item_fields, config, name)
                        ability_fields = {
                            entry[2].strip("\0"): {
                                mod[0]: mod[4] for mod in entry[3]
                            }
                            for entry in ability_entries
                        }
                        ability_origins = {
                            entry[2].replace("\0", ""): entry[1].replace(
                                "\0", ""
                            )
                            for entry in ability_entries
                            if entry[2].replace("\0", "")
                        }
                        avatar_fields = ability_fields.get(avatar_id, {})
                        if ability_origins.get(avatar_id) != "ANcl":
                            raise OfflineToolError(
                                "%s: %s must use the inert ANcl base"
                                % (name, avatar_id)
                            )
                        expected_avatar_strings = {
                            "aite": "1",
                            "anam": "\u5929\u795e\u4e0b\u51e1",
                            "aord": "avatar",
                            "aani": "stand",
                            "Ncl2": "0",
                            "Ncl6": "avatar",
                            "acat": "",
                            "aart": (
                                "ReplaceableTextures\\CommandButtons"
                                "\\BTNMetamorphosis.blp"
                            ),
                            "arar": (
                                "ReplaceableTextures\\CommandButtons"
                                "\\BTNMetamorphosis.blp"
                            ),
                        }
                        for field, expected in expected_avatar_strings.items():
                            actual = avatar_fields.get(field)
                            if isinstance(actual, bytes):
                                actual = actual.decode(
                                    "utf-8", "replace"
                                )
                            if str(actual) != str(expected):
                                raise OfflineToolError(
                                    "%s: %s.%s=%r, expected %r"
                                    % (
                                        name,
                                        avatar_id,
                                        field,
                                        actual,
                                        expected,
                                    )
                                )
                        if (
                            "abuf" in avatar_fields
                            or "Hav1" in avatar_fields
                        ):
                            raise OfflineToolError(
                                "%s: %s still contains Vampiric Aura data"
                                % (name, avatar_id)
                            )
                        expected_avatar_numbers = {
                            "adur": float(
                                config.COMMON["act_avatar_duration"]
                            ),
                            "ahdu": float(
                                config.COMMON["act_avatar_duration"]
                            ),
                            "acdn": float(
                                config.COMMON["act_avatar_cd"]
                            ),
                            "amcs": int(
                                config.COMMON["act_avatar_mana"]
                            ),
                        }
                        for field, expected in expected_avatar_numbers.items():
                            try:
                                actual = float(
                                    avatar_fields.get(field, "nan")
                                )
                            except (TypeError, ValueError):
                                actual = float("nan")
                            if abs(actual - float(expected)) > 0.0001:
                                raise OfflineToolError(
                                    "%s: %s.%s=%r, expected %r"
                                    % (
                                        name,
                                        avatar_id,
                                        field,
                                        avatar_fields.get(field),
                                        expected,
                                    )
                                )
                        demon_fields = item_fields.get(
                            demon_wing["item"], {}
                        )
                        demon_abilities = demon_fields.get("iabi", b"")
                        if isinstance(demon_abilities, bytes):
                            demon_abilities = demon_abilities.decode(
                                "utf-8", "replace"
                            )
                        expected_demon_abilities = ",".join(
                            demon_wing["iabi"]
                        )
                        if demon_abilities != expected_demon_abilities:
                            raise OfflineToolError(
                                "%s: %s.iabi=%r, expected %r"
                                % (
                                    name,
                                    demon_wing["item"],
                                    demon_abilities,
                                    expected_demon_abilities,
                                )
                            )
                        if str(demon_fields.get("idrp")) != "0":
                            raise OfflineToolError(
                                "%s: %s.idrp=%r, expected 0"
                                % (
                                    name,
                                    demon_wing["item"],
                                    demon_fields.get("idrp"),
                                )
                            )
                        avatar_markers = (
                            b"function WG_OnAvatarSimple takes",
                            b"function WG_AvatarSimpleExpires takes",
                            b"function WG_OnAvatarDropItem takes",
                            b"BlzGetUnitIntegerField(u, "
                            b"UNIT_IF_DEFENSE_TYPE)",
                            b"BlzSetUnitIntegerField(u, "
                            b"UNIT_IF_DEFENSE_TYPE, "
                            b"WG_AVATAR_DIVINE_DEFENSE)",
                            b"WG_AVATAR_MAGIC_IMMUNITY",
                            b"AvatarActive=",
                            b"UnitRemoveAbility(u, "
                            b"WG_AVATAR_WING_MODEL_ABILITY)",
                            b"UnitAddAbility(u, "
                            b"WG_AVATAR_WING_MODEL_ABILITY)",
                            b"BlzUnitDisableAbility(u, "
                            b"WG_AVATAR_WING_MODEL_ABILITY, true, true)",
                            b"SaveItemHandle(wg_avatarTable, key, 10, it)",
                            b"SetItemDroppable(it, false)",
                            b"SetItemDroppable(it, true)",
                            b"TimerStart(t, WG_AVATAR_DURATION, false, "
                            b"function WG_AvatarSimpleExpires)",
                            b"TriggerAddAction(t, function WG_OnAvatarSimple)",
                            b"real WG_AVATAR_ATTACK_SPEED_PCT = 1.0",
                            b"real WG_AVATAR_MOVE_SPEED_PCT = 1.0",
                            b"real WG_AVATAR_MODEL_SCALE_MULT = 3.0",
                            b"UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN",
                            b"BlzGetUnitRealField(u, "
                            b"UNIT_RF_SCALING_VALUE)",
                            b"SetUnitScale(u, targetScale, targetScale, "
                            b"targetScale)",
                            b"SetUnitMoveSpeed(u, originalSpeed * "
                            b"(1.0 + WG_AVATAR_MOVE_SPEED_PCT))",
                            b"LoadReal(wg_avatarTable, key, 50)",
                            b"LoadReal(wg_avatarTable, key, 51)",
                        )
                        compact_script = runtime_compact(script)
                        for marker in avatar_markers:
                            marker_text = marker.decode("ascii")
                            match = re.fullmatch(
                                r"function (\w+) takes",
                                marker_text,
                            )
                            if match:
                                marker_text = (
                                    "function " + match.group(1) + "("
                                )
                            elif "function " in marker_text:
                                marker_text = marker_text.replace(
                                    "function ",
                                    "",
                                )
                            marker_text = re.sub(
                                r"^(?:real|integer|boolean|string) ",
                                "",
                                marker_text,
                            )
                            if not runtime_marker_matches(
                                script,
                                compact_script,
                                marker,
                            ):
                                raise OfflineToolError(
                                    "%s: Avatar runtime token is missing: %s"
                                    % (name, marker_text)
                                )
                        bash_fields = ability_fields.get(
                            config.HAND["bash"], {}
                        )
                        if (
                            abs(
                                float(bash_fields.get("Hbh1", "nan"))
                                - 20.0
                            )
                            > 0.0001
                        ):
                            raise OfflineToolError(
                                "%s: 阿克蒙德之手重击概率不是 20%%"
                                % name
                            )
                        require_frost_control(
                            ability_fields,
                            ability_origins,
                            script,
                            name,
                        )
                        if item_active:
                            expected_items = {
                                "I103": ("A100,A101,A102,W091", "A100"),
                                "I105": ("A105,A106,A108,A109", "A105"),
                                "I106": ("A113,A110,A111,Aclq", "A113"),
                            }
                        else:
                            expected_items = {
                                "I103": ("A101,A102,W091", ""),
                                "I105": ("A106,A108,A109", ""),
                                "I106": ("A110,A111,Aclq", ""),
                            }
                        for ident, (abilities, cooldown) in expected_items.items():
                            fields = item_fields.get(ident, {})
                            actual_abilities = fields.get("iabi", b"")
                            actual_cooldown = fields.get("icid", b"")
                            if isinstance(actual_abilities, bytes):
                                actual_abilities = actual_abilities.decode(
                                    "utf-8", "replace"
                                )
                            if isinstance(actual_cooldown, bytes):
                                actual_cooldown = actual_cooldown.decode(
                                    "utf-8", "replace"
                                )
                            if (
                                actual_abilities != abilities
                                or actual_cooldown != cooldown
                            ):
                                raise OfflineToolError(
                                    "%s: %s equipment ownership mismatch"
                                    % (name, ident)
                                )
                            if item_active:
                                item_class = fields.get("icla", b"")
                                equipment = fields.get("iequ", b"")
                                usable = fields.get("iusa", -1)
                                if isinstance(item_class, bytes):
                                    item_class = item_class.decode(
                                        "utf-8", "replace"
                                    )
                                if isinstance(equipment, bytes):
                                    equipment = equipment.decode(
                                        "utf-8", "replace"
                                    )
                                if (
                                    item_class != "Equipment"
                                    or equipment != "Trinket"
                                    or int(usable) != 0
                                ):
                                    raise OfflineToolError(
                                        "%s: %s is not a non-usable Trinket"
                                        % (name, ident)
                                    )
                        expected_aite = 0
                        for ident in ("A100", "A105", "A113"):
                            actual_aite = ability_fields.get(ident, {}).get(
                                "aite", -1
                            )
                            if int(actual_aite) != expected_aite:
                                raise OfflineToolError(
                                    "%s: %s.aite=%r, expected %d"
                                    % (name, ident, actual_aite, expected_aite)
                                )
                            fields = ability_fields.get(ident, {})
                            if (
                                int(fields.get("abpx", -1)) != 2
                                or int(fields.get("abpy", -1)) != 1
                            ):
                                raise OfflineToolError(
                                    "%s: %s command-card position is not 2,1"
                                    % (name, ident)
                                )
                        spellbook_aite = ability_fields.get(
                            "A116", {}
                        ).get("aite", -1)
                        if int(spellbook_aite) != 1:
                            raise OfflineToolError(
                                "%s: A116 is not an internal item spellbook"
                                % name
                            )
                        for ident in (
                            "A101", "A102", "W091",
                            "A106", "A108", "A109",
                            "A110", "A111",
                        ):
                            passive_aite = ability_fields.get(
                                ident, {}
                            ).get("aite", -1)
                            if int(passive_aite) != 1:
                                raise OfflineToolError(
                                    "%s: %s is not an item passive"
                                    % (name, ident)
                                )
                        add_start = script.find(b"function IB_AddGive")
                        add_end = script.find(b"function IB_AddStep", add_start)
                        add_path = (
                            script[add_start:add_end]
                            if add_start >= 0 and add_end >= 0
                            else b""
                        )
                        if (
                            b"ALAS_GrantArtifact(u, GetItemTypeId(it))"
                            not in add_path
                        ):
                            raise OfflineToolError(
                                "%s: additem does not grant the artifact skill"
                                % name
                            )
                        if b"TriggerSleepAction(0.05)" in add_path:
                            raise OfflineToolError(
                                "%s: additem still uses the ineffective delay"
                                % name
                            )
                        for asset in (
                            "war3campImported\\Frostmourne.mdx",
                            "Chest_Legendary.mdx",
                            "ReplaceableTextures\\CommandButtons"
                            "\\BTNDemonicWarglaives.blp",
                        ):
                            if not chapter.read_file(asset):
                                raise OfflineToolError(
                                    "%s 缺少资源 %s" % (name, asset)
                                )
                    finally:
                        chapter.close()
                finally:
                    temp.unlink(missing_ok=True)
        finally:
            outer.close()
        self.log("Lua 成品审计通过：标题、章节、入口和关键资源。")

    def _audit_item_rules(self, output: Path, chapters: list[str]) -> None:
        outer = W.MPQArchive(str(output))
        try:
            for name in chapters:
                data = outer.read_file(name)
                if not data:
                    raise OfflineToolError("规则审计无法读取章节：" + name)
                fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
                os.close(fd)
                temp = Path(temp_name)
                try:
                    temp.write_bytes(data)
                    chapter = W.MPQArchive(str(temp))
                    try:
                        item_data = chapter.read_file("war3map.w3t") or b""
                        ability_data = chapter.read_file("war3map.w3a") or b""
                        ITEM_RULES.validate_item_bytes(item_data)
                        ITEM_RULES.validate_ability_bytes(ability_data)
                    finally:
                        chapter.close()
                finally:
                    temp.unlink(missing_ok=True)
        finally:
            outer.close()
        self.log(
            "物品规则审计通过：翅膀/神器不可出售，"
            "炽天使之翼群体传送复刻澄海 3C 配置。"
        )

    def _audit_map_release(self, output: Path, config_name: str) -> None:
        config = importlib.import_module(config_name)
        weapon_ids = getattr(
            config,
            "WEAPONS",
            {"frostmourne": "I105", "warglaive": "I106"},
        )
        if self.run([
            self.python_executable,
            INJECTOR / "audit_item_copy.py",
            "--map",
            output,
            "--hand-id",
            config.HAND["item"],
            "--frostmourne-id",
            weapon_ids["frostmourne"],
            "--warglaive-id",
            weapon_ids["warglaive"],
        ]):
            raise OfflineToolError("神器说明与建筑冻结脚本审计失败。")
        archive = W.MPQArchive(str(output))
        try:
            script = archive.read_file("war3map.j") or b""
            if not script:
                script = (
                    archive.read_file(r"scripts\war3map.j")
                    or archive.read_file(r"Scripts\war3map.j")
                    or b""
                )
            for marker in (
                b"function IB_Init takes nothing returns nothing",
                b"function WG_Init takes nothing returns nothing",
                b"function FR_Init takes nothing returns nothing",
                b"function WGL_Init takes nothing returns nothing",
            ):
                if marker not in script:
                    raise OfflineToolError(
                        "单图成品缺少运行时入口：" + marker.decode("ascii")
                    )
            if b"exitwhen created >= count" not in script:
                raise OfflineToolError(
                    "additem 没有按请求数量限制物品创建，存在无限补物品风险。"
                )
            if b"exitwhen added >= count" in script:
                raise OfflineToolError(
                    "additem 仍在按成功入包数量循环，满包或消耗品会导致死循环。"
                )
            decoded_script = script.decode("utf-8", "replace")
            if (
                b"function ALAS_InitQtCommand takes" not in script
                or b"function ALAS_OnQtCommand takes" not in script
                or b"function ALAS_InitQtCommand)" not in script
                or b"TriggerRegisterPlayerChatEvent" not in script
                or b'"qt"' not in script
                or b"FogEnable(false)" not in script
                or b"FogMaskEnable(false)" not in script
            ):
                raise OfflineToolError(
                    "地图缺少 qt 开全图命令代码。"
                )
            if decoded_script.count("call ALAS_EnableFullMap()") != 1:
                raise OfflineToolError(
                    "qt 开全图不能在启动时自动执行。"
                )
            item_data = archive.read_file("war3map.w3t") or b""
            ability_data = archive.read_file("war3map.w3a") or b""
            ITEM_RULES.validate_item_bytes(item_data)
            ITEM_RULES.validate_ability_bytes(ability_data)
            item_entries = ITEM_RULES.O.read_objects_bytes(
                item_data, False, fname="map.w3t", with_end=True
            )[1]
            ability_entries = ITEM_RULES.O.read_objects_bytes(
                ability_data, True, fname="map.w3a", with_end=True
            )[1]
            buff_data = archive.read_file("war3map.w3h") or b""
            buff_entries = ITEM_RULES.O.read_objects_bytes(
                buff_data, False, fname="map.w3h", with_end=True
            )[1]
            item_ids = {
                entry[2].replace("\0", "")
                for entry in item_entries
            }
            ability_ids = {
                entry[2].replace("\0", "")
                for entry in ability_entries
            }
            avatar = next(
                (
                    entry for entry in ability_entries
                    if entry[2].replace("\0", "") == config.ABIL["act_blink"]
                ),
                None,
            )
            if avatar is None or avatar[1].replace("\0", "") != "ANcl":
                raise OfflineToolError(
                    "单图恶魔降临必须使用无被动效果的 ANcl 基底。"
                )
            avatar_fields = {mod[0]: mod[4] for mod in avatar[3]}
            expected_avatar = {
                "aord": b"avatar",
                "aani": b"stand",
                "Ncl2": 0,
                "Ncl6": b"avatar",
                "acat": b"",
                "aefs": b"",
                "aefl": b"",
            }
            if "abuf" in avatar_fields or "Hav1" in avatar_fields:
                raise OfflineToolError(
                    "单图恶魔降临仍含吸血光环数据。"
                )
            for field, expected in expected_avatar.items():
                if avatar_fields.get(field) != expected:
                    raise OfflineToolError(
                        "单图恶魔降临字段 %s 不正确。" % field
                    )
            for marker in (
                b"real WG_AVATAR_ATTACK_SPEED_PCT = 1.0",
                b"real WG_AVATAR_MOVE_SPEED_PCT = 1.0",
                b"real WG_AVATAR_MODEL_SCALE_MULT = 3.0",
                b"BlzGetUnitRealField(u, UNIT_RF_SCALING_VALUE)",
                b"SetUnitScale(u, targetScale, targetScale, targetScale)",
                b"SetUnitMoveSpeed(u, originalSpeed * "
                b"(1.0 + WG_AVATAR_MOVE_SPEED_PCT))",
                b"LoadReal(wg_avatarTable, key, 50)",
                b"LoadReal(wg_avatarTable, key, 51)",
            ):
                if marker not in script:
                    raise OfflineToolError(
                        "单图恶魔降临缺少运行时字段：%s"
                        % marker.decode("ascii")
                    )
            item_active = self.equipment_mode == "item"
            mode_value = b"true" if item_active else b"false"
            for mode_name in (
                b"WG_ITEM_ACTIVE",
                b"FR_ITEM_ACTIVE",
                b"WGL_ITEM_ACTIVE",
            ):
                mode_marker = mode_name + b" = " + mode_value
                if script.count(mode_marker) != 1:
                    raise OfflineToolError(
                        "单图成品 %s 归属模式不正确"
                        % mode_name.decode("ascii")
                    )
            decoded_script = script.decode("utf-8", "replace")
            for function_name, ability_id, check_event in (
                ("WG_OnHandItemEvent", "WG_FINGER_ABILITY", True),
                ("FR_OnItemDrop", "FR_SPELL_ID", False),
                ("WGL_OnItemEvent", "'A113'", True),
            ):
                start = decoded_script.find(
                    "function %s takes" % function_name
                )
                end = decoded_script.find("endfunction", start)
                body = (
                    decoded_script[start:end]
                    if start >= 0 and end >= 0
                    else ""
                )
                if (
                    "GetManipulatedItem()" not in body
                    or (
                        check_event
                        and "EVENT_PLAYER_UNIT_DROP_ITEM" not in body
                    )
                    or "UnitRemoveAbility(u, %s)" % ability_id
                    not in body
                ):
                    raise OfflineToolError(
                        "单图 %s 缺少卸装即时移除技能。"
                        % function_name
                    )
                if "TriggerSleepAction" in body:
                    raise OfflineToolError(
                        "单图 %s 仍依赖延迟卸装同步。"
                        % function_name
                    )
            item_fields = {
                entry[2].strip("\0"): {
                    mod[0]: mod[4] for mod in entry[3]
                }
                for entry in item_entries
            }
            ability_fields = {
                entry[2].strip("\0"): {
                    mod[0]: mod[4] for mod in entry[3]
                }
                for entry in ability_entries
            }
            ability_origins = {
                entry[2].replace("\0", ""): entry[1].replace("\0", "")
                for entry in ability_entries
                if entry[2].replace("\0", "")
            }
            require_wing_copy(item_fields, config, output.name)
            bash_fields = ability_fields.get(config.HAND["bash"], {})
            if abs(float(bash_fields.get("Hbh1", "nan")) - 20.0) > 0.0001:
                raise OfflineToolError("单图阿克蒙德之手重击概率不是 20%。")
            require_frost_control(
                ability_fields,
                ability_origins,
                script,
                output.name,
            )
            if item_active:
                expected_items = {
                    "I103": ("A100,A101,A102,W091", "A100"),
                    "I105": ("A105,A106,A108,A109", "A105"),
                    "I106": ("A113,A110,A111,Aclq", "A113"),
                }
                if b"BlzUnitItemInEquipmentSlot" not in script:
                    raise OfflineToolError(
                        "单图新背包模式缺少装备栏归属检查。"
                    )
                for ident, expected in expected_items.items():
                    fields = item_fields.get(ident, {})
                    abilities = fields.get("iabi", b"")
                    cooldown = fields.get("icid", b"")
                    if isinstance(abilities, bytes):
                        abilities = abilities.decode("utf-8", "replace")
                    if isinstance(cooldown, bytes):
                        cooldown = cooldown.decode("utf-8", "replace")
                    if (abilities, cooldown) != expected:
                        raise OfflineToolError(
                            "单图新背包模式 %s 的物品技能归属不正确。"
                            % ident
                        )
                    item_class = fields.get("icla", b"")
                    equipment = fields.get("iequ", b"")
                    if isinstance(item_class, bytes):
                        item_class = item_class.decode("utf-8", "replace")
                    if isinstance(equipment, bytes):
                        equipment = equipment.decode("utf-8", "replace")
                    if (
                        item_class != "Equipment"
                        or equipment != "Trinket"
                        or int(fields.get("iusa", -1)) != 0
                    ):
                        raise OfflineToolError(
                            "单图新背包模式 %s 缺少 Equipment/Trinket。"
                            % ident
                        )
            required_items = {
                wing["item"] for wing in config.WINGS
            }
            required_items.update(config.WEAPONS.values())
            required_items.add(config.HAND["item"])
            required_abilities = JASS_CAMPAIGN.required_ability_ids(config)
            if required_items - item_ids:
                raise OfflineToolError(
                    "单图成品缺少物品："
                    + ", ".join(sorted(required_items - item_ids))
                )
            if required_abilities - ability_ids:
                raise OfflineToolError(
                    "单图成品缺少技能："
                    + ", ".join(sorted(required_abilities - ability_ids))
                )
            assets = (
                "war3campImported\\Frostmourne.mdx",
                "war3campImported\\DemonBoltImpactSilent.mdx",
                "war3campImported\\IceStompRaised.mdx",
                "war3campImported\\Rune-Blue-Aura_Raised20.mdx",
                "WingOfTheLucifer.MDX",
                "FWIND.MDX",
                "DoomgGuardWings.mdx",
                "anchibang0100.mdx",
                "Chest_Legendary.mdx",
                "ReplaceableTextures\\CommandButtons"
                "\\BTNDemonicWarglaives.blp",
                "ReplaceableTextures\\CommandButtons"
                "\\BTNGarrekCharge.blp",
            )
            missing_assets = [
                asset for asset in assets if not archive.read_file(asset)
            ]
            stormfall = archive.read_file("StormfallRed.mdx") or b""
            if b"EVTS" in stormfall:
                raise OfflineToolError(
                    "StormfallRed.mdx still contains sound event chunks"
                )
            silent_impact = (
                archive.read_file("war3campImported\\DemonBoltImpactSilent.mdx")
                or b""
            )
            if b"EVTS" in silent_impact:
                raise OfflineToolError(
                    "DemonBoltImpactSilent.mdx still contains sound events"
                )
            if missing_assets:
                raise OfflineToolError(
                    "单图成品缺少资源：" + ", ".join(missing_assets)
                )
        finally:
            archive.close()
        expected_title = "alas " + (
            output.stem[4:].lstrip()
            if output.stem.lower().startswith("alas")
            else output.stem
        )
        actual_title = NAMES.read_hm3w(output)
        if actual_title is not None and NAMES.strip_colours(actual_title) != expected_title:
            raise OfflineToolError(
                "单图标题不一致：%r != %r" % (actual_title, expected_title)
            )
        self.log(
            "单图成品审计通过：标题、入口、完整装备、不可出售规则、"
            "澄海 3C 传送配置及关键资源。"
        )

    def _audit_lua_map_release(self, output: Path) -> None:
        archive = W.MPQArchive(str(output))
        try:
            script = archive.read_file("war3map.lua") or b""
            item_data = archive.read_file("war3map.w3t") or b""
            ability_data = archive.read_file("war3map.w3a") or b""
        finally:
            archive.close()
        if not script or not item_data or not ability_data:
            raise OfflineToolError(
                "Lua 单图成品缺少脚本或对象数据。"
            )
        for marker in (
            b"function IB_Init()",
            b"function WG_Init()",
            b"function FR_Init()",
            b"function WGL_Init()",
            b'__alasRunInit("LOAD", ALAS_InitLoadSync)',
        ):
            if marker not in script:
                raise OfflineToolError(
                    "Lua 单图成品缺少运行时入口："
                    + marker.decode("ascii")
                )
        for marker in (b"__alasOnQtCommand", b'"qt"', b"FogEnable(false)"):
            if marker not in script:
                raise OfflineToolError(
                    "Lua 单图成品缺少 qt 开全图代码。"
                )
        ITEM_RULES.validate_item_bytes(item_data)
        ITEM_RULES.validate_ability_bytes(ability_data)
        self.log(
            "Lua 单图成品审计通过：运行时、物品规则与 qt 命令。"
        )

    def _audit_ft_data(
        self, output: Path, source_kind: str, chapters: list[str]
    ) -> None:
        if not self.ft_data:
            return
        outer = W.MPQArchive(str(output))
        checked = 0
        skipped = 0
        try:
            names = chapters if source_kind == "campaign" else ["<map>"]
            for name in names:
                if source_kind == "campaign":
                    data = outer.read_file(name)
                    if not data:
                        raise OfflineToolError("FT 审计无法读取章节：" + name)
                    fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
                    os.close(fd)
                    temp = Path(temp_name)
                    try:
                        temp.write_bytes(data)
                        inner = W.MPQArchive(str(temp))
                        try:
                            w3i_data = inner.read_file("war3map.w3i") or b""
                        finally:
                            inner.close()
                    finally:
                        temp.unlink(missing_ok=True)
                else:
                    w3i_data = outer.read_file("war3map.w3i") or b""
                if not w3i_data:
                    raise OfflineToolError("FT 审计缺少 war3map.w3i：" + name)
                model = W3I.parse_or_tolerant(w3i_data)
                if int(model["version"]) < 30:
                    skipped += 1
                    continue
                if int(model.get("game_data_version", -1)) != 1:
                    raise OfflineToolError(
                        "FT 游戏数据未生效：%s game_data_version=%s"
                        % (name, model.get("game_data_version"))
                    )
                checked += 1
        finally:
            outer.close()
        self.log(
            "FT 游戏数据审计通过：%d 个地图使用 TFT 数据，%d 个旧版地图保持原样。"
            % (checked, skipped)
        )

    def _audit_graphics_mode(
        self,
        output: Path,
        source_kind: str,
        chapters: list[str],
        skipped_cinematics: dict[str, str],
    ) -> None:
        if not self.follow_game_graphics:
            return
        outer = W.MPQArchive(str(output))
        checked = 0
        skipped = 0
        try:
            names = chapters if source_kind == "campaign" else ["<map>"]
            for name in names:
                if source_kind == "campaign":
                    data = outer.read_file(name)
                    if not data:
                        raise OfflineToolError(
                            "画面模式审计无法读取章节：" + name
                        )
                    fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
                    os.close(fd)
                    temp = Path(temp_name)
                    try:
                        temp.write_bytes(data)
                        inner = W.MPQArchive(str(temp))
                        try:
                            w3i_data = inner.read_file("war3map.w3i") or b""
                        finally:
                            inner.close()
                    finally:
                        temp.unlink(missing_ok=True)
                else:
                    w3i_data = outer.read_file("war3map.w3i") or b""
                if not w3i_data:
                    raise OfflineToolError("画面模式审计缺少 war3map.w3i：" + name)
                model = W3I.parse_or_tolerant(w3i_data)
                if int(model["version"]) < 31:
                    skipped += 1
                    continue
                if int(model.get("supported_modes", -1)) != 3:
                    raise OfflineToolError(
                        "画面模式未跟随游戏设置：%s supported_modes=%s"
                        % (name, model.get("supported_modes"))
                    )
                checked += 1
        finally:
            outer.close()
        self.log(
            "画面模式审计通过：%d 个地图允许 SD/HD 跟随游戏设置，"
            "%d 个旧版地图无需该字段。"
            % (checked, skipped)
        )
        audit_args: list[object] = [
            self.python_executable,
            INJECTOR / "apply_graphics_mode.py",
            "--audit",
            "--input",
            output,
        ]
        for name in sorted(skipped_cinematics):
            audit_args.extend(["--skip-chapter", name])
        code = self.run(audit_args)
        if code:
            raise OfflineToolError("Reforged hero graphics audit failed.")

    def _audit_universal_talents(self, output: Path) -> None:
        if not self.universal_talents:
            return
        try:
            if self._talent_bundle is None:
                raise ValueError("universal talent bundle is missing")
            TALENT_BUNDLE.verify_bundle(output, self._talent_bundle)
        except Exception as exc:
            raise OfflineToolError(
                "通用天赋树审计失败：" + str(exc)
            ) from exc
        self.log("通用天赋树审计通过：64 套独立天赋与专属背包。")

    def _audit_wild_equipment_drops(
        self,
        output: Path,
        source_kind: str,
        script_type: str,
    ) -> None:
        if not (
            self.wild_equipment_drops
            or self.campaign_equipment_drops
        ):
            return
        try:
            if self.campaign_equipment_drops:
                if self._campaign_drop_bundle is None:
                    raise ValueError("campaign drop bundle is missing")
                WILD_DROPS.verify_campaign_bundle(
                    output,
                    self._campaign_drop_bundle,
                    script_type,
                )
            else:
                WILD_DROPS.verify_bundle(output, script_type)
        except Exception as exc:
            raise OfflineToolError(
                "wild equipment drop audit failed: " + str(exc)
            ) from exc
        self.log(
            (
                "campaign equipment drops: neutral hostile + enemy heroes"
                if self.campaign_equipment_drops
                else (
                    "wild equipment drops: neutral hostile only; "
                    "white/green/blue/purple + boss orange"
                )
            )
        )

    def _audit_new_backpack(
        self,
        output: Path,
        source_kind: str,
        chapters: list[str],
        script_type: str,
    ) -> None:
        if not self.new_backpack:
            return
        expected = ",".join(
            {
                "inventory": "AIni",
                "equipment": "AEqu",
                "stats": "ASde",
                "talents": "ATal",
            }[panel]
            for panel in self.new_backpack_panels
        )
        outer = W.MPQArchive(str(output))
        names = chapters if source_kind == "campaign" else ["<map>"]
        checked = 0
        try:
            for name in names:
                if source_kind == "campaign":
                    data = outer.read_file(name)
                    if not data:
                        raise OfflineToolError(
                            "新背包审计无法读取章节：" + name
                        )
                    fd, temp_name = tempfile.mkstemp(
                        suffix=Path(name).suffix
                    )
                    os.close(fd)
                    temp = Path(temp_name)
                    try:
                        temp.write_bytes(data)
                        inner = W.MPQArchive(str(temp))
                        try:
                            item_data = inner.read_file("war3map.w3t") or b""
                            info_data = inner.read_file("war3map.w3i") or b""
                            script = (
                                inner.read_file("war3map.j")
                                or inner.read_file(r"scripts\war3map.j")
                                or inner.read_file(r"Scripts\war3map.j")
                                or inner.read_file("war3map.lua")
                                or inner.read_file(r"scripts\war3map.lua")
                                or inner.read_file(r"Scripts\war3map.lua")
                                or b""
                            )
                        finally:
                            inner.close()
                    finally:
                        temp.unlink(missing_ok=True)
                else:
                    item_data = outer.read_file("war3map.w3t") or b""
                    info_data = outer.read_file("war3map.w3i") or b""
                    script = (
                        outer.read_file("war3map.j")
                        or outer.read_file(r"scripts\war3map.j")
                        or outer.read_file(r"Scripts\war3map.j")
                        or outer.read_file("war3map.lua")
                        or outer.read_file(r"scripts\war3map.lua")
                        or outer.read_file(r"Scripts\war3map.lua")
                        or b""
                    )
                _version, entries, consumed = OBJ.read_objects_bytes(
                    item_data,
                    False,
                    fname=name + ".w3t",
                    with_end=True,
                )
                if consumed != len(item_data):
                    raise OfflineToolError(
                        "新背包对象数据有尾随字节：" + name
                    )
                info = W3I.parse_or_tolerant(info_data)
                if (
                    info.get("game_data_set"),
                    info.get("game_data_version"),
                ) != (2, 2):
                    raise OfflineToolError(
                        name + " 未设置 Reforged 2/2 数据版本"
                    )
                if self.universal_talents:
                    talent_backpacks = []
                    for _table, _old, new, mods in entries:
                        ident = new.replace("\0", "")
                        if not ident.startswith("Z"):
                            continue
                        fields = {
                            mod[0]: (
                                mod[4].decode("utf-8", "replace")
                                if isinstance(mod[4], bytes)
                                else mod[4]
                            )
                            for mod in mods
                        }
                        iabi = fields.get("iabi")
                        if (
                            isinstance(iabi, str)
                            and iabi.startswith("AIni,AEqu,ASde,Q")
                        ):
                            talent_backpacks.append(ident)
                    if not talent_backpacks:
                        raise OfflineToolError(
                            name + " 缺少通用天赋 Zxxx 背包物品"
                        )
                    ensure_marker = (
                        b"function TT_EnsureBackpack("
                        if script_type == "lua"
                        else b"function TT_EnsureBackpack"
                    )
                    grant_marker = (
                        b"it = UnitAddItemByIdSwapped(desiredId, u)"
                        if script_type == "lua"
                        else b"set it = UnitAddItemByIdSwapped(desiredId, u)"
                    )
                    if (
                        ensure_marker not in script
                        or grant_marker not in script
                    ):
                        raise OfflineToolError(
                            name + " 缺少通用天赋背包发放脚本"
                        )
                else:
                    item = next(
                        (
                            mods
                            for _table, _old, new, mods in entries
                            if new.replace("\0", "") == "B30B"
                        ),
                        None,
                    )
                    if item is None:
                        raise OfflineToolError(
                            "新背包缺少 B30B：" + name
                        )
                    fields = {
                        mod[0]: (
                            mod[4].decode("utf-8", "replace")
                            if isinstance(mod[4], bytes)
                            else mod[4]
                        )
                        for mod in item
                    }
                    if fields.get("iabi") != expected:
                        raise OfflineToolError(
                            "%s 的新背包页签不正确：%r"
                            % (name, fields.get("iabi"))
                        )
                    if (
                        b"ALAS_B30B_Init" not in script
                        and b"local function ensureHero" not in script
                    ):
                        raise OfflineToolError(
                            name + " 缺少新背包英雄发放脚本"
                        )
                checked += 1
        finally:
            outer.close()
        self.log(
            "新背包审计通过：%d 个地图，页签=%s。"
            % (checked, ",".join(self.new_backpack_panels))
        )

    def _run_audits(
        self,
        source: Path,
        work: Path,
        output: Path,
        script_type: str,
        chapters: list[str],
        skipped_cinematics: dict[str, str],
        source_kind: str,
        config: str,
    ) -> None:
        injected_chapters = [
            chapter
            for chapter in chapters
            if chapter not in skipped_cinematics
        ]
        self._audit_universal_talents(output)
        self._audit_wild_equipment_drops(
            output,
            source_kind,
            script_type,
        )
        self._audit_new_backpack(
            output, source_kind, injected_chapters, script_type
        )
        terms = ["阿克蒙德", "霜之哀伤", "埃辛诺斯战刃"]
        args: list[object] = [
            self.python_executable, INJECTOR / "audit_item_catalog.py",
            "--campaign" if source_kind == "campaign" else "--map",
            source, "--work", work,
        ]
        for term in terms:
            args.extend(["--term", term])
        if self.run(args):
            raise OfflineToolError("物品目录审计失败。")
        if source_kind == "map":
            if script_type == "lua":
                self._audit_lua_map_release(output)
            else:
                self._audit_map_release(output, config)
            self._audit_ft_data(output, source_kind, chapters)
            self._audit_graphics_mode(
                output,
                source_kind,
                chapters,
                skipped_cinematics,
            )
            return
        self._audit_item_rules(output, injected_chapters)
        self._audit_ft_data(output, source_kind, injected_chapters)
        self._audit_graphics_mode(
            output,
            source_kind,
            injected_chapters,
            skipped_cinematics,
        )
        if script_type == "lua":
            self._audit_lua_release(
                output,
                chapters,
                config,
                skipped_cinematics,
            )
            return
        if not LOCAL_AUDIT.is_file():
            raise OfflineToolError("缺少离线战役审计脚本。")
        audit_args: list[object] = [
            self.python_executable, LOCAL_AUDIT, output,
            "--config", config,
            "--equipment-mode", self.equipment_mode,
        ]
        for name in sorted(skipped_cinematics):
            audit_args.extend(["--skip-chapter", name])
        if self.run(audit_args):
            raise OfflineToolError("ALAS 战役结构审计失败。")

    def _run_doctor(self, targets: list[Path]) -> list[dict[str, object]]:
        results: list[dict[str, object]] = []
        doctor = DOCTOR / "DevosMapDoctor.py"
        if not doctor.is_file():
            self.log("提示：未找到 Map Doctor，跳过深度检查。")
            return results
        env = self._env()
        env["PJASS"] = find_pjass()
        for index, chapter in enumerate(targets, 1):
            self.log("[Doctor %d/%d] %s" % (index, len(targets), chapter.name))
            run = subprocess.run(
                [self.python_executable, str(doctor), "check", str(chapter),
                 "--quiet", "--json"],
                cwd=str(ROOT),
                env=env,
                capture_output=True,
                text=True,
                encoding="utf-8",
                errors="replace",
                creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
            )
            verdict = "error"
            blockers = 0
            try:
                report = json.loads(run.stdout)
                verdict = str(report.get("verdict", "error"))
                blockers = sum(
                    1 for item in report.get("items", [])
                    if item.get("severity") == "blocker"
                )
            except (TypeError, json.JSONDecodeError):
                self.log("  Doctor 输出无法解析，退出码 %d" % run.returncode)
            self.log("  %s，阻断项 %d" % (verdict, blockers))
            results.append({
                "chapter": chapter.name,
                "verdict": verdict,
                "blockers": blockers,
            })
        return results

    def _repair_saves(
        self,
        campaign: Path,
        source_kind: str,
        campaign_title: str = "",
    ) -> SaveRepairResult:
        result = SaveRepairResult(
            enabled=self.repair_saves,
            attempted=False,
            directories=[],
            reports=[],
            errors=[],
            changed=0,
            already_current=0,
            skipped=0,
            backups=[],
            message="",
        )
        if not self.repair_saves:
            result.message = "已关闭"
            self.log("自动修复存档: 关闭")
            return result
        if source_kind != "campaign":
            result.message = "单张地图不处理战役存档"
            self.log("自动修复存档: 跳过（单张地图不处理战役存档）")
            return result
        if not SAVE_REPAIR.is_file():
            result.message = "缺少存档修复工具"
            result.errors.append(str(SAVE_REPAIR))
            self.log("自动修复存档: 缺少 " + str(SAVE_REPAIR))
            return result
        if self.repair_save_dir is not None:
            explicit_dir = self.repair_save_dir.expanduser().resolve()
            if not explicit_dir.is_dir():
                result.message = "指定的存档目录不存在"
                result.errors.append(str(explicit_dir))
                self.log("自动修复存档: 指定的存档目录不存在 " + str(explicit_dir))
                return result

        directories = discover_save_directories(
            campaign,
            extra_names=(campaign_title,),
            explicit_dir=self.repair_save_dir,
        )
        if not directories:
            result.message = "未找到与成品同名的存档目录，已跳过"
            self.log("自动修复存档: " + result.message)
            return result

        result.attempted = True
        result.directories = [str(path) for path in directories]
        self.log("自动修复存档: 使用成品战役身份处理 %d 个目录" % len(directories))
        for directory in directories:
            if self.cancelled:
                result.errors.append("用户取消存档修复")
                break
            self.log("存档目录: " + str(directory))
            command = [
                str(self.python_executable),
                str(SAVE_REPAIR),
                "--campaign",
                str(campaign),
                "--saves",
                str(directory),
                "--apply",
                "--yes",
                "--json",
            ]
            self._last_command = command
            env = self._env()
            creationflags = getattr(subprocess, "CREATE_NO_WINDOW", 0)
            process = subprocess.Popen(
                command,
                cwd=str(ROOT),
                env=env,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                encoding="utf-8",
                errors="replace",
                creationflags=creationflags,
            )
            self._process = process
            try:
                stdout, stderr = process.communicate()
            finally:
                self._process = None
            text = (stdout or "").strip()
            try:
                report = json.loads(text)
            except json.JSONDecodeError:
                report = None
            if process.returncode != 0 or not isinstance(report, dict) or not report.get("ok"):
                detail = ""
                if isinstance(report, dict):
                    detail = str(report.get("error") or report)
                else:
                    detail = (stderr or stdout or "没有返回可解析的 JSON").strip()
                result.errors.append(str(directory) + ": " + detail)
                self.log("自动修复存档失败: " + detail)
                continue

            result.reports.append(report)
            result.changed += int(report.get("changed", 0))
            result.already_current += int(report.get("already_current", 0))
            result.skipped += int(report.get("skipped", 0))
            backup = report.get("backup")
            if backup:
                result.backups.append(str(backup))
            self.log(
                "存档修复完成: 修改 %d，已是最新 %d，跳过 %d"
                % (
                    int(report.get("changed", 0)),
                    int(report.get("already_current", 0)),
                    int(report.get("skipped", 0)),
                )
            )
            if backup:
                self.log("存档备份: " + str(backup))

        if result.errors:
            result.message = "部分或全部存档修复失败"
        elif result.changed:
            result.message = "已修复 %d 个存档" % result.changed
        elif result.already_current:
            result.message = "%d 个存档已经是最新状态" % result.already_current
        else:
            result.message = "存档扫描完成，没有需要修改的存档"
        self.log("自动修复存档: " + result.message)
        return result

    def build(
        self,
        source: Path,
        output: Path,
        *,
        overwrite: bool = False,
        doctor: bool = True,
    ) -> BuildResult:
        self._cancel.clear()
        source = source.resolve()
        output = output.resolve()
        info = analyze_source(source)
        if self.universal_talents:
            if not info.universal_talents_supported:
                raise OfflineToolError(
                    "通用天赋树不可用："
                    + info.universal_talents_reason
                    + "。"
                )
            if (
                not info.new_backpack_supported
                and not self.reforged_migrate
            ):
                raise OfflineToolError(
                    "通用天赋树需要 Reforged 数据；请先启用 Reforged 数据迁移。"
                )
        if self.new_backpack and not info.new_backpack_supported:
            if not self.reforged_migrate:
                raise OfflineToolError(
                    "新背包系统不可用："
                    + info.new_backpack_reason
                    + "；请先启用 Reforged 数据迁移。"
                )
            if not info.reforged_migration_supported:
                raise OfflineToolError(
                    "无法迁移到 Reforged："
                    + info.reforged_migration_reason
                )
        if (
            self.reforged_migrate
            and info.reforged_migration_required
            and not info.reforged_migration_supported
        ):
            raise OfflineToolError(
                "无法迁移到 Reforged："
                + info.reforged_migration_reason
            )
        if self.wild_equipment_drops and info.source_kind != "map":
            raise OfflineToolError(
                "wild equipment drops currently require a single map"
            )
        if self.campaign_equipment_drops and (
            info.source_kind != "campaign"
        ):
            raise OfflineToolError(
                "campaign equipment drops require a campaign source"
            )
        skipped_cinematics = (
            {}
            if self.include_cinematic_chapters
            else dict(info.cinematic_chapters)
        )
        injected_chapters = (
            list(info.chapters)
            if self.include_cinematic_chapters
            else list(info.injectable_chapters)
        )
        if info.source_kind == "campaign" and not injected_chapters:
            raise OfflineToolError(
                "\u672a\u627e\u5230\u53ef\u6ce8\u5165\u7684\u5267\u60c5"
                "\u7ae0\u8282\uff1b\u8be5\u6218\u5f79\u4f3c\u4e4e\u53ea"
                "\u5305\u542b\u8fc7\u573a\u52a8\u753b\u3002"
            )
        forsaken_lua = self._is_forsaken_lua_campaign(info)
        forsaken_fixes = False
        chapter_compaction = False
        lossless_compaction = False
        self.log(
            ("源战役: " if info.source_kind == "campaign" else "源地图: ")
            + str(source)
        )
        self.log("工具版本: " + APP_VERSION)
        self.log("游戏标题: " + info.title)
        self.log("脚本类型: " + info.script_type)
        self.log(
            "新背包兼容性: "
            + (
                "可用（" + info.new_backpack_reason + "）"
                if info.new_backpack_supported
                else "不可用（" + info.new_backpack_reason + "）"
            )
        )
        self.log(
            "Reforged 数据迁移: "
            + (
                "开启（" + info.reforged_migration_reason + "）"
                if self.reforged_migrate
                else "关闭"
            )
        )
        self.log(
            "紧凑归档: " + ("开启" if self.compact_archive else "关闭")
        )
        self.log("FT 游戏数据: " + ("开启" if self.ft_data else "关闭"))
        self.log(
            "新背包系统: "
            + (
                "开启（" + ", ".join(self.new_backpack_panels) + "）"
                if self.new_backpack
                else "关闭"
            )
        )
        self.log(
            "通用天赋树: "
            + (
                "开启（" + info.universal_talents_reason + "）"
                if self.universal_talents
                else "关闭"
            )
        )
        self.log(
            "画面模式跟随游戏设置: "
            + ("开启" if self.follow_game_graphics else "关闭")
        )
        self.log(
            "wild equipment drops: "
            + (
                "enabled (neutral hostile only)"
                if self.wild_equipment_drops
                else "disabled"
            )
        )
        self.log(
            "campaign equipment drops: "
            + (
                "enabled (neutral hostile + enemy heroes)"
                if self.campaign_equipment_drops
                else "disabled"
            )
        )
        if info.source_kind == "campaign":
            self.log("章节数量: %d" % len(info.chapters))
            self.log(
                "ALAS injection chapters: %d, skipped cinematics: %d"
                % (
                    len(injected_chapters),
                    len(skipped_cinematics),
                )
            )
            for name, reason in sorted(skipped_cinematics.items()):
                self.log("  skipped %s (%s)" % (name, reason))
            if output.suffix.lower() != ".w3n":
                raise OfflineToolError("战役成品扩展名必须是 .w3n。")
        else:
            self.log("地图模式: 单张地图")
            if output.suffix.lower() != source.suffix.lower():
                raise OfflineToolError(
                    "单图成品扩展名必须与源地图一致（%s）。"
                    % source.suffix.lower()
                )
        if info.script_type == "jass":
            self.log(
                "JASS 装备技能归属: "
                + (
                    "装备栏物品技能"
                    if self.equipment_mode == "item"
                    else "普通背包 + 英雄技能"
                )
            )
        if output == source:
            raise OfflineToolError("输出不能覆盖源文件。")
        if output.exists():
            if not overwrite:
                raise OfflineToolError("输出已存在；请换文件名或勾选允许归档替换。")
            trash = default_cache_dir() / "replaced"
            trash.mkdir(parents=True, exist_ok=True)
            archived = trash / (
                output.stem + "-" + time.strftime("%Y%m%d-%H%M%S")
                + output.suffix.lower()
            )
            shutil.move(str(output), str(archived))
            self.log("旧成品已移到可恢复目录: " + str(archived))
        output.parent.mkdir(parents=True, exist_ok=True)

        started = time.strftime("%Y-%m-%d %H:%M:%S")
        cache = default_cache_dir()
        slug = re.sub(r"[^0-9A-Za-z_-]+", "_", output.stem)[:60] or "campaign"
        work = cache / "work" / (slug + "-" + time.strftime("%Y%m%d-%H%M%S"))
        work.mkdir(parents=True, exist_ok=False)
        log_path = work / "build.log"
        target_log = self.log

        def tee_log(text: str) -> None:
            target_log(text)
            with log_path.open("a", encoding="utf-8") as handle:
                handle.write(text + "\n")

        self.log = tee_log
        build_work = work / "build"
        self.log("工作目录: " + str(work))
        running = running_war3_processes()
        if running:
            self.log(
                "警告: 检测到 "
                + "、".join(running)
                + " 正在运行。修改对象数据或脚本后，必须完全退出游戏/编辑器"
                "再测试；仅重新开始当前地图可能继续使用旧缓存。"
            )
        compat_report = work / "compat-report.json"
        compat_output = work / "compat" / ("compat-" + source.name)
        code = self.run([
            self.python_executable, APP_DIR / "compat_source.py",
            "--source", source,
            "--work", work / "compat" / "chapters",
            "--output", compat_output,
            "--report", compat_report,
        ])
        if code:
            raise OfflineToolError("源文件兼容检查失败。")
        compatibility = json.loads(compat_report.read_text(encoding="utf-8"))
        build_source = Path(compatibility["output"])
        if compatibility.get("changed"):
            self.log("已应用源文件兼容修复: " + str(build_source))
        if self.reforged_migrate:
            migrated_source = work / "compat" / (
                "reforged-" + build_source.name
            )
            code = self.run([
                self.python_executable,
                INJECTOR / "apply_reforged_migration.py",
                str(build_source),
                "--output", str(migrated_source),
                "--work", str(work / "reforged-migration"),
            ])
            if code:
                raise OfflineToolError("Reforged 数据迁移失败。")
            build_source = migrated_source
        elif self.new_backpack and self.universal_talents:
            # Universal talents grant their own Zxxx backpack items rather than
            # using apply_new_backpack.py. Those items still depend on the
            # Reforged AIni/AEqu/ASde panel abilities, so the target chapters
            # must use the 2/2 data baseline even when map-info is already v31.
            reforged_data_source = work / "compat" / (
                "reforged-data-" + build_source.name
            )
            code = self.run([
                self.python_executable,
                INJECTOR / "apply_reforged_migration.py",
                str(build_source),
                "--output", str(reforged_data_source),
                "--work", str(work / "reforged-data-version"),
            ])
            if code:
                raise OfflineToolError(
                    "通用天赋背包的 Reforged 2/2 数据切换失败。"
                )
            self.log(
                "通用天赋背包已启用 Reforged 2/2 数据版本: "
                + str(reforged_data_source)
            )
            build_source = reforged_data_source
        if self.ft_data and info.source_kind == "map":
            ft_source = work / "compat" / ("ft-" + source.name)
            code = self.run([
                self.python_executable, INJECTOR / "apply_ft_data.py",
                "--input", build_source,
                "--output", ft_source,
            ])
            if code:
                raise OfflineToolError("单图 FT 游戏数据转换失败。")
            if ft_source.is_file():
                build_source = ft_source
            else:
                self.log("FT 转换已跳过，继续使用兼容源文件。")
        if self.follow_game_graphics and info.source_kind == "map":
            graphics_source = work / "compat" / (
                "graphics-" + source.name
            )
            code = self.run([
                self.python_executable,
                INJECTOR / "apply_graphics_mode.py",
                "--input", build_source,
                "--output", graphics_source,
            ])
            if code:
                raise OfflineToolError("单图画面模式转换失败。")
            build_source = graphics_source
        if self.new_backpack and not self.universal_talents:
            backpack_source = work / "compat" / (
                "backpack-" + build_source.name
            )
            code = self.run([
                self.python_executable,
                INJECTOR / "apply_new_backpack.py",
                str(build_source),
                "--output", str(backpack_source),
                "--work", str(work / "new-backpack"),
                "--panels", ",".join(self.new_backpack_panels),
            ])
            if code:
                raise OfflineToolError("新背包系统注入失败。")
            build_source = backpack_source
        config = self.prepare_config(
            source, output, info.source_kind
        )
        talent_bundle = None
        if self.universal_talents:
            talent_bundle = TALENT_BUNDLE.prepare_bundle(
                build_source,
                work / "universal-talents",
                injected_chapters,
            )
            self._talent_bundle = talent_bundle
            self.log(
                "通用天赋等级基准: "
                + ", ".join(
                    "%s=%d" % (name, level)
                    for name, level in sorted(
                        talent_bundle.chapter_levels.items()
                    )
                )
            )
        talent_script_manifest = None
        if talent_bundle is not None and info.source_kind == "campaign":
            talent_script_manifest = (
                work / "universal-talents" / "chapter-scripts.json"
            )
            talent_script_manifest.write_text(
                json.dumps(
                    {
                        chapter: str(
                            talent_bundle.script_for(chapter)
                        )
                        for chapter in injected_chapters
                    },
                    ensure_ascii=False,
                    indent=2,
                ),
                encoding="utf-8",
            )
        wild_drop_bundle = None
        if self.wild_equipment_drops:
            wild_drop_bundle = WILD_DROPS.prepare_bundle(
                build_source,
                work / "wild-equipment-drops",
            )
            self.log(
                "wild drop level cap=%d; pools: "
                % wild_drop_bundle.level_cap
                + ", ".join(
                    "%s=%d" % (name, count)
                    for name, count in wild_drop_bundle.counts.items()
                )
            )
        campaign_drop_bundle = None
        if self.campaign_equipment_drops:
            campaign_drop_bundle = WILD_DROPS.prepare_campaign_bundle(
                build_source,
                work / "campaign-equipment-drops",
                injected_chapters,
            )
            self._campaign_drop_bundle = campaign_drop_bundle
            self.log(
                "campaign drop profiles: "
                + ", ".join(
                    "%s(global=%d,native=%d/%d,%d%%)"
                    % (
                        profile.chapter,
                        profile.level_cap,
                        profile.chapter_level_cap,
                        profile.chapter_hero_level_cap,
                        profile.chapter_progress,
                    )
                    for profile in campaign_drop_bundle.profiles
                )
            )
        if self.cancelled:
            raise OfflineToolError("用户取消。")

        if info.source_kind == "map":
            port_args: list[object] = [
                self.python_executable, INJECTOR / "port_alas_jass_map.py",
                "--map", build_source,
                "--work", build_work,
                "--config", config,
                "--output", output,
            ]
            if talent_bundle is not None:
                port_args.extend([
                    "--extra-script", talent_bundle.script_for(),
                    "--extra-object",
                    "w3a=" + str(talent_bundle.ability_object),
                    "--extra-object",
                    "w3t=" + str(talent_bundle.item_object),
                    "--suppress-source-backpack-auto",
                ])
            if wild_drop_bundle is not None:
                port_args.extend([
                    "--extra-script", wild_drop_bundle.script_dir,
                ])
            code = self.run(port_args)
        elif info.script_type == "jass":
            campaign_args: list[object] = [
                self.python_executable, INJECTOR / "port_alas_jass_campaign.py",
                "--campaign", build_source,
                "--work", build_work,
                "--config", config,
                "--output", output,
                "--preserve-source", source,
            ]
            if self.include_cinematic_chapters:
                campaign_args.append("--include-cinematic-chapters")
            if campaign_drop_bundle is not None:
                campaign_args.extend([
                    "--campaign-loot-manifest",
                    campaign_drop_bundle.manifest,
                ])
            if talent_bundle is not None:
                campaign_args.extend([
                    "--extra-script-manifest",
                    talent_script_manifest,
                    "--suppress-source-backpack-auto",
                ])
                for extension, path in (
                    ("w3a", talent_bundle.ability_object),
                    ("w3t", talent_bundle.item_object),
                ):
                    campaign_args.extend([
                        "--extra-object",
                        extension + "=" + str(path),
                    ])
            code = self.run(campaign_args)
        else:
            code = self.run([
                self.python_executable, INJECTOR / "port_wings_campaign.py",
                "extract", build_source, "--work", build_work,
            ])
            if not code and self.ft_data:
                code = self.run([
                    self.python_executable, INJECTOR / "apply_ft_data.py",
                    "--input", build_work / "base",
                ])
            if not code and forsaken_lua:
                self._prepare_forsaken_source(build_work)
                forsaken_fixes = True
            if not code:
                lua_args: list[object] = [
                    self.python_executable, INJECTOR / "port_item_skill_campaign.py",
                    "--campaign", build_source,
                    "--work", build_work,
                    "--config", config,
                    "--output", output,
                    "--no-deploy",
                    "--preserve-source", source,
                ]
                if self.include_cinematic_chapters:
                    lua_args.append("--include-cinematic-chapters")
                if campaign_drop_bundle is not None:
                    lua_args.extend([
                        "--campaign-loot-manifest",
                        campaign_drop_bundle.manifest,
                    ])
                if talent_bundle is not None:
                    lua_args.extend([
                        "--extra-lua-script-manifest",
                        talent_script_manifest,
                    ])
                    for extension, path in (
                        ("w3a", talent_bundle.ability_object),
                        ("w3t", talent_bundle.item_object),
                    ):
                        lua_args.extend([
                            "--extra-object",
                            extension + "=" + str(path),
                        ])
                code = self.run(lua_args)
        if code:
            raise OfflineToolError("构建失败，退出码 %d。工作目录已保留。" % code)
        if self.cancelled:
            raise OfflineToolError("用户取消。")

        if self.compact_archive:
            if info.source_kind == "campaign":
                self._compact_campaign_release(
                    output,
                    build_work,
                    info.chapters,
                    skipped_cinematics,
                )
                chapter_compaction = True
            else:
                self._compact_map_release(output, build_work)
            lossless_compaction = True

        if info.source_kind == "campaign" and skipped_cinematics:
            try:
                CAMP.verify_campaign_chapters(
                    source,
                    output,
                    set(skipped_cinematics),
                )
            except Exception as exc:
                raise OfflineToolError(
                    "\u538b\u7f29\u540e\u8fc7\u573a\u7ae0\u8282"
                    "\u6821\u9a8c\u5931\u8d25\uff1a" + str(exc)
                ) from exc

        self._run_audits(
            build_source, build_work, output,
            info.script_type, info.chapters,
            skipped_cinematics,
            info.source_kind, config,
        )
        doctor_results: list[dict[str, object]] = []
        if doctor:
            if info.source_kind == "map":
                doctor_targets = [output]
            else:
                base = build_work / "base"
                doctor_targets = CAMP.chapter_paths(base)
            doctor_results = self._run_doctor(doctor_targets)
        if self.cancelled:
            raise OfflineToolError("用户取消。")
        save_repair = self._repair_saves(
            output,
            info.source_kind,
            info.title,
        )
        if self.cancelled:
            raise OfflineToolError("用户取消。")

        finished = time.strftime("%Y-%m-%d %H:%M:%S")
        result = BuildResult(
            app_version=APP_VERSION,
            source=str(source),
            source_kind=info.source_kind,
            output=str(output),
            compact_archive=self.compact_archive,
            ft_data=self.ft_data,
            reforged_migrate=self.reforged_migrate,
            equipment_mode=self.equipment_mode,
            new_backpack=self.new_backpack,
            new_backpack_panels=self.new_backpack_panels,
            universal_talents=self.universal_talents,
            wild_equipment_drops=self.wild_equipment_drops,
            campaign_equipment_drops=self.campaign_equipment_drops,
            follow_game_graphics=self.follow_game_graphics,
            include_cinematic_chapters=(
                self.include_cinematic_chapters
            ),
            script_type=info.script_type,
            chapters=1 if info.source_kind == "map" else len(info.chapters),
            injected_chapters=(
                1
                if info.source_kind == "map"
                else len(injected_chapters)
            ),
            skipped_cinematic_chapters=len(skipped_cinematics),
            output_bytes=output.stat().st_size,
            output_sha256=sha256_file(output),
            doctor_blockers=sum(
                int(item.get("blockers", 0)) for item in doctor_results
            ),
            save_repair_enabled=self.repair_saves,
            save_repair=save_repair,
            work_dir=str(work),
            report=str(work / "build-report.json"),
            started_at=started,
            finished_at=finished,
        )
        report = {
            "result": asdict(result),
            "campaign": asdict(info),
            "config": config,
            "doctor": doctor_results,
            "save_repair": asdict(save_repair),
            "compatibility": compatibility,
            "forsaken_fixes": forsaken_fixes,
            "chapter_compaction": chapter_compaction,
            "lossless_compaction": lossless_compaction,
            "commands": {
                "last": self._last_command,
            },
        }
        Path(result.report).write_text(
            json.dumps(report, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        self.log("")
        self.log("构建完成")
        self.log("成品: " + result.output)
        self.log("大小: %d 字节" % result.output_bytes)
        self.log("SHA-256: " + result.output_sha256)
        self.log("报告: " + result.report)
        return result


def find_pjass() -> str:
    candidates = [
        APP_DIR / "assets" / "pjass.exe",
        ROOT / "tools" / "recover" / "HiveWE-src" / "HiveWE-main"
        / "data" / "tools" / "pjass.exe",
        ROOT / "tools" / "war3-tools" / "偶久改图一条龙工具包"
        / "tools" / "JassCraft" / "pjass.exe",
    ]
    for path in candidates:
        if path.is_file():
            return str(path)
    found = shutil.which("pjass.exe") or shutil.which("pjass")
    return found or ""
