"""
inject.py - 通用 War3 地图脚本注入工具

将 f.j / g.j / m.j 三部分脚本注入到地图的 war3map.j 中。

原理：
  war3map.j 结构为：
      globals
          <g.j 内容>
      endglobals
      <f.j 内容>
      function main takes nothing returns nothing
          <m.j 内容>
          ...原有 main 内容...
      endfunction

用法：
    python inject.py <map> <script_dir> [--output <out_map>]
    python inject.py <map> --list-scripts
    python inject.py <map> --show-main

示例：
    python inject.py maps/LostTemple/LostTemple.w3m scripts/item-browser
"""

import argparse
import os
import re
import shutil
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from war3mpq import MPQArchive, _hash_string, _encrypt, _decrypt, MPQ_HASH_FILE_KEY


# ---------------------------------------------------------------------------
# 脚本注入逻辑
# ---------------------------------------------------------------------------
def inject_script(war3map_j: str, g: str, f: str, m: str) -> str:
    """
    将 g/f/m 注入到 war3map.j。

    g -> globals 块
    f -> 全局函数（放在 main 之前）
    m -> main 函数开头
    """
    lines = war3map_j.split("\n")

    # 1) 定位 globals ... endglobals
    globals_start = None
    globals_end = None
    for i, line in enumerate(lines):
        stripped = line.strip().lower()
        if stripped == "globals" and globals_start is None:
            globals_start = i
        elif stripped == "endglobals" and globals_start is not None:
            globals_end = i
            break

    if globals_start is None or globals_end is None:
        raise ValueError("未找到 globals 块")

    # 2) 定位 function main takes nothing returns nothing
    main_idx = None
    for i, line in enumerate(lines):
        if re.match(r"\s*function\s+main\s+takes\s+nothing\s+returns\s+nothing", line):
            main_idx = i
            break

    if main_idx is None:
        raise ValueError("未找到 function main")

    # 3) 定位 main 的 endfunction
    main_end = None
    depth = 0
    for i in range(main_idx, len(lines)):
        stripped = lines[i].strip().lower()
        if stripped.startswith("function "):
            depth += 1
        elif stripped == "endfunction":
            depth -= 1
            if depth == 0:
                main_end = i
                break

    if main_end is None:
        raise ValueError("未找到 main 的 endfunction")

    # 4) 构建新内容
    g_lines = [l for l in g.split("\n")]
    f_lines = [l for l in f.split("\n")]
    m_lines = [l for l in m.split("\n")]

    new_lines = []
    # globals 之前
    new_lines.extend(lines[: globals_start + 1])
    # 注入 g
    new_lines.extend(["    // ==== ITEM BROWSER GLOBALS START ===="])
    new_lines.extend(g_lines)
    new_lines.extend(["    // ==== ITEM BROWSER GLOBALS END ===="])
    # globals 之后到 main 之前
    new_lines.extend(lines[globals_end:main_idx])
    # 注入 f（全局函数）
    new_lines.extend(["// ==== ITEM BROWSER FUNCTIONS START ===="])
    new_lines.extend(f_lines)
    new_lines.extend(["// ==== ITEM BROWSER FUNCTIONS END ===="])
    # main 函数头
    new_lines.append(lines[main_idx])
    # 注入 m（main 开头）
    new_lines.extend(["    // ==== ITEM BROWSER MAIN START ===="])
    new_lines.extend(m_lines)
    new_lines.extend(["    // ==== ITEM BROWSER MAIN END ===="])
    # main 原有内容
    new_lines.extend(lines[main_idx + 1 : main_end])
    # endfunction 及之后
    new_lines.extend(lines[main_end:])

    return "\n".join(new_lines)


def read_script_dir(script_dir):
    """读取 f.j / g.j / m.j。"""
    result = {}
    for name in ("f.j", "g.j", "m.j"):
        path = os.path.join(script_dir, name)
        if not os.path.isfile(path):
            raise FileNotFoundError("缺少脚本文件: %s" % path)
        with open(path, "r", encoding="utf-8") as fh:
            result[name] = fh.read()
    return result


# ---------------------------------------------------------------------------
# MPQ 写入（重建归档）
# ---------------------------------------------------------------------------
def rebuild_map(src_map, dst_map, replacements):
    """
    重建地图：复制原地图，替换指定文件。

    replacements: {文件名: bytes}
    由于原地图可能加密，这里采用"追加块"策略：
    在文件末尾追加新块，更新块表与哈希表。
    """
    # 读取原始数据
    with open(src_map, "rb") as fh:
        raw = bytearray(fh.read())

    archive = MPQArchive(src_map)
    header_offset = archive.header_offset
    hash_pos = archive.hash_table_pos
    block_pos = archive.block_table_pos
    hash_size = archive.hash_table_size
    block_size_entries = archive.block_table_size
    archive.close()

    # 找出每个待替换文件对应的块索引
    # 由于哈希表可能加密，这里用"重建整个 MPQ"的方式
    # 简化方案：解包所有可读文件 + 替换 + 重建
    return _rebuild_via_extract(src_map, dst_map, replacements)


def _rebuild_via_extract(src_map, dst_map, replacements):
    """解包所有文件，替换后重建 MPQ。"""
    archive = MPQArchive(src_map)
    files = {}
    for name in archive.files():
        data = archive.read_file(name)
        if data is not None:
            files[name] = data
    archive.close()

    # 应用替换
    for name, data in replacements.items():
        files[name] = data

    # 写回
    _write_mpq(dst_map, files)
    return True


def _write_mpq(path, files):
    """写出一个简单的未加密 MPQ 归档（含 HM3W 头）。"""
    # 简化：使用 zlib 压缩，单块文件
    import zlib

    block_size = 3  # 4096 字节扇区
    sector_size = 512 << block_size

    # 计算哈希表大小（2 的幂，>= 文件数）
    hash_size = 1
    while hash_size < len(files) * 2:
        hash_size *= 2

    # 构建块数据
    block_entries = []
    file_data = bytearray()
    data_offset = 0

    for name, content in files.items():
        compressed = zlib.compress(content)
        if len(compressed) < len(content):
            flags = 0x80000200  # EXISTS | COMPRESS | SINGLE_UNIT
            payload = compressed
        else:
            flags = 0x80000000  # EXISTS | SINGLE_UNIT
            payload = content
        block_entries.append((data_offset, len(payload), len(content), flags))
        file_data += payload
        data_offset += len(payload)

    # 哈希表
    hash_table = [(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF)] * hash_size
    for idx, name in enumerate(files):
        h_a = _hash_string(name, 1)
        h_b = _hash_string(name, 2)
        slot = _hash_string(name, 0) % hash_size
        while hash_table[slot][0] != 0xFFFFFFFF:
            slot = (slot + 1) % hash_size
        hash_table[slot] = (h_a, h_b, 0, idx)

    # 组装文件
    header_size = 32
    data_start = header_size
    block_table_pos = data_start + len(file_data)
    hash_table_pos = block_table_pos + len(block_entries) * 16
    archive_size = hash_table_pos + hash_size * 16

    header = struct.pack(
        "<IIHHIIIII",
        0x1A51504D,
        header_size,
        archive_size,
        0,
        block_size,
        hash_table_pos,
        block_table_pos,
        hash_size,
        len(block_entries),
    )

    out = bytearray()
    out += header
    out += file_data
    for e in block_entries:
        out += struct.pack("<IIII", *e)
    for e in hash_table:
        out += struct.pack("<IIII", *e)

    with open(path, "wb") as fh:
        fh.write(out)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def main():
    ap = argparse.ArgumentParser(description="War3 地图脚本注入工具")
    ap.add_argument("map", nargs="?", help="地图文件 (.w3m/.w3x)")
    ap.add_argument("script_dir", nargs="?", help="脚本目录（含 f.j/g.j/m.j）")
    ap.add_argument("--output", "-o", help="输出地图路径（默认覆盖）")
    ap.add_argument("--list-scripts", action="store_true", help="列出脚本目录")
    ap.add_argument("--show-main", action="store_true", help="显示 main 函数结构")
    ap.add_argument("--dry-run", action="store_true", help="只显示将要注入的内容")
    args = ap.parse_args()

    if args.list_scripts:
        base = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "scripts")
        print("可用脚本目录:")
        for d in sorted(os.listdir(base)):
            p = os.path.join(base, d)
            if os.path.isdir(p) and os.path.isfile(os.path.join(p, "f.j")):
                print("  %s" % d)
        return 0

    if not args.map:
        ap.error("需要指定地图文件")
    if not args.script_dir:
        ap.error("需要指定 script_dir")

    scripts = read_script_dir(args.script_dir)
    print("读取脚本: %s" % args.script_dir)
    for name, content in scripts.items():
        print("  %s: %d 字节" % (name, len(content)))

    # 读取 war3map.j
    archive = MPQArchive(args.map)
    war3map_j = archive.read_file("war3map.j")
    archive.close()

    if war3map_j is None:
        print("错误: 无法读取 war3map.j（地图可能加密）")
        print("提示: 请使用 HkeW3mModifier2.0.exe 等工具注入")
        return 1

    text = war3map_j.decode("utf-8", "replace")
    print("原 war3map.j: %d 字节" % len(war3map_j))

    if args.show_main:
        for i, line in enumerate(text.split("\n")):
            if "function main" in line or line.strip() == "globals" or line.strip() == "endglobals":
                print("  %4d: %s" % (i + 1, line))
        return 0

    new_text = inject_script(text, scripts["g.j"], scripts["f.j"], scripts["m.j"])
    print("注入后 war3map.j: %d 字节" % len(new_text.encode("utf-8")))

    if args.dry_run:
        print("--- 注入预览（前 80 行）---")
        for line in new_text.split("\n")[:80]:
            print(line)
        return 0

    out = args.output or args.map
    if out == args.map:
        backup = args.map + ".bak"
        if not os.path.exists(backup):
            shutil.copy2(args.map, backup)
            print("已备份原地图: %s" % backup)

    rebuild_map(args.map, out, {"war3map.j": new_text.encode("utf-8")})
    print("已写出: %s" % out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
