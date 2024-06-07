import 'package:dogs_sitting/my_page/my_screen.dart';
import 'package:dogs_sitting/welcome_page/welcome_page.dart'; // Importiere die WelcomePage
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WelcomePage()), // Navigiere zur WelcomePage
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/12.png'),
            fit: BoxFit.cover,
            alignment: Alignment(
              0.3,
              -0.5,
            ),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                'Dog Sitting',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Color.fromARGB(255, 27, 24, 24),
                  fontFamily: 'YourOtherFont',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
