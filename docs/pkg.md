
https://docs.platformio.org/en/latest/core/userguide/pkg/cmd_install.html

```bash
pio pkg install --global --platform espressif32@6.9.0
pio pkg install --global --tool toolchain-xtensa-esp32s3
```

### Explanation:
- `pio` is the PlatformIO CLI command.
- `platform install` is the subcommand used to install a platform.
- `espressif32@6.9.0` specifies the platform (`espressif32`) and the version (`6.9.0`) you want to install.

### Additional Notes:
1. **Verify Installation**:
   After installation, you can confirm the version by running:
   ```bash
   pio pkg show espressif32
   ```

2. **Specify in `platformio.ini`**:
   You can specify this version in your `platformio.ini` file:
   ```ini
   [env:esp32]
   platform = espressif32@6.9.0
   board = esp32dev
   framework = arduino
   ```

3. **Update PlatformIO**:
   Ensure PlatformIO is up-to-date to avoid compatibility issues:
   ```bash
   pio upgrade
   ```

4. **Uninstall Older Versions (Optional)**:
   If you want to remove other versions of the platform:
   ```bash
   pio pkg uninstall --global --platform espressif32@6.9.0
   pio pkg uninstall --global --tool toolchain-xtensa-esp32s3
   ``` 