# Configuration Supabase AIVOS

## ✅ Étapes complétées

### 1. Dépendances ajoutées (`pubspec.yaml`)
- `supabase_flutter: ^2.5.0` - Client Supabase officiel
- `flutter_dotenv: ^5.1.0` - Gestion des variables d'environnement
- `.env` ajouté aux assets Flutter

### 2. Variables d'environnement (`.env`)
```
SUPABASE_URL=https://sbgstgpacvyomuimcfem.supabase.co
SUPABASE_PUBLISH_KEY=sb_publishable_A_ZRr5De8Tg_-FLP5AvVeA_TRHJejH0
```

**Note de sécurité:**
- ✅ La clé publique (`SUPABASE_PUBLISH_KEY`) est utilisée côté client
- ✅ C'est la bonne approche moderne (pas d'anon secret)
- ⚠️ N'ajoute jamais le SERVICE_ROLE en .env côté client

### 3. Initialisation Supabase
- `main.dart` initialise Supabase avec `await Supabase.initialize()`
- Database structure auto-explorée au démarrage

### 4. Service Supabase (`lib/services/supabase_service.dart`)
Singleton pour accéder à tous les données:
- `getPopularProducts()` - Récupère produits populaires
- `getFlashSaleProducts()` - Produits en promotion
- `getBestSellersProducts()` - Bestsellers
- `getProductsByCategory(id)` - Produits par catégorie
- `getCategories()` - Toutes les catégories
- `searchProducts(query)` - Recherche

### 5. Modèles mis à jour
- `ProductModel` - Ajouté `fromJson()` et `toJson()` pour Supabase
- `CategoryModel` - Ajouté `fromJson()` et `toJson()` pour Supabase
- Support de la sérialisation JSON

## 🚀 Prochaines étapes

### Étape 1: Vérifier la structure Supabase
```bash
flutter pub get
flutter run
```

Regarde la console au démarrage. Tu verras:
```
========== 🔍 SUPABASE DATABASE INSPECTION ==========

📋 TABLES EXISTANTES:

✅ products
   Colonnes: [id, title, brand_name, price, ...]

❌ categories (n'existe pas)
```

### Étape 2: Créer les tables (si manquantes)

**Via Supabase Dashboard:**
1. Va sur https://app.supabase.com
2. Sélectionne le projet `sbgstgpacvyomuimcfem`
3. SQL Editor → Crée les tables

**Table `products`:**
```sql
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  brand_name TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  price_after_discount DECIMAL(10,2),
  discount_percent INTEGER,
  image TEXT,
  category_id UUID REFERENCES categories(id),
  collection_type TEXT, -- 'popular', 'flash_sale', 'best_sellers', 'kids'
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Table `categories`:**
```sql
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  image TEXT,
  svg_src TEXT,
  parent_category_id UUID REFERENCES categories(id),
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Étape 3: Remplir les tables
Une fois créées, insère les données des mocks en Supabase.

### Étape 4: Remplacer les mocks dans l'app
Une fois Supabase rempli, remplace:
- `popular_products.dart` - Utilise `SupabaseService.getPopularProducts()`
- `flash_sale.dart` - Utilise `SupabaseService.getFlashSaleProducts()`
- `best_sellers.dart` - Utilise `SupabaseService.getBestSellersProducts()`
- `categories.dart` - Utilise `SupabaseService.getCategories()`
- etc.

## 📝 Fichiers modifiés

```
✅ pubspec.yaml - Dépendances Supabase
✅ lib/main.dart - Initialisation Supabase + exploration DB
✅ lib/.env - Configuration (URL + Publish Key)
✅ lib/models/product_model.dart - fromJson/toJson pour Supabase
✅ lib/models/category_model.dart - fromJson/toJson pour Supabase
✅ lib/services/supabase_service.dart - Service données (NEW)
✅ lib/utils/db_explorer.dart - Exploration DB (NEW)
```

## 🔒 Sécurité

- ✅ Utilise la **Publish Key** (public, côté client)
- ✅ Pas d'anon secret hérité
- ✅ RLS (Row Level Security) recommandé dans Supabase

## 💡 Utilisation

```dart
// Récupérer les produits populaires
final supabase = SupabaseService();
final products = await supabase.getPopularProducts();

// Afficher dans le UI
for (var product in products) {
  print('${product.title} - \$${product.price}');
}
```

## ⚠️ Prochaine action

**Dis-moi ici ce que voit dans la console au démarrage après `flutter run`.**

Cela me permettra de:
1. Voir quelles tables existent déjà
2. Voir leur structure exacte
3. Adapter le code en fonction

Puis je remplacerai TOUS les mocks d'une traite! 🚀
