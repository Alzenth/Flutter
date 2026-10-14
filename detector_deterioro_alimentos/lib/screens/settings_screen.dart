import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _gasThreshold = 280;
  double _tempThreshold = 24;
  bool _telegramNotif = true;
  bool _appPushNotif = false;
  bool _flashEsp32 = true;
  bool _useStaticData = true; // <-- Control de modo testing/datos estáticos

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Text(
            'Configuración',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionHeader('Conectividad'),
        _buildListTile('Wi-Fi', 'Conectado', Icons.wifi, Colors.green),
        _buildListTile('MQTT broker', 'Estado de conectividad', Icons.rss_feed, Colors.grey),
        const SizedBox(height: 16),
        _buildSectionHeader('Umbrales de Alerta'),
        _buildSliderTile('Gas (COV)', '${_gasThreshold.toInt()} ppm', _gasThreshold, 100, 800, (v) {
          setState(() => _gasThreshold = v);
        }),
        _buildSliderTile('Temperatura', '${_tempThreshold.toInt()} °C', _tempThreshold, 10, 40, (v) {
          setState(() => _tempThreshold = v);
        }),
        const SizedBox(height: 16),
        _buildSectionHeader('Notificaciones'),
        _buildSwitchTile('Telegram', _telegramNotif, (v) => setState(() => _telegramNotif = v)),
        _buildSwitchTile('App Push', _appPushNotif, (v) => setState(() => _appPushNotif = v)),
        const SizedBox(height: 16),
        _buildSectionHeader('Hardware'),
        _buildSwitchTile('Flash ESP32-CAM', _flashEsp32, (v) => setState(() => _flashEsp32 = v)),
        const SizedBox(height: 16),
        
        // --- NUEVA SECCIÓN: TESTING ---
        _buildSectionHeader('Testing'),
        _buildSwitchTile(
          'Visualización con datos estáticos',
          _useStaticData,
          (v) => setState(() => _useStaticData = v),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }

  Widget _buildSliderTile(String title, String valueStr, double value, double min, double max, ValueChanged<double> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(valueStr, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF2ECC71),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontSize: 14)),
        value: value,
        activeColor: const Color(0xFF2ECC71),
        onChanged: onChanged,
      ),
    );
  }
}