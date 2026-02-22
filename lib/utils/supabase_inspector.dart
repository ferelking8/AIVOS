import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> inspectSupabaseDatabase() async {
  final client = Supabase.instance.client;

  try {
    // Récupérer info sur les tables via information_schema
    final tablesResponse = await client.from('information_schema.tables').select(
      'table_name, table_schema',
    ).eq('table_schema', 'public');

    print('=== TABLES DANS SUPABASE ===');
    print(tablesResponse);

    // Pour chaque table, afficher sa structure
    for (var tableInfo in tablesResponse as List) {
      final tableName = tableInfo['table_name'];
      print('\n📦 TABLE: $tableName');

      final columnsResponse =
          await client.from('information_schema.columns').select(
        'column_name, data_type, is_nullable',
      ).eq('table_name', tableName);

      for (var col in columnsResponse as List) {
        print('  - ${col['column_name']} (${col['data_type']}) ${col['is_nullable'] == 'NO' ? '[NOT NULL]' : '[NULL]'}');
      }
    }
  } catch (e) {
    print('Erreur: $e');
    print('\n⚠️ Alternative: Essayons de lire directement depuis les tables principales...');

    // Essai direct
    try {
      final products = await client.from('products').select('*').limit(1);
      print('\n✅ TABLE: products (existe)');
      if (products.isNotEmpty) {
        print('Colonnes: ${(products[0] as Map).keys.toList()}');
      }
    } catch (_) {
      print('\n❌ TABLE: products (n\'existe pas)');
    }

    try {
      final categories = await client.from('categories').select('*').limit(1);
      print('\n✅ TABLE: categories (existe)');
      if (categories.isNotEmpty) {
        print('Colonnes: ${(categories[0] as Map).keys.toList()}');
      }
    } catch (_) {
      print('\n❌ TABLE: categories (n\'existe pas)');
    }

    try {
      final users = await client.from('profiles').select('*').limit(1);
      print('\n✅ TABLE: profiles (existe)');
      if (users.isNotEmpty) {
        print('Colonnes: ${(users[0] as Map).keys.toList()}');
      }
    } catch (_) {
      print('\n❌ TABLE: profiles (n\'existe pas)');
    }

    try {
      final auth = await client.auth.getUser();
      print('\n✅ Auth: Configurée');
    } catch (_) {
      print('\n⚠️ Auth: Pas initialisée');
    }
  }
}
