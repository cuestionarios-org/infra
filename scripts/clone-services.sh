#!/bin/bash
set -e

REPOS=(
    "gateway-api"
    "auth-service"
    "competition-service"
    "qa-service"
)
ORG_URL="https://github.com/cuestionarios-org"

for repo in "${REPOS[@]}"; do
    if [ -d "../$repo/.git" ]; then
        echo "Repositorio $repo ya existe. Actualizando..."
        git -C "../$repo" pull
    else
        echo "Clonando $repo..."
        git clone "$ORG_URL/$repo.git" "../$repo"
    fi
done