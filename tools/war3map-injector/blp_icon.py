"""极简 BLP 图标读写（只处理 BLP1 调色板格式，War3 1.27 图标就是这种）。

BLP1 结构（little-endian）:
    magic      'BLP1'
    content    0 = JPEG, 1 = 调色板
    alphaBits  0/1/4/8
    width      u32
    height     u32
    hasMips    u32 (0/1)
    -> 然后 offsets[16] (u32) + sizes[16] (u32)，单位 = 相对文件开头
    -> 调色板 256 * (B,G,R,A) 紧跟其后（仅调色板格式）
    -> 每个 mip: 先 alpha (w*h 字节, 仅 alphaBits>0), 再索引 (w*h 字节)

用法:
    python blp_icon.py read <in.blp> <out.png>      # 转成 png 便于查看
    python blp_icon.py write <in.png> <out.blp>     # png -> BLP1(调色板, 带 mipmap)
"""
import struct
import sys

import numpy as np
from PIL import Image, ImageFile

# BLP1 里的 JPEG 数据有时会被我们自己的 MPQ 读取截断（尾段丢失），
#   宽容模式下依然能解出图（缺的一小块会变灰）。游戏里用的是完整文件，不受影响。
ImageFile.LOAD_TRUNCATED_IMAGES = True


def read_blp(path):
    raw = open(path, "rb").read()
    magic = raw[:4]
    if magic not in (b"BLP1", b"BLP2"):
        raise ValueError("not a BLP: %r" % magic)
    content, alpha_bits, width, height, has_mips = struct.unpack_from("<IIIII", raw, 4)
    if magic == b"BLP2":
        raise ValueError("BLP2 (DXT/JPEG) 暂不支持")
    if content == 0:
        # JPEG 格式（War3 原版图标就是这种）: 每个 mip 是一段 JPEG;
        # 若 alphaBits>0, 主 mip 的 JPEG 之后紧跟 w*h 字节原始 alpha。
        offs = struct.unpack_from("<16I", raw, 28)
        sizes = struct.unpack_from("<16I", raw, 92)
        import io

        # 实测: offsets[i] 指向"10 字节公共 JPEG 头之后", 真正的 JPEG 从 offsets[i]-10 开始
        start = max(0, offs[0] - 10)
        chunk = raw[start:offs[0] + sizes[0]]
        eoi = chunk.rfind(b"\xff\xd9")
        jpeg = chunk[: eoi + 2]
        img = Image.open(io.BytesIO(jpeg)).convert("RGB")
        rgba = np.dstack([np.array(img), np.full((height, width), 255, np.uint8)])
        return width, height, alpha_bits, has_mips, sizes[0], rgba
    if content != 1:
        raise ValueError("BLP1 未知 content=%d" % content)
    offs = struct.unpack_from("<16I", raw, 28)
    sizes = struct.unpack_from("<16I", raw, 92)
    pal_off = 28 + 64 + 64  # header(28) + offsets(64) + sizes(64)
    pal = np.frombuffer(raw, dtype=np.uint8, count=1024, offset=pal_off).reshape(256, 4)
    pal = pal[:, [2, 1, 0, 3]]  # BGRA -> RGBA
    # 实测(用本工程导入的 FWING.blp 反解验证): 每个 mip 是 索引(w*h) 在前、alpha(w*h) 在后
    start = offs[0]
    idx = np.frombuffer(raw, dtype=np.uint8, count=width * height, offset=start)
    img = pal[idx]
    rgba = img.reshape(height, width, 4)
    if alpha_bits:
        a = np.frombuffer(raw, dtype=np.uint8, count=width * height, offset=start + width * height)
        rgba[:, :, 3] = a.reshape(height, width)
    else:
        rgba[:, :, 3] = 255
    return width, height, alpha_bits, has_mips, sizes[0], rgba


def write_blp1(path, img, mips=False, quality=90):
    """img: PIL.Image (RGB/RGBA)。输出 BLP1 + JPEG 格式(同原版图标), alphaBits=8。

    mips=False 只写主 mip（原版图标多为多 mip，但引擎只用第 0 级画图标）。
    """
    img = img.convert("RGBA")
    w, h = img.size
    levels = [(w, h)]
    if mips:
        cw, ch = w, h
        while cw > 1 and ch > 1:
            cw //= 2
            ch //= 2
            levels.append((cw, ch))

    mip_imgs = []
    for (lw, lh) in levels:
        small = img if (lw, lh) == (w, h) else img.resize((lw, lh), Image.LANCZOS)
        mip_imgs.append(small)

    import io

    chunks = []
    for k, (im, (lw, lh)) in enumerate(zip(mip_imgs, levels)):
        buf = io.BytesIO()
        im.convert("RGB").save(buf, format="JPEG", quality=quality, subsampling=0)
        data = buf.getvalue()
        if k == 0:
            # 主 mip 后面跟原始 alpha
            data += np.array(im.split()[3], dtype=np.uint8).tobytes()
        chunks.append(data)

    header_size = 24 + 64 + 64
    offsets = []
    pos = header_size
    for data in chunks:
        offsets.append(pos)
        pos += len(data)
    sizes = [len(data) for data in chunks]

    out = bytearray()
    out += b"BLP1"
    out += struct.pack("<IIIII", 0, 8, w, h, 1 if mips else 0)
    offs = offsets + [0] * (16 - len(offsets))
    szs = sizes + [0] * (16 - len(sizes))
    out += struct.pack("<16I", *offs)
    out += struct.pack("<16I", *szs)
    for data in chunks:
        out += data
    open(path, "wb").write(bytes(out))
    return len(out), levels


def write_blp1_palette(path, img, min_size=4, colors=256):
    """写 BLP1 调色板格式（content=1, alphaBits=8）—— 和 War3 自带图标/本图 fwing.blp 同款。

    布局（用本工程导入的 fwing.blp 反解确认）:
        header 28B: 'BLP1', content=1, alphaBits=8, w, h, mipCount-1, 1
        offsets[16], sizes[16]
        palette 256 * BGRA
        每个 mip: 索引(w*h) 然后 alpha(w*h)
    """
    img = img.convert("RGBA")
    w, h = img.size
    levels = [(w, h)]
    cw, ch = w, h
    while cw > min_size and ch > min_size:
        cw //= 2
        ch //= 2
        levels.append((cw, ch))

    rgb = img.convert("RGB")
    q = rgb.quantize(colors=colors, method=Image.MEDIANCUT)
    pal = np.array(q.getpalette()[: colors * 3], dtype=np.uint8).reshape(colors, 3)
    pal256 = np.zeros((256, 4), dtype=np.uint8)
    pal256[:colors, :3] = pal[:, [2, 1, 0]]  # BGR

    p32 = pal.astype(np.int32)

    def quantize(im):
        arr = np.array(im.convert("RGB"), dtype=np.int32)
        d = ((arr[:, :, None, :] - p32[None, None, :, :]) ** 2).sum(axis=3)
        return d.argmin(axis=2).astype(np.uint8)

    chunks = []
    for (lw, lh) in levels:
        im = img if (lw, lh) == (w, h) else img.resize((lw, lh), Image.LANCZOS)
        idx = quantize(im)
        alpha = np.array(im.split()[3], dtype=np.uint8)
        chunks.append(idx.tobytes() + alpha.tobytes())

    header_size = 28 + 64 + 64 + 1024
    offsets, pos = [], header_size
    for data in chunks:
        offsets.append(pos)
        pos += len(data)
    sizes = [len(d) for d in chunks]

    out = bytearray()
    out += b"BLP1"
    out += struct.pack("<6I", 1, 8, w, h, len(levels) - 1, 1)
    out += struct.pack("<16I", *(offsets + [0] * (16 - len(offsets))))
    out += struct.pack("<16I", *(sizes + [0] * (16 - len(sizes))))
    out += pal256.tobytes()
    for data in chunks:
        out += data
    open(path, "wb").write(bytes(out))
    return len(out), levels


def main():
    cmd = sys.argv[1]
    if cmd == "read":
        w, h, ab, hm, s0, rgba = read_blp(sys.argv[2])
        print("size=%dx%d alphaBits=%d hasMips=%d mip0=%d bytes" % (w, h, ab, hm, s0))
        Image.fromarray(rgba, "RGBA").save(sys.argv[3])
        print("wrote", sys.argv[3])
    elif cmd == "write":
        img = Image.open(sys.argv[2])
        n, levels = write_blp1(sys.argv[3], img)
        print("wrote %s (%d bytes, %d mips)" % (sys.argv[3], n, len(levels)))
    elif cmd == "writepal":
        img = Image.open(sys.argv[2])
        to = int(sys.argv[4]) if len(sys.argv) > 4 else 4
        n, levels = write_blp1_palette(sys.argv[3], img, min_size=to)
        print("wrote %s (%d bytes, %d mips)" % (sys.argv[3], n, len(levels)))
    else:
        print(__doc__)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
