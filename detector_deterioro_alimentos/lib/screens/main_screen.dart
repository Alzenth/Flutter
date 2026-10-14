import 'package:flutter/material.dart';
import '../services/sensor_service.dart';
import 'status_screen.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  final AppState appState;

  const MainScreen({super.key, required this.appState});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      StatusScreen(appState: widget.appState),
      SettingsScreen(appState: widget.appState),
      const HistoryScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF18202A),
        selectedItemColor: const Color(0xFF2ECC71),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Estado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}