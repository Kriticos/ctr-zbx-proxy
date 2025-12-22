#!/bin/bash

echo "📁 Iniciando preparação das pastas do ambiente..."

# Diretório onde o script está
BASE_DIR="$(dirname "$(realpath "$0")")"

# Pastas de dados (volumes persistentes)
DATA_DIRS=(
  "$BASE_DIR/database"
)

# Criando diretórios
for DIR in "${DATA_DIRS[@]}"; do
  if [ ! -d "$DIR" ]; then
    echo "📂 Criando $DIR"
    mkdir -p "$DIR"
  else
    echo "✔️ Já existe: $DIR"
  fi
done

echo "🔧 Ajustando permissões..."
chown -R 1997:1997 "$BASE_DIR/database"
chmod -R 770 "$BASE_DIR/dadatabase"

# Configurando rede Docker personalizada
if ! docker network ls | grep -q "network-share"; then
  echo "🌐 Criando rede network-share..."
  docker network create \
    --driver=bridge \
    --subnet=172.18.0.0/16 \
    network-share
fi

echo "✅ Preparação concluída!"