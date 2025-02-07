import 'package:flutter/material.dart';
import '../models/color_data.dart';
import 'color_detail_screen.dart';
import '../widgets/animated_color_card.dart';

class ColorListScreen extends StatelessWidget {
  const ColorListScreen({Key? key}) : super(key: key);

  final List<ColorData> colors = const [
    ColorData(
      'أحمر',
      Colors.red,
      'اللون الأحمر يرمز إلى الطاقة والشجاعة. يتواجد في الطبيعة في الدماء والورود.',
    ),
    ColorData(
      'أزرق',
      Colors.blue,
      'يرمز الأزرق إلى الهدوء والثقة. لون السماء الصافية والمحيطات.',
    ),
    ColorData(
      'أخضر',
      Colors.green,
      'لون الطبيعة والنمو. لون الصحة والخصوبة.',
    ),
    ColorData(
      'أصفر',
      Colors.yellow,
      'لون الشمس المشرقة. يرمز إلى الفرح والتفاؤل.',
    ),
    ColorData(
      'برتقالي',
      Colors.orange,
      'مزيج من الأحمر والأصفر. لون الإبداع والحماس.',
    ),
    ColorData(
      'بنفسجي',
      Colors.purple,
      'لون الملوك والروحانية. مزيج من الأحمر والأزرق.',
    ),
    ColorData(
      'وردي',
      Colors.pink,
      'لون الحب والرومانسية. لون الزهور الجميلة والقلوب.',
    ),
    ColorData(
      'بني',
      Colors.brown,
      'لون الأرض والخشب. يرمز إلى الاستقرار والبساطة.',
    ),
    ColorData(
      'رمادي',
      Colors.grey,
      'لون الحياد والتوازن. يرمز إلى الواقعية والحكمة.',
    ),
    ColorData(
      'تركواز',
      Colors.teal,
      'لون الهدوء النفسي. لون مياه البحر الصافية.',
    ),
    ColorData(
      'نيلي',
      Colors.indigo,
      'لون الحدس والروحانية. لون السماء الليلية العميقة.',
    ),
    ColorData(
      'ليموني',
      Colors.lime,
      'لون النشاط والحيوية. يرمز إلى التجديد والطاقة.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: const Text(
          'تعلم الألوان',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ColorDetailScreen(colorData: colors[index]),
              ),
            ),
            child: AnimatedColorCard(colorData: colors[index]),
          ),
        ),
      ),
    );
  }
}
