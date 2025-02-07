import 'package:flutter/material.dart';
import '../models/shape_data.dart';
import 'shape_detail_screen.dart';

class ShapeListScreen extends StatelessWidget {
  const ShapeListScreen({Key? key}) : super(key: key);

  static const List<ShapeData> shapes = [
    ShapeData('دائرة', Icons.circle),
    ShapeData('مربع', Icons.square_outlined),
    ShapeData('مثلث', Icons.change_history_outlined),
    ShapeData('مستطيل', Icons.rectangle_outlined),
    ShapeData('بيضاوي', Icons.circle_outlined),
    ShapeData('خماسي', Icons.pentagon_outlined),
    ShapeData('سداسي', Icons.hexagon_outlined),
    ShapeData('سباعي', Icons.hive_outlined),
    ShapeData('نجمة', Icons.star_outline),
    ShapeData('معين', Icons.diamond_outlined),
    ShapeData('قلب', Icons.favorite_border),
    ShapeData('أسطوانة', Icons.cyclone_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: const Text(
          'الأشكال الهندسية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: shapes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShapeDetailScreen(shape: shapes[index]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(shapes[index].icon, size: 60, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(
                      shapes[index].name,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
