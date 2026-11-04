function Trig_Brood_Mother_Group_Remove_From_Group_Actions()
  GroupRemoveUnitSimple(GetDyingUnit(), udg_BossBroodMotherGroup)
  ConditionalTriggerExecute(gg_trg_Brood_Mother_Death)
end
