#!/usr/bin/env python3
"""Create an available iOS simulator for GitHub Actions."""

from __future__ import annotations

import json
import os
import subprocess
import sys
from pathlib import Path
from typing import Any


def run_json(kind: str) -> dict[str, Any]:
    result = subprocess.run(
        ["xcrun", "simctl", "list", "--json", kind],
        check=True,
        capture_output=True,
        text=True,
    )
    return json.loads(result.stdout)


def version_key(runtime: dict[str, Any]) -> tuple[int, ...]:
    version = str(runtime.get("version", "0"))
    return tuple(int(part) for part in version.split(".") if part.isdigit())


def available_ios_runtimes() -> list[dict[str, Any]]:
    runtimes = run_json("runtimes").get("runtimes", [])
    return sorted(
        (
            runtime
            for runtime in runtimes
            if runtime.get("isAvailable", True)
            and (
                str(runtime.get("identifier", "")).startswith("com.apple.CoreSimulator.SimRuntime.iOS")
                or str(runtime.get("name", "")).startswith("iOS")
            )
        ),
        key=version_key,
    )


def supported_device_type_ids(runtime: dict[str, Any]) -> set[str]:
    supported = runtime.get("supportedDeviceTypes") or []
    return {
        device_type.get("identifier")
        for device_type in supported
        if isinstance(device_type, dict) and device_type.get("identifier")
    }


def choose_device_type(runtime: dict[str, Any]) -> dict[str, Any]:
    preferred_names = [
        "iPhone 16",
        "iPhone 16 Pro",
        "iPhone 15",
        "iPhone 15 Pro",
    ]
    supported_ids = supported_device_type_ids(runtime)
    device_types = [
        device_type
        for device_type in run_json("devicetypes").get("devicetypes", [])
        if "iPhone" in str(device_type.get("name", ""))
        and device_type.get("identifier")
        and (not supported_ids or device_type.get("identifier") in supported_ids)
    ]

    for preferred_name in preferred_names:
        for device_type in device_types:
            if device_type.get("name") == preferred_name:
                return device_type

    if device_types:
        return device_types[-1]

    raise SystemExit("No available iPhone simulator device types were found.")


def write_github_env(key: str, value: str) -> None:
    github_env = os.environ.get("GITHUB_ENV")
    if github_env:
        with Path(github_env).open("a", encoding="utf-8") as env_file:
            env_file.write(f"{key}={value}\n")


def main() -> None:
    simulator_name = sys.argv[1] if len(sys.argv) > 1 else "Pandatrack CI iPhone"
    runtimes = available_ios_runtimes()
    if not runtimes:
        raise SystemExit("No available iOS simulator runtimes were found.")

    runtime = runtimes[-1]
    device_type = choose_device_type(runtime)
    result = subprocess.run(
        [
            "xcrun",
            "simctl",
            "create",
            simulator_name,
            device_type["identifier"],
            runtime["identifier"],
        ],
        check=True,
        capture_output=True,
        text=True,
    )
    simulator_udid = result.stdout.strip()
    write_github_env("PANDATRACK_SIMULATOR_UDID", simulator_udid)
    print(
        f"Created {simulator_name} ({simulator_udid}) "
        f"using {device_type['name']} on {runtime['name']}."
    )


if __name__ == "__main__":
    main()
