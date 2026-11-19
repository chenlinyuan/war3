from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[1]
DOCTOR = INJECTOR.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import universal_talents as TALENTS  # noqa: E402


REPLACEMENT = b"""function TestSkinActions takes nothing returns nothing
    if true then
        call SaveInteger(udg_x, GetHandleId(udg_t), 1, GetHeroStr(udg_hero, false))
        call SaveInteger(udg_x, GetHandleId(udg_t), 2, GetHeroAgi(udg_hero, false))
        call CreateNUnitsAtLoc(1, 'H61G', Player(PLAYER_NEUTRAL_PASSIVE), udg_p, 0.0)
        call SaveUnitHandle(udg_x, GetHandleId(udg_t), 3, bj_lastCreatedUnit)
        call SetHeroLevelBJ(bj_lastCreatedUnit, 10, false)
        call UnitAddItemSwapped(UnitItemInSlotBJ(udg_hero, 1), bj_lastCreatedUnit)
        call RemoveUnit(udg_hero)
        set udg_hero = LoadUnitHandle(udg_x, GetHandleId(udg_t), 3)
        call SetUnitOwner(udg_hero, Player(0), true)
    endif
endfunction
"""

MULTI_BRANCH_REPLACEMENT = b"""function TestSkinActions takes nothing returns nothing
    if GetItemTypeId(GetManipulatedItem()) == 'I001' then
        call SaveInteger(udg_x, GetHandleId(udg_t), 1, GetHeroStr(udg_hero, false))
        call CreateNUnitsAtLoc(1, 'H001', Player(PLAYER_NEUTRAL_PASSIVE), udg_p, 0.0)
        call SaveUnitHandle(udg_x, GetHandleId(udg_t), 3, bj_lastCreatedUnit)
        call SetHeroLevelBJ(bj_lastCreatedUnit, 10, false)
        call UnitAddItemSwapped(UnitItemInSlotBJ(udg_hero, 1), bj_lastCreatedUnit)
        call RemoveUnit(udg_hero)
        set udg_hero = LoadUnitHandle(udg_x, GetHandleId(udg_t), 3)
        call SetUnitOwner(udg_hero, Player(0), true)
    elseif GetItemTypeId(GetManipulatedItem()) == 'I002' then
        call SaveInteger(udg_x, GetHandleId(udg_t), 1, GetHeroStr(udg_hero, false))
        call CreateNUnitsAtLoc(1, 'H002', Player(PLAYER_NEUTRAL_PASSIVE), udg_p, 0.0)
        call SaveUnitHandle(udg_x, GetHandleId(udg_t), 3, bj_lastCreatedUnit)
        call SetHeroLevelBJ(bj_lastCreatedUnit, 10, false)
        call UnitAddItemSwapped(UnitItemInSlotBJ(udg_hero, 1), bj_lastCreatedUnit)
        call RemoveUnit(udg_hero)
        set udg_hero = LoadUnitHandle(udg_x, GetHandleId(udg_t), 3)
        call SetUnitOwner(udg_hero, Player(0), true)
    endif
endfunction
"""

YDWE_REPLACEMENT = b"""function RestoreChapterHero takes nothing returns nothing
    call RestoreUnitLocFacingPointBJ("hero01", "hero", udg_cache, Player(0), udg_loc, udg_look)
    set udg_hero01 = bj_lastLoadedUnit
    call YDWEReplaceUnitBJNull(udg_hero01, 'E009', bj_UNIT_STATE_METHOD_RELATIVE)
    set udg_hero01 = bj_lastReplacedUnit
    call SetHeroLevelBJ(bj_lastReplacedUnit, 10, false)
    call TT_CampaignAuditRestoreProbe(GetLastCreatedGameCacheBJ(), "hero", "hero08")
    call RestoreUnitLocFacingPointBJ("hero08", "hero", udg_cache, Player(0), udg_loc, udg_look)
endfunction
"""

MANUAL_COPY_REPLACEMENT = b"""function StorySkinActions takes nothing returns nothing
    call SetHeroLevelBJ(udg_jere2, GetUnitLevel(udg_jere), false)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 0)), udg_jere2)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 1)), udg_jere2)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 2)), udg_jere2)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 3)), udg_jere2)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 4)), udg_jere2)
    call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 5)), udg_jere2)
endfunction
"""

MALL_SKIN_REPLACEMENT = b"""function MallIllidanSkinActions takes nothing returns nothing
    if DzAPI_Map_HasMallItem(Player(0), "NJPIFU") == true then
        call ShowUnit(udg_yilidan, false)
        call SetUnitOwner(gg_unit_Eevi_0022, Player(PLAYER_NEUTRAL_PASSIVE), true)
        call CreateNUnitsAtLoc(1, 'E62B', Player(0), udg_loc, bj_UNIT_FACING)
        set udg_yilidan = bj_lastCreatedUnit
        call ModifyHeroStat(bj_HEROSTAT_STR, udg_yilidan, bj_MODIFYMETHOD_SET, 10)
        call ModifyHeroStat(bj_HEROSTAT_AGI, udg_yilidan, bj_MODIFYMETHOD_SET, 10)
        call UnitAddItemSwapped(UnitItemInSlotBJ(gg_unit_Eevi_0022, 1), udg_yilidan)
    endif
endfunction
"""


class TalentHeroReplacementPatchTests(unittest.TestCase):
    def test_wraps_author_replacement_with_talent_bridge(self) -> None:
        output, counts = TALENTS.patch_hero_replacements(REPLACEMENT)

        self.assertEqual(counts, {"begin": 1, "end": 1, "ydwe": 0})
        begin = output.index(b"call TT_BeginHeroReplacement(udg_hero)")
        save = output.index(b"GetHeroStr(udg_hero, false)")
        owner = output.index(
            b"call SetUnitOwner(udg_hero, Player(0), true)"
        )
        end = output.index(b"call TT_EndHeroReplacement(udg_hero)")
        self.assertLess(begin, save)
        self.assertLess(owner, end)
        self.assertIn(
            TALENTS.HERO_REPLACEMENT_BEGIN_MARKER,
            output,
        )
        self.assertIn(
            TALENTS.HERO_REPLACEMENT_END_MARKER,
            output,
        )

    def test_patch_is_idempotent(self) -> None:
        output, _counts = TALENTS.patch_hero_replacements(REPLACEMENT)
        second, counts = TALENTS.patch_hero_replacements(output)

        self.assertEqual(second, output)
        self.assertEqual(counts, {"begin": 1, "end": 1, "ydwe": 0})

    def test_non_player_replacement_branch_is_not_patched(self) -> None:
        script = REPLACEMENT.replace(
            b"        call SetUnitOwner(udg_hero, Player(0), true)\n",
            b"",
        )
        output, counts = TALENTS.patch_hero_replacements(script)
        self.assertEqual(output, script)
        self.assertEqual(counts, {"begin": 0, "end": 0, "ydwe": 0})

    def test_non_replacement_functions_are_untouched(self) -> None:
        script = b"""function Normal takes nothing returns nothing
    call RemoveUnit(udg_temp)
endfunction
"""
        output, counts = TALENTS.patch_hero_replacements(script)
        self.assertEqual(output, script)
        self.assertEqual(counts, {"begin": 0, "end": 0, "ydwe": 0})

    def test_wraps_each_skin_branch_in_one_function(self) -> None:
        output, counts = TALENTS.patch_hero_replacements(
            MULTI_BRANCH_REPLACEMENT
        )

        self.assertEqual(counts, {"begin": 2, "end": 2, "ydwe": 0})
        self.assertEqual(output.count(b"call TT_BeginHeroReplacement("), 2)
        self.assertEqual(output.count(b"call TT_EndHeroReplacement("), 2)
        self.assertEqual(output.count(b"'H001'"), 1)
        self.assertEqual(output.count(b"'H002'"), 1)

    def test_runtime_bridge_does_not_force_skill_points(self) -> None:
        script = (INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j").read_text(
            encoding="utf-8"
        )

        self.assertNotIn("TT_REPLACEMENT_SKILL_POINTS", script)
        self.assertNotIn("event=HERO_REPLACEMENT_POINTS", script)

    def test_wraps_ydwe_hero_replacement(self) -> None:
        output, counts = TALENTS.patch_hero_replacements(YDWE_REPLACEMENT)

        self.assertEqual(counts, {"begin": 0, "end": 0, "ydwe": 1})
        replace = output.index(
            b"call TT_YDWEReplaceHeroBJNull(udg_hero01"
        )
        level = output.index(b"call SetHeroLevelBJ(bj_lastReplacedUnit, 10")
        self.assertLess(replace, level)
        self.assertIn(TALENTS.HERO_YDWE_REPLACEMENT_MARKER, output)

    def test_wraps_manual_six_slot_type_copy(self) -> None:
        output, counts = TALENTS.patch_hero_replacements(
            MANUAL_COPY_REPLACEMENT
        )

        self.assertEqual(counts, {"begin": 1, "end": 1, "ydwe": 0})
        begin = output.index(
            b"call TT_BeginHeroReplacement(udg_jere)"
        )
        first_copy = output.index(
            b"UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 0)"
        )
        last_copy = output.index(
            b"UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlot(udg_jere, 5)"
        )
        end = output.index(
            b"call TT_EndHeroReplacement(udg_jere2)"
        )
        self.assertLess(begin, first_copy)
        self.assertLess(last_copy, end)
        self.assertIn(TALENTS.HERO_REPLACEMENT_BEGIN_MARKER, output)
        self.assertIn(TALENTS.HERO_REPLACEMENT_END_MARKER, output)

    def test_wraps_mall_skin_that_replaces_global_hero(self) -> None:
        output, counts = TALENTS.patch_hero_replacements(
            MALL_SKIN_REPLACEMENT
        )

        self.assertEqual(counts, {"begin": 1, "end": 1, "ydwe": 0})
        begin = output.index(
            b"call TT_BeginHeroReplacement(udg_yilidan)"
        )
        show = output.index(b"call ShowUnit(udg_yilidan, false)")
        assign = output.index(
            b"set udg_yilidan = bj_lastCreatedUnit"
        )
        end = output.index(
            b"call TT_EndHeroReplacement(udg_yilidan)"
        )
        self.assertLess(begin, show)
        self.assertLess(assign, end)

    def test_does_not_wrap_ydwe_non_hero_replacement(self) -> None:
        script = b"""function ReplaceGate takes nothing returns nothing
    call YDWEReplaceUnitBJNull(gg_unit_gate_0001, 'nfoh', bj_UNIT_STATE_METHOD_RELATIVE)
endfunction
"""
        output, counts = TALENTS.patch_hero_replacements(script)

        self.assertEqual(output, script)
        self.assertEqual(counts, {"begin": 0, "end": 0, "ydwe": 0})

    def test_runtime_bridge_restores_missing_replacement_items(self) -> None:
        script = (INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j").read_text(
            encoding="utf-8"
        )

        self.assertIn("call TT_CaptureReplacementItems(u)", script)
        self.assertIn("call TT_RestoreReplacementItems(u)", script)
        self.assertIn("set it = UnitItemInBagSlot(u, slot)", script)
        self.assertIn(
            "set it = BlzUnitItemInEquipmentSlot"
            "(u, ConvertLoadoutSlot(slot))",
            script,
        )
        self.assertIn("exitwhen slot >= 30", script)
        self.assertIn("exitwhen slot >= 9", script)
        self.assertIn("if UnitEquipItem(u, it) then", script)
        self.assertIn("if UnitAddItem(u, it) then", script)
        self.assertIn("event=HERO_REPLACEMENT_EXT_FAIL", script)
        self.assertLess(
            script.index("function TT_RestoreReplacementEquipment"),
            script.index("function TT_RestoreReplacementBag"),
        )
        self.assertIn("function TT_YDWEReplaceHeroBJNull", script)
        self.assertNotIn(
            "call YDWEReplaceUnitBJNull(u, newUnitId, unitStateMethod)",
            script,
        )
        self.assertIn("event=HERO_REPLACEMENT_SKIP_SAME_TYPE", script)
        self.assertIn("if not TT_START_READY then", script)
        self.assertIn("event=HERO_REPLACEMENT_DEFER_INIT", script)
        self.assertIn(
            'call ExecuteFunc("TT_FlushDeferredHeroReplacement")',
            script,
        )

    def test_runtime_bridge_does_not_move_standard_six_slots(self) -> None:
        script = (INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j").read_text(
            encoding="utf-8"
        )
        capture = script[
            script.index("function TT_CaptureReplacementItems"):
            script.index("function TT_RestoreReplacementEquipment")
        ]

        self.assertNotIn("UnitItemInSlot(u, slot)", capture)
        self.assertNotIn("TT_REPLACEMENT_ITEMS", capture)
        self.assertIn("TT_REPLACEMENT_BAG_ITEMS", capture)
        self.assertIn("TT_REPLACEMENT_EQUIPMENT_ITEMS", capture)

    def test_runtime_bridge_restores_selected_hero_ui(self) -> None:
        script = (INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j").read_text(
            encoding="utf-8"
        )

        self.assertIn(
            "set TT_REPLACEMENT_WAS_SELECTED = "
            "IsUnitSelected(u, GetOwningPlayer(u))",
            script,
        )
        self.assertIn(
            "call SelectUnitForPlayerSingle(u, GetOwningPlayer(u))",
            script,
        )

    def test_runtime_bridge_resets_talents_after_skin_change(
        self,
    ) -> None:
        script = (INJECTOR.parents[1] / "scripts" / "talent-test" / "f.j").read_text(
            encoding="utf-8"
        )
        end_start = script.index(
            "function TT_EndHeroReplacement takes unit u returns nothing"
        )
        end_end = script.index("endfunction", end_start)
        end_body = script[end_start:end_end]

        self.assertIn(
            "call TT_ResetTalents(u)",
            end_body,
        )
        self.assertIn(
            '"HERO_REPLACEMENT_TALENT_RESET"',
            end_body,
        )
        self.assertNotIn(
            "call TT_ScheduleTalentUiRebuild(u, heroIndex)",
            end_body,
        )

    def test_injector_verifiers_use_extended_inventory_markers(self) -> None:
        for source in (
            INJECTOR / "universal_talents.py",
            INJECTOR / "port_alas_jass_campaign.py",
        ):
            text = source.read_text(encoding="utf-8")
            self.assertIn("HERO_REPLACEMENT_EXT_CAPTURE", text)
            self.assertIn("HERO_REPLACEMENT_EXT_RESTORE", text)
            self.assertIn("HERO_REPLACEMENT_EXT_FAIL", text)
            self.assertNotIn("HERO_REPLACEMENT_ITEM_CAPTURE", text)
            self.assertNotIn("HERO_REPLACEMENT_ITEM_RESTORE", text)
            self.assertNotIn("HERO_REPLACEMENT_ITEM_FAIL", text)


if __name__ == "__main__":
    unittest.main()
