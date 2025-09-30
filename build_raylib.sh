#!/bin/bash

# Build raylib for this project
echo "Building raylib..."

cd deps/raylib/src

# Create build directory if it doesn't exist
mkdir -p ../../build

# Build raylib
make PLATFORM=PLATFORM_DESKTOP

# Copy the built library to our build directory
cp libraylib.a ../../build/

echo "Raylib built successfully!"