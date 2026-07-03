#!/usr/bin/env bash

#
# swiftgen.sh
# Chronos
#
# Created by Jean-Pierre Höhmann on 2022-04-20.
#
#

#
# Code Generation
#
# This script generates code from the Core Data model, XCode assets and
# resources.
#

set -euo pipefail

if [[ -z "${SRCROOT:-}" ]]; then
  SRCROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

PODS_ROOT="${PODS_ROOT:-${SRCROOT}/Pods}"
SWIFTGEN="${PODS_ROOT}/SwiftGen/bin/swiftgen"

if [[ ! -x "${SWIFTGEN}" ]]; then
  echo "error: SwiftGen is not installed. Run 'pod install --repo-update' to install it." >&2
  exit 1
fi

cd "${SRCROOT}/Chronos"

exec "${SWIFTGEN}"
