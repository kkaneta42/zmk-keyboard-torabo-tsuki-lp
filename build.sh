#!/bin/bash
set -e

echo "========================================="
echo "ZMK Firmware Build Script"
echo "========================================="

# Create firmware output directory
mkdir -p firmware

# Clean any existing build directories (ignore errors if mounted)
rm -rf build/* 2>/dev/null || true

# Initialize west if not already initialized
if [ ! -d ".west" ]; then
    echo "Initializing west workspace..."
    west init -l config
    west update
    west zephyr-export
fi

# Build configurations from build.yaml
echo "Building torabo_tsuki_lp_left (central)..."
west build -p -d build/left_central -s zmk/app -b bmp_boost -- \
    -DSHIELD="torabo_tsuki_lp_left" \
    -DZMK_CONFIG="/workspace/config" \
    -DBOARD_ROOT="/workspace" \
    -DCONFIG_ZMK_SPLIT_ROLE_CENTRAL=y
cp build/left_central/zephyr/zmk.uf2 firmware/torabo_tsuki_lp_left_central.uf2

echo "Building torabo_tsuki_lp_right (peripheral)..."
west build -p -d build/right_peripheral -s zmk/app -b bmp_boost -- \
    -DSHIELD="torabo_tsuki_lp_right" \
    -DZMK_CONFIG="/workspace/config" \
    -DBOARD_ROOT="/workspace"
cp build/right_peripheral/zephyr/zmk.uf2 firmware/torabo_tsuki_lp_right_peripheral.uf2

echo "Building torabo_tsuki_lp_left (peripheral)..."
west build -p -d build/left_peripheral -s zmk/app -b bmp_boost -- \
    -DSHIELD="torabo_tsuki_lp_left" \
    -DZMK_CONFIG="/workspace/config" \
    -DBOARD_ROOT="/workspace"
cp build/left_peripheral/zephyr/zmk.uf2 firmware/torabo_tsuki_lp_left_peripheral.uf2

echo "Building torabo_tsuki_lp_right (central)..."
west build -p -d build/right_central -s zmk/app -b bmp_boost -- \
    -DSHIELD="torabo_tsuki_lp_right" \
    -DZMK_CONFIG="/workspace/config" \
    -DBOARD_ROOT="/workspace" \
    -DCONFIG_ZMK_SPLIT_ROLE_CENTRAL=y
cp build/right_central/zephyr/zmk.uf2 firmware/torabo_tsuki_lp_right_central.uf2

echo "Building settings_reset..."
west build -p -d build/settings_reset -s zmk/app -b bmp_boost -- \
    -DSHIELD="settings_reset" \
    -DZMK_CONFIG="/workspace/config" \
    -DBOARD_ROOT="/workspace"
cp build/settings_reset/zephyr/zmk.uf2 firmware/settings_reset.uf2

echo "========================================="
echo "Build completed successfully!"
echo "Firmware files are in the 'firmware' directory:"
ls -la firmware/
echo "========================================="