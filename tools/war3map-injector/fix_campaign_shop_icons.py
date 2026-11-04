"""Add disabled variants for campaign-imported item icons.

远离开商店时，物品槽使用 DIS+图标名 的禁用图标。燃烧战役的
war3campImported 图标只有启用版，因此会显示绿块。这个脚本按
同目录 DIS 前缀规则补齐禁用版（内容沿用启用图标，避免绿块）。
"""
import glob
import io
import os
import struct
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
import mpq_patch as MP  # noqa: E402
import numpy as np  # noqa: E402
from PIL import Image  # noqa: E402
from blp_icon import read_blp, write_blp1_palette  # noqa: E402


def parse_w3t_icons(data):
    off = 8
    ver = struct.unpack_from("<i", data, 0)[0]
    orig = struct.unpack_from("<i", data, 4)[0]
    out = []

    def value(pos, t):
        if t == 0:
            return struct.unpack_from("<i", data, pos)[0], pos + 4
        if t in (1, 2):
            return struct.unpack_from("<f", data, pos)[0], pos + 4
        if t == 3:
            e = data.index(b"\x00", pos)
            return data[pos:e].decode("utf-8", "replace"), e + 1
        raise ValueError("bad type %d" % t)

    def entry(pos):
        old = data[pos:pos + 4].decode("latin-1")
        new = data[pos + 4:pos + 8].decode("latin-1")
        pos += 8
        n = struct.unpack_from("<i", data, pos)[0]
        pos += 4
        mods = {}
        for _ in range(n):
            mid = data[pos:pos + 4].decode("latin-1")
            t = struct.unpack_from("<i", data, pos + 4)[0]
            pos += 8
            v, pos = value(pos, t)
            pos += 4  # end marker
            mods[mid] = v
        return old, new, mods, pos

    for _ in range(orig):
        _old, _new, _mods, off = entry(off)
    cust = struct.unpack_from("<i", data, off)[0]
    off += 4
    for _ in range(cust):
        _old, _new, mods, off = entry(off)
        ic = mods.get("iico", "")
        if isinstance(ic, str) and ic and ic not in ("-", "_"):
            out.append(ic)
    if off != len(data):
        raise ValueError("w3t trailing %d bytes" % (len(data) - off))
    return out


def darken_icon(data):
    """Return a darkened, desaturated BLP1 image for a disabled item icon."""
    a = tempfile.NamedTemporaryFile(suffix=".blp", delete=False)
    b = tempfile.NamedTemporaryFile(suffix=".blp", delete=False)
    a.close()
    b.close()
    try:
        with open(a.name, "wb") as f:
            f.write(data)
        try:
            _w, _h, _ab, _hm, _s0, rgba = read_blp(a.name)
        except Exception:
            # Some campaign BLP1-JPEG icons put the shared JPEG header before
            # offsets[0], so read_blp's offs[0]-10 assumption misses the SOI.
            if data[:4] != b"BLP1":
                raise
            content, _ab, w, h, _mips = struct.unpack_from("<IIIII", data, 4)
            if content != 0:
                raise
            soi = data.find(b"\xff\xd8")
            eoi = data.rfind(b"\xff\xd9")
            if soi < 0 or eoi <= soi:
                raise
            img = Image.open(io.BytesIO(data[soi:eoi + 2])).convert("RGBA")
            if img.size != (w, h):
                img = img.resize((w, h), Image.LANCZOS)
            rgba = np.array(img)
        arr = rgba.astype(np.float32)
        gray = (arr[:, :, 0] * 0.299 + arr[:, :, 1] * 0.587 +
                arr[:, :, 2] * 0.114)[:, :, None]
        rgb = (arr[:, :, :3] * 0.65 + gray * 0.35) * 0.50
        arr[:, :, :3] = np.clip(rgb, 0, 255)
        img = Image.fromarray(arr.astype(np.uint8), "RGBA")
        # Icons are 64x64 UI assets.  Use the same palette-BLP writer as the
        # hero icons; the JPEG variant caused the game's resource parser to
        # read an invalid string pointer.
        if img.size != (64, 64):
            img = img.resize((64, 64), Image.LANCZOS)
        write_blp1_palette(b.name, img, min_size=4, colors=256)
        with open(b.name, "rb") as f:
            return f.read()
    finally:
        for p in (a.name, b.name):
            try:
                os.remove(p)
            except OSError:
                pass


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    src = os.path.abspath(sys.argv[1])
    out = os.path.abspath(sys.argv[3]) if len(sys.argv) > 3 and sys.argv[2] == "--out" else src
    a = W.MPQArchive(src)
    try:
        w3t = a.read_file("war3campaign.w3t")
        names = set(n.lower() for n in a.listfile)
        payload = []
        seen = set()
        for icon in parse_w3t_icons(w3t):
            path = icon.replace("/", "\\")
            if not path.lower().startswith(("war3campimported\\", "war3mapimported\\")):
                continue
            if path.lower() not in names:
                continue
            folder, base = os.path.split(path)
            data = a.read_file(path)
            if not data:
                continue
            try:
                dark = darken_icon(data)
            except Exception as e:
                print("  ! darken failed %s: %s" % (path, e))
                dark = data
            aliases = (
                folder + "\\DIS" + base,
                folder + "\\DISBTN" + base,
                "ReplaceableTextures\\CommandButtonsDisabled\\DIS" + base,
                "ReplaceableTextures\\CommandButtonsDisabled\\DISBTN" + base,
            )
            for dis in aliases:
                key = dis.lower()
                if key in names or key in seen:
                    continue
                seen.add(key)
                payload.append((dis, dark))
    finally:
        a.close()
    print("missing disabled icons:", len(payload))
    if not payload:
        return 0
    new_path = MP.patch(src, payload, out_path=out, backup=False)
    ok = MP.verify(src, new_path, payload)
    print("disabled-icon patch:", "OK" if ok else "FAIL", new_path)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
