
import 'dart:math' as math;
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Colors.red,
      const Color.fromARGB(255, 178, 166, 166),
      const Color.fromARGB(255, 147, 118, 118),
      Colors.grey,
    ];
    final radius = size.width * 0.4;
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.5;

    final angle = 2 * math.pi / colors.length;
    var startAngle = -math.pi / 2;

    for (final color in colors) {
      final x = centerX + math.cos(startAngle) * radius;
      final y = centerY + math.sin(startAngle) * radius;

      final paint = Paint()..color = color;
      canvas.drawCircle(Offset(x, y), radius, paint);

      startAngle += angle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// ... (nachfolgender Code)
