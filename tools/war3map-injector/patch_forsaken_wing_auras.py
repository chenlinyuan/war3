"""Make the wing Vampiric Aura explicitly target nearby friendly/allied units."""

from pathlib import Path

from doctor.data.objects import read_objects_bytes, write_objects_bytes
import mpq_patch
import war3mpq


ROOT = Path(__file__).resolve().parents[2]
ITEMFIX = ROOT / "maps" / "port" / "forsaken_undead" / "_itemfix"
SPIDER03 = ROOT / "maps" / "port" / "forsaken_undead" / "_spiderfix" / "UndeadRE01_03.w3x"
OUT = ROOT / "maps" / "port" / "forsaken_undead" / "_aurafix"

AURA_IDS = {
    "W071",  # Vampiric Aura
}
TARGETS = b"air,ground,organic,vuln,invu,friend,allies,neutral,self"


def patch_w3a(data):
    version, objects, _pos = read_objects_bytes(data, True, with_end=False)
    seen = set()
    before = {}
    for table, old, new, mods in objects:
        before[(table, old, new)] = tuple(
            (m[0], m[1], m[2], m[3], m[4]) for m in mods
        )
        if new not in AURA_IDS:
            continue
        seen.add(new)
        found = False
        for i, item in enumerate(mods):
            if item[0] == "atar":
                mods[i] = ("atar", 3, 1, 0, TARGETS)
                found = True
                break
        if not found:
            mods.append(("atar", 3, 1, 0, TARGETS))
    missing = AURA_IDS - seen
    if missing:
        raise RuntimeError("missing aura abilities: %r" % sorted(missing))
    updated = write_objects_bytes(version, objects, True)

    version2, objects2, _pos2 = read_objects_bytes(updated, True, with_end=False)
    if version2 != version:
        raise RuntimeError("object-data version changed")
    for table, old, new, mods in objects2:
        if new in AURA_IDS:
            values = [m[4] for m in mods if m[0] == "atar"]
            if values != [TARGETS]:
                raise RuntimeError("%s did not get the shared aura targets" % new)
        original = before[(table, old, new)]
        current = tuple(
            (m[0], m[1], m[2], m[3], m[4]) for m in mods
            if not (new in AURA_IDS and m[0] == "atar")
        )
        original_other = tuple(x for x in original if not (new in AURA_IDS and x[0] == "atar"))
        if current != original_other:
            raise RuntimeError("non-aura field changed in %s" % new.decode("latin-1"))
    return updated


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    sources = sorted(ITEMFIX.glob("*.w3x")) + [SPIDER03]
    for source in sources:
        archive = war3mpq.MPQArchive(str(source))
        try:
            data = archive.read_file("war3map.w3a")
        finally:
            archive.close()
        if not data:
            raise RuntimeError("war3map.w3a not found: %s" % source)
        updated = patch_w3a(data)
        target = OUT / source.name
        mpq_patch.patch(str(source), [("war3map.w3a", updated)],
                        out_path=str(target), backup=False)
        check = war3mpq.MPQArchive(str(target))
        try:
            result = check.read_file("war3map.w3a")
        finally:
            check.close()
        if result != updated:
            raise RuntimeError("read-back mismatch: %s" % target)
        print("patched", target.name, len(data), "->", len(updated))
    print("total", len(sources))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
