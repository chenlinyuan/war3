#!/usr/bin/env python3
"""Sync Frostmourne in the Reforged LT map to the knowledge-base version."""

from pathlib import Path
import argparse
import struct
import sys
import tempfile


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))

import mpq_patch  # noqa: E402
import objparse  # noqa: E402
import gen_frostmourne_lt as FROST_OBJECT  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import war3mpq  # noqa: E402


DEFAULT_MAP = (
    ROOT / "maps" / "port" / "lost_temple_30" / "LostTempleLV_BladeMaster30.w3x"
)
SOURCE_ABILITY = ROOT / "heroes" / "frostmourne" / "ability.w3a"
SOURCE_ITEM = ROOT / "heroes" / "frostmourne" / "item.w3t"
ASSET_DIR = ROOT / "heroes" / "frostmourne" / "assets"
FROST_ASSETS = {
    r"war3campImported\Frostmourne.mdx": "Frostmourne.mdx",
    "Frostmourne10.blp": "Frostmourne10.blp",
    "Frostmourne100.blp": "Frostmourne100.blp",
    r"war3campImported\IceStompRaised.mdx": "IceStompRaised.mdx",
    r"war3campImported\Rune-Blue-Aura_Raised20.mdx": "Rune-Blue-Aura_Raised20.mdx",
}
def find_entry(entries, entry_id):
    found = [entry for entry in entries if entry["new"] == entry_id]
    if len(found) != 1:
        raise RuntimeError("expected one %s entry, found %d" % (entry_id, len(found)))
    return found[0]


def upsert(entries, replacement):
    entries[:] = [entry for entry in entries if entry["new"] != replacement["new"]]
    entries.append(replacement)


def set_mod(entry, field_id, value):
    for mod in entry["mods"]:
        if mod[0] == field_id:
            mod[4] = value
            return
    raise RuntimeError("%s.%s is missing" % (entry["new"], field_id))


def patch_imports(data, paths):
    out = bytearray(data)
    version, count = struct.unpack_from("<ii", out, 0)
    if version not in (1, 2):
        raise RuntimeError("unexpected war3map.imp version %d" % version)
    added = []
    for path in paths:
        encoded = path.encode("ascii")
        if encoded + b"\0" not in out:
            added.append(encoded)
    struct.pack_into("<i", out, 4, count + len(added))
    for encoded in added:
        out += b"\x0d" + encoded + b"\0"
    return bytes(out)


def patch_objects(map_path):
    source_ability = objparse.read_file(str(SOURCE_ABILITY))[2]
    source_item = objparse.read_file(str(SOURCE_ITEM))[2]
    source_active = FROST_OBJECT.spell_entry()
    source_item_entry = find_entry(source_item, "I105")
    set_mod(source_item_entry, "utub", ITEM.FROSTMOURNE_ITEM_TOOLTIP)
    set_mod(source_item_entry, "ides", ITEM.FROSTMOURNE_ITEM_DESCRIPTION)
    archive = war3mpq.MPQArchive(str(map_path))
    try:
        ability_data = archive.read_file("war3map.w3a")
        item_data = archive.read_file("war3map.w3t")
        imp_data = archive.read_file("war3map.imp")
    finally:
        archive.close()
    if not ability_data or not item_data or not imp_data:
        raise RuntimeError("map is missing Frostmourne object data or war3map.imp")

    ability_version, ability_original, abilities = objparse.read_bytes(
        ability_data, "w3a"
    )
    item_version, item_original, items = objparse.read_bytes(item_data, "w3t")

    for ability_id in ("A105", "A106", "A108", "A109", "A170"):
        upsert(abilities, find_entry(source_ability, ability_id))

    current_item = find_entry(items, "I105")
    current_icon = {mod[0]: mod[4] for mod in current_item["mods"]}["iico"]
    replacement_item = find_entry(source_item, "I105")
    set_mod(replacement_item, "iico", current_icon)
    upsert(items, replacement_item)

    patched = {
        "war3map.w3a": objparse.build_bytes(
            ability_version, ability_original, abilities, "w3a"
        ),
        "war3map.w3t": objparse.build_bytes(
            item_version, item_original, items, "w3t"
        ),
        "war3map.imp": patch_imports(imp_data, FROST_ASSETS),
    }
    for internal, filename in FROST_ASSETS.items():
        local_file = ASSET_DIR / filename
        if not local_file.is_file():
            raise RuntimeError("missing Frostmourne asset: " + str(local_file))
        patched[internal] = local_file.read_bytes()
    return patched


def replace_function(data, name, replacement):
    marker = ("function %s takes" % name).encode("ascii")
    start = data.find(marker)
    if start < 0 or data.find(marker, start + 1) >= 0:
        raise RuntimeError("expected one %s function" % name)
    end = data.find(b"\nendfunction", start)
    if end < 0:
        raise RuntimeError("%s has no endfunction" % name)
    end += len(b"\nendfunction")
    return data[:start] + replacement.encode("utf-8") + data[end:]


def remove_function(data, name):
    marker = ("function %s takes" % name).encode("ascii")
    start = data.find(marker)
    if start < 0:
        return data
    if data.find(marker, start + 1) >= 0:
        raise RuntimeError("expected one %s function" % name)
    end = data.find(b"\nendfunction", start)
    if end < 0:
        raise RuntimeError("%s has no endfunction" % name)
    end += len(b"\nendfunction")
    return data[:start] + data[end + 1:]


def patch_script(data):
    data = data.replace(b"\r\n", b"\n").replace(b"\r", b"\n")
    old_globals = """real IT_FROST_RADIUS = 550.0
real IT_FROST_STAT_MULT = 4.0
real IT_FROST_SLOW_FACTOR = 0.35
real IT_FROST_SLOW_DURATION = 4.0
real IT_FROST_HERO_DURATION = 2.0

trigger IT_DeathTrigger = null
trigger IT_SpellTrigger = null
trigger IT_AttackTrigger = null
group IT_SlowGroup = null
hashtable IT_SlowTable = null
timer IT_SlowTimer = null
timer IT_SyncTimer = null
boolean IT_Inited = false""".encode("ascii")
    new_globals = """real IT_FROST_RADIUS = 550.0
real IT_FROST_STAT_MULT = 4.0
real IT_FROST_NOVA_CHANCE = 0.30

trigger IT_DeathTrigger = null
trigger IT_SpellTrigger = null
trigger IT_AttackTrigger = null
hashtable IT_FreezeTable = null
hashtable IT_FreezeTimerTable = null
timer IT_SyncTimer = null
boolean IT_Inited = false""".encode("ascii")
    if data.count(old_globals) == 1:
        data = data.replace(old_globals, new_globals, 1)
    elif data.count(new_globals) != 1:
        raise RuntimeError("unexpected Frostmourne globals")
    if b"integer IT_GROUND_MAX" not in data:
        ground_globals = b"""integer IT_GROUND_MAX = 16
item array IT_GROUND_ITEMS
integer array IT_GROUND_KEYS
effect array IT_GROUND_EFFECTS
real array IT_GROUND_X
real array IT_GROUND_Y
integer IT_GROUND_COUNT = 0
rect IT_GROUND_WORLD = null
hashtable IT_GROUND_TABLE = null
"""
        marker = b"boolean IT_Inited = false\n"
        if data.count(marker) != 1:
            raise RuntimeError("cannot place Frostmourne ground globals")
        data = data.replace(marker, marker + ground_globals, 1)

    freeze_functions = r"""function IT_Unfreeze takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerKey = GetHandleId(t)
    local integer unitKey = LoadInteger(IT_FreezeTimerTable, timerKey, 1)
    local unit u = LoadUnitHandle(IT_FreezeTimerTable, timerKey, 0)
    if u != null and GetUnitTypeId(u) != 0 then
        call PauseUnit(u, false)
        call SetUnitTimeScale(u, 1.0)
    endif
    call FlushChildHashtable(IT_FreezeTable, unitKey)
    call FlushChildHashtable(IT_FreezeTimerTable, timerKey)
    call DestroyTimer(t)
    set u = null
    set t = null
endfunction

function IT_FreezeAir takes unit u, real duration returns nothing
    local integer unitKey
    local integer timerKey
    local timer t
    if u == null or (not IsUnitType(u, UNIT_TYPE_FLYING) and not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then
        return
    endif
    set unitKey = GetHandleId(u)
    if HaveSavedHandle(IT_FreezeTable, unitKey, 0) then
        set t = LoadTimerHandle(IT_FreezeTable, unitKey, 0)
    else
        set t = CreateTimer()
        set timerKey = GetHandleId(t)
        call SaveTimerHandle(IT_FreezeTable, unitKey, 0, t)
        call SaveUnitHandle(IT_FreezeTimerTable, timerKey, 0, u)
        call SaveInteger(IT_FreezeTimerTable, timerKey, 1, unitKey)
        call PauseUnit(u, true)
        call SetUnitTimeScale(u, 0.0)
    endif
    call TimerStart(t, duration, false, function IT_Unfreeze)
    set t = null
endfunction"""
    if b"function IT_FrostSlowStep takes" in data:
        data = replace_function(data, "IT_FrostSlowStep", freeze_functions)
    elif b"function IT_Unfreeze takes" not in data:
        raise RuntimeError("Frostmourne freeze functions are missing")

    ground_functions = r"""function IT_IsGroundFrost takes item it returns boolean
    local player p
    if it == null or GetItemTypeId(it) != IT_ITEM_FROST then
        return false
    endif
    set p = GetItemPlayer(it)
    if p == null then
        return false
    endif
    return GetPlayerId(p) == PLAYER_NEUTRAL_PASSIVE
endfunction

function IT_AddGroundAura takes item it returns nothing
    local integer i = 0
    local integer key
    local effect fx = null
    local real x
    local real y
    if not IT_IsGroundFrost(it) then
        return
    endif
    set key = GetHandleId(it)
    loop
        exitwhen i >= IT_GROUND_COUNT
        if IT_GROUND_KEYS[i] == key then
            return
        endif
        set i = i + 1
    endloop
    if IT_GROUND_COUNT >= IT_GROUND_MAX then
        return
    endif
    if HaveSavedHandle(IT_GROUND_TABLE, key, 0) then
        set fx = LoadEffectHandle(IT_GROUND_TABLE, key, 0)
    endif
    set x = GetItemX(it)
    set y = GetItemY(it)
    if fx == null then
        set fx = AddSpecialEffect("war3campImported\\Rune-Blue-Aura_Raised20.mdx", x, y)
        call SaveEffectHandle(IT_GROUND_TABLE, key, 0, fx)
    endif
    set IT_GROUND_ITEMS[IT_GROUND_COUNT] = it
    set IT_GROUND_KEYS[IT_GROUND_COUNT] = key
    set IT_GROUND_EFFECTS[IT_GROUND_COUNT] = fx
    set IT_GROUND_X[IT_GROUND_COUNT] = x
    set IT_GROUND_Y[IT_GROUND_COUNT] = y
    set IT_GROUND_COUNT = IT_GROUND_COUNT + 1
    set fx = null
endfunction

function IT_EnumGroundItem takes nothing returns nothing
    call IT_AddGroundAura(GetEnumItem())
endfunction

function IT_RemoveGroundAura takes item it returns nothing
    local integer i = 0
    local integer key
    local integer last
    if it == null then
        return
    endif
    set key = GetHandleId(it)
    loop
        exitwhen i >= IT_GROUND_COUNT
        if IT_GROUND_KEYS[i] == key then
            call DestroyEffect(IT_GROUND_EFFECTS[i])
            call FlushChildHashtable(IT_GROUND_TABLE, key)
            set last = IT_GROUND_COUNT - 1
            set IT_GROUND_ITEMS[i] = IT_GROUND_ITEMS[last]
            set IT_GROUND_KEYS[i] = IT_GROUND_KEYS[last]
            set IT_GROUND_EFFECTS[i] = IT_GROUND_EFFECTS[last]
            set IT_GROUND_X[i] = IT_GROUND_X[last]
            set IT_GROUND_Y[i] = IT_GROUND_Y[last]
            set IT_GROUND_ITEMS[last] = null
            set IT_GROUND_KEYS[last] = 0
            set IT_GROUND_EFFECTS[last] = null
            set IT_GROUND_COUNT = last
            return
        endif
        set i = i + 1
    endloop
endfunction

function IT_OnFrostPickup takes nothing returns nothing
    local item it = GetManipulatedItem()
    if GetItemTypeId(it) == IT_ITEM_FROST then
        call IT_RemoveGroundAura(it)
    endif
    set it = null
endfunction

function IT_OnFrostDrop takes nothing returns nothing
    local item it = GetManipulatedItem()
    if GetItemTypeId(it) != IT_ITEM_FROST then
        set it = null
        return
    endif
    call TriggerSleepAction(0.05)
    call IT_AddGroundAura(it)
    set it = null
endfunction

"""
    if b"function IT_AddGroundAura takes item it returns nothing" not in data:
        attack_marker = b"function IT_OnAttack takes"
        if data.count(attack_marker) != 1:
            raise RuntimeError("cannot place Frostmourne ground-aura functions")
        data = data.replace(
            attack_marker,
            ground_functions.encode("utf-8") + attack_marker,
            1,
        )

    nova_attack = r"""function IT_OnAttack takes nothing returns nothing
    local unit source = GetAttacker()
    local unit target = GetTriggerUnit()
    local unit dummy
    if source == null or target == null then
        set source = null
        set target = null
        return
    endif
    if not UnitHasItemOfTypeBJ(source, IT_ITEM_FROST) then
        set source = null
        set target = null
        return
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(source)) or IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
        set source = null
        set target = null
        return
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) or GetRandomReal(0.0, 1.0) > IT_FROST_NOVA_CHANCE then
        set source = null
        set target = null
        return
    endif
    set dummy = CreateUnit(GetOwningPlayer(source), 'hfoo', GetUnitX(target), GetUnitY(target), 0.0)
    call UnitAddAbility(dummy, 'Aloc')
    call SetUnitScale(dummy, 0.01, 0.01, 0.01)
    call SetUnitVertexColor(dummy, 255, 255, 255, 0)
    call UnitAddAbility(dummy, 'A170')
    call IssueTargetOrder(dummy, "frostnova", target)
    call UnitApplyTimedLife(dummy, 'BTLF', 1.0)
    set dummy = null
    set source = null
    set target = null
endfunction"""
    data = replace_function(data, "IT_OnAttack", nova_attack)

    frost_spell = r"""function IT_PayFrostLifeCost takes unit u returns nothing
    local real currentLife
    local real cost
    if u == null then
        return
    endif
    set currentLife = GetUnitState(u, UNIT_STATE_LIFE)
    set cost = RMinBJ(RMaxBJ(1.0, currentLife * 0.20), RMaxBJ(0.0, currentLife - 1.0))
    if cost > 0.0 then
        call SetUnitState(u, UNIT_STATE_LIFE, currentLife - cost)
    endif
endfunction

function IT_OnFrostSpell takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local group g
    local unit target
    local real x
    local real y
    local real damage
    local real freezeDuration
    if caster == null or GetSpellAbilityId() != IT_ABILITY_FROST then
        set caster = null
        return
    endif
    set x = GetUnitX(caster)
    set y = GetUnitY(caster)
    set damage = I2R(GetHeroStr(caster, true)) * IT_FROST_STAT_MULT
    if damage <= 0.0 then
        set caster = null
        return
    endif
    call IT_PayFrostLifeCost(caster)
    call TriggerSleepAction(0.05)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, IT_FROST_RADIUS, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)
        if target != caster and IsUnitAliveBJ(target) and IsUnitEnemy(target, GetOwningPlayer(caster)) and not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
            call UnitDamageTarget(caster, target, damage, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            if IsUnitType(target, UNIT_TYPE_FLYING) then
                if IsUnitType(target, UNIT_TYPE_HERO) then
                    set freezeDuration = 3.0
                else
                    set freezeDuration = 5.0
                endif
                call IT_FreezeAir(target, freezeDuration)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set target = null
    set caster = null
endfunction"""
    data = remove_function(data, "IT_PayFrostLifeCost")
    data = replace_function(data, "IT_OnFrostSpell", frost_spell)

    spell_dispatch = """function IT_OnSpell takes nothing returns nothing
    if GetSpellAbilityId() == IT_ABILITY_FINGER then
        call IT_OnFinger()
    elseif GetSpellAbilityId() == IT_ABILITY_FROST then
        call IT_OnFrostSpell()
    endif
endfunction""".encode("ascii")
    data = replace_function(data, "IT_OnSpell", spell_dispatch.decode("ascii"))

    init = """function IT_Init takes nothing returns nothing
    local trigger t
    if IT_Inited then
        return
    endif
    set IT_Inited = true
    set IT_FreezeTable = InitHashtable()
    set IT_FreezeTimerTable = InitHashtable()
    set IT_GROUND_TABLE = InitHashtable()
    set IT_GROUND_WORLD = GetWorldBounds()
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function IT_OnPlunder)
    set IT_DeathTrigger = t
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function IT_OnSpell)
    set IT_SpellTrigger = t
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(t, function IT_OnAttack)
    set IT_AttackTrigger = t
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(t, function IT_OnFrostPickup)
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(t, function IT_OnFrostDrop)
    set IT_SyncTimer = CreateTimer()
    call TimerStart(IT_SyncTimer, 1.0, true, function IT_SyncStep)
    call EnumItemsInRect(IT_GROUND_WORLD, null, function IT_EnumGroundItem)
    set t = null
endfunction""".encode("ascii")
    data = replace_function(data, "IT_Init", init.decode("ascii"))
    return data.replace(b"\n", b"\r\n")


def assert_patched(archive):
    ability_version, ability_original, abilities = objparse.read_bytes(
        archive.read_file("war3map.w3a"), "w3a"
    )
    item_version, item_original, items = objparse.read_bytes(
        archive.read_file("war3map.w3t"), "w3t"
    )
    by_id = {entry["new"]: entry for entry in abilities}

    nova = by_id.get("A170")
    if nova is None or nova["old"] != "AUfn":
        raise RuntimeError("Frost Nova A170 is missing")
    nova_fields = {mod[0]: mod[4] for mod in nova["mods"]}
    expected_nova = {"aare": 250.0, "Ufn1": 50.0, "Ufn2": 100.0, "adur": 4.0}
    for field_id, expected in expected_nova.items():
        if abs(float(nova_fields[field_id]) - expected) > 0.0001:
            raise RuntimeError("A170.%s is not synchronized" % field_id)

    regen = by_id.get("A109")
    regen_fields = {mod[0]: mod[4] for mod in regen["mods"]}
    if abs(float(regen_fields["Imrp"]) - 1.0) > 0.0001:
        raise RuntimeError("A109.Imrp must be 1.0")
    active = by_id.get("A105")
    if active["old"] != "ANcl":
        raise RuntimeError("A105 must use the instant Channel base")
    active_fields = {mod[0]: mod[4] for mod in active["mods"]}
    if int(active_fields.get("aite", 1)) != 0:
        raise RuntimeError("A105 must be a hero ability")
    if active_fields.get("ahky") != "D":
        raise RuntimeError("A105 hotkey must be D")
    if active_fields.get("aord") != "froststomp":
        raise RuntimeError("A105 Profile order must be froststomp")
    if active_fields.get("Ncl6") != "froststomp":
        raise RuntimeError("A105 Channel order must be froststomp")
    if active_fields.get("Ncl2") != 0:
        raise RuntimeError("A105 must be an instant no-target skill")
    if active_fields.get("Ncl3") != 1:
        raise RuntimeError("A105 must remain visible")
    if active_fields.get("Ncl5") != 0:
        raise RuntimeError("A105 must not disable other abilities")
    if active_fields.get("aani") != "stand":
        raise RuntimeError("A105 must suppress the Channel animation")

    item = find_entry(items, "I105")
    item_fields = {mod[0]: mod[4] for mod in item["mods"]}
    if item_fields["iabi"] != "A106,A108,A109":
        raise RuntimeError("I105 ability list is not synchronized")
    if int(item_fields.get("iusa", 1)) != 0:
        raise RuntimeError("I105 must not be an active item")
    if item_fields.get("icid", b"") not in ("", b""):
        raise RuntimeError("I105 must not own an item cooldown")
    for field_id in ("utub", "ides"):
        text = item_fields[field_id]
        for required in ("攻击力 +30", "攻击速度 +50%", "魔法恢复 +100%",
                         "冰封践踏", "霜冻新星", "30% 概率",
                         "噬魂", "5%", "50%"):
            if required not in text:
                raise RuntimeError("I105.%s lacks %s" % (field_id, required))
        if "攻击减速 65%" in text:
            raise RuntimeError("I105 still advertises the old attack slow")
    for required in ("装备后获得技能：冰封践踏（D）。", "100 + 4×力量", "冰冻 5 秒"):
        if required not in item_fields["utub"]:
            raise RuntimeError("I105 tooltip lacks " + required)
    for forbidden in ("耗魔 100", "冷却 10 秒", "消耗 100 魔法"):
        if forbidden in item_fields["utub"]:
            raise RuntimeError("I105 tooltip still duplicates " + forbidden)
    active_tooltip = active_fields["aub1"]
    for required in ("消耗当前生命 20%", "100 + 4×力量", "冰冻 5 秒"):
        if required not in active_tooltip:
            raise RuntimeError("A105 tooltip lacks " + required)
    for forbidden in ("冰封践踏。", "耗魔 100", "冷却 10 秒", "消耗 100 魔法"):
        if forbidden in active_tooltip:
            raise RuntimeError("A105 tooltip still duplicates " + forbidden)

    for internal, expected_name in FROST_ASSETS.items():
        asset = archive.read_file(internal)
        if not asset:
            raise RuntimeError("missing imported Frostmourne asset: " + internal)
        expected = (ASSET_DIR / expected_name).read_bytes()
        if asset != expected:
            raise RuntimeError("Frostmourne asset mismatch: " + internal)

    script = archive.read_file("war3map.j") or b""
    for forbidden in (
        b"IT_FROST_SLOW_FACTOR",
        b"IT_FROST_SLOW_DURATION",
        b"IT_FROST_HERO_DURATION",
        b"IT_SlowGroup",
        b"IT_SlowTable",
        b"function IT_FrostSlowStep",
    ):
        if forbidden in script:
            raise RuntimeError("obsolete Frostmourne slow token remains: %r" % forbidden)
    for required in (
        b"real IT_FROST_NOVA_CHANCE = 0.30",
        b"call UnitAddAbility(dummy, 'A170')",
        b'call IssueTargetOrder(dummy, "frostnova", target)',
        b"call IT_PayFrostLifeCost(caster)",
        b"call IT_OnFrostSpell()",
        b"function IT_FreezeAir takes unit u, real duration returns nothing",
        b"currentLife * 0.20",
        b"function IT_AddGroundAura takes item it returns nothing",
        b"function IT_OnFrostPickup takes nothing returns nothing",
        b"function IT_OnFrostDrop takes nothing returns nothing",
        b'AddSpecialEffect("war3campImported\\\\Rune-Blue-Aura_Raised20.mdx"',
    ):
        if script.count(required) != 1:
            raise RuntimeError("Frostmourne token count is not one: %r" % required)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, default=DEFAULT_MAP)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    source = args.source.resolve()
    output = args.output
    if output is None:
        output = Path(tempfile.gettempdir()) / (
            source.stem + "_frostmourne_sync.w3x"
        )
    output = output.resolve()
    if not source.is_file():
        raise SystemExit("source map not found: " + str(source))
    if output.exists():
        output.unlink()

    archive = war3mpq.MPQArchive(str(source))
    try:
        script = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not script:
        raise RuntimeError("map is missing war3map.j")
    patches = patch_objects(source)
    patches["war3map.j"] = patch_script(script)
    mpq_patch.patch(
        str(source), list(patches.items()), out_path=str(output), backup=False
    )

    check = war3mpq.MPQArchive(str(output))
    try:
        for internal, expected in patches.items():
            if check.read_file(internal) != expected:
                raise RuntimeError("read-back mismatch: " + internal)
        assert_patched(check)
    finally:
        check.close()
    print("verified", output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
