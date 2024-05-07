// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // Cloud Firestore
import 'package:dogs_sitting/profilepage/create_profile_form.dart';

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

  Future<void> _saveUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileData = {
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'age': _ageController.text,
          'phoneNumber': _phoneNumberController.text,
          'email': _emailController.text,
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(profileData);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil erfolgreich erstellt!'),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user profile: $e');
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fehler beim Erstellen des Profils.'),
        ),
      );
    }
  }
}
