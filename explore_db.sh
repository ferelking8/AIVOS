#!/bin/bash

# Script pour explorer Supabase via l'API REST
SUPABASE_URL="https://sbgstgpacvyomuimcfem.supabase.co"
SUPABASE_KEY="sb_publishable_A_ZRr5De8Tg_-FLP5AvVeA_TRHJejH0"

echo "========== 🔍 EXPLORATION SUPABASE =========="
echo ""

# 1. Lister les tables
echo "📋 Tentative de connexion et exploration..."
echo ""

# Essayer de récupérer les tables via information_schema
echo "🔍 Cherchant les tables..."
curl -s -X GET \
  "${SUPABASE_URL}/rest/v1/information_schema.tables?table_schema=eq.public&select=table_name" \
  -H "apikey: ${SUPABASE_KEY}" \
  -H "Accept: application/json" 2>/dev/null || echo "❌ Information schema non disponible"

echo ""
echo ""

# 2. Tester chaque table probable
tables=("products" "categories" "users" "profiles" "orders" "bookmarks" "cart_items" "reviews")

for table in "${tables[@]}"; do
  echo "📦 Testant table: $table"

  response=$(curl -s -w "\n%{http_code}" -X GET \
    "${SUPABASE_URL}/rest/v1/${table}?select=*&limit=1" \
    -H "apikey: ${SUPABASE_KEY}" \
    -H "Accept: application/json" 2>/dev/null)

  http_code=$(echo "$response" | tail -n1)
  body=$(echo "$response" | head -n-1)

  if [ "$http_code" = "200" ]; then
    echo "   ✅ EXISTE"
    echo "   Structure: $body" | head -c 200
    echo ""

    # Récupérer le nombre de lignes
    count=$(curl -s -X GET \
      "${SUPABASE_URL}/rest/v1/${table}?select=count" \
      -H "apikey: ${SUPABASE_KEY}" \
      -H "Accept: application/json" \
      -H "Content-Profile: public" 2>/dev/null | jq 'length' 2>/dev/null || echo "?")
    echo "   Nombre de lignes: $count"
  elif [ "$http_code" = "404" ]; then
    echo "   ❌ N'existe pas"
  else
    echo "   ⚠️  Erreur HTTP $http_code"
  fi
  echo ""
done

echo "========== FIN EXPLORATION =========="
