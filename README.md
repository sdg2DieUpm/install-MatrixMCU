# Installation instruction for the SDG2 laboratory

## MacOS

First, we must install [Homebrew](https://brew.sh) in our Mac.
If you have not done it yet, open a terminal and insert the following command:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
The script explains what it will do and then pauses before it does it.

To check if Homebrew was installed correctly, **open a new terminal** and insert the following command:
```bash
brew --version
```
This command should output the version of Homebrew installed on your Mac.

Once you have Homebrew on your Mac, clone this repo and move to this directory:
```
git clone https://github.com/sdg2DieUpm/installer.git && cd installer
```
Then, run the script `macos.sh` in `sudo` mode:
```
sudo ./macos.sh
```

To check that the installation succeeded, run the following commands **ONE BY ONE**:
```bash
arm-none-eabi-gcc --version
arm-none-eabi-g++ --version
arm-none-eabi-gdb --version
arm-none-eabi-objcopy --version
arm-none-eabi-objdump --version
```
Each of these commands should output the current version of the tool under study, as well as other additional details about the software.

## Windows

For Windows, we will use the Windows Subsystem for Linux (WSL).
WSL allows developers to install a Linux distribution (such as Ubuntu, OpenSUSE, Kali, Debian, Arch Linux, etc.) and use Bash applications, utilities and command line tools directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot configuration.

1. Open PowerShell or the Windows command prompt as an administrator by right-clicking and selecting "Run as administrator".
2. Insert the following command:
```
wsl --install
```
3. Restart your PC.

Now, we have WSL with the latest version of Ubuntu installed in our machine.
If you search "Ubuntu" in your applications, you will find an executable that runs an Ubuntu shell on top of WSL.
You will find more information about how to configure your WSL development environment [here](https://learn.microsoft.com/es-es/windows/wsl/setup/environment?source=recommendations).

Next, you must follow the installation instructions for Ubuntu users.

**NOTE**: You must follow these instructions **from the Ubuntu terminal**, not the Window's PowerShell.

## Ubuntu

Clone this repo and move to this directory:
```
git clone https://github.com/sdg2DieUpm/installer.git && cd installer
```
Then, run the script `ubuntu.sh` in a terminal in `sudo` mode:
```bash
sudo ./ubuntu.sh
```
Once you are done, close and re-open the terminal so the shell reloads the `.bashrc` settings

To check that the installation succeeded, run the following commands **ONE BY ONE**:
```bash
arm-none-eabi-gcc --version
arm-none-eabi-g++ --version
arm-none-eabi-gdb --version
arm-none-eabi-objcopy --version
arm-none-eabi-objdump --version
```
Each of these commands should output the current version of the tool under study, as well as other additional details about the software.
