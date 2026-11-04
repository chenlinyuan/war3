#!/usr/bin/env node
import fs from "node:fs";
import {
  luaFrame,
  parseEris,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);
const FOURCC = (value) => Buffer.from(value, "ascii").readUInt32LE(0);

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

function u32(data, offset) {
  return new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength,
  ).getUint32(offset, true);
}

function put32(data, offset, value) {
  new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength,
  ).setUint32(offset, value, true);
}

function fields(data, table) {
  return new Map(
    (table?.pairs || [])
      .filter(([key]) => key.tag === 4)
      .map(([key, value]) => [text(data, key), value]),
  );
}

function parseIntegerArray(data, table) {
  if (table?.tag !== 5) {
    throw new Error("item list is not a table");
  }
  let position = table.start + 4;
  const metatableFlag = data[position++];
  if (metatableFlag !== 0) {
    throw new Error("unexpected item-list metatable");
  }
  position += 4;
  const values = new Map();
  while (position + 4 <= table.end) {
    const keyTag = u32(data, position);
    if (keyTag === 0) {
      break;
    }
    if (keyTag !== 3) {
      throw new Error(`unexpected item-list key tag ${keyTag} at ${position}`);
    }
    const key = u32(data, position + 5);
    const valueStart = position + 9;
    const valueTag = u32(data, valueStart);
    if (valueTag !== 3) {
      throw new Error(
        `unexpected item-list value tag ${valueTag} at ${valueStart}`
      );
    }
    values.set(key, {
      value: u32(data, valueStart + 5),
      valueOffset: valueStart + 5,
    });
    position = valueStart + 9;
  }
  return values;
}

function main() {
  const [input, output] = process.argv.slice(2);
  if (!input || !output) {
    throw new Error("usage: patch_saved_lua_items.mjs RAW_IN RAW_OUT");
  }
  const raw = new Uint8Array(fs.readFileSync(input));
  const eris = find(raw, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const size = u32(raw, eris - 4);
  luaFrame(raw, eris, size);
  const graph = parseEris(raw, eris);
  const root = fields(raw, graph.refs[1]);
  const loaded = fields(raw, root.get("_LOADED"));
  const global = fields(raw, loaded.get("_G"));

  const countNode = global.get("ib_itemCount");
  if (countNode?.value !== 280) {
    throw new Error(`expected saved item count 280, got ${countNode?.value}`);
  }
  const entries = parseIntegerArray(raw, global.get("ib_itemList"));
  const frostmourne = FOURCC("061I");
  for (const index of [278, 279]) {
    if (entries.get(index)?.value !== frostmourne) {
      throw new Error(
        `expected duplicate Frostmourne item at index ${index}, got ` +
        `${entries.get(index)?.value?.toString(16)}`
      );
    }
  }

  put32(raw, entries.get(278).valueOffset, FOURCC("cbmv"));
  put32(raw, entries.get(279).valueOffset, FOURCC("cdhb"));
  fs.writeFileSync(output, raw);
  console.log(JSON.stringify({
    input,
    output,
    eris,
    size,
    itemCount: countNode.value,
    replaced: {
      278: {from: "061I", to: "cbmv"},
      279: {from: "061I", to: "cdhb"},
    },
  }, null, 2));
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
