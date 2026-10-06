# MatrixMCU: STM32 Cross-Compilation

Extension Pack for editing, building, and debugging MatrixMCU STM32 projects
in VS Code. It includes C/C++ support, CMake integration, Cortex-Debug,
task variables, and a serial monitor.

Install the pack manually from the **Extensions** view. On Windows, connect
VS Code to your selected WSL distribution and check that the development
extensions are installed in the correct location before debugging.

The pack does not install the ARM GNU Toolchain, CMake, OpenOCD, usbipd-win,
or system tools. Use the MatrixMCU installation scripts for those dependencies.
