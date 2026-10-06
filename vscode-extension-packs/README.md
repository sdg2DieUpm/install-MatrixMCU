# MatrixMCU VS Code Extension Packs

Marketplace Extension Packs for the MatrixMCU courses. Students explicitly
choose and install one pack from the VS Code Extensions view; VS Code then
installs the extensions listed in that pack.

| Pack | Use |
| --- | --- |
| `matrixmcu-c-native` | Native C/C++ development on Linux, macOS, or WSL |
| `matrixmcu-stm32` | MatrixMCU/STM32 cross-compilation |
| `matrixmcu-full` | Both native and cross-compilation workflows |
| `matrixmcu-windows-wsl` | Windows add-on for WSL and USBIP connections |
| `matrixmcu-macos` | macOS add-on for native LLDB debugging |

The packs only install VS Code Marketplace extensions. They do not install GCC,
ARM toolchains, CMake, OpenOCD, USBIPD, or operating-system packages. Those
remain the responsibility of the MatrixMCU installation scripts.

Native and Full include the official `vscode-icons-team.vscode-icons` file icon
theme. To enable it, run **Preferences: File Icon Theme** and select **VSCode Icons**.

Todo Tree is no longer included. Updating a pack does not automatically uninstall
extensions removed from its list; uninstall Todo Tree manually if you no longer
want to use it.

For Windows, test the Windows/WSL pack from the local VS Code window and test the
profile pack while connected to the target WSL distribution. Confirm the
Extensions view shows each extension in the intended Local or WSL location
before publishing an update.

The manifests use the existing publisher ID `sdgdieupm`. Keep both the publisher
and extension names unchanged so updates retain their Marketplace IDs. Version
`0.1.2` updates the packs' names, descriptions, and documentation to English.
Packaging does not publish an update; publishing remains a separate manual step
after review and the required platform tests.

## Package locally

From each pack directory, run:

```bash
npx --yes @vscode/vsce package
```

The `vscode-extension-packs` workflow packages every pack as a pre-release on
pull requests and uploads one VSIX artifact per pack for seven days. Download
the desired artifact from the workflow run to test it without publishing it to
the Marketplace. Use these pre-release artifacts if uploading them manually;
earlier workflow runs may contain regular, non-pre-release VSIX files.

## Test a VSIX in an isolated VS Code profile

Create a temporary VSIX, then install it with separate user-data and extension
directories. This keeps the test away from your normal VS Code profile:

```bash
cd vscode-extension-packs/native
npx --yes @vscode/vsce package --out /tmp/matrixmcu-c-native.vsix
mkdir -p /tmp/matrixmcu-test/native-data /tmp/matrixmcu-test/native-extensions
code --user-data-dir /tmp/matrixmcu-test/native-data \
	--extensions-dir /tmp/matrixmcu-test/native-extensions \
	--install-extension /tmp/matrixmcu-c-native.vsix
code --user-data-dir /tmp/matrixmcu-test/native-data \
	--extensions-dir /tmp/matrixmcu-test/native-extensions \
	--list-extensions
```

Repeat with the STM32 and Full packs using different temporary directories.
Confirm the pack ID and member IDs appear in the output and in the Extensions
view. This checks installation from VSIX, not Marketplace publishing or compiler
installation. Windows/WSL and macOS packs still need hands-on tests on those
platforms before publication.
