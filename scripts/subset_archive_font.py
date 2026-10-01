"""Usage: python subset_archive_font.py ORIGINAL_TTF PUBLICATION_DIR OUTPUT_WOFF2."""
import argparse
from html import unescape
from pathlib import Path

from fontTools import subset
from fontTools.ttLib import TTFont

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("font", type=Path)
parser.add_argument("publication", type=Path)
parser.add_argument("output", type=Path)
args = parser.parse_args()

characters = set()
for page in args.publication.rglob("*.html"):
    if page.is_file() and ".pygments-cache" not in page.parts:
        characters.update(unescape(page.read_text(encoding="utf-8")))
unicodes = {ord(character) for character in characters}
for start, end in [(32, 592), (0x2000, 0x2070), (0x3000, 0x3040), (0xFF00, 0xFFF0)]:
    unicodes.update(range(start, end))

font = TTFont(args.font)
supported = set(font.getBestCmap())
missing = sorted(code for code in unicodes - supported if 0x3400 <= code <= 0x9FFF)
if missing:
    raise ValueError(f"Missing Chinese characters: {missing}")
options = subset.Options()
options.flavor = "woff2"
options.recalc_timestamp = False
subsetter = subset.Subsetter(options=options)
subsetter.populate(unicodes=unicodes & supported)
subsetter.subset(font)
font.flavor = "woff2"
args.output.parent.mkdir(parents=True, exist_ok=True)
font.save(args.output)
print(f"Saved {args.output}: {args.output.stat().st_size:,} bytes")
