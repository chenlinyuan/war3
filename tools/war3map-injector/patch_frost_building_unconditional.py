# -*- coding: utf-8 -*-
"""Freeze structures before the magic-immunity damage gate."""
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

    old = (
        b"        if target != caster and IsUnitAliveBJ(target) and FR_CanAffect(caster, target) then\n"
        b"            if not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then\n"
        b"                call UnitDamageTarget(caster, target, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\n"
        b"                if IsUnitType(target, UNIT_TYPE_FLYING) or IsUnitType(target, UNIT_TYPE_STRUCTURE) then\n"
        b"                    if IsUnitType(target, UNIT_TYPE_HERO) then\n"
        b"                        set freeze_duration = 3.0\n"
        b"                    else\n"
        b"                        set freeze_duration = 5.0\n"
        b"                    endif\n"
        b"                    call FR_FreezeAir(target, freeze_duration)\n"
        b"                endif\n"
        b"            endif\n"
        b"        endif\n"
    )
    new = (
        b"        if target != caster and IsUnitAliveBJ(target) and FR_CanAffect(caster, target) then\n"
        b"            if IsUnitType(target, UNIT_TYPE_STRUCTURE) then\n"
        b"                call FR_FreezeAir(target, 5.0)\n"
        b"            endif\n"
        b"            if not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then\n"
        b"                call UnitDamageTarget(caster, target, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\n"
        b"                if IsUnitType(target, UNIT_TYPE_FLYING) then\n"
        b"                    if IsUnitType(target, UNIT_TYPE_HERO) then\n"
        b"                        set freeze_duration = 3.0\n"
        b"                    else\n"
        b"                        set freeze_duration = 5.0\n"
        b"                    endif\n"
        b"                    call FR_FreezeAir(target, freeze_duration)\n"
        b"                endif\n"
        b"            endif\n"
        b"        endif\n"
    )
    data = replace_once(data, old, new, "structure freeze gate")

    output = os.path.abspath(args.output)
    os.makedirs(os.path.dirname(output), exist_ok=True)
    with open(output, "wb") as handle:
        handle.write(data)
    print("structures freeze outside magic-immunity gate")
    print(output)


if __name__ == "__main__":
    sys.exit(main())
