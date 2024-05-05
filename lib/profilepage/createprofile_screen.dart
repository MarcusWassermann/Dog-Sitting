// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dog/profilepage/create_profile_form.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _ageController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
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
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        ageController: _ageController,
        phoneNumberController: _phoneNumberController,
        emailController: _emailController,
        onSave: _saveUserProfile,
      ),
    );
  }

  void _saveUserProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil erfolgreich erstellt!'),
      ),
    );
  }
}
