@echo off

REM Runs Docker Desktop

REM If you get the following error: Windows cannot find 'C:\Porgram'....
REM Open up Registry Editor and delete Docker Desktop under 
REM Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
REM or reinstall Docker Desktop

REM Specify the path to the Docker executable
set DOCKER_EXECUTABLE="C:\Program Files\Docker\Docker\Docker Desktop.exe"

REM Check if Docker executable exists
if not exist %DOCKER_EXECUTABLE% (
    echo Docker is not installed or the executable path is incorrect.
    exit /b 1
)

REM Check if Docker is already running
docker version >nul 2>&1
if %errorlevel% equ 0 (
    echo Docker is already running.
    exit /b 0
)

REM Start Docker Desktop
echo Starting Docker...
set DOCKER_EXECUTABLE=%DOCKER_EXECUTABLE:"=%
start "" "%DOCKER_EXECUTABLE%"

REM Wait for Docker to start (adjust timeout as needed)
timeout /t 10 /nobreak >nul

REM Check if Docker has started successfully
docker version >nul 2>&1
if %errorlevel% equ 0 (
    echo Docker has started successfully.
    exit /b 0
) else (
    echo Failed to start Docker.
    exit /b 1
)








