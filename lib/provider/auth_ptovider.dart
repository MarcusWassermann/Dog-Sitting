// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn = false;

  void signInWithUsernameAndPassword(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: '$username', password: password);
      isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zum Markieren des Benutzers als eingeloggt
  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  Future<void> deleteProfile() async {
    // Methode zum Löschen des Profils
  }

  Future<void> deleteAd() async {
    // Methode zum Löschen der Anzeige
  }

  Future<void> removeAsEmergencyContact() async {
    // Methode zum Entfernen als Notfallkontakt
  }

  // Methode zur Überprüfung des Anmeldezustands
  Future<void> checkLoginState() async {
    final user = _auth.currentUser;
    isLoggedIn = user != null;
    notifyListeners();
  }

  void signIn(String email, String password) {}
}
