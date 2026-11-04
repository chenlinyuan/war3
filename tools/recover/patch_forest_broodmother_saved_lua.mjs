#!/usr/bin/env node
// Patch the neutral-hostile death action inside the saved Lua graph.

import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import {
  luaFrame,
  parseEris,
  setLuaLengths,
  splice,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";
import {
  ChunkReader,
  constantListInfo,
  constantNode,
  graphGlobals,
  inlineConstants,
} from "./patch_forsaken_save2.mjs";

const ERIS = Uint8Array.from([
  69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8,
]);
const LUAC = path.resolve(
  "tools/recover/luac-src/package/deps/lua-5.3.3/src/luac.exe",
);
const SOURCE = path.resolve(
  "tools/recover/forest_broodmother_saved_action.lua",
);
const TARGET = "Trig_Brood_Mother_Group_Remove_From_Group_Actions";

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

function compileTarget() {
  const output = path.resolve(
    "tools/recover/_forest_broodmother_saved_action.luac",
  );
  const result = spawnSync(LUAC, ["-o", output, SOURCE], {
    cwd: process.cwd(),
    encoding: "utf8",
  });
  if (result.status !== 0) {
    throw new Error(`luac failed: ${result.stderr || result.stdout}`);
  }
  const reader = new ChunkReader(fs.readFileSync(output), output);
  reader.take(33);
  reader.byte();
  const main = reader.function();
  if (main.protos.length !== 1) {
    throw new Error(`expected one compiled function, found ${main.protos.length}`);
  }
  return main.protos[0];
}

function view(data) {
  return new DataView(data.buffer, data.byteOffset, data.byteLength);
}

function tokenSize(data, position) {
  const tag = view(data).getUint32(position, true);
  if (tag === 0) {
    return 1;
  }
  if (tag === 1) {
    return 5;
  }
  if (tag === 2) {
    return 12;
  }
  if (tag === 3) {
    return 9;
  }
  if (tag === 4) {
    const size = Number(view(data).getBigUint64(position + 4, true));
    return 12 + size;
  }
  if (tag > 14) {
    return 4;
  }
  throw new Error(`unsupported constant token ${tag} at ${position}`);
}

function remapConstants(code, mapping) {
  const output = Buffer.from(code);
  for (let offset = 0; offset < output.length; offset += 4) {
    let word = output.readUInt32LE(offset);
    const opcode = word & 0x3f;
    if (opcode === 6) {
      const c = (word >>> 14) & 0x1ff;
      if (c & 0x100) {
        const mapped = mapping[c & 0xff];
        word = (word & ~(0x1ff << 14)) |
          (((mapped | 0x100) & 0x1ff) << 14);
      }
    } else if (opcode === 31) {
      const b = (word >>> 23) & 0x1ff;
      const c = (word >>> 14) & 0x1ff;
      if (b & 0x100) {
        const mapped = mapping[b & 0xff];
        word = (word & ~(0x1ff << 23)) |
          (((mapped | 0x100) & 0x1ff) << 23);
      }
      if (c & 0x100) {
        const mapped = mapping[c & 0xff];
        word = (word & ~(0x1ff << 14)) |
          (((mapped | 0x100) & 0x1ff) << 14);
      }
    } else if (opcode === 1) {
      const bx = (word >>> 14) & 0x3ffff;
      word = (word & ~(0x3ffff << 14)) |
        (mapping[bx] << 14);
    }
    output.writeUInt32LE(word >>> 0, offset);
  }
  return output;
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    throw new Error(
      "usage: patch_forest_broodmother_saved_lua.mjs INPUT.raw.bin OUTPUT.raw.bin",
    );
  }
  const original = new Uint8Array(fs.readFileSync(input));
  const eris = find(original, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const frame = luaFrame(original, eris, new DataView(
    original.buffer,
    original.byteOffset,
    original.byteLength,
  ).getUint32(eris - 4, true));
  const graph = parseEris(original, eris);
  const globals = graphGlobals(original, graph);
  const compiled = compileTarget();
  const wrapper = globals.get(TARGET);
  if (!wrapper || wrapper.tag !== 6 || wrapper.proto?.tag !== 9) {
    throw new Error(`saved function not found: ${TARGET}`);
  }
  if (wrapper.upvalues !== compiled.upvalueCount) {
    throw new Error("saved function upvalue count changed");
  }
  if (compiled.protos.length !== 0) {
    throw new Error("replacement unexpectedly has child functions");
  }
  const proto = wrapper.proto;
  const codeCountPosition = proto.code - 4;
  const constantCountPosition = proto.code + proto.codeSize;
  const oldConstantCount = view(original).getInt32(
    constantCountPosition,
    true,
  );
  if (oldConstantCount !== proto.constants.length) {
    throw new Error("saved constant count is inconsistent");
  }
  const oldConstantInfo = constantListInfo(
    original,
    constantCountPosition + 4,
    oldConstantCount,
  );
  const inlineTokens = [];
  for (let position = constantCountPosition + 4;
    position < oldConstantInfo.end;) {
    const size = tokenSize(original, position);
    const tag = view(original).getUint32(position, true);
    if (tag === 0 || tag === 1 || tag === 2 || tag === 3 || tag === 4) {
      inlineTokens.push(Buffer.from(original.subarray(position, position + size)));
    }
    position += size;
  }
  if (inlineTokens.length !== oldConstantInfo.defined) {
    throw new Error("saved inline constant count is inconsistent");
  }
  if (inlineTokens.length !== 1) {
    throw new Error(
      `expected one saved inline helper constant, found ${inlineTokens.length}`,
    );
  }
  const helperToken = inlineTokens[0];
  const insertionPoint = constantCountPosition + 4 + helperToken.length;
  const newObjectRef = graph.refs.filter(
    (node) => node && node.start < insertionPoint,
  ).length;

  const desired = new Map([
    ["GroupRemoveUnitSimple", 1],
    ["GetDyingUnit", 2],
    ["udg_BossBroodMotherGroup", 3],
    ["ConditionalTriggerExecute", 4],
  ]);
  const mapping = [];
  for (let index = 0; index < compiled.constants.length; index++) {
    const constant = compiled.constants[index];
    if (constant.value === "gg_trg_Brood_Mother_Death") {
      continue;
    }
    if (!desired.has(constant.value)) {
      throw new Error(`unexpected compiled constant ${constant.value}`);
    }
    mapping[index] = desired.get(constant.value);
  }

  const constants = [helperToken];
  for (const [value, targetIndex] of desired) {
    const node = constantNode(
      graph,
      original,
      { kind: "string", value },
      codeCountPosition,
    );
    if (!node) {
      throw new Error(
        `no saved string object for replacement constant ${value}`,
      );
    }
    const reference = Buffer.alloc(4);
    const storedRef = node.start >= insertionPoint ? node.ref + 1 : node.ref;
    reference.writeUInt32LE(storedRef + 14, 0);
    if (constants.length !== targetIndex) {
      throw new Error(
        `replacement constant order mismatch for ${value}: ` +
        `${constants.length} != ${targetIndex}`,
      );
    }
    constants.push(reference);
  }
  constants.push(inlineConstants(original, {
    kind: "string",
    value: "gg_trg_Brood_Mother_Death",
  }));
  const ggIndex = constants.length - 1;
  const ggCompiledIndex = compiled.constants.findIndex(
    (constant) => constant.value === "gg_trg_Brood_Mother_Death",
  );
  if (ggCompiledIndex < 0) {
    throw new Error("compiled gg trigger constant not found");
  }
  mapping[ggCompiledIndex] = ggIndex;
  const code = remapConstants(compiled.code, mapping);

  const replacement = Buffer.alloc(
    8 + code.length +
    constants.reduce((sum, item) => sum + item.length, 0),
  );
  replacement.writeInt32LE(code.length / 4, 0);
  code.copy(replacement, 4);
  replacement.writeInt32LE(
    constants.length,
    4 + code.length,
  );
  let writePosition = 8 + code.length;
  for (const constant of constants) {
    constant.copy(replacement, writePosition);
    writePosition += constant.length;
  }

  const edits = [{
    offset: codeCountPosition,
    remove: oldConstantInfo.end - codeCountPosition,
    bytes: replacement,
  }];
  for (let index = 0; index < graph.useRefs.length; index++) {
    const usedRef = graph.useRefs[index];
    const usePosition = graph.usePositions[index];
    if (
      usePosition >= constantCountPosition + 4 &&
      usePosition < oldConstantInfo.end
    ) {
      continue;
    }
    if (usedRef >= newObjectRef) {
      const reference = Buffer.alloc(4);
      reference.writeUInt32LE(usedRef + 1 + 14, 0);
      edits.push({
        offset: usePosition,
        remove: 4,
        bytes: reference,
      });
    }
  }
  if (proto.lineInfoCountPosition != null) {
    const lineInfo = Buffer.alloc(4 + compiled.lineInfo.length * 4);
    lineInfo.writeInt32LE(compiled.lineInfo.length, 0);
    for (let index = 0; index < compiled.lineInfo.length; index++) {
      lineInfo.writeInt32LE(compiled.lineInfo[index], 4 + index * 4);
    }
    edits.push({
      offset: proto.lineInfoCountPosition,
      remove: 4 + proto.lineInfoCount * 4,
      bytes: lineInfo,
    });
  }
  edits.push({
    offset: proto.start + 14,
    remove: 1,
    bytes: Uint8Array.of(compiled.maxStack),
  });
  edits.sort((left, right) => left.offset - right.offset);
  const patched = splice(original, edits);
  const delta = patched.length - original.length;
  setLuaLengths(patched, frame, graph.end - eris + delta);

  const verifiedGraph = parseEris(patched, eris);
  if (verifiedGraph.refs.length !== graph.refs.length + 1) {
    throw new Error(
      `saved Lua object count changed unexpectedly: ` +
      `${graph.refs.length} -> ${verifiedGraph.refs.length}`,
    );
  }
  const verified = graphGlobals(patched, verifiedGraph).get(TARGET);
  if (verified?.proto?.codeSize !== code.length) {
    throw new Error("patched instruction count did not round-trip");
  }
  const verifiedCode = Buffer.from(
    patched.subarray(
      verified.proto.code,
      verified.proto.code + verified.proto.codeSize,
    ),
  );
  if (!verifiedCode.equals(code)) {
    throw new Error("patched bytecode did not round-trip");
  }
  fs.writeFileSync(output, patched);
  console.log(JSON.stringify({
    input,
    output,
    eris,
    oldInstructions: proto.codeSize / 4,
    newInstructions: compiled.code.length / 4,
    oldConstants: oldConstantCount,
    newConstants: constants.length,
    oldInlineConstants: oldConstantInfo.defined,
    newInlineConstants: 2,
    delta,
    outputBytes: patched.length,
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
