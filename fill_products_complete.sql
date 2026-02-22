-- ========== REMPLISSAGE COMPLET DES PRODUITS AVEC IMAGES ET DONNÉES ==========

-- Récupérer les IDs des catégories pour les références
WITH cat_ids AS (
  SELECT id as woman_id FROM categories WHERE name = 'Woman''s' LIMIT 1
),

-- Insérer tous les produits avec les bonnes colonnes
insert_products AS (
  INSERT INTO products (
    title,
    description,
    brand,
    price,
    currency,
    stock,
    active,
    image_url,
    tags,
    category_id
  ) VALUES
  -- ========== POPULAR PRODUCTS ==========
  ('Mountain Warehouse for Women', 'Premium women''s mountain jacket', 'Lipsy london', 540, 'USD', 15, true, 'https://i.imgur.com/productDemoImg1.png', ARRAY['popular', 'women', 'jacket']::text[], (SELECT woman_id FROM cat_ids)),
  ('Mountain Beta Warehouse', 'Modern mountain beta style', 'Lipsy london', 800, 'USD', 8, true, 'https://i.imgur.com/productDemoImg4.png', ARRAY['popular', 'men', 'jacket']::text[], NULL),
  ('FS - Nike Air Max 270 Really React', 'Iconic Nike sneaker with React technology', 'Nike', 650.62, 'USD', 20, true, 'https://i.imgur.com/productDemoImg5.png', ARRAY['popular', 'sneakers', 'men']::text[], NULL),
  ('Green Poplin Ruched Front', 'Elegant green dress with ruched details', 'Lipsy london', 1264, 'USD', 5, true, 'https://i.imgur.com/productDemoImg6.png', ARRAY['popular', 'dress', 'women']::text[], (SELECT woman_id FROM cat_ids)),
  ('White Satin Corset Top', 'Luxurious white satin corset', 'Lipsy london', 1264, 'USD', 12, true, 'https://i.imgur.com/h2LqppX.png', ARRAY['popular', 'top', 'women']::text[], (SELECT woman_id FROM cat_ids)),

  -- ========== FLASH SALE PRODUCTS ==========
  ('Flash Sale - Nike Max React', 'Limited time - Nike Air Max 270', 'Nike', 390.36, 'USD', 50, true, 'https://i.imgur.com/productDemoImg5.png', ARRAY['flash_sale', 'sneakers', 'limited']::text[], NULL),
  ('Flash Sale - Green Poplin', 'Flash sale price - Green elegant dress', 'Lipsy london', 1200.80, 'USD', 30, true, 'https://i.imgur.com/productDemoImg6.png', ARRAY['flash_sale', 'dress', 'limited']::text[], (SELECT woman_id FROM cat_ids)),
  ('Flash Sale - Mountain Warehouse', 'Limited offer - Mountain jacket', 'Lipsy london', 680, 'USD', 25, true, 'https://i.imgur.com/productDemoImg4.png', ARRAY['flash_sale', 'jacket', 'limited']::text[], NULL),

  -- ========== BEST SELLERS ==========
  ('Best Seller - Green Poplin', 'Most popular green dress', 'Lipsy london', 650.62, 'USD', 100, true, 'https://i.imgur.com/tXyOMMG.png', ARRAY['bestseller', 'dress', 'women']::text[], (SELECT woman_id FROM cat_ids)),
  ('Best Seller - Satin Corset', 'Customer favorite - Satin corset', 'Lipsy london', 1264, 'USD', 80, true, 'https://i.imgur.com/h2LqppX.png', ARRAY['bestseller', 'top', 'women']::text[], (SELECT woman_id FROM cat_ids)),
  ('Best Seller - Mountain Warehouse', 'Top rated mountain jacket', 'Lipsy london', 800, 'USD', 60, true, 'https://i.imgur.com/productDemoImg4.png', ARRAY['bestseller', 'jacket', 'men']::text[], NULL),

  -- ========== KIDS PRODUCTS ==========
  ('Kids - Green Poplin Dress', 'Colorful dress for kids', 'Lipsy london', 650.62, 'USD', 40, true, 'https://i.imgur.com/dbbT6PA.png', ARRAY['kids', 'dress', 'girls']::text[], NULL),
  ('Kids - Sleeveless Tiered Dress', 'Cute tiered dress for children', 'Lipsy london', 650.62, 'USD', 35, true, 'https://i.imgur.com/7fSxC7k.png', ARRAY['kids', 'dress', 'girls']::text[], NULL),
  ('Kids - Ruffle Sleeve Dress', 'Playful ruffle sleeve design', 'Lipsy london', 400, 'USD', 50, true, 'https://i.imgur.com/pXnYE9Q.png', ARRAY['kids', 'dress', 'girls']::text[], NULL),
  ('Kids - Green Mountain Warehouse', 'Outdoor kids jacket', 'Lipsy london', 400, 'USD', 45, true, 'https://i.imgur.com/V1MXgfa.png', ARRAY['kids', 'jacket', 'boys']::text[], NULL),
  ('Kids - Printed Sleeveless Dress', 'Fun printed design for kids', 'Lipsy london', 654, 'USD', 38, true, 'https://i.imgur.com/8gvE5Ss.png', ARRAY['kids', 'dress', 'girls']::text[], NULL),
  ('Kids - Beta Warehouse Jacket', 'Durable kids mountain jacket', 'Lipsy london', 250, 'USD', 55, true, 'https://i.imgur.com/cBvB5YB.png', ARRAY['kids', 'jacket', 'unisex']::text[], NULL)
  ON CONFLICT DO NOTHING
)

SELECT 'Insertion complete!' as status;

-- Vérifier le résultat
SELECT COUNT(*) as total_products FROM products;
SELECT COUNT(*) as categories_with_products FROM (
  SELECT DISTINCT category_id FROM products WHERE category_id IS NOT NULL
);