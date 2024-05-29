import 'package:cloud_firestore/cloud_firestore.dart';


class EmergencyContactRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getEmergencyContactPhoneNumber(String documentId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('profiles').doc(documentId).get();

      if (snapshot.exists) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        final phoneNumber = data?['phoneNumber'] as String?;
        return phoneNumber ??
            ''; // Wenn phoneNumber nicht vorhanden ist, gib einen leeren String zurück
      } else {
        return ''; // Wenn das Dokument nicht existiert, gib einen leeren String zurück
      }
    } catch (error) {
      return ''; // Im Fehlerfall gib ebenfalls einen leeren String zurück
    }
  }
}
