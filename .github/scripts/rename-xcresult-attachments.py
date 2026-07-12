#!/usr/bin/env python3
"""Rename exported xcresult PNG attachments using their XCTest attachment names."""

from __future__ import annotations

import json
import re
import subprocess
import sys
from collections import deque
from pathlib import Path
from typing import Any, Iterable

UUID_PNG_PATTERN = re.compile(
    r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\.png$"
)


def xc_value(value: Any) -> str | None:
    if isinstance(value, dict):
        wrapped_value = value.get("_value")
        if wrapped_value is not None:
            return str(wrapped_value)
    if isinstance(value, str):
        return value
    return None


def run_xcresulttool_get(xcresult_path: Path, object_id: str | None = None) -> dict[str, Any] | None:
    command = ["xcrun", "xcresulttool", "get", "--format", "json", "--path", str(xcresult_path)]
    if object_id:
        command.extend(["--id", object_id])

    for candidate in (command, command[:3] + ["--legacy"] + command[3:]):
        try:
            result = subprocess.run(candidate, check=True, capture_output=True, text=True)
            return json.loads(result.stdout)
        except subprocess.CalledProcessError as error:
            last_error = error
        except json.JSONDecodeError:
            return None

    print(f"warning: could not read xcresult object {object_id or '<root>'}: {last_error}", file=sys.stderr)
    return None


def iter_child_nodes(node: Any) -> Iterable[Any]:
    if isinstance(node, dict):
        yield from node.values()
    elif isinstance(node, list):
        yield from node


def find_json_refs(node: Any, parent_key: str = "") -> Iterable[str]:
    if isinstance(node, dict):
        if parent_key.endswith("Ref") and parent_key != "payloadRef":
            ref_id = xc_value(node.get("id"))
            if ref_id:
                yield ref_id

        for key, value in node.items():
            yield from find_json_refs(value, key)
    elif isinstance(node, list):
        for value in node:
            yield from find_json_refs(value, parent_key)


def find_png_attachments(node: Any) -> Iterable[tuple[str, str]]:
    if isinstance(node, dict):
        payload_ref = node.get("payloadRef")
        filename = xc_value(node.get("filename"))
        name = xc_value(node.get("name")) or filename
        uniform_type = xc_value(node.get("uniformTypeIdentifier"))

        if isinstance(payload_ref, dict) and filename and name:
            is_png = filename.lower().endswith(".png") or uniform_type == "public.png"
            if is_png:
                yield filename, name

        for value in node.values():
            yield from find_png_attachments(value)
    elif isinstance(node, list):
        for value in node:
            yield from find_png_attachments(value)


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


def unique_path(output_directory: Path, slug: str, source: Path, used_paths: set[Path]) -> Path:
    candidate = output_directory / f"{slug}.png"
    index = 2
    while candidate in used_paths or (candidate.exists() and candidate != source):
        candidate = output_directory / f"{slug}-{index}.png"
        index += 1
    used_paths.add(candidate)
    return candidate


def discover_attachment_names(xcresult_path: Path) -> list[tuple[str, str]]:
    root = run_xcresulttool_get(xcresult_path)
    if root is None:
        raise SystemExit("Could not read xcresult root object.")

    attachments: list[tuple[str, str]] = []
    seen_attachment_filenames: set[str] = set()
    seen_refs: set[str] = set()
    refs = deque(find_json_refs(root))

    for filename, name in find_png_attachments(root):
        if filename not in seen_attachment_filenames:
            attachments.append((filename, name))
            seen_attachment_filenames.add(filename)

    while refs:
        ref_id = refs.popleft()
        if ref_id in seen_refs:
            continue
        seen_refs.add(ref_id)

        node = run_xcresulttool_get(xcresult_path, ref_id)
        if node is None:
            continue

        for filename, name in find_png_attachments(node):
            if filename not in seen_attachment_filenames:
                attachments.append((filename, name))
                seen_attachment_filenames.add(filename)

        refs.extend(ref for ref in find_json_refs(node) if ref not in seen_refs)

    return attachments


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: rename-xcresult-attachments.py <result.xcresult> <exported-attachments-directory>")

    xcresult_path = Path(sys.argv[1])
    output_directory = Path(sys.argv[2])

    if not xcresult_path.exists():
        raise SystemExit(f"Result bundle does not exist: {xcresult_path}")
    if not output_directory.exists():
        raise SystemExit(f"Attachment directory does not exist: {output_directory}")

    attachments = discover_attachment_names(xcresult_path)
    if not attachments:
        raise SystemExit("No PNG attachment metadata found in result bundle.")

    exported_files = {path.name: path for path in output_directory.rglob("*.png")}
    used_paths: set[Path] = set()
    renamed_count = 0

    for filename, name in attachments:
        source = exported_files.get(filename)
        if source is None:
            raise SystemExit(f"Exported PNG attachment missing for result filename: {filename}")

        slug = slugify(Path(name).stem)
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
