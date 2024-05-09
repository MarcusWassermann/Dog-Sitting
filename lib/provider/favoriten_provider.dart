import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<UserText> _favorites = [];

  List<UserText> get favorites => _favorites;

  UserText? get container => _favorites.isNotEmpty ? _favorites.first : null;

  bool isFavorite(UserText userText) {
    return _favorites.contains(userText);
  }

  void addToFavorites(UserText userText) {
    if (!_favorites.contains(userText)) {
      _favorites.add(userText);
      notifyListeners();
    }
  }

  void removeFromFavorites(UserText userText) {
    if (_favorites.contains(userText)) {
      _favorites.remove(userText);
      notifyListeners();
    }
  }
}
