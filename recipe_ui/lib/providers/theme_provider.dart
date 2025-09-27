import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF6B3F69); // #6B3F69
  static const Color primary = Color(0xFF8D5F8C);      // #8D5F8C
  static const Color secondary = Color(0xFFA376A2);    // #A376A2
  static const Color accent = Color(0xFFDDC3C3);       // #DDC3C3

  // RGB equivalents
  static const Color rgbPrimaryDark = Color.fromRGBO(107, 63, 105, 1);
  static const Color rgbPrimary = Color.fromRGBO(141, 95, 140, 1);
  static const Color rgbSecondary = Color.fromRGBO(163, 118, 162, 1);
  static const Color rgbAccent = Color.fromRGBO(221, 195, 195, 1);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.accent,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.accent,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  );
}
