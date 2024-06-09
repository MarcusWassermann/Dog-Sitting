import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'dart:convert';

class ProfileFavoriteProvider extends ChangeNotifier {
  final List<UserProfile> _favorites = [];
  late SharedPreferences _prefs;

  ProfileFavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFavorites() async {
    await _initPrefs();
    final favoritesData = _prefs.getString('profileFavorites');
    if (favoritesData != null) {
      final List<dynamic> decodedData = jsonDecode(favoritesData);
      _favorites.addAll(decodedData.map((e) => UserProfile.fromJson(e)));
      notifyListeners();
    }
  }

  List<UserProfile> get favorites => List.from(_favorites);

  bool isFavorite(UserProfile profile) {
    return _favorites.contains(profile);
  }

  Future<void> addToFavorites(UserProfile profile) async {
    await _initPrefs();
    if (!_favorites.contains(profile)) {
      _favorites.add(profile);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(UserProfile profile) async {
    await _initPrefs();
    if (_favorites.contains(profile)) {
      _favorites.remove(profile);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    await _initPrefs();
    final encodedData =
        jsonEncode(_favorites.map((profile) => profile.toJson()).toList());
    await _prefs.setString('profileFavorites', encodedData);
  }
}
