import 'package:flutter/material.dart';

class Emotion {
  final String name;
  final String imagePath;
  final Color backgroundColor;
  final String soundFile;
  final String detailGif;
  final String description;

  const Emotion({
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
    required this.soundFile,
    required this.detailGif,
    required this.description,
  });
}
