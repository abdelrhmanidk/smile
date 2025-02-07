import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../widgets/emotion_item.dart';

class EmotionLearningScreen extends StatelessWidget {
  const EmotionLearningScreen({Key? key}) : super(key: key);

  // قائمة العواطف (يمكنك تعديل المسارات والألوان حسب احتياجك)
  final List<Emotion> emotions = const [
    Emotion(
      name: 'فرحان',
      imagePath: 'assests/Feelings/Happy.png', // تأكد من صحة مسار الصورة
      backgroundColor: Color(0xFFFFF9C4), // تقريبًا Colors.yellow[200]
      soundFile: 'happy_sound.mp3',
      detailGif: 'assests/Feelings/Happy.png', // تأكد من صحة مسار الـ GIF
      description:
          'لما تكون فرحان، بتضحك وتبقى مبسوط قوي، زي لما تلعب مع أصحابك',
    ),
    Emotion(
      name: 'زعلان',
      imagePath: 'assests/Feelings/Sad.png',
      backgroundColor: Color(0xFF90CAF9), // تقريبًا Colors.blue[200]
      soundFile: 'sad_sound.mp3',
      detailGif: 'assests/Feelings/Sad.png',
      description:
          'لما تكون زعلان، تحس إن الدنيا مش ماشية، وممكن تحس برغبة في البكا شوية',
    ),
    Emotion(
      name: 'معصب',
      imagePath: 'assests/Feelings/Angry.png',
      backgroundColor: Color(0xFFEF9A9A), // تقريبًا Colors.red[200]
      soundFile: 'angry_sound.mp3',
      detailGif: 'assests/Feelings/Angry.png',
      description:
          'لما تكون معصب، ممكن تزعل وتقول كلام تقيل، جرب تهدى شوية وارتاح',
    ),
    Emotion(
      name: 'مستغرب',
      imagePath: 'assests/Feelings/Irritated.png',
      backgroundColor: Color(0xFFD1C4E9), // تقريبًا Colors.purple[200]
      soundFile: 'surprised_sound.mp3',
      detailGif: 'assests/Feelings/Irritated.png',
      description:
          'لما تحس بالمفاجأة، بتكون مش مصدق اللي بيحصل حواليك، وكل حاجة بقت غريبة',
    ),
    Emotion(
      name: 'خايف',
      imagePath: 'assests/Feelings/Confused.png',
      backgroundColor: Color(0xFFB3E5FC), // تقريبًا Colors.lightBlue[200]
      soundFile: 'afraid_sound.mp3',
      detailGif: 'assests/Feelings/Confused.png',
      description:
          'لما تكون خايف، ممكن تحس إن في حاجة وحشة على وشك تحصل، لكن دا طبيعي أحياناً',
    ),
    Emotion(
      name: 'متضايق',
      imagePath: 'assests/Feelings/Upset.png',
      backgroundColor: Color(0xFFFFE082), // تقريبًا Colors.amber[200]
      soundFile: 'upset_sound.mp3',
      detailGif: 'assests/Feelings/Upset.png',
      description:
          'لما تكون متضايق، تحس إنك مش عايز تكلم حد، خليك مع أصحابك اللي بيفهموك',
    ),
    Emotion(
      name: 'مضطرب',
      imagePath: 'assests/Feelings/Anxious.png',
      backgroundColor: Color(0xFF80DEEA), // تقريبًا Colors.teal[200]
      soundFile: 'anxious_sound.mp3',
      detailGif: 'assests/Feelings/Anxious.png',
      description: 'لما تكون مضطرب، بتحس بتوتر في قلبك، خد نفسك وروق شوية',
    ),
    Emotion(
      name: 'محتار',
      imagePath: 'assests/Feelings/Confused.png',
      backgroundColor: Color(0xFFD7CCC8), // تقريبًا Colors.brown[200]
      soundFile: 'confused_sound.mp3',
      detailGif: 'assests/Feelings/Confused.png',
      description:
          'لما تكون محتار، تحس إنك مش عارف تعمل إيه، خليك هادي وفكر كويس',
    ),
    Emotion(
      name: 'متفائل',
      imagePath: 'assests/Feelings/Playful.png',
      backgroundColor: Color(0xFFDCEDC8), // تقريبًا Colors.lime[200]
      soundFile: 'optimistic_sound.mp3',
      detailGif: 'assests/Feelings/Playful.png',
      description:
          'لما تكون متفائل، دايمًا شايف النور في الضلمة، وبتآمن إن كل حاجة هتبقى تمام',
    ),
    Emotion(
      name: 'قلقان',
      imagePath: 'assests/Feelings/Worried.png',
      backgroundColor: Color(0xFFFFCCBC), // تقريبًا Colors.deepOrange[200]
      soundFile: 'worried_sound.mp3',
      detailGif: 'assests/Feelings/Worried.png',
      description:
          'لما تكون قلقان، تحس إن في حاجات مش ماشية، خد نفس عميق وحاول تهدى',
    ),
  ];

  /// تقسيم قائمة العواطف إلى صفوف (كل صف يحتوي على عمودين)
  List<Widget> _buildEmotionRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < emotions.length; i += 2) {
      Widget firstItem = Expanded(child: EmotionItem(emotion: emotions[i]));
      Widget secondItem = Expanded(
        child: (i + 1 < emotions.length)
            ? EmotionItem(emotion: emotions[i + 1])
            : Container(),
      );
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              firstItem,
              const SizedBox(width: 20),
              secondItem,
            ],
          ),
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مستكشف العواطف'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade100, Colors.purple.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  'حاسس إيه النهاردة؟',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              ..._buildEmotionRows(context),
            ],
          ),
        ),
      ),
    );
  }
}
