# -*- coding: utf-8 -*-
"""Extract and convert Warcraft III 3.0's Reforged Blade Master for 1.27."""
import os
import struct
import subprocess
import sys

import numpy as np
from PIL import Image
import io

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
DEVOS = os.path.join(BASE, "tools", "_devos-map-doctor",
                     "devos-map-doctor-main")
sys.path.insert(0, DEVOS)

from doctor.data.casc_wc3 import CascWC3  # noqa: E402
from doctor.models.blpwrite import save_blp  # noqa: E402

GAME = r"H:\Games\Warcraft III"
MODEL_PATH = r"Units\Orc\HeroBladeMaster\HeroBladeMaster.mdx"
OUT = os.path.join(BASE, "heroes", "blade_master", "reforged")
WORK = os.path.join(HERE, "_reforged_blademaster_work")
NODE_DIR = os.path.join(HERE, "reforged_blademaster")

TEXTURES = {
    "HeroBladeMaster_Main": (
        r"Units\Orc\HeroBladeMaster\orc_blademaster_main_diffuse.dds",
        r"Units\Orc\HeroBladeMaster\orc_blademaster_main_orm.dds",
    ),
    "HeroBladeMaster_Hair": (
        r"Units\Orc\HeroBladeMaster\orc_blademaster_hair_diffuse.dds",
        r"Units\Orc\HeroBladeMaster\orc_blademaster_hair_orm.dds",
    ),
    "HeroBladeMaster_Flag": (
        r"Units\Orc\HeroBladeMaster\orc_blademaster_flag_diffuse.dds",
        r"Units\Orc\HeroBladeMaster\orc_blademaster_flag_orm.dds",
    ),
    "HeroBladeMaster_Weapon": (
        r"Units\Orc\HeroBladeMaster\orc_blademaster_weapon_diffuse.dds",
        r"Units\Orc\HeroBladeMaster\orc_blademaster_weapon_orm.dds",
    ),
}


def filter_mdx_chunks(data):
    drop = {b"CAMS", b"CORN", b"FAFX", b"BPOS"}
    out = bytearray(data[:4])
    pos = 4
    kept = []
    while pos + 8 <= len(data):
        tag = data[pos:pos + 4]
        size = struct.unpack_from("<I", data, pos + 4)[0]
        end = pos + 8 + size
        if end > len(data):
            raise SystemExit("truncated MDX chunk %r" % tag)
        if tag not in drop:
            out += data[pos:end]
            kept.append(tag.decode("latin-1"))
        pos = end
    return bytes(out), kept


def dds_image(data):
    return Image.open(io.BytesIO(data)).convert("RGBA")


def write_texture(casc, stem, spec):
    if isinstance(spec, tuple):
        diffuse_path, orm_path = spec
        image = dds_image(casc.read_wc3(diffuse_path, hd=True))
        mask = np.array(
            dds_image(casc.read_wc3(orm_path, hd=True)).getchannel("A"),
            dtype=np.float32,
        ) / 255.0
        rgba = np.array(image, dtype=np.uint8)
        rgba[:, :, 3] = np.rint(rgba[:, :, 3].astype(np.float32) * (1.0 - mask))
        image = Image.fromarray(rgba, "RGBA")
    else:
        image = dds_image(casc.read_wc3(spec, hd=True))
    path = os.path.join(OUT, stem + ".blp")
    levels, size = save_blp(image, path, quality=92, alpha_bits=8, mipmaps=True)
    print("%-28s %dx%d -> %s (%d mips, %d bytes)"
          % (stem, image.width, image.height, path, levels, size))


def main():
    os.makedirs(OUT, exist_ok=True)
    os.makedirs(WORK, exist_ok=True)
    casc = CascWC3(GAME)

    hd_model = casc.read_wc3(MODEL_PATH, hd=True)
    filtered, kept = filter_mdx_chunks(hd_model)
    filtered_path = os.path.join(WORK, "HeroBladeMaster_HD_filtered.mdx")
    open(filtered_path, "wb").write(filtered)
    print("HD model:", len(hd_model), "bytes; kept chunks:", ",".join(kept))

    for stem, spec in TEXTURES.items():
        write_texture(casc, stem, spec)

    node_modules = os.path.join(NODE_DIR, "node_modules", "war3-model")
    if not os.path.isdir(node_modules):
        subprocess.run(["npm", "install", "--no-audit", "--no-fund"],
                       cwd=NODE_DIR, check=True)
    output_model = os.path.join(OUT, "HeroBladeMaster_Reforged.mdx")
    subprocess.run(
        ["node", os.path.join(NODE_DIR, "convert_model.js"),
         filtered_path, output_model],
        cwd=NODE_DIR,
        check=True,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
