#!/usr/bin/env python3
"""Rename exported xcresult PNG attachments using xcresulttool's suggested names."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any, Iterable

UUID_PNG_PATTERN = re.compile(
    r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\.png$"
)
SUGGESTED_SUFFIX_PATTERN = re.compile(
    r"_[0-9]+_[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
)
EXPORT_LOG_PATTERN = re.compile(r"File:\s*(?P<file>[^,\s]+\.png),\s*suggested name:\s*\"(?P<suggested>[^\"]+\.png)\"")


def iter_dicts(node: Any) -> Iterable[dict[str, Any]]:
    if isinstance(node, dict):
        yield node
        for value in node.values():
            yield from iter_dicts(value)
    elif isinstance(node, list):
        for value in node:
            yield from iter_dicts(value)


def iter_strings(node: Any) -> Iterable[str]:
    if isinstance(node, str):
        yield node
    elif isinstance(node, dict):
        for value in node.values():
            yield from iter_strings(value)
    elif isinstance(node, list):
        for value in node:
            yield from iter_strings(value)


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


def unique_path(output_directory: Path, slug: str, source: Path, used_paths: set[Path]) -> Path:
    candidate = output_directory / f"{slug}.png"
    index = 2
    while candidate in used_paths or (candidate.exists() and candidate != source):
        candidate = output_directory / f"{slug}-{index}.png"
        index += 1
    used_paths.add(candidate)
    return candidate


def discover_mappings_from_manifest(output_directory: Path, exported_names: set[str]) -> dict[str, str]:
    manifest_path = output_directory / "manifest.json"
    if not manifest_path.exists():
        return {}

    with manifest_path.open(encoding="utf-8") as manifest_file:
        manifest = json.load(manifest_file)

    mappings: dict[str, str] = {}
    for item in iter_dicts(manifest):
        strings = [Path(value).name for value in iter_strings(item) if value.lower().endswith(".png")]
        source_names = sorted({value for value in strings if value in exported_names})
        suggested_names = sorted(
            value
            for value in strings
            if value not in exported_names and not UUID_PNG_PATTERN.match(value)
        )
        if len(source_names) == 1 and suggested_names:
            mappings[source_names[0]] = suggested_names[0]

    return mappings


def discover_mappings_from_export_log(output_directory: Path, exported_names: set[str]) -> dict[str, str]:
    export_log_path = output_directory / "export.log"
    if not export_log_path.exists():
        return {}

    mappings: dict[str, str] = {}
    for match in EXPORT_LOG_PATTERN.finditer(export_log_path.read_text(encoding="utf-8")):
        source_name = Path(match.group("file")).name
        suggested_name = Path(match.group("suggested")).name
        if source_name in exported_names:
            mappings[source_name] = suggested_name

    return mappings


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: rename-xcresult-attachments.py <result.xcresult> <exported-attachments-directory>")

    output_directory = Path(sys.argv[2])
    if not output_directory.exists():
        raise SystemExit(f"Attachment directory does not exist: {output_directory}")

    exported_files = {path.name: path for path in output_directory.rglob("*.png")}
    if not exported_files:
        raise SystemExit("No exported PNG screenshots found.")

    mappings = discover_mappings_from_manifest(output_directory, set(exported_files))
    if not mappings:
        mappings = discover_mappings_from_export_log(output_directory, set(exported_files))
    if not mappings:
        raise SystemExit("Could not find suggested screenshot names in xcresulttool export metadata.")

    missing_names = sorted(set(exported_files) - set(mappings))
    if missing_names:
        raise SystemExit(f"No suggested names found for exported screenshots: {', '.join(missing_names)}")

    used_paths: set[Path] = set()
    renamed_count = 0
    for source_name, suggested_name in sorted(mappings.items()):
        source = exported_files[source_name]
        slug = slug_from_suggested_name(suggested_name)
        destination = unique_path(output_directory, slug, source, used_paths)
        if source != destination:
            source.replace(destination)
        renamed_count += 1

    uuid_filenames = sorted(path.name for path in output_directory.rglob("*.png") if UUID_PNG_PATTERN.match(path.name))
    if uuid_filenames:
        raise SystemExit(f"Exported screenshots still have UUID filenames: {', '.join(uuid_filenames)}")

    print(f"Renamed {renamed_count} screenshot attachment(s) with readable filenames.")


if __name__ == "__main__":
    main()
