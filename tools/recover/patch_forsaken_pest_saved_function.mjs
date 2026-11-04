#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import {
  luaFrame,
  parseEris,
  setLuaLengths,
  splice,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";
import {
  ChunkReader,
  constantListInfo,
  graphGlobals,
  inlineConstants,
} from "./patch_forsaken_save2.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const TARGET = "Trig_Plague_Rats_Size_Actions";
const LUAC = path.resolve(
  "tools/recover/luac-src/package/deps/lua-5.3.3/src/luac.exe",
);
const SOURCE = path.resolve(
  "tools/recover/forsaken_pest_nest_death.lua",
);

function find(data, needle) {
  for (let position = data.indexOf(needle[0]);
    position >= 0;
    position = data.indexOf(needle[0], position + 1)) {
    if (needle.every((value, index) => data[position + index] === value)) {
      return position;
    }
  }
  return -1;
}

function u32(data, offset) {
  return new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength
  ).getUint32(offset, true);
}

function compileTarget() {
  const output = path.resolve(
    "tools/recover/_forsaken_pest_nest_death.luac",
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

function padOrTrimToOriginalSize(patched, originalSize) {
  if (patched.length === originalSize) {
    return { bytes: patched, delta: 0, trimmed: 0, padded: 0 };
  }
  if (patched.length < originalSize) {
    const padded = new Uint8Array(originalSize);
    padded.set(patched);
    return {
      bytes: padded,
      delta: patched.length - originalSize,
      trimmed: 0,
      padded: originalSize - patched.length,
    };
  }
  const excess = patched.length - originalSize;
  const trailing = patched.subarray(patched.length - excess);
  if (!trailing.every((value) => value === 0)) {
    throw new Error(
      `patched Lua grows by ${excess} bytes and has no trailing padding`,
    );
  }
  return {
    bytes: patched.subarray(0, originalSize),
    delta: excess,
    trimmed: excess,
    padded: 0,
  };
}

function put32(data, offset, value) {
  new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength
  ).setUint32(offset, value >>> 0, true);
}

function tokenSize(data, position) {
  const tag = u32(data, position);
  if (tag === 0) return 1;
  if (tag === 1) return 5;
  if (tag === 2) return 12;
  if (tag === 3) return 9;
  if (tag === 4) {
    return 12 + Number(new DataView(
      data.buffer,
      data.byteOffset,
      data.byteLength
    ).getBigUint64(position + 4, true));
  }
  if (tag > 14) return 4;
  throw new Error(`unsupported constant token ${tag} at ${position}`);
}

function tokenValue(data, graph, position) {
  const tag = u32(data, position);
  if (tag === 0) return { kind: "nil" };
  if (tag === 1) {
    return { kind: "boolean", value: data[position + 4] };
  }
  if (tag === 2) {
    return {
      kind: "float",
      value: new DataView(
        data.buffer,
        data.byteOffset,
        data.byteLength
      ).getFloat64(position + 4, true),
    };
  }
  if (tag === 3) {
    return {
      kind: "number-bits",
      bits: u32(data, position + 5),
      integer: data[position + 4],
    };
  }
  if (tag === 4) {
    const size = Number(new DataView(
      data.buffer,
      data.byteOffset,
      data.byteLength
    ).getBigUint64(position + 4, true));
    return {
      kind: "string",
      value: Buffer.from(data.subarray(position + 12, position + 12 + size))
        .toString("utf8"),
    };
  }
  if (tag > 14) {
    const node = graph.refs[tag - 14];
    if (node?.tag === 4) {
      return {
        kind: "string",
        value: Buffer.from(data.subarray(node.text, node.text + node.size))
          .toString("utf8"),
      };
    }
    if (node?.tag === 3) {
      return {
        kind: "number-bits",
        bits: node.value >>> 0,
        integer: node.boolean,
      };
    }
    if (node?.tag === 1) {
      return { kind: "boolean", value: node.value };
    }
  }
  return { kind: "reference", ref: tag - 14 };
}

function sameConstant(left, right) {
  if (left.kind === "float") {
    const bits = Buffer.alloc(4);
    bits.writeFloatLE(left.value, 0);
    return right.kind === "number-bits" &&
      right.bits === bits.readUInt32LE(0);
  }
  if (left.kind === "integer") {
    return right.kind === "number-bits" &&
      right.integer === 1 &&
      right.bits === (left.value >>> 0);
  }
  if (left.kind === "boolean") {
    return right.kind === "boolean" &&
      left.value === right.value;
  }
  if (left.kind === "string") {
    return right.kind === "string" &&
      left.value === right.value;
  }
  return left.kind === right.kind &&
    left.kind === "nil";
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

function patchFunction(original, graph, globals, compiled) {
  const wrapper = globals.get(TARGET);
  if (!wrapper || wrapper.tag !== 6 || wrapper.proto?.tag !== 9) {
    throw new Error(`saved function not found: ${TARGET}`);
  }
  if (wrapper.upvalues !== compiled.upvalueCount) {
    throw new Error(
      `saved function upvalue count changed: ` +
      `${wrapper.upvalues} -> ${compiled.upvalueCount}`,
    );
  }
  if (compiled.protos.length !== 0) {
    throw new Error("replacement unexpectedly has child functions");
  }
  const proto = wrapper.proto;
  const codeCountPosition = proto.code - 4;
  const constantCountPosition = proto.code + proto.codeSize;
  const oldCount = u32(original, constantCountPosition);
  if (oldCount !== proto.constants.length) {
    throw new Error("saved constant count is inconsistent");
  }
  const oldInfo = constantListInfo(
    original,
    constantCountPosition + 4,
    oldCount,
  );
  if (oldInfo.end > proto.lineInfoCountPosition) {
    throw new Error("constant list overlaps function debug information");
  }

  const oldTokens = [];
  const oldValues = [];
  for (let position = constantCountPosition + 4;
    position < oldInfo.end;) {
    const size = tokenSize(original, position);
    oldTokens.push(Buffer.from(original.subarray(position, position + size)));
    oldValues.push(tokenValue(original, graph, position));
    position += size;
  }
  if (oldTokens.length !== oldCount) {
    throw new Error("constant token count is inconsistent");
  }

  const appended = [];
  const appendedValues = [];
  const constants = [...oldTokens];
  const mapping = [];
  for (const constant of compiled.constants) {
    let index = oldValues.findIndex((value) => sameConstant(constant, value));
    if (index < 0) {
      const appendedIndex = appendedValues.findIndex(
        (value) => sameConstant(constant, value),
      );
      if (appendedIndex >= 0) {
        index = oldCount + appendedIndex;
      } else {
        index = constants.length;
        const token = constant.kind === "nil"
          ? Buffer.alloc(4)
          : Buffer.from(inlineConstants(original, constant));
        constants.push(token);
        appendedValues.push(constant);
        appended.push({ index, constant, length: token.length });
      }
    }
    mapping.push(index);
  }
  if (mapping.some((index) => index > 0xff)) {
    throw new Error("constant index exceeds RK operand range");
  }

  const code = remapConstants(compiled.code, mapping);
  const replacement = Buffer.alloc(
    8 + code.length + constants.reduce((sum, token) => sum + token.length, 0),
  );
  replacement.writeInt32LE(code.length / 4, 0);
  code.copy(replacement, 4);
  replacement.writeInt32LE(constants.length, 4 + code.length);
  let writePosition = 8 + code.length;
  for (const token of constants) {
    token.copy(replacement, writePosition);
    writePosition += token.length;
  }

  const insertionPoint = oldInfo.end;
  const objectsBeforeInsertion = graph.refs.filter(
    (node) => node && node.start < insertionPoint,
  ).length;
  const insertionCount = appended.filter(
    (item) => item.constant.kind === "string",
  ).length;
  const edits = [{
    offset: codeCountPosition,
    remove: oldInfo.end - codeCountPosition,
    bytes: replacement,
  }];
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

  const work = original.slice();
  if (insertionCount > 0) {
    for (let index = 0; index < graph.usePositions.length; index++) {
      const usePosition = graph.usePositions[index];
      const usedRef = graph.useRefs[index];
      if (usePosition >= codeCountPosition &&
          usePosition < oldInfo.end) {
        continue;
      }
      if (usePosition >= insertionPoint &&
          usedRef > objectsBeforeInsertion) {
        put32(work, usePosition, usedRef + insertionCount + 14);
      }
    }
  }
  edits.sort((left, right) => left.offset - right.offset);
  const patched = splice(work, edits);
  return {
    patched,
    delta: patched.length - original.length,
    code,
    constants,
    oldInstructions: proto.codeSize / 4,
    newInstructions: code.length / 4,
    oldConstants: oldCount,
    newConstants: constants.length,
    appended,
    insertedObjects: insertionCount,
    objectsBeforeInsertion,
    mapping,
  };
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    throw new Error(
      "usage: patch_forsaken_pest_saved_function.mjs INPUT.raw.bin OUTPUT.raw.bin",
    );
  }
  const original = new Uint8Array(fs.readFileSync(input));
  const eris = find(original, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const frame = luaFrame(original, eris, u32(original, eris - 4));
  const graph = parseEris(original, eris);
  const globals = graphGlobals(original, graph);
  const compiled = compileTarget();
  const patchedFunction = patchFunction(
    original,
    graph,
    globals,
    compiled,
  );
  const functionPatched = patchedFunction.patched;
  const delta = patchedFunction.delta;
  setLuaLengths(functionPatched, frame, graph.end - eris + delta);
  const normalized = padOrTrimToOriginalSize(functionPatched, original.length);

  const patchedFrame = luaFrame(
    normalized.bytes,
    eris,
    u32(normalized.bytes, eris - 4),
  );
  const patchedGraph = parseEris(normalized.bytes, eris);
  if (patchedGraph.refs.length !==
      graph.refs.length + patchedFunction.insertedObjects) {
    throw new Error(
      "saved Lua object count changed unexpectedly: " +
      `${graph.refs.length} -> ${patchedGraph.refs.length}`,
    );
  }
  if (JSON.stringify(patchedFrame.waitIds) !== JSON.stringify(frame.waitIds)) {
    throw new Error("saved pending trigger waits changed");
  }
  const verifiedFunction = graphGlobals(
    normalized.bytes,
    patchedGraph,
  ).get(TARGET);
  if (!verifiedFunction?.proto ||
      verifiedFunction.proto.codeSize !== compiled.code.length) {
    throw new Error("patched saved function did not round-trip");
  }
  const code = Buffer.from(
    normalized.bytes.subarray(
      verifiedFunction.proto.code,
      verifiedFunction.proto.code + verifiedFunction.proto.codeSize,
    ),
  );
  if (!code.equals(patchedFunction.code)) {
    throw new Error("patched saved function bytecode differs");
  }

  fs.writeFileSync(output, normalized.bytes);
  console.log(JSON.stringify({
    input,
    output,
    target: TARGET,
    originalInstructions: patchedFunction.oldInstructions,
    newInstructions: patchedFunction.newInstructions,
    originalConstants: patchedFunction.oldConstants,
    newConstants: patchedFunction.newConstants,
    insertedObjects: patchedFunction.insertedObjects,
    appendedConstants: patchedFunction.appended,
    luaDelta: delta,
    trimmed: normalized.trimmed,
    padded: normalized.padded,
    outputBytes: normalized.bytes.length,
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
