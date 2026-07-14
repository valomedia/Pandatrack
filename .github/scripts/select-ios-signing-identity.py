#!/usr/bin/env python3
"""Select an imported code-signing identity included in a provisioning profile."""

from __future__ import annotations

import os
import plistlib
import re
import subprocess
import sys
import tempfile
from pathlib import Path


IDENTITY_PATTERN = re.compile(r'\)\s+([0-9A-Fa-f]{40})\s+"(.+)"')


def certificate_sha1(certificate: bytes) -> str:
    with tempfile.NamedTemporaryFile(suffix=".cer", delete=False) as certificate_file:
        certificate_file.write(certificate)
        certificate_path = Path(certificate_file.name)

    try:
        result = subprocess.run(
            [
                "openssl",
                "x509",
                "-inform",
                "DER",
                "-in",
                str(certificate_path),
                "-noout",
                "-fingerprint",
                "-sha1",
            ],
            check=True,
            capture_output=True,
            text=True,
        )
    finally:
        certificate_path.unlink(missing_ok=True)

    return result.stdout.split("=", 1)[1].replace(":", "").strip().upper()


def profile_certificate_hashes(profile_plist: Path) -> set[str]:
    with profile_plist.open("rb") as profile_file:
        profile = plistlib.load(profile_file)

    return {
        certificate_sha1(certificate)
        for certificate in profile.get("DeveloperCertificates", [])
    }


def imported_identities(identities_path: Path) -> list[tuple[str, str]]:
    identities: list[tuple[str, str]] = []
    for line in identities_path.read_text(encoding="utf-8").splitlines():
        match = IDENTITY_PATTERN.search(line)
        if match:
            identities.append((match.group(1).upper(), match.group(2)))
    return identities


def write_github_env(key: str, value: str) -> None:
    github_env = os.environ.get("GITHUB_ENV")
    if github_env:
        with Path(github_env).open("a", encoding="utf-8") as env_file:
            env_file.write(f"{key}={value}\n")


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: select-ios-signing-identity.py PROFILE_PLIST IDENTITIES_FILE")

    profile_hashes = profile_certificate_hashes(Path(sys.argv[1]))
    identities = imported_identities(Path(sys.argv[2]))
    matching_identities = [identity for identity in identities if identity[0] in profile_hashes]

    if not matching_identities:
        print(
            "::error::The ad-hoc provisioning profile does not include any "
            "imported code-signing identity."
        )
        print(
            "::error::Update IOS_ADHOC_PROVISIONING_PROFILE_BASE64 so it includes "
            "the certificate from IOS_DISTRIBUTION_CERTIFICATE_BASE64, or import "
            "the distribution certificate that is already included in the profile."
        )
        raise SystemExit(1)

    selected_sha1, selected_name = next(
        (
            identity
            for identity in matching_identities
            if "Distribution" in identity[1]
        ),
        matching_identities[0],
    )
    write_github_env("PANDATRACK_CODE_SIGN_IDENTITY", selected_name)
    write_github_env("PANDATRACK_CODE_SIGN_IDENTITY_SHA1", selected_sha1)
    print(f"Selected signing identity {selected_name}.")


if __name__ == "__main__":
    main()
