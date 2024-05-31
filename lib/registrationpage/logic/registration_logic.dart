// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationLogic {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> registerUser({
    required BuildContext context,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordRepeat,
    required VoidCallback onSuccess,
  }) async {
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

      onSuccess();
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
}
