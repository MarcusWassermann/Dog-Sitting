// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key, required this.onRegistrationSuccess});

  final VoidCallback onRegistrationSuccess;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  bool _isInputValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateInput);
    _firstNameController.addListener(_validateInput);
    _lastNameController.addListener(_validateInput);
    _emailController.addListener(_validateInput);
    _passwordController.addListener(_validateInput);
    _passwordRepeatController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _isInputValid = _usernameController.text.isNotEmpty &&
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordController.text == _passwordRepeatController.text;
    });
  }

  Future<void> _registerUser() async {
    final String username = _usernameController.text.trim();
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String passwordRepeat = _passwordRepeatController.text.trim();

    if (password != passwordRepeat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwörter stimmen nicht überein!'),
          duration: Duration(seconds: 10),
        ),
      );
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erfolgreich registriert!'),
          duration: Duration(seconds: 10),
        ),
      );

      widget.onRegistrationSuccess();
    } catch (e) {
      if (kDebugMode) {
        print('Fehler bei der Registrierung: $e');
      }
      if (e is FirebaseAuthException) {
        if (kDebugMode) {
          print('Firebase Auth Fehlercode: ${e.code}');
        }
        if (kDebugMode) {
          print('Firebase Auth Fehlermeldung: ${e.message}');
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler bei der Registrierung: $e'),
          duration: const Duration(seconds: 10),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
            height: 32.0), // Zusätzlicher Platz über dem ersten Textfeld
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Benutzername',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'Vorname',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Nachname',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(height: 78.0),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-Mail',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Passwort',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _passwordRepeatController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Passwort wiederholen',
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
            height: 120.0), // Zusätzlicher Platz unter dem letzten Textfeld
        ElevatedButton(
          onPressed: _isInputValid ? _registerUser : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                _isInputValid ? Colors.blue : Colors.grey, // Textfarbe
          ),
          child: const Text('Registrieren'),
        ),
      ],
    );
  }
}
