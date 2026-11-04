#!/usr/bin/env node
// Patch The Forsaken checkpoint 2 without changing any saved-Lua lengths.

import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";
import {
  parseEris,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const LUAC = path.resolve(
  "tools/recover/luac-src/package/deps/lua-5.3.3/src/luac.exe",
);
const DARKHOUND_SOURCE = path.resolve(
  "tools/recover/forsaken_save2_inplace_darkhound.lua",
);
const RETURN_WORD = 0x00800026;

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

function graphGlobals(data, graph) {
  const root = stringFields(data, graph.refs[1]);
  const loaded = stringFields(data, root.get("_LOADED"));
  return stringFields(data, loaded.get("_G"));
}

class LuaChunkReader {
  constructor(data) {
    this.data = Buffer.from(data);
    this.view = view(this.data);
    this.position = 0;
  }

  take(count) {
    if (count < 0 || this.position + count > this.data.length) {
      throw new Error(`invalid Lua chunk read at ${this.position}`);
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
      throw new Error("unsupported 64-bit Lua integer");
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

  function() {
    this.string();
    this.int32();
    this.int32();
    this.byte();
    this.byte();
    const maxStack = this.byte();
    const codeCount = this.int32();
    const codeOffset = this.take(codeCount * 4);
    const code = Buffer.from(
      this.data.subarray(codeOffset, codeOffset + codeCount * 4),
    );
    const constants = [];
    const constantCount = this.int32();
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
        throw new Error(`unsupported Lua constant tag ${tag}`);
      }
    }
    const upvalueCount = this.int32();
    this.take(upvalueCount * 2);
    const protoCount = this.int32();
    const protos = [];
    for (let index = 0; index < protoCount; index++) {
      protos.push(this.function());
    }
    const lineInfoCount = this.int32();
    this.take(lineInfoCount * 4);
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
      maxStack,
      code,
      constants,
      upvalueCount,
      protos,
      lineInfoCount,
    };
  }
}

function compileDarkhoundCondition() {
  const output = path.resolve(
    "tools/recover/_forsaken_save2_inplace_darkhound.luac",
  );
  const result = spawnSync(LUAC, ["-o", output, DARKHOUND_SOURCE], {
    cwd: process.cwd(),
    encoding: "utf8",
  });
  if (result.status !== 0) {
    throw new Error(`luac failed: ${result.stderr || result.stdout}`);
  }
  const reader = new LuaChunkReader(fs.readFileSync(output));
  reader.take(33);
  reader.byte();
  const main = reader.function();
  if (main.protos.length !== 1) {
    throw new Error("expected one compiled darkhound function");
  }
  return main.protos[0];
}

function erisConstant(data, node) {
  if (node.tag === 0) {
    return {kind: "nil"};
  }
  if (node.tag === 1) {
    return {kind: "boolean", value: node.value};
  }
  if (node.tag === 3) {
    return node.boolean === 1
      ? {kind: "integer", value: node.value}
      : {kind: "floatWord", value: node.value};
  }
  if (node.tag === 4) {
    return {kind: "string", value: text(data, node)};
  }
  throw new Error(`unsupported saved Lua constant tag ${node.tag}`);
}

function compiledConstantKey(constant) {
  if (constant.kind === "nil") {
    return "nil";
  }
  if (constant.kind === "boolean") {
    return `boolean:${constant.value}`;
  }
  if (constant.kind === "integer") {
    return `integer:${constant.value >>> 0}`;
  }
  if (constant.kind === "float") {
    const bytes = Buffer.alloc(4);
    bytes.writeFloatLE(constant.value, 0);
    return `float:${bytes.readUInt32LE(0)}`;
  }
  if (constant.kind === "string") {
    return `string:${constant.value}`;
  }
  throw new Error(`unsupported compiled constant ${constant.kind}`);
}

function savedConstantKey(constant) {
  if (constant.kind === "nil") {
    return "nil";
  }
  if (constant.kind === "boolean") {
    return `boolean:${constant.value}`;
  }
  if (constant.kind === "integer") {
    return `integer:${constant.value >>> 0}`;
  }
  if (constant.kind === "floatWord") {
    return `float:${constant.value >>> 0}`;
  }
  if (constant.kind === "string") {
    return `string:${constant.value}`;
  }
  throw new Error(`unsupported saved constant ${constant.kind}`);
}

function remapDarkhound(compiled, savedProto, data) {
  const savedKeys = savedProto.constants.map((node) =>
    savedConstantKey(erisConstant(data, node))
  );
  const indexByKey = new Map(
    savedKeys.map((key, index) => [key, index]),
  );
  const remap = compiled.constants.map((constant, index) => {
    const key = compiledConstantKey(constant);
    if (!indexByKey.has(key)) {
      throw new Error(
        `darkhound constant ${index} (${key}) is absent from the saved proto`,
      );
    }
    return indexByKey.get(key);
  });

  const words = [];
  for (let offset = 0; offset < compiled.code.length; offset += 4) {
    let word = compiled.code.readUInt32LE(offset);
    const opcode = word & 0x3f;
    if (opcode === 6) {
      const c = (word >>> 14) & 0x1ff;
      if (c & 0x100) {
        const mapped = remap[c & 0xff];
        word = (word & ~(0x1ff << 14)) |
          (((mapped | 0x100) & 0x1ff) << 14);
      }
    } else if (opcode === 31) {
      const b = (word >>> 23) & 0x1ff;
      const c = (word >>> 14) & 0x1ff;
      if (b & 0x100) {
        const mapped = remap[b & 0xff];
        word = (word & ~(0x1ff << 23)) |
          (((mapped | 0x100) & 0x1ff) << 23);
      }
      if (c & 0x100) {
        const mapped = remap[c & 0xff];
        word = (word & ~(0x1ff << 14)) |
          (((mapped | 0x100) & 0x1ff) << 14);
      }
    } else if (opcode === 1) {
      const bx = (word >>> 14) & 0x3ffff;
      const mapped = remap[bx];
      word = (word & ~(0x3ffff << 14)) | (mapped << 14);
    }
    words.push(word >>> 0);
  }
  const oldCount = savedProto.codeSize / 4;
  if (words.length > oldCount) {
    throw new Error(
      `darkhound replacement needs ${words.length} instructions, ` +
      `but saved proto has ${oldCount}`,
    );
  }
  while (words.length < oldCount) {
    words.push(RETURN_WORD);
  }
  const output = Buffer.alloc(savedProto.codeSize);
  for (let index = 0; index < words.length; index++) {
    output.writeUInt32LE(words[index], index * 4);
  }
  return output;
}

function patchDarkhound(data, graph, globals) {
  const target = globals.get("Trig_Darkhound_Blood_Drop_Conditions");
  if (!target?.proto || target.upvalues !== 1) {
    throw new Error("saved darkhound condition function not found");
  }
  const compiled = compileDarkhoundCondition();
  if (compiled.upvalueCount !== 1 || compiled.protos.length !== 0) {
    throw new Error("unexpected compiled darkhound function shape");
  }
  const code = remapDarkhound(compiled, target.proto, data);
  code.copy(data, target.proto.code);
  return {
    instructions: target.proto.codeSize / 4,
    compiledInstructions: compiled.code.length / 4,
    condition: "any unit death while the supply trigger is enabled",
  };
}

function patchBroodMotherWeb(data, graph, globals) {
  const target = globals.get(
    "Trig_Brood_Mother_90_Create_Web_Func002Func003Func002A",
  );
  if (!target?.proto || target.proto.codeSize !== 160) {
    throw new Error("saved broodmother web function shape changed");
  }
  const proto = target.proto;
  const pauseTrueOffset = proto.code + 16;
  const oldWord = u32(data, pauseTrueOffset);
  if (oldWord !== 0x00800043) {
    throw new Error(
      `unexpected PauseUnitBJ(true) instruction ` +
      `0x${oldWord.toString(16)}`,
    );
  }
  put32(data, pauseTrueOffset, 0x00000043);

  const speed = proto.constants[4];
  if (
    speed?.tag !== 3 ||
    speed.boolean !== 0 ||
    speed.value !== 0x41c80000
  ) {
    throw new Error("unexpected saved 25.0 web time-scale constant");
  }
  view(data).setFloat32(speed.valueOffset, 100, true);
  return {
    pauseInstructionOffset: pauseTrueOffset,
    pauseArgument: "false",
    timeScale: 100,
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

function patchItemBrowser(data, graph, globals) {
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
  const result = [];
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
    const nameBytes = Buffer.from(item.name, "utf8");
    const nameNode = nameEntry[1];
    if (nameNode.tag !== 4 || nameNode.size !== nameBytes.length) {
      throw new Error(`saved item-browser name ${index} changed size`);
    }
    data.set(nameBytes, nameNode.text);
    const idNode = earlierStringNode(
      graph,
      data,
      item.id,
      gbkEntry[0].start,
    );
    if (!idNode) {
      throw new Error(`saved Lua has no earlier ${item.id} string node`);
    }
    put32(data, gbkEntry[0].end, idNode.ref + 14);
    result.push({index, id: item.id, name: item.name});
  }
  return result;
}

function main() {
  const args = process.argv.slice(2);
  const dataOnly = args.includes("--data-only");
  const [input, output] = args.filter((arg) => arg !== "--data-only");
  if (!input || !output) {
    throw new Error(
      "usage: patch_forsaken_save2_inplace.mjs INPUT.raw.bin OUTPUT.raw.bin",
    );
  }
  const raw = new Uint8Array(fs.readFileSync(input));
  const eris = find(raw, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const graph = parseEris(raw, eris);
  const globals = graphGlobals(raw, graph);
  const darkhound = dataOnly ? null : patchDarkhound(raw, graph, globals);
  const web = dataOnly ? null : patchBroodMotherWeb(raw, graph, globals);
  const items = patchItemBrowser(raw, graph, globals);

  if (raw.length !== fs.statSync(input).size) {
    throw new Error("raw save size changed");
  }
  const checked = parseEris(raw, eris);
  if (checked.end !== graph.end || checked.refs.length !== graph.refs.length) {
    throw new Error("saved Lua graph structure changed");
  }
  fs.writeFileSync(output, raw);
  console.log(JSON.stringify({
    input,
    output,
    eris,
    graphEnd: graph.end,
    objectCount: graph.refs.length,
    rawSize: raw.length,
    darkhound,
    web,
    items,
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
