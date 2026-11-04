# MPQ quirks in these archives

The payload decrypts to a normal MPQ, but this build writes MPQ in a way that
a stock reader mishandles in three places.  All three are implemented in
`w3xd/mpq.py` and covered by `tests/test_mpq.py`.

## 1. The hash table index uses hash type 0

MPQ defines four hashes of a member name:

| type | constant | purpose |
|---|---|---|
| 0 | `MPQ_HASH_TABLE_INDEX` | start slot for the probe |
| 1 | `MPQ_HASH_NAME_A` | first comparison value |
| 2 | `MPQ_HASH_NAME_B` | second comparison value |
| 3 | `MPQ_HASH_FILE_KEY` | key for decrypting file data |

Using type 3 as the table index — an easy mistake, both are "the third hash" —
makes **every** name lookup fail, even though the names are present in the
table.  The symptom is a map that looks like it has no `war3map.*` members at
all and no `(listfile)`.

```python
idx = hashes(name, HASH_TABLE_INDEX) & (ht_count - 1)    # 0, not 3
```

## 2. Every sector-based member has a sector offset table

Stock MPQ only stores a sector offset table for *encrypted* members.  These
archives always store one, encrypted or not.  A stock reader therefore treats
the table as file data and everything after it shifts.

The table is easy to detect: its first entry is its own size.

```python
first = struct.unpack_from("<I", blob, 0)[0]
has_table = (first == (nsectors + 1) * 4)
```

`nsectors = ceil(file_size / sector_size)` and `sector_size = 512 << block_shift`.

## 3. The zlib streams have a wrong trailing Adler-32

Each sector is `[mask][data]` with `mask == 0x02` meaning zlib.  The deflate
data inflates correctly to exactly the declared size, but `zlib.decompress`
raises:

```
Error -3 while decompressing data: incorrect data check
```

Skipping the 2-byte zlib header and inflating as raw deflate avoids the
checksum and returns the full, correct data:

```python
zlib.decompressobj(-15).decompress(body[2:])
```

`w3xd.mpq.inflate` tries this first and falls back to normal zlib.

## Bonus: `(listfile)` and `(attributes)` are FIX_KEY encrypted

Both are present in these archives and both are real encrypted members rather
than the usual oddities of a "protected" map.  Their key does not follow the
standard derivation, but it does not need to be guessed either — the sector
offset table gives known plaintext.

The first word of a decrypted offset table must be `(nsectors + 1) * 4`, and
MPQ's first decrypted word is

```
plain0 = ct0 ^ (key + 0xEEEEEEEE + CRYPT[0x400 + (key & 0xFF)])
```

so the key follows directly for each of the 256 possible low bytes:

```python
for klo in range(256):
    seed2 = (0xEEEEEEEE + CRYPT[0x400 + klo]) & 0xFFFFFFFF
    key = ((ct0 ^ tsz) - seed2) & 0xFFFFFFFF
    if (key & 0xFF) != klo:
        continue
    # validate: decrypt the whole table, check it is monotonic and ends at csize
```

Once the table verifies, the member decrypts with `fileKey` and the usual
`fileKey + i` per sector.  Reading `(listfile)` is what makes a fully named
export possible, including the original directory tree.

## Note on MPQ encryption

MPQ's `decrypt` is **not** an involution: `seed2` evolves from the plaintext,
so decrypting twice does not return the input.  Writing an archive therefore
needs its own routine; `w3xd.mpq.mpq_encrypt` is the inverse, used by the
tests to build archives from scratch.
