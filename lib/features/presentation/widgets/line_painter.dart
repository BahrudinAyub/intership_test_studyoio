import 'package:flutter/material.dart';
import 'dart:math';

class LinePainter extends CustomPainter {
  final Offset? start;
  final Offset? end;
  final double boxSize;
  final bool isDragged; // Tambahkan flag untuk mengontrol visibilitas panah

  LinePainter(this.start, this.end, {this.boxSize = 50.0, this.isDragged = false});


    @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null || isDragged) return; // Tambahkan kondisi isDragged

    // Sisanya tetap sama...


    // Ukuran panah dan garis yang menyesuaikan dengan jarak
    final distance = (start! - end!).distance;
    final shorteningFactor = distance < 100 ? 0.8 : 0.5;

    // Adjusting the end position to move the arrow into the box
    final adjustedEnd = Offset(
      end!.dx + boxSize / 4, // Geser ke kanan dengan menambah nilai pada dx
      end!.dy - boxSize / 1.0,
    );

    final adjustedStart = Offset(
      start!.dx + (adjustedEnd.dx - start!.dx) * shorteningFactor,
      start!.dy + (adjustedEnd.dy - start!.dy) * shorteningFactor,
    );

    // Calculate the midpoint and control point for the curve
    final midPoint = Offset(
      (adjustedStart.dx + adjustedEnd.dx) / 2,
      (adjustedStart.dy + adjustedEnd.dy) / 2,
    );

    final controlPoint = Offset(
      midPoint.dx,
      midPoint.dy -
          100 * (distance / 400), // Mengurangi tinggi kurva saat jarak mengecil
    );

    // Draw the curved path
    final path = Path()
      ..moveTo(adjustedStart.dx, adjustedStart.dy)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        adjustedEnd.dx,
        adjustedEnd.dy,
      );

    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth =
          5.0 * (distance / 200) // Menyesuaikan ketebalan garis dengan jarak
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    // Draw the arrow pointing into the box
    final arrowSize =
        15.0 * (distance / 200); // Menyesuaikan ukuran panah dengan jarak
    final lineDirection = (adjustedEnd - adjustedStart).direction;
    final arrowAngle = pi / 6;

    final arrowPath = Path()
      ..moveTo(adjustedEnd.dx, adjustedEnd.dy)
      ..lineTo(
        adjustedEnd.dx - arrowSize * cos(lineDirection - arrowAngle),
        adjustedEnd.dy - arrowSize * sin(lineDirection - arrowAngle),
      )
      ..moveTo(adjustedEnd.dx, adjustedEnd.dy)
      ..lineTo(
        adjustedEnd.dx - arrowSize * cos(lineDirection + arrowAngle),
        adjustedEnd.dy - arrowSize * sin(lineDirection + arrowAngle),
      );

    final arrowPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth =
          5.0 * (distance / 200) // Menyesuaikan ketebalan panah dengan jarak
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
