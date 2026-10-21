# -*- coding: utf-8 -*-
"""通用 WC3 对象数据（w3u/w3t/w3a/w3h/w3b/w3d/w3q）读写工具。

格式（1.24~1.27）：
  头部：version(int32) + origCount(int32) + [条目...] + customCount(int32) + [条目...]
  条目：oldId(4) + newId(4) + modCount(int32) + [修改...]
  修改（w3a/w3q）：modId(4) + type(int32) + level(int32) + column(int32) + value + end(int32)
  修改（其他）：    modId(4) + type(int32) + value + end(int32)
  value：type0=int32, type1/2=float32, type3=以 0 结尾的字符串（无对齐填充）
"""
import struct

HAS_LEVEL_COLUMN = {"w3a", "w3q"}
T_INT, T_REAL, T_UNREAL, T_STRING = 0, 1, 2, 3


class ObjError(Exception):
    pass


def _read_string(d, off):
    end = d.index(b"\x00", off)
    return d[off:end].decode("utf-8", "replace"), end + 1


def read_bytes(d, ext):
    ext = ext.lower().lstrip(".")
    has_lc = ext in HAS_LEVEL_COLUMN
    off = 0
    version = struct.unpack_from("<i", d, off)[0]
    off += 4
    if version not in (1, 2):
        raise ObjError("bad version %d" % version)

    def read_mods(pos):
        count = struct.unpack_from("<i", d, pos)[0]
        pos += 4
        mods = []
        for _ in range(count):
            mid = d[pos:pos + 4].decode("latin-1")
            t = struct.unpack_from("<i", d, pos + 4)[0]
            pos += 8
            level = column = None
            if has_lc:
                level = struct.unpack_from("<i", d, pos)[0]
                column = struct.unpack_from("<i", d, pos + 4)[0]
                pos += 8
            if t == T_INT:
                v = struct.unpack_from("<i", d, pos)[0]
                pos += 4
            elif t in (T_REAL, T_UNREAL):
                v = struct.unpack_from("<f", d, pos)[0]
                pos += 4
            elif t == T_STRING:
                v, pos = _read_string(d, pos)
            else:
                raise ObjError("bad mod type %d (%s)" % (t, mid))
            marker = struct.unpack_from("<i", d, pos)[0]
            pos += 4
            if marker != 0:
                raise ObjError("bad end marker %d (%s)" % (marker, mid))
            mods.append([mid, t, level, column, v])
        return mods, pos

    def read_group(pos):
        count = struct.unpack_from("<i", d, pos)[0]
        pos += 4
        out = []
        for _ in range(count):
            old = d[pos:pos + 4].decode("latin-1")
            new = d[pos + 4:pos + 8].decode("latin-1")
            pos += 8
            mods, pos = read_mods(pos)
            out.append({"old": old, "new": new, "mods": mods})
        return out, pos

    orig, off = read_group(off)
    cust, off = read_group(off)
    if off != len(d):
        raise ObjError("trailing %d bytes" % (len(d) - off))
    return version, orig, cust


def _write_string(s):
    return str(s).encode("utf-8") + b"\x00"


def build_bytes(version, orig, cust, ext):
    has_lc = ext.lower().lstrip(".") in HAS_LEVEL_COLUMN
    out = struct.pack("<ii", version, len(orig))
    for e in orig:
        out += e["old"].encode("latin-1")
        out += e["new"].encode("latin-1")
        out += struct.pack("<i", len(e["mods"]))
        for mid, t, level, column, v in e["mods"]:
            out += mid.encode("latin-1")
            out += struct.pack("<i", t)
            if has_lc:
                out += struct.pack("<ii", int(level or 0), int(column or 0))
            if t == T_INT:
                out += struct.pack("<i", int(v))
            elif t in (T_REAL, T_UNREAL):
                out += struct.pack("<f", float(v))
            elif t == T_STRING:
                out += _write_string(v)
            else:
                raise ObjError("bad mod type %d" % t)
            out += struct.pack("<i", 0)
    out += struct.pack("<i", len(cust))
    for e in cust:
        out += e["old"].encode("latin-1")
        out += e["new"].encode("latin-1")
        out += struct.pack("<i", len(e["mods"]))
        for mid, t, level, column, v in e["mods"]:
            out += mid.encode("latin-1")
            out += struct.pack("<i", t)
            if has_lc:
                out += struct.pack("<ii", int(level or 0), int(column or 0))
            if t == T_INT:
                out += struct.pack("<i", int(v))
            elif t in (T_REAL, T_UNREAL):
                out += struct.pack("<f", float(v))
            elif t == T_STRING:
                out += _write_string(v)
            else:
                raise ObjError("bad mod type %d" % t)
            out += struct.pack("<i", 0)
    return out


def read_file(path):
    return read_bytes(open(path, "rb").read(), path.rsplit(".", 1)[-1])


def write_file(path, version, orig, cust):
    ext = path.rsplit(".", 1)[-1]
    open(path, "wb").write(build_bytes(version, orig, cust, ext))


def mods_to_dict(entry):
    """把条目折成 {modId: 值}；多级字段同时以 (modId, level) 作键。"""
    out = {}
    for mid, _t, level, _col, v in entry["mods"]:
        out[mid] = v
        if level is not None:
            out[(mid, level)] = v
    return out
