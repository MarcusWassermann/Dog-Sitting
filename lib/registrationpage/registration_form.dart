// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key, required this.onRegistrationSuccess});

  final VoidCallback onRegistrationSuccess;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  bool _isInputValid = false;
  bool _passwordVisible = false;
  bool _passwordRepeatVisible = false;

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

  void _registerUser() {
    // Implementierung der Benutzerregistrierung
    widget.onRegistrationSuccess();
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required bool isEmpty,
    required bool isPassword,
    required VoidCallback onVisibilityToggle,
    bool isPasswordVisible = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white.withOpacity(0.3), // Leicht gefüllte Farbe
      errorBorder: isEmpty
          ? const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            )
          : null,
      focusedErrorBorder: isEmpty
          ? const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            )
          : null,
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onVisibilityToggle,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),
        TextField(
          controller: _usernameController,
          decoration: _inputDecoration(
            labelText: 'Benutzername',
            isEmpty: _usernameController.text.isEmpty,
            isPassword: false,
            onVisibilityToggle: () {},
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _firstNameController,
          decoration: _inputDecoration(
            labelText: 'Vorname',
            isEmpty: _firstNameController.text.isEmpty,
            isPassword: false,
            onVisibilityToggle: () {},
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _lastNameController,
          decoration: _inputDecoration(
            labelText: 'Nachname',
            isEmpty: _lastNameController.text.isEmpty,
            isPassword: false,
            onVisibilityToggle: () {},
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _emailController,
          decoration: _inputDecoration(
            labelText: 'E-Mail',
            isEmpty: _emailController.text.isEmpty,
            isPassword: false,
            onVisibilityToggle: () {},
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: _inputDecoration(
            labelText: 'Passwort',
            isEmpty: _passwordController.text.isEmpty,
            isPassword: true,
            onVisibilityToggle: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            isPasswordVisible: _passwordVisible,
          ),
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: _passwordRepeatController,
          obscureText: !_passwordRepeatVisible,
          decoration: _inputDecoration(
            labelText: 'Passwort wiederholen',
            isEmpty: _passwordRepeatController.text.isEmpty,
            isPassword: true,
            onVisibilityToggle: () {
              setState(() {
                _passwordRepeatVisible = !_passwordRepeatVisible;
              });
            },
            isPasswordVisible: _passwordRepeatVisible,
          ),
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: _isInputValid ? _registerUser : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: _isInputValid ? const Color.fromARGB(255, 18, 213, 148) : Colors.grey,
          ),
          child: const Text('Registrieren'),
        ),
      ],
    );
  }
}
