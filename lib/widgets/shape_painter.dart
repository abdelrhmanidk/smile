import 'dart:math';
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  final String shape;
  final double animationValue;

  ShapePainter({required this.shape, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * animationValue;

    switch (shape) {
      case 'دائرة':
        canvas.drawCircle(center, radius, paint);
        break;
      case 'مربع':
        canvas.drawRect(
          Rect.fromCenter(
            center: center,
            width: radius * 2,
            height: radius * 2,
          ),
          paint,
        );
        break;
      case 'مثلث':
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy + radius)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'مستطيل':
        canvas.drawRect(
          Rect.fromCenter(
            center: center,
            width: radius * 2,
            height: radius,
          ),
          paint,
        );
        break;
      case 'بيضاوي':
        canvas.drawOval(
          Rect.fromCenter(
            center: center,
            width: radius * 2,
            height: radius,
          ),
          paint,
        );
        break;
      case 'خماسي':
        _drawPolygon(canvas, center, radius, 5, paint);
        break;
      case 'سداسي':
        _drawPolygon(canvas, center, radius, 6, paint);
        break;
      case 'سباعي':
        _drawPolygon(canvas, center, radius, 7, paint);
        break;
      case 'نجمة':
        _drawStar(canvas, center, radius, paint);
        break;
      case 'معين':
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy)
          ..lineTo(center.dx, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'قلب':
        _drawHeart(canvas, center, radius, paint);
        break;
      case 'أسطوانة':
        _drawCylinder(canvas, center, radius, paint);
        break;
      default:
        break;
    }
  }

  void _drawPolygon(
      Canvas canvas, Offset center, double radius, int sides, Paint paint) {
    final path = Path();
    final angle = (2 * pi) / sides;
    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));

    for (int i = 1; i <= sides; i++) {
      final x = center.dx + radius * cos(angle * i);
      final y = center.dy + radius * sin(angle * i);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const numberOfPoints = 5;
    final double rotation = pi / 2;
    final double step = pi / numberOfPoints;

    for (int i = 0; i < numberOfPoints * 2; i++) {
      final double currentRadius = i % 2 == 0 ? radius : radius / 2;
      final double angle = (i * step) - rotation;
      final double x = center.dx + currentRadius * cos(angle);
      final double y = center.dy + currentRadius * sin(angle);
      if (i == 0) path.moveTo(x, y);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawHeart(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    final width = radius;
    final height = radius;

    path.moveTo(center.dx, center.dy + height / 4);
    path.cubicTo(
      center.dx - width / 2,
      center.dy - height,
      center.dx - width,
      center.dy + height / 3,
      center.dx,
      center.dy + height,
    );
    path.cubicTo(
      center.dx + width,
      center.dy + height / 3,
      center.dx + width / 2,
      center.dy - height,
      center.dx,
      center.dy + height / 4,
    );
    canvas.drawPath(path, paint);
  }

  void _drawCylinder(Canvas canvas, Offset center, double radius, Paint paint) {
    final oval = Rect.fromCenter(
      center: Offset(center.dx, center.dy - radius / 2),
      width: radius * 2,
      height: radius,
    );

    canvas.drawOval(oval, paint);
    canvas.drawOval(oval.translate(0, radius), paint);

    canvas.drawLine(
      Offset(center.dx - radius, center.dy - radius / 2),
      Offset(center.dx - radius, center.dy + radius / 2),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + radius, center.dy - radius / 2),
      Offset(center.dx + radius, center.dy + radius / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
