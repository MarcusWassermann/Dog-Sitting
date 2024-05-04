// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dog/appwaypage/app_way_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Registrieren'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              'Benutzername',
              controller: _usernameController,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              'E-Mail',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              'Passwort (mind. 8 Zeichen, 1 Großbuchstabe, 1 Zahl, 1 Sonderzeichen)',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 16.0),
            _buildRegisterButton(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 252, 252, 252),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 5, 5, 5),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String labelText, {
    TextInputType? keyboardType,
    bool obscureText = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          // Überprüfen, ob alle Felder ausgefüllt sind
          if (_usernameController.text.isEmpty ||
              _emailController.text.isEmpty ||
              _passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bitte fülle alle Felder aus.'),
              ),
            );
            return;
          }

          // Überprüfen, ob die E-Mail-Adresse gültig ist
          if (!_isValidEmail(_emailController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bitte gib eine gültige E-Mail-Adresse ein.'),
              ),
            );
            return;
          }

          // Überprüfen, ob das Passwort die Mindestanforderungen erfüllt
          if (!_isValidPassword(_passwordController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Das Passwort muss mindestens 8 Zeichen lang sein und mindestens einen Großbuchstaben, eine Zahl und ein Sonderzeichen enthalten.'),
              ),
            );
            return;
          }

          // Textfelder nach dem Drücken der Registrierungsschaltfläche leeren
          _usernameController.clear();
          _emailController.clear();
          _passwordController.clear();

          // Nach erfolgreicher Registrierung zur AppWayScreen navigieren
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppWayScreen(),
            ),
          );
        },
        child: const Text(
          'Registrieren',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Einfache Überprüfung, ob die E-Mail-Adresse eine gültige Form hat
    // Diese Überprüfung kann erweitert werden, um eine strengere Validierung durchzuführen
    return email.contains('@');
  }

  bool _isValidPassword(String password) {
    // Überprüfen, ob das Passwort mindestens 8 Zeichen lang ist
    if (password.length < 8) return false;

    // Überprüfen, ob das Passwort mindestens einen Großbuchstaben, eine Zahl und ein Sonderzeichen enthält
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasUppercase && hasDigits && hasSpecialCharacters;
  }
}
