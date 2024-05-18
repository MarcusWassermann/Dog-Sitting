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
        title: const Text(
          'Profil erstellen',
          style: TextStyle(color: Colors.white), // Weißer Text
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Weißer Pfeil
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hintergrundbild über die gesamte Seite
          Image.asset(
            'assets/14475041.jpg',
            fit: BoxFit.cover,
          ),
          // Inhalte über das Hintergrundbild
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight),
            child: CreateProfileForm(
              usernameController: _usernameController,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              ageController: _ageController,
              phoneNumberController: _phoneNumberController,
              emailController: _emailController,
              emergencyContact: _emergencyContact,
              onEmergencyContactChanged: (value) {
                setState(() {
                  _emergencyContact = value ?? false;
                });
              },
              onSave: _saveUserProfile,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUserProfile() async {
    // Hier wird das Benutzerprofil gespeichert
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil erfolgreich erstellt!'),
      ),
    );
  }
}
