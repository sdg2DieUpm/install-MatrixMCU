# MatrixMCU VS Code Extension Packs

Draft Marketplace Extension Packs for the MatrixMCU courses. Students explicitly
choose and install one pack from the VS Code Extensions view; VS Code then
installs the extensions listed in that pack.

| Pack | Use |
| --- | --- |
| `matrixmcu-native` | C nativo en Linux, macOS o WSL |
| `matrixmcu-stm32` | Compilación cruzada con MatrixMCU/STM32 |
| `matrixmcu-full` | Ambos recorridos |
| `matrixmcu-windows-wsl` | Complemento para Windows y conexión USBIP/WSL |
| `matrixmcu-macos` | Complemento para depuración nativa con LLDB |

The packs only install VS Code Marketplace extensions. They do not install GCC,
ARM toolchains, CMake, OpenOCD, USBIPD, or operating-system packages. Those
remain the responsibility of the interactive MatrixMCU installer.

For Windows, test the Windows/WSL pack from the local VS Code window and test the
profile pack while connected to the target WSL distribution. Confirm the
Extensions view shows each extension in the intended Local or WSL location
before publishing these packs.

The manifests use the requested publisher ID `sdgdieupm`. Confirm that the
organization can register this exact ID and create the publisher before release.
The publisher ID cannot be changed after publishing. Do not publish these drafts
until the professor review and the WSL placement tests pass.

## Package locally

From each pack directory, run:

```bash
npx --yes @vscode/vsce package
```

The `vscode-extension-packs` workflow packages every draft on pull requests and
uploads one VSIX artifact per pack for seven days. Download the desired artifact
from the workflow run to test it without publishing it to the Marketplace.

## Test a VSIX in an isolated VS Code profile

Create a temporary VSIX, then install it with separate user-data and extension
directories. This keeps the test away from your normal VS Code profile:

```bash
cd vscode-extension-packs/native
npx --yes @vscode/vsce package --out /tmp/matrixmcu-native.vsix
mkdir -p /tmp/matrixmcu-test/native-data /tmp/matrixmcu-test/native-extensions
code --user-data-dir /tmp/matrixmcu-test/native-data \
	--extensions-dir /tmp/matrixmcu-test/native-extensions \
	--install-extension /tmp/matrixmcu-native.vsix
code --user-data-dir /tmp/matrixmcu-test/native-data \
	--extensions-dir /tmp/matrixmcu-test/native-extensions \
	--list-extensions
```

Repeat with the STM32 and Full packs using different temporary directories.
Confirm the pack ID and member IDs appear in the output and in the Extensions
view. This checks installation from VSIX, not Marketplace publishing or compiler
installation. Windows/WSL and macOS packs still need hands-on tests on those
platforms before publication.
