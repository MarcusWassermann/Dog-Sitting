// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dog/appwaypage/app_way_page.dart';
import 'package:flutter_dog/loginpage/login_form.dart';

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
    // Einlogik implementieren
    if (_usernameController.text == 'example' &&
        _passwordController.text == 'password') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AppWayScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Einloggen fehlgeschlagen! Benutzername oder Passwort ist falsch.'),
        ),
      );
    }
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
        onForgotPassword: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwort vergessen?'),
            ),
          );
        },
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
