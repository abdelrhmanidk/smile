import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:smile/screens/HomePageChain.dart';
import 'package:vibration/vibration.dart';

import '../models/figure_data.dart';
import '../models/answer_record.dart';
import '../models/shape_puzzle.dart';
import '../widgets/figure_painter.dart'; // استيراد الودجت المخصص لرسم الشكل
import '../widgets/background_painter.dart'; // استيراد الودجت الخاص بالخلفية

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final AudioPlayer player = AudioPlayer();

  final List<FigureData> allShapes = [
    const FigureData(color: Colors.red, shape: 'circle', name: 'دائرة حمراء'),
    const FigureData(color: Colors.blue, shape: 'square', name: 'مربع أزرق'),
    const FigureData(
        color: Colors.yellow, shape: 'triangle', name: 'مثلث أصفر'),
    const FigureData(
        color: Colors.green, shape: 'rectangle', name: 'مستطيل أخضر'),
    const FigureData(color: Colors.purple, shape: 'star', name: 'نجمة بنفسجية'),
    const FigureData(color: Colors.orange, shape: 'heart', name: 'قلب برتقالي'),
    const FigureData(color: Colors.pink, shape: 'oval', name: 'بيضاوي وردي'),
    const FigureData(
        color: Colors.teal, shape: 'hexagon', name: 'سداسي تركوازي'),
    const FigureData(
        color: Colors.indigo, shape: 'pentagon', name: 'خماسي نيلي'),
    const FigureData(color: Colors.lime, shape: 'diamond', name: 'معين ليموني'),
    const FigureData(
        color: Colors.brown, shape: 'cylinder', name: 'أسطوانة بنية'),
    const FigureData(color: Colors.cyan, shape: 'cloud', name: 'سحابة زرقاء'),
  ];

  late List<ShapePuzzle> puzzles;
  int currentPuzzleIndex = 0;
  int _correctAnswers = 0;
  bool showSuccess = false;
  bool showError = false;
  bool _showFinalScore = false;

  final List<AnswerRecord> answerRecords = [];

  @override
  void initState() {
    super.initState();
    _generatePuzzles();
  }

  /// يولد الألغاز مع خلط الخيارات بحيث تكون الإجابة الصحيحة ضمن الخيارات.
  void _generatePuzzles() {
    puzzles = allShapes.map((shape) {
      List<FigureData> wrongAnswers = List<FigureData>.from(allShapes);
      wrongAnswers.remove(shape);
      wrongAnswers.shuffle();
      final options = wrongAnswers.take(3).toList();

      options.add(shape);
      options.shuffle();

      return ShapePuzzle(target: shape, options: options);
    }).toList();
  }

  /// يعيد رسالة التقييم بناءً على نسبة الإجابات الصحيحة.
  String _getFinalGrade() {
    final percentage = (_correctAnswers / puzzles.length) * 100;
    if (percentage >= 95) return 'ممتاز ⭐️⭐️⭐️⭐️⭐️';
    if (percentage >= 80) return 'رائع ⭐️⭐️⭐️⭐️';
    if (percentage >= 65) return 'جيد جداً ⭐️⭐️⭐️';
    if (percentage >= 50) return 'ليس سيئاً ⭐️⭐️';
    return 'حاول مرة أخرى ❤️';
  }

  /// يتعامل مع إجابة المستخدم، يسجلها، يشغل الصوت والاهتزاز المناسب ثم ينتقل للسؤال التالي.
  void _handleAnswer(FigureData selected) {
    final currentPuzzle = puzzles[currentPuzzleIndex];
    final isCorrect = selected == currentPuzzle.target;

    answerRecords.add(AnswerRecord(
      question: currentPuzzle.target,
      selected: selected,
      isCorrect: isCorrect,
    ));

    if (isCorrect) {
      _correctAnswers++;
      setState(() => showSuccess = true);
      player.play(AssetSource('success.mp3'));
      Vibration.vibrate(duration: 200);
    } else {
      setState(() => showError = true);
      player.play(AssetSource('error.mp3'));
      Vibration.vibrate(duration: 500);
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showSuccess = false;
        showError = false;
        if (currentPuzzleIndex < puzzles.length - 1) {
          currentPuzzleIndex++;
        } else {
          _showFinalScore = true;
        }
      });
    });
  }

  /// يبني الودجت الذي يعرض الشكل باستخدام الـ FigureWidget الموجود في widgets/figure_painter.dart.
  Widget _buildShape(FigureData data,
      {double size = 100, bool isTarget = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isTarget ? data.color.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isTarget ? Border.all(color: data.color, width: 3) : null,
      ),
      child: FigureWidget(shape: data, size: size),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPuzzle = puzzles[currentPuzzleIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: Stack(
          children: [
            // استخدام Positioned.fill مع CustomPaint لعرض الخلفية
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'ما هو هذا الشكل؟',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 40),
                  _buildShape(currentPuzzle.target, size: 150, isTarget: true),
                  const SizedBox(height: 40),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: currentPuzzle.options.map((option) {
                      return GestureDetector(
                        onTap: () => _handleAnswer(option),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildShape(option, size: 50),
                              const SizedBox(width: 10),
                              Text(
                                option.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: (currentPuzzleIndex + 1) / puzzles.length,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.lightBlueAccent,
                    ),
                  ),
                  Text(
                    '${currentPuzzleIndex + 1}/${puzzles.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            if (showSuccess)
              Positioned.fill(
                child: Container(
                  color: Colors.green.withOpacity(0.2),
                  child: const Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                ),
              ),
            if (showError)
              Positioned.fill(
                child: Container(
                  color: Colors.red.withOpacity(0.2),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                ),
              ),
            if (_showFinalScore)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.celebration,
                              color: Colors.amber, size: 100),
                          const SizedBox(height: 20),
                          Text(
                            'النتيجة النهائية',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '$_correctAnswers/${puzzles.length}',
                            style: const TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _getFinalGrade(),
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            icon:
                                const Icon(Icons.refresh, color: Colors.white),
                            label: const Text(
                              'الصفحه الرئيسيه',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePageChain()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
