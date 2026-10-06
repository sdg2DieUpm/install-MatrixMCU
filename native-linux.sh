#!/usr/bin/env bash

set -euo pipefail

readonly COMMANDS=(gcc g++ make cmake gdb git)

check_compilation() {
    local check_dir
    local result=0
    check_dir=$(mktemp -d) || return 1

    if gcc -std=c11 -x c - -o "$check_dir/hello" <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(void) {
    uint32_t value = 42;
    printf("%u\n", (unsigned)value);
    return EXIT_SUCCESS;
}
EOF
    then
        printf '[OK] Compilation and linking of C with standard headers and libraries\n'
    else
        printf '[MISSING] Unable to compile and link C with standard headers and libraries; run the installer to install build-essential.\n' >&2
        result=1
    fi

    rm -rf -- "$check_dir"
    return "$result"
}

check_tools() {
    local result=0
    local command_name

    for command_name in "${COMMANDS[@]}"; do
        if command -v "$command_name" >/dev/null 2>&1; then
            printf '[OK] %s\n' "$command_name"
        else
            printf '[MISSING] %s\n' "$command_name"
            result=1
        fi
    done
    if ((result == 0)); then
        check_compilation || result=1
    fi
    return "$result"
}

if (($# > 1)); then
    printf 'Usage: bash native-linux.sh [--check | --help]\n' >&2
    exit 2
fi

case ${1:-} in
    -h|--help)
        printf 'Native C development environment for Debian and derivatives, including Ubuntu on WSL.\n'
        printf 'Usage: bash native-linux.sh [--check | --help]\n'
        printf 'Without options, it installs the tools; --check only verifies them.\n'
        exit 0
        ;;
    --check)
        check_tools
        exit 0
        ;;
    '') ;;
    *)
        printf 'Usage: bash native-linux.sh [--check | --help]\n' >&2
        exit 2
        ;;
esac

if ! command -v apt-get >/dev/null 2>&1; then
    printf 'Error: this installer requires apt-get (Debian or derivatives).\n' >&2
    exit 1
fi

APT_GET=(apt-get)
if ((EUID != 0)); then
    APT_GET=(sudo apt-get)
fi

"${APT_GET[@]}" update
"${APT_GET[@]}" install --yes --no-install-recommends build-essential cmake gdb git

check_tools
printf '\nNext step suggested: install the MatrixMCU: Native C/C++ pack from VS Code.\n'