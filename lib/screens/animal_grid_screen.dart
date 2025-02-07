import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../widgets/animal_card.dart';

class AnimalGridScreen extends StatelessWidget {
  const AnimalGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختار حيوان'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: animals.length,
          itemBuilder: (context, index) {
            final animal = animals[index];
            return AnimalCard(animal: animal);
          },
        ),
      ),
    );
  }
}
