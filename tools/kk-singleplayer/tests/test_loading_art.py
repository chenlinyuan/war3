# -*- coding: utf-8 -*-
from __future__ import annotations

import struct
import sys
import unittest
from pathlib import Path

from PIL import Image, ImageDraw, ImageOps


ROOT = Path(__file__).resolve().parents[3]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import fix_campaign_loading_art as ART  # noqa: E402
from doctor.models import mdxgroups, mdxnodes  # noqa: E402
from doctor.viewers import map_card  # noqa: E402


class WidescreenCompositionTest(unittest.TestCase):
    def test_square_art_is_centered_without_distortion(self) -> None:
        source = Image.new("RGB", (512, 512), "#6a4228")
        draw = ImageDraw.Draw(source)
        draw.rectangle((0, 0, 255, 511), fill="#cf3030")
        draw.rectangle((256, 0, 511, 511), fill="#305fcf")

        output = ART.compose_widescreen(source)
        self.assertEqual(output.size, ART.TARGET_SIZE)
        restored = source.resize(
            (
                round(source.width * ART.SOURCE_HORIZONTAL_EXPANSION),
                source.height,
            ),
            Image.Resampling.LANCZOS,
        )
        expected = ImageOps.contain(
            restored,
            ART.TARGET_SIZE,
            method=Image.Resampling.LANCZOS,
        )
        left = (ART.TARGET_SIZE[0] - expected.width) // 2
        top = (ART.TARGET_SIZE[1] - expected.height) // 2
        self.assertEqual(output.getpixel((left + 100, top + 100)), expected.getpixel((100, 100)))
        self.assertNotEqual(output.getpixel((20, 20)), (0, 0, 0))

    def test_blp_round_trip_is_16_by_9(self) -> None:
        source = Image.new("RGB", (512, 512), "#5b4935")
        data = ART._blp_bytes(ART.compose_widescreen(source))
        width, height, _pixels, kind = map_card.decode(data, "test.blp")
        self.assertEqual((width, height), ART.TARGET_SIZE)
        self.assertEqual(kind, "BLP1/JPEG")


def plane_mdx() -> bytes:
    vertices = [
        0.0, 0.0, 0.0,
        0.8, 0.0, 0.0,
        0.8, 0.6, 0.0,
        0.0, 0.6, 0.0,
    ]
    geoset = {
        "vrtx": vertices,
        "nrms": [0.0, 0.0, 1.0] * 4,
        "ptyp": (4,),
        "pcnt": (6,),
        "pvtx": (0, 1, 2, 0, 2, 3),
        "gndx": [0, 0, 0, 0],
        "groups": ((0,),),
        "matid": 0,
        "selgroup": 0,
        "selflags": 0,
        "ext": (0.0,) * 7,
        "seqext": b"",
        "uvs": [(1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0)],
        "tail": b"",
    }
    body = mdxgroups.build_geoset(geoset)
    return b"MDLX" + b"GEOS" + struct.pack("<I", len(body)) + body


class LoadingModelGeometryTest(unittest.TestCase):
    def test_chapter_plane_is_expanded_to_16_by_9(self) -> None:
        patched = ART._patch_plane(plane_mdx(), ART.WIDE_LOADING_WIDTH, 0.6)
        chunks = mdxnodes.parse_chunks(patched)
        geos = next(body for name, body in chunks if name == b"GEOS")
        raw = mdxnodes.split_geosets(geos)[0]
        model = mdxgroups.geoset_full(raw)
        xs, ys = model["vrtx"][0::3], model["vrtx"][1::3]
        self.assertAlmostEqual(max(xs), ART.WIDE_LOADING_WIDTH, places=5)
        self.assertAlmostEqual(max(ys), 0.6, places=5)

    def test_campaign_background_fills_score_screen(self) -> None:
        patched = ART._patch_plane(
            plane_mdx(),
            ART.SCORE_SCREEN_WIDTH,
            ART.SCORE_SCREEN_HEIGHT,
        )
        chunks = mdxnodes.parse_chunks(patched)
        geos = next(body for name, body in chunks if name == b"GEOS")
        raw = mdxnodes.split_geosets(geos)[0]
        model = mdxgroups.geoset_full(raw)
        xs, ys = model["vrtx"][0::3], model["vrtx"][1::3]
        self.assertAlmostEqual(max(xs), 16 / 9, places=5)
        self.assertAlmostEqual(max(ys), 1.0, places=5)


if __name__ == "__main__":
    unittest.main()
