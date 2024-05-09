// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/profilepage/create_profile_form.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _ageController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  bool _emergencyContact = false;
  bool _normalContact = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil erstellen'),
      ),
      body: CreateProfileForm(
        usernameController: _usernameController,
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        ageController: _ageController,
        phoneNumberController: _phoneNumberController,
        emailController: _emailController,
        emergencyContact: _emergencyContact,
        normalContact: _normalContact,
        onEmergencyContactChanged: (value) {
          setState(() {
            _emergencyContact = value ?? false;
          });
        },
        onNormalContactChanged: (value) {
          setState(() {
            _normalContact = value ?? false;
          });
        },
        onSave: _saveUserProfile,
      ),
    );
  }

  Future<void> _saveUserProfile() async {
    if (_validateInputs()) {
      try {
        // Hier wird das Benutzerprofil gespeichert
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil erfolgreich erstellt!'),
          ),
        );
      } catch (e) {
        // Behandeln Sie den Fehler beim Speichern des Benutzerprofils
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fehler beim Erstellen des Profils.'),
          ),
        );
      }
    }
  }

  bool _validateInputs() {
    if (_usernameController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte füllen Sie alle Felder aus.'),
        ),
      );
      return false;
    }
    return true;
  }
}
