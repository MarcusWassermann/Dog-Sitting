import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dogs_sitting/models/user_text.dart';

class FavoriteProvider extends ChangeNotifier {
  List<UserText> _favorites = [];

  List<UserText> get favorites => _favorites;

  UserText? get container => _favorites.isNotEmpty ? _favorites.first : null;

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isFavorite(UserText userText) {
    return _favorites.contains(userText);
  }

  void addToFavorites(UserText userText) {
    if (!_favorites.contains(userText)) {
      _favorites.add(userText);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(UserText userText) {
    if (_favorites.contains(userText)) {
      _favorites.remove(userText);
      _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString('favorites');

    if (favoritesString != null) {
      final List<dynamic> favoriteList = json.decode(favoritesString);
      _favorites = favoriteList.map((item) => UserText.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = _favorites.map((item) => item.toJson()).toList();
    prefs.setString('favorites', json.encode(favoriteList));
  }
}
