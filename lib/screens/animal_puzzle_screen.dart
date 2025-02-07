import 'package:flutter/material.dart';
import '../models/AnimalPuzzle.dart';

class AnimalPuzzleScreen extends StatefulWidget {
  const AnimalPuzzleScreen({Key? key}) : super(key: key);

  @override
  _AnimalPuzzleScreenState createState() => _AnimalPuzzleScreenState();
}

class _AnimalPuzzleScreenState extends State<AnimalPuzzleScreen> {
  int currentPuzzleIndex = 0;
  late String currentEmoji;
  late String currentAnimal;
  late String currentDescription;
  late List<String> letters;
  late List<String> shuffledLetters;
  List<String> selectedLetters = [];

  @override
  void initState() {
    super.initState();
    _loadPuzzle();
  }

  void _loadPuzzle() {
    final puzzle = animalPuzzles[currentPuzzleIndex];
    currentEmoji = puzzle.emoji;
    currentAnimal = puzzle.name;
    currentDescription = puzzle.description;
    letters = currentAnimal.split('');
    shuffledLetters = List.from(letters)..shuffle();
    selectedLetters = List.filled(letters.length, '');
  }

  void _checkAnswer() {
    if (selectedLetters.join() == currentAnimal) {
      // عرض نافذة عند الإجابة الصحيحة
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  'مبروك!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'لقد كتبت الاسم بشكل صحيح',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nextPuzzle();
                  },
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // في حالة الإجابة الخاطئة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'حاول مرة أخرى!',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      );
    }
  }

  void _nextPuzzle() {
    setState(() {
      // زيادة الفهرس للحصول على لغز جديد؛ إذا وصلنا لنهاية القائمة، نعود للبداية
      currentPuzzleIndex = (currentPuzzleIndex + 1) % animalPuzzles.length;
      _loadPuzzle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final letterBoxSize = screenWidth / 7;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لعبة تركيب الحيوانات',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // ضمان اتجاه النص من اليمين إلى اليسار
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // عرض رمز الحيوان
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      currentEmoji,
                      style: const TextStyle(fontSize: 120),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // صناديق الحروف المختارة
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      letters.length,
                      (index) => DragTarget<String>(
                        onWillAccept: (data) {
                          return data == letters[index] &&
                              selectedLetters[index].isEmpty;
                        },
                        builder: (context, candidateData, rejectedData) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: letterBoxSize,
                            height: letterBoxSize,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedLetters[index].isEmpty
                                  ? Colors.white
                                  : Colors.deepPurple.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              selectedLetters[index],
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                          );
                        },
                        onAccept: (data) {
                          setState(() {
                            selectedLetters[index] = data;
                            shuffledLetters.remove(data);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // عرض الحروف القابلة للسحب
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: shuffledLetters.map((letter) {
                      return Draggable<String>(
                        data: letter,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: letterBoxSize,
                            height: letterBoxSize,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              letter,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                          width: letterBoxSize,
                          height: letterBoxSize,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                        ),
                        child: Container(
                          width: letterBoxSize,
                          height: letterBoxSize,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepPurple, width: 2),
                          ),
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  // زر التحقق من الإجابة
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _checkAnswer,
                    child: const Text('تحقق من الإجابة'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
