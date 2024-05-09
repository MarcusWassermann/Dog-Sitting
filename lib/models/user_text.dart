class UserText {
  final String _text; // Umbenannter Parameter
  String? imagePath; // Pfad zum Bild
  bool isApproved;
  String id; // ID des Benutzertextes

  UserText(this._text,
      {this.imagePath, this.isApproved = false, required this.id});

  String get text => _text;

  get container => null; // Getter für den Container
}
