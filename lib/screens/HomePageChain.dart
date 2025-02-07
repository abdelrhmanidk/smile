import 'package:flutter/material.dart';
import 'package:smile/screens/animal_grid_screen.dart';
import 'package:smile/screens/animal_puzzle_screen.dart';
import 'package:smile/screens/color_list_screen.dart';
import 'package:smile/screens/emotion_learning_screen.dart';
import 'package:smile/screens/game_screen.dart';
import 'package:smile/screens/puzzle_screen.dart';
import 'package:smile/screens/shape_list_screen.dart';

// تعديل نموذج الميزة: تم حذف خاصية route
class _ChainFeature {
  final String title;
  final IconData icon;

  _ChainFeature({
    required this.title,
    required this.icon,
  });
}

class HomePageChain extends StatelessWidget {
  HomePageChain({Key? key}) : super(key: key);

  // تحديد المميزات بدون خاصية route
  final List<_ChainFeature> features = [
    _ChainFeature(
      title: 'تعلم الأشكال',
      icon: Icons.crop_square,
    ),
    _ChainFeature(
      title: 'تعلم الألوان',
      icon: Icons.color_lens,
    ),
    _ChainFeature(
      title: 'العب', // كويز عن الأشكال والألوان
      icon: Icons.question_answer,
    ),
    _ChainFeature(
      title: 'تعلم المشاعر',
      icon: Icons.tag_faces,
    ),
    _ChainFeature(
      title: 'العب', // لعبة المشاعر
      icon: Icons.games,
    ),
    _ChainFeature(
      title: 'تعلم الحيوانات',
      icon: Icons.pets,
    ),
    _ChainFeature(
      title: 'العب', // لعبة عن الحيوانات
      icon: Icons.games_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 37, 66),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      // يمكن وضع Lottie هنا إن رغبت
                      Expanded(
                        child: Text(
                          'تحدث مع مساعدنا لتجربة تعليمية ممتعة!',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 3,
                color: Colors.white,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double areaWidth = constraints.maxWidth;
                  final double centerX = areaWidth / 2;
                  final List<Offset> featurePositions = [
                    Offset(centerX + 80, 50),
                    Offset(centerX - 10, 200),
                    Offset(centerX + 60, 340),
                    Offset(centerX - 70, 460),
                    Offset(centerX + 100, 550),
                    Offset(centerX - 40, 650),
                    Offset(centerX + 50, 800),
                  ];

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: areaWidth,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(areaWidth, 700),
                          painter: DottedLinePainter(
                            points: featurePositions,
                            dotSpacing: 6,
                          ),
                        ),
                        for (int i = 0; i < features.length; i++)
                          Positioned(
                            left: featurePositions[i].dx - (circleSize / 2),
                            top: featurePositions[i].dy - (circleSize / 2),
                            child: ChainFeatureItem(feature: features[i]),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double circleSize = 100;

// تغليف العنصر داخل InkWell للاستجابة للنقر مع التنقل للصفحة المناسبة
class ChainFeatureItem extends StatelessWidget {
  final _ChainFeature feature;

  const ChainFeatureItem({Key? key, required this.feature}) : super(key: key);

  // دالة تحديد الصفحة المستهدفة بناءً على عنوان أو أيقونة العنصر
  void _handleTap(BuildContext context) {
    if (feature.title == 'تعلم الأشكال') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ShapeListScreen()));
    } else if (feature.title == 'تعلم الألوان') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ColorListScreen()));
    } else if (feature.title == 'العب' &&
        feature.icon == Icons.question_answer) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PuzzleScreen()));
    } else if (feature.title == 'تعلم المشاعر') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EmotionLearningScreen()));
    } else if (feature.title == 'العب' && feature.icon == Icons.games) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GameScreen()));
    } else if (feature.title == 'تعلم الحيوانات') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AnimalGridScreen()));
    } else if (feature.title == 'العب' &&
        feature.icon == Icons.games_outlined) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AnimalPuzzleScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        width: circleSize,
        height: circleSize,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.blueAccent, width: 2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(3, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(feature.icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 4),
            Text(
              feature.title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

// كلاس رسم الخط المنقط كما هو موجود في الكود الأصلي
class DottedLinePainter extends CustomPainter {
  final List<Offset> points;
  final double dotSpacing;
  final double dotRadius;

  DottedLinePainter({
    required this.points,
    this.dotSpacing = 6,
    this.dotRadius = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final distance = (p2 - p1).distance;
      final direction = (p2 - p1) / distance;
      int count = (distance / dotSpacing).floor();
      for (int j = 0; j < count; j++) {
        final offset = p1 + direction * (j * dotSpacing);
        canvas.drawCircle(offset, dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DottedLinePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.dotSpacing != dotSpacing ||
        oldDelegate.dotRadius != dotRadius;
  }
}
