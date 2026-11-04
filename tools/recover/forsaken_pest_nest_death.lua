-- ALAS_PEST_SLOW_BURN_FIX_V3
function Trig_Plague_Rats_Size_Actions()
  bj_forLoopAIndex = 1
  bj_forLoopAIndexEnd = 6
  while not (bj_forLoopAIndex > bj_forLoopAIndexEnd) do
    if Trig_Plague_Rats_Size_Func001Func001C() then
      udg_PlagueRats_NestSizes[GetForLoopIndexA()] = udg_PlagueRats_NestSizes[GetForLoopIndexA()] - 1
      if udg_PlagueRats_NestSizes[GetForLoopIndexA()] <= 0 then
        SetUnitScalePercent(udg_PlagueRats_NestUnits[GetForLoopIndexA()], 1.0, 1.0, 1.0)
        KillUnit(udg_PlagueRats_NestUnits[GetForLoopIndexA()])
      else
        SetUnitScalePercent(udg_PlagueRats_NestUnits[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()])
        if udg_PlagueRats_NestFX[GetForLoopIndexA()] ~= nil then
          udg_PlagueRats_NestFXSize[GetForLoopIndexA()] = udg_PlagueRats_NestFXSize[GetForLoopIndexA()] - 0.01
          BlzSetSpecialEffectScale(udg_PlagueRats_NestFX[GetForLoopIndexA()], udg_PlagueRats_NestFXSize[GetForLoopIndexA()])
        end
      end
    end
    bj_forLoopAIndex = bj_forLoopAIndex + 1
  end
  if Trig_Plague_Rats_Size_Func002C() then
    DisableTrigger(GetTriggeringTrigger())
  end
end
