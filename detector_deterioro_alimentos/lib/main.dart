import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const FoodDetectorApp());
}

class FoodDetectorApp extends StatelessWidget {
  const FoodDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detector Inteligente de Alimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF12181F),
        cardColor: const Color(0xFF1E2630),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2ECC71),
          secondary: Color(0xFFE74C3C),
          surface: Color(0xFF1E2630),
        ),
      ),
      home: const MainScreen(),
    );
  }
}