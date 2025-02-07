import 'figure_data.dart';

class AnswerRecord {
  final FigureData question;
  final FigureData selected;
  final bool isCorrect;

  const AnswerRecord({
    required this.question,
    required this.selected,
    required this.isCorrect,
  });
}
