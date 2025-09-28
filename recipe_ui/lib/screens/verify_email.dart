import 'package:flutter/material.dart';
import 'package:recipe_ui/services/auth_service.dart';

// To check if email is verified or not and resend verification email if needed
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final AuthService _authService = AuthService();
  bool loading = false;

  Future<void> _checkVerified() async {
    setState(() => loading = true);
    final verified = await _authService.checkEmailVerified();
    setState(() => loading = false);

    if (verified && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A verification email has been sent.\nPlease check your inbox or spam folder.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.resendVerificationEmail();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Verification email resent!"),
                          ),
                        );
                      }
                    },
                    child: const Text("Resend Email"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkVerified,
                    child: const Text("I have verified, Continue"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                      if (mounted) {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: const Text("Back to Login"),
                  ),
                ],
              ),
      ),
    );
  }
}
