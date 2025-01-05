# GuidePIO
PlatformIo vscode user guide and tips after fresh install on ubuntu or debian

1. First run tools/setup.sh
2. Install PlatformIO vscode extenstions

# PlatformIO IDE extension does not work with Remote Development using SSH
https://github.com/platformio/platformio-vscode-ide/issues/942
https://github.com/luxk3/ubuntu_server_remote_dev_platformio

Update vscode file 
preferences -> settings 
-> Remote Extenstions -> platformIO 
-> Pio Home Server Http Port -> 8008

Add port forward in ssh config
Host example
	HostName example
	User user
	LocalForward 127.0.0.1:8008 127.0.0.1:8008
	IdentityFile ~/.ssh/key
	IdentitiesOnly yes

3. Close and reopen vscode

4. Initialize a new project
```bash
pio project init --board esp32-s3-devkitc-1 --project-option "platform=espressif32@6.9.0" --project-option "framework=arduino"
```

5. Verify basic sketch uploads and no issues

6. Enable debugging see tools debug.sh