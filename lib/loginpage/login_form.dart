
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// Definition des LoginForm-Widgets
class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

// Definition des Zustands für das LoginForm
class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Das Passwort ist anfangs nicht sichtbar
  }

  // Aufbau des UIs für das LoginForm
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: widget.usernameController,
                style:
                    const TextStyle(color: Colors.black), // Textfarbe festlegen
                decoration: InputDecoration(
                  labelText: 'Benutzername',
                  labelStyle: const TextStyle(
                      color: Colors.black), // Farbe des Label-Textes festlegen
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: widget.passwordController,
                obscureText: !_passwordVisible,
                style:
                    const TextStyle(color: Colors.black), // Textfarbe festlegen
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  labelStyle: const TextStyle(
                      color: Colors.black), // Farbe des Label-Textes festlegen
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: widget.onLogin,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              child: const Text('Einloggen'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: widget.onForgotPassword,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Passwort vergessen?',
                  style: TextStyle(color: Color.fromARGB(255, 222, 232, 240)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
