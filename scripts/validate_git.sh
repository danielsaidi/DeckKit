#!/bin/bash

# Validate the Git repository for an optional <BRANCH>.

# USAGE: bash scripts/validate_git.sh <BRANCH>

# Create local argument variables.
BRANCH=$1

# Check if a branch is provided
if [ $# -eq 0 ]; then
    echo "Error: No branch specified"
    exit 1
fi

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "Error: Git repository is dirty. There are uncommitted changes."
    exit 1
fi

# If a branch name is provided, check if we're on that branch
if [ $# -eq 1 ]; then
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_branch" != "$1" ]; then
        echo "Error: Not on the specified branch. Current branch is $current_branch, expected $1."
        exit 1
    fi
    echo "Git repository is clean and on the correct branch ($1)."
elif [ $# -gt 1 ]; then
    print_usage
    exit 1
fi

# The Git repository validation succeeded.
exit 0
