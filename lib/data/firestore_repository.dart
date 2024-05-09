import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, int age) async {
    await _firestore.collection('users').add({'name': name, 'age': age});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('users').snapshots();
  }

  // Weitere Methoden für Datenverwaltung ...
}
