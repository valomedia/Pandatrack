#!/usr/bin/env python3
"""Rename exported xcresult screenshots using their attachment slugs."""

from __future__ import annotations

import re
import sys
from pathlib import Path

GENERATED_SUFFIX_PATTERN = re.compile(
    r"_[0-9]+_[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
)
EXPORT_LOG_PATTERN = re.compile(r'File:\s*(?P<file>[^,\s]+\.png),\s*suggested name:\s*"(?P<suggested>[^\"]+\.png)"')
SLUG_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")


def attachment_slug(suggested_name: str) -> str:
    slug = GENERATED_SUFFIX_PATTERN.sub("", Path(suggested_name).stem)
    if not SLUG_PATTERN.fullmatch(slug):
        raise SystemExit(f"Screenshot attachment name is not a slug: {slug}")
    return slug


def png_pixel_size(path: Path) -> tuple[int, int]:
    data = path.read_bytes()
    if len(data) < 24 or data[:8] != b"\x89PNG\r\n\x1a\n":
        raise SystemExit(f"Screenshot is not a valid PNG: {path}")

    return int.from_bytes(data[16:20], "big"), int.from_bytes(data[20:24], "big")


def verify_orientation(path: Path) -> None:
    stem = path.stem
    if stem.endswith("-landscape") or re.search(r"-landscape-[0-9]+$", stem):
        width, height = png_pixel_size(path)
        if width <= height:
            raise SystemExit(f"Landscape screenshot is not wider than high: {path.name} ({width}x{height})")
    elif stem.endswith("-portrait") or re.search(r"-portrait-[0-9]+$", stem):
        width, height = png_pixel_size(path)
        if height <= width:
            raise SystemExit(f"Portrait screenshot is not higher than wide: {path.name} ({width}x{height})")


def unique_destination(output_directory: Path, slug: str, used_destinations: set[Path]) -> Path:
    destination = output_directory / f"{slug}.png"
    index = 2
    while destination.exists() or destination in used_destinations:
        destination = output_directory / f"{slug}-{index}.png"
        index += 1

    used_destinations.add(destination)
    return destination


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Usage: rename-xcresult-attachments.py <exported-attachments-directory>")

    output_directory = Path(sys.argv[1])
    export_log_path = output_directory / "export.log"
    if not export_log_path.exists():
        raise SystemExit(f"Export log does not exist: {export_log_path}")

    exported_screenshots = set(output_directory.rglob("*.png"))
    used_destinations: set[Path] = set()
    renamed_count = 0
    for match in EXPORT_LOG_PATTERN.finditer(export_log_path.read_text(encoding="utf-8")):
        source = output_directory / Path(match.group("file")).name
        if not source.exists():
            raise SystemExit(f"Exported screenshot does not exist: {source}")

        slug = attachment_slug(match.group("suggested"))
        destination = unique_destination(output_directory, slug, used_destinations)
        source.replace(destination)
        verify_orientation(destination)
        renamed_count += 1

    if renamed_count != len(exported_screenshots):
        raise SystemExit(
            f"Renamed {renamed_count} of {len(exported_screenshots)} exported PNG screenshot attachment(s)."
        )

    print(f"Renamed {renamed_count} screenshot attachment(s).")


if __name__ == "__main__":
    main()
