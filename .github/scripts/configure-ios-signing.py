#!/usr/bin/env python3
"""Apply CI-only manual signing settings to the app target."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


SETTING_FORMATS = {
    "CODE_SIGN_STYLE": "Manual",
}


def quote_build_setting(value: str) -> str:
    if re.fullmatch(r"[A-Za-z0-9_.$()/]+", value):
        return value

    return '"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"'


def build_setting_value(key: str, value: str) -> str:
    return SETTING_FORMATS.get(key, quote_build_setting(value))


def configuration_blocks(project: str) -> list[tuple[int, int]]:
    blocks: list[tuple[int, int]] = []
    search_start = 0

    while True:
        marker = project.find("isa = XCBuildConfiguration;", search_start)
        if marker == -1:
            return blocks

        block_start = project.rfind("\n", 0, marker) + 1
        block_start = project.rfind("\n", 0, block_start - 1) + 1
        opening_brace = project.find("{", block_start, marker)
        if opening_brace == -1:
            raise SystemExit("Could not find build configuration opening brace.")

        depth = 0
        block_end = None
        for index in range(opening_brace, len(project)):
            character = project[index]
            if character == "{":
                depth += 1
            elif character == "}":
                depth -= 1
                if depth == 0:
                    block_end = index + 2
                    break

        if block_end is None:
            raise SystemExit("Could not find build configuration closing brace.")

        blocks.append((block_start, block_end))
        search_start = block_end


def update_build_setting(block: str, key: str, value: str) -> str:
    formatted_value = build_setting_value(key, value)
    setting_pattern = re.compile(rf"^(\s*){re.escape(key)} = .*;$", re.MULTILINE)
    match = setting_pattern.search(block)
    if match:
        return setting_pattern.sub(
            rf"\1{key} = {formatted_value};",
            block,
            count=1,
        )

    build_settings_end = block.rfind("\n\t\t\t};")
    if build_settings_end == -1:
        raise SystemExit("Could not find buildSettings closing brace.")

    return block[:build_settings_end] + f"\n\t\t\t\t{key} = {formatted_value};" + block[build_settings_end:]


def configure_project(
    project: str,
    bundle_identifier: str,
    team_id: str,
    profile_name: str,
    signing_identity: str,
) -> tuple[str, int]:
    settings = {
        "CODE_SIGN_IDENTITY": signing_identity,
        "CODE_SIGN_STYLE": "Manual",
        "DEVELOPMENT_TEAM": team_id,
        "PROVISIONING_PROFILE_SPECIFIER": profile_name,
    }
    updated_project_parts: list[str] = []
    last_index = 0
    updated_count = 0

    for block_start, block_end in configuration_blocks(project):
        block = project[block_start:block_end]
        updated_project_parts.append(project[last_index:block_start])

        if f"PRODUCT_BUNDLE_IDENTIFIER = {bundle_identifier};" in block:
            for key, value in settings.items():
                block = update_build_setting(block, key, value)
            updated_count += 1

        updated_project_parts.append(block)
        last_index = block_end
    updated_project_parts.append(project[last_index:])

    return "".join(updated_project_parts), updated_count


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project_file", type=Path)
    parser.add_argument("--bundle-identifier", required=True)
    parser.add_argument("--team-id", required=True)
    parser.add_argument("--profile-name", required=True)
    parser.add_argument("--signing-identity", required=True)
    args = parser.parse_args()

    project = args.project_file.read_text(encoding="utf-8")
    updated_project, updated_count = configure_project(
        project,
        bundle_identifier=args.bundle_identifier,
        team_id=args.team_id,
        profile_name=args.profile_name,
        signing_identity=args.signing_identity,
    )

    if updated_count == 0:
        raise SystemExit(
            f"No build configurations found for bundle identifier {args.bundle_identifier}."
        )

    args.project_file.write_text(updated_project, encoding="utf-8")
    print(
        "Configured manual signing for "
        f"{updated_count} app build configuration(s) using {args.profile_name}."
    )


if __name__ == "__main__":
    main()
