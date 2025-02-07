import 'package:flutter/material.dart';
import '../models/color_data.dart';

class AnimatedColorCard extends StatefulWidget {
  final ColorData colorData;

  const AnimatedColorCard({Key? key, required this.colorData})
      : super(key: key);

  @override
  _AnimatedColorCardState createState() => _AnimatedColorCardState();
}

class _AnimatedColorCardState extends State<AnimatedColorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                widget.colorData.color,
                widget.colorData.color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.colorData.color.withOpacity(0.5),
                blurRadius: _animation.value * 30,
                spreadRadius: _animation.value * 4,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.color_lens, size: 80, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                widget.colorData.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
