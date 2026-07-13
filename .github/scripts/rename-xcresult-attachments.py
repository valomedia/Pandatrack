#!/usr/bin/env python3
"""Rename exported xcresult screenshots using their attachment names."""

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


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Usage: rename-xcresult-attachments.py <exported-attachments-directory>")

    output_directory = Path(sys.argv[1])
    export_log_path = output_directory / "export.log"
    if not export_log_path.exists():
        raise SystemExit(f"Export log does not exist: {export_log_path}")

    exported_screenshots = set(output_directory.rglob("*.png"))
    renamed_count = 0
    for match in EXPORT_LOG_PATTERN.finditer(export_log_path.read_text(encoding="utf-8")):
        source = output_directory / Path(match.group("file")).name
        if not source.exists():
            raise SystemExit(f"Exported screenshot does not exist: {source}")

        destination = output_directory / f"{attachment_slug(match.group('suggested'))}.png"
        if destination.exists():
            raise SystemExit(f"Duplicate screenshot attachment name: {destination.name}")

        source.replace(destination)
        renamed_count += 1

    if renamed_count != len(exported_screenshots):
        raise SystemExit(
            f"Renamed {renamed_count} of {len(exported_screenshots)} exported PNG screenshot attachment(s)."
        )

    print(f"Renamed {renamed_count} screenshot attachment(s).")


if __name__ == "__main__":
    main()
