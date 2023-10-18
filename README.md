# Installation instructions for the SDG2 laboratory

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

First, open Windows PowerShell as an administrator by right-clicking and selecting "Run as administrator". Next, insert the following command to install WSL:
```
wsl --install
```
Once it is done (it might take a while), you must restart your PC to apply all the changes.

Now, we have WSL with the latest version of Ubuntu installed in our machine.
If you search "Ubuntu" in your applications, you will find an executable that runs an Ubuntu shell on top of WSL.
You will find more information about how to configure your WSL development environment [here](https://learn.microsoft.com/es-es/windows/wsl/setup/environment?source=recommendations).

Next, open an Ubuntu terminal. The first time, it will take some time to install the operating system.
You must also create a new user for the Ubuntu subsystem.
This step is only done once, so **make sure to remember the user name and the password**, as you will need to provide them every time you open a new Ubuntu terminal.

### Connecting USB Devices to WSL

In this course, we will need to connect our STM32 board to WSL.
This is not available by default in WSL, so we need to install `usbipd-win` first.
To do so, download the `.msi` installer file from [the latest version of `usbipd-win`](https://github.com/dorssel/usbipd-win/releases) and run it.
You will need to restart your PC to apply the required changes.

Next, we need to configure our Ubuntu WSL instance to allow connecting USB devices.
Open an Ubuntu terminal and run the following commands:
```bash
sudo apt update
sudo apt install linux-tools-generic hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/*-generic/usbip 20
```

We already installed all the required dependencies.
Next, to connect an USB device to WSL, we must follow these steps:
1. Make sure that you have an Ubuntu terminal running. Otherwise, it will not be possible to attach any USB device.
2. Open Windows PowerShell. The first time you do this process, you will need to run it as an administrator by right-clicking and selecting "Run as administrator"
3. Run the following command **in the Windows PowerShell** to check all the USB devices connected to Windows:
```
usbipd wsl list
```
If you have your STM32 board connected, you will see something like:
```
BUSID   VID:PID     DEVICE                                                          STATE
(...)
1-4     0483:374b   ST-Link Debug, Dispositivo de almacenamiento USB, STMicro...    Not attached
(...)
```
The ST-Link Debug is the USB controller of our STM32 board. Note down the `VID:PID` field (in this example, `0483:374b`. In your case, the number may differ).
We will need it to identify which USB device we want to attach to WSL.
4. Run the following command **in the Windows PowerShell** to connect the USB device to your Ubuntu system:
```
usbipd wsl attach -a -i <VID:PID>
```
Make sure that you insert the correct hardware number for your board!

If everything went well, your PowerShell terminal will prompt something like this:
```
usbpid: info: Device with hardware-id <VID-PID> found at busid <BUSID>.
usbpid info: Starting endless attach loop; press Ctrl+C to quit.
Attached
```
Leave the PowerShell terminal open. It will make sure to keep your board connected to Ubuntu.
You can close it after closing the Ubuntu terminal.
5. To make sure that your board is connected to Ubuntu, run the following command **In the Ubuntu terminal**:
```
lsusb
```
You should be able to see your ST-Link Debug probe connected to your Ubuntu terminal.

### Installing the Dependencies on the Ubuntu Subsytem

Next, follow the installation instructions for Ubuntu **from the Ubuntu terminal**, not the Windows PowerShell.


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
