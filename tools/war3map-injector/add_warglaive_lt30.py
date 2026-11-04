#!/usr/bin/env python3
"""Add the Warglaive of Azzinoth to the Reforged LotTemple 3.0 map.

The map is the canonical LostTempleLV_BladeMaster30.w3x produced by
build_lost_temple_30.py.  This patch adds:

* item I106, based on gcel;
* A110 (+15 agility) and A111 (agility-scaled 15%..200% attack speed)
  inside hidden spellbook A116;
* a damage-event growth passive with a 1% chance to permanently grant
  1 agility without a cap;
* A113, a one-level Channel ability added/removed by equipment sync;
  scripted 0.05-second movement owns the 650-range terrain-crossing charge,
  per-target damage, and the custom A117/A118/B64B attack stack;
* the Warglaive icon and item-browser entries/aliases.
"""

from pathlib import Path
import argparse
import glob
import io
import os
import struct
import subprocess
import sys
import tempfile


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools" / "war3map-injector"))
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import objparse  # noqa: E402
import war3mpq  # noqa: E402
from PIL import Image, ImageOps  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.models import blpwrite  # noqa: E402


DEFAULT_MAP = (
    ROOT / "maps" / "port" / "lost_temple_30" / "LostTempleLV_BladeMaster30.w3x"
)
ICON_PATH = r"ReplaceableTextures\CommandButtons\BTNWarglaiveOfAzzinoth.blp"
DISABLED_ICON_PATH = (
    r"ReplaceableTextures\CommandButtonsDisabled\DISBTNWarglaiveOfAzzinoth.blp"
)
ICON_IMPORT_PATH = b"ReplaceableTextures/CommandButtons/BTNWarglaiveOfAzzinoth.blp"
DISABLED_ICON_IMPORT_PATH = (
    b"ReplaceableTextures/CommandButtonsDisabled/DISBTNWarglaiveOfAzzinoth.blp"
)
CHARGE_ICON_IMPORT_PATH = (
    b"ReplaceableTextures/CommandButtons/BTNGarrekCharge.blp"
)
CHARGE_DISABLED_IMPORT_PATH = (
    b"ReplaceableTextures/CommandButtonsDisabled/DISBTNGarrekCharge.blp"
)
CHARGE_ICON_SOURCE = (
    r"war3.w3mod:_de.w3mod:replaceabletextures\commandbuttons"
    r"\btnbatteringram.dds"
)
SOURCE_ICON_PATH = r"Textures\Warglaive of Azzinoth.blp"
CHARGE_ABILITY_ID = "A113"
STACK_ATTACK_ID = "A117"
STACK_STATUS_ID = "A118"
STACK_BUFF_ID = "B64B"

ITEM_ID = "I106"
AGILITY_ID = "A110"
SPEED_ID = "A111"
SPELLBOOK_ID = "A116"

ITEM_NAME = "\u57c3\u8f9b\u8bfa\u65af\u6218\u5203"
ATTACK_SPEED_AGI_MULT = 0.005
ATTACK_SPEED_MIN = 0.15
ATTACK_SPEED_MAX = 2.0
ATTACK_SPEED_STEP = 0.05
ATTACK_SPEED_LEVELS = (
    int(round((ATTACK_SPEED_MAX - ATTACK_SPEED_MIN) / ATTACK_SPEED_STEP))
    + 1
)
ATTACK_SPEED_DESCRIPTION = (
    "\u653b\u51fb\u901f\u5ea6\u968f\u654f\u6377\u63d0\u5347\uff1a"
    "\u654f\u6377\u00d70.5%\uff0c\u6700\u4f4e 15%\uff0c\u6700\u9ad8 200%\u3002"
)
ITEM_TOOLTIP = (
    "|cffff8c00\u795e\u5668|r|n|n"
    "+15 \u654f\u6377|n"
    "|cff5ddf26" + ATTACK_SPEED_DESCRIPTION + "|r|n"
    "|cff5ddf26\u957f\u5203\u98ce\u66b4\uff1a\u8fd1\u6218\u57fa\u7840\u653b\u51fb\u9020\u6210 15% \u987a\u5288\u4f24\u5bb3\u3002|r|n"
    "|cff5ddf26\u90aa\u9b42\u6dec\u70bc\uff1a\u57fa\u7840\u653b\u51fb\u6709 2% \u51e0\u7387"
    "\u6c38\u4e45\u63d0\u5347 1 \u70b9\u654f\u6377\u3002\u4e0d\u8bbe\u4e0a\u9650\u3002|r|n"
    "|cff66ccff装备后获得技能：雷霆冲锋（C）。|r"
)
CHARGE_NAME = "雷霆冲锋"
CHARGE_ICON_PATH = (
    r"ReplaceableTextures\CommandButtons\BTNGarrekCharge.blp"
)
CHARGE_DISABLED_ICON_PATH = (
    r"ReplaceableTextures\CommandButtonsDisabled\DISBTNGarrekCharge.blp"
)
CHARGE_DESCRIPTION = (
    "向目标方向雷霆冲锋，对沿途命中的敌人造成 3×敏捷 的伤害。|n"
    "冲锋距离：100 + 敏捷×10，最高 2000。|n"
    "每命中 1 个不同敌人，攻击力 +15，最多 20 层，持续 7 秒。"
)
STACK_STATUS_TEXT = (
    "受到埃辛诺斯战刃的雷霆冲锋影响：|n"
    "每命中 1 个不同敌人，攻击力 +15，最多 20 层，持续 7 秒。"
)


def mod(field, value, typ=None, level=0, column=0):
    if typ is None:
        if isinstance(value, str):
            typ = objparse.T_STRING
        elif isinstance(value, float):
            typ = objparse.T_REAL
        else:
            typ = objparse.T_INT
    return [field, typ, level, column, value]


def warglaive_attack_speed_mods():
    mods = [
        mod("anam", ITEM_NAME),
        mod("ansf", "(\u57c3\u8f9b\u8bfa\u65af)"),
        mod("aart", ICON_PATH),
        mod("arar", ICON_PATH),
        mod("atp1", "\u57c3\u8f9b\u8bfa\u65af\u00b7\u901f\u5ea6"),
        mod("aub1", ATTACK_SPEED_DESCRIPTION),
        mod("alev", ATTACK_SPEED_LEVELS),
        mod("aite", 1),
        mod("aher", 0),
    ]
    mods.extend(
        mod(
            "Isx1",
            round(
                ATTACK_SPEED_MIN + (level - 1) * ATTACK_SPEED_STEP,
                2,
            ),
            level=level,
            column=1,
        )
        for level in range(1, ATTACK_SPEED_LEVELS + 1)
    )
    return mods


def warglaive_ability_specs():
    charge_mods = [
        mod("anam", CHARGE_NAME),
        mod("ansf", "(埃辛诺斯)"),
        mod("aart", CHARGE_ICON_PATH),
        mod("arar", CHARGE_ICON_PATH),
        mod("atp1", CHARGE_NAME, level=1),
        mod("aub1", CHARGE_DESCRIPTION, level=1),
        mod("alev", 1),
        mod("aite", 0),
        mod("aher", 0),
        mod("ahky", "C"),
        mod("arhk", ""),
        mod("aret", ""),
        mod("arac", "other"),
        mod("aord", "channel"),
        mod("Ncl1", 1.16, level=1, column=1),
        mod("Ncl2", 2, level=1, column=2),
        mod("Ncl3", 1, level=1, column=3),
        mod("Ncl4", 1.16, level=1, column=4),
        mod("Ncl5", 1, level=1, column=5),
        mod("Ncl6", "channel", level=1, column=6),
        mod("atar", "", level=1),
        mod("aran", 100000.0, level=1),
        mod("aare", 150.0, level=1),
        mod("acdn", 16.0, level=1),
        mod("amcs", 70, level=1),
        mod("acat", ""),
        mod("aeat", ""),
        mod("atat", ""),
        mod("aani", "attack slam"),
        mod("abpx", 2),
        mod("abpy", 1),
    ]
    attack_mods = [
        mod("anam", "雷霆冲锋（攻击力）"),
        mod("aart", CHARGE_ICON_PATH),
        mod("arar", CHARGE_ICON_PATH),
        mod("alev", 20),
        mod("aite", 1),
        mod("aher", 0),
        mod("ahky", ""),
        mod("arhk", ""),
    ]
    attack_mods.extend(
        mod("Iatt", level * 15, level=level, column=1)
        for level in range(1, 21)
    )
    status_mods = [
        mod("anam", CHARGE_NAME),
        mod("aart", CHARGE_ICON_PATH),
        mod("arar", CHARGE_ICON_PATH),
        mod("atp1", CHARGE_NAME, level=1),
        mod("aub1", STACK_STATUS_TEXT, level=1),
        mod("alev", 1),
        mod("aite", 1),
        mod("aher", 0),
        mod("ahky", ""),
        mod("arhk", ""),
        mod("Oae1", 0.0, level=1, column=1),
        mod("Oae2", 0.0, level=1, column=2),
        mod("aare", 1.0, level=1),
        mod("atar", "self", level=1),
        mod("abuf", STACK_BUFF_ID, level=1),
    ]
    return (
        ("ANcl", CHARGE_ABILITY_ID, charge_mods),
        ("AIat", STACK_ATTACK_ID, attack_mods),
        ("AOae", STACK_STATUS_ID, status_mods),
    )


def find_campaign(size):
    campaigns = glob.glob(r"H:\Games\War3\Campaigns\*.w3n")
    for path in campaigns:
        try:
            if os.path.getsize(path) == size:
                return Path(path)
        except OSError:
            pass
    raise RuntimeError("cannot find campaign with size %d" % size)


def read_campaign_icon():
    archive = war3mpq.MPQArchive(str(find_campaign(31503019)))
    try:
        data = archive.read_file(SOURCE_ICON_PATH)
    finally:
        archive.close()
    if not data or not data.startswith(b"BLP"):
        raise RuntimeError("Warglaive icon is missing or is not a BLP")
    return data


def normalized_tga(data, brightness, size=64):
    if len(data) < 18 or data[2] != 2:
        raise RuntimeError("BLPconv did not produce an uncompressed TGA")
    header = bytearray(data[:18])
    bits = header[16]
    if bits not in (24, 32):
        raise RuntimeError("unexpected TGA pixel depth %d" % bits)
    width, height = struct.unpack_from("<HH", header, 12)
    if width > size or height > size:
        raise RuntimeError("source icon is larger than %dx%d" % (size, size))
    step = bits // 8
    source = data[18:18 + width * height * step]
    canvas = bytearray(size * size * step)
    if step == 4:
        canvas[3::4] = b"\xff" * (size * size)
    x0 = (size - width) // 2
    y0 = (size - height) // 2
    for y in range(height):
        for x in range(width):
            src = (y * width + x) * step
            dst = ((y + y0) * size + x + x0) * step
            canvas[dst] = source[src] * brightness // 100
            canvas[dst + 1] = source[src + 1] * brightness // 100
            canvas[dst + 2] = source[src + 2] * brightness // 100
            if step == 4:
                canvas[dst + 3] = source[src + 3]
    struct.pack_into("<HH", header, 12, size, size)
    return bytes(header) + bytes(canvas)


def make_icons(source):
    blpconv = glob.glob(
        str(ROOT / "tools" / "war3-tools" / "**" / "BLPconv.exe"),
        recursive=True,
    )
    if not blpconv:
        raise RuntimeError("BLPconv.exe is required to build the disabled icon")
    with tempfile.TemporaryDirectory() as temp_dir:
        temp = Path(temp_dir)
        source_path = temp / "source.blp"
        normal_tga = temp / "normal.tga"
        normal_resized_tga = temp / "normal64.tga"
        disabled_tga = temp / "disabled.tga"
        normal_blp = temp / "normal.blp"
        disabled_blp = temp / "disabled.blp"
        source_path.write_bytes(source)
        subprocess.run(
            [blpconv[0], str(source_path), str(normal_tga)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        tga_data = normal_tga.read_bytes()
        normal_resized_tga.write_bytes(normalized_tga(tga_data, 100))
        disabled_tga.write_bytes(normalized_tga(tga_data, 35))
        subprocess.run(
            [blpconv[0], str(normal_resized_tga), str(normal_blp)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        subprocess.run(
            [blpconv[0], str(disabled_tga), str(disabled_blp)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        normal = normal_blp.read_bytes()
        disabled = disabled_blp.read_bytes()
        if not normal.startswith(b"BLP") or not disabled.startswith(b"BLP"):
            raise RuntimeError("Warglaive icon conversion did not produce BLP files")
        return normal, disabled


def make_charge_icons():
    game = OBJ.GameBase(locale="zhcn", balance=None)
    data = game.casc.read_data(CHARGE_ICON_SOURCE)
    icon = Image.open(io.BytesIO(data)).convert("RGBA")
    icon = icon.resize((64, 64), Image.Resampling.LANCZOS)
    disabled = ImageOps.grayscale(icon)
    disabled = disabled.point(lambda px: int(px * 0.35))
    disabled = disabled.convert("RGBA")
    disabled.putalpha(icon.getchannel("A"))
    with tempfile.TemporaryDirectory() as temp_dir:
        temp = Path(temp_dir)
        normal_path = temp / "normal.blp"
        disabled_path = temp / "disabled.blp"
        blpwrite.save_blp(icon, str(normal_path), mipmaps=False)
        blpwrite.save_blp(disabled, str(disabled_path), mipmaps=False)
        normal = normal_path.read_bytes()
        disabled_bytes = disabled_path.read_bytes()
    if not normal.startswith(b"BLP") or not disabled_bytes.startswith(b"BLP"):
        raise RuntimeError("Garrek charge icon conversion did not produce BLP")
    return normal, disabled_bytes


def upsert(custom, old, new, mods):
    updated = [entry for entry in custom if entry["new"] != new]
    updated.append({"old": old, "new": new, "mods": mods})
    return updated


WGL_JASS_GLOBALS = """
    timer WGL_SYNC_TIMER = null
    group WGL_SCAN_GROUP = null
    hashtable WGL_FX_HT = null
"""


WGL_JASS_FUNCTIONS = r"""
//============================================================================
// WARGLAIVE OF AZZINOTH - SKILL BAR CHARGE
//============================================================================
function WGL_HasWarglaive takes unit u returns boolean
    local integer i = 0
    local item it
    local boolean found = false
    loop
        exitwhen i > 5 or found
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == 'I106' then
            set found = true
        endif
        set i = i + 1
    endloop
    set it = null
    return found
endfunction

function WGL_SyncUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) then
        if WGL_HasWarglaive(u) then
            if GetUnitAbilityLevel(u, 'A113') == 0 then
                call UnitAddAbility(u, 'A113')
                call UnitMakeAbilityPermanent(u, true, 'A113')
            endif
        else
            if GetUnitAbilityLevel(u, 'A113') > 0 then
                call UnitRemoveAbility(u, 'A113')
            endif
        endif
    endif
    set u = null
endfunction

function WGL_Sync takes nothing returns nothing
    call GroupClear(WGL_SCAN_GROUP)
    call GroupEnumUnitsInRect(WGL_SCAN_GROUP, bj_mapInitialPlayableArea, null)
    call ForGroup(WGL_SCAN_GROUP, function WGL_SyncUnit)
endfunction

function WGL_IsChargeTarget takes unit caster, unit target returns boolean
    local player owner = GetOwningPlayer(caster)
    if target == null or GetUnitTypeId(target) == 0 then
        return false
    endif
    if target == caster or GetWidgetLife(target) <= 0.405 then
        return false
    endif
    if not IsUnitEnemy(target, owner) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_MECHANICAL) then
        return false
    endif
    return true
endfunction

function WGL_DestroyTimedEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer id = GetHandleId(t)
    local effect fx = LoadEffectHandle(WGL_FX_HT, id, 0)
    call DestroyEffect(fx)
    call FlushChildHashtable(WGL_FX_HT, id)
    call DestroyTimer(t)
    set fx = null
    set t = null
endfunction

function WGL_ShowTimedEffect takes string path, real x, real y, real duration returns nothing
    local timer t = CreateTimer()
    local effect fx = AddSpecialEffect(path, x, y)
    call SaveEffectHandle(WGL_FX_HT, GetHandleId(t), 0, fx)
    call TimerStart(t, duration, false, function WGL_DestroyTimedEffect)
    set fx = null
    set t = null
endfunction

function WGL_CastConditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A113'
endfunction

function WGL_CastActions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player owner = GetOwningPlayer(caster)
    local real startX = GetUnitX(caster)
    local real startY = GetUnitY(caster)
    local real aimX = GetSpellTargetX()
    local real aimY = GetSpellTargetY()
    local real angle = Atan2(aimY - startY, aimX - startX)
    local real distance = SquareRoot((aimX - startX) * (aimX - startX) + (aimY - startY) * (aimY - startY))
    local real agility = I2R(GetHeroAgi(caster, true))
    local real hitDamage = 250.0 + agility * 2.0
    local real explosionDamage = 50.0 + agility
    local real healAmount = 20.0 + agility * 0.5
    local real traveled = 0.0
    local real stepDistance = 24.0
    local real nextX
    local real nextY
    local real markX
    local real markY
    local real healLife
    local integer guard = 0
    local group hitGroup = CreateGroup()
    local group markedGroup = CreateGroup()
    local unit victim
    local unit target
    local effect trail
    if distance > 800.0 then
        set distance = 800.0
    endif
    set trail = AddSpecialEffectTarget("war3campImported\\Windwalk Fire.mdx", caster, "origin")
    call SetUnitAnimation(caster, "walk")
    loop
        exitwhen traveled >= distance
        exitwhen guard >= 40
        exitwhen GetUnitTypeId(caster) == 0
        exitwhen GetWidgetLife(caster) <= 0.405
        set guard = guard + 1
        set traveled = traveled + stepDistance
        if traveled > distance then
            set traveled = distance
        endif
        set nextX = startX + traveled * Cos(angle)
        set nextY = startY + traveled * Sin(angle)
        if not IsUnitType(caster, UNIT_TYPE_FLYING) and not IsTerrainPathable(nextX, nextY, PATHING_TYPE_WALKABILITY) then
            set traveled = distance
        else
            call SetUnitX(caster, nextX)
            call SetUnitY(caster, nextY)
            call SetUnitFacing(caster, angle * bj_RADTODEG)
            call GroupEnumUnitsInRange(hitGroup, nextX, nextY, 256.0, null)
            loop
                set victim = FirstOfGroup(hitGroup)
                exitwhen victim == null
                call GroupRemoveUnit(hitGroup, victim)
                if not IsUnitInGroup(victim, markedGroup) and WGL_IsChargeTarget(caster, victim) then
                    call GroupAddUnit(markedGroup, victim)
                    if UnitDamageTarget(caster, victim, hitDamage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS) then
                        call WGL_ShowTimedEffect("war3campImported\\Ember.mdx", GetUnitX(victim), GetUnitY(victim), 3.0)
                    endif
                endif
            endloop
            call TriggerSleepAction(0.03)
        endif
    endloop
    call SetUnitAnimation(caster, "stand")
    call DestroyEffect(trail)
    set trail = null
    call TriggerSleepAction(3.0)
    set victim = FirstOfGroup(markedGroup)
    loop
        exitwhen victim == null
        call GroupRemoveUnit(markedGroup, victim)
        if GetUnitTypeId(victim) != 0 and GetWidgetLife(victim) > 0.405 then
            set markX = GetUnitX(victim)
            set markY = GetUnitY(victim)
            call GroupEnumUnitsInRange(hitGroup, markX, markY, 200.0, null)
            loop
                set target = FirstOfGroup(hitGroup)
                exitwhen target == null
                call GroupRemoveUnit(hitGroup, target)
                if WGL_IsChargeTarget(caster, target) then
                    call UnitDamageTarget(caster, target, explosionDamage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    call WGL_ShowTimedEffect("war3campImported\\Damnation Orange.mdx", GetUnitX(target), GetUnitY(target), 0.7)
                endif
            endloop
            if GetUnitTypeId(caster) != 0 and GetWidgetLife(caster) > 0.405 then
                if SquareRoot((markX - GetUnitX(caster)) * (markX - GetUnitX(caster)) + (markY - GetUnitY(caster)) * (markY - GetUnitY(caster))) <= 600.0 then
                    set healLife = GetWidgetLife(caster) + healAmount
                    if healLife > GetUnitState(caster, UNIT_STATE_MAX_LIFE) then
                        set healLife = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
                    endif
                    call SetWidgetLife(caster, healLife)
                endif
            endif
        endif
        set victim = FirstOfGroup(markedGroup)
    endloop
    call DestroyGroup(hitGroup)
    call DestroyGroup(markedGroup)
    set hitGroup = null
    set markedGroup = null
    set victim = null
    set target = null
    set caster = null
    set owner = null
endfunction

function WGL_Init takes nothing returns nothing
    local trigger castTrigger
    if WGL_SYNC_TIMER != null then
        return
    endif
    set WGL_SCAN_GROUP = CreateGroup()
    set WGL_FX_HT = InitHashtable()
    set WGL_SYNC_TIMER = CreateTimer()
    call TimerStart(WGL_SYNC_TIMER, 0.25, true, function WGL_Sync)
    set castTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(castTrigger, Condition(function WGL_CastConditions))
    call TriggerAddAction(castTrigger, function WGL_CastActions)
    set castTrigger = null
endfunction
"""


WGL_V3_GLOBALS = """
    boolean WGL_INITED = false
    boolean WGL_ITEM_ACTIVE = false
    trigger WGL_CAST_TRIGGER = null
    trigger WGL_ORDER_TRIGGER = null
    trigger WGL_GROWTH_TRIGGER = null
    hashtable WGL_FX_HT = null
    hashtable WGL_CHARGE_HT = null
    hashtable WGL_CASTER_HT = null
    hashtable WGL_STACK_HT = null
    hashtable WGL_STACK_TIMER_HT = null
    hashtable WGL_COOLDOWN_HT = null
    hashtable WGL_GROWTH_HT = null
    trigger WGL_ATTACK_SPEED_TRIGGER = null
    timer WGL_COOLDOWN_CLOCK = null
    real WGL_ATTACK_SPEED_AGI_MULT = 0.005
    real WGL_ATTACK_SPEED_MIN = 0.15
    real WGL_ATTACK_SPEED_MAX = 2.0
    real WGL_ATTACK_SPEED_STEP = 0.05
    integer WGL_ATTACK_SPEED_LEVELS = 38
    integer WGL_GROWTH_CHANCE_PERCENT = 2
    real WGL_GROWTH_ATTACK_GUARD = 0.12
    real WGL_CHARGE_BASE_DISTANCE = 100.0
    real WGL_CHARGE_AGI_MULT = 10.0
    real WGL_CHARGE_MAX_DISTANCE = 2000.0
    real WGL_CHARGE_STEP = 50.0
    real WGL_CHARGE_INTERVAL = 0.05
    real WGL_CHARGE_RADIUS = 150.0
    real WGL_CHARGE_COOLDOWN = 16.0
    real WGL_STACK_DURATION = 7.0
    integer WGL_STACK_MAX = 20
"""


WGL_V3_FUNCTIONS = r"""
//============================================================================
// WARGLAIVE OF AZZINOTH - SCRIPTED BARBARIC CHARGE
//============================================================================
function WGL_HasWarglaive takes unit u returns boolean
    local item it
    local boolean found
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    if WGL_ITEM_ACTIVE then
        set it = BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(8))
        set found = it != null and GetItemTypeId(it) == 'I106'
        set it = null
        return found
    endif
    return UnitHasItemOfTypeBJ(u, 'I106')
endfunction

function WGL_CooldownClockTick takes nothing returns nothing
endfunction

function WGL_SyncAttackSpeed takes unit u returns nothing
    local integer level
    local real bonus
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) or not WGL_HasWarglaive(u) then
        return
    endif
    if GetUnitAbilityLevel(u, 'A111') <= 0 then
        return
    endif
    set bonus = I2R(GetHeroAgi(u, true)) * WGL_ATTACK_SPEED_AGI_MULT
    if bonus < WGL_ATTACK_SPEED_MIN then
        set bonus = WGL_ATTACK_SPEED_MIN
    elseif bonus > WGL_ATTACK_SPEED_MAX then
        set bonus = WGL_ATTACK_SPEED_MAX
    endif
    set level = R2I(bonus / WGL_ATTACK_SPEED_STEP + 0.5)
    set level = level - R2I(WGL_ATTACK_SPEED_MIN / WGL_ATTACK_SPEED_STEP) + 1
    if level < 1 then
        set level = 1
    elseif level > WGL_ATTACK_SPEED_LEVELS then
        set level = WGL_ATTACK_SPEED_LEVELS
    endif
    if GetUnitAbilityLevel(u, 'A111') != level then
        call SetUnitAbilityLevel(u, 'A111', level)
    endif
endfunction

function WGL_SyncUnit takes unit u returns nothing
    local integer unitId
    local real cooldownRemaining
    local real cooldownExpires
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if WGL_ITEM_ACTIVE then
        if GetUnitAbilityLevel(u, 'A116') > 0 then
            call UnitRemoveAbility(u, 'A116')
        endif
        call WGL_SyncAttackSpeed(u)
        return
    endif
    if WGL_HasWarglaive(u) then
        call WGL_SyncAttackSpeed(u)
        if GetUnitAbilityLevel(u, 'A113') == 0 then
            call UnitAddAbility(u, 'A113')
            call UnitMakeAbilityPermanent(u, true, 'A113')
            set unitId = GetHandleId(u)
            set cooldownExpires = LoadReal(WGL_COOLDOWN_HT, unitId, 0)
            set cooldownRemaining = cooldownExpires - TimerGetElapsed(WGL_COOLDOWN_CLOCK)
            if cooldownRemaining > 0.0 then
                call BlzStartUnitAbilityCooldown(u, 'A113', cooldownRemaining)
            endif
            call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
        endif
    elseif GetUnitAbilityLevel(u, 'A113') > 0 then
        set unitId = GetHandleId(u)
        set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
        if cooldownRemaining > 0.0 then
            call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
        else
            call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
        endif
        call UnitRemoveAbility(u, 'A113')
    endif
endfunction

function WGL_DestroyTimedEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer id = GetHandleId(t)
    local effect fx = LoadEffectHandle(WGL_FX_HT, id, 0)
    if fx != null then
        call DestroyEffect(fx)
    endif
    call FlushChildHashtable(WGL_FX_HT, id)
    call DestroyTimer(t)
    set fx = null
    set t = null
endfunction

function WGL_ShowTimedEffect takes string path, real x, real y, real duration returns nothing
    local timer t = CreateTimer()
    local effect fx = AddSpecialEffect(path, x, y)
    call SaveEffectHandle(WGL_FX_HT, GetHandleId(t), 0, fx)
    call TimerStart(t, duration, false, function WGL_DestroyTimedEffect)
    set fx = null
    set t = null
endfunction

function WGL_ShowGrowthText takes unit u returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt, "埃辛诺斯战刃·邪魂淬炼：敏捷 +1", 0.023)
    call SetTextTagPosUnit(tt, u, 64.0)
    call SetTextTagColor(tt, 120, 255, 140, 255)
    call SetTextTagVelocity(tt, 0.0, 0.035)
    call SetTextTagPermanent(tt, false)
    call SetTextTagLifespan(tt, 1.2)
    call SetTextTagFadepoint(tt, 0.8)
    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(u))
    set tt = null
endfunction

function WGL_OnGrowthAttack takes nothing returns nothing
    local unit attacker = GetEventDamageSource()
    local unit victim = GetTriggerUnit()
    local integer unitId
    local real now
    if attacker == null or GetUnitTypeId(attacker) == 0 then
        set attacker = null
        set victim = null
        return
    endif
    if not IsUnitType(attacker, UNIT_TYPE_HERO) or not WGL_HasWarglaive(attacker) then
        set attacker = null
        set victim = null
        return
    endif
    if victim == null or GetUnitTypeId(victim) == 0 or GetWidgetLife(victim) <= 0.405 then
        set attacker = null
        set victim = null
        return
    endif
    if not IsUnitEnemy(victim, GetOwningPlayer(attacker)) or IsUnitType(victim, UNIT_TYPE_STRUCTURE) or IsUnitType(victim, UNIT_TYPE_MECHANICAL) then
        set attacker = null
        set victim = null
        return
    endif
    if not BlzGetEventIsAttack() then
        set attacker = null
        set victim = null
        return
    endif
    set unitId = GetHandleId(attacker)
    set now = TimerGetElapsed(WGL_COOLDOWN_CLOCK)
    if now < LoadReal(WGL_GROWTH_HT, unitId, 0) then
        set attacker = null
        set victim = null
        return
    endif
    call SaveReal(WGL_GROWTH_HT, unitId, 0, now + WGL_GROWTH_ATTACK_GUARD)
    if GetRandomInt(1, 100) > WGL_GROWTH_CHANCE_PERCENT then
        set attacker = null
        set victim = null
        return
    endif
    call SetHeroAgi(attacker, GetHeroAgi(attacker, false) + 1, true)
    call WGL_SyncAttackSpeed(attacker)
    call WGL_ShowGrowthText(attacker)
    set attacker = null
    set victim = null
endfunction

function WGL_IsChargeTarget takes unit caster, unit target returns boolean
    if target == null or GetUnitTypeId(target) == 0 then
        return false
    endif
    if target == caster or GetWidgetLife(target) <= 0.405 then
        return false
    endif
    if not IsUnitEnemy(target, GetOwningPlayer(caster)) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function WGL_RemoveStackAbilities takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if GetUnitAbilityLevel(u, 'A117') > 0 then
        call UnitMakeAbilityPermanent(u, false, 'A117')
        call UnitRemoveAbility(u, 'A117')
    endif
    if GetUnitAbilityLevel(u, 'A118') > 0 then
        call UnitMakeAbilityPermanent(u, false, 'A118')
        call UnitRemoveAbility(u, 'A118')
    endif
endfunction

function WGL_SyncInitialUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    call WGL_RemoveStackAbilities(u)
    call WGL_SyncUnit(u)
    set u = null
endfunction

function WGL_StackTick takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerId = GetHandleId(t)
    local integer unitId = LoadInteger(WGL_STACK_TIMER_HT, timerId, 0)
    local unit u = LoadUnitHandle(WGL_STACK_HT, unitId, 0)
    local real remaining
    if u == null or GetUnitTypeId(u) == 0 or GetWidgetLife(u) <= 0.405 then
        call WGL_RemoveStackAbilities(u)
        call FlushChildHashtable(WGL_STACK_TIMER_HT, timerId)
        call FlushChildHashtable(WGL_STACK_HT, unitId)
        call DestroyTimer(t)
    else
        set remaining = LoadReal(WGL_STACK_HT, unitId, 3) - 0.10
        if remaining <= 0.0 then
            call WGL_RemoveStackAbilities(u)
            call FlushChildHashtable(WGL_STACK_TIMER_HT, timerId)
            call FlushChildHashtable(WGL_STACK_HT, unitId)
            call DestroyTimer(t)
        else
            call SaveReal(WGL_STACK_HT, unitId, 3, remaining)
        endif
    endif
    set u = null
    set t = null
endfunction

function WGL_AddChargeStack takes unit u returns nothing
    local integer unitId = GetHandleId(u)
    local integer oldStacks = LoadInteger(WGL_STACK_HT, unitId, 2)
    local integer stacks = oldStacks + 1
    local timer t = LoadTimerHandle(WGL_STACK_HT, unitId, 1)
    if stacks > WGL_STACK_MAX then
        set stacks = WGL_STACK_MAX
    endif
    if GetUnitAbilityLevel(u, 'A117') == 0 then
        call UnitAddAbility(u, 'A117')
        call UnitMakeAbilityPermanent(u, true, 'A117')
    endif
    if GetUnitAbilityLevel(u, 'A118') == 0 then
        call UnitAddAbility(u, 'A118')
        call UnitMakeAbilityPermanent(u, true, 'A118')
    endif
    call BlzUnitHideAbility(u, 'A117', true)
    call BlzUnitHideAbility(u, 'A118', true)
    if GetUnitAbilityLevel(u, 'A117') != stacks then
        call SetUnitAbilityLevel(u, 'A117', stacks)
    endif
    if GetUnitAbilityLevel(u, 'A118') != 1 then
        call SetUnitAbilityLevel(u, 'A118', 1)
    endif
    call SaveUnitHandle(WGL_STACK_HT, unitId, 0, u)
    call SaveInteger(WGL_STACK_HT, unitId, 2, stacks)
    call SaveReal(WGL_STACK_HT, unitId, 3, WGL_STACK_DURATION)
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(WGL_STACK_HT, unitId, 1, t)
        call SaveInteger(WGL_STACK_TIMER_HT, GetHandleId(t), 0, unitId)
        call TimerStart(t, 0.10, true, function WGL_StackTick)
    endif
    set t = null
endfunction

function WGL_FinishCharge takes timer t returns nothing
    local integer timerId = GetHandleId(t)
    local integer unitId
    local unit caster = LoadUnitHandle(WGL_CHARGE_HT, timerId, 0)
    local group hitGroup = LoadGroupHandle(WGL_CHARGE_HT, timerId, 1)
    local real cooldownRemaining
    if caster != null and GetUnitTypeId(caster) != 0 then
        set unitId = GetHandleId(caster)
        if LoadTimerHandle(WGL_CASTER_HT, unitId, 0) == t then
            call FlushChildHashtable(WGL_CASTER_HT, unitId)
        endif
        call PauseUnit(caster, false)
        call SetUnitPathing(caster, true)
        call IssueImmediateOrder(caster, "stop")
        set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(caster, 'A113')
        if cooldownRemaining < 1.0 then
            call BlzStartUnitAbilityCooldown(caster, 'A113', WGL_CHARGE_COOLDOWN)
        endif
        call ResetUnitAnimation(caster)
    endif
    if hitGroup != null then
        call DestroyGroup(hitGroup)
    endif
    call FlushChildHashtable(WGL_CHARGE_HT, timerId)
    call DestroyTimer(t)
    set caster = null
    set hitGroup = null
endfunction

function WGL_ChargeTick takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerId = GetHandleId(t)
    local unit caster = LoadUnitHandle(WGL_CHARGE_HT, timerId, 0)
    local group hitGroup = LoadGroupHandle(WGL_CHARGE_HT, timerId, 1)
    local group candidates
    local unit victim
    local integer step = LoadInteger(WGL_CHARGE_HT, timerId, 2)
    local real startX = LoadReal(WGL_CHARGE_HT, timerId, 3)
    local real startY = LoadReal(WGL_CHARGE_HT, timerId, 4)
    local real angle = LoadReal(WGL_CHARGE_HT, timerId, 5)
    local real damage = LoadReal(WGL_CHARGE_HT, timerId, 6)
    local real chargeDistance = LoadReal(WGL_CHARGE_HT, timerId, 7)
    local real traveled
    local real x
    local real y
    if caster == null or GetUnitTypeId(caster) == 0 or GetWidgetLife(caster) <= 0.405 then
        call WGL_FinishCharge(t)
        set caster = null
        set hitGroup = null
        set t = null
        return
    endif
    if not IsUnitPaused(caster) or IsUnitType(caster, UNIT_TYPE_STUNNED) then
        call WGL_FinishCharge(t)
        set caster = null
        set hitGroup = null
        set t = null
        return
    endif
    set step = step + 1
    set traveled = I2R(step) * WGL_CHARGE_STEP
    if traveled > chargeDistance then
        set traveled = chargeDistance
    endif
    set x = startX + traveled * Cos(angle)
    set y = startY + traveled * Sin(angle)
    call SetUnitX(caster, x)
    call SetUnitY(caster, y)
    call SetUnitFacing(caster, angle * bj_RADTODEG)
    call WGL_ShowTimedEffect("StormfallRed.mdx", x, y, 0.55)
    set candidates = CreateGroup()
    call GroupEnumUnitsInRange(candidates, x, y, WGL_CHARGE_RADIUS, null)
    loop
        set victim = FirstOfGroup(candidates)
        exitwhen victim == null
        call GroupRemoveUnit(candidates, victim)
        if not IsUnitInGroup(victim, hitGroup) and WGL_IsChargeTarget(caster, victim) then
            call GroupAddUnit(hitGroup, victim)
            call WGL_AddChargeStack(caster)
            call UnitDamageTarget(caster, victim, damage, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
            call WGL_ShowTimedEffect("war3campImported\\DemonBoltImpactSilent.mdx", GetUnitX(victim), GetUnitY(victim), 0.8)
        endif
    endloop
    call DestroyGroup(candidates)
    call SaveInteger(WGL_CHARGE_HT, timerId, 2, step)
    if traveled >= chargeDistance then
        call WGL_FinishCharge(t)
    endif
    set candidates = null
    set victim = null
    set caster = null
    set hitGroup = null
    set t = null
endfunction

function WGL_OnChargePoint takes unit caster, real targetX, real targetY, boolean consumeMana returns nothing
    local integer unitId
    local integer timerId
    local timer previous
    local timer t
    local group hitGroup
    local real startX
    local real startY
    local real dx
    local real dy
    local real angle
    local real chargeDistance
    if caster == null or GetUnitTypeId(caster) == 0 or GetWidgetLife(caster) <= 0.405 then
        return
    endif
    if not WGL_HasWarglaive(caster) then
        return
    endif
    set unitId = GetHandleId(caster)
    set previous = LoadTimerHandle(WGL_CASTER_HT, unitId, 0)
    if previous != null then
        set previous = null
        return
    endif
    if consumeMana then
        if GetUnitState(caster, UNIT_STATE_MANA) < 70.0 then
            return
        endif
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - 70.0)
    endif
    call PlaySound("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.wav")
    set startX = GetUnitX(caster)
    set startY = GetUnitY(caster)
    set dx = targetX - startX
    set dy = targetY - startY
    if dx * dx + dy * dy < 1.0 then
        set angle = GetUnitFacing(caster) * bj_DEGTORAD
    else
        set angle = Atan2(dy, dx)
    endif
    set t = CreateTimer()
    set timerId = GetHandleId(t)
    set hitGroup = CreateGroup()
    call SaveUnitHandle(WGL_CHARGE_HT, timerId, 0, caster)
    call SaveGroupHandle(WGL_CHARGE_HT, timerId, 1, hitGroup)
    call SaveInteger(WGL_CHARGE_HT, timerId, 2, 0)
    call SaveReal(WGL_CHARGE_HT, timerId, 3, startX)
    call SaveReal(WGL_CHARGE_HT, timerId, 4, startY)
    call SaveReal(WGL_CHARGE_HT, timerId, 5, angle)
    call SaveReal(WGL_CHARGE_HT, timerId, 6, I2R(GetHeroAgi(caster, true)) * 3.0)
    set chargeDistance = RMinBJ(WGL_CHARGE_MAX_DISTANCE, WGL_CHARGE_BASE_DISTANCE + I2R(GetHeroAgi(caster, true)) * WGL_CHARGE_AGI_MULT)
    call SaveReal(WGL_CHARGE_HT, timerId, 7, chargeDistance)
    call SaveTimerHandle(WGL_CASTER_HT, unitId, 0, t)
    call SetUnitPathing(caster, false)
    call SetUnitFacing(caster, angle * bj_RADTODEG)
    call SetUnitAnimation(caster, "attack slam")
    call PauseUnit(caster, true)
    call BlzStartUnitAbilityCooldown(caster, 'A113', WGL_CHARGE_COOLDOWN)
    call TimerStart(t, WGL_CHARGE_INTERVAL, true, function WGL_ChargeTick)
    set previous = null
    set t = null
    set hitGroup = null
endfunction

function WGL_OnCharge takes nothing returns nothing
    if GetSpellAbilityId() != 'A113' then
        return
    endif
    call WGL_OnChargePoint(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), false)
endfunction

function WGL_OrderConditions takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local boolean matched
    set matched = caster != null and GetUnitTypeId(caster) != 0 and GetUnitAbilityLevel(caster, 'A113') > 0 and WGL_HasWarglaive(caster) and GetIssuedOrderId() == OrderId("channel")
    set caster = null
    return matched
endfunction

function WGL_OnChargeOrder takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real targetX
    local real targetY
    if not WGL_OrderConditions() then
        set caster = null
        return
    endif
    set targetX = GetOrderPointX()
    set targetY = GetOrderPointY()
    call IssueImmediateOrder(caster, "stop")
    call WGL_OnChargePoint(caster, targetX, targetY, true)
    set caster = null
endfunction

function WGL_OnItemEvent takes nothing returns nothing
    local unit u
    local item it
    local integer unitId
    local real cooldownRemaining
    set u = GetTriggerUnit()
    set it = GetManipulatedItem()
    if u == null or GetUnitTypeId(u) == 0 then
        set it = null
        set u = null
        return
    endif
    if not WGL_ITEM_ACTIVE and GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM and it != null and GetItemTypeId(it) == 'I106' then
        if GetUnitAbilityLevel(u, 'A113') > 0 then
            set unitId = GetHandleId(u)
            set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
            if cooldownRemaining > 0.0 then
                call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
            else
                call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
            endif
            call UnitRemoveAbility(u, 'A113')
        endif
        set it = null
        set u = null
        return
    endif
    call WGL_SyncUnit(u)
    set it = null
    set u = null
endfunction

function WGL_OnHeroLevel takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call WGL_SyncAttackSpeed(u)
    set u = null
endfunction

function WGL_Init takes nothing returns nothing
    local group initial
    local trigger itemTrigger
    if WGL_INITED then
        return
    endif
    set WGL_INITED = true
    set WGL_FX_HT = InitHashtable()
    set WGL_CHARGE_HT = InitHashtable()
    set WGL_CASTER_HT = InitHashtable()
    set WGL_STACK_HT = InitHashtable()
    set WGL_STACK_TIMER_HT = InitHashtable()
    set WGL_COOLDOWN_HT = InitHashtable()
    set WGL_GROWTH_HT = InitHashtable()
    set WGL_COOLDOWN_CLOCK = CreateTimer()
    call TimerStart(WGL_COOLDOWN_CLOCK, 8640000.0, false, function WGL_CooldownClockTick)
    set itemTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(itemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(itemTrigger, function WGL_OnItemEvent)
    set itemTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(itemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(itemTrigger, function WGL_OnItemEvent)
    set WGL_CAST_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_CAST_TRIGGER, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerRegisterAnyUnitEventBJ(WGL_CAST_TRIGGER, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(WGL_CAST_TRIGGER, function WGL_OnCharge)
    set WGL_ORDER_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_ORDER_TRIGGER, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddAction(WGL_ORDER_TRIGGER, function WGL_OnChargeOrder)
    set WGL_GROWTH_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_GROWTH_TRIGGER, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddAction(WGL_GROWTH_TRIGGER, function WGL_OnGrowthAttack)
    set WGL_ATTACK_SPEED_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WGL_ATTACK_SPEED_TRIGGER, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(WGL_ATTACK_SPEED_TRIGGER, function WGL_OnHeroLevel)
    set initial = CreateGroup()
    call GroupEnumUnitsInRect(initial, bj_mapInitialPlayableArea, null)
    call ForGroup(initial, function WGL_SyncInitialUnit)
    call DestroyGroup(initial)
    set initial = null
    set itemTrigger = null
endfunction
"""


def patch_objects(map_path):
    archive = war3mpq.MPQArchive(str(map_path))
    try:
        raw = {
            ext: archive.read_file("war3map." + ext)
            for ext in ("w3a", "w3h", "w3t", "imp")
        }
    finally:
        archive.close()
    for ext in ("w3a", "w3h", "w3t"):
        if not raw[ext]:
            raise RuntimeError("missing war3map." + ext)

    parsed = {
        ext: objparse.read_bytes(raw[ext], ext)
        for ext in ("w3a", "w3h", "w3t")
    }
    versions = {ext: parsed[ext][0] for ext in parsed}
    originals = {ext: parsed[ext][1] for ext in parsed}
    customs = {ext: list(parsed[ext][2]) for ext in parsed}

    occupied = {
        entry["new"]
        for entries in customs.values()
        for entry in entries
    }
    our_ids = {
        ITEM_ID,
        AGILITY_ID,
        SPEED_ID,
        SPELLBOOK_ID,
        CHARGE_ABILITY_ID,
        STACK_ATTACK_ID,
        STACK_STATUS_ID,
    }
    conflicts = sorted(occupied & our_ids)
    if conflicts:
        print("replacing existing Warglaive object IDs:", ", ".join(conflicts))

    ability_mods = [
        mod("anam", ITEM_NAME),
        mod("ansf", "(\u57c3\u8f9b\u8bfa\u65af)"),
        mod("aart", ICON_PATH),
        mod("arar", ICON_PATH),
        mod("atp1", "\u57c3\u8f9b\u8bfa\u65af\u00b7\u654f\u6377"),
        mod("aub1", "\u6c38\u4e45\u63d0\u9ad8 15 \u70b9\u654f\u6377\u3002"),
        mod("alev", 1),
        mod("aite", 1),
        mod("aher", 0),
        mod("Iagi", 15, level=1, column=1),
    ]
    customs["w3a"] = upsert(customs["w3a"], "AIa1", AGILITY_ID, ability_mods)

    speed_mods = warglaive_attack_speed_mods()
    customs["w3a"] = upsert(customs["w3a"], "AIsx", SPEED_ID, speed_mods)

    spellbook_mods = [
        mod("anam", "[\u4e66]\u57c3\u8f9b\u8bfa\u65af\u6218\u5203"),
        mod("aart", ICON_PATH),
        mod("arar", ICON_PATH),
        mod("alev", 1),
        mod("aite", 1),
        mod("aher", 0),
        mod("spb1", ",".join((AGILITY_ID, SPEED_ID)), level=1, column=1),
        mod("spb5", "spellbook", level=1, column=5),
        mod("spb3", 12, level=1, column=3),
        mod("spb4", 12, level=1, column=4),
    ]
    customs["w3a"] = upsert(customs["w3a"], "Aspb", SPELLBOOK_ID, spellbook_mods)
    customs["w3a"] = [
        entry for entry in customs["w3a"]
        if entry["new"] not in ("A112", "A114", "A115")
    ]

    for base_id, ident, ability_mods in warglaive_ability_specs():
        customs["w3a"] = upsert(
            customs["w3a"], base_id, ident, ability_mods
        )

    customs["w3h"] = [
        entry for entry in customs["w3h"]
        if entry["new"] not in ("B647", "BUbr")
    ]
    buff_mods = [
        mod("fnam", CHARGE_NAME),
        mod("ftip", CHARGE_NAME),
        mod("fube", STACK_STATUS_TEXT),
        mod("fart", CHARGE_ICON_PATH),
    ]
    customs["w3h"] = upsert(
        customs["w3h"], "BHab", STACK_BUFF_ID, buff_mods
    )

    item_mods = [
        mod("unam", "|cffff8c00" + ITEM_NAME + "|r"),
        mod("utip", ITEM_NAME),
        mod("utub", ITEM_TOOLTIP),
        mod("iabi", ",".join((AGILITY_ID, SPEED_ID, "Aclq"))),
        mod("icid", ""),
        mod("iico", ICON_PATH),
        mod("icla", "Artifact"),
        mod("ilev", 8),
        mod("igol", 1000),
        mod("ihtp", 75),
        mod("idro", 1),
        mod("ipaw", 0),
    ]
    customs["w3t"] = upsert(customs["w3t"], "gcel", ITEM_ID, item_mods)

    output = {}
    for ext in ("w3a", "w3h", "w3t"):
        output["war3map." + ext] = objparse.build_bytes(
            versions[ext], originals[ext], customs[ext], ext
        )

    imp = bytearray(raw["imp"])
    version, count = struct.unpack_from("<ii", imp, 0)
    if version not in (1, 2):
        raise RuntimeError("unexpected war3map.imp version %d" % version)
    added = [
        path
        for path in (
            ICON_IMPORT_PATH,
            DISABLED_ICON_IMPORT_PATH,
            CHARGE_ICON_IMPORT_PATH,
            CHARGE_DISABLED_IMPORT_PATH,
        )
        if path not in imp
    ]
    if added:
        struct.pack_into("<i", imp, 4, count + len(added))
        for path in added:
            imp += b"\x0d" + path + b"\x00"
    source_icon = read_campaign_icon()
    output[ICON_PATH], output[DISABLED_ICON_PATH] = make_icons(source_icon)
    (
        output[CHARGE_ICON_PATH],
        output[CHARGE_DISABLED_ICON_PATH],
    ) = make_charge_icons()
    output["war3map.imp"] = bytes(imp)
    return output


def patch_script(data):
    # The item-browser section assembled by the LT30 build uses LF even though
    # the base Blizzard script still has a few CRLF line endings near the top.
    newline = b"\n"
    item_anchor = (
        b"        set ib_itemCustom[275] = 1" + newline
        + b"        set ib_itemCount = 276" + newline
    )
    item_block = newline.join(
        (
            b"        set ib_itemList[276] = 'I106'",
            b'        set ib_itemName[276] = "'
            + ITEM_NAME.encode("utf-8")
            + b'"',
            b'        set ib_itemNameGbk[276] = "'
            + ITEM_NAME.encode("gbk")
            + b'"',
            b"        set ib_itemCustom[276] = 1",
        )
    )
    if data.count(item_anchor) == 1:
        replacement = (
            b"        set ib_itemCustom[275] = 1" + newline
            + item_block + newline
            + b"        set ib_itemCount = 277" + newline
        )
        data = data.replace(item_anchor, replacement, 1)
    elif not (
        data.count(b"        set ib_itemList[276] = 'I106'") == 1
        and data.count(b"        set ib_itemCount = 277") == 1
    ):
        raise RuntimeError("unexpected item-browser tail")

    alias_anchor = (
        b'        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), '
        b'ib_addName) or (ib_addIdx == 273 and IB_StrEqCI(ib_addName, "bag")) '
        b'or (ib_addIdx == 274 and (IB_StrEqCI(ib_addName, "hand") or '
        b'IB_StrEqCI(ib_addName, "akhand"))) or (ib_addIdx == 275 and '
        b'(IB_StrEqCI(ib_addName, "frost") or IB_StrEqCI(ib_addName, "frostmourne"))) then'
        + newline
    )
    if data.count(alias_anchor) == 1:
        alias_replacement = alias_anchor[:-len(b" then" + newline)] + (
            b' or (ib_addIdx == 276 and (IB_StrEqCI(ib_addName, "warglaive") '
            b'or IB_StrEqCI(ib_addName, "glaive") or '
            b'IB_StrEqCI(ib_addName, "eggblade") or '
            b'IB_StrEqCI(ib_addName, "azzinoth"))) then'
            + newline
        )
        data = data.replace(alias_anchor, alias_replacement, 1)
    elif data.count(b'IB_StrEqCI(ib_addName, "warglaive")') != 1:
        raise RuntimeError("unexpected item-browser alias block")

    protect_anchor = (
        b"    elseif abilId == 'AIsw' or abilId == 'AIsx' or abilId == 'AIsz' "
        b"or abilId == 'AIt6' or abilId == 'AIt9' or abilId == 'AIta' "
        b"or abilId == 'AItb' or abilId == 'AItc' then"
        + newline
    )
    protect_line = (
        b"    elseif abilId == 'A110' or abilId == 'A111' or abilId == 'A116' or abilId == 'A117' or abilId == 'A118' then"
    )
    old_protect_lines = (
        b"    elseif abilId == 'A110' or abilId == 'A111' or abilId == 'A116' then",
        b"    elseif abilId == 'A110' or abilId == 'A111' or abilId == 'A116' or abilId == 'A117' or abilId == 'A118' then",
        b"    elseif abilId == 'A110' or abilId == 'A111' or abilId == 'A115' then",
    )
    if data.count(protect_line) == 1:
        pass
    elif any(data.count(old_protect_line) == 1 for old_protect_line in old_protect_lines):
        old_protect_line = next(
            line for line in old_protect_lines if data.count(line) == 1
        )
        data = data.replace(old_protect_line, protect_line, 1)
    elif data.count(protect_anchor) == 1:
        protect_replacement = (
            protect_line
            + newline
            + b"        return true" + newline
            + protect_anchor
        )
        data = data.replace(protect_anchor, protect_replacement, 1)
    else:
        raise RuntimeError("unexpected item-ability protection block")

    globals_code = WGL_V3_GLOBALS.replace("\n", "\r\n").encode("ascii")
    if b"hashtable WGL_STACK_TIMER_HT = null" not in data:
        old_globals_start = data.find(b"    boolean WGL_INITED = false")
        if old_globals_start < 0:
            old_globals_start = data.find(b"    timer WGL_SYNC_TIMER = null")
        if old_globals_start >= 0:
            globals_end = data.find(b"endglobals", old_globals_start)
            if globals_end < 0:
                raise RuntimeError("unexpected Warglaive globals block")
            data = (
                data[:old_globals_start]
                + globals_code
                + b"\r\n"
                + data[globals_end:]
            )
        else:
            globals_end = b"endglobals\r\n"
            if data.count(globals_end) != 1:
                raise RuntimeError("unexpected JASS globals block")
            data = data.replace(globals_end, globals_code + globals_end, 1)

    main_anchor = b"function main takes nothing returns nothing\r\n"
    if data.count(main_anchor) != 1:
        raise RuntimeError("unexpected JASS main function")
    old_marker = (
        b"//============================================================================\r\n"
        b"// WARGLAIVE OF AZZINOTH - SKILL BAR CHARGE\r\n"
    )
    sync_marker = (
        b"//============================================================================\r\n"
        b"// WARGLAIVE OF AZZINOTH - REFORGED EQUIPMENT SYNC\r\n"
    )
    new_marker = (
        b"//============================================================================\r\n"
        b"// WARGLAIVE OF AZZINOTH - SCRIPTED BARBARIC CHARGE\r\n"
    )
    block_start = data.find(old_marker)
    if block_start < 0:
        block_start = data.find(sync_marker)
    if block_start < 0:
        block_start = data.find(new_marker)
    functions = WGL_V3_FUNCTIONS.replace("\n", "\r\n").encode("utf-8")
    main_pos = data.find(main_anchor)
    if block_start >= 0 and block_start < main_pos:
        data = data[:block_start] + functions + b"\r\n" + data[main_pos:]
    else:
        data = data.replace(
            main_anchor, functions + b"\r\n" + main_anchor, 1
        )

    init_call = b"    call WGL_Init(  )\r\n"
    if init_call not in data:
        custom_init = b"    call InitCustomTriggers(  )\r\n"
        if data.count(custom_init) != 1:
            raise RuntimeError("unexpected InitCustomTriggers call")
        data = data.replace(custom_init, init_call + custom_init, 1)
    return data


def assert_patched(archive):
    checks = {}
    for ext in ("w3a", "w3h", "w3t"):
        data = archive.read_file("war3map." + ext)
        if not data:
            raise RuntimeError("missing war3map." + ext)
        _version, _original, custom = objparse.read_bytes(data, ext)
        checks[ext] = custom

    item = next(entry for entry in checks["w3t"] if entry["new"] == ITEM_ID)
    item_fields = {entry[0]: entry[4] for entry in item["mods"]}
    expected_item = {
        "iabi": "A110,A111,Aclq",
        "iico": ICON_PATH,
        "icid": "",
        "icla": "Artifact",
        "ilev": 8,
        "idro": 1,
        "ipaw": 0,
    }
    for field, expected in expected_item.items():
        if item_fields.get(field) != expected:
            raise RuntimeError("%s.%s is %r, expected %r" %
                               (ITEM_ID, field, item_fields.get(field), expected))
    if item_fields["iabi"].split(",") != ["A110", "A111", "Aclq"]:
        raise RuntimeError("item must expose direct passives and cleave")
    item_tooltip = item_fields["utub"]
    for required in ("1%", "\u6c38\u4e45\u63d0\u5347 1 \u70b9\u654f\u6377", "\u4e0d\u8bbe\u4e0a\u9650"):
        if required not in item_tooltip:
            raise RuntimeError("item tooltip lacks " + required)
    if "\u96f7\u970d\u51b2\u950b" in item_tooltip:
        raise RuntimeError("item tooltip must not duplicate the skill-bar entry")

    by_id = {entry["new"]: entry for entry in checks["w3a"]}
    expected_abilities = {
        AGILITY_ID: ("AIa1", "Iagi", 15),
        SPELLBOOK_ID: ("Aspb", "spb1", "A110,A111"),
    }
    for ability_id, (base, field, expected) in expected_abilities.items():
        entry = by_id.get(ability_id)
        if entry is None or entry["old"] != base:
            raise RuntimeError("missing %s based on %s" % (ability_id, base))
        fields = {item[0]: item[4] for item in entry["mods"]}
        actual = fields.get(field)
        if isinstance(expected, str):
            if actual != expected:
                raise RuntimeError("%s.%s is %r, expected %r" %
                                   (ability_id, field, actual, expected))
        elif actual is None or abs(float(actual) - float(expected)) > 0.0001:
            raise RuntimeError("%s.%s is %r, expected %r" %
                               (ability_id, field, actual, expected))

    speed = by_id.get(SPEED_ID)
    if speed is None or speed["old"] != "AIsx":
        raise RuntimeError("missing %s based on AIsx" % SPEED_ID)
    speed_fields = {item[0]: item[4] for item in speed["mods"]}
    speed_levels = {
        item[2]: item[4]
        for item in speed["mods"]
        if item[0] == "Isx1"
    }
    if speed_fields.get("alev") != ATTACK_SPEED_LEVELS:
        raise RuntimeError(
            "%s.alev is %r, expected %r" %
            (SPEED_ID, speed_fields.get("alev"), ATTACK_SPEED_LEVELS)
        )
    if abs(float(speed_levels.get(1, -1)) - ATTACK_SPEED_MIN) > 0.0001:
        raise RuntimeError("%s level 1 attack speed mismatch" % SPEED_ID)
    if abs(float(speed_levels.get(ATTACK_SPEED_LEVELS, -1))
           - ATTACK_SPEED_MAX) > 0.0001:
        raise RuntimeError("%s maximum attack speed mismatch" % SPEED_ID)
    if ATTACK_SPEED_DESCRIPTION not in speed_fields.get("aub1", ""):
        raise RuntimeError("%s tooltip lacks dynamic attack speed" % SPEED_ID)

    if "A112" in by_id:
        raise RuntimeError("obsolete corruption orb A112 remains")
    if "A119" in by_id:
        raise RuntimeError("obsolete native growth ability A119 remains")

    charge = by_id.get(CHARGE_ABILITY_ID)
    if charge is None or charge["old"] != "ANcl":
        raise RuntimeError("A113 must be based on ANcl")
    charge_fields = {item[0]: item[4] for item in charge["mods"]}
    expected_charge = {
        "ahky": "C",
        "aite": 0,
        "alev": 1,
        "Ncl1": 1.16,
        "Ncl2": 2,
        "Ncl3": 1,
        "Ncl4": 1.16,
        "Ncl5": 1,
        "Ncl6": "channel",
        "aran": 100000.0,
        "acdn": 16.0,
        "amcs": 70,
        "aart": CHARGE_ICON_PATH,
        "arar": CHARGE_ICON_PATH,
        "atp1": CHARGE_NAME,
        "aub1": CHARGE_DESCRIPTION,
        "atar": "",
    }
    for field, expected in expected_charge.items():
        actual = charge_fields.get(field)
        if isinstance(expected, float):
            if actual is None or abs(float(actual) - expected) > 0.0001:
                raise RuntimeError("A113.%s is %r, expected %r" %
                                   (field, actual, expected))
        elif actual != expected:
            raise RuntimeError("A113.%s is %r, expected %r" %
                               (field, actual, expected))
    for field in ("abuf", "chr1", "chr2", "ubr1", "ubr2", "ubr3"):
        if field in charge_fields:
            raise RuntimeError("A113 must not depend on native AUbr field " + field)

    attack = by_id.get(STACK_ATTACK_ID)
    if attack is None or attack["old"] != "AIat":
        raise RuntimeError("A117 must be based on AIat")
    attack_fields = {item[0]: item[4] for item in attack["mods"]}
    if attack_fields.get("aite") != 1:
        raise RuntimeError("A117 must use the green item attack bonus")
    if attack_fields.get("ahky") != "":
        raise RuntimeError("A117 must not expose a command-card hotkey")
    attack_levels = {
        item[2]: item[4]
        for item in attack["mods"]
        if item[0] == "Iatt" and item[3] == 1
    }
    expected_attack_levels = {
        level: level * 15 for level in range(1, 21)
    }
    if attack_levels != expected_attack_levels:
        raise RuntimeError("A117 does not contain 15..300 green attack levels")

    status = by_id.get(STACK_STATUS_ID)
    if status is None or status["old"] != "AOae":
        raise RuntimeError("A118 must be based on AOae")
    status_fields = {item[0]: item[4] for item in status["mods"]}
    for field, expected in (
        ("abuf", STACK_BUFF_ID),
        ("Oae1", 0.0),
        ("Oae2", 0.0),
        ("ahky", ""),
    ):
        actual = status_fields.get(field)
        if isinstance(expected, float):
            if actual is None or abs(float(actual) - expected) > 0.0001:
                raise RuntimeError("A118.%s is %r, expected %r" %
                                   (field, actual, expected))
        elif actual != expected:
            raise RuntimeError("A118.%s is %r, expected %r" %
                               (field, actual, expected))

    for removed in ("A114", "A115"):
        if removed in by_id:
            raise RuntimeError("obsolete armour object remains: %s" % removed)
    buffs = {entry["new"]: entry for entry in checks["w3h"]}
    for removed in ("B647", "BUbr"):
        if removed in buffs:
            raise RuntimeError("obsolete native charge buff remains: " + removed)
    stack_buff = buffs.get(STACK_BUFF_ID)
    if stack_buff is None or stack_buff["old"] != "BHab":
        raise RuntimeError("B64B must be an independent BHab custom buff")
    stack_buff_fields = {item[0]: item[4] for item in stack_buff["mods"]}
    for field, expected in (
        ("fnam", CHARGE_NAME),
        ("ftip", CHARGE_NAME),
        ("fube", STACK_STATUS_TEXT),
        ("fart", CHARGE_ICON_PATH),
    ):
        if stack_buff_fields.get(field) != expected:
            raise RuntimeError("B64B.%s is not synchronized" % field)

    script = archive.read_file("war3map.j") or b""
    for token in (
        b"set ib_itemList[276] = 'I106'",
        b"set ib_itemCount = 277",
        b'IB_StrEqCI(ib_addName, "warglaive")',
        b"abilId == 'A110' or abilId == 'A111' or abilId == 'A116' or abilId == 'A117' or abilId == 'A118'",
        b"function WGL_Init takes nothing returns nothing",
        b"function WGL_OnGrowthAttack takes nothing returns nothing",
        b"BlzGetEventIsAttack()",
        b"EVENT_PLAYER_UNIT_DAMAGED",
        b"SetHeroAgi(attacker, GetHeroAgi(attacker, false) + 1, true)",
        b"call WGL_Init(  )",
        b"function WGL_SyncUnit takes unit u returns nothing",
        b"call UnitAddAbility(u, 'A113')",
        b"call UnitRemoveAbility(u, 'A113')",
        b"set u = GetTriggerUnit()",
        b"BlzGetUnitAbilityCooldownRemaining(u, 'A113')",
        b"call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)",
        b"call BlzStartUnitAbilityCooldown(u, 'A113', cooldownRemaining)",
        b"function WGL_OnItemEvent takes nothing returns nothing",
        b"function WGL_OnChargePoint takes unit caster, real targetX, real targetY, boolean consumeMana returns nothing",
        b"if not WGL_HasWarglaive(caster) then",
        b"function WGL_OnCharge takes nothing returns nothing",
        b"function WGL_OnChargeOrder takes nothing returns nothing",
        b'GetIssuedOrderId() == OrderId("channel")',
        b"GetUnitAbilityLevel(caster, 'A113') > 0 and WGL_HasWarglaive(caster)",
        b"function WGL_ChargeTick takes nothing returns nothing",
        b"function WGL_FinishCharge takes timer t returns nothing",
        b"function WGL_AddChargeStack takes unit u returns nothing",
        b"function WGL_StackTick takes nothing returns nothing",
        b"call BlzUnitHideAbility(u, 'A117', true)",
        b"call BlzUnitHideAbility(u, 'A118', true)",
        b'call IssueImmediateOrder(caster, "stop")',
        b"I2R(GetHeroAgi(caster, true)) * 3.0",
        b"set traveled = I2R(step) * WGL_CHARGE_STEP",
        b"not IsUnitInGroup(victim, hitGroup)",
        b"call WGL_AddChargeStack(caster)",
        b"real WGL_CHARGE_BASE_DISTANCE = 100.0",
        b"real WGL_CHARGE_AGI_MULT = 10.0",
        b"real WGL_CHARGE_MAX_DISTANCE = 2000.0",
        b"set chargeDistance = RMinBJ(WGL_CHARGE_MAX_DISTANCE, WGL_CHARGE_BASE_DISTANCE + I2R(GetHeroAgi(caster, true)) * WGL_CHARGE_AGI_MULT)",
        b"real WGL_CHARGE_STEP = 50.0",
        b"real WGL_CHARGE_INTERVAL = 0.05",
        b"real WGL_CHARGE_RADIUS = 150.0",
        b"real WGL_CHARGE_COOLDOWN = 16.0",
        b"real WGL_STACK_DURATION = 7.0",
        b"BlzStartUnitAbilityCooldown(caster, 'A113', WGL_CHARGE_COOLDOWN)",
        b"BlzGetUnitAbilityCooldownRemaining(caster, 'A113')",
        b"call SetUnitAnimation(caster, \"attack slam\")",
        b"call TimerStart(t, WGL_CHARGE_INTERVAL, true, function WGL_ChargeTick)",
        b"call TriggerRegisterAnyUnitEventBJ(WGL_CAST_TRIGGER, EVENT_PLAYER_UNIT_SPELL_EFFECT)",
        b"call TriggerAddAction(WGL_CAST_TRIGGER, function WGL_OnCharge)",
        b"call TriggerRegisterAnyUnitEventBJ(WGL_ORDER_TRIGGER, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)",
        b"call TriggerAddAction(WGL_ORDER_TRIGGER, function WGL_OnChargeOrder)",
        b"call SetUnitPathing(caster, false)",
        b"call SetUnitPathing(caster, true)",
        b"call PauseUnit(caster, true)",
        b"call PauseUnit(caster, false)",
        b"StormfallRed.mdx",
        b"war3campImported\\DemonBoltImpactSilent.mdx",
        b"call TriggerRegisterAnyUnitEventBJ(itemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)",
        b"UnitHasItemOfTypeBJ(u, 'I106')",
        b"BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(8))",
        b"boolean WGL_INITED = false",
    ):
        if script.count(token) < 1:
            raise RuntimeError("script token missing: %r" % token)
    for token in (
        b"function WGL_Init takes nothing returns nothing",
        b"call WGL_Init(  )",
        b"real WGL_CHARGE_BASE_DISTANCE = 100.0",
        b"real WGL_CHARGE_MAX_DISTANCE = 2000.0",
        b"hashtable WGL_STACK_TIMER_HT = null",
        b"hashtable WGL_COOLDOWN_HT = null",
    ):
        if script.count(token) != 1:
            raise RuntimeError("script token count is not one: %r" % token)
    wgl_start = script.find(
        b"// WARGLAIVE OF AZZINOTH - SCRIPTED BARBARIC CHARGE"
    )
    wgl_end = script.find(b"function main takes nothing returns nothing", wgl_start)
    if wgl_start < 0 or wgl_end < 0:
        raise RuntimeError("Warglaive runtime section not found")
    wgl_script = script[wgl_start:wgl_end]
    for forbidden in (
        b"WGL_SYNC_TIMER",
        b"BlzSetUnitArmor",
        b"BlzGetUnitArmor",
        b"A114",
        b"A115",
        b"B647",
        b"AUbr",
        b"BUbr",
        b"WGL_CAST_START_TRIGGER",
        b"WGL_OnChargeStart",
        b"WGL_ChargeTrailTick",
        b"WGL_TRAIL_INTERVAL",
        b"SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A117'",
        b"SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A118'",
        b"SetUnitPosition",
        b"IsTerrainPathable",
        b"BatteringRam",
        b"GetManipulatingUnit()",
    ):
        if forbidden in wgl_script:
            raise RuntimeError("obsolete armour timer token remains: %r" % forbidden)
    icon = archive.read_file(ICON_PATH)
    if not icon or not icon.startswith(b"BLP"):
        raise RuntimeError("Warglaive icon is not readable from the output map")
    disabled = archive.read_file(DISABLED_ICON_PATH)
    if not disabled or not disabled.startswith(b"BLP"):
        raise RuntimeError("disabled Warglaive icon is not readable from the output map")
    charge_icon = archive.read_file(CHARGE_ICON_PATH)
    if not charge_icon or not charge_icon.startswith(b"BLP"):
        raise RuntimeError("Garrek charge icon is not readable from the output map")
    charge_disabled = archive.read_file(CHARGE_DISABLED_ICON_PATH)
    if not charge_disabled or not charge_disabled.startswith(b"BLP"):
        raise RuntimeError("disabled Garrek charge icon is not readable")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, default=DEFAULT_MAP)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()

    source = args.source.resolve()
    output = args.output
    if output is None:
        output = Path(tempfile.gettempdir()) / (source.stem + "_warglaive.w3x")
    output = output.resolve()
    if not source.is_file():
        raise SystemExit("source map not found: " + str(source))
    if output.exists():
        output.unlink()

    archive = war3mpq.MPQArchive(str(source))
    try:
        script = archive.read_file("war3map.j") or b""
    finally:
        archive.close()
    if not script:
        raise SystemExit("war3map.j is missing")

    patches = patch_objects(source)
    patches["war3map.j"] = patch_script(script)
    mpq_patch.patch(
        str(source),
        list(patches.items()),
        out_path=str(output),
        backup=False,
    )

    check = war3mpq.MPQArchive(str(output))
    try:
        for name, expected in patches.items():
            if check.read_file(name) != expected:
                raise RuntimeError("read-back mismatch: " + name)
        assert_patched(check)
    finally:
        check.close()
    print("verified", output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
