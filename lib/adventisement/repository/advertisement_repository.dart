import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/models/user_text.dart';

class AdvertisementRepository with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Methode zum Hinzufügen einer Anzeige zum Repository
  Future<void> addAdvertisement(UserText userText) async {
    try {
      await _firestore.collection('advertisements').add(userText.toJson());
      notifyListeners(); // Benachrichtige Zuhörer über Änderungen im Repository
    } catch (e) {
      // Fehlerbehandlung
      if (kDebugMode) {
        print('Fehler beim Hinzufügen der Anzeige: $e');
      }
      rethrow;
    }
  }
}
