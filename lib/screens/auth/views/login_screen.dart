import 'package:flutter/material.dart';
import 'package:aivo/constants.dart';
import 'package:aivo/route/route_constants.dart';
import 'package:aivo/services/supabase_auth_service.dart';

import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  final GlobalKey _formWidgetKey = GlobalKey();

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: errorColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final state = _formWidgetKey.currentState as dynamic;
    final email = state?.email ?? '';
    final password = state?.password ?? '';

    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar('Please fill in all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = SupabaseAuthService();
      await authService.login(email: email, password: password);

      _showSuccessSnackBar('Login successful!');

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        entryPointScreenRoute,
        ModalRoute.withName(logInScreenRoute),
      );
    } catch (e) {
      final errorMessage = e.toString();
      setState(() {
        _errorMessage = errorMessage;
      });
      _showErrorSnackBar('Login failed: $errorMessage');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleSkip() async {
    final authService = SupabaseAuthService();
    await authService.markSkippedInitialAuth();

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      entryPointScreenRoute,
      ModalRoute.withName(logInScreenRoute),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _handleSkip,
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you intered during your registration.",
                  ),
                  const SizedBox(height: defaultPadding),

                  // Error message
                  if (_errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      margin: const EdgeInsets.only(bottom: defaultPadding),
                      decoration: BoxDecoration(
                        color: errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: errorColor),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: errorColor,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  LogInForm(key: _formWidgetKey, formKey: _formKey, formWidgetKey: _formWidgetKey),
                  Align(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, passwordRecoveryScreenRoute);
                            },
                      child: const Text("Forgot password?"),
                    ),
                  ),
                  SizedBox(
                    height: size.height > 700
                        ? size.height * 0.1
                        : defaultPadding,
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Log in"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pushNamed(context, signUpScreenRoute);
                              },
                        child: const Text("Sign up"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
