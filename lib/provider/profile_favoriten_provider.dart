import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dogs_sitting/models/user_profile.dart';

class ProfileFavoriteProvider extends ChangeNotifier {
  List<UserProfile> _favorites = [];

  List<UserProfile> get favorites => _favorites;

  ProfileFavoriteProvider() {
    _loadFavorites();
  }

  bool isFavorite(UserProfile item) {
    return _favorites.contains(item);
  }

  void addToFavorites(UserProfile item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(UserProfile item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
      _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString('profile_favorites');

    if (favoritesString != null) {
      _favorites = (json.decode(favoritesString) as List)
          .map((item) => UserProfile.fromJson(item))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = _favorites.map((item) => item.toJson()).toList();
    prefs.setString('profile_favorites', json.encode(favoriteList));
  }
}
