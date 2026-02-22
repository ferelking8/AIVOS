-- ========== DÉCOUVERTE STRUCTURE ET REMPLISSAGE SUPABASE ==========

-- ========== 1. VOIR LA STRUCTURE EXACTE DES TABLES ==========

-- Structure de CATEGORIES
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'categories' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Structure de PRODUCTS
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'products' AND table_schema = 'public'
ORDER BY ordinal_position;

-- ========== 2. REMPLIR LES CATÉGORIES ==========

INSERT INTO categories (name, description) VALUES
('Woman''s', 'Women clothing and accessories'),
('Man''s', 'Men clothing and accessories'),
('Kid''s', 'Kids clothing and accessories'),
('Accessories', 'Fashion accessories')
ON CONFLICT DO NOTHING;

-- ========== 3. REMPLIR LES PRODUITS ==========

-- Popular Products
INSERT INTO products (title, price) VALUES
('Mountain Warehouse for Women', 540),
('Mountain Beta Warehouse', 800),
('FS - Nike Air Max 270 Really React', 650.62),
('Green Poplin Ruched Front', 1264),
('white satin corset top', 1264)
ON CONFLICT DO NOTHING;

-- Flash Sale Products
INSERT INTO products (title, price) VALUES
('Flash Sale - Nike Air Max 270', 650.62),
('Flash Sale - Green Poplin', 1264),
('Flash Sale - Mountain Warehouse', 800)
ON CONFLICT DO NOTHING;

-- Best Sellers Products
INSERT INTO products (title, price) VALUES
('Best Seller - Green Poplin', 650.62),
('Best Seller - Satin Corset', 1264),
('Best Seller - Mountain Warehouse', 800)
ON CONFLICT DO NOTHING;

-- Kids Products
INSERT INTO products (title, price) VALUES
('Kids - Green Poplin', 650.62),
('Kids - Sleeveless Dress', 650),
('Kids - Ponte Sheath', 400),
('Kids - Mountain Beta', 400),
('Kids - Tiered Swing', 654),
('Kids - Beta Warehouse', 250)
ON CONFLICT DO NOTHING;

-- Vérifier les données
SELECT COUNT(*) as total_products FROM products;
SELECT COUNT(*) as total_categories FROM categories;