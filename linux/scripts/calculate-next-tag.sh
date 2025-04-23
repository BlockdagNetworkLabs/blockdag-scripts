#!/bin/bash
set -e

# Define your DockerHub repo (change if needed)
REPO="mattblockdag/blockdag-dev-node"

echo "Checking latest tags from DockerHub for repo: $REPO"

# Query DockerHub tags (public API)
TAGS=$(curl -s "https://hub.docker.com/v2/repositories/${REPO}/tags?page_size=100" | jq -r '.results[].name')

# Check if tags are empty
if [ -z "$TAGS" ]; then
    NEW_TAG="v0.1.0"
    echo "No tags found. Setting initial tag: $NEW_TAG"
else
    # Get highest semver-style tag
    LATEST_TAG=$(echo "$TAGS" | grep -E "^v[0-9]+\.[0-9]+\.[0-9]+$$" | sort -V | tail -n1)

    if [ -z "$LATEST_TAG" ]; then
        NEW_TAG="v0.1.0"
        echo "No valid semver tags found. Setting initial tag: $NEW_TAG"
    else
        # Bump PATCH version
        MAJOR=$(echo "$LATEST_TAG" | cut -d. -f1 | sed 's/v//')
        MINOR=$(echo "$LATEST_TAG" | cut -d. -f2)
        PATCH=$(echo "$LATEST_TAG" | cut -d. -f3)
        PATCH=$((PATCH+1))
        NEW_TAG="v${MAJOR}.${MINOR}.${PATCH}"
        echo "Latest found tag: $LATEST_TAG. Next tag: $NEW_TAG"
    fi
fi

# Write out to env file
echo "NEW_TAG=$NEW_TAG" > generated-tag.env
