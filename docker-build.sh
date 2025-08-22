#!/bin/bash
set -e

echo "========================================="
echo "Starting Docker Build Environment"
echo "========================================="

# Build Docker image if needed
echo "Building Docker image..."
docker-compose build

# Run the build script inside the container
echo "Running ZMK firmware build..."
docker-compose run --rm zmk-build ./build.sh

echo "========================================="
echo "Build process completed!"
echo "Check the 'firmware' directory for output files."
echo "========================================="