import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../models/emotion.dart';

class EmotionDetailScreen extends StatelessWidget {
  final Emotion emotion;

  const EmotionDetailScreen({Key? key, required this.emotion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          emotion.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // خلفية بتدرج لوني يعتمد على لون الخلفية الخاص بالعاطفة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  emotion.backgroundColor.withOpacity(0.7),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // المحتوى الرئيسي داخل ScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 180, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // صورة تفصيلية مع تأثير Hero للانتقال السلس
                  Center(
                    child: Hero(
                      tag: emotion.imagePath,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(emotion.detailGif),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // بطاقة وصف مع نص متحرك
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              emotion.description,
                              speed: const Duration(milliseconds: 100),
                              textAlign: TextAlign.center,
                              curve: Curves.easeInOut,
                            ),
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
