import 'dart:math';
import 'package:flutter/material.dart';
import '../models/figure_data.dart';

/// يمثل FigureWidget الذي يستخدم لرسم الشكل
class FigureWidget extends StatelessWidget {
  final FigureData shape;
  final double size;

  const FigureWidget({Key? key, required this.shape, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: FigureCustomPainter(shape: shape),
    );
  }
}

class FigureCustomPainter extends CustomPainter {
  final FigureData shape;

  FigureCustomPainter({required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = shape.color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;

    switch (shape.shape) {
      case 'circle':
        canvas.drawCircle(center, radius, paint);
        break;
      case 'square':
        canvas.drawRect(
          Rect.fromCenter(
              center: center, width: radius * 2, height: radius * 2),
          paint,
        );
        break;
      case 'triangle':
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy + radius)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'rectangle':
        canvas.drawRect(
          Rect.fromCenter(center: center, width: radius * 2, height: radius),
          paint,
        );
        break;
      case 'star':
        _drawStar(canvas, center, radius, paint);
        break;
      case 'heart':
        _drawHeart(canvas, center, radius, paint);
        break;
      case 'oval':
        canvas.drawOval(
          Rect.fromCenter(center: center, width: radius * 2, height: radius),
          paint,
        );
        break;
      case 'hexagon':
        _drawPolygon(canvas, center, radius, 6, paint);
        break;
      case 'pentagon':
        _drawPolygon(canvas, center, radius, 5, paint);
        break;
      case 'diamond':
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy)
          ..lineTo(center.dx, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'cylinder':
        _drawCylinder(canvas, center, radius, paint);
        break;
      case 'cloud':
        _drawCloud(canvas, center, radius, paint);
        break;
      default:
        break;
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    const numberOfPoints = 5;
    final double rotation = pi / 2;
    final double step = pi / numberOfPoints;
    final path = Path();

    for (int i = 0; i < numberOfPoints * 2; i++) {
      final double currentRadius = i % 2 == 0 ? radius : radius * 0.4;
      final double angle = (i * step) - rotation;
      final double x = center.dx + currentRadius * cos(angle);
      final double y = center.dy + currentRadius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
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

  void _drawPolygon(
      Canvas canvas, Offset center, double radius, int sides, Paint paint) {
    final path = Path();
    final angle = (2 * pi) / sides;
    path.moveTo(
      center.dx + radius * cos(-pi / 2),
      center.dy + radius * sin(-pi / 2),
    );
    for (int i = 1; i <= sides; i++) {
      final x = center.dx + radius * cos(angle * i - pi / 2);
      final y = center.dy + radius * sin(angle * i - pi / 2);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawCylinder(Canvas canvas, Offset center, double radius, Paint paint) {
    final oval = Rect.fromCenter(
      center: Offset(center.dx, center.dy - radius / 2),
      width: radius * 2,
      height: radius,
    );

    canvas.drawOval(oval, paint);
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

  void _drawCloud(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: center.translate(-radius * 0.6, 0),
        radius: radius * 0.4,
      ))
      ..addOval(Rect.fromCircle(
        center: center.translate(radius * 0.6, 0),
        radius: radius * 0.4,
      ))
      ..addOval(Rect.fromCircle(
        center: center.translate(0, radius * 0.3),
        radius: radius * 0.6,
      ))
      ..addOval(Rect.fromCircle(center: center, radius: radius * 0.5));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
