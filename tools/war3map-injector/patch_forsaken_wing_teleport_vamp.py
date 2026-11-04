# -*- coding: utf-8 -*-
"""Patch Seraph mass teleport and the Fallen wing's item vampiric aura.

The campaign keeps the wing object data inside every chapter map. This tool
patches those chapter archives from the latest deployed campaign, then writes a
new campaign without touching saves.
"""

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))
sys.path.insert(0, str(INJECTOR))

from doctor.data.objects import read_objects_bytes, write_objects_bytes  # noqa: E402
import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402


DEFAULT_SOURCE_DIR = ROOT / "maps" / "port" / "forsaken_undead" / "_tunnelfix_v3"
OUTPUT_DIR = ROOT / "maps" / "port" / "forsaken_undead" / "_wingteleportfix"
OUTPUT_NAME = "alas被遗忘的王国-翼传送吸血修复-v1.w3n"
TELEPORT_CD = 2.0
VAMP_ABILITY = "W071"
VAMP_ITEM_BASE = "AIav"


def object_map(objects):
    return {new: (table, old, mods) for table, old, new, mods in objects}


def set_mod(mods, field_id, value, value_type=2, level=1, column=0):
    for i, item in enumerate(mods):
        if item[0] == field_id:
            mods[i] = (field_id, value_type, level, column, value)
            return
    mods.append((field_id, value_type, level, column, value))


def remove_mods(mods, field_id):
    mods[:] = [item for item in mods if item[0] != field_id]


def replace_mod_text(mods, field_id, old, new):
    found = False
    for i, item in enumerate(mods):
        if item[0] != field_id:
            continue
        text = bytes(item[4]).decode("utf-8")
        if old not in text:
            raise RuntimeError("%s does not contain %r" % (field_id, old))
        mods[i] = (item[0], item[1], item[2], item[3],
                   text.replace(old, new).encode("utf-8"))
        found = True
    if not found:
        raise RuntimeError("missing text field %s" % field_id)


def patch_w3a(data):
    version, objects, pos = read_objects_bytes(data, True, with_end=False)
    if pos != len(data):
        raise RuntimeError("war3map.w3a has trailing data")

    by_id = object_map(objects)
    if VAMP_ABILITY not in by_id:
        raise RuntimeError("missing ability %s" % VAMP_ABILITY)
    if "W023" not in by_id:
        raise RuntimeError("missing teleport ability W023")
    if "W080" not in by_id:
        raise RuntimeError("missing Fallen spell book W080")

    for i, (table, old, new, mods) in enumerate(objects):
        if new != VAMP_ABILITY:
            continue
        # Scourge Bone Chimes (sbch) uses the native item aura AIav directly.
        # Inheriting its canonical targets avoids the non-native "allies"
        # token that was present on the old AUav-based book aura.
        objects[i] = (table, VAMP_ITEM_BASE, new, mods)
        remove_mods(mods, "atar")
        set_mod(mods, "aite", 1, value_type=0, level=0, column=0)
        set_mod(mods, "aher", 0, value_type=0, level=0, column=0)

    teleport = by_id["W023"][2]
    set_mod(teleport, "acdn", TELEPORT_CD)
    set_mod(teleport, "acas", 0.0)
    replace_mod_text(teleport, "aub1", "冷却 60 秒", "冷却 2 秒")

    book = by_id["W080"][2]
    book_ids = None
    for item in book:
        if item[0] == "spb1":
            book_ids = bytes(item[4]).decode("ascii").split(",")
            break
    if book_ids is None:
        raise RuntimeError("W080 has no spell list")
    if VAMP_ABILITY not in book_ids:
        raise RuntimeError("W080 does not contain %s" % VAMP_ABILITY)
    book_ids.remove(VAMP_ABILITY)
    set_mod(book, "spb1", ",".join(book_ids).encode("ascii"),
            value_type=3, level=1, column=1)

    return write_objects_bytes(version, objects, True)


def patch_w3t(data):
    version, objects, pos = read_objects_bytes(data, False, with_end=False)
    if pos != len(data):
        raise RuntimeError("war3map.w3t has trailing data")

    by_id = object_map(objects)
    if "I100" not in by_id:
        raise RuntimeError("missing Fallen wing item I100")
    if "I101" not in by_id:
        raise RuntimeError("missing Seraph wing item I101")

    fallen = by_id["I100"][2]
    ability_ids = None
    for item in fallen:
        if item[0] == "iabi":
            ability_ids = bytes(item[4]).decode("ascii").split(",")
            break
    if ability_ids is None:
        raise RuntimeError("I100 has no item ability list")
    if VAMP_ABILITY not in ability_ids:
        if len(ability_ids) >= 4:
            raise RuntimeError("I100 already has four item abilities")
        ability_ids.append(VAMP_ABILITY)
    set_mod(fallen, "iabi", ",".join(ability_ids).encode("ascii"),
            value_type=3, level=0, column=0)

    seraph = by_id["I101"][2]
    replace_mod_text(seraph, "utub", "冷却 60 秒", "冷却 2 秒")
    replace_mod_text(seraph, "ides", "冷却 60 秒", "冷却 2 秒")
    return write_objects_bytes(version, objects, False)


def assert_map_objects(archive_path):
    archive = war3mpq.MPQArchive(str(archive_path))
    try:
        w3a = archive.read_file("war3map.w3a")
        w3t = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if not w3a or not w3t:
        raise RuntimeError("missing object data in %s" % archive_path)

    _, abilities, _ = read_objects_bytes(w3a, True, with_end=False)
    _, items, _ = read_objects_bytes(w3t, False, with_end=False)
    by_abil = object_map(abilities)
    by_item = object_map(items)

    vamp_table, vamp_old, vamp_mods = by_abil[VAMP_ABILITY]
    if vamp_old != VAMP_ITEM_BASE:
        raise RuntimeError("%s base is %s" % (VAMP_ABILITY, vamp_old))
    vamp_values = {mod[0]: mod[4] for mod in vamp_mods}
    if vamp_values.get("aite") != 1:
        raise RuntimeError("%s is not marked as an item ability" % VAMP_ABILITY)
    if any(mod[0] == "atar" for mod in vamp_mods):
        raise RuntimeError("%s still overrides native AIav targets" % VAMP_ABILITY)
    if abs(vamp_values["Uav1"] - 0.4) > 0.0001:
        raise RuntimeError("%s life steal is not 40%%" % VAMP_ABILITY)
    if abs(vamp_values["aare"] - 700.0) > 0.0001:
        raise RuntimeError("%s radius is not 700" % VAMP_ABILITY)

    tele_values = {mod[0]: mod[4] for mod in by_abil["W023"][2]}
    if abs(tele_values["acdn"] - TELEPORT_CD) > 0.0001:
        raise RuntimeError("W023 cooldown is wrong")
    if abs(tele_values["acas"]) > 0.0001:
        raise RuntimeError("W023 cast time is not zero")
    if "冷却 60 秒" in bytes(tele_values["aub1"]).decode("utf-8"):
        raise RuntimeError("W023 tooltip still says 60 seconds")

    book_values = {mod[0]: mod[4] for mod in by_abil["W080"][2]}
    if VAMP_ABILITY in bytes(book_values["spb1"]).decode("ascii").split(","):
        raise RuntimeError("W080 still contains %s" % VAMP_ABILITY)

    item_slots = bytes(
        {mod[0]: mod[4] for mod in by_item["I100"][2]}["iabi"]
    ).decode("ascii").split(",")
    if item_slots != ["W022", "W002", "W000", VAMP_ABILITY]:
        raise RuntimeError("I100 item ability layout is %r" % item_slots)
    seraph = {mod[0]: mod[4] for mod in by_item["I101"][2]}
    for field_id in ("utub", "ides"):
        if "冷却 60 秒" in bytes(seraph[field_id]).decode("utf-8"):
            raise RuntimeError("I101 %s still says 60 seconds" % field_id)


def patch_inner_map(source_path, target_path):
    archive = war3mpq.MPQArchive(str(source_path))
    try:
        w3a = archive.read_file("war3map.w3a")
        w3t = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if not w3a or not w3t:
        raise RuntimeError("chapter lacks w3a/w3t: %s" % source_path)
    patches = [
        ("war3map.w3a", patch_w3a(w3a)),
        ("war3map.w3t", patch_w3t(w3t)),
    ]
    mpq_patch.patch(
        str(source_path), patches, out_path=str(target_path), backup=False
    )
    assert_map_objects(target_path)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source-dir", type=Path, default=DEFAULT_SOURCE_DIR)
    parser.add_argument("--out-dir", type=Path, default=OUTPUT_DIR)
    args = parser.parse_args()

    source_campaign = next(args.source_dir.glob("*.w3n"))
    args.out_dir.mkdir(parents=True, exist_ok=True)
    raw_maps = args.out_dir / "_source_maps"
    patched_maps = args.out_dir / "maps"
    raw_maps.mkdir(exist_ok=True)
    patched_maps.mkdir(exist_ok=True)

    campaign = war3mpq.MPQArchive(str(source_campaign))
    try:
        map_names = sorted(
            name for name in campaign.files()
            if name.lower().endswith((".w3x", ".w3m"))
        )
        map_data = {name: campaign.read_file(name) for name in map_names}
    finally:
        campaign.close()
    if len(map_names) != 15:
        raise RuntimeError("expected 15 campaign chapters, found %d" % len(map_names))

    campaign_patches = []
    for name in map_names:
        source_path = raw_maps / name
        target_path = patched_maps / name
        source_path.write_bytes(map_data[name])
        patch_inner_map(source_path, target_path)
        patched_data = target_path.read_bytes()
        assert_map_objects(target_path)
        campaign_patches.append((name, patched_data))
        print("verified", name)

    output_campaign = args.out_dir / OUTPUT_NAME
    mpq_patch.patch(
        str(source_campaign),
        campaign_patches,
        out_path=str(output_campaign),
        backup=False,
        store=map_names,
    )

    check = war3mpq.MPQArchive(str(output_campaign))
    try:
        for name, expected in campaign_patches:
            actual = check.read_file(name)
            if actual != expected:
                raise RuntimeError("campaign read-back mismatch: %s" % name)
    finally:
        check.close()

    for name in map_names:
        assert_map_objects(patched_maps / name)
    print("campaign verified:", output_campaign)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
