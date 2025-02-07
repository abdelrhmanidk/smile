import 'package:flutter/material.dart';
import '../models/color_data.dart';

class ColorDetailScreen extends StatefulWidget {
  final ColorData colorData;

  const ColorDetailScreen({Key? key, required this.colorData})
      : super(key: key);

  @override
  _ColorDetailScreenState createState() => _ColorDetailScreenState();
}

class _ColorDetailScreenState extends State<ColorDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 300, end: 350).animate(_controller);
    _colorAnimation = ColorTween(
      begin: widget.colorData.color,
      end: Colors.white,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: widget.colorData.color,
        title: Text(
          widget.colorData.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: _sizeAnimation.value * 6,
                  height: _sizeAnimation.value * 1.5,
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        widget.colorData.color,
                        widget.colorData.color.withOpacity(0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.colorData.color.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Text(
              widget.colorData.description,
              style: const TextStyle(fontSize: 25, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
