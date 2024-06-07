import 'package:flutter/material.dart';
import 'package:dogs_sitting/loginpage/login_screen.dart';
import 'package:dogs_sitting/registrationpage/registrations_screen.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/16.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100, // Höherer top-Wert für eine höhere Position des Textes
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: 0.2,
                child: const Text(
                  'Willkommen zur Dog-Sitting-App',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white, // Textfarbe auf Weiß geändert
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    side: const BorderSide(width: 2, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Anmelden'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    side: const BorderSide(width: 2, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
                  child: const Text('Registrieren'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
