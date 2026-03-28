#!/bin/bash

# ============================================
# deploy.sh — Viaje Alemania 2026
# Uso: ./deploy.sh "descripción del cambio"
# ============================================

REPO_DIR="/Users/guero/Documents/Viaje Alemania/viaje-alemania"
DOWNLOADS_DIR="$HOME/Downloads"
INDEX_FILE="index.html"

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que se pasó un mensaje de commit
if [ -z "$1" ]; then
  echo -e "${RED}❌ Error: falta el mensaje del commit${NC}"
  echo -e "Uso: ${YELLOW}./deploy.sh \"descripción del cambio\"${NC}"
  exit 1
fi

COMMIT_MSG="$1"

echo -e "${YELLOW}🚀 Iniciando deploy...${NC}"

# Verificar que el archivo existe en Downloads
if [ ! -f "$DOWNLOADS_DIR/$INDEX_FILE" ]; then
  echo -e "${RED}❌ No se encontró $INDEX_FILE en Downloads${NC}"
  echo -e "Asegúrate de haber descargado el archivo antes de correr este script."
  exit 1
fi

# Entrar al repo
cd "$REPO_DIR" || { echo -e "${RED}❌ No se pudo entrar al directorio del repo${NC}"; exit 1; }

# Copiar el archivo
cp "$DOWNLOADS_DIR/$INDEX_FILE" .
echo -e "${GREEN}✅ index.html copiado desde Downloads${NC}"

# Git add, commit, push
git add "$INDEX_FILE"
git commit -m "$COMMIT_MSG"

echo -e "${YELLOW}📤 Haciendo push a GitHub...${NC}"
git push

echo -e "${GREEN}✅ ¡Listo! Cambio publicado en GitHub Pages.${NC}"
echo -e "🌐 https://guerobertoldi42.github.io/viaje-alemania/"
