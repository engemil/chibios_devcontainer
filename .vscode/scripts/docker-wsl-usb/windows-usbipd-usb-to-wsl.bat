@echo off
setlocal enabledelayedexpansion

echo Printing list of USB devices...
echo.
usbipd list


@echo off
setlocal

echo Select an option:
echo 1. ST-Link ^(Will look for DEVICE name with ^"ST-Link^" in it^)
echo 2. Arduino ^(Will look for DEVICE name with ^"Arduino^" in it^)

set /p choice=Enter your choice (1-2): 

rem Validate user input
if "%choice%"=="1" (
    set selected_option=ST-Link
) else if "%choice%"=="2" (
    set selected_option=Arduino
) else (
    echo Invalid choice. Please select a number in the option range.
    exit /b 1
)

echo You selected: %selected_option%
echo.

REM List USB devices and filter by name
for /f "tokens=1-3" %%A in ('usbipd list') do (
    REM echo BUSID: %%A
    REM echo VID:PID: %%B
    REM echo DEVICE NAME: %%C

    REM Check if DEVICE NAME is the selected option and bind and attach the device to WSL
    if "%%C"=="%selected_option%" (
        echo Found device with BUSID: %%A

        REM Bind the USB to USBIP clients
        echo If your USB Device is already shared, ignore the message. It should be OK.
        usbipd bind --busid %%A

        REM Use PowerShell to check if WSL is running
        REM powershell -Command "if ((Get-Service LxssManager).Status -eq 'Running') { exit 0 } else { exit 1 }" REM Test
        powershell -Command "Get-Service 'LxssManager' -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq 'Running'}"
        

        REM Check the exit code to determine if WSL is running
        if %errorlevel% equ 0 (
            echo WSL is running, attaching USB device %%A to WSL.
            REM Attach the USB to WSL running in the background
            usbipd attach --wsl --busid %%A

        ) else (
            echo WSL is not running. Please setup WSL ^(with Ubuntu^) before running this script
            exit /b 1 REM Exit the batch sript with error code 1
        )
    )
)

REM Add a small delay before we check the USB device inside WSL
timeout /t 1 /nobreak > nul

echo List of USB devices inside WSL^:
echo.
wsl lsusb
echo If you do NOT see your device^(s^), you have to rerun the script or reconfigure your setup^!




REM Comment out section 1
goto commented_out_section_1

REM Add a small delay before we check the USB device inside WSL
timeout /t 2 /nobreak > nul

echo Checking USB devices connected inside WSL...

REM set "device_type=ST-Link"

echo.
echo Found the following %selected_option% device^(s^):

rem Initialize check variable
set check=0

rem Run the command and capture the output
for /f "tokens=*" %%A in ('wsl lsusb') do (
    set "line=%%A"
    rem Check if the line contains "ST-Link"
    echo !line! | findstr /i /c:"%selected_option%" > nul
    if !errorlevel! equ 0 (
        echo !line!
        set check=1
    )
)

rem Check the value of the check variable
if %check% == 0 (
    echo Did NOT find any USB device with the name %selected_option%!
)

:commented_out_section_1

endlocal



