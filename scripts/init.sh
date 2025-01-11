#!/bin/bash
set -e

echo "Inicializando el proyecto..."

# Comprueba si Docker está instalado
if ! [ -x "$(command -v docker)" ]; then
    echo "Error: Docker no está instalado." >&2
    exit 1
fi

# Comprueba si Docker Compose está instalado
if ! [ -x "$(command -v docker-compose)" ]; then
    echo "Error: Docker Compose no está instalado." >&2
    exit 1
fi

echo "Docker y Docker Compose están instalados."

# Construir y levantar servicios
docker-compose up --build -d

echo "Servicios inicializados correctamente."
