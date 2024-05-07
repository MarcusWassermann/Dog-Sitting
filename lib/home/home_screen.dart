import 'package:dogs_sitting/my_page/my_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity;
        if (velocity != null && velocity < -1000) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyScreen()),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1423213-3715587.jpg'),
            fit: BoxFit.cover, // Bildgröße anpassen
            alignment: Alignment(
                0.3, -0.5), // Horizontal: 0.5 (Mitte), Vertikal: -0.5 (oben)
          ),
        ),
        width: double
            .infinity, // Bild über die gesamte Breite des Bildschirms strecken
        height: double
            .infinity, // Bild über die gesamte Höhe des Bildschirms strecken
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100, 
            ),
            Center(
              child: Text(
                'Dog Sitting',
                style: TextStyle(
                  fontSize: 34.0, // Adjust the font size as needed
                  color: Color.fromARGB(255, 27, 24, 24),
                  fontFamily: 'YourOtherFont', // Anderes Schriftart
                  fontWeight: FontWeight.bold, // Fettschrift
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
