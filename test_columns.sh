#!/bin/bash

# Script pour tester différentes structures possibles
SUPABASE_URL="https://sbgstgpacvyomuimcfem.supabase.co"
SUPABASE_KEY="sb_publishable_A_ZRr5De8Tg_-FLP5AvVeA_TRHJejH0"

echo "========== 🔬 TEST DE STRUCTURE DES TABLES =========="
echo ""

# Test 1: Essayer différentes colonnes pour "categories"
echo "🧪 TEST 1: Colonnes de 'categories'"
echo "─────────────────────────────────────────"

test_columns=(
  "id,title"
  "id,name"
  "id,name,description"
  "id,title,image"
  "id,title,image,svg_src"
  "*"
)

for cols in "${test_columns[@]}"; do
  echo "  Essai: SELECT $cols"
  result=$(curl -s -X GET \
    "${SUPABASE_URL}/rest/v1/categories?select=$cols&limit=1" \
    -H "apikey: ${SUPABASE_KEY}" 2>&1)

  # Vérifier si c'est une erreur ou un résultat
  if echo "$result" | grep -q "error\|does not exist\|PGRST"; then
    error_msg=$(echo "$result" | jq '.message // .' 2>/dev/null | head -c 80)
    echo "    ❌ Erreur: $error_msg"
  else
    echo "    ✅ Succès!"
    echo "    Résultat: $result"
  fi
done

echo ""
echo ""

# Test 2: Même chose pour "products"
echo "🧪 TEST 2: Colonnes de 'products'"
echo "─────────────────────────────────────────"

test_columns=(
  "id,title"
  "id,name"
  "id,product_name"
  "id,title,price"
  "id,title,brand_name,price"
  "id,title,brand_name,price,discount,image"
  "*"
)

for cols in "${test_columns[@]}"; do
  echo "  Essai: SELECT $cols"
  result=$(curl -s -X GET \
    "${SUPABASE_URL}/rest/v1/products?select=$cols&limit=1" \
    -H "apikey: ${SUPABASE_KEY}" 2>&1)

  # Vérifier si c'est une erreur ou un résultat
  if echo "$result" | grep -q "error\|does not exist\|PGRST"; then
    error_msg=$(echo "$result" | jq '.message // .' 2>/dev/null | head -c 80)
    echo "    ❌ Erreur: $error_msg"
  else
    echo "    ✅ Succès!"
    echo "    Résultat: $result"
  fi
done

echo ""
echo "========== FIN DES TESTS =========="
