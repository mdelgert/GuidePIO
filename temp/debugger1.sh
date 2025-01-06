#!/bin/bash

# Debugger fix
# Link: https://community.platformio.org/t/debug-aborts-with-python-error/41139/2

# Full manual build
mkdir ~/source/esp
cd ~/source/esp
git clone -b v5.2.2 --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
./install.sh esp32s3
cd ~/.platformio/packages/toolchain-xtensa-esp32s3/bin
mv xtensa-esp32s3-elf-gdb xtensa-esp32s3-elf-gdb.orig
cp ~/.espressif/tools/xtensa-esp-elf-gdb/14.2_20240403/xtensa-esp-elf-gdb/bin/xtensa-esp32s3-elf-gdb xtensa-esp32s3-elf-gdb
cp ~/.espressif/tools/xtensa-esp-elf-gdb/14.2_20240403/xtensa-esp-elf-gdb/bin/xtensa-esp-elf-gdb-no-python .
cp ~/.espressif/tools/xtensa-esp-elf-gdb/14.2_20240403/xtensa-esp-elf-gdb/lib/xtensa_esp32s3.so ../lib/

# Delete and restore
#mv ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gdb.orig ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gdb
#rm ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gdb
#rm ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp-elf-gdb-no-python
#rm ~/.platformio/packages/toolchain-xtensa-esp32s3/lib/xtensa_esp32s3.so

# Automatic build
#mv ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gdb ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gdb.orig
#cp ../debugger/xtensa-esp32s3-elf-gdb ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/
#cp ../debugger/xtensa-esp-elf-gdb-no-python ~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp-elf-gdb-no-python
#cp ../debugger/xtensa_esp32s3.so ~/.platformio/packages/toolchain-xtensa-esp32s3/lib/