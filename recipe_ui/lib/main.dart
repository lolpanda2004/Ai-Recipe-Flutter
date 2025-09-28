import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_ui/providers/theme_provider.dart';
import 'package:recipe_ui/screens/splash_wrapper';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/verify': (context) => const VerifyEmailPage(),
      },
    );
  }
}
