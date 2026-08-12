#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  DEPLOY SLINGSHOTMIA.COM
#  Doble clic → sube todos los cambios a GitHub → Vercel despliega
# ─────────────────────────────────────────────────────────────
set -e
SITE="$HOME/slingshotmia.com"
REPO="https://github.com/acostajean0000-svg/slingshotmia.git"

cd "$SITE"

echo "🏁 Deploy de slingshotmia.com"
echo "─────────────────────────────"

# .gitignore básico (solo la primera vez)
if [ ! -f .gitignore ]; then
  printf ".DS_Store\nIMG_9439*.jpeg\ndeploy-slingshotmia.command\n" > .gitignore
fi

# Primera vez: conectar esta carpeta con el repo de GitHub (sin tocar tus archivos)
if [ ! -d .git ]; then
  echo "→ Primera vez: conectando la carpeta con GitHub…"
  TMP=$(mktemp -d)
  git clone --no-checkout "$REPO" "$TMP/repo" || {
    echo "❌ No se pudo conectar con GitHub. ¿Hay internet?"; read -n 1 -s -r -p "Tecla para cerrar…"; exit 1; }
  mv "$TMP/repo/.git" .git
  rm -rf "$TMP"
  git config user.name  "acostajean0000-svg"
  git config user.email "acostajean0000@gmail.com"
  git reset >/dev/null 2>&1 || true
  echo "✓ Carpeta conectada."
fi

# Detectar y subir cambios
git add -A
if git diff --cached --quiet; then
  echo "✓ No hay cambios que subir — el sitio ya está al día."
else
  echo "→ Cambios detectados:"
  git diff --cached --stat | tail -n 20
  git commit -m "Update site $(date '+%Y-%m-%d %H:%M')" >/dev/null
  echo "→ Sincronizando con GitHub…"
  git pull --rebase origin main || {
    echo "⚠️  Conflicto con cambios hechos en GitHub web. Resuélvelo o pide ayuda a Claude."; read -n 1 -s -r -p "Tecla para cerrar…"; exit 1; }
  git push origin HEAD:main
  echo ""
  echo "✅ Subido a GitHub. Vercel desplegará en ~1 minuto."
  echo "   Verifica en: https://slingshotmia.com"
fi

echo ""
read -n 1 -s -r -p "Presiona cualquier tecla para cerrar…"
