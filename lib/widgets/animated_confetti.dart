import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedConfetti extends StatefulWidget {
  const AnimatedConfetti({Key? key}) : super(key: key);

  @override
  _AnimatedConfettiState createState() => _AnimatedConfettiState();
}

class _AnimatedConfettiState extends State<AnimatedConfetti>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(_controller.value),
        );
      },
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final double progress;

  ConfettiPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random();
    final paint = Paint()
      ..color = Colors.accents[rnd.nextInt(Colors.accents.length)];

    for (int i = 0; i < 50; i++) {
      final angle = 2 * pi * progress + rnd.nextDouble() * pi;
      final distance = size.height * 0.5 * progress;
      final pos = Offset(
        size.width / 2 + cos(angle) * distance,
        size.height / 2 + sin(angle) * distance,
      );
      canvas.drawCircle(pos, 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
