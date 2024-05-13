import 'package:flutter/material.dart';
import 'package:dogs_sitting/loginpage/login_screen.dart';
import 'package:dogs_sitting/registrationpage/registrations_screen.dart';
import 'package:dogs_sitting/profilepage/createprofile_screen.dart';

class CustomRaisedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomRaisedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  void _handleButtonPress(BuildContext context) {
    // Standardaktion für den Button-Druck, z.B. Navigation zu einem bestimmten Bildschirm
    if (text == 'Anmelden') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (text == 'Registrieren') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    } else if (text == 'Profil anlegen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(context),
      child: Text(text),
    );
  }
}
