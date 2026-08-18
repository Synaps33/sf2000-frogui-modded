#!/bin/bash
set -e

# ========================================
#  FrogUI Build Script for SF2000 (Linux / WSL)
# ========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find sf2000_multicore
if [ -n "$MULTICORE_PATH" ] && [ -f "$MULTICORE_PATH/Makefile" ]; then
    MULTICORE_DIR="$MULTICORE_PATH"
elif [ -f "$SCRIPT_DIR/../sf2000_multicore/Makefile" ]; then
    MULTICORE_DIR="$(cd "$SCRIPT_DIR/../sf2000_multicore" && pwd)"
elif [ -f "$SCRIPT_DIR/sf2000_multicore/Makefile" ]; then
    MULTICORE_DIR="$(cd "$SCRIPT_DIR/sf2000_multicore" && pwd)"
elif [ -f "/mnt/d/sf2000_multicore/Makefile" ]; then
    MULTICORE_DIR="/mnt/d/sf2000_multicore"
elif [ -f "/mnt/c/sf2000_multicore/Makefile" ]; then
    MULTICORE_DIR="/mnt/c/sf2000_multicore"
else
    echo "ERROR: sf2000_multicore repository not found!"
    echo "Please clone sf2000_multicore next to this directory:"
    echo "  git clone --depth 1 https://github.com/Trademarked69/sf2000_multicore.git ../sf2000_multicore"
    echo "Or set MULTICORE_PATH environment variable."
    exit 1
fi

echo "========================================"
echo " FrogUI - SF2000 Build"
echo " Multicore: $MULTICORE_DIR"
echo "========================================"

# Make sure submodule libretro-common is initialized
if [ ! -f "$MULTICORE_DIR/libs/libretro-common/Makefile" ]; then
    echo "Initializing libretro-common submodule..."
    (cd "$MULTICORE_DIR" && git submodule update --init --recursive libs/libretro-common)
fi

# Clean and copy menu sources completely
rm -rf "$MULTICORE_DIR/cores/menu"
mkdir -p "$MULTICORE_DIR/cores/menu"
cp -r "$SCRIPT_DIR/cores/menu/"* "$MULTICORE_DIR/cores/menu/"

cd "$MULTICORE_DIR"
make clean CORE=cores/menu FROGGY_TYPE=SF2000
make CORE=cores/menu FROGGY_TYPE=SF2000 CONSOLE=menu

cp "$MULTICORE_DIR/core_87000000" "$SCRIPT_DIR/core_87000000"

echo ""
echo "========================================"
echo " BUILD SUCCESSFUL!"
echo " Output: $SCRIPT_DIR/core_87000000"
echo " Size: $(ls -lh "$SCRIPT_DIR/core_87000000" | awk '{print $5}')"
echo "========================================"
