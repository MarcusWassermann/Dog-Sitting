import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  final String
      profileName; // Name des Profils, für das Bewertungen angezeigt werden

  const ReviewsScreen({super.key, required this.profileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bewertungen für $profileName'),
      ),
      body: const Center(
        child: Text('Bewertungsanzeige noch nicht implementiert'),
      ),
    );
  }
}
