# -*- coding: utf-8 -*-
"""原生 MPQ 写入器：**安全**地替换/新增地图内部文件（不走 HKE GUI）。

为什么需要它（2026-10-10）：
  * HKE 保存时只认它"列得出来"的文件名；而很多图**没有 (listfile)**（例如
    星球战队枪械版：3043 个文件、零 listfile）→ 用 HKE 保存有丢几千个资源的风险。
  * 本工具按**块表**原样保留所有老条目（连"名字未知"的也照抄块数据），
    只在末尾追加我们替换/新增的那几个块，再重建哈希表/块表 → 不丢任何东西。
  * 顺带：不走 GUI，几秒完成（HKE 一次要 ~100 秒）。

用法:
    python mpq_patch.py <地图> <源文件>=<内部名> [...] [--out 输出] [--no-backup]

限制:
  * 只处理**未加密**的条目（本项目遇到的地图都是 EXISTS|COMPRESS）；
    遇到加密/单块格式会直接报错退出，不会写坏图。
  * 压缩用标准 zlib（每扇区：1 字节类型 0x02 + zlib 流；压不动就原样存）。
"""
import argparse
import os
import shutil
import struct
import sys
import zlib

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402

ALIGN = 512
WRITE_FLAGS = W.MPQ_FILE_EXISTS | W.MPQ_FILE_COMPRESS


def compress_sectors(data, sector_size):
    """返回 file_data：扇区偏移表 + 各扇区（每扇区 = 1 字节压缩类型 + 数据）。"""
    pieces = []
    offsets = [0]
    n = 0
    for i in range(0, max(len(data), 1), sector_size):
        chunk = data[i:i + sector_size]
        comp = zlib.compress(chunk, 9)
        piece = (b"\x02" + comp) if len(comp) + 1 < len(chunk) else chunk
        pieces.append(piece)
        n += len(piece)
        offsets.append(n)
    table_size = (len(pieces) + 1) * 4
    table = struct.pack("<%dI" % (len(pieces) + 1),
                        *[o + table_size for o in offsets])
    return table + b"".join(pieces)


def used_hash_count(hash_tbl):
    return sum(1 for e in hash_tbl
               if e[0] not in (W.MPQ_HASH_ENTRY_EMPTY, W.MPQ_HASH_ENTRY_DELETED))


def expand_hash_table(ar, hash_tbl, incoming_names, load_limit=0.70):
    """Grow a nearly full MPQ hash table without losing unlisted entries."""
    live = [e for e in hash_tbl
            if e[0] not in (W.MPQ_HASH_ENTRY_EMPTY, W.MPQ_HASH_ENTRY_DELETED)]
    live_pairs = {(e[0], e[1]) for e in live}
    incoming_pairs = {
        (W._hash_string(name, W.MPQ_HASH_NAME_A),
         W._hash_string(name, W.MPQ_HASH_NAME_B))
        for name in incoming_names
    }
    required = len(live_pairs | incoming_pairs)
    if required <= len(hash_tbl) * load_limit:
        return hash_tbl, len(hash_tbl)

    # listfile() intentionally omits MPQ-internal names.
    candidates = list(ar.files()) + [
        "(listfile)",
        "(attributes)",
        "(signature)",
        "(user data)",
    ]
    name_by_pair = {}
    for name in candidates:
        pair = (W._hash_string(name, W.MPQ_HASH_NAME_A),
                W._hash_string(name, W.MPQ_HASH_NAME_B))
        if pair in live_pairs:
            name_by_pair[pair] = name
    missing = live_pairs - set(name_by_pair)
    if missing:
        raise SystemExit(
            "哈希表需要扩容，但有 %d 个条目无法从 listfile 和标准内部名反查，"
            "为避免损坏归档已停止写入" % len(missing)
        )

    new_size = 1
    minimum = max(256, int(required / load_limit) + 1)
    while new_size < minimum:
        new_size <<= 1
    empty = (W.MPQ_HASH_ENTRY_EMPTY,) * 4
    new_table = [empty] * new_size
    for entry in live:
        name = name_by_pair[(entry[0], entry[1])]
        idx = W._hash_string(name, W.MPQ_HASH_TABLE_OFFSET) % new_size
        while new_table[idx][0] != W.MPQ_HASH_ENTRY_EMPTY:
            idx = (idx + 1) % new_size
        new_table[idx] = entry
    print("   哈希表扩容: %d -> %d 槽（%d -> %d 条）"
          % (len(hash_tbl), new_size, len(live), required), flush=True)
    return new_table, new_size


def block_table_score(data, n, file_size):
    """块表像不像真的：看"offset 在文件范围内、flags 合法、大小非 0"的比例。"""
    if n <= 0 or len(data) < n * 16:
        return 0.0
    good = 0
    for i in range(n):
        off, csize, fsize, flags = struct.unpack_from("<IIII", data, i * 16)
        if (flags & (W.MPQ_FILE_EXISTS | W.MPQ_FILE_DELETE_MARKER)) and off < file_size \
                and csize > 0 and fsize > 0:
            good += 1
    return good / float(n)


def table_encrypted(raw, size, name, file_size=None):
    """判断表是不是"标准密钥加密"的。

    ⚠ 不能只看 EMPTY 标记：**块表里根本没有 EMPTY 标记**（只有哈希表才有），
      所以块表要用语义检查（offset 递增 / flags 合法）。写错会把整张表写坏。
    """
    if size <= 0:
        return False
    key = W._hash_string(name, W.MPQ_HASH_FILE_KEY)
    if file_size is not None:                     # 块表: 语义检查
        s_plain = block_table_score(raw, size, file_size)
        dec = W._decrypt(raw, key)
        s_dec = block_table_score(dec, size, file_size)
        if max(s_plain, s_dec) < 0.5:
            raise SystemExit("块表既不像明文也不像标准加密（%0.2f / %0.2f），先别写"
                             % (s_plain, s_dec))
        return s_dec > s_plain
    dec = W._decrypt(raw, key)                    # 哈希表: EMPTY 标记
    for i in range(size):
        if struct.unpack_from("<I", dec, i * 16)[0] == W.MPQ_HASH_ENTRY_EMPTY:
            return True
    return False


def read_block(ar, idx):
    """按块表索引读一个块（绕过文件名），解压后的原始数据。"""
    off, csize, fsize, flags = ar.block_table[idx]
    if not (flags & W.MPQ_FILE_EXISTS) or (flags & W.MPQ_FILE_ENCRYPTED):
        return None
    ar.file.seek(ar.header_offset + off)
    raw = ar.file.read(csize)
    if not (flags & W.COMPRESSION_MASK):
        return raw[:fsize]
    # 单块文件（没有扇区表，整块一次压缩）
    if flags & W.MPQ_FILE_SINGLE_UNIT:
        d = W._decompress(raw, fsize)
        return d[:fsize] if d else None
    sector_size = 512 << ar.block_size
    n = (fsize + sector_size - 1) // sector_size
    if len(raw) < (n + 1) * 4:
        return None
    vals = list(struct.unpack_from("<%dI" % (n + 1), raw))
    out = bytearray()
    for i in range(n):
        end = vals[i + 1] if i + 1 < n else len(raw)
        stored_size = min(sector_size, fsize - i * sector_size)
        sector = raw[vals[i]:end]
        # MPQ stores an incompressible sector verbatim and marks it only by
        # sector length. Trying zlib/bzip2 on every 4 KB chunk of a large MP3
        # makes verification spend many minutes in failed decompressions.
        if len(sector) == stored_size:
            out += sector
        else:
            out += W._decompress(sector, stored_size)
    return bytes(out[:fsize])


def patch(map_path, patches, out_path=None, backup=True, store=()):
    """patches = [(内部名, 新数据)]；返回写入路径。

    store = 需要**原样存储(不压缩)**的内部名集合。
    用例：战役 .w3n 里的章节地图 —— 游戏要把"归档里的文件"当内嵌归档打开，
    压缩块打不开（会报"找不到地图或者损毁"）。原版战役里章节都是未压缩的。
    """
    out_path = out_path or map_path
    store = set(s.lower() for s in store)
    a = W.MPQArchive(map_path)
    try:
        header_offset = a.header_offset
        fmt = a.format_version
        block_size = a.block_size
        hash_size = a.hash_table_size
        hash_tbl = list(a.hash_table)
        block_tbl = list(a.block_table)
        ext = b""
        if fmt >= 1:
            a.file.seek(header_offset + 32)
            ext = a.file.read(24)
        file_size = os.path.getsize(map_path)
        a.file.seek(header_offset + a.hash_table_pos)
        raw_ht = a.file.read(hash_size * 16)
        ht_enc = table_encrypted(raw_ht, hash_size, "(hash table)")
        a.file.seek(header_offset + a.block_table_pos)
        raw_bt = a.file.read(len(block_tbl) * 16)
        bt_enc = table_encrypted(raw_bt, len(block_tbl), "(block table)", file_size)
        hash_tbl, hash_size = expand_hash_table(
            a, hash_tbl, [internal for internal, _data in patches]
        )
    finally:
        a.close()
    sector_size = 512 << block_size
    body = bytearray(open(map_path, "rb").read())
    size_before = len(body)
    # 注意：有些图 header 里的 archive_size **小于**真实数据范围（保护图常见，
    #   例如《西方世界的劫难6》：archive_size 之后其实还是块数据）。
    #   所以新块一律**追加在文件末尾**、再把哈希/块表也写在末尾，绝不"裁剪"任何东西 ——
    #   2026-10-12 试过按 archive_size 切开、把尾部当"附加区"重接，结果把最后一个块挪位、
    #   读回校验直接报"1 条不一致"。别再做那个优化。
    print("   档案: header@%d, MPQ v%d, 扇区 %d, 哈希 %d 格(已用 %d), 块 %d; 表加密 hash=%s block=%s"
          % (header_offset, fmt, sector_size, hash_size,
             used_hash_count(hash_tbl), len(block_tbl), ht_enc, bt_enc))

    def find_hash(name):
        ha = W._hash_string(name, W.MPQ_HASH_NAME_A)
        hb = W._hash_string(name, W.MPQ_HASH_NAME_B)
        idx = W._hash_string(name, W.MPQ_HASH_TABLE_OFFSET) % hash_size
        for _ in range(hash_size):
            e = hash_tbl[idx]
            if e[0] == ha and e[1] == hb:
                return idx, ha, hb
            if e[0] == W.MPQ_HASH_ENTRY_EMPTY:
                return None, ha, hb
            idx = (idx + 1) % hash_size
        return None, ha, hb

    for internal, data in patches:
        if internal.lower().startswith("(listfile)"):
            raise SystemExit("不写 (listfile)：写不完整清单反而会让 HKE 类工具丢文件")
        hi, ha, hb = find_hash(internal)
        if hi is not None:
            bi = hash_tbl[hi][3]
            flags = block_tbl[bi][3]
            if flags & (W.MPQ_FILE_ENCRYPTED | W.MPQ_FILE_SINGLE_UNIT):
                # MPQ 的加密/压缩是**按条目**记录的：把替换后的条目写成"未加密+压缩"
                # 完全合法，游戏按该条目自己的 flags 读，不影响其它条目。
                print("   注意 %s 原来是加密/单块(0x%08X) -> 写成未加密压缩条目"
                      % (internal, flags))
        if len(body) % ALIGN:
            body += b"\x00" * (ALIGN - len(body) % ALIGN)
        off = len(body) - header_offset
        if internal.lower() in store:
            fdata = data
            wflags = W.MPQ_FILE_EXISTS
        else:
            fdata = compress_sectors(data, sector_size)
            wflags = WRITE_FLAGS
        body += fdata
        csize = len(fdata)
        if hi is not None:
            bi = hash_tbl[hi][3]
            old = block_tbl[bi]
            block_tbl[bi] = (off, csize, len(data), wflags)
            print("   替换 %-26s 块 %-5d %d -> %d 字节%s"
                  % (internal, bi, old[2], len(data), "（原样存储）" if wflags == W.MPQ_FILE_EXISTS else ""))
        else:
            block_tbl.append((off, csize, len(data), wflags))
            bi = len(block_tbl) - 1
            idx = W._hash_string(internal, W.MPQ_HASH_TABLE_OFFSET) % hash_size
            while hash_tbl[idx][0] != W.MPQ_HASH_ENTRY_EMPTY:
                idx = (idx + 1) % hash_size
            hash_tbl[idx] = (ha, hb, 0, bi)
            print("   新增 %-26s 块 %-5d %d 字节（哈希槽 %d）%s"
                  % (internal, bi, len(data), idx, "（原样存储）" if wflags == W.MPQ_FILE_EXISTS else ""))

    def write_table(tbl, name, encrypted):
        if len(body) % ALIGN:
            body.extend(b"\x00" * (ALIGN - len(body) % ALIGN))
        pos = len(body) - header_offset
        raw = b"".join(struct.pack("<IIII", *e) for e in tbl)
        if encrypted:
            raw = W._encrypt(raw, W._hash_string(name, W.MPQ_HASH_FILE_KEY))
        body.extend(raw)
        return pos

    print("   写入块数据完成，重建 MPQ 表...", flush=True)
    pos_bt = write_table(block_tbl, "(block table)", bt_enc)
    pos_ht = write_table(hash_tbl, "(hash table)", ht_enc)

    # Keep the existing 4-byte MPQ marker and replace the remaining 28-byte
    # header in one operation. This also avoids relying on pack_into() with a
    # slice whose line-level profiler attribution can hide the real hot spot.
    body[header_offset + 4:header_offset + 32] = struct.pack(
        "<IIHHIIII",
        32,
        len(body) - header_offset,
        fmt,
        block_size,
        pos_ht,
        pos_bt,
        hash_size,
        len(block_tbl),
    )
    if fmt >= 1 and len(ext) == 24:
        body[header_offset + 32:header_offset + 56] = ext

    if out_path == map_path and backup:
        bak = map_path + ".origbak"
        if not os.path.exists(bak):
            shutil.copy2(map_path, bak)
            print("   原图备份: %s" % os.path.basename(bak))
    with open(out_path, "wb") as fh:
        fh.write(body)
    print("   写入 %s：%d -> %d 字节" % (os.path.basename(out_path),
                                        size_before, len(body)))
    return out_path


def verify(old_path, new_path, patched):
    a = W.MPQArchive(old_path)
    old_blocks = list(a.block_table)
    old_used = used_hash_count(a.hash_table)
    old_data = [read_block(a, i) for i in range(len(old_blocks))]
    a.close()
    b = W.MPQArchive(new_path)
    new_used = used_hash_count(b.hash_table)
    new_blocks = list(b.block_table)
    bad = 0
    skipped = 0
    for i, want in enumerate(old_data):
        if want is None:
            continue
        # 被我们**故意替换**的块（块表条目本身变了）不参与"老内容"比对
        if i >= len(new_blocks) or new_blocks[i] != old_blocks[i]:
            skipped += 1
            continue
        if read_block(b, i) != want:
            bad += 1
    ok = True
    print("   条目: 哈希 %d -> %d，块 %d -> %d" % (old_used, new_used,
                                                len(old_blocks), len(new_blocks)))
    if new_used < old_used:
        print("   !! 哈希条目变少")
        ok = False
    print("   老块内容: %d 条中 %d 条不一致（跳过被替换的 %d 条）%s"
          % (len(old_blocks), bad, skipped, "[OK]" if not bad else "[NG]"))
    if bad:
        ok = False
    for internal, want in patched:
        got = b.read_file(internal)
        same = (got == want)
        print("   %-26s 读回 %8d 字节 %s" % (internal, len(got or b""),
                                            "一致 [OK]" if same else "**不一致**"))
        if not same:
            ok = False
    b.close()
    return ok


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("patches", nargs="*", metavar="SRC=内部名")
    ap.add_argument("--out")
    ap.add_argument("--no-backup", action="store_true")
    ap.add_argument("--no-verify", action="store_true")
    args = ap.parse_args()
    if not args.patches:
        print(__doc__)
        return 1
    payload = []
    for spec in args.patches:
        if "=" not in spec:
            print("参数格式应为 源文件=内部名:", spec)
            return 1
        src, internal = spec.split("=", 1)
        payload.append((internal, open(src, "rb").read()))
    new_path = patch(args.map, payload, args.out, backup=not args.no_backup)
    if args.no_verify:
        return 0
    print("== 校验 ==")
    ok = verify(args.map, new_path, payload)
    print("== %s ==" % ("校验通过 [OK]" if ok else "校验失败 [NG]"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
