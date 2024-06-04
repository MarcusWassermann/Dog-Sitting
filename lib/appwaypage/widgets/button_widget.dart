import 'package:dogs_sitting/profilepage/createprofile_screen.dart';
import 'package:flutter/material.dart';

class ButtonWidgets {
  static Widget buildButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
    Alignment alignment,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: alignment,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.black), // Icon Farbe anpassen
          label: Text(
            label,
            style: const TextStyle(color: Colors.black), // Textfarbe anpassen
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, // Schriftfarbe anpassen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.black),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          ),
        ),
      ),
    );
  }

  static Widget buildSitterProfileButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateProfileScreen(),
              ),
            );
          },
          icon: const Icon(Icons.person_add,
              color: Colors.black), // Icon Farbe anpassen
          label: const Text(
            'Sitter\nProfil erstellen',
            textAlign: TextAlign.center, // Zentrierte Ausrichtung des Textes
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0, // Schriftgröße anpassen
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, // Schriftfarbe anpassen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.black),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10.0), // Höhe des Buttons verringern
          ),
        ),
      ),
    );
  }
}
