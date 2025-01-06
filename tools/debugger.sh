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

copy_new_files() {
    echo "Copying new debugger files..."
    cp "$ESPRESSIF_TOOLS_DIR/bin/xtensa-esp32s3-elf-gdb" "$PLATFORMIO_BIN_DIR/"
    cp "$ESPRESSIF_TOOLS_DIR/bin/xtensa-esp-elf-gdb-no-python" "$PLATFORMIO_BIN_DIR/"
    cp "$ESPRESSIF_TOOLS_DIR/lib/xtensa_esp32s3.so" "$PLATFORMIO_LIB_DIR/"
    echo "New debugger files copied successfully."
}

backup_original() {
    echo "Backing up existing GDB binary..."
    if [ -f "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb" ]; then
        mv "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb" "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb.orig"
    fi
}

restore_original() {
    echo "Restoring original GDB binaries..."
    if [ -f "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb.orig" ]; then
        mv "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb.orig" "$PLATFORMIO_BIN_DIR/xtensa-esp32s3-elf-gdb"
    fi
    rm -f "$PLATFORMIO_BIN_DIR/xtensa-esp-elf-gdb-no-python"
    rm -f "$PLATFORMIO_LIB_DIR/xtensa_esp32s3.so"
    echo "Original debugger setup restored."
}

complete_build() {
    echo "Performing a complete build..."
    setup_esp_idf
    backup_original
    copy_new_files
    echo "Complete build and update completed successfully."
}

patch_toolchain() {
    echo "Patching the PlatformIO toolchain with prebuilt binaries..."
    backup_original
    copy_new_files
    echo "Toolchain patched successfully."
}

# Main Script
echo "Starting ESP32 Debugger Setup..."

# User options
echo "Select an option:"
echo "1) Complete build (build ESP-IDF and copy new files)"
echo "2) Patch existing toolchain with prebuilt files"
echo "3) Restore original toolchain files"
read -rp "Enter your choice (1/2/3): " user_choice

case $user_choice in
    1)
        complete_build
        ;;
    2)
        patch_toolchain
        ;;
    3)
        restore_original
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Completion message
echo "ESP32 Debugger Setup completed."
echo "You can now use PlatformIO with the updated toolchain."
