import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Historial de Eventos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          ],
        ),
        const SizedBox(height: 12),
        // Gráfico simulado
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tendencia de Gases (24h)', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 16),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black12,
                child: const Center(
                  child: Icon(Icons.show_chart, color: Color(0xFF2ECC71), size: 60),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildHistoryItem('08:14', 'Carne - Descomposición (650 ppm)', Colors.red, true),
        _buildHistoryItem('Ayer', 'Fruta - Inicio de Deterioro (280 ppm)', Colors.orange, false),
        _buildHistoryItem('Ayer', 'Fruta - Estado Normal (120 ppm)', Colors.green, false),
      ],
    );
  }

  Widget _buildHistoryItem(String time, String description, Color color, bool hasImage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              time,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          if (hasImage)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.image, size: 20, color: Colors.white70),
            )
        ],
      ),
    );
  }
}