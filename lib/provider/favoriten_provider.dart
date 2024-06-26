import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dogs_sitting/models/user_text.dart';

class FavoriteProvider extends ChangeNotifier {
  List<UserText> _favorites = [];

  List<UserText> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isFavorite(UserText item) {
    return _favorites.contains(item);
  }

  void addToFavorites(UserText item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(UserText item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
      _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString('favorites');

    if (favoritesString != null) {
      _favorites = (json.decode(favoritesString) as List)
          .map((item) => UserText.fromJson(item))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = _favorites.map((item) => item.toJson()).toList();
    prefs.setString('favorites', json.encode(favoriteList));
  }
}
