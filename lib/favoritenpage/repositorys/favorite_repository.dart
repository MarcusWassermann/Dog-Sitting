import 'package:dogs_sitting/favoritenpage/services/favorite_service.dart';


class FavoriteRepository {
  final FavoriteService _favoriteService = FavoriteService();

  Future<void> addFavorite(String favorite) async {
    await _favoriteService.addToFavorites(favorite);
  }

  Future<void> removeFavorite(String favoriteId) async {
    await _favoriteService.removeFromFavorites(favoriteId);
  }

  Stream<List<String>> getFavorites() {
    return _favoriteService.getFavorites();
  }
}
