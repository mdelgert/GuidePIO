# GuidePIO
PlatformIo vscode user guide and tips after fresh install on ubuntu or debian

1. First run tools/setup.sh
2. Install PlatformIO vscode extenstions
3. Initialize a new project
```bash
pio project init --board esp32-s3-devkitc-1 --project-option "platform=espressif32@6.9.0" --project-option "framework=arduino"
```
5. Verify basic sketch uploads and no issues
6. Enable debugging see tools debug.sh will get the following error during debugging.

