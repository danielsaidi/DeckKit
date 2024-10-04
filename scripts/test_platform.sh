#!/bin/bash

# Test the SDK for a specific platform.

# Use _ instead of spaces when passing in the <PLATFORM>.

# USAGE: bash scripts/build_platform.sh <TARGET> <PLATFORM>

TARGET=$1
PLATFORM="${2//_/ }"

xcodebuild test -scheme $TARGET -derivedDataPath .build -destination "$PLATFORM" -enableCodeCoverage YES;
