import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoggedIn = false;

  AuthProvider() {
    checkLoginState(); // Überprüfung des Anmeldezustands beim Initialisieren
  }

  // Methode zur Anmeldung mit Benutzername und Passwort
  Future<void> signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      // Hier wird der Benutzername in eine E-Mail-Adresse übersetzt
      final userQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      if (userQuery.docs.isNotEmpty) {
        final email = userQuery.docs.first['email'];
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        isLoggedIn = true;
        await keepLoggedIn(); // Hier wird die Funktion keepLoggedIn aufgerufen
        notifyListeners();
      } else {
        throw Exception('Benutzername nicht gefunden');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }

  // Methode zur Anmeldung mit E-Mail und Passwort
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true;
      await keepLoggedIn(); // Hier wird die Funktion keepLoggedIn aufgerufen
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }

  // Methode zur Abmeldung
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
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
        print('Delete profile error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }

  // Methode zum Löschen einer Anzeige
  Future<void> deleteAd(String adId) async {
    try {
      await _firestore.collection('ads').doc(adId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Delete ad error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }

  // Methode zum Entfernen als Notfallkontakt
  Future<void> removeAsEmergencyContact(String userId) async {
    try {
      await _firestore.collection('emergency_contacts').doc(userId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Remove emergency contact error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }

  // Methode zum Überprüfen, ob der Benutzer eingeloggt bleibt
  Future<void> keepLoggedIn() async {
    try {
      await _auth.setPersistence(Persistence.LOCAL);
    } catch (e) {
      if (kDebugMode) {
        print('Keep logged in error: $e');
      }
      // Fehlerbehandlung, um dem Benutzer Feedback zu geben
    }
  }
}
