// my_screen.dart

import 'package:dogs_sitting/loginpage/login_screen.dart';
import 'package:dogs_sitting/registrationpage/registrations_screen.dart';
import 'package:flutter/material.dart';


class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen zur Dog-Sitter-App',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 201, 82, 82),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Anmelden'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Registrieren'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
