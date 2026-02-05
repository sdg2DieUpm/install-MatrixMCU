#!/bin/bash

# Update package list
sudo apt update

# Install build-essential
sudo apt install build-essential

# Install cmake
sudo apt install cmake
# sudo snap install cmake --classic

# Install openocd
sudo apt install openocd

# Install gdb multiarch
sudo apt install gdb-multiarch

# Create directories for the tools used in MatrixMCU course
sudo mkdir -p /opt/MatrixMCU/bin

# Download arm toolchain zip file
wget https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/arm-toolchain.tar.xz
# Uncompress arm toolchain zip file in /opt directory
sudo tar -xf /tmp/arm-toolchain.tar.xz -C /opt/MatrixMCU

# Create symbolic links to arm toolchain in /opt/MatrixMCU/bin
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /opt/MatrixMCU/bin/arm-none-eabi-gcc
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /opt/MatrixMCU/bin/arm-none-eabi-g++
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-nm /opt/MatrixMCU/bin/arm-none-eabi-nm
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /opt/MatrixMCU/bin/arm-none-eabi-objcopy
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump /opt/MatrixMCU/bin/arm-none-eabi-objdump

# Get the path to gdb-multiarch...
GDB_MULTIARCH_PATH=$(which gdb-multiarch)
# ... and create a symbolic link to gdb-multiarch in /opt/MatrixMCU/bin with the name arm-none-eabi-gdb
sudo ln -s $GDB_MULTIARCH_PATH /opt/MatrixMCU/bin/arm-none-eabi-gdb

# Add /opt/MatrixMCU/bin to PATH
echo 'export PATH=/opt/MatrixMCU/bin:$PATH # Required for MatrixMCU toolkit' >> ~/.bashrc
