import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EmergencyContactProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchEmergencyContact(
      String currentUserDocumentId, String userZipCode) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('profiles')
          .where('emergencyContact', isEqualTo: true)
          .get();

      final List<String> phoneNumbers = [];

      for (final doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data();
        final phoneNumber = data['phoneNumber'] as String?;
        final postcode = data['zipCode'] as String?;
        final postcodePrefix = userZipCode.substring(
            0, 2); // Extrahiere die ersten beiden Ziffern der Benutzer-PLZ

        if (phoneNumber != null &&
            postcode != null &&
            postcode.startsWith(postcodePrefix)) {
          phoneNumbers.add(phoneNumber);
        }
      }

      return phoneNumbers;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching emergency contacts: $error');
      }
      return []; // Return an empty list in case of error
    }
  }
}
