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

set +euo pipefail

# shellcheck disable=SC2164
cd "${SRCROOT}/Chronos"

exec swiftgen
