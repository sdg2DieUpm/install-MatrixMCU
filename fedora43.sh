#!/bin/bash

# Update package list
sudo dnf update

# Install build-essential alternative
sudo dnf group install development-tools c-development

# Install cmake
sudo dnf install cmake

# Install openocd
sudo dnf install openocd

#gdb-multiarch not available for Fedora

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
sudo ln -s /opt/MatrixMCU/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb /opt/MatrixMCU/bin/arm-none-eabi-gdb

# Add /opt/MatrixMCU/bin to PATH
echo 'export PATH=/opt/MatrixMCU/bin:$PATH # Required for MatrixMCU toolkit' >> ~/.bashrc

# Alternatively it can also be added inside a separate file in ~/.bashrc.d/ directory, which is a more modular approach.
#
