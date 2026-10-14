import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'services/sensor_service.dart';

void main() {
  runApp(const FoodDetectorApp());
}

class FoodDetectorApp extends StatefulWidget {
  const FoodDetectorApp({super.key});

  @override
  State<FoodDetectorApp> createState() => _FoodDetectorAppState();
}

class _FoodDetectorAppState extends State<FoodDetectorApp> {
  final AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'Detector Inteligente de Alimentos',
          debugShowCheckedModeBanner: false,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF4F6F8),
            cardColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2ECC71),
              secondary: Color(0xFFE74C3C),
              surface: Colors.white,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF12181F),
            cardColor: const Color(0xFF1E2630),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF2ECC71),
              secondary: Color(0xFFE74C3C),
              surface: Color(0xFF1E2630),
            ),
          ),
          home: MainScreen(appState: appState),
        );
      },
    );
  }
}