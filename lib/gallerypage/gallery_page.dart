import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          6, // Anzahl der Bilder
          (index) => _buildImageCard(index + 1), // Index beginnt bei 1
        ),
      ),
    );
  }

  Widget _buildImageCard(int imageIndex) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Aktion beim Klicken auf das Bild (z.B. Vollbildansicht)
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/image$imageIndex.jpg', // Beispielbild-Asset
              fit: BoxFit.cover,
              height: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Bild $imageIndex',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
