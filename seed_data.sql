-- Script pour remplir les tables Supabase avec les données de mocks

-- 1. Vider les tables (si nécessaire)
DELETE FROM products;
DELETE FROM categories;

-- 2. Insérer les catégories
INSERT INTO categories (title, image, svg_src) VALUES
('Woman''s', 'https://i.imgur.com/5M89G2P.png', NULL),
('Man''s', 'https://i.imgur.com/UM3GdWg.png', NULL),
('Kid''s', 'https://i.imgur.com/Lp0D6k5.png', NULL),
('Accessories', 'https://i.imgur.com/3mSE5sN.png', NULL);

-- 3. Insérer les produits (demoPopularProducts, demoFlashSaleProducts, demoBestSellersProducts)
-- Les données des mocks Flutter
INSERT INTO products (title, brand_name, price, price_after_discount, discount_percent, image, collection_type) VALUES
-- Popular Products
('Mountain Warehouse for Women', 'Lipsy london', 540, 420, 20, 'https://i.imgur.com/productDemoImg1.png', 'popular'),
('Mountain Beta Warehouse', 'Lipsy london', 800, NULL, NULL, 'https://i.imgur.com/productDemoImg4.png', 'popular'),
('FS - Nike Air Max 270 Really React', 'Lipsy london', 650.62, 390.36, 40, 'https://i.imgur.com/productDemoImg5.png', 'popular'),
('Green Poplin Ruched Front', 'Lipsy london', 1264, 1200.8, 5, 'https://i.imgur.com/productDemoImg6.png', 'popular'),
('Green Poplin Ruched Front', 'Lipsy london', 650.62, 390.36, 40, 'https://i.imgur.com/tXyOMMG.png', 'popular'),
('white satin corset top', 'Lipsy london', 1264, 1200.8, 5, 'https://i.imgur.com/h2LqppX.png', 'popular'),

-- Flash Sale Products
('FS - Nike Air Max 270 Really React', 'Lipsy london', 650.62, 390.36, 40, 'https://i.imgur.com/productDemoImg5.png', 'flash_sale'),
('Green Poplin Ruched Front', 'Lipsy london', 1264, 1200.8, 5, 'https://i.imgur.com/productDemoImg6.png', 'flash_sale'),
('Mountain Beta Warehouse', 'Lipsy london', 800, 680, 15, 'https://i.imgur.com/productDemoImg4.png', 'flash_sale'),

-- Best Sellers Products
('Green Poplin Ruched Front', 'Lipsy london', 650.62, 390.36, 40, 'https://i.imgur.com/tXyOMMG.png', 'best_sellers'),
('white satin corset top', 'Lipsy london', 1264, 1200.8, 5, 'https://i.imgur.com/h2LqppX.png', 'best_sellers'),
('Mountain Beta Warehouse', 'Lipsy london', 800, 680, 15, 'https://i.imgur.com/productDemoImg4.png', 'best_sellers'),

-- Kids Products
('Green Poplin Ruched Front', 'Lipsy london', 650.62, 590.36, 24, 'https://i.imgur.com/dbbT6PA.png', 'kids'),
('Printed Sleeveless Tiered Swing Dress', 'Lipsy london', 650.62, NULL, NULL, 'https://i.imgur.com/7fSxC7k.png', 'kids'),
('Ruffle-Sleeve Ponte-Knit Sheath', 'Lipsy london', 400, NULL, NULL, 'https://i.imgur.com/pXnYE9Q.png', 'kids'),
('Green Mountain Beta Warehouse', 'Lipsy london', 400, 360, 20, 'https://i.imgur.com/V1MXgfa.png', 'kids'),
('Printed Sleeveless Tiered Swing Dress', 'Lipsy london', 654, NULL, NULL, 'https://i.imgur.com/8gvE5Ss.png', 'kids'),
('Mountain Beta Warehouse', 'Lipsy london', 250, NULL, NULL, 'https://i.imgur.com/cBvB5YB.png', 'kids');
