import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/emotion.dart';
import '../screens/emotion_detail_screen.dart';

class EmotionItem extends StatelessWidget {
  final Emotion emotion;

  const EmotionItem({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // تشغيل الصوت عند النقر
        AudioPlayer().play(AssetSource(emotion.soundFile));
        // التنقل للصفحة الخاصة بتفاصيل العاطفة
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmotionDetailScreen(emotion: emotion),
          ),
        );
      },
      child: Column(
        children: [
          // تغليف CircleAvatar داخل Container مع بوردر أسود
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundColor: emotion.backgroundColor,
              backgroundImage: AssetImage(emotion.imagePath),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            emotion.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
