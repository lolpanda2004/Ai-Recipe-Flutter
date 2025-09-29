import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_ui/providers/theme_provider.dart';
import 'package:recipe_ui/screens/splash_wrapper';
import 'package:recipe_ui/screens/main_shell.dart';
import 'package:recipe_ui/screens/login_page.dart';
import 'package:recipe_ui/screens/verify_email.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load env file
  try {
    await dotenv.load(fileName: ".env");
    // print("🔑 GROQ_API_KEY: ${dotenv.env['GROQ_API_KEY']}");
  } catch (e) {}

  // Init Firebase
  await Firebase.initializeApp();

  runApp(const FoodEyApp());
}

class FoodEyApp extends StatelessWidget {
  const FoodEyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food-ey',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashWrapper(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/verify': (context) => const VerifyEmailPage(),
        '/shell': (context) => const MainShell(),
      },
    );
  }
}
