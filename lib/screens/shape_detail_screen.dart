import 'package:flutter/material.dart';
import '../models/shape_data.dart';
import '../widgets/shape_painter.dart';

class ShapeDetailScreen extends StatefulWidget {
  final ShapeData shape;

  const ShapeDetailScreen({Key? key, required this.shape}) : super(key: key);

  @override
  State<ShapeDetailScreen> createState() => _ShapeDetailScreenState();
}

class _ShapeDetailScreenState extends State<ShapeDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _shapeSize = 200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getShapeDefinition(String shape) {
    switch (shape) {
      case 'دائرة':
        return 'الدائرة هي شكل يتكون من نقاط متساوية البعد عن مركز واحد';
      case 'مربع':
        return 'المربع شكل له أربعة أضلاع متساوية وزوايا قائمة';
      case 'مثلث':
        return 'المثلث شكل ثلاثي الأضلاع والزوايا';
      case 'مستطيل':
        return 'المستطيل له أربعة أضلاع مع تساوي الأضلاع المتقابلة وزوايا قائمة';
      case 'بيضاوي':
        return 'الشكل البيضاوي يشبه الدائرة الممتدة';
      case 'خماسي':
        return 'الشكل الخماسي له خمسة أضلاع وخمس زوايا';
      case 'سداسي':
        return 'الشكل السداسي له ستة أضلاع وست زوايا';
      case 'سباعي':
        return 'الشكل السباعي له سبعة أضلاع وسبع زوايا';
      case 'نجمة':
        return 'النجمة شكل هندسي ذو نقاط بارزة متعددة';
      case 'معين':
        return 'المعين شكل رباعي جميع أضلاعه متساوية';
      case 'قلب':
        return 'الشكل القلب يرمز إلى الحب والمشاعر';
      case 'أسطوانة':
        return 'الأسطوانة لها قاعدتان دائريتان متوازيتان متصلتان بسطح منحني';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: Text(
          widget.shape.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(_shapeSize, _shapeSize),
                  painter: ShapePainter(
                    shape: widget.shape.name,
                    animationValue: _animation.value,
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                _getShapeDefinition(widget.shape.name),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
