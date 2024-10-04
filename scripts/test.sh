#!/bin/bash

# Test a <TARGET> for all supported platforms.

# USAGE: bash scripts/test.sh <TARGET>

# Exit immediately if a command exits with a non-zero status
set -e

# Create local argument variables.
TARGET=$1

# Check if target is provided
if [ $# -eq 0 ]; then
    echo "Error: No target specified"
    exit 1
fi

# Use the script folder to refer to the platform script.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT="$FOLDER/test_platform.sh"

# Make the script executable
chmod +x $SCRIPT

# A function that builds a specific platform
test_platform() {
    local platform=$1
    echo "Building for $platform..."
    if ! bash $SCRIPT $TARGET $platform; then
        echo "Failed to build $platform"
        return 1
    fi
    echo "Successfully built $platform"
}

# Array of platforms to build
platforms=("platform=iOS_Simulator,name=iPhone_16")

# Loop through platforms and build
for platform in "${platforms[@]}"; do
    if ! test_platform "$platform"; then
        exit 1
    fi
done

echo "All platforms tested successfully!"
