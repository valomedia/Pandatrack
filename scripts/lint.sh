#!/usr/bin/env bash

#
# lint.sh
# Pandatrack
#
# Run the repository's Xcode static-analysis gate.
#

set -euo pipefail

SRCROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -n "${PANDATRACK_SIMULATOR_UDID:-}" ]]; then
  DESTINATION="platform=iOS Simulator,id=${PANDATRACK_SIMULATOR_UDID}"
else
  DESTINATION="${PANDATRACK_LINT_DESTINATION:-generic/platform=iOS Simulator}"
fi

cd "${SRCROOT}"

xcodebuild analyze \
  -workspace Chronos.xcworkspace \
  -scheme Pandatrack \
  -destination "${DESTINATION}" \
  CODE_SIGNING_ALLOWED=NO
