#!/bin/bash

set -e  # Exit on any error
set -o pipefail  # Catch pipeline errors

# Variables
SOURCE_DIR="$HOME/source/esp"
ESP_IDF_REPO="https://github.com/espressif/esp-idf.git"
ESP_IDF_BRANCH="v5.2.2"
ESP_IDF_DIR="$SOURCE_DIR/esp-idf"
ESPRESSIF_TOOLS_DIR="$HOME/.espressif/tools/xtensa-esp-elf-gdb/14.2_20240403"
PLATFORMIO_BIN_DIR="$HOME/.platformio/packages/toolchain-xtensa-esp32s3/bin"
PLATFORMIO_LIB_DIR="$HOME/.platformio/packages/toolchain-xtensa-esp32s3/lib"

# Functions
setup_esp_idf() {
    echo "Setting up ESP-IDF v5.2.2..."
    if [ ! -d "$ESP_IDF_DIR" ]; then
        mkdir -p "$SOURCE_DIR"
        git clone -b "$ESP_IDF_BRANCH" --recursive "$ESP_IDF_REPO" "$ESP_IDF_DIR"
    else
        echo "ESP-IDF repository already cloned at $ESP_IDF_DIR."
    fi

    # Run ESP-IDF installer
    echo "Installing ESP-IDF tools for ESP32-S3..."
    cd "$ESP_IDF_DIR"
    ./install.sh esp32s3
}

update_platformio_toolchain() {
    echo "Updating PlatformIO toolchain for ESP32-S3..."

    # Backup original GDB binary
    if [ -f "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb" ]; then
        echo "Backing up original GDB binary..."
        mv "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb" "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb.orig"
    fi

    # Copy new binaries and libraries
    echo "Copying new binaries and libraries..."
    cp "$ESPRESSIF_TOOLS_DIR/bin/xtensa-esp32s3-elf-gdb" "$PLATFORMIO_BIN_DIR/"
    cp "$ESPRESSIF_TOOLS_DIR/bin/xtensa-esp-elf-gdb-no-python" "$PLATFORMIO_BIN_DIR/"
    cp "$ESPRESSIF_TOOLS_DIR/lib/xtensa_esp32s3.so" "$PLATFORMIO_LIB_DIR/"

    echo "PlatformIO toolchain updated successfully."
}

# Main Script
echo "Starting ESP-IDF Toolchain Setup..."

# Step 1: Setup ESP-IDF
setup_esp_idf

# Step 2: Update PlatformIO toolchain
update_platformio_toolchain

# Completion message
echo "ESP-IDF Toolchain Setup completed successfully."
echo "You can now use PlatformIO with the updated ESP32-S3 debugger."
