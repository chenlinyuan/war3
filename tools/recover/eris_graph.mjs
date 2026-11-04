#!/usr/bin/env node
// Read Warcraft III 3.x saved-Lua (Eris) graphs while retaining scalar values.

const TEXT = new TextDecoder();

export const ERIS_MARKER = Uint8Array.from([
  69, 82, 73, 83, 4, 82, 6, 158, 191, 4, 4, 8,
]);

export function findBytes(data, needle, start = 0) {
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

export function readU32(data, offset) {
  return new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength,
  ).getUint32(offset, true);
}

export function nodeText(data, node) {
  return node?.tag === 4
    ? TEXT.decode(data.subarray(node.text, node.text + node.size))
    : null;
}

export function stringFields(data, table) {
  if (table?.tag !== 5 || !table.pairs) {
    return new Map();
  }
  return new Map(
    table.pairs
      .filter(([key]) => key.tag === 4)
      .map(([key, value]) => [nodeText(data, key), value]),
  );
}

export function arrayEntries(table) {
  if (table?.tag !== 5 || !table.pairs) {
    return [];
  }
  return table.pairs
    .filter(([key]) => key.tag === 3)
    .sort((left, right) => left[0].value - right[0].value);
}

export function parseEris(data, start) {
  const view = new DataView(
    data.buffer,
    data.byteOffset,
    data.byteLength,
  );
  let position = start;
  const take = (count) => {
    if (count < 0 || position + count > data.length) {
      throw new Error(`invalid Lua size at ${position}`);
    }
    const result = position;
    position += count;
    return result;
  };
  const i32 = () => view.getInt32(take(4), true);
  const u8 = () => data[take(1)];
  const u64 = () => {
    const offset = take(8);
    if (view.getUint32(offset + 4, true) !== 0) {
      throw new Error(`unsupported 64-bit Lua value at ${offset}`);
    }
    return view.getUint32(offset, true);
  };
  const count = () => {
    const value = i32();
    if (value < 0 || value > 1_000_000) {
      throw new Error(`invalid Lua count at ${position - 4}`);
    }
    return value;
  };
  const flag = () => {
    const value = u8();
    if (value !== 0 && value !== 1) {
      throw new Error(`invalid Lua flag at ${position - 1}`);
    }
    return value;
  };

  const refs = [null];
  const uses = [];
  const tasks = [];
  const emit = (done) => tasks.push(() => read(done));
  const sequence = (length, done) => {
    let index = 0;
    const step = () => {
      if (index++ < length) {
        emit(step);
      } else {
        done();
      }
    };
    step();
  };

  function read(done) {
    const at = position;
    const tag = i32();
    if (tag > 14) {
      const ref = tag - 14;
      if (ref >= refs.length) {
        throw new Error(`invalid Lua reference at ${at}`);
      }
      uses.push({ position: at, ref });
      return done(refs[ref]);
    }
    if (tag === 0) {
      return done({ tag, start: at, end: position });
    }
    if (tag === 1) {
      const value = flag();
      return done({ tag, start: at, end: position, value });
    }
    if (tag === 2) {
      const valueOffset = take(8);
      const value = view.getFloat64(valueOffset, true);
      return done({ tag, start: at, end: position, value });
    }
    if (tag === 3) {
      const boolean = flag();
      const valueOffset = take(4);
      const value = view.getUint32(valueOffset, true);
      return done({
        tag,
        start: at,
        end: position,
        boolean,
        value,
        valueOffset,
      });
    }
    if (![4, 5, 6, 7, 8, 9, 12, 13].includes(tag)) {
      throw new Error(`unsupported Lua tag ${tag} at ${at}`);
    }
    const node = { tag, start: at, end: 0, ref: refs.length };
    refs.push(node);
    const finish = () => {
      node.end = position;
      tasks.push(() => done(node));
    };

    if (tag === 4) {
      node.size = u64();
      node.text = take(node.size);
      return finish();
    }
    if (tag === 12) {
      return emit(finish);
    }
    if (tag === 13) {
      node.kind = u8();
      return emit((child) => {
        node.child = child;
        finish();
      });
    }
    if (tag === 5 || tag === 7) {
      if (flag()) {
        return emit(finish);
      }
      if (tag === 7) {
        const size = u64();
        take(4);
        take(size);
        return emit(finish);
      }
      take(4);
      node.pairs = [];
      const entry = () => emit((key) => {
        if (key.tag === 0) {
          return emit(finish);
        }
        emit((value) => {
          if (value.tag === 0) {
            throw new Error("nil table value");
          }
          node.pairs.push([key, value]);
          entry();
        });
      });
      return entry();
    }
    if (tag === 6) {
      node.isC = flag();
      const upvalues = u8();
      node.upvalues = upvalues;
      return emit((first) => {
        if (!node.isC) {
          node.proto = first;
        }
        sequence(upvalues, finish);
      });
    }
    if (tag === 9) {
      take(11);
      const codeCount = count();
      node.codeOffset = take(codeCount * 4);
      node.codeSize = codeCount * 4;
      node.constants = [];
      const constCount = count();
      let constantIndex = 0;
      const constantsDone = () => {
        const upvalueCount = count();
        take(upvalueCount * 2);
        if (!flag()) {
          return finish();
        }
        return emit(() => {
          take(count() * 4);
          let locals = count();
          const local = () => {
            if (locals-- > 0) {
              take(8);
              emit(local);
            } else {
              sequence(upvalueCount, finish);
            }
          };
          local();
        });
      };
      const nextConstant = () => {
        if (constantIndex++ < constCount) {
          emit((constant) => {
            node.constants.push(constant);
            nextConstant();
          });
        } else {
          constantsDone();
        }
      };
      return nextConstant();
    }

    // tag 8: coroutine
    take(13);
    const stackSize = count();
    const used = u64();
    if (used > stackSize) {
      throw new Error("thread stack exceeds allocation");
    }
    return sequence(used, () => {
      const status = u8();
      u64();
      const openUpvalues = () => {
        if (!u64()) {
          return finish();
        }
        emit(openUpvalues);
      };
      const frame = () => {
        u64();
        u64();
        take(2);
        const call = u8();
        const next = () => {
          if (!flag()) {
            frame();
          } else {
            if (status === 1) {
              u64();
            }
            openUpvalues();
          }
        };
        if (call && (call & 16)) {
          u64();
        }
        if (call && (call & 2)) {
          u64();
          u64();
        } else if (call && flag()) {
          take(4);
          return emit(next);
        }
        next();
      };
      frame();
    });
  }

  if (findBytes(data, ERIS_MARKER, position) !== position) {
    throw new Error("missing Eris header");
  }
  position += 12;
  let root = null;
  emit((value) => {
    root = value;
  });
  while (tasks.length) {
    tasks.pop()();
  }
  if (!root) {
    throw new Error("incomplete saved Lua graph");
  }
  return { start, end: position, root, refs, uses };
}
