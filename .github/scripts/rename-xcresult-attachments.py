#!/usr/bin/env python3
"""Rename exported xcresult PNG screenshots using xcresulttool's suggested names."""

from __future__ import annotations

import hashlib
import re
import sys
from pathlib import Path

UUID_PNG_PATTERN = re.compile(
    r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\.png$"
)
SUGGESTED_SUFFIX_PATTERN = re.compile(
    r"_[0-9]+_[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
)
EXPORT_LOG_PATTERN = re.compile(r"File:\s*(?P<file>[^,\s]+\.png),\s*suggested name:\s*\"(?P<suggested>[^\"]+\.png)\"")


def slugify(value: str) -> str:
    slug_parts: list[str] = []
    last_character_was_dash = False

    for character in value.lower():
        if character.isalnum():
            slug_parts.append(character)
            last_character_was_dash = False
        elif not last_character_was_dash:
            slug_parts.append("-")
            last_character_was_dash = True

    return "".join(slug_parts).strip("-") or "screenshot"


def slug_from_suggested_name(suggested_name: str) -> str:
    stem = Path(suggested_name).stem
    stem = SUGGESTED_SUFFIX_PATTERN.sub("", stem)
    return slugify(stem)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def unique_path(path: Path) -> Path:
    if not path.exists():
        return path

    index = 2
    while True:
        candidate = path.with_name(f"{path.stem}-{index}{path.suffix}")
        if not candidate.exists():
            return candidate
        index += 1


def rename_exported_screenshot(source: Path, destination: Path) -> str:
    if destination.exists():
        if sha256(source) == sha256(destination):
            source.unlink()
            return "skipped duplicate"
        destination = unique_path(destination)

    source.replace(destination)
    return "renamed"


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Usage: rename-xcresult-attachments.py <exported-attachments-directory>")

    output_directory = Path(sys.argv[1])
    export_log_path = output_directory / "export.log"
    if not export_log_path.exists():
        raise SystemExit(f"Export log does not exist: {export_log_path}")

    renamed_count = 0
    duplicate_count = 0
    for match in EXPORT_LOG_PATTERN.finditer(export_log_path.read_text(encoding="utf-8")):
        source = output_directory / Path(match.group("file")).name
        if not source.exists():
            raise SystemExit(f"Exported screenshot does not exist: {source}")

        slug = slug_from_suggested_name(match.group("suggested"))
        result = rename_exported_screenshot(source, output_directory / f"{slug}.png")
        if result == "renamed":
            renamed_count += 1
        else:
            duplicate_count += 1

    if renamed_count == 0:
        raise SystemExit("No exported PNG screenshots were renamed.")

    uuid_filenames = sorted(path.name for path in output_directory.rglob("*.png") if UUID_PNG_PATTERN.match(path.name))
    if uuid_filenames:
        raise SystemExit(f"Exported screenshots still have UUID filenames: {', '.join(uuid_filenames)}")

    message = f"Renamed {renamed_count} screenshot attachment(s) with readable filenames."
    if duplicate_count:
        message += f" Skipped {duplicate_count} duplicate screenshot attachment(s)."
    print(message)


if __name__ == "__main__":
    main()
