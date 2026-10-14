import 'dart:math';
import 'package:flutter/material.dart';

class GaugePainter extends CustomPainter {
  final double value; // Valor normalizado de 0.0 a 1.0

  GaugePainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // Definimos el centro relativo al tamaño del contenedor
    final center = Offset(size.width / 2, size.height * 0.7);
    // Calculamos el radio limitándolo por ancho o alto para evitar desbordamiento
    final radius = min(size.width / 2.2, size.height * 0.65);

    const strokeWidth = 14.0;

    final bgPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final arcRect = Rect.fromCircle(center: center, radius: radius);

    final gradientPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFF2ECC71), Color(0xFFF1C40F), Color(0xFFE74C3C)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Arco base de 180° (de pi a 2*pi)
    canvas.drawArc(
      arcRect,
      pi,
      pi,
      false,
      bgPaint,
    );

    // Arco de valor (se dibuja según el porcentaje del valor recibido)
    canvas.drawArc(
      arcRect,
      pi,
      pi * value.clamp(0.0, 1.0),
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}