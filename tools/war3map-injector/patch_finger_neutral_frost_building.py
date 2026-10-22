# -*- coding: utf-8 -*-
"""Allow Death Finger to hit neutral units and Frostmourne to freeze buildings."""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import war3mpq as W  # noqa: E402


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("map")
    parser.add_argument("output")
    args = parser.parse_args()

    archive = W.MPQArchive(os.path.abspath(args.map))
    try:
        data = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not data:
        raise SystemExit("map has no war3map.j")
    data = data.replace(b"\r\n", b"\n")

    data = replace_once(
        data,
        b"if not IsUnitEnemy(target, p) then\n",
        b"if not IsUnitEnemy(target, p) and GetPlayerId(GetOwningPlayer(target)) != PLAYER_NEUTRAL_PASSIVE and GetPlayerId(GetOwningPlayer(target)) != PLAYER_NEUTRAL_AGGRESSIVE then\n",
        "Death Finger neutral target guard")

    data = replace_once(
        data,
        b"if u == null or not IsUnitType(u, UNIT_TYPE_FLYING) then\n",
        b"if u == null or (not IsUnitType(u, UNIT_TYPE_FLYING) and not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then\n",
        "Frostmourne freeze eligibility")
    data = replace_once(
        data,
        b"if IsUnitType(target, UNIT_TYPE_FLYING) then\n",
        b"if IsUnitType(target, UNIT_TYPE_FLYING) or IsUnitType(target, UNIT_TYPE_STRUCTURE) then\n",
        "Frostmourne building freeze")

    output = os.path.abspath(args.output)
    os.makedirs(os.path.dirname(output), exist_ok=True)
    with open(output, "wb") as handle:
        handle.write(data)
    print("patched Death Finger neutral target and Frostmourne building freeze")
    print(output)


if __name__ == "__main__":
    sys.exit(main())
