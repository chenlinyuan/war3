# -*- coding: utf-8 -*-
"""批量补齐战役对象数据引用的禁用态图标。

Warcraft III 在按钮不可用、施法暂停或打开游戏菜单时，会改为读取图标的
DIS/DISBTN 版本。自定义图标如果只有启用版，命令卡就会显示绿色方块。

本脚本扫描战役级 war3campaign.w3a/w3u/w3t/w3h/w3b/w3q，找出实际存在于
战役档案中的图标，为缺失的图标生成明显变暗、去饱和的 64x64 BLP1 调色板
版本。默认同时写入原目录和 CommandButtonsDisabled 目录。

注意：禁用态必须写成 BLP1 调色板。BLP1-JPEG 版本曾触发游戏 wcslen 崩溃。

用法：
    python fix_campaign_object_icons.py <campaign.w3n>
    python fix_campaign_object_icons.py <campaign.w3n> --out <new.w3n>
    python fix_campaign_object_icons.py <campaign.w3n> --dry-run
"""
import argparse
import collections
import hashlib
import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import numpy as np  # noqa: E402
from PIL import Image  # noqa: E402

import mpq_patch as MP  # noqa: E402
import war3mpq as W  # noqa: E402
from blp_icon import read_blp, write_blp1_palette  # noqa: E402


ICON_FIELDS = {
    "w3a": ("aart", "arar", "auar"),
    "w3q": ("gar1",),
    "w3u": ("uico", "ussi"),
    "w3t": ("iico",),
    "w3h": ("fart",),
    "w3b": ("bico",),
}
OBJECT_PREFIXES = (
    "war3campaign.",
    "war3campaignSkin.",
    "war3map.",
    "war3mapSkin.",
)
IMAGE_EXTENSIONS = (".blp", ".dds", ".tga", ".png", ".jpg", ".jpeg")
TEXT_ICON_KEYS = {"art", "researchart", "unart"}


def collect_icon_refs(archive):
    """直接从对象数据扫描图标字段。

    战役级对象文件是编辑器导出的混合布局，按普通 w3u/w3t 逐条解析会
    在条目之间错位。图标字段本身始终是 ``字段名 + type=3 + 路径``，
    因此按字段名和字符串值扫描更可靠，也不会受原版/自定义分段影响。
    """
    refs = []
    for prefix in OBJECT_PREFIXES:
        for ext, fields in ICON_FIELDS.items():
            data = archive.read_file(prefix + ext)
            if not data:
                continue
            for field in fields:
                needle = field.encode("latin-1")
                pos = 0
                while True:
                    offset = data.find(needle, pos)
                    if offset < 0:
                        break
                    pos = offset + 1
                    if offset + 8 > len(data):
                        break
                    if struct.unpack_from("<i", data, offset + 4)[0] != 3:
                        continue
                    value_pos = offset + 8
                    if ext in ("w3a", "w3q"):
                        value_pos += 8  # level + column
                    end = data.find(b"\x00", value_pos)
                    if end < 0:
                        continue
                    value = data[value_pos:end].decode("utf-8", "replace")
                    if not value or value in ("-", "_"):
                        continue
                    if (
                        value.lower().endswith(IMAGE_EXTENSIONS)
                        or "\\" in value
                        or "/" in value
                    ):
                        refs.append(
                            (
                                ext,
                                offset,
                                field,
                                value.replace("/", "\\"),
                            )
                        )
    refs.extend(collect_text_icon_refs(archive))
    return refs


def collect_text_icon_refs(archive):
    """Collect icon fields from map/campaign custom text object tables."""
    refs = []
    try:
        names = archive.files()
    except Exception:
        return refs
    for name in names:
        lower = name.casefold()
        if not lower.endswith(".txt"):
            continue
        if not (
            lower.startswith("units\\")
            or lower in ("war3mapskin.txt", "war3campaignskin.txt")
        ):
            continue
        data = archive.read_file(name)
        if not data:
            continue
        section = ""
        for line in data.decode("utf-8", "surrogateescape").splitlines():
            stripped = line.strip()
            if stripped.startswith("[") and stripped.endswith("]"):
                section = stripped[1:-1]
                continue
            if "=" not in stripped or stripped.startswith("//"):
                continue
            key, value = stripped.split("=", 1)
            key = key.strip()
            if key.casefold() not in TEXT_ICON_KEYS:
                continue
            for path in value.split(","):
                path = path.strip().strip('"').replace("/", "\\")
                if (
                    path
                    and not path.upper().startswith("TRIGSTR_")
                    and path not in ("-", "_")
                ):
                    refs.append((name, section, key, path))
    return refs


class ArchiveFiles:
    """带缓存的归档文件探测，不依赖可能不完整的 (listfile)。"""

    def __init__(self, archive):
        self.archive = archive
        self.cache = {}

    def exists(self, name):
        key = name.lower()
        if key not in self.cache:
            try:
                self.cache[key] = self.archive.read_file(name) is not None
            except Exception:
                self.cache[key] = False
        return self.cache[key]

    def read(self, name):
        return self.archive.read_file(name)


def resolve_icon(files, path):
    raw_candidates = [path]
    if "\\" not in path:
        raw_candidates += [
            "war3campImported\\" + path,
            "war3mapImported\\" + path,
            "ReplaceableTextures\\CommandButtons\\" + path,
        ]
    candidates = []
    for candidate in raw_candidates:
        candidates.append(candidate)
        if not os.path.splitext(candidate)[1]:
            candidates.extend(
                candidate + extension
                for extension in IMAGE_EXTENSIONS
            )
    candidates = list(dict.fromkeys(candidates))
    for candidate in candidates:
        if files.exists(candidate):
            return candidate
    return None


def resolve_icon_with_fallback(files, fallback_files, path):
    """Resolve an enabled icon locally, then from the parent campaign."""
    original = resolve_icon(files, path)
    if original:
        return original, files
    if fallback_files is not None:
        original = resolve_icon(fallback_files, path)
        if original:
            return original, fallback_files
    return None, None


def disabled_base(filename):
    upper = filename.upper()
    if upper.startswith("DISBTN"):
        return filename
    if upper.startswith("DIS"):
        return filename
    if upper.startswith("BTN"):
        return "DIS" + filename
    return "DIS" + filename


def disabled_candidates(path):
    folder, filename = os.path.split(path)
    upper = filename.upper()
    disabled = disabled_base(filename)
    same_folder = (folder + "\\" + disabled) if folder else disabled
    same_folder_plain = (
        (folder + "\\DIS" + filename) if folder else "DIS" + filename
    )
    same_folder_btn = (
        same_folder
        if upper.startswith("BTN")
        else (folder + "\\DISBTN" + filename if folder else "DISBTN" + filename)
    )
    command_folder = "ReplaceableTextures\\CommandButtonsDisabled\\"
    return list(dict.fromkeys([
        same_folder_plain,
        same_folder_btn,
        same_folder,
        command_folder + "DIS" + filename,
        command_folder + "DISBTN" + filename,
        command_folder + disabled,
    ]))


def inspect_disabled_states(files, path):
    folder, filename = os.path.split(path)
    upper = filename.upper()
    alternatives = []
    if upper.startswith("DISBTN"):
        alternatives.append(folder + "\\" + "DIS" + filename[3:])
    elif upper.startswith("DIS"):
        alternatives.append(folder + "\\" + "DISBTN" + filename[3:])
    candidates = disabled_candidates(path)
    for alt in alternatives:
        candidates.append(alt)
        candidates.append("ReplaceableTextures\\CommandButtonsDisabled\\" + os.path.basename(alt))
    return [name for name in candidates if files.exists(name)]


def darken_icon(data):
    """把启用图标转成变暗、去饱和的 BLP1 调色板禁用图标。"""
    fields = struct.unpack_from("<IIIII", data, 4)
    content, _alpha_bits, width, height, _has_mips = fields
    if data[:4] != b"BLP1":
        raise ValueError("not BLP1")
    if content == 0:
        import io
        soi = data.find(b"\xff\xd8")
        eoi = data.rfind(b"\xff\xd9")
        if soi < 0 or eoi <= soi:
            raise ValueError("BLP1-JPEG has no complete JPEG stream")
        image = Image.open(io.BytesIO(data[soi:eoi + 2])).convert("RGBA")
        if image.size != (width, height):
            image = image.resize((width, height), Image.LANCZOS)
        rgba = np.array(image)
    elif content == 1:
        import tempfile
        tmp = tempfile.NamedTemporaryFile(suffix=".blp", delete=False)
        tmp.close()
        try:
            with open(tmp.name, "wb") as fh:
                fh.write(data)
            _w, _h, _ab, _mips, _size, rgba = read_blp(tmp.name)
        finally:
            try:
                os.remove(tmp.name)
            except OSError:
                pass
    else:
        raise ValueError("unsupported BLP1 content=%d" % content)

    pixels = rgba.astype(np.float32)
    gray = (
        pixels[:, :, 0] * 0.299
        + pixels[:, :, 1] * 0.587
        + pixels[:, :, 2] * 0.114
    )[:, :, None]
    rgb = (pixels[:, :, :3] * 0.30 + gray * 0.70) * 0.46
    pixels[:, :, :3] = np.clip(rgb, 0, 255)
    image = Image.fromarray(pixels.astype(np.uint8), "RGBA")
    if image.size != (64, 64):
        image = image.resize((64, 64), Image.LANCZOS)

    import tempfile
    tmp = tempfile.NamedTemporaryFile(suffix=".blp", delete=False)
    tmp.close()
    try:
        write_blp1_palette(tmp.name, image, min_size=4, colors=256)
        with open(tmp.name, "rb") as fh:
            return fh.read()
    finally:
        try:
            os.remove(tmp.name)
        except OSError:
            pass


def _build_archive_patch(path, fallback_campaign=None, disabled_cache=None):
    archive = W.MPQArchive(str(path))
    fallback_archive = (
        W.MPQArchive(str(fallback_campaign))
        if fallback_campaign is not None
        else None
    )
    try:
        files = ArchiveFiles(archive)
        fallback_files = (
            ArchiveFiles(fallback_archive)
            if fallback_archive is not None
            else None
        )
        refs = collect_icon_refs(archive)
        by_icon = collections.defaultdict(list)
        data_sources = {}
        for ext, object_id, field, value in refs:
            original, source_files = resolve_icon_with_fallback(
                files,
                fallback_files,
                value,
            )
            if original:
                by_icon[original].append((ext, object_id, field, value))
                data_sources[original] = source_files

        existing = {path: inspect_disabled_states(files, path) for path in by_icon}
        patches = []
        patch_names = {}
        queued = set()
        cache = disabled_cache if disabled_cache is not None else {}
        for path in sorted(by_icon):
            aliases = [
                alias
                for alias in disabled_candidates(path)
                if not files.exists(alias)
                and alias.lower() not in queued
            ]
            if not aliases:
                continue
            original_data = data_sources[path].read(path)
            if not original_data:
                raise ValueError("cannot read icon: " + path)
            cache_key = hashlib.sha256(original_data).digest()
            disabled_data = cache.get(cache_key)
            if disabled_data is None:
                try:
                    disabled_data = darken_icon(original_data)
                except Exception:
                    # Some legacy BLP variants cannot be decoded by Pillow.  A
                    # direct copy still prevents the UI from showing a green
                    # missing-icon square, even though it is not darkened.
                    disabled_data = original_data
                cache[cache_key] = disabled_data
            for alias in aliases:
                patches.append((alias, disabled_data))
                queued.add(alias.lower())
            patch_names[path] = aliases
        return refs, by_icon, existing, patch_names, patches
    finally:
        archive.close()
        if fallback_archive is not None:
            fallback_archive.close()


def build_patch(campaign, disabled_cache=None):
    """Build campaign-level disabled icons from campaign object data."""
    return _build_archive_patch(
        campaign,
        disabled_cache=disabled_cache,
    )


def build_chapter_patch(map_path, campaign, disabled_cache=None):
    """Build chapter-local disabled icons, falling back to campaign assets."""
    return _build_archive_patch(
        map_path,
        fallback_campaign=campaign,
        disabled_cache=disabled_cache,
    )


def summary(info):
    """Return a JSON-serializable disabled-icon patch summary."""
    refs, by_icon, existing, _patch_names, patches = info
    return {
        "icon_references": len(refs),
        "unique_enabled_icons": len(by_icon),
        "covered_enabled_icons": sum(
            1 for names in existing.values() if names
        ),
        "generated_icon_files": len(patches),
    }


def verify_patch(campaign, by_icon, patch_names):
    archive = W.MPQArchive(campaign)
    try:
        files = ArchiveFiles(archive)
        bad = []
        for original in by_icon:
            candidates = patch_names.get(original) or disabled_candidates(original)
            found = [name for name in candidates if files.exists(name)]
            if not found:
                bad.append((original, "missing disabled icon"))
                continue
            data = files.read(found[0])
            if not data:
                bad.append((original, "empty disabled icon"))
                continue
            if data[:4] in (b"BLP2", b"DDS "):
                continue
            if data[:4] != b"BLP1":
                # Imported legacy icons may be TGA/PNG/JPEG. A format-preserving
                # copy is still a valid fallback when palette conversion fails.
                continue
            content, alpha, width, height, _mips = struct.unpack_from(
                "<IIIII", data, 4
            )
            if content not in (0, 1):
                bad.append((original, "unsupported BLP1 content=%d" % content))
                continue
            # JPEG-content BLPs may be original non-64 px source art used as a
            # safe fallback when palette conversion is impossible.  Generated
            # palette icons must remain the standard 64x64 UI size.
            if content == 1 and (width, height) != (64, 64):
                bad.append((original, "bad BLP1 header content=%d alpha=%d size=%dx%d"
                            % (content, alpha, width, height)))
        return bad
    finally:
        archive.close()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("campaign")
    parser.add_argument("--out")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    source = os.path.abspath(args.campaign)
    output = os.path.abspath(args.out) if args.out else source
    refs, by_icon, existing, patch_names, patches = build_patch(source)
    covered = sum(1 for names in existing.values() if names)
    print("图标引用: %d" % len(refs))
    print("档案内自定义图标的唯一启用版: %d" % len(by_icon))
    print("已有禁用态: %d，缺失禁用态: %d"
          % (covered, len(by_icon) - covered))
    print("待写入文件: %d" % len(patches))
    for original in sorted(patch_names):
        aliases = patch_names[original]
        if aliases:
            print("  + %s -> %s" % (original, " | ".join(aliases)))

    if args.dry_run or not patches:
        return 0

    new_path = MP.patch(source, patches, out_path=output, backup=False)
    if not MP.verify(source, new_path, patches):
        print("禁用态写入校验失败")
        return 1
    bad = verify_patch(new_path, by_icon, patch_names)
    if bad:
        print("禁用态内容校验失败:")
        for item in bad:
            print("  ! %s: %s" % item)
        return 1
    print("禁用态图标批量修复完成: %s" % new_path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
