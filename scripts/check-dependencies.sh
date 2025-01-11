#!/bin/bash
set -e

echo "Verificando dependencias..."

REQUIRED_CMDS=("docker" "docker-compose" "git")

for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! [ -x "$(command -v $cmd)" ]; then
        echo "Error: $cmd no está instalado." >&2
        exit 1
    fi
done

echo "Todas las dependencias están instaladas."
