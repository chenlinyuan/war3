#!/usr/bin/env node
import fs from "node:fs";
import {
  layout,
  states,
} from "./forsaken-save-repair-src/forsaken-save-repair-main/src/native-downgrade.mjs";

const UNIT = Uint8Array.from(Buffer.from("lga+u3w+", "ascii"));
const WANTED = ["n004", "n005", "h001"];

function equal(left, right) {
  return left.length === right.length &&
    left.every((value, index) => value === right[index]);
}

const raw = new Uint8Array(fs.readFileSync(process.argv[2]));
const native = layout(raw);
const records = states(raw, native);
const result = [];
for (const [key, state] of records) {
  if (!equal(state.type, UNIT)) {
    continue;
  }
  const body = raw.subarray(state.pos + 8, state.pos + 8 + state.size);
  const hits = [];
  for (const code of WANTED) {
    const needle = Buffer.from(code, "ascii");
    for (let offset = 0; offset + 4 <= body.length; offset++) {
      if (
        body[offset] === needle[0] &&
        body[offset + 1] === needle[1] &&
        body[offset + 2] === needle[2] &&
        body[offset + 3] === needle[3]
      ) {
        hits.push({
          code,
          bodyOffset: offset,
          absoluteOffset: state.pos + 8 + offset,
        });
      }
    }
  }
  if (hits.length) {
    result.push({
      key,
      owner: state.owner,
      recordOffset: state.pos,
      size: state.size,
      hits,
    });
  }
}
console.log(JSON.stringify({
  unitStates: [...records.values()].filter((state) => equal(state.type, UNIT)).length,
  matches: result,
}, null, 2));
