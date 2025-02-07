import 'package:flutter/material.dart';

class ColorMixerCircle extends StatefulWidget {
  final Color color;

  const ColorMixerCircle({Key? key, required this.color}) : super(key: key);

  @override
  _ColorMixerCircleState createState() => _ColorMixerCircleState();
}

class _ColorMixerCircleState extends State<ColorMixerCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
        return Transform.scale(
          scale: 0.8 + _controller.value * 0.2,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
