import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipe_ui/screens/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // List of food-themed icons
  static const List<IconData> foodIcons = [
    Icons.fastfood,
    Icons.local_pizza,
    Icons.ramen_dining,
    Icons.icecream,
    Icons.coffee,
    Icons.lunch_dining,
    Icons.set_meal,
    Icons.local_dining,
  ];

  // Randomly pick one icon
  IconData get randomFoodIcon {
    final random = Random();
    return foodIcons[random.nextInt(foodIcons.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title in the middle
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Food-ey!",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Icon(
                      randomFoodIcon,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            // Continue button at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
//                     Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(builder: (context) => const LoginPage()),
// );

                    // inside ElevatedButton onPressed:
                    print("✅ Get Started pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("Get Started"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
