#!/bin/zsh

# Update package list
brew update

# Install cmake
brew install cmake

# Install openocd
brew install opencd

# Install arm toolchain
brew install --cask gcc-arm-embedded
