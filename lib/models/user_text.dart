class UserText {
  final String text;
  final String id;
  final String postcode;
  final String? imagePath;
  bool isApproved;

  UserText(this.text,
      {required this.id,
      required this.postcode,
      this.imagePath,
      this.isApproved = false});

  // Methode, die das Objekt in ein JSON-freundliches Format konvertiert
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'id': id,
      'postcode': postcode,
      'imagePath': imagePath,
      'isApproved': isApproved,
    };
  }

  // Konvertiert ein JSON-Objekt in ein UserText-Objekt
  factory UserText.fromJson(Map<String, dynamic> json) {
    return UserText(
      json['enteredText'] ?? '', // Verwende 'enteredText' anstelle von 'text'
      id: json['userId'] ?? '', // Verwende 'userId' anstelle von 'id'
      postcode: json['postcode'] ?? '',
      imagePath: json['imageUrl'],
      isApproved: json['isApproved'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserText{text: $text, id: $id, postcode: $postcode, imagePath: $imagePath, isApproved: $isApproved}';
  }
}
