#!/usr/bin/env python3
"""Add an ASCII command that completes the next unfinished Forest main quest."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_COMPLETE_NEXT_MAIN_QUEST_V1"
UNPAUSE_MARKER = b"ALAS_SELECTED_UNPAUSE_V1"
FORBIDDEN_COMMANDS = (b"broodfix",)


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    count = data.count(old_bytes)
    if count != 1:
        raise RuntimeError(f"expected exactly one match, found {count}")
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("next-main-quest command already present")
    if UNPAUSE_MARKER not in data:
        raise RuntimeError("selected-unit unpause command is missing")
    for command in FORBIDDEN_COMMANDS:
        if command in data:
            raise RuntimeError(
                "refusing to patch a map containing recovery command: "
                + command.decode("ascii")
            )

    function_old = """-- @jass 1612
function IB_OnChat()
"""
    function_new = """-- ALAS_COMPLETE_NEXT_MAIN_QUEST_V1
function IB_CompleteNextMainQuest(p)
  local ids = {1, 2, 3, 4, 5, 6, 8, 9, 10}
  local quests = {
    [1] = udg_MQ_SecondChance,
    [2] = udg_MQ_ForsakenWorkers,
    [3] = udg_MQ_ApothecariumSupplies,
    [4] = udg_MQ_SequreQuarry,
    [5] = udg_MQ_DiggingDeeper,
    [6] = udg_MQ_ScourgePocket,
    [8] = udg_MQ_MissingForsaken,
    [9] = udg_MQ_SilverHandAttack,
    [10] = udg_MQ_RemnantsSH
  }
  local triggers = {
    [1] = gg_trg_MQ_01_Second_Chance_Complete,
    [2] = gg_trg_MQ_02_Forsaken_Workers_Complete,
    [3] = gg_trg_MQ_03_Apothecarium_Supply_Complete,
    [4] = gg_trg_MQ_04_Secure_Quarry_Complete,
    [5] = gg_trg_MQ_05_Digging_Deeper_Complete,
    [6] = gg_trg_MQ_06_Scourge_Pocket_Complete,
    [8] = gg_trg_MQ_08_Missing_Forsaken_Complete,
    [9] = gg_trg_MQ_09_Silverhand_Attack_Complete,
    [10] = gg_trg_MQ_10_Remnants_of_SH_Completed
  }
  local titles = {
    [1] = udg_MQSecondChanceTitle,
    [2] = udg_MQForsakenWorkersTitle,
    [3] = udg_MQApotSupplyTitle,
    [4] = udg_MQSecureQuarryTitle,
    [5] = udg_MQDiggingDeeperTitle,
    [6] = udg_MQScourgePocketTitle,
    [8] = udg_MQMissingForsakenTitle,
    [9] = udg_MQSilverhandAttackTitle,
    [10] = udg_MQRemnantsSilverhandTitle
  }
  local i = 1
  local found = 0
  local q
  local id
  while ((i <= 9) and (found == 0)) do
    id = ids[i]
    q = quests[id]
    if ((q == nil) or (IsQuestCompleted(q) ~= true)) then
      found = id
    end
    i = (i + 1)
  end
  if (found == 0) then
    IB_Message(p, "All main quests are already completed.")
  else
    ConditionalTriggerExecute(triggers[found])
    IB_Message(p, __cat("Completed main quest: ", titles[found], " [", I2S(found), "]"))
  end
  q = nil
end
-- @jass 1612
function IB_OnChat()
"""
    data = replace_once(data, function_old, function_new)

    command_old = """  elseif IB_StrEqCI(cmd, "fingertest2") then
    IB_FingerAddTest2(p)
  elseif IB_StrEqCI(cmd, "unpause") then
"""
    command_new = """  elseif IB_StrEqCI(cmd, "fingertest2") then
    IB_FingerAddTest2(p)
  elseif IB_StrEqCI(cmd, "mq") then
    IB_CompleteNextMainQuest(p)
  elseif IB_StrEqCI(cmd, "unpause") then
"""
    data = replace_once(data, command_old, command_new)

    registration_old = """    TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
    TriggerRegisterPlayerChatEvent(t, Player(i), "unpause", false)
    i = (i + 1)
"""
    registration_new = """    TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
    TriggerRegisterPlayerChatEvent(t, Player(i), "unpause", false)
    TriggerRegisterPlayerChatEvent(t, Player(i), "mq", false)
    i = (i + 1)
"""
    data = replace_once(data, registration_old, registration_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_next_main_quest.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)

    archive = war3mpq.MPQArchive(source)
    try:
        lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not lua:
        raise SystemExit("war3map.lua is missing")

    updated = patch_lua(lua)
    mpq_patch.patch(
        source,
        [("war3map.lua", updated)],
        out_path=destination,
        backup=False,
    )
    check = war3mpq.MPQArchive(destination)
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise SystemExit("war3map.lua read-back mismatch")
    print("built", destination, "lua", len(lua), "->", len(updated))


if __name__ == "__main__":
    main()
