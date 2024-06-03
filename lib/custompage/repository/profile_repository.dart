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

  Future<List<UserProfile>> searchProfiles(String query) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('profiles')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      if (kDebugMode) {
        print('searchProfiles() Query executed with query: $query');
      }

      List<UserProfile> profiles = querySnapshot.docs.map((doc) {
        return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (kDebugMode) {
        print('searchProfiles() Profiles loaded: $profiles');
      }

      return profiles;
    } catch (e) {
      if (kDebugMode) {
        print('searchProfiles() Error: $e');
      }
      return [];
    }
  }
}
