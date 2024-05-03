import 'package:flutter/material.dart';
import 'package:flutter_dog/favoritenpage/favoriten_screen.dart';
import 'package:flutter_dog/gallerypage/gallery_page.dart';
import 'package:flutter_dog/registrationpage/registrations_screen.dart';
import 'loginpage/login_screen.dart';
import 'emergencypage/emergency_contact_screen.dart'; 

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
            ElevatedButton(
              child: const Text('Emergency Kontakt'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EmergencyContactScreen(contactName: '')),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Favoriten'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
