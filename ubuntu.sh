#!/bin/bash

# Update package list
sudo apt update

# Install git
sudo apt install git

# Install build-essential
sudo apt install build-essential

# Install cmake
sudo apt install cmake

# Install openocd
sudo apt install openocd

# Install gdb multiarch
sudo apt install gdb-multiarch

# Download arm toolchain zip file
wget https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/arm-toolchain.tar.xz

# Uncompress arm toolchain zip file in /usr/share directory
sudo tar -xf /tmp/arm-toolchain.tar.xz -C /usr/local/

# Create symbolic links to arm toolchain in /usr/bin
sudo ln -s /usr/local/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
sudo ln -s /usr/local/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/local/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
sudo ln -s /usr/local/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump

# Add gdb-multiarch alias to .bashrc to use gdb-multiarch as arm-none-eabi-gdb
echo "alias arm-none-eabi-gdb='gdb-multiarch'" >> ~/.bashrc
