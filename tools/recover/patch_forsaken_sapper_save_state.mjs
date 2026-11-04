#!/usr/bin/env node

// Migrate only the Closing the Breach quest state in a Forsaken Act Two save.
// The save must already be rebound to the current campaign map identity.

import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { parse } from "./w3z_probe.js";
import {
  parseEris,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const QUEST = 4;
const WRITER = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)),
  "write_w3z_from_raw.js",
);

function fail(message) {
  throw new Error(message);
}

function find(data, needle, start = 0) {
  for (let pos = data.indexOf(needle[0], start);
    pos >= 0;
    pos = data.indexOf(needle[0], pos + 1)) {
    let same = true;
    for (let index = 0; index < needle.length; index++) {
      if (data[pos + index] !== needle[index]) {
        same = false;
        break;
      }
    }
    if (same) {
      return pos;
    }
  }
  return -1;
}

function fields(raw, table) {
  if (table?.tag !== 5 || !table.pairs) {
    return new Map();
  }
  return new Map(
    table.pairs.map(([key, value]) => [text(raw, key), value])
  );
}

function globals(raw) {
  const eris = find(raw, ERIS);
  if (eris < 0) {
    fail("ERIS marker not found");
  }
  const graph = parseEris(raw, eris);
  const root = fields(raw, graph.refs[1]);
  const loaded = fields(raw, root.get("_LOADED"));
  return fields(raw, loaded.get("_G"));
}

function arrayValue(global, name, index) {
  const table = global.get(name);
  if (table?.tag !== 5 || !table.pairs) {
    fail(`saved global is not a table: ${name}`);
  }
  const entry = table.pairs.find(
    ([key]) => key.tag === 3 && key.value === index
  );
  if (!entry) {
    fail(`saved table ${name} has no index ${index}`);
  }
  return entry[1];
}

function setBoolean(raw, global, name, index, value) {
  const node = arrayValue(global, name, index);
  if (node.tag !== 1) {
    fail(`${name}[${index}] is not a boolean`);
  }
  raw[node.valueOffset] = value ? 1 : 0;
}

function setInteger(raw, global, name, index, value) {
  const node = arrayValue(global, name, index);
  if (node.tag !== 3 || value < 0 || value > 127) {
    fail(`${name}[${index}] cannot be stored as a small integer`);
  }
  raw[node.valueOffset] = value;
}

function verify(raw) {
  const global = globals(raw);
  const integer = arrayValue(global, "udg_QJ_ReqNumberedCurrent_01", QUEST);
  const req1 = arrayValue(global, "udg_QJ_ReqCompleted_01", QUEST);
  const req2 = arrayValue(global, "udg_QJ_ReqCompleted_02", QUEST);
  const hidden2 = arrayValue(global, "udg_QJ_QuestReqHidden_02", QUEST);
  const revealed2 = arrayValue(global, "udg_QJ_QuestReqRevealed_02", QUEST);
  const completed = arrayValue(global, "udg_QJ_Completed", QUEST);
  const discovered = arrayValue(global, "udg_QJ_Discovered", QUEST);
  if (
    integer.value !== 3 ||
    req1.value !== 1 ||
    req2.value !== 0 ||
    hidden2.value !== 0 ||
    revealed2.value !== 1 ||
    completed.value !== 0 ||
    discovered.value !== 1
  ) {
    fail("sapper quest state did not verify after patching");
  }
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    fail("usage: patch_forsaken_sapper_save_state.mjs INPUT.w3z OUTPUT.w3z");
  }
  if (path.resolve(input) === path.resolve(output)) {
    fail("output must differ from input");
  }

  const source = parse(input);
  const raw = Buffer.from(source.uncompressed);
  const mapEnd = raw.indexOf(0);
  const mapName = raw.subarray(0, mapEnd).toString("ascii");
  if (mapName.toLowerCase() !== "undeadre02.w3x") {
    fail(`expected UndeadRE02.w3x save, found ${mapName}`);
  }

  const global = globals(raw);
  const current = arrayValue(
    global,
    "udg_QJ_ReqNumberedCurrent_01",
    QUEST,
  ).value;
  const req1 = arrayValue(global, "udg_QJ_ReqCompleted_01", QUEST).value;
  if (current > 3 || (current === 3 && req1 !== 1)) {
    fail(`unexpected existing sapper state: count=${current} req1=${req1}`);
  }

  setInteger(raw, global, "udg_QJ_ReqNumberedCurrent_01", QUEST, 3);
  setBoolean(raw, global, "udg_QJ_ReqCompleted_01", QUEST, true);
  setBoolean(raw, global, "udg_QJ_ReqCompleted_02", QUEST, false);
  setBoolean(raw, global, "udg_QJ_QuestReqHidden_02", QUEST, false);
  setBoolean(raw, global, "udg_QJ_QuestReqRevealed_02", QUEST, true);
  setBoolean(raw, global, "udg_QJ_Completed", QUEST, false);
  setBoolean(raw, global, "udg_QJ_Discovered", QUEST, true);
  const enabled = arrayValue(global, "udg_QJ_Enabled", QUEST);
  if (enabled.tag === 1) {
    raw[enabled.valueOffset] = 1;
  }
  const qmIndex = global.get("udg_QM_Index");
  if (qmIndex?.tag === 3 && qmIndex.value >= 0 && qmIndex.value <= 127) {
    raw[qmIndex.valueOffset] = QUEST;
  }
  verify(raw);

  const temp = path.join(
    os.tmpdir(),
    `forsaken-sapper-state-${process.pid}.bin`,
  );
  fs.writeFileSync(temp, raw);
  try {
    const result = spawnSync(
      process.execPath,
      [WRITER, path.resolve(input), temp, path.resolve(output)],
      { encoding: "utf8" },
    );
    if (result.status !== 0) {
      fail(result.stderr || result.stdout || "W3Z writer failed");
    }
  } finally {
    fs.rmSync(temp, { force: true });
  }

  const verification = parse(output);
  verify(Buffer.from(verification.uncompressed));
  console.log(JSON.stringify({
    input: path.resolve(input),
    output: path.resolve(output),
    map: mapName,
    previousCount: current,
    count: 3,
    returnToBerndVisible: true,
    questCompleted: false,
    bytes: verification.archive.length,
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
