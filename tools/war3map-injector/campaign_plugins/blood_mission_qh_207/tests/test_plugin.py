# -*- coding: utf-8 -*-
from __future__ import annotations

import sys
import unittest
from pathlib import Path


INJECTOR = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(INJECTOR))

from campaign_plugins.blood_mission_qh_207.patch import (  # noqa: E402
    patch,
    verify,
)


class BloodMissionBackpackTests(unittest.TestCase):
    def test_replaces_slot_based_task_item_cleanup(self) -> None:
        text = """function Trig_orginsetActions takes nothing returns nothing
    if ( ( YDWEUnitHasItemOfTypeBJNull(udg_Jere , 'I62A') == true ) ) then
        call RemoveItem(UnitItemInSlot(udg_Jere, 0))
        call RemoveItem(UnitItemInSlot(udg_Jere, 1))
    else
        call IssueImmediateOrder(udg_Jere, "berserk")
        call RemoveItem(UnitItemInSlot(udg_Jere, 0))
        call RemoveItem(UnitItemInSlot(udg_Jere, 1))
    endif
endfunction
function Trig_moveswordActions takes nothing returns nothing
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(udg_Jere, 'I625'))
    call UnitDropItemSlot(udg_Jere, UnitItemInSlot(udg_Jere, 1), 0)
endfunction
"""

        patched, stats = patch(text, "c3.w3x")

        self.assertNotIn("RemoveItem(UnitItemInSlot(udg_Jere", patched)
        self.assertEqual(
            patched.count(
                "call BM_RemoveCampaignTaskItem(udg_Jere, 'I62A')"
            ),
            2,
        )
        self.assertEqual(
            patched.count(
                "call BM_RemoveCampaignTaskItem(udg_Jere, 'I629')"
            ),
            2,
        )
        self.assertEqual(
            patched.count(
                "function BM_RemoveCampaignTaskItem takes unit u"
            ),
            1,
        )
        self.assertEqual(stats["campaign_patch_count"], 2)
        self.assertEqual(verify(patched, stats), [])

    def test_other_chapters_are_unchanged(self) -> None:
        text = (
            "call RemoveItem(UnitItemInSlot(udg_Jere, 0))\n"
            "call RemoveItem(UnitItemInSlot(udg_Jere, 1))\n"
        )

        patched, stats = patch(text, "c5.w3x")

        self.assertEqual(patched, text)
        self.assertEqual(stats["campaign_patch_count"], 0)

    def test_replaces_movesword_slot_drop_with_item_drop(self) -> None:
        text = """function Trig_moveswordActions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(udg_Jere, 'I625'))
    call UnitDropItemSlot(udg_Jere, UnitItemInSlot(udg_Jere, 1), 0)
endfunction
"""

        patched, stats = patch(text, "c10.w3x")

        self.assertNotIn("UnitDropItemSlot(udg_Jere", patched)
        self.assertIn(
            "call BM_DropCampaignItemByType(udg_Jere, 'I627')",
            patched,
        )
        self.assertEqual(
            patched.count(
                "function BM_DropCampaignItemByType takes unit u"
            ),
            1,
        )
        self.assertEqual(stats["campaign_patch_count"], 1)
        self.assertEqual(verify(patched, stats), [])

    def test_c18_removes_amulet_by_id_instead_of_slot(self) -> None:
        text = """function Trig_moveswordActions takes nothing returns nothing
    call RemoveItem(YDWEGetItemOfTypeFromUnitBJNull(udg_Jere, 'I625'))
    call UnitDropItemSlot(udg_Jere, UnitItemInSlot(udg_Jere, 1), 0)
endfunction
function Trig_end0Actions takes nothing returns nothing
    call RemoveItem(UnitItemInSlot(udg_Jere, 0))
    call UnitAddItemByIdSwapped('I627', udg_Jere)
endfunction
"""

        patched, stats = patch(text, "c18.w3x")

        self.assertNotIn("RemoveItem(UnitItemInSlot(udg_Jere", patched)
        self.assertIn(
            "call BM_RemoveCampaignTaskItem(udg_Jere, 'I625')",
            patched,
        )
        self.assertEqual(stats["campaign_patch_count"], 2)
        self.assertEqual(verify(patched, stats), [])


if __name__ == "__main__":
    unittest.main()
