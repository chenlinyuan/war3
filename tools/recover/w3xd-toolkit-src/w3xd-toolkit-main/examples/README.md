# Examples

These walk through what the tools do.  No game files are included in this
repository, so bring your own `.w3xd` — the commands below use
`HumanRE02Interlude.w3xd` as the example name.

## 1. Look before you leap

```console
$ w3xd info HumanRE02Interlude.w3xd --payload
file          : HumanRE02Interlude.w3xd
size          : 528,645 bytes
xorshift seed : 0x86c7da45  (matches size/license formula: True)
trailer       : version=1 flags=6 block_size=0x40
header size   : 154
payload size  : 528,427 bytes
license       : 0x0123456789abcdef
AES-256 key   : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e421eb3507d6a2d8aa975ba29ad
nonce offset  : 0x47
tag offset    : 0x53
payload       : 528,427 bytes, magic b'MPQ\x1a'
```

Three things are worth noticing:

* the seed the solver found matches the documented `(size, license)` formula,
  which is an independent check that the whole thing decoded correctly;
* `154 + 528,427 + 64 = 528,645`, the file size — the trailer validates;
* the payload magic is `MPQ\x1a`, so layer 2 came off cleanly.

If any of those failed you would get an error rather than output.

## 2. Decrypt and extract

```console
$ w3xd unpack HumanRE02Interlude.w3xd
license 0x0123456789abcdef -> HumanRE02Interlude.w3x (528,427 bytes)
46 members (46 named), 1,998,536 bytes -> HumanRE02Interlude.files
total 0.3s
```

The `.w3x` is a normal Warcraft III map: the World Editor opens it, MPQ tools
read it, and `w3xd extract` can pull members out of it later.

`HumanRE02Interlude.files/` mirrors the original archive paths, including
imported assets:

```
war3map.w3i      war3map.w3e   war3map.wts    war3map.luac   war3map.wct
war3map.doo      war3map.wpm   war3map.shd    war3map.imp    war3map.mmp
war3map.w3grp    war3map.w3l   conversation.json
```

The names come from the archive's own `(listfile)`, which is encrypted — the
reader recovers its key from known plaintext (see
[../docs/mpq-quirks.md](../docs/mpq-quirks.md)).

## 3. Decompile the script

```console
$ scripts/get-unluac.sh          # once
$ luac53 decompile HumanRE02Interlude.files/war3map.luac
war3map.luac -> war3map.lua (498,884 bytes)
```

The result is readable Lua 5.3:

```lua
udg_F1_Player02_User = nil
udg_Cin_Skipped = false
udg_Cache_CampaignName = ""
udg_Cache_MapNames = __jarray("")
gg_rct_Fog_01 = nil
gg_cam_Cin_A_01 = nil
gg_snd_HRE02I_M010_010_GAREK = nil
```

Those are the standard Warcraft III generated globals: `udg_` user variables,
`gg_rct_` regions, `gg_cam_` cameras, `gg_snd_` sounds.

## 4. When a decompiler gets something wrong

Decompilers occasionally mis-nest a construct.  The bytecode is the source of
truth:

```console
$ luac53 disasm HumanRE02Interlude.files/war3map.luac --find updateSlot
proto main/696/12  params=1 vararg=0 maxstack=7 code=44
constants:
   [ 0] str   b'ability'
   [ 2] str   b'count'
   [ 8] str   b'slot'
code:
  [   0] L18488  GETTABLE  A=1   B=0    C=256   C=K[0]b'ability'
  [   1] L18489  EQ        A=1   B=1    C=257   C=K[1]nil  (skip next when false)
  [   2] L18489  JMP       A=0   B=256  C=5     -> pc 9
  [   3] L18489  GETTABLE  A=2   B=0    C=258   C=K[2]b'count'
  [   7] L18489  LE        A=0   B=2    C=259   C=K[3]0  (skip next when false)
  [   8] L18489  JMP       A=0   B=256  C=8     -> pc 18
  [   9] L18490  GETTABUP  A=2   B=0    C=260   C=K[4]b'BlzFrameSetVisible'
  ...
  [  18] L18493  SETTABLE  A=1   B=264  C=0     B=K[8]b'slot'
```

Jumps to `pc 18` come from both `ability == nil` and `count <= 0`, so the
condition is `ability ~= nil and (slot.count or 0) > 0` — which is what the
branch structure should have said.

## 5. Batch

```console
$ scripts/unpack-all.sh /path/to/extracted
== decrypting containers ==
HumanRE01.w3xd   5,623,218 -> HumanRE01.w3x  hdr=334  payload=5,622,820  ...
...
20/20 decrypted

== decompiling war3map.luac ==
war3map.luac -> war3map.lua (1,945,651 bytes)
...
```

## Where to go next

* [../docs/container-format.md](../docs/container-format.md) — the byte-level format
* [../docs/recovering-the-license.md](../docs/recovering-the-license.md) — why no key is needed
* [../docs/luac-format.md](../docs/luac-format.md) — the Lua build and its one difference
* [../docs/reverse-engineering.md](../docs/reverse-engineering.md) — how it was worked out
