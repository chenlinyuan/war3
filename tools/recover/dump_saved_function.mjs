#!/usr/bin/env node
// Dump a saved LuaJIT function prototype without executing the saved Lua state.

import fs from "node:fs";
import {
  parseEris,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const ERIS_MARKER = Uint8Array.from([
  69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8,
]);

function findBytes(data, needle, start = 0) {
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

function readU32(data, offset) {
  return new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength,
  ).getUint32(offset, true);
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

function describe(data, node) {
  if (!node) {
    return "missing";
  }
  if (node.tag === 4) {
    return `string(${node.size}) ${JSON.stringify(text(data, node))}`;
  }
  if (node.tag === 3) {
    return `integer(${node.value})`;
  }
  if (node.tag === 2) {
    return `number(${node.value})`;
  }
  if (node.tag === 1) {
    return `boolean(${node.value})`;
  }
  if (node.tag === 5) {
    return `table(pairs=${node.pairs?.length ?? 0},bytes=${node.end - node.start})`;
  }
  if (node.tag === 6) {
    return `function(isC=${node.isC},upvalues=${node.upvalues})`;
  }
  if (node.tag === 9) {
    return `proto(instructions=${(node.codeSize ?? 0) / 4})`;
  }
  return `tag=${node.tag}`;
}

function main() {
  const [input, wantedName] = process.argv.slice(2);
  if (!input || !wantedName) {
    throw new Error("usage: dump_saved_function.mjs RAW_BIN GLOBAL_NAME");
  }
  const data = new Uint8Array(fs.readFileSync(input));
  const eris = findBytes(data, ERIS_MARKER);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const graph = parseEris(data, eris);
  const root = stringFields(data, graph.refs[1]);
  const loaded = stringFields(data, root.get("_LOADED"));
  const global = stringFields(data, loaded.get("_G"));
  const target = global.get(wantedName);
  if (!target) {
    throw new Error(`global not found: ${wantedName}`);
  }
  const output = {
    eris,
    graphEnd: graph.end,
    refs: graph.refs.length,
    target,
    function: describe(data, target),
  };
  if (target.tag !== 6) {
    console.log(JSON.stringify(output, null, 2));
    return;
  }
  output.isC = target.isC;
  output.upvalues = target.upvalues;
  output.proto = describe(data, target.proto);
  const proto = target.proto;
  if (!proto || proto.tag !== 9) {
    console.log(JSON.stringify(output, null, 2));
    return;
  }
  output.protoStart = proto.start;
  output.protoEnd = proto.end;
  output.header = Buffer.from(
    data.subarray(proto.start + 4, proto.code - 4),
  ).toString("hex");
  output.instructions = [];
  for (let offset = 0; offset < proto.codeSize; offset += 4) {
    const at = proto.code + offset;
    const word = readU32(data, at);
    output.instructions.push({
      offset,
      word: `0x${word.toString(16).padStart(8, "0")}`,
      opcode: word & 0x3f,
      a: (word >>> 6) & 0xff,
      c: (word >>> 14) & 0x1ff,
      b: (word >>> 23) & 0x1ff,
      ax: (word >>> 6) & 0x3ffffff,
      bx: (word >>> 14) & 0x3ffff,
    });
  }
  output.constants = proto.constants.map((constant, index) => ({
    index,
    description: describe(data, constant),
  }));
  console.log(JSON.stringify(output, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
