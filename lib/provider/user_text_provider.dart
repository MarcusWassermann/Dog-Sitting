import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserTextProvider extends ChangeNotifier {
  final List<UserText> _userTexts = [];
  late SharedPreferences _prefs;

  UserTextProvider() {
    _initPrefs();
    _loadUserTextsFromPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadUserTextsFromPrefs() async {
    final userTextsData = _prefs.getString('userTexts');
    if (userTextsData != null) {
      final List<dynamic> decodedData = jsonDecode(userTextsData);
      _userTexts.addAll(decodedData.map((e) => UserText.fromJson(e)));
      notifyListeners();
    }
  }

  List<UserText> get userTexts => List.from(_userTexts);

  Future<void> addUserText(UserText userText) async {
    _userTexts.add(userText);
    await _saveUserTextsToPrefs();
    notifyListeners();
  }

  Future<void> deleteAllUserTexts() async {
    _userTexts.clear();
    await _saveUserTextsToPrefs();
    notifyListeners();
  }

  UserText getUserText(String id) {
    return _userTexts.firstWhere((userText) => userText.id == id);
  }

  Future<void> saveUserTextsLocally(List<UserText> userTexts) async {
    _userTexts.clear();
    _userTexts.addAll(userTexts);
    await _saveUserTextsToPrefs();
    notifyListeners();
  }

  Future<void> _saveUserTextsToPrefs() async {
    final encodedData =
        jsonEncode(_userTexts.map((userText) => userText.toJson()).toList());
    await _prefs.setString('userTexts', encodedData);
  }
}
