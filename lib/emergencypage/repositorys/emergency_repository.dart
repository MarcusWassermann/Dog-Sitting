import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyContactRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getEmergencyContactPhoneNumbers(
      String postalCodePrefix) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('profiles')
          .where('postalCode', isGreaterThanOrEqualTo: postalCodePrefix)
          .where('postalCode', isLessThan: '$postalCodePrefix\uf8ff')
          .get();

      final List<String> phoneNumbers = [];

      for (var snapshot in querySnapshot.docs) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        final phoneNumber = data?['phoneNumber'] as String?;
        if (phoneNumber != null) {
          phoneNumbers.add(phoneNumber);
        }
      }

      return phoneNumbers;
    } catch (error) {
      return []; // Rückgabe einer leeren Liste im Fehlerfall
    }
  }
}
