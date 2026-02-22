-- ========== STRUCTURE COMPLÈTE DES TABLES ==========

-- Affiche toutes les colonnes de CATEGORIES
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'categories' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Affiche toutes les colonnes de PRODUCTS
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'products' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Affiche toutes les colonnes de ORDERS
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'orders' AND table_schema = 'public'
ORDER BY ordinal_position;