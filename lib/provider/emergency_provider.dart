import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EmergencyContactProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  Future<void> fetchEmergencyContact(String currentUserDocumentId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('profiles')
          .where('emergencyContact', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        _phoneNumber = data['phoneNumber'] ?? '';
      } else {
        _phoneNumber = '';
      }

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching emergency contact: $error');
      }
      _phoneNumber = '';
      notifyListeners();
    }
  }
}
