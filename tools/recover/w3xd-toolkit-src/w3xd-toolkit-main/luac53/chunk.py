"""
Binary reader/writer for Lua 5.3 chunks, parameterised by constant widths.

A chunk uses four widths: ``int`` (4), ``size_t`` (8), ``Instruction`` (4), and
the two that vary between builds -- ``lua_Integer`` and ``lua_Number``::

    STOCK    = (8, 8)     # every stock Lua 5.3 build
    BLIZZARD = (4, 4)     # Warcraft III Reforged 3.0's build

The string length encoding -- one byte, or ``0xFF`` followed by a ``size_t`` --
is stock Lua 5.3 behaviour, *not* a Blizzard deviation (the 7-bit varint only
arrived in Lua 5.4; see unluac's ``LStringType53``).  So converting a Blizzard
chunk to a stock one only ever rewrites constant payloads; the instruction
stream is copied verbatim.
"""

import struct

SIGNATURE = b"\x1bLua"
VERSION_53 = 0x53

LUAC_DATA = bytes([0x19, 0x93, 0x0D, 0x0A, 0x1A, 0x0A])
LUAC_INT = 0x5678
LUAC_NUM = 370.5

STOCK = (8, 8)
BLIZZARD = (4, 4)

T_NIL, T_BOOL, T_NUMFLT, T_STR, T_NUMINT = 0, 1, 3, 4, 19
T_LNGSTR = 20                      # long strings are tagged separately here

HEADER_PREFIX = SIGNATURE + bytes([VERSION_53, 0x00]) + LUAC_DATA
SIZES = (4, 8, 4)                  # int, size_t, Instruction


class LuaChunkError(Exception):
    pass


def make_header(size_integer, size_number):
    """A 25-byte header for the Blizzard widths, 33 bytes for stock ones."""
    int_bytes = struct.pack("<i" if size_integer == 4 else "<q", LUAC_INT)
    num_bytes = struct.pack("<f" if size_number == 4 else "<d", LUAC_NUM)
    return (HEADER_PREFIX + bytes(SIZES + (size_integer, size_number))
            + int_bytes + num_bytes)


def read_header(data):
    if data[:4] != SIGNATURE:
        raise LuaChunkError("not a Lua chunk")
    if data[4] != VERSION_53:
        raise LuaChunkError("not Lua 5.3 (version %#x)" % data[4])
    if data[6:12] != LUAC_DATA:
        raise LuaChunkError("unexpected LUAC_DATA (wrong endianness or format)")
    vals = tuple(data[12:17])
    return {
        "version": data[4],
        "format": data[5],
        "sizeof_int": vals[0],
        "sizeof_size_t": vals[1],
        "sizeof_instruction": vals[2],
        "sizeof_lua_integer": vals[3],
        "sizeof_lua_number": vals[4],
        "header_size": 12 + 5 + vals[3] + vals[4],
    }


# ------------------------------------------------------------------ reading
class ChunkReader:
    def __init__(self, data, sizes=BLIZZARD):
        self.d = data
        self.size_integer, self.size_number = sizes
        self.p = 0

    def need(self, n):
        if self.p + n > len(self.d):
            raise LuaChunkError("read past end of chunk at %#x" % self.p)

    def byte(self):
        self.need(1)
        v = self.d[self.p]
        self.p += 1
        return v

    def i32(self):
        self.need(4)
        v = struct.unpack_from("<i", self.d, self.p)[0]
        self.p += 4
        return v

    def u32(self):
        self.need(4)
        v = struct.unpack_from("<I", self.d, self.p)[0]
        self.p += 4
        return v

    def u64(self):
        self.need(8)
        v = struct.unpack_from("<Q", self.d, self.p)[0]
        self.p += 8
        return v

    def lua_integer(self):
        self.need(self.size_integer)
        if self.size_integer == 4:
            v = struct.unpack_from("<i", self.d, self.p)[0]
        else:
            v = struct.unpack_from("<q", self.d, self.p)[0]
        self.p += self.size_integer
        return v

    def lua_number(self):
        self.need(self.size_number)
        if self.size_number == 4:
            v = struct.unpack_from("<f", self.d, self.p)[0]
        else:
            v = struct.unpack_from("<d", self.d, self.p)[0]
        self.p += self.size_number
        return v

    def size(self):
        """String length: one byte, or ``0xFF`` followed by a ``size_t``."""
        b = self.byte()
        if b == 0xFF:
            return self.u64()
        return b

    def string(self):
        n = self.size()
        if n == 0:
            return None
        self.need(n - 1)
        s = self.d[self.p:self.p + n - 1]
        self.p += n - 1
        return s

    # -------------------------------------------------------------- function
    def read_function(self, stats):
        f = {}
        f["source"] = self.string()
        f["linedefined"] = self.i32()
        f["lastlinedefined"] = self.i32()
        f["numparams"] = self.byte()
        f["is_vararg"] = self.byte()
        f["maxstacksize"] = self.byte()
        n = self.i32()
        _sane(n, 1 << 24, "code count")
        stats["code"] += n
        f["code"] = [self.u32() for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 24, "constant count")
        stats["consts"] += n
        f["consts"] = [self._read_const(stats) for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 16, "upvalue count")
        f["upvals"] = [(self.byte(), self.byte()) for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 16, "prototype count")
        stats["protos"] += n
        f["protos"] = [self.read_function(stats) for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 24, "lineinfo count")
        stats["lineinfo"] += n
        f["lineinfo"] = [self.i32() for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 20, "locvar count")
        stats["locvars"] += n
        f["locvars"] = [(self.string(), self.i32(), self.i32()) for _ in range(n)]
        n = self.i32()
        _sane(n, 1 << 20, "upvalue name count")
        stats["upnames"] += n
        f["upnames"] = [self.string() for _ in range(n)]
        return f

    def _read_const(self, stats):
        t = self.byte()
        if t == T_NIL:
            return ("nil", None)
        if t == T_BOOL:
            return ("bool", self.byte())
        if t == T_NUMFLT:
            return ("num", self.lua_number())
        if t == T_NUMINT:
            return ("int", self.lua_integer())
        if t in (T_STR, T_LNGSTR):
            stats["strings"] += 1
            return ("str", self.string())
        raise LuaChunkError("unknown constant type %d at %#x" % (t, self.p - 1))


def _sane(n, hi, what):
    if not (0 <= n <= hi):
        raise LuaChunkError("implausible %s (%d) -- chunk desynchronised" % (what, n))


def new_stats():
    return dict(code=0, consts=0, protos=0, strings=0,
                lineinfo=0, locvars=0, upnames=0)


def parse(data, sizes=None):
    """Parse a whole chunk; raises if it desynchronises.

    Returns ``(header, sizeupvalues, main_function, stats)``.
    """
    hdr = read_header(data)
    if sizes is None:
        sizes = (hdr["sizeof_lua_integer"], hdr["sizeof_lua_number"])
    r = ChunkReader(data, sizes)
    r.p = hdr["header_size"]
    nup = r.byte()
    stats = new_stats()
    main = r.read_function(stats)
    if r.p != len(data):
        raise LuaChunkError("parsed %#x of %#x bytes" % (r.p, len(data)))
    return hdr, nup, main, stats


# ------------------------------------------------------------------ writing
class ChunkWriter:
    def __init__(self, sizes=STOCK):
        self.size_integer, self.size_number = sizes
        self.out = bytearray(make_header(*sizes))

    def byte(self, v):
        self.out.append(v & 0xFF)

    def i32(self, v):
        self.out += struct.pack("<i", v)

    def u32(self, v):
        self.out += struct.pack("<I", v)

    def lua_integer(self, v):
        self.out += struct.pack("<i" if self.size_integer == 4 else "<q", v)

    def lua_number(self, v):
        self.out += struct.pack("<f" if self.size_number == 4 else "<d", v)

    def size(self, v):
        """Lua 5.3 dumpSize: one byte, or ``0xFF`` then a ``size_t``."""
        if v < 0xFF:
            self.out.append(v)
        else:
            self.out.append(0xFF)
            self.out += struct.pack("<Q", v)

    def string(self, s):
        if s is None:
            self.size(0)
        else:
            self.size(len(s) + 1)
            self.out += s

    def write_function(self, f):
        self.string(f["source"])
        self.i32(f["linedefined"])
        self.i32(f["lastlinedefined"])
        self.byte(f["numparams"])
        self.byte(f["is_vararg"])
        self.byte(f["maxstacksize"])
        self.i32(len(f["code"]))
        for ins in f["code"]:
            self.u32(ins)
        self.i32(len(f["consts"]))
        for kind, val in f["consts"]:
            if kind == "nil":
                self.byte(T_NIL)
            elif kind == "bool":
                self.byte(T_BOOL)
                self.byte(val)
            elif kind == "num":
                self.byte(T_NUMFLT)
                self.lua_number(val)
            elif kind == "int":
                self.byte(T_NUMINT)
                self.lua_integer(val)
            else:
                self.byte(T_STR)
                self.string(val)
        self.i32(len(f["upvals"]))
        for instack, idx in f["upvals"]:
            self.byte(instack)
            self.byte(idx)
        self.i32(len(f["protos"]))
        for p in f["protos"]:
            self.write_function(p)
        self.i32(len(f["lineinfo"]))
        for ln in f["lineinfo"]:
            self.i32(ln)
        self.i32(len(f["locvars"]))
        for name, s, e in f["locvars"]:
            self.string(name)
            self.i32(s)
            self.i32(e)
        self.i32(len(f["upnames"]))
        for nm in f["upnames"]:
            self.string(nm)


def convert(data):
    """Blizzard chunk bytes -> stock Lua 5.3 chunk bytes.

    Returns ``(bytes, stats)``.
    """
    hdr = read_header(data)
    sizes = (hdr["sizeof_lua_integer"], hdr["sizeof_lua_number"])
    if sizes == STOCK:
        return data, new_stats()
    _h, nup, main, stats = parse(data, sizes)
    w = ChunkWriter(STOCK)
    w.byte(nup)
    w.write_function(main)
    return bytes(w.out), stats


def looks_like_stock(data):
    """True if this chunk already uses the stock 8-byte constant widths."""
    try:
        hdr = read_header(data)
    except LuaChunkError:
        return False
    return (hdr["sizeof_lua_integer"], hdr["sizeof_lua_number"]) == STOCK
