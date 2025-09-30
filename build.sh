#!/bin/bash

set -e

# Default to debug mode
BUILD_MODE="${1:-debug}"

case $BUILD_MODE in
    debug)
        echo "=== Building Odin + Raylib Project (Debug) ==="
        BUILD_DIR="build/debug"
        ODIN_FLAGS="-debug -vet"
        ;;
    release)
        echo "=== Building Odin + Raylib Project (Release) ==="
        BUILD_DIR="build/release"
        ODIN_FLAGS="-o:speed"
        ;;
    profile)
        echo "=== Building Odin + Raylib Project (Release) ==="
        BUILD_DIR="build/release"
        ODIN_FLAGS="-profile"
        ;;        
    *)
        echo "Usage: $0 [debug|release]"
        echo "  debug   - Build with debug symbols (default)"
        echo "  release - Build with optimizations"
        echo "  profile - Build for profiling"
        exit 1
        ;;
esac

# Create build directory
mkdir -p "$BUILD_DIR"

echo "1. Building raylib..."
cd deps/raylib/src

# Build raylib
make PLATFORM=PLATFORM_DESKTOP

# Copy library to project build directory
cp libraylib.a "../../../$BUILD_DIR/"

cd ../../..

echo "2. Building Odin program ($BUILD_MODE) in ($BUILD_DIR)..."

# Build Odin program with appropriate flags
odin build src \
    -out:"$BUILD_DIR/game" \
    $ODIN_FLAGS \
    -extra-linker-flags:"-L./$BUILD_DIR -lraylib -lm -lpthread -ldl -lX11 -lGL"

echo "=== $BUILD_MODE build complete! ==="
echo "Run: ./$BUILD_DIR/game"