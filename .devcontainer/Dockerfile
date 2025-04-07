FROM ubuntu:latest

# Install any additional tools you might want
RUN apt-get update && apt-get upgrade -y

# usbutils - To check for the USB connection (Run: lsusb). https://packages.ubuntu.com/noble/usbutils
RUN apt-get install usbutils -y 

# git - For getting repositories. https://packages.ubuntu.com/noble/git
RUN apt-get install git -y

# make - Compile C files. https://packages.ubuntu.com/noble/make
RUN apt-get install make -y 
# build-essential - Includes dpkg-dev, g++, gcc, libc6-dev, make. https://packages.ubuntu.com/noble/build-essential
#RUN apt-get install build-essential -y

# gcc-arm-none-eabi - Arm GNU Toolchain. Includes libnewlib aswell. https://packages.ubuntu.com/noble/gcc-arm-none-eabi
# TODO: See if I should use the gcc-arm-none-eabi that ChibiStudio includes under tools (2 versions: GCC 10.3.1 2021q4, GCC 11.3.1 2022q3)
# The newest one as of 19.12.2025 is now GCC 13.2.rel1
RUN apt-get install gcc-arm-none-eabi -y
# openocd - Open On-chip Debugger. https://packages.ubuntu.com/noble/openocd
RUN apt-get install openocd -y

# gdb - GNU project Debugger. https://packages.ubuntu.com/noble/gdb
#RUN apt-get install gdb -y
# gdb - GNU project Debugger. https://packages.ubuntu.com/noble/gdb
RUN apt-get install gdb-multiarch -y

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Make workspace directory
RUN mkdir /workspace



# NB! Test first to see if it works. Might be conflicting with how the folder is created with devcontainer.json.
# Making changes in that folder useless from the Dockerfile.

# Get ChibiOS Repository from Github
#RUN git clone https://github.com/ChibiOS/ChibiOS /workspace/ChibiOS


WORKDIR /workspace
