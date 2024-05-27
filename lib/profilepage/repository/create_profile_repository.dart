import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CreateProfileRepository {
  Future<void> saveProfileToFirestore(Map<String, dynamic> profileData) async {
    try {
      // Dokumentreferenz für das Benutzerprofil in der Firestore-Sammlung "profiles" erhalten
      DocumentReference profileRef =
          FirebaseFirestore.instance.collection('profiles').doc();

      // Profildaten in Firestore speichern
      await profileRef.set(profileData);

      if (kDebugMode) {
        print('Benutzerprofil erfolgreich in Firestore gespeichert');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Fehler beim Speichern des Benutzerprofils: $error');
      }
      rethrow;
    }
  }
}
