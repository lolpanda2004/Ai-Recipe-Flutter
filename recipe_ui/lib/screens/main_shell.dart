import 'package:flutter/material.dart';
import 'package:recipe_ui/screens/home_page.dart';
import 'package:recipe_ui/screens/fridge_page.dart';
import 'package:recipe_ui/screens/history_page.dart';
import 'package:recipe_ui/providers/theme_provider.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 1; // middle page by default

  final List<Widget> _pages = const [
    FridgePage(),
    HomePage(), // Ask a Recipe
    HistoryPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        backgroundColor: AppColors.accent,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: "Fridge"),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Ask",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
