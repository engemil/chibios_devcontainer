# Docker, WSL, usbipd, and USB Devices

NB! Run VS Code as Administrator to not experience any conflicts with the scripts.

These scripts does the following:
- `windows-start-docker.bat` - Start up Docker Desktop (if installed)
- `windows-install-usbipd.bat` - Install usbipd-win
- `windows-usbipd-usb-to-wsl.bat` -Connect your desired USB device(s) to WSL and checks in WSL if USB device(s) were connected correctly
    - Note: Only handles 1 device at the time. Script needs update to handle for example two or more ST-Link's connected.
- `RUN.bat` - To run all the scripts above in sequence.


## TODOs:
- Make `windows-usbipd-usb-to-wsl.bat` handle more than 1 device at the time
- Make `windows-usbipd-usb-to-wsl.bat` and `RUN.bat` take an argument to automate choosing for example ST-Link.
- Automate `RUN.bat` to run as administrator


