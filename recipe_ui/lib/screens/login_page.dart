import 'package:flutter/material.dart';
import 'package:recipe_ui/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLogin = true;
  bool loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    try {
      if (isLogin) {
        final user = await _authService.signIn(
          emailCtrl.text.trim(),
          passCtrl.text.trim(),
        );

        if (user != null && user.emailVerified) {
          if (mounted) {
            Navigator.pushReplacementNamed(context, "/shell");
          }
        } else {
          await _authService.resendVerificationEmail();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please verify your email first.")),
            );
          }
          await _authService.signOut();
        }
      } else {
        await _authService.signUp(emailCtrl.text.trim(), passCtrl.text.trim());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verification email sent!")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _googleSignIn() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Google Sign-in failed: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "Login" : "Sign Up",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: passCtrl,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? "6+ chars required" : null,
                    ),
                    const SizedBox(height: 20),

                    loading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            child: Text(isLogin ? "Login" : "Sign Up"),
                          ),
                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      icon: const Icon(Icons.g_mobiledata),
                      onPressed: _googleSignIn,
                      label: const Text("Sign in with Google"),
                    ),
                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin
                            ? "Don’t have an account? Sign Up"
                            : "Already have an account? Login",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
