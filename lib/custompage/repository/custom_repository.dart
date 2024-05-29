import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogs_sitting/models/user_text.dart';


class CustomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserText>> getAdvertisements() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('advertisements').get();

      List<UserText> advertisements = querySnapshot.docs.map((doc) {
        return UserText.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return advertisements;
    } catch (e) {
      return [];
    }
  }
}
