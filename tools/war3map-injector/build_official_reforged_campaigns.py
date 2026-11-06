# -*- coding: utf-8 -*-
"""Build standalone .w3n campaigns from the extracted Reforged chapters.

The source maps and official campaign manifest come from Warcraft III
Reforged's CASC storage.  The generated archives are plain MPQ v1 files with
a 512-byte HM3W header, a literal UTF-8 ``war3campaign.w3f``, and uncompressed
nested chapter archives so the game can open them through
``SFileOpenFileAsArchive``.

The game and World Editor are never launched by this tool.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import io
import os
import re
import struct
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

from mpyq import MPQArchive as PyMPQArchive


HERE = Path(__file__).resolve().parent
DOCTOR_DIR = HERE.parents[1] / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR_DIR))

import war3mpq as W  # noqa: E402
from doctor.data.casc_wc3 import CascWC3  # noqa: E402
from doctor.data import campaign_info, w3i  # noqa: E402


SOURCE_PREFIX = "war3.w3mod:campaign\\reforged\\"
MPQ_MAGIC = b"MPQ\x1a"
HM3W_SIZE = 0x200
MPQ_HEADER_SIZE = 32
SECTOR_SIZE = 0x1000
MPQ_FILE_EXISTS = 0x80000000


@dataclass(frozen=True)
class GroupSpec:
    section: str
    title: str
    filename: str
    branch: str
    prefix: str
    race: int
    race_name: str


GROUPS = (
    GroupSpec("Tutorial", "序章：兽族大逃亡", "官方战役_01_序章_兽族大逃亡.w3n", "roc", "prologue", 1, "Orc"),
    GroupSpec("Human", "洛丹伦的天灾", "官方战役_02_洛丹伦的天灾.w3n", "roc", "human", 0, "Human"),
    GroupSpec("Undead", "诅咒之路", "官方战役_03_诅咒之路.w3n", "roc", "undead", 2, "Undead"),
    GroupSpec("Orc", "入侵卡利姆多", "官方战役_04_入侵卡利姆多.w3n", "roc", "orc", 1, "Orc"),
    GroupSpec("NightElf", "永恒之井", "官方战役_05_永恒之井.w3n", "roc", "nightelf", 3, "NightElf"),
    GroupSpec("NightElfEx", "恐怖之潮", "官方战役_06_恐怖之潮.w3n", "tft", "nightelfx", 3, "NightElf"),
    GroupSpec("HumanEx", "血精灵的诅咒", "官方战役_07_血精灵的诅咒.w3n", "tft", "humanx", 0, "Human"),
    GroupSpec("UndeadEx", "诅咒者的遗赠", "官方战役_08_诅咒者的遗赠.w3n", "tft", "undeadx", 2, "Undead"),
    GroupSpec("OrcEx", "杜隆塔尔的建立", "官方战役_09_杜隆塔尔的建立.w3n", "tft", "orcx", 1, "Orc"),
)


WTS_RE = re.compile(
    r"^STRING\s+(\d+)[^\n]*\n(?:[ \t]*(?://[^\n]*)?\r?\n)*"
    r"[ \t]*\{[^\n]*\n(.*?)\r?\n?^\}",
    re.S | re.M,
)
COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)
INVALID_FILENAME = re.compile(r'[<>:"/\\|?*\x00-\x1f]')


class BuildError(RuntimeError):
    pass


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def parse_wts(data: bytes | None) -> dict[int, str]:
    if not data:
        return {}
    text = data.decode("utf-8-sig", "replace")
    return {int(m.group(1)): m.group(2).strip() for m in WTS_RE.finditer(text)}


def resolve_string(value, strings: dict[int, str]) -> str:
    if isinstance(value, bytes):
        value = value.decode("utf-8", "replace")
    if not isinstance(value, str):
        return str(value)
    match = re.fullmatch(r"\s*TRIGSTR_0*(\d+)\s*", value, re.I)
    return strings.get(int(match.group(1)), value) if match else value


def one_line(value: str) -> str:
    value = COLOR_TAG.sub("", value)
    value = value.replace("\r", "\n")
    parts = [part.strip() for part in value.split("\n") if part.strip()]
    return parts[0] if parts else ""


def map_description(path: Path) -> str:
    archive = W.MPQArchive(str(path))
    try:
        info = w3i.parse(archive.read_file("war3map.w3i") or b"")
        strings = parse_wts(archive.read_file("war3map.wts"))
        return one_line(resolve_string(info.get("description", ""), strings))
    finally:
        archive.close()


def safe_title(value: str, fallback: str) -> str:
    value = INVALID_FILENAME.sub("_", COLOR_TAG.sub("", value)).strip(" .")
    value = re.sub(r"\s+", " ", value)
    return value or fallback


def display_title(value: str, fallback: str) -> str:
    value = COLOR_TAG.sub("", value)
    value = re.sub(r"[\x00-\x1f]", " ", value).strip()
    value = re.sub(r"\s+", " ", value)
    return value or fallback


def read_manifest(source_root: Path) -> list[dict[str, str]]:
    manifest = source_root / "manifest.csv"
    if not manifest.is_file():
        raise BuildError("source manifest is missing: " + str(manifest))
    with manifest.open(encoding="utf-8-sig", newline="") as stream:
        rows = list(csv.DictReader(stream))
    required = ("源路径", "资料片", "分类", "输出相对路径", "SHA256")
    if not rows or any(key not in rows[0] for key in required):
        raise BuildError("source manifest has an unexpected format")
    return rows


def parse_campaign_metadata(data: bytes) -> dict[str, list[dict[str, str]]]:
    text = data.decode("utf-8-sig", "replace")
    sections: dict[str, list[dict[str, str]]] = {}
    for match in re.finditer(r"^\[([^\]]+)\]\s*$", text, re.M):
        start = match.end()
        next_match = re.search(r"^\[[^\]]+\]\s*$", text[start:], re.M)
        end = start + next_match.start() if next_match else len(text)
        block = text[start:end]
        missions = []
        for line in block.splitlines():
            mission = re.fullmatch(
                r'\s*Mission(\d+)\s*=\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*',
                line,
            )
            if mission:
                missions.append(
                    {
                        "index": mission.group(1),
                        "header": mission.group(2),
                        "name": mission.group(3),
                        "map": mission.group(4),
                    }
                )
        sections[match.group(1)] = missions
    return sections


def chapter_label(header: str) -> str:
    value = header.removeprefix("CAMP_").replace("_", " ").title()
    value = value.replace("Chapter ", "章节 ")
    value = value.replace("Interlude", "过场")
    value = value.replace("Secret Level", "隐藏关卡")
    value = value.replace("Finale", "终章")
    value = value.replace("Part ", "第 ")
    value = value.replace(" Part ", " 部分 ")
    value = value.replace("Act ", "幕 ")
    return value


def write_w3f(
    group: GroupSpec,
    buttons: list[dict[str, bytes | int]],
    maps: list[str],
) -> bytes:
    minimap = (
        "UI\\Widgets\\Glues\\Minimap-CustomCampaign-" + group.race_name
    ).encode("utf-8")
    model = {
        "version": 1,
        "campaign_version": 1,
        "editor_version": 6127,
        "name": group.title.encode("utf-8"),
        "difficulty": "普通".encode("utf-8"),
        "author": b"Blizzard Entertainment",
        "description": (
            "由 Warcraft III: Reforged 3.0.1.24371 官方 CASC 原始章节地图组装。"
        ).encode("utf-8"),
        "flags": 1,
        "background_number": 0,
        "background_path": b"",
        "minimap_path": minimap,
        "ambient_sound_number": 0,
        "ambient_sound_path": b"",
        "fog": [0, 0.0, 9000.0, 0.5, b"\xff\x80\x80\xff"],
        "race": group.race,
        "buttons": buttons,
        "maps": [{"unk": b"", "map": path.encode("utf-8")} for path in maps],
    }
    return campaign_info.write(model)


def pad_to(data: bytearray, alignment: int) -> None:
    padding = (-len(data)) % alignment
    if padding:
        data.extend(b"\0" * padding)


def build_mpq(files: list[tuple[str, bytes]], hm3w_title: str) -> bytes:
    names = [name for name, _data in files]
    if len(set(name.lower() for name in names)) != len(names):
        raise BuildError("duplicate internal MPQ names")
    if any(len(name) > 260 for name in names):
        raise BuildError("an internal MPQ name is too long")

    block_entries: list[tuple[int, int, int, int]] = []
    archive = bytearray(MPQ_HEADER_SIZE)
    for name, payload in files:
        pad_to(archive, 512)
        offset = len(archive)
        archive.extend(payload)
        block_entries.append((offset, len(payload), len(payload), MPQ_FILE_EXISTS))

    pad_to(archive, 512)
    block_table_pos = len(archive)
    block_table = b"".join(
        struct.pack("<IIII", *entry) for entry in block_entries
    )
    archive.extend(
        W._encrypt(
            block_table, W._hash_string("(block table)", W.MPQ_HASH_FILE_KEY)
        )
    )

    hash_size = 1
    while hash_size < len(files) * 2:
        hash_size <<= 1
    hash_table_pos = len(archive)
    hash_table = [(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF)] * hash_size
    for index, name in enumerate(names):
        hash_a = W._hash_string(name, W.MPQ_HASH_NAME_A)
        hash_b = W._hash_string(name, W.MPQ_HASH_NAME_B)
        slot = W._hash_string(name, W.MPQ_HASH_TABLE_OFFSET) % hash_size
        while hash_table[slot][0] != 0xFFFFFFFF:
            slot = (slot + 1) % hash_size
        hash_table[slot] = (hash_a, hash_b, 0, index)
    hash_table_data = b"".join(
        struct.pack("<IIII", *entry) for entry in hash_table
    )
    archive.extend(
        W._encrypt(
            hash_table_data, W._hash_string("(hash table)", W.MPQ_HASH_FILE_KEY)
        )
    )

    archive_size = len(archive)
    archive[0:MPQ_HEADER_SIZE] = struct.pack(
        "<4sIIHHIIII",
        MPQ_MAGIC,
        MPQ_HEADER_SIZE,
        archive_size,
        0,
        3,
        hash_table_pos,
        block_table_pos,
        hash_size,
        len(block_entries),
    )

    title = hm3w_title.encode("utf-8")
    header = bytearray(HM3W_SIZE)
    header[0:8] = b"HM3W" + b"\0" * 4
    header[8 : 8 + len(title)] = title
    tail_pos = 8 + len(title)
    if tail_pos + 9 > HM3W_SIZE:
        raise BuildError("HM3W title is too long")
    header[tail_pos : tail_pos + 9] = b"\0" + struct.pack("<ii", 1, 1)
    return bytes(header) + bytes(archive)


def validate_campaign(
    output: Path,
    group: GroupSpec,
    source_maps: dict[str, bytes],
    internal_maps: list[str],
    buttons: list[dict[str, bytes | int]],
) -> dict[str, object]:
    archive = W.MPQArchive(str(output))
    try:
        names = set(archive.files())
        w3f_data = archive.read_file("war3campaign.w3f")
        if not w3f_data:
            raise BuildError("generated campaign has no war3campaign.w3f")
        parsed = campaign_info.parse(w3f_data)
        if parsed["name"] != group.title.encode("utf-8"):
            raise BuildError("campaign title round-trip failed")
        if len(parsed["buttons"]) != len(buttons):
            raise BuildError("campaign button count mismatch")
        if len(parsed["maps"]) != len(internal_maps):
            raise BuildError("campaign map count mismatch")
        for internal in internal_maps:
            if internal not in names:
                raise BuildError("campaign map entry is missing: " + internal)
            data = archive.read_file(internal)
            if data != source_maps[internal]:
                raise BuildError("campaign map bytes changed: " + internal)
            nested = PyMPQArchive(io.BytesIO(data), listfile=False)
            if not nested.read_file("war3map.w3i"):
                raise BuildError("nested map has no war3map.w3i: " + internal)
    finally:
        archive.close()

    with output.open("rb") as stream:
        header = stream.read(HM3W_SIZE)
    if header[:4] != b"HM3W":
        raise BuildError("generated campaign has no HM3W header")
    end = header.find(b"\0", 8)
    if end < 0 or header[8:end].decode("utf-8", "replace") != group.title:
        raise BuildError("generated campaign HM3W title mismatch")

    return {
        "file": output.name,
        "section": group.section,
        "title": group.title,
        "maps": len(internal_maps),
        "buttons": len(buttons),
        "bytes": output.stat().st_size,
        "sha256": sha256_bytes(output.read_bytes()),
    }


def build(
    source_root: Path,
    output_dir: Path,
    game_root: Path,
    overwrite: bool = False,
) -> list[dict[str, object]]:
    rows = read_manifest(source_root)
    logical_maps: dict[str, Path] = {}
    for row in rows:
        logical = row["源路径"]
        if not logical.lower().startswith(SOURCE_PREFIX):
            raise BuildError("manifest contains a non-Reforged map: " + logical)
        path = source_root / row["输出相对路径"]
        if not path.is_file():
            raise BuildError("source map is missing: " + str(path))
        digest = sha256_bytes(path.read_bytes())
        if digest != row["SHA256"]:
            raise BuildError("source map hash mismatch: " + str(path))
        logical_maps[logical] = path
    if len(logical_maps) != 96:
        raise BuildError("expected 96 extracted official maps, found %d" % len(logical_maps))

    metadata_path = "war3.w3mod:ui\\campaigninforeforged.txt"
    metadata = parse_campaign_metadata(
        CascWC3(str(game_root)).read_data(metadata_path)
    )

    expected_counts = {
        "Tutorial": 5,
        "Human": 12,
        "Undead": 10,
        "Orc": 10,
        "NightElf": 8,
        "NightElfEx": 11,
        "HumanEx": 10,
        "UndeadEx": 13,
        "OrcEx": 17,
    }

    output_dir.mkdir(parents=True, exist_ok=True)
    results = []
    for group in GROUPS:
        branch_marker = "\\roc\\" if group.branch == "roc" else "\\tft\\"
        selected: list[tuple[str, Path]] = []
        for logical, path in logical_maps.items():
            lower = logical.lower()
            filename = path.name.lower()
            if branch_marker in lower and filename.startswith(group.prefix):
                selected.append((logical, path))
        selected.sort(key=lambda item: item[1].name.lower())
        if len(selected) != expected_counts[group.section]:
            raise BuildError(
                "%s: expected %d maps, found %d"
                % (group.section, expected_counts[group.section], len(selected))
            )

        source_maps: dict[str, bytes] = {}
        internal_maps: list[str] = []
        map_by_official_path: dict[str, str] = {}
        map_by_internal: dict[str, Path] = {}
        for logical, path in selected:
            relative = logical.split(SOURCE_PREFIX, 1)[1].replace("/", "\\")
            internal = (
                "Campaign\\Reforged\\"
                + group.branch.upper()
                + "\\"
                + Path(relative).name
            )
            internal_maps.append(internal)
            source_maps[internal] = path.read_bytes()
            map_by_official_path[internal.lower()] = internal
            map_by_internal[internal.lower()] = path

        buttons: list[dict[str, bytes | int]] = []
        for mission in metadata.get(group.section, []):
            official_map = mission["map"].replace("/", "\\")
            internal = map_by_official_path.get(official_map.lower())
            if internal is None:
                continue
            source_path = map_by_internal[internal.lower()]
            title = display_title(map_description(source_path), Path(internal).stem)
            buttons.append(
                {
                    "visible": 1,
                    "chapter": chapter_label(mission["header"]).encode("utf-8"),
                    "title": title.encode("utf-8"),
                    "map": internal.encode("utf-8"),
                }
            )

        if not buttons:
            raise BuildError(group.section + ": no official campaign buttons resolved")

        w3f = write_w3f(group, buttons, internal_maps)
        listfile = "\r\n".join(
            ["war3campaign.w3f", *internal_maps, "(listfile)"]
        ).encode("utf-8")
        files = [
            ("war3campaign.w3f", w3f),
            *[(name, source_maps[name]) for name in internal_maps],
            ("(listfile)", listfile),
        ]
        data = build_mpq(files, group.title)

        handle, temp_name = tempfile.mkstemp(
            prefix=".official-campaign-", suffix=".w3n", dir=output_dir
        )
        os.close(handle)
        partial = Path(temp_name)
        try:
            partial.write_bytes(data)
            result = validate_campaign(
                partial, group, source_maps, internal_maps, buttons
            )
            final = output_dir / group.filename
            if final.exists() and not overwrite:
                raise BuildError("output already exists: " + str(final))
            os.replace(partial, final)
            result["file"] = final.name
            results.append(result)
            print(
                "%s: %d maps, %d buttons, %d bytes"
                % (final.name, result["maps"], result["buttons"], result["bytes"]),
                flush=True,
            )
        finally:
            if partial.exists():
                partial.unlink()

    with (output_dir / "MANIFEST.csv").open(
        "w", encoding="utf-8-sig", newline=""
    ) as stream:
        writer = csv.DictWriter(stream, fieldnames=list(results[0]))
        writer.writeheader()
        writer.writerows(results)
    (output_dir / "README.txt").write_text(
        "\n".join(
            [
                "重制版官方战役 W3N",
                "",
                "来源：Warcraft III: Reforged 3.0.1.24371 官方 CASC",
                "逻辑路径：war3.w3mod:campaign\\reforged\\ROC 与 TFT",
                "未使用 Documents\\Warcraft III\\Campaigns 或任何自定义战役。",
                "",
                "共 9 个战役包、96 张官方地图、82 个战役菜单章节按钮。",
                "所有章节均按官方 campaigninforeforged.txt 排序；内部地图保持原始路径，",
                "因此地图脚本中的 Campaign\\Reforged\\ROC/TFT 下一关引用无需改写。",
                "章节地图在 .w3n 内使用未压缩 storage，供游戏按嵌套归档打开。",
                "",
                "静态验证已验证外层 MPQ、HM3W、war3campaign.w3f、每张嵌套地图的",
                "字节一致性及内部 war3map.w3i 可读性。运行测试仍需在游戏中确认。",
                "",
                "使用与测试：",
                "1. 将需要的 .w3n 复制到 C:\\Users\\Administrator\\Documents\\Warcraft III\\Campaigns。",
                "2. 手动启动游戏，在“战役 -> 自定义战役”中选择对应标题。",
                "3. 预期能看到各章节按钮并正常载入第一章；完成章节后应进入下一张官方地图。",
                "4. 若有问题，请回报 w3n 文件名、章节名、界面文字或 War3Log.txt 中的错误行。",
            ]
        )
        + "\n",
        encoding="utf-8",
    )
    return results


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Build official Reforged campaign maps into standalone .w3n archives."
    )
    parser.add_argument(
        "--source",
        type=Path,
        default=Path(r"C:\Users\Administrator\Desktop\重制版官方战役"),
    )
    parser.add_argument(
        "--game",
        type=Path,
        default=Path(r"H:\Games\Warcraft III"),
        help="Reforged installation containing Data and .build.info",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(r"C:\Users\Administrator\Desktop\重制版官方战役_W3N"),
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="replace existing generated campaigns in the output directory",
    )
    args = parser.parse_args(argv)
    results = build(
        args.source.resolve(),
        args.output.resolve(),
        args.game.resolve(),
        args.overwrite,
    )
    print("BUILT=%d" % len(results))
    print("MAPS=%d" % sum(int(item["maps"]) for item in results))
    print("BYTES=%d" % sum(int(item["bytes"]) for item in results))
    return 0


if __name__ == "__main__":
    sys.exit(main())
