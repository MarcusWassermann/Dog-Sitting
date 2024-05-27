import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoggedIn = false;

  // Methode zum Anmelden
  void signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zum Abmelden
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

  // Funktion zum Löschen des Profils
  Future<void> deleteProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        isLoggedIn = false;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Funktion zum Löschen der Anzeige
  Future<void> deleteAd() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Angenommen, Anzeigen sind in einer Collection "ads" gespeichert
        QuerySnapshot adSnapshot = await _firestore
            .collection('ads')
            .where('userId', isEqualTo: user.uid)
            .get();

        for (var doc in adSnapshot.docs) {
          await doc.reference.delete();
        }

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Funktion zum Entfernen als Notfallkontakt
  Future<void> removeAsEmergencyContact() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Angenommen, Notfallkontakte sind in einer Collection "emergencyContacts" gespeichert
        QuerySnapshot emergencyContactSnapshot = await _firestore
            .collection('emergencyContacts')
            .where('contactId', isEqualTo: user.uid)
            .get();

        for (var doc in emergencyContactSnapshot.docs) {
          await doc.reference.delete();
        }

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
