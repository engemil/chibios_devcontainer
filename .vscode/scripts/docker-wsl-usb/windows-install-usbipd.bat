@echo off
setlocal

rem Define the URL of the MSI file
set "MSI_URL=https://github.com/dorssel/usbipd-win/releases/download/v4.1.0/usbipd-win_4.1.0.msi"

rem Define the filename for the downloaded MSI
set "MSI_FILE=usbipd-win_4.1.0.msi"

rem Define the installation path (optional)
set "INSTALL_PATH=C:\Program Files\usbipd-win"

rem Check if the software is already installed by looking for the executable file
if exist "%INSTALL_PATH%\usbipd.exe" (
    echo USBIPD-Win is already installed. Skipping installation...
    exit /b 0
)

rem Create a temporary directory to download the MSI
set "TEMP_DIR=%TEMP%\usbip_install"
mkdir "%TEMP_DIR%"
cd "%TEMP_DIR%"

rem Download the MSI file using PowerShell
powershell -Command "(New-Object Net.WebClient).DownloadFile('%MSI_URL%', '%MSI_FILE%')"

rem Check if download was successful
if exist "%TEMP_DIR%\%MSI_FILE%" (
    echo Download completed. Installing %MSI_FILE%...
    
    rem Install the MSI file
    msiexec /i "%TEMP_DIR%\%MSI_FILE%" /quiet INSTALLDIR="%INSTALL_PATH%"
    
    echo Installation completed.
) else (
    echo Failed to download %MSI_URL%
)

rem Clean up temporary directory
cd "%TEMP%"
rmdir /q /s "%TEMP_DIR%"

endlocal








