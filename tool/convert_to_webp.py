import os
from pathlib import Path
from PIL import Image

root = Path(r"c:\Users\rdinda\Documents\GitHub\FMA_Pontos\assets\images")
skip_delete = {"splash.png"}

def quality_for(path: Path) -> int:
    name = path.name.lower()
    if "logo" in name or "splashscrean" in name:
        return 90
    return 85

converted = []
errors = []
for ext in ("*.png", "*.jpg", "*.jpeg"):
    for src in root.rglob(ext):
        q = quality_for(src)
        dst = src.with_suffix(".webp")
        try:
            with Image.open(src) as im:
                if im.mode in ("RGBA", "LA", "P"):
                    im = im.convert("RGBA")
                else:
                    im = im.convert("RGB")
                im.save(dst, "WEBP", quality=q, method=6)
            converted.append((src, dst, src.stat().st_size, dst.stat().st_size))
        except Exception as e:
            errors.append((str(src), str(e)))

print(f"Converted: {len(converted)}")
for src, dst, sb, db in converted:
    print(f"  {src.name}: {sb/1024/1024:.2f}MB -> {dst.name}: {db/1024/1024:.2f}MB")
if errors:
    print("Errors:", errors)

deleted = 0
for src, dst, _, _ in converted:
    if src.name in skip_delete:
        continue
    src.unlink()
    deleted += 1
print(f"Deleted PNGs: {deleted}, kept: {list(skip_delete)}")
