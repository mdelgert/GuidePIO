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
7. Remote homepage fix.

Test if it works in vscode
```bash
pio home --no-open
pio home #To launch in browser
```

 Add port forwarding in config

 Host somehost
	User someuser
	IdentityFile ~/.ssh/somekey
	IdentitiesOnly yes
	LocalForward 127.0.0.1:8008 127.0.0.1:8008 
	LocalForward 127.0.0.1:8009 127.0.0.1:8009 #If have more than one server on proxmox add more entries
    LocalForward 127.0.0.1:8010 127.0.0.1:8010

8. Its possible a session is still open use kill.sh and change the port

```bash
kill.sh
```