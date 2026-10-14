import 'package:flutter/material.dart';
import '../services/sensor_service.dart';
import '../widgets/gauge_painter.dart';

class StatusScreen extends StatelessWidget {
  final AppState appState;

  const StatusScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final data = appState.currentData;
    final isStatic = appState.useStaticData;
    final isConnected = appState.isConnected;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detector Inteligente',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: isStatic
                            ? Colors.blue
                            : (isConnected ? Colors.green : Colors.red),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isStatic
                            ? 'Modo Estático (Testing)'
                            : (isConnected
                                ? 'Conectado a ESP32 (${appState.esp32Ip})'
                                : 'Desconectado de ESP32'),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.account_circle, size: 32),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tarjeta principal con Medidor (Gauge)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2630),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: GaugePainter(value: data.gasPpm / 1000.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'ESTADO:\n${data.estado}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: data.estado == 'CRÍTICO'
                                  ? const Color(0xFFE74C3C)
                                  : const Color(0xFF2ECC71),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${data.gasPpm.toInt()} ppm',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'COV Gas',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.videocam, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('OV2640 Cam', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Métricas de Temperatura y Humedad
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Temperatura:',
                  value: '${data.temperatura.toStringAsFixed(1)} °C',
                  icon: Icons.thermostat,
                  color: const Color(0xFFD35400),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'Humedad:',
                  value: '${data.humedad.toInt()}%',
                  icon: Icons.water_drop,
                  color: const Color(0xFF2980B9),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Banner de Alerta
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: data.estado == 'CRÍTICO'
                  ? const Color(0xFF5C1D24)
                  : const Color(0xFF1E3A2B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: data.estado == 'CRÍTICO'
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFF2ECC71),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  data.estado == 'CRÍTICO'
                      ? Icons.warning_amber_rounded
                      : Icons.check_circle_outline,
                  color: data.estado == 'CRÍTICO'
                      ? const Color(0xFFE74C3C)
                      : const Color(0xFF2ECC71),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.alertaMensaje,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const Text(
                        'Telegram/Cloud sync',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const Spacer(),
              Icon(icon, color: color, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}