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
    final favoritesData = _prefs.getString('favorites');
    if (kDebugMode) {
      print('Favorites Data: $favoritesData');
    } // Debugging-Ausgabe hinzugefügt
    if (favoritesData != null) {
      final List<dynamic> decodedData = jsonDecode(favoritesData);
      _favorites.addAll(decodedData.map((e) => UserProfile.fromJson(e)));
      if (kDebugMode) {
        print('Loaded favorites: $_favorites');
      } // Debugging-Ausgabe hinzugefügt
      notifyListeners();
    }
  }

  List<UserProfile> get favorites => _favorites;

  bool isFavorite(UserProfile profile) {
    return _favorites.contains(profile);
  }

  Future<void> addToFavorites(UserProfile profile) async {
    await _initPrefs();
    _favorites.add(profile);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> removeFromFavorites(UserProfile profile) async {
    await _initPrefs();
    _favorites.remove(profile);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final encodedData = jsonEncode(_favorites);
    await _prefs.setString('favorites', encodedData);
  }
}
