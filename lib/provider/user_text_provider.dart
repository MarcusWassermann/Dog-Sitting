import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/material.dart';

class UserTextProvider extends ChangeNotifier {
  final List<UserText> _userTexts = [];
  String _enteredPostcode = '';

  List<UserText> get userTexts => _userTexts;

  String get enteredPostcode => _enteredPostcode;

  void addUserText(UserText userText) {
    _userTexts.add(userText);
    notifyListeners();
  }

  void approveUserText(int index) {
    _userTexts[index].isApproved = true;
    notifyListeners();
  }

  void deleteAllUserTexts() {
    _userTexts.clear();
    notifyListeners();
  }

  void setEnteredPostcode(String postcode) {
    _enteredPostcode = postcode;
    notifyListeners();
  }

  bool checkPostcode() {
    // Implementiere deine Logik zur Überprüfung der Postleitzahl hier
    // Rückgabe true, wenn die Postleitzahl gültig ist, sonst false
    return true; // Hier musst du die tatsächliche Überprüfung implementieren
  }

  getUserText(String id) {}
}
