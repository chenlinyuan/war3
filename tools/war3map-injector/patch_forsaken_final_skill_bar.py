# -*- coding: utf-8 -*-
"""Keep wing spell books hidden after the final chapter changes Garek's skin."""

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402


SOURCE_DIR = (
    ROOT / "maps" / "port" / "forsaken_undead" / "_wingteleportfix"
)
OUTPUT_DIR = (
    ROOT / "maps" / "port" / "forsaken_undead" / "_finalfix"
)
OUTPUT_NAME = "alas被遗忘的王国-终章与进度修复-v1.w3n"

OLD_BOOK_BLOCK = """      if ((wg_wingBook[i] ~= 0) and (GetUnitAbilityLevel(u, wg_wingBook[i]) == 0)) then
        UnitAddAbility(u, wg_wingBook[i])
        UnitMakeAbilityPermanent(u, true, wg_wingBook[i])
        SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook[i], false)
      end
      if (wg_wingBook2[i] ~= 0) then
        if (GetUnitAbilityLevel(u, wg_wingBook2[i]) == 0) then
          UnitAddAbility(u, wg_wingBook2[i])
          UnitMakeAbilityPermanent(u, true, wg_wingBook2[i])
          SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook2[i], false)
        end
      end"""

NEW_BOOK_BLOCK = """      if (wg_wingBook[i] ~= 0) then
        if (GetUnitAbilityLevel(u, wg_wingBook[i]) == 0) then
          UnitAddAbility(u, wg_wingBook[i])
          UnitMakeAbilityPermanent(u, true, wg_wingBook[i])
        end
        -- BlzSetUnitSkin resets availability; re-hide every sync.
        SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook[i], false)
      end
      if (wg_wingBook2[i] ~= 0) then
        if (GetUnitAbilityLevel(u, wg_wingBook2[i]) == 0) then
          UnitAddAbility(u, wg_wingBook2[i])
          UnitMakeAbilityPermanent(u, true, wg_wingBook2[i])
        end
        SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook2[i], false)
      end"""

OLD_TRANSFORM = """  BlzSetUnitSkin(udg_TheHero, FourCC("Ugr3"))
  SetUnitOwner(udg_TheHero, Player(PLAYER_NEUTRAL_PASSIVE), true)
  SetUnitOwner(udg_TheHero, udg_Player14_ThePlayer, true)
end"""

NEW_TRANSFORM = """  BlzSetUnitSkin(udg_TheHero, FourCC("Ugr3"))
  SetUnitOwner(udg_TheHero, Player(PLAYER_NEUTRAL_PASSIVE), true)
  SetUnitOwner(udg_TheHero, udg_Player14_ThePlayer, true)
  WG_SyncUnit(udg_TheHero)
end"""


def patch_lua(data, final_chapter=False):
    text = data.decode("utf-8")
    normalized = text.replace("\r\n", "\n")
    if normalized.count(OLD_BOOK_BLOCK) != 1:
        raise RuntimeError("expected one old wing-book block")
    updated = normalized.replace(OLD_BOOK_BLOCK, NEW_BOOK_BLOCK)
    if final_chapter:
        if updated.count(OLD_TRANSFORM) != 1:
            raise RuntimeError("expected one final Garek transform block")
        updated = updated.replace(OLD_TRANSFORM, NEW_TRANSFORM)
    if updated.count("WG_SyncUnit(udg_TheHero)") > 1:
        raise RuntimeError("final sync call was inserted more than once")
    if updated.count("-- BlzSetUnitSkin resets availability; re-hide every sync.") != 1:
        raise RuntimeError("wing-book visibility patch is missing")
    return updated.encode("utf-8")


def assert_lua(data, final_chapter=False):
    text = data.decode("utf-8")
    if OLD_BOOK_BLOCK in text.replace("\r\n", "\n"):
        raise RuntimeError("old book visibility logic remains")
    if text.count("function WG_SyncUnit(u)") != 1:
        raise RuntimeError("WG_SyncUnit definition count is not one")
    if text.count("SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook[i], false)") != 1:
        raise RuntimeError("main wing book is not re-hidden exactly once")
    if text.count("SetPlayerAbilityAvailable(GetOwningPlayer(u), wg_wingBook2[i], false)") != 1:
        raise RuntimeError("secondary wing book is not re-hidden exactly once")
    if final_chapter and text.count("WG_SyncUnit(udg_TheHero)") != 1:
        raise RuntimeError("final Garek sync call count is not one")


def main():
    source_campaign = next(SOURCE_DIR.glob("*.w3n"))
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    raw_dir = OUTPUT_DIR / "_source_maps"
    patched_dir = OUTPUT_DIR / "maps"
    raw_dir.mkdir(exist_ok=True)
    patched_dir.mkdir(exist_ok=True)

    campaign = war3mpq.MPQArchive(str(source_campaign))
    try:
        names = sorted(
            name for name in campaign.files()
            if name.lower().endswith((".w3x", ".w3m"))
        )
        data = {name: campaign.read_file(name) for name in names}
    finally:
        campaign.close()
    if len(names) != 15:
        raise RuntimeError("expected 15 chapters, found %d" % len(names))

    patches = []
    for name in names:
        source_map = raw_dir / name
        target_map = patched_dir / name
        source_map.write_bytes(data[name])
        archive = war3mpq.MPQArchive(str(source_map))
        try:
            lua = archive.read_file("war3map.lua")
        finally:
            archive.close()
        if not lua:
            raise RuntimeError("missing war3map.lua: %s" % name)
        updated = patch_lua(lua, final_chapter=(name == "UndeadRE03b.w3x"))
        assert_lua(updated, final_chapter=(name == "UndeadRE03b.w3x"))
        mpq_patch.patch(
            str(source_map),
            [("war3map.lua", updated)],
            out_path=str(target_map),
            backup=False,
        )
        check = war3mpq.MPQArchive(str(target_map))
        try:
            read_back = check.read_file("war3map.lua")
        finally:
            check.close()
        if read_back != updated:
            raise RuntimeError("map read-back mismatch: %s" % name)
        assert_lua(read_back, final_chapter=(name == "UndeadRE03b.w3x"))
        patches.append((name, target_map.read_bytes()))
        print("patched", name)

    output = OUTPUT_DIR / OUTPUT_NAME
    mpq_patch.patch(
        str(source_campaign),
        patches,
        out_path=str(output),
        backup=False,
        store=names,
    )
    check = war3mpq.MPQArchive(str(output))
    try:
        for name, expected in patches:
            actual = check.read_file(name)
            if actual != expected:
                raise RuntimeError("campaign read-back mismatch: %s" % name)
    finally:
        check.close()
    print("verified", output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
