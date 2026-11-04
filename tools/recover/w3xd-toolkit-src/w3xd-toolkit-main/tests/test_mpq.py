"""MPQ reader tests, including the three quirks of these archives.

The archive is built from scratch here, so the tests exercise the reader's
sector-offset-table handling, the hash-table index type and the inflate
fallback without needing any game data.
"""

import os
import struct
import sys
import tempfile
import unittest
import zlib

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from w3xd import mpq as M                                  # noqa: E402

FILE_NAME = "war3map.w3e"
CONTENT = b"W3E!" + bytes((i * 11) & 0xFF for i in range(9000))


def build_mpq(name=FILE_NAME, content=CONTENT, sector_size=4096):
    """A one-member MPQ laid out the way these archives are."""
    nsectors = (len(content) + sector_size - 1) // sector_size
    sectors = []
    for i in range(nsectors):
        chunk = content[i * sector_size:(i + 1) * sector_size]
        sectors.append(bytes([0x02]) + zlib.compress(chunk))
    table_size = (nsectors + 1) * 4
    offs = [table_size]
    for s in sectors:
        offs.append(offs[-1] + len(s))
    file_data = struct.pack("<%dI" % (nsectors + 1), *offs) + b"".join(sectors)

    header_size = 32
    data_pos = header_size
    ht_pos = data_pos + len(file_data)
    ht_count, bt_count = 16, 1
    bt_pos = ht_pos + ht_count * 16
    arch_size = bt_pos + bt_count * 16

    # hash table: put the entry exactly where the probe starts, pad with empties
    idx = M.hashes(name, M.HASH_TABLE_INDEX) & (ht_count - 1)
    entries = [(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFF, 0xFFFF, 0xFFFFFFFF)] * ht_count
    entries[idx] = (M.hashes(name, M.HASH_NAME_A), M.hashes(name, M.HASH_NAME_B),
                    0, 0, 0)
    ht = b"".join(struct.pack("<IIHHI", *e) for e in entries)
    ht = M.mpq_encrypt(ht, M.hashes("(hash table)", M.HASH_FILE_KEY))

    flags = M.FLAG_EXISTS | M.FLAG_COMPRESS
    bt = struct.pack("<IIII", data_pos, len(file_data), len(content), flags)
    bt = M.mpq_encrypt(bt, M.hashes("(block table)", M.HASH_FILE_KEY))

    header = struct.pack("<4sIIHHIIII", M.MPQ_MAGIC, header_size, arch_size, 0,
                         3, ht_pos, bt_pos, ht_count, bt_count)
    return header + file_data + ht + bt


class TestMpq(unittest.TestCase):
    def setUp(self):
        self.data = build_mpq()

    def test_header(self):
        m = M.MPQ.from_bytes("mem", self.data)
        self.assertEqual(m.hdr_size, 32)
        self.assertEqual(m.sector_size, 4096)
        self.assertEqual(m.ht_count, 16)
        self.assertEqual(m.bt_count, 1)

    def test_name_lookup_uses_hash_type_0(self):
        m = M.MPQ.from_bytes("mem", self.data)
        self.assertEqual(m.find(FILE_NAME), 0)
        # looking the entry up with hash type 3 (FILE_KEY) as the index would
        # miss it whenever the two indices differ
        idx0 = M.hashes(FILE_NAME, M.HASH_TABLE_INDEX) & (m.ht_count - 1)
        idx3 = M.hashes(FILE_NAME, M.HASH_FILE_KEY) & (m.ht_count - 1)
        self.assertEqual(m.hash_table[idx0][4], 0)
        if idx3 != idx0:
            self.assertEqual(m.hash_table[idx3][4], 0xFFFFFFFF)

    def test_sector_offset_table_is_present(self):
        # offset[0] == (nsectors+1)*4 without the member being encrypted
        ns = (len(CONTENT) + 4095) // 4096
        first = struct.unpack_from("<I", self.data, 32)[0]
        self.assertEqual(first, (ns + 1) * 4)
        m = M.MPQ.from_bytes("mem", self.data)
        self.assertEqual(m.read(FILE_NAME), CONTENT)

    def test_multi_sector_content(self):
        content = bytes((i * 13) & 0xFF for i in range(4096 * 3 + 77))
        data = build_mpq(content=content)
        m = M.MPQ.from_bytes("mem", data)
        self.assertEqual(m.read(FILE_NAME), content)

    def test_slash_and_backslash_are_equivalent(self):
        data = build_mpq(name="doodads\\foo.mdx", content=b"x" * 200)
        m = M.MPQ.from_bytes("mem", data)
        self.assertEqual(M.norm_name("a/b/c"), "a\\b\\c")
        self.assertEqual(m.find("doodads/foo.mdx"), m.find("doodads\\foo.mdx"))
        self.assertEqual(m.find("doodads/foo.mdx"), 0)

    def test_wrong_name_is_not_found(self):
        m = M.MPQ.from_bytes("mem", self.data)
        self.assertIsNone(m.find("no/such/file"))

    def test_missing_listfile(self):
        m = M.MPQ.from_bytes("mem", self.data)
        self.assertEqual(m.list_names(), [])

    def test_members_falls_back_to_standard_names(self):
        m = M.MPQ.from_bytes("mem", self.data)
        got = dict(m.members())
        self.assertEqual(got[FILE_NAME], CONTENT)

    def test_extract_writes_files(self):
        m = M.MPQ.from_bytes("mem", self.data)
        with tempfile.TemporaryDirectory() as d:
            written = m.extract(d)
            self.assertEqual(len(written), 1)
            path = os.path.join(d, "war3map.w3e")
            self.assertTrue(os.path.isfile(path))
            with open(path, "rb") as fh:
                self.assertEqual(fh.read(), CONTENT)

    def test_inflate_ignores_a_bad_trailing_checksum(self):
        good = zlib.compress(CONTENT)
        broken = good[:-4] + b"\x00\x00\x00\x00"
        self.assertEqual(M.inflate(broken), CONTENT)

    def test_mpq_encrypt_inverts_mpq_decrypt(self):
        blob = bytes(range(64))
        key = 0x12345678
        self.assertEqual(M.mpq_decrypt(M.mpq_encrypt(blob, key), key), blob)
        self.assertEqual(M.mpq_encrypt(M.mpq_decrypt(blob, key), key), blob)

    def test_mpq_decrypt_is_not_an_involution(self):
        # seed2 evolves from the plaintext, so decrypting twice is not identity
        blob = bytes(range(64))
        key = 0x12345678
        self.assertNotEqual(M.mpq_decrypt(M.mpq_decrypt(blob, key), key), blob)

    def test_extract_rejects_parent_traversal(self):
        data = build_mpq(name="..\\escape.txt", content=b"x" * 100)
        m = M.MPQ.from_bytes("mem", data)
        with tempfile.TemporaryDirectory() as d:
            m.extract(d)
            self.assertFalse(os.path.exists(os.path.join(os.path.dirname(d), "escape.txt")))

    def test_not_an_mpq(self):
        with self.assertRaises(ValueError):
            M.MPQ.from_bytes("mem", b"not an mpq" + bytes(100))


if __name__ == "__main__":
    unittest.main()
