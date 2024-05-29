import 'package:flutter/material.dart';

// Ein einfaches Datenmodell für den Benutzer
class User {
  final String id;
  final String email;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.token,
  });
}

// Der Benutzer-Provider
class UserProvider extends ChangeNotifier {
  // Der aktuelle Benutzer
  User? _user;

  // Funktion zum Überprüfen, ob ein Benutzer angemeldet ist
  bool get isLoggedIn => _user != null;

  // Funktion zum Abrufen der Benutzerinformationen
  User? get user => _user;

  // Funktion zum Anmelden eines Benutzers
  void login(String email, String token) {
    _user = User(id: '123', email: email, token: token);
    notifyListeners();
  }

  // Funktion zum Abmelden eines Benutzers
  void logout() {
    _user = null;
    notifyListeners();
  }
}
