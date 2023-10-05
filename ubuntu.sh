#!/bin/bash

# Update package list
sudo apt update

# Install cmake
sudo apt install cmake -y

# Install openocd
sudo apt install openocd -y

# Download arm toolchain zip file
wget https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/arm-toolchain.tar.xz

# Uncompress arm toolchain zip file in /usr/share directory
sudo tar -xf /tmp/arm-toolchain.tar.xz -C /usr/share/

# Create symbolic links to arm toolchain in /usr/bin
sudo ln -s /usr/share/arm-gnu-toolchain-12.3.rel1/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
sudo ln -s /usr/share/arm-gnu-toolchain-12.3.rel1/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/share/arm-gnu-toolchain-12.3.rel1/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
sudo ln -s /usr/share/arm-gnu-toolchain-12.3.rel1/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump
