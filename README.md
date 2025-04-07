# Chibios Devcontainer

Development environment for ChibiOS projects in VS Code with devcontainer built on Docker.

Key feature(s):
- **"Complete"** and **Integrated** development enviroment in VS Code.
- **Portable**, **consistent**, and **isolated** development environment. Making it easy to replicate independently of the host computer.

Folders:
- `.devcontainer` - Docker and devcontainer related files.
- `.vscode` - VS Code tasks and debug (launch) related files.
- `project` - Example project for the NUCLEO64-F401RE board.


To adapt for new hardware look into these places for change:
- `project`-folder (specific for NUCLEO64-F401RE board)
- `.vscode/launch.json` (specific for openocd and gdb-multiarch, and for NUCLEO64-F401RE board)
- `.vscode/tasks.json` (specific for openocd and gdb-multiarch)
- `.devcontainer/Dockerfile` (Adds make, gcc-arm-none-eabi, openocd, and gdb-multiarch)


## Prerequisites

- **VS Code** (https://code.visualstudio.com/)
- VS Code extension **Dev Containers** (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- **Docker** (https://www.docker.com/)

Confirmed working on host computer OS: **Ubuntu 24.04** and **Windows 11** (check notes under _Additonal Notes_)

## Additional Notes


<details>
<summary> Useful notes from the VS Code extensions </summary>

**Cortex-Debug** (https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)
- Useful information about specific debuggers for specific hardware

**MemoryView** (https://marketplace.visualstudio.com/items?itemName=mcu-debug.memory-view)
- Useful information in the overview section of the extension in the marketplace.
- You can look up specific variables by giving the input the variable pointer (e.g. `&test_variable`).
    - Recommend to only use global variables, or elsething might not work when refreshing the view.

**Peripheral Viewer** (https://marketplace.visualstudio.com/items?itemName=mcu-debug.peripheral-viewer)
- You can obtain an SVD file in different ways:
    - From a CMSIS pack.
        - Go to https://www.keil.arm.com/packs/ and search for e.g. `STM32F4`
        - You will find `STM32F4xx_DFP` (device family pack)  or `NUCLEO-F410RE_BSP` (Board Support Pack)
        - You will find the `STM32F401.svd`-file in the .pack file
    - From manufacturer, e.g. STM32F401RE
        - Go to https://www.st.com/en/microcontrollers-microprocessors/stm32f401.html#cad-resources
        - Download `STM32F4 System View Description` (SVD)
        - You will find the `STM32F401.svd`-file in the .zip file
    - Move the .svd-file where you want in the project folder
    - Point to it from the `.vscode/launch.json`-file.

**RTOS Views** (https://marketplace.visualstudio.com/items?itemName=mcu-debug.rtos-views)
- Get more out of **ChibiOS** with **RTOS Views** by: 
    - Thread stack peak calculation is disabled: to enable set `CH_DBG_FILL_THREADS` to `TRUE` in `chconf.h`
    - Kernel statistics are not enabled: to enable set `CH_DBG_STATISTICS` to `TRUE` in `chconf.h`
    - Note: Make sure you consider the performance/resources impact for any changes to your FW.
    - RTOSes supported: FreeRTOS, uC/OS-II, embOS, Zephyr (beta), ChibiOS (beta)

</details>




<details>
<summary> Using Windows as the host computer OS </summary>

- Recommended to use WSL 2 (Windows Subsystem for Linux).
    - Integrate it with Docker Desktop. Go to the settings and enable **Use the WSL 2 based engine**.
    - Use `usbipd` to attach any USB device to WSL, and then easily be accessed inside a linux container.
        - List USB devices: `usbipd list`
        - Bind device to **usbipd** e.g.: `usbipd bind --busid 8-4`
            - If you get an error, try e.g.: `Usbipd bind --force --busid 8-4`
        - Attach device to WSL, e.g.: `usbipd attach --wsl --busid 9-1`
- Included scripts and a task for connecting USB device(s) to the devcontainer on a Windows Host OS, through WSL. Check `.vscode/scripts/docker-wsl-usb/`-folder and the `Task(s) for Windows Host OS`-section in `.vscode/tasks.json`.
- Are tasks (from `.vscode/tasks.json`) running slow?
    - Move this project-folder to the WSL file system, e.g. `\\wsl.localhost\Ubuntu\home\engemil\my_projects`
    - VS Code can open folders in the WSL file system and start up a devcontainer. This way, it will run fast.

</details>




<details>
<summary> Known bugs </summary>

- `Cortex-Debug` extension depends on `debug-tracker-vscode`, which doesn't load in correctly, just remember to press the `reload`-button whenever the pop-up is there

</details>

