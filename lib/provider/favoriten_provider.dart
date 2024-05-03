import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void addToFavorites(String item) {
    _favorites.add(item);
    notifyListeners();
  }

  void removeFromFavorites(String item) {
    _favorites.remove(item);
    notifyListeners();
  }
}
