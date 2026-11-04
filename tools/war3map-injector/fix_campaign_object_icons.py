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
    "w3q": ("aart", "arar", "auar"),
    "w3u": ("uico", "ussi"),
    "w3t": ("iico",),
    "w3h": ("fart",),
    "w3b": ("bico",),
}
OBJECT_PREFIX = "war3campaign."


def collect_icon_refs(archive):
    """直接从对象数据扫描图标字段。

    战役级对象文件是编辑器导出的混合布局，按普通 w3u/w3t 逐条解析会
    在条目之间错位。图标字段本身始终是 ``字段名 + type=3 + 路径``，
    因此按字段名和字符串值扫描更可靠，也不会受原版/自定义分段影响。
    """
    refs = []
    for ext, fields in ICON_FIELDS.items():
        data = archive.read_file(OBJECT_PREFIX + ext)
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
                if value.lower().endswith(".blp") or "\\" in value:
                    refs.append((ext, offset, field, value.replace("/", "\\")))
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
    candidates = [path]
    if "\\" not in path:
        candidates += [
            "war3campImported\\" + path,
            "war3mapImported\\" + path,
            "ReplaceableTextures\\CommandButtons\\" + path,
        ]
    for candidate in candidates:
        if files.exists(candidate):
            return candidate
    return None


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
    disabled = disabled_base(filename)
    same_folder = (folder + "\\" + disabled) if folder else disabled
    return [
        same_folder,
        "ReplaceableTextures\\CommandButtonsDisabled\\" + disabled,
    ]


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


def build_patch(campaign):
    archive = W.MPQArchive(campaign)
    try:
        files = ArchiveFiles(archive)
        refs = collect_icon_refs(archive)
        by_icon = collections.defaultdict(list)
        for ext, object_id, field, value in refs:
            original = resolve_icon(files, value)
            if original:
                by_icon[original].append((ext, object_id, field, value))

        existing = {path: inspect_disabled_states(files, path) for path in by_icon}
        missing = [path for path, found in existing.items() if not found]
        patches = []
        patch_names = {}
        for path in sorted(missing):
            original_data = files.read(path)
            if not original_data:
                raise ValueError("cannot read icon: " + path)
            disabled_data = darken_icon(original_data)
            aliases = []
            for alias in disabled_candidates(path):
                if files.exists(alias):
                    continue
                aliases.append(alias)
                patches.append((alias, disabled_data))
            patch_names[path] = aliases
        return refs, by_icon, existing, patch_names, patches
    finally:
        archive.close()


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
            if not data or data[:4] != b"BLP1":
                bad.append((original, "not BLP1"))
                continue
            content, alpha, width, height, _mips = struct.unpack_from("<IIIII", data, 4)
            if content != 1 or alpha != 8 or (width, height) != (64, 64):
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
