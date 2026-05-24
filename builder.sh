#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <github_username/repository> <dockerhub_username/repository>"
    echo "Example: $0 mluukkai/express_app wassimmezghanni/testing"
    exit 1
fi

GITHUB_REPO=$1
DOCKER_REPO=$2
TEMP_DIR="temp_cloned_repo"

# Login to Docker Hub if credentials are provided
if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
    echo "Logging in to Docker Hub..."
    echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
fi

# 1. Clone the GitHub repository
echo "Cloning https://github.com/${GITHUB_REPO}..."
git clone "https://github.com/${GITHUB_REPO}.git" "$TEMP_DIR"

# 2. Check if Dockerfile exists in the root of the repository
if [ ! -f "$TEMP_DIR/Dockerfile" ]; then
    echo "Error: Dockerfile not found in the root of the repository!"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# 3. Build the Docker image
echo "Building Docker image ${DOCKER_REPO}..."
docker build -t "${DOCKER_REPO}" "$TEMP_DIR"

# 4. Push the Docker image to Docker Hub
echo "Pushing Docker image ${DOCKER_REPO} to Docker Hub..."
docker push "${DOCKER_REPO}"

# 5. Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Success! Image built and pushed successfully."
