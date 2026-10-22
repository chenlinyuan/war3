# -*- coding: utf-8 -*-
"""Patch one item's iico in a map's internal war3map.w3t."""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("map")
    parser.add_argument("outdir")
    parser.add_argument("item_id")
    parser.add_argument("icon")
    args = parser.parse_args()

    archive = W.MPQArchive(os.path.abspath(args.map))
    try:
        data = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if not data:
        raise SystemExit("map has no war3map.w3t")

    version, original, custom = O.read_bytes(data, "w3t")
    for entry in custom:
        if entry["new"] == args.item_id:
            for i, mod in enumerate(entry["mods"]):
                if mod[0] == "iico":
                    entry["mods"][i] = ["iico", O.T_STRING, 0, 0, args.icon]
                    break
            else:
                entry["mods"].append(["iico", O.T_STRING, 0, 0, args.icon])
            break
    else:
        raise SystemExit("item not found: %s" % args.item_id)

    outdir = os.path.abspath(args.outdir)
    os.makedirs(outdir, exist_ok=True)
    out = os.path.join(outdir, "war3map.w3t")
    O.write_file(out, version, original, custom)
    print("patched %s -> %s" % (args.item_id, args.icon))
    print(out)


if __name__ == "__main__":
    sys.exit(main())
