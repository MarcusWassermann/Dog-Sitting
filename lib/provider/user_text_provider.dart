import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/material.dart';


class UserTextProvider extends ChangeNotifier {
  final List<UserText> _userTexts = [];
  String _enteredPostcode =
      ''; // Hier wird die eingegebene Postleitzahl gespeichert

  List<UserText> get userTexts => _userTexts;

  String get enteredPostcode =>
      _enteredPostcode; // Getter für die eingegebene Postleitzahl

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

  // Methode zum Festlegen der eingegebenen Postleitzahl
  void setEnteredPostcode(String postcode) {
    _enteredPostcode = postcode;
    notifyListeners();
  }

  // Methode zur Überprüfung der eingegebenen Postleitzahl
  bool checkPostcode() {
    // Füge deine Logik zur Überprüfung der Postleitzahl hier ein
    // Rückgabe true, wenn die Postleitzahl gültig ist, sonst false
    return true; // Hier musst du die tatsächliche Überprüfung implementieren
  }
}
