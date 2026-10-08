#!/usr/bin/env bash
# Instala en Claude Code las skills de Viventa.
# Uso:  ./instalar.sh                 → las 18
#       ./instalar.sh lizeth-henriquez → solo las de esa persona (ver personas/)
set -euo pipefail
raiz="$(cd "$(dirname "$0")" && pwd)"
destino="$HOME/.claude/skills"
persona="${1:-}"
if [ -n "$persona" ]; then
  lista="$raiz/personas/$persona.skills"
  [ -f "$lista" ] || { echo "No conozco a «$persona». Opciones: $(ls "$raiz/personas" | sed -n 's/\.skills$//p' | tr '\n' ' ')" >&2; exit 1; }
  skills=$(grep -v '^#' "$lista")
else
  skills=$(ls "$raiz/skills")
fi
mkdir -p "$destino"
n=0
for s in $skills; do
  mkdir -p "$destino/$s"
  cp -R "$raiz/skills/$s/." "$destino/$s/"
  n=$((n + 1))
done
echo "Listo: $n skills instaladas en $destino. Reinicia Claude Code para que las cargue."
