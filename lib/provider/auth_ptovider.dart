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

  // Funktion zum Löschen des Profils
  void deleteProfile() {
    // Implementiere hier die Logik zum Löschen des Profils
    notifyListeners();
  }

  // Funktion zum Löschen der Anzeige
  void deleteAd() {
    // Implementiere hier die Logik zum Löschen der Anzeige
    notifyListeners();
  }

  // Funktion zum Entfernen als Notfallkontakt
  void removeAsEmergencyContact() {
    // Implementiere hier die Logik zum Entfernen als Notfallkontakt
    notifyListeners();
  }
}
