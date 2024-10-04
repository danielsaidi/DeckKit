#!/bin/bash

# Bump the project version number.

# USAGE: bash scripts/version_bump.sh

# Use the script folder to refer to the platform script.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT="$FOLDER/version.sh"

# Get the latest version
VERSION=$($SCRIPT)

# Function to validate semver format, including optional -rc.<INT> suffix
validate_semver() {
    if [[ $1 =~ ^v?[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)?$ ]]; then
        return 0
    else
        return 1
    fi
}

if [ $? -ne 0 ]; then
    echo "Failed to get the latest version"
    exit 1
fi

echo "The current version is: $VERSION"

# Prompt user for new version
while true; do
    read -p "Enter the new version number: " NEW_VERSION

    if validate_semver "$NEW_VERSION"; then
        break
    else
        echo "Invalid version format. Please use semver format (e.g., 1.2.3, v1.2.3, 1.2.3-rc.1, etc.)."
        exit 1
    fi
done

git tag $NEW_VERSION
git push --tags
git push -u origin HEAD
