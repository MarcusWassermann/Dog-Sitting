import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserProfile>> getProfiles() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('profiles').get();

      if (kDebugMode) {
        print('getProfiles() Query executed');
      }

      List<UserProfile> profiles = querySnapshot.docs.map((doc) {
        return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (kDebugMode) {
        print('getProfiles() Profiles loaded: $profiles');
      }

      return profiles;
    } catch (e) {
      if (kDebugMode) {
        print('getProfiles() Error: $e');
      }
      return [];
    }
  }

  Future<List<UserProfile>> searchProfilesByZipCode(String zipCode) async {
    try {
      debugPrint(
          'searchProfilesByZipCode() erhalten mit zipCode: $zipCode'); // Hinzugefügt für Debugging

      String searchQuery = zipCode.substring(
          0, 2); // Die ersten beiden Zeichen des zipCode erhalten

      QuerySnapshot querySnapshot = await _firestore
          .collection('profiles')
          .where('zipCode',
              isGreaterThanOrEqualTo:
                  searchQuery) // Zipcodes beginnen mit den ersten beiden Zeichen
          .where('zipCode',
              isLessThan:
                  '${searchQuery}z') // Zipcodes enden vor dem nächsten Präfix
          .get();

      if (kDebugMode) {
        print(
            'searchProfilesByZipCode() Query executed with zipCode: $zipCode');
      }

      List<UserProfile> profiles = querySnapshot.docs.map((doc) {
        return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (kDebugMode) {
        print('searchProfilesByZipCode() Profiles loaded: $profiles');
      }

      return profiles;
    } catch (e) {
      if (kDebugMode) {
        print('searchProfilesByZipCode() Error: $e');
      }
      return [];
    }
  }
}
