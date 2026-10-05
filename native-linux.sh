#!/usr/bin/env bash

set -euo pipefail

readonly COMMANDS=(gcc g++ make cmake gdb git)

check_tools() {
    local result=0
    local command_name

    for command_name in "${COMMANDS[@]}"; do
        if command -v "$command_name" >/dev/null 2>&1; then
            printf '[OK] %s\n' "$command_name"
        else
            printf '[FALTA] %s\n' "$command_name"
            result=1
        fi
    done
    return "$result"
}

if (($# > 1)); then
    printf 'Uso: bash native-linux.sh [--check | --help]\n' >&2
    exit 2
fi

case ${1:-} in
    -h|--help)
        printf 'C nativo en Debian y derivados, incluido Ubuntu en WSL.\n'
        printf 'Uso: bash native-linux.sh [--check | --help]\n'
        printf 'Sin opciones instala las herramientas; --check solo las comprueba.\n'
        exit 0
        ;;
    --check)
        check_tools
        exit 0
        ;;
    '') ;;
    *)
        printf 'Uso: bash native-linux.sh [--check | --help]\n' >&2
        exit 2
        ;;
esac

if ! command -v apt-get >/dev/null 2>&1; then
    printf 'Error: este instalador necesita apt-get (Debian o derivados).\n' >&2
    exit 1
fi

APT_GET=(apt-get)
if ((EUID != 0)); then
    APT_GET=(sudo apt-get)
fi

"${APT_GET[@]}" update
"${APT_GET[@]}" install --yes --no-install-recommends build-essential cmake gdb git

check_tools
printf '\nSiguiente paso: instala manualmente el pack MatrixMCU: Native C/C++ desde VS Code.\n'