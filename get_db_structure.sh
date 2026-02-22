#!/bin/bash

# Script pour récupérer la structure EXACTE de Supabase
SUPABASE_URL="https://sbgstgpacvyomuimcfem.supabase.co"
SUPABASE_KEY="sb_publishable_A_ZRr5De8Tg_-FLP5AvVeA_TRHJejH0"

echo "========== 📊 STRUCTURE COMPLÈTE SUPABASE =========="
echo ""

# Fonction pour obtenir les colonnes d'une table
get_table_structure() {
  local table=$1

  echo "📦 TABLE: $table"
  echo "─────────────────────────────────────────"

  # Utiliser curl pour faire une requête OPTIONS et voir les colonnes
  local meta=$(curl -s -X OPTIONS \
    "${SUPABASE_URL}/rest/v1/${table}" \
    -H "apikey: ${SUPABASE_KEY}" 2>&1)

  # Essayer d'obtenir un exemple pour voir les champs
  local example=$(curl -s -X GET \
    "${SUPABASE_URL}/rest/v1/${table}?limit=1&select=*" \
    -H "apikey: ${SUPABASE_KEY}" \
    -H "Content-Profile: public" 2>&1)

  # Si vide, essayer directement
  if [ "$example" = "[]" ]; then
    echo "Table VIDE - Essayons une approche différente..."

    # Essayer avec Accept header différent
    example=$(curl -s -X GET \
      "${SUPABASE_URL}/rest/v1/${table}?limit=0" \
      -H "apikey: ${SUPABASE_KEY}" \
      -H "Accept: application/json" 2>&1)
  fi

  # Afficher le résultat brut pour voir la structure
  if [ -z "$example" ] || [ "$example" = "[]" ]; then
    echo "⚠️  Table vide - pas de données pour inspirer"
    echo "    Essayons de lire via PostgreSQL REST..."
  else
    echo "✅ Structure détectée:"
    echo "$example" | jq '.' 2>/dev/null || echo "$example"
  fi

  echo ""
}

# Récupérer les métadonnées via la requête POST (méthode Supabase)
echo "🔍 Récupération des métadonnées des tables..."
echo ""

# Lister les tables connues
tables=("products" "categories" "orders" "users" "profiles" "cart_items" "bookmarks")

for table in "${tables[@]}"; do
  # Vérifier si la table existe
  status=$(curl -s -o /dev/null -w "%{http_code}" -X GET \
    "${SUPABASE_URL}/rest/v1/${table}?limit=0" \
    -H "apikey: ${SUPABASE_KEY}" 2>&1)

  if [ "$status" = "200" ]; then
    get_table_structure "$table"
  fi
done

echo ""
echo "========== 📋 INFORMATION SCHEMA (via SQL) =========="
echo ""
echo "Pour obtenir les colonnes exactes, essayons:"
echo ""

# Créer un script SQL pour afficher la structure
cat > /tmp/show_structure.sql << 'SQLEOF'
-- Affiche la structure complète de chaque table
SELECT
  table_name,
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
SQLEOF

echo "📝 Script SQL à exécuter dans Supabase:"
cat /tmp/show_structure.sql
