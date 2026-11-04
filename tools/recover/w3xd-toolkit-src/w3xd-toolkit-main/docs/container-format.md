# The `.w3xd` container format

Everything below was recovered from the disassembly of `Warcraft III.exe`
3.0.0.24268 (the "Forsaken Kingdom" build).  Function offsets are RVAs in that
binary.  Every claim in this document is also enforced by `tests/`.

## Why the file cannot simply be opened

A `.w3xd` is **not** an MPQ and it is **not** CASC-encrypted.  The bytes in the
CASC store are the final container; the encryption is part of the file format,
applied by the game before storing the map:

```
.w3xd on disk
   |
   |  layer 1: xorshift32 XOR over the whole file   (sub_1511910)
   v
container, cleartext structure
   |
   |  layer 2: AES-256-CCM over the payload          (sub_1511AC0)
   v
plain MPQ archive  ==  a normal .w3x map
```

Tools that only speak MPQ (CascView, MPQ editors) therefore see random bytes,
and the World Editor refuses the file.  There is no header, magic or listfile
in cleartext to recognise it by.

## Layer 1 — xorshift32 XOR (RVA `0x1511910`)

```c
uint32_t s = (size >> 32) ^ (license >> 32)
           ^ (uint32_t)size ^ (uint32_t)license
           ^ 0xB9E37739;
if (s == 0) s = 1;                       // cmove eax, 1
for (i = 0; i < size; i++) {
    s ^= s << 13;                        // 32-bit operations throughout
    s ^= s >> 17;
    s ^= s << 5;
    buf[i] ^= (uint8_t)s;                // low byte of the new state
}
```

The core loop at `0x1511950`:

```asm
0x01511950  mov  ecx, eax
0x01511952  lea  r10, [r10+1]
0x01511956  shl  ecx, 0xd      ; s << 13
0x01511959  xor  eax, ecx
0x0151195b  mov  ecx, eax
0x0151195d  shr  ecx, 0x11     ; s >> 17
0x01511960  xor  eax, ecx
0x01511962  mov  ecx, eax
0x01511964  shl  ecx, 5        ; s << 5
0x01511967  xor  eax, ecx
0x01511969  xor  byte ptr [r10-1], al
0x0151196d  sub  rdx, 1
0x01511971  jne  0x1511950
```

One state step per byte, so the byte at offset `p` is `low8(S[p+1])`, where
`S[0]` is the seed above.  The whole file is covered, header and trailer
included.

The seed depends on the license only through `license >> 32 ^ (uint32)license`
— a single unknown 32-bit word, which is what makes recovery possible
(see [recovering-the-license.md](recovering-the-license.md)).

## Layer 2 — AES-256-CCM (RVA `0x1511AC0`)

```
TryDecryptAes256Ccm(inOut /*rcx*/, size /*rdx*/, license /*r8*/,
                    nonce /*r9, 10 bytes*/, tag /*stack, 16 bytes*/)
```

```asm
0x01511ade  mov   rdi, [rsp+0x500]     ; tag pointer
0x01511b28  call  DeriveKey            ; DeriveKey(license, &key32, 32)
0x01511b3a  movzx eax, word [rbx+8]    ; nonce is read as 8 + 2 bytes
0x01511b6c  movsd xmm0, qword [rbx]
0x01511bef  call  0x1ed94d0            ; CCM: edx = 0x10 (tag), r8d = 5 (L)
```

`r8d = 5` is the CCM `L` parameter, so the nonce is `15 - 5 = 10` bytes and
the tag is 16 bytes.  The call sets the associated-data length to zero
(`[rsp+0x20] = 0`), so plain RFC 3610 CCM with no AAD.

### Key derivation (RVA `0x1511980`)

```asm
0x015119b9..0x015119fe   le64(license) stored byte by byte at [rbp-9]
0x01511a05  mov dword [rbp-1], 0x454D3357   ; "W3ME"
0x01511a0c  mov dword [rbp+3], 0x30534541   ; "AES0"
0x01511a17  movdqa [rbp+0x37], xmm0         ; same 16 bytes to a second buffer
0x01511a23  mov byte [rbp+0x46], 0x31       ; '1' -> last byte becomes "W3MEAES1"
```

```
hash1 = SHA1( le64(license) || "W3MEAES0" )        # 20-byte digest
hash2 = SHA1( le64(license) || "W3MEAES1" )

key[ 0:16] = hash1[ 0:16]
key[16:20] = hash1[16:20]
key[20:28] = hash2[ 0: 8]
key[28:32] = hash2[ 8:12]
```

Equivalently `key = SHA1(le64(license) + b"W3MEAES0")[0:20]
                  + SHA1(le64(license) + b"W3MEAES1")[0:12]`.

Note that the hash is **SHA-1**, not SHA-256: the code reads 20 bytes out of
each digest.  `w3xd info --key-material` reproduces this.

## Container layout (after layer 1)

The length is the length of the *whole file*; the trailer sits at the very end
and the game validates it field by field in `sub_1511F40`.

```
offset 0x00                  prefix
offset 0x47   10 bytes       CCM nonce
offset 0x51    2 bytes
offset 0x53   16 bytes       CCM tag
offset 0x63 .. hdr_size      rest of the header
offset hdr_size              payload_size bytes of AES-256-CCM ciphertext
offset size-0x40   64 bytes  trailer
```

The payload pointer the game uses is `buffer + hdr_size` and its length is
`size - hdr_size - 0x40`, computed at `0x1511534`–`0x1511544`:

```asm
0x01511534  lea  rcx, [rsi - 0x40]
0x0151153b  add  rcx, r14        ; rcx = buffer + size - 0x40   (the trailer)
0x0151153e  mov  r8, r15         ; payload size
0x01511541  movzx edx, bx        ; header size (16-bit, read from the file)
0x01511544  call sub_1511F40     ; validate
```

### Trailer

```
+0x00  u8  = 1                    container version
+0x01  u8  = 6                    flags
+0x02  u16 = 0x40                 size of this block
+0x04  u16 = hdr_size             >= 0x6c
+0x06  u64 = payload_size
+0x0e  u64 = license              64-bit product license
+0x16  22 zero bytes              known plaintext -- see below
+0x2c  20 byte digest
```

`sub_1511F40` checks, in order: byte 0 == 1, word 2 == 0x40, word 4 == the
16-bit header size, qword 6 == the payload size, qword 0x0e == the license,
and that all 22 bytes from 0x16 to 0x2c are zero.

The 16-bit header size is read from the stream object by `sub_1512030`, and
`sub_1512040` returns the stored license, which `0x1511501` compares against
the session license:

```asm
0x015114fc  call sub_1512040
0x01511501  cmp  rax, r13        ; r13 = session license
0x01511504  je   0x1511534
```

So every container is bound to the license it was produced for.  All campaign
maps shipped to one account share that account's license.

## Sizes seen in a shipped build

The header size is not constant — it varies per map (it is 16-bit and read from
the file):

| file | size | hdr_size | payload |
|---|---|---|---|
| `HumanRE01.w3xd` | 5,623,218 | 334 (`0x14e`) | 5,622,820 |
| `HumanRE02.w3xd` | 1,472,083 | 129 (`0x81`) | 1,471,890 |
| `HumanRE02Interlude.w3xd` | 528,645 | 154 (`0x9a`) | 528,427 |

In every case `hdr_size + payload_size + 0x40 == file size`, and the embedded
MPQ's `archiveSize` is `payload_size - 260`.

## The plaintext

The payload decrypts to an ordinary MPQ archive containing the usual map
members — `war3map.w3i`, `war3map.w3e`, `war3map.wts`, `war3map.luac`,
`war3map.wct`, imported assets and so on.  See
[mpq-quirks.md](mpq-quirks.md) for the three things this build does to MPQ
that a stock reader mishandles.
