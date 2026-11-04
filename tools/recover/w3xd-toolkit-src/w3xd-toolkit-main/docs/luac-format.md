# The Lua 5.3 bytecode in `war3map.luac`

Campaign maps ship their script compiled: `war3map.luac` in the archive (and no
`war3map.lua` source).  It is Lua 5.3 bytecode from a Blizzard build, and it
differs from stock Lua in exactly one way.

## The difference

```
$ luac53 info humanre02interlude.files/war3map.luac
file                : .../war3map.luac
size                : 508,423 bytes
version             : Lua 5.3
sizeof(int)         : 4
sizeof(size_t)      : 8
sizeof(Instruction) : 4
sizeof(lua_Integer) : 4  (Blizzard build)
sizeof(lua_Number)  : 4  (Blizzard build)
main source         : b'@D:\\Jenkins\\workspace\\warcraft3_working_dir\\...'
```

| item | stock Lua 5.3 | this build |
|---|---|---|
| `sizeof(lua_Integer)` | 8 (int64) | **4 (int32)** |
| `sizeof(lua_Number)` | 8 (double) | **4 (float32)** |

Everything else is stock, and the header says so itself:

| header byte | value | meaning |
|---|---|---|
| 0–3 | `\x1bLua` | signature |
| 4 | `0x53` | version 5.3 |
| 5 | `0x00` | format |
| 6–11 | `19 93 0d 0a 1a 0a` | `LUAC_DATA` |
| 12 | `4` | `sizeof(int)` |
| 13 | `8` | `sizeof(size_t)` |
| 14 | `4` | `sizeof(Instruction)` |
| 15 | **`4`** | `sizeof(lua_Integer)` — stock is 8 |
| 16 | **`4`** | `sizeof(lua_Number)` — stock is 8 |
| 17–20 | `78 56 00 00` | `LUAC_INT` = 0x5678 |
| 21–24 | `00 40 b9 43` | `LUAC_NUM` = 370.5, as a **float** |

Because the two width bytes are declared, the header is 25 bytes here instead
of the usual 33.  The `sizeupvalues` byte that follows is present, as in stock
5.3.2+.

### A correction worth recording

It is tempting to conclude that the string length encoding also differs.  It
does not.  Lua 5.3 `dumpSize` writes one byte, or `0xFF` followed by a 8-byte
`size_t`:

```
size <  0xFF :  [size]
size >= 0xFF :  [0xFF][size as u64 LE]
```

That is stock behaviour — unluac's `LStringType53` reads exactly this — and the
7-bit varint only appeared in Lua **5.4**.  The escape is visible in real data
when a string constant is long, for example a 257-character music list:

```
14 | ff | 02 01 00 00 00 00 00 00 | Sound\Music\mp3Music\NaxxramasWalking1.ogg;...
 ^    ^    ^
 |    |    258 = 257 characters + 1
 |    escape marker
 long-string constant tag
```

How the encoding was pinned down: a candidate is accepted only if parsing a
chunk consumes **exactly** its whole length.  Guessing wrong shows up
immediately as garbage counts or a run off the end of the buffer, so a short
script can try every plausible variant and report which one closes the file.

## Converting

```
$ luac53 convert war3map.luac -o war3map.stock.luac
functions=597 code=37,501 consts=7,112 strings=5,133
war3map.luac -> war3map.stock.luac (532,000 bytes)
```

`convert` only rewrites constant payloads — `lua_Integer` and `lua_Number` grow
to 8 bytes — and copies the instruction stream verbatim.  That is why it does
not need to understand a single opcode, and why the opcode set being stock
matters only to the decompiler downstream.

`luac53` also accepts a chunk that is already stock and passes it through.

## Decompiling

`luac53 decompile` chains the conversion and [unluac](https://github.com/HansWessels/unluac):

```
$ scripts/get-unluac.sh                 # clone + javac into tools/unluac
$ luac53 decompile war3map.luac -o war3map.lua
war3map.luac -> war3map.lua (498,884 bytes)
```

The output is ordinary Lua 5.3 source.  Debug information is present in these
chunks (line numbers, local names, upvalue names), which is what lets a
decompiler reconstruct readable names and structure:

```
$ luac53 info war3map.luac | tail -1
debug info          : 37,501 lines, 4,063 locals, 1,945 upvalue names
```

## Disassembling

When a decompiler gets a control-flow construct wrong — the classic case is a
mis-nested `if`/`else` — the prototype listing shows the real jumps:

```
$ luac53 disasm war3map.luac --find updateSlot
proto main/696/12  params=1 vararg=0 maxstack=7 code=44
code:
  [   0] L18488  GETTABLE  A=1   B=0    C=256   C=K[0]b'ability'
  [   1] L18489  EQ        A=1   B=1    C=257   C=K[1]nil  (skip next when false)
  [   2] L18489  JMP       A=0   B=256  C=5     -> pc 9
  ...
  [  18] L18493  SETTABLE  A=1   B=264  C=0     B=K[8]b'slot'
```

`--find` locates a prototype by any string constant in it (a function name
works well), `--lines LO HI` by source line range.

## See also

* `docs/container-format.md` — how to get `war3map.luac` out of a `.w3xd`
* `luac53/chunk.py` — the reader/writer, parameterised by constant widths
* `tests/test_luac.py` — round-trips every constant type and the `0xFF` escape
