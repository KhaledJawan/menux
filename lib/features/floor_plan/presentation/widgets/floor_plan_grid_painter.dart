import 'package:flutter/material.dart';

/// Subtle dot grid drawn behind the tables — a visual reference for
/// placement, not a hard boundary. Kept faint so it never competes with the
/// tables themselves for attention.
class FloorPlanGridPainter extends CustomPainter {
  const FloorPlanGridPainter({required this.gridSize, required this.color});

  final double gridSize;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double x = 0; x <= size.width; x += gridSize) {
      for (double y = 0; y <= size.height; y += gridSize) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant FloorPlanGridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize || oldDelegate.color != color;
  }
}
