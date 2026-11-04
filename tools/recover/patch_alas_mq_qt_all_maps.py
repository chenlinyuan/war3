#!/usr/bin/env python3
"""Add mq/qt chat commands to every chapter map in the Alas campaign."""

import hashlib
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_MQ_QT_ALL_MAPS_V1"
MAP_SUFFIXES = (".w3x", ".w3m")


def replace_once(data, old, new):
    if isinstance(data, bytes):
        old_bytes = old.encode("utf-8")
        new_bytes = new.encode("utf-8")
    else:
        old_bytes = old
        new_bytes = new
    count = data.count(old_bytes)
    if count != 1:
        raise RuntimeError(f"expected exactly one match, found {count}")
    return data.replace(old_bytes, new_bytes, 1)


def act1_adapter():
    return """function ALAS_MQ_Handle(p)
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
    [1] = gg_trg_Debug_MQ_01_SC_Complete_Quest,
    [2] = gg_trg_Debug_MQ_02_FW_Complete_Quest,
    [3] = gg_trg_Debug_MQ_03_AS_Complete_Quest,
    [4] = gg_trg_Debug_MQ_04_SQ_Complete_Quest,
    [5] = gg_trg_Debug_MQ_05_DD_Complete_Quest,
    [6] = gg_trg_Debug_MQ_SP_Complete_Quest,
    [8] = gg_trg_Debug_MQ_08_MF_Complete_Quest,
    [9] = gg_trg_Debug_MQ_09_SA_Complete_Quest,
    [10] = gg_trg_Debug_MQ_10_RS_Complete_Quest
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
  local id
  local q
  local found = 0
  while i <= 9 and found == 0 do
    id = ids[i]
    q = quests[id]
    if q ~= nil and IsQuestDiscovered(q) == true and IsQuestCompleted(q) ~= true then
      found = id
    end
    i = i + 1
  end
  if found == 0 then
    ALAS_MQ_QT_Say(p, "No active unfinished main quest.")
  else
    TriggerExecute(triggers[found])
    ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", titles[found], " [", I2S(found), "]"))
  end
  q = nil
end
"""


def act2_adapter():
    return """function ALAS_MQ_Handle(p)
  local i = 1
  local q
  local found = 0
  while i <= 70 and found == 0 do
    q = udg_QJ_Quests[i]
    if q ~= nil and udg_QJ_OptionalQuest[i] ~= true and udg_QJ_Discovered[i] == true and udg_QJ_Completed[i] ~= true then
      found = i
    end
    i = i + 1
  end
  if found == 0 then
    ALAS_MQ_QT_Say(p, "No active unfinished main quest.")
  else
    local title = udg_QJ_Title[found]
    if QJ_QuestUpdate_Complete(found, true) == true then
      ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", title, " [", I2S(found), "]"))
    else
      ALAS_MQ_QT_Say(p, __cat("Failed to complete main quest [", I2S(found), "]"))
    end
    title = nil
  end
  q = nil
end
"""


def act3a_adapter():
    return """function ALAS_MQ_Handle(p)
  local q = udg_Hold_Quest
  local title
  if q ~= nil and IsQuestDiscovered(q) == true and IsQuestCompleted(q) ~= true then
    title = GetQuestTitle(q)
    TriggerExecute(gg_trg_Quest_Hold_Completed_Q)
    ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", title))
    return
  end
  q = udg_Sky_Quest
  if q ~= nil and IsQuestDiscovered(q) == true and IsQuestCompleted(q) ~= true then
    title = GetQuestTitle(q)
    TriggerExecute(gg_trg_Quest_Sky_Completed_Q)
    ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", title))
    return
  end
  ALAS_MQ_QT_Say(p, "No active unfinished main quest.")
  q = nil
end
"""


def act3b_adapter():
    return """function ALAS_MQ_Handle(p)
  local q = udg_Necro_Quest
  local title
  if q ~= nil and IsQuestDiscovered(q) == true and IsQuestCompleted(q) ~= true then
    title = GetQuestTitle(q)
    TriggerExecute(gg_trg_Quest_Necro_Completed_Q)
    ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", title))
    return
  end
  q = udg_Ascen_Quest
  if q ~= nil and IsQuestDiscovered(q) == true and IsQuestCompleted(q) ~= true then
    title = GetQuestTitle(q)
    TriggerExecute(gg_trg_Quest_Ascen_Completed_Q)
    ALAS_MQ_QT_Say(p, __cat("Completed main quest: ", title))
    return
  end
  ALAS_MQ_QT_Say(p, "No active unfinished main quest.")
  q = nil
end
"""


def no_quest_adapter():
    return """function ALAS_MQ_Handle(p)
  ALAS_MQ_QT_Say(p, "No active unfinished main quest in this map.")
end
"""


COMMON = """-- ALAS_MQ_QT_ALL_MAPS_V1
function ALAS_MQ_QT_Say(p, message)
  DisplayTextToPlayer(p, 0, 0, message)
end

function ALAS_MQ_QT_ShowMap(p)
  FogMaskEnable(false)
  FogEnable(false)
  if ALAS_MQ_QT_FOG_MODIFIER == nil then
    ALAS_MQ_QT_FOG_MODIFIER = CreateFogModifierRect(GetLocalPlayer(), FOG_OF_WAR_VISIBLE, GetEntireMapRect(), false, false)
  end
  FogModifierStart(ALAS_MQ_QT_FOG_MODIFIER)
  ALAS_MQ_QT_Say(p, "Map revealed.")
end

function ALAS_MQ_QT_OnMQ()
  ALAS_MQ_Handle(GetTriggerPlayer())
end

function ALAS_MQ_QT_OnQT()
  ALAS_MQ_QT_ShowMap(GetTriggerPlayer())
end

function ALAS_MQ_QT_Init()
  local i = 0
  ALAS_MQ_QT_MQ_TRIGGER = CreateTrigger()
  ALAS_MQ_QT_FOG_TRIGGER = CreateTrigger()
  while i < 12 do
    TriggerRegisterPlayerChatEvent(ALAS_MQ_QT_MQ_TRIGGER, Player(i), "mq", false)
    TriggerRegisterPlayerChatEvent(ALAS_MQ_QT_FOG_TRIGGER, Player(i), "qt", false)
    i = i + 1
  end
  TriggerAddAction(ALAS_MQ_QT_MQ_TRIGGER, ALAS_MQ_QT_OnMQ)
  TriggerAddAction(ALAS_MQ_QT_FOG_TRIGGER, ALAS_MQ_QT_OnQT)
end

"""


def choose_adapter(lua):
    if (
        b"gg_trg_Debug_MQ_01_SC_Complete_Quest" in lua
        and b"gg_trg_Debug_MQ_10_RS_Complete_Quest" in lua
    ):
        return "act1", act1_adapter()
    if b"function QJ_QuestUpdate_Complete(" in lua:
        return "act2", act2_adapter()
    if (
        b"udg_Hold_Quest" in lua
        and b"gg_trg_Quest_Hold_Completed_Q" in lua
        and b"gg_trg_Quest_Sky_Completed_Q" in lua
    ):
        return "act3a", act3a_adapter()
    if (
        b"udg_Necro_Quest" in lua
        and b"gg_trg_Quest_Necro_Completed_Q" in lua
        and b"gg_trg_Quest_Ascen_Completed_Q" in lua
    ):
        return "act3b", act3b_adapter()
    return "no-quest", no_quest_adapter()


def patch_lua(lua):
    if MARKER in lua:
        raise RuntimeError("mq/qt module already present")
    kind, adapter = choose_adapter(lua)
    data = replace_once(
        lua.decode("utf-8"),
        "function main()\n",
        COMMON + adapter + "\nfunction main()\n",
    )
    data = replace_once(
        data,
        "  InitCustomTriggers()\n",
        "  InitCustomTriggers()\n  ALAS_MQ_QT_Init()\n",
    )
    return kind, data.encode("utf-8")


def read_map_file(archive, name):
    return archive.read_file(name)


def main():
    if len(sys.argv) < 4 or len(sys.argv) > 5:
        raise SystemExit(
            "usage: patch_alas_mq_qt_all_maps.py "
            "INPUT_CAMPAIGN FOREST_BASELINE_MAP OUTPUT_DIR [OUTPUT_CAMPAIGN]"
        )
    campaign_path = Path(sys.argv[1]).resolve()
    forest_baseline = Path(sys.argv[2]).resolve()
    output_dir = Path(sys.argv[3]).resolve()
    output_campaign = (
        Path(sys.argv[4]).resolve()
        if len(sys.argv) == 5
        else output_dir / "alas-mq-qt.w3n"
    )
    if output_dir.exists() and any(output_dir.iterdir()):
        raise SystemExit("output directory is not empty: " + str(output_dir))
    if output_campaign.exists():
        raise SystemExit("output campaign already exists: " + str(output_campaign))

    maps_dir = output_dir / "maps"
    maps_dir.mkdir(parents=True, exist_ok=True)
    forest_data = forest_baseline.read_bytes()
    campaign = war3mpq.MPQArchive(str(campaign_path))
    replacements = []
    report = []
    try:
        map_names = [
            name for name in campaign.files()
            if name.lower().endswith(MAP_SUFFIXES)
        ]
        if len(map_names) != 15:
            raise RuntimeError(f"expected 15 chapter maps, found {len(map_names)}")
        for name in map_names:
            source_data = (
                forest_data
                if name == "UndeadRE01_03.w3x"
                else read_map_file(campaign, name)
            )
            if not source_data:
                raise RuntimeError("missing map entry: " + name)
            input_path = maps_dir / (name + ".input.w3x")
            output_path = maps_dir / name
            input_path.write_bytes(source_data)

            archive = war3mpq.MPQArchive(str(input_path))
            try:
                lua = archive.read_file("war3map.lua")
            finally:
                archive.close()
            if not lua:
                raise RuntimeError("war3map.lua missing from " + name)
            if name in ("UndeadRE01_02.w3x", "UndeadRE01_03.w3x"):
                if b"ALAS_SELECTED_UNPAUSE_V1" not in lua:
                    raise RuntimeError("unpause regression in " + name)

            kind, updated = patch_lua(lua)
            mpq_patch.patch(
                str(input_path),
                [("war3map.lua", updated)],
                out_path=str(output_path),
                backup=False,
            )
            check = war3mpq.MPQArchive(str(output_path))
            try:
                result = check.read_file("war3map.lua")
            finally:
                check.close()
            if result != updated:
                raise RuntimeError("Lua read-back mismatch in " + name)

            if b"broodfix" in updated:
                raise RuntimeError("forbidden broodfix command in " + name)
            if updated.count(MARKER) != 1:
                raise RuntimeError("marker count mismatch in " + name)
            if b"TriggerRegisterPlayerChatEvent(ALAS_MQ_QT_MQ_TRIGGER, Player(i), \"mq\", false)" not in updated:
                raise RuntimeError("mq registration missing in " + name)
            if b"TriggerRegisterPlayerChatEvent(ALAS_MQ_QT_FOG_TRIGGER, Player(i), \"qt\", false)" not in updated:
                raise RuntimeError("qt registration missing in " + name)

            data = output_path.read_bytes()
            replacements.append((name, data))
            report.append(
                {
                    "map": name,
                    "adapter": kind,
                    "map_bytes": len(data),
                    "lua_bytes": len(updated),
                    "sha256": hashlib.sha256(data).hexdigest().upper(),
                }
            )
    finally:
        campaign.close()

    mpq_patch.patch(
        str(campaign_path),
        replacements,
        out_path=str(output_campaign),
        backup=False,
        store=tuple(name for name, _ in replacements),
    )
    check = war3mpq.MPQArchive(str(output_campaign))
    try:
        for name, data in replacements:
            if check.read_file(name) != data:
                raise RuntimeError("campaign read-back mismatch: " + name)
    finally:
        check.close()

    print("built", output_campaign)
    for row in report:
        print(
            "{map}: {adapter}, map={map_bytes}, lua={lua_bytes}, sha256={sha256}".format(
                **row
            )
        )


if __name__ == "__main__":
    main()
