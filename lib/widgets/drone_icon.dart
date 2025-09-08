import 'package:flutter/material.dart';

class DroneIcon extends StatelessWidget {
  final double size;
  final Color color;
  final bool isAnimated;

  const DroneIcon({
    super.key,
    this.size = 60.0,
    this.color = Colors.white,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: DroneIconPainter(color: color, isAnimated: isAnimated),
    );
  }
}

class DroneIconPainter extends CustomPainter {
  final Color color;
  final bool isAnimated;

  DroneIconPainter({required this.color, this.isAnimated = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double armLength = size.width * 0.35;
    final double propellerRadius = size.width * 0.08;

    // Draw drone body (center)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: size.width * 0.3,
        height: size.height * 0.15,
      ),
      fillPaint,
    );

    // Draw arms
    final List<Offset> armPositions = [
      Offset(centerX - armLength, centerY - armLength), // Top-left
      Offset(centerX + armLength, centerY - armLength), // Top-right
      Offset(centerX - armLength, centerY + armLength), // Bottom-left
      Offset(centerX + armLength, centerY + armLength), // Bottom-right
    ];

    for (final armPos in armPositions) {
      // Draw arm
      canvas.drawLine(Offset(centerX, centerY), armPos, paint);

      // Draw propeller
      canvas.drawCircle(armPos, propellerRadius, paint);

      // Draw propeller blades
      canvas.drawLine(
        Offset(armPos.dx - propellerRadius * 0.7, armPos.dy),
        Offset(armPos.dx + propellerRadius * 0.7, armPos.dy),
        paint,
      );
      canvas.drawLine(
        Offset(armPos.dx, armPos.dy - propellerRadius * 0.7),
        Offset(armPos.dx, armPos.dy + propellerRadius * 0.7),
        paint,
      );
    }

    // Draw camera/gimbal (optional detail)
    canvas.drawCircle(
      Offset(centerX, centerY + size.height * 0.1),
      size.width * 0.04,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
