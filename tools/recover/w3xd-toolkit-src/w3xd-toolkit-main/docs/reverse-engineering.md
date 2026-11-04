# How this was reversed

Notes on the method and the addresses, so the work can be checked and extended.
Target: `Warcraft III.exe` 3.0.0.24268, x86-64, image base `0x140000000`.
Offsets below are RVAs.

## Finding the code

`Warcraft III.exe` ships with its `.text` encrypted on disk (entropy 7.9998)
and only the bootstrap page in the clear; the rest is decrypted per page on
demand by `war3_loader.dll`, which the executable imports as a single ordinal.
Static analysis of the file on disk is therefore useless.

Reading the code needs a memory image of a *running* process.  Once one is
available, `.pdata` still describes 135,606 function boundaries, which makes
structure recovery straightforward even where a linear disassembler would
desynchronise on embedded jump tables.  Use a **recursive-descent** sweep
(`tools/` in the analysis workspace does this); a linear sweep over a function
containing a jump table produces plausible but wrong instructions, which is an
easy way to waste an afternoon.

The entry points are easy to find because the game logs its own errors: the
strings next to the crypto code read

```
[War3MECrypto ERROR] TryEncryptAes256Ccm: ...
```

so the crypto cluster is located by xref from those strings.

## The crypto cluster

| RVA | role |
|---|---|
| `0x1511910` | layer-1 xorshift32 XOR over the whole file |
| `0x1511980` | `DeriveKey(license, out32, 32)` |
| `0x1511AC0` | `TryDecryptAes256Ccm` |
| `0x1511C20` | `TryEncryptAes256Ccm` (dead in the shipped build) |
| `0x1511F40` | trailer validation |
| `0x1512030` | reads the 16-bit header size |
| `0x1512040` | returns the stored license |
| `0x15113C0` | the driver: reads the file, checks it, decrypts the payload |
| `0x1ED6150` / `0x1ED94D0` / `0x1ED9B20` | AES-CCM module (AES-NI / SSSE3 / software) |

`TryEncryptAes256Ccm` has no callers: only the decryption path ships.  That is
the first hint that the encryption side lives in Blizzard's build pipeline, and
it is why the container format and the `@D:\Jenkins\workspace\...` build path
in the Lua chunk names both point at the same offline tooling.

## Reading the trailer without running the game

`sub_1511F40` is short and completely plain, and reading it is what unlocked
everything:

```asm
0x01511f40  cmp  byte ptr [rcx], 1        ; version
0x01511f45  cmp  word ptr [rcx+2], 0x40   ; block size
0x01511f4c  cmp  word ptr [rcx+4], dx     ; header size
0x01511f52  cmp  qword ptr [rcx+6], r8    ; payload size
0x01511f58  cmp  qword ptr [rcx+0xe], r9  ; license
0x01511f5e  xor  eax, eax
0x01511f60  cmp  byte ptr [rcx+rax+0x16], 0    ; 22 zero bytes
0x01511f65  jne  0x1511f73
0x01511f67  inc  rax
0x01511f6a  cmp  rax, 0x16
0x01511f6e  jb   0x1511f60
```

The 22-byte zero check is the known plaintext, and `sub_1511910` being linear
turns that into a solvable system.  Neither fact is useful alone; together they
remove the need for a key entirely.

## What did *not* work

Recorded so the same ground is not covered twice:

* **Treating the `.w3xd` as MPQ.**  No magic, no listfile, nothing in the clear.
  The file is a container, not a protected archive.
* **Blaming CASC.**  Scanning the CASC data files showed the `.w3xd` blobs are
  stored as plaintext `BLTE('Z')` with no CASC-layer encryption, so what
  CascView exports is exactly what the game reads.  The encryption is part of
  the *format*.
* **Hunting the key in memory.**  A whole-dump AES key-schedule scan finds
  exactly one structurally valid AES-256 schedule, and it is not the map key.
  Everything relevant is derived on demand and freed.
* **Attaching a debugger.**  Workable in principle, but the launcher's
  protection reacts badly and the same result is available statically.
* **Searching local configuration for the license.**  It is not in any file the
  game ships; it arrives from the platform layer at runtime.  Ten million
  candidate values from local configuration produced nothing, which is expected
  in hindsight — the container itself is the only place it can be read, and it
  is encrypted.

## Reproducing a check

Everything in this repository can be verified without the game:

```
python -m unittest discover -s tests -t .
```

The tests build synthetic containers and MPQ archives and round-trip every
cryptographic layer, so a change that breaks the format is caught immediately.
