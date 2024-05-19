import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  final bool emergencyContact;
  final VoidCallback onToggleEmergencyContact;

  const ProfileButtons({super.key, 
    required this.emergencyContact,
    required this.onToggleEmergencyContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onToggleEmergencyContact,
          style: ElevatedButton.styleFrom(
            backgroundColor: emergencyContact ? Colors.green : Colors.red,
            minimumSize: const Size(30, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          child: Text(
            'Notfall Kontakt',
            style: TextStyle(
              color: emergencyContact ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            // Handle create profile button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
          ),
          child: const Text(
            'Profil erstellen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
