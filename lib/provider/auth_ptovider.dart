import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  // Methode zum Anmelden
  void signIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  // Methode zum Abmelden
  void signOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}
