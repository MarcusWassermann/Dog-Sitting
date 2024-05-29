import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/models/user_profile.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserProfile>> getProfiles() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('profiles').get();

      List<UserProfile> profiles = querySnapshot.docs.map((doc) {
        return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return profiles;
    } catch (e) {
      // Fehlerbehandlung hier
      return [];
    }
  }
}
