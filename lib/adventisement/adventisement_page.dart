import 'package:dogs_sitting/adventisement/advertisement_form.dart';
import 'package:flutter/material.dart';

class AdvertisementPage extends StatelessWidget {
  const AdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anzeigenseite',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0, // Entfernt die Schattenlinie der AppBar
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Hintergrundbild
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Restlicher Inhalt
          Positioned.fill(
            child: AdvertisementForm(
              postcodeEditingController: TextEditingController(),
            ),
          ),
        ],
      ),
    );
  }
}
