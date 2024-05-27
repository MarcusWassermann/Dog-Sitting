import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/foundation.dart';

class CustomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserText>> getAdvertisements() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('advertisements').get();

      if (kDebugMode) {
        print(
            'QuerySnapshot erhalten: ${querySnapshot.docs.length} Dokumente gefunden.');
      }

      List<UserText> advertisements = querySnapshot.docs.map((doc) {
        if (kDebugMode) {
          print('Dokumentdaten: ${doc.data()}');
        }
        return UserText.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (kDebugMode) {
        print('Anzeigen erhalten: $advertisements');
      }

      return advertisements;
    } catch (e) {
      if (kDebugMode) {
        print('Fehler beim Abrufen der Anzeigen: $e');
      }
      return [];
    }
  }
}
