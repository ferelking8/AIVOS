import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseAuthService {
  static final SupabaseAuthService _instance = SupabaseAuthService._internal();
  late final SupabaseClient _supabase;
  late final SharedPreferences _prefs;

  factory SupabaseAuthService() {
    return _instance;
  }

  SupabaseAuthService._internal() {
    _supabase = Supabase.instance.client;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===================== AUTHENTICATION =====================

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => _supabase.auth.currentUser != null;

  // Get user email
  String? get userEmail => _supabase.auth.currentUser?.email;

  // LOGIN
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // SIGN UP
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // RESET PASSWORD (Forgot Password)
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.aivo://reset-password',
      );
    } catch (e) {
      rethrow;
    }
  }

  // UPDATE PASSWORD
  Future<void> updatePassword({required String newPassword}) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      rethrow;
    }
  }

  // ===================== FIRST LAUNCH TRACKING =====================

  // Check if this is the first launch
  bool get isFirstLaunch {
    final hasShown = _prefs.getBool('onboarding_shown') ?? false;
    return !hasShown;
  }

  // Mark onboarding as shown
  Future<void> markOnboardingAsShown() async {
    await _prefs.setBool('onboarding_shown', true);
  }

  // Reset onboarding (for testing)
  Future<void> resetOnboarding() async {
    await _prefs.setBool('onboarding_shown', false);
  }

  // ===================== USER PREFERENCES =====================

  // Savoir si l'utilisateur a cliqué SKIP lors du premier lancement
  bool get hasSkippedInitialAuth {
    return _prefs.getBool('skipped_initial_auth') ?? false;
  }

  // Mark that user skipped auth
  Future<void> markSkippedInitialAuth() async {
    await _prefs.setBool('skipped_initial_auth', true);
  }

  // Reset skip flag (for testing)
  Future<void> resetSkipFlag() async {
    await _prefs.setBool('skipped_initial_auth', false);
  }
}
