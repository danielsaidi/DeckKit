#!/bin/bash

# Build a <TARGET> for a specific platform.

# USAGE: bash scripts/build_platform.sh <TARGET> <PLATFORM>

TARGET=$1
PLATFORM=$2

xcodebuild -scheme $TARGET -derivedDataPath .build -destination generic/platform=$PLATFORM
