import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../screens/animal_detail_page.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // استخدام التنقل التقليدي مع Navigator.push
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetailPage(animal: animal),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: animal.name,
                child: Image.asset(animal.imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                animal.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
