# installer
Installer scripts for SDG2

# MacOS

First, we must install Homebrew in our Mac. If you have not done it yet, open a terminal and insert the following command:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
The script explains what it will do and then pauses before it does it.

To check if Homebrew was installed correctly, insert **open a new terminal** and insert the following command:
```bash
brew --version
```
This command should output the version of Homebrew installed on your Mac.

Once you have Homebrew on your Mac, open a terminal and move to this directory.
Then, run the script `macos.sh` in sudo mode:
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

# Windows

To do.

# Ubuntu

- Open a terminal and move to this directory
- Run the script `ubuntu.sh` in a terminal in `sudo` mode:
```bash
sudo ./ubuntu.sh
```
- Close and re-open the terminal so the shell reloads the `.bashrc` settings

To check that the installation succeeded, run the following commands **ONE BY ONE**:
```bash
arm-none-eabi-gcc --version
arm-none-eabi-g++ --version
arm-none-eabi-gdb --version
arm-none-eabi-objcopy --version
arm-none-eabi-objdump --version
```
Each of these commands should output the current version of the tool under study, as well as other additional details about the software.