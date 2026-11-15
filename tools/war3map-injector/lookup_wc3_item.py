#!/usr/bin/env python3
r"""Look up a Warcraft III item and its item abilities from installed CASC data.

Examples:
  $env:WC3_GAME = "H:\Games\Warcraft III"
  python tools\war3map-injector\lookup_wc3_item.py 贪婪之赐
  python tools\war3map-injector\lookup_wc3_item.py ergg --json
  python tools\war3map-injector\lookup_wc3_item.py "Gift of Greed"

The reader uses balance=None so it sees the complete base-game table rather
than one of the reduced balance subsets. It never launches the game.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))

from doctor.data.casc_wc3 import CascWC3  # noqa: E402
from doctor.data.objects import GameBase  # noqa: E402


COLOR_CODE = re.compile(r"\|c[0-9a-fA-F]{8}|\|r")
ITEM_PRINT_FIELDS = (
    "itemid",
    "comment",
    "scriptname",
    "class",
    "level",
    "abillist",
    "cooldownid",
    "usable",
    "droppable",
    "pawnable",
    "goldcost",
    "lumbercost",
    "tag",
    "name",
    "tip",
    "description",
    "ubertip",
)
ABILITY_PRINT_FIELDS = (
    "alias",
    "code",
    "comments",
    "name",
    "levels",
    "targs1",
    "cast1",
    "dur1",
    "herodur1",
    "cool1",
    "cost1",
    "area1",
    "rng1",
)


def plain_text(value: object) -> str:
    return COLOR_CODE.sub("", str(value or ""))


def valid_game_root(path: Path) -> bool:
    return (path / ".build.info").is_file() and (path / "Data" / "data").is_dir()


def normalize_game_root(path: Path) -> Path | None:
    path = path.expanduser().resolve()
    candidates = (path, path.parent)
    for candidate in candidates:
        if valid_game_root(candidate):
            return candidate
    return None


def find_game_root(explicit: str | None) -> Path:
    candidates = []
    if explicit:
        candidates.append(Path(explicit))
    if os.environ.get("WC3_GAME"):
        candidates.append(Path(os.environ["WC3_GAME"]))
    candidates.extend(
        (
            Path(r"H:\Games\Warcraft III"),
            Path(r"H:\Games\Warcraft III Reforged"),
            Path(r"C:\Program Files (x86)\Warcraft III"),
            Path(r"C:\Program Files\Warcraft III"),
        )
    )
    for candidate in candidates:
        found = normalize_game_root(candidate)
        if found is not None:
            return found
    raise SystemExit(
        "找不到 War3 CASC 根目录。请传 --game 或设置 WC3_GAME；"
        "根目录应同时包含 .build.info 和 Data\\data。"
    )


def item_blob(row: dict[str, object]) -> str:
    keys = (
        "itemid",
        "comment",
        "scriptname",
        "name",
        "tip",
        "description",
        "ubertip",
    )
    return "\n".join(plain_text(row.get(key, "")) for key in keys).casefold()


def find_items(table: dict[str, dict[str, object]], query: str) -> list[str]:
    needle = plain_text(query).strip()
    exact = [ident for ident in table if ident.casefold() == needle.casefold()]
    if exact:
        return exact
    folded = needle.casefold()
    return sorted(ident for ident, row in table.items() if folded in item_blob(row))


def populated_ability_fields(row: dict[str, object]) -> dict[str, object]:
    out = {}
    try:
        levels = max(1, int(str(row.get("levels", "1"))))
    except ValueError:
        levels = 1
    field_keys = list(ABILITY_PRINT_FIELDS)
    for level in range(1, levels + 1):
        field_keys.extend(
            "%s%d" % (prefix, level)
            for prefix in (
                "dataa",
                "datab",
                "datac",
                "datad",
                "datae",
                "dataf",
                "datag",
                "datah",
                "datai",
            )
        )
    for key in field_keys:
        value = row.get(key)
        if value not in (None, "", "-"):
            out[key] = value
    return out


def build_result(
    game_root: Path,
    locale: str,
    query: str,
) -> tuple[dict[str, object], list[str]]:
    casc = CascWC3(str(game_root))
    try:
        game = GameBase(casc=casc, balance=None, locale=locale)
        items = game.table("item")
        matches = find_items(items, query)
        abilities = game.table("ability")
        result_items = {}
        errors = []
        for ident in matches:
            row = dict(items[ident])
            ability_rows = {}
            for ability_id in str(row.get("abillist", "")).split(","):
                ability_id = ability_id.strip()
                if not ability_id:
                    continue
                ability_row = abilities.get(ability_id)
                if ability_row is None:
                    errors.append("物品 %s 引用了不存在的技能 %s" % (ident, ability_id))
                    continue
                ability_rows[ability_id] = {
                    "fields": dict(ability_row),
                    "populated": populated_ability_fields(ability_row),
                }
            result_items[ident] = {
                "fields": row,
                "abilities": ability_rows,
            }
        return (
            {
                "game_root": str(game_root),
                "game_version": getattr(casc, "version_num", "?"),
                "locale": locale,
                "query": query,
                "items": result_items,
                "errors": errors,
            },
            matches,
        )
    finally:
        casc.on_close()


def print_human(result: dict[str, object]) -> None:
    print(
        "游戏版本: %s   CASC: %s   语言: %s"
        % (result["game_version"], result["game_root"], result["locale"])
    )
    items = result["items"]
    if not items:
        print("未找到匹配物品。")
        return
    for ident, item in items.items():
        fields = item["fields"]
        print("\n=== %s | %s ===" % (ident, plain_text(fields.get("name"))))
        for key in ITEM_PRINT_FIELDS:
            value = fields.get(key)
            if value not in (None, "", "-"):
                print("%-12s %s" % (key + ":", value))
        for ability_id, ability in item["abilities"].items():
            print("\n  [技能 %s]" % ability_id)
            for key, value in ability["populated"].items():
                print("  %-12s %s" % (key + ":", value))
    if result["errors"]:
        print("\n异常:")
        for error in result["errors"]:
            print("-", error)


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    parser = argparse.ArgumentParser(
        description="按名称或 ID 查询 War3 2.0/3.0 内建物品及其技能。"
    )
    parser.add_argument("query", help="中文名、英文名、注释、脚本名或四字符 ID")
    parser.add_argument("--game", help="War3 根目录（包含 .build.info 和 Data）")
    parser.add_argument("--locale", default="zhcn", help="本地化语言，默认 zhcn")
    parser.add_argument("--json", action="store_true", help="输出完整 JSON")
    args = parser.parse_args()

    game_root = find_game_root(args.game)
    result, _matches = build_result(game_root, args.locale, args.query)
    if args.json:
        json.dump(result, sys.stdout, ensure_ascii=False, indent=2)
        print()
    else:
        print_human(result)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
