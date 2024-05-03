import 'package:flutter/material.dart';
import 'package:flutter_dog/my_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity;
        if (velocity != null && velocity < -500) {
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
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Dog Sitting',
            style: TextStyle(
              fontSize: 48.0,
              color: Color.fromARGB(255, 27, 24, 24),
              fontFamily: 'YourCurvedFont',
            ),
          ),
        ),
      ),
    );
  }
}
