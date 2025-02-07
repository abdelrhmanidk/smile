import 'package:flutter/material.dart';
import '../models/feeling.dart';
import '../widgets/draggable_emotion.dart';
import '../widgets/emotion_target.dart';
import '../widgets/level_complete_dialog.dart';
import '../widgets/final_congratulation_dialog.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // قائمة الشعور (Feelings) الآن من نوع Feeling
  final List<Feeling> feelings = const [
    Feeling('😊', 'سعيد'),
    Feeling('😢', 'حزين'),
    Feeling('😡', 'غاضب'),
    Feeling('😲', 'مندهش'),
    Feeling('😨', 'خائف'),
    Feeling('😠', 'منزعج'),
    Feeling('😰', 'قلق'),
    Feeling('😃', 'متحمس'),
    Feeling('😴', 'متعب'),
    Feeling('😎', 'فخور'),
    Feeling('😕', 'مرتبك'),
    Feeling('🥱', 'ضجر'),
    Feeling('🤔', 'متفكر'),
  ];

  // قائمة لعناصر السحب (ترتيبها عشوائي)
  List<Feeling> draggableFeelings = [];
  // قائمة للأهداف (ترتيبها ثابت كما هو في القائمة الأصلية)
  List<Feeling> targetFeelings = [];

  int matchedPairs = 0;
  int currentLevel = 1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _initializeLevel();
  }

  void _initializeLevel() {
    // استخدام عدد من الإيموجيات حسب مستوى اللعبة (مثلاً currentLevel * 4)
    final levelFeelings = feelings.sublist(0, currentLevel * 4);
    draggableFeelings = List<Feeling>.from(levelFeelings)..shuffle();
    targetFeelings = List<Feeling>.from(levelFeelings);
    matchedPairs = 0;
  }

  void _handleMatch(Feeling feeling) {
    setState(() {
      matchedPairs++;
      score += 100;
    });

    if (matchedPairs == currentLevel * 2) {
      // إذا كان المستوى أقل من 3، عرض مربع إتمام المستوى، وإلا عرض شاشة التهنئة النهائية
      if (currentLevel < 3) {
        showDialog(
          context: context,
          builder: (context) => LevelCompleteDialog(
            level: currentLevel,
            onContinue: () {
              setState(() {
                currentLevel++;
                _initializeLevel();
              });
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const FinalCongratulationDialog(),
        );
      }
    }
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('المستوى: $currentLevel',
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          Text('النقاط: $score',
              style: const TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildEmotionGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: draggableFeelings.length,
      itemBuilder: (context, index) {
        final feeling = draggableFeelings[index];
        return DraggableEmotion(
          feeling: feeling,
          onMatched: _handleMatch,
        );
      },
    );
  }

  Widget _buildTargetSection() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: targetFeelings.length,
        itemBuilder: (context, index) {
          final feeling = targetFeelings[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 16),
            child: EmotionTarget(
              feeling: feeling,
              onMatched: _handleMatch,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(child: _buildEmotionGrid()),
              _buildTargetSection(),
            ],
          ),
        ),
      ),
    );
  }
}
