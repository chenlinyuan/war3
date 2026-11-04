#!/usr/bin/env node
// Patch the saved Lua state used by The Forsaken chapter's second checkpoint.

import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { pathToFileURL } from "node:url";
import {
  luaFrame,
  parseEris,
  setLuaLengths,
  splice,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const LUAC = path.resolve(
  "tools/recover/luac-src/package/deps/lua-5.3.3/src/luac.exe",
);
const LUA_SOURCE = path.resolve(
  "tools/recover/forsaken_save2_function_rewrites.lua",
);

const FUNCTION_TARGETS = [
  "Trig_Darkhound_Blood_Drop_Conditions",
  "Trig_Brood_Mother_90_Create_Web_Func002Func003Func002A",
];
const FORCED_INLINE_CONSTANTS = new Map([
  ["Trig_Darkhound_Blood_Drop_Conditions", [7]],
  ["Trig_Brood_Mother_90_Create_Web_Func002Func003Func002A", [3]],
]);

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

function view(data) {
  return new DataView(data.buffer, data.byteOffset, data.byteLength);
}

function u32(data, offset) {
  return view(data).getUint32(offset, true);
}

function put32(data, offset, value) {
  view(data).setUint32(offset, value >>> 0, true);
}

function fourCC(value) {
  return Buffer.from(value, "ascii").readUInt32LE(0);
}

function stringFields(data, table) {
  if (table?.tag !== 5 || !table.pairs) {
    return new Map();
  }
  return new Map(
    table.pairs
      .filter(([key]) => key.tag === 4)
      .map(([key, value]) => [text(data, key), value]),
  );
}

export function graphGlobals(data, graph) {
  const root = stringFields(data, graph.refs[1]);
  const loaded = stringFields(data, root.get("_LOADED"));
  return stringFields(data, loaded.get("_G"));
}

export class ChunkReader {
  constructor(data, source) {
    this.data = Buffer.from(data);
    this.source = source;
    this.view = view(this.data);
    this.position = 0;
  }

  fail(message) {
    throw new Error(`${this.source} at ${this.position}: ${message}`);
  }

  take(count) {
    if (count < 0 || this.position + count > this.data.length) {
      this.fail(`invalid read of ${count} bytes`);
    }
    const offset = this.position;
    this.position += count;
    return offset;
  }

  byte() {
    return this.data[this.take(1)];
  }

  int32() {
    return this.view.getInt32(this.take(4), true);
  }

  int64() {
    const offset = this.take(8);
    if (this.view.getInt32(offset + 4, true) !== 0) {
      this.fail("unsupported 64-bit integer");
    }
    return this.view.getUint32(offset, true);
  }

  float64() {
    return this.view.getFloat64(this.take(8), true);
  }

  string() {
    let size = this.byte();
    if (size === 0) {
      return null;
    }
    if (size === 0xff) {
      size = this.int64();
    }
    const offset = this.take(size - 1);
    return this.data.toString("utf8", offset, offset + size - 1);
  }

  function(parentSource = null) {
    const source = this.string() ?? parentSource;
    const lineDefined = this.int32();
    const lastLineDefined = this.int32();
    const numParams = this.byte();
    const isVararg = this.byte();
    const maxStack = this.byte();
    const codeCount = this.int32();
    const codeOffset = this.take(codeCount * 4);
    const code = Buffer.from(this.data.subarray(codeOffset, codeOffset + codeCount * 4));
    const constantCount = this.int32();
    const constants = [];
    for (let index = 0; index < constantCount; index++) {
      const tag = this.byte();
      if (tag === 0) {
        constants.push({kind: "nil"});
      } else if (tag === 1) {
        constants.push({kind: "boolean", value: this.byte()});
      } else if (tag === 3) {
        constants.push({kind: "float", value: this.float64()});
      } else if (tag === 19) {
        constants.push({kind: "integer", value: this.int64()});
      } else if (tag === 4 || tag === 20) {
        constants.push({kind: "string", value: this.string()});
      } else {
        this.fail(`unsupported constant tag ${tag}`);
      }
    }
    const upvalueCount = this.int32();
    this.take(upvalueCount * 2);
    const protoCount = this.int32();
    const protos = [];
    for (let index = 0; index < protoCount; index++) {
      protos.push(this.function(source));
    }
    const lineInfoCount = this.int32();
    const lineInfoOffset = this.take(lineInfoCount * 4);
    const lineInfo = [];
    for (let index = 0; index < lineInfoCount; index++) {
      lineInfo.push(
        this.view.getInt32(lineInfoOffset + index * 4, true),
      );
    }
    const localCount = this.int32();
    for (let index = 0; index < localCount; index++) {
      this.string();
      this.take(8);
    }
    const upvalueNameCount = this.int32();
    for (let index = 0; index < upvalueNameCount; index++) {
      this.string();
    }
    return {
      source,
      lineDefined,
      lastLineDefined,
      numParams,
      isVararg,
      maxStack,
      code,
      constants,
      lineInfo,
      upvalueCount,
      protos,
    };
  }
}

function compileRewritePrototypes() {
  const output = path.resolve("tools/recover/_forsaken_save2_rewrites.luac");
  const result = spawnSync(LUAC, ["-o", output, LUA_SOURCE], {
    cwd: process.cwd(),
    encoding: "utf8",
  });
  if (result.status !== 0) {
    throw new Error(`luac failed: ${result.stderr || result.stdout}`);
  }
  const reader = new ChunkReader(fs.readFileSync(output), output);
  const signature = Buffer.from([0x1b, 0x4c, 0x75, 0x61]);
  if (!reader.data.subarray(0, 4).equals(signature)) {
    reader.fail("not a Lua chunk");
  }
  // Lua 5.3.3 header, followed by the main chunk's upvalue count.
  reader.take(33);
  reader.byte();
  const main = reader.function();
  if (main.protos.length !== FUNCTION_TARGETS.length) {
    throw new Error(
      `expected ${FUNCTION_TARGETS.length} compiled rewrites, ` +
      `found ${main.protos.length}`,
    );
  }
  return new Map(
    FUNCTION_TARGETS.map((name, index) => [name, main.protos[index]]),
  );
}

export function constantNode(graph, data, constant, before) {
  const floatWord = constant.kind === "float"
    ? (() => {
      const bytes = Buffer.alloc(4);
      bytes.writeFloatLE(constant.value, 0);
      return bytes.readUInt32LE(0);
    })()
    : 0;
  const matches = graph.refs.filter((node) => {
    if (!node || node.start >= before) {
      return false;
    }
    if (constant.kind === "string") {
      return node.tag === 4 && text(data, node) === constant.value;
    }
    if (constant.kind === "integer") {
      return node.tag === 3 && node.boolean === 1 &&
        node.value === (constant.value >>> 0);
    }
    if (constant.kind === "float") {
      return node.tag === 3 && node.boolean === 0 &&
        node.value === floatWord;
    }
    if (constant.kind === "boolean") {
      return node.tag === 1 && node.value === constant.value;
    }
    return false;
  });
  return matches.at(-1) ?? null;
}

export function inlineConstants(data, constant) {
  if (constant.kind === "boolean") {
    return Buffer.from([1, 0, 0, 0, constant.value]);
  }
  if (constant.kind === "integer") {
    const output = Buffer.alloc(9);
    output.writeUInt32LE(3, 0);
    output[4] = 1;
    output.writeUInt32LE(constant.value >>> 0, 5);
    return output;
  }
  if (constant.kind === "float") {
    const output = Buffer.alloc(9);
    output.writeUInt32LE(3, 0);
    output[4] = 0;
    output.writeFloatLE(constant.value, 5);
    return output;
  }
  if (constant.kind === "string") {
    const bytes = Buffer.from(constant.value, "utf8");
    const output = Buffer.alloc(12 + bytes.length);
    output.writeUInt32LE(4, 0);
    output.writeUInt32LE(bytes.length, 4);
    output.writeUInt32LE(0, 8);
    bytes.copy(output, 12);
    return output;
  }
  throw new Error(`cannot inline ${constant.kind}`);
}

export function constantListInfo(data, start, constantCount) {
  let position = start;
  let defined = 0;
  for (let index = 0; index < constantCount; index++) {
    const tag = u32(data, position);
    if (tag === 0) {
      position++;
    } else if (tag === 1) {
      defined++;
      position += 5;
    } else if (tag === 2) {
      defined++;
      position += 12;
    } else if (tag === 3) {
      defined++;
      position += 9;
    } else if (tag === 4) {
      defined++;
      const size = Number(
        new DataView(data.buffer, data.byteOffset, data.byteLength)
          .getBigUint64(position + 4, true),
      );
      position += 12 + size;
    } else if (tag > 14) {
      position += 4;
    } else {
      throw new Error(`unsupported constant token ${tag} at ${position}`);
    }
  }
  return {defined, end: position};
}

export function functionEdit(
  data,
  graph,
  globals,
  name,
  compiled,
  forcedIndexes = null,
  allowExternalConstantReferences = false,
) {
  const wrapper = globals.get(name);
  if (!wrapper || wrapper.tag !== 6 || wrapper.proto?.tag !== 9) {
    throw new Error(`saved function not found: ${name}`);
  }
  const proto = wrapper.proto;
  if (wrapper.upvalues !== compiled.upvalueCount) {
    throw new Error(
      `${name}: upvalue count changed from ${wrapper.upvalues} ` +
      `to ${compiled.upvalueCount}`,
    );
  }
  if (compiled.protos.length !== 0) {
    throw new Error(`${name}: replacement unexpectedly has child functions`);
  }
  const codeCountPosition = proto.code - 4;
  const oldConstantCountPosition = proto.code + proto.codeSize;
  const oldConstantCount = view(data).getInt32(oldConstantCountPosition, true);
  if (oldConstantCount !== proto.constants.length) {
    throw new Error(`${name}: saved constant count is inconsistent`);
  }
  const oldConstantInfo = constantListInfo(
    data,
    oldConstantCountPosition + 4,
    oldConstantCount,
  );
  const oldConstantsEnd = oldConstantInfo.end;
  const oldDefinedCount = oldConstantInfo.defined;
  const removedObjectRefs = new Set(
    graph.refs
      .filter((node) =>
        node &&
        node.start >= oldConstantCountPosition + 4 &&
        node.start < oldConstantsEnd)
      .map((node) => node.ref),
  );
  for (let index = 0; index < graph.useRefs.length; index++) {
    const usePosition = graph.usePositions[index];
    const usedRef = graph.useRefs[index];
    if (
      !allowExternalConstantReferences &&
      removedObjectRefs.has(usedRef) &&
      (usePosition < oldConstantCountPosition + 4 ||
        usePosition >= oldConstantsEnd)
    ) {
      throw new Error(
        `${name}: saved Lua object ${usedRef} is referenced outside ` +
        `the replaced constant list`,
      );
    }
  }
  const forced = new Set(
    forcedIndexes ?? FORCED_INLINE_CONSTANTS.get(name) ?? [],
  );
  const constants = [];
  for (let index = 0; index < compiled.constants.length; index++) {
    const constant = compiled.constants[index];
    if (constant.kind === "nil") {
      constants.push(Buffer.from([0, 0, 0, 0]));
      continue;
    }
    if (forced.has(index)) {
      constants.push(inlineConstants(data, constant));
      continue;
    }
    const node = constantNode(graph, data, constant, codeCountPosition);
    if (!node) {
      constants.push(inlineConstants(data, constant));
      continue;
    }
    const reference = Buffer.alloc(4);
    reference.writeUInt32LE(node.ref + 14, 0);
    constants.push(reference);
  }
  let newDefinedCount = constants.filter(
    (item) => !(
      item.length === 4 &&
      (u32(item, 0) === 0 || u32(item, 0) > 14)
    ),
  ).length;
  for (let index = 0;
    newDefinedCount < oldDefinedCount &&
    index < compiled.constants.length;
    index++) {
    const constant = compiled.constants[index];
    const encoded = constants[index];
    if (constant.kind === "nil" || encoded.length !== 4) {
      continue;
    }
    constants[index] = inlineConstants(data, constant);
    newDefinedCount++;
  }
  if (newDefinedCount !== oldDefinedCount) {
    throw new Error(
      `${name}: cannot preserve saved Lua object numbering ` +
      `(old inline constants=${oldDefinedCount}, ` +
      `new inline constants=${newDefinedCount})`,
    );
  }
  const replacement = Buffer.alloc(
    8 + compiled.code.length + constants.reduce((sum, item) => sum + item.length, 0),
  );
  replacement.writeInt32LE(compiled.code.length / 4, 0);
  compiled.code.copy(replacement, 4);
  replacement.writeInt32LE(compiled.constants.length, 4 + compiled.code.length);
  let position = 8 + compiled.code.length;
  for (const constant of constants) {
    constant.copy(replacement, position);
    position += constant.length;
  }

  const maxStackOffset = proto.start + 4 + 10;
  let lineInfoEdit = null;
  if (proto.lineInfoCountPosition != null) {
    const lineInfoBytes = Buffer.alloc(4 + compiled.lineInfo.length * 4);
    lineInfoBytes.writeInt32LE(compiled.lineInfo.length, 0);
    for (let index = 0; index < compiled.lineInfo.length; index++) {
      lineInfoBytes.writeInt32LE(compiled.lineInfo[index], 4 + index * 4);
    }
    lineInfoEdit = {
      offset: proto.lineInfoCountPosition,
      remove: 4 + proto.lineInfoCount * 4,
      bytes: lineInfoBytes,
    };
  }
  return {
    edit: {
      offset: codeCountPosition,
      remove: oldConstantsEnd - codeCountPosition,
      bytes: replacement,
    },
    lineInfoEdit,
    maxStackOffset,
    maxStack: compiled.maxStack,
    oldInstructions: proto.codeSize / 4,
    newInstructions: compiled.code.length / 4,
    oldConstants: oldConstantCount,
    newConstants: compiled.constants.length,
    oldInlineConstants: oldDefinedCount,
    newInlineConstants: newDefinedCount,
    oldLineInfo: proto.lineInfoCount,
    newLineInfo: compiled.lineInfo.length,
  };
}

function arrayEntry(table, index) {
  return table?.pairs?.find(([key]) => key.tag === 3 && key.value === index);
}

function earlierStringNode(graph, data, value, before) {
  return graph.refs.findLast(
    (node) => node?.tag === 4 && node.start < before && text(data, node) === value,
  );
}

function patchItemBrowser(data, graph) {
  const globals = graphGlobals(data, graph);
  const count = globals.get("ib_itemCount");
  if (count?.value !== 280) {
    throw new Error(`expected saved item count 280, got ${count?.value}`);
  }
  const itemList = globals.get("ib_itemList");
  const itemName = globals.get("ib_itemName");
  const itemNameGbk = globals.get("ib_itemNameGbk");
  const itemCustom = globals.get("ib_itemCustom");

  const wanted = new Map([
    [278, {id: "cbmv", name: "巢母毒液"}],
    [279, {id: "cdhb", name: "darkhound  "}],
  ]);
  const report = [];
  for (const [index, item] of wanted) {
    const listEntry = arrayEntry(itemList, index);
    const nameEntry = arrayEntry(itemName, index);
    const gbkEntry = arrayEntry(itemNameGbk, index);
    const customEntry = arrayEntry(itemCustom, index);
    if (!listEntry || !nameEntry || !gbkEntry || !customEntry) {
      throw new Error(`saved item-browser index ${index} is incomplete`);
    }
    put32(data, listEntry[1].valueOffset, fourCC(item.id));
    put32(data, customEntry[1].valueOffset, 0);

    const nameNode = nameEntry[1];
    const nameBytes = Buffer.from(item.name, "utf8");
    if (nameNode.tag !== 4 || nameNode.size !== nameBytes.length) {
      throw new Error(
        `index ${index}: expected an inline ${nameBytes.length}-byte name, ` +
        `got tag=${nameNode.tag}, size=${nameNode.size}, ` +
        `text=${JSON.stringify(text(data, nameNode))}`,
      );
    }
    data.set(nameBytes, nameNode.text);

    const gbkTokenPosition = nameEntry[0].end;
    const idNode = earlierStringNode(
      graph,
      data,
      item.id,
      gbkEntry[0].start,
    );
    if (!idNode) {
      throw new Error(`no earlier saved Lua string node for ${item.id}`);
    }
    put32(data, gbkEntry[0].end, idNode.ref + 14);
    report.push({
      index,
      id: item.id,
      name: item.name,
      nameOffset: nameNode.text,
      gbkReferenceOffset: gbkEntry[0].end,
      gbkStringRef: idNode.ref,
      gbkTokenPosition,
    });
  }
  return report;
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    throw new Error("usage: patch_forsaken_save2.mjs INPUT.raw.bin OUTPUT.raw.bin");
  }
  const original = new Uint8Array(fs.readFileSync(input));
  const eris = find(original, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const size = u32(original, eris - 4);
  const frame = luaFrame(original, eris, size);
  const graph = parseEris(original, eris);
  const globals = graphGlobals(original, graph);
  const compiled = compileRewritePrototypes();
  const functionReports = [];
  const edits = [];
  for (const name of FUNCTION_TARGETS) {
    const record = functionEdit(
      original,
      graph,
      globals,
      name,
      compiled.get(name),
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
    functionReports.push({
      name,
      ...record,
      edit: undefined,
      lineInfoEdit: undefined,
    });
  }
  edits.sort((left, right) => left.offset - right.offset);
  const functionPatched = splice(original, edits);
  const delta = functionPatched.length - original.length;
  setLuaLengths(functionPatched, frame, graph.end - eris + delta);

  const shiftedFrame = luaFrame(
    functionPatched,
    eris,
    u32(functionPatched, eris - 4),
  );
  const shiftedGraph = parseEris(functionPatched, eris);
  if (shiftedGraph.end !== graph.end + delta) {
    throw new Error(
      `saved Lua graph end changed unexpectedly: ` +
      `${graph.end} -> ${shiftedGraph.end}, delta=${delta}`,
    );
  }
  if (shiftedGraph.refs.length !== graph.refs.length) {
    throw new Error(
      `saved Lua object count changed: ` +
      `${graph.refs.length} -> ${shiftedGraph.refs.length}`,
    );
  }
  if (JSON.stringify(shiftedFrame.waitIds) !== JSON.stringify(frame.waitIds)) {
    throw new Error("saved pending trigger waits changed");
  }

  for (const name of FUNCTION_TARGETS) {
    const afterGlobals = graphGlobals(functionPatched, shiftedGraph);
    const after = afterGlobals.get(name);
    const expected = compiled.get(name);
    if (after?.proto?.codeSize !== expected.code.length) {
      throw new Error(`${name}: instruction count did not round-trip`);
    }
    const code = Buffer.from(
      functionPatched.subarray(
        after.proto.code,
        after.proto.code + after.proto.codeSize,
      ),
    );
    if (!code.equals(expected.code)) {
      throw new Error(`${name}: bytecode did not round-trip`);
    }
    if (after.proto.constants.length !== expected.constants.length) {
      throw new Error(`${name}: constant count did not round-trip`);
    }
    if (after.proto.lineInfoCount !== expected.lineInfo.length) {
      throw new Error(`${name}: line info length did not round-trip`);
    }
  }

  const itemReport = patchItemBrowser(functionPatched, shiftedGraph);
  let outputBytes = functionPatched;
  let trailingPaddingTrimmed = 0;
  if (delta > 0) {
    const trailing = functionPatched.subarray(functionPatched.length - delta);
    if (trailing.every((byte) => byte === 0)) {
      outputBytes = functionPatched.subarray(0, functionPatched.length - delta);
      trailingPaddingTrimmed = delta;
    }
  }
  fs.writeFileSync(output, outputBytes);
  console.log(JSON.stringify({
    input,
    output,
    eris,
    originalLuaSize: size,
    patchedLuaSize: u32(functionPatched, eris - 4),
    luaSizeDelta: delta,
    trailingPaddingTrimmed,
    outputRawSize: outputBytes.length,
    pendingWaitIds: frame.waitIds,
    functions: functionReports,
    items: itemReport,
  }, null, 2));
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    main();
  } catch (error) {
    console.error(error.stack || error);
    process.exit(1);
  }
}
