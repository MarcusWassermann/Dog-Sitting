import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:dogs_sitting/models/user_text.dart';

class FavoriteProvider extends ChangeNotifier {
  List<dynamic> _favorites = [];

  List<dynamic> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isFavorite(dynamic item) {
    return _favorites.contains(item);
  }

  void addToFavorites(dynamic item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(dynamic item) {
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
      _favorites = (json.decode(favoritesString) as List).map((item) {
        if (item['type'] == 'user_profile') {
          return UserProfile.fromJson(item);
        } else if (item['type'] == 'user_text') {
          return UserText.fromJson(item);
        } else {
          return null;
        }
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = _favorites.map((item) {
      if (item is UserProfile) {
        return {'type': 'user_profile', ...item.toJson()};
      } else if (item is UserText) {
        return {'type': 'user_text', ...item.toJson()};
      } else {
        return null;
      }
    }).toList();
    prefs.setString('favorites', json.encode(favoriteList));
  }
}
