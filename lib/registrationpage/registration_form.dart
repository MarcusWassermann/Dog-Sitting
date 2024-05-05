// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dog/registrationpage/widgets/registration_button.dart';
import 'package:flutter_dog/registrationpage/widgets/registration_textfield.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          labelText: 'Benutzername',
          controller: _usernameController,
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          labelText: 'E-Mail',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          labelText:
              'Passwort (mind. 8 Zeichen, 1 Großbuchstabe, 1 Zahl, 1 Sonderzeichen)',
          obscureText: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 16.0),
        CustomButton(
          onPressed: () {
            // Funktion zum Registrieren aufrufen
          },
          text: 'Registrieren',
        ),
      ],
    );
  }
}
