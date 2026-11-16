# -*- coding: utf-8 -*-
"""Convert square/4:3 campaign loading art into non-distorted 16:9 assets."""
from __future__ import annotations

import struct
import sys
import tempfile
from pathlib import Path
from typing import Any

from PIL import Image, ImageEnhance, ImageFilter, ImageOps


ROOT = Path(__file__).resolve().parents[2]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))

import war3mpq as W  # noqa: E402
from doctor.data import campaign_info, w3i  # noqa: E402
from doctor.models import blpwrite, mdxgroups, mdxnodes, mdxtex  # noqa: E402
from doctor.viewers import map_card  # noqa: E402


TARGET_SIZE = (1024, 576)
TARGET_ASPECT = TARGET_SIZE[0] / TARGET_SIZE[1]
WIDE_LOADING_WIDTH = 0.8 * (TARGET_ASPECT / (0.8 / 0.6))
SCORE_SCREEN_WIDTH = TARGET_ASPECT
SCORE_SCREEN_HEIGHT = 1.0


def compose_widescreen(image: Image.Image) -> Image.Image:
    """Keep the source artwork intact and fill the sides with blurred artwork."""
    image = image.convert("RGB")
    background = ImageOps.fit(
        image,
        TARGET_SIZE,
        method=Image.Resampling.LANCZOS,
    ).filter(ImageFilter.GaussianBlur(32))
    background = ImageEnhance.Brightness(background).enhance(0.45)
    background = Image.blend(
        background,
        Image.new("RGB", TARGET_SIZE, (0, 0, 0)),
        0.18,
    )
    foreground = ImageOps.contain(
        image,
        TARGET_SIZE,
        method=Image.Resampling.LANCZOS,
    )
    left = (TARGET_SIZE[0] - foreground.width) // 2
    top = (TARGET_SIZE[1] - foreground.height) // 2
    background.paste(foreground, (left, top))
    return background


def _blp_bytes(image: Image.Image) -> bytes:
    with tempfile.TemporaryDirectory(prefix="loading-art-") as temporary:
        path = Path(temporary) / "texture.blp"
        blpwrite.save_blp(image, path, quality=92, mipmaps=True)
        return path.read_bytes()


def _read_archive_file(archive: W.MPQArchive, name: str) -> tuple[str, bytes]:
    normalized = name.replace("/", "\\")
    if hasattr(archive, "read_file"):
        actual = next(
            (
                candidate
                for candidate in archive.files()
                if candidate.casefold() == normalized.casefold()
            ),
            normalized,
        )
        data = archive.read_file(actual)
    else:
        actual = normalized
        data = map_card._get(archive, actual)
    if not data:
        raise ValueError("archive entry is missing: " + name)
    return actual, data


def _patch_plane(
    mdx: bytes,
    target_width: float,
    target_height: float,
) -> bytes:
    chunks = mdxnodes.parse_chunks(mdx)
    geos_index = next(
        (index for index, chunk in enumerate(chunks) if chunk[0] == b"GEOS"),
        None,
    )
    if geos_index is None:
        raise ValueError("loading-screen model has no GEOS chunk")
    body = bytearray()
    for raw_geoset in mdxnodes.split_geosets(chunks[geos_index][1]):
        geoset = mdxgroups.geoset_full(raw_geoset)
        vertices = geoset["vrtx"]
        xs = vertices[0::3]
        ys = vertices[1::3]
        min_x, max_x = min(xs), max(xs)
        min_y, max_y = min(ys), max(ys)
        x_span = max(max_x - min_x, 1e-6)
        y_span = max(max_y - min_y, 1e-6)
        scaled = []
        for index, value in enumerate(vertices):
            if index % 3 == 0:
                scaled.append((value - min_x) / x_span * target_width)
            elif index % 3 == 1:
                scaled.append((value - min_y) / y_span * target_height)
            else:
                scaled.append(value)
        geoset["vrtx"] = scaled
        geoset["ext"] = mdxgroups.extents_of(scaled)
        body += mdxgroups.build_geoset(geoset)
    chunks[geos_index][1] = body
    return b"MDLX" + b"".join(
        name + struct.pack("<I", len(data)) + bytes(data)
        for name, data in chunks
    )


def _decode_texture(data: bytes, name: str) -> Image.Image:
    width, height, pixels, _kind = map_card.decode(data, name)
    return Image.frombytes("RGBA", (width, height), pixels)


def _loading_texture_patches(
    archive: W.MPQArchive,
    screen: dict[str, Any],
    datas: dict[str, bytes],
    target_width: float,
    target_height: float,
) -> tuple[list[tuple[str, bytes]], dict[str, object]]:
    textures = screen.get("textures") or []
    layout = screen.get("layout")
    model = str(screen.get("model") or "")
    if layout == "single" and len(textures) == 1:
        texture = textures[0]
        image = _decode_texture(datas[str(texture["file"])], str(texture["cited"]))
        composed = compose_widescreen(image)
        patches = [(str(texture["file"]), _blp_bytes(composed))]
    elif layout == "quadrants" and len(textures) == 4:
        width, height, pixels, _files, _fmt = map_card._loading_pixels(screen, datas)
        composed = compose_widescreen(
            Image.frombytes("RGBA", (width, height), pixels)
        )
        patches = []
        half_w, half_h = TARGET_SIZE[0] // 2, TARGET_SIZE[1] // 2
        boxes = {
            "TL": (0, 0, half_w, half_h),
            "TR": (half_w, 0, TARGET_SIZE[0], half_h),
            "BL": (0, half_h, half_w, TARGET_SIZE[1]),
            "BR": (half_w, half_h, TARGET_SIZE[0], TARGET_SIZE[1]),
        }
        for texture in textures:
            quadrant = str(texture.get("quadrant") or "")
            if quadrant not in boxes:
                raise ValueError("unknown loading-screen quadrant: " + quadrant)
            patches.append(
                (
                    str(texture["file"]),
                    _blp_bytes(composed.crop(boxes[quadrant])),
                )
            )
    else:
        raise ValueError("unsupported loading-screen texture layout: " + str(layout))

    if model.lower().endswith((".mdx", ".mdl")):
        actual_model, model_data = _read_archive_file(archive, model)
        patches.append(
            (
                actual_model,
                _patch_plane(
                    model_data,
                    target_width,
                    target_height,
                ),
            )
        )
    else:
        raise ValueError("unsupported loading-screen model: " + model)
    return patches, {
        "model": model,
        "layout": layout,
        "textures": [str(texture["file"]) for texture in textures],
        "target_size": list(TARGET_SIZE),
    }


def chapter_loading_patches(
    map_path: Path,
) -> tuple[list[tuple[str, bytes]], dict[str, object] | None]:
    archive = map_card._open(map_path)
    info = map_card._get(archive, "war3map.w3i") or b""
    if not info:
        return [], None
    model = w3i.parse(info)
    screen, datas = map_card._loading_screen(archive, model)
    if not screen.get("custom") or not screen.get("replaceable"):
        return [], None
    patches, record = _loading_texture_patches(
        archive,
        screen,
        datas,
        WIDE_LOADING_WIDTH,
        0.6,
    )
    return patches, record


def campaign_background_patches(
    campaign_path: Path,
) -> tuple[list[tuple[str, bytes]], dict[str, object] | None]:
    archive = W.MPQArchive(str(campaign_path))
    try:
        source = archive.read_file("war3campaign.w3f") or b""
        if not source:
            return [], None
        model = campaign_info.parse(source)
        raw_model_path = model.get("background_path") or b""
        model_path = (
            raw_model_path.decode("utf-8", "replace")
            if isinstance(raw_model_path, bytes)
            else str(raw_model_path)
        ).replace("/", "\\")
        if not model_path or model_path.lower().endswith(".blp"):
            return [], None
        actual_model, model_data = _read_archive_file(archive, model_path)
        cited = mdxtex.mdx_textures(model_data)
        datas: dict[str, bytes] = {}
        textures: list[dict[str, object]] = []
        screen: dict[str, Any] = {
            "model": model_path,
            "layout": "single" if len(cited) == 1 else "quadrants",
            "textures": [],
        }
        for citation in cited:
            actual, data = _read_archive_file(archive, citation)
            width, height, kind = map_card._header_size(data, actual)
            quadrant = map_card._quadrant(actual)
            datas[actual] = data
            texture = {
                "cited": actual,
                "file": actual,
                "format": kind,
                "width": width,
                "height": height,
                "quadrant": quadrant,
            }
            textures.append(texture)
            screen["textures"].append(texture)
        if len(textures) == 1:
            screen["size"] = [textures[0]["width"], textures[0]["height"]]
        elif len(textures) == 4:
            by_quadrant = {
                str(texture["quadrant"] or ""): texture
                for texture in textures
            }
            if sorted(by_quadrant) == sorted(map_card.QUADRANTS):
                screen["size"] = [
                    int(by_quadrant["TL"]["width"])
                    + int(by_quadrant["TR"]["width"]),
                    int(by_quadrant["TL"]["height"])
                    + int(by_quadrant["BL"]["height"]),
                ]
            else:
                screen["size"] = None
        else:
            screen["size"] = None
        patches, record = _loading_texture_patches(
            archive,
            screen,
            datas,
            SCORE_SCREEN_WIDTH,
            SCORE_SCREEN_HEIGHT,
        )
        return patches, record
    finally:
        archive.close()
