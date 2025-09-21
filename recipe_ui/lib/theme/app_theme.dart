import 'package:flutter/material.dart';

class AppTheme {
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF4CAF50), // Fresh Green
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF4CAF50),
      secondary: const Color(0xFFFF7043), // Warm Orange
      background: const Color(0xFFFAFAFA), // Off-white background
      surface: const Color(0xFFFFFFFF), // Card surfaces
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: const Color(0xFF212121),
      onSurface: const Color(0xFF212121),
    ),
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF212121), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF757575), fontSize: 14),
      titleLarge: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold, fontSize: 20),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF81C784), // Softer green for dark mode
    colorScheme: ColorScheme.dark().copyWith(
      primary: const Color(0xFF81C784), // Light green
      secondary: const Color(0xFFFFA270), // Lighter orange
      background: const Color(0xFF121212), // Dark background
      surface: const Color(0xFF1E1E1E), // Dark card
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
