#!/usr/bin/env node
import fs from "node:fs";
import {
  luaFrame,
  parseEris,
  text,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";
import {
  arrayEntries,
} from "./eris_graph.mjs";

const ERIS = Uint8Array.from([69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8]);

function find(haystack, needle, start = 0) {
  for (let pos = haystack.indexOf(needle[0], start);
    pos >= 0;
    pos = haystack.indexOf(needle[0], pos + 1)) {
    let same = true;
    for (let index = 0; index < needle.length; index++) {
      if (haystack[pos + index] !== needle[index]) {
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

function u32(data, pos) {
  return new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength
  ).getUint32(pos, true);
}

function fields(raw, table) {
  if (table?.tag !== 5 || !table.pairs) {
    return new Map();
  }
  return new Map(
    table.pairs.map(([key, value]) => [text(raw, key), value])
  );
}

function nodeDescription(raw, node) {
  if (!node) {
    return "missing";
  }
  if (node.tag === 4) {
    return `string(${node.size}) ${JSON.stringify(text(raw, node))}`;
  }
  if (node.tag === 5) {
    return `table(${node.pairs?.length ?? 0},bytes=${node.end - node.start})`;
  }
  if (node.tag === 6) {
    return `function(isC=${node.isC},upvalues=${node.upvalues})`;
  }
  if (node.tag === 7) {
    return "userdata";
  }
  if (node.tag === 9) {
    return `proto(code=${(node.codeSize ?? 0) / 4})`;
  }
  if (node.tag === 3) {
    return `integer(${node.value})`;
  }
  if (node.tag === 1) {
    return `boolean(${node.value})`;
  }
  return `tag=${node.tag}`;
}

function main() {
  const raw = new Uint8Array(fs.readFileSync(process.argv[2]));
  const eris = find(raw, ERIS);
  if (eris < 0) {
    throw new Error("ERIS marker not found");
  }
  const size = u32(raw, eris - 4);
  const frame = luaFrame(raw, eris, size);
  const graph = parseEris(raw, eris);
  const root = fields(raw, graph.refs[1]);
  const loadedNode = root.get("_LOADED");
  const loaded = fields(raw, loadedNode);
  const globalNode = loaded.get("_G");
  const global = fields(raw, globalNode);
  console.log(JSON.stringify({
    eris,
    size,
    frame: {
      tag: frame.tag,
      waits: frame.waits,
      waitIds: frame.waitIds,
    },
    graphEnd: graph.end,
    rootEntries: root.size,
    loadedEntries: loaded.size,
    globalEntries: global.size,
    rootKeys: [...root.keys()].slice(0, 40),
  }, null, 2));

  const prefixes = [
    "ib_",
    "bj_queuedExec",
    "gg_trg_Banshee_C",
    "Trig_Banshee_C",
    "udg_Banshee_C",
    "udg_CS_PauseUGroup",
    "udg_Hero_Anya",
    "udg_Hero_Garek",
    "udg_GameOver",
    "gg_trg_Darkhound",
    "Trig_Darkhound",
    "BossBrood",
    "Trig_Brood",
    "udg_BossBrood",
    "udg_Bool_DevModeOn",
    "udg_Bool_MQApot",
    "udg_Int_CurrentDH",
    "udg_Int_TargetDH",
  ];
  for (const [name, node] of [...global.entries()].sort()) {
    if (prefixes.some((prefix) => name.startsWith(prefix))) {
      console.log(name, nodeDescription(raw, node));
      if (node?.tag === 7) {
        console.log("  userdata node:", JSON.stringify(node));
        console.log(
          "  userdata:",
          Buffer.from(raw.subarray(node.start, Math.min(node.end ?? (node.start + 48), node.start + 48))).toString("hex")
        );
      }
      if (node?.tag === 5) {
        const table = fields(raw, node);
        const array = arrayEntries(node);
        console.log(
          `  table stringEntries=${table.size} arrayEntries=${array.length}`
        );
        console.log(
          "  prefix:",
          Buffer.from(raw.subarray(node.start, node.start + 64)).toString("hex")
        );
        if (node.pairs.length) {
          console.log(
            "  first pairs:",
            node.pairs.slice(0, 4).map(([key, value]) => [
              nodeDescription(raw, key),
              nodeDescription(raw, value),
            ])
          );
        }
        if (array.length) {
          console.log(
            "  first/last:",
            array.slice(0, 2).map(([key, value]) => ({
              key: key.value,
              value: nodeDescription(raw, value),
            })),
            array.slice(-4).map(([key, value]) => ({
              key: key.value,
              value: nodeDescription(raw, value),
            }))
          );
        }
      }
    }
  }
}

try {
  main();
} catch (error) {
  console.error(error.stack || error);
  process.exit(1);
}
