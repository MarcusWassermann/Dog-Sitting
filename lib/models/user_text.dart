// user_text.dart

class UserText {
  String text;
  String? imagePath; // Pfad zum Bild
  bool isApproved;

  UserText(this.text, {this.imagePath, this.isApproved = false});

  String? get id => null;
}
