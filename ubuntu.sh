#!/bin/bash

# Update package list
sudo apt update

# Install build-essential
sudo apt install build-essential

# Install cmake
sudo apt install cmake

# Install openocd
sudo apt install openocd

# Install gdb multiarch
sudo apt install gdb-multiarch

# Create directories for the tools used in SDG2 course
sudo mkdir /opt/sdg2
sudo mkdir /opt/sdg2/bin

# Download arm toolchain zip file
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/arm-toolchain.tar.xz
# Uncompress arm toolchain zip file in /usr/share directory
sudo tar -xf /tmp/arm-toolchain.tar.xz -C /opt/sdg2

# Create symbolic links to arm toolchain in /opt/sdg2/bin
sudo ln -s /opt/sdg2/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /opt/sdg2/bin/arm-none-eabi-gcc
sudo ln -s /opt/sdg2/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /opt/sdg2/bin/arm-none-eabi-g++
sudo ln -s /opt/sdg2/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /opt/sdg2/bin/arm-none-eabi-objcopy
sudo ln -s /opt/sdg2/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump /opt/sdg2/bin/arm-none-eabi-objdump

# Get the path to gdb-multiarch...
GDB_MULTIARCH_PATH=$(which gdb-multiarch)
# ... and create a symbolic link to gdb-multiarch in /opt/sdg2/bin with the name arm-none-eabi-gdb
sudo ln -s $GDB_MULTIARCH_PATH /opt/sdg2/bin/arm-none-eabi-gdb

# Add /opt/sdg2/bin to PATH
echo 'export PATH=/opt/sdg2/bin:$PATH # Required for SDG2 course' >> ~/.bashrc
