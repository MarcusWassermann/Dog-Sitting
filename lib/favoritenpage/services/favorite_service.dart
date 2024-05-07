import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> addToFavorites(String favorite) async {
    await favoritesCollection.add({'favorite': favorite});
  }

  Future<void> removeFromFavorites(String favoriteId) async {
    await favoritesCollection.doc(favoriteId).delete();
  }

  Stream<List<String>> getFavorites() {
    return favoritesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc['favorite'] as String).toList());
  }
}
