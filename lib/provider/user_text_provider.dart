import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_text.dart';

class UserTextProvider extends ChangeNotifier {
  final List<UserText> _userTexts = [];

  List<UserText> get userTexts => _userTexts;

  void addUserText(UserText userText) {
    _userTexts.add(userText);
    notifyListeners();
  }

  void deleteAllUserTexts() {
    _userTexts.clear();
    notifyListeners();
  }

  UserText getUserText(String id) {
    return _userTexts.firstWhere((userText) => userText.id == id);
  }

  void saveUserTextsLocally(List<UserText> userTexts) {
    _userTexts.clear();
    _userTexts.addAll(userTexts);
    notifyListeners();
  }
}
