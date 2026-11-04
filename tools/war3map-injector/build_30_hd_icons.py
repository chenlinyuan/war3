"""Build the Warcraft III 3.0 HD icons used by the Lost Temple additions."""
import io
import os
import sys

from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
DEVOS = os.path.join(BASE, "tools", "_devos-map-doctor",
                     "devos-map-doctor-main")
sys.path.insert(0, DEVOS)

from doctor.data.casc_wc3 import CascWC3  # noqa: E402
from doctor.models.blpwrite import save_blp  # noqa: E402

GAME = r"H:\Games\Warcraft III"
OUT = os.path.join(BASE, "heroes", "item_icons")

ICONS = [
    (
        r"ReplaceableTextures\CommandButtons\BTNSpellSteal.dds",
        "BTNArchimondeHand_30HD.blp",
    ),
    (
        r"ReplaceableTextures\CommandButtonsDisabled\DISBTNSpellSteal.dds",
        "DISBTNArchimondeHand_30HD.blp",
    ),
    (
        r"ReplaceableTextures\CommandButtons\BTNFrostmourne.dds",
        "BTNFrostmourne_30HD.blp",
    ),
    (
        r"ReplaceableTextures\CommandButtonsDisabled\DISBTNFrostmourne.dds",
        "DISBTNFrostmourne_30HD.blp",
    ),
    (
        r"ReplaceableTextures\CommandButtons\BTNHeroAvatarOfFlame.dds",
        "BTNFirelordAvatar_30HD.blp",
    ),
    (
        r"ReplaceableTextures\CommandButtonsDisabled\DISBTNHeroAvatarOfFlame.dds",
        "DISBTNFirelordAvatar_30HD.blp",
    ),
]


def main():
    os.makedirs(OUT, exist_ok=True)
    casc = CascWC3(GAME)
    for source, filename in ICONS:
        image = Image.open(io.BytesIO(casc.read_wc3(source, hd=True))).convert("RGBA")
        target = os.path.join(OUT, filename)
        levels, size = save_blp(
            image, target, quality=92, alpha_bits=8, mipmaps=True
        )
        print("%-32s %dx%d -> %d bytes, %d mips"
              % (filename, image.width, image.height, size, levels))
    return 0


if __name__ == "__main__":
    sys.exit(main())
