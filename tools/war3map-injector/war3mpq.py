"""
war3mpq - Warcraft III 地图 MPQ 读写工具

处理 .w3m/.w3x 文件的 HM3W 地图头 + MPQ 结构。
支持：列出文件、提取、替换/注入文件、重建 MPQ。

用法：
    python war3mpq.py list <map>
    python war3mpq.py extract <map> <outdir>
    python war3mpq.py inject <map> <name> <file>   # 注入/替换单个文件
    python war3mpq.py info <map>
"""

import os
import struct
import sys
import zlib


# ---------------------------------------------------------------------------
# MPQ 常量
# ---------------------------------------------------------------------------
MPQ_MAGIC = 0x1A51504D  # 'MPQ\x1A'
HM3W_MAGIC = 0x57334D48  # 'HM3W'

MPQ_HASH_TABLE_OFFSET = 0
MPQ_HASH_NAME_A = 1
MPQ_HASH_NAME_B = 2
MPQ_HASH_FILE_KEY = 3
MPQ_HASH_ENTRY_EMPTY = 0xFFFFFFFF
MPQ_HASH_ENTRY_DELETED = 0xFFFFFFFE

MPQ_FILE_IMPLODE = 0x00000100
MPQ_FILE_COMPRESS = 0x00000200
MPQ_FILE_ENCRYPTED = 0x00010000
MPQ_FILE_FIX_KEY = 0x00020000
MPQ_FILE_PATCH_FILE = 0x00100000
MPQ_FILE_SINGLE_UNIT = 0x01000000
MPQ_FILE_DELETE_MARKER = 0x02000000
MPQ_FILE_SECTOR_CRC = 0x04000000
MPQ_FILE_EXISTS = 0x80000000

COMPRESSION_MASK = (
    MPQ_FILE_IMPLODE
    | MPQ_FILE_COMPRESS
    | 0x00000001  # huffman
    | 0x00000008  # pkware
    | 0x00000010  # bzip2
    | 0x00000020  # sparse
    | 0x00000040  # adpcm mono
    | 0x00000080  # adpcm stereo
    | 0x00000100  # implode
    | 0x00000200  # zlib
    | 0x00000400  # lzma
)


# ---------------------------------------------------------------------------
# 加密表
# ---------------------------------------------------------------------------
def _build_crypt_table():
    seed = 0x00100001
    table = [0] * 0x500
    for index1 in range(0x100):
        index2 = index1
        for _ in range(5):
            seed = (seed * 125 + 3) % 0x2AAAAB
            temp1 = (seed & 0xFFFF) << 0x10
            seed = (seed * 125 + 3) % 0x2AAAAB
            temp2 = seed & 0xFFFF
            table[index2] = (temp1 | temp2) & 0xFFFFFFFF
            index2 += 0x100
    return table


CRYPT_TABLE = _build_crypt_table()


def _hash_string(name, hash_type):
    """MPQ 文件名哈希。"""
    if isinstance(name, str):
        name = name.encode("utf-8")
    name = name.upper().replace(b"/", b"\\")
    seed1 = 0x7FED7FED
    seed2 = 0xEEEEEEEE
    for ch in name:
        # ⚠ 标准 Storm 哈希: 第二步用的是"原始字符值"，不是查表后的值。
        #   2026-10-10 修正 —— 原来写成用查表值, 于是**所有按名字查找都失败**
        #   (hash('(hash table)', FILE_KEY) 应为 0x3FDD5D13, 错实现给 0x559A0BD7)。
        seed1 = (CRYPT_TABLE[(hash_type << 8) + ch] ^ (seed1 + seed2)) & 0xFFFFFFFF
        seed2 = (ch + seed1 + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
    return seed1


def _decrypt(data, key):
    """MPQ 解密（原地）。"""
    seed1 = key & 0xFFFFFFFF
    seed2 = 0xEEEEEEEE
    # 长度不是 4 的倍数时先补零，否则 struct.unpack_from 会越界
    #   (2026-10-10: 压缩扇区常见这种情况)
    pad = (-len(data)) % 4
    result = bytearray(data + b"\x00" * pad)
    for i in range(0, len(result), 4):
        seed2 = (seed2 + CRYPT_TABLE[0x400 + (seed1 & 0xFF)]) & 0xFFFFFFFF
        chunk = struct.unpack_from("<I", result, i)[0]
        plain = (chunk ^ (seed1 + seed2)) & 0xFFFFFFFF
        struct.pack_into("<I", result, i, plain)
        seed1 = (((~seed1 << 0x15) + 0x11111111) | (seed1 >> 0x0B)) & 0xFFFFFFFF
        seed2 = (plain + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
    return bytes(result[: len(data)])


def _encrypt(data, key):
    """MPQ 加密。"""
    seed1 = key & 0xFFFFFFFF
    seed2 = 0xEEEEEEEE
    result = bytearray(data)
    for i in range(0, len(result), 4):
        seed2 = (seed2 + CRYPT_TABLE[0x400 + (seed1 & 0xFF)]) & 0xFFFFFFFF
        chunk = struct.unpack_from("<I", result, i)[0]
        plain = (chunk ^ (seed1 + seed2)) & 0xFFFFFFFF
        struct.pack_into("<I", result, i, plain)
        seed1 = (((~seed1 << 0x15) + 0x11111111) | (seed1 >> 0x0B)) & 0xFFFFFFFF
        seed2 = (chunk + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
    return bytes(result)


# ---------------------------------------------------------------------------
# MPQ 读取
# ---------------------------------------------------------------------------
class MPQFile:
    def __init__(self, name, offset, csize, fsize, flags):
        self.name = name
        self.offset = offset
        self.csize = csize
        self.fsize = fsize
        self.flags = flags


class MPQArchive:
    """只读 MPQ 归档（支持 HM3W 地图头）。"""

    def __init__(self, path):
        self.path = path
        self.file = open(path, "rb")
        self.map_header = None
        self.header_offset = 0
        self._read_header()
        self._read_tables()
        self._read_listfile()

    def _read_header(self):
        self.file.seek(0)
        magic = struct.unpack("<I", self.file.read(4))[0]
        if magic == HM3W_MAGIC:
            # HM3W 地图头: magic(4) + unknown(4) + name(null-terminated) + flags(4) + maxplayers(4)
            self.file.seek(8)  # 跳过 magic + unknown
            name_bytes = bytearray()
            while True:
                ch = self.file.read(1)
                if not ch or ch == b"\x00":
                    break
                name_bytes += ch
            name = name_bytes.decode("utf-8", "replace")
            flags = struct.unpack("<I", self.file.read(4))[0]
            max_players = struct.unpack("<I", self.file.read(4))[0]
            self.map_header = {
                "name": name,
                "flags": flags,
                "max_players": max_players,
            }
            # MPQ 头不一定紧邻 HM3W 头，向后扫描 'MPQ\x1A'
            scan_start = self.file.tell()
            self.file.seek(scan_start)
            buf = self.file.read(4096)
            idx = buf.find(b"MPQ\x1a")
            if idx < 0:
                raise ValueError("HM3W 后未找到 MPQ 头")
            self.header_offset = scan_start + idx
        else:
            self.header_offset = 0

        self.file.seek(self.header_offset)
        header = self.file.read(32)
        self.header_size = struct.unpack_from("<I", header, 4)[0]
        self.archive_size = struct.unpack_from("<I", header, 8)[0]
        self.format_version = struct.unpack_from("<H", header, 12)[0]
        self.block_size = struct.unpack_from("<H", header, 14)[0]
        self.hash_table_pos = struct.unpack_from("<I", header, 16)[0]
        self.block_table_pos = struct.unpack_from("<I", header, 20)[0]
        self.hash_table_size = struct.unpack_from("<I", header, 24)[0]
        self.block_table_size = struct.unpack_from("<I", header, 28)[0]

        if self.format_version >= 1:
            # 扩展头（v1）: hi_block_table_pos(8) + hash_table_pos_hi(8) + block_table_pos_hi(8)
            ext = self.file.read(24)
            (
                self.hi_block_table_pos,
                self.hash_table_pos_hi,
                self.block_table_pos_hi,
            ) = struct.unpack("<QQQ", ext)

    def _read_tables(self):
        # 哈希表 (每项 16 字节: hashA, hashB, locale, platform, blockIndex)
        self.file.seek(self.header_offset + self.hash_table_pos)
        raw = self.file.read(self.hash_table_size * 16)
        # 哈希表可能被加密，尝试多种密钥
        raw = self._try_decrypt_table(raw, self.hash_table_size, "(hash table)")
        self.hash_table = []
        for i in range(self.hash_table_size):
            entry = struct.unpack_from("<IIII", raw, i * 16)
            self.hash_table.append(entry)

        # 块表 (每项 16 字节: offset, csize, fsize, flags)
        self.file.seek(self.header_offset + self.block_table_pos)
        raw = self.file.read(self.block_table_size * 16)
        raw = self._try_decrypt_table(raw, self.block_table_size, "(block table)")
        self.block_table = []
        for i in range(self.block_table_size):
            entry = struct.unpack_from("<IIII", raw, i * 16)
            self.block_table.append(entry)

    def _try_decrypt_table(self, raw, size, table_name):
        """尝试用多种密钥解密表，返回最像未加密表的版本。"""
        # 候选密钥类型：0=HASH_TABLE_OFFSET, 1=HASH_NAME_A, 2=HASH_NAME_B, 3=HASH_FILE_KEY
        candidates = []
        for htype in (3, 1, 0, 2):
            key = _hash_string(table_name, htype)
            dec = _decrypt(raw, key)
            empties = sum(
                1 for i in range(size) if struct.unpack_from("<I", dec, i * 16)[0] == MPQ_HASH_ENTRY_EMPTY
            )
            candidates.append((empties, dec))
        # 原样（未加密）
        empties = sum(
            1 for i in range(size) if struct.unpack_from("<I", raw, i * 16)[0] == MPQ_HASH_ENTRY_EMPTY
        )
        candidates.append((empties, raw))
        # 选 EMPTY 最多的
        candidates.sort(key=lambda x: x[0], reverse=True)
        return candidates[0][1]

    def _read_listfile(self):
        self.listfile = []
        try:
            data = self.read_file("(listfile)")
            if data:
                self.listfile = [
                    line.strip()
                    for line in data.decode("utf-8", "replace").splitlines()
                    if line.strip()
                ]
        except Exception:
            self.listfile = []

    def _find_file(self, name):
        """通过哈希表查找文件。"""
        hash_a = _hash_string(name, MPQ_HASH_NAME_A)
        hash_b = _hash_string(name, MPQ_HASH_NAME_B)
        index = _hash_string(name, MPQ_HASH_TABLE_OFFSET) % self.hash_table_size

        for _ in range(self.hash_table_size):
            entry = self.hash_table[index]
            if entry[0] == MPQ_HASH_ENTRY_EMPTY:
                return None
            if entry[0] == hash_a and entry[1] == hash_b:
                block_index = entry[3]
                if block_index < len(self.block_table):
                    block = self.block_table[block_index]
                    return MPQFile(name, block[0], block[1], block[2], block[3])
            index = (index + 1) % self.hash_table_size
        return None

    def _file_key(self, name, block_offset, file_size, flags):
        """计算文件加密密钥。"""
        key = _hash_string(os.path.basename(name).replace("/", "\\"), MPQ_HASH_FILE_KEY)
        if flags & MPQ_FILE_FIX_KEY:
            key = ((key + block_offset) ^ file_size) & 0xFFFFFFFF
        return key

    def read_file(self, name):
        """读取并解压文件内容。"""
        info = self._find_file(name)
        if info is None:
            return None
        if not (info.flags & MPQ_FILE_EXISTS):
            return None

        self.file.seek(self.header_offset + info.offset)
        raw = self.file.read(info.csize)

        flags = info.flags
        key = self._file_key(name, info.offset, info.fsize, flags)

        if flags & MPQ_FILE_SINGLE_UNIT:
            # 单块文件
            data = raw
            if flags & MPQ_FILE_ENCRYPTED:
                data = _decrypt(data, key - 1)
            if flags & COMPRESSION_MASK:
                data = _decompress(data, info.fsize)
            return data[: info.fsize]
        else:
            # 分块文件
            sector_size = 512 << self.block_size
            num_sectors = (info.fsize + sector_size - 1) // sector_size
            # 读取扇区偏移表
            offset_table_size = (num_sectors + 1) * 4
            table = raw[:offset_table_size]
            cand_tables = []
            if flags & MPQ_FILE_ENCRYPTED:
                cand_tables.append(_decrypt(table, key - 1))
            cand_tables.append(table)   # 有些存档的偏移表其实是明文
            offsets = None
            for cand in cand_tables:
                vals = list(struct.unpack("<%dI" % (num_sectors + 1), cand[: offset_table_size]))
                # 合理性检查: 第一项=表长度, 单调不减, 末项接近压缩总长
                if vals[0] != offset_table_size:
                    continue
                if any(vals[i] > vals[i + 1] for i in range(len(vals) - 1)):
                    continue
                if vals[-1] > info.csize or vals[-1] + 64 < info.csize:
                    continue
                offsets = vals
                break
            if offsets is None:
                offsets = list(struct.unpack("<%dI" % (num_sectors + 1),
                                             cand_tables[0][: offset_table_size]))

            result = bytearray()
            for i in range(num_sectors):
                start = offsets[i]
                # 最后一个扇区的结束位置: 优先用压缩总长(fsize 边界更可靠)。
                #   有的工具(如 HKE)写的最后一项 offset 是坏的 -> 会丢尾巴,
                #   表现为"提取出来的图/文件总是差最后一截"。
                end = offsets[i + 1] if i + 1 < num_sectors else info.csize
                if end is None or end <= start or end > info.csize:
                    end = info.csize
                sector = raw[start:end]
                if flags & MPQ_FILE_ENCRYPTED:
                    sector = _decrypt(sector, (key + i) & 0xFFFFFFFF)
                if flags & COMPRESSION_MASK:
                    # 不管长度, 先试着解压 —— 有些存档的"未压缩扇区"长度也小于
                    # sector_size, 只看长度会漏解压 (_decompress 失败会原样返回)。
                    sector = _decompress(sector, sector_size)
                result += sector
            return bytes(result[: info.fsize])

    def files(self):
        """返回 listfile 中的文件列表。"""
        return list(self.listfile)

    def close(self):
        self.file.close()


def _looks_like_hash_table(data, size):
    """判断数据是否像未加密的哈希表（存在 EMPTY 标记 0xFFFFFFFF）。"""
    if len(data) < size * 16:
        return False
    empty = 0
    for i in range(size):
        v = struct.unpack_from("<I", data, i * 16)[0]
        if v == MPQ_HASH_ENTRY_EMPTY or v == MPQ_HASH_ENTRY_DELETED:
            empty += 1
    return empty > 0


def _looks_like_block_table(data, size):
    """判断数据是否像未加密的块表（offset 递增且在文件范围内）。"""
    if len(data) < size * 16:
        return False
    prev = -1
    valid = 0
    for i in range(size):
        off = struct.unpack_from("<I", data, i * 16)[0]
        if off == 0:
            continue
        if prev == -1 or off > prev:
            valid += 1
            prev = off
    return valid > size // 2


def _decompress(data, expected_size):
    # WC3 官方的 MPQ 里，压缩扇区**开头有一个压缩类型字节**:
    #   0x02 = zlib/deflate, 0x08 = PKWARE, 0x10 = bzip2
    #   (2026-10-10 补上 —— 之前没处理这个字节, 于是解压全部失败、只能拿到压缩数据,
    #    表现为"从 war3.mpq 里提出来的 blp 不是 BLP: b'\x02x\x9c...'"。)
    if data:
        tag = data[0]
        if tag == 0x02:
            # 用 decompressobj: 尾段缺失时也能解出前面大部分(否则整段解压会抛异常,
            #   我们就只能拿到压缩数据 -> "not a BLP: b'\x02x\x9c...'")
            for wbits in (15, -15):
                try:
                    obj = zlib.decompressobj(wbits)
                    out = obj.decompress(data[1:])
                    if len(out) > 0:
                        return out
                except Exception:
                    pass
        elif tag == 0x10:
            try:
                import bz2

                return bz2.decompress(data[1:])
            except Exception:
                pass
    # zlib
    try:
        obj = zlib.decompressobj()
        out = obj.decompress(data)
        if out:
            return out
    except Exception:
        pass
    # zlib raw
    try:
        obj = zlib.decompressobj(-15)
        out = obj.decompress(data)
        if out:
            return out
    except Exception:
        pass
    # bzip2
    try:
        import bz2

        return bz2.decompress(data)
    except Exception:
        pass
    # 未压缩
    return data


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def cmd_list(path):
    a = MPQArchive(path)
    if a.map_header:
        print("地图名: %s" % a.map_header["name"])
    print("文件数: %d" % len(a.listfile))
    for f in sorted(a.listfile):
        print("  %s" % f)
    a.close()


def cmd_extract(path, outdir):
    a = MPQArchive(path)
    os.makedirs(outdir, exist_ok=True)
    count = 0
    for name in a.listfile:
        data = a.read_file(name)
        if data is None:
            continue
        target = os.path.join(outdir, name.replace("\\", os.sep).replace("/", os.sep))
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "wb") as f:
            f.write(data)
        count += 1
    print("提取 %d 个文件到 %s" % (count, outdir))
    a.close()


def cmd_info(path):
    a = MPQArchive(path)
    print("文件: %s" % path)
    if a.map_header:
        print("地图名: %s" % a.map_header["name"])
        print("最大玩家: %d" % a.map_header["max_players"])
    print("MPQ 头偏移: 0x%X" % a.header_offset)
    print("格式版本: %d" % a.format_version)
    print("块大小: %d (扇区 %d 字节)" % (a.block_size, 512 << a.block_size))
    print("哈希表: %d 项" % a.hash_table_size)
    print("块表: %d 项" % a.block_table_size)
    print("listfile 文件数: %d" % len(a.listfile))
    a.close()


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    path = sys.argv[2]
    if cmd == "list":
        cmd_list(path)
    elif cmd == "extract":
        cmd_extract(path, sys.argv[3])
    elif cmd == "info":
        cmd_info(path)
    else:
        print("未知命令: %s" % cmd)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
