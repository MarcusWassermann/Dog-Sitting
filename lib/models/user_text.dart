class UserText {
  final String text;
  final String id;
  final String postcode;
  final String? imagePath;
  final bool isApproved;
  final bool isAdvertisement;
  final String enteredText;

  UserText(
    this.text, {
    required this.id,
    required this.postcode,
    this.imagePath,
    this.isApproved = false,
    this.isAdvertisement = false,
    required this.enteredText,
  });

  // name Getter
  String get name => text;

  // description Getter
  String get description => postcode;

  // Methode, die das Objekt in ein JSON-freundliches Format konvertiert
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'id': id,
      'postcode': postcode,
      'imagePath': imagePath,
      'isApproved': isApproved,
      'isAdvertisement': isAdvertisement,
      'enteredText': enteredText,
    };
  }

  // Konvertiert ein JSON-Objekt in ein UserText-Objekt
  factory UserText.fromJson(Map<String, dynamic> json) {
    return UserText(
      json['text'] ?? '',
      id: json['id'] ?? '',
      postcode: json['postcode'] ?? '',
      imagePath: json['imagePath'],
      isApproved: json['isApproved'] ?? false,
      isAdvertisement: json['isAdvertisement'] ?? false,
      enteredText: json['enteredText'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserText{text: $text, id: $id, postcode: $postcode, imagePath: $imagePath, isApproved: $isApproved, isAdvertisement: $isAdvertisement, enteredText: $enteredText}';
  }
}
