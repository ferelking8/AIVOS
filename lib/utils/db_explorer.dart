// Script pour explorer la structure Supabase
// À exécuter une fois dans main() pour voir l'état de la DB

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> exploreSupabase() async {
  final client = Supabase.instance.client;

  print('\n\n========== 🔍 SUPABASE DATABASE INSPECTION ==========\n');

  // 1. Tester la connexion
  try {
    final connTest = await client.from('information_schema.tables').select().limit(1);
    print('✅ Connexion à Supabase: OK\n');
  } catch (e) {
    print('❌ Connexion: Échouée - $e\n');
    return;
  }

  // 2. Chercher toutes les tables
  print('📋 TABLES EXISTANTES:\n');

  final tablesList = [
    'products',
    'categories',
    'users',
    'profiles',
    'orders',
    'bookmarks',
    'cart_items'
  ];

  for (String tableName in tablesList) {
    try {
      final response = await client.from(tableName).select('*').limit(1);
      print('✅ $tableName');
      print('   Colonnes: ${(response.isNotEmpty ? (response[0] as Map).keys.toList() : 'VIDE').toString()}');
      print('   Nombre de lignes: ${response.length}');
      if (response.isNotEmpty) {
        print('   Exemple: ${response[0]}');
      }
      print('');
    } catch (e) {
      final errorMsg = e.toString();
      if (errorMsg.contains('does not exist')) {
        print('❌ $tableName (n\'existe pas)');
      } else {
        print('⚠️  $tableName (erreur: ${e.toString().split('\n').first})');
      }
      print('');
    }
  }

  // 3. Check Auth
  print('\n🔐 AUTHENTIFICATION:\n');
  try {
    final user = await client.auth.getUser();
    print('✅ Auth initialisée - User: ${user.user?.email ?? 'Aucun utilisateur connecté'}');
  } catch (e) {
    print('⚠️  Auth check: ${e.toString().split('\n').first}');
  }

  print('\n========== FIN INSPECTION ==========\n');
}
