// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/registrationpage/widgets/registration_button.dart';
import 'package:dogs_sitting/registrationpage/widgets/registration_textfield.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key, required this.onRegistrationSuccess});

  final VoidCallback onRegistrationSuccess;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isInputValid = false;

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

  void _validateInput() {
    setState(() {
      _isInputValid = _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': _usernameController.text,
        'email': _emailController.text,
      });
      widget.onRegistrationSuccess();
    } catch (e) {
      if (kDebugMode) {
        print('Error registering user: $e');
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fehler beim Registrieren.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          labelText: 'Benutzername',
          controller: _usernameController,
          onChanged: (_) => _validateInput(),
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          labelText: 'E-Mail',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          onChanged: (_) => _validateInput(),
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          labelText: 'Passwort',
          obscureText: true,
          controller: _passwordController,
          onChanged: (_) => _validateInput(),
        ),
        const SizedBox(height: 16.0),
        CustomButton(
          onPressed: _isInputValid ? _registerUser : null,
          text: 'Registrieren',
        ),
      ],
    );
  }
}
