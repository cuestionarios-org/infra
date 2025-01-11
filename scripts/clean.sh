#!/bin/bash
set -e

echo "Limpiando contenedores y volúmenes..."

docker-compose down --volumes --remove-orphans

echo "Eliminando imágenes no usadas..."
docker image prune -f

echo "Proyecto limpiado con éxito."
