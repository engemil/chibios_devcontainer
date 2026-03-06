FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install any additional tools you might want
RUN apt-get update

# Install 
RUN apt-get install git -y
RUN apt-get install build-essential -y
#RUN apt-get install make -y 
RUN apt-get install gcc-arm-none-eabi -y
#RUN apt-get install binutils-arm-none-eabi -y
#RUN apt-get install gdb -y
RUN apt-get install gdb-multiarch -y
#RUN apt-get install stlink-tools -y
#RUN apt-get install openocd -y
RUN apt-get install minicom -y
RUN apt-get install usbutils -y 
#RUN apt-get install dfu-util -y
RUN apt-get install sudo -y

# Additional dependencies for stlink and openocd from source
RUN apt-get install cmake -y
RUN apt-get install python3 -y
RUN apt-get install autoconf -y
RUN apt-get install automake -y
RUN apt-get install libtool -y
RUN apt-get install pkg-config -y
RUN apt-get install libusb-1.0-0-dev -y
RUN apt-get install libhidapi-dev -y
RUN apt-get install libftdi-dev -y
RUN apt-get install libftdi1 -y
RUN apt-get install libjim-dev -y


# stlink (open-source version) from source
#RUN sudo apt-get remove stlink-tools -y
#RUN sudo apt-get autoremove -y
run mkdir -p /tmp
WORKDIR /tmp
RUN git clone https://github.com/stlink-org/stlink.git
WORKDIR /tmp/stlink
RUN git checkout develop
RUN cmake .
RUN make
RUN sudo make install
RUN sudo ldconfig
RUN hash -r
#RUN st-flash --version

# openocd from source
RUN git clone --recursive https://github.com/openocd-org/openocd.git /openocd
# Use WORKDIR instead of RUN cd /openocd, because how Docker isn't properly assigned to the correct directory with the "RUN cd"-command.
WORKDIR /openocd
RUN ./bootstrap
RUN ./configure --enable-ftdi --enable-stlink --enable-cmsis-dap --enable-cmsis-dap-v2 --prefix=/usr
# Without --prefix=/usr, openocd will be set to /usr/local/bin and config files to /usr/local/share/openocd by default, hence changing it to /usr.
RUN make -j$(nproc)
RUN make install

# If you have permission issues due to running a root in container, you can run the
# following command inside the container: sudo chown -R $(whoami):$(whoami) /workspace

# Prepare User
ARG USERNAME=engemil
ARG USER_UID=1000
ARG USER_GID=1000

# Remove any existing user/group that occupies the target UID/GID
RUN EXISTING_USER=$(getent passwd $USER_UID | cut -d: -f1) && \
    if [ -n "$EXISTING_USER" ]; then userdel -r "$EXISTING_USER"; fi || true
RUN EXISTING_GROUP=$(getent group $USER_GID | cut -d: -f1) && \
    if [ -n "$EXISTING_GROUP" ]; then groupdel "$EXISTING_GROUP"; fi || true
# Create the group with the host GID to avoid permission issues with mounted volumes
RUN groupadd --gid $USER_GID $USERNAME
# Create user with the host UID/GID so file ownership matches the host OS
RUN useradd -m -s /bin/bash --uid $USER_UID --gid $USER_GID $USERNAME
# Add user to sudo group
RUN usermod -aG sudo $USERNAME
# Allow passwordless sudo (typical for dev containers)
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# RUN AS USER FROM HERE
USER $USERNAME

RUN sudo apt-get install curl -y
RUN sudo curl -fsSL https://opencode.ai/install | bash


# Clean up
#RUN rm -rf /var/lib/apt-get/lists/*

# Make workspace directory
RUN sudo mkdir /workspace && sudo chown $USERNAME:$USERNAME /workspace
WORKDIR sudo /workspace
