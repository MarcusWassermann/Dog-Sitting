// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/appwaypage/app_way_page.dart';
import 'package:dogs_sitting/loginpage/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // Hier können Sie Ihre eigene Anmeldeüberprüfung implementieren
      // Zum Beispiel: Überprüfen Sie die Anmeldeinformationen in einer Datenbank oder einem Authentifizierungsdienst
      // In diesem Beispiel wird eine einfache Überprüfung mit festen Benutzerdaten durchgeführt
      if (username == 'example' && password == 'password') {
        // Wenn die Anmeldeinformationen korrekt sind, navigieren Sie zum Hauptbildschirm
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppWayScreen()),
        );
      } else {
        // Wenn die Anmeldeinformationen falsch sind, zeigen Sie eine Fehlermeldung an
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Einloggen fehlgeschlagen! Benutzername oder Passwort ist falsch.'),
          ),
        );
      }
    } else {
      // Wenn Benutzername oder Passwort leer sind, zeigen Sie eine Fehlermeldung an
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Benutzername und Passwort dürfen nicht leer sein.'),
        ),
      );
    }
  }

  void _forgotPassword() {
    // Hier können Sie die Logik für das Zurücksetzen des Passworts implementieren
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwort vergessen?'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Zurück zur vorherigen Seite
          },
        ),
      ),
      body: LoginForm(
        usernameController: _usernameController,
        passwordController: _passwordController,
        onLogin: _login,
        onForgotPassword: _forgotPassword,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
