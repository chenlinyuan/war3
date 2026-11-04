"""luac53: chunk parsing, conversion and the string length encoding."""

import os
import struct
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from luac53 import chunk                                    # noqa: E402


def sample_proto():
    """A prototype exercising every constant type and a >0xFF long string."""
    long_string = b"Sound\\Music\\mp3Music\\Track.ogg;" * 12       # 360 bytes
    sub = {
        "source": None, "linedefined": 7, "lastlinedefined": 9,
        "numparams": 2, "is_vararg": 0, "maxstacksize": 4,
        "code": [0x00000001, 0x00000002], "consts": [("int", 1)],
        "upvals": [(0, 0)], "protos": [],
        "lineinfo": [7, 8], "locvars": [(b"a", 0, 2)],
        "upnames": [b"_ENV"],
    }
    return {
        "source": b"@C:\\build\\war3map.lua",
        "linedefined": 0, "lastlinedefined": 0,
        "numparams": 0, "is_vararg": 1, "maxstacksize": 190,
        "code": [0x00000001, 0x80000002, 0x00000003],
        "consts": [
            ("nil", None),
            ("bool", 1),
            ("num", 1.5),
            ("num", 370.5),
            ("int", 300000),
            ("int", -7),
            ("str", b"udg_F1_Player02_User"),
            ("str", long_string),
            ("str", b""),
        ],
        "upvals": [(0, 0)],
        "protos": [sub],
        "lineinfo": [10, 11, 12],
        "locvars": [(b"x", 0, 3), (b"y", 1, 2)],
        "upnames": [b"_ENV"],
    }


class TestHeader(unittest.TestCase):
    def test_stock_header_is_33_bytes(self):
        h = chunk.make_header(*chunk.STOCK)
        self.assertEqual(len(h), 33)
        self.assertEqual(chunk.read_header(h)["header_size"], 33)

    def test_blizzard_header_is_25_bytes(self):
        h = chunk.make_header(*chunk.BLIZZARD)
        self.assertEqual(len(h), 25)
        info = chunk.read_header(h)
        self.assertEqual(info["header_size"], 25)
        self.assertEqual(info["sizeof_lua_integer"], 4)
        self.assertEqual(info["sizeof_lua_number"], 4)

    def test_rejects_other_versions(self):
        bad = bytearray(chunk.make_header(*chunk.STOCK))
        bad[4] = 0x52
        self.assertRaises(chunk.LuaChunkError, chunk.read_header, bytes(bad))

    def test_rejects_garbage(self):
        self.assertRaises(chunk.LuaChunkError, chunk.read_header, b"nope" * 32)


class TestStringSizeEncoding(unittest.TestCase):
    """Lua 5.3 dumpSize: one byte, or 0xFF followed by a size_t."""

    def encode(self, n):
        w = chunk.ChunkWriter(chunk.BLIZZARD)
        w.size(n)
        return bytes(w.out[len(chunk.make_header(*chunk.BLIZZARD)):])

    def test_short_sizes_are_one_byte(self):
        self.assertEqual(self.encode(1), b"\x01")
        self.assertEqual(self.encode(0x15), b"\x15")
        self.assertEqual(self.encode(0xFE), b"\xfe")

    def test_large_sizes_use_the_0xff_escape(self):
        out = self.encode(0x102)
        self.assertEqual(out[0], 0xFF)
        self.assertEqual(struct.unpack_from("<Q", out, 1)[0], 0x102)
        self.assertEqual(len(out), 9)

    def test_roundtrip_through_a_reader(self):
        for n in (0, 1, 0x15, 0xFE, 0xFF, 0x100, 0x102, 0xFFFF, 1 << 20):
            w = chunk.ChunkWriter(chunk.BLIZZARD)
            w.size(n)
            r = chunk.ChunkReader(bytes(w.out), chunk.BLIZZARD)
            r.p = len(chunk.make_header(*chunk.BLIZZARD))
            self.assertEqual(r.size(), n, n)


class TestRoundTrip(unittest.TestCase):
    def build(self, sizes):
        w = chunk.ChunkWriter(sizes)
        w.byte(1)
        w.write_function(sample_proto())
        return bytes(w.out)

    def test_blizzard_chunk_parses(self):
        data = self.build(chunk.BLIZZARD)
        _h, nup, main, stats = chunk.parse(data, chunk.BLIZZARD)
        self.assertEqual(nup, 1)
        self.assertEqual(main["maxstacksize"], 190)
        self.assertEqual(len(main["protos"]), 1)
        self.assertEqual(stats["consts"], 10)          # 9 + the sub prototype's 1
        self.assertEqual(main["consts"][4], ("int", 300000))

    def test_convert_to_stock_preserves_constants(self):
        src = self.build(chunk.BLIZZARD)
        out, stats = chunk.convert(src)
        self.assertTrue(chunk.looks_like_stock(out))
        hdr = chunk.read_header(out)
        self.assertEqual(hdr["sizeof_lua_integer"], 8)
        self.assertEqual(hdr["sizeof_lua_number"], 8)
        _h, nup, main, _s = chunk.parse(out, chunk.STOCK)
        self.assertEqual(nup, 1)
        expect = sample_proto()
        self.assertEqual(main["consts"], expect["consts"])
        self.assertEqual(main["code"], expect["code"])
        self.assertEqual(main["protos"][0]["consts"], expect["protos"][0]["consts"])
        self.assertEqual(main["source"], expect["source"])
        self.assertEqual(main["locvars"], expect["locvars"])

    def test_float32_becomes_exact_double(self):
        src = self.build(chunk.BLIZZARD)
        out, _ = chunk.convert(src)
        _h, _n, main, _s = chunk.parse(out, chunk.STOCK)
        self.assertEqual(main["consts"][2], ("num", 1.5))
        self.assertEqual(main["consts"][3], ("num", 370.5))

    def test_long_string_uses_the_escape(self):
        src = self.build(chunk.BLIZZARD)
        # the 360 byte constant must be stored as 0xFF + size_t in both flavours
        self.assertIn(b"\xff", src)
        out, _ = chunk.convert(src)
        _h, _n, main, _s = chunk.parse(out, chunk.STOCK)
        self.assertEqual(main["consts"][7][1], sample_proto()["consts"][7][1])

    def test_stock_chunk_is_left_alone(self):
        stock = self.build(chunk.STOCK)
        out, _ = chunk.convert(stock)
        self.assertEqual(out, stock)

    def test_instruction_stream_is_copied_verbatim(self):
        src = self.build(chunk.BLIZZARD)
        out, _ = chunk.convert(src)
        _h, _n, a, _s = chunk.parse(src, chunk.BLIZZARD)
        _h2, _n2, b, _s2 = chunk.parse(out, chunk.STOCK)
        self.assertEqual(a["code"], b["code"])

    def test_desynchronised_chunk_raises(self):
        src = bytearray(self.build(chunk.BLIZZARD))
        del src[len(src) // 2:len(src) // 2 + 5]
        self.assertRaises(chunk.LuaChunkError, chunk.parse, bytes(src), chunk.BLIZZARD)


class TestDisasm(unittest.TestCase):
    def test_decode_fields(self):
        from luac53 import disasm
        d = disasm.decode(0x00000001)
        self.assertEqual(d["name"], "LOADK")
        self.assertEqual(d["A"], 0)

    def test_find_proto_by_constant(self):
        from luac53 import disasm
        w = chunk.ChunkWriter(chunk.BLIZZARD)
        w.byte(1)
        w.write_function(sample_proto())
        hits = disasm.find_protos(bytes(w.out), "udg_F1_Player02_User")
        self.assertEqual(len(hits), 1)
        self.assertEqual(hits[0][0], "main")

    def test_listing_mentions_the_constant(self):
        from luac53 import disasm
        w = chunk.ChunkWriter(chunk.BLIZZARD)
        w.byte(1)
        w.write_function(sample_proto())
        hits = disasm.find_protos(bytes(w.out), "udg_F1_Player02_User")
        text = disasm.format_proto(hits[0][0], hits[0][1])
        self.assertIn("LOADK", text)
        self.assertIn("udg_F1_Player02_User", text)


if __name__ == "__main__":
    unittest.main()
