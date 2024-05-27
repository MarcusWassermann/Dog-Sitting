// lib/utils/shared_preferences_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLastScreen(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastScreen', value);
  }

  static Future<String> getLastScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastScreen') ?? '/home';
  }
}
