#!/bin/bash

set -e

echo "=== Building Odin + Raylib Project ==="

# Create build directory
mkdir -p build

echo "1. Building raylib..."
cd deps/raylib/src

# Build raylib
make PLATFORM=PLATFORM_DESKTOP

# Copy library to project build directory
cp libraylib.a ../../../build/

cd ../../..

echo "2. Building Odin program..."

# Build Odin program with raylib linking
odin build src \
    -out:build/game \
    -extra-linker-flags:"-L./build -lraylib -lm -lpthread -ldl -lX11 -lGL"

echo "=== Build complete! ==="
echo "Run: ./build/game"