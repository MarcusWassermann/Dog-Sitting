// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoggedIn = false;

  // Methode zur Anmeldung mit Benutzername und Passwort
  void signInWithUsernameAndPassword(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      isLoggedIn = true;
      await keepLoggedIn(); // Hier wird die Funktion keepLoggedIn aufgerufen
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zur Anmeldung mit E-Mail und Passwort
  void signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true;
      await keepLoggedIn(); // Hier wird die Funktion keepLoggedIn aufgerufen
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zur Abmeldung
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

  // Methode zur Überprüfung des Anmeldezustands
  Future<void> checkLoginState() async {
    final user = _auth.currentUser;
    isLoggedIn = user != null;
    notifyListeners();
  }

  // Methode zum Löschen des Benutzerprofils
  Future<void> deleteProfile() async {
    try {
      await _auth.currentUser?.delete();
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zum Löschen einer Anzeige
  Future<void> deleteAd(String adId) async {
    try {
      await _firestore.collection('ads').doc(adId).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zum Entfernen als Notfallkontakt
  Future<void> removeAsEmergencyContact(String userId) async {
    try {
      await _firestore.collection('emergency_contacts').doc(userId).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zur Anmeldung
  void signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true;
      await keepLoggedIn(); // Hier wird die Funktion keepLoggedIn aufgerufen
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zur Markierung des Benutzers als eingeloggt
  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  // Methode zum Überprüfen, ob der Benutzer eingeloggt bleibt
  Future<void> keepLoggedIn() async {
    try {
      await _auth.setPersistence(Persistence.LOCAL);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
