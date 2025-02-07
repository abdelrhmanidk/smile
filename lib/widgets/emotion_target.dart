import 'package:flutter/material.dart';
import '../models/feeling.dart';

class EmotionTarget extends StatefulWidget {
  final Feeling feeling;
  final Function(Feeling) onMatched;

  const EmotionTarget(
      {Key? key, required this.feeling, required this.onMatched})
      : super(key: key);

  @override
  _EmotionTargetState createState() => _EmotionTargetState();
}

class _EmotionTargetState extends State<EmotionTarget> {
  Feeling? droppedFeeling;
  Color? highlightColor;

  // تعريف ألوان التأكيد على الصحة أو الخطأ
  final Color correctColor = Colors.green.shade100;
  final Color wrongColor = Colors.red.shade100;
  final Color defaultColor = Colors.white;

  BorderRadius get currentBorderRadius {
    if (highlightColor == correctColor) {
      return BorderRadius.circular(20);
    } else if (highlightColor == wrongColor) {
      return BorderRadius.circular(5);
    } else {
      return BorderRadius.circular(15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Feeling>(
      onWillAccept: (data) {
        if (data?.label == widget.feeling.label) {
          setState(() {
            highlightColor = correctColor;
          });
          return true;
        } else {
          setState(() {
            highlightColor = wrongColor;
          });
          return false;
        }
      },
      onAccept: (data) {
        widget.onMatched(widget.feeling);
        setState(() {
          droppedFeeling = data;
          highlightColor = defaultColor;
        });
      },
      onLeave: (_) {
        setState(() {
          highlightColor = defaultColor;
        });
      },
      builder: (context, _, __) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: highlightColor ?? defaultColor,
            borderRadius: currentBorderRadius,
            border: Border.all(
              color: (highlightColor == correctColor)
                  ? Colors.green
                  : (highlightColor == wrongColor
                      ? Colors.red
                      : Colors.grey.shade300),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.feeling.label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: droppedFeeling != null
                      ? Center(
                          child: Text(
                            droppedFeeling!.emoji,
                            style: const TextStyle(fontSize: 50),
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
