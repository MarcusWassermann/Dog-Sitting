import 'package:flutter/material.dart';
import 'package:flutter_dog/models/user_text.dart';

class UserTextProvider extends ChangeNotifier {
  final List<UserText> _userTexts = [];

  List<UserText> get userTexts => _userTexts;

  // Methode zum Hinzufügen eines neuen Benutzertextes
  void addUserText(UserText userText) {
    _userTexts.add(userText);
    notifyListeners();
  }

  // Methode zum Freischalten eines Benutzertextes
  void approveUserText(int index) {
    _userTexts[index].isApproved = true;
    notifyListeners();
  }

  // Methode zum Löschen aller Benutzertexte
  void deleteAllUserTexts() {
    _userTexts.clear();
    notifyListeners();
  }
}
