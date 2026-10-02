#!/usr/bin/env bash

set -Eeuo pipefail

readonly PACKAGES=(build-essential cmake gdb git)
readonly COMMANDS=(gcc g++ make cmake gdb git)

usage() {
    cat <<'EOF'
Instalador de herramientas para C nativo en Ubuntu.

Uso:
  bash native-linux.sh [--check]

Opciones:
  --check  Comprueba si las herramientas necesarias estan instaladas.
  -h       Muestra esta ayuda.
EOF
}

fail() {
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

check_ubuntu() {
    [[ -r /etc/os-release ]] || fail 'No se encuentra /etc/os-release.'
    # shellcheck disable=SC1091
    . /etc/os-release

    if [[ -n ${WSL_DISTRO_NAME:-} || -n ${WSL_INTEROP:-} || $(uname -r) == *microsoft* ]]; then
        fail 'Windows/WSL todavia no esta admitido por este instalador.'
    fi

    [[ ${ID:-} == ubuntu ]] || fail 'Este instalador admite Ubuntu; no se han realizado cambios.'
    case ${VERSION_ID:-} in
        22.04|24.04|26.04) ;;
        *) fail "Version de Ubuntu no validada: ${VERSION_ID:-desconocida}. Se admite 22.04, 24.04 y 26.04." ;;
    esac
}

check_tools() {
    local missing=()
    local command_name

    for command_name in "${COMMANDS[@]}"; do
        if command -v "$command_name" >/dev/null 2>&1; then
            printf '[OK] %s: %s\n' "$command_name" "$(command -v "$command_name")"
        else
            printf '[FALTA] %s\n' "$command_name"
            missing+=("$command_name")
        fi
    done

    if ((${#missing[@]} > 0)); then
        printf '\nFaltan herramientas. Ejecuta el instalador sin --check para instalarlas.\n' >&2
        return 1
    fi

    printf '\nLas herramientas para C nativo estan disponibles.\n'
}

check_packages() {
    local missing=()
    local package_name

    for package_name in "${PACKAGES[@]}"; do
        if [[ $(dpkg-query -W -f='${db:Status-Status}' "$package_name" 2>/dev/null || true) == installed ]]; then
            printf '[OK] paquete %s\n' "$package_name"
        else
            printf '[FALTA] paquete %s\n' "$package_name"
            missing+=("$package_name")
        fi
    done

    if ((${#missing[@]} > 0)); then
        printf '\nFaltan paquetes del sistema. Ejecuta el instalador sin --check para instalarlos.\n' >&2
        return 1
    fi
}

check_installation() {
    local result=0

    check_packages || result=1
    check_tools || result=1
    return "$result"
}

if (($# > 1)); then
    usage >&2
    exit 2
fi

case ${1:-} in
    -h|--help)
        usage
        exit 0
        ;;
    ''|--check) ;;
    *)
        usage >&2
        exit 2
        ;;
esac

check_ubuntu

if [[ ${1:-} == --check ]]; then
    if check_installation; then
        exit 0
    else
        exit 1
    fi
fi

[[ -t 0 ]] || fail 'Ejecuta este script desde una terminal interactiva.'
command -v apt-get >/dev/null 2>&1 || fail 'No se encuentra apt-get.'

printf 'Se instalaran estas herramientas para C nativo en Ubuntu %s:\n' "$VERSION_ID"
printf '  - GCC y G++ (build-essential), Make, CMake, GDB y Git\n'
printf 'No se instalara la toolchain ARM ni OpenOCD, y no se modificara ~/.bashrc.\n'
read -r -p 'Continuar? [s/N] ' answer
case $answer in
    [sS]|[sS][iI]|[yY]|[yY][eE][sS]) ;;
    *)
        printf 'Instalacion cancelada; no se han realizado cambios.\n'
        exit 0
        ;;
esac

if ((EUID == 0)); then
    APT_GET=(apt-get)
else
    command -v sudo >/dev/null 2>&1 || fail 'Se necesita sudo para instalar paquetes.'
    APT_GET=(sudo apt-get)
fi

"${APT_GET[@]}" update
"${APT_GET[@]}" install --yes --no-install-recommends "${PACKAGES[@]}"

printf '\nComprobando herramientas instaladas...\n'
check_installation
printf '\nSiguiente paso: instala manualmente el pack MatrixMCU: C/C++ nativo desde VS Code.\n'