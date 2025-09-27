import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool isLogin = true; // toggle login/signup
  bool loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );
      }

      // Get token & send to backend
      final token = await _auth.currentUser?.getIdToken();
      debugPrint("Firebase Token: $token");

      // TODO: Call backend with this token
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() => loading = false);
  }

  
  Future<void> _googleSignIn() async {
  try {
    // Always use the package's constructor
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    // Start sign-in flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return; // user canceled

    // Get authentication object
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    debugPrint("Google Firebase Token: $token");
  } catch (e) {
    debugPrint("Google Sign-in failed: $e");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Google Sign-in failed: $e")));
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(isLogin ? "Login" : "Sign Up",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 20),

                    // Email field
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                    ),
                    const SizedBox(height: 10),

                    // Password field
                    TextFormField(
                      controller: passCtrl,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? "6+ chars required" : null,
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    loading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            child: Text(isLogin ? "Login" : "Sign Up"),
                          ),
                    const SizedBox(height: 10),

                    // Google Sign-in
                    OutlinedButton.icon(
                      icon: const Icon(Icons.g_mobiledata),
                      onPressed: _googleSignIn,
                      label: const Text("Sign in with Google"),
                    ),
                    const SizedBox(height: 10),

                    // Toggle Login/Signup
                    TextButton(
                      onPressed: () =>
                          setState(() => isLogin = !isLogin),
                      child: Text(isLogin
                          ? "Don’t have an account? Sign Up"
                          : "Already have an account? Login"),
                    )
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
