# w3xd-toolkit

**English** · [简体中文](README.zh-CN.md)

Decrypt **Warcraft III: Reforged 3.0** campaign map containers (`.w3xd`) into
normal `.w3x` maps, extract their members with their real names, and decompile
the Lua 5.3 bytecode inside them back to readable source.

* No key required — the license is recovered from the container itself.
* No dependencies — AES, CCM and the GF(2) solver are implemented here.
* Works on Linux, macOS and Windows (a Windows CNG fast path is used when
  available).
* 53 unit tests that build synthetic containers and archives, so nothing here
  depends on shipping game data.

```console
$ w3xd unpack HumanRE01.w3xd
license 0x...  -> HumanRE01.w3x (5,622,820 bytes)
67 members (67 named), 14,351,676 bytes -> HumanRE01.files

$ luac53 decompile HumanRE01.files/war3map.luac
war3map.luac -> war3map.lua (1,945,651 bytes)
```

---

## Contents

| | |
|---|---|
| [Background](#background) | what a `.w3xd` is and why editors cannot open it |
| [Install](#install) | requirements and setup |
| [Usage](#usage) | `w3xd` and `luac53` command reference |
| [The license](#the-license) | how it is recovered without knowing it |
| [Format documentation](#format-documentation) | the reverse-engineered details |
| [Scanning a CASC install](#scanning-a-casc-install) | find every container on disk |
| [Repository layout](#repository-layout) | where things live |
| [Contributing](#contributing) | how to help, and the three ground rules |
| [Legal](#legal) | read this before using or redistributing anything |

---

## Background

Reforged 3.0 ships its campaign maps as `.w3xd` files — the same map data as a
`.w3x`, wrapped in a container that the game unwraps at load time:

```
.w3xd on disk
   |  layer 1: xorshift32 XOR over the whole file, seeded from (size, license)
   |  layer 2: AES-256-CCM over the payload, keyed from the 64-bit license
   v
plain MPQ archive  ==  a normal .w3x map
```

The payload is a perfectly ordinary MPQ, and the World Editor would open it —
but only after both layers come off.  Nothing in the file is recognisable in
the clear, which is why CascView exports it as-is and the editor rejects it.

`w3xd-toolkit` removes both layers.

## Install

Python 3.8 or newer.  No pip packages are needed.

```bash
git clone https://github.com/mythic-p/w3xd-toolkit
cd w3xd-toolkit
python -m unittest discover -s tests -t .      # optional: 53 tests, <1s
```

Run in place:

```bash
python -m w3xd --help
python -m luac53 --help
```

or install the console scripts:

```bash
pip install -e .
w3xd --help
luac53 --help
```

Decompiling (as opposed to decrypting) additionally needs Java and
[unluac](https://github.com/HansWessels/unluac), which a script fetches and
builds for you:

```bash
scripts/get-unluac.sh          # Linux/macOS
scripts\get-unluac.ps1         # Windows PowerShell
```

It lands in `tools/unluac/` (git-ignored).  Alternatively set `UNLUAC_JAR` to
any unluac jar.

## Usage

### `w3xd` — containers

```
w3xd info     FILE.w3xd [--payload] [--key-material]   structure, sizes, license
w3xd license  FILE.w3xd [--key]                        print the license or AES key
w3xd decrypt  FILE.w3xd [-o OUT.w3x]                   container -> map
w3xd extract  FILE.w3x  [-o DIR]                       members of a decrypted map
w3xd unpack   FILE.w3xd [-o OUT.w3x] [-d DIR]          decrypt and extract
w3xd batch    DIR [-x]                                 every .w3xd in a directory
```

```console
$ w3xd info HumanRE02Interlude.w3xd
file          : HumanRE02Interlude.w3xd
size          : 528,645 bytes
xorshift seed : 0x86c7da45  (matches size/license formula: True)
trailer       : version=1 flags=6 block_size=0x40
header size   : 154
payload size  : 528,427 bytes
license       : 0x0123456789abcdef
AES-256 key   : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e421eb3507d6a2d8aa975ba29ad
```

`info` needs no key and does not decrypt the payload; it reports what it read
out of the trailer.  `--payload` additionally verifies the CCM tag and reports
the payload size and magic, which is the fastest way to confirm a container is
intact.

`unpack` writes `<name>.w3x` and, next to it, `<name>.files/` containing every
member under its original path:

```
HumanRE02Interlude.files/
  war3map.w3i  war3map.w3e  war3map.wts  war3map.luac  war3map.wct  ...
  conversation.json  CustomUI.TOC  3DPoint.mdx
  Abilities/Spells/Orc/LightningBolt/LightningBolt.flac
  doodads/ashenvale/rocks/ashenrock/av_environment_rocks_diffuse.dds
```

### `luac53` — the compiled Lua

```
luac53 info       FILE.luac                       header, widths, debug info
luac53 convert    FILE.luac [-o OUT.luac]         rewrite as a stock Lua 5.3 chunk
luac53 disasm     FILE.luac [--find TEXT...]      disassemble
                            [--lines LO HI] [--no-constants]
luac53 decompile  FILE.luac [-o OUT.lua]          convert + run unluac
```

`decompile` is the one you normally want:

```console
$ luac53 info HumanRE01.files/war3map.luac
sizeof(lua_Integer) : 4  (Blizzard build)
sizeof(lua_Number)  : 4  (Blizzard build)
functions           : 3,229
instructions        : 151,440
constants           : 40,650
debug info          : 151,440 lines, 6,796 locals, 5,576 upvalue names

$ luac53 decompile HumanRE01.files/war3map.luac -o war3map.lua
war3map.luac -> war3map.lua (1,945,651 bytes)
```

The result is ordinary Lua 5.3 source:

```lua
udg_F1_Player02_User = nil
udg_Weather_FogDZStart = 0.0
udg_Cache_HumanRE = ""
udg_Cache_MapNames = __jarray("")
...
function Item.updateSlot(slot)
  local ability = slot.ability
  if ability ~= nil and (slot.count or 0) > 0 then
    ability.slot = slot
    BlzFrameSetVisible(slot.icon, true)
    ...
```

`disasm --find NAME` is the tool for investigating a construct a decompiler got
wrong — see [docs/luac-format.md](docs/luac-format.md).

## The license

The AES key comes from a 64-bit **license** that is account bound, so it cannot
be published: your containers are encrypted for your license and nobody else's.
You do not have to supply it, though.  `w3xd` recovers it from the container:

* the trailer has 22 bytes that must all be zero — known plaintext;
* layer 1 is linear over GF(2) and advances one state step per byte.

Together those turn 22 known bytes into 176 linear equations in the 32 unknown
bits of the xorshift state, solved by Gaussian elimination in milliseconds.
Random data satisfies them with probability about `2⁻¹⁴⁴`, which is also what
makes blind scanning for containers practical.

```console
$ w3xd license HumanRE01.w3xd
0x0123456789abcdef

$ w3xd info HumanRE01.w3xd --key-material
  buffer A    : efcdab896745230157334d4541455330
  buffer B    : efcdab896745230157334d4541455331
  SHA1(A)     : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e42
  SHA1(B)     : 1eb3507d6a2d8aa975ba29ad010dfe2c436f7a4c
```

**Your license value is yours.** It is not in this repository, it is not a
constant, and you should not publish it: with it, your containers can be
decrypted by anyone.  Deriving it is a local, offline operation.

Full detail: [docs/recovering-the-license.md](docs/recovering-the-license.md).

## Format documentation

The reference documents are in English; this README is also available in
[简体中文](README.zh-CN.md).

| document | contents |
|---|---|
| [docs/container-format.md](docs/container-format.md) | `.w3xd` layout, both crypto layers, the trailer, the RVAs they came from |
| [docs/recovering-the-license.md](docs/recovering-the-license.md) | the known-plaintext recovery, step by step |
| [docs/mpq-quirks.md](docs/mpq-quirks.md) | the three things these archives do to MPQ that break stock readers |
| [docs/luac-format.md](docs/luac-format.md) | the Blizzard Lua 5.3 build, the string length encoding, decompiling |
| [docs/reverse-engineering.md](docs/reverse-engineering.md) | method, address table, and what did not work |

## Scanning a CASC install

Because the container test is so selective, every `.w3xd` in a CASC store can
be found without a file manifest: decode each `BLTE` blob and fingerprint the
result.  The fingerprint is the same 176-equation system, so a hit is a
container with overwhelming probability.

The scanner used during development is not included here (it is a few hundred
lines of CASC-specific plumbing), but the shape of it is:

1. walk `Data/data/data.NNN`, find every `BLTE` signature;
2. parse the modern BLTE header — `headerSize` at `+4`, chunk count at `+10`,
   descriptors at `+12` as `{u32 encodedSize, u32 decodedSize, u8 md5[16]}`, and
   note that `headerSize == 12 + 24 * chunkCount`;
3. inflate the last chunk only, which is enough for the fingerprint;
4. on a hit, decode the whole blob and hand it to `w3xd`.

A full pass over a 34 GB install takes a couple of minutes.

## Repository layout

```
w3xd-toolkit/
├── w3xd/                  container toolkit
│   ├── xorshift.py            layer 1
│   ├── aes.py                 AES-256 (pure Python + Windows CNG)
│   ├── ccm.py                 AES-256-CCM, L=5
│   ├── kdf.py                 SHA-1 based key derivation
│   ├── container.py           layout, license recovery, decryption
│   ├── mpq.py                 MPQ reader with the three quirks handled
│   └── cli.py                 command line interface
├── luac53/                Lua 5.3 bytecode toolkit
│   ├── chunk.py               reader/writer/transcoder
│   ├── disasm.py              disassembler
│   └── cli.py                 command line interface
├── docs/                  format documentation
├── scripts/               unluac fetcher, batch helpers
├── tests/                 53 unit tests, no game data required
└── examples/              worked example
```

## Contributing

Contributions are welcome — documentation corrections especially, since this
project's whole value is that its claims are checkable.

Three rules are not negotiable:

1. **No game data, keys or decompiled game content** in a commit.
2. **No new runtime dependencies.** The package installs and runs with none.
3. **Every format-touching change needs a test** that passes on a clean checkout
   with no game files present.

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request; it also
explains how to build a synthetic test vector and how to report a format
discrepancy without pasting anything you should not.  In short:

```bash
python -m unittest discover -s tests -t .      # must pass
```

## Legal

This is an interoperability and research tool for a game you own.  Before using
it, or publishing anything derived from it:

* **No game data is included here.**  The repository contains no maps, no
  assets, no keys and no Blizzard code.  Keep it that way — do not commit the
  contents of `*.files/`, `*.w3x` or a recovered license value.
* **Keys are account bound.**  A recovered license only decrypts containers
  issued for that account.  Do not publish yours.
* **Do not redistribute extracted assets.**  Decrypting maps you own, for your
  own study, modding or tooling, is one thing; republishing Blizzard's art,
  audio, terrain or scripts is another, and the EULA forbids it.
* **Do not use this to circumvent access controls on content you have not
  licensed.**  Campaign maps you can download are maps you are entitled to play;
  that entitlement does not extend to redistributing them.

Blizzard's EULA prohibits circumventing technical protection measures and
redistributing game resources.  This project exists for format analysis,
preservation research and interoperability; use it accordingly.  Warcraft,
Warcraft III and Blizzard Entertainment are trademarks of Blizzard
Entertainment, Inc.  This project is not affiliated with or endorsed by them.

## License

MIT — see [LICENSE](LICENSE).
