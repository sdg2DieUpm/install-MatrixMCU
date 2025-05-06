#!/bin/bash

# Update package list
sudo apt update

# Install dependencies
sudo apt install -y build-essential cmake openocd gdb-multiarch

# Create directories for the tools used in MatrixMCU toolkit
sudo mkdir -p /opt/MatrixMCU/bin

# Detect required toolchain binary depending on host architecture
TOOLCHAIN_VERSION="15.2.rel1"
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    TOOLCHAIN_DIR="arm-gnu-toolchain-$TOOLCHAIN_VERSION-x86_64-arm-none-eabi"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    TOOLCHAIN_DIR="arm-gnu-toolchain-$TOOLCHAIN_VERSION-aarch64-arm-none-eabi"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download arm toolchain zip file
wget https://developer.arm.com/-/media/Files/downloads/gnu/$TOOLCHAIN_VERSION/binrel/$TOOLCHAIN_DIR.tar.xz -O /tmp/arm-toolchain.tar.xz
# Uncompress arm toolchain zip file in /opt directory
sudo tar -xf /tmp/arm-toolchain.tar.xz -C /opt/MatrixMCU

# Create symbolic links to arm toolchain in /opt/MatrixMCU/bin
sudo ln -s /opt/MatrixMCU/$TOOLCHAIN_DIR/bin/arm-none-eabi-gcc /opt/MatrixMCU/bin/arm-none-eabi-gcc
sudo ln -s /opt/MatrixMCU/$TOOLCHAIN_DIR/bin/arm-none-eabi-g++ /opt/MatrixMCU/bin/arm-none-eabi-g++
sudo ln -s /opt/MatrixMCU/$TOOLCHAIN_DIR/bin/arm-none-eabi-nm /opt/MatrixMCU/bin/arm-none-eabi-nm
sudo ln -s /opt/MatrixMCU/$TOOLCHAIN_DIR/bin/arm-none-eabi-objcopy /opt/MatrixMCU/bin/arm-none-eabi-objcopy
sudo ln -s /opt/MatrixMCU/$TOOLCHAIN_DIR/bin/arm-none-eabi-objdump /opt/MatrixMCU/bin/arm-none-eabi-objdump

# Get the path to gdb-multiarch...
GDB_MULTIARCH_PATH=$(which gdb-multiarch)
# ... and create a symbolic link to gdb-multiarch in /opt/MatrixMCU/bin with the name arm-none-eabi-gdb
sudo ln -s $GDB_MULTIARCH_PATH /opt/MatrixMCU/bin/arm-none-eabi-gdb

# Add /opt/MatrixMCU/bin to PATH
echo 'export PATH=/opt/MatrixMCU/bin:$PATH # Required for MatrixMCU toolkit' >> ~/.bashrc
