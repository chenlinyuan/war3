#!/usr/bin/env node

// Patch the sapper entrance callbacks in an existing Forsaken Act Two save.

import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath, pathToFileURL } from "node:url";
import { parse } from "./w3z_probe.js";
import {
  luaFrame,
  parseEris,
  setLuaLengths,
  splice,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";
import {
  ChunkReader,
  functionEdit,
  graphGlobals,
} from "./patch_forsaken_save2.mjs";

const HERE = path.dirname(fileURLToPath(import.meta.url));
const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const LUAC = path.join(
  HERE,
  "luac-src",
  "package",
  "deps",
  "lua-5.3.3",
  "src",
  "luac.exe",
);
const SOURCE = path.join(HERE, "forsaken_sapper_saved_functions.lua");
const WRITER = path.join(HERE, "write_w3z_from_raw.js");
const TARGETS = [
  "Trig_Sapper_Tunnels_Blow_Entrance_01_Actions",
  "Trig_Sapper_Tunnels_Blow_Entrance_02_Actions",
  "Trig_Sapper_Tunnels_Blow_Entrance_03_Actions",
  "Trig_Sapper_Tunnels_Explosive_Barrels_Conditions",
];

function fail(message) {
  throw new Error(message);
}

function view(data) {
  return new DataView(data.buffer, data.byteOffset, data.byteLength);
}

function u32(data, offset) {
  return view(data).getUint32(offset, true);
}

function find(data, needle, start = 0) {
  for (let position = data.indexOf(needle[0], start);
    position >= 0;
    position = data.indexOf(needle[0], position + 1)) {
    let matches = true;
    for (let index = 0; index < needle.length; index++) {
      if (data[position + index] !== needle[index]) {
        matches = false;
        break;
      }
    }
    if (matches) {
      return position;
    }
  }
  return -1;
}

function compileFunctions() {
  const output = path.join(HERE, "_forsaken_sapper_saved_functions.luac");
  const result = spawnSync(LUAC, ["-o", output, SOURCE], {
    cwd: path.resolve(HERE, "..", ".."),
    encoding: "utf8",
  });
  if (result.status !== 0) {
    fail(`luac failed: ${result.stderr || result.stdout}`);
  }
  const reader = new ChunkReader(fs.readFileSync(output), output);
  const signature = Buffer.from([0x1b, 0x4c, 0x75, 0x61]);
  if (!reader.data.subarray(0, 4).equals(signature)) {
    reader.fail("not a Lua chunk");
  }
  reader.take(33);
  reader.byte();
  const main = reader.function();
  if (main.protos.length !== TARGETS.length) {
    fail(
      `expected ${TARGETS.length} compiled functions, ` +
      `found ${main.protos.length}`,
    );
  }
  return new Map(TARGETS.map((name, index) => [name, main.protos[index]]));
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    fail("usage: patch_forsaken_sapper_saved_lua.mjs INPUT.w3z OUTPUT.w3z");
  }
  if (path.resolve(input) === path.resolve(output)) {
    fail("output must differ from input");
  }

  const source = parse(input);
  const original = Buffer.from(source.uncompressed);
  const mapEnd = original.indexOf(0);
  const mapName = original.subarray(0, mapEnd).toString("ascii");
  if (mapName.toLowerCase() !== "undeadre02.w3x") {
    fail(`expected UndeadRE02.w3x save, found ${mapName}`);
  }

  const eris = find(original, ERIS);
  if (eris < 0) {
    fail("ERIS marker not found");
  }
  const size = u32(original, eris - 4);
  const frame = luaFrame(original, eris, size);
  const graph = parseEris(original, eris);
  const globals = graphGlobals(original, graph);
  const compiled = compileFunctions();
  const edits = [];
  const reports = [];
  for (const name of TARGETS) {
    const record = functionEdit(
      original,
      graph,
      globals,
      name,
      compiled.get(name),
      Array.from(
        { length: compiled.get(name).constants.length },
        (_, index) => index,
      ),
      true,
    );
    edits.push(record.edit);
    if (record.lineInfoEdit) {
      edits.push(record.lineInfoEdit);
    }
    edits.push({
      offset: record.maxStackOffset,
      remove: 1,
      bytes: Uint8Array.of(record.maxStack),
    });
    reports.push({
      name,
      oldInstructions: record.oldInstructions,
      newInstructions: record.newInstructions,
      oldConstants: record.oldConstants,
      newConstants: record.newConstants,
      oldInlineConstants: record.oldInlineConstants,
      newInlineConstants: record.newInlineConstants,
    });
  }
  edits.sort((left, right) => left.offset - right.offset);
  const patched = splice(original, edits);
  const delta = patched.length - original.length;
  setLuaLengths(patched, frame, graph.end - eris + delta);

  const shiftedFrame = luaFrame(
    patched,
    eris,
    u32(patched, eris - 4),
  );
  const shiftedGraph = parseEris(patched, eris);
  if (shiftedGraph.end !== graph.end + delta) {
    fail(`saved Lua graph end changed unexpectedly: ${graph.end} -> ${shiftedGraph.end}`);
  }
  if (shiftedGraph.refs.length !== graph.refs.length) {
    fail(`saved Lua object count changed: ${graph.refs.length} -> ${shiftedGraph.refs.length}`);
  }
  if (JSON.stringify(shiftedFrame.waitIds) !== JSON.stringify(frame.waitIds)) {
    fail("saved pending trigger waits changed");
  }

  let outputBytes = patched;
  let trailingPaddingTrimmed = 0;
  if (delta > 0) {
    const trailing = patched.subarray(patched.length - delta);
    if (trailing.every((byte) => byte === 0)) {
      outputBytes = patched.subarray(0, patched.length - delta);
      trailingPaddingTrimmed = delta;
    }
  }
  if (outputBytes.length !== source.uncompressed.length) {
    fail(
      `patched raw size ${outputBytes.length} differs from save size ` +
      `${source.uncompressed.length}`,
    );
  }

  const rawPath = path.join(
    os.tmpdir(),
    `forsaken-sapper-saved-lua-${process.pid}.bin`,
  );
  fs.writeFileSync(rawPath, outputBytes);
  try {
    const result = spawnSync(
      process.execPath,
      [WRITER, path.resolve(input), rawPath, path.resolve(output)],
      { encoding: "utf8" },
    );
    if (result.status !== 0) {
      fail(result.stderr || result.stdout || "W3Z writer failed");
    }
  } finally {
    fs.rmSync(rawPath, { force: true });
  }

  const verification = parse(output);
  if (!verification.uncompressed.equals(outputBytes)) {
    fail("written save does not inflate to the patched raw data");
  }
  console.log(JSON.stringify({
    input: path.resolve(input),
    output: path.resolve(output),
    map: mapName,
    saveBytes: verification.archive.length,
    luaSizeDelta: delta,
    trailingPaddingTrimmed,
    pendingWaitIds: shiftedFrame.waitIds,
    functions: reports,
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
