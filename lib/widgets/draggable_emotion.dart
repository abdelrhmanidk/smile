import 'package:flutter/material.dart';
import '../models/feeling.dart';

class DraggableEmotion extends StatelessWidget {
  final Feeling feeling;
  final Function(Feeling) onMatched;

  const DraggableEmotion(
      {Key? key, required this.feeling, required this.onMatched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<Feeling>(
      data: feeling,
      feedback: Material(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Text(
              feeling.emoji,
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildEmotionContainer(),
      ),
      child: _buildEmotionContainer(),
    );
  }

  Widget _buildEmotionContainer() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          )
        ],
      ),
      child: Center(
        child: Text(
          feeling.emoji,
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
