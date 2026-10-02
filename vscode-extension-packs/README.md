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

The manifests currently use `sdg2dieupm` as a candidate publisher ID. Confirm or
register the organization's Marketplace publisher before release. Do not publish
these drafts until the professor review and the WSL placement tests pass.

## Package locally

From each pack directory, run:

```bash
npx --yes @vscode/vsce package
```

The `vscode-extension-packs` workflow packages every draft on pull requests.
