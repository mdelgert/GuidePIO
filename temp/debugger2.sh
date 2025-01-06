#!/bin/bash

set -e  # Exit on any error
set -o pipefail  # Catch pipeline errors

# Variables
TOOLCHAIN_NAME="toolchain-xtensa-esp32s3"
PLATFORMIO_BIN_DIR="$HOME/.platformio/packages/$TOOLCHAIN_NAME/bin"
PLATFORMIO_LIB_DIR="$HOME/.platformio/packages/$TOOLCHAIN_NAME/lib"
DEBUGGER_DIR="../debugger"
TOOLCHAIN_DIR="$HOME/.platformio/packages/$TOOLCHAIN_NAME"


# Functions
check_and_install_toolchain() {
    echo "Checking if PlatformIO toolchain '$TOOLCHAIN_NAME' is installed..."
    if [ ! -d "$TOOLCHAIN_DIR" ]; then
        echo "Toolchain '$TOOLCHAIN_NAME' not found."
        read -rp "Would you like to install the toolchain using PlatformIO? (y/n): " install_choice
        if [[ $install_choice == "y" || $install_choice == "Y" ]]; then
            echo "Installing toolchain '$TOOLCHAIN_NAME'..."
            pio pkg install --global --tool "$TOOLCHAIN_NAME"
            echo "Toolchain '$TOOLCHAIN_NAME' installed successfully."
        else
            echo "Skipping installation of toolchain '$TOOLCHAIN_NAME'. Some features may not work."
            exit 1
        fi
    else
        echo "Toolchain '$TOOLCHAIN_NAME' is already installed at $TOOLCHAIN_DIR."
    fi
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
}

copy_debugger_files() {
    echo "Copying precompiled debugger files from $DEBUGGER_DIR..."
    cp "$DEBUGGER_DIR/xtensa-esp32s3-elf-gdb" "$PLATFORMIO_BIN_DIR/"
    cp "$DEBUGGER_DIR/xtensa-esp-elf-gdb-no-python" "$PLATFORMIO_BIN_DIR/"
    cp "$DEBUGGER_DIR/xtensa_esp32s3.so" "$PLATFORMIO_LIB_DIR/"
}

# Main Script
echo "Starting ESP32 Debugger Fix Setup..."

# Check and install PlatformIO toolchain dependency
check_and_install_toolchain

# Prompt user for action
echo "Select an option:"
echo "1) Use precompiled debugger files from $DEBUGGER_DIR"
echo "2) Restore original debugger setup"
read -rp "Enter your choice (1/2): " user_choice

case $user_choice in
    1)
        backup_original
        copy_debugger_files
        echo "Precompiled debugger files copied successfully."
        ;;
    2)
        restore_original
        echo "Original debugger setup restored."
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Completion message
echo "ESP32 Debugger Setup completed."
echo "You can now run 'pio debug' to test the debugger functionality."
